Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1DEF169CB6
	for <lists+linux-crypto@lfdr.de>; Mon, 24 Feb 2020 04:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgBXDnW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 23 Feb 2020 22:43:22 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:37203 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbgBXDnW (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 23 Feb 2020 22:43:22 -0500
Received: from chumthang.blr.asicdesigners.com (chumthang.blr.asicdesigners.com [10.193.186.96])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 01O3gx6a015521;
        Sun, 23 Feb 2020 19:43:15 -0800
From:   Ayush Sawal <ayush.sawal@chelsio.com>
To:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org
Cc:     vinay.yadav@chelsio.com, manojmalviya@chelsio.com,
        Ayush Sawal <ayush.sawal@chelsio.com>
Subject: [PATCH Crypto 2/2] chcr: Use multiple txq/rxq per tfm to process the requests
Date:   Mon, 24 Feb 2020 09:12:33 +0530
Message-Id: <20200224034233.12476-3-ayush.sawal@chelsio.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca87
In-Reply-To: <20200224034233.12476-1-ayush.sawal@chelsio.com>
References: <20200224034233.12476-1-ayush.sawal@chelsio.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch enables chcr to use multiple txq/rxq per tfm
to process the crypto requests. The txq/rxq are selected based
on  cpu core-id.

Signed-off-by: Ayush Sawal <ayush.sawal@chelsio.com>
---
 drivers/crypto/chelsio/chcr_algo.c   | 325 +++++++++++++++++----------
 drivers/crypto/chelsio/chcr_core.h   |   1 -
 drivers/crypto/chelsio/chcr_crypto.h |  14 +-
 3 files changed, 216 insertions(+), 124 deletions(-)

diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
index 17ce6970dab4..8952732c0b7d 100644
--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -715,6 +715,52 @@ static int chcr_cipher_fallback(struct crypto_sync_skcipher *cipher,
 	return err;
 
 }
+
+static inline int get_qidxs(struct crypto_async_request *req,
+			    unsigned int *txqidx, unsigned int *rxqidx)
+{
+	struct crypto_tfm *tfm = req->tfm;
+	int ret = 0;
+
+	switch (tfm->__crt_alg->cra_flags & CRYPTO_ALG_TYPE_MASK) {
+	case CRYPTO_ALG_TYPE_AEAD:
+	{
+		struct aead_request *aead_req =
+			container_of(req, struct aead_request, base);
+		struct chcr_aead_reqctx *reqctx = aead_request_ctx(aead_req);
+		*txqidx = reqctx->txqidx;
+		*rxqidx = reqctx->rxqidx;
+		break;
+	}
+	case CRYPTO_ALG_TYPE_SKCIPHER:
+	{
+		struct skcipher_request *sk_req =
+			container_of(req, struct skcipher_request, base);
+		struct chcr_skcipher_req_ctx *reqctx =
+			skcipher_request_ctx(sk_req);
+		*txqidx = reqctx->txqidx;
+		*rxqidx = reqctx->rxqidx;
+		break;
+	}
+	case CRYPTO_ALG_TYPE_AHASH:
+	{
+		struct ahash_request *ahash_req =
+			container_of(req, struct ahash_request, base);
+		struct chcr_ahash_req_ctx *reqctx =
+			ahash_request_ctx(ahash_req);
+		*txqidx = reqctx->txqidx;
+		*rxqidx = reqctx->rxqidx;
+		break;
+	}
+	default:
+		ret = -EINVAL;
+		/* should never get here */
+		BUG();
+		break;
+	}
+	return ret;
+}
+
 static inline void create_wreq(struct chcr_context *ctx,
 			       struct chcr_wr *chcr_req,
 			       struct crypto_async_request *req,
@@ -725,7 +771,15 @@ static inline void create_wreq(struct chcr_context *ctx,
 			       unsigned int lcb)
 {
 	struct uld_ctx *u_ctx = ULD_CTX(ctx);
-	int qid = u_ctx->lldi.rxq_ids[ctx->rx_qidx];
+	unsigned int tx_channel_id, rx_channel_id;
+	unsigned int txqidx = 0, rxqidx = 0;
+	unsigned int qid, fid;
+
+	get_qidxs(req, &txqidx, &rxqidx);
+	qid = u_ctx->lldi.rxq_ids[rxqidx];
+	fid = u_ctx->lldi.rxq_ids[0];
+	tx_channel_id = txqidx / ctx->txq_perchan;
+	rx_channel_id = rxqidx / ctx->rxq_perchan;
 
 
 	chcr_req->wreq.op_to_cctx_size = FILL_WR_OP_CCTX_SIZE;
@@ -734,15 +788,12 @@ static inline void create_wreq(struct chcr_context *ctx,
 	chcr_req->wreq.len16_pkd =
 		htonl(FW_CRYPTO_LOOKASIDE_WR_LEN16_V(DIV_ROUND_UP(len16, 16)));
 	chcr_req->wreq.cookie = cpu_to_be64((uintptr_t)req);
-	chcr_req->wreq.rx_chid_to_rx_q_id =
-		FILL_WR_RX_Q_ID(ctx->tx_chan_id, qid,
-				!!lcb, ctx->tx_qidx);
+	chcr_req->wreq.rx_chid_to_rx_q_id = FILL_WR_RX_Q_ID(rx_channel_id, qid,
+							    !!lcb, txqidx);
 
-	chcr_req->ulptx.cmd_dest = FILL_ULPTX_CMD_DEST(ctx->tx_chan_id,
-						       qid);
+	chcr_req->ulptx.cmd_dest = FILL_ULPTX_CMD_DEST(tx_channel_id, fid);
 	chcr_req->ulptx.len = htonl((DIV_ROUND_UP(len16, 16) -
-				     ((sizeof(chcr_req->wreq)) >> 4)));
-
+				((sizeof(chcr_req->wreq)) >> 4)));
 	chcr_req->sc_imm.cmd_more = FILL_CMD_MORE(!imm);
 	chcr_req->sc_imm.len = cpu_to_be32(sizeof(struct cpl_tx_sec_pdu) +
 					   sizeof(chcr_req->key_ctx) + sc_len);
@@ -758,7 +809,8 @@ static inline void create_wreq(struct chcr_context *ctx,
 static struct sk_buff *create_cipher_wr(struct cipher_wr_param *wrparam)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(wrparam->req);
-	struct ablk_ctx *ablkctx = ABLK_CTX(c_ctx(tfm));
+	struct chcr_context *ctx = c_ctx(tfm);
+	struct ablk_ctx *ablkctx = ABLK_CTX(ctx);
 	struct sk_buff *skb = NULL;
 	struct chcr_wr *chcr_req;
 	struct cpl_rx_phys_dsgl *phys_cpl;
@@ -771,7 +823,8 @@ static struct sk_buff *create_cipher_wr(struct cipher_wr_param *wrparam)
 	unsigned int kctx_len;
 	gfp_t flags = wrparam->req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
 			GFP_KERNEL : GFP_ATOMIC;
-	struct adapter *adap = padap(c_ctx(tfm)->dev);
+	struct adapter *adap = padap(ctx->dev);
+	unsigned int rx_channel_id = reqctx->rxqidx / ctx->rxq_perchan;
 
 	nents = sg_nents_xlen(reqctx->dstsg,  wrparam->bytes, CHCR_DST_SG_SIZE,
 			      reqctx->dst_ofst);
@@ -791,7 +844,7 @@ static struct sk_buff *create_cipher_wr(struct cipher_wr_param *wrparam)
 	}
 	chcr_req = __skb_put_zero(skb, transhdr_len);
 	chcr_req->sec_cpl.op_ivinsrtofst =
-		FILL_SEC_CPL_OP_IVINSR(c_ctx(tfm)->tx_chan_id, 2, 1);
+			FILL_SEC_CPL_OP_IVINSR(rx_channel_id, 2, 1);
 
 	chcr_req->sec_cpl.pldlen = htonl(IV + wrparam->bytes);
 	chcr_req->sec_cpl.aadstart_cipherstop_hi =
@@ -1112,7 +1165,7 @@ static int chcr_handle_cipher_resp(struct skcipher_request *req,
 	struct sk_buff *skb;
 	struct cpl_fw6_pld *fw6_pld = (struct cpl_fw6_pld *)input;
 	struct chcr_skcipher_req_ctx *reqctx = skcipher_request_ctx(req);
-	struct  cipher_wr_param wrparam;
+	struct cipher_wr_param wrparam;
 	struct chcr_dev *dev = c_ctx(tfm)->dev;
 	int bytes;
 
@@ -1157,7 +1210,7 @@ static int chcr_handle_cipher_resp(struct skcipher_request *req,
 	if (get_cryptoalg_subtype(tfm) ==
 	    CRYPTO_ALG_SUB_TYPE_CTR)
 		bytes = adjust_ctr_overflow(reqctx->iv, bytes);
-	wrparam.qid = u_ctx->lldi.rxq_ids[c_ctx(tfm)->rx_qidx];
+	wrparam.qid = u_ctx->lldi.rxq_ids[reqctx->rxqidx];
 	wrparam.req = req;
 	wrparam.bytes = bytes;
 	skb = create_cipher_wr(&wrparam);
@@ -1167,7 +1220,7 @@ static int chcr_handle_cipher_resp(struct skcipher_request *req,
 		goto unmap;
 	}
 	skb->dev = u_ctx->lldi.ports[0];
-	set_wr_txq(skb, CPL_PRIORITY_DATA, c_ctx(tfm)->tx_qidx);
+	set_wr_txq(skb, CPL_PRIORITY_DATA, reqctx->txqidx);
 	chcr_send_wr(skb);
 	reqctx->last_req_len = bytes;
 	reqctx->processed += bytes;
@@ -1307,39 +1360,42 @@ static int chcr_aes_encrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct chcr_skcipher_req_ctx *reqctx = skcipher_request_ctx(req);
-	struct chcr_context *ctx;
 	struct chcr_dev *dev = c_ctx(tfm)->dev;
 	struct sk_buff *skb = NULL;
-	int err, isfull = 0;
+	int err;
 	struct uld_ctx *u_ctx = ULD_CTX(c_ctx(tfm));
+	struct chcr_context *ctx = c_ctx(tfm);
+	unsigned int cpu;
+
+	cpu = get_cpu();
+	reqctx->txqidx = cpu % ctx->ntxq;
+	reqctx->rxqidx = cpu % ctx->nrxq;
+	put_cpu();
 
 	err = chcr_inc_wrcount(dev);
 	if (err)
 		return -ENXIO;
 	if (unlikely(cxgb4_is_crypto_q_full(u_ctx->lldi.ports[0],
-					    c_ctx(tfm)->tx_qidx))) {
-		isfull = 1;
-		if (!(req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG)) {
+						reqctx->txqidx) &&
+		(!(req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG)))) {
 			err = -ENOSPC;
 			goto error;
-		}
 	}
 
-	err = process_cipher(req, u_ctx->lldi.rxq_ids[c_ctx(tfm)->rx_qidx],
+	err = process_cipher(req, u_ctx->lldi.rxq_ids[reqctx->rxqidx],
 			     &skb, CHCR_ENCRYPT_OP);
 	if (err || !skb)
 		return  err;
 	skb->dev = u_ctx->lldi.ports[0];
-	set_wr_txq(skb, CPL_PRIORITY_DATA, c_ctx(tfm)->tx_qidx);
+	set_wr_txq(skb, CPL_PRIORITY_DATA, reqctx->txqidx);
 	chcr_send_wr(skb);
 	if (get_cryptoalg_subtype(tfm) ==
 		CRYPTO_ALG_SUB_TYPE_CBC && req->base.flags ==
 			CRYPTO_TFM_REQ_MAY_SLEEP ) {
-			ctx=c_ctx(tfm);
 			reqctx->partial_req = 1;
 			wait_for_completion(&ctx->cbc_aes_aio_done);
         }
-	return isfull ? -EBUSY : -EINPROGRESS;
+	return -EINPROGRESS;
 error:
 	chcr_dec_wrcount(dev);
 	return err;
@@ -1348,68 +1404,58 @@ static int chcr_aes_encrypt(struct skcipher_request *req)
 static int chcr_aes_decrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct chcr_skcipher_req_ctx *reqctx = skcipher_request_ctx(req);
 	struct uld_ctx *u_ctx = ULD_CTX(c_ctx(tfm));
 	struct chcr_dev *dev = c_ctx(tfm)->dev;
 	struct sk_buff *skb = NULL;
-	int err, isfull = 0;
+	int err;
+	struct chcr_context *ctx = c_ctx(tfm);
+	unsigned int cpu;
+
+	cpu = get_cpu();
+	reqctx->txqidx = cpu % ctx->ntxq;
+	reqctx->rxqidx = cpu % ctx->nrxq;
+	put_cpu();
 
 	err = chcr_inc_wrcount(dev);
 	if (err)
 		return -ENXIO;
 
 	if (unlikely(cxgb4_is_crypto_q_full(u_ctx->lldi.ports[0],
-					    c_ctx(tfm)->tx_qidx))) {
-		isfull = 1;
-		if (!(req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG))
+						reqctx->txqidx) &&
+		(!(req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG))))
 			return -ENOSPC;
-	}
-
-	err = process_cipher(req, u_ctx->lldi.rxq_ids[c_ctx(tfm)->rx_qidx],
+	err = process_cipher(req, u_ctx->lldi.rxq_ids[reqctx->rxqidx],
 			     &skb, CHCR_DECRYPT_OP);
 	if (err || !skb)
 		return err;
 	skb->dev = u_ctx->lldi.ports[0];
-	set_wr_txq(skb, CPL_PRIORITY_DATA, c_ctx(tfm)->tx_qidx);
+	set_wr_txq(skb, CPL_PRIORITY_DATA, reqctx->txqidx);
 	chcr_send_wr(skb);
-	return isfull ? -EBUSY : -EINPROGRESS;
+	return -EINPROGRESS;
 }
-
 static int chcr_device_init(struct chcr_context *ctx)
 {
 	struct uld_ctx *u_ctx = NULL;
-	unsigned int id;
-	int txq_perchan, txq_idx, ntxq;
-	int err = 0, rxq_perchan, rxq_idx;
+	struct adapter *adap;
+	int txq_perchan, ntxq;
+	int err = 0, rxq_perchan;
 
-	id = smp_processor_id();
 	if (!ctx->dev) {
 		u_ctx = assign_chcr_device();
 		if (!u_ctx) {
-			err = -ENXIO;
 			pr_err("chcr device assignment fails\n");
 			goto out;
 		}
 		ctx->dev = &u_ctx->dev;
+		adap = padap(ctx->dev);
 		ntxq = u_ctx->lldi.ntxq;
 		rxq_perchan = u_ctx->lldi.nrxq / u_ctx->lldi.nchan;
 		txq_perchan = ntxq / u_ctx->lldi.nchan;
-		spin_lock(&ctx->dev->lock_chcr_dev);
-		ctx->tx_chan_id = ctx->dev->tx_channel_id;
-		ctx->dev->tx_channel_id =
-			(ctx->dev->tx_channel_id + 1) %  u_ctx->lldi.nchan;
-		spin_unlock(&ctx->dev->lock_chcr_dev);
-		rxq_idx = ctx->tx_chan_id * rxq_perchan;
-		rxq_idx += id % rxq_perchan;
-		txq_idx = ctx->tx_chan_id * txq_perchan;
-		txq_idx += id % txq_perchan;
-		ctx->rx_qidx = rxq_idx;
-		ctx->tx_qidx = txq_idx;
-		/* Channel Id used by SGE to forward packet to Host.
-		 * Same value should be used in cpl_fw6_pld RSS_CH field
-		 * by FW. Driver programs PCI channel ID to be used in fw
-		 * at the time of queue allocation with value "pi->tx_chan"
-		 */
-		ctx->pci_chan_id = txq_idx / txq_perchan;
+		ctx->ntxq = ntxq;
+		ctx->nrxq = u_ctx->lldi.nrxq;
+		ctx->rxq_perchan = rxq_perchan;
+		ctx->txq_perchan = txq_perchan;
 	}
 out:
 	return err;
@@ -1511,9 +1557,10 @@ static struct sk_buff *create_hash_wr(struct ahash_request *req,
 {
 	struct chcr_ahash_req_ctx *req_ctx = ahash_request_ctx(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct hmac_ctx *hmacctx = HMAC_CTX(h_ctx(tfm));
+	struct chcr_context *ctx = h_ctx(tfm);
+	struct hmac_ctx *hmacctx = HMAC_CTX(ctx);
 	struct sk_buff *skb = NULL;
-	struct uld_ctx *u_ctx = ULD_CTX(h_ctx(tfm));
+	struct uld_ctx *u_ctx = ULD_CTX(ctx);
 	struct chcr_wr *chcr_req;
 	struct ulptx_sgl *ulptx;
 	unsigned int nents = 0, transhdr_len;
@@ -1522,6 +1569,7 @@ static struct sk_buff *create_hash_wr(struct ahash_request *req,
 		GFP_ATOMIC;
 	struct adapter *adap = padap(h_ctx(tfm)->dev);
 	int error = 0;
+	unsigned int rx_channel_id = req_ctx->rxqidx / ctx->rxq_perchan;
 
 	transhdr_len = HASH_TRANSHDR_SIZE(param->kctx_len);
 	req_ctx->hctx_wr.imm = (transhdr_len + param->bfr_len +
@@ -1539,7 +1587,8 @@ static struct sk_buff *create_hash_wr(struct ahash_request *req,
 	chcr_req = __skb_put_zero(skb, transhdr_len);
 
 	chcr_req->sec_cpl.op_ivinsrtofst =
-		FILL_SEC_CPL_OP_IVINSR(h_ctx(tfm)->tx_chan_id, 2, 0);
+		FILL_SEC_CPL_OP_IVINSR(rx_channel_id, 2, 0);
+
 	chcr_req->sec_cpl.pldlen = htonl(param->bfr_len + param->sg_len);
 
 	chcr_req->sec_cpl.aadstart_cipherstop_hi =
@@ -1602,16 +1651,22 @@ static int chcr_ahash_update(struct ahash_request *req)
 {
 	struct chcr_ahash_req_ctx *req_ctx = ahash_request_ctx(req);
 	struct crypto_ahash *rtfm = crypto_ahash_reqtfm(req);
-	struct uld_ctx *u_ctx = NULL;
+	struct uld_ctx *u_ctx = ULD_CTX(h_ctx(rtfm));
+	struct chcr_context *ctx = h_ctx(rtfm);
 	struct chcr_dev *dev = h_ctx(rtfm)->dev;
 	struct sk_buff *skb;
 	u8 remainder = 0, bs;
 	unsigned int nbytes = req->nbytes;
 	struct hash_wr_param params;
-	int error, isfull = 0;
+	int error;
+	unsigned int cpu;
+
+	cpu = get_cpu();
+	req_ctx->txqidx = cpu % ctx->ntxq;
+	req_ctx->rxqidx = cpu % ctx->nrxq;
+	put_cpu();
 
 	bs = crypto_tfm_alg_blocksize(crypto_ahash_tfm(rtfm));
-	u_ctx = ULD_CTX(h_ctx(rtfm));
 
 	if (nbytes + req_ctx->reqlen >= bs) {
 		remainder = (nbytes + req_ctx->reqlen) % bs;
@@ -1629,12 +1684,10 @@ static int chcr_ahash_update(struct ahash_request *req)
 	 * inflight count for dev guarantees that lldi and padap is valid
 	 */
 	if (unlikely(cxgb4_is_crypto_q_full(u_ctx->lldi.ports[0],
-					    h_ctx(rtfm)->tx_qidx))) {
-		isfull = 1;
-		if (!(req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG)) {
+						req_ctx->txqidx) &&
+		(!(req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG)))) {
 			error = -ENOSPC;
 			goto err;
-		}
 	}
 
 	chcr_init_hctx_per_wr(req_ctx);
@@ -1676,10 +1729,9 @@ static int chcr_ahash_update(struct ahash_request *req)
 	}
 	req_ctx->reqlen = remainder;
 	skb->dev = u_ctx->lldi.ports[0];
-	set_wr_txq(skb, CPL_PRIORITY_DATA, h_ctx(rtfm)->tx_qidx);
+	set_wr_txq(skb, CPL_PRIORITY_DATA, req_ctx->txqidx);
 	chcr_send_wr(skb);
-
-	return isfull ? -EBUSY : -EINPROGRESS;
+	return -EINPROGRESS;
 unmap:
 	chcr_hash_dma_unmap(&u_ctx->lldi.pdev->dev, req);
 err:
@@ -1704,16 +1756,22 @@ static int chcr_ahash_final(struct ahash_request *req)
 	struct chcr_dev *dev = h_ctx(rtfm)->dev;
 	struct hash_wr_param params;
 	struct sk_buff *skb;
-	struct uld_ctx *u_ctx = NULL;
+	struct uld_ctx *u_ctx = ULD_CTX(h_ctx(rtfm));
+	struct chcr_context *ctx = h_ctx(rtfm);
 	u8 bs = crypto_tfm_alg_blocksize(crypto_ahash_tfm(rtfm));
 	int error = -EINVAL;
+	unsigned int cpu;
+
+	cpu = get_cpu();
+	req_ctx->txqidx = cpu % ctx->ntxq;
+	req_ctx->rxqidx = cpu % ctx->nrxq;
+	put_cpu();
 
 	error = chcr_inc_wrcount(dev);
 	if (error)
 		return -ENXIO;
 
 	chcr_init_hctx_per_wr(req_ctx);
-	u_ctx = ULD_CTX(h_ctx(rtfm));
 	if (is_hmac(crypto_ahash_tfm(rtfm)))
 		params.opad_needed = 1;
 	else
@@ -1753,7 +1811,7 @@ static int chcr_ahash_final(struct ahash_request *req)
 	}
 	req_ctx->reqlen = 0;
 	skb->dev = u_ctx->lldi.ports[0];
-	set_wr_txq(skb, CPL_PRIORITY_DATA, h_ctx(rtfm)->tx_qidx);
+	set_wr_txq(skb, CPL_PRIORITY_DATA, req_ctx->txqidx);
 	chcr_send_wr(skb);
 	return -EINPROGRESS;
 err:
@@ -1766,25 +1824,29 @@ static int chcr_ahash_finup(struct ahash_request *req)
 	struct chcr_ahash_req_ctx *req_ctx = ahash_request_ctx(req);
 	struct crypto_ahash *rtfm = crypto_ahash_reqtfm(req);
 	struct chcr_dev *dev = h_ctx(rtfm)->dev;
-	struct uld_ctx *u_ctx = NULL;
+	struct uld_ctx *u_ctx = ULD_CTX(h_ctx(rtfm));
+	struct chcr_context *ctx = h_ctx(rtfm);
 	struct sk_buff *skb;
 	struct hash_wr_param params;
 	u8  bs;
-	int error, isfull = 0;
+	int error;
+	unsigned int cpu;
+
+	cpu = get_cpu();
+	req_ctx->txqidx = cpu % ctx->ntxq;
+	req_ctx->rxqidx = cpu % ctx->nrxq;
+	put_cpu();
 
 	bs = crypto_tfm_alg_blocksize(crypto_ahash_tfm(rtfm));
-	u_ctx = ULD_CTX(h_ctx(rtfm));
 	error = chcr_inc_wrcount(dev);
 	if (error)
 		return -ENXIO;
 
 	if (unlikely(cxgb4_is_crypto_q_full(u_ctx->lldi.ports[0],
-					    h_ctx(rtfm)->tx_qidx))) {
-		isfull = 1;
-		if (!(req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG)) {
+						req_ctx->txqidx) &&
+		(!(req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG)))) {
 			error = -ENOSPC;
 			goto err;
-		}
 	}
 	chcr_init_hctx_per_wr(req_ctx);
 	error = chcr_hash_dma_map(&u_ctx->lldi.pdev->dev, req);
@@ -1842,10 +1904,9 @@ static int chcr_ahash_finup(struct ahash_request *req)
 	req_ctx->reqlen = 0;
 	req_ctx->hctx_wr.processed += params.sg_len;
 	skb->dev = u_ctx->lldi.ports[0];
-	set_wr_txq(skb, CPL_PRIORITY_DATA, h_ctx(rtfm)->tx_qidx);
+	set_wr_txq(skb, CPL_PRIORITY_DATA, req_ctx->txqidx);
 	chcr_send_wr(skb);
-
-	return isfull ? -EBUSY : -EINPROGRESS;
+	return -EINPROGRESS;
 unmap:
 	chcr_hash_dma_unmap(&u_ctx->lldi.pdev->dev, req);
 err:
@@ -1858,11 +1919,18 @@ static int chcr_ahash_digest(struct ahash_request *req)
 	struct chcr_ahash_req_ctx *req_ctx = ahash_request_ctx(req);
 	struct crypto_ahash *rtfm = crypto_ahash_reqtfm(req);
 	struct chcr_dev *dev = h_ctx(rtfm)->dev;
-	struct uld_ctx *u_ctx = NULL;
+	struct uld_ctx *u_ctx = ULD_CTX(h_ctx(rtfm));
+	struct chcr_context *ctx = h_ctx(rtfm);
 	struct sk_buff *skb;
 	struct hash_wr_param params;
 	u8  bs;
-	int error, isfull = 0;
+	int error;
+	unsigned int cpu;
+
+	cpu = get_cpu();
+	req_ctx->txqidx = cpu % ctx->ntxq;
+	req_ctx->rxqidx = cpu % ctx->nrxq;
+	put_cpu();
 
 	rtfm->init(req);
 	bs = crypto_tfm_alg_blocksize(crypto_ahash_tfm(rtfm));
@@ -1870,14 +1938,11 @@ static int chcr_ahash_digest(struct ahash_request *req)
 	if (error)
 		return -ENXIO;
 
-	u_ctx = ULD_CTX(h_ctx(rtfm));
 	if (unlikely(cxgb4_is_crypto_q_full(u_ctx->lldi.ports[0],
-					    h_ctx(rtfm)->tx_qidx))) {
-		isfull = 1;
-		if (!(req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG)) {
+						req_ctx->txqidx) &&
+		(!(req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG)))) {
 			error = -ENOSPC;
 			goto err;
-		}
 	}
 
 	chcr_init_hctx_per_wr(req_ctx);
@@ -1933,9 +1998,9 @@ static int chcr_ahash_digest(struct ahash_request *req)
 	}
 	req_ctx->hctx_wr.processed += params.sg_len;
 	skb->dev = u_ctx->lldi.ports[0];
-	set_wr_txq(skb, CPL_PRIORITY_DATA, h_ctx(rtfm)->tx_qidx);
+	set_wr_txq(skb, CPL_PRIORITY_DATA, req_ctx->txqidx);
 	chcr_send_wr(skb);
-	return isfull ? -EBUSY : -EINPROGRESS;
+	return -EINPROGRESS;
 unmap:
 	chcr_hash_dma_unmap(&u_ctx->lldi.pdev->dev, req);
 err:
@@ -1948,14 +2013,20 @@ static int chcr_ahash_continue(struct ahash_request *req)
 	struct chcr_ahash_req_ctx *reqctx = ahash_request_ctx(req);
 	struct chcr_hctx_per_wr *hctx_wr = &reqctx->hctx_wr;
 	struct crypto_ahash *rtfm = crypto_ahash_reqtfm(req);
-	struct uld_ctx *u_ctx = NULL;
+	struct chcr_context *ctx = h_ctx(rtfm);
+	struct uld_ctx *u_ctx = ULD_CTX(ctx);
 	struct sk_buff *skb;
 	struct hash_wr_param params;
 	u8  bs;
 	int error;
+	unsigned int cpu;
+
+	cpu = get_cpu();
+	reqctx->txqidx = cpu % ctx->ntxq;
+	reqctx->rxqidx = cpu % ctx->nrxq;
+	put_cpu();
 
 	bs = crypto_tfm_alg_blocksize(crypto_ahash_tfm(rtfm));
-	u_ctx = ULD_CTX(h_ctx(rtfm));
 	get_alg_config(&params.alg_prm, crypto_ahash_digestsize(rtfm));
 	params.kctx_len = roundup(params.alg_prm.result_size, 16);
 	if (is_hmac(crypto_ahash_tfm(rtfm))) {
@@ -1995,7 +2066,7 @@ static int chcr_ahash_continue(struct ahash_request *req)
 	}
 	hctx_wr->processed += params.sg_len;
 	skb->dev = u_ctx->lldi.ports[0];
-	set_wr_txq(skb, CPL_PRIORITY_DATA, h_ctx(rtfm)->tx_qidx);
+	set_wr_txq(skb, CPL_PRIORITY_DATA, reqctx->txqidx);
 	chcr_send_wr(skb);
 	return 0;
 err:
@@ -2341,7 +2412,8 @@ static struct sk_buff *create_authenc_wr(struct aead_request *req,
 					 int size)
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	struct chcr_aead_ctx *aeadctx = AEAD_CTX(a_ctx(tfm));
+	struct chcr_context *ctx = a_ctx(tfm);
+	struct chcr_aead_ctx *aeadctx = AEAD_CTX(ctx);
 	struct chcr_authenc_ctx *actx = AUTHENC_CTX(aeadctx);
 	struct chcr_aead_reqctx *reqctx = aead_request_ctx(req);
 	struct sk_buff *skb = NULL;
@@ -2357,7 +2429,8 @@ static struct sk_buff *create_authenc_wr(struct aead_request *req,
 	int null = 0;
 	gfp_t flags = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ? GFP_KERNEL :
 		GFP_ATOMIC;
-	struct adapter *adap = padap(a_ctx(tfm)->dev);
+	struct adapter *adap = padap(ctx->dev);
+	unsigned int rx_channel_id = reqctx->rxqidx / ctx->rxq_perchan;
 
 	if (req->cryptlen == 0)
 		return NULL;
@@ -2409,7 +2482,7 @@ static struct sk_buff *create_authenc_wr(struct aead_request *req,
 	 * to the hardware spec
 	 */
 	chcr_req->sec_cpl.op_ivinsrtofst =
-		FILL_SEC_CPL_OP_IVINSR(a_ctx(tfm)->tx_chan_id, 2, 1);
+				FILL_SEC_CPL_OP_IVINSR(rx_channel_id, 2, 1);
 	chcr_req->sec_cpl.pldlen = htonl(req->assoclen + IV + req->cryptlen);
 	chcr_req->sec_cpl.aadstart_cipherstop_hi = FILL_SEC_CPL_CIPHERSTOP_HI(
 					null ? 0 : 1 + IV,
@@ -2585,13 +2658,14 @@ void chcr_add_aead_dst_ent(struct aead_request *req,
 	unsigned int authsize = crypto_aead_authsize(tfm);
 	struct chcr_context *ctx = a_ctx(tfm);
 	u32 temp;
+	unsigned int rx_channel_id = reqctx->rxqidx / ctx->rxq_perchan;
 
 	dsgl_walk_init(&dsgl_walk, phys_cpl);
 	dsgl_walk_add_page(&dsgl_walk, IV + reqctx->b0_len, reqctx->iv_dma);
 	temp = req->assoclen + req->cryptlen +
 		(reqctx->op ? -authsize : authsize);
 	dsgl_walk_add_sg(&dsgl_walk, req->dst, temp, 0);
-	dsgl_walk_end(&dsgl_walk, qid, ctx->pci_chan_id);
+	dsgl_walk_end(&dsgl_walk, qid, rx_channel_id);
 }
 
 void chcr_add_cipher_src_ent(struct skcipher_request *req,
@@ -2626,14 +2700,14 @@ void chcr_add_cipher_dst_ent(struct skcipher_request *req,
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(wrparam->req);
 	struct chcr_context *ctx = c_ctx(tfm);
 	struct dsgl_walk dsgl_walk;
+	unsigned int rx_channel_id = reqctx->rxqidx / ctx->rxq_perchan;
 
 	dsgl_walk_init(&dsgl_walk, phys_cpl);
 	dsgl_walk_add_sg(&dsgl_walk, reqctx->dstsg, wrparam->bytes,
 			 reqctx->dst_ofst);
 	reqctx->dstsg = dsgl_walk.last_sg;
 	reqctx->dst_ofst = dsgl_walk.last_sg_len;
-
-	dsgl_walk_end(&dsgl_walk, qid, ctx->pci_chan_id);
+	dsgl_walk_end(&dsgl_walk, qid, rx_channel_id);
 }
 
 void chcr_add_hash_src_ent(struct ahash_request *req,
@@ -2831,10 +2905,12 @@ static void fill_sec_cpl_for_aead(struct cpl_tx_sec_pdu *sec_cpl,
 				  unsigned short op_type)
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	struct chcr_aead_ctx *aeadctx = AEAD_CTX(a_ctx(tfm));
+	struct chcr_context *ctx = a_ctx(tfm);
+	struct chcr_aead_ctx *aeadctx = AEAD_CTX(ctx);
+	struct chcr_aead_reqctx *reqctx = aead_request_ctx(req);
 	unsigned int cipher_mode = CHCR_SCMD_CIPHER_MODE_AES_CCM;
 	unsigned int mac_mode = CHCR_SCMD_AUTH_MODE_CBCMAC;
-	unsigned int c_id = a_ctx(tfm)->tx_chan_id;
+	unsigned int rx_channel_id = reqctx->rxqidx / ctx->rxq_perchan;
 	unsigned int ccm_xtra;
 	unsigned char tag_offset = 0, auth_offset = 0;
 	unsigned int assoclen;
@@ -2855,9 +2931,7 @@ static void fill_sec_cpl_for_aead(struct cpl_tx_sec_pdu *sec_cpl,
 			auth_offset = 0;
 	}
 
-
-	sec_cpl->op_ivinsrtofst = FILL_SEC_CPL_OP_IVINSR(c_id,
-					 2, 1);
+	sec_cpl->op_ivinsrtofst = FILL_SEC_CPL_OP_IVINSR(rx_channel_id, 2, 1);
 	sec_cpl->pldlen =
 		htonl(req->assoclen + IV + req->cryptlen + ccm_xtra);
 	/* For CCM there wil be b0 always. So AAD start will be 1 always */
@@ -3000,7 +3074,8 @@ static struct sk_buff *create_gcm_wr(struct aead_request *req,
 				     int size)
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	struct chcr_aead_ctx *aeadctx = AEAD_CTX(a_ctx(tfm));
+	struct chcr_context *ctx = a_ctx(tfm);
+	struct chcr_aead_ctx *aeadctx = AEAD_CTX(ctx);
 	struct chcr_aead_reqctx  *reqctx = aead_request_ctx(req);
 	struct sk_buff *skb = NULL;
 	struct chcr_wr *chcr_req;
@@ -3013,7 +3088,8 @@ static struct sk_buff *create_gcm_wr(struct aead_request *req,
 	u8 *ivptr;
 	gfp_t flags = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ? GFP_KERNEL :
 		GFP_ATOMIC;
-	struct adapter *adap = padap(a_ctx(tfm)->dev);
+	struct adapter *adap = padap(ctx->dev);
+	unsigned int rx_channel_id = reqctx->rxqidx / ctx->rxq_perchan;
 
 	if (get_aead_subtype(tfm) == CRYPTO_ALG_SUB_TYPE_AEAD_RFC4106)
 		assoclen = req->assoclen - 8;
@@ -3055,7 +3131,7 @@ static struct sk_buff *create_gcm_wr(struct aead_request *req,
 	//Offset of tag from end
 	temp = (reqctx->op == CHCR_ENCRYPT_OP) ? 0 : authsize;
 	chcr_req->sec_cpl.op_ivinsrtofst = FILL_SEC_CPL_OP_IVINSR(
-					a_ctx(tfm)->tx_chan_id, 2, 1);
+						rx_channel_id, 2, 1);
 	chcr_req->sec_cpl.pldlen =
 		htonl(req->assoclen + IV + req->cryptlen);
 	chcr_req->sec_cpl.aadstart_cipherstop_hi = FILL_SEC_CPL_CIPHERSTOP_HI(
@@ -3603,9 +3679,9 @@ static int chcr_aead_op(struct aead_request *req,
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct chcr_aead_reqctx  *reqctx = aead_request_ctx(req);
-	struct uld_ctx *u_ctx;
+	struct chcr_context *ctx = a_ctx(tfm);
+	struct uld_ctx *u_ctx = ULD_CTX(ctx);
 	struct sk_buff *skb;
-	int isfull = 0;
 	struct chcr_dev *cdev;
 
 	cdev = a_ctx(tfm)->dev;
@@ -3621,18 +3697,15 @@ static int chcr_aead_op(struct aead_request *req,
 		return chcr_aead_fallback(req, reqctx->op);
 	}
 
-	u_ctx = ULD_CTX(a_ctx(tfm));
 	if (cxgb4_is_crypto_q_full(u_ctx->lldi.ports[0],
-				   a_ctx(tfm)->tx_qidx)) {
-		isfull = 1;
-		if (!(req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG)) {
+					reqctx->txqidx) &&
+		(!(req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG))) {
 			chcr_dec_wrcount(cdev);
 			return -ENOSPC;
-		}
 	}
 
 	/* Form a WR from req */
-	skb = create_wr_fn(req, u_ctx->lldi.rxq_ids[a_ctx(tfm)->rx_qidx], size);
+	skb = create_wr_fn(req, u_ctx->lldi.rxq_ids[reqctx->rxqidx], size);
 
 	if (IS_ERR_OR_NULL(skb)) {
 		chcr_dec_wrcount(cdev);
@@ -3640,15 +3713,22 @@ static int chcr_aead_op(struct aead_request *req,
 	}
 
 	skb->dev = u_ctx->lldi.ports[0];
-	set_wr_txq(skb, CPL_PRIORITY_DATA, a_ctx(tfm)->tx_qidx);
+	set_wr_txq(skb, CPL_PRIORITY_DATA, reqctx->txqidx);
 	chcr_send_wr(skb);
-	return isfull ? -EBUSY : -EINPROGRESS;
+	return -EINPROGRESS;
 }
 
 static int chcr_aead_encrypt(struct aead_request *req)
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct chcr_aead_reqctx *reqctx = aead_request_ctx(req);
+	struct chcr_context *ctx = a_ctx(tfm);
+	unsigned int cpu;
+
+	cpu = get_cpu();
+	reqctx->txqidx = cpu % ctx->ntxq;
+	reqctx->rxqidx = cpu % ctx->nrxq;
+	put_cpu();
 
 	reqctx->verify = VERIFY_HW;
 	reqctx->op = CHCR_ENCRYPT_OP;
@@ -3670,9 +3750,16 @@ static int chcr_aead_encrypt(struct aead_request *req)
 static int chcr_aead_decrypt(struct aead_request *req)
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	struct chcr_aead_ctx *aeadctx = AEAD_CTX(a_ctx(tfm));
+	struct chcr_context *ctx = a_ctx(tfm);
+	struct chcr_aead_ctx *aeadctx = AEAD_CTX(ctx);
 	struct chcr_aead_reqctx *reqctx = aead_request_ctx(req);
 	int size;
+	unsigned int cpu;
+
+	cpu = get_cpu();
+	reqctx->txqidx = cpu % ctx->ntxq;
+	reqctx->rxqidx = cpu % ctx->nrxq;
+	put_cpu();
 
 	if (aeadctx->mayverify == VERIFY_SW) {
 		size = crypto_aead_maxauthsize(tfm);
diff --git a/drivers/crypto/chelsio/chcr_core.h b/drivers/crypto/chelsio/chcr_core.h
index b41ef1abfe74..e51c138b0a51 100644
--- a/drivers/crypto/chelsio/chcr_core.h
+++ b/drivers/crypto/chelsio/chcr_core.h
@@ -148,7 +148,6 @@ struct chcr_dev {
 	int wqretry;
 	struct delayed_work detach_work;
 	struct completion detach_comp;
-	unsigned char tx_channel_id;
 };
 
 struct uld_ctx {
diff --git a/drivers/crypto/chelsio/chcr_crypto.h b/drivers/crypto/chelsio/chcr_crypto.h
index dbb7e13bb409..542bebae001f 100644
--- a/drivers/crypto/chelsio/chcr_crypto.h
+++ b/drivers/crypto/chelsio/chcr_crypto.h
@@ -187,6 +187,8 @@ struct chcr_aead_reqctx {
 	unsigned int op;
 	u16 imm;
 	u16 verify;
+	u16 txqidx;
+	u16 rxqidx;
 	u8 iv[CHCR_MAX_CRYPTO_IV_LEN + MAX_SCRATCH_PAD_SIZE];
 	u8 *scratch_pad;
 };
@@ -250,10 +252,10 @@ struct __crypto_ctx {
 
 struct chcr_context {
 	struct chcr_dev *dev;
-	unsigned char tx_qidx;
-	unsigned char rx_qidx;
-	unsigned char tx_chan_id;
-	unsigned char pci_chan_id;
+	unsigned char rxq_perchan;
+	unsigned char txq_perchan;
+	unsigned int  ntxq;
+	unsigned int  nrxq;
 	struct completion cbc_aes_aio_done;
 	struct __crypto_ctx crypto_ctx[0];
 };
@@ -280,6 +282,8 @@ struct chcr_ahash_req_ctx {
 	u8 *skbfr;
 	/* SKB which is being sent to the hardware for processing */
 	u64 data_len;  /* Data len till time */
+	u16 txqidx;
+	u16 rxqidx;
 	u8 reqlen;
 	u8 partial_hash[CHCR_HASH_MAX_DIGEST_SIZE];
 	u8 bfr1[CHCR_HASH_MAX_BLOCK_SIZE_128];
@@ -298,6 +302,8 @@ struct chcr_skcipher_req_ctx {
 	unsigned int op;
 	u16 imm;
 	u8 iv[CHCR_MAX_CRYPTO_IV_LEN];
+	u16 txqidx;
+	u16 rxqidx;
 };
 
 struct chcr_alg_template {
-- 
2.25.0.114.g5b0ca87


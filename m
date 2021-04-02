Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84643352FB6
	for <lists+linux-crypto@lfdr.de>; Fri,  2 Apr 2021 21:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhDBT0d (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 2 Apr 2021 15:26:33 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:65353 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbhDBT0a (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 2 Apr 2021 15:26:30 -0400
Received: from beagle8.blr.asicdesigners.com (beagle8.blr.asicdesigners.com [10.193.80.125])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 132JQI71005083;
        Fri, 2 Apr 2021 12:26:19 -0700
From:   Ayush Sawal <ayush.sawal@chelsio.com>
To:     linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     secdev@chelsio.com, Ayush Sawal <ayush.sawal@chelsio.com>
Subject: [PATCH crypto] chcr: Read rxchannel-id from firmware
Date:   Sat,  3 Apr 2021 00:55:48 +0530
Message-Id: <20210402192548.9405-1-ayush.sawal@chelsio.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The rxchannel id is updated by the driver using the
port no value, but this does not ensure that the value
is correct. So now rx channel value is obtained from
etoc channel map value.

Fixes: 567be3a5d227 ("crypto: chelsio - Use multiple txq/rxq per tfm to process the requests)
Signed-off-by: Ayush Sawal <ayush.sawal@chelsio.com>
---
 drivers/crypto/chelsio/chcr_algo.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
index f77d3fd962bf..ef350285dd6f 100644
--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -769,13 +769,14 @@ static inline void create_wreq(struct chcr_context *ctx,
 	struct uld_ctx *u_ctx = ULD_CTX(ctx);
 	unsigned int tx_channel_id, rx_channel_id;
 	unsigned int txqidx = 0, rxqidx = 0;
-	unsigned int qid, fid;
+	unsigned int qid, fid, portno;
 
 	get_qidxs(req, &txqidx, &rxqidx);
 	qid = u_ctx->lldi.rxq_ids[rxqidx];
 	fid = u_ctx->lldi.rxq_ids[0];
+	portno = rxqidx / ctx->rxq_perchan;
 	tx_channel_id = txqidx / ctx->txq_perchan;
-	rx_channel_id = rxqidx / ctx->rxq_perchan;
+	rx_channel_id = cxgb4_port_e2cchan(u_ctx->lldi.ports[portno]);
 
 
 	chcr_req->wreq.op_to_cctx_size = FILL_WR_OP_CCTX_SIZE;
@@ -803,6 +804,7 @@ static struct sk_buff *create_cipher_wr(struct cipher_wr_param *wrparam)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(wrparam->req);
 	struct chcr_context *ctx = c_ctx(tfm);
+	struct uld_ctx *u_ctx = ULD_CTX(ctx);
 	struct ablk_ctx *ablkctx = ABLK_CTX(ctx);
 	struct sk_buff *skb = NULL;
 	struct chcr_wr *chcr_req;
@@ -819,6 +821,7 @@ static struct sk_buff *create_cipher_wr(struct cipher_wr_param *wrparam)
 	struct adapter *adap = padap(ctx->dev);
 	unsigned int rx_channel_id = reqctx->rxqidx / ctx->rxq_perchan;
 
+	rx_channel_id = cxgb4_port_e2cchan(u_ctx->lldi.ports[rx_channel_id]);
 	nents = sg_nents_xlen(reqctx->dstsg,  wrparam->bytes, CHCR_DST_SG_SIZE,
 			      reqctx->dst_ofst);
 	dst_size = get_space_for_phys_dsgl(nents);
@@ -1578,6 +1581,7 @@ static struct sk_buff *create_hash_wr(struct ahash_request *req,
 	int error = 0;
 	unsigned int rx_channel_id = req_ctx->rxqidx / ctx->rxq_perchan;
 
+	rx_channel_id = cxgb4_port_e2cchan(u_ctx->lldi.ports[rx_channel_id]);
 	transhdr_len = HASH_TRANSHDR_SIZE(param->kctx_len);
 	req_ctx->hctx_wr.imm = (transhdr_len + param->bfr_len +
 				param->sg_len) <= SGE_MAX_WR_LEN;
@@ -2436,6 +2440,7 @@ static struct sk_buff *create_authenc_wr(struct aead_request *req,
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct chcr_context *ctx = a_ctx(tfm);
+	struct uld_ctx *u_ctx = ULD_CTX(ctx);
 	struct chcr_aead_ctx *aeadctx = AEAD_CTX(ctx);
 	struct chcr_authenc_ctx *actx = AUTHENC_CTX(aeadctx);
 	struct chcr_aead_reqctx *reqctx = aead_request_ctx(req);
@@ -2455,6 +2460,7 @@ static struct sk_buff *create_authenc_wr(struct aead_request *req,
 	struct adapter *adap = padap(ctx->dev);
 	unsigned int rx_channel_id = reqctx->rxqidx / ctx->rxq_perchan;
 
+	rx_channel_id = cxgb4_port_e2cchan(u_ctx->lldi.ports[rx_channel_id]);
 	if (req->cryptlen == 0)
 		return NULL;
 
@@ -2708,9 +2714,11 @@ void chcr_add_aead_dst_ent(struct aead_request *req,
 	struct dsgl_walk dsgl_walk;
 	unsigned int authsize = crypto_aead_authsize(tfm);
 	struct chcr_context *ctx = a_ctx(tfm);
+	struct uld_ctx *u_ctx = ULD_CTX(ctx);
 	u32 temp;
 	unsigned int rx_channel_id = reqctx->rxqidx / ctx->rxq_perchan;
 
+	rx_channel_id = cxgb4_port_e2cchan(u_ctx->lldi.ports[rx_channel_id]);
 	dsgl_walk_init(&dsgl_walk, phys_cpl);
 	dsgl_walk_add_page(&dsgl_walk, IV + reqctx->b0_len, reqctx->iv_dma);
 	temp = req->assoclen + req->cryptlen +
@@ -2750,9 +2758,11 @@ void chcr_add_cipher_dst_ent(struct skcipher_request *req,
 	struct chcr_skcipher_req_ctx *reqctx = skcipher_request_ctx(req);
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(wrparam->req);
 	struct chcr_context *ctx = c_ctx(tfm);
+	struct uld_ctx *u_ctx = ULD_CTX(ctx);
 	struct dsgl_walk dsgl_walk;
 	unsigned int rx_channel_id = reqctx->rxqidx / ctx->rxq_perchan;
 
+	rx_channel_id = cxgb4_port_e2cchan(u_ctx->lldi.ports[rx_channel_id]);
 	dsgl_walk_init(&dsgl_walk, phys_cpl);
 	dsgl_walk_add_sg(&dsgl_walk, reqctx->dstsg, wrparam->bytes,
 			 reqctx->dst_ofst);
@@ -2956,6 +2966,7 @@ static void fill_sec_cpl_for_aead(struct cpl_tx_sec_pdu *sec_cpl,
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct chcr_context *ctx = a_ctx(tfm);
+	struct uld_ctx *u_ctx = ULD_CTX(ctx);
 	struct chcr_aead_ctx *aeadctx = AEAD_CTX(ctx);
 	struct chcr_aead_reqctx *reqctx = aead_request_ctx(req);
 	unsigned int cipher_mode = CHCR_SCMD_CIPHER_MODE_AES_CCM;
@@ -2965,6 +2976,8 @@ static void fill_sec_cpl_for_aead(struct cpl_tx_sec_pdu *sec_cpl,
 	unsigned int tag_offset = 0, auth_offset = 0;
 	unsigned int assoclen;
 
+	rx_channel_id = cxgb4_port_e2cchan(u_ctx->lldi.ports[rx_channel_id]);
+
 	if (get_aead_subtype(tfm) == CRYPTO_ALG_SUB_TYPE_AEAD_RFC4309)
 		assoclen = req->assoclen - 8;
 	else
@@ -3125,6 +3138,7 @@ static struct sk_buff *create_gcm_wr(struct aead_request *req,
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct chcr_context *ctx = a_ctx(tfm);
+	struct uld_ctx *u_ctx = ULD_CTX(ctx);
 	struct chcr_aead_ctx *aeadctx = AEAD_CTX(ctx);
 	struct chcr_aead_reqctx  *reqctx = aead_request_ctx(req);
 	struct sk_buff *skb = NULL;
@@ -3141,6 +3155,7 @@ static struct sk_buff *create_gcm_wr(struct aead_request *req,
 	struct adapter *adap = padap(ctx->dev);
 	unsigned int rx_channel_id = reqctx->rxqidx / ctx->rxq_perchan;
 
+	rx_channel_id = cxgb4_port_e2cchan(u_ctx->lldi.ports[rx_channel_id]);
 	if (get_aead_subtype(tfm) == CRYPTO_ALG_SUB_TYPE_AEAD_RFC4106)
 		assoclen = req->assoclen - 8;
 
-- 
2.18.1


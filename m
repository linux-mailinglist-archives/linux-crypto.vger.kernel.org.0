Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDBF169CB5
	for <lists+linux-crypto@lfdr.de>; Mon, 24 Feb 2020 04:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgBXDnO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 23 Feb 2020 22:43:14 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:33124 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgBXDnO (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 23 Feb 2020 22:43:14 -0500
Received: from chumthang.blr.asicdesigners.com (chumthang.blr.asicdesigners.com [10.193.186.96])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 01O3gx6Z015521;
        Sun, 23 Feb 2020 19:43:09 -0800
From:   Ayush Sawal <ayush.sawal@chelsio.com>
To:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org
Cc:     vinay.yadav@chelsio.com, manojmalviya@chelsio.com,
        Ayush Sawal <ayush.sawal@chelsio.com>
Subject: [PATCH Crypto 1/2] chcr: Recalculate iv only if it is needed
Date:   Mon, 24 Feb 2020 09:12:32 +0530
Message-Id: <20200224034233.12476-2-ayush.sawal@chelsio.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca87
In-Reply-To: <20200224034233.12476-1-ayush.sawal@chelsio.com>
References: <20200224034233.12476-1-ayush.sawal@chelsio.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Recalculate iv only if it is needed i.e. if the last req to hw
was partial for aes-xts.

Signed-off-by: Ayush Sawal <ayush.sawal@chelsio.com>
---
 drivers/crypto/chelsio/chcr_algo.c   | 12 ++++++++++--
 drivers/crypto/chelsio/chcr_crypto.h |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
index 96c1b5fc9081..17ce6970dab4 100644
--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -1086,8 +1086,12 @@ static int chcr_final_cipher_iv(struct skcipher_request *req,
 	if (subtype == CRYPTO_ALG_SUB_TYPE_CTR)
 		ctr_add_iv(iv, req->iv, DIV_ROUND_UP(reqctx->processed,
 						       AES_BLOCK_SIZE));
-	else if (subtype == CRYPTO_ALG_SUB_TYPE_XTS)
-		ret = chcr_update_tweak(req, iv, 1);
+	else if (subtype == CRYPTO_ALG_SUB_TYPE_XTS) {
+		if (!reqctx->partial_req)
+			memcpy(iv, reqctx->iv, AES_BLOCK_SIZE);
+		else
+			ret = chcr_update_tweak(req, iv, 1);
+	}
 	else if (subtype == CRYPTO_ALG_SUB_TYPE_CBC) {
 		/*Already updated for Decrypt*/
 		if (!reqctx->op)
@@ -1199,6 +1203,7 @@ static int process_cipher(struct skcipher_request *req,
 	int bytes, err = -EINVAL;
 
 	reqctx->processed = 0;
+	reqctx->partial_req = 0;
 	if (!req->iv)
 		goto error;
 	if ((ablkctx->enckey_len == 0) || (ivsize > AES_BLOCK_SIZE) ||
@@ -1289,6 +1294,7 @@ static int process_cipher(struct skcipher_request *req,
 	}
 	reqctx->processed = bytes;
 	reqctx->last_req_len = bytes;
+	reqctx->partial_req = !!(req->cryptlen - reqctx->processed);
 
 	return 0;
 unmap:
@@ -1300,6 +1306,7 @@ static int process_cipher(struct skcipher_request *req,
 static int chcr_aes_encrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct chcr_skcipher_req_ctx *reqctx = skcipher_request_ctx(req);
 	struct chcr_context *ctx;
 	struct chcr_dev *dev = c_ctx(tfm)->dev;
 	struct sk_buff *skb = NULL;
@@ -1329,6 +1336,7 @@ static int chcr_aes_encrypt(struct skcipher_request *req)
 		CRYPTO_ALG_SUB_TYPE_CBC && req->base.flags ==
 			CRYPTO_TFM_REQ_MAY_SLEEP ) {
 			ctx=c_ctx(tfm);
+			reqctx->partial_req = 1;
 			wait_for_completion(&ctx->cbc_aes_aio_done);
         }
 	return isfull ? -EBUSY : -EINPROGRESS;
diff --git a/drivers/crypto/chelsio/chcr_crypto.h b/drivers/crypto/chelsio/chcr_crypto.h
index 9207d88c5538..dbb7e13bb409 100644
--- a/drivers/crypto/chelsio/chcr_crypto.h
+++ b/drivers/crypto/chelsio/chcr_crypto.h
@@ -291,6 +291,7 @@ struct chcr_skcipher_req_ctx {
 	struct scatterlist *dstsg;
 	unsigned int processed;
 	unsigned int last_req_len;
+	unsigned int partial_req;
 	struct scatterlist *srcsg;
 	unsigned int src_ofst;
 	unsigned int dst_ofst;
-- 
2.25.0.114.g5b0ca87


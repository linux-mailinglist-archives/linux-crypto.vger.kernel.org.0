Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71CC7F6078
	for <lists+linux-crypto@lfdr.de>; Sat,  9 Nov 2019 18:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfKIRLa (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 9 Nov 2019 12:11:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:41174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfKIRL3 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 9 Nov 2019 12:11:29 -0500
Received: from e123331-lin.home (lfbn-mar-1-643-104.w90-118.abo.wanadoo.fr [90.118.215.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99336207FF;
        Sat,  9 Nov 2019 17:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573319487;
        bh=Ril4rFG8b5QpCyw2UiwU7k4kZAyfB5aXDlok4xsGh8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UbhXkfneCw3sI5pA5EWXURTfv6nCMzjyb/Q4r1YhBlYsmTn/GqdhemCholL8JwWpo
         ZRHSZtsFlBc/rUD6go+oihTx+QOGxK9q55NBi4hKmEzr78ocm7clRpVw1rFuumlreC
         hZTE9osXzG2WMl3bMQarwzIl2pdrO3ipiust6P/M=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH v4 21/29] crypto: stm32 - switch to skcipher API
Date:   Sat,  9 Nov 2019 18:09:46 +0100
Message-Id: <20191109170954.756-22-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191109170954.756-1-ardb@kernel.org>
References: <20191109170954.756-1-ardb@kernel.org>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Commit 7a7ffe65c8c5 ("crypto: skcipher - Add top-level skcipher interface")
dated 20 august 2015 introduced the new skcipher API which is supposed to
replace both blkcipher and ablkcipher. While all consumers of the API have
been converted long ago, some producers of the ablkcipher remain, forcing
us to keep the ablkcipher support routines alive, along with the matching
code to expose [a]blkciphers via the skcipher API.

So switch this driver to the skcipher API, allowing us to finally drop the
ablkcipher code in the near future.

Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/crypto/stm32/stm32-cryp.c | 338 +++++++++-----------
 1 file changed, 159 insertions(+), 179 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
index ba5ea6434f9c..d347a1d6e351 100644
--- a/drivers/crypto/stm32/stm32-cryp.c
+++ b/drivers/crypto/stm32/stm32-cryp.c
@@ -19,6 +19,7 @@
 #include <crypto/engine.h>
 #include <crypto/scatterwalk.h>
 #include <crypto/internal/aead.h>
+#include <crypto/internal/skcipher.h>
 
 #define DRIVER_NAME             "stm32-cryp"
 
@@ -137,7 +138,7 @@ struct stm32_cryp {
 
 	struct crypto_engine    *engine;
 
-	struct ablkcipher_request *req;
+	struct skcipher_request *req;
 	struct aead_request     *areq;
 
 	size_t                  authsize;
@@ -395,8 +396,8 @@ static void stm32_cryp_hw_write_iv(struct stm32_cryp *cryp, u32 *iv)
 
 static void stm32_cryp_get_iv(struct stm32_cryp *cryp)
 {
-	struct ablkcipher_request *req = cryp->req;
-	u32 *tmp = req->info;
+	struct skcipher_request *req = cryp->req;
+	u32 *tmp = (void *)req->iv;
 
 	if (!tmp)
 		return;
@@ -616,7 +617,7 @@ static int stm32_cryp_hw_init(struct stm32_cryp *cryp)
 	case CR_TDES_CBC:
 	case CR_AES_CBC:
 	case CR_AES_CTR:
-		stm32_cryp_hw_write_iv(cryp, (u32 *)cryp->req->info);
+		stm32_cryp_hw_write_iv(cryp, (u32 *)cryp->req->iv);
 		break;
 
 	default:
@@ -667,7 +668,7 @@ static void stm32_cryp_finish_req(struct stm32_cryp *cryp, int err)
 	if (is_gcm(cryp) || is_ccm(cryp))
 		crypto_finalize_aead_request(cryp->engine, cryp->areq, err);
 	else
-		crypto_finalize_ablkcipher_request(cryp->engine, cryp->req,
+		crypto_finalize_skcipher_request(cryp->engine, cryp->req,
 						   err);
 
 	memset(cryp->ctx->key, 0, cryp->ctx->keylen);
@@ -685,11 +686,11 @@ static int stm32_cryp_cipher_one_req(struct crypto_engine *engine, void *areq);
 static int stm32_cryp_prepare_cipher_req(struct crypto_engine *engine,
 					 void *areq);
 
-static int stm32_cryp_cra_init(struct crypto_tfm *tfm)
+static int stm32_cryp_init_tfm(struct crypto_skcipher *tfm)
 {
-	struct stm32_cryp_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct stm32_cryp_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	tfm->crt_ablkcipher.reqsize = sizeof(struct stm32_cryp_reqctx);
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct stm32_cryp_reqctx));
 
 	ctx->enginectx.op.do_one_request = stm32_cryp_cipher_one_req;
 	ctx->enginectx.op.prepare_request = stm32_cryp_prepare_cipher_req;
@@ -714,11 +715,11 @@ static int stm32_cryp_aes_aead_init(struct crypto_aead *tfm)
 	return 0;
 }
 
-static int stm32_cryp_crypt(struct ablkcipher_request *req, unsigned long mode)
+static int stm32_cryp_crypt(struct skcipher_request *req, unsigned long mode)
 {
-	struct stm32_cryp_ctx *ctx = crypto_ablkcipher_ctx(
-			crypto_ablkcipher_reqtfm(req));
-	struct stm32_cryp_reqctx *rctx = ablkcipher_request_ctx(req);
+	struct stm32_cryp_ctx *ctx = crypto_skcipher_ctx(
+			crypto_skcipher_reqtfm(req));
+	struct stm32_cryp_reqctx *rctx = skcipher_request_ctx(req);
 	struct stm32_cryp *cryp = stm32_cryp_find_dev(ctx);
 
 	if (!cryp)
@@ -726,7 +727,7 @@ static int stm32_cryp_crypt(struct ablkcipher_request *req, unsigned long mode)
 
 	rctx->mode = mode;
 
-	return crypto_transfer_ablkcipher_request_to_engine(cryp->engine, req);
+	return crypto_transfer_skcipher_request_to_engine(cryp->engine, req);
 }
 
 static int stm32_cryp_aead_crypt(struct aead_request *req, unsigned long mode)
@@ -743,10 +744,10 @@ static int stm32_cryp_aead_crypt(struct aead_request *req, unsigned long mode)
 	return crypto_transfer_aead_request_to_engine(cryp->engine, req);
 }
 
-static int stm32_cryp_setkey(struct crypto_ablkcipher *tfm, const u8 *key,
+static int stm32_cryp_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			     unsigned int keylen)
 {
-	struct stm32_cryp_ctx *ctx = crypto_ablkcipher_ctx(tfm);
+	struct stm32_cryp_ctx *ctx = crypto_skcipher_ctx(tfm);
 
 	memcpy(ctx->key, key, keylen);
 	ctx->keylen = keylen;
@@ -754,7 +755,7 @@ static int stm32_cryp_setkey(struct crypto_ablkcipher *tfm, const u8 *key,
 	return 0;
 }
 
-static int stm32_cryp_aes_setkey(struct crypto_ablkcipher *tfm, const u8 *key,
+static int stm32_cryp_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
 				 unsigned int keylen)
 {
 	if (keylen != AES_KEYSIZE_128 && keylen != AES_KEYSIZE_192 &&
@@ -764,17 +765,17 @@ static int stm32_cryp_aes_setkey(struct crypto_ablkcipher *tfm, const u8 *key,
 		return stm32_cryp_setkey(tfm, key, keylen);
 }
 
-static int stm32_cryp_des_setkey(struct crypto_ablkcipher *tfm, const u8 *key,
+static int stm32_cryp_des_setkey(struct crypto_skcipher *tfm, const u8 *key,
 				 unsigned int keylen)
 {
-	return verify_ablkcipher_des_key(tfm, key) ?:
+	return verify_skcipher_des_key(tfm, key) ?:
 	       stm32_cryp_setkey(tfm, key, keylen);
 }
 
-static int stm32_cryp_tdes_setkey(struct crypto_ablkcipher *tfm, const u8 *key,
+static int stm32_cryp_tdes_setkey(struct crypto_skcipher *tfm, const u8 *key,
 				  unsigned int keylen)
 {
-	return verify_ablkcipher_des3_key(tfm, key) ?:
+	return verify_skcipher_des3_key(tfm, key) ?:
 	       stm32_cryp_setkey(tfm, key, keylen);
 }
 
@@ -818,32 +819,32 @@ static int stm32_cryp_aes_ccm_setauthsize(struct crypto_aead *tfm,
 	return 0;
 }
 
-static int stm32_cryp_aes_ecb_encrypt(struct ablkcipher_request *req)
+static int stm32_cryp_aes_ecb_encrypt(struct skcipher_request *req)
 {
 	return stm32_cryp_crypt(req, FLG_AES | FLG_ECB | FLG_ENCRYPT);
 }
 
-static int stm32_cryp_aes_ecb_decrypt(struct ablkcipher_request *req)
+static int stm32_cryp_aes_ecb_decrypt(struct skcipher_request *req)
 {
 	return stm32_cryp_crypt(req, FLG_AES | FLG_ECB);
 }
 
-static int stm32_cryp_aes_cbc_encrypt(struct ablkcipher_request *req)
+static int stm32_cryp_aes_cbc_encrypt(struct skcipher_request *req)
 {
 	return stm32_cryp_crypt(req, FLG_AES | FLG_CBC | FLG_ENCRYPT);
 }
 
-static int stm32_cryp_aes_cbc_decrypt(struct ablkcipher_request *req)
+static int stm32_cryp_aes_cbc_decrypt(struct skcipher_request *req)
 {
 	return stm32_cryp_crypt(req, FLG_AES | FLG_CBC);
 }
 
-static int stm32_cryp_aes_ctr_encrypt(struct ablkcipher_request *req)
+static int stm32_cryp_aes_ctr_encrypt(struct skcipher_request *req)
 {
 	return stm32_cryp_crypt(req, FLG_AES | FLG_CTR | FLG_ENCRYPT);
 }
 
-static int stm32_cryp_aes_ctr_decrypt(struct ablkcipher_request *req)
+static int stm32_cryp_aes_ctr_decrypt(struct skcipher_request *req)
 {
 	return stm32_cryp_crypt(req, FLG_AES | FLG_CTR);
 }
@@ -868,47 +869,47 @@ static int stm32_cryp_aes_ccm_decrypt(struct aead_request *req)
 	return stm32_cryp_aead_crypt(req, FLG_AES | FLG_CCM);
 }
 
-static int stm32_cryp_des_ecb_encrypt(struct ablkcipher_request *req)
+static int stm32_cryp_des_ecb_encrypt(struct skcipher_request *req)
 {
 	return stm32_cryp_crypt(req, FLG_DES | FLG_ECB | FLG_ENCRYPT);
 }
 
-static int stm32_cryp_des_ecb_decrypt(struct ablkcipher_request *req)
+static int stm32_cryp_des_ecb_decrypt(struct skcipher_request *req)
 {
 	return stm32_cryp_crypt(req, FLG_DES | FLG_ECB);
 }
 
-static int stm32_cryp_des_cbc_encrypt(struct ablkcipher_request *req)
+static int stm32_cryp_des_cbc_encrypt(struct skcipher_request *req)
 {
 	return stm32_cryp_crypt(req, FLG_DES | FLG_CBC | FLG_ENCRYPT);
 }
 
-static int stm32_cryp_des_cbc_decrypt(struct ablkcipher_request *req)
+static int stm32_cryp_des_cbc_decrypt(struct skcipher_request *req)
 {
 	return stm32_cryp_crypt(req, FLG_DES | FLG_CBC);
 }
 
-static int stm32_cryp_tdes_ecb_encrypt(struct ablkcipher_request *req)
+static int stm32_cryp_tdes_ecb_encrypt(struct skcipher_request *req)
 {
 	return stm32_cryp_crypt(req, FLG_TDES | FLG_ECB | FLG_ENCRYPT);
 }
 
-static int stm32_cryp_tdes_ecb_decrypt(struct ablkcipher_request *req)
+static int stm32_cryp_tdes_ecb_decrypt(struct skcipher_request *req)
 {
 	return stm32_cryp_crypt(req, FLG_TDES | FLG_ECB);
 }
 
-static int stm32_cryp_tdes_cbc_encrypt(struct ablkcipher_request *req)
+static int stm32_cryp_tdes_cbc_encrypt(struct skcipher_request *req)
 {
 	return stm32_cryp_crypt(req, FLG_TDES | FLG_CBC | FLG_ENCRYPT);
 }
 
-static int stm32_cryp_tdes_cbc_decrypt(struct ablkcipher_request *req)
+static int stm32_cryp_tdes_cbc_decrypt(struct skcipher_request *req)
 {
 	return stm32_cryp_crypt(req, FLG_TDES | FLG_CBC);
 }
 
-static int stm32_cryp_prepare_req(struct ablkcipher_request *req,
+static int stm32_cryp_prepare_req(struct skcipher_request *req,
 				  struct aead_request *areq)
 {
 	struct stm32_cryp_ctx *ctx;
@@ -919,7 +920,7 @@ static int stm32_cryp_prepare_req(struct ablkcipher_request *req,
 	if (!req && !areq)
 		return -EINVAL;
 
-	ctx = req ? crypto_ablkcipher_ctx(crypto_ablkcipher_reqtfm(req)) :
+	ctx = req ? crypto_skcipher_ctx(crypto_skcipher_reqtfm(req)) :
 		    crypto_aead_ctx(crypto_aead_reqtfm(areq));
 
 	cryp = ctx->cryp;
@@ -927,7 +928,7 @@ static int stm32_cryp_prepare_req(struct ablkcipher_request *req,
 	if (!cryp)
 		return -ENODEV;
 
-	rctx = req ? ablkcipher_request_ctx(req) : aead_request_ctx(areq);
+	rctx = req ? skcipher_request_ctx(req) : aead_request_ctx(areq);
 	rctx->mode &= FLG_MODE_MASK;
 
 	ctx->cryp = cryp;
@@ -939,7 +940,7 @@ static int stm32_cryp_prepare_req(struct ablkcipher_request *req,
 	if (req) {
 		cryp->req = req;
 		cryp->areq = NULL;
-		cryp->total_in = req->nbytes;
+		cryp->total_in = req->cryptlen;
 		cryp->total_out = cryp->total_in;
 	} else {
 		/*
@@ -1016,8 +1017,8 @@ static int stm32_cryp_prepare_req(struct ablkcipher_request *req,
 static int stm32_cryp_prepare_cipher_req(struct crypto_engine *engine,
 					 void *areq)
 {
-	struct ablkcipher_request *req = container_of(areq,
-						      struct ablkcipher_request,
+	struct skcipher_request *req = container_of(areq,
+						      struct skcipher_request,
 						      base);
 
 	return stm32_cryp_prepare_req(req, NULL);
@@ -1025,11 +1026,11 @@ static int stm32_cryp_prepare_cipher_req(struct crypto_engine *engine,
 
 static int stm32_cryp_cipher_one_req(struct crypto_engine *engine, void *areq)
 {
-	struct ablkcipher_request *req = container_of(areq,
-						      struct ablkcipher_request,
+	struct skcipher_request *req = container_of(areq,
+						      struct skcipher_request,
 						      base);
-	struct stm32_cryp_ctx *ctx = crypto_ablkcipher_ctx(
-			crypto_ablkcipher_reqtfm(req));
+	struct stm32_cryp_ctx *ctx = crypto_skcipher_ctx(
+			crypto_skcipher_reqtfm(req));
 	struct stm32_cryp *cryp = ctx->cryp;
 
 	if (!cryp)
@@ -1724,150 +1725,129 @@ static irqreturn_t stm32_cryp_irq(int irq, void *arg)
 	return IRQ_WAKE_THREAD;
 }
 
-static struct crypto_alg crypto_algs[] = {
-{
-	.cra_name		= "ecb(aes)",
-	.cra_driver_name	= "stm32-ecb-aes",
-	.cra_priority		= 200,
-	.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER |
-				  CRYPTO_ALG_ASYNC,
-	.cra_blocksize		= AES_BLOCK_SIZE,
-	.cra_ctxsize		= sizeof(struct stm32_cryp_ctx),
-	.cra_alignmask		= 0xf,
-	.cra_type		= &crypto_ablkcipher_type,
-	.cra_module		= THIS_MODULE,
-	.cra_init		= stm32_cryp_cra_init,
-	.cra_ablkcipher = {
-		.min_keysize	= AES_MIN_KEY_SIZE,
-		.max_keysize	= AES_MAX_KEY_SIZE,
-		.setkey		= stm32_cryp_aes_setkey,
-		.encrypt	= stm32_cryp_aes_ecb_encrypt,
-		.decrypt	= stm32_cryp_aes_ecb_decrypt,
-	}
+static struct skcipher_alg crypto_algs[] = {
+{
+	.base.cra_name		= "ecb(aes)",
+	.base.cra_driver_name	= "stm32-ecb-aes",
+	.base.cra_priority	= 200,
+	.base.cra_flags		= CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize	= AES_BLOCK_SIZE,
+	.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
+	.base.cra_alignmask	= 0xf,
+	.base.cra_module	= THIS_MODULE,
+
+	.init			= stm32_cryp_init_tfm,
+	.min_keysize		= AES_MIN_KEY_SIZE,
+	.max_keysize		= AES_MAX_KEY_SIZE,
+	.setkey			= stm32_cryp_aes_setkey,
+	.encrypt		= stm32_cryp_aes_ecb_encrypt,
+	.decrypt		= stm32_cryp_aes_ecb_decrypt,
 },
 {
-	.cra_name		= "cbc(aes)",
-	.cra_driver_name	= "stm32-cbc-aes",
-	.cra_priority		= 200,
-	.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER |
-				  CRYPTO_ALG_ASYNC,
-	.cra_blocksize		= AES_BLOCK_SIZE,
-	.cra_ctxsize		= sizeof(struct stm32_cryp_ctx),
-	.cra_alignmask		= 0xf,
-	.cra_type		= &crypto_ablkcipher_type,
-	.cra_module		= THIS_MODULE,
-	.cra_init		= stm32_cryp_cra_init,
-	.cra_ablkcipher = {
-		.min_keysize	= AES_MIN_KEY_SIZE,
-		.max_keysize	= AES_MAX_KEY_SIZE,
-		.ivsize		= AES_BLOCK_SIZE,
-		.setkey		= stm32_cryp_aes_setkey,
-		.encrypt	= stm32_cryp_aes_cbc_encrypt,
-		.decrypt	= stm32_cryp_aes_cbc_decrypt,
-	}
+	.base.cra_name		= "cbc(aes)",
+	.base.cra_driver_name	= "stm32-cbc-aes",
+	.base.cra_priority	= 200,
+	.base.cra_flags		= CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize	= AES_BLOCK_SIZE,
+	.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
+	.base.cra_alignmask	= 0xf,
+	.base.cra_module	= THIS_MODULE,
+
+	.init			= stm32_cryp_init_tfm,
+	.min_keysize		= AES_MIN_KEY_SIZE,
+	.max_keysize		= AES_MAX_KEY_SIZE,
+	.ivsize			= AES_BLOCK_SIZE,
+	.setkey			= stm32_cryp_aes_setkey,
+	.encrypt		= stm32_cryp_aes_cbc_encrypt,
+	.decrypt		= stm32_cryp_aes_cbc_decrypt,
 },
 {
-	.cra_name		= "ctr(aes)",
-	.cra_driver_name	= "stm32-ctr-aes",
-	.cra_priority		= 200,
-	.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER |
-				  CRYPTO_ALG_ASYNC,
-	.cra_blocksize		= 1,
-	.cra_ctxsize		= sizeof(struct stm32_cryp_ctx),
-	.cra_alignmask		= 0xf,
-	.cra_type		= &crypto_ablkcipher_type,
-	.cra_module		= THIS_MODULE,
-	.cra_init		= stm32_cryp_cra_init,
-	.cra_ablkcipher = {
-		.min_keysize	= AES_MIN_KEY_SIZE,
-		.max_keysize	= AES_MAX_KEY_SIZE,
-		.ivsize		= AES_BLOCK_SIZE,
-		.setkey		= stm32_cryp_aes_setkey,
-		.encrypt	= stm32_cryp_aes_ctr_encrypt,
-		.decrypt	= stm32_cryp_aes_ctr_decrypt,
-	}
+	.base.cra_name		= "ctr(aes)",
+	.base.cra_driver_name	= "stm32-ctr-aes",
+	.base.cra_priority	= 200,
+	.base.cra_flags		= CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize	= 1,
+	.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
+	.base.cra_alignmask	= 0xf,
+	.base.cra_module	= THIS_MODULE,
+
+	.init			= stm32_cryp_init_tfm,
+	.min_keysize		= AES_MIN_KEY_SIZE,
+	.max_keysize		= AES_MAX_KEY_SIZE,
+	.ivsize			= AES_BLOCK_SIZE,
+	.setkey			= stm32_cryp_aes_setkey,
+	.encrypt		= stm32_cryp_aes_ctr_encrypt,
+	.decrypt		= stm32_cryp_aes_ctr_decrypt,
 },
 {
-	.cra_name		= "ecb(des)",
-	.cra_driver_name	= "stm32-ecb-des",
-	.cra_priority		= 200,
-	.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER |
-				  CRYPTO_ALG_ASYNC,
-	.cra_blocksize		= DES_BLOCK_SIZE,
-	.cra_ctxsize		= sizeof(struct stm32_cryp_ctx),
-	.cra_alignmask		= 0xf,
-	.cra_type		= &crypto_ablkcipher_type,
-	.cra_module		= THIS_MODULE,
-	.cra_init		= stm32_cryp_cra_init,
-	.cra_ablkcipher = {
-		.min_keysize	= DES_BLOCK_SIZE,
-		.max_keysize	= DES_BLOCK_SIZE,
-		.setkey		= stm32_cryp_des_setkey,
-		.encrypt	= stm32_cryp_des_ecb_encrypt,
-		.decrypt	= stm32_cryp_des_ecb_decrypt,
-	}
+	.base.cra_name		= "ecb(des)",
+	.base.cra_driver_name	= "stm32-ecb-des",
+	.base.cra_priority	= 200,
+	.base.cra_flags		= CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize	= DES_BLOCK_SIZE,
+	.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
+	.base.cra_alignmask	= 0xf,
+	.base.cra_module	= THIS_MODULE,
+
+	.init			= stm32_cryp_init_tfm,
+	.min_keysize		= DES_BLOCK_SIZE,
+	.max_keysize		= DES_BLOCK_SIZE,
+	.setkey			= stm32_cryp_des_setkey,
+	.encrypt		= stm32_cryp_des_ecb_encrypt,
+	.decrypt		= stm32_cryp_des_ecb_decrypt,
 },
 {
-	.cra_name		= "cbc(des)",
-	.cra_driver_name	= "stm32-cbc-des",
-	.cra_priority		= 200,
-	.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER |
-				  CRYPTO_ALG_ASYNC,
-	.cra_blocksize		= DES_BLOCK_SIZE,
-	.cra_ctxsize		= sizeof(struct stm32_cryp_ctx),
-	.cra_alignmask		= 0xf,
-	.cra_type		= &crypto_ablkcipher_type,
-	.cra_module		= THIS_MODULE,
-	.cra_init		= stm32_cryp_cra_init,
-	.cra_ablkcipher = {
-		.min_keysize	= DES_BLOCK_SIZE,
-		.max_keysize	= DES_BLOCK_SIZE,
-		.ivsize		= DES_BLOCK_SIZE,
-		.setkey		= stm32_cryp_des_setkey,
-		.encrypt	= stm32_cryp_des_cbc_encrypt,
-		.decrypt	= stm32_cryp_des_cbc_decrypt,
-	}
+	.base.cra_name		= "cbc(des)",
+	.base.cra_driver_name	= "stm32-cbc-des",
+	.base.cra_priority	= 200,
+	.base.cra_flags		= CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize	= DES_BLOCK_SIZE,
+	.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
+	.base.cra_alignmask	= 0xf,
+	.base.cra_module	= THIS_MODULE,
+
+	.init			= stm32_cryp_init_tfm,
+	.min_keysize		= DES_BLOCK_SIZE,
+	.max_keysize		= DES_BLOCK_SIZE,
+	.ivsize			= DES_BLOCK_SIZE,
+	.setkey			= stm32_cryp_des_setkey,
+	.encrypt		= stm32_cryp_des_cbc_encrypt,
+	.decrypt		= stm32_cryp_des_cbc_decrypt,
 },
 {
-	.cra_name		= "ecb(des3_ede)",
-	.cra_driver_name	= "stm32-ecb-des3",
-	.cra_priority		= 200,
-	.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER |
-				  CRYPTO_ALG_ASYNC,
-	.cra_blocksize		= DES_BLOCK_SIZE,
-	.cra_ctxsize		= sizeof(struct stm32_cryp_ctx),
-	.cra_alignmask		= 0xf,
-	.cra_type		= &crypto_ablkcipher_type,
-	.cra_module		= THIS_MODULE,
-	.cra_init		= stm32_cryp_cra_init,
-	.cra_ablkcipher = {
-		.min_keysize	= 3 * DES_BLOCK_SIZE,
-		.max_keysize	= 3 * DES_BLOCK_SIZE,
-		.setkey		= stm32_cryp_tdes_setkey,
-		.encrypt	= stm32_cryp_tdes_ecb_encrypt,
-		.decrypt	= stm32_cryp_tdes_ecb_decrypt,
-	}
+	.base.cra_name		= "ecb(des3_ede)",
+	.base.cra_driver_name	= "stm32-ecb-des3",
+	.base.cra_priority	= 200,
+	.base.cra_flags		= CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize	= DES_BLOCK_SIZE,
+	.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
+	.base.cra_alignmask	= 0xf,
+	.base.cra_module	= THIS_MODULE,
+
+	.init			= stm32_cryp_init_tfm,
+	.min_keysize		= 3 * DES_BLOCK_SIZE,
+	.max_keysize		= 3 * DES_BLOCK_SIZE,
+	.setkey			= stm32_cryp_tdes_setkey,
+	.encrypt		= stm32_cryp_tdes_ecb_encrypt,
+	.decrypt		= stm32_cryp_tdes_ecb_decrypt,
 },
 {
-	.cra_name		= "cbc(des3_ede)",
-	.cra_driver_name	= "stm32-cbc-des3",
-	.cra_priority		= 200,
-	.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER |
-				  CRYPTO_ALG_ASYNC,
-	.cra_blocksize		= DES_BLOCK_SIZE,
-	.cra_ctxsize		= sizeof(struct stm32_cryp_ctx),
-	.cra_alignmask		= 0xf,
-	.cra_type		= &crypto_ablkcipher_type,
-	.cra_module		= THIS_MODULE,
-	.cra_init		= stm32_cryp_cra_init,
-	.cra_ablkcipher = {
-		.min_keysize	= 3 * DES_BLOCK_SIZE,
-		.max_keysize	= 3 * DES_BLOCK_SIZE,
-		.ivsize		= DES_BLOCK_SIZE,
-		.setkey		= stm32_cryp_tdes_setkey,
-		.encrypt	= stm32_cryp_tdes_cbc_encrypt,
-		.decrypt	= stm32_cryp_tdes_cbc_decrypt,
-	}
+	.base.cra_name		= "cbc(des3_ede)",
+	.base.cra_driver_name	= "stm32-cbc-des3",
+	.base.cra_priority	= 200,
+	.base.cra_flags		= CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize	= DES_BLOCK_SIZE,
+	.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
+	.base.cra_alignmask	= 0xf,
+	.base.cra_module	= THIS_MODULE,
+
+	.init			= stm32_cryp_init_tfm,
+	.min_keysize		= 3 * DES_BLOCK_SIZE,
+	.max_keysize		= 3 * DES_BLOCK_SIZE,
+	.ivsize			= DES_BLOCK_SIZE,
+	.setkey			= stm32_cryp_tdes_setkey,
+	.encrypt		= stm32_cryp_tdes_cbc_encrypt,
+	.decrypt		= stm32_cryp_tdes_cbc_decrypt,
 },
 };
 
@@ -2010,7 +1990,7 @@ static int stm32_cryp_probe(struct platform_device *pdev)
 		goto err_engine2;
 	}
 
-	ret = crypto_register_algs(crypto_algs, ARRAY_SIZE(crypto_algs));
+	ret = crypto_register_skciphers(crypto_algs, ARRAY_SIZE(crypto_algs));
 	if (ret) {
 		dev_err(dev, "Could not register algs\n");
 		goto err_algs;
@@ -2027,7 +2007,7 @@ static int stm32_cryp_probe(struct platform_device *pdev)
 	return 0;
 
 err_aead_algs:
-	crypto_unregister_algs(crypto_algs, ARRAY_SIZE(crypto_algs));
+	crypto_unregister_skciphers(crypto_algs, ARRAY_SIZE(crypto_algs));
 err_algs:
 err_engine2:
 	crypto_engine_exit(cryp->engine);
@@ -2059,7 +2039,7 @@ static int stm32_cryp_remove(struct platform_device *pdev)
 		return ret;
 
 	crypto_unregister_aeads(aead_algs, ARRAY_SIZE(aead_algs));
-	crypto_unregister_algs(crypto_algs, ARRAY_SIZE(crypto_algs));
+	crypto_unregister_skciphers(crypto_algs, ARRAY_SIZE(crypto_algs));
 
 	crypto_engine_exit(cryp->engine);
 
-- 
2.17.1


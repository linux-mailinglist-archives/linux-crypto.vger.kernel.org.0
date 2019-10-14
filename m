Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 654F4D6249
	for <lists+linux-crypto@lfdr.de>; Mon, 14 Oct 2019 14:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbfJNMUH (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 14 Oct 2019 08:20:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33349 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfJNMUG (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 14 Oct 2019 08:20:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id b9so19504794wrs.0
        for <linux-crypto@vger.kernel.org>; Mon, 14 Oct 2019 05:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iDXwkl7O2yYcupCDQGZpR6b45iWm8a4P/toc4fBfMes=;
        b=x10DFkT8B5qOpDZyhv01DBUES+o3abX6KTZto38qzT+/nQopl+Gw5ulkwl83d3NxpI
         Ptdn+aIp3Xk2spcA6Un+jW5iTfnHu4uyZ/yz645Bn2snkupT+iPTrF6tjwBONGbMCnNk
         0ZCTmBZhbJh/wVk9d52YnW4vMY+9xmmqGplDq36w9f0nE5FqhLeCywZ6mMJI8tgt2Ijl
         hc9vL68E7o9GXNYkTRnm9SFne5DN1hmHr/B1BzPXI3mVE6EEXQX7D2CWCjhXTNy1JgDU
         B59TfSn81/ou+mZVOGa7BMvWBQPUSSJelct/FScqMvqA++4taM24mp2IGs19VuRk+WxA
         H9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iDXwkl7O2yYcupCDQGZpR6b45iWm8a4P/toc4fBfMes=;
        b=BYJoEEhrQfNqKoqR0o7+qiSUbFrY6aG8hSk4NLbBpWbpKqGLx1y0HPpGAFL8X9wkQV
         M5z1lF34UNWOkKg55/0odHmUa9rlvtK0YN7HXhcv8SC08j/N46/qohTs7jeoZnMiY3Jc
         HEQh1T67VhoXLzbb1vUeTMcaqOwyGVo6elfXK+u/6yGKFIfiuqdg6lRqfQQ/QE6lz9XW
         ac2Su/x/lF21N/gDTsKuq7eqi/J2tqKDkl7WJi3mYjPRyeo9fKy4p9uv+3jNYRDJi7pv
         rmFRIhZ5zSJZZIj96Hq5/QNwQ+6F2dnCkxAr9t5b05XTfTrsTZLVUuNkg1V+tDwobOXv
         o2gg==
X-Gm-Message-State: APjAAAW3v36qpFQcOgWpDpyJ7aRxaVHgl8OCP4QKh55WP0QgiDPXkNll
        sfEB2Hld5gw0iMl5ebw8Z6I13f600BNLrw==
X-Google-Smtp-Source: APXvYqxlqwO8J8OKUPls95f5oexWvuFZP4Q/71goRqiJ45mLdlAbhx8sXV/XnwRiKYlKCL1n5TqMmw==
X-Received: by 2002:a5d:4a87:: with SMTP id o7mr26620721wrq.374.1571055600950;
        Mon, 14 Oct 2019 05:20:00 -0700 (PDT)
Received: from localhost.localdomain (91-167-84-221.subs.proxad.net. [91.167.84.221])
        by smtp.gmail.com with ESMTPSA id i1sm20222470wmb.19.2019.10.14.05.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 05:19:59 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH 20/25] crypto: stm32 - switch to skcipher API
Date:   Mon, 14 Oct 2019 14:19:05 +0200
Message-Id: <20191014121910.7264-21-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014121910.7264-1-ard.biesheuvel@linaro.org>
References: <20191014121910.7264-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
blkcipher code in the near future.

Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
2.20.1


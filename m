Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A04C3EFE73
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Nov 2019 14:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389196AbfKEN3Q (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 5 Nov 2019 08:29:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:47206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389116AbfKEN3Q (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 5 Nov 2019 08:29:16 -0500
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr [92.154.90.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3B2321D7D;
        Tue,  5 Nov 2019 13:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572960554;
        bh=LgsL6eDKHN8LPa1q+ftDXURke0wtTHffPmnUpK+9ZIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KPMUicrdbgptIPWe5Lz7g0qScuQt7jsamJI6L7fVwl2l9REow7j8Ls+VfeLlLCRWb
         HYMJzA0Ua0ZhWvctzeV06TGadzVTrmUPCFHYEjTx4axhG4yB+CJcWYeVuipejy5tHa
         eEYNuFUcc1+1l13GjGHVDXjXyrKiG4GsVG5kHLX0=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 17/29] crypto: mediatek - switch to skcipher API
Date:   Tue,  5 Nov 2019 14:28:14 +0100
Message-Id: <20191105132826.1838-18-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191105132826.1838-1-ardb@kernel.org>
References: <20191105132826.1838-1-ardb@kernel.org>
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

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/crypto/mediatek/mtk-aes.c | 248 +++++++++-----------
 1 file changed, 116 insertions(+), 132 deletions(-)

diff --git a/drivers/crypto/mediatek/mtk-aes.c b/drivers/crypto/mediatek/mtk-aes.c
index d43410259113..90880a81c534 100644
--- a/drivers/crypto/mediatek/mtk-aes.c
+++ b/drivers/crypto/mediatek/mtk-aes.c
@@ -11,6 +11,7 @@
 
 #include <crypto/aes.h>
 #include <crypto/gcm.h>
+#include <crypto/internal/skcipher.h>
 #include "mtk-platform.h"
 
 #define AES_QUEUE_SIZE		512
@@ -414,7 +415,7 @@ static int mtk_aes_map(struct mtk_cryp *cryp, struct mtk_aes_rec *aes)
 static void mtk_aes_info_init(struct mtk_cryp *cryp, struct mtk_aes_rec *aes,
 			      size_t len)
 {
-	struct ablkcipher_request *req = ablkcipher_request_cast(aes->areq);
+	struct skcipher_request *req = skcipher_request_cast(aes->areq);
 	struct mtk_aes_base_ctx *ctx = aes->ctx;
 	struct mtk_aes_info *info = &ctx->info;
 	u32 cnt = 0;
@@ -450,7 +451,7 @@ static void mtk_aes_info_init(struct mtk_cryp *cryp, struct mtk_aes_rec *aes,
 		return;
 	}
 
-	mtk_aes_write_state_le(info->state + ctx->keylen, req->info,
+	mtk_aes_write_state_le(info->state + ctx->keylen, (void *)req->iv,
 			       AES_BLOCK_SIZE);
 ctr:
 	info->tfm[0] += AES_TFM_SIZE(SIZE_IN_WORDS(AES_BLOCK_SIZE));
@@ -552,13 +553,13 @@ static int mtk_aes_transfer_complete(struct mtk_cryp *cryp,
 
 static int mtk_aes_start(struct mtk_cryp *cryp, struct mtk_aes_rec *aes)
 {
-	struct ablkcipher_request *req = ablkcipher_request_cast(aes->areq);
-	struct mtk_aes_reqctx *rctx = ablkcipher_request_ctx(req);
+	struct skcipher_request *req = skcipher_request_cast(aes->areq);
+	struct mtk_aes_reqctx *rctx = skcipher_request_ctx(req);
 
 	mtk_aes_set_mode(aes, rctx);
 	aes->resume = mtk_aes_transfer_complete;
 
-	return mtk_aes_dma(cryp, aes, req->src, req->dst, req->nbytes);
+	return mtk_aes_dma(cryp, aes, req->src, req->dst, req->cryptlen);
 }
 
 static inline struct mtk_aes_ctr_ctx *
@@ -571,7 +572,7 @@ static int mtk_aes_ctr_transfer(struct mtk_cryp *cryp, struct mtk_aes_rec *aes)
 {
 	struct mtk_aes_base_ctx *ctx = aes->ctx;
 	struct mtk_aes_ctr_ctx *cctx = mtk_aes_ctr_ctx_cast(ctx);
-	struct ablkcipher_request *req = ablkcipher_request_cast(aes->areq);
+	struct skcipher_request *req = skcipher_request_cast(aes->areq);
 	struct scatterlist *src, *dst;
 	u32 start, end, ctr, blocks;
 	size_t datalen;
@@ -579,11 +580,11 @@ static int mtk_aes_ctr_transfer(struct mtk_cryp *cryp, struct mtk_aes_rec *aes)
 
 	/* Check for transfer completion. */
 	cctx->offset += aes->total;
-	if (cctx->offset >= req->nbytes)
+	if (cctx->offset >= req->cryptlen)
 		return mtk_aes_transfer_complete(cryp, aes);
 
 	/* Compute data length. */
-	datalen = req->nbytes - cctx->offset;
+	datalen = req->cryptlen - cctx->offset;
 	blocks = DIV_ROUND_UP(datalen, AES_BLOCK_SIZE);
 	ctr = be32_to_cpu(cctx->iv[3]);
 
@@ -620,12 +621,12 @@ static int mtk_aes_ctr_transfer(struct mtk_cryp *cryp, struct mtk_aes_rec *aes)
 static int mtk_aes_ctr_start(struct mtk_cryp *cryp, struct mtk_aes_rec *aes)
 {
 	struct mtk_aes_ctr_ctx *cctx = mtk_aes_ctr_ctx_cast(aes->ctx);
-	struct ablkcipher_request *req = ablkcipher_request_cast(aes->areq);
-	struct mtk_aes_reqctx *rctx = ablkcipher_request_ctx(req);
+	struct skcipher_request *req = skcipher_request_cast(aes->areq);
+	struct mtk_aes_reqctx *rctx = skcipher_request_ctx(req);
 
 	mtk_aes_set_mode(aes, rctx);
 
-	memcpy(cctx->iv, req->info, AES_BLOCK_SIZE);
+	memcpy(cctx->iv, req->iv, AES_BLOCK_SIZE);
 	cctx->offset = 0;
 	aes->total = 0;
 	aes->resume = mtk_aes_ctr_transfer;
@@ -634,10 +635,10 @@ static int mtk_aes_ctr_start(struct mtk_cryp *cryp, struct mtk_aes_rec *aes)
 }
 
 /* Check and set the AES key to transform state buffer */
-static int mtk_aes_setkey(struct crypto_ablkcipher *tfm,
+static int mtk_aes_setkey(struct crypto_skcipher *tfm,
 			  const u8 *key, u32 keylen)
 {
-	struct mtk_aes_base_ctx *ctx = crypto_ablkcipher_ctx(tfm);
+	struct mtk_aes_base_ctx *ctx = crypto_skcipher_ctx(tfm);
 
 	switch (keylen) {
 	case AES_KEYSIZE_128:
@@ -651,7 +652,7 @@ static int mtk_aes_setkey(struct crypto_ablkcipher *tfm,
 		break;
 
 	default:
-		crypto_ablkcipher_set_flags(tfm, CRYPTO_TFM_RES_BAD_KEY_LEN);
+		crypto_skcipher_set_flags(tfm, CRYPTO_TFM_RES_BAD_KEY_LEN);
 		return -EINVAL;
 	}
 
@@ -661,10 +662,10 @@ static int mtk_aes_setkey(struct crypto_ablkcipher *tfm,
 	return 0;
 }
 
-static int mtk_aes_crypt(struct ablkcipher_request *req, u64 mode)
+static int mtk_aes_crypt(struct skcipher_request *req, u64 mode)
 {
-	struct crypto_ablkcipher *ablkcipher = crypto_ablkcipher_reqtfm(req);
-	struct mtk_aes_base_ctx *ctx = crypto_ablkcipher_ctx(ablkcipher);
+	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
+	struct mtk_aes_base_ctx *ctx = crypto_skcipher_ctx(skcipher);
 	struct mtk_aes_reqctx *rctx;
 	struct mtk_cryp *cryp;
 
@@ -672,185 +673,168 @@ static int mtk_aes_crypt(struct ablkcipher_request *req, u64 mode)
 	if (!cryp)
 		return -ENODEV;
 
-	rctx = ablkcipher_request_ctx(req);
+	rctx = skcipher_request_ctx(req);
 	rctx->mode = mode;
 
 	return mtk_aes_handle_queue(cryp, !(mode & AES_FLAGS_ENCRYPT),
 				    &req->base);
 }
 
-static int mtk_aes_ecb_encrypt(struct ablkcipher_request *req)
+static int mtk_aes_ecb_encrypt(struct skcipher_request *req)
 {
 	return mtk_aes_crypt(req, AES_FLAGS_ENCRYPT | AES_FLAGS_ECB);
 }
 
-static int mtk_aes_ecb_decrypt(struct ablkcipher_request *req)
+static int mtk_aes_ecb_decrypt(struct skcipher_request *req)
 {
 	return mtk_aes_crypt(req, AES_FLAGS_ECB);
 }
 
-static int mtk_aes_cbc_encrypt(struct ablkcipher_request *req)
+static int mtk_aes_cbc_encrypt(struct skcipher_request *req)
 {
 	return mtk_aes_crypt(req, AES_FLAGS_ENCRYPT | AES_FLAGS_CBC);
 }
 
-static int mtk_aes_cbc_decrypt(struct ablkcipher_request *req)
+static int mtk_aes_cbc_decrypt(struct skcipher_request *req)
 {
 	return mtk_aes_crypt(req, AES_FLAGS_CBC);
 }
 
-static int mtk_aes_ctr_encrypt(struct ablkcipher_request *req)
+static int mtk_aes_ctr_encrypt(struct skcipher_request *req)
 {
 	return mtk_aes_crypt(req, AES_FLAGS_ENCRYPT | AES_FLAGS_CTR);
 }
 
-static int mtk_aes_ctr_decrypt(struct ablkcipher_request *req)
+static int mtk_aes_ctr_decrypt(struct skcipher_request *req)
 {
 	return mtk_aes_crypt(req, AES_FLAGS_CTR);
 }
 
-static int mtk_aes_ofb_encrypt(struct ablkcipher_request *req)
+static int mtk_aes_ofb_encrypt(struct skcipher_request *req)
 {
 	return mtk_aes_crypt(req, AES_FLAGS_ENCRYPT | AES_FLAGS_OFB);
 }
 
-static int mtk_aes_ofb_decrypt(struct ablkcipher_request *req)
+static int mtk_aes_ofb_decrypt(struct skcipher_request *req)
 {
 	return mtk_aes_crypt(req, AES_FLAGS_OFB);
 }
 
-static int mtk_aes_cfb_encrypt(struct ablkcipher_request *req)
+static int mtk_aes_cfb_encrypt(struct skcipher_request *req)
 {
 	return mtk_aes_crypt(req, AES_FLAGS_ENCRYPT | AES_FLAGS_CFB128);
 }
 
-static int mtk_aes_cfb_decrypt(struct ablkcipher_request *req)
+static int mtk_aes_cfb_decrypt(struct skcipher_request *req)
 {
 	return mtk_aes_crypt(req, AES_FLAGS_CFB128);
 }
 
-static int mtk_aes_cra_init(struct crypto_tfm *tfm)
+static int mtk_aes_init_tfm(struct crypto_skcipher *tfm)
 {
-	struct mtk_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct mtk_aes_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	tfm->crt_ablkcipher.reqsize = sizeof(struct mtk_aes_reqctx);
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct mtk_aes_reqctx));
 	ctx->base.start = mtk_aes_start;
 	return 0;
 }
 
-static int mtk_aes_ctr_cra_init(struct crypto_tfm *tfm)
+static int mtk_aes_ctr_init_tfm(struct crypto_skcipher *tfm)
 {
-	struct mtk_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct mtk_aes_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	tfm->crt_ablkcipher.reqsize = sizeof(struct mtk_aes_reqctx);
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct mtk_aes_reqctx));
 	ctx->base.start = mtk_aes_ctr_start;
 	return 0;
 }
 
-static struct crypto_alg aes_algs[] = {
+static struct skcipher_alg aes_algs[] = {
 {
-	.cra_name		= "cbc(aes)",
-	.cra_driver_name	= "cbc-aes-mtk",
-	.cra_priority		= 400,
-	.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER |
-				  CRYPTO_ALG_ASYNC,
-	.cra_init		= mtk_aes_cra_init,
-	.cra_blocksize		= AES_BLOCK_SIZE,
-	.cra_ctxsize		= sizeof(struct mtk_aes_ctx),
-	.cra_alignmask		= 0xf,
-	.cra_type		= &crypto_ablkcipher_type,
-	.cra_module		= THIS_MODULE,
-	.cra_u.ablkcipher = {
-		.min_keysize	= AES_MIN_KEY_SIZE,
-		.max_keysize	= AES_MAX_KEY_SIZE,
-		.setkey		= mtk_aes_setkey,
-		.encrypt	= mtk_aes_cbc_encrypt,
-		.decrypt	= mtk_aes_cbc_decrypt,
-		.ivsize		= AES_BLOCK_SIZE,
-	}
+	.base.cra_name		= "cbc(aes)",
+	.base.cra_driver_name	= "cbc-aes-mtk",
+	.base.cra_priority	= 400,
+	.base.cra_flags		= CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize	= AES_BLOCK_SIZE,
+	.base.cra_ctxsize	= sizeof(struct mtk_aes_ctx),
+	.base.cra_alignmask	= 0xf,
+	.base.cra_module	= THIS_MODULE,
+
+	.min_keysize		= AES_MIN_KEY_SIZE,
+	.max_keysize		= AES_MAX_KEY_SIZE,
+	.setkey			= mtk_aes_setkey,
+	.encrypt		= mtk_aes_cbc_encrypt,
+	.decrypt		= mtk_aes_cbc_decrypt,
+	.ivsize			= AES_BLOCK_SIZE,
+	.init			= mtk_aes_init_tfm,
 },
 {
-	.cra_name		= "ecb(aes)",
-	.cra_driver_name	= "ecb-aes-mtk",
-	.cra_priority		= 400,
-	.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER |
-				  CRYPTO_ALG_ASYNC,
-	.cra_init		= mtk_aes_cra_init,
-	.cra_blocksize		= AES_BLOCK_SIZE,
-	.cra_ctxsize		= sizeof(struct mtk_aes_ctx),
-	.cra_alignmask		= 0xf,
-	.cra_type		= &crypto_ablkcipher_type,
-	.cra_module		= THIS_MODULE,
-	.cra_u.ablkcipher = {
-		.min_keysize	= AES_MIN_KEY_SIZE,
-		.max_keysize	= AES_MAX_KEY_SIZE,
-		.setkey		= mtk_aes_setkey,
-		.encrypt	= mtk_aes_ecb_encrypt,
-		.decrypt	= mtk_aes_ecb_decrypt,
-	}
+	.base.cra_name		= "ecb(aes)",
+	.base.cra_driver_name	= "ecb-aes-mtk",
+	.base.cra_priority	= 400,
+	.base.cra_flags		= CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize	= AES_BLOCK_SIZE,
+	.base.cra_ctxsize	= sizeof(struct mtk_aes_ctx),
+	.base.cra_alignmask	= 0xf,
+	.base.cra_module	= THIS_MODULE,
+
+	.min_keysize		= AES_MIN_KEY_SIZE,
+	.max_keysize		= AES_MAX_KEY_SIZE,
+	.setkey			= mtk_aes_setkey,
+	.encrypt		= mtk_aes_ecb_encrypt,
+	.decrypt		= mtk_aes_ecb_decrypt,
+	.init			= mtk_aes_init_tfm,
 },
 {
-	.cra_name		= "ctr(aes)",
-	.cra_driver_name	= "ctr-aes-mtk",
-	.cra_priority		= 400,
-	.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER |
-				  CRYPTO_ALG_ASYNC,
-	.cra_init		= mtk_aes_ctr_cra_init,
-	.cra_blocksize		= 1,
-	.cra_ctxsize		= sizeof(struct mtk_aes_ctr_ctx),
-	.cra_alignmask		= 0xf,
-	.cra_type		= &crypto_ablkcipher_type,
-	.cra_module		= THIS_MODULE,
-	.cra_u.ablkcipher = {
-		.min_keysize	= AES_MIN_KEY_SIZE,
-		.max_keysize	= AES_MAX_KEY_SIZE,
-		.ivsize		= AES_BLOCK_SIZE,
-		.setkey		= mtk_aes_setkey,
-		.encrypt	= mtk_aes_ctr_encrypt,
-		.decrypt	= mtk_aes_ctr_decrypt,
-	}
+	.base.cra_name		= "ctr(aes)",
+	.base.cra_driver_name	= "ctr-aes-mtk",
+	.base.cra_priority	= 400,
+	.base.cra_flags		= CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize	= 1,
+	.base.cra_ctxsize	= sizeof(struct mtk_aes_ctx),
+	.base.cra_alignmask	= 0xf,
+	.base.cra_module	= THIS_MODULE,
+
+	.min_keysize		= AES_MIN_KEY_SIZE,
+	.max_keysize		= AES_MAX_KEY_SIZE,
+	.ivsize			= AES_BLOCK_SIZE,
+	.setkey			= mtk_aes_setkey,
+	.encrypt		= mtk_aes_ctr_encrypt,
+	.decrypt		= mtk_aes_ctr_decrypt,
+	.init			= mtk_aes_ctr_init_tfm,
 },
 {
-	.cra_name		= "ofb(aes)",
-	.cra_driver_name	= "ofb-aes-mtk",
-	.cra_priority		= 400,
-	.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER |
-				  CRYPTO_ALG_ASYNC,
-	.cra_init		= mtk_aes_cra_init,
-	.cra_blocksize		= 1,
-	.cra_ctxsize		= sizeof(struct mtk_aes_ctx),
-	.cra_alignmask		= 0xf,
-	.cra_type		= &crypto_ablkcipher_type,
-	.cra_module		= THIS_MODULE,
-	.cra_u.ablkcipher = {
-		.min_keysize	= AES_MIN_KEY_SIZE,
-		.max_keysize	= AES_MAX_KEY_SIZE,
-		.ivsize		= AES_BLOCK_SIZE,
-		.setkey		= mtk_aes_setkey,
-		.encrypt	= mtk_aes_ofb_encrypt,
-		.decrypt	= mtk_aes_ofb_decrypt,
-	}
+	.base.cra_name		= "ofb(aes)",
+	.base.cra_driver_name	= "ofb-aes-mtk",
+	.base.cra_priority	= 400,
+	.base.cra_flags		= CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize	= AES_BLOCK_SIZE,
+	.base.cra_ctxsize	= sizeof(struct mtk_aes_ctx),
+	.base.cra_alignmask	= 0xf,
+	.base.cra_module	= THIS_MODULE,
+
+	.min_keysize		= AES_MIN_KEY_SIZE,
+	.max_keysize		= AES_MAX_KEY_SIZE,
+	.ivsize			= AES_BLOCK_SIZE,
+	.setkey			= mtk_aes_setkey,
+	.encrypt		= mtk_aes_ofb_encrypt,
+	.decrypt		= mtk_aes_ofb_decrypt,
 },
 {
-	.cra_name		= "cfb(aes)",
-	.cra_driver_name	= "cfb-aes-mtk",
-	.cra_priority		= 400,
-	.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER |
-				  CRYPTO_ALG_ASYNC,
-	.cra_init		= mtk_aes_cra_init,
-	.cra_blocksize		= 1,
-	.cra_ctxsize		= sizeof(struct mtk_aes_ctx),
-	.cra_alignmask		= 0xf,
-	.cra_type		= &crypto_ablkcipher_type,
-	.cra_module		= THIS_MODULE,
-	.cra_u.ablkcipher = {
-		.min_keysize	= AES_MIN_KEY_SIZE,
-		.max_keysize	= AES_MAX_KEY_SIZE,
-		.ivsize		= AES_BLOCK_SIZE,
-		.setkey		= mtk_aes_setkey,
-		.encrypt	= mtk_aes_cfb_encrypt,
-		.decrypt	= mtk_aes_cfb_decrypt,
-	}
+	.base.cra_name		= "cfb(aes)",
+	.base.cra_driver_name	= "cfb-aes-mtk",
+	.base.cra_priority	= 400,
+	.base.cra_flags		= CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize	= 1,
+	.base.cra_ctxsize	= sizeof(struct mtk_aes_ctx),
+	.base.cra_alignmask	= 0xf,
+	.base.cra_module	= THIS_MODULE,
+
+	.min_keysize		= AES_MIN_KEY_SIZE,
+	.max_keysize		= AES_MAX_KEY_SIZE,
+	.ivsize			= AES_BLOCK_SIZE,
+	.setkey			= mtk_aes_setkey,
+	.encrypt		= mtk_aes_cfb_encrypt,
+	.decrypt		= mtk_aes_cfb_decrypt,
 },
 };
 
@@ -1259,7 +1243,7 @@ static void mtk_aes_unregister_algs(void)
 	crypto_unregister_aead(&aes_gcm_alg);
 
 	for (i = 0; i < ARRAY_SIZE(aes_algs); i++)
-		crypto_unregister_alg(&aes_algs[i]);
+		crypto_unregister_skcipher(&aes_algs[i]);
 }
 
 static int mtk_aes_register_algs(void)
@@ -1267,7 +1251,7 @@ static int mtk_aes_register_algs(void)
 	int err, i;
 
 	for (i = 0; i < ARRAY_SIZE(aes_algs); i++) {
-		err = crypto_register_alg(&aes_algs[i]);
+		err = crypto_register_skcipher(&aes_algs[i]);
 		if (err)
 			goto err_aes_algs;
 	}
@@ -1280,7 +1264,7 @@ static int mtk_aes_register_algs(void)
 
 err_aes_algs:
 	for (; i--; )
-		crypto_unregister_alg(&aes_algs[i]);
+		crypto_unregister_skcipher(&aes_algs[i]);
 
 	return err;
 }
-- 
2.20.1


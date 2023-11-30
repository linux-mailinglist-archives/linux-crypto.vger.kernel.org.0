Return-Path: <linux-crypto+bounces-416-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CBD7FEF5D
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Nov 2023 13:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9EBD1C20A33
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Nov 2023 12:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE7347A42
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Nov 2023 12:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE0BD4A
	for <linux-crypto@vger.kernel.org>; Thu, 30 Nov 2023 04:27:54 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r8g90-005IJH-CA; Thu, 30 Nov 2023 20:27:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 30 Nov 2023 20:27:59 +0800
From: "Herbert Xu" <herbert@gondor.apana.org.au>
Date: Thu, 30 Nov 2023 20:27:59 +0800
Subject: [PATCH 5/19] crypto: atmel - Remove cfb and ofb
References: <ZWh/nV+g46zhURa9@gondor.apana.org.au>
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Message-Id: <E1r8g90-005IJH-CA@formenos.hmeau.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

Remove the unused CFB/OFB implementation.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 drivers/crypto/atmel-aes.c  |  214 --------------------------------------------
 drivers/crypto/atmel-tdes.c |  205 +-----------------------------------------
 2 files changed, 8 insertions(+), 411 deletions(-)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index d1d93e897892..8bd64fc37e75 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -46,11 +46,6 @@
 #define ATMEL_AES_BUFFER_ORDER	2
 #define ATMEL_AES_BUFFER_SIZE	(PAGE_SIZE << ATMEL_AES_BUFFER_ORDER)
 
-#define CFB8_BLOCK_SIZE		1
-#define CFB16_BLOCK_SIZE	2
-#define CFB32_BLOCK_SIZE	4
-#define CFB64_BLOCK_SIZE	8
-
 #define SIZE_IN_WORDS(x)	((x) >> 2)
 
 /* AES flags */
@@ -60,12 +55,6 @@
 #define AES_FLAGS_OPMODE_MASK	(AES_MR_OPMOD_MASK | AES_MR_CFBS_MASK)
 #define AES_FLAGS_ECB		AES_MR_OPMOD_ECB
 #define AES_FLAGS_CBC		AES_MR_OPMOD_CBC
-#define AES_FLAGS_OFB		AES_MR_OPMOD_OFB
-#define AES_FLAGS_CFB128	(AES_MR_OPMOD_CFB | AES_MR_CFBS_128b)
-#define AES_FLAGS_CFB64		(AES_MR_OPMOD_CFB | AES_MR_CFBS_64b)
-#define AES_FLAGS_CFB32		(AES_MR_OPMOD_CFB | AES_MR_CFBS_32b)
-#define AES_FLAGS_CFB16		(AES_MR_OPMOD_CFB | AES_MR_CFBS_16b)
-#define AES_FLAGS_CFB8		(AES_MR_OPMOD_CFB | AES_MR_CFBS_8b)
 #define AES_FLAGS_CTR		AES_MR_OPMOD_CTR
 #define AES_FLAGS_GCM		AES_MR_OPMOD_GCM
 #define AES_FLAGS_XTS		AES_MR_OPMOD_XTS
@@ -87,7 +76,6 @@
 
 struct atmel_aes_caps {
 	bool			has_dualbuff;
-	bool			has_cfb64;
 	bool			has_gcm;
 	bool			has_xts;
 	bool			has_authenc;
@@ -860,22 +848,6 @@ static int atmel_aes_dma_start(struct atmel_aes_dev *dd,
 	int err;
 
 	switch (dd->ctx->block_size) {
-	case CFB8_BLOCK_SIZE:
-		addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-		maxburst = 1;
-		break;
-
-	case CFB16_BLOCK_SIZE:
-		addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
-		maxburst = 1;
-		break;
-
-	case CFB32_BLOCK_SIZE:
-	case CFB64_BLOCK_SIZE:
-		addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		maxburst = 1;
-		break;
-
 	case AES_BLOCK_SIZE:
 		addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 		maxburst = dd->caps.max_burst_size;
@@ -1103,7 +1075,7 @@ static int atmel_aes_crypt(struct skcipher_request *req, unsigned long mode)
 	}
 
 	/*
-	 * ECB, CBC, CFB, OFB or CTR mode require the plaintext and ciphertext
+	 * ECB, CBC or CTR mode require the plaintext and ciphertext
 	 * to have a positve integer length.
 	 */
 	if (!req->cryptlen && opmode != AES_FLAGS_XTS)
@@ -1113,27 +1085,7 @@ static int atmel_aes_crypt(struct skcipher_request *req, unsigned long mode)
 	    !IS_ALIGNED(req->cryptlen, crypto_skcipher_blocksize(skcipher)))
 		return -EINVAL;
 
-	switch (mode & AES_FLAGS_OPMODE_MASK) {
-	case AES_FLAGS_CFB8:
-		ctx->block_size = CFB8_BLOCK_SIZE;
-		break;
-
-	case AES_FLAGS_CFB16:
-		ctx->block_size = CFB16_BLOCK_SIZE;
-		break;
-
-	case AES_FLAGS_CFB32:
-		ctx->block_size = CFB32_BLOCK_SIZE;
-		break;
-
-	case AES_FLAGS_CFB64:
-		ctx->block_size = CFB64_BLOCK_SIZE;
-		break;
-
-	default:
-		ctx->block_size = AES_BLOCK_SIZE;
-		break;
-	}
+	ctx->block_size = AES_BLOCK_SIZE;
 	ctx->is_aead = false;
 
 	rctx = skcipher_request_ctx(req);
@@ -1188,66 +1140,6 @@ static int atmel_aes_cbc_decrypt(struct skcipher_request *req)
 	return atmel_aes_crypt(req, AES_FLAGS_CBC);
 }
 
-static int atmel_aes_ofb_encrypt(struct skcipher_request *req)
-{
-	return atmel_aes_crypt(req, AES_FLAGS_OFB | AES_FLAGS_ENCRYPT);
-}
-
-static int atmel_aes_ofb_decrypt(struct skcipher_request *req)
-{
-	return atmel_aes_crypt(req, AES_FLAGS_OFB);
-}
-
-static int atmel_aes_cfb_encrypt(struct skcipher_request *req)
-{
-	return atmel_aes_crypt(req, AES_FLAGS_CFB128 | AES_FLAGS_ENCRYPT);
-}
-
-static int atmel_aes_cfb_decrypt(struct skcipher_request *req)
-{
-	return atmel_aes_crypt(req, AES_FLAGS_CFB128);
-}
-
-static int atmel_aes_cfb64_encrypt(struct skcipher_request *req)
-{
-	return atmel_aes_crypt(req, AES_FLAGS_CFB64 | AES_FLAGS_ENCRYPT);
-}
-
-static int atmel_aes_cfb64_decrypt(struct skcipher_request *req)
-{
-	return atmel_aes_crypt(req, AES_FLAGS_CFB64);
-}
-
-static int atmel_aes_cfb32_encrypt(struct skcipher_request *req)
-{
-	return atmel_aes_crypt(req, AES_FLAGS_CFB32 | AES_FLAGS_ENCRYPT);
-}
-
-static int atmel_aes_cfb32_decrypt(struct skcipher_request *req)
-{
-	return atmel_aes_crypt(req, AES_FLAGS_CFB32);
-}
-
-static int atmel_aes_cfb16_encrypt(struct skcipher_request *req)
-{
-	return atmel_aes_crypt(req, AES_FLAGS_CFB16 | AES_FLAGS_ENCRYPT);
-}
-
-static int atmel_aes_cfb16_decrypt(struct skcipher_request *req)
-{
-	return atmel_aes_crypt(req, AES_FLAGS_CFB16);
-}
-
-static int atmel_aes_cfb8_encrypt(struct skcipher_request *req)
-{
-	return atmel_aes_crypt(req, AES_FLAGS_CFB8 | AES_FLAGS_ENCRYPT);
-}
-
-static int atmel_aes_cfb8_decrypt(struct skcipher_request *req)
-{
-	return atmel_aes_crypt(req, AES_FLAGS_CFB8);
-}
-
 static int atmel_aes_ctr_encrypt(struct skcipher_request *req)
 {
 	return atmel_aes_crypt(req, AES_FLAGS_CTR | AES_FLAGS_ENCRYPT);
@@ -1318,76 +1210,6 @@ static struct skcipher_alg aes_algs[] = {
 	.decrypt		= atmel_aes_cbc_decrypt,
 	.ivsize			= AES_BLOCK_SIZE,
 },
-{
-	.base.cra_name		= "ofb(aes)",
-	.base.cra_driver_name	= "atmel-ofb-aes",
-	.base.cra_blocksize	= 1,
-	.base.cra_ctxsize	= sizeof(struct atmel_aes_ctx),
-
-	.init			= atmel_aes_init_tfm,
-	.min_keysize		= AES_MIN_KEY_SIZE,
-	.max_keysize		= AES_MAX_KEY_SIZE,
-	.setkey			= atmel_aes_setkey,
-	.encrypt		= atmel_aes_ofb_encrypt,
-	.decrypt		= atmel_aes_ofb_decrypt,
-	.ivsize			= AES_BLOCK_SIZE,
-},
-{
-	.base.cra_name		= "cfb(aes)",
-	.base.cra_driver_name	= "atmel-cfb-aes",
-	.base.cra_blocksize	= 1,
-	.base.cra_ctxsize	= sizeof(struct atmel_aes_ctx),
-
-	.init			= atmel_aes_init_tfm,
-	.min_keysize		= AES_MIN_KEY_SIZE,
-	.max_keysize		= AES_MAX_KEY_SIZE,
-	.setkey			= atmel_aes_setkey,
-	.encrypt		= atmel_aes_cfb_encrypt,
-	.decrypt		= atmel_aes_cfb_decrypt,
-	.ivsize			= AES_BLOCK_SIZE,
-},
-{
-	.base.cra_name		= "cfb32(aes)",
-	.base.cra_driver_name	= "atmel-cfb32-aes",
-	.base.cra_blocksize	= CFB32_BLOCK_SIZE,
-	.base.cra_ctxsize	= sizeof(struct atmel_aes_ctx),
-
-	.init			= atmel_aes_init_tfm,
-	.min_keysize		= AES_MIN_KEY_SIZE,
-	.max_keysize		= AES_MAX_KEY_SIZE,
-	.setkey			= atmel_aes_setkey,
-	.encrypt		= atmel_aes_cfb32_encrypt,
-	.decrypt		= atmel_aes_cfb32_decrypt,
-	.ivsize			= AES_BLOCK_SIZE,
-},
-{
-	.base.cra_name		= "cfb16(aes)",
-	.base.cra_driver_name	= "atmel-cfb16-aes",
-	.base.cra_blocksize	= CFB16_BLOCK_SIZE,
-	.base.cra_ctxsize	= sizeof(struct atmel_aes_ctx),
-
-	.init			= atmel_aes_init_tfm,
-	.min_keysize		= AES_MIN_KEY_SIZE,
-	.max_keysize		= AES_MAX_KEY_SIZE,
-	.setkey			= atmel_aes_setkey,
-	.encrypt		= atmel_aes_cfb16_encrypt,
-	.decrypt		= atmel_aes_cfb16_decrypt,
-	.ivsize			= AES_BLOCK_SIZE,
-},
-{
-	.base.cra_name		= "cfb8(aes)",
-	.base.cra_driver_name	= "atmel-cfb8-aes",
-	.base.cra_blocksize	= CFB8_BLOCK_SIZE,
-	.base.cra_ctxsize	= sizeof(struct atmel_aes_ctx),
-
-	.init			= atmel_aes_init_tfm,
-	.min_keysize		= AES_MIN_KEY_SIZE,
-	.max_keysize		= AES_MAX_KEY_SIZE,
-	.setkey			= atmel_aes_setkey,
-	.encrypt		= atmel_aes_cfb8_encrypt,
-	.decrypt		= atmel_aes_cfb8_decrypt,
-	.ivsize			= AES_BLOCK_SIZE,
-},
 {
 	.base.cra_name		= "ctr(aes)",
 	.base.cra_driver_name	= "atmel-ctr-aes",
@@ -1404,21 +1226,6 @@ static struct skcipher_alg aes_algs[] = {
 },
 };
 
-static struct skcipher_alg aes_cfb64_alg = {
-	.base.cra_name		= "cfb64(aes)",
-	.base.cra_driver_name	= "atmel-cfb64-aes",
-	.base.cra_blocksize	= CFB64_BLOCK_SIZE,
-	.base.cra_ctxsize	= sizeof(struct atmel_aes_ctx),
-
-	.init			= atmel_aes_init_tfm,
-	.min_keysize		= AES_MIN_KEY_SIZE,
-	.max_keysize		= AES_MAX_KEY_SIZE,
-	.setkey			= atmel_aes_setkey,
-	.encrypt		= atmel_aes_cfb64_encrypt,
-	.decrypt		= atmel_aes_cfb64_decrypt,
-	.ivsize			= AES_BLOCK_SIZE,
-};
-
 
 /* gcm aead functions */
 
@@ -2407,9 +2214,6 @@ static void atmel_aes_unregister_algs(struct atmel_aes_dev *dd)
 	if (dd->caps.has_gcm)
 		crypto_unregister_aead(&aes_gcm_alg);
 
-	if (dd->caps.has_cfb64)
-		crypto_unregister_skcipher(&aes_cfb64_alg);
-
 	for (i = 0; i < ARRAY_SIZE(aes_algs); i++)
 		crypto_unregister_skcipher(&aes_algs[i]);
 }
@@ -2434,14 +2238,6 @@ static int atmel_aes_register_algs(struct atmel_aes_dev *dd)
 			goto err_aes_algs;
 	}
 
-	if (dd->caps.has_cfb64) {
-		atmel_aes_crypto_alg_init(&aes_cfb64_alg.base);
-
-		err = crypto_register_skcipher(&aes_cfb64_alg);
-		if (err)
-			goto err_aes_cfb64_alg;
-	}
-
 	if (dd->caps.has_gcm) {
 		atmel_aes_crypto_alg_init(&aes_gcm_alg.base);
 
@@ -2482,8 +2278,6 @@ static int atmel_aes_register_algs(struct atmel_aes_dev *dd)
 err_aes_xts_alg:
 	crypto_unregister_aead(&aes_gcm_alg);
 err_aes_gcm_alg:
-	crypto_unregister_skcipher(&aes_cfb64_alg);
-err_aes_cfb64_alg:
 	i = ARRAY_SIZE(aes_algs);
 err_aes_algs:
 	for (j = 0; j < i; j++)
@@ -2495,7 +2289,6 @@ static int atmel_aes_register_algs(struct atmel_aes_dev *dd)
 static void atmel_aes_get_cap(struct atmel_aes_dev *dd)
 {
 	dd->caps.has_dualbuff = 0;
-	dd->caps.has_cfb64 = 0;
 	dd->caps.has_gcm = 0;
 	dd->caps.has_xts = 0;
 	dd->caps.has_authenc = 0;
@@ -2507,7 +2300,6 @@ static void atmel_aes_get_cap(struct atmel_aes_dev *dd)
 	case 0x600:
 	case 0x500:
 		dd->caps.has_dualbuff = 1;
-		dd->caps.has_cfb64 = 1;
 		dd->caps.has_gcm = 1;
 		dd->caps.has_xts = 1;
 		dd->caps.has_authenc = 1;
@@ -2515,13 +2307,11 @@ static void atmel_aes_get_cap(struct atmel_aes_dev *dd)
 		break;
 	case 0x200:
 		dd->caps.has_dualbuff = 1;
-		dd->caps.has_cfb64 = 1;
 		dd->caps.has_gcm = 1;
 		dd->caps.max_burst_size = 4;
 		break;
 	case 0x130:
 		dd->caps.has_dualbuff = 1;
-		dd->caps.has_cfb64 = 1;
 		dd->caps.max_burst_size = 4;
 		break;
 	case 0x120:
diff --git a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
index 27b7000e25bc..dcc2380a5889 100644
--- a/drivers/crypto/atmel-tdes.c
+++ b/drivers/crypto/atmel-tdes.c
@@ -45,11 +45,6 @@
 #define TDES_FLAGS_OPMODE_MASK	(TDES_MR_OPMOD_MASK | TDES_MR_CFBS_MASK)
 #define TDES_FLAGS_ECB		TDES_MR_OPMOD_ECB
 #define TDES_FLAGS_CBC		TDES_MR_OPMOD_CBC
-#define TDES_FLAGS_OFB		TDES_MR_OPMOD_OFB
-#define TDES_FLAGS_CFB64	(TDES_MR_OPMOD_CFB | TDES_MR_CFBS_64b)
-#define TDES_FLAGS_CFB32	(TDES_MR_OPMOD_CFB | TDES_MR_CFBS_32b)
-#define TDES_FLAGS_CFB16	(TDES_MR_OPMOD_CFB | TDES_MR_CFBS_16b)
-#define TDES_FLAGS_CFB8		(TDES_MR_OPMOD_CFB | TDES_MR_CFBS_8b)
 
 #define TDES_FLAGS_MODE_MASK	(TDES_FLAGS_OPMODE_MASK | TDES_FLAGS_ENCRYPT)
 
@@ -60,13 +55,8 @@
 
 #define ATMEL_TDES_QUEUE_LENGTH	50
 
-#define CFB8_BLOCK_SIZE		1
-#define CFB16_BLOCK_SIZE	2
-#define CFB32_BLOCK_SIZE	4
-
 struct atmel_tdes_caps {
 	bool	has_dma;
-	u32		has_cfb_3keys;
 };
 
 struct atmel_tdes_dev;
@@ -376,7 +366,6 @@ static int atmel_tdes_crypt_pdc(struct atmel_tdes_dev *dd,
 				dma_addr_t dma_addr_in,
 				dma_addr_t dma_addr_out, int length)
 {
-	struct atmel_tdes_reqctx *rctx = skcipher_request_ctx(dd->req);
 	int len32;
 
 	dd->dma_size = length;
@@ -386,19 +375,7 @@ static int atmel_tdes_crypt_pdc(struct atmel_tdes_dev *dd,
 					   DMA_TO_DEVICE);
 	}
 
-	switch (rctx->mode & TDES_FLAGS_OPMODE_MASK) {
-	case TDES_FLAGS_CFB8:
-		len32 = DIV_ROUND_UP(length, sizeof(u8));
-		break;
-
-	case TDES_FLAGS_CFB16:
-		len32 = DIV_ROUND_UP(length, sizeof(u16));
-		break;
-
-	default:
-		len32 = DIV_ROUND_UP(length, sizeof(u32));
-		break;
-	}
+	len32 = DIV_ROUND_UP(length, sizeof(u32));
 
 	atmel_tdes_write(dd, TDES_PTCR, TDES_PTCR_TXTDIS|TDES_PTCR_RXTDIS);
 	atmel_tdes_write(dd, TDES_TPR, dma_addr_in);
@@ -419,7 +396,6 @@ static int atmel_tdes_crypt_dma(struct atmel_tdes_dev *dd,
 				dma_addr_t dma_addr_in,
 				dma_addr_t dma_addr_out, int length)
 {
-	struct atmel_tdes_reqctx *rctx = skcipher_request_ctx(dd->req);
 	struct scatterlist sg[2];
 	struct dma_async_tx_descriptor	*in_desc, *out_desc;
 	enum dma_slave_buswidth addr_width;
@@ -431,19 +407,7 @@ static int atmel_tdes_crypt_dma(struct atmel_tdes_dev *dd,
 					   DMA_TO_DEVICE);
 	}
 
-	switch (rctx->mode & TDES_FLAGS_OPMODE_MASK) {
-	case TDES_FLAGS_CFB8:
-		addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-		break;
-
-	case TDES_FLAGS_CFB16:
-		addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
-		break;
-
-	default:
-		addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		break;
-	}
+	addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
 	dd->dma_lch_in.dma_conf.dst_addr_width = addr_width;
 	dd->dma_lch_out.dma_conf.src_addr_width = addr_width;
@@ -680,39 +644,11 @@ static int atmel_tdes_crypt(struct skcipher_request *req, unsigned long mode)
 	if (!req->cryptlen)
 		return 0;
 
-	switch (mode & TDES_FLAGS_OPMODE_MASK) {
-	case TDES_FLAGS_CFB8:
-		if (!IS_ALIGNED(req->cryptlen, CFB8_BLOCK_SIZE)) {
-			dev_dbg(dev, "request size is not exact amount of CFB8 blocks\n");
-			return -EINVAL;
-		}
-		ctx->block_size = CFB8_BLOCK_SIZE;
-		break;
-
-	case TDES_FLAGS_CFB16:
-		if (!IS_ALIGNED(req->cryptlen, CFB16_BLOCK_SIZE)) {
-			dev_dbg(dev, "request size is not exact amount of CFB16 blocks\n");
-			return -EINVAL;
-		}
-		ctx->block_size = CFB16_BLOCK_SIZE;
-		break;
-
-	case TDES_FLAGS_CFB32:
-		if (!IS_ALIGNED(req->cryptlen, CFB32_BLOCK_SIZE)) {
-			dev_dbg(dev, "request size is not exact amount of CFB32 blocks\n");
-			return -EINVAL;
-		}
-		ctx->block_size = CFB32_BLOCK_SIZE;
-		break;
-
-	default:
-		if (!IS_ALIGNED(req->cryptlen, DES_BLOCK_SIZE)) {
-			dev_dbg(dev, "request size is not exact amount of DES blocks\n");
-			return -EINVAL;
-		}
-		ctx->block_size = DES_BLOCK_SIZE;
-		break;
+	if (!IS_ALIGNED(req->cryptlen, DES_BLOCK_SIZE)) {
+		dev_dbg(dev, "request size is not exact amount of DES blocks\n");
+		return -EINVAL;
 	}
+	ctx->block_size = DES_BLOCK_SIZE;
 
 	rctx->mode = mode;
 
@@ -832,55 +768,6 @@ static int atmel_tdes_cbc_decrypt(struct skcipher_request *req)
 {
 	return atmel_tdes_crypt(req, TDES_FLAGS_CBC);
 }
-static int atmel_tdes_cfb_encrypt(struct skcipher_request *req)
-{
-	return atmel_tdes_crypt(req, TDES_FLAGS_CFB64 | TDES_FLAGS_ENCRYPT);
-}
-
-static int atmel_tdes_cfb_decrypt(struct skcipher_request *req)
-{
-	return atmel_tdes_crypt(req, TDES_FLAGS_CFB64);
-}
-
-static int atmel_tdes_cfb8_encrypt(struct skcipher_request *req)
-{
-	return atmel_tdes_crypt(req, TDES_FLAGS_CFB8 | TDES_FLAGS_ENCRYPT);
-}
-
-static int atmel_tdes_cfb8_decrypt(struct skcipher_request *req)
-{
-	return atmel_tdes_crypt(req, TDES_FLAGS_CFB8);
-}
-
-static int atmel_tdes_cfb16_encrypt(struct skcipher_request *req)
-{
-	return atmel_tdes_crypt(req, TDES_FLAGS_CFB16 | TDES_FLAGS_ENCRYPT);
-}
-
-static int atmel_tdes_cfb16_decrypt(struct skcipher_request *req)
-{
-	return atmel_tdes_crypt(req, TDES_FLAGS_CFB16);
-}
-
-static int atmel_tdes_cfb32_encrypt(struct skcipher_request *req)
-{
-	return atmel_tdes_crypt(req, TDES_FLAGS_CFB32 | TDES_FLAGS_ENCRYPT);
-}
-
-static int atmel_tdes_cfb32_decrypt(struct skcipher_request *req)
-{
-	return atmel_tdes_crypt(req, TDES_FLAGS_CFB32);
-}
-
-static int atmel_tdes_ofb_encrypt(struct skcipher_request *req)
-{
-	return atmel_tdes_crypt(req, TDES_FLAGS_OFB | TDES_FLAGS_ENCRYPT);
-}
-
-static int atmel_tdes_ofb_decrypt(struct skcipher_request *req)
-{
-	return atmel_tdes_crypt(req, TDES_FLAGS_OFB);
-}
 
 static int atmel_tdes_init_tfm(struct crypto_skcipher *tfm)
 {
@@ -931,71 +818,6 @@ static struct skcipher_alg tdes_algs[] = {
 	.encrypt		= atmel_tdes_cbc_encrypt,
 	.decrypt		= atmel_tdes_cbc_decrypt,
 },
-{
-	.base.cra_name		= "cfb(des)",
-	.base.cra_driver_name	= "atmel-cfb-des",
-	.base.cra_blocksize	= DES_BLOCK_SIZE,
-	.base.cra_alignmask	= 0x7,
-
-	.min_keysize		= DES_KEY_SIZE,
-	.max_keysize		= DES_KEY_SIZE,
-	.ivsize			= DES_BLOCK_SIZE,
-	.setkey			= atmel_des_setkey,
-	.encrypt		= atmel_tdes_cfb_encrypt,
-	.decrypt		= atmel_tdes_cfb_decrypt,
-},
-{
-	.base.cra_name		= "cfb8(des)",
-	.base.cra_driver_name	= "atmel-cfb8-des",
-	.base.cra_blocksize	= CFB8_BLOCK_SIZE,
-	.base.cra_alignmask	= 0,
-
-	.min_keysize		= DES_KEY_SIZE,
-	.max_keysize		= DES_KEY_SIZE,
-	.ivsize			= DES_BLOCK_SIZE,
-	.setkey			= atmel_des_setkey,
-	.encrypt		= atmel_tdes_cfb8_encrypt,
-	.decrypt		= atmel_tdes_cfb8_decrypt,
-},
-{
-	.base.cra_name		= "cfb16(des)",
-	.base.cra_driver_name	= "atmel-cfb16-des",
-	.base.cra_blocksize	= CFB16_BLOCK_SIZE,
-	.base.cra_alignmask	= 0x1,
-
-	.min_keysize		= DES_KEY_SIZE,
-	.max_keysize		= DES_KEY_SIZE,
-	.ivsize			= DES_BLOCK_SIZE,
-	.setkey			= atmel_des_setkey,
-	.encrypt		= atmel_tdes_cfb16_encrypt,
-	.decrypt		= atmel_tdes_cfb16_decrypt,
-},
-{
-	.base.cra_name		= "cfb32(des)",
-	.base.cra_driver_name	= "atmel-cfb32-des",
-	.base.cra_blocksize	= CFB32_BLOCK_SIZE,
-	.base.cra_alignmask	= 0x3,
-
-	.min_keysize		= DES_KEY_SIZE,
-	.max_keysize		= DES_KEY_SIZE,
-	.ivsize			= DES_BLOCK_SIZE,
-	.setkey			= atmel_des_setkey,
-	.encrypt		= atmel_tdes_cfb32_encrypt,
-	.decrypt		= atmel_tdes_cfb32_decrypt,
-},
-{
-	.base.cra_name		= "ofb(des)",
-	.base.cra_driver_name	= "atmel-ofb-des",
-	.base.cra_blocksize	= 1,
-	.base.cra_alignmask	= 0x7,
-
-	.min_keysize		= DES_KEY_SIZE,
-	.max_keysize		= DES_KEY_SIZE,
-	.ivsize			= DES_BLOCK_SIZE,
-	.setkey			= atmel_des_setkey,
-	.encrypt		= atmel_tdes_ofb_encrypt,
-	.decrypt		= atmel_tdes_ofb_decrypt,
-},
 {
 	.base.cra_name		= "ecb(des3_ede)",
 	.base.cra_driver_name	= "atmel-ecb-tdes",
@@ -1021,19 +843,6 @@ static struct skcipher_alg tdes_algs[] = {
 	.decrypt		= atmel_tdes_cbc_decrypt,
 	.ivsize			= DES_BLOCK_SIZE,
 },
-{
-	.base.cra_name		= "ofb(des3_ede)",
-	.base.cra_driver_name	= "atmel-ofb-tdes",
-	.base.cra_blocksize	= DES_BLOCK_SIZE,
-	.base.cra_alignmask	= 0x7,
-
-	.min_keysize		= DES3_EDE_KEY_SIZE,
-	.max_keysize		= DES3_EDE_KEY_SIZE,
-	.setkey			= atmel_tdes_setkey,
-	.encrypt		= atmel_tdes_ofb_encrypt,
-	.decrypt		= atmel_tdes_ofb_decrypt,
-	.ivsize			= DES_BLOCK_SIZE,
-},
 };
 
 static void atmel_tdes_queue_task(unsigned long data)
@@ -1121,14 +930,12 @@ static void atmel_tdes_get_cap(struct atmel_tdes_dev *dd)
 {
 
 	dd->caps.has_dma = 0;
-	dd->caps.has_cfb_3keys = 0;
 
 	/* keep only major version number */
 	switch (dd->hw_version & 0xf00) {
 	case 0x800:
 	case 0x700:
 		dd->caps.has_dma = 1;
-		dd->caps.has_cfb_3keys = 1;
 		break;
 	case 0x600:
 		break;


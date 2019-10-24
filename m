Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B07AE33F1
	for <lists+linux-crypto@lfdr.de>; Thu, 24 Oct 2019 15:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731940AbfJXNYJ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 24 Oct 2019 09:24:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37870 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387593AbfJXNYI (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 24 Oct 2019 09:24:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id q130so2429185wme.2
        for <linux-crypto@vger.kernel.org>; Thu, 24 Oct 2019 06:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mc2WnweIaRtDafmlV+b5kd5/545ymLu8iFRfFqG/ZGs=;
        b=gwmxMfqOuK/AkoUT2NsJbgOEJ10J+0blvqaG8wdGFBWU7ThKf2TAegGuDFPnimRXEU
         NlNfjYSUl1gb3ofZ0kySStBhkM070vr+ZtlGkAiUfqpjAGSjsK7av6WCNM5JOJnJrXXU
         Va0mbJhP7wu/xExkmk8tdTkdkpfBh6rCcmzO7SIOGtk0xNiErDfjgJ3njVb2LkqQrc3r
         VaxFQ0YM+Uyox5+uNduXv4p9mV46FPVBNb5Oi3yRqqvANCE+1nodCdaH309wl/5Vz/nk
         eemWvNLdxV14zdfEcnL7+H7e+DLarq5cbFStaCMQ0pPvRZjc/SrLHjW57MD4Gpt2ZuHv
         +aYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mc2WnweIaRtDafmlV+b5kd5/545ymLu8iFRfFqG/ZGs=;
        b=cEX0JJ2uMyHRfdm5Y5ls0qvKbQYcnuBTs20dSyFxijirU5+U7hOpxJ3TxA8dkSl+7P
         gV6G3NFyxQo0uvcjBXHFAlhJaA2w88dN5z76FgkNK6truMjWfaBjljFz81F/Lwg3Pq5R
         OyEcvDuJwrDP9h1MlfvBP5ImJNcl3r0wHQHaR8SGmEFzXBwyHAmnvBFQkOOA3L9SBxmz
         9v6axkpQWhyxyDzO/JjpZmu2b/PV5cnEge8VbzmKXoPgQYzfllitCwHkZiFAVgnTFoz7
         2V5uQGEZIpUY7K92Sc/+XeZDq7o8W5Rh4wGbR7nwXDJtE0RgAdAXZtlUTHaHr2O1Awt+
         lJhg==
X-Gm-Message-State: APjAAAW+pi013zv+X5fEe0Y13+oCY4a7yzDXIf2uxgmAmrsOuGddv0N7
        u6d3LO5ryoEB0KpoT50A5NogOJhJ5rnoVU7Q
X-Google-Smtp-Source: APXvYqx+U6iyGF4NuMqJjOPQBjBgswbNGE8WPgUedfhjqWwTNvaTOMUvhtKo6fQIS9H+FkWc+jpz+Q==
X-Received: by 2002:a1c:67d7:: with SMTP id b206mr4803243wmc.68.1571923444629;
        Thu, 24 Oct 2019 06:24:04 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
        by smtp.gmail.com with ESMTPSA id e3sm2346310wme.36.2019.10.24.06.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 06:24:03 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH v2 08/27] crypto: atmel-aes - switch to skcipher API
Date:   Thu, 24 Oct 2019 15:23:26 +0200
Message-Id: <20191024132345.5236-9-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024132345.5236-1-ard.biesheuvel@linaro.org>
References: <20191024132345.5236-1-ard.biesheuvel@linaro.org>
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

Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/crypto/atmel-aes.c | 509 ++++++++++----------
 1 file changed, 245 insertions(+), 264 deletions(-)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index 00920a2b95ce..28e420ffd4f5 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -36,6 +36,7 @@
 #include <crypto/gcm.h>
 #include <crypto/xts.h>
 #include <crypto/internal/aead.h>
+#include <crypto/internal/skcipher.h>
 #include <linux/platform_data/crypto-atmel.h>
 #include <dt-bindings/dma/at91.h>
 #include "atmel-aes-regs.h"
@@ -492,23 +493,23 @@ static void atmel_aes_authenc_complete(struct atmel_aes_dev *dd, int err);
 
 static void atmel_aes_set_iv_as_last_ciphertext_block(struct atmel_aes_dev *dd)
 {
-	struct ablkcipher_request *req = ablkcipher_request_cast(dd->areq);
-	struct atmel_aes_reqctx *rctx = ablkcipher_request_ctx(req);
-	struct crypto_ablkcipher *ablkcipher = crypto_ablkcipher_reqtfm(req);
-	unsigned int ivsize = crypto_ablkcipher_ivsize(ablkcipher);
+	struct skcipher_request *req = skcipher_request_cast(dd->areq);
+	struct atmel_aes_reqctx *rctx = skcipher_request_ctx(req);
+	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
+	unsigned int ivsize = crypto_skcipher_ivsize(skcipher);
 
-	if (req->nbytes < ivsize)
+	if (req->cryptlen < ivsize)
 		return;
 
 	if (rctx->mode & AES_FLAGS_ENCRYPT) {
-		scatterwalk_map_and_copy(req->info, req->dst,
-					 req->nbytes - ivsize, ivsize, 0);
+		scatterwalk_map_and_copy(req->iv, req->dst,
+					 req->cryptlen - ivsize, ivsize, 0);
 	} else {
 		if (req->src == req->dst)
-			memcpy(req->info, rctx->lastc, ivsize);
+			memcpy(req->iv, rctx->lastc, ivsize);
 		else
-			scatterwalk_map_and_copy(req->info, req->src,
-						 req->nbytes - ivsize,
+			scatterwalk_map_and_copy(req->iv, req->src,
+						 req->cryptlen - ivsize,
 						 ivsize, 0);
 	}
 }
@@ -981,9 +982,9 @@ static int atmel_aes_transfer_complete(struct atmel_aes_dev *dd)
 
 static int atmel_aes_start(struct atmel_aes_dev *dd)
 {
-	struct ablkcipher_request *req = ablkcipher_request_cast(dd->areq);
-	struct atmel_aes_reqctx *rctx = ablkcipher_request_ctx(req);
-	bool use_dma = (req->nbytes >= ATMEL_AES_DMA_THRESHOLD ||
+	struct skcipher_request *req = skcipher_request_cast(dd->areq);
+	struct atmel_aes_reqctx *rctx = skcipher_request_ctx(req);
+	bool use_dma = (req->cryptlen >= ATMEL_AES_DMA_THRESHOLD ||
 			dd->ctx->block_size != AES_BLOCK_SIZE);
 	int err;
 
@@ -993,12 +994,12 @@ static int atmel_aes_start(struct atmel_aes_dev *dd)
 	if (err)
 		return atmel_aes_complete(dd, err);
 
-	atmel_aes_write_ctrl(dd, use_dma, req->info);
+	atmel_aes_write_ctrl(dd, use_dma, (void *)req->iv);
 	if (use_dma)
-		return atmel_aes_dma_start(dd, req->src, req->dst, req->nbytes,
+		return atmel_aes_dma_start(dd, req->src, req->dst, req->cryptlen,
 					   atmel_aes_transfer_complete);
 
-	return atmel_aes_cpu_start(dd, req->src, req->dst, req->nbytes,
+	return atmel_aes_cpu_start(dd, req->src, req->dst, req->cryptlen,
 				   atmel_aes_transfer_complete);
 }
 
@@ -1011,7 +1012,7 @@ atmel_aes_ctr_ctx_cast(struct atmel_aes_base_ctx *ctx)
 static int atmel_aes_ctr_transfer(struct atmel_aes_dev *dd)
 {
 	struct atmel_aes_ctr_ctx *ctx = atmel_aes_ctr_ctx_cast(dd->ctx);
-	struct ablkcipher_request *req = ablkcipher_request_cast(dd->areq);
+	struct skcipher_request *req = skcipher_request_cast(dd->areq);
 	struct scatterlist *src, *dst;
 	u32 ctr, blocks;
 	size_t datalen;
@@ -1019,11 +1020,11 @@ static int atmel_aes_ctr_transfer(struct atmel_aes_dev *dd)
 
 	/* Check for transfer completion. */
 	ctx->offset += dd->total;
-	if (ctx->offset >= req->nbytes)
+	if (ctx->offset >= req->cryptlen)
 		return atmel_aes_transfer_complete(dd);
 
 	/* Compute data length. */
-	datalen = req->nbytes - ctx->offset;
+	datalen = req->cryptlen - ctx->offset;
 	blocks = DIV_ROUND_UP(datalen, AES_BLOCK_SIZE);
 	ctr = be32_to_cpu(ctx->iv[3]);
 	if (dd->caps.has_ctr32) {
@@ -1076,8 +1077,8 @@ static int atmel_aes_ctr_transfer(struct atmel_aes_dev *dd)
 static int atmel_aes_ctr_start(struct atmel_aes_dev *dd)
 {
 	struct atmel_aes_ctr_ctx *ctx = atmel_aes_ctr_ctx_cast(dd->ctx);
-	struct ablkcipher_request *req = ablkcipher_request_cast(dd->areq);
-	struct atmel_aes_reqctx *rctx = ablkcipher_request_ctx(req);
+	struct skcipher_request *req = skcipher_request_cast(dd->areq);
+	struct atmel_aes_reqctx *rctx = skcipher_request_ctx(req);
 	int err;
 
 	atmel_aes_set_mode(dd, rctx);
@@ -1086,16 +1087,16 @@ static int atmel_aes_ctr_start(struct atmel_aes_dev *dd)
 	if (err)
 		return atmel_aes_complete(dd, err);
 
-	memcpy(ctx->iv, req->info, AES_BLOCK_SIZE);
+	memcpy(ctx->iv, req->iv, AES_BLOCK_SIZE);
 	ctx->offset = 0;
 	dd->total = 0;
 	return atmel_aes_ctr_transfer(dd);
 }
 
-static int atmel_aes_crypt(struct ablkcipher_request *req, unsigned long mode)
+static int atmel_aes_crypt(struct skcipher_request *req, unsigned long mode)
 {
-	struct crypto_ablkcipher *ablkcipher = crypto_ablkcipher_reqtfm(req);
-	struct atmel_aes_base_ctx *ctx = crypto_ablkcipher_ctx(ablkcipher);
+	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
+	struct atmel_aes_base_ctx *ctx = crypto_skcipher_ctx(skcipher);
 	struct atmel_aes_reqctx *rctx;
 	struct atmel_aes_dev *dd;
 
@@ -1126,30 +1127,30 @@ static int atmel_aes_crypt(struct ablkcipher_request *req, unsigned long mode)
 	if (!dd)
 		return -ENODEV;
 
-	rctx = ablkcipher_request_ctx(req);
+	rctx = skcipher_request_ctx(req);
 	rctx->mode = mode;
 
 	if (!(mode & AES_FLAGS_ENCRYPT) && (req->src == req->dst)) {
-		unsigned int ivsize = crypto_ablkcipher_ivsize(ablkcipher);
+		unsigned int ivsize = crypto_skcipher_ivsize(skcipher);
 
-		if (req->nbytes >= ivsize)
+		if (req->cryptlen >= ivsize)
 			scatterwalk_map_and_copy(rctx->lastc, req->src,
-						 req->nbytes - ivsize,
+						 req->cryptlen - ivsize,
 						 ivsize, 0);
 	}
 
 	return atmel_aes_handle_queue(dd, &req->base);
 }
 
-static int atmel_aes_setkey(struct crypto_ablkcipher *tfm, const u8 *key,
+static int atmel_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			   unsigned int keylen)
 {
-	struct atmel_aes_base_ctx *ctx = crypto_ablkcipher_ctx(tfm);
+	struct atmel_aes_base_ctx *ctx = crypto_skcipher_ctx(tfm);
 
 	if (keylen != AES_KEYSIZE_128 &&
 	    keylen != AES_KEYSIZE_192 &&
 	    keylen != AES_KEYSIZE_256) {
-		crypto_ablkcipher_set_flags(tfm, CRYPTO_TFM_RES_BAD_KEY_LEN);
+		crypto_skcipher_set_flags(tfm, CRYPTO_TFM_RES_BAD_KEY_LEN);
 		return -EINVAL;
 	}
 
@@ -1159,297 +1160,279 @@ static int atmel_aes_setkey(struct crypto_ablkcipher *tfm, const u8 *key,
 	return 0;
 }
 
-static int atmel_aes_ecb_encrypt(struct ablkcipher_request *req)
+static int atmel_aes_ecb_encrypt(struct skcipher_request *req)
 {
 	return atmel_aes_crypt(req, AES_FLAGS_ECB | AES_FLAGS_ENCRYPT);
 }
 
-static int atmel_aes_ecb_decrypt(struct ablkcipher_request *req)
+static int atmel_aes_ecb_decrypt(struct skcipher_request *req)
 {
 	return atmel_aes_crypt(req, AES_FLAGS_ECB);
 }
 
-static int atmel_aes_cbc_encrypt(struct ablkcipher_request *req)
+static int atmel_aes_cbc_encrypt(struct skcipher_request *req)
 {
 	return atmel_aes_crypt(req, AES_FLAGS_CBC | AES_FLAGS_ENCRYPT);
 }
 
-static int atmel_aes_cbc_decrypt(struct ablkcipher_request *req)
+static int atmel_aes_cbc_decrypt(struct skcipher_request *req)
 {
 	return atmel_aes_crypt(req, AES_FLAGS_CBC);
 }
 
-static int atmel_aes_ofb_encrypt(struct ablkcipher_request *req)
+static int atmel_aes_ofb_encrypt(struct skcipher_request *req)
 {
 	return atmel_aes_crypt(req, AES_FLAGS_OFB | AES_FLAGS_ENCRYPT);
 }
 
-static int atmel_aes_ofb_decrypt(struct ablkcipher_request *req)
+static int atmel_aes_ofb_decrypt(struct skcipher_request *req)
 {
 	return atmel_aes_crypt(req, AES_FLAGS_OFB);
 }
 
-static int atmel_aes_cfb_encrypt(struct ablkcipher_request *req)
+static int atmel_aes_cfb_encrypt(struct skcipher_request *req)
 {
 	return atmel_aes_crypt(req, AES_FLAGS_CFB128 | AES_FLAGS_ENCRYPT);
 }
 
-static int atmel_aes_cfb_decrypt(struct ablkcipher_request *req)
+static int atmel_aes_cfb_decrypt(struct skcipher_request *req)
 {
 	return atmel_aes_crypt(req, AES_FLAGS_CFB128);
 }
 
-static int atmel_aes_cfb64_encrypt(struct ablkcipher_request *req)
+static int atmel_aes_cfb64_encrypt(struct skcipher_request *req)
 {
 	return atmel_aes_crypt(req, AES_FLAGS_CFB64 | AES_FLAGS_ENCRYPT);
 }
 
-static int atmel_aes_cfb64_decrypt(struct ablkcipher_request *req)
+static int atmel_aes_cfb64_decrypt(struct skcipher_request *req)
 {
 	return atmel_aes_crypt(req, AES_FLAGS_CFB64);
 }
 
-static int atmel_aes_cfb32_encrypt(struct ablkcipher_request *req)
+static int atmel_aes_cfb32_encrypt(struct skcipher_request *req)
 {
 	return atmel_aes_crypt(req, AES_FLAGS_CFB32 | AES_FLAGS_ENCRYPT);
 }
 
-static int atmel_aes_cfb32_decrypt(struct ablkcipher_request *req)
+static int atmel_aes_cfb32_decrypt(struct skcipher_request *req)
 {
 	return atmel_aes_crypt(req, AES_FLAGS_CFB32);
 }
 
-static int atmel_aes_cfb16_encrypt(struct ablkcipher_request *req)
+static int atmel_aes_cfb16_encrypt(struct skcipher_request *req)
 {
 	return atmel_aes_crypt(req, AES_FLAGS_CFB16 | AES_FLAGS_ENCRYPT);
 }
 
-static int atmel_aes_cfb16_decrypt(struct ablkcipher_request *req)
+static int atmel_aes_cfb16_decrypt(struct skcipher_request *req)
 {
 	return atmel_aes_crypt(req, AES_FLAGS_CFB16);
 }
 
-static int atmel_aes_cfb8_encrypt(struct ablkcipher_request *req)
+static int atmel_aes_cfb8_encrypt(struct skcipher_request *req)
 {
 	return atmel_aes_crypt(req, AES_FLAGS_CFB8 | AES_FLAGS_ENCRYPT);
 }
 
-static int atmel_aes_cfb8_decrypt(struct ablkcipher_request *req)
+static int atmel_aes_cfb8_decrypt(struct skcipher_request *req)
 {
 	return atmel_aes_crypt(req, AES_FLAGS_CFB8);
 }
 
-static int atmel_aes_ctr_encrypt(struct ablkcipher_request *req)
+static int atmel_aes_ctr_encrypt(struct skcipher_request *req)
 {
 	return atmel_aes_crypt(req, AES_FLAGS_CTR | AES_FLAGS_ENCRYPT);
 }
 
-static int atmel_aes_ctr_decrypt(struct ablkcipher_request *req)
+static int atmel_aes_ctr_decrypt(struct skcipher_request *req)
 {
 	return atmel_aes_crypt(req, AES_FLAGS_CTR);
 }
 
-static int atmel_aes_cra_init(struct crypto_tfm *tfm)
+static int atmel_aes_init_tfm(struct crypto_skcipher *tfm)
 {
-	struct atmel_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct atmel_aes_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	tfm->crt_ablkcipher.reqsize = sizeof(struct atmel_aes_reqctx);
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct atmel_aes_reqctx));
 	ctx->base.start = atmel_aes_start;
 
 	return 0;
 }
 
-static int atmel_aes_ctr_cra_init(struct crypto_tfm *tfm)
+static int atmel_aes_ctr_init_tfm(struct crypto_skcipher *tfm)
 {
-	struct atmel_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct atmel_aes_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	tfm->crt_ablkcipher.reqsize = sizeof(struct atmel_aes_reqctx);
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct atmel_aes_reqctx));
 	ctx->base.start = atmel_aes_ctr_start;
 
 	return 0;
 }
 
-static struct crypto_alg aes_algs[] = {
-{
-	.cra_name		= "ecb(aes)",
-	.cra_driver_name	= "atmel-ecb-aes",
-	.cra_priority		= ATMEL_AES_PRIORITY,
-	.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER | CRYPTO_ALG_ASYNC,
-	.cra_blocksize		= AES_BLOCK_SIZE,
-	.cra_ctxsize		= sizeof(struct atmel_aes_ctx),
-	.cra_alignmask		= 0xf,
-	.cra_type		= &crypto_ablkcipher_type,
-	.cra_module		= THIS_MODULE,
-	.cra_init		= atmel_aes_cra_init,
-	.cra_u.ablkcipher = {
-		.min_keysize	= AES_MIN_KEY_SIZE,
-		.max_keysize	= AES_MAX_KEY_SIZE,
-		.setkey		= atmel_aes_setkey,
-		.encrypt	= atmel_aes_ecb_encrypt,
-		.decrypt	= atmel_aes_ecb_decrypt,
-	}
+static struct skcipher_alg aes_algs[] = {
+{
+	.base.cra_name		= "ecb(aes)",
+	.base.cra_driver_name	= "atmel-ecb-aes",
+	.base.cra_priority	= ATMEL_AES_PRIORITY,
+	.base.cra_flags		= CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize	= AES_BLOCK_SIZE,
+	.base.cra_ctxsize	= sizeof(struct atmel_aes_ctx),
+	.base.cra_alignmask	= 0xf,
+	.base.cra_module	= THIS_MODULE,
+
+	.init			= atmel_aes_init_tfm,
+	.min_keysize		= AES_MIN_KEY_SIZE,
+	.max_keysize		= AES_MAX_KEY_SIZE,
+	.setkey			= atmel_aes_setkey,
+	.encrypt		= atmel_aes_ecb_encrypt,
+	.decrypt		= atmel_aes_ecb_decrypt,
 },
 {
-	.cra_name		= "cbc(aes)",
-	.cra_driver_name	= "atmel-cbc-aes",
-	.cra_priority		= ATMEL_AES_PRIORITY,
-	.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER | CRYPTO_ALG_ASYNC,
-	.cra_blocksize		= AES_BLOCK_SIZE,
-	.cra_ctxsize		= sizeof(struct atmel_aes_ctx),
-	.cra_alignmask		= 0xf,
-	.cra_type		= &crypto_ablkcipher_type,
-	.cra_module		= THIS_MODULE,
-	.cra_init		= atmel_aes_cra_init,
-	.cra_u.ablkcipher = {
-		.min_keysize	= AES_MIN_KEY_SIZE,
-		.max_keysize	= AES_MAX_KEY_SIZE,
-		.ivsize		= AES_BLOCK_SIZE,
-		.setkey		= atmel_aes_setkey,
-		.encrypt	= atmel_aes_cbc_encrypt,
-		.decrypt	= atmel_aes_cbc_decrypt,
-	}
+	.base.cra_name		= "cbc(aes)",
+	.base.cra_driver_name	= "atmel-cbc-aes",
+	.base.cra_priority	= ATMEL_AES_PRIORITY,
+	.base.cra_flags		= CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize	= AES_BLOCK_SIZE,
+	.base.cra_ctxsize	= sizeof(struct atmel_aes_ctx),
+	.base.cra_alignmask	= 0xf,
+	.base.cra_module	= THIS_MODULE,
+
+	.init			= atmel_aes_init_tfm,
+	.min_keysize		= AES_MIN_KEY_SIZE,
+	.max_keysize		= AES_MAX_KEY_SIZE,
+	.setkey			= atmel_aes_setkey,
+	.encrypt		= atmel_aes_cbc_encrypt,
+	.decrypt		= atmel_aes_cbc_decrypt,
+	.ivsize			= AES_BLOCK_SIZE,
 },
 {
-	.cra_name		= "ofb(aes)",
-	.cra_driver_name	= "atmel-ofb-aes",
-	.cra_priority		= ATMEL_AES_PRIORITY,
-	.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER | CRYPTO_ALG_ASYNC,
-	.cra_blocksize		= AES_BLOCK_SIZE,
-	.cra_ctxsize		= sizeof(struct atmel_aes_ctx),
-	.cra_alignmask		= 0xf,
-	.cra_type		= &crypto_ablkcipher_type,
-	.cra_module		= THIS_MODULE,
-	.cra_init		= atmel_aes_cra_init,
-	.cra_u.ablkcipher = {
-		.min_keysize	= AES_MIN_KEY_SIZE,
-		.max_keysize	= AES_MAX_KEY_SIZE,
-		.ivsize		= AES_BLOCK_SIZE,
-		.setkey		= atmel_aes_setkey,
-		.encrypt	= atmel_aes_ofb_encrypt,
-		.decrypt	= atmel_aes_ofb_decrypt,
-	}
+	.base.cra_name		= "ofb(aes)",
+	.base.cra_driver_name	= "atmel-ofb-aes",
+	.base.cra_priority	= ATMEL_AES_PRIORITY,
+	.base.cra_flags		= CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize	= AES_BLOCK_SIZE,
+	.base.cra_ctxsize	= sizeof(struct atmel_aes_ctx),
+	.base.cra_alignmask	= 0xf,
+	.base.cra_module	= THIS_MODULE,
+
+	.init			= atmel_aes_init_tfm,
+	.min_keysize		= AES_MIN_KEY_SIZE,
+	.max_keysize		= AES_MAX_KEY_SIZE,
+	.setkey			= atmel_aes_setkey,
+	.encrypt		= atmel_aes_ofb_encrypt,
+	.decrypt		= atmel_aes_ofb_decrypt,
+	.ivsize			= AES_BLOCK_SIZE,
 },
 {
-	.cra_name		= "cfb(aes)",
-	.cra_driver_name	= "atmel-cfb-aes",
-	.cra_priority		= ATMEL_AES_PRIORITY,
-	.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER | CRYPTO_ALG_ASYNC,
-	.cra_blocksize		= AES_BLOCK_SIZE,
-	.cra_ctxsize		= sizeof(struct atmel_aes_ctx),
-	.cra_alignmask		= 0xf,
-	.cra_type		= &crypto_ablkcipher_type,
-	.cra_module		= THIS_MODULE,
-	.cra_init		= atmel_aes_cra_init,
-	.cra_u.ablkcipher = {
-		.min_keysize	= AES_MIN_KEY_SIZE,
-		.max_keysize	= AES_MAX_KEY_SIZE,
-		.ivsize		= AES_BLOCK_SIZE,
-		.setkey		= atmel_aes_setkey,
-		.encrypt	= atmel_aes_cfb_encrypt,
-		.decrypt	= atmel_aes_cfb_decrypt,
-	}
+	.base.cra_name		= "cfb(aes)",
+	.base.cra_driver_name	= "atmel-cfb-aes",
+	.base.cra_priority	= ATMEL_AES_PRIORITY,
+	.base.cra_flags		= CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize	= AES_BLOCK_SIZE,
+	.base.cra_ctxsize	= sizeof(struct atmel_aes_ctx),
+	.base.cra_alignmask	= 0xf,
+	.base.cra_module	= THIS_MODULE,
+
+	.init			= atmel_aes_init_tfm,
+	.min_keysize		= AES_MIN_KEY_SIZE,
+	.max_keysize		= AES_MAX_KEY_SIZE,
+	.setkey			= atmel_aes_setkey,
+	.encrypt		= atmel_aes_cfb_encrypt,
+	.decrypt		= atmel_aes_cfb_decrypt,
+	.ivsize			= AES_BLOCK_SIZE,
 },
 {
-	.cra_name		= "cfb32(aes)",
-	.cra_driver_name	= "atmel-cfb32-aes",
-	.cra_priority		= ATMEL_AES_PRIORITY,
-	.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER | CRYPTO_ALG_ASYNC,
-	.cra_blocksize		= CFB32_BLOCK_SIZE,
-	.cra_ctxsize		= sizeof(struct atmel_aes_ctx),
-	.cra_alignmask		= 0x3,
-	.cra_type		= &crypto_ablkcipher_type,
-	.cra_module		= THIS_MODULE,
-	.cra_init		= atmel_aes_cra_init,
-	.cra_u.ablkcipher = {
-		.min_keysize	= AES_MIN_KEY_SIZE,
-		.max_keysize	= AES_MAX_KEY_SIZE,
-		.ivsize		= AES_BLOCK_SIZE,
-		.setkey		= atmel_aes_setkey,
-		.encrypt	= atmel_aes_cfb32_encrypt,
-		.decrypt	= atmel_aes_cfb32_decrypt,
-	}
+	.base.cra_name		= "cfb32(aes)",
+	.base.cra_driver_name	= "atmel-cfb32-aes",
+	.base.cra_priority	= ATMEL_AES_PRIORITY,
+	.base.cra_flags		= CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize	= CFB32_BLOCK_SIZE,
+	.base.cra_ctxsize	= sizeof(struct atmel_aes_ctx),
+	.base.cra_alignmask	= 0xf,
+	.base.cra_module	= THIS_MODULE,
+
+	.init			= atmel_aes_init_tfm,
+	.min_keysize		= AES_MIN_KEY_SIZE,
+	.max_keysize		= AES_MAX_KEY_SIZE,
+	.setkey			= atmel_aes_setkey,
+	.encrypt		= atmel_aes_cfb32_encrypt,
+	.decrypt		= atmel_aes_cfb32_decrypt,
+	.ivsize			= AES_BLOCK_SIZE,
 },
 {
-	.cra_name		= "cfb16(aes)",
-	.cra_driver_name	= "atmel-cfb16-aes",
-	.cra_priority		= ATMEL_AES_PRIORITY,
-	.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER | CRYPTO_ALG_ASYNC,
-	.cra_blocksize		= CFB16_BLOCK_SIZE,
-	.cra_ctxsize		= sizeof(struct atmel_aes_ctx),
-	.cra_alignmask		= 0x1,
-	.cra_type		= &crypto_ablkcipher_type,
-	.cra_module		= THIS_MODULE,
-	.cra_init		= atmel_aes_cra_init,
-	.cra_u.ablkcipher = {
-		.min_keysize	= AES_MIN_KEY_SIZE,
-		.max_keysize	= AES_MAX_KEY_SIZE,
-		.ivsize		= AES_BLOCK_SIZE,
-		.setkey		= atmel_aes_setkey,
-		.encrypt	= atmel_aes_cfb16_encrypt,
-		.decrypt	= atmel_aes_cfb16_decrypt,
-	}
+	.base.cra_name		= "cfb16(aes)",
+	.base.cra_driver_name	= "atmel-cfb16-aes",
+	.base.cra_priority	= ATMEL_AES_PRIORITY,
+	.base.cra_flags		= CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize	= CFB16_BLOCK_SIZE,
+	.base.cra_ctxsize	= sizeof(struct atmel_aes_ctx),
+	.base.cra_alignmask	= 0xf,
+	.base.cra_module	= THIS_MODULE,
+
+	.init			= atmel_aes_init_tfm,
+	.min_keysize		= AES_MIN_KEY_SIZE,
+	.max_keysize		= AES_MAX_KEY_SIZE,
+	.setkey			= atmel_aes_setkey,
+	.encrypt		= atmel_aes_cfb16_encrypt,
+	.decrypt		= atmel_aes_cfb16_decrypt,
+	.ivsize			= AES_BLOCK_SIZE,
 },
 {
-	.cra_name		= "cfb8(aes)",
-	.cra_driver_name	= "atmel-cfb8-aes",
-	.cra_priority		= ATMEL_AES_PRIORITY,
-	.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER | CRYPTO_ALG_ASYNC,
-	.cra_blocksize		= CFB8_BLOCK_SIZE,
-	.cra_ctxsize		= sizeof(struct atmel_aes_ctx),
-	.cra_alignmask		= 0x0,
-	.cra_type		= &crypto_ablkcipher_type,
-	.cra_module		= THIS_MODULE,
-	.cra_init		= atmel_aes_cra_init,
-	.cra_u.ablkcipher = {
-		.min_keysize	= AES_MIN_KEY_SIZE,
-		.max_keysize	= AES_MAX_KEY_SIZE,
-		.ivsize		= AES_BLOCK_SIZE,
-		.setkey		= atmel_aes_setkey,
-		.encrypt	= atmel_aes_cfb8_encrypt,
-		.decrypt	= atmel_aes_cfb8_decrypt,
-	}
+	.base.cra_name		= "cfb8(aes)",
+	.base.cra_driver_name	= "atmel-cfb8-aes",
+	.base.cra_priority	= ATMEL_AES_PRIORITY,
+	.base.cra_flags		= CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize	= CFB8_BLOCK_SIZE,
+	.base.cra_ctxsize	= sizeof(struct atmel_aes_ctx),
+	.base.cra_alignmask	= 0xf,
+	.base.cra_module	= THIS_MODULE,
+
+	.init			= atmel_aes_init_tfm,
+	.min_keysize		= AES_MIN_KEY_SIZE,
+	.max_keysize		= AES_MAX_KEY_SIZE,
+	.setkey			= atmel_aes_setkey,
+	.encrypt		= atmel_aes_cfb8_encrypt,
+	.decrypt		= atmel_aes_cfb8_decrypt,
+	.ivsize			= AES_BLOCK_SIZE,
 },
 {
-	.cra_name		= "ctr(aes)",
-	.cra_driver_name	= "atmel-ctr-aes",
-	.cra_priority		= ATMEL_AES_PRIORITY,
-	.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER | CRYPTO_ALG_ASYNC,
-	.cra_blocksize		= 1,
-	.cra_ctxsize		= sizeof(struct atmel_aes_ctr_ctx),
-	.cra_alignmask		= 0xf,
-	.cra_type		= &crypto_ablkcipher_type,
-	.cra_module		= THIS_MODULE,
-	.cra_init		= atmel_aes_ctr_cra_init,
-	.cra_u.ablkcipher = {
-		.min_keysize	= AES_MIN_KEY_SIZE,
-		.max_keysize	= AES_MAX_KEY_SIZE,
-		.ivsize		= AES_BLOCK_SIZE,
-		.setkey		= atmel_aes_setkey,
-		.encrypt	= atmel_aes_ctr_encrypt,
-		.decrypt	= atmel_aes_ctr_decrypt,
-	}
+	.base.cra_name		= "ctr(aes)",
+	.base.cra_driver_name	= "atmel-ctr-aes",
+	.base.cra_priority	= ATMEL_AES_PRIORITY,
+	.base.cra_flags		= CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize	= 1,
+	.base.cra_ctxsize	= sizeof(struct atmel_aes_ctr_ctx),
+	.base.cra_alignmask	= 0xf,
+	.base.cra_module	= THIS_MODULE,
+
+	.init			= atmel_aes_ctr_init_tfm,
+	.min_keysize		= AES_MIN_KEY_SIZE,
+	.max_keysize		= AES_MAX_KEY_SIZE,
+	.setkey			= atmel_aes_setkey,
+	.encrypt		= atmel_aes_ctr_encrypt,
+	.decrypt		= atmel_aes_ctr_decrypt,
+	.ivsize			= AES_BLOCK_SIZE,
 },
 };
 
-static struct crypto_alg aes_cfb64_alg = {
-	.cra_name		= "cfb64(aes)",
-	.cra_driver_name	= "atmel-cfb64-aes",
-	.cra_priority		= ATMEL_AES_PRIORITY,
-	.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER | CRYPTO_ALG_ASYNC,
-	.cra_blocksize		= CFB64_BLOCK_SIZE,
-	.cra_ctxsize		= sizeof(struct atmel_aes_ctx),
-	.cra_alignmask		= 0x7,
-	.cra_type		= &crypto_ablkcipher_type,
-	.cra_module		= THIS_MODULE,
-	.cra_init		= atmel_aes_cra_init,
-	.cra_u.ablkcipher = {
-		.min_keysize	= AES_MIN_KEY_SIZE,
-		.max_keysize	= AES_MAX_KEY_SIZE,
-		.ivsize		= AES_BLOCK_SIZE,
-		.setkey		= atmel_aes_setkey,
-		.encrypt	= atmel_aes_cfb64_encrypt,
-		.decrypt	= atmel_aes_cfb64_decrypt,
-	}
+static struct skcipher_alg aes_cfb64_alg = {
+	.base.cra_name		= "cfb64(aes)",
+	.base.cra_driver_name	= "atmel-cfb64-aes",
+	.base.cra_priority	= ATMEL_AES_PRIORITY,
+	.base.cra_flags		= CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize	= CFB64_BLOCK_SIZE,
+	.base.cra_ctxsize	= sizeof(struct atmel_aes_ctx),
+	.base.cra_alignmask	= 0xf,
+	.base.cra_module	= THIS_MODULE,
+
+	.init			= atmel_aes_init_tfm,
+	.min_keysize		= AES_MIN_KEY_SIZE,
+	.max_keysize		= AES_MAX_KEY_SIZE,
+	.setkey			= atmel_aes_setkey,
+	.encrypt		= atmel_aes_cfb64_encrypt,
+	.decrypt		= atmel_aes_cfb64_decrypt,
+	.ivsize			= AES_BLOCK_SIZE,
 };
 
 
@@ -1864,8 +1847,8 @@ static int atmel_aes_xts_process_data(struct atmel_aes_dev *dd);
 static int atmel_aes_xts_start(struct atmel_aes_dev *dd)
 {
 	struct atmel_aes_xts_ctx *ctx = atmel_aes_xts_ctx_cast(dd->ctx);
-	struct ablkcipher_request *req = ablkcipher_request_cast(dd->areq);
-	struct atmel_aes_reqctx *rctx = ablkcipher_request_ctx(req);
+	struct skcipher_request *req = skcipher_request_cast(dd->areq);
+	struct atmel_aes_reqctx *rctx = skcipher_request_ctx(req);
 	unsigned long flags;
 	int err;
 
@@ -1875,7 +1858,7 @@ static int atmel_aes_xts_start(struct atmel_aes_dev *dd)
 	if (err)
 		return atmel_aes_complete(dd, err);
 
-	/* Compute the tweak value from req->info with ecb(aes). */
+	/* Compute the tweak value from req->iv with ecb(aes). */
 	flags = dd->flags;
 	dd->flags &= ~AES_FLAGS_MODE_MASK;
 	dd->flags |= (AES_FLAGS_ECB | AES_FLAGS_ENCRYPT);
@@ -1883,14 +1866,14 @@ static int atmel_aes_xts_start(struct atmel_aes_dev *dd)
 				 ctx->key2, ctx->base.keylen);
 	dd->flags = flags;
 
-	atmel_aes_write_block(dd, AES_IDATAR(0), req->info);
+	atmel_aes_write_block(dd, AES_IDATAR(0), (void *)req->iv);
 	return atmel_aes_wait_for_data_ready(dd, atmel_aes_xts_process_data);
 }
 
 static int atmel_aes_xts_process_data(struct atmel_aes_dev *dd)
 {
-	struct ablkcipher_request *req = ablkcipher_request_cast(dd->areq);
-	bool use_dma = (req->nbytes >= ATMEL_AES_DMA_THRESHOLD);
+	struct skcipher_request *req = skcipher_request_cast(dd->areq);
+	bool use_dma = (req->cryptlen >= ATMEL_AES_DMA_THRESHOLD);
 	u32 tweak[AES_BLOCK_SIZE / sizeof(u32)];
 	static const u32 one[AES_BLOCK_SIZE / sizeof(u32)] = {cpu_to_le32(1), };
 	u8 *tweak_bytes = (u8 *)tweak;
@@ -1915,20 +1898,20 @@ static int atmel_aes_xts_process_data(struct atmel_aes_dev *dd)
 	atmel_aes_write_block(dd, AES_TWR(0), tweak);
 	atmel_aes_write_block(dd, AES_ALPHAR(0), one);
 	if (use_dma)
-		return atmel_aes_dma_start(dd, req->src, req->dst, req->nbytes,
+		return atmel_aes_dma_start(dd, req->src, req->dst, req->cryptlen,
 					   atmel_aes_transfer_complete);
 
-	return atmel_aes_cpu_start(dd, req->src, req->dst, req->nbytes,
+	return atmel_aes_cpu_start(dd, req->src, req->dst, req->cryptlen,
 				   atmel_aes_transfer_complete);
 }
 
-static int atmel_aes_xts_setkey(struct crypto_ablkcipher *tfm, const u8 *key,
+static int atmel_aes_xts_setkey(struct crypto_skcipher *tfm, const u8 *key,
 				unsigned int keylen)
 {
-	struct atmel_aes_xts_ctx *ctx = crypto_ablkcipher_ctx(tfm);
+	struct atmel_aes_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
 	int err;
 
-	err = xts_check_key(crypto_ablkcipher_tfm(tfm), key, keylen);
+	err = xts_check_key(crypto_skcipher_tfm(tfm), key, keylen);
 	if (err)
 		return err;
 
@@ -1939,45 +1922,43 @@ static int atmel_aes_xts_setkey(struct crypto_ablkcipher *tfm, const u8 *key,
 	return 0;
 }
 
-static int atmel_aes_xts_encrypt(struct ablkcipher_request *req)
+static int atmel_aes_xts_encrypt(struct skcipher_request *req)
 {
 	return atmel_aes_crypt(req, AES_FLAGS_XTS | AES_FLAGS_ENCRYPT);
 }
 
-static int atmel_aes_xts_decrypt(struct ablkcipher_request *req)
+static int atmel_aes_xts_decrypt(struct skcipher_request *req)
 {
 	return atmel_aes_crypt(req, AES_FLAGS_XTS);
 }
 
-static int atmel_aes_xts_cra_init(struct crypto_tfm *tfm)
+static int atmel_aes_xts_init_tfm(struct crypto_skcipher *tfm)
 {
-	struct atmel_aes_xts_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct atmel_aes_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	tfm->crt_ablkcipher.reqsize = sizeof(struct atmel_aes_reqctx);
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct atmel_aes_reqctx));
 	ctx->base.start = atmel_aes_xts_start;
 
 	return 0;
 }
 
-static struct crypto_alg aes_xts_alg = {
-	.cra_name		= "xts(aes)",
-	.cra_driver_name	= "atmel-xts-aes",
-	.cra_priority		= ATMEL_AES_PRIORITY,
-	.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER | CRYPTO_ALG_ASYNC,
-	.cra_blocksize		= AES_BLOCK_SIZE,
-	.cra_ctxsize		= sizeof(struct atmel_aes_xts_ctx),
-	.cra_alignmask		= 0xf,
-	.cra_type		= &crypto_ablkcipher_type,
-	.cra_module		= THIS_MODULE,
-	.cra_init		= atmel_aes_xts_cra_init,
-	.cra_u.ablkcipher = {
-		.min_keysize	= 2 * AES_MIN_KEY_SIZE,
-		.max_keysize	= 2 * AES_MAX_KEY_SIZE,
-		.ivsize		= AES_BLOCK_SIZE,
-		.setkey		= atmel_aes_xts_setkey,
-		.encrypt	= atmel_aes_xts_encrypt,
-		.decrypt	= atmel_aes_xts_decrypt,
-	}
+static struct skcipher_alg aes_xts_alg = {
+	.base.cra_name		= "xts(aes)",
+	.base.cra_driver_name	= "atmel-xts-aes",
+	.base.cra_priority	= ATMEL_AES_PRIORITY,
+	.base.cra_flags		= CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize	= AES_BLOCK_SIZE,
+	.base.cra_ctxsize	= sizeof(struct atmel_aes_xts_ctx),
+	.base.cra_alignmask	= 0xf,
+	.base.cra_module	= THIS_MODULE,
+
+	.min_keysize		= 2 * AES_MIN_KEY_SIZE,
+	.max_keysize		= 2 * AES_MAX_KEY_SIZE,
+	.ivsize			= AES_BLOCK_SIZE,
+	.setkey			= atmel_aes_xts_setkey,
+	.encrypt		= atmel_aes_xts_encrypt,
+	.decrypt		= atmel_aes_xts_decrypt,
+	.init			= atmel_aes_xts_init_tfm,
 };
 
 #ifdef CONFIG_CRYPTO_DEV_ATMEL_AUTHENC
@@ -2474,16 +2455,16 @@ static void atmel_aes_unregister_algs(struct atmel_aes_dev *dd)
 #endif
 
 	if (dd->caps.has_xts)
-		crypto_unregister_alg(&aes_xts_alg);
+		crypto_unregister_skcipher(&aes_xts_alg);
 
 	if (dd->caps.has_gcm)
 		crypto_unregister_aead(&aes_gcm_alg);
 
 	if (dd->caps.has_cfb64)
-		crypto_unregister_alg(&aes_cfb64_alg);
+		crypto_unregister_skcipher(&aes_cfb64_alg);
 
 	for (i = 0; i < ARRAY_SIZE(aes_algs); i++)
-		crypto_unregister_alg(&aes_algs[i]);
+		crypto_unregister_skcipher(&aes_algs[i]);
 }
 
 static int atmel_aes_register_algs(struct atmel_aes_dev *dd)
@@ -2491,13 +2472,13 @@ static int atmel_aes_register_algs(struct atmel_aes_dev *dd)
 	int err, i, j;
 
 	for (i = 0; i < ARRAY_SIZE(aes_algs); i++) {
-		err = crypto_register_alg(&aes_algs[i]);
+		err = crypto_register_skcipher(&aes_algs[i]);
 		if (err)
 			goto err_aes_algs;
 	}
 
 	if (dd->caps.has_cfb64) {
-		err = crypto_register_alg(&aes_cfb64_alg);
+		err = crypto_register_skcipher(&aes_cfb64_alg);
 		if (err)
 			goto err_aes_cfb64_alg;
 	}
@@ -2509,7 +2490,7 @@ static int atmel_aes_register_algs(struct atmel_aes_dev *dd)
 	}
 
 	if (dd->caps.has_xts) {
-		err = crypto_register_alg(&aes_xts_alg);
+		err = crypto_register_skcipher(&aes_xts_alg);
 		if (err)
 			goto err_aes_xts_alg;
 	}
@@ -2531,17 +2512,17 @@ static int atmel_aes_register_algs(struct atmel_aes_dev *dd)
 err_aes_authenc_alg:
 	for (j = 0; j < i; j++)
 		crypto_unregister_aead(&aes_authenc_algs[j]);
-	crypto_unregister_alg(&aes_xts_alg);
+	crypto_unregister_skcipher(&aes_xts_alg);
 #endif
 err_aes_xts_alg:
 	crypto_unregister_aead(&aes_gcm_alg);
 err_aes_gcm_alg:
-	crypto_unregister_alg(&aes_cfb64_alg);
+	crypto_unregister_skcipher(&aes_cfb64_alg);
 err_aes_cfb64_alg:
 	i = ARRAY_SIZE(aes_algs);
 err_aes_algs:
 	for (j = 0; j < i; j++)
-		crypto_unregister_alg(&aes_algs[j]);
+		crypto_unregister_skcipher(&aes_algs[j]);
 
 	return err;
 }
-- 
2.20.1


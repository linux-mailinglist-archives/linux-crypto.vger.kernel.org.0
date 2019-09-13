Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE17EB265A
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Sep 2019 21:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbfIMT7n (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 13 Sep 2019 15:59:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39884 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730108AbfIMT7n (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 13 Sep 2019 15:59:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id g12so2364993eds.6
        for <linux-crypto@vger.kernel.org>; Fri, 13 Sep 2019 12:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Uq1Gheoqv3swa16Fbj6f5UTDSQJ3lgrcDJwL1SdbWuY=;
        b=AcxtW4l3hw6N7wConC1T3vGOorvCaDfkjzerp6VmaeeZwAC7ZcIliSK1IS/McPQJfu
         JqwoaawQ773LrJOUhekUctcc5KoUw2L8HinXEhKpxFLS5yBAwvnosoLPw6wZfO0+iaQ5
         4EJ7t0WwgPePIJUrxjvwPs8bLpT6ybXSzsa3y++urobgk9iH0TVTo/6zQ8/C0QsddTUJ
         ZJR71Ejm4RGmz7fcBy8P9mdCvAMWW2AIORpTigj4gMV6l2f0uMpo8Gs0mMD56JIw+zpq
         NeA6teMPAkW2byF01HsP3antycQWCu57pte3H5QsAgxvaBMD5HtGoLSInm4l9hzSUmy8
         AnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Uq1Gheoqv3swa16Fbj6f5UTDSQJ3lgrcDJwL1SdbWuY=;
        b=Y6W2LcNVpkPo6tCJ0nh2XaLs9o/sDUjUqaeLm6/s3jKz6W/xRbx1ephWVufy9z4Iee
         TdNUTFuAzGx4lYK/x3f+IpI7jMBce+PO1NRjE0H/W/cR2dL9MU4ahXDrim71tSQetKkP
         J1uN47r6l1tBGVoEl+OjrSMgo6MLld/7xaUlDhK+md/omY+oFY+0RYyANdOAwYpLuPEu
         ALzxvo86JcO/Y33g/9jauEqG5+nPNt2iY4fd0J2WIbVPyXJTNVOU6T8mRUeWP9/JaEz1
         a8T9Y2CTMzSG4xoD3kaw/afQgyWA6mQsAhTImFkyy5jrhHAZsGOnbgfmcn5ZqXZLSoV6
         vH5w==
X-Gm-Message-State: APjAAAUnEwaz9Jm5ALpElvdSWT+NztGmewKGSNPdKQRPWbBg+vpQOgPv
        f0MIOxFDLD9cU0PeOVLpqg66AcDR
X-Google-Smtp-Source: APXvYqwZKmdjrX+BMWUQ9D3b+UYM5PzusIZl/OREYGtRGsmZoMoXMRLmjWsR+ebZezM/krWqfAeoRA==
X-Received: by 2002:a05:6402:614:: with SMTP id n20mr49733788edv.237.1568404779265;
        Fri, 13 Sep 2019 12:59:39 -0700 (PDT)
Received: from localhost.localdomain.com ([188.204.2.113])
        by smtp.gmail.com with ESMTPSA id a50sm4592579eda.25.2019.09.13.12.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 12:59:38 -0700 (PDT)
From:   Pascal van Leeuwen <pascalvanl@gmail.com>
X-Google-Original-From: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
To:     linux-crypto@vger.kernel.org
Cc:     antoine.tenart@bootlin.com, herbert@gondor.apana.org.au,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: [PATCHv2 2/3] crypto: inside-secure - Add HMAC-SHA3 family of authentication algorithms
Date:   Fri, 13 Sep 2019 20:56:48 +0200
Message-Id: <1568401009-29762-3-git-send-email-pvanleeuwen@verimatrix.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568401009-29762-1-git-send-email-pvanleeuwen@verimatrix.com>
References: <1568401009-29762-1-git-send-email-pvanleeuwen@verimatrix.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch adds support for hmac(sha3-224), hmac(sha3-256), hmac(sha3-384)
and hmac(sha3-512) authentication algorithms.

The patch has been tested with the eip197c_iewxkbc configuration on the
Xilinx VCU118 development board, including the testmgr extra tests.

changes since v1:
- nothing

Signed-off-by: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
---
 drivers/crypto/inside-secure/safexcel.c      |   4 +
 drivers/crypto/inside-secure/safexcel.h      |   4 +
 drivers/crypto/inside-secure/safexcel_hash.c | 441 ++++++++++++++++++++++++++-
 3 files changed, 436 insertions(+), 13 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index 4c91bbf..c8157f2 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -1191,6 +1191,10 @@ static int safexcel_request_ring_irq(void *pdev, int irqid,
 	&safexcel_alg_sha3_256,
 	&safexcel_alg_sha3_384,
 	&safexcel_alg_sha3_512,
+	&safexcel_alg_hmac_sha3_224,
+	&safexcel_alg_hmac_sha3_256,
+	&safexcel_alg_hmac_sha3_384,
+	&safexcel_alg_hmac_sha3_512,
 };
 
 static int safexcel_register_algorithms(struct safexcel_crypto_priv *priv)
diff --git a/drivers/crypto/inside-secure/safexcel.h b/drivers/crypto/inside-secure/safexcel.h
index f41982d..275f8b5 100644
--- a/drivers/crypto/inside-secure/safexcel.h
+++ b/drivers/crypto/inside-secure/safexcel.h
@@ -897,5 +897,9 @@ int safexcel_hmac_setkey(const char *alg, const u8 *key, unsigned int keylen,
 extern struct safexcel_alg_template safexcel_alg_sha3_256;
 extern struct safexcel_alg_template safexcel_alg_sha3_384;
 extern struct safexcel_alg_template safexcel_alg_sha3_512;
+extern struct safexcel_alg_template safexcel_alg_hmac_sha3_224;
+extern struct safexcel_alg_template safexcel_alg_hmac_sha3_256;
+extern struct safexcel_alg_template safexcel_alg_hmac_sha3_384;
+extern struct safexcel_alg_template safexcel_alg_hmac_sha3_512;
 
 #endif
diff --git a/drivers/crypto/inside-secure/safexcel_hash.c b/drivers/crypto/inside-secure/safexcel_hash.c
index 1d67cf2..85c3a07 100644
--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -27,12 +27,15 @@ struct safexcel_ahash_ctx {
 	bool cbcmac;
 	bool do_fallback;
 	bool fb_init_done;
+	bool fb_do_setkey;
 
-	u32 ipad[SHA512_DIGEST_SIZE / sizeof(u32)];
-	u32 opad[SHA512_DIGEST_SIZE / sizeof(u32)];
+	u32 ipad[SHA3_512_BLOCK_SIZE / sizeof(u32)];
+	u32 opad[SHA3_512_BLOCK_SIZE / sizeof(u32)];
 
 	struct crypto_cipher *kaes;
 	struct crypto_ahash *fback;
+	struct crypto_shash *shpre;
+	struct shash_desc *shdesc;
 };
 
 struct safexcel_ahash_req {
@@ -52,7 +55,8 @@ struct safexcel_ahash_req {
 
 	u8 state_sz;    /* expected state size, only set once */
 	u8 block_sz;    /* block size, only set once */
-	u32 state[SHA512_DIGEST_SIZE / sizeof(u32)] __aligned(sizeof(u32));
+	u8 digest_sz;   /* output digest size, only set once */
+	u32 state[SHA3_512_BLOCK_SIZE / sizeof(u32)] __aligned(sizeof(u32));
 
 	u64 len;
 	u64 processed;
@@ -246,7 +250,7 @@ static int safexcel_handle_req_result(struct safexcel_crypto_priv *priv,
 	}
 
 	if (sreq->result_dma) {
-		dma_unmap_single(priv->dev, sreq->result_dma, sreq->state_sz,
+		dma_unmap_single(priv->dev, sreq->result_dma, sreq->digest_sz,
 				 DMA_FROM_DEVICE);
 		sreq->result_dma = 0;
 	}
@@ -265,7 +269,7 @@ static int safexcel_handle_req_result(struct safexcel_crypto_priv *priv,
 			memcpy(sreq->cache, sreq->state,
 			       crypto_ahash_digestsize(ahash));
 
-			memcpy(sreq->state, ctx->opad, sreq->state_sz);
+			memcpy(sreq->state, ctx->opad, sreq->digest_sz);
 
 			sreq->len = sreq->block_sz +
 				    crypto_ahash_digestsize(ahash);
@@ -309,7 +313,7 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 	struct safexcel_command_desc *cdesc, *first_cdesc = NULL;
 	struct safexcel_result_desc *rdesc;
 	struct scatterlist *sg;
-	int i, extra = 0, n_cdesc = 0, ret = 0, cache_len, skip = 0, res_sz;
+	int i, extra = 0, n_cdesc = 0, ret = 0, cache_len, skip = 0;
 	u64 queued, len;
 
 	queued = safexcel_queued_len(req);
@@ -451,11 +455,10 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 	/* Setup the context options */
 	safexcel_context_control(ctx, req, first_cdesc);
 
-	/* Add the token. Note that the XCBC result is only 1 AES block. */
-	res_sz = req->xcbcmac ? AES_BLOCK_SIZE : req->state_sz;
-	safexcel_hash_token(first_cdesc, len, res_sz, ctx->cbcmac);
+	/* Add the token */
+	safexcel_hash_token(first_cdesc, len, req->digest_sz, ctx->cbcmac);
 
-	req->result_dma = dma_map_single(priv->dev, req->state, req->state_sz,
+	req->result_dma = dma_map_single(priv->dev, req->state, req->digest_sz,
 					 DMA_FROM_DEVICE);
 	if (dma_mapping_error(priv->dev, req->result_dma)) {
 		ret = -EINVAL;
@@ -464,7 +467,7 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 
 	/* Add a result descriptor */
 	rdesc = safexcel_add_rdesc(priv, ring, 1, 1, req->result_dma,
-				   res_sz);
+				   req->digest_sz);
 	if (IS_ERR(rdesc)) {
 		ret = PTR_ERR(rdesc);
 		goto unmap_result;
@@ -479,7 +482,7 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 	return 0;
 
 unmap_result:
-	dma_unmap_single(priv->dev, req->result_dma, req->state_sz,
+	dma_unmap_single(priv->dev, req->result_dma, req->digest_sz,
 			 DMA_FROM_DEVICE);
 unmap_sg:
 	if (req->nents) {
@@ -912,6 +915,7 @@ static int safexcel_ahash_cra_init(struct crypto_tfm *tfm)
 	ctx->priv = tmpl->priv;
 	ctx->base.send = safexcel_ahash_send;
 	ctx->base.handle_result = safexcel_handle_result;
+	ctx->fb_do_setkey = false;
 
 	crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
 				 sizeof(struct safexcel_ahash_req));
@@ -928,6 +932,7 @@ static int safexcel_sha1_init(struct ahash_request *areq)
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA1;
 	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
 	req->state_sz = SHA1_DIGEST_SIZE;
+	req->digest_sz = SHA1_DIGEST_SIZE;
 	req->block_sz = SHA1_BLOCK_SIZE;
 
 	return 0;
@@ -1009,6 +1014,7 @@ static int safexcel_hmac_sha1_init(struct ahash_request *areq)
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA1;
 	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
 	req->state_sz = SHA1_DIGEST_SIZE;
+	req->digest_sz = SHA1_DIGEST_SIZE;
 	req->block_sz = SHA1_BLOCK_SIZE;
 	req->hmac = true;
 
@@ -1245,6 +1251,7 @@ static int safexcel_sha256_init(struct ahash_request *areq)
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA256;
 	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
 	req->state_sz = SHA256_DIGEST_SIZE;
+	req->digest_sz = SHA256_DIGEST_SIZE;
 	req->block_sz = SHA256_BLOCK_SIZE;
 
 	return 0;
@@ -1300,6 +1307,7 @@ static int safexcel_sha224_init(struct ahash_request *areq)
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA224;
 	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
 	req->state_sz = SHA256_DIGEST_SIZE;
+	req->digest_sz = SHA256_DIGEST_SIZE;
 	req->block_sz = SHA256_BLOCK_SIZE;
 
 	return 0;
@@ -1368,6 +1376,7 @@ static int safexcel_hmac_sha224_init(struct ahash_request *areq)
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA224;
 	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
 	req->state_sz = SHA256_DIGEST_SIZE;
+	req->digest_sz = SHA256_DIGEST_SIZE;
 	req->block_sz = SHA256_BLOCK_SIZE;
 	req->hmac = true;
 
@@ -1438,6 +1447,7 @@ static int safexcel_hmac_sha256_init(struct ahash_request *areq)
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA256;
 	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
 	req->state_sz = SHA256_DIGEST_SIZE;
+	req->digest_sz = SHA256_DIGEST_SIZE;
 	req->block_sz = SHA256_BLOCK_SIZE;
 	req->hmac = true;
 
@@ -1495,6 +1505,7 @@ static int safexcel_sha512_init(struct ahash_request *areq)
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA512;
 	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
 	req->state_sz = SHA512_DIGEST_SIZE;
+	req->digest_sz = SHA512_DIGEST_SIZE;
 	req->block_sz = SHA512_BLOCK_SIZE;
 
 	return 0;
@@ -1550,6 +1561,7 @@ static int safexcel_sha384_init(struct ahash_request *areq)
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA384;
 	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
 	req->state_sz = SHA512_DIGEST_SIZE;
+	req->digest_sz = SHA512_DIGEST_SIZE;
 	req->block_sz = SHA512_BLOCK_SIZE;
 
 	return 0;
@@ -1618,6 +1630,7 @@ static int safexcel_hmac_sha512_init(struct ahash_request *areq)
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA512;
 	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
 	req->state_sz = SHA512_DIGEST_SIZE;
+	req->digest_sz = SHA512_DIGEST_SIZE;
 	req->block_sz = SHA512_BLOCK_SIZE;
 	req->hmac = true;
 
@@ -1688,6 +1701,7 @@ static int safexcel_hmac_sha384_init(struct ahash_request *areq)
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA384;
 	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
 	req->state_sz = SHA512_DIGEST_SIZE;
+	req->digest_sz = SHA512_DIGEST_SIZE;
 	req->block_sz = SHA512_BLOCK_SIZE;
 	req->hmac = true;
 
@@ -1745,6 +1759,7 @@ static int safexcel_md5_init(struct ahash_request *areq)
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_MD5;
 	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
 	req->state_sz = MD5_DIGEST_SIZE;
+	req->digest_sz = MD5_DIGEST_SIZE;
 	req->block_sz = MD5_HMAC_BLOCK_SIZE;
 
 	return 0;
@@ -1806,6 +1821,7 @@ static int safexcel_hmac_md5_init(struct ahash_request *areq)
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_MD5;
 	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
 	req->state_sz = MD5_DIGEST_SIZE;
+	req->digest_sz = MD5_DIGEST_SIZE;
 	req->block_sz = MD5_HMAC_BLOCK_SIZE;
 	req->len_is_le = true; /* MD5 is little endian! ... */
 	req->hmac = true;
@@ -1887,6 +1903,7 @@ static int safexcel_crc32_init(struct ahash_request *areq)
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_CRC32;
 	req->digest = CONTEXT_CONTROL_DIGEST_XCM;
 	req->state_sz = sizeof(u32);
+	req->digest_sz = sizeof(u32);
 	req->block_sz = sizeof(u32);
 
 	return 0;
@@ -1958,6 +1975,7 @@ static int safexcel_cbcmac_init(struct ahash_request *areq)
 
 	req->digest   = CONTEXT_CONTROL_DIGEST_XCM;
 	req->state_sz = ctx->key_sz;
+	req->digest_sz = AES_BLOCK_SIZE;
 	req->block_sz = AES_BLOCK_SIZE;
 	req->xcbcmac  = true;
 
@@ -2245,6 +2263,7 @@ static int safexcel_sm3_init(struct ahash_request *areq)
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SM3;
 	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
 	req->state_sz = SM3_DIGEST_SIZE;
+	req->digest_sz = SM3_DIGEST_SIZE;
 	req->block_sz = SM3_BLOCK_SIZE;
 
 	return 0;
@@ -2313,6 +2332,7 @@ static int safexcel_hmac_sm3_init(struct ahash_request *areq)
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SM3;
 	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
 	req->state_sz = SM3_DIGEST_SIZE;
+	req->digest_sz = SM3_DIGEST_SIZE;
 	req->block_sz = SM3_BLOCK_SIZE;
 	req->hmac = true;
 
@@ -2371,6 +2391,7 @@ static int safexcel_sha3_224_init(struct ahash_request *areq)
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA3_224;
 	req->digest = CONTEXT_CONTROL_DIGEST_INITIAL;
 	req->state_sz = SHA3_224_DIGEST_SIZE;
+	req->digest_sz = SHA3_224_DIGEST_SIZE;
 	req->block_sz = SHA3_224_BLOCK_SIZE;
 	ctx->do_fallback = false;
 	ctx->fb_init_done = false;
@@ -2391,7 +2412,23 @@ static int safexcel_sha3_fbcheck(struct ahash_request *req)
 		ahash_request_set_crypt(subreq, req->src, req->result,
 					req->nbytes);
 		if (!ctx->fb_init_done) {
-			ret = crypto_ahash_init(subreq);
+			if (ctx->fb_do_setkey) {
+				/* Set fallback cipher HMAC key */
+				u8 key[SHA3_224_BLOCK_SIZE];
+
+				memcpy(key, ctx->ipad,
+				       crypto_ahash_blocksize(ctx->fback) / 2);
+				memcpy(key +
+				       crypto_ahash_blocksize(ctx->fback) / 2,
+				       ctx->opad,
+				       crypto_ahash_blocksize(ctx->fback) / 2);
+				ret = crypto_ahash_setkey(ctx->fback, key,
+					crypto_ahash_blocksize(ctx->fback));
+				memzero_explicit(key,
+					crypto_ahash_blocksize(ctx->fback));
+				ctx->fb_do_setkey = false;
+			}
+			ret = ret ?: crypto_ahash_init(subreq);
 			ctx->fb_init_done = true;
 		}
 	}
@@ -2547,6 +2584,7 @@ static int safexcel_sha3_256_init(struct ahash_request *areq)
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA3_256;
 	req->digest = CONTEXT_CONTROL_DIGEST_INITIAL;
 	req->state_sz = SHA3_256_DIGEST_SIZE;
+	req->digest_sz = SHA3_256_DIGEST_SIZE;
 	req->block_sz = SHA3_256_BLOCK_SIZE;
 	ctx->do_fallback = false;
 	ctx->fb_init_done = false;
@@ -2604,6 +2642,7 @@ static int safexcel_sha3_384_init(struct ahash_request *areq)
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA3_384;
 	req->digest = CONTEXT_CONTROL_DIGEST_INITIAL;
 	req->state_sz = SHA3_384_DIGEST_SIZE;
+	req->digest_sz = SHA3_384_DIGEST_SIZE;
 	req->block_sz = SHA3_384_BLOCK_SIZE;
 	ctx->do_fallback = false;
 	ctx->fb_init_done = false;
@@ -2661,6 +2700,7 @@ static int safexcel_sha3_512_init(struct ahash_request *areq)
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA3_512;
 	req->digest = CONTEXT_CONTROL_DIGEST_INITIAL;
 	req->state_sz = SHA3_512_DIGEST_SIZE;
+	req->digest_sz = SHA3_512_DIGEST_SIZE;
 	req->block_sz = SHA3_512_BLOCK_SIZE;
 	ctx->do_fallback = false;
 	ctx->fb_init_done = false;
@@ -2706,3 +2746,378 @@ struct safexcel_alg_template safexcel_alg_sha3_512 = {
 		},
 	},
 };
+
+static int safexcel_hmac_sha3_cra_init(struct crypto_tfm *tfm, const char *alg)
+{
+	struct safexcel_ahash_ctx *ctx = crypto_tfm_ctx(tfm);
+	int ret;
+
+	ret = safexcel_sha3_cra_init(tfm);
+	if (ret)
+		return ret;
+
+	/* Allocate precalc basic digest implementation */
+	ctx->shpre = crypto_alloc_shash(alg, 0, CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(ctx->shpre))
+		return PTR_ERR(ctx->shpre);
+
+	ctx->shdesc = kmalloc(sizeof(*ctx->shdesc) +
+			      crypto_shash_descsize(ctx->shpre), GFP_KERNEL);
+	if (!ctx->shdesc) {
+		crypto_free_shash(ctx->shpre);
+		return -ENOMEM;
+	}
+	ctx->shdesc->tfm = ctx->shpre;
+	return 0;
+}
+
+static void safexcel_hmac_sha3_cra_exit(struct crypto_tfm *tfm)
+{
+	struct safexcel_ahash_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	crypto_free_ahash(ctx->fback);
+	crypto_free_shash(ctx->shpre);
+	kfree(ctx->shdesc);
+	safexcel_ahash_cra_exit(tfm);
+}
+
+static int safexcel_hmac_sha3_setkey(struct crypto_ahash *tfm, const u8 *key,
+				     unsigned int keylen)
+{
+	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
+	int ret = 0;
+
+	if (keylen > crypto_ahash_blocksize(tfm)) {
+		/*
+		 * If the key is larger than the blocksize, then hash it
+		 * first using our fallback cipher
+		 */
+		ret = crypto_shash_digest(ctx->shdesc, key, keylen,
+					  (u8 *)ctx->ipad);
+		keylen = crypto_shash_digestsize(ctx->shpre);
+
+		/*
+		 * If the digest is larger than half the blocksize, we need to
+		 * move the rest to opad due to the way our HMAC infra works.
+		 */
+		if (keylen > crypto_ahash_blocksize(tfm) / 2)
+			/* Buffers overlap, need to use memmove iso memcpy! */
+			memmove(ctx->opad,
+				(u8 *)ctx->ipad +
+					crypto_ahash_blocksize(tfm) / 2,
+				keylen - crypto_ahash_blocksize(tfm) / 2);
+	} else {
+		/*
+		 * Copy the key to our ipad & opad buffers
+		 * Note that ipad and opad each contain one half of the key,
+		 * to match the existing HMAC driver infrastructure.
+		 */
+		if (keylen <= crypto_ahash_blocksize(tfm) / 2) {
+			memcpy(ctx->ipad, key, keylen);
+		} else {
+			memcpy(ctx->ipad, key,
+			       crypto_ahash_blocksize(tfm) / 2);
+			memcpy(ctx->opad,
+			       key + crypto_ahash_blocksize(tfm) / 2,
+			       keylen - crypto_ahash_blocksize(tfm) / 2);
+		}
+	}
+
+	/* Pad key with zeroes */
+	if (keylen <= crypto_ahash_blocksize(tfm) / 2) {
+		memset((u8 *)ctx->ipad + keylen, 0,
+		       crypto_ahash_blocksize(tfm) / 2 - keylen);
+		memset(ctx->opad, 0, crypto_ahash_blocksize(tfm) / 2);
+	} else {
+		memset((u8 *)ctx->opad + keylen -
+		       crypto_ahash_blocksize(tfm) / 2, 0,
+		       crypto_ahash_blocksize(tfm) - keylen);
+	}
+
+	/* If doing fallback, still need to set the new key! */
+	ctx->fb_do_setkey = true;
+	return ret;
+}
+
+static int safexcel_hmac_sha3_224_init(struct ahash_request *areq)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+
+	memset(req, 0, sizeof(*req));
+
+	/* Copy (half of) the key */
+	memcpy(req->state, ctx->ipad, SHA3_224_BLOCK_SIZE / 2);
+	/* Start of HMAC should have len == processed == blocksize */
+	req->len	= SHA3_224_BLOCK_SIZE;
+	req->processed	= SHA3_224_BLOCK_SIZE;
+	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA3_224;
+	req->digest = CONTEXT_CONTROL_DIGEST_HMAC;
+	req->state_sz = SHA3_224_BLOCK_SIZE / 2;
+	req->digest_sz = SHA3_224_DIGEST_SIZE;
+	req->block_sz = SHA3_224_BLOCK_SIZE;
+	req->hmac = true;
+	ctx->do_fallback = false;
+	ctx->fb_init_done = false;
+	return 0;
+}
+
+static int safexcel_hmac_sha3_224_digest(struct ahash_request *req)
+{
+	if (req->nbytes)
+		return safexcel_hmac_sha3_224_init(req) ?:
+		       safexcel_ahash_finup(req);
+
+	/* HW cannot do zero length HMAC, use fallback instead */
+	return safexcel_sha3_digest_fallback(req);
+}
+
+static int safexcel_hmac_sha3_224_cra_init(struct crypto_tfm *tfm)
+{
+	return safexcel_hmac_sha3_cra_init(tfm, "sha3-224");
+}
+
+struct safexcel_alg_template safexcel_alg_hmac_sha3_224 = {
+	.type = SAFEXCEL_ALG_TYPE_AHASH,
+	.algo_mask = SAFEXCEL_ALG_SHA3,
+	.alg.ahash = {
+		.init = safexcel_hmac_sha3_224_init,
+		.update = safexcel_sha3_update,
+		.final = safexcel_sha3_final,
+		.finup = safexcel_sha3_finup,
+		.digest = safexcel_hmac_sha3_224_digest,
+		.setkey = safexcel_hmac_sha3_setkey,
+		.export = safexcel_sha3_export,
+		.import = safexcel_sha3_import,
+		.halg = {
+			.digestsize = SHA3_224_DIGEST_SIZE,
+			.statesize = sizeof(struct safexcel_ahash_export_state),
+			.base = {
+				.cra_name = "hmac(sha3-224)",
+				.cra_driver_name = "safexcel-hmac-sha3-224",
+				.cra_priority = SAFEXCEL_CRA_PRIORITY,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+					     CRYPTO_ALG_KERN_DRIVER_ONLY |
+					     CRYPTO_ALG_NEED_FALLBACK,
+				.cra_blocksize = SHA3_224_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct safexcel_ahash_ctx),
+				.cra_init = safexcel_hmac_sha3_224_cra_init,
+				.cra_exit = safexcel_hmac_sha3_cra_exit,
+				.cra_module = THIS_MODULE,
+			},
+		},
+	},
+};
+
+static int safexcel_hmac_sha3_256_init(struct ahash_request *areq)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+
+	memset(req, 0, sizeof(*req));
+
+	/* Copy (half of) the key */
+	memcpy(req->state, ctx->ipad, SHA3_256_BLOCK_SIZE / 2);
+	/* Start of HMAC should have len == processed == blocksize */
+	req->len	= SHA3_256_BLOCK_SIZE;
+	req->processed	= SHA3_256_BLOCK_SIZE;
+	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA3_256;
+	req->digest = CONTEXT_CONTROL_DIGEST_HMAC;
+	req->state_sz = SHA3_256_BLOCK_SIZE / 2;
+	req->digest_sz = SHA3_256_DIGEST_SIZE;
+	req->block_sz = SHA3_256_BLOCK_SIZE;
+	req->hmac = true;
+	ctx->do_fallback = false;
+	ctx->fb_init_done = false;
+	return 0;
+}
+
+static int safexcel_hmac_sha3_256_digest(struct ahash_request *req)
+{
+	if (req->nbytes)
+		return safexcel_hmac_sha3_256_init(req) ?:
+		       safexcel_ahash_finup(req);
+
+	/* HW cannot do zero length HMAC, use fallback instead */
+	return safexcel_sha3_digest_fallback(req);
+}
+
+static int safexcel_hmac_sha3_256_cra_init(struct crypto_tfm *tfm)
+{
+	return safexcel_hmac_sha3_cra_init(tfm, "sha3-256");
+}
+
+struct safexcel_alg_template safexcel_alg_hmac_sha3_256 = {
+	.type = SAFEXCEL_ALG_TYPE_AHASH,
+	.algo_mask = SAFEXCEL_ALG_SHA3,
+	.alg.ahash = {
+		.init = safexcel_hmac_sha3_256_init,
+		.update = safexcel_sha3_update,
+		.final = safexcel_sha3_final,
+		.finup = safexcel_sha3_finup,
+		.digest = safexcel_hmac_sha3_256_digest,
+		.setkey = safexcel_hmac_sha3_setkey,
+		.export = safexcel_sha3_export,
+		.import = safexcel_sha3_import,
+		.halg = {
+			.digestsize = SHA3_256_DIGEST_SIZE,
+			.statesize = sizeof(struct safexcel_ahash_export_state),
+			.base = {
+				.cra_name = "hmac(sha3-256)",
+				.cra_driver_name = "safexcel-hmac-sha3-256",
+				.cra_priority = SAFEXCEL_CRA_PRIORITY,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+					     CRYPTO_ALG_KERN_DRIVER_ONLY |
+					     CRYPTO_ALG_NEED_FALLBACK,
+				.cra_blocksize = SHA3_256_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct safexcel_ahash_ctx),
+				.cra_init = safexcel_hmac_sha3_256_cra_init,
+				.cra_exit = safexcel_hmac_sha3_cra_exit,
+				.cra_module = THIS_MODULE,
+			},
+		},
+	},
+};
+
+static int safexcel_hmac_sha3_384_init(struct ahash_request *areq)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+
+	memset(req, 0, sizeof(*req));
+
+	/* Copy (half of) the key */
+	memcpy(req->state, ctx->ipad, SHA3_384_BLOCK_SIZE / 2);
+	/* Start of HMAC should have len == processed == blocksize */
+	req->len	= SHA3_384_BLOCK_SIZE;
+	req->processed	= SHA3_384_BLOCK_SIZE;
+	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA3_384;
+	req->digest = CONTEXT_CONTROL_DIGEST_HMAC;
+	req->state_sz = SHA3_384_BLOCK_SIZE / 2;
+	req->digest_sz = SHA3_384_DIGEST_SIZE;
+	req->block_sz = SHA3_384_BLOCK_SIZE;
+	req->hmac = true;
+	ctx->do_fallback = false;
+	ctx->fb_init_done = false;
+	return 0;
+}
+
+static int safexcel_hmac_sha3_384_digest(struct ahash_request *req)
+{
+	if (req->nbytes)
+		return safexcel_hmac_sha3_384_init(req) ?:
+		       safexcel_ahash_finup(req);
+
+	/* HW cannot do zero length HMAC, use fallback instead */
+	return safexcel_sha3_digest_fallback(req);
+}
+
+static int safexcel_hmac_sha3_384_cra_init(struct crypto_tfm *tfm)
+{
+	return safexcel_hmac_sha3_cra_init(tfm, "sha3-384");
+}
+
+struct safexcel_alg_template safexcel_alg_hmac_sha3_384 = {
+	.type = SAFEXCEL_ALG_TYPE_AHASH,
+	.algo_mask = SAFEXCEL_ALG_SHA3,
+	.alg.ahash = {
+		.init = safexcel_hmac_sha3_384_init,
+		.update = safexcel_sha3_update,
+		.final = safexcel_sha3_final,
+		.finup = safexcel_sha3_finup,
+		.digest = safexcel_hmac_sha3_384_digest,
+		.setkey = safexcel_hmac_sha3_setkey,
+		.export = safexcel_sha3_export,
+		.import = safexcel_sha3_import,
+		.halg = {
+			.digestsize = SHA3_384_DIGEST_SIZE,
+			.statesize = sizeof(struct safexcel_ahash_export_state),
+			.base = {
+				.cra_name = "hmac(sha3-384)",
+				.cra_driver_name = "safexcel-hmac-sha3-384",
+				.cra_priority = SAFEXCEL_CRA_PRIORITY,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+					     CRYPTO_ALG_KERN_DRIVER_ONLY |
+					     CRYPTO_ALG_NEED_FALLBACK,
+				.cra_blocksize = SHA3_384_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct safexcel_ahash_ctx),
+				.cra_init = safexcel_hmac_sha3_384_cra_init,
+				.cra_exit = safexcel_hmac_sha3_cra_exit,
+				.cra_module = THIS_MODULE,
+			},
+		},
+	},
+};
+
+static int safexcel_hmac_sha3_512_init(struct ahash_request *areq)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+
+	memset(req, 0, sizeof(*req));
+
+	/* Copy (half of) the key */
+	memcpy(req->state, ctx->ipad, SHA3_512_BLOCK_SIZE / 2);
+	/* Start of HMAC should have len == processed == blocksize */
+	req->len	= SHA3_512_BLOCK_SIZE;
+	req->processed	= SHA3_512_BLOCK_SIZE;
+	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA3_512;
+	req->digest = CONTEXT_CONTROL_DIGEST_HMAC;
+	req->state_sz = SHA3_512_BLOCK_SIZE / 2;
+	req->digest_sz = SHA3_512_DIGEST_SIZE;
+	req->block_sz = SHA3_512_BLOCK_SIZE;
+	req->hmac = true;
+	ctx->do_fallback = false;
+	ctx->fb_init_done = false;
+	return 0;
+}
+
+static int safexcel_hmac_sha3_512_digest(struct ahash_request *req)
+{
+	if (req->nbytes)
+		return safexcel_hmac_sha3_512_init(req) ?:
+		       safexcel_ahash_finup(req);
+
+	/* HW cannot do zero length HMAC, use fallback instead */
+	return safexcel_sha3_digest_fallback(req);
+}
+
+static int safexcel_hmac_sha3_512_cra_init(struct crypto_tfm *tfm)
+{
+	return safexcel_hmac_sha3_cra_init(tfm, "sha3-512");
+}
+struct safexcel_alg_template safexcel_alg_hmac_sha3_512 = {
+	.type = SAFEXCEL_ALG_TYPE_AHASH,
+	.algo_mask = SAFEXCEL_ALG_SHA3,
+	.alg.ahash = {
+		.init = safexcel_hmac_sha3_512_init,
+		.update = safexcel_sha3_update,
+		.final = safexcel_sha3_final,
+		.finup = safexcel_sha3_finup,
+		.digest = safexcel_hmac_sha3_512_digest,
+		.setkey = safexcel_hmac_sha3_setkey,
+		.export = safexcel_sha3_export,
+		.import = safexcel_sha3_import,
+		.halg = {
+			.digestsize = SHA3_512_DIGEST_SIZE,
+			.statesize = sizeof(struct safexcel_ahash_export_state),
+			.base = {
+				.cra_name = "hmac(sha3-512)",
+				.cra_driver_name = "safexcel-hmac-sha3-512",
+				.cra_priority = SAFEXCEL_CRA_PRIORITY,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+					     CRYPTO_ALG_KERN_DRIVER_ONLY |
+					     CRYPTO_ALG_NEED_FALLBACK,
+				.cra_blocksize = SHA3_512_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct safexcel_ahash_ctx),
+				.cra_init = safexcel_hmac_sha3_512_cra_init,
+				.cra_exit = safexcel_hmac_sha3_cra_exit,
+				.cra_module = THIS_MODULE,
+			},
+		},
+	},
+};
-- 
1.8.3.1


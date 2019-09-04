Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50FE6A7EAC
	for <lists+linux-crypto@lfdr.de>; Wed,  4 Sep 2019 11:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfIDJBd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 4 Sep 2019 05:01:33 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44468 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfIDJBd (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 4 Sep 2019 05:01:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id a21so21660375edt.11
        for <linux-crypto@vger.kernel.org>; Wed, 04 Sep 2019 02:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9wl+ZPOS3LnjcAIiK1SZiXqWfKrcnB53gsg+wf7xeNQ=;
        b=PQlGyjMDCgTs7nUoz46tUv+K5965YTbbi5kUL7fG9matIdIu2EjSP6JjfwO0705Fln
         k+5l+E7zxDk/PFpGwN/lnnFrqhkdR0Gs7c80PyKWumYT4nnPtkh1eHav1++3RBcQIDqN
         Ajx5HCBQZuiVqUn+sQLuGa2U3GjwBECBjdj6YE17Df2iRLRQnkQVfXkhKv350ltIhOI6
         vghtbcDv8sfUgSCsoYbYkgrL7Vxcu4j7d9Q44XgJZqfEuh1JMmiHHRXfi9iosR/4v6iO
         63ACfnrGmMe13gwEYaZSbnBP2yjF1Mndq5ZXpSdPjyJdfGM/c5tzjlfmsP6dYVkohOPb
         zI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9wl+ZPOS3LnjcAIiK1SZiXqWfKrcnB53gsg+wf7xeNQ=;
        b=aOBjRcFIfNsb9rkpWhhGHz4EzHLfASnUhi1hV2y0eanuX1NiZWXnN03CSq4uPC8ALu
         xYpkxgXYf4rCaNLOn1H/DTuob9nfCCdo1e4ZqqRJCDp2xmOl/UyVi9vOlTSluEL/66qL
         JOuBJ3Y8BvFab1Ncjy9RwE90zRedmTyzhRoFJvAZ6DMmo4xAqrTvH2EGbFC5GYU7XmnJ
         Ak1cq0ULpVMp2MfJ4h5CXcBFYDFonksFXCSbDjd6ZLdbGHhaPCw2rjRBA4m9AtheN/EP
         Ev+jImosoj6TgGHFOtX81Uw3gQkVblBDFC8fNDbNAgYnVrjLNZVolH7K9R5wi1EKN8j4
         T3jA==
X-Gm-Message-State: APjAAAXmxv0ptYhaCTcS7cnwTPz55LAFJ7HfZwwq4IXsgeEmuIPg218O
        bVjkm0z3HD+ZP0MGILpiXR38quN0
X-Google-Smtp-Source: APXvYqwBI0hzkdpx/dJrBLLNmMMetlROW+41kV2opSQzNNjpUMaubkpbNMCUJsIdem5U6StfjGxGsA==
X-Received: by 2002:a17:906:5044:: with SMTP id e4mr32140479ejk.268.1567587691002;
        Wed, 04 Sep 2019 02:01:31 -0700 (PDT)
Received: from localhost.localdomain.com ([188.204.2.113])
        by smtp.gmail.com with ESMTPSA id t30sm1473997edt.91.2019.09.04.02.01.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 02:01:30 -0700 (PDT)
From:   Pascal van Leeuwen <pascalvanl@gmail.com>
X-Google-Original-From: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
To:     linux-crypto@vger.kernel.org
Cc:     antoine.tenart@bootlin.com, herbert@gondor.apana.org.au,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: [PATCH 1/3] crypto: inside-secure - Added support for the AES CBCMAC ahash
Date:   Wed,  4 Sep 2019 09:36:46 +0200
Message-Id: <1567582608-29177-2-git-send-email-pvanleeuwen@verimatrix.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1567582608-29177-1-git-send-email-pvanleeuwen@verimatrix.com>
References: <1567582608-29177-1-git-send-email-pvanleeuwen@verimatrix.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch adds support for the AES-CBCMAC authentication algorithm.

Signed-off-by: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
---
 drivers/crypto/inside-secure/safexcel.c      |   1 +
 drivers/crypto/inside-secure/safexcel.h      |   1 +
 drivers/crypto/inside-secure/safexcel_hash.c | 235 ++++++++++++++++++++++-----
 3 files changed, 196 insertions(+), 41 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index 02851b9..898a6b0 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -1010,6 +1010,7 @@ static int safexcel_request_ring_irq(void *pdev, int irqid,
 	&safexcel_alg_gcm,
 	&safexcel_alg_ccm,
 	&safexcel_alg_crc32,
+	&safexcel_alg_cbcmac,
 };
 
 static int safexcel_register_algorithms(struct safexcel_crypto_priv *priv)
diff --git a/drivers/crypto/inside-secure/safexcel.h b/drivers/crypto/inside-secure/safexcel.h
index bb98c93..ff91141 100644
--- a/drivers/crypto/inside-secure/safexcel.h
+++ b/drivers/crypto/inside-secure/safexcel.h
@@ -807,5 +807,6 @@ int safexcel_hmac_setkey(const char *alg, const u8 *key, unsigned int keylen,
 extern struct safexcel_alg_template safexcel_alg_gcm;
 extern struct safexcel_alg_template safexcel_alg_ccm;
 extern struct safexcel_alg_template safexcel_alg_crc32;
+extern struct safexcel_alg_template safexcel_alg_cbcmac;
 
 #endif
diff --git a/drivers/crypto/inside-secure/safexcel_hash.c b/drivers/crypto/inside-secure/safexcel_hash.c
index 9d1e8cf..8df4fdc 100644
--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -5,6 +5,7 @@
  * Antoine Tenart <antoine.tenart@free-electrons.com>
  */
 
+#include <crypto/aes.h>
 #include <crypto/hmac.h>
 #include <crypto/md5.h>
 #include <crypto/sha.h>
@@ -19,6 +20,7 @@ struct safexcel_ahash_ctx {
 	struct safexcel_crypto_priv *priv;
 
 	u32 alg;
+	u8  key_sz;
 
 	u32 ipad[SHA512_DIGEST_SIZE / sizeof(u32)];
 	u32 opad[SHA512_DIGEST_SIZE / sizeof(u32)];
@@ -31,6 +33,8 @@ struct safexcel_ahash_req {
 	bool needs_inv;
 	bool hmac_zlen;
 	bool len_is_le;
+	bool not_first;
+	bool xcbcmac;
 
 	int nents;
 	dma_addr_t result_dma;
@@ -57,21 +61,31 @@ static inline u64 safexcel_queued_len(struct safexcel_ahash_req *req)
 }
 
 static void safexcel_hash_token(struct safexcel_command_desc *cdesc,
-				u32 input_length, u32 result_length)
+				u32 input_length, u32 result_length,
+				bool xcbcmac)
 {
 	struct safexcel_token *token =
 		(struct safexcel_token *)cdesc->control_data.token;
 
 	token[0].opcode = EIP197_TOKEN_OPCODE_DIRECTION;
 	token[0].packet_length = input_length;
-	token[0].stat = EIP197_TOKEN_STAT_LAST_HASH;
 	token[0].instructions = EIP197_TOKEN_INS_TYPE_HASH;
 
-	token[1].opcode = EIP197_TOKEN_OPCODE_INSERT;
-	token[1].packet_length = result_length;
-	token[1].stat = EIP197_TOKEN_STAT_LAST_HASH |
+	input_length &= 15;
+	if (unlikely(xcbcmac && input_length)) {
+		token[1].opcode = EIP197_TOKEN_OPCODE_INSERT;
+		token[1].packet_length = 16 - input_length;
+		token[1].stat = EIP197_TOKEN_STAT_LAST_HASH;
+		token[1].instructions = EIP197_TOKEN_INS_TYPE_HASH;
+	} else {
+		token[0].stat = EIP197_TOKEN_STAT_LAST_HASH;
+	}
+
+	token[2].opcode = EIP197_TOKEN_OPCODE_INSERT;
+	token[2].stat = EIP197_TOKEN_STAT_LAST_HASH |
 			EIP197_TOKEN_STAT_LAST_PACKET;
-	token[1].instructions = EIP197_TOKEN_INS_TYPE_OUTPUT |
+	token[2].packet_length = result_length;
+	token[2].instructions = EIP197_TOKEN_INS_TYPE_OUTPUT |
 				EIP197_TOKEN_INS_INSERT_HASH_DIGEST;
 }
 
@@ -90,29 +104,40 @@ static void safexcel_context_control(struct safexcel_ahash_ctx *ctx,
 	 * descriptor.
 	 */
 	if (unlikely(req->digest == CONTEXT_CONTROL_DIGEST_XCM)) {
-		ctx->base.ctxr->data[0] = req->state[0];
-
-		cdesc->control_data.control0 |= req->digest |
-			CONTEXT_CONTROL_TYPE_HASH_OUT  |
-			CONTEXT_CONTROL_SIZE(4);
+		if (req->xcbcmac)
+			memcpy(ctx->base.ctxr->data, ctx->ipad, ctx->key_sz);
+		else
+			memcpy(ctx->base.ctxr->data, req->state, req->state_sz);
 
+		if (!req->finish && req->xcbcmac)
+			cdesc->control_data.control0 |=
+				CONTEXT_CONTROL_DIGEST_XCM |
+				CONTEXT_CONTROL_TYPE_HASH_OUT  |
+				CONTEXT_CONTROL_NO_FINISH_HASH |
+				CONTEXT_CONTROL_SIZE(req->state_sz /
+						     sizeof(u32));
+		else
+			cdesc->control_data.control0 |=
+				CONTEXT_CONTROL_DIGEST_XCM |
+				CONTEXT_CONTROL_TYPE_HASH_OUT  |
+				CONTEXT_CONTROL_SIZE(req->state_sz /
+						     sizeof(u32));
 		return;
 	} else if (!req->processed) {
 		/* First - and possibly only - block of basic hash only */
-		if (req->finish) {
+		if (req->finish)
 			cdesc->control_data.control0 |= req->digest |
 				CONTEXT_CONTROL_TYPE_HASH_OUT |
 				CONTEXT_CONTROL_RESTART_HASH  |
 				/* ensure its not 0! */
 				CONTEXT_CONTROL_SIZE(1);
-		} else {
+		else
 			cdesc->control_data.control0 |= req->digest |
 				CONTEXT_CONTROL_TYPE_HASH_OUT  |
 				CONTEXT_CONTROL_RESTART_HASH   |
 				CONTEXT_CONTROL_NO_FINISH_HASH |
 				/* ensure its not 0! */
 				CONTEXT_CONTROL_SIZE(1);
-		}
 		return;
 	}
 
@@ -246,7 +271,8 @@ static int safexcel_handle_req_result(struct safexcel_crypto_priv *priv,
 			return 1;
 		}
 
-		if (unlikely(sreq->digest == CONTEXT_CONTROL_DIGEST_XCM)) {
+		if (unlikely(sreq->digest == CONTEXT_CONTROL_DIGEST_XCM &&
+			     ctx->alg == CONTEXT_CONTROL_CRYPTO_ALG_CRC32)) {
 			/* Undo final XOR with 0xffffffff ...*/
 			*(u32 *)areq->result = ~sreq->state[0];
 		} else {
@@ -274,10 +300,10 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 	struct safexcel_command_desc *cdesc, *first_cdesc = NULL;
 	struct safexcel_result_desc *rdesc;
 	struct scatterlist *sg;
-	int i, extra = 0, n_cdesc = 0, ret = 0;
-	u64 queued, len, cache_len;
+	int i, extra = 0, n_cdesc = 0, ret = 0, cache_len, skip = 0, res_sz;
+	u64 queued, len;
 
-	queued = len = safexcel_queued_len(req);
+	queued = safexcel_queued_len(req);
 	if (queued <= HASH_CACHE_SIZE)
 		cache_len = queued;
 	else
@@ -300,15 +326,43 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 				   areq->nbytes - extra);
 
 		queued -= extra;
-		len -= extra;
 
 		if (!queued) {
 			*commands = 0;
 			*results = 0;
 			return 0;
 		}
+
+		extra = 0;
+	}
+
+	if (unlikely(req->xcbcmac && req->processed > AES_BLOCK_SIZE)) {
+		if (unlikely(cache_len < AES_BLOCK_SIZE)) {
+			/*
+			 * Cache contains less than 1 full block, complete.
+			 */
+			extra = AES_BLOCK_SIZE - cache_len;
+			if (queued > cache_len) {
+				/* More data follows: borrow bytes */
+				u64 tmp = queued - cache_len;
+
+				skip = min_t(u64, tmp, extra);
+				sg_pcopy_to_buffer(areq->src,
+					sg_nents(areq->src),
+					req->cache + cache_len,
+					skip, 0);
+			}
+			extra -= skip;
+			memset(req->cache + cache_len + skip, 0, extra);
+			cache_len = AES_BLOCK_SIZE;
+			queued = queued + extra;
+		}
+
+		/* XCBC continue: XOR previous result into 1st word */
+		crypto_xor(req->cache, (const u8 *)req->state, AES_BLOCK_SIZE);
 	}
 
+	len = queued;
 	/* Add a command descriptor for the cached data, if any */
 	if (cache_len) {
 		req->cache_dma = dma_map_single(priv->dev, req->cache,
@@ -319,8 +373,8 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 		req->cache_sz = cache_len;
 		first_cdesc = safexcel_add_cdesc(priv, ring, 1,
 						 (cache_len == len),
-						 req->cache_dma, cache_len, len,
-						 ctx->base.ctxr_dma);
+						 req->cache_dma, cache_len,
+						 len, ctx->base.ctxr_dma);
 		if (IS_ERR(first_cdesc)) {
 			ret = PTR_ERR(first_cdesc);
 			goto unmap_cache;
@@ -332,10 +386,6 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 			goto send_command;
 	}
 
-	/* Skip descriptor generation for zero-length requests */
-	if (!areq->nbytes)
-		goto send_command;
-
 	/* Now handle the current ahash request buffer(s) */
 	req->nents = dma_map_sg(priv->dev, areq->src,
 				sg_nents_for_len(areq->src,
@@ -349,34 +399,43 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 	for_each_sg(areq->src, sg, req->nents, i) {
 		int sglen = sg_dma_len(sg);
 
+		if (unlikely(sglen <= skip)) {
+			skip -= sglen;
+			continue;
+		}
+
 		/* Do not overflow the request */
-		if (queued < sglen)
+		if ((queued + skip) <= sglen)
 			sglen = queued;
+		else
+			sglen -= skip;
 
 		cdesc = safexcel_add_cdesc(priv, ring, !n_cdesc,
 					   !(queued - sglen),
-					   sg_dma_address(sg),
-					   sglen, len, ctx->base.ctxr_dma);
+					   sg_dma_address(sg) + skip, sglen,
+					   len, ctx->base.ctxr_dma);
 		if (IS_ERR(cdesc)) {
 			ret = PTR_ERR(cdesc);
 			goto unmap_sg;
 		}
-		n_cdesc++;
 
-		if (n_cdesc == 1)
+		if (!n_cdesc)
 			first_cdesc = cdesc;
+		n_cdesc++;
 
 		queued -= sglen;
 		if (!queued)
 			break;
+		skip = 0;
 	}
 
 send_command:
 	/* Setup the context options */
 	safexcel_context_control(ctx, req, first_cdesc);
 
-	/* Add the token */
-	safexcel_hash_token(first_cdesc, len, req->state_sz);
+	/* Add the token. Note that the XCBC result is only 1 AES block. */
+	res_sz = req->xcbcmac ? AES_BLOCK_SIZE : req->state_sz;
+	safexcel_hash_token(first_cdesc, len, res_sz, req->xcbcmac);
 
 	req->result_dma = dma_map_single(priv->dev, req->state, req->state_sz,
 					 DMA_FROM_DEVICE);
@@ -387,7 +446,7 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 
 	/* Add a result descriptor */
 	rdesc = safexcel_add_rdesc(priv, ring, 1, 1, req->result_dma,
-				   req->state_sz);
+				   res_sz);
 	if (IS_ERR(rdesc)) {
 		ret = PTR_ERR(rdesc);
 		goto unmap_result;
@@ -395,7 +454,7 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 
 	safexcel_rdr_req_set(priv, ring, rdesc, &areq->base);
 
-	req->processed += len;
+	req->processed += len - extra;
 
 	*commands = n_cdesc;
 	*results = 1;
@@ -405,7 +464,10 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 	dma_unmap_single(priv->dev, req->result_dma, req->state_sz,
 			 DMA_FROM_DEVICE);
 unmap_sg:
-	dma_unmap_sg(priv->dev, areq->src, req->nents, DMA_TO_DEVICE);
+	if (req->nents) {
+		dma_unmap_sg(priv->dev, areq->src, req->nents, DMA_TO_DEVICE);
+		req->nents = 0;
+	}
 cdesc_rollback:
 	for (i = 0; i < n_cdesc; i++)
 		safexcel_ring_rollback_wptr(priv, &priv->ring[ring].cdr);
@@ -603,14 +665,10 @@ static int safexcel_ahash_enqueue(struct ahash_request *areq)
 
 	if (ctx->base.ctxr) {
 		if (priv->flags & EIP197_TRC_CACHE && !ctx->base.needs_inv &&
-		    req->processed &&
-		    (/* invalidate for basic hash continuation finish */
-		     (req->finish &&
-		      (req->digest == CONTEXT_CONTROL_DIGEST_PRECOMPUTED)) ||
+		     /* invalidate for *any* non-XCBC continuation */
+		   ((req->not_first && !req->xcbcmac) ||
 		     /* invalidate if (i)digest changed */
 		     memcmp(ctx->base.ctxr->data, req->state, req->state_sz) ||
-		     /* invalidate for HMAC continuation finish */
-		     (req->finish && (req->processed != req->block_sz)) ||
 		     /* invalidate for HMAC finish with odigest changed */
 		     (req->finish && req->hmac &&
 		      memcmp(ctx->base.ctxr->data + (req->state_sz>>2),
@@ -635,6 +693,7 @@ static int safexcel_ahash_enqueue(struct ahash_request *areq)
 		if (!ctx->base.ctxr)
 			return -ENOMEM;
 	}
+	req->not_first = true;
 
 	ring = ctx->base.ring;
 
@@ -712,6 +771,11 @@ static int safexcel_ahash_final(struct ahash_request *areq)
 		/* Zero length CRC32 */
 		memcpy(areq->result, ctx->ipad, sizeof(u32));
 		return 0;
+	} else if (unlikely(req->xcbcmac && req->len == AES_BLOCK_SIZE &&
+			    !areq->nbytes)) {
+		/* Zero length CBC MAC */
+		memset(areq->result, 0, AES_BLOCK_SIZE);
+		return 0;
 	} else if (unlikely(req->hmac &&
 			    (req->len == req->block_sz) &&
 			    !areq->nbytes)) {
@@ -1841,3 +1905,92 @@ struct safexcel_alg_template safexcel_alg_crc32 = {
 		},
 	},
 };
+
+static int safexcel_cbcmac_init(struct ahash_request *areq)
+{
+	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
+	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+
+	memset(req, 0, sizeof(*req));
+
+	/* Start from loaded keys */
+	memcpy(req->state, ctx->ipad, ctx->key_sz);
+	/* Set processed to non-zero to enable invalidation detection */
+	req->len	= AES_BLOCK_SIZE;
+	req->processed	= AES_BLOCK_SIZE;
+
+	req->digest   = CONTEXT_CONTROL_DIGEST_XCM;
+	req->state_sz = ctx->key_sz;
+	req->block_sz = AES_BLOCK_SIZE;
+	req->xcbcmac  = true;
+
+	return 0;
+}
+
+static int safexcel_cbcmac_setkey(struct crypto_ahash *tfm, const u8 *key,
+				 unsigned int len)
+{
+	struct safexcel_ahash_ctx *ctx = crypto_tfm_ctx(crypto_ahash_tfm(tfm));
+	struct crypto_aes_ctx aes;
+	int ret, i;
+
+	ret = aes_expandkey(&aes, key, len);
+	if (ret) {
+		crypto_ahash_set_flags(tfm, CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return ret;
+	}
+
+	memset(ctx->ipad, 0, 2 * AES_BLOCK_SIZE);
+	for (i = 0; i < len / sizeof(u32); i++)
+		ctx->ipad[i + 8] = cpu_to_be32(aes.key_enc[i]);
+
+	if (len == AES_KEYSIZE_192) {
+		ctx->alg    = CONTEXT_CONTROL_CRYPTO_ALG_XCBC192;
+		ctx->key_sz = AES_MAX_KEY_SIZE + 2 * AES_BLOCK_SIZE;
+	} else if (len == AES_KEYSIZE_256) {
+		ctx->alg    = CONTEXT_CONTROL_CRYPTO_ALG_XCBC256;
+		ctx->key_sz = AES_MAX_KEY_SIZE + 2 * AES_BLOCK_SIZE;
+	} else {
+		ctx->alg    = CONTEXT_CONTROL_CRYPTO_ALG_XCBC128;
+		ctx->key_sz = AES_MIN_KEY_SIZE + 2 * AES_BLOCK_SIZE;
+	}
+
+	memzero_explicit(&aes, sizeof(aes));
+	return 0;
+}
+
+static int safexcel_cbcmac_digest(struct ahash_request *areq)
+{
+	return safexcel_cbcmac_init(areq) ?: safexcel_ahash_finup(areq);
+}
+
+struct safexcel_alg_template safexcel_alg_cbcmac = {
+	.type = SAFEXCEL_ALG_TYPE_AHASH,
+	.algo_mask = 0,
+	.alg.ahash = {
+		.init = safexcel_cbcmac_init,
+		.update = safexcel_ahash_update,
+		.final = safexcel_ahash_final,
+		.finup = safexcel_ahash_finup,
+		.digest = safexcel_cbcmac_digest,
+		.setkey = safexcel_cbcmac_setkey,
+		.export = safexcel_ahash_export,
+		.import = safexcel_ahash_import,
+		.halg = {
+			.digestsize = AES_BLOCK_SIZE,
+			.statesize = sizeof(struct safexcel_ahash_export_state),
+			.base = {
+				.cra_name = "cbcmac(aes)",
+				.cra_driver_name = "safexcel-cbcmac-aes",
+				.cra_priority = SAFEXCEL_CRA_PRIORITY,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+					     CRYPTO_ALG_KERN_DRIVER_ONLY,
+				.cra_blocksize = 1,
+				.cra_ctxsize = sizeof(struct safexcel_ahash_ctx),
+				.cra_init = safexcel_ahash_cra_init,
+				.cra_exit = safexcel_ahash_cra_exit,
+				.cra_module = THIS_MODULE,
+			},
+		},
+	},
+};
-- 
1.8.3.1


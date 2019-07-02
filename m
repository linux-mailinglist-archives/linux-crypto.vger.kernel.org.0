Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60B435D330
	for <lists+linux-crypto@lfdr.de>; Tue,  2 Jul 2019 17:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfGBPmn (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 2 Jul 2019 11:42:43 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46264 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfGBPmn (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 2 Jul 2019 11:42:43 -0400
Received: by mail-ed1-f68.google.com with SMTP id d4so448920edr.13
        for <linux-crypto@vger.kernel.org>; Tue, 02 Jul 2019 08:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=niqAXUqiozlcROGYRDNXrUEFjBHJddxRMPsznlrrQUk=;
        b=lK50F6Rnuh9+f9xM3y+3QT0wMuaRl0Rv9y1kIHzn5AwheWMT5GPJOPhjU01+eXNjqM
         axOyqkiGh8/VJpMhfYLZoGYQ8l9UNQIpgEMvVtquLg7KGKnUoQpq/uiZl8z1NwUk9icY
         6zXihNIwLJrP+YCeNLio8KynxnWtsqqncdMBQMhPVtssw6fGgp/0DaIJX72SGGuAgwD+
         tok/EImklYdIf7X7PAWgj9/XxNmJSIyT4jEOJrKmYJ3JyC8Uz9mq/PQsNHLq4wuzkMfD
         LLIQ5Sapv5KN6hv6pO292QN2wgRJSzheV84j0aI2Z/lymPE6CdeAFk4ytphIilb+xJE6
         4b/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=niqAXUqiozlcROGYRDNXrUEFjBHJddxRMPsznlrrQUk=;
        b=X27U6LRZbS6nV+ee2AvF/37EO+FMh/5i7hc5yYBw8Q8Q/Q4LMdV0AFYIeGUr/7ebK+
         /+jyyJGdJBJ23fdll8LUtgoqJu4pPbq7E6ACm0GX1PsRgW/IyJaJyB6nd9nEV4ms1lJ/
         h/aJbWja7g7jS/ResawjxcKg4kU0lp+1IJ1fo05hYVrvU+pRVM06VRJtJ9lN42nlsn44
         42caV+PB7CTirf8wCHMzva3L2TFyAcTtTYFzWG18Gntu3rNZWzXoaNIu+mhU0FnDlgpm
         t/SXV+G0iTvxz09SJiH5z+rNuIuGuEAYPSCWqZLB1J8YMOkDuDOZiv/vzu5RscK2o/wF
         BkOA==
X-Gm-Message-State: APjAAAXmofuRIiak841NiiYk6cL3MZpKuU8gr0A+aVqZ2WeLRh0tJsOo
        W/ezEOcNYxWQ5EH2QYbETRGskskl
X-Google-Smtp-Source: APXvYqzYsqIT7A8wNa5Te70lD7o4zmMkuOYcb1tUMOZnblO4C0bsWPe/NkVg3/7PYhr1geOV04fUDQ==
X-Received: by 2002:a17:906:684e:: with SMTP id a14mr29529467ejs.156.1562082159310;
        Tue, 02 Jul 2019 08:42:39 -0700 (PDT)
Received: from localhost.localdomain.com ([188.204.2.113])
        by smtp.gmail.com with ESMTPSA id j11sm2341704ejr.69.2019.07.02.08.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 08:42:38 -0700 (PDT)
From:   Pascal van Leeuwen <pascalvanl@gmail.com>
X-Google-Original-From: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
To:     linux-crypto@vger.kernel.org
Cc:     antoine.tenart@bootlin.com, herbert@gondor.apana.org.au,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@insidesecure.com>,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: [PATCH 8/9] crypto: inside-secure - add support for arbitrary size hash/HMAC updates
Date:   Tue,  2 Jul 2019 16:39:59 +0200
Message-Id: <1562078400-969-11-git-send-email-pvanleeuwen@verimatrix.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562078400-969-1-git-send-email-pvanleeuwen@verimatrix.com>
References: <1562078400-969-1-git-send-email-pvanleeuwen@verimatrix.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Pascal van Leeuwen <pvanleeuwen@insidesecure.com>

This patch fixes an issue with hash and HMAC operations that perform
"large" intermediate updates (i.e. combined size > 2 hash blocks) by
actually making use of the hardware's hash continue capabilities.
The original implementation would cache these updates in a buffer that
was 2 hash blocks in size and fail if all update calls combined would
overflow that buffer. Which caused the cryptomgr extra tests to fail.

Signed-off-by: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
---
 drivers/crypto/inside-secure/safexcel.h      |   4 +-
 drivers/crypto/inside-secure/safexcel_hash.c | 423 +++++++++++++++++----------
 2 files changed, 269 insertions(+), 158 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel.h b/drivers/crypto/inside-secure/safexcel.h
index 75c6126..b68fec3 100644
--- a/drivers/crypto/inside-secure/safexcel.h
+++ b/drivers/crypto/inside-secure/safexcel.h
@@ -667,6 +667,8 @@ struct safexcel_context {
 	bool exit_inv;
 };
 
+#define HASH_CACHE_SIZE			SHA512_BLOCK_SIZE
+
 struct safexcel_ahash_export_state {
 	u64 len[2];
 	u64 processed[2];
@@ -674,7 +676,7 @@ struct safexcel_ahash_export_state {
 	u32 digest;
 
 	u32 state[SHA512_DIGEST_SIZE / sizeof(u32)];
-	u8 cache[SHA512_BLOCK_SIZE << 1];
+	u8 cache[HASH_CACHE_SIZE];
 };
 
 /*
diff --git a/drivers/crypto/inside-secure/safexcel_hash.c b/drivers/crypto/inside-secure/safexcel_hash.c
index 1b62608..59ec7dc 100644
--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -35,17 +35,18 @@ struct safexcel_ahash_req {
 
 	u32 digest;
 
-	u8 state_sz;    /* expected sate size, only set once */
+	u8 state_sz;    /* expected state size, only set once */
+	u8 block_sz;    /* block size, only set once */
 	u32 state[SHA512_DIGEST_SIZE / sizeof(u32)] __aligned(sizeof(u32));
 
 	u64 len[2];
 	u64 processed[2];
 
-	u8 cache[SHA512_BLOCK_SIZE] __aligned(sizeof(u32));
+	u8 cache[HASH_CACHE_SIZE] __aligned(sizeof(u32));
 	dma_addr_t cache_dma;
 	unsigned int cache_sz;
 
-	u8 cache_next[SHA512_BLOCK_SIZE] __aligned(sizeof(u32));
+	u8 cache_next[HASH_CACHE_SIZE] __aligned(sizeof(u32));
 };
 
 static inline u64 safexcel_queued_len(struct safexcel_ahash_req *req)
@@ -79,75 +80,99 @@ static void safexcel_hash_token(struct safexcel_command_desc *cdesc,
 
 static void safexcel_context_control(struct safexcel_ahash_ctx *ctx,
 				     struct safexcel_ahash_req *req,
-				     struct safexcel_command_desc *cdesc,
-				     unsigned int digestsize)
+				     struct safexcel_command_desc *cdesc)
 {
 	struct safexcel_crypto_priv *priv = ctx->priv;
-	int i;
+	u64 count = 0;
 
-	cdesc->control_data.control0 |= CONTEXT_CONTROL_TYPE_HASH_OUT;
 	cdesc->control_data.control0 |= ctx->alg;
-	cdesc->control_data.control0 |= req->digest;
-
-	if (req->digest == CONTEXT_CONTROL_DIGEST_PRECOMPUTED) {
-		if (req->processed[0] || req->processed[1]) {
-			if (ctx->alg == CONTEXT_CONTROL_CRYPTO_ALG_MD5)
-				cdesc->control_data.control0 |= CONTEXT_CONTROL_SIZE(5);
-			else if (ctx->alg == CONTEXT_CONTROL_CRYPTO_ALG_SHA1)
-				cdesc->control_data.control0 |= CONTEXT_CONTROL_SIZE(6);
-			else if (ctx->alg == CONTEXT_CONTROL_CRYPTO_ALG_SHA224 ||
-				 ctx->alg == CONTEXT_CONTROL_CRYPTO_ALG_SHA256)
-				cdesc->control_data.control0 |= CONTEXT_CONTROL_SIZE(9);
-			else if (ctx->alg == CONTEXT_CONTROL_CRYPTO_ALG_SHA384 ||
-				 ctx->alg == CONTEXT_CONTROL_CRYPTO_ALG_SHA512)
-				cdesc->control_data.control0 |= CONTEXT_CONTROL_SIZE(17);
-
-			cdesc->control_data.control1 |= CONTEXT_CONTROL_DIGEST_CNT;
+
+	/*
+	 * Copy the input digest if needed, and setup the context
+	 * fields. Do this now as we need it to setup the first command
+	 * descriptor.
+	 */
+	if ((!req->processed[0]) && (!req->processed[1])) {
+		/* First - and possibly only - block of basic hash only */
+		if (req->finish) {
+			cdesc->control_data.control0 |=
+				CONTEXT_CONTROL_TYPE_HASH_OUT |
+				CONTEXT_CONTROL_RESTART_HASH  |
+				/* ensure its not 0! */
+				CONTEXT_CONTROL_SIZE(1);
 		} else {
-			cdesc->control_data.control0 |= CONTEXT_CONTROL_RESTART_HASH;
+			cdesc->control_data.control0 |=
+				CONTEXT_CONTROL_TYPE_HASH_OUT  |
+				CONTEXT_CONTROL_RESTART_HASH   |
+				CONTEXT_CONTROL_NO_FINISH_HASH |
+				/* ensure its not 0! */
+				CONTEXT_CONTROL_SIZE(1);
 		}
+		return;
+	}
 
-		if (!req->finish)
-			cdesc->control_data.control0 |= CONTEXT_CONTROL_NO_FINISH_HASH;
-
-		/*
-		 * Copy the input digest if needed, and setup the context
-		 * fields. Do this now as we need it to setup the first command
-		 * descriptor.
-		 */
-		if (req->processed[0] || req->processed[1]) {
-			for (i = 0; i < digestsize / sizeof(u32); i++)
-				ctx->base.ctxr->data[i] = cpu_to_le32(req->state[i]);
-
-			if (req->finish) {
-				u64 count = req->processed[0] / EIP197_COUNTER_BLOCK_SIZE;
-				count += ((0xffffffff / EIP197_COUNTER_BLOCK_SIZE) *
-					  req->processed[1]);
-
-				/* This is a haredware limitation, as the
-				 * counter must fit into an u32. This represents
-				 * a farily big amount of input data, so we
-				 * shouldn't see this.
-				 */
-				if (unlikely(count & 0xffff0000)) {
-					dev_warn(priv->dev,
-						 "Input data is too big\n");
-					return;
-				}
-
-				ctx->base.ctxr->data[i] = cpu_to_le32(count);
+	/* Hash continuation or HMAC, setup (inner) digest from state */
+	memcpy(ctx->base.ctxr->data, req->state, req->state_sz);
+
+	if (req->finish) {
+		/* Compute digest count for hash/HMAC finish operations */
+		if ((req->digest == CONTEXT_CONTROL_DIGEST_PRECOMPUTED) ||
+		    req->processed[1] ||
+		    (req->processed[0] != req->block_sz)) {
+			count = req->processed[0] / EIP197_COUNTER_BLOCK_SIZE;
+			count += ((0x100000000ULL / EIP197_COUNTER_BLOCK_SIZE) *
+				  req->processed[1]);
+
+			/* This is a hardware limitation, as the
+			 * counter must fit into an u32. This represents
+			 * a fairly big amount of input data, so we
+			 * shouldn't see this.
+			 */
+			if (unlikely(count & 0xffffffff00000000ULL)) {
+				dev_warn(priv->dev,
+					 "Input data is too big\n");
+				return;
 			}
 		}
-	} else if (req->digest == CONTEXT_CONTROL_DIGEST_HMAC) {
-		cdesc->control_data.control0 |= CONTEXT_CONTROL_SIZE(2 * req->state_sz / sizeof(u32));
 
-		memcpy(ctx->base.ctxr->data, ctx->ipad, req->state_sz);
-		memcpy(ctx->base.ctxr->data + req->state_sz / sizeof(u32),
-		       ctx->opad, req->state_sz);
+		if ((req->digest == CONTEXT_CONTROL_DIGEST_PRECOMPUTED) ||
+		    /* PE HW < 4.4 cannot do HMAC continue, fake using hash */
+		    ((req->processed[1] ||
+		      (req->processed[0] != req->block_sz)))) {
+			/* Basic hash continue operation, need digest + cnt */
+			cdesc->control_data.control0 |=
+				CONTEXT_CONTROL_SIZE((req->state_sz >> 2) + 1) |
+				CONTEXT_CONTROL_TYPE_HASH_OUT |
+				CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
+			cdesc->control_data.control1 |=
+				CONTEXT_CONTROL_DIGEST_CNT;
+			ctx->base.ctxr->data[req->state_sz >> 2] =
+				cpu_to_le32(count);
+			req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
+		} else { /* HMAC */
+			/* Need outer digest for HMAC finalization */
+			memcpy(ctx->base.ctxr->data + (req->state_sz >> 2),
+			       ctx->opad, req->state_sz);
+
+			/* Single pass HMAC - no digest count */
+			cdesc->control_data.control0 |=
+				CONTEXT_CONTROL_SIZE(req->state_sz >> 1) |
+				CONTEXT_CONTROL_TYPE_HASH_OUT |
+				CONTEXT_CONTROL_DIGEST_HMAC;
+		}
+	} else { /* Hash continuation, do not finish yet */
+		cdesc->control_data.control0 |=
+			CONTEXT_CONTROL_SIZE(req->state_sz >> 2) |
+			CONTEXT_CONTROL_DIGEST_PRECOMPUTED |
+			CONTEXT_CONTROL_TYPE_HASH_OUT |
+			CONTEXT_CONTROL_NO_FINISH_HASH;
 	}
 }
 
-static int safexcel_handle_req_result(struct safexcel_crypto_priv *priv, int ring,
+static int safexcel_ahash_enqueue(struct ahash_request *areq);
+
+static int safexcel_handle_req_result(struct safexcel_crypto_priv *priv,
+				      int ring,
 				      struct crypto_async_request *async,
 				      bool *should_complete, int *ret)
 {
@@ -155,6 +180,7 @@ static int safexcel_handle_req_result(struct safexcel_crypto_priv *priv, int rin
 	struct ahash_request *areq = ahash_request_cast(async);
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(areq);
 	struct safexcel_ahash_req *sreq = ahash_request_ctx(areq);
+	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(ahash);
 	u64 cache_len;
 
 	*ret = 0;
@@ -188,9 +214,33 @@ static int safexcel_handle_req_result(struct safexcel_crypto_priv *priv, int rin
 		sreq->cache_sz = 0;
 	}
 
-	if (sreq->finish)
+	if (sreq->finish) {
+		if (sreq->hmac &&
+		    (sreq->digest != CONTEXT_CONTROL_DIGEST_HMAC)) {
+			/* Faking HMAC using hash - need to do outer hash */
+			memcpy(sreq->cache, sreq->state,
+			       crypto_ahash_digestsize(ahash));
+
+			memcpy(sreq->state, ctx->opad, sreq->state_sz);
+
+			sreq->len[0] = sreq->block_sz +
+				       crypto_ahash_digestsize(ahash);
+			sreq->len[1] = 0;
+			sreq->processed[0] = sreq->block_sz;
+			sreq->processed[1] = 0;
+			sreq->hmac = 0;
+
+			ctx->base.needs_inv = true;
+			areq->nbytes = 0;
+			safexcel_ahash_enqueue(areq);
+
+			*should_complete = false; /* Not done yet */
+			return 1;
+		}
+
 		memcpy(areq->result, sreq->state,
 		       crypto_ahash_digestsize(ahash));
+	}
 
 	cache_len = safexcel_queued_len(sreq);
 	if (cache_len)
@@ -205,7 +255,6 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 				   int *commands, int *results)
 {
 	struct ahash_request *areq = ahash_request_cast(async);
-	struct crypto_ahash *ahash = crypto_ahash_reqtfm(areq);
 	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
 	struct safexcel_crypto_priv *priv = ctx->priv;
@@ -213,27 +262,25 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 	struct safexcel_result_desc *rdesc;
 	struct scatterlist *sg;
 	int i, extra = 0, n_cdesc = 0, ret = 0;
-	u64 queued, len, cache_len, cache_max;
-
-	cache_max = crypto_ahash_blocksize(ahash);
+	u64 queued, len, cache_len;
 
 	queued = len = safexcel_queued_len(req);
-	if (queued <= cache_max)
+	if (queued <= HASH_CACHE_SIZE)
 		cache_len = queued;
 	else
 		cache_len = queued - areq->nbytes;
 
-	if (!req->last_req) {
+	if (!req->finish && !req->last_req) {
 		/* If this is not the last request and the queued data does not
-		 * fit into full blocks, cache it for the next send() call.
+		 * fit into full cache blocks, cache it for the next send call.
 		 */
-		extra = queued & (cache_max - 1);
+		extra = queued & (HASH_CACHE_SIZE - 1);
 
 		/* If this is not the last request and the queued data
 		 * is a multiple of a block, cache the last one for now.
 		 */
 		if (!extra)
-			extra = cache_max;
+			extra = HASH_CACHE_SIZE;
 
 		sg_pcopy_to_buffer(areq->src, sg_nents(areq->src),
 				   req->cache_next, extra,
@@ -272,8 +319,14 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 			goto send_command;
 	}
 
+	/* Skip descriptor generation for zero-length requests */
+	if (!areq->nbytes)
+		goto send_command;
+
 	/* Now handle the current ahash request buffer(s) */
-	req->nents = dma_map_sg(priv->dev, areq->src, sg_nents(areq->src),
+	req->nents = dma_map_sg(priv->dev, areq->src,
+				sg_nents_for_len(areq->src,
+						 areq->nbytes),
 				DMA_TO_DEVICE);
 	if (!req->nents) {
 		ret = -ENOMEM;
@@ -288,7 +341,8 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 			sglen = queued;
 
 		cdesc = safexcel_add_cdesc(priv, ring, !n_cdesc,
-					   !(queued - sglen), sg_dma_address(sg),
+					   !(queued - sglen),
+					   sg_dma_address(sg),
 					   sglen, len, ctx->base.ctxr_dma);
 		if (IS_ERR(cdesc)) {
 			ret = PTR_ERR(cdesc);
@@ -306,7 +360,7 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 
 send_command:
 	/* Setup the context options */
-	safexcel_context_control(ctx, req, first_cdesc, req->state_sz);
+	safexcel_context_control(ctx, req, first_cdesc);
 
 	/* Add the token */
 	safexcel_hash_token(first_cdesc, len, req->state_sz);
@@ -355,27 +409,6 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 	return ret;
 }
 
-static inline bool safexcel_ahash_needs_inv_get(struct ahash_request *areq)
-{
-	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
-	unsigned int state_w_sz = req->state_sz / sizeof(u32);
-	u64 processed;
-	int i;
-
-	processed = req->processed[0] / EIP197_COUNTER_BLOCK_SIZE;
-	processed += (0xffffffff / EIP197_COUNTER_BLOCK_SIZE) * req->processed[1];
-
-	for (i = 0; i < state_w_sz; i++)
-		if (ctx->base.ctxr->data[i] != cpu_to_le32(req->state[i]))
-			return true;
-
-	if (ctx->base.ctxr->data[state_w_sz] != cpu_to_le32(processed))
-		return true;
-
-	return false;
-}
-
 static int safexcel_handle_inv_result(struct safexcel_crypto_priv *priv,
 				      int ring,
 				      struct crypto_async_request *async,
@@ -523,30 +556,25 @@ static int safexcel_ahash_exit_inv(struct crypto_tfm *tfm)
 /* safexcel_ahash_cache: cache data until at least one request can be sent to
  * the engine, aka. when there is at least 1 block size in the pipe.
  */
-static int safexcel_ahash_cache(struct ahash_request *areq, u32 cache_max)
+static int safexcel_ahash_cache(struct ahash_request *areq)
 {
 	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
-	u64 queued, cache_len;
+	u64 cache_len;
 
-	/* queued: everything accepted by the driver which will be handled by
-	 * the next send() calls.
-	 * tot sz handled by update() - tot sz handled by send()
-	 */
-	queued = safexcel_queued_len(req);
 	/* cache_len: everything accepted by the driver but not sent yet,
 	 * tot sz handled by update() - last req sz - tot sz handled by send()
 	 */
-	cache_len = queued - areq->nbytes;
+	cache_len = safexcel_queued_len(req);
 
 	/*
 	 * In case there isn't enough bytes to proceed (less than a
 	 * block size), cache the data until we have enough.
 	 */
-	if (cache_len + areq->nbytes <= cache_max) {
+	if (cache_len + areq->nbytes <= HASH_CACHE_SIZE) {
 		sg_pcopy_to_buffer(areq->src, sg_nents(areq->src),
 				   req->cache + cache_len,
 				   areq->nbytes, 0);
-		return areq->nbytes;
+		return 0;
 	}
 
 	/* We couldn't cache all the data */
@@ -565,13 +593,25 @@ static int safexcel_ahash_enqueue(struct ahash_request *areq)
 	if (ctx->base.ctxr) {
 		if (priv->flags & EIP197_TRC_CACHE && !ctx->base.needs_inv &&
 		    (req->processed[0] || req->processed[1]) &&
-		    req->digest == CONTEXT_CONTROL_DIGEST_PRECOMPUTED)
-			/* We're still setting needs_inv here, even though it is
+		    (/* invalidate for basic hash continuation finish */
+		     (req->finish &&
+		      (req->digest == CONTEXT_CONTROL_DIGEST_PRECOMPUTED)) ||
+		     /* invalidate if (i)digest changed */
+		     memcmp(ctx->base.ctxr->data, req->state, req->state_sz) ||
+		     /* invalidate for HMAC continuation finish */
+		     (req->finish && (req->processed[1] ||
+		      (req->processed[0] != req->block_sz))) ||
+		     /* invalidate for HMAC finish with odigest changed */
+		     (req->finish &&
+		      memcmp(ctx->base.ctxr->data + (req->state_sz>>2),
+			     ctx->opad, req->state_sz))))
+			/*
+			 * We're still setting needs_inv here, even though it is
 			 * cleared right away, because the needs_inv flag can be
 			 * set in other functions and we want to keep the same
 			 * logic.
 			 */
-			ctx->base.needs_inv = safexcel_ahash_needs_inv_get(areq);
+			ctx->base.needs_inv = true;
 
 		if (ctx->base.needs_inv) {
 			ctx->base.needs_inv = false;
@@ -601,33 +641,25 @@ static int safexcel_ahash_enqueue(struct ahash_request *areq)
 static int safexcel_ahash_update(struct ahash_request *areq)
 {
 	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
-	struct crypto_ahash *ahash = crypto_ahash_reqtfm(areq);
-	u32 cache_max;
+	int ret;
 
 	/* If the request is 0 length, do nothing */
 	if (!areq->nbytes)
 		return 0;
 
+	/* Add request to the cache if it fits */
+	ret = safexcel_ahash_cache(areq);
+
+	/* Update total request length */
 	req->len[0] += areq->nbytes;
 	if (req->len[0] < areq->nbytes)
 		req->len[1]++;
 
-	cache_max = crypto_ahash_blocksize(ahash);
-
-	safexcel_ahash_cache(areq, cache_max);
-
-	/*
-	 * We're not doing partial updates when performing an hmac request.
-	 * Everything will be handled by the final() call.
+	/* If not all data could fit into the cache, go process the excess.
+	 * Also go process immediately for an HMAC IV precompute, which
+	 * will never be finished at all, but needs to be processed anyway.
 	 */
-	if (req->digest == CONTEXT_CONTROL_DIGEST_HMAC)
-		return 0;
-
-	if (req->hmac)
-		return safexcel_ahash_enqueue(areq);
-
-	if (!req->last_req &&
-	    safexcel_queued_len(req) > cache_max)
+	if ((ret && !req->finish) || req->last_req)
 		return safexcel_ahash_enqueue(areq);
 
 	return 0;
@@ -638,7 +670,6 @@ static int safexcel_ahash_final(struct ahash_request *areq)
 	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
 
-	req->last_req = true;
 	req->finish = true;
 
 	if (unlikely(!req->len[0] && !req->len[1] && !areq->nbytes)) {
@@ -667,6 +698,14 @@ static int safexcel_ahash_final(struct ahash_request *areq)
 			       SHA512_DIGEST_SIZE);
 
 		return 0;
+	} else if (unlikely(req->hmac && !req->len[1] &&
+			    (req->len[0] == req->block_sz) &&
+			    !areq->nbytes)) {
+		/* TODO: add support for zero length HMAC */
+		return 0;
+	} else if (req->hmac) {
+		/* Finalize HMAC */
+		req->digest = CONTEXT_CONTROL_DIGEST_HMAC;
 	}
 
 	return safexcel_ahash_enqueue(areq);
@@ -676,7 +715,6 @@ static int safexcel_ahash_finup(struct ahash_request *areq)
 {
 	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
 
-	req->last_req = true;
 	req->finish = true;
 
 	safexcel_ahash_update(areq);
@@ -685,12 +723,8 @@ static int safexcel_ahash_finup(struct ahash_request *areq)
 
 static int safexcel_ahash_export(struct ahash_request *areq, void *out)
 {
-	struct crypto_ahash *ahash = crypto_ahash_reqtfm(areq);
 	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
 	struct safexcel_ahash_export_state *export = out;
-	u32 cache_sz;
-
-	cache_sz = crypto_ahash_blocksize(ahash);
 
 	export->len[0] = req->len[0];
 	export->len[1] = req->len[1];
@@ -700,25 +734,21 @@ static int safexcel_ahash_export(struct ahash_request *areq, void *out)
 	export->digest = req->digest;
 
 	memcpy(export->state, req->state, req->state_sz);
-	memcpy(export->cache, req->cache, cache_sz);
+	memcpy(export->cache, req->cache, HASH_CACHE_SIZE);
 
 	return 0;
 }
 
 static int safexcel_ahash_import(struct ahash_request *areq, const void *in)
 {
-	struct crypto_ahash *ahash = crypto_ahash_reqtfm(areq);
 	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
 	const struct safexcel_ahash_export_state *export = in;
-	u32 cache_sz;
 	int ret;
 
 	ret = crypto_ahash_init(areq);
 	if (ret)
 		return ret;
 
-	cache_sz = crypto_ahash_blocksize(ahash);
-
 	req->len[0] = export->len[0];
 	req->len[1] = export->len[1];
 	req->processed[0] = export->processed[0];
@@ -726,7 +756,7 @@ static int safexcel_ahash_import(struct ahash_request *areq, const void *in)
 
 	req->digest = export->digest;
 
-	memcpy(req->cache, export->cache, cache_sz);
+	memcpy(req->cache, export->cache, HASH_CACHE_SIZE);
 	memcpy(req->state, export->state, req->state_sz);
 
 	return 0;
@@ -758,6 +788,7 @@ static int safexcel_sha1_init(struct ahash_request *areq)
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA1;
 	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
 	req->state_sz = SHA1_DIGEST_SIZE;
+	req->block_sz = SHA1_BLOCK_SIZE;
 
 	return 0;
 }
@@ -823,10 +854,23 @@ struct safexcel_alg_template safexcel_alg_sha1 = {
 
 static int safexcel_hmac_sha1_init(struct ahash_request *areq)
 {
+	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
 	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
 
-	safexcel_sha1_init(areq);
-	req->digest = CONTEXT_CONTROL_DIGEST_HMAC;
+	memset(req, 0, sizeof(*req));
+
+	/* Start from ipad precompute */
+	memcpy(req->state, ctx->ipad, SHA1_DIGEST_SIZE);
+	/* Already processed the key^ipad part now! */
+	req->len[0]	  = SHA1_BLOCK_SIZE;
+	req->processed[0] = SHA1_BLOCK_SIZE;
+
+	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA1;
+	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
+	req->state_sz = SHA1_DIGEST_SIZE;
+	req->block_sz = SHA1_BLOCK_SIZE;
+	req->hmac = true;
+
 	return 0;
 }
 
@@ -995,21 +1039,16 @@ static int safexcel_hmac_alg_setkey(struct crypto_ahash *tfm, const u8 *key,
 	struct safexcel_ahash_ctx *ctx = crypto_tfm_ctx(crypto_ahash_tfm(tfm));
 	struct safexcel_crypto_priv *priv = ctx->priv;
 	struct safexcel_ahash_export_state istate, ostate;
-	int ret, i;
+	int ret;
 
 	ret = safexcel_hmac_setkey(alg, key, keylen, &istate, &ostate);
 	if (ret)
 		return ret;
 
-	if (priv->flags & EIP197_TRC_CACHE && ctx->base.ctxr) {
-		for (i = 0; i < state_sz / sizeof(u32); i++) {
-			if (ctx->ipad[i] != le32_to_cpu(istate.state[i]) ||
-			    ctx->opad[i] != le32_to_cpu(ostate.state[i])) {
-				ctx->base.needs_inv = true;
-				break;
-			}
-		}
-	}
+	if (priv->flags & EIP197_TRC_CACHE && ctx->base.ctxr &&
+	    (memcmp(ctx->ipad, istate.state, state_sz) ||
+	     memcmp(ctx->opad, ostate.state, state_sz)))
+		ctx->base.needs_inv = true;
 
 	memcpy(ctx->ipad, &istate.state, state_sz);
 	memcpy(ctx->opad, &ostate.state, state_sz);
@@ -1064,6 +1103,7 @@ static int safexcel_sha256_init(struct ahash_request *areq)
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA256;
 	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
 	req->state_sz = SHA256_DIGEST_SIZE;
+	req->block_sz = SHA256_BLOCK_SIZE;
 
 	return 0;
 }
@@ -1117,6 +1157,7 @@ static int safexcel_sha224_init(struct ahash_request *areq)
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA224;
 	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
 	req->state_sz = SHA256_DIGEST_SIZE;
+	req->block_sz = SHA256_BLOCK_SIZE;
 
 	return 0;
 }
@@ -1169,10 +1210,23 @@ static int safexcel_hmac_sha224_setkey(struct crypto_ahash *tfm, const u8 *key,
 
 static int safexcel_hmac_sha224_init(struct ahash_request *areq)
 {
+	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
 	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
 
-	safexcel_sha224_init(areq);
-	req->digest = CONTEXT_CONTROL_DIGEST_HMAC;
+	memset(req, 0, sizeof(*req));
+
+	/* Start from ipad precompute */
+	memcpy(req->state, ctx->ipad, SHA256_DIGEST_SIZE);
+	/* Already processed the key^ipad part now! */
+	req->len[0]	  = SHA256_BLOCK_SIZE;
+	req->processed[0] = SHA256_BLOCK_SIZE;
+
+	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA224;
+	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
+	req->state_sz = SHA256_DIGEST_SIZE;
+	req->block_sz = SHA256_BLOCK_SIZE;
+	req->hmac = true;
+
 	return 0;
 }
 
@@ -1225,10 +1279,23 @@ static int safexcel_hmac_sha256_setkey(struct crypto_ahash *tfm, const u8 *key,
 
 static int safexcel_hmac_sha256_init(struct ahash_request *areq)
 {
+	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
 	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
 
-	safexcel_sha256_init(areq);
-	req->digest = CONTEXT_CONTROL_DIGEST_HMAC;
+	memset(req, 0, sizeof(*req));
+
+	/* Start from ipad precompute */
+	memcpy(req->state, ctx->ipad, SHA256_DIGEST_SIZE);
+	/* Already processed the key^ipad part now! */
+	req->len[0]	  = SHA256_BLOCK_SIZE;
+	req->processed[0] = SHA256_BLOCK_SIZE;
+
+	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA256;
+	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
+	req->state_sz = SHA256_DIGEST_SIZE;
+	req->block_sz = SHA256_BLOCK_SIZE;
+	req->hmac = true;
+
 	return 0;
 }
 
@@ -1282,6 +1349,7 @@ static int safexcel_sha512_init(struct ahash_request *areq)
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA512;
 	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
 	req->state_sz = SHA512_DIGEST_SIZE;
+	req->block_sz = SHA512_BLOCK_SIZE;
 
 	return 0;
 }
@@ -1335,6 +1403,7 @@ static int safexcel_sha384_init(struct ahash_request *areq)
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA384;
 	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
 	req->state_sz = SHA512_DIGEST_SIZE;
+	req->block_sz = SHA512_BLOCK_SIZE;
 
 	return 0;
 }
@@ -1387,10 +1456,23 @@ static int safexcel_hmac_sha512_setkey(struct crypto_ahash *tfm, const u8 *key,
 
 static int safexcel_hmac_sha512_init(struct ahash_request *areq)
 {
+	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
 	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
 
-	safexcel_sha512_init(areq);
-	req->digest = CONTEXT_CONTROL_DIGEST_HMAC;
+	memset(req, 0, sizeof(*req));
+
+	/* Start from ipad precompute */
+	memcpy(req->state, ctx->ipad, SHA512_DIGEST_SIZE);
+	/* Already processed the key^ipad part now! */
+	req->len[0]	  = SHA512_BLOCK_SIZE;
+	req->processed[0] = SHA512_BLOCK_SIZE;
+
+	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA512;
+	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
+	req->state_sz = SHA512_DIGEST_SIZE;
+	req->block_sz = SHA512_BLOCK_SIZE;
+	req->hmac = true;
+
 	return 0;
 }
 
@@ -1443,10 +1525,23 @@ static int safexcel_hmac_sha384_setkey(struct crypto_ahash *tfm, const u8 *key,
 
 static int safexcel_hmac_sha384_init(struct ahash_request *areq)
 {
+	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
 	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
 
-	safexcel_sha384_init(areq);
-	req->digest = CONTEXT_CONTROL_DIGEST_HMAC;
+	memset(req, 0, sizeof(*req));
+
+	/* Start from ipad precompute */
+	memcpy(req->state, ctx->ipad, SHA512_DIGEST_SIZE);
+	/* Already processed the key^ipad part now! */
+	req->len[0]	  = SHA512_BLOCK_SIZE;
+	req->processed[0] = SHA512_BLOCK_SIZE;
+
+	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA384;
+	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
+	req->state_sz = SHA512_DIGEST_SIZE;
+	req->block_sz = SHA512_BLOCK_SIZE;
+	req->hmac = true;
+
 	return 0;
 }
 
@@ -1500,6 +1595,7 @@ static int safexcel_md5_init(struct ahash_request *areq)
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_MD5;
 	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
 	req->state_sz = MD5_DIGEST_SIZE;
+	req->block_sz = MD5_HMAC_BLOCK_SIZE;
 
 	return 0;
 }
@@ -1545,10 +1641,23 @@ struct safexcel_alg_template safexcel_alg_md5 = {
 
 static int safexcel_hmac_md5_init(struct ahash_request *areq)
 {
+	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
 	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
 
-	safexcel_md5_init(areq);
-	req->digest = CONTEXT_CONTROL_DIGEST_HMAC;
+	memset(req, 0, sizeof(*req));
+
+	/* Start from ipad precompute */
+	memcpy(req->state, ctx->ipad, MD5_DIGEST_SIZE);
+	/* Already processed the key^ipad part now! */
+	req->len[0]	  = MD5_HMAC_BLOCK_SIZE;
+	req->processed[0] = MD5_HMAC_BLOCK_SIZE;
+
+	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_MD5;
+	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
+	req->state_sz = MD5_DIGEST_SIZE;
+	req->block_sz = MD5_HMAC_BLOCK_SIZE;
+	req->hmac = true;
+
 	return 0;
 }
 
-- 
1.8.3.1


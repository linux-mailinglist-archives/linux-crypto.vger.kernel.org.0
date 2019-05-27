Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 501052B7E2
	for <lists+linux-crypto@lfdr.de>; Mon, 27 May 2019 16:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfE0Ovq (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 27 May 2019 10:51:46 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:55469 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfE0Ovp (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 27 May 2019 10:51:45 -0400
X-Originating-IP: 90.88.147.134
Received: from localhost (aaubervilliers-681-1-27-134.w90-88.abo.wanadoo.fr [90.88.147.134])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 7C69BFF814;
        Mon, 27 May 2019 14:51:42 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, igall@marvell.com
Subject: [PATCH 12/14] crypto: inside-secure - add support for HMAC updates
Date:   Mon, 27 May 2019 16:51:04 +0200
Message-Id: <20190527145106.8693-13-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527145106.8693-1-antoine.tenart@bootlin.com>
References: <20190527145106.8693-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch adds support for HMAC updates in the Inside Secure SafeXcel
crypto engine driver. Updates were supported for hash algorithms, but
were never enabled for HMAC ones. This fixes boot time test issues.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/crypto/inside-secure/safexcel.h      |  2 +-
 drivers/crypto/inside-secure/safexcel_hash.c | 58 +++++++++++++-------
 2 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel.h b/drivers/crypto/inside-secure/safexcel.h
index ca6ece5607cd..e0c202f33674 100644
--- a/drivers/crypto/inside-secure/safexcel.h
+++ b/drivers/crypto/inside-secure/safexcel.h
@@ -644,7 +644,7 @@ struct safexcel_ahash_export_state {
 	u32 digest;
 
 	u32 state[SHA512_DIGEST_SIZE / sizeof(u32)];
-	u8 cache[SHA512_BLOCK_SIZE];
+	u8 cache[SHA512_BLOCK_SIZE << 1];
 };
 
 /*
diff --git a/drivers/crypto/inside-secure/safexcel_hash.c b/drivers/crypto/inside-secure/safexcel_hash.c
index a9197d2c5a48..20950744ea4e 100644
--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -41,11 +41,11 @@ struct safexcel_ahash_req {
 	u64 len[2];
 	u64 processed[2];
 
-	u8 cache[SHA512_BLOCK_SIZE] __aligned(sizeof(u32));
+	u8 cache[SHA512_BLOCK_SIZE << 1] __aligned(sizeof(u32));
 	dma_addr_t cache_dma;
 	unsigned int cache_sz;
 
-	u8 cache_next[SHA512_BLOCK_SIZE] __aligned(sizeof(u32));
+	u8 cache_next[SHA512_BLOCK_SIZE << 1] __aligned(sizeof(u32));
 };
 
 static inline u64 safexcel_queued_len(struct safexcel_ahash_req *req)
@@ -89,6 +89,9 @@ static void safexcel_context_control(struct safexcel_ahash_ctx *ctx,
 	cdesc->control_data.control0 |= ctx->alg;
 	cdesc->control_data.control0 |= req->digest;
 
+	if (!req->finish)
+		cdesc->control_data.control0 |= CONTEXT_CONTROL_NO_FINISH_HASH;
+
 	if (req->digest == CONTEXT_CONTROL_DIGEST_PRECOMPUTED) {
 		if (req->processed[0] || req->processed[1]) {
 			if (ctx->alg == CONTEXT_CONTROL_CRYPTO_ALG_MD5)
@@ -107,9 +110,6 @@ static void safexcel_context_control(struct safexcel_ahash_ctx *ctx,
 			cdesc->control_data.control0 |= CONTEXT_CONTROL_RESTART_HASH;
 		}
 
-		if (!req->finish)
-			cdesc->control_data.control0 |= CONTEXT_CONTROL_NO_FINISH_HASH;
-
 		/*
 		 * Copy the input digest if needed, and setup the context
 		 * fields. Do this now as we need it to setup the first command
@@ -212,11 +212,15 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 	struct safexcel_command_desc *cdesc, *first_cdesc = NULL;
 	struct safexcel_result_desc *rdesc;
 	struct scatterlist *sg;
-	int i, extra, n_cdesc = 0, ret = 0;
-	u64 queued, len, cache_len;
+	int i, extra = 0, n_cdesc = 0, ret = 0;
+	u64 queued, len, cache_len, cache_max;
+
+	cache_max = crypto_ahash_blocksize(ahash);
+	if (req->digest == CONTEXT_CONTROL_DIGEST_HMAC)
+		cache_max <<= 1;
 
 	queued = len = safexcel_queued_len(req);
-	if (queued <= crypto_ahash_blocksize(ahash))
+	if (queued <= cache_max)
 		cache_len = queued;
 	else
 		cache_len = queued - areq->nbytes;
@@ -227,6 +231,10 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 		 */
 		extra = queued & (crypto_ahash_blocksize(ahash) - 1);
 
+		if (req->digest == CONTEXT_CONTROL_DIGEST_HMAC &&
+		    extra < crypto_ahash_blocksize(ahash))
+			extra += crypto_ahash_blocksize(ahash);
+
 		/* If this is not the last request and the queued data
 		 * is a multiple of a block, cache the last one for now.
 		 */
@@ -239,12 +247,6 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 
 		queued -= extra;
 		len -= extra;
-
-		if (!queued) {
-			*commands = 0;
-			*results = 0;
-			return 0;
-		}
 	}
 
 	/* Add a command descriptor for the cached data, if any */
@@ -522,10 +524,9 @@ static int safexcel_ahash_exit_inv(struct crypto_tfm *tfm)
 /* safexcel_ahash_cache: cache data until at least one request can be sent to
  * the engine, aka. when there is at least 1 block size in the pipe.
  */
-static int safexcel_ahash_cache(struct ahash_request *areq)
+static int safexcel_ahash_cache(struct ahash_request *areq, u32 cache_max)
 {
 	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
-	struct crypto_ahash *ahash = crypto_ahash_reqtfm(areq);
 	u64 queued, cache_len;
 
 	/* queued: everything accepted by the driver which will be handled by
@@ -542,7 +543,7 @@ static int safexcel_ahash_cache(struct ahash_request *areq)
 	 * In case there isn't enough bytes to proceed (less than a
 	 * block size), cache the data until we have enough.
 	 */
-	if (cache_len + areq->nbytes <= crypto_ahash_blocksize(ahash)) {
+	if (cache_len + areq->nbytes <= cache_max) {
 		sg_pcopy_to_buffer(areq->src, sg_nents(areq->src),
 				   req->cache + cache_len,
 				   areq->nbytes, 0);
@@ -602,6 +603,7 @@ static int safexcel_ahash_update(struct ahash_request *areq)
 {
 	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(areq);
+	u32 cache_max;
 
 	/* If the request is 0 length, do nothing */
 	if (!areq->nbytes)
@@ -611,7 +613,11 @@ static int safexcel_ahash_update(struct ahash_request *areq)
 	if (req->len[0] < areq->nbytes)
 		req->len[1]++;
 
-	safexcel_ahash_cache(areq);
+	cache_max = crypto_ahash_blocksize(ahash);
+	if (req->digest == CONTEXT_CONTROL_DIGEST_HMAC)
+		cache_max <<= 1;
+
+	safexcel_ahash_cache(areq, cache_max);
 
 	/*
 	 * We're not doing partial updates when performing an hmac request.
@@ -624,7 +630,7 @@ static int safexcel_ahash_update(struct ahash_request *areq)
 		return safexcel_ahash_enqueue(areq);
 
 	if (!req->last_req &&
-	    safexcel_queued_len(req) > crypto_ahash_blocksize(ahash))
+	    safexcel_queued_len(req) > cache_max)
 		return safexcel_ahash_enqueue(areq);
 
 	return 0;
@@ -681,6 +687,11 @@ static int safexcel_ahash_export(struct ahash_request *areq, void *out)
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(areq);
 	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
 	struct safexcel_ahash_export_state *export = out;
+	u32 cache_sz;
+
+	cache_sz = crypto_ahash_blocksize(ahash);
+	if (req->digest == CONTEXT_CONTROL_DIGEST_HMAC)
+		cache_sz <<= 1;
 
 	export->len[0] = req->len[0];
 	export->len[1] = req->len[1];
@@ -690,7 +701,7 @@ static int safexcel_ahash_export(struct ahash_request *areq, void *out)
 	export->digest = req->digest;
 
 	memcpy(export->state, req->state, req->state_sz);
-	memcpy(export->cache, req->cache, crypto_ahash_blocksize(ahash));
+	memcpy(export->cache, req->cache, cache_sz);
 
 	return 0;
 }
@@ -700,12 +711,17 @@ static int safexcel_ahash_import(struct ahash_request *areq, const void *in)
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(areq);
 	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
 	const struct safexcel_ahash_export_state *export = in;
+	u32 cache_sz;
 	int ret;
 
 	ret = crypto_ahash_init(areq);
 	if (ret)
 		return ret;
 
+	cache_sz = crypto_ahash_blocksize(ahash);
+	if (req->digest == CONTEXT_CONTROL_DIGEST_HMAC)
+		cache_sz <<= 1;
+
 	req->len[0] = export->len[0];
 	req->len[1] = export->len[1];
 	req->processed[0] = export->processed[0];
@@ -713,7 +729,7 @@ static int safexcel_ahash_import(struct ahash_request *areq, const void *in)
 
 	req->digest = export->digest;
 
-	memcpy(req->cache, export->cache, crypto_ahash_blocksize(ahash));
+	memcpy(req->cache, export->cache, cache_sz);
 	memcpy(req->state, export->state, req->state_sz);
 
 	return 0;
-- 
2.21.0


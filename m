Return-Path: <linux-crypto+bounces-10261-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04025A4964E
	for <lists+linux-crypto@lfdr.de>; Fri, 28 Feb 2025 11:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021BD168D57
	for <lists+linux-crypto@lfdr.de>; Fri, 28 Feb 2025 10:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991F525EFA8;
	Fri, 28 Feb 2025 10:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fylQsflm"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3D725DCEF;
	Fri, 28 Feb 2025 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736842; cv=none; b=E61fYwzbjrRrUR69NVs8JvxAeD/CubenxWrY0sbN6LuuxywZrw5DVLMGP373Vr1zW346sbm0OBhKXOpSPXnuVXxMGwO7UjgaKzJ/4xJt8Ue7F5KHN91W9Rl66qTq5Msh7hl6PNAPZndDZdMYbUNme11S8yyeIx/MZrIIoJzJ2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736842; c=relaxed/simple;
	bh=9EoxRBYCdba2ggIV7HlnyrqEHWRv9T6X+J8nbbYqe1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hC/FwaKQ+uXcR4nUyq6rhqtM60Bv82rQjVm+N9fyePD8JmEJU1SAYl3VCxpsx4PMM6cgmIGLABiFwJSXsuvbXWz2WJemDXPaQzhjMtixDjV6iQqRmiXthnkhmQeFYhAyh9gP+gJg3Rk9zQineDzChVP2oezZTtW44I+NK6FEqYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fylQsflm; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740736839; x=1772272839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9EoxRBYCdba2ggIV7HlnyrqEHWRv9T6X+J8nbbYqe1A=;
  b=fylQsflmAo/YecCQ4sTER5+lsOA3v/vkA1xfVdQKtIbDBrbLk7JaTOju
   oiNBM1NlU5EHdUMkfnfsO/IKUsI0vbFKWgT7YD9qI9Rho25E/SMFlExfS
   gxW7+nCvP9wfQOgopOYIMAu97LzhVQp5aiKAltctfI/sQtXnbUgiPWYa2
   KaU2+oVhyCVA/bbXzzHnIOTb1d2Qos5XYhXD7iLFyQr/eUFQt2p7SYLhS
   g1Bx0CYww9Mq+jr5zbGWzdpgSi2wwuhzCNPImecibbj3hoMmw0PWJV89+
   zh47LRp5MiCq7jtp2oYANpIulbBCKZGkHNUOyLMK4cWy9QIuSUh9sPd17
   A==;
X-CSE-ConnectionGUID: xcCuZ7xQQwKmGsESGkVVKA==
X-CSE-MsgGUID: +wnj+PtUSwK061PxI1DcZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="40902719"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="40902719"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 02:00:29 -0800
X-CSE-ConnectionGUID: pMzcQvOITtOWPzaQXSTBqw==
X-CSE-MsgGUID: IXxfhbbtQEeK9DMYHChuYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="117325750"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.115])
  by orviesa006.jf.intel.com with ESMTP; 28 Feb 2025 02:00:29 -0800
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	21cnbao@gmail.com,
	ying.huang@linux.alibaba.com,
	akpm@linux-foundation.org,
	linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	clabbe@baylibre.com,
	ardb@kernel.org,
	ebiggers@google.com,
	surenb@google.com,
	kristen.c.accardi@intel.com
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v7 13/15] mm: zswap: Allocate pool batching resources if the compressor supports batching.
Date: Fri, 28 Feb 2025 02:00:22 -0800
Message-Id: <20250228100024.332528-14-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250228100024.332528-1-kanchana.p.sridhar@intel.com>
References: <20250228100024.332528-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for the per-CPU acomp_ctx to track multiple
compression/decompression requests and multiple compression destination
buffers. The zswap_cpu_comp_prepare() CPU onlining code will get the
maximum batch-size the compressor supports. If so, it will allocate the
necessary batching resources.

However, zswap does not use more than one request yet. Follow-up patches
will actually utilize the multiple acomp_ctx requests/buffers for batch
compression/decompression of multiple pages.

The newly added ZSWAP_MAX_BATCH_SIZE limits the amount of extra memory used
for batching. There is a small extra memory overhead of allocating the
"reqs" and "buffers" arrays for compressors that do not support batching.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/zswap.c | 100 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 31 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 3a93714a9327..6aa602b8514e 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -78,6 +78,16 @@ static bool zswap_pool_reached_full;
 
 #define ZSWAP_PARAM_UNSET ""
 
+/*
+ * For compression batching of large folios:
+ * Maximum number of acomp compress requests that will be processed
+ * in a batch, iff the zswap compressor supports batching.
+ * This limit exists because we preallocate enough requests and buffers
+ * in the per-cpu acomp_ctx accordingly. Hence, a higher limit means higher
+ * memory usage.
+ */
+#define ZSWAP_MAX_BATCH_SIZE 8U
+
 static int zswap_setup(void);
 
 /* Enable/disable zswap */
@@ -143,8 +153,8 @@ bool zswap_never_enabled(void)
 
 struct crypto_acomp_ctx {
 	struct crypto_acomp *acomp;
-	struct acomp_req *req;
-	u8 *buffer;
+	struct acomp_req **reqs;
+	u8 **buffers;
 	unsigned int nr_reqs;
 	struct crypto_wait wait;
 	struct mutex mutex;
@@ -251,13 +261,22 @@ static void __zswap_pool_empty(struct percpu_ref *ref);
 static void acomp_ctx_dealloc(struct crypto_acomp_ctx *acomp_ctx)
 {
 	if (!IS_ERR_OR_NULL(acomp_ctx) && acomp_ctx->nr_reqs) {
+		int i;
+
+		if (acomp_ctx->reqs) {
+			for (i = 0; i < acomp_ctx->nr_reqs; ++i)
+				if (!IS_ERR_OR_NULL(acomp_ctx->reqs[i]))
+					acomp_request_free(acomp_ctx->reqs[i]);
+			kfree(acomp_ctx->reqs);
+			acomp_ctx->reqs = NULL;
+		}
 
-		if (!IS_ERR_OR_NULL(acomp_ctx->req))
-			acomp_request_free(acomp_ctx->req);
-		acomp_ctx->req = NULL;
-
-		kfree(acomp_ctx->buffer);
-		acomp_ctx->buffer = NULL;
+		if (acomp_ctx->buffers) {
+			for (i = 0; i < acomp_ctx->nr_reqs; ++i)
+				kfree(acomp_ctx->buffers[i]);
+			kfree(acomp_ctx->buffers);
+			acomp_ctx->buffers = NULL;
+		}
 
 		if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
 			crypto_free_acomp(acomp_ctx->acomp);
@@ -270,7 +289,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 {
 	struct zswap_pool *pool = hlist_entry(node, struct zswap_pool, node);
 	struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
-	int ret = -ENOMEM;
+	int i, ret = -ENOMEM;
 
 	/*
 	 * Just to be even more fail-safe against changes in assumptions and/or
@@ -292,22 +311,41 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 		goto fail;
 	}
 
-	acomp_ctx->nr_reqs = 1;
+	acomp_ctx->nr_reqs = min(ZSWAP_MAX_BATCH_SIZE,
+				 crypto_acomp_batch_size(acomp_ctx->acomp));
 
-	acomp_ctx->req = acomp_request_alloc(acomp_ctx->acomp);
-	if (!acomp_ctx->req) {
-		pr_err("could not alloc crypto acomp_request %s\n",
-		       pool->tfm_name);
-		ret = -ENOMEM;
+	acomp_ctx->reqs = kcalloc_node(acomp_ctx->nr_reqs, sizeof(struct acomp_req *),
+				       GFP_KERNEL, cpu_to_node(cpu));
+	if (!acomp_ctx->reqs)
 		goto fail;
+
+	for (i = 0; i < acomp_ctx->nr_reqs; ++i) {
+		acomp_ctx->reqs[i] = acomp_request_alloc(acomp_ctx->acomp);
+		if (!acomp_ctx->reqs[i]) {
+			pr_err("could not alloc crypto acomp_request reqs[%d] %s\n",
+				i, pool->tfm_name);
+			goto fail;
+		}
 	}
 
-	acomp_ctx->buffer = kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL, cpu_to_node(cpu));
-	if (!acomp_ctx->buffer) {
-		ret = -ENOMEM;
+	acomp_ctx->buffers = kcalloc_node(acomp_ctx->nr_reqs, sizeof(u8 *),
+					  GFP_KERNEL, cpu_to_node(cpu));
+	if (!acomp_ctx->buffers)
 		goto fail;
+
+	for (i = 0; i < acomp_ctx->nr_reqs; ++i) {
+		acomp_ctx->buffers[i] = kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL,
+						     cpu_to_node(cpu));
+		if (!acomp_ctx->buffers[i])
+			goto fail;
 	}
 
+	/*
+	 * The crypto_wait is used only in fully synchronous, i.e., with scomp
+	 * or non-poll mode of acomp, hence there is only one "wait" per
+	 * acomp_ctx, with callback set to reqs[0], under the assumption that
+	 * there is at least 1 request per acomp_ctx.
+	 */
 	crypto_init_wait(&acomp_ctx->wait);
 
 	/*
@@ -315,7 +353,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 	 * crypto_wait_req(); if the backend of acomp is scomp, the callback
 	 * won't be called, crypto_wait_req() will return without blocking.
 	 */
-	acomp_request_set_callback(acomp_ctx->req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+	acomp_request_set_callback(acomp_ctx->reqs[0], CRYPTO_TFM_REQ_MAY_BACKLOG,
 				   crypto_req_done, &acomp_ctx->wait);
 
 	acomp_ctx->is_sleepable = acomp_is_async(acomp_ctx->acomp);
@@ -407,8 +445,8 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 		struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
 
 		acomp_ctx->acomp = NULL;
-		acomp_ctx->req = NULL;
-		acomp_ctx->buffer = NULL;
+		acomp_ctx->reqs = NULL;
+		acomp_ctx->buffers = NULL;
 		acomp_ctx->__online = false;
 		acomp_ctx->nr_reqs = 0;
 		mutex_init(&acomp_ctx->mutex);
@@ -1026,7 +1064,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	u8 *dst;
 
 	acomp_ctx = acomp_ctx_get_cpu_lock(pool);
-	dst = acomp_ctx->buffer;
+	dst = acomp_ctx->buffers[0];
 	sg_init_table(&input, 1);
 	sg_set_page(&input, page, PAGE_SIZE, 0);
 
@@ -1036,7 +1074,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	 * giving the dst buffer with enough length to avoid buffer overflow.
 	 */
 	sg_init_one(&output, dst, PAGE_SIZE * 2);
-	acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE_SIZE, dlen);
+	acomp_request_set_params(acomp_ctx->reqs[0], &input, &output, PAGE_SIZE, dlen);
 
 	/*
 	 * it maybe looks a little bit silly that we send an asynchronous request,
@@ -1050,8 +1088,8 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	 * but in different threads running on different cpu, we have different
 	 * acomp instance, so multiple threads can do (de)compression in parallel.
 	 */
-	comp_ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
-	dlen = acomp_ctx->req->dlen;
+	comp_ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->reqs[0]), &acomp_ctx->wait);
+	dlen = acomp_ctx->reqs[0]->dlen;
 	if (comp_ret)
 		goto unlock;
 
@@ -1102,19 +1140,19 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	 */
 	if ((acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)) ||
 	    !virt_addr_valid(src)) {
-		memcpy(acomp_ctx->buffer, src, entry->length);
-		src = acomp_ctx->buffer;
+		memcpy(acomp_ctx->buffers[0], src, entry->length);
+		src = acomp_ctx->buffers[0];
 		zpool_unmap_handle(zpool, entry->handle);
 	}
 
 	sg_init_one(&input, src, entry->length);
 	sg_init_table(&output, 1);
 	sg_set_folio(&output, folio, PAGE_SIZE, 0);
-	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
-	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
-	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
+	acomp_request_set_params(acomp_ctx->reqs[0], &input, &output, entry->length, PAGE_SIZE);
+	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->reqs[0]), &acomp_ctx->wait));
+	BUG_ON(acomp_ctx->reqs[0]->dlen != PAGE_SIZE);
 
-	if (src != acomp_ctx->buffer)
+	if (src != acomp_ctx->buffers[0])
 		zpool_unmap_handle(zpool, entry->handle);
 	acomp_ctx_put_unlock(acomp_ctx);
 }
-- 
2.27.0



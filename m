Return-Path: <linux-crypto+bounces-10430-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73981A4EAB8
	for <lists+linux-crypto@lfdr.de>; Tue,  4 Mar 2025 19:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C043B3782
	for <lists+linux-crypto@lfdr.de>; Tue,  4 Mar 2025 17:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35978280400;
	Tue,  4 Mar 2025 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1B/AgcL"
X-Original-To: linux-crypto@vger.kernel.org
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E310F25F988
	for <linux-crypto@vger.kernel.org>; Tue,  4 Mar 2025 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109225; cv=fail; b=sWylJyTuwHbYvh1zyhK2giyZCW7XNCzeJJ8rXgM9fKZx0yxjc9q+avkiPrWqFWelNSpniu+wtWngya26zIadL6ZErY9asHrl+E12FJ1JWUGFQ/rA7hFF4FVKKIE2LlCHBL7SKFXrmXH2zYqe1lJNfq3zbg9yQLws/SgDt8YY3Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109225; c=relaxed/simple;
	bh=JjO45+yHGJNaurW5/n/EIHdQndhrv/uTCGRkga/QmII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CGD35IWDCjz9U0okaC6fcBQJCczL93mPakC1WBKOWXTNKNZCspfzCNUDmdj0fBi7/UPilWIcJQnSMzqX4HKC4sCYzIFaVGN5tuTSDgmZ6KTWVvtBBOQDZ4qGh1bd3qkv5W5xbe8Vs5rwjRvTTcIrGm9TrNe0AT26S5e5rup6brU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1B/AgcL reason="signature verification failed"; arc=none smtp.client-ip=192.198.163.14; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id C253A408B646
	for <linux-crypto@vger.kernel.org>; Tue,  4 Mar 2025 20:27:00 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m1B/AgcL
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6ghp6vZTzG29P
	for <linux-crypto@vger.kernel.org>; Tue,  4 Mar 2025 19:13:30 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id F10FC42720; Tue,  4 Mar 2025 19:13:20 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1B/AgcL
X-Envelope-From: <linux-kernel+bounces-541197-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1B/AgcL
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id BD6EB42035
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:53:12 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 955F82DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:53:12 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87FDE1892EAD
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9126A1F4E4B;
	Mon,  3 Mar 2025 08:47:51 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58431F130C;
	Mon,  3 Mar 2025 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991666; cv=none; b=TG0jEB7PH6NjUE6TBeM4kTTYPXGBmCmkLbrks8f76pymuy+1+sU8goPgVUBKZfkOFATN2aITUSTbHRka57mKZpziUv4bsrVX+kv84R3/YoSSu2LLk3DSZGC4y6tdtTfs7CFxHYOuHj3c+OU9QJmeA24IJlPJOmqef1ibvV+nnxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991666; c=relaxed/simple;
	bh=mzM5ALTaJ0aweiEptVLygcT+eKuMHDddBO1cMIOmY5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nDi5o6rLMuDc4m0fns7tE2zE03l/Lcm23YaltNxVe6jVqe2QELuDNjGmfLzsp1B9rR3dJEnxtt1cbt3rbZjmCXv03KgUPvDARBBOWWFKa2uDcD8cBrhyQl8UH4LRohZr5iEMX3TvxzV4Y4obOejhkMOHaqzfPajW4NoeaT0lnyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1B/AgcL; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740991665; x=1772527665;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mzM5ALTaJ0aweiEptVLygcT+eKuMHDddBO1cMIOmY5c=;
  b=m1B/AgcLtUhvYbpJE1+UVl1vgFgConOvdEPX1imXuGUpeLb6kjCDhOFK
   5qoSNwf60Ju1coNTezJl4ixH0KdGfvz7bZtdcVurzfPNd51VuP1IYULsa
   L2/SsVyvE/F2WJFGtmzHLzTZNGU4cU7jVSmHsTOOKApIK7FHQu9iNhqmw
   mFmvWnaCT5IfoaVGG55KxInTrrR4rS0U8GdaBpiMv6VcROKONPJJQtAiZ
   A5uu5DifFBPffwpVYLKKKTft2b298y6srS8HO1eXgi22mK0NRHVf/DdmC
   hRVblSDY6yMhIAN1mZ5UeuA39EPU7YfQryuHMg3QFCLg/w+BMv6KbochF
   A==;
X-CSE-ConnectionGUID: WwZyvSgxT66VPjEjUhmlVg==
X-CSE-MsgGUID: DZLNIhyPSXul57FF91Ppxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="42112018"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="42112018"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 00:47:40 -0800
X-CSE-ConnectionGUID: ehvg2B31TRqs9zpVgL56/w==
X-CSE-MsgGUID: pKsO428nSeatt0KiCUhTdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="118426829"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.115])
  by fmviesa010.fm.intel.com with ESMTP; 03 Mar 2025 00:47:38 -0800
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
Subject: [PATCH v8 13/14] mm: zswap: Allocate pool batching resources if the compressor supports batching.
Date: Mon,  3 Mar 2025 00:47:23 -0800
Message-Id: <20250303084724.6490-14-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250303084724.6490-1-kanchana.p.sridhar@intel.com>
References: <20250303084724.6490-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6ghp6vZTzG29P
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741713921.10988@PImvX86EsQEnhEcgSSILJg
X-ITU-MailScanner-SpamCheck: not spam

This patch adds support for the per-CPU acomp_ctx to track multiple
compression/decompression requests and multiple compression destination
buffers. The zswap_cpu_comp_prepare() CPU onlining code will get the
maximum batch-size the compressor supports. If so, it will allocate the
necessary batching resources.

However, zswap does not use more than one request yet. Follow-up patches
will actually utilize the multiple acomp_ctx requests/buffers for batch
compression/decompression of multiple pages.

The newly added ZSWAP_MAX_BATCH_SIZE limits the amount of extra memory us=
ed
for batching. There is a small extra memory overhead of allocating the
"reqs" and "buffers" arrays for compressors that do not support batching.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/zswap.c | 99 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 30 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index cff96df1df8b..fae59d6d5147 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -78,6 +78,16 @@ static bool zswap_pool_reached_full;
=20
 #define ZSWAP_PARAM_UNSET ""
=20
+/*
+ * For compression batching of large folios:
+ * Maximum number of acomp compress requests that will be processed
+ * in a batch, iff the zswap compressor supports batching.
+ * This limit exists because we preallocate enough requests and buffers
+ * in the per-cpu acomp_ctx accordingly. Hence, a higher limit means hig=
her
+ * memory usage.
+ */
+#define ZSWAP_MAX_BATCH_SIZE 8U
+
 static int zswap_setup(void);
=20
 /* Enable/disable zswap */
@@ -143,8 +153,8 @@ bool zswap_never_enabled(void)
=20
 struct crypto_acomp_ctx {
 	struct crypto_acomp *acomp;
-	struct acomp_req *req;
-	u8 *buffer;
+	struct acomp_req **reqs;
+	u8 **buffers;
 	u8 nr_reqs;
 	struct crypto_wait wait;
 	struct mutex mutex;
@@ -251,13 +261,22 @@ static void __zswap_pool_empty(struct percpu_ref *r=
ef);
 static void acomp_ctx_dealloc(struct crypto_acomp_ctx *acomp_ctx)
 {
 	if (!IS_ERR_OR_NULL(acomp_ctx) && acomp_ctx->nr_reqs) {
+		u8 i;
+
+		if (acomp_ctx->reqs) {
+			for (i =3D 0; i < acomp_ctx->nr_reqs; ++i)
+				if (!IS_ERR_OR_NULL(acomp_ctx->reqs[i]))
+					acomp_request_free(acomp_ctx->reqs[i]);
+			kfree(acomp_ctx->reqs);
+			acomp_ctx->reqs =3D NULL;
+		}
=20
-		if (!IS_ERR_OR_NULL(acomp_ctx->req))
-			acomp_request_free(acomp_ctx->req);
-		acomp_ctx->req =3D NULL;
-
-		kfree(acomp_ctx->buffer);
-		acomp_ctx->buffer =3D NULL;
+		if (acomp_ctx->buffers) {
+			for (i =3D 0; i < acomp_ctx->nr_reqs; ++i)
+				kfree(acomp_ctx->buffers[i]);
+			kfree(acomp_ctx->buffers);
+			acomp_ctx->buffers =3D NULL;
+		}
=20
 		if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
 			crypto_free_acomp(acomp_ctx->acomp);
@@ -271,6 +290,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, s=
truct hlist_node *node)
 	struct zswap_pool *pool =3D hlist_entry(node, struct zswap_pool, node);
 	struct crypto_acomp_ctx *acomp_ctx =3D per_cpu_ptr(pool->acomp_ctx, cpu=
);
 	int ret =3D -ENOMEM;
+	u8 i;
=20
 	/*
 	 * Just to be even more fail-safe against changes in assumptions and/or
@@ -292,22 +312,41 @@ static int zswap_cpu_comp_prepare(unsigned int cpu,=
 struct hlist_node *node)
 		goto fail;
 	}
=20
-	acomp_ctx->nr_reqs =3D 1;
+	acomp_ctx->nr_reqs =3D min(ZSWAP_MAX_BATCH_SIZE,
+				 crypto_acomp_batch_size(acomp_ctx->acomp));
=20
-	acomp_ctx->req =3D acomp_request_alloc(acomp_ctx->acomp);
-	if (!acomp_ctx->req) {
-		pr_err("could not alloc crypto acomp_request %s\n",
-		       pool->tfm_name);
-		ret =3D -ENOMEM;
+	acomp_ctx->reqs =3D kcalloc_node(acomp_ctx->nr_reqs, sizeof(struct acom=
p_req *),
+				       GFP_KERNEL, cpu_to_node(cpu));
+	if (!acomp_ctx->reqs)
 		goto fail;
+
+	for (i =3D 0; i < acomp_ctx->nr_reqs; ++i) {
+		acomp_ctx->reqs[i] =3D acomp_request_alloc(acomp_ctx->acomp);
+		if (!acomp_ctx->reqs[i]) {
+			pr_err("could not alloc crypto acomp_request reqs[%d] %s\n",
+				i, pool->tfm_name);
+			goto fail;
+		}
 	}
=20
-	acomp_ctx->buffer =3D kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL, cpu_to_no=
de(cpu));
-	if (!acomp_ctx->buffer) {
-		ret =3D -ENOMEM;
+	acomp_ctx->buffers =3D kcalloc_node(acomp_ctx->nr_reqs, sizeof(u8 *),
+					  GFP_KERNEL, cpu_to_node(cpu));
+	if (!acomp_ctx->buffers)
 		goto fail;
+
+	for (i =3D 0; i < acomp_ctx->nr_reqs; ++i) {
+		acomp_ctx->buffers[i] =3D kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL,
+						     cpu_to_node(cpu));
+		if (!acomp_ctx->buffers[i])
+			goto fail;
 	}
=20
+	/*
+	 * The crypto_wait is used only in fully synchronous, i.e., with scomp
+	 * or non-poll mode of acomp, hence there is only one "wait" per
+	 * acomp_ctx, with callback set to reqs[0], under the assumption that
+	 * there is at least 1 request per acomp_ctx.
+	 */
 	crypto_init_wait(&acomp_ctx->wait);
=20
 	/*
@@ -315,7 +354,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, s=
truct hlist_node *node)
 	 * crypto_wait_req(); if the backend of acomp is scomp, the callback
 	 * won't be called, crypto_wait_req() will return without blocking.
 	 */
-	acomp_request_set_callback(acomp_ctx->req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+	acomp_request_set_callback(acomp_ctx->reqs[0], CRYPTO_TFM_REQ_MAY_BACKL=
OG,
 				   crypto_req_done, &acomp_ctx->wait);
=20
 	acomp_ctx->is_sleepable =3D acomp_is_async(acomp_ctx->acomp);
@@ -407,8 +446,8 @@ static struct zswap_pool *zswap_pool_create(char *typ=
e, char *compressor)
 		struct crypto_acomp_ctx *acomp_ctx =3D per_cpu_ptr(pool->acomp_ctx, cp=
u);
=20
 		acomp_ctx->acomp =3D NULL;
-		acomp_ctx->req =3D NULL;
-		acomp_ctx->buffer =3D NULL;
+		acomp_ctx->reqs =3D NULL;
+		acomp_ctx->buffers =3D NULL;
 		acomp_ctx->__online =3D false;
 		acomp_ctx->nr_reqs =3D 0;
 		mutex_init(&acomp_ctx->mutex);
@@ -1026,7 +1065,7 @@ static bool zswap_compress(struct page *page, struc=
t zswap_entry *entry,
 	u8 *dst;
=20
 	acomp_ctx =3D acomp_ctx_get_cpu_lock(pool);
-	dst =3D acomp_ctx->buffer;
+	dst =3D acomp_ctx->buffers[0];
 	sg_init_table(&input, 1);
 	sg_set_page(&input, page, PAGE_SIZE, 0);
=20
@@ -1036,7 +1075,7 @@ static bool zswap_compress(struct page *page, struc=
t zswap_entry *entry,
 	 * giving the dst buffer with enough length to avoid buffer overflow.
 	 */
 	sg_init_one(&output, dst, PAGE_SIZE * 2);
-	acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE_SIZE, dl=
en);
+	acomp_request_set_params(acomp_ctx->reqs[0], &input, &output, PAGE_SIZE=
, dlen);
=20
 	/*
 	 * it maybe looks a little bit silly that we send an asynchronous reque=
st,
@@ -1050,8 +1089,8 @@ static bool zswap_compress(struct page *page, struc=
t zswap_entry *entry,
 	 * but in different threads running on different cpu, we have different
 	 * acomp instance, so multiple threads can do (de)compression in parall=
el.
 	 */
-	comp_ret =3D crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &ac=
omp_ctx->wait);
-	dlen =3D acomp_ctx->req->dlen;
+	comp_ret =3D crypto_wait_req(crypto_acomp_compress(acomp_ctx->reqs[0]),=
 &acomp_ctx->wait);
+	dlen =3D acomp_ctx->reqs[0]->dlen;
 	if (comp_ret)
 		goto unlock;
=20
@@ -1102,19 +1141,19 @@ static void zswap_decompress(struct zswap_entry *=
entry, struct folio *folio)
 	 */
 	if ((acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)) ||
 	    !virt_addr_valid(src)) {
-		memcpy(acomp_ctx->buffer, src, entry->length);
-		src =3D acomp_ctx->buffer;
+		memcpy(acomp_ctx->buffers[0], src, entry->length);
+		src =3D acomp_ctx->buffers[0];
 		zpool_unmap_handle(zpool, entry->handle);
 	}
=20
 	sg_init_one(&input, src, entry->length);
 	sg_init_table(&output, 1);
 	sg_set_folio(&output, folio, PAGE_SIZE, 0);
-	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length=
, PAGE_SIZE);
-	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_=
ctx->wait));
-	BUG_ON(acomp_ctx->req->dlen !=3D PAGE_SIZE);
+	acomp_request_set_params(acomp_ctx->reqs[0], &input, &output, entry->le=
ngth, PAGE_SIZE);
+	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->reqs[0]), &ac=
omp_ctx->wait));
+	BUG_ON(acomp_ctx->reqs[0]->dlen !=3D PAGE_SIZE);
=20
-	if (src !=3D acomp_ctx->buffer)
+	if (src !=3D acomp_ctx->buffers[0])
 		zpool_unmap_handle(zpool, entry->handle);
 	acomp_ctx_put_unlock(acomp_ctx);
 }
--=20
2.27.0




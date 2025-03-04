Return-Path: <linux-crypto+bounces-10378-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EF4A4D811
	for <lists+linux-crypto@lfdr.de>; Tue,  4 Mar 2025 10:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C79188925E
	for <lists+linux-crypto@lfdr.de>; Tue,  4 Mar 2025 09:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F871FCFF9;
	Tue,  4 Mar 2025 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="gIOw3RLP"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177331FDA9C
	for <linux-crypto@vger.kernel.org>; Tue,  4 Mar 2025 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080319; cv=none; b=F+Nw9n/zjkcwplG0bJHH/+qS0Xum95uOR09AjBwv8sdfHlZnRWc3I1AINCjqszkVbZln1ILIDMOyn6c/TIlrtDFFs4G7vWtXW9X/4DlTr/Hk8l5hQBTrhnX/QjWgYyeNLCKBUms4fu6ZwD1krd2G6SLqHUeJDRGUYJiRfYMEqzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080319; c=relaxed/simple;
	bh=pEoYCzAC5W9nR3RIs8GDOdWzFQpTbf5KW3yU6400ZAY=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=Jn3ivSVIkmSdZ2PHI9E5URDrIbDIHy6isV+K8CVpFwiFejsmBH/EDl96w/GYHvvRGCK5WrGnOwAYlq+KA8AWofRaQknTbHQVCmJZ1J1I0XY6PKBYXpHWKiC9f3eUEZ2582oCUtcrlEiR0v4/jat4RfsRX+I3nBItQf6GozT+bFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=gIOw3RLP; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ohyCghcONkkI1RQ7lYU6pSsY7Vt9ONamE1WQpUNPRNg=; b=gIOw3RLP35QeN9c7IznxuMqEjl
	b17BqBR9VjCgO0eTaqJq/aQTJslrifTKl5hU8kqIcajROrf0Zjmlhupgyk3aI6iENCEKtDSuOpadw
	U1zzENGex2x+qyM8DCwhjkzNbrfFHiroKDwv8oG8GXZ4gv33VU5DomR8BDzxKXXXtDaUMSMEkG+Cc
	+eguvTGwFvKLsQe8AODHJRADUKAc1+h8i95V/AqpXKCnajv2xeCxZRDuJq8CdLaWnl73IJ6Y8K8SI
	fsf/iKW1Nmy/qSV2HTeNn0jbq5GLAKIwvnbYi1GmLR/9WGUF7TQhL+Zz0URYDLEUSk7/rUtvOek8M
	GQHEwmhQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tpOWX-003a39-09;
	Tue, 04 Mar 2025 17:25:14 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 04 Mar 2025 17:25:13 +0800
Date: Tue, 04 Mar 2025 17:25:13 +0800
Message-Id: <840b89f0c8a11c691ea827a7ce620a6931e434d4.1741080140.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1741080140.git.herbert@gondor.apana.org.au>
References: <cover.1741080140.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v2 PATCH 5/7] crypto: scomp - Remove support for most non-trivial
 destination SG lists
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc: linux-mm@kvack.org, Yosry Ahmed <yosry.ahmed@linux.dev>, Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

As the only user of acomp/scomp uses a trivial single-page SG
list, remove support for everything else in preprataion for the
addition of virtual address support.

However, keep support for non-trivial source SG lists as that
user is currently jumping through hoops in order to linearise
the source data.

Limit the source SG linearisation buffer to a single page as
that user never goes over that.  The only other potential user
is also unlikely to exceed that (IPComp) and it can easily do
its own linearisation if necessary.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 crypto/acompress.c                  |  6 --
 crypto/scompress.c                  | 98 ++++++++++++-----------------
 include/crypto/acompress.h          | 12 +---
 include/crypto/internal/scompress.h |  2 -
 4 files changed, 42 insertions(+), 76 deletions(-)

diff --git a/crypto/acompress.c b/crypto/acompress.c
index d2103d4e42cc..8914d0c4cc75 100644
--- a/crypto/acompress.c
+++ b/crypto/acompress.c
@@ -73,7 +73,6 @@ static int crypto_acomp_init_tfm(struct crypto_tfm *tfm)
 
 	acomp->compress = alg->compress;
 	acomp->decompress = alg->decompress;
-	acomp->dst_free = alg->dst_free;
 	acomp->reqsize = alg->reqsize;
 
 	if (alg->exit)
@@ -146,11 +145,6 @@ void acomp_request_free(struct acomp_req *req)
 	if (tfm->__crt_alg->cra_type != &crypto_acomp_type)
 		crypto_acomp_scomp_free_ctx(req);
 
-	if (req->base.flags & CRYPTO_ACOMP_ALLOC_OUTPUT) {
-		acomp->dst_free(req->dst);
-		req->dst = NULL;
-	}
-
 	__acomp_request_free(req);
 }
 EXPORT_SYMBOL_GPL(acomp_request_free);
diff --git a/crypto/scompress.c b/crypto/scompress.c
index 1cef6bb06a81..d78f307343ac 100644
--- a/crypto/scompress.c
+++ b/crypto/scompress.c
@@ -18,15 +18,18 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/vmalloc.h>
 #include <net/netlink.h>
 
 #include "compress.h"
 
+#define SCOMP_SCRATCH_SIZE	PAGE_SIZE
+
 struct scomp_scratch {
 	spinlock_t	lock;
-	void		*src;
-	void		*dst;
+	union {
+		void *src;
+		unsigned long saddr;
+	};
 };
 
 static DEFINE_PER_CPU(struct scomp_scratch, scomp_scratch) = {
@@ -66,10 +69,8 @@ static void crypto_scomp_free_scratches(void)
 	for_each_possible_cpu(i) {
 		scratch = per_cpu_ptr(&scomp_scratch, i);
 
-		vfree(scratch->src);
-		vfree(scratch->dst);
+		free_page(scratch->saddr);
 		scratch->src = NULL;
-		scratch->dst = NULL;
 	}
 }
 
@@ -79,18 +80,14 @@ static int crypto_scomp_alloc_scratches(void)
 	int i;
 
 	for_each_possible_cpu(i) {
-		void *mem;
+		unsigned long mem;
 
 		scratch = per_cpu_ptr(&scomp_scratch, i);
 
-		mem = vmalloc_node(SCOMP_SCRATCH_SIZE, cpu_to_node(i));
+		mem = __get_free_page(GFP_KERNEL);
 		if (!mem)
 			goto error;
-		scratch->src = mem;
-		mem = vmalloc_node(SCOMP_SCRATCH_SIZE, cpu_to_node(i));
-		if (!mem)
-			goto error;
-		scratch->dst = mem;
+		scratch->saddr = mem;
 	}
 	return 0;
 error:
@@ -113,72 +110,58 @@ static int crypto_scomp_init_tfm(struct crypto_tfm *tfm)
 static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 {
 	struct crypto_acomp *tfm = crypto_acomp_reqtfm(req);
-	void **tfm_ctx = acomp_tfm_ctx(tfm);
+	struct crypto_scomp **tfm_ctx = acomp_tfm_ctx(tfm);
 	struct crypto_scomp *scomp = *tfm_ctx;
 	void **ctx = acomp_request_ctx(req);
 	struct scomp_scratch *scratch;
+	unsigned int slen = req->slen;
+	unsigned int dlen = req->dlen;
 	void *src, *dst;
-	unsigned int dlen;
 	int ret;
 
-	if (!req->src || !req->slen || req->slen > SCOMP_SCRATCH_SIZE)
+	if (!req->src || !slen)
 		return -EINVAL;
 
-	if (req->dst && !req->dlen)
+	if (req->dst && !dlen)
 		return -EINVAL;
 
-	if (!req->dlen || req->dlen > SCOMP_SCRATCH_SIZE)
-		req->dlen = SCOMP_SCRATCH_SIZE;
+	if (sg_nents(req->dst) > 1)
+		return -ENOSYS;
 
-	dlen = req->dlen;
+	if (req->dst->offset >= PAGE_SIZE)
+		return -ENOSYS;
+
+	if (req->dst->offset + dlen > PAGE_SIZE)
+		dlen = PAGE_SIZE - req->dst->offset;
+
+	if (sg_nents(req->src) == 1 && (!PageHighMem(sg_page(req->src)) ||
+					req->src->offset + slen <= PAGE_SIZE))
+		src = kmap_local_page(sg_page(req->src)) + req->src->offset;
+	else
+		src = scratch->src;
+
+	dst = kmap_local_page(sg_page(req->dst)) + req->dst->offset;
 
 	scratch = raw_cpu_ptr(&scomp_scratch);
 	spin_lock(&scratch->lock);
 
-	if (sg_nents(req->src) == 1 && !PageHighMem(sg_page(req->src))) {
-		src = page_to_virt(sg_page(req->src)) + req->src->offset;
-	} else {
-		scatterwalk_map_and_copy(scratch->src, req->src, 0,
-					 req->slen, 0);
-		src = scratch->src;
-	}
-
-	if (req->dst && sg_nents(req->dst) == 1 && !PageHighMem(sg_page(req->dst)))
-		dst = page_to_virt(sg_page(req->dst)) + req->dst->offset;
-	else
-		dst = scratch->dst;
+	if (src == scratch->src)
+		memcpy_from_sglist(src, req->src, 0, req->slen);
 
 	if (dir)
-		ret = crypto_scomp_compress(scomp, src, req->slen,
+		ret = crypto_scomp_compress(scomp, src, slen,
 					    dst, &req->dlen, *ctx);
 	else
-		ret = crypto_scomp_decompress(scomp, src, req->slen,
+		ret = crypto_scomp_decompress(scomp, src, slen,
 					      dst, &req->dlen, *ctx);
-	if (!ret) {
-		if (!req->dst) {
-			req->dst = sgl_alloc(req->dlen, GFP_ATOMIC, NULL);
-			if (!req->dst) {
-				ret = -ENOMEM;
-				goto out;
-			}
-		} else if (req->dlen > dlen) {
-			ret = -ENOSPC;
-			goto out;
-		}
-		if (dst == scratch->dst) {
-			scatterwalk_map_and_copy(scratch->dst, req->dst, 0,
-						 req->dlen, 1);
-		} else {
-			int nr_pages = DIV_ROUND_UP(req->dst->offset + req->dlen, PAGE_SIZE);
-			int i;
-			struct page *dst_page = sg_page(req->dst);
 
-			for (i = 0; i < nr_pages; i++)
-				flush_dcache_page(dst_page + i);
-		}
-	}
-out:
 	spin_unlock(&scratch->lock);
+
+	if (src != scratch->src)
+		kunmap_local(src);
+	kunmap_local(dst);
+	flush_dcache_page(sg_page(req->dst));
+
 	return ret;
 }
 
@@ -225,7 +208,6 @@ int crypto_init_scomp_ops_async(struct crypto_tfm *tfm)
 
 	crt->compress = scomp_acomp_compress;
 	crt->decompress = scomp_acomp_decompress;
-	crt->dst_free = sgl_free;
 	crt->reqsize = sizeof(void *);
 
 	return 0;
diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index 15bb13e47f8b..25e193b0b8b4 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -15,8 +15,6 @@
 #include <linux/scatterlist.h>
 #include <linux/types.h>
 
-#define CRYPTO_ACOMP_ALLOC_OUTPUT	0x00000001
-
 /* Set this bit for virtual address instead of SG list. */
 #define CRYPTO_ACOMP_REQ_VIRT		0x00000002
 
@@ -75,15 +73,12 @@ struct acomp_req {
  *
  * @compress:		Function performs a compress operation
  * @decompress:		Function performs a de-compress operation
- * @dst_free:		Frees destination buffer if allocated inside the
- *			algorithm
  * @reqsize:		Context size for (de)compression requests
  * @base:		Common crypto API algorithm data structure
  */
 struct crypto_acomp {
 	int (*compress)(struct acomp_req *req);
 	int (*decompress)(struct acomp_req *req);
-	void (*dst_free)(struct scatterlist *dst);
 	unsigned int reqsize;
 	struct crypto_tfm base;
 };
@@ -234,7 +229,7 @@ static inline void acomp_request_set_callback(struct acomp_req *req,
 					      crypto_completion_t cmpl,
 					      void *data)
 {
-	u32 keep = CRYPTO_ACOMP_ALLOC_OUTPUT | CRYPTO_ACOMP_REQ_VIRT;
+	u32 keep = CRYPTO_ACOMP_REQ_VIRT;
 
 	req->base.complete = cmpl;
 	req->base.data = data;
@@ -268,9 +263,7 @@ static inline void acomp_request_set_params(struct acomp_req *req,
 	req->slen = slen;
 	req->dlen = dlen;
 
-	req->base.flags &= ~(CRYPTO_ACOMP_ALLOC_OUTPUT | CRYPTO_ACOMP_REQ_VIRT);
-	if (!req->dst)
-		req->base.flags |= CRYPTO_ACOMP_ALLOC_OUTPUT;
+	req->base.flags &= ~CRYPTO_ACOMP_REQ_VIRT;
 }
 
 /**
@@ -294,7 +287,6 @@ static inline void acomp_request_set_virt(struct acomp_req *req,
 	req->slen = slen;
 	req->dlen = dlen;
 
-	req->base.flags &= ~CRYPTO_ACOMP_ALLOC_OUTPUT;
 	req->base.flags |= CRYPTO_ACOMP_REQ_VIRT;
 }
 
diff --git a/include/crypto/internal/scompress.h b/include/crypto/internal/scompress.h
index 6ba9974df7d3..2a6b15c0a32d 100644
--- a/include/crypto/internal/scompress.h
+++ b/include/crypto/internal/scompress.h
@@ -12,8 +12,6 @@
 #include <crypto/acompress.h>
 #include <crypto/algapi.h>
 
-#define SCOMP_SCRATCH_SIZE	131072
-
 struct acomp_req;
 
 struct crypto_scomp {
-- 
2.39.5



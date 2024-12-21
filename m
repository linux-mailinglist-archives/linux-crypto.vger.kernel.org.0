Return-Path: <linux-crypto+bounces-8679-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C5E9F9ECC
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Dec 2024 07:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB85163CB5
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Dec 2024 06:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0981F0E22;
	Sat, 21 Dec 2024 06:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DgKQXGJl"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0991EC4E2;
	Sat, 21 Dec 2024 06:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734762686; cv=none; b=PA4VNgCIYZWcIa1CjaTnjAen5DYyC9lQhzFYpf0KYG56Ap6gdYqED7hqAJ1Qo9w1MJRPpjNAAuJPKM0pE23HI39USXCZMde2vSjHYM5XS3NJ8xh+ySwbVnGZXJDdZM/ayoR3aGW8HUYp7lTOdEILg4W+z4kOabR/dWx9ILbtzP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734762686; c=relaxed/simple;
	bh=Ybj/ayHmpbuA6aY9ACaZeRej9qfykY7Qa0yAfnK5XSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OrtX3oAJUG4B8E0GosXNIVPsYh6bDKcRn3kHRIMPPd2352lSKx393i2NmCiEImnrMS3jG5wd3eV0mE5bdEBCTS7bOoMfh0SB0yPvotLPzUDbbGgsN0zPSoqLDg23zEqK8ny4kg+K75U6rrsK8AybfndYXqgVs8XyivklljJ3fOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DgKQXGJl; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734762684; x=1766298684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ybj/ayHmpbuA6aY9ACaZeRej9qfykY7Qa0yAfnK5XSM=;
  b=DgKQXGJlEYdXAdKL9ZaDAjqowyR5cwR7B7yqXh4SswXd4MNOqTTF4JC6
   /p7Od/8varMzVwgEroigd5bjxFkc/lY8P8Y7CVVElbDi1v3bxIqkWaDtO
   sZlRGs9PWEBqnWNb/be/fRHEkHbm9WQVAYbHvGyA30Rz/1lIg7pMGgP3K
   wwSezWqhqu90Xjt4fCS5+/dnkkugJwPfT2IyGIMUQEAmHGL4qUldKpmJ0
   +nbLlByRccAjQL7GYFF1ZB4vePZDFkx/bErZ5NVxkCjdJ/P5/NJMdN6mN
   WFL6L131+ZA4ECNZR1hLuFQMnnY3EArvbzDd+QEYICqirLFqQ0N+ZunFR
   Q==;
X-CSE-ConnectionGUID: cbUk5JOzRsK/U3EENKbOkQ==
X-CSE-MsgGUID: EfrqgKjoQT+/ECSd7SzqJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="35021651"
X-IronPort-AV: E=Sophos;i="6.12,253,1728975600"; 
   d="scan'208";a="35021651"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 22:31:20 -0800
X-CSE-ConnectionGUID: CeK+YvJ2QtOf6+gzycQ7nA==
X-CSE-MsgGUID: GItpzuP8SdWDHnGWUeqQQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="99184585"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.115])
  by orviesa007.jf.intel.com with ESMTP; 20 Dec 2024 22:31:20 -0800
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	21cnbao@gmail.com,
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
Subject: [PATCH v5 04/12] crypto: iaa - Implement batch_compress(), batch_decompress() API in iaa_crypto.
Date: Fri, 20 Dec 2024 22:31:11 -0800
Message-Id: <20241221063119.29140-5-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241221063119.29140-1-kanchana.p.sridhar@intel.com>
References: <20241221063119.29140-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch provides iaa_crypto driver implementations for the newly added
crypto_acomp batch_compress() and batch_decompress() interfaces using
acomp request chaining.

iaa_crypto also implements the new crypto_acomp get_batch_size() interface
that returns an iaa_driver specific constant, IAA_CRYPTO_MAX_BATCH_SIZE
(set to 8U currently).

This allows swap modules such as zswap/zram to allocate required batching
resources and then invoke fully asynchronous batch parallel
compression/decompression of pages on systems with Intel IAA, by invoking
these API, respectively:

 crypto_acomp_batch_size(...);
 crypto_acomp_batch_compress(...);
 crypto_acomp_batch_decompress(...);

This enables zswap compress batching code to be developed in
a manner similar to the current single-page synchronous calls to:

 crypto_acomp_compress(...);
 crypto_acomp_decompress(...);

thereby, facilitating encapsulated and modular hand-off between the kernel
zswap/zram code and the crypto_acomp layer.

Since iaa_crypto supports the use of acomp request chaining, this patch
also adds CRYPTO_ALG_REQ_CHAIN to the iaa_acomp_fixed_deflate algorithm's
cra_flags.

Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto.h      |   9 +
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 395 ++++++++++++++++++++-
 2 files changed, 403 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto.h b/drivers/crypto/intel/iaa/iaa_crypto.h
index 56985e395263..b3b67c44ec8a 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto.h
+++ b/drivers/crypto/intel/iaa/iaa_crypto.h
@@ -39,6 +39,15 @@
 					 IAA_DECOMP_CHECK_FOR_EOB | \
 					 IAA_DECOMP_STOP_ON_EOB)
 
+/*
+ * The maximum compress/decompress batch size for IAA's implementation of
+ * the crypto_acomp batch_compress() and batch_decompress() interfaces.
+ * The IAA compression algorithms should provide the crypto_acomp
+ * get_batch_size() interface through a function that returns this
+ * constant.
+ */
+#define IAA_CRYPTO_MAX_BATCH_SIZE 8U
+
 /* Representation of IAA workqueue */
 struct iaa_wq {
 	struct list_head	list;
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 29d03df39fab..b51b0b4b9ac3 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -1807,6 +1807,396 @@ static void compression_ctx_init(struct iaa_compression_ctx *ctx)
 	ctx->use_irq = use_irq;
 }
 
+static int iaa_comp_poll(struct acomp_req *req)
+{
+	struct idxd_desc *idxd_desc;
+	struct idxd_device *idxd;
+	struct iaa_wq *iaa_wq;
+	struct pci_dev *pdev;
+	struct device *dev;
+	struct idxd_wq *wq;
+	bool compress_op;
+	int ret;
+
+	idxd_desc = req->base.data;
+	if (!idxd_desc)
+		return -EAGAIN;
+
+	compress_op = (idxd_desc->iax_hw->opcode == IAX_OPCODE_COMPRESS);
+	wq = idxd_desc->wq;
+	iaa_wq = idxd_wq_get_private(wq);
+	idxd = iaa_wq->iaa_device->idxd;
+	pdev = idxd->pdev;
+	dev = &pdev->dev;
+
+	ret = check_completion(dev, idxd_desc->iax_completion, true, true);
+	if (ret == -EAGAIN)
+		return ret;
+	if (ret)
+		goto out;
+
+	req->dlen = idxd_desc->iax_completion->output_size;
+
+	/* Update stats */
+	if (compress_op) {
+		update_total_comp_bytes_out(req->dlen);
+		update_wq_comp_bytes(wq, req->dlen);
+	} else {
+		update_total_decomp_bytes_in(req->slen);
+		update_wq_decomp_bytes(wq, req->slen);
+	}
+
+	if (iaa_verify_compress && (idxd_desc->iax_hw->opcode == IAX_OPCODE_COMPRESS)) {
+		struct crypto_tfm *tfm = req->base.tfm;
+		dma_addr_t src_addr, dst_addr;
+		u32 compression_crc;
+
+		compression_crc = idxd_desc->iax_completion->crc;
+
+		dma_sync_sg_for_device(dev, req->dst, 1, DMA_FROM_DEVICE);
+		dma_sync_sg_for_device(dev, req->src, 1, DMA_TO_DEVICE);
+
+		src_addr = sg_dma_address(req->src);
+		dst_addr = sg_dma_address(req->dst);
+
+		ret = iaa_compress_verify(tfm, req, wq, src_addr, req->slen,
+					  dst_addr, &req->dlen, compression_crc);
+	}
+out:
+	/* caller doesn't call crypto_wait_req, so no acomp_request_complete() */
+
+	dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
+	dma_unmap_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
+
+	idxd_free_desc(idxd_desc->wq, idxd_desc);
+
+	dev_dbg(dev, "%s: returning ret=%d\n", __func__, ret);
+
+	return ret;
+}
+
+static unsigned int iaa_comp_get_batch_size(void)
+{
+	return IAA_CRYPTO_MAX_BATCH_SIZE;
+}
+
+static void iaa_set_req_poll(
+	struct acomp_req *reqs[],
+	int nr_reqs,
+	bool set_flag)
+{
+	int i;
+
+	for (i = 0; i < nr_reqs; ++i) {
+		set_flag ? (reqs[i]->flags |= CRYPTO_ACOMP_REQ_POLL) :
+			   (reqs[i]->flags &= ~CRYPTO_ACOMP_REQ_POLL);
+	}
+}
+
+/**
+ * This API provides IAA compress batching functionality for use by swap
+ * modules.
+ *
+ * @reqs: @nr_pages asynchronous compress requests.
+ * @wait: crypto_wait for acomp batch compress implemented using request
+ *        chaining. Required if async_mode is "false". If async_mode is "true",
+ *        and @wait is NULL, the completions will be processed using
+ *        asynchronous polling of the requests' completion statuses.
+ * @pages: Pages to be compressed by IAA.
+ * @dsts: Pre-allocated destination buffers to store results of IAA
+ *        compression. Each element of @dsts must be of size "PAGE_SIZE * 2".
+ * @dlens: Will contain the compressed lengths.
+ * @errors: zero on successful compression of the corresponding
+ *          req, or error code in case of error.
+ * @nr_pages: The number of pages, up to IAA_CRYPTO_MAX_BATCH_SIZE,
+ *            to be compressed.
+ *
+ * Returns true if all compress requests complete successfully,
+ * false otherwise.
+ */
+static bool iaa_comp_acompress_batch(
+	struct acomp_req *reqs[],
+	struct crypto_wait *wait,
+	struct page *pages[],
+	u8 *dsts[],
+	unsigned int dlens[],
+	int errors[],
+	int nr_pages)
+{
+	struct scatterlist inputs[IAA_CRYPTO_MAX_BATCH_SIZE];
+	struct scatterlist outputs[IAA_CRYPTO_MAX_BATCH_SIZE];
+	bool compressions_done = false;
+	bool async = (async_mode && !use_irq);
+	bool async_poll = (async && !wait);
+	int i, err = 0;
+
+	BUG_ON(nr_pages > IAA_CRYPTO_MAX_BATCH_SIZE);
+	BUG_ON(!async && !wait);
+
+	if (async)
+		iaa_set_req_poll(reqs, nr_pages, true);
+	else
+		iaa_set_req_poll(reqs, nr_pages, false);
+
+	/*
+	 * Prepare and submit acomp_reqs to IAA. IAA will process these
+	 * compress jobs in parallel if async_mode is true.
+	 */
+	for (i = 0; i < nr_pages; ++i) {
+		sg_init_table(&inputs[i], 1);
+		sg_set_page(&inputs[i], pages[i], PAGE_SIZE, 0);
+
+		/*
+		 * Each dst buffer should be of size (PAGE_SIZE * 2).
+		 * Reflect same in sg_list.
+		 */
+		sg_init_one(&outputs[i], dsts[i], PAGE_SIZE * 2);
+		acomp_request_set_params(reqs[i], &inputs[i],
+					 &outputs[i], PAGE_SIZE, dlens[i]);
+
+		/*
+		 * As long as the API is called with a valid "wait", chain the
+		 * requests for synchronous/asynchronous compress ops.
+		 * If async_mode is in effect, but the API is called with a
+		 * NULL "wait", submit the requests first, and poll for
+		 * their completion status later, after all descriptors have
+		 * been submitted.
+		 */
+		if (!async_poll) {
+			/* acomp request chaining. */
+			if (i)
+				acomp_request_chain(reqs[i], reqs[0]);
+			else
+				acomp_reqchain_init(reqs[0], 0, crypto_req_done,
+						    wait);
+		} else {
+			errors[i] = iaa_comp_acompress(reqs[i]);
+
+			if (errors[i] != -EINPROGRESS) {
+				errors[i] = -EINVAL;
+				err = -EINVAL;
+			} else {
+				errors[i] = -EAGAIN;
+			}
+		}
+	}
+
+	if (!async_poll) {
+		if (async)
+			/* Process the request chain in parallel. */
+			err = crypto_wait_req(acomp_do_async_req_chain(reqs[0],
+					      iaa_comp_acompress, iaa_comp_poll),
+					      wait);
+		else
+			/* Process the request chain in series. */
+			err = crypto_wait_req(acomp_do_req_chain(reqs[0],
+					      iaa_comp_acompress), wait);
+
+		for (i = 0; i < nr_pages; ++i) {
+			errors[i] = acomp_request_err(reqs[i]);
+			if (errors[i]) {
+				err = -EINVAL;
+				pr_debug("Request chaining req %d compress error %d\n", i, errors[i]);
+			} else {
+				dlens[i] = reqs[i]->dlen;
+			}
+		}
+
+		goto reset_reqs;
+	}
+
+	/*
+	 * Asynchronously poll for and process IAA compress job completions.
+	 */
+	while (!compressions_done) {
+		compressions_done = true;
+
+		for (i = 0; i < nr_pages; ++i) {
+			/*
+			 * Skip, if the compression has already completed
+			 * successfully or with an error.
+			 */
+			if (errors[i] != -EAGAIN)
+				continue;
+
+			errors[i] = iaa_comp_poll(reqs[i]);
+
+			if (errors[i]) {
+				if (errors[i] == -EAGAIN)
+					compressions_done = false;
+				else
+					err = -EINVAL;
+			} else {
+				dlens[i] = reqs[i]->dlen;
+			}
+		}
+	}
+
+reset_reqs:
+	/*
+	 * For the same 'reqs[]' to be usable by
+	 * iaa_comp_acompress()/iaa_comp_deacompress(),
+	 * clear the CRYPTO_ACOMP_REQ_POLL bit on all acomp_reqs, and the
+	 * CRYPTO_TFM_REQ_CHAIN bit on the reqs[0].
+	 */
+	iaa_set_req_poll(reqs, nr_pages, false);
+	if (!async_poll)
+		acomp_reqchain_clear(reqs[0], wait);
+
+	return !err;
+}
+
+/**
+ * This API provides IAA decompress batching functionality for use by swap
+ * modules.
+ *
+ * @reqs: @nr_pages asynchronous decompress requests.
+ * @wait: crypto_wait for acomp batch decompress implemented using request
+ *        chaining. Required if async_mode is "false". If async_mode is "true",
+ *        and @wait is NULL, the completions will be processed using
+ *        asynchronous polling of the requests' completion statuses.
+ * @srcs: The src buffers to be decompressed by IAA.
+ * @pages: The pages to store the decompressed buffers.
+ * @slens: Compressed lengths of @srcs.
+ * @errors: zero on successful compression of the corresponding
+ *          req, or error code in case of error.
+ * @nr_pages: The number of pages, up to IAA_CRYPTO_MAX_BATCH_SIZE,
+ *            to be decompressed.
+ *
+ * Returns true if all decompress requests complete successfully,
+ * false otherwise.
+ */
+static bool iaa_comp_adecompress_batch(
+	struct acomp_req *reqs[],
+	struct crypto_wait *wait,
+	u8 *srcs[],
+	struct page *pages[],
+	unsigned int slens[],
+	int errors[],
+	int nr_pages)
+{
+	struct scatterlist inputs[IAA_CRYPTO_MAX_BATCH_SIZE];
+	struct scatterlist outputs[IAA_CRYPTO_MAX_BATCH_SIZE];
+	unsigned int dlens[IAA_CRYPTO_MAX_BATCH_SIZE];
+	bool decompressions_done = false;
+	bool async = (async_mode && !use_irq);
+	bool async_poll = (async && !wait);
+	int i, err = 0;
+
+	BUG_ON(nr_pages > IAA_CRYPTO_MAX_BATCH_SIZE);
+	BUG_ON(!async && !wait);
+
+	if (async)
+		iaa_set_req_poll(reqs, nr_pages, true);
+	else
+		iaa_set_req_poll(reqs, nr_pages, false);
+
+	/*
+	 * Prepare and submit acomp_reqs to IAA. IAA will process these
+	 * decompress jobs in parallel if async_mode is true.
+	 */
+	for (i = 0; i < nr_pages; ++i) {
+		dlens[i] = PAGE_SIZE;
+		sg_init_one(&inputs[i], srcs[i], slens[i]);
+		sg_init_table(&outputs[i], 1);
+		sg_set_page(&outputs[i], pages[i], PAGE_SIZE, 0);
+		acomp_request_set_params(reqs[i], &inputs[i],
+					&outputs[i], slens[i], dlens[i]);
+
+		/*
+		 * As long as the API is called with a valid "wait", chain the
+		 * requests for synchronous/asynchronous decompress ops.
+		 * If async_mode is in effect, but the API is called with a
+		 * NULL "wait", submit the requests first, and poll for
+		 * their completion status later, after all descriptors have
+		 * been submitted.
+		 */
+		if (!async_poll) {
+			/* acomp request chaining. */
+			if (i)
+				acomp_request_chain(reqs[i], reqs[0]);
+			else
+				acomp_reqchain_init(reqs[0], 0, crypto_req_done,
+						    wait);
+		} else {
+			errors[i] = iaa_comp_adecompress(reqs[i]);
+
+			if (errors[i] != -EINPROGRESS) {
+				errors[i] = -EINVAL;
+				err = -EINVAL;
+			} else {
+				errors[i] = -EAGAIN;
+			}
+		}
+	}
+
+	if (!async_poll) {
+		if (async)
+			/* Process the request chain in parallel. */
+			err = crypto_wait_req(acomp_do_async_req_chain(reqs[0],
+					      iaa_comp_adecompress, iaa_comp_poll),
+					      wait);
+		else
+			/* Process the request chain in series. */
+			err = crypto_wait_req(acomp_do_req_chain(reqs[0],
+					      iaa_comp_adecompress), wait);
+
+		for (i = 0; i < nr_pages; ++i) {
+			errors[i] = acomp_request_err(reqs[i]);
+			if (errors[i]) {
+				err = -EINVAL;
+				pr_debug("Request chaining req %d decompress error %d\n", i, errors[i]);
+			} else {
+				dlens[i] = reqs[i]->dlen;
+				BUG_ON(dlens[i] != PAGE_SIZE);
+			}
+		}
+
+		goto reset_reqs;
+	}
+
+	/*
+	 * Asynchronously poll for and process IAA decompress job completions.
+	 */
+	while (!decompressions_done) {
+		decompressions_done = true;
+
+		for (i = 0; i < nr_pages; ++i) {
+			/*
+			 * Skip, if the decompression has already completed
+			 * successfully or with an error.
+			 */
+			if (errors[i] != -EAGAIN)
+				continue;
+
+			errors[i] = iaa_comp_poll(reqs[i]);
+
+			if (errors[i]) {
+				if (errors[i] == -EAGAIN)
+					decompressions_done = false;
+				else
+					err = -EINVAL;
+			} else {
+				dlens[i] = reqs[i]->dlen;
+				BUG_ON(dlens[i] != PAGE_SIZE);
+			}
+		}
+	}
+
+reset_reqs:
+	/*
+	 * For the same 'reqs[]' to be usable by
+	 * iaa_comp_acompress()/iaa_comp_deacompress(),
+	 * clear the CRYPTO_ACOMP_REQ_POLL bit on all acomp_reqs, and the
+	 * CRYPTO_TFM_REQ_CHAIN bit on the reqs[0].
+	 */
+	iaa_set_req_poll(reqs, nr_pages, false);
+	if (!async_poll)
+		acomp_reqchain_clear(reqs[0], wait);
+
+	return !err;
+}
+
 static int iaa_comp_init_fixed(struct crypto_acomp *acomp_tfm)
 {
 	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
@@ -1832,10 +2222,13 @@ static struct acomp_alg iaa_acomp_fixed_deflate = {
 	.compress		= iaa_comp_acompress,
 	.decompress		= iaa_comp_adecompress,
 	.dst_free               = dst_free,
+	.get_batch_size		= iaa_comp_get_batch_size,
+	.batch_compress		= iaa_comp_acompress_batch,
+	.batch_decompress	= iaa_comp_adecompress_batch,
 	.base			= {
 		.cra_name		= "deflate",
 		.cra_driver_name	= "deflate-iaa",
-		.cra_flags		= CRYPTO_ALG_ASYNC,
+		.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_REQ_CHAIN,
 		.cra_ctxsize		= sizeof(struct iaa_compression_ctx),
 		.cra_module		= THIS_MODULE,
 		.cra_priority		= IAA_ALG_PRIORITY,
-- 
2.27.0



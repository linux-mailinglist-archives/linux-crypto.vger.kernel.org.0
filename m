Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73052DBFBB
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Dec 2020 12:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgLPLtC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 16 Dec 2020 06:49:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:25423 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgLPLtB (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 16 Dec 2020 06:49:01 -0500
IronPort-SDR: 8lcC81SrtafNAtQ8MW48EdMb+ww0CyccvdaJW+R02oy3OH1zLGYH1zNQLnioVbZrEcG0KFGTqp
 JFkClgXAQMUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="259775321"
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="259775321"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 03:47:14 -0800
IronPort-SDR: trGaUA/MHF63Xa1Q9+9nwu9KLgcL3J3D/JMFkrCmwVL2IvaWLlKRjfcR65rT9AHT0Ftr+aNw9R
 IQUrHJqJV2Yw==
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="368985159"
Received: from johnlyon-mobl.ger.corp.intel.com (HELO dalessan-mobl1.ir.intel.com) ([10.251.90.249])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 03:47:08 -0800
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Declan Murphy <declan.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Subject: [PATCH v4 2/5] crypto: keembay - Add Keem Bay OCS HCU driver
Date:   Wed, 16 Dec 2020 11:46:36 +0000
Message-Id: <20201216114639.3451399-3-daniele.alessandrelli@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201216114639.3451399-1-daniele.alessandrelli@linux.intel.com>
References: <20201216114639.3451399-1-daniele.alessandrelli@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Declan Murphy <declan.murphy@intel.com>

Add support for the Hashing Control Unit (HCU) included in the Offload
Crypto Subsystem (OCS) of the Intel Keem Bay SoC, thus enabling
hardware-accelerated hashing on the Keem Bay SoC for the following
algorithms:
- sha256
- sha384
- sha512
- sm3

The driver is composed of two files:

- 'ocs-hcu.c' which interacts with the hardware and abstracts it by
  providing an API following the usual paradigm used in hashing drivers
  / libraries (e.g., hash_init(), hash_update(), hash_final(), etc.).
  NOTE: this API can block and sleep, since completions are used to wait
  for the HW to complete the hashing.

- 'keembay-ocs-hcu-core.c' which exports the functionality provided by
  'ocs-hcu.c' as a ahash crypto driver. The crypto engine is used to
  provide asynchronous behavior. 'keembay-ocs-hcu-core.c' also takes
  care of the DMA mapping of the input sg list.

The driver passes crypto manager self-tests, including the extra tests
(CRYPTO_MANAGER_EXTRA_TESTS=y).

Signed-off-by: Declan Murphy <declan.murphy@intel.com>
Co-developed-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Acked-by: Mark Gross <mgross@linux.intel.com>
---
 drivers/crypto/keembay/Kconfig                |  17 +
 drivers/crypto/keembay/Makefile               |   3 +
 drivers/crypto/keembay/keembay-ocs-hcu-core.c | 830 ++++++++++++++++++
 drivers/crypto/keembay/ocs-hcu.c              | 684 +++++++++++++++
 drivers/crypto/keembay/ocs-hcu.h              |  98 +++
 5 files changed, 1632 insertions(+)
 create mode 100644 drivers/crypto/keembay/keembay-ocs-hcu-core.c
 create mode 100644 drivers/crypto/keembay/ocs-hcu.c
 create mode 100644 drivers/crypto/keembay/ocs-hcu.h

diff --git a/drivers/crypto/keembay/Kconfig b/drivers/crypto/keembay/Kconfig
index 3c16797b25b9..d207a4511b7e 100644
--- a/drivers/crypto/keembay/Kconfig
+++ b/drivers/crypto/keembay/Kconfig
@@ -37,3 +37,20 @@ config CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_CTS
 	  Provides OCS version of cts(cbc(aes)) and cts(cbc(sm4)).
 
 	  Intel does not recommend use of CTS mode with AES/SM4.
+
+config CRYPTO_DEV_KEEMBAY_OCS_HCU
+	tristate "Support for Intel Keem Bay OCS HCU HW acceleration"
+	select CRYPTO_HASH
+	select CRYPTO_ENGINE
+	depends on OF || COMPILE_TEST
+	help
+	  Support for Intel Keem Bay Offload and Crypto Subsystem (OCS) Hash
+	  Control Unit (HCU) hardware acceleration for use with Crypto API.
+
+	  Provides OCS HCU hardware acceleration of sha256, sha384, sha512, and
+	  sm3.
+
+	  Say Y or M if you're building for the Intel Keem Bay SoC. If compiled
+	  as a module, the module will be called keembay-ocs-hcu.
+
+	  If unsure, say N.
diff --git a/drivers/crypto/keembay/Makefile b/drivers/crypto/keembay/Makefile
index f21e2c4ab3b3..aea03d4432c4 100644
--- a/drivers/crypto/keembay/Makefile
+++ b/drivers/crypto/keembay/Makefile
@@ -3,3 +3,6 @@
 #
 obj-$(CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4) += keembay-ocs-aes.o
 keembay-ocs-aes-objs := keembay-ocs-aes-core.o ocs-aes.o
+
+obj-$(CONFIG_CRYPTO_DEV_KEEMBAY_OCS_HCU) += keembay-ocs-hcu.o
+keembay-ocs-hcu-objs := keembay-ocs-hcu-core.o ocs-hcu.o
diff --git a/drivers/crypto/keembay/keembay-ocs-hcu-core.c b/drivers/crypto/keembay/keembay-ocs-hcu-core.c
new file mode 100644
index 000000000000..388cf9add757
--- /dev/null
+++ b/drivers/crypto/keembay/keembay-ocs-hcu-core.c
@@ -0,0 +1,830 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel Keem Bay OCS HCU Crypto Driver.
+ *
+ * Copyright (C) 2018-2020 Intel Corporation
+ */
+
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+
+#include <crypto/engine.h>
+#include <crypto/scatterwalk.h>
+#include <crypto/sha2.h>
+#include <crypto/sm3.h>
+#include <crypto/internal/hash.h>
+
+#include "ocs-hcu.h"
+
+#define DRV_NAME	"keembay-ocs-hcu"
+
+/* Flag marking a final request. */
+#define REQ_FINAL			BIT(0)
+
+/**
+ * struct ocs_hcu_ctx: OCS HCU Transform context.
+ * @engine_ctx:	 Crypto Engine context.
+ * @hcu_dev:	 The OCS HCU device used by the transformation.
+ * @is_sm3_tfm:  Whether or not this is an SM3 transformation.
+ */
+struct ocs_hcu_ctx {
+	struct crypto_engine_ctx engine_ctx;
+	struct ocs_hcu_dev *hcu_dev;
+	bool is_sm3_tfm;
+};
+
+/**
+ * struct ocs_hcu_rctx - Context for the request.
+ * @hcu_dev:	    OCS HCU device to be used to service the request.
+ * @flags:	    Flags tracking request status.
+ * @algo:	    Algorithm to use for the request.
+ * @blk_sz:	    Block size of the transformation / request.
+ * @dig_sz:	    Digest size of the transformation / request.
+ * @dma_list:	    OCS DMA linked list.
+ * @hash_ctx:	    OCS HCU hashing context.
+ * @buffer:	    Buffer to store partial block of data.
+ * @buf_cnt:	    Number of bytes currently stored in the buffer.
+ * @buf_dma_addr:   The DMA address of @buffer (when mapped).
+ * @buf_dma_count:  The number of bytes in @buffer currently DMA-mapped.
+ * @sg:		    Head of the scatterlist entries containing data.
+ * @sg_data_total:  Total data in the SG list at any time.
+ * @sg_data_offset: Offset into the data of the current individual SG node.
+ * @sg_dma_nents:   Number of sg entries mapped in dma_list.
+ */
+struct ocs_hcu_rctx {
+	struct ocs_hcu_dev	*hcu_dev;
+	u32			flags;
+	enum ocs_hcu_algo	algo;
+	size_t			blk_sz;
+	size_t			dig_sz;
+	struct ocs_hcu_dma_list	*dma_list;
+	struct ocs_hcu_hash_ctx	hash_ctx;
+	u8			buffer[SHA512_BLOCK_SIZE];
+	size_t			buf_cnt;
+	dma_addr_t		buf_dma_addr;
+	size_t			buf_dma_count;
+	struct scatterlist	*sg;
+	unsigned int		sg_data_total;
+	unsigned int		sg_data_offset;
+	unsigned int		sg_dma_nents;
+};
+
+/**
+ * struct ocs_hcu_drv - Driver data
+ * @dev_list:	The list of HCU devices.
+ * @lock:	The lock protecting dev_list.
+ */
+struct ocs_hcu_drv {
+	struct list_head dev_list;
+	spinlock_t lock; /* Protects dev_list. */
+};
+
+static struct ocs_hcu_drv ocs_hcu = {
+	.dev_list = LIST_HEAD_INIT(ocs_hcu.dev_list),
+	.lock = __SPIN_LOCK_UNLOCKED(ocs_hcu.lock),
+};
+
+/*
+ * Return the total amount of data in the request; that is: the data in the
+ * request buffer + the data in the sg list.
+ */
+static inline unsigned int kmb_get_total_data(struct ocs_hcu_rctx *rctx)
+{
+	return rctx->sg_data_total + rctx->buf_cnt;
+}
+
+/* Move remaining content of scatter-gather list to context buffer. */
+static int flush_sg_to_ocs_buffer(struct ocs_hcu_rctx *rctx)
+{
+	size_t count;
+
+	if (rctx->sg_data_total > (sizeof(rctx->buffer) - rctx->buf_cnt)) {
+		WARN(1, "%s: sg data does not fit in buffer\n", __func__);
+		return -EINVAL;
+	}
+
+	while (rctx->sg_data_total) {
+		if (!rctx->sg) {
+			WARN(1, "%s: unexpected NULL sg\n", __func__);
+			return -EINVAL;
+		}
+		/*
+		 * If current sg has been fully processed, skip to the next
+		 * one.
+		 */
+		if (rctx->sg_data_offset == rctx->sg->length) {
+			rctx->sg = sg_next(rctx->sg);
+			rctx->sg_data_offset = 0;
+			continue;
+		}
+		/*
+		 * Determine the maximum data available to copy from the node.
+		 * Minimum of the length left in the sg node, or the total data
+		 * in the request.
+		 */
+		count = min(rctx->sg->length - rctx->sg_data_offset,
+			    rctx->sg_data_total);
+		/* Copy from scatter-list entry to context buffer. */
+		scatterwalk_map_and_copy(&rctx->buffer[rctx->buf_cnt],
+					 rctx->sg, rctx->sg_data_offset,
+					 count, 0);
+
+		rctx->sg_data_offset += count;
+		rctx->sg_data_total -= count;
+		rctx->buf_cnt += count;
+	}
+
+	return 0;
+}
+
+static struct ocs_hcu_dev *kmb_ocs_hcu_find_dev(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct ocs_hcu_ctx *tctx = crypto_ahash_ctx(tfm);
+
+	/* If the HCU device for the request was previously set, return it. */
+	if (tctx->hcu_dev)
+		return tctx->hcu_dev;
+
+	/*
+	 * Otherwise, get the first HCU device available (there should be one
+	 * and only one device).
+	 */
+	spin_lock_bh(&ocs_hcu.lock);
+	tctx->hcu_dev = list_first_entry_or_null(&ocs_hcu.dev_list,
+						 struct ocs_hcu_dev,
+						 list);
+	spin_unlock_bh(&ocs_hcu.lock);
+
+	return tctx->hcu_dev;
+}
+
+/* Free OCS DMA linked list and DMA-able context buffer. */
+static void kmb_ocs_hcu_dma_cleanup(struct ahash_request *req,
+				    struct ocs_hcu_rctx *rctx)
+{
+	struct ocs_hcu_dev *hcu_dev = rctx->hcu_dev;
+	struct device *dev = hcu_dev->dev;
+
+	/* Unmap rctx->buffer (if mapped). */
+	if (rctx->buf_dma_count) {
+		dma_unmap_single(dev, rctx->buf_dma_addr, rctx->buf_dma_count,
+				 DMA_TO_DEVICE);
+		rctx->buf_dma_count = 0;
+	}
+
+	/* Unmap req->src (if mapped). */
+	if (rctx->sg_dma_nents) {
+		dma_unmap_sg(dev, req->src, rctx->sg_dma_nents, DMA_TO_DEVICE);
+		rctx->sg_dma_nents = 0;
+	}
+
+	/* Free dma_list (if allocated). */
+	if (rctx->dma_list) {
+		ocs_hcu_dma_list_free(hcu_dev, rctx->dma_list);
+		rctx->dma_list = NULL;
+	}
+}
+
+/*
+ * Prepare for DMA operation:
+ * - DMA-map request context buffer (if needed)
+ * - DMA-map SG list (only the entries to be processed, see note below)
+ * - Allocate OCS HCU DMA linked list (number of elements =  SG entries to
+ *   process + context buffer (if not empty)).
+ * - Add DMA-mapped request context buffer to OCS HCU DMA list.
+ * - Add SG entries to DMA list.
+ *
+ * Note: if this is a final request, we process all the data in the SG list,
+ * otherwise we can only process up to the maximum amount of block-aligned data
+ * (the remainder will be put into the context buffer and processed in the next
+ * request).
+ */
+static int kmb_ocs_dma_prepare(struct ahash_request *req)
+{
+	struct ocs_hcu_rctx *rctx = ahash_request_ctx(req);
+	struct device *dev = rctx->hcu_dev->dev;
+	unsigned int remainder = 0;
+	unsigned int total;
+	size_t nents;
+	size_t count;
+	int rc;
+	int i;
+
+	/* This function should be called only when there is data to process. */
+	total = kmb_get_total_data(rctx);
+	if (!total)
+		return -EINVAL;
+
+	/*
+	 * If this is not a final DMA (terminated DMA), the data passed to the
+	 * HCU must be aligned to the block size; compute the remainder data to
+	 * be processed in the next request.
+	 */
+	if (!(rctx->flags & REQ_FINAL))
+		remainder = total % rctx->blk_sz;
+
+	/* Determine the number of scatter gather list entries to process. */
+	nents = sg_nents_for_len(req->src, rctx->sg_data_total - remainder);
+
+	/* If there are entries to process, map them. */
+	if (nents) {
+		rctx->sg_dma_nents = dma_map_sg(dev, req->src, nents,
+						DMA_TO_DEVICE);
+		if (!rctx->sg_dma_nents) {
+			dev_err(dev, "Failed to MAP SG\n");
+			rc = -ENOMEM;
+			goto cleanup;
+		}
+		/*
+		 * The value returned by dma_map_sg() can be < nents; so update
+		 * nents accordingly.
+		 */
+		nents = rctx->sg_dma_nents;
+	}
+
+	/*
+	 * If context buffer is not empty, map it and add extra DMA entry for
+	 * it.
+	 */
+	if (rctx->buf_cnt) {
+		rctx->buf_dma_addr = dma_map_single(dev, rctx->buffer,
+						    rctx->buf_cnt,
+						    DMA_TO_DEVICE);
+		if (dma_mapping_error(dev, rctx->buf_dma_addr)) {
+			dev_err(dev, "Failed to map request context buffer\n");
+			rc = -ENOMEM;
+			goto cleanup;
+		}
+		rctx->buf_dma_count = rctx->buf_cnt;
+		/* Increase number of dma entries. */
+		nents++;
+	}
+
+	/* Allocate OCS HCU DMA list. */
+	rctx->dma_list = ocs_hcu_dma_list_alloc(rctx->hcu_dev, nents);
+	if (!rctx->dma_list) {
+		rc = -ENOMEM;
+		goto cleanup;
+	}
+
+	/* Add request context buffer (if previously DMA-mapped) */
+	if (rctx->buf_dma_count) {
+		rc = ocs_hcu_dma_list_add_tail(rctx->hcu_dev, rctx->dma_list,
+					       rctx->buf_dma_addr,
+					       rctx->buf_dma_count);
+		if (rc)
+			goto cleanup;
+	}
+
+	/* Add the SG nodes to be processed to the DMA linked list. */
+	for_each_sg(req->src, rctx->sg, rctx->sg_dma_nents, i) {
+		/*
+		 * The number of bytes to add to the list entry is the minimum
+		 * between:
+		 * - The DMA length of the SG entry.
+		 * - The data left to be processed.
+		 */
+		count = min(rctx->sg_data_total - remainder,
+			    sg_dma_len(rctx->sg) - rctx->sg_data_offset);
+		/*
+		 * Do not create a zero length DMA descriptor. Check in case of
+		 * zero length SG node.
+		 */
+		if (count == 0)
+			continue;
+		/* Add sg to HCU DMA list. */
+		rc = ocs_hcu_dma_list_add_tail(rctx->hcu_dev,
+					       rctx->dma_list,
+					       rctx->sg->dma_address,
+					       count);
+		if (rc)
+			goto cleanup;
+
+		/* Update amount of data remaining in SG list. */
+		rctx->sg_data_total -= count;
+
+		/*
+		 * If  remaining data is equal to remainder (note: 'less than'
+		 * case should never happen in practice), we are done: update
+		 * offset and exit the loop.
+		 */
+		if (rctx->sg_data_total <= remainder) {
+			WARN_ON(rctx->sg_data_total < remainder);
+			rctx->sg_data_offset += count;
+			break;
+		}
+
+		/*
+		 * If we get here is because we need to process the next sg in
+		 * the list; set offset within the sg to 0.
+		 */
+		rctx->sg_data_offset = 0;
+	}
+
+	return 0;
+cleanup:
+	dev_err(dev, "Failed to prepare DMA.\n");
+	kmb_ocs_hcu_dma_cleanup(req, rctx);
+
+	return rc;
+}
+
+static void kmb_ocs_hcu_secure_cleanup(struct ahash_request *req)
+{
+	struct ocs_hcu_rctx *rctx = ahash_request_ctx(req);
+
+	/* Clear buffer of any data. */
+	memzero_explicit(rctx->buffer, sizeof(rctx->buffer));
+}
+
+static int kmb_ocs_hcu_handle_queue(struct ahash_request *req)
+{
+	struct ocs_hcu_dev *hcu_dev = kmb_ocs_hcu_find_dev(req);
+
+	if (!hcu_dev)
+		return -ENOENT;
+
+	return crypto_transfer_hash_request_to_engine(hcu_dev->engine, req);
+}
+
+static int kmb_ocs_hcu_do_one_request(struct crypto_engine *engine, void *areq)
+{
+	struct ahash_request *req = container_of(areq, struct ahash_request,
+						 base);
+	struct ocs_hcu_dev *hcu_dev = kmb_ocs_hcu_find_dev(req);
+	struct ocs_hcu_rctx *rctx = ahash_request_ctx(req);
+	int rc;
+
+	if (!hcu_dev) {
+		rc = -ENOENT;
+		goto error;
+	}
+
+	/* Handle update request case. */
+	if (!(rctx->flags & REQ_FINAL)) {
+		/* Update should always have input data. */
+		if (!kmb_get_total_data(rctx))
+			return -EINVAL;
+
+		/* Map input data into the HCU DMA linked list. */
+		rc = kmb_ocs_dma_prepare(req);
+		if (rc)
+			goto error;
+
+		/* Do hashing step. */
+		rc = ocs_hcu_hash_update(hcu_dev, &rctx->hash_ctx,
+					 rctx->dma_list);
+
+		/* Unmap data and free DMA list regardless of return code. */
+		kmb_ocs_hcu_dma_cleanup(req, rctx);
+
+		/* Process previous return code. */
+		if (rc)
+			goto error;
+
+		/*
+		 * Reset request buffer count (data in the buffer was just
+		 * processed).
+		 */
+		rctx->buf_cnt = 0;
+		/*
+		 * Move remaining sg data into the request buffer, so that it
+		 * will be processed during the next request.
+		 *
+		 * NOTE: we have remaining data if kmb_get_total_data() was not
+		 * a multiple of block size.
+		 */
+		rc = flush_sg_to_ocs_buffer(rctx);
+		if (rc)
+			goto error;
+
+		goto done;
+	}
+
+	/* If we get here, this is a final request. */
+
+	/* If there is data to process, use finup. */
+	if (kmb_get_total_data(rctx)) {
+		/* Map input data into the HCU DMA linked list. */
+		rc = kmb_ocs_dma_prepare(req);
+		if (rc)
+			goto error;
+
+		/* Do hashing step. */
+		rc = ocs_hcu_hash_finup(hcu_dev, &rctx->hash_ctx,
+					rctx->dma_list,
+					req->result, rctx->dig_sz);
+		/* Free DMA list regardless of return code. */
+		kmb_ocs_hcu_dma_cleanup(req, rctx);
+
+		/* Process previous return code. */
+		if (rc)
+			goto error;
+
+	} else {  /* Otherwise (if we have no data), use final. */
+		rc = ocs_hcu_hash_final(hcu_dev, &rctx->hash_ctx, req->result,
+					rctx->dig_sz);
+		if (rc)
+			goto error;
+	}
+
+	/* Perform secure clean-up. */
+	kmb_ocs_hcu_secure_cleanup(req);
+done:
+	crypto_finalize_hash_request(hcu_dev->engine, req, 0);
+
+	return 0;
+
+error:
+	kmb_ocs_hcu_secure_cleanup(req);
+	return rc;
+}
+
+static int kmb_ocs_hcu_init(struct ahash_request *req)
+{
+	struct ocs_hcu_dev *hcu_dev = kmb_ocs_hcu_find_dev(req);
+	struct ocs_hcu_rctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct ocs_hcu_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	if (!hcu_dev)
+		return -ENOENT;
+
+	/* Initialize entire request context to zero. */
+	memset(rctx, 0, sizeof(*rctx));
+
+	rctx->hcu_dev = hcu_dev;
+	rctx->dig_sz = crypto_ahash_digestsize(tfm);
+
+	switch (rctx->dig_sz) {
+	case SHA256_DIGEST_SIZE:
+		rctx->blk_sz = SHA256_BLOCK_SIZE;
+		/*
+		 * SHA256 and SM3 have the same digest size: use info from tfm
+		 * context to find out which one we should use.
+		 */
+		rctx->algo = ctx->is_sm3_tfm ? OCS_HCU_ALGO_SM3 :
+					       OCS_HCU_ALGO_SHA256;
+		break;
+	case SHA384_DIGEST_SIZE:
+		rctx->blk_sz = SHA384_BLOCK_SIZE;
+		rctx->algo = OCS_HCU_ALGO_SHA384;
+		break;
+	case SHA512_DIGEST_SIZE:
+		rctx->blk_sz = SHA512_BLOCK_SIZE;
+		rctx->algo = OCS_HCU_ALGO_SHA512;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Initialize intermediate data. */
+	ocs_hcu_hash_init(&rctx->hash_ctx, rctx->algo);
+
+	return 0;
+}
+
+static int kmb_ocs_hcu_update(struct ahash_request *req)
+{
+	struct ocs_hcu_rctx *rctx = ahash_request_ctx(req);
+
+	if (!req->nbytes)
+		return 0;
+
+	rctx->sg_data_total = req->nbytes;
+	rctx->sg_data_offset = 0;
+	rctx->sg = req->src;
+
+	/*
+	 * If remaining sg_data fits into ctx buffer, just copy it there; we'll
+	 * process it at the next update() or final().
+	 */
+	if (rctx->sg_data_total <= (sizeof(rctx->buffer) - rctx->buf_cnt))
+		return flush_sg_to_ocs_buffer(rctx);
+
+	return kmb_ocs_hcu_handle_queue(req);
+}
+
+static int kmb_ocs_hcu_final(struct ahash_request *req)
+{
+	struct ocs_hcu_rctx *rctx = ahash_request_ctx(req);
+
+	rctx->sg_data_total = 0;
+	rctx->sg_data_offset = 0;
+	rctx->sg = NULL;
+
+	rctx->flags |= REQ_FINAL;
+
+	return kmb_ocs_hcu_handle_queue(req);
+}
+
+static int kmb_ocs_hcu_finup(struct ahash_request *req)
+{
+	struct ocs_hcu_rctx *rctx = ahash_request_ctx(req);
+
+	rctx->sg_data_total = req->nbytes;
+	rctx->sg_data_offset = 0;
+	rctx->sg = req->src;
+
+	rctx->flags |= REQ_FINAL;
+
+	return kmb_ocs_hcu_handle_queue(req);
+}
+
+static int kmb_ocs_hcu_digest(struct ahash_request *req)
+{
+	int rc = 0;
+	struct ocs_hcu_dev *hcu_dev = kmb_ocs_hcu_find_dev(req);
+
+	if (!hcu_dev)
+		return -ENOENT;
+
+	rc = kmb_ocs_hcu_init(req);
+	if (rc)
+		return rc;
+
+	rc = kmb_ocs_hcu_finup(req);
+
+	return rc;
+}
+
+static int kmb_ocs_hcu_export(struct ahash_request *req, void *out)
+{
+	struct ocs_hcu_rctx *rctx = ahash_request_ctx(req);
+
+	/* Intermediate data is always stored and applied per request. */
+	memcpy(out, rctx, sizeof(*rctx));
+
+	return 0;
+}
+
+static int kmb_ocs_hcu_import(struct ahash_request *req, const void *in)
+{
+	struct ocs_hcu_rctx *rctx = ahash_request_ctx(req);
+
+	/* Intermediate data is always stored and applied per request. */
+	memcpy(rctx, in, sizeof(*rctx));
+
+	return 0;
+}
+
+/* Set request size and initialize tfm context. */
+static void __cra_init(struct crypto_tfm *tfm, struct ocs_hcu_ctx *ctx)
+{
+	crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
+				 sizeof(struct ocs_hcu_rctx));
+
+	/* Init context to 0. */
+	memzero_explicit(ctx, sizeof(*ctx));
+	/* Set engine ops. */
+	ctx->engine_ctx.op.do_one_request = kmb_ocs_hcu_do_one_request;
+}
+
+static int kmb_ocs_hcu_sha_cra_init(struct crypto_tfm *tfm)
+{
+	struct ocs_hcu_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	__cra_init(tfm, ctx);
+
+	return 0;
+}
+
+static int kmb_ocs_hcu_sm3_cra_init(struct crypto_tfm *tfm)
+{
+	struct ocs_hcu_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	__cra_init(tfm, ctx);
+
+	ctx->is_sm3_tfm = true;
+
+	return 0;
+}
+
+static struct ahash_alg ocs_hcu_algs[] = {
+{
+	.init		= kmb_ocs_hcu_init,
+	.update		= kmb_ocs_hcu_update,
+	.final		= kmb_ocs_hcu_final,
+	.finup		= kmb_ocs_hcu_finup,
+	.digest		= kmb_ocs_hcu_digest,
+	.export		= kmb_ocs_hcu_export,
+	.import		= kmb_ocs_hcu_import,
+	.halg = {
+		.digestsize	= SHA256_DIGEST_SIZE,
+		.statesize	= sizeof(struct ocs_hcu_rctx),
+		.base	= {
+			.cra_name		= "sha256",
+			.cra_driver_name	= "sha256-keembay-ocs",
+			.cra_priority		= 255,
+			.cra_flags		= CRYPTO_ALG_ASYNC,
+			.cra_blocksize		= SHA256_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct ocs_hcu_ctx),
+			.cra_alignmask		= 0,
+			.cra_module		= THIS_MODULE,
+			.cra_init		= kmb_ocs_hcu_sha_cra_init,
+		}
+	}
+},
+{
+	.init		= kmb_ocs_hcu_init,
+	.update		= kmb_ocs_hcu_update,
+	.final		= kmb_ocs_hcu_final,
+	.finup		= kmb_ocs_hcu_finup,
+	.digest		= kmb_ocs_hcu_digest,
+	.export		= kmb_ocs_hcu_export,
+	.import		= kmb_ocs_hcu_import,
+	.halg = {
+		.digestsize	= SM3_DIGEST_SIZE,
+		.statesize	= sizeof(struct ocs_hcu_rctx),
+		.base	= {
+			.cra_name		= "sm3",
+			.cra_driver_name	= "sm3-keembay-ocs",
+			.cra_priority		= 255,
+			.cra_flags		= CRYPTO_ALG_ASYNC,
+			.cra_blocksize		= SM3_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct ocs_hcu_ctx),
+			.cra_alignmask		= 0,
+			.cra_module		= THIS_MODULE,
+			.cra_init		= kmb_ocs_hcu_sm3_cra_init,
+		}
+	}
+},
+{
+	.init		= kmb_ocs_hcu_init,
+	.update		= kmb_ocs_hcu_update,
+	.final		= kmb_ocs_hcu_final,
+	.finup		= kmb_ocs_hcu_finup,
+	.digest		= kmb_ocs_hcu_digest,
+	.export		= kmb_ocs_hcu_export,
+	.import		= kmb_ocs_hcu_import,
+	.halg = {
+		.digestsize	= SHA384_DIGEST_SIZE,
+		.statesize	= sizeof(struct ocs_hcu_rctx),
+		.base	= {
+			.cra_name		= "sha384",
+			.cra_driver_name	= "sha384-keembay-ocs",
+			.cra_priority		= 255,
+			.cra_flags		= CRYPTO_ALG_ASYNC,
+			.cra_blocksize		= SHA384_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct ocs_hcu_ctx),
+			.cra_alignmask		= 0,
+			.cra_module		= THIS_MODULE,
+			.cra_init		= kmb_ocs_hcu_sha_cra_init,
+		}
+	}
+},
+{
+	.init		= kmb_ocs_hcu_init,
+	.update		= kmb_ocs_hcu_update,
+	.final		= kmb_ocs_hcu_final,
+	.finup		= kmb_ocs_hcu_finup,
+	.digest		= kmb_ocs_hcu_digest,
+	.export		= kmb_ocs_hcu_export,
+	.import		= kmb_ocs_hcu_import,
+	.halg = {
+		.digestsize	= SHA512_DIGEST_SIZE,
+		.statesize	= sizeof(struct ocs_hcu_rctx),
+		.base	= {
+			.cra_name		= "sha512",
+			.cra_driver_name	= "sha512-keembay-ocs",
+			.cra_priority		= 255,
+			.cra_flags		= CRYPTO_ALG_ASYNC,
+			.cra_blocksize		= SHA512_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct ocs_hcu_ctx),
+			.cra_alignmask		= 0,
+			.cra_module		= THIS_MODULE,
+			.cra_init		= kmb_ocs_hcu_sha_cra_init,
+		}
+	}
+},
+};
+
+/* Device tree driver match. */
+static const struct of_device_id kmb_ocs_hcu_of_match[] = {
+	{
+		.compatible = "intel,keembay-ocs-hcu",
+	},
+	{}
+};
+
+static int kmb_ocs_hcu_remove(struct platform_device *pdev)
+{
+	struct ocs_hcu_dev *hcu_dev;
+	int rc;
+
+	hcu_dev = platform_get_drvdata(pdev);
+	if (!hcu_dev)
+		return -ENODEV;
+
+	crypto_unregister_ahashes(ocs_hcu_algs, ARRAY_SIZE(ocs_hcu_algs));
+
+	rc = crypto_engine_exit(hcu_dev->engine);
+
+	spin_lock_bh(&ocs_hcu.lock);
+	list_del(&hcu_dev->list);
+	spin_unlock_bh(&ocs_hcu.lock);
+
+	return rc;
+}
+
+static int kmb_ocs_hcu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ocs_hcu_dev *hcu_dev;
+	struct resource *hcu_mem;
+	int rc;
+
+	hcu_dev = devm_kzalloc(dev, sizeof(*hcu_dev), GFP_KERNEL);
+	if (!hcu_dev)
+		return -ENOMEM;
+
+	hcu_dev->dev = dev;
+
+	platform_set_drvdata(pdev, hcu_dev);
+	rc = dma_set_mask_and_coherent(&pdev->dev, OCS_HCU_DMA_BIT_MASK);
+	if (rc)
+		return rc;
+
+	/* Get the memory address and remap. */
+	hcu_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!hcu_mem) {
+		dev_err(dev, "Could not retrieve io mem resource.\n");
+		return -ENODEV;
+	}
+
+	hcu_dev->io_base = devm_ioremap_resource(dev, hcu_mem);
+	if (IS_ERR(hcu_dev->io_base)) {
+		dev_err(dev, "Could not io-remap mem resource.\n");
+		return PTR_ERR(hcu_dev->io_base);
+	}
+
+	init_completion(&hcu_dev->irq_done);
+
+	/* Get and request IRQ. */
+	hcu_dev->irq = platform_get_irq(pdev, 0);
+	if (hcu_dev->irq < 0)
+		return hcu_dev->irq;
+
+	rc = devm_request_threaded_irq(&pdev->dev, hcu_dev->irq,
+				       ocs_hcu_irq_handler, NULL, 0,
+				       "keembay-ocs-hcu", hcu_dev);
+	if (rc < 0) {
+		dev_err(dev, "Could not request IRQ.\n");
+		return rc;
+	}
+
+	INIT_LIST_HEAD(&hcu_dev->list);
+
+	spin_lock_bh(&ocs_hcu.lock);
+	list_add_tail(&hcu_dev->list, &ocs_hcu.dev_list);
+	spin_unlock_bh(&ocs_hcu.lock);
+
+	/* Initialize crypto engine */
+	hcu_dev->engine = crypto_engine_alloc_init(dev, 1);
+	if (!hcu_dev->engine)
+		goto list_del;
+
+	rc = crypto_engine_start(hcu_dev->engine);
+	if (rc) {
+		dev_err(dev, "Could not start engine.\n");
+		goto cleanup;
+	}
+
+	/* Security infrastructure guarantees OCS clock is enabled. */
+
+	rc = crypto_register_ahashes(ocs_hcu_algs, ARRAY_SIZE(ocs_hcu_algs));
+	if (rc) {
+		dev_err(dev, "Could not register algorithms.\n");
+		goto cleanup;
+	}
+
+	return 0;
+
+cleanup:
+	crypto_engine_exit(hcu_dev->engine);
+list_del:
+	spin_lock_bh(&ocs_hcu.lock);
+	list_del(&hcu_dev->list);
+	spin_unlock_bh(&ocs_hcu.lock);
+
+	return rc;
+}
+
+/* The OCS driver is a platform device. */
+static struct platform_driver kmb_ocs_hcu_driver = {
+	.probe = kmb_ocs_hcu_probe,
+	.remove = kmb_ocs_hcu_remove,
+	.driver = {
+			.name = DRV_NAME,
+			.of_match_table = kmb_ocs_hcu_of_match,
+		},
+};
+
+module_platform_driver(kmb_ocs_hcu_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/crypto/keembay/ocs-hcu.c b/drivers/crypto/keembay/ocs-hcu.c
new file mode 100644
index 000000000000..6a80a31d0b00
--- /dev/null
+++ b/drivers/crypto/keembay/ocs-hcu.c
@@ -0,0 +1,684 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel Keem Bay OCS HCU Crypto Driver.
+ *
+ * Copyright (C) 2018-2020 Intel Corporation
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/iopoll.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+
+#include <crypto/sha2.h>
+
+#include "ocs-hcu.h"
+
+/* Registers. */
+#define OCS_HCU_MODE			0x00
+#define OCS_HCU_CHAIN			0x04
+#define OCS_HCU_OPERATION		0x08
+#define OCS_HCU_KEY_0			0x0C
+#define OCS_HCU_ISR			0x50
+#define OCS_HCU_IER			0x54
+#define OCS_HCU_STATUS			0x58
+#define OCS_HCU_MSG_LEN_LO		0x60
+#define OCS_HCU_MSG_LEN_HI		0x64
+#define OCS_HCU_KEY_BYTE_ORDER_CFG	0x80
+#define OCS_HCU_DMA_SRC_ADDR		0x400
+#define OCS_HCU_DMA_SRC_SIZE		0x408
+#define OCS_HCU_DMA_DST_SIZE		0x40C
+#define OCS_HCU_DMA_DMA_MODE		0x410
+#define OCS_HCU_DMA_NEXT_SRC_DESCR	0x418
+#define OCS_HCU_DMA_MSI_ISR		0x480
+#define OCS_HCU_DMA_MSI_IER		0x484
+#define OCS_HCU_DMA_MSI_MASK		0x488
+
+/* Register bit definitions. */
+#define HCU_MODE_ALGO_SHIFT		16
+#define HCU_MODE_HMAC_SHIFT		22
+
+#define HCU_STATUS_BUSY			BIT(0)
+
+#define HCU_BYTE_ORDER_SWAP		BIT(0)
+
+#define HCU_IRQ_HASH_DONE		BIT(2)
+#define HCU_IRQ_HASH_ERR_MASK		(BIT(3) | BIT(1) | BIT(0))
+
+#define HCU_DMA_IRQ_SRC_DONE		BIT(0)
+#define HCU_DMA_IRQ_SAI_ERR		BIT(2)
+#define HCU_DMA_IRQ_BAD_COMP_ERR	BIT(3)
+#define HCU_DMA_IRQ_INBUF_RD_ERR	BIT(4)
+#define HCU_DMA_IRQ_INBUF_WD_ERR	BIT(5)
+#define HCU_DMA_IRQ_OUTBUF_WR_ERR	BIT(6)
+#define HCU_DMA_IRQ_OUTBUF_RD_ERR	BIT(7)
+#define HCU_DMA_IRQ_CRD_ERR		BIT(8)
+#define HCU_DMA_IRQ_ERR_MASK		(HCU_DMA_IRQ_SAI_ERR | \
+					 HCU_DMA_IRQ_BAD_COMP_ERR | \
+					 HCU_DMA_IRQ_INBUF_RD_ERR | \
+					 HCU_DMA_IRQ_INBUF_WD_ERR | \
+					 HCU_DMA_IRQ_OUTBUF_WR_ERR | \
+					 HCU_DMA_IRQ_OUTBUF_RD_ERR | \
+					 HCU_DMA_IRQ_CRD_ERR)
+
+#define HCU_DMA_SNOOP_MASK		(0x7 << 28)
+#define HCU_DMA_SRC_LL_EN		BIT(25)
+#define HCU_DMA_EN			BIT(31)
+
+#define OCS_HCU_ENDIANNESS_VALUE	0x2A
+
+#define HCU_DMA_MSI_UNMASK		BIT(0)
+#define HCU_DMA_MSI_DISABLE		0
+#define HCU_IRQ_DISABLE			0
+
+#define OCS_HCU_START			BIT(0)
+#define OCS_HCU_TERMINATE		BIT(1)
+
+#define OCS_LL_DMA_FLAG_TERMINATE	BIT(31)
+
+#define OCS_HCU_HW_KEY_LEN_U32		(OCS_HCU_HW_KEY_LEN / sizeof(u32))
+
+#define HCU_DATA_WRITE_ENDIANNESS_OFFSET	26
+
+#define OCS_HCU_NUM_CHAINS_SHA256_224_SM3	(SHA256_DIGEST_SIZE / sizeof(u32))
+#define OCS_HCU_NUM_CHAINS_SHA384_512		(SHA512_DIGEST_SIZE / sizeof(u32))
+
+/*
+ * While polling on a busy HCU, wait maximum 200us between one check and the
+ * other.
+ */
+#define OCS_HCU_WAIT_BUSY_RETRY_DELAY_US	200
+/* Wait on a busy HCU for maximum 1 second. */
+#define OCS_HCU_WAIT_BUSY_TIMEOUT_US		1000000
+
+/**
+ * struct ocs_hcu_dma_list - An entry in an OCS DMA linked list.
+ * @src_addr:  Source address of the data.
+ * @src_len:   Length of data to be fetched.
+ * @nxt_desc:  Next descriptor to fetch.
+ * @ll_flags:  Flags (Freeze @ terminate) for the DMA engine.
+ */
+struct ocs_hcu_dma_entry {
+	u32 src_addr;
+	u32 src_len;
+	u32 nxt_desc;
+	u32 ll_flags;
+};
+
+/**
+ * struct ocs_dma_list - OCS-specific DMA linked list.
+ * @head:	The head of the list (points to the array backing the list).
+ * @tail:	The current tail of the list; NULL if the list is empty.
+ * @dma_addr:	The DMA address of @head (i.e., the DMA address of the backing
+ *		array).
+ * @max_nents:	Maximum number of entries in the list (i.e., number of elements
+ *		in the backing array).
+ *
+ * The OCS DMA list is an array-backed list of OCS DMA descriptors. The array
+ * backing the list is allocated with dma_alloc_coherent() and pointed by
+ * @head.
+ */
+struct ocs_hcu_dma_list {
+	struct ocs_hcu_dma_entry	*head;
+	struct ocs_hcu_dma_entry	*tail;
+	dma_addr_t			dma_addr;
+	size_t				max_nents;
+};
+
+static inline u32 ocs_hcu_num_chains(enum ocs_hcu_algo algo)
+{
+	switch (algo) {
+	case OCS_HCU_ALGO_SHA224:
+	case OCS_HCU_ALGO_SHA256:
+	case OCS_HCU_ALGO_SM3:
+		return OCS_HCU_NUM_CHAINS_SHA256_224_SM3;
+	case OCS_HCU_ALGO_SHA384:
+	case OCS_HCU_ALGO_SHA512:
+		return OCS_HCU_NUM_CHAINS_SHA384_512;
+	default:
+		return 0;
+	};
+}
+
+static inline u32 ocs_hcu_digest_size(enum ocs_hcu_algo algo)
+{
+	switch (algo) {
+	case OCS_HCU_ALGO_SHA224:
+		return SHA224_DIGEST_SIZE;
+	case OCS_HCU_ALGO_SHA256:
+	case OCS_HCU_ALGO_SM3:
+		/* SM3 shares the same block size. */
+		return SHA256_DIGEST_SIZE;
+	case OCS_HCU_ALGO_SHA384:
+		return SHA384_DIGEST_SIZE;
+	case OCS_HCU_ALGO_SHA512:
+		return SHA512_DIGEST_SIZE;
+	default:
+		return 0;
+	}
+}
+
+/**
+ * ocs_hcu_wait_busy() - Wait for HCU OCS hardware to became usable.
+ * @hcu_dev:	OCS HCU device to wait for.
+ *
+ * Return: 0 if device free, -ETIMEOUT if device busy and internal timeout has
+ *	   expired.
+ */
+static int ocs_hcu_wait_busy(struct ocs_hcu_dev *hcu_dev)
+{
+	long val;
+
+	return readl_poll_timeout(hcu_dev->io_base + OCS_HCU_STATUS, val,
+				  !(val & HCU_STATUS_BUSY),
+				  OCS_HCU_WAIT_BUSY_RETRY_DELAY_US,
+				  OCS_HCU_WAIT_BUSY_TIMEOUT_US);
+}
+
+static void ocs_hcu_done_irq_en(struct ocs_hcu_dev *hcu_dev)
+{
+	/* Clear any pending interrupts. */
+	writel(0xFFFFFFFF, hcu_dev->io_base + OCS_HCU_ISR);
+	hcu_dev->irq_err = false;
+	/* Enable error and HCU done interrupts. */
+	writel(HCU_IRQ_HASH_DONE | HCU_IRQ_HASH_ERR_MASK,
+	       hcu_dev->io_base + OCS_HCU_IER);
+}
+
+static void ocs_hcu_dma_irq_en(struct ocs_hcu_dev *hcu_dev)
+{
+	/* Clear any pending interrupts. */
+	writel(0xFFFFFFFF, hcu_dev->io_base + OCS_HCU_DMA_MSI_ISR);
+	hcu_dev->irq_err = false;
+	/* Only operating on DMA source completion and error interrupts. */
+	writel(HCU_DMA_IRQ_ERR_MASK | HCU_DMA_IRQ_SRC_DONE,
+	       hcu_dev->io_base + OCS_HCU_DMA_MSI_IER);
+	/* Unmask */
+	writel(HCU_DMA_MSI_UNMASK, hcu_dev->io_base + OCS_HCU_DMA_MSI_MASK);
+}
+
+static void ocs_hcu_irq_dis(struct ocs_hcu_dev *hcu_dev)
+{
+	writel(HCU_IRQ_DISABLE, hcu_dev->io_base + OCS_HCU_IER);
+	writel(HCU_DMA_MSI_DISABLE, hcu_dev->io_base + OCS_HCU_DMA_MSI_IER);
+}
+
+static int ocs_hcu_wait_and_disable_irq(struct ocs_hcu_dev *hcu_dev)
+{
+	int rc;
+
+	rc = wait_for_completion_interruptible(&hcu_dev->irq_done);
+	if (rc)
+		goto exit;
+
+	if (hcu_dev->irq_err) {
+		/* Unset flag and return error. */
+		hcu_dev->irq_err = false;
+		rc = -EIO;
+		goto exit;
+	}
+
+exit:
+	ocs_hcu_irq_dis(hcu_dev);
+
+	return rc;
+}
+
+/**
+ * ocs_hcu_get_intermediate_data() - Get intermediate data.
+ * @hcu_dev:	The target HCU device.
+ * @data:	Where to store the intermediate.
+ * @algo:	The algorithm being used.
+ *
+ * This function is used to save the current hashing process state in order to
+ * continue it in the future.
+ *
+ * Note: once all data has been processed, the intermediate data actually
+ * contains the hashing result. So this function is also used to retrieve the
+ * final result of a hashing process.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+static int ocs_hcu_get_intermediate_data(struct ocs_hcu_dev *hcu_dev,
+					 struct ocs_hcu_idata *data,
+					 enum ocs_hcu_algo algo)
+{
+	const int n = ocs_hcu_num_chains(algo);
+	u32 *chain;
+	int rc;
+	int i;
+
+	/* Data not requested. */
+	if (!data)
+		return -EINVAL;
+
+	chain = (u32 *)data->digest;
+
+	/* Ensure that the OCS is no longer busy before reading the chains. */
+	rc = ocs_hcu_wait_busy(hcu_dev);
+	if (rc)
+		return rc;
+
+	/*
+	 * This loops is safe because data->digest is an array of
+	 * SHA512_DIGEST_SIZE bytes and the maximum value returned by
+	 * ocs_hcu_num_chains() is OCS_HCU_NUM_CHAINS_SHA384_512 which is equal
+	 * to SHA512_DIGEST_SIZE / sizeof(u32).
+	 */
+	for (i = 0; i < n; i++)
+		chain[i] = readl(hcu_dev->io_base + OCS_HCU_CHAIN);
+
+	data->msg_len_lo = readl(hcu_dev->io_base + OCS_HCU_MSG_LEN_LO);
+	data->msg_len_hi = readl(hcu_dev->io_base + OCS_HCU_MSG_LEN_HI);
+
+	return 0;
+}
+
+/**
+ * ocs_hcu_set_intermediate_data() - Set intermediate data.
+ * @hcu_dev:	The target HCU device.
+ * @data:	The intermediate data to be set.
+ * @algo:	The algorithm being used.
+ *
+ * This function is used to continue a previous hashing process.
+ */
+static void ocs_hcu_set_intermediate_data(struct ocs_hcu_dev *hcu_dev,
+					  const struct ocs_hcu_idata *data,
+					  enum ocs_hcu_algo algo)
+{
+	const int n = ocs_hcu_num_chains(algo);
+	u32 *chain = (u32 *)data->digest;
+	int i;
+
+	/*
+	 * This loops is safe because data->digest is an array of
+	 * SHA512_DIGEST_SIZE bytes and the maximum value returned by
+	 * ocs_hcu_num_chains() is OCS_HCU_NUM_CHAINS_SHA384_512 which is equal
+	 * to SHA512_DIGEST_SIZE / sizeof(u32).
+	 */
+	for (i = 0; i < n; i++)
+		writel(chain[i], hcu_dev->io_base + OCS_HCU_CHAIN);
+
+	writel(data->msg_len_lo, hcu_dev->io_base + OCS_HCU_MSG_LEN_LO);
+	writel(data->msg_len_hi, hcu_dev->io_base + OCS_HCU_MSG_LEN_HI);
+}
+
+static int ocs_hcu_get_digest(struct ocs_hcu_dev *hcu_dev,
+			      enum ocs_hcu_algo algo, u8 *dgst, size_t dgst_len)
+{
+	u32 *chain;
+	int rc;
+	int i;
+
+	if (!dgst)
+		return -EINVAL;
+
+	/* Length of the output buffer must match the algo digest size. */
+	if (dgst_len != ocs_hcu_digest_size(algo))
+		return -EINVAL;
+
+	/* Ensure that the OCS is no longer busy before reading the chains. */
+	rc = ocs_hcu_wait_busy(hcu_dev);
+	if (rc)
+		return rc;
+
+	chain = (u32 *)dgst;
+	for (i = 0; i < dgst_len / sizeof(u32); i++)
+		chain[i] = readl(hcu_dev->io_base + OCS_HCU_CHAIN);
+
+	return 0;
+}
+
+/**
+ * ocs_hcu_hw_cfg() - Configure the HCU hardware.
+ * @hcu_dev:	The HCU device to configure.
+ * @algo:	The algorithm to be used by the HCU device.
+ * @use_hmac:	Whether or not HW HMAC should be used.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+static int ocs_hcu_hw_cfg(struct ocs_hcu_dev *hcu_dev, enum ocs_hcu_algo algo,
+			  bool use_hmac)
+{
+	u32 cfg;
+	int rc;
+
+	if (algo != OCS_HCU_ALGO_SHA256 && algo != OCS_HCU_ALGO_SHA224 &&
+	    algo != OCS_HCU_ALGO_SHA384 && algo != OCS_HCU_ALGO_SHA512 &&
+	    algo != OCS_HCU_ALGO_SM3)
+		return -EINVAL;
+
+	rc = ocs_hcu_wait_busy(hcu_dev);
+	if (rc)
+		return rc;
+
+	/* Ensure interrupts are disabled. */
+	ocs_hcu_irq_dis(hcu_dev);
+
+	/* Configure endianness, hashing algorithm and HW HMAC (if needed) */
+	cfg = OCS_HCU_ENDIANNESS_VALUE << HCU_DATA_WRITE_ENDIANNESS_OFFSET;
+	cfg |= algo << HCU_MODE_ALGO_SHIFT;
+	if (use_hmac)
+		cfg |= BIT(HCU_MODE_HMAC_SHIFT);
+
+	writel(cfg, hcu_dev->io_base + OCS_HCU_MODE);
+
+	return 0;
+}
+
+/**
+ * ocs_hcu_ll_dma_start() - Start OCS HCU hashing via DMA
+ * @hcu_dev:	The OCS HCU device to use.
+ * @dma_list:	The OCS DMA list mapping the data to hash.
+ * @finalize:	Whether or not this is the last hashing operation and therefore
+ *		the final hash should be compute even if data is not
+ *		block-aligned.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+static int ocs_hcu_ll_dma_start(struct ocs_hcu_dev *hcu_dev,
+				const struct ocs_hcu_dma_list *dma_list,
+				bool finalize)
+{
+	u32 cfg = HCU_DMA_SNOOP_MASK | HCU_DMA_SRC_LL_EN | HCU_DMA_EN;
+	int rc;
+
+	if (!dma_list)
+		return -EINVAL;
+
+	/*
+	 * For final requests we use HCU_DONE IRQ to be notified when all input
+	 * data has been processed by the HCU; however, we cannot do so for
+	 * non-final requests, because we don't get a HCU_DONE IRQ when we
+	 * don't terminate the operation.
+	 *
+	 * Therefore, for non-final requests, we use the DMA IRQ, which
+	 * triggers when DMA has finishing feeding all the input data to the
+	 * HCU, but the HCU may still be processing it. This is fine, since we
+	 * will wait for the HCU processing to be completed when we try to read
+	 * intermediate results, in ocs_hcu_get_intermediate_data().
+	 */
+	if (finalize)
+		ocs_hcu_done_irq_en(hcu_dev);
+	else
+		ocs_hcu_dma_irq_en(hcu_dev);
+
+	reinit_completion(&hcu_dev->irq_done);
+	writel(dma_list->dma_addr, hcu_dev->io_base + OCS_HCU_DMA_NEXT_SRC_DESCR);
+	writel(0, hcu_dev->io_base + OCS_HCU_DMA_SRC_SIZE);
+	writel(0, hcu_dev->io_base + OCS_HCU_DMA_DST_SIZE);
+
+	writel(OCS_HCU_START, hcu_dev->io_base + OCS_HCU_OPERATION);
+
+	writel(cfg, hcu_dev->io_base + OCS_HCU_DMA_DMA_MODE);
+
+	if (finalize)
+		writel(OCS_HCU_TERMINATE, hcu_dev->io_base + OCS_HCU_OPERATION);
+
+	rc = ocs_hcu_wait_and_disable_irq(hcu_dev);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+struct ocs_hcu_dma_list *ocs_hcu_dma_list_alloc(struct ocs_hcu_dev *hcu_dev,
+						int max_nents)
+{
+	struct ocs_hcu_dma_list *dma_list;
+
+	dma_list = kmalloc(sizeof(*dma_list), GFP_KERNEL);
+	if (!dma_list)
+		return NULL;
+
+	/* Total size of the DMA list to allocate. */
+	dma_list->head = dma_alloc_coherent(hcu_dev->dev,
+					    sizeof(*dma_list->head) * max_nents,
+					    &dma_list->dma_addr, GFP_KERNEL);
+	if (!dma_list->head) {
+		kfree(dma_list);
+		return NULL;
+	}
+	dma_list->max_nents = max_nents;
+	dma_list->tail = NULL;
+
+	return dma_list;
+}
+
+void ocs_hcu_dma_list_free(struct ocs_hcu_dev *hcu_dev,
+			   struct ocs_hcu_dma_list *dma_list)
+{
+	if (!dma_list)
+		return;
+
+	dma_free_coherent(hcu_dev->dev,
+			  sizeof(*dma_list->head) * dma_list->max_nents,
+			  dma_list->head, dma_list->dma_addr);
+
+	kfree(dma_list);
+}
+
+/* Add a new DMA entry at the end of the OCS DMA list. */
+int ocs_hcu_dma_list_add_tail(struct ocs_hcu_dev *hcu_dev,
+			      struct ocs_hcu_dma_list *dma_list,
+			      dma_addr_t addr, u32 len)
+{
+	struct device *dev = hcu_dev->dev;
+	struct ocs_hcu_dma_entry *old_tail;
+	struct ocs_hcu_dma_entry *new_tail;
+
+	if (!len)
+		return 0;
+
+	if (!dma_list)
+		return -EINVAL;
+
+	if (addr & ~OCS_HCU_DMA_BIT_MASK) {
+		dev_err(dev,
+			"Unexpected error: Invalid DMA address for OCS HCU\n");
+		return -EINVAL;
+	}
+
+	old_tail = dma_list->tail;
+	new_tail = old_tail ? old_tail + 1 : dma_list->head;
+
+	/* Check if list is full. */
+	if (new_tail - dma_list->head >= dma_list->max_nents)
+		return -ENOMEM;
+
+	/*
+	 * If there was an old tail (i.e., this is not the first element we are
+	 * adding), un-terminate the old tail and make it point to the new one.
+	 */
+	if (old_tail) {
+		old_tail->ll_flags &= ~OCS_LL_DMA_FLAG_TERMINATE;
+		/*
+		 * The old tail 'nxt_desc' must point to the DMA address of the
+		 * new tail.
+		 */
+		old_tail->nxt_desc = dma_list->dma_addr +
+				     sizeof(*dma_list->tail) * (new_tail -
+								dma_list->head);
+	}
+
+	new_tail->src_addr = (u32)addr;
+	new_tail->src_len = (u32)len;
+	new_tail->ll_flags = OCS_LL_DMA_FLAG_TERMINATE;
+	new_tail->nxt_desc = 0;
+
+	/* Update list tail with new tail. */
+	dma_list->tail = new_tail;
+
+	return 0;
+}
+
+/**
+ * ocs_hcu_hash_init() - Initialize hash operation context.
+ * @ctx:	The context to initialize.
+ * @algo:	The hashing algorithm to use.
+ *
+ * Return:	0 on success, negative error code otherwise.
+ */
+int ocs_hcu_hash_init(struct ocs_hcu_hash_ctx *ctx, enum ocs_hcu_algo algo)
+{
+	if (!ctx)
+		return -EINVAL;
+
+	ctx->algo = algo;
+	ctx->idata.msg_len_lo = 0;
+	ctx->idata.msg_len_hi = 0;
+	/* No need to set idata.digest to 0. */
+
+	return 0;
+}
+
+/**
+ * ocs_hcu_digest() - Perform a hashing iteration.
+ * @hcu_dev:	The OCS HCU device to use.
+ * @ctx:	The OCS HCU hashing context.
+ * @dma_list:	The OCS DMA list mapping the input data to process.
+ *
+ * Return: 0 on success; negative error code otherwise.
+ */
+int ocs_hcu_hash_update(struct ocs_hcu_dev *hcu_dev,
+			struct ocs_hcu_hash_ctx *ctx,
+			const struct ocs_hcu_dma_list *dma_list)
+{
+	int rc;
+
+	if (!hcu_dev || !ctx)
+		return -EINVAL;
+
+	/* Configure the hardware for the current request. */
+	rc = ocs_hcu_hw_cfg(hcu_dev, ctx->algo, false);
+	if (rc)
+		return rc;
+
+	/* If we already processed some data, idata needs to be set. */
+	if (ctx->idata.msg_len_lo || ctx->idata.msg_len_hi)
+		ocs_hcu_set_intermediate_data(hcu_dev, &ctx->idata, ctx->algo);
+
+	/* Start linked-list DMA hashing. */
+	rc = ocs_hcu_ll_dma_start(hcu_dev, dma_list, false);
+	if (rc)
+		return rc;
+
+	/* Update idata and return. */
+	return ocs_hcu_get_intermediate_data(hcu_dev, &ctx->idata, ctx->algo);
+}
+
+/**
+ * ocs_hcu_hash_final() - Update and finalize hash computation.
+ * @hcu_dev:	The OCS HCU device to use.
+ * @ctx:	The OCS HCU hashing context.
+ * @dma_list:	The OCS DMA list mapping the input data to process.
+ * @dgst:	The buffer where to save the computed digest.
+ * @dgst_len:	The length of @dgst.
+ *
+ * Return: 0 on success; negative error code otherwise.
+ */
+int ocs_hcu_hash_finup(struct ocs_hcu_dev *hcu_dev,
+		       const struct ocs_hcu_hash_ctx *ctx,
+		       const struct ocs_hcu_dma_list *dma_list,
+		       u8 *dgst, size_t dgst_len)
+{
+	int rc;
+
+	if (!hcu_dev || !ctx)
+		return -EINVAL;
+
+	/* Configure the hardware for the current request. */
+	rc = ocs_hcu_hw_cfg(hcu_dev, ctx->algo, false);
+	if (rc)
+		return rc;
+
+	/* If we already processed some data, idata needs to be set. */
+	if (ctx->idata.msg_len_lo || ctx->idata.msg_len_hi)
+		ocs_hcu_set_intermediate_data(hcu_dev, &ctx->idata, ctx->algo);
+
+	/* Start linked-list DMA hashing. */
+	rc = ocs_hcu_ll_dma_start(hcu_dev, dma_list, true);
+	if (rc)
+		return rc;
+
+	/* Get digest and return. */
+	return ocs_hcu_get_digest(hcu_dev, ctx->algo, dgst, dgst_len);
+}
+
+/**
+ * ocs_hcu_hash_final() - Finalize hash computation.
+ * @hcu_dev:		The OCS HCU device to use.
+ * @ctx:		The OCS HCU hashing context.
+ * @dgst:		The buffer where to save the computed digest.
+ * @dgst_len:		The length of @dgst.
+ *
+ * Return: 0 on success; negative error code otherwise.
+ */
+int ocs_hcu_hash_final(struct ocs_hcu_dev *hcu_dev,
+		       const struct ocs_hcu_hash_ctx *ctx, u8 *dgst,
+		       size_t dgst_len)
+{
+	int rc;
+
+	if (!hcu_dev || !ctx)
+		return -EINVAL;
+
+	/* Configure the hardware for the current request. */
+	rc = ocs_hcu_hw_cfg(hcu_dev, ctx->algo, false);
+	if (rc)
+		return rc;
+
+	/* If we already processed some data, idata needs to be set. */
+	if (ctx->idata.msg_len_lo || ctx->idata.msg_len_hi)
+		ocs_hcu_set_intermediate_data(hcu_dev, &ctx->idata, ctx->algo);
+
+	/*
+	 * Enable HCU interrupts, so that HCU_DONE will be triggered once the
+	 * final hash is computed.
+	 */
+	ocs_hcu_done_irq_en(hcu_dev);
+	reinit_completion(&hcu_dev->irq_done);
+	writel(OCS_HCU_TERMINATE, hcu_dev->io_base + OCS_HCU_OPERATION);
+
+	rc = ocs_hcu_wait_and_disable_irq(hcu_dev);
+	if (rc)
+		return rc;
+
+	/* Get digest and return. */
+	return ocs_hcu_get_digest(hcu_dev, ctx->algo, dgst, dgst_len);
+}
+
+irqreturn_t ocs_hcu_irq_handler(int irq, void *dev_id)
+{
+	struct ocs_hcu_dev *hcu_dev = dev_id;
+	u32 hcu_irq;
+	u32 dma_irq;
+
+	/* Read and clear the HCU interrupt. */
+	hcu_irq = readl(hcu_dev->io_base + OCS_HCU_ISR);
+	writel(hcu_irq, hcu_dev->io_base + OCS_HCU_ISR);
+
+	/* Read and clear the HCU DMA interrupt. */
+	dma_irq = readl(hcu_dev->io_base + OCS_HCU_DMA_MSI_ISR);
+	writel(dma_irq, hcu_dev->io_base + OCS_HCU_DMA_MSI_ISR);
+
+	/* Check for errors. */
+	if (hcu_irq & HCU_IRQ_HASH_ERR_MASK || dma_irq & HCU_DMA_IRQ_ERR_MASK) {
+		hcu_dev->irq_err = true;
+		goto complete;
+	}
+
+	/* Check for DONE IRQs. */
+	if (hcu_irq & HCU_IRQ_HASH_DONE || dma_irq & HCU_DMA_IRQ_SRC_DONE)
+		goto complete;
+
+	return IRQ_NONE;
+
+complete:
+	complete(&hcu_dev->irq_done);
+
+	return IRQ_HANDLED;
+}
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/crypto/keembay/ocs-hcu.h b/drivers/crypto/keembay/ocs-hcu.h
new file mode 100644
index 000000000000..6a467dcaf99c
--- /dev/null
+++ b/drivers/crypto/keembay/ocs-hcu.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Intel Keem Bay OCS HCU Crypto Driver.
+ *
+ * Copyright (C) 2018-2020 Intel Corporation
+ */
+
+#include <linux/dma-mapping.h>
+
+#ifndef _CRYPTO_OCS_HCU_H
+#define _CRYPTO_OCS_HCU_H
+
+#define OCS_HCU_DMA_BIT_MASK		DMA_BIT_MASK(32)
+
+#define OCS_HCU_HW_KEY_LEN		64
+
+struct ocs_hcu_dma_list;
+
+enum ocs_hcu_algo {
+	OCS_HCU_ALGO_SHA256 = 2,
+	OCS_HCU_ALGO_SHA224 = 3,
+	OCS_HCU_ALGO_SHA384 = 4,
+	OCS_HCU_ALGO_SHA512 = 5,
+	OCS_HCU_ALGO_SM3    = 6,
+};
+
+/**
+ * struct ocs_hcu_dev - OCS HCU device context.
+ * @list:	List of device contexts.
+ * @dev:	OCS HCU device.
+ * @io_base:	Base address of OCS HCU registers.
+ * @engine:	Crypto engine for the device.
+ * @irq:	IRQ number.
+ * @irq_done:	Completion for IRQ.
+ * @irq_err:	Flag indicating an IRQ error has happened.
+ */
+struct ocs_hcu_dev {
+	struct list_head list;
+	struct device *dev;
+	void __iomem *io_base;
+	struct crypto_engine *engine;
+	int irq;
+	struct completion irq_done;
+	bool irq_err;
+};
+
+/**
+ * struct ocs_hcu_idata - Intermediate data generated by the HCU.
+ * @msg_len_lo: Length of data the HCU has operated on in bits, low 32b.
+ * @msg_len_hi: Length of data the HCU has operated on in bits, high 32b.
+ * @digest: The digest read from the HCU. If the HCU is terminated, it will
+ *	    contain the actual hash digest. Otherwise it is the intermediate
+ *	    state.
+ */
+struct ocs_hcu_idata {
+	u32 msg_len_lo;
+	u32 msg_len_hi;
+	u8  digest[SHA512_DIGEST_SIZE];
+};
+
+/**
+ * struct ocs_hcu_hash_ctx - Context for OCS HCU hashing operation.
+ * @algo:	The hashing algorithm being used.
+ * @idata:	The current intermediate data.
+ */
+struct ocs_hcu_hash_ctx {
+	enum ocs_hcu_algo	algo;
+	struct ocs_hcu_idata	idata;
+};
+
+irqreturn_t ocs_hcu_irq_handler(int irq, void *dev_id);
+
+struct ocs_hcu_dma_list *ocs_hcu_dma_list_alloc(struct ocs_hcu_dev *hcu_dev,
+						int max_nents);
+
+void ocs_hcu_dma_list_free(struct ocs_hcu_dev *hcu_dev,
+			   struct ocs_hcu_dma_list *dma_list);
+
+int ocs_hcu_dma_list_add_tail(struct ocs_hcu_dev *hcu_dev,
+			      struct ocs_hcu_dma_list *dma_list,
+			      dma_addr_t addr, u32 len);
+
+int ocs_hcu_hash_init(struct ocs_hcu_hash_ctx *ctx, enum ocs_hcu_algo algo);
+
+int ocs_hcu_hash_update(struct ocs_hcu_dev *hcu_dev,
+			struct ocs_hcu_hash_ctx *ctx,
+			const struct ocs_hcu_dma_list *dma_list);
+
+int ocs_hcu_hash_finup(struct ocs_hcu_dev *hcu_dev,
+		       const struct ocs_hcu_hash_ctx *ctx,
+		       const struct ocs_hcu_dma_list *dma_list,
+		       u8 *dgst, size_t dgst_len);
+
+int ocs_hcu_hash_final(struct ocs_hcu_dev *hcu_dev,
+		       const struct ocs_hcu_hash_ctx *ctx, u8 *dgst,
+		       size_t dgst_len);
+
+#endif /* _CRYPTO_OCS_HCU_H */
-- 
2.26.2


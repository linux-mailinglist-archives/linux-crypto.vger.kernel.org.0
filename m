Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB9663A82C
	for <lists+linux-crypto@lfdr.de>; Mon, 28 Nov 2022 13:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiK1MXo (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 28 Nov 2022 07:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiK1MX1 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 28 Nov 2022 07:23:27 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0D0192B3
        for <linux-crypto@vger.kernel.org>; Mon, 28 Nov 2022 04:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669638099; x=1701174099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LlLgiT40Y+dnqraJ1NTkLCK5YJkDJeSrxfw0zdVXMxQ=;
  b=bpugPS2LjvybS8WOtT3ele9acf14BvuKkm2nEP159pOCDltMRWi4+89m
   MZLaf7Ana7sL+BnoBnYx8BM5asw7fISSkNQlGXmA1Gj6Z8PHjO3Lv/WDc
   UzrT/sLNdbM8tcc2D7VUlgO6tEh+6bOCFvfIednefPisdA/HOqw4tR0Ge
   APaA2eab4yJ3K4yZaR3IUmvmnRPp40InDBn7Sv1HU+Hv03NvDrq4nuY3i
   Nq3j3wbTiImO93HR+RU7z+F3qSdx5Yp4tz/z9+2/R/9dVVvvvtTjtsDwt
   iPoNV3fQWzeqU766pn5jOwKYxhjDaPsPmt1XTUVWkgMZNkFniJqj2aT0I
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="313517757"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="313517757"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 04:21:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="817806016"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="817806016"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.76])
  by orsmga005.jf.intel.com with ESMTP; 28 Nov 2022 04:21:30 -0800
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Vlad Dronov <vdronov@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Adam Guerin <adam.guerin@intel.com>
Subject: [PATCH v3 01/12] crypto: qat - relocate bufferlist logic
Date:   Mon, 28 Nov 2022 12:21:12 +0000
Message-Id: <20221128122123.130459-2-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221128122123.130459-1-giovanni.cabiddu@intel.com>
References: <20221128122123.130459-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Move the logic that maps, unmaps and converts scatterlists into QAT
bufferlists from qat_algs.c to a new module, qat_bl.
This is to allow reuse of the logic by the data compression service.

This commit does not implement any functional change.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
Reviewed-by: Adam Guerin <adam.guerin@intel.com>
---
 drivers/crypto/qat/qat_common/Makefile   |   3 +-
 drivers/crypto/qat/qat_common/qat_algs.c | 184 +--------------------
 drivers/crypto/qat/qat_common/qat_bl.c   | 194 +++++++++++++++++++++++
 drivers/crypto/qat/qat_common/qat_bl.h   |  17 ++
 4 files changed, 214 insertions(+), 184 deletions(-)
 create mode 100644 drivers/crypto/qat/qat_common/qat_bl.c
 create mode 100644 drivers/crypto/qat/qat_common/qat_bl.h

diff --git a/drivers/crypto/qat/qat_common/Makefile b/drivers/crypto/qat/qat_common/Makefile
index 80919cfcc29d..b0587d03eac2 100644
--- a/drivers/crypto/qat/qat_common/Makefile
+++ b/drivers/crypto/qat/qat_common/Makefile
@@ -19,7 +19,8 @@ intel_qat-objs := adf_cfg.o \
 	qat_asym_algs.o \
 	qat_algs_send.o \
 	qat_uclo.o \
-	qat_hal.o
+	qat_hal.o \
+	qat_bl.o
 
 intel_qat-$(CONFIG_DEBUG_FS) += adf_transport_debug.o
 intel_qat-$(CONFIG_PCI_IOV) += adf_sriov.o adf_vf_isr.o adf_pfvf_utils.o \
diff --git a/drivers/crypto/qat/qat_common/qat_algs.c b/drivers/crypto/qat/qat_common/qat_algs.c
index cad9c58caab1..2ee4fa64032f 100644
--- a/drivers/crypto/qat/qat_common/qat_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_algs.c
@@ -23,6 +23,7 @@
 #include "icp_qat_hw.h"
 #include "icp_qat_fw.h"
 #include "icp_qat_fw_la.h"
+#include "qat_bl.h"
 
 #define QAT_AES_HW_CONFIG_ENC(alg, mode) \
 	ICP_QAT_HW_CIPHER_CONFIG_BUILD(mode, alg, \
@@ -663,189 +664,6 @@ static int qat_alg_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 		return qat_alg_aead_newkey(tfm, key, keylen);
 }
 
-static void qat_alg_free_bufl(struct qat_crypto_instance *inst,
-			      struct qat_crypto_request *qat_req)
-{
-	struct device *dev = &GET_DEV(inst->accel_dev);
-	struct qat_alg_buf_list *bl = qat_req->buf.bl;
-	struct qat_alg_buf_list *blout = qat_req->buf.blout;
-	dma_addr_t blp = qat_req->buf.blp;
-	dma_addr_t blpout = qat_req->buf.bloutp;
-	size_t sz = qat_req->buf.sz;
-	size_t sz_out = qat_req->buf.sz_out;
-	int bl_dma_dir;
-	int i;
-
-	bl_dma_dir = blp != blpout ? DMA_TO_DEVICE : DMA_BIDIRECTIONAL;
-
-	for (i = 0; i < bl->num_bufs; i++)
-		dma_unmap_single(dev, bl->bufers[i].addr,
-				 bl->bufers[i].len, bl_dma_dir);
-
-	dma_unmap_single(dev, blp, sz, DMA_TO_DEVICE);
-
-	if (!qat_req->buf.sgl_src_valid)
-		kfree(bl);
-
-	if (blp != blpout) {
-		/* If out of place operation dma unmap only data */
-		int bufless = blout->num_bufs - blout->num_mapped_bufs;
-
-		for (i = bufless; i < blout->num_bufs; i++) {
-			dma_unmap_single(dev, blout->bufers[i].addr,
-					 blout->bufers[i].len,
-					 DMA_FROM_DEVICE);
-		}
-		dma_unmap_single(dev, blpout, sz_out, DMA_TO_DEVICE);
-
-		if (!qat_req->buf.sgl_dst_valid)
-			kfree(blout);
-	}
-}
-
-static int qat_alg_sgl_to_bufl(struct qat_crypto_instance *inst,
-			       struct scatterlist *sgl,
-			       struct scatterlist *sglout,
-			       struct qat_crypto_request *qat_req,
-			       gfp_t flags)
-{
-	struct device *dev = &GET_DEV(inst->accel_dev);
-	int i, sg_nctr = 0;
-	int n = sg_nents(sgl);
-	struct qat_alg_buf_list *bufl;
-	struct qat_alg_buf_list *buflout = NULL;
-	dma_addr_t blp = DMA_MAPPING_ERROR;
-	dma_addr_t bloutp = DMA_MAPPING_ERROR;
-	struct scatterlist *sg;
-	size_t sz_out, sz = struct_size(bufl, bufers, n);
-	int node = dev_to_node(&GET_DEV(inst->accel_dev));
-	int bufl_dma_dir;
-
-	if (unlikely(!n))
-		return -EINVAL;
-
-	qat_req->buf.sgl_src_valid = false;
-	qat_req->buf.sgl_dst_valid = false;
-
-	if (n > QAT_MAX_BUFF_DESC) {
-		bufl = kzalloc_node(sz, flags, node);
-		if (unlikely(!bufl))
-			return -ENOMEM;
-	} else {
-		bufl = &qat_req->buf.sgl_src.sgl_hdr;
-		memset(bufl, 0, sizeof(struct qat_alg_buf_list));
-		qat_req->buf.sgl_src_valid = true;
-	}
-
-	bufl_dma_dir = sgl != sglout ? DMA_TO_DEVICE : DMA_BIDIRECTIONAL;
-
-	for_each_sg(sgl, sg, n, i)
-		bufl->bufers[i].addr = DMA_MAPPING_ERROR;
-
-	for_each_sg(sgl, sg, n, i) {
-		int y = sg_nctr;
-
-		if (!sg->length)
-			continue;
-
-		bufl->bufers[y].addr = dma_map_single(dev, sg_virt(sg),
-						      sg->length,
-						      bufl_dma_dir);
-		bufl->bufers[y].len = sg->length;
-		if (unlikely(dma_mapping_error(dev, bufl->bufers[y].addr)))
-			goto err_in;
-		sg_nctr++;
-	}
-	bufl->num_bufs = sg_nctr;
-	blp = dma_map_single(dev, bufl, sz, DMA_TO_DEVICE);
-	if (unlikely(dma_mapping_error(dev, blp)))
-		goto err_in;
-	qat_req->buf.bl = bufl;
-	qat_req->buf.blp = blp;
-	qat_req->buf.sz = sz;
-	/* Handle out of place operation */
-	if (sgl != sglout) {
-		struct qat_alg_buf *bufers;
-
-		n = sg_nents(sglout);
-		sz_out = struct_size(buflout, bufers, n);
-		sg_nctr = 0;
-
-		if (n > QAT_MAX_BUFF_DESC) {
-			buflout = kzalloc_node(sz_out, flags, node);
-			if (unlikely(!buflout))
-				goto err_in;
-		} else {
-			buflout = &qat_req->buf.sgl_dst.sgl_hdr;
-			memset(buflout, 0, sizeof(struct qat_alg_buf_list));
-			qat_req->buf.sgl_dst_valid = true;
-		}
-
-		bufers = buflout->bufers;
-		for_each_sg(sglout, sg, n, i)
-			bufers[i].addr = DMA_MAPPING_ERROR;
-
-		for_each_sg(sglout, sg, n, i) {
-			int y = sg_nctr;
-
-			if (!sg->length)
-				continue;
-
-			bufers[y].addr = dma_map_single(dev, sg_virt(sg),
-							sg->length,
-							DMA_FROM_DEVICE);
-			if (unlikely(dma_mapping_error(dev, bufers[y].addr)))
-				goto err_out;
-			bufers[y].len = sg->length;
-			sg_nctr++;
-		}
-		buflout->num_bufs = sg_nctr;
-		buflout->num_mapped_bufs = sg_nctr;
-		bloutp = dma_map_single(dev, buflout, sz_out, DMA_TO_DEVICE);
-		if (unlikely(dma_mapping_error(dev, bloutp)))
-			goto err_out;
-		qat_req->buf.blout = buflout;
-		qat_req->buf.bloutp = bloutp;
-		qat_req->buf.sz_out = sz_out;
-	} else {
-		/* Otherwise set the src and dst to the same address */
-		qat_req->buf.bloutp = qat_req->buf.blp;
-		qat_req->buf.sz_out = 0;
-	}
-	return 0;
-
-err_out:
-	if (!dma_mapping_error(dev, bloutp))
-		dma_unmap_single(dev, bloutp, sz_out, DMA_TO_DEVICE);
-
-	n = sg_nents(sglout);
-	for (i = 0; i < n; i++)
-		if (!dma_mapping_error(dev, buflout->bufers[i].addr))
-			dma_unmap_single(dev, buflout->bufers[i].addr,
-					 buflout->bufers[i].len,
-					 DMA_FROM_DEVICE);
-
-	if (!qat_req->buf.sgl_dst_valid)
-		kfree(buflout);
-
-err_in:
-	if (!dma_mapping_error(dev, blp))
-		dma_unmap_single(dev, blp, sz, DMA_TO_DEVICE);
-
-	n = sg_nents(sgl);
-	for (i = 0; i < n; i++)
-		if (!dma_mapping_error(dev, bufl->bufers[i].addr))
-			dma_unmap_single(dev, bufl->bufers[i].addr,
-					 bufl->bufers[i].len,
-					 bufl_dma_dir);
-
-	if (!qat_req->buf.sgl_src_valid)
-		kfree(bufl);
-
-	dev_err(dev, "Failed to map buf for dma\n");
-	return -ENOMEM;
-}
-
 static void qat_aead_alg_callback(struct icp_qat_fw_la_resp *qat_resp,
 				  struct qat_crypto_request *qat_req)
 {
diff --git a/drivers/crypto/qat/qat_common/qat_bl.c b/drivers/crypto/qat/qat_common/qat_bl.c
new file mode 100644
index 000000000000..6d0a39f8ce10
--- /dev/null
+++ b/drivers/crypto/qat/qat_common/qat_bl.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2014 - 2022 Intel Corporation */
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/pci.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include "adf_accel_devices.h"
+#include "qat_bl.h"
+#include "qat_crypto.h"
+
+void qat_alg_free_bufl(struct qat_crypto_instance *inst,
+		       struct qat_crypto_request *qat_req)
+{
+	struct device *dev = &GET_DEV(inst->accel_dev);
+	struct qat_alg_buf_list *bl = qat_req->buf.bl;
+	struct qat_alg_buf_list *blout = qat_req->buf.blout;
+	dma_addr_t blp = qat_req->buf.blp;
+	dma_addr_t blpout = qat_req->buf.bloutp;
+	size_t sz = qat_req->buf.sz;
+	size_t sz_out = qat_req->buf.sz_out;
+	int bl_dma_dir;
+	int i;
+
+	bl_dma_dir = blp != blpout ? DMA_TO_DEVICE : DMA_BIDIRECTIONAL;
+
+	for (i = 0; i < bl->num_bufs; i++)
+		dma_unmap_single(dev, bl->bufers[i].addr,
+				 bl->bufers[i].len, bl_dma_dir);
+
+	dma_unmap_single(dev, blp, sz, DMA_TO_DEVICE);
+
+	if (!qat_req->buf.sgl_src_valid)
+		kfree(bl);
+
+	if (blp != blpout) {
+		/* If out of place operation dma unmap only data */
+		int bufless = blout->num_bufs - blout->num_mapped_bufs;
+
+		for (i = bufless; i < blout->num_bufs; i++) {
+			dma_unmap_single(dev, blout->bufers[i].addr,
+					 blout->bufers[i].len,
+					 DMA_FROM_DEVICE);
+		}
+		dma_unmap_single(dev, blpout, sz_out, DMA_TO_DEVICE);
+
+		if (!qat_req->buf.sgl_dst_valid)
+			kfree(blout);
+	}
+}
+
+int qat_alg_sgl_to_bufl(struct qat_crypto_instance *inst,
+			struct scatterlist *sgl,
+			struct scatterlist *sglout,
+			struct qat_crypto_request *qat_req,
+			gfp_t flags)
+{
+	struct device *dev = &GET_DEV(inst->accel_dev);
+	int i, sg_nctr = 0;
+	int n = sg_nents(sgl);
+	struct qat_alg_buf_list *bufl;
+	struct qat_alg_buf_list *buflout = NULL;
+	dma_addr_t blp = DMA_MAPPING_ERROR;
+	dma_addr_t bloutp = DMA_MAPPING_ERROR;
+	struct scatterlist *sg;
+	size_t sz_out, sz = struct_size(bufl, bufers, n);
+	int node = dev_to_node(&GET_DEV(inst->accel_dev));
+	int bufl_dma_dir;
+
+	if (unlikely(!n))
+		return -EINVAL;
+
+	qat_req->buf.sgl_src_valid = false;
+	qat_req->buf.sgl_dst_valid = false;
+
+	if (n > QAT_MAX_BUFF_DESC) {
+		bufl = kzalloc_node(sz, flags, node);
+		if (unlikely(!bufl))
+			return -ENOMEM;
+	} else {
+		bufl = &qat_req->buf.sgl_src.sgl_hdr;
+		memset(bufl, 0, sizeof(struct qat_alg_buf_list));
+		qat_req->buf.sgl_src_valid = true;
+	}
+
+	bufl_dma_dir = sgl != sglout ? DMA_TO_DEVICE : DMA_BIDIRECTIONAL;
+
+	for_each_sg(sgl, sg, n, i)
+		bufl->bufers[i].addr = DMA_MAPPING_ERROR;
+
+	for_each_sg(sgl, sg, n, i) {
+		int y = sg_nctr;
+
+		if (!sg->length)
+			continue;
+
+		bufl->bufers[y].addr = dma_map_single(dev, sg_virt(sg),
+						      sg->length,
+						      bufl_dma_dir);
+		bufl->bufers[y].len = sg->length;
+		if (unlikely(dma_mapping_error(dev, bufl->bufers[y].addr)))
+			goto err_in;
+		sg_nctr++;
+	}
+	bufl->num_bufs = sg_nctr;
+	blp = dma_map_single(dev, bufl, sz, DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(dev, blp)))
+		goto err_in;
+	qat_req->buf.bl = bufl;
+	qat_req->buf.blp = blp;
+	qat_req->buf.sz = sz;
+	/* Handle out of place operation */
+	if (sgl != sglout) {
+		struct qat_alg_buf *bufers;
+
+		n = sg_nents(sglout);
+		sz_out = struct_size(buflout, bufers, n);
+		sg_nctr = 0;
+
+		if (n > QAT_MAX_BUFF_DESC) {
+			buflout = kzalloc_node(sz_out, flags, node);
+			if (unlikely(!buflout))
+				goto err_in;
+		} else {
+			buflout = &qat_req->buf.sgl_dst.sgl_hdr;
+			memset(buflout, 0, sizeof(struct qat_alg_buf_list));
+			qat_req->buf.sgl_dst_valid = true;
+		}
+
+		bufers = buflout->bufers;
+		for_each_sg(sglout, sg, n, i)
+			bufers[i].addr = DMA_MAPPING_ERROR;
+
+		for_each_sg(sglout, sg, n, i) {
+			int y = sg_nctr;
+
+			if (!sg->length)
+				continue;
+
+			bufers[y].addr = dma_map_single(dev, sg_virt(sg),
+							sg->length,
+							DMA_FROM_DEVICE);
+			if (unlikely(dma_mapping_error(dev, bufers[y].addr)))
+				goto err_out;
+			bufers[y].len = sg->length;
+			sg_nctr++;
+		}
+		buflout->num_bufs = sg_nctr;
+		buflout->num_mapped_bufs = sg_nctr;
+		bloutp = dma_map_single(dev, buflout, sz_out, DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(dev, bloutp)))
+			goto err_out;
+		qat_req->buf.blout = buflout;
+		qat_req->buf.bloutp = bloutp;
+		qat_req->buf.sz_out = sz_out;
+	} else {
+		/* Otherwise set the src and dst to the same address */
+		qat_req->buf.bloutp = qat_req->buf.blp;
+		qat_req->buf.sz_out = 0;
+	}
+	return 0;
+
+err_out:
+	if (!dma_mapping_error(dev, bloutp))
+		dma_unmap_single(dev, bloutp, sz_out, DMA_TO_DEVICE);
+
+	n = sg_nents(sglout);
+	for (i = 0; i < n; i++)
+		if (!dma_mapping_error(dev, buflout->bufers[i].addr))
+			dma_unmap_single(dev, buflout->bufers[i].addr,
+					 buflout->bufers[i].len,
+					 DMA_FROM_DEVICE);
+
+	if (!qat_req->buf.sgl_dst_valid)
+		kfree(buflout);
+
+err_in:
+	if (!dma_mapping_error(dev, blp))
+		dma_unmap_single(dev, blp, sz, DMA_TO_DEVICE);
+
+	n = sg_nents(sgl);
+	for (i = 0; i < n; i++)
+		if (!dma_mapping_error(dev, bufl->bufers[i].addr))
+			dma_unmap_single(dev, bufl->bufers[i].addr,
+					 bufl->bufers[i].len,
+					 bufl_dma_dir);
+
+	if (!qat_req->buf.sgl_src_valid)
+		kfree(bufl);
+
+	dev_err(dev, "Failed to map buf for dma\n");
+	return -ENOMEM;
+}
diff --git a/drivers/crypto/qat/qat_common/qat_bl.h b/drivers/crypto/qat/qat_common/qat_bl.h
new file mode 100644
index 000000000000..7a916f1ec645
--- /dev/null
+++ b/drivers/crypto/qat/qat_common/qat_bl.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2014 - 2022 Intel Corporation */
+#ifndef QAT_BL_H
+#define QAT_BL_H
+#include <linux/scatterlist.h>
+#include <linux/types.h>
+#include "qat_crypto.h"
+
+void qat_alg_free_bufl(struct qat_crypto_instance *inst,
+		       struct qat_crypto_request *qat_req);
+int qat_alg_sgl_to_bufl(struct qat_crypto_instance *inst,
+			struct scatterlist *sgl,
+			struct scatterlist *sglout,
+			struct qat_crypto_request *qat_req,
+			gfp_t flags);
+
+#endif
-- 
2.38.1


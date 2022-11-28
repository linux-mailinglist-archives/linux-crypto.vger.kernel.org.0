Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507D563A837
	for <lists+linux-crypto@lfdr.de>; Mon, 28 Nov 2022 13:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiK1MYY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 28 Nov 2022 07:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiK1MXc (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 28 Nov 2022 07:23:32 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E43FE1
        for <linux-crypto@vger.kernel.org>; Mon, 28 Nov 2022 04:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669638118; x=1701174118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5xFRRvVu9krawYI4HtCQxIz/y7dQAhCtt4FfSgz+9lQ=;
  b=mpxhHyU3C/C/FXyqRPruwaiFSQilunIJvpLp2wV5Lie2SmLNqUpyXU7q
   PzcxSdDgybh69ZqTnPNL04wRPVjuadVpdb3jar0AkSASO1p+A/ty3ppEb
   OLzl0FCy6+FAvsJIdMOXVu/6Wduda9PvLHb+OzORiRc2muH4xmqBKDOHv
   5UTR4d+6HbHtcj6739th/kQJ8XikEAod6NHA6FCxCg8stAcyRgrPMU2wz
   TmeXcBdcbbHBvWmHDCh7fYcf97YSSQovk9PYUKxE/r5D7jMBuvVi4/Jb8
   zsettxioYfNb2VhaC4SzZCTfwgKu0kpqNt/O+hdTuaInhZjlbuA3mNHn0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="313517861"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="313517861"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 04:21:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="817806197"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="817806197"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.76])
  by orsmga005.jf.intel.com with ESMTP; 28 Nov 2022 04:21:56 -0800
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Vlad Dronov <vdronov@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH v3 12/12] crypto: qat - add resubmit logic for decompression
Date:   Mon, 28 Nov 2022 12:21:23 +0000
Message-Id: <20221128122123.130459-13-giovanni.cabiddu@intel.com>
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

The acomp API allows to send requests with a NULL destination buffer. In
this case, the algorithm implementation needs to allocate the
destination scatter list, perform the operation and return the buffer to
the user. For decompression, data is likely to expand and be bigger than
the allocated buffer.

This implements a re-submission mechanism for decompression requests
that is triggered if the destination buffer, allocated by the driver,
is not sufficiently big to store the output from decompression.

If an overflow is detected when processing the callback for a
decompression request with a NULL destination buffer, a workqueue is
scheduled. This allocates a new scatter list of size CRYPTO_ACOMP_DST_MAX,
now 128KB, creates a new firmware scatter list and resubmits the job to
the hardware accelerator.

Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/qat/qat_common/qat_bl.c        | 159 ++++++++++++++++++
 drivers/crypto/qat/qat_common/qat_bl.h        |   6 +
 drivers/crypto/qat/qat_common/qat_comp_algs.c |  70 ++++++++
 drivers/crypto/qat/qat_common/qat_comp_req.h  |  10 ++
 4 files changed, 245 insertions(+)

diff --git a/drivers/crypto/qat/qat_common/qat_bl.c b/drivers/crypto/qat/qat_common/qat_bl.c
index 221a4eb610a3..2e89ff08041b 100644
--- a/drivers/crypto/qat/qat_common/qat_bl.c
+++ b/drivers/crypto/qat/qat_common/qat_bl.c
@@ -222,3 +222,162 @@ int qat_bl_sgl_to_bufl(struct adf_accel_dev *accel_dev,
 				    extra_dst_buff, sz_extra_dst_buff,
 				    flags);
 }
+
+static void qat_bl_sgl_unmap(struct adf_accel_dev *accel_dev,
+			     struct qat_alg_buf_list *bl)
+{
+	struct device *dev = &GET_DEV(accel_dev);
+	int n = bl->num_bufs;
+	int i;
+
+	for (i = 0; i < n; i++)
+		if (!dma_mapping_error(dev, bl->bufers[i].addr))
+			dma_unmap_single(dev, bl->bufers[i].addr,
+					 bl->bufers[i].len, DMA_FROM_DEVICE);
+}
+
+static int qat_bl_sgl_map(struct adf_accel_dev *accel_dev,
+			  struct scatterlist *sgl,
+			  struct qat_alg_buf_list **bl)
+{
+	struct device *dev = &GET_DEV(accel_dev);
+	struct qat_alg_buf_list *bufl;
+	int node = dev_to_node(dev);
+	struct scatterlist *sg;
+	int n, i, sg_nctr;
+	size_t sz;
+
+	n = sg_nents(sgl);
+	sz = struct_size(bufl, bufers, n);
+	bufl = kzalloc_node(sz, GFP_KERNEL, node);
+	if (unlikely(!bufl))
+		return -ENOMEM;
+
+	for (i = 0; i < n; i++)
+		bufl->bufers[i].addr = DMA_MAPPING_ERROR;
+
+	sg_nctr = 0;
+	for_each_sg(sgl, sg, n, i) {
+		int y = sg_nctr;
+
+		if (!sg->length)
+			continue;
+
+		bufl->bufers[y].addr = dma_map_single(dev, sg_virt(sg),
+						      sg->length,
+						      DMA_FROM_DEVICE);
+		bufl->bufers[y].len = sg->length;
+		if (unlikely(dma_mapping_error(dev, bufl->bufers[y].addr)))
+			goto err_map;
+		sg_nctr++;
+	}
+	bufl->num_bufs = sg_nctr;
+	bufl->num_mapped_bufs = sg_nctr;
+
+	*bl = bufl;
+
+	return 0;
+
+err_map:
+	for (i = 0; i < n; i++)
+		if (!dma_mapping_error(dev, bufl->bufers[i].addr))
+			dma_unmap_single(dev, bufl->bufers[i].addr,
+					 bufl->bufers[i].len,
+					 DMA_FROM_DEVICE);
+	kfree(bufl);
+	*bl = NULL;
+
+	return -ENOMEM;
+}
+
+static void qat_bl_sgl_free_unmap(struct adf_accel_dev *accel_dev,
+				  struct scatterlist *sgl,
+				  struct qat_alg_buf_list *bl,
+				  bool free_bl)
+{
+	if (bl) {
+		qat_bl_sgl_unmap(accel_dev, bl);
+
+		if (free_bl)
+			kfree(bl);
+	}
+	if (sgl)
+		sgl_free(sgl);
+}
+
+static int qat_bl_sgl_alloc_map(struct adf_accel_dev *accel_dev,
+				struct scatterlist **sgl,
+				struct qat_alg_buf_list **bl,
+				unsigned int dlen,
+				gfp_t gfp)
+{
+	struct scatterlist *dst;
+	int ret;
+
+	dst = sgl_alloc(dlen, gfp, NULL);
+	if (!dst) {
+		dev_err(&GET_DEV(accel_dev), "sg_alloc failed\n");
+		return -ENOMEM;
+	}
+
+	ret = qat_bl_sgl_map(accel_dev, dst, bl);
+	if (ret)
+		goto err;
+
+	*sgl = dst;
+
+	return 0;
+
+err:
+	sgl_free(dst);
+	*sgl = NULL;
+	return ret;
+}
+
+int qat_bl_realloc_map_new_dst(struct adf_accel_dev *accel_dev,
+			       struct scatterlist **sg,
+			       unsigned int dlen,
+			       struct qat_request_buffs *qat_bufs,
+			       gfp_t gfp)
+{
+	struct device *dev = &GET_DEV(accel_dev);
+	dma_addr_t new_blp = DMA_MAPPING_ERROR;
+	struct qat_alg_buf_list *new_bl;
+	struct scatterlist *new_sg;
+	size_t new_bl_size;
+	int ret;
+
+	ret = qat_bl_sgl_alloc_map(accel_dev, &new_sg, &new_bl, dlen, gfp);
+	if (ret)
+		return ret;
+
+	new_bl_size = struct_size(new_bl, bufers, new_bl->num_bufs);
+
+	/* Map new firmware SGL descriptor */
+	new_blp = dma_map_single(dev, new_bl, new_bl_size, DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(dev, new_blp)))
+		goto err;
+
+	/* Unmap old firmware SGL descriptor */
+	dma_unmap_single(dev, qat_bufs->bloutp, qat_bufs->sz_out, DMA_TO_DEVICE);
+
+	/* Free and unmap old scatterlist */
+	qat_bl_sgl_free_unmap(accel_dev, *sg, qat_bufs->blout,
+			      !qat_bufs->sgl_dst_valid);
+
+	qat_bufs->sgl_dst_valid = false;
+	qat_bufs->blout = new_bl;
+	qat_bufs->bloutp = new_blp;
+	qat_bufs->sz_out = new_bl_size;
+
+	*sg = new_sg;
+
+	return 0;
+err:
+	qat_bl_sgl_free_unmap(accel_dev, new_sg, new_bl, true);
+
+	if (!dma_mapping_error(dev, new_blp))
+		dma_unmap_single(dev, new_blp, new_bl_size, DMA_TO_DEVICE);
+
+	return -ENOMEM;
+}
diff --git a/drivers/crypto/qat/qat_common/qat_bl.h b/drivers/crypto/qat/qat_common/qat_bl.h
index 5f2ea8f352f7..8ca5e52ee9e2 100644
--- a/drivers/crypto/qat/qat_common/qat_bl.h
+++ b/drivers/crypto/qat/qat_common/qat_bl.h
@@ -58,4 +58,10 @@ static inline gfp_t qat_algs_alloc_flags(struct crypto_async_request *req)
 	return req->flags & CRYPTO_TFM_REQ_MAY_SLEEP ? GFP_KERNEL : GFP_ATOMIC;
 }
 
+int qat_bl_realloc_map_new_dst(struct adf_accel_dev *accel_dev,
+			       struct scatterlist **newd,
+			       unsigned int dlen,
+			       struct qat_request_buffs *qat_bufs,
+			       gfp_t gfp);
+
 #endif
diff --git a/drivers/crypto/qat/qat_common/qat_comp_algs.c b/drivers/crypto/qat/qat_common/qat_comp_algs.c
index 63fd4ac33dbf..1480d36a8d2b 100644
--- a/drivers/crypto/qat/qat_common/qat_comp_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_comp_algs.c
@@ -5,6 +5,7 @@
 #include <crypto/internal/acompress.h>
 #include <crypto/scatterwalk.h>
 #include <linux/dma-mapping.h>
+#include <linux/workqueue.h>
 #include "adf_accel_devices.h"
 #include "adf_common_drv.h"
 #include "qat_bl.h"
@@ -25,6 +26,11 @@ struct qat_compression_ctx {
 	struct qat_compression_instance *inst;
 };
 
+struct qat_dst {
+	bool is_null;
+	int resubmitted;
+};
+
 struct qat_compression_req {
 	u8 req[QAT_COMP_REQ_SIZE];
 	struct qat_compression_ctx *qat_compression_ctx;
@@ -33,6 +39,8 @@ struct qat_compression_req {
 	enum direction dir;
 	int actual_dlen;
 	struct qat_alg_req alg_req;
+	struct work_struct resubmit;
+	struct qat_dst dst;
 };
 
 static int qat_alg_send_dc_message(struct qat_compression_req *qat_req,
@@ -49,6 +57,46 @@ static int qat_alg_send_dc_message(struct qat_compression_req *qat_req,
 	return qat_alg_send_message(alg_req);
 }
 
+static void qat_comp_resubmit(struct work_struct *work)
+{
+	struct qat_compression_req *qat_req =
+		container_of(work, struct qat_compression_req, resubmit);
+	struct qat_compression_ctx *ctx = qat_req->qat_compression_ctx;
+	struct adf_accel_dev *accel_dev = ctx->inst->accel_dev;
+	struct qat_request_buffs *qat_bufs = &qat_req->buf;
+	struct qat_compression_instance *inst = ctx->inst;
+	struct acomp_req *areq = qat_req->acompress_req;
+	struct crypto_acomp *tfm = crypto_acomp_reqtfm(areq);
+	unsigned int dlen = CRYPTO_ACOMP_DST_MAX;
+	u8 *req = qat_req->req;
+	dma_addr_t dfbuf;
+	int ret;
+
+	areq->dlen = dlen;
+
+	dev_dbg(&GET_DEV(accel_dev), "[%s][%s] retry NULL dst request - dlen = %d\n",
+		crypto_tfm_alg_driver_name(crypto_acomp_tfm(tfm)),
+		qat_req->dir == COMPRESSION ? "comp" : "decomp", dlen);
+
+	ret = qat_bl_realloc_map_new_dst(accel_dev, &areq->dst, dlen, qat_bufs,
+					 qat_algs_alloc_flags(&areq->base));
+	if (ret)
+		goto err;
+
+	qat_req->dst.resubmitted = true;
+
+	dfbuf = qat_req->buf.bloutp;
+	qat_comp_override_dst(req, dfbuf, dlen);
+
+	ret = qat_alg_send_dc_message(qat_req, inst, &areq->base);
+	if (ret != -ENOSPC)
+		return;
+
+err:
+	qat_bl_free_bufl(accel_dev, qat_bufs);
+	areq->base.complete(&areq->base, ret);
+}
+
 static void qat_comp_generic_callback(struct qat_compression_req *qat_req,
 				      void *resp)
 {
@@ -80,6 +128,21 @@ static void qat_comp_generic_callback(struct qat_compression_req *qat_req,
 
 	areq->dlen = 0;
 
+	if (qat_req->dir == DECOMPRESSION && qat_req->dst.is_null) {
+		if (cmp_err == ERR_CODE_OVERFLOW_ERROR) {
+			if (qat_req->dst.resubmitted) {
+				dev_dbg(&GET_DEV(accel_dev),
+					"Output does not fit destination buffer\n");
+				res = -EOVERFLOW;
+				goto end;
+			}
+
+			INIT_WORK(&qat_req->resubmit, qat_comp_resubmit);
+			adf_misc_wq_queue_work(&qat_req->resubmit);
+			return;
+		}
+	}
+
 	if (unlikely(status != ICP_QAT_FW_COMN_STATUS_FLAG_OK))
 		goto end;
 
@@ -176,16 +239,23 @@ static int qat_comp_alg_compress_decompress(struct acomp_req *areq,
 	if (areq->dst && !dlen)
 		return -EINVAL;
 
+	qat_req->dst.is_null = false;
+
 	/* Handle acomp requests that require the allocation of a destination
 	 * buffer. The size of the destination buffer is double the source
 	 * buffer (rounded up to the size of a page) to fit the decompressed
 	 * output or an expansion on the data for compression.
 	 */
 	if (!areq->dst) {
+		qat_req->dst.is_null = true;
+
 		dlen = round_up(2 * slen, PAGE_SIZE);
 		areq->dst = sgl_alloc(dlen, f, NULL);
 		if (!areq->dst)
 			return -ENOMEM;
+
+		areq->dlen = dlen;
+		qat_req->dst.resubmitted = false;
 	}
 
 	if (dir == COMPRESSION) {
diff --git a/drivers/crypto/qat/qat_common/qat_comp_req.h b/drivers/crypto/qat/qat_common/qat_comp_req.h
index 18a1f33a6db9..404e32c5e778 100644
--- a/drivers/crypto/qat/qat_common/qat_comp_req.h
+++ b/drivers/crypto/qat/qat_common/qat_comp_req.h
@@ -25,6 +25,16 @@ static inline void qat_comp_create_req(void *ctx, void *req, u64 src, u32 slen,
 	req_pars->out_buffer_sz = dlen;
 }
 
+static inline void qat_comp_override_dst(void *req, u64 dst, u32 dlen)
+{
+	struct icp_qat_fw_comp_req *fw_req = req;
+	struct icp_qat_fw_comp_req_params *req_pars = &fw_req->comp_pars;
+
+	fw_req->comn_mid.dest_data_addr = dst;
+	fw_req->comn_mid.dst_length = dlen;
+	req_pars->out_buffer_sz = dlen;
+}
+
 static inline void qat_comp_create_compression_req(void *ctx, void *req,
 						   u64 src, u32 slen,
 						   u64 dst, u32 dlen,
-- 
2.38.1


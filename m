Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B9F635C6F
	for <lists+linux-crypto@lfdr.de>; Wed, 23 Nov 2022 13:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbiKWMLI (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 23 Nov 2022 07:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237447AbiKWMKy (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 23 Nov 2022 07:10:54 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BC365857
        for <linux-crypto@vger.kernel.org>; Wed, 23 Nov 2022 04:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669205445; x=1700741445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d1veQr0LieAam1r8o+w6mjv7f8HxbslaUEvp9hjMkAw=;
  b=cAAT8RN5Pn1Ly6r3e7Ro3U48mEmNWRUs8v9snvA/fjRs2BLO2//JmguC
   OK8xmWOG5v2vm0AauOglS2fRPP9FY89ZH4bClCBdvGIyrKTWFHTT82Hdh
   7udxSwNgWszhJYJOFLzOk5TTLGcuGhBV2Kg3yVrWTP15nBYmrcuaWUKEK
   UfcHTaTfd8qaE7nEE8csNdAeLB7n9wOjKxjDGaBF+RpnTvqvQsaDK6NLL
   XPm6k998vrr8GkpLgPC7BdmixH43SlOF0t0isbng+668884rtYayN2Mqv
   2NNEEYi27edfZPiRRtklIljCUz3J31I8JG69++k8qHQ0OpfjpwyktAN9B
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="312752471"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="312752471"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 04:10:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="784227470"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="784227470"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.76])
  by fmsmga001.fm.intel.com with ESMTP; 23 Nov 2022 04:10:44 -0800
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Vlad Dronov <vdronov@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Adam Guerin <adam.guerin@intel.com>
Subject: [PATCH v2 03/11] crypto: qat - change bufferlist logic interface
Date:   Wed, 23 Nov 2022 12:10:24 +0000
Message-Id: <20221123121032.71991-4-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123121032.71991-1-giovanni.cabiddu@intel.com>
References: <20221123121032.71991-1-giovanni.cabiddu@intel.com>
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

The functions qat_alg_sgl_to_bufl() and qat_alg_free_bufl() take as
argument a qat_crypto_instance and a qat_crypto_request structure.
These two structures are used only to get a reference to the
adf_accel_dev and qat_crypto_request_buffs.

In order to reuse these functions for the compression service, change
the signature so that they take adf_accel_dev and
qat_crypto_request_buffs.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
Reviewed-by: Adam Guerin <adam.guerin@intel.com>
---
 drivers/crypto/qat/qat_common/qat_algs.c | 24 +++++----
 drivers/crypto/qat/qat_common/qat_bl.c   | 62 ++++++++++++------------
 drivers/crypto/qat/qat_common/qat_bl.h   |  8 +--
 3 files changed, 49 insertions(+), 45 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/qat_algs.c b/drivers/crypto/qat/qat_common/qat_algs.c
index 3e7e9fffe28b..dfa65e42db78 100644
--- a/drivers/crypto/qat/qat_common/qat_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_algs.c
@@ -673,7 +673,7 @@ static void qat_aead_alg_callback(struct icp_qat_fw_la_resp *qat_resp,
 	u8 stat_filed = qat_resp->comn_resp.comn_status;
 	int res = 0, qat_res = ICP_QAT_FW_COMN_RESP_CRYPTO_STAT_GET(stat_filed);
 
-	qat_bl_free_bufl(inst, qat_req);
+	qat_bl_free_bufl(inst->accel_dev, &qat_req->buf);
 	if (unlikely(qat_res != ICP_QAT_FW_COMN_STATUS_FLAG_OK))
 		res = -EBADMSG;
 	areq->base.complete(&areq->base, res);
@@ -743,7 +743,7 @@ static void qat_skcipher_alg_callback(struct icp_qat_fw_la_resp *qat_resp,
 	u8 stat_filed = qat_resp->comn_resp.comn_status;
 	int res = 0, qat_res = ICP_QAT_FW_COMN_RESP_CRYPTO_STAT_GET(stat_filed);
 
-	qat_bl_free_bufl(inst, qat_req);
+	qat_bl_free_bufl(inst->accel_dev, &qat_req->buf);
 	if (unlikely(qat_res != ICP_QAT_FW_COMN_STATUS_FLAG_OK))
 		res = -EINVAL;
 
@@ -799,7 +799,8 @@ static int qat_alg_aead_dec(struct aead_request *areq)
 	if (cipher_len % AES_BLOCK_SIZE != 0)
 		return -EINVAL;
 
-	ret = qat_bl_sgl_to_bufl(ctx->inst, areq->src, areq->dst, qat_req, f);
+	ret = qat_bl_sgl_to_bufl(ctx->inst->accel_dev, areq->src, areq->dst,
+				 &qat_req->buf, f);
 	if (unlikely(ret))
 		return ret;
 
@@ -821,7 +822,7 @@ static int qat_alg_aead_dec(struct aead_request *areq)
 
 	ret = qat_alg_send_sym_message(qat_req, ctx->inst, &areq->base);
 	if (ret == -ENOSPC)
-		qat_bl_free_bufl(ctx->inst, qat_req);
+		qat_bl_free_bufl(ctx->inst->accel_dev, &qat_req->buf);
 
 	return ret;
 }
@@ -842,7 +843,8 @@ static int qat_alg_aead_enc(struct aead_request *areq)
 	if (areq->cryptlen % AES_BLOCK_SIZE != 0)
 		return -EINVAL;
 
-	ret = qat_bl_sgl_to_bufl(ctx->inst, areq->src, areq->dst, qat_req, f);
+	ret = qat_bl_sgl_to_bufl(ctx->inst->accel_dev, areq->src, areq->dst,
+				 &qat_req->buf, f);
 	if (unlikely(ret))
 		return ret;
 
@@ -866,7 +868,7 @@ static int qat_alg_aead_enc(struct aead_request *areq)
 
 	ret = qat_alg_send_sym_message(qat_req, ctx->inst, &areq->base);
 	if (ret == -ENOSPC)
-		qat_bl_free_bufl(ctx->inst, qat_req);
+		qat_bl_free_bufl(ctx->inst->accel_dev, &qat_req->buf);
 
 	return ret;
 }
@@ -1027,7 +1029,8 @@ static int qat_alg_skcipher_encrypt(struct skcipher_request *req)
 	if (req->cryptlen == 0)
 		return 0;
 
-	ret = qat_bl_sgl_to_bufl(ctx->inst, req->src, req->dst, qat_req, f);
+	ret = qat_bl_sgl_to_bufl(ctx->inst->accel_dev, req->src, req->dst,
+				 &qat_req->buf, f);
 	if (unlikely(ret))
 		return ret;
 
@@ -1048,7 +1051,7 @@ static int qat_alg_skcipher_encrypt(struct skcipher_request *req)
 
 	ret = qat_alg_send_sym_message(qat_req, ctx->inst, &req->base);
 	if (ret == -ENOSPC)
-		qat_bl_free_bufl(ctx->inst, qat_req);
+		qat_bl_free_bufl(ctx->inst->accel_dev, &qat_req->buf);
 
 	return ret;
 }
@@ -1093,7 +1096,8 @@ static int qat_alg_skcipher_decrypt(struct skcipher_request *req)
 	if (req->cryptlen == 0)
 		return 0;
 
-	ret = qat_bl_sgl_to_bufl(ctx->inst, req->src, req->dst, qat_req, f);
+	ret = qat_bl_sgl_to_bufl(ctx->inst->accel_dev, req->src, req->dst,
+				 &qat_req->buf, f);
 	if (unlikely(ret))
 		return ret;
 
@@ -1115,7 +1119,7 @@ static int qat_alg_skcipher_decrypt(struct skcipher_request *req)
 
 	ret = qat_alg_send_sym_message(qat_req, ctx->inst, &req->base);
 	if (ret == -ENOSPC)
-		qat_bl_free_bufl(ctx->inst, qat_req);
+		qat_bl_free_bufl(ctx->inst->accel_dev, &qat_req->buf);
 
 	return ret;
 }
diff --git a/drivers/crypto/qat/qat_common/qat_bl.c b/drivers/crypto/qat/qat_common/qat_bl.c
index 8f7743f3c89b..5e319887f8d6 100644
--- a/drivers/crypto/qat/qat_common/qat_bl.c
+++ b/drivers/crypto/qat/qat_common/qat_bl.c
@@ -10,16 +10,16 @@
 #include "qat_bl.h"
 #include "qat_crypto.h"
 
-void qat_bl_free_bufl(struct qat_crypto_instance *inst,
-		      struct qat_crypto_request *qat_req)
+void qat_bl_free_bufl(struct adf_accel_dev *accel_dev,
+		      struct qat_crypto_request_buffs *buf)
 {
-	struct device *dev = &GET_DEV(inst->accel_dev);
-	struct qat_alg_buf_list *bl = qat_req->buf.bl;
-	struct qat_alg_buf_list *blout = qat_req->buf.blout;
-	dma_addr_t blp = qat_req->buf.blp;
-	dma_addr_t blpout = qat_req->buf.bloutp;
-	size_t sz = qat_req->buf.sz;
-	size_t sz_out = qat_req->buf.sz_out;
+	struct device *dev = &GET_DEV(accel_dev);
+	struct qat_alg_buf_list *bl = buf->bl;
+	struct qat_alg_buf_list *blout = buf->blout;
+	dma_addr_t blp = buf->blp;
+	dma_addr_t blpout = buf->bloutp;
+	size_t sz = buf->sz;
+	size_t sz_out = buf->sz_out;
 	int bl_dma_dir;
 	int i;
 
@@ -31,7 +31,7 @@ void qat_bl_free_bufl(struct qat_crypto_instance *inst,
 
 	dma_unmap_single(dev, blp, sz, DMA_TO_DEVICE);
 
-	if (!qat_req->buf.sgl_src_valid)
+	if (!buf->sgl_src_valid)
 		kfree(bl);
 
 	if (blp != blpout) {
@@ -45,18 +45,18 @@ void qat_bl_free_bufl(struct qat_crypto_instance *inst,
 		}
 		dma_unmap_single(dev, blpout, sz_out, DMA_TO_DEVICE);
 
-		if (!qat_req->buf.sgl_dst_valid)
+		if (!buf->sgl_dst_valid)
 			kfree(blout);
 	}
 }
 
-int qat_bl_sgl_to_bufl(struct qat_crypto_instance *inst,
+int qat_bl_sgl_to_bufl(struct adf_accel_dev *accel_dev,
 		       struct scatterlist *sgl,
 		       struct scatterlist *sglout,
-		       struct qat_crypto_request *qat_req,
+		       struct qat_crypto_request_buffs *buf,
 		       gfp_t flags)
 {
-	struct device *dev = &GET_DEV(inst->accel_dev);
+	struct device *dev = &GET_DEV(accel_dev);
 	int i, sg_nctr = 0;
 	int n = sg_nents(sgl);
 	struct qat_alg_buf_list *bufl;
@@ -65,23 +65,23 @@ int qat_bl_sgl_to_bufl(struct qat_crypto_instance *inst,
 	dma_addr_t bloutp = DMA_MAPPING_ERROR;
 	struct scatterlist *sg;
 	size_t sz_out, sz = struct_size(bufl, bufers, n);
-	int node = dev_to_node(&GET_DEV(inst->accel_dev));
+	int node = dev_to_node(&GET_DEV(accel_dev));
 	int bufl_dma_dir;
 
 	if (unlikely(!n))
 		return -EINVAL;
 
-	qat_req->buf.sgl_src_valid = false;
-	qat_req->buf.sgl_dst_valid = false;
+	buf->sgl_src_valid = false;
+	buf->sgl_dst_valid = false;
 
 	if (n > QAT_MAX_BUFF_DESC) {
 		bufl = kzalloc_node(sz, flags, node);
 		if (unlikely(!bufl))
 			return -ENOMEM;
 	} else {
-		bufl = &qat_req->buf.sgl_src.sgl_hdr;
+		bufl = &buf->sgl_src.sgl_hdr;
 		memset(bufl, 0, sizeof(struct qat_alg_buf_list));
-		qat_req->buf.sgl_src_valid = true;
+		buf->sgl_src_valid = true;
 	}
 
 	bufl_dma_dir = sgl != sglout ? DMA_TO_DEVICE : DMA_BIDIRECTIONAL;
@@ -107,9 +107,9 @@ int qat_bl_sgl_to_bufl(struct qat_crypto_instance *inst,
 	blp = dma_map_single(dev, bufl, sz, DMA_TO_DEVICE);
 	if (unlikely(dma_mapping_error(dev, blp)))
 		goto err_in;
-	qat_req->buf.bl = bufl;
-	qat_req->buf.blp = blp;
-	qat_req->buf.sz = sz;
+	buf->bl = bufl;
+	buf->blp = blp;
+	buf->sz = sz;
 	/* Handle out of place operation */
 	if (sgl != sglout) {
 		struct qat_alg_buf *bufers;
@@ -123,9 +123,9 @@ int qat_bl_sgl_to_bufl(struct qat_crypto_instance *inst,
 			if (unlikely(!buflout))
 				goto err_in;
 		} else {
-			buflout = &qat_req->buf.sgl_dst.sgl_hdr;
+			buflout = &buf->sgl_dst.sgl_hdr;
 			memset(buflout, 0, sizeof(struct qat_alg_buf_list));
-			qat_req->buf.sgl_dst_valid = true;
+			buf->sgl_dst_valid = true;
 		}
 
 		bufers = buflout->bufers;
@@ -151,13 +151,13 @@ int qat_bl_sgl_to_bufl(struct qat_crypto_instance *inst,
 		bloutp = dma_map_single(dev, buflout, sz_out, DMA_TO_DEVICE);
 		if (unlikely(dma_mapping_error(dev, bloutp)))
 			goto err_out;
-		qat_req->buf.blout = buflout;
-		qat_req->buf.bloutp = bloutp;
-		qat_req->buf.sz_out = sz_out;
+		buf->blout = buflout;
+		buf->bloutp = bloutp;
+		buf->sz_out = sz_out;
 	} else {
 		/* Otherwise set the src and dst to the same address */
-		qat_req->buf.bloutp = qat_req->buf.blp;
-		qat_req->buf.sz_out = 0;
+		buf->bloutp = buf->blp;
+		buf->sz_out = 0;
 	}
 	return 0;
 
@@ -172,7 +172,7 @@ int qat_bl_sgl_to_bufl(struct qat_crypto_instance *inst,
 					 buflout->bufers[i].len,
 					 DMA_FROM_DEVICE);
 
-	if (!qat_req->buf.sgl_dst_valid)
+	if (!buf->sgl_dst_valid)
 		kfree(buflout);
 
 err_in:
@@ -186,7 +186,7 @@ int qat_bl_sgl_to_bufl(struct qat_crypto_instance *inst,
 					 bufl->bufers[i].len,
 					 bufl_dma_dir);
 
-	if (!qat_req->buf.sgl_src_valid)
+	if (!buf->sgl_src_valid)
 		kfree(bufl);
 
 	dev_err(dev, "Failed to map buf for dma\n");
diff --git a/drivers/crypto/qat/qat_common/qat_bl.h b/drivers/crypto/qat/qat_common/qat_bl.h
index ed4c200ac619..241299c219dd 100644
--- a/drivers/crypto/qat/qat_common/qat_bl.h
+++ b/drivers/crypto/qat/qat_common/qat_bl.h
@@ -6,12 +6,12 @@
 #include <linux/types.h>
 #include "qat_crypto.h"
 
-void qat_bl_free_bufl(struct qat_crypto_instance *inst,
-		      struct qat_crypto_request *qat_req);
-int qat_bl_sgl_to_bufl(struct qat_crypto_instance *inst,
+void qat_bl_free_bufl(struct adf_accel_dev *accel_dev,
+		      struct qat_crypto_request_buffs *buf);
+int qat_bl_sgl_to_bufl(struct adf_accel_dev *accel_dev,
 		       struct scatterlist *sgl,
 		       struct scatterlist *sglout,
-		       struct qat_crypto_request *qat_req,
+		       struct qat_crypto_request_buffs *buf,
 		       gfp_t flags);
 
 #endif
-- 
2.38.1


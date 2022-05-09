Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D241B51FE62
	for <lists+linux-crypto@lfdr.de>; Mon,  9 May 2022 15:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbiEINj3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 9 May 2022 09:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbiEINj2 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 9 May 2022 09:39:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0746F24D627;
        Mon,  9 May 2022 06:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652103334; x=1683639334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EJ6HHrpFB11GVC5lvl1GeFBeW68IUfXgN3vSuG6XFJg=;
  b=LbHr/V1nRQ20Q4+v9WnDH8BcmiMcGuplo1brWYSkAR+vQzAMbt8XgWmz
   /4/TPaljM411PCbFRWXhBxBbnIjP5Y8G8kXtyuYVsC0uzHxrRlKpL9z/A
   l9SIdE94YIPVEY/KttClp8etgPmI+BKeCe45XYRX+eY3otJ4NOTpQwq9G
   vQ2rh50b4C4pdSOPAAeYmCHEG0s0zPCldBLXW4kYe6TFDNA56y3PABQY0
   vwXw+R9VlAwO7JSfkIAiDHfdoXyaCG2zKKqSH62XNtsSUkfVPpIve8J1X
   YN22ARVe9pWtH1Xz5lNO8ia6U2Vp1MtUU19xopRRQ/01oT3ylRWtodfY0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="248952332"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="248952332"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 06:34:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="622967265"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.76])
  by fmsmga008.fm.intel.com with ESMTP; 09 May 2022 06:34:32 -0700
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Vlad Dronov <vdronov@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        stable@vger.kernel.org, Marco Chiappero <marco.chiappero@intel.com>
Subject: [PATCH v3 02/10] crypto: qat - refactor submission logic
Date:   Mon,  9 May 2022 14:34:09 +0100
Message-Id: <20220509133417.56043-3-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220509133417.56043-1-giovanni.cabiddu@intel.com>
References: <20220509133417.56043-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

All the algorithms in qat_algs.c and qat_asym_algs.c use the same
pattern to submit messages to the HW queues. Move the submission loop
to a new function, qat_alg_send_message(), and share it between the
symmetric and the asymmetric algorithms.

As part of this rework, since the number of retries before returning an
error is inconsistent between the symmetric and asymmetric
implementations, set it to a value that works for both (i.e. 20, was 10
in qat_algs.c and 100 in qat_asym_algs.c)

In addition fix the return code reported when the HW queues are full.
In that case return -ENOSPC instead of -EBUSY.

Including stable in CC since (1) the error code returned if the HW queues
are full is incorrect and (2) to facilitate the backport of the next fix
"crypto: qat - add backlog mechanism".

Cc: stable@vger.kernel.org
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Marco Chiappero <marco.chiappero@intel.com>
---
 drivers/crypto/qat/qat_common/Makefile        |  1 +
 drivers/crypto/qat/qat_common/qat_algs.c      | 68 +++++++++----------
 drivers/crypto/qat/qat_common/qat_algs_send.c | 21 ++++++
 drivers/crypto/qat/qat_common/qat_algs_send.h | 10 +++
 drivers/crypto/qat/qat_common/qat_asym_algs.c | 50 +++++++++-----
 drivers/crypto/qat/qat_common/qat_crypto.h    |  5 ++
 6 files changed, 101 insertions(+), 54 deletions(-)
 create mode 100644 drivers/crypto/qat/qat_common/qat_algs_send.c
 create mode 100644 drivers/crypto/qat/qat_common/qat_algs_send.h

diff --git a/drivers/crypto/qat/qat_common/Makefile b/drivers/crypto/qat/qat_common/Makefile
index f25a6c8edfc7..04f058acc4d3 100644
--- a/drivers/crypto/qat/qat_common/Makefile
+++ b/drivers/crypto/qat/qat_common/Makefile
@@ -16,6 +16,7 @@ intel_qat-objs := adf_cfg.o \
 	qat_crypto.o \
 	qat_algs.o \
 	qat_asym_algs.o \
+	qat_algs_send.o \
 	qat_uclo.o \
 	qat_hal.o
 
diff --git a/drivers/crypto/qat/qat_common/qat_algs.c b/drivers/crypto/qat/qat_common/qat_algs.c
index ec635fe44c1f..6017ae82c713 100644
--- a/drivers/crypto/qat/qat_common/qat_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_algs.c
@@ -17,7 +17,7 @@
 #include <crypto/xts.h>
 #include <linux/dma-mapping.h>
 #include "adf_accel_devices.h"
-#include "adf_transport.h"
+#include "qat_algs_send.h"
 #include "adf_common_drv.h"
 #include "qat_crypto.h"
 #include "icp_qat_hw.h"
@@ -939,6 +939,17 @@ void qat_alg_callback(void *resp)
 	qat_req->cb(qat_resp, qat_req);
 }
 
+static int qat_alg_send_sym_message(struct qat_crypto_request *qat_req,
+				    struct qat_crypto_instance *inst)
+{
+	struct qat_alg_req req;
+
+	req.fw_req = (u32 *)&qat_req->req;
+	req.tx_ring = inst->sym_tx;
+
+	return qat_alg_send_message(&req);
+}
+
 static int qat_alg_aead_dec(struct aead_request *areq)
 {
 	struct crypto_aead *aead_tfm = crypto_aead_reqtfm(areq);
@@ -949,7 +960,7 @@ static int qat_alg_aead_dec(struct aead_request *areq)
 	struct icp_qat_fw_la_auth_req_params *auth_param;
 	struct icp_qat_fw_la_bulk_req *msg;
 	int digst_size = crypto_aead_authsize(aead_tfm);
-	int ret, ctr = 0;
+	int ret;
 	u32 cipher_len;
 
 	cipher_len = areq->cryptlen - digst_size;
@@ -975,15 +986,12 @@ static int qat_alg_aead_dec(struct aead_request *areq)
 	auth_param = (void *)((u8 *)cipher_param + sizeof(*cipher_param));
 	auth_param->auth_off = 0;
 	auth_param->auth_len = areq->assoclen + cipher_param->cipher_length;
-	do {
-		ret = adf_send_message(ctx->inst->sym_tx, (u32 *)msg);
-	} while (ret == -EAGAIN && ctr++ < 10);
 
-	if (ret == -EAGAIN) {
+	ret = qat_alg_send_sym_message(qat_req, ctx->inst);
+	if (ret == -ENOSPC)
 		qat_alg_free_bufl(ctx->inst, qat_req);
-		return -EBUSY;
-	}
-	return -EINPROGRESS;
+
+	return ret;
 }
 
 static int qat_alg_aead_enc(struct aead_request *areq)
@@ -996,7 +1004,7 @@ static int qat_alg_aead_enc(struct aead_request *areq)
 	struct icp_qat_fw_la_auth_req_params *auth_param;
 	struct icp_qat_fw_la_bulk_req *msg;
 	u8 *iv = areq->iv;
-	int ret, ctr = 0;
+	int ret;
 
 	if (areq->cryptlen % AES_BLOCK_SIZE != 0)
 		return -EINVAL;
@@ -1023,15 +1031,11 @@ static int qat_alg_aead_enc(struct aead_request *areq)
 	auth_param->auth_off = 0;
 	auth_param->auth_len = areq->assoclen + areq->cryptlen;
 
-	do {
-		ret = adf_send_message(ctx->inst->sym_tx, (u32 *)msg);
-	} while (ret == -EAGAIN && ctr++ < 10);
-
-	if (ret == -EAGAIN) {
+	ret = qat_alg_send_sym_message(qat_req, ctx->inst);
+	if (ret == -ENOSPC)
 		qat_alg_free_bufl(ctx->inst, qat_req);
-		return -EBUSY;
-	}
-	return -EINPROGRESS;
+
+	return ret;
 }
 
 static int qat_alg_skcipher_rekey(struct qat_alg_skcipher_ctx *ctx,
@@ -1184,7 +1188,7 @@ static int qat_alg_skcipher_encrypt(struct skcipher_request *req)
 	struct qat_crypto_request *qat_req = skcipher_request_ctx(req);
 	struct icp_qat_fw_la_cipher_req_params *cipher_param;
 	struct icp_qat_fw_la_bulk_req *msg;
-	int ret, ctr = 0;
+	int ret;
 
 	if (req->cryptlen == 0)
 		return 0;
@@ -1208,15 +1212,11 @@ static int qat_alg_skcipher_encrypt(struct skcipher_request *req)
 
 	qat_alg_set_req_iv(qat_req);
 
-	do {
-		ret = adf_send_message(ctx->inst->sym_tx, (u32 *)msg);
-	} while (ret == -EAGAIN && ctr++ < 10);
-
-	if (ret == -EAGAIN) {
+	ret = qat_alg_send_sym_message(qat_req, ctx->inst);
+	if (ret == -ENOSPC)
 		qat_alg_free_bufl(ctx->inst, qat_req);
-		return -EBUSY;
-	}
-	return -EINPROGRESS;
+
+	return ret;
 }
 
 static int qat_alg_skcipher_blk_encrypt(struct skcipher_request *req)
@@ -1253,7 +1253,7 @@ static int qat_alg_skcipher_decrypt(struct skcipher_request *req)
 	struct qat_crypto_request *qat_req = skcipher_request_ctx(req);
 	struct icp_qat_fw_la_cipher_req_params *cipher_param;
 	struct icp_qat_fw_la_bulk_req *msg;
-	int ret, ctr = 0;
+	int ret;
 
 	if (req->cryptlen == 0)
 		return 0;
@@ -1278,15 +1278,11 @@ static int qat_alg_skcipher_decrypt(struct skcipher_request *req)
 	qat_alg_set_req_iv(qat_req);
 	qat_alg_update_iv(qat_req);
 
-	do {
-		ret = adf_send_message(ctx->inst->sym_tx, (u32 *)msg);
-	} while (ret == -EAGAIN && ctr++ < 10);
-
-	if (ret == -EAGAIN) {
+	ret = qat_alg_send_sym_message(qat_req, ctx->inst);
+	if (ret == -ENOSPC)
 		qat_alg_free_bufl(ctx->inst, qat_req);
-		return -EBUSY;
-	}
-	return -EINPROGRESS;
+
+	return ret;
 }
 
 static int qat_alg_skcipher_blk_decrypt(struct skcipher_request *req)
diff --git a/drivers/crypto/qat/qat_common/qat_algs_send.c b/drivers/crypto/qat/qat_common/qat_algs_send.c
new file mode 100644
index 000000000000..78f1bb8c26c0
--- /dev/null
+++ b/drivers/crypto/qat/qat_common/qat_algs_send.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2022 Intel Corporation */
+#include "adf_transport.h"
+#include "qat_algs_send.h"
+#include "qat_crypto.h"
+
+#define ADF_MAX_RETRIES		20
+
+int qat_alg_send_message(struct qat_alg_req *req)
+{
+	int ret = 0, ctr = 0;
+
+	do {
+		ret = adf_send_message(req->tx_ring, req->fw_req);
+	} while (ret == -EAGAIN && ctr++ < ADF_MAX_RETRIES);
+
+	if (ret == -EAGAIN)
+		return -ENOSPC;
+
+	return -EINPROGRESS;
+}
diff --git a/drivers/crypto/qat/qat_common/qat_algs_send.h b/drivers/crypto/qat/qat_common/qat_algs_send.h
new file mode 100644
index 000000000000..3fa685d0c293
--- /dev/null
+++ b/drivers/crypto/qat/qat_common/qat_algs_send.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2022 Intel Corporation */
+#ifndef QAT_ALGS_SEND_H
+#define QAT_ALGS_SEND_H
+
+#include "qat_crypto.h"
+
+int qat_alg_send_message(struct qat_alg_req *req);
+
+#endif
diff --git a/drivers/crypto/qat/qat_common/qat_asym_algs.c b/drivers/crypto/qat/qat_common/qat_asym_algs.c
index b0b78445418b..a3fdbcc08772 100644
--- a/drivers/crypto/qat/qat_common/qat_asym_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_asym_algs.c
@@ -12,6 +12,7 @@
 #include <crypto/scatterwalk.h>
 #include "icp_qat_fw_pke.h"
 #include "adf_accel_devices.h"
+#include "qat_algs_send.h"
 #include "adf_transport.h"
 #include "adf_common_drv.h"
 #include "qat_crypto.h"
@@ -137,6 +138,17 @@ struct qat_asym_request {
 	void (*cb)(struct icp_qat_fw_pke_resp *resp);
 } __aligned(64);
 
+static int qat_alg_send_asym_message(struct qat_asym_request *qat_req,
+				     struct qat_crypto_instance *inst)
+{
+	struct qat_alg_req req;
+
+	req.fw_req = (u32 *)&qat_req->req;
+	req.tx_ring = inst->pke_tx;
+
+	return qat_alg_send_message(&req);
+}
+
 static void qat_dh_cb(struct icp_qat_fw_pke_resp *resp)
 {
 	struct qat_asym_request *req = (void *)(__force long)resp->opaque;
@@ -213,7 +225,7 @@ static int qat_dh_compute_value(struct kpp_request *req)
 	struct qat_asym_request *qat_req =
 			PTR_ALIGN(kpp_request_ctx(req), 64);
 	struct icp_qat_fw_pke_request *msg = &qat_req->req;
-	int ret, ctr = 0;
+	int ret;
 	int n_input_params = 0;
 
 	if (unlikely(!ctx->xa))
@@ -338,13 +350,13 @@ static int qat_dh_compute_value(struct kpp_request *req)
 	msg->input_param_count = n_input_params;
 	msg->output_param_count = 1;
 
-	do {
-		ret = adf_send_message(ctx->inst->pke_tx, (u32 *)msg);
-	} while (ret == -EBUSY && ctr++ < 100);
+	ret = qat_alg_send_asym_message(qat_req, ctx->inst);
+	if (ret == -ENOSPC)
+		goto unmap_all;
 
-	if (!ret)
-		return -EINPROGRESS;
+	return ret;
 
+unmap_all:
 	if (!dma_mapping_error(dev, qat_req->phy_out))
 		dma_unmap_single(dev, qat_req->phy_out,
 				 sizeof(struct qat_dh_output_params),
@@ -642,7 +654,7 @@ static int qat_rsa_enc(struct akcipher_request *req)
 	struct qat_asym_request *qat_req =
 			PTR_ALIGN(akcipher_request_ctx(req), 64);
 	struct icp_qat_fw_pke_request *msg = &qat_req->req;
-	int ret, ctr = 0;
+	int ret;
 
 	if (unlikely(!ctx->n || !ctx->e))
 		return -EINVAL;
@@ -732,13 +744,14 @@ static int qat_rsa_enc(struct akcipher_request *req)
 	msg->pke_mid.opaque = (u64)(__force long)qat_req;
 	msg->input_param_count = 3;
 	msg->output_param_count = 1;
-	do {
-		ret = adf_send_message(ctx->inst->pke_tx, (u32 *)msg);
-	} while (ret == -EBUSY && ctr++ < 100);
 
-	if (!ret)
-		return -EINPROGRESS;
+	ret = qat_alg_send_asym_message(qat_req, ctx->inst);
+	if (ret == -ENOSPC)
+		goto unmap_all;
+
+	return ret;
 
+unmap_all:
 	if (!dma_mapping_error(dev, qat_req->phy_out))
 		dma_unmap_single(dev, qat_req->phy_out,
 				 sizeof(struct qat_rsa_output_params),
@@ -776,7 +789,7 @@ static int qat_rsa_dec(struct akcipher_request *req)
 	struct qat_asym_request *qat_req =
 			PTR_ALIGN(akcipher_request_ctx(req), 64);
 	struct icp_qat_fw_pke_request *msg = &qat_req->req;
-	int ret, ctr = 0;
+	int ret;
 
 	if (unlikely(!ctx->n || !ctx->d))
 		return -EINVAL;
@@ -884,13 +897,14 @@ static int qat_rsa_dec(struct akcipher_request *req)
 		msg->input_param_count = 3;
 
 	msg->output_param_count = 1;
-	do {
-		ret = adf_send_message(ctx->inst->pke_tx, (u32 *)msg);
-	} while (ret == -EBUSY && ctr++ < 100);
 
-	if (!ret)
-		return -EINPROGRESS;
+	ret = qat_alg_send_asym_message(qat_req, ctx->inst);
+	if (ret == -ENOSPC)
+		goto unmap_all;
+
+	return ret;
 
+unmap_all:
 	if (!dma_mapping_error(dev, qat_req->phy_out))
 		dma_unmap_single(dev, qat_req->phy_out,
 				 sizeof(struct qat_rsa_output_params),
diff --git a/drivers/crypto/qat/qat_common/qat_crypto.h b/drivers/crypto/qat/qat_common/qat_crypto.h
index 0928f159ea99..0dcba6fc358c 100644
--- a/drivers/crypto/qat/qat_common/qat_crypto.h
+++ b/drivers/crypto/qat/qat_common/qat_crypto.h
@@ -9,6 +9,11 @@
 #include "adf_accel_devices.h"
 #include "icp_qat_fw_la.h"
 
+struct qat_alg_req {
+	u32 *fw_req;
+	struct adf_etr_ring_data *tx_ring;
+};
+
 struct qat_crypto_instance {
 	struct adf_etr_ring_data *sym_tx;
 	struct adf_etr_ring_data *sym_rx;
-- 
2.35.1


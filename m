Return-Path: <linux-crypto+bounces-12533-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C668AA4A34
	for <lists+linux-crypto@lfdr.de>; Wed, 30 Apr 2025 13:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4088A1C081D3
	for <lists+linux-crypto@lfdr.de>; Wed, 30 Apr 2025 11:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1083325A358;
	Wed, 30 Apr 2025 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLVL06SN"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFEC238171
	for <linux-crypto@vger.kernel.org>; Wed, 30 Apr 2025 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746012908; cv=none; b=jH/BPpUUbflHHg3Oq0OCZXVgMkUU7Nqy4BFXw1vtXQGGS0v7etui4q48VaAZRFiFHd6b/USzKs572Mtru+Kf1gmgoES675QFYghpYV05CT9FCh9SEBvxoNCHpY1t1K/jJltiAQwf8iy9HkE0XU7P9pV3x9N3IPj26mCP6/8P75Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746012908; c=relaxed/simple;
	bh=eHFfbwXaoZJfVQSAzSXWd4F0jAzqzlPAg9fsMUZRWJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XcBNUPf/FOSvEa61/D/8ANiu2q/OypW7E+K6oBKHj5uNsW+RJ0UM1LbcAMGLmqRlXxBAmyz2LSp6VuN/+Dwk29bHaWkylzHMoqASZU86kDzWEvXy9biMbasnSt6ks1k+yI1MLi7PsWNef0oQg3dETQRatFUEv6ISYMldXM2ZPbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLVL06SN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746012906; x=1777548906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eHFfbwXaoZJfVQSAzSXWd4F0jAzqzlPAg9fsMUZRWJQ=;
  b=JLVL06SNo8UHixQd8jmhIEVl8yF7e13lcv/Vu7O5cq3KzMm/XOamTvs5
   gVVp35bFqL9WQErsdbGvxg3GXKvcpnp53QTN+ptepv6xk9b+Hv3z8Jg3g
   GSJxIZUh+CbVUzRVFATfdlS75Qkc+p6ZOK8+rxhM0fw8BUW1DpF5YtCHh
   n/5V1zusMOggl71Ds4z0cZiwNoM+dgWgcmZGKqK4GVecuhuPxpYXz2L8g
   qwx5Xj+nahL8YmcEJ1xrulkcEh3eiWShI1CqQe/+L4CGtHpQglgfJKsuW
   1/uyvfeVPUEIC+RJjcl1otvk7ZhPuPHWhOb3rcZB+D4OzI74wrLD1Jtws
   g==;
X-CSE-ConnectionGUID: HU4/6T7zRKyy2pMaaJTIEQ==
X-CSE-MsgGUID: 72ucgNfxSkqcHp319/1J8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="51331135"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="51331135"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 04:35:06 -0700
X-CSE-ConnectionGUID: N0pqXoOOR2eQQ2eDoP9W5A==
X-CSE-MsgGUID: chpXIlVaSt+3GPjF875BIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="133812524"
Received: from t21-qat.iind.intel.com ([10.49.15.35])
  by orviesa009.jf.intel.com with ESMTP; 30 Apr 2025 04:35:04 -0700
From: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
To: herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org,
	qat-linux@intel.com
Subject: [PATCH 02/11] crypto: qat - refactor compression template logic
Date: Wed, 30 Apr 2025 12:34:44 +0100
Message-Id: <20250430113453.1587497-3-suman.kumar.chakraborty@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250430113453.1587497-1-suman.kumar.chakraborty@intel.com>
References: <20250430113453.1587497-1-suman.kumar.chakraborty@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic that generates the compression templates, which are used by to
submit compression requests to the QAT device, is very similar between
QAT devices and diverges mainly on the HW generation-specific
configuration word.

This makes the logic that generates the compression and decompression
templates common between GEN2 and GEN4 devices and abstracts the
generation-specific logic to the generation-specific implementations.

The adf_gen2_dc.c and adf_gen4_dc.c have been replaced by adf_dc.c, and
the generation-specific logic has been reduced and moved to
adf_gen2_hw_data.c and adf_gen4_hw_data.c.

This does not introduce any functional change.

Co-developed-by: Vijay Sundar Selvamani <vijay.sundar.selvamani@intel.com>
Signed-off-by: Vijay Sundar Selvamani <vijay.sundar.selvamani@intel.com>
Signed-off-by: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../intel/qat/qat_420xx/adf_420xx_hw_data.c   |  1 -
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     |  1 -
 .../intel/qat/qat_c3xxx/adf_c3xxx_hw_data.c   |  1 -
 .../qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c     |  1 -
 .../intel/qat/qat_c62x/adf_c62x_hw_data.c     |  1 -
 .../intel/qat/qat_c62xvf/adf_c62xvf_hw_data.c |  1 -
 drivers/crypto/intel/qat/qat_common/Makefile  |  3 +-
 .../intel/qat/qat_common/adf_accel_devices.h  |  4 +-
 .../qat_common/{adf_gen2_dc.c => adf_dc.c}    | 47 +++++------
 drivers/crypto/intel/qat/qat_common/adf_dc.h  | 17 ++++
 .../crypto/intel/qat/qat_common/adf_gen2_dc.h | 10 ---
 .../intel/qat/qat_common/adf_gen2_hw_data.c   | 57 +++++++++++++
 .../intel/qat/qat_common/adf_gen2_hw_data.h   |  1 +
 .../crypto/intel/qat/qat_common/adf_gen4_dc.c | 83 -------------------
 .../crypto/intel/qat/qat_common/adf_gen4_dc.h | 10 ---
 .../intel/qat/qat_common/adf_gen4_hw_data.c   | 70 ++++++++++++++++
 .../intel/qat/qat_common/adf_gen4_hw_data.h   |  2 +
 .../intel/qat/qat_common/qat_comp_algs.c      |  5 +-
 .../intel/qat/qat_common/qat_compression.c    |  1 -
 .../intel/qat/qat_common/qat_compression.h    |  1 -
 .../qat/qat_dh895xcc/adf_dh895xcc_hw_data.c   |  1 -
 .../qat_dh895xccvf/adf_dh895xccvf_hw_data.c   |  1 -
 22 files changed, 173 insertions(+), 146 deletions(-)
 rename drivers/crypto/intel/qat/qat_common/{adf_gen2_dc.c => adf_dc.c} (61%)
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_dc.h
 delete mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen2_dc.h
 delete mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen4_dc.c
 delete mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen4_dc.h

diff --git a/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
index 5817b3164185..7c3c0f561c95 100644
--- a/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
@@ -9,7 +9,6 @@
 #include <adf_common_drv.h>
 #include <adf_fw_config.h>
 #include <adf_gen4_config.h>
-#include <adf_gen4_dc.h>
 #include <adf_gen4_hw_csr_data.h>
 #include <adf_gen4_hw_data.h>
 #include <adf_gen4_pfvf.h>
diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
index 2d89d4a3a7b9..bd0b1b1015c0 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -9,7 +9,6 @@
 #include <adf_common_drv.h>
 #include <adf_fw_config.h>
 #include <adf_gen4_config.h>
-#include <adf_gen4_dc.h>
 #include <adf_gen4_hw_csr_data.h>
 #include <adf_gen4_hw_data.h>
 #include <adf_gen4_pfvf.h>
diff --git a/drivers/crypto/intel/qat/qat_c3xxx/adf_c3xxx_hw_data.c b/drivers/crypto/intel/qat/qat_c3xxx/adf_c3xxx_hw_data.c
index 9425af26d34c..07f2c42a68f5 100644
--- a/drivers/crypto/intel/qat/qat_c3xxx/adf_c3xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_c3xxx/adf_c3xxx_hw_data.c
@@ -5,7 +5,6 @@
 #include <adf_clock.h>
 #include <adf_common_drv.h>
 #include <adf_gen2_config.h>
-#include <adf_gen2_dc.h>
 #include <adf_gen2_hw_csr_data.h>
 #include <adf_gen2_hw_data.h>
 #include <adf_gen2_pfvf.h>
diff --git a/drivers/crypto/intel/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c b/drivers/crypto/intel/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c
index f73d9a4a9ab7..db3c33fa1881 100644
--- a/drivers/crypto/intel/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c
@@ -3,7 +3,6 @@
 #include <adf_accel_devices.h>
 #include <adf_common_drv.h>
 #include <adf_gen2_config.h>
-#include <adf_gen2_dc.h>
 #include <adf_gen2_hw_csr_data.h>
 #include <adf_gen2_hw_data.h>
 #include <adf_gen2_pfvf.h>
diff --git a/drivers/crypto/intel/qat/qat_c62x/adf_c62x_hw_data.c b/drivers/crypto/intel/qat/qat_c62x/adf_c62x_hw_data.c
index 1a2f36b603fb..0b410b41474d 100644
--- a/drivers/crypto/intel/qat/qat_c62x/adf_c62x_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_c62x/adf_c62x_hw_data.c
@@ -5,7 +5,6 @@
 #include <adf_clock.h>
 #include <adf_common_drv.h>
 #include <adf_gen2_config.h>
-#include <adf_gen2_dc.h>
 #include <adf_gen2_hw_csr_data.h>
 #include <adf_gen2_hw_data.h>
 #include <adf_gen2_pfvf.h>
diff --git a/drivers/crypto/intel/qat/qat_c62xvf/adf_c62xvf_hw_data.c b/drivers/crypto/intel/qat/qat_c62xvf/adf_c62xvf_hw_data.c
index 29e53b41a895..7f00035d3661 100644
--- a/drivers/crypto/intel/qat/qat_c62xvf/adf_c62xvf_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_c62xvf/adf_c62xvf_hw_data.c
@@ -3,7 +3,6 @@
 #include <adf_accel_devices.h>
 #include <adf_common_drv.h>
 #include <adf_gen2_config.h>
-#include <adf_gen2_dc.h>
 #include <adf_gen2_hw_csr_data.h>
 #include <adf_gen2_hw_data.h>
 #include <adf_gen2_pfvf.h>
diff --git a/drivers/crypto/intel/qat/qat_common/Makefile b/drivers/crypto/intel/qat/qat_common/Makefile
index 0370eaad42b1..0a9da7398a78 100644
--- a/drivers/crypto/intel/qat/qat_common/Makefile
+++ b/drivers/crypto/intel/qat/qat_common/Makefile
@@ -8,13 +8,12 @@ intel_qat-y := adf_accel_engine.o \
 	adf_cfg_services.o \
 	adf_clock.o \
 	adf_ctl_drv.o \
+	adf_dc.o \
 	adf_dev_mgr.o \
 	adf_gen2_config.o \
-	adf_gen2_dc.o \
 	adf_gen2_hw_csr_data.o \
 	adf_gen2_hw_data.o \
 	adf_gen4_config.o \
-	adf_gen4_dc.o \
 	adf_gen4_hw_csr_data.o \
 	adf_gen4_hw_data.o \
 	adf_gen4_pm.o \
diff --git a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
index 1e301a20c244..a39f506322f6 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
@@ -12,6 +12,7 @@
 #include <linux/qat/qat_mig_dev.h>
 #include <linux/wordpart.h>
 #include "adf_cfg_common.h"
+#include "adf_dc.h"
 #include "adf_rl.h"
 #include "adf_telemetry.h"
 #include "adf_pfvf_msg.h"
@@ -267,7 +268,8 @@ struct adf_pfvf_ops {
 };
 
 struct adf_dc_ops {
-	void (*build_deflate_ctx)(void *ctx);
+	int (*build_comp_block)(void *ctx, enum adf_dc_algo algo);
+	int (*build_decomp_block)(void *ctx, enum adf_dc_algo algo);
 };
 
 struct qat_migdev_ops {
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen2_dc.c b/drivers/crypto/intel/qat/qat_common/adf_dc.c
similarity index 61%
rename from drivers/crypto/intel/qat/qat_common/adf_gen2_dc.c
rename to drivers/crypto/intel/qat/qat_common/adf_dc.c
index 47261b1c1da6..4beb4b7dbf0e 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen2_dc.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_dc.c
@@ -1,22 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2022 Intel Corporation */
 #include "adf_accel_devices.h"
-#include "adf_gen2_dc.h"
+#include "adf_dc.h"
 #include "icp_qat_fw_comp.h"
 
-static void qat_comp_build_deflate_ctx(void *ctx)
+int qat_comp_build_ctx(struct adf_accel_dev *accel_dev, void *ctx, enum adf_dc_algo algo)
 {
-	struct icp_qat_fw_comp_req *req_tmpl = (struct icp_qat_fw_comp_req *)ctx;
-	struct icp_qat_fw_comn_req_hdr *header = &req_tmpl->comn_hdr;
-	struct icp_qat_fw_comp_req_hdr_cd_pars *cd_pars = &req_tmpl->cd_pars;
-	struct icp_qat_fw_comp_req_params *req_pars = &req_tmpl->comp_pars;
+	struct icp_qat_fw_comp_req *req_tmpl = ctx;
 	struct icp_qat_fw_comp_cd_hdr *comp_cd_ctrl = &req_tmpl->comp_cd_ctrl;
+	struct icp_qat_fw_comp_req_params *req_pars = &req_tmpl->comp_pars;
+	struct icp_qat_fw_comn_req_hdr *header = &req_tmpl->comn_hdr;
+	int ret;
 
 	memset(req_tmpl, 0, sizeof(*req_tmpl));
 	header->hdr_flags =
 		ICP_QAT_FW_COMN_HDR_FLAGS_BUILD(ICP_QAT_FW_COMN_REQ_FLAG_SET);
 	header->service_type = ICP_QAT_FW_COMN_REQ_CPM_FW_COMP;
-	header->service_cmd_id = ICP_QAT_FW_COMP_CMD_STATIC;
 	header->comn_req_flags =
 		ICP_QAT_FW_COMN_FLAGS_BUILD(QAT_COMN_CD_FLD_TYPE_16BYTE_DATA,
 					    QAT_COMN_PTR_TYPE_SGL);
@@ -26,12 +25,14 @@ static void qat_comp_build_deflate_ctx(void *ctx)
 					    ICP_QAT_FW_COMP_NOT_ENH_AUTO_SELECT_BEST,
 					    ICP_QAT_FW_COMP_NOT_DISABLE_TYPE0_ENH_AUTO_SELECT_BEST,
 					    ICP_QAT_FW_COMP_ENABLE_SECURE_RAM_USED_AS_INTMD_BUF);
-	cd_pars->u.sl.comp_slice_cfg_word[0] =
-		ICP_QAT_HW_COMPRESSION_CONFIG_BUILD(ICP_QAT_HW_COMPRESSION_DIR_COMPRESS,
-						    ICP_QAT_HW_COMPRESSION_DELAYED_MATCH_DISABLED,
-						    ICP_QAT_HW_COMPRESSION_ALGO_DEFLATE,
-						    ICP_QAT_HW_COMPRESSION_DEPTH_1,
-						    ICP_QAT_HW_COMPRESSION_FILE_TYPE_0);
+
+	/* Build HW config block for compression */
+	ret = GET_DC_OPS(accel_dev)->build_comp_block(ctx, algo);
+	if (ret) {
+		dev_err(&GET_DEV(accel_dev), "Failed to build compression block\n");
+		return ret;
+	}
+
 	req_pars->crc.legacy.initial_adler = COMP_CPR_INITIAL_ADLER;
 	req_pars->crc.legacy.initial_crc32 = COMP_CPR_INITIAL_CRC;
 	req_pars->req_par_flags =
@@ -52,19 +53,11 @@ static void qat_comp_build_deflate_ctx(void *ctx)
 	/* Fill second half of the template for decompression */
 	memcpy(req_tmpl + 1, req_tmpl, sizeof(*req_tmpl));
 	req_tmpl++;
-	header = &req_tmpl->comn_hdr;
-	header->service_cmd_id = ICP_QAT_FW_COMP_CMD_DECOMPRESS;
-	cd_pars = &req_tmpl->cd_pars;
-	cd_pars->u.sl.comp_slice_cfg_word[0] =
-		ICP_QAT_HW_COMPRESSION_CONFIG_BUILD(ICP_QAT_HW_COMPRESSION_DIR_DECOMPRESS,
-						    ICP_QAT_HW_COMPRESSION_DELAYED_MATCH_DISABLED,
-						    ICP_QAT_HW_COMPRESSION_ALGO_DEFLATE,
-						    ICP_QAT_HW_COMPRESSION_DEPTH_1,
-						    ICP_QAT_HW_COMPRESSION_FILE_TYPE_0);
-}
 
-void adf_gen2_init_dc_ops(struct adf_dc_ops *dc_ops)
-{
-	dc_ops->build_deflate_ctx = qat_comp_build_deflate_ctx;
+	/* Build HW config block for decompression */
+	ret = GET_DC_OPS(accel_dev)->build_decomp_block(req_tmpl, algo);
+	if (ret)
+		dev_err(&GET_DEV(accel_dev), "Failed to build decompression block\n");
+
+	return ret;
 }
-EXPORT_SYMBOL_GPL(adf_gen2_init_dc_ops);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_dc.h b/drivers/crypto/intel/qat/qat_common/adf_dc.h
new file mode 100644
index 000000000000..6cb5e09054a6
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_dc.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2025 Intel Corporation */
+#ifndef ADF_DC_H
+#define ADF_DC_H
+
+struct adf_accel_dev;
+
+enum adf_dc_algo {
+	QAT_DEFLATE,
+	QAT_LZ4,
+	QAT_LZ4S,
+	QAT_ZSTD,
+};
+
+int qat_comp_build_ctx(struct adf_accel_dev *accel_dev, void *ctx, enum adf_dc_algo algo);
+
+#endif /* ADF_DC_H */
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen2_dc.h b/drivers/crypto/intel/qat/qat_common/adf_gen2_dc.h
deleted file mode 100644
index 6eae023354d7..000000000000
--- a/drivers/crypto/intel/qat/qat_common/adf_gen2_dc.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/* Copyright(c) 2022 Intel Corporation */
-#ifndef ADF_GEN2_DC_H
-#define ADF_GEN2_DC_H
-
-#include "adf_accel_devices.h"
-
-void adf_gen2_init_dc_ops(struct adf_dc_ops *dc_ops);
-
-#endif /* ADF_GEN2_DC_H */
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen2_hw_data.c b/drivers/crypto/intel/qat/qat_common/adf_gen2_hw_data.c
index 2b263442c856..6a505e9a5cf9 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen2_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen2_hw_data.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
 /* Copyright(c) 2020 Intel Corporation */
 #include "adf_common_drv.h"
+#include "adf_dc.h"
 #include "adf_gen2_hw_data.h"
+#include "icp_qat_fw_comp.h"
 #include "icp_qat_hw.h"
 #include <linux/pci.h>
 
@@ -169,3 +171,58 @@ void adf_gen2_set_ssm_wdtimer(struct adf_accel_dev *accel_dev)
 	}
 }
 EXPORT_SYMBOL_GPL(adf_gen2_set_ssm_wdtimer);
+
+static int adf_gen2_build_comp_block(void *ctx, enum adf_dc_algo algo)
+{
+	struct icp_qat_fw_comp_req *req_tmpl = ctx;
+	struct icp_qat_fw_comp_req_hdr_cd_pars *cd_pars = &req_tmpl->cd_pars;
+	struct icp_qat_fw_comn_req_hdr *header = &req_tmpl->comn_hdr;
+
+	switch (algo) {
+	case QAT_DEFLATE:
+		header->service_cmd_id = ICP_QAT_FW_COMP_CMD_STATIC;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	cd_pars->u.sl.comp_slice_cfg_word[0] =
+		ICP_QAT_HW_COMPRESSION_CONFIG_BUILD(ICP_QAT_HW_COMPRESSION_DIR_COMPRESS,
+						    ICP_QAT_HW_COMPRESSION_DELAYED_MATCH_DISABLED,
+						    ICP_QAT_HW_COMPRESSION_ALGO_DEFLATE,
+						    ICP_QAT_HW_COMPRESSION_DEPTH_1,
+						    ICP_QAT_HW_COMPRESSION_FILE_TYPE_0);
+
+	return 0;
+}
+
+static int adf_gen2_build_decomp_block(void *ctx, enum adf_dc_algo algo)
+{
+	struct icp_qat_fw_comp_req *req_tmpl = ctx;
+	struct icp_qat_fw_comp_req_hdr_cd_pars *cd_pars = &req_tmpl->cd_pars;
+	struct icp_qat_fw_comn_req_hdr *header = &req_tmpl->comn_hdr;
+
+	switch (algo) {
+	case QAT_DEFLATE:
+		header->service_cmd_id = ICP_QAT_FW_COMP_CMD_DECOMPRESS;
+	break;
+	default:
+		return -EINVAL;
+	}
+
+	cd_pars->u.sl.comp_slice_cfg_word[0] =
+		ICP_QAT_HW_COMPRESSION_CONFIG_BUILD(ICP_QAT_HW_COMPRESSION_DIR_DECOMPRESS,
+						    ICP_QAT_HW_COMPRESSION_DELAYED_MATCH_DISABLED,
+						    ICP_QAT_HW_COMPRESSION_ALGO_DEFLATE,
+						    ICP_QAT_HW_COMPRESSION_DEPTH_1,
+						    ICP_QAT_HW_COMPRESSION_FILE_TYPE_0);
+
+	return 0;
+}
+
+void adf_gen2_init_dc_ops(struct adf_dc_ops *dc_ops)
+{
+	dc_ops->build_comp_block = adf_gen2_build_comp_block;
+	dc_ops->build_decomp_block = adf_gen2_build_decomp_block;
+}
+EXPORT_SYMBOL_GPL(adf_gen2_init_dc_ops);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen2_hw_data.h b/drivers/crypto/intel/qat/qat_common/adf_gen2_hw_data.h
index 708e9186127b..59bad368a921 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen2_hw_data.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen2_hw_data.h
@@ -88,5 +88,6 @@ void adf_gen2_get_arb_info(struct arb_info *arb_info);
 void adf_gen2_enable_ints(struct adf_accel_dev *accel_dev);
 u32 adf_gen2_get_accel_cap(struct adf_accel_dev *accel_dev);
 void adf_gen2_set_ssm_wdtimer(struct adf_accel_dev *accel_dev);
+void adf_gen2_init_dc_ops(struct adf_dc_ops *dc_ops);
 
 #endif
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_dc.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_dc.c
deleted file mode 100644
index 5859238e37de..000000000000
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_dc.c
+++ /dev/null
@@ -1,83 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* Copyright(c) 2022 Intel Corporation */
-#include "adf_accel_devices.h"
-#include "icp_qat_fw_comp.h"
-#include "icp_qat_hw_20_comp.h"
-#include "adf_gen4_dc.h"
-
-static void qat_comp_build_deflate(void *ctx)
-{
-	struct icp_qat_fw_comp_req *req_tmpl =
-				(struct icp_qat_fw_comp_req *)ctx;
-	struct icp_qat_fw_comn_req_hdr *header = &req_tmpl->comn_hdr;
-	struct icp_qat_fw_comp_req_hdr_cd_pars *cd_pars = &req_tmpl->cd_pars;
-	struct icp_qat_fw_comp_req_params *req_pars = &req_tmpl->comp_pars;
-	struct icp_qat_hw_comp_20_config_csr_upper hw_comp_upper_csr = {0};
-	struct icp_qat_hw_comp_20_config_csr_lower hw_comp_lower_csr = {0};
-	struct icp_qat_hw_decomp_20_config_csr_lower hw_decomp_lower_csr = {0};
-	u32 upper_val;
-	u32 lower_val;
-
-	memset(req_tmpl, 0, sizeof(*req_tmpl));
-	header->hdr_flags =
-		ICP_QAT_FW_COMN_HDR_FLAGS_BUILD(ICP_QAT_FW_COMN_REQ_FLAG_SET);
-	header->service_type = ICP_QAT_FW_COMN_REQ_CPM_FW_COMP;
-	header->service_cmd_id = ICP_QAT_FW_COMP_CMD_STATIC;
-	header->comn_req_flags =
-		ICP_QAT_FW_COMN_FLAGS_BUILD(QAT_COMN_CD_FLD_TYPE_16BYTE_DATA,
-					    QAT_COMN_PTR_TYPE_SGL);
-	header->serv_specif_flags =
-		ICP_QAT_FW_COMP_FLAGS_BUILD(ICP_QAT_FW_COMP_STATELESS_SESSION,
-					    ICP_QAT_FW_COMP_AUTO_SELECT_BEST,
-					    ICP_QAT_FW_COMP_NOT_ENH_AUTO_SELECT_BEST,
-					    ICP_QAT_FW_COMP_NOT_DISABLE_TYPE0_ENH_AUTO_SELECT_BEST,
-					    ICP_QAT_FW_COMP_ENABLE_SECURE_RAM_USED_AS_INTMD_BUF);
-	hw_comp_lower_csr.skip_ctrl = ICP_QAT_HW_COMP_20_BYTE_SKIP_3BYTE_LITERAL;
-	hw_comp_lower_csr.algo = ICP_QAT_HW_COMP_20_HW_COMP_FORMAT_ILZ77;
-	hw_comp_lower_csr.lllbd = ICP_QAT_HW_COMP_20_LLLBD_CTRL_LLLBD_ENABLED;
-	hw_comp_lower_csr.sd = ICP_QAT_HW_COMP_20_SEARCH_DEPTH_LEVEL_1;
-	hw_comp_lower_csr.hash_update = ICP_QAT_HW_COMP_20_SKIP_HASH_UPDATE_DONT_ALLOW;
-	hw_comp_lower_csr.edmm = ICP_QAT_HW_COMP_20_EXTENDED_DELAY_MATCH_MODE_EDMM_ENABLED;
-	hw_comp_upper_csr.nice = ICP_QAT_HW_COMP_20_CONFIG_CSR_NICE_PARAM_DEFAULT_VAL;
-	hw_comp_upper_csr.lazy = ICP_QAT_HW_COMP_20_CONFIG_CSR_LAZY_PARAM_DEFAULT_VAL;
-
-	upper_val = ICP_QAT_FW_COMP_20_BUILD_CONFIG_UPPER(hw_comp_upper_csr);
-	lower_val = ICP_QAT_FW_COMP_20_BUILD_CONFIG_LOWER(hw_comp_lower_csr);
-
-	cd_pars->u.sl.comp_slice_cfg_word[0] = lower_val;
-	cd_pars->u.sl.comp_slice_cfg_word[1] = upper_val;
-
-	req_pars->crc.legacy.initial_adler = COMP_CPR_INITIAL_ADLER;
-	req_pars->crc.legacy.initial_crc32 = COMP_CPR_INITIAL_CRC;
-	req_pars->req_par_flags =
-		ICP_QAT_FW_COMP_REQ_PARAM_FLAGS_BUILD(ICP_QAT_FW_COMP_SOP,
-						      ICP_QAT_FW_COMP_EOP,
-						      ICP_QAT_FW_COMP_BFINAL,
-						      ICP_QAT_FW_COMP_CNV,
-						      ICP_QAT_FW_COMP_CNV_RECOVERY,
-						      ICP_QAT_FW_COMP_NO_CNV_DFX,
-						      ICP_QAT_FW_COMP_CRC_MODE_LEGACY,
-						      ICP_QAT_FW_COMP_NO_XXHASH_ACC,
-						      ICP_QAT_FW_COMP_CNV_ERROR_NONE,
-						      ICP_QAT_FW_COMP_NO_APPEND_CRC,
-						      ICP_QAT_FW_COMP_NO_DROP_DATA);
-
-	/* Fill second half of the template for decompression */
-	memcpy(req_tmpl + 1, req_tmpl, sizeof(*req_tmpl));
-	req_tmpl++;
-	header = &req_tmpl->comn_hdr;
-	header->service_cmd_id = ICP_QAT_FW_COMP_CMD_DECOMPRESS;
-	cd_pars = &req_tmpl->cd_pars;
-
-	hw_decomp_lower_csr.algo = ICP_QAT_HW_DECOMP_20_HW_DECOMP_FORMAT_DEFLATE;
-	lower_val = ICP_QAT_FW_DECOMP_20_BUILD_CONFIG_LOWER(hw_decomp_lower_csr);
-
-	cd_pars->u.sl.comp_slice_cfg_word[0] = lower_val;
-	cd_pars->u.sl.comp_slice_cfg_word[1] = 0;
-}
-
-void adf_gen4_init_dc_ops(struct adf_dc_ops *dc_ops)
-{
-	dc_ops->build_deflate_ctx = qat_comp_build_deflate;
-}
-EXPORT_SYMBOL_GPL(adf_gen4_init_dc_ops);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_dc.h b/drivers/crypto/intel/qat/qat_common/adf_gen4_dc.h
deleted file mode 100644
index 0b1a6774412e..000000000000
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_dc.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/* Copyright(c) 2022 Intel Corporation */
-#ifndef ADF_GEN4_DC_H
-#define ADF_GEN4_DC_H
-
-#include "adf_accel_devices.h"
-
-void adf_gen4_init_dc_ops(struct adf_dc_ops *dc_ops);
-
-#endif /* ADF_GEN4_DC_H */
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
index 099949a2421c..0406cb09c5bb 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
@@ -9,6 +9,8 @@
 #include "adf_fw_config.h"
 #include "adf_gen4_hw_data.h"
 #include "adf_gen4_pm.h"
+#include "icp_qat_fw_comp.h"
+#include "icp_qat_hw_20_comp.h"
 
 u32 adf_gen4_get_accel_mask(struct adf_hw_device_data *self)
 {
@@ -663,3 +665,71 @@ int adf_gen4_bank_state_restore(struct adf_accel_dev *accel_dev, u32 bank_number
 	return ret;
 }
 EXPORT_SYMBOL_GPL(adf_gen4_bank_state_restore);
+
+static int adf_gen4_build_comp_block(void *ctx, enum adf_dc_algo algo)
+{
+	struct icp_qat_fw_comp_req *req_tmpl = ctx;
+	struct icp_qat_fw_comp_req_hdr_cd_pars *cd_pars = &req_tmpl->cd_pars;
+	struct icp_qat_hw_comp_20_config_csr_upper hw_comp_upper_csr = { };
+	struct icp_qat_hw_comp_20_config_csr_lower hw_comp_lower_csr = { };
+	struct icp_qat_fw_comn_req_hdr *header = &req_tmpl->comn_hdr;
+	u32 upper_val;
+	u32 lower_val;
+
+	switch (algo) {
+	case QAT_DEFLATE:
+		header->service_cmd_id = ICP_QAT_FW_COMP_CMD_DYNAMIC;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	hw_comp_lower_csr.skip_ctrl = ICP_QAT_HW_COMP_20_BYTE_SKIP_3BYTE_LITERAL;
+	hw_comp_lower_csr.algo = ICP_QAT_HW_COMP_20_HW_COMP_FORMAT_ILZ77;
+	hw_comp_lower_csr.lllbd = ICP_QAT_HW_COMP_20_LLLBD_CTRL_LLLBD_ENABLED;
+	hw_comp_lower_csr.sd = ICP_QAT_HW_COMP_20_SEARCH_DEPTH_LEVEL_1;
+	hw_comp_lower_csr.hash_update = ICP_QAT_HW_COMP_20_SKIP_HASH_UPDATE_DONT_ALLOW;
+	hw_comp_lower_csr.edmm = ICP_QAT_HW_COMP_20_EXTENDED_DELAY_MATCH_MODE_EDMM_ENABLED;
+	hw_comp_upper_csr.nice = ICP_QAT_HW_COMP_20_CONFIG_CSR_NICE_PARAM_DEFAULT_VAL;
+	hw_comp_upper_csr.lazy = ICP_QAT_HW_COMP_20_CONFIG_CSR_LAZY_PARAM_DEFAULT_VAL;
+
+	upper_val = ICP_QAT_FW_COMP_20_BUILD_CONFIG_UPPER(hw_comp_upper_csr);
+	lower_val = ICP_QAT_FW_COMP_20_BUILD_CONFIG_LOWER(hw_comp_lower_csr);
+
+	cd_pars->u.sl.comp_slice_cfg_word[0] = lower_val;
+	cd_pars->u.sl.comp_slice_cfg_word[1] = upper_val;
+
+	return 0;
+}
+
+static int adf_gen4_build_decomp_block(void *ctx, enum adf_dc_algo algo)
+{
+	struct icp_qat_fw_comp_req *req_tmpl = ctx;
+	struct icp_qat_hw_decomp_20_config_csr_lower hw_decomp_lower_csr = { };
+	struct icp_qat_fw_comp_req_hdr_cd_pars *cd_pars = &req_tmpl->cd_pars;
+	struct icp_qat_fw_comn_req_hdr *header = &req_tmpl->comn_hdr;
+	u32 lower_val;
+
+	switch (algo) {
+	case QAT_DEFLATE:
+		header->service_cmd_id = ICP_QAT_FW_COMP_CMD_DECOMPRESS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	hw_decomp_lower_csr.algo = ICP_QAT_HW_DECOMP_20_HW_DECOMP_FORMAT_DEFLATE;
+	lower_val = ICP_QAT_FW_DECOMP_20_BUILD_CONFIG_LOWER(hw_decomp_lower_csr);
+
+	cd_pars->u.sl.comp_slice_cfg_word[0] = lower_val;
+	cd_pars->u.sl.comp_slice_cfg_word[1] = 0;
+
+	return 0;
+}
+
+void adf_gen4_init_dc_ops(struct adf_dc_ops *dc_ops)
+{
+	dc_ops->build_comp_block = adf_gen4_build_comp_block;
+	dc_ops->build_decomp_block = adf_gen4_build_decomp_block;
+}
+EXPORT_SYMBOL_GPL(adf_gen4_init_dc_ops);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
index 51fc2eaa263e..e4f4d5fa616d 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
@@ -7,6 +7,7 @@
 
 #include "adf_accel_devices.h"
 #include "adf_cfg_common.h"
+#include "adf_dc.h"
 
 /* PCIe configuration space */
 #define ADF_GEN4_BAR_MASK	(BIT(0) | BIT(2) | BIT(4))
@@ -180,5 +181,6 @@ int adf_gen4_bank_state_save(struct adf_accel_dev *accel_dev, u32 bank_number,
 int adf_gen4_bank_state_restore(struct adf_accel_dev *accel_dev,
 				u32 bank_number, struct bank_state *state);
 bool adf_gen4_services_supported(unsigned long service_mask);
+void adf_gen4_init_dc_ops(struct adf_dc_ops *dc_ops);
 
 #endif
diff --git a/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
index a0a29b97a749..8b123472b71c 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
@@ -8,6 +8,7 @@
 #include <linux/workqueue.h>
 #include "adf_accel_devices.h"
 #include "adf_common_drv.h"
+#include "adf_dc.h"
 #include "qat_bl.h"
 #include "qat_comp_req.h"
 #include "qat_compression.h"
@@ -145,9 +146,7 @@ static int qat_comp_alg_init_tfm(struct crypto_acomp *acomp_tfm)
 		return -EINVAL;
 	ctx->inst = inst;
 
-	ctx->inst->build_deflate_ctx(ctx->comp_ctx);
-
-	return 0;
+	return qat_comp_build_ctx(inst->accel_dev, ctx->comp_ctx, QAT_DEFLATE);
 }
 
 static void qat_comp_alg_exit_tfm(struct crypto_acomp *acomp_tfm)
diff --git a/drivers/crypto/intel/qat/qat_common/qat_compression.c b/drivers/crypto/intel/qat/qat_common/qat_compression.c
index 7842a9f22178..c285b45b8679 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_compression.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_compression.c
@@ -144,7 +144,6 @@ static int qat_compression_create_instances(struct adf_accel_dev *accel_dev)
 		inst->id = i;
 		atomic_set(&inst->refctr, 0);
 		inst->accel_dev = accel_dev;
-		inst->build_deflate_ctx = GET_DC_OPS(accel_dev)->build_deflate_ctx;
 
 		snprintf(key, sizeof(key), ADF_DC "%d" ADF_RING_DC_BANK_NUM, i);
 		ret = adf_cfg_get_param_value(accel_dev, SEC, key, val);
diff --git a/drivers/crypto/intel/qat/qat_common/qat_compression.h b/drivers/crypto/intel/qat/qat_common/qat_compression.h
index aebac2302dcf..5ced3ed0e5ea 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_compression.h
+++ b/drivers/crypto/intel/qat/qat_common/qat_compression.h
@@ -20,7 +20,6 @@ struct qat_compression_instance {
 	atomic_t refctr;
 	struct qat_instance_backlog backlog;
 	struct adf_dc_data *dc_data;
-	void (*build_deflate_ctx)(void *ctx);
 };
 
 static inline bool adf_hw_dev_has_compression(struct adf_accel_dev *accel_dev)
diff --git a/drivers/crypto/intel/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c b/drivers/crypto/intel/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
index bf9e8f34f451..5b4bd0ba1ccb 100644
--- a/drivers/crypto/intel/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
@@ -4,7 +4,6 @@
 #include <adf_admin.h>
 #include <adf_common_drv.h>
 #include <adf_gen2_config.h>
-#include <adf_gen2_dc.h>
 #include <adf_gen2_hw_csr_data.h>
 #include <adf_gen2_hw_data.h>
 #include <adf_gen2_pfvf.h>
diff --git a/drivers/crypto/intel/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c b/drivers/crypto/intel/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c
index bc59c1473eef..828456c43b76 100644
--- a/drivers/crypto/intel/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c
@@ -3,7 +3,6 @@
 #include <adf_accel_devices.h>
 #include <adf_common_drv.h>
 #include <adf_gen2_config.h>
-#include <adf_gen2_dc.h>
 #include <adf_gen2_hw_csr_data.h>
 #include <adf_gen2_hw_data.h>
 #include <adf_gen2_pfvf.h>
-- 
2.40.1



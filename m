Return-Path: <linux-crypto+bounces-14649-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F253EB00397
	for <lists+linux-crypto@lfdr.de>; Thu, 10 Jul 2025 15:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FD7546514
	for <lists+linux-crypto@lfdr.de>; Thu, 10 Jul 2025 13:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B61B259C85;
	Thu, 10 Jul 2025 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jEfRd6mt"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8043725A326
	for <linux-crypto@vger.kernel.org>; Thu, 10 Jul 2025 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154449; cv=none; b=E+EJ0I1UbavN40QdoBnn+/xJZjsR14YyBm6hFKS3tAVditX4wm3CRMvFTpOI7HGZINasHtYwyT2Ku3mgzax3TkAzDRpPnLYtdX1IzXo6Ba15lI7nwiIRss2idCSNziFCDGd7aNO/YWBhFG39lf5geoFCwbp2fq1LJhfFxwkcodk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154449; c=relaxed/simple;
	bh=ykGzoj+14sYxnlaqgYSVDlfiGJKpRLfa8NtzuFaCYno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LNDNVqBz+yO28qwrcIMhwNOAS3602Bci4YFgR1lROSFCcInGlvQj2fssTgsFl3nBLcz3sw0WhdQRbdaVofHRX/hQMYM4R3ULxAHceOz1TJvTB04VnUGF4x4srq/6vosKPd+JFDb3Ztoawf2wyMk5ppDtn3euLxcs++zneDFCn3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jEfRd6mt; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752154447; x=1783690447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ykGzoj+14sYxnlaqgYSVDlfiGJKpRLfa8NtzuFaCYno=;
  b=jEfRd6mtFLaLmyvpGGGvXHKqq9uFN+K9FG4VGJ5a2fwTVmwRLlsugYOd
   INFiTrHsTs+2Ovg7EhnryOS9jlr5gglNOhQQmMv0h3o/Y1KZK7JgdNvEK
   E0b9lFjkIwnaa5NTjJkdd3Trp1c+D/m+QMnRI88e7GLLcU3pUWinwGPN+
   Qy+8AUjIN2PQTxtRGEotsN8kByCpTMOxLIRIzN3dgZQ8NeRbJR4NrWZP1
   cSqAQ367JFs8Ir+BVXhe7WtMYVRqQN73xl1OJtL5hxCK/tsC1n3LVFkME
   Qc0MS4etaI92G+ILjzs2fC6rmQg9jpUI/88DeF7eYEikX8D5L6wi8sOc4
   A==;
X-CSE-ConnectionGUID: gKrPEwhDSTGitvxlG09Hsg==
X-CSE-MsgGUID: laWWFCvtSDaTT6q3YjJfXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="58241851"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="58241851"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 06:34:06 -0700
X-CSE-ConnectionGUID: beQwRyeGRhiOnOXgOwdneQ==
X-CSE-MsgGUID: nPucsz1ZQM+hMvtJOdQ/Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="155494667"
Received: from t21-qat.iind.intel.com ([10.49.15.35])
  by orviesa006.jf.intel.com with ESMTP; 10 Jul 2025 06:34:05 -0700
From: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
To: herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org,
	qat-linux@intel.com
Subject: [PATCH 8/8] crypto: qat - enable rate limiting feature for GEN6 devices
Date: Thu, 10 Jul 2025 14:33:47 +0100
Message-Id: <20250710133347.566310-9-suman.kumar.chakraborty@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250710133347.566310-1-suman.kumar.chakraborty@intel.com>
References: <20250710133347.566310-1-suman.kumar.chakraborty@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for enabling rate limiting(RL) feature for QAT GEN6 by
initializing the rl_data member in adf_hw_device_data structure.

Implement init_num_svc_aes() for GEN6 which will populate the number of
AEs associated with the RL service type.

Implement adf_gen6_get_svc_slice_cnt() for GEN6 which will return
the slice count that can support the RL service type.

Co-developed-by: George Abraham P <george.abraham.p@intel.com>
Signed-off-by: George Abraham P <george.abraham.p@intel.com>
Signed-off-by: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 Documentation/ABI/testing/sysfs-driver-qat_rl | 14 ++--
 .../intel/qat/qat_6xxx/adf_6xxx_hw_data.c     | 71 +++++++++++++++++++
 .../intel/qat/qat_6xxx/adf_6xxx_hw_data.h     | 20 ++++++
 3 files changed, 98 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-qat_rl b/Documentation/ABI/testing/sysfs-driver-qat_rl
index 8c282ae3155d..d534f89b4971 100644
--- a/Documentation/ABI/testing/sysfs-driver-qat_rl
+++ b/Documentation/ABI/testing/sysfs-driver-qat_rl
@@ -31,7 +31,7 @@ Description:
 		* rm_all: Removes all the configured SLAs.
 			* Inputs: None
 
-		This attribute is only available for qat_4xxx devices.
+		This attribute is only available for qat_4xxx and qat_6xxx devices.
 
 What:		/sys/bus/pci/devices/<BDF>/qat_rl/rp
 Date:		January 2024
@@ -68,7 +68,7 @@ Description:
 			## Write
 			# echo 0x5 > /sys/bus/pci/devices/<BDF>/qat_rl/rp
 
-		This attribute is only available for qat_4xxx devices.
+		This attribute is only available for qat_4xxx and qat_6xxx devices.
 
 What:		/sys/bus/pci/devices/<BDF>/qat_rl/id
 Date:		January 2024
@@ -101,7 +101,7 @@ Description:
 			# cat /sys/bus/pci/devices/<BDF>/qat_rl/rp
 			0x5  ## ring pair ID 0 and ring pair ID 2
 
-		This attribute is only available for qat_4xxx devices.
+		This attribute is only available for qat_4xxx and qat_6xxx devices.
 
 What:		/sys/bus/pci/devices/<BDF>/qat_rl/cir
 Date:		January 2024
@@ -135,7 +135,7 @@ Description:
 			# cat /sys/bus/pci/devices/<BDF>/qat_rl/cir
 			500
 
-		This attribute is only available for qat_4xxx devices.
+		This attribute is only available for qat_4xxx and qat_6xxx devices.
 
 What:		/sys/bus/pci/devices/<BDF>/qat_rl/pir
 Date:		January 2024
@@ -169,7 +169,7 @@ Description:
 			# cat /sys/bus/pci/devices/<BDF>/qat_rl/pir
 			750
 
-		This attribute is only available for qat_4xxx devices.
+		This attribute is only available for qat_4xxx and qat_6xxx devices.
 
 What:		/sys/bus/pci/devices/<BDF>/qat_rl/srv
 Date:		January 2024
@@ -202,7 +202,7 @@ Description:
 			# cat /sys/bus/pci/devices/<BDF>/qat_rl/srv
 			dc
 
-		This attribute is only available for qat_4xxx devices.
+		This attribute is only available for qat_4xxx and qat_6xxx devices.
 
 What:		/sys/bus/pci/devices/<BDF>/qat_rl/cap_rem
 Date:		January 2024
@@ -223,4 +223,4 @@ Description:
 			# cat /sys/bus/pci/devices/<BDF>/qat_rl/cap_rem
 			0
 
-		This attribute is only available for qat_4xxx devices.
+		This attribute is only available for qat_4xxx and qat_6xxx devices.
diff --git a/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.c b/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.c
index 28b7a7649bb6..bed88d3ce8ca 100644
--- a/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.c
@@ -524,6 +524,55 @@ static int adf_gen6_init_thd2arb_map(struct adf_accel_dev *accel_dev)
 	return 0;
 }
 
+static void init_num_svc_aes(struct adf_rl_hw_data *device_data)
+{
+	enum adf_fw_objs obj_type, obj_iter;
+	unsigned int svc, i, num_grp;
+	u32 ae_mask;
+
+	for (svc = 0; svc < SVC_BASE_COUNT; svc++) {
+		switch (svc) {
+		case SVC_SYM:
+		case SVC_ASYM:
+			obj_type = ADF_FW_CY_OBJ;
+			break;
+		case SVC_DC:
+		case SVC_DECOMP:
+			obj_type = ADF_FW_DC_OBJ;
+			break;
+		}
+
+		num_grp = ARRAY_SIZE(adf_default_fw_config);
+		for (i = 0; i < num_grp; i++) {
+			obj_iter = adf_default_fw_config[i].obj;
+			if (obj_iter == obj_type) {
+				ae_mask = adf_default_fw_config[i].ae_mask;
+				device_data->svc_ae_mask[svc] = hweight32(ae_mask);
+				break;
+			}
+		}
+	}
+}
+
+static u32 adf_gen6_get_svc_slice_cnt(struct adf_accel_dev *accel_dev,
+				      enum adf_base_services svc)
+{
+	struct adf_rl_hw_data *device_data = &accel_dev->hw_device->rl_data;
+
+	switch (svc) {
+	case SVC_SYM:
+		return device_data->slices.cph_cnt;
+	case SVC_ASYM:
+		return device_data->slices.pke_cnt;
+	case SVC_DC:
+		return device_data->slices.cpr_cnt + device_data->slices.dcpr_cnt;
+	case SVC_DECOMP:
+		return device_data->slices.dcpr_cnt;
+	default:
+		return 0;
+	}
+}
+
 static void set_vc_csr_for_bank(void __iomem *csr, u32 bank_number)
 {
 	u32 value;
@@ -805,6 +854,25 @@ static int dev_config(struct adf_accel_dev *accel_dev)
 	return ret;
 }
 
+static void adf_gen6_init_rl_data(struct adf_rl_hw_data *rl_data)
+{
+	rl_data->pciout_tb_offset = ADF_GEN6_RL_TOKEN_PCIEOUT_BUCKET_OFFSET;
+	rl_data->pciin_tb_offset = ADF_GEN6_RL_TOKEN_PCIEIN_BUCKET_OFFSET;
+	rl_data->r2l_offset = ADF_GEN6_RL_R2L_OFFSET;
+	rl_data->l2c_offset = ADF_GEN6_RL_L2C_OFFSET;
+	rl_data->c2s_offset = ADF_GEN6_RL_C2S_OFFSET;
+	rl_data->pcie_scale_div = ADF_6XXX_RL_PCIE_SCALE_FACTOR_DIV;
+	rl_data->pcie_scale_mul = ADF_6XXX_RL_PCIE_SCALE_FACTOR_MUL;
+	rl_data->max_tp[SVC_ASYM] = ADF_6XXX_RL_MAX_TP_ASYM;
+	rl_data->max_tp[SVC_SYM] = ADF_6XXX_RL_MAX_TP_SYM;
+	rl_data->max_tp[SVC_DC] = ADF_6XXX_RL_MAX_TP_DC;
+	rl_data->max_tp[SVC_DECOMP] = ADF_6XXX_RL_MAX_TP_DECOMP;
+	rl_data->scan_interval = ADF_6XXX_RL_SCANS_PER_SEC;
+	rl_data->scale_ref = ADF_6XXX_RL_SLICE_REF;
+
+	init_num_svc_aes(rl_data);
+}
+
 void adf_init_hw_data_6xxx(struct adf_hw_device_data *hw_data)
 {
 	hw_data->dev_class = &adf_6xxx_class;
@@ -863,6 +931,8 @@ void adf_init_hw_data_6xxx(struct adf_hw_device_data *hw_data)
 	hw_data->enable_pm = enable_pm;
 	hw_data->services_supported = services_supported;
 	hw_data->num_rps = ADF_GEN6_ETR_MAX_BANKS;
+	hw_data->clock_frequency = ADF_6XXX_AE_FREQ;
+	hw_data->get_svc_slice_cnt = adf_gen6_get_svc_slice_cnt;
 
 	adf_gen6_init_hw_csr_ops(&hw_data->csr_ops);
 	adf_gen6_init_pf_pfvf_ops(&hw_data->pfvf_ops);
@@ -870,6 +940,7 @@ void adf_init_hw_data_6xxx(struct adf_hw_device_data *hw_data)
 	adf_gen6_init_vf_mig_ops(&hw_data->vfmig_ops);
 	adf_gen6_init_ras_ops(&hw_data->ras_ops);
 	adf_gen6_init_tl_data(&hw_data->tl_data);
+	adf_gen6_init_rl_data(&hw_data->rl_data);
 }
 
 void adf_clean_hw_data_6xxx(struct adf_hw_device_data *hw_data)
diff --git a/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.h b/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.h
index 8824958527c4..d822911fe68c 100644
--- a/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.h
+++ b/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.h
@@ -122,6 +122,13 @@
 /* Number of heartbeat counter pairs */
 #define ADF_NUM_HB_CNT_PER_AE ADF_NUM_THREADS_PER_AE
 
+/* Rate Limiting */
+#define ADF_GEN6_RL_R2L_OFFSET			0x508000
+#define ADF_GEN6_RL_L2C_OFFSET			0x509000
+#define ADF_GEN6_RL_C2S_OFFSET			0x508818
+#define ADF_GEN6_RL_TOKEN_PCIEIN_BUCKET_OFFSET	0x508800
+#define ADF_GEN6_RL_TOKEN_PCIEOUT_BUCKET_OFFSET	0x508804
+
 /* Physical function fuses */
 #define ADF_6XXX_ACCELENGINES_MASK	GENMASK(8, 0)
 #define ADF_6XXX_ADMIN_AE_MASK		GENMASK(8, 8)
@@ -133,6 +140,19 @@
 #define ADF_6XXX_DC_OBJ		"qat_6xxx_dc.bin"
 #define ADF_6XXX_ADMIN_OBJ	"qat_6xxx_admin.bin"
 
+/* RL constants */
+#define ADF_6XXX_RL_PCIE_SCALE_FACTOR_DIV	100
+#define ADF_6XXX_RL_PCIE_SCALE_FACTOR_MUL	102
+#define ADF_6XXX_RL_SCANS_PER_SEC		954
+#define ADF_6XXX_RL_MAX_TP_ASYM			173750UL
+#define ADF_6XXX_RL_MAX_TP_SYM			95000UL
+#define ADF_6XXX_RL_MAX_TP_DC			40000UL
+#define ADF_6XXX_RL_MAX_TP_DECOMP		40000UL
+#define ADF_6XXX_RL_SLICE_REF			1000UL
+
+/* Clock frequency */
+#define ADF_6XXX_AE_FREQ			(1000 * HZ_PER_MHZ)
+
 enum icp_qat_gen6_slice_mask {
 	ICP_ACCEL_GEN6_MASK_UCS_SLICE = BIT(0),
 	ICP_ACCEL_GEN6_MASK_AUTH_SLICE = BIT(1),
-- 
2.40.1



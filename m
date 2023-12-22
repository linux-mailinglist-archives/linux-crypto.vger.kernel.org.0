Return-Path: <linux-crypto+bounces-978-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABF081CAC9
	for <lists+linux-crypto@lfdr.de>; Fri, 22 Dec 2023 14:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7B31F23212
	for <lists+linux-crypto@lfdr.de>; Fri, 22 Dec 2023 13:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3961CA9C;
	Fri, 22 Dec 2023 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBKRvDIW"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A20D1CA86
	for <linux-crypto@vger.kernel.org>; Fri, 22 Dec 2023 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703252228; x=1734788228;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TqjcPk1esuoyF29T/XgBejGkQQTqzH0IgaPaYbU+tQo=;
  b=DBKRvDIW3pw2zlRG9hTWxdk4N4LyKhHCQgOUwJxkuoqmWPMuAEhYMbll
   zuW7uyj0oFlT1Gv2peD+u75BMMEadUkx9vFUUX3kgo49mT5caC64c+Izp
   afIpQFJGGTDPS607rjIIr8tIWXEjFGDEnSNL0yajFS9Y+2Jd6qzF0FWYW
   U39jaXUj6yOpvD35Hl6K24DEa76gkb+gJUpeiscPcIPVsIgiMrfK4SfZ0
   PccaEsiy4syJE+Qq1sITs1NoLKGOEJ8qkKcZtJgqdBPZ/yTKng/LZ2g7D
   oGlxyDlI3T5DOsSIf82JVxG61POBjYsoW2s17sgN3DcQo58Hzeu375/Mf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="3371419"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="3371419"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 05:37:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="847462384"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="847462384"
Received: from r031s002_zp31l10c01.deacluster.intel.com (HELO localhost.localdomain) ([10.219.171.29])
  by fmsmga004.fm.intel.com with ESMTP; 22 Dec 2023 05:37:06 -0800
From: Damian Muszynski <damian.muszynski@intel.com>
To: herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org,
	qat-linux@intel.com,
	Damian Muszynski <damian.muszynski@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH] crypto: qat - generate dynamically arbiter mappings
Date: Fri, 22 Dec 2023 14:15:35 +0100
Message-ID: <20231222131804.8765-1-damian.muszynski@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

The thread-to-arbiter mapping describes which arbiter can assign jobs
to an acceleration engine thread.
The existing mappings are functionally correct, but hardcoded and not
optimized.

Replace the static mappings with an algorithm that generates optimal
mappings, based on the loaded configuration.

The logic has been made common so that it can be shared between all
QAT GEN4 devices.

Signed-off-by: Damian Muszynski <damian.muszynski@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 .../intel/qat/qat_420xx/adf_420xx_hw_data.c   | 131 +++++++-----------
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     | 110 ++++++++++-----
 .../intel/qat/qat_common/adf_accel_devices.h  |   4 +
 .../intel/qat/qat_common/adf_gen4_hw_data.c   |  90 ++++++++++++
 .../intel/qat/qat_common/adf_gen4_hw_data.h   |  12 ++
 5 files changed, 235 insertions(+), 112 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
index 5edce27db864..a87d29ae724f 100644
--- a/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
@@ -25,6 +25,10 @@
 #define ADF_AE_GROUP_3		GENMASK(15, 12)
 #define ADF_AE_GROUP_4		BIT(16)
 
+#define ENA_THD_MASK_ASYM	GENMASK(1, 0)
+#define ENA_THD_MASK_SYM	GENMASK(3, 0)
+#define ENA_THD_MASK_DC		GENMASK(1, 0)
+
 static const char * const adf_420xx_fw_objs[] = {
 	[ADF_FW_SYM_OBJ] =  ADF_420XX_SYM_OBJ,
 	[ADF_FW_ASYM_OBJ] =  ADF_420XX_ASYM_OBJ,
@@ -83,62 +87,6 @@ static const struct adf_fw_config adf_fw_dcc_config[] = {
 	{ADF_AE_GROUP_4, ADF_FW_ADMIN_OBJ},
 };
 
-/* Worker thread to service arbiter mappings */
-static const u32 default_thrd_to_arb_map[ADF_420XX_MAX_ACCELENGINES] = {
-	0x00000055, 0x00000055, 0x00000055, 0x00000055,
-	0x0000AAAA, 0x0000AAAA, 0x0000AAAA, 0x0000AAAA,
-	0x00000055, 0x00000055, 0x00000055, 0x00000055,
-	0x0000AAAA, 0x0000AAAA, 0x0000AAAA, 0x0000AAAA,
-	0x0
-};
-
-static const u32 thrd_to_arb_map_asym[ADF_420XX_MAX_ACCELENGINES] = {
-	0x000000FF, 0x000000FF, 0x000000FF, 0x000000FF,
-	0x000000FF, 0x000000FF, 0x000000FF, 0x000000FF,
-	0x000000FF, 0x000000FF, 0x000000FF, 0x000000FF,
-	0x000000FF, 0x000000FF, 0x000000FF, 0x000000FF,
-	0x0
-};
-
-static const u32 thrd_to_arb_map_sym[ADF_420XX_MAX_ACCELENGINES] = {
-	0x0000FFFF, 0x0000FFFF, 0x0000FFFF, 0x0000FFFF,
-	0x0000FFFF, 0x0000FFFF, 0x0000FFFF, 0x0000FFFF,
-	0x0000FFFF, 0x0000FFFF, 0x0000FFFF, 0x0000FFFF,
-	0x0000FFFF, 0x0000FFFF, 0x0000FFFF, 0x0000FFFF,
-	0x0
-};
-
-static const u32 thrd_to_arb_map_asym_dc[ADF_420XX_MAX_ACCELENGINES] = {
-	0x00000055, 0x00000055, 0x00000055, 0x00000055,
-	0x000000AA, 0x000000AA, 0x000000AA, 0x000000AA,
-	0x000000AA, 0x000000AA, 0x000000AA, 0x000000AA,
-	0x000000AA, 0x000000AA, 0x000000AA, 0x000000AA,
-	0x0
-};
-
-static const u32 thrd_to_arb_map_sym_dc[ADF_420XX_MAX_ACCELENGINES] = {
-	0x00000055, 0x00000055, 0x00000055, 0x00000055,
-	0x0000AAAA, 0x0000AAAA, 0x0000AAAA, 0x0000AAAA,
-	0x0000AAAA, 0x0000AAAA, 0x0000AAAA, 0x0000AAAA,
-	0x00000000, 0x00000000, 0x00000000, 0x00000000,
-	0x0
-};
-
-static const u32 thrd_to_arb_map_dc[ADF_420XX_MAX_ACCELENGINES] = {
-	0x000000FF, 0x000000FF, 0x000000FF, 0x000000FF,
-	0x000000FF, 0x000000FF, 0x000000FF, 0x000000FF,
-	0x00000000, 0x00000000, 0x00000000, 0x00000000,
-	0x00000000, 0x00000000, 0x00000000, 0x00000000,
-	0x0
-};
-
-static const u32 thrd_to_arb_map_dcc[ADF_420XX_MAX_ACCELENGINES] = {
-	0x00000000, 0x00000000, 0x00000000, 0x00000000,
-	0x0000FFFF, 0x0000FFFF, 0x0000FFFF, 0x0000FFFF,
-	0x00000000, 0x00000000, 0x00000000, 0x00000000,
-	0x00000000, 0x00000000, 0x00000000, 0x00000000,
-	0x0
-};
 
 static struct adf_hw_device_class adf_420xx_class = {
 	.name = ADF_420XX_DEVICE_NAME,
@@ -346,24 +294,11 @@ static u32 get_accel_cap(struct adf_accel_dev *accel_dev)
 
 static const u32 *adf_get_arbiter_mapping(struct adf_accel_dev *accel_dev)
 {
-	switch (adf_get_service_enabled(accel_dev)) {
-	case SVC_ASYM:
-		return thrd_to_arb_map_asym;
-	case SVC_SYM:
-		return thrd_to_arb_map_sym;
-	case SVC_DC:
-		return thrd_to_arb_map_dc;
-	case SVC_DCC:
-		return thrd_to_arb_map_dcc;
-	case SVC_ASYM_DC:
-	case SVC_DC_ASYM:
-		return thrd_to_arb_map_asym_dc;
-	case SVC_DC_SYM:
-	case SVC_SYM_DC:
-		return thrd_to_arb_map_sym_dc;
-	default:
-		return default_thrd_to_arb_map;
-	}
+	if (adf_gen4_init_thd2arb_map(accel_dev))
+		dev_warn(&GET_DEV(accel_dev),
+			 "Generate of the thread to arbiter map failed");
+
+	return GET_HW_DATA(accel_dev)->thd_to_arb_map;
 }
 
 static void adf_init_rl_data(struct adf_rl_hw_data *rl_data)
@@ -384,11 +319,47 @@ static void adf_init_rl_data(struct adf_rl_hw_data *rl_data)
 	rl_data->scale_ref = ADF_420XX_RL_SLICE_REF;
 }
 
-enum adf_rp_groups {
-	RP_GROUP_0 = 0,
-	RP_GROUP_1,
-	RP_GROUP_COUNT
-};
+static int get_rp_group(struct adf_accel_dev *accel_dev, u32 ae_mask)
+{
+	switch (ae_mask) {
+	case ADF_AE_GROUP_0:
+		return RP_GROUP_0;
+	case ADF_AE_GROUP_1:
+	case ADF_AE_GROUP_3:
+		return RP_GROUP_1;
+	case ADF_AE_GROUP_2:
+		if (get_fw_config(accel_dev) == adf_fw_cy_config)
+			return RP_GROUP_0;
+		else
+			return RP_GROUP_1;
+	default:
+		dev_dbg(&GET_DEV(accel_dev), "ae_mask not recognized");
+		return -EINVAL;
+	}
+}
+
+static u32 get_ena_thd_mask(struct adf_accel_dev *accel_dev, u32 obj_num)
+{
+	const struct adf_fw_config *fw_config;
+
+	if (obj_num >= uof_get_num_objs(accel_dev))
+		return ADF_GEN4_ENA_THD_MASK_ERROR;
+
+	fw_config = get_fw_config(accel_dev);
+	if (!fw_config)
+		return ADF_GEN4_ENA_THD_MASK_ERROR;
+
+	switch (fw_config[obj_num].obj) {
+	case ADF_FW_ASYM_OBJ:
+		return ENA_THD_MASK_ASYM;
+	case ADF_FW_SYM_OBJ:
+		return ENA_THD_MASK_SYM;
+	case ADF_FW_DC_OBJ:
+		return ENA_THD_MASK_DC;
+	default:
+		return ADF_GEN4_ENA_THD_MASK_ERROR;
+	}
+}
 
 static u16 get_ring_to_svc_map(struct adf_accel_dev *accel_dev)
 {
@@ -526,6 +497,8 @@ void adf_init_hw_data_420xx(struct adf_hw_device_data *hw_data, u32 dev_id)
 	hw_data->uof_get_name = uof_get_name_420xx;
 	hw_data->uof_get_num_objs = uof_get_num_objs;
 	hw_data->uof_get_ae_mask = uof_get_ae_mask;
+	hw_data->get_rp_group = get_rp_group;
+	hw_data->get_ena_thd_mask = get_ena_thd_mask;
 	hw_data->set_msix_rttable = adf_gen4_set_msix_default_rttable;
 	hw_data->set_ssm_wdtimer = adf_gen4_set_ssm_wdtimer;
 	hw_data->get_ring_to_svc_map = get_ring_to_svc_map;
diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
index 558caefd71b9..479062aa5e6b 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -23,6 +23,11 @@
 #define ADF_AE_GROUP_1		GENMASK(7, 4)
 #define ADF_AE_GROUP_2		BIT(8)
 
+#define ENA_THD_MASK_ASYM	GENMASK(1, 0)
+#define ENA_THD_MASK_ASYM_401XX	GENMASK(5, 0)
+#define ENA_THD_MASK_SYM	GENMASK(6, 0)
+#define ENA_THD_MASK_DC		GENMASK(1, 0)
+
 static const char * const adf_4xxx_fw_objs[] = {
 	[ADF_FW_SYM_OBJ] =  ADF_4XXX_SYM_OBJ,
 	[ADF_FW_ASYM_OBJ] =  ADF_4XXX_ASYM_OBJ,
@@ -86,25 +91,6 @@ static_assert(ARRAY_SIZE(adf_fw_cy_config) == ARRAY_SIZE(adf_fw_asym_dc_config))
 static_assert(ARRAY_SIZE(adf_fw_cy_config) == ARRAY_SIZE(adf_fw_sym_dc_config));
 static_assert(ARRAY_SIZE(adf_fw_cy_config) == ARRAY_SIZE(adf_fw_dcc_config));
 
-/* Worker thread to service arbiter mappings */
-static const u32 default_thrd_to_arb_map[ADF_4XXX_MAX_ACCELENGINES] = {
-	0x5555555, 0x5555555, 0x5555555, 0x5555555,
-	0xAAAAAAA, 0xAAAAAAA, 0xAAAAAAA, 0xAAAAAAA,
-	0x0
-};
-
-static const u32 thrd_to_arb_map_dc[ADF_4XXX_MAX_ACCELENGINES] = {
-	0x000000FF, 0x000000FF, 0x000000FF, 0x000000FF,
-	0x000000FF, 0x000000FF, 0x000000FF, 0x000000FF,
-	0x0
-};
-
-static const u32 thrd_to_arb_map_dcc[ADF_4XXX_MAX_ACCELENGINES] = {
-	0x00000000, 0x00000000, 0x00000000, 0x00000000,
-	0x0000FFFF, 0x0000FFFF, 0x0000FFFF, 0x0000FFFF,
-	0x0
-};
-
 static struct adf_hw_device_class adf_4xxx_class = {
 	.name = ADF_4XXX_DEVICE_NAME,
 	.type = DEV_4XXX,
@@ -220,14 +206,11 @@ static u32 get_accel_cap(struct adf_accel_dev *accel_dev)
 
 static const u32 *adf_get_arbiter_mapping(struct adf_accel_dev *accel_dev)
 {
-	switch (adf_get_service_enabled(accel_dev)) {
-	case SVC_DC:
-		return thrd_to_arb_map_dc;
-	case SVC_DCC:
-		return thrd_to_arb_map_dcc;
-	default:
-		return default_thrd_to_arb_map;
-	}
+	if (adf_gen4_init_thd2arb_map(accel_dev))
+		dev_warn(&GET_DEV(accel_dev),
+			 "Generate of the thread to arbiter map failed");
+
+	return GET_HW_DATA(accel_dev)->thd_to_arb_map;
 }
 
 static void adf_init_rl_data(struct adf_rl_hw_data *rl_data)
@@ -278,11 +261,64 @@ static const struct adf_fw_config *get_fw_config(struct adf_accel_dev *accel_dev
 	}
 }
 
-enum adf_rp_groups {
-	RP_GROUP_0 = 0,
-	RP_GROUP_1,
-	RP_GROUP_COUNT
-};
+static int get_rp_group(struct adf_accel_dev *accel_dev, u32 ae_mask)
+{
+	switch (ae_mask) {
+	case ADF_AE_GROUP_0:
+		return RP_GROUP_0;
+	case ADF_AE_GROUP_1:
+		return RP_GROUP_1;
+	default:
+		dev_dbg(&GET_DEV(accel_dev), "ae_mask not recognized");
+		return -EINVAL;
+	}
+}
+
+static u32 get_ena_thd_mask(struct adf_accel_dev *accel_dev, u32 obj_num)
+{
+	const struct adf_fw_config *fw_config;
+
+	if (obj_num >= uof_get_num_objs(accel_dev))
+		return ADF_GEN4_ENA_THD_MASK_ERROR;
+
+	fw_config = get_fw_config(accel_dev);
+	if (!fw_config)
+		return ADF_GEN4_ENA_THD_MASK_ERROR;
+
+	switch (fw_config[obj_num].obj) {
+	case ADF_FW_ASYM_OBJ:
+		return ENA_THD_MASK_ASYM;
+	case ADF_FW_SYM_OBJ:
+		return ENA_THD_MASK_SYM;
+	case ADF_FW_DC_OBJ:
+		return ENA_THD_MASK_DC;
+	default:
+		return ADF_GEN4_ENA_THD_MASK_ERROR;
+	}
+}
+
+static u32 get_ena_thd_mask_401xx(struct adf_accel_dev *accel_dev, u32 obj_num)
+{
+	const struct adf_fw_config *fw_config;
+
+	if (obj_num >= uof_get_num_objs(accel_dev))
+		return ADF_GEN4_ENA_THD_MASK_ERROR;
+
+	fw_config = get_fw_config(accel_dev);
+	if (!fw_config)
+		return ADF_GEN4_ENA_THD_MASK_ERROR;
+
+	switch (fw_config[obj_num].obj) {
+	case ADF_FW_ASYM_OBJ:
+		return ENA_THD_MASK_ASYM_401XX;
+	case ADF_FW_SYM_OBJ:
+		return ENA_THD_MASK_SYM;
+	case ADF_FW_DC_OBJ:
+		return ENA_THD_MASK_DC;
+	default:
+		return ADF_GEN4_ENA_THD_MASK_ERROR;
+	}
+}
 
 static u16 get_ring_to_svc_map(struct adf_accel_dev *accel_dev)
 {
@@ -428,14 +464,22 @@ void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data, u32 dev_id)
 		hw_data->fw_mmp_name = ADF_402XX_MMP;
 		hw_data->uof_get_name = uof_get_name_402xx;
 		break;
-
+	case ADF_401XX_PCI_DEVICE_ID:
+		hw_data->fw_name = ADF_4XXX_FW;
+		hw_data->fw_mmp_name = ADF_4XXX_MMP;
+		hw_data->uof_get_name = uof_get_name_4xxx;
+		hw_data->get_ena_thd_mask = get_ena_thd_mask_401xx;
+		break;
 	default:
 		hw_data->fw_name = ADF_4XXX_FW;
 		hw_data->fw_mmp_name = ADF_4XXX_MMP;
 		hw_data->uof_get_name = uof_get_name_4xxx;
+		hw_data->get_ena_thd_mask = get_ena_thd_mask;
+		break;
 	}
 	hw_data->uof_get_num_objs = uof_get_num_objs;
 	hw_data->uof_get_ae_mask = uof_get_ae_mask;
+	hw_data->get_rp_group = get_rp_group;
 	hw_data->set_msix_rttable = adf_gen4_set_msix_default_rttable;
 	hw_data->set_ssm_wdtimer = adf_gen4_set_ssm_wdtimer;
 	hw_data->get_ring_to_svc_map = get_ring_to_svc_map;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
index db671879b1f8..a16c7e6edc65 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
@@ -13,6 +13,7 @@
 #include "adf_rl.h"
 #include "adf_telemetry.h"
 #include "adf_pfvf_msg.h"
+#include "icp_qat_hw.h"
 
 #define ADF_DH895XCC_DEVICE_NAME "dh895xcc"
 #define ADF_DH895XCCVF_DEVICE_NAME "dh895xccvf"
@@ -248,6 +249,8 @@ struct adf_hw_device_data {
 	const char *(*uof_get_name)(struct adf_accel_dev *accel_dev, u32 obj_num);
 	u32 (*uof_get_num_objs)(struct adf_accel_dev *accel_dev);
 	u32 (*uof_get_ae_mask)(struct adf_accel_dev *accel_dev, u32 obj_num);
+	int (*get_rp_group)(struct adf_accel_dev *accel_dev, u32 ae_mask);
+	u32 (*get_ena_thd_mask)(struct adf_accel_dev *accel_dev, u32 obj_num);
 	int (*dev_config)(struct adf_accel_dev *accel_dev);
 	struct adf_pfvf_ops pfvf_ops;
 	struct adf_hw_csr_ops csr_ops;
@@ -270,6 +273,7 @@ struct adf_hw_device_data {
 	u32 admin_ae_mask;
 	u16 tx_rings_mask;
 	u16 ring_to_svc_map;
+	u32 thd_to_arb_map[ICP_QAT_HW_AE_DELIMITER];
 	u8 tx_rx_gap;
 	u8 num_banks;
 	u16 num_banks_per_vf;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
index ee08b34876dd..9985683056d5 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2020 Intel Corporation */
 #include <linux/iopoll.h>
 #include "adf_accel_devices.h"
+#include "adf_cfg_services.h"
 #include "adf_common_drv.h"
 #include "adf_gen4_hw_data.h"
 #include "adf_gen4_pm.h"
@@ -340,3 +341,92 @@ int adf_gen4_ring_pair_reset(struct adf_accel_dev *accel_dev, u32 bank_number)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(adf_gen4_ring_pair_reset);
+
+static const u32 thrd_to_arb_map_dcc[] = {
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0000FFFF, 0x0000FFFF, 0x0000FFFF, 0x0000FFFF,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0
+};
+
+static const u16 rp_group_to_arb_mask[] = {
+	[RP_GROUP_0] = 0x5,
+	[RP_GROUP_1] = 0xA,
+};
+
+static bool is_single_service(int service_id)
+{
+	switch (service_id) {
+	case SVC_DC:
+	case SVC_SYM:
+	case SVC_ASYM:
+		return true;
+	case SVC_CY:
+	case SVC_CY2:
+	case SVC_DCC:
+	case SVC_ASYM_DC:
+	case SVC_DC_ASYM:
+	case SVC_SYM_DC:
+	case SVC_DC_SYM:
+	default:
+		return false;
+	}
+}
+
+int adf_gen4_init_thd2arb_map(struct adf_accel_dev *accel_dev)
+{
+	struct adf_hw_device_data *hw_data = GET_HW_DATA(accel_dev);
+	u32 *thd2arb_map = hw_data->thd_to_arb_map;
+	unsigned int ae_cnt, worker_obj_cnt, i, j;
+	unsigned long ae_mask, thds_mask;
+	int srv_id, rp_group;
+	u32 thd2arb_map_base;
+	u16 arb_mask;
+
+	if (!hw_data->get_rp_group || !hw_data->get_ena_thd_mask ||
+	    !hw_data->get_num_aes || !hw_data->uof_get_num_objs ||
+	    !hw_data->uof_get_ae_mask)
+		return -EFAULT;
+
+	srv_id = adf_get_service_enabled(accel_dev);
+	if (srv_id < 0)
+		return srv_id;
+
+	ae_cnt = hw_data->get_num_aes(hw_data);
+	worker_obj_cnt = hw_data->uof_get_num_objs(accel_dev) -
+			 ADF_GEN4_ADMIN_ACCELENGINES;
+
+	if (srv_id == SVC_DCC) {
+		memcpy(thd2arb_map, thrd_to_arb_map_dcc,
+		       array_size(sizeof(*thd2arb_map), ae_cnt));
+		return 0;
+	}
+
+	for (i = 0; i < worker_obj_cnt; i++) {
+		ae_mask = hw_data->uof_get_ae_mask(accel_dev, i);
+		rp_group = hw_data->get_rp_group(accel_dev, ae_mask);
+		thds_mask = hw_data->get_ena_thd_mask(accel_dev, i);
+		thd2arb_map_base = 0;
+
+		if (rp_group >= RP_GROUP_COUNT || rp_group < RP_GROUP_0)
+			return -EINVAL;
+
+		if (thds_mask == ADF_GEN4_ENA_THD_MASK_ERROR)
+			return -EINVAL;
+
+		if (is_single_service(srv_id))
+			arb_mask = rp_group_to_arb_mask[RP_GROUP_0] |
+				   rp_group_to_arb_mask[RP_GROUP_1];
+		else
+			arb_mask = rp_group_to_arb_mask[rp_group];
+
+		for_each_set_bit(j, &thds_mask, ADF_NUM_THREADS_PER_AE)
+			thd2arb_map_base |= arb_mask << (j * 4);
+
+		for_each_set_bit(j, &ae_mask, ae_cnt)
+			thd2arb_map[j] = thd2arb_map_base;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(adf_gen4_init_thd2arb_map);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
index 46a782ba456f..7d8a774cadc8 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
@@ -28,6 +28,7 @@
 /* Accelerators */
 #define ADF_GEN4_ACCELERATORS_MASK	0x1
 #define ADF_GEN4_MAX_ACCELERATORS	1
+#define ADF_GEN4_ADMIN_ACCELENGINES	1
 
 /* MSIX interrupt */
 #define ADF_GEN4_SMIAPF_RP_X0_MASK_OFFSET	0x41A040
@@ -193,6 +194,9 @@ do { \
 #define ADF_GEN4_RL_TOKEN_PCIEIN_BUCKET_OFFSET	0x508800
 #define ADF_GEN4_RL_TOKEN_PCIEOUT_BUCKET_OFFSET	0x508804
 
+/* Arbiter threads mask with error value */
+#define ADF_GEN4_ENA_THD_MASK_ERROR	GENMASK(ADF_NUM_THREADS_PER_AE, 0)
+
 void adf_gen4_set_ssm_wdtimer(struct adf_accel_dev *accel_dev);
 
 enum icp_qat_gen4_slice_mask {
@@ -207,6 +211,12 @@ enum icp_qat_gen4_slice_mask {
 	ICP_ACCEL_GEN4_MASK_ZUC_256_SLICE = BIT(9),
 };
 
+enum adf_gen4_rp_groups {
+	RP_GROUP_0,
+	RP_GROUP_1,
+	RP_GROUP_COUNT
+};
+
 void adf_gen4_enable_error_correction(struct adf_accel_dev *accel_dev);
 void adf_gen4_enable_ints(struct adf_accel_dev *accel_dev);
 u32 adf_gen4_get_accel_mask(struct adf_hw_device_data *self);
@@ -224,4 +234,6 @@ void adf_gen4_init_hw_csr_ops(struct adf_hw_csr_ops *csr_ops);
 int adf_gen4_ring_pair_reset(struct adf_accel_dev *accel_dev, u32 bank_number);
 void adf_gen4_set_msix_default_rttable(struct adf_accel_dev *accel_dev);
 void adf_gen4_set_ssm_wdtimer(struct adf_accel_dev *accel_dev);
+int adf_gen4_init_thd2arb_map(struct adf_accel_dev *accel_dev);
+
 #endif

base-commit: c0dff412728aee07b6124eeb70c0d89819f26e71
-- 
2.43.0



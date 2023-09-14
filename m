Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDE87A0870
	for <lists+linux-crypto@lfdr.de>; Thu, 14 Sep 2023 17:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240284AbjINPEd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 14 Sep 2023 11:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240593AbjINPE3 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 14 Sep 2023 11:04:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FF81FD2
        for <linux-crypto@vger.kernel.org>; Thu, 14 Sep 2023 08:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694703865; x=1726239865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dOcuuximqMMet8P5nt8dQtiz1x/xB3oGQ65ltzGT7p0=;
  b=TSNFIgmcYTIcjBOWiA6/8Sd1ps17nyfxlM5dqZUXz4jkWfHorZWPDteZ
   JwOrczF4cR6t9J8x88ZeYm1Bb8psyqG53zY+PxyK+fCHzG4vqRc9MZ5Na
   K5rfmcjKFGd3ilHpl9KneOvgeaQfQfZAo1jo4j9X7L6or78t/SB0v1iJY
   XKm4BdYmpaFjfJAj4ZBxB6Uvf0fITVpaNguslHqasChVrop+fAmqauQIc
   euYEYU2sPFMORY5dPU7n898cj5yMHRd9HiKfBheZtMrpoB+rU1gtQyxSb
   Vw53OYnVg5wA4x6rk4p5OnvMmRHPs13tav0Xm8AU5jl/NNdA0sJBdMAoO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="381679580"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="381679580"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 07:35:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="810089558"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="810089558"
Received: from silpixa00400295.ir.intel.com ([10.237.213.194])
  by fmsmga008.fm.intel.com with ESMTP; 14 Sep 2023 07:35:08 -0700
From:   Adam Guerin <adam.guerin@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Adam Guerin <adam.guerin@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH 2/2] crypto: qat - enable dc chaining service
Date:   Thu, 14 Sep 2023 15:14:13 +0100
Message-Id: <20230914141413.466155-3-adam.guerin@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914141413.466155-1-adam.guerin@intel.com>
References: <20230914141413.466155-1-adam.guerin@intel.com>
MIME-Version: 1.0
Organisation: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare, Ireland
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

QAT GEN4 devices support chained compression operations. These
allow, with a single request to firmware, to hash then compress
data.

Extend the configuration to enable such mode. The cfg_services
operations in sysfs are extended to allow the string "dcc". When
selected, the driver downloads to the device both the symmetric
crypto and the compression firmware images and sends an admin message
to firmware which enables `chained` operations.
In addition, it sets the device's capabilities as the combination
of compression and symmetric crypto capabilities, while excluding
the ICP_ACCEL_CAPABILITIES_CRYPTO_SYMMETRIC bit to indicate
that in this mode, symmetric crypto instances are not supported.

When "dcc" is enabled, the device will handle compression requests
as if the "dc" configuration is loaded ("dcc" is a variation of "dc")
and the driver will register the acomp algorithms.

As for the other extended configurations, "dcc" is only available for
qat_4xxx devices and the chaining service will be only accessible from
user space.

Signed-off-by: Adam Guerin <adam.guerin@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 Documentation/ABI/testing/sysfs-driver-qat    |  2 +
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     | 29 ++++++++++++++
 drivers/crypto/intel/qat/qat_4xxx/adf_drv.c   |  1 +
 .../crypto/intel/qat/qat_common/adf_admin.c   | 39 +++++++++++++++++--
 .../intel/qat/qat_common/adf_cfg_services.h   |  2 +
 .../intel/qat/qat_common/adf_cfg_strings.h    |  1 +
 .../qat/qat_common/icp_qat_fw_init_admin.h    |  1 +
 7 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-qat b/Documentation/ABI/testing/sysfs-driver-qat
index ef6d6c57105e..96834d103a09 100644
--- a/Documentation/ABI/testing/sysfs-driver-qat
+++ b/Documentation/ABI/testing/sysfs-driver-qat
@@ -29,6 +29,8 @@ Description:	(RW) Reports the current configuration of the QAT device.
 		  services
 		* asym;sym: identical to sym;asym
 		* dc: the device is configured for running compression services
+		* dcc: identical to dc but enables the dc chaining feature,
+		  hash then compression. If this is not required chose dc
 		* sym: the device is configured for running symmetric crypto
 		  services
 		* asym: the device is configured for running asymmetric crypto
diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
index cc2285b9f17b..12b5d1819111 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -76,11 +76,18 @@ static const struct adf_fw_config adf_fw_sym_dc_config[] = {
 	{0x100, ADF_FW_ADMIN_OBJ},
 };
 
+static const struct adf_fw_config adf_fw_dcc_config[] = {
+	{0xF0, ADF_FW_DC_OBJ},
+	{0xF, ADF_FW_SYM_OBJ},
+	{0x100, ADF_FW_ADMIN_OBJ},
+};
+
 static_assert(ARRAY_SIZE(adf_fw_cy_config) == ARRAY_SIZE(adf_fw_dc_config));
 static_assert(ARRAY_SIZE(adf_fw_cy_config) == ARRAY_SIZE(adf_fw_sym_config));
 static_assert(ARRAY_SIZE(adf_fw_cy_config) == ARRAY_SIZE(adf_fw_asym_config));
 static_assert(ARRAY_SIZE(adf_fw_cy_config) == ARRAY_SIZE(adf_fw_asym_dc_config));
 static_assert(ARRAY_SIZE(adf_fw_cy_config) == ARRAY_SIZE(adf_fw_sym_dc_config));
+static_assert(ARRAY_SIZE(adf_fw_cy_config) == ARRAY_SIZE(adf_fw_dcc_config));
 
 /* Worker thread to service arbiter mappings */
 static const u32 default_thrd_to_arb_map[ADF_4XXX_MAX_ACCELENGINES] = {
@@ -95,6 +102,12 @@ static const u32 thrd_to_arb_map_dc[ADF_4XXX_MAX_ACCELENGINES] = {
 	0x0
 };
 
+static const u32 thrd_to_arb_map_dcc[ADF_4XXX_MAX_ACCELENGINES] = {
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0000FFFF, 0x0000FFFF, 0x0000FFFF, 0x0000FFFF,
+	0x0
+};
+
 static struct adf_hw_device_class adf_4xxx_class = {
 	.name = ADF_4XXX_DEVICE_NAME,
 	.type = DEV_4XXX,
@@ -189,6 +202,7 @@ static u32 get_accel_cap(struct adf_accel_dev *accel_dev)
 {
 	struct pci_dev *pdev = accel_dev->accel_pci_dev.pci_dev;
 	u32 capabilities_sym, capabilities_asym, capabilities_dc;
+	u32 capabilities_dcc;
 	u32 fusectl1;
 
 	/* Read accelerator capabilities mask */
@@ -261,6 +275,14 @@ static u32 get_accel_cap(struct adf_accel_dev *accel_dev)
 		return capabilities_sym | capabilities_asym;
 	case SVC_DC:
 		return capabilities_dc;
+	case SVC_DCC:
+		/*
+		 * Sym capabilities are available for chaining operations,
+		 * but sym crypto instances cannot be supported
+		 */
+		capabilities_dcc = capabilities_dc | capabilities_sym;
+		capabilities_dcc &= ~ICP_ACCEL_CAPABILITIES_CRYPTO_SYMMETRIC;
+		return capabilities_dcc;
 	case SVC_SYM:
 		return capabilities_sym;
 	case SVC_ASYM:
@@ -286,6 +308,8 @@ static const u32 *adf_get_arbiter_mapping(struct adf_accel_dev *accel_dev)
 	switch (get_service_enabled(accel_dev)) {
 	case SVC_DC:
 		return thrd_to_arb_map_dc;
+	case SVC_DCC:
+		return thrd_to_arb_map_dcc;
 	default:
 		return default_thrd_to_arb_map;
 	}
@@ -383,6 +407,9 @@ static const char *uof_get_name(struct adf_accel_dev *accel_dev, u32 obj_num,
 	case SVC_DC:
 		id = adf_fw_dc_config[obj_num].obj;
 		break;
+	case SVC_DCC:
+		id = adf_fw_dcc_config[obj_num].obj;
+		break;
 	case SVC_SYM:
 		id = adf_fw_sym_config[obj_num].obj;
 		break;
@@ -429,6 +456,8 @@ static u32 uof_get_ae_mask(struct adf_accel_dev *accel_dev, u32 obj_num)
 		return adf_fw_cy_config[obj_num].ae_mask;
 	case SVC_DC:
 		return adf_fw_dc_config[obj_num].ae_mask;
+	case SVC_DCC:
+		return adf_fw_dcc_config[obj_num].ae_mask;
 	case SVC_CY2:
 		return adf_fw_cy_config[obj_num].ae_mask;
 	case SVC_SYM:
diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c b/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
index 204a00a204f2..90f5c1ca7b8d 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
@@ -279,6 +279,7 @@ int adf_gen4_dev_config(struct adf_accel_dev *accel_dev)
 		ret = adf_crypto_dev_config(accel_dev);
 		break;
 	case SVC_DC:
+	case SVC_DCC:
 		ret = adf_comp_dev_config(accel_dev);
 		break;
 	default:
diff --git a/drivers/crypto/intel/qat/qat_common/adf_admin.c b/drivers/crypto/intel/qat/qat_common/adf_admin.c
index a85f87f01ffe..556007218df7 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_admin.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_admin.c
@@ -8,6 +8,7 @@
 #include <linux/dma-mapping.h>
 #include "adf_accel_devices.h"
 #include "adf_common_drv.h"
+#include "adf_cfg.h"
 #include "adf_heartbeat.h"
 #include "icp_qat_fw_init_admin.h"
 
@@ -212,6 +213,17 @@ int adf_get_fw_timestamp(struct adf_accel_dev *accel_dev, u64 *timestamp)
 	return 0;
 }
 
+static int adf_set_chaining(struct adf_accel_dev *accel_dev)
+{
+	u32 ae_mask = GET_HW_DATA(accel_dev)->ae_mask;
+	struct icp_qat_fw_init_admin_resp resp = { };
+	struct icp_qat_fw_init_admin_req req = { };
+
+	req.cmd_id = ICP_QAT_FW_DC_CHAIN_INIT;
+
+	return adf_send_admin(accel_dev, &req, &resp, ae_mask);
+}
+
 static int adf_get_dc_capabilities(struct adf_accel_dev *accel_dev,
 				   u32 *capabilities)
 {
@@ -284,6 +296,19 @@ int adf_send_admin_hb_timer(struct adf_accel_dev *accel_dev, uint32_t ticks)
 	return adf_send_admin(accel_dev, &req, &resp, ae_mask);
 }
 
+static bool is_dcc_enabled(struct adf_accel_dev *accel_dev)
+{
+	char services[ADF_CFG_MAX_VAL_LEN_IN_BYTES] = {0};
+	int ret;
+
+	ret = adf_cfg_get_param_value(accel_dev, ADF_GENERAL_SEC,
+				      ADF_SERVICES_ENABLED, services);
+	if (ret)
+		return false;
+
+	return !strcmp(services, "dcc");
+}
+
 /**
  * adf_send_admin_init() - Function sends init message to FW
  * @accel_dev: Pointer to acceleration device.
@@ -297,6 +322,16 @@ int adf_send_admin_init(struct adf_accel_dev *accel_dev)
 	u32 dc_capabilities = 0;
 	int ret;
 
+	ret = adf_set_fw_constants(accel_dev);
+	if (ret)
+		return ret;
+
+	if (is_dcc_enabled(accel_dev)) {
+		ret = adf_set_chaining(accel_dev);
+		if (ret)
+			return ret;
+	}
+
 	ret = adf_get_dc_capabilities(accel_dev, &dc_capabilities);
 	if (ret) {
 		dev_err(&GET_DEV(accel_dev), "Cannot get dc capabilities\n");
@@ -304,10 +339,6 @@ int adf_send_admin_init(struct adf_accel_dev *accel_dev)
 	}
 	accel_dev->hw_device->extended_dc_capabilities = dc_capabilities;
 
-	ret = adf_set_fw_constants(accel_dev);
-	if (ret)
-		return ret;
-
 	return adf_init_ae(accel_dev);
 }
 EXPORT_SYMBOL_GPL(adf_send_admin_init);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_cfg_services.h b/drivers/crypto/intel/qat/qat_common/adf_cfg_services.h
index 7fcb3b8f148a..b353d40c5c6d 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_cfg_services.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_cfg_services.h
@@ -9,6 +9,7 @@ enum adf_services {
 	SVC_CY = 0,
 	SVC_CY2,
 	SVC_DC,
+	SVC_DCC,
 	SVC_SYM,
 	SVC_ASYM,
 	SVC_DC_ASYM,
@@ -21,6 +22,7 @@ static const char *const adf_cfg_services[] = {
 	[SVC_CY] = ADF_CFG_CY,
 	[SVC_CY2] = ADF_CFG_ASYM_SYM,
 	[SVC_DC] = ADF_CFG_DC,
+	[SVC_DCC] = ADF_CFG_DCC,
 	[SVC_SYM] = ADF_CFG_SYM,
 	[SVC_ASYM] = ADF_CFG_ASYM,
 	[SVC_DC_ASYM] = ADF_CFG_DC_ASYM,
diff --git a/drivers/crypto/intel/qat/qat_common/adf_cfg_strings.h b/drivers/crypto/intel/qat/qat_common/adf_cfg_strings.h
index 6066dc637352..322b76903a73 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_cfg_strings.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_cfg_strings.h
@@ -32,6 +32,7 @@
 #define ADF_CFG_DC_ASYM "dc;asym"
 #define ADF_CFG_SYM_DC "sym;dc"
 #define ADF_CFG_DC_SYM "dc;sym"
+#define ADF_CFG_DCC "dcc"
 #define ADF_SERVICES_ENABLED "ServicesEnabled"
 #define ADF_PM_IDLE_SUPPORT "PmIdleSupport"
 #define ADF_ETRMGR_COALESCING_ENABLED "InterruptCoalescingEnabled"
diff --git a/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h b/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h
index 5b2d2987aacf..9e5ce419d875 100644
--- a/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h
+++ b/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h
@@ -16,6 +16,7 @@ enum icp_qat_fw_init_admin_cmd_id {
 	ICP_QAT_FW_HEARTBEAT_SYNC = 7,
 	ICP_QAT_FW_HEARTBEAT_GET = 8,
 	ICP_QAT_FW_COMP_CAPABILITY_GET = 9,
+	ICP_QAT_FW_DC_CHAIN_INIT = 11,
 	ICP_QAT_FW_HEARTBEAT_TIMER_SET = 13,
 	ICP_QAT_FW_TIMER_GET = 19,
 	ICP_QAT_FW_CNV_STATS_GET = 20,
-- 
2.40.1


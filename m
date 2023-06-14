Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF3D72A08F
	for <lists+linux-crypto@lfdr.de>; Fri,  9 Jun 2023 18:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjFIQsu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 9 Jun 2023 12:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjFIQsp (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 9 Jun 2023 12:48:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7633A88
        for <linux-crypto@vger.kernel.org>; Fri,  9 Jun 2023 09:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686329322; x=1717865322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rAzGqJmUdmzJqq8gQp7Xyec7dSCYmZKjqDWGvK/1jLg=;
  b=fEr2n4ElQiNflbUYcW2s5RImt0ysdIXDH/Qq61r2qLtK4JTYyzQ/SBgt
   BRBF3FODMBjapbYSr7lLm1DXU8R6tz32pYas6flLH2gXvARTmq+Vlxyyy
   XDPYq3Gv/dilMmcnGeO1ftQWNIQOrRze2Ho4gfH3XUoaJB6xYWwrP/pU+
   GSbBIL1OoJK/BhU1++qNLfJHK+ee/JNBx4XUVOj2v3cJjdBEGNHynjQCA
   Skzn2b2n45en4//nT0Rv9uPzaMkCc5lbcA1b3UYJg/iCEbW/N93V5RauE
   sGJzLkLMH5tu/Dmytag6aQ/axCLt4Jb1NquUQ9jnT7OlBDyDna2UGG6BZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="337999103"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="337999103"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 09:48:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="957214199"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="957214199"
Received: from silpixa00400295.ir.intel.com ([10.237.213.194])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jun 2023 09:48:32 -0700
From:   Adam Guerin <adam.guerin@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Adam Guerin <adam.guerin@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4/4] crypto: qat - extend configuration for 4xxx
Date:   Fri,  9 Jun 2023 17:38:22 +0100
Message-Id: <20230609163821.6533-5-adam.guerin@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230609163821.6533-1-adam.guerin@intel.com>
References: <20230609163821.6533-1-adam.guerin@intel.com>
MIME-Version: 1.0
Organisation: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare, Ireland
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

A QAT GEN4 device can be currently configured for crypto (sym;asym) or
compression (dc).

This patch extends the configuration to support more variations of these
services, download the correct FW images on the device and report the
correct capabilities on the device based on the configured service.

The device can now be configured with the following services:
"sym", "asym", "dc", "sym;asym", "asym;sym", "sym;dc", "dc;sym",
"asym;dc", "dc;asym".

With this change, the configuration "sym", "asym", "sym;dc", "dc;sym",
"asym;dc", "dc;asym" will be accessible only via userspace, i.e. the driver
for those configurations will not register into the crypto framework.
Support for such configurations in kernel will be enabled in a later
patch.

The pairs "sym;asym" and "asym;sym" result in identical device config.
As do "sym;dc", "dc;sym", and "asym;dc", "dc;asym".

Signed-off-by: Adam Guerin <adam.guerin@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-driver-qat    |  11 ++
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     | 127 +++++++++++++++---
 drivers/crypto/intel/qat/qat_4xxx/adf_drv.c   |  33 +++++
 .../intel/qat/qat_common/adf_cfg_strings.h    |   7 +
 .../crypto/intel/qat/qat_common/adf_sysfs.c   |   7 +
 5 files changed, 163 insertions(+), 22 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-qat b/Documentation/ABI/testing/sysfs-driver-qat
index 087842b1969e..e6d427c41bee 100644
--- a/Documentation/ABI/testing/sysfs-driver-qat
+++ b/Documentation/ABI/testing/sysfs-driver-qat
@@ -27,7 +27,18 @@ Description:	(RW) Reports the current configuration of the QAT device.
 
 		* sym;asym: the device is configured for running crypto
 		  services
+		* asym;sym: identical to sym;asym
 		* dc: the device is configured for running compression services
+		* sym: the device is configured for running symmetric crypto
+		  services
+		* asym: the device is configured for running asymmetric crypto
+		  services
+		* asym;dc: the device is configured for running asymmetric
+		  crypto services and compression services
+		* dc;asym: identical to asym;dc
+		* sym;dc: the device is configured for running symmetric crypto
+		  services and compression services
+		* dc;sym: identical to sym;dc
 
 		It is possible to set the configuration only if the device
 		is in the `down` state (see /sys/bus/pci/devices/<BDF>/qat/state)
diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
index bd55c938f7eb..831d460bc503 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -50,10 +50,38 @@ static const struct adf_fw_config adf_fw_dc_config[] = {
 	{0x100, ADF_FW_ADMIN_OBJ},
 };
 
+static const struct adf_fw_config adf_fw_sym_config[] = {
+	{0xF0, ADF_FW_SYM_OBJ},
+	{0xF, ADF_FW_SYM_OBJ},
+	{0x100, ADF_FW_ADMIN_OBJ},
+};
+
+static const struct adf_fw_config adf_fw_asym_config[] = {
+	{0xF0, ADF_FW_ASYM_OBJ},
+	{0xF, ADF_FW_ASYM_OBJ},
+	{0x100, ADF_FW_ADMIN_OBJ},
+};
+
+static const struct adf_fw_config adf_fw_asym_dc_config[] = {
+	{0xF0, ADF_FW_ASYM_OBJ},
+	{0xF, ADF_FW_DC_OBJ},
+	{0x100, ADF_FW_ADMIN_OBJ},
+};
+
+static const struct adf_fw_config adf_fw_sym_dc_config[] = {
+	{0xF0, ADF_FW_SYM_OBJ},
+	{0xF, ADF_FW_DC_OBJ},
+	{0x100, ADF_FW_ADMIN_OBJ},
+};
+
 static_assert(ARRAY_SIZE(adf_fw_cy_config) == ARRAY_SIZE(adf_fw_dc_config));
+static_assert(ARRAY_SIZE(adf_fw_cy_config) == ARRAY_SIZE(adf_fw_sym_config));
+static_assert(ARRAY_SIZE(adf_fw_cy_config) == ARRAY_SIZE(adf_fw_asym_config));
+static_assert(ARRAY_SIZE(adf_fw_cy_config) == ARRAY_SIZE(adf_fw_asym_dc_config));
+static_assert(ARRAY_SIZE(adf_fw_cy_config) == ARRAY_SIZE(adf_fw_sym_dc_config));
 
 /* Worker thread to service arbiter mappings */
-static const u32 thrd_to_arb_map_cy[ADF_4XXX_MAX_ACCELENGINES] = {
+static const u32 default_thrd_to_arb_map[ADF_4XXX_MAX_ACCELENGINES] = {
 	0x5555555, 0x5555555, 0x5555555, 0x5555555,
 	0xAAAAAAA, 0xAAAAAAA, 0xAAAAAAA, 0xAAAAAAA,
 	0x0
@@ -73,12 +101,26 @@ static struct adf_hw_device_class adf_4xxx_class = {
 
 enum dev_services {
 	SVC_CY = 0,
+	SVC_CY2,
 	SVC_DC,
+	SVC_SYM,
+	SVC_ASYM,
+	SVC_DC_ASYM,
+	SVC_ASYM_DC,
+	SVC_DC_SYM,
+	SVC_SYM_DC,
 };
 
 static const char *const dev_cfg_services[] = {
 	[SVC_CY] = ADF_CFG_CY,
+	[SVC_CY2] = ADF_CFG_ASYM_SYM,
 	[SVC_DC] = ADF_CFG_DC,
+	[SVC_SYM] = ADF_CFG_SYM,
+	[SVC_ASYM] = ADF_CFG_ASYM,
+	[SVC_DC_ASYM] = ADF_CFG_DC_ASYM,
+	[SVC_ASYM_DC] = ADF_CFG_ASYM_DC,
+	[SVC_DC_SYM] = ADF_CFG_DC_SYM,
+	[SVC_SYM_DC] = ADF_CFG_SYM_DC,
 };
 
 static int get_service_enabled(struct adf_accel_dev *accel_dev)
@@ -168,45 +210,50 @@ static void set_msix_default_rttable(struct adf_accel_dev *accel_dev)
 static u32 get_accel_cap(struct adf_accel_dev *accel_dev)
 {
 	struct pci_dev *pdev = accel_dev->accel_pci_dev.pci_dev;
-	u32 capabilities_cy, capabilities_dc;
+	u32 capabilities_sym, capabilities_asym, capabilities_dc;
 	u32 fusectl1;
 
 	/* Read accelerator capabilities mask */
 	pci_read_config_dword(pdev, ADF_4XXX_FUSECTL1_OFFSET, &fusectl1);
 
-	capabilities_cy = ICP_ACCEL_CAPABILITIES_CRYPTO_SYMMETRIC |
-			  ICP_ACCEL_CAPABILITIES_CRYPTO_ASYMMETRIC |
+	capabilities_sym = ICP_ACCEL_CAPABILITIES_CRYPTO_SYMMETRIC |
 			  ICP_ACCEL_CAPABILITIES_CIPHER |
 			  ICP_ACCEL_CAPABILITIES_AUTHENTICATION |
 			  ICP_ACCEL_CAPABILITIES_SHA3 |
 			  ICP_ACCEL_CAPABILITIES_SHA3_EXT |
 			  ICP_ACCEL_CAPABILITIES_HKDF |
-			  ICP_ACCEL_CAPABILITIES_ECEDMONT |
 			  ICP_ACCEL_CAPABILITIES_CHACHA_POLY |
 			  ICP_ACCEL_CAPABILITIES_AESGCM_SPC |
 			  ICP_ACCEL_CAPABILITIES_AES_V2;
 
 	/* A set bit in fusectl1 means the feature is OFF in this SKU */
 	if (fusectl1 & ICP_ACCEL_4XXX_MASK_CIPHER_SLICE) {
-		capabilities_cy &= ~ICP_ACCEL_CAPABILITIES_CRYPTO_SYMMETRIC;
-		capabilities_cy &= ~ICP_ACCEL_CAPABILITIES_HKDF;
-		capabilities_cy &= ~ICP_ACCEL_CAPABILITIES_CIPHER;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_CRYPTO_SYMMETRIC;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_HKDF;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_CIPHER;
 	}
+
 	if (fusectl1 & ICP_ACCEL_4XXX_MASK_UCS_SLICE) {
-		capabilities_cy &= ~ICP_ACCEL_CAPABILITIES_CHACHA_POLY;
-		capabilities_cy &= ~ICP_ACCEL_CAPABILITIES_AESGCM_SPC;
-		capabilities_cy &= ~ICP_ACCEL_CAPABILITIES_AES_V2;
-		capabilities_cy &= ~ICP_ACCEL_CAPABILITIES_CIPHER;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_CHACHA_POLY;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_AESGCM_SPC;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_AES_V2;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_CIPHER;
 	}
+
 	if (fusectl1 & ICP_ACCEL_4XXX_MASK_AUTH_SLICE) {
-		capabilities_cy &= ~ICP_ACCEL_CAPABILITIES_AUTHENTICATION;
-		capabilities_cy &= ~ICP_ACCEL_CAPABILITIES_SHA3;
-		capabilities_cy &= ~ICP_ACCEL_CAPABILITIES_SHA3_EXT;
-		capabilities_cy &= ~ICP_ACCEL_CAPABILITIES_CIPHER;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_AUTHENTICATION;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_SHA3;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_SHA3_EXT;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_CIPHER;
 	}
+
+	capabilities_asym = ICP_ACCEL_CAPABILITIES_CRYPTO_ASYMMETRIC |
+			  ICP_ACCEL_CAPABILITIES_CIPHER |
+			  ICP_ACCEL_CAPABILITIES_ECEDMONT;
+
 	if (fusectl1 & ICP_ACCEL_4XXX_MASK_PKE_SLICE) {
-		capabilities_cy &= ~ICP_ACCEL_CAPABILITIES_CRYPTO_ASYMMETRIC;
-		capabilities_cy &= ~ICP_ACCEL_CAPABILITIES_ECEDMONT;
+		capabilities_asym &= ~ICP_ACCEL_CAPABILITIES_CRYPTO_ASYMMETRIC;
+		capabilities_asym &= ~ICP_ACCEL_CAPABILITIES_ECEDMONT;
 	}
 
 	capabilities_dc = ICP_ACCEL_CAPABILITIES_COMPRESSION |
@@ -223,9 +270,20 @@ static u32 get_accel_cap(struct adf_accel_dev *accel_dev)
 
 	switch (get_service_enabled(accel_dev)) {
 	case SVC_CY:
-		return capabilities_cy;
+	case SVC_CY2:
+		return capabilities_sym | capabilities_asym;
 	case SVC_DC:
 		return capabilities_dc;
+	case SVC_SYM:
+		return capabilities_sym;
+	case SVC_ASYM:
+		return capabilities_asym;
+	case SVC_ASYM_DC:
+	case SVC_DC_ASYM:
+		return capabilities_asym | capabilities_dc;
+	case SVC_SYM_DC:
+	case SVC_DC_SYM:
+		return capabilities_sym | capabilities_dc;
 	default:
 		return 0;
 	}
@@ -239,12 +297,10 @@ static enum dev_sku_info get_sku(struct adf_hw_device_data *self)
 static const u32 *adf_get_arbiter_mapping(struct adf_accel_dev *accel_dev)
 {
 	switch (get_service_enabled(accel_dev)) {
-	case SVC_CY:
-		return thrd_to_arb_map_cy;
 	case SVC_DC:
 		return thrd_to_arb_map_dc;
 	default:
-		return NULL;
+		return default_thrd_to_arb_map;
 	}
 }
 
@@ -326,11 +382,26 @@ static const char *uof_get_name(struct adf_accel_dev *accel_dev, u32 obj_num,
 
 	switch (get_service_enabled(accel_dev)) {
 	case SVC_CY:
+	case SVC_CY2:
 		id = adf_fw_cy_config[obj_num].obj;
 		break;
 	case SVC_DC:
 		id = adf_fw_dc_config[obj_num].obj;
 		break;
+	case SVC_SYM:
+		id = adf_fw_sym_config[obj_num].obj;
+		break;
+	case SVC_ASYM:
+		id =  adf_fw_asym_config[obj_num].obj;
+		break;
+	case SVC_ASYM_DC:
+	case SVC_DC_ASYM:
+		id = adf_fw_asym_dc_config[obj_num].obj;
+		break;
+	case SVC_SYM_DC:
+	case SVC_DC_SYM:
+		id = adf_fw_sym_dc_config[obj_num].obj;
+		break;
 	default:
 		id = -EINVAL;
 		break;
@@ -363,6 +434,18 @@ static u32 uof_get_ae_mask(struct adf_accel_dev *accel_dev, u32 obj_num)
 		return adf_fw_cy_config[obj_num].ae_mask;
 	case SVC_DC:
 		return adf_fw_dc_config[obj_num].ae_mask;
+	case SVC_CY2:
+		return adf_fw_cy_config[obj_num].ae_mask;
+	case SVC_SYM:
+		return adf_fw_sym_config[obj_num].ae_mask;
+	case SVC_ASYM:
+		return adf_fw_asym_config[obj_num].ae_mask;
+	case SVC_ASYM_DC:
+	case SVC_DC_ASYM:
+		return adf_fw_asym_dc_config[obj_num].ae_mask;
+	case SVC_SYM_DC:
+	case SVC_DC_SYM:
+		return adf_fw_sym_dc_config[obj_num].ae_mask;
 	default:
 		return 0;
 	}
diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c b/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
index 3ecc19087780..1a15600361d0 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
@@ -25,11 +25,25 @@ MODULE_DEVICE_TABLE(pci, adf_pci_tbl);
 enum configs {
 	DEV_CFG_CY = 0,
 	DEV_CFG_DC,
+	DEV_CFG_SYM,
+	DEV_CFG_ASYM,
+	DEV_CFG_ASYM_SYM,
+	DEV_CFG_ASYM_DC,
+	DEV_CFG_DC_ASYM,
+	DEV_CFG_SYM_DC,
+	DEV_CFG_DC_SYM,
 };
 
 static const char * const services_operations[] = {
 	ADF_CFG_CY,
 	ADF_CFG_DC,
+	ADF_CFG_SYM,
+	ADF_CFG_ASYM,
+	ADF_CFG_ASYM_SYM,
+	ADF_CFG_ASYM_DC,
+	ADF_CFG_DC_ASYM,
+	ADF_CFG_SYM_DC,
+	ADF_CFG_DC_SYM,
 };
 
 static void adf_cleanup_accel(struct adf_accel_dev *accel_dev)
@@ -242,6 +256,21 @@ static int adf_comp_dev_config(struct adf_accel_dev *accel_dev)
 	return ret;
 }
 
+static int adf_no_dev_config(struct adf_accel_dev *accel_dev)
+{
+	unsigned long val;
+	int ret;
+
+	val = 0;
+	ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC, ADF_NUM_DC,
+					  &val, ADF_DEC);
+	if (ret)
+		return ret;
+
+	return adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC, ADF_NUM_CY,
+					  &val, ADF_DEC);
+}
+
 int adf_gen4_dev_config(struct adf_accel_dev *accel_dev)
 {
 	char services[ADF_CFG_MAX_VAL_LEN_IN_BYTES] = {0};
@@ -266,11 +295,15 @@ int adf_gen4_dev_config(struct adf_accel_dev *accel_dev)
 
 	switch (ret) {
 	case DEV_CFG_CY:
+	case DEV_CFG_ASYM_SYM:
 		ret = adf_crypto_dev_config(accel_dev);
 		break;
 	case DEV_CFG_DC:
 		ret = adf_comp_dev_config(accel_dev);
 		break;
+	default:
+		ret = adf_no_dev_config(accel_dev);
+		break;
 	}
 
 	if (ret)
diff --git a/drivers/crypto/intel/qat/qat_common/adf_cfg_strings.h b/drivers/crypto/intel/qat/qat_common/adf_cfg_strings.h
index 5d8c3bdb258c..b6a9abe6d98c 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_cfg_strings.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_cfg_strings.h
@@ -25,6 +25,13 @@
 #define ADF_DC "Dc"
 #define ADF_CFG_DC "dc"
 #define ADF_CFG_CY "sym;asym"
+#define ADF_CFG_SYM "sym"
+#define ADF_CFG_ASYM "asym"
+#define ADF_CFG_ASYM_SYM "asym;sym"
+#define ADF_CFG_ASYM_DC "asym;dc"
+#define ADF_CFG_DC_ASYM "dc;asym"
+#define ADF_CFG_SYM_DC "sym;dc"
+#define ADF_CFG_DC_SYM "dc;sym"
 #define ADF_SERVICES_ENABLED "ServicesEnabled"
 #define ADF_ETRMGR_COALESCING_ENABLED "InterruptCoalescingEnabled"
 #define ADF_ETRMGR_COALESCING_ENABLED_FORMAT \
diff --git a/drivers/crypto/intel/qat/qat_common/adf_sysfs.c b/drivers/crypto/intel/qat/qat_common/adf_sysfs.c
index 3eb6611ab1b1..b2ec92322dd8 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_sysfs.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_sysfs.c
@@ -78,6 +78,13 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
 static const char * const services_operations[] = {
 	ADF_CFG_CY,
 	ADF_CFG_DC,
+	ADF_CFG_SYM,
+	ADF_CFG_ASYM,
+	ADF_CFG_ASYM_SYM,
+	ADF_CFG_ASYM_DC,
+	ADF_CFG_DC_ASYM,
+	ADF_CFG_SYM_DC,
+	ADF_CFG_DC_SYM,
 };
 
 static ssize_t cfg_services_show(struct device *dev, struct device_attribute *attr,
-- 
2.40.1


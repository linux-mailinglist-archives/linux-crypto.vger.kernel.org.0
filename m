Return-Path: <linux-crypto+bounces-861-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B2E814511
	for <lists+linux-crypto@lfdr.de>; Fri, 15 Dec 2023 11:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60611C2276D
	for <lists+linux-crypto@lfdr.de>; Fri, 15 Dec 2023 10:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94D61944D;
	Fri, 15 Dec 2023 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CsQ2E9cZ"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B8A19441
	for <linux-crypto@vger.kernel.org>; Fri, 15 Dec 2023 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702634620; x=1734170620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sxdG1M7G8tPOTTQeVRFwkd/xzpuwr1q4eyta0OshUkU=;
  b=CsQ2E9cZrcxpV006fpE3lqkfhzK45g7q4XcGykfgaW8x/MezmTIWuLju
   23YoCAR4hAuM1onee5AtGgV756otLRmeYoVS0NdGooTn++nK4i5KS6Lnn
   Q0xUjGVF1IJtt3QpoopLts1uUiObq7OMQJ3TaWNDp1NFBEgmo771lpn23
   T9bBJI1buF/XJ1so4mUqtwuGwIi14YS9WQuJ23iZD0xhAlu37pueu3+E/
   4zKfrEP46tVz1UQtuL+1sL2kxfPyxnJeig7D0aXrRmQcnlR0ydyzW5mgL
   NbhFa8K4qfdpvzWYNGHEh04VgLItVUQRkP/AZlnU15lYcSfWUmGXdDnYB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="374759874"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="374759874"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 02:03:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="845074137"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="845074137"
Received: from qat-wangjie-342.sh.intel.com ([10.67.115.171])
  by fmsmga004.fm.intel.com with ESMTP; 15 Dec 2023 02:03:37 -0800
From: Jie Wang <jie.wang@intel.com>
To: herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org,
	qat-linux@intel.com
Subject: [PATCH 5/5] crypto: qat - add support for 420xx devices
Date: Fri, 15 Dec 2023 05:01:48 -0500
Message-Id: <20231215100147.1703641-6-jie.wang@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231215100147.1703641-1-jie.wang@intel.com>
References: <20231215100147.1703641-1-jie.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Asia-Pacific Research & Development Ltd. - No. 880, Zi Xing, Road, Shanghai Zizhu Science Park, Shanghai, 200241, PRC
Content-Transfer-Encoding: 8bit

Add support for 420xx devices by including a new device driver that
supports such devices, updates to the firmware loader and capabilities.

Compared to 4xxx devices, 420xx devices have more acceleration engines
(16 service engines and 1 admin) and support the wireless cipher
algorithms ZUC and Snow 3G.

Signed-off-by: Jie Wang <jie.wang@intel.com>
Co-developed-by: Dong Xie <dong.xie@intel.com>
Signed-off-by: Dong Xie <dong.xie@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/intel/qat/Kconfig              |  11 +
 drivers/crypto/intel/qat/Makefile             |   1 +
 drivers/crypto/intel/qat/qat_420xx/Makefile   |   4 +
 .../intel/qat/qat_420xx/adf_420xx_hw_data.c   | 552 ++++++++++++++++++
 .../intel/qat/qat_420xx/adf_420xx_hw_data.h   |  55 ++
 drivers/crypto/intel/qat/qat_420xx/adf_drv.c  | 202 +++++++
 .../intel/qat/qat_common/adf_accel_devices.h  |   3 +
 .../intel/qat/qat_common/adf_cfg_common.h     |   1 +
 .../intel/qat/qat_common/adf_gen4_hw_data.h   |   2 +
 .../crypto/intel/qat/qat_common/icp_qat_hw.h  |  14 +-
 .../intel/qat/qat_common/icp_qat_uclo.h       |   2 +-
 drivers/crypto/intel/qat/qat_common/qat_hal.c |   6 +-
 .../crypto/intel/qat/qat_common/qat_uclo.c    |   1 +
 13 files changed, 849 insertions(+), 5 deletions(-)
 create mode 100644 drivers/crypto/intel/qat/qat_420xx/Makefile
 create mode 100644 drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
 create mode 100644 drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.h
 create mode 100644 drivers/crypto/intel/qat/qat_420xx/adf_drv.c

diff --git a/drivers/crypto/intel/qat/Kconfig b/drivers/crypto/intel/qat/Kconfig
index 1220cc86f910..c120f6715a09 100644
--- a/drivers/crypto/intel/qat/Kconfig
+++ b/drivers/crypto/intel/qat/Kconfig
@@ -59,6 +59,17 @@ config CRYPTO_DEV_QAT_4XXX
 	  To compile this as a module, choose M here: the module
 	  will be called qat_4xxx.
 
+config CRYPTO_DEV_QAT_420XX
+	tristate "Support for Intel(R) QAT_420XX"
+	depends on PCI && (!CPU_BIG_ENDIAN || COMPILE_TEST)
+	select CRYPTO_DEV_QAT
+	help
+	  Support for Intel(R) QuickAssist Technology QAT_420xx
+	  for accelerating crypto and compression workloads.
+
+	  To compile this as a module, choose M here: the module
+	  will be called qat_420xx.
+
 config CRYPTO_DEV_QAT_DH895xCCVF
 	tristate "Support for Intel(R) DH895xCC Virtual Function"
 	depends on PCI && (!CPU_BIG_ENDIAN || COMPILE_TEST)
diff --git a/drivers/crypto/intel/qat/Makefile b/drivers/crypto/intel/qat/Makefile
index 258c8a626ce0..235b69f4f3f7 100644
--- a/drivers/crypto/intel/qat/Makefile
+++ b/drivers/crypto/intel/qat/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_CRYPTO_DEV_QAT_DH895xCC) += qat_dh895xcc/
 obj-$(CONFIG_CRYPTO_DEV_QAT_C3XXX) += qat_c3xxx/
 obj-$(CONFIG_CRYPTO_DEV_QAT_C62X) += qat_c62x/
 obj-$(CONFIG_CRYPTO_DEV_QAT_4XXX) += qat_4xxx/
+obj-$(CONFIG_CRYPTO_DEV_QAT_420XX) += qat_420xx/
 obj-$(CONFIG_CRYPTO_DEV_QAT_DH895xCCVF) += qat_dh895xccvf/
 obj-$(CONFIG_CRYPTO_DEV_QAT_C3XXXVF) += qat_c3xxxvf/
 obj-$(CONFIG_CRYPTO_DEV_QAT_C62XVF) += qat_c62xvf/
diff --git a/drivers/crypto/intel/qat/qat_420xx/Makefile b/drivers/crypto/intel/qat/qat_420xx/Makefile
new file mode 100644
index 000000000000..a90fbe00b3c8
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_420xx/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+ccflags-y := -I $(srctree)/$(src)/../qat_common
+obj-$(CONFIG_CRYPTO_DEV_QAT_420XX) += qat_420xx.o
+qat_420xx-objs := adf_drv.o adf_420xx_hw_data.o
diff --git a/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
new file mode 100644
index 000000000000..d296eb18db3c
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
@@ -0,0 +1,552 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation */
+#include <linux/iopoll.h>
+#include <adf_accel_devices.h>
+#include <adf_admin.h>
+#include <adf_cfg.h>
+#include <adf_cfg_services.h>
+#include <adf_clock.h>
+#include <adf_common_drv.h>
+#include <adf_fw_config.h>
+#include <adf_gen4_config.h>
+#include <adf_gen4_dc.h>
+#include <adf_gen4_hw_data.h>
+#include <adf_gen4_pfvf.h>
+#include <adf_gen4_pm.h>
+#include <adf_gen4_ras.h>
+#include <adf_gen4_timer.h>
+#include "adf_420xx_hw_data.h"
+#include "icp_qat_hw.h"
+
+#define ADF_AE_GROUP_0		GENMASK(3, 0)
+#define ADF_AE_GROUP_1		GENMASK(7, 4)
+#define ADF_AE_GROUP_2		GENMASK(11, 8)
+#define ADF_AE_GROUP_3		GENMASK(15, 12)
+#define ADF_AE_GROUP_4		BIT(16)
+
+static const char * const adf_420xx_fw_objs[] = {
+	[ADF_FW_SYM_OBJ] =  ADF_420XX_SYM_OBJ,
+	[ADF_FW_ASYM_OBJ] =  ADF_420XX_ASYM_OBJ,
+	[ADF_FW_DC_OBJ] =  ADF_420XX_DC_OBJ,
+	[ADF_FW_ADMIN_OBJ] = ADF_420XX_ADMIN_OBJ,
+};
+
+static const struct adf_fw_config adf_fw_cy_config[] = {
+	{ADF_AE_GROUP_3, ADF_FW_SYM_OBJ},
+	{ADF_AE_GROUP_2, ADF_FW_ASYM_OBJ},
+	{ADF_AE_GROUP_1, ADF_FW_SYM_OBJ},
+	{ADF_AE_GROUP_0, ADF_FW_ASYM_OBJ},
+	{ADF_AE_GROUP_4, ADF_FW_ADMIN_OBJ},
+};
+
+static const struct adf_fw_config adf_fw_dc_config[] = {
+	{ADF_AE_GROUP_1, ADF_FW_DC_OBJ},
+	{ADF_AE_GROUP_0, ADF_FW_DC_OBJ},
+	{ADF_AE_GROUP_4, ADF_FW_ADMIN_OBJ},
+};
+
+static const struct adf_fw_config adf_fw_sym_config[] = {
+	{ADF_AE_GROUP_3, ADF_FW_SYM_OBJ},
+	{ADF_AE_GROUP_2, ADF_FW_SYM_OBJ},
+	{ADF_AE_GROUP_1, ADF_FW_SYM_OBJ},
+	{ADF_AE_GROUP_0, ADF_FW_SYM_OBJ},
+	{ADF_AE_GROUP_4, ADF_FW_ADMIN_OBJ},
+};
+
+static const struct adf_fw_config adf_fw_asym_config[] = {
+	{ADF_AE_GROUP_3, ADF_FW_ASYM_OBJ},
+	{ADF_AE_GROUP_2, ADF_FW_ASYM_OBJ},
+	{ADF_AE_GROUP_1, ADF_FW_ASYM_OBJ},
+	{ADF_AE_GROUP_0, ADF_FW_ASYM_OBJ},
+	{ADF_AE_GROUP_4, ADF_FW_ADMIN_OBJ},
+};
+
+static const struct adf_fw_config adf_fw_asym_dc_config[] = {
+	{ADF_AE_GROUP_3, ADF_FW_ASYM_OBJ},
+	{ADF_AE_GROUP_2, ADF_FW_ASYM_OBJ},
+	{ADF_AE_GROUP_1, ADF_FW_ASYM_OBJ},
+	{ADF_AE_GROUP_0, ADF_FW_DC_OBJ},
+	{ADF_AE_GROUP_4, ADF_FW_ADMIN_OBJ},
+};
+
+static const struct adf_fw_config adf_fw_sym_dc_config[] = {
+	{ADF_AE_GROUP_2, ADF_FW_SYM_OBJ},
+	{ADF_AE_GROUP_1, ADF_FW_SYM_OBJ},
+	{ADF_AE_GROUP_0, ADF_FW_DC_OBJ},
+	{ADF_AE_GROUP_4, ADF_FW_ADMIN_OBJ},
+};
+
+static const struct adf_fw_config adf_fw_dcc_config[] = {
+	{ADF_AE_GROUP_1, ADF_FW_DC_OBJ},
+	{ADF_AE_GROUP_0, ADF_FW_SYM_OBJ},
+	{ADF_AE_GROUP_4, ADF_FW_ADMIN_OBJ},
+};
+
+/* Worker thread to service arbiter mappings */
+static const u32 default_thrd_to_arb_map[ADF_420XX_MAX_ACCELENGINES] = {
+	0x00000055, 0x00000055, 0x00000055, 0x00000055,
+	0x0000AAAA, 0x0000AAAA, 0x0000AAAA, 0x0000AAAA,
+	0x00000055, 0x00000055, 0x00000055, 0x00000055,
+	0x0000AAAA, 0x0000AAAA, 0x0000AAAA, 0x0000AAAA,
+	0x0
+};
+
+static const u32 thrd_to_arb_map_asym[ADF_420XX_MAX_ACCELENGINES] = {
+	0x000000FF, 0x000000FF, 0x000000FF, 0x000000FF,
+	0x000000FF, 0x000000FF, 0x000000FF, 0x000000FF,
+	0x000000FF, 0x000000FF, 0x000000FF, 0x000000FF,
+	0x000000FF, 0x000000FF, 0x000000FF, 0x000000FF,
+	0x0
+};
+
+static const u32 thrd_to_arb_map_sym[ADF_420XX_MAX_ACCELENGINES] = {
+	0x0000FFFF, 0x0000FFFF, 0x0000FFFF, 0x0000FFFF,
+	0x0000FFFF, 0x0000FFFF, 0x0000FFFF, 0x0000FFFF,
+	0x0000FFFF, 0x0000FFFF, 0x0000FFFF, 0x0000FFFF,
+	0x0000FFFF, 0x0000FFFF, 0x0000FFFF, 0x0000FFFF,
+	0x0
+};
+
+static const u32 thrd_to_arb_map_asym_dc[ADF_420XX_MAX_ACCELENGINES] = {
+	0x00000055, 0x00000055, 0x00000055, 0x00000055,
+	0x000000AA, 0x000000AA, 0x000000AA, 0x000000AA,
+	0x000000AA, 0x000000AA, 0x000000AA, 0x000000AA,
+	0x000000AA, 0x000000AA, 0x000000AA, 0x000000AA,
+	0x0
+};
+
+static const u32 thrd_to_arb_map_sym_dc[ADF_420XX_MAX_ACCELENGINES] = {
+	0x00000055, 0x00000055, 0x00000055, 0x00000055,
+	0x0000AAAA, 0x0000AAAA, 0x0000AAAA, 0x0000AAAA,
+	0x0000AAAA, 0x0000AAAA, 0x0000AAAA, 0x0000AAAA,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0
+};
+
+static const u32 thrd_to_arb_map_dc[ADF_420XX_MAX_ACCELENGINES] = {
+	0x000000FF, 0x000000FF, 0x000000FF, 0x000000FF,
+	0x000000FF, 0x000000FF, 0x000000FF, 0x000000FF,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0
+};
+
+static const u32 thrd_to_arb_map_dcc[ADF_420XX_MAX_ACCELENGINES] = {
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0000FFFF, 0x0000FFFF, 0x0000FFFF, 0x0000FFFF,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0
+};
+
+static struct adf_hw_device_class adf_420xx_class = {
+	.name = ADF_420XX_DEVICE_NAME,
+	.type = DEV_420XX,
+	.instances = 0,
+};
+
+static u32 get_ae_mask(struct adf_hw_device_data *self)
+{
+	u32 me_disable = self->fuses;
+
+	return ~me_disable & ADF_420XX_ACCELENGINES_MASK;
+}
+
+static u32 uof_get_num_objs(struct adf_accel_dev *accel_dev)
+{
+	switch (adf_get_service_enabled(accel_dev)) {
+	case SVC_CY:
+	case SVC_CY2:
+		return ARRAY_SIZE(adf_fw_cy_config);
+	case SVC_DC:
+		return ARRAY_SIZE(adf_fw_dc_config);
+	case SVC_DCC:
+		return ARRAY_SIZE(adf_fw_dcc_config);
+	case SVC_SYM:
+		return ARRAY_SIZE(adf_fw_sym_config);
+	case SVC_ASYM:
+		return ARRAY_SIZE(adf_fw_asym_config);
+	case SVC_ASYM_DC:
+	case SVC_DC_ASYM:
+		return ARRAY_SIZE(adf_fw_asym_dc_config);
+	case SVC_SYM_DC:
+	case SVC_DC_SYM:
+		return ARRAY_SIZE(adf_fw_sym_dc_config);
+	default:
+		return 0;
+	}
+}
+
+static const struct adf_fw_config *get_fw_config(struct adf_accel_dev *accel_dev)
+{
+	switch (adf_get_service_enabled(accel_dev)) {
+	case SVC_CY:
+	case SVC_CY2:
+		return adf_fw_cy_config;
+	case SVC_DC:
+		return adf_fw_dc_config;
+	case SVC_DCC:
+		return adf_fw_dcc_config;
+	case SVC_SYM:
+		return adf_fw_sym_config;
+	case SVC_ASYM:
+		return adf_fw_asym_config;
+	case SVC_ASYM_DC:
+	case SVC_DC_ASYM:
+		return adf_fw_asym_dc_config;
+	case SVC_SYM_DC:
+	case SVC_DC_SYM:
+		return adf_fw_sym_dc_config;
+	default:
+		return NULL;
+	}
+}
+
+static void update_ae_mask(struct adf_accel_dev *accel_dev)
+{
+	struct adf_hw_device_data *hw_data = GET_HW_DATA(accel_dev);
+	const struct adf_fw_config *fw_config;
+	u32 config_ae_mask = 0;
+	u32 ae_mask, num_objs;
+	int i;
+
+	ae_mask = get_ae_mask(hw_data);
+
+	/* Modify the AE mask based on the firmware configuration loaded */
+	fw_config = get_fw_config(accel_dev);
+	num_objs = uof_get_num_objs(accel_dev);
+
+	config_ae_mask |= ADF_420XX_ADMIN_AE_MASK;
+	for (i = 0; i < num_objs; i++)
+		config_ae_mask |= fw_config[i].ae_mask;
+
+	hw_data->ae_mask = ae_mask & config_ae_mask;
+}
+
+static u32 get_accel_cap(struct adf_accel_dev *accel_dev)
+{
+	u32 capabilities_sym, capabilities_asym, capabilities_dc;
+	struct pci_dev *pdev = accel_dev->accel_pci_dev.pci_dev;
+	u32 capabilities_dcc;
+	u32 fusectl1;
+
+	/* As a side effect, update ae_mask based on configuration */
+	update_ae_mask(accel_dev);
+
+	/* Read accelerator capabilities mask */
+	pci_read_config_dword(pdev, ADF_GEN4_FUSECTL1_OFFSET, &fusectl1);
+
+	capabilities_sym = ICP_ACCEL_CAPABILITIES_CRYPTO_SYMMETRIC |
+			  ICP_ACCEL_CAPABILITIES_CIPHER |
+			  ICP_ACCEL_CAPABILITIES_AUTHENTICATION |
+			  ICP_ACCEL_CAPABILITIES_SHA3 |
+			  ICP_ACCEL_CAPABILITIES_SHA3_EXT |
+			  ICP_ACCEL_CAPABILITIES_HKDF |
+			  ICP_ACCEL_CAPABILITIES_CHACHA_POLY |
+			  ICP_ACCEL_CAPABILITIES_AESGCM_SPC |
+			  ICP_ACCEL_CAPABILITIES_SM3 |
+			  ICP_ACCEL_CAPABILITIES_SM4 |
+			  ICP_ACCEL_CAPABILITIES_AES_V2 |
+			  ICP_ACCEL_CAPABILITIES_ZUC |
+			  ICP_ACCEL_CAPABILITIES_ZUC_256 |
+			  ICP_ACCEL_CAPABILITIES_WIRELESS_CRYPTO_EXT |
+			  ICP_ACCEL_CAPABILITIES_EXT_ALGCHAIN;
+
+	/* A set bit in fusectl1 means the feature is OFF in this SKU */
+	if (fusectl1 & ICP_ACCEL_GEN4_MASK_CIPHER_SLICE) {
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_CRYPTO_SYMMETRIC;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_HKDF;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_CIPHER;
+	}
+
+	if (fusectl1 & ICP_ACCEL_GEN4_MASK_UCS_SLICE) {
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_CHACHA_POLY;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_AESGCM_SPC;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_AES_V2;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_CIPHER;
+	}
+
+	if (fusectl1 & ICP_ACCEL_GEN4_MASK_AUTH_SLICE) {
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_AUTHENTICATION;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_SHA3;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_SHA3_EXT;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_CIPHER;
+	}
+
+	if (fusectl1 & ICP_ACCEL_GEN4_MASK_SMX_SLICE) {
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_SM3;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_SM4;
+	}
+
+	if (fusectl1 & ICP_ACCEL_GEN4_MASK_WCP_WAT_SLICE) {
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_ZUC;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_ZUC_256;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_WIRELESS_CRYPTO_EXT;
+	}
+
+	if (fusectl1 & ICP_ACCEL_GEN4_MASK_EIA3_SLICE) {
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_ZUC;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_ZUC_256;
+	}
+
+	if (fusectl1 & ICP_ACCEL_GEN4_MASK_ZUC_256_SLICE)
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_ZUC_256;
+
+	capabilities_asym = ICP_ACCEL_CAPABILITIES_CRYPTO_ASYMMETRIC |
+			  ICP_ACCEL_CAPABILITIES_SM2 |
+			  ICP_ACCEL_CAPABILITIES_ECEDMONT;
+
+	if (fusectl1 & ICP_ACCEL_GEN4_MASK_PKE_SLICE) {
+		capabilities_asym &= ~ICP_ACCEL_CAPABILITIES_CRYPTO_ASYMMETRIC;
+		capabilities_asym &= ~ICP_ACCEL_CAPABILITIES_SM2;
+		capabilities_asym &= ~ICP_ACCEL_CAPABILITIES_ECEDMONT;
+	}
+
+	capabilities_dc = ICP_ACCEL_CAPABILITIES_COMPRESSION |
+			  ICP_ACCEL_CAPABILITIES_LZ4_COMPRESSION |
+			  ICP_ACCEL_CAPABILITIES_LZ4S_COMPRESSION |
+			  ICP_ACCEL_CAPABILITIES_CNV_INTEGRITY64;
+
+	if (fusectl1 & ICP_ACCEL_GEN4_MASK_COMPRESS_SLICE) {
+		capabilities_dc &= ~ICP_ACCEL_CAPABILITIES_COMPRESSION;
+		capabilities_dc &= ~ICP_ACCEL_CAPABILITIES_LZ4_COMPRESSION;
+		capabilities_dc &= ~ICP_ACCEL_CAPABILITIES_LZ4S_COMPRESSION;
+		capabilities_dc &= ~ICP_ACCEL_CAPABILITIES_CNV_INTEGRITY64;
+	}
+
+	switch (adf_get_service_enabled(accel_dev)) {
+	case SVC_CY:
+	case SVC_CY2:
+		return capabilities_sym | capabilities_asym;
+	case SVC_DC:
+		return capabilities_dc;
+	case SVC_DCC:
+		/*
+		 * Sym capabilities are available for chaining operations,
+		 * but sym crypto instances cannot be supported
+		 */
+		capabilities_dcc = capabilities_dc | capabilities_sym;
+		capabilities_dcc &= ~ICP_ACCEL_CAPABILITIES_CRYPTO_SYMMETRIC;
+		return capabilities_dcc;
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
+	default:
+		return 0;
+	}
+}
+
+static const u32 *adf_get_arbiter_mapping(struct adf_accel_dev *accel_dev)
+{
+	switch (adf_get_service_enabled(accel_dev)) {
+	case SVC_ASYM:
+		return thrd_to_arb_map_asym;
+	case SVC_SYM:
+		return thrd_to_arb_map_sym;
+	case SVC_DC:
+		return thrd_to_arb_map_dc;
+	case SVC_DCC:
+		return thrd_to_arb_map_dcc;
+	case SVC_ASYM_DC:
+	case SVC_DC_ASYM:
+		return thrd_to_arb_map_asym_dc;
+	case SVC_DC_SYM:
+	case SVC_SYM_DC:
+		return thrd_to_arb_map_sym_dc;
+	default:
+		return default_thrd_to_arb_map;
+	}
+}
+
+static void adf_init_rl_data(struct adf_rl_hw_data *rl_data)
+{
+	rl_data->pciout_tb_offset = ADF_GEN4_RL_TOKEN_PCIEOUT_BUCKET_OFFSET;
+	rl_data->pciin_tb_offset = ADF_GEN4_RL_TOKEN_PCIEIN_BUCKET_OFFSET;
+	rl_data->r2l_offset = ADF_GEN4_RL_R2L_OFFSET;
+	rl_data->l2c_offset = ADF_GEN4_RL_L2C_OFFSET;
+	rl_data->c2s_offset = ADF_GEN4_RL_C2S_OFFSET;
+
+	rl_data->pcie_scale_div = ADF_420XX_RL_PCIE_SCALE_FACTOR_DIV;
+	rl_data->pcie_scale_mul = ADF_420XX_RL_PCIE_SCALE_FACTOR_MUL;
+	rl_data->dcpr_correction = ADF_420XX_RL_DCPR_CORRECTION;
+	rl_data->max_tp[ADF_SVC_ASYM] = ADF_420XX_RL_MAX_TP_ASYM;
+	rl_data->max_tp[ADF_SVC_SYM] = ADF_420XX_RL_MAX_TP_SYM;
+	rl_data->max_tp[ADF_SVC_DC] = ADF_420XX_RL_MAX_TP_DC;
+	rl_data->scan_interval = ADF_420XX_RL_SCANS_PER_SEC;
+	rl_data->scale_ref = ADF_420XX_RL_SLICE_REF;
+}
+
+enum adf_rp_groups {
+	RP_GROUP_0 = 0,
+	RP_GROUP_1,
+	RP_GROUP_COUNT
+};
+
+static u16 get_ring_to_svc_map(struct adf_accel_dev *accel_dev)
+{
+	enum adf_cfg_service_type rps[RP_GROUP_COUNT] = { };
+	const struct adf_fw_config *fw_config;
+	u16 ring_to_svc_map;
+	int i, j;
+
+	fw_config = get_fw_config(accel_dev);
+	if (!fw_config)
+		return 0;
+
+	for (i = 0; i < RP_GROUP_COUNT; i++) {
+		switch (fw_config[i].ae_mask) {
+		case ADF_AE_GROUP_0:
+			j = RP_GROUP_0;
+			break;
+		case ADF_AE_GROUP_1:
+			j = RP_GROUP_1;
+			break;
+		default:
+			return 0;
+		}
+
+		switch (fw_config[i].obj) {
+		case ADF_FW_SYM_OBJ:
+			rps[j] = SYM;
+			break;
+		case ADF_FW_ASYM_OBJ:
+			rps[j] = ASYM;
+			break;
+		case ADF_FW_DC_OBJ:
+			rps[j] = COMP;
+			break;
+		default:
+			rps[j] = 0;
+			break;
+		}
+	}
+
+	ring_to_svc_map = rps[RP_GROUP_0] << ADF_CFG_SERV_RING_PAIR_0_SHIFT |
+			  rps[RP_GROUP_1] << ADF_CFG_SERV_RING_PAIR_1_SHIFT |
+			  rps[RP_GROUP_0] << ADF_CFG_SERV_RING_PAIR_2_SHIFT |
+			  rps[RP_GROUP_1] << ADF_CFG_SERV_RING_PAIR_3_SHIFT;
+
+	return ring_to_svc_map;
+}
+
+static const char *uof_get_name(struct adf_accel_dev *accel_dev, u32 obj_num,
+				const char * const fw_objs[], int num_objs)
+{
+	const struct adf_fw_config *fw_config;
+	int id;
+
+	fw_config = get_fw_config(accel_dev);
+	if (fw_config)
+		id = fw_config[obj_num].obj;
+	else
+		id = -EINVAL;
+
+	if (id < 0 || id > num_objs)
+		return NULL;
+
+	return fw_objs[id];
+}
+
+static const char *uof_get_name_420xx(struct adf_accel_dev *accel_dev, u32 obj_num)
+{
+	int num_fw_objs = ARRAY_SIZE(adf_420xx_fw_objs);
+
+	return uof_get_name(accel_dev, obj_num, adf_420xx_fw_objs, num_fw_objs);
+}
+
+static u32 uof_get_ae_mask(struct adf_accel_dev *accel_dev, u32 obj_num)
+{
+	const struct adf_fw_config *fw_config;
+
+	fw_config = get_fw_config(accel_dev);
+	if (!fw_config)
+		return 0;
+
+	return fw_config[obj_num].ae_mask;
+}
+
+static void adf_gen4_set_err_mask(struct adf_dev_err_mask *dev_err_mask)
+{
+	dev_err_mask->cppagentcmdpar_mask = ADF_420XX_HICPPAGENTCMDPARERRLOG_MASK;
+	dev_err_mask->parerr_ath_cph_mask = ADF_420XX_PARITYERRORMASK_ATH_CPH_MASK;
+	dev_err_mask->parerr_cpr_xlt_mask = ADF_420XX_PARITYERRORMASK_CPR_XLT_MASK;
+	dev_err_mask->parerr_dcpr_ucs_mask = ADF_420XX_PARITYERRORMASK_DCPR_UCS_MASK;
+	dev_err_mask->parerr_pke_mask = ADF_420XX_PARITYERRORMASK_PKE_MASK;
+	dev_err_mask->ssmfeatren_mask = ADF_420XX_SSMFEATREN_MASK;
+}
+
+void adf_init_hw_data_420xx(struct adf_hw_device_data *hw_data, u32 dev_id)
+{
+	hw_data->dev_class = &adf_420xx_class;
+	hw_data->instance_id = adf_420xx_class.instances++;
+	hw_data->num_banks = ADF_GEN4_ETR_MAX_BANKS;
+	hw_data->num_banks_per_vf = ADF_GEN4_NUM_BANKS_PER_VF;
+	hw_data->num_rings_per_bank = ADF_GEN4_NUM_RINGS_PER_BANK;
+	hw_data->num_accel = ADF_GEN4_MAX_ACCELERATORS;
+	hw_data->num_engines = ADF_420XX_MAX_ACCELENGINES;
+	hw_data->num_logical_accel = 1;
+	hw_data->tx_rx_gap = ADF_GEN4_RX_RINGS_OFFSET;
+	hw_data->tx_rings_mask = ADF_GEN4_TX_RINGS_MASK;
+	hw_data->ring_to_svc_map = ADF_GEN4_DEFAULT_RING_TO_SRV_MAP;
+	hw_data->alloc_irq = adf_isr_resource_alloc;
+	hw_data->free_irq = adf_isr_resource_free;
+	hw_data->enable_error_correction = adf_gen4_enable_error_correction;
+	hw_data->get_accel_mask = adf_gen4_get_accel_mask;
+	hw_data->get_ae_mask = get_ae_mask;
+	hw_data->get_num_accels = adf_gen4_get_num_accels;
+	hw_data->get_num_aes = adf_gen4_get_num_aes;
+	hw_data->get_sram_bar_id = adf_gen4_get_sram_bar_id;
+	hw_data->get_etr_bar_id = adf_gen4_get_etr_bar_id;
+	hw_data->get_misc_bar_id = adf_gen4_get_misc_bar_id;
+	hw_data->get_arb_info = adf_gen4_get_arb_info;
+	hw_data->get_admin_info = adf_gen4_get_admin_info;
+	hw_data->get_accel_cap = get_accel_cap;
+	hw_data->get_sku = adf_gen4_get_sku;
+	hw_data->init_admin_comms = adf_init_admin_comms;
+	hw_data->exit_admin_comms = adf_exit_admin_comms;
+	hw_data->send_admin_init = adf_send_admin_init;
+	hw_data->init_arb = adf_init_arb;
+	hw_data->exit_arb = adf_exit_arb;
+	hw_data->get_arb_mapping = adf_get_arbiter_mapping;
+	hw_data->enable_ints = adf_gen4_enable_ints;
+	hw_data->init_device = adf_gen4_init_device;
+	hw_data->reset_device = adf_reset_flr;
+	hw_data->admin_ae_mask = ADF_420XX_ADMIN_AE_MASK;
+	hw_data->fw_name = ADF_420XX_FW;
+	hw_data->fw_mmp_name = ADF_420XX_MMP;
+	hw_data->uof_get_name = uof_get_name_420xx;
+	hw_data->uof_get_num_objs = uof_get_num_objs;
+	hw_data->uof_get_ae_mask = uof_get_ae_mask;
+	hw_data->set_msix_rttable = adf_gen4_set_msix_default_rttable;
+	hw_data->set_ssm_wdtimer = adf_gen4_set_ssm_wdtimer;
+	hw_data->get_ring_to_svc_map = get_ring_to_svc_map;
+	hw_data->disable_iov = adf_disable_sriov;
+	hw_data->ring_pair_reset = adf_gen4_ring_pair_reset;
+	hw_data->enable_pm = adf_gen4_enable_pm;
+	hw_data->handle_pm_interrupt = adf_gen4_handle_pm_interrupt;
+	hw_data->dev_config = adf_gen4_dev_config;
+	hw_data->start_timer = adf_gen4_timer_start;
+	hw_data->stop_timer = adf_gen4_timer_stop;
+	hw_data->get_hb_clock = adf_gen4_get_heartbeat_clock;
+	hw_data->num_hb_ctrs = ADF_NUM_HB_CNT_PER_AE;
+	hw_data->clock_frequency = ADF_420XX_AE_FREQ;
+
+	adf_gen4_set_err_mask(&hw_data->dev_err_mask);
+	adf_gen4_init_hw_csr_ops(&hw_data->csr_ops);
+	adf_gen4_init_pf_pfvf_ops(&hw_data->pfvf_ops);
+	adf_gen4_init_dc_ops(&hw_data->dc_ops);
+	adf_gen4_init_ras_ops(&hw_data->ras_ops);
+	adf_init_rl_data(&hw_data->rl_data);
+}
+
+void adf_clean_hw_data_420xx(struct adf_hw_device_data *hw_data)
+{
+	hw_data->dev_class->instances--;
+}
diff --git a/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.h b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.h
new file mode 100644
index 000000000000..99abbfc14820
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2023 Intel Corporation */
+#ifndef ADF_420XX_HW_DATA_H_
+#define ADF_420XX_HW_DATA_H_
+
+#include <adf_accel_devices.h>
+
+#define ADF_420XX_MAX_ACCELENGINES		17
+
+#define ADF_420XX_ACCELENGINES_MASK		0x1FFFF
+#define ADF_420XX_ADMIN_AE_MASK			0x10000
+
+#define ADF_420XX_HICPPAGENTCMDPARERRLOG_MASK	(0xFF)
+#define ADF_420XX_PARITYERRORMASK_ATH_CPH_MASK	(0xFF00FF)
+#define ADF_420XX_PARITYERRORMASK_CPR_XLT_MASK	(0x10001)
+#define ADF_420XX_PARITYERRORMASK_DCPR_UCS_MASK	(0xF0007)
+#define ADF_420XX_PARITYERRORMASK_PKE_MASK	(0xFFF)
+#define ADF_420XX_PARITYERRORMASK_WAT_WCP_MASK	(0x3FF03FF)
+
+/*
+ * SSMFEATREN bit mask
+ * BIT(4) - enables parity detection on CPP
+ * BIT(12) - enables the logging of push/pull data errors
+ *	     in pperr register
+ * BIT(16) - BIT(27) - enable parity detection on SPPs
+ */
+#define ADF_420XX_SSMFEATREN_MASK \
+	(BIT(4) | BIT(12) | BIT(16) | BIT(17) | BIT(18) | BIT(19) | BIT(20) | \
+	 BIT(21) | BIT(22) | BIT(23) | BIT(24) | BIT(25) | BIT(26) | BIT(27))
+
+/* Firmware Binaries */
+#define ADF_420XX_FW		"qat_420xx.bin"
+#define ADF_420XX_MMP		"qat_420xx_mmp.bin"
+#define ADF_420XX_SYM_OBJ	"qat_420xx_sym.bin"
+#define ADF_420XX_DC_OBJ	"qat_420xx_dc.bin"
+#define ADF_420XX_ASYM_OBJ	"qat_420xx_asym.bin"
+#define ADF_420XX_ADMIN_OBJ	"qat_420xx_admin.bin"
+
+/* RL constants */
+#define ADF_420XX_RL_PCIE_SCALE_FACTOR_DIV	100
+#define ADF_420XX_RL_PCIE_SCALE_FACTOR_MUL	102
+#define ADF_420XX_RL_DCPR_CORRECTION		1
+#define ADF_420XX_RL_SCANS_PER_SEC		954
+#define ADF_420XX_RL_MAX_TP_ASYM		173750UL
+#define ADF_420XX_RL_MAX_TP_SYM			95000UL
+#define ADF_420XX_RL_MAX_TP_DC			40000UL
+#define ADF_420XX_RL_SLICE_REF			1000UL
+
+/* Clocks frequency */
+#define ADF_420XX_AE_FREQ		(1000 * HZ_PER_MHZ)
+
+void adf_init_hw_data_420xx(struct adf_hw_device_data *hw_data, u32 dev_id);
+void adf_clean_hw_data_420xx(struct adf_hw_device_data *hw_data);
+
+#endif
diff --git a/drivers/crypto/intel/qat/qat_420xx/adf_drv.c b/drivers/crypto/intel/qat/qat_420xx/adf_drv.c
new file mode 100644
index 000000000000..2a3598409eeb
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_420xx/adf_drv.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation */
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include <adf_accel_devices.h>
+#include <adf_gen4_hw_data.h>
+#include <adf_gen4_config.h>
+#include <adf_cfg.h>
+#include <adf_common_drv.h>
+#include <adf_dbgfs.h>
+
+#include "adf_420xx_hw_data.h"
+
+static const struct pci_device_id adf_pci_tbl[] = {
+	{ PCI_VDEVICE(INTEL, ADF_420XX_PCI_DEVICE_ID), },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, adf_pci_tbl);
+
+static void adf_cleanup_accel(struct adf_accel_dev *accel_dev)
+{
+	if (accel_dev->hw_device) {
+		adf_clean_hw_data_420xx(accel_dev->hw_device);
+		accel_dev->hw_device = NULL;
+	}
+	adf_dbgfs_exit(accel_dev);
+	adf_cfg_dev_remove(accel_dev);
+	adf_devmgr_rm_dev(accel_dev, NULL);
+}
+
+static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	struct adf_accel_dev *accel_dev;
+	struct adf_accel_pci *accel_pci_dev;
+	struct adf_hw_device_data *hw_data;
+	unsigned int i, bar_nr;
+	unsigned long bar_mask;
+	struct adf_bar *bar;
+	int ret;
+
+	if (num_possible_nodes() > 1 && dev_to_node(&pdev->dev) < 0) {
+		/*
+		 * If the accelerator is connected to a node with no memory
+		 * there is no point in using the accelerator since the remote
+		 * memory transaction will be very slow.
+		 */
+		dev_err(&pdev->dev, "Invalid NUMA configuration.\n");
+		return -EINVAL;
+	}
+
+	accel_dev = devm_kzalloc(&pdev->dev, sizeof(*accel_dev), GFP_KERNEL);
+	if (!accel_dev)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&accel_dev->crypto_list);
+	accel_pci_dev = &accel_dev->accel_pci_dev;
+	accel_pci_dev->pci_dev = pdev;
+
+	/*
+	 * Add accel device to accel table
+	 * This should be called before adf_cleanup_accel is called
+	 */
+	if (adf_devmgr_add_dev(accel_dev, NULL)) {
+		dev_err(&pdev->dev, "Failed to add new accelerator device.\n");
+		return -EFAULT;
+	}
+
+	accel_dev->owner = THIS_MODULE;
+	/* Allocate and initialise device hardware meta-data structure */
+	hw_data = devm_kzalloc(&pdev->dev, sizeof(*hw_data), GFP_KERNEL);
+	if (!hw_data) {
+		ret = -ENOMEM;
+		goto out_err;
+	}
+
+	accel_dev->hw_device = hw_data;
+	adf_init_hw_data_420xx(accel_dev->hw_device, ent->device);
+
+	pci_read_config_byte(pdev, PCI_REVISION_ID, &accel_pci_dev->revid);
+	pci_read_config_dword(pdev, ADF_GEN4_FUSECTL4_OFFSET, &hw_data->fuses);
+
+	/* Get Accelerators and Accelerators Engines masks */
+	hw_data->accel_mask = hw_data->get_accel_mask(hw_data);
+	hw_data->ae_mask = hw_data->get_ae_mask(hw_data);
+	accel_pci_dev->sku = hw_data->get_sku(hw_data);
+	/* If the device has no acceleration engines then ignore it */
+	if (!hw_data->accel_mask || !hw_data->ae_mask ||
+	    (~hw_data->ae_mask & 0x01)) {
+		dev_err(&pdev->dev, "No acceleration units found.\n");
+		ret = -EFAULT;
+		goto out_err;
+	}
+
+	/* Create device configuration table */
+	ret = adf_cfg_dev_add(accel_dev);
+	if (ret)
+		goto out_err;
+
+	/* Enable PCI device */
+	ret = pcim_enable_device(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't enable PCI device.\n");
+		goto out_err;
+	}
+
+	/* Set DMA identifier */
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (ret) {
+		dev_err(&pdev->dev, "No usable DMA configuration.\n");
+		goto out_err;
+	}
+
+	ret = adf_gen4_cfg_dev_init(accel_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to initialize configuration.\n");
+		goto out_err;
+	}
+
+	/* Get accelerator capabilities mask */
+	hw_data->accel_capabilities_mask = hw_data->get_accel_cap(accel_dev);
+	if (!hw_data->accel_capabilities_mask) {
+		dev_err(&pdev->dev, "Failed to get capabilities mask.\n");
+		ret = -EINVAL;
+		goto out_err;
+	}
+
+	/* Find and map all the device's BARS */
+	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM) & ADF_GEN4_BAR_MASK;
+
+	ret = pcim_iomap_regions_request_all(pdev, bar_mask, pci_name(pdev));
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to map pci regions.\n");
+		goto out_err;
+	}
+
+	i = 0;
+	for_each_set_bit(bar_nr, &bar_mask, PCI_STD_NUM_BARS) {
+		bar = &accel_pci_dev->pci_bars[i++];
+		bar->virt_addr = pcim_iomap_table(pdev)[bar_nr];
+	}
+
+	pci_set_master(pdev);
+
+	if (pci_save_state(pdev)) {
+		dev_err(&pdev->dev, "Failed to save pci state.\n");
+		ret = -ENOMEM;
+		goto out_err;
+	}
+
+	accel_dev->ras_errors.enabled = true;
+	adf_dbgfs_init(accel_dev);
+
+	ret = adf_dev_up(accel_dev, true);
+	if (ret)
+		goto out_err_dev_stop;
+
+	ret = adf_sysfs_init(accel_dev);
+	if (ret)
+		goto out_err_dev_stop;
+
+	return ret;
+
+out_err_dev_stop:
+	adf_dev_down(accel_dev, false);
+out_err:
+	adf_cleanup_accel(accel_dev);
+	return ret;
+}
+
+static void adf_remove(struct pci_dev *pdev)
+{
+	struct adf_accel_dev *accel_dev = adf_devmgr_pci_to_accel_dev(pdev);
+
+	if (!accel_dev) {
+		pr_err("QAT: Driver removal failed\n");
+		return;
+	}
+	adf_dev_down(accel_dev, false);
+	adf_cleanup_accel(accel_dev);
+}
+
+static struct pci_driver adf_driver = {
+	.id_table = adf_pci_tbl,
+	.name = ADF_420XX_DEVICE_NAME,
+	.probe = adf_probe,
+	.remove = adf_remove,
+	.sriov_configure = adf_sriov_configure,
+	.err_handler = &adf_err_handler,
+};
+
+module_pci_driver(adf_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Intel");
+MODULE_FIRMWARE(ADF_420XX_FW);
+MODULE_FIRMWARE(ADF_420XX_MMP);
+MODULE_DESCRIPTION("Intel(R) QuickAssist Technology");
+MODULE_VERSION(ADF_DRV_VERSION);
+MODULE_SOFTDEP("pre: crypto-intel_qat");
+MODULE_IMPORT_NS(CRYPTO_QAT);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
index 33de8855fd66..7df6336ddd62 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
@@ -19,12 +19,15 @@
 #define ADF_C3XXX_DEVICE_NAME "c3xxx"
 #define ADF_C3XXXVF_DEVICE_NAME "c3xxxvf"
 #define ADF_4XXX_DEVICE_NAME "4xxx"
+#define ADF_420XX_DEVICE_NAME "420xx"
 #define ADF_4XXX_PCI_DEVICE_ID 0x4940
 #define ADF_4XXXIOV_PCI_DEVICE_ID 0x4941
 #define ADF_401XX_PCI_DEVICE_ID 0x4942
 #define ADF_401XXIOV_PCI_DEVICE_ID 0x4943
 #define ADF_402XX_PCI_DEVICE_ID 0x4944
 #define ADF_402XXIOV_PCI_DEVICE_ID 0x4945
+#define ADF_420XX_PCI_DEVICE_ID 0x4946
+#define ADF_420XXIOV_PCI_DEVICE_ID 0x4947
 #define ADF_DEVICE_FUSECTL_OFFSET 0x40
 #define ADF_DEVICE_LEGFUSE_OFFSET 0x4C
 #define ADF_DEVICE_FUSECTL_MASK 0x80000000
diff --git a/drivers/crypto/intel/qat/qat_common/adf_cfg_common.h b/drivers/crypto/intel/qat/qat_common/adf_cfg_common.h
index 6e5de1dab97b..89df3888d7ea 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_cfg_common.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_cfg_common.h
@@ -47,6 +47,7 @@ enum adf_device_type {
 	DEV_C3XXX,
 	DEV_C3XXXVF,
 	DEV_4XXX,
+	DEV_420XX,
 };
 
 struct adf_dev_status_info {
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
index b42fb8048c04..051ad20581a6 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
@@ -202,6 +202,8 @@ enum icp_qat_gen4_slice_mask {
 	ICP_ACCEL_GEN4_MASK_UCS_SLICE = BIT(4),
 	ICP_ACCEL_GEN4_MASK_EIA3_SLICE = BIT(5),
 	ICP_ACCEL_GEN4_MASK_SMX_SLICE = BIT(7),
+	ICP_ACCEL_GEN4_MASK_WCP_WAT_SLICE = BIT(8),
+	ICP_ACCEL_GEN4_MASK_ZUC_256_SLICE = BIT(9),
 };
 
 void adf_gen4_enable_error_correction(struct adf_accel_dev *accel_dev);
diff --git a/drivers/crypto/intel/qat/qat_common/icp_qat_hw.h b/drivers/crypto/intel/qat/qat_common/icp_qat_hw.h
index eb2ef225bcee..b8f1c4ffb8b5 100644
--- a/drivers/crypto/intel/qat/qat_common/icp_qat_hw.h
+++ b/drivers/crypto/intel/qat/qat_common/icp_qat_hw.h
@@ -18,7 +18,12 @@ enum icp_qat_hw_ae_id {
 	ICP_QAT_HW_AE_9 = 9,
 	ICP_QAT_HW_AE_10 = 10,
 	ICP_QAT_HW_AE_11 = 11,
-	ICP_QAT_HW_AE_DELIMITER = 12
+	ICP_QAT_HW_AE_12 = 12,
+	ICP_QAT_HW_AE_13 = 13,
+	ICP_QAT_HW_AE_14 = 14,
+	ICP_QAT_HW_AE_15 = 15,
+	ICP_QAT_HW_AE_16 = 16,
+	ICP_QAT_HW_AE_DELIMITER = 17
 };
 
 enum icp_qat_hw_qat_id {
@@ -95,7 +100,7 @@ enum icp_qat_capabilities_mask {
 	/* Bits 10-11 are currently reserved */
 	ICP_ACCEL_CAPABILITIES_HKDF = BIT(12),
 	ICP_ACCEL_CAPABILITIES_ECEDMONT = BIT(13),
-	/* Bit 14 is currently reserved */
+	ICP_ACCEL_CAPABILITIES_EXT_ALGCHAIN = BIT(14),
 	ICP_ACCEL_CAPABILITIES_SHA3_EXT = BIT(15),
 	ICP_ACCEL_CAPABILITIES_AESGCM_SPC = BIT(16),
 	ICP_ACCEL_CAPABILITIES_CHACHA_POLY = BIT(17),
@@ -107,7 +112,10 @@ enum icp_qat_capabilities_mask {
 	ICP_ACCEL_CAPABILITIES_CNV_INTEGRITY64 = BIT(23),
 	ICP_ACCEL_CAPABILITIES_LZ4_COMPRESSION = BIT(24),
 	ICP_ACCEL_CAPABILITIES_LZ4S_COMPRESSION = BIT(25),
-	ICP_ACCEL_CAPABILITIES_AES_V2 = BIT(26)
+	ICP_ACCEL_CAPABILITIES_AES_V2 = BIT(26),
+	/* Bits 27-28 are currently reserved */
+	ICP_ACCEL_CAPABILITIES_ZUC_256 = BIT(29),
+	ICP_ACCEL_CAPABILITIES_WIRELESS_CRYPTO_EXT = BIT(30),
 };
 
 #define QAT_AUTH_MODE_BITPOS 4
diff --git a/drivers/crypto/intel/qat/qat_common/icp_qat_uclo.h b/drivers/crypto/intel/qat/qat_common/icp_qat_uclo.h
index 69482abdb8b9..e28241bdd0f4 100644
--- a/drivers/crypto/intel/qat/qat_common/icp_qat_uclo.h
+++ b/drivers/crypto/intel/qat/qat_common/icp_qat_uclo.h
@@ -7,7 +7,7 @@
 #define ICP_QAT_AC_C62X_DEV_TYPE   0x01000000
 #define ICP_QAT_AC_C3XXX_DEV_TYPE  0x02000000
 #define ICP_QAT_AC_4XXX_A_DEV_TYPE 0x08000000
-#define ICP_QAT_UCLO_MAX_AE       12
+#define ICP_QAT_UCLO_MAX_AE       17
 #define ICP_QAT_UCLO_MAX_CTX      8
 #define ICP_QAT_UCLO_MAX_UIMAGE   (ICP_QAT_UCLO_MAX_AE * ICP_QAT_UCLO_MAX_CTX)
 #define ICP_QAT_UCLO_MAX_USTORE   0x4000
diff --git a/drivers/crypto/intel/qat/qat_common/qat_hal.c b/drivers/crypto/intel/qat/qat_common/qat_hal.c
index cbb946a80076..317cafa9d11f 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_hal.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_hal.c
@@ -697,12 +697,16 @@ static int qat_hal_chip_init(struct icp_qat_fw_loader_handle *handle,
 	case ADF_4XXX_PCI_DEVICE_ID:
 	case ADF_401XX_PCI_DEVICE_ID:
 	case ADF_402XX_PCI_DEVICE_ID:
+	case ADF_420XX_PCI_DEVICE_ID:
 		handle->chip_info->mmp_sram_size = 0;
 		handle->chip_info->nn = false;
 		handle->chip_info->lm2lm3 = true;
 		handle->chip_info->lm_size = ICP_QAT_UCLO_MAX_LMEM_REG_2X;
 		handle->chip_info->icp_rst_csr = ICP_RESET_CPP0;
-		handle->chip_info->icp_rst_mask = 0x100015;
+		if (handle->pci_dev->device == ADF_420XX_PCI_DEVICE_ID)
+			handle->chip_info->icp_rst_mask = 0x100155;
+		else
+			handle->chip_info->icp_rst_mask = 0x100015;
 		handle->chip_info->glb_clk_enable_csr = ICP_GLOBAL_CLK_ENABLE_CPP0;
 		handle->chip_info->misc_ctl_csr = MISC_CONTROL_C4XXX;
 		handle->chip_info->wakeup_event_val = 0x80000000;
diff --git a/drivers/crypto/intel/qat/qat_common/qat_uclo.c b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
index e27ea7e28c51..ad2c64af7427 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_uclo.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
@@ -733,6 +733,7 @@ qat_uclo_get_dev_type(struct icp_qat_fw_loader_handle *handle)
 	case ADF_4XXX_PCI_DEVICE_ID:
 	case ADF_401XX_PCI_DEVICE_ID:
 	case ADF_402XX_PCI_DEVICE_ID:
+	case ADF_420XX_PCI_DEVICE_ID:
 		return ICP_QAT_AC_4XXX_A_DEV_TYPE;
 	default:
 		pr_err("QAT: unsupported device 0x%x\n",
-- 
2.32.0



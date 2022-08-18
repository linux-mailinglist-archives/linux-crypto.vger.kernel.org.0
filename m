Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA59598AD6
	for <lists+linux-crypto@lfdr.de>; Thu, 18 Aug 2022 20:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344321AbiHRSCA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 18 Aug 2022 14:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344650AbiHRSB5 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 18 Aug 2022 14:01:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1FBC6CFE
        for <linux-crypto@vger.kernel.org>; Thu, 18 Aug 2022 11:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660845714; x=1692381714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D8DlTyHZfIlDhsO0A8v6Al1s0oRWgZaIpkbmdeEV88M=;
  b=OlDlFT6IU03djUqSum4PBwFXRCryuY/NnhmW8u0lYfiTCP14VJc+uD/u
   0ZAELg5cbA7rsKilSPcFfyHtrwDre84n/UC27GJsNu2krMzafA+SM8Ixm
   S+smnjntghbVRuHyneR7INMMdZF9oeMomYJ9KuuEvms42ri1K6Ida6JOk
   KYHMtJVQQk2s4O7LmRNNnOyQawQ9Ar3EnMJihKwEee0VFaCPsiZUCHx+2
   golCmBunhh5PCnCSjCFcD2ZrJhpHenLH63K6xyqQ3IxU6cPEviSkuMLq5
   PYxKDmZ0CZU4m1Ck1ioDJXq4jp9rh9r3t4sldwh0zwL9Okw2BqG8KCGK/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="294109503"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="294109503"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 11:01:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="607919647"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.76])
  by orsmga002.jf.intel.com with ESMTP; 18 Aug 2022 11:01:52 -0700
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Vlad Dronov <vdronov@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Adam Guerin <adam.guerin@intel.com>
Subject: [PATCH 9/9] crypto: qat - enable deflate for QAT GEN4
Date:   Thu, 18 Aug 2022 19:01:20 +0100
Message-Id: <20220818180120.63452-10-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220818180120.63452-1-giovanni.cabiddu@intel.com>
References: <20220818180120.63452-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
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

Enable deflate for QAT GEN4 devices.

This adds
  (1) logic to create configuration entries at probe time for the
  compression instances for QAT GEN4 devices;
  (2) the implementation of QAT GEN4 specific compression operations,
  required since the creation of the compression request template is
  different between GEN2 and GEN4; and
  (3) updates to the firmware API related to compression for GEN4.

The implementation configures the device to produce data compressed
dynamically, optimized for throughput over compression ratio.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
Reviewed-by: Adam Guerin <adam.guerin@intel.com>
---
 .../crypto/qat/qat_4xxx/adf_4xxx_hw_data.c    |   4 +-
 .../crypto/qat/qat_4xxx/adf_4xxx_hw_data.h    |   2 +-
 drivers/crypto/qat/qat_4xxx/adf_drv.c         | 139 +++++++-
 drivers/crypto/qat/qat_common/Makefile        |   1 +
 drivers/crypto/qat/qat_common/adf_gen4_dc.c   |  83 +++++
 drivers/crypto/qat/qat_common/adf_gen4_dc.h   |  10 +
 .../qat/qat_common/icp_qat_hw_20_comp.h       | 164 ++++++++++
 .../qat/qat_common/icp_qat_hw_20_comp_defs.h  | 300 ++++++++++++++++++
 8 files changed, 689 insertions(+), 14 deletions(-)
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen4_dc.c
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen4_dc.h
 create mode 100644 drivers/crypto/qat/qat_common/icp_qat_hw_20_comp.h
 create mode 100644 drivers/crypto/qat/qat_common/icp_qat_hw_20_comp_defs.h

diff --git a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
index fda5f699ff57..834a705180c0 100644
--- a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -4,6 +4,7 @@
 #include <adf_accel_devices.h>
 #include <adf_cfg.h>
 #include <adf_common_drv.h>
+#include <adf_gen4_dc.h>
 #include <adf_gen4_hw_data.h>
 #include <adf_gen4_pfvf.h>
 #include <adf_gen4_pm.h>
@@ -357,10 +358,11 @@ void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data)
 	hw_data->ring_pair_reset = adf_gen4_ring_pair_reset;
 	hw_data->enable_pm = adf_gen4_enable_pm;
 	hw_data->handle_pm_interrupt = adf_gen4_handle_pm_interrupt;
-	hw_data->dev_config = adf_crypto_dev_config;
+	hw_data->dev_config = adf_gen4_dev_config;
 
 	adf_gen4_init_hw_csr_ops(&hw_data->csr_ops);
 	adf_gen4_init_pf_pfvf_ops(&hw_data->pfvf_ops);
+	adf_gen4_init_dc_ops(&hw_data->dc_ops);
 }
 
 void adf_clean_hw_data_4xxx(struct adf_hw_device_data *hw_data)
diff --git a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h
index 9d49248931f6..e98428ba78e2 100644
--- a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h
+++ b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h
@@ -70,6 +70,6 @@ enum icp_qat_4xxx_slice_mask {
 
 void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data);
 void adf_clean_hw_data_4xxx(struct adf_hw_device_data *hw_data);
-int adf_crypto_dev_config(struct adf_accel_dev *accel_dev);
+int adf_gen4_dev_config(struct adf_accel_dev *accel_dev);
 
 #endif
diff --git a/drivers/crypto/qat/qat_4xxx/adf_drv.c b/drivers/crypto/qat/qat_4xxx/adf_drv.c
index ea9dac047a5f..509dbb939caf 100644
--- a/drivers/crypto/qat/qat_4xxx/adf_drv.c
+++ b/drivers/crypto/qat/qat_4xxx/adf_drv.c
@@ -9,6 +9,7 @@
 #include <adf_common_drv.h>
 
 #include "adf_4xxx_hw_data.h"
+#include "qat_compression.h"
 #include "qat_crypto.h"
 #include "adf_transport_access_macros.h"
 
@@ -19,6 +20,16 @@ static const struct pci_device_id adf_pci_tbl[] = {
 };
 MODULE_DEVICE_TABLE(pci, adf_pci_tbl);
 
+enum configs {
+	DEV_CFG_CY = 0,
+	DEV_CFG_DC,
+};
+
+static const char * const services_operations[] = {
+	ADF_CFG_CY,
+	ADF_CFG_DC,
+};
+
 static void adf_cleanup_accel(struct adf_accel_dev *accel_dev)
 {
 	if (accel_dev->hw_device) {
@@ -53,7 +64,7 @@ static int adf_cfg_dev_init(struct adf_accel_dev *accel_dev)
 	return 0;
 }
 
-int adf_crypto_dev_config(struct adf_accel_dev *accel_dev)
+static int adf_crypto_dev_config(struct adf_accel_dev *accel_dev)
 {
 	char key[ADF_CFG_MAX_KEY_LEN_IN_BYTES];
 	int banks = GET_MAX_BANKS(accel_dev);
@@ -68,14 +79,6 @@ int adf_crypto_dev_config(struct adf_accel_dev *accel_dev)
 	else
 		instances = 0;
 
-	ret = adf_cfg_section_add(accel_dev, ADF_KERNEL_SEC);
-	if (ret)
-		goto err;
-
-	ret = adf_cfg_section_add(accel_dev, "Accelerator0");
-	if (ret)
-		goto err;
-
 	for (i = 0; i < instances; i++) {
 		val = i;
 		bank = i * 2;
@@ -161,10 +164,122 @@ int adf_crypto_dev_config(struct adf_accel_dev *accel_dev)
 	if (ret)
 		goto err;
 
-	set_bit(ADF_STATUS_CONFIGURED, &accel_dev->status);
 	return 0;
 err:
-	dev_err(&GET_DEV(accel_dev), "Failed to start QAT accel dev\n");
+	dev_err(&GET_DEV(accel_dev), "Failed to add configuration for crypto\n");
+	return ret;
+}
+
+static int adf_comp_dev_config(struct adf_accel_dev *accel_dev)
+{
+	char key[ADF_CFG_MAX_KEY_LEN_IN_BYTES];
+	int banks = GET_MAX_BANKS(accel_dev);
+	int cpus = num_online_cpus();
+	unsigned long val;
+	int instances;
+	int ret;
+	int i;
+
+	if (adf_hw_dev_has_compression(accel_dev))
+		instances = min(cpus, banks);
+	else
+		instances = 0;
+
+	for (i = 0; i < instances; i++) {
+		val = i;
+		snprintf(key, sizeof(key), ADF_DC "%d" ADF_RING_DC_BANK_NUM, i);
+		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
+						  key, &val, ADF_DEC);
+		if (ret)
+			goto err;
+
+		val = 512;
+		snprintf(key, sizeof(key), ADF_DC "%d" ADF_RING_DC_SIZE, i);
+		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
+						  key, &val, ADF_DEC);
+		if (ret)
+			goto err;
+
+		val = 0;
+		snprintf(key, sizeof(key), ADF_DC "%d" ADF_RING_DC_TX, i);
+		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
+						  key, &val, ADF_DEC);
+		if (ret)
+			goto err;
+
+		val = 1;
+		snprintf(key, sizeof(key), ADF_DC "%d" ADF_RING_DC_RX, i);
+		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
+						  key, &val, ADF_DEC);
+		if (ret)
+			goto err;
+
+		val = ADF_COALESCING_DEF_TIME;
+		snprintf(key, sizeof(key), ADF_ETRMGR_COALESCE_TIMER_FORMAT, i);
+		ret = adf_cfg_add_key_value_param(accel_dev, "Accelerator0",
+						  key, &val, ADF_DEC);
+		if (ret)
+			goto err;
+	}
+
+	val = i;
+	ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC, ADF_NUM_DC,
+					  &val, ADF_DEC);
+	if (ret)
+		goto err;
+
+	val = 0;
+	ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC, ADF_NUM_CY,
+					  &val, ADF_DEC);
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+	dev_err(&GET_DEV(accel_dev), "Failed to add configuration for compression\n");
+	return ret;
+}
+
+int adf_gen4_dev_config(struct adf_accel_dev *accel_dev)
+{
+	char services[ADF_CFG_MAX_VAL_LEN_IN_BYTES] = {0};
+	int ret;
+
+	ret = adf_cfg_section_add(accel_dev, ADF_KERNEL_SEC);
+	if (ret)
+		goto err;
+
+	ret = adf_cfg_section_add(accel_dev, "Accelerator0");
+	if (ret)
+		goto err;
+
+	ret = adf_cfg_get_param_value(accel_dev, ADF_GENERAL_SEC,
+				      ADF_SERVICES_ENABLED, services);
+	if (ret)
+		goto err;
+
+	ret = sysfs_match_string(services_operations, services);
+	if (ret < 0)
+		goto err;
+
+	switch (ret) {
+	case DEV_CFG_CY:
+		ret = adf_crypto_dev_config(accel_dev);
+		break;
+	case DEV_CFG_DC:
+		ret = adf_comp_dev_config(accel_dev);
+		break;
+	}
+
+	if (ret)
+		goto err;
+
+	set_bit(ADF_STATUS_CONFIGURED, &accel_dev->status);
+
+	return ret;
+
+err:
+	dev_err(&GET_DEV(accel_dev), "Failed to configure QAT driver\n");
 	return ret;
 }
 
@@ -299,7 +414,7 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		goto out_err_disable_aer;
 
-	ret = adf_crypto_dev_config(accel_dev);
+	ret = hw_data->dev_config(accel_dev);
 	if (ret)
 		goto out_err_disable_aer;
 
diff --git a/drivers/crypto/qat/qat_common/Makefile b/drivers/crypto/qat/qat_common/Makefile
index e3db4786738f..1fb8d50f509f 100644
--- a/drivers/crypto/qat/qat_common/Makefile
+++ b/drivers/crypto/qat/qat_common/Makefile
@@ -16,6 +16,7 @@ intel_qat-objs := adf_cfg.o \
 	adf_gen4_hw_data.o \
 	adf_gen4_pm.o \
 	adf_gen2_dc.o \
+	adf_gen4_dc.o \
 	qat_crypto.o \
 	qat_compression.o \
 	qat_comp_algs.o \
diff --git a/drivers/crypto/qat/qat_common/adf_gen4_dc.c b/drivers/crypto/qat/qat_common/adf_gen4_dc.c
new file mode 100644
index 000000000000..b0452814adea
--- /dev/null
+++ b/drivers/crypto/qat/qat_common/adf_gen4_dc.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2022 Intel Corporation */
+#include "adf_accel_devices.h"
+#include "icp_qat_fw_comp.h"
+#include "icp_qat_hw_20_comp.h"
+#include "adf_gen4_dc.h"
+
+static void qat_comp_build_deflate(void *ctx)
+{
+	struct icp_qat_fw_comp_req *req_tmpl =
+				(struct icp_qat_fw_comp_req *)ctx;
+	struct icp_qat_fw_comn_req_hdr *header = &req_tmpl->comn_hdr;
+	struct icp_qat_fw_comp_req_hdr_cd_pars *cd_pars = &req_tmpl->cd_pars;
+	struct icp_qat_fw_comp_req_params *req_pars = &req_tmpl->comp_pars;
+	struct icp_qat_hw_comp_20_config_csr_upper hw_comp_upper_csr = {0};
+	struct icp_qat_hw_comp_20_config_csr_lower hw_comp_lower_csr = {0};
+	struct icp_qat_hw_decomp_20_config_csr_lower hw_decomp_lower_csr = {0};
+	u32 upper_val;
+	u32 lower_val;
+
+	memset(req_tmpl, 0, sizeof(*req_tmpl));
+	header->hdr_flags =
+		ICP_QAT_FW_COMN_HDR_FLAGS_BUILD(ICP_QAT_FW_COMN_REQ_FLAG_SET);
+	header->service_type = ICP_QAT_FW_COMN_REQ_CPM_FW_COMP;
+	header->service_cmd_id = ICP_QAT_FW_COMP_CMD_STATIC;
+	header->comn_req_flags =
+		ICP_QAT_FW_COMN_FLAGS_BUILD(QAT_COMN_CD_FLD_TYPE_16BYTE_DATA,
+					    QAT_COMN_PTR_TYPE_SGL);
+	header->serv_specif_flags =
+		ICP_QAT_FW_COMP_FLAGS_BUILD(ICP_QAT_FW_COMP_STATELESS_SESSION,
+					    ICP_QAT_FW_COMP_AUTO_SELECT_BEST,
+					    ICP_QAT_FW_COMP_NOT_ENH_AUTO_SELECT_BEST,
+					    ICP_QAT_FW_COMP_NOT_DISABLE_TYPE0_ENH_AUTO_SELECT_BEST,
+					    ICP_QAT_FW_COMP_ENABLE_SECURE_RAM_USED_AS_INTMD_BUF);
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
+	req_pars->crc.legacy.initial_adler = COMP_CPR_INITIAL_ADLER;
+	req_pars->crc.legacy.initial_crc32 = COMP_CPR_INITIAL_CRC;
+	req_pars->req_par_flags =
+		ICP_QAT_FW_COMP_REQ_PARAM_FLAGS_BUILD(ICP_QAT_FW_COMP_SOP,
+						      ICP_QAT_FW_COMP_EOP,
+						      ICP_QAT_FW_COMP_BFINAL,
+						      ICP_QAT_FW_COMP_CNV,
+						      ICP_QAT_FW_COMP_CNV_RECOVERY,
+						      ICP_QAT_FW_COMP_NO_CNV_DFX,
+						      ICP_QAT_FW_COMP_CRC_MODE_LEGACY,
+						      ICP_QAT_FW_COMP_NO_XXHASH_ACC,
+						      ICP_QAT_FW_COMP_CNV_ERROR_NONE,
+						      ICP_QAT_FW_COMP_NO_APPEND_CRC,
+						      ICP_QAT_FW_COMP_NO_DROP_DATA);
+
+	/* Fill second half of the template for decompression */
+	memcpy(req_tmpl + 1, req_tmpl, sizeof(*req_tmpl));
+	req_tmpl++;
+	header = &req_tmpl->comn_hdr;
+	header->service_cmd_id = ICP_QAT_FW_COMP_CMD_DECOMPRESS;
+	cd_pars = &req_tmpl->cd_pars;
+
+	hw_decomp_lower_csr.algo = ICP_QAT_HW_DECOMP_20_HW_DECOMP_FORMAT_DEFLATE;
+	lower_val = ICP_QAT_FW_DECOMP_20_BUILD_CONFIG_LOWER(hw_decomp_lower_csr);
+
+	cd_pars->u.sl.comp_slice_cfg_word[0] = lower_val;
+	cd_pars->u.sl.comp_slice_cfg_word[1] = 0;
+}
+
+void adf_gen4_init_dc_ops(struct adf_dc_ops *dc_ops)
+{
+	dc_ops->build_deflate_ctx = qat_comp_build_deflate;
+}
+EXPORT_SYMBOL_GPL(adf_gen4_init_dc_ops);
diff --git a/drivers/crypto/qat/qat_common/adf_gen4_dc.h b/drivers/crypto/qat/qat_common/adf_gen4_dc.h
new file mode 100644
index 000000000000..068c2b9a4cec
--- /dev/null
+++ b/drivers/crypto/qat/qat_common/adf_gen4_dc.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2022 Intel Corporation */
+#ifndef ADF_GEN4_DC_H
+#define ADF_GEN4_DC_H
+
+#include "adf_accel_devices.h"
+
+void adf_gen4_init_dc_ops(struct adf_dc_ops *dc_ops);
+
+#endif /* ADF_GEN4_DC_H */
diff --git a/drivers/crypto/qat/qat_common/icp_qat_hw_20_comp.h b/drivers/crypto/qat/qat_common/icp_qat_hw_20_comp.h
new file mode 100644
index 000000000000..741a9946e4ca
--- /dev/null
+++ b/drivers/crypto/qat/qat_common/icp_qat_hw_20_comp.h
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2022 Intel Corporation */
+#ifndef _ICP_QAT_HW_20_COMP_H_
+#define _ICP_QAT_HW_20_COMP_H_
+
+#include "icp_qat_hw_20_comp_defs.h"
+#include "icp_qat_fw.h"
+
+struct icp_qat_hw_comp_20_config_csr_lower {
+	enum icp_qat_hw_comp_20_extended_delay_match_mode edmm;
+	enum icp_qat_hw_comp_20_hw_comp_format algo;
+	enum icp_qat_hw_comp_20_search_depth sd;
+	enum icp_qat_hw_comp_20_hbs_control hbs;
+	enum icp_qat_hw_comp_20_abd abd;
+	enum icp_qat_hw_comp_20_lllbd_ctrl lllbd;
+	enum icp_qat_hw_comp_20_min_match_control mmctrl;
+	enum icp_qat_hw_comp_20_skip_hash_collision hash_col;
+	enum icp_qat_hw_comp_20_skip_hash_update hash_update;
+	enum icp_qat_hw_comp_20_byte_skip skip_ctrl;
+};
+
+static inline __u32
+ICP_QAT_FW_COMP_20_BUILD_CONFIG_LOWER(struct icp_qat_hw_comp_20_config_csr_lower csr)
+{
+	u32 val32 = 0;
+
+	QAT_FIELD_SET(val32, csr.algo,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_HW_COMP_FORMAT_BITPOS,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_HW_COMP_FORMAT_MASK);
+	QAT_FIELD_SET(val32, csr.sd,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_SEARCH_DEPTH_BITPOS,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_SEARCH_DEPTH_MASK);
+	QAT_FIELD_SET(val32, csr.edmm,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_EXTENDED_DELAY_MATCH_MODE_BITPOS,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_EXTENDED_DELAY_MATCH_MODE_MASK);
+	QAT_FIELD_SET(val32, csr.hbs,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_HBS_CONTROL_BITPOS,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_HBS_CONTROL_MASK);
+	QAT_FIELD_SET(val32, csr.lllbd,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_LLLBD_CTRL_BITPOS,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_LLLBD_CTRL_MASK);
+	QAT_FIELD_SET(val32, csr.mmctrl,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_MIN_MATCH_CONTROL_BITPOS,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_MIN_MATCH_CONTROL_MASK);
+	QAT_FIELD_SET(val32, csr.hash_col,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_SKIP_HASH_COLLISION_BITPOS,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_SKIP_HASH_COLLISION_MASK);
+	QAT_FIELD_SET(val32, csr.hash_update,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_SKIP_HASH_UPDATE_BITPOS,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_SKIP_HASH_UPDATE_MASK);
+	QAT_FIELD_SET(val32, csr.skip_ctrl,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_BYTE_SKIP_BITPOS,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_BYTE_SKIP_MASK);
+	QAT_FIELD_SET(val32, csr.abd, ICP_QAT_HW_COMP_20_CONFIG_CSR_ABD_BITPOS,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_ABD_MASK);
+
+	return __builtin_bswap32(val32);
+}
+
+struct icp_qat_hw_comp_20_config_csr_upper {
+	enum icp_qat_hw_comp_20_scb_control scb_ctrl;
+	enum icp_qat_hw_comp_20_rmb_control rmb_ctrl;
+	enum icp_qat_hw_comp_20_som_control som_ctrl;
+	enum icp_qat_hw_comp_20_skip_hash_rd_control skip_hash_ctrl;
+	enum icp_qat_hw_comp_20_scb_unload_control scb_unload_ctrl;
+	enum icp_qat_hw_comp_20_disable_token_fusion_control disable_token_fusion_ctrl;
+	enum icp_qat_hw_comp_20_lbms lbms;
+	enum icp_qat_hw_comp_20_scb_mode_reset_mask scb_mode_reset;
+	__u16 lazy;
+	__u16 nice;
+};
+
+static inline __u32
+ICP_QAT_FW_COMP_20_BUILD_CONFIG_UPPER(struct icp_qat_hw_comp_20_config_csr_upper csr)
+{
+	u32 val32 = 0;
+
+	QAT_FIELD_SET(val32, csr.scb_ctrl,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_SCB_CONTROL_BITPOS,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_SCB_CONTROL_MASK);
+	QAT_FIELD_SET(val32, csr.rmb_ctrl,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_RMB_CONTROL_BITPOS,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_RMB_CONTROL_MASK);
+	QAT_FIELD_SET(val32, csr.som_ctrl,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_SOM_CONTROL_BITPOS,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_SOM_CONTROL_MASK);
+	QAT_FIELD_SET(val32, csr.skip_hash_ctrl,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_SKIP_HASH_RD_CONTROL_BITPOS,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_SKIP_HASH_RD_CONTROL_MASK);
+	QAT_FIELD_SET(val32, csr.scb_unload_ctrl,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_SCB_UNLOAD_CONTROL_BITPOS,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_SCB_UNLOAD_CONTROL_MASK);
+	QAT_FIELD_SET(val32, csr.disable_token_fusion_ctrl,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_DISABLE_TOKEN_FUSION_CONTROL_BITPOS,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_DISABLE_TOKEN_FUSION_CONTROL_MASK);
+	QAT_FIELD_SET(val32, csr.lbms,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_LBMS_BITPOS,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_LBMS_MASK);
+	QAT_FIELD_SET(val32, csr.scb_mode_reset,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_SCB_MODE_RESET_MASK_BITPOS,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_SCB_MODE_RESET_MASK_MASK);
+	QAT_FIELD_SET(val32, csr.lazy,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_LAZY_PARAM_BITPOS,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_LAZY_PARAM_MASK);
+	QAT_FIELD_SET(val32, csr.nice,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_NICE_PARAM_BITPOS,
+		      ICP_QAT_HW_COMP_20_CONFIG_CSR_NICE_PARAM_MASK);
+
+	return __builtin_bswap32(val32);
+}
+
+struct icp_qat_hw_decomp_20_config_csr_lower {
+	enum icp_qat_hw_decomp_20_hbs_control hbs;
+	enum icp_qat_hw_decomp_20_lbms lbms;
+	enum icp_qat_hw_decomp_20_hw_comp_format algo;
+	enum icp_qat_hw_decomp_20_min_match_control mmctrl;
+	enum icp_qat_hw_decomp_20_lz4_block_checksum_present lbc;
+};
+
+static inline __u32
+ICP_QAT_FW_DECOMP_20_BUILD_CONFIG_LOWER(struct icp_qat_hw_decomp_20_config_csr_lower csr)
+{
+	u32 val32 = 0;
+
+	QAT_FIELD_SET(val32, csr.hbs,
+		      ICP_QAT_HW_DECOMP_20_CONFIG_CSR_HBS_CONTROL_BITPOS,
+		      ICP_QAT_HW_DECOMP_20_CONFIG_CSR_HBS_CONTROL_MASK);
+	QAT_FIELD_SET(val32, csr.lbms,
+		      ICP_QAT_HW_DECOMP_20_CONFIG_CSR_LBMS_BITPOS,
+		      ICP_QAT_HW_DECOMP_20_CONFIG_CSR_LBMS_MASK);
+	QAT_FIELD_SET(val32, csr.algo,
+		      ICP_QAT_HW_DECOMP_20_CONFIG_CSR_HW_DECOMP_FORMAT_BITPOS,
+		      ICP_QAT_HW_DECOMP_20_CONFIG_CSR_HW_DECOMP_FORMAT_MASK);
+	QAT_FIELD_SET(val32, csr.mmctrl,
+		      ICP_QAT_HW_DECOMP_20_CONFIG_CSR_MIN_MATCH_CONTROL_BITPOS,
+		      ICP_QAT_HW_DECOMP_20_CONFIG_CSR_MIN_MATCH_CONTROL_MASK);
+	QAT_FIELD_SET(val32, csr.lbc,
+		      ICP_QAT_HW_DECOMP_20_CONFIG_CSR_LZ4_BLOCK_CHECKSUM_PRESENT_BITPOS,
+		      ICP_QAT_HW_DECOMP_20_CONFIG_CSR_LZ4_BLOCK_CHECKSUM_PRESENT_MASK);
+
+	return __builtin_bswap32(val32);
+}
+
+struct icp_qat_hw_decomp_20_config_csr_upper {
+	enum icp_qat_hw_decomp_20_speculative_decoder_control sdc;
+	enum icp_qat_hw_decomp_20_mini_cam_control mcc;
+};
+
+static inline __u32
+ICP_QAT_FW_DECOMP_20_BUILD_CONFIG_UPPER(struct icp_qat_hw_decomp_20_config_csr_upper csr)
+{
+	u32 val32 = 0;
+
+	QAT_FIELD_SET(val32, csr.sdc,
+		      ICP_QAT_HW_DECOMP_20_CONFIG_CSR_SPECULATIVE_DECODER_CONTROL_BITPOS,
+		      ICP_QAT_HW_DECOMP_20_CONFIG_CSR_SPECULATIVE_DECODER_CONTROL_MASK);
+	QAT_FIELD_SET(val32, csr.mcc,
+		      ICP_QAT_HW_DECOMP_20_CONFIG_CSR_MINI_CAM_CONTROL_BITPOS,
+		      ICP_QAT_HW_DECOMP_20_CONFIG_CSR_MINI_CAM_CONTROL_MASK);
+
+	return __builtin_bswap32(val32);
+}
+
+#endif
diff --git a/drivers/crypto/qat/qat_common/icp_qat_hw_20_comp_defs.h b/drivers/crypto/qat/qat_common/icp_qat_hw_20_comp_defs.h
new file mode 100644
index 000000000000..20b2c7d5438c
--- /dev/null
+++ b/drivers/crypto/qat/qat_common/icp_qat_hw_20_comp_defs.h
@@ -0,0 +1,300 @@
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2022 Intel Corporation */
+#ifndef _ICP_QAT_HW_20_COMP_DEFS_H
+#define _ICP_QAT_HW_20_COMP_DEFS_H
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_SCB_CONTROL_BITPOS 31
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_SCB_CONTROL_MASK 0x1
+
+enum icp_qat_hw_comp_20_scb_control {
+	ICP_QAT_HW_COMP_20_SCB_CONTROL_ENABLE = 0x0,
+	ICP_QAT_HW_COMP_20_SCB_CONTROL_DISABLE = 0x1,
+};
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_SCB_CONTROL_DEFAULT_VAL \
+	ICP_QAT_HW_COMP_20_SCB_CONTROL_DISABLE
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_RMB_CONTROL_BITPOS 30
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_RMB_CONTROL_MASK 0x1
+
+enum icp_qat_hw_comp_20_rmb_control {
+	ICP_QAT_HW_COMP_20_RMB_CONTROL_RESET_ALL = 0x0,
+	ICP_QAT_HW_COMP_20_RMB_CONTROL_RESET_FC_ONLY = 0x1,
+};
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_RMB_CONTROL_DEFAULT_VAL \
+	ICP_QAT_HW_COMP_20_RMB_CONTROL_RESET_ALL
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_SOM_CONTROL_BITPOS 28
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_SOM_CONTROL_MASK 0x3
+
+enum icp_qat_hw_comp_20_som_control {
+	ICP_QAT_HW_COMP_20_SOM_CONTROL_NORMAL_MODE = 0x0,
+	ICP_QAT_HW_COMP_20_SOM_CONTROL_REPLAY_MODE = 0x1,
+	ICP_QAT_HW_COMP_20_SOM_CONTROL_INPUT_CRC = 0x2,
+	ICP_QAT_HW_COMP_20_SOM_CONTROL_RESERVED_MODE = 0x3,
+};
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_SOM_CONTROL_DEFAULT_VAL \
+	ICP_QAT_HW_COMP_20_SOM_CONTROL_NORMAL_MODE
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_SKIP_HASH_RD_CONTROL_BITPOS 27
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_SKIP_HASH_RD_CONTROL_MASK 0x1
+
+enum icp_qat_hw_comp_20_skip_hash_rd_control {
+	ICP_QAT_HW_COMP_20_SKIP_HASH_RD_CONTROL_NO_SKIP = 0x0,
+	ICP_QAT_HW_COMP_20_SKIP_HASH_RD_CONTROL_SKIP_HASH_READS = 0x1,
+};
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_SKIP_HASH_RD_CONTROL_DEFAULT_VAL \
+	ICP_QAT_HW_COMP_20_SKIP_HASH_RD_CONTROL_NO_SKIP
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_SCB_UNLOAD_CONTROL_BITPOS 26
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_SCB_UNLOAD_CONTROL_MASK 0x1
+
+enum icp_qat_hw_comp_20_scb_unload_control {
+	ICP_QAT_HW_COMP_20_SCB_UNLOAD_CONTROL_UNLOAD = 0x0,
+	ICP_QAT_HW_COMP_20_SCB_UNLOAD_CONTROL_NO_UNLOAD = 0x1,
+};
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_SCB_UNLOAD_CONTROL_DEFAULT_VAL \
+	ICP_QAT_HW_COMP_20_SCB_UNLOAD_CONTROL_UNLOAD
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_DISABLE_TOKEN_FUSION_CONTROL_BITPOS 21
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_DISABLE_TOKEN_FUSION_CONTROL_MASK 0x1
+
+enum icp_qat_hw_comp_20_disable_token_fusion_control {
+	ICP_QAT_HW_COMP_20_DISABLE_TOKEN_FUSION_CONTROL_ENABLE = 0x0,
+	ICP_QAT_HW_COMP_20_DISABLE_TOKEN_FUSION_CONTROL_DISABLE = 0x1,
+};
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_DISABLE_TOKEN_FUSION_CONTROL_DEFAULT_VAL \
+	ICP_QAT_HW_COMP_20_DISABLE_TOKEN_FUSION_CONTROL_ENABLE
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_LBMS_BITPOS 19
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_LBMS_MASK 0x3
+
+enum icp_qat_hw_comp_20_lbms {
+	ICP_QAT_HW_COMP_20_LBMS_LBMS_64KB = 0x0,
+	ICP_QAT_HW_COMP_20_LBMS_LBMS_256KB = 0x1,
+	ICP_QAT_HW_COMP_20_LBMS_LBMS_1MB = 0x2,
+	ICP_QAT_HW_COMP_20_LBMS_LBMS_4MB = 0x3,
+};
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_LBMS_DEFAULT_VAL \
+	ICP_QAT_HW_COMP_20_LBMS_LBMS_64KB
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_SCB_MODE_RESET_MASK_BITPOS 18
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_SCB_MODE_RESET_MASK_MASK 0x1
+
+enum icp_qat_hw_comp_20_scb_mode_reset_mask {
+	ICP_QAT_HW_COMP_20_SCB_MODE_RESET_MASK_RESET_COUNTERS = 0x0,
+	ICP_QAT_HW_COMP_20_SCB_MODE_RESET_MASK_RESET_COUNTERS_AND_HISTORY = 0x1,
+};
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_SCB_MODE_RESET_MASK_DEFAULT_VAL \
+	ICP_QAT_HW_COMP_20_SCB_MODE_RESET_MASK_RESET_COUNTERS
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_LAZY_PARAM_BITPOS 9
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_LAZY_PARAM_MASK 0x1ff
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_LAZY_PARAM_DEFAULT_VAL 258
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_NICE_PARAM_BITPOS 0
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_NICE_PARAM_MASK 0x1ff
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_NICE_PARAM_DEFAULT_VAL 259
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_HBS_CONTROL_BITPOS 14
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_HBS_CONTROL_MASK 0x7
+
+enum icp_qat_hw_comp_20_hbs_control {
+	ICP_QAT_HW_COMP_20_HBS_CONTROL_HBS_IS_32KB = 0x0,
+	ICP_QAT_HW_COMP_23_HBS_CONTROL_HBS_IS_64KB = 0x1,
+};
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_HBS_CONTROL_DEFAULT_VAL \
+	ICP_QAT_HW_COMP_20_HBS_CONTROL_HBS_IS_32KB
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_ABD_BITPOS 13
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_ABD_MASK 0x1
+
+enum icp_qat_hw_comp_20_abd {
+	ICP_QAT_HW_COMP_20_ABD_ABD_ENABLED = 0x0,
+	ICP_QAT_HW_COMP_20_ABD_ABD_DISABLED = 0x1,
+};
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_ABD_DEFAULT_VAL \
+	ICP_QAT_HW_COMP_20_ABD_ABD_ENABLED
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_LLLBD_CTRL_BITPOS 12
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_LLLBD_CTRL_MASK 0x1
+
+enum icp_qat_hw_comp_20_lllbd_ctrl {
+	ICP_QAT_HW_COMP_20_LLLBD_CTRL_LLLBD_ENABLED = 0x0,
+	ICP_QAT_HW_COMP_20_LLLBD_CTRL_LLLBD_DISABLED = 0x1,
+};
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_LLLBD_CTRL_DEFAULT_VAL \
+	ICP_QAT_HW_COMP_20_LLLBD_CTRL_LLLBD_ENABLED
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_SEARCH_DEPTH_BITPOS 8
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_SEARCH_DEPTH_MASK 0xf
+
+enum icp_qat_hw_comp_20_search_depth {
+	ICP_QAT_HW_COMP_20_SEARCH_DEPTH_LEVEL_1 = 0x1,
+	ICP_QAT_HW_COMP_20_SEARCH_DEPTH_LEVEL_6 = 0x3,
+	ICP_QAT_HW_COMP_20_SEARCH_DEPTH_LEVEL_9 = 0x4,
+};
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_SEARCH_DEPTH_DEFAULT_VAL \
+	ICP_QAT_HW_COMP_20_SEARCH_DEPTH_LEVEL_1
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_HW_COMP_FORMAT_BITPOS 5
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_HW_COMP_FORMAT_MASK 0x7
+
+enum icp_qat_hw_comp_20_hw_comp_format {
+	ICP_QAT_HW_COMP_20_HW_COMP_FORMAT_ILZ77 = 0x0,
+	ICP_QAT_HW_COMP_20_HW_COMP_FORMAT_DEFLATE = 0x1,
+	ICP_QAT_HW_COMP_20_HW_COMP_FORMAT_LZ4 = 0x2,
+	ICP_QAT_HW_COMP_20_HW_COMP_FORMAT_LZ4S = 0x3,
+	ICP_QAT_HW_COMP_23_HW_COMP_FORMAT_ZSTD = 0x4,
+};
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_HW_COMP_FORMAT_DEFAULT_VAL \
+	ICP_QAT_HW_COMP_20_HW_COMP_FORMAT_DEFLATE
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_MIN_MATCH_CONTROL_BITPOS 4
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_MIN_MATCH_CONTROL_MASK 0x1
+
+enum icp_qat_hw_comp_20_min_match_control {
+	ICP_QAT_HW_COMP_20_MIN_MATCH_CONTROL_MATCH_3B = 0x0,
+	ICP_QAT_HW_COMP_20_MIN_MATCH_CONTROL_MATCH_4B = 0x1,
+};
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_MIN_MATCH_CONTROL_DEFAULT_VAL \
+	ICP_QAT_HW_COMP_20_MIN_MATCH_CONTROL_MATCH_3B
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_SKIP_HASH_COLLISION_BITPOS 3
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_SKIP_HASH_COLLISION_MASK 0x1
+
+enum icp_qat_hw_comp_20_skip_hash_collision {
+	ICP_QAT_HW_COMP_20_SKIP_HASH_COLLISION_ALLOW = 0x0,
+	ICP_QAT_HW_COMP_20_SKIP_HASH_COLLISION_DONT_ALLOW = 0x1,
+};
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_SKIP_HASH_COLLISION_DEFAULT_VAL \
+	ICP_QAT_HW_COMP_20_SKIP_HASH_COLLISION_ALLOW
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_SKIP_HASH_UPDATE_BITPOS 2
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_SKIP_HASH_UPDATE_MASK 0x1
+
+enum icp_qat_hw_comp_20_skip_hash_update {
+	ICP_QAT_HW_COMP_20_SKIP_HASH_UPDATE_ALLOW = 0x0,
+	ICP_QAT_HW_COMP_20_SKIP_HASH_UPDATE_DONT_ALLOW = 0x1,
+};
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_SKIP_HASH_UPDATE_DEFAULT_VAL \
+	ICP_QAT_HW_COMP_20_SKIP_HASH_UPDATE_ALLOW
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_BYTE_SKIP_BITPOS 1
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_BYTE_SKIP_MASK 0x1
+
+enum icp_qat_hw_comp_20_byte_skip {
+	ICP_QAT_HW_COMP_20_BYTE_SKIP_3BYTE_TOKEN = 0x0,
+	ICP_QAT_HW_COMP_20_BYTE_SKIP_3BYTE_LITERAL = 0x1,
+};
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_BYTE_SKIP_DEFAULT_VAL \
+	ICP_QAT_HW_COMP_20_BYTE_SKIP_3BYTE_TOKEN
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_EXTENDED_DELAY_MATCH_MODE_BITPOS 0
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_EXTENDED_DELAY_MATCH_MODE_MASK 0x1
+
+enum icp_qat_hw_comp_20_extended_delay_match_mode {
+	ICP_QAT_HW_COMP_20_EXTENDED_DELAY_MATCH_MODE_EDMM_DISABLED = 0x0,
+	ICP_QAT_HW_COMP_20_EXTENDED_DELAY_MATCH_MODE_EDMM_ENABLED = 0x1,
+};
+
+#define ICP_QAT_HW_COMP_20_CONFIG_CSR_EXTENDED_DELAY_MATCH_MODE_DEFAULT_VAL \
+	ICP_QAT_HW_COMP_20_EXTENDED_DELAY_MATCH_MODE_EDMM_DISABLED
+
+#define ICP_QAT_HW_DECOMP_20_CONFIG_CSR_SPECULATIVE_DECODER_CONTROL_BITPOS 31
+#define ICP_QAT_HW_DECOMP_20_CONFIG_CSR_SPECULATIVE_DECODER_CONTROL_MASK 0x1
+
+enum icp_qat_hw_decomp_20_speculative_decoder_control {
+	ICP_QAT_HW_DECOMP_20_SPECULATIVE_DECODER_CONTROL_ENABLE = 0x0,
+	ICP_QAT_HW_DECOMP_20_SPECULATIVE_DECODER_CONTROL_DISABLE = 0x1,
+};
+
+#define ICP_QAT_HW_DECOMP_20_CONFIG_CSR_SPECULATIVE_DECODER_CONTROL_DEFAULT_VAL \
+	ICP_QAT_HW_DECOMP_20_SPECULATIVE_DECODER_CONTROL_ENABLE
+
+#define ICP_QAT_HW_DECOMP_20_CONFIG_CSR_MINI_CAM_CONTROL_BITPOS 30
+#define ICP_QAT_HW_DECOMP_20_CONFIG_CSR_MINI_CAM_CONTROL_MASK 0x1
+
+enum icp_qat_hw_decomp_20_mini_cam_control {
+	ICP_QAT_HW_DECOMP_20_MINI_CAM_CONTROL_ENABLE = 0x0,
+	ICP_QAT_HW_DECOMP_20_MINI_CAM_CONTROL_DISABLE = 0x1,
+};
+
+#define ICP_QAT_HW_DECOMP_20_CONFIG_CSR_MINI_CAM_CONTROL_DEFAULT_VAL \
+	ICP_QAT_HW_DECOMP_20_MINI_CAM_CONTROL_ENABLE
+
+#define ICP_QAT_HW_DECOMP_20_CONFIG_CSR_HBS_CONTROL_BITPOS 14
+#define ICP_QAT_HW_DECOMP_20_CONFIG_CSR_HBS_CONTROL_MASK 0x7
+
+enum icp_qat_hw_decomp_20_hbs_control {
+	ICP_QAT_HW_DECOMP_20_HBS_CONTROL_HBS_IS_32KB = 0x0,
+};
+
+#define ICP_QAT_HW_DECOMP_20_CONFIG_CSR_HBS_CONTROL_DEFAULT_VAL \
+	ICP_QAT_HW_DECOMP_20_HBS_CONTROL_HBS_IS_32KB
+
+#define ICP_QAT_HW_DECOMP_20_CONFIG_CSR_LBMS_BITPOS 8
+#define ICP_QAT_HW_DECOMP_20_CONFIG_CSR_LBMS_MASK 0x3
+
+enum icp_qat_hw_decomp_20_lbms {
+	ICP_QAT_HW_DECOMP_20_LBMS_LBMS_64KB = 0x0,
+	ICP_QAT_HW_DECOMP_20_LBMS_LBMS_256KB = 0x1,
+	ICP_QAT_HW_DECOMP_20_LBMS_LBMS_1MB = 0x2,
+	ICP_QAT_HW_DECOMP_20_LBMS_LBMS_4MB = 0x3,
+};
+
+#define ICP_QAT_HW_DECOMP_20_CONFIG_CSR_LBMS_DEFAULT_VAL \
+	ICP_QAT_HW_DECOMP_20_LBMS_LBMS_64KB
+
+#define ICP_QAT_HW_DECOMP_20_CONFIG_CSR_HW_DECOMP_FORMAT_BITPOS 5
+#define ICP_QAT_HW_DECOMP_20_CONFIG_CSR_HW_DECOMP_FORMAT_MASK 0x7
+
+enum icp_qat_hw_decomp_20_hw_comp_format {
+	ICP_QAT_HW_DECOMP_20_HW_DECOMP_FORMAT_DEFLATE = 0x1,
+	ICP_QAT_HW_DECOMP_20_HW_DECOMP_FORMAT_LZ4 = 0x2,
+	ICP_QAT_HW_DECOMP_20_HW_DECOMP_FORMAT_LZ4S = 0x3,
+	ICP_QAT_HW_DECOMP_23_HW_DECOMP_FORMAT_ZSTD = 0x4,
+};
+
+#define ICP_QAT_HW_DECOMP_20_CONFIG_CSR_HW_DECOMP_FORMAT_DEFAULT_VAL \
+	ICP_QAT_HW_DECOMP_20_HW_DECOMP_FORMAT_DEFLATE
+
+#define ICP_QAT_HW_DECOMP_20_CONFIG_CSR_MIN_MATCH_CONTROL_BITPOS 4
+#define ICP_QAT_HW_DECOMP_20_CONFIG_CSR_MIN_MATCH_CONTROL_MASK 0x1
+
+enum icp_qat_hw_decomp_20_min_match_control {
+	ICP_QAT_HW_DECOMP_20_MIN_MATCH_CONTROL_MATCH_3B = 0x0,
+	ICP_QAT_HW_DECOMP_20_MIN_MATCH_CONTROL_MATCH_4B = 0x1,
+};
+
+#define ICP_QAT_HW_DECOMP_20_CONFIG_CSR_MIN_MATCH_CONTROL_DEFAULT_VAL \
+	ICP_QAT_HW_DECOMP_20_MIN_MATCH_CONTROL_MATCH_3B
+
+#define ICP_QAT_HW_DECOMP_20_CONFIG_CSR_LZ4_BLOCK_CHECKSUM_PRESENT_BITPOS 3
+#define ICP_QAT_HW_DECOMP_20_CONFIG_CSR_LZ4_BLOCK_CHECKSUM_PRESENT_MASK 0x1
+
+enum icp_qat_hw_decomp_20_lz4_block_checksum_present {
+	ICP_QAT_HW_DECOMP_20_LZ4_BLOCK_CHKSUM_ABSENT = 0x0,
+	ICP_QAT_HW_DECOMP_20_LZ4_BLOCK_CHKSUM_PRESENT = 0x1,
+};
+
+#define ICP_QAT_HW_DECOMP_20_CONFIG_CSR_LZ4_BLOCK_CHECKSUM_PRESENT_DEFAULT_VAL \
+	ICP_QAT_HW_DECOMP_20_LZ4_BLOCK_CHKSUM_ABSENT
+
+#endif
-- 
2.37.1


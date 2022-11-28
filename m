Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AC163A838
	for <lists+linux-crypto@lfdr.de>; Mon, 28 Nov 2022 13:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiK1MYZ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 28 Nov 2022 07:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiK1MXc (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 28 Nov 2022 07:23:32 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9016BC3B
        for <linux-crypto@vger.kernel.org>; Mon, 28 Nov 2022 04:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669638117; x=1701174117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cxq+fBuTbTWierXGKNFjFsEe5CVatOwSdyfqcErgsXk=;
  b=GgfuNws/yYYLVL2tPo1QhUklPz8e/lPooAjB0mJUcipq8+Odkji5YF1V
   pa87reygsd/IADi9llLY/GTLez6XATUFHiIUBx6/RLWSL+sEDNo+CSG+r
   vp9PIXYm4LNLbcBCpYegK4rEoT4AnZotRTPeOjleaQLRjXpaa0/Mo1pAW
   /p5mXd8PTNYMuRpDULumd2gdr/8qX744I4xuJA4Ap6NK1VWYTotGMRxrD
   oyZM2UIYefin/f07cmMszFIURBZa/fJIGz57NjCUvOSxKnDPR6h45063N
   Hi4yKO02+t+lQqzelRBWhRs+yYmmjUaTYPEpel45c4UgUXat1xNZ8cZjR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="313517849"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="313517849"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 04:21:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="817806184"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="817806184"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.76])
  by orsmga005.jf.intel.com with ESMTP; 28 Nov 2022 04:21:49 -0800
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Vlad Dronov <vdronov@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Adam Guerin <adam.guerin@intel.com>
Subject: [PATCH v3 09/12] crypto: qat - expose deflate through acomp api for QAT GEN2
Date:   Mon, 28 Nov 2022 12:21:20 +0000
Message-Id: <20221128122123.130459-10-giovanni.cabiddu@intel.com>
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

Add infrastructure for implementing the acomp APIs in the QAT driver and
expose the deflate algorithm for QAT GEN2 devices.
This adds
  (1) the compression service which includes logic to create, allocate
  and handle compression instances;
  (2) logic to create configuration entries at probe time for the
  compression instances;
  (3) updates to the firmware API for allowing the compression service;
  and;
  (4) a back-end for deflate that implements the acomp api for QAT GEN2
  devices.

The implementation configures the device to produce data compressed
statically, optimized for throughput over compression ratio.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
Reviewed-by: Adam Guerin <adam.guerin@intel.com>
---
 drivers/crypto/qat/qat_4xxx/adf_drv.c         |   6 +
 .../crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c  |   2 +
 .../qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c     |   2 +
 .../crypto/qat/qat_c62x/adf_c62x_hw_data.c    |   2 +
 .../qat/qat_c62xvf/adf_c62xvf_hw_data.c       |   2 +
 drivers/crypto/qat/qat_common/Makefile        |   3 +
 .../crypto/qat/qat_common/adf_accel_devices.h |  14 +
 .../crypto/qat/qat_common/adf_cfg_strings.h   |   1 +
 .../crypto/qat/qat_common/adf_common_drv.h    |   8 +
 drivers/crypto/qat/qat_common/adf_ctl_drv.c   |   6 +
 .../crypto/qat/qat_common/adf_gen2_config.c   |  99 ++++-
 drivers/crypto/qat/qat_common/adf_gen2_dc.c   |  70 +++
 drivers/crypto/qat/qat_common/adf_gen2_dc.h   |  10 +
 drivers/crypto/qat/qat_common/adf_init.c      |  11 +
 drivers/crypto/qat/qat_common/adf_sriov.c     |   4 +
 drivers/crypto/qat/qat_common/icp_qat_fw.h    |  24 ++
 .../crypto/qat/qat_common/icp_qat_fw_comp.h   | 404 ++++++++++++++++++
 drivers/crypto/qat/qat_common/icp_qat_hw.h    |  66 +++
 drivers/crypto/qat/qat_common/qat_comp_algs.c | 274 ++++++++++++
 drivers/crypto/qat/qat_common/qat_comp_req.h  | 113 +++++
 .../crypto/qat/qat_common/qat_compression.c   | 297 +++++++++++++
 .../crypto/qat/qat_common/qat_compression.h   |  37 ++
 .../qat/qat_dh895xcc/adf_dh895xcc_hw_data.c   |   2 +
 .../qat_dh895xccvf/adf_dh895xccvf_hw_data.c   |   2 +
 24 files changed, 1447 insertions(+), 12 deletions(-)
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen2_dc.c
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen2_dc.h
 create mode 100644 drivers/crypto/qat/qat_common/icp_qat_fw_comp.h
 create mode 100644 drivers/crypto/qat/qat_common/qat_comp_algs.c
 create mode 100644 drivers/crypto/qat/qat_common/qat_comp_req.h
 create mode 100644 drivers/crypto/qat/qat_common/qat_compression.c
 create mode 100644 drivers/crypto/qat/qat_common/qat_compression.h

diff --git a/drivers/crypto/qat/qat_4xxx/adf_drv.c b/drivers/crypto/qat/qat_4xxx/adf_drv.c
index 670a58b25cb1..8496c451b48e 100644
--- a/drivers/crypto/qat/qat_4xxx/adf_drv.c
+++ b/drivers/crypto/qat/qat_4xxx/adf_drv.c
@@ -155,6 +155,12 @@ int adf_crypto_dev_config(struct adf_accel_dev *accel_dev)
 	if (ret)
 		goto err;
 
+	val = 0;
+	ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC, ADF_NUM_DC,
+					  &val, ADF_DEC);
+	if (ret)
+		goto err;
+
 	set_bit(ADF_STATUS_CONFIGURED, &accel_dev->status);
 	return 0;
 err:
diff --git a/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c b/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
index c0519a79060a..c55c51a07677 100644
--- a/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
+++ b/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
@@ -3,6 +3,7 @@
 #include <adf_accel_devices.h>
 #include <adf_common_drv.h>
 #include <adf_gen2_config.h>
+#include <adf_gen2_dc.h>
 #include <adf_gen2_hw_data.h>
 #include <adf_gen2_pfvf.h>
 #include "adf_c3xxx_hw_data.h"
@@ -129,6 +130,7 @@ void adf_init_hw_data_c3xxx(struct adf_hw_device_data *hw_data)
 
 	adf_gen2_init_pf_pfvf_ops(&hw_data->pfvf_ops);
 	adf_gen2_init_hw_csr_ops(&hw_data->csr_ops);
+	adf_gen2_init_dc_ops(&hw_data->dc_ops);
 }
 
 void adf_clean_hw_data_c3xxx(struct adf_hw_device_data *hw_data)
diff --git a/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c b/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c
index 6c37dda6da2e..84d9486e04de 100644
--- a/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c
+++ b/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c
@@ -3,6 +3,7 @@
 #include <adf_accel_devices.h>
 #include <adf_common_drv.h>
 #include <adf_gen2_config.h>
+#include <adf_gen2_dc.h>
 #include <adf_gen2_hw_data.h>
 #include <adf_gen2_pfvf.h>
 #include <adf_pfvf_vf_msg.h>
@@ -91,6 +92,7 @@ void adf_init_hw_data_c3xxxiov(struct adf_hw_device_data *hw_data)
 	adf_devmgr_update_class_index(hw_data);
 	adf_gen2_init_vf_pfvf_ops(&hw_data->pfvf_ops);
 	adf_gen2_init_hw_csr_ops(&hw_data->csr_ops);
+	adf_gen2_init_dc_ops(&hw_data->dc_ops);
 }
 
 void adf_clean_hw_data_c3xxxiov(struct adf_hw_device_data *hw_data)
diff --git a/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c b/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
index 689358cb7bb0..b7aa19d2fa80 100644
--- a/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
+++ b/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
@@ -3,6 +3,7 @@
 #include <adf_accel_devices.h>
 #include <adf_common_drv.h>
 #include <adf_gen2_config.h>
+#include <adf_gen2_dc.h>
 #include <adf_gen2_hw_data.h>
 #include <adf_gen2_pfvf.h>
 #include "adf_c62x_hw_data.h"
@@ -131,6 +132,7 @@ void adf_init_hw_data_c62x(struct adf_hw_device_data *hw_data)
 
 	adf_gen2_init_pf_pfvf_ops(&hw_data->pfvf_ops);
 	adf_gen2_init_hw_csr_ops(&hw_data->csr_ops);
+	adf_gen2_init_dc_ops(&hw_data->dc_ops);
 }
 
 void adf_clean_hw_data_c62x(struct adf_hw_device_data *hw_data)
diff --git a/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c b/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c
index 521110ecd07f..751d7aa57fc7 100644
--- a/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c
+++ b/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c
@@ -3,6 +3,7 @@
 #include <adf_accel_devices.h>
 #include <adf_common_drv.h>
 #include <adf_gen2_config.h>
+#include <adf_gen2_dc.h>
 #include <adf_gen2_hw_data.h>
 #include <adf_gen2_pfvf.h>
 #include <adf_pfvf_vf_msg.h>
@@ -91,6 +92,7 @@ void adf_init_hw_data_c62xiov(struct adf_hw_device_data *hw_data)
 	adf_devmgr_update_class_index(hw_data);
 	adf_gen2_init_vf_pfvf_ops(&hw_data->pfvf_ops);
 	adf_gen2_init_hw_csr_ops(&hw_data->csr_ops);
+	adf_gen2_init_dc_ops(&hw_data->dc_ops);
 }
 
 void adf_clean_hw_data_c62xiov(struct adf_hw_device_data *hw_data)
diff --git a/drivers/crypto/qat/qat_common/Makefile b/drivers/crypto/qat/qat_common/Makefile
index b59b6315134b..e3db4786738f 100644
--- a/drivers/crypto/qat/qat_common/Makefile
+++ b/drivers/crypto/qat/qat_common/Makefile
@@ -15,7 +15,10 @@ intel_qat-objs := adf_cfg.o \
 	adf_gen2_config.o \
 	adf_gen4_hw_data.o \
 	adf_gen4_pm.o \
+	adf_gen2_dc.o \
 	qat_crypto.o \
+	qat_compression.o \
+	qat_comp_algs.o \
 	qat_algs.o \
 	qat_asym_algs.o \
 	qat_algs_send.o \
diff --git a/drivers/crypto/qat/qat_common/adf_accel_devices.h b/drivers/crypto/qat/qat_common/adf_accel_devices.h
index 0a55a4f34dcf..284f5aad3ee0 100644
--- a/drivers/crypto/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/qat/qat_common/adf_accel_devices.h
@@ -163,6 +163,10 @@ struct adf_pfvf_ops {
 					u32 pfvf_offset, u8 compat_ver);
 };
 
+struct adf_dc_ops {
+	void (*build_deflate_ctx)(void *ctx);
+};
+
 struct adf_hw_device_data {
 	struct adf_hw_device_class *dev_class;
 	u32 (*get_accel_mask)(struct adf_hw_device_data *self);
@@ -202,6 +206,7 @@ struct adf_hw_device_data {
 	int (*dev_config)(struct adf_accel_dev *accel_dev);
 	struct adf_pfvf_ops pfvf_ops;
 	struct adf_hw_csr_ops csr_ops;
+	struct adf_dc_ops dc_ops;
 	const char *fw_name;
 	const char *fw_mmp_name;
 	u32 fuses;
@@ -247,6 +252,7 @@ struct adf_hw_device_data {
 #define GET_MAX_ACCELENGINES(accel_dev) (GET_HW_DATA(accel_dev)->num_engines)
 #define GET_CSR_OPS(accel_dev) (&(accel_dev)->hw_device->csr_ops)
 #define GET_PFVF_OPS(accel_dev) (&(accel_dev)->hw_device->pfvf_ops)
+#define GET_DC_OPS(accel_dev) (&(accel_dev)->hw_device->dc_ops)
 #define accel_to_pci_dev(accel_ptr) accel_ptr->accel_pci_dev.pci_dev
 
 struct adf_admin_comms;
@@ -266,13 +272,21 @@ struct adf_accel_vf_info {
 	u8 vf_compat_ver;
 };
 
+struct adf_dc_data {
+	u8 *ovf_buff;
+	size_t ovf_buff_sz;
+	dma_addr_t ovf_buff_p;
+};
+
 struct adf_accel_dev {
 	struct adf_etr_data *transport;
 	struct adf_hw_device_data *hw_device;
 	struct adf_cfg_device_data *cfg;
 	struct adf_fw_loader_data *fw_loader;
 	struct adf_admin_comms *admin;
+	struct adf_dc_data *dc_data;
 	struct list_head crypto_list;
+	struct list_head compression_list;
 	unsigned long status;
 	atomic_t ref_count;
 	struct dentry *debugfs_dir;
diff --git a/drivers/crypto/qat/qat_common/adf_cfg_strings.h b/drivers/crypto/qat/qat_common/adf_cfg_strings.h
index 655248dbf962..5d8c3bdb258c 100644
--- a/drivers/crypto/qat/qat_common/adf_cfg_strings.h
+++ b/drivers/crypto/qat/qat_common/adf_cfg_strings.h
@@ -20,6 +20,7 @@
 #define ADF_ETRMGR_BANK "Bank"
 #define ADF_RING_SYM_BANK_NUM "BankSymNumber"
 #define ADF_RING_ASYM_BANK_NUM "BankAsymNumber"
+#define ADF_RING_DC_BANK_NUM "BankDcNumber"
 #define ADF_CY "Cy"
 #define ADF_DC "Dc"
 #define ADF_CFG_DC "dc"
diff --git a/drivers/crypto/qat/qat_common/adf_common_drv.h b/drivers/crypto/qat/qat_common/adf_common_drv.h
index b8ec0268d2d2..7189265573c0 100644
--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
@@ -120,6 +120,14 @@ void qat_algs_unregister(void);
 int qat_asym_algs_register(void);
 void qat_asym_algs_unregister(void);
 
+struct qat_compression_instance *qat_compression_get_instance_node(int node);
+void qat_compression_put_instance(struct qat_compression_instance *inst);
+int qat_compression_register(void);
+int qat_compression_unregister(void);
+int qat_comp_algs_register(void);
+void qat_comp_algs_unregister(void);
+void qat_comp_alg_callback(void *resp);
+
 int adf_isr_resource_alloc(struct adf_accel_dev *accel_dev);
 void adf_isr_resource_free(struct adf_accel_dev *accel_dev);
 int adf_vf_isr_resource_alloc(struct adf_accel_dev *accel_dev);
diff --git a/drivers/crypto/qat/qat_common/adf_ctl_drv.c b/drivers/crypto/qat/qat_common/adf_ctl_drv.c
index 82b69e1f725b..9190532b27eb 100644
--- a/drivers/crypto/qat/qat_common/adf_ctl_drv.c
+++ b/drivers/crypto/qat/qat_common/adf_ctl_drv.c
@@ -438,8 +438,13 @@ static int __init adf_register_ctl_device_driver(void)
 	if (qat_crypto_register())
 		goto err_crypto_register;
 
+	if (qat_compression_register())
+		goto err_compression_register;
+
 	return 0;
 
+err_compression_register:
+	qat_crypto_unregister();
 err_crypto_register:
 	adf_exit_vf_wq();
 err_vf_wq:
@@ -463,6 +468,7 @@ static void __exit adf_unregister_ctl_device_driver(void)
 	adf_exit_vf_wq();
 	adf_exit_pf_wq();
 	qat_crypto_unregister();
+	qat_compression_unregister();
 	adf_clean_vf_map(false);
 	mutex_destroy(&adf_ctl_lock);
 }
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_config.c b/drivers/crypto/qat/qat_common/adf_gen2_config.c
index 1c490e1859a7..eeb30da7587a 100644
--- a/drivers/crypto/qat/qat_common/adf_gen2_config.c
+++ b/drivers/crypto/qat/qat_common/adf_gen2_config.c
@@ -6,6 +6,7 @@
 #include "adf_gen2_config.h"
 #include "adf_common_drv.h"
 #include "qat_crypto.h"
+#include "qat_compression.h"
 #include "adf_transport_access_macros.h"
 
 static int adf_gen2_crypto_dev_config(struct adf_accel_dev *accel_dev)
@@ -23,14 +24,6 @@ static int adf_gen2_crypto_dev_config(struct adf_accel_dev *accel_dev)
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
 		snprintf(key, sizeof(key), ADF_CY "%d" ADF_RING_ASYM_BANK_NUM, i);
@@ -108,10 +101,68 @@ static int adf_gen2_crypto_dev_config(struct adf_accel_dev *accel_dev)
 	if (ret)
 		goto err;
 
-	set_bit(ADF_STATUS_CONFIGURED, &accel_dev->status);
-	return 0;
+	return ret;
+
+err:
+	dev_err(&GET_DEV(accel_dev), "Failed to add configuration for crypto\n");
+	return ret;
+}
+
+static int adf_gen2_comp_dev_config(struct adf_accel_dev *accel_dev)
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
+		val = 6;
+		snprintf(key, sizeof(key), ADF_DC "%d" ADF_RING_DC_TX, i);
+		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
+						  key, &val, ADF_DEC);
+		if (ret)
+			goto err;
+
+		val = 14;
+		snprintf(key, sizeof(key), ADF_DC "%d" ADF_RING_DC_RX, i);
+		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
+						  key, &val, ADF_DEC);
+		if (ret)
+			goto err;
+	}
+
+	val = i;
+	ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC, ADF_NUM_DC,
+					  &val, ADF_DEC);
+	if (ret)
+		return ret;
+
+	return ret;
+
 err:
-	dev_err(&GET_DEV(accel_dev), "Failed to start QAT accel dev\n");
+	dev_err(&GET_DEV(accel_dev), "Failed to add configuration for compression\n");
 	return ret;
 }
 
@@ -126,6 +177,30 @@ static int adf_gen2_crypto_dev_config(struct adf_accel_dev *accel_dev)
  */
 int adf_gen2_dev_config(struct adf_accel_dev *accel_dev)
 {
-	return adf_gen2_crypto_dev_config(accel_dev);
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
+	ret = adf_gen2_crypto_dev_config(accel_dev);
+	if (ret)
+		goto err;
+
+	ret = adf_gen2_comp_dev_config(accel_dev);
+	if (ret)
+		goto err;
+
+	set_bit(ADF_STATUS_CONFIGURED, &accel_dev->status);
+
+	return ret;
+
+err:
+	dev_err(&GET_DEV(accel_dev), "Failed to configure QAT driver\n");
+	return ret;
 }
 EXPORT_SYMBOL_GPL(adf_gen2_dev_config);
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_dc.c b/drivers/crypto/qat/qat_common/adf_gen2_dc.c
new file mode 100644
index 000000000000..47261b1c1da6
--- /dev/null
+++ b/drivers/crypto/qat/qat_common/adf_gen2_dc.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation */
+#include "adf_accel_devices.h"
+#include "adf_gen2_dc.h"
+#include "icp_qat_fw_comp.h"
+
+static void qat_comp_build_deflate_ctx(void *ctx)
+{
+	struct icp_qat_fw_comp_req *req_tmpl = (struct icp_qat_fw_comp_req *)ctx;
+	struct icp_qat_fw_comn_req_hdr *header = &req_tmpl->comn_hdr;
+	struct icp_qat_fw_comp_req_hdr_cd_pars *cd_pars = &req_tmpl->cd_pars;
+	struct icp_qat_fw_comp_req_params *req_pars = &req_tmpl->comp_pars;
+	struct icp_qat_fw_comp_cd_hdr *comp_cd_ctrl = &req_tmpl->comp_cd_ctrl;
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
+					    ICP_QAT_FW_COMP_NOT_AUTO_SELECT_BEST,
+					    ICP_QAT_FW_COMP_NOT_ENH_AUTO_SELECT_BEST,
+					    ICP_QAT_FW_COMP_NOT_DISABLE_TYPE0_ENH_AUTO_SELECT_BEST,
+					    ICP_QAT_FW_COMP_ENABLE_SECURE_RAM_USED_AS_INTMD_BUF);
+	cd_pars->u.sl.comp_slice_cfg_word[0] =
+		ICP_QAT_HW_COMPRESSION_CONFIG_BUILD(ICP_QAT_HW_COMPRESSION_DIR_COMPRESS,
+						    ICP_QAT_HW_COMPRESSION_DELAYED_MATCH_DISABLED,
+						    ICP_QAT_HW_COMPRESSION_ALGO_DEFLATE,
+						    ICP_QAT_HW_COMPRESSION_DEPTH_1,
+						    ICP_QAT_HW_COMPRESSION_FILE_TYPE_0);
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
+	ICP_QAT_FW_COMN_NEXT_ID_SET(comp_cd_ctrl, ICP_QAT_FW_SLICE_DRAM_WR);
+	ICP_QAT_FW_COMN_CURR_ID_SET(comp_cd_ctrl, ICP_QAT_FW_SLICE_COMP);
+
+	/* Fill second half of the template for decompression */
+	memcpy(req_tmpl + 1, req_tmpl, sizeof(*req_tmpl));
+	req_tmpl++;
+	header = &req_tmpl->comn_hdr;
+	header->service_cmd_id = ICP_QAT_FW_COMP_CMD_DECOMPRESS;
+	cd_pars = &req_tmpl->cd_pars;
+	cd_pars->u.sl.comp_slice_cfg_word[0] =
+		ICP_QAT_HW_COMPRESSION_CONFIG_BUILD(ICP_QAT_HW_COMPRESSION_DIR_DECOMPRESS,
+						    ICP_QAT_HW_COMPRESSION_DELAYED_MATCH_DISABLED,
+						    ICP_QAT_HW_COMPRESSION_ALGO_DEFLATE,
+						    ICP_QAT_HW_COMPRESSION_DEPTH_1,
+						    ICP_QAT_HW_COMPRESSION_FILE_TYPE_0);
+}
+
+void adf_gen2_init_dc_ops(struct adf_dc_ops *dc_ops)
+{
+	dc_ops->build_deflate_ctx = qat_comp_build_deflate_ctx;
+}
+EXPORT_SYMBOL_GPL(adf_gen2_init_dc_ops);
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_dc.h b/drivers/crypto/qat/qat_common/adf_gen2_dc.h
new file mode 100644
index 000000000000..6eae023354d7
--- /dev/null
+++ b/drivers/crypto/qat/qat_common/adf_gen2_dc.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2022 Intel Corporation */
+#ifndef ADF_GEN2_DC_H
+#define ADF_GEN2_DC_H
+
+#include "adf_accel_devices.h"
+
+void adf_gen2_init_dc_ops(struct adf_dc_ops *dc_ops);
+
+#endif /* ADF_GEN2_DC_H */
diff --git a/drivers/crypto/qat/qat_common/adf_init.c b/drivers/crypto/qat/qat_common/adf_init.c
index 33a9a46d6949..cef7bb8ec007 100644
--- a/drivers/crypto/qat/qat_common/adf_init.c
+++ b/drivers/crypto/qat/qat_common/adf_init.c
@@ -209,6 +209,14 @@ int adf_dev_start(struct adf_accel_dev *accel_dev)
 		clear_bit(ADF_STATUS_STARTED, &accel_dev->status);
 		return -EFAULT;
 	}
+
+	if (!list_empty(&accel_dev->compression_list) && qat_comp_algs_register()) {
+		dev_err(&GET_DEV(accel_dev),
+			"Failed to register compression algs\n");
+		set_bit(ADF_STATUS_STARTING, &accel_dev->status);
+		clear_bit(ADF_STATUS_STARTED, &accel_dev->status);
+		return -EFAULT;
+	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(adf_dev_start);
@@ -242,6 +250,9 @@ void adf_dev_stop(struct adf_accel_dev *accel_dev)
 		qat_asym_algs_unregister();
 	}
 
+	if (!list_empty(&accel_dev->compression_list))
+		qat_comp_algs_unregister();
+
 	list_for_each(list_itr, &service_table) {
 		service = list_entry(list_itr, struct service_hndl, list);
 		if (!test_bit(accel_dev->accel_id, service->start_status))
diff --git a/drivers/crypto/qat/qat_common/adf_sriov.c b/drivers/crypto/qat/qat_common/adf_sriov.c
index b2db1d70d71f..d85a90cc387b 100644
--- a/drivers/crypto/qat/qat_common/adf_sriov.c
+++ b/drivers/crypto/qat/qat_common/adf_sriov.c
@@ -170,6 +170,10 @@ int adf_sriov_configure(struct pci_dev *pdev, int numvfs)
 	if (adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
 					ADF_NUM_CY, (void *)&val, ADF_DEC))
 		return -EFAULT;
+	ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC, ADF_NUM_DC,
+					  &val, ADF_DEC);
+	if (ret)
+		return ret;
 
 	set_bit(ADF_STATUS_CONFIGURED, &accel_dev->status);
 
diff --git a/drivers/crypto/qat/qat_common/icp_qat_fw.h b/drivers/crypto/qat/qat_common/icp_qat_fw.h
index 6dc09d270082..c141160421e1 100644
--- a/drivers/crypto/qat/qat_common/icp_qat_fw.h
+++ b/drivers/crypto/qat/qat_common/icp_qat_fw.h
@@ -116,6 +116,10 @@ struct icp_qat_fw_comn_resp {
 #define ICP_QAT_FW_COMN_VALID_FLAG_BITPOS 7
 #define ICP_QAT_FW_COMN_VALID_FLAG_MASK 0x1
 #define ICP_QAT_FW_COMN_HDR_RESRVD_FLD_MASK 0x7F
+#define ICP_QAT_FW_COMN_CNV_FLAG_BITPOS 6
+#define ICP_QAT_FW_COMN_CNV_FLAG_MASK 0x1
+#define ICP_QAT_FW_COMN_CNVNR_FLAG_BITPOS 5
+#define ICP_QAT_FW_COMN_CNVNR_FLAG_MASK 0x1
 
 #define ICP_QAT_FW_COMN_OV_SRV_TYPE_GET(icp_qat_fw_comn_req_hdr_t) \
 	icp_qat_fw_comn_req_hdr_t.service_type
@@ -132,6 +136,26 @@ struct icp_qat_fw_comn_resp {
 #define ICP_QAT_FW_COMN_HDR_VALID_FLAG_GET(hdr_t) \
 	ICP_QAT_FW_COMN_VALID_FLAG_GET(hdr_t.hdr_flags)
 
+#define ICP_QAT_FW_COMN_HDR_CNVNR_FLAG_GET(hdr_flags) \
+	QAT_FIELD_GET(hdr_flags, \
+	ICP_QAT_FW_COMN_CNVNR_FLAG_BITPOS, \
+	ICP_QAT_FW_COMN_CNVNR_FLAG_MASK)
+
+#define ICP_QAT_FW_COMN_HDR_CNVNR_FLAG_SET(hdr_t, val) \
+	QAT_FIELD_SET((hdr_t.hdr_flags), (val), \
+	ICP_QAT_FW_COMN_CNVNR_FLAG_BITPOS, \
+	ICP_QAT_FW_COMN_CNVNR_FLAG_MASK)
+
+#define ICP_QAT_FW_COMN_HDR_CNV_FLAG_GET(hdr_flags) \
+	QAT_FIELD_GET(hdr_flags, \
+	ICP_QAT_FW_COMN_CNV_FLAG_BITPOS, \
+	ICP_QAT_FW_COMN_CNV_FLAG_MASK)
+
+#define ICP_QAT_FW_COMN_HDR_CNV_FLAG_SET(hdr_t, val) \
+	QAT_FIELD_SET((hdr_t.hdr_flags), (val), \
+	ICP_QAT_FW_COMN_CNV_FLAG_BITPOS, \
+	ICP_QAT_FW_COMN_CNV_FLAG_MASK)
+
 #define ICP_QAT_FW_COMN_HDR_VALID_FLAG_SET(hdr_t, val) \
 	ICP_QAT_FW_COMN_VALID_FLAG_SET(hdr_t, val)
 
diff --git a/drivers/crypto/qat/qat_common/icp_qat_fw_comp.h b/drivers/crypto/qat/qat_common/icp_qat_fw_comp.h
new file mode 100644
index 000000000000..a03d43fef2b3
--- /dev/null
+++ b/drivers/crypto/qat/qat_common/icp_qat_fw_comp.h
@@ -0,0 +1,404 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2022 Intel Corporation */
+#ifndef _ICP_QAT_FW_COMP_H_
+#define _ICP_QAT_FW_COMP_H_
+#include "icp_qat_fw.h"
+
+enum icp_qat_fw_comp_cmd_id {
+	ICP_QAT_FW_COMP_CMD_STATIC = 0,
+	ICP_QAT_FW_COMP_CMD_DYNAMIC = 1,
+	ICP_QAT_FW_COMP_CMD_DECOMPRESS = 2,
+	ICP_QAT_FW_COMP_CMD_DELIMITER
+};
+
+enum icp_qat_fw_comp_20_cmd_id {
+	ICP_QAT_FW_COMP_20_CMD_LZ4_COMPRESS = 3,
+	ICP_QAT_FW_COMP_20_CMD_LZ4_DECOMPRESS = 4,
+	ICP_QAT_FW_COMP_20_CMD_LZ4S_COMPRESS = 5,
+	ICP_QAT_FW_COMP_20_CMD_LZ4S_DECOMPRESS = 6,
+	ICP_QAT_FW_COMP_20_CMD_XP10_COMPRESS = 7,
+	ICP_QAT_FW_COMP_20_CMD_XP10_DECOMPRESS = 8,
+	ICP_QAT_FW_COMP_20_CMD_RESERVED_9 = 9,
+	ICP_QAT_FW_COMP_23_CMD_ZSTD_COMPRESS = 10,
+	ICP_QAT_FW_COMP_23_CMD_ZSTD_DECOMPRESS = 11,
+	ICP_QAT_FW_COMP_20_CMD_DELIMITER
+};
+
+#define ICP_QAT_FW_COMP_STATELESS_SESSION 0
+#define ICP_QAT_FW_COMP_STATEFUL_SESSION 1
+#define ICP_QAT_FW_COMP_NOT_AUTO_SELECT_BEST 0
+#define ICP_QAT_FW_COMP_AUTO_SELECT_BEST 1
+#define ICP_QAT_FW_COMP_NOT_ENH_AUTO_SELECT_BEST 0
+#define ICP_QAT_FW_COMP_ENH_AUTO_SELECT_BEST 1
+#define ICP_QAT_FW_COMP_NOT_DISABLE_TYPE0_ENH_AUTO_SELECT_BEST 0
+#define ICP_QAT_FW_COMP_DISABLE_TYPE0_ENH_AUTO_SELECT_BEST 1
+#define ICP_QAT_FW_COMP_DISABLE_SECURE_RAM_USED_AS_INTMD_BUF 1
+#define ICP_QAT_FW_COMP_ENABLE_SECURE_RAM_USED_AS_INTMD_BUF 0
+#define ICP_QAT_FW_COMP_SESSION_TYPE_BITPOS 2
+#define ICP_QAT_FW_COMP_SESSION_TYPE_MASK 0x1
+#define ICP_QAT_FW_COMP_AUTO_SELECT_BEST_BITPOS 3
+#define ICP_QAT_FW_COMP_AUTO_SELECT_BEST_MASK 0x1
+#define ICP_QAT_FW_COMP_ENHANCED_AUTO_SELECT_BEST_BITPOS 4
+#define ICP_QAT_FW_COMP_ENHANCED_AUTO_SELECT_BEST_MASK 0x1
+#define ICP_QAT_FW_COMP_RET_DISABLE_TYPE0_HEADER_DATA_BITPOS 5
+#define ICP_QAT_FW_COMP_RET_DISABLE_TYPE0_HEADER_DATA_MASK 0x1
+#define ICP_QAT_FW_COMP_DISABLE_SECURE_RAM_AS_INTMD_BUF_BITPOS 7
+#define ICP_QAT_FW_COMP_DISABLE_SECURE_RAM_AS_INTMD_BUF_MASK 0x1
+
+#define ICP_QAT_FW_COMP_FLAGS_BUILD(sesstype, autoselect, enhanced_asb, \
+	ret_uncomp, secure_ram) \
+	((((sesstype) & ICP_QAT_FW_COMP_SESSION_TYPE_MASK) << \
+	ICP_QAT_FW_COMP_SESSION_TYPE_BITPOS) | \
+	(((autoselect) & ICP_QAT_FW_COMP_AUTO_SELECT_BEST_MASK) << \
+	ICP_QAT_FW_COMP_AUTO_SELECT_BEST_BITPOS) | \
+	(((enhanced_asb) & ICP_QAT_FW_COMP_ENHANCED_AUTO_SELECT_BEST_MASK) << \
+	ICP_QAT_FW_COMP_ENHANCED_AUTO_SELECT_BEST_BITPOS) | \
+	(((ret_uncomp) & ICP_QAT_FW_COMP_RET_DISABLE_TYPE0_HEADER_DATA_MASK) << \
+	ICP_QAT_FW_COMP_RET_DISABLE_TYPE0_HEADER_DATA_BITPOS) | \
+	(((secure_ram) & ICP_QAT_FW_COMP_DISABLE_SECURE_RAM_AS_INTMD_BUF_MASK) << \
+	ICP_QAT_FW_COMP_DISABLE_SECURE_RAM_AS_INTMD_BUF_BITPOS))
+
+#define ICP_QAT_FW_COMP_SESSION_TYPE_GET(flags) \
+	QAT_FIELD_GET(flags, ICP_QAT_FW_COMP_SESSION_TYPE_BITPOS, \
+	ICP_QAT_FW_COMP_SESSION_TYPE_MASK)
+
+#define ICP_QAT_FW_COMP_SESSION_TYPE_SET(flags, val) \
+	QAT_FIELD_SET(flags, val, ICP_QAT_FW_COMP_SESSION_TYPE_BITPOS, \
+	ICP_QAT_FW_COMP_SESSION_TYPE_MASK)
+
+#define ICP_QAT_FW_COMP_AUTO_SELECT_BEST_GET(flags) \
+	QAT_FIELD_GET(flags, ICP_QAT_FW_COMP_AUTO_SELECT_BEST_BITPOS, \
+	ICP_QAT_FW_COMP_AUTO_SELECT_BEST_MASK)
+
+#define ICP_QAT_FW_COMP_EN_ASB_GET(flags) \
+	QAT_FIELD_GET(flags, ICP_QAT_FW_COMP_ENHANCED_AUTO_SELECT_BEST_BITPOS, \
+	ICP_QAT_FW_COMP_ENHANCED_AUTO_SELECT_BEST_MASK)
+
+#define ICP_QAT_FW_COMP_RET_UNCOMP_GET(flags) \
+	QAT_FIELD_GET(flags, \
+	ICP_QAT_FW_COMP_RET_DISABLE_TYPE0_HEADER_DATA_BITPOS, \
+	ICP_QAT_FW_COMP_RET_DISABLE_TYPE0_HEADER_DATA_MASK)
+
+#define ICP_QAT_FW_COMP_SECURE_RAM_USE_GET(flags) \
+	QAT_FIELD_GET(flags, \
+	ICP_QAT_FW_COMP_DISABLE_SECURE_RAM_AS_INTMD_BUF_BITPOS, \
+	ICP_QAT_FW_COMP_DISABLE_SECURE_RAM_AS_INTMD_BUF_MASK)
+
+struct icp_qat_fw_comp_req_hdr_cd_pars {
+	union {
+		struct {
+			__u64 content_desc_addr;
+			__u16 content_desc_resrvd1;
+			__u8 content_desc_params_sz;
+			__u8 content_desc_hdr_resrvd2;
+			__u32 content_desc_resrvd3;
+		} s;
+		struct {
+			__u32 comp_slice_cfg_word[ICP_QAT_FW_NUM_LONGWORDS_2];
+			__u32 content_desc_resrvd4;
+		} sl;
+	} u;
+};
+
+struct icp_qat_fw_comp_req_params {
+	__u32 comp_len;
+	__u32 out_buffer_sz;
+	union {
+		struct {
+			__u32 initial_crc32;
+			__u32 initial_adler;
+		} legacy;
+		__u64 crc_data_addr;
+	} crc;
+	__u32 req_par_flags;
+	__u32 rsrvd;
+};
+
+#define ICP_QAT_FW_COMP_REQ_PARAM_FLAGS_BUILD(sop, eop, bfinal, cnv, cnvnr, \
+					      cnvdfx, crc, xxhash_acc, \
+					      cnv_error_type, append_crc, \
+					      drop_data) \
+	((((sop) & ICP_QAT_FW_COMP_SOP_MASK) << \
+	ICP_QAT_FW_COMP_SOP_BITPOS) | \
+	(((eop) & ICP_QAT_FW_COMP_EOP_MASK) << \
+	ICP_QAT_FW_COMP_EOP_BITPOS) | \
+	(((bfinal) & ICP_QAT_FW_COMP_BFINAL_MASK) \
+	<< ICP_QAT_FW_COMP_BFINAL_BITPOS) | \
+	(((cnv) & ICP_QAT_FW_COMP_CNV_MASK) << \
+	ICP_QAT_FW_COMP_CNV_BITPOS) | \
+	(((cnvnr) & ICP_QAT_FW_COMP_CNVNR_MASK) \
+	<< ICP_QAT_FW_COMP_CNVNR_BITPOS) | \
+	(((cnvdfx) & ICP_QAT_FW_COMP_CNV_DFX_MASK) \
+	<< ICP_QAT_FW_COMP_CNV_DFX_BITPOS) | \
+	(((crc) & ICP_QAT_FW_COMP_CRC_MODE_MASK) \
+	<< ICP_QAT_FW_COMP_CRC_MODE_BITPOS) | \
+	(((xxhash_acc) & ICP_QAT_FW_COMP_XXHASH_ACC_MODE_MASK) \
+	<< ICP_QAT_FW_COMP_XXHASH_ACC_MODE_BITPOS) | \
+	(((cnv_error_type) & ICP_QAT_FW_COMP_CNV_ERROR_MASK) \
+	<< ICP_QAT_FW_COMP_CNV_ERROR_BITPOS) | \
+	(((append_crc) & ICP_QAT_FW_COMP_APPEND_CRC_MASK) \
+	<< ICP_QAT_FW_COMP_APPEND_CRC_BITPOS) | \
+	(((drop_data) & ICP_QAT_FW_COMP_DROP_DATA_MASK) \
+	<< ICP_QAT_FW_COMP_DROP_DATA_BITPOS))
+
+#define ICP_QAT_FW_COMP_NOT_SOP 0
+#define ICP_QAT_FW_COMP_SOP 1
+#define ICP_QAT_FW_COMP_NOT_EOP 0
+#define ICP_QAT_FW_COMP_EOP 1
+#define ICP_QAT_FW_COMP_NOT_BFINAL 0
+#define ICP_QAT_FW_COMP_BFINAL 1
+#define ICP_QAT_FW_COMP_NO_CNV 0
+#define ICP_QAT_FW_COMP_CNV 1
+#define ICP_QAT_FW_COMP_NO_CNV_RECOVERY 0
+#define ICP_QAT_FW_COMP_CNV_RECOVERY 1
+#define ICP_QAT_FW_COMP_NO_CNV_DFX 0
+#define ICP_QAT_FW_COMP_CNV_DFX 1
+#define ICP_QAT_FW_COMP_CRC_MODE_LEGACY 0
+#define ICP_QAT_FW_COMP_CRC_MODE_E2E 1
+#define ICP_QAT_FW_COMP_NO_XXHASH_ACC 0
+#define ICP_QAT_FW_COMP_XXHASH_ACC 1
+#define ICP_QAT_FW_COMP_APPEND_CRC 1
+#define ICP_QAT_FW_COMP_NO_APPEND_CRC 0
+#define ICP_QAT_FW_COMP_DROP_DATA 1
+#define ICP_QAT_FW_COMP_NO_DROP_DATA 0
+#define ICP_QAT_FW_COMP_SOP_BITPOS 0
+#define ICP_QAT_FW_COMP_SOP_MASK 0x1
+#define ICP_QAT_FW_COMP_EOP_BITPOS 1
+#define ICP_QAT_FW_COMP_EOP_MASK 0x1
+#define ICP_QAT_FW_COMP_BFINAL_BITPOS 6
+#define ICP_QAT_FW_COMP_BFINAL_MASK 0x1
+#define ICP_QAT_FW_COMP_CNV_BITPOS 16
+#define ICP_QAT_FW_COMP_CNV_MASK 0x1
+#define ICP_QAT_FW_COMP_CNVNR_BITPOS 17
+#define ICP_QAT_FW_COMP_CNVNR_MASK 0x1
+#define ICP_QAT_FW_COMP_CNV_DFX_BITPOS 18
+#define ICP_QAT_FW_COMP_CNV_DFX_MASK 0x1
+#define ICP_QAT_FW_COMP_CRC_MODE_BITPOS 19
+#define ICP_QAT_FW_COMP_CRC_MODE_MASK 0x1
+#define ICP_QAT_FW_COMP_XXHASH_ACC_MODE_BITPOS 20
+#define ICP_QAT_FW_COMP_XXHASH_ACC_MODE_MASK 0x1
+#define ICP_QAT_FW_COMP_CNV_ERROR_BITPOS 21
+#define ICP_QAT_FW_COMP_CNV_ERROR_MASK 0b111
+#define ICP_QAT_FW_COMP_CNV_ERROR_NONE 0b000
+#define ICP_QAT_FW_COMP_CNV_ERROR_CHECKSUM 0b001
+#define ICP_QAT_FW_COMP_CNV_ERROR_DCPR_OBC_DIFF 0b010
+#define ICP_QAT_FW_COMP_CNV_ERROR_DCPR 0b011
+#define ICP_QAT_FW_COMP_CNV_ERROR_XLT 0b100
+#define ICP_QAT_FW_COMP_CNV_ERROR_DCPR_IBC_DIFF 0b101
+#define ICP_QAT_FW_COMP_APPEND_CRC_BITPOS 24
+#define ICP_QAT_FW_COMP_APPEND_CRC_MASK 0x1
+#define ICP_QAT_FW_COMP_DROP_DATA_BITPOS 25
+#define ICP_QAT_FW_COMP_DROP_DATA_MASK 0x1
+
+#define ICP_QAT_FW_COMP_SOP_GET(flags) \
+	QAT_FIELD_GET(flags, ICP_QAT_FW_COMP_SOP_BITPOS, \
+	ICP_QAT_FW_COMP_SOP_MASK)
+
+#define ICP_QAT_FW_COMP_SOP_SET(flags, val) \
+	QAT_FIELD_SET(flags, val, ICP_QAT_FW_COMP_SOP_BITPOS, \
+	ICP_QAT_FW_COMP_SOP_MASK)
+
+#define ICP_QAT_FW_COMP_EOP_GET(flags) \
+	QAT_FIELD_GET(flags, ICP_QAT_FW_COMP_EOP_BITPOS, \
+	ICP_QAT_FW_COMP_EOP_MASK)
+
+#define ICP_QAT_FW_COMP_EOP_SET(flags, val) \
+	QAT_FIELD_SET(flags, val, ICP_QAT_FW_COMP_EOP_BITPOS, \
+	ICP_QAT_FW_COMP_EOP_MASK)
+
+#define ICP_QAT_FW_COMP_BFINAL_GET(flags) \
+	QAT_FIELD_GET(flags, ICP_QAT_FW_COMP_BFINAL_BITPOS, \
+	ICP_QAT_FW_COMP_BFINAL_MASK)
+
+#define ICP_QAT_FW_COMP_BFINAL_SET(flags, val) \
+	QAT_FIELD_SET(flags, val, ICP_QAT_FW_COMP_BFINAL_BITPOS, \
+	ICP_QAT_FW_COMP_BFINAL_MASK)
+
+#define ICP_QAT_FW_COMP_CNV_GET(flags) \
+	QAT_FIELD_GET(flags, ICP_QAT_FW_COMP_CNV_BITPOS, \
+	ICP_QAT_FW_COMP_CNV_MASK)
+
+#define ICP_QAT_FW_COMP_CNVNR_GET(flags) \
+	QAT_FIELD_GET(flags, ICP_QAT_FW_COMP_CNVNR_BITPOS, \
+	ICP_QAT_FW_COMP_CNVNR_MASK)
+
+#define ICP_QAT_FW_COMP_CNV_DFX_GET(flags) \
+	QAT_FIELD_GET(flags, ICP_QAT_FW_COMP_CNV_DFX_BITPOS, \
+	ICP_QAT_FW_COMP_CNV_DFX_MASK)
+
+#define ICP_QAT_FW_COMP_CNV_DFX_SET(flags, val) \
+	QAT_FIELD_SET(flags, val, ICP_QAT_FW_COMP_CNV_DFX_BITPOS, \
+	ICP_QAT_FW_COMP_CNV_DFX_MASK)
+
+#define ICP_QAT_FW_COMP_CRC_MODE_GET(flags) \
+	QAT_FIELD_GET(flags, ICP_QAT_FW_COMP_CRC_MODE_BITPOS, \
+	ICP_QAT_FW_COMP_CRC_MODE_MASK)
+
+#define ICP_QAT_FW_COMP_XXHASH_ACC_MODE_GET(flags) \
+	QAT_FIELD_GET(flags, ICP_QAT_FW_COMP_XXHASH_ACC_MODE_BITPOS, \
+	ICP_QAT_FW_COMP_XXHASH_ACC_MODE_MASK)
+
+#define ICP_QAT_FW_COMP_XXHASH_ACC_MODE_SET(flags, val) \
+	QAT_FIELD_SET(flags, val, ICP_QAT_FW_COMP_XXHASH_ACC_MODE_BITPOS, \
+	ICP_QAT_FW_COMP_XXHASH_ACC_MODE_MASK)
+
+#define ICP_QAT_FW_COMP_CNV_ERROR_TYPE_GET(flags) \
+	QAT_FIELD_GET(flags, ICP_QAT_FW_COMP_CNV_ERROR_BITPOS, \
+	ICP_QAT_FW_COMP_CNV_ERROR_MASK)
+
+#define ICP_QAT_FW_COMP_CNV_ERROR_TYPE_SET(flags, val) \
+	QAT_FIELD_SET(flags, val, ICP_QAT_FW_COMP_CNV_ERROR_BITPOS, \
+	ICP_QAT_FW_COMP_CNV_ERROR_MASK)
+
+struct icp_qat_fw_xlt_req_params {
+	__u64 inter_buff_ptr;
+};
+
+struct icp_qat_fw_comp_cd_hdr {
+	__u16 ram_bank_flags;
+	__u8 comp_cfg_offset;
+	__u8 next_curr_id;
+	__u32 resrvd;
+	__u64 comp_state_addr;
+	__u64 ram_banks_addr;
+};
+
+#define COMP_CPR_INITIAL_CRC 0
+#define COMP_CPR_INITIAL_ADLER 1
+
+struct icp_qat_fw_xlt_cd_hdr {
+	__u16 resrvd1;
+	__u8 resrvd2;
+	__u8 next_curr_id;
+	__u32 resrvd3;
+};
+
+struct icp_qat_fw_comp_req {
+	struct icp_qat_fw_comn_req_hdr comn_hdr;
+	struct icp_qat_fw_comp_req_hdr_cd_pars cd_pars;
+	struct icp_qat_fw_comn_req_mid comn_mid;
+	struct icp_qat_fw_comp_req_params comp_pars;
+	union {
+		struct icp_qat_fw_xlt_req_params xlt_pars;
+		__u32 resrvd1[ICP_QAT_FW_NUM_LONGWORDS_2];
+	} u1;
+	__u32 resrvd2[ICP_QAT_FW_NUM_LONGWORDS_2];
+	struct icp_qat_fw_comp_cd_hdr comp_cd_ctrl;
+	union {
+		struct icp_qat_fw_xlt_cd_hdr xlt_cd_ctrl;
+		__u32 resrvd3[ICP_QAT_FW_NUM_LONGWORDS_2];
+	} u2;
+};
+
+struct icp_qat_fw_resp_comp_pars {
+	__u32 input_byte_counter;
+	__u32 output_byte_counter;
+	union {
+		struct {
+			__u32 curr_crc32;
+			__u32 curr_adler_32;
+		} legacy;
+		__u32 resrvd[ICP_QAT_FW_NUM_LONGWORDS_2];
+	} crc;
+};
+
+struct icp_qat_fw_comp_state {
+	__u32 rd8_counter;
+	__u32 status_flags;
+	__u32 in_counter;
+	__u32 out_counter;
+	__u64 intermediate_state;
+	__u32 lobc;
+	__u32 replaybc;
+	__u64 pcrc64_poly;
+	__u32 crc32;
+	__u32 adler_xxhash32;
+	__u64 pcrc64_xorout;
+	__u32 out_buf_size;
+	__u32 in_buf_size;
+	__u64 in_pcrc64;
+	__u64 out_pcrc64;
+	__u32 lobs;
+	__u32 libc;
+	__u64 reserved;
+	__u32 xxhash_state[4];
+	__u32 cleartext[4];
+};
+
+struct icp_qat_fw_comp_resp {
+	struct icp_qat_fw_comn_resp_hdr comn_resp;
+	__u64 opaque_data;
+	struct icp_qat_fw_resp_comp_pars comp_resp_pars;
+};
+
+#define QAT_FW_COMP_BANK_FLAG_MASK 0x1
+#define QAT_FW_COMP_BANK_I_BITPOS 8
+#define QAT_FW_COMP_BANK_H_BITPOS 7
+#define QAT_FW_COMP_BANK_G_BITPOS 6
+#define QAT_FW_COMP_BANK_F_BITPOS 5
+#define QAT_FW_COMP_BANK_E_BITPOS 4
+#define QAT_FW_COMP_BANK_D_BITPOS 3
+#define QAT_FW_COMP_BANK_C_BITPOS 2
+#define QAT_FW_COMP_BANK_B_BITPOS 1
+#define QAT_FW_COMP_BANK_A_BITPOS 0
+
+enum icp_qat_fw_comp_bank_enabled {
+	ICP_QAT_FW_COMP_BANK_DISABLED = 0,
+	ICP_QAT_FW_COMP_BANK_ENABLED = 1,
+	ICP_QAT_FW_COMP_BANK_DELIMITER = 2
+};
+
+#define ICP_QAT_FW_COMP_RAM_FLAGS_BUILD(bank_i_enable, bank_h_enable, \
+					bank_g_enable, bank_f_enable, \
+					bank_e_enable, bank_d_enable, \
+					bank_c_enable, bank_b_enable, \
+					bank_a_enable) \
+	((((bank_i_enable) & QAT_FW_COMP_BANK_FLAG_MASK) << \
+	QAT_FW_COMP_BANK_I_BITPOS) | \
+	(((bank_h_enable) & QAT_FW_COMP_BANK_FLAG_MASK) << \
+	QAT_FW_COMP_BANK_H_BITPOS) | \
+	(((bank_g_enable) & QAT_FW_COMP_BANK_FLAG_MASK) << \
+	QAT_FW_COMP_BANK_G_BITPOS) | \
+	(((bank_f_enable) & QAT_FW_COMP_BANK_FLAG_MASK) << \
+	QAT_FW_COMP_BANK_F_BITPOS) | \
+	(((bank_e_enable) & QAT_FW_COMP_BANK_FLAG_MASK) << \
+	QAT_FW_COMP_BANK_E_BITPOS) | \
+	(((bank_d_enable) & QAT_FW_COMP_BANK_FLAG_MASK) << \
+	QAT_FW_COMP_BANK_D_BITPOS) | \
+	(((bank_c_enable) & QAT_FW_COMP_BANK_FLAG_MASK) << \
+	QAT_FW_COMP_BANK_C_BITPOS) | \
+	(((bank_b_enable) & QAT_FW_COMP_BANK_FLAG_MASK) << \
+	QAT_FW_COMP_BANK_B_BITPOS) | \
+	(((bank_a_enable) & QAT_FW_COMP_BANK_FLAG_MASK) << \
+	QAT_FW_COMP_BANK_A_BITPOS))
+
+struct icp_qat_fw_comp_crc_data_struct {
+	__u32 crc32;
+	union {
+		__u32 adler;
+		__u32 xxhash;
+	} adler_xxhash_u;
+	__u32 cpr_in_crc_lo;
+	__u32 cpr_in_crc_hi;
+	__u32 cpr_out_crc_lo;
+	__u32 cpr_out_crc_hi;
+	__u32 xlt_in_crc_lo;
+	__u32 xlt_in_crc_hi;
+	__u32 xlt_out_crc_lo;
+	__u32 xlt_out_crc_hi;
+	__u32 prog_crc_poly_lo;
+	__u32 prog_crc_poly_hi;
+	__u32 xor_out_lo;
+	__u32 xor_out_hi;
+	__u32 append_crc_lo;
+	__u32 append_crc_hi;
+};
+
+struct xxhash_acc_state_buff {
+	__u32 in_counter;
+	__u32 out_counter;
+	__u32 xxhash_state[4];
+	__u32 clear_txt[4];
+};
+
+#endif
diff --git a/drivers/crypto/qat/qat_common/icp_qat_hw.h b/drivers/crypto/qat/qat_common/icp_qat_hw.h
index 433304cad2ed..4042739bb6fa 100644
--- a/drivers/crypto/qat/qat_common/icp_qat_hw.h
+++ b/drivers/crypto/qat/qat_common/icp_qat_hw.h
@@ -307,4 +307,70 @@ struct icp_qat_hw_cipher_algo_blk {
 		struct icp_qat_hw_ucs_cipher_aes256_f8 ucs_aes;
 	};
 } __aligned(64);
+
+enum icp_qat_hw_compression_direction {
+	ICP_QAT_HW_COMPRESSION_DIR_COMPRESS = 0,
+	ICP_QAT_HW_COMPRESSION_DIR_DECOMPRESS = 1,
+	ICP_QAT_HW_COMPRESSION_DIR_DELIMITER = 2
+};
+
+enum icp_qat_hw_compression_delayed_match {
+	ICP_QAT_HW_COMPRESSION_DELAYED_MATCH_DISABLED = 0,
+	ICP_QAT_HW_COMPRESSION_DELAYED_MATCH_ENABLED = 1,
+	ICP_QAT_HW_COMPRESSION_DELAYED_MATCH_DELIMITER = 2
+};
+
+enum icp_qat_hw_compression_algo {
+	ICP_QAT_HW_COMPRESSION_ALGO_DEFLATE = 0,
+	ICP_QAT_HW_COMPRESSION_ALGO_LZS = 1,
+	ICP_QAT_HW_COMPRESSION_ALGO_DELIMITER = 2
+};
+
+enum icp_qat_hw_compression_depth {
+	ICP_QAT_HW_COMPRESSION_DEPTH_1 = 0,
+	ICP_QAT_HW_COMPRESSION_DEPTH_4 = 1,
+	ICP_QAT_HW_COMPRESSION_DEPTH_8 = 2,
+	ICP_QAT_HW_COMPRESSION_DEPTH_16 = 3,
+	ICP_QAT_HW_COMPRESSION_DEPTH_128 = 4,
+	ICP_QAT_HW_COMPRESSION_DEPTH_DELIMITER = 5
+};
+
+enum icp_qat_hw_compression_file_type {
+	ICP_QAT_HW_COMPRESSION_FILE_TYPE_0 = 0,
+	ICP_QAT_HW_COMPRESSION_FILE_TYPE_1 = 1,
+	ICP_QAT_HW_COMPRESSION_FILE_TYPE_2 = 2,
+	ICP_QAT_HW_COMPRESSION_FILE_TYPE_3 = 3,
+	ICP_QAT_HW_COMPRESSION_FILE_TYPE_4 = 4,
+	ICP_QAT_HW_COMPRESSION_FILE_TYPE_DELIMITER = 5
+};
+
+struct icp_qat_hw_compression_config {
+	__u32 lower_val;
+	__u32 upper_val;
+};
+
+#define QAT_COMPRESSION_DIR_BITPOS 4
+#define QAT_COMPRESSION_DIR_MASK 0x7
+#define QAT_COMPRESSION_DELAYED_MATCH_BITPOS 16
+#define QAT_COMPRESSION_DELAYED_MATCH_MASK 0x1
+#define QAT_COMPRESSION_ALGO_BITPOS 31
+#define QAT_COMPRESSION_ALGO_MASK 0x1
+#define QAT_COMPRESSION_DEPTH_BITPOS 28
+#define QAT_COMPRESSION_DEPTH_MASK 0x7
+#define QAT_COMPRESSION_FILE_TYPE_BITPOS 24
+#define QAT_COMPRESSION_FILE_TYPE_MASK 0xF
+
+#define ICP_QAT_HW_COMPRESSION_CONFIG_BUILD(dir, delayed, \
+	algo, depth, filetype) \
+	((((dir) & QAT_COMPRESSION_DIR_MASK) << \
+	QAT_COMPRESSION_DIR_BITPOS) | \
+	(((delayed) & QAT_COMPRESSION_DELAYED_MATCH_MASK) << \
+	QAT_COMPRESSION_DELAYED_MATCH_BITPOS) | \
+	(((algo) & QAT_COMPRESSION_ALGO_MASK) << \
+	QAT_COMPRESSION_ALGO_BITPOS) | \
+	(((depth) & QAT_COMPRESSION_DEPTH_MASK) << \
+	QAT_COMPRESSION_DEPTH_BITPOS) | \
+	(((filetype) & QAT_COMPRESSION_FILE_TYPE_MASK) << \
+	QAT_COMPRESSION_FILE_TYPE_BITPOS))
+
 #endif
diff --git a/drivers/crypto/qat/qat_common/qat_comp_algs.c b/drivers/crypto/qat/qat_common/qat_comp_algs.c
new file mode 100644
index 000000000000..63fd4ac33dbf
--- /dev/null
+++ b/drivers/crypto/qat/qat_common/qat_comp_algs.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation */
+#include <linux/crypto.h>
+#include <crypto/acompress.h>
+#include <crypto/internal/acompress.h>
+#include <crypto/scatterwalk.h>
+#include <linux/dma-mapping.h>
+#include "adf_accel_devices.h"
+#include "adf_common_drv.h"
+#include "qat_bl.h"
+#include "qat_comp_req.h"
+#include "qat_compression.h"
+#include "qat_algs_send.h"
+
+static DEFINE_MUTEX(algs_lock);
+static unsigned int active_devs;
+
+enum direction {
+	DECOMPRESSION = 0,
+	COMPRESSION = 1,
+};
+
+struct qat_compression_ctx {
+	u8 comp_ctx[QAT_COMP_CTX_SIZE];
+	struct qat_compression_instance *inst;
+};
+
+struct qat_compression_req {
+	u8 req[QAT_COMP_REQ_SIZE];
+	struct qat_compression_ctx *qat_compression_ctx;
+	struct acomp_req *acompress_req;
+	struct qat_request_buffs buf;
+	enum direction dir;
+	int actual_dlen;
+	struct qat_alg_req alg_req;
+};
+
+static int qat_alg_send_dc_message(struct qat_compression_req *qat_req,
+				   struct qat_compression_instance *inst,
+				   struct crypto_async_request *base)
+{
+	struct qat_alg_req *alg_req = &qat_req->alg_req;
+
+	alg_req->fw_req = (u32 *)&qat_req->req;
+	alg_req->tx_ring = inst->dc_tx;
+	alg_req->base = base;
+	alg_req->backlog = &inst->backlog;
+
+	return qat_alg_send_message(alg_req);
+}
+
+static void qat_comp_generic_callback(struct qat_compression_req *qat_req,
+				      void *resp)
+{
+	struct acomp_req *areq = qat_req->acompress_req;
+	struct qat_compression_ctx *ctx = qat_req->qat_compression_ctx;
+	struct adf_accel_dev *accel_dev = ctx->inst->accel_dev;
+	struct crypto_acomp *tfm = crypto_acomp_reqtfm(areq);
+	struct qat_compression_instance *inst = ctx->inst;
+	int consumed, produced;
+	s8 cmp_err, xlt_err;
+	int res = -EBADMSG;
+	int status;
+	u8 cnv;
+
+	status = qat_comp_get_cmp_status(resp);
+	status |= qat_comp_get_xlt_status(resp);
+	cmp_err = qat_comp_get_cmp_err(resp);
+	xlt_err = qat_comp_get_xlt_err(resp);
+
+	consumed = qat_comp_get_consumed_ctr(resp);
+	produced = qat_comp_get_produced_ctr(resp);
+
+	dev_dbg(&GET_DEV(accel_dev),
+		"[%s][%s][%s] slen = %8d dlen = %8d consumed = %8d produced = %8d cmp_err = %3d xlt_err = %3d",
+		crypto_tfm_alg_driver_name(crypto_acomp_tfm(tfm)),
+		qat_req->dir == COMPRESSION ? "comp  " : "decomp",
+		status ? "ERR" : "OK ",
+		areq->slen, areq->dlen, consumed, produced, cmp_err, xlt_err);
+
+	areq->dlen = 0;
+
+	if (unlikely(status != ICP_QAT_FW_COMN_STATUS_FLAG_OK))
+		goto end;
+
+	if (qat_req->dir == COMPRESSION) {
+		cnv = qat_comp_get_cmp_cnv_flag(resp);
+		if (unlikely(!cnv)) {
+			dev_err(&GET_DEV(accel_dev),
+				"Verified compression not supported\n");
+			goto end;
+		}
+
+		if (unlikely(produced > qat_req->actual_dlen)) {
+			memset(inst->dc_data->ovf_buff, 0,
+			       inst->dc_data->ovf_buff_sz);
+			dev_dbg(&GET_DEV(accel_dev),
+				"Actual buffer overflow: produced=%d, dlen=%d\n",
+				produced, qat_req->actual_dlen);
+			goto end;
+		}
+	}
+
+	res = 0;
+	areq->dlen = produced;
+
+end:
+	qat_bl_free_bufl(accel_dev, &qat_req->buf);
+	areq->base.complete(&areq->base, res);
+}
+
+void qat_comp_alg_callback(void *resp)
+{
+	struct qat_compression_req *qat_req =
+			(void *)(__force long)qat_comp_get_opaque(resp);
+	struct qat_instance_backlog *backlog = qat_req->alg_req.backlog;
+
+	qat_comp_generic_callback(qat_req, resp);
+
+	qat_alg_send_backlog(backlog);
+}
+
+static int qat_comp_alg_init_tfm(struct crypto_acomp *acomp_tfm)
+{
+	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
+	struct qat_compression_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct qat_compression_instance *inst;
+	int node;
+
+	if (tfm->node == NUMA_NO_NODE)
+		node = numa_node_id();
+	else
+		node = tfm->node;
+
+	memset(ctx, 0, sizeof(*ctx));
+	inst = qat_compression_get_instance_node(node);
+	if (!inst)
+		return -EINVAL;
+	ctx->inst = inst;
+
+	ctx->inst->build_deflate_ctx(ctx->comp_ctx);
+
+	return 0;
+}
+
+static void qat_comp_alg_exit_tfm(struct crypto_acomp *acomp_tfm)
+{
+	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
+	struct qat_compression_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	qat_compression_put_instance(ctx->inst);
+	memset(ctx, 0, sizeof(*ctx));
+}
+
+static int qat_comp_alg_compress_decompress(struct acomp_req *areq,
+					    enum direction dir)
+{
+	struct qat_compression_req *qat_req = acomp_request_ctx(areq);
+	struct crypto_acomp *acomp_tfm = crypto_acomp_reqtfm(areq);
+	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
+	struct qat_compression_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct qat_compression_instance *inst = ctx->inst;
+	struct qat_sgl_to_bufl_params *p_params = NULL;
+	gfp_t f = qat_algs_alloc_flags(&areq->base);
+	struct qat_sgl_to_bufl_params params;
+	unsigned int slen = areq->slen;
+	unsigned int dlen = areq->dlen;
+	dma_addr_t sfbuf, dfbuf;
+	u8 *req = qat_req->req;
+	size_t ovf_buff_sz;
+	int ret;
+
+	if (!areq->src || !slen)
+		return -EINVAL;
+
+	if (areq->dst && !dlen)
+		return -EINVAL;
+
+	/* Handle acomp requests that require the allocation of a destination
+	 * buffer. The size of the destination buffer is double the source
+	 * buffer (rounded up to the size of a page) to fit the decompressed
+	 * output or an expansion on the data for compression.
+	 */
+	if (!areq->dst) {
+		dlen = round_up(2 * slen, PAGE_SIZE);
+		areq->dst = sgl_alloc(dlen, f, NULL);
+		if (!areq->dst)
+			return -ENOMEM;
+	}
+
+	if (dir == COMPRESSION) {
+		params.extra_dst_buff = inst->dc_data->ovf_buff_p;
+		ovf_buff_sz = inst->dc_data->ovf_buff_sz;
+		params.sz_extra_dst_buff = ovf_buff_sz;
+		p_params = &params;
+	}
+
+	ret = qat_bl_sgl_to_bufl(ctx->inst->accel_dev, areq->src, areq->dst,
+				 &qat_req->buf, p_params, f);
+	if (unlikely(ret))
+		return ret;
+
+	sfbuf = qat_req->buf.blp;
+	dfbuf = qat_req->buf.bloutp;
+	qat_req->qat_compression_ctx = ctx;
+	qat_req->acompress_req = areq;
+	qat_req->dir = dir;
+
+	if (dir == COMPRESSION) {
+		qat_req->actual_dlen = dlen;
+		dlen += ovf_buff_sz;
+		qat_comp_create_compression_req(ctx->comp_ctx, req,
+						(u64)(__force long)sfbuf, slen,
+						(u64)(__force long)dfbuf, dlen,
+						(u64)(__force long)qat_req);
+	} else {
+		qat_comp_create_decompression_req(ctx->comp_ctx, req,
+						  (u64)(__force long)sfbuf, slen,
+						  (u64)(__force long)dfbuf, dlen,
+						  (u64)(__force long)qat_req);
+	}
+
+	ret = qat_alg_send_dc_message(qat_req, inst, &areq->base);
+	if (ret == -ENOSPC)
+		qat_bl_free_bufl(inst->accel_dev, &qat_req->buf);
+
+	return ret;
+}
+
+static int qat_comp_alg_compress(struct acomp_req *req)
+{
+	return qat_comp_alg_compress_decompress(req, COMPRESSION);
+}
+
+static int qat_comp_alg_decompress(struct acomp_req *req)
+{
+	return qat_comp_alg_compress_decompress(req, DECOMPRESSION);
+}
+
+static struct acomp_alg qat_acomp[] = { {
+	.base = {
+		.cra_name = "deflate",
+		.cra_driver_name = "qat_deflate",
+		.cra_priority = 4001,
+		.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY,
+		.cra_ctxsize = sizeof(struct qat_compression_ctx),
+		.cra_module = THIS_MODULE,
+	},
+	.init = qat_comp_alg_init_tfm,
+	.exit = qat_comp_alg_exit_tfm,
+	.compress = qat_comp_alg_compress,
+	.decompress = qat_comp_alg_decompress,
+	.dst_free = sgl_free,
+	.reqsize = sizeof(struct qat_compression_req),
+} };
+
+int qat_comp_algs_register(void)
+{
+	int ret = 0;
+
+	mutex_lock(&algs_lock);
+	if (++active_devs == 1)
+		ret = crypto_register_acomps(qat_acomp, ARRAY_SIZE(qat_acomp));
+	mutex_unlock(&algs_lock);
+	return ret;
+}
+
+void qat_comp_algs_unregister(void)
+{
+	mutex_lock(&algs_lock);
+	if (--active_devs == 0)
+		crypto_unregister_acomps(qat_acomp, ARRAY_SIZE(qat_acomp));
+	mutex_unlock(&algs_lock);
+}
diff --git a/drivers/crypto/qat/qat_common/qat_comp_req.h b/drivers/crypto/qat/qat_common/qat_comp_req.h
new file mode 100644
index 000000000000..18a1f33a6db9
--- /dev/null
+++ b/drivers/crypto/qat/qat_common/qat_comp_req.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2022 Intel Corporation */
+#ifndef _QAT_COMP_REQ_H_
+#define _QAT_COMP_REQ_H_
+
+#include "icp_qat_fw_comp.h"
+
+#define QAT_COMP_REQ_SIZE (sizeof(struct icp_qat_fw_comp_req))
+#define QAT_COMP_CTX_SIZE (QAT_COMP_REQ_SIZE * 2)
+
+static inline void qat_comp_create_req(void *ctx, void *req, u64 src, u32 slen,
+				       u64 dst, u32 dlen, u64 opaque)
+{
+	struct icp_qat_fw_comp_req *fw_tmpl = ctx;
+	struct icp_qat_fw_comp_req *fw_req = req;
+	struct icp_qat_fw_comp_req_params *req_pars = &fw_req->comp_pars;
+
+	memcpy(fw_req, fw_tmpl, sizeof(*fw_req));
+	fw_req->comn_mid.src_data_addr = src;
+	fw_req->comn_mid.src_length = slen;
+	fw_req->comn_mid.dest_data_addr = dst;
+	fw_req->comn_mid.dst_length = dlen;
+	fw_req->comn_mid.opaque_data = opaque;
+	req_pars->comp_len = slen;
+	req_pars->out_buffer_sz = dlen;
+}
+
+static inline void qat_comp_create_compression_req(void *ctx, void *req,
+						   u64 src, u32 slen,
+						   u64 dst, u32 dlen,
+						   u64 opaque)
+{
+	qat_comp_create_req(ctx, req, src, slen, dst, dlen, opaque);
+}
+
+static inline void qat_comp_create_decompression_req(void *ctx, void *req,
+						     u64 src, u32 slen,
+						     u64 dst, u32 dlen,
+						     u64 opaque)
+{
+	struct icp_qat_fw_comp_req *fw_tmpl = ctx;
+
+	fw_tmpl++;
+	qat_comp_create_req(fw_tmpl, req, src, slen, dst, dlen, opaque);
+}
+
+static inline u32 qat_comp_get_consumed_ctr(void *resp)
+{
+	struct icp_qat_fw_comp_resp *qat_resp = resp;
+
+	return qat_resp->comp_resp_pars.input_byte_counter;
+}
+
+static inline u32 qat_comp_get_produced_ctr(void *resp)
+{
+	struct icp_qat_fw_comp_resp *qat_resp = resp;
+
+	return qat_resp->comp_resp_pars.output_byte_counter;
+}
+
+static inline u32 qat_comp_get_produced_adler32(void *resp)
+{
+	struct icp_qat_fw_comp_resp *qat_resp = resp;
+
+	return qat_resp->comp_resp_pars.crc.legacy.curr_adler_32;
+}
+
+static inline u64 qat_comp_get_opaque(void *resp)
+{
+	struct icp_qat_fw_comp_resp *qat_resp = resp;
+
+	return qat_resp->opaque_data;
+}
+
+static inline s8 qat_comp_get_cmp_err(void *resp)
+{
+	struct icp_qat_fw_comp_resp *qat_resp = resp;
+
+	return qat_resp->comn_resp.comn_error.cmp_err_code;
+}
+
+static inline s8 qat_comp_get_xlt_err(void *resp)
+{
+	struct icp_qat_fw_comp_resp *qat_resp = resp;
+
+	return qat_resp->comn_resp.comn_error.xlat_err_code;
+}
+
+static inline s8 qat_comp_get_cmp_status(void *resp)
+{
+	struct icp_qat_fw_comp_resp *qat_resp = resp;
+	u8 stat_filed = qat_resp->comn_resp.comn_status;
+
+	return ICP_QAT_FW_COMN_RESP_CMP_STAT_GET(stat_filed);
+}
+
+static inline s8 qat_comp_get_xlt_status(void *resp)
+{
+	struct icp_qat_fw_comp_resp *qat_resp = resp;
+	u8 stat_filed = qat_resp->comn_resp.comn_status;
+
+	return ICP_QAT_FW_COMN_RESP_XLAT_STAT_GET(stat_filed);
+}
+
+static inline u8 qat_comp_get_cmp_cnv_flag(void *resp)
+{
+	struct icp_qat_fw_comp_resp *qat_resp = resp;
+	u8 flags = qat_resp->comn_resp.hdr_flags;
+
+	return ICP_QAT_FW_COMN_HDR_CNV_FLAG_GET(flags);
+}
+
+#endif
diff --git a/drivers/crypto/qat/qat_common/qat_compression.c b/drivers/crypto/qat/qat_common/qat_compression.c
new file mode 100644
index 000000000000..9fd10f4242f8
--- /dev/null
+++ b/drivers/crypto/qat/qat_common/qat_compression.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation */
+#include <linux/module.h>
+#include <linux/slab.h>
+#include "adf_accel_devices.h"
+#include "adf_common_drv.h"
+#include "adf_transport.h"
+#include "adf_transport_access_macros.h"
+#include "adf_cfg.h"
+#include "adf_cfg_strings.h"
+#include "qat_compression.h"
+#include "icp_qat_fw.h"
+
+#define SEC ADF_KERNEL_SEC
+
+static struct service_hndl qat_compression;
+
+void qat_compression_put_instance(struct qat_compression_instance *inst)
+{
+	atomic_dec(&inst->refctr);
+	adf_dev_put(inst->accel_dev);
+}
+
+static int qat_compression_free_instances(struct adf_accel_dev *accel_dev)
+{
+	struct qat_compression_instance *inst;
+	struct list_head *list_ptr, *tmp;
+	int i;
+
+	list_for_each_safe(list_ptr, tmp, &accel_dev->compression_list) {
+		inst = list_entry(list_ptr,
+				  struct qat_compression_instance, list);
+
+		for (i = 0; i < atomic_read(&inst->refctr); i++)
+			qat_compression_put_instance(inst);
+
+		if (inst->dc_tx)
+			adf_remove_ring(inst->dc_tx);
+
+		if (inst->dc_rx)
+			adf_remove_ring(inst->dc_rx);
+
+		list_del(list_ptr);
+		kfree(inst);
+	}
+	return 0;
+}
+
+struct qat_compression_instance *qat_compression_get_instance_node(int node)
+{
+	struct qat_compression_instance *inst = NULL;
+	struct adf_accel_dev *accel_dev = NULL;
+	unsigned long best = ~0;
+	struct list_head *itr;
+
+	list_for_each(itr, adf_devmgr_get_head()) {
+		struct adf_accel_dev *tmp_dev;
+		unsigned long ctr;
+		int tmp_dev_node;
+
+		tmp_dev = list_entry(itr, struct adf_accel_dev, list);
+		tmp_dev_node = dev_to_node(&GET_DEV(tmp_dev));
+
+		if ((node == tmp_dev_node || tmp_dev_node < 0) &&
+		    adf_dev_started(tmp_dev) && !list_empty(&tmp_dev->compression_list)) {
+			ctr = atomic_read(&tmp_dev->ref_count);
+			if (best > ctr) {
+				accel_dev = tmp_dev;
+				best = ctr;
+			}
+		}
+	}
+
+	if (!accel_dev) {
+		pr_info("QAT: Could not find a device on node %d\n", node);
+		/* Get any started device */
+		list_for_each(itr, adf_devmgr_get_head()) {
+			struct adf_accel_dev *tmp_dev;
+
+			tmp_dev = list_entry(itr, struct adf_accel_dev, list);
+			if (adf_dev_started(tmp_dev) &&
+			    !list_empty(&tmp_dev->compression_list)) {
+				accel_dev = tmp_dev;
+				break;
+			}
+		}
+	}
+
+	if (!accel_dev)
+		return NULL;
+
+	best = ~0;
+	list_for_each(itr, &accel_dev->compression_list) {
+		struct qat_compression_instance *tmp_inst;
+		unsigned long ctr;
+
+		tmp_inst = list_entry(itr, struct qat_compression_instance, list);
+		ctr = atomic_read(&tmp_inst->refctr);
+		if (best > ctr) {
+			inst = tmp_inst;
+			best = ctr;
+		}
+	}
+	if (inst) {
+		if (adf_dev_get(accel_dev)) {
+			dev_err(&GET_DEV(accel_dev), "Could not increment dev refctr\n");
+			return NULL;
+		}
+		atomic_inc(&inst->refctr);
+	}
+	return inst;
+}
+
+static int qat_compression_create_instances(struct adf_accel_dev *accel_dev)
+{
+	struct qat_compression_instance *inst;
+	char key[ADF_CFG_MAX_KEY_LEN_IN_BYTES];
+	char val[ADF_CFG_MAX_VAL_LEN_IN_BYTES];
+	unsigned long num_inst, num_msg_dc;
+	unsigned long bank;
+	int msg_size;
+	int ret;
+	int i;
+
+	INIT_LIST_HEAD(&accel_dev->compression_list);
+	strscpy(key, ADF_NUM_DC, sizeof(key));
+	ret = adf_cfg_get_param_value(accel_dev, SEC, key, val);
+	if (ret)
+		return ret;
+
+	ret = kstrtoul(val, 10, &num_inst);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < num_inst; i++) {
+		inst = kzalloc_node(sizeof(*inst), GFP_KERNEL,
+				    dev_to_node(&GET_DEV(accel_dev)));
+		if (!inst) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		list_add_tail(&inst->list, &accel_dev->compression_list);
+		inst->id = i;
+		atomic_set(&inst->refctr, 0);
+		inst->accel_dev = accel_dev;
+		inst->build_deflate_ctx = GET_DC_OPS(accel_dev)->build_deflate_ctx;
+
+		snprintf(key, sizeof(key), ADF_DC "%d" ADF_RING_DC_BANK_NUM, i);
+		ret = adf_cfg_get_param_value(accel_dev, SEC, key, val);
+		if (ret)
+			return ret;
+
+		ret = kstrtoul(val, 10, &bank);
+		if (ret)
+			return ret;
+
+		snprintf(key, sizeof(key), ADF_DC "%d" ADF_RING_DC_SIZE, i);
+		ret = adf_cfg_get_param_value(accel_dev, SEC, key, val);
+		if (ret)
+			return ret;
+
+		ret = kstrtoul(val, 10, &num_msg_dc);
+		if (ret)
+			return ret;
+
+		msg_size = ICP_QAT_FW_REQ_DEFAULT_SZ;
+		snprintf(key, sizeof(key), ADF_DC "%d" ADF_RING_DC_TX, i);
+		ret = adf_create_ring(accel_dev, SEC, bank, num_msg_dc,
+				      msg_size, key, NULL, 0, &inst->dc_tx);
+		if (ret)
+			return ret;
+
+		msg_size = ICP_QAT_FW_RESP_DEFAULT_SZ;
+		snprintf(key, sizeof(key), ADF_DC "%d" ADF_RING_DC_RX, i);
+		ret = adf_create_ring(accel_dev, SEC, bank, num_msg_dc,
+				      msg_size, key, qat_comp_alg_callback, 0,
+				      &inst->dc_rx);
+		if (ret)
+			return ret;
+
+		inst->dc_data = accel_dev->dc_data;
+		INIT_LIST_HEAD(&inst->backlog.list);
+		spin_lock_init(&inst->backlog.lock);
+	}
+	return 0;
+err:
+	qat_compression_free_instances(accel_dev);
+	return ret;
+}
+
+static int qat_compression_alloc_dc_data(struct adf_accel_dev *accel_dev)
+{
+	struct device *dev = &GET_DEV(accel_dev);
+	dma_addr_t obuff_p = DMA_MAPPING_ERROR;
+	size_t ovf_buff_sz = QAT_COMP_MAX_SKID;
+	struct adf_dc_data *dc_data = NULL;
+	u8 *obuff = NULL;
+
+	dc_data = devm_kzalloc(dev, sizeof(*dc_data), GFP_KERNEL);
+	if (!dc_data)
+		goto err;
+
+	obuff = kzalloc_node(ovf_buff_sz, GFP_KERNEL, dev_to_node(dev));
+	if (!obuff)
+		goto err;
+
+	obuff_p = dma_map_single(dev, obuff, ovf_buff_sz, DMA_FROM_DEVICE);
+	if (unlikely(dma_mapping_error(dev, obuff_p)))
+		goto err;
+
+	dc_data->ovf_buff = obuff;
+	dc_data->ovf_buff_p = obuff_p;
+	dc_data->ovf_buff_sz = ovf_buff_sz;
+
+	accel_dev->dc_data = dc_data;
+
+	return 0;
+
+err:
+	accel_dev->dc_data = NULL;
+	kfree(obuff);
+	devm_kfree(dev, dc_data);
+	return -ENOMEM;
+}
+
+static void qat_free_dc_data(struct adf_accel_dev *accel_dev)
+{
+	struct adf_dc_data *dc_data = accel_dev->dc_data;
+	struct device *dev = &GET_DEV(accel_dev);
+
+	if (!dc_data)
+		return;
+
+	dma_unmap_single(dev, dc_data->ovf_buff_p, dc_data->ovf_buff_sz,
+			 DMA_FROM_DEVICE);
+	memset(dc_data->ovf_buff, 0, dc_data->ovf_buff_sz);
+	kfree(dc_data->ovf_buff);
+	devm_kfree(dev, dc_data);
+	accel_dev->dc_data = NULL;
+}
+
+static int qat_compression_init(struct adf_accel_dev *accel_dev)
+{
+	int ret;
+
+	ret = qat_compression_alloc_dc_data(accel_dev);
+	if (ret)
+		return ret;
+
+	ret = qat_compression_create_instances(accel_dev);
+	if (ret)
+		qat_free_dc_data(accel_dev);
+
+	return ret;
+}
+
+static int qat_compression_shutdown(struct adf_accel_dev *accel_dev)
+{
+	qat_free_dc_data(accel_dev);
+	return qat_compression_free_instances(accel_dev);
+}
+
+static int qat_compression_event_handler(struct adf_accel_dev *accel_dev,
+					 enum adf_event event)
+{
+	int ret;
+
+	switch (event) {
+	case ADF_EVENT_INIT:
+		ret = qat_compression_init(accel_dev);
+		break;
+	case ADF_EVENT_SHUTDOWN:
+		ret = qat_compression_shutdown(accel_dev);
+		break;
+	case ADF_EVENT_RESTARTING:
+	case ADF_EVENT_RESTARTED:
+	case ADF_EVENT_START:
+	case ADF_EVENT_STOP:
+	default:
+		ret = 0;
+	}
+	return ret;
+}
+
+int qat_compression_register(void)
+{
+	memset(&qat_compression, 0, sizeof(qat_compression));
+	qat_compression.event_hld = qat_compression_event_handler;
+	qat_compression.name = "qat_compression";
+	return adf_service_register(&qat_compression);
+}
+
+int qat_compression_unregister(void)
+{
+	return adf_service_unregister(&qat_compression);
+}
diff --git a/drivers/crypto/qat/qat_common/qat_compression.h b/drivers/crypto/qat/qat_common/qat_compression.h
new file mode 100644
index 000000000000..aebac2302dcf
--- /dev/null
+++ b/drivers/crypto/qat/qat_common/qat_compression.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2022 Intel Corporation */
+#ifndef _QAT_COMPRESSION_H_
+#define _QAT_COMPRESSION_H_
+
+#include <linux/list.h>
+#include <linux/types.h>
+#include "adf_accel_devices.h"
+#include "qat_algs_send.h"
+
+#define QAT_COMP_MAX_SKID 4096
+
+struct qat_compression_instance {
+	struct adf_etr_ring_data *dc_tx;
+	struct adf_etr_ring_data *dc_rx;
+	struct adf_accel_dev *accel_dev;
+	struct list_head list;
+	unsigned long state;
+	int id;
+	atomic_t refctr;
+	struct qat_instance_backlog backlog;
+	struct adf_dc_data *dc_data;
+	void (*build_deflate_ctx)(void *ctx);
+};
+
+static inline bool adf_hw_dev_has_compression(struct adf_accel_dev *accel_dev)
+{
+	struct adf_hw_device_data *hw_device = accel_dev->hw_device;
+	u32 mask = ~hw_device->accel_capabilities_mask;
+
+	if (mask & ADF_ACCEL_CAPABILITIES_COMPRESSION)
+		return false;
+
+	return true;
+}
+
+#endif
diff --git a/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c b/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
index baacf817abf6..bc80bb475118 100644
--- a/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
+++ b/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
@@ -3,6 +3,7 @@
 #include <adf_accel_devices.h>
 #include <adf_common_drv.h>
 #include <adf_gen2_config.h>
+#include <adf_gen2_dc.h>
 #include <adf_gen2_hw_data.h>
 #include <adf_gen2_pfvf.h>
 #include "adf_dh895xcc_hw_data.h"
@@ -242,6 +243,7 @@ void adf_init_hw_data_dh895xcc(struct adf_hw_device_data *hw_data)
 	hw_data->pfvf_ops.disable_all_vf2pf_interrupts = disable_all_vf2pf_interrupts;
 	hw_data->pfvf_ops.disable_pending_vf2pf_interrupts = disable_pending_vf2pf_interrupts;
 	adf_gen2_init_hw_csr_ops(&hw_data->csr_ops);
+	adf_gen2_init_dc_ops(&hw_data->dc_ops);
 }
 
 void adf_clean_hw_data_dh895xcc(struct adf_hw_device_data *hw_data)
diff --git a/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c b/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c
index b933a00fb91b..70e56cc16ece 100644
--- a/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c
+++ b/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c
@@ -3,6 +3,7 @@
 #include <adf_accel_devices.h>
 #include <adf_common_drv.h>
 #include <adf_gen2_config.h>
+#include <adf_gen2_dc.h>
 #include <adf_gen2_hw_data.h>
 #include <adf_gen2_pfvf.h>
 #include <adf_pfvf_vf_msg.h>
@@ -91,6 +92,7 @@ void adf_init_hw_data_dh895xcciov(struct adf_hw_device_data *hw_data)
 	adf_devmgr_update_class_index(hw_data);
 	adf_gen2_init_vf_pfvf_ops(&hw_data->pfvf_ops);
 	adf_gen2_init_hw_csr_ops(&hw_data->csr_ops);
+	adf_gen2_init_dc_ops(&hw_data->dc_ops);
 }
 
 void adf_clean_hw_data_dh895xcciov(struct adf_hw_device_data *hw_data)
-- 
2.38.1


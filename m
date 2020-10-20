Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969AA28C2A6
	for <lists+linux-crypto@lfdr.de>; Mon, 12 Oct 2020 22:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbgJLUjc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 12 Oct 2020 16:39:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:34024 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730636AbgJLUjc (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 12 Oct 2020 16:39:32 -0400
IronPort-SDR: vGf9IAU8OK7GD+7I0kujOpZLOt3J2WDCEP+Z0Wf6yO3IVSp+HmKaM8xJQSKXW74Awq4yG9CMYr
 fsWQiP+kcjOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="165913128"
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="165913128"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 13:39:31 -0700
IronPort-SDR: /VJ5IA95zBDPU4VtNW5zco477ngdjfKUOwNzcGcAKrhaPy2/oGhEZUt/KTqhLg2kbouDofZOTT
 /qKfwxmfHG7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="299328198"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.51])
  by fmsmga007.fm.intel.com with ESMTP; 12 Oct 2020 13:39:29 -0700
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 15/31] crypto: qat - abstract arbiter access
Date:   Mon, 12 Oct 2020 21:38:31 +0100
Message-Id: <20201012203847.340030-16-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012203847.340030-1-giovanni.cabiddu@intel.com>
References: <20201012203847.340030-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The arbiter configuration, the offset to the arbiter config CSR and the
offset to the worker thread to service arbiter CSR are going to be
different in QAT GEN4 devices although the logic that uses them is the
same across all QAT generations.

This patch reworks the gen-specific parts of the arbiter access code by
introducing the arb_info structure, that contains the values that are
generation specific, and a function in the structure adf_hw_device_data,
get_arb_info(), that allows to get them.

Since the arbiter values for QAT GEN2 devices (c62x, c3xxx and
dh895xcc) are the same, a single function, adf_gen2_get_arb_info() is
provided in adf_gen2_hw_data.c and referenced by each QAT GEN2 driver.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Fiona Trahe <fiona.trahe@intel.com>
Reviewed-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c  |  1 +
 .../crypto/qat/qat_c62x/adf_c62x_hw_data.c    |  1 +
 .../crypto/qat/qat_common/adf_accel_devices.h |  7 ++++
 .../crypto/qat/qat_common/adf_gen2_hw_data.c  |  8 ++++
 .../crypto/qat/qat_common/adf_gen2_hw_data.h  |  6 +++
 .../crypto/qat/qat_common/adf_hw_arbiter.c    | 41 ++++++++++++-------
 .../qat/qat_dh895xcc/adf_dh895xcc_hw_data.c   |  1 +
 7 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c b/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
index f72ed415800e..f3f33dc0c316 100644
--- a/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
+++ b/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
@@ -203,6 +203,7 @@ void adf_init_hw_data_c3xxx(struct adf_hw_device_data *hw_data)
 	hw_data->get_pf2vf_offset = get_pf2vf_offset;
 	hw_data->get_vintmsk_offset = get_vintmsk_offset;
 	hw_data->get_admin_info = adf_gen2_get_admin_info;
+	hw_data->get_arb_info = adf_gen2_get_arb_info;
 	hw_data->get_sku = get_sku;
 	hw_data->fw_name = ADF_C3XXX_FW;
 	hw_data->fw_mmp_name = ADF_C3XXX_MMP;
diff --git a/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c b/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
index d4443523dc9d..53c03b2f763f 100644
--- a/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
+++ b/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
@@ -213,6 +213,7 @@ void adf_init_hw_data_c62x(struct adf_hw_device_data *hw_data)
 	hw_data->get_pf2vf_offset = get_pf2vf_offset;
 	hw_data->get_vintmsk_offset = get_vintmsk_offset;
 	hw_data->get_admin_info = adf_gen2_get_admin_info;
+	hw_data->get_arb_info = adf_gen2_get_arb_info;
 	hw_data->get_sku = get_sku;
 	hw_data->fw_name = ADF_C62X_FW;
 	hw_data->fw_mmp_name = ADF_C62X_MMP;
diff --git a/drivers/crypto/qat/qat_common/adf_accel_devices.h b/drivers/crypto/qat/qat_common/adf_accel_devices.h
index 779f62fde3bd..951072feb176 100644
--- a/drivers/crypto/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/qat/qat_common/adf_accel_devices.h
@@ -97,6 +97,12 @@ struct adf_hw_device_class {
 	u32 instances;
 } __packed;
 
+struct arb_info {
+	u32 arb_cfg;
+	u32 arb_offset;
+	u32 wt2sam_offset;
+};
+
 struct admin_info {
 	u32 admin_msg_ur;
 	u32 admin_msg_lr;
@@ -144,6 +150,7 @@ struct adf_hw_device_data {
 	u32 (*get_num_accels)(struct adf_hw_device_data *self);
 	u32 (*get_pf2vf_offset)(u32 i);
 	u32 (*get_vintmsk_offset)(u32 i);
+	void (*get_arb_info)(struct arb_info *arb_csrs_info);
 	void (*get_admin_info)(struct admin_info *admin_csrs_info);
 	enum dev_sku_info (*get_sku)(struct adf_hw_device_data *self);
 	int (*alloc_irq)(struct adf_accel_dev *accel_dev);
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_hw_data.c b/drivers/crypto/qat/qat_common/adf_gen2_hw_data.c
index 15a0bc921d7e..b2f770cc29d8 100644
--- a/drivers/crypto/qat/qat_common/adf_gen2_hw_data.c
+++ b/drivers/crypto/qat/qat_common/adf_gen2_hw_data.c
@@ -45,6 +45,14 @@ void adf_gen2_get_admin_info(struct admin_info *admin_csrs_info)
 }
 EXPORT_SYMBOL_GPL(adf_gen2_get_admin_info);
 
+void adf_gen2_get_arb_info(struct arb_info *arb_info)
+{
+	arb_info->arb_cfg = ADF_ARB_CONFIG;
+	arb_info->arb_offset = ADF_ARB_OFFSET;
+	arb_info->wt2sam_offset = ADF_ARB_WRK_2_SER_MAP_OFFSET;
+}
+EXPORT_SYMBOL_GPL(adf_gen2_get_arb_info);
+
 static u32 read_csr_ring_head(void __iomem *csr_base_addr, u32 bank, u32 ring)
 {
 	return READ_CSR_RING_HEAD(csr_base_addr, bank, ring);
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_hw_data.h b/drivers/crypto/qat/qat_common/adf_gen2_hw_data.h
index e9d2591b2be8..fe4ea3220bca 100644
--- a/drivers/crypto/qat/qat_common/adf_gen2_hw_data.h
+++ b/drivers/crypto/qat/qat_common/adf_gen2_hw_data.h
@@ -97,9 +97,15 @@ do { \
 #define ADF_ADMINMSGLR_OFFSET	(0x3A000 + 0x578)
 #define ADF_MAILBOX_BASE_OFFSET	0x20970
 
+/* Arbiter configuration */
+#define ADF_ARB_OFFSET			0x30000
+#define ADF_ARB_WRK_2_SER_MAP_OFFSET	0x180
+#define ADF_ARB_CONFIG			(BIT(31) | BIT(6) | BIT(0))
+
 void adf_gen2_cfg_iov_thds(struct adf_accel_dev *accel_dev, bool enable,
 			   int num_a_regs, int num_b_regs);
 void adf_gen2_init_hw_csr_ops(struct adf_hw_csr_ops *csr_ops);
 void adf_gen2_get_admin_info(struct admin_info *admin_csrs_info);
+void adf_gen2_get_arb_info(struct arb_info *arb_info);
 
 #endif
diff --git a/drivers/crypto/qat/qat_common/adf_hw_arbiter.c b/drivers/crypto/qat/qat_common/adf_hw_arbiter.c
index be2fd264a223..9dc9d58f6093 100644
--- a/drivers/crypto/qat/qat_common/adf_hw_arbiter.c
+++ b/drivers/crypto/qat/qat_common/adf_hw_arbiter.c
@@ -6,36 +6,39 @@
 
 #define ADF_ARB_NUM 4
 #define ADF_ARB_REG_SIZE 0x4
-#define ADF_ARB_OFFSET 0x30000
 #define ADF_ARB_REG_SLOT 0x1000
-#define ADF_ARB_WRK_2_SER_MAP_OFFSET 0x180
 #define ADF_ARB_RINGSRVARBEN_OFFSET 0x19C
 
 #define WRITE_CSR_ARB_RINGSRVARBEN(csr_addr, index, value) \
 	ADF_CSR_WR(csr_addr, ADF_ARB_RINGSRVARBEN_OFFSET + \
 	(ADF_ARB_REG_SLOT * index), value)
 
-#define WRITE_CSR_ARB_SARCONFIG(csr_addr, index, value) \
-	ADF_CSR_WR(csr_addr, ADF_ARB_OFFSET + \
-	(ADF_ARB_REG_SIZE * index), value)
+#define WRITE_CSR_ARB_SARCONFIG(csr_addr, arb_offset, index, value) \
+	ADF_CSR_WR(csr_addr, (arb_offset) + \
+	(ADF_ARB_REG_SIZE * (index)), value)
 
-#define WRITE_CSR_ARB_WRK_2_SER_MAP(csr_addr, index, value) \
-	ADF_CSR_WR(csr_addr, (ADF_ARB_OFFSET + \
-	ADF_ARB_WRK_2_SER_MAP_OFFSET) + \
-	(ADF_ARB_REG_SIZE * index), value)
+#define WRITE_CSR_ARB_WT2SAM(csr_addr, arb_offset, wt_offset, index, value) \
+	ADF_CSR_WR(csr_addr, ((arb_offset) + (wt_offset)) + \
+	(ADF_ARB_REG_SIZE * (index)), value)
 
 int adf_init_arb(struct adf_accel_dev *accel_dev)
 {
 	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
 	void __iomem *csr = accel_dev->transport->banks[0].csr_addr;
-	u32 arb_cfg = 0x1 << 31 | 0x4 << 4 | 0x1;
-	u32 arb, i;
+	u32 arb_off, wt_off, arb_cfg;
 	const u32 *thd_2_arb_cfg;
+	struct arb_info info;
+	int arb, i;
+
+	hw_data->get_arb_info(&info);
+	arb_cfg = info.arb_cfg;
+	arb_off = info.arb_offset;
+	wt_off = info.wt2sam_offset;
 
 	/* Service arb configured for 32 bytes responses and
 	 * ring flow control check enabled. */
 	for (arb = 0; arb < ADF_ARB_NUM; arb++)
-		WRITE_CSR_ARB_SARCONFIG(csr, arb, arb_cfg);
+		WRITE_CSR_ARB_SARCONFIG(csr, arb_off, arb, arb_cfg);
 
 	/* Map worker threads to service arbiters */
 	hw_data->get_arb_mapping(accel_dev, &thd_2_arb_cfg);
@@ -44,7 +47,7 @@ int adf_init_arb(struct adf_accel_dev *accel_dev)
 		return -EFAULT;
 
 	for (i = 0; i < hw_data->num_engines; i++)
-		WRITE_CSR_ARB_WRK_2_SER_MAP(csr, i, *(thd_2_arb_cfg + i));
+		WRITE_CSR_ARB_WT2SAM(csr, arb_off, wt_off, i, thd_2_arb_cfg[i]);
 
 	return 0;
 }
@@ -60,21 +63,29 @@ void adf_update_ring_arb(struct adf_etr_ring_data *ring)
 void adf_exit_arb(struct adf_accel_dev *accel_dev)
 {
 	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+	u32 arb_off, wt_off;
+	struct arb_info info;
 	void __iomem *csr;
 	unsigned int i;
 
+	hw_data->get_arb_info(&info);
+	arb_off = info.arb_offset;
+	wt_off = info.wt2sam_offset;
+
 	if (!accel_dev->transport)
 		return;
 
 	csr = accel_dev->transport->banks[0].csr_addr;
 
+	hw_data->get_arb_info(&info);
+
 	/* Reset arbiter configuration */
 	for (i = 0; i < ADF_ARB_NUM; i++)
-		WRITE_CSR_ARB_SARCONFIG(csr, i, 0);
+		WRITE_CSR_ARB_SARCONFIG(csr, arb_off, i, 0);
 
 	/* Unmap worker threads to service arbiters */
 	for (i = 0; i < hw_data->num_engines; i++)
-		WRITE_CSR_ARB_WRK_2_SER_MAP(csr, i, 0);
+		WRITE_CSR_ARB_WT2SAM(csr, arb_off, wt_off, i, 0);
 
 	/* Disable arbitration on all rings */
 	for (i = 0; i < GET_MAX_BANKS(accel_dev); i++)
diff --git a/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c b/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
index c568e9808cec..2e7017a3ad46 100644
--- a/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
+++ b/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
@@ -211,6 +211,7 @@ void adf_init_hw_data_dh895xcc(struct adf_hw_device_data *hw_data)
 	hw_data->get_pf2vf_offset = get_pf2vf_offset;
 	hw_data->get_vintmsk_offset = get_vintmsk_offset;
 	hw_data->get_admin_info = adf_gen2_get_admin_info;
+	hw_data->get_arb_info = adf_gen2_get_arb_info;
 	hw_data->get_sram_bar_id = get_sram_bar_id;
 	hw_data->get_sku = get_sku;
 	hw_data->fw_name = ADF_DH895XCC_FW;
-- 
2.26.2


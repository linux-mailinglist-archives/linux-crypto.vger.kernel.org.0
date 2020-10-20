Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E7228C29C
	for <lists+linux-crypto@lfdr.de>; Mon, 12 Oct 2020 22:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbgJLUjS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 12 Oct 2020 16:39:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:33938 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729539AbgJLUjR (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 12 Oct 2020 16:39:17 -0400
IronPort-SDR: fZ3nsDnQDrsz3NY8IZbJlHI5p3rzwEGLPCJxgI0SeDTbP+RUifK3bqFo1TI0qIbo6xzgwvYa+9
 wo2cklSQbyJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="165913082"
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="165913082"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 13:39:16 -0700
IronPort-SDR: 1U8/sDb1kI5Vem81YLHtcvURvlw+nwM1QJ4v2gydSCfaNpQG8He1QMoCvo5j2sSIV6JpfIGBx1
 Mdgmm8rpUAxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="299328151"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.51])
  by fmsmga007.fm.intel.com with ESMTP; 12 Oct 2020 13:39:14 -0700
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 07/31] crypto: qat - abstract admin interface
Date:   Mon, 12 Oct 2020 21:38:23 +0100
Message-Id: <20201012203847.340030-8-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012203847.340030-1-giovanni.cabiddu@intel.com>
References: <20201012203847.340030-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Abstract access to admin interface and move generation specific code into
adf_gen2_hw_data.c in preparation for the introduction of the qat_4xxx
driver.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Fiona Trahe <fiona.trahe@intel.com>
Reviewed-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c  |  1 +
 .../crypto/qat/qat_c62x/adf_c62x_hw_data.c    |  1 +
 .../crypto/qat/qat_common/adf_accel_devices.h |  7 ++++++
 drivers/crypto/qat/qat_common/adf_admin.c     | 25 +++++++++++--------
 .../crypto/qat/qat_common/adf_gen2_hw_data.c  |  8 ++++++
 .../crypto/qat/qat_common/adf_gen2_hw_data.h  |  6 +++++
 .../qat/qat_dh895xcc/adf_dh895xcc_hw_data.c   |  1 +
 7 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c b/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
index 7af38b947cfe..f72ed415800e 100644
--- a/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
+++ b/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
@@ -202,6 +202,7 @@ void adf_init_hw_data_c3xxx(struct adf_hw_device_data *hw_data)
 	hw_data->get_misc_bar_id = get_misc_bar_id;
 	hw_data->get_pf2vf_offset = get_pf2vf_offset;
 	hw_data->get_vintmsk_offset = get_vintmsk_offset;
+	hw_data->get_admin_info = adf_gen2_get_admin_info;
 	hw_data->get_sku = get_sku;
 	hw_data->fw_name = ADF_C3XXX_FW;
 	hw_data->fw_mmp_name = ADF_C3XXX_MMP;
diff --git a/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c b/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
index c18fb77dd8ec..d4443523dc9d 100644
--- a/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
+++ b/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
@@ -212,6 +212,7 @@ void adf_init_hw_data_c62x(struct adf_hw_device_data *hw_data)
 	hw_data->get_misc_bar_id = get_misc_bar_id;
 	hw_data->get_pf2vf_offset = get_pf2vf_offset;
 	hw_data->get_vintmsk_offset = get_vintmsk_offset;
+	hw_data->get_admin_info = adf_gen2_get_admin_info;
 	hw_data->get_sku = get_sku;
 	hw_data->fw_name = ADF_C62X_FW;
 	hw_data->fw_mmp_name = ADF_C62X_MMP;
diff --git a/drivers/crypto/qat/qat_common/adf_accel_devices.h b/drivers/crypto/qat/qat_common/adf_accel_devices.h
index 459e22076813..5f57850c2e8d 100644
--- a/drivers/crypto/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/qat/qat_common/adf_accel_devices.h
@@ -97,6 +97,12 @@ struct adf_hw_device_class {
 	u32 instances;
 } __packed;
 
+struct admin_info {
+	u32 admin_msg_ur;
+	u32 admin_msg_lr;
+	u32 mailbox_offset;
+};
+
 struct adf_hw_csr_ops {
 	u32 (*read_csr_ring_head)(void __iomem *csr_base_addr, u32 bank,
 				  u32 ring);
@@ -138,6 +144,7 @@ struct adf_hw_device_data {
 	u32 (*get_num_accels)(struct adf_hw_device_data *self);
 	u32 (*get_pf2vf_offset)(u32 i);
 	u32 (*get_vintmsk_offset)(u32 i);
+	void (*get_admin_info)(struct admin_info *admin_csrs_info);
 	enum dev_sku_info (*get_sku)(struct adf_hw_device_data *self);
 	int (*alloc_irq)(struct adf_accel_dev *accel_dev);
 	void (*free_irq)(struct adf_accel_dev *accel_dev);
diff --git a/drivers/crypto/qat/qat_common/adf_admin.c b/drivers/crypto/qat/qat_common/adf_admin.c
index ec9b390276d6..3ae7c89ce82a 100644
--- a/drivers/crypto/qat/qat_common/adf_admin.c
+++ b/drivers/crypto/qat/qat_common/adf_admin.c
@@ -10,11 +10,7 @@
 #include "adf_common_drv.h"
 #include "icp_qat_fw_init_admin.h"
 
-/* Admin Messages Registers */
-#define ADF_DH895XCC_ADMINMSGUR_OFFSET (0x3A000 + 0x574)
-#define ADF_DH895XCC_ADMINMSGLR_OFFSET (0x3A000 + 0x578)
-#define ADF_DH895XCC_MAILBOX_BASE_OFFSET 0x20970
-#define ADF_DH895XCC_MAILBOX_STRIDE 0x1000
+#define ADF_ADMIN_MAILBOX_STRIDE 0x1000
 #define ADF_ADMINMSG_LEN 32
 #define ADF_CONST_TABLE_SIZE 1024
 #define ADF_ADMIN_POLL_DELAY_US 20
@@ -118,7 +114,7 @@ static int adf_put_admin_msg_sync(struct adf_accel_dev *accel_dev, u32 ae,
 	struct adf_admin_comms *admin = accel_dev->admin;
 	int offset = ae * ADF_ADMINMSG_LEN * 2;
 	void __iomem *mailbox = admin->mailbox_addr;
-	int mb_offset = ae * ADF_DH895XCC_MAILBOX_STRIDE;
+	int mb_offset = ae * ADF_ADMIN_MAILBOX_STRIDE;
 	struct icp_qat_fw_init_admin_req *request = in;
 
 	mutex_lock(&admin->lock);
@@ -225,8 +221,9 @@ int adf_init_admin_comms(struct adf_accel_dev *accel_dev)
 	struct adf_bar *pmisc =
 		&GET_BARS(accel_dev)[hw_data->get_misc_bar_id(hw_data)];
 	void __iomem *csr = pmisc->virt_addr;
-	void __iomem *mailbox = (void __iomem *)((uintptr_t)csr +
-				 ADF_DH895XCC_MAILBOX_BASE_OFFSET);
+	struct admin_info admin_csrs_info;
+	u32 mailbox_offset, adminmsg_u, adminmsg_l;
+	void __iomem *mailbox;
 	u64 reg_val;
 
 	admin = kzalloc_node(sizeof(*accel_dev->admin), GFP_KERNEL,
@@ -254,9 +251,17 @@ int adf_init_admin_comms(struct adf_accel_dev *accel_dev)
 	}
 
 	memcpy(admin->virt_tbl_addr, const_tab, sizeof(const_tab));
+	hw_data->get_admin_info(&admin_csrs_info);
+
+	mailbox_offset = admin_csrs_info.mailbox_offset;
+	mailbox = (void __iomem *)((uintptr_t)csr + mailbox_offset);
+	adminmsg_u = admin_csrs_info.admin_msg_ur;
+	adminmsg_l = admin_csrs_info.admin_msg_lr;
+
 	reg_val = (u64)admin->phy_addr;
-	ADF_CSR_WR(csr, ADF_DH895XCC_ADMINMSGUR_OFFSET, reg_val >> 32);
-	ADF_CSR_WR(csr, ADF_DH895XCC_ADMINMSGLR_OFFSET, reg_val);
+	ADF_CSR_WR(csr, adminmsg_u, upper_32_bits(reg_val));
+	ADF_CSR_WR(csr, adminmsg_l, lower_32_bits(reg_val));
+
 	mutex_init(&admin->lock);
 	admin->mailbox_addr = mailbox;
 	accel_dev->admin = admin;
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_hw_data.c b/drivers/crypto/qat/qat_common/adf_gen2_hw_data.c
index 9011c94156a9..15a0bc921d7e 100644
--- a/drivers/crypto/qat/qat_common/adf_gen2_hw_data.c
+++ b/drivers/crypto/qat/qat_common/adf_gen2_hw_data.c
@@ -37,6 +37,14 @@ void adf_gen2_cfg_iov_thds(struct adf_accel_dev *accel_dev, bool enable,
 }
 EXPORT_SYMBOL_GPL(adf_gen2_cfg_iov_thds);
 
+void adf_gen2_get_admin_info(struct admin_info *admin_csrs_info)
+{
+	admin_csrs_info->mailbox_offset = ADF_MAILBOX_BASE_OFFSET;
+	admin_csrs_info->admin_msg_ur = ADF_ADMINMSGUR_OFFSET;
+	admin_csrs_info->admin_msg_lr = ADF_ADMINMSGLR_OFFSET;
+}
+EXPORT_SYMBOL_GPL(adf_gen2_get_admin_info);
+
 static u32 read_csr_ring_head(void __iomem *csr_base_addr, u32 bank, u32 ring)
 {
 	return READ_CSR_RING_HEAD(csr_base_addr, bank, ring);
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_hw_data.h b/drivers/crypto/qat/qat_common/adf_gen2_hw_data.h
index 592aee627762..e9d2591b2be8 100644
--- a/drivers/crypto/qat/qat_common/adf_gen2_hw_data.h
+++ b/drivers/crypto/qat/qat_common/adf_gen2_hw_data.h
@@ -92,8 +92,14 @@ do { \
 	ADF_CSR_WR(pmisc_bar_addr, AE2FUNCTION_MAP_B_OFFSET + \
 		   AE2FUNCTION_MAP_REG_SIZE * (index), value)
 
+/* Admin Interface Offsets */
+#define ADF_ADMINMSGUR_OFFSET	(0x3A000 + 0x574)
+#define ADF_ADMINMSGLR_OFFSET	(0x3A000 + 0x578)
+#define ADF_MAILBOX_BASE_OFFSET	0x20970
+
 void adf_gen2_cfg_iov_thds(struct adf_accel_dev *accel_dev, bool enable,
 			   int num_a_regs, int num_b_regs);
 void adf_gen2_init_hw_csr_ops(struct adf_hw_csr_ops *csr_ops);
+void adf_gen2_get_admin_info(struct admin_info *admin_csrs_info);
 
 #endif
diff --git a/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c b/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
index 39423316664b..c568e9808cec 100644
--- a/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
+++ b/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
@@ -210,6 +210,7 @@ void adf_init_hw_data_dh895xcc(struct adf_hw_device_data *hw_data)
 	hw_data->get_misc_bar_id = get_misc_bar_id;
 	hw_data->get_pf2vf_offset = get_pf2vf_offset;
 	hw_data->get_vintmsk_offset = get_vintmsk_offset;
+	hw_data->get_admin_info = adf_gen2_get_admin_info;
 	hw_data->get_sram_bar_id = get_sram_bar_id;
 	hw_data->get_sku = get_sku;
 	hw_data->fw_name = ADF_DH895XCC_FW;
-- 
2.26.2


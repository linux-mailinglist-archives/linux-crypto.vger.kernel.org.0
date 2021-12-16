Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093CA476CF7
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Dec 2021 10:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbhLPJLX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Dec 2021 04:11:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:9672 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232927AbhLPJLW (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Dec 2021 04:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639645882; x=1671181882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NuRd4IDkvME/gxL7utS9tAshVn6Sl0FNq4MureM6XS4=;
  b=mVxi2ruA3h70SYy4as8t9c54lUTg48WZwoZAE9YB+wIFnXmtutzZzC9t
   GPNxevT0Y1Eo0X8i0nIox6kMIBQBu7MsC3k7u6g8u0sKVVDp84lhbCopV
   pAZO81KPJnCgUtbS73TDYkHNSt8eGTTOJB6mnWnRcuQrjYpP+mMqtilQG
   z15iHGvlAPyH9rWkmQtyMirxUOEYEH7wnqNri70kg/z3XuEd+7dkam6r5
   T8vKYzYX9mVYs9ktA8N97aCFidKIWAt1eFmqQIOkYFlCSeVOHjS4Yyema
   VQWXgW3H4A7aCcuhUtbcrlzS7Sd8zwMajp6liLqk6tXRoDokTeE0Pbncn
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="219458375"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="219458375"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 01:11:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="465968445"
Received: from silpixa00393544.ir.intel.com ([10.237.213.118])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2021 01:11:20 -0800
From:   Marco Chiappero <marco.chiappero@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        giovanni.cabiddu@intel.com, marco.chiappero@intel.com,
        Fiona Trahe <fiona.trahe@intel.com>
Subject: [PATCH 06/24] crypto: qat - add the adf_get_pmisc_base() helper function
Date:   Thu, 16 Dec 2021 09:13:16 +0000
Message-Id: <20211216091334.402420-7-marco.chiappero@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216091334.402420-1-marco.chiappero@intel.com>
References: <20211216091334.402420-1-marco.chiappero@intel.com>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add and use the new helper function adf_get_pmisc_base() where convenient.

Also:
- remove no longer shared variables
- leverage other utilities, such as GET_PFVF_OPS(), as a consequence
- consistently use the "pmisc_addr" name for the returned value of this
  new helper

Signed-off-by: Marco Chiappero <marco.chiappero@intel.com>
Co-developed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Fiona Trahe <fiona.trahe@intel.com>
---
 drivers/crypto/qat/qat_common/adf_admin.c     | 10 ++---
 .../crypto/qat/qat_common/adf_common_drv.h    | 11 +++++
 .../crypto/qat/qat_common/adf_gen2_hw_data.c  | 39 ++++++------------
 drivers/crypto/qat/qat_common/adf_gen2_pfvf.c | 24 ++++-------
 .../crypto/qat/qat_common/adf_gen4_hw_data.c  |  9 +---
 drivers/crypto/qat/qat_common/adf_isr.c       | 28 ++++---------
 drivers/crypto/qat/qat_common/adf_vf_isr.c    | 14 ++-----
 drivers/crypto/qat/qat_common/qat_hal.c       | 41 +++++--------------
 8 files changed, 61 insertions(+), 115 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_admin.c b/drivers/crypto/qat/qat_common/adf_admin.c
index c381b89d548d..498eb6f690e3 100644
--- a/drivers/crypto/qat/qat_common/adf_admin.c
+++ b/drivers/crypto/qat/qat_common/adf_admin.c
@@ -255,9 +255,7 @@ int adf_init_admin_comms(struct adf_accel_dev *accel_dev)
 {
 	struct adf_admin_comms *admin;
 	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
-	struct adf_bar *pmisc =
-		&GET_BARS(accel_dev)[hw_data->get_misc_bar_id(hw_data)];
-	void __iomem *csr = pmisc->virt_addr;
+	void __iomem *pmisc_addr = adf_get_pmisc_base(accel_dev);
 	struct admin_info admin_csrs_info;
 	u32 mailbox_offset, adminmsg_u, adminmsg_l;
 	void __iomem *mailbox;
@@ -291,13 +289,13 @@ int adf_init_admin_comms(struct adf_accel_dev *accel_dev)
 	hw_data->get_admin_info(&admin_csrs_info);
 
 	mailbox_offset = admin_csrs_info.mailbox_offset;
-	mailbox = csr + mailbox_offset;
+	mailbox = pmisc_addr + mailbox_offset;
 	adminmsg_u = admin_csrs_info.admin_msg_ur;
 	adminmsg_l = admin_csrs_info.admin_msg_lr;
 
 	reg_val = (u64)admin->phy_addr;
-	ADF_CSR_WR(csr, adminmsg_u, upper_32_bits(reg_val));
-	ADF_CSR_WR(csr, adminmsg_l, lower_32_bits(reg_val));
+	ADF_CSR_WR(pmisc_addr, adminmsg_u, upper_32_bits(reg_val));
+	ADF_CSR_WR(pmisc_addr, adminmsg_l, lower_32_bits(reg_val));
 
 	mutex_init(&admin->lock);
 	admin->mailbox_addr = mailbox;
diff --git a/drivers/crypto/qat/qat_common/adf_common_drv.h b/drivers/crypto/qat/qat_common/adf_common_drv.h
index 2d8b72085505..5212891344a9 100644
--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
@@ -243,4 +243,15 @@ static inline void adf_flush_vf_wq(struct adf_accel_dev *accel_dev)
 }
 
 #endif
+
+static inline void __iomem *adf_get_pmisc_base(struct adf_accel_dev *accel_dev)
+{
+	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+	struct adf_bar *pmisc;
+
+	pmisc = &GET_BARS(accel_dev)[hw_data->get_misc_bar_id(hw_data)];
+
+	return pmisc->virt_addr;
+}
+
 #endif
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_hw_data.c b/drivers/crypto/qat/qat_common/adf_gen2_hw_data.c
index 688dd6f53b0b..57035b7dd4b2 100644
--- a/drivers/crypto/qat/qat_common/adf_gen2_hw_data.c
+++ b/drivers/crypto/qat/qat_common/adf_gen2_hw_data.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
 /* Copyright(c) 2020 Intel Corporation */
+#include "adf_common_drv.h"
 #include "adf_gen2_hw_data.h"
 #include "icp_qat_hw.h"
 #include <linux/pci.h>
@@ -25,31 +26,29 @@ EXPORT_SYMBOL_GPL(adf_gen2_get_num_aes);
 void adf_gen2_enable_error_correction(struct adf_accel_dev *accel_dev)
 {
 	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
-	struct adf_bar *misc_bar = &GET_BARS(accel_dev)
-					[hw_data->get_misc_bar_id(hw_data)];
+	void __iomem *pmisc_addr = adf_get_pmisc_base(accel_dev);
 	unsigned long accel_mask = hw_data->accel_mask;
 	unsigned long ae_mask = hw_data->ae_mask;
-	void __iomem *csr = misc_bar->virt_addr;
 	unsigned int val, i;
 
 	/* Enable Accel Engine error detection & correction */
 	for_each_set_bit(i, &ae_mask, hw_data->num_engines) {
-		val = ADF_CSR_RD(csr, ADF_GEN2_AE_CTX_ENABLES(i));
+		val = ADF_CSR_RD(pmisc_addr, ADF_GEN2_AE_CTX_ENABLES(i));
 		val |= ADF_GEN2_ENABLE_AE_ECC_ERR;
-		ADF_CSR_WR(csr, ADF_GEN2_AE_CTX_ENABLES(i), val);
-		val = ADF_CSR_RD(csr, ADF_GEN2_AE_MISC_CONTROL(i));
+		ADF_CSR_WR(pmisc_addr, ADF_GEN2_AE_CTX_ENABLES(i), val);
+		val = ADF_CSR_RD(pmisc_addr, ADF_GEN2_AE_MISC_CONTROL(i));
 		val |= ADF_GEN2_ENABLE_AE_ECC_PARITY_CORR;
-		ADF_CSR_WR(csr, ADF_GEN2_AE_MISC_CONTROL(i), val);
+		ADF_CSR_WR(pmisc_addr, ADF_GEN2_AE_MISC_CONTROL(i), val);
 	}
 
 	/* Enable shared memory error detection & correction */
 	for_each_set_bit(i, &accel_mask, hw_data->num_accel) {
-		val = ADF_CSR_RD(csr, ADF_GEN2_UERRSSMSH(i));
+		val = ADF_CSR_RD(pmisc_addr, ADF_GEN2_UERRSSMSH(i));
 		val |= ADF_GEN2_ERRSSMSH_EN;
-		ADF_CSR_WR(csr, ADF_GEN2_UERRSSMSH(i), val);
-		val = ADF_CSR_RD(csr, ADF_GEN2_CERRSSMSH(i));
+		ADF_CSR_WR(pmisc_addr, ADF_GEN2_UERRSSMSH(i), val);
+		val = ADF_CSR_RD(pmisc_addr, ADF_GEN2_CERRSSMSH(i));
 		val |= ADF_GEN2_ERRSSMSH_EN;
-		ADF_CSR_WR(csr, ADF_GEN2_CERRSSMSH(i), val);
+		ADF_CSR_WR(pmisc_addr, ADF_GEN2_CERRSSMSH(i), val);
 	}
 }
 EXPORT_SYMBOL_GPL(adf_gen2_enable_error_correction);
@@ -57,15 +56,9 @@ EXPORT_SYMBOL_GPL(adf_gen2_enable_error_correction);
 void adf_gen2_cfg_iov_thds(struct adf_accel_dev *accel_dev, bool enable,
 			   int num_a_regs, int num_b_regs)
 {
-	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
-	void __iomem *pmisc_addr;
-	struct adf_bar *pmisc;
-	int pmisc_id, i;
+	void __iomem *pmisc_addr = adf_get_pmisc_base(accel_dev);
 	u32 reg;
-
-	pmisc_id = hw_data->get_misc_bar_id(hw_data);
-	pmisc = &GET_BARS(accel_dev)[pmisc_id];
-	pmisc_addr = pmisc->virt_addr;
+	int i;
 
 	/* Set/Unset Valid bit in AE Thread to PCIe Function Mapping Group A */
 	for (i = 0; i < num_a_regs; i++) {
@@ -245,18 +238,12 @@ EXPORT_SYMBOL_GPL(adf_gen2_get_accel_cap);
 void adf_gen2_set_ssm_wdtimer(struct adf_accel_dev *accel_dev)
 {
 	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+	void __iomem *pmisc_addr = adf_get_pmisc_base(accel_dev);
 	u32 timer_val_pke = ADF_SSM_WDT_PKE_DEFAULT_VALUE;
 	u32 timer_val = ADF_SSM_WDT_DEFAULT_VALUE;
 	unsigned long accel_mask = hw_data->accel_mask;
-	void __iomem *pmisc_addr;
-	struct adf_bar *pmisc;
-	int pmisc_id;
 	u32 i = 0;
 
-	pmisc_id = hw_data->get_misc_bar_id(hw_data);
-	pmisc = &GET_BARS(accel_dev)[pmisc_id];
-	pmisc_addr = pmisc->virt_addr;
-
 	/* Configures WDT timers */
 	for_each_set_bit(i, &accel_mask, hw_data->num_accel) {
 		/* Enable WDT for sym and dc */
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_pfvf.c b/drivers/crypto/qat/qat_common/adf_gen2_pfvf.c
index 099e39808d13..5ac69ece34a8 100644
--- a/drivers/crypto/qat/qat_common/adf_gen2_pfvf.c
+++ b/drivers/crypto/qat/qat_common/adf_gen2_pfvf.c
@@ -75,15 +75,12 @@ static void adf_gen2_disable_vf2pf_interrupts(void __iomem *pmisc_addr,
 static int adf_gen2_pfvf_send(struct adf_accel_dev *accel_dev, u32 msg,
 			      u8 vf_nr)
 {
-	struct adf_accel_pci *pci_info = &accel_dev->accel_pci_dev;
-	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
-	void __iomem *pmisc_bar_addr =
-		pci_info->pci_bars[hw_data->get_misc_bar_id(hw_data)].virt_addr;
-	u32 val, pfvf_offset, count = 0;
-	u32 local_in_use_mask, local_in_use_pattern;
+	void __iomem *pmisc_addr = adf_get_pmisc_base(accel_dev);
+	unsigned int retries = ADF_PFVF_MSG_MAX_RETRIES;
 	u32 remote_in_use_mask, remote_in_use_pattern;
+	u32 local_in_use_mask, local_in_use_pattern;
+	u32 val, pfvf_offset, count = 0;
 	struct mutex *lock;	/* lock preventing concurrent acces of CSR */
-	unsigned int retries = ADF_PFVF_MSG_MAX_RETRIES;
 	u32 int_bit;
 	int ret;
 
@@ -114,7 +111,7 @@ static int adf_gen2_pfvf_send(struct adf_accel_dev *accel_dev, u32 msg,
 	ret = 0;
 
 	/* Check if the PFVF CSR is in use by remote function */
-	val = ADF_CSR_RD(pmisc_bar_addr, pfvf_offset);
+	val = ADF_CSR_RD(pmisc_addr, pfvf_offset);
 	if ((val & remote_in_use_mask) == remote_in_use_pattern) {
 		dev_dbg(&GET_DEV(accel_dev),
 			"PFVF CSR in use by remote function\n");
@@ -122,12 +119,12 @@ static int adf_gen2_pfvf_send(struct adf_accel_dev *accel_dev, u32 msg,
 	}
 
 	/* Attempt to get ownership of the PFVF CSR */
-	ADF_CSR_WR(pmisc_bar_addr, pfvf_offset, msg | int_bit);
+	ADF_CSR_WR(pmisc_addr, pfvf_offset, msg | int_bit);
 
 	/* Wait for confirmation from remote func it received the message */
 	do {
 		msleep(ADF_PFVF_MSG_ACK_DELAY);
-		val = ADF_CSR_RD(pmisc_bar_addr, pfvf_offset);
+		val = ADF_CSR_RD(pmisc_addr, pfvf_offset);
 	} while ((val & int_bit) && (count++ < ADF_PFVF_MSG_ACK_MAX_RETRY));
 
 	if (val & int_bit) {
@@ -143,7 +140,7 @@ static int adf_gen2_pfvf_send(struct adf_accel_dev *accel_dev, u32 msg,
 	}
 
 	/* Finished with the PFVF CSR; relinquish it and leave msg in CSR */
-	ADF_CSR_WR(pmisc_bar_addr, pfvf_offset, val & ~local_in_use_mask);
+	ADF_CSR_WR(pmisc_addr, pfvf_offset, val & ~local_in_use_mask);
 out:
 	mutex_unlock(lock);
 	return ret;
@@ -160,10 +157,7 @@ static int adf_gen2_pfvf_send(struct adf_accel_dev *accel_dev, u32 msg,
 
 static u32 adf_gen2_pfvf_recv(struct adf_accel_dev *accel_dev, u8 vf_nr)
 {
-	struct adf_accel_pci *pci_info = &accel_dev->accel_pci_dev;
-	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
-	void __iomem *pmisc_addr =
-		pci_info->pci_bars[hw_data->get_misc_bar_id(hw_data)].virt_addr;
+	void __iomem *pmisc_addr = adf_get_pmisc_base(accel_dev);
 	u32 pfvf_offset;
 	u32 msg_origin;
 	u32 int_bit;
diff --git a/drivers/crypto/qat/qat_common/adf_gen4_hw_data.c b/drivers/crypto/qat/qat_common/adf_gen4_hw_data.c
index c7808ff2aba1..3148a62938fd 100644
--- a/drivers/crypto/qat/qat_common/adf_gen4_hw_data.c
+++ b/drivers/crypto/qat/qat_common/adf_gen4_hw_data.c
@@ -111,20 +111,13 @@ static inline void adf_gen4_unpack_ssm_wdtimer(u64 value, u32 *upper,
 
 void adf_gen4_set_ssm_wdtimer(struct adf_accel_dev *accel_dev)
 {
-	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+	void __iomem *pmisc_addr = adf_get_pmisc_base(accel_dev);
 	u64 timer_val_pke = ADF_SSM_WDT_PKE_DEFAULT_VALUE;
 	u64 timer_val = ADF_SSM_WDT_DEFAULT_VALUE;
 	u32 ssm_wdt_pke_high = 0;
 	u32 ssm_wdt_pke_low = 0;
 	u32 ssm_wdt_high = 0;
 	u32 ssm_wdt_low = 0;
-	void __iomem *pmisc_addr;
-	struct adf_bar *pmisc;
-	int pmisc_id;
-
-	pmisc_id = hw_data->get_misc_bar_id(hw_data);
-	pmisc = &GET_BARS(accel_dev)[pmisc_id];
-	pmisc_addr = pmisc->virt_addr;
 
 	/* Convert 64bit WDT timer value into 32bit values for
 	 * mmio write to 32bit CSRs.
diff --git a/drivers/crypto/qat/qat_common/adf_isr.c b/drivers/crypto/qat/qat_common/adf_isr.c
index 522e0c10d9b9..4ca482aa69f7 100644
--- a/drivers/crypto/qat/qat_common/adf_isr.c
+++ b/drivers/crypto/qat/qat_common/adf_isr.c
@@ -57,54 +57,42 @@ static irqreturn_t adf_msix_isr_bundle(int irq, void *bank_ptr)
 #ifdef CONFIG_PCI_IOV
 void adf_enable_vf2pf_interrupts(struct adf_accel_dev *accel_dev, u32 vf_mask)
 {
-	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
-	u32 misc_bar_id = hw_data->get_misc_bar_id(hw_data);
-	struct adf_bar *pmisc = &GET_BARS(accel_dev)[misc_bar_id];
-	void __iomem *pmisc_addr = pmisc->virt_addr;
+	void __iomem *pmisc_addr = adf_get_pmisc_base(accel_dev);
 	unsigned long flags;
 
 	spin_lock_irqsave(&accel_dev->pf.vf2pf_ints_lock, flags);
-	hw_data->pfvf_ops.enable_vf2pf_interrupts(pmisc_addr, vf_mask);
+	GET_PFVF_OPS(accel_dev)->enable_vf2pf_interrupts(pmisc_addr, vf_mask);
 	spin_unlock_irqrestore(&accel_dev->pf.vf2pf_ints_lock, flags);
 }
 
 void adf_disable_vf2pf_interrupts(struct adf_accel_dev *accel_dev, u32 vf_mask)
 {
-	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
-	u32 misc_bar_id = hw_data->get_misc_bar_id(hw_data);
-	struct adf_bar *pmisc = &GET_BARS(accel_dev)[misc_bar_id];
-	void __iomem *pmisc_addr = pmisc->virt_addr;
+	void __iomem *pmisc_addr = adf_get_pmisc_base(accel_dev);
 	unsigned long flags;
 
 	spin_lock_irqsave(&accel_dev->pf.vf2pf_ints_lock, flags);
-	hw_data->pfvf_ops.disable_vf2pf_interrupts(pmisc_addr, vf_mask);
+	GET_PFVF_OPS(accel_dev)->disable_vf2pf_interrupts(pmisc_addr, vf_mask);
 	spin_unlock_irqrestore(&accel_dev->pf.vf2pf_ints_lock, flags);
 }
 
 static void adf_disable_vf2pf_interrupts_irq(struct adf_accel_dev *accel_dev,
 					     u32 vf_mask)
 {
-	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
-	u32 misc_bar_id = hw_data->get_misc_bar_id(hw_data);
-	struct adf_bar *pmisc = &GET_BARS(accel_dev)[misc_bar_id];
-	void __iomem *pmisc_addr = pmisc->virt_addr;
+	void __iomem *pmisc_addr = adf_get_pmisc_base(accel_dev);
 
 	spin_lock(&accel_dev->pf.vf2pf_ints_lock);
-	hw_data->pfvf_ops.disable_vf2pf_interrupts(pmisc_addr, vf_mask);
+	GET_PFVF_OPS(accel_dev)->disable_vf2pf_interrupts(pmisc_addr, vf_mask);
 	spin_unlock(&accel_dev->pf.vf2pf_ints_lock);
 }
 
 static bool adf_handle_vf2pf_int(struct adf_accel_dev *accel_dev)
 {
-	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
-	int bar_id = hw_data->get_misc_bar_id(hw_data);
-	struct adf_bar *pmisc = &GET_BARS(accel_dev)[bar_id];
-	void __iomem *pmisc_addr = pmisc->virt_addr;
+	void __iomem *pmisc_addr = adf_get_pmisc_base(accel_dev);
 	bool irq_handled = false;
 	unsigned long vf_mask;
 
 	/* Get the interrupt sources triggered by VFs */
-	vf_mask = hw_data->pfvf_ops.get_vf2pf_sources(pmisc_addr);
+	vf_mask = GET_PFVF_OPS(accel_dev)->get_vf2pf_sources(pmisc_addr);
 
 	if (vf_mask) {
 		struct adf_accel_vf_info *vf_info;
diff --git a/drivers/crypto/qat/qat_common/adf_vf_isr.c b/drivers/crypto/qat/qat_common/adf_vf_isr.c
index fe094178f065..86c3bd0c9c2b 100644
--- a/drivers/crypto/qat/qat_common/adf_vf_isr.c
+++ b/drivers/crypto/qat/qat_common/adf_vf_isr.c
@@ -30,22 +30,16 @@ struct adf_vf_stop_data {
 
 void adf_enable_pf2vf_interrupts(struct adf_accel_dev *accel_dev)
 {
-	struct adf_accel_pci *pci_info = &accel_dev->accel_pci_dev;
-	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
-	void __iomem *pmisc_bar_addr =
-		pci_info->pci_bars[hw_data->get_misc_bar_id(hw_data)].virt_addr;
+	void __iomem *pmisc_addr = adf_get_pmisc_base(accel_dev);
 
-	ADF_CSR_WR(pmisc_bar_addr, ADF_VINTMSK_OFFSET, 0x0);
+	ADF_CSR_WR(pmisc_addr, ADF_VINTMSK_OFFSET, 0x0);
 }
 
 void adf_disable_pf2vf_interrupts(struct adf_accel_dev *accel_dev)
 {
-	struct adf_accel_pci *pci_info = &accel_dev->accel_pci_dev;
-	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
-	void __iomem *pmisc_bar_addr =
-		pci_info->pci_bars[hw_data->get_misc_bar_id(hw_data)].virt_addr;
+	void __iomem *pmisc_addr = adf_get_pmisc_base(accel_dev);
 
-	ADF_CSR_WR(pmisc_bar_addr, ADF_VINTMSK_OFFSET, 0x2);
+	ADF_CSR_WR(pmisc_addr, ADF_VINTMSK_OFFSET, 0x2);
 }
 EXPORT_SYMBOL_GPL(adf_disable_pf2vf_interrupts);
 
diff --git a/drivers/crypto/qat/qat_common/qat_hal.c b/drivers/crypto/qat/qat_common/qat_hal.c
index 12ca6b8764aa..4bfd8f3566f7 100644
--- a/drivers/crypto/qat/qat_common/qat_hal.c
+++ b/drivers/crypto/qat/qat_common/qat_hal.c
@@ -684,8 +684,7 @@ static int qat_hal_chip_init(struct icp_qat_fw_loader_handle *handle,
 {
 	struct adf_accel_pci *pci_info = &accel_dev->accel_pci_dev;
 	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
-	struct adf_bar *misc_bar =
-			&pci_info->pci_bars[hw_data->get_misc_bar_id(hw_data)];
+	void __iomem *pmisc_addr = adf_get_pmisc_base(accel_dev);
 	unsigned int max_en_ae_id = 0;
 	struct adf_bar *sram_bar;
 	unsigned int csr_val = 0;
@@ -715,18 +714,12 @@ static int qat_hal_chip_init(struct icp_qat_fw_loader_handle *handle,
 		handle->chip_info->fcu_loaded_ae_csr = FCU_AE_LOADED_4XXX;
 		handle->chip_info->fcu_loaded_ae_pos = 0;
 
-		handle->hal_cap_g_ctl_csr_addr_v =
-			(void __iomem *)((uintptr_t)misc_bar->virt_addr +
-			ICP_QAT_CAP_OFFSET_4XXX);
-		handle->hal_cap_ae_xfer_csr_addr_v =
-			(void __iomem *)((uintptr_t)misc_bar->virt_addr +
-			ICP_QAT_AE_OFFSET_4XXX);
-		handle->hal_ep_csr_addr_v =
-			(void __iomem *)((uintptr_t)misc_bar->virt_addr +
-			ICP_QAT_EP_OFFSET_4XXX);
+		handle->hal_cap_g_ctl_csr_addr_v = pmisc_addr + ICP_QAT_CAP_OFFSET_4XXX;
+		handle->hal_cap_ae_xfer_csr_addr_v = pmisc_addr + ICP_QAT_AE_OFFSET_4XXX;
+		handle->hal_ep_csr_addr_v = pmisc_addr + ICP_QAT_EP_OFFSET_4XXX;
 		handle->hal_cap_ae_local_csr_addr_v =
 			(void __iomem *)((uintptr_t)handle->hal_cap_ae_xfer_csr_addr_v
-							+ LOCAL_TO_XFER_REG_OFFSET);
+			+ LOCAL_TO_XFER_REG_OFFSET);
 		break;
 	case PCI_DEVICE_ID_INTEL_QAT_C62X:
 	case PCI_DEVICE_ID_INTEL_QAT_C3XXX:
@@ -749,15 +742,9 @@ static int qat_hal_chip_init(struct icp_qat_fw_loader_handle *handle,
 		handle->chip_info->fcu_dram_addr_lo = FCU_DRAM_ADDR_LO;
 		handle->chip_info->fcu_loaded_ae_csr = FCU_STATUS;
 		handle->chip_info->fcu_loaded_ae_pos = FCU_LOADED_AE_POS;
-		handle->hal_cap_g_ctl_csr_addr_v =
-			(void __iomem *)((uintptr_t)misc_bar->virt_addr +
-			ICP_QAT_CAP_OFFSET);
-		handle->hal_cap_ae_xfer_csr_addr_v =
-			(void __iomem *)((uintptr_t)misc_bar->virt_addr +
-			ICP_QAT_AE_OFFSET);
-		handle->hal_ep_csr_addr_v =
-			(void __iomem *)((uintptr_t)misc_bar->virt_addr +
-			ICP_QAT_EP_OFFSET);
+		handle->hal_cap_g_ctl_csr_addr_v = pmisc_addr + ICP_QAT_CAP_OFFSET;
+		handle->hal_cap_ae_xfer_csr_addr_v = pmisc_addr + ICP_QAT_AE_OFFSET;
+		handle->hal_ep_csr_addr_v = pmisc_addr + ICP_QAT_EP_OFFSET;
 		handle->hal_cap_ae_local_csr_addr_v =
 			(void __iomem *)((uintptr_t)handle->hal_cap_ae_xfer_csr_addr_v
 			+ LOCAL_TO_XFER_REG_OFFSET);
@@ -782,15 +769,9 @@ static int qat_hal_chip_init(struct icp_qat_fw_loader_handle *handle,
 		handle->chip_info->fcu_dram_addr_lo = 0;
 		handle->chip_info->fcu_loaded_ae_csr = 0;
 		handle->chip_info->fcu_loaded_ae_pos = 0;
-		handle->hal_cap_g_ctl_csr_addr_v =
-			(void __iomem *)((uintptr_t)misc_bar->virt_addr +
-			ICP_QAT_CAP_OFFSET);
-		handle->hal_cap_ae_xfer_csr_addr_v =
-			(void __iomem *)((uintptr_t)misc_bar->virt_addr +
-			ICP_QAT_AE_OFFSET);
-		handle->hal_ep_csr_addr_v =
-			(void __iomem *)((uintptr_t)misc_bar->virt_addr +
-			ICP_QAT_EP_OFFSET);
+		handle->hal_cap_g_ctl_csr_addr_v = pmisc_addr + ICP_QAT_CAP_OFFSET;
+		handle->hal_cap_ae_xfer_csr_addr_v = pmisc_addr + ICP_QAT_AE_OFFSET;
+		handle->hal_ep_csr_addr_v = pmisc_addr + ICP_QAT_EP_OFFSET;
 		handle->hal_cap_ae_local_csr_addr_v =
 			(void __iomem *)((uintptr_t)handle->hal_cap_ae_xfer_csr_addr_v
 			+ LOCAL_TO_XFER_REG_OFFSET);
-- 
2.31.1


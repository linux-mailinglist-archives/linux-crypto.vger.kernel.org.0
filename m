Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592CE44CAC9
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Nov 2021 21:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbhKJUzP (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 10 Nov 2021 15:55:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:55750 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232934AbhKJUzO (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 10 Nov 2021 15:55:14 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="232610939"
X-IronPort-AV: E=Sophos;i="5.87,224,1631602800"; 
   d="scan'208";a="232610939"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 12:52:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,224,1631602800"; 
   d="scan'208";a="642662978"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.51])
  by fmsmga001.fm.intel.com with ESMTP; 10 Nov 2021 12:52:24 -0800
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        marco.chiappero@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH 02/24] crypto: qat - refactor PF top half for PFVF
Date:   Wed, 10 Nov 2021 20:51:55 +0000
Message-Id: <20211110205217.99903-3-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211110205217.99903-1-giovanni.cabiddu@intel.com>
References: <20211110205217.99903-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Marco Chiappero <marco.chiappero@intel.com>

Move logic associated to handling VF2PF interrupt to its own function.
This will simplify the handling of multiple interrupt sources in the
function adf_msix_isr_ae() in the future.

Signed-off-by: Marco Chiappero <marco.chiappero@intel.com>
Co-developed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/qat/qat_common/adf_isr.c | 84 +++++++++++++------------
 1 file changed, 44 insertions(+), 40 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_isr.c b/drivers/crypto/qat/qat_common/adf_isr.c
index 40593c9449a2..5dfc534f1bf0 100644
--- a/drivers/crypto/qat/qat_common/adf_isr.c
+++ b/drivers/crypto/qat/qat_common/adf_isr.c
@@ -54,52 +54,56 @@ static irqreturn_t adf_msix_isr_bundle(int irq, void *bank_ptr)
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_PCI_IOV
+static bool adf_handle_vf2pf_int(struct adf_accel_dev *accel_dev)
+{
+	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+	int bar_id = hw_data->get_misc_bar_id(hw_data);
+	struct adf_bar *pmisc = &GET_BARS(accel_dev)[bar_id];
+	void __iomem *pmisc_addr = pmisc->virt_addr;
+	bool irq_handled = false;
+	unsigned long vf_mask;
+
+	/* Get the interrupt sources triggered by VFs */
+	vf_mask = hw_data->get_vf2pf_sources(pmisc_addr);
+
+	if (vf_mask) {
+		struct adf_accel_vf_info *vf_info;
+		int i;
+
+		/* Disable VF2PF interrupts for VFs with pending ints */
+		adf_disable_vf2pf_interrupts_irq(accel_dev, vf_mask);
+
+		/*
+		 * Handle VF2PF interrupt unless the VF is malicious and
+		 * is attempting to flood the host OS with VF2PF interrupts.
+		 */
+		for_each_set_bit(i, &vf_mask, ADF_MAX_NUM_VFS) {
+			vf_info = accel_dev->pf.vf_info + i;
+
+			if (!__ratelimit(&vf_info->vf2pf_ratelimit)) {
+				dev_info(&GET_DEV(accel_dev),
+					 "Too many ints from VF%d\n",
+					  vf_info->vf_nr + 1);
+				continue;
+			}
+
+			adf_schedule_vf2pf_handler(vf_info);
+			irq_handled = true;
+		}
+	}
+	return irq_handled;
+}
+#endif /* CONFIG_PCI_IOV */
+
 static irqreturn_t adf_msix_isr_ae(int irq, void *dev_ptr)
 {
 	struct adf_accel_dev *accel_dev = dev_ptr;
 
 #ifdef CONFIG_PCI_IOV
 	/* If SR-IOV is enabled (vf_info is non-NULL), check for VF->PF ints */
-	if (accel_dev->pf.vf_info) {
-		struct adf_hw_device_data *hw_data = accel_dev->hw_device;
-		struct adf_bar *pmisc =
-			&GET_BARS(accel_dev)[hw_data->get_misc_bar_id(hw_data)];
-		void __iomem *pmisc_addr = pmisc->virt_addr;
-		unsigned long vf_mask;
-
-		/* Get the interrupt sources triggered by VFs */
-		vf_mask = hw_data->get_vf2pf_sources(pmisc_addr);
-
-		if (vf_mask) {
-			struct adf_accel_vf_info *vf_info;
-			bool irq_handled = false;
-			int i;
-
-			/* Disable VF2PF interrupts for VFs with pending ints */
-			adf_disable_vf2pf_interrupts_irq(accel_dev, vf_mask);
-
-			/*
-			 * Handle VF2PF interrupt unless the VF is malicious and
-			 * is attempting to flood the host OS with VF2PF interrupts.
-			 */
-			for_each_set_bit(i, &vf_mask, ADF_MAX_NUM_VFS) {
-				vf_info = accel_dev->pf.vf_info + i;
-
-				if (!__ratelimit(&vf_info->vf2pf_ratelimit)) {
-					dev_info(&GET_DEV(accel_dev),
-						 "Too many ints from VF%d\n",
-						  vf_info->vf_nr + 1);
-					continue;
-				}
-
-				adf_schedule_vf2pf_handler(vf_info);
-				irq_handled = true;
-			}
-
-			if (irq_handled)
-				return IRQ_HANDLED;
-		}
-	}
+	if (accel_dev->pf.vf_info && adf_handle_vf2pf_int(accel_dev))
+		return IRQ_HANDLED;
 #endif /* CONFIG_PCI_IOV */
 
 	dev_dbg(&GET_DEV(accel_dev), "qat_dev%d spurious AE interrupt\n",
-- 
2.33.1


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7B244CAD1
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Nov 2021 21:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbhKJUz1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 10 Nov 2021 15:55:27 -0500
Received: from mga09.intel.com ([134.134.136.24]:55773 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233071AbhKJUz0 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 10 Nov 2021 15:55:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="232611081"
X-IronPort-AV: E=Sophos;i="5.87,224,1631602800"; 
   d="scan'208";a="232611081"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 12:52:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,224,1631602800"; 
   d="scan'208";a="642663098"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.51])
  by fmsmga001.fm.intel.com with ESMTP; 10 Nov 2021 12:52:36 -0800
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        marco.chiappero@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH 10/24] crypto: qat - relocate PFVF PF related logic
Date:   Wed, 10 Nov 2021 20:52:03 +0000
Message-Id: <20211110205217.99903-11-giovanni.cabiddu@intel.com>
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

Move device specific PFVF logic related to the PF to the newly created
adf_gen2_pfvf.c.
This refactory is done to isolate the GEN2 PFVF code into its own file
in preparation for the introduction of support for PFVF for GEN4
devices.

Signed-off-by: Marco Chiappero <marco.chiappero@intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 .../crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c  |  1 +
 .../crypto/qat/qat_c62x/adf_c62x_hw_data.c    |  1 +
 drivers/crypto/qat/qat_common/Makefile        |  3 +-
 .../crypto/qat/qat_common/adf_gen2_hw_data.c  | 48 ----------------
 .../crypto/qat/qat_common/adf_gen2_hw_data.h  | 13 -----
 drivers/crypto/qat/qat_common/adf_gen2_pfvf.c | 57 +++++++++++++++++++
 drivers/crypto/qat/qat_common/adf_gen2_pfvf.h | 19 +++++++
 .../qat/qat_dh895xcc/adf_dh895xcc_hw_data.c   |  1 +
 8 files changed, 81 insertions(+), 62 deletions(-)
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen2_pfvf.c
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen2_pfvf.h

diff --git a/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c b/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
index 1fa690219d92..0bc528004f79 100644
--- a/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
+++ b/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
@@ -4,6 +4,7 @@
 #include <adf_common_drv.h>
 #include <adf_pf2vf_msg.h>
 #include <adf_gen2_hw_data.h>
+#include <adf_gen2_pfvf.h>
 #include "adf_c3xxx_hw_data.h"
 #include "icp_qat_hw.h"
 
diff --git a/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c b/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
index 0613db077689..9303f2dbcaf9 100644
--- a/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
+++ b/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
@@ -4,6 +4,7 @@
 #include <adf_common_drv.h>
 #include <adf_pf2vf_msg.h>
 #include <adf_gen2_hw_data.h>
+#include <adf_gen2_pfvf.h>
 #include "adf_c62x_hw_data.h"
 #include "icp_qat_hw.h"
 
diff --git a/drivers/crypto/qat/qat_common/Makefile b/drivers/crypto/qat/qat_common/Makefile
index 9c57abdf56b7..3874e427d1f7 100644
--- a/drivers/crypto/qat/qat_common/Makefile
+++ b/drivers/crypto/qat/qat_common/Makefile
@@ -16,7 +16,8 @@ intel_qat-objs := adf_cfg.o \
 	qat_algs.o \
 	qat_asym_algs.o \
 	qat_uclo.o \
-	qat_hal.o
+	qat_hal.o \
+	adf_gen2_pfvf.o
 
 intel_qat-$(CONFIG_DEBUG_FS) += adf_transport_debug.o
 intel_qat-$(CONFIG_PCI_IOV) += adf_sriov.o adf_pf2vf_msg.o \
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_hw_data.c b/drivers/crypto/qat/qat_common/adf_gen2_hw_data.c
index 262bdc05dab4..3b48fdaaff6d 100644
--- a/drivers/crypto/qat/qat_common/adf_gen2_hw_data.c
+++ b/drivers/crypto/qat/qat_common/adf_gen2_hw_data.c
@@ -4,54 +4,6 @@
 #include "icp_qat_hw.h"
 #include <linux/pci.h>
 
-#define ADF_GEN2_PF2VF_OFFSET(i)	(0x3A000 + 0x280 + ((i) * 0x04))
-
-u32 adf_gen2_get_pf2vf_offset(u32 i)
-{
-	return ADF_GEN2_PF2VF_OFFSET(i);
-}
-EXPORT_SYMBOL_GPL(adf_gen2_get_pf2vf_offset);
-
-u32 adf_gen2_get_vf2pf_sources(void __iomem *pmisc_addr)
-{
-	u32 errsou3, errmsk3, vf_int_mask;
-
-	/* Get the interrupt sources triggered by VFs */
-	errsou3 = ADF_CSR_RD(pmisc_addr, ADF_GEN2_ERRSOU3);
-	vf_int_mask = ADF_GEN2_ERR_REG_VF2PF(errsou3);
-
-	/* To avoid adding duplicate entries to work queue, clear
-	 * vf_int_mask_sets bits that are already masked in ERRMSK register.
-	 */
-	errmsk3 = ADF_CSR_RD(pmisc_addr, ADF_GEN2_ERRMSK3);
-	vf_int_mask &= ~ADF_GEN2_ERR_REG_VF2PF(errmsk3);
-
-	return vf_int_mask;
-}
-EXPORT_SYMBOL_GPL(adf_gen2_get_vf2pf_sources);
-
-void adf_gen2_enable_vf2pf_interrupts(void __iomem *pmisc_addr, u32 vf_mask)
-{
-	/* Enable VF2PF Messaging Ints - VFs 0 through 15 per vf_mask[15:0] */
-	if (vf_mask & 0xFFFF) {
-		u32 val = ADF_CSR_RD(pmisc_addr, ADF_GEN2_ERRMSK3)
-			  & ~ADF_GEN2_ERR_MSK_VF2PF(vf_mask);
-		ADF_CSR_WR(pmisc_addr, ADF_GEN2_ERRMSK3, val);
-	}
-}
-EXPORT_SYMBOL_GPL(adf_gen2_enable_vf2pf_interrupts);
-
-void adf_gen2_disable_vf2pf_interrupts(void __iomem *pmisc_addr, u32 vf_mask)
-{
-	/* Disable VF2PF interrupts for VFs 0 through 15 per vf_mask[15:0] */
-	if (vf_mask & 0xFFFF) {
-		u32 val = ADF_CSR_RD(pmisc_addr, ADF_GEN2_ERRMSK3)
-			  | ADF_GEN2_ERR_MSK_VF2PF(vf_mask);
-		ADF_CSR_WR(pmisc_addr, ADF_GEN2_ERRMSK3, val);
-	}
-}
-EXPORT_SYMBOL_GPL(adf_gen2_disable_vf2pf_interrupts);
-
 u32 adf_gen2_get_num_accels(struct adf_hw_device_data *self)
 {
 	if (!self || !self->accel_mask)
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_hw_data.h b/drivers/crypto/qat/qat_common/adf_gen2_hw_data.h
index c169d704097d..448c97f740e7 100644
--- a/drivers/crypto/qat/qat_common/adf_gen2_hw_data.h
+++ b/drivers/crypto/qat/qat_common/adf_gen2_hw_data.h
@@ -136,19 +136,6 @@ do { \
 #define ADF_GEN2_CERRSSMSH(i)		((i) * 0x4000 + 0x10)
 #define ADF_GEN2_ERRSSMSH_EN		BIT(3)
 
- /* VF2PF interrupts */
-#define ADF_GEN2_ERRSOU3 (0x3A000 + 0x0C)
-#define ADF_GEN2_ERRSOU5 (0x3A000 + 0xD8)
-#define ADF_GEN2_ERRMSK3 (0x3A000 + 0x1C)
-#define ADF_GEN2_ERRMSK5 (0x3A000 + 0xDC)
-#define ADF_GEN2_ERR_REG_VF2PF(vf_src)	(((vf_src) & 0x01FFFE00) >> 9)
-#define ADF_GEN2_ERR_MSK_VF2PF(vf_mask)	(((vf_mask) & 0xFFFF) << 9)
-
-u32 adf_gen2_get_pf2vf_offset(u32 i);
-u32 adf_gen2_get_vf2pf_sources(void __iomem *pmisc_bar);
-void adf_gen2_enable_vf2pf_interrupts(void __iomem *pmisc_addr, u32 vf_mask);
-void adf_gen2_disable_vf2pf_interrupts(void __iomem *pmisc_addr, u32 vf_mask);
-
 u32 adf_gen2_get_num_accels(struct adf_hw_device_data *self);
 u32 adf_gen2_get_num_aes(struct adf_hw_device_data *self);
 void adf_gen2_enable_error_correction(struct adf_accel_dev *accel_dev);
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_pfvf.c b/drivers/crypto/qat/qat_common/adf_gen2_pfvf.c
new file mode 100644
index 000000000000..d4d79419daaa
--- /dev/null
+++ b/drivers/crypto/qat/qat_common/adf_gen2_pfvf.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2021 Intel Corporation */
+#include <linux/types.h>
+#include "adf_accel_devices.h"
+#include "adf_gen2_pfvf.h"
+
+ /* VF2PF interrupts */
+#define ADF_GEN2_ERR_REG_VF2PF(vf_src)	(((vf_src) & 0x01FFFE00) >> 9)
+#define ADF_GEN2_ERR_MSK_VF2PF(vf_mask)	(((vf_mask) & 0xFFFF) << 9)
+
+#define ADF_GEN2_PF2VF_OFFSET(i)	(0x3A000 + 0x280 + ((i) * 0x04))
+
+u32 adf_gen2_get_pf2vf_offset(u32 i)
+{
+	return ADF_GEN2_PF2VF_OFFSET(i);
+}
+EXPORT_SYMBOL_GPL(adf_gen2_get_pf2vf_offset);
+
+u32 adf_gen2_get_vf2pf_sources(void __iomem *pmisc_addr)
+{
+	u32 errsou3, errmsk3, vf_int_mask;
+
+	/* Get the interrupt sources triggered by VFs */
+	errsou3 = ADF_CSR_RD(pmisc_addr, ADF_GEN2_ERRSOU3);
+	vf_int_mask = ADF_GEN2_ERR_REG_VF2PF(errsou3);
+
+	/* To avoid adding duplicate entries to work queue, clear
+	 * vf_int_mask_sets bits that are already masked in ERRMSK register.
+	 */
+	errmsk3 = ADF_CSR_RD(pmisc_addr, ADF_GEN2_ERRMSK3);
+	vf_int_mask &= ~ADF_GEN2_ERR_REG_VF2PF(errmsk3);
+
+	return vf_int_mask;
+}
+EXPORT_SYMBOL_GPL(adf_gen2_get_vf2pf_sources);
+
+void adf_gen2_enable_vf2pf_interrupts(void __iomem *pmisc_addr, u32 vf_mask)
+{
+	/* Enable VF2PF Messaging Ints - VFs 0 through 15 per vf_mask[15:0] */
+	if (vf_mask & 0xFFFF) {
+		u32 val = ADF_CSR_RD(pmisc_addr, ADF_GEN2_ERRMSK3)
+			  & ~ADF_GEN2_ERR_MSK_VF2PF(vf_mask);
+		ADF_CSR_WR(pmisc_addr, ADF_GEN2_ERRMSK3, val);
+	}
+}
+EXPORT_SYMBOL_GPL(adf_gen2_enable_vf2pf_interrupts);
+
+void adf_gen2_disable_vf2pf_interrupts(void __iomem *pmisc_addr, u32 vf_mask)
+{
+	/* Disable VF2PF interrupts for VFs 0 through 15 per vf_mask[15:0] */
+	if (vf_mask & 0xFFFF) {
+		u32 val = ADF_CSR_RD(pmisc_addr, ADF_GEN2_ERRMSK3)
+			  | ADF_GEN2_ERR_MSK_VF2PF(vf_mask);
+		ADF_CSR_WR(pmisc_addr, ADF_GEN2_ERRMSK3, val);
+	}
+}
+EXPORT_SYMBOL_GPL(adf_gen2_disable_vf2pf_interrupts);
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_pfvf.h b/drivers/crypto/qat/qat_common/adf_gen2_pfvf.h
new file mode 100644
index 000000000000..0987e254e86b
--- /dev/null
+++ b/drivers/crypto/qat/qat_common/adf_gen2_pfvf.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2021 Intel Corporation */
+#ifndef ADF_GEN2_PFVF_H
+#define ADF_GEN2_PFVF_H
+
+#include <linux/types.h>
+#include "adf_accel_devices.h"
+
+#define ADF_GEN2_ERRSOU3 (0x3A000 + 0x0C)
+#define ADF_GEN2_ERRSOU5 (0x3A000 + 0xD8)
+#define ADF_GEN2_ERRMSK3 (0x3A000 + 0x1C)
+#define ADF_GEN2_ERRMSK5 (0x3A000 + 0xDC)
+
+u32 adf_gen2_get_pf2vf_offset(u32 i);
+u32 adf_gen2_get_vf2pf_sources(void __iomem *pmisc_bar);
+void adf_gen2_enable_vf2pf_interrupts(void __iomem *pmisc_addr, u32 vf_mask);
+void adf_gen2_disable_vf2pf_interrupts(void __iomem *pmisc_addr, u32 vf_mask);
+
+#endif /* ADF_GEN2_PFVF_H */
diff --git a/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c b/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
index 8e2e1554dcf6..6094ff1cdfc5 100644
--- a/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
+++ b/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
@@ -4,6 +4,7 @@
 #include <adf_pf2vf_msg.h>
 #include <adf_common_drv.h>
 #include <adf_gen2_hw_data.h>
+#include <adf_gen2_pfvf.h>
 #include "adf_dh895xcc_hw_data.h"
 #include "icp_qat_hw.h"
 
-- 
2.33.1


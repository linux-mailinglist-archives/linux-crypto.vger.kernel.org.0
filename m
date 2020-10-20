Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE9A28C299
	for <lists+linux-crypto@lfdr.de>; Mon, 12 Oct 2020 22:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgJLUjL (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 12 Oct 2020 16:39:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:33900 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbgJLUjL (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 12 Oct 2020 16:39:11 -0400
IronPort-SDR: p9vL06LKz2BEA/+FAx0xA7B9W76uJXxu1PD39VmVCJ6mWFFcjNQn8EQHBanzRpmGEiFcL0eigu
 TUR0zYH9Zwfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="165913066"
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="165913066"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 13:39:10 -0700
IronPort-SDR: fxEIYzNnkxGIhQBuBfrV79A1Yo//Y7tTuC2FL4Zv3JlyWa64QSiETYbAMSrR2diLzAKZNdgKbP
 OiwrRBMlVgZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="299328132"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.51])
  by fmsmga007.fm.intel.com with ESMTP; 12 Oct 2020 13:39:08 -0700
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 04/31] crypto: qat - fix configuration of iov threads
Date:   Mon, 12 Oct 2020 21:38:20 +0100
Message-Id: <20201012203847.340030-5-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012203847.340030-1-giovanni.cabiddu@intel.com>
References: <20201012203847.340030-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The number of AE2FUNC_MAP registers is different in every QAT device
(c62x, c3xxx and dh895xcc) although the logic and the register offsets
are the same across devices.

This patch separates the logic that configures the iov threads in a
common function that takes as input the number of AE2FUNC_MAP registers
supported by a device. The function is then added to the
adf_hw_device_data structure of each device, and called with the
appropriate parameters.

The configure iov thread logic is added to a new file,
adf_gen2_hw_data.c, that is going to contain code that is shared across
QAT GEN2 devices.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Fiona Trahe <fiona.trahe@intel.com>
Reviewed-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c  |  9 +++
 .../crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.h  |  4 ++
 .../crypto/qat/qat_c62x/adf_c62x_hw_data.c    |  9 +++
 .../crypto/qat/qat_c62x/adf_c62x_hw_data.h    |  4 ++
 drivers/crypto/qat/qat_common/Makefile        |  1 +
 .../crypto/qat/qat_common/adf_accel_devices.h |  2 +
 .../crypto/qat/qat_common/adf_gen2_hw_data.c  | 38 +++++++++++
 .../crypto/qat/qat_common/adf_gen2_hw_data.h  | 30 +++++++++
 drivers/crypto/qat/qat_common/adf_sriov.c     | 63 ++-----------------
 .../qat/qat_dh895xcc/adf_dh895xcc_hw_data.c   |  9 +++
 .../qat/qat_dh895xcc/adf_dh895xcc_hw_data.h   |  5 ++
 11 files changed, 115 insertions(+), 59 deletions(-)
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen2_hw_data.c
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen2_hw_data.h

diff --git a/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c b/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
index 62b0b290ff85..f449b2a0e82d 100644
--- a/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
+++ b/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
@@ -3,6 +3,7 @@
 #include <adf_accel_devices.h>
 #include <adf_common_drv.h>
 #include <adf_pf2vf_msg.h>
+#include <adf_gen2_hw_data.h>
 #include "adf_c3xxx_hw_data.h"
 
 /* Worker thread to service arbiter mappings based on dev SKUs */
@@ -171,6 +172,13 @@ static int adf_pf_enable_vf2pf_comms(struct adf_accel_dev *accel_dev)
 	return 0;
 }
 
+static void configure_iov_threads(struct adf_accel_dev *accel_dev, bool enable)
+{
+	adf_gen2_cfg_iov_thds(accel_dev, enable,
+			      ADF_C3XXX_AE2FUNC_MAP_GRP_A_NUM_REGS,
+			      ADF_C3XXX_AE2FUNC_MAP_GRP_B_NUM_REGS);
+}
+
 void adf_init_hw_data_c3xxx(struct adf_hw_device_data *hw_data)
 {
 	hw_data->dev_class = &c3xxx_class;
@@ -199,6 +207,7 @@ void adf_init_hw_data_c3xxx(struct adf_hw_device_data *hw_data)
 	hw_data->fw_mmp_name = ADF_C3XXX_MMP;
 	hw_data->init_admin_comms = adf_init_admin_comms;
 	hw_data->exit_admin_comms = adf_exit_admin_comms;
+	hw_data->configure_iov_threads = configure_iov_threads;
 	hw_data->disable_iov = adf_disable_sriov;
 	hw_data->send_admin_init = adf_send_admin_init;
 	hw_data->init_arb = adf_init_arb;
diff --git a/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.h b/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.h
index 94097816f68a..fece8e38025a 100644
--- a/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.h
+++ b/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.h
@@ -31,6 +31,10 @@
 #define ADF_C3XXX_PF2VF_OFFSET(i)	(0x3A000 + 0x280 + ((i) * 0x04))
 #define ADF_C3XXX_VINTMSK_OFFSET(i)	(0x3A000 + 0x200 + ((i) * 0x04))
 
+/* AE to function mapping */
+#define ADF_C3XXX_AE2FUNC_MAP_GRP_A_NUM_REGS 48
+#define ADF_C3XXX_AE2FUNC_MAP_GRP_B_NUM_REGS 6
+
 /* Firmware Binary */
 #define ADF_C3XXX_FW "qat_c3xxx.bin"
 #define ADF_C3XXX_MMP "qat_c3xxx_mmp.bin"
diff --git a/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c b/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
index 1334b43e46e4..d7bed610ae86 100644
--- a/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
+++ b/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
@@ -3,6 +3,7 @@
 #include <adf_accel_devices.h>
 #include <adf_common_drv.h>
 #include <adf_pf2vf_msg.h>
+#include <adf_gen2_hw_data.h>
 #include "adf_c62x_hw_data.h"
 
 /* Worker thread to service arbiter mappings based on dev SKUs */
@@ -181,6 +182,13 @@ static int adf_pf_enable_vf2pf_comms(struct adf_accel_dev *accel_dev)
 	return 0;
 }
 
+static void configure_iov_threads(struct adf_accel_dev *accel_dev, bool enable)
+{
+	adf_gen2_cfg_iov_thds(accel_dev, enable,
+			      ADF_C62X_AE2FUNC_MAP_GRP_A_NUM_REGS,
+			      ADF_C62X_AE2FUNC_MAP_GRP_B_NUM_REGS);
+}
+
 void adf_init_hw_data_c62x(struct adf_hw_device_data *hw_data)
 {
 	hw_data->dev_class = &c62x_class;
@@ -209,6 +217,7 @@ void adf_init_hw_data_c62x(struct adf_hw_device_data *hw_data)
 	hw_data->fw_mmp_name = ADF_C62X_MMP;
 	hw_data->init_admin_comms = adf_init_admin_comms;
 	hw_data->exit_admin_comms = adf_exit_admin_comms;
+	hw_data->configure_iov_threads = configure_iov_threads;
 	hw_data->disable_iov = adf_disable_sriov;
 	hw_data->send_admin_init = adf_send_admin_init;
 	hw_data->init_arb = adf_init_arb;
diff --git a/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.h b/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.h
index a2e2961a2102..53d3cb577f5b 100644
--- a/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.h
+++ b/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.h
@@ -32,6 +32,10 @@
 #define ADF_C62X_PF2VF_OFFSET(i)	(0x3A000 + 0x280 + ((i) * 0x04))
 #define ADF_C62X_VINTMSK_OFFSET(i)	(0x3A000 + 0x200 + ((i) * 0x04))
 
+/* AE to function mapping */
+#define ADF_C62X_AE2FUNC_MAP_GRP_A_NUM_REGS 80
+#define ADF_C62X_AE2FUNC_MAP_GRP_B_NUM_REGS 10
+
 /* Firmware Binary */
 #define ADF_C62X_FW "qat_c62x.bin"
 #define ADF_C62X_MMP "qat_c62x_mmp.bin"
diff --git a/drivers/crypto/qat/qat_common/Makefile b/drivers/crypto/qat/qat_common/Makefile
index 47a8e3d8b81a..25d28516dcdd 100644
--- a/drivers/crypto/qat/qat_common/Makefile
+++ b/drivers/crypto/qat/qat_common/Makefile
@@ -10,6 +10,7 @@ intel_qat-objs := adf_cfg.o \
 	adf_transport.o \
 	adf_admin.o \
 	adf_hw_arbiter.o \
+	adf_gen2_hw_data.o \
 	qat_crypto.o \
 	qat_algs.o \
 	qat_asym_algs.o \
diff --git a/drivers/crypto/qat/qat_common/adf_accel_devices.h b/drivers/crypto/qat/qat_common/adf_accel_devices.h
index 85b423d28f77..d7a27d15e137 100644
--- a/drivers/crypto/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/qat/qat_common/adf_accel_devices.h
@@ -125,6 +125,8 @@ struct adf_hw_device_data {
 	void (*get_arb_mapping)(struct adf_accel_dev *accel_dev,
 				const u32 **cfg);
 	void (*disable_iov)(struct adf_accel_dev *accel_dev);
+	void (*configure_iov_threads)(struct adf_accel_dev *accel_dev,
+				      bool enable);
 	void (*enable_ints)(struct adf_accel_dev *accel_dev);
 	int (*enable_vf2pf_comms)(struct adf_accel_dev *accel_dev);
 	void (*reset_device)(struct adf_accel_dev *accel_dev);
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_hw_data.c b/drivers/crypto/qat/qat_common/adf_gen2_hw_data.c
new file mode 100644
index 000000000000..26e345e3d7c3
--- /dev/null
+++ b/drivers/crypto/qat/qat_common/adf_gen2_hw_data.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2020 Intel Corporation */
+#include "adf_gen2_hw_data.h"
+
+void adf_gen2_cfg_iov_thds(struct adf_accel_dev *accel_dev, bool enable,
+			   int num_a_regs, int num_b_regs)
+{
+	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+	void __iomem *pmisc_addr;
+	struct adf_bar *pmisc;
+	int pmisc_id, i;
+	u32 reg;
+
+	pmisc_id = hw_data->get_misc_bar_id(hw_data);
+	pmisc = &GET_BARS(accel_dev)[pmisc_id];
+	pmisc_addr = pmisc->virt_addr;
+
+	/* Set/Unset Valid bit in AE Thread to PCIe Function Mapping Group A */
+	for (i = 0; i < num_a_regs; i++) {
+		reg = READ_CSR_AE2FUNCTION_MAP_A(pmisc_addr, i);
+		if (enable)
+			reg |= AE2FUNCTION_MAP_VALID;
+		else
+			reg &= ~AE2FUNCTION_MAP_VALID;
+		WRITE_CSR_AE2FUNCTION_MAP_A(pmisc_addr, i, reg);
+	}
+
+	/* Set/Unset Valid bit in AE Thread to PCIe Function Mapping Group B */
+	for (i = 0; i < num_b_regs; i++) {
+		reg = READ_CSR_AE2FUNCTION_MAP_B(pmisc_addr, i);
+		if (enable)
+			reg |= AE2FUNCTION_MAP_VALID;
+		else
+			reg &= ~AE2FUNCTION_MAP_VALID;
+		WRITE_CSR_AE2FUNCTION_MAP_B(pmisc_addr, i, reg);
+	}
+}
+EXPORT_SYMBOL_GPL(adf_gen2_cfg_iov_thds);
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_hw_data.h b/drivers/crypto/qat/qat_common/adf_gen2_hw_data.h
new file mode 100644
index 000000000000..1d348425d5f4
--- /dev/null
+++ b/drivers/crypto/qat/qat_common/adf_gen2_hw_data.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2020 Intel Corporation */
+#ifndef ADF_GEN2_HW_DATA_H_
+#define ADF_GEN2_HW_DATA_H_
+
+#include "adf_accel_devices.h"
+
+/* AE to function map */
+#define AE2FUNCTION_MAP_A_OFFSET	(0x3A400 + 0x190)
+#define AE2FUNCTION_MAP_B_OFFSET	(0x3A400 + 0x310)
+#define AE2FUNCTION_MAP_REG_SIZE	4
+#define AE2FUNCTION_MAP_VALID		BIT(7)
+
+#define READ_CSR_AE2FUNCTION_MAP_A(pmisc_bar_addr, index) \
+	ADF_CSR_RD(pmisc_bar_addr, AE2FUNCTION_MAP_A_OFFSET + \
+		   AE2FUNCTION_MAP_REG_SIZE * (index))
+#define WRITE_CSR_AE2FUNCTION_MAP_A(pmisc_bar_addr, index, value) \
+	ADF_CSR_WR(pmisc_bar_addr, AE2FUNCTION_MAP_A_OFFSET + \
+		   AE2FUNCTION_MAP_REG_SIZE * (index), value)
+#define READ_CSR_AE2FUNCTION_MAP_B(pmisc_bar_addr, index) \
+	ADF_CSR_RD(pmisc_bar_addr, AE2FUNCTION_MAP_B_OFFSET + \
+		   AE2FUNCTION_MAP_REG_SIZE * (index))
+#define WRITE_CSR_AE2FUNCTION_MAP_B(pmisc_bar_addr, index, value) \
+	ADF_CSR_WR(pmisc_bar_addr, AE2FUNCTION_MAP_B_OFFSET + \
+		   AE2FUNCTION_MAP_REG_SIZE * (index), value)
+
+void adf_gen2_cfg_iov_thds(struct adf_accel_dev *accel_dev, bool enable,
+			   int num_a_regs, int num_b_regs);
+
+#endif
diff --git a/drivers/crypto/qat/qat_common/adf_sriov.c b/drivers/crypto/qat/qat_common/adf_sriov.c
index 963b2bea78f2..dde6c57ef15a 100644
--- a/drivers/crypto/qat/qat_common/adf_sriov.c
+++ b/drivers/crypto/qat/qat_common/adf_sriov.c
@@ -10,31 +10,6 @@
 
 static struct workqueue_struct *pf2vf_resp_wq;
 
-#define ME2FUNCTION_MAP_A_OFFSET	(0x3A400 + 0x190)
-#define ME2FUNCTION_MAP_A_NUM_REGS	96
-
-#define ME2FUNCTION_MAP_B_OFFSET	(0x3A400 + 0x310)
-#define ME2FUNCTION_MAP_B_NUM_REGS	12
-
-#define ME2FUNCTION_MAP_REG_SIZE	4
-#define ME2FUNCTION_MAP_VALID		BIT(7)
-
-#define READ_CSR_ME2FUNCTION_MAP_A(pmisc_bar_addr, index)		\
-	ADF_CSR_RD(pmisc_bar_addr, ME2FUNCTION_MAP_A_OFFSET +		\
-		   ME2FUNCTION_MAP_REG_SIZE * index)
-
-#define WRITE_CSR_ME2FUNCTION_MAP_A(pmisc_bar_addr, index, value)	\
-	ADF_CSR_WR(pmisc_bar_addr, ME2FUNCTION_MAP_A_OFFSET +		\
-		   ME2FUNCTION_MAP_REG_SIZE * index, value)
-
-#define READ_CSR_ME2FUNCTION_MAP_B(pmisc_bar_addr, index)		\
-	ADF_CSR_RD(pmisc_bar_addr, ME2FUNCTION_MAP_B_OFFSET +		\
-		   ME2FUNCTION_MAP_REG_SIZE * index)
-
-#define WRITE_CSR_ME2FUNCTION_MAP_B(pmisc_bar_addr, index, value)	\
-	ADF_CSR_WR(pmisc_bar_addr, ME2FUNCTION_MAP_B_OFFSET +		\
-		   ME2FUNCTION_MAP_REG_SIZE * index, value)
-
 struct adf_pf2vf_resp {
 	struct work_struct pf2vf_resp_work;
 	struct adf_accel_vf_info *vf_info;
@@ -68,12 +43,8 @@ static int adf_enable_sriov(struct adf_accel_dev *accel_dev)
 	struct pci_dev *pdev = accel_to_pci_dev(accel_dev);
 	int totalvfs = pci_sriov_get_totalvfs(pdev);
 	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
-	struct adf_bar *pmisc =
-			&GET_BARS(accel_dev)[hw_data->get_misc_bar_id(hw_data)];
-	void __iomem *pmisc_addr = pmisc->virt_addr;
 	struct adf_accel_vf_info *vf_info;
 	int i;
-	u32 reg;
 
 	for (i = 0, vf_info = accel_dev->pf.vf_info; i < totalvfs;
 	     i++, vf_info++) {
@@ -90,19 +61,8 @@ static int adf_enable_sriov(struct adf_accel_dev *accel_dev)
 				     DEFAULT_RATELIMIT_BURST);
 	}
 
-	/* Set Valid bits in ME Thread to PCIe Function Mapping Group A */
-	for (i = 0; i < ME2FUNCTION_MAP_A_NUM_REGS; i++) {
-		reg = READ_CSR_ME2FUNCTION_MAP_A(pmisc_addr, i);
-		reg |= ME2FUNCTION_MAP_VALID;
-		WRITE_CSR_ME2FUNCTION_MAP_A(pmisc_addr, i, reg);
-	}
-
-	/* Set Valid bits in ME Thread to PCIe Function Mapping Group B */
-	for (i = 0; i < ME2FUNCTION_MAP_B_NUM_REGS; i++) {
-		reg = READ_CSR_ME2FUNCTION_MAP_B(pmisc_addr, i);
-		reg |= ME2FUNCTION_MAP_VALID;
-		WRITE_CSR_ME2FUNCTION_MAP_B(pmisc_addr, i, reg);
-	}
+	/* Set Valid bits in AE Thread to PCIe Function Mapping */
+	hw_data->configure_iov_threads(accel_dev, true);
 
 	/* Enable VF to PF interrupts for all VFs */
 	adf_enable_vf2pf_interrupts(accel_dev, GENMASK_ULL(totalvfs - 1, 0));
@@ -127,12 +87,8 @@ static int adf_enable_sriov(struct adf_accel_dev *accel_dev)
 void adf_disable_sriov(struct adf_accel_dev *accel_dev)
 {
 	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
-	struct adf_bar *pmisc =
-			&GET_BARS(accel_dev)[hw_data->get_misc_bar_id(hw_data)];
-	void __iomem *pmisc_addr = pmisc->virt_addr;
 	int totalvfs = pci_sriov_get_totalvfs(accel_to_pci_dev(accel_dev));
 	struct adf_accel_vf_info *vf;
-	u32 reg;
 	int i;
 
 	if (!accel_dev->pf.vf_info)
@@ -145,19 +101,8 @@ void adf_disable_sriov(struct adf_accel_dev *accel_dev)
 	/* Disable VF to PF interrupts */
 	adf_disable_vf2pf_interrupts(accel_dev, 0xFFFFFFFF);
 
-	/* Clear Valid bits in ME Thread to PCIe Function Mapping Group A */
-	for (i = 0; i < ME2FUNCTION_MAP_A_NUM_REGS; i++) {
-		reg = READ_CSR_ME2FUNCTION_MAP_A(pmisc_addr, i);
-		reg &= ~ME2FUNCTION_MAP_VALID;
-		WRITE_CSR_ME2FUNCTION_MAP_A(pmisc_addr, i, reg);
-	}
-
-	/* Clear Valid bits in ME Thread to PCIe Function Mapping Group B */
-	for (i = 0; i < ME2FUNCTION_MAP_B_NUM_REGS; i++) {
-		reg = READ_CSR_ME2FUNCTION_MAP_B(pmisc_addr, i);
-		reg &= ~ME2FUNCTION_MAP_VALID;
-		WRITE_CSR_ME2FUNCTION_MAP_B(pmisc_addr, i, reg);
-	}
+	/* Clear Valid bits in AE Thread to PCIe Function Mapping */
+	hw_data->configure_iov_threads(accel_dev, false);
 
 	for (i = 0, vf = accel_dev->pf.vf_info; i < totalvfs; i++, vf++) {
 		tasklet_disable(&vf->vf2pf_bh_tasklet);
diff --git a/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c b/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
index 1f3ea3ba1cee..7b2f13ff49fd 100644
--- a/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
+++ b/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
@@ -3,6 +3,7 @@
 #include <adf_accel_devices.h>
 #include <adf_pf2vf_msg.h>
 #include <adf_common_drv.h>
+#include <adf_gen2_hw_data.h>
 #include "adf_dh895xcc_hw_data.h"
 
 /* Worker thread to service arbiter mappings based on dev SKUs */
@@ -180,6 +181,13 @@ static int adf_pf_enable_vf2pf_comms(struct adf_accel_dev *accel_dev)
 	return 0;
 }
 
+static void configure_iov_threads(struct adf_accel_dev *accel_dev, bool enable)
+{
+	adf_gen2_cfg_iov_thds(accel_dev, enable,
+			      ADF_DH895XCC_AE2FUNC_MAP_GRP_A_NUM_REGS,
+			      ADF_DH895XCC_AE2FUNC_MAP_GRP_B_NUM_REGS);
+}
+
 void adf_init_hw_data_dh895xcc(struct adf_hw_device_data *hw_data)
 {
 	hw_data->dev_class = &dh895xcc_class;
@@ -208,6 +216,7 @@ void adf_init_hw_data_dh895xcc(struct adf_hw_device_data *hw_data)
 	hw_data->fw_mmp_name = ADF_DH895XCC_MMP;
 	hw_data->init_admin_comms = adf_init_admin_comms;
 	hw_data->exit_admin_comms = adf_exit_admin_comms;
+	hw_data->configure_iov_threads = configure_iov_threads;
 	hw_data->disable_iov = adf_disable_sriov;
 	hw_data->send_admin_init = adf_send_admin_init;
 	hw_data->init_arb = adf_init_arb;
diff --git a/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.h b/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.h
index 082a04466dca..4d613923d155 100644
--- a/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.h
+++ b/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.h
@@ -36,6 +36,11 @@
 
 #define ADF_DH895XCC_PF2VF_OFFSET(i)	(0x3A000 + 0x280 + ((i) * 0x04))
 #define ADF_DH895XCC_VINTMSK_OFFSET(i)	(0x3A000 + 0x200 + ((i) * 0x04))
+
+/* AE to function mapping */
+#define ADF_DH895XCC_AE2FUNC_MAP_GRP_A_NUM_REGS 96
+#define ADF_DH895XCC_AE2FUNC_MAP_GRP_B_NUM_REGS 12
+
 /* FW names */
 #define ADF_DH895XCC_FW "qat_895xcc.bin"
 #define ADF_DH895XCC_MMP "qat_895xcc_mmp.bin"
-- 
2.26.2


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BA02B20C5
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Nov 2020 17:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgKMQq4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 13 Nov 2020 11:46:56 -0500
Received: from mga07.intel.com ([134.134.136.100]:5727 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbgKMQq4 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 13 Nov 2020 11:46:56 -0500
IronPort-SDR: JWmPoR/716k4kI06or1anY4zQ03/LW290+R1sHfsArlI25g35dn/MKNsVR5baxceCSPqv0ynYI
 9ABBrABldMww==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="234655791"
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="234655791"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 08:46:54 -0800
IronPort-SDR: 6GK7z3CNlxUIBXVyIbxdL910JJhFVB2LFV8jfkxWcnbZYF2UHueeDRc2QbT2TMjBs9xozRxLVj
 GehSb8Rn6TtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="328926319"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.51])
  by orsmga006.jf.intel.com with ESMTP; 13 Nov 2020 08:46:52 -0800
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>
Subject: [PATCH 3/3] crypto: qat - add qat_4xxx driver
Date:   Fri, 13 Nov 2020 16:46:43 +0000
Message-Id: <20201113164643.103383-4-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113164643.103383-1-giovanni.cabiddu@intel.com>
References: <20201113164643.103383-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add support for QAT 4xxx devices.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Fiona Trahe <fiona.trahe@intel.com>
---
 drivers/crypto/qat/Kconfig                    |  11 +
 drivers/crypto/qat/Makefile                   |   1 +
 drivers/crypto/qat/qat_4xxx/Makefile          |   4 +
 .../crypto/qat/qat_4xxx/adf_4xxx_hw_data.c    | 218 ++++++++++++
 .../crypto/qat/qat_4xxx/adf_4xxx_hw_data.h    |  75 ++++
 drivers/crypto/qat/qat_4xxx/adf_drv.c         | 320 ++++++++++++++++++
 drivers/crypto/qat/qat_common/Makefile        |   1 +
 .../crypto/qat/qat_common/adf_accel_devices.h |   1 +
 .../crypto/qat/qat_common/adf_cfg_common.h    |   3 +-
 .../crypto/qat/qat_common/adf_gen4_hw_data.c  | 101 ++++++
 .../crypto/qat/qat_common/adf_gen4_hw_data.h  |  99 ++++++
 11 files changed, 833 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/qat/qat_4xxx/Makefile
 create mode 100644 drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
 create mode 100644 drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h
 create mode 100644 drivers/crypto/qat/qat_4xxx/adf_drv.c
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen4_hw_data.c
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen4_hw_data.h

diff --git a/drivers/crypto/qat/Kconfig b/drivers/crypto/qat/Kconfig
index 2006322345de..beb379b23dc3 100644
--- a/drivers/crypto/qat/Kconfig
+++ b/drivers/crypto/qat/Kconfig
@@ -46,6 +46,17 @@ config CRYPTO_DEV_QAT_C62X
 	  To compile this as a module, choose M here: the module
 	  will be called qat_c62x.
 
+config CRYPTO_DEV_QAT_4XXX
+	tristate "Support for Intel(R) QAT_4XXX"
+	depends on X86 && PCI
+	select CRYPTO_DEV_QAT
+	help
+	  Support for Intel(R) QuickAssist Technology QAT_4xxx
+	  for accelerating crypto and compression workloads.
+
+	  To compile this as a module, choose M here: the module
+	  will be called qat_4xxx.
+
 config CRYPTO_DEV_QAT_DH895xCCVF
 	tristate "Support for Intel(R) DH895xCC Virtual Function"
 	depends on X86 && PCI
diff --git a/drivers/crypto/qat/Makefile b/drivers/crypto/qat/Makefile
index 7dd15e751d02..258c8a626ce0 100644
--- a/drivers/crypto/qat/Makefile
+++ b/drivers/crypto/qat/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_CRYPTO_DEV_QAT) += qat_common/
 obj-$(CONFIG_CRYPTO_DEV_QAT_DH895xCC) += qat_dh895xcc/
 obj-$(CONFIG_CRYPTO_DEV_QAT_C3XXX) += qat_c3xxx/
 obj-$(CONFIG_CRYPTO_DEV_QAT_C62X) += qat_c62x/
+obj-$(CONFIG_CRYPTO_DEV_QAT_4XXX) += qat_4xxx/
 obj-$(CONFIG_CRYPTO_DEV_QAT_DH895xCCVF) += qat_dh895xccvf/
 obj-$(CONFIG_CRYPTO_DEV_QAT_C3XXXVF) += qat_c3xxxvf/
 obj-$(CONFIG_CRYPTO_DEV_QAT_C62XVF) += qat_c62xvf/
diff --git a/drivers/crypto/qat/qat_4xxx/Makefile b/drivers/crypto/qat/qat_4xxx/Makefile
new file mode 100644
index 000000000000..ff9c8b5897ea
--- /dev/null
+++ b/drivers/crypto/qat/qat_4xxx/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+ccflags-y := -I $(srctree)/$(src)/../qat_common
+obj-$(CONFIG_CRYPTO_DEV_QAT_4XXX) += qat_4xxx.o
+qat_4xxx-objs := adf_drv.o adf_4xxx_hw_data.o
diff --git a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
new file mode 100644
index 000000000000..e7a7c1e3da28
--- /dev/null
+++ b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2020 Intel Corporation */
+#include <adf_accel_devices.h>
+#include <adf_common_drv.h>
+#include <adf_pf2vf_msg.h>
+#include <adf_gen4_hw_data.h>
+#include "adf_4xxx_hw_data.h"
+
+struct adf_fw_config {
+	u32 ae_mask;
+	char *obj_name;
+};
+
+static struct adf_fw_config adf_4xxx_fw_config[] = {
+	{0xF0, ADF_4XXX_SYM_OBJ},
+	{0xF, ADF_4XXX_ASYM_OBJ},
+	{0x100, ADF_4XXX_ADMIN_OBJ},
+};
+
+/* Worker thread to service arbiter mappings */
+static u32 thrd_to_arb_map[] = {
+	0x5555555, 0x5555555, 0x5555555, 0x5555555,
+	0xAAAAAAA, 0xAAAAAAA, 0xAAAAAAA, 0xAAAAAAA,
+	0x0
+};
+
+static struct adf_hw_device_class adf_4xxx_class = {
+	.name = ADF_4XXX_DEVICE_NAME,
+	.type = DEV_4XXX,
+	.instances = 0,
+};
+
+static u32 get_accel_mask(struct adf_hw_device_data *self)
+{
+	return ADF_4XXX_ACCELERATORS_MASK;
+}
+
+static u32 get_ae_mask(struct adf_hw_device_data *self)
+{
+	u32 me_disable = self->fuses;
+
+	return ~me_disable & ADF_4XXX_ACCELENGINES_MASK;
+}
+
+static u32 get_num_accels(struct adf_hw_device_data *self)
+{
+	return ADF_4XXX_MAX_ACCELERATORS;
+}
+
+static u32 get_num_aes(struct adf_hw_device_data *self)
+{
+	if (!self || !self->ae_mask)
+		return 0;
+
+	return hweight32(self->ae_mask);
+}
+
+static u32 get_misc_bar_id(struct adf_hw_device_data *self)
+{
+	return ADF_4XXX_PMISC_BAR;
+}
+
+static u32 get_etr_bar_id(struct adf_hw_device_data *self)
+{
+	return ADF_4XXX_ETR_BAR;
+}
+
+static u32 get_sram_bar_id(struct adf_hw_device_data *self)
+{
+	return ADF_4XXX_SRAM_BAR;
+}
+
+/*
+ * The vector routing table is used to select the MSI-X entry to use for each
+ * interrupt source.
+ * The first ADF_4XXX_ETR_MAX_BANKS entries correspond to ring interrupts.
+ * The final entry corresponds to VF2PF or error interrupts.
+ * This vector table could be used to configure one MSI-X entry to be shared
+ * between multiple interrupt sources.
+ *
+ * The default routing is set to have a one to one correspondence between the
+ * interrupt source and the MSI-X entry used.
+ */
+static void set_msix_default_rttable(struct adf_accel_dev *accel_dev)
+{
+	void __iomem *csr;
+	int i;
+
+	csr = (&GET_BARS(accel_dev)[ADF_4XXX_PMISC_BAR])->virt_addr;
+	for (i = 0; i <= ADF_4XXX_ETR_MAX_BANKS; i++)
+		ADF_CSR_WR(csr, ADF_4XXX_MSIX_RTTABLE_OFFSET(i), i);
+}
+
+static enum dev_sku_info get_sku(struct adf_hw_device_data *self)
+{
+	return DEV_SKU_1;
+}
+
+static void adf_get_arbiter_mapping(struct adf_accel_dev *accel_dev,
+				    u32 const **arb_map_config)
+{
+	struct adf_hw_device_data *hw_device = accel_dev->hw_device;
+	unsigned long ae_mask = hw_device->ae_mask;
+	int i;
+
+	for_each_clear_bit(i, &ae_mask, ADF_4XXX_MAX_ACCELENGINES)
+		thrd_to_arb_map[i] = 0;
+
+	*arb_map_config = thrd_to_arb_map;
+}
+
+static void get_arb_info(struct arb_info *arb_info)
+{
+	arb_info->arb_cfg = ADF_4XXX_ARB_CONFIG;
+	arb_info->arb_offset = ADF_4XXX_ARB_OFFSET;
+	arb_info->wt2sam_offset = ADF_4XXX_ARB_WRK_2_SER_MAP_OFFSET;
+}
+
+static void get_admin_info(struct admin_info *admin_csrs_info)
+{
+	admin_csrs_info->mailbox_offset = ADF_4XXX_MAILBOX_BASE_OFFSET;
+	admin_csrs_info->admin_msg_ur = ADF_4XXX_ADMINMSGUR_OFFSET;
+	admin_csrs_info->admin_msg_lr = ADF_4XXX_ADMINMSGLR_OFFSET;
+}
+
+static void adf_enable_error_correction(struct adf_accel_dev *accel_dev)
+{
+	struct adf_bar *misc_bar = &GET_BARS(accel_dev)[ADF_4XXX_PMISC_BAR];
+	void __iomem *csr = misc_bar->virt_addr;
+
+	/* Enable all in errsou3 except VFLR notification on host */
+	ADF_CSR_WR(csr, ADF_4XXX_ERRMSK3, ADF_4XXX_VFLNOTIFY);
+}
+
+static void adf_enable_ints(struct adf_accel_dev *accel_dev)
+{
+	void __iomem *addr;
+
+	addr = (&GET_BARS(accel_dev)[ADF_4XXX_PMISC_BAR])->virt_addr;
+
+	/* Enable bundle interrupts */
+	ADF_CSR_WR(addr, ADF_4XXX_SMIAPF_RP_X0_MASK_OFFSET, 0);
+	ADF_CSR_WR(addr, ADF_4XXX_SMIAPF_RP_X1_MASK_OFFSET, 0);
+
+	/* Enable misc interrupts */
+	ADF_CSR_WR(addr, ADF_4XXX_SMIAPF_MASK_OFFSET, 0);
+}
+
+static int adf_pf_enable_vf2pf_comms(struct adf_accel_dev *accel_dev)
+{
+	return 0;
+}
+
+static u32 uof_get_num_objs(void)
+{
+	return ARRAY_SIZE(adf_4xxx_fw_config);
+}
+
+static char *uof_get_name(u32 obj_num)
+{
+	return adf_4xxx_fw_config[obj_num].obj_name;
+}
+
+static u32 uof_get_ae_mask(u32 obj_num)
+{
+	return adf_4xxx_fw_config[obj_num].ae_mask;
+}
+
+void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data)
+{
+	hw_data->dev_class = &adf_4xxx_class;
+	hw_data->instance_id = adf_4xxx_class.instances++;
+	hw_data->num_banks = ADF_4XXX_ETR_MAX_BANKS;
+	hw_data->num_rings_per_bank = ADF_4XXX_NUM_RINGS_PER_BANK;
+	hw_data->num_accel = ADF_4XXX_MAX_ACCELERATORS;
+	hw_data->num_engines = ADF_4XXX_MAX_ACCELENGINES;
+	hw_data->num_logical_accel = 1;
+	hw_data->tx_rx_gap = ADF_4XXX_RX_RINGS_OFFSET;
+	hw_data->tx_rings_mask = ADF_4XXX_TX_RINGS_MASK;
+	hw_data->alloc_irq = adf_isr_resource_alloc;
+	hw_data->free_irq = adf_isr_resource_free;
+	hw_data->enable_error_correction = adf_enable_error_correction;
+	hw_data->get_accel_mask = get_accel_mask;
+	hw_data->get_ae_mask = get_ae_mask;
+	hw_data->get_num_accels = get_num_accels;
+	hw_data->get_num_aes = get_num_aes;
+	hw_data->get_sram_bar_id = get_sram_bar_id;
+	hw_data->get_etr_bar_id = get_etr_bar_id;
+	hw_data->get_misc_bar_id = get_misc_bar_id;
+	hw_data->get_arb_info = get_arb_info;
+	hw_data->get_admin_info = get_admin_info;
+	hw_data->get_sku = get_sku;
+	hw_data->fw_name = ADF_4XXX_FW;
+	hw_data->fw_mmp_name = ADF_4XXX_MMP;
+	hw_data->init_admin_comms = adf_init_admin_comms;
+	hw_data->exit_admin_comms = adf_exit_admin_comms;
+	hw_data->disable_iov = adf_disable_sriov;
+	hw_data->send_admin_init = adf_send_admin_init;
+	hw_data->init_arb = adf_init_arb;
+	hw_data->exit_arb = adf_exit_arb;
+	hw_data->get_arb_mapping = adf_get_arbiter_mapping;
+	hw_data->enable_ints = adf_enable_ints;
+	hw_data->enable_vf2pf_comms = adf_pf_enable_vf2pf_comms;
+	hw_data->reset_device = adf_reset_flr;
+	hw_data->min_iov_compat_ver = ADF_PFVF_COMPATIBILITY_VERSION;
+	hw_data->admin_ae_mask = ADF_4XXX_ADMIN_AE_MASK;
+	hw_data->uof_get_num_objs = uof_get_num_objs;
+	hw_data->uof_get_name = uof_get_name;
+	hw_data->uof_get_ae_mask = uof_get_ae_mask;
+	hw_data->set_msix_rttable = set_msix_default_rttable;
+
+	adf_gen4_init_hw_csr_ops(&hw_data->csr_ops);
+}
+
+void adf_clean_hw_data_4xxx(struct adf_hw_device_data *hw_data)
+{
+	hw_data->dev_class->instances--;
+}
diff --git a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h
new file mode 100644
index 000000000000..cdde0be886bf
--- /dev/null
+++ b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2014 - 2020 Intel Corporation */
+#ifndef ADF_4XXX_HW_DATA_H_
+#define ADF_4XXX_HW_DATA_H_
+
+#include <adf_accel_devices.h>
+
+/* PCIe configuration space */
+#define ADF_4XXX_SRAM_BAR		0
+#define ADF_4XXX_PMISC_BAR		1
+#define ADF_4XXX_ETR_BAR		2
+#define ADF_4XXX_RX_RINGS_OFFSET	1
+#define ADF_4XXX_TX_RINGS_MASK		0x1
+#define ADF_4XXX_MAX_ACCELERATORS	1
+#define ADF_4XXX_MAX_ACCELENGINES	9
+#define ADF_4XXX_BAR_MASK		(BIT(0) | BIT(2) | BIT(4))
+
+/* Physical function fuses */
+#define ADF_4XXX_FUSECTL0_OFFSET	(0x2C8)
+#define ADF_4XXX_FUSECTL1_OFFSET	(0x2CC)
+#define ADF_4XXX_FUSECTL2_OFFSET	(0x2D0)
+#define ADF_4XXX_FUSECTL3_OFFSET	(0x2D4)
+#define ADF_4XXX_FUSECTL4_OFFSET	(0x2D8)
+#define ADF_4XXX_FUSECTL5_OFFSET	(0x2DC)
+
+#define ADF_4XXX_ACCELERATORS_MASK	(0x1)
+#define ADF_4XXX_ACCELENGINES_MASK	(0x1FF)
+#define ADF_4XXX_ADMIN_AE_MASK		(0x100)
+
+#define ADF_4XXX_ETR_MAX_BANKS		64
+
+/* MSIX interrupt */
+#define ADF_4XXX_SMIAPF_RP_X0_MASK_OFFSET	(0x41A040)
+#define ADF_4XXX_SMIAPF_RP_X1_MASK_OFFSET	(0x41A044)
+#define ADF_4XXX_SMIAPF_MASK_OFFSET		(0x41A084)
+#define ADF_4XXX_MSIX_RTTABLE_OFFSET(i)		(0x409000 + ((i) * 0x04))
+
+/* Bank and ring configuration */
+#define ADF_4XXX_NUM_RINGS_PER_BANK	2
+
+/* Error source registers */
+#define ADF_4XXX_ERRSOU0	(0x41A200)
+#define ADF_4XXX_ERRSOU1	(0x41A204)
+#define ADF_4XXX_ERRSOU2	(0x41A208)
+#define ADF_4XXX_ERRSOU3	(0x41A20C)
+
+/* Error source mask registers */
+#define ADF_4XXX_ERRMSK0	(0x41A210)
+#define ADF_4XXX_ERRMSK1	(0x41A214)
+#define ADF_4XXX_ERRMSK2	(0x41A218)
+#define ADF_4XXX_ERRMSK3	(0x41A21C)
+
+#define ADF_4XXX_VFLNOTIFY	BIT(7)
+
+/* Arbiter configuration */
+#define ADF_4XXX_ARB_CONFIG			(BIT(31) | BIT(6) | BIT(0))
+#define ADF_4XXX_ARB_OFFSET			(0x0)
+#define ADF_4XXX_ARB_WRK_2_SER_MAP_OFFSET	(0x400)
+
+/* Admin Interface Reg Offset */
+#define ADF_4XXX_ADMINMSGUR_OFFSET	(0x500574)
+#define ADF_4XXX_ADMINMSGLR_OFFSET	(0x500578)
+#define ADF_4XXX_MAILBOX_BASE_OFFSET	(0x600970)
+
+/* Firmware Binaries */
+#define ADF_4XXX_FW		"qat_4xxx.bin"
+#define ADF_4XXX_MMP		"qat_4xxx_mmp.bin"
+#define ADF_4XXX_SYM_OBJ	"qat_4xxx_sym.bin"
+#define ADF_4XXX_ASYM_OBJ	"qat_4xxx_asym.bin"
+#define ADF_4XXX_ADMIN_OBJ	"qat_4xxx_admin.bin"
+
+void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data);
+void adf_clean_hw_data_4xxx(struct adf_hw_device_data *hw_data);
+
+#endif
diff --git a/drivers/crypto/qat/qat_4xxx/adf_drv.c b/drivers/crypto/qat/qat_4xxx/adf_drv.c
new file mode 100644
index 000000000000..de5a955f406a
--- /dev/null
+++ b/drivers/crypto/qat/qat_4xxx/adf_drv.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2020 Intel Corporation */
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include <adf_accel_devices.h>
+#include <adf_cfg.h>
+#include <adf_common_drv.h>
+
+#include "adf_4xxx_hw_data.h"
+#include "qat_crypto.h"
+#include "adf_transport_access_macros.h"
+
+static const struct pci_device_id adf_pci_tbl[] = {
+	{ PCI_VDEVICE(INTEL, ADF_4XXX_PCI_DEVICE_ID), },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, adf_pci_tbl);
+
+static void adf_cleanup_accel(struct adf_accel_dev *accel_dev)
+{
+	if (accel_dev->hw_device) {
+		adf_clean_hw_data_4xxx(accel_dev->hw_device);
+		accel_dev->hw_device = NULL;
+	}
+	adf_cfg_dev_remove(accel_dev);
+	debugfs_remove(accel_dev->debugfs_dir);
+	adf_devmgr_rm_dev(accel_dev, NULL);
+}
+
+static int adf_crypto_dev_config(struct adf_accel_dev *accel_dev)
+{
+	char key[ADF_CFG_MAX_KEY_LEN_IN_BYTES];
+	int banks = GET_MAX_BANKS(accel_dev);
+	int cpus = num_online_cpus();
+	unsigned long bank, val;
+	int instances;
+	int ret;
+	int i;
+
+	if (adf_hw_dev_has_crypto(accel_dev))
+		instances = min(cpus, banks / 2);
+	else
+		instances = 0;
+
+	ret = adf_cfg_section_add(accel_dev, ADF_KERNEL_SEC);
+	if (ret)
+		goto err;
+
+	ret = adf_cfg_section_add(accel_dev, "Accelerator0");
+	if (ret)
+		goto err;
+
+	for (i = 0; i < instances; i++) {
+		val = i;
+		bank = i * 2;
+		snprintf(key, sizeof(key), ADF_CY "%d" ADF_RING_ASYM_BANK_NUM, i);
+		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
+						  key, &bank, ADF_DEC);
+		if (ret)
+			goto err;
+
+		bank += 1;
+		snprintf(key, sizeof(key), ADF_CY "%d" ADF_RING_SYM_BANK_NUM, i);
+		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
+						  key, &bank, ADF_DEC);
+		if (ret)
+			goto err;
+
+		snprintf(key, sizeof(key), ADF_CY "%d" ADF_ETRMGR_CORE_AFFINITY,
+			 i);
+		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
+						  key, &val, ADF_DEC);
+		if (ret)
+			goto err;
+
+		snprintf(key, sizeof(key), ADF_CY "%d" ADF_RING_ASYM_SIZE, i);
+		val = 128;
+		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
+						  key, &val, ADF_DEC);
+		if (ret)
+			goto err;
+
+		val = 512;
+		snprintf(key, sizeof(key), ADF_CY "%d" ADF_RING_SYM_SIZE, i);
+		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
+						  key, &val, ADF_DEC);
+		if (ret)
+			goto err;
+
+		val = 0;
+		snprintf(key, sizeof(key), ADF_CY "%d" ADF_RING_ASYM_TX, i);
+		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
+						  key, &val, ADF_DEC);
+		if (ret)
+			goto err;
+
+		val = 0;
+		snprintf(key, sizeof(key), ADF_CY "%d" ADF_RING_SYM_TX, i);
+		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
+						  key, &val, ADF_DEC);
+		if (ret)
+			goto err;
+
+		val = 1;
+		snprintf(key, sizeof(key), ADF_CY "%d" ADF_RING_ASYM_RX, i);
+		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
+						  key, &val, ADF_DEC);
+		if (ret)
+			goto err;
+
+		val = 1;
+		snprintf(key, sizeof(key), ADF_CY "%d" ADF_RING_SYM_RX, i);
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
+	ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC, ADF_NUM_CY,
+					  &val, ADF_DEC);
+	if (ret)
+		goto err;
+
+	set_bit(ADF_STATUS_CONFIGURED, &accel_dev->status);
+	return 0;
+err:
+	dev_err(&GET_DEV(accel_dev), "Failed to start QAT accel dev\n");
+	return ret;
+}
+
+static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	struct adf_accel_dev *accel_dev;
+	struct adf_accel_pci *accel_pci_dev;
+	struct adf_hw_device_data *hw_data;
+	char name[ADF_DEVICE_NAME_LENGTH];
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
+	adf_init_hw_data_4xxx(accel_dev->hw_device);
+
+	pci_read_config_byte(pdev, PCI_REVISION_ID, &accel_pci_dev->revid);
+	pci_read_config_dword(pdev, ADF_4XXX_FUSECTL4_OFFSET, &hw_data->fuses);
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
+	/* Create dev top level debugfs entry */
+	snprintf(name, sizeof(name), "%s%s_%s", ADF_DEVICE_NAME_PREFIX,
+		 hw_data->dev_class->name, pci_name(pdev));
+
+	accel_dev->debugfs_dir = debugfs_create_dir(name, NULL);
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
+	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64))) {
+		if ((pci_set_dma_mask(pdev, DMA_BIT_MASK(32)))) {
+			dev_err(&pdev->dev, "No usable DMA configuration.\n");
+			ret = -EFAULT;
+			goto out_err;
+		} else {
+			pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
+		}
+	} else {
+		pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
+	}
+
+	/* Find and map all the device's BARS */
+	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM) & ADF_4XXX_BAR_MASK;
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
+	if (adf_enable_aer(accel_dev)) {
+		dev_err(&pdev->dev, "Failed to enable aer.\n");
+		ret = -EFAULT;
+		goto out_err;
+	}
+
+	if (pci_save_state(pdev)) {
+		dev_err(&pdev->dev, "Failed to save pci state.\n");
+		ret = -ENOMEM;
+		goto out_err_disable_aer;
+	}
+
+	ret = adf_crypto_dev_config(accel_dev);
+	if (ret)
+		goto out_err_disable_aer;
+
+	ret = adf_dev_init(accel_dev);
+	if (ret)
+		goto out_err_dev_shutdown;
+
+	ret = adf_dev_start(accel_dev);
+	if (ret)
+		goto out_err_dev_stop;
+
+	return ret;
+
+out_err_dev_stop:
+	adf_dev_stop(accel_dev);
+out_err_dev_shutdown:
+	adf_dev_shutdown(accel_dev);
+out_err_disable_aer:
+	adf_disable_aer(accel_dev);
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
+	adf_dev_stop(accel_dev);
+	adf_dev_shutdown(accel_dev);
+	adf_disable_aer(accel_dev);
+	adf_cleanup_accel(accel_dev);
+}
+
+static struct pci_driver adf_driver = {
+	.id_table = adf_pci_tbl,
+	.name = ADF_4XXX_DEVICE_NAME,
+	.probe = adf_probe,
+	.remove = adf_remove,
+	.sriov_configure = adf_sriov_configure,
+};
+
+module_pci_driver(adf_driver);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Intel");
+MODULE_FIRMWARE(ADF_4XXX_FW);
+MODULE_FIRMWARE(ADF_4XXX_MMP);
+MODULE_DESCRIPTION("Intel(R) QuickAssist Technology");
+MODULE_VERSION(ADF_DRV_VERSION);
+MODULE_SOFTDEP("pre: crypto-intel_qat");
diff --git a/drivers/crypto/qat/qat_common/Makefile b/drivers/crypto/qat/qat_common/Makefile
index 25d28516dcdd..9c57abdf56b7 100644
--- a/drivers/crypto/qat/qat_common/Makefile
+++ b/drivers/crypto/qat/qat_common/Makefile
@@ -11,6 +11,7 @@ intel_qat-objs := adf_cfg.o \
 	adf_admin.o \
 	adf_hw_arbiter.o \
 	adf_gen2_hw_data.o \
+	adf_gen4_hw_data.o \
 	qat_crypto.o \
 	qat_algs.o \
 	qat_asym_algs.o \
diff --git a/drivers/crypto/qat/qat_common/adf_accel_devices.h b/drivers/crypto/qat/qat_common/adf_accel_devices.h
index 26164d71f1d6..c46a5805b294 100644
--- a/drivers/crypto/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/qat/qat_common/adf_accel_devices.h
@@ -15,6 +15,7 @@
 #define ADF_C62XVF_DEVICE_NAME "c6xxvf"
 #define ADF_C3XXX_DEVICE_NAME "c3xxx"
 #define ADF_C3XXXVF_DEVICE_NAME "c3xxxvf"
+#define ADF_4XXX_DEVICE_NAME "4xxx"
 #define ADF_4XXX_PCI_DEVICE_ID 0x4940
 #define ADF_4XXXIOV_PCI_DEVICE_ID 0x4941
 #define ADF_ERRSOU3 (0x3A000 + 0x0C)
diff --git a/drivers/crypto/qat/qat_common/adf_cfg_common.h b/drivers/crypto/qat/qat_common/adf_cfg_common.h
index 1ef46ccfba47..4fabb70b1f18 100644
--- a/drivers/crypto/qat/qat_common/adf_cfg_common.h
+++ b/drivers/crypto/qat/qat_common/adf_cfg_common.h
@@ -32,7 +32,8 @@ enum adf_device_type {
 	DEV_C62X,
 	DEV_C62XVF,
 	DEV_C3XXX,
-	DEV_C3XXXVF
+	DEV_C3XXXVF,
+	DEV_4XXX,
 };
 
 struct adf_dev_status_info {
diff --git a/drivers/crypto/qat/qat_common/adf_gen4_hw_data.c b/drivers/crypto/qat/qat_common/adf_gen4_hw_data.c
new file mode 100644
index 000000000000..b72ff58e0bc7
--- /dev/null
+++ b/drivers/crypto/qat/qat_common/adf_gen4_hw_data.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2020 Intel Corporation */
+#include "adf_accel_devices.h"
+#include "adf_gen4_hw_data.h"
+
+static u64 build_csr_ring_base_addr(dma_addr_t addr, u32 size)
+{
+	return BUILD_RING_BASE_ADDR(addr, size);
+}
+
+static u32 read_csr_ring_head(void __iomem *csr_base_addr, u32 bank, u32 ring)
+{
+	return READ_CSR_RING_HEAD(csr_base_addr, bank, ring);
+}
+
+static void write_csr_ring_head(void __iomem *csr_base_addr, u32 bank, u32 ring,
+				u32 value)
+{
+	WRITE_CSR_RING_HEAD(csr_base_addr, bank, ring, value);
+}
+
+static u32 read_csr_ring_tail(void __iomem *csr_base_addr, u32 bank, u32 ring)
+{
+	return READ_CSR_RING_TAIL(csr_base_addr, bank, ring);
+}
+
+static void write_csr_ring_tail(void __iomem *csr_base_addr, u32 bank, u32 ring,
+				u32 value)
+{
+	WRITE_CSR_RING_TAIL(csr_base_addr, bank, ring, value);
+}
+
+static u32 read_csr_e_stat(void __iomem *csr_base_addr, u32 bank)
+{
+	return READ_CSR_E_STAT(csr_base_addr, bank);
+}
+
+static void write_csr_ring_config(void __iomem *csr_base_addr, u32 bank, u32 ring,
+				  u32 value)
+{
+	WRITE_CSR_RING_CONFIG(csr_base_addr, bank, ring, value);
+}
+
+static void write_csr_ring_base(void __iomem *csr_base_addr, u32 bank, u32 ring,
+				dma_addr_t addr)
+{
+	WRITE_CSR_RING_BASE(csr_base_addr, bank, ring, addr);
+}
+
+static void write_csr_int_flag(void __iomem *csr_base_addr, u32 bank,
+			       u32 value)
+{
+	WRITE_CSR_INT_FLAG(csr_base_addr, bank, value);
+}
+
+static void write_csr_int_srcsel(void __iomem *csr_base_addr, u32 bank)
+{
+	WRITE_CSR_INT_SRCSEL(csr_base_addr, bank);
+}
+
+static void write_csr_int_col_en(void __iomem *csr_base_addr, u32 bank, u32 value)
+{
+	WRITE_CSR_INT_COL_EN(csr_base_addr, bank, value);
+}
+
+static void write_csr_int_col_ctl(void __iomem *csr_base_addr, u32 bank,
+				  u32 value)
+{
+	WRITE_CSR_INT_COL_CTL(csr_base_addr, bank, value);
+}
+
+static void write_csr_int_flag_and_col(void __iomem *csr_base_addr, u32 bank,
+				       u32 value)
+{
+	WRITE_CSR_INT_FLAG_AND_COL(csr_base_addr, bank, value);
+}
+
+static void write_csr_ring_srv_arb_en(void __iomem *csr_base_addr, u32 bank,
+				      u32 value)
+{
+	WRITE_CSR_RING_SRV_ARB_EN(csr_base_addr, bank, value);
+}
+
+void adf_gen4_init_hw_csr_ops(struct adf_hw_csr_ops *csr_ops)
+{
+	csr_ops->build_csr_ring_base_addr = build_csr_ring_base_addr;
+	csr_ops->read_csr_ring_head = read_csr_ring_head;
+	csr_ops->write_csr_ring_head = write_csr_ring_head;
+	csr_ops->read_csr_ring_tail = read_csr_ring_tail;
+	csr_ops->write_csr_ring_tail = write_csr_ring_tail;
+	csr_ops->read_csr_e_stat = read_csr_e_stat;
+	csr_ops->write_csr_ring_config = write_csr_ring_config;
+	csr_ops->write_csr_ring_base = write_csr_ring_base;
+	csr_ops->write_csr_int_flag = write_csr_int_flag;
+	csr_ops->write_csr_int_srcsel = write_csr_int_srcsel;
+	csr_ops->write_csr_int_col_en = write_csr_int_col_en;
+	csr_ops->write_csr_int_col_ctl = write_csr_int_col_ctl;
+	csr_ops->write_csr_int_flag_and_col = write_csr_int_flag_and_col;
+	csr_ops->write_csr_ring_srv_arb_en = write_csr_ring_srv_arb_en;
+}
+EXPORT_SYMBOL_GPL(adf_gen4_init_hw_csr_ops);
diff --git a/drivers/crypto/qat/qat_common/adf_gen4_hw_data.h b/drivers/crypto/qat/qat_common/adf_gen4_hw_data.h
new file mode 100644
index 000000000000..8ab62b2ac311
--- /dev/null
+++ b/drivers/crypto/qat/qat_common/adf_gen4_hw_data.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2020 Intel Corporation */
+#ifndef ADF_GEN4_HW_CSR_DATA_H_
+#define ADF_GEN4_HW_CSR_DATA_H_
+
+#include "adf_accel_devices.h"
+
+/* Transport access */
+#define ADF_BANK_INT_SRC_SEL_MASK	0x44UL
+#define ADF_RING_CSR_RING_CONFIG	0x1000
+#define ADF_RING_CSR_RING_LBASE		0x1040
+#define ADF_RING_CSR_RING_UBASE		0x1080
+#define ADF_RING_CSR_RING_HEAD		0x0C0
+#define ADF_RING_CSR_RING_TAIL		0x100
+#define ADF_RING_CSR_E_STAT		0x14C
+#define ADF_RING_CSR_INT_FLAG		0x170
+#define ADF_RING_CSR_INT_SRCSEL		0x174
+#define ADF_RING_CSR_INT_COL_CTL	0x180
+#define ADF_RING_CSR_INT_FLAG_AND_COL	0x184
+#define ADF_RING_CSR_INT_COL_CTL_ENABLE	0x80000000
+#define ADF_RING_CSR_INT_COL_EN		0x17C
+#define ADF_RING_CSR_ADDR_OFFSET	0x100000
+#define ADF_RING_BUNDLE_SIZE		0x2000
+
+#define BUILD_RING_BASE_ADDR(addr, size) \
+	((((addr) >> 6) & (GENMASK_ULL(63, 0) << (size))) << 6)
+#define READ_CSR_RING_HEAD(csr_base_addr, bank, ring) \
+	ADF_CSR_RD((csr_base_addr) + ADF_RING_CSR_ADDR_OFFSET, \
+		   ADF_RING_BUNDLE_SIZE * (bank) + \
+		   ADF_RING_CSR_RING_HEAD + ((ring) << 2))
+#define READ_CSR_RING_TAIL(csr_base_addr, bank, ring) \
+	ADF_CSR_RD((csr_base_addr) + ADF_RING_CSR_ADDR_OFFSET, \
+		   ADF_RING_BUNDLE_SIZE * (bank) + \
+		   ADF_RING_CSR_RING_TAIL + ((ring) << 2))
+#define READ_CSR_E_STAT(csr_base_addr, bank) \
+	ADF_CSR_RD((csr_base_addr) + ADF_RING_CSR_ADDR_OFFSET, \
+		   ADF_RING_BUNDLE_SIZE * (bank) + ADF_RING_CSR_E_STAT)
+#define WRITE_CSR_RING_CONFIG(csr_base_addr, bank, ring, value) \
+	ADF_CSR_WR((csr_base_addr) + ADF_RING_CSR_ADDR_OFFSET, \
+		   ADF_RING_BUNDLE_SIZE * (bank) + \
+		   ADF_RING_CSR_RING_CONFIG + ((ring) << 2), value)
+#define WRITE_CSR_RING_BASE(csr_base_addr, bank, ring, value)	\
+do { \
+	void __iomem *_csr_base_addr = csr_base_addr; \
+	u32 _bank = bank;						\
+	u32 _ring = ring;						\
+	dma_addr_t _value = value;					\
+	u32 l_base = 0, u_base = 0;					\
+	l_base = lower_32_bits(_value);					\
+	u_base = upper_32_bits(_value);					\
+	ADF_CSR_WR((_csr_base_addr) + ADF_RING_CSR_ADDR_OFFSET,		\
+		   ADF_RING_BUNDLE_SIZE * (_bank) +			\
+		   ADF_RING_CSR_RING_LBASE + ((_ring) << 2), l_base);	\
+	ADF_CSR_WR((_csr_base_addr) + ADF_RING_CSR_ADDR_OFFSET,		\
+		   ADF_RING_BUNDLE_SIZE * (_bank) +			\
+		   ADF_RING_CSR_RING_UBASE + ((_ring) << 2), u_base);	\
+} while (0)
+
+#define WRITE_CSR_RING_HEAD(csr_base_addr, bank, ring, value) \
+	ADF_CSR_WR((csr_base_addr) + ADF_RING_CSR_ADDR_OFFSET, \
+		   ADF_RING_BUNDLE_SIZE * (bank) + \
+		   ADF_RING_CSR_RING_HEAD + ((ring) << 2), value)
+#define WRITE_CSR_RING_TAIL(csr_base_addr, bank, ring, value) \
+	ADF_CSR_WR((csr_base_addr) + ADF_RING_CSR_ADDR_OFFSET, \
+		   ADF_RING_BUNDLE_SIZE * (bank) + \
+		   ADF_RING_CSR_RING_TAIL + ((ring) << 2), value)
+#define WRITE_CSR_INT_FLAG(csr_base_addr, bank, value) \
+	ADF_CSR_WR((csr_base_addr) + ADF_RING_CSR_ADDR_OFFSET, \
+		   ADF_RING_BUNDLE_SIZE * (bank) + \
+		   ADF_RING_CSR_INT_FLAG, (value))
+#define WRITE_CSR_INT_SRCSEL(csr_base_addr, bank) \
+	ADF_CSR_WR((csr_base_addr) + ADF_RING_CSR_ADDR_OFFSET, \
+		   ADF_RING_BUNDLE_SIZE * (bank) + \
+		   ADF_RING_CSR_INT_SRCSEL, ADF_BANK_INT_SRC_SEL_MASK)
+#define WRITE_CSR_INT_COL_EN(csr_base_addr, bank, value) \
+	ADF_CSR_WR((csr_base_addr) + ADF_RING_CSR_ADDR_OFFSET, \
+		   ADF_RING_BUNDLE_SIZE * (bank) + \
+		   ADF_RING_CSR_INT_COL_EN, (value))
+#define WRITE_CSR_INT_COL_CTL(csr_base_addr, bank, value) \
+	ADF_CSR_WR((csr_base_addr) + ADF_RING_CSR_ADDR_OFFSET, \
+		   ADF_RING_BUNDLE_SIZE * (bank) + \
+		   ADF_RING_CSR_INT_COL_CTL, \
+		   ADF_RING_CSR_INT_COL_CTL_ENABLE | (value))
+#define WRITE_CSR_INT_FLAG_AND_COL(csr_base_addr, bank, value) \
+	ADF_CSR_WR((csr_base_addr) + ADF_RING_CSR_ADDR_OFFSET, \
+		   ADF_RING_BUNDLE_SIZE * (bank) + \
+		   ADF_RING_CSR_INT_FLAG_AND_COL, (value))
+
+/* Arbiter configuration */
+#define ADF_RING_CSR_RING_SRV_ARB_EN 0x19C
+
+#define WRITE_CSR_RING_SRV_ARB_EN(csr_base_addr, bank, value) \
+	ADF_CSR_WR((csr_base_addr) + ADF_RING_CSR_ADDR_OFFSET, \
+		   ADF_RING_BUNDLE_SIZE * (bank) + \
+		   ADF_RING_CSR_RING_SRV_ARB_EN, (value))
+
+void adf_gen4_init_hw_csr_ops(struct adf_hw_csr_ops *csr_ops);
+
+#endif
-- 
2.28.0


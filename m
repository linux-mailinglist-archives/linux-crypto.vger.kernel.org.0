Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891A028C29A
	for <lists+linux-crypto@lfdr.de>; Mon, 12 Oct 2020 22:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgJLUjO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 12 Oct 2020 16:39:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:33900 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbgJLUjN (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 12 Oct 2020 16:39:13 -0400
IronPort-SDR: U8VTy0s5h2v73vBf4wFCqGsC8+qZQPEFtqveLeMWs8HSWmowoWiNffGAs6Zq4Kn2iXJQL4K/fp
 jUqyycBXs7NQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="165913071"
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="165913071"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 13:39:12 -0700
IronPort-SDR: ADaZ+7+a+qvCMgOKVjMjVY/8t/lb1hpjjJx4JeqPQHzIvENN9UQtP2GbVvyOeUTJIlnyjLMCY9
 l6Qer63VyCng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="299328135"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.51])
  by fmsmga007.fm.intel.com with ESMTP; 12 Oct 2020 13:39:10 -0700
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 05/31] crypto: qat - split transport CSR access logic
Date:   Mon, 12 Oct 2020 21:38:21 +0100
Message-Id: <20201012203847.340030-6-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012203847.340030-1-giovanni.cabiddu@intel.com>
References: <20201012203847.340030-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Abstract access to transport CSRs and move generation specific code into
adf_gen2_hw_data.c in preparation for the introduction of the qat_4xxx
driver.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Fiona Trahe <fiona.trahe@intel.com>
Reviewed-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c  |  1 +
 .../qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c     |  2 +
 .../crypto/qat/qat_c62x/adf_c62x_hw_data.c    |  1 +
 .../qat/qat_c62xvf/adf_c62xvf_hw_data.c       |  2 +
 .../crypto/qat/qat_common/adf_accel_devices.h | 27 ++++++
 .../crypto/qat/qat_common/adf_gen2_hw_data.c  | 85 ++++++++++++++++++
 .../crypto/qat/qat_common/adf_gen2_hw_data.h  |  1 +
 drivers/crypto/qat/qat_common/adf_isr.c       |  4 +-
 drivers/crypto/qat/qat_common/adf_transport.c | 86 +++++++++++++------
 .../qat/qat_common/adf_transport_debug.c      | 22 ++---
 drivers/crypto/qat/qat_common/adf_vf_isr.c    |  5 +-
 .../qat/qat_dh895xcc/adf_dh895xcc_hw_data.c   |  1 +
 .../qat_dh895xccvf/adf_dh895xccvf_hw_data.c   |  2 +
 13 files changed, 198 insertions(+), 41 deletions(-)

diff --git a/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c b/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
index f449b2a0e82d..7af38b947cfe 100644
--- a/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
+++ b/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
@@ -217,6 +217,7 @@ void adf_init_hw_data_c3xxx(struct adf_hw_device_data *hw_data)
 	hw_data->enable_vf2pf_comms = adf_pf_enable_vf2pf_comms;
 	hw_data->reset_device = adf_reset_flr;
 	hw_data->min_iov_compat_ver = ADF_PFVF_COMPATIBILITY_VERSION;
+	adf_gen2_init_hw_csr_ops(&hw_data->csr_ops);
 }
 
 void adf_clean_hw_data_c3xxx(struct adf_hw_device_data *hw_data)
diff --git a/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c b/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c
index 80a355e85a72..15f6b9bdfb22 100644
--- a/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c
+++ b/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c
@@ -3,6 +3,7 @@
 #include <adf_accel_devices.h>
 #include <adf_pf2vf_msg.h>
 #include <adf_common_drv.h>
+#include <adf_gen2_hw_data.h>
 #include "adf_c3xxxvf_hw_data.h"
 
 static struct adf_hw_device_class c3xxxiov_class = {
@@ -98,6 +99,7 @@ void adf_init_hw_data_c3xxxiov(struct adf_hw_device_data *hw_data)
 	hw_data->min_iov_compat_ver = ADF_PFVF_COMPATIBILITY_VERSION;
 	hw_data->dev_class->instances++;
 	adf_devmgr_update_class_index(hw_data);
+	adf_gen2_init_hw_csr_ops(&hw_data->csr_ops);
 }
 
 void adf_clean_hw_data_c3xxxiov(struct adf_hw_device_data *hw_data)
diff --git a/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c b/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
index d7bed610ae86..c18fb77dd8ec 100644
--- a/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
+++ b/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
@@ -227,6 +227,7 @@ void adf_init_hw_data_c62x(struct adf_hw_device_data *hw_data)
 	hw_data->enable_vf2pf_comms = adf_pf_enable_vf2pf_comms;
 	hw_data->reset_device = adf_reset_flr;
 	hw_data->min_iov_compat_ver = ADF_PFVF_COMPATIBILITY_VERSION;
+	adf_gen2_init_hw_csr_ops(&hw_data->csr_ops);
 }
 
 void adf_clean_hw_data_c62x(struct adf_hw_device_data *hw_data)
diff --git a/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c b/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c
index 7725387e58f8..d231583428c9 100644
--- a/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c
+++ b/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c
@@ -3,6 +3,7 @@
 #include <adf_accel_devices.h>
 #include <adf_pf2vf_msg.h>
 #include <adf_common_drv.h>
+#include <adf_gen2_hw_data.h>
 #include "adf_c62xvf_hw_data.h"
 
 static struct adf_hw_device_class c62xiov_class = {
@@ -98,6 +99,7 @@ void adf_init_hw_data_c62xiov(struct adf_hw_device_data *hw_data)
 	hw_data->min_iov_compat_ver = ADF_PFVF_COMPATIBILITY_VERSION;
 	hw_data->dev_class->instances++;
 	adf_devmgr_update_class_index(hw_data);
+	adf_gen2_init_hw_csr_ops(&hw_data->csr_ops);
 }
 
 void adf_clean_hw_data_c62xiov(struct adf_hw_device_data *hw_data)
diff --git a/drivers/crypto/qat/qat_common/adf_accel_devices.h b/drivers/crypto/qat/qat_common/adf_accel_devices.h
index d7a27d15e137..459e22076813 100644
--- a/drivers/crypto/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/qat/qat_common/adf_accel_devices.h
@@ -97,6 +97,31 @@ struct adf_hw_device_class {
 	u32 instances;
 } __packed;
 
+struct adf_hw_csr_ops {
+	u32 (*read_csr_ring_head)(void __iomem *csr_base_addr, u32 bank,
+				  u32 ring);
+	void (*write_csr_ring_head)(void __iomem *csr_base_addr, u32 bank,
+				    u32 ring, u32 value);
+	u32 (*read_csr_ring_tail)(void __iomem *csr_base_addr, u32 bank,
+				  u32 ring);
+	void (*write_csr_ring_tail)(void __iomem *csr_base_addr, u32 bank,
+				    u32 ring, u32 value);
+	u32 (*read_csr_e_stat)(void __iomem *csr_base_addr, u32 bank);
+	void (*write_csr_ring_config)(void __iomem *csr_base_addr, u32 bank,
+				      u32 ring, u32 value);
+	void (*write_csr_ring_base)(void __iomem *csr_base_addr, u32 bank,
+				    u32 ring, dma_addr_t addr);
+	void (*write_csr_int_flag)(void __iomem *csr_base_addr, u32 bank,
+				   u32 value);
+	void (*write_csr_int_srcsel)(void __iomem *csr_base_addr, u32 bank);
+	void (*write_csr_int_col_en)(void __iomem *csr_base_addr, u32 bank,
+				     u32 value);
+	void (*write_csr_int_col_ctl)(void __iomem *csr_base_addr, u32 bank,
+				      u32 value);
+	void (*write_csr_int_flag_and_col)(void __iomem *csr_base_addr,
+					   u32 bank, u32 value);
+};
+
 struct adf_cfg_device_data;
 struct adf_accel_dev;
 struct adf_etr_data;
@@ -130,6 +155,7 @@ struct adf_hw_device_data {
 	void (*enable_ints)(struct adf_accel_dev *accel_dev);
 	int (*enable_vf2pf_comms)(struct adf_accel_dev *accel_dev);
 	void (*reset_device)(struct adf_accel_dev *accel_dev);
+	struct adf_hw_csr_ops csr_ops;
 	const char *fw_name;
 	const char *fw_mmp_name;
 	u32 fuses;
@@ -162,6 +188,7 @@ struct adf_hw_device_data {
 #define GET_NUM_RINGS_PER_BANK(accel_dev) \
 	GET_HW_DATA(accel_dev)->num_rings_per_bank
 #define GET_MAX_ACCELENGINES(accel_dev) (GET_HW_DATA(accel_dev)->num_engines)
+#define GET_CSR_OPS(accel_dev) (&(accel_dev)->hw_device->csr_ops)
 #define accel_to_pci_dev(accel_ptr) accel_ptr->accel_pci_dev.pci_dev
 
 struct adf_admin_comms;
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_hw_data.c b/drivers/crypto/qat/qat_common/adf_gen2_hw_data.c
index 26e345e3d7c3..07a9211bf7f9 100644
--- a/drivers/crypto/qat/qat_common/adf_gen2_hw_data.c
+++ b/drivers/crypto/qat/qat_common/adf_gen2_hw_data.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
 /* Copyright(c) 2020 Intel Corporation */
 #include "adf_gen2_hw_data.h"
+#include "adf_transport_access_macros.h"
 
 void adf_gen2_cfg_iov_thds(struct adf_accel_dev *accel_dev, bool enable,
 			   int num_a_regs, int num_b_regs)
@@ -36,3 +37,87 @@ void adf_gen2_cfg_iov_thds(struct adf_accel_dev *accel_dev, bool enable,
 	}
 }
 EXPORT_SYMBOL_GPL(adf_gen2_cfg_iov_thds);
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
+static void write_csr_ring_config(void __iomem *csr_base_addr, u32 bank,
+				  u32 ring, u32 value)
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
+static void write_csr_int_flag(void __iomem *csr_base_addr, u32 bank, u32 value)
+{
+	WRITE_CSR_INT_FLAG(csr_base_addr, bank, value);
+}
+
+static void write_csr_int_srcsel(void __iomem *csr_base_addr, u32 bank)
+{
+	WRITE_CSR_INT_SRCSEL(csr_base_addr, bank);
+}
+
+static void write_csr_int_col_en(void __iomem *csr_base_addr, u32 bank,
+				 u32 value)
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
+void adf_gen2_init_hw_csr_ops(struct adf_hw_csr_ops *csr_ops)
+{
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
+}
+EXPORT_SYMBOL_GPL(adf_gen2_init_hw_csr_ops);
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_hw_data.h b/drivers/crypto/qat/qat_common/adf_gen2_hw_data.h
index 1d348425d5f4..e6d3919a56a1 100644
--- a/drivers/crypto/qat/qat_common/adf_gen2_hw_data.h
+++ b/drivers/crypto/qat/qat_common/adf_gen2_hw_data.h
@@ -26,5 +26,6 @@
 
 void adf_gen2_cfg_iov_thds(struct adf_accel_dev *accel_dev, bool enable,
 			   int num_a_regs, int num_b_regs);
+void adf_gen2_init_hw_csr_ops(struct adf_hw_csr_ops *csr_ops);
 
 #endif
diff --git a/drivers/crypto/qat/qat_common/adf_isr.c b/drivers/crypto/qat/qat_common/adf_isr.c
index 36136f7db509..5444f0ea0a1d 100644
--- a/drivers/crypto/qat/qat_common/adf_isr.c
+++ b/drivers/crypto/qat/qat_common/adf_isr.c
@@ -50,8 +50,10 @@ static void adf_disable_msix(struct adf_accel_pci *pci_dev_info)
 static irqreturn_t adf_msix_isr_bundle(int irq, void *bank_ptr)
 {
 	struct adf_etr_bank_data *bank = bank_ptr;
+	struct adf_hw_csr_ops *csr_ops = GET_CSR_OPS(bank->accel_dev);
 
-	WRITE_CSR_INT_FLAG_AND_COL(bank->csr_addr, bank->bank_number, 0);
+	csr_ops->write_csr_int_flag_and_col(bank->csr_addr, bank->bank_number,
+					    0);
 	tasklet_hi_schedule(&bank->resp_handler);
 	return IRQ_HANDLED;
 }
diff --git a/drivers/crypto/qat/qat_common/adf_transport.c b/drivers/crypto/qat/qat_common/adf_transport.c
index 24ddaaaa55b1..03fb7812818b 100644
--- a/drivers/crypto/qat/qat_common/adf_transport.c
+++ b/drivers/crypto/qat/qat_common/adf_transport.c
@@ -54,24 +54,32 @@ static void adf_unreserve_ring(struct adf_etr_bank_data *bank, u32 ring)
 
 static void adf_enable_ring_irq(struct adf_etr_bank_data *bank, u32 ring)
 {
+	struct adf_hw_csr_ops *csr_ops = GET_CSR_OPS(bank->accel_dev);
+
 	spin_lock_bh(&bank->lock);
 	bank->irq_mask |= (1 << ring);
 	spin_unlock_bh(&bank->lock);
-	WRITE_CSR_INT_COL_EN(bank->csr_addr, bank->bank_number, bank->irq_mask);
-	WRITE_CSR_INT_COL_CTL(bank->csr_addr, bank->bank_number,
-			      bank->irq_coalesc_timer);
+	csr_ops->write_csr_int_col_en(bank->csr_addr, bank->bank_number,
+				      bank->irq_mask);
+	csr_ops->write_csr_int_col_ctl(bank->csr_addr, bank->bank_number,
+				       bank->irq_coalesc_timer);
 }
 
 static void adf_disable_ring_irq(struct adf_etr_bank_data *bank, u32 ring)
 {
+	struct adf_hw_csr_ops *csr_ops = GET_CSR_OPS(bank->accel_dev);
+
 	spin_lock_bh(&bank->lock);
 	bank->irq_mask &= ~(1 << ring);
 	spin_unlock_bh(&bank->lock);
-	WRITE_CSR_INT_COL_EN(bank->csr_addr, bank->bank_number, bank->irq_mask);
+	csr_ops->write_csr_int_col_en(bank->csr_addr, bank->bank_number,
+				      bank->irq_mask);
 }
 
 int adf_send_message(struct adf_etr_ring_data *ring, u32 *msg)
 {
+	struct adf_hw_csr_ops *csr_ops = GET_CSR_OPS(ring->bank->accel_dev);
+
 	if (atomic_add_return(1, ring->inflights) >
 	    ADF_MAX_INFLIGHTS(ring->ring_size, ring->msg_size)) {
 		atomic_dec(ring->inflights);
@@ -84,14 +92,17 @@ int adf_send_message(struct adf_etr_ring_data *ring, u32 *msg)
 	ring->tail = adf_modulo(ring->tail +
 				ADF_MSG_SIZE_TO_BYTES(ring->msg_size),
 				ADF_RING_SIZE_MODULO(ring->ring_size));
-	WRITE_CSR_RING_TAIL(ring->bank->csr_addr, ring->bank->bank_number,
-			    ring->ring_number, ring->tail);
+	csr_ops->write_csr_ring_tail(ring->bank->csr_addr,
+				     ring->bank->bank_number, ring->ring_number,
+				     ring->tail);
 	spin_unlock_bh(&ring->lock);
+
 	return 0;
 }
 
 static int adf_handle_response(struct adf_etr_ring_data *ring)
 {
+	struct adf_hw_csr_ops *csr_ops = GET_CSR_OPS(ring->bank->accel_dev);
 	u32 msg_counter = 0;
 	u32 *msg = (u32 *)((uintptr_t)ring->base_addr + ring->head);
 
@@ -105,30 +116,36 @@ static int adf_handle_response(struct adf_etr_ring_data *ring)
 		msg_counter++;
 		msg = (u32 *)((uintptr_t)ring->base_addr + ring->head);
 	}
-	if (msg_counter > 0)
-		WRITE_CSR_RING_HEAD(ring->bank->csr_addr,
-				    ring->bank->bank_number,
-				    ring->ring_number, ring->head);
+	if (msg_counter > 0) {
+		csr_ops->write_csr_ring_head(ring->bank->csr_addr,
+					     ring->bank->bank_number,
+					     ring->ring_number, ring->head);
+	}
 	return 0;
 }
 
 static void adf_configure_tx_ring(struct adf_etr_ring_data *ring)
 {
+	struct adf_hw_csr_ops *csr_ops = GET_CSR_OPS(ring->bank->accel_dev);
 	u32 ring_config = BUILD_RING_CONFIG(ring->ring_size);
 
-	WRITE_CSR_RING_CONFIG(ring->bank->csr_addr, ring->bank->bank_number,
-			      ring->ring_number, ring_config);
+	csr_ops->write_csr_ring_config(ring->bank->csr_addr,
+				       ring->bank->bank_number,
+				       ring->ring_number, ring_config);
+
 }
 
 static void adf_configure_rx_ring(struct adf_etr_ring_data *ring)
 {
+	struct adf_hw_csr_ops *csr_ops = GET_CSR_OPS(ring->bank->accel_dev);
 	u32 ring_config =
 			BUILD_RESP_RING_CONFIG(ring->ring_size,
 					       ADF_RING_NEAR_WATERMARK_512,
 					       ADF_RING_NEAR_WATERMARK_0);
 
-	WRITE_CSR_RING_CONFIG(ring->bank->csr_addr, ring->bank->bank_number,
-			      ring->ring_number, ring_config);
+	csr_ops->write_csr_ring_config(ring->bank->csr_addr,
+				       ring->bank->bank_number,
+				       ring->ring_number, ring_config);
 }
 
 static int adf_init_ring(struct adf_etr_ring_data *ring)
@@ -136,6 +153,7 @@ static int adf_init_ring(struct adf_etr_ring_data *ring)
 	struct adf_etr_bank_data *bank = ring->bank;
 	struct adf_accel_dev *accel_dev = bank->accel_dev;
 	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+	struct adf_hw_csr_ops *csr_ops = GET_CSR_OPS(accel_dev);
 	u64 ring_base;
 	u32 ring_size_bytes =
 			ADF_SIZE_TO_RING_SIZE_IN_BYTES(ring->ring_size);
@@ -163,8 +181,9 @@ static int adf_init_ring(struct adf_etr_ring_data *ring)
 		adf_configure_rx_ring(ring);
 
 	ring_base = BUILD_RING_BASE_ADDR(ring->dma_addr, ring->ring_size);
-	WRITE_CSR_RING_BASE(ring->bank->csr_addr, ring->bank->bank_number,
-			    ring->ring_number, ring_base);
+	csr_ops->write_csr_ring_base(ring->bank->csr_addr,
+				     ring->bank->bank_number, ring->ring_number,
+				     ring_base);
 	spin_lock_init(&ring->lock);
 	return 0;
 }
@@ -269,15 +288,17 @@ int adf_create_ring(struct adf_accel_dev *accel_dev, const char *section,
 void adf_remove_ring(struct adf_etr_ring_data *ring)
 {
 	struct adf_etr_bank_data *bank = ring->bank;
+	struct adf_hw_csr_ops *csr_ops = GET_CSR_OPS(bank->accel_dev);
 
 	/* Disable interrupts for the given ring */
 	adf_disable_ring_irq(bank, ring->ring_number);
 
 	/* Clear PCI config space */
-	WRITE_CSR_RING_CONFIG(bank->csr_addr, bank->bank_number,
-			      ring->ring_number, 0);
-	WRITE_CSR_RING_BASE(bank->csr_addr, bank->bank_number,
-			    ring->ring_number, 0);
+
+	csr_ops->write_csr_ring_config(bank->csr_addr, bank->bank_number,
+				       ring->ring_number, 0);
+	csr_ops->write_csr_ring_base(bank->csr_addr, bank->bank_number,
+				     ring->ring_number, 0);
 	adf_ring_debugfs_rm(ring);
 	adf_unreserve_ring(bank, ring->ring_number);
 	/* Disable HW arbitration for the given ring */
@@ -287,11 +308,14 @@ void adf_remove_ring(struct adf_etr_ring_data *ring)
 
 static void adf_ring_response_handler(struct adf_etr_bank_data *bank)
 {
-	u8 num_rings_per_bank = GET_NUM_RINGS_PER_BANK(bank->accel_dev);
+	struct adf_accel_dev *accel_dev = bank->accel_dev;
+	u8 num_rings_per_bank = GET_NUM_RINGS_PER_BANK(accel_dev);
+	struct adf_hw_csr_ops *csr_ops = GET_CSR_OPS(accel_dev);
 	unsigned long empty_rings;
 	int i;
 
-	empty_rings = READ_CSR_E_STAT(bank->csr_addr, bank->bank_number);
+	empty_rings = csr_ops->read_csr_e_stat(bank->csr_addr,
+					       bank->bank_number);
 	empty_rings = ~empty_rings & bank->irq_mask;
 
 	for_each_set_bit(i, &empty_rings, num_rings_per_bank)
@@ -301,11 +325,13 @@ static void adf_ring_response_handler(struct adf_etr_bank_data *bank)
 void adf_response_handler(uintptr_t bank_addr)
 {
 	struct adf_etr_bank_data *bank = (void *)bank_addr;
+	struct adf_hw_csr_ops *csr_ops = GET_CSR_OPS(bank->accel_dev);
 
 	/* Handle all the responses and reenable IRQs */
 	adf_ring_response_handler(bank);
-	WRITE_CSR_INT_FLAG_AND_COL(bank->csr_addr, bank->bank_number,
-				   bank->irq_mask);
+
+	csr_ops->write_csr_int_flag_and_col(bank->csr_addr, bank->bank_number,
+					    bank->irq_mask);
 }
 
 static inline int adf_get_cfg_int(struct adf_accel_dev *accel_dev,
@@ -345,6 +371,7 @@ static int adf_init_bank(struct adf_accel_dev *accel_dev,
 {
 	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
 	u8 num_rings_per_bank = hw_data->num_rings_per_bank;
+	struct adf_hw_csr_ops *csr_ops = &hw_data->csr_ops;
 	struct adf_etr_ring_data *ring;
 	struct adf_etr_ring_data *tx_ring;
 	u32 i, coalesc_enabled = 0;
@@ -375,8 +402,9 @@ static int adf_init_bank(struct adf_accel_dev *accel_dev,
 		bank->irq_coalesc_timer = ADF_COALESCING_MIN_TIME;
 
 	for (i = 0; i < num_rings_per_bank; i++) {
-		WRITE_CSR_RING_CONFIG(csr_addr, bank_num, i, 0);
-		WRITE_CSR_RING_BASE(csr_addr, bank_num, i, 0);
+		csr_ops->write_csr_ring_config(csr_addr, bank_num, i, 0);
+		csr_ops->write_csr_ring_base(csr_addr, bank_num, i, 0);
+
 		ring = &bank->rings[i];
 		if (hw_data->tx_rings_mask & (1 << i)) {
 			ring->inflights =
@@ -401,8 +429,10 @@ static int adf_init_bank(struct adf_accel_dev *accel_dev,
 		goto err;
 	}
 
-	WRITE_CSR_INT_FLAG(csr_addr, bank_num, ADF_BANK_INT_FLAG_CLEAR_MASK);
-	WRITE_CSR_INT_SRCSEL(csr_addr, bank_num);
+	csr_ops->write_csr_int_flag(csr_addr, bank_num,
+				    ADF_BANK_INT_FLAG_CLEAR_MASK);
+	csr_ops->write_csr_int_srcsel(csr_addr, bank_num);
+
 	return 0;
 err:
 	ring_mask = hw_data->tx_rings_mask;
diff --git a/drivers/crypto/qat/qat_common/adf_transport_debug.c b/drivers/crypto/qat/qat_common/adf_transport_debug.c
index da79d734c035..1205186ad51e 100644
--- a/drivers/crypto/qat/qat_common/adf_transport_debug.c
+++ b/drivers/crypto/qat/qat_common/adf_transport_debug.c
@@ -42,16 +42,17 @@ static int adf_ring_show(struct seq_file *sfile, void *v)
 {
 	struct adf_etr_ring_data *ring = sfile->private;
 	struct adf_etr_bank_data *bank = ring->bank;
+	struct adf_hw_csr_ops *csr_ops = GET_CSR_OPS(bank->accel_dev);
 	void __iomem *csr = ring->bank->csr_addr;
 
 	if (v == SEQ_START_TOKEN) {
 		int head, tail, empty;
 
-		head = READ_CSR_RING_HEAD(csr, bank->bank_number,
-					  ring->ring_number);
-		tail = READ_CSR_RING_TAIL(csr, bank->bank_number,
-					  ring->ring_number);
-		empty = READ_CSR_E_STAT(csr, bank->bank_number);
+		head = csr_ops->read_csr_ring_head(csr, bank->bank_number,
+						   ring->ring_number);
+		tail = csr_ops->read_csr_ring_tail(csr, bank->bank_number,
+						   ring->ring_number);
+		empty = csr_ops->read_csr_e_stat(csr, bank->bank_number);
 
 		seq_puts(sfile, "------- Ring configuration -------\n");
 		seq_printf(sfile, "ring name: %s\n",
@@ -144,6 +145,7 @@ static void *adf_bank_next(struct seq_file *sfile, void *v, loff_t *pos)
 static int adf_bank_show(struct seq_file *sfile, void *v)
 {
 	struct adf_etr_bank_data *bank = sfile->private;
+	struct adf_hw_csr_ops *csr_ops = GET_CSR_OPS(bank->accel_dev);
 
 	if (v == SEQ_START_TOKEN) {
 		seq_printf(sfile, "------- Bank %d configuration -------\n",
@@ -157,11 +159,11 @@ static int adf_bank_show(struct seq_file *sfile, void *v)
 		if (!(bank->ring_mask & 1 << ring_id))
 			return 0;
 
-		head = READ_CSR_RING_HEAD(csr, bank->bank_number,
-					  ring->ring_number);
-		tail = READ_CSR_RING_TAIL(csr, bank->bank_number,
-					  ring->ring_number);
-		empty = READ_CSR_E_STAT(csr, bank->bank_number);
+		head = csr_ops->read_csr_ring_head(csr, bank->bank_number,
+						   ring->ring_number);
+		tail = csr_ops->read_csr_ring_tail(csr, bank->bank_number,
+						   ring->ring_number);
+		empty = csr_ops->read_csr_e_stat(csr, bank->bank_number);
 
 		seq_printf(sfile,
 			   "ring num %02d, head %04x, tail %04x, empty: %d\n",
diff --git a/drivers/crypto/qat/qat_common/adf_vf_isr.c b/drivers/crypto/qat/qat_common/adf_vf_isr.c
index c4a44dc6af3e..38d316a42ba6 100644
--- a/drivers/crypto/qat/qat_common/adf_vf_isr.c
+++ b/drivers/crypto/qat/qat_common/adf_vf_isr.c
@@ -156,6 +156,7 @@ static irqreturn_t adf_isr(int irq, void *privdata)
 {
 	struct adf_accel_dev *accel_dev = privdata;
 	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+	struct adf_hw_csr_ops *csr_ops = &hw_data->csr_ops;
 	struct adf_bar *pmisc =
 			&GET_BARS(accel_dev)[hw_data->get_misc_bar_id(hw_data)];
 	void __iomem *pmisc_bar_addr = pmisc->virt_addr;
@@ -180,8 +181,8 @@ static irqreturn_t adf_isr(int irq, void *privdata)
 		struct adf_etr_bank_data *bank = &etr_data->banks[0];
 
 		/* Disable Flag and Coalesce Ring Interrupts */
-		WRITE_CSR_INT_FLAG_AND_COL(bank->csr_addr, bank->bank_number,
-					   0);
+		csr_ops->write_csr_int_flag_and_col(bank->csr_addr,
+						    bank->bank_number, 0);
 		tasklet_hi_schedule(&bank->resp_handler);
 		return IRQ_HANDLED;
 	}
diff --git a/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c b/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
index 7b2f13ff49fd..39423316664b 100644
--- a/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
+++ b/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
@@ -226,6 +226,7 @@ void adf_init_hw_data_dh895xcc(struct adf_hw_device_data *hw_data)
 	hw_data->enable_vf2pf_comms = adf_pf_enable_vf2pf_comms;
 	hw_data->reset_device = adf_reset_sbr;
 	hw_data->min_iov_compat_ver = ADF_PFVF_COMPATIBILITY_VERSION;
+	adf_gen2_init_hw_csr_ops(&hw_data->csr_ops);
 }
 
 void adf_clean_hw_data_dh895xcc(struct adf_hw_device_data *hw_data)
diff --git a/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c b/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c
index eca144bc1d67..f14fb82ed6df 100644
--- a/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c
+++ b/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c
@@ -3,6 +3,7 @@
 #include <adf_accel_devices.h>
 #include <adf_pf2vf_msg.h>
 #include <adf_common_drv.h>
+#include <adf_gen2_hw_data.h>
 #include "adf_dh895xccvf_hw_data.h"
 
 static struct adf_hw_device_class dh895xcciov_class = {
@@ -98,6 +99,7 @@ void adf_init_hw_data_dh895xcciov(struct adf_hw_device_data *hw_data)
 	hw_data->min_iov_compat_ver = ADF_PFVF_COMPATIBILITY_VERSION;
 	hw_data->dev_class->instances++;
 	adf_devmgr_update_class_index(hw_data);
+	adf_gen2_init_hw_csr_ops(&hw_data->csr_ops);
 }
 
 void adf_clean_hw_data_dh895xcciov(struct adf_hw_device_data *hw_data)
-- 
2.26.2


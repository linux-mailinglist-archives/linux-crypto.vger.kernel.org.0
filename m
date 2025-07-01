Return-Path: <linux-crypto+bounces-14447-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18409AEF3B9
	for <lists+linux-crypto@lfdr.de>; Tue,  1 Jul 2025 11:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267744A24A1
	for <lists+linux-crypto@lfdr.de>; Tue,  1 Jul 2025 09:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2E226E6F1;
	Tue,  1 Jul 2025 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cUamu9QN"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585C7221281
	for <linux-crypto@vger.kernel.org>; Tue,  1 Jul 2025 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751363262; cv=none; b=m3919UAH4SQxQDr8jy0/ppHr32UG0ahLoe9Xw9v7cfCjZ4zUGkyC39yd4O2MMEaFRsqnmTdtzq1rVQgQBzv5ey1CJK6tx9TZW2OWf5rKXsTwzSJGrL9oLSstY4q3KTYwCB9Ufru8emnl767NtjzEF2TjlpiFK/6hJfW+fJMIw3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751363262; c=relaxed/simple;
	bh=SFo/HcFmTZB6yai4b4t//AF5PEs+T9gjqUtgrSgXSjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hX0qq1f2k03Gft98RpzhEa5GYHNyoIu/ip8IgZ6K/k550zltUUxm2yjPsqAFNNC+jU/cNiAUDCtG5WfaoL4aqo7XoLGNH0+D9qKgxIc927r8oZxO9Ps24R8uQmKbBb7yiTBWeMVw740DiNFEGwN06p/o/Bq0/2PFnZT0w3dgkII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cUamu9QN; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751363261; x=1782899261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SFo/HcFmTZB6yai4b4t//AF5PEs+T9gjqUtgrSgXSjE=;
  b=cUamu9QNMKMbYgbW3nNua3g/g6+oIC5BUqiY2V6CcEa8XEI5zZKqOeHh
   G/T2zDt2CUn7sATib7pfCAFD3R9FqNUWY+8VOLQ8ULRl0QcFDBIlh4SiD
   d49k2KtM3xNapv7rEA1/zlgiiUQ0pZ7Svnb8oUO2B0HZuPo9HrgaBqC4g
   gbQ7eXkn6hutCNN9ymESb0lCPFwkIlwSNuJAGBsBwH1NR9gROyTbzdtqA
   R5V4JQabDPYqHMb0EQGYNXaw+KK8nuvhp8JqGHQaiDVMWvmJnyOHGF16H
   URrLrg6eygai14ZYauuHrPbQVfMXHcvnDYopOnq8Hp/DsYHxaKA4sTCw4
   g==;
X-CSE-ConnectionGUID: YGBAV7QfQ5SMStdhbIC77Q==
X-CSE-MsgGUID: CrZ6ZYXCRkSNrB0F1wVufA==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53483470"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="53483470"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 02:47:41 -0700
X-CSE-ConnectionGUID: flaTxIK1Q+O/HoxLzSct1A==
X-CSE-MsgGUID: QKG7Tj0KT1GNk8lNYo+jOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="154030071"
Received: from t21-qat.iind.intel.com ([10.49.15.35])
  by fmviesa009.fm.intel.com with ESMTP; 01 Jul 2025 02:47:38 -0700
From: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
To: herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org,
	qat-linux@intel.com
Subject: [PATCH 3/5] crypto: qat - relocate bank state helper functions
Date: Tue,  1 Jul 2025 10:47:28 +0100
Message-Id: <20250701094730.227991-4-suman.kumar.chakraborty@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250701094730.227991-1-suman.kumar.chakraborty@intel.com>
References: <20250701094730.227991-1-suman.kumar.chakraborty@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Małgorzata Mielnik <malgorzata.mielnik@intel.com>

The existing implementation of bank state management functions,
including saving and restoring state, is located within 4xxx device
files. However, these functions do not contain GEN4-specific code and
are applicable to other QAT generations.

Relocate the bank state management functions to a new file,
adf_bank_state.c, and rename them removing the `gen4` prefix. This change
enables the reuse of such functions across different QAT generations.

Add documentation to bank state related functions that were
moved from QAT 4xxx specific files to common files.

This does not introduce any functional change.

Signed-off-by: Małgorzata Mielnik <malgorzata.mielnik@intel.com>
---
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     |   5 +-
 drivers/crypto/intel/qat/qat_common/Makefile  |   1 +
 .../intel/qat/qat_common/adf_bank_state.c     | 238 ++++++++++++++++++
 .../intel/qat/qat_common/adf_bank_state.h     |  16 ++
 .../intel/qat/qat_common/adf_gen4_hw_data.c   | 200 ---------------
 .../intel/qat/qat_common/adf_gen4_hw_data.h   |   7 -
 6 files changed, 258 insertions(+), 209 deletions(-)
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_bank_state.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_bank_state.h

diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
index bd0b1b1015c0..4d4889533558 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -3,6 +3,7 @@
 #include <linux/iopoll.h>
 #include <adf_accel_devices.h>
 #include <adf_admin.h>
+#include <adf_bank_state.h>
 #include <adf_cfg.h>
 #include <adf_cfg_services.h>
 #include <adf_clock.h>
@@ -448,8 +449,8 @@ void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data, u32 dev_id)
 	hw_data->get_ring_to_svc_map = adf_gen4_get_ring_to_svc_map;
 	hw_data->disable_iov = adf_disable_sriov;
 	hw_data->ring_pair_reset = adf_gen4_ring_pair_reset;
-	hw_data->bank_state_save = adf_gen4_bank_state_save;
-	hw_data->bank_state_restore = adf_gen4_bank_state_restore;
+	hw_data->bank_state_save = adf_bank_state_save;
+	hw_data->bank_state_restore = adf_bank_state_restore;
 	hw_data->enable_pm = adf_gen4_enable_pm;
 	hw_data->handle_pm_interrupt = adf_gen4_handle_pm_interrupt;
 	hw_data->dev_config = adf_gen4_dev_config;
diff --git a/drivers/crypto/intel/qat/qat_common/Makefile b/drivers/crypto/intel/qat/qat_common/Makefile
index 66bb295ace28..e426cc3c49c3 100644
--- a/drivers/crypto/intel/qat/qat_common/Makefile
+++ b/drivers/crypto/intel/qat/qat_common/Makefile
@@ -4,6 +4,7 @@ ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE='"CRYPTO_QAT"'
 intel_qat-y := adf_accel_engine.o \
 	adf_admin.o \
 	adf_aer.o \
+	adf_bank_state.o \
 	adf_cfg.o \
 	adf_cfg_services.o \
 	adf_clock.o \
diff --git a/drivers/crypto/intel/qat/qat_common/adf_bank_state.c b/drivers/crypto/intel/qat/qat_common/adf_bank_state.c
new file mode 100644
index 000000000000..2a0bbee8a288
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_bank_state.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2025 Intel Corporation */
+
+#define pr_fmt(fmt)	"QAT: " fmt
+
+#include <linux/bits.h>
+#include <linux/dev_printk.h>
+#include <linux/printk.h>
+#include "adf_accel_devices.h"
+#include "adf_bank_state.h"
+#include "adf_common_drv.h"
+
+/* Ring interrupt masks */
+#define ADF_RP_INT_SRC_SEL_F_RISE_MASK	GENMASK(1, 0)
+#define ADF_RP_INT_SRC_SEL_F_FALL_MASK	GENMASK(2, 0)
+#define ADF_RP_INT_SRC_SEL_RANGE_WIDTH	4
+
+static inline int check_stat(u32 (*op)(void __iomem *, u32), u32 expect_val,
+			     const char *name, void __iomem *base, u32 bank)
+{
+	u32 actual_val = op(base, bank);
+
+	if (expect_val == actual_val)
+		return 0;
+
+	pr_err("Fail to restore %s register. Expected %#x, actual %#x\n",
+	       name, expect_val, actual_val);
+
+	return -EINVAL;
+}
+
+static void bank_state_save(struct adf_hw_csr_ops *ops, void __iomem *base,
+			    u32 bank, struct bank_state *state, u32 num_rings)
+{
+	u32 i;
+
+	state->ringstat0 = ops->read_csr_stat(base, bank);
+	state->ringuostat = ops->read_csr_uo_stat(base, bank);
+	state->ringestat = ops->read_csr_e_stat(base, bank);
+	state->ringnestat = ops->read_csr_ne_stat(base, bank);
+	state->ringnfstat = ops->read_csr_nf_stat(base, bank);
+	state->ringfstat = ops->read_csr_f_stat(base, bank);
+	state->ringcstat0 = ops->read_csr_c_stat(base, bank);
+	state->iaintflagen = ops->read_csr_int_en(base, bank);
+	state->iaintflagreg = ops->read_csr_int_flag(base, bank);
+	state->iaintflagsrcsel0 = ops->read_csr_int_srcsel(base, bank);
+	state->iaintcolen = ops->read_csr_int_col_en(base, bank);
+	state->iaintcolctl = ops->read_csr_int_col_ctl(base, bank);
+	state->iaintflagandcolen = ops->read_csr_int_flag_and_col(base, bank);
+	state->ringexpstat = ops->read_csr_exp_stat(base, bank);
+	state->ringexpintenable = ops->read_csr_exp_int_en(base, bank);
+	state->ringsrvarben = ops->read_csr_ring_srv_arb_en(base, bank);
+
+	for (i = 0; i < num_rings; i++) {
+		state->rings[i].head = ops->read_csr_ring_head(base, bank, i);
+		state->rings[i].tail = ops->read_csr_ring_tail(base, bank, i);
+		state->rings[i].config = ops->read_csr_ring_config(base, bank, i);
+		state->rings[i].base = ops->read_csr_ring_base(base, bank, i);
+	}
+}
+
+static int bank_state_restore(struct adf_hw_csr_ops *ops, void __iomem *base,
+			      u32 bank, struct bank_state *state, u32 num_rings,
+			      int tx_rx_gap)
+{
+	u32 val, tmp_val, i;
+	int ret;
+
+	for (i = 0; i < num_rings; i++)
+		ops->write_csr_ring_base(base, bank, i, state->rings[i].base);
+
+	for (i = 0; i < num_rings; i++)
+		ops->write_csr_ring_config(base, bank, i, state->rings[i].config);
+
+	for (i = 0; i < num_rings / 2; i++) {
+		int tx = i * (tx_rx_gap + 1);
+		int rx = tx + tx_rx_gap;
+
+		ops->write_csr_ring_head(base, bank, tx, state->rings[tx].head);
+		ops->write_csr_ring_tail(base, bank, tx, state->rings[tx].tail);
+
+		/*
+		 * The TX ring head needs to be updated again to make sure that
+		 * the HW will not consider the ring as full when it is empty
+		 * and the correct state flags are set to match the recovered state.
+		 */
+		if (state->ringestat & BIT(tx)) {
+			val = ops->read_csr_int_srcsel(base, bank);
+			val |= ADF_RP_INT_SRC_SEL_F_RISE_MASK;
+			ops->write_csr_int_srcsel_w_val(base, bank, val);
+			ops->write_csr_ring_head(base, bank, tx, state->rings[tx].head);
+		}
+
+		ops->write_csr_ring_tail(base, bank, rx, state->rings[rx].tail);
+		val = ops->read_csr_int_srcsel(base, bank);
+		val |= ADF_RP_INT_SRC_SEL_F_RISE_MASK << ADF_RP_INT_SRC_SEL_RANGE_WIDTH;
+		ops->write_csr_int_srcsel_w_val(base, bank, val);
+
+		ops->write_csr_ring_head(base, bank, rx, state->rings[rx].head);
+		val = ops->read_csr_int_srcsel(base, bank);
+		val |= ADF_RP_INT_SRC_SEL_F_FALL_MASK << ADF_RP_INT_SRC_SEL_RANGE_WIDTH;
+		ops->write_csr_int_srcsel_w_val(base, bank, val);
+
+		/*
+		 * The RX ring tail needs to be updated again to make sure that
+		 * the HW will not consider the ring as empty when it is full
+		 * and the correct state flags are set to match the recovered state.
+		 */
+		if (state->ringfstat & BIT(rx))
+			ops->write_csr_ring_tail(base, bank, rx, state->rings[rx].tail);
+	}
+
+	ops->write_csr_int_flag_and_col(base, bank, state->iaintflagandcolen);
+	ops->write_csr_int_en(base, bank, state->iaintflagen);
+	ops->write_csr_int_col_en(base, bank, state->iaintcolen);
+	ops->write_csr_int_srcsel_w_val(base, bank, state->iaintflagsrcsel0);
+	ops->write_csr_exp_int_en(base, bank, state->ringexpintenable);
+	ops->write_csr_int_col_ctl(base, bank, state->iaintcolctl);
+
+	/*
+	 * Verify whether any exceptions were raised during the bank save process.
+	 * If exceptions occurred, the status and exception registers cannot
+	 * be directly restored. Consequently, further restoration is not
+	 * feasible, and the current state of the ring should be maintained.
+	 */
+	val = state->ringexpstat;
+	if (val) {
+		pr_info("Bank %u state not fully restored due to exception in saved state (%#x)\n",
+			bank, val);
+		return 0;
+	}
+
+	/* Ensure that the restoration process completed without exceptions */
+	tmp_val = ops->read_csr_exp_stat(base, bank);
+	if (tmp_val) {
+		pr_err("Bank %u restored with exception: %#x\n", bank, tmp_val);
+		return -EFAULT;
+	}
+
+	ops->write_csr_ring_srv_arb_en(base, bank, state->ringsrvarben);
+
+	/* Check that all ring statuses match the saved state. */
+	ret = check_stat(ops->read_csr_stat, state->ringstat0, "ringstat",
+			 base, bank);
+	if (ret)
+		return ret;
+
+	ret = check_stat(ops->read_csr_e_stat, state->ringestat, "ringestat",
+			 base, bank);
+	if (ret)
+		return ret;
+
+	ret = check_stat(ops->read_csr_ne_stat, state->ringnestat, "ringnestat",
+			 base, bank);
+	if (ret)
+		return ret;
+
+	ret = check_stat(ops->read_csr_nf_stat, state->ringnfstat, "ringnfstat",
+			 base, bank);
+	if (ret)
+		return ret;
+
+	ret = check_stat(ops->read_csr_f_stat, state->ringfstat, "ringfstat",
+			 base, bank);
+	if (ret)
+		return ret;
+
+	ret = check_stat(ops->read_csr_c_stat, state->ringcstat0, "ringcstat",
+			 base, bank);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * adf_bank_state_save() - save state of bank-related registers
+ * @accel_dev: Pointer to the device structure
+ * @bank_number: Bank number
+ * @state: Pointer to bank state structure
+ *
+ * This function saves the state of a bank by reading the bank CSRs and
+ * writing them in the @state structure.
+ *
+ * Returns 0 on success, error code otherwise
+ */
+int adf_bank_state_save(struct adf_accel_dev *accel_dev, u32 bank_number,
+			struct bank_state *state)
+{
+	struct adf_hw_device_data *hw_data = GET_HW_DATA(accel_dev);
+	struct adf_hw_csr_ops *csr_ops = GET_CSR_OPS(accel_dev);
+	void __iomem *csr_base = adf_get_etr_base(accel_dev);
+
+	if (bank_number >= hw_data->num_banks || !state)
+		return -EINVAL;
+
+	dev_dbg(&GET_DEV(accel_dev), "Saving state of bank %d\n", bank_number);
+
+	bank_state_save(csr_ops, csr_base, bank_number, state,
+			hw_data->num_rings_per_bank);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(adf_bank_state_save);
+
+/**
+ * adf_bank_state_restore() - restore state of bank-related registers
+ * @accel_dev: Pointer to the device structure
+ * @bank_number: Bank number
+ * @state: Pointer to bank state structure
+ *
+ * This function attempts to restore the state of a bank by writing the
+ * bank CSRs to the values in the state structure.
+ *
+ * Returns 0 on success, error code otherwise
+ */
+int adf_bank_state_restore(struct adf_accel_dev *accel_dev, u32 bank_number,
+			   struct bank_state *state)
+{
+	struct adf_hw_device_data *hw_data = GET_HW_DATA(accel_dev);
+	struct adf_hw_csr_ops *csr_ops = GET_CSR_OPS(accel_dev);
+	void __iomem *csr_base = adf_get_etr_base(accel_dev);
+	int ret;
+
+	if (bank_number >= hw_data->num_banks  || !state)
+		return -EINVAL;
+
+	dev_dbg(&GET_DEV(accel_dev), "Restoring state of bank %d\n", bank_number);
+
+	ret = bank_state_restore(csr_ops, csr_base, bank_number, state,
+				 hw_data->num_rings_per_bank, hw_data->tx_rx_gap);
+	if (ret)
+		dev_err(&GET_DEV(accel_dev),
+			"Unable to restore state of bank %d\n", bank_number);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(adf_bank_state_restore);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_bank_state.h b/drivers/crypto/intel/qat/qat_common/adf_bank_state.h
new file mode 100644
index 000000000000..85b15ed161f4
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_bank_state.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2025 Intel Corporation */
+#ifndef ADF_BANK_STATE_H_
+#define ADF_BANK_STATE_H_
+
+#include <linux/types.h>
+
+struct adf_accel_dev;
+struct bank_state;
+
+int adf_bank_state_restore(struct adf_accel_dev *accel_dev, u32 bank_number,
+			   struct bank_state *state);
+int adf_bank_state_save(struct adf_accel_dev *accel_dev, u32 bank_number,
+			struct bank_state *state);
+
+#endif
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
index b5eef5235b61..0dbf9cc2a858 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
@@ -491,206 +491,6 @@ int adf_gen4_bank_drain_start(struct adf_accel_dev *accel_dev,
 	return ret;
 }
 
-static void bank_state_save(struct adf_hw_csr_ops *ops, void __iomem *base,
-			    u32 bank, struct bank_state *state, u32 num_rings)
-{
-	u32 i;
-
-	state->ringstat0 = ops->read_csr_stat(base, bank);
-	state->ringuostat = ops->read_csr_uo_stat(base, bank);
-	state->ringestat = ops->read_csr_e_stat(base, bank);
-	state->ringnestat = ops->read_csr_ne_stat(base, bank);
-	state->ringnfstat = ops->read_csr_nf_stat(base, bank);
-	state->ringfstat = ops->read_csr_f_stat(base, bank);
-	state->ringcstat0 = ops->read_csr_c_stat(base, bank);
-	state->iaintflagen = ops->read_csr_int_en(base, bank);
-	state->iaintflagreg = ops->read_csr_int_flag(base, bank);
-	state->iaintflagsrcsel0 = ops->read_csr_int_srcsel(base, bank);
-	state->iaintcolen = ops->read_csr_int_col_en(base, bank);
-	state->iaintcolctl = ops->read_csr_int_col_ctl(base, bank);
-	state->iaintflagandcolen = ops->read_csr_int_flag_and_col(base, bank);
-	state->ringexpstat = ops->read_csr_exp_stat(base, bank);
-	state->ringexpintenable = ops->read_csr_exp_int_en(base, bank);
-	state->ringsrvarben = ops->read_csr_ring_srv_arb_en(base, bank);
-
-	for (i = 0; i < num_rings; i++) {
-		state->rings[i].head = ops->read_csr_ring_head(base, bank, i);
-		state->rings[i].tail = ops->read_csr_ring_tail(base, bank, i);
-		state->rings[i].config = ops->read_csr_ring_config(base, bank, i);
-		state->rings[i].base = ops->read_csr_ring_base(base, bank, i);
-	}
-}
-
-static inline int check_stat(u32 (*op)(void __iomem *, u32), u32 expect_val,
-			     const char *name, void __iomem *base, u32 bank)
-{
-	u32 actual_val = op(base, bank);
-
-	if (expect_val == actual_val)
-		return 0;
-
-	pr_err("Fail to restore %s register. Expected %#x, actual %#x\n",
-	       name, expect_val, actual_val);
-
-	return -EINVAL;
-}
-
-static int bank_state_restore(struct adf_hw_csr_ops *ops, void __iomem *base,
-			      u32 bank, struct bank_state *state, u32 num_rings,
-			      int tx_rx_gap)
-{
-	u32 val, tmp_val, i;
-	int ret;
-
-	for (i = 0; i < num_rings; i++)
-		ops->write_csr_ring_base(base, bank, i, state->rings[i].base);
-
-	for (i = 0; i < num_rings; i++)
-		ops->write_csr_ring_config(base, bank, i, state->rings[i].config);
-
-	for (i = 0; i < num_rings / 2; i++) {
-		int tx = i * (tx_rx_gap + 1);
-		int rx = tx + tx_rx_gap;
-
-		ops->write_csr_ring_head(base, bank, tx, state->rings[tx].head);
-		ops->write_csr_ring_tail(base, bank, tx, state->rings[tx].tail);
-
-		/*
-		 * The TX ring head needs to be updated again to make sure that
-		 * the HW will not consider the ring as full when it is empty
-		 * and the correct state flags are set to match the recovered state.
-		 */
-		if (state->ringestat & BIT(tx)) {
-			val = ops->read_csr_int_srcsel(base, bank);
-			val |= ADF_RP_INT_SRC_SEL_F_RISE_MASK;
-			ops->write_csr_int_srcsel_w_val(base, bank, val);
-			ops->write_csr_ring_head(base, bank, tx, state->rings[tx].head);
-		}
-
-		ops->write_csr_ring_tail(base, bank, rx, state->rings[rx].tail);
-		val = ops->read_csr_int_srcsel(base, bank);
-		val |= ADF_RP_INT_SRC_SEL_F_RISE_MASK << ADF_RP_INT_SRC_SEL_RANGE_WIDTH;
-		ops->write_csr_int_srcsel_w_val(base, bank, val);
-
-		ops->write_csr_ring_head(base, bank, rx, state->rings[rx].head);
-		val = ops->read_csr_int_srcsel(base, bank);
-		val |= ADF_RP_INT_SRC_SEL_F_FALL_MASK << ADF_RP_INT_SRC_SEL_RANGE_WIDTH;
-		ops->write_csr_int_srcsel_w_val(base, bank, val);
-
-		/*
-		 * The RX ring tail needs to be updated again to make sure that
-		 * the HW will not consider the ring as empty when it is full
-		 * and the correct state flags are set to match the recovered state.
-		 */
-		if (state->ringfstat & BIT(rx))
-			ops->write_csr_ring_tail(base, bank, rx, state->rings[rx].tail);
-	}
-
-	ops->write_csr_int_flag_and_col(base, bank, state->iaintflagandcolen);
-	ops->write_csr_int_en(base, bank, state->iaintflagen);
-	ops->write_csr_int_col_en(base, bank, state->iaintcolen);
-	ops->write_csr_int_srcsel_w_val(base, bank, state->iaintflagsrcsel0);
-	ops->write_csr_exp_int_en(base, bank, state->ringexpintenable);
-	ops->write_csr_int_col_ctl(base, bank, state->iaintcolctl);
-
-	/*
-	 * Verify whether any exceptions were raised during the bank save process.
-	 * If exceptions occurred, the status and exception registers cannot
-	 * be directly restored. Consequently, further restoration is not
-	 * feasible, and the current state of the ring should be maintained.
-	 */
-	val = state->ringexpstat;
-	if (val) {
-		pr_info("Bank %u state not fully restored due to exception in saved state (%#x)\n",
-			bank, val);
-		return 0;
-	}
-
-	/* Ensure that the restoration process completed without exceptions */
-	tmp_val = ops->read_csr_exp_stat(base, bank);
-	if (tmp_val) {
-		pr_err("Bank %u restored with exception: %#x\n", bank, tmp_val);
-		return -EFAULT;
-	}
-
-	ops->write_csr_ring_srv_arb_en(base, bank, state->ringsrvarben);
-
-	/* Check that all ring statuses match the saved state. */
-	ret = check_stat(ops->read_csr_stat, state->ringstat0, "ringstat",
-			 base, bank);
-	if (ret)
-		return ret;
-
-	ret = check_stat(ops->read_csr_e_stat, state->ringestat, "ringestat",
-			 base, bank);
-	if (ret)
-		return ret;
-
-	ret = check_stat(ops->read_csr_ne_stat, state->ringnestat, "ringnestat",
-			 base, bank);
-	if (ret)
-		return ret;
-
-	ret = check_stat(ops->read_csr_nf_stat, state->ringnfstat, "ringnfstat",
-			 base, bank);
-	if (ret)
-		return ret;
-
-	ret = check_stat(ops->read_csr_f_stat, state->ringfstat, "ringfstat",
-			 base, bank);
-	if (ret)
-		return ret;
-
-	ret = check_stat(ops->read_csr_c_stat, state->ringcstat0, "ringcstat",
-			 base, bank);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-int adf_gen4_bank_state_save(struct adf_accel_dev *accel_dev, u32 bank_number,
-			     struct bank_state *state)
-{
-	struct adf_hw_device_data *hw_data = GET_HW_DATA(accel_dev);
-	struct adf_hw_csr_ops *csr_ops = GET_CSR_OPS(accel_dev);
-	void __iomem *csr_base = adf_get_etr_base(accel_dev);
-
-	if (bank_number >= hw_data->num_banks || !state)
-		return -EINVAL;
-
-	dev_dbg(&GET_DEV(accel_dev), "Saving state of bank %d\n", bank_number);
-
-	bank_state_save(csr_ops, csr_base, bank_number, state,
-			hw_data->num_rings_per_bank);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(adf_gen4_bank_state_save);
-
-int adf_gen4_bank_state_restore(struct adf_accel_dev *accel_dev, u32 bank_number,
-				struct bank_state *state)
-{
-	struct adf_hw_device_data *hw_data = GET_HW_DATA(accel_dev);
-	struct adf_hw_csr_ops *csr_ops = GET_CSR_OPS(accel_dev);
-	void __iomem *csr_base = adf_get_etr_base(accel_dev);
-	int ret;
-
-	if (bank_number >= hw_data->num_banks  || !state)
-		return -EINVAL;
-
-	dev_dbg(&GET_DEV(accel_dev), "Restoring state of bank %d\n", bank_number);
-
-	ret = bank_state_restore(csr_ops, csr_base, bank_number, state,
-				 hw_data->num_rings_per_bank, hw_data->tx_rx_gap);
-	if (ret)
-		dev_err(&GET_DEV(accel_dev),
-			"Unable to restore state of bank %d\n", bank_number);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(adf_gen4_bank_state_restore);
-
 static int adf_gen4_build_comp_block(void *ctx, enum adf_dc_algo algo)
 {
 	struct icp_qat_fw_comp_req *req_tmpl = ctx;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
index e4f4d5fa616d..7f2b9cb0fe60 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
@@ -84,9 +84,6 @@
 #define ADF_WQM_CSR_RPRESETSTS(bank)	(ADF_WQM_CSR_RPRESETCTL(bank) + 4)
 
 /* Ring interrupt */
-#define ADF_RP_INT_SRC_SEL_F_RISE_MASK	GENMASK(1, 0)
-#define ADF_RP_INT_SRC_SEL_F_FALL_MASK	GENMASK(2, 0)
-#define ADF_RP_INT_SRC_SEL_RANGE_WIDTH	4
 #define ADF_COALESCED_POLL_TIMEOUT_US	(1 * USEC_PER_SEC)
 #define ADF_COALESCED_POLL_DELAY_US	1000
 #define ADF_WQM_CSR_RPINTSOU(bank)	(0x200000 + ((bank) << 12))
@@ -176,10 +173,6 @@ int adf_gen4_bank_drain_start(struct adf_accel_dev *accel_dev,
 			      u32 bank_number, int timeout_us);
 void adf_gen4_bank_drain_finish(struct adf_accel_dev *accel_dev,
 				u32 bank_number);
-int adf_gen4_bank_state_save(struct adf_accel_dev *accel_dev, u32 bank_number,
-			     struct bank_state *state);
-int adf_gen4_bank_state_restore(struct adf_accel_dev *accel_dev,
-				u32 bank_number, struct bank_state *state);
 bool adf_gen4_services_supported(unsigned long service_mask);
 void adf_gen4_init_dc_ops(struct adf_dc_ops *dc_ops);
 
-- 
2.40.1



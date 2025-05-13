Return-Path: <linux-crypto+bounces-13038-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18543AB52DF
	for <lists+linux-crypto@lfdr.de>; Tue, 13 May 2025 12:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1DF919E3D2A
	for <lists+linux-crypto@lfdr.de>; Tue, 13 May 2025 10:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209B2270571;
	Tue, 13 May 2025 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/hB8jcx"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AF227056C
	for <linux-crypto@vger.kernel.org>; Tue, 13 May 2025 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747131939; cv=none; b=Ih9SDQK/26nH5SosbEqFIVQvc4+O3M8n0gFgv6sYvz7iDMRDQP3ffX5WRcpDYnPOud7Wra8TB3J6zSyPk2vjW6ocrTKubSwxZ95RVZuWst2PsNqTEORvPc+6+a8+eRc51motrku7JeOx8vT9YUYiUrSs+1Xs/Zqc8gmRyaiaH1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747131939; c=relaxed/simple;
	bh=xx98N1os7FzqJoBLQM+1zSJhAdbwSxaiZ1h1yqnRj0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PVfFTfYxdaDnv9ktuW+KjbJj/LxyOcN+61zBzz0ui6L8lIt2oK/72D5V4K98Z2+lArmtJK2BI5Iwzc3aDFqDRthDlEkdkNsbKDD4tMhXKI0Qipmj/+BCdgJjUObcNYYWg+TugJDW7MfHUXVI2iABRVGaFRdxEIet85WxeJLdzEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/hB8jcx; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747131936; x=1778667936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xx98N1os7FzqJoBLQM+1zSJhAdbwSxaiZ1h1yqnRj0g=;
  b=m/hB8jcxYyQiVC9P82tEho6vyNFEhq9C3B5rVFWC4bI9cYrQMrOd15f4
   3+FbXr5lB55gxTWoHuiuk0RoWoZKXK2i6KXzkGrS5/VTBzOzlfNZjoEek
   S5ueZsAjAq4oT0SMaW2uDQm16EoFTxzNF04O8txuzxjU9HURAkW8QoFI2
   hgSOAIywy9MohvnGNXnvLI2pN4xz5I65dP/aaSVrialF5y9lTfuZtWoRJ
   K7MMFQoozJ+zigp01t1/cpKyEXfbV0RHDQOtdayEVNvL6mX06FCKIt7S2
   kyhPtoOVfZpDG/KOeTq4N+iPilzTmr/4gXw24yrfBpYXKhyF/k6bkRIXj
   Q==;
X-CSE-ConnectionGUID: pmDEsPDkQ4+JZmcEOnGnkg==
X-CSE-MsgGUID: mNb1BsnSSWWNkzRuZ1AKig==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="48076414"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="48076414"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 03:25:35 -0700
X-CSE-ConnectionGUID: 6nfdU9LBSrur2NeEPbb7Sw==
X-CSE-MsgGUID: 3+ry/mHbQD+pQ0sWJsQdhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="142786409"
Received: from t21-qat.iind.intel.com ([10.49.15.35])
  by orviesa005.jf.intel.com with ESMTP; 13 May 2025 03:25:34 -0700
From: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
To: herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org,
	qat-linux@intel.com
Subject: [PATCH 1/2] crypto: qat - enable RAS support for GEN6 devices
Date: Tue, 13 May 2025 11:25:26 +0100
Message-Id: <20250513102527.1181096-2-suman.kumar.chakraborty@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250513102527.1181096-1-suman.kumar.chakraborty@intel.com>
References: <20250513102527.1181096-1-suman.kumar.chakraborty@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the reporting and handling of errors for QAT GEN6 devices.

Errors are categorized as correctable, non-fatal, or fatal. Error
handling involves reading the error source registers (ERRSOU0 to ERRSOU3)
to determine the source of the error and then decoding the actual source
reading specific registers.

The action taken depends on the error type:
   - Correctable and Non-Fatal errors. These error are logged, cleared and
     the corresponding counter is incremented.
   - Fatal errors. These errors are logged, cleared and a Function Level
     Reset (FLR) is scheduled.

This reports and handles the following errors:
   - Accelerator engine (AE) correctable errors
   - Accelerator engine (AE) uncorrectable errors
   - Chassis push-pull (CPP) errors
   - Host interface (HI) parity errors
   - Internal memory parity errors
   - Receive interface (RI) errors
   - Transmit interface (TI) errors
   - Interface for system-on-chip (SoC) fabric (IOSF) primary command
     parity errors
   - Shared RAM and slice module (SSM) errors

Signed-off-by: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 .../intel/qat/qat_6xxx/adf_6xxx_hw_data.c     |   2 +
 drivers/crypto/intel/qat/qat_common/Makefile  |   1 +
 .../intel/qat/qat_common/adf_gen6_ras.c       | 818 ++++++++++++++++++
 .../intel/qat/qat_common/adf_gen6_ras.h       | 504 +++++++++++
 4 files changed, 1325 insertions(+)
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen6_ras.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen6_ras.h

diff --git a/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.c b/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.c
index 73d479383b1f..359a6447ccb8 100644
--- a/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.c
@@ -16,6 +16,7 @@
 #include <adf_common_drv.h>
 #include <adf_fw_config.h>
 #include <adf_gen6_pm.h>
+#include <adf_gen6_ras.h>
 #include <adf_gen6_shared.h>
 #include <adf_timer.h>
 #include "adf_6xxx_hw_data.h"
@@ -834,6 +835,7 @@ void adf_init_hw_data_6xxx(struct adf_hw_device_data *hw_data)
 	adf_gen6_init_hw_csr_ops(&hw_data->csr_ops);
 	adf_gen6_init_pf_pfvf_ops(&hw_data->pfvf_ops);
 	adf_gen6_init_dc_ops(&hw_data->dc_ops);
+	adf_gen6_init_ras_ops(&hw_data->ras_ops);
 }
 
 void adf_clean_hw_data_6xxx(struct adf_hw_device_data *hw_data)
diff --git a/drivers/crypto/intel/qat/qat_common/Makefile b/drivers/crypto/intel/qat/qat_common/Makefile
index 958f9a8ac6b3..66bb295ace28 100644
--- a/drivers/crypto/intel/qat/qat_common/Makefile
+++ b/drivers/crypto/intel/qat/qat_common/Makefile
@@ -19,6 +19,7 @@ intel_qat-y := adf_accel_engine.o \
 	adf_gen4_pm.o \
 	adf_gen4_ras.o \
 	adf_gen4_vf_mig.o \
+	adf_gen6_ras.o \
 	adf_gen6_shared.o \
 	adf_hw_arbiter.o \
 	adf_init.o \
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen6_ras.c b/drivers/crypto/intel/qat/qat_common/adf_gen6_ras.c
new file mode 100644
index 000000000000..967253082a98
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen6_ras.c
@@ -0,0 +1,818 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2025 Intel Corporation */
+#include <linux/bitfield.h>
+#include <linux/types.h>
+
+#include "adf_common_drv.h"
+#include "adf_gen6_ras.h"
+#include "adf_sysfs_ras_counters.h"
+
+static void enable_errsou_reporting(void __iomem *csr)
+{
+	/* Enable correctable error reporting in ERRSOU0 */
+	ADF_CSR_WR(csr, ADF_GEN6_ERRMSK0, 0);
+
+	/* Enable uncorrectable error reporting in ERRSOU1 */
+	ADF_CSR_WR(csr, ADF_GEN6_ERRMSK1, 0);
+
+	/*
+	 * Enable uncorrectable error reporting in ERRSOU2
+	 * but disable PM interrupt by default
+	 */
+	ADF_CSR_WR(csr, ADF_GEN6_ERRMSK2, ADF_GEN6_ERRSOU2_PM_INT_BIT);
+
+	/* Enable uncorrectable error reporting in ERRSOU3 */
+	ADF_CSR_WR(csr, ADF_GEN6_ERRMSK3, 0);
+}
+
+static void enable_ae_error_reporting(struct adf_accel_dev *accel_dev, void __iomem *csr)
+{
+	u32 ae_mask = GET_HW_DATA(accel_dev)->ae_mask;
+
+	/* Enable acceleration engine correctable error reporting */
+	ADF_CSR_WR(csr, ADF_GEN6_HIAECORERRLOGENABLE_CPP0, ae_mask);
+
+	/* Enable acceleration engine uncorrectable error reporting */
+	ADF_CSR_WR(csr, ADF_GEN6_HIAEUNCERRLOGENABLE_CPP0, ae_mask);
+}
+
+static void enable_cpp_error_reporting(struct adf_accel_dev *accel_dev, void __iomem *csr)
+{
+	/* Enable HI CPP agents command parity error reporting */
+	ADF_CSR_WR(csr, ADF_GEN6_HICPPAGENTCMDPARERRLOGENABLE,
+		   ADF_6XXX_HICPPAGENTCMDPARERRLOG_MASK);
+
+	ADF_CSR_WR(csr, ADF_GEN6_CPP_CFC_ERR_CTRL, ADF_GEN6_CPP_CFC_ERR_CTRL_MASK);
+}
+
+static void enable_ti_ri_error_reporting(void __iomem *csr)
+{
+	u32 reg, mask;
+
+	/* Enable RI memory error reporting */
+	mask = ADF_GEN6_RIMEM_PARERR_FATAL_MASK | ADF_GEN6_RIMEM_PARERR_CERR_MASK;
+	ADF_CSR_WR(csr, ADF_GEN6_RI_MEM_PAR_ERR_EN0, mask);
+
+	/* Enable IOSF primary command parity error reporting */
+	ADF_CSR_WR(csr, ADF_GEN6_RIMISCCTL, ADF_GEN6_RIMISCSTS_BIT);
+
+	/* Enable TI internal memory parity error reporting */
+	reg = ADF_CSR_RD(csr, ADF_GEN6_TI_CI_PAR_ERR_MASK);
+	reg &= ~ADF_GEN6_TI_CI_PAR_STS_MASK;
+	ADF_CSR_WR(csr, ADF_GEN6_TI_CI_PAR_ERR_MASK, reg);
+
+	reg = ADF_CSR_RD(csr, ADF_GEN6_TI_PULL0FUB_PAR_ERR_MASK);
+	reg &= ~ADF_GEN6_TI_PULL0FUB_PAR_STS_MASK;
+	ADF_CSR_WR(csr, ADF_GEN6_TI_PULL0FUB_PAR_ERR_MASK, reg);
+
+	reg = ADF_CSR_RD(csr, ADF_GEN6_TI_PUSHFUB_PAR_ERR_MASK);
+	reg &= ~ADF_GEN6_TI_PUSHFUB_PAR_STS_MASK;
+	ADF_CSR_WR(csr, ADF_GEN6_TI_PUSHFUB_PAR_ERR_MASK, reg);
+
+	reg = ADF_CSR_RD(csr, ADF_GEN6_TI_CD_PAR_ERR_MASK);
+	reg &= ~ADF_GEN6_TI_CD_PAR_STS_MASK;
+	ADF_CSR_WR(csr, ADF_GEN6_TI_CD_PAR_ERR_MASK, reg);
+
+	reg = ADF_CSR_RD(csr, ADF_GEN6_TI_TRNSB_PAR_ERR_MASK);
+	reg &= ~ADF_GEN6_TI_TRNSB_PAR_STS_MASK;
+	ADF_CSR_WR(csr, ADF_GEN6_TI_TRNSB_PAR_ERR_MASK, reg);
+
+	/* Enable error handling in RI, TI CPP interface control registers */
+	ADF_CSR_WR(csr, ADF_GEN6_RICPPINTCTL, ADF_GEN6_RICPPINTCTL_MASK);
+	ADF_CSR_WR(csr, ADF_GEN6_TICPPINTCTL, ADF_GEN6_TICPPINTCTL_MASK);
+
+	/*
+	 * Enable error detection and reporting in TIMISCSTS
+	 * with bits 1, 2 and 30 value preserved
+	 */
+	reg = ADF_CSR_RD(csr, ADF_GEN6_TIMISCCTL);
+	reg &= ADF_GEN6_TIMSCCTL_RELAY_MASK;
+	reg |= ADF_GEN6_TIMISCCTL_BIT;
+	ADF_CSR_WR(csr, ADF_GEN6_TIMISCCTL, reg);
+}
+
+static void enable_ssm_error_reporting(struct adf_accel_dev *accel_dev,
+				       void __iomem *csr)
+{
+	/* Enable SSM interrupts */
+	ADF_CSR_WR(csr, ADF_GEN6_INTMASKSSM, 0);
+}
+
+static void adf_gen6_enable_ras(struct adf_accel_dev *accel_dev)
+{
+	void __iomem *csr = adf_get_pmisc_base(accel_dev);
+
+	enable_errsou_reporting(csr);
+	enable_ae_error_reporting(accel_dev, csr);
+	enable_cpp_error_reporting(accel_dev, csr);
+	enable_ti_ri_error_reporting(csr);
+	enable_ssm_error_reporting(accel_dev, csr);
+}
+
+static void disable_errsou_reporting(void __iomem *csr)
+{
+	u32 val;
+
+	/* Disable correctable error reporting in ERRSOU0 */
+	ADF_CSR_WR(csr, ADF_GEN6_ERRMSK0, ADF_GEN6_ERRSOU0_MASK);
+
+	/* Disable uncorrectable error reporting in ERRSOU1 */
+	ADF_CSR_WR(csr, ADF_GEN6_ERRMSK1, ADF_GEN6_ERRMSK1_MASK);
+
+	/* Disable uncorrectable error reporting in ERRSOU2 */
+	val = ADF_CSR_RD(csr, ADF_GEN6_ERRMSK2);
+	val |= ADF_GEN6_ERRSOU2_DIS_MASK;
+	ADF_CSR_WR(csr, ADF_GEN6_ERRMSK2, val);
+
+	/* Disable uncorrectable error reporting in ERRSOU3 */
+	ADF_CSR_WR(csr, ADF_GEN6_ERRMSK3, ADF_GEN6_ERRSOU3_DIS_MASK);
+}
+
+static void disable_ae_error_reporting(void __iomem *csr)
+{
+	/* Disable acceleration engine correctable error reporting */
+	ADF_CSR_WR(csr, ADF_GEN6_HIAECORERRLOGENABLE_CPP0, 0);
+
+	/* Disable acceleration engine uncorrectable error reporting */
+	ADF_CSR_WR(csr, ADF_GEN6_HIAEUNCERRLOGENABLE_CPP0, 0);
+}
+
+static void disable_cpp_error_reporting(void __iomem *csr)
+{
+	/* Disable HI CPP agents command parity error reporting */
+	ADF_CSR_WR(csr, ADF_GEN6_HICPPAGENTCMDPARERRLOGENABLE, 0);
+
+	ADF_CSR_WR(csr, ADF_GEN6_CPP_CFC_ERR_CTRL, ADF_GEN6_CPP_CFC_ERR_CTRL_DIS_MASK);
+}
+
+static void disable_ti_ri_error_reporting(void __iomem *csr)
+{
+	u32 reg;
+
+	/* Disable RI memory error reporting */
+	ADF_CSR_WR(csr, ADF_GEN6_RI_MEM_PAR_ERR_EN0, 0);
+
+	/* Disable IOSF primary command parity error reporting */
+	reg = ADF_CSR_RD(csr, ADF_GEN6_RIMISCCTL);
+	reg &= ~ADF_GEN6_RIMISCSTS_BIT;
+	ADF_CSR_WR(csr, ADF_GEN6_RIMISCCTL, reg);
+
+	/* Disable TI internal memory parity error reporting */
+	ADF_CSR_WR(csr, ADF_GEN6_TI_CI_PAR_ERR_MASK, ADF_GEN6_TI_CI_PAR_STS_MASK);
+	ADF_CSR_WR(csr, ADF_GEN6_TI_PULL0FUB_PAR_ERR_MASK, ADF_GEN6_TI_PULL0FUB_PAR_STS_MASK);
+	ADF_CSR_WR(csr, ADF_GEN6_TI_PUSHFUB_PAR_ERR_MASK, ADF_GEN6_TI_PUSHFUB_PAR_STS_MASK);
+	ADF_CSR_WR(csr, ADF_GEN6_TI_CD_PAR_ERR_MASK, ADF_GEN6_TI_CD_PAR_STS_MASK);
+	ADF_CSR_WR(csr, ADF_GEN6_TI_TRNSB_PAR_ERR_MASK, ADF_GEN6_TI_TRNSB_PAR_STS_MASK);
+
+	/* Disable error handling in RI, TI CPP interface control registers */
+	reg = ADF_CSR_RD(csr, ADF_GEN6_RICPPINTCTL);
+	reg &= ~ADF_GEN6_RICPPINTCTL_MASK;
+	ADF_CSR_WR(csr, ADF_GEN6_RICPPINTCTL, reg);
+
+	reg = ADF_CSR_RD(csr, ADF_GEN6_TICPPINTCTL);
+	reg &= ~ADF_GEN6_TICPPINTCTL_MASK;
+	ADF_CSR_WR(csr, ADF_GEN6_TICPPINTCTL, reg);
+
+	/*
+	 * Disable error detection and reporting in TIMISCSTS
+	 * with bits 1, 2 and 30 value preserved
+	 */
+	reg = ADF_CSR_RD(csr, ADF_GEN6_TIMISCCTL);
+	reg &= ADF_GEN6_TIMSCCTL_RELAY_MASK;
+	ADF_CSR_WR(csr, ADF_GEN6_TIMISCCTL, reg);
+}
+
+static void disable_ssm_error_reporting(void __iomem *csr)
+{
+	/* Disable SSM interrupts */
+	ADF_CSR_WR(csr, ADF_GEN6_INTMASKSSM, ADF_GEN6_INTMASKSSM_MASK);
+}
+
+static void adf_gen6_disable_ras(struct adf_accel_dev *accel_dev)
+{
+	void __iomem *csr = adf_get_pmisc_base(accel_dev);
+
+	disable_errsou_reporting(csr);
+	disable_ae_error_reporting(csr);
+	disable_cpp_error_reporting(csr);
+	disable_ti_ri_error_reporting(csr);
+	disable_ssm_error_reporting(csr);
+}
+
+static void adf_gen6_process_errsou0(struct adf_accel_dev *accel_dev, void __iomem *csr)
+{
+	u32 ae, errsou;
+
+	ae = ADF_CSR_RD(csr, ADF_GEN6_HIAECORERRLOG_CPP0);
+	ae &= GET_HW_DATA(accel_dev)->ae_mask;
+
+	dev_warn(&GET_DEV(accel_dev), "Correctable error detected: %#x\n", ae);
+
+	ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_CORR);
+
+	/* Clear interrupt from ERRSOU0 */
+	ADF_CSR_WR(csr, ADF_GEN6_HIAECORERRLOG_CPP0, ae);
+
+	errsou = ADF_CSR_RD(csr, ADF_GEN6_ERRSOU0);
+	if (errsou & ADF_GEN6_ERRSOU0_MASK)
+		dev_warn(&GET_DEV(accel_dev), "errsou0 still set: %#x\n", errsou);
+}
+
+static void adf_handle_cpp_ae_unc(struct adf_accel_dev *accel_dev, void __iomem *csr,
+				  u32 errsou)
+{
+	u32 ae;
+
+	if (!(errsou & ADF_GEN6_ERRSOU1_CPP0_MEUNC_BIT))
+		return;
+
+	ae = ADF_CSR_RD(csr, ADF_GEN6_HIAEUNCERRLOG_CPP0);
+	ae &= GET_HW_DATA(accel_dev)->ae_mask;
+	if (ae) {
+		dev_err(&GET_DEV(accel_dev), "Uncorrectable error detected: %#x\n", ae);
+		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_UNCORR);
+		ADF_CSR_WR(csr, ADF_GEN6_HIAEUNCERRLOG_CPP0, ae);
+	}
+}
+
+static void adf_handle_cpp_cmd_par_err(struct adf_accel_dev *accel_dev, void __iomem *csr,
+				       u32 errsou)
+{
+	u32 cmd_par_err;
+
+	if (!(errsou & ADF_GEN6_ERRSOU1_CPP_CMDPARERR_BIT))
+		return;
+
+	cmd_par_err = ADF_CSR_RD(csr, ADF_GEN6_HICPPAGENTCMDPARERRLOG);
+	cmd_par_err &= ADF_6XXX_HICPPAGENTCMDPARERRLOG_MASK;
+	if (cmd_par_err) {
+		dev_err(&GET_DEV(accel_dev), "HI CPP agent command parity error: %#x\n",
+			cmd_par_err);
+		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_FATAL);
+		ADF_CSR_WR(csr, ADF_GEN6_HICPPAGENTCMDPARERRLOG, cmd_par_err);
+	}
+}
+
+static void adf_handle_ri_mem_par_err(struct adf_accel_dev *accel_dev, void __iomem *csr,
+				      u32 errsou)
+{
+	u32 rimem_parerr_sts;
+
+	if (!(errsou & ADF_GEN6_ERRSOU1_RIMEM_PARERR_STS_BIT))
+		return;
+
+	rimem_parerr_sts = ADF_CSR_RD(csr, ADF_GEN6_RIMEM_PARERR_STS);
+	rimem_parerr_sts &= ADF_GEN6_RIMEM_PARERR_CERR_MASK |
+			    ADF_GEN6_RIMEM_PARERR_FATAL_MASK;
+	if (rimem_parerr_sts & ADF_GEN6_RIMEM_PARERR_CERR_MASK) {
+		dev_err(&GET_DEV(accel_dev), "RI memory parity correctable error: %#x\n",
+			rimem_parerr_sts);
+		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_CORR);
+	}
+
+	if (rimem_parerr_sts & ADF_GEN6_RIMEM_PARERR_FATAL_MASK) {
+		dev_err(&GET_DEV(accel_dev), "RI memory parity fatal error: %#x\n",
+			rimem_parerr_sts);
+		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_FATAL);
+	}
+
+	ADF_CSR_WR(csr, ADF_GEN6_RIMEM_PARERR_STS, rimem_parerr_sts);
+}
+
+static void adf_handle_ti_ci_par_sts(struct adf_accel_dev *accel_dev, void __iomem *csr)
+{
+	u32 ti_ci_par_sts;
+
+	ti_ci_par_sts = ADF_CSR_RD(csr, ADF_GEN6_TI_CI_PAR_STS);
+	ti_ci_par_sts &= ADF_GEN6_TI_CI_PAR_STS_MASK;
+	if (ti_ci_par_sts) {
+		dev_err(&GET_DEV(accel_dev), "TI memory parity error: %#x\n", ti_ci_par_sts);
+		ADF_CSR_WR(csr, ADF_GEN6_TI_CI_PAR_STS, ti_ci_par_sts);
+		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_UNCORR);
+	}
+}
+
+static void adf_handle_ti_pullfub_par_sts(struct adf_accel_dev *accel_dev, void __iomem *csr)
+{
+	u32 ti_pullfub_par_sts;
+
+	ti_pullfub_par_sts = ADF_CSR_RD(csr, ADF_GEN6_TI_PULL0FUB_PAR_STS);
+	ti_pullfub_par_sts &= ADF_GEN6_TI_PULL0FUB_PAR_STS_MASK;
+	if (ti_pullfub_par_sts) {
+		dev_err(&GET_DEV(accel_dev), "TI pull parity error: %#x\n", ti_pullfub_par_sts);
+		ADF_CSR_WR(csr, ADF_GEN6_TI_PULL0FUB_PAR_STS, ti_pullfub_par_sts);
+		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_UNCORR);
+	}
+}
+
+static void adf_handle_ti_pushfub_par_sts(struct adf_accel_dev *accel_dev, void __iomem *csr)
+{
+	u32 ti_pushfub_par_sts;
+
+	ti_pushfub_par_sts = ADF_CSR_RD(csr, ADF_GEN6_TI_PUSHFUB_PAR_STS);
+	ti_pushfub_par_sts &= ADF_GEN6_TI_PUSHFUB_PAR_STS_MASK;
+	if (ti_pushfub_par_sts) {
+		dev_err(&GET_DEV(accel_dev), "TI push parity error: %#x\n", ti_pushfub_par_sts);
+		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_UNCORR);
+		ADF_CSR_WR(csr, ADF_GEN6_TI_PUSHFUB_PAR_STS, ti_pushfub_par_sts);
+	}
+}
+
+static void adf_handle_ti_cd_par_sts(struct adf_accel_dev *accel_dev, void __iomem *csr)
+{
+	u32 ti_cd_par_sts;
+
+	ti_cd_par_sts = ADF_CSR_RD(csr, ADF_GEN6_TI_CD_PAR_STS);
+	ti_cd_par_sts &= ADF_GEN6_TI_CD_PAR_STS_MASK;
+	if (ti_cd_par_sts) {
+		dev_err(&GET_DEV(accel_dev), "TI CD parity error: %#x\n", ti_cd_par_sts);
+		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_UNCORR);
+		ADF_CSR_WR(csr, ADF_GEN6_TI_CD_PAR_STS, ti_cd_par_sts);
+	}
+}
+
+static void adf_handle_ti_trnsb_par_sts(struct adf_accel_dev *accel_dev, void __iomem *csr)
+{
+	u32 ti_trnsb_par_sts;
+
+	ti_trnsb_par_sts = ADF_CSR_RD(csr, ADF_GEN6_TI_TRNSB_PAR_STS);
+	ti_trnsb_par_sts &= ADF_GEN6_TI_TRNSB_PAR_STS_MASK;
+	if (ti_trnsb_par_sts) {
+		dev_err(&GET_DEV(accel_dev), "TI TRNSB parity error: %#x\n", ti_trnsb_par_sts);
+		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_UNCORR);
+		ADF_CSR_WR(csr, ADF_GEN6_TI_TRNSB_PAR_STS, ti_trnsb_par_sts);
+	}
+}
+
+static void adf_handle_iosfp_cmd_parerr(struct adf_accel_dev *accel_dev, void __iomem *csr)
+{
+	u32 rimiscsts;
+
+	rimiscsts = ADF_CSR_RD(csr, ADF_GEN6_RIMISCSTS);
+	rimiscsts &= ADF_GEN6_RIMISCSTS_BIT;
+	if (rimiscsts) {
+		dev_err(&GET_DEV(accel_dev), "Command parity error detected on IOSFP: %#x\n",
+			rimiscsts);
+		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_FATAL);
+		ADF_CSR_WR(csr, ADF_GEN6_RIMISCSTS, rimiscsts);
+	}
+}
+
+static void adf_handle_ti_err(struct adf_accel_dev *accel_dev, void __iomem *csr,
+			      u32 errsou)
+{
+	if (!(errsou & ADF_GEN6_ERRSOU1_TIMEM_PARERR_STS_BIT))
+		return;
+
+	adf_handle_ti_ci_par_sts(accel_dev, csr);
+	adf_handle_ti_pullfub_par_sts(accel_dev, csr);
+	adf_handle_ti_pushfub_par_sts(accel_dev, csr);
+	adf_handle_ti_cd_par_sts(accel_dev, csr);
+	adf_handle_ti_trnsb_par_sts(accel_dev, csr);
+	adf_handle_iosfp_cmd_parerr(accel_dev, csr);
+}
+
+static void adf_handle_sfi_cmd_parerr(struct adf_accel_dev *accel_dev, void __iomem *csr,
+				      u32 errsou)
+{
+	if (!(errsou & ADF_GEN6_ERRSOU1_SFICMD_PARERR_BIT))
+		return;
+
+	dev_err(&GET_DEV(accel_dev),
+		"Command parity error detected on streaming fabric interface\n");
+
+	ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_FATAL);
+}
+
+static void adf_gen6_process_errsou1(struct adf_accel_dev *accel_dev, void __iomem *csr,
+				     u32 errsou)
+{
+	adf_handle_cpp_ae_unc(accel_dev, csr, errsou);
+	adf_handle_cpp_cmd_par_err(accel_dev, csr, errsou);
+	adf_handle_ri_mem_par_err(accel_dev, csr, errsou);
+	adf_handle_ti_err(accel_dev, csr, errsou);
+	adf_handle_sfi_cmd_parerr(accel_dev, csr, errsou);
+
+	errsou = ADF_CSR_RD(csr, ADF_GEN6_ERRSOU1);
+	if (errsou & ADF_GEN6_ERRSOU1_MASK)
+		dev_warn(&GET_DEV(accel_dev), "errsou1 still set: %#x\n", errsou);
+}
+
+static void adf_handle_cerrssmsh(struct adf_accel_dev *accel_dev, void __iomem *csr)
+{
+	u32 reg;
+
+	reg = ADF_CSR_RD(csr, ADF_GEN6_CERRSSMSH);
+	reg &= ADF_GEN6_CERRSSMSH_ERROR_BIT;
+	if (reg) {
+		dev_warn(&GET_DEV(accel_dev),
+			 "Correctable error on ssm shared memory: %#x\n", reg);
+		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_CORR);
+		ADF_CSR_WR(csr, ADF_GEN6_CERRSSMSH, reg);
+	}
+}
+
+static void adf_handle_uerrssmsh(struct adf_accel_dev *accel_dev, void __iomem *csr,
+				 u32 iastatssm)
+{
+	u32 reg;
+
+	if (!(iastatssm & ADF_GEN6_IAINTSTATSSM_SH_ERR_BIT))
+		return;
+
+	reg = ADF_CSR_RD(csr, ADF_GEN6_UERRSSMSH);
+	reg &= ADF_GEN6_UERRSSMSH_MASK;
+	if (reg) {
+		dev_err(&GET_DEV(accel_dev),
+			"Fatal error on ssm shared memory: %#x\n", reg);
+		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_FATAL);
+		ADF_CSR_WR(csr, ADF_GEN6_UERRSSMSH, reg);
+	}
+}
+
+static void adf_handle_pperr_err(struct adf_accel_dev *accel_dev, void __iomem *csr,
+				 u32 iastatssm)
+{
+	u32 reg;
+
+	if (!(iastatssm & ADF_GEN6_IAINTSTATSSM_PPERR_BIT))
+		return;
+
+	reg = ADF_CSR_RD(csr, ADF_GEN6_PPERR);
+	reg &= ADF_GEN6_PPERR_MASK;
+	if (reg) {
+		dev_err(&GET_DEV(accel_dev),
+			"Fatal push or pull data error: %#x\n", reg);
+		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_FATAL);
+		ADF_CSR_WR(csr, ADF_GEN6_PPERR, reg);
+	}
+}
+
+static void adf_handle_scmpar_err(struct adf_accel_dev *accel_dev, void __iomem *csr,
+				  u32 iastatssm)
+{
+	u32 reg;
+
+	if (!(iastatssm & ADF_GEN6_IAINTSTATSSM_SCMPAR_ERR_BIT))
+		return;
+
+	reg = ADF_CSR_RD(csr, ADF_GEN6_SSM_FERR_STATUS);
+	reg &= ADF_GEN6_SCM_PAR_ERR_MASK;
+	if (reg) {
+		dev_err(&GET_DEV(accel_dev), "Fatal error on SCM: %#x\n", reg);
+		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_FATAL);
+		ADF_CSR_WR(csr, ADF_GEN6_SSM_FERR_STATUS, reg);
+	}
+}
+
+static void adf_handle_cpppar_err(struct adf_accel_dev *accel_dev, void __iomem *csr,
+				  u32 iastatssm)
+{
+	u32 reg;
+
+	if (!(iastatssm & ADF_GEN6_IAINTSTATSSM_CPPPAR_ERR_BIT))
+		return;
+
+	reg = ADF_CSR_RD(csr, ADF_GEN6_SSM_FERR_STATUS);
+	reg &= ADF_GEN6_CPP_PAR_ERR_MASK;
+	if (reg) {
+		dev_err(&GET_DEV(accel_dev), "Fatal error on CPP: %#x\n", reg);
+		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_FATAL);
+		ADF_CSR_WR(csr, ADF_GEN6_SSM_FERR_STATUS, reg);
+	}
+}
+
+static void adf_handle_rfpar_err(struct adf_accel_dev *accel_dev, void __iomem *csr,
+				 u32 iastatssm)
+{
+	u32 reg;
+
+	if (!(iastatssm & ADF_GEN6_IAINTSTATSSM_RFPAR_ERR_BIT))
+		return;
+
+	reg = ADF_CSR_RD(csr, ADF_GEN6_SSM_FERR_STATUS);
+	reg &= ADF_GEN6_RF_PAR_ERR_MASK;
+	if (reg) {
+		dev_err(&GET_DEV(accel_dev), "Fatal error on RF Parity: %#x\n", reg);
+		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_FATAL);
+		ADF_CSR_WR(csr, ADF_GEN6_SSM_FERR_STATUS, reg);
+	}
+}
+
+static void adf_handle_unexp_cpl_err(struct adf_accel_dev *accel_dev, void __iomem *csr,
+				     u32 iastatssm)
+{
+	u32 reg;
+
+	if (!(iastatssm & ADF_GEN6_IAINTSTATSSM_UNEXP_CPL_ERR_BIT))
+		return;
+
+	reg = ADF_CSR_RD(csr, ADF_GEN6_SSM_FERR_STATUS);
+	reg &= ADF_GEN6_UNEXP_CPL_ERR_MASK;
+	if (reg) {
+		dev_err(&GET_DEV(accel_dev),
+			"Fatal error for AXI unexpected tag/length: %#x\n", reg);
+		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_FATAL);
+		ADF_CSR_WR(csr, ADF_GEN6_SSM_FERR_STATUS, reg);
+	}
+}
+
+static void adf_handle_iaintstatssm(struct adf_accel_dev *accel_dev, void __iomem *csr)
+{
+	u32 iastatssm = ADF_CSR_RD(csr, ADF_GEN6_IAINTSTATSSM);
+
+	iastatssm &= ADF_GEN6_IAINTSTATSSM_MASK;
+	if (!iastatssm)
+		return;
+
+	adf_handle_uerrssmsh(accel_dev, csr, iastatssm);
+	adf_handle_pperr_err(accel_dev, csr, iastatssm);
+	adf_handle_scmpar_err(accel_dev, csr, iastatssm);
+	adf_handle_cpppar_err(accel_dev, csr, iastatssm);
+	adf_handle_rfpar_err(accel_dev, csr, iastatssm);
+	adf_handle_unexp_cpl_err(accel_dev, csr, iastatssm);
+
+	ADF_CSR_WR(csr, ADF_GEN6_IAINTSTATSSM, iastatssm);
+}
+
+static void adf_handle_ssm(struct adf_accel_dev *accel_dev, void __iomem *csr, u32 errsou)
+{
+	if (!(errsou & ADF_GEN6_ERRSOU2_SSM_ERR_BIT))
+		return;
+
+	adf_handle_cerrssmsh(accel_dev, csr);
+	adf_handle_iaintstatssm(accel_dev, csr);
+}
+
+static void adf_handle_cpp_cfc_err(struct adf_accel_dev *accel_dev, void __iomem *csr,
+				   u32 errsou)
+{
+	u32 reg;
+
+	if (!(errsou & ADF_GEN6_ERRSOU2_CPP_CFC_ERR_STATUS_BIT))
+		return;
+
+	reg = ADF_CSR_RD(csr, ADF_GEN6_CPP_CFC_ERR_STATUS);
+	if (reg & ADF_GEN6_CPP_CFC_ERR_STATUS_DATAPAR_BIT) {
+		dev_err(&GET_DEV(accel_dev), "CPP_CFC_ERR: data parity: %#x", reg);
+		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_UNCORR);
+	}
+
+	if (reg & ADF_GEN6_CPP_CFC_ERR_STATUS_CMDPAR_BIT) {
+		dev_err(&GET_DEV(accel_dev), "CPP_CFC_ERR: command parity: %#x", reg);
+		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_FATAL);
+	}
+
+	if (reg & ADF_GEN6_CPP_CFC_FATAL_ERR_BIT) {
+		dev_err(&GET_DEV(accel_dev), "CPP_CFC_ERR: errors: %#x", reg);
+		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_FATAL);
+	}
+
+	ADF_CSR_WR(csr, ADF_GEN6_CPP_CFC_ERR_STATUS_CLR,
+		   ADF_GEN6_CPP_CFC_ERR_STATUS_CLR_MASK);
+}
+
+static void adf_gen6_process_errsou2(struct adf_accel_dev *accel_dev, void __iomem *csr,
+				     u32 errsou)
+{
+	adf_handle_ssm(accel_dev, csr, errsou);
+	adf_handle_cpp_cfc_err(accel_dev, csr, errsou);
+
+	errsou = ADF_CSR_RD(csr, ADF_GEN6_ERRSOU2);
+	if (errsou & ADF_GEN6_ERRSOU2_MASK)
+		dev_warn(&GET_DEV(accel_dev), "errsou2 still set: %#x\n", errsou);
+}
+
+static void adf_handle_timiscsts(struct adf_accel_dev *accel_dev, void __iomem *csr,
+				 u32 errsou)
+{
+	u32 timiscsts;
+
+	if (!(errsou & ADF_GEN6_ERRSOU3_TIMISCSTS_BIT))
+		return;
+
+	timiscsts = ADF_CSR_RD(csr, ADF_GEN6_TIMISCSTS);
+	if (timiscsts) {
+		dev_err(&GET_DEV(accel_dev), "Fatal error in transmit interface: %#x\n",
+			timiscsts);
+		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_FATAL);
+	}
+}
+
+static void adf_handle_ricppintsts(struct adf_accel_dev *accel_dev, void __iomem *csr,
+				   u32 errsou)
+{
+	u32 ricppintsts;
+
+	if (!(errsou & ADF_GEN6_ERRSOU3_RICPPINTSTS_MASK))
+		return;
+
+	ricppintsts = ADF_CSR_RD(csr, ADF_GEN6_RICPPINTSTS);
+	ricppintsts &= ADF_GEN6_RICPPINTSTS_MASK;
+	if (ricppintsts) {
+		dev_err(&GET_DEV(accel_dev), "RI push pull error: %#x\n", ricppintsts);
+		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_UNCORR);
+		ADF_CSR_WR(csr, ADF_GEN6_RICPPINTSTS, ricppintsts);
+	}
+}
+
+static void adf_handle_ticppintsts(struct adf_accel_dev *accel_dev, void __iomem *csr,
+				   u32 errsou)
+{
+	u32 ticppintsts;
+
+	if (!(errsou & ADF_GEN6_ERRSOU3_TICPPINTSTS_MASK))
+		return;
+
+	ticppintsts = ADF_CSR_RD(csr, ADF_GEN6_TICPPINTSTS);
+	ticppintsts &= ADF_GEN6_TICPPINTSTS_MASK;
+	if (ticppintsts) {
+		dev_err(&GET_DEV(accel_dev), "TI push pull error: %#x\n", ticppintsts);
+		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_FATAL);
+		ADF_CSR_WR(csr, ADF_GEN6_TICPPINTSTS, ticppintsts);
+	}
+}
+
+static void adf_handle_atufaultstatus(struct adf_accel_dev *accel_dev, void __iomem *csr,
+				      u32 errsou)
+{
+	u32 max_rp_num = GET_HW_DATA(accel_dev)->num_banks;
+	u32 atufaultstatus;
+	u32 i;
+
+	if (!(errsou & ADF_GEN6_ERRSOU3_ATUFAULTSTATUS_BIT))
+		return;
+
+	for (i = 0; i < max_rp_num; i++) {
+		atufaultstatus = ADF_CSR_RD(csr, ADF_GEN6_ATUFAULTSTATUS(i));
+
+		atufaultstatus &= ADF_GEN6_ATUFAULTSTATUS_BIT;
+		if (atufaultstatus) {
+			dev_err(&GET_DEV(accel_dev), "Ring pair (%u) ATU detected fault: %#x\n", i,
+				atufaultstatus);
+			ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_UNCORR);
+			ADF_CSR_WR(csr, ADF_GEN6_ATUFAULTSTATUS(i), atufaultstatus);
+		}
+	}
+}
+
+static void adf_handle_rlterror(struct adf_accel_dev *accel_dev, void __iomem *csr,
+				u32 errsou)
+{
+	u32 rlterror;
+
+	if (!(errsou & ADF_GEN6_ERRSOU3_RLTERROR_BIT))
+		return;
+
+	rlterror = ADF_CSR_RD(csr, ADF_GEN6_RLT_ERRLOG);
+	rlterror &= ADF_GEN6_RLT_ERRLOG_MASK;
+	if (rlterror) {
+		dev_err(&GET_DEV(accel_dev), "Error in rate limiting block: %#x\n", rlterror);
+		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_UNCORR);
+		ADF_CSR_WR(csr, ADF_GEN6_RLT_ERRLOG, rlterror);
+	}
+}
+
+static void adf_handle_vflr(struct adf_accel_dev *accel_dev, void __iomem *csr, u32 errsou)
+{
+	if (!(errsou & ADF_GEN6_ERRSOU3_VFLRNOTIFY_BIT))
+		return;
+
+	dev_err(&GET_DEV(accel_dev), "Uncorrectable error in VF\n");
+	ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_UNCORR);
+}
+
+static void adf_handle_tc_vc_map_error(struct adf_accel_dev *accel_dev, void __iomem *csr,
+				       u32 errsou)
+{
+	if (!(errsou & ADF_GEN6_ERRSOU3_TC_VC_MAP_ERROR_BIT))
+		return;
+
+	dev_err(&GET_DEV(accel_dev), "Violation of PCIe TC VC mapping\n");
+	ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_FATAL);
+}
+
+static void adf_handle_pcie_devhalt(struct adf_accel_dev *accel_dev, void __iomem *csr,
+				    u32 errsou)
+{
+	if (!(errsou & ADF_GEN6_ERRSOU3_PCIE_DEVHALT_BIT))
+		return;
+
+	dev_err(&GET_DEV(accel_dev),
+		"DEVHALT due to an error in an incoming transaction\n");
+	ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_FATAL);
+}
+
+static void adf_handle_pg_req_devhalt(struct adf_accel_dev *accel_dev, void __iomem *csr,
+				      u32 errsou)
+{
+	if (!(errsou & ADF_GEN6_ERRSOU3_PG_REQ_DEVHALT_BIT))
+		return;
+
+	dev_err(&GET_DEV(accel_dev),
+		"Error due to response failure in response to a page request\n");
+	ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_FATAL);
+}
+
+static void adf_handle_xlt_cpl_devhalt(struct adf_accel_dev *accel_dev, void __iomem *csr,
+				       u32 errsou)
+{
+	if (!(errsou & ADF_GEN6_ERRSOU3_XLT_CPL_DEVHALT_BIT))
+		return;
+
+	dev_err(&GET_DEV(accel_dev), "Error status for a address translation request\n");
+	ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_FATAL);
+}
+
+static void adf_handle_ti_int_err_devhalt(struct adf_accel_dev *accel_dev, void __iomem *csr,
+					  u32 errsou)
+{
+	if (!(errsou & ADF_GEN6_ERRSOU3_TI_INT_ERR_DEVHALT_BIT))
+		return;
+
+	dev_err(&GET_DEV(accel_dev), "DEVHALT due to a TI internal memory error\n");
+	ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_FATAL);
+}
+
+static void adf_gen6_process_errsou3(struct adf_accel_dev *accel_dev, void __iomem *csr,
+				     u32 errsou)
+{
+	adf_handle_timiscsts(accel_dev, csr, errsou);
+	adf_handle_ricppintsts(accel_dev, csr, errsou);
+	adf_handle_ticppintsts(accel_dev, csr, errsou);
+	adf_handle_atufaultstatus(accel_dev, csr, errsou);
+	adf_handle_rlterror(accel_dev, csr, errsou);
+	adf_handle_vflr(accel_dev, csr, errsou);
+	adf_handle_tc_vc_map_error(accel_dev, csr, errsou);
+	adf_handle_pcie_devhalt(accel_dev, csr, errsou);
+	adf_handle_pg_req_devhalt(accel_dev, csr, errsou);
+	adf_handle_xlt_cpl_devhalt(accel_dev, csr, errsou);
+	adf_handle_ti_int_err_devhalt(accel_dev, csr, errsou);
+
+	errsou = ADF_CSR_RD(csr, ADF_GEN6_ERRSOU3);
+	if (errsou & ADF_GEN6_ERRSOU3_MASK)
+		dev_warn(&GET_DEV(accel_dev), "errsou3 still set: %#x\n", errsou);
+}
+
+static void adf_gen6_is_reset_required(struct adf_accel_dev *accel_dev, void __iomem *csr,
+				       bool *reset_required)
+{
+	u8 reset, dev_state;
+	u32 gensts;
+
+	gensts = ADF_CSR_RD(csr, ADF_GEN6_GENSTS);
+	dev_state = FIELD_GET(ADF_GEN6_GENSTS_DEVICE_STATE_MASK, gensts);
+	reset = FIELD_GET(ADF_GEN6_GENSTS_RESET_TYPE_MASK, gensts);
+	if (dev_state == ADF_GEN6_GENSTS_DEVHALT && reset == ADF_GEN6_GENSTS_PFLR) {
+		*reset_required = true;
+		return;
+	}
+
+	if (reset == ADF_GEN6_GENSTS_COLD_RESET)
+		dev_err(&GET_DEV(accel_dev), "Fatal error, cold reset required\n");
+
+	*reset_required = false;
+}
+
+static bool adf_gen6_handle_interrupt(struct adf_accel_dev *accel_dev, bool *reset_required)
+{
+	void __iomem *csr = adf_get_pmisc_base(accel_dev);
+	bool handled = false;
+	u32 errsou;
+
+	errsou = ADF_CSR_RD(csr, ADF_GEN6_ERRSOU0);
+	if (errsou & ADF_GEN6_ERRSOU0_MASK) {
+		adf_gen6_process_errsou0(accel_dev, csr);
+		handled = true;
+	}
+
+	errsou = ADF_CSR_RD(csr, ADF_GEN6_ERRSOU1);
+	if (errsou & ADF_GEN6_ERRSOU1_MASK) {
+		adf_gen6_process_errsou1(accel_dev, csr, errsou);
+		handled = true;
+	}
+
+	errsou = ADF_CSR_RD(csr, ADF_GEN6_ERRSOU2);
+	if (errsou & ADF_GEN6_ERRSOU2_MASK) {
+		adf_gen6_process_errsou2(accel_dev, csr, errsou);
+		handled = true;
+	}
+
+	errsou = ADF_CSR_RD(csr, ADF_GEN6_ERRSOU3);
+	if (errsou & ADF_GEN6_ERRSOU3_MASK) {
+		adf_gen6_process_errsou3(accel_dev, csr, errsou);
+		handled = true;
+	}
+
+	adf_gen6_is_reset_required(accel_dev, csr, reset_required);
+
+	return handled;
+}
+
+void adf_gen6_init_ras_ops(struct adf_ras_ops *ras_ops)
+{
+	ras_ops->enable_ras_errors = adf_gen6_enable_ras;
+	ras_ops->disable_ras_errors = adf_gen6_disable_ras;
+	ras_ops->handle_interrupt = adf_gen6_handle_interrupt;
+}
+EXPORT_SYMBOL_GPL(adf_gen6_init_ras_ops);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen6_ras.h b/drivers/crypto/intel/qat/qat_common/adf_gen6_ras.h
new file mode 100644
index 000000000000..66ced271d173
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen6_ras.h
@@ -0,0 +1,504 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2025 Intel Corporation */
+#ifndef ADF_GEN6_RAS_H_
+#define ADF_GEN6_RAS_H_
+
+#include <linux/bits.h>
+
+struct adf_ras_ops;
+
+/* Error source registers */
+#define ADF_GEN6_ERRSOU0	0x41A200
+#define ADF_GEN6_ERRSOU1	0x41A204
+#define ADF_GEN6_ERRSOU2	0x41A208
+#define ADF_GEN6_ERRSOU3	0x41A20C
+
+/* Error source mask registers */
+#define ADF_GEN6_ERRMSK0	0x41A210
+#define ADF_GEN6_ERRMSK1	0x41A214
+#define ADF_GEN6_ERRMSK2	0x41A218
+#define ADF_GEN6_ERRMSK3	0x41A21C
+
+/* ERRSOU0 Correctable error mask */
+#define ADF_GEN6_ERRSOU0_MASK				BIT(0)
+
+#define ADF_GEN6_ERRSOU1_CPP0_MEUNC_BIT			BIT(0)
+#define ADF_GEN6_ERRSOU1_CPP_CMDPARERR_BIT		BIT(1)
+#define ADF_GEN6_ERRSOU1_RIMEM_PARERR_STS_BIT		BIT(2)
+#define ADF_GEN6_ERRSOU1_TIMEM_PARERR_STS_BIT		BIT(3)
+#define ADF_GEN6_ERRSOU1_SFICMD_PARERR_BIT	        BIT(4)
+
+#define ADF_GEN6_ERRSOU1_MASK ( \
+	(ADF_GEN6_ERRSOU1_CPP0_MEUNC_BIT)	| \
+	(ADF_GEN6_ERRSOU1_CPP_CMDPARERR_BIT)	| \
+	(ADF_GEN6_ERRSOU1_RIMEM_PARERR_STS_BIT)	| \
+	(ADF_GEN6_ERRSOU1_TIMEM_PARERR_STS_BIT)	| \
+	(ADF_GEN6_ERRSOU1_SFICMD_PARERR_BIT))
+
+#define ADF_GEN6_ERRMSK1_CPP0_MEUNC_BIT			BIT(0)
+#define ADF_GEN6_ERRMSK1_CPP_CMDPARERR_BIT		BIT(1)
+#define ADF_GEN6_ERRMSK1_RIMEM_PARERR_STS_BIT		BIT(2)
+#define ADF_GEN6_ERRMSK1_TIMEM_PARERR_STS_BIT		BIT(3)
+#define ADF_GEN6_ERRMSK1_IOSFCMD_PARERR_BIT	        BIT(4)
+
+#define ADF_GEN6_ERRMSK1_MASK ( \
+	(ADF_GEN6_ERRMSK1_CPP0_MEUNC_BIT)	| \
+	(ADF_GEN6_ERRMSK1_CPP_CMDPARERR_BIT)	| \
+	(ADF_GEN6_ERRMSK1_RIMEM_PARERR_STS_BIT)	| \
+	(ADF_GEN6_ERRMSK1_TIMEM_PARERR_STS_BIT)	| \
+	(ADF_GEN6_ERRMSK1_IOSFCMD_PARERR_BIT))
+
+/* HI AE Uncorrectable error log */
+#define ADF_GEN6_HIAEUNCERRLOG_CPP0			0x41A300
+
+/* HI AE Uncorrectable error log enable */
+#define ADF_GEN6_HIAEUNCERRLOGENABLE_CPP0		0x41A320
+
+/* HI AE Correctable error log */
+#define ADF_GEN6_HIAECORERRLOG_CPP0			0x41A308
+
+/* HI AE Correctable error log enable */
+#define ADF_GEN6_HIAECORERRLOGENABLE_CPP0		0x41A318
+
+/* HI CPP Agent Command parity error log */
+#define ADF_GEN6_HICPPAGENTCMDPARERRLOG			0x41A310
+
+/* HI CPP Agent command parity error logging enable */
+#define ADF_GEN6_HICPPAGENTCMDPARERRLOGENABLE		0x41A314
+
+#define ADF_6XXX_HICPPAGENTCMDPARERRLOG_MASK		0x1B
+
+/* RI Memory parity error status register */
+#define ADF_GEN6_RIMEM_PARERR_STS			0x41B128
+
+/* RI Memory parity error reporting enable */
+#define ADF_GEN6_RI_MEM_PAR_ERR_EN0			0x41B12C
+
+/*
+ * RI Memory parity error mask
+ * BIT(4) - ri_tlq_phdr parity error
+ * BIT(5) - ri_tlq_pdata parity error
+ * BIT(6) - ri_tlq_nphdr parity error
+ * BIT(7) - ri_tlq_npdata parity error
+ * BIT(8) - ri_tlq_cplhdr parity error
+ * BIT(10) - BIT(13) - ri_tlq_cpldata[0:3] parity error
+ * BIT(19) - ri_cds_cmd_fifo parity error
+ * BIT(20) - ri_obc_ricpl_fifo parity error
+ * BIT(21) - ri_obc_tiricpl_fifo parity error
+ * BIT(22) - ri_obc_cppcpl_fifo parity error
+ * BIT(23) - ri_obc_pendcpl_fifo parity error
+ * BIT(24) - ri_cpp_cmd_fifo parity error
+ * BIT(25) - ri_cds_ticmd_fifo parity error
+ * BIT(26) - riti_cmd_fifo parity error
+ * BIT(27) - ri_int_msixtbl parity error
+ * BIT(28) - ri_int_imstbl parity error
+ * BIT(30) - ri_kpt_fuses parity error
+ */
+#define ADF_GEN6_RIMEM_PARERR_FATAL_MASK \
+	(BIT(0) | BIT(1) | BIT(2) | BIT(4) | BIT(5) | BIT(6) | \
+	 BIT(7) | BIT(8) | BIT(18) | BIT(19) | BIT(20) | BIT(21) | \
+	 BIT(22) | BIT(23) | BIT(24) | BIT(25) | BIT(26) | BIT(27) | \
+	 BIT(28) | BIT(30))
+
+#define ADF_GEN6_RIMEM_PARERR_CERR_MASK \
+	(BIT(10) | BIT(11) | BIT(12) | BIT(13))
+
+/* TI CI parity status */
+#define ADF_GEN6_TI_CI_PAR_STS				0x50060C
+
+/* TI CI parity reporting mask */
+#define ADF_GEN6_TI_CI_PAR_ERR_MASK			0x500608
+
+/*
+ * TI CI parity status mask
+ * BIT(0) - CdCmdQ_sts patiry error status
+ * BIT(1) - CdDataQ_sts parity error status
+ * BIT(3) - CPP_SkidQ_sts parity error status
+ */
+#define ADF_GEN6_TI_CI_PAR_STS_MASK \
+	(BIT(0) | BIT(1) | BIT(3))
+
+/* TI PULLFUB parity status */
+#define ADF_GEN6_TI_PULL0FUB_PAR_STS			0x500618
+
+/* TI PULLFUB parity error reporting mask */
+#define ADF_GEN6_TI_PULL0FUB_PAR_ERR_MASK		0x500614
+
+/*
+ * TI PULLFUB parity status mask
+ * BIT(0) - TrnPullReqQ_sts parity status
+ * BIT(1) - TrnSharedDataQ_sts parity status
+ * BIT(2) - TrnPullReqDataQ_sts parity status
+ * BIT(4) - CPP_CiPullReqQ_sts parity status
+ * BIT(5) - CPP_TrnPullReqQ_sts parity status
+ * BIT(6) - CPP_PullidQ_sts parity status
+ * BIT(7) - CPP_WaitDataQ_sts parity status
+ * BIT(8) - CPP_CdDataQ_sts parity status
+ * BIT(9) - CPP_TrnDataQP0_sts parity status
+ * BIT(10) - BIT(11) - CPP_TrnDataQRF[00:01]_sts parity status
+ * BIT(12) - CPP_TrnDataQP1_sts parity status
+ * BIT(13) - BIT(14) - CPP_TrnDataQRF[10:11]_sts parity status
+ */
+#define ADF_GEN6_TI_PULL0FUB_PAR_STS_MASK \
+	(BIT(0) | BIT(1) | BIT(2) | BIT(4) | BIT(5) | BIT(6) | BIT(7) | \
+	 BIT(8) | BIT(9) | BIT(10) | BIT(11) | BIT(12) | BIT(13) | BIT(14))
+
+/* TI PUSHUB parity status */
+#define ADF_GEN6_TI_PUSHFUB_PAR_STS			0x500630
+
+/* TI PUSHFUB parity error reporting mask */
+#define ADF_GEN6_TI_PUSHFUB_PAR_ERR_MASK		0x50062C
+
+/*
+ * TI PUSHUB parity status mask
+ * BIT(0) - SbPushReqQ_sts parity status
+ * BIT(1) - BIT(2) - SbPushDataQ[0:1]_sts parity status
+ * BIT(4) - CPP_CdPushReqQ_sts parity status
+ * BIT(5) - BIT(6) - CPP_CdPushDataQ[0:1]_sts parity status
+ * BIT(7) - CPP_SbPushReqQ_sts parity status
+ * BIT(8) - CPP_SbPushDataQP_sts parity status
+ * BIT(9) - BIT(10) - CPP_SbPushDataQRF[0:1]_sts parity status
+ */
+#define ADF_GEN6_TI_PUSHFUB_PAR_STS_MASK \
+	(BIT(0) | BIT(1) | BIT(2) | BIT(4) | BIT(5) | \
+	 BIT(6) | BIT(7) | BIT(8) | BIT(9) | BIT(10))
+
+/* TI CD parity status */
+#define ADF_GEN6_TI_CD_PAR_STS				0x50063C
+
+/* TI CD parity error mask */
+#define ADF_GEN6_TI_CD_PAR_ERR_MASK			0x500638
+
+/*
+ * TI CD parity status mask
+ * BIT(0) - BIT(15) - CtxMdRam[0:15]_sts parity status
+ * BIT(16) - Leaf2ClusterRam_sts parity status
+ * BIT(17) - BIT(18) - Ring2LeafRam[0:1]_sts parity status
+ * BIT(19) - VirtualQ_sts parity status
+ * BIT(20) - DtRdQ_sts parity status
+ * BIT(21) - DtWrQ_sts parity status
+ * BIT(22) - RiCmdQ_sts parity status
+ * BIT(23) - BypassQ_sts parity status
+ * BIT(24) - DtRdQ_sc_sts parity status
+ * BIT(25) - DtWrQ_sc_sts parity status
+ */
+#define ADF_GEN6_TI_CD_PAR_STS_MASK \
+	(BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) | BIT(6) | \
+	 BIT(7) | BIT(8) | BIT(9) | BIT(10) | BIT(11) | BIT(12) | BIT(13) | \
+	 BIT(14) | BIT(15) | BIT(16) | BIT(17) | BIT(18) | BIT(19) | BIT(20) | \
+	 BIT(21) | BIT(22) | BIT(23) | BIT(24) | BIT(25))
+
+/* TI TRNSB parity status */
+#define ADF_GEN6_TI_TRNSB_PAR_STS			0x500648
+
+/* TI TRNSB parity error reporting mask */
+#define ADF_GEN6_TI_TRNSB_PAR_ERR_MASK			0x500644
+
+/*
+ * TI TRNSB parity status mask
+ * BIT(0) - TrnPHdrQP_sts parity status
+ * BIT(1) - TrnPHdrQRF_sts parity status
+ * BIT(2) - TrnPDataQP_sts parity status
+ * BIT(3) - BIT(6) - TrnPDataQRF[0:3]_sts parity status
+ * BIT(7) - TrnNpHdrQP_sts parity status
+ * BIT(8) - BIT(9) - TrnNpHdrQRF[0:1]_sts parity status
+ * BIT(10) - TrnCplHdrQ_sts parity status
+ * BIT(11) - TrnPutObsReqQ_sts parity status
+ * BIT(12) - TrnPushReqQ_sts parity status
+ * BIT(13) - SbSplitIdRam_sts parity status
+ * BIT(14) - SbReqCountQ_sts parity status
+ * BIT(15) - SbCplTrkRam_sts parity status
+ * BIT(16) - SbGetObsReqQ_sts parity status
+ * BIT(17) - SbEpochIdQ_sts parity status
+ * BIT(18) - SbAtCplHdrQ_sts parity status
+ * BIT(19) - SbAtCplDataQ_sts parity status
+ * BIT(20) - SbReqCountRam_sts parity status
+ * BIT(21) - SbAtCplHdrQ_sc_sts parity status
+ */
+#define ADF_GEN6_TI_TRNSB_PAR_STS_MASK \
+	(BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) | BIT(6) | \
+	 BIT(7) | BIT(8) | BIT(9) | BIT(10) | BIT(11) | BIT(12) | \
+	 BIT(13) | BIT(14) | BIT(15) | BIT(16) | BIT(17) | BIT(18) | \
+	 BIT(19) | BIT(20) | BIT(21))
+
+/* Status register to log misc error on RI */
+#define ADF_GEN6_RIMISCSTS				0x41B1B8
+
+/* Status control register to log misc RI error */
+#define ADF_GEN6_RIMISCCTL				0x41B1BC
+
+/*
+ * ERRSOU2 bit mask
+ * BIT(0) - SSM Interrupt Mask
+ * BIT(1) - CFC on CPP. ORed of CFC Push error and Pull error
+ * BIT(2) - BIT(4) - CPP attention interrupts
+ * BIT(18) - PM interrupt
+ */
+#define ADF_GEN6_ERRSOU2_SSM_ERR_BIT			BIT(0)
+#define ADF_GEN6_ERRSOU2_CPP_CFC_ERR_STATUS_BIT	BIT(1)
+#define ADF_GEN6_ERRSOU2_CPP_CFC_ATT_INT_MASK \
+	(BIT(2) | BIT(3) | BIT(4))
+
+#define ADF_GEN6_ERRSOU2_PM_INT_BIT			BIT(18)
+
+#define ADF_GEN6_ERRSOU2_MASK \
+	(ADF_GEN6_ERRSOU2_SSM_ERR_BIT | \
+	 ADF_GEN6_ERRSOU2_CPP_CFC_ERR_STATUS_BIT)
+
+#define ADF_GEN6_ERRSOU2_DIS_MASK \
+	(ADF_GEN6_ERRSOU2_SSM_ERR_BIT | \
+	 ADF_GEN6_ERRSOU2_CPP_CFC_ERR_STATUS_BIT | \
+	 ADF_GEN6_ERRSOU2_CPP_CFC_ATT_INT_MASK)
+
+#define ADF_GEN6_IAINTSTATSSM				0x28
+
+/* IAINTSTATSSM error bit mask definitions */
+#define ADF_GEN6_IAINTSTATSSM_SH_ERR_BIT		BIT(0)
+#define ADF_GEN6_IAINTSTATSSM_PPERR_BIT			BIT(2)
+#define ADF_GEN6_IAINTSTATSSM_SCMPAR_ERR_BIT		BIT(4)
+#define ADF_GEN6_IAINTSTATSSM_CPPPAR_ERR_BIT		BIT(5)
+#define ADF_GEN6_IAINTSTATSSM_RFPAR_ERR_BIT		BIT(6)
+#define ADF_GEN6_IAINTSTATSSM_UNEXP_CPL_ERR_BIT		BIT(7)
+
+#define ADF_GEN6_IAINTSTATSSM_MASK \
+	(ADF_GEN6_IAINTSTATSSM_SH_ERR_BIT | \
+	 ADF_GEN6_IAINTSTATSSM_PPERR_BIT | \
+	 ADF_GEN6_IAINTSTATSSM_SCMPAR_ERR_BIT | \
+	 ADF_GEN6_IAINTSTATSSM_CPPPAR_ERR_BIT | \
+	 ADF_GEN6_IAINTSTATSSM_RFPAR_ERR_BIT | \
+	 ADF_GEN6_IAINTSTATSSM_UNEXP_CPL_ERR_BIT)
+
+#define ADF_GEN6_UERRSSMSH				0x18
+
+/*
+ * UERRSSMSH error bit mask definitions
+ *
+ * BIT(0) - Indicates one uncorrectable error
+ * BIT(15) - Indicates multiple uncorrectable errors
+ *	     in device shared memory
+ */
+#define ADF_GEN6_UERRSSMSH_MASK			(BIT(0) | BIT(15))
+
+/*
+ * CERRSSMSH error bit
+ * BIT(0) - Indicates one correctable error
+ */
+#define ADF_GEN6_CERRSSMSH_ERROR_BIT			(BIT(0) | BIT(15) | BIT(24))
+#define ADF_GEN6_CERRSSMSH				0x10
+
+#define ADF_GEN6_INTMASKSSM				0x0
+
+/*
+ * Error reporting mask in INTMASKSSM
+ * BIT(0) - Shared memory uncorrectable interrupt mask
+ * BIT(2) - PPERR interrupt mask
+ * BIT(4) - SCM parity error interrupt mask
+ * BIT(5) - CPP parity error interrupt mask
+ * BIT(6) - SHRAM RF parity error interrupt mask
+ * BIT(7) - AXI unexpected completion error mask
+ */
+#define ADF_GEN6_INTMASKSSM_MASK	\
+	(BIT(0) | BIT(2) | BIT(4) | BIT(5) | BIT(6) | BIT(7))
+
+/* CPP push or pull error */
+#define ADF_GEN6_PPERR					0x8
+
+#define ADF_GEN6_PPERR_MASK				(BIT(0) | BIT(1))
+
+/*
+ * SSM_FERR_STATUS error bit mask definitions
+ */
+#define ADF_GEN6_SCM_PAR_ERR_MASK			BIT(5)
+#define ADF_GEN6_CPP_PAR_ERR_MASK			(BIT(0) | BIT(1) | BIT(2))
+#define ADF_GEN6_UNEXP_CPL_ERR_MASK			(BIT(3) | BIT(4) | BIT(10) | BIT(11))
+#define ADF_GEN6_RF_PAR_ERR_MASK			BIT(16)
+
+#define ADF_GEN6_SSM_FERR_STATUS			0x9C
+
+#define ADF_GEN6_CPP_CFC_ERR_STATUS			0x640C04
+
+/*
+ * BIT(0) - Indicates one or more CPP CFC errors
+ * BIT(1) - Indicates multiple CPP CFC errors
+ * BIT(7) - Indicates CPP CFC command parity error type
+ * BIT(8) - Indicates CPP CFC data parity error type
+ */
+#define ADF_GEN6_CPP_CFC_ERR_STATUS_ERR_BIT		BIT(0)
+#define ADF_GEN6_CPP_CFC_ERR_STATUS_MERR_BIT		BIT(1)
+#define ADF_GEN6_CPP_CFC_ERR_STATUS_CMDPAR_BIT		BIT(7)
+#define ADF_GEN6_CPP_CFC_ERR_STATUS_DATAPAR_BIT		BIT(8)
+#define ADF_GEN6_CPP_CFC_FATAL_ERR_BIT		\
+	(ADF_GEN6_CPP_CFC_ERR_STATUS_ERR_BIT |	\
+	 ADF_GEN6_CPP_CFC_ERR_STATUS_MERR_BIT)
+
+/*
+ * BIT(0) - Enables CFC to detect and log a push/pull data error
+ * BIT(1) - Enables CFC to generate interrupt to PCIEP for a CPP error
+ * BIT(4) - When 1 parity detection is disabled
+ * BIT(5) - When 1 parity detection is disabled on CPP command bus
+ * BIT(6) - When 1 parity detection is disabled on CPP push/pull bus
+ * BIT(9) - When 1 RF parity error detection is disabled
+ */
+#define ADF_GEN6_CPP_CFC_ERR_CTRL_MASK		(BIT(0) | BIT(1))
+
+#define ADF_GEN6_CPP_CFC_ERR_CTRL_DIS_MASK \
+	(BIT(4) | BIT(5) | BIT(6) | BIT(9) | BIT(10))
+
+#define ADF_GEN6_CPP_CFC_ERR_CTRL			0x640C00
+
+/*
+ * BIT(0) - Clears bit(0) of ADF_GEN6_CPP_CFC_ERR_STATUS
+ *	    when an error is reported on CPP
+ * BIT(1) - Clears bit(1) of ADF_GEN6_CPP_CFC_ERR_STATUS
+ *	    when multiple errors are reported on CPP
+ * BIT(2) - Clears bit(2) of ADF_GEN6_CPP_CFC_ERR_STATUS
+ *	    when attention interrupt is reported
+ */
+#define ADF_GEN6_CPP_CFC_ERR_STATUS_CLR_MASK		(BIT(0) | BIT(1) | BIT(2))
+#define ADF_GEN6_CPP_CFC_ERR_STATUS_CLR			0x640C08
+
+/*
+ * ERRSOU3 bit masks
+ * BIT(0) - indicates error response order overflow and/or BME error
+ * BIT(1) - indicates RI push/pull error
+ * BIT(2) - indicates TI push/pull error
+ * BIT(5) - indicates TI pull parity error
+ * BIT(6) - indicates RI push parity error
+ * BIT(7) - indicates VFLR interrupt
+ * BIT(8) - indicates ring pair interrupts for ATU detected fault
+ * BIT(9) - indicates rate limiting error
+ */
+#define ADF_GEN6_ERRSOU3_TIMISCSTS_BIT			BIT(0)
+#define ADF_GEN6_ERRSOU3_RICPPINTSTS_MASK		(BIT(1) | BIT(6))
+#define ADF_GEN6_ERRSOU3_TICPPINTSTS_MASK		(BIT(2) | BIT(5))
+#define ADF_GEN6_ERRSOU3_VFLRNOTIFY_BIT			BIT(7)
+#define ADF_GEN6_ERRSOU3_ATUFAULTSTATUS_BIT		BIT(8)
+#define ADF_GEN6_ERRSOU3_RLTERROR_BIT			BIT(9)
+#define ADF_GEN6_ERRSOU3_TC_VC_MAP_ERROR_BIT		BIT(16)
+#define ADF_GEN6_ERRSOU3_PCIE_DEVHALT_BIT		BIT(17)
+#define ADF_GEN6_ERRSOU3_PG_REQ_DEVHALT_BIT		BIT(18)
+#define ADF_GEN6_ERRSOU3_XLT_CPL_DEVHALT_BIT		BIT(19)
+#define ADF_GEN6_ERRSOU3_TI_INT_ERR_DEVHALT_BIT		BIT(20)
+
+#define ADF_GEN6_ERRSOU3_MASK ( \
+	(ADF_GEN6_ERRSOU3_TIMISCSTS_BIT) | \
+	(ADF_GEN6_ERRSOU3_RICPPINTSTS_MASK) | \
+	(ADF_GEN6_ERRSOU3_TICPPINTSTS_MASK) | \
+	(ADF_GEN6_ERRSOU3_VFLRNOTIFY_BIT) | \
+	(ADF_GEN6_ERRSOU3_ATUFAULTSTATUS_BIT) | \
+	(ADF_GEN6_ERRSOU3_RLTERROR_BIT) | \
+	(ADF_GEN6_ERRSOU3_TC_VC_MAP_ERROR_BIT) | \
+	(ADF_GEN6_ERRSOU3_PCIE_DEVHALT_BIT) | \
+	(ADF_GEN6_ERRSOU3_PG_REQ_DEVHALT_BIT) | \
+	(ADF_GEN6_ERRSOU3_XLT_CPL_DEVHALT_BIT) | \
+	(ADF_GEN6_ERRSOU3_TI_INT_ERR_DEVHALT_BIT))
+
+#define ADF_GEN6_ERRSOU3_DIS_MASK ( \
+	(ADF_GEN6_ERRSOU3_TIMISCSTS_BIT) | \
+	(ADF_GEN6_ERRSOU3_RICPPINTSTS_MASK) | \
+	(ADF_GEN6_ERRSOU3_TICPPINTSTS_MASK) | \
+	(ADF_GEN6_ERRSOU3_VFLRNOTIFY_BIT) | \
+	(ADF_GEN6_ERRSOU3_ATUFAULTSTATUS_BIT) | \
+	(ADF_GEN6_ERRSOU3_RLTERROR_BIT) | \
+	(ADF_GEN6_ERRSOU3_TC_VC_MAP_ERROR_BIT))
+
+/* Rate limiting error log register */
+#define ADF_GEN6_RLT_ERRLOG				0x508814
+
+#define ADF_GEN6_RLT_ERRLOG_MASK	(BIT(0) | BIT(1) | BIT(2) | BIT(3))
+
+/* TI misc status register */
+#define ADF_GEN6_TIMISCSTS				0x50054C
+
+/* TI misc error reporting mask */
+#define ADF_GEN6_TIMISCCTL				0x500548
+
+/*
+ * TI Misc error reporting control mask
+ * BIT(0) - Enables error detection and logging in TIMISCSTS register
+ * BIT(1) - It has effect only when SRIOV enabled, this bit is 0 by default
+ * BIT(2) - Enables the D-F-x counter within the dispatch arbiter
+ *	    to start based on the command triggered from
+ * BIT(30) - Disables VFLR functionality
+ * bits 1, 2 and 30 value should be preserved and not meant to be changed
+ * within RAS.
+ */
+#define ADF_GEN6_TIMISCCTL_BIT				BIT(0)
+#define ADF_GEN6_TIMSCCTL_RELAY_MASK			(BIT(1) | BIT(2) | BIT(30))
+
+/* RI CPP interface status register */
+#define ADF_GEN6_RICPPINTSTS				0x41A330
+
+/*
+ * Uncorrectable error mask in RICPPINTSTS register
+ * BIT(0) - RI asserted the CPP error signal during a push
+ * BIT(1) - RI detected the CPP error signal asserted during a pull
+ * BIT(2) - RI detected a push data parity error
+ * BIT(3) - RI detected a push valid parity error
+ */
+#define ADF_GEN6_RICPPINTSTS_MASK			(BIT(0) | BIT(1) | BIT(2) | BIT(3))
+
+/* RI CPP interface register control */
+#define ADF_GEN6_RICPPINTCTL				0x41A32C
+
+/*
+ * Control bit mask for RICPPINTCTL register
+ * BIT(0) - value of 1 enables error detection and reporting
+ *	    on the RI CPP Push interface
+ * BIT(1) - value of 1 enables error detection and reporting
+ *	    on the RI CPP Pull interface
+ * BIT(2) - value of 1 enables error detection and reporting
+ *	    on the RI Parity
+ * BIT(3) - value of 1 enable checking parity on CPP
+ */
+#define ADF_GEN6_RICPPINTCTL_MASK \
+	(BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4))
+
+/* TI CPP interface status register */
+#define ADF_GEN6_TICPPINTSTS				0x50053C
+
+/*
+ * Uncorrectable error mask in TICPPINTSTS register
+ * BIT(0) - value of 1 indicates that the TI asserted
+ *	    the CPP error signal during a push
+ * BIT(1) - value of 1 indicates that the TI detected
+ *	    the CPP error signal asserted during a pull
+ * BIT(2) - value of 1 indicates that the TI detected
+ *	    a pull data parity error
+ */
+#define ADF_GEN6_TICPPINTSTS_MASK			(BIT(0) | BIT(1) | BIT(2))
+
+/* TI CPP interface status register control */
+#define ADF_GEN6_TICPPINTCTL				0x500538
+
+/*
+ * Control bit mask for TICPPINTCTL register
+ * BIT(0) - value of 1 enables error detection and reporting on
+ *	    the TI CPP Push interface
+ * BIT(1) - value of 1 enables error detection and reporting on
+ *	    the TI CPP Push interface
+ * BIT(2) - value of 1 enables parity error detection and logging on
+ *	    the TI CPP Pull interface
+ * BIT(3) - value of 1 enables CPP CMD and Pull Data parity checking
+ */
+#define ADF_GEN6_TICPPINTCTL_MASK	\
+	(BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4))
+
+/* ATU fault status register */
+#define ADF_GEN6_ATUFAULTSTATUS(i)			(0x506000 + ((i) * 0x4))
+
+#define ADF_GEN6_ATUFAULTSTATUS_BIT			BIT(0)
+
+/* Command parity error detected on IOSFP command to QAT */
+#define ADF_GEN6_RIMISCSTS_BIT				BIT(0)
+
+#define ADF_GEN6_GENSTS					0x41A220
+#define ADF_GEN6_GENSTS_DEVICE_STATE_MASK		GENMASK(1, 0)
+#define ADF_GEN6_GENSTS_RESET_TYPE_MASK			GENMASK(3, 2)
+#define ADF_GEN6_GENSTS_PFLR				0x1
+#define ADF_GEN6_GENSTS_COLD_RESET			0x3
+#define ADF_GEN6_GENSTS_DEVHALT				0x1
+
+void adf_gen6_init_ras_ops(struct adf_ras_ops *ras_ops);
+
+#endif /* ADF_GEN6_RAS_H_ */
-- 
2.40.1



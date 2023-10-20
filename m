Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516507D0D43
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Oct 2023 12:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376745AbjJTKfS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Oct 2023 06:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376863AbjJTKfN (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Oct 2023 06:35:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FE5D5A
        for <linux-crypto@vger.kernel.org>; Fri, 20 Oct 2023 03:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697798107; x=1729334107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0GMLd/lmqXdPf5KoxBNLckO0+PXv+KR3+m9ztwXmUGI=;
  b=eB1BQDsi+U+NDdHQgoDvBT2/EiB4QQsHy66wpbhusvfQ0XBrNSWjvMrW
   COcevhIB/sTMXhC+ieeoS9EwcB9kexBeUVFddagzNhd0UfWAOwtRA7wF8
   ZZz54NdGNOKHe0lW3YiKf+BY1peGc6MkJTESjM5tVAo66oDDbn+cZbW0b
   PYPcHtZ+PXwK4oBTjMgZk5QMTGreGmYIfgLXBq9DN87P6jgyo+EswMdVZ
   cC4sgXyFuQ8tg4rR11E1y+rb8TFReJEaBsJPJTSGrWxUUdtElxEPxvuLQ
   83434McSZYXq06jaAUTMRFjsFgJnjUl0A5TjfJDZ1oRQP8bPWA/kBrHfa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="383686713"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="383686713"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 03:35:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="792369937"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="792369937"
Received: from fl31ca105gs0706.deacluster.intel.com (HELO fl31ca105gs0706..) ([10.45.133.167])
  by orsmga001.jf.intel.com with ESMTP; 20 Oct 2023 03:35:02 -0700
From:   Shashank Gupta <shashank.gupta@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Shashank Gupta <shashank.gupta@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Tero Kristo <tero.kristo@linux.intel.com>
Subject: [PATCH 7/9] crypto: qat - add handling of errors from ERRSOU3 for QAT GEN4
Date:   Fri, 20 Oct 2023 11:32:51 +0100
Message-ID: <20231020103431.230671-8-shashank.gupta@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020103431.230671-1-shashank.gupta@intel.com>
References: <20231020103431.230671-1-shashank.gupta@intel.com>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add logic to detect, report and handle uncorrectable errors reported
through the ERRSOU3 register in QAT GEN4 devices.

Signed-off-by: Shashank Gupta <shashank.gupta@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 .../intel/qat/qat_common/adf_gen4_ras.c       | 256 ++++++++++++++++++
 .../intel/qat/qat_common/adf_gen4_ras.h       | 218 +++++++++++++++
 2 files changed, 474 insertions(+)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c
index 285b755e13be..8ba9c9bdb89b 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c
@@ -19,6 +19,14 @@ static void enable_errsou_reporting(void __iomem *csr)
 	ADF_CSR_WR(csr, ADF_GEN4_ERRMSK2,
 		   ADF_GEN4_ERRSOU2_PM_INT_BIT |
 		   ADF_GEN4_ERRSOU2_CPP_CFC_ATT_INT_BITMASK);
+
+	/*
+	 * Enable uncorrectable error reporting in ERRSOU3
+	 * but disable RLT error interrupt and VFLR notify interrupt by default
+	 */
+	ADF_CSR_WR(csr, ADF_GEN4_ERRMSK3,
+		   ADF_GEN4_ERRSOU3_RLTERROR_BIT |
+		   ADF_GEN4_ERRSOU3_VFLRNOTIFY_BIT);
 }
 
 static void disable_errsou_reporting(void __iomem *csr)
@@ -35,6 +43,9 @@ static void disable_errsou_reporting(void __iomem *csr)
 	val = ADF_CSR_RD(csr, ADF_GEN4_ERRMSK2);
 	val |= ADF_GEN4_ERRSOU2_DIS_BITMASK;
 	ADF_CSR_WR(csr, ADF_GEN4_ERRMSK2, val);
+
+	/* Disable uncorrectable error reporting in ERRSOU3 */
+	ADF_CSR_WR(csr, ADF_GEN4_ERRMSK3, ADF_GEN4_ERRSOU3_BITMASK);
 }
 
 static void enable_ae_error_reporting(struct adf_accel_dev *accel_dev,
@@ -82,6 +93,8 @@ static void disable_cpp_error_reporting(void __iomem *csr)
 
 static void enable_ti_ri_error_reporting(void __iomem *csr)
 {
+	u32 reg;
+
 	/* Enable RI Memory error reporting */
 	ADF_CSR_WR(csr, ADF_GEN4_RI_MEM_PAR_ERR_EN0,
 		   ADF_GEN4_RIMEM_PARERR_STS_FATAL_BITMASK |
@@ -96,10 +109,26 @@ static void enable_ti_ri_error_reporting(void __iomem *csr)
 	ADF_CSR_WR(csr, ADF_GEN4_TI_PUSHFUB_PAR_ERR_MASK, 0);
 	ADF_CSR_WR(csr, ADF_GEN4_TI_CD_PAR_ERR_MASK, 0);
 	ADF_CSR_WR(csr, ADF_GEN4_TI_TRNSB_PAR_ERR_MASK, 0);
+
+	/* Enable error handling in RI, TI CPP interface control registers */
+	ADF_CSR_WR(csr, ADF_GEN4_RICPPINTCTL, ADF_GEN4_RICPPINTCTL_BITMASK);
+
+	ADF_CSR_WR(csr, ADF_GEN4_TICPPINTCTL, ADF_GEN4_TICPPINTCTL_BITMASK);
+
+	/*
+	 * Enable error detection and reporting in TIMISCSTS
+	 * with bits 1, 2 and 30 value preserved
+	 */
+	reg = ADF_CSR_RD(csr, ADF_GEN4_TIMISCCTL);
+	reg &= ADF_GEN4_TIMSCCTL_RELAY_BITMASK;
+	reg |= ADF_GEN4_TIMISCCTL_BIT;
+	ADF_CSR_WR(csr, ADF_GEN4_TIMISCCTL, reg);
 }
 
 static void disable_ti_ri_error_reporting(void __iomem *csr)
 {
+	u32 reg;
+
 	/* Disable RI Memory error reporting */
 	ADF_CSR_WR(csr, ADF_GEN4_RI_MEM_PAR_ERR_EN0, 0);
 
@@ -117,6 +146,19 @@ static void disable_ti_ri_error_reporting(void __iomem *csr)
 		   ADF_GEN4_TI_CD_PAR_STS_BITMASK);
 	ADF_CSR_WR(csr, ADF_GEN4_TI_TRNSB_PAR_ERR_MASK,
 		   ADF_GEN4_TI_TRNSB_PAR_STS_BITMASK);
+
+	/* Disable error handling in RI, TI CPP interface control registers */
+	ADF_CSR_WR(csr, ADF_GEN4_RICPPINTCTL, 0);
+
+	ADF_CSR_WR(csr, ADF_GEN4_TICPPINTCTL, 0);
+
+	/*
+	 * Disable error detection and reporting in TIMISCSTS
+	 * with bits 1, 2 and 30 value preserved
+	 */
+	reg = ADF_CSR_RD(csr, ADF_GEN4_TIMISCCTL);
+	reg &= ADF_GEN4_TIMSCCTL_RELAY_BITMASK;
+	ADF_CSR_WR(csr, ADF_GEN4_TIMISCCTL, reg);
 }
 
 static void enable_rf_error_reporting(struct adf_accel_dev *accel_dev,
@@ -251,8 +293,32 @@ static void disable_ssm_error_reporting(struct adf_accel_dev *accel_dev,
 			   err_mask->parerr_wat_wcp_mask);
 }
 
+static void enable_aram_error_reporting(void __iomem *csr)
+{
+	ADF_CSR_WR(csr, ADF_GEN4_REG_ARAMCERRUERR_EN,
+		   ADF_GEN4_REG_ARAMCERRUERR_EN_BITMASK);
+
+	ADF_CSR_WR(csr, ADF_GEN4_REG_ARAMCERR,
+		   ADF_GEN4_REG_ARAMCERR_EN_BITMASK);
+
+	ADF_CSR_WR(csr, ADF_GEN4_REG_ARAMUERR,
+		   ADF_GEN4_REG_ARAMUERR_EN_BITMASK);
+
+	ADF_CSR_WR(csr, ADF_GEN4_REG_CPPMEMTGTERR,
+		   ADF_GEN4_REG_CPPMEMTGTERR_EN_BITMASK);
+}
+
+static void disable_aram_error_reporting(void __iomem *csr)
+{
+	ADF_CSR_WR(csr, ADF_GEN4_REG_ARAMCERRUERR_EN, 0);
+	ADF_CSR_WR(csr, ADF_GEN4_REG_ARAMCERR, 0);
+	ADF_CSR_WR(csr, ADF_GEN4_REG_ARAMUERR, 0);
+	ADF_CSR_WR(csr, ADF_GEN4_REG_CPPMEMTGTERR, 0);
+}
+
 static void adf_gen4_enable_ras(struct adf_accel_dev *accel_dev)
 {
+	void __iomem *aram_csr = adf_get_aram_base(accel_dev);
 	void __iomem *csr = adf_get_pmisc_base(accel_dev);
 
 	enable_errsou_reporting(csr);
@@ -261,10 +327,12 @@ static void adf_gen4_enable_ras(struct adf_accel_dev *accel_dev)
 	enable_ti_ri_error_reporting(csr);
 	enable_rf_error_reporting(accel_dev, csr);
 	enable_ssm_error_reporting(accel_dev, csr);
+	enable_aram_error_reporting(aram_csr);
 }
 
 static void adf_gen4_disable_ras(struct adf_accel_dev *accel_dev)
 {
+	void __iomem *aram_csr = adf_get_aram_base(accel_dev);
 	void __iomem *csr = adf_get_pmisc_base(accel_dev);
 
 	disable_errsou_reporting(csr);
@@ -273,6 +341,7 @@ static void adf_gen4_disable_ras(struct adf_accel_dev *accel_dev)
 	disable_ti_ri_error_reporting(csr);
 	disable_rf_error_reporting(accel_dev, csr);
 	disable_ssm_error_reporting(accel_dev, csr);
+	disable_aram_error_reporting(aram_csr);
 }
 
 static void adf_gen4_process_errsou0(struct adf_accel_dev *accel_dev,
@@ -1122,9 +1191,190 @@ static void adf_gen4_process_errsou2(struct adf_accel_dev *accel_dev,
 	*reset_required |= adf_handle_cpp_cfc_err(accel_dev, csr, errsou);
 }
 
+static bool adf_handle_timiscsts(struct adf_accel_dev *accel_dev,
+				 void __iomem *csr, u32 errsou)
+{
+	u32 timiscsts;
+
+	if (!(errsou & ADF_GEN4_ERRSOU3_TIMISCSTS_BIT))
+		return false;
+
+	timiscsts = ADF_CSR_RD(csr, ADF_GEN4_TIMISCSTS);
+
+	dev_err(&GET_DEV(accel_dev),
+		"Fatal error in Transmit Interface: 0x%x\n", timiscsts);
+
+	return true;
+}
+
+static bool adf_handle_ricppintsts(struct adf_accel_dev *accel_dev,
+				   void __iomem *csr, u32 errsou)
+{
+	u32 ricppintsts;
+
+	if (!(errsou & ADF_GEN4_ERRSOU3_RICPPINTSTS_BITMASK))
+		return false;
+
+	ricppintsts = ADF_CSR_RD(csr, ADF_GEN4_RICPPINTSTS);
+	ricppintsts &= ADF_GEN4_RICPPINTSTS_BITMASK;
+
+	dev_err(&GET_DEV(accel_dev),
+		"RI CPP Uncorrectable Error: 0x%x\n", ricppintsts);
+
+	ADF_CSR_WR(csr, ADF_GEN4_RICPPINTSTS, ricppintsts);
+
+	return false;
+}
+
+static bool adf_handle_ticppintsts(struct adf_accel_dev *accel_dev,
+				   void __iomem *csr, u32 errsou)
+{
+	u32 ticppintsts;
+
+	if (!(errsou & ADF_GEN4_ERRSOU3_TICPPINTSTS_BITMASK))
+		return false;
+
+	ticppintsts = ADF_CSR_RD(csr, ADF_GEN4_TICPPINTSTS);
+	ticppintsts &= ADF_GEN4_TICPPINTSTS_BITMASK;
+
+	dev_err(&GET_DEV(accel_dev),
+		"TI CPP Uncorrectable Error: 0x%x\n", ticppintsts);
+
+	ADF_CSR_WR(csr, ADF_GEN4_TICPPINTSTS, ticppintsts);
+
+	return false;
+}
+
+static bool adf_handle_aramcerr(struct adf_accel_dev *accel_dev,
+				void __iomem *csr, u32 errsou)
+{
+	u32 aram_cerr;
+
+	if (!(errsou & ADF_GEN4_ERRSOU3_REG_ARAMCERR_BIT))
+		return false;
+
+	aram_cerr = ADF_CSR_RD(csr, ADF_GEN4_REG_ARAMCERR);
+	aram_cerr &= ADF_GEN4_REG_ARAMCERR_BIT;
+
+	dev_warn(&GET_DEV(accel_dev),
+		 "ARAM correctable error : 0x%x\n", aram_cerr);
+
+	aram_cerr |= ADF_GEN4_REG_ARAMCERR_EN_BITMASK;
+
+	ADF_CSR_WR(csr, ADF_GEN4_REG_ARAMCERR, aram_cerr);
+
+	return false;
+}
+
+static bool adf_handle_aramuerr(struct adf_accel_dev *accel_dev,
+				void __iomem *csr, u32 errsou)
+{
+	bool reset_required = false;
+	u32 aramuerr;
+
+	if (!(errsou & ADF_GEN4_ERRSOU3_REG_ARAMUERR_BIT))
+		return false;
+
+	aramuerr = ADF_CSR_RD(csr, ADF_GEN4_REG_ARAMUERR);
+	aramuerr &= ADF_GEN4_REG_ARAMUERR_ERROR_BIT |
+		    ADF_GEN4_REG_ARAMUERR_MULTI_ERRORS_BIT;
+
+	if (!aramuerr)
+		return false;
+
+	if (aramuerr & ADF_GEN4_REG_ARAMUERR_MULTI_ERRORS_BIT) {
+		dev_err(&GET_DEV(accel_dev),
+			"ARAM multiple uncorrectable errors: 0x%x\n", aramuerr);
+
+		reset_required = true;
+	} else {
+		dev_err(&GET_DEV(accel_dev),
+			"ARAM uncorrectable error: 0x%x\n", aramuerr);
+	}
+
+	aramuerr |= ADF_GEN4_REG_ARAMUERR_EN_BITMASK;
+
+	ADF_CSR_WR(csr, ADF_GEN4_REG_ARAMUERR, aramuerr);
+
+	return reset_required;
+}
+
+static bool adf_handle_reg_cppmemtgterr(struct adf_accel_dev *accel_dev,
+					void __iomem *csr, u32 errsou)
+{
+	bool reset_required = false;
+	u32 cppmemtgterr;
+
+	if (!(errsou & ADF_GEN4_ERRSOU3_REG_ARAMUERR_BIT))
+		return false;
+
+	cppmemtgterr = ADF_CSR_RD(csr, ADF_GEN4_REG_CPPMEMTGTERR);
+	cppmemtgterr &= ADF_GEN4_REG_CPPMEMTGTERR_BITMASK |
+			ADF_GEN4_REG_CPPMEMTGTERR_MULTI_ERRORS_BIT;
+	if (!cppmemtgterr)
+		return false;
+
+	if (cppmemtgterr & ADF_GEN4_REG_CPPMEMTGTERR_MULTI_ERRORS_BIT) {
+		dev_err(&GET_DEV(accel_dev),
+			"Misc memory target multiple uncorrectable errors: 0x%x\n",
+			cppmemtgterr);
+
+		reset_required = true;
+	} else {
+		dev_err(&GET_DEV(accel_dev),
+			"Misc memory target uncorrectable error: 0x%x\n", cppmemtgterr);
+	}
+
+	cppmemtgterr |= ADF_GEN4_REG_CPPMEMTGTERR_EN_BITMASK;
+
+	ADF_CSR_WR(csr, ADF_GEN4_REG_CPPMEMTGTERR, cppmemtgterr);
+
+	return reset_required;
+}
+
+static bool adf_handle_atufaultstatus(struct adf_accel_dev *accel_dev,
+				      void __iomem *csr, u32 errsou)
+{
+	u32 i;
+	u32 max_rp_num = GET_HW_DATA(accel_dev)->num_banks;
+
+	if (!(errsou & ADF_GEN4_ERRSOU3_ATUFAULTSTATUS_BIT))
+		return false;
+
+	for (i = 0; i < max_rp_num; i++) {
+		u32 atufaultstatus = ADF_CSR_RD(csr, ADF_GEN4_ATUFAULTSTATUS(i));
+
+		atufaultstatus &= ADF_GEN4_ATUFAULTSTATUS_BIT;
+
+		if (atufaultstatus) {
+			dev_err(&GET_DEV(accel_dev),
+				"Ring Pair (%u) ATU detected fault: 0x%x\n", i,
+				atufaultstatus);
+
+			ADF_CSR_WR(csr, ADF_GEN4_ATUFAULTSTATUS(i), atufaultstatus);
+		}
+	}
+
+	return false;
+}
+
+static void adf_gen4_process_errsou3(struct adf_accel_dev *accel_dev,
+				     void __iomem *csr, void __iomem *aram_csr,
+				     u32 errsou, bool *reset_required)
+{
+	*reset_required |= adf_handle_timiscsts(accel_dev, csr, errsou);
+	*reset_required |= adf_handle_ricppintsts(accel_dev, csr, errsou);
+	*reset_required |= adf_handle_ticppintsts(accel_dev, csr, errsou);
+	*reset_required |= adf_handle_aramcerr(accel_dev, aram_csr, errsou);
+	*reset_required |= adf_handle_aramuerr(accel_dev, aram_csr, errsou);
+	*reset_required |= adf_handle_reg_cppmemtgterr(accel_dev, aram_csr, errsou);
+	*reset_required |= adf_handle_atufaultstatus(accel_dev, csr, errsou);
+}
+
 static bool adf_gen4_handle_interrupt(struct adf_accel_dev *accel_dev,
 				      bool *reset_required)
 {
+	void __iomem *aram_csr = adf_get_aram_base(accel_dev);
 	void __iomem *csr = adf_get_pmisc_base(accel_dev);
 	u32 errsou = ADF_CSR_RD(csr, ADF_GEN4_ERRSOU0);
 	bool handled = false;
@@ -1148,6 +1398,12 @@ static bool adf_gen4_handle_interrupt(struct adf_accel_dev *accel_dev,
 		handled = true;
 	}
 
+	errsou = ADF_CSR_RD(csr, ADF_GEN4_ERRSOU3);
+	if (errsou & ADF_GEN4_ERRSOU3_BITMASK) {
+		adf_gen4_process_errsou3(accel_dev, csr, aram_csr, errsou, reset_required);
+		handled = true;
+	}
+
 	return handled;
 }
 
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.h b/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.h
index e3583c3ed827..53352083cd12 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.h
@@ -599,6 +599,224 @@ struct adf_ras_ops;
 
 #define ADF_GEN4_DCPR_SLICES_NUM			3
 
+/*
+ * ERRSOU3 bit masks
+ * BIT(0) - indicates error Response Order Overflow and/or BME error
+ * BIT(1) - indicates RI push/pull error
+ * BIT(2) - indicates TI push/pull error
+ * BIT(3) - indicates ARAM correctable error
+ * BIT(4) - indicates ARAM uncorrectable error
+ * BIT(5) - indicates TI pull parity error
+ * BIT(6) - indicates RI push parity error
+ * BIT(7) - indicates VFLR interrupt
+ * BIT(8) - indicates ring pair interrupts for ATU detected fault
+ * BIT(9) - indicates error when accessing RLT block
+ */
+#define ADF_GEN4_ERRSOU3_TIMISCSTS_BIT			BIT(0)
+#define ADF_GEN4_ERRSOU3_RICPPINTSTS_BITMASK		(BIT(1) | BIT(6))
+#define ADF_GEN4_ERRSOU3_TICPPINTSTS_BITMASK		(BIT(2) | BIT(5))
+#define ADF_GEN4_ERRSOU3_REG_ARAMCERR_BIT		BIT(3)
+#define ADF_GEN4_ERRSOU3_REG_ARAMUERR_BIT		BIT(4)
+#define ADF_GEN4_ERRSOU3_VFLRNOTIFY_BIT			BIT(7)
+#define ADF_GEN4_ERRSOU3_ATUFAULTSTATUS_BIT		BIT(8)
+#define ADF_GEN4_ERRSOU3_RLTERROR_BIT			BIT(9)
+
+#define ADF_GEN4_ERRSOU3_BITMASK ( \
+	(ADF_GEN4_ERRSOU3_TIMISCSTS_BIT) | \
+	(ADF_GEN4_ERRSOU3_RICPPINTSTS_BITMASK) | \
+	(ADF_GEN4_ERRSOU3_TICPPINTSTS_BITMASK) | \
+	(ADF_GEN4_ERRSOU3_REG_ARAMCERR_BIT) | \
+	(ADF_GEN4_ERRSOU3_REG_ARAMUERR_BIT) | \
+	(ADF_GEN4_ERRSOU3_VFLRNOTIFY_BIT) | \
+	(ADF_GEN4_ERRSOU3_ATUFAULTSTATUS_BIT) | \
+	(ADF_GEN4_ERRSOU3_RLTERROR_BIT))
+
+/* TI Misc status register */
+#define ADF_GEN4_TIMISCSTS				0x50054C
+
+/* TI Misc error reporting mask */
+#define ADF_GEN4_TIMISCCTL				0x500548
+
+/*
+ * TI Misc error reporting control mask
+ * BIT(0) - Enables error detection and logging in TIMISCSTS register
+ * BIT(1) - It has effect only when SRIOV enabled, this bit is 0 by default
+ * BIT(2) - Enables the D-F-x counter within the dispatch arbiter
+ *	    to start based on the command triggered from
+ * BIT(30) - Disables VFLR functionality
+ *	     By setting this bit will revert to CPM1.x functionality
+ * bits 1, 2 and 30 value should be preserved and not meant to be changed
+ * within RAS.
+ */
+#define ADF_GEN4_TIMISCCTL_BIT				BIT(0)
+#define ADF_GEN4_TIMSCCTL_RELAY_BITMASK (BIT(1) | BIT(2) | BIT(30))
+
+/* RI CPP interface status register */
+#define ADF_GEN4_RICPPINTSTS				0x41A330
+
+/*
+ * Uncorrectable error mask in RICPPINTSTS register
+ * BIT(0) - RI asserted the CPP error signal during a push
+ * BIT(1) - RI detected the CPP error signal asserted during a pull
+ * BIT(2) - RI detected a push data parity error
+ * BIT(3) - RI detected a push valid parity error
+ */
+#define ADF_GEN4_RICPPINTSTS_BITMASK \
+	(BIT(0) | BIT(1) | BIT(2) | BIT(3))
+
+/* RI CPP interface status register control */
+#define ADF_GEN4_RICPPINTCTL				0x41A32C
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
+ * BIT(4) - value of 1 enables the stop feature of the stop and stream
+ *	    for all RI CPP Command RFs
+ */
+#define ADF_GEN4_RICPPINTCTL_BITMASK \
+	(BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4))
+
+/* Push ID of the command which triggered the transaction error on RI */
+#define ADF_GEN4_RIERRPUSHID				0x41A334
+
+/* Pull ID of the command which triggered the transaction error on RI */
+#define ADF_GEN4_RIERRPULLID				0x41A338
+
+/* TI CPP interface status register */
+#define ADF_GEN4_TICPPINTSTS				0x50053C
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
+#define ADF_GEN4_TICPPINTSTS_BITMASK \
+	(BIT(0) | BIT(1) | BIT(2))
+
+/* TI CPP interface status register control */
+#define ADF_GEN4_TICPPINTCTL				0x500538
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
+ * BIT(4) - value of 1 enables TI stop part of stop and scream mode on
+ *	    CPP/RF Parity error
+ */
+#define ADF_GEN4_TICPPINTCTL_BITMASK \
+	(BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4))
+
+/* Push ID of the command which triggered the transaction error on TI */
+#define ADF_GEN4_TIERRPUSHID				0x500540
+
+/* Pull ID of the command which triggered the transaction error on TI */
+#define ADF_GEN4_TIERRPULLID				0x500544
+
+/* Correctable error in ARAM agent register */
+#define ADF_GEN4_REG_ARAMCERR				0x1700
+
+#define ADF_GEN4_REG_ARAMCERR_BIT			BIT(0)
+
+/*
+ * Correctable error enablement in ARAM bit mask
+ * BIT(3) - enable ARAM RAM to fix and log correctable error
+ * BIT(26) - enables ARAM agent to generate interrupt for correctable error
+ */
+#define ADF_GEN4_REG_ARAMCERR_EN_BITMASK		(BIT(3) | BIT(26))
+
+/* Correctable error address in ARAM agent register */
+#define ADF_GEN4_REG_ARAMCERRAD				0x1708
+
+/* Uncorrectable error in ARAM agent register */
+#define ADF_GEN4_REG_ARAMUERR				0x1704
+
+/*
+ * ARAM error bit mask
+ * BIT(0) - indicates error logged in ARAMCERR or ARAMUCERR
+ * BIT(18) - indicates uncorrectable multiple errors in ARAM agent
+ */
+#define ADF_GEN4_REG_ARAMUERR_ERROR_BIT			BIT(0)
+#define ADF_GEN4_REG_ARAMUERR_MULTI_ERRORS_BIT		BIT(18)
+
+/*
+ * Uncorrectable error enablement in ARAM bit mask
+ * BIT(3) - enable ARAM RAM to fix and log uncorrectable error
+ * BIT(19) - enables ARAM agent to generate interrupt for uncorrectable error
+ */
+#define ADF_GEN4_REG_ARAMUERR_EN_BITMASK		(BIT(3) | BIT(19))
+
+/* Unorrectable error address in ARAM agent register */
+#define ADF_GEN4_REG_ARAMUERRAD				0x170C
+
+/* Uncorrectable error transaction push/pull ID registers*/
+#define ADF_GEN4_REG_ERRPPID_LO				0x1714
+#define ADF_GEN4_REG_ERRPPID_HI				0x1718
+
+/* ARAM ECC block error enablement */
+#define ADF_GEN4_REG_ARAMCERRUERR_EN			0x1808
+
+/*
+ * ARAM ECC block error control bit masks
+ * BIT(0) - enable ARAM CD ECC block error detecting
+ * BIT(1) - enable ARAM pull request ECC error detecting
+ * BIT(2) - enable ARAM command dispatch ECC error detecting
+ * BIT(3) - enable ARAM read datapath push ECC error detecting
+ * BIT(4) - enable ARAM read datapath pull ECC error detecting
+ * BIT(5) - enable ARAM RMW ECC error detecting
+ * BIT(6) - enable ARAM write datapath RMW ECC error detecting
+ * BIT(7) - enable ARAM write datapath ECC error detecting
+ */
+#define ADF_GEN4_REG_ARAMCERRUERR_EN_BITMASK \
+	(BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | \
+	 BIT(5) | BIT(6) | BIT(7))
+
+/* ARAM misc memory target error registers*/
+#define ADF_GEN4_REG_CPPMEMTGTERR			0x1710
+
+/*
+ * ARAM misc memory target error bit masks
+ * BIT(0) - indicates an error in ARAM target memory
+ * BIT(1) - indicates multiple errors in ARAM target memory
+ * BIT(4) - indicates pull error in ARAM target memory
+ * BIT(5) - indicates parity pull error in ARAM target memory
+ * BIT(6) - indicates push error in ARAM target memory
+ */
+#define ADF_GEN4_REG_CPPMEMTGTERR_BITMASK \
+	(BIT(0) | BIT(4) | BIT(5) | BIT(6))
+
+#define ADF_GEN4_REG_CPPMEMTGTERR_MULTI_ERRORS_BIT	BIT(1)
+
+/*
+ * ARAM misc memory target error enablement mask
+ * BIT(2) - enables CPP memory to detect and log push/pull data error
+ * BIT(7) - enables push/pull error to generate interrupts to RI
+ * BIT(8) - enables ARAM to check parity on pull data and CPP command buses
+ * BIT(9) - enables ARAM to autopush to AE when push/parity error is detected
+ *	    on lookaside DT
+ */
+#define ADF_GEN4_REG_CPPMEMTGTERR_EN_BITMASK \
+	(BIT(2) | BIT(7) | BIT(8) | BIT(9))
+
+/* ATU fault status register */
+#define ADF_GEN4_ATUFAULTSTATUS(i)			(0x506000 + ((i) * 0x4))
+
+#define ADF_GEN4_ATUFAULTSTATUS_BIT			BIT(0)
+
 /* Command Parity error detected on IOSFP Command to QAT */
 #define ADF_GEN4_RIMISCSTS_BIT				BIT(0)
 
-- 
2.41.0


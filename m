Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11DB7D0D42
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Oct 2023 12:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376842AbjJTKfR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Oct 2023 06:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376812AbjJTKfN (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Oct 2023 06:35:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A5BD46
        for <linux-crypto@vger.kernel.org>; Fri, 20 Oct 2023 03:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697798105; x=1729334105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M8AYmR5gbAYI+7YD2yNky7PTEo575Ztb1XNyZapx4a8=;
  b=kby/51AsCI5U1S3IJ1az71r23EugOPScrdsN0J8idEmMqJzNODoyXFvv
   dxSIWr3ZtOnMyCGit+CljHdIprrntFiCFDRaVlWm/9duXVllsToC8SL+G
   Nqp06Y8a5s9MX2+9JwLFfl5CeBdM7c0/1WxrKddSTrvebrV1Fok/4gvPq
   zeRf269EaP2vvXRzK45iSezsOvfUjvQKX+XIOLheUWppyy3ljMJ76VkAE
   H4xffRD+NGXsGJI3UnTL89rWeUipi3o9jwWmI3pBBZLfoIWzpQnp3pGyP
   xxIsVmuwulxcPr0wYoG1kBAwOu9ePpqldwbd6ZZlT+L1W/RamERsaJqal
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="383686707"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="383686707"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 03:35:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="792369927"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="792369927"
Received: from fl31ca105gs0706.deacluster.intel.com (HELO fl31ca105gs0706..) ([10.45.133.167])
  by orsmga001.jf.intel.com with ESMTP; 20 Oct 2023 03:35:02 -0700
From:   Shashank Gupta <shashank.gupta@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Shashank Gupta <shashank.gupta@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Tero Kristo <tero.kristo@linux.intel.com>
Subject: [PATCH 4/9] crypto: qat - add handling of errors from ERRSOU2 for QAT GEN4
Date:   Fri, 20 Oct 2023 11:32:48 +0100
Message-ID: <20231020103431.230671-5-shashank.gupta@intel.com>
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
through the ERRSOU2 register in QAT GEN4 devices.

Signed-off-by: Shashank Gupta <shashank.gupta@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     |   5 +
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.h     |  15 +
 .../intel/qat/qat_common/adf_accel_devices.h  |   6 +
 .../intel/qat/qat_common/adf_gen4_ras.c       | 709 ++++++++++++++++++
 .../intel/qat/qat_common/adf_gen4_ras.h       | 320 ++++++++
 5 files changed, 1055 insertions(+)

diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
index 41a6c49e74ad..51db004641bf 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -479,6 +479,11 @@ static u32 uof_get_ae_mask(struct adf_accel_dev *accel_dev, u32 obj_num)
 static void adf_gen4_set_err_mask(struct adf_dev_err_mask *dev_err_mask)
 {
 	dev_err_mask->cppagentcmdpar_mask = ADF_4XXX_HICPPAGENTCMDPARERRLOG_MASK;
+	dev_err_mask->parerr_ath_cph_mask = ADF_4XXX_PARITYERRORMASK_ATH_CPH_MASK;
+	dev_err_mask->parerr_cpr_xlt_mask = ADF_4XXX_PARITYERRORMASK_CPR_XLT_MASK;
+	dev_err_mask->parerr_dcpr_ucs_mask = ADF_4XXX_PARITYERRORMASK_DCPR_UCS_MASK;
+	dev_err_mask->parerr_pke_mask = ADF_4XXX_PARITYERRORMASK_PKE_MASK;
+	dev_err_mask->ssmfeatren_mask = ADF_4XXX_SSMFEATREN_MASK;
 }
 
 void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data, u32 dev_id)
diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.h b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.h
index 7695b4e7277e..efd5dadc19ed 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.h
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.h
@@ -29,6 +29,21 @@
 #define ADF_4XXX_ADMIN_AE_MASK		(0x100)
 
 #define ADF_4XXX_HICPPAGENTCMDPARERRLOG_MASK	0x1F
+#define ADF_4XXX_PARITYERRORMASK_ATH_CPH_MASK	0xF000F
+#define ADF_4XXX_PARITYERRORMASK_CPR_XLT_MASK	0x10001
+#define ADF_4XXX_PARITYERRORMASK_DCPR_UCS_MASK	0x30007
+#define ADF_4XXX_PARITYERRORMASK_PKE_MASK	0x3F
+
+/*
+ * SSMFEATREN bit mask
+ * BIT(4) - enables parity detection on CPP
+ * BIT(12) - enables the logging of push/pull data errors
+ *	     in pperr register
+ * BIT(16) - BIT(23) - enable parity detection on SPPs
+ */
+#define ADF_4XXX_SSMFEATREN_MASK \
+	(BIT(4) | BIT(12) | BIT(16) | BIT(17) | BIT(18) | \
+	 BIT(19) | BIT(20) | BIT(21) | BIT(22) | BIT(23))
 
 #define ADF_4XXX_ETR_MAX_BANKS		64
 
diff --git a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
index ebdf9f7f4bc8..65d52a07e435 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
@@ -178,6 +178,12 @@ struct adf_dc_ops {
 
 struct adf_dev_err_mask {
 	u32 cppagentcmdpar_mask;
+	u32 parerr_ath_cph_mask;
+	u32 parerr_cpr_xlt_mask;
+	u32 parerr_dcpr_ucs_mask;
+	u32 parerr_pke_mask;
+	u32 parerr_wat_wcp_mask;
+	u32 ssmfeatren_mask;
 };
 
 struct adf_hw_device_data {
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c
index 59ae5a574091..877abed683d8 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c
@@ -11,15 +11,30 @@ static void enable_errsou_reporting(void __iomem *csr)
 
 	/* Enable uncorrectable error reporting in ERRSOU1 */
 	ADF_CSR_WR(csr, ADF_GEN4_ERRMSK1, 0);
+
+	/*
+	 * Enable uncorrectable error reporting in ERRSOU2
+	 * but disable PM interrupt and CFC attention interrupt by default
+	 */
+	ADF_CSR_WR(csr, ADF_GEN4_ERRMSK2,
+		   ADF_GEN4_ERRSOU2_PM_INT_BIT |
+		   ADF_GEN4_ERRSOU2_CPP_CFC_ATT_INT_BITMASK);
 }
 
 static void disable_errsou_reporting(void __iomem *csr)
 {
+	u32 val = 0;
+
 	/* Disable correctable error reporting in ERRSOU0 */
 	ADF_CSR_WR(csr, ADF_GEN4_ERRMSK0, ADF_GEN4_ERRSOU0_BIT);
 
 	/* Disable uncorrectable error reporting in ERRSOU1 */
 	ADF_CSR_WR(csr, ADF_GEN4_ERRMSK1, ADF_GEN4_ERRSOU1_BITMASK);
+
+	/* Disable uncorrectable error reporting in ERRSOU2 */
+	val = ADF_CSR_RD(csr, ADF_GEN4_ERRMSK2);
+	val |= ADF_GEN4_ERRSOU2_DIS_BITMASK;
+	ADF_CSR_WR(csr, ADF_GEN4_ERRMSK2, val);
 }
 
 static void enable_ae_error_reporting(struct adf_accel_dev *accel_dev,
@@ -51,12 +66,18 @@ static void enable_cpp_error_reporting(struct adf_accel_dev *accel_dev,
 	/* Enable HI CPP Agents Command Parity Error Reporting */
 	ADF_CSR_WR(csr, ADF_GEN4_HICPPAGENTCMDPARERRLOGENABLE,
 		   err_mask->cppagentcmdpar_mask);
+
+	ADF_CSR_WR(csr, ADF_GEN4_CPP_CFC_ERR_CTRL,
+		   ADF_GEN4_CPP_CFC_ERR_CTRL_BITMASK);
 }
 
 static void disable_cpp_error_reporting(void __iomem *csr)
 {
 	/* Disable HI CPP Agents Command Parity Error Reporting */
 	ADF_CSR_WR(csr, ADF_GEN4_HICPPAGENTCMDPARERRLOGENABLE, 0);
+
+	ADF_CSR_WR(csr, ADF_GEN4_CPP_CFC_ERR_CTRL,
+		   ADF_GEN4_CPP_CFC_ERR_CTRL_DIS_BITMASK);
 }
 
 static void enable_ti_ri_error_reporting(void __iomem *csr)
@@ -98,6 +119,138 @@ static void disable_ti_ri_error_reporting(void __iomem *csr)
 		   ADF_GEN4_TI_TRNSB_PAR_STS_BITMASK);
 }
 
+static void enable_rf_error_reporting(struct adf_accel_dev *accel_dev,
+				      void __iomem *csr)
+{
+	struct adf_dev_err_mask *err_mask = GET_ERR_MASK(accel_dev);
+
+	/* Enable RF parity error in Shared RAM */
+	ADF_CSR_WR(csr, ADF_GEN4_SSMSOFTERRORPARITYMASK_SRC, 0);
+	ADF_CSR_WR(csr, ADF_GEN4_SSMSOFTERRORPARITYMASK_ATH_CPH, 0);
+	ADF_CSR_WR(csr, ADF_GEN4_SSMSOFTERRORPARITYMASK_CPR_XLT, 0);
+	ADF_CSR_WR(csr, ADF_GEN4_SSMSOFTERRORPARITYMASK_DCPR_UCS, 0);
+	ADF_CSR_WR(csr, ADF_GEN4_SSMSOFTERRORPARITYMASK_PKE, 0);
+
+	if (err_mask->parerr_wat_wcp_mask)
+		ADF_CSR_WR(csr, ADF_GEN4_SSMSOFTERRORPARITYMASK_WAT_WCP, 0);
+}
+
+static void disable_rf_error_reporting(struct adf_accel_dev *accel_dev,
+				       void __iomem *csr)
+{
+	struct adf_dev_err_mask *err_mask = GET_ERR_MASK(accel_dev);
+
+	/* Disable RF Parity Error reporting in Shared RAM */
+	ADF_CSR_WR(csr, ADF_GEN4_SSMSOFTERRORPARITYMASK_SRC,
+		   ADF_GEN4_SSMSOFTERRORPARITY_SRC_BIT);
+
+	ADF_CSR_WR(csr, ADF_GEN4_SSMSOFTERRORPARITYMASK_ATH_CPH,
+		   err_mask->parerr_ath_cph_mask);
+
+	ADF_CSR_WR(csr, ADF_GEN4_SSMSOFTERRORPARITYMASK_CPR_XLT,
+		   err_mask->parerr_cpr_xlt_mask);
+
+	ADF_CSR_WR(csr, ADF_GEN4_SSMSOFTERRORPARITYMASK_DCPR_UCS,
+		   err_mask->parerr_dcpr_ucs_mask);
+
+	ADF_CSR_WR(csr, ADF_GEN4_SSMSOFTERRORPARITYMASK_PKE,
+		   err_mask->parerr_pke_mask);
+
+	if (err_mask->parerr_wat_wcp_mask)
+		ADF_CSR_WR(csr, ADF_GEN4_SSMSOFTERRORPARITYMASK_WAT_WCP,
+			   err_mask->parerr_wat_wcp_mask);
+}
+
+static void enable_ssm_error_reporting(struct adf_accel_dev *accel_dev,
+				       void __iomem *csr)
+{
+	struct adf_dev_err_mask *err_mask = GET_ERR_MASK(accel_dev);
+	u32 val = 0;
+
+	/* Enable SSM interrupts */
+	ADF_CSR_WR(csr, ADF_GEN4_INTMASKSSM, 0);
+
+	/* Enable shared memory error detection & correction */
+	val = ADF_CSR_RD(csr, ADF_GEN4_SSMFEATREN);
+	val |= err_mask->ssmfeatren_mask;
+	ADF_CSR_WR(csr, ADF_GEN4_SSMFEATREN, val);
+
+	/* Enable SER detection in SER_err_ssmsh register */
+	ADF_CSR_WR(csr, ADF_GEN4_SER_EN_SSMSH,
+		   ADF_GEN4_SER_EN_SSMSH_BITMASK);
+
+	/* Enable SSM soft parity error */
+	ADF_CSR_WR(csr, ADF_GEN4_SPPPARERRMSK_ATH_CPH, 0);
+	ADF_CSR_WR(csr, ADF_GEN4_SPPPARERRMSK_CPR_XLT, 0);
+	ADF_CSR_WR(csr, ADF_GEN4_SPPPARERRMSK_DCPR_UCS, 0);
+	ADF_CSR_WR(csr, ADF_GEN4_SPPPARERRMSK_PKE, 0);
+
+	if (err_mask->parerr_wat_wcp_mask)
+		ADF_CSR_WR(csr, ADF_GEN4_SPPPARERRMSK_WAT_WCP, 0);
+
+	/* Enable slice hang interrupt reporting */
+	ADF_CSR_WR(csr, ADF_GEN4_SHINTMASKSSM_ATH_CPH, 0);
+	ADF_CSR_WR(csr, ADF_GEN4_SHINTMASKSSM_CPR_XLT, 0);
+	ADF_CSR_WR(csr, ADF_GEN4_SHINTMASKSSM_DCPR_UCS, 0);
+	ADF_CSR_WR(csr, ADF_GEN4_SHINTMASKSSM_PKE, 0);
+
+	if (err_mask->parerr_wat_wcp_mask)
+		ADF_CSR_WR(csr, ADF_GEN4_SHINTMASKSSM_WAT_WCP, 0);
+}
+
+static void disable_ssm_error_reporting(struct adf_accel_dev *accel_dev,
+					void __iomem *csr)
+{
+	struct adf_dev_err_mask *err_mask = GET_ERR_MASK(accel_dev);
+	u32 val = 0;
+
+	/* Disable SSM interrupts */
+	ADF_CSR_WR(csr, ADF_GEN4_INTMASKSSM,
+		   ADF_GEN4_INTMASKSSM_BITMASK);
+
+	/* Disable shared memory error detection & correction */
+	val = ADF_CSR_RD(csr, ADF_GEN4_SSMFEATREN);
+	val &= ADF_GEN4_SSMFEATREN_DIS_BITMASK;
+	ADF_CSR_WR(csr, ADF_GEN4_SSMFEATREN, val);
+
+	/* Disable SER detection in SER_err_ssmsh register */
+	ADF_CSR_WR(csr, ADF_GEN4_SER_EN_SSMSH, 0);
+
+	/* Disable SSM soft parity error */
+	ADF_CSR_WR(csr, ADF_GEN4_SPPPARERRMSK_ATH_CPH,
+		   err_mask->parerr_ath_cph_mask);
+
+	ADF_CSR_WR(csr, ADF_GEN4_SPPPARERRMSK_CPR_XLT,
+		   err_mask->parerr_cpr_xlt_mask);
+
+	ADF_CSR_WR(csr, ADF_GEN4_SPPPARERRMSK_DCPR_UCS,
+		   err_mask->parerr_dcpr_ucs_mask);
+
+	ADF_CSR_WR(csr, ADF_GEN4_SPPPARERRMSK_PKE,
+		   err_mask->parerr_pke_mask);
+
+	if (err_mask->parerr_wat_wcp_mask)
+		ADF_CSR_WR(csr, ADF_GEN4_SPPPARERRMSK_WAT_WCP,
+			   err_mask->parerr_wat_wcp_mask);
+
+	/* Disable slice hang interrupt reporting */
+	ADF_CSR_WR(csr, ADF_GEN4_SHINTMASKSSM_ATH_CPH,
+		   err_mask->parerr_ath_cph_mask);
+
+	ADF_CSR_WR(csr, ADF_GEN4_SHINTMASKSSM_CPR_XLT,
+		   err_mask->parerr_cpr_xlt_mask);
+
+	ADF_CSR_WR(csr, ADF_GEN4_SHINTMASKSSM_DCPR_UCS,
+		   err_mask->parerr_dcpr_ucs_mask);
+
+	ADF_CSR_WR(csr, ADF_GEN4_SHINTMASKSSM_PKE,
+		   err_mask->parerr_pke_mask);
+
+	if (err_mask->parerr_wat_wcp_mask)
+		ADF_CSR_WR(csr, ADF_GEN4_SHINTMASKSSM_WAT_WCP,
+			   err_mask->parerr_wat_wcp_mask);
+}
+
 static void adf_gen4_enable_ras(struct adf_accel_dev *accel_dev)
 {
 	void __iomem *csr = adf_get_pmisc_base(accel_dev);
@@ -106,6 +259,8 @@ static void adf_gen4_enable_ras(struct adf_accel_dev *accel_dev)
 	enable_ae_error_reporting(accel_dev, csr);
 	enable_cpp_error_reporting(accel_dev, csr);
 	enable_ti_ri_error_reporting(csr);
+	enable_rf_error_reporting(accel_dev, csr);
+	enable_ssm_error_reporting(accel_dev, csr);
 }
 
 static void adf_gen4_disable_ras(struct adf_accel_dev *accel_dev)
@@ -116,6 +271,8 @@ static void adf_gen4_disable_ras(struct adf_accel_dev *accel_dev)
 	disable_ae_error_reporting(csr);
 	disable_cpp_error_reporting(csr);
 	disable_ti_ri_error_reporting(csr);
+	disable_rf_error_reporting(accel_dev, csr);
+	disable_ssm_error_reporting(accel_dev, csr);
 }
 
 static void adf_gen4_process_errsou0(struct adf_accel_dev *accel_dev,
@@ -345,6 +502,552 @@ static void adf_gen4_process_errsou1(struct adf_accel_dev *accel_dev,
 	*reset_required |= adf_handle_iosfp_cmd_parerr(accel_dev, csr, errsou);
 }
 
+static bool adf_handle_uerrssmsh(struct adf_accel_dev *accel_dev,
+				 void __iomem *csr, u32 iastatssm)
+{
+	u32 reg;
+
+	if (!(iastatssm & ADF_GEN4_IAINTSTATSSM_UERRSSMSH_BIT))
+		return false;
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_UERRSSMSH);
+	reg &= ADF_GEN4_UERRSSMSH_BITMASK;
+
+	dev_err(&GET_DEV(accel_dev),
+		"Uncorrectable error on ssm shared memory: 0x%x\n",
+		reg);
+
+	ADF_CSR_WR(csr, ADF_GEN4_UERRSSMSH, reg);
+
+	return false;
+}
+
+static bool adf_handle_cerrssmsh(struct adf_accel_dev *accel_dev,
+				 void __iomem *csr, u32 iastatssm)
+{
+	u32 reg;
+
+	if (!(iastatssm & ADF_GEN4_IAINTSTATSSM_CERRSSMSH_BIT))
+		return false;
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_CERRSSMSH);
+	reg &= ADF_GEN4_CERRSSMSH_ERROR_BIT;
+
+	dev_warn(&GET_DEV(accel_dev),
+		 "Correctable error on ssm shared memory: 0x%x\n",
+		 reg);
+
+	ADF_CSR_WR(csr, ADF_GEN4_CERRSSMSH, reg);
+
+	return false;
+}
+
+static bool adf_handle_pperr_err(struct adf_accel_dev *accel_dev,
+				 void __iomem *csr, u32 iastatssm)
+{
+	u32 reg;
+
+	if (!(iastatssm & ADF_GEN4_IAINTSTATSSM_PPERR_BIT))
+		return false;
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_PPERR);
+	reg &= ADF_GEN4_PPERR_BITMASK;
+
+	dev_err(&GET_DEV(accel_dev),
+		"Uncorrectable error CPP transaction on memory target: 0x%x\n",
+		reg);
+
+	ADF_CSR_WR(csr, ADF_GEN4_PPERR, reg);
+
+	return false;
+}
+
+static void adf_poll_slicehang_csr(struct adf_accel_dev *accel_dev,
+				   void __iomem *csr, u32 slice_hang_offset,
+				   char *slice_name)
+{
+	u32 slice_hang_reg = ADF_CSR_RD(csr, slice_hang_offset);
+
+	if (!slice_hang_reg)
+		return;
+
+	dev_err(&GET_DEV(accel_dev),
+		"Slice %s hang error encountered\n", slice_name);
+}
+
+static bool adf_handle_slice_hang_error(struct adf_accel_dev *accel_dev,
+					void __iomem *csr, u32 iastatssm)
+{
+	struct adf_dev_err_mask *err_mask = GET_ERR_MASK(accel_dev);
+
+	if (!(iastatssm & ADF_GEN4_IAINTSTATSSM_SLICEHANG_ERR_BIT))
+		return false;
+
+	adf_poll_slicehang_csr(accel_dev, csr,
+			       ADF_GEN4_SLICEHANGSTATUS_ATH_CPH, "ath_cph");
+	adf_poll_slicehang_csr(accel_dev, csr,
+			       ADF_GEN4_SLICEHANGSTATUS_CPR_XLT, "cpr_xlt");
+	adf_poll_slicehang_csr(accel_dev, csr,
+			       ADF_GEN4_SLICEHANGSTATUS_DCPR_UCS, "dcpr_ucs");
+	adf_poll_slicehang_csr(accel_dev, csr,
+			       ADF_GEN4_SLICEHANGSTATUS_PKE, "pke");
+
+	if (err_mask->parerr_wat_wcp_mask)
+		adf_poll_slicehang_csr(accel_dev, csr,
+				       ADF_GEN4_SLICEHANGSTATUS_WAT_WCP,
+				       "ath_cph");
+
+	return false;
+}
+
+static bool adf_handle_spp_pullcmd_err(struct adf_accel_dev *accel_dev,
+				       void __iomem *csr)
+{
+	struct adf_dev_err_mask *err_mask = GET_ERR_MASK(accel_dev);
+	bool reset_required = false;
+	u32 reg;
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_SPPPULLCMDPARERR_ATH_CPH);
+	reg &= err_mask->parerr_ath_cph_mask;
+	if (reg) {
+		dev_err(&GET_DEV(accel_dev),
+			"SPP pull command fatal error ATH_CPH: 0x%x\n", reg);
+
+		ADF_CSR_WR(csr, ADF_GEN4_SPPPULLCMDPARERR_ATH_CPH, reg);
+
+		reset_required = true;
+	}
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_SPPPULLCMDPARERR_CPR_XLT);
+	reg &= err_mask->parerr_cpr_xlt_mask;
+	if (reg) {
+		dev_err(&GET_DEV(accel_dev),
+			"SPP pull command fatal error CPR_XLT: 0x%x\n", reg);
+
+		ADF_CSR_WR(csr, ADF_GEN4_SPPPULLCMDPARERR_CPR_XLT, reg);
+
+		reset_required = true;
+	}
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_SPPPULLCMDPARERR_DCPR_UCS);
+	reg &= err_mask->parerr_dcpr_ucs_mask;
+	if (reg) {
+		dev_err(&GET_DEV(accel_dev),
+			"SPP pull command fatal error DCPR_UCS: 0x%x\n", reg);
+
+		ADF_CSR_WR(csr, ADF_GEN4_SPPPULLCMDPARERR_DCPR_UCS, reg);
+
+		reset_required = true;
+	}
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_SPPPULLCMDPARERR_PKE);
+	reg &= err_mask->parerr_pke_mask;
+	if (reg) {
+		dev_err(&GET_DEV(accel_dev),
+			"SPP pull command fatal error PKE: 0x%x\n", reg);
+
+		ADF_CSR_WR(csr, ADF_GEN4_SPPPULLCMDPARERR_PKE, reg);
+
+		reset_required = true;
+	}
+
+	if (err_mask->parerr_wat_wcp_mask) {
+		reg = ADF_CSR_RD(csr, ADF_GEN4_SPPPULLCMDPARERR_WAT_WCP);
+		reg &= err_mask->parerr_wat_wcp_mask;
+		if (reg) {
+			dev_err(&GET_DEV(accel_dev),
+				"SPP pull command fatal error WAT_WCP: 0x%x\n", reg);
+
+			ADF_CSR_WR(csr, ADF_GEN4_SPPPULLCMDPARERR_WAT_WCP, reg);
+
+			reset_required = true;
+		}
+	}
+
+	return reset_required;
+}
+
+static bool adf_handle_spp_pulldata_err(struct adf_accel_dev *accel_dev,
+					void __iomem *csr)
+{
+	struct adf_dev_err_mask *err_mask = GET_ERR_MASK(accel_dev);
+	u32 reg;
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_SPPPULLDATAPARERR_ATH_CPH);
+	reg &= err_mask->parerr_ath_cph_mask;
+	if (reg) {
+		dev_err(&GET_DEV(accel_dev),
+			"SPP pull data err ATH_CPH: 0x%x\n", reg);
+
+		ADF_CSR_WR(csr, ADF_GEN4_SPPPULLDATAPARERR_ATH_CPH, reg);
+	}
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_SPPPULLDATAPARERR_CPR_XLT);
+	reg &= err_mask->parerr_cpr_xlt_mask;
+	if (reg) {
+		dev_err(&GET_DEV(accel_dev),
+			"SPP pull data err CPR_XLT: 0x%x\n", reg);
+
+		ADF_CSR_WR(csr, ADF_GEN4_SPPPULLDATAPARERR_CPR_XLT, reg);
+	}
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_SPPPULLDATAPARERR_DCPR_UCS);
+	reg &= err_mask->parerr_dcpr_ucs_mask;
+	if (reg) {
+		dev_err(&GET_DEV(accel_dev),
+			"SPP pull data err DCPR_UCS: 0x%x\n", reg);
+
+		ADF_CSR_WR(csr, ADF_GEN4_SPPPULLDATAPARERR_DCPR_UCS, reg);
+	}
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_SPPPULLDATAPARERR_PKE);
+	reg &= err_mask->parerr_pke_mask;
+	if (reg) {
+		dev_err(&GET_DEV(accel_dev),
+			"SPP pull data err PKE: 0x%x\n", reg);
+
+		ADF_CSR_WR(csr, ADF_GEN4_SPPPULLDATAPARERR_PKE, reg);
+	}
+
+	if (err_mask->parerr_wat_wcp_mask) {
+		reg = ADF_CSR_RD(csr, ADF_GEN4_SPPPULLDATAPARERR_WAT_WCP);
+		reg &= err_mask->parerr_wat_wcp_mask;
+		if (reg) {
+			dev_err(&GET_DEV(accel_dev),
+				"SPP pull data err WAT_WCP: 0x%x\n", reg);
+
+			ADF_CSR_WR(csr, ADF_GEN4_SPPPULLDATAPARERR_WAT_WCP, reg);
+		}
+	}
+
+	return false;
+}
+
+static bool adf_handle_spp_pushcmd_err(struct adf_accel_dev *accel_dev,
+				       void __iomem *csr)
+{
+	struct adf_dev_err_mask *err_mask = GET_ERR_MASK(accel_dev);
+	bool reset_required = false;
+	u32 reg;
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_SPPPUSHCMDPARERR_ATH_CPH);
+	reg &= err_mask->parerr_ath_cph_mask;
+	if (reg) {
+		dev_err(&GET_DEV(accel_dev),
+			"SPP push command fatal error ATH_CPH: 0x%x\n", reg);
+
+		ADF_CSR_WR(csr, ADF_GEN4_SPPPUSHCMDPARERR_ATH_CPH, reg);
+
+		reset_required = true;
+	}
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_SPPPUSHCMDPARERR_CPR_XLT);
+	reg &= err_mask->parerr_cpr_xlt_mask;
+	if (reg) {
+		dev_err(&GET_DEV(accel_dev),
+			"SPP push command fatal error CPR_XLT: 0x%x\n", reg);
+
+		ADF_CSR_WR(csr, ADF_GEN4_SPPPUSHCMDPARERR_CPR_XLT, reg);
+
+		reset_required = true;
+	}
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_SPPPUSHCMDPARERR_DCPR_UCS);
+	reg &= err_mask->parerr_dcpr_ucs_mask;
+	if (reg) {
+		dev_err(&GET_DEV(accel_dev),
+			"SPP push command fatal error DCPR_UCS: 0x%x\n", reg);
+
+		ADF_CSR_WR(csr, ADF_GEN4_SPPPUSHCMDPARERR_DCPR_UCS, reg);
+
+		reset_required = true;
+	}
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_SPPPUSHCMDPARERR_PKE);
+	reg &= err_mask->parerr_pke_mask;
+	if (reg) {
+		dev_err(&GET_DEV(accel_dev),
+			"SPP push command fatal error PKE: 0x%x\n",
+			reg);
+
+		ADF_CSR_WR(csr, ADF_GEN4_SPPPUSHCMDPARERR_PKE, reg);
+
+		reset_required = true;
+	}
+
+	if (err_mask->parerr_wat_wcp_mask) {
+		reg = ADF_CSR_RD(csr, ADF_GEN4_SPPPUSHCMDPARERR_WAT_WCP);
+		reg &= err_mask->parerr_wat_wcp_mask;
+		if (reg) {
+			dev_err(&GET_DEV(accel_dev),
+				"SPP push command fatal error WAT_WCP: 0x%x\n", reg);
+
+			ADF_CSR_WR(csr, ADF_GEN4_SPPPUSHCMDPARERR_WAT_WCP, reg);
+
+			reset_required = true;
+		}
+	}
+
+	return reset_required;
+}
+
+static bool adf_handle_spp_pushdata_err(struct adf_accel_dev *accel_dev,
+					void __iomem *csr)
+{
+	struct adf_dev_err_mask *err_mask = GET_ERR_MASK(accel_dev);
+	u32 reg;
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_SPPPUSHDATAPARERR_ATH_CPH);
+	reg &= err_mask->parerr_ath_cph_mask;
+	if (reg) {
+		dev_err(&GET_DEV(accel_dev),
+			"SPP push data err ATH_CPH: 0x%x\n", reg);
+
+		ADF_CSR_WR(csr, ADF_GEN4_SPPPUSHDATAPARERR_ATH_CPH, reg);
+	}
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_SPPPUSHDATAPARERR_CPR_XLT);
+	reg &= err_mask->parerr_cpr_xlt_mask;
+	if (reg) {
+		dev_err(&GET_DEV(accel_dev),
+			"SPP push data err CPR_XLT: 0x%x\n", reg);
+
+		ADF_CSR_WR(csr, ADF_GEN4_SPPPUSHDATAPARERR_CPR_XLT, reg);
+	}
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_SPPPUSHDATAPARERR_DCPR_UCS);
+	reg &= err_mask->parerr_dcpr_ucs_mask;
+	if (reg) {
+		dev_err(&GET_DEV(accel_dev),
+			"SPP push data err DCPR_UCS: 0x%x\n", reg);
+
+		ADF_CSR_WR(csr, ADF_GEN4_SPPPUSHDATAPARERR_DCPR_UCS, reg);
+	}
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_SPPPUSHDATAPARERR_PKE);
+	reg &= err_mask->parerr_pke_mask;
+	if (reg) {
+		dev_err(&GET_DEV(accel_dev),
+			"SPP push data err PKE: 0x%x\n", reg);
+
+		ADF_CSR_WR(csr, ADF_GEN4_SPPPUSHDATAPARERR_PKE, reg);
+	}
+
+	if (err_mask->parerr_wat_wcp_mask) {
+		reg = ADF_CSR_RD(csr, ADF_GEN4_SPPPUSHDATAPARERR_WAT_WCP);
+		reg &= err_mask->parerr_wat_wcp_mask;
+		if (reg) {
+			dev_err(&GET_DEV(accel_dev),
+				"SPP push data err WAT_WCP: 0x%x\n", reg);
+
+			ADF_CSR_WR(csr, ADF_GEN4_SPPPUSHDATAPARERR_WAT_WCP,
+				   reg);
+		}
+	}
+
+	return false;
+}
+
+static bool adf_handle_spppar_err(struct adf_accel_dev *accel_dev,
+				  void __iomem *csr, u32 iastatssm)
+{
+	bool reset_required;
+
+	if (!(iastatssm & ADF_GEN4_IAINTSTATSSM_SPPPARERR_BIT))
+		return false;
+
+	reset_required = adf_handle_spp_pullcmd_err(accel_dev, csr);
+	reset_required |= adf_handle_spp_pulldata_err(accel_dev, csr);
+	reset_required |= adf_handle_spp_pushcmd_err(accel_dev, csr);
+	reset_required |= adf_handle_spp_pushdata_err(accel_dev, csr);
+
+	return reset_required;
+}
+
+static bool adf_handle_ssmcpppar_err(struct adf_accel_dev *accel_dev,
+				     void __iomem *csr, u32 iastatssm)
+{
+	bool reset_required = false;
+	u32 reg;
+
+	if (!(iastatssm & ADF_GEN4_IAINTSTATSSM_SSMCPPERR_BIT))
+		return false;
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_SSMCPPERR);
+	reg &= ADF_GEN4_SSMCPPERR_FATAL_BITMASK | ADF_GEN4_SSMCPPERR_UNCERR_BITMASK;
+	if (reg & ADF_GEN4_SSMCPPERR_FATAL_BITMASK) {
+		dev_err(&GET_DEV(accel_dev),
+			"Fatal SSM CPP parity error: 0x%x\n", reg);
+
+		reset_required = true;
+	}
+
+	if (reg & ADF_GEN4_SSMCPPERR_UNCERR_BITMASK)
+		dev_err(&GET_DEV(accel_dev),
+			"non-Fatal SSM CPP parity error: 0x%x\n", reg);
+
+	ADF_CSR_WR(csr, ADF_GEN4_SSMCPPERR, reg);
+
+	return reset_required;
+}
+
+static bool adf_handle_rf_parr_err(struct adf_accel_dev *accel_dev,
+				   void __iomem *csr, u32 iastatssm)
+{
+	struct adf_dev_err_mask *err_mask = GET_ERR_MASK(accel_dev);
+	u32 reg;
+
+	if (!(iastatssm & ADF_GEN4_IAINTSTATSSM_SSMSOFTERRORPARITY_BIT))
+		return false;
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_SSMSOFTERRORPARITY_SRC);
+	reg &= ADF_GEN4_SSMSOFTERRORPARITY_SRC_BIT;
+	if (reg)
+		ADF_CSR_WR(csr, ADF_GEN4_SSMSOFTERRORPARITY_SRC, reg);
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_SSMSOFTERRORPARITY_ATH_CPH);
+	reg &= err_mask->parerr_ath_cph_mask;
+	if (reg)
+		ADF_CSR_WR(csr, ADF_GEN4_SSMSOFTERRORPARITY_ATH_CPH, reg);
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_SSMSOFTERRORPARITY_CPR_XLT);
+	reg &= err_mask->parerr_cpr_xlt_mask;
+	if (reg)
+		ADF_CSR_WR(csr, ADF_GEN4_SSMSOFTERRORPARITY_CPR_XLT, reg);
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_SSMSOFTERRORPARITY_DCPR_UCS);
+	reg &= err_mask->parerr_dcpr_ucs_mask;
+	if (reg)
+		ADF_CSR_WR(csr, ADF_GEN4_SSMSOFTERRORPARITY_DCPR_UCS, reg);
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_SSMSOFTERRORPARITY_PKE);
+	reg &= err_mask->parerr_pke_mask;
+	if (reg)
+		ADF_CSR_WR(csr, ADF_GEN4_SSMSOFTERRORPARITY_PKE, reg);
+
+	if (err_mask->parerr_wat_wcp_mask) {
+		reg = ADF_CSR_RD(csr, ADF_GEN4_SSMSOFTERRORPARITY_WAT_WCP);
+		reg &= err_mask->parerr_wat_wcp_mask;
+		if (reg)
+			ADF_CSR_WR(csr, ADF_GEN4_SSMSOFTERRORPARITY_WAT_WCP,
+				   reg);
+	}
+
+	dev_err(&GET_DEV(accel_dev), "Slice ssm soft parity error reported");
+
+	return false;
+}
+
+static bool adf_handle_ser_err_ssmsh(struct adf_accel_dev *accel_dev,
+				     void __iomem *csr, u32 iastatssm)
+{
+	bool reset_required = false;
+	u32 reg;
+
+	if (!(iastatssm & (ADF_GEN4_IAINTSTATSSM_SER_ERR_SSMSH_CERR_BIT |
+			 ADF_GEN4_IAINTSTATSSM_SER_ERR_SSMSH_UNCERR_BIT)))
+		return false;
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_SER_ERR_SSMSH);
+	reg &= ADF_GEN4_SER_ERR_SSMSH_FATAL_BITMASK |
+	       ADF_GEN4_SER_ERR_SSMSH_UNCERR_BITMASK |
+	       ADF_GEN4_SER_ERR_SSMSH_CERR_BITMASK;
+	if (reg & ADF_GEN4_SER_ERR_SSMSH_FATAL_BITMASK) {
+		dev_err(&GET_DEV(accel_dev),
+			"Fatal SER_SSMSH_ERR: 0x%x\n", reg);
+
+		reset_required = true;
+	}
+
+	if (reg & ADF_GEN4_SER_ERR_SSMSH_UNCERR_BITMASK)
+		dev_err(&GET_DEV(accel_dev),
+			"non-fatal SER_SSMSH_ERR: 0x%x\n", reg);
+
+	if (reg & ADF_GEN4_SER_ERR_SSMSH_CERR_BITMASK)
+		dev_warn(&GET_DEV(accel_dev),
+			 "Correctable SER_SSMSH_ERR: 0x%x\n", reg);
+
+	ADF_CSR_WR(csr, ADF_GEN4_SER_ERR_SSMSH, reg);
+
+	return reset_required;
+}
+
+static bool adf_handle_iaintstatssm(struct adf_accel_dev *accel_dev,
+				    void __iomem *csr)
+{
+	u32 iastatssm = ADF_CSR_RD(csr, ADF_GEN4_IAINTSTATSSM);
+	bool reset_required;
+
+	iastatssm &= ADF_GEN4_IAINTSTATSSM_BITMASK;
+	if (!iastatssm)
+		return false;
+
+	reset_required = adf_handle_uerrssmsh(accel_dev, csr, iastatssm);
+	reset_required |= adf_handle_cerrssmsh(accel_dev, csr, iastatssm);
+	reset_required |= adf_handle_pperr_err(accel_dev, csr, iastatssm);
+	reset_required |= adf_handle_slice_hang_error(accel_dev, csr, iastatssm);
+	reset_required |= adf_handle_spppar_err(accel_dev, csr, iastatssm);
+	reset_required |= adf_handle_ssmcpppar_err(accel_dev, csr, iastatssm);
+	reset_required |= adf_handle_rf_parr_err(accel_dev, csr, iastatssm);
+	reset_required |= adf_handle_ser_err_ssmsh(accel_dev, csr, iastatssm);
+
+	ADF_CSR_WR(csr, ADF_GEN4_IAINTSTATSSM, iastatssm);
+
+	return reset_required;
+}
+
+static bool adf_handle_ssm(struct adf_accel_dev *accel_dev, void __iomem *csr,
+			   u32 errsou)
+{
+	if (!(errsou & ADF_GEN4_ERRSOU2_SSM_ERR_BIT))
+		return false;
+
+	return adf_handle_iaintstatssm(accel_dev, csr);
+}
+
+static bool adf_handle_cpp_cfc_err(struct adf_accel_dev *accel_dev,
+				   void __iomem *csr, u32 errsou)
+{
+	bool reset_required = false;
+	u32 reg;
+
+	if (!(errsou & ADF_GEN4_ERRSOU2_CPP_CFC_ERR_STATUS_BIT))
+		return false;
+
+	reg = ADF_CSR_RD(csr, ADF_GEN4_CPP_CFC_ERR_STATUS);
+	if (reg & ADF_GEN4_CPP_CFC_ERR_STATUS_DATAPAR_BIT) {
+		dev_err(&GET_DEV(accel_dev),
+			"CPP_CFC_ERR: data parity: 0x%x", reg);
+	}
+
+	if (reg & ADF_GEN4_CPP_CFC_ERR_STATUS_CMDPAR_BIT) {
+		dev_err(&GET_DEV(accel_dev),
+			"CPP_CFC_ERR: command parity: 0x%x", reg);
+
+		reset_required = true;
+	}
+
+	if (reg & ADF_GEN4_CPP_CFC_ERR_STATUS_MERR_BIT) {
+		dev_err(&GET_DEV(accel_dev),
+			"CPP_CFC_ERR: multiple errors: 0x%x", reg);
+
+		reset_required = true;
+	}
+
+	ADF_CSR_WR(csr, ADF_GEN4_CPP_CFC_ERR_STATUS_CLR,
+		   ADF_GEN4_CPP_CFC_ERR_STATUS_CLR_BITMASK);
+
+	return reset_required;
+}
+
+static void adf_gen4_process_errsou2(struct adf_accel_dev *accel_dev,
+				     void __iomem *csr, u32 errsou,
+				     bool *reset_required)
+{
+	*reset_required |= adf_handle_ssm(accel_dev, csr, errsou);
+	*reset_required |= adf_handle_cpp_cfc_err(accel_dev, csr, errsou);
+}
+
 static bool adf_gen4_handle_interrupt(struct adf_accel_dev *accel_dev,
 				      bool *reset_required)
 {
@@ -365,6 +1068,12 @@ static bool adf_gen4_handle_interrupt(struct adf_accel_dev *accel_dev,
 		handled = true;
 	}
 
+	errsou = ADF_CSR_RD(csr, ADF_GEN4_ERRSOU2);
+	if (errsou & ADF_GEN4_ERRSOU2_BITMASK) {
+		adf_gen4_process_errsou2(accel_dev, csr, errsou, reset_required);
+		handled = true;
+	}
+
 	return handled;
 }
 
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.h b/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.h
index 67a85cc74a44..65c1b7925444 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.h
@@ -203,6 +203,326 @@ struct adf_ras_ops;
 /* Status control register to log misc RI error */
 #define ADF_GEN4_RIMISCCTL				0x41B1BC
 
+/*
+ * ERRSOU2 bit mask
+ * BIT(0) - SSM Interrupt Mask
+ * BIT(1) - CFC on CPP. ORed of CFC Push error and Pull error
+ * BIT(2) - BIT(4) - CPP attention interrupts, deprecated on gen4 devices
+ * BIT(18) - PM interrupt
+ */
+#define ADF_GEN4_ERRSOU2_SSM_ERR_BIT			BIT(0)
+#define ADF_GEN4_ERRSOU2_CPP_CFC_ERR_STATUS_BIT	BIT(1)
+#define ADF_GEN4_ERRSOU2_CPP_CFC_ATT_INT_BITMASK \
+	(BIT(2) | BIT(3) | BIT(4))
+
+#define ADF_GEN4_ERRSOU2_PM_INT_BIT			BIT(18)
+
+#define ADF_GEN4_ERRSOU2_BITMASK \
+	(ADF_GEN4_ERRSOU2_SSM_ERR_BIT | \
+	 ADF_GEN4_ERRSOU2_CPP_CFC_ERR_STATUS_BIT)
+
+#define ADF_GEN4_ERRSOU2_DIS_BITMASK \
+	(ADF_GEN4_ERRSOU2_SSM_ERR_BIT | \
+	 ADF_GEN4_ERRSOU2_CPP_CFC_ERR_STATUS_BIT | \
+	 ADF_GEN4_ERRSOU2_CPP_CFC_ATT_INT_BITMASK)
+
+#define ADF_GEN4_IAINTSTATSSM				0x28
+
+/* IAINTSTATSSM error bit mask definitions */
+#define ADF_GEN4_IAINTSTATSSM_UERRSSMSH_BIT		BIT(0)
+#define ADF_GEN4_IAINTSTATSSM_CERRSSMSH_BIT		BIT(1)
+#define ADF_GEN4_IAINTSTATSSM_PPERR_BIT			BIT(2)
+#define ADF_GEN4_IAINTSTATSSM_SLICEHANG_ERR_BIT		BIT(3)
+#define ADF_GEN4_IAINTSTATSSM_SPPPARERR_BIT		BIT(4)
+#define ADF_GEN4_IAINTSTATSSM_SSMCPPERR_BIT		BIT(5)
+#define ADF_GEN4_IAINTSTATSSM_SSMSOFTERRORPARITY_BIT	BIT(6)
+#define ADF_GEN4_IAINTSTATSSM_SER_ERR_SSMSH_CERR_BIT	BIT(7)
+#define ADF_GEN4_IAINTSTATSSM_SER_ERR_SSMSH_UNCERR_BIT	BIT(8)
+
+#define ADF_GEN4_IAINTSTATSSM_BITMASK \
+	(ADF_GEN4_IAINTSTATSSM_UERRSSMSH_BIT | \
+	 ADF_GEN4_IAINTSTATSSM_CERRSSMSH_BIT | \
+	 ADF_GEN4_IAINTSTATSSM_PPERR_BIT | \
+	 ADF_GEN4_IAINTSTATSSM_SLICEHANG_ERR_BIT | \
+	 ADF_GEN4_IAINTSTATSSM_SPPPARERR_BIT | \
+	 ADF_GEN4_IAINTSTATSSM_SSMCPPERR_BIT | \
+	 ADF_GEN4_IAINTSTATSSM_SSMSOFTERRORPARITY_BIT | \
+	 ADF_GEN4_IAINTSTATSSM_SER_ERR_SSMSH_CERR_BIT | \
+	 ADF_GEN4_IAINTSTATSSM_SER_ERR_SSMSH_UNCERR_BIT)
+
+#define ADF_GEN4_UERRSSMSH				0x18
+
+/*
+ * UERRSSMSH error bit masks definitions
+ *
+ * BIT(0) - Indicates one uncorrectable error
+ * BIT(15) - Indicates multiple uncorrectable errors
+ *	     in device shared memory
+ */
+#define ADF_GEN4_UERRSSMSH_BITMASK			(BIT(0) | BIT(15))
+
+#define ADF_GEN4_UERRSSMSHAD				0x1C
+
+#define ADF_GEN4_CERRSSMSH				0x10
+
+/*
+ * CERRSSMSH error bit
+ * BIT(0) - Indicates one correctable error
+ */
+#define ADF_GEN4_CERRSSMSH_ERROR_BIT			BIT(0)
+
+#define ADF_GEN4_CERRSSMSHAD				0x14
+
+/* SSM error handling features enable register */
+#define ADF_GEN4_SSMFEATREN				0x198
+
+/*
+ * Disable SSM error detection and reporting features
+ * enabled by device driver on RAS initialization
+ *
+ * following bits should be cleared :
+ * BIT(4)  - Disable parity for CPP parity
+ * BIT(12) - Disable logging push/pull data error in pperr register.
+ * BIT(16) - BIT(23) - Disable parity for SPPs
+ * BIT(24) - BIT(27) - Disable parity for SPPs, if it's supported on the device.
+ */
+#define ADF_GEN4_SSMFEATREN_DIS_BITMASK \
+	(BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(5) | BIT(6) | BIT(7) | \
+	 BIT(8) | BIT(9) | BIT(10) | BIT(11) | BIT(13) | BIT(14) | BIT(15))
+
+#define ADF_GEN4_INTMASKSSM				0x0
+
+/*
+ * Error reporting mask in INTMASKSSM
+ * BIT(0) - Shared memory uncorrectable interrupt mask
+ * BIT(1) - Shared memory correctable interrupt mask
+ * BIT(2) - PPERR interrupt mask
+ * BIT(3) - CPP parity error Interrupt mask
+ * BIT(4) - SSM interrupt generated by SER correctable error mask
+ * BIT(5) - SSM interrupt generated by SER uncorrectable error
+ *	    - not stop and scream - mask
+ */
+#define ADF_GEN4_INTMASKSSM_BITMASK \
+	(BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5))
+
+/* CPP push or pull error */
+#define ADF_GEN4_PPERR					0x8
+
+#define ADF_GEN4_PPERR_BITMASK				(BIT(0) | BIT(1))
+
+#define ADF_GEN4_PPERRID				0xC
+
+/* Slice hang handling related registers */
+#define ADF_GEN4_SLICEHANGSTATUS_ATH_CPH		0x84
+#define ADF_GEN4_SLICEHANGSTATUS_CPR_XLT		0x88
+#define ADF_GEN4_SLICEHANGSTATUS_DCPR_UCS		0x90
+#define ADF_GEN4_SLICEHANGSTATUS_WAT_WCP		0x8C
+#define ADF_GEN4_SLICEHANGSTATUS_PKE			0x94
+
+#define ADF_GEN4_SHINTMASKSSM_ATH_CPH			0xF0
+#define ADF_GEN4_SHINTMASKSSM_CPR_XLT			0xF4
+#define ADF_GEN4_SHINTMASKSSM_DCPR_UCS			0xFC
+#define ADF_GEN4_SHINTMASKSSM_WAT_WCP			0xF8
+#define ADF_GEN4_SHINTMASKSSM_PKE			0x100
+
+/* SPP pull cmd parity err_*slice* CSR */
+#define ADF_GEN4_SPPPULLCMDPARERR_ATH_CPH		0x1A4
+#define ADF_GEN4_SPPPULLCMDPARERR_CPR_XLT		0x1A8
+#define ADF_GEN4_SPPPULLCMDPARERR_DCPR_UCS		0x1B0
+#define ADF_GEN4_SPPPULLCMDPARERR_PKE			0x1B4
+#define ADF_GEN4_SPPPULLCMDPARERR_WAT_WCP		0x1AC
+
+/* SPP pull data parity err_*slice* CSR */
+#define ADF_GEN4_SPPPULLDATAPARERR_ATH_CPH		0x1BC
+#define ADF_GEN4_SPPPULLDATAPARERR_CPR_XLT		0x1C0
+#define ADF_GEN4_SPPPULLDATAPARERR_DCPR_UCS		0x1C8
+#define ADF_GEN4_SPPPULLDATAPARERR_PKE			0x1CC
+#define ADF_GEN4_SPPPULLDATAPARERR_WAT_WCP		0x1C4
+
+/* SPP push cmd parity err_*slice* CSR */
+#define ADF_GEN4_SPPPUSHCMDPARERR_ATH_CPH		0x1D4
+#define ADF_GEN4_SPPPUSHCMDPARERR_CPR_XLT		0x1D8
+#define ADF_GEN4_SPPPUSHCMDPARERR_DCPR_UCS		0x1E0
+#define ADF_GEN4_SPPPUSHCMDPARERR_PKE			0x1E4
+#define ADF_GEN4_SPPPUSHCMDPARERR_WAT_WCP		0x1DC
+
+/* SPP push data parity err_*slice* CSR */
+#define ADF_GEN4_SPPPUSHDATAPARERR_ATH_CPH		0x1EC
+#define ADF_GEN4_SPPPUSHDATAPARERR_CPR_XLT		0x1F0
+#define ADF_GEN4_SPPPUSHDATAPARERR_DCPR_UCS		0x1F8
+#define ADF_GEN4_SPPPUSHDATAPARERR_PKE			0x1FC
+#define ADF_GEN4_SPPPUSHDATAPARERR_WAT_WCP		0x1F4
+
+/* Accelerator SPP parity error mask registers */
+#define ADF_GEN4_SPPPARERRMSK_ATH_CPH			0x204
+#define ADF_GEN4_SPPPARERRMSK_CPR_XLT			0x208
+#define ADF_GEN4_SPPPARERRMSK_DCPR_UCS			0x210
+#define ADF_GEN4_SPPPARERRMSK_PKE			0x214
+#define ADF_GEN4_SPPPARERRMSK_WAT_WCP			0x20C
+
+#define ADF_GEN4_SSMCPPERR				0x224
+
+/*
+ * Uncorrectable error mask in SSMCPPERR
+ * BIT(0) - indicates CPP command parity error
+ * BIT(1) - indicates CPP Main Push PPID parity error
+ * BIT(2) - indicates CPP Main ePPID parity error
+ * BIT(3) - indicates CPP Main push data parity error
+ * BIT(4) - indicates CPP Main Pull PPID parity error
+ * BIT(5) - indicates CPP target pull data parity error
+ */
+#define ADF_GEN4_SSMCPPERR_FATAL_BITMASK \
+	(BIT(0) | BIT(1) | BIT(4))
+
+#define ADF_GEN4_SSMCPPERR_UNCERR_BITMASK \
+	(BIT(2) | BIT(3) | BIT(5))
+
+#define ADF_GEN4_SSMSOFTERRORPARITY_SRC			0x9C
+#define ADF_GEN4_SSMSOFTERRORPARITYMASK_SRC		0xB8
+
+#define ADF_GEN4_SSMSOFTERRORPARITY_ATH_CPH		0xA0
+#define ADF_GEN4_SSMSOFTERRORPARITYMASK_ATH_CPH		0xBC
+
+#define ADF_GEN4_SSMSOFTERRORPARITY_CPR_XLT		0xA4
+#define ADF_GEN4_SSMSOFTERRORPARITYMASK_CPR_XLT		0xC0
+
+#define ADF_GEN4_SSMSOFTERRORPARITY_DCPR_UCS		0xAC
+#define ADF_GEN4_SSMSOFTERRORPARITYMASK_DCPR_UCS	0xC8
+
+#define ADF_GEN4_SSMSOFTERRORPARITY_PKE			0xB0
+#define ADF_GEN4_SSMSOFTERRORPARITYMASK_PKE		0xCC
+
+#define ADF_GEN4_SSMSOFTERRORPARITY_WAT_WCP		0xA8
+#define ADF_GEN4_SSMSOFTERRORPARITYMASK_WAT_WCP		0xC4
+
+/* RF parity error detected in SharedRAM */
+#define ADF_GEN4_SSMSOFTERRORPARITY_SRC_BIT		BIT(0)
+
+#define ADF_GEN4_SER_ERR_SSMSH				0x44C
+
+/*
+ * Fatal error mask in SER_ERR_SSMSH
+ * BIT(0) - Indicates an uncorrectable error has occurred in the
+ *          accelerator controller command RFs
+ * BIT(2) - Parity error occurred in the bank SPP fifos
+ * BIT(3) - Indicates Parity error occurred in following fifos in
+ *          the design
+ * BIT(4) - Parity error occurred in flops in the design
+ * BIT(5) - Uncorrectable error has occurred in the
+ *	    target push and pull data register flop
+ * BIT(7) - Indicates Parity error occurred in the Resource Manager
+ *	    pending lock request fifos
+ * BIT(8) - Indicates Parity error occurred in the Resource Manager
+ *	    MECTX command queues logic
+ * BIT(9) - Indicates Parity error occurred in the Resource Manager
+ *	    MECTX sigdone fifo flops
+ * BIT(10) - Indicates an uncorrectable error has occurred in the
+ *	     Resource Manager MECTX command RFs
+ * BIT(14) - Parity error occurred in Buffer Manager sigdone FIFO
+ */
+ #define ADF_GEN4_SER_ERR_SSMSH_FATAL_BITMASK \
+	 (BIT(0) | BIT(2) | BIT(3) | BIT(4) | BIT(5) | BIT(7) | \
+	  BIT(8) | BIT(9) | BIT(10) | BIT(14))
+
+/*
+ * Uncorrectable error mask in SER_ERR_SSMSH
+ * BIT(12) Parity error occurred in Buffer Manager pool 0
+ * BIT(13) Parity error occurred in Buffer Manager pool 1
+ */
+#define ADF_GEN4_SER_ERR_SSMSH_UNCERR_BITMASK \
+	(BIT(12) | BIT(13))
+
+/*
+ * Correctable error mask in SER_ERR_SSMSH
+ * BIT(1) - Indicates a correctable Error has occurred
+ *	    in the slice controller command RFs
+ * BIT(6) - Indicates a correctable Error has occurred in
+ *	    the target push and pull data RFs
+ * BIT(11) - Indicates an correctable Error has occurred in
+ *	     the Resource Manager MECTX command RFs
+ */
+#define ADF_GEN4_SER_ERR_SSMSH_CERR_BITMASK \
+	(BIT(1) | BIT(6) | BIT(11))
+
+/* SSM shared memory SER error reporting mask */
+#define ADF_GEN4_SER_EN_SSMSH				0x450
+
+/*
+ * SSM SER error reporting mask in SER_en_err_ssmsh
+ * BIT(0) - Enables uncorrectable Error detection in :
+ *	    1) slice controller command RFs.
+ *	    2) target push/pull data registers
+ * BIT(1) - Enables correctable Error detection in :
+ *	    1) slice controller command RFs
+ *	    2) target push/pull data registers
+ * BIT(2) - Enables Parity error detection in
+ *	    1) bank SPP fifos
+ *	    2) gen4_pull_id_queue
+ *	    3) gen4_push_id_queue
+ *	    4) AE_pull_sigdn_fifo
+ *	    5) DT_push_sigdn_fifo
+ *	    6) slx_push_sigdn_fifo
+ *	    7) secure_push_cmd_fifo
+ *	    8) secure_pull_cmd_fifo
+ *	    9) Head register in FIFO wrapper
+ *	    10) current_cmd in individual push queue
+ *	    11) current_cmd in individual pull queue
+ *	    12) push_command_rxp arbitrated in ssm_push_cmd_queues
+ *	    13) pull_command_rxp arbitrated in ssm_pull_cmd_queues
+ * BIT(3) - Enables uncorrectable Error detection in
+ *	    the resource manager mectx cmd RFs.
+ * BIT(4) - Enables correctable error detection in the Resource Manager
+ *	    mectx command RFs
+ * BIT(5) - Enables Parity error detection in
+ *	    1) resource manager lock request fifo
+ *	    2) mectx cmdqueues logic
+ *	    3) mectx sigdone fifo
+ * BIT(6) - Enables Parity error detection in Buffer Manager pools
+ *	    and sigdone fifo
+ */
+#define ADF_GEN4_SER_EN_SSMSH_BITMASK \
+	(BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) | BIT(6))
+
+#define ADF_GEN4_CPP_CFC_ERR_STATUS			0x640C04
+
+/*
+ * BIT(1) - Indicates multiple CPP CFC errors
+ * BIT(7) - Indicates CPP CFC command parity error type
+ * BIT(8) - Indicated CPP CFC data parity error type
+ */
+#define ADF_GEN4_CPP_CFC_ERR_STATUS_MERR_BIT		BIT(1)
+#define ADF_GEN4_CPP_CFC_ERR_STATUS_CMDPAR_BIT		BIT(7)
+#define ADF_GEN4_CPP_CFC_ERR_STATUS_DATAPAR_BIT		BIT(8)
+
+/*
+ * BIT(0) - Enables CFC to detect and log push/pull data error
+ * BIT(1) - Enables CFC to generate interrupt to PCIEP for CPP error
+ * BIT(4) - When 1 Parity detection is disabled
+ * BIT(5) - When 1 Parity detection is disabled on CPP command bus
+ * BIT(6) - When 1 Parity detection is disabled on CPP push/pull bus
+ * BIT(9) - When 1 RF parity error detection is disabled
+ */
+#define ADF_GEN4_CPP_CFC_ERR_CTRL_BITMASK		(BIT(0) | BIT(1))
+
+#define ADF_GEN4_CPP_CFC_ERR_CTRL_DIS_BITMASK \
+	(BIT(4) | BIT(5) | BIT(6) | BIT(9) | BIT(10))
+
+#define ADF_GEN4_CPP_CFC_ERR_CTRL			0x640C00
+
+/*
+ * BIT(0) - Clears bit(0) of ADF_GEN4_CPP_CFC_ERR_STATUS
+ *	    when an error is reported on CPP
+ * BIT(1) - Clears bit(1) of ADF_GEN4_CPP_CFC_ERR_STATUS
+ *	    when multiple errors are reported on CPP
+ * BIT(2) - Clears bit(2) of ADF_GEN4_CPP_CFC_ERR_STATUS
+ *	    when attention interrupt is reported
+ */
+#define ADF_GEN4_CPP_CFC_ERR_STATUS_CLR_BITMASK (BIT(0) | BIT(1) | BIT(2))
+#define ADF_GEN4_CPP_CFC_ERR_STATUS_CLR			0x640C08
+
+#define ADF_GEN4_CPP_CFC_ERR_PPID_LO			0x640C0C
+#define ADF_GEN4_CPP_CFC_ERR_PPID_HI			0x640C10
+
 /* Command Parity error detected on IOSFP Command to QAT */
 #define ADF_GEN4_RIMISCSTS_BIT				BIT(0)
 
-- 
2.41.0


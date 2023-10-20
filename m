Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706A97D0D3C
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Oct 2023 12:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376791AbjJTKfP (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Oct 2023 06:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376857AbjJTKfH (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Oct 2023 06:35:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DEAD52
        for <linux-crypto@vger.kernel.org>; Fri, 20 Oct 2023 03:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697798104; x=1729334104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Kkt8ZNkQE/ewWXmqhtjackZI8YHZOPvVFQQeljZtuA=;
  b=WwK/mL4F8dzk1i/l3/lbQ1c6cYNEzkhmN9Q+WWFL7dqrE1VZuz1uf7w2
   1Ds3PPkWahd9rvLdw2ZteDSg7RSsC9PB7CQscViYvQmNTMGmqqvxnE8lu
   +7iaPwoa1EDlsK9l3h6PTrA5JEPMfGd4pMsSWn044PSvLADxZBnNWzQo8
   vDjlS/uazkFWhJ3ga6r6ACc1okxQ1bcAUm4ZBuXqZhsvTYJwB33n7ZFRU
   0HcvPTS5hx3InM9CIz4sWRmw9QsmrlFIcHJD0X6plZapBVIOLBvziOfDI
   CxNvaqvLphRi3fA7EcBA+Vuu19fchh5CufmPe7Q95WYJeTuUxr0ynOYl0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="383686704"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="383686704"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 03:35:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="792369924"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="792369924"
Received: from fl31ca105gs0706.deacluster.intel.com (HELO fl31ca105gs0706..) ([10.45.133.167])
  by orsmga001.jf.intel.com with ESMTP; 20 Oct 2023 03:35:02 -0700
From:   Shashank Gupta <shashank.gupta@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Shashank Gupta <shashank.gupta@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Tero Kristo <tero.kristo@linux.intel.com>
Subject: [PATCH 3/9] crypto: qat - add reporting of errors from ERRSOU1 for QAT GEN4
Date:   Fri, 20 Oct 2023 11:32:47 +0100
Message-ID: <20231020103431.230671-4-shashank.gupta@intel.com>
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

Add logic to detect and report uncorrectable errors reported through
the ERRSOU1 register in QAT GEN4 devices.
This also introduces the adf_dev_err_mask structure as part of
adf_hw_device_data which will allow to provide different error masks
per device generation.

Signed-off-by: Shashank Gupta <shashank.gupta@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     |   6 +
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.h     |   2 +
 .../intel/qat/qat_common/adf_accel_devices.h  |   6 +
 .../intel/qat/qat_common/adf_gen4_ras.c       | 289 ++++++++++++++++++
 .../intel/qat/qat_common/adf_gen4_ras.h       | 190 ++++++++++++
 5 files changed, 493 insertions(+)

diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
index 671e32c93160..41a6c49e74ad 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -476,6 +476,11 @@ static u32 uof_get_ae_mask(struct adf_accel_dev *accel_dev, u32 obj_num)
 	}
 }
 
+static void adf_gen4_set_err_mask(struct adf_dev_err_mask *dev_err_mask)
+{
+	dev_err_mask->cppagentcmdpar_mask = ADF_4XXX_HICPPAGENTCMDPARERRLOG_MASK;
+}
+
 void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data, u32 dev_id)
 {
 	hw_data->dev_class = &adf_4xxx_class;
@@ -539,6 +544,7 @@ void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data, u32 dev_id)
 	hw_data->get_hb_clock = get_heartbeat_clock;
 	hw_data->num_hb_ctrs = ADF_NUM_HB_CNT_PER_AE;
 
+	adf_gen4_set_err_mask(&hw_data->dev_err_mask);
 	adf_gen4_init_hw_csr_ops(&hw_data->csr_ops);
 	adf_gen4_init_pf_pfvf_ops(&hw_data->pfvf_ops);
 	adf_gen4_init_dc_ops(&hw_data->dc_ops);
diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.h b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.h
index bb3d95a8fb21..7695b4e7277e 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.h
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.h
@@ -28,6 +28,8 @@
 #define ADF_4XXX_ACCELENGINES_MASK	(0x1FF)
 #define ADF_4XXX_ADMIN_AE_MASK		(0x100)
 
+#define ADF_4XXX_HICPPAGENTCMDPARERRLOG_MASK	0x1F
+
 #define ADF_4XXX_ETR_MAX_BANKS		64
 
 /* MSIX interrupt */
diff --git a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
index a62419479184..ebdf9f7f4bc8 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
@@ -176,6 +176,10 @@ struct adf_dc_ops {
 	void (*build_deflate_ctx)(void *ctx);
 };
 
+struct adf_dev_err_mask {
+	u32 cppagentcmdpar_mask;
+};
+
 struct adf_hw_device_data {
 	struct adf_hw_device_class *dev_class;
 	u32 (*get_accel_mask)(struct adf_hw_device_data *self);
@@ -222,6 +226,7 @@ struct adf_hw_device_data {
 	struct adf_hw_csr_ops csr_ops;
 	struct adf_dc_ops dc_ops;
 	struct adf_ras_ops ras_ops;
+	struct adf_dev_err_mask dev_err_mask;
 	const char *fw_name;
 	const char *fw_mmp_name;
 	u32 fuses;
@@ -270,6 +275,7 @@ struct adf_hw_device_data {
 #define GET_SRV_TYPE(accel_dev, idx) \
 	(((GET_HW_DATA(accel_dev)->ring_to_svc_map) >> (ADF_SRV_TYPE_BIT_LEN * (idx))) \
 	& ADF_SRV_TYPE_MASK)
+#define GET_ERR_MASK(accel_dev) (&GET_HW_DATA(accel_dev)->dev_err_mask)
 #define GET_MAX_ACCELENGINES(accel_dev) (GET_HW_DATA(accel_dev)->num_engines)
 #define GET_CSR_OPS(accel_dev) (&(accel_dev)->hw_device->csr_ops)
 #define GET_PFVF_OPS(accel_dev) (&(accel_dev)->hw_device->pfvf_ops)
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c
index 4fbaadbe480e..59ae5a574091 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c
@@ -8,12 +8,18 @@ static void enable_errsou_reporting(void __iomem *csr)
 {
 	/* Enable correctable error reporting in ERRSOU0 */
 	ADF_CSR_WR(csr, ADF_GEN4_ERRMSK0, 0);
+
+	/* Enable uncorrectable error reporting in ERRSOU1 */
+	ADF_CSR_WR(csr, ADF_GEN4_ERRMSK1, 0);
 }
 
 static void disable_errsou_reporting(void __iomem *csr)
 {
 	/* Disable correctable error reporting in ERRSOU0 */
 	ADF_CSR_WR(csr, ADF_GEN4_ERRMSK0, ADF_GEN4_ERRSOU0_BIT);
+
+	/* Disable uncorrectable error reporting in ERRSOU1 */
+	ADF_CSR_WR(csr, ADF_GEN4_ERRMSK1, ADF_GEN4_ERRSOU1_BITMASK);
 }
 
 static void enable_ae_error_reporting(struct adf_accel_dev *accel_dev,
@@ -23,12 +29,73 @@ static void enable_ae_error_reporting(struct adf_accel_dev *accel_dev,
 
 	/* Enable Acceleration Engine correctable error reporting */
 	ADF_CSR_WR(csr, ADF_GEN4_HIAECORERRLOGENABLE_CPP0, ae_mask);
+
+	/* Enable Acceleration Engine uncorrectable error reporting */
+	ADF_CSR_WR(csr, ADF_GEN4_HIAEUNCERRLOGENABLE_CPP0, ae_mask);
 }
 
 static void disable_ae_error_reporting(void __iomem *csr)
 {
 	/* Disable Acceleration Engine correctable error reporting */
 	ADF_CSR_WR(csr, ADF_GEN4_HIAECORERRLOGENABLE_CPP0, 0);
+
+	/* Disable Acceleration Engine uncorrectable error reporting */
+	ADF_CSR_WR(csr, ADF_GEN4_HIAEUNCERRLOGENABLE_CPP0, 0);
+}
+
+static void enable_cpp_error_reporting(struct adf_accel_dev *accel_dev,
+				       void __iomem *csr)
+{
+	struct adf_dev_err_mask *err_mask = GET_ERR_MASK(accel_dev);
+
+	/* Enable HI CPP Agents Command Parity Error Reporting */
+	ADF_CSR_WR(csr, ADF_GEN4_HICPPAGENTCMDPARERRLOGENABLE,
+		   err_mask->cppagentcmdpar_mask);
+}
+
+static void disable_cpp_error_reporting(void __iomem *csr)
+{
+	/* Disable HI CPP Agents Command Parity Error Reporting */
+	ADF_CSR_WR(csr, ADF_GEN4_HICPPAGENTCMDPARERRLOGENABLE, 0);
+}
+
+static void enable_ti_ri_error_reporting(void __iomem *csr)
+{
+	/* Enable RI Memory error reporting */
+	ADF_CSR_WR(csr, ADF_GEN4_RI_MEM_PAR_ERR_EN0,
+		   ADF_GEN4_RIMEM_PARERR_STS_FATAL_BITMASK |
+		   ADF_GEN4_RIMEM_PARERR_STS_UNCERR_BITMASK);
+
+	/* Enable IOSF Primary Command Parity error Reporting */
+	ADF_CSR_WR(csr, ADF_GEN4_RIMISCCTL, ADF_GEN4_RIMISCSTS_BIT);
+
+	/* Enable TI Internal Memory Parity Error reporting */
+	ADF_CSR_WR(csr, ADF_GEN4_TI_CI_PAR_ERR_MASK, 0);
+	ADF_CSR_WR(csr, ADF_GEN4_TI_PULL0FUB_PAR_ERR_MASK, 0);
+	ADF_CSR_WR(csr, ADF_GEN4_TI_PUSHFUB_PAR_ERR_MASK, 0);
+	ADF_CSR_WR(csr, ADF_GEN4_TI_CD_PAR_ERR_MASK, 0);
+	ADF_CSR_WR(csr, ADF_GEN4_TI_TRNSB_PAR_ERR_MASK, 0);
+}
+
+static void disable_ti_ri_error_reporting(void __iomem *csr)
+{
+	/* Disable RI Memory error reporting */
+	ADF_CSR_WR(csr, ADF_GEN4_RI_MEM_PAR_ERR_EN0, 0);
+
+	/* Disable IOSF Primary Command Parity error Reporting */
+	ADF_CSR_WR(csr, ADF_GEN4_RIMISCCTL, 0);
+
+	/* Disable TI Internal Memory Parity Error reporting */
+	ADF_CSR_WR(csr, ADF_GEN4_TI_CI_PAR_ERR_MASK,
+		   ADF_GEN4_TI_CI_PAR_STS_BITMASK);
+	ADF_CSR_WR(csr, ADF_GEN4_TI_PULL0FUB_PAR_ERR_MASK,
+		   ADF_GEN4_TI_PULL0FUB_PAR_STS_BITMASK);
+	ADF_CSR_WR(csr, ADF_GEN4_TI_PUSHFUB_PAR_ERR_MASK,
+		   ADF_GEN4_TI_PUSHFUB_PAR_STS_BITMASK);
+	ADF_CSR_WR(csr, ADF_GEN4_TI_CD_PAR_ERR_MASK,
+		   ADF_GEN4_TI_CD_PAR_STS_BITMASK);
+	ADF_CSR_WR(csr, ADF_GEN4_TI_TRNSB_PAR_ERR_MASK,
+		   ADF_GEN4_TI_TRNSB_PAR_STS_BITMASK);
 }
 
 static void adf_gen4_enable_ras(struct adf_accel_dev *accel_dev)
@@ -37,6 +104,8 @@ static void adf_gen4_enable_ras(struct adf_accel_dev *accel_dev)
 
 	enable_errsou_reporting(csr);
 	enable_ae_error_reporting(accel_dev, csr);
+	enable_cpp_error_reporting(accel_dev, csr);
+	enable_ti_ri_error_reporting(csr);
 }
 
 static void adf_gen4_disable_ras(struct adf_accel_dev *accel_dev)
@@ -45,6 +114,8 @@ static void adf_gen4_disable_ras(struct adf_accel_dev *accel_dev)
 
 	disable_errsou_reporting(csr);
 	disable_ae_error_reporting(csr);
+	disable_cpp_error_reporting(csr);
+	disable_ti_ri_error_reporting(csr);
 }
 
 static void adf_gen4_process_errsou0(struct adf_accel_dev *accel_dev,
@@ -62,6 +133,218 @@ static void adf_gen4_process_errsou0(struct adf_accel_dev *accel_dev,
 	ADF_CSR_WR(csr, ADF_GEN4_HIAECORERRLOG_CPP0, aecorrerr);
 }
 
+static bool adf_handle_cpp_aeunc(struct adf_accel_dev *accel_dev,
+				 void __iomem *csr, u32 errsou)
+{
+	u32 aeuncorerr;
+
+	if (!(errsou & ADF_GEN4_ERRSOU1_HIAEUNCERRLOG_CPP0_BIT))
+		return false;
+
+	aeuncorerr = ADF_CSR_RD(csr, ADF_GEN4_HIAEUNCERRLOG_CPP0);
+	aeuncorerr &= GET_HW_DATA(accel_dev)->ae_mask;
+
+	dev_err(&GET_DEV(accel_dev),
+		"Uncorrectable error detected in AE: 0x%x\n",
+		aeuncorerr);
+
+	ADF_CSR_WR(csr, ADF_GEN4_HIAEUNCERRLOG_CPP0, aeuncorerr);
+
+	return false;
+}
+
+static bool adf_handle_cppcmdparerr(struct adf_accel_dev *accel_dev,
+				    void __iomem *csr, u32 errsou)
+{
+	struct adf_dev_err_mask *err_mask = GET_ERR_MASK(accel_dev);
+	u32 cmdparerr;
+
+	if (!(errsou & ADF_GEN4_ERRSOU1_HICPPAGENTCMDPARERRLOG_BIT))
+		return false;
+
+	cmdparerr = ADF_CSR_RD(csr, ADF_GEN4_HICPPAGENTCMDPARERRLOG);
+	cmdparerr &= err_mask->cppagentcmdpar_mask;
+
+	dev_err(&GET_DEV(accel_dev),
+		"HI CPP agent command parity error: 0x%x\n",
+		cmdparerr);
+
+	ADF_CSR_WR(csr, ADF_GEN4_HICPPAGENTCMDPARERRLOG, cmdparerr);
+
+	return true;
+}
+
+static bool adf_handle_ri_mem_par_err(struct adf_accel_dev *accel_dev,
+				      void __iomem *csr, u32 errsou)
+{
+	bool reset_required = false;
+	u32 rimem_parerr_sts;
+
+	if (!(errsou & ADF_GEN4_ERRSOU1_RIMEM_PARERR_STS_BIT))
+		return false;
+
+	rimem_parerr_sts = ADF_CSR_RD(csr, ADF_GEN4_RIMEM_PARERR_STS);
+	rimem_parerr_sts &= ADF_GEN4_RIMEM_PARERR_STS_UNCERR_BITMASK |
+			    ADF_GEN4_RIMEM_PARERR_STS_FATAL_BITMASK;
+
+	if (rimem_parerr_sts & ADF_GEN4_RIMEM_PARERR_STS_UNCERR_BITMASK)
+		dev_err(&GET_DEV(accel_dev),
+			"RI Memory Parity uncorrectable error: 0x%x\n",
+			rimem_parerr_sts);
+
+	if (rimem_parerr_sts & ADF_GEN4_RIMEM_PARERR_STS_FATAL_BITMASK) {
+		dev_err(&GET_DEV(accel_dev),
+			"RI Memory Parity fatal error: 0x%x\n",
+			rimem_parerr_sts);
+		reset_required = true;
+	}
+
+	ADF_CSR_WR(csr, ADF_GEN4_RIMEM_PARERR_STS, rimem_parerr_sts);
+
+	return reset_required;
+}
+
+static bool adf_handle_ti_ci_par_sts(struct adf_accel_dev *accel_dev,
+				     void __iomem *csr, u32 errsou)
+{
+	u32 ti_ci_par_sts;
+
+	if (!(errsou & ADF_GEN4_ERRSOU1_TIMEM_PARERR_STS_BIT))
+		return false;
+
+	ti_ci_par_sts = ADF_CSR_RD(csr, ADF_GEN4_TI_CI_PAR_STS);
+	ti_ci_par_sts &= ADF_GEN4_TI_CI_PAR_STS_BITMASK;
+
+	if (ti_ci_par_sts) {
+		dev_err(&GET_DEV(accel_dev),
+			"TI Memory Parity Error: 0x%x\n", ti_ci_par_sts);
+		ADF_CSR_WR(csr, ADF_GEN4_TI_CI_PAR_STS, ti_ci_par_sts);
+	}
+
+	return false;
+}
+
+static bool adf_handle_ti_pullfub_par_sts(struct adf_accel_dev *accel_dev,
+					  void __iomem *csr, u32 errsou)
+{
+	u32 ti_pullfub_par_sts;
+
+	if (!(errsou & ADF_GEN4_ERRSOU1_TIMEM_PARERR_STS_BIT))
+		return false;
+
+	ti_pullfub_par_sts = ADF_CSR_RD(csr, ADF_GEN4_TI_PULL0FUB_PAR_STS);
+	ti_pullfub_par_sts &= ADF_GEN4_TI_PULL0FUB_PAR_STS_BITMASK;
+
+	if (ti_pullfub_par_sts) {
+		dev_err(&GET_DEV(accel_dev),
+			"TI Pull Parity Error: 0x%x\n", ti_pullfub_par_sts);
+
+		ADF_CSR_WR(csr, ADF_GEN4_TI_PULL0FUB_PAR_STS,
+			   ti_pullfub_par_sts);
+	}
+
+	return false;
+}
+
+static bool adf_handle_ti_pushfub_par_sts(struct adf_accel_dev *accel_dev,
+					  void __iomem *csr, u32 errsou)
+{
+	u32 ti_pushfub_par_sts;
+
+	if (!(errsou & ADF_GEN4_ERRSOU1_TIMEM_PARERR_STS_BIT))
+		return false;
+
+	ti_pushfub_par_sts = ADF_CSR_RD(csr, ADF_GEN4_TI_PUSHFUB_PAR_STS);
+	ti_pushfub_par_sts &= ADF_GEN4_TI_PUSHFUB_PAR_STS_BITMASK;
+
+	if (ti_pushfub_par_sts) {
+		dev_err(&GET_DEV(accel_dev),
+			"TI Push Parity Error: 0x%x\n", ti_pushfub_par_sts);
+
+		ADF_CSR_WR(csr, ADF_GEN4_TI_PUSHFUB_PAR_STS,
+			   ti_pushfub_par_sts);
+	}
+
+	return false;
+}
+
+static bool adf_handle_ti_cd_par_sts(struct adf_accel_dev *accel_dev,
+				     void __iomem *csr, u32 errsou)
+{
+	u32 ti_cd_par_sts;
+
+	if (!(errsou & ADF_GEN4_ERRSOU1_TIMEM_PARERR_STS_BIT))
+		return false;
+
+	ti_cd_par_sts = ADF_CSR_RD(csr, ADF_GEN4_TI_CD_PAR_STS);
+	ti_cd_par_sts &= ADF_GEN4_TI_CD_PAR_STS_BITMASK;
+
+	if (ti_cd_par_sts) {
+		dev_err(&GET_DEV(accel_dev),
+			"TI CD Parity Error: 0x%x\n", ti_cd_par_sts);
+
+		ADF_CSR_WR(csr, ADF_GEN4_TI_CD_PAR_STS, ti_cd_par_sts);
+	}
+
+	return false;
+}
+
+static bool adf_handle_ti_trnsb_par_sts(struct adf_accel_dev *accel_dev,
+					void __iomem *csr, u32 errsou)
+{
+	u32 ti_trnsb_par_sts;
+
+	if (!(errsou & ADF_GEN4_ERRSOU1_TIMEM_PARERR_STS_BIT))
+		return false;
+
+	ti_trnsb_par_sts = ADF_CSR_RD(csr, ADF_GEN4_TI_TRNSB_PAR_STS);
+	ti_trnsb_par_sts &= ADF_GEN4_TI_TRNSB_PAR_STS_BITMASK;
+
+	if (ti_trnsb_par_sts) {
+		dev_err(&GET_DEV(accel_dev),
+			"TI TRNSB Parity Error: 0x%x\n", ti_trnsb_par_sts);
+
+		ADF_CSR_WR(csr, ADF_GEN4_TI_TRNSB_PAR_STS, ti_trnsb_par_sts);
+	}
+
+	return false;
+}
+
+static bool adf_handle_iosfp_cmd_parerr(struct adf_accel_dev *accel_dev,
+					void __iomem *csr, u32 errsou)
+{
+	u32 rimiscsts;
+
+	if (!(errsou & ADF_GEN4_ERRSOU1_TIMEM_PARERR_STS_BIT))
+		return false;
+
+	rimiscsts = ADF_CSR_RD(csr, ADF_GEN4_RIMISCSTS);
+	rimiscsts &= ADF_GEN4_RIMISCSTS_BIT;
+
+	dev_err(&GET_DEV(accel_dev),
+		"Command Parity error detected on IOSFP: 0x%x\n",
+		rimiscsts);
+
+	ADF_CSR_WR(csr, ADF_GEN4_RIMISCSTS, rimiscsts);
+
+	return true;
+}
+
+static void adf_gen4_process_errsou1(struct adf_accel_dev *accel_dev,
+				     void __iomem *csr, u32 errsou,
+				     bool *reset_required)
+{
+	*reset_required |= adf_handle_cpp_aeunc(accel_dev, csr, errsou);
+	*reset_required |= adf_handle_cppcmdparerr(accel_dev, csr, errsou);
+	*reset_required |= adf_handle_ri_mem_par_err(accel_dev, csr, errsou);
+	*reset_required |= adf_handle_ti_ci_par_sts(accel_dev, csr, errsou);
+	*reset_required |= adf_handle_ti_pullfub_par_sts(accel_dev, csr, errsou);
+	*reset_required |= adf_handle_ti_pushfub_par_sts(accel_dev, csr, errsou);
+	*reset_required |= adf_handle_ti_cd_par_sts(accel_dev, csr, errsou);
+	*reset_required |= adf_handle_ti_trnsb_par_sts(accel_dev, csr, errsou);
+	*reset_required |= adf_handle_iosfp_cmd_parerr(accel_dev, csr, errsou);
+}
+
 static bool adf_gen4_handle_interrupt(struct adf_accel_dev *accel_dev,
 				      bool *reset_required)
 {
@@ -76,6 +359,12 @@ static bool adf_gen4_handle_interrupt(struct adf_accel_dev *accel_dev,
 		handled = true;
 	}
 
+	errsou = ADF_CSR_RD(csr, ADF_GEN4_ERRSOU1);
+	if (errsou & ADF_GEN4_ERRSOU1_BITMASK) {
+		adf_gen4_process_errsou1(accel_dev, csr, errsou, reset_required);
+		handled = true;
+	}
+
 	return handled;
 }
 
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.h b/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.h
index e6c4dfbb2389..67a85cc74a44 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.h
@@ -15,6 +15,196 @@ struct adf_ras_ops;
 
 /* HI AE Correctable error log enable */
 #define ADF_GEN4_HIAECORERRLOGENABLE_CPP0		0x41A318
+#define ADF_GEN4_ERRSOU1_HIAEUNCERRLOG_CPP0_BIT		BIT(0)
+#define ADF_GEN4_ERRSOU1_HICPPAGENTCMDPARERRLOG_BIT	BIT(1)
+#define ADF_GEN4_ERRSOU1_RIMEM_PARERR_STS_BIT		BIT(2)
+#define ADF_GEN4_ERRSOU1_TIMEM_PARERR_STS_BIT		BIT(3)
+#define ADF_GEN4_ERRSOU1_RIMISCSTS_BIT			BIT(4)
+
+#define ADF_GEN4_ERRSOU1_BITMASK ( \
+	(ADF_GEN4_ERRSOU1_HIAEUNCERRLOG_CPP0_BIT)	| \
+	(ADF_GEN4_ERRSOU1_HICPPAGENTCMDPARERRLOG_BIT)	| \
+	(ADF_GEN4_ERRSOU1_RIMEM_PARERR_STS_BIT)	| \
+	(ADF_GEN4_ERRSOU1_TIMEM_PARERR_STS_BIT)	| \
+	(ADF_GEN4_ERRSOU1_RIMISCSTS_BIT))
+
+/* HI AE Uncorrectable error log */
+#define ADF_GEN4_HIAEUNCERRLOG_CPP0			0x41A300
+
+/* HI AE Uncorrectable error log enable */
+#define ADF_GEN4_HIAEUNCERRLOGENABLE_CPP0		0x41A320
+
+/* HI CPP Agent Command parity error log */
+#define ADF_GEN4_HICPPAGENTCMDPARERRLOG			0x41A310
+
+/* HI CPP Agent Command parity error logging enable */
+#define ADF_GEN4_HICPPAGENTCMDPARERRLOGENABLE		0x41A314
+
+/* RI Memory parity error status register */
+#define ADF_GEN4_RIMEM_PARERR_STS			0x41B128
+
+/* RI Memory parity error reporting enable */
+#define ADF_GEN4_RI_MEM_PAR_ERR_EN0			0x41B12C
+
+/*
+ * RI Memory parity error mask
+ * BIT(0) - BIT(3) - ri_iosf_pdata_rxq[0:3] parity error
+ * BIT(4) - ri_tlq_phdr parity error
+ * BIT(5) - ri_tlq_pdata parity error
+ * BIT(6) - ri_tlq_nphdr parity error
+ * BIT(7) - ri_tlq_npdata parity error
+ * BIT(8) - BIT(9) - ri_tlq_cplhdr[0:1] parity error
+ * BIT(10) - BIT(17) - ri_tlq_cpldata[0:7] parity error
+ * BIT(18) - set this bit to 1 to enable logging status to ri_mem_par_err_sts0
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
+#define ADF_GEN4_RIMEM_PARERR_STS_UNCERR_BITMASK \
+	(BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(5) | \
+	 BIT(7) | BIT(10) | BIT(11) | BIT(12) | BIT(13) | \
+	 BIT(14) | BIT(15) | BIT(16) | BIT(17) | BIT(18) | BIT(19) | \
+	 BIT(20) | BIT(21) | BIT(22) | BIT(23) | BIT(24) | BIT(25) | \
+	 BIT(26) | BIT(27) | BIT(28) | BIT(30))
+
+#define ADF_GEN4_RIMEM_PARERR_STS_FATAL_BITMASK \
+	(BIT(4) | BIT(6) | BIT(8) | BIT(9))
+
+/* TI CI parity status */
+#define ADF_GEN4_TI_CI_PAR_STS				0x50060C
+
+/* TI CI parity reporting mask */
+#define ADF_GEN4_TI_CI_PAR_ERR_MASK			0x500608
+
+/*
+ * TI CI parity status mask
+ * BIT(0) - CdCmdQ_sts patiry error status
+ * BIT(1) - CdDataQ_sts parity error status
+ * BIT(3) - CPP_SkidQ_sts parity error status
+ * BIT(7) - CPP_SkidQ_sc_sts parity error status
+ */
+#define ADF_GEN4_TI_CI_PAR_STS_BITMASK \
+	(BIT(0) | BIT(1) | BIT(3) | BIT(7))
+
+/* TI PULLFUB parity status */
+#define ADF_GEN4_TI_PULL0FUB_PAR_STS			0x500618
+
+/* TI PULLFUB parity error reporting mask */
+#define ADF_GEN4_TI_PULL0FUB_PAR_ERR_MASK		0x500614
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
+#define ADF_GEN4_TI_PULL0FUB_PAR_STS_BITMASK \
+	(BIT(0) | BIT(1) | BIT(2) | BIT(4) | BIT(5) | BIT(6) | BIT(7) | \
+	 BIT(8) | BIT(9) | BIT(10) | BIT(11) | BIT(12) | BIT(13) | BIT(14))
+
+/* TI PUSHUB parity status */
+#define ADF_GEN4_TI_PUSHFUB_PAR_STS			0x500630
+
+/* TI PUSHFUB parity error reporting mask */
+#define ADF_GEN4_TI_PUSHFUB_PAR_ERR_MASK		0x50062C
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
+#define ADF_GEN4_TI_PUSHFUB_PAR_STS_BITMASK \
+	(BIT(0) | BIT(1) | BIT(2) | BIT(4) | BIT(5) | \
+	 BIT(6) | BIT(7) | BIT(8) | BIT(9) | BIT(10))
+
+/* TI CD parity status */
+#define ADF_GEN4_TI_CD_PAR_STS				0x50063C
+
+/* TI CD parity error mask */
+#define ADF_GEN4_TI_CD_PAR_ERR_MASK			0x500638
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
+#define ADF_GEN4_TI_CD_PAR_STS_BITMASK \
+	(BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) | BIT(6) | \
+	 BIT(7) | BIT(8) | BIT(9) | BIT(10) | BIT(11) | BIT(12) | BIT(13) | \
+	 BIT(14) | BIT(15) | BIT(16) | BIT(17) | BIT(18) | BIT(19) | BIT(20) | \
+	 BIT(21) | BIT(22) | BIT(23) | BIT(24) | BIT(25))
+
+/* TI TRNSB parity status */
+#define ADF_GEN4_TI_TRNSB_PAR_STS			0x500648
+
+/* TI TRNSB Parity error reporting mask */
+#define ADF_GEN4_TI_TRNSB_PAR_ERR_MASK			0x500644
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
+#define ADF_GEN4_TI_TRNSB_PAR_STS_BITMASK \
+	(BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) | BIT(6) | \
+	 BIT(7) | BIT(8) | BIT(9) | BIT(10) | BIT(11) | BIT(12) | \
+	 BIT(13) | BIT(14) | BIT(15) | BIT(16) | BIT(17) | BIT(18) | \
+	 BIT(19) | BIT(20) | BIT(21))
+
+/* Status register to log misc error on RI */
+#define ADF_GEN4_RIMISCSTS				0x41B1B8
+
+/* Status control register to log misc RI error */
+#define ADF_GEN4_RIMISCCTL				0x41B1BC
+
+/* Command Parity error detected on IOSFP Command to QAT */
+#define ADF_GEN4_RIMISCSTS_BIT				BIT(0)
 
 void adf_gen4_init_ras_ops(struct adf_ras_ops *ras_ops);
 
-- 
2.41.0


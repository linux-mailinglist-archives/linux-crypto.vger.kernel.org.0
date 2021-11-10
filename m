Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B9444CAD3
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Nov 2021 21:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhKJUzd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 10 Nov 2021 15:55:33 -0500
Received: from mga09.intel.com ([134.134.136.24]:55773 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233140AbhKJUza (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 10 Nov 2021 15:55:30 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="232611118"
X-IronPort-AV: E=Sophos;i="5.87,224,1631602800"; 
   d="scan'208";a="232611118"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 12:52:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,224,1631602800"; 
   d="scan'208";a="642663118"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.51])
  by fmsmga001.fm.intel.com with ESMTP; 10 Nov 2021 12:52:39 -0800
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        marco.chiappero@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH 12/24] crypto: qat - relocate PFVF disabled function
Date:   Wed, 10 Nov 2021 20:52:05 +0000
Message-Id: <20211110205217.99903-13-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211110205217.99903-1-giovanni.cabiddu@intel.com>
References: <20211110205217.99903-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Move the function pfvf_comms_disabled() from the qat_4xxx module to
intel_qat as it will be used by other components to keep the PFVF
feature disabled.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Marco Chiappero <marco.chiappero@intel.com>
---
 drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c   | 7 +------
 drivers/crypto/qat/qat_common/adf_common_drv.h   | 2 ++
 drivers/crypto/qat/qat_common/adf_gen4_hw_data.c | 7 +++++++
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
index fa768f10635f..ab61eebb1b96 100644
--- a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -191,11 +191,6 @@ static int adf_init_device(struct adf_accel_dev *accel_dev)
 	return ret;
 }
 
-static int pfvf_comms_disabled(struct adf_accel_dev *accel_dev)
-{
-	return 0;
-}
-
 static u32 uof_get_num_objs(void)
 {
 	return ARRAY_SIZE(adf_4xxx_fw_config);
@@ -253,7 +248,7 @@ void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data)
 	hw_data->uof_get_ae_mask = uof_get_ae_mask;
 	hw_data->set_msix_rttable = set_msix_default_rttable;
 	hw_data->set_ssm_wdtimer = adf_gen4_set_ssm_wdtimer;
-	hw_data->enable_pfvf_comms = pfvf_comms_disabled;
+	hw_data->enable_pfvf_comms = adf_pfvf_comms_disabled;
 	hw_data->disable_iov = adf_disable_sriov;
 	hw_data->min_iov_compat_ver = ADF_PFVF_COMPAT_THIS_VERSION;
 
diff --git a/drivers/crypto/qat/qat_common/adf_common_drv.h b/drivers/crypto/qat/qat_common/adf_common_drv.h
index 120b2e26b20f..dc5846e880fe 100644
--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
@@ -129,6 +129,8 @@ void adf_isr_resource_free(struct adf_accel_dev *accel_dev);
 int adf_vf_isr_resource_alloc(struct adf_accel_dev *accel_dev);
 void adf_vf_isr_resource_free(struct adf_accel_dev *accel_dev);
 
+int adf_pfvf_comms_disabled(struct adf_accel_dev *accel_dev);
+
 int qat_hal_init(struct adf_accel_dev *accel_dev);
 void qat_hal_deinit(struct icp_qat_fw_loader_handle *handle);
 int qat_hal_start(struct icp_qat_fw_loader_handle *handle);
diff --git a/drivers/crypto/qat/qat_common/adf_gen4_hw_data.c b/drivers/crypto/qat/qat_common/adf_gen4_hw_data.c
index 000528327b29..e3157df8a653 100644
--- a/drivers/crypto/qat/qat_common/adf_gen4_hw_data.c
+++ b/drivers/crypto/qat/qat_common/adf_gen4_hw_data.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
 /* Copyright(c) 2020 Intel Corporation */
 #include "adf_accel_devices.h"
+#include "adf_common_drv.h"
 #include "adf_gen4_hw_data.h"
 
 static u64 build_csr_ring_base_addr(dma_addr_t addr, u32 size)
@@ -139,3 +140,9 @@ void adf_gen4_set_ssm_wdtimer(struct adf_accel_dev *accel_dev)
 	ADF_CSR_WR(pmisc_addr, ADF_SSMWDTPKEH_OFFSET, ssm_wdt_pke_high);
 }
 EXPORT_SYMBOL_GPL(adf_gen4_set_ssm_wdtimer);
+
+int adf_pfvf_comms_disabled(struct adf_accel_dev *accel_dev)
+{
+	return 0;
+}
+EXPORT_SYMBOL_GPL(adf_pfvf_comms_disabled);
-- 
2.33.1


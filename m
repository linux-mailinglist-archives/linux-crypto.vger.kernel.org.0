Return-Path: <linux-crypto+bounces-859-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A0881450F
	for <lists+linux-crypto@lfdr.de>; Fri, 15 Dec 2023 11:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F71C1C22803
	for <lists+linux-crypto@lfdr.de>; Fri, 15 Dec 2023 10:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E8F19446;
	Fri, 15 Dec 2023 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oIc7N321"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA83E1944D
	for <linux-crypto@vger.kernel.org>; Fri, 15 Dec 2023 10:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702634610; x=1734170610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E8nX2x8t7SJEqd+hFnkXpjhKwd68IOQQqDVgldpSQHU=;
  b=oIc7N321k656NoG3iMWs1QKSZ2vp2JCxtopV7M7kXpig/k6eMh5sUQ16
   Ihn87iCM0gz5QSwxBT69fsnR7iw7cqK/ieMiiG8uIVmCP9Xon5Ox8I1MQ
   pBO7Wk8+kMFVvbG8bWFPX1E9otTfeBNTdbt6YQyjwH0zkykdNKM13T8tl
   7mbb6Q7EgA/xlG9VQKD6lkXsd8i3VVYGToCI9RUAEUHWvPFyMJepE//BN
   AbmkqSy6/2WNk2ElBaykv4sH1QXXvpd7adVLzlWJxSFczpnZh8KKIUfMg
   mn1a0Gsy9C8bB3EuwnF72ntxhanEpRiB4Mgbo2CQHZecTsuQm4vV0p2g+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="374759863"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="374759863"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 02:03:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="845074105"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="845074105"
Received: from qat-wangjie-342.sh.intel.com ([10.67.115.171])
  by fmsmga004.fm.intel.com with ESMTP; 15 Dec 2023 02:03:28 -0800
From: Jie Wang <jie.wang@intel.com>
To: herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org,
	qat-linux@intel.com
Subject: [PATCH 3/5] crypto: qat - relocate portions of qat_4xxx code
Date: Fri, 15 Dec 2023 05:01:46 -0500
Message-Id: <20231215100147.1703641-4-jie.wang@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231215100147.1703641-1-jie.wang@intel.com>
References: <20231215100147.1703641-1-jie.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Asia-Pacific Research & Development Ltd. - No. 880, Zi Xing, Road, Shanghai Zizhu Science Park, Shanghai, 200241, PRC
Content-Transfer-Encoding: 8bit

Move logic that is common between QAT GEN4 accelerators to the
qat_common folder. This includes addresses of CSRs, setters and
configuration logic.
When moved, functions and defines have been renamed from 4XXX to GEN4.

Code specific to the device is moved to the file adf_gen4_hw_data.c.
Code related to configuration is moved to the newly created
adf_gen4_config.c.

This does not introduce any functional change.

Signed-off-by: Jie Wang <jie.wang@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     | 188 ++----------
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.h     |  52 ----
 drivers/crypto/intel/qat/qat_4xxx/adf_drv.c   | 277 +----------------
 drivers/crypto/intel/qat/qat_common/Makefile  |   1 +
 .../intel/qat/qat_common/adf_gen4_config.c    | 287 ++++++++++++++++++
 .../intel/qat/qat_common/adf_gen4_config.h    |  11 +
 .../intel/qat/qat_common/adf_gen4_hw_data.c   | 148 +++++++++
 .../intel/qat/qat_common/adf_gen4_hw_data.h   |  72 +++++
 8 files changed, 552 insertions(+), 484 deletions(-)
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen4_config.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen4_config.h

diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
index f7e8fdc82d38..ee0ffeec491b 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -7,6 +7,7 @@
 #include <adf_cfg_services.h>
 #include <adf_clock.h>
 #include <adf_common_drv.h>
+#include <adf_gen4_config.h>
 #include <adf_gen4_dc.h>
 #include <adf_gen4_hw_data.h>
 #include <adf_gen4_pfvf.h>
@@ -120,11 +121,6 @@ static struct adf_hw_device_class adf_4xxx_class = {
 	.instances = 0,
 };
 
-static u32 get_accel_mask(struct adf_hw_device_data *self)
-{
-	return ADF_4XXX_ACCELERATORS_MASK;
-}
-
 static u32 get_ae_mask(struct adf_hw_device_data *self)
 {
 	u32 me_disable = self->fuses;
@@ -132,55 +128,6 @@ static u32 get_ae_mask(struct adf_hw_device_data *self)
 	return ~me_disable & ADF_4XXX_ACCELENGINES_MASK;
 }
 
-static u32 get_num_accels(struct adf_hw_device_data *self)
-{
-	return ADF_4XXX_MAX_ACCELERATORS;
-}
-
-static u32 get_num_aes(struct adf_hw_device_data *self)
-{
-	if (!self || !self->ae_mask)
-		return 0;
-
-	return hweight32(self->ae_mask);
-}
-
-static u32 get_misc_bar_id(struct adf_hw_device_data *self)
-{
-	return ADF_4XXX_PMISC_BAR;
-}
-
-static u32 get_etr_bar_id(struct adf_hw_device_data *self)
-{
-	return ADF_4XXX_ETR_BAR;
-}
-
-static u32 get_sram_bar_id(struct adf_hw_device_data *self)
-{
-	return ADF_4XXX_SRAM_BAR;
-}
-
-/*
- * The vector routing table is used to select the MSI-X entry to use for each
- * interrupt source.
- * The first ADF_4XXX_ETR_MAX_BANKS entries correspond to ring interrupts.
- * The final entry corresponds to VF2PF or error interrupts.
- * This vector table could be used to configure one MSI-X entry to be shared
- * between multiple interrupt sources.
- *
- * The default routing is set to have a one to one correspondence between the
- * interrupt source and the MSI-X entry used.
- */
-static void set_msix_default_rttable(struct adf_accel_dev *accel_dev)
-{
-	void __iomem *csr;
-	int i;
-
-	csr = (&GET_BARS(accel_dev)[ADF_4XXX_PMISC_BAR])->virt_addr;
-	for (i = 0; i <= ADF_4XXX_ETR_MAX_BANKS; i++)
-		ADF_CSR_WR(csr, ADF_4XXX_MSIX_RTTABLE_OFFSET(i), i);
-}
-
 static u32 get_accel_cap(struct adf_accel_dev *accel_dev)
 {
 	struct pci_dev *pdev = accel_dev->accel_pci_dev.pci_dev;
@@ -189,7 +136,7 @@ static u32 get_accel_cap(struct adf_accel_dev *accel_dev)
 	u32 fusectl1;
 
 	/* Read accelerator capabilities mask */
-	pci_read_config_dword(pdev, ADF_4XXX_FUSECTL1_OFFSET, &fusectl1);
+	pci_read_config_dword(pdev, ADF_GEN4_FUSECTL1_OFFSET, &fusectl1);
 
 	capabilities_sym = ICP_ACCEL_CAPABILITIES_CRYPTO_SYMMETRIC |
 			  ICP_ACCEL_CAPABILITIES_CIPHER |
@@ -204,27 +151,27 @@ static u32 get_accel_cap(struct adf_accel_dev *accel_dev)
 			  ICP_ACCEL_CAPABILITIES_AES_V2;
 
 	/* A set bit in fusectl1 means the feature is OFF in this SKU */
-	if (fusectl1 & ICP_ACCEL_4XXX_MASK_CIPHER_SLICE) {
+	if (fusectl1 & ICP_ACCEL_GEN4_MASK_CIPHER_SLICE) {
 		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_CRYPTO_SYMMETRIC;
 		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_HKDF;
 		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_CIPHER;
 	}
 
-	if (fusectl1 & ICP_ACCEL_4XXX_MASK_UCS_SLICE) {
+	if (fusectl1 & ICP_ACCEL_GEN4_MASK_UCS_SLICE) {
 		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_CHACHA_POLY;
 		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_AESGCM_SPC;
 		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_AES_V2;
 		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_CIPHER;
 	}
 
-	if (fusectl1 & ICP_ACCEL_4XXX_MASK_AUTH_SLICE) {
+	if (fusectl1 & ICP_ACCEL_GEN4_MASK_AUTH_SLICE) {
 		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_AUTHENTICATION;
 		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_SHA3;
 		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_SHA3_EXT;
 		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_CIPHER;
 	}
 
-	if (fusectl1 & ICP_ACCEL_4XXX_MASK_SMX_SLICE) {
+	if (fusectl1 & ICP_ACCEL_GEN4_MASK_SMX_SLICE) {
 		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_SM3;
 		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_SM4;
 	}
@@ -234,7 +181,7 @@ static u32 get_accel_cap(struct adf_accel_dev *accel_dev)
 			  ICP_ACCEL_CAPABILITIES_SM2 |
 			  ICP_ACCEL_CAPABILITIES_ECEDMONT;
 
-	if (fusectl1 & ICP_ACCEL_4XXX_MASK_PKE_SLICE) {
+	if (fusectl1 & ICP_ACCEL_GEN4_MASK_PKE_SLICE) {
 		capabilities_asym &= ~ICP_ACCEL_CAPABILITIES_CRYPTO_ASYMMETRIC;
 		capabilities_asym &= ~ICP_ACCEL_CAPABILITIES_SM2;
 		capabilities_asym &= ~ICP_ACCEL_CAPABILITIES_ECEDMONT;
@@ -245,7 +192,7 @@ static u32 get_accel_cap(struct adf_accel_dev *accel_dev)
 			  ICP_ACCEL_CAPABILITIES_LZ4S_COMPRESSION |
 			  ICP_ACCEL_CAPABILITIES_CNV_INTEGRITY64;
 
-	if (fusectl1 & ICP_ACCEL_4XXX_MASK_COMPRESS_SLICE) {
+	if (fusectl1 & ICP_ACCEL_GEN4_MASK_COMPRESS_SLICE) {
 		capabilities_dc &= ~ICP_ACCEL_CAPABILITIES_COMPRESSION;
 		capabilities_dc &= ~ICP_ACCEL_CAPABILITIES_LZ4_COMPRESSION;
 		capabilities_dc &= ~ICP_ACCEL_CAPABILITIES_LZ4S_COMPRESSION;
@@ -281,11 +228,6 @@ static u32 get_accel_cap(struct adf_accel_dev *accel_dev)
 	}
 }
 
-static enum dev_sku_info get_sku(struct adf_hw_device_data *self)
-{
-	return DEV_SKU_1;
-}
-
 static const u32 *adf_get_arbiter_mapping(struct adf_accel_dev *accel_dev)
 {
 	switch (adf_get_service_enabled(accel_dev)) {
@@ -298,28 +240,6 @@ static const u32 *adf_get_arbiter_mapping(struct adf_accel_dev *accel_dev)
 	}
 }
 
-static void get_arb_info(struct arb_info *arb_info)
-{
-	arb_info->arb_cfg = ADF_4XXX_ARB_CONFIG;
-	arb_info->arb_offset = ADF_4XXX_ARB_OFFSET;
-	arb_info->wt2sam_offset = ADF_4XXX_ARB_WRK_2_SER_MAP_OFFSET;
-}
-
-static void get_admin_info(struct admin_info *admin_csrs_info)
-{
-	admin_csrs_info->mailbox_offset = ADF_4XXX_MAILBOX_BASE_OFFSET;
-	admin_csrs_info->admin_msg_ur = ADF_4XXX_ADMINMSGUR_OFFSET;
-	admin_csrs_info->admin_msg_lr = ADF_4XXX_ADMINMSGLR_OFFSET;
-}
-
-static u32 get_heartbeat_clock(struct adf_hw_device_data *self)
-{
-	/*
-	 * 4XXX uses KPT counter for HB
-	 */
-	return ADF_4XXX_KPT_COUNTER_FREQ;
-}
-
 static void adf_init_rl_data(struct adf_rl_hw_data *rl_data)
 {
 	rl_data->pciout_tb_offset = ADF_GEN4_RL_TOKEN_PCIEOUT_BUCKET_OFFSET;
@@ -338,58 +258,6 @@ static void adf_init_rl_data(struct adf_rl_hw_data *rl_data)
 	rl_data->scale_ref = ADF_4XXX_RL_SLICE_REF;
 }
 
-static void adf_enable_error_correction(struct adf_accel_dev *accel_dev)
-{
-	struct adf_bar *misc_bar = &GET_BARS(accel_dev)[ADF_4XXX_PMISC_BAR];
-	void __iomem *csr = misc_bar->virt_addr;
-
-	/* Enable all in errsou3 except VFLR notification on host */
-	ADF_CSR_WR(csr, ADF_GEN4_ERRMSK3, ADF_GEN4_VFLNOTIFY);
-}
-
-static void adf_enable_ints(struct adf_accel_dev *accel_dev)
-{
-	void __iomem *addr;
-
-	addr = (&GET_BARS(accel_dev)[ADF_4XXX_PMISC_BAR])->virt_addr;
-
-	/* Enable bundle interrupts */
-	ADF_CSR_WR(addr, ADF_4XXX_SMIAPF_RP_X0_MASK_OFFSET, 0);
-	ADF_CSR_WR(addr, ADF_4XXX_SMIAPF_RP_X1_MASK_OFFSET, 0);
-
-	/* Enable misc interrupts */
-	ADF_CSR_WR(addr, ADF_4XXX_SMIAPF_MASK_OFFSET, 0);
-}
-
-static int adf_init_device(struct adf_accel_dev *accel_dev)
-{
-	void __iomem *addr;
-	u32 status;
-	u32 csr;
-	int ret;
-
-	addr = (&GET_BARS(accel_dev)[ADF_4XXX_PMISC_BAR])->virt_addr;
-
-	/* Temporarily mask PM interrupt */
-	csr = ADF_CSR_RD(addr, ADF_GEN4_ERRMSK2);
-	csr |= ADF_GEN4_PM_SOU;
-	ADF_CSR_WR(addr, ADF_GEN4_ERRMSK2, csr);
-
-	/* Set DRV_ACTIVE bit to power up the device */
-	ADF_CSR_WR(addr, ADF_GEN4_PM_INTERRUPT, ADF_GEN4_PM_DRV_ACTIVE);
-
-	/* Poll status register to make sure the device is powered up */
-	ret = read_poll_timeout(ADF_CSR_RD, status,
-				status & ADF_GEN4_PM_INIT_STATE,
-				ADF_GEN4_PM_POLL_DELAY_US,
-				ADF_GEN4_PM_POLL_TIMEOUT_US, true, addr,
-				ADF_GEN4_PM_STATUS);
-	if (ret)
-		dev_err(&GET_DEV(accel_dev), "Failed to power up the device\n");
-
-	return ret;
-}
-
 static u32 uof_get_num_objs(struct adf_accel_dev *accel_dev)
 {
 	return ARRAY_SIZE(adf_fw_cy_config);
@@ -530,37 +398,37 @@ void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data, u32 dev_id)
 {
 	hw_data->dev_class = &adf_4xxx_class;
 	hw_data->instance_id = adf_4xxx_class.instances++;
-	hw_data->num_banks = ADF_4XXX_ETR_MAX_BANKS;
-	hw_data->num_banks_per_vf = ADF_4XXX_NUM_BANKS_PER_VF;
-	hw_data->num_rings_per_bank = ADF_4XXX_NUM_RINGS_PER_BANK;
-	hw_data->num_accel = ADF_4XXX_MAX_ACCELERATORS;
+	hw_data->num_banks = ADF_GEN4_ETR_MAX_BANKS;
+	hw_data->num_banks_per_vf = ADF_GEN4_NUM_BANKS_PER_VF;
+	hw_data->num_rings_per_bank = ADF_GEN4_NUM_RINGS_PER_BANK;
+	hw_data->num_accel = ADF_GEN4_MAX_ACCELERATORS;
 	hw_data->num_engines = ADF_4XXX_MAX_ACCELENGINES;
 	hw_data->num_logical_accel = 1;
-	hw_data->tx_rx_gap = ADF_4XXX_RX_RINGS_OFFSET;
-	hw_data->tx_rings_mask = ADF_4XXX_TX_RINGS_MASK;
+	hw_data->tx_rx_gap = ADF_GEN4_RX_RINGS_OFFSET;
+	hw_data->tx_rings_mask = ADF_GEN4_TX_RINGS_MASK;
 	hw_data->ring_to_svc_map = ADF_GEN4_DEFAULT_RING_TO_SRV_MAP;
 	hw_data->alloc_irq = adf_isr_resource_alloc;
 	hw_data->free_irq = adf_isr_resource_free;
-	hw_data->enable_error_correction = adf_enable_error_correction;
-	hw_data->get_accel_mask = get_accel_mask;
+	hw_data->enable_error_correction = adf_gen4_enable_error_correction;
+	hw_data->get_accel_mask = adf_gen4_get_accel_mask;
 	hw_data->get_ae_mask = get_ae_mask;
-	hw_data->get_num_accels = get_num_accels;
-	hw_data->get_num_aes = get_num_aes;
-	hw_data->get_sram_bar_id = get_sram_bar_id;
-	hw_data->get_etr_bar_id = get_etr_bar_id;
-	hw_data->get_misc_bar_id = get_misc_bar_id;
-	hw_data->get_arb_info = get_arb_info;
-	hw_data->get_admin_info = get_admin_info;
+	hw_data->get_num_accels = adf_gen4_get_num_accels;
+	hw_data->get_num_aes = adf_gen4_get_num_aes;
+	hw_data->get_sram_bar_id = adf_gen4_get_sram_bar_id;
+	hw_data->get_etr_bar_id = adf_gen4_get_etr_bar_id;
+	hw_data->get_misc_bar_id = adf_gen4_get_misc_bar_id;
+	hw_data->get_arb_info = adf_gen4_get_arb_info;
+	hw_data->get_admin_info = adf_gen4_get_admin_info;
 	hw_data->get_accel_cap = get_accel_cap;
-	hw_data->get_sku = get_sku;
+	hw_data->get_sku = adf_gen4_get_sku;
 	hw_data->init_admin_comms = adf_init_admin_comms;
 	hw_data->exit_admin_comms = adf_exit_admin_comms;
 	hw_data->send_admin_init = adf_send_admin_init;
 	hw_data->init_arb = adf_init_arb;
 	hw_data->exit_arb = adf_exit_arb;
 	hw_data->get_arb_mapping = adf_get_arbiter_mapping;
-	hw_data->enable_ints = adf_enable_ints;
-	hw_data->init_device = adf_init_device;
+	hw_data->enable_ints = adf_gen4_enable_ints;
+	hw_data->init_device = adf_gen4_init_device;
 	hw_data->reset_device = adf_reset_flr;
 	hw_data->admin_ae_mask = ADF_4XXX_ADMIN_AE_MASK;
 	switch (dev_id) {
@@ -577,7 +445,7 @@ void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data, u32 dev_id)
 	}
 	hw_data->uof_get_num_objs = uof_get_num_objs;
 	hw_data->uof_get_ae_mask = uof_get_ae_mask;
-	hw_data->set_msix_rttable = set_msix_default_rttable;
+	hw_data->set_msix_rttable = adf_gen4_set_msix_default_rttable;
 	hw_data->set_ssm_wdtimer = adf_gen4_set_ssm_wdtimer;
 	hw_data->get_ring_to_svc_map = get_ring_to_svc_map;
 	hw_data->disable_iov = adf_disable_sriov;
@@ -587,7 +455,7 @@ void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data, u32 dev_id)
 	hw_data->dev_config = adf_gen4_dev_config;
 	hw_data->start_timer = adf_gen4_timer_start;
 	hw_data->stop_timer = adf_gen4_timer_stop;
-	hw_data->get_hb_clock = get_heartbeat_clock;
+	hw_data->get_hb_clock = adf_gen4_get_heartbeat_clock;
 	hw_data->num_hb_ctrs = ADF_NUM_HB_CNT_PER_AE;
 	hw_data->clock_frequency = ADF_4XXX_AE_FREQ;
 
diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.h b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.h
index 33423295e90f..76388363ea87 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.h
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.h
@@ -6,25 +6,8 @@
 #include <linux/units.h>
 #include <adf_accel_devices.h>
 
-/* PCIe configuration space */
-#define ADF_4XXX_SRAM_BAR		0
-#define ADF_4XXX_PMISC_BAR		1
-#define ADF_4XXX_ETR_BAR		2
-#define ADF_4XXX_RX_RINGS_OFFSET	1
-#define ADF_4XXX_TX_RINGS_MASK		0x1
-#define ADF_4XXX_MAX_ACCELERATORS	1
 #define ADF_4XXX_MAX_ACCELENGINES	9
-#define ADF_4XXX_BAR_MASK		(BIT(0) | BIT(2) | BIT(4))
 
-/* Physical function fuses */
-#define ADF_4XXX_FUSECTL0_OFFSET	(0x2C8)
-#define ADF_4XXX_FUSECTL1_OFFSET	(0x2CC)
-#define ADF_4XXX_FUSECTL2_OFFSET	(0x2D0)
-#define ADF_4XXX_FUSECTL3_OFFSET	(0x2D4)
-#define ADF_4XXX_FUSECTL4_OFFSET	(0x2D8)
-#define ADF_4XXX_FUSECTL5_OFFSET	(0x2DC)
-
-#define ADF_4XXX_ACCELERATORS_MASK	(0x1)
 #define ADF_4XXX_ACCELENGINES_MASK	(0x1FF)
 #define ADF_4XXX_ADMIN_AE_MASK		(0x100)
 
@@ -45,28 +28,6 @@
 	(BIT(4) | BIT(12) | BIT(16) | BIT(17) | BIT(18) | \
 	 BIT(19) | BIT(20) | BIT(21) | BIT(22) | BIT(23))
 
-#define ADF_4XXX_ETR_MAX_BANKS		64
-
-/* MSIX interrupt */
-#define ADF_4XXX_SMIAPF_RP_X0_MASK_OFFSET	(0x41A040)
-#define ADF_4XXX_SMIAPF_RP_X1_MASK_OFFSET	(0x41A044)
-#define ADF_4XXX_SMIAPF_MASK_OFFSET		(0x41A084)
-#define ADF_4XXX_MSIX_RTTABLE_OFFSET(i)		(0x409000 + ((i) * 0x04))
-
-/* Bank and ring configuration */
-#define ADF_4XXX_NUM_RINGS_PER_BANK	2
-#define ADF_4XXX_NUM_BANKS_PER_VF	4
-
-/* Arbiter configuration */
-#define ADF_4XXX_ARB_CONFIG			(BIT(31) | BIT(6) | BIT(0))
-#define ADF_4XXX_ARB_OFFSET			(0x0)
-#define ADF_4XXX_ARB_WRK_2_SER_MAP_OFFSET	(0x400)
-
-/* Admin Interface Reg Offset */
-#define ADF_4XXX_ADMINMSGUR_OFFSET	(0x500574)
-#define ADF_4XXX_ADMINMSGLR_OFFSET	(0x500578)
-#define ADF_4XXX_MAILBOX_BASE_OFFSET	(0x600970)
-
 /* Firmware Binaries */
 #define ADF_4XXX_FW		"qat_4xxx.bin"
 #define ADF_4XXX_MMP		"qat_4xxx_mmp.bin"
@@ -93,22 +54,9 @@
 #define ADF_4XXX_RL_SLICE_REF			1000UL
 
 /* Clocks frequency */
-#define ADF_4XXX_KPT_COUNTER_FREQ	(100 * HZ_PER_MHZ)
 #define ADF_4XXX_AE_FREQ		(1000 * HZ_PER_MHZ)
 
-/* qat_4xxx fuse bits are different from old GENs, redefine them */
-enum icp_qat_4xxx_slice_mask {
-	ICP_ACCEL_4XXX_MASK_CIPHER_SLICE = BIT(0),
-	ICP_ACCEL_4XXX_MASK_AUTH_SLICE = BIT(1),
-	ICP_ACCEL_4XXX_MASK_PKE_SLICE = BIT(2),
-	ICP_ACCEL_4XXX_MASK_COMPRESS_SLICE = BIT(3),
-	ICP_ACCEL_4XXX_MASK_UCS_SLICE = BIT(4),
-	ICP_ACCEL_4XXX_MASK_EIA3_SLICE = BIT(5),
-	ICP_ACCEL_4XXX_MASK_SMX_SLICE = BIT(7),
-};
-
 void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data, u32 dev_id);
 void adf_clean_hw_data_4xxx(struct adf_hw_device_data *hw_data);
-int adf_gen4_dev_config(struct adf_accel_dev *accel_dev);
 
 #endif
diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c b/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
index 8f483d1197dd..9762f2bf7727 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
@@ -8,13 +8,10 @@
 #include <adf_cfg.h>
 #include <adf_common_drv.h>
 #include <adf_dbgfs.h>
-#include <adf_heartbeat.h>
+#include <adf_gen4_config.h>
+#include <adf_gen4_hw_data.h>
 
 #include "adf_4xxx_hw_data.h"
-#include "adf_cfg_services.h"
-#include "qat_compression.h"
-#include "qat_crypto.h"
-#include "adf_transport_access_macros.h"
 
 static const struct pci_device_id adf_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, ADF_4XXX_PCI_DEVICE_ID), },
@@ -35,270 +32,6 @@ static void adf_cleanup_accel(struct adf_accel_dev *accel_dev)
 	adf_devmgr_rm_dev(accel_dev, NULL);
 }
 
-static int adf_cfg_dev_init(struct adf_accel_dev *accel_dev)
-{
-	const char *config;
-	int ret;
-
-	config = accel_dev->accel_id % 2 ? ADF_CFG_DC : ADF_CFG_CY;
-
-	ret = adf_cfg_section_add(accel_dev, ADF_GENERAL_SEC);
-	if (ret)
-		return ret;
-
-	/* Default configuration is crypto only for even devices
-	 * and compression for odd devices
-	 */
-	ret = adf_cfg_add_key_value_param(accel_dev, ADF_GENERAL_SEC,
-					  ADF_SERVICES_ENABLED, config,
-					  ADF_STR);
-	if (ret)
-		return ret;
-
-	adf_heartbeat_save_cfg_param(accel_dev, ADF_CFG_HB_TIMER_MIN_MS);
-
-	return 0;
-}
-
-static int adf_crypto_dev_config(struct adf_accel_dev *accel_dev)
-{
-	char key[ADF_CFG_MAX_KEY_LEN_IN_BYTES];
-	int banks = GET_MAX_BANKS(accel_dev);
-	int cpus = num_online_cpus();
-	unsigned long bank, val;
-	int instances;
-	int ret;
-	int i;
-
-	if (adf_hw_dev_has_crypto(accel_dev))
-		instances = min(cpus, banks / 2);
-	else
-		instances = 0;
-
-	for (i = 0; i < instances; i++) {
-		val = i;
-		bank = i * 2;
-		snprintf(key, sizeof(key), ADF_CY "%d" ADF_RING_ASYM_BANK_NUM, i);
-		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
-						  key, &bank, ADF_DEC);
-		if (ret)
-			goto err;
-
-		bank += 1;
-		snprintf(key, sizeof(key), ADF_CY "%d" ADF_RING_SYM_BANK_NUM, i);
-		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
-						  key, &bank, ADF_DEC);
-		if (ret)
-			goto err;
-
-		snprintf(key, sizeof(key), ADF_CY "%d" ADF_ETRMGR_CORE_AFFINITY,
-			 i);
-		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
-						  key, &val, ADF_DEC);
-		if (ret)
-			goto err;
-
-		snprintf(key, sizeof(key), ADF_CY "%d" ADF_RING_ASYM_SIZE, i);
-		val = 128;
-		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
-						  key, &val, ADF_DEC);
-		if (ret)
-			goto err;
-
-		val = 512;
-		snprintf(key, sizeof(key), ADF_CY "%d" ADF_RING_SYM_SIZE, i);
-		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
-						  key, &val, ADF_DEC);
-		if (ret)
-			goto err;
-
-		val = 0;
-		snprintf(key, sizeof(key), ADF_CY "%d" ADF_RING_ASYM_TX, i);
-		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
-						  key, &val, ADF_DEC);
-		if (ret)
-			goto err;
-
-		val = 0;
-		snprintf(key, sizeof(key), ADF_CY "%d" ADF_RING_SYM_TX, i);
-		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
-						  key, &val, ADF_DEC);
-		if (ret)
-			goto err;
-
-		val = 1;
-		snprintf(key, sizeof(key), ADF_CY "%d" ADF_RING_ASYM_RX, i);
-		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
-						  key, &val, ADF_DEC);
-		if (ret)
-			goto err;
-
-		val = 1;
-		snprintf(key, sizeof(key), ADF_CY "%d" ADF_RING_SYM_RX, i);
-		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
-						  key, &val, ADF_DEC);
-		if (ret)
-			goto err;
-
-		val = ADF_COALESCING_DEF_TIME;
-		snprintf(key, sizeof(key), ADF_ETRMGR_COALESCE_TIMER_FORMAT, i);
-		ret = adf_cfg_add_key_value_param(accel_dev, "Accelerator0",
-						  key, &val, ADF_DEC);
-		if (ret)
-			goto err;
-	}
-
-	val = i;
-	ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC, ADF_NUM_CY,
-					  &val, ADF_DEC);
-	if (ret)
-		goto err;
-
-	val = 0;
-	ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC, ADF_NUM_DC,
-					  &val, ADF_DEC);
-	if (ret)
-		goto err;
-
-	return 0;
-err:
-	dev_err(&GET_DEV(accel_dev), "Failed to add configuration for crypto\n");
-	return ret;
-}
-
-static int adf_comp_dev_config(struct adf_accel_dev *accel_dev)
-{
-	char key[ADF_CFG_MAX_KEY_LEN_IN_BYTES];
-	int banks = GET_MAX_BANKS(accel_dev);
-	int cpus = num_online_cpus();
-	unsigned long val;
-	int instances;
-	int ret;
-	int i;
-
-	if (adf_hw_dev_has_compression(accel_dev))
-		instances = min(cpus, banks);
-	else
-		instances = 0;
-
-	for (i = 0; i < instances; i++) {
-		val = i;
-		snprintf(key, sizeof(key), ADF_DC "%d" ADF_RING_DC_BANK_NUM, i);
-		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
-						  key, &val, ADF_DEC);
-		if (ret)
-			goto err;
-
-		val = 512;
-		snprintf(key, sizeof(key), ADF_DC "%d" ADF_RING_DC_SIZE, i);
-		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
-						  key, &val, ADF_DEC);
-		if (ret)
-			goto err;
-
-		val = 0;
-		snprintf(key, sizeof(key), ADF_DC "%d" ADF_RING_DC_TX, i);
-		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
-						  key, &val, ADF_DEC);
-		if (ret)
-			goto err;
-
-		val = 1;
-		snprintf(key, sizeof(key), ADF_DC "%d" ADF_RING_DC_RX, i);
-		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
-						  key, &val, ADF_DEC);
-		if (ret)
-			goto err;
-
-		val = ADF_COALESCING_DEF_TIME;
-		snprintf(key, sizeof(key), ADF_ETRMGR_COALESCE_TIMER_FORMAT, i);
-		ret = adf_cfg_add_key_value_param(accel_dev, "Accelerator0",
-						  key, &val, ADF_DEC);
-		if (ret)
-			goto err;
-	}
-
-	val = i;
-	ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC, ADF_NUM_DC,
-					  &val, ADF_DEC);
-	if (ret)
-		goto err;
-
-	val = 0;
-	ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC, ADF_NUM_CY,
-					  &val, ADF_DEC);
-	if (ret)
-		goto err;
-
-	return 0;
-err:
-	dev_err(&GET_DEV(accel_dev), "Failed to add configuration for compression\n");
-	return ret;
-}
-
-static int adf_no_dev_config(struct adf_accel_dev *accel_dev)
-{
-	unsigned long val;
-	int ret;
-
-	val = 0;
-	ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC, ADF_NUM_DC,
-					  &val, ADF_DEC);
-	if (ret)
-		return ret;
-
-	return adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC, ADF_NUM_CY,
-					  &val, ADF_DEC);
-}
-
-int adf_gen4_dev_config(struct adf_accel_dev *accel_dev)
-{
-	char services[ADF_CFG_MAX_VAL_LEN_IN_BYTES] = {0};
-	int ret;
-
-	ret = adf_cfg_section_add(accel_dev, ADF_KERNEL_SEC);
-	if (ret)
-		goto err;
-
-	ret = adf_cfg_section_add(accel_dev, "Accelerator0");
-	if (ret)
-		goto err;
-
-	ret = adf_cfg_get_param_value(accel_dev, ADF_GENERAL_SEC,
-				      ADF_SERVICES_ENABLED, services);
-	if (ret)
-		goto err;
-
-	ret = sysfs_match_string(adf_cfg_services, services);
-	if (ret < 0)
-		goto err;
-
-	switch (ret) {
-	case SVC_CY:
-	case SVC_CY2:
-		ret = adf_crypto_dev_config(accel_dev);
-		break;
-	case SVC_DC:
-	case SVC_DCC:
-		ret = adf_comp_dev_config(accel_dev);
-		break;
-	default:
-		ret = adf_no_dev_config(accel_dev);
-		break;
-	}
-
-	if (ret)
-		goto err;
-
-	set_bit(ADF_STATUS_CONFIGURED, &accel_dev->status);
-
-	return ret;
-
-err:
-	dev_err(&GET_DEV(accel_dev), "Failed to configure QAT driver\n");
-	return ret;
-}
-
 static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct adf_accel_dev *accel_dev;
@@ -348,7 +81,7 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adf_init_hw_data_4xxx(accel_dev->hw_device, ent->device);
 
 	pci_read_config_byte(pdev, PCI_REVISION_ID, &accel_pci_dev->revid);
-	pci_read_config_dword(pdev, ADF_4XXX_FUSECTL4_OFFSET, &hw_data->fuses);
+	pci_read_config_dword(pdev, ADF_GEN4_FUSECTL4_OFFSET, &hw_data->fuses);
 
 	/* Get Accelerators and Accelerators Engines masks */
 	hw_data->accel_mask = hw_data->get_accel_mask(hw_data);
@@ -381,7 +114,7 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto out_err;
 	}
 
-	ret = adf_cfg_dev_init(accel_dev);
+	ret = adf_gen4_cfg_dev_init(accel_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize configuration.\n");
 		goto out_err;
@@ -396,7 +129,7 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	/* Find and map all the device's BARS */
-	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM) & ADF_4XXX_BAR_MASK;
+	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM) & ADF_GEN4_BAR_MASK;
 
 	ret = pcim_iomap_regions_request_all(pdev, bar_mask, pci_name(pdev));
 	if (ret) {
diff --git a/drivers/crypto/intel/qat/qat_common/Makefile b/drivers/crypto/intel/qat/qat_common/Makefile
index 779a8aa0b8d2..928de6997155 100644
--- a/drivers/crypto/intel/qat/qat_common/Makefile
+++ b/drivers/crypto/intel/qat/qat_common/Makefile
@@ -16,6 +16,7 @@ intel_qat-objs := adf_cfg.o \
 	adf_sysfs_ras_counters.o \
 	adf_gen2_hw_data.o \
 	adf_gen2_config.o \
+	adf_gen4_config.o \
 	adf_gen4_hw_data.o \
 	adf_gen4_pm.o \
 	adf_gen2_dc.o \
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_config.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_config.c
new file mode 100644
index 000000000000..fe1f3d727dc5
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_config.c
@@ -0,0 +1,287 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation */
+#include "adf_accel_devices.h"
+#include "adf_cfg.h"
+#include "adf_cfg_services.h"
+#include "adf_cfg_strings.h"
+#include "adf_common_drv.h"
+#include "adf_gen4_config.h"
+#include "adf_heartbeat.h"
+#include "adf_transport_access_macros.h"
+#include "qat_compression.h"
+#include "qat_crypto.h"
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
+	val = 0;
+	ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC, ADF_NUM_DC,
+					  &val, ADF_DEC);
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+	dev_err(&GET_DEV(accel_dev), "Failed to add configuration for crypto\n");
+	return ret;
+}
+
+static int adf_comp_dev_config(struct adf_accel_dev *accel_dev)
+{
+	char key[ADF_CFG_MAX_KEY_LEN_IN_BYTES];
+	int banks = GET_MAX_BANKS(accel_dev);
+	int cpus = num_online_cpus();
+	unsigned long val;
+	int instances;
+	int ret;
+	int i;
+
+	if (adf_hw_dev_has_compression(accel_dev))
+		instances = min(cpus, banks);
+	else
+		instances = 0;
+
+	for (i = 0; i < instances; i++) {
+		val = i;
+		snprintf(key, sizeof(key), ADF_DC "%d" ADF_RING_DC_BANK_NUM, i);
+		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
+						  key, &val, ADF_DEC);
+		if (ret)
+			goto err;
+
+		val = 512;
+		snprintf(key, sizeof(key), ADF_DC "%d" ADF_RING_DC_SIZE, i);
+		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
+						  key, &val, ADF_DEC);
+		if (ret)
+			goto err;
+
+		val = 0;
+		snprintf(key, sizeof(key), ADF_DC "%d" ADF_RING_DC_TX, i);
+		ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
+						  key, &val, ADF_DEC);
+		if (ret)
+			goto err;
+
+		val = 1;
+		snprintf(key, sizeof(key), ADF_DC "%d" ADF_RING_DC_RX, i);
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
+	ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC, ADF_NUM_DC,
+					  &val, ADF_DEC);
+	if (ret)
+		goto err;
+
+	val = 0;
+	ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC, ADF_NUM_CY,
+					  &val, ADF_DEC);
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+	dev_err(&GET_DEV(accel_dev), "Failed to add configuration for compression\n");
+	return ret;
+}
+
+static int adf_no_dev_config(struct adf_accel_dev *accel_dev)
+{
+	unsigned long val;
+	int ret;
+
+	val = 0;
+	ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC, ADF_NUM_DC,
+					  &val, ADF_DEC);
+	if (ret)
+		return ret;
+
+	return adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC, ADF_NUM_CY,
+					  &val, ADF_DEC);
+}
+
+/**
+ * adf_gen4_dev_config() - create dev config required to create instances
+ *
+ * @accel_dev: Pointer to acceleration device.
+ *
+ * Function creates device configuration required to create instances
+ *
+ * Return: 0 on success, error code otherwise.
+ */
+int adf_gen4_dev_config(struct adf_accel_dev *accel_dev)
+{
+	char services[ADF_CFG_MAX_VAL_LEN_IN_BYTES] = {0};
+	int ret;
+
+	ret = adf_cfg_section_add(accel_dev, ADF_KERNEL_SEC);
+	if (ret)
+		goto err;
+
+	ret = adf_cfg_section_add(accel_dev, "Accelerator0");
+	if (ret)
+		goto err;
+
+	ret = adf_cfg_get_param_value(accel_dev, ADF_GENERAL_SEC,
+				      ADF_SERVICES_ENABLED, services);
+	if (ret)
+		goto err;
+
+	ret = sysfs_match_string(adf_cfg_services, services);
+	if (ret < 0)
+		goto err;
+
+	switch (ret) {
+	case SVC_CY:
+	case SVC_CY2:
+		ret = adf_crypto_dev_config(accel_dev);
+		break;
+	case SVC_DC:
+	case SVC_DCC:
+		ret = adf_comp_dev_config(accel_dev);
+		break;
+	default:
+		ret = adf_no_dev_config(accel_dev);
+		break;
+	}
+
+	if (ret)
+		goto err;
+
+	set_bit(ADF_STATUS_CONFIGURED, &accel_dev->status);
+
+	return ret;
+
+err:
+	dev_err(&GET_DEV(accel_dev), "Failed to configure QAT driver\n");
+	return ret;
+}
+EXPORT_SYMBOL_GPL(adf_gen4_dev_config);
+
+int adf_gen4_cfg_dev_init(struct adf_accel_dev *accel_dev)
+{
+	const char *config;
+	int ret;
+
+	config = accel_dev->accel_id % 2 ? ADF_CFG_DC : ADF_CFG_CY;
+
+	ret = adf_cfg_section_add(accel_dev, ADF_GENERAL_SEC);
+	if (ret)
+		return ret;
+
+	/* Default configuration is crypto only for even devices
+	 * and compression for odd devices
+	 */
+	ret = adf_cfg_add_key_value_param(accel_dev, ADF_GENERAL_SEC,
+					  ADF_SERVICES_ENABLED, config,
+					  ADF_STR);
+	if (ret)
+		return ret;
+
+	adf_heartbeat_save_cfg_param(accel_dev, ADF_CFG_HB_TIMER_MIN_MS);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(adf_gen4_cfg_dev_init);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_config.h b/drivers/crypto/intel/qat/qat_common/adf_gen4_config.h
new file mode 100644
index 000000000000..bb87655f69a8
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_config.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2023 Intel Corporation */
+#ifndef ADF_GEN4_CONFIG_H_
+#define ADF_GEN4_CONFIG_H_
+
+#include "adf_accel_devices.h"
+
+int adf_gen4_dev_config(struct adf_accel_dev *accel_dev);
+int adf_gen4_cfg_dev_init(struct adf_accel_dev *accel_dev);
+
+#endif
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
index 3148a62938fd..ee08b34876dd 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
@@ -4,6 +4,7 @@
 #include "adf_accel_devices.h"
 #include "adf_common_drv.h"
 #include "adf_gen4_hw_data.h"
+#include "adf_gen4_pm.h"
 
 static u64 build_csr_ring_base_addr(dma_addr_t addr, u32 size)
 {
@@ -102,6 +103,131 @@ void adf_gen4_init_hw_csr_ops(struct adf_hw_csr_ops *csr_ops)
 }
 EXPORT_SYMBOL_GPL(adf_gen4_init_hw_csr_ops);
 
+u32 adf_gen4_get_accel_mask(struct adf_hw_device_data *self)
+{
+	return ADF_GEN4_ACCELERATORS_MASK;
+}
+EXPORT_SYMBOL_GPL(adf_gen4_get_accel_mask);
+
+u32 adf_gen4_get_num_accels(struct adf_hw_device_data *self)
+{
+	return ADF_GEN4_MAX_ACCELERATORS;
+}
+EXPORT_SYMBOL_GPL(adf_gen4_get_num_accels);
+
+u32 adf_gen4_get_num_aes(struct adf_hw_device_data *self)
+{
+	if (!self || !self->ae_mask)
+		return 0;
+
+	return hweight32(self->ae_mask);
+}
+EXPORT_SYMBOL_GPL(adf_gen4_get_num_aes);
+
+u32 adf_gen4_get_misc_bar_id(struct adf_hw_device_data *self)
+{
+	return ADF_GEN4_PMISC_BAR;
+}
+EXPORT_SYMBOL_GPL(adf_gen4_get_misc_bar_id);
+
+u32 adf_gen4_get_etr_bar_id(struct adf_hw_device_data *self)
+{
+	return ADF_GEN4_ETR_BAR;
+}
+EXPORT_SYMBOL_GPL(adf_gen4_get_etr_bar_id);
+
+u32 adf_gen4_get_sram_bar_id(struct adf_hw_device_data *self)
+{
+	return ADF_GEN4_SRAM_BAR;
+}
+EXPORT_SYMBOL_GPL(adf_gen4_get_sram_bar_id);
+
+enum dev_sku_info adf_gen4_get_sku(struct adf_hw_device_data *self)
+{
+	return DEV_SKU_1;
+}
+EXPORT_SYMBOL_GPL(adf_gen4_get_sku);
+
+void adf_gen4_get_arb_info(struct arb_info *arb_info)
+{
+	arb_info->arb_cfg = ADF_GEN4_ARB_CONFIG;
+	arb_info->arb_offset = ADF_GEN4_ARB_OFFSET;
+	arb_info->wt2sam_offset = ADF_GEN4_ARB_WRK_2_SER_MAP_OFFSET;
+}
+EXPORT_SYMBOL_GPL(adf_gen4_get_arb_info);
+
+void adf_gen4_get_admin_info(struct admin_info *admin_csrs_info)
+{
+	admin_csrs_info->mailbox_offset = ADF_GEN4_MAILBOX_BASE_OFFSET;
+	admin_csrs_info->admin_msg_ur = ADF_GEN4_ADMINMSGUR_OFFSET;
+	admin_csrs_info->admin_msg_lr = ADF_GEN4_ADMINMSGLR_OFFSET;
+}
+EXPORT_SYMBOL_GPL(adf_gen4_get_admin_info);
+
+u32 adf_gen4_get_heartbeat_clock(struct adf_hw_device_data *self)
+{
+	/*
+	 * GEN4 uses KPT counter for HB
+	 */
+	return ADF_GEN4_KPT_COUNTER_FREQ;
+}
+EXPORT_SYMBOL_GPL(adf_gen4_get_heartbeat_clock);
+
+void adf_gen4_enable_error_correction(struct adf_accel_dev *accel_dev)
+{
+	struct adf_bar *misc_bar = &GET_BARS(accel_dev)[ADF_GEN4_PMISC_BAR];
+	void __iomem *csr = misc_bar->virt_addr;
+
+	/* Enable all in errsou3 except VFLR notification on host */
+	ADF_CSR_WR(csr, ADF_GEN4_ERRMSK3, ADF_GEN4_VFLNOTIFY);
+}
+EXPORT_SYMBOL_GPL(adf_gen4_enable_error_correction);
+
+void adf_gen4_enable_ints(struct adf_accel_dev *accel_dev)
+{
+	void __iomem *addr;
+
+	addr = (&GET_BARS(accel_dev)[ADF_GEN4_PMISC_BAR])->virt_addr;
+
+	/* Enable bundle interrupts */
+	ADF_CSR_WR(addr, ADF_GEN4_SMIAPF_RP_X0_MASK_OFFSET, 0);
+	ADF_CSR_WR(addr, ADF_GEN4_SMIAPF_RP_X1_MASK_OFFSET, 0);
+
+	/* Enable misc interrupts */
+	ADF_CSR_WR(addr, ADF_GEN4_SMIAPF_MASK_OFFSET, 0);
+}
+EXPORT_SYMBOL_GPL(adf_gen4_enable_ints);
+
+int adf_gen4_init_device(struct adf_accel_dev *accel_dev)
+{
+	void __iomem *addr;
+	u32 status;
+	u32 csr;
+	int ret;
+
+	addr = (&GET_BARS(accel_dev)[ADF_GEN4_PMISC_BAR])->virt_addr;
+
+	/* Temporarily mask PM interrupt */
+	csr = ADF_CSR_RD(addr, ADF_GEN4_ERRMSK2);
+	csr |= ADF_GEN4_PM_SOU;
+	ADF_CSR_WR(addr, ADF_GEN4_ERRMSK2, csr);
+
+	/* Set DRV_ACTIVE bit to power up the device */
+	ADF_CSR_WR(addr, ADF_GEN4_PM_INTERRUPT, ADF_GEN4_PM_DRV_ACTIVE);
+
+	/* Poll status register to make sure the device is powered up */
+	ret = read_poll_timeout(ADF_CSR_RD, status,
+				status & ADF_GEN4_PM_INIT_STATE,
+				ADF_GEN4_PM_POLL_DELAY_US,
+				ADF_GEN4_PM_POLL_TIMEOUT_US, true, addr,
+				ADF_GEN4_PM_STATUS);
+	if (ret)
+		dev_err(&GET_DEV(accel_dev), "Failed to power up the device\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(adf_gen4_init_device);
+
 static inline void adf_gen4_unpack_ssm_wdtimer(u64 value, u32 *upper,
 					       u32 *lower)
 {
@@ -135,6 +261,28 @@ void adf_gen4_set_ssm_wdtimer(struct adf_accel_dev *accel_dev)
 }
 EXPORT_SYMBOL_GPL(adf_gen4_set_ssm_wdtimer);
 
+/*
+ * The vector routing table is used to select the MSI-X entry to use for each
+ * interrupt source.
+ * The first ADF_GEN4_ETR_MAX_BANKS entries correspond to ring interrupts.
+ * The final entry corresponds to VF2PF or error interrupts.
+ * This vector table could be used to configure one MSI-X entry to be shared
+ * between multiple interrupt sources.
+ *
+ * The default routing is set to have a one to one correspondence between the
+ * interrupt source and the MSI-X entry used.
+ */
+void adf_gen4_set_msix_default_rttable(struct adf_accel_dev *accel_dev)
+{
+	void __iomem *csr;
+	int i;
+
+	csr = (&GET_BARS(accel_dev)[ADF_GEN4_PMISC_BAR])->virt_addr;
+	for (i = 0; i <= ADF_GEN4_ETR_MAX_BANKS; i++)
+		ADF_CSR_WR(csr, ADF_GEN4_MSIX_RTTABLE_OFFSET(i), i);
+}
+EXPORT_SYMBOL_GPL(adf_gen4_set_msix_default_rttable);
+
 int adf_pfvf_comms_disabled(struct adf_accel_dev *accel_dev)
 {
 	return 0;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
index 1813fe1d5a06..b42fb8048c04 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
@@ -3,9 +3,55 @@
 #ifndef ADF_GEN4_HW_CSR_DATA_H_
 #define ADF_GEN4_HW_CSR_DATA_H_
 
+#include <linux/units.h>
+
 #include "adf_accel_devices.h"
 #include "adf_cfg_common.h"
 
+/* PCIe configuration space */
+#define ADF_GEN4_BAR_MASK	(BIT(0) | BIT(2) | BIT(4))
+#define ADF_GEN4_SRAM_BAR	0
+#define ADF_GEN4_PMISC_BAR	1
+#define ADF_GEN4_ETR_BAR	2
+
+/* Clocks frequency */
+#define ADF_GEN4_KPT_COUNTER_FREQ	(100 * HZ_PER_MHZ)
+
+/* Physical function fuses */
+#define ADF_GEN4_FUSECTL0_OFFSET	0x2C8
+#define ADF_GEN4_FUSECTL1_OFFSET	0x2CC
+#define ADF_GEN4_FUSECTL2_OFFSET	0x2D0
+#define ADF_GEN4_FUSECTL3_OFFSET	0x2D4
+#define ADF_GEN4_FUSECTL4_OFFSET	0x2D8
+#define ADF_GEN4_FUSECTL5_OFFSET	0x2DC
+
+/* Accelerators */
+#define ADF_GEN4_ACCELERATORS_MASK	0x1
+#define ADF_GEN4_MAX_ACCELERATORS	1
+
+/* MSIX interrupt */
+#define ADF_GEN4_SMIAPF_RP_X0_MASK_OFFSET	0x41A040
+#define ADF_GEN4_SMIAPF_RP_X1_MASK_OFFSET	0x41A044
+#define ADF_GEN4_SMIAPF_MASK_OFFSET		0x41A084
+#define ADF_GEN4_MSIX_RTTABLE_OFFSET(i)		(0x409000 + ((i) * 0x04))
+
+/* Bank and ring configuration */
+#define ADF_GEN4_NUM_RINGS_PER_BANK	2
+#define ADF_GEN4_NUM_BANKS_PER_VF	4
+#define ADF_GEN4_ETR_MAX_BANKS		64
+#define ADF_GEN4_RX_RINGS_OFFSET	1
+#define ADF_GEN4_TX_RINGS_MASK		0x1
+
+/* Arbiter configuration */
+#define ADF_GEN4_ARB_CONFIG			(BIT(31) | BIT(6) | BIT(0))
+#define ADF_GEN4_ARB_OFFSET			0x0
+#define ADF_GEN4_ARB_WRK_2_SER_MAP_OFFSET	0x400
+
+/* Admin Interface Reg Offset */
+#define ADF_GEN4_ADMINMSGUR_OFFSET	0x500574
+#define ADF_GEN4_ADMINMSGLR_OFFSET	0x500578
+#define ADF_GEN4_MAILBOX_BASE_OFFSET	0x600970
+
 /* Transport access */
 #define ADF_BANK_INT_SRC_SEL_MASK	0x44UL
 #define ADF_RING_CSR_RING_CONFIG	0x1000
@@ -147,6 +193,32 @@ do { \
 #define ADF_GEN4_RL_TOKEN_PCIEOUT_BUCKET_OFFSET	0x508804
 
 void adf_gen4_set_ssm_wdtimer(struct adf_accel_dev *accel_dev);
+
+enum icp_qat_gen4_slice_mask {
+	ICP_ACCEL_GEN4_MASK_CIPHER_SLICE = BIT(0),
+	ICP_ACCEL_GEN4_MASK_AUTH_SLICE = BIT(1),
+	ICP_ACCEL_GEN4_MASK_PKE_SLICE = BIT(2),
+	ICP_ACCEL_GEN4_MASK_COMPRESS_SLICE = BIT(3),
+	ICP_ACCEL_GEN4_MASK_UCS_SLICE = BIT(4),
+	ICP_ACCEL_GEN4_MASK_EIA3_SLICE = BIT(5),
+	ICP_ACCEL_GEN4_MASK_SMX_SLICE = BIT(7),
+};
+
+void adf_gen4_enable_error_correction(struct adf_accel_dev *accel_dev);
+void adf_gen4_enable_ints(struct adf_accel_dev *accel_dev);
+u32 adf_gen4_get_accel_mask(struct adf_hw_device_data *self);
+void adf_gen4_get_admin_info(struct admin_info *admin_csrs_info);
+void adf_gen4_get_arb_info(struct arb_info *arb_info);
+u32 adf_gen4_get_etr_bar_id(struct adf_hw_device_data *self);
+u32 adf_gen4_get_heartbeat_clock(struct adf_hw_device_data *self);
+u32 adf_gen4_get_misc_bar_id(struct adf_hw_device_data *self);
+u32 adf_gen4_get_num_accels(struct adf_hw_device_data *self);
+u32 adf_gen4_get_num_aes(struct adf_hw_device_data *self);
+enum dev_sku_info adf_gen4_get_sku(struct adf_hw_device_data *self);
+u32 adf_gen4_get_sram_bar_id(struct adf_hw_device_data *self);
+int adf_gen4_init_device(struct adf_accel_dev *accel_dev);
 void adf_gen4_init_hw_csr_ops(struct adf_hw_csr_ops *csr_ops);
 int adf_gen4_ring_pair_reset(struct adf_accel_dev *accel_dev, u32 bank_number);
+void adf_gen4_set_msix_default_rttable(struct adf_accel_dev *accel_dev);
+void adf_gen4_set_ssm_wdtimer(struct adf_accel_dev *accel_dev);
 #endif
-- 
2.32.0



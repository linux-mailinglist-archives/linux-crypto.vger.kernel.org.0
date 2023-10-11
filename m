Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39577C5413
	for <lists+linux-crypto@lfdr.de>; Wed, 11 Oct 2023 14:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjJKMgd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 11 Oct 2023 08:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjJKMg3 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 11 Oct 2023 08:36:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D309E
        for <linux-crypto@vger.kernel.org>; Wed, 11 Oct 2023 05:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697027784; x=1728563784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v6IUw6gDPncLTBvPkTmUN/6ErcFu739oQxFGqgfL2n0=;
  b=iePZNilw9MJWBleeLItmen7rO9sOAJiiddS/9j1i+WPmnCjrDK/PQR5g
   D/wEOYbepOeCLQdlRu56v5k3WFt90sPobAMXz5efSECiGokMdm+fN6ia5
   Vy2nRm3myBqdJU/z/mVj1BM/WnYx7eU7MJa8WNsvJ1scTA/eUlA1Jbif+
   n4RIwRBdoq01EOhWq5VEwO2ymceA3VBrgXkX2CQgM+cl/dOBkWfOpjoix
   g+ilqd6WTkoAHl6Jrgr200XnkjWgjSMdVQIF9uLSzPneZjBgjf7eOr3FQ
   PR0yLIWqSpDknwvXhrS12Er2XmfMJs3e73pueiXbz+p9RFSj5BkwKj8IO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="374992908"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="374992908"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 05:36:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="870124679"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="870124679"
Received: from r031s002_zp31l10c01.deacluster.intel.com (HELO localhost.localdomain) ([10.219.171.29])
  by fmsmga002.fm.intel.com with ESMTP; 11 Oct 2023 05:36:22 -0700
From:   Damian Muszynski <damian.muszynski@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Damian Muszynski <damian.muszynski@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH 08/11] crypto: qat - add rate limiting feature to qat_4xxx
Date:   Wed, 11 Oct 2023 14:15:06 +0200
Message-ID: <20231011121934.45255-9-damian.muszynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011121934.45255-1-damian.muszynski@intel.com>
References: <20231011121934.45255-1-damian.muszynski@intel.com>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The Rate Limiting (RL) feature allows to control the rate of requests
that can be submitted on a ring pair (RP). This allows sharing a QAT
device among multiple users while ensuring a guaranteed throughput.

Configuration of RL is accomplished through entities called SLAs
(Service Level Agreement). Each SLA object gets a unique identifier
and defines the limitations for a single service across up to four
ring pairs (RPs count allocated to a single VF).

The rate is determined using two fields:
  * CIR (Committed Information Rate), i.e., the guaranteed rate.
  * PIR (Peak Information Rate), i.e., the maximum rate achievable
    when the device has available resources.
The rate values are expressed in permille scale i.e. 0-1000.
Ring pair selection is achieved by providing a 64-bit mask, where
each bit corresponds to one of the ring pairs.

This adds an interface and logic that allow to add, update, retrieve
and remove an SLA.

Signed-off-by: Damian Muszynski <damian.muszynski@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     |   20 +
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.h     |   13 +-
 drivers/crypto/intel/qat/qat_common/Makefile  |    2 +
 .../intel/qat/qat_common/adf_accel_devices.h  |    3 +
 .../crypto/intel/qat/qat_common/adf_admin.c   |   47 +
 .../crypto/intel/qat/qat_common/adf_admin.h   |    8 +
 .../intel/qat/qat_common/adf_gen4_hw_data.h   |    7 +
 .../crypto/intel/qat/qat_common/adf_init.c    |    9 +
 drivers/crypto/intel/qat/qat_common/adf_rl.c  | 1176 +++++++++++++++++
 drivers/crypto/intel/qat/qat_common/adf_rl.h  |  169 +++
 .../intel/qat/qat_common/adf_rl_admin.c       |   98 ++
 .../intel/qat/qat_common/adf_rl_admin.h       |   18 +
 .../qat/qat_common/icp_qat_fw_init_admin.h    |   38 +
 13 files changed, 1607 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_rl.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_rl.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_rl_admin.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_rl_admin.h

diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
index 8a80701b7791..bc3745f0018f 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -342,6 +342,24 @@ static u32 get_heartbeat_clock(struct adf_hw_device_data *self)
 	return ADF_4XXX_KPT_COUNTER_FREQ;
 }
 
+static void adf_init_rl_data(struct adf_rl_hw_data *rl_data)
+{
+	rl_data->pciout_tb_offset = ADF_GEN4_RL_TOKEN_PCIEOUT_BUCKET_OFFSET;
+	rl_data->pciin_tb_offset = ADF_GEN4_RL_TOKEN_PCIEIN_BUCKET_OFFSET;
+	rl_data->r2l_offset = ADF_GEN4_RL_R2L_OFFSET;
+	rl_data->l2c_offset = ADF_GEN4_RL_L2C_OFFSET;
+	rl_data->c2s_offset = ADF_GEN4_RL_C2S_OFFSET;
+
+	rl_data->pcie_scale_div = ADF_4XXX_RL_PCIE_SCALE_FACTOR_DIV;
+	rl_data->pcie_scale_mul = ADF_4XXX_RL_PCIE_SCALE_FACTOR_MUL;
+	rl_data->dcpr_correction = ADF_4XXX_RL_DCPR_CORRECTION;
+	rl_data->max_tp[ADF_SVC_ASYM] = ADF_4XXX_RL_MAX_TP_ASYM;
+	rl_data->max_tp[ADF_SVC_SYM] = ADF_4XXX_RL_MAX_TP_SYM;
+	rl_data->max_tp[ADF_SVC_DC] = ADF_4XXX_RL_MAX_TP_DC;
+	rl_data->scan_interval = ADF_4XXX_RL_SCANS_PER_SEC;
+	rl_data->scale_ref = ADF_4XXX_RL_SLICE_REF;
+}
+
 static void adf_enable_error_correction(struct adf_accel_dev *accel_dev)
 {
 	struct adf_bar *misc_bar = &GET_BARS(accel_dev)[ADF_4XXX_PMISC_BAR];
@@ -583,10 +601,12 @@ void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data, u32 dev_id)
 	hw_data->stop_timer = adf_gen4_timer_stop;
 	hw_data->get_hb_clock = get_heartbeat_clock;
 	hw_data->num_hb_ctrs = ADF_NUM_HB_CNT_PER_AE;
+	hw_data->clock_frequency = ADF_4XXX_AE_FREQ;
 
 	adf_gen4_init_hw_csr_ops(&hw_data->csr_ops);
 	adf_gen4_init_pf_pfvf_ops(&hw_data->pfvf_ops);
 	adf_gen4_init_dc_ops(&hw_data->dc_ops);
+	adf_init_rl_data(&hw_data->rl_data);
 }
 
 void adf_clean_hw_data_4xxx(struct adf_hw_device_data *hw_data)
diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.h b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.h
index bb3d95a8fb21..590cbe816b7b 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.h
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.h
@@ -65,8 +65,19 @@
 #define ADF_402XX_ASYM_OBJ	"qat_402xx_asym.bin"
 #define ADF_402XX_ADMIN_OBJ	"qat_402xx_admin.bin"
 
+/* RL constants */
+#define ADF_4XXX_RL_PCIE_SCALE_FACTOR_DIV	100
+#define ADF_4XXX_RL_PCIE_SCALE_FACTOR_MUL	102
+#define ADF_4XXX_RL_DCPR_CORRECTION		1
+#define ADF_4XXX_RL_SCANS_PER_SEC		954
+#define ADF_4XXX_RL_MAX_TP_ASYM			173750UL
+#define ADF_4XXX_RL_MAX_TP_SYM			95000UL
+#define ADF_4XXX_RL_MAX_TP_DC			45000UL
+#define ADF_4XXX_RL_SLICE_REF			1000UL
+
 /* Clocks frequency */
-#define ADF_4XXX_KPT_COUNTER_FREQ (100 * HZ_PER_MHZ)
+#define ADF_4XXX_KPT_COUNTER_FREQ	(100 * HZ_PER_MHZ)
+#define ADF_4XXX_AE_FREQ		(1000 * HZ_PER_MHZ)
 
 /* qat_4xxx fuse bits are different from old GENs, redefine them */
 enum icp_qat_4xxx_slice_mask {
diff --git a/drivers/crypto/intel/qat/qat_common/Makefile b/drivers/crypto/intel/qat/qat_common/Makefile
index 204c7d0aa31e..77f8c484d49c 100644
--- a/drivers/crypto/intel/qat/qat_common/Makefile
+++ b/drivers/crypto/intel/qat/qat_common/Makefile
@@ -26,6 +26,8 @@ intel_qat-objs := adf_cfg.o \
 	qat_algs.o \
 	qat_asym_algs.o \
 	qat_algs_send.o \
+	adf_rl.o \
+	adf_rl_admin.o \
 	qat_uclo.o \
 	qat_hal.o \
 	qat_bl.o
diff --git a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
index 45742226a96f..35b805b9a136 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
@@ -8,6 +8,7 @@
 #include <linux/io.h>
 #include <linux/ratelimit.h>
 #include "adf_cfg_common.h"
+#include "adf_rl.h"
 #include "adf_pfvf_msg.h"
 
 #define ADF_DH895XCC_DEVICE_NAME "dh895xcc"
@@ -215,6 +216,7 @@ struct adf_hw_device_data {
 	struct adf_pfvf_ops pfvf_ops;
 	struct adf_hw_csr_ops csr_ops;
 	struct adf_dc_ops dc_ops;
+	struct adf_rl_hw_data rl_data;
 	const char *fw_name;
 	const char *fw_mmp_name;
 	u32 fuses;
@@ -325,6 +327,7 @@ struct adf_accel_dev {
 	struct adf_accel_pci accel_pci_dev;
 	struct adf_timer *timer;
 	struct adf_heartbeat *heartbeat;
+	struct adf_rl *rate_limiting;
 	union {
 		struct {
 			/* protects VF2PF interrupts access */
diff --git a/drivers/crypto/intel/qat/qat_common/adf_admin.c b/drivers/crypto/intel/qat/qat_common/adf_admin.c
index 9ff00eb4cc67..b9cd21f772d3 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_admin.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_admin.c
@@ -330,6 +330,53 @@ static int adf_get_fw_capabilities(struct adf_accel_dev *accel_dev, u16 *caps)
 	return 0;
 }
 
+int adf_send_admin_rl_init(struct adf_accel_dev *accel_dev,
+			   struct icp_qat_fw_init_admin_slice_cnt *slices)
+{
+	u32 ae_mask = accel_dev->hw_device->admin_ae_mask;
+	struct icp_qat_fw_init_admin_resp resp = { };
+	struct icp_qat_fw_init_admin_req req = { };
+	int ret;
+
+	req.cmd_id = ICP_QAT_FW_RL_INIT;
+
+	ret = adf_send_admin(accel_dev, &req, &resp, ae_mask);
+	if (ret)
+		return ret;
+
+	memcpy(slices, &resp.slices, sizeof(*slices));
+
+	return 0;
+}
+
+int adf_send_admin_rl_add_update(struct adf_accel_dev *accel_dev,
+				 struct icp_qat_fw_init_admin_req *req)
+{
+	u32 ae_mask = accel_dev->hw_device->admin_ae_mask;
+	struct icp_qat_fw_init_admin_resp resp = { };
+
+	/*
+	 * req struct filled in rl implementation. Used commands
+	 * ICP_QAT_FW_RL_ADD for a new SLA
+	 * ICP_QAT_FW_RL_UPDATE for update SLA
+	 */
+	return adf_send_admin(accel_dev, req, &resp, ae_mask);
+}
+
+int adf_send_admin_rl_delete(struct adf_accel_dev *accel_dev, u16 node_id,
+			     u8 node_type)
+{
+	u32 ae_mask = accel_dev->hw_device->admin_ae_mask;
+	struct icp_qat_fw_init_admin_resp resp = { };
+	struct icp_qat_fw_init_admin_req req = { };
+
+	req.cmd_id = ICP_QAT_FW_RL_REMOVE;
+	req.node_id = node_id;
+	req.node_type = node_type;
+
+	return adf_send_admin(accel_dev, &req, &resp, ae_mask);
+}
+
 /**
  * adf_send_admin_init() - Function sends init message to FW
  * @accel_dev: Pointer to acceleration device.
diff --git a/drivers/crypto/intel/qat/qat_common/adf_admin.h b/drivers/crypto/intel/qat/qat_common/adf_admin.h
index 03507ec3a51d..55cbcbc66c9f 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_admin.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_admin.h
@@ -3,6 +3,8 @@
 #ifndef ADF_ADMIN
 #define ADF_ADMIN
 
+#include "icp_qat_fw_init_admin.h"
+
 struct adf_accel_dev;
 
 int adf_init_admin_comms(struct adf_accel_dev *accel_dev);
@@ -12,6 +14,12 @@ int adf_get_ae_fw_counters(struct adf_accel_dev *accel_dev, u16 ae, u64 *reqs, u
 int adf_init_admin_pm(struct adf_accel_dev *accel_dev, u32 idle_delay);
 int adf_send_admin_tim_sync(struct adf_accel_dev *accel_dev, u32 cnt);
 int adf_send_admin_hb_timer(struct adf_accel_dev *accel_dev, uint32_t ticks);
+int adf_send_admin_rl_init(struct adf_accel_dev *accel_dev,
+			   struct icp_qat_fw_init_admin_slice_cnt *slices);
+int adf_send_admin_rl_add_update(struct adf_accel_dev *accel_dev,
+				 struct icp_qat_fw_init_admin_req *req);
+int adf_send_admin_rl_delete(struct adf_accel_dev *accel_dev, u16 node_id,
+			     u8 node_type);
 int adf_get_fw_timestamp(struct adf_accel_dev *accel_dev, u64 *timestamp);
 int adf_get_pm_info(struct adf_accel_dev *accel_dev, dma_addr_t p_state_addr, size_t buff_size);
 int adf_get_cnv_stats(struct adf_accel_dev *accel_dev, u16 ae, u16 *err_cnt, u16 *latest_err);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
index 02d7a019ebf8..1813fe1d5a06 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
@@ -139,6 +139,13 @@ do { \
 /* Number of heartbeat counter pairs */
 #define ADF_NUM_HB_CNT_PER_AE ADF_NUM_THREADS_PER_AE
 
+/* Rate Limiting */
+#define ADF_GEN4_RL_R2L_OFFSET			0x508000
+#define ADF_GEN4_RL_L2C_OFFSET			0x509000
+#define ADF_GEN4_RL_C2S_OFFSET			0x508818
+#define ADF_GEN4_RL_TOKEN_PCIEIN_BUCKET_OFFSET	0x508800
+#define ADF_GEN4_RL_TOKEN_PCIEOUT_BUCKET_OFFSET	0x508804
+
 void adf_gen4_set_ssm_wdtimer(struct adf_accel_dev *accel_dev);
 void adf_gen4_init_hw_csr_ops(struct adf_hw_csr_ops *csr_ops);
 int adf_gen4_ring_pair_reset(struct adf_accel_dev *accel_dev, u32 bank_number);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_init.c b/drivers/crypto/intel/qat/qat_common/adf_init.c
index b4cf605ccf3e..827c70c4221f 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_init.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_init.c
@@ -9,6 +9,7 @@
 #include "adf_common_drv.h"
 #include "adf_dbgfs.h"
 #include "adf_heartbeat.h"
+#include "adf_rl.h"
 
 static LIST_HEAD(service_table);
 static DEFINE_MUTEX(service_lock);
@@ -133,6 +134,9 @@ static int adf_dev_init(struct adf_accel_dev *accel_dev)
 	}
 
 	adf_heartbeat_init(accel_dev);
+	ret = adf_rl_init(accel_dev);
+	if (ret && ret != -EOPNOTSUPP)
+		return ret;
 
 	/*
 	 * Subservice initialisation is divided into two stages: init and start.
@@ -208,6 +212,9 @@ static int adf_dev_start(struct adf_accel_dev *accel_dev)
 	}
 
 	adf_heartbeat_start(accel_dev);
+	ret = adf_rl_start(accel_dev);
+	if (ret && ret != -EOPNOTSUPP)
+		return ret;
 
 	list_for_each_entry(service, &service_table, list) {
 		if (service->event_hld(accel_dev, ADF_EVENT_START)) {
@@ -267,6 +274,7 @@ static void adf_dev_stop(struct adf_accel_dev *accel_dev)
 	    !test_bit(ADF_STATUS_STARTING, &accel_dev->status))
 		return;
 
+	adf_rl_stop(accel_dev);
 	adf_dbgfs_rm(accel_dev);
 
 	clear_bit(ADF_STATUS_STARTING, &accel_dev->status);
@@ -353,6 +361,7 @@ static void adf_dev_shutdown(struct adf_accel_dev *accel_dev)
 			clear_bit(accel_dev->accel_id, service->init_status);
 	}
 
+	adf_rl_exit(accel_dev);
 	adf_heartbeat_shutdown(accel_dev);
 
 	hw_data->disable_iov(accel_dev);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_rl.c b/drivers/crypto/intel/qat/qat_common/adf_rl.c
new file mode 100644
index 000000000000..dec98a056dce
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_rl.c
@@ -0,0 +1,1176 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation */
+
+#define dev_fmt(fmt) "RateLimiting: " fmt
+
+#include <asm/errno.h>
+#include <asm/div64.h>
+
+#include <linux/dev_printk.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/units.h>
+
+#include "adf_accel_devices.h"
+#include "adf_common_drv.h"
+#include "adf_rl_admin.h"
+#include "adf_rl.h"
+
+#define RL_TOKEN_GRANULARITY_PCIEIN_BUCKET	0U
+#define RL_TOKEN_GRANULARITY_PCIEOUT_BUCKET	0U
+#define RL_TOKEN_PCIE_SIZE			64
+#define RL_TOKEN_ASYM_SIZE			1024
+#define RL_CSR_SIZE				4U
+#define RL_CAPABILITY_MASK			GENMASK(6, 4)
+#define RL_CAPABILITY_VALUE			0x70
+#define RL_VALIDATE_NON_ZERO(input)		((input) == 0)
+#define ROOT_MASK				GENMASK(1, 0)
+#define CLUSTER_MASK				GENMASK(3, 0)
+#define LEAF_MASK				GENMASK(5, 0)
+
+static int validate_user_input(struct adf_accel_dev *accel_dev,
+			       struct adf_rl_sla_input_data *sla_in,
+			       bool is_update)
+{
+	const unsigned long rp_mask = sla_in->rp_mask;
+	size_t rp_mask_size;
+	int i, cnt;
+
+	if (sla_in->sla_id < RL_SLA_EMPTY_ID || sla_in->sla_id >= RL_NODES_CNT_MAX) {
+		dev_notice(&GET_DEV(accel_dev), "Wrong SLA ID\n");
+		goto ret_inval;
+	}
+
+	if (sla_in->pir < sla_in->cir) {
+		dev_notice(&GET_DEV(accel_dev),
+			   "PIR must be >= CIR, setting PIR to CIR\n");
+		sla_in->pir = sla_in->cir;
+	}
+
+	if (!is_update) {
+		cnt = 0;
+		rp_mask_size = sizeof(sla_in->rp_mask) * BITS_PER_BYTE;
+		for_each_set_bit(i, &rp_mask, rp_mask_size) {
+			if (++cnt > RL_RP_CNT_PER_LEAF_MAX) {
+				dev_notice(&GET_DEV(accel_dev),
+					   "Too many ring pairs selected for this SLA\n");
+				goto ret_inval;
+			}
+		}
+
+		if (sla_in->srv >= ADF_SVC_NONE) {
+			dev_notice(&GET_DEV(accel_dev),
+				   "Wrong service type\n");
+			goto ret_inval;
+		}
+
+		if (sla_in->type > RL_LEAF) {
+			dev_notice(&GET_DEV(accel_dev),
+				   "Wrong node type\n");
+			goto ret_inval;
+		}
+
+		if (sla_in->parent_id < RL_PARENT_DEFAULT_ID ||
+		    sla_in->parent_id >= RL_NODES_CNT_MAX) {
+			dev_notice(&GET_DEV(accel_dev),
+				   "Wrong parent ID\n");
+			goto ret_inval;
+		}
+	}
+
+	return 0;
+
+ret_inval:
+	return -EINVAL;
+}
+
+static int validate_sla_id(struct adf_accel_dev *accel_dev, int sla_id)
+{
+	struct rl_sla *sla;
+
+	if (sla_id < 0 || sla_id >= RL_NODES_CNT_MAX)
+		goto ret_not_exists;
+
+	sla = accel_dev->rate_limiting->sla[sla_id];
+
+	if (!sla)
+		goto ret_not_exists;
+
+	if (sla->type != RL_LEAF) {
+		dev_notice(&GET_DEV(accel_dev),
+			   "This ID is reserved for internal use\n");
+		goto ret_inval;
+	}
+
+	return 0;
+
+ret_not_exists:
+	dev_notice(&GET_DEV(accel_dev),
+		   "SLA with provided ID does not exist\n");
+ret_inval:
+	return -EINVAL;
+}
+
+/**
+ * find_parent() - Find the parent for a new SLA
+ * @rl_data: pointer to ratelimiting data
+ * @sla_in: pointer to user input data for a new SLA
+ *
+ * Function returns a pointer to the parent SLA. If the parent ID is provided
+ * as input in the user data, then such ID is validated and the parent SLA
+ * is returned.
+ * Otherwise, it returns the default parent SLA (root or cluster) for
+ * the new object.
+ *
+ * Return:
+ * * Pointer to the parent SLA object
+ * * NULL - when parent cannot be found
+ */
+static struct rl_sla *find_parent(struct adf_rl *rl_data,
+				  struct adf_rl_sla_input_data *sla_in)
+{
+	int input_parent_id = sla_in->parent_id;
+	struct rl_sla *root = NULL;
+	struct rl_sla *parent_sla;
+	int i;
+
+	if (sla_in->type == RL_ROOT)
+		return NULL;
+
+	if (input_parent_id > RL_PARENT_DEFAULT_ID) {
+		parent_sla = rl_data->sla[input_parent_id];
+		/*
+		 * SLA can be a parent if it has the same service as the child
+		 * and its type is higher in the hierarchy,
+		 * for example the parent type of a LEAF must be a CLUSTER.
+		 */
+		if (parent_sla && parent_sla->srv == sla_in->srv &&
+		    parent_sla->type == sla_in->type - 1)
+			return parent_sla;
+
+		return NULL;
+	}
+
+	/* If input_parent_id is not valid, get root for this service type. */
+	for (i = 0; i < RL_ROOT_MAX; i++) {
+		if (rl_data->root[i] && rl_data->root[i]->srv == sla_in->srv) {
+			root = rl_data->root[i];
+			break;
+		}
+	}
+
+	if (!root)
+		return NULL;
+
+	/*
+	 * If the type of this SLA is cluster, then return the root.
+	 * Otherwise, find the default (i.e. first) cluster for this service.
+	 */
+	if (sla_in->type == RL_CLUSTER)
+		return root;
+
+	for (i = 0; i < RL_CLUSTER_MAX; i++) {
+		if (rl_data->cluster[i] && rl_data->cluster[i]->parent == root)
+			return rl_data->cluster[i];
+	}
+
+	return NULL;
+}
+
+static enum adf_cfg_service_type srv_to_cfg_svc_type(enum adf_base_services rl_srv)
+{
+	switch (rl_srv) {
+	case ADF_SVC_ASYM:
+		return ASYM;
+	case ADF_SVC_SYM:
+		return SYM;
+	case ADF_SVC_DC:
+		return COMP;
+	default:
+		return UNUSED;
+	}
+}
+
+/**
+ * get_sla_arr_of_type() - Returns a pointer to SLA type specific array
+ * @rl_data: pointer to ratelimiting data
+ * @type: SLA type
+ * @sla_arr: pointer to variable where requested pointer will be stored
+ *
+ * Return: Max number of elements allowed for the returned array
+ */
+static u32 get_sla_arr_of_type(struct adf_rl *rl_data, enum rl_node_type type,
+			       struct rl_sla ***sla_arr)
+{
+	switch (type) {
+	case RL_LEAF:
+		*sla_arr = rl_data->leaf;
+		return RL_LEAF_MAX;
+	case RL_CLUSTER:
+		*sla_arr = rl_data->cluster;
+		return RL_CLUSTER_MAX;
+	case RL_ROOT:
+		*sla_arr = rl_data->root;
+		return RL_ROOT_MAX;
+	default:
+		*sla_arr = NULL;
+		return 0;
+	}
+}
+
+static bool is_service_enabled(struct adf_accel_dev *accel_dev,
+			       enum adf_base_services rl_srv)
+{
+	enum adf_cfg_service_type arb_srv = srv_to_cfg_svc_type(rl_srv);
+	struct adf_hw_device_data *hw_data = GET_HW_DATA(accel_dev);
+	u8 rps_per_bundle = hw_data->num_banks_per_vf;
+	int i;
+
+	for (i = 0; i < rps_per_bundle; i++) {
+		if (GET_SRV_TYPE(accel_dev, i) == arb_srv)
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ * prepare_rp_ids() - Creates an array of ring pair IDs from bitmask
+ * @accel_dev: pointer to acceleration device structure
+ * @sla: SLA object data where result will be written
+ * @rp_mask: bitmask of ring pair IDs
+ *
+ * Function tries to convert provided bitmap to an array of IDs. It checks if
+ * RPs aren't in use, are assigned to SLA  service or if a number of provided
+ * IDs is not too big. If successful, writes the result into the field
+ * sla->ring_pairs_cnt.
+ *
+ * Return:
+ * * 0		- ok
+ * * -EINVAL	- ring pairs array cannot be created from provided mask
+ */
+static int prepare_rp_ids(struct adf_accel_dev *accel_dev, struct rl_sla *sla,
+			  const unsigned long rp_mask)
+{
+	enum adf_cfg_service_type arb_srv = srv_to_cfg_svc_type(sla->srv);
+	u16 rps_per_bundle = GET_HW_DATA(accel_dev)->num_banks_per_vf;
+	bool *rp_in_use = accel_dev->rate_limiting->rp_in_use;
+	size_t rp_cnt_max = ARRAY_SIZE(sla->ring_pairs_ids);
+	u16 rp_id_max = GET_HW_DATA(accel_dev)->num_banks;
+	u16 cnt = 0;
+	u16 rp_id;
+
+	for_each_set_bit(rp_id, &rp_mask, rp_id_max) {
+		if (cnt >= rp_cnt_max) {
+			dev_notice(&GET_DEV(accel_dev),
+				   "Assigned more ring pairs than supported");
+			return -EINVAL;
+		}
+
+		if (rp_in_use[rp_id]) {
+			dev_notice(&GET_DEV(accel_dev),
+				   "RP %u already assigned to other SLA", rp_id);
+			return -EINVAL;
+		}
+
+		if (GET_SRV_TYPE(accel_dev, rp_id % rps_per_bundle) != arb_srv) {
+			dev_notice(&GET_DEV(accel_dev),
+				   "RP %u does not support SLA service", rp_id);
+			return -EINVAL;
+		}
+
+		sla->ring_pairs_ids[cnt++] = rp_id;
+	}
+
+	sla->ring_pairs_cnt = cnt;
+
+	return 0;
+}
+
+static void mark_rps_usage(struct rl_sla *sla, bool *rp_in_use, bool used)
+{
+	u16 rp_id;
+	int i;
+
+	for (i = 0; i < sla->ring_pairs_cnt; i++) {
+		rp_id = sla->ring_pairs_ids[i];
+		rp_in_use[rp_id] = used;
+	}
+}
+
+static void assign_rps_to_leaf(struct adf_accel_dev *accel_dev,
+			       struct rl_sla *sla, bool clear)
+{
+	struct adf_hw_device_data *hw_data = GET_HW_DATA(accel_dev);
+	void __iomem *pmisc_addr = adf_get_pmisc_base(accel_dev);
+	u32 base_offset = hw_data->rl_data.r2l_offset;
+	u32 node_id = clear ? 0U : (sla->node_id & LEAF_MASK);
+	u32 offset;
+	int i;
+
+	for (i = 0; i < sla->ring_pairs_cnt; i++) {
+		offset = base_offset + (RL_CSR_SIZE * sla->ring_pairs_ids[i]);
+		ADF_CSR_WR(pmisc_addr, offset, node_id);
+	}
+}
+
+static void assign_leaf_to_cluster(struct adf_accel_dev *accel_dev,
+				   struct rl_sla *sla, bool clear)
+{
+	struct adf_hw_device_data *hw_data = GET_HW_DATA(accel_dev);
+	void __iomem *pmisc_addr = adf_get_pmisc_base(accel_dev);
+	u32 base_offset = hw_data->rl_data.l2c_offset;
+	u32 node_id = sla->node_id & LEAF_MASK;
+	u32 parent_id = clear ? 0U : (sla->parent->node_id & CLUSTER_MASK);
+	u32 offset;
+
+	offset = base_offset + (RL_CSR_SIZE * node_id);
+	ADF_CSR_WR(pmisc_addr, offset, parent_id);
+}
+
+static void assign_cluster_to_root(struct adf_accel_dev *accel_dev,
+				   struct rl_sla *sla, bool clear)
+{
+	struct adf_hw_device_data *hw_data = GET_HW_DATA(accel_dev);
+	void __iomem *pmisc_addr = adf_get_pmisc_base(accel_dev);
+	u32 base_offset = hw_data->rl_data.c2s_offset;
+	u32 node_id = sla->node_id & CLUSTER_MASK;
+	u32 parent_id = clear ? 0U : (sla->parent->node_id & ROOT_MASK);
+	u32 offset;
+
+	offset = base_offset + (RL_CSR_SIZE * node_id);
+	ADF_CSR_WR(pmisc_addr, offset, parent_id);
+}
+
+static void assign_node_to_parent(struct adf_accel_dev *accel_dev,
+				  struct rl_sla *sla, bool clear_assignment)
+{
+	switch (sla->type) {
+	case RL_LEAF:
+		assign_rps_to_leaf(accel_dev, sla, clear_assignment);
+		assign_leaf_to_cluster(accel_dev, sla, clear_assignment);
+		break;
+	case RL_CLUSTER:
+		assign_cluster_to_root(accel_dev, sla, clear_assignment);
+		break;
+	default:
+		break;
+	}
+}
+
+/**
+ * can_parent_afford_sla() - Verifies if parent allows to create an SLA
+ * @sla_in: pointer to user input data for a new SLA
+ * @sla_parent: pointer to parent SLA object
+ * @sla_cir: current child CIR value (only for update)
+ * @is_update: request is a update
+ *
+ * Algorithm verifies if parent has enough remaining budget to take assignment
+ * of a child with provided parameters. In update case current CIR value must be
+ * returned to budget first.
+ * PIR value cannot exceed the PIR assigned to parent.
+ *
+ * Return:
+ * * true	- SLA can be created
+ * * false	- SLA cannot be created
+ */
+static bool can_parent_afford_sla(struct adf_rl_sla_input_data *sla_in,
+				  struct rl_sla *sla_parent, u32 sla_cir,
+				  bool is_update)
+{
+	u32 rem_cir = sla_parent->rem_cir;
+
+	if (is_update)
+		rem_cir += sla_cir;
+
+	if (sla_in->cir > rem_cir || sla_in->pir > sla_parent->pir)
+		return false;
+
+	return true;
+}
+
+/**
+ * can_node_afford_update() - Verifies if SLA can be updated with input data
+ * @sla_in: pointer to user input data for a new SLA
+ * @sla: pointer to SLA object selected for update
+ *
+ * Algorithm verifies if a new CIR value is big enough to satisfy currently
+ * assigned child SLAs and if PIR can be updated
+ *
+ * Return:
+ * * true	- SLA can be updated
+ * * false	- SLA cannot be updated
+ */
+static bool can_node_afford_update(struct adf_rl_sla_input_data *sla_in,
+				   struct rl_sla *sla)
+{
+	u32 cir_in_use = sla->cir - sla->rem_cir;
+
+	/* new CIR cannot be smaller then currently consumed value */
+	if (cir_in_use > sla_in->cir)
+		return false;
+
+	/* PIR of root/cluster cannot be reduced in node with assigned children */
+	if (sla_in->pir < sla->pir && sla->type != RL_LEAF && cir_in_use > 0)
+		return false;
+
+	return true;
+}
+
+static bool is_enough_budget(struct adf_rl *rl_data, struct rl_sla *sla,
+			     struct adf_rl_sla_input_data *sla_in,
+			     bool is_update)
+{
+	u32 max_val = rl_data->device_data->scale_ref;
+	struct rl_sla *parent = sla->parent;
+	bool ret = true;
+
+	if (sla_in->cir > max_val || sla_in->pir > max_val)
+		ret = false;
+
+	switch (sla->type) {
+	case RL_LEAF:
+		ret &= can_parent_afford_sla(sla_in, parent, sla->cir,
+						  is_update);
+		break;
+	case RL_CLUSTER:
+		ret &= can_parent_afford_sla(sla_in, parent, sla->cir,
+						  is_update);
+
+		if (is_update)
+			ret &= can_node_afford_update(sla_in, sla);
+
+		break;
+	case RL_ROOT:
+		if (is_update)
+			ret &= can_node_afford_update(sla_in, sla);
+
+		break;
+	default:
+		ret = false;
+		break;
+	}
+
+	return ret;
+}
+
+static void update_budget(struct rl_sla *sla, u32 old_cir, bool is_update)
+{
+	u32 new_rem;
+
+	switch (sla->type) {
+	case RL_LEAF:
+		if (is_update)
+			sla->parent->rem_cir += old_cir;
+
+		sla->parent->rem_cir -= sla->cir;
+		sla->rem_cir = 0;
+		break;
+	case RL_CLUSTER:
+		if (is_update) {
+			sla->parent->rem_cir += old_cir;
+			new_rem = sla->cir - (old_cir - sla->rem_cir);
+			sla->rem_cir = new_rem;
+		} else {
+			sla->rem_cir = sla->cir;
+		}
+
+		sla->parent->rem_cir -= sla->cir;
+		break;
+	case RL_ROOT:
+		if (is_update) {
+			new_rem = sla->cir - (old_cir - sla->rem_cir);
+			sla->rem_cir = new_rem;
+		} else {
+			sla->rem_cir = sla->cir;
+		}
+		break;
+	default:
+		break;
+	}
+}
+
+/**
+ * get_next_free_sla_id() - finds next free ID in the SLA array
+ * @rl_data: Pointer to ratelimiting data structure
+ *
+ * Return:
+ * * 0 : RL_NODES_CNT_MAX	- correct ID
+ * * -ENOSPC			- all SLA slots are in use
+ */
+static int get_next_free_sla_id(struct adf_rl *rl_data)
+{
+	int i = 0;
+
+	while (i < RL_NODES_CNT_MAX && rl_data->sla[i++])
+		;
+
+	if (i == RL_NODES_CNT_MAX)
+		return -ENOSPC;
+
+	return i - 1;
+}
+
+/**
+ * get_next_free_node_id() - finds next free ID in the array of that node type
+ * @rl_data: Pointer to ratelimiting data structure
+ * @sla: Pointer to SLA object for which the ID is searched
+ *
+ * Return:
+ * * 0 : RL_[NODE_TYPE]_MAX	- correct ID
+ * * -ENOSPC			- all slots of that type are in use
+ */
+static int get_next_free_node_id(struct adf_rl *rl_data, struct rl_sla *sla)
+{
+	struct adf_hw_device_data *hw_device = GET_HW_DATA(rl_data->accel_dev);
+	int max_id, i, step, rp_per_leaf;
+	struct rl_sla **sla_list;
+
+	rp_per_leaf = hw_device->num_banks / hw_device->num_banks_per_vf;
+
+	/*
+	 * Static nodes mapping:
+	 * root0 - cluster[0,4,8,12] - leaf[0-15]
+	 * root1 - cluster[1,5,9,13] - leaf[16-31]
+	 * root2 - cluster[2,6,10,14] - leaf[32-47]
+	 */
+	switch (sla->type) {
+	case RL_LEAF:
+		i = sla->srv * rp_per_leaf;
+		step = 1;
+		max_id = i + rp_per_leaf;
+		sla_list = rl_data->leaf;
+		break;
+	case RL_CLUSTER:
+		i = sla->srv;
+		step = 4;
+		max_id = RL_CLUSTER_MAX;
+		sla_list = rl_data->cluster;
+		break;
+	case RL_ROOT:
+		return sla->srv;
+	default:
+		return -EINVAL;
+	}
+
+	while (i < max_id && sla_list[i])
+		i += step;
+
+	if (i >= max_id)
+		return -ENOSPC;
+
+	return i;
+}
+
+u32 adf_rl_calculate_slice_tokens(struct adf_accel_dev *accel_dev, u32 sla_val,
+				  enum adf_base_services svc_type)
+{
+	struct adf_rl_hw_data *device_data = &accel_dev->hw_device->rl_data;
+	struct adf_hw_device_data *hw_data = GET_HW_DATA(accel_dev);
+	u64 avail_slice_cycles, allocated_tokens;
+
+	if (!sla_val)
+		return 0;
+
+	avail_slice_cycles = hw_data->clock_frequency;
+
+	switch (svc_type) {
+	case ADF_SVC_ASYM:
+		avail_slice_cycles *= device_data->slices.pke_cnt;
+		break;
+	case ADF_SVC_SYM:
+		avail_slice_cycles *= device_data->slices.cph_cnt;
+		break;
+	case ADF_SVC_DC:
+		avail_slice_cycles *= device_data->slices.dcpr_cnt;
+		break;
+	default:
+		break;
+	}
+
+	do_div(avail_slice_cycles, device_data->scan_interval);
+	allocated_tokens = avail_slice_cycles * sla_val;
+	do_div(allocated_tokens, device_data->scale_ref);
+
+	return allocated_tokens;
+}
+
+u32 adf_rl_calculate_ae_cycles(struct adf_accel_dev *accel_dev, u32 sla_val,
+			       enum adf_base_services svc_type)
+{
+	struct adf_rl_hw_data *device_data = &accel_dev->hw_device->rl_data;
+	struct adf_hw_device_data *hw_data = GET_HW_DATA(accel_dev);
+	u64 allocated_ae_cycles, avail_ae_cycles;
+
+	if (!sla_val)
+		return 0;
+
+	avail_ae_cycles = hw_data->clock_frequency;
+	avail_ae_cycles *= hw_data->get_num_aes(hw_data) - 1;
+	do_div(avail_ae_cycles, device_data->scan_interval);
+
+	sla_val *= device_data->max_tp[svc_type];
+	sla_val /= device_data->scale_ref;
+
+	allocated_ae_cycles = (sla_val * avail_ae_cycles);
+	do_div(allocated_ae_cycles, device_data->max_tp[svc_type]);
+
+	return allocated_ae_cycles;
+}
+
+u32 adf_rl_calculate_pci_bw(struct adf_accel_dev *accel_dev, u32 sla_val,
+			    enum adf_base_services svc_type, bool is_bw_out)
+{
+	struct adf_rl_hw_data *device_data = &accel_dev->hw_device->rl_data;
+	u64 sla_to_bytes, allocated_bw, sla_scaled;
+
+	if (!sla_val)
+		return 0;
+
+	sla_to_bytes = sla_val;
+	sla_to_bytes *= device_data->max_tp[svc_type];
+	do_div(sla_to_bytes, device_data->scale_ref);
+
+	sla_to_bytes *= (svc_type == ADF_SVC_ASYM) ? RL_TOKEN_ASYM_SIZE :
+						     BYTES_PER_MBIT;
+	if (svc_type == ADF_SVC_DC && is_bw_out)
+		sla_to_bytes *= device_data->slices.dcpr_cnt -
+				device_data->dcpr_correction;
+
+	sla_scaled = sla_to_bytes * device_data->pcie_scale_mul;
+	do_div(sla_scaled, device_data->pcie_scale_div);
+	allocated_bw = sla_scaled;
+	do_div(allocated_bw, RL_TOKEN_PCIE_SIZE);
+	do_div(allocated_bw, device_data->scan_interval);
+
+	return allocated_bw;
+}
+
+/**
+ * add_new_sla_entry() - creates a new SLA object and fills it with user data
+ * @accel_dev: pointer to acceleration device structure
+ * @sla_in: pointer to user input data for a new SLA
+ * @sla_out: Pointer to variable that will contain the address of a new
+ *	     SLA object if the operation succeeds
+ *
+ * Return:
+ * * 0		- ok
+ * * -ENOMEM	- memory allocation failed
+ * * -EINVAL	- invalid user input
+ * * -ENOSPC	- all available SLAs are in use
+ */
+static int add_new_sla_entry(struct adf_accel_dev *accel_dev,
+			     struct adf_rl_sla_input_data *sla_in,
+			     struct rl_sla **sla_out)
+{
+	struct adf_rl *rl_data = accel_dev->rate_limiting;
+	struct rl_sla *sla;
+	int ret = 0;
+
+	sla = kzalloc(sizeof(*sla), GFP_KERNEL);
+	if (!sla) {
+		ret = -ENOMEM;
+		goto ret_err;
+	}
+	*sla_out = sla;
+
+	if (!is_service_enabled(accel_dev, sla_in->srv)) {
+		dev_notice(&GET_DEV(accel_dev),
+			   "Provided service is not enabled\n");
+		ret = -EINVAL;
+		goto ret_err;
+	}
+
+	sla->srv = sla_in->srv;
+	sla->type = sla_in->type;
+	ret = get_next_free_node_id(rl_data, sla);
+	if (ret < 0) {
+		dev_notice(&GET_DEV(accel_dev),
+			   "Exceeded number of available nodes for that service\n");
+		goto ret_err;
+	}
+	sla->node_id = ret;
+
+	ret = get_next_free_sla_id(rl_data);
+	if (ret < 0) {
+		dev_notice(&GET_DEV(accel_dev),
+			   "Allocated maximum SLAs number\n");
+		goto ret_err;
+	}
+	sla->sla_id = ret;
+
+	sla->parent = find_parent(rl_data, sla_in);
+	if (!sla->parent && sla->type != RL_ROOT) {
+		if (sla_in->parent_id != RL_PARENT_DEFAULT_ID)
+			dev_notice(&GET_DEV(accel_dev),
+				   "Provided parent ID does not exist or cannot be parent for this SLA.");
+		else
+			dev_notice(&GET_DEV(accel_dev),
+				   "Unable to find parent node for this service. Is service enabled?");
+		ret = -EINVAL;
+		goto ret_err;
+	}
+
+	if (sla->type == RL_LEAF) {
+		ret = prepare_rp_ids(accel_dev, sla, sla_in->rp_mask);
+		if (!sla->ring_pairs_cnt || ret) {
+			dev_notice(&GET_DEV(accel_dev),
+				   "Unable to find ring pairs to assign to the leaf");
+			if (!ret)
+				ret = -EINVAL;
+
+			goto ret_err;
+		}
+	}
+
+	ret = 0;
+
+ret_err:
+	/* Allocated sla will be freed at the bottom of calling function */
+	return ret;
+}
+
+static int initialize_default_nodes(struct adf_accel_dev *accel_dev)
+{
+	struct adf_rl *rl_data = accel_dev->rate_limiting;
+	struct adf_rl_hw_data *device_data = rl_data->device_data;
+	struct adf_rl_sla_input_data sla_in = { };
+	int ret = 0;
+	int i;
+
+	/* Init root for each enabled service */
+	sla_in.type = RL_ROOT;
+	sla_in.parent_id = RL_PARENT_DEFAULT_ID;
+
+	for (i = 0; i < ADF_SVC_NONE; i++) {
+		if (!is_service_enabled(accel_dev, i))
+			continue;
+
+		sla_in.cir = device_data->scale_ref;
+		sla_in.pir = sla_in.cir;
+		sla_in.srv = i;
+
+		ret = adf_rl_add_sla(accel_dev, &sla_in);
+		if (ret)
+			goto err_ret;
+	}
+
+	/* Init default cluster for each root */
+	sla_in.type = RL_CLUSTER;
+	for (i = 0; i < ADF_SVC_NONE; i++) {
+		if (!rl_data->root[i])
+			continue;
+
+		sla_in.cir = rl_data->root[i]->cir;
+		sla_in.pir = sla_in.cir;
+		sla_in.srv = rl_data->root[i]->srv;
+
+		ret = adf_rl_add_sla(accel_dev, &sla_in);
+		if (ret)
+			goto err_ret;
+	}
+
+	return 0;
+
+err_ret:
+	dev_notice(&GET_DEV(accel_dev),
+		   "Initialization of default nodes failed\n");
+	return ret;
+}
+
+static void clear_sla(struct adf_rl *rl_data, struct rl_sla *sla)
+{
+	bool *rp_in_use = rl_data->rp_in_use;
+	struct rl_sla **sla_type_arr = NULL;
+	int i, sla_id, node_id;
+	u32 old_cir;
+
+	sla_id = sla->sla_id;
+	node_id = sla->node_id;
+	old_cir = sla->cir;
+	sla->cir = 0;
+	sla->pir = 0;
+
+	for (i = 0; i < sla->ring_pairs_cnt; i++)
+		rp_in_use[sla->ring_pairs_ids[i]] = false;
+
+	update_budget(sla, old_cir, true);
+	get_sla_arr_of_type(rl_data, sla->type, &sla_type_arr);
+	assign_node_to_parent(rl_data->accel_dev, sla, true);
+	adf_rl_send_admin_delete_msg(rl_data->accel_dev, node_id, sla->type);
+	mark_rps_usage(sla, rl_data->rp_in_use, false);
+
+	kfree(sla);
+	rl_data->sla[sla_id] = NULL;
+	sla_type_arr[node_id] = NULL;
+}
+
+/**
+ * add_update_sla() - handles the creation and the update of an SLA
+ * @accel_dev: pointer to acceleration device structure
+ * @sla_in: pointer to user input data for a new/updated SLA
+ * @is_update: flag to indicate if this is an update or an add operation
+ *
+ * Return:
+ * * 0		- ok
+ * * -ENOMEM	- memory allocation failed
+ * * -EINVAL	- user input data cannot be used to create SLA
+ * * -ENOSPC	- all available SLAs are in use
+ */
+static int add_update_sla(struct adf_accel_dev *accel_dev,
+			  struct adf_rl_sla_input_data *sla_in, bool is_update)
+{
+	struct adf_rl *rl_data = accel_dev->rate_limiting;
+	struct rl_sla **sla_type_arr = NULL;
+	struct rl_sla *sla = NULL;
+	u32 old_cir = 0;
+	int ret;
+
+	if (!sla_in) {
+		dev_warn(&GET_DEV(accel_dev),
+			 "SLA input data pointer is missing\n");
+		ret = -EFAULT;
+		goto ret_err;
+	}
+
+	/* Input validation */
+	ret = validate_user_input(accel_dev, sla_in, is_update);
+	if (ret)
+		goto ret_err;
+
+	mutex_lock(&rl_data->rl_lock);
+
+	if (is_update) {
+		ret = validate_sla_id(accel_dev, sla_in->sla_id);
+		if (ret)
+			goto ret_err;
+
+		sla = rl_data->sla[sla_in->sla_id];
+		old_cir = sla->cir;
+	} else {
+		ret = add_new_sla_entry(accel_dev, sla_in, &sla);
+		if (ret)
+			goto ret_err;
+	}
+
+	if (!is_enough_budget(rl_data, sla, sla_in, is_update)) {
+		dev_notice(&GET_DEV(accel_dev),
+			   "Input value exceeds the remaining budget%s\n",
+			   is_update ? " or more budget is already in use" : "");
+		ret = -EINVAL;
+		goto ret_err;
+	}
+	sla->cir = sla_in->cir;
+	sla->pir = sla_in->pir;
+
+	/* Apply SLA */
+	assign_node_to_parent(accel_dev, sla, false);
+	ret = adf_rl_send_admin_add_update_msg(accel_dev, sla, is_update);
+	if (ret) {
+		dev_notice(&GET_DEV(accel_dev),
+			   "Failed to apply an SLA\n");
+		goto ret_err;
+	}
+	update_budget(sla, old_cir, is_update);
+
+	if (!is_update) {
+		mark_rps_usage(sla, rl_data->rp_in_use, true);
+		get_sla_arr_of_type(rl_data, sla->type, &sla_type_arr);
+		sla_type_arr[sla->node_id] = sla;
+		rl_data->sla[sla->sla_id] = sla;
+	}
+
+	sla_in->sla_id = sla->sla_id;
+	goto ret_ok;
+
+ret_err:
+	if (!is_update && sla) {
+		sla_in->sla_id = -1;
+		kfree(sla);
+	}
+ret_ok:
+	mutex_unlock(&rl_data->rl_lock);
+	return ret;
+}
+
+/**
+ * adf_rl_add_sla() - handles the creation of an SLA
+ * @accel_dev: pointer to acceleration device structure
+ * @sla_in: pointer to user input data required to add an SLA
+ *
+ * Return:
+ * * 0		- ok
+ * * -ENOMEM	- memory allocation failed
+ * * -EINVAL	- invalid user input
+ * * -ENOSPC	- all available SLAs are in use
+ */
+int adf_rl_add_sla(struct adf_accel_dev *accel_dev,
+		   struct adf_rl_sla_input_data *sla_in)
+{
+	return add_update_sla(accel_dev, sla_in, false);
+}
+
+/**
+ * adf_rl_update_sla() - handles the update of an SLA
+ * @accel_dev: pointer to acceleration device structure
+ * @sla_in: pointer to user input data required to update an SLA
+ *
+ * Return:
+ * * 0		- ok
+ * * -EINVAL	- user input data cannot be used to update SLA
+ */
+int adf_rl_update_sla(struct adf_accel_dev *accel_dev,
+		      struct adf_rl_sla_input_data *sla_in)
+{
+	return add_update_sla(accel_dev, sla_in, true);
+}
+
+/**
+ * adf_rl_get_sla() - returns an existing SLA data
+ * @accel_dev: pointer to acceleration device structure
+ * @sla_in: pointer to user data where SLA info will be stored
+ *
+ * The sla_id for which data are requested should be set in sla_id structure
+ *
+ * Return:
+ * * 0		- ok
+ * * -EINVAL	- provided sla_id does not exist
+ */
+int adf_rl_get_sla(struct adf_accel_dev *accel_dev,
+		   struct adf_rl_sla_input_data *sla_in)
+{
+	struct rl_sla *sla;
+	int ret, i;
+
+	ret = validate_sla_id(accel_dev, sla_in->sla_id);
+	if (ret)
+		return ret;
+
+	sla = accel_dev->rate_limiting->sla[sla_in->sla_id];
+	sla_in->type = sla->type;
+	sla_in->srv = sla->srv;
+	sla_in->cir = sla->cir;
+	sla_in->pir = sla->pir;
+	sla_in->rp_mask = 0U;
+	if (sla->parent)
+		sla_in->parent_id = sla->parent->sla_id;
+	else
+		sla_in->parent_id = RL_PARENT_DEFAULT_ID;
+
+	for (i = 0; i < sla->ring_pairs_cnt; i++)
+		sla_in->rp_mask |= BIT(sla->ring_pairs_ids[i]);
+
+	return 0;
+}
+
+/**
+ * adf_rl_get_capability_remaining() - returns the remaining SLA value (CIR) for
+ *				       selected service or provided sla_id
+ * @accel_dev: pointer to acceleration device structure
+ * @srv: service ID for which capability is requested
+ * @sla_id: ID of the cluster or root to which we want assign a new SLA
+ *
+ * Check if the provided SLA id is valid. If it is and the service matches
+ * the requested service and the type is cluster or root, return the remaining
+ * capability.
+ * If the provided ID does not match the service or type, return the remaining
+ * capacity of the default cluster for that service.
+ *
+ * Return:
+ * * Positive value	- correct remaining value
+ * * -EINVAL		- algorithm cannot find a remaining value for provided data
+ */
+int adf_rl_get_capability_remaining(struct adf_accel_dev *accel_dev,
+				    enum adf_base_services srv, int sla_id)
+{
+	struct adf_rl *rl_data = accel_dev->rate_limiting;
+	struct rl_sla *sla = NULL;
+	int i;
+
+	if (srv >= ADF_SVC_NONE)
+		return -EINVAL;
+
+	if (sla_id > RL_SLA_EMPTY_ID && !validate_sla_id(accel_dev, sla_id)) {
+		sla = rl_data->sla[sla_id];
+
+		if (sla->srv == srv && sla->type <= RL_CLUSTER)
+			goto ret_ok;
+	}
+
+	for (i = 0; i < RL_CLUSTER_MAX; i++) {
+		if (!rl_data->cluster[i])
+			continue;
+
+		if (rl_data->cluster[i]->srv == srv) {
+			sla = rl_data->cluster[i];
+			goto ret_ok;
+		}
+	}
+
+	return -EINVAL;
+ret_ok:
+	return sla->rem_cir;
+}
+
+/**
+ * adf_rl_remove_sla() - removes provided sla_id
+ * @accel_dev: pointer to acceleration device structure
+ * @sla_id: ID of the cluster or root to which we want assign an new SLA
+ *
+ * Return:
+ * * 0		- ok
+ * * -EINVAL	- wrong sla_id or it still have assigned children
+ */
+int adf_rl_remove_sla(struct adf_accel_dev *accel_dev, u32 sla_id)
+{
+	struct adf_rl *rl_data = accel_dev->rate_limiting;
+	struct rl_sla *sla;
+	int ret;
+
+	ret = validate_sla_id(accel_dev, sla_id);
+	if (ret)
+		return ret;
+
+	sla = rl_data->sla[sla_id];
+
+	if (sla->type < RL_LEAF && sla->rem_cir != sla->cir) {
+		dev_notice(&GET_DEV(accel_dev),
+			   "To remove parent SLA all its children must be removed first");
+		return -EINVAL;
+	}
+
+	mutex_lock(&rl_data->rl_lock);
+	clear_sla(rl_data, sla);
+	mutex_unlock(&rl_data->rl_lock);
+
+	return 0;
+}
+
+/**
+ * adf_rl_remove_sla_all() - removes all SLAs from device
+ * @accel_dev: pointer to acceleration device structure
+ * @incl_default: set to true if default SLAs also should be removed
+ */
+void adf_rl_remove_sla_all(struct adf_accel_dev *accel_dev, bool incl_default)
+{
+	struct adf_rl *rl_data = accel_dev->rate_limiting;
+	int end_type = incl_default ? RL_ROOT : RL_LEAF;
+	struct rl_sla **sla_type_arr = NULL;
+	u32 max_id;
+	int i, j;
+
+	mutex_lock(&rl_data->rl_lock);
+
+	/* Unregister and remove all SLAs */
+	for (j = RL_LEAF; j >= end_type; j--) {
+		max_id = get_sla_arr_of_type(rl_data, j, &sla_type_arr);
+
+		for (i = 0; i < max_id; i++) {
+			if (!sla_type_arr[i])
+				continue;
+
+			clear_sla(rl_data, sla_type_arr[i]);
+		}
+	}
+
+	mutex_unlock(&rl_data->rl_lock);
+}
+
+int adf_rl_init(struct adf_accel_dev *accel_dev)
+{
+	struct adf_hw_device_data *hw_data = GET_HW_DATA(accel_dev);
+	struct adf_rl_hw_data *rl_hw_data = &hw_data->rl_data;
+	struct adf_rl *rl;
+	int ret = 0;
+
+	/* Validate device parameters */
+	if (RL_VALIDATE_NON_ZERO(rl_hw_data->max_tp[ADF_SVC_ASYM]) ||
+	    RL_VALIDATE_NON_ZERO(rl_hw_data->max_tp[ADF_SVC_SYM]) ||
+	    RL_VALIDATE_NON_ZERO(rl_hw_data->max_tp[ADF_SVC_DC]) ||
+	    RL_VALIDATE_NON_ZERO(rl_hw_data->scan_interval) ||
+	    RL_VALIDATE_NON_ZERO(rl_hw_data->pcie_scale_div) ||
+	    RL_VALIDATE_NON_ZERO(rl_hw_data->pcie_scale_mul) ||
+	    RL_VALIDATE_NON_ZERO(rl_hw_data->scale_ref)) {
+		ret = -EOPNOTSUPP;
+		goto err_ret;
+	}
+
+	rl = kzalloc(sizeof(*rl), GFP_KERNEL);
+	if (!rl) {
+		ret = -ENOMEM;
+		goto err_ret;
+	}
+
+	mutex_init(&rl->rl_lock);
+	rl->device_data = &accel_dev->hw_device->rl_data;
+	rl->accel_dev = accel_dev;
+	accel_dev->rate_limiting = rl;
+
+err_ret:
+	return ret;
+}
+
+int adf_rl_start(struct adf_accel_dev *accel_dev)
+{
+	struct adf_rl_hw_data *rl_hw_data = &GET_HW_DATA(accel_dev)->rl_data;
+	void __iomem *pmisc_addr = adf_get_pmisc_base(accel_dev);
+	u16 fw_caps =  GET_HW_DATA(accel_dev)->fw_capabilities;
+	int ret;
+
+	if (!accel_dev->rate_limiting) {
+		ret = -EOPNOTSUPP;
+		goto ret_err;
+	}
+
+	if ((fw_caps & RL_CAPABILITY_MASK) != RL_CAPABILITY_VALUE) {
+		dev_info(&GET_DEV(accel_dev), "not supported\n");
+		ret = -EOPNOTSUPP;
+		goto ret_free;
+	}
+
+	ADF_CSR_WR(pmisc_addr, rl_hw_data->pciin_tb_offset,
+		   RL_TOKEN_GRANULARITY_PCIEIN_BUCKET);
+	ADF_CSR_WR(pmisc_addr, rl_hw_data->pciout_tb_offset,
+		   RL_TOKEN_GRANULARITY_PCIEOUT_BUCKET);
+
+	ret = adf_rl_send_admin_init_msg(accel_dev, &rl_hw_data->slices);
+	if (ret) {
+		dev_err(&GET_DEV(accel_dev), "initialization failed\n");
+		goto ret_free;
+	}
+
+	ret = initialize_default_nodes(accel_dev);
+	if (ret) {
+		dev_err(&GET_DEV(accel_dev),
+			"failed to initialize default SLAs\n");
+		goto ret_sla_rm;
+	}
+
+	return 0;
+
+ret_sla_rm:
+	adf_rl_remove_sla_all(accel_dev, true);
+ret_free:
+	kfree(accel_dev->rate_limiting);
+	accel_dev->rate_limiting = NULL;
+ret_err:
+	return ret;
+}
+
+void adf_rl_stop(struct adf_accel_dev *accel_dev)
+{
+	if (!accel_dev->rate_limiting)
+		return;
+
+	adf_rl_remove_sla_all(accel_dev, true);
+}
+
+void adf_rl_exit(struct adf_accel_dev *accel_dev)
+{
+	if (!accel_dev->rate_limiting)
+		return;
+
+	kfree(accel_dev->rate_limiting);
+	accel_dev->rate_limiting = NULL;
+}
diff --git a/drivers/crypto/intel/qat/qat_common/adf_rl.h b/drivers/crypto/intel/qat/qat_common/adf_rl.h
new file mode 100644
index 000000000000..1ccb6613c92e
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_rl.h
@@ -0,0 +1,169 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2023 Intel Corporation */
+
+#ifndef ADF_RL_H_
+#define ADF_RL_H_
+
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+struct adf_accel_dev;
+
+#define RL_ROOT_MAX		4
+#define RL_CLUSTER_MAX		16
+#define RL_LEAF_MAX		64
+#define RL_NODES_CNT_MAX	(RL_ROOT_MAX + RL_CLUSTER_MAX + RL_LEAF_MAX)
+#define RL_RP_CNT_PER_LEAF_MAX	4U
+#define RL_RP_CNT_MAX		64
+#define RL_SLA_EMPTY_ID		-1
+#define RL_PARENT_DEFAULT_ID	-1
+
+enum rl_node_type {
+	RL_ROOT,
+	RL_CLUSTER,
+	RL_LEAF,
+};
+
+enum adf_base_services {
+	ADF_SVC_ASYM = 0,
+	ADF_SVC_SYM,
+	ADF_SVC_DC,
+	ADF_SVC_NONE,
+};
+
+/**
+ * struct adf_rl_sla_input_data - ratelimiting user input data structure
+ * @rp_mask: 64 bit bitmask of ring pair IDs which will be assigned to SLA.
+ *	     Eg. 0x5 -> RP0 and RP2 assigned; 0xA005 -> RP0,2,13,15 assigned.
+ * @sla_id: ID of current SLA for operations update, rm, get. For the add
+ *	    operation, this field will be updated with the ID of the newly
+ *	    added SLA
+ * @parent_id: ID of the SLA to which the current one should be assigned.
+ *	       Set to -1 to refer to the default parent.
+ * @cir: Committed information rate. Rate guaranteed to be achieved. Input value
+ *	 is expressed in permille scale, i.e. 1000 refers to the maximum
+ *	 device throughput for a selected service.
+ * @pir: Peak information rate. Maximum rate available that the SLA can achieve.
+ *	 Input value is expressed in permille scale, i.e. 1000 refers to
+ *	 the maximum device throughput for a selected service.
+ * @type: SLA type: root, cluster, node
+ * @srv: Service associated to the SLA: asym, sym dc.
+ *
+ * This structure is used to perform operations on an SLA.
+ * Depending on the operation, some of the parameters are ignored.
+ * The following list reports which parameters should be set for each operation.
+ *	- add: all except sla_id
+ *	- update: cir, pir, sla_id
+ *	- rm: sla_id
+ *	- rm_all: -
+ *	- get: sla_id
+ *	- get_capability_rem: srv, sla_id
+ */
+struct adf_rl_sla_input_data {
+	u64 rp_mask;
+	int sla_id;
+	int parent_id;
+	unsigned int cir;
+	unsigned int pir;
+	enum rl_node_type type;
+	enum adf_base_services srv;
+};
+
+struct rl_slice_cnt {
+	u8 dcpr_cnt;
+	u8 pke_cnt;
+	u8 cph_cnt;
+};
+
+struct adf_rl_hw_data {
+	u32 scale_ref;
+	u32 scan_interval;
+	u32 r2l_offset;
+	u32 l2c_offset;
+	u32 c2s_offset;
+	u32 pciin_tb_offset;
+	u32 pciout_tb_offset;
+	u32 pcie_scale_mul;
+	u32 pcie_scale_div;
+	u32 dcpr_correction;
+	u32 max_tp[RL_ROOT_MAX];
+	struct rl_slice_cnt slices;
+};
+
+/**
+ * struct adf_rl - ratelimiting data structure
+ * @accel_dev: pointer to acceleration device data
+ * @device_data: pointer to rate limiting data specific to a device type (or revision)
+ * @sla: array of pointers to SLA objects
+ * @root: array of pointers to root type SLAs, element number reflects node_id
+ * @cluster: array of pointers to cluster type SLAs, element number reflects node_id
+ * @leaf: array of pointers to leaf type SLAs, element number reflects node_id
+ * @rp_in_use: array of ring pair IDs already used in one of SLAs
+ * @rl_lock: mutex object which is protecting data in this structure
+ * @input: structure which is used for holding the data received from user
+ */
+struct adf_rl {
+	struct adf_accel_dev *accel_dev;
+	struct adf_rl_hw_data *device_data;
+	/* mapping sla_id to SLA objects */
+	struct rl_sla *sla[RL_NODES_CNT_MAX];
+	struct rl_sla *root[RL_ROOT_MAX];
+	struct rl_sla *cluster[RL_CLUSTER_MAX];
+	struct rl_sla *leaf[RL_LEAF_MAX];
+	bool rp_in_use[RL_RP_CNT_MAX];
+	/* Mutex protecting writing to SLAs lists */
+	struct mutex rl_lock;
+};
+
+/**
+ * struct rl_sla - SLA object data structure
+ * @parent: pointer to the parent SLA (root/cluster)
+ * @type: SLA type
+ * @srv: service associated with this SLA
+ * @sla_id: ID of the SLA, used as element number in SLA array and as identifier
+ *	    shared with the user
+ * @node_id: ID of node, each of SLA type have a separate ID list
+ * @cir: committed information rate
+ * @pir: peak information rate (PIR >= CIR)
+ * @rem_cir: if this SLA is a parent then this field represents a remaining
+ *	     value to be used by child SLAs.
+ * @ring_pairs_ids: array with numeric ring pairs IDs assigned to this SLA
+ * @ring_pairs_cnt: number of assigned ring pairs listed in the array above
+ */
+struct rl_sla {
+	struct rl_sla *parent;
+	enum rl_node_type type;
+	enum adf_base_services srv;
+	u32 sla_id;
+	u32 node_id;
+	u32 cir;
+	u32 pir;
+	u32 rem_cir;
+	u16 ring_pairs_ids[RL_RP_CNT_PER_LEAF_MAX];
+	u16 ring_pairs_cnt;
+};
+
+int adf_rl_add_sla(struct adf_accel_dev *accel_dev,
+		   struct adf_rl_sla_input_data *sla_in);
+int adf_rl_update_sla(struct adf_accel_dev *accel_dev,
+		      struct adf_rl_sla_input_data *sla_in);
+int adf_rl_get_sla(struct adf_accel_dev *accel_dev,
+		   struct adf_rl_sla_input_data *sla_in);
+int adf_rl_get_capability_remaining(struct adf_accel_dev *accel_dev,
+				    enum adf_base_services srv, int sla_id);
+int adf_rl_remove_sla(struct adf_accel_dev *accel_dev, u32 sla_id);
+void adf_rl_remove_sla_all(struct adf_accel_dev *accel_dev, bool incl_default);
+
+int adf_rl_init(struct adf_accel_dev *accel_dev);
+int adf_rl_start(struct adf_accel_dev *accel_dev);
+void adf_rl_stop(struct adf_accel_dev *accel_dev);
+void adf_rl_exit(struct adf_accel_dev *accel_dev);
+
+u32 adf_rl_calculate_pci_bw(struct adf_accel_dev *accel_dev, u32 sla_val,
+			    enum adf_base_services svc_type, bool is_bw_out);
+u32 adf_rl_calculate_ae_cycles(struct adf_accel_dev *accel_dev, u32 sla_val,
+			       enum adf_base_services svc_type);
+u32 adf_rl_calculate_slice_tokens(struct adf_accel_dev *accel_dev, u32 sla_val,
+				  enum adf_base_services svc_type);
+
+#endif /* ADF_RL_H_ */
diff --git a/drivers/crypto/intel/qat/qat_common/adf_rl_admin.c b/drivers/crypto/intel/qat/qat_common/adf_rl_admin.c
new file mode 100644
index 000000000000..820fcb2d42bf
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_rl_admin.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation */
+
+#include <linux/dma-mapping.h>
+#include <linux/pci.h>
+
+#include "adf_admin.h"
+#include "adf_accel_devices.h"
+#include "adf_rl_admin.h"
+
+static void
+prep_admin_req_msg(struct rl_sla *sla, dma_addr_t dma_addr,
+		   struct icp_qat_fw_init_admin_sla_config_params *fw_params,
+		   struct icp_qat_fw_init_admin_req *req, bool is_update)
+{
+	req->cmd_id = is_update ? ICP_QAT_FW_RL_UPDATE : ICP_QAT_FW_RL_ADD;
+	req->init_cfg_ptr = dma_addr;
+	req->init_cfg_sz = sizeof(*fw_params);
+	req->node_id = sla->node_id;
+	req->node_type = sla->type;
+	req->rp_count = sla->ring_pairs_cnt;
+	req->svc_type = sla->srv;
+}
+
+static void
+prep_admin_req_params(struct adf_accel_dev *accel_dev, struct rl_sla *sla,
+		      struct icp_qat_fw_init_admin_sla_config_params *fw_params)
+{
+	fw_params->pcie_in_cir =
+		adf_rl_calculate_pci_bw(accel_dev, sla->cir, sla->srv, false);
+	fw_params->pcie_in_pir =
+		adf_rl_calculate_pci_bw(accel_dev, sla->pir, sla->srv, false);
+	fw_params->pcie_out_cir =
+		adf_rl_calculate_pci_bw(accel_dev, sla->cir, sla->srv, true);
+	fw_params->pcie_out_pir =
+		adf_rl_calculate_pci_bw(accel_dev, sla->pir, sla->srv, true);
+
+	fw_params->slice_util_cir =
+		adf_rl_calculate_slice_tokens(accel_dev, sla->cir, sla->srv);
+	fw_params->slice_util_pir =
+		adf_rl_calculate_slice_tokens(accel_dev, sla->pir, sla->srv);
+
+	fw_params->ae_util_cir =
+		adf_rl_calculate_ae_cycles(accel_dev, sla->cir, sla->srv);
+	fw_params->ae_util_pir =
+		adf_rl_calculate_ae_cycles(accel_dev, sla->pir, sla->srv);
+
+	memcpy(fw_params->rp_ids, sla->ring_pairs_ids,
+	       sizeof(sla->ring_pairs_ids));
+}
+
+int adf_rl_send_admin_init_msg(struct adf_accel_dev *accel_dev,
+			       struct rl_slice_cnt *slices_int)
+{
+	struct icp_qat_fw_init_admin_slice_cnt slices_resp = { };
+	int ret;
+
+	ret = adf_send_admin_rl_init(accel_dev, &slices_resp);
+	if (ret)
+		goto err_ret;
+
+	slices_int->dcpr_cnt = slices_resp.dcpr_cnt;
+	slices_int->pke_cnt = slices_resp.pke_cnt;
+	/* For symmetric crypto, slice tokens are relative to the UCS slice */
+	slices_int->cph_cnt = slices_resp.ucs_cnt;
+
+err_ret:
+	return ret;
+}
+
+int adf_rl_send_admin_add_update_msg(struct adf_accel_dev *accel_dev,
+				     struct rl_sla *sla, bool is_update)
+{
+	struct icp_qat_fw_init_admin_sla_config_params *fw_params;
+	struct icp_qat_fw_init_admin_req req = { };
+	dma_addr_t dma_addr;
+	int ret;
+
+	fw_params = dma_alloc_coherent(&GET_DEV(accel_dev), sizeof(*fw_params),
+				       &dma_addr, GFP_KERNEL);
+	if (!fw_params)
+		return -ENOMEM;
+
+	prep_admin_req_params(accel_dev, sla, fw_params);
+	prep_admin_req_msg(sla, dma_addr, fw_params, &req, is_update);
+	ret = adf_send_admin_rl_add_update(accel_dev, &req);
+
+	dma_free_coherent(&GET_DEV(accel_dev), sizeof(*fw_params), fw_params,
+			  dma_addr);
+
+	return ret;
+}
+
+int adf_rl_send_admin_delete_msg(struct adf_accel_dev *accel_dev, u16 node_id,
+				 u8 node_type)
+{
+	return adf_send_admin_rl_delete(accel_dev, node_id, node_type);
+}
diff --git a/drivers/crypto/intel/qat/qat_common/adf_rl_admin.h b/drivers/crypto/intel/qat/qat_common/adf_rl_admin.h
new file mode 100644
index 000000000000..dd5419b7e896
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_rl_admin.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2023 Intel Corporation */
+
+#ifndef ADF_RL_ADMIN_H_
+#define ADF_RL_ADMIN_H_
+
+#include <linux/types.h>
+
+#include "adf_rl.h"
+
+int adf_rl_send_admin_init_msg(struct adf_accel_dev *accel_dev,
+			       struct rl_slice_cnt *slices_int);
+int adf_rl_send_admin_add_update_msg(struct adf_accel_dev *accel_dev,
+				     struct rl_sla *sla, bool is_update);
+int adf_rl_send_admin_delete_msg(struct adf_accel_dev *accel_dev, u16 node_id,
+				 u8 node_type);
+
+#endif /* ADF_RL_ADMIN_H_ */
diff --git a/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h b/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h
index e4de9a30e0bd..cd418b51d9f3 100644
--- a/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h
+++ b/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h
@@ -5,6 +5,8 @@
 
 #include "icp_qat_fw.h"
 
+#define RL_MAX_RP_IDS 16
+
 enum icp_qat_fw_init_admin_cmd_id {
 	ICP_QAT_FW_INIT_AE = 0,
 	ICP_QAT_FW_TRNG_ENABLE = 1,
@@ -19,10 +21,14 @@ enum icp_qat_fw_init_admin_cmd_id {
 	ICP_QAT_FW_CRYPTO_CAPABILITY_GET = 10,
 	ICP_QAT_FW_DC_CHAIN_INIT = 11,
 	ICP_QAT_FW_HEARTBEAT_TIMER_SET = 13,
+	ICP_QAT_FW_RL_INIT = 15,
 	ICP_QAT_FW_TIMER_GET = 19,
 	ICP_QAT_FW_CNV_STATS_GET = 20,
 	ICP_QAT_FW_PM_STATE_CONFIG = 128,
 	ICP_QAT_FW_PM_INFO = 129,
+	ICP_QAT_FW_RL_ADD = 134,
+	ICP_QAT_FW_RL_UPDATE = 135,
+	ICP_QAT_FW_RL_REMOVE = 136,
 };
 
 enum icp_qat_fw_init_admin_resp_status {
@@ -30,6 +36,30 @@ enum icp_qat_fw_init_admin_resp_status {
 	ICP_QAT_FW_INIT_RESP_STATUS_FAIL
 };
 
+struct icp_qat_fw_init_admin_slice_cnt {
+	__u8 cpr_cnt;
+	__u8 xlt_cnt;
+	__u8 dcpr_cnt;
+	__u8 pke_cnt;
+	__u8 wat_cnt;
+	__u8 wcp_cnt;
+	__u8 ucs_cnt;
+	__u8 cph_cnt;
+	__u8 ath_cnt;
+};
+
+struct icp_qat_fw_init_admin_sla_config_params {
+	__u32 pcie_in_cir;
+	__u32 pcie_in_pir;
+	__u32 pcie_out_cir;
+	__u32 pcie_out_pir;
+	__u32 slice_util_cir;
+	__u32 slice_util_pir;
+	__u32 ae_util_cir;
+	__u32 ae_util_pir;
+	__u16 rp_ids[RL_MAX_RP_IDS];
+};
+
 struct icp_qat_fw_init_admin_req {
 	__u16 init_cfg_sz;
 	__u8 resrvd1;
@@ -49,6 +79,13 @@ struct icp_qat_fw_init_admin_req {
 		struct {
 			__u32 heartbeat_ticks;
 		};
+		struct {
+			__u16 node_id;
+			__u8 node_type;
+			__u8 svc_type;
+			__u8 resrvd5[3];
+			__u8 rp_count;
+		};
 		__u32 idle_filter;
 	};
 
@@ -110,6 +147,7 @@ struct icp_qat_fw_init_admin_resp {
 			__u32 unsuccessful_count;
 			__u64 resrvd8;
 		};
+		struct icp_qat_fw_init_admin_slice_cnt slices;
 		__u16 fw_capabilities;
 	};
 } __packed;
-- 
2.41.0


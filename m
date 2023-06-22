Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A70D73A80E
	for <lists+linux-crypto@lfdr.de>; Thu, 22 Jun 2023 20:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjFVSSy (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 22 Jun 2023 14:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjFVSSw (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 22 Jun 2023 14:18:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671FB2116
        for <linux-crypto@vger.kernel.org>; Thu, 22 Jun 2023 11:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687457928; x=1718993928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sRlyPN8Jpo0hmGXW8oPcEMltQdrkUhFDXEW2bOQqdrc=;
  b=CSWbo3J0q68ODSELvP1GL033PAFWeH5SnokEtqxR9Va0zYycypBsU5wU
   mXTkX3gGOvBmhiWnt2pTE8U1QMM/Pyb0lDCtn4IJHhnM0duwGced21rrm
   cFIiEVrDX2SHfcRiBDCwPK5XaRi8GQIesAkDJaKESMK1BCRjDaX7r6vPZ
   EDGd8CC5HDkiOsvSBUkENbWl3HqBibFPHiovHcrXe7BM45S6DzFpWnELX
   7ySnkrbj/lY3z3/Ve2dQgBTOmF14DV6BvY/OIPqn7QMiTdsSDqPWRO0Io
   UPnNi2Q0mtzssmQJMj9hlbXZ7pDOKdBNLTBTDoySAp0iLnINk7Jqxfnzy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="340175960"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="340175960"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 11:18:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="665163041"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="665163041"
Received: from r031s002_zp31l10c01.gv.intel.com (HELO localhost.localdomain) ([10.219.171.29])
  by orsmga003.jf.intel.com with ESMTP; 22 Jun 2023 11:18:33 -0700
From:   Damian Muszynski <damian.muszynski@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Damian Muszynski <damian.muszynski@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 4/5] crypto: qat - add heartbeat feature
Date:   Thu, 22 Jun 2023 20:04:05 +0200
Message-Id: <20230622180405.133298-5-damian.muszynski@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622180405.133298-1-damian.muszynski@intel.com>
References: <20230622180405.133298-1-damian.muszynski@intel.com>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Under some circumstances, firmware in the QAT devices could become
unresponsive. The Heartbeat feature provides a mechanism to detect
unresponsive devices.

The QAT FW periodically writes to memory a set of counters that allow
to detect the liveness of a device. This patch adds logic to enable
the reporting of those counters, analyze them and report if a device
is alive or not.

In particular this adds
  (1) heartbeat enabling, reading and detection logic
  (2) reporting of heartbeat status and configuration via debugfs
  (3) documentation for the newly created sysfs entries
  (4) configuration of FW settings related to heartbeat, e.g. tick period
  (5) logic to convert time in ms (provided by the user) to clock ticks

This patch introduces a new folder in debugfs called heartbeat with the
following attributes:
 - status
 - queries_sent
 - queries_failed
 - config

All attributes except config are reading only. In particular:
 - `status` file returns 0 when device is operational and -1 otherwise.
 - `queries_sent` returns the total number of heartbeat queries sent.
 - `queries_failed` returns the total number of heartbeat queries failed.
 - `config` allows to adjust the frequency at which the firmware writes
   counters to memory. This period is given in milliseconds and it is
   fixed for GEN4 devices.

Signed-off-by: Damian Muszynski <damian.muszynski@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/ABI/testing/debugfs-driver-qat  |  51 ++++
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     |   1 +
 drivers/crypto/intel/qat/qat_4xxx/adf_drv.c   |   3 +
 .../intel/qat/qat_c3xxx/adf_c3xxx_hw_data.c   |   1 +
 .../intel/qat/qat_c62x/adf_c62x_hw_data.c     |   1 +
 drivers/crypto/intel/qat/qat_common/Makefile  |   2 +
 .../intel/qat/qat_common/adf_accel_devices.h  |   7 +
 .../crypto/intel/qat/qat_common/adf_admin.c   |  14 +
 .../intel/qat/qat_common/adf_cfg_strings.h    |   2 +
 .../intel/qat/qat_common/adf_common_drv.h     |   1 +
 .../crypto/intel/qat/qat_common/adf_dbgfs.c   |   9 +-
 .../intel/qat/qat_common/adf_gen2_config.c    |   7 +
 .../intel/qat/qat_common/adf_gen2_hw_data.h   |   3 +
 .../intel/qat/qat_common/adf_gen4_hw_data.h   |   3 +
 .../intel/qat/qat_common/adf_heartbeat.c      | 268 ++++++++++++++++++
 .../intel/qat/qat_common/adf_heartbeat.h      |  73 +++++
 .../qat/qat_common/adf_heartbeat_dbgfs.c      | 194 +++++++++++++
 .../qat/qat_common/adf_heartbeat_dbgfs.h      |  12 +
 .../crypto/intel/qat/qat_common/adf_init.c    |   7 +
 .../qat/qat_common/icp_qat_fw_init_admin.h    |   4 +
 .../qat/qat_dh895xcc/adf_dh895xcc_hw_data.c   |   1 +
 21 files changed, 662 insertions(+), 2 deletions(-)
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_heartbeat.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_heartbeat.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.h

diff --git a/Documentation/ABI/testing/debugfs-driver-qat b/Documentation/ABI/testing/debugfs-driver-qat
index f75eeff4bc7a..1c2ebb82fa41 100644
--- a/Documentation/ABI/testing/debugfs-driver-qat
+++ b/Documentation/ABI/testing/debugfs-driver-qat
@@ -8,3 +8,54 @@ Description:	(RO) Read returns the number of requests sent to the FW and the num
 
 			<N>: Number of requests sent from Acceleration Engine N to FW and responses
 			     Acceleration Engine N received from FW
+
+What:		/sys/kernel/debug/qat_<device>_<BDF>/heartbeat/config
+Date:		June 2023
+KernelVersion:	6.5
+Contact:	qat-linux@intel.com
+Description:	(RW) Read returns value of the Heartbeat update period.
+		Write to the file changes this period value.
+
+		This period should reflect planned polling interval of device
+		health status. High frequency Heartbeat monitoring wastes CPU cycles
+		but minimizes the customer’s system downtime. Also, if there are
+		large service requests that take some time to complete, high frequency
+		Heartbeat monitoring could result in false reports of unresponsiveness
+		and in those cases, period needs to be increased.
+
+		This parameter is effective only for c3xxx, c62x, dh895xcc devices.
+		4xxx has this value internally fixed to 200ms.
+
+		Default value is set to 500. Minimal allowed value is 200.
+		All values are expressed in milliseconds.
+
+What:		/sys/kernel/debug/qat_<device>_<BDF>/heartbeat/queries_failed
+Date:		June 2023
+KernelVersion:	6.5
+Contact:	qat-linux@intel.com
+Description:	(RO) Read returns the number of times the device became unresponsive.
+
+		Attribute returns value of the counter which is incremented when
+		status query results negative.
+
+What:		/sys/kernel/debug/qat_<device>_<BDF>/heartbeat/queries_sent
+Date:		June 2023
+KernelVersion:	6.5
+Contact:	qat-linux@intel.com
+Description:	(RO) Read returns the number of times the control process checked
+		if the device is responsive.
+
+		Attribute returns value of the counter which is incremented on
+		every status query.
+
+What:		/sys/kernel/debug/qat_<device>_<BDF>/heartbeat/status
+Date:		June 2023
+KernelVersion:	6.5
+Contact:	qat-linux@intel.com
+Description:	(RO) Read returns the device health status.
+
+		Returns 0 when device is healthy or -1 when is unresponsive
+		or the query failed to send.
+
+		The driver does not monitor for Heartbeat. It is left for a user
+		to poll the status periodically.
diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
index 9cda0c17992a..268a1f7694fc 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -521,6 +521,7 @@ void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data, u32 dev_id)
 	hw_data->start_timer = adf_gen4_timer_start;
 	hw_data->stop_timer = adf_gen4_timer_stop;
 	hw_data->get_hb_clock = get_heartbeat_clock;
+	hw_data->num_hb_ctrs = ADF_NUM_HB_CNT_PER_AE;
 
 	adf_gen4_init_hw_csr_ops(&hw_data->csr_ops);
 	adf_gen4_init_pf_pfvf_ops(&hw_data->pfvf_ops);
diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c b/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
index 1a15600361d0..6d4e2e139ffa 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
@@ -8,6 +8,7 @@
 #include <adf_cfg.h>
 #include <adf_common_drv.h>
 #include <adf_dbgfs.h>
+#include <adf_heartbeat.h>
 
 #include "adf_4xxx_hw_data.h"
 #include "qat_compression.h"
@@ -77,6 +78,8 @@ static int adf_cfg_dev_init(struct adf_accel_dev *accel_dev)
 	if (ret)
 		return ret;
 
+	adf_heartbeat_save_cfg_param(accel_dev, ADF_CFG_HB_TIMER_MIN_MS);
+
 	return 0;
 }
 
diff --git a/drivers/crypto/intel/qat/qat_c3xxx/adf_c3xxx_hw_data.c b/drivers/crypto/intel/qat/qat_c3xxx/adf_c3xxx_hw_data.c
index 2c6a1dd9780c..e81d11409426 100644
--- a/drivers/crypto/intel/qat/qat_c3xxx/adf_c3xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_c3xxx/adf_c3xxx_hw_data.c
@@ -152,6 +152,7 @@ void adf_init_hw_data_c3xxx(struct adf_hw_device_data *hw_data)
 	hw_data->dev_config = adf_gen2_dev_config;
 	hw_data->measure_clock = measure_clock;
 	hw_data->get_hb_clock = get_ts_clock;
+	hw_data->num_hb_ctrs = ADF_NUM_HB_CNT_PER_AE;
 
 	adf_gen2_init_pf_pfvf_ops(&hw_data->pfvf_ops);
 	adf_gen2_init_hw_csr_ops(&hw_data->csr_ops);
diff --git a/drivers/crypto/intel/qat/qat_c62x/adf_c62x_hw_data.c b/drivers/crypto/intel/qat/qat_c62x/adf_c62x_hw_data.c
index 081702be839e..1a8c8e3a48e9 100644
--- a/drivers/crypto/intel/qat/qat_c62x/adf_c62x_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_c62x/adf_c62x_hw_data.c
@@ -154,6 +154,7 @@ void adf_init_hw_data_c62x(struct adf_hw_device_data *hw_data)
 	hw_data->dev_config = adf_gen2_dev_config;
 	hw_data->measure_clock = measure_clock;
 	hw_data->get_hb_clock = get_ts_clock;
+	hw_data->num_hb_ctrs = ADF_NUM_HB_CNT_PER_AE;
 
 	adf_gen2_init_pf_pfvf_ops(&hw_data->pfvf_ops);
 	adf_gen2_init_hw_csr_ops(&hw_data->csr_ops);
diff --git a/drivers/crypto/intel/qat/qat_common/Makefile b/drivers/crypto/intel/qat/qat_common/Makefile
index b3e32d2abf45..43622c7fca71 100644
--- a/drivers/crypto/intel/qat/qat_common/Makefile
+++ b/drivers/crypto/intel/qat/qat_common/Makefile
@@ -31,6 +31,8 @@ intel_qat-objs := adf_cfg.o \
 
 intel_qat-$(CONFIG_DEBUG_FS) += adf_transport_debug.o \
 				adf_fw_counters.o \
+				adf_heartbeat.o \
+				adf_heartbeat_dbgfs.o \
 				adf_dbgfs.o
 
 intel_qat-$(CONFIG_PCI_IOV) += adf_sriov.o adf_vf_isr.o adf_pfvf_utils.o \
diff --git a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
index c96f59cb7de9..ab897e1717e0 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
@@ -233,6 +233,7 @@ struct adf_hw_device_data {
 	u8 num_accel;
 	u8 num_logical_accel;
 	u8 num_engines;
+	u32 num_hb_ctrs;
 };
 
 /* CSR write macro */
@@ -245,6 +246,11 @@ struct adf_hw_device_data {
 #define ADF_CFG_NUM_SERVICES	4
 #define ADF_SRV_TYPE_BIT_LEN	3
 #define ADF_SRV_TYPE_MASK	0x7
+#define ADF_AE_ADMIN_THREAD	7
+#define ADF_NUM_THREADS_PER_AE	8
+#define ADF_NUM_PKE_STRAND	2
+#define ADF_AE_STRAND0_THREAD	8
+#define ADF_AE_STRAND1_THREAD	9
 
 #define GET_DEV(accel_dev) ((accel_dev)->accel_pci_dev.pci_dev->dev)
 #define GET_BARS(accel_dev) ((accel_dev)->accel_pci_dev.pci_bars)
@@ -301,6 +307,7 @@ struct adf_accel_dev {
 	struct module *owner;
 	struct adf_accel_pci accel_pci_dev;
 	struct adf_timer *timer;
+	struct adf_heartbeat *heartbeat;
 	union {
 		struct {
 			/* protects VF2PF interrupts access */
diff --git a/drivers/crypto/intel/qat/qat_common/adf_admin.c b/drivers/crypto/intel/qat/qat_common/adf_admin.c
index 966e7ea271a2..ff790823b868 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_admin.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_admin.c
@@ -8,6 +8,7 @@
 #include <linux/dma-mapping.h>
 #include "adf_accel_devices.h"
 #include "adf_common_drv.h"
+#include "adf_heartbeat.h"
 #include "icp_qat_fw_init_admin.h"
 
 #define ADF_ADMIN_MAILBOX_STRIDE 0x1000
@@ -270,6 +271,19 @@ int adf_send_admin_tim_sync(struct adf_accel_dev *accel_dev, u32 cnt)
 	return adf_send_admin(accel_dev, &req, &resp, ae_mask);
 }
 
+int adf_send_admin_hb_timer(struct adf_accel_dev *accel_dev, uint32_t ticks)
+{
+	u32 ae_mask = accel_dev->hw_device->ae_mask;
+	struct icp_qat_fw_init_admin_req req = { };
+	struct icp_qat_fw_init_admin_resp resp;
+
+	req.cmd_id = ICP_QAT_FW_HEARTBEAT_TIMER_SET;
+	req.init_cfg_ptr = accel_dev->heartbeat->dma.phy_addr;
+	req.heartbeat_ticks = ticks;
+
+	return adf_send_admin(accel_dev, &req, &resp, ae_mask);
+}
+
 /**
  * adf_send_admin_init() - Function sends init message to FW
  * @accel_dev: Pointer to acceleration device.
diff --git a/drivers/crypto/intel/qat/qat_common/adf_cfg_strings.h b/drivers/crypto/intel/qat/qat_common/adf_cfg_strings.h
index 3ae1e5caee0e..6066dc637352 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_cfg_strings.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_cfg_strings.h
@@ -47,4 +47,6 @@
 #define ADF_ETRMGR_CORE_AFFINITY_FORMAT \
 	ADF_ETRMGR_BANK "%d" ADF_ETRMGR_CORE_AFFINITY
 #define ADF_ACCEL_STR "Accelerator%d"
+#define ADF_HEARTBEAT_TIMER  "HeartbeatTimer"
+
 #endif
diff --git a/drivers/crypto/intel/qat/qat_common/adf_common_drv.h b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
index a9552832858f..799a2193d3e5 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
@@ -97,6 +97,7 @@ int adf_send_admin_init(struct adf_accel_dev *accel_dev);
 int adf_get_ae_fw_counters(struct adf_accel_dev *accel_dev, u16 ae, u64 *reqs, u64 *resps);
 int adf_init_admin_pm(struct adf_accel_dev *accel_dev, u32 idle_delay);
 int adf_send_admin_tim_sync(struct adf_accel_dev *accel_dev, u32 cnt);
+int adf_send_admin_hb_timer(struct adf_accel_dev *accel_dev, uint32_t ticks);
 int adf_get_fw_timestamp(struct adf_accel_dev *accel_dev, u64 *timestamp);
 int adf_init_arb(struct adf_accel_dev *accel_dev);
 void adf_exit_arb(struct adf_accel_dev *accel_dev);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_dbgfs.c b/drivers/crypto/intel/qat/qat_common/adf_dbgfs.c
index 5080ecffab03..04845f8d72be 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_dbgfs.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_dbgfs.c
@@ -7,6 +7,7 @@
 #include "adf_common_drv.h"
 #include "adf_dbgfs.h"
 #include "adf_fw_counters.h"
+#include "adf_heartbeat_dbgfs.h"
 
 /**
  * adf_dbgfs_init() - add persistent debugfs entries
@@ -58,8 +59,10 @@ void adf_dbgfs_add(struct adf_accel_dev *accel_dev)
 	if (!accel_dev->debugfs_dir)
 		return;
 
-	if (!accel_dev->is_vf)
+	if (!accel_dev->is_vf) {
 		adf_fw_counters_dbgfs_add(accel_dev);
+		adf_heartbeat_dbgfs_add(accel_dev);
+	}
 }
 
 /**
@@ -71,6 +74,8 @@ void adf_dbgfs_rm(struct adf_accel_dev *accel_dev)
 	if (!accel_dev->debugfs_dir)
 		return;
 
-	if (!accel_dev->is_vf)
+	if (!accel_dev->is_vf) {
+		adf_heartbeat_dbgfs_rm(accel_dev);
 		adf_fw_counters_dbgfs_rm(accel_dev);
+	}
 }
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen2_config.c b/drivers/crypto/intel/qat/qat_common/adf_gen2_config.c
index eeb30da7587a..c27ff6d18e11 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen2_config.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen2_config.c
@@ -7,6 +7,7 @@
 #include "adf_common_drv.h"
 #include "qat_crypto.h"
 #include "qat_compression.h"
+#include "adf_heartbeat.h"
 #include "adf_transport_access_macros.h"
 
 static int adf_gen2_crypto_dev_config(struct adf_accel_dev *accel_dev)
@@ -195,6 +196,12 @@ int adf_gen2_dev_config(struct adf_accel_dev *accel_dev)
 	if (ret)
 		goto err;
 
+	ret = adf_cfg_section_add(accel_dev, ADF_GENERAL_SEC);
+	if (ret)
+		goto err;
+
+	adf_heartbeat_save_cfg_param(accel_dev, ADF_CFG_HB_TIMER_DEFAULT_MS);
+
 	set_bit(ADF_STATUS_CONFIGURED, &accel_dev->status);
 
 	return ret;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen2_hw_data.h b/drivers/crypto/intel/qat/qat_common/adf_gen2_hw_data.h
index e4bc07529be4..6bd341061de4 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen2_hw_data.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen2_hw_data.h
@@ -145,6 +145,9 @@ do { \
 #define ADF_GEN2_CERRSSMSH(i)		((i) * 0x4000 + 0x10)
 #define ADF_GEN2_ERRSSMSH_EN		BIT(3)
 
+/* Number of heartbeat counter pairs */
+#define ADF_NUM_HB_CNT_PER_AE ADF_NUM_THREADS_PER_AE
+
 /* Interrupts */
 #define ADF_GEN2_SMIAPF0_MASK_OFFSET    (0x3A000 + 0x28)
 #define ADF_GEN2_SMIAPF1_MASK_OFFSET    (0x3A000 + 0x30)
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
index 4fb4b3df5a18..02d7a019ebf8 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
@@ -136,6 +136,9 @@ do { \
 
 #define ADF_GEN4_VFLNOTIFY	BIT(7)
 
+/* Number of heartbeat counter pairs */
+#define ADF_NUM_HB_CNT_PER_AE ADF_NUM_THREADS_PER_AE
+
 void adf_gen4_set_ssm_wdtimer(struct adf_accel_dev *accel_dev);
 void adf_gen4_init_hw_csr_ops(struct adf_hw_csr_ops *csr_ops);
 int adf_gen4_ring_pair_reset(struct adf_accel_dev *accel_dev, u32 bank_number);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_heartbeat.c b/drivers/crypto/intel/qat/qat_common/adf_heartbeat.c
new file mode 100644
index 000000000000..7358aac8e56d
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_heartbeat.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation */
+
+#include <linux/dev_printk.h>
+#include <linux/dma-mapping.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/kstrtox.h>
+#include <linux/overflow.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <asm/errno.h>
+#include "adf_accel_devices.h"
+#include "adf_cfg.h"
+#include "adf_cfg_strings.h"
+#include "adf_clock.h"
+#include "adf_common_drv.h"
+#include "adf_heartbeat.h"
+#include "adf_transport_internal.h"
+#include "icp_qat_fw_init_admin.h"
+
+/* Heartbeat counter pair */
+struct hb_cnt_pair {
+	__u16 resp_heartbeat_cnt;
+	__u16 req_heartbeat_cnt;
+};
+
+static int adf_hb_check_polling_freq(struct adf_accel_dev *accel_dev)
+{
+	u64 curr_time = adf_clock_get_current_time();
+	u64 polling_time = curr_time - accel_dev->heartbeat->last_hb_check_time;
+
+	if (polling_time < accel_dev->heartbeat->hb_timer) {
+		dev_warn(&GET_DEV(accel_dev),
+			 "HB polling too frequent. Configured HB timer %d ms\n",
+			 accel_dev->heartbeat->hb_timer);
+		return -EINVAL;
+	}
+
+	accel_dev->heartbeat->last_hb_check_time = curr_time;
+	return 0;
+}
+
+static int get_timer_ticks(struct adf_accel_dev *accel_dev, unsigned int *value)
+{
+	char timer_str[ADF_CFG_MAX_VAL_LEN_IN_BYTES] = { };
+	u32 timer_ms = ADF_CFG_HB_TIMER_DEFAULT_MS;
+	int cfg_read_status;
+	u32 ticks;
+	int ret;
+
+	cfg_read_status = adf_cfg_get_param_value(accel_dev, ADF_GENERAL_SEC,
+						  ADF_HEARTBEAT_TIMER, timer_str);
+	if (cfg_read_status == 0) {
+		if (kstrtouint(timer_str, 10, &timer_ms))
+			dev_dbg(&GET_DEV(accel_dev),
+				"kstrtouint failed to parse the %s, param value",
+				ADF_HEARTBEAT_TIMER);
+	}
+
+	if (timer_ms < ADF_CFG_HB_TIMER_MIN_MS) {
+		dev_err(&GET_DEV(accel_dev), "Timer cannot be less than %u\n",
+			ADF_CFG_HB_TIMER_MIN_MS);
+		return -EINVAL;
+	}
+
+	/*
+	 * On 4xxx devices adf_timer is responsible for HB updates and
+	 * its period is fixed to 200ms
+	 */
+	if (accel_dev->timer)
+		timer_ms = ADF_CFG_HB_TIMER_MIN_MS;
+
+	ret = adf_heartbeat_ms_to_ticks(accel_dev, timer_ms, &ticks);
+	if (ret)
+		return ret;
+
+	adf_heartbeat_save_cfg_param(accel_dev, timer_ms);
+
+	accel_dev->heartbeat->hb_timer = timer_ms;
+	*value = ticks;
+
+	return 0;
+}
+
+static int check_ae(struct hb_cnt_pair *curr, struct hb_cnt_pair *prev,
+		    u16 *count, const size_t hb_ctrs)
+{
+	size_t thr;
+
+	/* loop through all threads in AE */
+	for (thr = 0; thr < hb_ctrs; thr++) {
+		u16 req = curr[thr].req_heartbeat_cnt;
+		u16 resp = curr[thr].resp_heartbeat_cnt;
+		u16 last = prev[thr].resp_heartbeat_cnt;
+
+		if ((thr == ADF_AE_ADMIN_THREAD || req != resp) && resp == last) {
+			u16 retry = ++count[thr];
+
+			if (retry >= ADF_CFG_HB_COUNT_THRESHOLD)
+				return -EIO;
+
+		} else {
+			count[thr] = 0;
+		}
+	}
+	return 0;
+}
+
+static int adf_hb_get_status(struct adf_accel_dev *accel_dev)
+{
+	struct adf_hw_device_data *hw_device = accel_dev->hw_device;
+	struct hb_cnt_pair *live_stats, *last_stats, *curr_stats;
+	const size_t hb_ctrs = hw_device->num_hb_ctrs;
+	const unsigned long ae_mask = hw_device->ae_mask;
+	const size_t max_aes = hw_device->num_engines;
+	const size_t dev_ctrs = size_mul(max_aes, hb_ctrs);
+	const size_t stats_size = size_mul(dev_ctrs, sizeof(*curr_stats));
+	struct hb_cnt_pair *ae_curr_p, *ae_prev_p;
+	u16 *count_fails, *ae_count_p;
+	size_t ae_offset;
+	size_t ae = 0;
+	int ret = 0;
+
+	live_stats = accel_dev->heartbeat->dma.virt_addr;
+	last_stats = live_stats + dev_ctrs;
+	count_fails = (u16 *)(last_stats + dev_ctrs);
+
+	curr_stats = kmemdup(live_stats, stats_size, GFP_KERNEL);
+	if (!curr_stats)
+		return -ENOMEM;
+
+	/* loop through active AEs */
+	for_each_set_bit(ae, &ae_mask, max_aes) {
+		ae_offset = size_mul(ae, hb_ctrs);
+		ae_curr_p = curr_stats + ae_offset;
+		ae_prev_p = last_stats + ae_offset;
+		ae_count_p = count_fails + ae_offset;
+
+		ret = check_ae(ae_curr_p, ae_prev_p, ae_count_p, hb_ctrs);
+		if (ret)
+			break;
+	}
+
+	/* Copy current stats for the next iteration */
+	memcpy(last_stats, curr_stats, stats_size);
+	kfree(curr_stats);
+
+	return ret;
+}
+
+void adf_heartbeat_status(struct adf_accel_dev *accel_dev,
+			  enum adf_device_heartbeat_status *hb_status)
+{
+	struct adf_heartbeat *hb;
+
+	if (!adf_dev_started(accel_dev) ||
+	    test_bit(ADF_STATUS_RESTARTING, &accel_dev->status)) {
+		*hb_status = HB_DEV_UNRESPONSIVE;
+		return;
+	}
+
+	if (adf_hb_check_polling_freq(accel_dev) == -EINVAL) {
+		*hb_status = HB_DEV_UNSUPPORTED;
+		return;
+	}
+
+	hb = accel_dev->heartbeat;
+	hb->hb_sent_counter++;
+
+	if (adf_hb_get_status(accel_dev)) {
+		dev_err(&GET_DEV(accel_dev),
+			"Heartbeat ERROR: QAT is not responding.\n");
+		*hb_status = HB_DEV_UNRESPONSIVE;
+		hb->hb_failed_counter++;
+		return;
+	}
+
+	*hb_status = HB_DEV_ALIVE;
+}
+
+int adf_heartbeat_ms_to_ticks(struct adf_accel_dev *accel_dev, unsigned int time_ms,
+			      u32 *value)
+{
+	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+	u32 clk_per_sec;
+
+	/* HB clock may be different than AE clock */
+	if (!hw_data->get_hb_clock)
+		return -EINVAL;
+
+	clk_per_sec = hw_data->get_hb_clock(hw_data);
+	*value = time_ms * (clk_per_sec / MSEC_PER_SEC);
+
+	return 0;
+}
+
+int adf_heartbeat_save_cfg_param(struct adf_accel_dev *accel_dev,
+				 unsigned int timer_ms)
+{
+	char timer_str[ADF_CFG_MAX_VAL_LEN_IN_BYTES];
+
+	snprintf(timer_str, sizeof(timer_str), "%u", timer_ms);
+	return adf_cfg_add_key_value_param(accel_dev, ADF_GENERAL_SEC,
+					  ADF_HEARTBEAT_TIMER, timer_str,
+					  ADF_STR);
+}
+EXPORT_SYMBOL_GPL(adf_heartbeat_save_cfg_param);
+
+int adf_heartbeat_init(struct adf_accel_dev *accel_dev)
+{
+	struct adf_heartbeat *hb;
+
+	hb = kzalloc(sizeof(*hb), GFP_KERNEL);
+	if (!hb)
+		goto err_ret;
+
+	hb->dma.virt_addr = dma_alloc_coherent(&GET_DEV(accel_dev), PAGE_SIZE,
+					       &hb->dma.phy_addr, GFP_KERNEL);
+	if (!hb->dma.virt_addr)
+		goto err_free;
+
+	accel_dev->heartbeat = hb;
+
+	return 0;
+
+err_free:
+	kfree(hb);
+err_ret:
+	return -ENOMEM;
+}
+
+int adf_heartbeat_start(struct adf_accel_dev *accel_dev)
+{
+	unsigned int timer_ticks;
+	int ret;
+
+	if (!accel_dev->heartbeat) {
+		dev_warn(&GET_DEV(accel_dev), "Heartbeat instance not found!");
+		return -EFAULT;
+	}
+
+	ret = get_timer_ticks(accel_dev, &timer_ticks);
+	if (ret)
+		return ret;
+
+	ret = adf_send_admin_hb_timer(accel_dev, timer_ticks);
+	if (ret)
+		dev_warn(&GET_DEV(accel_dev), "Heartbeat not supported!");
+
+	return ret;
+}
+
+void adf_heartbeat_shutdown(struct adf_accel_dev *accel_dev)
+{
+	struct adf_heartbeat *hb = accel_dev->heartbeat;
+
+	if (!hb)
+		return;
+
+	if (hb->dma.virt_addr)
+		dma_free_coherent(&GET_DEV(accel_dev), PAGE_SIZE,
+				  hb->dma.virt_addr, hb->dma.phy_addr);
+
+	kfree(hb);
+	accel_dev->heartbeat = NULL;
+}
diff --git a/drivers/crypto/intel/qat/qat_common/adf_heartbeat.h b/drivers/crypto/intel/qat/qat_common/adf_heartbeat.h
new file mode 100644
index 000000000000..297147f44150
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_heartbeat.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2023 Intel Corporation */
+
+#ifndef ADF_HEARTBEAT_H_
+#define ADF_HEARTBEAT_H_
+
+#include <linux/types.h>
+
+struct adf_accel_dev;
+struct dentry;
+
+#define ADF_CFG_HB_TIMER_MIN_MS 200
+#define ADF_CFG_HB_TIMER_DEFAULT_MS 500
+#define ADF_CFG_HB_COUNT_THRESHOLD 3
+
+enum adf_device_heartbeat_status {
+	HB_DEV_UNRESPONSIVE = 0,
+	HB_DEV_ALIVE,
+	HB_DEV_UNSUPPORTED,
+};
+
+struct adf_heartbeat {
+	unsigned int hb_sent_counter;
+	unsigned int hb_failed_counter;
+	unsigned int hb_timer;
+	u64 last_hb_check_time;
+	struct hb_dma_addr {
+		dma_addr_t phy_addr;
+		void *virt_addr;
+	} dma;
+	struct {
+		struct dentry *base_dir;
+		struct dentry *status;
+		struct dentry *cfg;
+		struct dentry *sent;
+		struct dentry *failed;
+	} dbgfs;
+};
+
+#ifdef CONFIG_DEBUG_FS
+int adf_heartbeat_init(struct adf_accel_dev *accel_dev);
+int adf_heartbeat_start(struct adf_accel_dev *accel_dev);
+void adf_heartbeat_shutdown(struct adf_accel_dev *accel_dev);
+
+int adf_heartbeat_ms_to_ticks(struct adf_accel_dev *accel_dev, unsigned int time_ms,
+			      uint32_t *value);
+int adf_heartbeat_save_cfg_param(struct adf_accel_dev *accel_dev,
+				 unsigned int timer_ms);
+void adf_heartbeat_status(struct adf_accel_dev *accel_dev,
+			  enum adf_device_heartbeat_status *hb_status);
+
+#else
+static inline int adf_heartbeat_init(struct adf_accel_dev *accel_dev)
+{
+	return 0;
+}
+
+static inline int adf_heartbeat_start(struct adf_accel_dev *accel_dev)
+{
+	return 0;
+}
+
+static inline void adf_heartbeat_shutdown(struct adf_accel_dev *accel_dev)
+{
+}
+
+static inline int adf_heartbeat_save_cfg_param(struct adf_accel_dev *accel_dev,
+					       unsigned int timer_ms)
+{
+	return 0;
+}
+#endif
+#endif /* ADF_HEARTBEAT_H_ */
diff --git a/drivers/crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.c b/drivers/crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.c
new file mode 100644
index 000000000000..803cbfd838f0
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation */
+
+#include <linux/debugfs.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/kstrtox.h>
+#include <linux/types.h>
+#include "adf_cfg.h"
+#include "adf_common_drv.h"
+#include "adf_heartbeat.h"
+#include "adf_heartbeat_dbgfs.h"
+
+#define HB_OK 0
+#define HB_ERROR -1
+#define HB_STATUS_MAX_STRLEN 4
+#define HB_STATS_MAX_STRLEN 16
+
+static ssize_t adf_hb_stats_read(struct file *file, char __user *user_buffer,
+				 size_t count, loff_t *ppos)
+{
+	char buf[HB_STATS_MAX_STRLEN];
+	unsigned int *value;
+	int len;
+
+	if (*ppos > 0)
+		return 0;
+
+	value = file->private_data;
+	len = scnprintf(buf, sizeof(buf), "%u\n", *value);
+
+	return simple_read_from_buffer(user_buffer, count, ppos, buf, len + 1);
+}
+
+static const struct file_operations adf_hb_stats_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = adf_hb_stats_read,
+};
+
+static ssize_t adf_hb_status_read(struct file *file, char __user *user_buf,
+				  size_t count, loff_t *ppos)
+{
+	enum adf_device_heartbeat_status hb_status;
+	char ret_str[HB_STATUS_MAX_STRLEN];
+	struct adf_accel_dev *accel_dev;
+	int ret_code;
+	size_t len;
+
+	if (*ppos > 0)
+		return 0;
+
+	accel_dev = file->private_data;
+	ret_code = HB_OK;
+
+	adf_heartbeat_status(accel_dev, &hb_status);
+
+	if (hb_status != HB_DEV_ALIVE)
+		ret_code = HB_ERROR;
+
+	len = scnprintf(ret_str, sizeof(ret_str), "%d\n", ret_code);
+
+	return simple_read_from_buffer(user_buf, count, ppos, ret_str, len + 1);
+}
+
+static const struct file_operations adf_hb_status_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = adf_hb_status_read,
+};
+
+static ssize_t adf_hb_cfg_read(struct file *file, char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	char timer_str[ADF_CFG_MAX_VAL_LEN_IN_BYTES];
+	struct adf_accel_dev *accel_dev;
+	unsigned int timer_ms;
+	int len;
+
+	if (*ppos > 0)
+		return 0;
+
+	accel_dev = file->private_data;
+	timer_ms = accel_dev->heartbeat->hb_timer;
+	len = scnprintf(timer_str, sizeof(timer_str), "%u\n", timer_ms);
+
+	return simple_read_from_buffer(user_buf, count, ppos, timer_str,
+				       len + 1);
+}
+
+static ssize_t adf_hb_cfg_write(struct file *file, const char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	char input_str[ADF_CFG_MAX_VAL_LEN_IN_BYTES] = { };
+	struct adf_accel_dev *accel_dev;
+	int ret, written_chars;
+	unsigned int timer_ms;
+	u32 ticks;
+
+	accel_dev = file->private_data;
+	timer_ms = ADF_CFG_HB_TIMER_DEFAULT_MS;
+
+	/* last byte left as string termination */
+	if (count > sizeof(input_str) - 1)
+		return -EINVAL;
+
+	written_chars = simple_write_to_buffer(input_str, sizeof(input_str) - 1,
+					       ppos, user_buf, count);
+	if (written_chars > 0) {
+		ret = kstrtouint(input_str, 10, &timer_ms);
+		if (ret) {
+			dev_err(&GET_DEV(accel_dev),
+				"heartbeat_cfg: Invalid value\n");
+			return ret;
+		}
+
+		if (timer_ms < ADF_CFG_HB_TIMER_MIN_MS) {
+			dev_err(&GET_DEV(accel_dev),
+				"heartbeat_cfg: Invalid value\n");
+			return -EINVAL;
+		}
+
+		/*
+		 * On 4xxx devices adf_timer is responsible for HB updates and
+		 * its period is fixed to 200ms
+		 */
+		if (accel_dev->timer)
+			timer_ms = ADF_CFG_HB_TIMER_MIN_MS;
+
+		ret = adf_heartbeat_save_cfg_param(accel_dev, timer_ms);
+		if (ret)
+			return ret;
+
+		ret = adf_heartbeat_ms_to_ticks(accel_dev, timer_ms, &ticks);
+		if (ret)
+			return ret;
+
+		ret = adf_send_admin_hb_timer(accel_dev, ticks);
+		if (ret)
+			return ret;
+
+		accel_dev->heartbeat->hb_timer = timer_ms;
+	}
+
+	return written_chars;
+}
+
+static const struct file_operations adf_hb_cfg_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = adf_hb_cfg_read,
+	.write = adf_hb_cfg_write,
+};
+
+void adf_heartbeat_dbgfs_add(struct adf_accel_dev *accel_dev)
+{
+	struct adf_heartbeat *hb = accel_dev->heartbeat;
+
+	if (!hb)
+		return;
+
+	hb->dbgfs.base_dir = debugfs_create_dir("heartbeat", accel_dev->debugfs_dir);
+	hb->dbgfs.status = debugfs_create_file("status", 0400, hb->dbgfs.base_dir,
+					       accel_dev, &adf_hb_status_fops);
+	hb->dbgfs.sent = debugfs_create_file("queries_sent", 0400, hb->dbgfs.base_dir,
+					     &hb->hb_sent_counter, &adf_hb_stats_fops);
+	hb->dbgfs.failed = debugfs_create_file("queries_failed", 0400, hb->dbgfs.base_dir,
+					       &hb->hb_failed_counter, &adf_hb_stats_fops);
+	hb->dbgfs.cfg = debugfs_create_file("config", 0600, hb->dbgfs.base_dir,
+					    accel_dev, &adf_hb_cfg_fops);
+}
+EXPORT_SYMBOL_GPL(adf_heartbeat_dbgfs_add);
+
+void adf_heartbeat_dbgfs_rm(struct adf_accel_dev *accel_dev)
+{
+	struct adf_heartbeat *hb = accel_dev->heartbeat;
+
+	if (!hb)
+		return;
+
+	debugfs_remove(hb->dbgfs.status);
+	hb->dbgfs.status = NULL;
+	debugfs_remove(hb->dbgfs.sent);
+	hb->dbgfs.sent = NULL;
+	debugfs_remove(hb->dbgfs.failed);
+	hb->dbgfs.failed = NULL;
+	debugfs_remove(hb->dbgfs.cfg);
+	hb->dbgfs.cfg = NULL;
+	debugfs_remove(hb->dbgfs.base_dir);
+	hb->dbgfs.base_dir = NULL;
+}
+EXPORT_SYMBOL_GPL(adf_heartbeat_dbgfs_rm);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.h b/drivers/crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.h
new file mode 100644
index 000000000000..84dd29ea6454
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2023 Intel Corporation */
+
+#ifndef ADF_HEARTBEAT_DBGFS_H_
+#define ADF_HEARTBEAT_DBGFS_H_
+
+struct adf_accel_dev;
+
+void adf_heartbeat_dbgfs_add(struct adf_accel_dev *accel_dev);
+void adf_heartbeat_dbgfs_rm(struct adf_accel_dev *accel_dev);
+
+#endif /* ADF_HEARTBEAT_DBGFS_H_ */
diff --git a/drivers/crypto/intel/qat/qat_common/adf_init.c b/drivers/crypto/intel/qat/qat_common/adf_init.c
index 53fca6a7e2af..89001fe92e76 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_init.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_init.c
@@ -8,6 +8,7 @@
 #include "adf_cfg.h"
 #include "adf_common_drv.h"
 #include "adf_dbgfs.h"
+#include "adf_heartbeat.h"
 
 static LIST_HEAD(service_table);
 static DEFINE_MUTEX(service_lock);
@@ -129,6 +130,8 @@ static int adf_dev_init(struct adf_accel_dev *accel_dev)
 			return -EFAULT;
 	}
 
+	adf_heartbeat_init(accel_dev);
+
 	/*
 	 * Subservice initialisation is divided into two stages: init and start.
 	 * This is to facilitate any ordering dependencies between services
@@ -204,6 +207,8 @@ static int adf_dev_start(struct adf_accel_dev *accel_dev)
 		}
 	}
 
+	adf_heartbeat_start(accel_dev);
+
 	list_for_each(list_itr, &service_table) {
 		service = list_entry(list_itr, struct service_hndl, list);
 		if (service->event_hld(accel_dev, ADF_EVENT_START)) {
@@ -347,6 +352,8 @@ static void adf_dev_shutdown(struct adf_accel_dev *accel_dev)
 			clear_bit(accel_dev->accel_id, service->init_status);
 	}
 
+	adf_heartbeat_shutdown(accel_dev);
+
 	hw_data->disable_iov(accel_dev);
 
 	if (test_bit(ADF_STATUS_IRQ_ALLOCATED, &accel_dev->status)) {
diff --git a/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h b/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h
index e836fbaeec62..3e968a4bcc9c 100644
--- a/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h
+++ b/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h
@@ -16,6 +16,7 @@ enum icp_qat_fw_init_admin_cmd_id {
 	ICP_QAT_FW_HEARTBEAT_SYNC = 7,
 	ICP_QAT_FW_HEARTBEAT_GET = 8,
 	ICP_QAT_FW_COMP_CAPABILITY_GET = 9,
+	ICP_QAT_FW_HEARTBEAT_TIMER_SET = 13,
 	ICP_QAT_FW_TIMER_GET = 19,
 	ICP_QAT_FW_PM_STATE_CONFIG = 128,
 };
@@ -41,6 +42,9 @@ struct icp_qat_fw_init_admin_req {
 		struct {
 			__u32 int_timer_ticks;
 		};
+		struct {
+			__u32 heartbeat_ticks;
+		};
 		__u32 idle_filter;
 	};
 
diff --git a/drivers/crypto/intel/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c b/drivers/crypto/intel/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
index c57403a6fbac..8fbab905c5cc 100644
--- a/drivers/crypto/intel/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
@@ -247,6 +247,7 @@ void adf_init_hw_data_dh895xcc(struct adf_hw_device_data *hw_data)
 	hw_data->dev_config = adf_gen2_dev_config;
 	hw_data->clock_frequency = ADF_DH895X_AE_FREQ;
 	hw_data->get_hb_clock = get_ts_clock;
+	hw_data->num_hb_ctrs = ADF_NUM_HB_CNT_PER_AE;
 
 	adf_gen2_init_pf_pfvf_ops(&hw_data->pfvf_ops);
 	hw_data->pfvf_ops.enable_vf2pf_interrupts = enable_vf2pf_interrupts;
-- 
2.40.1


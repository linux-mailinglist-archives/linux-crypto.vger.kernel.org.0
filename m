Return-Path: <linux-crypto+bounces-974-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004C081C83F
	for <lists+linux-crypto@lfdr.de>; Fri, 22 Dec 2023 11:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155A41C21E9D
	for <lists+linux-crypto@lfdr.de>; Fri, 22 Dec 2023 10:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CA311727;
	Fri, 22 Dec 2023 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DHWOKeC9"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA6C168A2
	for <linux-crypto@vger.kernel.org>; Fri, 22 Dec 2023 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703241496; x=1734777496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FOgTGQHKXCd9DLFSaeQKpicCPjwgOnWV1+4B1C9/PJM=;
  b=DHWOKeC942G5GCl+f+MP64LNttAxB6NXtEPJuqY37zBbsKDAKLyOIPae
   9yCuxNvcs+Bdcs+6dxaSrYK/ePtzZ9xNT83scwmVeF9YtzbUm4sj4eWiJ
   4sYxBxeqinSPLnRxqK9Z+MLNRIrZv1PMMZe06NMa2UkPbTz0sZ9Lk9HZj
   DoZj4oEVNScDnDIIckZkP0B3zn5m0mQTRKpbolVCuoUo0k1l3krrgJAv/
   3nwBeskgl01nNY0hvxDr5FYmf0NRpqCgPsiiWf0HOL2al6xXh3lSDd7sd
   rfK/ZPCvREKcs7wzyfp/yj80ziGloMyZAYcCU5ZtX3FGV0oD3Q0g3cp9+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="2948190"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="2948190"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 02:38:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="726742880"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="726742880"
Received: from r007s007_zp31l10c01.deacluster.intel.com (HELO fedora.deacluster.intel.com) ([10.219.171.169])
  by orsmga003.jf.intel.com with ESMTP; 22 Dec 2023 02:38:14 -0800
From: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
To: herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org,
	qat-linux@intel.com,
	Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Damian Muszynski <damian.muszynski@intel.com>
Subject: [PATCH v2 3/4] crypto: qat - add support for device telemetry
Date: Fri, 22 Dec 2023 11:35:07 +0100
Message-ID: <20231222103508.1037442-4-lucas.segarra.fernandez@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231222103508.1037442-1-lucas.segarra.fernandez@intel.com>
References: <20231222103508.1037442-1-lucas.segarra.fernandez@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose through debugfs device telemetry data for QAT GEN4 devices.

This allows to gather metrics about the performance and the utilization
of a device. In particular, statistics on (1) the utilization of the
PCIe channel, (2) address translation, when SVA is enabled and (3) the
internal engines for crypto and data compression.

If telemetry is supported by the firmware, the driver allocates a DMA
region and a circular buffer. When telemetry is enabled, through the
`control` attribute in debugfs, the driver sends to the firmware, via
the admin interface, the `TL_START` command. This triggers the device to
periodically gather telemetry data from hardware registers and write it
into the DMA memory region. The device writes into the shared region
every second.

The driver, every 500ms, snapshots the DMA shared region into the
circular buffer. This is then used to compute basic metric
(min/max/average) on each counter, every time the `device_data` attribute
is queried.

Telemetry counters are exposed through debugfs in the folder
/sys/kernel/debug/qat_<device>_<BDF>/telemetry.

For details, refer to debugfs-driver-qat_telemetry in Documentation/ABI.

This patch is based on earlier work done by Wojciech Ziemba.

Signed-off-by: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Damian Muszynski <damian.muszynski@intel.com>
---
 .../ABI/testing/debugfs-driver-qat_telemetry  | 103 ++++
 .../intel/qat/qat_420xx/adf_420xx_hw_data.c   |   2 +
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     |   2 +
 drivers/crypto/intel/qat/qat_common/Makefile  |   3 +
 .../intel/qat/qat_common/adf_accel_devices.h  |   4 +
 .../crypto/intel/qat/qat_common/adf_dbgfs.c   |   3 +
 .../crypto/intel/qat/qat_common/adf_gen4_tl.c | 118 ++++
 .../crypto/intel/qat/qat_common/adf_gen4_tl.h | 121 +++++
 .../crypto/intel/qat/qat_common/adf_init.c    |  12 +
 .../intel/qat/qat_common/adf_telemetry.c      | 271 ++++++++++
 .../intel/qat/qat_common/adf_telemetry.h      |  92 ++++
 .../intel/qat/qat_common/adf_tl_debugfs.c     | 502 ++++++++++++++++++
 .../intel/qat/qat_common/adf_tl_debugfs.h     | 106 ++++
 13 files changed, 1339 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-driver-qat_telemetry
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen4_tl.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen4_tl.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_telemetry.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_telemetry.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.h

diff --git a/Documentation/ABI/testing/debugfs-driver-qat_telemetry b/Documentation/ABI/testing/debugfs-driver-qat_telemetry
new file mode 100644
index 000000000000..24532365387c
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-driver-qat_telemetry
@@ -0,0 +1,103 @@
+What:		/sys/kernel/debug/qat_<device>_<BDF>/telemetry/control
+Date:		March 2024
+KernelVersion:	6.8
+Contact:	qat-linux@intel.com
+Description:	(RW) Enables/disables the reporting of telemetry metrics.
+
+		Allowed values to write:
+		========================
+		* 0: disable telemetry
+		* 1: enable telemetry
+		* 2, 3, 4: enable telemetry and calculate minimum, maximum
+		  and average for each counter over 2, 3 or 4 samples
+
+		Returned values:
+		================
+		* 1-4: telemetry is enabled and running
+		* 0: telemetry is disabled
+
+		Example.
+
+		Writing '3' to this file starts the collection of
+		telemetry metrics. Samples are collected every second and
+		stored in a circular buffer of size 3. These values are then
+		used to calculate the minimum, maximum and average for each
+		counter. After enabling, counters can be retrieved through
+		the ``device_data`` file::
+
+		  echo 3 > /sys/kernel/debug/qat_4xxx_0000:6b:00.0/telemetry/control
+
+		Writing '0' to this file stops the collection of telemetry
+		metrics::
+
+		  echo 0 > /sys/kernel/debug/qat_4xxx_0000:6b:00.0/telemetry/control
+
+		This attribute is only available for qat_4xxx devices.
+
+What:		/sys/kernel/debug/qat_<device>_<BDF>/telemetry/device_data
+Date:		March 2024
+KernelVersion:	6.8
+Contact:	qat-linux@intel.com
+Description:	(RO) Reports device telemetry counters.
+		Reads report metrics about performance and utilization of
+		a QAT device:
+
+		=======================	========================================
+		Field			Description
+		=======================	========================================
+		sample_cnt		number of acquisitions of telemetry data
+					from the device. Reads are performed
+					every 1000 ms.
+		pci_trans_cnt		number of PCIe partial transactions
+		max_rd_lat		maximum logged read latency [ns] (could
+					be any read operation)
+		rd_lat_acc_avg		average read latency [ns]
+		max_gp_lat		max get to put latency [ns] (only takes
+					samples for AE0)
+		gp_lat_acc_avg		average get to put latency [ns]
+		bw_in			PCIe, write bandwidth [Mbps]
+		bw_out			PCIe, read bandwidth [Mbps]
+		at_page_req_lat_avg	Address Translator(AT), average page
+					request latency [ns]
+		at_trans_lat_avg	AT, average page translation latency [ns]
+		at_max_tlb_used		AT, maximum uTLB used
+		util_cpr<N>		utilization of Compression slice N [%]
+		exec_cpr<N>		execution count of Compression slice N
+		util_xlt<N>		utilization of Translator slice N [%]
+		exec_xlt<N>		execution count of Translator slice N
+		util_dcpr<N>		utilization of Decompression slice N [%]
+		exec_dcpr<N>		execution count of Decompression slice N
+		util_pke<N>		utilization of PKE N [%]
+		exec_pke<N>		execution count of PKE N
+		util_ucs<N>		utilization of UCS slice N [%]
+		exec_ucs<N>		execution count of UCS slice N
+		util_wat<N>		utilization of Wireless Authentication
+					slice N [%]
+		exec_wat<N>		execution count of Wireless Authentication
+					slice N
+		util_wcp<N>		utilization of Wireless Cipher slice N [%]
+		exec_wcp<N>		execution count of Wireless Cipher slice N
+		util_cph<N>		utilization of Cipher slice N [%]
+		exec_cph<N>		execution count of Cipher slice N
+		util_ath<N>		utilization of Authentication slice N [%]
+		exec_ath<N>		execution count of Authentication slice N
+		=======================	========================================
+
+		The telemetry report file can be read with the following command::
+
+		  cat /sys/kernel/debug/qat_4xxx_0000:6b:00.0/telemetry/device_data
+
+		If ``control`` is set to 1, only the current values of the
+		counters are displayed::
+
+		  <counter_name> <current>
+
+		If ``control`` is 2, 3 or 4, counters are displayed in the
+		following format::
+
+		  <counter_name> <current> <min> <max> <avg>
+
+		If a device lacks of a specific accelerator, the corresponding
+		attribute is not reported.
+
+		This attribute is only available for qat_4xxx devices.
diff --git a/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
index d296eb18db3c..a7730d8057d6 100644
--- a/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
@@ -15,6 +15,7 @@
 #include <adf_gen4_pm.h>
 #include <adf_gen4_ras.h>
 #include <adf_gen4_timer.h>
+#include <adf_gen4_tl.h>
 #include "adf_420xx_hw_data.h"
 #include "icp_qat_hw.h"
 
@@ -543,6 +544,7 @@ void adf_init_hw_data_420xx(struct adf_hw_device_data *hw_data, u32 dev_id)
 	adf_gen4_init_pf_pfvf_ops(&hw_data->pfvf_ops);
 	adf_gen4_init_dc_ops(&hw_data->dc_ops);
 	adf_gen4_init_ras_ops(&hw_data->ras_ops);
+	adf_gen4_init_tl_data(&hw_data->tl_data);
 	adf_init_rl_data(&hw_data->rl_data);
 }
 
diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
index f133126932c1..73001b20cbfd 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -15,6 +15,7 @@
 #include <adf_gen4_pm.h>
 #include "adf_gen4_ras.h"
 #include <adf_gen4_timer.h>
+#include <adf_gen4_tl.h>
 #include "adf_4xxx_hw_data.h"
 #include "icp_qat_hw.h"
 
@@ -453,6 +454,7 @@ void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data, u32 dev_id)
 	adf_gen4_init_pf_pfvf_ops(&hw_data->pfvf_ops);
 	adf_gen4_init_dc_ops(&hw_data->dc_ops);
 	adf_gen4_init_ras_ops(&hw_data->ras_ops);
+	adf_gen4_init_tl_data(&hw_data->tl_data);
 	adf_init_rl_data(&hw_data->rl_data);
 }
 
diff --git a/drivers/crypto/intel/qat/qat_common/Makefile b/drivers/crypto/intel/qat/qat_common/Makefile
index 928de6997155..6908727bff3b 100644
--- a/drivers/crypto/intel/qat/qat_common/Makefile
+++ b/drivers/crypto/intel/qat/qat_common/Makefile
@@ -41,9 +41,12 @@ intel_qat-$(CONFIG_DEBUG_FS) += adf_transport_debug.o \
 				adf_fw_counters.o \
 				adf_cnv_dbgfs.o \
 				adf_gen4_pm_debugfs.o \
+				adf_gen4_tl.o \
 				adf_heartbeat.o \
 				adf_heartbeat_dbgfs.o \
 				adf_pm_dbgfs.o \
+				adf_telemetry.o \
+				adf_tl_debugfs.o \
 				adf_dbgfs.o
 
 intel_qat-$(CONFIG_PCI_IOV) += adf_sriov.o adf_vf_isr.o adf_pfvf_utils.o \
diff --git a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
index fc7786d71e96..b274ebc799c9 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include "adf_cfg_common.h"
 #include "adf_rl.h"
+#include "adf_telemetry.h"
 #include "adf_pfvf_msg.h"
 
 #define ADF_DH895XCC_DEVICE_NAME "dh895xcc"
@@ -254,6 +255,7 @@ struct adf_hw_device_data {
 	struct adf_ras_ops ras_ops;
 	struct adf_dev_err_mask dev_err_mask;
 	struct adf_rl_hw_data rl_data;
+	struct adf_tl_hw_data tl_data;
 	const char *fw_name;
 	const char *fw_mmp_name;
 	u32 fuses;
@@ -308,6 +310,7 @@ struct adf_hw_device_data {
 #define GET_CSR_OPS(accel_dev) (&(accel_dev)->hw_device->csr_ops)
 #define GET_PFVF_OPS(accel_dev) (&(accel_dev)->hw_device->pfvf_ops)
 #define GET_DC_OPS(accel_dev) (&(accel_dev)->hw_device->dc_ops)
+#define GET_TL_DATA(accel_dev) GET_HW_DATA(accel_dev)->tl_data
 #define accel_to_pci_dev(accel_ptr) accel_ptr->accel_pci_dev.pci_dev
 
 struct adf_admin_comms;
@@ -356,6 +359,7 @@ struct adf_accel_dev {
 	struct adf_cfg_device_data *cfg;
 	struct adf_fw_loader_data *fw_loader;
 	struct adf_admin_comms *admin;
+	struct adf_telemetry *telemetry;
 	struct adf_dc_data *dc_data;
 	struct adf_pm power_management;
 	struct list_head crypto_list;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_dbgfs.c b/drivers/crypto/intel/qat/qat_common/adf_dbgfs.c
index 477efcc81a16..c42f5c25aabd 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_dbgfs.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_dbgfs.c
@@ -10,6 +10,7 @@
 #include "adf_fw_counters.h"
 #include "adf_heartbeat_dbgfs.h"
 #include "adf_pm_dbgfs.h"
+#include "adf_tl_debugfs.h"
 
 /**
  * adf_dbgfs_init() - add persistent debugfs entries
@@ -66,6 +67,7 @@ void adf_dbgfs_add(struct adf_accel_dev *accel_dev)
 		adf_heartbeat_dbgfs_add(accel_dev);
 		adf_pm_dbgfs_add(accel_dev);
 		adf_cnv_dbgfs_add(accel_dev);
+		adf_tl_dbgfs_add(accel_dev);
 	}
 }
 
@@ -79,6 +81,7 @@ void adf_dbgfs_rm(struct adf_accel_dev *accel_dev)
 		return;
 
 	if (!accel_dev->is_vf) {
+		adf_tl_dbgfs_rm(accel_dev);
 		adf_cnv_dbgfs_rm(accel_dev);
 		adf_pm_dbgfs_rm(accel_dev);
 		adf_heartbeat_dbgfs_rm(accel_dev);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_tl.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_tl.c
new file mode 100644
index 000000000000..4efbe6bc651c
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_tl.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2023 Intel Corporation. */
+#include <linux/export.h>
+#include <linux/kernel.h>
+
+#include "adf_gen4_tl.h"
+#include "adf_telemetry.h"
+#include "adf_tl_debugfs.h"
+
+#define ADF_GEN4_TL_DEV_REG_OFF(reg) ADF_TL_DEV_REG_OFF(reg, gen4)
+
+#define ADF_GEN4_TL_SL_UTIL_COUNTER(_name)	\
+	ADF_TL_COUNTER("util_" #_name,		\
+			ADF_TL_SIMPLE_COUNT,	\
+			ADF_TL_SLICE_REG_OFF(_name, reg_tm_slice_util, gen4))
+
+#define ADF_GEN4_TL_SL_EXEC_COUNTER(_name)	\
+	ADF_TL_COUNTER("exec_" #_name,		\
+			ADF_TL_SIMPLE_COUNT,	\
+			ADF_TL_SLICE_REG_OFF(_name, reg_tm_slice_exec_cnt, gen4))
+
+/* Device level counters. */
+static const struct adf_tl_dbg_counter dev_counters[] = {
+	/* PCIe partial transactions. */
+	ADF_TL_COUNTER(PCI_TRANS_CNT_NAME, ADF_TL_SIMPLE_COUNT,
+		       ADF_GEN4_TL_DEV_REG_OFF(reg_tl_pci_trans_cnt)),
+	/* Max read latency[ns]. */
+	ADF_TL_COUNTER(MAX_RD_LAT_NAME, ADF_TL_COUNTER_NS,
+		       ADF_GEN4_TL_DEV_REG_OFF(reg_tl_rd_lat_max)),
+	/* Read latency average[ns]. */
+	ADF_TL_COUNTER_LATENCY(RD_LAT_ACC_NAME, ADF_TL_COUNTER_NS_AVG,
+			       ADF_GEN4_TL_DEV_REG_OFF(reg_tl_rd_lat_acc),
+			       ADF_GEN4_TL_DEV_REG_OFF(reg_tl_rd_cmpl_cnt)),
+	/* Max get to put latency[ns]. */
+	ADF_TL_COUNTER(MAX_LAT_NAME, ADF_TL_COUNTER_NS,
+		       ADF_GEN4_TL_DEV_REG_OFF(reg_tl_gp_lat_max)),
+	/* Get to put latency average[ns]. */
+	ADF_TL_COUNTER_LATENCY(LAT_ACC_NAME, ADF_TL_COUNTER_NS_AVG,
+			       ADF_GEN4_TL_DEV_REG_OFF(reg_tl_gp_lat_acc),
+			       ADF_GEN4_TL_DEV_REG_OFF(reg_tl_ae_put_cnt)),
+	/* PCIe write bandwidth[Mbps]. */
+	ADF_TL_COUNTER(BW_IN_NAME, ADF_TL_COUNTER_MBPS,
+		       ADF_GEN4_TL_DEV_REG_OFF(reg_tl_bw_in)),
+	/* PCIe read bandwidth[Mbps]. */
+	ADF_TL_COUNTER(BW_OUT_NAME, ADF_TL_COUNTER_MBPS,
+		       ADF_GEN4_TL_DEV_REG_OFF(reg_tl_bw_out)),
+	/* Page request latency average[ns]. */
+	ADF_TL_COUNTER_LATENCY(PAGE_REQ_LAT_NAME, ADF_TL_COUNTER_NS_AVG,
+			       ADF_GEN4_TL_DEV_REG_OFF(reg_tl_at_page_req_lat_acc),
+			       ADF_GEN4_TL_DEV_REG_OFF(reg_tl_at_page_req_cnt)),
+	/* Page translation latency average[ns]. */
+	ADF_TL_COUNTER_LATENCY(AT_TRANS_LAT_NAME, ADF_TL_COUNTER_NS_AVG,
+			       ADF_GEN4_TL_DEV_REG_OFF(reg_tl_at_trans_lat_acc),
+			       ADF_GEN4_TL_DEV_REG_OFF(reg_tl_at_trans_lat_cnt)),
+	/* Maximum uTLB used. */
+	ADF_TL_COUNTER(AT_MAX_UTLB_USED_NAME, ADF_TL_SIMPLE_COUNT,
+		       ADF_GEN4_TL_DEV_REG_OFF(reg_tl_at_max_tlb_used)),
+};
+
+/* Slice utilization counters. */
+static const struct adf_tl_dbg_counter sl_util_counters[ADF_TL_SL_CNT_COUNT] = {
+	/* Compression slice utilization. */
+	ADF_GEN4_TL_SL_UTIL_COUNTER(cpr),
+	/* Translator slice utilization. */
+	ADF_GEN4_TL_SL_UTIL_COUNTER(xlt),
+	/* Decompression slice utilization. */
+	ADF_GEN4_TL_SL_UTIL_COUNTER(dcpr),
+	/* PKE utilization. */
+	ADF_GEN4_TL_SL_UTIL_COUNTER(pke),
+	/* Wireless Authentication slice utilization. */
+	ADF_GEN4_TL_SL_UTIL_COUNTER(wat),
+	/* Wireless Cipher slice utilization. */
+	ADF_GEN4_TL_SL_UTIL_COUNTER(wcp),
+	/* UCS slice utilization. */
+	ADF_GEN4_TL_SL_UTIL_COUNTER(ucs),
+	/* Cipher slice utilization. */
+	ADF_GEN4_TL_SL_UTIL_COUNTER(cph),
+	/* Authentication slice utilization. */
+	ADF_GEN4_TL_SL_UTIL_COUNTER(ath),
+};
+
+/* Slice execution counters. */
+static const struct adf_tl_dbg_counter sl_exec_counters[ADF_TL_SL_CNT_COUNT] = {
+	/* Compression slice execution count. */
+	ADF_GEN4_TL_SL_EXEC_COUNTER(cpr),
+	/* Translator slice execution count. */
+	ADF_GEN4_TL_SL_EXEC_COUNTER(xlt),
+	/* Decompression slice execution count. */
+	ADF_GEN4_TL_SL_EXEC_COUNTER(dcpr),
+	/* PKE execution count. */
+	ADF_GEN4_TL_SL_EXEC_COUNTER(pke),
+	/* Wireless Authentication slice execution count. */
+	ADF_GEN4_TL_SL_EXEC_COUNTER(wat),
+	/* Wireless Cipher slice execution count. */
+	ADF_GEN4_TL_SL_EXEC_COUNTER(wcp),
+	/* UCS slice execution count. */
+	ADF_GEN4_TL_SL_EXEC_COUNTER(ucs),
+	/* Cipher slice execution count. */
+	ADF_GEN4_TL_SL_EXEC_COUNTER(cph),
+	/* Authentication slice execution count. */
+	ADF_GEN4_TL_SL_EXEC_COUNTER(ath),
+};
+
+void adf_gen4_init_tl_data(struct adf_tl_hw_data *tl_data)
+{
+	tl_data->layout_sz = ADF_GEN4_TL_LAYOUT_SZ;
+	tl_data->slice_reg_sz = ADF_GEN4_TL_SLICE_REG_SZ;
+	tl_data->num_hbuff = ADF_GEN4_TL_NUM_HIST_BUFFS;
+	tl_data->msg_cnt_off = ADF_GEN4_TL_MSG_CNT_OFF;
+	tl_data->cpp_ns_per_cycle = ADF_GEN4_CPP_NS_PER_CYCLE;
+	tl_data->bw_units_to_bytes = ADF_GEN4_TL_BW_HW_UNITS_TO_BYTES;
+
+	tl_data->dev_counters = dev_counters;
+	tl_data->num_dev_counters = ARRAY_SIZE(dev_counters);
+	tl_data->sl_util_counters = sl_util_counters;
+	tl_data->sl_exec_counters = sl_exec_counters;
+}
+EXPORT_SYMBOL_GPL(adf_gen4_init_tl_data);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_tl.h b/drivers/crypto/intel/qat/qat_common/adf_gen4_tl.h
new file mode 100644
index 000000000000..feb2eecf24cf
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_tl.h
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2023 Intel Corporation. */
+#ifndef ADF_GEN4_TL_H
+#define ADF_GEN4_TL_H
+
+#include <linux/stddef.h>
+#include <linux/types.h>
+
+struct adf_tl_hw_data;
+
+/* Computation constants. */
+#define ADF_GEN4_CPP_NS_PER_CYCLE		2
+#define ADF_GEN4_TL_BW_HW_UNITS_TO_BYTES	64
+
+/* Maximum aggregation time. Value in milliseconds. */
+#define ADF_GEN4_TL_MAX_AGGR_TIME_MS		4000
+/* Num of buffers to store historic values. */
+#define ADF_GEN4_TL_NUM_HIST_BUFFS \
+	(ADF_GEN4_TL_MAX_AGGR_TIME_MS / ADF_TL_DATA_WR_INTERVAL_MS)
+
+/* Max number of HW resources of one type. */
+#define ADF_GEN4_TL_MAX_SLICES_PER_TYPE		24
+
+/**
+ * struct adf_gen4_tl_slice_data_regs - HW slice data as populated by FW.
+ * @reg_tm_slice_exec_cnt: Slice execution count.
+ * @reg_tm_slice_util: Slice utilization.
+ */
+struct adf_gen4_tl_slice_data_regs {
+	__u32 reg_tm_slice_exec_cnt;
+	__u32 reg_tm_slice_util;
+};
+
+#define ADF_GEN4_TL_SLICE_REG_SZ sizeof(struct adf_gen4_tl_slice_data_regs)
+
+/**
+ * struct adf_gen4_tl_device_data_regs - This structure stores device telemetry
+ * counter values as are being populated periodically by device.
+ * @reg_tl_rd_lat_acc: read latency accumulator
+ * @reg_tl_gp_lat_acc: get-put latency accumulator
+ * @reg_tl_at_page_req_lat_acc: AT/DevTLB page request latency accumulator
+ * @reg_tl_at_trans_lat_acc: DevTLB transaction latency accumulator
+ * @reg_tl_re_acc: accumulated ring empty time
+ * @reg_tl_pci_trans_cnt: PCIe partial transactions
+ * @reg_tl_rd_lat_max: maximum logged read latency
+ * @reg_tl_rd_cmpl_cnt: read requests completed count
+ * @reg_tl_gp_lat_max: maximum logged get to put latency
+ * @reg_tl_ae_put_cnt: Accelerator Engine put counts across all rings
+ * @reg_tl_bw_in: PCIe write bandwidth
+ * @reg_tl_bw_out: PCIe read bandwidth
+ * @reg_tl_at_page_req_cnt: DevTLB page requests count
+ * @reg_tl_at_trans_lat_cnt: DevTLB transaction latency samples count
+ * @reg_tl_at_max_tlb_used: maximum uTLB used
+ * @reg_tl_re_cnt: ring empty time samples count
+ * @reserved: reserved
+ * @ath_slices: array of Authentication slices utilization registers
+ * @cph_slices: array of Cipher slices utilization registers
+ * @cpr_slices: array of Compression slices utilization registers
+ * @xlt_slices: array of Translator slices utilization registers
+ * @dcpr_slices: array of Decompression slices utilization registers
+ * @pke_slices: array of PKE slices utilization registers
+ * @ucs_slices: array of UCS slices utilization registers
+ * @wat_slices: array of Wireless Authentication slices utilization registers
+ * @wcp_slices: array of Wireless Cipher slices utilization registers
+ */
+struct adf_gen4_tl_device_data_regs {
+	__u64 reg_tl_rd_lat_acc;
+	__u64 reg_tl_gp_lat_acc;
+	__u64 reg_tl_at_page_req_lat_acc;
+	__u64 reg_tl_at_trans_lat_acc;
+	__u64 reg_tl_re_acc;
+	__u32 reg_tl_pci_trans_cnt;
+	__u32 reg_tl_rd_lat_max;
+	__u32 reg_tl_rd_cmpl_cnt;
+	__u32 reg_tl_gp_lat_max;
+	__u32 reg_tl_ae_put_cnt;
+	__u32 reg_tl_bw_in;
+	__u32 reg_tl_bw_out;
+	__u32 reg_tl_at_page_req_cnt;
+	__u32 reg_tl_at_trans_lat_cnt;
+	__u32 reg_tl_at_max_tlb_used;
+	__u32 reg_tl_re_cnt;
+	__u32 reserved;
+	struct adf_gen4_tl_slice_data_regs ath_slices[ADF_GEN4_TL_MAX_SLICES_PER_TYPE];
+	struct adf_gen4_tl_slice_data_regs cph_slices[ADF_GEN4_TL_MAX_SLICES_PER_TYPE];
+	struct adf_gen4_tl_slice_data_regs cpr_slices[ADF_GEN4_TL_MAX_SLICES_PER_TYPE];
+	struct adf_gen4_tl_slice_data_regs xlt_slices[ADF_GEN4_TL_MAX_SLICES_PER_TYPE];
+	struct adf_gen4_tl_slice_data_regs dcpr_slices[ADF_GEN4_TL_MAX_SLICES_PER_TYPE];
+	struct adf_gen4_tl_slice_data_regs pke_slices[ADF_GEN4_TL_MAX_SLICES_PER_TYPE];
+	struct adf_gen4_tl_slice_data_regs ucs_slices[ADF_GEN4_TL_MAX_SLICES_PER_TYPE];
+	struct adf_gen4_tl_slice_data_regs wat_slices[ADF_GEN4_TL_MAX_SLICES_PER_TYPE];
+	struct adf_gen4_tl_slice_data_regs wcp_slices[ADF_GEN4_TL_MAX_SLICES_PER_TYPE];
+};
+
+/**
+ * struct adf_gen4_tl_layout - This structure represents entire telemetry
+ * counters data: Device + 4 Ring Pairs as are being populated periodically
+ * by device.
+ * @tl_device_data_regs: structure of device telemetry registers
+ * @reserved1: reserved
+ * @reg_tl_msg_cnt: telemetry messages counter
+ * @reserved: reserved
+ */
+struct adf_gen4_tl_layout {
+	struct adf_gen4_tl_device_data_regs tl_device_data_regs;
+	__u32 reserved1[14];
+	__u32 reg_tl_msg_cnt;
+	__u32 reserved;
+};
+
+#define ADF_GEN4_TL_LAYOUT_SZ	sizeof(struct adf_gen4_tl_layout)
+#define ADF_GEN4_TL_MSG_CNT_OFF	offsetof(struct adf_gen4_tl_layout, reg_tl_msg_cnt)
+
+#ifdef CONFIG_DEBUG_FS
+void adf_gen4_init_tl_data(struct adf_tl_hw_data *tl_data);
+#else
+static inline void adf_gen4_init_tl_data(struct adf_tl_hw_data *tl_data)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+#endif /* ADF_GEN4_TL_H */
diff --git a/drivers/crypto/intel/qat/qat_common/adf_init.c b/drivers/crypto/intel/qat/qat_common/adf_init.c
index 81c39f3d07e1..f43ae9111553 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_init.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_init.c
@@ -11,6 +11,7 @@
 #include "adf_heartbeat.h"
 #include "adf_rl.h"
 #include "adf_sysfs_ras_counters.h"
+#include "adf_telemetry.h"
 
 static LIST_HEAD(service_table);
 static DEFINE_MUTEX(service_lock);
@@ -142,6 +143,10 @@ static int adf_dev_init(struct adf_accel_dev *accel_dev)
 	if (ret && ret != -EOPNOTSUPP)
 		return ret;
 
+	ret = adf_tl_init(accel_dev);
+	if (ret && ret != -EOPNOTSUPP)
+		return ret;
+
 	/*
 	 * Subservice initialisation is divided into two stages: init and start.
 	 * This is to facilitate any ordering dependencies between services
@@ -220,6 +225,10 @@ static int adf_dev_start(struct adf_accel_dev *accel_dev)
 	if (ret && ret != -EOPNOTSUPP)
 		return ret;
 
+	ret = adf_tl_start(accel_dev);
+	if (ret && ret != -EOPNOTSUPP)
+		return ret;
+
 	list_for_each_entry(service, &service_table, list) {
 		if (service->event_hld(accel_dev, ADF_EVENT_START)) {
 			dev_err(&GET_DEV(accel_dev),
@@ -279,6 +288,7 @@ static void adf_dev_stop(struct adf_accel_dev *accel_dev)
 	    !test_bit(ADF_STATUS_STARTING, &accel_dev->status))
 		return;
 
+	adf_tl_stop(accel_dev);
 	adf_rl_stop(accel_dev);
 	adf_dbgfs_rm(accel_dev);
 	adf_sysfs_stop_ras(accel_dev);
@@ -374,6 +384,8 @@ static void adf_dev_shutdown(struct adf_accel_dev *accel_dev)
 
 	adf_heartbeat_shutdown(accel_dev);
 
+	adf_tl_shutdown(accel_dev);
+
 	hw_data->disable_iov(accel_dev);
 
 	if (test_bit(ADF_STATUS_IRQ_ALLOCATED, &accel_dev->status)) {
diff --git a/drivers/crypto/intel/qat/qat_common/adf_telemetry.c b/drivers/crypto/intel/qat/qat_common/adf_telemetry.c
new file mode 100644
index 000000000000..05c476d58895
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_telemetry.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2023 Intel Corporation. */
+#define dev_fmt(fmt) "Telemetry: " fmt
+
+#include <asm/errno.h>
+#include <linux/atomic.h>
+#include <linux/device.h>
+#include <linux/dev_printk.h>
+#include <linux/dma-mapping.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/workqueue.h>
+
+#include "adf_admin.h"
+#include "adf_accel_devices.h"
+#include "adf_common_drv.h"
+#include "adf_telemetry.h"
+
+#define TL_IS_ZERO(input)	((input) == 0)
+
+static bool is_tl_supported(struct adf_accel_dev *accel_dev)
+{
+	u16 fw_caps =  GET_HW_DATA(accel_dev)->fw_capabilities;
+
+	return fw_caps & TL_CAPABILITY_BIT;
+}
+
+static int validate_tl_data(struct adf_tl_hw_data *tl_data)
+{
+	if (!tl_data->dev_counters ||
+	    TL_IS_ZERO(tl_data->num_dev_counters) ||
+	    !tl_data->sl_util_counters ||
+	    !tl_data->sl_exec_counters)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int adf_tl_alloc_mem(struct adf_accel_dev *accel_dev)
+{
+	struct adf_tl_hw_data *tl_data = &GET_TL_DATA(accel_dev);
+	struct device *dev = &GET_DEV(accel_dev);
+	size_t regs_sz = tl_data->layout_sz;
+	struct adf_telemetry *telemetry;
+	int node = dev_to_node(dev);
+	void *tl_data_regs;
+	unsigned int i;
+
+	telemetry = kzalloc_node(sizeof(*telemetry), GFP_KERNEL, node);
+	if (!telemetry)
+		return -ENOMEM;
+
+	telemetry->regs_hist_buff = kmalloc_array(tl_data->num_hbuff,
+						  sizeof(*telemetry->regs_hist_buff),
+						  GFP_KERNEL);
+	if (!telemetry->regs_hist_buff)
+		goto err_free_tl;
+
+	telemetry->regs_data = dma_alloc_coherent(dev, regs_sz,
+						  &telemetry->regs_data_p,
+						  GFP_KERNEL);
+	if (!telemetry->regs_data)
+		goto err_free_regs_hist_buff;
+
+	for (i = 0; i < tl_data->num_hbuff; i++) {
+		tl_data_regs = kzalloc_node(regs_sz, GFP_KERNEL, node);
+		if (!tl_data_regs)
+			goto err_free_dma;
+
+		telemetry->regs_hist_buff[i] = tl_data_regs;
+	}
+
+	accel_dev->telemetry = telemetry;
+
+	return 0;
+
+err_free_dma:
+	dma_free_coherent(dev, regs_sz, telemetry->regs_data,
+			  telemetry->regs_data_p);
+
+	while (i--)
+		kfree(telemetry->regs_hist_buff[i]);
+
+err_free_regs_hist_buff:
+	kfree(telemetry->regs_hist_buff);
+err_free_tl:
+	kfree(telemetry);
+
+	return -ENOMEM;
+}
+
+static void adf_tl_free_mem(struct adf_accel_dev *accel_dev)
+{
+	struct adf_tl_hw_data *tl_data = &GET_TL_DATA(accel_dev);
+	struct adf_telemetry *telemetry = accel_dev->telemetry;
+	struct device *dev = &GET_DEV(accel_dev);
+	size_t regs_sz = tl_data->layout_sz;
+	unsigned int i;
+
+	for (i = 0; i < tl_data->num_hbuff; i++)
+		kfree(telemetry->regs_hist_buff[i]);
+
+	dma_free_coherent(dev, regs_sz, telemetry->regs_data,
+			  telemetry->regs_data_p);
+
+	kfree(telemetry->regs_hist_buff);
+	kfree(telemetry);
+	accel_dev->telemetry = NULL;
+}
+
+static unsigned long get_next_timeout(void)
+{
+	return msecs_to_jiffies(ADF_TL_TIMER_INT_MS);
+}
+
+static void snapshot_regs(struct adf_telemetry *telemetry, size_t size)
+{
+	void *dst = telemetry->regs_hist_buff[telemetry->hb_num];
+	void *src = telemetry->regs_data;
+
+	memcpy(dst, src, size);
+}
+
+static void tl_work_handler(struct work_struct *work)
+{
+	struct delayed_work *delayed_work;
+	struct adf_telemetry *telemetry;
+	struct adf_tl_hw_data *tl_data;
+	u32 msg_cnt, old_msg_cnt;
+	size_t layout_sz;
+	u32 *regs_data;
+	size_t id;
+
+	delayed_work = to_delayed_work(work);
+	telemetry = container_of(delayed_work, struct adf_telemetry, work_ctx);
+	tl_data = &GET_TL_DATA(telemetry->accel_dev);
+	regs_data = telemetry->regs_data;
+
+	id = tl_data->msg_cnt_off / sizeof(*regs_data);
+	layout_sz = tl_data->layout_sz;
+
+	if (!atomic_read(&telemetry->state)) {
+		cancel_delayed_work_sync(&telemetry->work_ctx);
+		return;
+	}
+
+	msg_cnt = regs_data[id];
+	old_msg_cnt = msg_cnt;
+	if (msg_cnt == telemetry->msg_cnt)
+		goto out;
+
+	mutex_lock(&telemetry->regs_hist_lock);
+
+	snapshot_regs(telemetry, layout_sz);
+
+	/* Check if data changed while updating it */
+	msg_cnt = regs_data[id];
+	if (old_msg_cnt != msg_cnt)
+		snapshot_regs(telemetry, layout_sz);
+
+	telemetry->msg_cnt = msg_cnt;
+	telemetry->hb_num++;
+	telemetry->hb_num %= telemetry->hbuffs;
+
+	mutex_unlock(&telemetry->regs_hist_lock);
+
+out:
+	adf_misc_wq_queue_delayed_work(&telemetry->work_ctx, get_next_timeout());
+}
+
+int adf_tl_halt(struct adf_accel_dev *accel_dev)
+{
+	struct adf_telemetry *telemetry = accel_dev->telemetry;
+	struct device *dev = &GET_DEV(accel_dev);
+	int ret;
+
+	cancel_delayed_work_sync(&telemetry->work_ctx);
+	atomic_set(&telemetry->state, 0);
+
+	ret = adf_send_admin_tl_stop(accel_dev);
+	if (ret)
+		dev_err(dev, "failed to stop telemetry\n");
+
+	return ret;
+}
+
+int adf_tl_run(struct adf_accel_dev *accel_dev, int state)
+{
+	struct adf_tl_hw_data *tl_data = &GET_TL_DATA(accel_dev);
+	struct adf_telemetry *telemetry = accel_dev->telemetry;
+	struct device *dev = &GET_DEV(accel_dev);
+	size_t layout_sz = tl_data->layout_sz;
+	int ret;
+
+	ret = adf_send_admin_tl_start(accel_dev, telemetry->regs_data_p,
+				      layout_sz, NULL, &telemetry->slice_cnt);
+	if (ret) {
+		dev_err(dev, "failed to start telemetry\n");
+		return ret;
+	}
+
+	telemetry->hbuffs = state;
+	atomic_set(&telemetry->state, state);
+
+	adf_misc_wq_queue_delayed_work(&telemetry->work_ctx, get_next_timeout());
+
+	return 0;
+}
+
+int adf_tl_init(struct adf_accel_dev *accel_dev)
+{
+	struct adf_tl_hw_data *tl_data = &GET_TL_DATA(accel_dev);
+	struct device *dev = &GET_DEV(accel_dev);
+	struct adf_telemetry *telemetry;
+	int ret;
+
+	ret = validate_tl_data(tl_data);
+	if (ret)
+		return ret;
+
+	ret = adf_tl_alloc_mem(accel_dev);
+	if (ret) {
+		dev_err(dev, "failed to initialize: %d\n", ret);
+		return ret;
+	}
+
+	telemetry = accel_dev->telemetry;
+	telemetry->accel_dev = accel_dev;
+
+	mutex_init(&telemetry->wr_lock);
+	mutex_init(&telemetry->regs_hist_lock);
+	INIT_DELAYED_WORK(&telemetry->work_ctx, tl_work_handler);
+
+	return 0;
+}
+
+int adf_tl_start(struct adf_accel_dev *accel_dev)
+{
+	struct device *dev = &GET_DEV(accel_dev);
+
+	if (!accel_dev->telemetry)
+		return -EOPNOTSUPP;
+
+	if (!is_tl_supported(accel_dev)) {
+		dev_info(dev, "feature not supported by FW\n");
+		adf_tl_free_mem(accel_dev);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+void adf_tl_stop(struct adf_accel_dev *accel_dev)
+{
+	if (!accel_dev->telemetry)
+		return;
+
+	if (atomic_read(&accel_dev->telemetry->state))
+		adf_tl_halt(accel_dev);
+}
+
+void adf_tl_shutdown(struct adf_accel_dev *accel_dev)
+{
+	if (!accel_dev->telemetry)
+		return;
+
+	adf_tl_free_mem(accel_dev);
+}
diff --git a/drivers/crypto/intel/qat/qat_common/adf_telemetry.h b/drivers/crypto/intel/qat/qat_common/adf_telemetry.h
new file mode 100644
index 000000000000..08de17621467
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_telemetry.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2023 Intel Corporation. */
+#ifndef ADF_TELEMETRY_H
+#define ADF_TELEMETRY_H
+
+#include <linux/bits.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include "icp_qat_fw_init_admin.h"
+
+struct adf_accel_dev;
+struct adf_tl_dbg_counter;
+struct dentry;
+
+#define ADF_TL_SL_CNT_COUNT		\
+	(sizeof(struct icp_qat_fw_init_admin_slice_cnt) / sizeof(__u8))
+
+#define TL_CAPABILITY_BIT		BIT(1)
+/* Interval within device writes data to DMA region. Value in milliseconds. */
+#define ADF_TL_DATA_WR_INTERVAL_MS	1000
+/* Interval within timer interrupt should be handled. Value in milliseconds. */
+#define ADF_TL_TIMER_INT_MS		(ADF_TL_DATA_WR_INTERVAL_MS / 2)
+
+struct adf_tl_hw_data {
+	size_t layout_sz;
+	size_t slice_reg_sz;
+	size_t msg_cnt_off;
+	const struct adf_tl_dbg_counter *dev_counters;
+	const struct adf_tl_dbg_counter *sl_util_counters;
+	const struct adf_tl_dbg_counter *sl_exec_counters;
+	u8 num_hbuff;
+	u8 cpp_ns_per_cycle;
+	u8 bw_units_to_bytes;
+	u8 num_dev_counters;
+};
+
+struct adf_telemetry {
+	struct adf_accel_dev *accel_dev;
+	atomic_t state;
+	u32 hbuffs;
+	int hb_num;
+	u32 msg_cnt;
+	dma_addr_t regs_data_p; /* bus address for DMA mapping */
+	void *regs_data; /* virtual address for DMA mapping */
+	/**
+	 * @regs_hist_buff: array of pointers to copies of the last @hbuffs
+	 * values of @regs_data
+	 */
+	void **regs_hist_buff;
+	struct dentry *dbg_dir;
+	/**
+	 * @regs_hist_lock: protects from race conditions between write and read
+	 * to the copies referenced by @regs_hist_buff
+	 */
+	struct mutex regs_hist_lock;
+	/**
+	 * @wr_lock: protects from concurrent writes to debugfs telemetry files
+	 */
+	struct mutex wr_lock;
+	struct delayed_work work_ctx;
+	struct icp_qat_fw_init_admin_slice_cnt slice_cnt;
+};
+
+#ifdef CONFIG_DEBUG_FS
+int adf_tl_init(struct adf_accel_dev *accel_dev);
+int adf_tl_start(struct adf_accel_dev *accel_dev);
+void adf_tl_stop(struct adf_accel_dev *accel_dev);
+void adf_tl_shutdown(struct adf_accel_dev *accel_dev);
+int adf_tl_run(struct adf_accel_dev *accel_dev, int state);
+int adf_tl_halt(struct adf_accel_dev *accel_dev);
+#else
+static inline int adf_tl_init(struct adf_accel_dev *accel_dev)
+{
+	return 0;
+}
+
+static inline int adf_tl_start(struct adf_accel_dev *accel_dev)
+{
+	return 0;
+}
+
+static inline void adf_tl_stop(struct adf_accel_dev *accel_dev)
+{
+}
+
+static inline void adf_tl_shutdown(struct adf_accel_dev *accel_dev)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+#endif /* ADF_TELEMETRY_H */
diff --git a/drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.c b/drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.c
new file mode 100644
index 000000000000..accb46d6ea3c
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.c
@@ -0,0 +1,502 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2023 Intel Corporation. */
+#define dev_fmt(fmt) "Telemetry debugfs: " fmt
+
+#include <linux/atomic.h>
+#include <linux/debugfs.h>
+#include <linux/dev_printk.h>
+#include <linux/dcache.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/mutex.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/units.h>
+
+#include "adf_accel_devices.h"
+#include "adf_telemetry.h"
+#include "adf_tl_debugfs.h"
+
+#define TL_VALUE_MIN_PADDING	20
+#define TL_KEY_MIN_PADDING	23
+
+static int tl_collect_values_u32(struct adf_telemetry *telemetry,
+				 size_t counter_offset, u64 *arr)
+{
+	unsigned int samples, hb_idx, i;
+	u32 *regs_hist_buff;
+	u32 counter_val;
+
+	samples = min(telemetry->msg_cnt, telemetry->hbuffs);
+	hb_idx = telemetry->hb_num + telemetry->hbuffs - samples;
+
+	mutex_lock(&telemetry->regs_hist_lock);
+
+	for (i = 0; i < samples; i++) {
+		regs_hist_buff = telemetry->regs_hist_buff[hb_idx % telemetry->hbuffs];
+		counter_val = regs_hist_buff[counter_offset / sizeof(counter_val)];
+		arr[i] = counter_val;
+		hb_idx++;
+	}
+
+	mutex_unlock(&telemetry->regs_hist_lock);
+
+	return samples;
+}
+
+static int tl_collect_values_u64(struct adf_telemetry *telemetry,
+				 size_t counter_offset, u64 *arr)
+{
+	unsigned int samples, hb_idx, i;
+	u64 *regs_hist_buff;
+	u64 counter_val;
+
+	samples = min(telemetry->msg_cnt, telemetry->hbuffs);
+	hb_idx = telemetry->hb_num + telemetry->hbuffs - samples;
+
+	mutex_lock(&telemetry->regs_hist_lock);
+
+	for (i = 0; i < samples; i++) {
+		regs_hist_buff = telemetry->regs_hist_buff[hb_idx % telemetry->hbuffs];
+		counter_val = regs_hist_buff[counter_offset / sizeof(counter_val)];
+		arr[i] = counter_val;
+		hb_idx++;
+	}
+
+	mutex_unlock(&telemetry->regs_hist_lock);
+
+	return samples;
+}
+
+/**
+ * avg_array() - Return average of values within an array.
+ * @array: Array of values.
+ * @len: Number of elements.
+ *
+ * This algorithm computes average of an array without running into overflow.
+ *
+ * Return: average of values.
+ */
+#define avg_array(array, len) (				\
+{							\
+	typeof(&(array)[0]) _array = (array);		\
+	__unqual_scalar_typeof(_array[0]) _x = 0;	\
+	__unqual_scalar_typeof(_array[0]) _y = 0;	\
+	__unqual_scalar_typeof(_array[0]) _a, _b;	\
+	typeof(len) _len = (len);			\
+	size_t _i;					\
+							\
+	for (_i = 0; _i < _len; _i++) {			\
+		_a = _array[_i];			\
+		_b = do_div(_a, _len);			\
+		_x += _a;				\
+		if (_y >= _len - _b) {			\
+			_x++;				\
+			_y -= _len - _b;		\
+		} else {				\
+			_y += _b;			\
+		}					\
+	}						\
+	do_div(_y, _len);				\
+	(_x + _y);					\
+})
+
+/* Calculation function for simple counter. */
+static int tl_calc_count(struct adf_telemetry *telemetry,
+			 const struct adf_tl_dbg_counter *ctr,
+			 struct adf_tl_dbg_aggr_values *vals)
+{
+	struct adf_tl_hw_data *tl_data = &GET_TL_DATA(telemetry->accel_dev);
+	u64 *hist_vals;
+	int sample_cnt;
+	int ret = 0;
+
+	hist_vals = kmalloc_array(tl_data->num_hbuff, sizeof(*hist_vals),
+				  GFP_KERNEL);
+	if (!hist_vals)
+		return -ENOMEM;
+
+	memset(vals, 0, sizeof(*vals));
+	sample_cnt = tl_collect_values_u32(telemetry, ctr->offset1, hist_vals);
+	if (!sample_cnt)
+		goto out_free_hist_vals;
+
+	vals->curr = hist_vals[sample_cnt - 1];
+	vals->min = min_array(hist_vals, sample_cnt);
+	vals->max = max_array(hist_vals, sample_cnt);
+	vals->avg = avg_array(hist_vals, sample_cnt);
+
+out_free_hist_vals:
+	kfree(hist_vals);
+	return ret;
+}
+
+/* Convert CPP bus cycles to ns. */
+static int tl_cycles_to_ns(struct adf_telemetry *telemetry,
+			   const struct adf_tl_dbg_counter *ctr,
+			   struct adf_tl_dbg_aggr_values *vals)
+{
+	struct adf_tl_hw_data *tl_data = &GET_TL_DATA(telemetry->accel_dev);
+	u8 cpp_ns_per_cycle = tl_data->cpp_ns_per_cycle;
+	int ret;
+
+	ret = tl_calc_count(telemetry, ctr, vals);
+	if (ret)
+		return ret;
+
+	vals->curr *= cpp_ns_per_cycle;
+	vals->min *= cpp_ns_per_cycle;
+	vals->max *= cpp_ns_per_cycle;
+	vals->avg *= cpp_ns_per_cycle;
+
+	return 0;
+}
+
+/*
+ * Compute latency cumulative average with division of accumulated value
+ * by sample count. Returned value is in ns.
+ */
+static int tl_lat_acc_avg(struct adf_telemetry *telemetry,
+			  const struct adf_tl_dbg_counter *ctr,
+			  struct adf_tl_dbg_aggr_values *vals)
+{
+	struct adf_tl_hw_data *tl_data = &GET_TL_DATA(telemetry->accel_dev);
+	u8 cpp_ns_per_cycle = tl_data->cpp_ns_per_cycle;
+	u8 num_hbuff = tl_data->num_hbuff;
+	int sample_cnt, i;
+	u64 *hist_vals;
+	u64 *hist_cnt;
+	int ret = 0;
+
+	hist_vals = kmalloc_array(num_hbuff, sizeof(*hist_vals), GFP_KERNEL);
+	if (!hist_vals)
+		return -ENOMEM;
+
+	hist_cnt = kmalloc_array(num_hbuff, sizeof(*hist_cnt), GFP_KERNEL);
+	if (!hist_cnt) {
+		ret = -ENOMEM;
+		goto out_free_hist_vals;
+	}
+
+	memset(vals, 0, sizeof(*vals));
+	sample_cnt = tl_collect_values_u64(telemetry, ctr->offset1, hist_vals);
+	if (!sample_cnt)
+		goto out_free_hist_cnt;
+
+	tl_collect_values_u32(telemetry, ctr->offset2, hist_cnt);
+
+	for (i = 0; i < sample_cnt; i++) {
+		/* Avoid division by 0 if count is 0. */
+		if (hist_cnt[i])
+			hist_vals[i] = div_u64(hist_vals[i] * cpp_ns_per_cycle,
+					       hist_cnt[i]);
+		else
+			hist_vals[i] = 0;
+	}
+
+	vals->curr = hist_vals[sample_cnt - 1];
+	vals->min = min_array(hist_vals, sample_cnt);
+	vals->max = max_array(hist_vals, sample_cnt);
+	vals->avg = avg_array(hist_vals, sample_cnt);
+
+out_free_hist_cnt:
+	kfree(hist_cnt);
+out_free_hist_vals:
+	kfree(hist_vals);
+	return ret;
+}
+
+/* Convert HW raw bandwidth units to Mbps. */
+static int tl_bw_hw_units_to_mbps(struct adf_telemetry *telemetry,
+				  const struct adf_tl_dbg_counter *ctr,
+				  struct adf_tl_dbg_aggr_values *vals)
+{
+	struct adf_tl_hw_data *tl_data = &GET_TL_DATA(telemetry->accel_dev);
+	u16 bw_hw_2_bits = tl_data->bw_units_to_bytes * BITS_PER_BYTE;
+	u64 *hist_vals;
+	int sample_cnt;
+	int ret = 0;
+
+	hist_vals = kmalloc_array(tl_data->num_hbuff, sizeof(*hist_vals),
+				  GFP_KERNEL);
+	if (!hist_vals)
+		return -ENOMEM;
+
+	memset(vals, 0, sizeof(*vals));
+	sample_cnt = tl_collect_values_u32(telemetry, ctr->offset1, hist_vals);
+	if (!sample_cnt)
+		goto out_free_hist_vals;
+
+	vals->curr = div_u64(hist_vals[sample_cnt - 1] * bw_hw_2_bits, MEGA);
+	vals->min = div_u64(min_array(hist_vals, sample_cnt) * bw_hw_2_bits, MEGA);
+	vals->max = div_u64(max_array(hist_vals, sample_cnt) * bw_hw_2_bits, MEGA);
+	vals->avg = div_u64(avg_array(hist_vals, sample_cnt) * bw_hw_2_bits, MEGA);
+
+out_free_hist_vals:
+	kfree(hist_vals);
+	return ret;
+}
+
+static void tl_seq_printf_counter(struct adf_telemetry *telemetry,
+				  struct seq_file *s, const char *name,
+				  struct adf_tl_dbg_aggr_values *vals)
+{
+	seq_printf(s, "%-*s", TL_KEY_MIN_PADDING, name);
+	seq_printf(s, "%*llu", TL_VALUE_MIN_PADDING, vals->curr);
+	if (atomic_read(&telemetry->state) > 1) {
+		seq_printf(s, "%*llu", TL_VALUE_MIN_PADDING, vals->min);
+		seq_printf(s, "%*llu", TL_VALUE_MIN_PADDING, vals->max);
+		seq_printf(s, "%*llu", TL_VALUE_MIN_PADDING, vals->avg);
+	}
+	seq_puts(s, "\n");
+}
+
+static int tl_calc_and_print_counter(struct adf_telemetry *telemetry,
+				     struct seq_file *s,
+				     const struct adf_tl_dbg_counter *ctr,
+				     const char *name)
+{
+	const char *counter_name = name ? name : ctr->name;
+	enum adf_tl_counter_type type = ctr->type;
+	struct adf_tl_dbg_aggr_values vals;
+	int ret;
+
+	switch (type) {
+	case ADF_TL_SIMPLE_COUNT:
+		ret = tl_calc_count(telemetry, ctr, &vals);
+		break;
+	case ADF_TL_COUNTER_NS:
+		ret = tl_cycles_to_ns(telemetry, ctr, &vals);
+		break;
+	case ADF_TL_COUNTER_NS_AVG:
+		ret = tl_lat_acc_avg(telemetry, ctr, &vals);
+		break;
+	case ADF_TL_COUNTER_MBPS:
+		ret = tl_bw_hw_units_to_mbps(telemetry, ctr, &vals);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ret)
+		return ret;
+
+	tl_seq_printf_counter(telemetry, s, counter_name, &vals);
+
+	return 0;
+}
+
+static int tl_print_sl_counter(struct adf_telemetry *telemetry,
+			       const struct adf_tl_dbg_counter *ctr,
+			       struct seq_file *s, u8 cnt_id)
+{
+	size_t sl_regs_sz = GET_TL_DATA(telemetry->accel_dev).slice_reg_sz;
+	struct adf_tl_dbg_counter slice_ctr;
+	size_t offset_inc = cnt_id * sl_regs_sz;
+	char cnt_name[MAX_COUNT_NAME_SIZE];
+
+	snprintf(cnt_name, MAX_COUNT_NAME_SIZE, "%s%d", ctr->name, cnt_id);
+	slice_ctr = *ctr;
+	slice_ctr.offset1 += offset_inc;
+
+	return tl_calc_and_print_counter(telemetry, s, &slice_ctr, cnt_name);
+}
+
+static int tl_calc_and_print_sl_counters(struct adf_accel_dev *accel_dev,
+					 struct seq_file *s, u8 cnt_type, u8 cnt_id)
+{
+	struct adf_tl_hw_data *tl_data = &GET_TL_DATA(accel_dev);
+	struct adf_telemetry *telemetry = accel_dev->telemetry;
+	const struct adf_tl_dbg_counter *sl_tl_util_counters;
+	const struct adf_tl_dbg_counter *sl_tl_exec_counters;
+	const struct adf_tl_dbg_counter *ctr;
+	int ret;
+
+	sl_tl_util_counters = tl_data->sl_util_counters;
+	sl_tl_exec_counters = tl_data->sl_exec_counters;
+
+	ctr = &sl_tl_util_counters[cnt_type];
+
+	ret = tl_print_sl_counter(telemetry, ctr, s, cnt_id);
+	if (ret) {
+		dev_notice(&GET_DEV(accel_dev),
+			   "invalid slice utilization counter type\n");
+		return ret;
+	}
+
+	ctr = &sl_tl_exec_counters[cnt_type];
+
+	ret = tl_print_sl_counter(telemetry, ctr, s, cnt_id);
+	if (ret) {
+		dev_notice(&GET_DEV(accel_dev),
+			   "invalid slice execution counter type\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void tl_print_msg_cnt(struct seq_file *s, u32 msg_cnt)
+{
+	seq_printf(s, "%-*s", TL_KEY_MIN_PADDING, SNAPSHOT_CNT_MSG);
+	seq_printf(s, "%*u\n", TL_VALUE_MIN_PADDING, msg_cnt);
+}
+
+static int tl_print_dev_data(struct adf_accel_dev *accel_dev,
+			     struct seq_file *s)
+{
+	struct adf_tl_hw_data *tl_data = &GET_TL_DATA(accel_dev);
+	struct adf_telemetry *telemetry = accel_dev->telemetry;
+	const struct adf_tl_dbg_counter *dev_tl_counters;
+	u8 num_dev_counters = tl_data->num_dev_counters;
+	u8 *sl_cnt = (u8 *)&telemetry->slice_cnt;
+	const struct adf_tl_dbg_counter *ctr;
+	unsigned int i;
+	int ret;
+	u8 j;
+
+	if (!atomic_read(&telemetry->state)) {
+		dev_info(&GET_DEV(accel_dev), "not enabled\n");
+		return -EPERM;
+	}
+
+	dev_tl_counters = tl_data->dev_counters;
+
+	tl_print_msg_cnt(s, telemetry->msg_cnt);
+
+	/* Print device level telemetry. */
+	for (i = 0; i < num_dev_counters; i++) {
+		ctr = &dev_tl_counters[i];
+		ret = tl_calc_and_print_counter(telemetry, s, ctr, NULL);
+		if (ret) {
+			dev_notice(&GET_DEV(accel_dev),
+				   "invalid counter type\n");
+			return ret;
+		}
+	}
+
+	/* Print per slice telemetry. */
+	for (i = 0; i < ADF_TL_SL_CNT_COUNT; i++) {
+		for (j = 0; j < sl_cnt[i]; j++) {
+			ret = tl_calc_and_print_sl_counters(accel_dev, s, i, j);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int tl_dev_data_show(struct seq_file *s, void *unused)
+{
+	struct adf_accel_dev *accel_dev = s->private;
+
+	if (!accel_dev)
+		return -EINVAL;
+
+	return tl_print_dev_data(accel_dev, s);
+}
+DEFINE_SHOW_ATTRIBUTE(tl_dev_data);
+
+static int tl_control_show(struct seq_file *s, void *unused)
+{
+	struct adf_accel_dev *accel_dev = s->private;
+
+	if (!accel_dev)
+		return -EINVAL;
+
+	seq_printf(s, "%d\n", atomic_read(&accel_dev->telemetry->state));
+
+	return 0;
+}
+
+static ssize_t tl_control_write(struct file *file, const char __user *userbuf,
+				size_t count, loff_t *ppos)
+{
+	struct seq_file *seq_f = file->private_data;
+	struct adf_accel_dev *accel_dev;
+	struct adf_telemetry *telemetry;
+	struct adf_tl_hw_data *tl_data;
+	struct device *dev;
+	u32 input;
+	int ret;
+
+	accel_dev = seq_f->private;
+	if (!accel_dev)
+		return -EINVAL;
+
+	tl_data = &GET_TL_DATA(accel_dev);
+	telemetry = accel_dev->telemetry;
+	dev = &GET_DEV(accel_dev);
+
+	mutex_lock(&telemetry->wr_lock);
+
+	ret = kstrtou32_from_user(userbuf, count, 10, &input);
+	if (ret)
+		goto unlock_and_exit;
+
+	if (input > tl_data->num_hbuff) {
+		dev_info(dev, "invalid control input\n");
+		ret = -EINVAL;
+		goto unlock_and_exit;
+	}
+
+	/* If input is 0, just stop telemetry. */
+	if (!input) {
+		ret = adf_tl_halt(accel_dev);
+		if (!ret)
+			ret = count;
+
+		goto unlock_and_exit;
+	}
+
+	/* If TL is already enabled, stop it. */
+	if (atomic_read(&telemetry->state)) {
+		dev_info(dev, "already enabled, restarting.\n");
+		ret = adf_tl_halt(accel_dev);
+		if (ret)
+			goto unlock_and_exit;
+	}
+
+	ret = adf_tl_run(accel_dev, input);
+	if (ret)
+		goto unlock_and_exit;
+
+	ret = count;
+
+unlock_and_exit:
+	mutex_unlock(&telemetry->wr_lock);
+	return ret;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(tl_control);
+
+void adf_tl_dbgfs_add(struct adf_accel_dev *accel_dev)
+{
+	struct adf_telemetry *telemetry = accel_dev->telemetry;
+	struct dentry *parent = accel_dev->debugfs_dir;
+	struct dentry *dir;
+
+	if (!telemetry)
+		return;
+
+	dir = debugfs_create_dir("telemetry", parent);
+	accel_dev->telemetry->dbg_dir = dir;
+	debugfs_create_file("device_data", 0444, dir, accel_dev, &tl_dev_data_fops);
+	debugfs_create_file("control", 0644, dir, accel_dev, &tl_control_fops);
+}
+
+void adf_tl_dbgfs_rm(struct adf_accel_dev *accel_dev)
+{
+	struct adf_telemetry *telemetry = accel_dev->telemetry;
+	struct dentry *dbg_dir;
+
+	if (!telemetry)
+		return;
+
+	dbg_dir = telemetry->dbg_dir;
+
+	debugfs_remove_recursive(dbg_dir);
+
+	if (atomic_read(&telemetry->state))
+		adf_tl_halt(accel_dev);
+}
diff --git a/drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.h b/drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.h
new file mode 100644
index 000000000000..b2e8f1912c16
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2023 Intel Corporation. */
+#ifndef ADF_TL_DEBUGFS_H
+#define ADF_TL_DEBUGFS_H
+
+#include <linux/types.h>
+
+struct adf_accel_dev;
+
+#define MAX_COUNT_NAME_SIZE	32
+#define SNAPSHOT_CNT_MSG	"sample_cnt"
+#define RP_NUM_INDEX		"rp_num"
+#define PCI_TRANS_CNT_NAME	"pci_trans_cnt"
+#define MAX_RD_LAT_NAME		"max_rd_lat"
+#define RD_LAT_ACC_NAME		"rd_lat_acc_avg"
+#define MAX_LAT_NAME		"max_gp_lat"
+#define LAT_ACC_NAME		"gp_lat_acc_avg"
+#define BW_IN_NAME		"bw_in"
+#define BW_OUT_NAME		"bw_out"
+#define PAGE_REQ_LAT_NAME	"at_page_req_lat_avg"
+#define AT_TRANS_LAT_NAME	"at_trans_lat_avg"
+#define AT_MAX_UTLB_USED_NAME	"at_max_tlb_used"
+#define AT_GLOB_DTLB_HIT_NAME	"at_glob_devtlb_hit"
+#define AT_GLOB_DTLB_MISS_NAME	"at_glob_devtlb_miss"
+#define AT_PAYLD_DTLB_HIT_NAME	"tl_at_payld_devtlb_hit"
+#define AT_PAYLD_DTLB_MISS_NAME	"tl_at_payld_devtlb_miss"
+
+#define ADF_TL_DATA_REG_OFF(reg, qat_gen)	\
+	offsetof(struct adf_##qat_gen##_tl_layout, reg)
+
+#define ADF_TL_DEV_REG_OFF(reg, qat_gen)			\
+	(ADF_TL_DATA_REG_OFF(tl_device_data_regs, qat_gen) +	\
+	offsetof(struct adf_##qat_gen##_tl_device_data_regs, reg))
+
+#define ADF_TL_SLICE_REG_OFF(slice, reg, qat_gen)		\
+	(ADF_TL_DEV_REG_OFF(slice##_slices[0], qat_gen) +	\
+	offsetof(struct adf_##qat_gen##_tl_slice_data_regs, reg))
+
+/**
+ * enum adf_tl_counter_type - telemetry counter types
+ * @ADF_TL_COUNTER_UNSUPPORTED: unsupported counter
+ * @ADF_TL_SIMPLE_COUNT: simple counter
+ * @ADF_TL_COUNTER_NS: latency counter, value in ns
+ * @ADF_TL_COUNTER_NS_AVG: accumulated average latency counter, value in ns
+ * @ADF_TL_COUNTER_MBPS: bandwidth, value in MBps
+ */
+enum adf_tl_counter_type {
+	ADF_TL_COUNTER_UNSUPPORTED,
+	ADF_TL_SIMPLE_COUNT,
+	ADF_TL_COUNTER_NS,
+	ADF_TL_COUNTER_NS_AVG,
+	ADF_TL_COUNTER_MBPS,
+};
+
+/**
+ * struct adf_tl_dbg_counter - telemetry counter definition
+ * @name: name of the counter as printed in the report
+ * @adf_tl_counter_type: type of the counter
+ * @offset1: offset of 1st register
+ * @offset2: offset of 2nd optional register
+ */
+struct adf_tl_dbg_counter {
+	const char *name;
+	enum adf_tl_counter_type type;
+	size_t offset1;
+	size_t offset2;
+};
+
+#define ADF_TL_COUNTER(_name, _type, _offset)	\
+{	.name =		_name,			\
+	.type =		_type,			\
+	.offset1 =	_offset			\
+}
+
+#define ADF_TL_COUNTER_LATENCY(_name, _type, _offset1, _offset2)	\
+{	.name =		_name,						\
+	.type =		_type,						\
+	.offset1 =	_offset1,					\
+	.offset2 =	_offset2					\
+}
+
+/* Telemetry counter aggregated values. */
+struct adf_tl_dbg_aggr_values {
+	u64 curr;
+	u64 min;
+	u64 max;
+	u64 avg;
+};
+
+/**
+ * adf_tl_dbgfs_add() - Add telemetry's debug fs entries.
+ * @accel_dev: Pointer to acceleration device.
+ *
+ * Creates telemetry's debug fs folder and attributes in QAT debug fs root.
+ */
+void adf_tl_dbgfs_add(struct adf_accel_dev *accel_dev);
+
+/**
+ * adf_tl_dbgfs_rm() - Remove telemetry's debug fs entries.
+ * @accel_dev: Pointer to acceleration device.
+ *
+ * Removes telemetry's debug fs folder and attributes from QAT debug fs root.
+ */
+void adf_tl_dbgfs_rm(struct adf_accel_dev *accel_dev);
+
+#endif /* ADF_TL_DEBUGFS_H */
-- 
2.41.0



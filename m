Return-Path: <linux-crypto+bounces-975-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A76481C840
	for <lists+linux-crypto@lfdr.de>; Fri, 22 Dec 2023 11:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADE381C224DD
	for <lists+linux-crypto@lfdr.de>; Fri, 22 Dec 2023 10:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD63312E6A;
	Fri, 22 Dec 2023 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YdFg9GE4"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749EF12B65
	for <linux-crypto@vger.kernel.org>; Fri, 22 Dec 2023 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703241503; x=1734777503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j0P159qq/L7HfvaD9ZYmcwBlnINVOrqkJN2dvg2Nwng=;
  b=YdFg9GE49Z1puXSMkyvBzX1RZ0hdUWAAlnhrHqKS2HxAtKA8As3axbSw
   IeoNZgj2Dd40xntZU1nE4MmSMDC3g6sZa7/VdEktFGO2phnMWY7btGoRo
   tG2H22hXD9gxuXEjX37RJ5ibiKrJY3AgpGj3NN3NF1erqDzyLY6bz2dB7
   IeN3i5WRoR/ZDuPxxe2ZN+7Xu+Qac/OM2rqK0jXsCXqsfcU7+zdVT5qnC
   0RBv2/GPb1gCJEax61nqneHA0GMyL9TztKhfvOdCfO5dG7NvUxv7F1VZj
   8Cdqg1I4B3x2zA6kvLzWshq7jfKiwo5p6W0yyRPWN823UVfyQ+vuudci/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="2948202"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="2948202"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 02:38:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="726742892"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="726742892"
Received: from r007s007_zp31l10c01.deacluster.intel.com (HELO fedora.deacluster.intel.com) ([10.219.171.169])
  by orsmga003.jf.intel.com with ESMTP; 22 Dec 2023 02:38:21 -0800
From: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
To: herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org,
	qat-linux@intel.com,
	Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Damian Muszynski <damian.muszynski@intel.com>
Subject: [PATCH v2 4/4] crypto: qat - add support for ring pair level telemetry
Date: Fri, 22 Dec 2023 11:35:08 +0100
Message-ID: <20231222103508.1037442-5-lucas.segarra.fernandez@intel.com>
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

Expose through debugfs ring pair telemetry data for QAT GEN4 devices.

This allows to gather metrics about the PCIe channel and device TLB for
a selected ring pair. It is possible to monitor maximum 4 ring pairs at
the time per device.

For details, refer to debugfs-driver-qat_telemetry in Documentation/ABI.

This patch is based on earlier work done by Wojciech Ziemba.

Signed-off-by: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Damian Muszynski <damian.muszynski@intel.com>
---
 .../ABI/testing/debugfs-driver-qat_telemetry  | 125 +++++++++++
 .../intel/qat/qat_420xx/adf_420xx_hw_data.c   |   1 +
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     |   1 +
 .../intel/qat/qat_common/adf_accel_devices.h  |   1 +
 .../intel/qat/qat_common/adf_gen4_hw_data.h   |   1 +
 .../crypto/intel/qat/qat_common/adf_gen4_tl.c |  35 +++
 .../crypto/intel/qat/qat_common/adf_gen4_tl.h |  41 +++-
 .../intel/qat/qat_common/adf_telemetry.c      |  23 +-
 .../intel/qat/qat_common/adf_telemetry.h      |   7 +
 .../intel/qat/qat_common/adf_tl_debugfs.c     | 208 ++++++++++++++++++
 .../intel/qat/qat_common/adf_tl_debugfs.h     |  11 +
 11 files changed, 449 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-driver-qat_telemetry b/Documentation/ABI/testing/debugfs-driver-qat_telemetry
index 24532365387c..eacee2072088 100644
--- a/Documentation/ABI/testing/debugfs-driver-qat_telemetry
+++ b/Documentation/ABI/testing/debugfs-driver-qat_telemetry
@@ -101,3 +101,128 @@ Description:	(RO) Reports device telemetry counters.
 		attribute is not reported.
 
 		This attribute is only available for qat_4xxx devices.
+
+What:		/sys/kernel/debug/qat_<device>_<BDF>/telemetry/rp_<A/B/C/D>_data
+Date:		March 2024
+KernelVersion:	6.8
+Contact:	qat-linux@intel.com
+Description:	(RW) Selects up to 4 Ring Pairs (RP) to monitor, one per file,
+		and report telemetry counters related to each.
+
+		Allowed values to write:
+		========================
+		* 0 to ``<num_rps - 1>``:
+		  Ring pair to be monitored. The value of ``num_rps`` can be
+		  retrieved through ``/sys/bus/pci/devices/<BDF>/qat/num_rps``.
+		  See Documentation/ABI/testing/sysfs-driver-qat.
+
+		Reads report metrics about performance and utilization of
+		the selected RP:
+
+		=======================	========================================
+		Field			Description
+		=======================	========================================
+		sample_cnt		number of acquisitions of telemetry data
+					from the device. Reads are performed
+					every 1000 ms
+		rp_num			RP number associated with slot <A/B/C/D>
+		service_type		service associated to the RP
+		pci_trans_cnt		number of PCIe partial transactions
+		gp_lat_acc_avg		average get to put latency [ns]
+		bw_in			PCIe, write bandwidth [Mbps]
+		bw_out			PCIe, read bandwidth [Mbps]
+		at_glob_devtlb_hit	Message descriptor DevTLB hit rate
+		at_glob_devtlb_miss	Message descriptor DevTLB miss rate
+		tl_at_payld_devtlb_hit	Payload DevTLB hit rate
+		tl_at_payld_devtlb_miss	Payload DevTLB miss rate
+		======================= ========================================
+
+		Example.
+
+		Writing the value '32' to the file ``rp_C_data`` starts the
+		collection of telemetry metrics for ring pair 32::
+
+		  echo 32 > /sys/kernel/debug/qat_4xxx_0000:6b:00.0/telemetry/rp_C_data
+
+		Once a ring pair is selected, statistics can be read accessing
+		the file::
+
+		  cat /sys/kernel/debug/qat_4xxx_0000:6b:00.0/telemetry/rp_C_data
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
+
+		On QAT GEN4 devices there are 64 RPs on a PF, so the allowed
+		values are 0..63. This number is absolute to the device.
+		If Virtual Functions (VF) are used, the ring pair number can
+		be derived from the Bus, Device, Function of the VF:
+
+		============ ====== ====== ====== ======
+		PCI BDF/VF   RP0    RP1    RP2    RP3
+		============ ====== ====== ====== ======
+		0000:6b:0.1  RP  0  RP  1  RP  2  RP  3
+		0000:6b:0.2  RP  4  RP  5  RP  6  RP  7
+		0000:6b:0.3  RP  8  RP  9  RP 10  RP 11
+		0000:6b:0.4  RP 12  RP 13  RP 14  RP 15
+		0000:6b:0.5  RP 16  RP 17  RP 18  RP 19
+		0000:6b:0.6  RP 20  RP 21  RP 22  RP 23
+		0000:6b:0.7  RP 24  RP 25  RP 26  RP 27
+		0000:6b:1.0  RP 28  RP 29  RP 30  RP 31
+		0000:6b:1.1  RP 32  RP 33  RP 34  RP 35
+		0000:6b:1.2  RP 36  RP 37  RP 38  RP 39
+		0000:6b:1.3  RP 40  RP 41  RP 42  RP 43
+		0000:6b:1.4  RP 44  RP 45  RP 46  RP 47
+		0000:6b:1.5  RP 48  RP 49  RP 50  RP 51
+		0000:6b:1.6  RP 52  RP 53  RP 54  RP 55
+		0000:6b:1.7  RP 56  RP 57  RP 58  RP 59
+		0000:6b:2.0  RP 60  RP 61  RP 62  RP 63
+		============ ====== ====== ====== ======
+
+		The mapping is only valid for the BDFs of VFs on the host.
+
+
+		The service provided on a ring-pair varies depending on the
+		configuration. The configuration for a given device can be
+		queried and set using ``cfg_services``.
+		See Documentation/ABI/testing/sysfs-driver-qat for details.
+
+		The following table reports how ring pairs are mapped to VFs
+		on the PF 0000:6b:0.0 configured for `sym;asym` or `asym;sym`:
+
+		=========== ============ =========== ============ ===========
+		PCI BDF/VF  RP0/service  RP1/service RP2/service  RP3/service
+		=========== ============ =========== ============ ===========
+		0000:6b:0.1 RP 0 asym    RP 1 sym    RP 2 asym    RP 3 sym
+		0000:6b:0.2 RP 4 asym    RP 5 sym    RP 6 asym    RP 7 sym
+		0000:6b:0.3 RP 8 asym    RP 9 sym    RP10 asym    RP11 sym
+		...         ...          ...         ...          ...
+		=========== ============ =========== ============ ===========
+
+		All VFs follow the same pattern.
+
+
+		The following table reports how ring pairs are mapped to VFs on
+		the PF 0000:6b:0.0 configured for `dc`:
+
+		=========== ============ =========== ============ ===========
+		PCI BDF/VF  RP0/service  RP1/service RP2/service  RP3/service
+		=========== ============ =========== ============ ===========
+		0000:6b:0.1 RP 0 dc      RP 1 dc     RP 2 dc      RP 3 dc
+		0000:6b:0.2 RP 4 dc      RP 5 dc     RP 6 dc      RP 7 dc
+		0000:6b:0.3 RP 8 dc      RP 9 dc     RP10 dc      RP11 dc
+		...         ...          ...         ...          ...
+		=========== ============ =========== ============ ===========
+
+		The mapping of a RP to a service can be retrieved using
+		``rp2srv`` from sysfs.
+		See Documentation/ABI/testing/sysfs-driver-qat for details.
+
+		This attribute is only available for qat_4xxx devices.
diff --git a/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
index a7730d8057d6..5edce27db864 100644
--- a/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
@@ -520,6 +520,7 @@ void adf_init_hw_data_420xx(struct adf_hw_device_data *hw_data, u32 dev_id)
 	hw_data->init_device = adf_gen4_init_device;
 	hw_data->reset_device = adf_reset_flr;
 	hw_data->admin_ae_mask = ADF_420XX_ADMIN_AE_MASK;
+	hw_data->num_rps = ADF_GEN4_MAX_RPS;
 	hw_data->fw_name = ADF_420XX_FW;
 	hw_data->fw_mmp_name = ADF_420XX_MMP;
 	hw_data->uof_get_name = uof_get_name_420xx;
diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
index 73001b20cbfd..558caefd71b9 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -421,6 +421,7 @@ void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data, u32 dev_id)
 	hw_data->init_device = adf_gen4_init_device;
 	hw_data->reset_device = adf_reset_flr;
 	hw_data->admin_ae_mask = ADF_4XXX_ADMIN_AE_MASK;
+	hw_data->num_rps = ADF_GEN4_MAX_RPS;
 	switch (dev_id) {
 	case ADF_402XX_PCI_DEVICE_ID:
 		hw_data->fw_name = ADF_402XX_FW;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
index b274ebc799c9..db671879b1f8 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
@@ -278,6 +278,7 @@ struct adf_hw_device_data {
 	u8 num_logical_accel;
 	u8 num_engines;
 	u32 num_hb_ctrs;
+	u8 num_rps;
 };
 
 /* CSR write macro */
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
index 051ad20581a6..46a782ba456f 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
@@ -36,6 +36,7 @@
 #define ADF_GEN4_MSIX_RTTABLE_OFFSET(i)		(0x409000 + ((i) * 0x04))
 
 /* Bank and ring configuration */
+#define ADF_GEN4_MAX_RPS		64
 #define ADF_GEN4_NUM_RINGS_PER_BANK	2
 #define ADF_GEN4_NUM_BANKS_PER_VF	4
 #define ADF_GEN4_ETR_MAX_BANKS		64
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_tl.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_tl.c
index 4efbe6bc651c..7fc7a77f6aed 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_tl.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_tl.c
@@ -9,6 +9,8 @@
 
 #define ADF_GEN4_TL_DEV_REG_OFF(reg) ADF_TL_DEV_REG_OFF(reg, gen4)
 
+#define ADF_GEN4_TL_RP_REG_OFF(reg) ADF_TL_RP_REG_OFF(reg, gen4)
+
 #define ADF_GEN4_TL_SL_UTIL_COUNTER(_name)	\
 	ADF_TL_COUNTER("util_" #_name,		\
 			ADF_TL_SIMPLE_COUNT,	\
@@ -101,11 +103,42 @@ static const struct adf_tl_dbg_counter sl_exec_counters[ADF_TL_SL_CNT_COUNT] = {
 	ADF_GEN4_TL_SL_EXEC_COUNTER(ath),
 };
 
+/* Ring pair counters. */
+static const struct adf_tl_dbg_counter rp_counters[] = {
+	/* PCIe partial transactions. */
+	ADF_TL_COUNTER(PCI_TRANS_CNT_NAME, ADF_TL_SIMPLE_COUNT,
+		       ADF_GEN4_TL_RP_REG_OFF(reg_tl_pci_trans_cnt)),
+	/* Get to put latency average[ns]. */
+	ADF_TL_COUNTER_LATENCY(LAT_ACC_NAME, ADF_TL_COUNTER_NS_AVG,
+			       ADF_GEN4_TL_RP_REG_OFF(reg_tl_gp_lat_acc),
+			       ADF_GEN4_TL_RP_REG_OFF(reg_tl_ae_put_cnt)),
+	/* PCIe write bandwidth[Mbps]. */
+	ADF_TL_COUNTER(BW_IN_NAME, ADF_TL_COUNTER_MBPS,
+		       ADF_GEN4_TL_RP_REG_OFF(reg_tl_bw_in)),
+	/* PCIe read bandwidth[Mbps]. */
+	ADF_TL_COUNTER(BW_OUT_NAME, ADF_TL_COUNTER_MBPS,
+		       ADF_GEN4_TL_RP_REG_OFF(reg_tl_bw_out)),
+	/* Message descriptor DevTLB hit rate. */
+	ADF_TL_COUNTER(AT_GLOB_DTLB_HIT_NAME, ADF_TL_SIMPLE_COUNT,
+		       ADF_GEN4_TL_RP_REG_OFF(reg_tl_at_glob_devtlb_hit)),
+	/* Message descriptor DevTLB miss rate. */
+	ADF_TL_COUNTER(AT_GLOB_DTLB_MISS_NAME, ADF_TL_SIMPLE_COUNT,
+		       ADF_GEN4_TL_RP_REG_OFF(reg_tl_at_glob_devtlb_miss)),
+	/* Payload DevTLB hit rate. */
+	ADF_TL_COUNTER(AT_PAYLD_DTLB_HIT_NAME, ADF_TL_SIMPLE_COUNT,
+		       ADF_GEN4_TL_RP_REG_OFF(reg_tl_at_payld_devtlb_hit)),
+	/* Payload DevTLB miss rate. */
+	ADF_TL_COUNTER(AT_PAYLD_DTLB_MISS_NAME, ADF_TL_SIMPLE_COUNT,
+		       ADF_GEN4_TL_RP_REG_OFF(reg_tl_at_payld_devtlb_miss)),
+};
+
 void adf_gen4_init_tl_data(struct adf_tl_hw_data *tl_data)
 {
 	tl_data->layout_sz = ADF_GEN4_TL_LAYOUT_SZ;
 	tl_data->slice_reg_sz = ADF_GEN4_TL_SLICE_REG_SZ;
+	tl_data->rp_reg_sz = ADF_GEN4_TL_RP_REG_SZ;
 	tl_data->num_hbuff = ADF_GEN4_TL_NUM_HIST_BUFFS;
+	tl_data->max_rp = ADF_GEN4_TL_MAX_RP_NUM;
 	tl_data->msg_cnt_off = ADF_GEN4_TL_MSG_CNT_OFF;
 	tl_data->cpp_ns_per_cycle = ADF_GEN4_CPP_NS_PER_CYCLE;
 	tl_data->bw_units_to_bytes = ADF_GEN4_TL_BW_HW_UNITS_TO_BYTES;
@@ -114,5 +147,7 @@ void adf_gen4_init_tl_data(struct adf_tl_hw_data *tl_data)
 	tl_data->num_dev_counters = ARRAY_SIZE(dev_counters);
 	tl_data->sl_util_counters = sl_util_counters;
 	tl_data->sl_exec_counters = sl_exec_counters;
+	tl_data->rp_counters = rp_counters;
+	tl_data->num_rp_counters = ARRAY_SIZE(rp_counters);
 }
 EXPORT_SYMBOL_GPL(adf_gen4_init_tl_data);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_tl.h b/drivers/crypto/intel/qat/qat_common/adf_gen4_tl.h
index feb2eecf24cf..32df4163beb9 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_tl.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_tl.h
@@ -21,6 +21,9 @@ struct adf_tl_hw_data;
 /* Max number of HW resources of one type. */
 #define ADF_GEN4_TL_MAX_SLICES_PER_TYPE		24
 
+/* Max number of simultaneously monitored ring pairs. */
+#define ADF_GEN4_TL_MAX_RP_NUM			4
+
 /**
  * struct adf_gen4_tl_slice_data_regs - HW slice data as populated by FW.
  * @reg_tm_slice_exec_cnt: Slice execution count.
@@ -92,18 +95,52 @@ struct adf_gen4_tl_device_data_regs {
 	struct adf_gen4_tl_slice_data_regs wcp_slices[ADF_GEN4_TL_MAX_SLICES_PER_TYPE];
 };
 
+/**
+ * struct adf_gen4_tl_ring_pair_data_regs - This structure stores Ring Pair
+ * telemetry counter values as are being populated periodically by device.
+ * @reg_tl_gp_lat_acc: get-put latency accumulator
+ * @reserved: reserved
+ * @reg_tl_pci_trans_cnt: PCIe partial transactions
+ * @reg_tl_ae_put_cnt: Accelerator Engine put counts across all rings
+ * @reg_tl_bw_in: PCIe write bandwidth
+ * @reg_tl_bw_out: PCIe read bandwidth
+ * @reg_tl_at_glob_devtlb_hit: Message descriptor DevTLB hit rate
+ * @reg_tl_at_glob_devtlb_miss: Message descriptor DevTLB miss rate
+ * @reg_tl_at_payld_devtlb_hit: Payload DevTLB hit rate
+ * @reg_tl_at_payld_devtlb_miss: Payload DevTLB miss rate
+ * @reg_tl_re_cnt: ring empty time samples count
+ * @reserved1: reserved
+ */
+struct adf_gen4_tl_ring_pair_data_regs {
+	__u64 reg_tl_gp_lat_acc;
+	__u64 reserved;
+	__u32 reg_tl_pci_trans_cnt;
+	__u32 reg_tl_ae_put_cnt;
+	__u32 reg_tl_bw_in;
+	__u32 reg_tl_bw_out;
+	__u32 reg_tl_at_glob_devtlb_hit;
+	__u32 reg_tl_at_glob_devtlb_miss;
+	__u32 reg_tl_at_payld_devtlb_hit;
+	__u32 reg_tl_at_payld_devtlb_miss;
+	__u32 reg_tl_re_cnt;
+	__u32 reserved1;
+};
+
+#define ADF_GEN4_TL_RP_REG_SZ sizeof(struct adf_gen4_tl_ring_pair_data_regs)
+
 /**
  * struct adf_gen4_tl_layout - This structure represents entire telemetry
  * counters data: Device + 4 Ring Pairs as are being populated periodically
  * by device.
  * @tl_device_data_regs: structure of device telemetry registers
- * @reserved1: reserved
+ * @tl_ring_pairs_data_regs: array of ring pairs telemetry registers
  * @reg_tl_msg_cnt: telemetry messages counter
  * @reserved: reserved
  */
 struct adf_gen4_tl_layout {
 	struct adf_gen4_tl_device_data_regs tl_device_data_regs;
-	__u32 reserved1[14];
+	struct adf_gen4_tl_ring_pair_data_regs
+			tl_ring_pairs_data_regs[ADF_GEN4_TL_MAX_RP_NUM];
 	__u32 reg_tl_msg_cnt;
 	__u32 reserved;
 };
diff --git a/drivers/crypto/intel/qat/qat_common/adf_telemetry.c b/drivers/crypto/intel/qat/qat_common/adf_telemetry.c
index 05c476d58895..2ff714d11bd2 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_telemetry.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_telemetry.c
@@ -33,7 +33,9 @@ static int validate_tl_data(struct adf_tl_hw_data *tl_data)
 	if (!tl_data->dev_counters ||
 	    TL_IS_ZERO(tl_data->num_dev_counters) ||
 	    !tl_data->sl_util_counters ||
-	    !tl_data->sl_exec_counters)
+	    !tl_data->sl_exec_counters ||
+	    !tl_data->rp_counters ||
+	    TL_IS_ZERO(tl_data->num_rp_counters))
 		return -EOPNOTSUPP;
 
 	return 0;
@@ -53,11 +55,17 @@ static int adf_tl_alloc_mem(struct adf_accel_dev *accel_dev)
 	if (!telemetry)
 		return -ENOMEM;
 
+	telemetry->rp_num_indexes = kmalloc_array(tl_data->max_rp,
+						  sizeof(*telemetry->rp_num_indexes),
+						  GFP_KERNEL);
+	if (!telemetry->rp_num_indexes)
+		goto err_free_tl;
+
 	telemetry->regs_hist_buff = kmalloc_array(tl_data->num_hbuff,
 						  sizeof(*telemetry->regs_hist_buff),
 						  GFP_KERNEL);
 	if (!telemetry->regs_hist_buff)
-		goto err_free_tl;
+		goto err_free_rp_indexes;
 
 	telemetry->regs_data = dma_alloc_coherent(dev, regs_sz,
 						  &telemetry->regs_data_p,
@@ -86,6 +94,8 @@ static int adf_tl_alloc_mem(struct adf_accel_dev *accel_dev)
 
 err_free_regs_hist_buff:
 	kfree(telemetry->regs_hist_buff);
+err_free_rp_indexes:
+	kfree(telemetry->rp_num_indexes);
 err_free_tl:
 	kfree(telemetry);
 
@@ -107,6 +117,7 @@ static void adf_tl_free_mem(struct adf_accel_dev *accel_dev)
 			  telemetry->regs_data_p);
 
 	kfree(telemetry->regs_hist_buff);
+	kfree(telemetry->rp_num_indexes);
 	kfree(telemetry);
 	accel_dev->telemetry = NULL;
 }
@@ -196,7 +207,8 @@ int adf_tl_run(struct adf_accel_dev *accel_dev, int state)
 	int ret;
 
 	ret = adf_send_admin_tl_start(accel_dev, telemetry->regs_data_p,
-				      layout_sz, NULL, &telemetry->slice_cnt);
+				      layout_sz, telemetry->rp_num_indexes,
+				      &telemetry->slice_cnt);
 	if (ret) {
 		dev_err(dev, "failed to start telemetry\n");
 		return ret;
@@ -213,8 +225,10 @@ int adf_tl_run(struct adf_accel_dev *accel_dev, int state)
 int adf_tl_init(struct adf_accel_dev *accel_dev)
 {
 	struct adf_tl_hw_data *tl_data = &GET_TL_DATA(accel_dev);
+	u8 max_rp = GET_TL_DATA(accel_dev).max_rp;
 	struct device *dev = &GET_DEV(accel_dev);
 	struct adf_telemetry *telemetry;
+	unsigned int i;
 	int ret;
 
 	ret = validate_tl_data(tl_data);
@@ -234,6 +248,9 @@ int adf_tl_init(struct adf_accel_dev *accel_dev)
 	mutex_init(&telemetry->regs_hist_lock);
 	INIT_DELAYED_WORK(&telemetry->work_ctx, tl_work_handler);
 
+	for (i = 0; i < max_rp; i++)
+		telemetry->rp_num_indexes[i] = ADF_TL_RP_REGS_DISABLED;
+
 	return 0;
 }
 
diff --git a/drivers/crypto/intel/qat/qat_common/adf_telemetry.h b/drivers/crypto/intel/qat/qat_common/adf_telemetry.h
index 08de17621467..9be81cd3b886 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_telemetry.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_telemetry.h
@@ -23,17 +23,23 @@ struct dentry;
 /* Interval within timer interrupt should be handled. Value in milliseconds. */
 #define ADF_TL_TIMER_INT_MS		(ADF_TL_DATA_WR_INTERVAL_MS / 2)
 
+#define ADF_TL_RP_REGS_DISABLED		(0xff)
+
 struct adf_tl_hw_data {
 	size_t layout_sz;
 	size_t slice_reg_sz;
+	size_t rp_reg_sz;
 	size_t msg_cnt_off;
 	const struct adf_tl_dbg_counter *dev_counters;
 	const struct adf_tl_dbg_counter *sl_util_counters;
 	const struct adf_tl_dbg_counter *sl_exec_counters;
+	const struct adf_tl_dbg_counter *rp_counters;
 	u8 num_hbuff;
 	u8 cpp_ns_per_cycle;
 	u8 bw_units_to_bytes;
 	u8 num_dev_counters;
+	u8 num_rp_counters;
+	u8 max_rp;
 };
 
 struct adf_telemetry {
@@ -50,6 +56,7 @@ struct adf_telemetry {
 	 */
 	void **regs_hist_buff;
 	struct dentry *dbg_dir;
+	u8 *rp_num_indexes;
 	/**
 	 * @regs_hist_lock: protects from race conditions between write and read
 	 * to the copies referenced by @regs_hist_buff
diff --git a/drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.c b/drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.c
index accb46d6ea3c..c8241f5a0a26 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.c
@@ -6,6 +6,7 @@
 #include <linux/debugfs.h>
 #include <linux/dev_printk.h>
 #include <linux/dcache.h>
+#include <linux/file.h>
 #include <linux/kernel.h>
 #include <linux/math64.h>
 #include <linux/mutex.h>
@@ -14,11 +15,13 @@
 #include <linux/units.h>
 
 #include "adf_accel_devices.h"
+#include "adf_cfg_strings.h"
 #include "adf_telemetry.h"
 #include "adf_tl_debugfs.h"
 
 #define TL_VALUE_MIN_PADDING	20
 #define TL_KEY_MIN_PADDING	23
+#define TL_RP_SRV_UNKNOWN	"Unknown"
 
 static int tl_collect_values_u32(struct adf_telemetry *telemetry,
 				 size_t counter_offset, u64 *arr)
@@ -470,11 +473,210 @@ static ssize_t tl_control_write(struct file *file, const char __user *userbuf,
 }
 DEFINE_SHOW_STORE_ATTRIBUTE(tl_control);
 
+static int get_rp_index_from_file(const struct file *f, u8 *rp_id, u8 rp_num)
+{
+	char alpha;
+	u8 index;
+	int ret;
+
+	ret = sscanf(f->f_path.dentry->d_name.name, ADF_TL_RP_REGS_FNAME, &alpha);
+	if (ret != 1)
+		return -EINVAL;
+
+	index = ADF_TL_DBG_RP_INDEX_ALPHA(alpha);
+	*rp_id = index;
+
+	return 0;
+}
+
+static int adf_tl_dbg_change_rp_index(struct adf_accel_dev *accel_dev,
+				      unsigned int new_rp_num,
+				      unsigned int rp_regs_index)
+{
+	struct adf_hw_device_data *hw_data = GET_HW_DATA(accel_dev);
+	struct adf_telemetry *telemetry = accel_dev->telemetry;
+	struct device *dev = &GET_DEV(accel_dev);
+	unsigned int i;
+	u8 curr_state;
+	int ret;
+
+	if (new_rp_num >= hw_data->num_rps) {
+		dev_info(dev, "invalid Ring Pair number selected\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < hw_data->tl_data.max_rp; i++) {
+		if (telemetry->rp_num_indexes[i] == new_rp_num) {
+			dev_info(dev, "RP nr: %d is already selected in slot rp_%c_data\n",
+				 new_rp_num, ADF_TL_DBG_RP_ALPHA_INDEX(i));
+			return 0;
+		}
+	}
+
+	dev_dbg(dev, "selecting RP nr %u into slot rp_%c_data\n",
+		new_rp_num, ADF_TL_DBG_RP_ALPHA_INDEX(rp_regs_index));
+
+	curr_state = atomic_read(&telemetry->state);
+
+	if (curr_state) {
+		ret = adf_tl_halt(accel_dev);
+		if (ret)
+			return ret;
+
+		telemetry->rp_num_indexes[rp_regs_index] = new_rp_num;
+
+		ret = adf_tl_run(accel_dev, curr_state);
+		if (ret)
+			return ret;
+	} else {
+		telemetry->rp_num_indexes[rp_regs_index] = new_rp_num;
+	}
+
+	return 0;
+}
+
+static void tl_print_rp_srv(struct adf_accel_dev *accel_dev, struct seq_file *s,
+			    u8 rp_idx)
+{
+	u32 banks_per_vf = GET_HW_DATA(accel_dev)->num_banks_per_vf;
+	enum adf_cfg_service_type svc;
+
+	seq_printf(s, "%-*s", TL_KEY_MIN_PADDING, RP_SERVICE_TYPE);
+
+	svc = GET_SRV_TYPE(accel_dev, rp_idx % banks_per_vf);
+	switch (svc) {
+	case COMP:
+		seq_printf(s, "%*s\n", TL_VALUE_MIN_PADDING, ADF_CFG_DC);
+		break;
+	case SYM:
+		seq_printf(s, "%*s\n", TL_VALUE_MIN_PADDING, ADF_CFG_SYM);
+		break;
+	case ASYM:
+		seq_printf(s, "%*s\n", TL_VALUE_MIN_PADDING, ADF_CFG_ASYM);
+		break;
+	default:
+		seq_printf(s, "%*s\n", TL_VALUE_MIN_PADDING, TL_RP_SRV_UNKNOWN);
+		break;
+	}
+}
+
+static int tl_print_rp_data(struct adf_accel_dev *accel_dev, struct seq_file *s,
+			    u8 rp_regs_index)
+{
+	struct adf_tl_hw_data *tl_data = &GET_TL_DATA(accel_dev);
+	struct adf_telemetry *telemetry = accel_dev->telemetry;
+	const struct adf_tl_dbg_counter *rp_tl_counters;
+	u8 num_rp_counters = tl_data->num_rp_counters;
+	size_t rp_regs_sz = tl_data->rp_reg_sz;
+	struct adf_tl_dbg_counter ctr;
+	unsigned int i;
+	u8 rp_idx;
+	int ret;
+
+	if (!atomic_read(&telemetry->state)) {
+		dev_info(&GET_DEV(accel_dev), "not enabled\n");
+		return -EPERM;
+	}
+
+	rp_tl_counters = tl_data->rp_counters;
+	rp_idx = telemetry->rp_num_indexes[rp_regs_index];
+
+	if (rp_idx == ADF_TL_RP_REGS_DISABLED) {
+		dev_info(&GET_DEV(accel_dev), "no RP number selected in rp_%c_data\n",
+			 ADF_TL_DBG_RP_ALPHA_INDEX(rp_regs_index));
+		return -EPERM;
+	}
+
+	tl_print_msg_cnt(s, telemetry->msg_cnt);
+	seq_printf(s, "%-*s", TL_KEY_MIN_PADDING, RP_NUM_INDEX);
+	seq_printf(s, "%*d\n", TL_VALUE_MIN_PADDING, rp_idx);
+	tl_print_rp_srv(accel_dev, s, rp_idx);
+
+	for (i = 0; i < num_rp_counters; i++) {
+		ctr = rp_tl_counters[i];
+		ctr.offset1 += rp_regs_sz * rp_regs_index;
+		ctr.offset2 += rp_regs_sz * rp_regs_index;
+		ret = tl_calc_and_print_counter(telemetry, s, &ctr, NULL);
+		if (ret) {
+			dev_dbg(&GET_DEV(accel_dev),
+				"invalid RP counter type\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int tl_rp_data_show(struct seq_file *s, void *unused)
+{
+	struct adf_accel_dev *accel_dev = s->private;
+	u8 rp_regs_index;
+	u8 max_rp;
+	int ret;
+
+	if (!accel_dev)
+		return -EINVAL;
+
+	max_rp = GET_TL_DATA(accel_dev).max_rp;
+	ret = get_rp_index_from_file(s->file, &rp_regs_index, max_rp);
+	if (ret) {
+		dev_dbg(&GET_DEV(accel_dev), "invalid RP data file name\n");
+		return ret;
+	}
+
+	return tl_print_rp_data(accel_dev, s, rp_regs_index);
+}
+
+static ssize_t tl_rp_data_write(struct file *file, const char __user *userbuf,
+				size_t count, loff_t *ppos)
+{
+	struct seq_file *seq_f = file->private_data;
+	struct adf_accel_dev *accel_dev;
+	struct adf_telemetry *telemetry;
+	unsigned int new_rp_num;
+	u8 rp_regs_index;
+	u8 max_rp;
+	int ret;
+
+	accel_dev = seq_f->private;
+	if (!accel_dev)
+		return -EINVAL;
+
+	telemetry = accel_dev->telemetry;
+	max_rp = GET_TL_DATA(accel_dev).max_rp;
+
+	mutex_lock(&telemetry->wr_lock);
+
+	ret = get_rp_index_from_file(file, &rp_regs_index, max_rp);
+	if (ret) {
+		dev_dbg(&GET_DEV(accel_dev), "invalid RP data file name\n");
+		goto unlock_and_exit;
+	}
+
+	ret = kstrtou32_from_user(userbuf, count, 10, &new_rp_num);
+	if (ret)
+		goto unlock_and_exit;
+
+	ret = adf_tl_dbg_change_rp_index(accel_dev, new_rp_num, rp_regs_index);
+	if (ret)
+		goto unlock_and_exit;
+
+	ret = count;
+
+unlock_and_exit:
+	mutex_unlock(&telemetry->wr_lock);
+	return ret;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(tl_rp_data);
+
 void adf_tl_dbgfs_add(struct adf_accel_dev *accel_dev)
 {
 	struct adf_telemetry *telemetry = accel_dev->telemetry;
 	struct dentry *parent = accel_dev->debugfs_dir;
+	u8 max_rp = GET_TL_DATA(accel_dev).max_rp;
+	char name[ADF_TL_RP_REGS_FNAME_SIZE];
 	struct dentry *dir;
+	unsigned int i;
 
 	if (!telemetry)
 		return;
@@ -483,6 +685,12 @@ void adf_tl_dbgfs_add(struct adf_accel_dev *accel_dev)
 	accel_dev->telemetry->dbg_dir = dir;
 	debugfs_create_file("device_data", 0444, dir, accel_dev, &tl_dev_data_fops);
 	debugfs_create_file("control", 0644, dir, accel_dev, &tl_control_fops);
+
+	for (i = 0; i < max_rp; i++) {
+		snprintf(name, sizeof(name), ADF_TL_RP_REGS_FNAME,
+			 ADF_TL_DBG_RP_ALPHA_INDEX(i));
+		debugfs_create_file(name, 0644, dir, accel_dev, &tl_rp_data_fops);
+	}
 }
 
 void adf_tl_dbgfs_rm(struct adf_accel_dev *accel_dev)
diff --git a/drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.h b/drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.h
index b2e8f1912c16..11cc9eae19b3 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.h
@@ -24,6 +24,13 @@ struct adf_accel_dev;
 #define AT_GLOB_DTLB_MISS_NAME	"at_glob_devtlb_miss"
 #define AT_PAYLD_DTLB_HIT_NAME	"tl_at_payld_devtlb_hit"
 #define AT_PAYLD_DTLB_MISS_NAME	"tl_at_payld_devtlb_miss"
+#define RP_SERVICE_TYPE		"service_type"
+
+#define ADF_TL_DBG_RP_ALPHA_INDEX(index) ((index) + 'A')
+#define ADF_TL_DBG_RP_INDEX_ALPHA(alpha) ((alpha) - 'A')
+
+#define ADF_TL_RP_REGS_FNAME		"rp_%c_data"
+#define ADF_TL_RP_REGS_FNAME_SIZE		16
 
 #define ADF_TL_DATA_REG_OFF(reg, qat_gen)	\
 	offsetof(struct adf_##qat_gen##_tl_layout, reg)
@@ -36,6 +43,10 @@ struct adf_accel_dev;
 	(ADF_TL_DEV_REG_OFF(slice##_slices[0], qat_gen) +	\
 	offsetof(struct adf_##qat_gen##_tl_slice_data_regs, reg))
 
+#define ADF_TL_RP_REG_OFF(reg, qat_gen)					\
+	(ADF_TL_DATA_REG_OFF(tl_ring_pairs_data_regs[0], qat_gen) +	\
+	offsetof(struct adf_##qat_gen##_tl_ring_pair_data_regs, reg))
+
 /**
  * enum adf_tl_counter_type - telemetry counter types
  * @ADF_TL_COUNTER_UNSUPPORTED: unsupported counter
-- 
2.41.0



Return-Path: <linux-crypto+bounces-1200-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B4C8227B2
	for <lists+linux-crypto@lfdr.de>; Wed,  3 Jan 2024 05:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCDEDB21940
	for <lists+linux-crypto@lfdr.de>; Wed,  3 Jan 2024 04:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02502171CC;
	Wed,  3 Jan 2024 04:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OS1fTUeJ"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FC2171C4
	for <linux-crypto@vger.kernel.org>; Wed,  3 Jan 2024 04:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704254958; x=1735790958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ta5yr5OFpr8eNcJ+wCXa435D5d5+79/XdNWWxh4v780=;
  b=OS1fTUeJ3vtkFuLGOWp27uBKAp1zcx/bxy9d70yPAlulPUHoUlbhyktO
   mMAvg5LsNc0KuWXbH/dUd7mo2XRSUZpLuxNbT9MfbHc0xp/UWDqdVvOu2
   g1B3stwYdNfHuq3Z45fGxzTY7htcoNvHVohO7CPC6bXBuQDNOr/tkMb3/
   54FD6BFjp2g/GIyT7i8ltsoDNPyIWojkZ7BAn/XWjcT0MhE8b+Mirwt3f
   cch0jl5KMDtT6bYJV4uDx1I/eCbLnanrxK2+Mh3JCxkuYtSmSGvqJVZIa
   9Rv1nbVi/OwQ6PaPgh1uRKly2DsCj98Pi2TKb/YrdbfJ61epGTlH1l4Ep
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="3725482"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="3725482"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 20:09:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="1111241868"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="1111241868"
Received: from myep-mobl1.png.intel.com ([10.107.5.97])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 20:09:12 -0800
From: Mun Chun Yep <mun.chun.yep@intel.com>
To: herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org,
	qat-linux@intel.com,
	Damian Muszynski <damian.muszynski@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
	Ahsan Atta <ahsan.atta@intel.com>,
	Markas Rapoportas <markas.rapoportas@intel.com>
Subject: [PATCH 1/9] crypto: qat - add heartbeat error simulator
Date: Wed,  3 Jan 2024 12:07:14 +0800
Message-Id: <20240103040722.14467-2-mun.chun.yep@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103040722.14467-1-mun.chun.yep@intel.com>
References: <20240103040722.14467-1-mun.chun.yep@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Damian Muszynski <damian.muszynski@intel.com>

Add a mechanism that allows to inject a heartbeat error for testing
purposes.
A new attribute `inject_error` is added to debugfs for each QAT device.
Upon a write on this attribute, the driver will inject an error on the
device which can then be detected by the heartbeat feature.
Errors are breaking the device functionality thus they require a
device reset in order to be recovered.

This functionality is not compiled by default, to enable it
CRYPTO_DEV_QAT_ERROR_INJECTION must be set.

Signed-off-by: Damian Muszynski <damian.muszynski@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
Reviewed-by: Markas Rapoportas <markas.rapoportas@intel.com>
---
 Documentation/ABI/testing/debugfs-driver-qat  | 26 +++++++
 drivers/crypto/intel/qat/Kconfig              | 15 ++++
 drivers/crypto/intel/qat/qat_common/Makefile  |  3 +
 .../intel/qat/qat_common/adf_common_drv.h     |  1 +
 .../intel/qat/qat_common/adf_heartbeat.c      |  6 --
 .../intel/qat/qat_common/adf_heartbeat.h      | 18 +++++
 .../qat/qat_common/adf_heartbeat_dbgfs.c      | 52 +++++++++++++
 .../qat/qat_common/adf_heartbeat_inject.c     | 76 +++++++++++++++++++
 .../intel/qat/qat_common/adf_hw_arbiter.c     | 25 ++++++
 9 files changed, 216 insertions(+), 6 deletions(-)
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_heartbeat_inject.c

diff --git a/Documentation/ABI/testing/debugfs-driver-qat b/Documentation/ABI/testing/debugfs-driver-qat
index b2db010d851e..bd6793760f29 100644
--- a/Documentation/ABI/testing/debugfs-driver-qat
+++ b/Documentation/ABI/testing/debugfs-driver-qat
@@ -81,3 +81,29 @@ Description:	(RO) Read returns, for each Acceleration Engine (AE), the number
 			<N>: Number of Compress and Verify (CnV) errors and type
 			     of the last CnV error detected by Acceleration
 			     Engine N.
+
+What:		/sys/kernel/debug/qat_<device>_<BDF>/heartbeat/inject_error
+Date:		March 2024
+KernelVersion:	6.8
+Contact:	qat-linux@intel.com
+Description:	(WO) Write to inject an error that simulates an heartbeat
+		failure. This is to be used for testing purposes.
+
+		After writing this file, the driver stops arbitration on a
+		random engine and disables the fetching of heartbeat counters.
+		If a workload is running on the device, a job submitted to the
+		accelerator might not get a response and a read of the
+		`heartbeat/status` attribute might report -1, i.e. device
+		unresponsive.
+		The error is unrecoverable thus the device must be restarted to
+		restore its functionality.
+
+		This attribute is available only when the kernel is built with
+		CONFIG_CRYPTO_DEV_QAT_ERROR_INJECTION=y.
+
+		A write of 1 enables error injection.
+
+		The following example shows how to enable error injection::
+
+			# cd /sys/kernel/debug/qat_<device>_<BDF>
+			# echo 1 > heartbeat/inject_error
diff --git a/drivers/crypto/intel/qat/Kconfig b/drivers/crypto/intel/qat/Kconfig
index c120f6715a09..7aefd57f9d2f 100644
--- a/drivers/crypto/intel/qat/Kconfig
+++ b/drivers/crypto/intel/qat/Kconfig
@@ -106,3 +106,18 @@ config CRYPTO_DEV_QAT_C62XVF
 
 	  To compile this as a module, choose M here: the module
 	  will be called qat_c62xvf.
+
+config CRYPTO_DEV_QAT_ERROR_INJECTION
+	bool "Support for Intel(R) QAT Devices Heartbeat Error Injection"
+	default n
+	depends on CRYPTO_DEV_QAT
+	depends on DEBUG_FS
+	help
+	  Enables a mechanism that allows to inject a heartbeat error on
+	  Intel(R) QuickAssist devices for testing purposes.
+
+	  This is intended for developer use only.
+	  If unsure, say N.
+
+	  This functionality is available via debugfs entry of the Intel(R)
+	  QuickAssist device
diff --git a/drivers/crypto/intel/qat/qat_common/Makefile b/drivers/crypto/intel/qat/qat_common/Makefile
index 6908727bff3b..e36310667335 100644
--- a/drivers/crypto/intel/qat/qat_common/Makefile
+++ b/drivers/crypto/intel/qat/qat_common/Makefile
@@ -53,3 +53,6 @@ intel_qat-$(CONFIG_PCI_IOV) += adf_sriov.o adf_vf_isr.o adf_pfvf_utils.o \
 			       adf_pfvf_pf_msg.o adf_pfvf_pf_proto.o \
 			       adf_pfvf_vf_msg.o adf_pfvf_vf_proto.o \
 			       adf_gen2_pfvf.o adf_gen4_pfvf.o
+
+intel_qat-$(CONFIG_CRYPTO_DEV_QAT_ERROR_INJECTION) += adf_heartbeat_inject.o
+ccflags-$(CONFIG_CRYPTO_DEV_QAT_ERROR_INJECTION) += -DQAT_HB_ERROR_INJECTION
diff --git a/drivers/crypto/intel/qat/qat_common/adf_common_drv.h b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
index f06188033a93..0baae42deb3a 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
@@ -90,6 +90,7 @@ void adf_exit_aer(void);
 int adf_init_arb(struct adf_accel_dev *accel_dev);
 void adf_exit_arb(struct adf_accel_dev *accel_dev);
 void adf_update_ring_arb(struct adf_etr_ring_data *ring);
+int adf_disable_arb_thd(struct adf_accel_dev *accel_dev, u32 ae, u32 thr);
 
 int adf_dev_get(struct adf_accel_dev *accel_dev);
 void adf_dev_put(struct adf_accel_dev *accel_dev);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_heartbeat.c b/drivers/crypto/intel/qat/qat_common/adf_heartbeat.c
index 13f48d2f6da8..f88b1bc6857e 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_heartbeat.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_heartbeat.c
@@ -23,12 +23,6 @@
 
 #define ADF_HB_EMPTY_SIG 0xA5A5A5A5
 
-/* Heartbeat counter pair */
-struct hb_cnt_pair {
-	__u16 resp_heartbeat_cnt;
-	__u16 req_heartbeat_cnt;
-};
-
 static int adf_hb_check_polling_freq(struct adf_accel_dev *accel_dev)
 {
 	u64 curr_time = adf_clock_get_current_time();
diff --git a/drivers/crypto/intel/qat/qat_common/adf_heartbeat.h b/drivers/crypto/intel/qat/qat_common/adf_heartbeat.h
index b22e3cb29798..75db563f23ba 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_heartbeat.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_heartbeat.h
@@ -19,6 +19,12 @@ enum adf_device_heartbeat_status {
 	HB_DEV_UNSUPPORTED,
 };
 
+/* Heartbeat counter pair */
+struct hb_cnt_pair {
+	__u16 resp_heartbeat_cnt;
+	__u16 req_heartbeat_cnt;
+};
+
 struct adf_heartbeat {
 	unsigned int hb_sent_counter;
 	unsigned int hb_failed_counter;
@@ -35,6 +41,9 @@ struct adf_heartbeat {
 		struct dentry *cfg;
 		struct dentry *sent;
 		struct dentry *failed;
+#ifdef QAT_HB_ERROR_INJECTION
+		struct dentry *inject_error;
+#endif
 	} dbgfs;
 };
 
@@ -51,6 +60,15 @@ void adf_heartbeat_status(struct adf_accel_dev *accel_dev,
 			  enum adf_device_heartbeat_status *hb_status);
 void adf_heartbeat_check_ctrs(struct adf_accel_dev *accel_dev);
 
+#ifdef QAT_HB_ERROR_INJECTION
+int adf_heartbeat_inject_error(struct adf_accel_dev *accel_dev);
+#else
+static inline int adf_heartbeat_inject_error(struct adf_accel_dev *accel_dev)
+{
+	return -EPERM;
+}
+#endif
+
 #else
 static inline int adf_heartbeat_init(struct adf_accel_dev *accel_dev)
 {
diff --git a/drivers/crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.c b/drivers/crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.c
index 2661af6a2ef6..d797677397e6 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.c
@@ -155,6 +155,43 @@ static const struct file_operations adf_hb_cfg_fops = {
 	.write = adf_hb_cfg_write,
 };
 
+static ssize_t adf_hb_error_inject_write(struct file *file,
+					 const char __user *user_buf,
+					 size_t count, loff_t *ppos)
+{
+	struct adf_accel_dev *accel_dev = file->private_data;
+	size_t written_chars;
+	char buf[3];
+	int ret;
+
+	/* last byte left as string termination */
+	if (count != 2)
+		return -EINVAL;
+
+	written_chars = simple_write_to_buffer(buf, sizeof(buf) - 1,
+					       ppos, user_buf, count);
+	if (buf[0] != '1')
+		return -EINVAL;
+
+	ret = adf_heartbeat_inject_error(accel_dev);
+	if (ret) {
+		dev_err(&GET_DEV(accel_dev),
+			"Heartbeat error injection failed with status %d\n",
+			ret);
+		return ret;
+	}
+
+	dev_info(&GET_DEV(accel_dev), "Heartbeat error injection enabled\n");
+
+	return written_chars;
+}
+
+static const struct file_operations adf_hb_error_inject_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.write = adf_hb_error_inject_write,
+};
+
 void adf_heartbeat_dbgfs_add(struct adf_accel_dev *accel_dev)
 {
 	struct adf_heartbeat *hb = accel_dev->heartbeat;
@@ -171,6 +208,17 @@ void adf_heartbeat_dbgfs_add(struct adf_accel_dev *accel_dev)
 					       &hb->hb_failed_counter, &adf_hb_stats_fops);
 	hb->dbgfs.cfg = debugfs_create_file("config", 0600, hb->dbgfs.base_dir,
 					    accel_dev, &adf_hb_cfg_fops);
+
+	if (IS_ENABLED(CONFIG_CRYPTO_DEV_QAT_ERROR_INJECTION)) {
+		struct dentry *inject_error __maybe_unused;
+
+		inject_error = debugfs_create_file("inject_error", 0200,
+						   hb->dbgfs.base_dir, accel_dev,
+						   &adf_hb_error_inject_fops);
+#ifdef QAT_HB_ERROR_INJECTION
+		hb->dbgfs.inject_error = inject_error;
+#endif
+	}
 }
 EXPORT_SYMBOL_GPL(adf_heartbeat_dbgfs_add);
 
@@ -189,6 +237,10 @@ void adf_heartbeat_dbgfs_rm(struct adf_accel_dev *accel_dev)
 	hb->dbgfs.failed = NULL;
 	debugfs_remove(hb->dbgfs.cfg);
 	hb->dbgfs.cfg = NULL;
+#ifdef QAT_HB_ERROR_INJECTION
+	debugfs_remove(hb->dbgfs.inject_error);
+	hb->dbgfs.inject_error = NULL;
+#endif
 	debugfs_remove(hb->dbgfs.base_dir);
 	hb->dbgfs.base_dir = NULL;
 }
diff --git a/drivers/crypto/intel/qat/qat_common/adf_heartbeat_inject.c b/drivers/crypto/intel/qat/qat_common/adf_heartbeat_inject.c
new file mode 100644
index 000000000000..a3b474bdef6c
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_heartbeat_inject.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation */
+#include <linux/random.h>
+
+#include "adf_admin.h"
+#include "adf_common_drv.h"
+#include "adf_heartbeat.h"
+
+#define MAX_HB_TICKS 0xFFFFFFFF
+
+static int adf_hb_set_timer_to_max(struct adf_accel_dev *accel_dev)
+{
+	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+
+	accel_dev->heartbeat->hb_timer = 0;
+
+	if (hw_data->stop_timer)
+		hw_data->stop_timer(accel_dev);
+
+	return adf_send_admin_hb_timer(accel_dev, MAX_HB_TICKS);
+}
+
+static void adf_set_hb_counters_fail(struct adf_accel_dev *accel_dev, u32 ae,
+				     u32 thr)
+{
+	struct hb_cnt_pair *stats = accel_dev->heartbeat->dma.virt_addr;
+	struct adf_hw_device_data *hw_device = accel_dev->hw_device;
+	const size_t max_aes = hw_device->get_num_aes(hw_device);
+	const size_t hb_ctrs = hw_device->num_hb_ctrs;
+	size_t thr_id = ae * hb_ctrs + thr;
+	u16 num_rsp = stats[thr_id].resp_heartbeat_cnt;
+
+	/*
+	 * Inject live.req != live.rsp and live.rsp == last.rsp
+	 * to trigger the heartbeat error detection
+	 */
+	stats[thr_id].req_heartbeat_cnt++;
+	stats += (max_aes * hb_ctrs);
+	stats[thr_id].resp_heartbeat_cnt = num_rsp;
+}
+
+int adf_heartbeat_inject_error(struct adf_accel_dev *accel_dev)
+{
+	struct adf_hw_device_data *hw_device = accel_dev->hw_device;
+	const size_t max_aes = hw_device->get_num_aes(hw_device);
+	const size_t hb_ctrs = hw_device->num_hb_ctrs;
+	u32 rand, rand_ae, rand_thr;
+	unsigned long ae_mask;
+	int ret;
+
+	ae_mask = hw_device->ae_mask;
+
+	do {
+		/* Ensure we have a valid ae */
+		get_random_bytes(&rand, sizeof(rand));
+		rand_ae = rand % max_aes;
+	} while (!test_bit(rand_ae, &ae_mask));
+
+	get_random_bytes(&rand, sizeof(rand));
+	rand_thr = rand % hb_ctrs;
+
+	/* Increase the heartbeat timer to prevent FW updating HB counters */
+	ret = adf_hb_set_timer_to_max(accel_dev);
+	if (ret)
+		return ret;
+
+	/* Configure worker threads to stop processing any packet */
+	ret = adf_disable_arb_thd(accel_dev, rand_ae, rand_thr);
+	if (ret)
+		return ret;
+
+	/* Change HB counters memory to simulate a hang */
+	adf_set_hb_counters_fail(accel_dev, rand_ae, rand_thr);
+
+	return 0;
+}
diff --git a/drivers/crypto/intel/qat/qat_common/adf_hw_arbiter.c b/drivers/crypto/intel/qat/qat_common/adf_hw_arbiter.c
index da6956699246..65bd26b25abc 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_hw_arbiter.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_hw_arbiter.c
@@ -103,3 +103,28 @@ void adf_exit_arb(struct adf_accel_dev *accel_dev)
 		csr_ops->write_csr_ring_srv_arb_en(csr, i, 0);
 }
 EXPORT_SYMBOL_GPL(adf_exit_arb);
+
+int adf_disable_arb_thd(struct adf_accel_dev *accel_dev, u32 ae, u32 thr)
+{
+	void __iomem *csr = accel_dev->transport->banks[0].csr_addr;
+	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+	const u32 *thd_2_arb_cfg;
+	struct arb_info info;
+	u32 ae_thr_map;
+
+	if (ADF_AE_STRAND0_THREAD == thr || ADF_AE_STRAND1_THREAD == thr)
+		thr = ADF_AE_ADMIN_THREAD;
+
+	hw_data->get_arb_info(&info);
+	thd_2_arb_cfg = hw_data->get_arb_mapping(accel_dev);
+	if (!thd_2_arb_cfg)
+		return -EFAULT;
+
+	/* Disable scheduling for this particular AE and thread */
+	ae_thr_map = *(thd_2_arb_cfg + ae);
+	ae_thr_map &= ~(GENMASK(3, 0) << (thr * BIT(2)));
+
+	WRITE_CSR_ARB_WT2SAM(csr, info.arb_offset, info.wt2sam_offset, ae,
+			     ae_thr_map);
+	return 0;
+}
-- 
2.34.1



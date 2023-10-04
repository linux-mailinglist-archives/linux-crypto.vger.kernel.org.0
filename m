Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CDC7B7D57
	for <lists+linux-crypto@lfdr.de>; Wed,  4 Oct 2023 12:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjJDKig (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 4 Oct 2023 06:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjJDKif (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 4 Oct 2023 06:38:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BA3C1
        for <linux-crypto@vger.kernel.org>; Wed,  4 Oct 2023 03:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696415910; x=1727951910;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GU7KBnsKPPxF436YyT3jy25Q0XaqbzbRe+EGMj39Mcg=;
  b=kdDa6PJA8PRH5O6wWhZCfIIOqsBo40CtBobrdkGjN5+jfCSNw2JmPBnn
   G7YZc/xueR1PaCjcAriWDxnhcmwMXdtUUmgpXbNoDMkv9lQv00PX6VeJH
   BRlKC+g7H2kMa1IByjx9vLEEvlBVs+WNVnQajQoAvrVLrLBuZZtPHilI1
   omMpwuKLy9qz1y9OjWRLKiTSGFjRNneqGMKdktkveV4aNaQMTWBauXjXU
   KkMnw1YTT9stsXRKmwl+Pb/MK3+D/GJEXTK7l/vv7Ob4GSW7aCbqslTnb
   GXgiy/mcXgT8a5rPZMT5l3Ja1lamyGnDlrUvgAIGy+HWJ2yJl9Hjj5qZJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="381992751"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="381992751"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 03:38:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="701043315"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="701043315"
Received: from r007s007_zp31l10c01.deacluster.intel.com (HELO fedora.deacluster.intel.com) ([10.219.171.169])
  by orsmga003.jf.intel.com with ESMTP; 04 Oct 2023 03:38:26 -0700
From:   Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH v4] crypto: qat - add cnv_errors debugfs file
Date:   Wed,  4 Oct 2023 12:36:42 +0200
Message-ID: <20231004103642.37876-1-lucas.segarra.fernandez@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The Compress and Verify (CnV) feature check and ensures data integrity
in the compression operation. The implementation of CnV keeps a record
of the CnV errors that have occurred since the driver was loaded.

Expose CnV error stats by providing the "cnv_errors" file under
debugfs. This includes the number of errors detected up to now and
the type of the last error. The error count is provided on a per
Acceleration Engine basis and it is reset every time the driver is loaded.

Signed-off-by: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
v3 -> v4:
- rebase on top of latest version (v6) of crypto: qat - add pm_status debugfs file
- alphabetical order for intel_qat-$(CONFIG_DEBUG_FS) makefile target
---
v2 -> v3:
- remove unneeded header inclussion
---
v1 -> v2:
- Rebase on top of latest version (v4) of crypto: qat - add pm_status debugfs file
---
 Documentation/ABI/testing/debugfs-driver-qat  |  13 +
 drivers/crypto/intel/qat/qat_common/Makefile  |   1 +
 .../intel/qat/qat_common/adf_accel_devices.h  |   1 +
 .../crypto/intel/qat/qat_common/adf_admin.c   |  21 ++
 .../intel/qat/qat_common/adf_cnv_dbgfs.c      | 299 ++++++++++++++++++
 .../intel/qat/qat_common/adf_cnv_dbgfs.h      |  11 +
 .../intel/qat/qat_common/adf_common_drv.h     |   1 +
 .../crypto/intel/qat/qat_common/adf_dbgfs.c   |   3 +
 .../qat/qat_common/icp_qat_fw_init_admin.h    |   5 +
 9 files changed, 355 insertions(+)
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_cnv_dbgfs.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_cnv_dbgfs.h

diff --git a/Documentation/ABI/testing/debugfs-driver-qat b/Documentation/ABI/testing/debugfs-driver-qat
index 0656f27d1042..b2db010d851e 100644
--- a/Documentation/ABI/testing/debugfs-driver-qat
+++ b/Documentation/ABI/testing/debugfs-driver-qat
@@ -68,3 +68,16 @@ Description:	(RO) Read returns power management information specific to the
 		QAT device.
 
 		This attribute is only available for qat_4xxx devices.
+
+What:		/sys/kernel/debug/qat_<device>_<BDF>/cnv_errors
+Date:		January 2024
+KernelVersion:	6.7
+Contact:	qat-linux@intel.com
+Description:	(RO) Read returns, for each Acceleration Engine (AE), the number
+		of errors and the type of the last error detected by the device
+		when performing verified compression.
+		Reported counters::
+
+			<N>: Number of Compress and Verify (CnV) errors and type
+			     of the last CnV error detected by Acceleration
+			     Engine N.
diff --git a/drivers/crypto/intel/qat/qat_common/Makefile b/drivers/crypto/intel/qat/qat_common/Makefile
index cf44ede55c58..204c7d0aa31e 100644
--- a/drivers/crypto/intel/qat/qat_common/Makefile
+++ b/drivers/crypto/intel/qat/qat_common/Makefile
@@ -32,6 +32,7 @@ intel_qat-objs := adf_cfg.o \
 
 intel_qat-$(CONFIG_DEBUG_FS) += adf_transport_debug.o \
 				adf_fw_counters.o \
+				adf_cnv_dbgfs.o \
 				adf_gen4_pm_debugfs.o \
 				adf_heartbeat.o \
 				adf_heartbeat_dbgfs.o \
diff --git a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
index 1adbc619b896..9677c8e0f180 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
@@ -317,6 +317,7 @@ struct adf_accel_dev {
 	atomic_t ref_count;
 	struct dentry *debugfs_dir;
 	struct dentry *fw_cntr_dbgfile;
+	struct dentry *cnv_dbgfile;
 	struct list_head list;
 	struct module *owner;
 	struct adf_accel_pci accel_pci_dev;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_admin.c b/drivers/crypto/intel/qat/qat_common/adf_admin.c
index 2d45167b48a0..3a04e743497f 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_admin.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_admin.c
@@ -406,6 +406,27 @@ int adf_get_pm_info(struct adf_accel_dev *accel_dev, dma_addr_t p_state_addr,
 	return ret;
 }
 
+int adf_get_cnv_stats(struct adf_accel_dev *accel_dev, u16 ae, u16 *err_cnt,
+		      u16 *latest_err)
+{
+	struct icp_qat_fw_init_admin_req req = { };
+	struct icp_qat_fw_init_admin_resp resp;
+	int ret;
+
+	req.cmd_id = ICP_QAT_FW_CNV_STATS_GET;
+
+	ret = adf_put_admin_msg_sync(accel_dev, ae, &req, &resp);
+	if (ret)
+		return ret;
+	if (resp.status)
+		return -EPROTONOSUPPORT;
+
+	*err_cnt = resp.error_count;
+	*latest_err = resp.latest_error;
+
+	return ret;
+}
+
 int adf_init_admin_comms(struct adf_accel_dev *accel_dev)
 {
 	struct adf_admin_comms *admin;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_cnv_dbgfs.c b/drivers/crypto/intel/qat/qat_common/adf_cnv_dbgfs.c
new file mode 100644
index 000000000000..aa5b6ff1dfb4
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_cnv_dbgfs.c
@@ -0,0 +1,299 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation */
+
+#include <linux/bitfield.h>
+#include <linux/debugfs.h>
+#include <linux/kernel.h>
+
+#include "adf_accel_devices.h"
+#include "adf_common_drv.h"
+#include "adf_cnv_dbgfs.h"
+#include "qat_compression.h"
+
+#define CNV_DEBUGFS_FILENAME		"cnv_errors"
+#define CNV_MIN_PADDING			16
+
+#define CNV_ERR_INFO_MASK		GENMASK(11, 0)
+#define CNV_ERR_TYPE_MASK		GENMASK(15, 12)
+#define CNV_SLICE_ERR_MASK		GENMASK(7, 0)
+#define CNV_SLICE_ERR_SIGN_BIT_INDEX	7
+#define CNV_DELTA_ERR_SIGN_BIT_INDEX	11
+
+enum cnv_error_type {
+	CNV_ERR_TYPE_NONE,
+	CNV_ERR_TYPE_CHECKSUM,
+	CNV_ERR_TYPE_DECOMP_PRODUCED_LENGTH,
+	CNV_ERR_TYPE_DECOMPRESSION,
+	CNV_ERR_TYPE_TRANSLATION,
+	CNV_ERR_TYPE_DECOMP_CONSUMED_LENGTH,
+	CNV_ERR_TYPE_UNKNOWN,
+	CNV_ERR_TYPES_COUNT
+};
+
+#define CNV_ERROR_TYPE_GET(latest_err)	\
+	min_t(u16, u16_get_bits(latest_err, CNV_ERR_TYPE_MASK), CNV_ERR_TYPE_UNKNOWN)
+
+#define CNV_GET_DELTA_ERR_INFO(latest_error)	\
+	sign_extend32(latest_error, CNV_DELTA_ERR_SIGN_BIT_INDEX)
+
+#define CNV_GET_SLICE_ERR_INFO(latest_error)	\
+	sign_extend32(latest_error, CNV_SLICE_ERR_SIGN_BIT_INDEX)
+
+#define CNV_GET_DEFAULT_ERR_INFO(latest_error)	\
+	u16_get_bits(latest_error, CNV_ERR_INFO_MASK)
+
+enum cnv_fields {
+	CNV_ERR_COUNT,
+	CNV_LATEST_ERR,
+	CNV_FIELDS_COUNT
+};
+
+static const char * const cnv_field_names[CNV_FIELDS_COUNT] = {
+	[CNV_ERR_COUNT] = "Total Errors",
+	[CNV_LATEST_ERR] = "Last Error",
+};
+
+static const char * const cnv_error_names[CNV_ERR_TYPES_COUNT] = {
+	[CNV_ERR_TYPE_NONE] = "No Error",
+	[CNV_ERR_TYPE_CHECKSUM] = "Checksum Error",
+	[CNV_ERR_TYPE_DECOMP_PRODUCED_LENGTH] = "Length Error-P",
+	[CNV_ERR_TYPE_DECOMPRESSION] = "Decomp Error",
+	[CNV_ERR_TYPE_TRANSLATION] = "Xlat Error",
+	[CNV_ERR_TYPE_DECOMP_CONSUMED_LENGTH] = "Length Error-C",
+	[CNV_ERR_TYPE_UNKNOWN] = "Unknown Error",
+};
+
+struct ae_cnv_errors {
+	u16 ae;
+	u16 err_cnt;
+	u16 latest_err;
+	bool is_comp_ae;
+};
+
+struct cnv_err_stats {
+	u16 ae_count;
+	struct ae_cnv_errors ae_cnv_errors[];
+};
+
+static s16 get_err_info(u8 error_type, u16 latest)
+{
+	switch (error_type) {
+	case CNV_ERR_TYPE_DECOMP_PRODUCED_LENGTH:
+	case CNV_ERR_TYPE_DECOMP_CONSUMED_LENGTH:
+		return CNV_GET_DELTA_ERR_INFO(latest);
+	case CNV_ERR_TYPE_DECOMPRESSION:
+	case CNV_ERR_TYPE_TRANSLATION:
+		return CNV_GET_SLICE_ERR_INFO(latest);
+	default:
+		return CNV_GET_DEFAULT_ERR_INFO(latest);
+	}
+}
+
+static void *qat_cnv_errors_seq_start(struct seq_file *sfile, loff_t *pos)
+{
+	struct cnv_err_stats *err_stats = sfile->private;
+
+	if (*pos == 0)
+		return SEQ_START_TOKEN;
+
+	if (*pos > err_stats->ae_count)
+		return NULL;
+
+	return &err_stats->ae_cnv_errors[*pos - 1];
+}
+
+static void *qat_cnv_errors_seq_next(struct seq_file *sfile, void *v,
+				     loff_t *pos)
+{
+	struct cnv_err_stats *err_stats = sfile->private;
+
+	(*pos)++;
+
+	if (*pos > err_stats->ae_count)
+		return NULL;
+
+	return &err_stats->ae_cnv_errors[*pos - 1];
+}
+
+static void qat_cnv_errors_seq_stop(struct seq_file *sfile, void *v)
+{
+}
+
+static int qat_cnv_errors_seq_show(struct seq_file *sfile, void *v)
+{
+	struct ae_cnv_errors *ae_errors;
+	unsigned int i;
+	s16 err_info;
+	u8 err_type;
+
+	if (v == SEQ_START_TOKEN) {
+		seq_puts(sfile, "AE ");
+		for (i = 0; i < CNV_FIELDS_COUNT; ++i)
+			seq_printf(sfile, " %*s", CNV_MIN_PADDING,
+				   cnv_field_names[i]);
+	} else {
+		ae_errors = v;
+
+		if (!ae_errors->is_comp_ae)
+			return 0;
+
+		err_type = CNV_ERROR_TYPE_GET(ae_errors->latest_err);
+		err_info = get_err_info(err_type, ae_errors->latest_err);
+
+		seq_printf(sfile, "%d:", ae_errors->ae);
+		seq_printf(sfile, " %*d", CNV_MIN_PADDING, ae_errors->err_cnt);
+		seq_printf(sfile, "%*s [%d]", CNV_MIN_PADDING,
+			   cnv_error_names[err_type], err_info);
+	}
+	seq_putc(sfile, '\n');
+
+	return 0;
+}
+
+static const struct seq_operations qat_cnv_errors_sops = {
+	.start = qat_cnv_errors_seq_start,
+	.next = qat_cnv_errors_seq_next,
+	.stop = qat_cnv_errors_seq_stop,
+	.show = qat_cnv_errors_seq_show,
+};
+
+/**
+ * cnv_err_stats_alloc() - Get CNV stats for the provided device.
+ * @accel_dev: Pointer to a QAT acceleration device
+ *
+ * Allocates and populates table of CNV errors statistics for each non-admin AE
+ * available through the supplied acceleration device. The caller becomes the
+ * owner of such memory and is responsible for the deallocation through a call
+ * to kfree().
+ *
+ * Returns: a pointer to a dynamically allocated struct cnv_err_stats on success
+ * or a negative value on error.
+ */
+static struct cnv_err_stats *cnv_err_stats_alloc(struct adf_accel_dev *accel_dev)
+{
+	struct adf_hw_device_data *hw_data = GET_HW_DATA(accel_dev);
+	struct cnv_err_stats *err_stats;
+	unsigned long ae_count;
+	unsigned long ae_mask;
+	size_t err_stats_size;
+	unsigned long ae;
+	unsigned int i;
+	u16 latest_err;
+	u16 err_cnt;
+	int ret;
+
+	if (!adf_dev_started(accel_dev)) {
+		dev_err(&GET_DEV(accel_dev), "QAT Device not started\n");
+		return ERR_PTR(-EBUSY);
+	}
+
+	/* Ignore the admin AEs */
+	ae_mask = hw_data->ae_mask & ~hw_data->admin_ae_mask;
+	ae_count = hweight_long(ae_mask);
+	if (unlikely(!ae_count))
+		return ERR_PTR(-EINVAL);
+
+	err_stats_size = struct_size(err_stats, ae_cnv_errors, ae_count);
+	err_stats = kmalloc(err_stats_size, GFP_KERNEL);
+	if (!err_stats)
+		return ERR_PTR(-ENOMEM);
+
+	err_stats->ae_count = ae_count;
+
+	i = 0;
+	for_each_set_bit(ae, &ae_mask, GET_MAX_ACCELENGINES(accel_dev)) {
+		ret = adf_get_cnv_stats(accel_dev, ae, &err_cnt, &latest_err);
+		if (ret) {
+			dev_dbg(&GET_DEV(accel_dev),
+				"Failed to get CNV stats for ae %ld, [%d].\n",
+				ae, ret);
+			err_stats->ae_cnv_errors[i++].is_comp_ae = false;
+			continue;
+		}
+		err_stats->ae_cnv_errors[i].is_comp_ae = true;
+		err_stats->ae_cnv_errors[i].latest_err = latest_err;
+		err_stats->ae_cnv_errors[i].err_cnt = err_cnt;
+		err_stats->ae_cnv_errors[i].ae = ae;
+		i++;
+	}
+
+	return err_stats;
+}
+
+static int qat_cnv_errors_file_open(struct inode *inode, struct file *file)
+{
+	struct adf_accel_dev *accel_dev = inode->i_private;
+	struct seq_file *cnv_errors_seq_file;
+	struct cnv_err_stats *cnv_err_stats;
+	int ret;
+
+	cnv_err_stats = cnv_err_stats_alloc(accel_dev);
+	if (IS_ERR(cnv_err_stats))
+		return PTR_ERR(cnv_err_stats);
+
+	ret = seq_open(file, &qat_cnv_errors_sops);
+	if (unlikely(ret)) {
+		kfree(cnv_err_stats);
+		return ret;
+	}
+
+	cnv_errors_seq_file = file->private_data;
+	cnv_errors_seq_file->private = cnv_err_stats;
+	return ret;
+}
+
+static int qat_cnv_errors_file_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *cnv_errors_seq_file = file->private_data;
+
+	kfree(cnv_errors_seq_file->private);
+	cnv_errors_seq_file->private = NULL;
+
+	return seq_release(inode, file);
+}
+
+static const struct file_operations qat_cnv_fops = {
+	.owner = THIS_MODULE,
+	.open = qat_cnv_errors_file_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = qat_cnv_errors_file_release,
+};
+
+static ssize_t no_comp_file_read(struct file *f, char __user *buf, size_t count,
+				 loff_t *pos)
+{
+	char *file_msg = "No engine configured for comp\n";
+
+	return simple_read_from_buffer(buf, count, pos, file_msg,
+				       strlen(file_msg));
+}
+
+static const struct file_operations qat_cnv_no_comp_fops = {
+	.owner = THIS_MODULE,
+	.read = no_comp_file_read,
+};
+
+void adf_cnv_dbgfs_add(struct adf_accel_dev *accel_dev)
+{
+	const struct file_operations *fops;
+	void *data;
+
+	if (adf_hw_dev_has_compression(accel_dev)) {
+		fops = &qat_cnv_fops;
+		data = accel_dev;
+	} else {
+		fops = &qat_cnv_no_comp_fops;
+		data = NULL;
+	}
+
+	accel_dev->cnv_dbgfile = debugfs_create_file(CNV_DEBUGFS_FILENAME, 0400,
+						     accel_dev->debugfs_dir,
+						     data, fops);
+}
+
+void adf_cnv_dbgfs_rm(struct adf_accel_dev *accel_dev)
+{
+	debugfs_remove(accel_dev->cnv_dbgfile);
+	accel_dev->cnv_dbgfile = NULL;
+}
diff --git a/drivers/crypto/intel/qat/qat_common/adf_cnv_dbgfs.h b/drivers/crypto/intel/qat/qat_common/adf_cnv_dbgfs.h
new file mode 100644
index 000000000000..b02b0961c433
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_cnv_dbgfs.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2023 Intel Corporation */
+#ifndef ADF_CNV_DBG_H
+#define ADF_CNV_DBG_H
+
+struct adf_accel_dev;
+
+void adf_cnv_dbgfs_add(struct adf_accel_dev *accel_dev);
+void adf_cnv_dbgfs_rm(struct adf_accel_dev *accel_dev);
+
+#endif
diff --git a/drivers/crypto/intel/qat/qat_common/adf_common_drv.h b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
index 46dd81074166..18a382508542 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
@@ -96,6 +96,7 @@ int adf_send_admin_tim_sync(struct adf_accel_dev *accel_dev, u32 cnt);
 int adf_send_admin_hb_timer(struct adf_accel_dev *accel_dev, uint32_t ticks);
 int adf_get_fw_timestamp(struct adf_accel_dev *accel_dev, u64 *timestamp);
 int adf_get_pm_info(struct adf_accel_dev *accel_dev, dma_addr_t p_state_addr, size_t buff_size);
+int adf_get_cnv_stats(struct adf_accel_dev *accel_dev, u16 ae, u16 *err_cnt, u16 *latest_err);
 int adf_init_arb(struct adf_accel_dev *accel_dev);
 void adf_exit_arb(struct adf_accel_dev *accel_dev);
 void adf_update_ring_arb(struct adf_etr_ring_data *ring);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_dbgfs.c b/drivers/crypto/intel/qat/qat_common/adf_dbgfs.c
index 395bb493f20c..477efcc81a16 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_dbgfs.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_dbgfs.c
@@ -5,6 +5,7 @@
 #include "adf_accel_devices.h"
 #include "adf_cfg.h"
 #include "adf_common_drv.h"
+#include "adf_cnv_dbgfs.h"
 #include "adf_dbgfs.h"
 #include "adf_fw_counters.h"
 #include "adf_heartbeat_dbgfs.h"
@@ -64,6 +65,7 @@ void adf_dbgfs_add(struct adf_accel_dev *accel_dev)
 		adf_fw_counters_dbgfs_add(accel_dev);
 		adf_heartbeat_dbgfs_add(accel_dev);
 		adf_pm_dbgfs_add(accel_dev);
+		adf_cnv_dbgfs_add(accel_dev);
 	}
 }
 
@@ -77,6 +79,7 @@ void adf_dbgfs_rm(struct adf_accel_dev *accel_dev)
 		return;
 
 	if (!accel_dev->is_vf) {
+		adf_cnv_dbgfs_rm(accel_dev);
 		adf_pm_dbgfs_rm(accel_dev);
 		adf_heartbeat_dbgfs_rm(accel_dev);
 		adf_fw_counters_dbgfs_rm(accel_dev);
diff --git a/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h b/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h
index 2ebbec75d778..9e5ce419d875 100644
--- a/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h
+++ b/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h
@@ -19,6 +19,7 @@ enum icp_qat_fw_init_admin_cmd_id {
 	ICP_QAT_FW_DC_CHAIN_INIT = 11,
 	ICP_QAT_FW_HEARTBEAT_TIMER_SET = 13,
 	ICP_QAT_FW_TIMER_GET = 19,
+	ICP_QAT_FW_CNV_STATS_GET = 20,
 	ICP_QAT_FW_PM_STATE_CONFIG = 128,
 	ICP_QAT_FW_PM_INFO = 129,
 };
@@ -65,6 +66,10 @@ struct icp_qat_fw_init_admin_resp {
 			__u16 version_major_num;
 		};
 		__u32 extended_features;
+		struct {
+			__u16 error_count;
+			__u16 latest_error;
+		};
 	};
 	__u64 opaque_data;
 	union {

base-commit: 19a7effff1ad00af204b0ec09191771d5b1c95d3
-- 
2.41.0


Return-Path: <linux-crypto+bounces-3623-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 013988A8650
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Apr 2024 16:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53DE0B24FEB
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Apr 2024 14:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5C81448FA;
	Wed, 17 Apr 2024 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMPXo+y1"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7026F1411CE;
	Wed, 17 Apr 2024 14:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364882; cv=none; b=cKpcYYFNIwrNKiphc43nIZEoIESeq5x1IfJrREN1sLhVa/xKd25jURmnkzHIPl2RfV9V23ztyUf9N3yiDXwZh8d7hj4nX+SFE9f0fDhAS41IjnbHJYnv0nQCosBEqtbI+zacs7Fo3AGu/YeV5dUOoTW4M8K5ozmYbNxTnFmodHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364882; c=relaxed/simple;
	bh=42nPBUhu317W9899sUyQMhQxRfRgpykWHm5vShx/S2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=K1EnKA0mAaZnV7JvYI0xVPqA7qxGCk2bAndXeLBszj2fZeFLt3lNfnVVD4UpBM3MSFgpBm5nb6RYAaH86rzNria+3tVt+GvxoWJGMsdyIKRgNI5zMgXbCCM47cXaEvWIIUtF5Hc+ctwjPA3uiGMjYtsJGBIx+RxlKBbvZl9+Cuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMPXo+y1; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713364880; x=1744900880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=42nPBUhu317W9899sUyQMhQxRfRgpykWHm5vShx/S2A=;
  b=ZMPXo+y1YObYXz/TxR2Izkj1kT5ij3QP5AXl2ddPMJcw7t5jV2CIFIza
   m8cv9ot5mf1KlaRGNfQ/wNfVgxvVhg1+zHm17vmg+LRm9lUM6ITfHFdxz
   tQIclC63BwiSUJJfnK2oH0Na7duKBhUk11MiP4Uw0fUc8DU9ELvVNH5j6
   W63gjyekL2dXj35y6aDWVec/D9wBknk7B6toU93w3LDo5jkNoF6s7UDRc
   d2A+yvUHla+BtHQGC41cuXMrkiuHgvyDu/CXrJtJoRxJCVnugAraLN5By
   sdkecYaXs5XWkXudebaYlMw11K3JhdbZdMYIHpdsqTHE8xnglAGg83BvZ
   g==;
X-CSE-ConnectionGUID: tyzt8lLPQqapgPHaod5q/g==
X-CSE-MsgGUID: Do/q0NcjQLeQYTfCx8QbVw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8720137"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="8720137"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 07:41:20 -0700
X-CSE-ConnectionGUID: aYvWBiqzR6WAS29kWBQEQA==
X-CSE-MsgGUID: HHogimz3R9Wd36Z9PfueWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="22651822"
Received: from qat-server-archercity1.sh.intel.com ([10.67.111.115])
  by orviesa009.jf.intel.com with ESMTP; 17 Apr 2024 07:41:17 -0700
From: Xin Zeng <xin.zeng@intel.com>
To: herbert@gondor.apana.org.au,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	yishaih@nvidia.com,
	shameerali.kolothum.thodi@huawei.com,
	kevin.tian@intel.com
Cc: linux-crypto@vger.kernel.org,
	kvm@vger.kernel.org,
	qat-linux@intel.com,
	Xin Zeng <xin.zeng@intel.com>,
	Yahui Cao <yahui.cao@intel.com>
Subject: [PATCH v6 1/1] vfio/qat: Add vfio_pci driver for Intel QAT SR-IOV VF devices
Date: Wed, 17 Apr 2024 22:31:41 +0800
Message-Id: <20240417143141.1909824-2-xin.zeng@intel.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20240417143141.1909824-1-xin.zeng@intel.com>
References: <20240417143141.1909824-1-xin.zeng@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

Add vfio pci variant driver for Intel QAT SR-IOV VF devices. This driver
registers to the vfio subsystem through the interfaces exposed by the
susbsystem. It follows the live migration protocol v2 defined in
uapi/linux/vfio.h and interacts with Intel QAT PF driver through a set
of interfaces defined in qat/qat_mig_dev.h to support live migration of
Intel QAT VF devices.

The migration data of each Intel QAT GEN4 VF device is encapsulated into
a 4096 bytes block. The data consists of two parts.

The first is a pre-configured set of attributes of the VF being migrated,
which are only set when it is created. This can be migrated during pre-copy
stage and used for a device compatibility check.

The second is the VF state. This includes the required MMIO regions and
the shadow states maintained by the QAT PF driver. This part can only be
saved when the VF is fully quiesced and be migrated during stop-copy stage.

Both these 2 parts of data are saved in hierarchical structures including
a preamble section and several raw state sections.

When the pre-configured part of the migration data is fully retrieved from
user space, the preamble section are used to validate the correctness of
the data blocks and check the version compatibility. The raw state
sections are then used to do a device compatibility check.

When the device transits from RESUMING state, the VF states are extracted
from the raw state sections of the VF state part of the migration data and
then loaded into the device.

This version only covers migration for Intel QAT GEN4 VF devices.

Co-developed-by: Yahui Cao <yahui.cao@intel.com>
Signed-off-by: Yahui Cao <yahui.cao@intel.com>
Signed-off-by: Xin Zeng <xin.zeng@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 MAINTAINERS                   |   8 +
 drivers/vfio/pci/Kconfig      |   2 +
 drivers/vfio/pci/Makefile     |   2 +
 drivers/vfio/pci/qat/Kconfig  |  12 +
 drivers/vfio/pci/qat/Makefile |   3 +
 drivers/vfio/pci/qat/main.c   | 679 ++++++++++++++++++++++++++++++++++
 6 files changed, 706 insertions(+)
 create mode 100644 drivers/vfio/pci/qat/Kconfig
 create mode 100644 drivers/vfio/pci/qat/Makefile
 create mode 100644 drivers/vfio/pci/qat/main.c

diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947fb080..929cf84ff852 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23241,6 +23241,14 @@ L:	kvm@vger.kernel.org
 S:	Maintained
 F:	drivers/vfio/platform/
 
+VFIO QAT PCI DRIVER
+M:	Xin Zeng <xin.zeng@intel.com>
+M:	Giovanni Cabiddu <giovanni.cabiddu@intel.com>
+L:	kvm@vger.kernel.org
+L:	qat-linux@intel.com
+S:	Supported
+F:	drivers/vfio/pci/qat/
+
 VFIO VIRTIO PCI DRIVER
 M:	Yishai Hadas <yishaih@nvidia.com>
 L:	kvm@vger.kernel.org
diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 15821a2d77d2..bf50ffa10bde 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -69,4 +69,6 @@ source "drivers/vfio/pci/virtio/Kconfig"
 
 source "drivers/vfio/pci/nvgrace-gpu/Kconfig"
 
+source "drivers/vfio/pci/qat/Kconfig"
+
 endmenu
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index ce7a61f1d912..cf00c0a7e55c 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -17,3 +17,5 @@ obj-$(CONFIG_PDS_VFIO_PCI) += pds/
 obj-$(CONFIG_VIRTIO_VFIO_PCI) += virtio/
 
 obj-$(CONFIG_NVGRACE_GPU_VFIO_PCI) += nvgrace-gpu/
+
+obj-$(CONFIG_QAT_VFIO_PCI) += qat/
diff --git a/drivers/vfio/pci/qat/Kconfig b/drivers/vfio/pci/qat/Kconfig
new file mode 100644
index 000000000000..bf52cfa4b595
--- /dev/null
+++ b/drivers/vfio/pci/qat/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config QAT_VFIO_PCI
+	tristate "VFIO support for QAT VF PCI devices"
+	select VFIO_PCI_CORE
+	depends on CRYPTO_DEV_QAT_4XXX
+	help
+	  This provides migration support for Intel(R) QAT Virtual Function
+	  using the VFIO framework.
+
+	  To compile this as a module, choose M here: the module
+	  will be called qat_vfio_pci. If you don't know what to do here,
+	  say N.
diff --git a/drivers/vfio/pci/qat/Makefile b/drivers/vfio/pci/qat/Makefile
new file mode 100644
index 000000000000..5fe5c4ec19d3
--- /dev/null
+++ b/drivers/vfio/pci/qat/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_QAT_VFIO_PCI) += qat_vfio_pci.o
+qat_vfio_pci-y := main.o
diff --git a/drivers/vfio/pci/qat/main.c b/drivers/vfio/pci/qat/main.c
new file mode 100644
index 000000000000..041552ddce5d
--- /dev/null
+++ b/drivers/vfio/pci/qat/main.c
@@ -0,0 +1,679 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024 Intel Corporation */
+
+#include <linux/anon_inodes.h>
+#include <linux/container_of.h>
+#include <linux/device.h>
+#include <linux/file.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/sizes.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/vfio_pci_core.h>
+#include <linux/qat/qat_mig_dev.h>
+
+struct qat_vf_migration_file {
+	struct file *filp;
+	/* protects migration region context */
+	struct mutex lock;
+	bool disabled;
+	struct qat_vf_core_device *qat_vdev;
+	ssize_t filled_size;
+};
+
+struct qat_vf_core_device {
+	struct vfio_pci_core_device core_device;
+	struct qat_mig_dev *mdev;
+	/* protects migration state */
+	struct mutex state_mutex;
+	enum vfio_device_mig_state mig_state;
+	struct qat_vf_migration_file *resuming_migf;
+	struct qat_vf_migration_file *saving_migf;
+};
+
+static int qat_vf_pci_open_device(struct vfio_device *core_vdev)
+{
+	struct qat_vf_core_device *qat_vdev =
+		container_of(core_vdev, struct qat_vf_core_device,
+			     core_device.vdev);
+	struct vfio_pci_core_device *vdev = &qat_vdev->core_device;
+	int ret;
+
+	ret = vfio_pci_core_enable(vdev);
+	if (ret)
+		return ret;
+
+	ret = qat_vfmig_open(qat_vdev->mdev);
+	if (ret) {
+		vfio_pci_core_disable(vdev);
+		return ret;
+	}
+	qat_vdev->mig_state = VFIO_DEVICE_STATE_RUNNING;
+
+	vfio_pci_core_finish_enable(vdev);
+
+	return 0;
+}
+
+static void qat_vf_disable_fd(struct qat_vf_migration_file *migf)
+{
+	mutex_lock(&migf->lock);
+	migf->disabled = true;
+	migf->filp->f_pos = 0;
+	migf->filled_size = 0;
+	mutex_unlock(&migf->lock);
+}
+
+static void qat_vf_disable_fds(struct qat_vf_core_device *qat_vdev)
+{
+	if (qat_vdev->resuming_migf) {
+		qat_vf_disable_fd(qat_vdev->resuming_migf);
+		fput(qat_vdev->resuming_migf->filp);
+		qat_vdev->resuming_migf = NULL;
+	}
+
+	if (qat_vdev->saving_migf) {
+		qat_vf_disable_fd(qat_vdev->saving_migf);
+		fput(qat_vdev->saving_migf->filp);
+		qat_vdev->saving_migf = NULL;
+	}
+}
+
+static void qat_vf_pci_close_device(struct vfio_device *core_vdev)
+{
+	struct qat_vf_core_device *qat_vdev = container_of(core_vdev,
+			struct qat_vf_core_device, core_device.vdev);
+
+	qat_vfmig_close(qat_vdev->mdev);
+	qat_vf_disable_fds(qat_vdev);
+	vfio_pci_core_close_device(core_vdev);
+}
+
+static long qat_vf_precopy_ioctl(struct file *filp, unsigned int cmd,
+				 unsigned long arg)
+{
+	struct qat_vf_migration_file *migf = filp->private_data;
+	struct qat_vf_core_device *qat_vdev = migf->qat_vdev;
+	struct qat_mig_dev *mig_dev = qat_vdev->mdev;
+	struct vfio_precopy_info info;
+	loff_t *pos = &filp->f_pos;
+	unsigned long minsz;
+	int ret = 0;
+
+	if (cmd != VFIO_MIG_GET_PRECOPY_INFO)
+		return -ENOTTY;
+
+	minsz = offsetofend(struct vfio_precopy_info, dirty_bytes);
+
+	if (copy_from_user(&info, (void __user *)arg, minsz))
+		return -EFAULT;
+	if (info.argsz < minsz)
+		return -EINVAL;
+
+	mutex_lock(&qat_vdev->state_mutex);
+	if (qat_vdev->mig_state != VFIO_DEVICE_STATE_PRE_COPY &&
+	    qat_vdev->mig_state != VFIO_DEVICE_STATE_PRE_COPY_P2P) {
+		mutex_unlock(&qat_vdev->state_mutex);
+		return -EINVAL;
+	}
+
+	mutex_lock(&migf->lock);
+	if (migf->disabled) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (*pos > mig_dev->setup_size) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	info.dirty_bytes = 0;
+	info.initial_bytes = mig_dev->setup_size - *pos;
+
+out:
+	mutex_unlock(&migf->lock);
+	mutex_unlock(&qat_vdev->state_mutex);
+	if (ret)
+		return ret;
+	return copy_to_user((void __user *)arg, &info, minsz) ? -EFAULT : 0;
+}
+
+static ssize_t qat_vf_save_read(struct file *filp, char __user *buf,
+				size_t len, loff_t *pos)
+{
+	struct qat_vf_migration_file *migf = filp->private_data;
+	struct qat_mig_dev *mig_dev = migf->qat_vdev->mdev;
+	ssize_t done = 0;
+	loff_t *offs;
+	int ret;
+
+	if (pos)
+		return -ESPIPE;
+	offs = &filp->f_pos;
+
+	mutex_lock(&migf->lock);
+	if (*offs > migf->filled_size || *offs < 0) {
+		done = -EINVAL;
+		goto out_unlock;
+	}
+
+	if (migf->disabled) {
+		done = -ENODEV;
+		goto out_unlock;
+	}
+
+	len = min_t(size_t, migf->filled_size - *offs, len);
+	if (len) {
+		ret = copy_to_user(buf, mig_dev->state + *offs, len);
+		if (ret) {
+			done = -EFAULT;
+			goto out_unlock;
+		}
+		*offs += len;
+		done = len;
+	}
+
+out_unlock:
+	mutex_unlock(&migf->lock);
+	return done;
+}
+
+static int qat_vf_release_file(struct inode *inode, struct file *filp)
+{
+	struct qat_vf_migration_file *migf = filp->private_data;
+
+	qat_vf_disable_fd(migf);
+	mutex_destroy(&migf->lock);
+	kfree(migf);
+
+	return 0;
+}
+
+static const struct file_operations qat_vf_save_fops = {
+	.owner = THIS_MODULE,
+	.read = qat_vf_save_read,
+	.unlocked_ioctl = qat_vf_precopy_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
+	.release = qat_vf_release_file,
+	.llseek = no_llseek,
+};
+
+static int qat_vf_save_state(struct qat_vf_core_device *qat_vdev,
+			     struct qat_vf_migration_file *migf)
+{
+	int ret;
+
+	ret = qat_vfmig_save_state(qat_vdev->mdev);
+	if (ret)
+		return ret;
+	migf->filled_size = qat_vdev->mdev->state_size;
+
+	return 0;
+}
+
+static int qat_vf_save_setup(struct qat_vf_core_device *qat_vdev,
+			     struct qat_vf_migration_file *migf)
+{
+	int ret;
+
+	ret = qat_vfmig_save_setup(qat_vdev->mdev);
+	if (ret)
+		return ret;
+	migf->filled_size = qat_vdev->mdev->setup_size;
+
+	return 0;
+}
+
+/*
+ * Allocate a file handler for user space and then save the migration data for
+ * the device being migrated. If this is called in the pre-copy stage, save the
+ * pre-configured device data. Otherwise, if this is called in the stop-copy
+ * stage, save the device state. In both cases, update the data size which can
+ * then be read from user space.
+ */
+static struct qat_vf_migration_file *
+qat_vf_save_device_data(struct qat_vf_core_device *qat_vdev, bool pre_copy)
+{
+	struct qat_vf_migration_file *migf;
+	int ret;
+
+	migf = kzalloc(sizeof(*migf), GFP_KERNEL);
+	if (!migf)
+		return ERR_PTR(-ENOMEM);
+
+	migf->filp = anon_inode_getfile("qat_vf_mig", &qat_vf_save_fops,
+					migf, O_RDONLY);
+	ret = PTR_ERR_OR_ZERO(migf->filp);
+	if (ret) {
+		kfree(migf);
+		return ERR_PTR(ret);
+	}
+
+	stream_open(migf->filp->f_inode, migf->filp);
+	mutex_init(&migf->lock);
+
+	if (pre_copy)
+		ret = qat_vf_save_setup(qat_vdev, migf);
+	else
+		ret = qat_vf_save_state(qat_vdev, migf);
+	if (ret) {
+		fput(migf->filp);
+		return ERR_PTR(ret);
+	}
+
+	migf->qat_vdev = qat_vdev;
+
+	return migf;
+}
+
+static ssize_t qat_vf_resume_write(struct file *filp, const char __user *buf,
+				   size_t len, loff_t *pos)
+{
+	struct qat_vf_migration_file *migf = filp->private_data;
+	struct qat_mig_dev *mig_dev = migf->qat_vdev->mdev;
+	loff_t end, *offs;
+	ssize_t done = 0;
+	int ret;
+
+	if (pos)
+		return -ESPIPE;
+	offs = &filp->f_pos;
+
+	if (*offs < 0 ||
+	    check_add_overflow((loff_t)len, *offs, &end))
+		return -EOVERFLOW;
+
+	if (end > mig_dev->state_size)
+		return -ENOMEM;
+
+	mutex_lock(&migf->lock);
+	if (migf->disabled) {
+		done = -ENODEV;
+		goto out_unlock;
+	}
+
+	ret = copy_from_user(mig_dev->state + *offs, buf, len);
+	if (ret) {
+		done = -EFAULT;
+		goto out_unlock;
+	}
+	*offs += len;
+	migf->filled_size += len;
+
+	/*
+	 * Load the pre-configured device data first to check if the target
+	 * device is compatible with the source device.
+	 */
+	ret = qat_vfmig_load_setup(mig_dev, migf->filled_size);
+	if (ret && ret != -EAGAIN) {
+		done = ret;
+		goto out_unlock;
+	}
+	done = len;
+
+out_unlock:
+	mutex_unlock(&migf->lock);
+	return done;
+}
+
+static const struct file_operations qat_vf_resume_fops = {
+	.owner = THIS_MODULE,
+	.write = qat_vf_resume_write,
+	.release = qat_vf_release_file,
+	.llseek = no_llseek,
+};
+
+static struct qat_vf_migration_file *
+qat_vf_resume_device_data(struct qat_vf_core_device *qat_vdev)
+{
+	struct qat_vf_migration_file *migf;
+	int ret;
+
+	migf = kzalloc(sizeof(*migf), GFP_KERNEL);
+	if (!migf)
+		return ERR_PTR(-ENOMEM);
+
+	migf->filp = anon_inode_getfile("qat_vf_mig", &qat_vf_resume_fops, migf, O_WRONLY);
+	ret = PTR_ERR_OR_ZERO(migf->filp);
+	if (ret) {
+		kfree(migf);
+		return ERR_PTR(ret);
+	}
+
+	migf->qat_vdev = qat_vdev;
+	migf->filled_size = 0;
+	stream_open(migf->filp->f_inode, migf->filp);
+	mutex_init(&migf->lock);
+
+	return migf;
+}
+
+static int qat_vf_load_device_data(struct qat_vf_core_device *qat_vdev)
+{
+	return qat_vfmig_load_state(qat_vdev->mdev);
+}
+
+static struct file *qat_vf_pci_step_device_state(struct qat_vf_core_device *qat_vdev, u32 new)
+{
+	u32 cur = qat_vdev->mig_state;
+	int ret;
+
+	/*
+	 * As the device is not capable of just stopping P2P DMAs, suspend the
+	 * device completely once any of the P2P states are reached.
+	 * On the opposite direction, resume the device after transiting from
+	 * the P2P state.
+	 */
+	if ((cur == VFIO_DEVICE_STATE_RUNNING && new == VFIO_DEVICE_STATE_RUNNING_P2P) ||
+	    (cur == VFIO_DEVICE_STATE_PRE_COPY && new == VFIO_DEVICE_STATE_PRE_COPY_P2P)) {
+		ret = qat_vfmig_suspend(qat_vdev->mdev);
+		if (ret)
+			return ERR_PTR(ret);
+		return NULL;
+	}
+
+	if ((cur == VFIO_DEVICE_STATE_RUNNING_P2P && new == VFIO_DEVICE_STATE_RUNNING) ||
+	    (cur == VFIO_DEVICE_STATE_PRE_COPY_P2P && new == VFIO_DEVICE_STATE_PRE_COPY)) {
+		qat_vfmig_resume(qat_vdev->mdev);
+		return NULL;
+	}
+
+	if ((cur == VFIO_DEVICE_STATE_RUNNING_P2P && new == VFIO_DEVICE_STATE_STOP) ||
+	    (cur == VFIO_DEVICE_STATE_STOP && new == VFIO_DEVICE_STATE_RUNNING_P2P))
+		return NULL;
+
+	if (cur == VFIO_DEVICE_STATE_STOP && new == VFIO_DEVICE_STATE_STOP_COPY) {
+		struct qat_vf_migration_file *migf;
+
+		migf = qat_vf_save_device_data(qat_vdev, false);
+		if (IS_ERR(migf))
+			return ERR_CAST(migf);
+		get_file(migf->filp);
+		qat_vdev->saving_migf = migf;
+		return migf->filp;
+	}
+
+	if (cur == VFIO_DEVICE_STATE_STOP && new == VFIO_DEVICE_STATE_RESUMING) {
+		struct qat_vf_migration_file *migf;
+
+		migf = qat_vf_resume_device_data(qat_vdev);
+		if (IS_ERR(migf))
+			return ERR_CAST(migf);
+		get_file(migf->filp);
+		qat_vdev->resuming_migf = migf;
+		return migf->filp;
+	}
+
+	if ((cur == VFIO_DEVICE_STATE_STOP_COPY && new == VFIO_DEVICE_STATE_STOP) ||
+	    (cur == VFIO_DEVICE_STATE_PRE_COPY && new == VFIO_DEVICE_STATE_RUNNING) ||
+	    (cur == VFIO_DEVICE_STATE_PRE_COPY_P2P && new == VFIO_DEVICE_STATE_RUNNING_P2P)) {
+		qat_vf_disable_fds(qat_vdev);
+		return NULL;
+	}
+
+	if ((cur == VFIO_DEVICE_STATE_RUNNING && new == VFIO_DEVICE_STATE_PRE_COPY) ||
+	    (cur == VFIO_DEVICE_STATE_RUNNING_P2P && new == VFIO_DEVICE_STATE_PRE_COPY_P2P)) {
+		struct qat_vf_migration_file *migf;
+
+		migf = qat_vf_save_device_data(qat_vdev, true);
+		if (IS_ERR(migf))
+			return ERR_CAST(migf);
+		get_file(migf->filp);
+		qat_vdev->saving_migf = migf;
+		return migf->filp;
+	}
+
+	if (cur == VFIO_DEVICE_STATE_PRE_COPY_P2P && new == VFIO_DEVICE_STATE_STOP_COPY) {
+		struct qat_vf_migration_file *migf = qat_vdev->saving_migf;
+
+		if (!migf)
+			return ERR_PTR(-EINVAL);
+		ret = qat_vf_save_state(qat_vdev, migf);
+		if (ret)
+			return ERR_PTR(ret);
+		return NULL;
+	}
+
+	if (cur == VFIO_DEVICE_STATE_RESUMING && new == VFIO_DEVICE_STATE_STOP) {
+		ret = qat_vf_load_device_data(qat_vdev);
+		if (ret)
+			return ERR_PTR(ret);
+
+		qat_vf_disable_fds(qat_vdev);
+		return NULL;
+	}
+
+	/* vfio_mig_get_next_state() does not use arcs other than the above */
+	WARN_ON(true);
+	return ERR_PTR(-EINVAL);
+}
+
+static void qat_vf_reset_done(struct qat_vf_core_device *qat_vdev)
+{
+	qat_vdev->mig_state = VFIO_DEVICE_STATE_RUNNING;
+	qat_vfmig_reset(qat_vdev->mdev);
+	qat_vf_disable_fds(qat_vdev);
+}
+
+static struct file *qat_vf_pci_set_device_state(struct vfio_device *vdev,
+						enum vfio_device_mig_state new_state)
+{
+	struct qat_vf_core_device *qat_vdev = container_of(vdev,
+			struct qat_vf_core_device, core_device.vdev);
+	enum vfio_device_mig_state next_state;
+	struct file *res = NULL;
+	int ret;
+
+	mutex_lock(&qat_vdev->state_mutex);
+	while (new_state != qat_vdev->mig_state) {
+		ret = vfio_mig_get_next_state(vdev, qat_vdev->mig_state,
+					      new_state, &next_state);
+		if (ret) {
+			res = ERR_PTR(ret);
+			break;
+		}
+		res = qat_vf_pci_step_device_state(qat_vdev, next_state);
+		if (IS_ERR(res))
+			break;
+		qat_vdev->mig_state = next_state;
+		if (WARN_ON(res && new_state != qat_vdev->mig_state)) {
+			fput(res);
+			res = ERR_PTR(-EINVAL);
+			break;
+		}
+	}
+	mutex_unlock(&qat_vdev->state_mutex);
+
+	return res;
+}
+
+static int qat_vf_pci_get_device_state(struct vfio_device *vdev,
+				       enum vfio_device_mig_state *curr_state)
+{
+	struct qat_vf_core_device *qat_vdev = container_of(vdev,
+			struct qat_vf_core_device, core_device.vdev);
+
+	mutex_lock(&qat_vdev->state_mutex);
+	*curr_state = qat_vdev->mig_state;
+	mutex_unlock(&qat_vdev->state_mutex);
+
+	return 0;
+}
+
+static int qat_vf_pci_get_data_size(struct vfio_device *vdev,
+				    unsigned long *stop_copy_length)
+{
+	struct qat_vf_core_device *qat_vdev = container_of(vdev,
+			struct qat_vf_core_device, core_device.vdev);
+
+	mutex_lock(&qat_vdev->state_mutex);
+	*stop_copy_length = qat_vdev->mdev->state_size;
+	mutex_unlock(&qat_vdev->state_mutex);
+
+	return 0;
+}
+
+static const struct vfio_migration_ops qat_vf_pci_mig_ops = {
+	.migration_set_state = qat_vf_pci_set_device_state,
+	.migration_get_state = qat_vf_pci_get_device_state,
+	.migration_get_data_size = qat_vf_pci_get_data_size,
+};
+
+static void qat_vf_pci_release_dev(struct vfio_device *core_vdev)
+{
+	struct qat_vf_core_device *qat_vdev = container_of(core_vdev,
+			struct qat_vf_core_device, core_device.vdev);
+
+	qat_vfmig_cleanup(qat_vdev->mdev);
+	qat_vfmig_destroy(qat_vdev->mdev);
+	mutex_destroy(&qat_vdev->state_mutex);
+	vfio_pci_core_release_dev(core_vdev);
+}
+
+static int qat_vf_pci_init_dev(struct vfio_device *core_vdev)
+{
+	struct qat_vf_core_device *qat_vdev = container_of(core_vdev,
+			struct qat_vf_core_device, core_device.vdev);
+	struct qat_mig_dev *mdev;
+	struct pci_dev *parent;
+	int ret, vf_id;
+
+	core_vdev->migration_flags = VFIO_MIGRATION_STOP_COPY | VFIO_MIGRATION_P2P |
+				     VFIO_MIGRATION_PRE_COPY;
+	core_vdev->mig_ops = &qat_vf_pci_mig_ops;
+
+	ret = vfio_pci_core_init_dev(core_vdev);
+	if (ret)
+		return ret;
+
+	mutex_init(&qat_vdev->state_mutex);
+
+	parent = pci_physfn(qat_vdev->core_device.pdev);
+	vf_id = pci_iov_vf_id(qat_vdev->core_device.pdev);
+	if (vf_id < 0) {
+		ret = -ENODEV;
+		goto err_rel;
+	}
+
+	mdev = qat_vfmig_create(parent, vf_id);
+	if (IS_ERR(mdev)) {
+		ret = PTR_ERR(mdev);
+		goto err_rel;
+	}
+
+	ret = qat_vfmig_init(mdev);
+	if (ret)
+		goto err_destroy;
+
+	qat_vdev->mdev = mdev;
+
+	return 0;
+
+err_destroy:
+	qat_vfmig_destroy(mdev);
+err_rel:
+	vfio_pci_core_release_dev(core_vdev);
+	return ret;
+}
+
+static const struct vfio_device_ops qat_vf_pci_ops = {
+	.name = "qat-vf-vfio-pci",
+	.init = qat_vf_pci_init_dev,
+	.release = qat_vf_pci_release_dev,
+	.open_device = qat_vf_pci_open_device,
+	.close_device = qat_vf_pci_close_device,
+	.ioctl = vfio_pci_core_ioctl,
+	.read = vfio_pci_core_read,
+	.write = vfio_pci_core_write,
+	.mmap = vfio_pci_core_mmap,
+	.request = vfio_pci_core_request,
+	.match = vfio_pci_core_match,
+	.bind_iommufd = vfio_iommufd_physical_bind,
+	.unbind_iommufd = vfio_iommufd_physical_unbind,
+	.attach_ioas = vfio_iommufd_physical_attach_ioas,
+	.detach_ioas = vfio_iommufd_physical_detach_ioas,
+};
+
+static struct qat_vf_core_device *qat_vf_drvdata(struct pci_dev *pdev)
+{
+	struct vfio_pci_core_device *core_device = pci_get_drvdata(pdev);
+
+	return container_of(core_device, struct qat_vf_core_device, core_device);
+}
+
+static void qat_vf_pci_aer_reset_done(struct pci_dev *pdev)
+{
+	struct qat_vf_core_device *qat_vdev = qat_vf_drvdata(pdev);
+
+	if (!qat_vdev->mdev)
+		return;
+
+	mutex_lock(&qat_vdev->state_mutex);
+	qat_vf_reset_done(qat_vdev);
+	mutex_unlock(&qat_vdev->state_mutex);
+}
+
+static int
+qat_vf_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct qat_vf_core_device *qat_vdev;
+	int ret;
+
+	qat_vdev = vfio_alloc_device(qat_vf_core_device, core_device.vdev, dev, &qat_vf_pci_ops);
+	if (IS_ERR(qat_vdev))
+		return PTR_ERR(qat_vdev);
+
+	pci_set_drvdata(pdev, &qat_vdev->core_device);
+	ret = vfio_pci_core_register_device(&qat_vdev->core_device);
+	if (ret)
+		goto out_put_device;
+
+	return 0;
+
+out_put_device:
+	vfio_put_device(&qat_vdev->core_device.vdev);
+	return ret;
+}
+
+static void qat_vf_vfio_pci_remove(struct pci_dev *pdev)
+{
+	struct qat_vf_core_device *qat_vdev = qat_vf_drvdata(pdev);
+
+	vfio_pci_core_unregister_device(&qat_vdev->core_device);
+	vfio_put_device(&qat_vdev->core_device.vdev);
+}
+
+static const struct pci_device_id qat_vf_vfio_pci_table[] = {
+	/* Intel QAT GEN4 4xxx VF device */
+	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, 0x4941) },
+	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, 0x4943) },
+	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, 0x4945) },
+	{}
+};
+MODULE_DEVICE_TABLE(pci, qat_vf_vfio_pci_table);
+
+static const struct pci_error_handlers qat_vf_err_handlers = {
+	.reset_done = qat_vf_pci_aer_reset_done,
+	.error_detected = vfio_pci_core_aer_err_detected,
+};
+
+static struct pci_driver qat_vf_vfio_pci_driver = {
+	.name = "qat_vfio_pci",
+	.id_table = qat_vf_vfio_pci_table,
+	.probe = qat_vf_vfio_pci_probe,
+	.remove = qat_vf_vfio_pci_remove,
+	.err_handler = &qat_vf_err_handlers,
+	.driver_managed_dma = true,
+};
+module_pci_driver(qat_vf_vfio_pci_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Xin Zeng <xin.zeng@intel.com>");
+MODULE_DESCRIPTION("QAT VFIO PCI - VFIO PCI driver with live migration support for Intel(R) QAT GEN4 device family");
+MODULE_IMPORT_NS(CRYPTO_QAT);
-- 
2.18.2



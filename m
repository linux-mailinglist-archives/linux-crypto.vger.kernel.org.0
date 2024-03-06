Return-Path: <linux-crypto+bounces-2541-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5639E87387C
	for <lists+linux-crypto@lfdr.de>; Wed,  6 Mar 2024 15:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC7C2B21122
	for <lists+linux-crypto@lfdr.de>; Wed,  6 Mar 2024 14:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DFE13328D;
	Wed,  6 Mar 2024 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fjdq3rZx"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97560132C37;
	Wed,  6 Mar 2024 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709734091; cv=none; b=jKkdBnStgwWW9MfqLTfJ57gs8xPt/cbdm6SV4jTyCX2w+ShNR8TkZTXm3Mr54GxdXyCy8UN83ivvUoKZbtdYk7gjNseVxyFPQaTq17qTxlfxMkOAZ0OufbJBVgfIBFM6DMEmiIjJhre14D9TvUVU5q1JMbJxNLqlTaHoev7MCXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709734091; c=relaxed/simple;
	bh=fxYw3EC/mCKqJp55F9v+ErT3ot8Wli69YokWirH5aeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jsp4iLSFHIgcK3iYtzxI5Bfy9OLtl3uI3uVKgqT/p5NRMS3Y0dolhgxm9FvaBkSgYn4x1yHo5+pGzO1RwcXDfRTdwvoOPWq37Uea0IkcB9CepwE04nuAtXfnQJZc32H1Zm7fjAar3mBrYE5iaFBuHAR9ia6lCA0xviHkXuaTBdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fjdq3rZx; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709734090; x=1741270090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=fxYw3EC/mCKqJp55F9v+ErT3ot8Wli69YokWirH5aeQ=;
  b=Fjdq3rZxcVqO+zGr8xUc4uqVgvnWYHmhE1wpHwBSdGlhlCyYcO8gQo2d
   XLBrVFLkV8+ISNt+joNzvEHe3CboBvGkebZzIuV69rK5kErCnr2UACFNb
   w+8axclrnG+uqFWjq8dXLdwlaT1tAMy38kSaz7yAPd6m2jbSKIHHGoj1/
   NOFdFqipOm0VUyLAn7awWAY73Hj4MCA1IF44272EC8XrEObDZyky7GuuC
   OoFzaOY181hqU2u5pgl2arynxX2IHJZTNP8pBQe9iJSSwBQFEyx4KhxCK
   f8QFEBpsUYdqMP52RwSdVFVh9NWR2xgPabio2q2clkXWMla2Yt2/pdPOv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="15490469"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="15490469"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 06:08:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="10192202"
Received: from qat-server-archercity1.sh.intel.com ([10.67.111.115])
  by orviesa007.jf.intel.com with ESMTP; 06 Mar 2024 06:08:06 -0800
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
Subject: [PATCH v5 10/10] vfio/qat: Add vfio_pci driver for Intel QAT VF devices
Date: Wed,  6 Mar 2024 21:58:55 +0800
Message-Id: <20240306135855.4123535-11-xin.zeng@intel.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20240306135855.4123535-1-xin.zeng@intel.com>
References: <20240306135855.4123535-1-xin.zeng@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

Add vfio pci driver for Intel QAT VF devices.

This driver uses vfio_pci_core to register to the VFIO subsystem. It
acts as a vfio agent and interacts with the QAT PF driver to implement
VF live migration.

Co-developed-by: Yahui Cao <yahui.cao@intel.com>
Signed-off-by: Yahui Cao <yahui.cao@intel.com>
Signed-off-by: Xin Zeng <xin.zeng@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 MAINTAINERS                   |   8 +
 drivers/vfio/pci/Kconfig      |   2 +
 drivers/vfio/pci/Makefile     |   2 +
 drivers/vfio/pci/qat/Kconfig  |  12 +
 drivers/vfio/pci/qat/Makefile |   3 +
 drivers/vfio/pci/qat/main.c   | 662 ++++++++++++++++++++++++++++++++++
 6 files changed, 689 insertions(+)
 create mode 100644 drivers/vfio/pci/qat/Kconfig
 create mode 100644 drivers/vfio/pci/qat/Makefile
 create mode 100644 drivers/vfio/pci/qat/main.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5a4051996f1e..ee7a9dde4b19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23105,6 +23105,14 @@ L:	kvm@vger.kernel.org
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
 VGA_SWITCHEROO
 R:	Lukas Wunner <lukas@wunner.de>
 S:	Maintained
diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 18c397df566d..6fb5fb1dfc16 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -67,4 +67,6 @@ source "drivers/vfio/pci/pds/Kconfig"
 
 source "drivers/vfio/pci/virtio/Kconfig"
 
+source "drivers/vfio/pci/qat/Kconfig"
+
 endmenu
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index 046139a4eca5..2e637ff66900 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -15,3 +15,5 @@ obj-$(CONFIG_HISI_ACC_VFIO_PCI) += hisilicon/
 obj-$(CONFIG_PDS_VFIO_PCI) += pds/
 
 obj-$(CONFIG_VIRTIO_VFIO_PCI) += virtio/
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
index 000000000000..713eb1ccfbfe
--- /dev/null
+++ b/drivers/vfio/pci/qat/main.c
@@ -0,0 +1,662 @@
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



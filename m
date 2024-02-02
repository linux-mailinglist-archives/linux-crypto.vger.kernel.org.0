Return-Path: <linux-crypto+bounces-1816-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4BA846E5F
	for <lists+linux-crypto@lfdr.de>; Fri,  2 Feb 2024 11:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84E7F294B75
	for <lists+linux-crypto@lfdr.de>; Fri,  2 Feb 2024 10:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6244E13A273;
	Fri,  2 Feb 2024 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gue1gwIm"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798E71AAB1
	for <linux-crypto@vger.kernel.org>; Fri,  2 Feb 2024 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871321; cv=none; b=bE9LaZwgjl+3jZ5TJQNQwRfMG5IKSyiLynY5es6y0YnXq5RuhiW9h1/TnaH3TLzwLWgl1WZVrZunclzNKqWkyLF9b1xWYRVWhYvBL7zEk7cSQ5oPNuWwWxCx+12dIXmVXasTWSTJ8a2mv1YO746t38n2XWPDn+idkOnumflRO/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871321; c=relaxed/simple;
	bh=4eVCZxNR793rgSi1WiVtKc0LjycNbDTrHhVkTPYPbns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=usGrIbS+MwBz7jc04tV33mrJawhStPFPo8YKkicOa3zYSOEPXVFXa/OsKuGYNwNeEql+ibjKPlEYjiNYQM9DvAr9ilYw79K9QD1aoGomlw8Iwm7JL4GOZIM5slLzPtFtj8ioWE4klmrTM/nRb6lRhhQPR1x35qZkGE4ZKziOxno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gue1gwIm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706871320; x=1738407320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4eVCZxNR793rgSi1WiVtKc0LjycNbDTrHhVkTPYPbns=;
  b=Gue1gwIm9gaF9broqtySugFOnvMQ8lBJzCkMVfHCHQ+W9GH1dTkBXAhD
   Y4xxlYViocT6S6oFUiQK+oC5VaICH7LItZNjsuqys/PM1F5AgYr7B9cM2
   qlBlKR6yXLek96ibKo61uDgTE7neILRBeREqa/KYXvMbVrv4JqASKGrr/
   dvEJFlmRgZiHHj/ujWjKBBupq1uFNbPrysrirG9LGquHMwqIBUoC6Ag3H
   wPhKJ2Wx279ot3b6R9Hv4UszZzxEB+XeYCE9SAEhIp/37v4t+Bk3K84kt
   yrab9180DClSG1nrCo/MBJ7LAOxAoxqPGuTSsLnaqEF8QPEkvlZiv674C
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="10787349"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="10787349"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 02:55:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="53637"
Received: from myep-mobl1.png.intel.com ([10.107.10.166])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 02:55:17 -0800
From: Mun Chun Yep <mun.chun.yep@intel.com>
To: herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org,
	qat-linux@intel.com,
	Damian Muszynski <damian.muszynski@intel.com>,
	Ahsan Atta <ahsan.atta@intel.com>,
	Markas Rapoportas <markas.rapoportas@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Mun Chun Yep <mun.chun.yep@intel.com>
Subject: [PATCH v2 7/9] crypto: qat - add auto reset on error
Date: Fri,  2 Feb 2024 18:53:22 +0800
Message-Id: <20240202105324.50391-8-mun.chun.yep@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202105324.50391-1-mun.chun.yep@intel.com>
References: <20240202105324.50391-1-mun.chun.yep@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Damian Muszynski <damian.muszynski@intel.com>

Expose the `auto_reset` sysfs attribute to configure the driver to reset
the device when a fatal error is detected.

When auto reset is enabled, the driver resets the device when it detects
either an heartbeat failure or a fatal error through an interrupt.

This patch is based on earlier work done by Shashank Gupta.

Signed-off-by: Damian Muszynski <damian.muszynski@intel.com>
Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
Reviewed-by: Markas Rapoportas <markas.rapoportas@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Mun Chun Yep <mun.chun.yep@intel.com>
---
 Documentation/ABI/testing/sysfs-driver-qat    | 20 ++++++++++
 .../intel/qat/qat_common/adf_accel_devices.h  |  1 +
 drivers/crypto/intel/qat/qat_common/adf_aer.c | 11 +++++-
 .../intel/qat/qat_common/adf_common_drv.h     |  1 +
 .../crypto/intel/qat/qat_common/adf_sysfs.c   | 37 +++++++++++++++++++
 5 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-qat b/Documentation/ABI/testing/sysfs-driver-qat
index bbf329cf0d67..6778f1fea874 100644
--- a/Documentation/ABI/testing/sysfs-driver-qat
+++ b/Documentation/ABI/testing/sysfs-driver-qat
@@ -141,3 +141,23 @@ Description:
 			64
 
 		This attribute is only available for qat_4xxx devices.
+
+What:		/sys/bus/pci/devices/<BDF>/qat/auto_reset
+Date:		March 2024
+KernelVersion:	6.8
+Contact:	qat-linux@intel.com
+Description:	(RW) Reports the current state of the autoreset feature
+		for a QAT device
+
+		Write to the attribute to enable or disable device auto reset.
+
+		Device auto reset is disabled by default.
+
+		The values are::
+
+		* 1/Yy/on: auto reset enabled. If the device encounters an
+		  unrecoverable error, it will be reset automatically.
+		* 0/Nn/off: auto reset disabled. If the device encounters an
+		  unrecoverable error, it will not be reset.
+
+		This attribute is only available for qat_4xxx devices.
diff --git a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
index 4a3c36aaa7ca..0f26aa976c8c 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
@@ -402,6 +402,7 @@ struct adf_accel_dev {
 	struct adf_error_counters ras_errors;
 	struct mutex state_lock; /* protect state of the device */
 	bool is_vf;
+	bool autoreset_on_error;
 	u32 accel_id;
 };
 #endif
diff --git a/drivers/crypto/intel/qat/qat_common/adf_aer.c b/drivers/crypto/intel/qat/qat_common/adf_aer.c
index cd273b31db0e..b3d4b6b99c65 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_aer.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_aer.c
@@ -204,6 +204,14 @@ const struct pci_error_handlers adf_err_handler = {
 };
 EXPORT_SYMBOL_GPL(adf_err_handler);
 
+int adf_dev_autoreset(struct adf_accel_dev *accel_dev)
+{
+	if (accel_dev->autoreset_on_error)
+		return adf_dev_aer_schedule_reset(accel_dev, ADF_DEV_RESET_ASYNC);
+
+	return 0;
+}
+
 static void adf_notify_fatal_error_worker(struct work_struct *work)
 {
 	struct adf_fatal_error_data *wq_data =
@@ -215,10 +223,11 @@ static void adf_notify_fatal_error_worker(struct work_struct *work)
 
 	if (!accel_dev->is_vf) {
 		/* Disable arbitration to stop processing of new requests */
-		if (hw_device->exit_arb)
+		if (accel_dev->autoreset_on_error && hw_device->exit_arb)
 			hw_device->exit_arb(accel_dev);
 		if (accel_dev->pf.vf_info)
 			adf_pf2vf_notify_fatal_error(accel_dev);
+		adf_dev_autoreset(accel_dev);
 	}
 
 	kfree(wq_data);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_common_drv.h b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
index 10891c9da6e7..57328249c89e 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
@@ -87,6 +87,7 @@ int adf_ae_stop(struct adf_accel_dev *accel_dev);
 extern const struct pci_error_handlers adf_err_handler;
 void adf_reset_sbr(struct adf_accel_dev *accel_dev);
 void adf_reset_flr(struct adf_accel_dev *accel_dev);
+int adf_dev_autoreset(struct adf_accel_dev *accel_dev);
 void adf_dev_restore(struct adf_accel_dev *accel_dev);
 int adf_init_aer(void);
 void adf_exit_aer(void);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_sysfs.c b/drivers/crypto/intel/qat/qat_common/adf_sysfs.c
index d450dad32c9e..4e7f70d4049d 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_sysfs.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_sysfs.c
@@ -204,6 +204,42 @@ static ssize_t pm_idle_enabled_store(struct device *dev, struct device_attribute
 }
 static DEVICE_ATTR_RW(pm_idle_enabled);
 
+static ssize_t auto_reset_show(struct device *dev, struct device_attribute *attr,
+			       char *buf)
+{
+	char *auto_reset;
+	struct adf_accel_dev *accel_dev;
+
+	accel_dev = adf_devmgr_pci_to_accel_dev(to_pci_dev(dev));
+	if (!accel_dev)
+		return -EINVAL;
+
+	auto_reset = accel_dev->autoreset_on_error ? "on" : "off";
+
+	return sysfs_emit(buf, "%s\n", auto_reset);
+}
+
+static ssize_t auto_reset_store(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct adf_accel_dev *accel_dev;
+	bool enabled = false;
+	int ret;
+
+	ret = kstrtobool(buf, &enabled);
+	if (ret)
+		return ret;
+
+	accel_dev = adf_devmgr_pci_to_accel_dev(to_pci_dev(dev));
+	if (!accel_dev)
+		return -EINVAL;
+
+	accel_dev->autoreset_on_error = enabled;
+
+	return count;
+}
+static DEVICE_ATTR_RW(auto_reset);
+
 static DEVICE_ATTR_RW(state);
 static DEVICE_ATTR_RW(cfg_services);
 
@@ -291,6 +327,7 @@ static struct attribute *qat_attrs[] = {
 	&dev_attr_pm_idle_enabled.attr,
 	&dev_attr_rp2srv.attr,
 	&dev_attr_num_rps.attr,
+	&dev_attr_auto_reset.attr,
 	NULL,
 };
 
-- 
2.34.1



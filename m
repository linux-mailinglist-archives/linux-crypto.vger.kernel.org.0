Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C6852A459
	for <lists+linux-crypto@lfdr.de>; Tue, 17 May 2022 16:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348493AbiEQOKQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 17 May 2022 10:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbiEQOKL (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 17 May 2022 10:10:11 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A222C3E0D0
        for <linux-crypto@vger.kernel.org>; Tue, 17 May 2022 07:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652796610; x=1684332610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0l8FealIKlrTBFy3+Xly5NGFuqQ4toqZrpjKyGX4Ipw=;
  b=ImodHS2rCPsMzYY4hVSbEH5RvzcarBfvUOYu4n+wFL3Y7aUFHcB5drfd
   Di7HhDQzzeC04A7TIPnbDPxMwe95V5MH6vtxbb4AjJdpKVyPB2OEYL7R2
   IFlqFKmDkokjAmga4Es1waKKM00F+mniklt/k2gP3ow8XqBdIamiUbxbL
   gHvfPPKCfuDFH3tdWcq5gOeymB+ATJ25TAXbrdYIp3QxkAAdKUtBKDFiG
   AL+NkudU2HmkIB+gX86kfF8mmHnJ5Bz+LW93XyN5aMeiyhAioJ4/L5b3u
   ooz+XJ3WDvYXS0H8Sras/qNuBbBjefNY8B/EPddNqKBwOtO7pl8YqQgXO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="268777768"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="268777768"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 07:10:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="816916433"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.76])
  by fmsmga006.fm.intel.com with ESMTP; 17 May 2022 07:10:07 -0700
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        vdronov@redhat.com, Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Tomasz Kowallik <tomaszx.kowalik@intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>
Subject: [PATCH 1/4] crypto: qat - expose device state through sysfs for 4xxx
Date:   Tue, 17 May 2022 15:09:59 +0100
Message-Id: <20220517141002.32385-2-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220517141002.32385-1-giovanni.cabiddu@intel.com>
References: <20220517141002.32385-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Expose the device state through an attribute in sysfs and allow to
change it. This is to stop and shutdown a QAT device in order to change
its configuration.

The state attribute has been added to a newly created `qat` attribute
group which will contain all _QAT specific_ attributes.

The logic that implements the sysfs entries is part of a new file,
adf_sysfs.c. This exposes an entry point to allow the driver to create
attributes.

The function that creates the sysfs attributes is called from the probe
function of the driver and not in the state machine init function to
allow the change of states even if the device is the down state.

In order to restore the device configuration between a transition from
down to up, the function that configures the devices has been abstracted
into the HW data structure.

The `state` attribute is only exposed for qat_4xxx devices.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Co-developed-by: Tomasz Kowallik <tomaszx.kowalik@intel.com>
Signed-off-by: Tomasz Kowallik <tomaszx.kowalik@intel.com>
Reviewed-by: Adam Guerin <adam.guerin@intel.com>
Reviewed-by: Fiona Trahe <fiona.trahe@intel.com>
Reviewed-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
---
 Documentation/ABI/testing/sysfs-driver-qat    |  21 ++++
 .../crypto/qat/qat_4xxx/adf_4xxx_hw_data.c    |   1 +
 .../crypto/qat/qat_4xxx/adf_4xxx_hw_data.h    |   1 +
 drivers/crypto/qat/qat_4xxx/adf_drv.c         |   6 +-
 drivers/crypto/qat/qat_common/Makefile        |   1 +
 .../crypto/qat/qat_common/adf_accel_devices.h |   1 +
 .../crypto/qat/qat_common/adf_common_drv.h    |   2 +
 drivers/crypto/qat/qat_common/adf_sysfs.c     | 119 ++++++++++++++++++
 8 files changed, 151 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-qat
 create mode 100644 drivers/crypto/qat/qat_common/adf_sysfs.c

diff --git a/Documentation/ABI/testing/sysfs-driver-qat b/Documentation/ABI/testing/sysfs-driver-qat
new file mode 100644
index 000000000000..0915253efaa3
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-qat
@@ -0,0 +1,21 @@
+What:		/sys/bus/pci/devices/<BDF>/qat/state
+Date:		June 2022
+KernelVersion:	5.19
+Contact:	qat-linux@intel.com
+Description:	Reports the current state of the QAT device and allows to
+		change it.
+
+		This attribute is RW.
+
+		Returned values:
+			up: the device is up and running
+			down: the device is down
+
+		Allowed values:
+			up: initialize and start the device
+			down: stop the device and bring it down
+
+		It is possible to transition the device from up to down only
+		if the device is up and vice versa.
+
+		This attribute is only available for qat_4xxx devices.
diff --git a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
index fb5970a68484..fda5f699ff57 100644
--- a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -357,6 +357,7 @@ void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data)
 	hw_data->ring_pair_reset = adf_gen4_ring_pair_reset;
 	hw_data->enable_pm = adf_gen4_enable_pm;
 	hw_data->handle_pm_interrupt = adf_gen4_handle_pm_interrupt;
+	hw_data->dev_config = adf_crypto_dev_config;
 
 	adf_gen4_init_hw_csr_ops(&hw_data->csr_ops);
 	adf_gen4_init_pf_pfvf_ops(&hw_data->pfvf_ops);
diff --git a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h
index 1034752845ca..9d49248931f6 100644
--- a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h
+++ b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h
@@ -70,5 +70,6 @@ enum icp_qat_4xxx_slice_mask {
 
 void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data);
 void adf_clean_hw_data_4xxx(struct adf_hw_device_data *hw_data);
+int adf_crypto_dev_config(struct adf_accel_dev *accel_dev);
 
 #endif
diff --git a/drivers/crypto/qat/qat_4xxx/adf_drv.c b/drivers/crypto/qat/qat_4xxx/adf_drv.c
index 181fa1c8b3c7..2f212561acc4 100644
--- a/drivers/crypto/qat/qat_4xxx/adf_drv.c
+++ b/drivers/crypto/qat/qat_4xxx/adf_drv.c
@@ -53,7 +53,7 @@ static int adf_cfg_dev_init(struct adf_accel_dev *accel_dev)
 	return 0;
 }
 
-static int adf_crypto_dev_config(struct adf_accel_dev *accel_dev)
+int adf_crypto_dev_config(struct adf_accel_dev *accel_dev)
 {
 	char key[ADF_CFG_MAX_KEY_LEN_IN_BYTES];
 	int banks = GET_MAX_BANKS(accel_dev);
@@ -289,6 +289,10 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto out_err_disable_aer;
 	}
 
+	ret = adf_sysfs_init(accel_dev);
+	if (ret)
+		goto out_err_disable_aer;
+
 	ret = adf_crypto_dev_config(accel_dev);
 	if (ret)
 		goto out_err_disable_aer;
diff --git a/drivers/crypto/qat/qat_common/Makefile b/drivers/crypto/qat/qat_common/Makefile
index 04f058acc4d3..80919cfcc29d 100644
--- a/drivers/crypto/qat/qat_common/Makefile
+++ b/drivers/crypto/qat/qat_common/Makefile
@@ -10,6 +10,7 @@ intel_qat-objs := adf_cfg.o \
 	adf_transport.o \
 	adf_admin.o \
 	adf_hw_arbiter.o \
+	adf_sysfs.o \
 	adf_gen2_hw_data.o \
 	adf_gen4_hw_data.o \
 	adf_gen4_pm.o \
diff --git a/drivers/crypto/qat/qat_common/adf_accel_devices.h b/drivers/crypto/qat/qat_common/adf_accel_devices.h
index ede6458c9dbf..0a55a4f34dcf 100644
--- a/drivers/crypto/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/qat/qat_common/adf_accel_devices.h
@@ -199,6 +199,7 @@ struct adf_hw_device_data {
 	char *(*uof_get_name)(struct adf_accel_dev *accel_dev, u32 obj_num);
 	u32 (*uof_get_num_objs)(void);
 	u32 (*uof_get_ae_mask)(struct adf_accel_dev *accel_dev, u32 obj_num);
+	int (*dev_config)(struct adf_accel_dev *accel_dev);
 	struct adf_pfvf_ops pfvf_ops;
 	struct adf_hw_csr_ops csr_ops;
 	const char *fw_name;
diff --git a/drivers/crypto/qat/qat_common/adf_common_drv.h b/drivers/crypto/qat/qat_common/adf_common_drv.h
index 0464fa257929..0f3031f9055d 100644
--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
@@ -132,6 +132,8 @@ void adf_vf_isr_resource_free(struct adf_accel_dev *accel_dev);
 
 int adf_pfvf_comms_disabled(struct adf_accel_dev *accel_dev);
 
+int adf_sysfs_init(struct adf_accel_dev *accel_dev);
+
 int qat_hal_init(struct adf_accel_dev *accel_dev);
 void qat_hal_deinit(struct icp_qat_fw_loader_handle *handle);
 int qat_hal_start(struct icp_qat_fw_loader_handle *handle);
diff --git a/drivers/crypto/qat/qat_common/adf_sysfs.c b/drivers/crypto/qat/qat_common/adf_sysfs.c
new file mode 100644
index 000000000000..8f47a5694dd7
--- /dev/null
+++ b/drivers/crypto/qat/qat_common/adf_sysfs.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2022 Intel Corporation */
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include "adf_accel_devices.h"
+#include "adf_cfg.h"
+#include "adf_common_drv.h"
+
+static const char * const state_operations[] = {
+	[DEV_DOWN] = "down",
+	[DEV_UP] = "up",
+};
+
+static ssize_t state_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct adf_accel_dev *accel_dev;
+	char *state;
+
+	accel_dev = adf_devmgr_pci_to_accel_dev(to_pci_dev(dev));
+	if (!accel_dev)
+		return -EINVAL;
+
+	state = adf_dev_started(accel_dev) ? "up" : "down";
+	return sysfs_emit(buf, "%s\n", state);
+}
+
+static ssize_t state_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct adf_accel_dev *accel_dev;
+	u32 accel_id;
+	int ret;
+
+	accel_dev = adf_devmgr_pci_to_accel_dev(to_pci_dev(dev));
+	if (!accel_dev)
+		return -EINVAL;
+
+	accel_id = accel_dev->accel_id;
+
+	if (adf_devmgr_in_reset(accel_dev) || adf_dev_in_use(accel_dev)) {
+		dev_info(dev, "Device qat_dev%d is busy\n", accel_id);
+		return -EBUSY;
+	}
+
+	ret = sysfs_match_string(state_operations, buf);
+	if (ret < 0)
+		return ret;
+
+	switch (ret) {
+	case DEV_DOWN:
+		if (!adf_dev_started(accel_dev)) {
+			dev_info(dev, "Device qat_dev%d already down\n",
+				 accel_id);
+			return -EINVAL;
+		}
+
+		dev_info(dev, "Stopping device qat_dev%d\n", accel_id);
+
+		adf_dev_stop(accel_dev);
+		adf_dev_shutdown(accel_dev);
+
+		break;
+	case DEV_UP:
+		if (adf_dev_started(accel_dev)) {
+			dev_info(dev, "Device qat_dev%d already up\n",
+				 accel_id);
+			return -EINVAL;
+		}
+
+		dev_info(dev, "Starting device qat_dev%d\n", accel_id);
+
+		ret = GET_HW_DATA(accel_dev)->dev_config(accel_dev);
+		if (!ret)
+			ret = adf_dev_init(accel_dev);
+		if (!ret)
+			ret = adf_dev_start(accel_dev);
+
+		if (ret < 0) {
+			dev_err(dev, "Failed to start device qat_dev%d\n",
+				accel_id);
+			adf_dev_stop(accel_dev);
+			adf_dev_shutdown(accel_dev);
+			return ret;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(state);
+
+static struct attribute *qat_attrs[] = {
+	&dev_attr_state.attr,
+	NULL,
+};
+
+static struct attribute_group qat_group = {
+	.attrs = qat_attrs,
+	.name = "qat",
+};
+
+int adf_sysfs_init(struct adf_accel_dev *accel_dev)
+{
+	int ret;
+
+	ret = devm_device_add_group(&GET_DEV(accel_dev), &qat_group);
+	if (ret) {
+		dev_err(&GET_DEV(accel_dev),
+			"Failed to create qat attribute group: %d\n", ret);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(adf_sysfs_init);
-- 
2.36.1


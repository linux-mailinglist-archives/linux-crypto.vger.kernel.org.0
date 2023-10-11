Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1055F7C5414
	for <lists+linux-crypto@lfdr.de>; Wed, 11 Oct 2023 14:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjJKMge (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 11 Oct 2023 08:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjJKMga (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 11 Oct 2023 08:36:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D7E91
        for <linux-crypto@vger.kernel.org>; Wed, 11 Oct 2023 05:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697027787; x=1728563787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v3qdF5Ac6Xrb0hleqPYrqlE7Jr/qxXCXFUi6I9MO07c=;
  b=NyMT7CU3DOlUUrehIIXmWyCQfGm4pnRfjM0I5Ag4yn0v4yv1NCzasnkk
   itLc7VGCO7Aa4IU//gutbwA2MUkd7LCdFw8sTQNhhP2u1xdTIlAlo5hGH
   MDxsIhsB68lwY7mbpEQtz+I4wKj7+ZdeuRxrpaA+z5vWPkwiUeUi2FQrZ
   XaZNusd3pcocRjM1PdoqKiq0bWMgKTM3f8zVzFAfjzEcewYM91d37VJ9i
   ZlVPkfTWbk8r36KUbBBR1zaszLlJ36pc8qNCesrDx4QUlxlg3wtZ1pNP3
   CanuYqkY7iyMf8HAUkoFXs6FQSLDJ2bd73m4Z6md+GMz6/BFkoxRtuPTD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="374992926"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="374992926"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 05:36:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="870124706"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="870124706"
Received: from r031s002_zp31l10c01.deacluster.intel.com (HELO localhost.localdomain) ([10.219.171.29])
  by fmsmga002.fm.intel.com with ESMTP; 11 Oct 2023 05:36:26 -0700
From:   Damian Muszynski <damian.muszynski@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Ciunas Bennett <ciunas.bennett@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Damian Muszynski <damian.muszynski@intel.com>
Subject: [PATCH 09/11] crypto: qat - add rate limiting sysfs interface
Date:   Wed, 11 Oct 2023 14:15:07 +0200
Message-ID: <20231011121934.45255-10-damian.muszynski@intel.com>
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

From: Ciunas Bennett <ciunas.bennett@intel.com>

Add an interface for the rate limiting feature which allows to add,
remove and modify a QAT SLA (Service Level Agreement).

This adds a new sysfs attribute group, `qat_rl`, which can be accessed
from /sys/bus/pci/devices/<BUS:DEV:FUNCTION> with the following
hierarchy:
    |-+ qat_rl
      |---- id  (RW) # SLA identifier
      |---- cir (RW) # Committed Information Rate
      |---- pir (RW) # Peak Information Rate
      |---- srv (RW) # Service to be rate limited
      |---- rp  (RW) (HEX) # Ring pairs to be rate limited
      |---- cap_rem  (RW)  # Remaining capability for a service
      |---- sla_op   (WO)  # Allows to perform an operation on an SLA

The API works by setting the appropriate RW attributes and then
issuing a command through the `sla_op`. For example, to create an SLA, a
user needs to input the necessary data into the attributes cir, pir, srv
and rp and then write into `sla_op` the command `add` to execute the
operation.
The API also provides `cap_rem` attribute to get information about
the remaining device capability within a certain service which is
required when setting an SLA.

Signed-off-by: Ciunas Bennett <ciunas.bennett@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Damian Muszynski <damian.muszynski@intel.com>
---
 Documentation/ABI/testing/sysfs-driver-qat_rl | 227 +++++++++
 drivers/crypto/intel/qat/qat_common/Makefile  |   1 +
 drivers/crypto/intel/qat/qat_common/adf_rl.c  |  10 +
 drivers/crypto/intel/qat/qat_common/adf_rl.h  |   7 +
 .../intel/qat/qat_common/adf_sysfs_rl.c       | 451 ++++++++++++++++++
 .../intel/qat/qat_common/adf_sysfs_rl.h       |  11 +
 6 files changed, 707 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-qat_rl
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_sysfs_rl.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_sysfs_rl.h

diff --git a/Documentation/ABI/testing/sysfs-driver-qat_rl b/Documentation/ABI/testing/sysfs-driver-qat_rl
new file mode 100644
index 000000000000..41e774cc8646
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-qat_rl
@@ -0,0 +1,227 @@
+What:		/sys/bus/pci/devices/<BDF>/qat_rl/sla_op
+Date:		January 2024
+KernelVersion:	6.7
+Contact:	qat-linux@intel.com
+Description:
+		(WO) This attribute is used to perform an operation on an SLA.
+		The supported operations are: add, update, rm, rm_all, and get.
+
+		Input values must be filled through the associated attribute in
+		this group before a write to this file.
+		If the operation completes successfully, the associated
+		attributes will be updated.
+		The associated attributes are: cir, pir, srv, rp, and id.
+
+		Supported operations:
+
+		* add: Creates a new SLA with the provided inputs from user.
+			* Inputs: cir, pir, srv, and rp
+			* Output: id
+
+		* get: Returns the configuration of the specified SLA in id attribute
+			* Inputs: id
+			* Outputs: cir, pir, srv, and rp
+
+		* update: Updates the SLA with new values set in the following attributes
+			* Inputs: id, cir, and pir
+
+		* rm: Removes the specified SLA in the id attribute.
+			* Inputs: id
+
+		* rm_all: Removes all the configured SLAs.
+			* Inputs: None
+
+		This attribute is only available for qat_4xxx devices.
+
+What:		/sys/bus/pci/devices/<BDF>/qat_rl/rp
+Date:		January 2024
+KernelVersion:	6.7
+Contact:	qat-linux@intel.com
+Description:
+		(RW) When read, reports the current assigned ring pairs for the
+		queried SLA.
+		When wrote to, configures the ring pairs associated to a new SLA.
+
+		The value is a 64-bit bit mask and is written/displayed in hex.
+		Each bit of this mask represents a single ring pair i.e.,
+		bit 1 == ring pair id 0; bit 3 == ring pair id 2.
+
+		Selected ring pairs must to be assigned to a single service,
+		i.e. the one provided with the srv attribute. The service
+		assigned to a certain ring pair can be checked by querying
+		the attribute qat/rp2srv.
+
+		The maximum number of ring pairs is 4 per SLA.
+
+		Applicability in sla_op:
+
+		* WRITE: add operation
+		* READ: get operation
+
+		Example usage::
+
+			## Read
+			# echo 4 > /sys/bus/pci/devices/<BDF>/qat_rl/id
+			# cat /sys/bus/pci/devices/<BDF>/qat_rl/rp
+			0x5
+
+			## Write
+			# echo 0x5 > /sys/bus/pci/devices/<BDF>/qat_rl/rp
+
+		This attribute is only available for qat_4xxx devices.
+
+What:		/sys/bus/pci/devices/<BDF>/qat_rl/id
+Date:		January 2024
+KernelVersion:	6.7
+Contact:	qat-linux@intel.com
+Description:
+		(RW) If written to, the value is used to retrieve a particular
+		SLA and operate on it.
+		This is valid only for the following operations: update, rm,
+		and get.
+		A read of this attribute is only guaranteed to have correct data
+		after creation of an SLA.
+
+		Applicability in sla_op:
+
+		* WRITE: rm and update operations
+		* READ: add and get operations
+
+		Example usage::
+
+			## Read
+			## Set attributes e.g. cir, pir, srv, etc
+			# echo "add" > /sys/bus/pci/devices/<BDF>/qat_rl/sla_op
+			# cat /sys/bus/pci/devices/<BDF>/qat_rl/id
+			4
+
+			## Write
+			# echo 7 > /sys/bus/pci/devices/<BDF>/qat_rl/id
+			# echo "get" > /sys/bus/pci/devices/<BDF>/qat_rl/sla_op
+			# cat /sys/bus/pci/devices/<BDF>/qat_rl/rp
+			0x5  ## ring pair ID 0 and ring pair ID 2
+
+		This attribute is only available for qat_4xxx devices.
+
+What:		/sys/bus/pci/devices/<BDF>/qat_rl/cir
+Date:		January 2024
+KernelVersion:	6.7
+Contact:	qat-linux@intel.com
+Description:
+		(RW) Committed information rate (CIR). Rate guaranteed to be
+		achieved by a particular SLA. The value is expressed in
+		permille scale, i.e. 1000 refers to the maximum device
+		throughput for a selected service.
+
+		After sending a "get" to sla_op, this will be populated with the
+		CIR for that queried SLA.
+		Write to this file before sending an "add/update" sla_op, to set
+		the SLA to the specified value.
+
+		Applicability in sla_op:
+
+		* WRITE: add and update operations
+		* READ: get operation
+
+		Example usage::
+
+			## Write
+			# echo 500 > /sys/bus/pci/devices/<BDF>/qat_rl/cir
+			# echo "add" /sys/bus/pci/devices/<BDF>/qat_rl/sla_op
+
+			## Read
+			# echo 4 > /sys/bus/pci/devices/<BDF>/qat_rl/id
+			# echo "get" > /sys/bus/pci/devices/<BDF>/qat_rl/sla_op
+			# cat /sys/bus/pci/devices/<BDF>/qat_rl/cir
+			500
+
+		This attribute is only available for qat_4xxx devices.
+
+What:		/sys/bus/pci/devices/<BDF>/qat_rl/pir
+Date:		January 2024
+KernelVersion:	6.7
+Contact:	qat-linux@intel.com
+Description:
+		(RW) Peak information rate (PIR). The maximum rate that can be
+		achieved by that particular SLA. An SLA can reach a value
+		between CIR and PIR when the device is not fully utilized by
+		requests from other users (assigned to different SLAs).
+
+		After sending a "get" to sla_op, this will be populated with the
+		PIR for that queried SLA.
+		Write to this file before sending an "add/update" sla_op, to set
+		the SLA to the specified value.
+
+		Applicability in sla_op:
+
+		* WRITE: add and update operations
+		* READ: get operation
+
+		Example usage::
+
+			## Write
+			# echo 750 > /sys/bus/pci/devices/<BDF>/qat_rl/pir
+			# echo "add" > /sys/bus/pci/devices/<BDF>/qat_rl/sla_op
+
+			## Read
+			# echo 4 > /sys/bus/pci/devices/<BDF>/qat_rl/id
+			# echo "get" > /sys/bus/pci/devices/<BDF>/qat_rl/sla_op
+			# cat /sys/bus/pci/devices/<BDF>/qat_rl/pir
+			750
+
+		This attribute is only available for qat_4xxx devices.
+
+What:		/sys/bus/pci/devices/<BDF>/qat_rl/srv
+Date:		January 2024
+KernelVersion:	6.7
+Contact:	qat-linux@intel.com
+Description:
+		(RW) Service (SRV). Represents the service (sym, asym, dc)
+		associated to an SLA.
+		Can be written to or queried to set/show the SRV type for an SLA.
+		The SRV attribute is used to specify the SRV type before adding
+		an SLA. After an SLA is configured, reports the service
+		associated to that SLA.
+
+		Applicability in sla_op:
+
+		* WRITE: add and update operations
+		* READ: get operation
+
+		Example usage::
+
+			## Write
+			# echo "dc" > /sys/bus/pci/devices/<BDF>/qat_rl/srv
+			# echo "add" > /sys/bus/pci/devices/<BDF>/qat_rl/sla_op
+			# cat /sys/bus/pci/devices/<BDF>/qat_rl/id
+			4
+
+			## Read
+			# echo 4 > /sys/bus/pci/devices/<BDF>/qat_rl/id
+			# echo "get" > /sys/bus/pci/devices/<BDF>/qat_rl/sla_op
+			# cat /sys/bus/pci/devices/<BDF>/qat_rl/srv
+			dc
+
+		This attribute is only available for qat_4xxx devices.
+
+What:		/sys/bus/pci/devices/<BDF>/qat_rl/cap_rem
+Date:		January 2024
+KernelVersion:	6.7
+Contact:	qat-linux@intel.com
+Description:
+		(RW) This file will return the remaining capability for a
+		particular service/sla. This is the remaining value that a new
+		SLA can be set to or a current SLA can be increased with.
+
+		Example usage::
+
+			# echo "asym" > /sys/bus/pci/devices/<BDF>/qat_rl/cap_rem
+			# cat /sys/bus/pci/devices/<BDF>/qat_rl/cap_rem
+			250
+			# echo 250 > /sys/bus/pci/devices/<BDF>/qat_rl/cir
+			# echo "add" > /sys/bus/pci/devices/<BDF>/qat_rl/sla_op
+			# cat /sys/bus/pci/devices/<BDF>/qat_rl/cap_rem
+			0
+
+		This attribute is only available for qat_4xxx devices.
+
diff --git a/drivers/crypto/intel/qat/qat_common/Makefile b/drivers/crypto/intel/qat/qat_common/Makefile
index 77f8c484d49c..832f0b48d99e 100644
--- a/drivers/crypto/intel/qat/qat_common/Makefile
+++ b/drivers/crypto/intel/qat/qat_common/Makefile
@@ -28,6 +28,7 @@ intel_qat-objs := adf_cfg.o \
 	qat_algs_send.o \
 	adf_rl.o \
 	adf_rl_admin.o \
+	adf_sysfs_rl.o \
 	qat_uclo.o \
 	qat_hal.o \
 	qat_bl.o
diff --git a/drivers/crypto/intel/qat/qat_common/adf_rl.c b/drivers/crypto/intel/qat/qat_common/adf_rl.c
index dec98a056dce..d8bb4154048a 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_rl.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_rl.c
@@ -16,6 +16,7 @@
 #include "adf_common_drv.h"
 #include "adf_rl_admin.h"
 #include "adf_rl.h"
+#include "adf_sysfs_rl.h"
 
 #define RL_TOKEN_GRANULARITY_PCIEIN_BUCKET	0U
 #define RL_TOKEN_GRANULARITY_PCIEOUT_BUCKET	0U
@@ -1147,8 +1148,16 @@ int adf_rl_start(struct adf_accel_dev *accel_dev)
 		goto ret_sla_rm;
 	}
 
+	ret = adf_sysfs_rl_add(accel_dev);
+	if (ret) {
+		dev_err(&GET_DEV(accel_dev), "failed to add sysfs interface\n");
+		goto ret_sysfs_rm;
+	}
+
 	return 0;
 
+ret_sysfs_rm:
+	adf_sysfs_rl_rm(accel_dev);
 ret_sla_rm:
 	adf_rl_remove_sla_all(accel_dev, true);
 ret_free:
@@ -1163,6 +1172,7 @@ void adf_rl_stop(struct adf_accel_dev *accel_dev)
 	if (!accel_dev->rate_limiting)
 		return;
 
+	adf_sysfs_rl_rm(accel_dev);
 	adf_rl_remove_sla_all(accel_dev, true);
 }
 
diff --git a/drivers/crypto/intel/qat/qat_common/adf_rl.h b/drivers/crypto/intel/qat/qat_common/adf_rl.h
index 1ccb6613c92e..eb5a330f8543 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_rl.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_rl.h
@@ -75,6 +75,12 @@ struct rl_slice_cnt {
 	u8 cph_cnt;
 };
 
+struct adf_rl_interface_data {
+	struct adf_rl_sla_input_data input;
+	enum adf_base_services cap_rem_srv;
+	struct rw_semaphore lock;
+};
+
 struct adf_rl_hw_data {
 	u32 scale_ref;
 	u32 scan_interval;
@@ -113,6 +119,7 @@ struct adf_rl {
 	bool rp_in_use[RL_RP_CNT_MAX];
 	/* Mutex protecting writing to SLAs lists */
 	struct mutex rl_lock;
+	struct adf_rl_interface_data user_input;
 };
 
 /**
diff --git a/drivers/crypto/intel/qat/qat_common/adf_sysfs_rl.c b/drivers/crypto/intel/qat/qat_common/adf_sysfs_rl.c
new file mode 100644
index 000000000000..abf9c52474ec
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_sysfs_rl.c
@@ -0,0 +1,451 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation */
+
+#define dev_fmt(fmt) "RateLimiting: " fmt
+
+#include <linux/dev_printk.h>
+#include <linux/pci.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+
+#include "adf_common_drv.h"
+#include "adf_rl.h"
+#include "adf_sysfs_rl.h"
+
+#define GET_RL_STRUCT(accel_dev) ((accel_dev)->rate_limiting->user_input)
+
+enum rl_ops {
+	ADD,
+	UPDATE,
+	RM,
+	RM_ALL,
+	GET,
+};
+
+enum rl_params {
+	RP_MASK,
+	ID,
+	CIR,
+	PIR,
+	SRV,
+	CAP_REM_SRV,
+};
+
+static const char *const rl_services[] = {
+	[ADF_SVC_ASYM] = "asym",
+	[ADF_SVC_SYM] = "sym",
+	[ADF_SVC_DC] = "dc",
+};
+
+static const char *const rl_operations[] = {
+	[ADD] = "add",
+	[UPDATE] = "update",
+	[RM] = "rm",
+	[RM_ALL] = "rm_all",
+	[GET] = "get",
+};
+
+static int set_param_u(struct device *dev, enum rl_params param, u64 set)
+{
+	struct adf_rl_interface_data *data;
+	struct adf_accel_dev *accel_dev;
+	int ret = 0;
+
+	accel_dev = adf_devmgr_pci_to_accel_dev(to_pci_dev(dev));
+	if (!accel_dev)
+		return -EINVAL;
+
+	data = &GET_RL_STRUCT(accel_dev);
+
+	down_write(&data->lock);
+	switch (param) {
+	case RP_MASK:
+		data->input.rp_mask = set;
+		break;
+	case CIR:
+		data->input.cir = set;
+		break;
+	case PIR:
+		data->input.pir = set;
+		break;
+	case SRV:
+		data->input.srv = set;
+		break;
+	case CAP_REM_SRV:
+		data->cap_rem_srv = set;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	up_write(&data->lock);
+
+	return ret;
+}
+
+static int set_param_s(struct device *dev, enum rl_params param, int set)
+{
+	struct adf_rl_interface_data *data;
+	struct adf_accel_dev *accel_dev;
+
+	accel_dev = adf_devmgr_pci_to_accel_dev(to_pci_dev(dev));
+	if (!accel_dev || param != ID)
+		return -EINVAL;
+
+	data = &GET_RL_STRUCT(accel_dev);
+
+	down_write(&data->lock);
+	data->input.sla_id = set;
+	up_write(&data->lock);
+
+	return 0;
+}
+
+static int get_param_u(struct device *dev, enum rl_params param, u64 *get)
+{
+	struct adf_rl_interface_data *data;
+	struct adf_accel_dev *accel_dev;
+	int ret = 0;
+
+	accel_dev = adf_devmgr_pci_to_accel_dev(to_pci_dev(dev));
+	if (!accel_dev)
+		return -EINVAL;
+
+	data = &GET_RL_STRUCT(accel_dev);
+
+	down_read(&data->lock);
+	switch (param) {
+	case RP_MASK:
+		*get = data->input.rp_mask;
+		break;
+	case CIR:
+		*get = data->input.cir;
+		break;
+	case PIR:
+		*get = data->input.pir;
+		break;
+	case SRV:
+		*get = data->input.srv;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	up_read(&data->lock);
+
+	return ret;
+}
+
+static int get_param_s(struct device *dev, enum rl_params param)
+{
+	struct adf_rl_interface_data *data;
+	struct adf_accel_dev *accel_dev;
+	int ret = 0;
+
+	accel_dev = adf_devmgr_pci_to_accel_dev(to_pci_dev(dev));
+	if (!accel_dev)
+		return -EINVAL;
+
+	data = &GET_RL_STRUCT(accel_dev);
+
+	down_read(&data->lock);
+	if (param == ID)
+		ret = data->input.sla_id;
+	up_read(&data->lock);
+
+	return ret;
+}
+
+static ssize_t rp_show(struct device *dev, struct device_attribute *attr,
+		       char *buf)
+{
+	int ret;
+	u64 get;
+
+	ret = get_param_u(dev, RP_MASK, &get);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%#llx\n", get);
+}
+
+static ssize_t rp_store(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	int err;
+	u64 val;
+
+	err = kstrtou64(buf, 16, &val);
+	if (err)
+		return err;
+
+	err = set_param_u(dev, RP_MASK, val);
+	if (err)
+		return err;
+
+	return count;
+}
+static DEVICE_ATTR_RW(rp);
+
+static ssize_t id_show(struct device *dev, struct device_attribute *attr,
+		       char *buf)
+{
+	return sysfs_emit(buf, "%d\n", get_param_s(dev, ID));
+}
+
+static ssize_t id_store(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	int err;
+	int val;
+
+	err = kstrtoint(buf, 10, &val);
+	if (err)
+		return err;
+
+	err = set_param_s(dev, ID, val);
+	if (err)
+		return err;
+
+	return count;
+}
+static DEVICE_ATTR_RW(id);
+
+static ssize_t cir_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	int ret;
+	u64 get;
+
+	ret = get_param_u(dev, CIR, &get);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%llu\n", get);
+}
+
+static ssize_t cir_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
+{
+	unsigned int val;
+	int err;
+
+	err = kstrtouint(buf, 10, &val);
+	if (err)
+		return err;
+
+	err = set_param_u(dev, CIR, val);
+	if (err)
+		return err;
+
+	return count;
+}
+static DEVICE_ATTR_RW(cir);
+
+static ssize_t pir_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	int ret;
+	u64 get;
+
+	ret = get_param_u(dev, PIR, &get);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%llu\n", get);
+}
+
+static ssize_t pir_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
+{
+	unsigned int val;
+	int err;
+
+	err = kstrtouint(buf, 10, &val);
+	if (err)
+		return err;
+
+	err = set_param_u(dev, PIR, val);
+	if (err)
+		return err;
+
+	return count;
+}
+static DEVICE_ATTR_RW(pir);
+
+static ssize_t srv_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	int ret;
+	u64 get;
+
+	ret = get_param_u(dev, SRV, &get);
+	if (ret)
+		return ret;
+
+	if (get == ADF_SVC_NONE)
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%s\n", rl_services[get]);
+}
+
+static ssize_t srv_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
+{
+	unsigned int val;
+	int ret;
+
+	ret = sysfs_match_string(rl_services, buf);
+	if (ret < 0)
+		return ret;
+
+	val = ret;
+	ret = set_param_u(dev, SRV, val);
+	if (ret)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR_RW(srv);
+
+static ssize_t cap_rem_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct adf_rl_interface_data *data;
+	struct adf_accel_dev *accel_dev;
+	int ret, rem_cap;
+
+	accel_dev = adf_devmgr_pci_to_accel_dev(to_pci_dev(dev));
+	if (!accel_dev)
+		return -EINVAL;
+
+	data = &GET_RL_STRUCT(accel_dev);
+
+	down_read(&data->lock);
+	rem_cap = adf_rl_get_capability_remaining(accel_dev, data->cap_rem_srv,
+						  RL_SLA_EMPTY_ID);
+	up_read(&data->lock);
+	if (rem_cap < 0)
+		return rem_cap;
+
+	ret = sysfs_emit(buf, "%u\n", rem_cap);
+
+	return ret;
+}
+
+static ssize_t cap_rem_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	unsigned int val;
+	int ret;
+
+	ret = sysfs_match_string(rl_services, buf);
+	if (ret < 0)
+		return ret;
+
+	val = ret;
+	ret = set_param_u(dev, CAP_REM_SRV, val);
+	if (ret)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR_RW(cap_rem);
+
+static ssize_t sla_op_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct adf_rl_interface_data *data;
+	struct adf_accel_dev *accel_dev;
+	int ret;
+
+	accel_dev = adf_devmgr_pci_to_accel_dev(to_pci_dev(dev));
+	if (!accel_dev)
+		return -EINVAL;
+
+	data = &GET_RL_STRUCT(accel_dev);
+
+	ret = sysfs_match_string(rl_operations, buf);
+	if (ret < 0)
+		return ret;
+
+	down_write(&data->lock);
+	switch (ret) {
+	case ADD:
+		data->input.parent_id = RL_PARENT_DEFAULT_ID;
+		data->input.type = RL_LEAF;
+		data->input.sla_id = 0;
+		ret = adf_rl_add_sla(accel_dev, &data->input);
+		if (ret)
+			goto err_free_lock;
+		break;
+	case UPDATE:
+		ret = adf_rl_update_sla(accel_dev, &data->input);
+		if (ret)
+			goto err_free_lock;
+		break;
+	case RM:
+		ret = adf_rl_remove_sla(accel_dev, data->input.sla_id);
+		if (ret)
+			goto err_free_lock;
+		break;
+	case RM_ALL:
+		adf_rl_remove_sla_all(accel_dev, false);
+		break;
+	case GET:
+		ret = adf_rl_get_sla(accel_dev, &data->input);
+		if (ret)
+			goto err_free_lock;
+		break;
+	default:
+		ret = -EINVAL;
+		goto err_free_lock;
+	}
+	up_write(&data->lock);
+
+	return count;
+
+err_free_lock:
+	up_write(&data->lock);
+
+	return ret;
+}
+static DEVICE_ATTR_WO(sla_op);
+
+static struct attribute *qat_rl_attrs[] = {
+	&dev_attr_rp.attr,
+	&dev_attr_id.attr,
+	&dev_attr_cir.attr,
+	&dev_attr_pir.attr,
+	&dev_attr_srv.attr,
+	&dev_attr_cap_rem.attr,
+	&dev_attr_sla_op.attr,
+	NULL,
+};
+
+static struct attribute_group qat_rl_group = {
+	.attrs = qat_rl_attrs,
+	.name = "qat_rl",
+};
+
+int adf_sysfs_rl_add(struct adf_accel_dev *accel_dev)
+{
+	struct adf_rl_interface_data *data;
+	int ret;
+
+	data = &GET_RL_STRUCT(accel_dev);
+
+	ret = device_add_group(&GET_DEV(accel_dev), &qat_rl_group);
+	if (ret)
+		dev_err(&GET_DEV(accel_dev),
+			"Failed to create qat_rl attribute group\n");
+
+	data->cap_rem_srv = ADF_SVC_NONE;
+	data->input.srv = ADF_SVC_NONE;
+
+	return ret;
+}
+
+void adf_sysfs_rl_rm(struct adf_accel_dev *accel_dev)
+{
+	device_remove_group(&GET_DEV(accel_dev), &qat_rl_group);
+}
diff --git a/drivers/crypto/intel/qat/qat_common/adf_sysfs_rl.h b/drivers/crypto/intel/qat/qat_common/adf_sysfs_rl.h
new file mode 100644
index 000000000000..22d36aa8a757
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_sysfs_rl.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2023 Intel Corporation */
+#ifndef ADF_SYSFS_RL_H_
+#define ADF_SYSFS_RL_H_
+
+struct adf_accel_dev;
+
+int adf_sysfs_rl_add(struct adf_accel_dev *accel_dev);
+void adf_sysfs_rl_rm(struct adf_accel_dev *accel_dev);
+
+#endif /* ADF_SYSFS_RL_H_ */
-- 
2.41.0


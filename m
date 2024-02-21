Return-Path: <linux-crypto+bounces-2228-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DA685E259
	for <lists+linux-crypto@lfdr.de>; Wed, 21 Feb 2024 17:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353FF1C209A4
	for <lists+linux-crypto@lfdr.de>; Wed, 21 Feb 2024 16:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ECE83CC2;
	Wed, 21 Feb 2024 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fd9FLfj2"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B90839FF;
	Wed, 21 Feb 2024 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708531169; cv=none; b=KoM1tmJD2+ZsdNDJ7wFkRgPlrVNPMZA+tqdjgJiR46Uq/Ws+x303UrIJkXlPI1YE2VZn/8Ba+LEfYgcrUkJByNwGkxqAZfyDFaxEhSVN9cti/7BUhQ4QzEeprTFl9VU/jYicXyJJ1t3jjShJ+HDXf8R5byP/hTO2klIsgcr/DHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708531169; c=relaxed/simple;
	bh=HjEVmX2DdBXSdWX6tJC0zjdQhmV4osCO5mBQQRbwOrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=e/IM8WshcXwXU3GtKv9cAC+8YaoO5uyYbLHhqG6CT0/WOLMpzEzn9al9ZUZlSXYAbiPnw2CNVWrcOKfggyHVzQx18bkXhxZjZjPHmLVlJqMPGZ/0qlDpYdCntr/lIghukndJGWGr8iHbkuqDlN/lKrt0oXgwVqkU7V7p1GdZxLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fd9FLfj2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708531166; x=1740067166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=HjEVmX2DdBXSdWX6tJC0zjdQhmV4osCO5mBQQRbwOrs=;
  b=fd9FLfj2v/+utxt5JlLUJLWEaUcpz7QbroGuLPfmDy9yOXOi6iHIqhYj
   Q36ZD39OePcehTVVn55qqiHUWYE7lwr0KE5QGm5edSzMXd+LrPv/7k9J4
   mZG6O48igloyMev+U07NwpHx0QAPE5AScMCThV5l8m4DpmNnV1actY6yw
   r9Av0RZMGGr9Tenx/gB6xRJ2Yhg/gDq6/3HVTTtvAqGvU8UvwXIuUaQ8p
   IE1ZsssEjl2BTyi1KllqF9C2qPKFAsIxatSHEp7/R/OExLXS4WaegrJox
   RnQ49uegGQNIYCJ1nU2Gl+8NAqbH3vqQKH+wZ13chXUgoTuEdzx/FQ5Jl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2568893"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2568893"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 07:59:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="9760987"
Received: from qat-server-archercity1.sh.intel.com ([10.67.111.115])
  by fmviesa004.fm.intel.com with ESMTP; 21 Feb 2024 07:59:08 -0800
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
	Xin Zeng <xin.zeng@intel.com>
Subject: [PATCH v3 09/10] crypto: qat - implement interface for live migration
Date: Wed, 21 Feb 2024 23:50:07 +0800
Message-Id: <20240221155008.960369-10-xin.zeng@intel.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20240221155008.960369-1-xin.zeng@intel.com>
References: <20240221155008.960369-1-xin.zeng@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

Add logic to implement the interface for live migration defined in
qat/qat_mig_dev.h. This is specific for QAT GEN4 Virtual Functions
(VFs).

This introduces a migration data manager which is used to handle the
device state during migration. The manager ensures that the device state
is stored in a format that can be restored in the destination node.

The VF state is organized into a hierarchical structure that includes a
preamble, a general state section, a MISC bar section and an ETR bar
section. The latter contains the state of the 4 ring pairs contained on
a VF. Here is a graphical representation of the state:

    preamble | general state section | leaf state
             | MISC bar state section| leaf state
             | ETR bar state section | bank0 state section | leaf state
                                     | bank1 state section | leaf state
                                     | bank2 state section | leaf state
                                     | bank3 state section | leaf state

In addition to the implementation of the qat_migdev_ops interface and
the state manager framework, add a mutex in pfvf to avoid pf2vf messages
during migration.

Signed-off-by: Xin Zeng <xin.zeng@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 .../intel/qat/qat_420xx/adf_420xx_hw_data.c   |    2 +
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     |    2 +
 drivers/crypto/intel/qat/qat_common/Makefile  |    2 +
 .../intel/qat/qat_common/adf_accel_devices.h  |    6 +
 .../intel/qat/qat_common/adf_gen4_hw_data.h   |   10 +
 .../intel/qat/qat_common/adf_gen4_vf_mig.c    | 1010 +++++++++++++++++
 .../intel/qat/qat_common/adf_mstate_mgr.c     |  318 ++++++
 .../intel/qat/qat_common/adf_mstate_mgr.h     |   89 ++
 .../crypto/intel/qat/qat_common/adf_sriov.c   |    7 +-
 9 files changed, 1445 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen4_vf_mig.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_mstate_mgr.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_mstate_mgr.h

diff --git a/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
index 9ccbf5998d5c..d255cb3ebd9c 100644
--- a/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
@@ -17,6 +17,7 @@
 #include <adf_gen4_ras.h>
 #include <adf_gen4_timer.h>
 #include <adf_gen4_tl.h>
+#include <adf_gen4_vf_mig.h>
 #include "adf_420xx_hw_data.h"
 #include "icp_qat_hw.h"
 
@@ -488,6 +489,7 @@ void adf_init_hw_data_420xx(struct adf_hw_device_data *hw_data, u32 dev_id)
 	adf_gen4_init_dc_ops(&hw_data->dc_ops);
 	adf_gen4_init_ras_ops(&hw_data->ras_ops);
 	adf_gen4_init_tl_data(&hw_data->tl_data);
+	adf_gen4_init_vf_mig_ops(&hw_data->vfmig_ops);
 	adf_init_rl_data(&hw_data->rl_data);
 }
 
diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
index eaf055e6f938..1e77e189a938 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -17,6 +17,7 @@
 #include "adf_gen4_ras.h"
 #include <adf_gen4_timer.h>
 #include <adf_gen4_tl.h>
+#include <adf_gen4_vf_mig.h>
 #include "adf_4xxx_hw_data.h"
 #include "icp_qat_hw.h"
 
@@ -472,6 +473,7 @@ void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data, u32 dev_id)
 	adf_gen4_init_dc_ops(&hw_data->dc_ops);
 	adf_gen4_init_ras_ops(&hw_data->ras_ops);
 	adf_gen4_init_tl_data(&hw_data->tl_data);
+	adf_gen4_init_vf_mig_ops(&hw_data->vfmig_ops);
 	adf_init_rl_data(&hw_data->rl_data);
 }
 
diff --git a/drivers/crypto/intel/qat/qat_common/Makefile b/drivers/crypto/intel/qat/qat_common/Makefile
index 9fba31d4ac7f..6f9266edc9f1 100644
--- a/drivers/crypto/intel/qat/qat_common/Makefile
+++ b/drivers/crypto/intel/qat/qat_common/Makefile
@@ -20,12 +20,14 @@ intel_qat-objs := adf_cfg.o \
 	adf_gen4_config.o \
 	adf_gen4_hw_csr_data.o \
 	adf_gen4_hw_data.o \
+	adf_gen4_vf_mig.o \
 	adf_gen4_pm.o \
 	adf_gen2_dc.o \
 	adf_gen4_dc.o \
 	adf_gen4_ras.o \
 	adf_gen4_timer.o \
 	adf_clock.o \
+	adf_mstate_mgr.o \
 	qat_crypto.o \
 	qat_compression.o \
 	qat_comp_algs.o \
diff --git a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
index b08fea10121e..7830ecb1a1f1 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
@@ -412,11 +412,17 @@ struct adf_fw_loader_data {
 struct adf_accel_vf_info {
 	struct adf_accel_dev *accel_dev;
 	struct mutex pf2vf_lock; /* protect CSR access for PF2VF messages */
+	struct mutex pfvf_mig_lock; /* protects PFVF state for migration */
 	struct ratelimit_state vf2pf_ratelimit;
 	u32 vf_nr;
 	bool init;
 	bool restarting;
 	u8 vf_compat_ver;
+	/*
+	 * Private area used for device migration.
+	 * Memory allocation and free is managed by migration driver.
+	 */
+	void *mig_priv;
 };
 
 struct adf_dc_data {
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
index e8cb930e80c9..8b10926cedba 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
@@ -86,6 +86,7 @@
 #define ADF_RP_INT_SRC_SEL_F_RISE_MASK	BIT(2)
 #define ADF_RP_INT_SRC_SEL_F_FALL_MASK	GENMASK(2, 0)
 #define ADF_RP_INT_SRC_SEL_RANGE_WIDTH	4
+#define ADF_COALESCED_POLL_TIMEOUT_US	(1 * USEC_PER_SEC)
 #define ADF_COALESCED_POLL_DELAY_US	1000
 #define ADF_WQM_CSR_RPINTSOU(bank)	(0x200000 + ((bank) << 12))
 #define ADF_WQM_CSR_RP_IDX_RX		1
@@ -120,6 +121,15 @@
 /* PF2VM communication channel */
 #define ADF_GEN4_PF2VM_OFFSET(i)	(0x40B010 + (i) * 0x20)
 #define ADF_GEN4_VM2PF_OFFSET(i)	(0x40B014 + (i) * 0x20)
+#define ADF_GEN4_VINTMSKPF2VM_OFFSET(i)	(0x40B00C + (i) * 0x20)
+#define ADF_GEN4_VINTSOUPF2VM_OFFSET(i)	(0x40B008 + (i) * 0x20)
+#define ADF_GEN4_VINTMSK_OFFSET(i)	(0x40B004 + (i) * 0x20)
+#define ADF_GEN4_VINTSOU_OFFSET(i)	(0x40B000 + (i) * 0x20)
+
+struct adf_gen4_vfmig {
+	struct adf_mstate_mgr *mstate_mgr;
+	bool bank_stopped[ADF_GEN4_NUM_BANKS_PER_VF];
+};
 
 void adf_gen4_set_ssm_wdtimer(struct adf_accel_dev *accel_dev);
 
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_vf_mig.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_vf_mig.c
new file mode 100644
index 000000000000..78a39cfe196f
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_vf_mig.c
@@ -0,0 +1,1010 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024 Intel Corporation */
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <asm/errno.h>
+
+#include "adf_accel_devices.h"
+#include "adf_common_drv.h"
+#include "adf_gen4_hw_data.h"
+#include "adf_gen4_pfvf.h"
+#include "adf_pfvf_utils.h"
+#include "adf_mstate_mgr.h"
+#include "adf_gen4_vf_mig.h"
+
+#define ADF_GEN4_VF_MSTATE_SIZE		4096
+#define ADF_GEN4_PFVF_RSP_TIMEOUT_US	5000
+
+static int adf_gen4_vfmig_save_setup(struct qat_mig_dev *mdev);
+static int adf_gen4_vfmig_load_setup(struct qat_mig_dev *mdev, int len);
+
+static int adf_gen4_vfmig_init_device(struct qat_mig_dev *mdev)
+{
+	u8 *state;
+
+	state = kmalloc(ADF_GEN4_VF_MSTATE_SIZE, GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+
+	mdev->state = state;
+	mdev->state_size = ADF_GEN4_VF_MSTATE_SIZE;
+	mdev->setup_size = 0;
+	mdev->remote_setup_size = 0;
+
+	return 0;
+}
+
+static void adf_gen4_vfmig_cleanup_device(struct qat_mig_dev *mdev)
+{
+	kfree(mdev->state);
+	mdev->state = NULL;
+}
+
+static void adf_gen4_vfmig_reset_device(struct qat_mig_dev *mdev)
+{
+	mdev->setup_size = 0;
+	mdev->remote_setup_size = 0;
+}
+
+static int adf_gen4_vfmig_open_device(struct qat_mig_dev *mdev)
+{
+	struct adf_accel_dev *accel_dev = mdev->parent_accel_dev;
+	struct adf_accel_vf_info *vf_info;
+	struct adf_gen4_vfmig *vfmig;
+
+	vf_info = &accel_dev->pf.vf_info[mdev->vf_id];
+
+	vfmig = kzalloc(sizeof(*vfmig), GFP_KERNEL);
+	if (!vfmig)
+		return -ENOMEM;
+
+	vfmig->mstate_mgr = adf_mstate_mgr_new(mdev->state, mdev->state_size);
+	if (!vfmig->mstate_mgr) {
+		kfree(vfmig);
+		return -ENOMEM;
+	}
+	vf_info->mig_priv = vfmig;
+	mdev->setup_size = 0;
+	mdev->remote_setup_size = 0;
+
+	return 0;
+}
+
+static void adf_gen4_vfmig_close_device(struct qat_mig_dev *mdev)
+{
+	struct adf_accel_dev *accel_dev = mdev->parent_accel_dev;
+	struct adf_accel_vf_info *vf_info;
+	struct adf_gen4_vfmig *vfmig;
+
+	vf_info = &accel_dev->pf.vf_info[mdev->vf_id];
+	if (vf_info->mig_priv) {
+		vfmig = vf_info->mig_priv;
+		adf_mstate_mgr_destroy(vfmig->mstate_mgr);
+		kfree(vfmig);
+		vf_info->mig_priv = NULL;
+	}
+}
+
+static int adf_gen4_vfmig_suspend_device(struct qat_mig_dev *mdev)
+{
+	struct adf_accel_dev *accel_dev = mdev->parent_accel_dev;
+	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+	struct adf_accel_vf_info *vf_info;
+	struct adf_gen4_vfmig *vf_mig;
+	u32 vf_nr = mdev->vf_id;
+	int ret, i;
+
+	vf_info = &accel_dev->pf.vf_info[vf_nr];
+	vf_mig = vf_info->mig_priv;
+
+	/* Stop all inflight jobs */
+	for (i = 0; i < hw_data->num_banks_per_vf; i++) {
+		u32 pf_bank_nr = i + vf_nr * hw_data->num_banks_per_vf;
+
+		ret = adf_gen4_bank_drain_start(accel_dev, pf_bank_nr,
+						ADF_RPRESET_POLL_TIMEOUT_US);
+		if (ret) {
+			dev_err(&GET_DEV(accel_dev),
+				"Failed to drain bank %d for vf_nr %d\n", i,
+				vf_nr);
+			return ret;
+		}
+		vf_mig->bank_stopped[i] = true;
+
+		adf_gen4_bank_quiesce_coal_timer(accel_dev, pf_bank_nr,
+						 ADF_COALESCED_POLL_TIMEOUT_US);
+	}
+
+	return 0;
+}
+
+static int adf_gen4_vfmig_resume_device(struct qat_mig_dev *mdev)
+{
+	struct adf_accel_dev *accel_dev = mdev->parent_accel_dev;
+	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+	struct adf_accel_vf_info *vf_info;
+	struct adf_gen4_vfmig *vf_mig;
+	u32 vf_nr = mdev->vf_id;
+	int i;
+
+	vf_info = &accel_dev->pf.vf_info[vf_nr];
+	vf_mig = vf_info->mig_priv;
+
+	for (i = 0; i < hw_data->num_banks_per_vf; i++) {
+		u32 pf_bank_nr = i + vf_nr * hw_data->num_banks_per_vf;
+
+		if (vf_mig->bank_stopped[i]) {
+			adf_gen4_bank_drain_finish(accel_dev, pf_bank_nr);
+			vf_mig->bank_stopped[i] = false;
+		}
+	}
+
+	return 0;
+}
+
+struct adf_vf_bank_info {
+	struct adf_accel_dev *accel_dev;
+	u32 vf_nr;
+	u32 bank_nr;
+};
+
+struct mig_user_sla {
+	enum adf_base_services srv;
+	u64 rp_mask;
+	u32 cir;
+	u32 pir;
+};
+
+static int adf_mstate_sla_check(struct adf_mstate_mgr *sub_mgr, u8 *src_buf,
+				u32 src_size, void *opaque)
+{
+	struct adf_mstate_vreginfo _sinfo = { src_buf, src_size };
+	struct adf_mstate_vreginfo *sinfo = &_sinfo, *dinfo = opaque;
+	u32 src_sla_cnt = sinfo->size / sizeof(struct mig_user_sla);
+	u32 dst_sla_cnt = dinfo->size / sizeof(struct mig_user_sla);
+	struct mig_user_sla *src_slas = sinfo->addr;
+	struct mig_user_sla *dst_slas = dinfo->addr;
+	int i, j;
+
+	for (i = 0; i < src_sla_cnt; i++) {
+		for (j = 0; j < dst_sla_cnt; j++) {
+			if (src_slas[i].srv != dst_slas[j].srv ||
+			    src_slas[i].rp_mask != dst_slas[j].rp_mask)
+				continue;
+
+			if (src_slas[i].cir > dst_slas[j].cir ||
+			    src_slas[i].pir > dst_slas[j].pir) {
+				pr_err("QAT: DST VF rate limiting mismatch.\n");
+				return -EINVAL;
+			}
+			break;
+		}
+
+		if (j == dst_sla_cnt) {
+			pr_err("QAT: SRC VF rate limiting mismatch - SRC srv %d and rp_mask 0x%llx.\n",
+			       src_slas[i].srv, src_slas[i].rp_mask);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static inline int adf_mstate_check_cap_size(u32 src_sz, u32 dst_sz, u32 max_sz)
+{
+	if (src_sz > max_sz || dst_sz > max_sz)
+		return -EINVAL;
+	else
+		return 0;
+}
+
+static int adf_mstate_compatver_check(struct adf_mstate_mgr *sub_mgr,
+				      u8 *src_buf, u32 src_sz, void *opaque)
+{
+	struct adf_mstate_vreginfo *info = opaque;
+	u8 compat = 0;
+	u8 *pcompat;
+
+	if (src_sz != info->size) {
+		pr_debug("QAT: State mismatch (compat version size), current %u, expected %u\n",
+			 src_sz, info->size);
+		return -EINVAL;
+	}
+
+	memcpy(info->addr, src_buf, info->size);
+	pcompat = info->addr;
+	if (*pcompat == 0) {
+		pr_warn("QAT: Unable to determine the version of VF\n");
+		return 0;
+	}
+
+	compat = adf_vf_compat_checker(*pcompat);
+	if (compat == ADF_PF2VF_VF_INCOMPATIBLE) {
+		pr_debug("QAT: SRC VF driver (ver=%u) is incompatible with DST PF driver (ver=%u)\n",
+			 *pcompat, ADF_PFVF_COMPAT_THIS_VERSION);
+		return -EINVAL;
+	}
+
+	if (compat == ADF_PF2VF_VF_COMPAT_UNKNOWN)
+		pr_debug("QAT: SRC VF driver (ver=%u) is newer than DST PF driver (ver=%u)\n",
+			 *pcompat, ADF_PFVF_COMPAT_THIS_VERSION);
+
+	return 0;
+}
+
+/*
+ * adf_mstate_capmask_compare() - compare QAT device capability mask
+ * @sinfo:	Pointer to source capability info
+ * @dinfo:	Pointer to target capability info
+ *
+ * This function compares the capability mask between source VF and target VF
+ *
+ * Returns: 0 if target capability mask is identical to source capability mask,
+ * 1 if target mask can represent all the capabilities represented by source mask,
+ * -1 if target mask can't represent all the capabilities represented by source
+ * mask.
+ */
+static int adf_mstate_capmask_compare(struct adf_mstate_vreginfo *sinfo,
+				      struct adf_mstate_vreginfo *dinfo)
+{
+	u64 src = 0, dst = 0;
+
+	if (adf_mstate_check_cap_size(sinfo->size, dinfo->size, sizeof(u64))) {
+		pr_debug("QAT: Unexpected capability size %u %u %zu\n",
+			 sinfo->size, dinfo->size, sizeof(u64));
+		return -1;
+	}
+
+	memcpy(&src, sinfo->addr, sinfo->size);
+	memcpy(&dst, dinfo->addr, dinfo->size);
+
+	pr_debug("QAT: Check cap compatibility of cap %llu %llu\n", src, dst);
+
+	if (src == dst)
+		return 0;
+
+	if ((src | dst) == dst)
+		return 1;
+
+	return -1;
+}
+
+static int adf_mstate_capmask_superset(struct adf_mstate_mgr *sub_mgr, u8 *buf,
+				       u32 size, void *opa)
+{
+	struct adf_mstate_vreginfo sinfo = { buf, size };
+
+	if (adf_mstate_capmask_compare(&sinfo, opa) >= 0)
+		return 0;
+
+	return -EINVAL;
+}
+
+static int adf_mstate_capmask_equal(struct adf_mstate_mgr *sub_mgr, u8 *buf,
+				    u32 size, void *opa)
+{
+	struct adf_mstate_vreginfo sinfo = { buf, size };
+
+	if (adf_mstate_capmask_compare(&sinfo, opa) == 0)
+		return 0;
+
+	return -EINVAL;
+}
+
+static int adf_mstate_set_vreg(struct adf_mstate_mgr *sub_mgr, u8 *buf,
+			       u32 size, void *opa)
+{
+	struct adf_mstate_vreginfo *info = opa;
+
+	if (size != info->size) {
+		pr_debug("QAT: Unexpected cap size %u %u\n", size, info->size);
+		return -EINVAL;
+	}
+	memcpy(info->addr, buf, info->size);
+
+	return 0;
+}
+
+static u32 adf_gen4_vfmig_get_slas(struct adf_accel_dev *accel_dev, u32 vf_nr,
+				   struct mig_user_sla *pmig_slas)
+{
+	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+	struct adf_rl *rl_data = accel_dev->rate_limiting;
+	struct rl_sla **sla_type_arr = NULL;
+	u64 rp_mask, rp_index;
+	u32 max_num_sla;
+	u32 sla_cnt = 0;
+	int i, j;
+
+	if (!accel_dev->rate_limiting)
+		return 0;
+
+	rp_index = vf_nr * hw_data->num_banks_per_vf;
+	max_num_sla = adf_rl_get_sla_arr_of_type(rl_data, RL_LEAF, &sla_type_arr);
+
+	for (i = 0; i < max_num_sla; i++) {
+		if (!sla_type_arr[i])
+			continue;
+
+		rp_mask = 0;
+		for (j = 0; j < sla_type_arr[i]->ring_pairs_cnt; j++)
+			rp_mask |= BIT(sla_type_arr[i]->ring_pairs_ids[j]);
+
+		if (rp_mask & GENMASK_ULL(rp_index + 3, rp_index)) {
+			pmig_slas->rp_mask = rp_mask;
+			pmig_slas->cir = sla_type_arr[i]->cir;
+			pmig_slas->pir = sla_type_arr[i]->pir;
+			pmig_slas->srv = sla_type_arr[i]->srv;
+			pmig_slas++;
+			sla_cnt++;
+		}
+	}
+
+	return sla_cnt;
+}
+
+static int adf_gen4_vfmig_load_etr_regs(struct adf_mstate_mgr *sub_mgr,
+					u8 *state, u32 size, void *opa)
+{
+	struct adf_vf_bank_info *vf_bank_info = opa;
+	struct adf_accel_dev *accel_dev = vf_bank_info->accel_dev;
+	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+	u32 pf_bank_nr;
+	int ret;
+
+	pf_bank_nr = vf_bank_info->bank_nr + vf_bank_info->vf_nr * hw_data->num_banks_per_vf;
+	ret = hw_data->bank_state_restore(accel_dev, pf_bank_nr,
+					  (struct bank_state *)state);
+	if (ret) {
+		dev_err(&GET_DEV(accel_dev),
+			"Failed to load regs for vf%d bank%d\n",
+			vf_bank_info->vf_nr, vf_bank_info->bank_nr);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int adf_gen4_vfmig_load_etr_bank(struct adf_accel_dev *accel_dev,
+					u32 vf_nr, u32 bank_nr,
+					struct adf_mstate_mgr *mstate_mgr)
+{
+	struct adf_vf_bank_info vf_bank_info = {accel_dev, vf_nr, bank_nr};
+	struct adf_mstate_sect_h *subsec, *l2_subsec;
+	struct adf_mstate_mgr sub_sects_mgr;
+	char bank_ids[ADF_MSTATE_ID_LEN];
+
+	snprintf(bank_ids, sizeof(bank_ids), ADF_MSTATE_BANK_IDX_IDS "%x", bank_nr);
+	subsec = adf_mstate_sect_lookup(mstate_mgr, bank_ids, NULL, NULL);
+	if (!subsec) {
+		dev_err(&GET_DEV(accel_dev),
+			"Failed to lookup sec %s for vf%d bank%d\n",
+			ADF_MSTATE_BANK_IDX_IDS, vf_nr, bank_nr);
+		return -EINVAL;
+	}
+
+	adf_mstate_mgr_init_from_psect(&sub_sects_mgr, subsec);
+	l2_subsec = adf_mstate_sect_lookup(&sub_sects_mgr, ADF_MSTATE_ETR_REGS_IDS,
+					   adf_gen4_vfmig_load_etr_regs,
+					   &vf_bank_info);
+	if (!l2_subsec) {
+		dev_err(&GET_DEV(accel_dev),
+			"Failed to add sec %s for vf%d bank%d\n",
+			ADF_MSTATE_ETR_REGS_IDS, vf_nr, bank_nr);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int adf_gen4_vfmig_load_etr(struct adf_accel_dev *accel_dev, u32 vf_nr)
+{
+	struct adf_accel_vf_info *vf_info = &accel_dev->pf.vf_info[vf_nr];
+	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+	struct adf_gen4_vfmig *vfmig = vf_info->mig_priv;
+	struct adf_mstate_mgr *mstate_mgr = vfmig->mstate_mgr;
+	struct adf_mstate_mgr sub_sects_mgr;
+	struct adf_mstate_sect_h *subsec;
+	int ret, i;
+
+	subsec = adf_mstate_sect_lookup(mstate_mgr, ADF_MSTATE_ETRB_IDS, NULL,
+					NULL);
+	if (!subsec) {
+		dev_err(&GET_DEV(accel_dev), "Failed to load sec %s\n",
+			ADF_MSTATE_ETRB_IDS);
+		return -EINVAL;
+	}
+
+	adf_mstate_mgr_init_from_psect(&sub_sects_mgr, subsec);
+	for (i = 0; i < hw_data->num_banks_per_vf; i++) {
+		ret = adf_gen4_vfmig_load_etr_bank(accel_dev, vf_nr, i,
+						   &sub_sects_mgr);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int adf_gen4_vfmig_load_misc(struct adf_accel_dev *accel_dev, u32 vf_nr)
+{
+	struct adf_accel_vf_info *vf_info = &accel_dev->pf.vf_info[vf_nr];
+	struct adf_gen4_vfmig *vfmig = vf_info->mig_priv;
+	void __iomem *csr = adf_get_pmisc_base(accel_dev);
+	struct adf_mstate_mgr *mstate_mgr = vfmig->mstate_mgr;
+	struct adf_mstate_sect_h *subsec, *l2_subsec;
+	struct adf_mstate_mgr sub_sects_mgr;
+	struct {
+		char *id;
+		u64 ofs;
+	} misc_states[] = {
+		{ADF_MSTATE_VINTMSK_IDS, ADF_GEN4_VINTMSK_OFFSET(vf_nr)},
+		{ADF_MSTATE_VINTMSK_PF2VM_IDS, ADF_GEN4_VINTMSKPF2VM_OFFSET(vf_nr)},
+		{ADF_MSTATE_PF2VM_IDS, ADF_GEN4_PF2VM_OFFSET(vf_nr)},
+		{ADF_MSTATE_VM2PF_IDS, ADF_GEN4_VM2PF_OFFSET(vf_nr)},
+	};
+	int i;
+
+	subsec = adf_mstate_sect_lookup(mstate_mgr, ADF_MSTATE_MISCB_IDS, NULL,
+					NULL);
+	if (!subsec) {
+		dev_err(&GET_DEV(accel_dev), "Failed to load sec %s\n",
+			ADF_MSTATE_MISCB_IDS);
+		return -EINVAL;
+	}
+
+	adf_mstate_mgr_init_from_psect(&sub_sects_mgr, subsec);
+	for (i = 0; i < ARRAY_SIZE(misc_states); i++) {
+		struct adf_mstate_vreginfo info;
+		u32 regv;
+
+		info.addr = &regv;
+		info.size = sizeof(regv);
+		l2_subsec = adf_mstate_sect_lookup(&sub_sects_mgr,
+						   misc_states[i].id,
+						   adf_mstate_set_vreg,
+						   &info);
+		if (!l2_subsec) {
+			dev_err(&GET_DEV(accel_dev),
+				"Failed to load sec %s\n", misc_states[i].id);
+			return -EINVAL;
+		}
+		ADF_CSR_WR(csr, misc_states[i].ofs, regv);
+	}
+
+	return 0;
+}
+
+static int adf_gen4_vfmig_load_generic(struct adf_accel_dev *accel_dev, u32 vf_nr)
+{
+	struct adf_accel_vf_info *vf_info = &accel_dev->pf.vf_info[vf_nr];
+	struct mig_user_sla dst_slas[RL_RP_CNT_PER_LEAF_MAX] = { };
+	struct adf_gen4_vfmig *vfmig = vf_info->mig_priv;
+	struct adf_mstate_mgr *mstate_mgr = vfmig->mstate_mgr;
+	struct adf_mstate_sect_h *subsec, *l2_subsec;
+	struct adf_mstate_mgr sub_sects_mgr;
+	u32 dst_sla_cnt;
+	struct {
+		char *id;
+		int (*action)(struct adf_mstate_mgr *sub_mgr, u8 *buf, u32 size, void *opa);
+		struct adf_mstate_vreginfo info;
+	} gen_states[] = {
+		{ADF_MSTATE_IOV_INIT_IDS, adf_mstate_set_vreg,
+		{&vf_info->init, sizeof(vf_info->init)}},
+		{ADF_MSTATE_COMPAT_VER_IDS, adf_mstate_compatver_check,
+		{&vf_info->vf_compat_ver, sizeof(vf_info->vf_compat_ver)}},
+		{ADF_MSTATE_SLA_IDS, adf_mstate_sla_check, {dst_slas, 0}},
+	};
+	int i;
+
+	subsec = adf_mstate_sect_lookup(mstate_mgr, ADF_MSTATE_GEN_IDS, NULL, NULL);
+	if (!subsec) {
+		dev_err(&GET_DEV(accel_dev), "Failed to load sec %s\n",
+			ADF_MSTATE_GEN_IDS);
+		return -EINVAL;
+	}
+
+	adf_mstate_mgr_init_from_psect(&sub_sects_mgr, subsec);
+	for (i = 0; i < ARRAY_SIZE(gen_states); i++) {
+		if (gen_states[i].info.addr == dst_slas) {
+			dst_sla_cnt = adf_gen4_vfmig_get_slas(accel_dev, vf_nr, dst_slas);
+			gen_states[i].info.size = dst_sla_cnt * sizeof(struct mig_user_sla);
+		}
+
+		l2_subsec = adf_mstate_sect_lookup(&sub_sects_mgr,
+						   gen_states[i].id,
+						   gen_states[i].action,
+						   &gen_states[i].info);
+		if (!l2_subsec) {
+			dev_err(&GET_DEV(accel_dev), "Failed to load sec %s\n",
+				gen_states[i].id);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int adf_gen4_vfmig_load_config(struct adf_accel_dev *accel_dev, u32 vf_nr)
+{
+	struct adf_accel_vf_info *vf_info = &accel_dev->pf.vf_info[vf_nr];
+	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+	struct adf_gen4_vfmig *vfmig = vf_info->mig_priv;
+	struct adf_mstate_mgr *mstate_mgr = vfmig->mstate_mgr;
+	struct adf_mstate_sect_h *subsec, *l2_subsec;
+	struct adf_mstate_mgr sub_sects_mgr;
+	struct {
+		char *id;
+		int (*action)(struct adf_mstate_mgr *sub_mgr, u8 *buf, u32 size, void *opa);
+		struct adf_mstate_vreginfo info;
+	} setups[] = {
+		{ADF_MSTATE_GEN_CAP_IDS, adf_mstate_capmask_superset,
+		{&hw_data->accel_capabilities_mask, sizeof(hw_data->accel_capabilities_mask)}},
+		{ADF_MSTATE_GEN_SVCMAP_IDS, adf_mstate_capmask_equal,
+		{&hw_data->ring_to_svc_map, sizeof(hw_data->ring_to_svc_map)}},
+		{ADF_MSTATE_GEN_EXTDC_IDS, adf_mstate_capmask_superset,
+		{&hw_data->extended_dc_capabilities, sizeof(hw_data->extended_dc_capabilities)}},
+	};
+	int i;
+
+	subsec = adf_mstate_sect_lookup(mstate_mgr, ADF_MSTATE_CONFIG_IDS, NULL, NULL);
+	if (!subsec) {
+		dev_err(&GET_DEV(accel_dev), "Failed to load sec %s\n",
+			ADF_MSTATE_CONFIG_IDS);
+		return -EINVAL;
+	}
+
+	adf_mstate_mgr_init_from_psect(&sub_sects_mgr, subsec);
+	for (i = 0; i < ARRAY_SIZE(setups); i++) {
+		l2_subsec = adf_mstate_sect_lookup(&sub_sects_mgr, setups[i].id,
+						   setups[i].action, &setups[i].info);
+		if (!l2_subsec) {
+			dev_err(&GET_DEV(accel_dev), "Failed to load sec %s\n",
+				setups[i].id);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int adf_gen4_vfmig_save_etr_regs(struct adf_mstate_mgr *subs, u8 *state,
+					u32 size, void *opa)
+{
+	struct adf_vf_bank_info *vf_bank_info = opa;
+	struct adf_accel_dev *accel_dev = vf_bank_info->accel_dev;
+	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+	u32 pf_bank_nr;
+	int ret;
+
+	pf_bank_nr = vf_bank_info->bank_nr;
+	pf_bank_nr += vf_bank_info->vf_nr * hw_data->num_banks_per_vf;
+
+	ret = hw_data->bank_state_save(accel_dev, pf_bank_nr,
+				       (struct bank_state *)state);
+	if (ret) {
+		dev_err(&GET_DEV(accel_dev),
+			"Failed to save regs for vf%d bank%d\n",
+			vf_bank_info->vf_nr, vf_bank_info->bank_nr);
+		return ret;
+	}
+
+	return sizeof(struct bank_state);
+}
+
+static int adf_gen4_vfmig_save_etr_bank(struct adf_accel_dev *accel_dev,
+					u32 vf_nr, u32 bank_nr,
+					struct adf_mstate_mgr *mstate_mgr)
+{
+	struct adf_mstate_sect_h *subsec, *l2_subsec;
+	struct adf_vf_bank_info vf_bank_info;
+	struct adf_mstate_mgr sub_sects_mgr;
+	char bank_ids[ADF_MSTATE_ID_LEN];
+
+	snprintf(bank_ids, sizeof(bank_ids), ADF_MSTATE_BANK_IDX_IDS "%x", bank_nr);
+
+	subsec = adf_mstate_sect_add(mstate_mgr, bank_ids, NULL, NULL);
+	if (!subsec) {
+		dev_err(&GET_DEV(accel_dev),
+			"Failed to add sec %s for vf%d bank%d\n",
+			ADF_MSTATE_BANK_IDX_IDS, vf_nr, bank_nr);
+		return -EINVAL;
+	}
+
+	adf_mstate_mgr_init_from_parent(&sub_sects_mgr, mstate_mgr);
+	vf_bank_info.accel_dev = accel_dev;
+	vf_bank_info.vf_nr = vf_nr;
+	vf_bank_info.bank_nr = bank_nr;
+	l2_subsec = adf_mstate_sect_add(&sub_sects_mgr, ADF_MSTATE_ETR_REGS_IDS,
+					adf_gen4_vfmig_save_etr_regs,
+					&vf_bank_info);
+	if (!l2_subsec) {
+		dev_err(&GET_DEV(accel_dev),
+			"Failed to add sec %s for vf%d bank%d\n",
+			ADF_MSTATE_ETR_REGS_IDS, vf_nr, bank_nr);
+		return -EINVAL;
+	}
+	adf_mstate_sect_update(mstate_mgr, &sub_sects_mgr, subsec);
+
+	return 0;
+}
+
+static int adf_gen4_vfmig_save_etr(struct adf_accel_dev *accel_dev, u32 vf_nr)
+{
+	struct adf_accel_vf_info *vf_info = &accel_dev->pf.vf_info[vf_nr];
+	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+	struct adf_gen4_vfmig *vfmig = vf_info->mig_priv;
+	struct adf_mstate_mgr *mstate_mgr = vfmig->mstate_mgr;
+	struct adf_mstate_mgr sub_sects_mgr;
+	struct adf_mstate_sect_h *subsec;
+	int ret, i;
+
+	subsec = adf_mstate_sect_add(mstate_mgr, ADF_MSTATE_ETRB_IDS, NULL, NULL);
+	if (!subsec) {
+		dev_err(&GET_DEV(accel_dev), "Failed to add sec %s\n",
+			ADF_MSTATE_ETRB_IDS);
+		return -EINVAL;
+	}
+
+	adf_mstate_mgr_init_from_parent(&sub_sects_mgr, mstate_mgr);
+	for (i = 0; i < hw_data->num_banks_per_vf; i++) {
+		ret = adf_gen4_vfmig_save_etr_bank(accel_dev, vf_nr, i,
+						   &sub_sects_mgr);
+		if (ret)
+			return ret;
+	}
+	adf_mstate_sect_update(mstate_mgr, &sub_sects_mgr, subsec);
+
+	return 0;
+}
+
+static int adf_gen4_vfmig_save_misc(struct adf_accel_dev *accel_dev, u32 vf_nr)
+{
+	struct adf_accel_vf_info *vf_info = &accel_dev->pf.vf_info[vf_nr];
+	struct adf_gen4_vfmig *vfmig = vf_info->mig_priv;
+	struct adf_mstate_mgr *mstate_mgr = vfmig->mstate_mgr;
+	void __iomem *csr = adf_get_pmisc_base(accel_dev);
+	struct adf_mstate_sect_h *subsec, *l2_subsec;
+	struct adf_mstate_mgr sub_sects_mgr;
+	struct {
+		char *id;
+		u64 offset;
+	} misc_states[] = {
+		{ADF_MSTATE_VINTSRC_IDS, ADF_GEN4_VINTSOU_OFFSET(vf_nr)},
+		{ADF_MSTATE_VINTMSK_IDS, ADF_GEN4_VINTMSK_OFFSET(vf_nr)},
+		{ADF_MSTATE_VINTSRC_PF2VM_IDS, ADF_GEN4_VINTSOUPF2VM_OFFSET(vf_nr)},
+		{ADF_MSTATE_VINTMSK_PF2VM_IDS, ADF_GEN4_VINTMSKPF2VM_OFFSET(vf_nr)},
+		{ADF_MSTATE_PF2VM_IDS, ADF_GEN4_PF2VM_OFFSET(vf_nr)},
+		{ADF_MSTATE_VM2PF_IDS, ADF_GEN4_VM2PF_OFFSET(vf_nr)},
+	};
+	ktime_t time_exp;
+	int i;
+
+	subsec = adf_mstate_sect_add(mstate_mgr, ADF_MSTATE_MISCB_IDS, NULL, NULL);
+	if (!subsec) {
+		dev_err(&GET_DEV(accel_dev), "Failed to add sec %s\n",
+			ADF_MSTATE_MISCB_IDS);
+		return -EINVAL;
+	}
+
+	time_exp = ktime_add_us(ktime_get(), ADF_GEN4_PFVF_RSP_TIMEOUT_US);
+	while (!mutex_trylock(&vf_info->pfvf_mig_lock)) {
+		if (ktime_after(ktime_get(), time_exp)) {
+			dev_err(&GET_DEV(accel_dev), "Failed to get pfvf mig lock\n");
+			return -ETIMEDOUT;
+		}
+		usleep_range(500, 1000);
+	}
+
+	adf_mstate_mgr_init_from_parent(&sub_sects_mgr, mstate_mgr);
+	for (i = 0; i < ARRAY_SIZE(misc_states); i++) {
+		struct adf_mstate_vreginfo info;
+		u32 regv;
+
+		info.addr = &regv;
+		info.size = sizeof(regv);
+		regv = ADF_CSR_RD(csr, misc_states[i].offset);
+
+		l2_subsec = adf_mstate_sect_add_vreg(&sub_sects_mgr,
+						     misc_states[i].id,
+						     &info);
+		if (!l2_subsec) {
+			dev_err(&GET_DEV(accel_dev), "Failed to add sec %s\n",
+				misc_states[i].id);
+			mutex_unlock(&vf_info->pfvf_mig_lock);
+			return -EINVAL;
+		}
+	}
+
+	mutex_unlock(&vf_info->pfvf_mig_lock);
+	adf_mstate_sect_update(mstate_mgr, &sub_sects_mgr, subsec);
+
+	return 0;
+}
+
+static int adf_gen4_vfmig_save_generic(struct adf_accel_dev *accel_dev, u32 vf_nr)
+{
+	struct adf_accel_vf_info *vf_info = &accel_dev->pf.vf_info[vf_nr];
+	struct adf_gen4_vfmig *vfmig = vf_info->mig_priv;
+	struct adf_mstate_mgr *mstate_mgr = vfmig->mstate_mgr;
+	struct adf_mstate_mgr sub_sects_mgr;
+	struct adf_mstate_sect_h *subsec, *l2_subsec;
+	struct mig_user_sla src_slas[RL_RP_CNT_PER_LEAF_MAX] = { };
+	u32 src_sla_cnt;
+	struct {
+		char *id;
+		struct adf_mstate_vreginfo info;
+	} gen_states[] = {
+		{ADF_MSTATE_IOV_INIT_IDS,
+		{&vf_info->init, sizeof(vf_info->init)}},
+		{ADF_MSTATE_COMPAT_VER_IDS,
+		{&vf_info->vf_compat_ver, sizeof(vf_info->vf_compat_ver)}},
+		{ADF_MSTATE_SLA_IDS, {src_slas, 0}},
+	};
+	int i;
+
+	subsec = adf_mstate_sect_add(mstate_mgr, ADF_MSTATE_GEN_IDS, NULL, NULL);
+	if (!subsec) {
+		dev_err(&GET_DEV(accel_dev), "Failed to add sec %s\n",
+			ADF_MSTATE_GEN_IDS);
+		return -EINVAL;
+	}
+
+	adf_mstate_mgr_init_from_parent(&sub_sects_mgr, mstate_mgr);
+	for (i = 0; i < ARRAY_SIZE(gen_states); i++) {
+		if (gen_states[i].info.addr == src_slas) {
+			src_sla_cnt = adf_gen4_vfmig_get_slas(accel_dev, vf_nr, src_slas);
+			gen_states[i].info.size = src_sla_cnt * sizeof(struct mig_user_sla);
+		}
+
+		l2_subsec = adf_mstate_sect_add_vreg(&sub_sects_mgr,
+						     gen_states[i].id,
+						     &gen_states[i].info);
+		if (!l2_subsec) {
+			dev_err(&GET_DEV(accel_dev), "Failed to add sec %s\n",
+				gen_states[i].id);
+			return -EINVAL;
+		}
+	}
+	adf_mstate_sect_update(mstate_mgr, &sub_sects_mgr, subsec);
+
+	return 0;
+}
+
+static int adf_gen4_vfmig_save_config(struct adf_accel_dev *accel_dev, u32 vf_nr)
+{
+	struct adf_accel_vf_info *vf_info = &accel_dev->pf.vf_info[vf_nr];
+	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+	struct adf_gen4_vfmig *vfmig = vf_info->mig_priv;
+	struct adf_mstate_mgr *mstate_mgr = vfmig->mstate_mgr;
+	struct adf_mstate_mgr sub_sects_mgr;
+	struct adf_mstate_sect_h *subsec, *l2_subsec;
+	struct {
+		char *id;
+		struct adf_mstate_vreginfo info;
+	} setups[] = {
+		{ADF_MSTATE_GEN_CAP_IDS,
+		{&hw_data->accel_capabilities_mask, sizeof(hw_data->accel_capabilities_mask)}},
+		{ADF_MSTATE_GEN_SVCMAP_IDS,
+		{&hw_data->ring_to_svc_map, sizeof(hw_data->ring_to_svc_map)}},
+		{ADF_MSTATE_GEN_EXTDC_IDS,
+		{&hw_data->extended_dc_capabilities, sizeof(hw_data->extended_dc_capabilities)}},
+	};
+	int i;
+
+	subsec = adf_mstate_sect_add(mstate_mgr, ADF_MSTATE_CONFIG_IDS, NULL, NULL);
+	if (!subsec) {
+		dev_err(&GET_DEV(accel_dev), "Failed to add sec %s\n",
+			ADF_MSTATE_CONFIG_IDS);
+		return -EINVAL;
+	}
+
+	adf_mstate_mgr_init_from_parent(&sub_sects_mgr, mstate_mgr);
+	for (i = 0; i < ARRAY_SIZE(setups); i++) {
+		l2_subsec = adf_mstate_sect_add_vreg(&sub_sects_mgr, setups[i].id,
+						     &setups[i].info);
+		if (!l2_subsec) {
+			dev_err(&GET_DEV(accel_dev), "Failed to add sec %s\n",
+				setups[i].id);
+			return -EINVAL;
+		}
+	}
+	adf_mstate_sect_update(mstate_mgr, &sub_sects_mgr, subsec);
+
+	return 0;
+}
+
+static int adf_gen4_vfmig_save_state(struct qat_mig_dev *mdev)
+{
+	struct adf_accel_dev *accel_dev = mdev->parent_accel_dev;
+	struct adf_accel_vf_info *vf_info;
+	struct adf_gen4_vfmig *vfmig;
+	u32 vf_nr = mdev->vf_id;
+	int ret;
+
+	vf_info = &accel_dev->pf.vf_info[vf_nr];
+	vfmig = vf_info->mig_priv;
+
+	ret = adf_gen4_vfmig_save_setup(mdev);
+	if (ret) {
+		dev_err(&GET_DEV(accel_dev),
+			"Failed to save setup for vf_nr %d\n", vf_nr);
+		return ret;
+	}
+
+	adf_mstate_mgr_init(vfmig->mstate_mgr, mdev->state + mdev->setup_size,
+			    mdev->state_size - mdev->setup_size);
+	if (!adf_mstate_preamble_add(vfmig->mstate_mgr))
+		return -EINVAL;
+
+	ret = adf_gen4_vfmig_save_generic(accel_dev, vf_nr);
+	if (ret) {
+		dev_err(&GET_DEV(accel_dev),
+			"Failed to save generic state for vf_nr %d\n", vf_nr);
+		return ret;
+	}
+
+	ret = adf_gen4_vfmig_save_misc(accel_dev, vf_nr);
+	if (ret) {
+		dev_err(&GET_DEV(accel_dev),
+			"Failed to save misc bar state for vf_nr %d\n", vf_nr);
+		return ret;
+	}
+
+	ret = adf_gen4_vfmig_save_etr(accel_dev, vf_nr);
+	if (ret) {
+		dev_err(&GET_DEV(accel_dev),
+			"Failed to save etr bar state for vf_nr %d\n", vf_nr);
+		return ret;
+	}
+
+	adf_mstate_preamble_update(vfmig->mstate_mgr);
+
+	return 0;
+}
+
+static int adf_gen4_vfmig_load_state(struct qat_mig_dev *mdev)
+{
+	struct adf_accel_dev *accel_dev = mdev->parent_accel_dev;
+	struct adf_accel_vf_info *vf_info;
+	struct adf_gen4_vfmig *vfmig;
+	u32 vf_nr = mdev->vf_id;
+	int ret;
+
+	vf_info = &accel_dev->pf.vf_info[vf_nr];
+	vfmig = vf_info->mig_priv;
+
+	ret = adf_gen4_vfmig_load_setup(mdev, mdev->state_size);
+	if (ret) {
+		dev_err(&GET_DEV(accel_dev), "Failed to load setup for vf_nr %d\n",
+			vf_nr);
+		return ret;
+	}
+
+	ret = adf_mstate_mgr_init_from_remote(vfmig->mstate_mgr,
+					      mdev->state + mdev->remote_setup_size,
+					      mdev->state_size - mdev->remote_setup_size,
+					      NULL, NULL);
+	if (ret) {
+		dev_err(&GET_DEV(accel_dev), "Invalid state for vf_nr %d\n",
+			vf_nr);
+		return ret;
+	}
+
+	ret = adf_gen4_vfmig_load_generic(accel_dev, vf_nr);
+	if (ret) {
+		dev_err(&GET_DEV(accel_dev),
+			"Failed to load general state for vf_nr %d\n", vf_nr);
+		return ret;
+	}
+
+	ret = adf_gen4_vfmig_load_misc(accel_dev, vf_nr);
+	if (ret) {
+		dev_err(&GET_DEV(accel_dev),
+			"Failed to load misc bar state for vf_nr %d\n", vf_nr);
+		return ret;
+	}
+
+	ret = adf_gen4_vfmig_load_etr(accel_dev, vf_nr);
+	if (ret) {
+		dev_err(&GET_DEV(accel_dev),
+			"Failed to load etr bar state for vf_nr %d\n", vf_nr);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int adf_gen4_vfmig_save_setup(struct qat_mig_dev *mdev)
+{
+	struct adf_accel_dev *accel_dev = mdev->parent_accel_dev;
+	struct adf_accel_vf_info *vf_info;
+	struct adf_gen4_vfmig *vfmig;
+	u32 vf_nr = mdev->vf_id;
+	int ret;
+
+	vf_info = &accel_dev->pf.vf_info[vf_nr];
+	vfmig = vf_info->mig_priv;
+
+	if (mdev->setup_size)
+		return 0;
+
+	adf_mstate_mgr_init(vfmig->mstate_mgr, mdev->state, mdev->state_size);
+	if (!adf_mstate_preamble_add(vfmig->mstate_mgr))
+		return -EINVAL;
+
+	ret = adf_gen4_vfmig_save_config(accel_dev, mdev->vf_id);
+	if (ret)
+		return ret;
+
+	adf_mstate_preamble_update(vfmig->mstate_mgr);
+	mdev->setup_size = adf_mstate_state_size(vfmig->mstate_mgr);
+
+	return 0;
+}
+
+static int adf_gen4_vfmig_load_setup(struct qat_mig_dev *mdev, int len)
+{
+	struct adf_accel_dev *accel_dev = mdev->parent_accel_dev;
+	struct adf_accel_vf_info *vf_info;
+	struct adf_gen4_vfmig *vfmig;
+	u32 vf_nr = mdev->vf_id;
+	u32 setup_size;
+	int ret;
+
+	vf_info = &accel_dev->pf.vf_info[vf_nr];
+	vfmig = vf_info->mig_priv;
+
+	if (mdev->remote_setup_size)
+		return 0;
+
+	if (len < sizeof(struct adf_mstate_preh))
+		return -EAGAIN;
+
+	adf_mstate_mgr_init(vfmig->mstate_mgr, mdev->state, mdev->state_size);
+	setup_size = adf_mstate_state_size_from_remote(vfmig->mstate_mgr);
+	if (setup_size > mdev->state_size)
+		return -EINVAL;
+
+	if (len < setup_size)
+		return -EAGAIN;
+
+	ret = adf_mstate_mgr_init_from_remote(vfmig->mstate_mgr, mdev->state,
+					      setup_size, NULL, NULL);
+	if (ret) {
+		dev_err(&GET_DEV(accel_dev), "Invalide setup for vf_nr %d\n",
+			vf_nr);
+		return ret;
+	}
+
+	mdev->remote_setup_size = setup_size;
+
+	ret = adf_gen4_vfmig_load_config(accel_dev, vf_nr);
+	if (ret) {
+		dev_err(&GET_DEV(accel_dev),
+			"Failed to load config for vf_nr %d\n", vf_nr);
+		return ret;
+	}
+
+	return 0;
+}
+
+void adf_gen4_init_vf_mig_ops(struct qat_migdev_ops *vfmig_ops)
+{
+	vfmig_ops->init = adf_gen4_vfmig_init_device;
+	vfmig_ops->cleanup = adf_gen4_vfmig_cleanup_device;
+	vfmig_ops->reset = adf_gen4_vfmig_reset_device;
+	vfmig_ops->open = adf_gen4_vfmig_open_device;
+	vfmig_ops->close = adf_gen4_vfmig_close_device;
+	vfmig_ops->suspend = adf_gen4_vfmig_suspend_device;
+	vfmig_ops->resume = adf_gen4_vfmig_resume_device;
+	vfmig_ops->save_state = adf_gen4_vfmig_save_state;
+	vfmig_ops->load_state = adf_gen4_vfmig_load_state;
+	vfmig_ops->load_setup = adf_gen4_vfmig_load_setup;
+	vfmig_ops->save_setup = adf_gen4_vfmig_save_setup;
+}
+EXPORT_SYMBOL_GPL(adf_gen4_init_vf_mig_ops);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_mstate_mgr.c b/drivers/crypto/intel/qat/qat_common/adf_mstate_mgr.c
new file mode 100644
index 000000000000..41cc763a74aa
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_mstate_mgr.c
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024 Intel Corporation */
+
+#include <linux/slab.h>
+#include <linux/types.h>
+#include "adf_mstate_mgr.h"
+
+#define ADF_MSTATE_MAGIC	0xADF5CAEA
+#define ADF_MSTATE_VERSION	0x1
+
+struct adf_mstate_sect_h {
+	u8 id[ADF_MSTATE_ID_LEN];
+	u32 size;
+	u32 sub_sects;
+	u8 state[];
+};
+
+u32 adf_mstate_state_size(struct adf_mstate_mgr *mgr)
+{
+	return mgr->state - mgr->buf;
+}
+
+static inline u32 adf_mstate_avail_room(struct adf_mstate_mgr *mgr)
+{
+	return mgr->buf + mgr->size - mgr->state;
+}
+
+void adf_mstate_mgr_init(struct adf_mstate_mgr *mgr, u8 *buf, u32 size)
+{
+	mgr->buf = buf;
+	mgr->state = buf;
+	mgr->size = size;
+	mgr->n_sects = 0;
+};
+
+struct adf_mstate_mgr *adf_mstate_mgr_new(u8 *buf, u32 size)
+{
+	struct adf_mstate_mgr *mgr;
+
+	mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
+	if (!mgr)
+		return NULL;
+
+	adf_mstate_mgr_init(mgr, buf, size);
+
+	return mgr;
+}
+
+void adf_mstate_mgr_destroy(struct adf_mstate_mgr *mgr)
+{
+	kfree(mgr);
+}
+
+void adf_mstate_mgr_init_from_parent(struct adf_mstate_mgr *mgr,
+				     struct adf_mstate_mgr *p_mgr)
+{
+	adf_mstate_mgr_init(mgr, p_mgr->state,
+			    p_mgr->size - adf_mstate_state_size(p_mgr));
+}
+
+void adf_mstate_mgr_init_from_psect(struct adf_mstate_mgr *mgr,
+				    struct adf_mstate_sect_h *p_sect)
+{
+	adf_mstate_mgr_init(mgr, p_sect->state, p_sect->size);
+	mgr->n_sects = p_sect->sub_sects;
+}
+
+static void adf_mstate_preamble_init(struct adf_mstate_preh *preamble)
+{
+	preamble->magic = ADF_MSTATE_MAGIC;
+	preamble->version = ADF_MSTATE_VERSION;
+	preamble->preh_len = sizeof(*preamble);
+	preamble->size = 0;
+	preamble->n_sects = 0;
+}
+
+/* default preambles checker */
+static int adf_mstate_preamble_def_checker(struct adf_mstate_preh *preamble,
+					   void *opaque)
+{
+	struct adf_mstate_mgr *mgr = opaque;
+
+	if (preamble->magic != ADF_MSTATE_MAGIC ||
+	    preamble->version > ADF_MSTATE_VERSION ||
+	    preamble->preh_len > mgr->size) {
+		pr_debug("QAT: LM - Invalid state (magic=%#x, version=%#x, hlen=%u), state_size=%u\n",
+			 preamble->magic, preamble->version, preamble->preh_len,
+			 mgr->size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+struct adf_mstate_preh *adf_mstate_preamble_add(struct adf_mstate_mgr *mgr)
+{
+	struct adf_mstate_preh *pre = (struct adf_mstate_preh *)mgr->buf;
+
+	if (adf_mstate_avail_room(mgr) < sizeof(*pre)) {
+		pr_err("QAT: LM - Not enough space for preamble\n");
+		return NULL;
+	}
+
+	adf_mstate_preamble_init(pre);
+	mgr->state += pre->preh_len;
+
+	return pre;
+}
+
+int adf_mstate_preamble_update(struct adf_mstate_mgr *mgr)
+{
+	struct adf_mstate_preh *preamble = (struct adf_mstate_preh *)mgr->buf;
+
+	preamble->size = adf_mstate_state_size(mgr) - preamble->preh_len;
+	preamble->n_sects = mgr->n_sects;
+
+	return 0;
+}
+
+static void adf_mstate_dump_sect(struct adf_mstate_sect_h *sect,
+				 const char *prefix)
+{
+	pr_debug("QAT: LM - %s QAT state section %s\n", prefix, sect->id);
+	print_hex_dump_debug("h-", DUMP_PREFIX_OFFSET, 16, 2, sect,
+			     sizeof(*sect), true);
+	print_hex_dump_debug("s-", DUMP_PREFIX_OFFSET, 16, 2, sect->state,
+			     sect->size, true);
+}
+
+static inline void __adf_mstate_sect_update(struct adf_mstate_mgr *mgr,
+					    struct adf_mstate_sect_h *sect,
+					    u32 size,
+					    u32 n_subsects)
+{
+	sect->size += size;
+	sect->sub_sects += n_subsects;
+	mgr->n_sects++;
+	mgr->state += sect->size;
+
+	adf_mstate_dump_sect(sect, "Add");
+}
+
+void adf_mstate_sect_update(struct adf_mstate_mgr *p_mgr,
+			    struct adf_mstate_mgr *curr_mgr,
+			    struct adf_mstate_sect_h *sect)
+{
+	__adf_mstate_sect_update(p_mgr, sect, adf_mstate_state_size(curr_mgr),
+				 curr_mgr->n_sects);
+}
+
+static struct adf_mstate_sect_h *adf_mstate_sect_add_header(struct adf_mstate_mgr *mgr,
+							    const char *id)
+{
+	struct adf_mstate_sect_h *sect = (struct adf_mstate_sect_h *)(mgr->state);
+
+	if (adf_mstate_avail_room(mgr) < sizeof(*sect)) {
+		pr_debug("QAT: LM - Not enough space for header of QAT state sect %s\n", id);
+		return NULL;
+	}
+
+	strscpy(sect->id, id, sizeof(sect->id));
+	sect->size = 0;
+	sect->sub_sects = 0;
+	mgr->state += sizeof(*sect);
+
+	return sect;
+}
+
+struct adf_mstate_sect_h *adf_mstate_sect_add_vreg(struct adf_mstate_mgr *mgr,
+						   const char *id,
+						   struct adf_mstate_vreginfo *info)
+{
+	struct adf_mstate_sect_h *sect;
+
+	sect = adf_mstate_sect_add_header(mgr, id);
+	if (!sect)
+		return NULL;
+
+	if (adf_mstate_avail_room(mgr) < info->size) {
+		pr_debug("QAT: LM - Not enough space for QAT state sect %s, requires %u\n",
+			 id, info->size);
+		return NULL;
+	}
+
+	memcpy(sect->state, info->addr, info->size);
+	__adf_mstate_sect_update(mgr, sect, info->size, 0);
+
+	return sect;
+}
+
+struct adf_mstate_sect_h *adf_mstate_sect_add(struct adf_mstate_mgr *mgr,
+					      const char *id,
+					      adf_mstate_populate populate,
+					      void *opaque)
+{
+	struct adf_mstate_mgr sub_sects_mgr;
+	struct adf_mstate_sect_h *sect;
+	int avail_room, size;
+
+	sect = adf_mstate_sect_add_header(mgr, id);
+	if (!sect)
+		return NULL;
+
+	if (!populate)
+		return sect;
+
+	avail_room = adf_mstate_avail_room(mgr);
+	adf_mstate_mgr_init_from_parent(&sub_sects_mgr, mgr);
+
+	size = (*populate)(&sub_sects_mgr, sect->state, avail_room, opaque);
+	if (size < 0)
+		return NULL;
+
+	size += adf_mstate_state_size(&sub_sects_mgr);
+	if (avail_room < size) {
+		pr_debug("QAT: LM - Not enough space for QAT state sect %s, requires %u\n",
+			 id, size);
+		return NULL;
+	}
+	__adf_mstate_sect_update(mgr, sect, size, sub_sects_mgr.n_sects);
+
+	return sect;
+}
+
+static int adf_mstate_sect_validate(struct adf_mstate_mgr *mgr)
+{
+	struct adf_mstate_sect_h *start = (struct adf_mstate_sect_h *)mgr->state;
+	struct adf_mstate_sect_h *sect = start;
+	u64 end;
+	int i;
+
+	end = (uintptr_t)mgr->buf + mgr->size;
+	for (i = 0; i < mgr->n_sects; i++) {
+		uintptr_t s_start = (uintptr_t)sect->state;
+		uintptr_t s_end = s_start + sect->size;
+
+		if (s_end < s_start || s_end > end) {
+			pr_debug("QAT: LM - Corrupted state section (index=%u, size=%u) in state_mgr (size=%u, secs=%u)\n",
+				 i, sect->size, mgr->size, mgr->n_sects);
+			return -EINVAL;
+		}
+		sect = (struct adf_mstate_sect_h *)s_end;
+	}
+
+	pr_debug("QAT: LM - Scanned section (last child=%s, size=%lu) in state_mgr (size=%u, secs=%u)\n",
+		 start->id, sizeof(struct adf_mstate_sect_h) * (ulong)(sect - start),
+		 mgr->size, mgr->n_sects);
+
+	return 0;
+}
+
+u32 adf_mstate_state_size_from_remote(struct adf_mstate_mgr *mgr)
+{
+	struct adf_mstate_preh *preh = (struct adf_mstate_preh *)mgr->buf;
+
+	return preh->preh_len + preh->size;
+}
+
+int adf_mstate_mgr_init_from_remote(struct adf_mstate_mgr *mgr, u8 *buf, u32 size,
+				    adf_mstate_preamble_checker pre_checker,
+				    void *opaque)
+{
+	struct adf_mstate_preh *pre;
+	int ret;
+
+	adf_mstate_mgr_init(mgr, buf, size);
+	pre = (struct adf_mstate_preh *)(mgr->buf);
+
+	pr_debug("QAT: LM - Dump state preambles\n");
+	print_hex_dump_debug("", DUMP_PREFIX_OFFSET, 16, 2, pre, pre->preh_len, 0);
+
+	if (pre_checker)
+		ret = (*pre_checker)(pre, opaque);
+	else
+		ret = adf_mstate_preamble_def_checker(pre, mgr);
+	if (ret)
+		return ret;
+
+	mgr->state = mgr->buf + pre->preh_len;
+	mgr->n_sects = pre->n_sects;
+
+	return adf_mstate_sect_validate(mgr);
+}
+
+struct adf_mstate_sect_h *adf_mstate_sect_lookup(struct adf_mstate_mgr *mgr,
+						 const char *id,
+						 adf_mstate_action action,
+						 void *opaque)
+{
+	struct adf_mstate_sect_h *sect = (struct adf_mstate_sect_h *)mgr->state;
+	struct adf_mstate_mgr sub_sects_mgr;
+	int i, ret;
+
+	for (i = 0; i < mgr->n_sects; i++) {
+		if (!strncmp(sect->id, id, sizeof(sect->id)))
+			goto found;
+
+		sect = (struct adf_mstate_sect_h *)(sect->state + sect->size);
+	}
+
+	return NULL;
+
+found:
+	adf_mstate_dump_sect(sect, "Found");
+
+	adf_mstate_mgr_init_from_psect(&sub_sects_mgr, sect);
+	if (sect->sub_sects && adf_mstate_sect_validate(&sub_sects_mgr))
+		return NULL;
+
+	if (!action)
+		return sect;
+
+	ret = (*action)(&sub_sects_mgr, sect->state, sect->size, opaque);
+	if (ret)
+		return NULL;
+
+	return sect;
+}
diff --git a/drivers/crypto/intel/qat/qat_common/adf_mstate_mgr.h b/drivers/crypto/intel/qat/qat_common/adf_mstate_mgr.h
new file mode 100644
index 000000000000..81d263a596c5
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_mstate_mgr.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2024 Intel Corporation */
+
+#ifndef ADF_MSTATE_MGR_H
+#define ADF_MSTATE_MGR_H
+
+#define ADF_MSTATE_ID_LEN		8
+
+#define ADF_MSTATE_ETRB_IDS		"ETRBAR"
+#define ADF_MSTATE_MISCB_IDS		"MISCBAR"
+#define ADF_MSTATE_EXTB_IDS		"EXTBAR"
+#define ADF_MSTATE_GEN_IDS		"GENER"
+#define ADF_MSTATE_CONFIG_IDS		"CONFIG"
+#define ADF_MSTATE_SECTION_NUM		5
+
+#define ADF_MSTATE_BANK_IDX_IDS		"bnk"
+
+#define ADF_MSTATE_ETR_REGS_IDS		"mregs"
+#define ADF_MSTATE_VINTSRC_IDS		"visrc"
+#define ADF_MSTATE_VINTMSK_IDS		"vimsk"
+#define ADF_MSTATE_SLA_IDS		"sla"
+#define ADF_MSTATE_IOV_INIT_IDS		"iovinit"
+#define ADF_MSTATE_COMPAT_VER_IDS	"compver"
+#define ADF_MSTATE_GEN_CAP_IDS		"gencap"
+#define ADF_MSTATE_GEN_SVCMAP_IDS	"svcmap"
+#define ADF_MSTATE_GEN_EXTDC_IDS	"extdc"
+#define ADF_MSTATE_VINTSRC_PF2VM_IDS	"vispv"
+#define ADF_MSTATE_VINTMSK_PF2VM_IDS	"vimpv"
+#define ADF_MSTATE_VM2PF_IDS		"vm2pf"
+#define ADF_MSTATE_PF2VM_IDS		"pf2vm"
+
+struct adf_mstate_mgr {
+	u8 *buf;
+	u8 *state;
+	u32 size;
+	u32 n_sects;
+};
+
+struct adf_mstate_preh {
+	u32 magic;
+	u32 version;
+	u16 preh_len;
+	u16 n_sects;
+	u32 size;
+};
+
+struct adf_mstate_vreginfo {
+	void *addr;
+	u32 size;
+};
+
+struct adf_mstate_sect_h;
+
+typedef int (*adf_mstate_preamble_checker)(struct adf_mstate_preh *preamble, void *opa);
+typedef int (*adf_mstate_populate)(struct adf_mstate_mgr *sub_mgr, u8 *buf,
+				   u32 size, void *opa);
+typedef int (*adf_mstate_action)(struct adf_mstate_mgr *sub_mgr, u8 *buf, u32 size,
+				 void *opa);
+
+struct adf_mstate_mgr *adf_mstate_mgr_new(u8 *buf, u32 size);
+void adf_mstate_mgr_destroy(struct adf_mstate_mgr *mgr);
+void adf_mstate_mgr_init(struct adf_mstate_mgr *mgr, u8 *buf, u32 size);
+void adf_mstate_mgr_init_from_parent(struct adf_mstate_mgr *mgr,
+				     struct adf_mstate_mgr *p_mgr);
+void adf_mstate_mgr_init_from_psect(struct adf_mstate_mgr *mgr,
+				    struct adf_mstate_sect_h *p_sect);
+int adf_mstate_mgr_init_from_remote(struct adf_mstate_mgr *mgr,
+				    u8 *buf, u32 size,
+				    adf_mstate_preamble_checker checker,
+				    void *opaque);
+struct adf_mstate_preh *adf_mstate_preamble_add(struct adf_mstate_mgr *mgr);
+int adf_mstate_preamble_update(struct adf_mstate_mgr *mgr);
+u32 adf_mstate_state_size(struct adf_mstate_mgr *mgr);
+u32 adf_mstate_state_size_from_remote(struct adf_mstate_mgr *mgr);
+void adf_mstate_sect_update(struct adf_mstate_mgr *p_mgr,
+			    struct adf_mstate_mgr *curr_mgr,
+			    struct adf_mstate_sect_h *sect);
+struct adf_mstate_sect_h *adf_mstate_sect_add_vreg(struct adf_mstate_mgr *mgr,
+						   const char *id,
+						   struct adf_mstate_vreginfo *info);
+struct adf_mstate_sect_h *adf_mstate_sect_add(struct adf_mstate_mgr *mgr,
+					      const char *id,
+					      adf_mstate_populate populate,
+					      void *opaque);
+struct adf_mstate_sect_h *adf_mstate_sect_lookup(struct adf_mstate_mgr *mgr,
+						 const char *id,
+						 adf_mstate_action action,
+						 void *opaque);
+#endif
diff --git a/drivers/crypto/intel/qat/qat_common/adf_sriov.c b/drivers/crypto/intel/qat/qat_common/adf_sriov.c
index 87a70c00c41e..8d645e7e04aa 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_sriov.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_sriov.c
@@ -26,10 +26,12 @@ static void adf_iov_send_resp(struct work_struct *work)
 	u32 vf_nr = vf_info->vf_nr;
 	bool ret;
 
+	mutex_lock(&vf_info->pfvf_mig_lock);
 	ret = adf_recv_and_handle_vf2pf_msg(accel_dev, vf_nr);
 	if (ret)
 		/* re-enable interrupt on PF from this VF */
 		adf_enable_vf2pf_interrupts(accel_dev, 1 << vf_nr);
+	mutex_unlock(&vf_info->pfvf_mig_lock);
 
 	kfree(pf2vf_resp);
 }
@@ -62,6 +64,7 @@ static int adf_enable_sriov(struct adf_accel_dev *accel_dev)
 		vf_info->vf_nr = i;
 
 		mutex_init(&vf_info->pf2vf_lock);
+		mutex_init(&vf_info->pfvf_mig_lock);
 		ratelimit_state_init(&vf_info->vf2pf_ratelimit,
 				     ADF_VF2PF_RATELIMIT_INTERVAL,
 				     ADF_VF2PF_RATELIMIT_BURST);
@@ -138,8 +141,10 @@ void adf_disable_sriov(struct adf_accel_dev *accel_dev)
 	if (hw_data->configure_iov_threads)
 		hw_data->configure_iov_threads(accel_dev, false);
 
-	for (i = 0, vf = accel_dev->pf.vf_info; i < totalvfs; i++, vf++)
+	for (i = 0, vf = accel_dev->pf.vf_info; i < totalvfs; i++, vf++) {
 		mutex_destroy(&vf->pf2vf_lock);
+		mutex_destroy(&vf->pfvf_mig_lock);
+	}
 
 	if (!test_bit(ADF_STATUS_RESTARTING, &accel_dev->status)) {
 		kfree(accel_dev->pf.vf_info);
-- 
2.18.2



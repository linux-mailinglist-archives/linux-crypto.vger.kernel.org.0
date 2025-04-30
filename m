Return-Path: <linux-crypto+bounces-12542-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A51AA4A37
	for <lists+linux-crypto@lfdr.de>; Wed, 30 Apr 2025 13:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 880C97AF4BB
	for <lists+linux-crypto@lfdr.de>; Wed, 30 Apr 2025 11:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC6D231848;
	Wed, 30 Apr 2025 11:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UQURQYwV"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1982586C1
	for <linux-crypto@vger.kernel.org>; Wed, 30 Apr 2025 11:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746012930; cv=none; b=gq7mbb8VMHEZ0D0IZp8zFOhZmZt1dr9HFfDTu8Waxgz9Twu9fdZm7eNyknXpB/P0nWlxGNYzhZrWFDP6KNVDGaRFgseGXYhXrxoO9tpGhudgbjjYmm9SSnJbQrQvN3/zQwyEDVzrepjs47h04pL2LJWSib07TaNQE5/BOr+NrnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746012930; c=relaxed/simple;
	bh=hwLo/3WEedi5/Xs3uD+Agmqmi20Br/JAmWTB6if3cb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S0HW091qXJ6rN/kBu7WGJWcxqO62EW2aTn5e1dd2m1xAVvMUull0KX/5nfhi5Edv/uPiv5gROIyCq0IZt/uOUu5/r81Rzj044X2uobpfAwAvuhGsbrBFflcq5LShnKPy+To0vmob6p2bS/7irjlBs8C4sVw0uMjrYu04/sefI4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UQURQYwV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746012924; x=1777548924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hwLo/3WEedi5/Xs3uD+Agmqmi20Br/JAmWTB6if3cb0=;
  b=UQURQYwVj72UsgHvYN5WgYXCbOgaRd4AMI78Jp4+14Wl3xEdSCM2DjIH
   rePkS1QGq9NQiQU7yfr7jaW7FsF+f45Ss6NGhFFLLTbI+dxed9l7nZL/U
   vsneeLO1fgbfJkwjvANeC3NMP2ghurwVSIyvQPopsm7y8V2QDFwQNz1oR
   fhHYQgnCXp0K1rahiGVZkFKXt0SgXfcvTQmO737hjJgbcYg3G3iSfswz3
   x6k6rUfs59ImJbPSxJI+PR+3xTAXUvCHwkaVMobZMEFgJtxqaHXWQOKqH
   W3U6lmbN1+maRs8EFuTcydP5uBqfKyWu2Ekh/MT3SZNZ/ecqEmYv19cod
   A==;
X-CSE-ConnectionGUID: umSK+EsFSkKT4ebz1RbRaA==
X-CSE-MsgGUID: 7c9moTL8Sj2NhKRUm8QK5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="51331170"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="51331170"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 04:35:23 -0700
X-CSE-ConnectionGUID: 7958fPSBSaWLCuKQW6ucAw==
X-CSE-MsgGUID: z55sPQVORiK7mwVEYPHCUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="133812564"
Received: from t21-qat.iind.intel.com ([10.49.15.35])
  by orviesa009.jf.intel.com with ESMTP; 30 Apr 2025 04:35:21 -0700
From: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
To: herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org,
	qat-linux@intel.com
Subject: [PATCH 11/11] crypto: qat - add qat_6xxx driver
Date: Wed, 30 Apr 2025 12:34:53 +0100
Message-Id: <20250430113453.1587497-12-suman.kumar.chakraborty@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250430113453.1587497-1-suman.kumar.chakraborty@intel.com>
References: <20250430113453.1587497-1-suman.kumar.chakraborty@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurent M Coquerel <laurent.m.coquerel@intel.com>

Add a new driver, qat_6xxx, to support QAT GEN6 devices.
QAT GEN6 devices are a follow-on generation of GEN4 devices and
differently from the previous generation, they can support all three
services (symmetric, asymmetric, and data compression) concurrently.

In order to have the qat_6xxx driver to reuse some of the GEN4 logic,
a new abstraction layer has been introduced to bridge the two
implementations. This allows to avoid code duplication and to keep the
qat_6xxx driver isolated from the GEN4 logic. This approach has been
used for the PF to VF logic and the HW CSR access logic.

Signed-off-by: Laurent M Coquerel <laurent.m.coquerel@intel.com>
Co-developed-by: George Abraham P <george.abraham.p@intel.com>
Signed-off-by: George Abraham P <george.abraham.p@intel.com>
Co-developed-by: Karthikeyan Gopal <karthikeyan.gopal@intel.com>
Signed-off-by: Karthikeyan Gopal <karthikeyan.gopal@intel.com>
Co-developed-by: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
Signed-off-by: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/intel/qat/Kconfig              |  12 +
 drivers/crypto/intel/qat/Makefile             |   1 +
 drivers/crypto/intel/qat/qat_6xxx/Makefile    |   3 +
 .../intel/qat/qat_6xxx/adf_6xxx_hw_data.c     | 843 ++++++++++++++++++
 .../intel/qat/qat_6xxx/adf_6xxx_hw_data.h     | 148 +++
 drivers/crypto/intel/qat/qat_6xxx/adf_drv.c   | 224 +++++
 drivers/crypto/intel/qat/qat_common/Makefile  |   1 +
 .../intel/qat/qat_common/adf_accel_devices.h  |   2 +
 .../intel/qat/qat_common/adf_cfg_common.h     |   1 +
 .../intel/qat/qat_common/adf_fw_config.h      |   1 +
 .../crypto/intel/qat/qat_common/adf_gen6_pm.h |  28 +
 .../intel/qat/qat_common/adf_gen6_shared.c    |  49 +
 .../intel/qat/qat_common/adf_gen6_shared.h    |  15 +
 13 files changed, 1328 insertions(+)
 create mode 100644 drivers/crypto/intel/qat/qat_6xxx/Makefile
 create mode 100644 drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.c
 create mode 100644 drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.h
 create mode 100644 drivers/crypto/intel/qat/qat_6xxx/adf_drv.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen6_pm.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen6_shared.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen6_shared.h

diff --git a/drivers/crypto/intel/qat/Kconfig b/drivers/crypto/intel/qat/Kconfig
index 02fb8abe4e6e..359c61f0c8a1 100644
--- a/drivers/crypto/intel/qat/Kconfig
+++ b/drivers/crypto/intel/qat/Kconfig
@@ -70,6 +70,18 @@ config CRYPTO_DEV_QAT_420XX
 	  To compile this as a module, choose M here: the module
 	  will be called qat_420xx.
 
+config CRYPTO_DEV_QAT_6XXX
+	tristate "Support for Intel(R) QuickAssist Technology QAT_6XXX"
+	depends on (X86 || COMPILE_TEST)
+	depends on PCI
+	select CRYPTO_DEV_QAT
+	help
+	  Support for Intel(R) QuickAssist Technology QAT_6xxx
+	  for accelerating crypto and compression workloads.
+
+	  To compile this as a module, choose M here: the module
+	  will be called qat_6xxx.
+
 config CRYPTO_DEV_QAT_DH895xCCVF
 	tristate "Support for Intel(R) DH895xCC Virtual Function"
 	depends on PCI && (!CPU_BIG_ENDIAN || COMPILE_TEST)
diff --git a/drivers/crypto/intel/qat/Makefile b/drivers/crypto/intel/qat/Makefile
index 1eda8dc18515..abef14207afa 100644
--- a/drivers/crypto/intel/qat/Makefile
+++ b/drivers/crypto/intel/qat/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_CRYPTO_DEV_QAT_C3XXX) += qat_c3xxx/
 obj-$(CONFIG_CRYPTO_DEV_QAT_C62X) += qat_c62x/
 obj-$(CONFIG_CRYPTO_DEV_QAT_4XXX) += qat_4xxx/
 obj-$(CONFIG_CRYPTO_DEV_QAT_420XX) += qat_420xx/
+obj-$(CONFIG_CRYPTO_DEV_QAT_6XXX) += qat_6xxx/
 obj-$(CONFIG_CRYPTO_DEV_QAT_DH895xCCVF) += qat_dh895xccvf/
 obj-$(CONFIG_CRYPTO_DEV_QAT_C3XXXVF) += qat_c3xxxvf/
 obj-$(CONFIG_CRYPTO_DEV_QAT_C62XVF) += qat_c62xvf/
diff --git a/drivers/crypto/intel/qat/qat_6xxx/Makefile b/drivers/crypto/intel/qat/qat_6xxx/Makefile
new file mode 100644
index 000000000000..4b4de67cb0c2
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_6xxx/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_CRYPTO_DEV_QAT_6XXX) += qat_6xxx.o
+qat_6xxx-y := adf_drv.o adf_6xxx_hw_data.o
diff --git a/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.c b/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.c
new file mode 100644
index 000000000000..73d479383b1f
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.c
@@ -0,0 +1,843 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2025 Intel Corporation */
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/iopoll.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+
+#include <adf_accel_devices.h>
+#include <adf_admin.h>
+#include <adf_cfg.h>
+#include <adf_cfg_services.h>
+#include <adf_clock.h>
+#include <adf_common_drv.h>
+#include <adf_fw_config.h>
+#include <adf_gen6_pm.h>
+#include <adf_gen6_shared.h>
+#include <adf_timer.h>
+#include "adf_6xxx_hw_data.h"
+#include "icp_qat_fw_comp.h"
+#include "icp_qat_hw_51_comp.h"
+
+#define RP_GROUP_0_MASK		(BIT(0) | BIT(2))
+#define RP_GROUP_1_MASK		(BIT(1) | BIT(3))
+#define RP_GROUP_ALL_MASK	(RP_GROUP_0_MASK | RP_GROUP_1_MASK)
+
+#define ADF_AE_GROUP_0		GENMASK(3, 0)
+#define ADF_AE_GROUP_1		GENMASK(7, 4)
+#define ADF_AE_GROUP_2		BIT(8)
+
+struct adf_ring_config {
+	u32 ring_mask;
+	enum adf_cfg_service_type ring_type;
+	const unsigned long *thrd_mask;
+};
+
+static u32 rmask_two_services[] = {
+	RP_GROUP_0_MASK,
+	RP_GROUP_1_MASK,
+};
+
+enum adf_gen6_rps {
+	RP0 = 0,
+	RP1 = 1,
+	RP2 = 2,
+	RP3 = 3,
+	RP_MAX = RP3
+};
+
+/*
+ * thrd_mask_[sym|asym|cpr|dcc]: these static arrays define the thread
+ * configuration for handling requests of specific services across the
+ * accelerator engines. Each element in an array corresponds to an
+ * accelerator engine, with the value being a bitmask that specifies which
+ * threads within that engine are capable of processing the particular service.
+ *
+ * For example, a value of 0x0C means that threads 2 and 3 are enabled for the
+ * service in the respective accelerator engine.
+ */
+static const unsigned long thrd_mask_sym[ADF_6XXX_MAX_ACCELENGINES] = {
+	0x0C, 0x0C, 0x0C, 0x0C, 0x1C, 0x1C, 0x1C, 0x1C, 0x00
+};
+
+static const unsigned long thrd_mask_asym[ADF_6XXX_MAX_ACCELENGINES] = {
+	0x70, 0x70, 0x70, 0x70, 0x60, 0x60, 0x60, 0x60, 0x00
+};
+
+static const unsigned long thrd_mask_cpr[ADF_6XXX_MAX_ACCELENGINES] = {
+	0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00
+};
+
+static const unsigned long thrd_mask_dcc[ADF_6XXX_MAX_ACCELENGINES] = {
+	0x00, 0x00, 0x00, 0x00, 0x07, 0x07, 0x03, 0x03, 0x00
+};
+
+static const char *const adf_6xxx_fw_objs[] = {
+	[ADF_FW_CY_OBJ] = ADF_6XXX_CY_OBJ,
+	[ADF_FW_DC_OBJ] = ADF_6XXX_DC_OBJ,
+	[ADF_FW_ADMIN_OBJ] = ADF_6XXX_ADMIN_OBJ,
+};
+
+static const struct adf_fw_config adf_default_fw_config[] = {
+	{ ADF_AE_GROUP_1, ADF_FW_DC_OBJ },
+	{ ADF_AE_GROUP_0, ADF_FW_CY_OBJ },
+	{ ADF_AE_GROUP_2, ADF_FW_ADMIN_OBJ },
+};
+
+static struct adf_hw_device_class adf_6xxx_class = {
+	.name = ADF_6XXX_DEVICE_NAME,
+	.type = DEV_6XXX,
+};
+
+static bool services_supported(unsigned long mask)
+{
+	int num_svc;
+
+	if (mask >= BIT(SVC_BASE_COUNT))
+		return false;
+
+	num_svc = hweight_long(mask);
+	switch (num_svc) {
+	case ADF_ONE_SERVICE:
+		return true;
+	case ADF_TWO_SERVICES:
+	case ADF_THREE_SERVICES:
+		return !test_bit(SVC_DCC, &mask);
+	default:
+		return false;
+	}
+}
+
+static int get_service(unsigned long *mask)
+{
+	if (test_and_clear_bit(SVC_ASYM, mask))
+		return SVC_ASYM;
+
+	if (test_and_clear_bit(SVC_SYM, mask))
+		return SVC_SYM;
+
+	if (test_and_clear_bit(SVC_DC, mask))
+		return SVC_DC;
+
+	if (test_and_clear_bit(SVC_DCC, mask))
+		return SVC_DCC;
+
+	return -EINVAL;
+}
+
+static enum adf_cfg_service_type get_ring_type(enum adf_services service)
+{
+	switch (service) {
+	case SVC_SYM:
+		return SYM;
+	case SVC_ASYM:
+		return ASYM;
+	case SVC_DC:
+	case SVC_DCC:
+		return COMP;
+	default:
+		return UNUSED;
+	}
+}
+
+static const unsigned long *get_thrd_mask(enum adf_services service)
+{
+	switch (service) {
+	case SVC_SYM:
+		return thrd_mask_sym;
+	case SVC_ASYM:
+		return thrd_mask_asym;
+	case SVC_DC:
+		return thrd_mask_cpr;
+	case SVC_DCC:
+		return thrd_mask_dcc;
+	default:
+		return NULL;
+	}
+}
+
+static int get_rp_config(struct adf_accel_dev *accel_dev, struct adf_ring_config *rp_config,
+			 unsigned int *num_services)
+{
+	unsigned int i, nservices;
+	unsigned long mask;
+	int ret, service;
+
+	ret = adf_get_service_mask(accel_dev, &mask);
+	if (ret)
+		return ret;
+
+	nservices = hweight_long(mask);
+	if (nservices > MAX_NUM_CONCURR_SVC)
+		return -EINVAL;
+
+	for (i = 0; i < nservices; i++) {
+		service = get_service(&mask);
+		if (service < 0)
+			return service;
+
+		rp_config[i].ring_type = get_ring_type(service);
+		rp_config[i].thrd_mask = get_thrd_mask(service);
+
+		/*
+		 * If there is only one service enabled, use all ring pairs for
+		 * that service.
+		 * If there are two services enabled, use ring pairs 0 and 2 for
+		 * one service and ring pairs 1 and 3 for the other service.
+		 */
+		switch (nservices) {
+		case ADF_ONE_SERVICE:
+			rp_config[i].ring_mask = RP_GROUP_ALL_MASK;
+			break;
+		case ADF_TWO_SERVICES:
+			rp_config[i].ring_mask = rmask_two_services[i];
+			break;
+		case ADF_THREE_SERVICES:
+			rp_config[i].ring_mask = BIT(i);
+
+			/* If ASYM is enabled, use additional ring pair */
+			if (service == SVC_ASYM)
+				rp_config[i].ring_mask |= BIT(RP3);
+
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	*num_services = nservices;
+
+	return 0;
+}
+
+static u32 adf_gen6_get_arb_mask(struct adf_accel_dev *accel_dev, unsigned int ae)
+{
+	struct adf_ring_config rp_config[MAX_NUM_CONCURR_SVC];
+	unsigned int num_services, i, thrd;
+	u32 ring_mask, thd2arb_mask = 0;
+	const unsigned long *p_mask;
+
+	if (get_rp_config(accel_dev, rp_config, &num_services))
+		return 0;
+
+	/*
+	 * The thd2arb_mask maps ring pairs to threads within an accelerator engine.
+	 * It ensures that jobs submitted to ring pairs are scheduled on threads capable
+	 * of handling the specified service type.
+	 *
+	 * Each group of 4 bits in the mask corresponds to a thread, with each bit
+	 * indicating whether a job from a ring pair can be scheduled on that thread.
+	 * The use of 4 bits is due to the organization of ring pairs into groups of
+	 * four, where each group shares the same configuration.
+	 */
+	for (i = 0; i < num_services; i++) {
+		p_mask = &rp_config[i].thrd_mask[ae];
+		ring_mask = rp_config[i].ring_mask;
+
+		for_each_set_bit(thrd, p_mask, ADF_NUM_THREADS_PER_AE)
+			thd2arb_mask |= ring_mask << (thrd * 4);
+	}
+
+	return thd2arb_mask;
+}
+
+static u16 get_ring_to_svc_map(struct adf_accel_dev *accel_dev)
+{
+	enum adf_cfg_service_type rps[ADF_GEN6_NUM_BANKS_PER_VF] = { };
+	struct adf_ring_config rp_config[MAX_NUM_CONCURR_SVC];
+	unsigned int num_services, rp_num, i;
+	unsigned long cfg_mask;
+	u16 ring_to_svc_map;
+
+	if (get_rp_config(accel_dev, rp_config, &num_services))
+		return 0;
+
+	/*
+	 * Loop through the configured services and populate the `rps` array that
+	 * contains what service that particular ring pair can handle (i.e. symmetric
+	 * crypto, asymmetric crypto, data compression or compression chaining).
+	 */
+	for (i = 0; i < num_services; i++) {
+		cfg_mask = rp_config[i].ring_mask;
+		for_each_set_bit(rp_num, &cfg_mask, ADF_GEN6_NUM_BANKS_PER_VF)
+			rps[rp_num] = rp_config[i].ring_type;
+	}
+
+	/*
+	 * The ring_mask is structured into segments of 3 bits, with each
+	 * segment representing the service configuration for a specific ring pair.
+	 * Since ring pairs are organized into groups of 4, the ring_mask contains 4
+	 * such 3-bit segments, each corresponding to one ring pair.
+	 *
+	 * The device has 64 ring pairs, which are organized in groups of 4, namely
+	 * 16 groups. Each group has the same configuration, represented here by
+	 * `ring_to_svc_map`.
+	 */
+	ring_to_svc_map = rps[RP0] << ADF_CFG_SERV_RING_PAIR_0_SHIFT |
+			  rps[RP1] << ADF_CFG_SERV_RING_PAIR_1_SHIFT |
+			  rps[RP2] << ADF_CFG_SERV_RING_PAIR_2_SHIFT |
+			  rps[RP3] << ADF_CFG_SERV_RING_PAIR_3_SHIFT;
+
+	return ring_to_svc_map;
+}
+
+static u32 get_accel_mask(struct adf_hw_device_data *self)
+{
+	return ADF_GEN6_ACCELERATORS_MASK;
+}
+
+static u32 get_num_accels(struct adf_hw_device_data *self)
+{
+	return ADF_GEN6_MAX_ACCELERATORS;
+}
+
+static u32 get_num_aes(struct adf_hw_device_data *self)
+{
+	return self ? hweight32(self->ae_mask) : 0;
+}
+
+static u32 get_misc_bar_id(struct adf_hw_device_data *self)
+{
+	return ADF_GEN6_PMISC_BAR;
+}
+
+static u32 get_etr_bar_id(struct adf_hw_device_data *self)
+{
+	return ADF_GEN6_ETR_BAR;
+}
+
+static u32 get_sram_bar_id(struct adf_hw_device_data *self)
+{
+	return ADF_GEN6_SRAM_BAR;
+}
+
+static enum dev_sku_info get_sku(struct adf_hw_device_data *self)
+{
+	return DEV_SKU_1;
+}
+
+static void get_arb_info(struct arb_info *arb_info)
+{
+	arb_info->arb_cfg = ADF_GEN6_ARB_CONFIG;
+	arb_info->arb_offset = ADF_GEN6_ARB_OFFSET;
+	arb_info->wt2sam_offset = ADF_GEN6_ARB_WRK_2_SER_MAP_OFFSET;
+}
+
+static void get_admin_info(struct admin_info *admin_csrs_info)
+{
+	admin_csrs_info->mailbox_offset = ADF_GEN6_MAILBOX_BASE_OFFSET;
+	admin_csrs_info->admin_msg_ur = ADF_GEN6_ADMINMSGUR_OFFSET;
+	admin_csrs_info->admin_msg_lr = ADF_GEN6_ADMINMSGLR_OFFSET;
+}
+
+static u32 get_heartbeat_clock(struct adf_hw_device_data *self)
+{
+	return ADF_GEN6_COUNTER_FREQ;
+}
+
+static void enable_error_correction(struct adf_accel_dev *accel_dev)
+{
+	void __iomem *csr = adf_get_pmisc_base(accel_dev);
+
+	/*
+	 * Enable all error notification bits in errsou3 except VFLR
+	 * notification on host.
+	 */
+	ADF_CSR_WR(csr, ADF_GEN6_ERRMSK3, ADF_GEN6_VFLNOTIFY);
+}
+
+static void enable_ints(struct adf_accel_dev *accel_dev)
+{
+	void __iomem *addr = adf_get_pmisc_base(accel_dev);
+
+	/* Enable bundle interrupts */
+	ADF_CSR_WR(addr, ADF_GEN6_SMIAPF_RP_X0_MASK_OFFSET, 0);
+	ADF_CSR_WR(addr, ADF_GEN6_SMIAPF_RP_X1_MASK_OFFSET, 0);
+
+	/* Enable misc interrupts */
+	ADF_CSR_WR(addr, ADF_GEN6_SMIAPF_MASK_OFFSET, 0);
+}
+
+static void set_ssm_wdtimer(struct adf_accel_dev *accel_dev)
+{
+	void __iomem *addr = adf_get_pmisc_base(accel_dev);
+	u64 val_pke = ADF_SSM_WDT_PKE_DEFAULT_VALUE;
+	u64 val = ADF_SSM_WDT_DEFAULT_VALUE;
+
+	/* Enable watchdog timer for sym and dc */
+	ADF_CSR_WR64_LO_HI(addr, ADF_SSMWDTATHL_OFFSET, ADF_SSMWDTATHH_OFFSET, val);
+	ADF_CSR_WR64_LO_HI(addr, ADF_SSMWDTCNVL_OFFSET, ADF_SSMWDTCNVH_OFFSET, val);
+	ADF_CSR_WR64_LO_HI(addr, ADF_SSMWDTUCSL_OFFSET, ADF_SSMWDTUCSH_OFFSET, val);
+	ADF_CSR_WR64_LO_HI(addr, ADF_SSMWDTDCPRL_OFFSET, ADF_SSMWDTDCPRH_OFFSET, val);
+
+	/* Enable watchdog timer for pke */
+	ADF_CSR_WR64_LO_HI(addr, ADF_SSMWDTPKEL_OFFSET, ADF_SSMWDTPKEH_OFFSET, val_pke);
+}
+
+/*
+ * The vector routing table is used to select the MSI-X entry to use for each
+ * interrupt source.
+ * The first ADF_GEN6_ETR_MAX_BANKS entries correspond to ring interrupts.
+ * The final entry corresponds to VF2PF or error interrupts.
+ * This vector table could be used to configure one MSI-X entry to be shared
+ * between multiple interrupt sources.
+ *
+ * The default routing is set to have a one to one correspondence between the
+ * interrupt source and the MSI-X entry used.
+ */
+static void set_msix_default_rttable(struct adf_accel_dev *accel_dev)
+{
+	void __iomem *csr = adf_get_pmisc_base(accel_dev);
+	unsigned int i;
+
+	for (i = 0; i <= ADF_GEN6_ETR_MAX_BANKS; i++)
+		ADF_CSR_WR(csr, ADF_GEN6_MSIX_RTTABLE_OFFSET(i), i);
+}
+
+static int reset_ring_pair(void __iomem *csr, u32 bank_number)
+{
+	u32 status;
+	int ret;
+
+	/*
+	 * Write rpresetctl register BIT(0) as 1.
+	 * Since rpresetctl registers have no RW fields, no need to preserve
+	 * values for other bits. Just write directly.
+	 */
+	ADF_CSR_WR(csr, ADF_WQM_CSR_RPRESETCTL(bank_number),
+		   ADF_WQM_CSR_RPRESETCTL_RESET);
+
+	/* Read rpresetsts register and wait for rp reset to complete */
+	ret = read_poll_timeout(ADF_CSR_RD, status,
+				status & ADF_WQM_CSR_RPRESETSTS_STATUS,
+				ADF_RPRESET_POLL_DELAY_US,
+				ADF_RPRESET_POLL_TIMEOUT_US, true,
+				csr, ADF_WQM_CSR_RPRESETSTS(bank_number));
+	if (ret)
+		return ret;
+
+	/* When ring pair reset is done, clear rpresetsts */
+	ADF_CSR_WR(csr, ADF_WQM_CSR_RPRESETSTS(bank_number), ADF_WQM_CSR_RPRESETSTS_STATUS);
+
+	return 0;
+}
+
+static int ring_pair_reset(struct adf_accel_dev *accel_dev, u32 bank_number)
+{
+	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+	void __iomem *csr = adf_get_etr_base(accel_dev);
+	int ret;
+
+	if (bank_number >= hw_data->num_banks)
+		return -EINVAL;
+
+	dev_dbg(&GET_DEV(accel_dev), "ring pair reset for bank:%d\n", bank_number);
+
+	ret = reset_ring_pair(csr, bank_number);
+	if (ret)
+		dev_err(&GET_DEV(accel_dev), "ring pair reset failed (timeout)\n");
+	else
+		dev_dbg(&GET_DEV(accel_dev), "ring pair reset successful\n");
+
+	return ret;
+}
+
+static int build_comp_block(void *ctx, enum adf_dc_algo algo)
+{
+	struct icp_qat_fw_comp_req *req_tmpl = ctx;
+	struct icp_qat_fw_comp_req_hdr_cd_pars *cd_pars = &req_tmpl->cd_pars;
+	struct icp_qat_hw_comp_51_config_csr_lower hw_comp_lower_csr = { };
+	struct icp_qat_fw_comn_req_hdr *header = &req_tmpl->comn_hdr;
+	u32 lower_val;
+
+	switch (algo) {
+	case QAT_DEFLATE:
+		header->service_cmd_id = ICP_QAT_FW_COMP_CMD_DYNAMIC;
+	break;
+	default:
+		return -EINVAL;
+	}
+
+	hw_comp_lower_csr.lllbd = ICP_QAT_HW_COMP_51_LLLBD_CTRL_LLLBD_DISABLED;
+	hw_comp_lower_csr.sd = ICP_QAT_HW_COMP_51_SEARCH_DEPTH_LEVEL_1;
+	lower_val = ICP_QAT_FW_COMP_51_BUILD_CONFIG_LOWER(hw_comp_lower_csr);
+	cd_pars->u.sl.comp_slice_cfg_word[0] = lower_val;
+	cd_pars->u.sl.comp_slice_cfg_word[1] = 0;
+
+	return 0;
+}
+
+static int build_decomp_block(void *ctx, enum adf_dc_algo algo)
+{
+	struct icp_qat_fw_comp_req *req_tmpl = ctx;
+	struct icp_qat_fw_comp_req_hdr_cd_pars *cd_pars = &req_tmpl->cd_pars;
+	struct icp_qat_fw_comn_req_hdr *header = &req_tmpl->comn_hdr;
+
+	switch (algo) {
+	case QAT_DEFLATE:
+		header->service_cmd_id = ICP_QAT_FW_COMP_CMD_DECOMPRESS;
+	break;
+	default:
+		return -EINVAL;
+	}
+
+	cd_pars->u.sl.comp_slice_cfg_word[0] = 0;
+	cd_pars->u.sl.comp_slice_cfg_word[1] = 0;
+
+	return 0;
+}
+
+static void adf_gen6_init_dc_ops(struct adf_dc_ops *dc_ops)
+{
+	dc_ops->build_comp_block = build_comp_block;
+	dc_ops->build_decomp_block = build_decomp_block;
+}
+
+static int adf_gen6_init_thd2arb_map(struct adf_accel_dev *accel_dev)
+{
+	struct adf_hw_device_data *hw_data = GET_HW_DATA(accel_dev);
+	u32 *thd2arb_map = hw_data->thd_to_arb_map;
+	unsigned int i;
+
+	for (i = 0; i < hw_data->num_engines; i++) {
+		thd2arb_map[i] = adf_gen6_get_arb_mask(accel_dev, i);
+		dev_dbg(&GET_DEV(accel_dev), "ME:%d arb_mask:%#x\n", i, thd2arb_map[i]);
+	}
+
+	return 0;
+}
+
+static void set_vc_csr_for_bank(void __iomem *csr, u32 bank_number)
+{
+	u32 value;
+
+	/*
+	 * After each PF FLR, for each of the 64 ring pairs in the PF, the
+	 * driver must program the ringmodectl CSRs.
+	 */
+	value = ADF_CSR_RD(csr, ADF_GEN6_CSR_RINGMODECTL(bank_number));
+	value |= FIELD_PREP(ADF_GEN6_RINGMODECTL_TC_MASK, ADF_GEN6_RINGMODECTL_TC_DEFAULT);
+	value |= FIELD_PREP(ADF_GEN6_RINGMODECTL_TC_EN_MASK, ADF_GEN6_RINGMODECTL_TC_EN_OP1);
+	ADF_CSR_WR(csr, ADF_GEN6_CSR_RINGMODECTL(bank_number), value);
+}
+
+static int set_vc_config(struct adf_accel_dev *accel_dev)
+{
+	struct pci_dev *pdev = accel_to_pci_dev(accel_dev);
+	u32 value;
+	int err;
+
+	/*
+	 * After each PF FLR, the driver must program the Port Virtual Channel (VC)
+	 * Control Registers.
+	 * Read PVC0CTL then write the masked values.
+	 */
+	pci_read_config_dword(pdev, ADF_GEN6_PVC0CTL_OFFSET, &value);
+	value |= FIELD_PREP(ADF_GEN6_PVC0CTL_TCVCMAP_MASK, ADF_GEN6_PVC0CTL_TCVCMAP_DEFAULT);
+	err = pci_write_config_dword(pdev, ADF_GEN6_PVC0CTL_OFFSET, value);
+	if (err) {
+		dev_err(&GET_DEV(accel_dev), "pci write to PVC0CTL failed\n");
+		return pcibios_err_to_errno(err);
+	}
+
+	/* Read PVC1CTL then write masked values */
+	pci_read_config_dword(pdev, ADF_GEN6_PVC1CTL_OFFSET, &value);
+	value |= FIELD_PREP(ADF_GEN6_PVC1CTL_TCVCMAP_MASK, ADF_GEN6_PVC1CTL_TCVCMAP_DEFAULT);
+	value |= FIELD_PREP(ADF_GEN6_PVC1CTL_VCEN_MASK, ADF_GEN6_PVC1CTL_VCEN_ON);
+	err = pci_write_config_dword(pdev, ADF_GEN6_PVC1CTL_OFFSET, value);
+	if (err)
+		dev_err(&GET_DEV(accel_dev), "pci write to PVC1CTL failed\n");
+
+	return pcibios_err_to_errno(err);
+}
+
+static int adf_gen6_set_vc(struct adf_accel_dev *accel_dev)
+{
+	struct adf_hw_device_data *hw_data = GET_HW_DATA(accel_dev);
+	void __iomem *csr = adf_get_etr_base(accel_dev);
+	u32 i;
+
+	for (i = 0; i < hw_data->num_banks; i++) {
+		dev_dbg(&GET_DEV(accel_dev), "set virtual channels for bank:%d\n", i);
+		set_vc_csr_for_bank(csr, i);
+	}
+
+	return set_vc_config(accel_dev);
+}
+
+static u32 get_ae_mask(struct adf_hw_device_data *self)
+{
+	unsigned long fuses = self->fuses[ADF_FUSECTL4];
+	u32 mask = ADF_6XXX_ACCELENGINES_MASK;
+
+	/*
+	 * If bit 0 is set in the fuses, the first 4 engines are disabled.
+	 * If bit 4 is set, the second group of 4 engines are disabled.
+	 * If bit 8 is set, the admin engine (bit 8) is disabled.
+	 */
+	if (test_bit(0, &fuses))
+		mask &= ~ADF_AE_GROUP_0;
+
+	if (test_bit(4, &fuses))
+		mask &= ~ADF_AE_GROUP_1;
+
+	if (test_bit(8, &fuses))
+		mask &= ~ADF_AE_GROUP_2;
+
+	return mask;
+}
+
+static u32 get_accel_cap(struct adf_accel_dev *accel_dev)
+{
+	u32 capabilities_sym, capabilities_asym;
+	u32 capabilities_dc;
+	unsigned long mask;
+	u32 caps = 0;
+	u32 fusectl1;
+
+	fusectl1 = GET_HW_DATA(accel_dev)->fuses[ADF_FUSECTL1];
+
+	/* Read accelerator capabilities mask */
+	capabilities_sym = ICP_ACCEL_CAPABILITIES_CRYPTO_SYMMETRIC |
+			  ICP_ACCEL_CAPABILITIES_CIPHER |
+			  ICP_ACCEL_CAPABILITIES_AUTHENTICATION |
+			  ICP_ACCEL_CAPABILITIES_SHA3 |
+			  ICP_ACCEL_CAPABILITIES_SHA3_EXT |
+			  ICP_ACCEL_CAPABILITIES_CHACHA_POLY |
+			  ICP_ACCEL_CAPABILITIES_AESGCM_SPC |
+			  ICP_ACCEL_CAPABILITIES_AES_V2;
+
+	/* A set bit in fusectl1 means the corresponding feature is OFF in this SKU */
+	if (fusectl1 & ICP_ACCEL_GEN6_MASK_UCS_SLICE) {
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_CRYPTO_SYMMETRIC;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_CIPHER;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_CHACHA_POLY;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_AESGCM_SPC;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_AES_V2;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_CIPHER;
+	}
+	if (fusectl1 & ICP_ACCEL_GEN6_MASK_AUTH_SLICE) {
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_AUTHENTICATION;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_SHA3;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_SHA3_EXT;
+		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_CIPHER;
+	}
+
+	capabilities_asym = 0;
+
+	capabilities_dc = ICP_ACCEL_CAPABILITIES_COMPRESSION |
+			  ICP_ACCEL_CAPABILITIES_LZ4_COMPRESSION |
+			  ICP_ACCEL_CAPABILITIES_LZ4S_COMPRESSION |
+			  ICP_ACCEL_CAPABILITIES_CNV_INTEGRITY64;
+
+	if (fusectl1 & ICP_ACCEL_GEN6_MASK_CPR_SLICE) {
+		capabilities_dc &= ~ICP_ACCEL_CAPABILITIES_COMPRESSION;
+		capabilities_dc &= ~ICP_ACCEL_CAPABILITIES_LZ4_COMPRESSION;
+		capabilities_dc &= ~ICP_ACCEL_CAPABILITIES_LZ4S_COMPRESSION;
+		capabilities_dc &= ~ICP_ACCEL_CAPABILITIES_CNV_INTEGRITY64;
+	}
+
+	if (adf_get_service_mask(accel_dev, &mask))
+		return 0;
+
+	if (test_bit(SVC_ASYM, &mask))
+		caps |= capabilities_asym;
+	if (test_bit(SVC_SYM, &mask))
+		caps |= capabilities_sym;
+	if (test_bit(SVC_DC, &mask))
+		caps |= capabilities_dc;
+	if (test_bit(SVC_DCC, &mask)) {
+		/*
+		 * Sym capabilities are available for chaining operations,
+		 * but sym crypto instances cannot be supported
+		 */
+		caps = capabilities_dc | capabilities_sym;
+		caps &= ~ICP_ACCEL_CAPABILITIES_CRYPTO_SYMMETRIC;
+	}
+
+	return caps;
+}
+
+static u32 uof_get_num_objs(struct adf_accel_dev *accel_dev)
+{
+	return ARRAY_SIZE(adf_default_fw_config);
+}
+
+static const char *uof_get_name(struct adf_accel_dev *accel_dev, u32 obj_num)
+{
+	int num_fw_objs = ARRAY_SIZE(adf_6xxx_fw_objs);
+	int id;
+
+	id = adf_default_fw_config[obj_num].obj;
+	if (id >= num_fw_objs)
+		return NULL;
+
+	return adf_6xxx_fw_objs[id];
+}
+
+static const char *uof_get_name_6xxx(struct adf_accel_dev *accel_dev, u32 obj_num)
+{
+	return uof_get_name(accel_dev, obj_num);
+}
+
+static int uof_get_obj_type(struct adf_accel_dev *accel_dev, u32 obj_num)
+{
+	if (obj_num >= uof_get_num_objs(accel_dev))
+		return -EINVAL;
+
+	return adf_default_fw_config[obj_num].obj;
+}
+
+static u32 uof_get_ae_mask(struct adf_accel_dev *accel_dev, u32 obj_num)
+{
+	return adf_default_fw_config[obj_num].ae_mask;
+}
+
+static const u32 *adf_get_arbiter_mapping(struct adf_accel_dev *accel_dev)
+{
+	if (adf_gen6_init_thd2arb_map(accel_dev))
+		dev_warn(&GET_DEV(accel_dev),
+			 "Failed to generate thread to arbiter mapping");
+
+	return GET_HW_DATA(accel_dev)->thd_to_arb_map;
+}
+
+static int adf_init_device(struct adf_accel_dev *accel_dev)
+{
+	void __iomem *addr = adf_get_pmisc_base(accel_dev);
+	u32 status;
+	u32 csr;
+	int ret;
+
+	/* Temporarily mask PM interrupt */
+	csr = ADF_CSR_RD(addr, ADF_GEN6_ERRMSK2);
+	csr |= ADF_GEN6_PM_SOU;
+	ADF_CSR_WR(addr, ADF_GEN6_ERRMSK2, csr);
+
+	/* Set DRV_ACTIVE bit to power up the device */
+	ADF_CSR_WR(addr, ADF_GEN6_PM_INTERRUPT, ADF_GEN6_PM_DRV_ACTIVE);
+
+	/* Poll status register to make sure the device is powered up */
+	ret = read_poll_timeout(ADF_CSR_RD, status,
+				status & ADF_GEN6_PM_INIT_STATE,
+				ADF_GEN6_PM_POLL_DELAY_US,
+				ADF_GEN6_PM_POLL_TIMEOUT_US, true, addr,
+				ADF_GEN6_PM_STATUS);
+	if (ret) {
+		dev_err(&GET_DEV(accel_dev), "Failed to power up the device\n");
+		return ret;
+	}
+
+	dev_dbg(&GET_DEV(accel_dev), "Setting virtual channels for device qat_dev%d\n",
+		accel_dev->accel_id);
+
+	ret = adf_gen6_set_vc(accel_dev);
+	if (ret)
+		dev_err(&GET_DEV(accel_dev), "Failed to set virtual channels\n");
+
+	return ret;
+}
+
+static int enable_pm(struct adf_accel_dev *accel_dev)
+{
+	return adf_init_admin_pm(accel_dev, ADF_GEN6_PM_DEFAULT_IDLE_FILTER);
+}
+
+static int dev_config(struct adf_accel_dev *accel_dev)
+{
+	int ret;
+
+	ret = adf_cfg_section_add(accel_dev, ADF_KERNEL_SEC);
+	if (ret)
+		return ret;
+
+	ret = adf_cfg_section_add(accel_dev, "Accelerator0");
+	if (ret)
+		return ret;
+
+	switch (adf_get_service_enabled(accel_dev)) {
+	case SVC_DC:
+	case SVC_DCC:
+		ret = adf_gen6_comp_dev_config(accel_dev);
+		break;
+	default:
+		ret = adf_gen6_no_dev_config(accel_dev);
+		break;
+	}
+	if (ret)
+		return ret;
+
+	__set_bit(ADF_STATUS_CONFIGURED, &accel_dev->status);
+
+	return ret;
+}
+
+void adf_init_hw_data_6xxx(struct adf_hw_device_data *hw_data)
+{
+	hw_data->dev_class = &adf_6xxx_class;
+	hw_data->instance_id = adf_6xxx_class.instances++;
+	hw_data->num_banks = ADF_GEN6_ETR_MAX_BANKS;
+	hw_data->num_banks_per_vf = ADF_GEN6_NUM_BANKS_PER_VF;
+	hw_data->num_rings_per_bank = ADF_GEN6_NUM_RINGS_PER_BANK;
+	hw_data->num_accel = ADF_GEN6_MAX_ACCELERATORS;
+	hw_data->num_engines = ADF_6XXX_MAX_ACCELENGINES;
+	hw_data->num_logical_accel = 1;
+	hw_data->tx_rx_gap = ADF_GEN6_RX_RINGS_OFFSET;
+	hw_data->tx_rings_mask = ADF_GEN6_TX_RINGS_MASK;
+	hw_data->ring_to_svc_map = 0;
+	hw_data->alloc_irq = adf_isr_resource_alloc;
+	hw_data->free_irq = adf_isr_resource_free;
+	hw_data->enable_error_correction = enable_error_correction;
+	hw_data->get_accel_mask = get_accel_mask;
+	hw_data->get_ae_mask = get_ae_mask;
+	hw_data->get_num_accels = get_num_accels;
+	hw_data->get_num_aes = get_num_aes;
+	hw_data->get_sram_bar_id = get_sram_bar_id;
+	hw_data->get_etr_bar_id = get_etr_bar_id;
+	hw_data->get_misc_bar_id = get_misc_bar_id;
+	hw_data->get_arb_info = get_arb_info;
+	hw_data->get_admin_info = get_admin_info;
+	hw_data->get_accel_cap = get_accel_cap;
+	hw_data->get_sku = get_sku;
+	hw_data->init_admin_comms = adf_init_admin_comms;
+	hw_data->exit_admin_comms = adf_exit_admin_comms;
+	hw_data->send_admin_init = adf_send_admin_init;
+	hw_data->init_arb = adf_init_arb;
+	hw_data->exit_arb = adf_exit_arb;
+	hw_data->get_arb_mapping = adf_get_arbiter_mapping;
+	hw_data->enable_ints = enable_ints;
+	hw_data->reset_device = adf_reset_flr;
+	hw_data->admin_ae_mask = ADF_6XXX_ADMIN_AE_MASK;
+	hw_data->fw_name = ADF_6XXX_FW;
+	hw_data->fw_mmp_name = ADF_6XXX_MMP;
+	hw_data->uof_get_name = uof_get_name_6xxx;
+	hw_data->uof_get_num_objs = uof_get_num_objs;
+	hw_data->uof_get_obj_type = uof_get_obj_type;
+	hw_data->uof_get_ae_mask = uof_get_ae_mask;
+	hw_data->set_msix_rttable = set_msix_default_rttable;
+	hw_data->set_ssm_wdtimer = set_ssm_wdtimer;
+	hw_data->get_ring_to_svc_map = get_ring_to_svc_map;
+	hw_data->disable_iov = adf_disable_sriov;
+	hw_data->ring_pair_reset = ring_pair_reset;
+	hw_data->dev_config = dev_config;
+	hw_data->get_hb_clock = get_heartbeat_clock;
+	hw_data->num_hb_ctrs = ADF_NUM_HB_CNT_PER_AE;
+	hw_data->start_timer = adf_timer_start;
+	hw_data->stop_timer = adf_timer_stop;
+	hw_data->init_device = adf_init_device;
+	hw_data->enable_pm = enable_pm;
+	hw_data->services_supported = services_supported;
+
+	adf_gen6_init_hw_csr_ops(&hw_data->csr_ops);
+	adf_gen6_init_pf_pfvf_ops(&hw_data->pfvf_ops);
+	adf_gen6_init_dc_ops(&hw_data->dc_ops);
+}
+
+void adf_clean_hw_data_6xxx(struct adf_hw_device_data *hw_data)
+{
+	if (hw_data->dev_class->instances)
+		hw_data->dev_class->instances--;
+}
diff --git a/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.h b/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.h
new file mode 100644
index 000000000000..78e2e2c5816e
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_6xxx/adf_6xxx_hw_data.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2025 Intel Corporation */
+#ifndef ADF_6XXX_HW_DATA_H_
+#define ADF_6XXX_HW_DATA_H_
+
+#include <linux/bits.h>
+#include <linux/time.h>
+#include <linux/units.h>
+
+#include "adf_accel_devices.h"
+#include "adf_cfg_common.h"
+#include "adf_dc.h"
+
+/* PCIe configuration space */
+#define ADF_GEN6_BAR_MASK		(BIT(0) | BIT(2) | BIT(4))
+#define ADF_GEN6_SRAM_BAR		0
+#define ADF_GEN6_PMISC_BAR		1
+#define ADF_GEN6_ETR_BAR		2
+#define ADF_6XXX_MAX_ACCELENGINES	9
+
+/* Clocks frequency */
+#define ADF_GEN6_COUNTER_FREQ		(100 * HZ_PER_MHZ)
+
+/* Physical function fuses */
+#define ADF_GEN6_FUSECTL0_OFFSET	0x2C8
+#define ADF_GEN6_FUSECTL1_OFFSET	0x2CC
+#define ADF_GEN6_FUSECTL4_OFFSET	0x2D8
+
+/* Accelerators */
+#define ADF_GEN6_ACCELERATORS_MASK	0x1
+#define ADF_GEN6_MAX_ACCELERATORS	1
+
+/* MSI-X interrupt */
+#define ADF_GEN6_SMIAPF_RP_X0_MASK_OFFSET	0x41A040
+#define ADF_GEN6_SMIAPF_RP_X1_MASK_OFFSET	0x41A044
+#define ADF_GEN6_SMIAPF_MASK_OFFSET		0x41A084
+#define ADF_GEN6_MSIX_RTTABLE_OFFSET(i)		(0x409000 + ((i) * 4))
+
+/* Bank and ring configuration */
+#define ADF_GEN6_NUM_RINGS_PER_BANK	2
+#define ADF_GEN6_NUM_BANKS_PER_VF	4
+#define ADF_GEN6_ETR_MAX_BANKS		64
+#define ADF_GEN6_RX_RINGS_OFFSET	1
+#define ADF_GEN6_TX_RINGS_MASK		0x1
+
+/* Arbiter configuration */
+#define ADF_GEN6_ARB_CONFIG			(BIT(31) | BIT(6) | BIT(0))
+#define ADF_GEN6_ARB_OFFSET			0x000
+#define ADF_GEN6_ARB_WRK_2_SER_MAP_OFFSET	0x400
+
+/* Admin interface configuration */
+#define ADF_GEN6_ADMINMSGUR_OFFSET	0x500574
+#define ADF_GEN6_ADMINMSGLR_OFFSET	0x500578
+#define ADF_GEN6_MAILBOX_BASE_OFFSET	0x600970
+
+/*
+ * Watchdog timers
+ * Timeout is in cycles. Clock speed may vary across products but this
+ * value should be a few milli-seconds.
+ */
+#define ADF_SSM_WDT_DEFAULT_VALUE	0x7000000ULL
+#define ADF_SSM_WDT_PKE_DEFAULT_VALUE	0x8000000ULL
+#define ADF_SSMWDTATHL_OFFSET		0x5208
+#define ADF_SSMWDTATHH_OFFSET		0x520C
+#define ADF_SSMWDTCNVL_OFFSET		0x5408
+#define ADF_SSMWDTCNVH_OFFSET		0x540C
+#define ADF_SSMWDTUCSL_OFFSET		0x5808
+#define ADF_SSMWDTUCSH_OFFSET		0x580C
+#define ADF_SSMWDTDCPRL_OFFSET		0x5A08
+#define ADF_SSMWDTDCPRH_OFFSET		0x5A0C
+#define ADF_SSMWDTPKEL_OFFSET		0x5E08
+#define ADF_SSMWDTPKEH_OFFSET		0x5E0C
+
+/* Ring reset */
+#define ADF_RPRESET_POLL_TIMEOUT_US	(5 * USEC_PER_SEC)
+#define ADF_RPRESET_POLL_DELAY_US	20
+#define ADF_WQM_CSR_RPRESETCTL_RESET	BIT(0)
+#define ADF_WQM_CSR_RPRESETCTL(bank)	(0x6000 + (bank) * 8)
+#define ADF_WQM_CSR_RPRESETSTS_STATUS	BIT(0)
+#define ADF_WQM_CSR_RPRESETSTS(bank)	(ADF_WQM_CSR_RPRESETCTL(bank) + 4)
+
+/* Controls and sets up the corresponding ring mode of operation */
+#define ADF_GEN6_CSR_RINGMODECTL(bank)		(0x9000 + (bank) * 4)
+
+/* Specifies the traffic class to use for the transactions to/from the ring */
+#define ADF_GEN6_RINGMODECTL_TC_MASK		GENMASK(18, 16)
+#define ADF_GEN6_RINGMODECTL_TC_DEFAULT		0x7
+
+/* Specifies usage of tc for the transactions to/from this ring */
+#define ADF_GEN6_RINGMODECTL_TC_EN_MASK		GENMASK(20, 19)
+
+/*
+ * Use the value programmed in the tc field for request descriptor
+ * and metadata read transactions
+ */
+#define ADF_GEN6_RINGMODECTL_TC_EN_OP1		0x1
+
+/* VC0 Resource Control Register */
+#define ADF_GEN6_PVC0CTL_OFFSET			0x204
+#define ADF_GEN6_PVC0CTL_TCVCMAP_OFFSET		1
+#define ADF_GEN6_PVC0CTL_TCVCMAP_MASK		GENMASK(7, 1)
+#define ADF_GEN6_PVC0CTL_TCVCMAP_DEFAULT	0x7F
+
+/* VC1 Resource Control Register */
+#define ADF_GEN6_PVC1CTL_OFFSET			0x210
+#define ADF_GEN6_PVC1CTL_TCVCMAP_OFFSET		1
+#define ADF_GEN6_PVC1CTL_TCVCMAP_MASK		GENMASK(7, 1)
+#define ADF_GEN6_PVC1CTL_TCVCMAP_DEFAULT	0x40
+#define ADF_GEN6_PVC1CTL_VCEN_OFFSET		31
+#define ADF_GEN6_PVC1CTL_VCEN_MASK		BIT(31)
+/* RW bit: 0x1 - enables a Virtual Channel, 0x0 - disables */
+#define ADF_GEN6_PVC1CTL_VCEN_ON		0x1
+
+/* Error source mask registers */
+#define ADF_GEN6_ERRMSK0	0x41A210
+#define ADF_GEN6_ERRMSK1	0x41A214
+#define ADF_GEN6_ERRMSK2	0x41A218
+#define ADF_GEN6_ERRMSK3	0x41A21C
+
+#define ADF_GEN6_VFLNOTIFY	BIT(7)
+
+/* Number of heartbeat counter pairs */
+#define ADF_NUM_HB_CNT_PER_AE ADF_NUM_THREADS_PER_AE
+
+/* Physical function fuses */
+#define ADF_6XXX_ACCELENGINES_MASK	GENMASK(8, 0)
+#define ADF_6XXX_ADMIN_AE_MASK		GENMASK(8, 8)
+
+/* Firmware binaries */
+#define ADF_6XXX_FW		"qat_6xxx.bin"
+#define ADF_6XXX_MMP		"qat_6xxx_mmp.bin"
+#define ADF_6XXX_CY_OBJ		"qat_6xxx_cy.bin"
+#define ADF_6XXX_DC_OBJ		"qat_6xxx_dc.bin"
+#define ADF_6XXX_ADMIN_OBJ	"qat_6xxx_admin.bin"
+
+enum icp_qat_gen6_slice_mask {
+	ICP_ACCEL_GEN6_MASK_UCS_SLICE = BIT(0),
+	ICP_ACCEL_GEN6_MASK_AUTH_SLICE = BIT(1),
+	ICP_ACCEL_GEN6_MASK_PKE_SLICE = BIT(2),
+	ICP_ACCEL_GEN6_MASK_CPR_SLICE = BIT(3),
+	ICP_ACCEL_GEN6_MASK_DCPRZ_SLICE = BIT(4),
+	ICP_ACCEL_GEN6_MASK_WCP_WAT_SLICE = BIT(6),
+};
+
+void adf_init_hw_data_6xxx(struct adf_hw_device_data *hw_data);
+void adf_clean_hw_data_6xxx(struct adf_hw_device_data *hw_data);
+
+#endif /* ADF_6XXX_HW_DATA_H_ */
diff --git a/drivers/crypto/intel/qat/qat_6xxx/adf_drv.c b/drivers/crypto/intel/qat/qat_6xxx/adf_drv.c
new file mode 100644
index 000000000000..2531c337e0dd
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_6xxx/adf_drv.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2025 Intel Corporation */
+#include <linux/array_size.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+
+#include <adf_accel_devices.h>
+#include <adf_cfg.h>
+#include <adf_common_drv.h>
+#include <adf_dbgfs.h>
+
+#include "adf_gen6_shared.h"
+#include "adf_6xxx_hw_data.h"
+
+static int bar_map[] = {
+	0,	/* SRAM */
+	2,	/* PMISC */
+	4,	/* ETR */
+};
+
+static void adf_device_down(void *accel_dev)
+{
+	adf_dev_down(accel_dev);
+}
+
+static void adf_dbgfs_cleanup(void *accel_dev)
+{
+	adf_dbgfs_exit(accel_dev);
+}
+
+static void adf_cfg_device_remove(void *accel_dev)
+{
+	adf_cfg_dev_remove(accel_dev);
+}
+
+static void adf_cleanup_hw_data(void *accel_dev)
+{
+	struct adf_accel_dev *accel_device = accel_dev;
+
+	if (accel_device->hw_device) {
+		adf_clean_hw_data_6xxx(accel_device->hw_device);
+		accel_device->hw_device = NULL;
+	}
+}
+
+static void adf_devmgr_remove(void *accel_dev)
+{
+	adf_devmgr_rm_dev(accel_dev, NULL);
+}
+
+static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	struct adf_accel_pci *accel_pci_dev;
+	struct adf_hw_device_data *hw_data;
+	struct device *dev = &pdev->dev;
+	struct adf_accel_dev *accel_dev;
+	struct adf_bar *bar;
+	unsigned int i;
+	int ret;
+
+	if (num_possible_nodes() > 1 && dev_to_node(dev) < 0) {
+		/*
+		 * If the accelerator is connected to a node with no memory
+		 * there is no point in using the accelerator since the remote
+		 * memory transaction will be very slow.
+		 */
+		return dev_err_probe(dev, -EINVAL, "Invalid NUMA configuration.\n");
+	}
+
+	accel_dev = devm_kzalloc(dev, sizeof(*accel_dev), GFP_KERNEL);
+	if (!accel_dev)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&accel_dev->crypto_list);
+	INIT_LIST_HEAD(&accel_dev->list);
+	accel_pci_dev = &accel_dev->accel_pci_dev;
+	accel_pci_dev->pci_dev = pdev;
+	accel_dev->owner = THIS_MODULE;
+
+	hw_data = devm_kzalloc(dev, sizeof(*hw_data), GFP_KERNEL);
+	if (!hw_data)
+		return -ENOMEM;
+
+	pci_read_config_byte(pdev, PCI_REVISION_ID, &accel_pci_dev->revid);
+	pci_read_config_dword(pdev, ADF_GEN6_FUSECTL4_OFFSET, &hw_data->fuses[ADF_FUSECTL4]);
+	pci_read_config_dword(pdev, ADF_GEN6_FUSECTL0_OFFSET, &hw_data->fuses[ADF_FUSECTL0]);
+	pci_read_config_dword(pdev, ADF_GEN6_FUSECTL1_OFFSET, &hw_data->fuses[ADF_FUSECTL1]);
+
+	if (!(hw_data->fuses[ADF_FUSECTL1] & ICP_ACCEL_GEN6_MASK_WCP_WAT_SLICE))
+		return dev_err_probe(dev, -EFAULT, "Wireless mode is not supported.\n");
+
+	/* Enable PCI device */
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Cannot enable PCI device.\n");
+
+	ret = adf_devmgr_add_dev(accel_dev, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add new accelerator device.\n");
+
+	ret = devm_add_action_or_reset(dev, adf_devmgr_remove, accel_dev);
+	if (ret)
+		return ret;
+
+	accel_dev->hw_device = hw_data;
+	adf_init_hw_data_6xxx(accel_dev->hw_device);
+
+	ret = devm_add_action_or_reset(dev, adf_cleanup_hw_data, accel_dev);
+	if (ret)
+		return ret;
+
+	/* Get Accelerators and Accelerator Engine masks */
+	hw_data->accel_mask = hw_data->get_accel_mask(hw_data);
+	hw_data->ae_mask = hw_data->get_ae_mask(hw_data);
+	accel_pci_dev->sku = hw_data->get_sku(hw_data);
+
+	/* If the device has no acceleration engines then ignore it */
+	if (!hw_data->accel_mask || !hw_data->ae_mask ||
+	    (~hw_data->ae_mask & ADF_GEN6_ACCELERATORS_MASK)) {
+		ret = -EFAULT;
+		return dev_err_probe(dev, ret, "No acceleration units were found.\n");
+	}
+
+	/* Create device configuration table */
+	ret = adf_cfg_dev_add(accel_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, adf_cfg_device_remove, accel_dev);
+	if (ret)
+		return ret;
+
+	/* Set DMA identifier */
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (ret)
+		return dev_err_probe(dev, ret, "No usable DMA configuration.\n");
+
+	ret = adf_gen6_cfg_dev_init(accel_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize configuration.\n");
+
+	/* Get accelerator capability mask */
+	hw_data->accel_capabilities_mask = hw_data->get_accel_cap(accel_dev);
+	if (!hw_data->accel_capabilities_mask) {
+		ret = -EINVAL;
+		return dev_err_probe(dev, ret, "Failed to get capabilities mask.\n");
+	}
+
+	for (i = 0; i < ARRAY_SIZE(bar_map); i++) {
+		bar = &accel_pci_dev->pci_bars[i];
+
+		/* Map 64-bit PCIe BAR */
+		bar->virt_addr = pcim_iomap_region(pdev, bar_map[i], pci_name(pdev));
+		if (!bar->virt_addr) {
+			ret = -ENOMEM;
+			return dev_err_probe(dev, ret, "Failed to ioremap PCI region.\n");
+		}
+	}
+
+	pci_set_master(pdev);
+
+	/*
+	 * The PCI config space is saved at this point and will be restored
+	 * after a Function Level Reset (FLR) as the FLR does not completely
+	 * restore it.
+	 */
+	ret = pci_save_state(pdev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to save pci state.\n");
+
+	adf_dbgfs_init(accel_dev);
+
+	ret = devm_add_action_or_reset(dev, adf_dbgfs_cleanup, accel_dev);
+	if (ret)
+		return ret;
+
+	ret = adf_dev_up(accel_dev, true);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, adf_device_down, accel_dev);
+	if (ret)
+		return ret;
+
+	ret = adf_sysfs_init(accel_dev);
+
+	return ret;
+}
+
+static void adf_shutdown(struct pci_dev *pdev)
+{
+	struct adf_accel_dev *accel_dev = adf_devmgr_pci_to_accel_dev(pdev);
+
+	adf_dev_down(accel_dev);
+}
+
+static const struct pci_device_id adf_pci_tbl[] = {
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_QAT_6XXX) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, adf_pci_tbl);
+
+static struct pci_driver adf_driver = {
+	.id_table = adf_pci_tbl,
+	.name = ADF_6XXX_DEVICE_NAME,
+	.probe = adf_probe,
+	.shutdown = adf_shutdown,
+	.sriov_configure = adf_sriov_configure,
+	.err_handler = &adf_err_handler,
+};
+module_pci_driver(adf_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Intel");
+MODULE_FIRMWARE(ADF_6XXX_FW);
+MODULE_FIRMWARE(ADF_6XXX_MMP);
+MODULE_DESCRIPTION("Intel(R) QuickAssist Technology for GEN6 Devices");
+MODULE_SOFTDEP("pre: crypto-intel_qat");
+MODULE_IMPORT_NS("CRYPTO_QAT");
diff --git a/drivers/crypto/intel/qat/qat_common/Makefile b/drivers/crypto/intel/qat/qat_common/Makefile
index 0a9da7398a78..958f9a8ac6b3 100644
--- a/drivers/crypto/intel/qat/qat_common/Makefile
+++ b/drivers/crypto/intel/qat/qat_common/Makefile
@@ -19,6 +19,7 @@ intel_qat-y := adf_accel_engine.o \
 	adf_gen4_pm.o \
 	adf_gen4_ras.o \
 	adf_gen4_vf_mig.o \
+	adf_gen6_shared.o \
 	adf_hw_arbiter.o \
 	adf_init.o \
 	adf_isr.o \
diff --git a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
index ed8b85360573..2ee526063213 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
@@ -26,6 +26,7 @@
 #define ADF_C3XXXVF_DEVICE_NAME "c3xxxvf"
 #define ADF_4XXX_DEVICE_NAME "4xxx"
 #define ADF_420XX_DEVICE_NAME "420xx"
+#define ADF_6XXX_DEVICE_NAME "6xxx"
 #define PCI_DEVICE_ID_INTEL_QAT_4XXX 0x4940
 #define PCI_DEVICE_ID_INTEL_QAT_4XXXIOV 0x4941
 #define PCI_DEVICE_ID_INTEL_QAT_401XX 0x4942
@@ -35,6 +36,7 @@
 #define PCI_DEVICE_ID_INTEL_QAT_420XX 0x4946
 #define PCI_DEVICE_ID_INTEL_QAT_420XXIOV 0x4947
 #define PCI_DEVICE_ID_INTEL_QAT_6XXX 0x4948
+#define PCI_DEVICE_ID_INTEL_QAT_6XXX_IOV 0x4949
 
 #define ADF_DEVICE_FUSECTL_OFFSET 0x40
 #define ADF_DEVICE_LEGFUSE_OFFSET 0x4C
diff --git a/drivers/crypto/intel/qat/qat_common/adf_cfg_common.h b/drivers/crypto/intel/qat/qat_common/adf_cfg_common.h
index 89df3888d7ea..15fdf9854b81 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_cfg_common.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_cfg_common.h
@@ -48,6 +48,7 @@ enum adf_device_type {
 	DEV_C3XXXVF,
 	DEV_4XXX,
 	DEV_420XX,
+	DEV_6XXX,
 };
 
 struct adf_dev_status_info {
diff --git a/drivers/crypto/intel/qat/qat_common/adf_fw_config.h b/drivers/crypto/intel/qat/qat_common/adf_fw_config.h
index 4f86696800c9..78957fa900b7 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_fw_config.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_fw_config.h
@@ -8,6 +8,7 @@ enum adf_fw_objs {
 	ADF_FW_ASYM_OBJ,
 	ADF_FW_DC_OBJ,
 	ADF_FW_ADMIN_OBJ,
+	ADF_FW_CY_OBJ,
 };
 
 struct adf_fw_config {
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen6_pm.h b/drivers/crypto/intel/qat/qat_common/adf_gen6_pm.h
new file mode 100644
index 000000000000..9a5b995f7ada
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen6_pm.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2025 Intel Corporation */
+#ifndef ADF_GEN6_PM_H
+#define ADF_GEN6_PM_H
+
+#include <linux/bits.h>
+#include <linux/time.h>
+
+struct adf_accel_dev;
+
+/* Power management */
+#define ADF_GEN6_PM_POLL_DELAY_US	20
+#define ADF_GEN6_PM_POLL_TIMEOUT_US	USEC_PER_SEC
+#define ADF_GEN6_PM_STATUS		0x50A00C
+#define ADF_GEN6_PM_INTERRUPT		0x50A028
+
+/* Power management source in ERRSOU2 and ERRMSK2 */
+#define ADF_GEN6_PM_SOU			BIT(18)
+
+/* cpm_pm_interrupt bitfields */
+#define ADF_GEN6_PM_DRV_ACTIVE		BIT(20)
+
+#define ADF_GEN6_PM_DEFAULT_IDLE_FILTER	0x6
+
+/* cpm_pm_status bitfields */
+#define ADF_GEN6_PM_INIT_STATE			BIT(21)
+
+#endif /* ADF_GEN6_PM_H */
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen6_shared.c b/drivers/crypto/intel/qat/qat_common/adf_gen6_shared.c
new file mode 100644
index 000000000000..58a072e2f936
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen6_shared.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2025 Intel Corporation */
+#include <linux/export.h>
+
+#include "adf_gen4_config.h"
+#include "adf_gen4_hw_csr_data.h"
+#include "adf_gen4_pfvf.h"
+#include "adf_gen6_shared.h"
+
+struct adf_accel_dev;
+struct adf_pfvf_ops;
+struct adf_hw_csr_ops;
+
+/*
+ * QAT GEN4 and GEN6 devices often differ in terms of supported features,
+ * options and internal logic. However, some of the mechanisms and register
+ * layout are shared between those two GENs. This file serves as an abstraction
+ * layer that allows to use existing GEN4 implementation that is also
+ * applicable to GEN6 without additional overhead and complexity.
+ */
+void adf_gen6_init_pf_pfvf_ops(struct adf_pfvf_ops *pfvf_ops)
+{
+	adf_gen4_init_pf_pfvf_ops(pfvf_ops);
+}
+EXPORT_SYMBOL_GPL(adf_gen6_init_pf_pfvf_ops);
+
+void adf_gen6_init_hw_csr_ops(struct adf_hw_csr_ops *csr_ops)
+{
+	return adf_gen4_init_hw_csr_ops(csr_ops);
+}
+EXPORT_SYMBOL_GPL(adf_gen6_init_hw_csr_ops);
+
+int adf_gen6_cfg_dev_init(struct adf_accel_dev *accel_dev)
+{
+	return adf_gen4_cfg_dev_init(accel_dev);
+}
+EXPORT_SYMBOL_GPL(adf_gen6_cfg_dev_init);
+
+int adf_gen6_comp_dev_config(struct adf_accel_dev *accel_dev)
+{
+	return adf_comp_dev_config(accel_dev);
+}
+EXPORT_SYMBOL_GPL(adf_gen6_comp_dev_config);
+
+int adf_gen6_no_dev_config(struct adf_accel_dev *accel_dev)
+{
+	return adf_no_dev_config(accel_dev);
+}
+EXPORT_SYMBOL_GPL(adf_gen6_no_dev_config);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen6_shared.h b/drivers/crypto/intel/qat/qat_common/adf_gen6_shared.h
new file mode 100644
index 000000000000..bc8e71e984fc
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen6_shared.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2025 Intel Corporation */
+#ifndef ADF_GEN6_SHARED_H_
+#define ADF_GEN6_SHARED_H_
+
+struct adf_hw_csr_ops;
+struct adf_accel_dev;
+struct adf_pfvf_ops;
+
+void adf_gen6_init_pf_pfvf_ops(struct adf_pfvf_ops *pfvf_ops);
+void adf_gen6_init_hw_csr_ops(struct adf_hw_csr_ops *csr_ops);
+int adf_gen6_cfg_dev_init(struct adf_accel_dev *accel_dev);
+int adf_gen6_comp_dev_config(struct adf_accel_dev *accel_dev);
+int adf_gen6_no_dev_config(struct adf_accel_dev *accel_dev);
+#endif/* ADF_GEN6_SHARED_H_ */
-- 
2.40.1



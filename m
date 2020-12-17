Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57312DD60F
	for <lists+linux-crypto@lfdr.de>; Thu, 17 Dec 2020 18:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgLQRZ4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 17 Dec 2020 12:25:56 -0500
Received: from mga05.intel.com ([192.55.52.43]:47104 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgLQRZ4 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 17 Dec 2020 12:25:56 -0500
IronPort-SDR: dNWkIKE4DE4pFqwoEov5cI+IKeXsrizGjZBN9ECiVt79NHY7oq6FdVbcUKM6Ksb2BWin27itnk
 RhIy/eFw8n8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9838"; a="260017936"
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; 
   d="scan'208";a="260017936"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 09:21:46 -0800
IronPort-SDR: vXdyw/5yhtKTdKiJJi3Y+GOCIcELpA3liL+qidPwNrW1I/aTqdEubZWI1SCSNP0CbM5C8hv/Fz
 6LtdQPXaRpIw==
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; 
   d="scan'208";a="369931015"
Received: from cdonohoe-mobl2.ger.corp.intel.com (HELO dalessan-mobl1.ir.intel.com) ([10.252.13.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 09:21:41 -0800
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Prabhjot Khurana <prabhjot.khurana@intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>
Subject: [RFC PATCH 6/6] crypto: keembay-ocs-ecc - Add Keem Bay OCS ECC Driver
Date:   Thu, 17 Dec 2020 17:21:01 +0000
Message-Id: <20201217172101.381772-7-daniele.alessandrelli@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201217172101.381772-1-daniele.alessandrelli@linux.intel.com>
References: <20201217172101.381772-1-daniele.alessandrelli@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Prabhjot Khurana <prabhjot.khurana@intel.com>

The Intel Keem Bay SoC can provide hardware acceleration of Elliptic
Curve Cryptography (ECC) by means of its Offload and Crypto Subsystem
(OCS).

Add the Keem Bay OCS ECC driver which leverages such hardware
capabilities to provide hardware-acceleration of ECDH-256 and ECDH-384.

Signed-off-by: Prabhjot Khurana <prabhjot.khurana@intel.com>
Co-developed-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
---
 MAINTAINERS                                 |    4 +
 drivers/crypto/keembay/Kconfig              |   31 +
 drivers/crypto/keembay/Makefile             |    2 +
 drivers/crypto/keembay/keembay-ocs-ecc.c    | 1003 +++++++++++++++++++
 drivers/crypto/keembay/ocs-ecc-curve-defs.h |   68 ++
 5 files changed, 1108 insertions(+)
 create mode 100644 drivers/crypto/keembay/keembay-ocs-ecc.c
 create mode 100644 drivers/crypto/keembay/ocs-ecc-curve-defs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index fa5bc7c4c9fe..a9ba4989fb45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9076,6 +9076,10 @@ M:	Prabhjot Khurana <prabhjot.khurana@intel.com>
 M:	Mark Gross <mgross@linux.intel.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/crypto/intel,keembay-ocs-ecc.yaml
+F:	drivers/crypto/keembay/Kconfig
+F:	drivers/crypto/keembay/Makefile
+F:	drivers/crypto/keembay/keembay-ocs-ecc.c
+F:	drivers/crypto/keembay/ocs-ecc-curve-defs.h
 
 INTEL MANAGEMENT ENGINE (mei)
 M:	Tomas Winkler <tomas.winkler@intel.com>
diff --git a/drivers/crypto/keembay/Kconfig b/drivers/crypto/keembay/Kconfig
index 3c16797b25b9..01f9d4ecfa92 100644
--- a/drivers/crypto/keembay/Kconfig
+++ b/drivers/crypto/keembay/Kconfig
@@ -37,3 +37,34 @@ config CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_CTS
 	  Provides OCS version of cts(cbc(aes)) and cts(cbc(sm4)).
 
 	  Intel does not recommend use of CTS mode with AES/SM4.
+
+config CRYPTO_DEV_KEEMBAY_OCS_ECC
+	tristate "Support for Intel Keem Bay OCS ECC HW acceleration"
+	depends on ARCH_KEEMBAY || COMPILE_TEST
+	depends on OF || COMPILE_TEST
+	depends on HAS_IOMEM
+	select CRYPTO_ECDH
+	select CRYPTO_ENGINE
+	help
+	  Support for Intel Keem Bay Offload and Crypto Subsystem (OCS)
+	  Elliptic Curve Cryptography (ECC) hardware acceleration for use with
+	  Crypto API.
+
+	  Provides OCS acceleration for ECDH-256, ECDH-384.
+
+	  Say Y or M if you are compiling for the Intel Keem Bay SoC. The
+	  module will be called keembay-ocs-ecc.
+
+	  If unsure, say N.
+
+config CRYPTO_DEV_KEEMBAY_OCS_ECDH_GEN_PRIV_KEY_SUPPORT
+	bool "Add ECDH private key generation in Keem Bay OCS ECC driver"
+	depends on CRYPTO_DEV_KEEMBAY_OCS_ECC
+	help
+	  Add ECDH private key generation in the Intel Keem Bay OCS ECC driver.
+
+	  Intel does not recommend use of private key generation for ECDH
+	  computations, which, however, is required to pass crypto self-tests.
+
+	  Say Y if you need the driver to pass crypto self-tests. If unsure,
+	  say N.
diff --git a/drivers/crypto/keembay/Makefile b/drivers/crypto/keembay/Makefile
index f21e2c4ab3b3..6ac1182871f7 100644
--- a/drivers/crypto/keembay/Makefile
+++ b/drivers/crypto/keembay/Makefile
@@ -3,3 +3,5 @@
 #
 obj-$(CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4) += keembay-ocs-aes.o
 keembay-ocs-aes-objs := keembay-ocs-aes-core.o ocs-aes.o
+
+obj-$(CONFIG_CRYPTO_DEV_KEEMBAY_OCS_ECC) += keembay-ocs-ecc.o
diff --git a/drivers/crypto/keembay/keembay-ocs-ecc.c b/drivers/crypto/keembay/keembay-ocs-ecc.c
new file mode 100644
index 000000000000..7775ac864fff
--- /dev/null
+++ b/drivers/crypto/keembay/keembay-ocs-ecc.c
@@ -0,0 +1,1003 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel Keem Bay OCS ECC Crypto Driver.
+ *
+ * Copyright (C) 2019-2020 Intel Corporation
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/crypto.h>
+#include <linux/delay.h>
+#include <linux/fips.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include <crypto/ecdh.h>
+#include <crypto/engine.h>
+#include <crypto/kpp.h>
+#include <crypto/rng.h>
+
+#include <crypto/internal/ecc.h>
+#include <crypto/internal/kpp.h>
+
+#include "ocs-ecc-curve-defs.h"
+
+#define DRV_NAME			"keembay-ocs-ecc"
+
+#define KMB_OCS_ECC_PRIORITY		350
+
+#define HW_OFFS_OCS_ECC_COMMAND		0x00000000
+#define HW_OFFS_OCS_ECC_STATUS		0x00000004
+#define HW_OFFS_OCS_ECC_DATA_IN		0x00000080
+#define HW_OFFS_OCS_ECC_CX_DATA_OUT	0x00000100
+#define HW_OFFS_OCS_ECC_CY_DATA_OUT	0x00000180
+#define HW_OFFS_OCS_ECC_ISR		0x00000400
+#define HW_OFFS_OCS_ECC_IER		0x00000404
+
+#define HW_OCS_ECC_ISR_INT_STATUS_DONE	BIT(0)
+#define HW_OCS_ECC_COMMAND_INS_BP	BIT(0)
+
+#define HW_OCS_ECC_COMMAND_START_VAL	BIT(0)
+
+#define OCS_ECC_OP_SIZE_384		BIT(8)
+#define OCS_ECC_OP_SIZE_256		0
+
+/* ECC Instruction : for ECC_COMMAND */
+#define OCS_ECC_INST_WRITE_AX		(0x01 << HW_OCS_ECC_COMMAND_INS_BP)
+#define OCS_ECC_INST_WRITE_AY		(0x02 << HW_OCS_ECC_COMMAND_INS_BP)
+#define OCS_ECC_INST_WRITE_BX_D		(0x03 << HW_OCS_ECC_COMMAND_INS_BP)
+#define OCS_ECC_INST_WRITE_BY_L		(0x04 << HW_OCS_ECC_COMMAND_INS_BP)
+#define OCS_ECC_INST_WRITE_P		(0x05 << HW_OCS_ECC_COMMAND_INS_BP)
+#define OCS_ECC_INST_WRITE_A		(0x06 << HW_OCS_ECC_COMMAND_INS_BP)
+#define OCS_ECC_INST_CALC_D_IDX_A	(0x08 << HW_OCS_ECC_COMMAND_INS_BP)
+#define OCS_ECC_INST_CALC_A_POW_B_MODP	(0xB  << HW_OCS_ECC_COMMAND_INS_BP)
+#define OCS_ECC_INST_CALC_A_MUL_B_MODP	(0xB  << HW_OCS_ECC_COMMAND_INS_BP)
+#define OCS_ECC_INST_CALC_A_ADD_B_MODP	(0xB  << HW_OCS_ECC_COMMAND_INS_BP)
+
+#define ECC_ENABLE_INTR			1
+
+#define POLL_USEC			100
+#define TIMEOUT_USEC			10000
+
+#define ECC_CURVE_NIST_P384_DIGITS	(384 / 64)
+#define KMB_ECC_VLI_MAX_DIGITS		ECC_CURVE_NIST_P384_DIGITS
+#define KMB_ECC_VLI_MAX_BYTES		(KMB_ECC_VLI_MAX_DIGITS \
+					 << ECC_DIGITS_TO_BYTES_SHIFT)
+
+#define POW_CUBE			3
+
+/**
+ * struct ocs_ecc_dev - ECC device context
+ * @list: List of device contexts
+ * @dev: OCS ECC device
+ * @base_reg: IO base address of OCS ECC
+ * @engine: Crypto engine for the device
+ * @irq_done: IRQ done completion.
+ * @irq: IRQ number
+ */
+struct ocs_ecc_dev {
+	struct list_head list;
+	struct device *dev;
+	void __iomem *base_reg;
+	struct crypto_engine *engine;
+	struct completion irq_done;
+	int irq;
+};
+
+/**
+ * struct ocs_ecc_ctx - Transformation context.
+ * @engine_ctx:	 Crypto engine ctx.
+ * @ecc_dev:	 The ECC driver associated with this context.
+ * @curve:	 The elliptic curve used by this transformation.
+ * @private_key: The private key.
+ */
+struct ocs_ecc_ctx {
+	struct crypto_engine_ctx engine_ctx;
+	struct ocs_ecc_dev *ecc_dev;
+	const struct ecc_curve *curve;
+	u64 private_key[KMB_ECC_VLI_MAX_DIGITS];
+};
+
+/* Driver data. */
+struct ocs_ecc_drv {
+	struct list_head dev_list;
+	spinlock_t lock;	/* Protects dev_list. */
+};
+
+/* Global variable holding the list of OCS ECC devices (only one expected). */
+static struct ocs_ecc_drv ocs_ecc = {
+	.dev_list = LIST_HEAD_INIT(ocs_ecc.dev_list),
+	.lock = __SPIN_LOCK_UNLOCKED(ocs_ecc.lock),
+};
+
+/* Get OCS ECC tfm context from kpp_request. */
+static inline struct ocs_ecc_ctx *kmb_ocs_ecc_tctx(struct kpp_request *req)
+{
+	return kpp_tfm_ctx(crypto_kpp_reqtfm(req));
+}
+
+/* Converts number of digits to number of bytes. */
+static inline unsigned int digits_to_bytes(unsigned int n)
+{
+	return n << ECC_DIGITS_TO_BYTES_SHIFT;
+}
+
+static inline const struct ecc_curve *kmb_ecc_get_curve(unsigned int curve_id)
+{
+	switch (curve_id) {
+	case ECC_CURVE_NIST_P256:
+		return &nist_p256;
+	case ECC_CURVE_NIST_P384:
+		return &nist_p384;
+	default:
+		return NULL;
+	}
+}
+
+/*
+ * Wait for ECC idle i.e when an operation (other than write operations)
+ * is done.
+ */
+static inline int ocs_ecc_wait_idle(struct ocs_ecc_dev *dev)
+{
+	u32 value;
+
+	return readl_poll_timeout((dev->base_reg + HW_OFFS_OCS_ECC_STATUS),
+				  value,
+				  !(value & HW_OCS_ECC_ISR_INT_STATUS_DONE),
+				  POLL_USEC, TIMEOUT_USEC);
+}
+
+static void ocs_ecc_cmd_start(struct ocs_ecc_dev *ecc_dev, u32 op_size)
+{
+	iowrite32(op_size | HW_OCS_ECC_COMMAND_START_VAL,
+		  ecc_dev->base_reg + HW_OFFS_OCS_ECC_COMMAND);
+}
+
+/* Direct write of u32 buffer to ECC engine with associated instruction. */
+static void ocs_ecc_write_cmd_and_data(struct ocs_ecc_dev *dev,
+				       u32 op_size,
+				       u32 inst,
+				       const void *data_in,
+				       size_t data_size)
+{
+	iowrite32(op_size | inst, dev->base_reg + HW_OFFS_OCS_ECC_COMMAND);
+
+	/* MMIO Write src uint32 to dst. */
+	memcpy_toio(dev->base_reg + HW_OFFS_OCS_ECC_DATA_IN, data_in,
+		    data_size);
+}
+
+/* Start OCS ECC operation and wait for its completion. */
+static int ocs_ecc_trigger_op(struct ocs_ecc_dev *ecc_dev, u32 op_size,
+			       u32 inst)
+{
+	reinit_completion(&ecc_dev->irq_done);
+
+	iowrite32(ECC_ENABLE_INTR, ecc_dev->base_reg + HW_OFFS_OCS_ECC_IER);
+	iowrite32(op_size | inst, ecc_dev->base_reg + HW_OFFS_OCS_ECC_COMMAND);
+
+	return wait_for_completion_interruptible(&ecc_dev->irq_done);
+}
+
+/**
+ * ocs_ecc_read_cx_out() - Read the CX data output buffer.
+ * @dev:	The OCS ECC device to read from.
+ * @cx_out:	The buffer where to store the CX value. Must be at least
+ *		@byte_count byte long.
+ * @byte_count:	The amount of data to read.
+ */
+static inline void ocs_ecc_read_cx_out(struct ocs_ecc_dev *dev, void *cx_out,
+				       size_t byte_count)
+{
+	memcpy_fromio(cx_out, dev->base_reg + HW_OFFS_OCS_ECC_CX_DATA_OUT,
+		      byte_count);
+}
+
+/**
+ * ocs_ecc_read_cy_out() - Read the CX data output buffer.
+ * @dev:	The OCS ECC device to read from.
+ * @cy_out:	The buffer where to store the CY value. Must be at least
+ *		@byte_count byte long.
+ * @byte_count:	The amount of data to read.
+ */
+static inline void ocs_ecc_read_cy_out(struct ocs_ecc_dev *dev, void *cy_out,
+				       size_t byte_count)
+{
+	memcpy_fromio(cy_out, dev->base_reg + HW_OFFS_OCS_ECC_CY_DATA_OUT,
+		      byte_count);
+}
+
+static struct ocs_ecc_dev *kmb_ocs_ecc_find_dev(struct ocs_ecc_ctx *tctx)
+{
+	if (tctx->ecc_dev)
+		return tctx->ecc_dev;
+
+	spin_lock(&ocs_ecc.lock);
+
+	/* Only a single OCS device available. */
+	tctx->ecc_dev = list_first_entry(&ocs_ecc.dev_list, struct ocs_ecc_dev,
+					 list);
+
+	spin_unlock(&ocs_ecc.lock);
+
+	return tctx->ecc_dev;
+}
+
+/* Do point multiplication using OCS ECC HW. */
+static int kmb_ecc_point_mult(struct ocs_ecc_dev *ecc_dev,
+			      struct ecc_point *result,
+			      const struct ecc_point *point,
+			      u64 *scalar,
+			      const struct ecc_curve *curve)
+{
+	u8 sca[KMB_ECC_VLI_MAX_BYTES]; /* Use the maximum data size. */
+	u32 op_size = (curve->g.ndigits > ECC_CURVE_NIST_P256_DIGITS) ?
+		      OCS_ECC_OP_SIZE_384 : OCS_ECC_OP_SIZE_256;
+	size_t nbytes = digits_to_bytes(curve->g.ndigits);
+	int rc = 0;
+
+	/* Generate random nbytes for Simple and Differential SCA protection. */
+	rc = crypto_get_default_rng();
+	if (rc)
+		return rc;
+
+	rc = crypto_rng_get_bytes(crypto_default_rng, sca, nbytes);
+	crypto_put_default_rng();
+	if (rc)
+		return rc;
+
+	/* Wait engine to be idle before starting new operation. */
+	rc = ocs_ecc_wait_idle(ecc_dev);
+	if (rc)
+		return rc;
+
+	/* Send ecc_start pulse as well as indicating operation size. */
+	ocs_ecc_cmd_start(ecc_dev, op_size);
+
+	/* Write ax param; Base point (Gx). */
+	ocs_ecc_write_cmd_and_data(ecc_dev, op_size, OCS_ECC_INST_WRITE_AX,
+				   point->x, nbytes);
+
+	/* Write ay param; Base point (Gy). */
+	ocs_ecc_write_cmd_and_data(ecc_dev, op_size, OCS_ECC_INST_WRITE_AY,
+				   point->y, nbytes);
+
+	/*
+	 * Write the private key into DATA_IN reg.
+	 *
+	 * Since DATA_IN register is used to write different values during the
+	 * computation private Key value is overwritten with
+	 * side-channel-resistance value.
+	 */
+	ocs_ecc_write_cmd_and_data(ecc_dev, op_size, OCS_ECC_INST_WRITE_BX_D,
+				   scalar, nbytes);
+
+	/* Write operand by/l. */
+	ocs_ecc_write_cmd_and_data(ecc_dev, op_size, OCS_ECC_INST_WRITE_BY_L,
+				   sca, nbytes);
+	memzero_explicit(sca, sizeof(sca));
+
+	/* Write p = curve prime(GF modulus). */
+	ocs_ecc_write_cmd_and_data(ecc_dev, op_size, OCS_ECC_INST_WRITE_P,
+				   curve->p, nbytes);
+
+	/* Write a = curve coefficient. */
+	ocs_ecc_write_cmd_and_data(ecc_dev, op_size, OCS_ECC_INST_WRITE_A,
+				   curve->a, nbytes);
+
+	/* Make hardware perform the multiplication. */
+	rc = ocs_ecc_trigger_op(ecc_dev, op_size, OCS_ECC_INST_CALC_D_IDX_A);
+	if (rc)
+		return rc;
+
+	/* Read result. */
+	ocs_ecc_read_cx_out(ecc_dev, result->x, nbytes);
+	ocs_ecc_read_cy_out(ecc_dev, result->y, nbytes);
+
+	return 0;
+}
+
+/**
+ * kmb_ecc_do_scalar_op() - Perform Scalar operation using OCS ECC HW.
+ * @ecc_dev:	The OCS ECC device to use.
+ * @scalar_out:	Where to store the output scalar.
+ * @scalar_a:	Input scalar operand 'a'.
+ * @scalar_b:	Input scalar operand 'b'
+ * @curve:	The curve on which the operation is performed.
+ * @ndigits:	The size of the operands (in digits).
+ * @inst:	The operation to perform (as an OCS ECC instruction).
+ *
+ * Return:	0 on success, negative error code otherwise.
+ */
+static int kmb_ecc_do_scalar_op(struct ocs_ecc_dev *ecc_dev, u64 *scalar_out,
+				const u64 *scalar_a, const u64 *scalar_b,
+				const struct ecc_curve *curve,
+				unsigned int ndigits, const u32 inst)
+{
+	u32 op_size = (ndigits > ECC_CURVE_NIST_P256_DIGITS) ?
+		      OCS_ECC_OP_SIZE_384 : OCS_ECC_OP_SIZE_256;
+	size_t nbytes = digits_to_bytes(ndigits);
+	size_t data_size_u8;
+	int rc;
+
+	/* Wait engine to be idle before starting new operation. */
+	rc = ocs_ecc_wait_idle(ecc_dev);
+
+	if (rc)
+		return rc;
+
+	/* Send ecc_start pulse as well as indicating operation size. */
+	ocs_ecc_cmd_start(ecc_dev, op_size);
+
+	/* Write ax param (Base point (Gx).*/
+	ocs_ecc_write_cmd_and_data(ecc_dev, op_size, OCS_ECC_INST_WRITE_AX,
+				   scalar_a, nbytes);
+
+	/* Write ay param Base point (Gy).*/
+	ocs_ecc_write_cmd_and_data(ecc_dev, op_size, OCS_ECC_INST_WRITE_AY,
+				   scalar_b, nbytes);
+
+	/* Write p = curve prime(GF modulus).*/
+	ocs_ecc_write_cmd_and_data(ecc_dev, op_size, OCS_ECC_INST_WRITE_P,
+				   curve->p, nbytes);
+
+	/* Give instruction A.B or A+B to ECC engine. */
+	rc = ocs_ecc_trigger_op(ecc_dev, op_size, inst);
+	if (rc)
+		return rc;
+
+	data_size_u8 = digits_to_bytes(ndigits);
+
+	ocs_ecc_read_cx_out(ecc_dev, scalar_out, data_size_u8);
+
+	if (vli_is_zero(scalar_out, ndigits))
+		return -EINVAL;
+
+	return 0;
+}
+
+/* SP800-56A section 5.6.2.3.4 partial verification: ephemeral keys only */
+static int kmb_ocs_ecc_is_pubkey_valid_partial(struct ocs_ecc_dev *ecc_dev,
+					       const struct ecc_curve *curve,
+					       struct ecc_point *pk)
+{
+	u64 xxx[KMB_ECC_VLI_MAX_DIGITS];
+	u64 yy[KMB_ECC_VLI_MAX_DIGITS];
+	u64 w[KMB_ECC_VLI_MAX_DIGITS];
+	int rc;
+
+	if (WARN_ON(pk->ndigits != curve->g.ndigits))
+		return -EINVAL;
+
+	/* Check 1: Verify key is not the zero point. */
+	if (ecc_point_is_zero(pk))
+		return -EINVAL;
+
+	/* Check 2: Verify key is in the range [0, p-1]. */
+	if (vli_cmp(curve->p, pk->x, pk->ndigits) != 1)
+		return -EINVAL;
+
+	if (vli_cmp(curve->p, pk->y, pk->ndigits) != 1)
+		return -EINVAL;
+
+	/* Check 3: Verify that y^2 == (x^3 + a·x + b) mod p */
+
+	 /* y^2 */
+	/* Compute y^2 -> store in yy */
+	rc = kmb_ecc_do_scalar_op(ecc_dev, yy, pk->y, pk->y, curve, pk->ndigits,
+				  OCS_ECC_INST_CALC_A_MUL_B_MODP);
+	if (!rc)
+		goto exit;
+
+	/* x^3 */
+	/* Assigning w = 3, used for calculating x^3. */
+	w[0] = POW_CUBE;
+	/* Load the next stage.*/
+	rc = kmb_ecc_do_scalar_op(ecc_dev, xxx, pk->x, w, curve, pk->ndigits,
+				  OCS_ECC_INST_CALC_A_POW_B_MODP);
+	if (!rc)
+		goto exit;
+
+	/* Do a*x -> store in w. */
+	rc = kmb_ecc_do_scalar_op(ecc_dev, w, curve->a, pk->x, curve,
+				  pk->ndigits,
+				  OCS_ECC_INST_CALC_A_MUL_B_MODP);
+	if (!rc)
+		goto exit;
+
+	/* Do ax + b == w + b; store in w. */
+	rc = kmb_ecc_do_scalar_op(ecc_dev, w, w, curve->b, curve,
+				  pk->ndigits,
+				  OCS_ECC_INST_CALC_A_ADD_B_MODP);
+	if (!rc)
+		goto exit;
+
+	/* x^3 + ax + b == x^3 + w -> store in w. */
+	rc = kmb_ecc_do_scalar_op(ecc_dev, w, xxx, w, curve, pk->ndigits,
+				  OCS_ECC_INST_CALC_A_ADD_B_MODP);
+	if (!rc)
+		goto exit;
+
+	/* Compare y^2 == x^3 + a·x + b. */
+	rc = vli_cmp(yy, w, pk->ndigits);
+	if (rc)
+		rc = -EINVAL;
+
+exit:
+	memzero_explicit(xxx, sizeof(xxx));
+	memzero_explicit(yy, sizeof(yy));
+	memzero_explicit(w, sizeof(w));
+
+	return rc;
+}
+
+/* SP800-56A section 5.6.2.3.3 full verification */
+static int kmb_ocs_ecc_is_pubkey_valid_full(struct ocs_ecc_dev *ecc_dev,
+					    const struct ecc_curve *curve,
+					    struct ecc_point *pk)
+{
+	struct ecc_point *nQ;
+	int rc;
+
+	/* Checks 1 through 3 */
+	rc = kmb_ocs_ecc_is_pubkey_valid_partial(ecc_dev, curve, pk);
+	if (rc)
+		return rc;
+
+	/* Check 4: Verify that nQ is the zero point. */
+	nQ = ecc_alloc_point(pk->ndigits);
+	if (!nQ)
+		return -ENOMEM;
+
+	rc = kmb_ecc_point_mult(ecc_dev, nQ, pk, curve->n, curve);
+	if (rc)
+		goto exit;
+
+	if (!ecc_point_is_zero(nQ))
+		rc = -EINVAL;
+
+exit:
+	ecc_free_point(nQ);
+
+	return rc;
+}
+
+static int kmb_ecc_is_key_valid(const struct ecc_curve *curve,
+				const u64 *private_key, size_t private_key_len)
+{
+	size_t ndigits = curve->g.ndigits;
+	u64 one[KMB_ECC_VLI_MAX_DIGITS] = {1};
+	u64 res[KMB_ECC_VLI_MAX_DIGITS];
+
+	if (private_key_len != digits_to_bytes(ndigits))
+		return -EINVAL;
+
+	if (!private_key)
+		return -EINVAL;
+
+	/* Make sure the private key is in the range [2, n-3]. */
+	if (vli_cmp(one, private_key, ndigits) != -1)
+		return -EINVAL;
+
+	vli_sub(res, curve->n, one, ndigits);
+	vli_sub(res, res, one, ndigits);
+	if (vli_cmp(res, private_key, ndigits) != 1)
+		return -EINVAL;
+
+	return 0;
+}
+
+#ifdef	CONFIG_CRYPTO_DEV_KEEMBAY_OCS_ECDH_GEN_PRIV_KEY_SUPPORT
+/*
+ * ECC private keys are generated using the method of extra random bits,
+ * equivalent to that described in FIPS 186-4, Appendix B.4.1.
+ *
+ * d = (c mod(n–1)) + 1    where c is a string of random bits, 64 bits longer
+ *                         than requested
+ * 0 <= c mod(n-1) <= n-2  and implies that
+ * 1 <= d <= n-1
+ *
+ * This method generates a private key uniformly distributed in the range
+ * [1, n-1].
+ */
+static int kmb_ecc_gen_privkey(const struct ecc_curve *curve, u64 *privkey)
+{
+	size_t nbytes = digits_to_bytes(curve->g.ndigits);
+	u64 priv[KMB_ECC_VLI_MAX_DIGITS];
+	size_t nbits;
+	int rc;
+
+	nbits = vli_num_bits(curve->n, curve->g.ndigits);
+
+	/* Check that N is included in Table 1 of FIPS 186-4, section 6.1.1 */
+	if (nbits < 160 || curve->g.ndigits > ARRAY_SIZE(priv))
+		return -EINVAL;
+
+	/*
+	 * FIPS 186-4 recommends that the private key should be obtained from a
+	 * RBG with a security strength equal to or greater than the security
+	 * strength associated with N.
+	 *
+	 * The maximum security strength identified by NIST SP800-57pt1r4 for
+	 * ECC is 256 (N >= 512).
+	 *
+	 * This condition is met by the default RNG because it selects a favored
+	 * DRBG with a security strength of 256.
+	 */
+	if (crypto_get_default_rng())
+		return -EFAULT;
+
+	rc = crypto_rng_get_bytes(crypto_default_rng, (u8 *)priv, nbytes);
+	crypto_put_default_rng();
+	if (rc)
+		goto cleanup;
+
+	rc = kmb_ecc_is_key_valid(curve, priv, nbytes);
+	if (rc)
+		goto cleanup;
+
+	ecc_swap_digits(priv, privkey, curve->g.ndigits);
+
+cleanup:
+	memzero_explicit(&priv, sizeof(priv));
+
+	return rc;
+}
+#else /* !CONFIG_CRYPTO_DEV_KEEMBAY_OCS_ECDH_GEN_PRIV_KEY_SUPPORT */
+/* If key generation is not enabled, always return error. */
+static int kmb_ecc_gen_privkey(const struct ecc_curve *curve, u64 *privkey)
+{
+	return -EINVAL;
+}
+#endif  /* !CONFIG_CRYPTO_DEV_KEEMBAY_OCS_ECDH_GEN_PRIV_KEY_SUPPORT */
+
+static int kmb_ocs_ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
+				   unsigned int len)
+{
+	struct ocs_ecc_ctx *tctx = kpp_tfm_ctx(tfm);
+	struct ecdh params;
+	int rc = 0;
+
+	rc = crypto_ecdh_decode_key(buf, len, &params);
+	if (rc)
+		goto cleanup;
+
+	tctx->curve = kmb_ecc_get_curve(params.curve_id);
+	if (!tctx->curve) {
+		rc = -EOPNOTSUPP;
+		goto cleanup;
+	}
+
+	if (!params.key || !params.key_size) {
+		rc = kmb_ecc_gen_privkey(tctx->curve, tctx->private_key);
+		goto cleanup;
+	}
+
+	rc = kmb_ecc_is_key_valid(tctx->curve, (const u64 *)params.key,
+				  params.key_size);
+	if (rc)
+		goto cleanup;
+
+	ecc_swap_digits((const u64 *)params.key, tctx->private_key,
+			tctx->curve->g.ndigits);
+cleanup:
+	memzero_explicit(&params, sizeof(params));
+
+	if (rc)
+		tctx->curve = NULL;
+
+	return rc;
+}
+
+/* Compute shared secret. */
+static int kmb_ecc_do_shared_secret(struct ocs_ecc_ctx *tctx,
+				    struct kpp_request *req)
+{
+	struct ocs_ecc_dev *ecc_dev = tctx->ecc_dev;
+	const struct ecc_curve *curve = tctx->curve;
+	u64 shared_secret[KMB_ECC_VLI_MAX_DIGITS];
+	u64 pubk_buf[KMB_ECC_VLI_MAX_DIGITS * 2];
+	size_t copied, nbytes, pubk_len;
+	struct ecc_point *pk, *result;
+	int rc;
+
+	nbytes = digits_to_bytes(curve->g.ndigits);
+
+	/* Public key is a point, thus it has two coordinates */
+	pubk_len = 2 * nbytes;
+
+	/* Copy public key from SG list to pubk_buf. */
+	copied = sg_copy_to_buffer(req->src,
+				   sg_nents_for_len(req->src, pubk_len),
+				   pubk_buf, pubk_len);
+	if (copied != pubk_len)
+		return -EINVAL;
+
+	/* Allocate and initialize public key point. */
+	pk = ecc_alloc_point(curve->g.ndigits);
+	if (!pk)
+		return -ENOMEM;
+
+	ecc_swap_digits(pubk_buf, pk->x, curve->g.ndigits);
+	ecc_swap_digits(&pubk_buf[curve->g.ndigits], pk->y, curve->g.ndigits);
+
+	/*
+	 * Check the public key for following
+	 * Check 1: Verify key is not the zero point.
+	 * Check 2: Verify key is in the range [1, p-1].
+	 * Check 3: Verify that y^2 == (x^3 + a·x + b) mod p
+	 */
+	rc = kmb_ocs_ecc_is_pubkey_valid_partial(tctx->ecc_dev, curve, pk);
+	if (rc)
+		goto exit_free_pk;
+
+	/* Allocate point for storing computed shared secret. */
+	result = ecc_alloc_point(pk->ndigits);
+	if (!result) {
+		rc = -ENOMEM;
+		goto exit_free_pk;
+	}
+
+	/* Calculate the shared secret.*/
+	rc = kmb_ecc_point_mult(ecc_dev, result, pk, tctx->private_key, curve);
+	if (rc)
+		goto exit_free_result;
+
+	if (ecc_point_is_zero(result)) {
+		rc = -EFAULT;
+		goto exit_free_result;
+	}
+
+	/* Copy shared secret from point to buffer. */
+	ecc_swap_digits(result->x, shared_secret, result->ndigits);
+
+	/* Request might ask for less bytes than what we have. */
+	nbytes = min_t(size_t, nbytes, req->dst_len);
+
+	copied = sg_copy_from_buffer(req->dst,
+				     sg_nents_for_len(req->dst, nbytes),
+				     shared_secret, nbytes);
+
+	if (copied != nbytes)
+		rc = -EINVAL;
+
+	memzero_explicit(shared_secret, sizeof(shared_secret));
+
+exit_free_result:
+	ecc_free_point(result);
+
+exit_free_pk:
+	ecc_free_point(pk);
+
+	if (rc)
+		return rc;
+
+	crypto_finalize_kpp_request(ecc_dev->engine, req, 0);
+
+	return 0;
+}
+
+/* Compute public key. */
+static int kmb_ecc_do_public_key(struct ocs_ecc_ctx *tctx,
+				 struct kpp_request *req)
+{
+	const struct ecc_curve *curve = tctx->curve;
+	u64 pubk_buf[KMB_ECC_VLI_MAX_DIGITS * 2];
+	struct ecc_point *pk;
+	size_t pubk_len;
+	size_t copied;
+	int rc;
+
+	/* Public key is a point, so it has double the digits. */
+	pubk_len = 2 * digits_to_bytes(curve->g.ndigits);
+
+	pk = ecc_alloc_point(curve->g.ndigits);
+	if (!pk)
+		return -ENOMEM;
+
+	/* Public Key(pk) = priv * G. */
+	rc = kmb_ecc_point_mult(tctx->ecc_dev, pk, &curve->g, tctx->private_key,
+				curve);
+	if (rc)
+		goto exit;
+
+	/* SP800-56A rev 3 5.6.2.1.3 key check */
+	if (kmb_ocs_ecc_is_pubkey_valid_full(tctx->ecc_dev, curve, pk)) {
+		rc = -EAGAIN;
+		goto exit;
+	}
+
+	/* Copy public key from point to buffer. */
+	ecc_swap_digits(pk->x, pubk_buf, pk->ndigits);
+	ecc_swap_digits(pk->y, &pubk_buf[pk->ndigits], pk->ndigits);
+
+	/* Copy public key to req->dst. */
+	copied = sg_copy_from_buffer(req->dst,
+				     sg_nents_for_len(req->dst, pubk_len),
+				     pubk_buf, pubk_len);
+
+	if (copied != pubk_len)
+		rc = -EINVAL;
+
+exit:
+	ecc_free_point(pk);
+
+	/* If there was an error, return. */
+	if (rc)
+		return rc;
+
+	/* Otherwise finalize request. */
+	crypto_finalize_kpp_request(tctx->ecc_dev->engine, req, 0);
+
+	return 0;
+}
+
+static int kmb_ocs_ecc_do_one_request(struct crypto_engine *engine,
+				      void *areq)
+{
+	struct kpp_request *req = container_of(areq, struct kpp_request, base);
+	struct ocs_ecc_ctx *tctx = kmb_ocs_ecc_tctx(req);
+
+	if (req->src)
+		return kmb_ecc_do_shared_secret(tctx, req);
+	else
+		return kmb_ecc_do_public_key(tctx, req);
+}
+
+static int kmb_ocs_ecdh_generate_public_key(struct kpp_request *req)
+{
+	struct ocs_ecc_ctx *tctx = kmb_ocs_ecc_tctx(req);
+	const struct ecc_curve *curve = tctx->curve;
+
+	/* Ensure kmb_ocs_ecdh_set_secret() has been successfully called. */
+	if (!tctx->curve)
+		return -EINVAL;
+
+	/* Ensure dst is present. */
+	if (!req->dst)
+		return -EINVAL;
+
+	/* Check the request dst is big enough to hold the public key. */
+	if (req->dst_len < (2 * digits_to_bytes(curve->g.ndigits)))
+		return -EINVAL;
+
+	/* 'src' is not supposed to be present when generate pubk is called. */
+	if (req->src)
+		return -EINVAL;
+
+	return crypto_transfer_kpp_request_to_engine(tctx->ecc_dev->engine,
+						     req);
+}
+
+static int kmb_ocs_ecdh_compute_shared_secret(struct kpp_request *req)
+{
+	struct ocs_ecc_ctx *tctx = kmb_ocs_ecc_tctx(req);
+	const struct ecc_curve *curve = tctx->curve;
+
+	/* Ensure kmb_ocs_ecdh_set_secret() has been successfully called. */
+	if (!tctx->curve)
+		return -EINVAL;
+
+	/* Ensure dst is present. */
+	if (!req->dst)
+		return -EINVAL;
+
+	/* Ensure src is present. */
+	if (!req->src)
+		return -EINVAL;
+
+	/*
+	 * req->src is expected to the (other-side) public key, so its length
+	 * must be 2 * coordinate size (in bytes).
+	 */
+	if (req->src_len != 2 * digits_to_bytes(curve->g.ndigits))
+		return -EINVAL;
+
+	return crypto_transfer_kpp_request_to_engine(tctx->ecc_dev->engine,
+						     req);
+}
+
+static int kmb_ocs_ecdh_init_tfm(struct crypto_kpp *tfm)
+{
+	struct ocs_ecc_ctx *tctx = kpp_tfm_ctx(tfm);
+
+	memset(tctx, 0, sizeof(*tctx));
+
+	tctx->ecc_dev = kmb_ocs_ecc_find_dev(tctx);
+
+	if (IS_ERR(tctx->ecc_dev)) {
+		pr_err("Failed to find the device : %ld\n",
+		       PTR_ERR(tctx->ecc_dev));
+		return PTR_ERR(tctx->ecc_dev);
+	}
+
+	tctx->engine_ctx.op.prepare_request = NULL;
+	tctx->engine_ctx.op.do_one_request = kmb_ocs_ecc_do_one_request;
+	tctx->engine_ctx.op.unprepare_request = NULL;
+
+	return 0;
+}
+
+static void kmb_ocs_ecdh_exit_tfm(struct crypto_kpp *tfm)
+{
+	struct ocs_ecc_ctx *tctx = kpp_tfm_ctx(tfm);
+
+	memzero_explicit(tctx->private_key, sizeof(*tctx->private_key));
+}
+
+static unsigned int kmb_ocs_ecdh_max_size(struct crypto_kpp *tfm)
+{
+	struct ocs_ecc_ctx *tctx = kpp_tfm_ctx(tfm);
+
+	/* Public key is made of two coordinates, so double the digits. */
+	return digits_to_bytes(tctx->curve->g.ndigits) * 2;
+}
+
+static struct kpp_alg ocs_ecc_algs = {
+	.set_secret = kmb_ocs_ecdh_set_secret,
+	.generate_public_key = kmb_ocs_ecdh_generate_public_key,
+	.compute_shared_secret = kmb_ocs_ecdh_compute_shared_secret,
+	.init = kmb_ocs_ecdh_init_tfm,
+	.exit = kmb_ocs_ecdh_exit_tfm,
+	.max_size = kmb_ocs_ecdh_max_size,
+	.base = {
+		.cra_name = "ecdh",
+		.cra_driver_name = "ecdh-keembay-ocs",
+		.cra_priority = KMB_OCS_ECC_PRIORITY,
+		.cra_module = THIS_MODULE,
+		.cra_ctxsize = sizeof(struct ocs_ecc_ctx),
+	},
+};
+
+static irqreturn_t ocs_ecc_irq_handler(int irq, void *dev_id)
+{
+	struct ocs_ecc_dev *ecc_dev = dev_id;
+	u32 status;
+
+	/*
+	 * Read the status register and write it back to clear the
+	 * DONE_INT_STATUS bit.
+	 */
+	status = ioread32(ecc_dev->base_reg + HW_OFFS_OCS_ECC_ISR);
+	iowrite32(status, ecc_dev->base_reg + HW_OFFS_OCS_ECC_ISR);
+
+	if (!(status & HW_OCS_ECC_ISR_INT_STATUS_DONE))
+		return IRQ_NONE;
+
+	complete(&ecc_dev->irq_done);
+
+	return IRQ_HANDLED;
+}
+
+static int kmb_ocs_ecc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ocs_ecc_dev *ecc_dev;
+	int rc;
+
+	ecc_dev = devm_kzalloc(dev, sizeof(*ecc_dev), GFP_KERNEL);
+	if (!ecc_dev)
+		return -ENOMEM;
+
+	ecc_dev->dev = dev;
+
+	platform_set_drvdata(pdev, ecc_dev);
+
+	INIT_LIST_HEAD(&ecc_dev->list);
+	init_completion(&ecc_dev->irq_done);
+
+	/* Get base register address. */
+	ecc_dev->base_reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ecc_dev->base_reg)) {
+		dev_err(dev, "Failed to get base address\n");
+		rc = PTR_ERR(ecc_dev->base_reg);
+		goto list_del;
+	}
+
+	/* Get and request IRQ */
+	ecc_dev->irq = platform_get_irq(pdev, 0);
+	if (ecc_dev->irq < 0) {
+		rc = ecc_dev->irq;
+		goto list_del;
+	}
+
+	rc = devm_request_threaded_irq(dev, ecc_dev->irq, ocs_ecc_irq_handler,
+				       NULL, 0, "keembay-ocs-ecc", ecc_dev);
+	if (rc < 0) {
+		dev_err(dev, "Could not request IRQ\n");
+		goto list_del;
+	}
+
+	/* Add device to the list of OCS ECC devices. */
+	spin_lock(&ocs_ecc.lock);
+	list_add_tail(&ecc_dev->list, &ocs_ecc.dev_list);
+	spin_unlock(&ocs_ecc.lock);
+
+	/* Initialize crypto engine. */
+	ecc_dev->engine = crypto_engine_alloc_init(dev, 1);
+	if (!ecc_dev->engine) {
+		dev_err(dev, "Could not allocate crypto engine\n");
+		goto list_del;
+	}
+
+	rc = crypto_engine_start(ecc_dev->engine);
+	if (rc) {
+		dev_err(dev, "Could not start crypto engine\n");
+		goto cleanup;
+	}
+
+	/* Register the KPP algo. */
+	rc = crypto_register_kpp(&ocs_ecc_algs);
+	if (rc) {
+		dev_err(dev,
+			"Could not register OCS algorithms with Crypto API\n");
+		goto cleanup;
+	}
+
+	return 0;
+
+cleanup:
+	crypto_engine_exit(ecc_dev->engine);
+
+list_del:
+	spin_lock(&ocs_ecc.lock);
+	list_del(&ecc_dev->list);
+	spin_unlock(&ocs_ecc.lock);
+
+	return rc;
+}
+
+static int kmb_ocs_ecc_remove(struct platform_device *pdev)
+{
+	struct ocs_ecc_dev *ecc_dev;
+
+	ecc_dev = platform_get_drvdata(pdev);
+	if (!ecc_dev)
+		return -ENODEV;
+
+	crypto_unregister_kpp(&ocs_ecc_algs);
+
+	spin_lock(&ocs_ecc.lock);
+	list_del(&ecc_dev->list);
+	spin_unlock(&ocs_ecc.lock);
+
+	crypto_engine_exit(ecc_dev->engine);
+
+	return 0;
+}
+
+/* Device tree driver match. */
+static const struct of_device_id kmb_ocs_ecc_of_match[] = {
+	{
+		.compatible = "intel,keembay-ocs-ecc",
+	},
+	{}
+};
+
+/* The OCS driver is a platform device. */
+static struct platform_driver kmb_ocs_ecc_driver = {
+	.probe = kmb_ocs_ecc_probe,
+	.remove = kmb_ocs_ecc_remove,
+	.driver = {
+			.name = DRV_NAME,
+			.of_match_table = kmb_ocs_ecc_of_match,
+		},
+};
+module_platform_driver(kmb_ocs_ecc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Intel Keem Bay OCS ECC Driver");
+MODULE_ALIAS_CRYPTO("ecdh");
+MODULE_ALIAS_CRYPTO("ecdh-keembay-ocs");
diff --git a/drivers/crypto/keembay/ocs-ecc-curve-defs.h b/drivers/crypto/keembay/ocs-ecc-curve-defs.h
new file mode 100644
index 000000000000..9e5273828559
--- /dev/null
+++ b/drivers/crypto/keembay/ocs-ecc-curve-defs.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Intel Keem Bay OCS ECC Curve Definitions.
+ *
+ * Copyright (C) 2019-2020 Intel Corporation
+ */
+#ifndef _CRYPTO_KEEMBAY_OCS_ECC_CURVE_DEFS_H
+#define _CRYPTO_KEEMBAY_OCS_ECC_CURVE_DEFS_H
+
+/* NIST P-256: a = p - 3 */
+static u64 nist_p256_g_x[] = { 0xF4A13945D898C296ull, 0x77037D812DEB33A0ull,
+				0xF8BCE6E563A440F2ull, 0x6B17D1F2E12C4247ull };
+static u64 nist_p256_g_y[] = { 0xCBB6406837BF51F5ull, 0x2BCE33576B315ECEull,
+				0x8EE7EB4A7C0F9E16ull, 0x4FE342E2FE1A7F9Bull };
+static u64 nist_p256_p[] = { 0xFFFFFFFFFFFFFFFFull, 0x00000000FFFFFFFFull,
+				0x0000000000000000ull, 0xFFFFFFFF00000001ull };
+static u64 nist_p256_n[] = { 0xF3B9CAC2FC632551ull, 0xBCE6FAADA7179E84ull,
+				0xFFFFFFFFFFFFFFFFull, 0xFFFFFFFF00000000ull };
+static u64 nist_p256_a[] = { 0xFFFFFFFFFFFFFFFCull, 0x00000000FFFFFFFFull,
+				0x0000000000000000ull, 0xFFFFFFFF00000001ull };
+static u64 nist_p256_b[] = { 0x3BCE3C3E27D2604Bull, 0x651D06B0CC53B0F6ull,
+				0xB3EBBD55769886BCull, 0x5AC635D8AA3A93E7ull };
+static struct ecc_curve nist_p256 = {
+	.name = "nist_256",
+	.g = {
+		.x = nist_p256_g_x,
+		.y = nist_p256_g_y,
+		.ndigits = 4,
+	},
+	.p = nist_p256_p,
+	.n = nist_p256_n,
+	.a = nist_p256_a,
+	.b = nist_p256_b
+};
+
+/* NIST P-384: a = p - 3 */
+static u64 nist_p384_g_x[] = { 0x3A545E3872760AB7ull, 0x5502F25DBF55296Cull,
+				0x59F741E082542A38ull, 0x6E1D3B628BA79B98ull,
+				0x8EB1C71EF320AD74ull, 0xAA87CA22BE8B0537ull };
+static u64 nist_p384_g_y[] = { 0x7A431D7C90EA0E5F, 0x0A60B1CE1D7E819Dull,
+				0xE9DA3113B5F0B8C0ull, 0xF8F41DBD289A147Cull,
+				0x5D9E98BF9292DC29ull, 0x3617DE4A96262C6Full };
+static u64 nist_p384_p[] = { 0x00000000FFFFFFFFull, 0xFFFFFFFF00000000ull,
+				0xFFFFFFFFFFFFFFFEull, 0xFFFFFFFFFFFFFFFFull,
+				0xFFFFFFFFFFFFFFFFull, 0xFFFFFFFFFFFFFFFFull };
+static u64 nist_p384_n[] = { 0xECEC196ACCC52973ull, 0x581A0DB248B0A77Aull,
+				0xC7634D81F4372DDFull, 0xFFFFFFFFFFFFFFFF,
+				0xFFFFFFFFFFFFFFFFull, 0xFFFFFFFFFFFFFFFFull};
+static u64 nist_p384_a[] = { 0x00000000FFFFFFFCull, 0xFFFFFFFF00000000ull,
+				0xFFFFFFFFFFFFFFFEull, 0xFFFFFFFFFFFFFFFFull,
+				0xFFFFFFFFFFFFFFFFull, 0xFFFFFFFFFFFFFFFFull};
+static u64 nist_p384_b[] = { 0x2A85C8EDD3EC2AEFull, 0xC656398D8A2ED19Dull,
+				0x0314088F5013875Aull, 0x181D9C6EFE814112ull,
+				0x988E056BE3F82D19ull, 0xB3312FA7E23EE7E4ull };
+static struct ecc_curve nist_p384 = {
+	.name = "nist_384",
+	.g = {
+		.x = nist_p384_g_x,
+		.y = nist_p384_g_y,
+		.ndigits = 6,
+	},
+	.p = nist_p384_p,
+	.n = nist_p384_n,
+	.a = nist_p384_a,
+	.b = nist_p384_b
+};
+
+#endif
-- 
2.26.2


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158092C5370
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Nov 2020 13:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbgKZL5i (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 26 Nov 2020 06:57:38 -0500
Received: from mga18.intel.com ([134.134.136.126]:7386 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388106AbgKZL5i (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 26 Nov 2020 06:57:38 -0500
IronPort-SDR: t2KdPGJCet48MDM1O5/A+RhpV8GXh7S3rxQVPZ5xIRkBrHc56kwwAt8sTRClV052nfxgmfmEjP
 79PjwLFGFXXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="160048315"
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="160048315"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 03:52:14 -0800
IronPort-SDR: +Bk6Tl9gPV3M8K6tdgLHHtMBS3ICRfWRceG+jj0ek22jesLmM2ACq1WwRWjYjcRDO9ivxlEsJZ
 CScZ6zwnuM4A==
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="362781615"
Received: from smaciag-mobl2.ger.corp.intel.com (HELO dalessan-mobl1.ir.intel.com) ([10.251.85.7])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 03:52:09 -0800
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Mark Gross <mgross@linux.intel.com>
Subject: [PATCH 2/2] crypto: keembay-ocs-aes: Add support for Keem Bay OCS AES/SM4
Date:   Thu, 26 Nov 2020 11:51:48 +0000
Message-Id: <20201126115148.68039-3-daniele.alessandrelli@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201126115148.68039-1-daniele.alessandrelli@linux.intel.com>
References: <20201126115148.68039-1-daniele.alessandrelli@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Mike Healy <mikex.healy@intel.com>

Add support for the AES/SM4 crypto engine included in the Offload and
Crypto Subsystem (OCS) of the Intel Keem Bay SoC, thus enabling
hardware-acceleration for the following transformations:

- ecb(aes), cbc(aes), ctr(aes), cts(cbc(aes)), gcm(aes) and cbc(aes);
  supported for 128-bit and 256-bit keys.

- ecb(sm4), cbc(sm4), ctr(sm4), cts(cbc(sm4)), gcm(sm4) and cbc(sm4);
  supported for 128-bit keys.

The driver passes crypto manager self-tests, including the extra tests
(CRYPTO_MANAGER_EXTRA_TESTS=y).

Signed-off-by: Mike Healy <mikex.healy@intel.com>
Co-developed-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Acked-by: Mark Gross <mgross@linux.intel.com>
---
 MAINTAINERS                                   |   10 +
 drivers/crypto/Kconfig                        |    2 +
 drivers/crypto/Makefile                       |    1 +
 drivers/crypto/keembay/Kconfig                |   39 +
 drivers/crypto/keembay/Makefile               |    5 +
 drivers/crypto/keembay/keembay-ocs-aes-core.c | 1713 +++++++++++++++++
 drivers/crypto/keembay/ocs-aes.c              | 1489 ++++++++++++++
 drivers/crypto/keembay/ocs-aes.h              |  129 ++
 8 files changed, 3388 insertions(+)
 create mode 100644 drivers/crypto/keembay/Kconfig
 create mode 100644 drivers/crypto/keembay/Makefile
 create mode 100644 drivers/crypto/keembay/keembay-ocs-aes-core.c
 create mode 100644 drivers/crypto/keembay/ocs-aes.c
 create mode 100644 drivers/crypto/keembay/ocs-aes.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 606f9d7ef19a..f5f6539ae3eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8863,6 +8863,16 @@ M:	Deepak Saxena <dsaxena@plexity.net>
 S:	Maintained
 F:	drivers/char/hw_random/ixp4xx-rng.c
 
+INTEL KEEM BAY OCS AES/SM4 CRYPTO DRIVER
+M:	Daniele Alessandrelli <daniele.alessandrelli@intel.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/crypto/intel,keembay-ocs-aes.yaml
+F:	drivers/crypto/keembay/Kconfig
+F:	drivers/crypto/keembay/Makefile
+F:	drivers/crypto/keembay/keembay-ocs-aes-core.c
+F:	drivers/crypto/keembay/ocs-aes.c
+F:	drivers/crypto/keembay/ocs-aes.h
+
 INTEL MANAGEMENT ENGINE (mei)
 M:	Tomas Winkler <tomas.winkler@intel.com>
 L:	linux-kernel@vger.kernel.org
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index c2950127def6..e636be70b18d 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -881,4 +881,6 @@ config CRYPTO_DEV_SA2UL
 	  used for crypto offload.  Select this if you want to use hardware
 	  acceleration for cryptographic algorithms on these devices.
 
+source "drivers/crypto/keembay/Kconfig"
+
 endif # CRYPTO_HW
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 53fc115cf459..fff9a70348e1 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -51,3 +51,4 @@ obj-$(CONFIG_CRYPTO_DEV_ARTPEC6) += axis/
 obj-$(CONFIG_CRYPTO_DEV_ZYNQMP_AES) += xilinx/
 obj-y += hisilicon/
 obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic/
+obj-y += keembay/
diff --git a/drivers/crypto/keembay/Kconfig b/drivers/crypto/keembay/Kconfig
new file mode 100644
index 000000000000..3c16797b25b9
--- /dev/null
+++ b/drivers/crypto/keembay/Kconfig
@@ -0,0 +1,39 @@
+config CRYPTO_DEV_KEEMBAY_OCS_AES_SM4
+	tristate "Support for Intel Keem Bay OCS AES/SM4 HW acceleration"
+	depends on OF || COMPILE_TEST
+	select CRYPTO_SKCIPHER
+	select CRYPTO_AEAD
+	select CRYPTO_ENGINE
+	help
+	  Support for Intel Keem Bay Offload and Crypto Subsystem (OCS) AES and
+	  SM4 cihper hardware acceleration for use with Crypto API.
+
+	  Provides HW acceleration for the following transformations:
+	  cbc(aes), ctr(aes), ccm(aes), gcm(aes), cbc(sm4), ctr(sm4), ccm(sm4)
+	  and gcm(sm4).
+
+	  Optionally, support for the following transformations can also be
+	  enabled: ecb(aes), cts(cbc(aes)), ecb(sm4) and cts(cbc(sm4)).
+
+config CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_ECB
+	bool "Support for Intel Keem Bay OCS AES/SM4 ECB HW acceleration"
+	depends on CRYPTO_DEV_KEEMBAY_OCS_AES_SM4
+	help
+	  Support for Intel Keem Bay Offload and Crypto Subsystem (OCS)
+	  AES/SM4 ECB mode hardware acceleration for use with Crypto API.
+
+	  Provides OCS version of ecb(aes) and ecb(sm4)
+
+	  Intel does not recommend use of ECB mode with AES/SM4.
+
+config CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_CTS
+	bool "Support for Intel Keem Bay OCS AES/SM4 CTS HW acceleration"
+	depends on CRYPTO_DEV_KEEMBAY_OCS_AES_SM4
+	help
+	  Support for Intel Keem Bay Offload and Crypto Subsystem (OCS)
+	  AES/SM4 CBC with CTS mode hardware acceleration for use with
+	  Crypto API.
+
+	  Provides OCS version of cts(cbc(aes)) and cts(cbc(sm4)).
+
+	  Intel does not recommend use of CTS mode with AES/SM4.
diff --git a/drivers/crypto/keembay/Makefile b/drivers/crypto/keembay/Makefile
new file mode 100644
index 000000000000..f21e2c4ab3b3
--- /dev/null
+++ b/drivers/crypto/keembay/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for Intel Keem Bay OCS Crypto API Linux drivers
+#
+obj-$(CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4) += keembay-ocs-aes.o
+keembay-ocs-aes-objs := keembay-ocs-aes-core.o ocs-aes.o
diff --git a/drivers/crypto/keembay/keembay-ocs-aes-core.c b/drivers/crypto/keembay/keembay-ocs-aes-core.c
new file mode 100644
index 000000000000..b6b25d994af3
--- /dev/null
+++ b/drivers/crypto/keembay/keembay-ocs-aes-core.c
@@ -0,0 +1,1713 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel Keem Bay OCS AES Crypto Driver.
+ *
+ * Copyright (C) 2018-2020 Intel Corporation
+ */
+
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/crypto.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+#include <crypto/aes.h>
+#include <crypto/engine.h>
+#include <crypto/gcm.h>
+#include <crypto/scatterwalk.h>
+
+#include <crypto/internal/aead.h>
+#include <crypto/internal/skcipher.h>
+
+#include "ocs-aes.h"
+
+#define KMB_OCS_PRIORITY	350
+#define DRV_NAME		"keembay-ocs-aes"
+
+#define OCS_AES_MIN_KEY_SIZE	16
+#define OCS_AES_MAX_KEY_SIZE	32
+#define OCS_AES_KEYSIZE_128	16
+#define OCS_AES_KEYSIZE_192	24
+#define OCS_AES_KEYSIZE_256	32
+#define OCS_SM4_KEY_SIZE	16
+
+/**
+ * struct ocs_aes_tctx - OCS AES Transform context
+ * @engine_ctx:		Engine context.
+ * @aes_dev:		The OCS AES device.
+ * @key:		AES/SM4 key.
+ * @key_len:		The length (in bytes) of @key.
+ * @cipher:		OCS cipher to use (either AES or SM4).
+ * @sw_cipher:		The cipher to use as fallback.
+ * @use_fallback:	Whether or not fallback cipher should be used.
+ */
+struct ocs_aes_tctx {
+	struct crypto_engine_ctx engine_ctx;
+	struct ocs_aes_dev *aes_dev;
+	u8 key[OCS_AES_KEYSIZE_256];
+	unsigned int key_len;
+	enum ocs_cipher cipher;
+	union {
+		struct crypto_sync_skcipher *sk;
+		struct crypto_aead *aead;
+	} sw_cipher;
+	bool use_fallback;
+};
+
+/**
+ * struct ocs_aes_rctx - OCS AES Request context.
+ * @instruction:	Instruction to be executed (encrypt / decrypt).
+ * @mode:		Mode to use (ECB, CBC, CTR, CCm, GCM, CTS)
+ * @src_nents:		Number of source SG entries.
+ * @dst_nents:		Number of destination SG entries.
+ * @src_dma_count:	The number of DMA-mapped entries of the source SG.
+ * @dst_dma_count:	The number of DMA-mapped entries of the destination SG.
+ * @in_place:		Whether or not this is an in place request, i.e.,
+ *			src_sg == dst_sg.
+ * @src_dll:		OCS DMA linked list for input data.
+ * @dst_dll:		OCS DMA linked list for output data.
+ * @last_ct_blk:	Buffer to hold last cipher text block (only used in CBC
+ *			mode).
+ * @cts_swap:		Whether or not CTS swap must be performed.
+ * @aad_src_dll:	OCS DMA linked list for input AAD data.
+ * @aad_dst_dll:	OCS DMA linked list for output AAD data.
+ * @in_tag:		Buffer to hold input encrypted tag (only used for
+ *			CCM/GCM decrypt).
+ * @out_tag:		Buffer to hold output encrypted / decrypted tag (only
+ *			used for GCM encrypt / decrypt).
+ */
+struct ocs_aes_rctx {
+	/* Fields common across all modes. */
+	enum ocs_instruction	instruction;
+	enum ocs_mode		mode;
+	int			src_nents;
+	int			dst_nents;
+	int			src_dma_count;
+	int			dst_dma_count;
+	bool			in_place;
+	struct ocs_dll_desc	src_dll;
+	struct ocs_dll_desc	dst_dll;
+
+	/* CBC specific */
+	u8			last_ct_blk[AES_BLOCK_SIZE];
+
+	/* CTS specific */
+	int			cts_swap;
+
+	/* CCM/GCM specific */
+	struct ocs_dll_desc	aad_src_dll;
+	struct ocs_dll_desc	aad_dst_dll;
+	u8			in_tag[AES_BLOCK_SIZE];
+
+	/* GCM specific */
+	u8			out_tag[AES_BLOCK_SIZE];
+};
+
+/* Driver data. */
+struct ocs_aes_drv {
+	struct list_head dev_list;
+	spinlock_t lock;	/* Protects dev_list. */
+};
+
+static struct ocs_aes_drv ocs_aes = {
+	.dev_list = LIST_HEAD_INIT(ocs_aes.dev_list),
+	.lock = __SPIN_LOCK_UNLOCKED(ocs_aes.lock),
+};
+
+static struct ocs_aes_dev *kmb_ocs_aes_find_dev(struct ocs_aes_tctx *tctx)
+{
+	struct ocs_aes_dev *aes_dev;
+
+	spin_lock(&ocs_aes.lock);
+
+	if (tctx->aes_dev) {
+		aes_dev = tctx->aes_dev;
+		goto exit;
+	}
+
+	/* Only a single OCS device available */
+	aes_dev = list_first_entry(&ocs_aes.dev_list, struct ocs_aes_dev, list);
+	tctx->aes_dev = aes_dev;
+
+exit:
+	spin_unlock(&ocs_aes.lock);
+
+	return aes_dev;
+}
+
+/*
+ * Ensure key is 128-bit or 256-bit for AES or 128-bit for SM4 and an actual
+ * key is being passed in.
+ *
+ * Return: 0 if key is valid, -EINVAL otherwise.
+ */
+static int check_key(const u8 *in_key, size_t key_len, enum ocs_cipher cipher)
+{
+	if (!in_key)
+		return -EINVAL;
+
+	/* For AES, only 128-byte or 256-byte keys are supported. */
+	if (cipher == OCS_AES && (key_len == OCS_AES_KEYSIZE_128 ||
+				  key_len == OCS_AES_KEYSIZE_256))
+		return 0;
+
+	/* For SM4, only 128-byte keys are supported. */
+	if (cipher == OCS_SM4 && key_len == OCS_AES_KEYSIZE_128)
+		return 0;
+
+	/* Everything else is unsupported. */
+	return -EINVAL;
+}
+
+/* Save key into transformation context. */
+static int save_key(struct ocs_aes_tctx *tctx, const u8 *in_key, size_t key_len,
+		    enum ocs_cipher cipher)
+{
+	int ret;
+
+	ret = check_key(in_key, key_len, cipher);
+	if (ret)
+		return ret;
+
+	memcpy(tctx->key, in_key, key_len);
+	tctx->key_len = key_len;
+	tctx->cipher = cipher;
+
+	return 0;
+}
+
+/* Set key for symmetric cypher. */
+static int kmb_ocs_sk_set_key(struct crypto_skcipher *tfm, const u8 *in_key,
+			      size_t key_len, enum ocs_cipher cipher)
+{
+	struct ocs_aes_tctx *tctx = crypto_skcipher_ctx(tfm);
+
+	/* Fallback is used for AES with 192-bit key. */
+	tctx->use_fallback = (cipher == OCS_AES &&
+			      key_len == OCS_AES_KEYSIZE_192);
+
+	if (!tctx->use_fallback)
+		return save_key(tctx, in_key, key_len, cipher);
+
+	crypto_sync_skcipher_clear_flags(tctx->sw_cipher.sk,
+					 CRYPTO_TFM_REQ_MASK);
+	crypto_sync_skcipher_set_flags(tctx->sw_cipher.sk,
+				       tfm->base.crt_flags &
+				       CRYPTO_TFM_REQ_MASK);
+
+	return crypto_sync_skcipher_setkey(tctx->sw_cipher.sk, in_key, key_len);
+}
+
+/* Set key for AEAD cipher. */
+static int kmb_ocs_aead_set_key(struct crypto_aead *tfm, const u8 *in_key,
+				size_t key_len, enum ocs_cipher cipher)
+{
+	struct ocs_aes_tctx *tctx = crypto_aead_ctx(tfm);
+
+	/* Fallback is used for AES with 192-bit key. */
+	tctx->use_fallback = (cipher == OCS_AES &&
+			      key_len == OCS_AES_KEYSIZE_192);
+
+	if (!tctx->use_fallback)
+		return save_key(tctx, in_key, key_len, cipher);
+
+	crypto_aead_clear_flags(tctx->sw_cipher.aead, CRYPTO_TFM_REQ_MASK);
+	crypto_aead_set_flags(tctx->sw_cipher.aead,
+			      crypto_aead_get_flags(tfm) & CRYPTO_TFM_REQ_MASK);
+
+	return crypto_aead_setkey(tctx->sw_cipher.aead, in_key, key_len);
+}
+
+/* Swap two AES blocks in SG lists. */
+static void sg_swap_blocks(struct scatterlist *sgl, unsigned int nents,
+			   off_t blk1_offset, off_t blk2_offset)
+{
+	u8 tmp_buf1[AES_BLOCK_SIZE], tmp_buf2[AES_BLOCK_SIZE];
+
+	/*
+	 * No easy way to copy within sg list, so copy both blocks to temporary
+	 * buffers first.
+	 */
+	sg_pcopy_to_buffer(sgl, nents, tmp_buf1, AES_BLOCK_SIZE, blk1_offset);
+	sg_pcopy_to_buffer(sgl, nents, tmp_buf2, AES_BLOCK_SIZE, blk2_offset);
+	sg_pcopy_from_buffer(sgl, nents, tmp_buf1, AES_BLOCK_SIZE, blk2_offset);
+	sg_pcopy_from_buffer(sgl, nents, tmp_buf2, AES_BLOCK_SIZE, blk1_offset);
+}
+
+/* Initialize request context to default values. */
+static void ocs_aes_init_rctx(struct ocs_aes_rctx *rctx)
+{
+	/* Zero everything. */
+	memset(rctx, 0, sizeof(*rctx));
+
+	/* Set initial value for DMA addresses. */
+	rctx->src_dll.dma_addr = DMA_MAPPING_ERROR;
+	rctx->dst_dll.dma_addr = DMA_MAPPING_ERROR;
+	rctx->aad_src_dll.dma_addr = DMA_MAPPING_ERROR;
+	rctx->aad_dst_dll.dma_addr = DMA_MAPPING_ERROR;
+}
+
+static int kmb_ocs_sk_validate_input(struct skcipher_request *req,
+				     enum ocs_mode mode)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	int iv_size = crypto_skcipher_ivsize(tfm);
+
+	switch (mode) {
+	case OCS_MODE_ECB:
+		/* Ensure input length is multiple of block size */
+		if (req->cryptlen % AES_BLOCK_SIZE != 0)
+			return -EINVAL;
+
+		return 0;
+
+	case OCS_MODE_CBC:
+		/* Ensure input length is multiple of block size */
+		if (req->cryptlen % AES_BLOCK_SIZE != 0)
+			return -EINVAL;
+
+		/* Ensure IV is present and block size in length */
+		if (!req->iv || iv_size != AES_BLOCK_SIZE)
+			return -EINVAL;
+		/*
+		 * NOTE: Since req->cryptlen == 0 case was already handled in
+		 * kmb_ocs_sk_common(), the above two conditions also guarantee
+		 * that: cryptlen >= iv_size
+		 */
+		return 0;
+
+	case OCS_MODE_CTR:
+		/* Ensure IV is present and block size in length */
+		if (!req->iv || iv_size != AES_BLOCK_SIZE)
+			return -EINVAL;
+		return 0;
+
+	case OCS_MODE_CTS:
+		/* Ensure input length >= block size */
+		if (req->cryptlen < AES_BLOCK_SIZE)
+			return -EINVAL;
+
+		/* Ensure IV is present and block size in length */
+		if (!req->iv || iv_size != AES_BLOCK_SIZE)
+			return -EINVAL;
+
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * Called by encrypt() / decrypt() skcipher functions.
+ *
+ * Use fallback if needed, otherwise initialize context and enqueue request
+ * into engine.
+ */
+static int kmb_ocs_sk_common(struct skcipher_request *req,
+			     enum ocs_cipher cipher,
+			     enum ocs_instruction instruction,
+			     enum ocs_mode mode)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct ocs_aes_rctx *rctx = skcipher_request_ctx(req);
+	struct ocs_aes_tctx *tctx = crypto_skcipher_ctx(tfm);
+	struct ocs_aes_dev *aes_dev;
+	int rc;
+
+	if (tctx->use_fallback) {
+		SYNC_SKCIPHER_REQUEST_ON_STACK(subreq, tctx->sw_cipher.sk);
+
+		skcipher_request_set_sync_tfm(subreq, tctx->sw_cipher.sk);
+		skcipher_request_set_callback(subreq, req->base.flags, NULL,
+					      NULL);
+		skcipher_request_set_crypt(subreq, req->src, req->dst,
+					   req->cryptlen, req->iv);
+
+		if (instruction == OCS_ENCRYPT)
+			rc = crypto_skcipher_encrypt(subreq);
+		else
+			rc = crypto_skcipher_decrypt(subreq);
+
+		skcipher_request_zero(subreq);
+
+		return rc;
+	}
+
+	/*
+	 * If cryptlen == 0, no processing needed for ECB, CBC and CTR.
+	 *
+	 * For CTS continue: kmb_ocs_sk_validate_input() will return -EINVAL.
+	 */
+	if (!req->cryptlen && mode != OCS_MODE_CTS)
+		return 0;
+
+	rc = kmb_ocs_sk_validate_input(req, mode);
+	if (rc)
+		return rc;
+
+	aes_dev = kmb_ocs_aes_find_dev(tctx);
+	if (!aes_dev)
+		return -ENODEV;
+
+	if (cipher != tctx->cipher)
+		return -EINVAL;
+
+	ocs_aes_init_rctx(rctx);
+	rctx->instruction = instruction;
+	rctx->mode = mode;
+
+	return crypto_transfer_skcipher_request_to_engine(aes_dev->engine, req);
+}
+
+static void cleanup_ocs_dma_linked_list(struct device *dev,
+					struct ocs_dll_desc *dll)
+{
+	if (dll->vaddr)
+		dma_free_coherent(dev, dll->size, dll->vaddr, dll->dma_addr);
+	dll->vaddr = NULL;
+	dll->size = 0;
+	dll->dma_addr = DMA_MAPPING_ERROR;
+}
+
+static void kmb_ocs_sk_dma_cleanup(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct ocs_aes_rctx *rctx = skcipher_request_ctx(req);
+	struct ocs_aes_tctx *tctx = crypto_skcipher_ctx(tfm);
+	struct device *dev = tctx->aes_dev->dev;
+
+	if (rctx->src_dma_count) {
+		dma_unmap_sg(dev, req->src, rctx->src_nents, DMA_TO_DEVICE);
+		rctx->src_dma_count = 0;
+	}
+
+	if (rctx->dst_dma_count) {
+		dma_unmap_sg(dev, req->dst, rctx->dst_nents, rctx->in_place ?
+							     DMA_BIDIRECTIONAL :
+							     DMA_FROM_DEVICE);
+		rctx->dst_dma_count = 0;
+	}
+
+	/* Clean up OCS DMA linked lists */
+	cleanup_ocs_dma_linked_list(dev, &rctx->src_dll);
+	cleanup_ocs_dma_linked_list(dev, &rctx->dst_dll);
+}
+
+static int kmb_ocs_sk_prepare_inplace(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct ocs_aes_rctx *rctx = skcipher_request_ctx(req);
+	struct ocs_aes_tctx *tctx = crypto_skcipher_ctx(tfm);
+	int iv_size = crypto_skcipher_ivsize(tfm);
+	int rc;
+
+	/*
+	 * For CBC decrypt, save last block (iv) to last_ct_blk buffer.
+	 *
+	 * Note: if we are here, we already checked that cryptlen >= iv_size
+	 * and iv_size == AES_BLOCK_SIZE (i.e., the size of last_ct_blk); see
+	 * kmb_ocs_sk_validate_input().
+	 */
+	if (rctx->mode == OCS_MODE_CBC && rctx->instruction == OCS_DECRYPT)
+		scatterwalk_map_and_copy(rctx->last_ct_blk, req->src,
+					 req->cryptlen - iv_size, iv_size, 0);
+
+	/* For CTS decrypt, swap last two blocks, if needed. */
+	if (rctx->cts_swap && rctx->instruction == OCS_DECRYPT)
+		sg_swap_blocks(req->dst, rctx->dst_nents,
+			       req->cryptlen - AES_BLOCK_SIZE,
+			       req->cryptlen - (2 * AES_BLOCK_SIZE));
+
+	/* src and dst buffers are the same, use bidirectional DMA mapping. */
+	rctx->dst_dma_count = dma_map_sg(tctx->aes_dev->dev, req->dst,
+					 rctx->dst_nents, DMA_BIDIRECTIONAL);
+	if (rctx->dst_dma_count == 0) {
+		dev_err(tctx->aes_dev->dev, "Failed to map destination sg\n");
+		return -ENOMEM;
+	}
+
+	/* Create DST linked list */
+	rc = ocs_create_linked_list_from_sg(tctx->aes_dev, req->dst,
+					    rctx->dst_dma_count, &rctx->dst_dll,
+					    req->cryptlen, 0);
+	if (rc)
+		return rc;
+	/*
+	 * If descriptor creation was successful, set the src_dll.dma_addr to
+	 * the value of dst_dll.dma_addr, as we do in-place AES operation on
+	 * the src.
+	 */
+	rctx->src_dll.dma_addr = rctx->dst_dll.dma_addr;
+
+	return 0;
+}
+
+static int kmb_ocs_sk_prepare_notinplace(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct ocs_aes_rctx *rctx = skcipher_request_ctx(req);
+	struct ocs_aes_tctx *tctx = crypto_skcipher_ctx(tfm);
+	int rc;
+
+	rctx->src_nents =  sg_nents_for_len(req->src, req->cryptlen);
+	if (rctx->src_nents < 0)
+		return -EBADMSG;
+
+	/* Map SRC SG. */
+	rctx->src_dma_count = dma_map_sg(tctx->aes_dev->dev, req->src,
+					 rctx->src_nents, DMA_TO_DEVICE);
+	if (rctx->src_dma_count == 0) {
+		dev_err(tctx->aes_dev->dev, "Failed to map source sg\n");
+		return -ENOMEM;
+	}
+
+	/* Create SRC linked list */
+	rc = ocs_create_linked_list_from_sg(tctx->aes_dev, req->src,
+					    rctx->src_dma_count, &rctx->src_dll,
+					    req->cryptlen, 0);
+	if (rc)
+		return rc;
+
+	/* Map DST SG. */
+	rctx->dst_dma_count = dma_map_sg(tctx->aes_dev->dev, req->dst,
+					 rctx->dst_nents, DMA_FROM_DEVICE);
+	if (rctx->dst_dma_count == 0) {
+		dev_err(tctx->aes_dev->dev, "Failed to map destination sg\n");
+		return -ENOMEM;
+	}
+
+	/* Create DST linked list */
+	rc = ocs_create_linked_list_from_sg(tctx->aes_dev, req->dst,
+					    rctx->dst_dma_count, &rctx->dst_dll,
+					    req->cryptlen, 0);
+	if (rc)
+		return rc;
+
+	/* If this is not a CTS decrypt operation with swapping, we are done. */
+	if (!(rctx->cts_swap && rctx->instruction == OCS_DECRYPT))
+		return 0;
+
+	/*
+	 * Otherwise, we have to copy src to dst (as we cannot modify src).
+	 * Use OCS AES bypass mode to copy src to dst via DMA.
+	 *
+	 * NOTE: for anything other than small data sizes this is rather
+	 * inefficient.
+	 */
+	rc = ocs_aes_bypass_op(tctx->aes_dev, rctx->dst_dll.dma_addr,
+			       rctx->src_dll.dma_addr, req->cryptlen);
+	if (rc)
+		return rc;
+
+	/*
+	 * Now dst == src, so clean up what we did so far and use in_place
+	 * logic.
+	 */
+	kmb_ocs_sk_dma_cleanup(req);
+	rctx->in_place = true;
+
+	return kmb_ocs_sk_prepare_inplace(req);
+}
+
+static int kmb_ocs_sk_run(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct ocs_aes_rctx *rctx = skcipher_request_ctx(req);
+	struct ocs_aes_tctx *tctx = crypto_skcipher_ctx(tfm);
+	struct ocs_aes_dev *aes_dev = tctx->aes_dev;
+	int iv_size = crypto_skcipher_ivsize(tfm);
+	int rc;
+
+	rctx->dst_nents = sg_nents_for_len(req->dst, req->cryptlen);
+	if (rctx->dst_nents < 0)
+		return -EBADMSG;
+
+	/*
+	 * If 2 blocks or greater, and multiple of block size swap last two
+	 * blocks to be compatible with other crypto API CTS implementations:
+	 * OCS mode uses CBC-CS2, whereas other crypto API implementations use
+	 * CBC-CS3.
+	 * CBC-CS2 and CBC-CS3 defined by:
+	 * https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-38a-add.pdf
+	 */
+	rctx->cts_swap = (rctx->mode == OCS_MODE_CTS &&
+			  req->cryptlen > AES_BLOCK_SIZE &&
+			  req->cryptlen % AES_BLOCK_SIZE == 0);
+
+	rctx->in_place = (req->src == req->dst);
+
+	if (rctx->in_place)
+		rc = kmb_ocs_sk_prepare_inplace(req);
+	else
+		rc = kmb_ocs_sk_prepare_notinplace(req);
+
+	if (rc)
+		goto error;
+
+	rc = ocs_aes_op(aes_dev, rctx->mode, tctx->cipher, rctx->instruction,
+			rctx->dst_dll.dma_addr, rctx->src_dll.dma_addr,
+			req->cryptlen, req->iv, iv_size);
+	if (rc)
+		goto error;
+
+	/* Clean-up DMA before further processing output. */
+	kmb_ocs_sk_dma_cleanup(req);
+
+	/* For CTS Encrypt, swap last 2 blocks, if needed. */
+	if (rctx->cts_swap && rctx->instruction == OCS_ENCRYPT) {
+		sg_swap_blocks(req->dst, rctx->dst_nents,
+			       req->cryptlen - AES_BLOCK_SIZE,
+			       req->cryptlen - (2 * AES_BLOCK_SIZE));
+		return 0;
+	}
+
+	/* For CBC copy IV to req->IV. */
+	if (rctx->mode == OCS_MODE_CBC) {
+		/* CBC encrypt case. */
+		if (rctx->instruction == OCS_ENCRYPT) {
+			scatterwalk_map_and_copy(req->iv, req->dst,
+						 req->cryptlen - iv_size,
+						 iv_size, 0);
+			return 0;
+		}
+		/* CBC decrypt case. */
+		if (rctx->in_place)
+			memcpy(req->iv, rctx->last_ct_blk, iv_size);
+		else
+			scatterwalk_map_and_copy(req->iv, req->src,
+						 req->cryptlen - iv_size,
+						 iv_size, 0);
+		return 0;
+	}
+	/* For all other modes there's nothing to do. */
+
+	return 0;
+
+error:
+	kmb_ocs_sk_dma_cleanup(req);
+
+	return rc;
+}
+
+static int kmb_ocs_aead_validate_input(struct aead_request *req,
+				       enum ocs_instruction instruction,
+				       enum ocs_mode mode)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	int tag_size = crypto_aead_authsize(tfm);
+	int iv_size = crypto_aead_ivsize(tfm);
+
+	/* For decrypt crytplen == len(PT) + len(tag). */
+	if (instruction == OCS_DECRYPT && req->cryptlen < tag_size)
+		return -EINVAL;
+
+	/* IV is mandatory. */
+	if (!req->iv)
+		return -EINVAL;
+
+	switch (mode) {
+	case OCS_MODE_GCM:
+		if (iv_size != GCM_AES_IV_SIZE)
+			return -EINVAL;
+
+		return 0;
+
+	case OCS_MODE_CCM:
+		/* Ensure IV is present and block size in length */
+		if (iv_size != AES_BLOCK_SIZE)
+			return -EINVAL;
+
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * Called by encrypt() / decrypt() aead functions.
+ *
+ * Use fallback if needed, otherwise initialize context and enqueue request
+ * into engine.
+ */
+static int kmb_ocs_aead_common(struct aead_request *req,
+			       enum ocs_cipher cipher,
+			       enum ocs_instruction instruction,
+			       enum ocs_mode mode)
+{
+	struct ocs_aes_tctx *tctx = crypto_aead_ctx(crypto_aead_reqtfm(req));
+	struct ocs_aes_rctx *rctx = aead_request_ctx(req);
+	struct ocs_aes_dev *dd;
+	int rc;
+
+	if (tctx->use_fallback) {
+		struct aead_request *subreq = aead_request_ctx(req);
+
+		aead_request_set_tfm(subreq, tctx->sw_cipher.aead);
+		aead_request_set_callback(subreq, req->base.flags,
+					  req->base.complete, req->base.data);
+		aead_request_set_crypt(subreq, req->src, req->dst,
+				       req->cryptlen, req->iv);
+		aead_request_set_ad(subreq, req->assoclen);
+		rc = crypto_aead_setauthsize(tctx->sw_cipher.aead,
+					     crypto_aead_authsize(crypto_aead_reqtfm(req)));
+		if (rc)
+			return rc;
+
+		return (instruction == OCS_ENCRYPT) ?
+		       crypto_aead_encrypt(subreq) :
+		       crypto_aead_decrypt(subreq);
+	}
+
+	rc = kmb_ocs_aead_validate_input(req, instruction, mode);
+	if (rc)
+		return rc;
+
+	dd = kmb_ocs_aes_find_dev(tctx);
+	if (!dd)
+		return -ENODEV;
+
+	if (cipher != tctx->cipher)
+		return -EINVAL;
+
+	ocs_aes_init_rctx(rctx);
+	rctx->instruction = instruction;
+	rctx->mode = mode;
+
+	return crypto_transfer_aead_request_to_engine(dd->engine, req);
+}
+
+static void kmb_ocs_aead_dma_cleanup(struct aead_request *req)
+{
+	struct ocs_aes_tctx *tctx = crypto_aead_ctx(crypto_aead_reqtfm(req));
+	struct ocs_aes_rctx *rctx = aead_request_ctx(req);
+	struct device *dev = tctx->aes_dev->dev;
+
+	if (rctx->src_dma_count) {
+		dma_unmap_sg(dev, req->src, rctx->src_nents, DMA_TO_DEVICE);
+		rctx->src_dma_count = 0;
+	}
+
+	if (rctx->dst_dma_count) {
+		dma_unmap_sg(dev, req->dst, rctx->dst_nents, rctx->in_place ?
+							     DMA_BIDIRECTIONAL :
+							     DMA_FROM_DEVICE);
+		rctx->dst_dma_count = 0;
+	}
+	/* Clean up OCS DMA linked lists */
+	cleanup_ocs_dma_linked_list(dev, &rctx->src_dll);
+	cleanup_ocs_dma_linked_list(dev, &rctx->dst_dll);
+	cleanup_ocs_dma_linked_list(dev, &rctx->aad_src_dll);
+	cleanup_ocs_dma_linked_list(dev, &rctx->aad_dst_dll);
+}
+
+/**
+ * kmb_ocs_aead_dma_prepare() - Do DMA mapping for AEAD processing.
+ * @req:		The AEAD request being processed.
+ * @src_dll_size:	Where to store the length of the data mapped into the
+ *			src_dll OCS DMA list.
+ *
+ * Do the following:
+ * - DMA map req->src and req->dst
+ * - Initialize the following OCS DMA linked lists: rctx->src_dll,
+ *   rctx->dst_dll, rctx->aad_src_dll and rxtc->aad_dst_dll.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+static int kmb_ocs_aead_dma_prepare(struct aead_request *req, u32 *src_dll_size)
+{
+	struct ocs_aes_tctx *tctx = crypto_aead_ctx(crypto_aead_reqtfm(req));
+	const int tag_size = crypto_aead_authsize(crypto_aead_reqtfm(req));
+	struct ocs_aes_rctx *rctx = aead_request_ctx(req);
+	u32 in_size;	/* The length of the data to be mapped by src_dll. */
+	u32 out_size;	/* The length of the data to be mapped by dst_dll. */
+	u32 dst_size;	/* The length of the data in dst_sg. */
+	int rc;
+
+	/* Get number of entries in input data SG list. */
+	rctx->src_nents = sg_nents_for_len(req->src,
+					   req->assoclen + req->cryptlen);
+	if (rctx->src_nents < 0)
+		return -EBADMSG;
+
+	if (rctx->instruction == OCS_DECRYPT) {
+		/*
+		 * For decrypt:
+		 * - src sg list is:		AAD|CT|tag
+		 * - dst sg list expects:	AAD|PT
+		 *
+		 * in_size == len(CT); out_size == len(PT)
+		 */
+
+		/* req->cryptlen includes both CT and tag. */
+		in_size = req->cryptlen - tag_size;
+
+		/* out_size = PT size == CT size */
+		out_size = in_size;
+
+		/* len(dst_sg) == len(AAD) + len(PT) */
+		dst_size = req->assoclen + out_size;
+
+		/*
+		 * Copy tag from source SG list to 'in_tag' buffer.
+		 *
+		 * Note: this needs to be done here, before DMA mapping src_sg.
+		 */
+		sg_pcopy_to_buffer(req->src, rctx->src_nents, rctx->in_tag,
+				   tag_size, req->assoclen + in_size);
+
+	} else { /* OCS_ENCRYPT */
+		/*
+		 * For encrypt:
+		 *	src sg list is:		AAD|PT
+		 *	dst sg list expects:	AAD|CT|tag
+		 */
+		/* in_size == len(PT) */
+		in_size = req->cryptlen;
+
+		/*
+		 * In CCM mode the OCS engine appends the tag to the ciphertext,
+		 * but in GCM mode the tag must be read from the tag registers
+		 * and appended manually below
+		 */
+		out_size = (rctx->mode == OCS_MODE_CCM) ? in_size + tag_size :
+							  in_size;
+		/* len(dst_sg) == len(AAD) + len(CT) + len(tag) */
+		dst_size = req->assoclen + in_size + tag_size;
+	}
+	*src_dll_size = in_size;
+
+	/* Get number of entries in output data SG list. */
+	rctx->dst_nents = sg_nents_for_len(req->dst, dst_size);
+	if (rctx->dst_nents < 0)
+		return -EBADMSG;
+
+	rctx->in_place = (req->src == req->dst) ? 1 : 0;
+
+	/* Map destination; use bidirectional mapping for in-place case. */
+	rctx->dst_dma_count = dma_map_sg(tctx->aes_dev->dev, req->dst,
+					 rctx->dst_nents,
+					 rctx->in_place ? DMA_BIDIRECTIONAL :
+							  DMA_FROM_DEVICE);
+	if (rctx->dst_dma_count == 0 && rctx->dst_nents != 0) {
+		dev_err(tctx->aes_dev->dev, "Failed to map destination sg\n");
+		return -ENOMEM;
+	}
+
+	/* Create AAD DST list: maps dst[0:AAD_SIZE-1]. */
+	rc = ocs_create_linked_list_from_sg(tctx->aes_dev, req->dst,
+					    rctx->dst_dma_count,
+					    &rctx->aad_dst_dll, req->assoclen,
+					    0);
+	if (rc)
+		return rc;
+
+	/* Create DST list: maps dst[AAD_SIZE:out_size] */
+	rc = ocs_create_linked_list_from_sg(tctx->aes_dev, req->dst,
+					    rctx->dst_dma_count, &rctx->dst_dll,
+					    out_size, req->assoclen);
+	if (rc)
+		return rc;
+
+	if (rctx->in_place) {
+		/* If this is not CCM encrypt, we are done. */
+		if (!(rctx->mode == OCS_MODE_CCM &&
+		      rctx->instruction == OCS_ENCRYPT)) {
+			/*
+			 * SRC and DST are the same, so re-use the same DMA
+			 * addresses (to avoid allocating new DMA lists
+			 * identical to the dst ones).
+			 */
+			rctx->src_dll.dma_addr = rctx->dst_dll.dma_addr;
+			rctx->aad_src_dll.dma_addr = rctx->aad_dst_dll.dma_addr;
+
+			return 0;
+		}
+		/*
+		 * For CCM encrypt the input and output linked lists contain
+		 * different amounts of data, so, we need to create different
+		 * SRC and AAD SRC lists, even for the in-place case.
+		 */
+		rc = ocs_create_linked_list_from_sg(tctx->aes_dev, req->dst,
+						    rctx->dst_dma_count,
+						    &rctx->aad_src_dll,
+						    req->assoclen, 0);
+		if (rc)
+			return rc;
+		rc = ocs_create_linked_list_from_sg(tctx->aes_dev, req->dst,
+						    rctx->dst_dma_count,
+						    &rctx->src_dll, in_size,
+						    req->assoclen);
+		if (rc)
+			return rc;
+
+		return 0;
+	}
+	/* Not in-place case. */
+
+	/* Map source SG. */
+	rctx->src_dma_count = dma_map_sg(tctx->aes_dev->dev, req->src,
+					 rctx->src_nents, DMA_TO_DEVICE);
+	if (rctx->src_dma_count == 0 && rctx->src_nents != 0) {
+		dev_err(tctx->aes_dev->dev, "Failed to map source sg\n");
+		return -ENOMEM;
+	}
+
+	/* Create AAD SRC list. */
+	rc = ocs_create_linked_list_from_sg(tctx->aes_dev, req->src,
+					    rctx->src_dma_count,
+					    &rctx->aad_src_dll,
+					    req->assoclen, 0);
+	if (rc)
+		return rc;
+
+	/* Create SRC list. */
+	rc = ocs_create_linked_list_from_sg(tctx->aes_dev, req->src,
+					    rctx->src_dma_count,
+					    &rctx->src_dll, in_size,
+					    req->assoclen);
+	if (rc)
+		return rc;
+
+	if (req->assoclen == 0)
+		return 0;
+
+	/* Copy AAD from src sg to dst sg using OCS DMA. */
+	rc = ocs_aes_bypass_op(tctx->aes_dev, rctx->aad_dst_dll.dma_addr,
+			       rctx->aad_src_dll.dma_addr, req->cryptlen);
+	if (rc)
+		dev_err(tctx->aes_dev->dev,
+			"Failed to copy source AAD to destination AAD\n");
+
+	return rc;
+}
+
+static int kmb_ocs_aead_run(struct aead_request *req)
+{
+	struct ocs_aes_tctx *tctx = crypto_aead_ctx(crypto_aead_reqtfm(req));
+	const int tag_size = crypto_aead_authsize(crypto_aead_reqtfm(req));
+	struct ocs_aes_rctx *rctx = aead_request_ctx(req);
+	u32 in_size;	/* The length of the data mapped by src_dll. */
+	int rc;
+
+	rc = kmb_ocs_aead_dma_prepare(req, &in_size);
+	if (rc)
+		goto exit;
+
+	/* For CCM, we just call the OCS processing and we are done. */
+	if (rctx->mode == OCS_MODE_CCM) {
+		rc = ocs_aes_ccm_op(tctx->aes_dev, tctx->cipher,
+				    rctx->instruction, rctx->dst_dll.dma_addr,
+				    rctx->src_dll.dma_addr, in_size,
+				    req->iv,
+				    rctx->aad_src_dll.dma_addr, req->assoclen,
+				    rctx->in_tag, tag_size);
+		goto exit;
+	}
+	/* GCM case; invoke OCS processing. */
+	rc = ocs_aes_gcm_op(tctx->aes_dev, tctx->cipher,
+			    rctx->instruction,
+			    rctx->dst_dll.dma_addr,
+			    rctx->src_dll.dma_addr, in_size,
+			    req->iv,
+			    rctx->aad_src_dll.dma_addr, req->assoclen,
+			    rctx->out_tag, tag_size);
+	if (rc)
+		goto exit;
+
+	/* For GCM decrypt, we have to compare in_tag with out_tag. */
+	if (rctx->instruction == OCS_DECRYPT) {
+		rc = memcmp(rctx->in_tag, rctx->out_tag, tag_size) ?
+		     -EBADMSG : 0;
+		goto exit;
+	}
+
+	/* For GCM encrypt, we must manually copy out_tag to DST sg. */
+
+	/* Clean-up must be called before the sg_pcopy_from_buffer() below. */
+	kmb_ocs_aead_dma_cleanup(req);
+
+	/* Copy tag to destination sg after AAD and CT. */
+	sg_pcopy_from_buffer(req->dst, rctx->dst_nents, rctx->out_tag,
+			     tag_size, req->assoclen + req->cryptlen);
+
+	/* Return directly as DMA cleanup already done. */
+	return 0;
+
+exit:
+	kmb_ocs_aead_dma_cleanup(req);
+
+	return rc;
+}
+
+static int kmb_ocs_aes_sk_do_one_request(struct crypto_engine *engine,
+					 void *areq)
+{
+	struct skcipher_request *req =
+			container_of(areq, struct skcipher_request, base);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct ocs_aes_tctx *tctx = crypto_skcipher_ctx(tfm);
+	int err;
+
+	if (!tctx->aes_dev) {
+		err = -ENODEV;
+		goto exit;
+	}
+
+	err = ocs_aes_set_key(tctx->aes_dev, tctx->key_len, tctx->key,
+			      tctx->cipher);
+	if (err)
+		goto exit;
+
+	err = kmb_ocs_sk_run(req);
+
+exit:
+	crypto_finalize_skcipher_request(engine, req, err);
+
+	return 0;
+}
+
+static int kmb_ocs_aes_aead_do_one_request(struct crypto_engine *engine,
+					   void *areq)
+{
+	struct aead_request *req = container_of(areq,
+						struct aead_request, base);
+	struct ocs_aes_tctx *tctx = crypto_aead_ctx(crypto_aead_reqtfm(req));
+	int err;
+
+	if (!tctx->aes_dev)
+		return -ENODEV;
+
+	err = ocs_aes_set_key(tctx->aes_dev, tctx->key_len, tctx->key,
+			      tctx->cipher);
+	if (err)
+		goto exit;
+
+	err = kmb_ocs_aead_run(req);
+
+exit:
+	crypto_finalize_aead_request(tctx->aes_dev->engine, req, err);
+
+	return 0;
+}
+
+static int kmb_ocs_aes_set_key(struct crypto_skcipher *tfm, const u8 *in_key,
+			       unsigned int key_len)
+{
+	return kmb_ocs_sk_set_key(tfm, in_key, key_len, OCS_AES);
+}
+
+static int kmb_ocs_aes_aead_set_key(struct crypto_aead *tfm, const u8 *in_key,
+				    unsigned int key_len)
+{
+	return kmb_ocs_aead_set_key(tfm, in_key, key_len, OCS_AES);
+}
+
+#ifdef CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_ECB
+static int kmb_ocs_aes_ecb_encrypt(struct skcipher_request *req)
+{
+	return kmb_ocs_sk_common(req, OCS_AES, OCS_ENCRYPT, OCS_MODE_ECB);
+}
+
+static int kmb_ocs_aes_ecb_decrypt(struct skcipher_request *req)
+{
+	return kmb_ocs_sk_common(req, OCS_AES, OCS_DECRYPT, OCS_MODE_ECB);
+}
+#endif /* CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_ECB */
+
+static int kmb_ocs_aes_cbc_encrypt(struct skcipher_request *req)
+{
+	return kmb_ocs_sk_common(req, OCS_AES, OCS_ENCRYPT, OCS_MODE_CBC);
+}
+
+static int kmb_ocs_aes_cbc_decrypt(struct skcipher_request *req)
+{
+	return kmb_ocs_sk_common(req, OCS_AES, OCS_DECRYPT, OCS_MODE_CBC);
+}
+
+static int kmb_ocs_aes_ctr_encrypt(struct skcipher_request *req)
+{
+	return kmb_ocs_sk_common(req, OCS_AES, OCS_ENCRYPT, OCS_MODE_CTR);
+}
+
+static int kmb_ocs_aes_ctr_decrypt(struct skcipher_request *req)
+{
+	return kmb_ocs_sk_common(req, OCS_AES, OCS_DECRYPT, OCS_MODE_CTR);
+}
+
+#ifdef CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_CTS
+static int kmb_ocs_aes_cts_encrypt(struct skcipher_request *req)
+{
+	return kmb_ocs_sk_common(req, OCS_AES, OCS_ENCRYPT, OCS_MODE_CTS);
+}
+
+static int kmb_ocs_aes_cts_decrypt(struct skcipher_request *req)
+{
+	return kmb_ocs_sk_common(req, OCS_AES, OCS_DECRYPT, OCS_MODE_CTS);
+}
+#endif /* CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_CTS */
+
+static int kmb_ocs_aes_gcm_encrypt(struct aead_request *req)
+{
+	return kmb_ocs_aead_common(req, OCS_AES, OCS_ENCRYPT, OCS_MODE_GCM);
+}
+
+static int kmb_ocs_aes_gcm_decrypt(struct aead_request *req)
+{
+	return kmb_ocs_aead_common(req, OCS_AES, OCS_DECRYPT, OCS_MODE_GCM);
+}
+
+static int kmb_ocs_aes_ccm_encrypt(struct aead_request *req)
+{
+	return kmb_ocs_aead_common(req, OCS_AES, OCS_ENCRYPT, OCS_MODE_CCM);
+}
+
+static int kmb_ocs_aes_ccm_decrypt(struct aead_request *req)
+{
+	return kmb_ocs_aead_common(req, OCS_AES, OCS_DECRYPT, OCS_MODE_CCM);
+}
+
+static int kmb_ocs_sm4_set_key(struct crypto_skcipher *tfm, const u8 *in_key,
+			       unsigned int key_len)
+{
+	return kmb_ocs_sk_set_key(tfm, in_key, key_len, OCS_SM4);
+}
+
+static int kmb_ocs_sm4_aead_set_key(struct crypto_aead *tfm, const u8 *in_key,
+				    unsigned int key_len)
+{
+	return kmb_ocs_aead_set_key(tfm, in_key, key_len, OCS_SM4);
+}
+
+#ifdef CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_ECB
+static int kmb_ocs_sm4_ecb_encrypt(struct skcipher_request *req)
+{
+	return kmb_ocs_sk_common(req, OCS_SM4, OCS_ENCRYPT, OCS_MODE_ECB);
+}
+
+static int kmb_ocs_sm4_ecb_decrypt(struct skcipher_request *req)
+{
+	return kmb_ocs_sk_common(req, OCS_SM4, OCS_DECRYPT, OCS_MODE_ECB);
+}
+#endif /* CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_ECB */
+
+static int kmb_ocs_sm4_cbc_encrypt(struct skcipher_request *req)
+{
+	return kmb_ocs_sk_common(req, OCS_SM4, OCS_ENCRYPT, OCS_MODE_CBC);
+}
+
+static int kmb_ocs_sm4_cbc_decrypt(struct skcipher_request *req)
+{
+	return kmb_ocs_sk_common(req, OCS_SM4, OCS_DECRYPT, OCS_MODE_CBC);
+}
+
+static int kmb_ocs_sm4_ctr_encrypt(struct skcipher_request *req)
+{
+	return kmb_ocs_sk_common(req, OCS_SM4, OCS_ENCRYPT, OCS_MODE_CTR);
+}
+
+static int kmb_ocs_sm4_ctr_decrypt(struct skcipher_request *req)
+{
+	return kmb_ocs_sk_common(req, OCS_SM4, OCS_DECRYPT, OCS_MODE_CTR);
+}
+
+#ifdef CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_CTS
+static int kmb_ocs_sm4_cts_encrypt(struct skcipher_request *req)
+{
+	return kmb_ocs_sk_common(req, OCS_SM4, OCS_ENCRYPT, OCS_MODE_CTS);
+}
+
+static int kmb_ocs_sm4_cts_decrypt(struct skcipher_request *req)
+{
+	return kmb_ocs_sk_common(req, OCS_SM4, OCS_DECRYPT, OCS_MODE_CTS);
+}
+#endif /* CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_CTS */
+
+static int kmb_ocs_sm4_gcm_encrypt(struct aead_request *req)
+{
+	return kmb_ocs_aead_common(req, OCS_SM4, OCS_ENCRYPT, OCS_MODE_GCM);
+}
+
+static int kmb_ocs_sm4_gcm_decrypt(struct aead_request *req)
+{
+	return kmb_ocs_aead_common(req, OCS_SM4, OCS_DECRYPT, OCS_MODE_GCM);
+}
+
+static int kmb_ocs_sm4_ccm_encrypt(struct aead_request *req)
+{
+	return kmb_ocs_aead_common(req, OCS_SM4, OCS_ENCRYPT, OCS_MODE_CCM);
+}
+
+static int kmb_ocs_sm4_ccm_decrypt(struct aead_request *req)
+{
+	return kmb_ocs_aead_common(req, OCS_SM4, OCS_DECRYPT, OCS_MODE_CCM);
+}
+
+static inline int ocs_common_init(struct ocs_aes_tctx *tctx)
+{
+	tctx->engine_ctx.op.prepare_request = NULL;
+	tctx->engine_ctx.op.do_one_request = kmb_ocs_aes_sk_do_one_request;
+	tctx->engine_ctx.op.unprepare_request = NULL;
+
+	return 0;
+}
+
+static int ocs_aes_init_tfm(struct crypto_skcipher *tfm)
+{
+	const char *alg_name = crypto_tfm_alg_name(&tfm->base);
+	struct ocs_aes_tctx *tctx = crypto_skcipher_ctx(tfm);
+	struct crypto_sync_skcipher *blk;
+
+	/* set fallback cipher in case it will be needed */
+	blk = crypto_alloc_sync_skcipher(alg_name, 0, CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(blk))
+		return PTR_ERR(blk);
+
+	tctx->sw_cipher.sk = blk;
+
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct ocs_aes_rctx));
+
+	return ocs_common_init(tctx);
+}
+
+static int ocs_sm4_init_tfm(struct crypto_skcipher *tfm)
+{
+	struct ocs_aes_tctx *tctx = crypto_skcipher_ctx(tfm);
+
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct ocs_aes_rctx));
+
+	return ocs_common_init(tctx);
+}
+
+static inline void clear_key(struct ocs_aes_tctx *tctx)
+{
+	memzero_explicit(tctx->key, OCS_AES_KEYSIZE_256);
+
+	/* Zero key registers if set */
+	if (tctx->aes_dev)
+		ocs_aes_set_key(tctx->aes_dev, OCS_AES_KEYSIZE_256,
+				tctx->key, OCS_AES);
+}
+
+static void ocs_exit_tfm(struct crypto_skcipher *tfm)
+{
+	struct ocs_aes_tctx *tctx = crypto_skcipher_ctx(tfm);
+
+	clear_key(tctx);
+
+	if (tctx->sw_cipher.sk) {
+		crypto_free_sync_skcipher(tctx->sw_cipher.sk);
+		tctx->sw_cipher.sk = NULL;
+	}
+}
+
+static inline int ocs_common_aead_init(struct ocs_aes_tctx *tctx)
+{
+	tctx->engine_ctx.op.prepare_request = NULL;
+	tctx->engine_ctx.op.do_one_request = kmb_ocs_aes_aead_do_one_request;
+	tctx->engine_ctx.op.unprepare_request = NULL;
+
+	return 0;
+}
+
+static int ocs_aes_aead_cra_init(struct crypto_aead *tfm)
+{
+	const char *alg_name = crypto_tfm_alg_name(&tfm->base);
+	struct ocs_aes_tctx *tctx = crypto_aead_ctx(tfm);
+	struct crypto_aead *blk;
+
+	/* Set fallback cipher in case it will be needed */
+	blk = crypto_alloc_aead(alg_name, 0, CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(blk))
+		return PTR_ERR(blk);
+
+	tctx->sw_cipher.aead = blk;
+
+	crypto_aead_set_reqsize(tfm,
+				max(sizeof(struct ocs_aes_rctx),
+				    (sizeof(struct aead_request) +
+				     crypto_aead_reqsize(tctx->sw_cipher.aead))));
+
+	return ocs_common_aead_init(tctx);
+}
+
+static int kmb_ocs_aead_ccm_setauthsize(struct crypto_aead *tfm,
+					unsigned int authsize)
+{
+	switch (authsize) {
+	case 4:
+	case 6:
+	case 8:
+	case 10:
+	case 12:
+	case 14:
+	case 16:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int kmb_ocs_aead_gcm_setauthsize(struct crypto_aead *tfm,
+					unsigned int authsize)
+{
+	return crypto_gcm_check_authsize(authsize);
+}
+
+static int ocs_sm4_aead_cra_init(struct crypto_aead *tfm)
+{
+	struct ocs_aes_tctx *tctx = crypto_aead_ctx(tfm);
+
+	crypto_aead_set_reqsize(tfm, sizeof(struct ocs_aes_rctx));
+
+	return ocs_common_aead_init(tctx);
+}
+
+static void ocs_aead_cra_exit(struct crypto_aead *tfm)
+{
+	struct ocs_aes_tctx *tctx = crypto_aead_ctx(tfm);
+
+	clear_key(tctx);
+
+	if (tctx->sw_cipher.aead) {
+		crypto_free_aead(tctx->sw_cipher.aead);
+		tctx->sw_cipher.aead = NULL;
+	}
+}
+
+static struct skcipher_alg algs[] = {
+#ifdef CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_ECB
+	{
+		.base.cra_name = "ecb(aes)",
+		.base.cra_driver_name = "ecb-aes-keembay-ocs",
+		.base.cra_priority = KMB_OCS_PRIORITY,
+		.base.cra_flags = CRYPTO_ALG_ASYNC |
+				  CRYPTO_ALG_KERN_DRIVER_ONLY |
+				  CRYPTO_ALG_NEED_FALLBACK,
+		.base.cra_blocksize = AES_BLOCK_SIZE,
+		.base.cra_ctxsize = sizeof(struct ocs_aes_tctx),
+		.base.cra_module = THIS_MODULE,
+		.base.cra_alignmask = 0,
+
+		.min_keysize = OCS_AES_MIN_KEY_SIZE,
+		.max_keysize = OCS_AES_MAX_KEY_SIZE,
+		.setkey = kmb_ocs_aes_set_key,
+		.encrypt = kmb_ocs_aes_ecb_encrypt,
+		.decrypt = kmb_ocs_aes_ecb_decrypt,
+		.init = ocs_aes_init_tfm,
+		.exit = ocs_exit_tfm,
+	},
+#endif /* CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_ECB */
+	{
+		.base.cra_name = "cbc(aes)",
+		.base.cra_driver_name = "cbc-aes-keembay-ocs",
+		.base.cra_priority = KMB_OCS_PRIORITY,
+		.base.cra_flags = CRYPTO_ALG_ASYNC |
+				  CRYPTO_ALG_KERN_DRIVER_ONLY |
+				  CRYPTO_ALG_NEED_FALLBACK,
+		.base.cra_blocksize = AES_BLOCK_SIZE,
+		.base.cra_ctxsize = sizeof(struct ocs_aes_tctx),
+		.base.cra_module = THIS_MODULE,
+		.base.cra_alignmask = 0,
+
+		.min_keysize = OCS_AES_MIN_KEY_SIZE,
+		.max_keysize = OCS_AES_MAX_KEY_SIZE,
+		.ivsize = AES_BLOCK_SIZE,
+		.setkey = kmb_ocs_aes_set_key,
+		.encrypt = kmb_ocs_aes_cbc_encrypt,
+		.decrypt = kmb_ocs_aes_cbc_decrypt,
+		.init = ocs_aes_init_tfm,
+		.exit = ocs_exit_tfm,
+	},
+	{
+		.base.cra_name = "ctr(aes)",
+		.base.cra_driver_name = "ctr-aes-keembay-ocs",
+		.base.cra_priority = KMB_OCS_PRIORITY,
+		.base.cra_flags = CRYPTO_ALG_ASYNC |
+				  CRYPTO_ALG_KERN_DRIVER_ONLY |
+				  CRYPTO_ALG_NEED_FALLBACK,
+		.base.cra_blocksize = 1,
+		.base.cra_ctxsize = sizeof(struct ocs_aes_tctx),
+		.base.cra_module = THIS_MODULE,
+		.base.cra_alignmask = 0,
+
+		.min_keysize = OCS_AES_MIN_KEY_SIZE,
+		.max_keysize = OCS_AES_MAX_KEY_SIZE,
+		.ivsize = AES_BLOCK_SIZE,
+		.setkey = kmb_ocs_aes_set_key,
+		.encrypt = kmb_ocs_aes_ctr_encrypt,
+		.decrypt = kmb_ocs_aes_ctr_decrypt,
+		.init = ocs_aes_init_tfm,
+		.exit = ocs_exit_tfm,
+	},
+#ifdef CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_CTS
+	{
+		.base.cra_name = "cts(cbc(aes))",
+		.base.cra_driver_name = "cts-aes-keembay-ocs",
+		.base.cra_priority = KMB_OCS_PRIORITY,
+		.base.cra_flags = CRYPTO_ALG_ASYNC |
+				  CRYPTO_ALG_KERN_DRIVER_ONLY |
+				  CRYPTO_ALG_NEED_FALLBACK,
+		.base.cra_blocksize = AES_BLOCK_SIZE,
+		.base.cra_ctxsize = sizeof(struct ocs_aes_tctx),
+		.base.cra_module = THIS_MODULE,
+		.base.cra_alignmask = 0,
+
+		.min_keysize = OCS_AES_MIN_KEY_SIZE,
+		.max_keysize = OCS_AES_MAX_KEY_SIZE,
+		.ivsize = AES_BLOCK_SIZE,
+		.setkey = kmb_ocs_aes_set_key,
+		.encrypt = kmb_ocs_aes_cts_encrypt,
+		.decrypt = kmb_ocs_aes_cts_decrypt,
+		.init = ocs_aes_init_tfm,
+		.exit = ocs_exit_tfm,
+	},
+#endif /* CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_CTS */
+#ifdef CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_ECB
+	{
+		.base.cra_name = "ecb(sm4)",
+		.base.cra_driver_name = "ecb-sm4-keembay-ocs",
+		.base.cra_priority = KMB_OCS_PRIORITY,
+		.base.cra_flags = CRYPTO_ALG_ASYNC |
+				  CRYPTO_ALG_KERN_DRIVER_ONLY,
+		.base.cra_blocksize = AES_BLOCK_SIZE,
+		.base.cra_ctxsize = sizeof(struct ocs_aes_tctx),
+		.base.cra_module = THIS_MODULE,
+		.base.cra_alignmask = 0,
+
+		.min_keysize = OCS_SM4_KEY_SIZE,
+		.max_keysize = OCS_SM4_KEY_SIZE,
+		.setkey = kmb_ocs_sm4_set_key,
+		.encrypt = kmb_ocs_sm4_ecb_encrypt,
+		.decrypt = kmb_ocs_sm4_ecb_decrypt,
+		.init = ocs_sm4_init_tfm,
+		.exit = ocs_exit_tfm,
+	},
+#endif /* CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_ECB */
+	{
+		.base.cra_name = "cbc(sm4)",
+		.base.cra_driver_name = "cbc-sm4-keembay-ocs",
+		.base.cra_priority = KMB_OCS_PRIORITY,
+		.base.cra_flags = CRYPTO_ALG_ASYNC |
+				  CRYPTO_ALG_KERN_DRIVER_ONLY,
+		.base.cra_blocksize = AES_BLOCK_SIZE,
+		.base.cra_ctxsize = sizeof(struct ocs_aes_tctx),
+		.base.cra_module = THIS_MODULE,
+		.base.cra_alignmask = 0,
+
+		.min_keysize = OCS_SM4_KEY_SIZE,
+		.max_keysize = OCS_SM4_KEY_SIZE,
+		.ivsize = AES_BLOCK_SIZE,
+		.setkey = kmb_ocs_sm4_set_key,
+		.encrypt = kmb_ocs_sm4_cbc_encrypt,
+		.decrypt = kmb_ocs_sm4_cbc_decrypt,
+		.init = ocs_sm4_init_tfm,
+		.exit = ocs_exit_tfm,
+	},
+	{
+		.base.cra_name = "ctr(sm4)",
+		.base.cra_driver_name = "ctr-sm4-keembay-ocs",
+		.base.cra_priority = KMB_OCS_PRIORITY,
+		.base.cra_flags = CRYPTO_ALG_ASYNC |
+				  CRYPTO_ALG_KERN_DRIVER_ONLY,
+		.base.cra_blocksize = 1,
+		.base.cra_ctxsize = sizeof(struct ocs_aes_tctx),
+		.base.cra_module = THIS_MODULE,
+		.base.cra_alignmask = 0,
+
+		.min_keysize = OCS_SM4_KEY_SIZE,
+		.max_keysize = OCS_SM4_KEY_SIZE,
+		.ivsize = AES_BLOCK_SIZE,
+		.setkey = kmb_ocs_sm4_set_key,
+		.encrypt = kmb_ocs_sm4_ctr_encrypt,
+		.decrypt = kmb_ocs_sm4_ctr_decrypt,
+		.init = ocs_sm4_init_tfm,
+		.exit = ocs_exit_tfm,
+	},
+#ifdef CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_CTS
+	{
+		.base.cra_name = "cts(cbc(sm4))",
+		.base.cra_driver_name = "cts-sm4-keembay-ocs",
+		.base.cra_priority = KMB_OCS_PRIORITY,
+		.base.cra_flags = CRYPTO_ALG_ASYNC |
+				  CRYPTO_ALG_KERN_DRIVER_ONLY,
+		.base.cra_blocksize = AES_BLOCK_SIZE,
+		.base.cra_ctxsize = sizeof(struct ocs_aes_tctx),
+		.base.cra_module = THIS_MODULE,
+		.base.cra_alignmask = 0,
+
+		.min_keysize = OCS_SM4_KEY_SIZE,
+		.max_keysize = OCS_SM4_KEY_SIZE,
+		.ivsize = AES_BLOCK_SIZE,
+		.setkey = kmb_ocs_sm4_set_key,
+		.encrypt = kmb_ocs_sm4_cts_encrypt,
+		.decrypt = kmb_ocs_sm4_cts_decrypt,
+		.init = ocs_sm4_init_tfm,
+		.exit = ocs_exit_tfm,
+	}
+#endif /* CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_CTS */
+};
+
+static struct aead_alg algs_aead[] = {
+	{
+		.base = {
+			.cra_name = "gcm(aes)",
+			.cra_driver_name = "gcm-aes-keembay-ocs",
+			.cra_priority = KMB_OCS_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+				     CRYPTO_ALG_KERN_DRIVER_ONLY |
+				     CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize = 1,
+			.cra_ctxsize = sizeof(struct ocs_aes_tctx),
+			.cra_alignmask = 0,
+			.cra_module = THIS_MODULE,
+		},
+		.init = ocs_aes_aead_cra_init,
+		.exit = ocs_aead_cra_exit,
+		.ivsize = GCM_AES_IV_SIZE,
+		.maxauthsize = AES_BLOCK_SIZE,
+		.setauthsize = kmb_ocs_aead_gcm_setauthsize,
+		.setkey = kmb_ocs_aes_aead_set_key,
+		.encrypt = kmb_ocs_aes_gcm_encrypt,
+		.decrypt = kmb_ocs_aes_gcm_decrypt,
+	},
+	{
+		.base = {
+			.cra_name = "ccm(aes)",
+			.cra_driver_name = "ccm-aes-keembay-ocs",
+			.cra_priority = KMB_OCS_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+				     CRYPTO_ALG_KERN_DRIVER_ONLY |
+				     CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize = 1,
+			.cra_ctxsize = sizeof(struct ocs_aes_tctx),
+			.cra_alignmask = 0,
+			.cra_module = THIS_MODULE,
+		},
+		.init = ocs_aes_aead_cra_init,
+		.exit = ocs_aead_cra_exit,
+		.ivsize = AES_BLOCK_SIZE,
+		.maxauthsize = AES_BLOCK_SIZE,
+		.setauthsize = kmb_ocs_aead_ccm_setauthsize,
+		.setkey = kmb_ocs_aes_aead_set_key,
+		.encrypt = kmb_ocs_aes_ccm_encrypt,
+		.decrypt = kmb_ocs_aes_ccm_decrypt,
+	},
+	{
+		.base = {
+			.cra_name = "gcm(sm4)",
+			.cra_driver_name = "gcm-sm4-keembay-ocs",
+			.cra_priority = KMB_OCS_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+				     CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = 1,
+			.cra_ctxsize = sizeof(struct ocs_aes_tctx),
+			.cra_alignmask = 0,
+			.cra_module = THIS_MODULE,
+		},
+		.init = ocs_sm4_aead_cra_init,
+		.exit = ocs_aead_cra_exit,
+		.ivsize = GCM_AES_IV_SIZE,
+		.maxauthsize = AES_BLOCK_SIZE,
+		.setauthsize = kmb_ocs_aead_gcm_setauthsize,
+		.setkey = kmb_ocs_sm4_aead_set_key,
+		.encrypt = kmb_ocs_sm4_gcm_encrypt,
+		.decrypt = kmb_ocs_sm4_gcm_decrypt,
+	},
+	{
+		.base = {
+			.cra_name = "ccm(sm4)",
+			.cra_driver_name = "ccm-sm4-keembay-ocs",
+			.cra_priority = KMB_OCS_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+				     CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = 1,
+			.cra_ctxsize = sizeof(struct ocs_aes_tctx),
+			.cra_alignmask = 0,
+			.cra_module = THIS_MODULE,
+		},
+		.init = ocs_sm4_aead_cra_init,
+		.exit = ocs_aead_cra_exit,
+		.ivsize = AES_BLOCK_SIZE,
+		.maxauthsize = AES_BLOCK_SIZE,
+		.setauthsize = kmb_ocs_aead_ccm_setauthsize,
+		.setkey = kmb_ocs_sm4_aead_set_key,
+		.encrypt = kmb_ocs_sm4_ccm_encrypt,
+		.decrypt = kmb_ocs_sm4_ccm_decrypt,
+	}
+};
+
+static void unregister_aes_algs(struct ocs_aes_dev *aes_dev)
+{
+	crypto_unregister_aeads(algs_aead, ARRAY_SIZE(algs_aead));
+	crypto_unregister_skciphers(algs, ARRAY_SIZE(algs));
+}
+
+static int register_aes_algs(struct ocs_aes_dev *aes_dev)
+{
+	int ret;
+
+	/*
+	 * If any algorithm fails to register, all preceding algorithms that
+	 * were successfully registered will be automatically unregistered.
+	 */
+	ret = crypto_register_aeads(algs_aead, ARRAY_SIZE(algs_aead));
+	if (ret)
+		return ret;
+
+	ret = crypto_register_skciphers(algs, ARRAY_SIZE(algs));
+	if (ret)
+		crypto_unregister_aeads(algs_aead, ARRAY_SIZE(algs));
+
+	return ret;
+}
+
+/* Device tree driver match. */
+static const struct of_device_id kmb_ocs_aes_of_match[] = {
+	{
+		.compatible = "intel,keembay-ocs-aes",
+	},
+	{}
+};
+
+static int kmb_ocs_aes_remove(struct platform_device *pdev)
+{
+	struct ocs_aes_dev *aes_dev;
+
+	aes_dev = platform_get_drvdata(pdev);
+	if (!aes_dev)
+		return -ENODEV;
+
+	unregister_aes_algs(aes_dev);
+
+	spin_lock(&ocs_aes.lock);
+	list_del(&aes_dev->list);
+	spin_unlock(&ocs_aes.lock);
+
+	crypto_engine_exit(aes_dev->engine);
+
+	return 0;
+}
+
+static int kmb_ocs_aes_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ocs_aes_dev *aes_dev;
+	struct resource *aes_mem;
+	int rc;
+
+	aes_dev = devm_kzalloc(dev, sizeof(*aes_dev), GFP_KERNEL);
+	if (!aes_dev)
+		return -ENOMEM;
+
+	aes_dev->dev = dev;
+
+	platform_set_drvdata(pdev, aes_dev);
+
+	rc = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	if (rc) {
+		dev_err(dev, "Failed to set 32 bit dma mask %d\n", rc);
+		return rc;
+	}
+
+	/* Get base register address. */
+	aes_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!aes_mem) {
+		dev_err(dev, "Could not retrieve io mem resource\n");
+		return -ENODEV;
+	}
+
+	aes_dev->base_reg = devm_ioremap_resource(&pdev->dev, aes_mem);
+	if (IS_ERR(aes_dev->base_reg)) {
+		dev_err(dev, "Failed to get base address\n");
+		return PTR_ERR(aes_dev->base_reg);
+	}
+
+	/* Get and request IRQ */
+	aes_dev->irq = platform_get_irq(pdev, 0);
+	if (aes_dev->irq < 0)
+		return aes_dev->irq;
+
+	rc = devm_request_threaded_irq(dev, aes_dev->irq, ocs_aes_irq_handler,
+				       NULL, 0, "keembay-ocs-aes", aes_dev);
+	if (rc < 0) {
+		dev_err(dev, "Could not request IRQ\n");
+		return rc;
+	}
+
+	INIT_LIST_HEAD(&aes_dev->list);
+	spin_lock(&ocs_aes.lock);
+	list_add_tail(&aes_dev->list, &ocs_aes.dev_list);
+	spin_unlock(&ocs_aes.lock);
+
+	init_completion(&aes_dev->irq_completion);
+
+	/* Initialize crypto engine */
+	aes_dev->engine = crypto_engine_alloc_init(dev, true);
+	if (!aes_dev->engine)
+		goto list_del;
+
+	rc = crypto_engine_start(aes_dev->engine);
+	if (rc) {
+		dev_err(dev, "Could not start crypto engine\n");
+		goto cleanup;
+	}
+
+	rc = register_aes_algs(aes_dev);
+	if (rc) {
+		dev_err(dev,
+			"Could not register OCS algorithms with Crypto API\n");
+		goto cleanup;
+	}
+
+	return 0;
+
+cleanup:
+	crypto_engine_exit(aes_dev->engine);
+list_del:
+	spin_lock(&ocs_aes.lock);
+	list_del(&aes_dev->list);
+	spin_unlock(&ocs_aes.lock);
+
+	return rc;
+}
+
+/* The OCS driver is a platform device. */
+static struct platform_driver kmb_ocs_aes_driver = {
+	.probe = kmb_ocs_aes_probe,
+	.remove = kmb_ocs_aes_remove,
+	.driver = {
+			.name = DRV_NAME,
+			.of_match_table = kmb_ocs_aes_of_match,
+		},
+};
+
+module_platform_driver(kmb_ocs_aes_driver);
+
+MODULE_DESCRIPTION("Intel Keem Bay Offload and Crypto Subsystem (OCS) AES/SM4 Driver");
+MODULE_LICENSE("GPL");
+
+MODULE_ALIAS_CRYPTO("cbc-aes-keembay-ocs");
+MODULE_ALIAS_CRYPTO("ctr-aes-keembay-ocs");
+MODULE_ALIAS_CRYPTO("gcm-aes-keembay-ocs");
+MODULE_ALIAS_CRYPTO("ccm-aes-keembay-ocs");
+
+MODULE_ALIAS_CRYPTO("cbc-sm4-keembay-ocs");
+MODULE_ALIAS_CRYPTO("ctr-sm4-keembay-ocs");
+MODULE_ALIAS_CRYPTO("gcm-sm4-keembay-ocs");
+MODULE_ALIAS_CRYPTO("ccm-sm4-keembay-ocs");
+
+#ifdef CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_ECB
+MODULE_ALIAS_CRYPTO("ecb-aes-keembay-ocs");
+MODULE_ALIAS_CRYPTO("ecb-sm4-keembay-ocs");
+#endif /* CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_ECB */
+
+#ifdef CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_CTS
+MODULE_ALIAS_CRYPTO("cts-aes-keembay-ocs");
+MODULE_ALIAS_CRYPTO("cts-sm4-keembay-ocs");
+#endif /* CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_CTS */
diff --git a/drivers/crypto/keembay/ocs-aes.c b/drivers/crypto/keembay/ocs-aes.c
new file mode 100644
index 000000000000..cc286adb1c4a
--- /dev/null
+++ b/drivers/crypto/keembay/ocs-aes.c
@@ -0,0 +1,1489 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel Keem Bay OCS AES Crypto Driver.
+ *
+ * Copyright (C) 2018-2020 Intel Corporation
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/swab.h>
+
+#include <asm/byteorder.h>
+#include <asm/errno.h>
+
+#include <crypto/aes.h>
+#include <crypto/gcm.h>
+
+#include "ocs-aes.h"
+
+#define AES_COMMAND_OFFSET			0x0000
+#define AES_KEY_0_OFFSET			0x0004
+#define AES_KEY_1_OFFSET			0x0008
+#define AES_KEY_2_OFFSET			0x000C
+#define AES_KEY_3_OFFSET			0x0010
+#define AES_KEY_4_OFFSET			0x0014
+#define AES_KEY_5_OFFSET			0x0018
+#define AES_KEY_6_OFFSET			0x001C
+#define AES_KEY_7_OFFSET			0x0020
+#define AES_IV_0_OFFSET				0x0024
+#define AES_IV_1_OFFSET				0x0028
+#define AES_IV_2_OFFSET				0x002C
+#define AES_IV_3_OFFSET				0x0030
+#define AES_ACTIVE_OFFSET			0x0034
+#define AES_STATUS_OFFSET			0x0038
+#define AES_KEY_SIZE_OFFSET			0x0044
+#define AES_IER_OFFSET				0x0048
+#define AES_ISR_OFFSET				0x005C
+#define AES_MULTIPURPOSE1_0_OFFSET		0x0200
+#define AES_MULTIPURPOSE1_1_OFFSET		0x0204
+#define AES_MULTIPURPOSE1_2_OFFSET		0x0208
+#define AES_MULTIPURPOSE1_3_OFFSET		0x020C
+#define AES_MULTIPURPOSE2_0_OFFSET		0x0220
+#define AES_MULTIPURPOSE2_1_OFFSET		0x0224
+#define AES_MULTIPURPOSE2_2_OFFSET		0x0228
+#define AES_MULTIPURPOSE2_3_OFFSET		0x022C
+#define AES_BYTE_ORDER_CFG_OFFSET		0x02C0
+#define AES_TLEN_OFFSET				0x0300
+#define AES_T_MAC_0_OFFSET			0x0304
+#define AES_T_MAC_1_OFFSET			0x0308
+#define AES_T_MAC_2_OFFSET			0x030C
+#define AES_T_MAC_3_OFFSET			0x0310
+#define AES_PLEN_OFFSET				0x0314
+#define AES_A_DMA_SRC_ADDR_OFFSET		0x0400
+#define AES_A_DMA_DST_ADDR_OFFSET		0x0404
+#define AES_A_DMA_SRC_SIZE_OFFSET		0x0408
+#define AES_A_DMA_DST_SIZE_OFFSET		0x040C
+#define AES_A_DMA_DMA_MODE_OFFSET		0x0410
+#define AES_A_DMA_NEXT_SRC_DESCR_OFFSET		0x0418
+#define AES_A_DMA_NEXT_DST_DESCR_OFFSET		0x041C
+#define AES_A_DMA_WHILE_ACTIVE_MODE_OFFSET	0x0420
+#define AES_A_DMA_LOG_OFFSET			0x0424
+#define AES_A_DMA_STATUS_OFFSET			0x0428
+#define AES_A_DMA_PERF_CNTR_OFFSET		0x042C
+#define AES_A_DMA_MSI_ISR_OFFSET		0x0480
+#define AES_A_DMA_MSI_IER_OFFSET		0x0484
+#define AES_A_DMA_MSI_MASK_OFFSET		0x0488
+#define AES_A_DMA_INBUFFER_WRITE_FIFO_OFFSET	0x0600
+#define AES_A_DMA_OUTBUFFER_READ_FIFO_OFFSET	0x0700
+
+/*
+ * AES_A_DMA_DMA_MODE register.
+ * Default: 0x00000000.
+ * bit[31]	ACTIVE
+ *		This bit activates the DMA. When the DMA finishes, it resets
+ *		this bit to zero.
+ * bit[30:26]	Unused by this driver.
+ * bit[25]	SRC_LINK_LIST_EN
+ *		Source link list enable bit. When the linked list is terminated
+ *		this bit is reset by the DMA.
+ * bit[24]	DST_LINK_LIST_EN
+ *		Destination link list enable bit. When the linked list is
+ *		terminated this bit is reset by the DMA.
+ * bit[23:0]	Unused by this driver.
+ */
+#define AES_A_DMA_DMA_MODE_ACTIVE		BIT(31)
+#define AES_A_DMA_DMA_MODE_SRC_LINK_LIST_EN	BIT(25)
+#define AES_A_DMA_DMA_MODE_DST_LINK_LIST_EN	BIT(24)
+
+/*
+ * AES_ACTIVE register
+ * default 0x00000000
+ * bit[31:10]	Reserved
+ * bit[9]	LAST_ADATA
+ * bit[8]	LAST_GCX
+ * bit[7:2]	Reserved
+ * bit[1]	TERMINATION
+ * bit[0]	TRIGGER
+ */
+#define AES_ACTIVE_LAST_ADATA			BIT(9)
+#define AES_ACTIVE_LAST_CCM_GCM			BIT(8)
+#define AES_ACTIVE_TERMINATION			BIT(1)
+#define AES_ACTIVE_TRIGGER			BIT(0)
+
+#define AES_DISABLE_INT				0x00000000
+#define AES_DMA_CPD_ERR_INT			BIT(8)
+#define AES_DMA_OUTBUF_RD_ERR_INT		BIT(7)
+#define AES_DMA_OUTBUF_WR_ERR_INT		BIT(6)
+#define AES_DMA_INBUF_RD_ERR_INT		BIT(5)
+#define AES_DMA_INBUF_WR_ERR_INT		BIT(4)
+#define AES_DMA_BAD_COMP_INT			BIT(3)
+#define AES_DMA_SAI_INT				BIT(2)
+#define AES_DMA_SRC_DONE_INT			BIT(0)
+#define AES_COMPLETE_INT			BIT(1)
+
+#define AES_DMA_MSI_MASK_CLEAR			BIT(0)
+
+#define AES_128_BIT_KEY				0x00000000
+#define AES_256_BIT_KEY				BIT(0)
+
+#define AES_DEACTIVATE_PERF_CNTR		0x00000000
+#define AES_ACTIVATE_PERF_CNTR			BIT(0)
+
+#define AES_MAX_TAG_SIZE_U32			4
+
+#define OCS_LL_DMA_FLAG_TERMINATE		BIT(31)
+
+/*
+ * There is an inconsistency in the documentation. This is documented as a
+ * 11-bit value, but it is actually 10-bits.
+ */
+#define AES_DMA_STATUS_INPUT_BUFFER_OCCUPANCY_MASK	0x3FF
+
+/*
+ * During CCM decrypt, the OCS block needs to finish processing the ciphertext
+ * before the tag is written. For 128-bit mode this required delay is 28 OCS
+ * clock cycles. For 256-bit mode it is 36 OCS clock cycles.
+ */
+#define CCM_DECRYPT_DELAY_TAG_CLK_COUNT		36UL
+
+/*
+ * During CCM decrypt there must be a delay of at least 42 OCS clock cycles
+ * between setting the TRIGGER bit in AES_ACTIVE and setting the LAST_CCM_GCM
+ * bit in the same register (as stated in the OCS databook)
+ */
+#define CCM_DECRYPT_DELAY_LAST_GCX_CLK_COUNT	42UL
+
+/* See RFC3610 section 2.2 */
+#define L_PRIME_MIN (1)
+#define L_PRIME_MAX (7)
+/*
+ * CCM IV format from RFC 3610 section 2.3
+ *
+ *   Octet Number   Contents
+ *   ------------   ---------
+ *   0              Flags
+ *   1 ... 15-L     Nonce N
+ *   16-L ... 15    Counter i
+ *
+ * Flags = L' = L - 1
+ */
+#define L_PRIME_IDX		0
+#define COUNTER_START(lprime)	(16 - ((lprime) + 1))
+#define COUNTER_LEN(lprime)	((lprime) + 1)
+
+enum aes_counter_mode {
+	AES_CTR_M_NO_INC = 0,
+	AES_CTR_M_32_INC = 1,
+	AES_CTR_M_64_INC = 2,
+	AES_CTR_M_128_INC = 3,
+};
+
+/**
+ * struct ocs_dma_linked_list - OCS DMA linked list entry.
+ * @src_addr:   Source address of the data.
+ * @src_len:    Length of data to be fetched.
+ * @next:	Next dma_list to fetch.
+ * @ll_flags:   Flags (Freeze @ terminate) for the DMA engine.
+ */
+struct ocs_dma_linked_list {
+	u32 src_addr;
+	u32 src_len;
+	u32 next;
+	u32 ll_flags;
+} __packed;
+
+/*
+ * Set endianness of inputs and outputs
+ * AES_BYTE_ORDER_CFG
+ * default 0x00000000
+ * bit [10] - KEY_HI_LO_SWAP
+ * bit [9] - KEY_HI_SWAP_DWORDS_IN_OCTWORD
+ * bit [8] - KEY_HI_SWAP_BYTES_IN_DWORD
+ * bit [7] - KEY_LO_SWAP_DWORDS_IN_OCTWORD
+ * bit [6] - KEY_LO_SWAP_BYTES_IN_DWORD
+ * bit [5] - IV_SWAP_DWORDS_IN_OCTWORD
+ * bit [4] - IV_SWAP_BYTES_IN_DWORD
+ * bit [3] - DOUT_SWAP_DWORDS_IN_OCTWORD
+ * bit [2] - DOUT_SWAP_BYTES_IN_DWORD
+ * bit [1] - DOUT_SWAP_DWORDS_IN_OCTWORD
+ * bit [0] - DOUT_SWAP_BYTES_IN_DWORD
+ */
+static inline void aes_a_set_endianness(const struct ocs_aes_dev *aes_dev)
+{
+	iowrite32(0x7FF, aes_dev->base_reg + AES_BYTE_ORDER_CFG_OFFSET);
+}
+
+/* Trigger AES process start. */
+static inline void aes_a_op_trigger(const struct ocs_aes_dev *aes_dev)
+{
+	iowrite32(AES_ACTIVE_TRIGGER, aes_dev->base_reg + AES_ACTIVE_OFFSET);
+}
+
+/* Indicate last bulk of data. */
+static inline void aes_a_op_termination(const struct ocs_aes_dev *aes_dev)
+{
+	iowrite32(AES_ACTIVE_TERMINATION,
+		  aes_dev->base_reg + AES_ACTIVE_OFFSET);
+}
+
+/*
+ * Set LAST_CCM_GCM in AES_ACTIVE register and clear all other bits.
+ *
+ * Called when DMA is programmed to fetch the last batch of data.
+ * - For AES-CCM it is called for the last batch of Payload data and Ciphertext
+ *   data.
+ * - For AES-GCM, it is called for the last batch of Plaintext data and
+ *   Ciphertext data.
+ */
+static inline void aes_a_set_last_gcx(const struct ocs_aes_dev *aes_dev)
+{
+	iowrite32(AES_ACTIVE_LAST_CCM_GCM,
+		  aes_dev->base_reg + AES_ACTIVE_OFFSET);
+}
+
+/* Wait for LAST_CCM_GCM bit to be unset. */
+static inline void aes_a_wait_last_gcx(const struct ocs_aes_dev *aes_dev)
+{
+	u32 aes_active_reg;
+
+	do {
+		aes_active_reg = ioread32(aes_dev->base_reg +
+					  AES_ACTIVE_OFFSET);
+	} while (aes_active_reg & AES_ACTIVE_LAST_CCM_GCM);
+}
+
+/* Wait for 10 bits of input occupancy. */
+static void aes_a_dma_wait_input_buffer_occupancy(const struct ocs_aes_dev *aes_dev)
+{
+	u32 reg;
+
+	do {
+		reg = ioread32(aes_dev->base_reg + AES_A_DMA_STATUS_OFFSET);
+	} while (reg & AES_DMA_STATUS_INPUT_BUFFER_OCCUPANCY_MASK);
+}
+
+ /*
+  * Set LAST_CCM_GCM and LAST_ADATA bits in AES_ACTIVE register (and clear all
+  * other bits).
+  *
+  * Called when DMA is programmed to fetch the last batch of Associated Data
+  * (CCM case) or Additional Authenticated Data (GCM case).
+  */
+static inline void aes_a_set_last_gcx_and_adata(const struct ocs_aes_dev *aes_dev)
+{
+	iowrite32(AES_ACTIVE_LAST_ADATA | AES_ACTIVE_LAST_CCM_GCM,
+		  aes_dev->base_reg + AES_ACTIVE_OFFSET);
+}
+
+/* Set DMA src and dst transfer size to 0 */
+static inline void aes_a_dma_set_xfer_size_zero(const struct ocs_aes_dev *aes_dev)
+{
+	iowrite32(0, aes_dev->base_reg + AES_A_DMA_SRC_SIZE_OFFSET);
+	iowrite32(0, aes_dev->base_reg + AES_A_DMA_DST_SIZE_OFFSET);
+}
+
+/* Activate DMA for zero-byte transfer case. */
+static inline void aes_a_dma_active(const struct ocs_aes_dev *aes_dev)
+{
+	iowrite32(AES_A_DMA_DMA_MODE_ACTIVE,
+		  aes_dev->base_reg + AES_A_DMA_DMA_MODE_OFFSET);
+}
+
+/* Activate DMA and enable src linked list */
+static inline void aes_a_dma_active_src_ll_en(const struct ocs_aes_dev *aes_dev)
+{
+	iowrite32(AES_A_DMA_DMA_MODE_ACTIVE |
+		  AES_A_DMA_DMA_MODE_SRC_LINK_LIST_EN,
+		  aes_dev->base_reg + AES_A_DMA_DMA_MODE_OFFSET);
+}
+
+/* Activate DMA and enable dst linked list */
+static inline void aes_a_dma_active_dst_ll_en(const struct ocs_aes_dev *aes_dev)
+{
+	iowrite32(AES_A_DMA_DMA_MODE_ACTIVE |
+		  AES_A_DMA_DMA_MODE_DST_LINK_LIST_EN,
+		  aes_dev->base_reg + AES_A_DMA_DMA_MODE_OFFSET);
+}
+
+/* Activate DMA and enable src and dst linked lists */
+static inline void aes_a_dma_active_src_dst_ll_en(const struct ocs_aes_dev *aes_dev)
+{
+	iowrite32(AES_A_DMA_DMA_MODE_ACTIVE |
+		  AES_A_DMA_DMA_MODE_SRC_LINK_LIST_EN |
+		  AES_A_DMA_DMA_MODE_DST_LINK_LIST_EN,
+		  aes_dev->base_reg + AES_A_DMA_DMA_MODE_OFFSET);
+}
+
+/* Reset PERF_CNTR to 0 and activate it */
+static inline void aes_a_dma_reset_and_activate_perf_cntr(const struct ocs_aes_dev *aes_dev)
+{
+	iowrite32(0x00000000, aes_dev->base_reg + AES_A_DMA_PERF_CNTR_OFFSET);
+	iowrite32(AES_ACTIVATE_PERF_CNTR,
+		  aes_dev->base_reg + AES_A_DMA_WHILE_ACTIVE_MODE_OFFSET);
+}
+
+/* Wait until PERF_CNTR is > delay, then deactivate it */
+static inline void aes_a_dma_wait_and_deactivate_perf_cntr(const struct ocs_aes_dev *aes_dev,
+							   int delay)
+{
+	while (ioread32(aes_dev->base_reg + AES_A_DMA_PERF_CNTR_OFFSET) < delay)
+		;
+	iowrite32(AES_DEACTIVATE_PERF_CNTR,
+		  aes_dev->base_reg + AES_A_DMA_WHILE_ACTIVE_MODE_OFFSET);
+}
+
+/* Disable AES and DMA IRQ. */
+static void aes_irq_disable(struct ocs_aes_dev *aes_dev)
+{
+	u32 isr_val = 0;
+
+	/* Disable interrupts */
+	iowrite32(AES_DISABLE_INT,
+		  aes_dev->base_reg + AES_A_DMA_MSI_IER_OFFSET);
+	iowrite32(AES_DISABLE_INT, aes_dev->base_reg + AES_IER_OFFSET);
+
+	/* Clear any pending interrupt */
+	isr_val = ioread32(aes_dev->base_reg + AES_A_DMA_MSI_ISR_OFFSET);
+	if (isr_val)
+		iowrite32(isr_val,
+			  aes_dev->base_reg + AES_A_DMA_MSI_ISR_OFFSET);
+
+	isr_val = ioread32(aes_dev->base_reg + AES_A_DMA_MSI_MASK_OFFSET);
+	if (isr_val)
+		iowrite32(isr_val,
+			  aes_dev->base_reg + AES_A_DMA_MSI_MASK_OFFSET);
+
+	isr_val = ioread32(aes_dev->base_reg + AES_ISR_OFFSET);
+	if (isr_val)
+		iowrite32(isr_val, aes_dev->base_reg + AES_ISR_OFFSET);
+}
+
+/* Enable AES or DMA IRQ.  IRQ is disabled once fired. */
+static void aes_irq_enable(struct ocs_aes_dev *aes_dev, u8 irq)
+{
+	if (irq == AES_COMPLETE_INT) {
+		/* Ensure DMA error interrupts are enabled */
+		iowrite32(AES_DMA_CPD_ERR_INT |
+			  AES_DMA_OUTBUF_RD_ERR_INT |
+			  AES_DMA_OUTBUF_WR_ERR_INT |
+			  AES_DMA_INBUF_RD_ERR_INT |
+			  AES_DMA_INBUF_WR_ERR_INT |
+			  AES_DMA_BAD_COMP_INT |
+			  AES_DMA_SAI_INT,
+			  aes_dev->base_reg + AES_A_DMA_MSI_IER_OFFSET);
+		/*
+		 * AES_IER
+		 * default 0x00000000
+		 * bits [31:3] - reserved
+		 * bit [2] - EN_SKS_ERR
+		 * bit [1] - EN_AES_COMPLETE
+		 * bit [0] - reserved
+		 */
+		iowrite32(AES_COMPLETE_INT, aes_dev->base_reg + AES_IER_OFFSET);
+		return;
+	}
+	if (irq == AES_DMA_SRC_DONE_INT) {
+		/* Ensure AES interrupts are disabled */
+		iowrite32(AES_DISABLE_INT, aes_dev->base_reg + AES_IER_OFFSET);
+		/*
+		 * DMA_MSI_IER
+		 * default 0x00000000
+		 * bits [31:9] - reserved
+		 * bit [8] - CPD_ERR_INT_EN
+		 * bit [7] - OUTBUF_RD_ERR_INT_EN
+		 * bit [6] - OUTBUF_WR_ERR_INT_EN
+		 * bit [5] - INBUF_RD_ERR_INT_EN
+		 * bit [4] - INBUF_WR_ERR_INT_EN
+		 * bit [3] - BAD_COMP_INT_EN
+		 * bit [2] - SAI_INT_EN
+		 * bit [1] - DST_DONE_INT_EN
+		 * bit [0] - SRC_DONE_INT_EN
+		 */
+		iowrite32(AES_DMA_CPD_ERR_INT |
+			  AES_DMA_OUTBUF_RD_ERR_INT |
+			  AES_DMA_OUTBUF_WR_ERR_INT |
+			  AES_DMA_INBUF_RD_ERR_INT |
+			  AES_DMA_INBUF_WR_ERR_INT |
+			  AES_DMA_BAD_COMP_INT |
+			  AES_DMA_SAI_INT |
+			  AES_DMA_SRC_DONE_INT,
+			  aes_dev->base_reg + AES_A_DMA_MSI_IER_OFFSET);
+	}
+}
+
+/* Enable and wait for IRQ (either from OCS AES engine or DMA) */
+static int ocs_aes_irq_enable_and_wait(struct ocs_aes_dev *aes_dev, u8 irq)
+{
+	int rc;
+
+	reinit_completion(&aes_dev->irq_completion);
+	aes_irq_enable(aes_dev, irq);
+	rc = wait_for_completion_interruptible(&aes_dev->irq_completion);
+	if (rc)
+		return rc;
+
+	return aes_dev->dma_err_mask ? -EIO : 0;
+}
+
+/* Configure DMA to OCS, linked list mode */
+static inline void dma_to_ocs_aes_ll(struct ocs_aes_dev *aes_dev,
+				     dma_addr_t dma_list)
+{
+	iowrite32(0, aes_dev->base_reg + AES_A_DMA_SRC_SIZE_OFFSET);
+	iowrite32(dma_list,
+		  aes_dev->base_reg + AES_A_DMA_NEXT_SRC_DESCR_OFFSET);
+}
+
+/* Configure DMA from OCS, linked list mode */
+static inline void dma_from_ocs_aes_ll(struct ocs_aes_dev *aes_dev,
+				       dma_addr_t dma_list)
+{
+	iowrite32(0, aes_dev->base_reg + AES_A_DMA_DST_SIZE_OFFSET);
+	iowrite32(dma_list,
+		  aes_dev->base_reg + AES_A_DMA_NEXT_DST_DESCR_OFFSET);
+}
+
+irqreturn_t ocs_aes_irq_handler(int irq, void *dev_id)
+{
+	struct ocs_aes_dev *aes_dev = dev_id;
+	u32 aes_dma_isr;
+
+	/* Read DMA ISR status. */
+	aes_dma_isr = ioread32(aes_dev->base_reg + AES_A_DMA_MSI_ISR_OFFSET);
+
+	/* Disable and clear interrupts. */
+	aes_irq_disable(aes_dev);
+
+	/* Save DMA error status. */
+	aes_dev->dma_err_mask = aes_dma_isr &
+				(AES_DMA_CPD_ERR_INT |
+				 AES_DMA_OUTBUF_RD_ERR_INT |
+				 AES_DMA_OUTBUF_WR_ERR_INT |
+				 AES_DMA_INBUF_RD_ERR_INT |
+				 AES_DMA_INBUF_WR_ERR_INT |
+				 AES_DMA_BAD_COMP_INT |
+				 AES_DMA_SAI_INT);
+
+	/* Signal IRQ completion. */
+	complete(&aes_dev->irq_completion);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * ocs_aes_set_key() - Write key into OCS AES hardware.
+ * @aes_dev:	The OCS AES device to write the key to.
+ * @key_size:	The size of the key (in bytes).
+ * @key:	The key to write.
+ * @cipher:	The cipher the key is for.
+ *
+ * For AES @key_size must be either 16 or 32. For SM4 @key_size must be 16.
+ *
+ * Return:	0 on success, negative error code otherwise.
+ */
+int ocs_aes_set_key(struct ocs_aes_dev *aes_dev, u32 key_size, const u8 *key,
+		    enum ocs_cipher cipher)
+{
+	const u32 *key_u32;
+	u32 val;
+	int i;
+
+	/* OCS AES supports 128-bit and 256-bit keys only. */
+	if (cipher == OCS_AES && !(key_size == 32 || key_size == 16)) {
+		dev_err(aes_dev->dev,
+			"%d-bit keys not supported by AES cipher\n",
+			key_size * 8);
+		return -EINVAL;
+	}
+	/* OCS SM4 supports 128-bit keys only. */
+	if (cipher == OCS_SM4 && key_size != 16) {
+		dev_err(aes_dev->dev,
+			"%d-bit keys not supported for SM4 cipher\n",
+			key_size * 8);
+		return -EINVAL;
+	}
+
+	if (!key)
+		return -EINVAL;
+
+	key_u32 = (const u32 *)key;
+
+	/* Write key to AES_KEY[0-7] registers */
+	for (i = 0; i < (key_size / sizeof(u32)); i++) {
+		iowrite32(key_u32[i],
+			  aes_dev->base_reg + AES_KEY_0_OFFSET +
+			  (i * sizeof(u32)));
+	}
+	/*
+	 * Write key size
+	 * bits [31:1] - reserved
+	 * bit [0] - AES_KEY_SIZE
+	 *           0 - 128 bit key
+	 *           1 - 256 bit key
+	 */
+	val = (key_size == 16) ? AES_128_BIT_KEY : AES_256_BIT_KEY;
+	iowrite32(val, aes_dev->base_reg + AES_KEY_SIZE_OFFSET);
+
+	return 0;
+}
+
+/* Write AES_COMMAND */
+static inline void set_ocs_aes_command(struct ocs_aes_dev *aes_dev,
+				       enum ocs_cipher cipher,
+				       enum ocs_mode mode,
+				       enum ocs_instruction instruction)
+{
+	u32 val;
+
+	/* AES_COMMAND
+	 * default 0x000000CC
+	 * bit [14] - CIPHER_SELECT
+	 *            0 - AES
+	 *            1 - SM4
+	 * bits [11:8] - OCS_AES_MODE
+	 *               0000 - ECB
+	 *               0001 - CBC
+	 *               0010 - CTR
+	 *               0110 - CCM
+	 *               0111 - GCM
+	 *               1001 - CTS
+	 * bits [7:6] - AES_INSTRUCTION
+	 *              00 - ENCRYPT
+	 *              01 - DECRYPT
+	 *              10 - EXPAND
+	 *              11 - BYPASS
+	 * bits [3:2] - CTR_M_BITS
+	 *              00 - No increment
+	 *              01 - Least significant 32 bits are incremented
+	 *              10 - Least significant 64 bits are incremented
+	 *              11 - Full 128 bits are incremented
+	 */
+	val = (cipher << 14) | (mode << 8) | (instruction << 6) |
+	      (AES_CTR_M_128_INC << 2);
+	iowrite32(val, aes_dev->base_reg + AES_COMMAND_OFFSET);
+}
+
+static void ocs_aes_init(struct ocs_aes_dev *aes_dev,
+			 enum ocs_mode mode,
+			 enum ocs_cipher cipher,
+			 enum ocs_instruction instruction)
+{
+	/* Ensure interrupts are disabled and pending interrupts cleared. */
+	aes_irq_disable(aes_dev);
+
+	/* Set endianness recommended by data-sheet. */
+	aes_a_set_endianness(aes_dev);
+
+	/* Set AES_COMMAND register. */
+	set_ocs_aes_command(aes_dev, cipher, mode, instruction);
+}
+
+/*
+ * Write the byte length of the last AES/SM4 block of Payload data (without
+ * zero padding and without the length of the MAC) in register AES_PLEN.
+ */
+static inline void ocs_aes_write_last_data_blk_len(struct ocs_aes_dev *aes_dev,
+						   u32 size)
+{
+	u32 val;
+
+	if (size == 0) {
+		val = 0;
+		goto exit;
+	}
+
+	val = size % AES_BLOCK_SIZE;
+	if (val == 0)
+		val = AES_BLOCK_SIZE;
+
+exit:
+	iowrite32(val, aes_dev->base_reg + AES_PLEN_OFFSET);
+}
+
+/*
+ * Validate inputs according to mode.
+ * If OK return 0; else return -EINVAL.
+ */
+static int ocs_aes_validate_inputs(dma_addr_t src_dma_list, u32 src_size,
+				   const u8 *iv, u32 iv_size,
+				   dma_addr_t aad_dma_list, u32 aad_size,
+				   const u8 *tag, u32 tag_size,
+				   enum ocs_cipher cipher, enum ocs_mode mode,
+				   enum ocs_instruction instruction,
+				   dma_addr_t dst_dma_list)
+{
+	/* Ensure cipher, mode and instruction are valid. */
+	if (!(cipher == OCS_AES || cipher == OCS_SM4))
+		return -EINVAL;
+
+	if (mode != OCS_MODE_ECB && mode != OCS_MODE_CBC &&
+	    mode != OCS_MODE_CTR && mode != OCS_MODE_CCM &&
+	    mode != OCS_MODE_GCM && mode != OCS_MODE_CTS)
+		return -EINVAL;
+
+	if (instruction != OCS_ENCRYPT && instruction != OCS_DECRYPT &&
+	    instruction != OCS_EXPAND  && instruction != OCS_BYPASS)
+		return -EINVAL;
+
+	/*
+	 * When instruction is OCS_BYPASS, OCS simply copies data from source
+	 * to destination using DMA.
+	 *
+	 * AES mode is irrelevant, but both source and destination DMA
+	 * linked-list must be defined.
+	 */
+	if (instruction == OCS_BYPASS) {
+		if (src_dma_list == DMA_MAPPING_ERROR ||
+		    dst_dma_list == DMA_MAPPING_ERROR)
+			return -EINVAL;
+
+		return 0;
+	}
+
+	/*
+	 * For performance reasons switch based on mode to limit unnecessary
+	 * conditionals for each mode
+	 */
+	switch (mode) {
+	case OCS_MODE_ECB:
+		/* Ensure input length is multiple of block size */
+		if (src_size % AES_BLOCK_SIZE != 0)
+			return -EINVAL;
+
+		/* Ensure source and destination linked lists are created */
+		if (src_dma_list == DMA_MAPPING_ERROR ||
+		    dst_dma_list == DMA_MAPPING_ERROR)
+			return -EINVAL;
+
+		return 0;
+
+	case OCS_MODE_CBC:
+		/* Ensure input length is multiple of block size */
+		if (src_size % AES_BLOCK_SIZE != 0)
+			return -EINVAL;
+
+		/* Ensure source and destination linked lists are created */
+		if (src_dma_list == DMA_MAPPING_ERROR ||
+		    dst_dma_list == DMA_MAPPING_ERROR)
+			return -EINVAL;
+
+		/* Ensure IV is present and block size in length */
+		if (!iv || iv_size != AES_BLOCK_SIZE)
+			return -EINVAL;
+
+		return 0;
+
+	case OCS_MODE_CTR:
+		/* Ensure input length of 1 byte or greater */
+		if (src_size == 0)
+			return -EINVAL;
+
+		/* Ensure source and destination linked lists are created */
+		if (src_dma_list == DMA_MAPPING_ERROR ||
+		    dst_dma_list == DMA_MAPPING_ERROR)
+			return -EINVAL;
+
+		/* Ensure IV is present and block size in length */
+		if (!iv || iv_size != AES_BLOCK_SIZE)
+			return -EINVAL;
+
+		return 0;
+
+	case OCS_MODE_CTS:
+		/* Ensure input length >= block size */
+		if (src_size < AES_BLOCK_SIZE)
+			return -EINVAL;
+
+		/* Ensure source and destination linked lists are created */
+		if (src_dma_list == DMA_MAPPING_ERROR ||
+		    dst_dma_list == DMA_MAPPING_ERROR)
+			return -EINVAL;
+
+		/* Ensure IV is present and block size in length */
+		if (!iv || iv_size != AES_BLOCK_SIZE)
+			return -EINVAL;
+
+		return 0;
+
+	case OCS_MODE_GCM:
+		/* Ensure IV is present and GCM_AES_IV_SIZE in length */
+		if (!iv || iv_size != GCM_AES_IV_SIZE)
+			return -EINVAL;
+
+		/*
+		 * If input data present ensure source and destination linked
+		 * lists are created
+		 */
+		if (src_size && (src_dma_list == DMA_MAPPING_ERROR ||
+				 dst_dma_list == DMA_MAPPING_ERROR))
+			return -EINVAL;
+
+		/* If aad present ensure aad linked list is created */
+		if (aad_size && aad_dma_list == DMA_MAPPING_ERROR)
+			return -EINVAL;
+
+		/* Ensure tag destination is set */
+		if (!tag)
+			return -EINVAL;
+
+		/* Just ensure that tag_size doesn't cause overflows. */
+		if (tag_size > (AES_MAX_TAG_SIZE_U32 * sizeof(u32)))
+			return -EINVAL;
+
+		return 0;
+
+	case OCS_MODE_CCM:
+		/* Ensure IV is present and block size in length */
+		if (!iv || iv_size != AES_BLOCK_SIZE)
+			return -EINVAL;
+
+		/* 2 <= L <= 8, so 1 <= L' <= 7 */
+		if (iv[L_PRIME_IDX] < L_PRIME_MIN ||
+		    iv[L_PRIME_IDX] > L_PRIME_MAX)
+			return -EINVAL;
+
+		/* If aad present ensure aad linked list is created */
+		if (aad_size && aad_dma_list == DMA_MAPPING_ERROR)
+			return -EINVAL;
+
+		/* Just ensure that tag_size doesn't cause overflows. */
+		if (tag_size > (AES_MAX_TAG_SIZE_U32 * sizeof(u32)))
+			return -EINVAL;
+
+		if (instruction == OCS_DECRYPT) {
+			/*
+			 * If input data present ensure source and destination
+			 * linked lists are created
+			 */
+			if (src_size && (src_dma_list == DMA_MAPPING_ERROR ||
+					 dst_dma_list == DMA_MAPPING_ERROR))
+				return -EINVAL;
+
+			/* Ensure input tag is present */
+			if (!tag)
+				return -EINVAL;
+
+			return 0;
+		}
+
+		/* Instruction == OCS_ENCRYPT */
+
+		/*
+		 * Destination linked list always required (for tag even if no
+		 * input data)
+		 */
+		if (dst_dma_list == DMA_MAPPING_ERROR)
+			return -EINVAL;
+
+		/* If input data present ensure src linked list is created */
+		if (src_size && src_dma_list == DMA_MAPPING_ERROR)
+			return -EINVAL;
+
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+/**
+ * ocs_aes_op() - Perform AES/SM4 operation.
+ * @aes_dev:		The OCS AES device to use.
+ * @mode:		The mode to use (ECB, CBC, CTR, or CTS).
+ * @cipher:		The cipher to use (AES or SM4).
+ * @instruction:	The instruction to perform (encrypt or decrypt).
+ * @dst_dma_list:	The OCS DMA list mapping output memory.
+ * @src_dma_list:	The OCS DMA list mapping input payload data.
+ * @src_size:		The amount of data mapped by @src_dma_list.
+ * @iv:			The IV vector.
+ * @iv_size:		The size (in bytes) of @iv.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int ocs_aes_op(struct ocs_aes_dev *aes_dev,
+	       enum ocs_mode mode,
+	       enum ocs_cipher cipher,
+	       enum ocs_instruction instruction,
+	       dma_addr_t dst_dma_list,
+	       dma_addr_t src_dma_list,
+	       u32 src_size,
+	       u8 *iv,
+	       u32 iv_size)
+{
+	u32 *iv32;
+	int rc;
+
+	rc = ocs_aes_validate_inputs(src_dma_list, src_size, iv, iv_size, 0, 0,
+				     NULL, 0, cipher, mode, instruction,
+				     dst_dma_list);
+	if (rc)
+		return rc;
+	/*
+	 * ocs_aes_validate_inputs() is a generic check, now ensure mode is not
+	 * GCM or CCM.
+	 */
+	if (mode == OCS_MODE_GCM || mode == OCS_MODE_CCM)
+		return -EINVAL;
+
+	/* Cast IV to u32 array. */
+	iv32 = (u32 *)iv;
+
+	ocs_aes_init(aes_dev, mode, cipher, instruction);
+
+	if (mode == OCS_MODE_CTS) {
+		/* Write the byte length of the last data block to engine. */
+		ocs_aes_write_last_data_blk_len(aes_dev, src_size);
+	}
+
+	/* ECB is the only mode that doesn't use IV. */
+	if (mode != OCS_MODE_ECB) {
+		iowrite32(iv32[0], aes_dev->base_reg + AES_IV_0_OFFSET);
+		iowrite32(iv32[1], aes_dev->base_reg + AES_IV_1_OFFSET);
+		iowrite32(iv32[2], aes_dev->base_reg + AES_IV_2_OFFSET);
+		iowrite32(iv32[3], aes_dev->base_reg + AES_IV_3_OFFSET);
+	}
+
+	/* Set AES_ACTIVE.TRIGGER to start the operation. */
+	aes_a_op_trigger(aes_dev);
+
+	/* Configure and activate input / output DMA. */
+	dma_to_ocs_aes_ll(aes_dev, src_dma_list);
+	dma_from_ocs_aes_ll(aes_dev, dst_dma_list);
+	aes_a_dma_active_src_dst_ll_en(aes_dev);
+
+	if (mode == OCS_MODE_CTS) {
+		/*
+		 * For CTS mode, instruct engine to activate ciphertext
+		 * stealing if last block of data is incomplete.
+		 */
+		aes_a_set_last_gcx(aes_dev);
+	} else {
+		/* For all other modes, just write the 'termination' bit. */
+		aes_a_op_termination(aes_dev);
+	}
+
+	/* Wait for engine to complete processing. */
+	rc = ocs_aes_irq_enable_and_wait(aes_dev, AES_COMPLETE_INT);
+	if (rc)
+		return rc;
+
+	if (mode == OCS_MODE_CTR) {
+		/* Read back IV for streaming mode */
+		iv32[0] = ioread32(aes_dev->base_reg + AES_IV_0_OFFSET);
+		iv32[1] = ioread32(aes_dev->base_reg + AES_IV_1_OFFSET);
+		iv32[2] = ioread32(aes_dev->base_reg + AES_IV_2_OFFSET);
+		iv32[3] = ioread32(aes_dev->base_reg + AES_IV_3_OFFSET);
+	}
+
+	return 0;
+}
+
+/* Compute and write J0 to engine registers. */
+static void ocs_aes_gcm_write_j0(const struct ocs_aes_dev *aes_dev,
+				 const u8 *iv)
+{
+	const u32 *j0 = (u32 *)iv;
+
+	/*
+	 * IV must be 12 bytes; Other sizes not supported as Linux crypto API
+	 * does only expects/allows 12 byte IV for GCM
+	 */
+	iowrite32(0x00000001, aes_dev->base_reg + AES_IV_0_OFFSET);
+	iowrite32(__swab32(j0[2]), aes_dev->base_reg + AES_IV_1_OFFSET);
+	iowrite32(__swab32(j0[1]), aes_dev->base_reg + AES_IV_2_OFFSET);
+	iowrite32(__swab32(j0[0]), aes_dev->base_reg + AES_IV_3_OFFSET);
+}
+
+/* Read GCM tag from engine registers. */
+static inline void ocs_aes_gcm_read_tag(struct ocs_aes_dev *aes_dev,
+					u8 *tag, u32 tag_size)
+{
+	u32 tag_u32[AES_MAX_TAG_SIZE_U32];
+
+	/*
+	 * The Authentication Tag T is stored in Little Endian order in the
+	 * registers with the most significant bytes stored from AES_T_MAC[3]
+	 * downward.
+	 */
+	tag_u32[0] = __swab32(ioread32(aes_dev->base_reg + AES_T_MAC_3_OFFSET));
+	tag_u32[1] = __swab32(ioread32(aes_dev->base_reg + AES_T_MAC_2_OFFSET));
+	tag_u32[2] = __swab32(ioread32(aes_dev->base_reg + AES_T_MAC_1_OFFSET));
+	tag_u32[3] = __swab32(ioread32(aes_dev->base_reg + AES_T_MAC_0_OFFSET));
+
+	memcpy(tag, tag_u32, tag_size);
+}
+
+/**
+ * ocs_aes_gcm_op() - Perform GCM operation.
+ * @aes_dev:		The OCS AES device to use.
+ * @cipher:		The Cipher to use (AES or SM4).
+ * @instruction:	The instruction to perform (encrypt or decrypt).
+ * @dst_dma_list:	The OCS DMA list mapping output memory.
+ * @src_dma_list:	The OCS DMA list mapping input payload data.
+ * @src_size:		The amount of data mapped by @src_dma_list.
+ * @iv:			The input IV vector.
+ * @aad_dma_list:	The OCS DMA list mapping input AAD data.
+ * @aad_size:		The amount of data mapped by @aad_dma_list.
+ * @out_tag:		Where to store computed tag.
+ * @tag_size:		The size (in bytes) of @out_tag.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int ocs_aes_gcm_op(struct ocs_aes_dev *aes_dev,
+		   enum ocs_cipher cipher,
+		   enum ocs_instruction instruction,
+		   dma_addr_t dst_dma_list,
+		   dma_addr_t src_dma_list,
+		   u32 src_size,
+		   const u8 *iv,
+		   dma_addr_t aad_dma_list,
+		   u32 aad_size,
+		   u8 *out_tag,
+		   u32 tag_size)
+{
+	u64 bit_len;
+	u32 val;
+	int rc;
+
+	rc = ocs_aes_validate_inputs(src_dma_list, src_size, iv,
+				     GCM_AES_IV_SIZE, aad_dma_list,
+				     aad_size, out_tag, tag_size, cipher,
+				     OCS_MODE_GCM, instruction,
+				     dst_dma_list);
+	if (rc)
+		return rc;
+
+	ocs_aes_init(aes_dev, OCS_MODE_GCM, cipher, instruction);
+
+	/* Compute and write J0 to OCS HW. */
+	ocs_aes_gcm_write_j0(aes_dev, iv);
+
+	/* Write out_tag byte length */
+	iowrite32(tag_size, aes_dev->base_reg + AES_TLEN_OFFSET);
+
+	/* Write the byte length of the last plaintext / ciphertext block. */
+	ocs_aes_write_last_data_blk_len(aes_dev, src_size);
+
+	/* Write ciphertext bit length */
+	bit_len = src_size * 8;
+	val = bit_len & 0xFFFFFFFF;
+	iowrite32(val, aes_dev->base_reg + AES_MULTIPURPOSE2_0_OFFSET);
+	val = bit_len >> 32;
+	iowrite32(val, aes_dev->base_reg + AES_MULTIPURPOSE2_1_OFFSET);
+
+	/* Write aad bit length */
+	bit_len = aad_size * 8;
+	val = bit_len & 0xFFFFFFFF;
+	iowrite32(val, aes_dev->base_reg + AES_MULTIPURPOSE2_2_OFFSET);
+	val = bit_len >> 32;
+	iowrite32(val, aes_dev->base_reg + AES_MULTIPURPOSE2_3_OFFSET);
+
+	/* Set AES_ACTIVE.TRIGGER to start the operation. */
+	aes_a_op_trigger(aes_dev);
+
+	/* Process AAD. */
+	if (aad_size) {
+		/* If aad present, configure DMA to feed it to the engine. */
+		dma_to_ocs_aes_ll(aes_dev, aad_dma_list);
+		aes_a_dma_active_src_ll_en(aes_dev);
+
+		/* Instructs engine to pad last block of aad, if needed. */
+		aes_a_set_last_gcx_and_adata(aes_dev);
+
+		/* Wait for DMA transfer to complete. */
+		rc = ocs_aes_irq_enable_and_wait(aes_dev, AES_DMA_SRC_DONE_INT);
+		if (rc)
+			return rc;
+	} else {
+		aes_a_set_last_gcx_and_adata(aes_dev);
+	}
+
+	/* Wait until adata (if present) has been processed. */
+	aes_a_wait_last_gcx(aes_dev);
+	aes_a_dma_wait_input_buffer_occupancy(aes_dev);
+
+	/* Now process payload. */
+	if (src_size) {
+		/* Configure and activate DMA for both input and output data. */
+		dma_to_ocs_aes_ll(aes_dev, src_dma_list);
+		dma_from_ocs_aes_ll(aes_dev, dst_dma_list);
+		aes_a_dma_active_src_dst_ll_en(aes_dev);
+	} else {
+		aes_a_dma_set_xfer_size_zero(aes_dev);
+		aes_a_dma_active(aes_dev);
+	}
+
+	/* Instruct AES/SMA4 engine payload processing is over. */
+	aes_a_set_last_gcx(aes_dev);
+
+	/* Wait for OCS AES engine to complete processing. */
+	rc = ocs_aes_irq_enable_and_wait(aes_dev, AES_COMPLETE_INT);
+	if (rc)
+		return rc;
+
+	ocs_aes_gcm_read_tag(aes_dev, out_tag, tag_size);
+
+	return 0;
+}
+
+/* Write encrypted tag to AES/SM4 engine. */
+static void ocs_aes_ccm_write_encrypted_tag(struct ocs_aes_dev *aes_dev,
+					    const u8 *in_tag, u32 tag_size)
+{
+	int i;
+
+	/* Ensure DMA input buffer is empty */
+	aes_a_dma_wait_input_buffer_occupancy(aes_dev);
+
+	/*
+	 * During CCM decrypt, the OCS block needs to finish processing the
+	 * ciphertext before the tag is written.  So delay needed after DMA has
+	 * completed writing the ciphertext
+	 */
+	aes_a_dma_reset_and_activate_perf_cntr(aes_dev);
+	aes_a_dma_wait_and_deactivate_perf_cntr(aes_dev,
+						CCM_DECRYPT_DELAY_TAG_CLK_COUNT);
+
+	/* Write encrypted tag to AES/SM4 engine. */
+	for (i = 0; i < tag_size; i++) {
+		iowrite8(in_tag[i], aes_dev->base_reg +
+				    AES_A_DMA_INBUFFER_WRITE_FIFO_OFFSET);
+	}
+}
+
+/*
+ * Write B0 CCM block to OCS AES HW.
+ *
+ * Note: B0 format is documented in NIST Special Publication 800-38C
+ * https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-38c.pdf
+ * (see Section A.2.1)
+ */
+static int ocs_aes_ccm_write_b0(const struct ocs_aes_dev *aes_dev,
+				const u8 *iv, u32 adata_size, u32 tag_size,
+				u32 cryptlen)
+{
+	u8 b0[16]; /* CCM B0 block is 16 bytes long. */
+	int i, q;
+
+	/* Initialize B0 to 0. */
+	memset(b0, 0, sizeof(b0));
+
+	/*
+	 * B0[0] is the 'Flags Octet' and has the following structure:
+	 *   bit 7: Reserved
+	 *   bit 6: Adata flag
+	 *   bit 5-3: t value encoded as (t-2)/2
+	 *   bit 2-0: q value encoded as q - 1
+	 */
+	/* If there is AAD data, set the Adata flag. */
+	if (adata_size)
+		b0[0] |= BIT(6);
+	/*
+	 * t denotes the octet length of T.
+	 * t can only be an element of { 4, 6, 8, 10, 12, 14, 16} and is
+	 * encoded as (t - 2) / 2
+	 */
+	b0[0] |= (((tag_size - 2) / 2) & 0x7)  << 3;
+	/*
+	 * q is the octet length of Q.
+	 * q can only be an element of {2, 3, 4, 5, 6, 7, 8} and is encoded as
+	 * q - 1 == iv[0]
+	 */
+	b0[0] |= iv[0] & 0x7;
+	/*
+	 * Copy the Nonce N from IV to B0; N is located in iv[1]..iv[15 - q]
+	 * and must be copied to b0[1]..b0[15-q].
+	 * q == iv[0] + 1
+	 */
+	q = iv[0] + 1;
+	for (i = 1; i <= 15 - q; i++)
+		b0[i] = iv[i];
+	/*
+	 * The rest of B0 must contain Q, i.e., the message length.
+	 * Q is encoded in q octets, in big-endian order, so to write it, we
+	 * start from the end of B0 and we move backward.
+	 */
+	i = sizeof(b0) - 1;
+	while (q) {
+		b0[i] = cryptlen & 0xff;
+		cryptlen >>= 8;
+		i--;
+		q--;
+	}
+	/*
+	 * If cryptlen is not zero at this point, it means that its original
+	 * value was too big.
+	 */
+	if (cryptlen)
+		return -EOVERFLOW;
+	/* Now write B0 to OCS AES input buffer. */
+	for (i = 0; i < sizeof(b0); i++)
+		iowrite8(b0[i], aes_dev->base_reg +
+				AES_A_DMA_INBUFFER_WRITE_FIFO_OFFSET);
+	return 0;
+}
+
+/*
+ * Write adata length to OCS AES HW.
+ *
+ * Note: adata len encoding is documented in NIST Special Publication 800-38C
+ * https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-38c.pdf
+ * (see Section A.2.2)
+ */
+static void ocs_aes_ccm_write_adata_len(const struct ocs_aes_dev *aes_dev,
+					u64 adata_len)
+{
+	u8 enc_a[10]; /* Maximum encoded size: 10 octets. */
+	int i, len;
+
+	/*
+	 * adata_len ('a') is encoded as follows:
+	 * If 0 < a < 2^16 - 2^8    ==> 'a' encoded as [a]16, i.e., two octets
+	 *				(big endian).
+	 * If 2^16 - 2^8 ≤ a < 2^32 ==> 'a' encoded as 0xff || 0xfe || [a]32,
+	 *				i.e., six octets (big endian).
+	 * If 2^32 ≤ a < 2^64       ==> 'a' encoded as 0xff || 0xff || [a]64,
+	 *				i.e., ten octets (big endian).
+	 */
+	if (adata_len < 65280) {
+		len = 2;
+		*(__be16 *)enc_a = cpu_to_be16(adata_len);
+	} else if (adata_len <= 0xFFFFFFFF) {
+		len = 6;
+		*(__be16 *)enc_a = cpu_to_be16(0xfffe);
+		*(__be32 *)&enc_a[2] = cpu_to_be32(adata_len);
+	} else { /* adata_len >= 2^32 */
+		len = 10;
+		*(__be16 *)enc_a = cpu_to_be16(0xffff);
+		*(__be64 *)&enc_a[2] = cpu_to_be64(adata_len);
+	}
+	for (i = 0; i < len; i++)
+		iowrite8(enc_a[i],
+			 aes_dev->base_reg +
+			 AES_A_DMA_INBUFFER_WRITE_FIFO_OFFSET);
+}
+
+static int ocs_aes_ccm_do_adata(struct ocs_aes_dev *aes_dev,
+				dma_addr_t adata_dma_list, u32 adata_size)
+{
+	int rc;
+
+	if (!adata_size) {
+		/* Since no aad the LAST_GCX bit can be set now */
+		aes_a_set_last_gcx_and_adata(aes_dev);
+		goto exit;
+	}
+
+	/* Adata case. */
+
+	/*
+	 * Form the encoding of the Associated data length and write it
+	 * to the AES/SM4 input buffer.
+	 */
+	ocs_aes_ccm_write_adata_len(aes_dev, adata_size);
+
+	/* Configure the AES/SM4 DMA to fetch the Associated Data */
+	dma_to_ocs_aes_ll(aes_dev, adata_dma_list);
+
+	/* Activate DMA to fetch Associated data. */
+	aes_a_dma_active_src_ll_en(aes_dev);
+
+	/* Set LAST_GCX and LAST_ADATA in AES ACTIVE register. */
+	aes_a_set_last_gcx_and_adata(aes_dev);
+
+	/* Wait for DMA transfer to complete. */
+	rc = ocs_aes_irq_enable_and_wait(aes_dev, AES_DMA_SRC_DONE_INT);
+	if (rc)
+		return rc;
+
+exit:
+	/* Wait until adata (if present) has been processed. */
+	aes_a_wait_last_gcx(aes_dev);
+	aes_a_dma_wait_input_buffer_occupancy(aes_dev);
+
+	return 0;
+}
+
+static int ocs_aes_ccm_encrypt_do_payload(struct ocs_aes_dev *aes_dev,
+					  dma_addr_t dst_dma_list,
+					  dma_addr_t src_dma_list,
+					  u32 src_size)
+{
+	if (src_size) {
+		/*
+		 * Configure and activate DMA for both input and output
+		 * data.
+		 */
+		dma_to_ocs_aes_ll(aes_dev, src_dma_list);
+		dma_from_ocs_aes_ll(aes_dev, dst_dma_list);
+		aes_a_dma_active_src_dst_ll_en(aes_dev);
+	} else {
+		/* Configure and activate DMA for output data only. */
+		dma_from_ocs_aes_ll(aes_dev, dst_dma_list);
+		aes_a_dma_active_dst_ll_en(aes_dev);
+	}
+
+	/*
+	 * Set the LAST GCX bit in AES_ACTIVE Register to instruct
+	 * AES/SM4 engine to pad the last block of data.
+	 */
+	aes_a_set_last_gcx(aes_dev);
+
+	/* We are done, wait for IRQ and return. */
+	return ocs_aes_irq_enable_and_wait(aes_dev, AES_COMPLETE_INT);
+}
+
+static int ocs_aes_ccm_decrypt_do_payload(struct ocs_aes_dev *aes_dev,
+					  dma_addr_t dst_dma_list,
+					  dma_addr_t src_dma_list,
+					  u32 src_size)
+{
+	if (!src_size) {
+		/* Let engine process 0-length input. */
+		aes_a_dma_set_xfer_size_zero(aes_dev);
+		aes_a_dma_active(aes_dev);
+		aes_a_set_last_gcx(aes_dev);
+
+		return 0;
+	}
+
+	/*
+	 * Configure and activate DMA for both input and output
+	 * data.
+	 */
+	dma_to_ocs_aes_ll(aes_dev, src_dma_list);
+	dma_from_ocs_aes_ll(aes_dev, dst_dma_list);
+	aes_a_dma_active_src_dst_ll_en(aes_dev);
+	/*
+	 * Set the LAST GCX bit in AES_ACTIVE Register; this allows the
+	 * AES/SM4 engine to differentiate between encrypted data and
+	 * encrypted MAC.
+	 */
+	aes_a_set_last_gcx(aes_dev);
+	 /*
+	  * Enable DMA DONE interrupt; once DMA transfer is over,
+	  * interrupt handler will process the MAC/tag.
+	  */
+	return ocs_aes_irq_enable_and_wait(aes_dev, AES_DMA_SRC_DONE_INT);
+}
+
+/*
+ * Compare Tag to Yr.
+ *
+ * Only used at the end of CCM decrypt. If tag == yr, message authentication
+ * has succeeded.
+ */
+static inline int ccm_compare_tag_to_yr(struct ocs_aes_dev *aes_dev,
+					u8 tag_size_bytes)
+{
+	u32 tag[AES_MAX_TAG_SIZE_U32];
+	u32 yr[AES_MAX_TAG_SIZE_U32];
+	u8 i;
+
+	/* Read Tag and Yr from AES registers. */
+	for (i = 0; i < AES_MAX_TAG_SIZE_U32; i++) {
+		tag[i] = ioread32(aes_dev->base_reg +
+				  AES_T_MAC_0_OFFSET + (i * sizeof(u32)));
+		yr[i] = ioread32(aes_dev->base_reg +
+				 AES_MULTIPURPOSE2_0_OFFSET +
+				 (i * sizeof(u32)));
+	}
+
+	return memcmp(tag, yr, tag_size_bytes) ? -EBADMSG : 0;
+}
+
+/**
+ * ocs_aes_ccm_op() - Perform CCM operation.
+ * @aes_dev:		The OCS AES device to use.
+ * @cipher:		The Cipher to use (AES or SM4).
+ * @instruction:	The instruction to perform (encrypt or decrypt).
+ * @dst_dma_list:	The OCS DMA list mapping output memory.
+ * @src_dma_list:	The OCS DMA list mapping input payload data.
+ * @src_size:		The amount of data mapped by @src_dma_list.
+ * @iv:			The input IV vector.
+ * @adata_dma_list:	The OCS DMA list mapping input A-data.
+ * @adata_size:		The amount of data mapped by @adata_dma_list.
+ * @in_tag:		Input tag.
+ * @tag_size:		The size (in bytes) of @in_tag.
+ *
+ * Note: for encrypt the tag is appended to the ciphertext (in the memory
+ *	 mapped by @dst_dma_list).
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int ocs_aes_ccm_op(struct ocs_aes_dev *aes_dev,
+		   enum ocs_cipher cipher,
+		   enum ocs_instruction instruction,
+		   dma_addr_t dst_dma_list,
+		   dma_addr_t src_dma_list,
+		   u32 src_size,
+		   u8 *iv,
+		   dma_addr_t adata_dma_list,
+		   u32 adata_size,
+		   u8 *in_tag,
+		   u32 tag_size)
+{
+	u32 *iv_32;
+	u8 lprime;
+	int rc;
+
+	rc = ocs_aes_validate_inputs(src_dma_list, src_size, iv,
+				     AES_BLOCK_SIZE, adata_dma_list, adata_size,
+				     in_tag, tag_size, cipher, OCS_MODE_CCM,
+				     instruction, dst_dma_list);
+	if (rc)
+		return rc;
+
+	ocs_aes_init(aes_dev, OCS_MODE_CCM, cipher, instruction);
+
+	/*
+	 * Note: rfc 3610 and NIST 800-38C require counter of zero to encrypt
+	 * auth tag so ensure this is the case
+	 */
+	lprime = iv[L_PRIME_IDX];
+	memset(&iv[COUNTER_START(lprime)], 0, COUNTER_LEN(lprime));
+
+	/*
+	 * Nonce is already converted to ctr0 before being passed into this
+	 * function as iv.
+	 */
+	iv_32 = (u32 *)iv;
+	iowrite32(__swab32(iv_32[0]),
+		  aes_dev->base_reg + AES_MULTIPURPOSE1_3_OFFSET);
+	iowrite32(__swab32(iv_32[1]),
+		  aes_dev->base_reg + AES_MULTIPURPOSE1_2_OFFSET);
+	iowrite32(__swab32(iv_32[2]),
+		  aes_dev->base_reg + AES_MULTIPURPOSE1_1_OFFSET);
+	iowrite32(__swab32(iv_32[3]),
+		  aes_dev->base_reg + AES_MULTIPURPOSE1_0_OFFSET);
+
+	/* Write MAC/tag length in register AES_TLEN */
+	iowrite32(tag_size, aes_dev->base_reg + AES_TLEN_OFFSET);
+	/*
+	 * Write the byte length of the last AES/SM4 block of Payload data
+	 * (without zero padding and without the length of the MAC) in register
+	 * AES_PLEN.
+	 */
+	ocs_aes_write_last_data_blk_len(aes_dev, src_size);
+
+	/* Set AES_ACTIVE.TRIGGER to start the operation. */
+	aes_a_op_trigger(aes_dev);
+
+	aes_a_dma_reset_and_activate_perf_cntr(aes_dev);
+
+	/* Form block B0 and write it to the AES/SM4 input buffer. */
+	rc = ocs_aes_ccm_write_b0(aes_dev, iv, adata_size, tag_size, src_size);
+	if (rc)
+		return rc;
+	/*
+	 * Ensure there has been at least CCM_DECRYPT_DELAY_LAST_GCX_CLK_COUNT
+	 * clock cycles since TRIGGER bit was set
+	 */
+	aes_a_dma_wait_and_deactivate_perf_cntr(aes_dev,
+						CCM_DECRYPT_DELAY_LAST_GCX_CLK_COUNT);
+
+	/* Process Adata. */
+	ocs_aes_ccm_do_adata(aes_dev, adata_dma_list, adata_size);
+
+	/* For Encrypt case we just process the payload and return. */
+	if (instruction == OCS_ENCRYPT) {
+		return ocs_aes_ccm_encrypt_do_payload(aes_dev, dst_dma_list,
+						      src_dma_list, src_size);
+	}
+	/* For Decypt we need to process the payload and then the tag. */
+	rc = ocs_aes_ccm_decrypt_do_payload(aes_dev, dst_dma_list,
+					    src_dma_list, src_size);
+	if (rc)
+		return rc;
+
+	/* Process MAC/tag directly: feed tag to engine and wait for IRQ. */
+	ocs_aes_ccm_write_encrypted_tag(aes_dev, in_tag, tag_size);
+	rc = ocs_aes_irq_enable_and_wait(aes_dev, AES_COMPLETE_INT);
+	if (rc)
+		return rc;
+
+	return ccm_compare_tag_to_yr(aes_dev, tag_size);
+}
+
+/**
+ * ocs_create_linked_list_from_sg() - Create OCS DMA linked list from SG list.
+ * @aes_dev:	  The OCS AES device the list will be created for.
+ * @sg:		  The SG list OCS DMA linked list will be created from. When
+ *		  passed to this function, @sg must have been already mapped
+ *		  with dma_map_sg().
+ * @sg_dma_count: The number of DMA-mapped entries in @sg. This must be the
+ *		  value returned by dma_map_sg() when @sg was mapped.
+ * @dll_desc:	  The OCS DMA dma_list to use to store information about the
+ *		  created linked list.
+ * @data_size:	  The size of the data (from the SG list) to be mapped into the
+ *		  OCS DMA linked list.
+ * @data_offset:  The offset (within the SG list) of the data to be mapped.
+ *
+ * Return:	0 on success, negative error code otherwise.
+ */
+int ocs_create_linked_list_from_sg(const struct ocs_aes_dev *aes_dev,
+				   struct scatterlist *sg,
+				   int sg_dma_count,
+				   struct ocs_dll_desc *dll_desc,
+				   size_t data_size, size_t data_offset)
+{
+	struct ocs_dma_linked_list *ll = NULL;
+	struct scatterlist *sg_tmp;
+	unsigned int tmp;
+	int dma_nents;
+	int i;
+
+	if (!dll_desc || !sg || !aes_dev)
+		return -EINVAL;
+
+	/* Default values for when no ddl_desc is created. */
+	dll_desc->vaddr = NULL;
+	dll_desc->dma_addr = DMA_MAPPING_ERROR;
+	dll_desc->size = 0;
+
+	if (data_size == 0)
+		return 0;
+
+	/* Loop over sg_list until we reach entry at specified offset. */
+	while (data_offset >= sg_dma_len(sg)) {
+		data_offset -= sg_dma_len(sg);
+		sg_dma_count--;
+		sg = sg_next(sg);
+		/* If we reach the end of the list, offset was invalid. */
+		if (!sg || sg_dma_count == 0)
+			return -EINVAL;
+	}
+
+	/* Compute number of DMA-mapped SG entries to add into OCS DMA list. */
+	dma_nents = 0;
+	tmp = 0;
+	sg_tmp = sg;
+	while (tmp < data_offset + data_size) {
+		/* If we reach the end of the list, data_size was invalid. */
+		if (!sg_tmp)
+			return -EINVAL;
+		tmp += sg_dma_len(sg_tmp);
+		dma_nents++;
+		sg_tmp = sg_next(sg_tmp);
+	}
+	if (dma_nents > sg_dma_count)
+		return -EINVAL;
+
+	/* Allocate the DMA list, one entry for each SG entry. */
+	dll_desc->size = sizeof(struct ocs_dma_linked_list) * dma_nents;
+	dll_desc->vaddr = dma_alloc_coherent(aes_dev->dev, dll_desc->size,
+					     &dll_desc->dma_addr, GFP_KERNEL);
+	if (!dll_desc->vaddr)
+		return -ENOMEM;
+
+	/* Populate DMA linked list entries. */
+	ll = dll_desc->vaddr;
+	for (i = 0; i < dma_nents; i++, sg = sg_next(sg)) {
+		ll[i].src_addr = sg_dma_address(sg) + data_offset;
+		ll[i].src_len = (sg_dma_len(sg) - data_offset) < data_size ?
+				(sg_dma_len(sg) - data_offset) : data_size;
+		data_offset = 0;
+		data_size -= ll[i].src_len;
+		/* Current element points to the DMA address of the next one. */
+		ll[i].next = dll_desc->dma_addr + (sizeof(*ll) * (i + 1));
+		ll[i].ll_flags = 0;
+	}
+	/* Terminate last element. */
+	ll[i - 1].next = 0;
+	ll[i - 1].ll_flags = OCS_LL_DMA_FLAG_TERMINATE;
+
+	return 0;
+}
diff --git a/drivers/crypto/keembay/ocs-aes.h b/drivers/crypto/keembay/ocs-aes.h
new file mode 100644
index 000000000000..c035fc48b7ed
--- /dev/null
+++ b/drivers/crypto/keembay/ocs-aes.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Intel Keem Bay OCS AES Crypto Driver.
+ *
+ * Copyright (C) 2018-2020 Intel Corporation
+ */
+
+#ifndef _CRYPTO_OCS_AES_H
+#define _CRYPTO_OCS_AES_H
+
+#include <linux/dma-mapping.h>
+
+enum ocs_cipher {
+	OCS_AES = 0,
+	OCS_SM4 = 1,
+};
+
+enum ocs_mode {
+	OCS_MODE_ECB = 0,
+	OCS_MODE_CBC = 1,
+	OCS_MODE_CTR = 2,
+	OCS_MODE_CCM = 6,
+	OCS_MODE_GCM = 7,
+	OCS_MODE_CTS = 9,
+};
+
+enum ocs_instruction {
+	OCS_ENCRYPT = 0,
+	OCS_DECRYPT = 1,
+	OCS_EXPAND  = 2,
+	OCS_BYPASS  = 3,
+};
+
+/**
+ * struct ocs_aes_dev - AES device context.
+ * @list:			List head for insertion into device list hold
+ *				by driver.
+ * @dev:			OCS AES device.
+ * @irq:			IRQ number.
+ * @base_reg:			IO base address of OCS AES.
+ * @irq_copy_completion:	Completion to indicate IRQ has been triggered.
+ * @dma_err_mask:		Error reported by OCS DMA interrupts.
+ * @engine:			Crypto engine for the device.
+ */
+struct ocs_aes_dev {
+	struct list_head list;
+	struct device *dev;
+	int irq;
+	void __iomem *base_reg;
+	struct completion irq_completion;
+	u32 dma_err_mask;
+	struct crypto_engine *engine;
+};
+
+/**
+ * struct ocs_dll_desc - Descriptor of an OCS DMA Linked List.
+ * @vaddr:	Virtual address of the linked list head.
+ * @dma_addr:	DMA address of the linked list head.
+ * @size:	Size (in bytes) of the linked list.
+ */
+struct ocs_dll_desc {
+	void		*vaddr;
+	dma_addr_t	dma_addr;
+	size_t		size;
+};
+
+int ocs_aes_set_key(struct ocs_aes_dev *aes_dev, const u32 key_size,
+		    const u8 *key, const enum ocs_cipher cipher);
+
+int ocs_aes_op(struct ocs_aes_dev *aes_dev,
+	       enum ocs_mode mode,
+	       enum ocs_cipher cipher,
+	       enum ocs_instruction instruction,
+	       dma_addr_t dst_dma_list,
+	       dma_addr_t src_dma_list,
+	       u32 src_size,
+	       u8 *iv,
+	       u32 iv_size);
+
+/**
+ * ocs_aes_bypass_op() - Use OCS DMA to copy data.
+ * @aes_dev:            The OCS AES device to use.
+ * @dst_dma_list:	The OCS DMA list mapping the memory where input data
+ *			will be copied to.
+ * @src_dma_list:	The OCS DMA list mapping input data.
+ * @src_size:		The amount of data to copy.
+ */
+static inline int ocs_aes_bypass_op(struct ocs_aes_dev *aes_dev,
+				    dma_addr_t dst_dma_list,
+				    dma_addr_t src_dma_list, u32 src_size)
+{
+	return ocs_aes_op(aes_dev, OCS_MODE_ECB, OCS_AES, OCS_BYPASS,
+			  dst_dma_list, src_dma_list, src_size, NULL, 0);
+}
+
+int ocs_aes_gcm_op(struct ocs_aes_dev *aes_dev,
+		   enum ocs_cipher cipher,
+		   enum ocs_instruction instruction,
+		   dma_addr_t dst_dma_list,
+		   dma_addr_t src_dma_list,
+		   u32 src_size,
+		   const u8 *iv,
+		   dma_addr_t aad_dma_list,
+		   u32 aad_size,
+		   u8 *out_tag,
+		   u32 tag_size);
+
+int ocs_aes_ccm_op(struct ocs_aes_dev *aes_dev,
+		   enum ocs_cipher cipher,
+		   enum ocs_instruction instruction,
+		   dma_addr_t dst_dma_list,
+		   dma_addr_t src_dma_list,
+		   u32 src_size,
+		   u8 *iv,
+		   dma_addr_t adata_dma_list,
+		   u32 adata_size,
+		   u8 *in_tag,
+		   u32 tag_size);
+
+int ocs_create_linked_list_from_sg(const struct ocs_aes_dev *aes_dev,
+				   struct scatterlist *sg,
+				   int sg_dma_count,
+				   struct ocs_dll_desc *dll_desc,
+				   size_t data_size,
+				   size_t data_offset);
+
+irqreturn_t ocs_aes_irq_handler(int irq, void *dev_id);
+
+#endif
-- 
2.26.2


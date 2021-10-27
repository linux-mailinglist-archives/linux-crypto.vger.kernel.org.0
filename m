Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBAA43C55D
	for <lists+linux-crypto@lfdr.de>; Wed, 27 Oct 2021 10:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbhJ0Im1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 27 Oct 2021 04:42:27 -0400
Received: from pv50p00im-ztdg10021801.me.com ([17.58.6.56]:48953 "EHLO
        pv50p00im-ztdg10021801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239457AbhJ0Im0 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 27 Oct 2021 04:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1635324000;
        bh=vMCE9SmBs6pqR0nQ1gAw5t9oDPsiqxsgo/MK5VHuKKM=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=gTKRzE5Ue2OgO6mThOIhRit6Bjg7gHWu3XyAsVAbEW9wre4KmSHjgcny8vtMFCSEo
         iRZwhp5D++TsPXAhRj8ehoI+FXmBbJFUEBm/Z4wZVDbjZgzQrTyrCDaERm27Hz+ZA4
         SIceqeRFyDuyOk6V+xlyddE5PtxktruqhPmJL0zE4hW6zwJaVB/FGNA22zAIj13cUU
         9LsVEngDMt/rkXJAFB/m0fzAgta9pLzomwBp6l8/sJ2XTQKGylKiQGBRTqOylyL6pA
         pJxaFKotHDWhGLPxNI9OO7qhl/dI7yALMOlb/m3pcVwXCIA3OJxK9HLImOYXrjb4ri
         ziyK6G9M7PhOA==
Received: from debian.lan (dhcp-077-251-223-151.chello.nl [77.251.223.151])
        by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id 599403603B2;
        Wed, 27 Oct 2021 08:39:54 +0000 (UTC)
From:   Richard van Schagen <vschagen@icloud.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-crypto@vger.kernel.org,
        Richard van Schagen <vschagen@icloud.com>
Subject: [PATCH v2 2/2] crypto: mtk-eip93 - Add Mediatek EIP-93 crypto engine
Date:   Wed, 27 Oct 2021 16:39:02 +0800
Message-Id: <20211027083902.3093181-3-vschagen@icloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027083902.3093181-1-vschagen@icloud.com>
References: <20211027083902.3093181-1-vschagen@icloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-10-27_02:2021-10-26,2021-10-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2110270052
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch adds support for the Mediatek EIP-93 crypto engine.

This will add AES/DES/3DES ciphers in ECB/CBC and CTR modes as well as
authenc(HMAC(x), cipher(y)) using HMAC MD5, SHA1, SHA224 and SHA256.

Signed-off-by: Richard van Schagen <vschagen@icloud.com>
---
Changes since V1:
 - Removed unused variables
 - Add corrected header files
 - Select dependencies in Kconfig

 drivers/crypto/Kconfig                  |   2 +
 drivers/crypto/Makefile                 |   1 +
 drivers/crypto/mtk-eip93/Kconfig        |  49 ++
 drivers/crypto/mtk-eip93/Makefile       |   7 +
 drivers/crypto/mtk-eip93/eip93-aead.c   | 767 +++++++++++++++++++++++
 drivers/crypto/mtk-eip93/eip93-aead.h   |  43 ++
 drivers/crypto/mtk-eip93/eip93-aes.h    |  15 +
 drivers/crypto/mtk-eip93/eip93-cipher.c | 399 ++++++++++++
 drivers/crypto/mtk-eip93/eip93-cipher.h |  62 ++
 drivers/crypto/mtk-eip93/eip93-common.c | 784 ++++++++++++++++++++++++
 drivers/crypto/mtk-eip93/eip93-common.h |  34 +
 drivers/crypto/mtk-eip93/eip93-des.h    |  15 +
 drivers/crypto/mtk-eip93/eip93-main.c   | 458 ++++++++++++++
 drivers/crypto/mtk-eip93/eip93-main.h   | 146 +++++
 drivers/crypto/mtk-eip93/eip93-regs.h   | 382 ++++++++++++
 15 files changed, 3164 insertions(+)
 create mode 100644 drivers/crypto/mtk-eip93/Kconfig
 create mode 100644 drivers/crypto/mtk-eip93/Makefile
 create mode 100644 drivers/crypto/mtk-eip93/eip93-aead.c
 create mode 100644 drivers/crypto/mtk-eip93/eip93-aead.h
 create mode 100644 drivers/crypto/mtk-eip93/eip93-aes.h
 create mode 100644 drivers/crypto/mtk-eip93/eip93-cipher.c
 create mode 100644 drivers/crypto/mtk-eip93/eip93-cipher.h
 create mode 100644 drivers/crypto/mtk-eip93/eip93-common.c
 create mode 100644 drivers/crypto/mtk-eip93/eip93-common.h
 create mode 100644 drivers/crypto/mtk-eip93/eip93-des.h
 create mode 100644 drivers/crypto/mtk-eip93/eip93-main.c
 create mode 100644 drivers/crypto/mtk-eip93/eip93-main.h
 create mode 100644 drivers/crypto/mtk-eip93/eip93-regs.h

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 51690e731..ce23b1fd8 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -912,4 +912,6 @@ config CRYPTO_DEV_SA2UL
 
 source "drivers/crypto/keembay/Kconfig"
 
+source "drivers/crypto/mtk-eip93/Kconfig"
+
 endif # CRYPTO_HW
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 1fe5120eb..92a6ddf1a 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -51,3 +51,4 @@ obj-$(CONFIG_CRYPTO_DEV_ZYNQMP_AES) += xilinx/
 obj-y += hisilicon/
 obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic/
 obj-y += keembay/
+obj-$(CONFIG_CRYPTO_DEV_EIP93) += mtk-eip93/
diff --git a/drivers/crypto/mtk-eip93/Kconfig b/drivers/crypto/mtk-eip93/Kconfig
new file mode 100644
index 000000000..bfd6bd0de
--- /dev/null
+++ b/drivers/crypto/mtk-eip93/Kconfig
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0
+config CRYPTO_DEV_EIP93_SKCIPHER
+	tristate
+
+config CRYPTO_DEV_EIP93_HMAC
+	tristate
+
+config CRYPTO_DEV_EIP93
+	tristate "Support for EIP93 crypto HW accelerators"
+	depends on SOC_MT7621 || COMPILE_TEST
+	help
+	  EIP93 have various crypto HW accelerators. Select this if
+	  you want to use the EIP93 modules for any of the crypto algorithms.
+
+if CRYPTO_DEV_EIP93
+
+config CRYPTO_DEV_EIP93_AES
+	bool "Register AES algorithm implementations with the Crypto API"
+	default y
+	select CRYPTO_DEV_EIP93_SKCIPHER
+	select CRYPTO_LIB_AES
+	select CRYPTO_SKCIPHER
+	help
+	  Selecting this will offload AES - ECB, CBC and CTR crypto
+	  to the EIP-93 crypto engine.
+
+config CRYPTO_DEV_EIP93_DES
+	bool "Register legacy DES / 3DES algorithm with the Crypto API"
+	default y
+	select CRYPTO_DEV_EIP93_SKCIPHER
+	select CRYPTO_LIB_DES
+	select CRYPTO_SKCIPHER
+	help
+	  Selecting this will offload DES and 3DES ECB and CBC
+	  crypto to the EIP-93 crypto engine.
+
+config CRYPTO_DEV_EIP93_AEAD
+  	bool "Register AEAD algorithm with the Crypto API"
+  	default y
+	select CRYPTO_DEV_EIP93_HMAC
+	select CRYPTO_AEAD
+	select CRYPTO_AUTHENC
+	select CRYPTO_MD5
+	select CRYPTO_SHA1
+	select CRYPTO_SHA256
+	help
+  	  Selecting this will offload AEAD authenc(hmac(x), cipher(y))
+	  crypto to the EIP-93 crypto engine.
+endif
diff --git a/drivers/crypto/mtk-eip93/Makefile b/drivers/crypto/mtk-eip93/Makefile
new file mode 100644
index 000000000..a100e4ed9
--- /dev/null
+++ b/drivers/crypto/mtk-eip93/Makefile
@@ -0,0 +1,7 @@
+obj-$(CONFIG_CRYPTO_DEV_EIP93) += crypto-hw-eip93.o
+
+crypto-hw-eip93-y += eip93-main.o eip93-common.o
+
+crypto-hw-eip93-$(CONFIG_CRYPTO_DEV_EIP93_SKCIPHER) += eip93-cipher.o
+crypto-hw-eip93-$(CONFIG_CRYPTO_DEV_EIP93_AEAD) += eip93-aead.o
+
diff --git a/drivers/crypto/mtk-eip93/eip93-aead.c b/drivers/crypto/mtk-eip93/eip93-aead.c
new file mode 100644
index 000000000..a6ed25e06
--- /dev/null
+++ b/drivers/crypto/mtk-eip93/eip93-aead.c
@@ -0,0 +1,767 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 - 2021
+ *
+ * Richard van Schagen <vschagen@icloud.com>
+ */
+
+#include <crypto/aead.h>
+#include <crypto/aes.h>
+#include <crypto/authenc.h>
+#include <crypto/ctr.h>
+#include <crypto/hmac.h>
+#include <crypto/internal/aead.h>
+#include <crypto/md5.h>
+#include <crypto/null.h>
+#include <crypto/sha1.h>
+#include <crypto/sha2.h>
+
+#if IS_ENABLED(CONFIG_CRYPTO_DEV_EIP93_DES)
+#include <crypto/internal/des.h>
+#endif
+
+#include <linux/crypto.h>
+#include <linux/dma-mapping.h>
+
+#include "eip93-cipher.h"
+#include "eip93-common.h"
+#include "eip93-regs.h"
+
+void mtk_aead_handle_result(struct mtk_device *mtk,
+				struct crypto_async_request *async,
+				int err)
+{
+	struct aead_request *req = aead_request_cast(async);
+	struct mtk_cipher_reqctx *rctx = aead_request_ctx(req);
+
+	mtk_unmap_dma(mtk, rctx, req->src, req->dst);
+	mtk_handle_result(mtk, rctx, req->iv);
+
+	if (err == 1)
+		err = -EBADMSG;
+	/* let software handle anti-replay errors */
+	if (err == 4)
+		err = 0;
+
+	aead_request_complete(req, err);
+}
+
+int mtk_aead_send_req(struct crypto_async_request *async)
+{
+	struct aead_request *req = aead_request_cast(async);
+	struct mtk_cipher_reqctx *rctx = aead_request_ctx(req);
+	int err;
+
+	err = check_valid_request(rctx);
+	if (err) {
+		aead_request_complete(req, err);
+		return err;
+	}
+
+	return mtk_send_req(async, req->iv, rctx);
+}
+
+/* Crypto aead API functions */
+static int mtk_aead_cra_init(struct crypto_tfm *tfm)
+{
+	struct mtk_crypto_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct mtk_alg_template *tmpl = container_of(tfm->__crt_alg,
+				struct mtk_alg_template, alg.aead.base);
+	u32 flags = tmpl->flags;
+	char *alg_base;
+
+	memset(ctx, 0, sizeof(*ctx));
+
+	crypto_aead_set_reqsize(__crypto_aead_cast(tfm),
+			sizeof(struct mtk_cipher_reqctx));
+
+	ctx->mtk = tmpl->mtk;
+	ctx->type = tmpl->type;
+	ctx->in_first = true;
+	ctx->out_first = true;
+
+	ctx->sa_in = kzalloc(sizeof(struct saRecord_s), GFP_KERNEL);
+	if (!ctx->sa_in)
+		return -ENOMEM;
+
+	ctx->sa_base_in = dma_map_single(ctx->mtk->dev, ctx->sa_in,
+				sizeof(struct saRecord_s), DMA_TO_DEVICE);
+
+	ctx->sa_out = kzalloc(sizeof(struct saRecord_s), GFP_KERNEL);
+	if (!ctx->sa_out)
+		return -ENOMEM;
+
+	ctx->sa_base_out = dma_map_single(ctx->mtk->dev, ctx->sa_out,
+				sizeof(struct saRecord_s), DMA_TO_DEVICE);
+
+	/* software workaround for now */
+	if (IS_HASH_MD5(flags))
+		alg_base = "md5";
+	if (IS_HASH_SHA1(flags))
+		alg_base = "sha1";
+	if (IS_HASH_SHA224(flags))
+		alg_base = "sha224";
+	if (IS_HASH_SHA256(flags))
+		alg_base = "sha256";
+
+	ctx->shash = crypto_alloc_shash(alg_base, 0, CRYPTO_ALG_NEED_FALLBACK);
+
+	if (IS_ERR(ctx->shash)) {
+		dev_err(ctx->mtk->dev, "base driver %s could not be loaded.\n",
+				alg_base);
+		return PTR_ERR(ctx->shash);
+	}
+
+	return 0;
+}
+
+static void mtk_aead_cra_exit(struct crypto_tfm *tfm)
+{
+	struct mtk_crypto_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	if (ctx->shash)
+		crypto_free_shash(ctx->shash);
+
+	dma_unmap_single(ctx->mtk->dev, ctx->sa_base_in,
+			sizeof(struct saRecord_s), DMA_TO_DEVICE);
+	dma_unmap_single(ctx->mtk->dev, ctx->sa_base_out,
+			sizeof(struct saRecord_s), DMA_TO_DEVICE);
+	kfree(ctx->sa_in);
+	kfree(ctx->sa_out);
+}
+
+static int mtk_aead_setkey(struct crypto_aead *ctfm, const u8 *key,
+			unsigned int len)
+{
+	struct crypto_tfm *tfm = crypto_aead_tfm(ctfm);
+	struct mtk_crypto_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct mtk_alg_template *tmpl = container_of(tfm->__crt_alg,
+				struct mtk_alg_template, alg.skcipher.base);
+	u32 flags = tmpl->flags;
+	struct crypto_authenc_keys keys;
+	struct crypto_aes_ctx aes;
+	struct saRecord_s *saRecord = ctx->sa_out;
+	int sa_size = sizeof(struct saRecord_s);
+	int err;
+	u32 nonce = 0;
+
+	if (crypto_authenc_extractkeys(&keys, key, len))
+		return -EINVAL;
+
+	if (IS_RFC3686(flags)) {
+		if (keys.enckeylen < CTR_RFC3686_NONCE_SIZE)
+			goto badkey;
+
+		keys.enckeylen -= CTR_RFC3686_NONCE_SIZE;
+		memcpy(&nonce, keys.enckey + keys.enckeylen,
+						CTR_RFC3686_NONCE_SIZE);
+	}
+
+	switch ((flags & MTK_ALG_MASK)) {
+#ifdef CONFIG_CRYPTO_DEV_EIP93_DES
+	case MTK_ALG_DES:
+		err = verify_aead_des_key(ctfm, keys.enckey, keys.enckeylen);
+		break;
+	case MTK_ALG_3DES:
+		if (keys.enckeylen != DES3_EDE_KEY_SIZE)
+			return -EINVAL;
+
+		err = verify_aead_des3_key(ctfm, keys.enckey, keys.enckeylen);
+		break;
+#endif
+	case MTK_ALG_AES:
+		err = aes_expandkey(&aes, keys.enckey, keys.enckeylen);
+	}
+	if (err)
+		goto badkey;
+
+	ctx->blksize = crypto_aead_blocksize(ctfm);
+	dma_unmap_single(ctx->mtk->dev, ctx->sa_base_in, sa_size,
+								DMA_TO_DEVICE);
+
+	dma_unmap_single(ctx->mtk->dev, ctx->sa_base_out, sa_size,
+								DMA_TO_DEVICE);
+	/* Encryption key */
+	mtk_set_saRecord(saRecord, keys.enckeylen, flags);
+	saRecord->saCmd0.bits.opCode = 1;
+	saRecord->saCmd0.bits.digestLength = ctx->authsize >> 2;
+
+	memcpy(saRecord->saKey, keys.enckey, keys.enckeylen);
+	ctx->saNonce = nonce;
+	saRecord->saNonce = nonce;
+
+	/* authentication key */
+	err = mtk_authenc_setkey(ctx->shash, saRecord, keys.authkey,
+							keys.authkeylen);
+
+	saRecord->saCmd0.bits.direction = 0;
+	memcpy(ctx->sa_in, saRecord, sa_size);
+	ctx->sa_in->saCmd0.bits.direction = 1;
+	ctx->sa_in->saCmd1.bits.copyDigest = 0;
+
+	ctx->sa_base_out = dma_map_single(ctx->mtk->dev, ctx->sa_out, sa_size,
+								DMA_TO_DEVICE);
+	ctx->sa_base_in = dma_map_single(ctx->mtk->dev, ctx->sa_in, sa_size,
+								DMA_TO_DEVICE);
+	ctx->in_first = true;
+	ctx->out_first = true;
+badkey:
+	return err;
+}
+
+static int mtk_aead_setauthsize(struct crypto_aead *ctfm,
+				unsigned int authsize)
+{
+	struct crypto_tfm *tfm = crypto_aead_tfm(ctfm);
+	struct mtk_crypto_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	dma_unmap_single(ctx->mtk->dev, ctx->sa_base_in,
+				sizeof(struct saRecord_s), DMA_TO_DEVICE);
+
+	dma_unmap_single(ctx->mtk->dev, ctx->sa_base_out,
+				sizeof(struct saRecord_s), DMA_TO_DEVICE);
+
+	ctx->authsize = authsize;
+	ctx->sa_in->saCmd0.bits.digestLength = ctx->authsize >> 2;
+	ctx->sa_out->saCmd0.bits.digestLength = ctx->authsize >> 2;
+
+	ctx->sa_base_out = dma_map_single(ctx->mtk->dev, ctx->sa_out,
+			sizeof(struct saRecord_s), DMA_TO_DEVICE);
+	ctx->sa_base_in = dma_map_single(ctx->mtk->dev, ctx->sa_in,
+				sizeof(struct saRecord_s), DMA_TO_DEVICE);
+	return 0;
+}
+
+static void mtk_aead_setassoc(struct mtk_crypto_ctx *ctx,
+			struct aead_request *req, bool in)
+{
+	struct saRecord_s *saRecord;
+
+	if (in) {
+		dma_unmap_single(ctx->mtk->dev, ctx->sa_base_in,
+				sizeof(struct saRecord_s), DMA_TO_DEVICE);
+		saRecord = ctx->sa_in;
+		saRecord->saCmd1.bits.hashCryptOffset = req->assoclen >> 2;
+
+		ctx->sa_base_in = dma_map_single(ctx->mtk->dev, ctx->sa_in,
+				sizeof(struct saRecord_s), DMA_TO_DEVICE);
+		ctx->assoclen_in = req->assoclen;
+	} else {
+		dma_unmap_single(ctx->mtk->dev, ctx->sa_base_out,
+				sizeof(struct saRecord_s), DMA_TO_DEVICE);
+		saRecord = ctx->sa_out;
+		saRecord->saCmd1.bits.hashCryptOffset = req->assoclen >> 2;
+
+		ctx->sa_base_out = dma_map_single(ctx->mtk->dev, ctx->sa_out,
+			sizeof(struct saRecord_s), DMA_TO_DEVICE);
+		ctx->assoclen_out = req->assoclen;
+	}
+}
+
+static int mtk_aead_crypt(struct aead_request *req)
+{
+	struct mtk_cipher_reqctx *rctx = aead_request_ctx(req);
+	struct crypto_async_request *async = &req->base;
+	struct mtk_crypto_ctx *ctx = crypto_tfm_ctx(req->base.tfm);
+	struct crypto_aead *aead = crypto_aead_reqtfm(req);
+
+	rctx->textsize = req->cryptlen;
+	rctx->blksize = ctx->blksize;
+	rctx->assoclen = req->assoclen;
+	rctx->authsize = ctx->authsize;
+	rctx->sg_src = req->src;
+	rctx->sg_dst = req->dst;
+	rctx->ivsize = crypto_aead_ivsize(aead);
+
+	if IS_DECRYPT(rctx->flags)
+		rctx->textsize -= rctx->authsize;
+
+	return mtk_aead_send_req(async);
+}
+
+static int mtk_aead_encrypt(struct aead_request *req)
+{
+	struct mtk_crypto_ctx *ctx = crypto_tfm_ctx(req->base.tfm);
+	struct mtk_cipher_reqctx *rctx = aead_request_ctx(req);
+	struct mtk_alg_template *tmpl = container_of(req->base.tfm->__crt_alg,
+				struct mtk_alg_template, alg.aead.base);
+
+	rctx->flags = tmpl->flags;
+	rctx->flags |= MTK_ENCRYPT;
+	if (ctx->out_first) {
+		mtk_aead_setassoc(ctx, req, false);
+		ctx->out_first = false;
+	}
+
+	if (req->assoclen != ctx->assoclen_out) {
+		dev_err(ctx->mtk->dev, "Request AAD length error\n");
+		return -EINVAL;
+	}
+
+	rctx->saRecord_base = ctx->sa_base_out;
+
+	return mtk_aead_crypt(req);
+}
+
+static int mtk_aead_decrypt(struct aead_request *req)
+{
+	struct mtk_crypto_ctx *ctx = crypto_tfm_ctx(req->base.tfm);
+	struct mtk_cipher_reqctx *rctx = aead_request_ctx(req);
+	struct mtk_alg_template *tmpl = container_of(req->base.tfm->__crt_alg,
+				struct mtk_alg_template, alg.aead.base);
+
+	rctx->flags = tmpl->flags;
+	rctx->flags |= MTK_DECRYPT;
+	if (ctx->in_first) {
+		mtk_aead_setassoc(ctx, req, true);
+		ctx->in_first = false;
+	}
+
+	if (req->assoclen != ctx->assoclen_in) {
+		dev_err(ctx->mtk->dev, "Request AAD length error\n");
+		return -EINVAL;
+	}
+
+	rctx->saRecord_base = ctx->sa_base_in;
+
+	return mtk_aead_crypt(req);
+}
+
+/* Available authenc algorithms in this module */
+struct mtk_alg_template mtk_alg_authenc_hmac_md5_cbc_aes = {
+	.type = MTK_ALG_TYPE_AEAD,
+	.flags = MTK_HASH_HMAC | MTK_HASH_MD5 | MTK_MODE_CBC | MTK_ALG_AES,
+	.alg.aead = {
+		.setkey = mtk_aead_setkey,
+		.encrypt = mtk_aead_encrypt,
+		.decrypt = mtk_aead_decrypt,
+		.ivsize	= AES_BLOCK_SIZE,
+		.setauthsize = mtk_aead_setauthsize,
+		.maxauthsize = MD5_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(md5),cbc(aes))",
+			.cra_driver_name =
+				"authenc(hmac(md5-eip93), cbc(aes-eip93))",
+			.cra_priority = MTK_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = AES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct mtk_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = mtk_aead_cra_init,
+			.cra_exit = mtk_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct mtk_alg_template mtk_alg_authenc_hmac_sha1_cbc_aes = {
+	.type = MTK_ALG_TYPE_AEAD,
+	.flags = MTK_HASH_HMAC | MTK_HASH_SHA1 | MTK_MODE_CBC | MTK_ALG_AES,
+	.alg.aead = {
+		.setkey = mtk_aead_setkey,
+		.encrypt = mtk_aead_encrypt,
+		.decrypt = mtk_aead_decrypt,
+		.ivsize	= AES_BLOCK_SIZE,
+		.setauthsize = mtk_aead_setauthsize,
+		.maxauthsize = SHA1_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(sha1),cbc(aes))",
+			.cra_driver_name =
+				"authenc(hmac(sha1-eip93),cbc(aes-eip93))",
+			.cra_priority = MTK_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = AES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct mtk_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = mtk_aead_cra_init,
+			.cra_exit = mtk_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct mtk_alg_template mtk_alg_authenc_hmac_sha224_cbc_aes = {
+	.type = MTK_ALG_TYPE_AEAD,
+	.flags = MTK_HASH_HMAC | MTK_HASH_SHA224 | MTK_MODE_CBC | MTK_ALG_AES,
+	.alg.aead = {
+		.setkey = mtk_aead_setkey,
+		.encrypt = mtk_aead_encrypt,
+		.decrypt = mtk_aead_decrypt,
+		.ivsize	= AES_BLOCK_SIZE,
+		.setauthsize = mtk_aead_setauthsize,
+		.maxauthsize = SHA224_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(sha224),cbc(aes))",
+			.cra_driver_name =
+				"authenc(hmac(sha224-eip93),cbc(aes-eip93))",
+			.cra_priority = MTK_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = AES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct mtk_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = mtk_aead_cra_init,
+			.cra_exit = mtk_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct mtk_alg_template mtk_alg_authenc_hmac_sha256_cbc_aes = {
+	.type = MTK_ALG_TYPE_AEAD,
+	.flags = MTK_HASH_HMAC | MTK_HASH_SHA256 | MTK_MODE_CBC | MTK_ALG_AES,
+	.alg.aead = {
+		.setkey = mtk_aead_setkey,
+		.encrypt = mtk_aead_encrypt,
+		.decrypt = mtk_aead_decrypt,
+		.ivsize	= AES_BLOCK_SIZE,
+		.setauthsize = mtk_aead_setauthsize,
+		.maxauthsize = SHA256_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(sha256),cbc(aes))",
+			.cra_driver_name =
+				"authenc(hmac(sha256-eip93),cbc(aes-eip93))",
+			.cra_priority = MTK_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = AES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct mtk_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = mtk_aead_cra_init,
+			.cra_exit = mtk_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct mtk_alg_template mtk_alg_authenc_hmac_md5_rfc3686_aes = {
+	.type = MTK_ALG_TYPE_AEAD,
+	.flags = MTK_HASH_HMAC | MTK_HASH_MD5 |
+			MTK_MODE_CTR | MTK_MODE_RFC3686 | MTK_ALG_AES,
+	.alg.aead = {
+		.setkey = mtk_aead_setkey,
+		.encrypt = mtk_aead_encrypt,
+		.decrypt = mtk_aead_decrypt,
+		.ivsize	= CTR_RFC3686_IV_SIZE,
+		.setauthsize = mtk_aead_setauthsize,
+		.maxauthsize = MD5_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(md5),rfc3686(ctr(aes)))",
+			.cra_driver_name =
+			"authenc(hmac(md5-eip93),rfc3686(ctr(aes-eip93)))",
+			.cra_priority = MTK_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = 1,
+			.cra_ctxsize = sizeof(struct mtk_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = mtk_aead_cra_init,
+			.cra_exit = mtk_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct mtk_alg_template mtk_alg_authenc_hmac_sha1_rfc3686_aes = {
+	.type = MTK_ALG_TYPE_AEAD,
+	.flags = MTK_HASH_HMAC | MTK_HASH_SHA1 |
+			MTK_MODE_CTR | MTK_MODE_RFC3686 | MTK_ALG_AES,
+	.alg.aead = {
+		.setkey = mtk_aead_setkey,
+		.encrypt = mtk_aead_encrypt,
+		.decrypt = mtk_aead_decrypt,
+		.ivsize	= CTR_RFC3686_IV_SIZE,
+		.setauthsize = mtk_aead_setauthsize,
+		.maxauthsize = SHA1_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(sha1),rfc3686(ctr(aes)))",
+			.cra_driver_name =
+			"authenc(hmac(sha1-eip93),rfc3686(ctr(aes-eip93)))",
+			.cra_priority = MTK_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = 1,
+			.cra_ctxsize = sizeof(struct mtk_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = mtk_aead_cra_init,
+			.cra_exit = mtk_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct mtk_alg_template mtk_alg_authenc_hmac_sha224_rfc3686_aes = {
+	.type = MTK_ALG_TYPE_AEAD,
+	.flags = MTK_HASH_HMAC | MTK_HASH_SHA224 |
+			MTK_MODE_CTR | MTK_MODE_RFC3686 | MTK_ALG_AES,
+	.alg.aead = {
+		.setkey = mtk_aead_setkey,
+		.encrypt = mtk_aead_encrypt,
+		.decrypt = mtk_aead_decrypt,
+		.ivsize	= CTR_RFC3686_IV_SIZE,
+		.setauthsize = mtk_aead_setauthsize,
+		.maxauthsize = SHA224_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(sha224),rfc3686(ctr(aes)))",
+			.cra_driver_name =
+			"authenc(hmac(sha224-eip93),rfc3686(ctr(aes-eip93)))",
+			.cra_priority = MTK_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = 1,
+			.cra_ctxsize = sizeof(struct mtk_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = mtk_aead_cra_init,
+			.cra_exit = mtk_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct mtk_alg_template mtk_alg_authenc_hmac_sha256_rfc3686_aes = {
+	.type = MTK_ALG_TYPE_AEAD,
+	.flags = MTK_HASH_HMAC | MTK_HASH_SHA256 |
+			MTK_MODE_CTR | MTK_MODE_RFC3686 | MTK_ALG_AES,
+	.alg.aead = {
+		.setkey = mtk_aead_setkey,
+		.encrypt = mtk_aead_encrypt,
+		.decrypt = mtk_aead_decrypt,
+		.ivsize	= CTR_RFC3686_IV_SIZE,
+		.setauthsize = mtk_aead_setauthsize,
+		.maxauthsize = SHA256_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(sha256),rfc3686(ctr(aes)))",
+			.cra_driver_name =
+			"authenc(hmac(sha256-eip93),rfc3686(ctr(aes-eip93)))",
+			.cra_priority = MTK_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = 1,
+			.cra_ctxsize = sizeof(struct mtk_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = mtk_aead_cra_init,
+			.cra_exit = mtk_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+#if IS_ENABLED(CONFIG_CRYPTO_DEV_EIP93_DES)
+struct mtk_alg_template mtk_alg_authenc_hmac_md5_cbc_des = {
+	.type = MTK_ALG_TYPE_AEAD,
+	.flags = MTK_HASH_HMAC | MTK_HASH_MD5 | MTK_MODE_CBC | MTK_ALG_DES,
+	.alg.aead = {
+		.setkey = mtk_aead_setkey,
+		.encrypt = mtk_aead_encrypt,
+		.decrypt = mtk_aead_decrypt,
+		.ivsize	= DES_BLOCK_SIZE,
+		.setauthsize = mtk_aead_setauthsize,
+		.maxauthsize = MD5_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(md5),cbc(des))",
+			.cra_driver_name =
+				"authenc(hmac(md5-eip93),cbc(des-eip93))",
+			.cra_priority = MTK_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = DES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct mtk_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = mtk_aead_cra_init,
+			.cra_exit = mtk_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct mtk_alg_template mtk_alg_authenc_hmac_sha1_cbc_des = {
+	.type = MTK_ALG_TYPE_AEAD,
+	.flags = MTK_HASH_HMAC | MTK_HASH_SHA1 | MTK_MODE_CBC | MTK_ALG_DES,
+	.alg.aead = {
+		.setkey = mtk_aead_setkey,
+		.encrypt = mtk_aead_encrypt,
+		.decrypt = mtk_aead_decrypt,
+		.ivsize	= DES_BLOCK_SIZE,
+		.setauthsize = mtk_aead_setauthsize,
+		.maxauthsize = SHA1_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(sha1),cbc(des))",
+			.cra_driver_name =
+				"authenc(hmac(sha1-eip93),cbc(des-eip93))",
+			.cra_priority = MTK_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = DES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct mtk_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = mtk_aead_cra_init,
+			.cra_exit = mtk_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct mtk_alg_template mtk_alg_authenc_hmac_sha224_cbc_des = {
+	.type = MTK_ALG_TYPE_AEAD,
+	.flags = MTK_HASH_HMAC | MTK_HASH_SHA224 | MTK_MODE_CBC | MTK_ALG_DES,
+	.alg.aead = {
+		.setkey = mtk_aead_setkey,
+		.encrypt = mtk_aead_encrypt,
+		.decrypt = mtk_aead_decrypt,
+		.ivsize	= DES_BLOCK_SIZE,
+		.setauthsize = mtk_aead_setauthsize,
+		.maxauthsize = SHA224_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(sha224),cbc(des))",
+			.cra_driver_name =
+				"authenc(hmac(sha224-eip93),cbc(des-eip93))",
+			.cra_priority = MTK_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = DES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct mtk_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = mtk_aead_cra_init,
+			.cra_exit = mtk_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct mtk_alg_template mtk_alg_authenc_hmac_sha256_cbc_des = {
+	.type = MTK_ALG_TYPE_AEAD,
+	.flags = MTK_HASH_HMAC | MTK_HASH_SHA256 | MTK_MODE_CBC | MTK_ALG_DES,
+	.alg.aead = {
+		.setkey = mtk_aead_setkey,
+		.encrypt = mtk_aead_encrypt,
+		.decrypt = mtk_aead_decrypt,
+		.ivsize	= DES_BLOCK_SIZE,
+		.setauthsize = mtk_aead_setauthsize,
+		.maxauthsize = SHA256_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(sha256),cbc(des))",
+			.cra_driver_name =
+				"authenc(hmac(sha256-eip93),cbc(des-eip93))",
+			.cra_priority = MTK_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = DES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct mtk_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = mtk_aead_cra_init,
+			.cra_exit = mtk_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct mtk_alg_template mtk_alg_authenc_hmac_md5_cbc_des3_ede = {
+	.type = MTK_ALG_TYPE_AEAD,
+	.flags = MTK_HASH_HMAC | MTK_HASH_MD5 | MTK_MODE_CBC | MTK_ALG_3DES,
+	.alg.aead = {
+		.setkey = mtk_aead_setkey,
+		.encrypt = mtk_aead_encrypt,
+		.decrypt = mtk_aead_decrypt,
+		.ivsize	= DES3_EDE_BLOCK_SIZE,
+		.setauthsize = mtk_aead_setauthsize,
+		.maxauthsize = MD5_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(md5),cbc(des3_ede))",
+			.cra_driver_name =
+				"authenc(hmac(md5-eip93),cbc(des3_ede-eip93))",
+			.cra_priority = MTK_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = DES3_EDE_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct mtk_crypto_ctx),
+			.cra_alignmask = 0x0,
+			.cra_init = mtk_aead_cra_init,
+			.cra_exit = mtk_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct mtk_alg_template mtk_alg_authenc_hmac_sha1_cbc_des3_ede = {
+	.type = MTK_ALG_TYPE_AEAD,
+	.flags = MTK_HASH_HMAC | MTK_HASH_SHA1 | MTK_MODE_CBC | MTK_ALG_3DES,
+	.alg.aead = {
+		.setkey = mtk_aead_setkey,
+		.encrypt = mtk_aead_encrypt,
+		.decrypt = mtk_aead_decrypt,
+		.ivsize	= DES3_EDE_BLOCK_SIZE,
+		.setauthsize = mtk_aead_setauthsize,
+		.maxauthsize = SHA1_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(sha1),cbc(des3_ede))",
+			.cra_driver_name =
+				"authenc(hmac(sha1-eip93),cbc(des3_ede-eip93))",
+			.cra_priority = MTK_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = DES3_EDE_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct mtk_crypto_ctx),
+			.cra_alignmask = 0x0,
+			.cra_init = mtk_aead_cra_init,
+			.cra_exit = mtk_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct mtk_alg_template mtk_alg_authenc_hmac_sha224_cbc_des3_ede = {
+	.type = MTK_ALG_TYPE_AEAD,
+	.flags = MTK_HASH_HMAC | MTK_HASH_SHA224 | MTK_MODE_CBC | MTK_ALG_3DES,
+	.alg.aead = {
+		.setkey = mtk_aead_setkey,
+		.encrypt = mtk_aead_encrypt,
+		.decrypt = mtk_aead_decrypt,
+		.ivsize	= DES3_EDE_BLOCK_SIZE,
+		.setauthsize = mtk_aead_setauthsize,
+		.maxauthsize = SHA224_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(sha224),cbc(des3_ede))",
+			.cra_driver_name =
+			"authenc(hmac(sha224-eip93),cbc(des3_ede-eip93))",
+			.cra_priority = MTK_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = DES3_EDE_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct mtk_crypto_ctx),
+			.cra_alignmask = 0x0,
+			.cra_init = mtk_aead_cra_init,
+			.cra_exit = mtk_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct mtk_alg_template mtk_alg_authenc_hmac_sha256_cbc_des3_ede = {
+	.type = MTK_ALG_TYPE_AEAD,
+	.flags = MTK_HASH_HMAC | MTK_HASH_SHA256 | MTK_MODE_CBC | MTK_ALG_3DES,
+	.alg.aead = {
+		.setkey = mtk_aead_setkey,
+		.encrypt = mtk_aead_encrypt,
+		.decrypt = mtk_aead_decrypt,
+		.ivsize	= DES3_EDE_BLOCK_SIZE,
+		.setauthsize = mtk_aead_setauthsize,
+		.maxauthsize = SHA256_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(sha256),cbc(des3_ede))",
+			.cra_driver_name =
+			"authenc(hmac(sha256-eip93),cbc(des3_ede-eip93))",
+			.cra_priority = MTK_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = DES3_EDE_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct mtk_crypto_ctx),
+			.cra_alignmask = 0x0,
+			.cra_init = mtk_aead_cra_init,
+			.cra_exit = mtk_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+#endif
diff --git a/drivers/crypto/mtk-eip93/eip93-aead.h b/drivers/crypto/mtk-eip93/eip93-aead.h
new file mode 100644
index 000000000..2f81b0e6d
--- /dev/null
+++ b/drivers/crypto/mtk-eip93/eip93-aead.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2019 - 2021
+ *
+ * Richard van Schagen <vschagen@icloud.com>
+ */
+#ifndef _EIP93_AEAD_H_
+#define _EIP93_AEAD_H_
+
+extern struct mtk_alg_template mtk_alg_authenc_hmac_md5_cbc_aes;
+extern struct mtk_alg_template mtk_alg_authenc_hmac_sha1_cbc_aes;
+extern struct mtk_alg_template mtk_alg_authenc_hmac_sha224_cbc_aes;
+extern struct mtk_alg_template mtk_alg_authenc_hmac_sha256_cbc_aes;
+extern struct mtk_alg_template mtk_alg_authenc_hmac_md5_ctr_aes;
+extern struct mtk_alg_template mtk_alg_authenc_hmac_sha1_ctr_aes;
+extern struct mtk_alg_template mtk_alg_authenc_hmac_sha224_ctr_aes;
+extern struct mtk_alg_template mtk_alg_authenc_hmac_sha256_ctr_aes;
+extern struct mtk_alg_template mtk_alg_authenc_hmac_md5_rfc3686_aes;
+extern struct mtk_alg_template mtk_alg_authenc_hmac_sha1_rfc3686_aes;
+extern struct mtk_alg_template mtk_alg_authenc_hmac_sha224_rfc3686_aes;
+extern struct mtk_alg_template mtk_alg_authenc_hmac_sha256_rfc3686_aes;
+#if IS_ENABLED(CONFIG_CRYPTO_DEV_EIP93_DES)
+extern struct mtk_alg_template mtk_alg_authenc_hmac_md5_cbc_des;
+extern struct mtk_alg_template mtk_alg_authenc_hmac_sha1_cbc_des;
+extern struct mtk_alg_template mtk_alg_authenc_hmac_sha224_cbc_des;
+extern struct mtk_alg_template mtk_alg_authenc_hmac_sha256_cbc_des;
+extern struct mtk_alg_template mtk_alg_authenc_hmac_md5_cbc_des3_ede;
+extern struct mtk_alg_template mtk_alg_authenc_hmac_sha1_cbc_des3_ede;
+extern struct mtk_alg_template mtk_alg_authenc_hmac_sha224_cbc_des3_ede;
+extern struct mtk_alg_template mtk_alg_authenc_hmac_sha256_cbc_des3_ede;
+extern struct mtk_alg_template mtk_alg_authenc_hmac_md5_ecb_null;
+extern struct mtk_alg_template mtk_alg_authenc_hmac_sha1_ecb_null;
+extern struct mtk_alg_template mtk_alg_authenc_hmac_sha224_ecb_null;
+extern struct mtk_alg_template mtk_alg_authenc_hmac_sha256_ecb_null;
+#endif
+
+void mtk_aead_handle_result(struct mtk_device *mtk,
+				struct crypto_async_request *async,
+				int err);
+
+int mtk_aead_send_req(struct crypto_async_request *async);
+
+#endif /* _EIP93_AEAD_H_ */
diff --git a/drivers/crypto/mtk-eip93/eip93-aes.h b/drivers/crypto/mtk-eip93/eip93-aes.h
new file mode 100644
index 000000000..1d0b985c1
--- /dev/null
+++ b/drivers/crypto/mtk-eip93/eip93-aes.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2019 - 2021
+ *
+ * Richard van Schagen <vschagen@icloud.com>
+ */
+#ifndef _EIP93_AES_H_
+#define _EIP93_AES_H_
+
+extern struct mtk_alg_template mtk_alg_ecb_aes;
+extern struct mtk_alg_template mtk_alg_cbc_aes;
+extern struct mtk_alg_template mtk_alg_ctr_aes;
+extern struct mtk_alg_template mtk_alg_rfc3686_aes;
+
+#endif /* _EIP93_AES_H_ */
diff --git a/drivers/crypto/mtk-eip93/eip93-cipher.c b/drivers/crypto/mtk-eip93/eip93-cipher.c
new file mode 100644
index 000000000..068bcf2d3
--- /dev/null
+++ b/drivers/crypto/mtk-eip93/eip93-cipher.c
@@ -0,0 +1,399 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 - 2021
+ *
+ * Richard van Schagen <vschagen@icloud.com>
+ */
+
+#if IS_ENABLED(CONFIG_CRYPTO_DEV_EIP93_AES)
+#include <crypto/aes.h>
+#include <crypto/ctr.h>
+#endif
+#if IS_ENABLED(CONFIG_CRYPTO_DEV_EIP93_DES)
+#include <crypto/internal/des.h>
+#endif
+#include <linux/dma-mapping.h>
+
+#include "eip93-cipher.h"
+#include "eip93-common.h"
+#include "eip93-regs.h"
+
+/* Crypto skcipher API functions */
+static int mtk_skcipher_cra_init(struct crypto_tfm *tfm)
+{
+	struct mtk_crypto_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct mtk_alg_template *tmpl = container_of(tfm->__crt_alg,
+				struct mtk_alg_template, alg.skcipher.base);
+
+	crypto_skcipher_set_reqsize(__crypto_skcipher_cast(tfm),
+					sizeof(struct mtk_cipher_reqctx));
+
+	memset(ctx, 0, sizeof(*ctx));
+
+	ctx->mtk = tmpl->mtk;
+	ctx->type = tmpl->type;
+
+	ctx->sa_in = kzalloc(sizeof(struct saRecord_s), GFP_KERNEL);
+	if (!ctx->sa_in)
+		return -ENOMEM;
+
+	ctx->sa_base_in = dma_map_single(ctx->mtk->dev, ctx->sa_in,
+				sizeof(struct saRecord_s), DMA_TO_DEVICE);
+
+	ctx->sa_out = kzalloc(sizeof(struct saRecord_s), GFP_KERNEL);
+	if (!ctx->sa_out)
+		return -ENOMEM;
+
+	ctx->sa_base_out = dma_map_single(ctx->mtk->dev, ctx->sa_out,
+				sizeof(struct saRecord_s), DMA_TO_DEVICE);
+	return 0;
+}
+
+static void mtk_skcipher_cra_exit(struct crypto_tfm *tfm)
+{
+	struct mtk_crypto_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	dma_unmap_single(ctx->mtk->dev, ctx->sa_base_in,
+			sizeof(struct saRecord_s), DMA_TO_DEVICE);
+	dma_unmap_single(ctx->mtk->dev, ctx->sa_base_out,
+			sizeof(struct saRecord_s), DMA_TO_DEVICE);
+	kfree(ctx->sa_in);
+	kfree(ctx->sa_out);
+}
+
+static int mtk_skcipher_setkey(struct crypto_skcipher *ctfm, const u8 *key,
+				 unsigned int len)
+{
+	struct crypto_tfm *tfm = crypto_skcipher_tfm(ctfm);
+	struct mtk_crypto_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct mtk_alg_template *tmpl = container_of(tfm->__crt_alg,
+				struct mtk_alg_template, alg.skcipher.base);
+	u32 flags = tmpl->flags;
+	struct saRecord_s *saRecord = ctx->sa_out;
+	u32 nonce = 0;
+	unsigned int keylen = len;
+	int sa_size = sizeof(struct saRecord_s), err = -EINVAL;
+
+	if (!key || !keylen)
+		return err;
+
+#ifdef CONFIG_CRYPTO_DEV_EIP93_AES
+	if (IS_RFC3686(flags)) {
+		if (len < CTR_RFC3686_NONCE_SIZE)
+			return err;
+
+		keylen = len - CTR_RFC3686_NONCE_SIZE;
+		memcpy(&nonce, key + keylen, CTR_RFC3686_NONCE_SIZE);
+	}
+#endif
+
+#ifdef CONFIG_CRYPTO_DEV_EIP93_DES
+	if (flags & MTK_ALG_DES) {
+		ctx->blksize = DES_BLOCK_SIZE;
+		err = verify_skcipher_des_key(ctfm, key);
+	}
+	if (flags & MTK_ALG_3DES) {
+		ctx->blksize = DES3_EDE_BLOCK_SIZE;
+		err = verify_skcipher_des3_key(ctfm, key);
+	}
+#endif
+#ifdef CONFIG_CRYPTO_DEV_EIP93_AES
+	if (flags & MTK_ALG_AES) {
+		struct crypto_aes_ctx aes;
+		ctx->blksize = AES_BLOCK_SIZE;
+		err = aes_expandkey(&aes, key, keylen);
+	}
+#endif
+	if (err)
+		return err;
+
+	dma_unmap_single(ctx->mtk->dev, ctx->sa_base_in, sa_size,
+								DMA_TO_DEVICE);
+
+	dma_unmap_single(ctx->mtk->dev, ctx->sa_base_out, sa_size,
+								DMA_TO_DEVICE);
+
+	mtk_set_saRecord(saRecord, keylen, flags);
+
+	memcpy(saRecord->saKey, key, keylen);
+	ctx->saNonce = nonce;
+	saRecord->saNonce = nonce;
+	saRecord->saCmd0.bits.direction = 0;
+
+	memcpy(ctx->sa_in, saRecord, sa_size);
+	ctx->sa_in->saCmd0.bits.direction = 1;
+
+	ctx->sa_base_out = dma_map_single(ctx->mtk->dev, ctx->sa_out, sa_size,
+								DMA_TO_DEVICE);
+
+	ctx->sa_base_in = dma_map_single(ctx->mtk->dev, ctx->sa_in, sa_size,
+								DMA_TO_DEVICE);
+	return err;
+}
+
+static int mtk_skcipher_crypt(struct skcipher_request *req)
+{
+	struct mtk_cipher_reqctx *rctx = skcipher_request_ctx(req);
+	struct crypto_async_request *async = &req->base;
+	struct mtk_crypto_ctx *ctx = crypto_tfm_ctx(req->base.tfm);
+	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
+
+	if (!req->cryptlen)
+		return 0;
+
+	rctx->assoclen = 0;
+	rctx->textsize = req->cryptlen;
+	rctx->authsize = 0;
+	rctx->sg_src = req->src;
+	rctx->sg_dst = req->dst;
+	rctx->ivsize = crypto_skcipher_ivsize(skcipher);
+	rctx->blksize = ctx->blksize;
+	if (!IS_ECB(rctx->flags))
+		rctx->flags |= MTK_DESC_DMA_IV;
+
+	return mtk_skcipher_send_req(async);
+}
+
+static int mtk_skcipher_encrypt(struct skcipher_request *req)
+{
+	struct mtk_crypto_ctx *ctx = crypto_tfm_ctx(req->base.tfm);
+	struct mtk_cipher_reqctx *rctx = skcipher_request_ctx(req);
+	struct mtk_alg_template *tmpl = container_of(req->base.tfm->__crt_alg,
+				struct mtk_alg_template, alg.skcipher.base);
+
+	rctx->flags = tmpl->flags;
+	rctx->flags |= MTK_ENCRYPT;
+	rctx->saRecord_base = ctx->sa_base_out;
+
+	return mtk_skcipher_crypt(req);
+}
+
+static int mtk_skcipher_decrypt(struct skcipher_request *req)
+{
+	struct mtk_crypto_ctx *ctx = crypto_tfm_ctx(req->base.tfm);
+	struct mtk_cipher_reqctx *rctx = skcipher_request_ctx(req);
+	struct mtk_alg_template *tmpl = container_of(req->base.tfm->__crt_alg,
+				struct mtk_alg_template, alg.skcipher.base);
+
+	rctx->flags = tmpl->flags;
+	rctx->flags |= MTK_DECRYPT;
+	rctx->saRecord_base = ctx->sa_base_in;
+
+	return mtk_skcipher_crypt(req);
+}
+
+/* Available algorithms in this module */
+#ifdef CONFIG_CRYPTO_DEV_EIP93_AES
+struct mtk_alg_template mtk_alg_ecb_aes = {
+	.type = MTK_ALG_TYPE_SKCIPHER,
+	.flags = MTK_MODE_ECB | MTK_ALG_AES,
+	.alg.skcipher = {
+		.setkey = mtk_skcipher_setkey,
+		.encrypt = mtk_skcipher_encrypt,
+		.decrypt = mtk_skcipher_decrypt,
+		.min_keysize = AES_MIN_KEY_SIZE,
+		.max_keysize = AES_MAX_KEY_SIZE,
+		.ivsize	= 0,
+		.base = {
+			.cra_name = "ecb(aes)",
+			.cra_driver_name = "ecb(aes-eip93)",
+			.cra_priority = MTK_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_NEED_FALLBACK |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = AES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct mtk_crypto_ctx),
+			.cra_alignmask = 0xf,
+			.cra_init = mtk_skcipher_cra_init,
+			.cra_exit = mtk_skcipher_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct mtk_alg_template mtk_alg_cbc_aes = {
+	.type = MTK_ALG_TYPE_SKCIPHER,
+	.flags = MTK_MODE_CBC | MTK_ALG_AES,
+	.alg.skcipher = {
+		.setkey = mtk_skcipher_setkey,
+		.encrypt = mtk_skcipher_encrypt,
+		.decrypt = mtk_skcipher_decrypt,
+		.min_keysize = AES_MIN_KEY_SIZE,
+		.max_keysize = AES_MAX_KEY_SIZE,
+		.ivsize	= AES_BLOCK_SIZE,
+		.base = {
+			.cra_name = "cbc(aes)",
+			.cra_driver_name = "cbc(aes-eip93)",
+			.cra_priority = MTK_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_NEED_FALLBACK |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = AES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct mtk_crypto_ctx),
+			.cra_alignmask = 0xf,
+			.cra_init = mtk_skcipher_cra_init,
+			.cra_exit = mtk_skcipher_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct mtk_alg_template mtk_alg_ctr_aes = {
+	.type = MTK_ALG_TYPE_SKCIPHER,
+	.flags = MTK_MODE_CTR | MTK_ALG_AES,
+	.alg.skcipher = {
+		.setkey = mtk_skcipher_setkey,
+		.encrypt = mtk_skcipher_encrypt,
+		.decrypt = mtk_skcipher_decrypt,
+		.min_keysize = AES_MIN_KEY_SIZE,
+		.max_keysize = AES_MAX_KEY_SIZE,
+		.ivsize	= AES_BLOCK_SIZE,
+		.base = {
+			.cra_name = "ctr(aes)",
+			.cra_driver_name = "ctr(aes-eip93)",
+			.cra_priority = MTK_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+				     CRYPTO_ALG_NEED_FALLBACK |
+				     CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = 1,
+			.cra_ctxsize = sizeof(struct mtk_crypto_ctx),
+			.cra_alignmask = 0xf,
+			.cra_init = mtk_skcipher_cra_init,
+			.cra_exit = mtk_skcipher_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct mtk_alg_template mtk_alg_rfc3686_aes = {
+	.type = MTK_ALG_TYPE_SKCIPHER,
+	.flags = MTK_MODE_CTR | MTK_MODE_RFC3686 | MTK_ALG_AES,
+	.alg.skcipher = {
+		.setkey = mtk_skcipher_setkey,
+		.encrypt = mtk_skcipher_encrypt,
+		.decrypt = mtk_skcipher_decrypt,
+		.min_keysize = AES_MIN_KEY_SIZE + CTR_RFC3686_NONCE_SIZE,
+		.max_keysize = AES_MAX_KEY_SIZE + CTR_RFC3686_NONCE_SIZE,
+		.ivsize	= CTR_RFC3686_IV_SIZE,
+		.base = {
+			.cra_name = "rfc3686(ctr(aes))",
+			.cra_driver_name = "rfc3686(ctr(aes-eip93))",
+			.cra_priority = MTK_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_NEED_FALLBACK |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = 1,
+			.cra_ctxsize = sizeof(struct mtk_crypto_ctx),
+			.cra_alignmask = 0xf,
+			.cra_init = mtk_skcipher_cra_init,
+			.cra_exit = mtk_skcipher_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+#endif
+#ifdef CONFIG_CRYPTO_DEV_EIP93_DES
+struct mtk_alg_template mtk_alg_ecb_des = {
+	.type = MTK_ALG_TYPE_SKCIPHER,
+	.flags = MTK_MODE_ECB | MTK_ALG_DES,
+	.alg.skcipher = {
+		.setkey = mtk_skcipher_setkey,
+		.encrypt = mtk_skcipher_encrypt,
+		.decrypt = mtk_skcipher_decrypt,
+		.min_keysize = DES_KEY_SIZE,
+		.max_keysize = DES_KEY_SIZE,
+		.ivsize	= 0,
+		.base = {
+			.cra_name = "ecb(des)",
+			.cra_driver_name = "ebc(des-eip93)",
+			.cra_priority = MTK_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = DES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct mtk_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = mtk_skcipher_cra_init,
+			.cra_exit = mtk_skcipher_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct mtk_alg_template mtk_alg_cbc_des = {
+	.type = MTK_ALG_TYPE_SKCIPHER,
+	.flags = MTK_MODE_CBC | MTK_ALG_DES,
+	.alg.skcipher = {
+		.setkey = mtk_skcipher_setkey,
+		.encrypt = mtk_skcipher_encrypt,
+		.decrypt = mtk_skcipher_decrypt,
+		.min_keysize = DES_KEY_SIZE,
+		.max_keysize = DES_KEY_SIZE,
+		.ivsize	= DES_BLOCK_SIZE,
+		.base = {
+			.cra_name = "cbc(des)",
+			.cra_driver_name = "cbc(des-eip93)",
+			.cra_priority = MTK_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = DES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct mtk_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = mtk_skcipher_cra_init,
+			.cra_exit = mtk_skcipher_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct mtk_alg_template mtk_alg_ecb_des3_ede = {
+	.type = MTK_ALG_TYPE_SKCIPHER,
+	.flags = MTK_MODE_ECB | MTK_ALG_3DES,
+	.alg.skcipher = {
+		.setkey = mtk_skcipher_setkey,
+		.encrypt = mtk_skcipher_encrypt,
+		.decrypt = mtk_skcipher_decrypt,
+		.min_keysize = DES3_EDE_KEY_SIZE,
+		.max_keysize = DES3_EDE_KEY_SIZE,
+		.ivsize	= 0,
+		.base = {
+			.cra_name = "ecb(des3_ede)",
+			.cra_driver_name = "ecb(des3_ede-eip93)",
+			.cra_priority = MTK_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = DES3_EDE_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct mtk_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = mtk_skcipher_cra_init,
+			.cra_exit = mtk_skcipher_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct mtk_alg_template mtk_alg_cbc_des3_ede = {
+	.type = MTK_ALG_TYPE_SKCIPHER,
+	.flags = MTK_MODE_CBC | MTK_ALG_3DES,
+	.alg.skcipher = {
+		.setkey = mtk_skcipher_setkey,
+		.encrypt = mtk_skcipher_encrypt,
+		.decrypt = mtk_skcipher_decrypt,
+		.min_keysize = DES3_EDE_KEY_SIZE,
+		.max_keysize = DES3_EDE_KEY_SIZE,
+		.ivsize	= DES3_EDE_BLOCK_SIZE,
+		.base = {
+			.cra_name = "cbc(des3_ede)",
+			.cra_driver_name = "cbc(des3_ede-eip93)",
+			.cra_priority = MTK_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = DES3_EDE_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct mtk_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = mtk_skcipher_cra_init,
+			.cra_exit = mtk_skcipher_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+#endif
diff --git a/drivers/crypto/mtk-eip93/eip93-cipher.h b/drivers/crypto/mtk-eip93/eip93-cipher.h
new file mode 100644
index 000000000..fb41f360a
--- /dev/null
+++ b/drivers/crypto/mtk-eip93/eip93-cipher.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2019 - 2021
+ *
+ * Richard van Schagen <vschagen@icloud.com>
+ */
+#ifndef _EIP93_CIPHER_H_
+#define _EIP93_CIPHER_H_
+
+#include "eip93-main.h"
+
+struct mtk_crypto_ctx {
+	struct mtk_device		*mtk;
+	struct saRecord_s		*sa_in;
+	dma_addr_t			sa_base_in;
+	struct saRecord_s		*sa_out;
+	dma_addr_t			sa_base_out;
+	uint32_t			saNonce;
+	int				blksize;
+	/* AEAD specific */
+	unsigned int			authsize;
+	unsigned int			assoclen_in;
+	unsigned int			assoclen_out;
+	bool				in_first;
+	bool				out_first;
+	enum mtk_alg_type		type;
+	struct crypto_shash		*shash;
+};
+
+struct mtk_cipher_reqctx {
+	unsigned long			flags;
+	unsigned int			blksize;
+	unsigned int			ivsize;
+	unsigned int			textsize;
+	unsigned int			assoclen;
+	unsigned int			authsize;
+	dma_addr_t			saRecord_base;
+	struct saState_s		*saState;
+	dma_addr_t			saState_base;
+	uint32_t			saState_idx;
+	struct eip93_descriptor_s	*cdesc;
+	struct scatterlist		*sg_src;
+	struct scatterlist		*sg_dst;
+	int				src_nents;
+	int				dst_nents;
+	struct saState_s		*saState_ctr;
+	dma_addr_t			saState_base_ctr;
+	uint32_t			saState_ctr_idx;
+};
+
+int check_valid_request(struct mtk_cipher_reqctx *rctx);
+
+void mtk_unmap_dma(struct mtk_device *mtk, struct mtk_cipher_reqctx *rctx,
+			struct scatterlist *reqsrc, struct scatterlist *reqdst);
+
+int mtk_send_req(struct crypto_async_request *async,
+			const u8 *reqiv, struct mtk_cipher_reqctx *rctx);
+
+void mtk_handle_result(struct mtk_device *mtk, struct mtk_cipher_reqctx *rctx,
+			u8 *reqiv);
+
+#endif /* _EIP93_CIPHER_H_ */
diff --git a/drivers/crypto/mtk-eip93/eip93-common.c b/drivers/crypto/mtk-eip93/eip93-common.c
new file mode 100644
index 000000000..5b4235cfa
--- /dev/null
+++ b/drivers/crypto/mtk-eip93/eip93-common.c
@@ -0,0 +1,784 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 - 2021
+ *
+ * Richard van Schagen <vschagen@icloud.com>
+ */
+
+
+#include <crypto/aes.h>
+#include <crypto/ctr.h>
+#include <crypto/hmac.h>
+#include <crypto/sha1.h>
+#include <crypto/sha2.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/scatterlist.h>
+
+#include "eip93-main.h"
+#include "eip93-cipher.h"
+#include "eip93-regs.h"
+
+inline void *mtk_ring_next_wptr(struct mtk_device *mtk,
+						struct mtk_desc_ring *ring)
+{
+	void *ptr = ring->write;
+
+	if ((ring->write == ring->read - ring->offset) ||
+		(ring->read == ring->base && ring->write == ring->base_end))
+		return ERR_PTR(-ENOMEM);
+
+	if (ring->write == ring->base_end)
+		ring->write = ring->base;
+	else
+		ring->write += ring->offset;
+
+	return ptr;
+}
+
+inline void *mtk_ring_next_rptr(struct mtk_device *mtk,
+						struct mtk_desc_ring *ring)
+{
+	void *ptr = ring->read;
+
+	if (ring->write == ring->read)
+		return ERR_PTR(-ENOENT);
+
+	if (ring->read == ring->base_end)
+		ring->read = ring->base;
+	else
+		ring->read += ring->offset;
+
+	return ptr;
+}
+
+inline int mtk_put_descriptor(struct mtk_device *mtk,
+					struct eip93_descriptor_s *desc)
+{
+	struct eip93_descriptor_s *cdesc;
+	struct eip93_descriptor_s *rdesc;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&mtk->ring->write_lock, irqflags);
+
+	rdesc = mtk_ring_next_wptr(mtk, &mtk->ring->rdr);
+
+	if (IS_ERR(rdesc)) {
+		spin_unlock_irqrestore(&mtk->ring->write_lock, irqflags);
+		return -ENOENT;
+	}
+
+	cdesc = mtk_ring_next_wptr(mtk, &mtk->ring->cdr);
+
+	if (IS_ERR(cdesc)) {
+		spin_unlock_irqrestore(&mtk->ring->write_lock, irqflags);
+		return -ENOENT;
+	}
+
+	memset(rdesc, 0, sizeof(struct eip93_descriptor_s));
+
+	memcpy(cdesc, desc, sizeof(struct eip93_descriptor_s));
+
+	atomic_dec(&mtk->ring->free);
+	spin_unlock_irqrestore(&mtk->ring->write_lock, irqflags);
+
+	return 0;
+}
+
+inline void *mtk_get_descriptor(struct mtk_device *mtk)
+{
+	struct eip93_descriptor_s *cdesc;
+	void *ptr;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&mtk->ring->read_lock, irqflags);
+
+	cdesc = mtk_ring_next_rptr(mtk, &mtk->ring->cdr);
+
+	if (IS_ERR(cdesc)) {
+		spin_unlock_irqrestore(&mtk->ring->read_lock, irqflags);
+		return ERR_PTR(-ENOENT);
+	}
+
+	memset(cdesc, 0, sizeof(struct eip93_descriptor_s));
+
+	ptr = mtk_ring_next_rptr(mtk, &mtk->ring->rdr);
+	if (IS_ERR(ptr)) {
+		spin_unlock_irqrestore(&mtk->ring->read_lock, irqflags);
+		return ERR_PTR(-ENOENT);
+	}
+
+	atomic_inc(&mtk->ring->free);
+	spin_unlock_irqrestore(&mtk->ring->read_lock, irqflags);
+	return ptr;
+}
+
+inline int mtk_get_free_saState(struct mtk_device *mtk)
+{
+	struct mtk_state_pool *saState_pool;
+	int i;
+
+	for (i = 0; i < MTK_RING_SIZE; i++) {
+		saState_pool = &mtk->ring->saState_pool[i];
+		if (saState_pool->in_use == false) {
+			saState_pool->in_use = true;
+			return i;
+		}
+
+	}
+
+	return -ENOENT;
+}
+
+static inline void mtk_free_sg_copy(const int len, struct scatterlist **sg)
+{
+	if (!*sg || !len)
+		return;
+
+	free_pages((unsigned long)sg_virt(*sg), get_order(len));
+	kfree(*sg);
+	*sg = NULL;
+}
+
+static inline int mtk_make_sg_copy(struct scatterlist *src,
+			struct scatterlist **dst,
+			const uint32_t len, const bool copy)
+{
+	void *pages;
+
+	*dst = kmalloc(sizeof(**dst), GFP_KERNEL);
+	if (!*dst)
+		return -ENOMEM;
+
+
+	pages = (void *)__get_free_pages(GFP_KERNEL | GFP_DMA,
+					get_order(len));
+
+	if (!pages) {
+		kfree(*dst);
+		*dst = NULL;
+		return -ENOMEM;
+	}
+
+	sg_init_table(*dst, 1);
+	sg_set_buf(*dst, pages, len);
+
+	/* copy only as requested */
+	if (copy)
+		sg_copy_to_buffer(src, sg_nents(src), pages, len);
+
+	return 0;
+}
+
+static inline bool mtk_is_sg_aligned(struct scatterlist *sg, u32 len,
+						const int blksize)
+{
+	int nents;
+
+	for (nents = 0; sg; sg = sg_next(sg), ++nents) {
+		if (!IS_ALIGNED(sg->offset, 4))
+			return false;
+
+		if (len <= sg->length) {
+			if (!IS_ALIGNED(len, blksize))
+				return false;
+
+			return true;
+		}
+
+		if (!IS_ALIGNED(sg->length, blksize))
+			return false;
+
+		len -= sg->length;
+	}
+	return false;
+}
+
+int check_valid_request(struct mtk_cipher_reqctx *rctx)
+{
+	struct scatterlist *src = rctx->sg_src;
+	struct scatterlist *dst = rctx->sg_dst;
+	uint32_t src_nents, dst_nents;
+	u32 textsize = rctx->textsize;
+	u32 authsize = rctx->authsize;
+	u32 blksize = rctx->blksize;
+	u32 totlen_src = rctx->assoclen + rctx->textsize;
+	u32 totlen_dst = rctx->assoclen + rctx->textsize;
+	u32 copy_len;
+	bool src_align, dst_align;
+	int err = -EINVAL;
+
+	if (!IS_CTR(rctx->flags)) {
+		if (!IS_ALIGNED(textsize, blksize))
+			return err;
+	}
+
+	if (authsize) {
+		if (IS_ENCRYPT(rctx->flags))
+			totlen_dst += authsize;
+		else
+			totlen_src += authsize;
+	}
+
+	src_nents = sg_nents_for_len(src, totlen_src);
+	dst_nents = sg_nents_for_len(dst, totlen_dst);
+
+	if (src == dst) {
+		src_nents = max(src_nents, dst_nents);
+		dst_nents = src_nents;
+		if (unlikely((totlen_src || totlen_dst) && (src_nents <= 0)))
+			return err;
+
+	} else {
+		if (unlikely(totlen_src && (src_nents <= 0)))
+			return err;
+
+		if (unlikely(totlen_dst && (dst_nents <= 0)))
+			return err;
+	}
+
+	if (authsize) {
+		if (dst_nents == 1 && src_nents == 1) {
+			src_align = mtk_is_sg_aligned(src, totlen_src, blksize);
+			if (src ==  dst)
+				dst_align = src_align;
+			else
+				dst_align = mtk_is_sg_aligned(dst,
+						totlen_dst, blksize);
+		} else {
+			src_align = false;
+			dst_align = false;
+		}
+	} else {
+		src_align = mtk_is_sg_aligned(src, totlen_src, blksize);
+		if (src == dst)
+			dst_align = src_align;
+		else
+			dst_align = mtk_is_sg_aligned(dst, totlen_dst, blksize);
+	}
+
+	copy_len = max(totlen_src, totlen_dst);
+	if (!src_align) {
+		err = mtk_make_sg_copy(src, &rctx->sg_src, copy_len, true);
+		if (err)
+			return err;
+	}
+
+	if (!dst_align) {
+		err = mtk_make_sg_copy(dst, &rctx->sg_dst, copy_len, false);
+		if (err)
+			return err;
+	}
+
+	rctx->src_nents = sg_nents_for_len(rctx->sg_src, totlen_src);
+	rctx->dst_nents = sg_nents_for_len(rctx->sg_dst, totlen_dst);
+
+	return 0;
+}
+/*
+ * Set saRecord function:
+ * Even saRecord is set to "0", keep " = 0" for readability.
+ */
+void mtk_set_saRecord(struct saRecord_s *saRecord, const unsigned int keylen,
+				const u32 flags)
+{
+	saRecord->saCmd0.bits.ivSource = 2;
+	if (IS_ECB(flags))
+		saRecord->saCmd0.bits.saveIv = 0;
+	else
+		saRecord->saCmd0.bits.saveIv = 1;
+
+	saRecord->saCmd0.bits.opGroup = 0;
+	saRecord->saCmd0.bits.opCode = 0;
+
+	switch ((flags & MTK_ALG_MASK)) {
+	case MTK_ALG_AES:
+		saRecord->saCmd0.bits.cipher = 3;
+		saRecord->saCmd1.bits.aesKeyLen = keylen >> 3;
+		break;
+	case MTK_ALG_3DES:
+		saRecord->saCmd0.bits.cipher = 1;
+		break;
+	case MTK_ALG_DES:
+		saRecord->saCmd0.bits.cipher = 0;
+		break;
+	default:
+		saRecord->saCmd0.bits.cipher = 15;
+	}
+
+	switch ((flags & MTK_HASH_MASK)) {
+	case MTK_HASH_SHA256:
+		saRecord->saCmd0.bits.hash = 3;
+		break;
+	case MTK_HASH_SHA224:
+		saRecord->saCmd0.bits.hash = 2;
+		break;
+	case MTK_HASH_SHA1:
+		saRecord->saCmd0.bits.hash = 1;
+		break;
+	case MTK_HASH_MD5:
+		saRecord->saCmd0.bits.hash = 0;
+		break;
+	default:
+		saRecord->saCmd0.bits.hash = 15;
+	}
+
+	saRecord->saCmd0.bits.hdrProc = 0;
+	saRecord->saCmd0.bits.padType = 3;
+	saRecord->saCmd0.bits.extPad = 0;
+	saRecord->saCmd0.bits.scPad = 0;
+
+	switch ((flags & MTK_MODE_MASK)) {
+	case MTK_MODE_CBC:
+		saRecord->saCmd1.bits.cipherMode = 1;
+		break;
+	case MTK_MODE_CTR:
+		saRecord->saCmd1.bits.cipherMode = 2;
+		break;
+	case MTK_MODE_ECB:
+		saRecord->saCmd1.bits.cipherMode = 0;
+		break;
+	}
+
+	saRecord->saCmd1.bits.byteOffset = 0;
+	saRecord->saCmd1.bits.hashCryptOffset = 0;
+	saRecord->saCmd0.bits.digestLength = 0;
+	saRecord->saCmd1.bits.copyPayload = 0;
+
+	if (IS_HMAC(flags)) {
+		saRecord->saCmd1.bits.hmac = 1;
+		saRecord->saCmd1.bits.copyDigest = 1;
+		saRecord->saCmd1.bits.copyHeader = 1;
+	} else {
+		saRecord->saCmd1.bits.hmac = 0;
+		saRecord->saCmd1.bits.copyDigest = 0;
+		saRecord->saCmd1.bits.copyHeader = 0;
+	}
+
+	/* Default for now, might be used for ESP offload */
+	saRecord->saCmd1.bits.seqNumCheck = 0;
+	saRecord->saSpi = 0x0;
+	saRecord->saSeqNumMask[0] = 0xFFFFFFFF;
+	saRecord->saSeqNumMask[1] = 0x0;
+}
+
+/*
+ * Poor mans Scatter/gather function:
+ * Create a Descriptor for every segment to avoid copying buffers.
+ * For performance better to wait for hardware to perform multiple DMA
+ *
+ */
+static inline int mtk_scatter_combine(struct mtk_device *mtk,
+			struct mtk_cipher_reqctx *rctx,
+			u32 datalen, u32 split, int offsetin)
+{
+	struct eip93_descriptor_s *cdesc = rctx->cdesc;
+	struct scatterlist *sgsrc = rctx->sg_src;
+	struct scatterlist *sgdst = rctx->sg_dst;
+	unsigned int remainin = sg_dma_len(sgsrc);
+	unsigned int remainout = sg_dma_len(sgdst);
+	dma_addr_t saddr = sg_dma_address(sgsrc);
+	dma_addr_t daddr = sg_dma_address(sgdst);
+	dma_addr_t stateAddr;
+	u32 srcAddr, dstAddr, len, n;
+	bool nextin = false;
+	bool nextout = false;
+	int offsetout = 0;
+	int ndesc_cdr = 0, err;
+
+	if (IS_ECB(rctx->flags))
+		rctx->saState_base = 0;
+
+	if (split < datalen) {
+		stateAddr = rctx->saState_base_ctr;
+		n = split;
+	} else {
+		stateAddr = rctx->saState_base;
+		n = datalen;
+	}
+
+	do {
+		if (nextin) {
+			sgsrc = sg_next(sgsrc);
+			remainin = sg_dma_len(sgsrc);
+			if (remainin == 0)
+				continue;
+
+			saddr = sg_dma_address(sgsrc);
+			offsetin = 0;
+			nextin = false;
+		}
+
+		if (nextout) {
+			sgdst = sg_next(sgdst);
+			remainout = sg_dma_len(sgdst);
+			if (remainout == 0)
+				continue;
+
+			daddr = sg_dma_address(sgdst);
+			offsetout = 0;
+			nextout = false;
+		}
+		srcAddr = saddr + offsetin;
+		dstAddr = daddr + offsetout;
+
+		if (remainin == remainout) {
+			len = remainin;
+			if (len > n) {
+				len = n;
+				remainin -= n;
+				remainout -= n;
+				offsetin += n;
+				offsetout += n;
+			} else {
+				nextin = true;
+				nextout = true;
+			}
+		} else if (remainin < remainout) {
+			len = remainin;
+			if (len > n) {
+				len = n;
+				remainin -= n;
+				remainout -= n;
+				offsetin += n;
+				offsetout += n;
+			} else {
+				offsetout += len;
+				remainout -= len;
+				nextin = true;
+			}
+		} else {
+			len = remainout;
+			if (len > n) {
+				len = n;
+				remainin -= n;
+				remainout -= n;
+				offsetin += n;
+				offsetout += n;
+			} else {
+				offsetin += len;
+				remainin -= len;
+				nextout = true;
+			}
+		}
+		n -= len;
+
+		cdesc->srcAddr = srcAddr;
+		cdesc->dstAddr = dstAddr;
+		cdesc->stateAddr = stateAddr;
+		cdesc->peLength.bits.peReady = 0;
+		cdesc->peLength.bits.byPass = 0;
+		cdesc->peLength.bits.length = len;
+		cdesc->peLength.bits.hostReady = 1;
+
+		if (n == 0) {
+			n = datalen - split;
+			split = datalen;
+			stateAddr = rctx->saState_base;
+		}
+
+		if (n == 0)
+			cdesc->userId |= MTK_DESC_LAST;
+
+		/* Loop - Delay - No need to rollback
+		 * Maybe refine by slowing down at MTK_RING_BUSY
+		 */
+again:
+		err = mtk_put_descriptor(mtk, cdesc);
+		if (err) {
+			udelay(500);
+			goto again;
+		}
+		/* Writing new descriptor count starts DMA action */
+		writel(1, mtk->base + EIP93_REG_PE_CD_COUNT);
+
+		ndesc_cdr++;
+	} while (n);
+
+	return -EINPROGRESS;
+}
+
+int mtk_send_req(struct crypto_async_request *async,
+			const u8 *reqiv, struct mtk_cipher_reqctx *rctx)
+{
+	struct mtk_crypto_ctx *ctx = crypto_tfm_ctx(async->tfm);
+	struct mtk_device *mtk = ctx->mtk;
+	struct scatterlist *src = rctx->sg_src;
+	struct scatterlist *dst = rctx->sg_dst;
+	struct saState_s *saState;
+	struct mtk_state_pool *saState_pool;
+	struct eip93_descriptor_s cdesc;
+	u32 flags = rctx->flags;
+	int idx;
+	int offsetin = 0, err = -ENOMEM;
+	u32 datalen = rctx->assoclen + rctx->textsize;
+	u32 split = datalen;
+	u32 start, end, ctr, blocks;
+	u32 iv[AES_BLOCK_SIZE / sizeof(u32)];
+
+	rctx->saState_ctr = NULL;
+	rctx->saState = NULL;
+
+	if (IS_ECB(flags))
+		goto skip_iv;
+
+	memcpy(iv, reqiv, rctx->ivsize);
+
+	if (!IS_ALIGNED((u32)reqiv, rctx->ivsize) || IS_RFC3686(flags)) {
+		rctx->flags &= ~MTK_DESC_DMA_IV;
+		flags = rctx->flags;
+	}
+
+	if (IS_DMA_IV(flags)) {
+		rctx->saState = (void *)reqiv;
+	} else  {
+		idx = mtk_get_free_saState(mtk);
+		if (idx < 0)
+			goto send_err;
+		saState_pool = &mtk->ring->saState_pool[idx];
+		rctx->saState_idx = idx;
+		rctx->saState = saState_pool->base;
+		rctx->saState_base = saState_pool->base_dma;
+		memcpy(rctx->saState->stateIv, iv, rctx->ivsize);
+	}
+
+	saState = rctx->saState;
+
+	if (IS_RFC3686(flags)) {
+		saState->stateIv[0] = ctx->saNonce;
+		saState->stateIv[1] = iv[0];
+		saState->stateIv[2] = iv[1];
+		saState->stateIv[3] = cpu_to_be32(1);
+	} else if (!IS_HMAC(flags) && IS_CTR(flags)) {
+		/* Compute data length. */
+		blocks = DIV_ROUND_UP(rctx->textsize, AES_BLOCK_SIZE);
+		ctr = be32_to_cpu(iv[3]);
+		/* Check 32bit counter overflow. */
+		start = ctr;
+		end = start + blocks - 1;
+		if (end < start) {
+			split = AES_BLOCK_SIZE * -start;
+			/*
+			 * Increment the counter manually to cope with
+			 * the hardware counter overflow.
+			 */
+			iv[3] = 0xffffffff;
+			crypto_inc((u8 *)iv, AES_BLOCK_SIZE);
+			idx = mtk_get_free_saState(mtk);
+			if (idx < 0)
+				goto free_state;
+			saState_pool = &mtk->ring->saState_pool[idx];
+			rctx->saState_ctr_idx = idx;
+			rctx->saState_ctr = saState_pool->base;
+			rctx->saState_base_ctr = saState_pool->base_dma;
+
+			memcpy(rctx->saState_ctr->stateIv, reqiv, rctx->ivsize);
+			memcpy(saState->stateIv, iv, rctx->ivsize);
+		}
+	}
+
+	if (IS_DMA_IV(flags)) {
+		rctx->saState_base = dma_map_single(mtk->dev, (void *)reqiv,
+						rctx->ivsize, DMA_TO_DEVICE);
+		if (dma_mapping_error(mtk->dev, rctx->saState_base))
+			goto free_state;
+	}
+skip_iv:
+	cdesc.peCrtlStat.bits.hostReady = 1;
+	cdesc.peCrtlStat.bits.prngMode = 0;
+	cdesc.peCrtlStat.bits.hashFinal = 0;
+	cdesc.peCrtlStat.bits.padCrtlStat = 0;
+	cdesc.peCrtlStat.bits.peReady = 0;
+	cdesc.saAddr = rctx->saRecord_base;
+	cdesc.arc4Addr = (u32)async;
+	if (ctx->type == MTK_ALG_TYPE_AEAD)
+		cdesc.userId = MTK_DESC_AEAD;
+	else
+		cdesc.userId = MTK_DESC_SKCIPHER;
+	rctx->cdesc = &cdesc;
+
+	/* map DMA_BIDIRECTIONAL to invalidate cache on destination
+	 * implies __dma_cache_wback_inv
+	 */
+	dma_map_sg(mtk->dev, dst, rctx->dst_nents, DMA_BIDIRECTIONAL);
+	if (src != dst)
+		dma_map_sg(mtk->dev, src, rctx->src_nents, DMA_TO_DEVICE);
+
+	err = mtk_scatter_combine(mtk, rctx, datalen, split, offsetin);
+
+	return err;
+
+free_state:
+	if (rctx->saState) {
+		saState_pool = &mtk->ring->saState_pool[rctx->saState_idx];
+		saState_pool->in_use = false;
+	}
+
+	if (rctx->saState_ctr) {
+		saState_pool = &mtk->ring->saState_pool[rctx->saState_ctr_idx];
+		saState_pool->in_use = false;
+	}
+send_err:
+	return err;
+}
+
+void mtk_unmap_dma(struct mtk_device *mtk, struct mtk_cipher_reqctx *rctx,
+			struct scatterlist *reqsrc, struct scatterlist *reqdst)
+{
+	u32 len = rctx->assoclen + rctx->textsize;
+	u32 authsize = rctx->authsize;
+	u32 flags = rctx->flags;
+	u32 *otag;
+	int i;
+
+	if (rctx->sg_src == rctx->sg_dst) {
+		dma_unmap_sg(mtk->dev, rctx->sg_dst, rctx->dst_nents,
+							DMA_BIDIRECTIONAL);
+		goto process_tag;
+	}
+
+	dma_unmap_sg(mtk->dev, rctx->sg_src, rctx->src_nents,
+							DMA_TO_DEVICE);
+
+	if (rctx->sg_src != reqsrc)
+		mtk_free_sg_copy(len +  rctx->authsize, &rctx->sg_src);
+
+	dma_unmap_sg(mtk->dev, rctx->sg_dst, rctx->dst_nents,
+							DMA_BIDIRECTIONAL);
+
+	/* SHA tags need conversion from net-to-host */
+process_tag:
+	if (IS_DECRYPT(flags))
+		authsize = 0;
+
+	if (authsize) {
+		if (!IS_HASH_MD5(flags)) {
+			otag = sg_virt(rctx->sg_dst) + len;
+			for (i = 0; i < (authsize / 4); i++)
+				otag[i] = ntohl(otag[i]);
+		}
+	}
+
+	if (rctx->sg_dst != reqdst) {
+		sg_copy_from_buffer(reqdst, sg_nents(reqdst),
+				sg_virt(rctx->sg_dst), len + authsize);
+		mtk_free_sg_copy(len + rctx->authsize, &rctx->sg_dst);
+	}
+}
+
+void mtk_handle_result(struct mtk_device *mtk, struct mtk_cipher_reqctx *rctx,
+			u8 *reqiv)
+{
+	struct mtk_state_pool *saState_pool;
+
+	if (IS_DMA_IV(rctx->flags))
+		dma_unmap_single(mtk->dev, rctx->saState_base, rctx->ivsize,
+						DMA_TO_DEVICE);
+
+	if (!IS_ECB(rctx->flags))
+		memcpy(reqiv, rctx->saState->stateIv, rctx->ivsize);
+
+	if ((rctx->saState) && !(IS_DMA_IV(rctx->flags))) {
+		saState_pool = &mtk->ring->saState_pool[rctx->saState_idx];
+		saState_pool->in_use = false;
+	}
+
+	if (rctx->saState_ctr) {
+		saState_pool = &mtk->ring->saState_pool[rctx->saState_ctr_idx];
+		saState_pool->in_use = false;
+	}
+}
+
+#if IS_ENABLED(CONFIG_CRYPTO_DEV_EIP93_SKCIPHER)
+int mtk_skcipher_send_req(struct crypto_async_request *async)
+{
+	struct skcipher_request *req = skcipher_request_cast(async);
+	struct mtk_cipher_reqctx *rctx = skcipher_request_ctx(req);
+	int err;
+
+	err = check_valid_request(rctx);
+
+	if (err) {
+		skcipher_request_complete(req, err);
+		return err;
+	}
+
+	return mtk_send_req(async, req->iv, rctx);
+}
+
+void mtk_skcipher_handle_result(struct mtk_device *mtk,
+				struct crypto_async_request *async,
+				int err)
+{
+	struct skcipher_request *req = skcipher_request_cast(async);
+	struct mtk_cipher_reqctx *rctx = skcipher_request_ctx(req);
+
+	mtk_unmap_dma(mtk, rctx, req->src, req->dst);
+	mtk_handle_result(mtk, rctx, req->iv);
+
+	skcipher_request_complete(req, err);
+}
+#endif
+
+#if IS_ENABLED(CONFIG_CRYPTO_DEV_EIP93_HMAC)
+/* basically this is set hmac - key */
+int mtk_authenc_setkey(struct crypto_shash *cshash, struct saRecord_s *sa,
+			const u8 *authkey, unsigned int authkeylen)
+{
+	int bs = crypto_shash_blocksize(cshash);
+	int ds = crypto_shash_digestsize(cshash);
+	int ss = crypto_shash_statesize(cshash);
+	u8 *ipad, *opad;
+	unsigned int i, err;
+
+	SHASH_DESC_ON_STACK(shash, cshash);
+
+	shash->tfm = cshash;
+
+	/* auth key
+	 *
+	 * EIP93 can only authenticate with hash of the key
+	 * do software shash until EIP93 hash function complete.
+	 */
+	ipad = kcalloc(2, SHA256_BLOCK_SIZE + ss, GFP_KERNEL);
+	if (!ipad)
+		return -ENOMEM;
+
+	opad = ipad + SHA256_BLOCK_SIZE + ss;
+
+	if (authkeylen > bs) {
+		err = crypto_shash_digest(shash, authkey,
+					authkeylen, ipad);
+		if (err)
+			return err;
+
+		authkeylen = ds;
+	} else
+		memcpy(ipad, authkey, authkeylen);
+
+	memset(ipad + authkeylen, 0, bs - authkeylen);
+	memcpy(opad, ipad, bs);
+
+	for (i = 0; i < bs; i++) {
+		ipad[i] ^= HMAC_IPAD_VALUE;
+		opad[i] ^= HMAC_OPAD_VALUE;
+	}
+
+	err = crypto_shash_init(shash) ?:
+		crypto_shash_update(shash, ipad, bs) ?:
+		crypto_shash_export(shash, ipad) ?:
+		crypto_shash_init(shash) ?:
+		crypto_shash_update(shash, opad, bs) ?:
+		crypto_shash_export(shash, opad);
+
+	if (err)
+		return err;
+
+	/* add auth key */
+	memcpy(&sa->saIDigest, ipad, SHA256_DIGEST_SIZE);
+	memcpy(&sa->saODigest, opad, SHA256_DIGEST_SIZE);
+
+	kfree(ipad);
+	return 0;
+}
+#endif
diff --git a/drivers/crypto/mtk-eip93/eip93-common.h b/drivers/crypto/mtk-eip93/eip93-common.h
new file mode 100644
index 000000000..e67a5da94
--- /dev/null
+++ b/drivers/crypto/mtk-eip93/eip93-common.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2019 - 2021
+ *
+ * Richard van Schagen <vschagen@icloud.com>
+ */
+
+#ifndef _EIP93_COMMON_H_
+#define _EIP93_COMMON_H_
+
+inline int mtk_put_descriptor(struct mtk_device *mtk,
+					struct eip93_descriptor_s *desc);
+
+inline void *mtk_get_descriptor(struct mtk_device *mtk);
+
+inline int mtk_get_free_saState(struct mtk_device *mtk);
+
+void mtk_set_saRecord(struct saRecord_s *saRecord, const unsigned int keylen,
+				const u32 flags);
+
+#if IS_ENABLED(CONFIG_CRYPTO_DEV_EIP93_SKCIPHER)
+int mtk_skcipher_send_req(struct crypto_async_request *async);
+
+void mtk_skcipher_handle_result(struct mtk_device *mtk,
+				struct crypto_async_request *async,
+				int err);
+#endif
+
+#if IS_ENABLED(CONFIG_CRYPTO_DEV_EIP93_HMAC)
+int mtk_authenc_setkey(struct crypto_shash *cshash, struct saRecord_s *sa,
+			const u8 *authkey, unsigned int authkeylen);
+#endif
+
+#endif /* _EIP93_COMMON_H_ */
diff --git a/drivers/crypto/mtk-eip93/eip93-des.h b/drivers/crypto/mtk-eip93/eip93-des.h
new file mode 100644
index 000000000..9af79f2fb
--- /dev/null
+++ b/drivers/crypto/mtk-eip93/eip93-des.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2019 - 2021
+ *
+ * Richard van Schagen <vschagen@icloud.com>
+ */
+#ifndef _EIP93_DES_H_
+#define _EIP93_DES_H_
+
+extern struct mtk_alg_template mtk_alg_ecb_des;
+extern struct mtk_alg_template mtk_alg_cbc_des;
+extern struct mtk_alg_template mtk_alg_ecb_des3_ede;
+extern struct mtk_alg_template mtk_alg_cbc_des3_ede;
+
+#endif /* _EIP93_DES_H_ */
diff --git a/drivers/crypto/mtk-eip93/eip93-main.c b/drivers/crypto/mtk-eip93/eip93-main.c
new file mode 100644
index 000000000..78e9a5994
--- /dev/null
+++ b/drivers/crypto/mtk-eip93/eip93-main.c
@@ -0,0 +1,458 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 - 2021
+ *
+ * Richard van Schagen <vschagen@icloud.com>
+ */
+
+#include <linux/atomic.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+
+#include "eip93-main.h"
+#include "eip93-regs.h"
+#include "eip93-common.h"
+
+#if IS_ENABLED(CONFIG_CRYPTO_DEV_EIP93_AES)
+#include "eip93-aes.h"
+#endif
+#if IS_ENABLED(CONFIG_CRYPTO_DEV_EIP93_DES)
+#include "eip93-des.h"
+#endif
+#if IS_ENABLED(CONFIG_CRYPTO_DEV_EIP93_AEAD)
+#include "eip93-aead.h"
+#endif
+
+static struct mtk_alg_template *mtk_algs[] = {
+#if IS_ENABLED(CONFIG_CRYPTO_DEV_EIP93_DES)
+	&mtk_alg_ecb_des,
+	&mtk_alg_cbc_des,
+	&mtk_alg_ecb_des3_ede,
+	&mtk_alg_cbc_des3_ede,
+#endif
+#if IS_ENABLED(CONFIG_CRYPTO_DEV_EIP93_AES)
+	&mtk_alg_ecb_aes,
+	&mtk_alg_cbc_aes,
+	&mtk_alg_ctr_aes,
+	&mtk_alg_rfc3686_aes,
+#endif
+#if IS_ENABLED(CONFIG_CRYPTO_DEV_EIP93_AEAD)
+#if IS_ENABLED(CONFIG_CRYPTO_DEV_EIP93_DES)
+	&mtk_alg_authenc_hmac_md5_cbc_des,
+	&mtk_alg_authenc_hmac_sha1_cbc_des,
+	&mtk_alg_authenc_hmac_sha224_cbc_des,
+	&mtk_alg_authenc_hmac_sha256_cbc_des,
+	&mtk_alg_authenc_hmac_md5_cbc_des3_ede,
+	&mtk_alg_authenc_hmac_sha1_cbc_des3_ede,
+	&mtk_alg_authenc_hmac_sha224_cbc_des3_ede,
+	&mtk_alg_authenc_hmac_sha256_cbc_des3_ede,
+#endif
+	&mtk_alg_authenc_hmac_md5_cbc_aes,
+	&mtk_alg_authenc_hmac_sha1_cbc_aes,
+	&mtk_alg_authenc_hmac_sha224_cbc_aes,
+	&mtk_alg_authenc_hmac_sha256_cbc_aes,
+	&mtk_alg_authenc_hmac_md5_rfc3686_aes,
+	&mtk_alg_authenc_hmac_sha1_rfc3686_aes,
+	&mtk_alg_authenc_hmac_sha224_rfc3686_aes,
+	&mtk_alg_authenc_hmac_sha256_rfc3686_aes,
+#endif
+};
+
+inline void mtk_irq_disable(struct mtk_device *mtk, u32 mask)
+{
+	__raw_writel(mask, mtk->base + EIP93_REG_MASK_DISABLE);
+}
+
+inline void mtk_irq_enable(struct mtk_device *mtk, u32 mask)
+{
+	__raw_writel(mask, mtk->base + EIP93_REG_MASK_ENABLE);
+}
+
+inline void mtk_irq_clear(struct mtk_device *mtk, u32 mask)
+{
+	__raw_writel(mask, mtk->base + EIP93_REG_INT_CLR);
+}
+
+static void mtk_unregister_algs(struct mtk_device *mtk, int i)
+{
+	int j;
+
+	for (j = 0; j < i; j++) {
+		switch (mtk_algs[j]->type) {
+		case MTK_ALG_TYPE_SKCIPHER:
+			crypto_unregister_skcipher(&mtk_algs[j]->alg.skcipher);
+			break;
+		case MTK_ALG_TYPE_AEAD:
+			crypto_unregister_aead(&mtk_algs[j]->alg.aead);
+			break;
+		}
+	}
+}
+
+static int mtk_register_algs(struct mtk_device *mtk)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < ARRAY_SIZE(mtk_algs); i++) {
+		mtk_algs[i]->mtk = mtk;
+
+		switch (mtk_algs[i]->type) {
+		case MTK_ALG_TYPE_SKCIPHER:
+			ret = crypto_register_skcipher(&mtk_algs[i]->alg.skcipher);
+			break;
+		case MTK_ALG_TYPE_AEAD:
+			ret = crypto_register_aead(&mtk_algs[i]->alg.aead);
+			break;
+		}
+		if (ret)
+			goto fail;
+	}
+
+	return 0;
+
+fail:
+	mtk_unregister_algs(mtk, i);
+
+	return ret;
+}
+
+void mtk_handle_result_descriptor(struct mtk_device *mtk)
+{
+	struct crypto_async_request *async;
+	struct eip93_descriptor_s *rdesc;
+	bool last_entry;
+	u32 flags;
+	int handled, ready, err;
+	union peCrtlStat_w	done1;
+	union peLength_w	done2;
+
+get_more:
+	handled = 0;
+
+	ready = readl(mtk->base + EIP93_REG_PE_RD_COUNT) & GENMASK(10, 0);
+
+	if (!ready) {
+		mtk_irq_clear(mtk, EIP93_INT_PE_RDRTHRESH_REQ);
+		mtk_irq_enable(mtk, EIP93_INT_PE_RDRTHRESH_REQ);
+		return;
+	}
+
+	last_entry = false;
+
+	while (ready) {
+		rdesc = mtk_get_descriptor(mtk);
+		if (IS_ERR(rdesc)) {
+			dev_err(mtk->dev, "Ndesc: %d nreq: %d\n",
+				handled, ready);
+			err = -EIO;
+			break;
+		}
+		/* make sure DMA is finished writing */
+		do {
+			done1.word = READ_ONCE(rdesc->peCrtlStat.word);
+			done2.word = READ_ONCE(rdesc->peLength.word);
+		} while ((!done1.bits.peReady) || (!done2.bits.peReady));
+
+		err = rdesc->peCrtlStat.bits.errStatus;
+
+		flags = rdesc->userId;
+		async = (struct crypto_async_request *)rdesc->arc4Addr;
+
+		writel(1, mtk->base + EIP93_REG_PE_RD_COUNT);
+		mtk_irq_clear(mtk, EIP93_INT_PE_RDRTHRESH_REQ);
+
+		handled++;
+		ready--;
+
+		if (flags & MTK_DESC_LAST) {
+			last_entry = true;
+			break;
+		}
+	}
+
+	if (!last_entry)
+		goto get_more;
+#if IS_ENABLED(CONFIG_CRYPTO_DEV_EIP93_SKCIPHER)
+	if (flags & MTK_DESC_SKCIPHER)
+		mtk_skcipher_handle_result(mtk, async, err);
+#endif
+#if IS_ENABLED(CONFIG_CRYPTO_DEV_EIP93_AEAD)
+	if (flags & MTK_DESC_AEAD)
+		mtk_aead_handle_result(mtk, async, err);
+#endif
+	goto get_more;
+}
+
+static void mtk_done_task(unsigned long data)
+{
+	struct mtk_device *mtk = (struct mtk_device *)data;
+
+	mtk_handle_result_descriptor(mtk);
+}
+
+static irqreturn_t mtk_irq_handler(int irq, void *dev_id)
+{
+	struct mtk_device *mtk = (struct mtk_device *)dev_id;
+	u32 irq_status;
+
+	irq_status = readl(mtk->base + EIP93_REG_INT_MASK_STAT);
+
+	if (irq_status & EIP93_INT_PE_RDRTHRESH_REQ) {
+		mtk_irq_disable(mtk, EIP93_INT_PE_RDRTHRESH_REQ);
+		tasklet_schedule(&mtk->ring->done_task);
+		return IRQ_HANDLED;
+	}
+
+/* TODO: error handler; for now just clear ALL */
+	mtk_irq_clear(mtk, irq_status);
+	if (irq_status)
+		mtk_irq_disable(mtk, irq_status);
+
+	return IRQ_NONE;
+}
+
+void mtk_initialize(struct mtk_device *mtk)
+{
+	union peConfig_w peConfig;
+	union peEndianCfg_w peEndianCfg;
+	union peIntCfg_w peIntCfg;
+	union peClockCfg_w peClockCfg;
+	union peBufThresh_w peBufThresh;
+	union peRingThresh_w peRingThresh;
+
+	/* Reset Engine and setup Mode */
+	peConfig.word = 0;
+	peConfig.bits.resetPE = 1;
+	peConfig.bits.resetRing = 1;
+	peConfig.bits.peMode = 3;
+	peConfig.bits.enCDRupdate = 1;
+
+	writel(peConfig.word, mtk->base + EIP93_REG_PE_CONFIG);
+
+	udelay(10);
+
+	peConfig.bits.resetPE = 0;
+	peConfig.bits.resetRing = 0;
+
+	writel(peConfig.word, mtk->base + EIP93_REG_PE_CONFIG);
+
+	/* Initialize the BYTE_ORDER_CFG register */
+	peEndianCfg.word = 0;
+	writel(peEndianCfg.word, mtk->base + EIP93_REG_PE_ENDIAN_CONFIG);
+
+	/* Initialize the INT_CFG register */
+	peIntCfg.word = 0;
+	writel(peIntCfg.word, mtk->base + EIP93_REG_INT_CFG);
+
+	/* Config Clocks */
+	peClockCfg.word = 0;
+	peClockCfg.bits.enPEclk = 1;
+#if IS_ENABLED(CONFIG_CRYPTO_DEV_EIP93_DES)
+	peClockCfg.bits.enDESclk = 1;
+#endif
+#if IS_ENABLED(CONFIG_CRYPTO_DEV_EIP93_AES)
+	peClockCfg.bits.enAESclk = 1;
+#endif
+#if IS_ENABLED(CONFIG_CRYPTO_DEV_EIP93_HMAC)
+	peClockCfg.bits.enHASHclk = 1;
+#endif
+	writel(peClockCfg.word, mtk->base + EIP93_REG_PE_CLOCK_CTRL);
+
+	/* Config DMA thresholds */
+	peBufThresh.word = 0;
+	peBufThresh.bits.inputBuffer  = 128;
+	peBufThresh.bits.outputBuffer = 128;
+
+	writel(peBufThresh.word, mtk->base + EIP93_REG_PE_BUF_THRESH);
+
+	/* Clear/ack all interrupts before disable all */
+	mtk_irq_clear(mtk, 0xFFFFFFFF);
+	mtk_irq_disable(mtk, 0xFFFFFFFF);
+
+	/* Config Ring Threshold */
+	peRingThresh.word = 0;
+	peRingThresh.bits.CDRThresh = MTK_RING_SIZE - MTK_RING_BUSY;
+	peRingThresh.bits.RDRThresh = 1;
+	peRingThresh.bits.RDTimeout = 5;
+	peRingThresh.bits.enTimeout = 1;
+
+	writel(peRingThresh.word, mtk->base + EIP93_REG_PE_RING_THRESH);
+}
+
+static void mtk_desc_free(struct mtk_device *mtk,
+				struct mtk_desc_ring *cdr,
+				struct mtk_desc_ring *rdr)
+{
+	writel(0, mtk->base + EIP93_REG_PE_RING_CONFIG);
+	writel(0, mtk->base + EIP93_REG_PE_CDR_BASE);
+	writel(0, mtk->base + EIP93_REG_PE_RDR_BASE);
+}
+
+static int mtk_desc_init(struct mtk_device *mtk,
+			struct mtk_desc_ring *cdr,
+			struct mtk_desc_ring *rdr)
+{
+	struct mtk_state_pool *saState_pool;
+	union peRingCfg_w peRingCfg;
+	int RingOffset, RingSize, i;
+
+
+	RingOffset = sizeof(struct eip93_descriptor_s);
+	RingSize = MTK_RING_SIZE - 1;
+
+	cdr->offset = RingOffset;
+	cdr->base = dmam_alloc_coherent(mtk->dev, cdr->offset * MTK_RING_SIZE,
+					&cdr->base_dma, GFP_KERNEL);
+	if (!cdr->base)
+		return -ENOMEM;
+
+	cdr->write = cdr->base;
+	cdr->base_end = cdr->base + cdr->offset * RingSize;
+	cdr->read  = cdr->base;
+
+	rdr->offset = RingOffset;
+	rdr->base = dmam_alloc_coherent(mtk->dev, rdr->offset * MTK_RING_SIZE,
+					&rdr->base_dma, GFP_KERNEL);
+	if (!rdr->base)
+		return -ENOMEM;
+
+	rdr->write = rdr->base;
+	rdr->base_end = rdr->base + rdr->offset * RingSize;
+	rdr->read  = rdr->base;
+
+	writel((u32)cdr->base_dma, mtk->base + EIP93_REG_PE_CDR_BASE);
+	writel((u32)rdr->base_dma, mtk->base + EIP93_REG_PE_RDR_BASE);
+
+	peRingCfg.word = 0;
+	peRingCfg.bits.ringSize = RingSize;
+	peRingCfg.bits.ringOffset = RingOffset / 4;
+
+	writel(peRingCfg.word, mtk->base + EIP93_REG_PE_RING_CONFIG);
+
+	atomic_set(&mtk->ring->free, RingSize);
+	/* Create State record DMA pool */
+	RingOffset = sizeof(struct saState_s);
+	RingSize =  RingOffset * MTK_RING_SIZE;
+	mtk->ring->saState = dmam_alloc_coherent(mtk->dev, RingSize,
+					&mtk->ring->saState_dma, GFP_KERNEL);
+	if (!mtk->ring->saState)
+		return -ENOMEM;
+
+	mtk->ring->saState_pool = devm_kcalloc(mtk->dev, 1,
+				sizeof(struct mtk_state_pool) * MTK_RING_SIZE,
+				GFP_KERNEL);
+
+	for (i = 0; i < MTK_RING_SIZE; i++) {
+		saState_pool = &mtk->ring->saState_pool[i];
+		saState_pool->base = mtk->ring->saState + (i * RingOffset);
+		saState_pool->base_dma = mtk->ring->saState_dma + (i * RingOffset);
+		saState_pool->in_use = false;
+	}
+
+	return 0;
+}
+
+static int mtk_crypto_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_device *mtk;
+	struct resource *res;
+	int ret;
+
+	mtk = devm_kzalloc(dev, sizeof(*mtk), GFP_KERNEL);
+	if (!mtk)
+		return -ENOMEM;
+
+	mtk->dev = dev;
+	platform_set_drvdata(pdev, mtk);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mtk->base = devm_ioremap_resource(&pdev->dev, res);
+
+	if (IS_ERR(mtk->base))
+		return PTR_ERR(mtk->base);
+
+	mtk->irq = platform_get_irq(pdev, 0);
+
+	if (mtk->irq < 0)
+		return mtk->irq;
+
+	ret = devm_request_threaded_irq(mtk->dev, mtk->irq, mtk_irq_handler,
+					NULL, IRQF_ONESHOT,
+					dev_name(mtk->dev), mtk);
+
+	mtk->ring = devm_kcalloc(mtk->dev, 1, sizeof(*mtk->ring), GFP_KERNEL);
+
+	if (!mtk->ring)
+		return -ENOMEM;
+
+	ret = mtk_desc_init(mtk, &mtk->ring->cdr, &mtk->ring->rdr);
+
+	if (ret)
+		return ret;
+
+	tasklet_init(&mtk->ring->done_task, mtk_done_task, (unsigned long)mtk);
+
+	spin_lock_init(&mtk->ring->read_lock);
+	spin_lock_init(&mtk->ring->write_lock);
+
+	mtk_initialize(mtk);
+
+	/* Init. finished, enable RDR interupt */
+	mtk_irq_enable(mtk, EIP93_INT_PE_RDRTHRESH_REQ);
+
+	ret = mtk_register_algs(mtk);
+
+	dev_info(mtk->dev, "EIP93 Crypto Engine Initialized.");
+
+	return 0;
+}
+
+static int mtk_crypto_remove(struct platform_device *pdev)
+{
+	struct mtk_device *mtk = platform_get_drvdata(pdev);
+
+	mtk_unregister_algs(mtk, ARRAY_SIZE(mtk_algs));
+
+	tasklet_kill(&mtk->ring->done_task);
+
+	/* Clear/ack all interrupts before disable all */
+	mtk_irq_clear(mtk, 0xFFFFFFFF);
+	mtk_irq_disable(mtk, 0xFFFFFFFF);
+
+	writel(0, mtk->base + EIP93_REG_PE_CLOCK_CTRL);
+
+	mtk_desc_free(mtk, &mtk->ring->cdr, &mtk->ring->rdr);
+	dev_info(mtk->dev, "EIP93 removed.\n");
+
+	return 0;
+}
+
+#if defined(CONFIG_OF)
+static const struct of_device_id mtk_crypto_of_match[] = {
+	{ .compatible = "mediatek,mtk-eip93", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mtk_crypto_of_match);
+#endif
+
+static struct platform_driver mtk_crypto_driver = {
+	.probe = mtk_crypto_probe,
+	.remove = mtk_crypto_remove,
+	.driver = {
+		.name = "mtk-eip93",
+		.of_match_table = of_match_ptr(mtk_crypto_of_match),
+	},
+};
+module_platform_driver(mtk_crypto_driver);
+
+MODULE_AUTHOR("Richard van Schagen <vschagen@cs.com>");
+MODULE_ALIAS("platform:" KBUILD_MODNAME);
+MODULE_DESCRIPTION("Mediatek EIP-93 crypto engine driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/crypto/mtk-eip93/eip93-main.h b/drivers/crypto/mtk-eip93/eip93-main.h
new file mode 100644
index 000000000..159f28c64
--- /dev/null
+++ b/drivers/crypto/mtk-eip93/eip93-main.h
@@ -0,0 +1,146 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2019 - 2021
+ *
+ * Richard van Schagen <vschagen@icloud.com>
+ */
+#ifndef _EIP93_MAIN_H_
+#define _EIP93_MAIN_H_
+
+#include <crypto/internal/aead.h>
+#include <crypto/internal/hash.h>
+#include <crypto/internal/rng.h>
+#include <crypto/internal/skcipher.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+
+#define MTK_RING_SIZE			512
+#define MTK_RING_BUSY			32
+#define MTK_CRA_PRIORITY		1500
+
+/* cipher algorithms */
+#define MTK_ALG_DES			BIT(0)
+#define MTK_ALG_3DES			BIT(1)
+#define MTK_ALG_AES			BIT(2)
+#define MTK_ALG_MASK			GENMASK(2, 0)
+/* hash and hmac algorithms */
+#define MTK_HASH_MD5			BIT(3)
+#define MTK_HASH_SHA1			BIT(4)
+#define MTK_HASH_SHA224			BIT(5)
+#define MTK_HASH_SHA256			BIT(6)
+#define MTK_HASH_HMAC			BIT(7)
+#define MTK_HASH_MASK			GENMASK(6, 3)
+/* cipher modes */
+#define MTK_MODE_CBC			BIT(8)
+#define MTK_MODE_ECB			BIT(9)
+#define MTK_MODE_CTR			BIT(10)
+#define MTK_MODE_RFC3686		BIT(11)
+#define MTK_MODE_MASK			GENMASK(10, 8)
+
+/* cipher encryption/decryption operations */
+#define MTK_ENCRYPT			BIT(12)
+#define MTK_DECRYPT			BIT(13)
+
+#define MTK_BUSY			BIT(14)
+
+/* descriptor flags */
+#define MTK_DESC_ASYNC			BIT(31)
+#define MTK_DESC_SKCIPHER		BIT(30)
+#define MTK_DESC_AEAD			BIT(29)
+#define MTK_DESC_AHASH			BIT(28)
+#define MTK_DESC_PRNG			BIT(27)
+#define MTK_DESC_FAKE_HMAC		BIT(26)
+#define MTK_DESC_LAST			BIT(25)
+#define MTK_DESC_FINISH			BIT(24)
+#define MTK_DESC_IPSEC			BIT(23)
+#define MTK_DESC_DMA_IV			BIT(22)
+
+#define IS_DES(flags)			(flags & MTK_ALG_DES)
+#define IS_3DES(flags)			(flags & MTK_ALG_3DES)
+#define IS_AES(flags)			(flags & MTK_ALG_AES)
+
+#define IS_HASH_MD5(flags)		(flags & MTK_HASH_MD5)
+#define IS_HASH_SHA1(flags)		(flags & MTK_HASH_SHA1)
+#define IS_HASH_SHA224(flags)		(flags & MTK_HASH_SHA224)
+#define IS_HASH_SHA256(flags)		(flags & MTK_HASH_SHA256)
+#define IS_HMAC(flags)			(flags & MTK_HASH_HMAC)
+
+#define IS_CBC(mode)			(mode & MTK_MODE_CBC)
+#define IS_ECB(mode)			(mode & MTK_MODE_ECB)
+#define IS_CTR(mode)			(mode & MTK_MODE_CTR)
+#define IS_RFC3686(mode)		(mode & MTK_MODE_RFC3686)
+
+#define IS_BUSY(flags)			(flags & MTK_BUSY)
+#define IS_DMA_IV(flags)		(flags & MTK_DESC_DMA_IV)
+
+#define IS_ENCRYPT(dir)			(dir & MTK_ENCRYPT)
+#define IS_DECRYPT(dir)			(dir & MTK_DECRYPT)
+
+#define IS_CIPHER(flags)		(flags & (MTK_ALG_DES || \
+						MTK_ALG_3DES ||  \
+						MTK_ALG_AES))
+
+#define IS_HASH(flags)			(flags & (MTK_HASH_MD5 ||  \
+						MTK_HASH_SHA1 ||   \
+						MTK_HASH_SHA224 || \
+						MTK_HASH_SHA256))
+
+/**
+ * struct mtk_device - crypto engine device structure
+ */
+struct mtk_device {
+	void __iomem		*base;
+	struct device		*dev;
+	struct clk		*clk;
+	int			irq;
+	struct mtk_ring		*ring;
+	struct mtk_state_pool	*saState_pool;
+};
+
+struct mtk_desc_ring {
+	void			*base;
+	void			*base_end;
+	dma_addr_t		base_dma;
+	/* write and read pointers */
+	void			*read;
+	void			*write;
+	/* descriptor element offset */
+	u32			offset;
+};
+
+struct mtk_state_pool {
+	void			*base;
+	dma_addr_t		base_dma;
+	bool			in_use;
+};
+
+struct mtk_ring {
+	struct tasklet_struct		done_task;
+	/* command/result rings */
+	struct mtk_desc_ring		cdr;
+	struct mtk_desc_ring		rdr;
+	spinlock_t			write_lock;
+	spinlock_t			read_lock;
+	atomic_t			free;
+	/* saState */
+	struct mtk_state_pool		*saState_pool;
+	void				*saState;
+	dma_addr_t			saState_dma;
+};
+
+enum mtk_alg_type {
+	MTK_ALG_TYPE_AEAD,
+	MTK_ALG_TYPE_SKCIPHER,
+};
+
+struct mtk_alg_template {
+	struct mtk_device	*mtk;
+	enum mtk_alg_type	type;
+	u32			flags;
+	union {
+		struct aead_alg		aead;
+		struct skcipher_alg	skcipher;
+	} alg;
+};
+
+#endif /* _EIP93_MAIN_H_ */
diff --git a/drivers/crypto/mtk-eip93/eip93-regs.h b/drivers/crypto/mtk-eip93/eip93-regs.h
new file mode 100644
index 000000000..41667d666
--- /dev/null
+++ b/drivers/crypto/mtk-eip93/eip93-regs.h
@@ -0,0 +1,382 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 - 2021
+ *
+ * Richard van Schagen <vschagen@icloud.com>
+ */
+#ifndef REG_EIP93_H
+#define REG_EIP93_H
+
+#define EIP93_REG_WIDTH			4
+/*-----------------------------------------------------------------------------
+ * Register Map
+ */
+#define DESP_BASE			0x0000000
+#define EIP93_REG_PE_CTRL_STAT		((DESP_BASE)+(0x00 * EIP93_REG_WIDTH))
+#define EIP93_REG_PE_SOURCE_ADDR	((DESP_BASE)+(0x01 * EIP93_REG_WIDTH))
+#define EIP93_REG_PE_DEST_ADDR		((DESP_BASE)+(0x02 * EIP93_REG_WIDTH))
+#define EIP93_REG_PE_SA_ADDR		((DESP_BASE)+(0x03 * EIP93_REG_WIDTH))
+#define EIP93_REG_PE_ADDR		((DESP_BASE)+(0x04 * EIP93_REG_WIDTH))
+#define EIP93_REG_PE_USER_ID		((DESP_BASE)+(0x06 * EIP93_REG_WIDTH))
+#define EIP93_REG_PE_LENGTH		((DESP_BASE)+(0x07 * EIP93_REG_WIDTH))
+
+//PACKET ENGINE RING configuration registers
+#define PE_RNG_BASE			0x0000080
+
+#define EIP93_REG_PE_CDR_BASE		((PE_RNG_BASE)+(0x00 * EIP93_REG_WIDTH))
+#define EIP93_REG_PE_RDR_BASE		((PE_RNG_BASE)+(0x01 * EIP93_REG_WIDTH))
+#define EIP93_REG_PE_RING_CONFIG	((PE_RNG_BASE)+(0x02 * EIP93_REG_WIDTH))
+#define EIP93_REG_PE_RING_THRESH	((PE_RNG_BASE)+(0x03 * EIP93_REG_WIDTH))
+#define EIP93_REG_PE_CD_COUNT		((PE_RNG_BASE)+(0x04 * EIP93_REG_WIDTH))
+#define EIP93_REG_PE_RD_COUNT		((PE_RNG_BASE)+(0x05 * EIP93_REG_WIDTH))
+#define EIP93_REG_PE_RING_RW_PNTR	((PE_RNG_BASE)+(0x06 * EIP93_REG_WIDTH))
+
+//PACKET ENGINE  configuration registers
+#define PE_CFG_BASE			0x0000100
+#define EIP93_REG_PE_CONFIG		((PE_CFG_BASE)+(0x00 * EIP93_REG_WIDTH))
+#define EIP93_REG_PE_STATUS		((PE_CFG_BASE)+(0x01 * EIP93_REG_WIDTH))
+#define EIP93_REG_PE_BUF_THRESH		((PE_CFG_BASE)+(0x03 * EIP93_REG_WIDTH))
+#define EIP93_REG_PE_INBUF_COUNT	((PE_CFG_BASE)+(0x04 * EIP93_REG_WIDTH))
+#define EIP93_REG_PE_OUTBUF_COUNT	((PE_CFG_BASE)+(0x05 * EIP93_REG_WIDTH))
+#define EIP93_REG_PE_BUF_RW_PNTR	((PE_CFG_BASE)+(0x06 * EIP93_REG_WIDTH))
+
+//PACKET ENGINE endian config
+#define EN_CFG_BASE			0x00001CC
+#define EIP93_REG_PE_ENDIAN_CONFIG	((EN_CFG_BASE)+(0x00 * EIP93_REG_WIDTH))
+
+//EIP93 CLOCK control registers
+#define CLOCK_BASE			0x01E8
+#define EIP93_REG_PE_CLOCK_CTRL		((CLOCK_BASE)+(0x00 * EIP93_REG_WIDTH))
+
+//EIP93 Device Option and Revision Register
+#define REV_BASE			0x01F4
+#define EIP93_REG_PE_OPTION_1		((REV_BASE)+(0x00 * EIP93_REG_WIDTH))
+#define EIP93_REG_PE_OPTION_0		((REV_BASE)+(0x01 * EIP93_REG_WIDTH))
+#define EIP93_REG_PE_REVISION		((REV_BASE)+(0x02 * EIP93_REG_WIDTH))
+
+//EIP93 Interrupt Control Register
+#define INT_BASE			0x0200
+#define EIP93_REG_INT_UNMASK_STAT	((INT_BASE)+(0x00 * EIP93_REG_WIDTH))
+#define EIP93_REG_INT_MASK_STAT		((INT_BASE)+(0x01 * EIP93_REG_WIDTH))
+#define EIP93_REG_INT_CLR		((INT_BASE)+(0x01 * EIP93_REG_WIDTH))
+#define EIP93_REG_INT_MASK		((INT_BASE)+(0x02 * EIP93_REG_WIDTH))
+#define EIP93_REG_INT_CFG		((INT_BASE)+(0x03 * EIP93_REG_WIDTH))
+#define EIP93_REG_MASK_ENABLE		((INT_BASE)+(0X04 * EIP93_REG_WIDTH))
+#define EIP93_REG_MASK_DISABLE		((INT_BASE)+(0X05 * EIP93_REG_WIDTH))
+
+//EIP93 SA Record register
+#define SA_BASE				0x0400
+#define EIP93_REG_SA_CMD_0		((SA_BASE)+(0x00 * EIP93_REG_WIDTH))
+#define EIP93_REG_SA_CMD_1		((SA_BASE)+(0x01 * EIP93_REG_WIDTH))
+
+//#define EIP93_REG_SA_READY		((SA_BASE)+(31 * EIP93_REG_WIDTH))
+
+//State save register
+#define STATE_BASE			0x0500
+#define EIP93_REG_STATE_IV_0		((STATE_BASE)+(0x00 * EIP93_REG_WIDTH))
+#define EIP93_REG_STATE_IV_1		((STATE_BASE)+(0x01 * EIP93_REG_WIDTH))
+
+#define EIP93_PE_ARC4STATE_BASEADDR_REG	0x0700
+
+//RAM buffer start address
+#define EIP93_INPUT_BUFFER		0x0800
+#define EIP93_OUTPUT_BUFFER		0x0800
+
+//EIP93 PRNG Configuration Register
+#define PRNG_BASE			0x0300
+#define EIP93_REG_PRNG_STAT		((PRNG_BASE)+(0x00 * EIP93_REG_WIDTH))
+#define EIP93_REG_PRNG_CTRL		((PRNG_BASE)+(0x01 * EIP93_REG_WIDTH))
+#define EIP93_REG_PRNG_SEED_0		((PRNG_BASE)+(0x02 * EIP93_REG_WIDTH))
+#define EIP93_REG_PRNG_SEED_1		((PRNG_BASE)+(0x03 * EIP93_REG_WIDTH))
+#define EIP93_REG_PRNG_SEED_2		((PRNG_BASE)+(0x04 * EIP93_REG_WIDTH))
+#define EIP93_REG_PRNG_SEED_3		((PRNG_BASE)+(0x05 * EIP93_REG_WIDTH))
+#define EIP93_REG_PRNG_KEY_0		((PRNG_BASE)+(0x06 * EIP93_REG_WIDTH))
+#define EIP93_REG_PRNG_KEY_1		((PRNG_BASE)+(0x07 * EIP93_REG_WIDTH))
+#define EIP93_REG_PRNG_KEY_2		((PRNG_BASE)+(0x08 * EIP93_REG_WIDTH))
+#define EIP93_REG_PRNG_KEY_3		((PRNG_BASE)+(0x09 * EIP93_REG_WIDTH))
+#define EIP93_REG_PRNG_RES_0		((PRNG_BASE)+(0x0A * EIP93_REG_WIDTH))
+#define EIP93_REG_PRNG_RES_1		((PRNG_BASE)+(0x0B * EIP93_REG_WIDTH))
+#define EIP93_REG_PRNG_RES_2		((PRNG_BASE)+(0x0C * EIP93_REG_WIDTH))
+#define EIP93_REG_PRNG_RES_3		((PRNG_BASE)+(0x0D * EIP93_REG_WIDTH))
+#define EIP93_REG_PRNG_LFSR_0		((PRNG_BASE)+(0x0E * EIP93_REG_WIDTH))
+#define EIP93_REG_PRNG_LFSR_1		((PRNG_BASE)+(0x0F * EIP93_REG_WIDTH))
+
+/*-----------------------------------------------------------------------------
+ * Constants & masks
+ */
+
+#define EIP93_SUPPORTED_INTERRUPTS_MASK	0xffff7f00
+#define EIP93_PRNG_DT_TEXT_LOWERHALF	0xDEAD
+#define EIP93_PRNG_DT_TEXT_UPPERHALF	0xC0DE
+#define EIP93_10BITS_MASK		0X3FF
+#define EIP93_12BITS_MASK		0XFFF
+#define EIP93_4BITS_MASK		0X04
+#define EIP93_20BITS_MASK		0xFFFFF
+
+#define EIP93_MIN_DESC_DONE_COUNT	0
+#define EIP93_MAX_DESC_DONE_COUNT	15
+
+#define EIP93_MIN_DESC_PENDING_COUNT	0
+#define EIP93_MAX_DESC_PENDING_COUNT	1023
+
+#define EIP93_MIN_TIMEOUT_COUNT		0
+#define EIP93_MAX_TIMEOUT_COUNT		15
+
+#define EIP93_MIN_PE_INPUT_THRESHOLD	1
+#define EIP93_MAX_PE_INPUT_THRESHOLD	511
+
+#define EIP93_MIN_PE_OUTPUT_THRESHOLD	1
+#define EIP93_MAX_PE_OUTPUT_THRESHOLD	432
+
+#define EIP93_MIN_PE_RING_SIZE		1
+#define EIP93_MAX_PE_RING_SIZE		1023
+
+#define EIP93_MIN_PE_DESCRIPTOR_SIZE	7
+#define EIP93_MAX_PE_DESCRIPTOR_SIZE	15
+
+//3DES keys,seed,known data and its result
+#define EIP93_KEY_0			0x133b3454
+#define EIP93_KEY_1			0x5e5b890b
+#define EIP93_KEY_2			0x5eb30757
+#define EIP93_KEY_3			0x93ab15f7
+#define EIP93_SEED_0			0x62c4bf5e
+#define EIP93_SEED_1			0x972667c8
+#define EIP93_SEED_2			0x6345bf67
+#define EIP93_SEED_3			0xcb3482bf
+#define EIP93_LFSR_0			0xDEADC0DE
+#define EIP93_LFSR_1			0xBEEFF00D
+
+/*-----------------------------------------------------------------------------
+ * EIP93 device initialization specifics
+ */
+
+/*----------------------------------------------------------------------------
+ * Byte Order Reversal Mechanisms Supported in EIP93
+ * EIP93_BO_REVERSE_HALF_WORD : reverse the byte order within a half-word
+ * EIP93_BO_REVERSE_WORD :  reverse the byte order within a word
+ * EIP93_BO_REVERSE_DUAL_WORD : reverse the byte order within a dual-word
+ * EIP93_BO_REVERSE_QUAD_WORD : reverse the byte order within a quad-word
+ */
+enum EIP93_Byte_Order_Value_t {
+	EIP93_BO_REVERSE_HALF_WORD = 1,
+	EIP93_BO_REVERSE_WORD = 2,
+	EIP93_BO_REVERSE_DUAL_WORD = 4,
+	EIP93_BO_REVERSE_QUAD_WORD = 8,
+};
+
+/*----------------------------------------------------------------------------
+ * Byte Order Reversal Mechanisms Supported in EIP93 for Target Data
+ * EIP93_BO_REVERSE_HALF_WORD : reverse the byte order within a half-word
+ * EIP93_BO_REVERSE_WORD :  reverse the byte order within a word
+ */
+enum EIP93_Byte_Order_Value_TD_t {
+	EIP93_BO_REVERSE_HALF_WORD_TD = 1,
+	EIP93_BO_REVERSE_WORD_TD = 2,
+};
+
+// BYTE_ORDER_CFG register values
+#define EIP93_BYTE_ORDER_PD		EIP93_BO_REVERSE_WORD
+#define EIP93_BYTE_ORDER_SA		EIP93_BO_REVERSE_WORD
+#define EIP93_BYTE_ORDER_DATA		EIP93_BO_REVERSE_WORD
+#define EIP93_BYTE_ORDER_TD		EIP93_BO_REVERSE_WORD_TD
+
+// INT_CFG register values
+#define EIP93_INT_HOST_OUTPUT_TYPE	0
+#define EIP93_INT_PULSE_CLEAR		0
+
+/*
+ * Interrupts of EIP93
+ */
+
+enum EIP93_InterruptSource_t {
+	EIP93_INT_PE_CDRTHRESH_REQ =	BIT(0),
+	EIP93_INT_PE_RDRTHRESH_REQ =	BIT(1),
+	EIP93_INT_PE_OPERATION_DONE =	BIT(9),
+	EIP93_INT_PE_INBUFTHRESH_REQ =	BIT(10),
+	EIP93_INT_PE_OUTBURTHRSH_REQ =	BIT(11),
+	EIP93_INT_PE_PRNG_IRQ =		BIT(12),
+	EIP93_INT_PE_ERR_REG =		BIT(13),
+	EIP93_INT_PE_RD_DONE_IRQ =	BIT(16),
+};
+
+union peConfig_w {
+	u32 word;
+	struct {
+		u32 resetPE		:1;
+		u32 resetRing		:1;
+		u32 reserved		:6;
+		u32 peMode		:2;
+		u32 enCDRupdate		:1;
+		u32 reserved2		:5;
+		u32 swapCDRD		:1;
+		u32 swapSA		:1;
+		u32 swapData		:1;
+		u32 reserved3		:13;
+	} bits;
+} __packed;
+
+union peEndianCfg_w {
+	u32 word;
+	struct {
+		u32 masterByteSwap	:8;
+		u32 reserved		:8;
+		u32 targetByteSwap	:8;
+		u32 reserved2		:8;
+	} bits;
+} __packed;
+
+union peIntCfg_w {
+	u32 word;
+	struct {
+		u32 PulseClear		:1;
+		u32 IntType		:1;
+		u32 reserved		:30;
+	} bits;
+} __packed;
+
+union peClockCfg_w {
+	u32 word;
+	struct {
+		u32 enPEclk		:1;
+		u32 enDESclk		:1;
+		u32 enAESclk		:1;
+		u32 reserved		:1;
+		u32 enHASHclk		:1;
+		u32 reserved2		:27;
+	} bits;
+} __packed;
+
+union peBufThresh_w {
+	u32 word;
+	struct {
+		u32 inputBuffer		:8;
+		u32 reserved		:8;
+		u32 outputBuffer	:8;
+		u32 reserved2		:8;
+	} bits;
+} __packed;
+
+union peRingThresh_w {
+	u32 word;
+	struct {
+		u32 CDRThresh		:10;
+		u32 reserved		:6;
+		u32 RDRThresh		:10;
+		u32 RDTimeout		:4;
+		u32 reserved2		:1;
+		u32 enTimeout		:1;
+	} bits;
+} __packed;
+
+union peRingCfg_w {
+	u32 word;
+	struct {
+		u32 ringSize		:10;
+		u32 reserved		:6;
+		u32 ringOffset		:8;
+		u32 reserved2		:8;
+	} bits;
+} __packed;
+
+union saCmd0 {
+	u32	word;
+	struct {
+		u32 opCode		:3;
+		u32 direction		:1;
+		u32 opGroup		:2;
+		u32 padType		:2;
+		u32 cipher		:4;
+		u32 hash		:4;
+		u32 reserved2		:1;
+		u32 scPad		:1;
+		u32 extPad		:1;
+		u32 hdrProc		:1;
+		u32 digestLength	:4;
+		u32 ivSource		:2;
+		u32 hashSource		:2;
+		u32 saveIv		:1;
+		u32 saveHash		:1;
+		u32 reserved1		:2;
+	} bits;
+} __packed;
+
+union saCmd1 {
+	u32	word;
+	struct {
+		u32 copyDigest		:1;
+		u32 copyHeader		:1;
+		u32 copyPayload		:1;
+		u32 copyPad		:1;
+		u32 reserved4		:4;
+		u32 cipherMode		:2;
+		u32 reserved3		:1;
+		u32 sslMac		:1;
+		u32 hmac		:1;
+		u32 byteOffset		:1;
+		u32 reserved2		:2;
+		u32 hashCryptOffset	:8;
+		u32 aesKeyLen		:3;
+		u32 reserved1		:1;
+		u32 aesDecKey		:1;
+		u32 seqNumCheck		:1;
+		u32 reserved0		:2;
+	} bits;
+} __packed;
+
+struct saRecord_s {
+	union saCmd0	saCmd0;
+	union saCmd1	saCmd1;
+	u32		saKey[8];
+	u32		saIDigest[8];
+	u32		saODigest[8];
+	u32		saSpi;
+	u32		saSeqNum[2];
+	u32		saSeqNumMask[2];
+	u32		saNonce;
+} __packed;
+
+struct saState_s {
+	u32	stateIv[4];
+	u32	stateByteCnt[2];
+	u32	stateIDigest[8];
+} __packed;
+
+union peCrtlStat_w {
+	u32 word;
+	struct {
+		u32 hostReady		:1;
+		u32 peReady		:1;
+		u32 reserved		:1;
+		u32 initArc4		:1;
+		u32 hashFinal		:1;
+		u32 haltMode		:1;
+		u32 prngMode		:2;
+		u32 padValue		:8;
+		u32 errStatus		:8;
+		u32 padCrtlStat		:8;
+	} bits;
+} __packed;
+
+union  peLength_w {
+	u32 word;
+	struct {
+		u32 length		:20;
+		u32 reserved		:2;
+		u32 hostReady		:1;
+		u32 peReady		:1;
+		u32 byPass		:8;
+	} bits;
+} __packed;
+
+struct eip93_descriptor_s {
+	union peCrtlStat_w	peCrtlStat;
+	u32			srcAddr;
+	u32			dstAddr;
+	u32			saAddr;
+	u32			stateAddr;
+	u32			arc4Addr;
+	u32			userId;
+	union peLength_w	peLength;
+} __packed;
+
+#endif
-- 
2.30.2


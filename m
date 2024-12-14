Return-Path: <linux-crypto+bounces-8602-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3419F1EBD
	for <lists+linux-crypto@lfdr.de>; Sat, 14 Dec 2024 14:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA11818896B9
	for <lists+linux-crypto@lfdr.de>; Sat, 14 Dec 2024 13:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C28A192B60;
	Sat, 14 Dec 2024 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGAdswru"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C900195FE5;
	Sat, 14 Dec 2024 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734182936; cv=none; b=qydVlPh1nWfy5dKUpWaETVYrUlddZ55SrSzr/jWEDr1GwN6lw/I1RG14P2GHvnHwtUIdGyp0cGliazwH3vkAf2pCgOEI2JQiZLH3bsjjAXN5XRxyYi0ChmUFjfSktAMBOP6A4jxU9yN2gzGUFMcFRRf4LbmMyoxqFWgHvx6dCh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734182936; c=relaxed/simple;
	bh=qpGmsIU09PBftU/na0/nVtTd6+UQbm2pb7IIe8h0B4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHmTuEikiVQ1NzTK4q+u5lD75cLuyJGScOU1Vszsec/9pxFdq7CR3UypG9lGyrrBIVmdnO8VXU5kSSpLVh+Fif6gLk0dB46vAePdyDVueGCwrrIuK+N5WQg9X+1eMHWqFbr4Bwi3svG0LoHzrputW1zyU8zNdvwYEKkQHJQrpaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGAdswru; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43622354a3eso18231285e9.1;
        Sat, 14 Dec 2024 05:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734182929; x=1734787729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1ahxLRl4co29kq543AfCn9XJsFiZwRknfy0rqnhgzc=;
        b=OGAdswruw14I/YwywktlYkxxoJGrKbN3XR9xK6CwtpijbIiErRy/dZaCGiUaxBIRSe
         8CcHmhaIJiC43JAcNengxTr4Gi28HbfIUvy3VppBzv4a1cHVZmfx7ELQawNHCgqTGeiJ
         IL23ZwP9nvLtkTMKyvX+VdU3LtMg53RaUooD+ZU35/6PsLxypfhXyCH19SfuwGpuUzZj
         81nuNhmHULaz0JjwLyGE6FiIew3YBDHMMUWxmT0omXz+38ZQBotwFVyZAjJCm25n0z6R
         6/EuWWBhdgaWZ6U0S4jQJxLx7jldRKhn6OYdtnzMnNqGylDGtM92Pbd6GNloOP6E4Ff7
         N1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734182929; x=1734787729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1ahxLRl4co29kq543AfCn9XJsFiZwRknfy0rqnhgzc=;
        b=aSVy7wGSypkb8Hd1GW4p8LEQzuXElMLPlDv1KSeoPlPDr09nP0DYpSk+PQ/I3EngRb
         cKIpDwEEXSdiqffmiY/tFVaVDVU7QZni7hubcOX+A4EYZ4x5V0Zfi9kCBx1bzzNjNDqX
         11BeUT89/VL6KIDHCy93vBe4EYEy5wNZwyv4FnjZ/4gy7Z1FGctZtGQiK+0W7lvOCP5V
         0pkcgdGkKPCEdXFNbC/U8hN+O4uPgqg6B74OyVY3n4QXjeRtfnI1VdvQXq1fVLnTdxAU
         RjtNZJzIofeSzKc2G3tdKe92PCWoEs60z5axTQvZ9BdkRQAcI92gwgjkq2dulIrb5S6Q
         UD5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUORMJIMVMyoSimIFnNSWXbIgL7Gvseh+cPmr2bYdnqc9OAE+iwss41lDdrl0YLZKmzLWwRm6kmqqJVQij5@vger.kernel.org, AJvYcCWd9koruXjdAIURyi6v814w4JNna6Vl6EjT4wf44Ieyc3mDLCcHSChA2qjSXATPU/l9JkDcz39qwtCAnxSC@vger.kernel.org, AJvYcCX6z/kFbg2u+6ZN/Wj5CcIJv70whCrRYVlEejgDDO/DC8EB0EQ/XRhqJxmKWwuCMLXD+ZD+/X62m9bh@vger.kernel.org
X-Gm-Message-State: AOJu0YwHbWNaimrtny1grj70IbXsw/vN0xYvDTgI9eNXJnjBv8DCjuTB
	D99lktFUpjtVZfOwSEEWy/c2TvdYPZZpmQaS/ffsH847Bc/LCuaeEAQioA==
X-Gm-Gg: ASbGnctlbgVxFTf38EfM7+mGVi5H8OYb7CQlp+FDUS7nbDMt807YcMMdvFyyZyhDQqD
	Q27BYHh1IZeBJ7cznjBz8V0vvGG0mL9MZqLI0oUDP7CL00lak4cLUbQDgf3BQ0m7j7Phng1vRXn
	3Sm0O3EWyWzSJYQDnZVYDN6OW8SpQsJl/40zPaREZO9cvIoyS0YeNS2qYFTf9xweoGhEF5Kyo8y
	gxIrpdF7St3o49niiZQv9g8U1rRZ7Y/m0tYrTEnncgH7q81BOeqZdUIwtvJTZMdYBWuZXVYf2S/
	8CvfO25sWZAUVdOQJE7s7CMP8w==
X-Google-Smtp-Source: AGHT+IGc0zA96zl0UY4hknaDpY9PnE4nrxQsWN7DTtnW9jTtAiKX4ixaNGb/RuLLtTO6wjR0qsx1nA==
X-Received: by 2002:a05:600c:1d9a:b0:434:ea21:e14f with SMTP id 5b1f17b1804b1-4362aa584a1mr57231175e9.13.1734182928404;
        Sat, 14 Dec 2024 05:28:48 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-388c80162a6sm2559850f8f.33.2024.12.14.05.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 05:28:47 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Antoine Tenart <atenart@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	upstream@airoha.com
Cc: Richard van Schagen <vschagen@icloud.com>
Subject: [PATCH v9 3/3] crypto: Add Inside Secure SafeXcel EIP-93 crypto engine support
Date: Sat, 14 Dec 2024 14:27:54 +0100
Message-ID: <20241214132808.19449-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241214132808.19449-1-ansuelsmth@gmail.com>
References: <20241214132808.19449-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Inside Secure SafeXcel EIP-93 Crypto Engine used on
Mediatek MT7621 SoC and new Airoha SoC.

EIP-93 IP supports AES/DES/3DES ciphers in ECB/CBC and CTR modes as well as
authenc(HMAC(x), cipher(y)) using HMAC MD5, SHA1, SHA224 and SHA256.

EIP-93 provide regs to signal support for specific chipers and the
driver dynamically register only the supported one by the chip.

Signed-off-by: Richard van Schagen <vschagen@icloud.com>
Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS                                   |   7 +
 drivers/crypto/Kconfig                        |   1 +
 drivers/crypto/Makefile                       |   1 +
 drivers/crypto/inside-secure/eip93/Kconfig    |  20 +
 drivers/crypto/inside-secure/eip93/Makefile   |   5 +
 .../crypto/inside-secure/eip93/eip93-aead.c   | 711 ++++++++++++++
 .../crypto/inside-secure/eip93/eip93-aead.h   |  38 +
 .../crypto/inside-secure/eip93/eip93-aes.h    |  16 +
 .../crypto/inside-secure/eip93/eip93-cipher.c | 413 +++++++++
 .../crypto/inside-secure/eip93/eip93-cipher.h |  60 ++
 .../crypto/inside-secure/eip93/eip93-common.c | 816 +++++++++++++++++
 .../crypto/inside-secure/eip93/eip93-common.h |  24 +
 .../crypto/inside-secure/eip93/eip93-des.h    |  16 +
 .../crypto/inside-secure/eip93/eip93-hash.c   | 866 ++++++++++++++++++
 .../crypto/inside-secure/eip93/eip93-hash.h   |  82 ++
 .../crypto/inside-secure/eip93/eip93-main.c   | 502 ++++++++++
 .../crypto/inside-secure/eip93/eip93-main.h   | 152 +++
 .../crypto/inside-secure/eip93/eip93-regs.h   | 335 +++++++
 18 files changed, 4065 insertions(+)
 create mode 100644 drivers/crypto/inside-secure/eip93/Kconfig
 create mode 100644 drivers/crypto/inside-secure/eip93/Makefile
 create mode 100644 drivers/crypto/inside-secure/eip93/eip93-aead.c
 create mode 100644 drivers/crypto/inside-secure/eip93/eip93-aead.h
 create mode 100644 drivers/crypto/inside-secure/eip93/eip93-aes.h
 create mode 100644 drivers/crypto/inside-secure/eip93/eip93-cipher.c
 create mode 100644 drivers/crypto/inside-secure/eip93/eip93-cipher.h
 create mode 100644 drivers/crypto/inside-secure/eip93/eip93-common.c
 create mode 100644 drivers/crypto/inside-secure/eip93/eip93-common.h
 create mode 100644 drivers/crypto/inside-secure/eip93/eip93-des.h
 create mode 100644 drivers/crypto/inside-secure/eip93/eip93-hash.c
 create mode 100644 drivers/crypto/inside-secure/eip93/eip93-hash.h
 create mode 100644 drivers/crypto/inside-secure/eip93/eip93-main.c
 create mode 100644 drivers/crypto/inside-secure/eip93/eip93-main.h
 create mode 100644 drivers/crypto/inside-secure/eip93/eip93-regs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b009c3ced239..c8876023b0bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11322,6 +11322,13 @@ L:	linux-crypto@vger.kernel.org
 S:	Maintained
 F:	drivers/crypto/inside-secure/
 
+INSIDE SECURE EIP93 CRYPTO DRIVER
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	linux-crypto@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/crypto/inside-secure,safexcel-eip93.yaml
+F:	drivers/crypto/inside-secure/eip93/
+
 INTEGRITY MEASUREMENT ARCHITECTURE (IMA)
 M:	Mimi Zohar <zohar@linux.ibm.com>
 M:	Roberto Sassu <roberto.sassu@huawei.com>
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 08b1238bcd7b..8891ce8cc955 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -851,5 +851,6 @@ config CRYPTO_DEV_SA2UL
 
 source "drivers/crypto/aspeed/Kconfig"
 source "drivers/crypto/starfive/Kconfig"
+source "drivers/crypto/inside-secure/eip93/Kconfig"
 
 endif # CRYPTO_HW
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index ad4ccef67d12..49fb90526c3f 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -52,3 +52,4 @@ obj-y += hisilicon/
 obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic/
 obj-y += intel/
 obj-y += starfive/
+obj-y += inside-secure/eip93/
diff --git a/drivers/crypto/inside-secure/eip93/Kconfig b/drivers/crypto/inside-secure/eip93/Kconfig
new file mode 100644
index 000000000000..8353d3d7ec9b
--- /dev/null
+++ b/drivers/crypto/inside-secure/eip93/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0
+config CRYPTO_DEV_EIP93
+	tristate "Support for EIP93 crypto HW accelerators"
+	depends on SOC_MT7621 || ARCH_AIROHA ||COMPILE_TEST
+	select CRYPTO_LIB_AES
+	select CRYPTO_LIB_DES
+	select CRYPTO_SKCIPHER
+	select CRYPTO_AEAD
+	select CRYPTO_AUTHENC
+	select CRYPTO_MD5
+	select CRYPTO_SHA1
+	select CRYPTO_SHA256
+	help
+	  EIP93 have various crypto HW accelerators. Select this if
+	  you want to use the EIP93 modules for any of the crypto algorithms.
+
+	  If the IP supports it, this provide offload for AES - ECB, CBC and
+	  CTR crypto. Also provide DES and 3DES ECB and CBC.
+
+	  Also provide AEAD authenc(hmac(x), cipher(y)) for supported algo.
diff --git a/drivers/crypto/inside-secure/eip93/Makefile b/drivers/crypto/inside-secure/eip93/Makefile
new file mode 100644
index 000000000000..a3d3d3677cdc
--- /dev/null
+++ b/drivers/crypto/inside-secure/eip93/Makefile
@@ -0,0 +1,5 @@
+obj-$(CONFIG_CRYPTO_DEV_EIP93) += crypto-hw-eip93.o
+
+crypto-hw-eip93-y += eip93-main.o eip93-common.o
+crypto-hw-eip93-y += eip93-cipher.o eip93-aead.o
+crypto-hw-eip93-y += eip93-hash.o
diff --git a/drivers/crypto/inside-secure/eip93/eip93-aead.c b/drivers/crypto/inside-secure/eip93/eip93-aead.c
new file mode 100644
index 000000000000..78580b7bb166
--- /dev/null
+++ b/drivers/crypto/inside-secure/eip93/eip93-aead.c
@@ -0,0 +1,711 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 - 2021
+ *
+ * Richard van Schagen <vschagen@icloud.com>
+ * Christian Marangi <ansuelsmth@gmail.com
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
+#include <crypto/internal/des.h>
+
+#include <linux/crypto.h>
+#include <linux/dma-mapping.h>
+
+#include "eip93-aead.h"
+#include "eip93-cipher.h"
+#include "eip93-common.h"
+#include "eip93-regs.h"
+
+void eip93_aead_handle_result(struct crypto_async_request *async, int err)
+{
+	struct eip93_crypto_ctx *ctx = crypto_tfm_ctx(async->tfm);
+	struct eip93_device *mtk = ctx->mtk;
+	struct aead_request *req = aead_request_cast(async);
+	struct eip93_cipher_reqctx *rctx = aead_request_ctx(req);
+
+	eip93_unmap_dma(mtk, rctx, req->src, req->dst);
+	eip93_handle_result(mtk, rctx, req->iv);
+
+	aead_request_complete(req, err);
+}
+
+static int eip93_aead_send_req(struct crypto_async_request *async)
+{
+	struct aead_request *req = aead_request_cast(async);
+	struct eip93_cipher_reqctx *rctx = aead_request_ctx(req);
+	int err;
+
+	err = check_valid_request(rctx);
+	if (err) {
+		aead_request_complete(req, err);
+		return err;
+	}
+
+	return eip93_send_req(async, req->iv, rctx);
+}
+
+/* Crypto aead API functions */
+static int eip93_aead_cra_init(struct crypto_tfm *tfm)
+{
+	struct eip93_crypto_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct eip93_alg_template *tmpl = container_of(tfm->__crt_alg,
+				struct eip93_alg_template, alg.aead.base);
+
+	crypto_aead_set_reqsize(__crypto_aead_cast(tfm),
+				sizeof(struct eip93_cipher_reqctx));
+
+	ctx->mtk = tmpl->mtk;
+	ctx->flags = tmpl->flags;
+	ctx->type = tmpl->type;
+	ctx->set_assoc = true;
+
+	ctx->sa_record = kzalloc(sizeof(*ctx->sa_record), GFP_KERNEL);
+	if (!ctx->sa_record)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void eip93_aead_cra_exit(struct crypto_tfm *tfm)
+{
+	struct eip93_crypto_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	dma_unmap_single(ctx->mtk->dev, ctx->sa_record_base,
+			 sizeof(*ctx->sa_record), DMA_TO_DEVICE);
+	kfree(ctx->sa_record);
+}
+
+static int eip93_aead_setkey(struct crypto_aead *ctfm, const u8 *key,
+			     unsigned int len)
+{
+	struct crypto_tfm *tfm = crypto_aead_tfm(ctfm);
+	struct eip93_crypto_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct crypto_authenc_keys keys;
+	struct crypto_aes_ctx aes;
+	struct sa_record *sa_record = ctx->sa_record;
+	u32 nonce = 0;
+	int ret;
+
+	if (crypto_authenc_extractkeys(&keys, key, len))
+		return -EINVAL;
+
+	if (IS_RFC3686(ctx->flags)) {
+		if (keys.enckeylen < CTR_RFC3686_NONCE_SIZE)
+			return -EINVAL;
+
+		keys.enckeylen -= CTR_RFC3686_NONCE_SIZE;
+		memcpy(&nonce, keys.enckey + keys.enckeylen,
+		       CTR_RFC3686_NONCE_SIZE);
+	}
+
+	switch ((ctx->flags & EIP93_ALG_MASK)) {
+	case EIP93_ALG_DES:
+		ret = verify_aead_des_key(ctfm, keys.enckey, keys.enckeylen);
+		if (ret)
+			return ret;
+
+		break;
+	case EIP93_ALG_3DES:
+		if (keys.enckeylen != DES3_EDE_KEY_SIZE)
+			return -EINVAL;
+
+		ret = verify_aead_des3_key(ctfm, keys.enckey, keys.enckeylen);
+		if (ret)
+			return ret;
+
+		break;
+	case EIP93_ALG_AES:
+		ret = aes_expandkey(&aes, keys.enckey, keys.enckeylen);
+		if (ret)
+			return ret;
+
+		break;
+	}
+
+	ctx->blksize = crypto_aead_blocksize(ctfm);
+	/* Encryption key */
+	eip93_set_sa_record(sa_record, keys.enckeylen, ctx->flags);
+	sa_record->sa_cmd0_word &= ~EIP93_SA_CMD_OPCODE;
+	sa_record->sa_cmd0_word |= FIELD_PREP(EIP93_SA_CMD_OPCODE,
+					      EIP93_SA_CMD_OPCODE_BASIC_OUT_ENC_HASH);
+	sa_record->sa_cmd0_word &= ~EIP93_SA_CMD_DIGEST_LENGTH;
+	sa_record->sa_cmd0_word |= FIELD_PREP(EIP93_SA_CMD_DIGEST_LENGTH,
+					      ctx->authsize / sizeof(u32));
+
+	memcpy(sa_record->sa_key, keys.enckey, keys.enckeylen);
+	ctx->sa_nonce = nonce;
+	sa_record->sa_nonce = nonce;
+
+	/* authentication key */
+	ret = eip93_hmac_setkey(ctx->flags, keys.authkey, keys.authkeylen,
+				ctx->authsize, sa_record->sa_i_digest,
+				sa_record->sa_o_digest, false);
+
+	ctx->set_assoc = true;
+
+	return ret;
+}
+
+static int eip93_aead_setauthsize(struct crypto_aead *ctfm,
+				  unsigned int authsize)
+{
+	struct crypto_tfm *tfm = crypto_aead_tfm(ctfm);
+	struct eip93_crypto_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	ctx->authsize = authsize;
+	ctx->sa_record->sa_cmd0_word &= ~EIP93_SA_CMD_DIGEST_LENGTH;
+	ctx->sa_record->sa_cmd0_word |= FIELD_PREP(EIP93_SA_CMD_DIGEST_LENGTH,
+						   ctx->authsize / sizeof(u32));
+
+	return 0;
+}
+
+static void eip93_aead_setassoc(struct eip93_crypto_ctx *ctx,
+				struct aead_request *req)
+{
+	struct sa_record *sa_record = ctx->sa_record;
+
+	sa_record->sa_cmd1_word &= ~EIP93_SA_CMD_HASH_CRYPT_OFFSET;
+	sa_record->sa_cmd1_word |= FIELD_PREP(EIP93_SA_CMD_HASH_CRYPT_OFFSET,
+					      req->assoclen / sizeof(u32));
+
+	ctx->assoclen = req->assoclen;
+}
+
+static int eip93_aead_crypt(struct aead_request *req)
+{
+	struct eip93_cipher_reqctx *rctx = aead_request_ctx(req);
+	struct crypto_async_request *async = &req->base;
+	struct eip93_crypto_ctx *ctx = crypto_tfm_ctx(req->base.tfm);
+	struct crypto_aead *aead = crypto_aead_reqtfm(req);
+	int ret;
+
+	ctx->sa_record_base = dma_map_single(ctx->mtk->dev, ctx->sa_record,
+					     sizeof(*ctx->sa_record), DMA_TO_DEVICE);
+	ret = dma_mapping_error(ctx->mtk->dev, ctx->sa_record_base);
+	if (ret)
+		return ret;
+
+	rctx->textsize = req->cryptlen;
+	rctx->blksize = ctx->blksize;
+	rctx->assoclen = req->assoclen;
+	rctx->authsize = ctx->authsize;
+	rctx->sg_src = req->src;
+	rctx->sg_dst = req->dst;
+	rctx->ivsize = crypto_aead_ivsize(aead);
+	rctx->desc_flags = EIP93_DESC_AEAD;
+	rctx->sa_record_base = ctx->sa_record_base;
+
+	if (IS_DECRYPT(rctx->flags))
+		rctx->textsize -= rctx->authsize;
+
+	return eip93_aead_send_req(async);
+}
+
+static int eip93_aead_encrypt(struct aead_request *req)
+{
+	struct eip93_crypto_ctx *ctx = crypto_tfm_ctx(req->base.tfm);
+	struct eip93_cipher_reqctx *rctx = aead_request_ctx(req);
+
+	rctx->flags = ctx->flags;
+	rctx->flags |= EIP93_ENCRYPT;
+	if (ctx->set_assoc) {
+		eip93_aead_setassoc(ctx, req);
+		ctx->set_assoc = false;
+	}
+
+	if (req->assoclen != ctx->assoclen) {
+		dev_err(ctx->mtk->dev, "Request AAD length error\n");
+		return -EINVAL;
+	}
+
+	return eip93_aead_crypt(req);
+}
+
+static int eip93_aead_decrypt(struct aead_request *req)
+{
+	struct eip93_crypto_ctx *ctx = crypto_tfm_ctx(req->base.tfm);
+	struct eip93_cipher_reqctx *rctx = aead_request_ctx(req);
+
+	ctx->sa_record->sa_cmd0_word |= EIP93_SA_CMD_DIRECTION_IN;
+	ctx->sa_record->sa_cmd1_word &= ~(EIP93_SA_CMD_COPY_PAD |
+					  EIP93_SA_CMD_COPY_DIGEST);
+
+	rctx->flags = ctx->flags;
+	rctx->flags |= EIP93_DECRYPT;
+	if (ctx->set_assoc) {
+		eip93_aead_setassoc(ctx, req);
+		ctx->set_assoc = false;
+	}
+
+	if (req->assoclen != ctx->assoclen) {
+		dev_err(ctx->mtk->dev, "Request AAD length error\n");
+		return -EINVAL;
+	}
+
+	return eip93_aead_crypt(req);
+}
+
+/* Available authenc algorithms in this module */
+struct eip93_alg_template eip93_alg_authenc_hmac_md5_cbc_aes = {
+	.type = EIP93_ALG_TYPE_AEAD,
+	.flags = EIP93_HASH_HMAC | EIP93_HASH_MD5 | EIP93_MODE_CBC | EIP93_ALG_AES,
+	.alg.aead = {
+		.setkey = eip93_aead_setkey,
+		.encrypt = eip93_aead_encrypt,
+		.decrypt = eip93_aead_decrypt,
+		.ivsize	= AES_BLOCK_SIZE,
+		.setauthsize = eip93_aead_setauthsize,
+		.maxauthsize = MD5_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(md5),cbc(aes))",
+			.cra_driver_name =
+				"authenc(hmac(md5-eip93), cbc(aes-eip93))",
+			.cra_priority = EIP93_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY |
+					CRYPTO_ALG_ALLOCATES_MEMORY,
+			.cra_blocksize = AES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct eip93_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = eip93_aead_cra_init,
+			.cra_exit = eip93_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_authenc_hmac_sha1_cbc_aes = {
+	.type = EIP93_ALG_TYPE_AEAD,
+	.flags = EIP93_HASH_HMAC | EIP93_HASH_SHA1 | EIP93_MODE_CBC | EIP93_ALG_AES,
+	.alg.aead = {
+		.setkey = eip93_aead_setkey,
+		.encrypt = eip93_aead_encrypt,
+		.decrypt = eip93_aead_decrypt,
+		.ivsize	= AES_BLOCK_SIZE,
+		.setauthsize = eip93_aead_setauthsize,
+		.maxauthsize = SHA1_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(sha1),cbc(aes))",
+			.cra_driver_name =
+				"authenc(hmac(sha1-eip93),cbc(aes-eip93))",
+			.cra_priority = EIP93_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY |
+					CRYPTO_ALG_ALLOCATES_MEMORY,
+			.cra_blocksize = AES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct eip93_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = eip93_aead_cra_init,
+			.cra_exit = eip93_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_authenc_hmac_sha224_cbc_aes = {
+	.type = EIP93_ALG_TYPE_AEAD,
+	.flags = EIP93_HASH_HMAC | EIP93_HASH_SHA224 | EIP93_MODE_CBC | EIP93_ALG_AES,
+	.alg.aead = {
+		.setkey = eip93_aead_setkey,
+		.encrypt = eip93_aead_encrypt,
+		.decrypt = eip93_aead_decrypt,
+		.ivsize	= AES_BLOCK_SIZE,
+		.setauthsize = eip93_aead_setauthsize,
+		.maxauthsize = SHA224_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(sha224),cbc(aes))",
+			.cra_driver_name =
+				"authenc(hmac(sha224-eip93),cbc(aes-eip93))",
+			.cra_priority = EIP93_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY |
+					CRYPTO_ALG_ALLOCATES_MEMORY,
+			.cra_blocksize = AES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct eip93_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = eip93_aead_cra_init,
+			.cra_exit = eip93_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_authenc_hmac_sha256_cbc_aes = {
+	.type = EIP93_ALG_TYPE_AEAD,
+	.flags = EIP93_HASH_HMAC | EIP93_HASH_SHA256 | EIP93_MODE_CBC | EIP93_ALG_AES,
+	.alg.aead = {
+		.setkey = eip93_aead_setkey,
+		.encrypt = eip93_aead_encrypt,
+		.decrypt = eip93_aead_decrypt,
+		.ivsize	= AES_BLOCK_SIZE,
+		.setauthsize = eip93_aead_setauthsize,
+		.maxauthsize = SHA256_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(sha256),cbc(aes))",
+			.cra_driver_name =
+				"authenc(hmac(sha256-eip93),cbc(aes-eip93))",
+			.cra_priority = EIP93_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY |
+					CRYPTO_ALG_ALLOCATES_MEMORY,
+			.cra_blocksize = AES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct eip93_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = eip93_aead_cra_init,
+			.cra_exit = eip93_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_authenc_hmac_md5_rfc3686_aes = {
+	.type = EIP93_ALG_TYPE_AEAD,
+	.flags = EIP93_HASH_HMAC | EIP93_HASH_MD5 |
+			EIP93_MODE_CTR | EIP93_MODE_RFC3686 | EIP93_ALG_AES,
+	.alg.aead = {
+		.setkey = eip93_aead_setkey,
+		.encrypt = eip93_aead_encrypt,
+		.decrypt = eip93_aead_decrypt,
+		.ivsize	= CTR_RFC3686_IV_SIZE,
+		.setauthsize = eip93_aead_setauthsize,
+		.maxauthsize = MD5_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(md5),rfc3686(ctr(aes)))",
+			.cra_driver_name =
+			"authenc(hmac(md5-eip93),rfc3686(ctr(aes-eip93)))",
+			.cra_priority = EIP93_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY |
+					CRYPTO_ALG_ALLOCATES_MEMORY,
+			.cra_blocksize = 1,
+			.cra_ctxsize = sizeof(struct eip93_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = eip93_aead_cra_init,
+			.cra_exit = eip93_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_authenc_hmac_sha1_rfc3686_aes = {
+	.type = EIP93_ALG_TYPE_AEAD,
+	.flags = EIP93_HASH_HMAC | EIP93_HASH_SHA1 |
+			EIP93_MODE_CTR | EIP93_MODE_RFC3686 | EIP93_ALG_AES,
+	.alg.aead = {
+		.setkey = eip93_aead_setkey,
+		.encrypt = eip93_aead_encrypt,
+		.decrypt = eip93_aead_decrypt,
+		.ivsize	= CTR_RFC3686_IV_SIZE,
+		.setauthsize = eip93_aead_setauthsize,
+		.maxauthsize = SHA1_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(sha1),rfc3686(ctr(aes)))",
+			.cra_driver_name =
+			"authenc(hmac(sha1-eip93),rfc3686(ctr(aes-eip93)))",
+			.cra_priority = EIP93_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY |
+					CRYPTO_ALG_ALLOCATES_MEMORY,
+			.cra_blocksize = 1,
+			.cra_ctxsize = sizeof(struct eip93_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = eip93_aead_cra_init,
+			.cra_exit = eip93_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_authenc_hmac_sha224_rfc3686_aes = {
+	.type = EIP93_ALG_TYPE_AEAD,
+	.flags = EIP93_HASH_HMAC | EIP93_HASH_SHA224 |
+			EIP93_MODE_CTR | EIP93_MODE_RFC3686 | EIP93_ALG_AES,
+	.alg.aead = {
+		.setkey = eip93_aead_setkey,
+		.encrypt = eip93_aead_encrypt,
+		.decrypt = eip93_aead_decrypt,
+		.ivsize	= CTR_RFC3686_IV_SIZE,
+		.setauthsize = eip93_aead_setauthsize,
+		.maxauthsize = SHA224_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(sha224),rfc3686(ctr(aes)))",
+			.cra_driver_name =
+			"authenc(hmac(sha224-eip93),rfc3686(ctr(aes-eip93)))",
+			.cra_priority = EIP93_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY |
+					CRYPTO_ALG_ALLOCATES_MEMORY,
+			.cra_blocksize = 1,
+			.cra_ctxsize = sizeof(struct eip93_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = eip93_aead_cra_init,
+			.cra_exit = eip93_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_authenc_hmac_sha256_rfc3686_aes = {
+	.type = EIP93_ALG_TYPE_AEAD,
+	.flags = EIP93_HASH_HMAC | EIP93_HASH_SHA256 |
+			EIP93_MODE_CTR | EIP93_MODE_RFC3686 | EIP93_ALG_AES,
+	.alg.aead = {
+		.setkey = eip93_aead_setkey,
+		.encrypt = eip93_aead_encrypt,
+		.decrypt = eip93_aead_decrypt,
+		.ivsize	= CTR_RFC3686_IV_SIZE,
+		.setauthsize = eip93_aead_setauthsize,
+		.maxauthsize = SHA256_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(sha256),rfc3686(ctr(aes)))",
+			.cra_driver_name =
+			"authenc(hmac(sha256-eip93),rfc3686(ctr(aes-eip93)))",
+			.cra_priority = EIP93_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY |
+					CRYPTO_ALG_ALLOCATES_MEMORY,
+			.cra_blocksize = 1,
+			.cra_ctxsize = sizeof(struct eip93_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = eip93_aead_cra_init,
+			.cra_exit = eip93_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_authenc_hmac_md5_cbc_des = {
+	.type = EIP93_ALG_TYPE_AEAD,
+	.flags = EIP93_HASH_HMAC | EIP93_HASH_MD5 | EIP93_MODE_CBC | EIP93_ALG_DES,
+	.alg.aead = {
+		.setkey = eip93_aead_setkey,
+		.encrypt = eip93_aead_encrypt,
+		.decrypt = eip93_aead_decrypt,
+		.ivsize	= DES_BLOCK_SIZE,
+		.setauthsize = eip93_aead_setauthsize,
+		.maxauthsize = MD5_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(md5),cbc(des))",
+			.cra_driver_name =
+				"authenc(hmac(md5-eip93),cbc(des-eip93))",
+			.cra_priority = EIP93_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY |
+					CRYPTO_ALG_ALLOCATES_MEMORY,
+			.cra_blocksize = DES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct eip93_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = eip93_aead_cra_init,
+			.cra_exit = eip93_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_authenc_hmac_sha1_cbc_des = {
+	.type = EIP93_ALG_TYPE_AEAD,
+	.flags = EIP93_HASH_HMAC | EIP93_HASH_SHA1 | EIP93_MODE_CBC | EIP93_ALG_DES,
+	.alg.aead = {
+		.setkey = eip93_aead_setkey,
+		.encrypt = eip93_aead_encrypt,
+		.decrypt = eip93_aead_decrypt,
+		.ivsize	= DES_BLOCK_SIZE,
+		.setauthsize = eip93_aead_setauthsize,
+		.maxauthsize = SHA1_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(sha1),cbc(des))",
+			.cra_driver_name =
+				"authenc(hmac(sha1-eip93),cbc(des-eip93))",
+			.cra_priority = EIP93_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY |
+					CRYPTO_ALG_ALLOCATES_MEMORY,
+			.cra_blocksize = DES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct eip93_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = eip93_aead_cra_init,
+			.cra_exit = eip93_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_authenc_hmac_sha224_cbc_des = {
+	.type = EIP93_ALG_TYPE_AEAD,
+	.flags = EIP93_HASH_HMAC | EIP93_HASH_SHA224 | EIP93_MODE_CBC | EIP93_ALG_DES,
+	.alg.aead = {
+		.setkey = eip93_aead_setkey,
+		.encrypt = eip93_aead_encrypt,
+		.decrypt = eip93_aead_decrypt,
+		.ivsize	= DES_BLOCK_SIZE,
+		.setauthsize = eip93_aead_setauthsize,
+		.maxauthsize = SHA224_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(sha224),cbc(des))",
+			.cra_driver_name =
+				"authenc(hmac(sha224-eip93),cbc(des-eip93))",
+			.cra_priority = EIP93_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY |
+					CRYPTO_ALG_ALLOCATES_MEMORY,
+			.cra_blocksize = DES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct eip93_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = eip93_aead_cra_init,
+			.cra_exit = eip93_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_authenc_hmac_sha256_cbc_des = {
+	.type = EIP93_ALG_TYPE_AEAD,
+	.flags = EIP93_HASH_HMAC | EIP93_HASH_SHA256 | EIP93_MODE_CBC | EIP93_ALG_DES,
+	.alg.aead = {
+		.setkey = eip93_aead_setkey,
+		.encrypt = eip93_aead_encrypt,
+		.decrypt = eip93_aead_decrypt,
+		.ivsize	= DES_BLOCK_SIZE,
+		.setauthsize = eip93_aead_setauthsize,
+		.maxauthsize = SHA256_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(sha256),cbc(des))",
+			.cra_driver_name =
+				"authenc(hmac(sha256-eip93),cbc(des-eip93))",
+			.cra_priority = EIP93_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY |
+					CRYPTO_ALG_ALLOCATES_MEMORY,
+			.cra_blocksize = DES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct eip93_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = eip93_aead_cra_init,
+			.cra_exit = eip93_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_authenc_hmac_md5_cbc_des3_ede = {
+	.type = EIP93_ALG_TYPE_AEAD,
+	.flags = EIP93_HASH_HMAC | EIP93_HASH_MD5 | EIP93_MODE_CBC | EIP93_ALG_3DES,
+	.alg.aead = {
+		.setkey = eip93_aead_setkey,
+		.encrypt = eip93_aead_encrypt,
+		.decrypt = eip93_aead_decrypt,
+		.ivsize	= DES3_EDE_BLOCK_SIZE,
+		.setauthsize = eip93_aead_setauthsize,
+		.maxauthsize = MD5_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(md5),cbc(des3_ede))",
+			.cra_driver_name =
+				"authenc(hmac(md5-eip93),cbc(des3_ede-eip93))",
+			.cra_priority = EIP93_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY |
+					CRYPTO_ALG_ALLOCATES_MEMORY,
+			.cra_blocksize = DES3_EDE_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct eip93_crypto_ctx),
+			.cra_alignmask = 0x0,
+			.cra_init = eip93_aead_cra_init,
+			.cra_exit = eip93_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_authenc_hmac_sha1_cbc_des3_ede = {
+	.type = EIP93_ALG_TYPE_AEAD,
+	.flags = EIP93_HASH_HMAC | EIP93_HASH_SHA1 | EIP93_MODE_CBC | EIP93_ALG_3DES,
+	.alg.aead = {
+		.setkey = eip93_aead_setkey,
+		.encrypt = eip93_aead_encrypt,
+		.decrypt = eip93_aead_decrypt,
+		.ivsize	= DES3_EDE_BLOCK_SIZE,
+		.setauthsize = eip93_aead_setauthsize,
+		.maxauthsize = SHA1_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(sha1),cbc(des3_ede))",
+			.cra_driver_name =
+				"authenc(hmac(sha1-eip93),cbc(des3_ede-eip93))",
+			.cra_priority = EIP93_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY |
+					CRYPTO_ALG_ALLOCATES_MEMORY,
+			.cra_blocksize = DES3_EDE_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct eip93_crypto_ctx),
+			.cra_alignmask = 0x0,
+			.cra_init = eip93_aead_cra_init,
+			.cra_exit = eip93_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_authenc_hmac_sha224_cbc_des3_ede = {
+	.type = EIP93_ALG_TYPE_AEAD,
+	.flags = EIP93_HASH_HMAC | EIP93_HASH_SHA224 | EIP93_MODE_CBC | EIP93_ALG_3DES,
+	.alg.aead = {
+		.setkey = eip93_aead_setkey,
+		.encrypt = eip93_aead_encrypt,
+		.decrypt = eip93_aead_decrypt,
+		.ivsize	= DES3_EDE_BLOCK_SIZE,
+		.setauthsize = eip93_aead_setauthsize,
+		.maxauthsize = SHA224_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(sha224),cbc(des3_ede))",
+			.cra_driver_name =
+			"authenc(hmac(sha224-eip93),cbc(des3_ede-eip93))",
+			.cra_priority = EIP93_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY |
+					CRYPTO_ALG_ALLOCATES_MEMORY,
+			.cra_blocksize = DES3_EDE_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct eip93_crypto_ctx),
+			.cra_alignmask = 0x0,
+			.cra_init = eip93_aead_cra_init,
+			.cra_exit = eip93_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_authenc_hmac_sha256_cbc_des3_ede = {
+	.type = EIP93_ALG_TYPE_AEAD,
+	.flags = EIP93_HASH_HMAC | EIP93_HASH_SHA256 | EIP93_MODE_CBC | EIP93_ALG_3DES,
+	.alg.aead = {
+		.setkey = eip93_aead_setkey,
+		.encrypt = eip93_aead_encrypt,
+		.decrypt = eip93_aead_decrypt,
+		.ivsize	= DES3_EDE_BLOCK_SIZE,
+		.setauthsize = eip93_aead_setauthsize,
+		.maxauthsize = SHA256_DIGEST_SIZE,
+		.base = {
+			.cra_name = "authenc(hmac(sha256),cbc(des3_ede))",
+			.cra_driver_name =
+			"authenc(hmac(sha256-eip93),cbc(des3_ede-eip93))",
+			.cra_priority = EIP93_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY |
+					CRYPTO_ALG_ALLOCATES_MEMORY,
+			.cra_blocksize = DES3_EDE_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct eip93_crypto_ctx),
+			.cra_alignmask = 0x0,
+			.cra_init = eip93_aead_cra_init,
+			.cra_exit = eip93_aead_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
diff --git a/drivers/crypto/inside-secure/eip93/eip93-aead.h b/drivers/crypto/inside-secure/eip93/eip93-aead.h
new file mode 100644
index 000000000000..e2fa8fd39c50
--- /dev/null
+++ b/drivers/crypto/inside-secure/eip93/eip93-aead.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2019 - 2021
+ *
+ * Richard van Schagen <vschagen@icloud.com>
+ * Christian Marangi <ansuelsmth@gmail.com
+ */
+#ifndef _EIP93_AEAD_H_
+#define _EIP93_AEAD_H_
+
+extern struct eip93_alg_template eip93_alg_authenc_hmac_md5_cbc_aes;
+extern struct eip93_alg_template eip93_alg_authenc_hmac_sha1_cbc_aes;
+extern struct eip93_alg_template eip93_alg_authenc_hmac_sha224_cbc_aes;
+extern struct eip93_alg_template eip93_alg_authenc_hmac_sha256_cbc_aes;
+extern struct eip93_alg_template eip93_alg_authenc_hmac_md5_ctr_aes;
+extern struct eip93_alg_template eip93_alg_authenc_hmac_sha1_ctr_aes;
+extern struct eip93_alg_template eip93_alg_authenc_hmac_sha224_ctr_aes;
+extern struct eip93_alg_template eip93_alg_authenc_hmac_sha256_ctr_aes;
+extern struct eip93_alg_template eip93_alg_authenc_hmac_md5_rfc3686_aes;
+extern struct eip93_alg_template eip93_alg_authenc_hmac_sha1_rfc3686_aes;
+extern struct eip93_alg_template eip93_alg_authenc_hmac_sha224_rfc3686_aes;
+extern struct eip93_alg_template eip93_alg_authenc_hmac_sha256_rfc3686_aes;
+extern struct eip93_alg_template eip93_alg_authenc_hmac_md5_cbc_des;
+extern struct eip93_alg_template eip93_alg_authenc_hmac_sha1_cbc_des;
+extern struct eip93_alg_template eip93_alg_authenc_hmac_sha224_cbc_des;
+extern struct eip93_alg_template eip93_alg_authenc_hmac_sha256_cbc_des;
+extern struct eip93_alg_template eip93_alg_authenc_hmac_md5_cbc_des3_ede;
+extern struct eip93_alg_template eip93_alg_authenc_hmac_sha1_cbc_des3_ede;
+extern struct eip93_alg_template eip93_alg_authenc_hmac_sha224_cbc_des3_ede;
+extern struct eip93_alg_template eip93_alg_authenc_hmac_sha256_cbc_des3_ede;
+extern struct eip93_alg_template eip93_alg_authenc_hmac_md5_ecb_null;
+extern struct eip93_alg_template eip93_alg_authenc_hmac_sha1_ecb_null;
+extern struct eip93_alg_template eip93_alg_authenc_hmac_sha224_ecb_null;
+extern struct eip93_alg_template eip93_alg_authenc_hmac_sha256_ecb_null;
+
+void eip93_aead_handle_result(struct crypto_async_request *async, int err);
+
+#endif /* _EIP93_AEAD_H_ */
diff --git a/drivers/crypto/inside-secure/eip93/eip93-aes.h b/drivers/crypto/inside-secure/eip93/eip93-aes.h
new file mode 100644
index 000000000000..1d83d39cab2a
--- /dev/null
+++ b/drivers/crypto/inside-secure/eip93/eip93-aes.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2019 - 2021
+ *
+ * Richard van Schagen <vschagen@icloud.com>
+ * Christian Marangi <ansuelsmth@gmail.com
+ */
+#ifndef _EIP93_AES_H_
+#define _EIP93_AES_H_
+
+extern struct eip93_alg_template eip93_alg_ecb_aes;
+extern struct eip93_alg_template eip93_alg_cbc_aes;
+extern struct eip93_alg_template eip93_alg_ctr_aes;
+extern struct eip93_alg_template eip93_alg_rfc3686_aes;
+
+#endif /* _EIP93_AES_H_ */
diff --git a/drivers/crypto/inside-secure/eip93/eip93-cipher.c b/drivers/crypto/inside-secure/eip93/eip93-cipher.c
new file mode 100644
index 000000000000..e35d6c942bf5
--- /dev/null
+++ b/drivers/crypto/inside-secure/eip93/eip93-cipher.c
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 - 2021
+ *
+ * Richard van Schagen <vschagen@icloud.com>
+ * Christian Marangi <ansuelsmth@gmail.com
+ */
+
+#include <crypto/aes.h>
+#include <crypto/ctr.h>
+#include <crypto/internal/des.h>
+#include <linux/dma-mapping.h>
+
+#include "eip93-aes.h"
+#include "eip93-cipher.h"
+#include "eip93-common.h"
+#include "eip93-des.h"
+#include "eip93-regs.h"
+
+void eip93_skcipher_handle_result(struct crypto_async_request *async, int err)
+{
+	struct eip93_crypto_ctx *ctx = crypto_tfm_ctx(async->tfm);
+	struct eip93_device *mtk = ctx->mtk;
+	struct skcipher_request *req = skcipher_request_cast(async);
+	struct eip93_cipher_reqctx *rctx = skcipher_request_ctx(req);
+
+	eip93_unmap_dma(mtk, rctx, req->src, req->dst);
+	eip93_handle_result(mtk, rctx, req->iv);
+
+	skcipher_request_complete(req, err);
+}
+
+static int eip93_skcipher_send_req(struct crypto_async_request *async)
+{
+	struct skcipher_request *req = skcipher_request_cast(async);
+	struct eip93_cipher_reqctx *rctx = skcipher_request_ctx(req);
+	int err;
+
+	err = check_valid_request(rctx);
+
+	if (err) {
+		skcipher_request_complete(req, err);
+		return err;
+	}
+
+	return eip93_send_req(async, req->iv, rctx);
+}
+
+/* Crypto skcipher API functions */
+static int eip93_skcipher_cra_init(struct crypto_tfm *tfm)
+{
+	struct eip93_crypto_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct eip93_alg_template *tmpl = container_of(tfm->__crt_alg,
+				struct eip93_alg_template, alg.skcipher.base);
+
+	crypto_skcipher_set_reqsize(__crypto_skcipher_cast(tfm),
+				    sizeof(struct eip93_cipher_reqctx));
+
+	memset(ctx, 0, sizeof(*ctx));
+
+	ctx->mtk = tmpl->mtk;
+	ctx->type = tmpl->type;
+
+	ctx->sa_record = kzalloc(sizeof(*ctx->sa_record), GFP_KERNEL);
+	if (!ctx->sa_record)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void eip93_skcipher_cra_exit(struct crypto_tfm *tfm)
+{
+	struct eip93_crypto_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	dma_unmap_single(ctx->mtk->dev, ctx->sa_record_base,
+			 sizeof(*ctx->sa_record), DMA_TO_DEVICE);
+	kfree(ctx->sa_record);
+}
+
+static int eip93_skcipher_setkey(struct crypto_skcipher *ctfm, const u8 *key,
+				 unsigned int len)
+{
+	struct crypto_tfm *tfm = crypto_skcipher_tfm(ctfm);
+	struct eip93_crypto_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct eip93_alg_template *tmpl = container_of(tfm->__crt_alg,
+						     struct eip93_alg_template,
+						     alg.skcipher.base);
+	struct sa_record *sa_record = ctx->sa_record;
+	unsigned int keylen = len;
+	u32 flags = tmpl->flags;
+	u32 nonce = 0;
+	int ret;
+
+	if (!key || !keylen)
+		return -EINVAL;
+
+	if (IS_RFC3686(flags)) {
+		if (len < CTR_RFC3686_NONCE_SIZE)
+			return -EINVAL;
+
+		keylen = len - CTR_RFC3686_NONCE_SIZE;
+		memcpy(&nonce, key + keylen, CTR_RFC3686_NONCE_SIZE);
+	}
+
+	if (flags & EIP93_ALG_DES) {
+		ctx->blksize = DES_BLOCK_SIZE;
+		ret = verify_skcipher_des_key(ctfm, key);
+		if (ret)
+			return ret;
+	}
+	if (flags & EIP93_ALG_3DES) {
+		ctx->blksize = DES3_EDE_BLOCK_SIZE;
+		ret = verify_skcipher_des3_key(ctfm, key);
+		if (ret)
+			return ret;
+	}
+
+	if (flags & EIP93_ALG_AES) {
+		struct crypto_aes_ctx aes;
+
+		ctx->blksize = AES_BLOCK_SIZE;
+		ret = aes_expandkey(&aes, key, keylen);
+		if (ret)
+			return ret;
+	}
+
+	eip93_set_sa_record(sa_record, keylen, flags);
+
+	memcpy(sa_record->sa_key, key, keylen);
+	ctx->sa_nonce = nonce;
+	sa_record->sa_nonce = nonce;
+
+	return 0;
+}
+
+static int eip93_skcipher_crypt(struct skcipher_request *req)
+{
+	struct eip93_cipher_reqctx *rctx = skcipher_request_ctx(req);
+	struct crypto_async_request *async = &req->base;
+	struct eip93_crypto_ctx *ctx = crypto_tfm_ctx(req->base.tfm);
+	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
+	int ret;
+
+	if (!req->cryptlen)
+		return 0;
+
+	/*
+	 * ECB and CBC algorithms require message lengths to be
+	 * multiples of block size.
+	 */
+	if (IS_ECB(rctx->flags) || IS_CBC(rctx->flags))
+		if (!IS_ALIGNED(req->cryptlen,
+				crypto_skcipher_blocksize(skcipher)))
+			return -EINVAL;
+
+	ctx->sa_record_base = dma_map_single(ctx->mtk->dev, ctx->sa_record,
+					     sizeof(*ctx->sa_record), DMA_TO_DEVICE);
+	ret = dma_mapping_error(ctx->mtk->dev, ctx->sa_record_base);
+	if (ret)
+		return ret;
+
+	rctx->assoclen = 0;
+	rctx->textsize = req->cryptlen;
+	rctx->authsize = 0;
+	rctx->sg_src = req->src;
+	rctx->sg_dst = req->dst;
+	rctx->ivsize = crypto_skcipher_ivsize(skcipher);
+	rctx->blksize = ctx->blksize;
+	rctx->desc_flags = EIP93_DESC_SKCIPHER;
+	rctx->sa_record_base = ctx->sa_record_base;
+
+	return eip93_skcipher_send_req(async);
+}
+
+static int eip93_skcipher_encrypt(struct skcipher_request *req)
+{
+	struct eip93_cipher_reqctx *rctx = skcipher_request_ctx(req);
+	struct eip93_alg_template *tmpl = container_of(req->base.tfm->__crt_alg,
+				struct eip93_alg_template, alg.skcipher.base);
+
+	rctx->flags = tmpl->flags;
+	rctx->flags |= EIP93_ENCRYPT;
+
+	return eip93_skcipher_crypt(req);
+}
+
+static int eip93_skcipher_decrypt(struct skcipher_request *req)
+{
+	struct eip93_crypto_ctx *ctx = crypto_tfm_ctx(req->base.tfm);
+	struct eip93_cipher_reqctx *rctx = skcipher_request_ctx(req);
+	struct eip93_alg_template *tmpl = container_of(req->base.tfm->__crt_alg,
+				struct eip93_alg_template, alg.skcipher.base);
+
+	ctx->sa_record->sa_cmd0_word |= EIP93_SA_CMD_DIRECTION_IN;
+
+	rctx->flags = tmpl->flags;
+	rctx->flags |= EIP93_DECRYPT;
+
+	return eip93_skcipher_crypt(req);
+}
+
+/* Available algorithms in this module */
+struct eip93_alg_template eip93_alg_ecb_aes = {
+	.type = EIP93_ALG_TYPE_SKCIPHER,
+	.flags = EIP93_MODE_ECB | EIP93_ALG_AES,
+	.alg.skcipher = {
+		.setkey = eip93_skcipher_setkey,
+		.encrypt = eip93_skcipher_encrypt,
+		.decrypt = eip93_skcipher_decrypt,
+		.min_keysize = AES_MIN_KEY_SIZE,
+		.max_keysize = AES_MAX_KEY_SIZE,
+		.ivsize	= 0,
+		.base = {
+			.cra_name = "ecb(aes)",
+			.cra_driver_name = "ecb(aes-eip93)",
+			.cra_priority = EIP93_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_NEED_FALLBACK |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = AES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct eip93_crypto_ctx),
+			.cra_alignmask = 0xf,
+			.cra_init = eip93_skcipher_cra_init,
+			.cra_exit = eip93_skcipher_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_cbc_aes = {
+	.type = EIP93_ALG_TYPE_SKCIPHER,
+	.flags = EIP93_MODE_CBC | EIP93_ALG_AES,
+	.alg.skcipher = {
+		.setkey = eip93_skcipher_setkey,
+		.encrypt = eip93_skcipher_encrypt,
+		.decrypt = eip93_skcipher_decrypt,
+		.min_keysize = AES_MIN_KEY_SIZE,
+		.max_keysize = AES_MAX_KEY_SIZE,
+		.ivsize	= AES_BLOCK_SIZE,
+		.base = {
+			.cra_name = "cbc(aes)",
+			.cra_driver_name = "cbc(aes-eip93)",
+			.cra_priority = EIP93_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_NEED_FALLBACK |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = AES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct eip93_crypto_ctx),
+			.cra_alignmask = 0xf,
+			.cra_init = eip93_skcipher_cra_init,
+			.cra_exit = eip93_skcipher_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_ctr_aes = {
+	.type = EIP93_ALG_TYPE_SKCIPHER,
+	.flags = EIP93_MODE_CTR | EIP93_ALG_AES,
+	.alg.skcipher = {
+		.setkey = eip93_skcipher_setkey,
+		.encrypt = eip93_skcipher_encrypt,
+		.decrypt = eip93_skcipher_decrypt,
+		.min_keysize = AES_MIN_KEY_SIZE,
+		.max_keysize = AES_MAX_KEY_SIZE,
+		.ivsize	= AES_BLOCK_SIZE,
+		.base = {
+			.cra_name = "ctr(aes)",
+			.cra_driver_name = "ctr(aes-eip93)",
+			.cra_priority = EIP93_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+				     CRYPTO_ALG_NEED_FALLBACK |
+				     CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = 1,
+			.cra_ctxsize = sizeof(struct eip93_crypto_ctx),
+			.cra_alignmask = 0xf,
+			.cra_init = eip93_skcipher_cra_init,
+			.cra_exit = eip93_skcipher_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_rfc3686_aes = {
+	.type = EIP93_ALG_TYPE_SKCIPHER,
+	.flags = EIP93_MODE_CTR | EIP93_MODE_RFC3686 | EIP93_ALG_AES,
+	.alg.skcipher = {
+		.setkey = eip93_skcipher_setkey,
+		.encrypt = eip93_skcipher_encrypt,
+		.decrypt = eip93_skcipher_decrypt,
+		.min_keysize = AES_MIN_KEY_SIZE + CTR_RFC3686_NONCE_SIZE,
+		.max_keysize = AES_MAX_KEY_SIZE + CTR_RFC3686_NONCE_SIZE,
+		.ivsize	= CTR_RFC3686_IV_SIZE,
+		.base = {
+			.cra_name = "rfc3686(ctr(aes))",
+			.cra_driver_name = "rfc3686(ctr(aes-eip93))",
+			.cra_priority = EIP93_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_NEED_FALLBACK |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = 1,
+			.cra_ctxsize = sizeof(struct eip93_crypto_ctx),
+			.cra_alignmask = 0xf,
+			.cra_init = eip93_skcipher_cra_init,
+			.cra_exit = eip93_skcipher_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_ecb_des = {
+	.type = EIP93_ALG_TYPE_SKCIPHER,
+	.flags = EIP93_MODE_ECB | EIP93_ALG_DES,
+	.alg.skcipher = {
+		.setkey = eip93_skcipher_setkey,
+		.encrypt = eip93_skcipher_encrypt,
+		.decrypt = eip93_skcipher_decrypt,
+		.min_keysize = DES_KEY_SIZE,
+		.max_keysize = DES_KEY_SIZE,
+		.ivsize	= 0,
+		.base = {
+			.cra_name = "ecb(des)",
+			.cra_driver_name = "ebc(des-eip93)",
+			.cra_priority = EIP93_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = DES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct eip93_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = eip93_skcipher_cra_init,
+			.cra_exit = eip93_skcipher_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_cbc_des = {
+	.type = EIP93_ALG_TYPE_SKCIPHER,
+	.flags = EIP93_MODE_CBC | EIP93_ALG_DES,
+	.alg.skcipher = {
+		.setkey = eip93_skcipher_setkey,
+		.encrypt = eip93_skcipher_encrypt,
+		.decrypt = eip93_skcipher_decrypt,
+		.min_keysize = DES_KEY_SIZE,
+		.max_keysize = DES_KEY_SIZE,
+		.ivsize	= DES_BLOCK_SIZE,
+		.base = {
+			.cra_name = "cbc(des)",
+			.cra_driver_name = "cbc(des-eip93)",
+			.cra_priority = EIP93_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = DES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct eip93_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = eip93_skcipher_cra_init,
+			.cra_exit = eip93_skcipher_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_ecb_des3_ede = {
+	.type = EIP93_ALG_TYPE_SKCIPHER,
+	.flags = EIP93_MODE_ECB | EIP93_ALG_3DES,
+	.alg.skcipher = {
+		.setkey = eip93_skcipher_setkey,
+		.encrypt = eip93_skcipher_encrypt,
+		.decrypt = eip93_skcipher_decrypt,
+		.min_keysize = DES3_EDE_KEY_SIZE,
+		.max_keysize = DES3_EDE_KEY_SIZE,
+		.ivsize	= 0,
+		.base = {
+			.cra_name = "ecb(des3_ede)",
+			.cra_driver_name = "ecb(des3_ede-eip93)",
+			.cra_priority = EIP93_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = DES3_EDE_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct eip93_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = eip93_skcipher_cra_init,
+			.cra_exit = eip93_skcipher_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_cbc_des3_ede = {
+	.type = EIP93_ALG_TYPE_SKCIPHER,
+	.flags = EIP93_MODE_CBC | EIP93_ALG_3DES,
+	.alg.skcipher = {
+		.setkey = eip93_skcipher_setkey,
+		.encrypt = eip93_skcipher_encrypt,
+		.decrypt = eip93_skcipher_decrypt,
+		.min_keysize = DES3_EDE_KEY_SIZE,
+		.max_keysize = DES3_EDE_KEY_SIZE,
+		.ivsize	= DES3_EDE_BLOCK_SIZE,
+		.base = {
+			.cra_name = "cbc(des3_ede)",
+			.cra_driver_name = "cbc(des3_ede-eip93)",
+			.cra_priority = EIP93_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = DES3_EDE_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct eip93_crypto_ctx),
+			.cra_alignmask = 0,
+			.cra_init = eip93_skcipher_cra_init,
+			.cra_exit = eip93_skcipher_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
diff --git a/drivers/crypto/inside-secure/eip93/eip93-cipher.h b/drivers/crypto/inside-secure/eip93/eip93-cipher.h
new file mode 100644
index 000000000000..093cc3386cfb
--- /dev/null
+++ b/drivers/crypto/inside-secure/eip93/eip93-cipher.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2019 - 2021
+ *
+ * Richard van Schagen <vschagen@icloud.com>
+ * Christian Marangi <ansuelsmth@gmail.com
+ */
+#ifndef _EIP93_CIPHER_H_
+#define _EIP93_CIPHER_H_
+
+#include "eip93-main.h"
+
+struct eip93_crypto_ctx {
+	struct eip93_device		*mtk;
+	u32				flags;
+	struct sa_record		*sa_record;
+	u32				sa_nonce;
+	int				blksize;
+	dma_addr_t			sa_record_base;
+	/* AEAD specific */
+	unsigned int			authsize;
+	unsigned int			assoclen;
+	bool				set_assoc;
+	enum eip93_alg_type		type;
+};
+
+struct eip93_cipher_reqctx {
+	u16				desc_flags;
+	u16				flags;
+	unsigned int			blksize;
+	unsigned int			ivsize;
+	unsigned int			textsize;
+	unsigned int			assoclen;
+	unsigned int			authsize;
+	dma_addr_t			sa_record_base;
+	struct sa_state			*sa_state;
+	dma_addr_t			sa_state_base;
+	struct eip93_descriptor		*cdesc;
+	struct scatterlist		*sg_src;
+	struct scatterlist		*sg_dst;
+	int				src_nents;
+	int				dst_nents;
+	struct sa_state			*sa_state_ctr;
+	dma_addr_t			sa_state_ctr_base;
+};
+
+int check_valid_request(struct eip93_cipher_reqctx *rctx);
+
+void eip93_unmap_dma(struct eip93_device *mtk, struct eip93_cipher_reqctx *rctx,
+		     struct scatterlist *reqsrc, struct scatterlist *reqdst);
+
+void eip93_skcipher_handle_result(struct crypto_async_request *async, int err);
+
+int eip93_send_req(struct crypto_async_request *async,
+		   const u8 *reqiv, struct eip93_cipher_reqctx *rctx);
+
+void eip93_handle_result(struct eip93_device *mtk, struct eip93_cipher_reqctx *rctx,
+			 u8 *reqiv);
+
+#endif /* _EIP93_CIPHER_H_ */
diff --git a/drivers/crypto/inside-secure/eip93/eip93-common.c b/drivers/crypto/inside-secure/eip93/eip93-common.c
new file mode 100644
index 000000000000..90103606a7ba
--- /dev/null
+++ b/drivers/crypto/inside-secure/eip93/eip93-common.c
@@ -0,0 +1,816 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 - 2021
+ *
+ * Richard van Schagen <vschagen@icloud.com>
+ * Christian Marangi <ansuelsmth@gmail.com
+ */
+
+#include <crypto/aes.h>
+#include <crypto/ctr.h>
+#include <crypto/hmac.h>
+#include <crypto/sha1.h>
+#include <crypto/sha2.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/scatterlist.h>
+
+#include "eip93-cipher.h"
+#include "eip93-hash.h"
+#include "eip93-common.h"
+#include "eip93-main.h"
+#include "eip93-regs.h"
+
+int eip93_parse_ctrl_stat_err(struct eip93_device *mtk, int err)
+{
+	u32 ext_err;
+
+	if (!err)
+		return 0;
+
+	switch (err & ~EIP93_PE_CTRL_PE_EXT_ERR_CODE) {
+	case EIP93_PE_CTRL_PE_AUTH_ERR:
+	case EIP93_PE_CTRL_PE_PAD_ERR:
+		return -EBADMSG;
+	/* let software handle anti-replay errors */
+	case EIP93_PE_CTRL_PE_SEQNUM_ERR:
+		return 0;
+	case EIP93_PE_CTRL_PE_EXT_ERR:
+		break;
+	default:
+		dev_err(mtk->dev, "Unhandled error 0x%08x\n", err);
+		return -EINVAL;
+	}
+
+	/* Parse additional ext errors */
+	ext_err = FIELD_GET(EIP93_PE_CTRL_PE_EXT_ERR_CODE, err);
+	switch (ext_err) {
+	case EIP93_PE_CTRL_PE_EXT_ERR_BUS:
+	case EIP93_PE_CTRL_PE_EXT_ERR_PROCESSING:
+		return -EIO;
+	case EIP93_PE_CTRL_PE_EXT_ERR_DESC_OWNER:
+		return -EACCES;
+	case EIP93_PE_CTRL_PE_EXT_ERR_INVALID_CRYPTO_OP:
+	case EIP93_PE_CTRL_PE_EXT_ERR_INVALID_CRYPTO_ALGO:
+	case EIP93_PE_CTRL_PE_EXT_ERR_SPI:
+		return -EINVAL;
+	case EIP93_PE_CTRL_PE_EXT_ERR_ZERO_LENGTH:
+	case EIP93_PE_CTRL_PE_EXT_ERR_INVALID_PK_LENGTH:
+	case EIP93_PE_CTRL_PE_EXT_ERR_BLOCK_SIZE_ERR:
+		return -EBADMSG;
+	default:
+		dev_err(mtk->dev, "Unhandled ext error 0x%08x\n", ext_err);
+		return -EINVAL;
+	}
+}
+
+static void *eip93_ring_next_wptr(struct eip93_device *mtk,
+				  struct eip93_desc_ring *ring)
+{
+	void *ptr = ring->write;
+
+	if ((ring->write == ring->read - ring->offset) ||
+	    (ring->read == ring->base && ring->write == ring->base_end))
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
+static void *eip93_ring_next_rptr(struct eip93_device *mtk,
+				  struct eip93_desc_ring *ring)
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
+int eip93_put_descriptor(struct eip93_device *mtk,
+			 struct eip93_descriptor *desc)
+{
+	struct eip93_descriptor *cdesc;
+	struct eip93_descriptor *rdesc;
+
+	guard(spinlock_irqsave)(&mtk->ring->write_lock);
+
+	rdesc = eip93_ring_next_wptr(mtk, &mtk->ring->rdr);
+	if (IS_ERR(rdesc))
+		return -ENOENT;
+
+	cdesc = eip93_ring_next_wptr(mtk, &mtk->ring->cdr);
+	if (IS_ERR(cdesc))
+		return -ENOENT;
+
+	memset(rdesc, 0, sizeof(struct eip93_descriptor));
+
+	memcpy(cdesc, desc, sizeof(struct eip93_descriptor));
+
+	atomic_dec(&mtk->ring->free);
+
+	return 0;
+}
+
+void *eip93_get_descriptor(struct eip93_device *mtk)
+{
+	struct eip93_descriptor *cdesc;
+	void *ptr;
+
+	guard(spinlock_irqsave)(&mtk->ring->read_lock);
+
+	cdesc = eip93_ring_next_rptr(mtk, &mtk->ring->cdr);
+	if (IS_ERR(cdesc))
+		return ERR_PTR(-ENOENT);
+
+	memset(cdesc, 0, sizeof(struct eip93_descriptor));
+
+	ptr = eip93_ring_next_rptr(mtk, &mtk->ring->rdr);
+	if (IS_ERR(ptr))
+		return ERR_PTR(-ENOENT);
+
+	atomic_inc(&mtk->ring->free);
+
+	return ptr;
+}
+
+static void eip93_free_sg_copy(const int len, struct scatterlist **sg)
+{
+	if (!*sg || !len)
+		return;
+
+	free_pages((unsigned long)sg_virt(*sg), get_order(len));
+	kfree(*sg);
+	*sg = NULL;
+}
+
+static int eip93_make_sg_copy(struct scatterlist *src, struct scatterlist **dst,
+			      const u32 len, const bool copy)
+{
+	void *pages;
+
+	*dst = kmalloc(sizeof(**dst), GFP_KERNEL);
+	if (!*dst)
+		return -ENOMEM;
+
+	pages = (void *)__get_free_pages(GFP_KERNEL | GFP_DMA,
+					 get_order(len));
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
+static bool eip93_is_sg_aligned(struct scatterlist *sg, u32 len,
+				const int blksize)
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
+int check_valid_request(struct eip93_cipher_reqctx *rctx)
+{
+	struct scatterlist *src = rctx->sg_src;
+	struct scatterlist *dst = rctx->sg_dst;
+	u32 src_nents, dst_nents;
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
+		if (unlikely((totlen_src || totlen_dst) && src_nents <= 0))
+			return err;
+
+	} else {
+		if (unlikely(totlen_src && src_nents <= 0))
+			return err;
+
+		if (unlikely(totlen_dst && dst_nents <= 0))
+			return err;
+	}
+
+	if (authsize) {
+		if (dst_nents == 1 && src_nents == 1) {
+			src_align = eip93_is_sg_aligned(src, totlen_src, blksize);
+			if (src ==  dst)
+				dst_align = src_align;
+			else
+				dst_align = eip93_is_sg_aligned(dst, totlen_dst, blksize);
+		} else {
+			src_align = false;
+			dst_align = false;
+		}
+	} else {
+		src_align = eip93_is_sg_aligned(src, totlen_src, blksize);
+		if (src == dst)
+			dst_align = src_align;
+		else
+			dst_align = eip93_is_sg_aligned(dst, totlen_dst, blksize);
+	}
+
+	copy_len = max(totlen_src, totlen_dst);
+	if (!src_align) {
+		err = eip93_make_sg_copy(src, &rctx->sg_src, copy_len, true);
+		if (err)
+			return err;
+	}
+
+	if (!dst_align) {
+		err = eip93_make_sg_copy(dst, &rctx->sg_dst, copy_len, false);
+		if (err)
+			return err;
+	}
+
+	rctx->src_nents = sg_nents_for_len(rctx->sg_src, totlen_src);
+	rctx->dst_nents = sg_nents_for_len(rctx->sg_dst, totlen_dst);
+
+	return 0;
+}
+
+/*
+ * Set sa_record function:
+ * Even sa_record is set to "0", keep " = 0" for readability.
+ */
+void eip93_set_sa_record(struct sa_record *sa_record, const unsigned int keylen,
+			 const u32 flags)
+{
+	/* Reset cmd word */
+	sa_record->sa_cmd0_word = 0;
+	sa_record->sa_cmd1_word = 0;
+
+	sa_record->sa_cmd0_word |= EIP93_SA_CMD_IV_FROM_STATE;
+	if (!IS_ECB(flags))
+		sa_record->sa_cmd0_word |= EIP93_SA_CMD_SAVE_IV;
+
+	sa_record->sa_cmd0_word |= EIP93_SA_CMD_OP_BASIC;
+
+	switch ((flags & EIP93_ALG_MASK)) {
+	case EIP93_ALG_AES:
+		sa_record->sa_cmd0_word |= EIP93_SA_CMD_CIPHER_AES;
+		sa_record->sa_cmd1_word |= FIELD_PREP(EIP93_SA_CMD_AES_KEY_LENGTH,
+						      keylen >> 3);
+		break;
+	case EIP93_ALG_3DES:
+		sa_record->sa_cmd0_word |= EIP93_SA_CMD_CIPHER_3DES;
+		break;
+	case EIP93_ALG_DES:
+		sa_record->sa_cmd0_word |= EIP93_SA_CMD_CIPHER_DES;
+		break;
+	default:
+		sa_record->sa_cmd0_word |= EIP93_SA_CMD_CIPHER_NULL;
+	}
+
+	switch ((flags & EIP93_HASH_MASK)) {
+	case EIP93_HASH_SHA256:
+		sa_record->sa_cmd0_word |= EIP93_SA_CMD_HASH_SHA256;
+		break;
+	case EIP93_HASH_SHA224:
+		sa_record->sa_cmd0_word |= EIP93_SA_CMD_HASH_SHA224;
+		break;
+	case EIP93_HASH_SHA1:
+		sa_record->sa_cmd0_word |= EIP93_SA_CMD_HASH_SHA1;
+		break;
+	case EIP93_HASH_MD5:
+		sa_record->sa_cmd0_word |= EIP93_SA_CMD_HASH_MD5;
+		break;
+	default:
+		sa_record->sa_cmd0_word |= EIP93_SA_CMD_HASH_NULL;
+	}
+
+	sa_record->sa_cmd0_word |= EIP93_SA_CMD_PAD_ZERO;
+
+	switch ((flags & EIP93_MODE_MASK)) {
+	case EIP93_MODE_CBC:
+		sa_record->sa_cmd1_word |= EIP93_SA_CMD_CHIPER_MODE_CBC;
+		break;
+	case EIP93_MODE_CTR:
+		sa_record->sa_cmd1_word |= EIP93_SA_CMD_CHIPER_MODE_CTR;
+		break;
+	case EIP93_MODE_ECB:
+		sa_record->sa_cmd1_word |= EIP93_SA_CMD_CHIPER_MODE_ECB;
+		break;
+	}
+
+	sa_record->sa_cmd0_word |= EIP93_SA_CMD_DIGEST_3WORD;
+	if (IS_HASH(flags)) {
+		sa_record->sa_cmd1_word |= EIP93_SA_CMD_COPY_PAD;
+		sa_record->sa_cmd1_word |= EIP93_SA_CMD_COPY_DIGEST;
+	}
+
+	if (IS_HMAC(flags)) {
+		sa_record->sa_cmd1_word |= EIP93_SA_CMD_HMAC;
+		sa_record->sa_cmd1_word |= EIP93_SA_CMD_COPY_HEADER;
+	}
+
+	sa_record->sa_spi = 0x0;
+	sa_record->sa_seqmum_mask[0] = 0xFFFFFFFF;
+	sa_record->sa_seqmum_mask[1] = 0x0;
+}
+
+/*
+ * Poor mans Scatter/gather function:
+ * Create a Descriptor for every segment to avoid copying buffers.
+ * For performance better to wait for hardware to perform multiple DMA
+ */
+static int eip93_scatter_combine(struct eip93_device *mtk,
+				 struct eip93_cipher_reqctx *rctx,
+				 u32 datalen, u32 split, int offsetin)
+{
+	struct eip93_descriptor *cdesc = rctx->cdesc;
+	struct scatterlist *sgsrc = rctx->sg_src;
+	struct scatterlist *sgdst = rctx->sg_dst;
+	unsigned int remainin = sg_dma_len(sgsrc);
+	unsigned int remainout = sg_dma_len(sgdst);
+	dma_addr_t saddr = sg_dma_address(sgsrc);
+	dma_addr_t daddr = sg_dma_address(sgdst);
+	dma_addr_t state_addr;
+	u32 src_addr, dst_addr, len, n;
+	bool nextin = false;
+	bool nextout = false;
+	int offsetout = 0;
+	int err;
+
+	if (IS_ECB(rctx->flags))
+		rctx->sa_state_base = 0;
+
+	if (split < datalen) {
+		state_addr = rctx->sa_state_ctr_base;
+		n = split;
+	} else {
+		state_addr = rctx->sa_state_base;
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
+		src_addr = saddr + offsetin;
+		dst_addr = daddr + offsetout;
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
+		cdesc->src_addr = src_addr;
+		cdesc->dst_addr = dst_addr;
+		cdesc->state_addr = state_addr;
+		cdesc->pe_length_word = FIELD_PREP(EIP93_PE_LENGTH_HOST_PE_READY,
+						   EIP93_PE_LENGTH_HOST_READY);
+		cdesc->pe_length_word |= FIELD_PREP(EIP93_PE_LENGTH_LENGTH, len);
+
+		if (n == 0) {
+			n = datalen - split;
+			split = datalen;
+			state_addr = rctx->sa_state_base;
+		}
+
+		if (n == 0)
+			cdesc->user_id |= FIELD_PREP(EIP93_PE_USER_ID_DESC_FLAGS,
+						     EIP93_DESC_LAST);
+
+		/*
+		 * Loop - Delay - No need to rollback
+		 * Maybe refine by slowing down at EIP93_RING_BUSY
+		 */
+again:
+		err = eip93_put_descriptor(mtk, cdesc);
+		if (err) {
+			usleep_range(EIP93_RING_BUSY_DELAY,
+				     EIP93_RING_BUSY_DELAY * 2);
+			goto again;
+		}
+		/* Writing new descriptor count starts DMA action */
+		writel(1, mtk->base + EIP93_REG_PE_CD_COUNT);
+	} while (n);
+
+	return -EINPROGRESS;
+}
+
+int eip93_send_req(struct crypto_async_request *async,
+		   const u8 *reqiv, struct eip93_cipher_reqctx *rctx)
+{
+	struct eip93_crypto_ctx *ctx = crypto_tfm_ctx(async->tfm);
+	struct eip93_device *mtk = ctx->mtk;
+	struct scatterlist *src = rctx->sg_src;
+	struct scatterlist *dst = rctx->sg_dst;
+	struct sa_state *sa_state;
+	struct eip93_descriptor cdesc;
+	u32 flags = rctx->flags;
+	int offsetin = 0, err;
+	u32 datalen = rctx->assoclen + rctx->textsize;
+	u32 split = datalen;
+	u32 start, end, ctr, blocks;
+	u32 iv[AES_BLOCK_SIZE / sizeof(u32)];
+	int crypto_async_idr;
+
+	rctx->sa_state_ctr = NULL;
+	rctx->sa_state = NULL;
+
+	if (IS_ECB(flags))
+		goto skip_iv;
+
+	memcpy(iv, reqiv, rctx->ivsize);
+
+	rctx->sa_state = kzalloc(sizeof(*rctx->sa_state), GFP_KERNEL);
+	if (!rctx->sa_state)
+		return -ENOMEM;
+
+	sa_state = rctx->sa_state;
+
+	memcpy(sa_state->state_iv, iv, rctx->ivsize);
+	if (IS_RFC3686(flags)) {
+		sa_state->state_iv[0] = ctx->sa_nonce;
+		sa_state->state_iv[1] = iv[0];
+		sa_state->state_iv[2] = iv[1];
+		sa_state->state_iv[3] = (u32 __force)cpu_to_be32(0x1);
+	} else if (!IS_HMAC(flags) && IS_CTR(flags)) {
+		/* Compute data length. */
+		blocks = DIV_ROUND_UP(rctx->textsize, AES_BLOCK_SIZE);
+		ctr = be32_to_cpu((__be32 __force)iv[3]);
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
+
+			rctx->sa_state_ctr = kzalloc(sizeof(*rctx->sa_state_ctr),
+						     GFP_KERNEL);
+			if (!rctx->sa_state_ctr) {
+				err = -ENOMEM;
+				goto free_sa_state;
+			}
+
+			memcpy(rctx->sa_state_ctr->state_iv, reqiv, rctx->ivsize);
+			memcpy(sa_state->state_iv, iv, rctx->ivsize);
+
+			rctx->sa_state_ctr_base = dma_map_single(mtk->dev, rctx->sa_state_ctr,
+								 sizeof(*rctx->sa_state_ctr),
+								 DMA_TO_DEVICE);
+			err = dma_mapping_error(mtk->dev, rctx->sa_state_ctr_base);
+			if (err)
+				goto free_sa_state_ctr;
+		}
+	}
+
+	rctx->sa_state_base = dma_map_single(mtk->dev, rctx->sa_state,
+					     sizeof(*rctx->sa_state), DMA_TO_DEVICE);
+	err = dma_mapping_error(mtk->dev, rctx->sa_state_base);
+	if (err)
+		goto free_sa_state_ctr_dma;
+
+skip_iv:
+
+	cdesc.pe_ctrl_stat_word = FIELD_PREP(EIP93_PE_CTRL_PE_READY_DES_TRING_OWN,
+					     EIP93_PE_CTRL_HOST_READY);
+	cdesc.sa_addr = rctx->sa_record_base;
+	cdesc.arc4_addr = 0;
+
+	scoped_guard(spinlock_bh, &mtk->ring->idr_lock)
+		crypto_async_idr = idr_alloc(&mtk->ring->crypto_async_idr, async, 0,
+					     EIP93_RING_NUM - 1, GFP_ATOMIC);
+
+	cdesc.user_id = FIELD_PREP(EIP93_PE_USER_ID_CRYPTO_IDR, (u16)crypto_async_idr) |
+			FIELD_PREP(EIP93_PE_USER_ID_DESC_FLAGS, rctx->desc_flags);
+
+	rctx->cdesc = &cdesc;
+
+	/* map DMA_BIDIRECTIONAL to invalidate cache on destination
+	 * implies __dma_cache_wback_inv
+	 */
+	if (!dma_map_sg(mtk->dev, dst, rctx->dst_nents, DMA_BIDIRECTIONAL)) {
+		err = -ENOMEM;
+		goto free_sa_state_ctr_dma;
+	}
+
+	if (src != dst &&
+	    !dma_map_sg(mtk->dev, src, rctx->src_nents, DMA_TO_DEVICE)) {
+		err = -ENOMEM;
+		goto free_sg_dma;
+	}
+
+	return eip93_scatter_combine(mtk, rctx, datalen, split, offsetin);
+
+free_sg_dma:
+	dma_unmap_sg(mtk->dev, dst, rctx->dst_nents, DMA_BIDIRECTIONAL);
+free_sa_state_ctr_dma:
+	if (rctx->sa_state_ctr)
+		dma_unmap_single(mtk->dev, rctx->sa_state_ctr_base,
+				 sizeof(*rctx->sa_state_ctr),
+				 DMA_TO_DEVICE);
+free_sa_state_ctr:
+	kfree(rctx->sa_state_ctr);
+	if (rctx->sa_state)
+		dma_unmap_single(mtk->dev, rctx->sa_state_base,
+				 sizeof(*rctx->sa_state),
+				 DMA_TO_DEVICE);
+free_sa_state:
+	kfree(rctx->sa_state);
+
+	return err;
+}
+
+void eip93_unmap_dma(struct eip93_device *mtk, struct eip93_cipher_reqctx *rctx,
+		     struct scatterlist *reqsrc, struct scatterlist *reqdst)
+{
+	u32 len = rctx->assoclen + rctx->textsize;
+	u32 authsize = rctx->authsize;
+	u32 flags = rctx->flags;
+	u32 *otag;
+	int i;
+
+	if (rctx->sg_src == rctx->sg_dst) {
+		dma_unmap_sg(mtk->dev, rctx->sg_dst, rctx->dst_nents,
+			     DMA_BIDIRECTIONAL);
+		goto process_tag;
+	}
+
+	dma_unmap_sg(mtk->dev, rctx->sg_src, rctx->src_nents,
+		     DMA_TO_DEVICE);
+
+	if (rctx->sg_src != reqsrc)
+		eip93_free_sg_copy(len +  rctx->authsize, &rctx->sg_src);
+
+	dma_unmap_sg(mtk->dev, rctx->sg_dst, rctx->dst_nents,
+		     DMA_BIDIRECTIONAL);
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
+				otag[i] = be32_to_cpu((__be32 __force)otag[i]);
+		}
+	}
+
+	if (rctx->sg_dst != reqdst) {
+		sg_copy_from_buffer(reqdst, sg_nents(reqdst),
+				    sg_virt(rctx->sg_dst), len + authsize);
+		eip93_free_sg_copy(len + rctx->authsize, &rctx->sg_dst);
+	}
+}
+
+void eip93_handle_result(struct eip93_device *mtk, struct eip93_cipher_reqctx *rctx,
+			 u8 *reqiv)
+{
+	if (rctx->sa_state_ctr)
+		dma_unmap_single(mtk->dev, rctx->sa_state_ctr_base,
+				 sizeof(*rctx->sa_state_ctr),
+				 DMA_FROM_DEVICE);
+
+	if (rctx->sa_state)
+		dma_unmap_single(mtk->dev, rctx->sa_state_base,
+				 sizeof(*rctx->sa_state),
+				 DMA_FROM_DEVICE);
+
+	if (!IS_ECB(rctx->flags))
+		memcpy(reqiv, rctx->sa_state->state_iv, rctx->ivsize);
+
+	kfree(rctx->sa_state_ctr);
+	kfree(rctx->sa_state);
+}
+
+int eip93_hmac_setkey(u32 ctx_flags, const u8 *key, unsigned int keylen,
+		      unsigned int hashlen, u8 *dest_ipad, u8 *dest_opad,
+		      bool skip_ipad)
+{
+	u8 ipad[SHA256_BLOCK_SIZE], opad[SHA256_BLOCK_SIZE];
+	struct crypto_ahash *ahash_tfm;
+	struct eip93_hash_reqctx *rctx;
+	struct ahash_request *req;
+	DECLARE_CRYPTO_WAIT(wait);
+	struct scatterlist sg[1];
+	const char *alg_name;
+	int i, ret;
+
+	switch (ctx_flags & EIP93_HASH_MASK) {
+	case EIP93_HASH_SHA256:
+		alg_name = "sha256-eip93";
+		break;
+	case EIP93_HASH_SHA224:
+		alg_name = "sha224-eip93";
+		break;
+	case EIP93_HASH_SHA1:
+		alg_name = "sha1-eip93";
+		break;
+	case EIP93_HASH_MD5:
+		alg_name = "md5-eip93";
+		break;
+	default: /* Impossible */
+		return -EINVAL;
+	}
+
+	ahash_tfm = crypto_alloc_ahash(alg_name, 0, 0);
+	if (IS_ERR(ahash_tfm))
+		return PTR_ERR(ahash_tfm);
+
+	req = ahash_request_alloc(ahash_tfm, GFP_ATOMIC);
+	if (!req) {
+		ret = -ENOMEM;
+		goto err_ahash;
+	}
+
+	rctx = ahash_request_ctx_dma(req);
+	crypto_init_wait(&wait);
+	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				   crypto_req_done, &wait);
+
+	/* Hash the key if > SHA256_BLOCK_SIZE */
+	if (keylen > SHA256_BLOCK_SIZE) {
+		sg_init_one(&sg[0], key, keylen);
+
+		ahash_request_set_crypt(req, sg, ipad, keylen);
+		ret = crypto_wait_req(crypto_ahash_digest(req), &wait);
+		if (ret)
+			goto err_req;
+
+		keylen = hashlen;
+	} else {
+		memcpy(ipad, key, keylen);
+	}
+
+	/* Copy to opad */
+	memset(ipad + keylen, 0, SHA256_BLOCK_SIZE - keylen);
+	memcpy(opad, ipad, SHA256_BLOCK_SIZE);
+
+	/* Pad with HMAC constants */
+	for (i = 0; i < SHA256_BLOCK_SIZE; i++) {
+		ipad[i] ^= HMAC_IPAD_VALUE;
+		opad[i] ^= HMAC_OPAD_VALUE;
+	}
+
+	if (skip_ipad) {
+		memcpy(dest_ipad, ipad, SHA256_BLOCK_SIZE);
+	} else {
+		/* Hash ipad */
+		sg_init_one(&sg[0], ipad, SHA256_BLOCK_SIZE);
+		ahash_request_set_crypt(req, sg, dest_ipad, SHA256_BLOCK_SIZE);
+		ret = crypto_ahash_init(req);
+		if (ret)
+			goto err_req;
+
+		/* Disable HASH_FINALIZE for ipad hash */
+		rctx->partial_hash = true;
+
+		ret = crypto_wait_req(crypto_ahash_finup(req), &wait);
+		if (ret)
+			goto err_req;
+	}
+
+	/* Hash opad */
+	sg_init_one(&sg[0], opad, SHA256_BLOCK_SIZE);
+	ahash_request_set_crypt(req, sg, dest_opad, SHA256_BLOCK_SIZE);
+	ret = crypto_ahash_init(req);
+	if (ret)
+		goto err_req;
+
+	/* Disable HASH_FINALIZE for opad hash */
+	rctx->partial_hash = true;
+
+	ret = crypto_wait_req(crypto_ahash_finup(req), &wait);
+	if (ret)
+		goto err_req;
+
+	if (!IS_HASH_MD5(ctx_flags)) {
+		for (i = 0; i < SHA256_DIGEST_SIZE / sizeof(u32); i++) {
+			u32 *ipad_hash = (u32 *)dest_ipad;
+			u32 *opad_hash = (u32 *)dest_opad;
+
+			if (!skip_ipad)
+				ipad_hash[i] = (u32 __force)cpu_to_be32(ipad_hash[i]);
+			opad_hash[i] = (u32 __force)cpu_to_be32(opad_hash[i]);
+		}
+	}
+
+err_req:
+	ahash_request_free(req);
+err_ahash:
+	crypto_free_ahash(ahash_tfm);
+
+	return ret;
+}
diff --git a/drivers/crypto/inside-secure/eip93/eip93-common.h b/drivers/crypto/inside-secure/eip93/eip93-common.h
new file mode 100644
index 000000000000..956a1793caeb
--- /dev/null
+++ b/drivers/crypto/inside-secure/eip93/eip93-common.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2019 - 2021
+ *
+ * Richard van Schagen <vschagen@icloud.com>
+ * Christian Marangi <ansuelsmth@gmail.com
+ */
+
+#ifndef _EIP93_COMMON_H_
+#define _EIP93_COMMON_H_
+
+void *eip93_get_descriptor(struct eip93_device *mtk);
+int eip93_put_descriptor(struct eip93_device *mtk, struct eip93_descriptor *desc);
+
+void eip93_set_sa_record(struct sa_record *sa_record, const unsigned int keylen,
+			 const u32 flags);
+
+int eip93_parse_ctrl_stat_err(struct eip93_device *mtk, int err);
+
+int eip93_hmac_setkey(u32 ctx_flags, const u8 *key, unsigned int keylen,
+		      unsigned int hashlen, u8 *ipad, u8 *opad,
+		      bool skip_ipad);
+
+#endif /* _EIP93_COMMON_H_ */
diff --git a/drivers/crypto/inside-secure/eip93/eip93-des.h b/drivers/crypto/inside-secure/eip93/eip93-des.h
new file mode 100644
index 000000000000..74748df04acf
--- /dev/null
+++ b/drivers/crypto/inside-secure/eip93/eip93-des.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2019 - 2021
+ *
+ * Richard van Schagen <vschagen@icloud.com>
+ * Christian Marangi <ansuelsmth@gmail.com
+ */
+#ifndef _EIP93_DES_H_
+#define _EIP93_DES_H_
+
+extern struct eip93_alg_template eip93_alg_ecb_des;
+extern struct eip93_alg_template eip93_alg_cbc_des;
+extern struct eip93_alg_template eip93_alg_ecb_des3_ede;
+extern struct eip93_alg_template eip93_alg_cbc_des3_ede;
+
+#endif /* _EIP93_DES_H_ */
diff --git a/drivers/crypto/inside-secure/eip93/eip93-hash.c b/drivers/crypto/inside-secure/eip93/eip93-hash.c
new file mode 100644
index 000000000000..509214d3a90a
--- /dev/null
+++ b/drivers/crypto/inside-secure/eip93/eip93-hash.c
@@ -0,0 +1,866 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024
+ *
+ * Christian Marangi <ansuelsmth@gmail.com
+ */
+
+#include <crypto/sha1.h>
+#include <crypto/sha2.h>
+#include <crypto/md5.h>
+#include <crypto/hmac.h>
+#include <linux/dma-mapping.h>
+#include <linux/delay.h>
+
+#include "eip93-cipher.h"
+#include "eip93-hash.h"
+#include "eip93-main.h"
+#include "eip93-common.h"
+#include "eip93-regs.h"
+
+static void eip93_hash_free_data_blocks(struct ahash_request *req)
+{
+	struct eip93_hash_reqctx *rctx = ahash_request_ctx_dma(req);
+	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
+	struct eip93_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct eip93_device *mtk = ctx->mtk;
+	struct mkt_hash_block *block, *tmp;
+
+	list_for_each_entry_safe(block, tmp, &rctx->blocks, list) {
+		dma_unmap_single(mtk->dev, block->data_dma,
+				 SHA256_BLOCK_SIZE, DMA_TO_DEVICE);
+		kfree(block);
+	}
+	if (!list_empty(&rctx->blocks))
+		INIT_LIST_HEAD(&rctx->blocks);
+
+	if (rctx->finalize)
+		dma_unmap_single(mtk->dev, rctx->data_dma,
+				 rctx->data_used,
+				 DMA_TO_DEVICE);
+}
+
+static void eip93_hash_free_sa_record(struct ahash_request *req)
+{
+	struct eip93_hash_reqctx *rctx = ahash_request_ctx_dma(req);
+	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
+	struct eip93_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct eip93_device *mtk = ctx->mtk;
+
+	if (IS_HMAC(ctx->flags))
+		dma_unmap_single(mtk->dev, rctx->sa_record_hmac_base,
+				 sizeof(rctx->sa_record_hmac), DMA_TO_DEVICE);
+
+	dma_unmap_single(mtk->dev, rctx->sa_record_base,
+			 sizeof(rctx->sa_record), DMA_TO_DEVICE);
+}
+
+void eip93_hash_handle_result(struct crypto_async_request *async, int err)
+{
+	struct ahash_request *req = ahash_request_cast(async);
+	struct eip93_hash_reqctx *rctx = ahash_request_ctx_dma(req);
+	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
+	struct eip93_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	int digestsize = crypto_ahash_digestsize(ahash);
+	struct sa_state *sa_state = &rctx->sa_state;
+	struct eip93_device *mtk = ctx->mtk;
+	int i;
+
+	dma_unmap_single(mtk->dev, rctx->sa_state_base,
+			 sizeof(*sa_state), DMA_FROM_DEVICE);
+
+	/*
+	 * With partial_hash assume SHA256_DIGEST_SIZE buffer is passed.
+	 * This is to handle SHA224 that have a 32 byte intermediate digest.
+	 */
+	if (rctx->partial_hash)
+		digestsize = SHA256_DIGEST_SIZE;
+
+	if (rctx->finalize || rctx->partial_hash) {
+		/* bytes needs to be swapped for req->result */
+		if (!IS_HASH_MD5(ctx->flags)) {
+			for (i = 0; i < digestsize / sizeof(u32); i++) {
+				u32 *digest = (u32 *)sa_state->state_i_digest;
+
+				digest[i] = be32_to_cpu((__be32 __force)digest[i]);
+			}
+		}
+
+		memcpy(req->result, sa_state->state_i_digest, digestsize);
+	}
+
+	eip93_hash_free_sa_record(req);
+	eip93_hash_free_data_blocks(req);
+
+	ahash_request_complete(req, err);
+}
+
+static void eip93_hash_init_sa_state_digest(u32 hash, u8 *digest)
+{
+	u32 sha256_init[] = { SHA256_H0, SHA256_H1, SHA256_H2, SHA256_H3,
+			      SHA256_H4, SHA256_H5, SHA256_H6, SHA256_H7 };
+	u32 sha224_init[] = { SHA224_H0, SHA224_H1, SHA224_H2, SHA224_H3,
+			      SHA224_H4, SHA224_H5, SHA224_H6, SHA224_H7 };
+	u32 sha1_init[] = { SHA1_H0, SHA1_H1, SHA1_H2, SHA1_H3, SHA1_H4 };
+	u32 md5_init[] = { MD5_H0, MD5_H1, MD5_H2, MD5_H3 };
+
+	/* Init HASH constant */
+	switch (hash) {
+	case EIP93_HASH_SHA256:
+		memcpy(digest, sha256_init, sizeof(sha256_init));
+		return;
+	case EIP93_HASH_SHA224:
+		memcpy(digest, sha224_init, sizeof(sha224_init));
+		return;
+	case EIP93_HASH_SHA1:
+		memcpy(digest, sha1_init, sizeof(sha1_init));
+		return;
+	case EIP93_HASH_MD5:
+		memcpy(digest, md5_init, sizeof(md5_init));
+		return;
+	default: /* Impossible */
+		return;
+	}
+}
+
+static void eip93_hash_export_sa_state(struct ahash_request *req,
+				       struct eip93_hash_export_state *state)
+{
+	struct eip93_hash_reqctx *rctx = ahash_request_ctx_dma(req);
+	struct sa_state *sa_state = &rctx->sa_state;
+
+	/*
+	 * EIP93 have special handling for state_byte_cnt in sa_state.
+	 * Even if a zero packet is passed (and a BADMSG is returned),
+	 * state_byte_cnt is incremented to the digest handled (with the hash
+	 * primitive). This is problematic with export/import as EIP93
+	 * expect 0 state_byte_cnt for the very first iteration.
+	 */
+	if (!rctx->len)
+		memset(state->state_len, 0, sizeof(u32) * 2);
+	else
+		memcpy(state->state_len, sa_state->state_byte_cnt,
+		       sizeof(u32) * 2);
+	memcpy(state->state_hash, sa_state->state_i_digest,
+	       SHA256_DIGEST_SIZE);
+	state->len = rctx->len;
+	state->data_used = rctx->data_used;
+}
+
+static void __eip93_hash_init(struct ahash_request *req)
+{
+	struct eip93_hash_reqctx *rctx = ahash_request_ctx_dma(req);
+	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
+	struct eip93_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct sa_record *sa_record = &rctx->sa_record;
+	int digestsize;
+
+	digestsize = crypto_ahash_digestsize(ahash);
+
+	eip93_set_sa_record(sa_record, 0, ctx->flags);
+	sa_record->sa_cmd0_word |= EIP93_SA_CMD_HASH_FROM_STATE;
+	sa_record->sa_cmd0_word |= EIP93_SA_CMD_SAVE_HASH;
+	sa_record->sa_cmd0_word &= ~EIP93_SA_CMD_OPCODE;
+	sa_record->sa_cmd0_word |= FIELD_PREP(EIP93_SA_CMD_OPCODE,
+					      EIP93_SA_CMD_OPCODE_BASIC_OUT_HASH);
+	sa_record->sa_cmd0_word &= ~EIP93_SA_CMD_DIGEST_LENGTH;
+	sa_record->sa_cmd0_word |= FIELD_PREP(EIP93_SA_CMD_DIGEST_LENGTH,
+					      digestsize / sizeof(u32));
+
+	/*
+	 * HMAC special handling
+	 * Enabling CMD_HMAC force the inner hash to be always finalized.
+	 * This cause problems on handling message > 64 byte as we
+	 * need to produce intermediate inner hash on sending intermediate
+	 * 64 bytes blocks.
+	 *
+	 * To handle this, enable CMD_HMAC only on the last block.
+	 * We make a duplicate of sa_record and on the last descriptor,
+	 * we pass a dedicated sa_record with CMD_HMAC enabled to make
+	 * EIP93 apply the outer hash.
+	 */
+	if (IS_HMAC(ctx->flags)) {
+		struct sa_record *sa_record_hmac = &rctx->sa_record_hmac;
+
+		memcpy(sa_record_hmac, sa_record, sizeof(*sa_record));
+		/* Copy pre-hashed opad for HMAC */
+		memcpy(sa_record_hmac->sa_o_digest, ctx->opad, SHA256_DIGEST_SIZE);
+
+		/* Disable HMAC for hash normal sa_record */
+		sa_record->sa_cmd1_word &= ~EIP93_SA_CMD_HMAC;
+	}
+
+	rctx->len = 0;
+	rctx->data_used = 0;
+	rctx->partial_hash = false;
+	rctx->finalize = false;
+	INIT_LIST_HEAD(&rctx->blocks);
+}
+
+static int eip93_send_hash_req(struct crypto_async_request *async, u8 *data,
+			       dma_addr_t *data_dma, u32 len, bool last)
+{
+	struct ahash_request *req = ahash_request_cast(async);
+	struct eip93_hash_reqctx *rctx = ahash_request_ctx_dma(req);
+	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
+	struct eip93_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct eip93_device *mtk = ctx->mtk;
+	struct eip93_descriptor cdesc = { };
+	dma_addr_t src_addr;
+	int ret;
+
+	/* Map block data to DMA */
+	src_addr = dma_map_single(mtk->dev, data, len, DMA_TO_DEVICE);
+	ret = dma_mapping_error(mtk->dev, src_addr);
+	if (ret)
+		return ret;
+
+	cdesc.pe_ctrl_stat_word = FIELD_PREP(EIP93_PE_CTRL_PE_READY_DES_TRING_OWN,
+					     EIP93_PE_CTRL_HOST_READY);
+	cdesc.sa_addr = rctx->sa_record_base;
+	cdesc.arc4_addr = 0;
+
+	cdesc.state_addr = rctx->sa_state_base;
+	cdesc.src_addr = src_addr;
+	cdesc.pe_length_word = FIELD_PREP(EIP93_PE_LENGTH_HOST_PE_READY,
+					  EIP93_PE_LENGTH_HOST_READY);
+	cdesc.pe_length_word |= FIELD_PREP(EIP93_PE_LENGTH_LENGTH,
+					   len);
+
+	cdesc.user_id |= FIELD_PREP(EIP93_PE_USER_ID_DESC_FLAGS, EIP93_DESC_HASH);
+
+	if (last) {
+		int crypto_async_idr;
+
+		if (rctx->finalize && !rctx->partial_hash) {
+			/* For last block, pass sa_record with CMD_HMAC enabled */
+			if (IS_HMAC(ctx->flags)) {
+				struct sa_record *sa_record_hmac = &rctx->sa_record_hmac;
+
+				rctx->sa_record_hmac_base = dma_map_single(mtk->dev,
+									   sa_record_hmac,
+									   sizeof(*sa_record_hmac),
+									   DMA_TO_DEVICE);
+				ret = dma_mapping_error(mtk->dev, rctx->sa_record_hmac_base);
+				if (ret)
+					return ret;
+
+				cdesc.sa_addr = rctx->sa_record_hmac_base;
+			}
+
+			cdesc.pe_ctrl_stat_word |= EIP93_PE_CTRL_PE_HASH_FINAL;
+		}
+
+		scoped_guard(spinlock_bh, &mtk->ring->idr_lock)
+			crypto_async_idr = idr_alloc(&mtk->ring->crypto_async_idr, async, 0,
+						     EIP93_RING_NUM - 1, GFP_ATOMIC);
+
+		cdesc.user_id |= FIELD_PREP(EIP93_PE_USER_ID_CRYPTO_IDR, (u16)crypto_async_idr) |
+				 FIELD_PREP(EIP93_PE_USER_ID_DESC_FLAGS, EIP93_DESC_LAST);
+	}
+
+again:
+	ret = eip93_put_descriptor(mtk, &cdesc);
+	if (ret) {
+		usleep_range(EIP93_RING_BUSY_DELAY,
+			     EIP93_RING_BUSY_DELAY * 2);
+		goto again;
+	}
+
+	/* Writing new descriptor count starts DMA action */
+	writel(1, mtk->base + EIP93_REG_PE_CD_COUNT);
+
+	*data_dma = src_addr;
+	return 0;
+}
+
+static int eip93_hash_init(struct ahash_request *req)
+{
+	struct eip93_hash_reqctx *rctx = ahash_request_ctx_dma(req);
+	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
+	struct eip93_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct sa_state *sa_state = &rctx->sa_state;
+
+	memset(sa_state->state_byte_cnt, 0, sizeof(u32) * 2);
+	eip93_hash_init_sa_state_digest(ctx->flags & EIP93_HASH_MASK,
+					sa_state->state_i_digest);
+
+	__eip93_hash_init(req);
+
+	/* For HMAC setup the initial block for ipad */
+	if (IS_HMAC(ctx->flags)) {
+		memcpy(rctx->data, ctx->ipad, SHA256_BLOCK_SIZE);
+
+		rctx->data_used = SHA256_BLOCK_SIZE;
+		rctx->len += SHA256_BLOCK_SIZE;
+	}
+
+	return 0;
+}
+
+/*
+ * With complete_req true, we wait for the engine to consume all the block in list,
+ * else we just queue the block to the engine as final() will wait. This is useful
+ * for finup().
+ */
+static int __eip93_hash_update(struct ahash_request *req, bool complete_req)
+{
+	struct eip93_hash_reqctx *rctx = ahash_request_ctx_dma(req);
+	struct crypto_async_request *async = &req->base;
+	unsigned int read, to_consume = req->nbytes;
+	unsigned int max_read, consumed = 0;
+	struct mkt_hash_block *block;
+	bool wait_req = false;
+	int offset;
+	int ret;
+
+	/* Get the offset and available space to fill req data */
+	offset = rctx->data_used;
+	max_read = SHA256_BLOCK_SIZE - offset;
+
+	/* Consume req in block of SHA256_BLOCK_SIZE.
+	 * to_read is initially set to space available in the req data
+	 * and then reset to SHA256_BLOCK_SIZE.
+	 */
+	while (to_consume > max_read) {
+		block = kzalloc(sizeof(*block), GFP_ATOMIC);
+		if (!block) {
+			ret = -ENOMEM;
+			goto free_blocks;
+		}
+
+		read = sg_pcopy_to_buffer(req->src, sg_nents(req->src),
+					  block->data + offset,
+					  max_read, consumed);
+
+		/*
+		 * For first iteration only, copy req data to block
+		 * and reset offset and max_read for next iteration.
+		 */
+		if (offset > 0) {
+			memcpy(block->data, rctx->data, offset);
+			offset = 0;
+			max_read = SHA256_BLOCK_SIZE;
+		}
+
+		list_add(&block->list, &rctx->blocks);
+		to_consume -= read;
+		consumed += read;
+	}
+
+	/* Write the remaining data to req data */
+	read = sg_pcopy_to_buffer(req->src, sg_nents(req->src),
+				  rctx->data + offset, to_consume,
+				  consumed);
+	rctx->data_used = offset + read;
+
+	/* Update counter with processed bytes */
+	rctx->len += read + consumed;
+
+	/* Consume all the block added to list */
+	list_for_each_entry_reverse(block, &rctx->blocks, list) {
+		wait_req = complete_req &&
+			    list_is_first(&block->list, &rctx->blocks);
+
+		ret = eip93_send_hash_req(async, block->data,
+					  &block->data_dma,
+					  SHA256_BLOCK_SIZE, wait_req);
+		if (ret)
+			goto free_blocks;
+	}
+
+	return wait_req ? -EINPROGRESS : 0;
+
+free_blocks:
+	eip93_hash_free_data_blocks(req);
+
+	return ret;
+}
+
+static int eip93_hash_update(struct ahash_request *req)
+{
+	struct eip93_hash_reqctx *rctx = ahash_request_ctx_dma(req);
+	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
+	struct eip93_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct sa_record *sa_record = &rctx->sa_record;
+	struct sa_state *sa_state = &rctx->sa_state;
+	struct eip93_device *mtk = ctx->mtk;
+	int ret;
+
+	if (!req->nbytes)
+		return 0;
+
+	rctx->sa_state_base = dma_map_single(mtk->dev, sa_state,
+					     sizeof(*sa_state),
+					     DMA_TO_DEVICE);
+	ret = dma_mapping_error(mtk->dev, rctx->sa_state_base);
+	if (ret)
+		return ret;
+
+	rctx->sa_record_base = dma_map_single(mtk->dev, sa_record,
+					      sizeof(*sa_record),
+					      DMA_TO_DEVICE);
+	ret = dma_mapping_error(mtk->dev, rctx->sa_record_base);
+	if (ret)
+		goto free_sa_state;
+
+	ret = __eip93_hash_update(req, true);
+	if (ret && ret != -EINPROGRESS)
+		goto free_sa_record;
+
+	return ret;
+
+free_sa_record:
+	dma_unmap_single(mtk->dev, rctx->sa_record_base,
+			 sizeof(*sa_record), DMA_TO_DEVICE);
+
+free_sa_state:
+	dma_unmap_single(mtk->dev, rctx->sa_state_base,
+			 sizeof(*sa_state), DMA_TO_DEVICE);
+
+	return ret;
+}
+
+/*
+ * With map_data true, we map the sa_record and sa_state. This is needed
+ * for finup() as the they are mapped before calling update()
+ */
+static int __eip93_hash_final(struct ahash_request *req, bool map_dma)
+{
+	struct eip93_hash_reqctx *rctx = ahash_request_ctx_dma(req);
+	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
+	struct eip93_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct crypto_async_request *async = &req->base;
+	struct sa_record *sa_record = &rctx->sa_record;
+	struct sa_state *sa_state = &rctx->sa_state;
+	struct eip93_device *mtk = ctx->mtk;
+	int ret;
+
+	/* EIP93 can't handle zero bytes hash */
+	if (!rctx->len && !IS_HMAC(ctx->flags)) {
+		switch ((ctx->flags & EIP93_HASH_MASK)) {
+		case EIP93_HASH_SHA256:
+			memcpy(req->result, sha256_zero_message_hash,
+			       SHA256_DIGEST_SIZE);
+			break;
+		case EIP93_HASH_SHA224:
+			memcpy(req->result, sha224_zero_message_hash,
+			       SHA224_DIGEST_SIZE);
+			break;
+		case EIP93_HASH_SHA1:
+			memcpy(req->result, sha1_zero_message_hash,
+			       SHA1_DIGEST_SIZE);
+			break;
+		case EIP93_HASH_MD5:
+			memcpy(req->result, md5_zero_message_hash,
+			       MD5_DIGEST_SIZE);
+			break;
+		default: /* Impossible */
+			return -EINVAL;
+		}
+
+		return 0;
+	}
+
+	/* Signal interrupt from engine is for last block */
+	rctx->finalize = true;
+
+	if (map_dma) {
+		rctx->sa_state_base = dma_map_single(mtk->dev, sa_state,
+						     sizeof(*sa_state),
+						     DMA_TO_DEVICE);
+		ret = dma_mapping_error(mtk->dev, rctx->sa_state_base);
+		if (ret)
+			return ret;
+
+		rctx->sa_record_base = dma_map_single(mtk->dev, sa_record,
+						      sizeof(*sa_record),
+						      DMA_TO_DEVICE);
+		ret = dma_mapping_error(mtk->dev, rctx->sa_record_base);
+		if (ret)
+			goto free_sa_state;
+	}
+
+	/* Send last block */
+	ret = eip93_send_hash_req(async, rctx->data, &rctx->data_dma,
+				  rctx->data_used, true);
+	if (ret)
+		goto free_blocks;
+
+	return -EINPROGRESS;
+
+free_blocks:
+	eip93_hash_free_data_blocks(req);
+
+	dma_unmap_single(mtk->dev, rctx->sa_record_base,
+			 sizeof(*sa_record), DMA_TO_DEVICE);
+
+free_sa_state:
+	dma_unmap_single(mtk->dev, rctx->sa_state_base,
+			 sizeof(*sa_state), DMA_TO_DEVICE);
+
+	return ret;
+}
+
+static int eip93_hash_final(struct ahash_request *req)
+{
+	return __eip93_hash_final(req, true);
+}
+
+static int eip93_hash_finup(struct ahash_request *req)
+{
+	struct eip93_hash_reqctx *rctx = ahash_request_ctx_dma(req);
+	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
+	struct eip93_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct sa_record *sa_record = &rctx->sa_record;
+	struct sa_state *sa_state = &rctx->sa_state;
+	struct eip93_device *mtk = ctx->mtk;
+	int ret;
+
+	if (rctx->len + req->nbytes || IS_HMAC(ctx->flags)) {
+		rctx->sa_state_base = dma_map_single(mtk->dev, sa_state,
+						     sizeof(*sa_state),
+						     DMA_TO_DEVICE);
+		ret = dma_mapping_error(mtk->dev, rctx->sa_state_base);
+		if (ret)
+			return ret;
+
+		rctx->sa_record_base = dma_map_single(mtk->dev, sa_record,
+						      sizeof(*sa_record),
+						      DMA_TO_DEVICE);
+		ret = dma_mapping_error(mtk->dev, rctx->sa_record_base);
+		if (ret)
+			goto free_sa_state;
+
+		ret = __eip93_hash_update(req, false);
+		if (ret)
+			goto free_sa_record;
+	}
+
+	return __eip93_hash_final(req, false);
+
+free_sa_record:
+	dma_unmap_single(mtk->dev, rctx->sa_record_base,
+			 sizeof(*sa_record), DMA_TO_DEVICE);
+free_sa_state:
+	dma_unmap_single(mtk->dev, rctx->sa_state_base,
+			 sizeof(*sa_state), DMA_TO_DEVICE);
+
+	return ret;
+}
+
+static int eip93_hash_hmac_setkey(struct crypto_ahash *ahash, const u8 *key,
+				  u32 keylen)
+{
+	unsigned int digestsize = crypto_ahash_digestsize(ahash);
+	struct crypto_tfm *tfm = crypto_ahash_tfm(ahash);
+	struct eip93_hash_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	return eip93_hmac_setkey(ctx->flags, key, keylen, digestsize,
+				 ctx->ipad, ctx->opad, true);
+}
+
+static int eip93_hash_cra_init(struct crypto_tfm *tfm)
+{
+	struct eip93_hash_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct eip93_alg_template *tmpl = container_of(tfm->__crt_alg,
+				struct eip93_alg_template, alg.ahash.halg.base);
+
+	crypto_ahash_set_reqsize_dma(__crypto_ahash_cast(tfm),
+				     sizeof(struct eip93_hash_reqctx));
+
+	ctx->mtk = tmpl->mtk;
+	ctx->flags = tmpl->flags;
+
+	return 0;
+}
+
+static int eip93_hash_digest(struct ahash_request *req)
+{
+	int ret;
+
+	ret = eip93_hash_init(req);
+	if (ret)
+		return ret;
+
+	return eip93_hash_finup(req);
+}
+
+static int eip93_hash_import(struct ahash_request *req, const void *in)
+{
+	struct eip93_hash_reqctx *rctx = ahash_request_ctx_dma(req);
+	const struct eip93_hash_export_state *state = in;
+	struct sa_state *sa_state = &rctx->sa_state;
+
+	memcpy(sa_state->state_byte_cnt, state->state_len, sizeof(u32) * 2);
+	memcpy(sa_state->state_i_digest, state->state_hash, SHA256_DIGEST_SIZE);
+
+	__eip93_hash_init(req);
+
+	rctx->len = state->len;
+	rctx->data_used = state->data_used;
+
+	/* Skip copying data if we have nothing to copy */
+	if (rctx->len)
+		memcpy(rctx->data, state->data, rctx->data_used);
+
+	return 0;
+}
+
+static int eip93_hash_export(struct ahash_request *req, void *out)
+{
+	struct eip93_hash_reqctx *rctx = ahash_request_ctx_dma(req);
+	struct eip93_hash_export_state *state = out;
+
+	/* Save the first block in state data */
+	if (rctx->len)
+		memcpy(state->data, rctx->data, rctx->data_used);
+
+	eip93_hash_export_sa_state(req, state);
+
+	return 0;
+}
+
+struct eip93_alg_template eip93_alg_md5 = {
+	.type = EIP93_ALG_TYPE_HASH,
+	.flags = EIP93_HASH_MD5,
+	.alg.ahash = {
+		.init = eip93_hash_init,
+		.update = eip93_hash_update,
+		.final = eip93_hash_final,
+		.finup = eip93_hash_finup,
+		.digest = eip93_hash_digest,
+		.export = eip93_hash_export,
+		.import = eip93_hash_import,
+		.halg = {
+			.digestsize = MD5_DIGEST_SIZE,
+			.statesize = sizeof(struct eip93_hash_export_state),
+			.base = {
+				.cra_name = "md5",
+				.cra_driver_name = "md5-eip93",
+				.cra_priority = 300,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+						CRYPTO_ALG_KERN_DRIVER_ONLY |
+						CRYPTO_ALG_ALLOCATES_MEMORY,
+				.cra_blocksize = MD5_HMAC_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct eip93_hash_ctx),
+				.cra_init = eip93_hash_cra_init,
+				.cra_module = THIS_MODULE,
+			},
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_sha1 = {
+	.type = EIP93_ALG_TYPE_HASH,
+	.flags = EIP93_HASH_SHA1,
+	.alg.ahash = {
+		.init = eip93_hash_init,
+		.update = eip93_hash_update,
+		.final = eip93_hash_final,
+		.finup = eip93_hash_finup,
+		.digest = eip93_hash_digest,
+		.export = eip93_hash_export,
+		.import = eip93_hash_import,
+		.halg = {
+			.digestsize = SHA1_DIGEST_SIZE,
+			.statesize = sizeof(struct eip93_hash_export_state),
+			.base = {
+				.cra_name = "sha1",
+				.cra_driver_name = "sha1-eip93",
+				.cra_priority = 300,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+						CRYPTO_ALG_KERN_DRIVER_ONLY |
+						CRYPTO_ALG_ALLOCATES_MEMORY,
+				.cra_blocksize = SHA1_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct eip93_hash_ctx),
+				.cra_init = eip93_hash_cra_init,
+				.cra_module = THIS_MODULE,
+			},
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_sha224 = {
+	.type = EIP93_ALG_TYPE_HASH,
+	.flags = EIP93_HASH_SHA224,
+	.alg.ahash = {
+		.init = eip93_hash_init,
+		.update = eip93_hash_update,
+		.final = eip93_hash_final,
+		.finup = eip93_hash_finup,
+		.digest = eip93_hash_digest,
+		.export = eip93_hash_export,
+		.import = eip93_hash_import,
+		.halg = {
+			.digestsize = SHA224_DIGEST_SIZE,
+			.statesize = sizeof(struct eip93_hash_export_state),
+			.base = {
+				.cra_name = "sha224",
+				.cra_driver_name = "sha224-eip93",
+				.cra_priority = 300,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+						CRYPTO_ALG_KERN_DRIVER_ONLY |
+						CRYPTO_ALG_ALLOCATES_MEMORY,
+				.cra_blocksize = SHA224_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct eip93_hash_ctx),
+				.cra_init = eip93_hash_cra_init,
+				.cra_module = THIS_MODULE,
+			},
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_sha256 = {
+	.type = EIP93_ALG_TYPE_HASH,
+	.flags = EIP93_HASH_SHA256,
+	.alg.ahash = {
+		.init = eip93_hash_init,
+		.update = eip93_hash_update,
+		.final = eip93_hash_final,
+		.finup = eip93_hash_finup,
+		.digest = eip93_hash_digest,
+		.export = eip93_hash_export,
+		.import = eip93_hash_import,
+		.halg = {
+			.digestsize = SHA256_DIGEST_SIZE,
+			.statesize = sizeof(struct eip93_hash_export_state),
+			.base = {
+				.cra_name = "sha256",
+				.cra_driver_name = "sha256-eip93",
+				.cra_priority = 300,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+						CRYPTO_ALG_KERN_DRIVER_ONLY |
+						CRYPTO_ALG_ALLOCATES_MEMORY,
+				.cra_blocksize = SHA256_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct eip93_hash_ctx),
+				.cra_init = eip93_hash_cra_init,
+				.cra_module = THIS_MODULE,
+			},
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_hmac_md5 = {
+	.type = EIP93_ALG_TYPE_HASH,
+	.flags = EIP93_HASH_HMAC | EIP93_HASH_MD5,
+	.alg.ahash = {
+		.init = eip93_hash_init,
+		.update = eip93_hash_update,
+		.final = eip93_hash_final,
+		.finup = eip93_hash_finup,
+		.digest = eip93_hash_digest,
+		.setkey = eip93_hash_hmac_setkey,
+		.export = eip93_hash_export,
+		.import = eip93_hash_import,
+		.halg = {
+			.digestsize = MD5_DIGEST_SIZE,
+			.statesize = sizeof(struct eip93_hash_export_state),
+			.base = {
+				.cra_name = "hmac(md5)",
+				.cra_driver_name = "hmac(md5-eip93)",
+				.cra_priority = 300,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+						CRYPTO_ALG_KERN_DRIVER_ONLY |
+						CRYPTO_ALG_ALLOCATES_MEMORY,
+				.cra_blocksize = MD5_HMAC_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct eip93_hash_ctx),
+				.cra_init = eip93_hash_cra_init,
+				.cra_module = THIS_MODULE,
+			},
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_hmac_sha1 = {
+	.type = EIP93_ALG_TYPE_HASH,
+	.flags = EIP93_HASH_HMAC | EIP93_HASH_SHA1,
+	.alg.ahash = {
+		.init = eip93_hash_init,
+		.update = eip93_hash_update,
+		.final = eip93_hash_final,
+		.finup = eip93_hash_finup,
+		.digest = eip93_hash_digest,
+		.setkey = eip93_hash_hmac_setkey,
+		.export = eip93_hash_export,
+		.import = eip93_hash_import,
+		.halg = {
+			.digestsize = SHA1_DIGEST_SIZE,
+			.statesize = sizeof(struct eip93_hash_export_state),
+			.base = {
+				.cra_name = "hmac(sha1)",
+				.cra_driver_name = "hmac(sha1-eip93)",
+				.cra_priority = 300,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+						CRYPTO_ALG_KERN_DRIVER_ONLY |
+						CRYPTO_ALG_ALLOCATES_MEMORY,
+				.cra_blocksize = SHA1_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct eip93_hash_ctx),
+				.cra_init = eip93_hash_cra_init,
+				.cra_module = THIS_MODULE,
+			},
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_hmac_sha224 = {
+	.type = EIP93_ALG_TYPE_HASH,
+	.flags = EIP93_HASH_HMAC | EIP93_HASH_SHA224,
+	.alg.ahash = {
+		.init = eip93_hash_init,
+		.update = eip93_hash_update,
+		.final = eip93_hash_final,
+		.finup = eip93_hash_finup,
+		.digest = eip93_hash_digest,
+		.setkey = eip93_hash_hmac_setkey,
+		.export = eip93_hash_export,
+		.import = eip93_hash_import,
+		.halg = {
+			.digestsize = SHA224_DIGEST_SIZE,
+			.statesize = sizeof(struct eip93_hash_export_state),
+			.base = {
+				.cra_name = "hmac(sha224)",
+				.cra_driver_name = "hmac(sha224-eip93)",
+				.cra_priority = 300,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+						CRYPTO_ALG_KERN_DRIVER_ONLY |
+						CRYPTO_ALG_ALLOCATES_MEMORY,
+				.cra_blocksize = SHA224_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct eip93_hash_ctx),
+				.cra_init = eip93_hash_cra_init,
+				.cra_module = THIS_MODULE,
+			},
+		},
+	},
+};
+
+struct eip93_alg_template eip93_alg_hmac_sha256 = {
+	.type = EIP93_ALG_TYPE_HASH,
+	.flags = EIP93_HASH_HMAC | EIP93_HASH_SHA256,
+	.alg.ahash = {
+		.init = eip93_hash_init,
+		.update = eip93_hash_update,
+		.final = eip93_hash_final,
+		.finup = eip93_hash_finup,
+		.digest = eip93_hash_digest,
+		.setkey = eip93_hash_hmac_setkey,
+		.export = eip93_hash_export,
+		.import = eip93_hash_import,
+		.halg = {
+			.digestsize = SHA256_DIGEST_SIZE,
+			.statesize = sizeof(struct eip93_hash_export_state),
+			.base = {
+				.cra_name = "hmac(sha256)",
+				.cra_driver_name = "hmac(sha256-eip93)",
+				.cra_priority = 300,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+						CRYPTO_ALG_KERN_DRIVER_ONLY |
+						CRYPTO_ALG_ALLOCATES_MEMORY,
+				.cra_blocksize = SHA256_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct eip93_hash_ctx),
+				.cra_init = eip93_hash_cra_init,
+				.cra_module = THIS_MODULE,
+			},
+		},
+	},
+};
diff --git a/drivers/crypto/inside-secure/eip93/eip93-hash.h b/drivers/crypto/inside-secure/eip93/eip93-hash.h
new file mode 100644
index 000000000000..9a3f14bfb46d
--- /dev/null
+++ b/drivers/crypto/inside-secure/eip93/eip93-hash.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2019 - 2021
+ *
+ * Richard van Schagen <vschagen@icloud.com>
+ * Christian Marangi <ansuelsmth@gmail.com
+ */
+#ifndef _EIP93_HASH_H_
+#define _EIP93_HASH_H_
+
+#include <crypto/sha2.h>
+
+#include "eip93-main.h"
+#include "eip93-regs.h"
+
+struct eip93_hash_ctx {
+	struct eip93_device	*mtk;
+	u32			flags;
+
+	u8			ipad[SHA256_BLOCK_SIZE] __aligned(sizeof(u32));
+	u8			opad[SHA256_DIGEST_SIZE] __aligned(sizeof(u32));
+};
+
+struct eip93_hash_reqctx {
+	/* Placement is important for DMA align */
+	struct {
+		struct sa_record	sa_record;
+		struct sa_record	sa_record_hmac;
+		struct sa_state		sa_state;
+	} __aligned(CRYPTO_DMA_ALIGN);
+
+	dma_addr_t		sa_record_base;
+	dma_addr_t		sa_record_hmac_base;
+	dma_addr_t		sa_state_base;
+
+	/* Don't enable HASH_FINALIZE when last block is sent */
+	bool			partial_hash;
+
+	/* Set to signal interrupt is for final packet */
+	bool			finalize;
+
+	/*
+	 * EIP93 requires data to be accumulated in block of 64 bytes
+	 * for intermediate hash calculation.
+	 */
+	u64			len;
+	u32			data_used;
+
+	u8			data[SHA256_BLOCK_SIZE] __aligned(sizeof(u32));
+	dma_addr_t		data_dma;
+
+	struct list_head	blocks;
+};
+
+struct mkt_hash_block {
+	struct list_head	list;
+	u8			data[SHA256_BLOCK_SIZE] __aligned(sizeof(u32));
+	dma_addr_t		data_dma;
+};
+
+struct eip93_hash_export_state {
+	u64			len;
+	u32			data_used;
+
+	u32			state_len[2];
+	u8			state_hash[SHA256_DIGEST_SIZE] __aligned(sizeof(u32));
+
+	u8			data[SHA256_BLOCK_SIZE] __aligned(sizeof(u32));
+};
+
+void eip93_hash_handle_result(struct crypto_async_request *async, int err);
+
+extern struct eip93_alg_template eip93_alg_md5;
+extern struct eip93_alg_template eip93_alg_sha1;
+extern struct eip93_alg_template eip93_alg_sha224;
+extern struct eip93_alg_template eip93_alg_sha256;
+extern struct eip93_alg_template eip93_alg_hmac_md5;
+extern struct eip93_alg_template eip93_alg_hmac_sha1;
+extern struct eip93_alg_template eip93_alg_hmac_sha224;
+extern struct eip93_alg_template eip93_alg_hmac_sha256;
+
+#endif /* _EIP93_HASH_H_ */
diff --git a/drivers/crypto/inside-secure/eip93/eip93-main.c b/drivers/crypto/inside-secure/eip93/eip93-main.c
new file mode 100644
index 000000000000..b324b17a3ea8
--- /dev/null
+++ b/drivers/crypto/inside-secure/eip93/eip93-main.c
@@ -0,0 +1,502 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 - 2021
+ *
+ * Richard van Schagen <vschagen@icloud.com>
+ * Christian Marangi <ansuelsmth@gmail.com
+ */
+
+#include <linux/atomic.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <crypto/aes.h>
+#include <crypto/ctr.h>
+
+#include "eip93-main.h"
+#include "eip93-regs.h"
+#include "eip93-common.h"
+#include "eip93-cipher.h"
+#include "eip93-aes.h"
+#include "eip93-des.h"
+#include "eip93-aead.h"
+#include "eip93-hash.h"
+
+static struct eip93_alg_template *eip93_algs[] = {
+	&eip93_alg_ecb_des,
+	&eip93_alg_cbc_des,
+	&eip93_alg_ecb_des3_ede,
+	&eip93_alg_cbc_des3_ede,
+	&eip93_alg_ecb_aes,
+	&eip93_alg_cbc_aes,
+	&eip93_alg_ctr_aes,
+	&eip93_alg_rfc3686_aes,
+	&eip93_alg_authenc_hmac_md5_cbc_des,
+	&eip93_alg_authenc_hmac_sha1_cbc_des,
+	&eip93_alg_authenc_hmac_sha224_cbc_des,
+	&eip93_alg_authenc_hmac_sha256_cbc_des,
+	&eip93_alg_authenc_hmac_md5_cbc_des3_ede,
+	&eip93_alg_authenc_hmac_sha1_cbc_des3_ede,
+	&eip93_alg_authenc_hmac_sha224_cbc_des3_ede,
+	&eip93_alg_authenc_hmac_sha256_cbc_des3_ede,
+	&eip93_alg_authenc_hmac_md5_cbc_aes,
+	&eip93_alg_authenc_hmac_sha1_cbc_aes,
+	&eip93_alg_authenc_hmac_sha224_cbc_aes,
+	&eip93_alg_authenc_hmac_sha256_cbc_aes,
+	&eip93_alg_authenc_hmac_md5_rfc3686_aes,
+	&eip93_alg_authenc_hmac_sha1_rfc3686_aes,
+	&eip93_alg_authenc_hmac_sha224_rfc3686_aes,
+	&eip93_alg_authenc_hmac_sha256_rfc3686_aes,
+	&eip93_alg_md5,
+	&eip93_alg_sha1,
+	&eip93_alg_sha224,
+	&eip93_alg_sha256,
+	&eip93_alg_hmac_md5,
+	&eip93_alg_hmac_sha1,
+	&eip93_alg_hmac_sha224,
+	&eip93_alg_hmac_sha256,
+};
+
+inline void eip93_irq_disable(struct eip93_device *mtk, u32 mask)
+{
+	__raw_writel(mask, mtk->base + EIP93_REG_MASK_DISABLE);
+}
+
+inline void eip93_irq_enable(struct eip93_device *mtk, u32 mask)
+{
+	__raw_writel(mask, mtk->base + EIP93_REG_MASK_ENABLE);
+}
+
+inline void eip93_irq_clear(struct eip93_device *mtk, u32 mask)
+{
+	__raw_writel(mask, mtk->base + EIP93_REG_INT_CLR);
+}
+
+static void eip93_unregister_algs(unsigned int i)
+{
+	unsigned int j;
+
+	for (j = 0; j < i; j++) {
+		switch (eip93_algs[j]->type) {
+		case EIP93_ALG_TYPE_SKCIPHER:
+			crypto_unregister_skcipher(&eip93_algs[j]->alg.skcipher);
+			break;
+		case EIP93_ALG_TYPE_AEAD:
+			crypto_unregister_aead(&eip93_algs[j]->alg.aead);
+			break;
+		case EIP93_ALG_TYPE_HASH:
+			crypto_unregister_ahash(&eip93_algs[i]->alg.ahash);
+			break;
+		}
+	}
+}
+
+static int eip93_register_algs(struct eip93_device *mtk, u32 supported_algo_flags)
+{
+	unsigned int i;
+	int ret = 0;
+
+	for (i = 0; i < ARRAY_SIZE(eip93_algs); i++) {
+		u32 alg_flags = eip93_algs[i]->flags;
+
+		eip93_algs[i]->mtk = mtk;
+
+		if ((IS_DES(alg_flags) || IS_3DES(alg_flags)) &&
+		    !(supported_algo_flags & EIP93_PE_OPTION_TDES))
+			continue;
+
+		if (IS_AES(alg_flags)) {
+			if (!(supported_algo_flags & EIP93_PE_OPTION_AES))
+				continue;
+
+			if (!IS_HMAC(alg_flags)) {
+				if (supported_algo_flags & EIP93_PE_OPTION_AES_KEY128)
+					eip93_algs[i]->alg.skcipher.max_keysize =
+						AES_KEYSIZE_128;
+
+				if (supported_algo_flags & EIP93_PE_OPTION_AES_KEY192)
+					eip93_algs[i]->alg.skcipher.max_keysize =
+						AES_KEYSIZE_192;
+
+				if (supported_algo_flags & EIP93_PE_OPTION_AES_KEY256)
+					eip93_algs[i]->alg.skcipher.max_keysize =
+						AES_KEYSIZE_256;
+
+				if (IS_RFC3686(alg_flags))
+					eip93_algs[i]->alg.skcipher.max_keysize +=
+						CTR_RFC3686_NONCE_SIZE;
+			}
+		}
+
+		if (IS_HASH_MD5(alg_flags) &&
+		    !(supported_algo_flags & EIP93_PE_OPTION_MD5))
+			continue;
+
+		if (IS_HASH_SHA1(alg_flags) &&
+		    !(supported_algo_flags & EIP93_PE_OPTION_SHA_1))
+			continue;
+
+		if (IS_HASH_SHA224(alg_flags) &&
+		    !(supported_algo_flags & EIP93_PE_OPTION_SHA_224))
+			continue;
+
+		if (IS_HASH_SHA256(alg_flags) &&
+		    !(supported_algo_flags & EIP93_PE_OPTION_SHA_256))
+			continue;
+
+		switch (eip93_algs[i]->type) {
+		case EIP93_ALG_TYPE_SKCIPHER:
+			ret = crypto_register_skcipher(&eip93_algs[i]->alg.skcipher);
+			break;
+		case EIP93_ALG_TYPE_AEAD:
+			ret = crypto_register_aead(&eip93_algs[i]->alg.aead);
+			break;
+		case EIP93_ALG_TYPE_HASH:
+			ret = crypto_register_ahash(&eip93_algs[i]->alg.ahash);
+			break;
+		}
+		if (ret)
+			goto fail;
+	}
+
+	return 0;
+
+fail:
+	eip93_unregister_algs(i);
+
+	return ret;
+}
+
+static void eip93_handle_result_descriptor(struct eip93_device *mtk)
+{
+	struct crypto_async_request *async;
+	struct eip93_descriptor *rdesc;
+	u16 desc_flags, crypto_idr;
+	bool last_entry;
+	int handled, left, err;
+	u32 pe_ctrl_stat;
+	u32 pe_length;
+
+get_more:
+	handled = 0;
+
+	left = readl(mtk->base + EIP93_REG_PE_RD_COUNT) & EIP93_PE_RD_COUNT;
+
+	if (!left) {
+		eip93_irq_clear(mtk, EIP93_INT_RDR_THRESH);
+		eip93_irq_enable(mtk, EIP93_INT_RDR_THRESH);
+		return;
+	}
+
+	last_entry = false;
+
+	while (left) {
+		rdesc = eip93_get_descriptor(mtk);
+		if (IS_ERR(rdesc)) {
+			dev_err(mtk->dev, "Ndesc: %d nreq: %d\n",
+				handled, left);
+			err = -EIO;
+			break;
+		}
+		/* make sure DMA is finished writing */
+		do {
+			pe_ctrl_stat = READ_ONCE(rdesc->pe_ctrl_stat_word);
+			pe_length = READ_ONCE(rdesc->pe_length_word);
+		} while (FIELD_GET(EIP93_PE_CTRL_PE_READY_DES_TRING_OWN, pe_ctrl_stat) !=
+			 EIP93_PE_CTRL_PE_READY ||
+			 FIELD_GET(EIP93_PE_LENGTH_HOST_PE_READY, pe_length) !=
+			 EIP93_PE_LENGTH_PE_READY);
+
+		err = rdesc->pe_ctrl_stat_word & (EIP93_PE_CTRL_PE_EXT_ERR_CODE |
+						  EIP93_PE_CTRL_PE_EXT_ERR |
+						  EIP93_PE_CTRL_PE_SEQNUM_ERR |
+						  EIP93_PE_CTRL_PE_PAD_ERR |
+						  EIP93_PE_CTRL_PE_AUTH_ERR);
+
+		desc_flags = FIELD_GET(EIP93_PE_USER_ID_DESC_FLAGS, rdesc->user_id);
+		crypto_idr = FIELD_GET(EIP93_PE_USER_ID_CRYPTO_IDR, rdesc->user_id);
+
+		writel(1, mtk->base + EIP93_REG_PE_RD_COUNT);
+		eip93_irq_clear(mtk, EIP93_INT_RDR_THRESH);
+
+		handled++;
+		left--;
+
+		if (desc_flags & EIP93_DESC_LAST) {
+			last_entry = true;
+			break;
+		}
+	}
+
+	if (!last_entry)
+		goto get_more;
+
+	/* Get crypto async ref only for last descriptor */
+	scoped_guard(spinlock_bh, &mtk->ring->idr_lock) {
+		async = idr_find(&mtk->ring->crypto_async_idr, crypto_idr);
+		idr_remove(&mtk->ring->crypto_async_idr, crypto_idr);
+	}
+
+	/* Parse error in ctrl stat word */
+	err = eip93_parse_ctrl_stat_err(mtk, err);
+
+	if (desc_flags & EIP93_DESC_SKCIPHER)
+		eip93_skcipher_handle_result(async, err);
+
+	if (desc_flags & EIP93_DESC_AEAD)
+		eip93_aead_handle_result(async, err);
+
+	if (desc_flags & EIP93_DESC_HASH)
+		eip93_hash_handle_result(async, err);
+
+	goto get_more;
+}
+
+static void eip93_done_task(unsigned long data)
+{
+	struct eip93_device *mtk = (struct eip93_device *)data;
+
+	eip93_handle_result_descriptor(mtk);
+}
+
+static irqreturn_t eip93_irq_handler(int irq, void *data)
+{
+	struct eip93_device *mtk = data;
+	u32 irq_status;
+
+	irq_status = readl(mtk->base + EIP93_REG_INT_MASK_STAT);
+	if (FIELD_GET(EIP93_INT_RDR_THRESH, irq_status)) {
+		eip93_irq_disable(mtk, EIP93_INT_RDR_THRESH);
+		tasklet_schedule(&mtk->ring->done_task);
+		return IRQ_HANDLED;
+	}
+
+	/* Ignore errors in AUTO mode, handled by the RDR */
+	eip93_irq_clear(mtk, irq_status);
+	if (irq_status)
+		eip93_irq_disable(mtk, irq_status);
+
+	return IRQ_NONE;
+}
+
+static void eip93_initialize(struct eip93_device *mtk, u32 supported_algo_flags)
+{
+	u32 val;
+
+	/* Reset PE and rings */
+	val = EIP93_PE_CONFIG_RST_PE | EIP93_PE_CONFIG_RST_RING;
+	val |= EIP93_PE_TARGET_AUTO_RING_MODE;
+	/* For Auto more, update the CDR ring owner after processing */
+	val |= EIP93_PE_CONFIG_EN_CDR_UPDATE;
+	writel(val, mtk->base + EIP93_REG_PE_CONFIG);
+
+	/* Wait for PE and ring to reset */
+	usleep_range(10, 20);
+
+	/* Release PE and ring reset */
+	val = readl(mtk->base + EIP93_REG_PE_CONFIG);
+	val &= ~(EIP93_PE_CONFIG_RST_PE | EIP93_PE_CONFIG_RST_RING);
+	writel(val, mtk->base + EIP93_REG_PE_CONFIG);
+
+	/* Config Clocks */
+	val = EIP93_PE_CLOCK_EN_PE_CLK;
+	if (supported_algo_flags & EIP93_PE_OPTION_TDES)
+		val |= EIP93_PE_CLOCK_EN_DES_CLK;
+	if (supported_algo_flags & EIP93_PE_OPTION_AES)
+		val |= EIP93_PE_CLOCK_EN_AES_CLK;
+	if (supported_algo_flags &
+	    (EIP93_PE_OPTION_MD5 | EIP93_PE_OPTION_SHA_1 | EIP93_PE_OPTION_SHA_224 |
+	     EIP93_PE_OPTION_SHA_256))
+		val |= EIP93_PE_CLOCK_EN_HASH_CLK;
+	writel(val, mtk->base + EIP93_REG_PE_CLOCK_CTRL);
+
+	/* Config DMA thresholds */
+	val = FIELD_PREP(EIP93_PE_OUTBUF_THRESH, 128) |
+	      FIELD_PREP(EIP93_PE_INBUF_THRESH, 128);
+	writel(val, mtk->base + EIP93_REG_PE_BUF_THRESH);
+
+	/* Clear/ack all interrupts before disable all */
+	eip93_irq_clear(mtk, EIP93_INT_ALL);
+	eip93_irq_disable(mtk, EIP93_INT_ALL);
+
+	/* Setup CRD threshold to trigger interrupt */
+	val = FIELD_PREP(EIPR93_PE_CDR_THRESH, EIP93_RING_NUM - EIP93_RING_BUSY);
+	/*
+	 * Configure RDR interrupt to be triggered if RD counter is not 0
+	 * for more than 2^(N+10) system clocks.
+	 */
+	val |= FIELD_PREP(EIPR93_PE_RD_TIMEOUT, 5) | EIPR93_PE_TIMEROUT_EN;
+	writel(val, mtk->base + EIP93_REG_PE_RING_THRESH);
+}
+
+static void eip93_desc_free(struct eip93_device *mtk)
+{
+	writel(0, mtk->base + EIP93_REG_PE_RING_CONFIG);
+	writel(0, mtk->base + EIP93_REG_PE_CDR_BASE);
+	writel(0, mtk->base + EIP93_REG_PE_RDR_BASE);
+}
+
+static int eip93_set_ring(struct eip93_device *mtk, struct eip93_desc_ring *ring)
+{
+	ring->offset = sizeof(struct eip93_descriptor);
+	ring->base = dmam_alloc_coherent(mtk->dev,
+					 sizeof(struct eip93_descriptor) * EIP93_RING_NUM,
+					 &ring->base_dma, GFP_KERNEL);
+	if (!ring->base)
+		return -ENOMEM;
+
+	ring->write = ring->base;
+	ring->base_end = ring->base + sizeof(struct eip93_descriptor) * (EIP93_RING_NUM - 1);
+	ring->read  = ring->base;
+
+	return 0;
+}
+
+static int eip93_desc_init(struct eip93_device *mtk)
+{
+	struct eip93_desc_ring *cdr = &mtk->ring->cdr;
+	struct eip93_desc_ring *rdr = &mtk->ring->rdr;
+	int ret;
+	u32 val;
+
+	ret = eip93_set_ring(mtk, cdr);
+	if (ret)
+		return ret;
+
+	ret = eip93_set_ring(mtk, rdr);
+	if (ret)
+		return ret;
+
+	writel((u32 __force)cdr->base_dma, mtk->base + EIP93_REG_PE_CDR_BASE);
+	writel((u32 __force)rdr->base_dma, mtk->base + EIP93_REG_PE_RDR_BASE);
+
+	val = FIELD_PREP(EIP93_PE_RING_SIZE, EIP93_RING_NUM - 1);
+	writel(val, mtk->base + EIP93_REG_PE_RING_CONFIG);
+
+	atomic_set(&mtk->ring->free, EIP93_RING_NUM - 1);
+
+	return 0;
+}
+
+static void eip93_cleanup(struct eip93_device *mtk)
+{
+	tasklet_kill(&mtk->ring->done_task);
+
+	/* Clear/ack all interrupts before disable all */
+	eip93_irq_clear(mtk, EIP93_INT_ALL);
+	eip93_irq_disable(mtk, EIP93_INT_ALL);
+
+	writel(0, mtk->base + EIP93_REG_PE_CLOCK_CTRL);
+
+	eip93_desc_free(mtk);
+
+	idr_destroy(&mtk->ring->crypto_async_idr);
+}
+
+static int eip93_crypto_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct eip93_device *mtk;
+	u32 ver, algo_flags;
+	int ret;
+
+	mtk = devm_kzalloc(dev, sizeof(*mtk), GFP_KERNEL);
+	if (!mtk)
+		return -ENOMEM;
+
+	mtk->dev = dev;
+	platform_set_drvdata(pdev, mtk);
+
+	mtk->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mtk->base))
+		return PTR_ERR(mtk->base);
+
+	mtk->irq = platform_get_irq(pdev, 0);
+	if (mtk->irq < 0)
+		return mtk->irq;
+
+	ret = devm_request_threaded_irq(mtk->dev, mtk->irq, eip93_irq_handler,
+					NULL, IRQF_ONESHOT,
+					dev_name(mtk->dev), mtk);
+
+	mtk->ring = devm_kcalloc(mtk->dev, 1, sizeof(*mtk->ring), GFP_KERNEL);
+	if (!mtk->ring)
+		return -ENOMEM;
+
+	ret = eip93_desc_init(mtk);
+
+	if (ret)
+		return ret;
+
+	tasklet_init(&mtk->ring->done_task, eip93_done_task, (unsigned long)mtk);
+
+	spin_lock_init(&mtk->ring->read_lock);
+	spin_lock_init(&mtk->ring->write_lock);
+
+	spin_lock_init(&mtk->ring->idr_lock);
+	idr_init(&mtk->ring->crypto_async_idr);
+
+	algo_flags = readl(mtk->base + EIP93_REG_PE_OPTION_1);
+
+	eip93_initialize(mtk, algo_flags);
+
+	/* Init finished, enable RDR interrupt */
+	eip93_irq_enable(mtk, EIP93_INT_RDR_THRESH);
+
+	ret = eip93_register_algs(mtk, algo_flags);
+	if (ret) {
+		eip93_cleanup(mtk);
+		return ret;
+	}
+
+	ver = readl(mtk->base + EIP93_REG_PE_REVISION);
+	/* EIP_EIP_NO:MAJOR_HW_REV:MINOR_HW_REV:HW_PATCH,PE(ALGO_FLAGS) */
+	dev_info(mtk->dev, "EIP%lu:%lx:%lx:%lx,PE(0x%x:0x%x)\n",
+		 FIELD_GET(EIP93_PE_REVISION_EIP_NO, ver),
+		 FIELD_GET(EIP93_PE_REVISION_MAJ_HW_REV, ver),
+		 FIELD_GET(EIP93_PE_REVISION_MIN_HW_REV, ver),
+		 FIELD_GET(EIP93_PE_REVISION_HW_PATCH, ver),
+		 algo_flags,
+		 readl(mtk->base + EIP93_REG_PE_OPTION_0));
+
+	return 0;
+}
+
+static void eip93_crypto_remove(struct platform_device *pdev)
+{
+	struct eip93_device *mtk = platform_get_drvdata(pdev);
+
+	eip93_unregister_algs(ARRAY_SIZE(eip93_algs));
+	eip93_cleanup(mtk);
+}
+
+static const struct of_device_id eip93_crypto_of_match[] = {
+	{ .compatible = "inside-secure,safexcel-eip93i", },
+	{ .compatible = "inside-secure,safexcel-eip93ie", },
+	{ .compatible = "inside-secure,safexcel-eip93is", },
+	{ .compatible = "inside-secure,safexcel-eip93ies", },
+	/* IW not supported currently, missing AES-XCB-MAC/AES-CCM */
+	/* { .compatible = "inside-secure,safexcel-eip93iw", }, */
+	{}
+};
+MODULE_DEVICE_TABLE(of, eip93_crypto_of_match);
+
+static struct platform_driver eip93_crypto_driver = {
+	.probe = eip93_crypto_probe,
+	.remove = eip93_crypto_remove,
+	.driver = {
+		.name = "mtk-eip93",
+		.of_match_table = eip93_crypto_of_match,
+	},
+};
+module_platform_driver(eip93_crypto_driver);
+
+MODULE_AUTHOR("Richard van Schagen <vschagen@cs.com>");
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_DESCRIPTION("Mediatek EIP-93 crypto engine driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/crypto/inside-secure/eip93/eip93-main.h b/drivers/crypto/inside-secure/eip93/eip93-main.h
new file mode 100644
index 000000000000..c7a7ed8d89cc
--- /dev/null
+++ b/drivers/crypto/inside-secure/eip93/eip93-main.h
@@ -0,0 +1,152 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2019 - 2021
+ *
+ * Richard van Schagen <vschagen@icloud.com>
+ * Christian Marangi <ansuelsmth@gmail.com
+ */
+#ifndef _EIP93_MAIN_H_
+#define _EIP93_MAIN_H_
+
+#include <crypto/internal/aead.h>
+#include <crypto/internal/hash.h>
+#include <crypto/internal/skcipher.h>
+#include <linux/bitfield.h>
+#include <linux/interrupt.h>
+
+#define EIP93_RING_BUSY_DELAY		500
+
+#define EIP93_RING_NUM			512
+#define EIP93_RING_BUSY			32
+#define EIP93_CRA_PRIORITY		1500
+
+#define EIP93_RING_SA_STATE_ADDR(base, idx)	((base) + (idx))
+#define EIP93_RING_SA_STATE_DMA(dma_base, idx)	((u32 __force)(dma_base) + \
+						 ((idx) * sizeof(struct sa_state)))
+
+/* cipher algorithms */
+#define EIP93_ALG_DES			BIT(0)
+#define EIP93_ALG_3DES			BIT(1)
+#define EIP93_ALG_AES			BIT(2)
+#define EIP93_ALG_MASK			GENMASK(2, 0)
+/* hash and hmac algorithms */
+#define EIP93_HASH_MD5			BIT(3)
+#define EIP93_HASH_SHA1			BIT(4)
+#define EIP93_HASH_SHA224			BIT(5)
+#define EIP93_HASH_SHA256			BIT(6)
+#define EIP93_HASH_HMAC			BIT(7)
+#define EIP93_HASH_MASK			GENMASK(6, 3)
+/* cipher modes */
+#define EIP93_MODE_CBC			BIT(8)
+#define EIP93_MODE_ECB			BIT(9)
+#define EIP93_MODE_CTR			BIT(10)
+#define EIP93_MODE_RFC3686		BIT(11)
+#define EIP93_MODE_MASK			GENMASK(10, 8)
+
+/* cipher encryption/decryption operations */
+#define EIP93_ENCRYPT			BIT(12)
+#define EIP93_DECRYPT			BIT(13)
+
+#define EIP93_BUSY			BIT(14)
+
+/* descriptor flags */
+#define EIP93_DESC_DMA_IV			BIT(0)
+#define EIP93_DESC_IPSEC			BIT(1)
+#define EIP93_DESC_FINISH			BIT(2)
+#define EIP93_DESC_LAST			BIT(3)
+#define EIP93_DESC_FAKE_HMAC		BIT(4)
+#define EIP93_DESC_PRNG			BIT(5)
+#define EIP93_DESC_HASH			BIT(6)
+#define EIP93_DESC_AEAD			BIT(7)
+#define EIP93_DESC_SKCIPHER		BIT(8)
+#define EIP93_DESC_ASYNC			BIT(9)
+
+#define IS_DMA_IV(desc_flags)		((desc_flags) & EIP93_DESC_DMA_IV)
+
+#define IS_DES(flags)			((flags) & EIP93_ALG_DES)
+#define IS_3DES(flags)			((flags) & EIP93_ALG_3DES)
+#define IS_AES(flags)			((flags) & EIP93_ALG_AES)
+
+#define IS_HASH_MD5(flags)		((flags) & EIP93_HASH_MD5)
+#define IS_HASH_SHA1(flags)		((flags) & EIP93_HASH_SHA1)
+#define IS_HASH_SHA224(flags)		((flags) & EIP93_HASH_SHA224)
+#define IS_HASH_SHA256(flags)		((flags) & EIP93_HASH_SHA256)
+#define IS_HMAC(flags)			((flags) & EIP93_HASH_HMAC)
+
+#define IS_CBC(mode)			((mode) & EIP93_MODE_CBC)
+#define IS_ECB(mode)			((mode) & EIP93_MODE_ECB)
+#define IS_CTR(mode)			((mode) & EIP93_MODE_CTR)
+#define IS_RFC3686(mode)		((mode) & EIP93_MODE_RFC3686)
+
+#define IS_BUSY(flags)			((flags) & EIP93_BUSY)
+
+#define IS_ENCRYPT(dir)			((dir) & EIP93_ENCRYPT)
+#define IS_DECRYPT(dir)			((dir) & EIP93_DECRYPT)
+
+#define IS_CIPHER(flags)		((flags) & (EIP93_ALG_DES | \
+						    EIP93_ALG_3DES |  \
+						    EIP93_ALG_AES))
+
+#define IS_HASH(flags)			((flags) & (EIP93_HASH_MD5 |  \
+						    EIP93_HASH_SHA1 |   \
+						    EIP93_HASH_SHA224 | \
+						    EIP93_HASH_SHA256))
+
+/**
+ * struct eip93_device - crypto engine device structure
+ */
+struct eip93_device {
+	void __iomem		*base;
+	struct device		*dev;
+	struct clk		*clk;
+	int			irq;
+	struct eip93_ring		*ring;
+};
+
+struct eip93_desc_ring {
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
+struct eip93_state_pool {
+	void			*base;
+	dma_addr_t		base_dma;
+};
+
+struct eip93_ring {
+	struct tasklet_struct		done_task;
+	/* command/result rings */
+	struct eip93_desc_ring		cdr;
+	struct eip93_desc_ring		rdr;
+	spinlock_t			write_lock;
+	spinlock_t			read_lock;
+	atomic_t			free;
+	/* aync idr */
+	spinlock_t			idr_lock;
+	struct idr			crypto_async_idr;
+};
+
+enum eip93_alg_type {
+	EIP93_ALG_TYPE_AEAD,
+	EIP93_ALG_TYPE_SKCIPHER,
+	EIP93_ALG_TYPE_HASH,
+};
+
+struct eip93_alg_template {
+	struct eip93_device	*mtk;
+	enum eip93_alg_type	type;
+	u32			flags;
+	union {
+		struct aead_alg		aead;
+		struct skcipher_alg	skcipher;
+		struct ahash_alg	ahash;
+	} alg;
+};
+
+#endif /* _EIP93_MAIN_H_ */
diff --git a/drivers/crypto/inside-secure/eip93/eip93-regs.h b/drivers/crypto/inside-secure/eip93/eip93-regs.h
new file mode 100644
index 000000000000..0490b8d15131
--- /dev/null
+++ b/drivers/crypto/inside-secure/eip93/eip93-regs.h
@@ -0,0 +1,335 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 - 2021
+ *
+ * Richard van Schagen <vschagen@icloud.com>
+ * Christian Marangi <ansuelsmth@gmail.com
+ */
+#ifndef REG_EIP93_H
+#define REG_EIP93_H
+
+#define EIP93_REG_PE_CTRL_STAT			0x0
+#define   EIP93_PE_CTRL_PE_PAD_CTRL_STAT	GENMASK(31, 24)
+#define   EIP93_PE_CTRL_PE_EXT_ERR_CODE		GENMASK(23, 20)
+#define   EIP93_PE_CTRL_PE_EXT_ERR_PROCESSING	0x8
+#define   EIP93_PE_CTRL_PE_EXT_ERR_BLOCK_SIZE_ERR 0x7
+#define   EIP93_PE_CTRL_PE_EXT_ERR_INVALID_PK_LENGTH 0x6
+#define   EIP93_PE_CTRL_PE_EXT_ERR_ZERO_LENGTH	0x5
+#define   EIP93_PE_CTRL_PE_EXT_ERR_SPI		0x4
+#define   EIP93_PE_CTRL_PE_EXT_ERR_INVALID_CRYPTO_ALGO 0x3
+#define   EIP93_PE_CTRL_PE_EXT_ERR_INVALID_CRYPTO_OP 0x2
+#define   EIP93_PE_CTRL_PE_EXT_ERR_DESC_OWNER	0x1
+#define   EIP93_PE_CTRL_PE_EXT_ERR_BUS		0x0
+#define   EIP93_PE_CTRL_PE_EXT_ERR		BIT(19)
+#define   EIP93_PE_CTRL_PE_SEQNUM_ERR		BIT(18)
+#define   EIP93_PE_CTRL_PE_PAD_ERR		BIT(17)
+#define   EIP93_PE_CTRL_PE_AUTH_ERR		BIT(16)
+#define   EIP93_PE_CTRL_PE_PAD_VALUE		GENMASK(15, 8)
+#define   EIP93_PE_CTRL_PE_PRNG_MODE		GENMASK(7, 6)
+#define   EIP93_PE_CTRL_PE_HASH_FINAL		BIT(4)
+#define   EIP93_PE_CTRL_PE_INIT_ARC4		BIT(3)
+#define   EIP93_PE_CTRL_PE_READY_DES_TRING_OWN	GENMASK(1, 0)
+#define   EIP93_PE_CTRL_PE_READY		0x2
+#define   EIP93_PE_CTRL_HOST_READY		0x1
+#define EIP93_REG_PE_SOURCE_ADDR		0x4
+#define EIP93_REG_PE_DEST_ADDR			0x8
+#define EIP93_REG_PE_SA_ADDR			0xc
+#define EIP93_REG_PE_ADDR			0x10 /* STATE_ADDR */
+/*
+ * Special implementation for user ID
+ * user_id in eip93_descriptor is used to identify the
+ * descriptor and is opaque and can be used by the driver
+ * in custom way.
+ *
+ * The usage of this should be to put an address to the crypto
+ * request struct from the kernel but this can't work in 64bit
+ * world.
+ *
+ * Also it's required to put some flags to identify the last
+ * descriptor.
+ *
+ * To handle this, split the u32 in 2 part:
+ * - 31:16 descriptor flags
+ * - 15:0 IDR to connect the crypto request address
+ */
+#define EIP93_REG_PE_USER_ID			0x18
+#define   EIP93_PE_USER_ID_DESC_FLAGS		GENMASK(31, 16)
+#define   EIP93_PE_USER_ID_CRYPTO_IDR		GENMASK(15, 0)
+#define EIP93_REG_PE_LENGTH			0x1c
+#define   EIP93_PE_LENGTH_BYPASS		GENMASK(31, 24)
+#define   EIP93_PE_LENGTH_HOST_PE_READY		GENMASK(23, 22)
+#define   EIP93_PE_LENGTH_PE_READY		0x2
+#define   EIP93_PE_LENGTH_HOST_READY		0x1
+#define   EIP93_PE_LENGTH_LENGTH		GENMASK(19, 0)
+
+/* PACKET ENGINE RING configuration registers */
+#define EIP93_REG_PE_CDR_BASE			0x80
+#define EIP93_REG_PE_RDR_BASE			0x84
+#define EIP93_REG_PE_RING_CONFIG		0x88
+#define   EIP93_PE_EN_EXT_TRIG			BIT(31)
+/* Absent in later revision of eip93 */
+/* #define   EIP93_PE_RING_OFFSET		GENMASK(23, 15) */
+#define   EIP93_PE_RING_SIZE			GENMASK(9, 0)
+#define EIP93_REG_PE_RING_THRESH		0x8c
+#define   EIPR93_PE_TIMEROUT_EN			BIT(31)
+#define   EIPR93_PE_RD_TIMEOUT			GENMASK(29, 26)
+#define   EIPR93_PE_RDR_THRESH			GENMASK(25, 16)
+#define   EIPR93_PE_CDR_THRESH			GENMASK(9, 0)
+#define EIP93_REG_PE_CD_COUNT			0x90
+#define   EIP93_PE_CD_COUNT			GENMASK(10, 0)
+/*
+ * In the same register, writing a value in GENMASK(7, 0) will
+ * increment the descriptor count and start DMA action.
+ */
+#define   EIP93_PE_CD_COUNT_INCR		GENMASK(7, 0)
+#define EIP93_REG_PE_RD_COUNT			0x94
+#define   EIP93_PE_RD_COUNT			GENMASK(10, 0)
+/*
+ * In the same register, writing a value in GENMASK(7, 0) will
+ * increment the descriptor count and start DMA action.
+ */
+#define   EIP93_PE_RD_COUNT_INCR		GENMASK(7, 0)
+#define EIP93_REG_PE_RING_RW_PNTR		0x98 /* RING_PNTR */
+
+/* PACKET ENGINE  configuration registers */
+#define EIP93_REG_PE_CONFIG			0x100
+#define   EIP93_PE_CONFIG_SWAP_TARGET		BIT(20)
+#define   EIP93_PE_CONFIG_SWAP_DATA		BIT(18)
+#define   EIP93_PE_CONFIG_SWAP_SA		BIT(17)
+#define   EIP93_PE_CONFIG_SWAP_CDRD		BIT(16)
+#define   EIP93_PE_CONFIG_EN_CDR_UPDATE		BIT(10)
+#define   EIP93_PE_CONFIG_PE_MODE		GENMASK(9, 8)
+#define   EIP93_PE_TARGET_AUTO_RING_MODE	FIELD_PREP(EIP93_PE_CONFIG_PE_MODE, 0x3)
+#define   EIP93_PE_TARGET_COMMAND_NO_RDR_MODE	FIELD_PREP(EIP93_PE_CONFIG_PE_MODE, 0x2)
+#define   EIP93_PE_TARGET_COMMAND_WITH_RDR_MODE	FIELD_PREP(EIP93_PE_CONFIG_PE_MODE, 0x1)
+#define   EIP93_PE_DIRECT_HOST_MODE		FIELD_PREP(EIP93_PE_CONFIG_PE_MODE, 0x0)
+#define   EIP93_PE_CONFIG_RST_RING		BIT(2)
+#define   EIP93_PE_CONFIG_RST_PE		BIT(0)
+#define EIP93_REG_PE_STATUS			0x104
+#define EIP93_REG_PE_BUF_THRESH			0x10c
+#define   EIP93_PE_OUTBUF_THRESH		GENMASK(23, 16)
+#define   EIP93_PE_INBUF_THRESH			GENMASK(7, 0)
+#define EIP93_REG_PE_INBUF_COUNT		0x100
+#define EIP93_REG_PE_OUTBUF_COUNT		0x114
+#define EIP93_REG_PE_BUF_RW_PNTR		0x118 /* BUF_PNTR */
+
+/* PACKET ENGINE endian config */
+#define EIP93_REG_PE_ENDIAN_CONFIG		0x1cc
+#define EIP93_AIROHA_REG_PE_ENDIAN_CONFIG	0x1d0
+#define   EIP93_PE_ENDIAN_TARGET_BYTE_SWAP	GENMASK(23, 16)
+#define   EIP93_PE_ENDIAN_MASTER_BYTE_SWAP	GENMASK(7, 0)
+/*
+ * Byte goes 2 and 2 and are referenced by ID
+ * Split GENMASK(7, 0) in 4 part, one for each byte.
+ * Example LITTLE ENDIAN: Example BIG ENDIAN
+ * GENMASK(7, 6) 0x3	  GENMASK(7, 6) 0x0
+ * GENMASK(5, 4) 0x2	  GENMASK(7, 6) 0x1
+ * GENMASK(3, 2) 0x1	  GENMASK(3, 2) 0x2
+ * GENMASK(1, 0) 0x0	  GENMASK(1, 0) 0x3
+ */
+#define   EIP93_PE_ENDIAN_BYTE0			0x0
+#define   EIP93_PE_ENDIAN_BYTE1			0x1
+#define   EIP93_PE_ENDIAN_BYTE2			0x2
+#define   EIP93_PE_ENDIAN_BYTE3			0x3
+
+/* EIP93 CLOCK control registers */
+#define EIP93_REG_PE_CLOCK_CTRL			0x1e8
+#define   EIP93_PE_CLOCK_EN_HASH_CLK		BIT(4)
+#define   EIP93_PE_CLOCK_EN_ARC4_CLK		BIT(3)
+#define   EIP93_PE_CLOCK_EN_AES_CLK		BIT(2)
+#define   EIP93_PE_CLOCK_EN_DES_CLK		BIT(1)
+#define   EIP93_PE_CLOCK_EN_PE_CLK		BIT(0)
+
+/* EIP93 Device Option and Revision Register */
+#define EIP93_REG_PE_OPTION_1			0x1f4
+#define   EIP93_PE_OPTION_MAC_KEY256		BIT(31)
+#define   EIP93_PE_OPTION_MAC_KEY192		BIT(30)
+#define   EIP93_PE_OPTION_MAC_KEY128		BIT(29)
+#define   EIP93_PE_OPTION_AES_CBC_MAC		BIT(28)
+#define   EIP93_PE_OPTION_AES_XCBX		BIT(23)
+#define   EIP93_PE_OPTION_SHA_256		BIT(19)
+#define   EIP93_PE_OPTION_SHA_224		BIT(18)
+#define   EIP93_PE_OPTION_SHA_1			BIT(17)
+#define   EIP93_PE_OPTION_MD5			BIT(16)
+#define   EIP93_PE_OPTION_AES_KEY256		BIT(15)
+#define   EIP93_PE_OPTION_AES_KEY192		BIT(14)
+#define   EIP93_PE_OPTION_AES_KEY128		BIT(13)
+#define   EIP93_PE_OPTION_AES			BIT(2)
+#define   EIP93_PE_OPTION_ARC4			BIT(1)
+#define   EIP93_PE_OPTION_TDES			BIT(0) /* DES and TDES */
+#define EIP93_REG_PE_OPTION_0			0x1f8
+#define EIP93_REG_PE_REVISION			0x1fc
+#define   EIP93_PE_REVISION_MAJ_HW_REV		GENMASK(27, 24)
+#define   EIP93_PE_REVISION_MIN_HW_REV		GENMASK(23, 20)
+#define   EIP93_PE_REVISION_HW_PATCH		GENMASK(19, 16)
+#define   EIP93_PE_REVISION_EIP_NO		GENMASK(7, 0)
+
+/* EIP93 Interrupt Control Register */
+#define EIP93_REG_INT_UNMASK_STAT		0x200
+#define EIP93_REG_INT_MASK_STAT			0x204
+#define EIP93_REG_INT_CLR			0x204
+#define EIP93_REG_INT_MASK			0x208 /* INT_EN */
+/* Each int reg have the same bitmap */
+#define   EIP93_INT_INTERFACE_ERR		BIT(18)
+#define   EIP93_INT_RPOC_ERR			BIT(17)
+#define   EIP93_INT_PE_RING_ERR			BIT(16)
+#define   EIP93_INT_HALT			BIT(15)
+#define   EIP93_INT_OUTBUF_THRESH		BIT(11)
+#define   EIP93_INT_INBUF_THRESH		BIT(10)
+#define   EIP93_INT_OPERATION_DONE		BIT(9)
+#define   EIP93_INT_RDR_THRESH			BIT(1)
+#define   EIP93_INT_CDR_THRESH			BIT(0)
+#define   EIP93_INT_ALL				(EIP93_INT_INTERFACE_ERR | \
+						 EIP93_INT_RPOC_ERR | \
+						 EIP93_INT_PE_RING_ERR | \
+						 EIP93_INT_HALT | \
+						 EIP93_INT_OUTBUF_THRESH | \
+						 EIP93_INT_INBUF_THRESH | \
+						 EIP93_INT_OPERATION_DONE | \
+						 EIP93_INT_RDR_THRESH | \
+						 EIP93_INT_CDR_THRESH)
+
+#define EIP93_REG_INT_CFG			0x20c
+#define   EIP93_INT_TYPE_PULSE			BIT(0)
+#define EIP93_REG_MASK_ENABLE			0x210
+#define EIP93_REG_MASK_DISABLE			0x214
+
+/* EIP93 SA Record register */
+#define EIP93_REG_SA_CMD_0			0x400
+#define   EIP93_SA_CMD_SAVE_HASH		BIT(29)
+#define   EIP93_SA_CMD_SAVE_IV			BIT(28)
+#define   EIP93_SA_CMD_HASH_SOURCE		GENMASK(27, 26)
+#define   EIP93_SA_CMD_HASH_NO_LOAD		FIELD_PREP(EIP93_SA_CMD_HASH_SOURCE, 0x3)
+#define   EIP93_SA_CMD_HASH_FROM_STATE		FIELD_PREP(EIP93_SA_CMD_HASH_SOURCE, 0x2)
+#define   EIP93_SA_CMD_HASH_FROM_SA		FIELD_PREP(EIP93_SA_CMD_HASH_SOURCE, 0x0)
+#define   EIP93_SA_CMD_IV_SOURCE		GENMASK(25, 24)
+#define   EIP93_SA_CMD_IV_FROM_PRNG		FIELD_PREP(EIP93_SA_CMD_IV_SOURCE, 0x3)
+#define   EIP93_SA_CMD_IV_FROM_STATE		FIELD_PREP(EIP93_SA_CMD_IV_SOURCE, 0x2)
+#define   EIP93_SA_CMD_IV_FROM_INPUT		FIELD_PREP(EIP93_SA_CMD_IV_SOURCE, 0x1)
+#define   EIP93_SA_CMD_IV_NO_LOAD		FIELD_PREP(EIP93_SA_CMD_IV_SOURCE, 0x0)
+#define   EIP93_SA_CMD_DIGEST_LENGTH		GENMASK(23, 20)
+#define   EIP93_SA_CMD_DIGEST_10WORD		FIELD_PREP(EIP93_SA_CMD_DIGEST_LENGTH, 0xa) /* SRTP and TLS */
+#define   EIP93_SA_CMD_DIGEST_8WORD		FIELD_PREP(EIP93_SA_CMD_DIGEST_LENGTH, 0x8) /* SHA-256 */
+#define   EIP93_SA_CMD_DIGEST_7WORD		FIELD_PREP(EIP93_SA_CMD_DIGEST_LENGTH, 0x7) /* SHA-224 */
+#define   EIP93_SA_CMD_DIGEST_6WORD		FIELD_PREP(EIP93_SA_CMD_DIGEST_LENGTH, 0x6)
+#define   EIP93_SA_CMD_DIGEST_5WORD		FIELD_PREP(EIP93_SA_CMD_DIGEST_LENGTH, 0x5) /* SHA1 */
+#define   EIP93_SA_CMD_DIGEST_4WORD		FIELD_PREP(EIP93_SA_CMD_DIGEST_LENGTH, 0x4) /* MD5 and AES-based */
+#define   EIP93_SA_CMD_DIGEST_3WORD_IPSEC	FIELD_PREP(EIP93_SA_CMD_DIGEST_LENGTH, 0x3) /* IPSEC */
+#define   EIP93_SA_CMD_DIGEST_2WORD		FIELD_PREP(EIP93_SA_CMD_DIGEST_LENGTH, 0x2)
+#define   EIP93_SA_CMD_DIGEST_1WORD		FIELD_PREP(EIP93_SA_CMD_DIGEST_LENGTH, 0x1)
+#define   EIP93_SA_CMD_DIGEST_3WORD		FIELD_PREP(EIP93_SA_CMD_DIGEST_LENGTH, 0x0) /* 96bit output */
+#define   EIP93_SA_CMD_HDR_PROC			BIT(19)
+#define   EIP93_SA_CMD_EXT_PAD			BIT(18)
+#define   EIP93_SA_CMD_SCPAD			BIT(17)
+#define   EIP93_SA_CMD_HASH			GENMASK(15, 12)
+#define   EIP93_SA_CMD_HASH_NULL		FIELD_PREP(EIP93_SA_CMD_HASH, 0xf)
+#define   EIP93_SA_CMD_HASH_SHA256		FIELD_PREP(EIP93_SA_CMD_HASH, 0x3)
+#define   EIP93_SA_CMD_HASH_SHA224		FIELD_PREP(EIP93_SA_CMD_HASH, 0x2)
+#define   EIP93_SA_CMD_HASH_SHA1		FIELD_PREP(EIP93_SA_CMD_HASH, 0x1)
+#define   EIP93_SA_CMD_HASH_MD5			FIELD_PREP(EIP93_SA_CMD_HASH, 0x0)
+#define   EIP93_SA_CMD_CIPHER			GENMASK(11, 8)
+#define   EIP93_SA_CMD_CIPHER_NULL		FIELD_PREP(EIP93_SA_CMD_CIPHER, 0xf)
+#define   EIP93_SA_CMD_CIPHER_AES		FIELD_PREP(EIP93_SA_CMD_CIPHER, 0x3)
+#define   EIP93_SA_CMD_CIPHER_ARC4		FIELD_PREP(EIP93_SA_CMD_CIPHER, 0x2)
+#define   EIP93_SA_CMD_CIPHER_3DES		FIELD_PREP(EIP93_SA_CMD_CIPHER, 0x1)
+#define   EIP93_SA_CMD_CIPHER_DES		FIELD_PREP(EIP93_SA_CMD_CIPHER, 0x0)
+#define   EIP93_SA_CMD_PAD_TYPE			GENMASK(7, 6)
+#define   EIP93_SA_CMD_PAD_CONST_SSL		FIELD_PREP(EIP93_SA_CMD_PAD_TYPE, 0x6)
+#define   EIP93_SA_CMD_PAD_TLS_DTLS		FIELD_PREP(EIP93_SA_CMD_PAD_TYPE, 0x5)
+#define   EIP93_SA_CMD_PAD_ZERO			FIELD_PREP(EIP93_SA_CMD_PAD_TYPE, 0x3)
+#define   EIP93_SA_CMD_PAD_CONST		FIELD_PREP(EIP93_SA_CMD_PAD_TYPE, 0x2)
+#define   EIP93_SA_CMD_PAD_PKCS7		FIELD_PREP(EIP93_SA_CMD_PAD_TYPE, 0x1)
+#define   EIP93_SA_CMD_PAD_IPSEC		FIELD_PREP(EIP93_SA_CMD_PAD_TYPE, 0x0)
+#define   EIP93_SA_CMD_OPGROUP			GENMASK(5, 4)
+#define   EIP93_SA_CMD_OP_EXT			FIELD_PREP(EIP93_SA_CMD_OPGROUP, 0x2)
+#define   EIP93_SA_CMD_OP_PROTOCOL		FIELD_PREP(EIP93_SA_CMD_OPGROUP, 0x1)
+#define   EIP93_SA_CMD_OP_BASIC			FIELD_PREP(EIP93_SA_CMD_OPGROUP, 0x0)
+#define   EIP93_SA_CMD_DIRECTION_IN		BIT(3) /* 0: outbount 1: inbound */
+#define   EIP93_SA_CMD_OPCODE			GENMASK(2, 0)
+#define   EIP93_SA_CMD_OPCODE_BASIC_OUT_PRNG	0x7
+#define   EIP93_SA_CMD_OPCODE_BASIC_OUT_HASH	0x3
+#define   EIP93_SA_CMD_OPCODE_BASIC_OUT_ENC_HASH 0x1
+#define   EIP93_SA_CMD_OPCODE_BASIC_OUT_ENC	0x0
+#define   EIP93_SA_CMD_OPCODE_BASIC_IN_HASH	0x3
+#define   EIP93_SA_CMD_OPCODE_BASIC_IN_HASH_DEC	0x1
+#define   EIP93_SA_CMD_OPCODE_BASIC_IN_DEC	0x0
+#define   EIP93_SA_CMD_OPCODE_PROTOCOL_OUT_ESP	0x0
+#define   EIP93_SA_CMD_OPCODE_PROTOCOL_OUT_SSL	0x4
+#define   EIP93_SA_CMD_OPCODE_PROTOCOL_OUT_TLS	0x5
+#define   EIP93_SA_CMD_OPCODE_PROTOCOL_OUT_SRTP	0x7
+#define   EIP93_SA_CMD_OPCODE_PROTOCOL_IN_ESP	0x0
+#define   EIP93_SA_CMD_OPCODE_PROTOCOL_IN_SSL	0x2
+#define   EIP93_SA_CMD_OPCODE_PROTOCOL_IN_TLS	0x3
+#define   EIP93_SA_CMD_OPCODE_PROTOCOL_IN_SRTP	0x7
+#define   EIP93_SA_CMD_OPCODE_EXT_OUT_DTSL	0x1
+#define   EIP93_SA_CMD_OPCODE_EXT_OUT_SSL	0x4
+#define   EIP93_SA_CMD_OPCODE_EXT_OUT_TLSV10	0x5
+#define   EIP93_SA_CMD_OPCODE_EXT_OUT_TLSV11	0x6
+#define   EIP93_SA_CMD_OPCODE_EXT_IN_DTSL	0x1
+#define   EIP93_SA_CMD_OPCODE_EXT_IN_SSL	0x4
+#define   EIP93_SA_CMD_OPCODE_EXT_IN_TLSV10	0x5
+#define   EIP93_SA_CMD_OPCODE_EXT_IN_TLSV11	0x6
+#define EIP93_REG_SA_CMD_1			0x404
+#define   EIP93_SA_CMD_EN_SEQNUM_CHK		BIT(29)
+/* This mask can be either used for ARC4 or AES */
+#define   EIP93_SA_CMD_ARC4_KEY_LENGHT		GENMASK(28, 24)
+#define   EIP93_SA_CMD_AES_DEC_KEY		BIT(28) /* 0: encrypt key 1: decrypt key */
+#define   EIP93_SA_CMD_AES_KEY_LENGTH		GENMASK(26, 24)
+#define   EIP93_SA_CMD_AES_KEY_256BIT		FIELD_PREP(EIP93_SA_CMD_AES_KEY_LENGTH, 0x4)
+#define   EIP93_SA_CMD_AES_KEY_192BIT		FIELD_PREP(EIP93_SA_CMD_AES_KEY_LENGTH, 0x3)
+#define   EIP93_SA_CMD_AES_KEY_128BIT		FIELD_PREP(EIP93_SA_CMD_AES_KEY_LENGTH, 0x2)
+#define   EIP93_SA_CMD_HASH_CRYPT_OFFSET	GENMASK(23, 16)
+#define   EIP93_SA_CMD_BYTE_OFFSET		BIT(13) /* 0: CRYPT_OFFSET in 32bit word 1: CRYPT_OFFSET in 8bit bytes */
+#define   EIP93_SA_CMD_HMAC			BIT(12)
+#define   EIP93_SA_CMD_SSL_MAC			BIT(12)
+/* This mask can be either used for ARC4 or AES */
+#define   EIP93_SA_CMD_CHIPER_MODE		GENMASK(9, 8)
+/* AES or DES operations */
+#define   EIP93_SA_CMD_CHIPER_MODE_ICM		FIELD_PREP(EIP93_SA_CMD_CHIPER_MODE, 0x3)
+#define   EIP93_SA_CMD_CHIPER_MODE_CTR		FIELD_PREP(EIP93_SA_CMD_CHIPER_MODE, 0x2)
+#define   EIP93_SA_CMD_CHIPER_MODE_CBC		FIELD_PREP(EIP93_SA_CMD_CHIPER_MODE, 0x1)
+#define   EIP93_SA_CMD_CHIPER_MODE_ECB		FIELD_PREP(EIP93_SA_CMD_CHIPER_MODE, 0x0)
+/* ARC4 operations */
+#define   EIP93_SA_CMD_CHIPER_MODE_STATEFULL	FIELD_PREP(EIP93_SA_CMD_CHIPER_MODE, 0x1)
+#define   EIP93_SA_CMD_CHIPER_MODE_STATELESS	FIELD_PREP(EIP93_SA_CMD_CHIPER_MODE, 0x0)
+#define   EIP93_SA_CMD_COPY_PAD			BIT(3)
+#define   EIP93_SA_CMD_COPY_PAYLOAD		BIT(2)
+#define   EIP93_SA_CMD_COPY_HEADER		BIT(1)
+#define   EIP93_SA_CMD_COPY_DIGEST		BIT(0) /* With this enabled, COPY_PAD is required */
+
+/* State save register */
+#define EIP93_REG_STATE_IV_0			0x500
+#define EIP93_REG_STATE_IV_1			0x504
+
+#define EIP93_REG_PE_ARC4STATE			0x700
+
+struct sa_record {
+	u32 sa_cmd0_word;
+	u32 sa_cmd1_word;
+	u32 sa_key[8];
+	u8 sa_i_digest[32];
+	u8 sa_o_digest[32];
+	u32 sa_spi;
+	u32 sa_seqnum[2];
+	u32 sa_seqmum_mask[2];
+	u32 sa_nonce;
+} __packed;
+
+struct sa_state {
+	u32 state_iv[4];
+	u32 state_byte_cnt[2];
+	u8 state_i_digest[32];
+} __packed;
+
+struct eip93_descriptor {
+	u32 pe_ctrl_stat_word;
+	u32 src_addr;
+	u32 dst_addr;
+	u32 sa_addr;
+	u32 state_addr;
+	u32 arc4_addr;
+	u32 user_id;
+	u32 pe_length_word;
+} __packed;
+
+#endif
-- 
2.45.2



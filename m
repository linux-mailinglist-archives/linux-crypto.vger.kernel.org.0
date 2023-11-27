Return-Path: <linux-crypto+bounces-302-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0364C7F9BCD
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Nov 2023 09:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91A9280D4D
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Nov 2023 08:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C54171AC
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Nov 2023 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bZbye1PT"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B897218F
	for <linux-crypto@vger.kernel.org>; Sun, 26 Nov 2023 23:07:35 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc9b626a96so26864175ad.2
        for <linux-crypto@vger.kernel.org>; Sun, 26 Nov 2023 23:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701068855; x=1701673655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1s7i3VA49GEZVjag/Kbhi+FIt8+X1iRiytC3VJdGAg=;
        b=bZbye1PTMTRi/rawxPtlfPPa8km4RZ0l3B+7K3XyihDu17U9PSLCvaaxC5NlFZDZb1
         HEi5x8xtOrDs4dGYmdjI7hPwjEuYsbjY9slL9GlooPTEO61BdMEZH4fkDPgc+1vr1L7q
         yRxXin6L1AurZfCoK0GCsUPrR1WFRpmkkfe2JuXiJUet6CoARCD1KgCtnSMc4lukNmO3
         18L0yKFLXHmrw8/9STRr3UPkcAHADhha68MR7QNItWz/eqHcxpdWervPgnyPPLkzup7/
         T/UabG6R3fwE2E22YD2R49g86RXokDdEmDmejJnsbSx5EpHX8XhsbNlCu+igJT6hnjxy
         PYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701068855; x=1701673655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1s7i3VA49GEZVjag/Kbhi+FIt8+X1iRiytC3VJdGAg=;
        b=QYkUvWQG4X+v4LRkNQUMB10tQWDxzyUVFQJPmPDBJsYN9pC7xqzZ4cLE3mFMuI6yU1
         F82qGnvev3F7Kp254uakpnxzV8PHaQGLoWoR/8OBby81FQi2PLV5D8R2GrfMeDjBjm/6
         vTBNPj31Qkov9QetBKFDJcUFe+7NpWK8JwyLy3hGhG1BwFdWjGjkrC1dlyrM/o1j8x9a
         Gjczr9xzykt5oTYWIhjwEYwbso2mNW4YMgoCSxplzVW3mbM7ddyiIDdnTF81+Tbpfo9e
         f3rmnTAYrZiN+kMDh41iwSKcAyocwuo+docGUR+zd3gpZ0iJXJygieNELKdWrSHAViAV
         gDqg==
X-Gm-Message-State: AOJu0YzstYEMap5A8RcfMFdWRGDfAEZexlAonM60Um/d/zvCPgkdg5UK
	cczrz/5aWJqiHqnNxac9BzBswg==
X-Google-Smtp-Source: AGHT+IEdpkYekzvZiIQ/njqiH1GpCr+lk2R945AdXDLzoB19kY/lDSKWeYSQh2uFfNGIUhkXyGVo9g==
X-Received: by 2002:a17:902:ead2:b0:1cf:63bb:82a6 with SMTP id p18-20020a170902ead200b001cf63bb82a6mr9164128pld.65.1701068854621;
        Sun, 26 Nov 2023 23:07:34 -0800 (PST)
Received: from localhost.localdomain ([101.10.45.230])
        by smtp.gmail.com with ESMTPSA id jh15-20020a170903328f00b001cfcd3a764esm1340134plb.77.2023.11.26.23.07.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Nov 2023 23:07:34 -0800 (PST)
From: Jerry Shih <jerry.shih@sifive.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	conor.dooley@microchip.com,
	ebiggers@kernel.org,
	ardb@kernel.org
Cc: heiko@sntech.de,
	phoebe.chen@sifive.com,
	hongrong.hsu@sifive.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH v2 07/13] RISC-V: crypto: add accelerated AES-CBC/CTR/ECB/XTS implementations
Date: Mon, 27 Nov 2023 15:06:57 +0800
Message-Id: <20231127070703.1697-8-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20231127070703.1697-1-jerry.shih@sifive.com>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Port the vector-crypto accelerated CBC, CTR, ECB and XTS block modes for
AES cipher from OpenSSL(openssl/openssl#21923).
In addition, support XTS-AES-192 mode which is not existed in OpenSSL.

Co-developed-by: Phoebe Chen <phoebe.chen@sifive.com>
Signed-off-by: Phoebe Chen <phoebe.chen@sifive.com>
Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
---
Changelog v2:
 - Do not turn on kconfig `AES_BLOCK_RISCV64` option by default.
 - Update asm function for using aes key in `crypto_aes_ctx` structure.
 - Turn to use simd skcipher interface for AES-CBC/CTR/ECB/XTS modes.
 We still have lots of discussions for kernel-vector implementation.
 Before the final version of kernel-vector, use simd skcipher interface
 to skip the fallback path for all aes modes in all kinds of contexts.
 If we could always enable kernel-vector in softirq in the future, we
 could make the original sync skcipher algorithm back.
 - Refine aes-xts comments for head and tail blocks handling.
 - Update VLEN constraint for aex-xts mode.
 - Add `asmlinkage` qualifier for crypto asm function.
 - Rename aes-riscv64-zvbb-zvkg-zvkned to aes-riscv64-zvkned-zvbb-zvkg.
 - Rename aes-riscv64-zvkb-zvkned to aes-riscv64-zvkned-zvkb.
 - Reorder structure riscv64_aes_algs_zvkned, riscv64_aes_alg_zvkned_zvkb
   and riscv64_aes_alg_zvkned_zvbb_zvkg members initialization in the
   order declared.
---
 arch/riscv/crypto/Kconfig                     |  21 +
 arch/riscv/crypto/Makefile                    |  11 +
 .../crypto/aes-riscv64-block-mode-glue.c      | 514 ++++++++++
 .../crypto/aes-riscv64-zvkned-zvbb-zvkg.pl    | 949 ++++++++++++++++++
 arch/riscv/crypto/aes-riscv64-zvkned-zvkb.pl  | 415 ++++++++
 arch/riscv/crypto/aes-riscv64-zvkned.pl       | 746 ++++++++++++++
 6 files changed, 2656 insertions(+)
 create mode 100644 arch/riscv/crypto/aes-riscv64-block-mode-glue.c
 create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned-zvbb-zvkg.pl
 create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned-zvkb.pl

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index 65189d4d47b3..9d991ddda289 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -13,4 +13,25 @@ config CRYPTO_AES_RISCV64
 	  Architecture: riscv64 using:
 	  - Zvkned vector crypto extension
 
+config CRYPTO_AES_BLOCK_RISCV64
+	tristate "Ciphers: AES, modes: ECB/CBC/CTR/XTS"
+	depends on 64BIT && RISCV_ISA_V
+	select CRYPTO_AES_RISCV64
+	select CRYPTO_SIMD
+	select CRYPTO_SKCIPHER
+	help
+	  Length-preserving ciphers: AES cipher algorithms (FIPS-197)
+	  with block cipher modes:
+	  - ECB (Electronic Codebook) mode (NIST SP 800-38A)
+	  - CBC (Cipher Block Chaining) mode (NIST SP 800-38A)
+	  - CTR (Counter) mode (NIST SP 800-38A)
+	  - XTS (XOR Encrypt XOR Tweakable Block Cipher with Ciphertext
+	    Stealing) mode (NIST SP 800-38E and IEEE 1619)
+
+	  Architecture: riscv64 using:
+	  - Zvkned vector crypto extension
+	  - Zvbb vector extension (XTS)
+	  - Zvkb vector crypto extension (CTR/XTS)
+	  - Zvkg vector crypto extension (XTS)
+
 endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index 90ca91d8df26..9574b009762f 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -6,10 +6,21 @@
 obj-$(CONFIG_CRYPTO_AES_RISCV64) += aes-riscv64.o
 aes-riscv64-y := aes-riscv64-glue.o aes-riscv64-zvkned.o
 
+obj-$(CONFIG_CRYPTO_AES_BLOCK_RISCV64) += aes-block-riscv64.o
+aes-block-riscv64-y := aes-riscv64-block-mode-glue.o aes-riscv64-zvkned-zvbb-zvkg.o aes-riscv64-zvkned-zvkb.o
+
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $(<) void $(@)
 
 $(obj)/aes-riscv64-zvkned.S: $(src)/aes-riscv64-zvkned.pl
 	$(call cmd,perlasm)
 
+$(obj)/aes-riscv64-zvkned-zvbb-zvkg.S: $(src)/aes-riscv64-zvkned-zvbb-zvkg.pl
+	$(call cmd,perlasm)
+
+$(obj)/aes-riscv64-zvkned-zvkb.S: $(src)/aes-riscv64-zvkned-zvkb.pl
+	$(call cmd,perlasm)
+
 clean-files += aes-riscv64-zvkned.S
+clean-files += aes-riscv64-zvkned-zvbb-zvkg.S
+clean-files += aes-riscv64-zvkned-zvkb.S
diff --git a/arch/riscv/crypto/aes-riscv64-block-mode-glue.c b/arch/riscv/crypto/aes-riscv64-block-mode-glue.c
new file mode 100644
index 000000000000..36fdd83b11ef
--- /dev/null
+++ b/arch/riscv/crypto/aes-riscv64-block-mode-glue.c
@@ -0,0 +1,514 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Port of the OpenSSL AES block mode implementations for RISC-V
+ *
+ * Copyright (C) 2023 SiFive, Inc.
+ * Author: Jerry Shih <jerry.shih@sifive.com>
+ */
+
+#include <asm/simd.h>
+#include <asm/vector.h>
+#include <crypto/aes.h>
+#include <crypto/ctr.h>
+#include <crypto/xts.h>
+#include <crypto/internal/cipher.h>
+#include <crypto/internal/simd.h>
+#include <crypto/internal/skcipher.h>
+#include <crypto/scatterwalk.h>
+#include <linux/crypto.h>
+#include <linux/linkage.h>
+#include <linux/math.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+#include "aes-riscv64-glue.h"
+
+struct riscv64_aes_xts_ctx {
+	struct crypto_aes_ctx ctx1;
+	struct crypto_aes_ctx ctx2;
+};
+
+/* aes cbc block mode using zvkned vector crypto extension */
+asmlinkage void rv64i_zvkned_cbc_encrypt(const u8 *in, u8 *out, size_t length,
+					 const struct crypto_aes_ctx *key,
+					 u8 *ivec);
+asmlinkage void rv64i_zvkned_cbc_decrypt(const u8 *in, u8 *out, size_t length,
+					 const struct crypto_aes_ctx *key,
+					 u8 *ivec);
+/* aes ecb block mode using zvkned vector crypto extension */
+asmlinkage void rv64i_zvkned_ecb_encrypt(const u8 *in, u8 *out, size_t length,
+					 const struct crypto_aes_ctx *key);
+asmlinkage void rv64i_zvkned_ecb_decrypt(const u8 *in, u8 *out, size_t length,
+					 const struct crypto_aes_ctx *key);
+
+/* aes ctr block mode using zvkb and zvkned vector crypto extension */
+/* This func operates on 32-bit counter. Caller has to handle the overflow. */
+asmlinkage void
+rv64i_zvkb_zvkned_ctr32_encrypt_blocks(const u8 *in, u8 *out, size_t length,
+				       const struct crypto_aes_ctx *key,
+				       u8 *ivec);
+
+/* aes xts block mode using zvbb, zvkg and zvkned vector crypto extension */
+asmlinkage void
+rv64i_zvbb_zvkg_zvkned_aes_xts_encrypt(const u8 *in, u8 *out, size_t length,
+				       const struct crypto_aes_ctx *key, u8 *iv,
+				       int update_iv);
+asmlinkage void
+rv64i_zvbb_zvkg_zvkned_aes_xts_decrypt(const u8 *in, u8 *out, size_t length,
+				       const struct crypto_aes_ctx *key, u8 *iv,
+				       int update_iv);
+
+typedef void (*aes_xts_func)(const u8 *in, u8 *out, size_t length,
+			     const struct crypto_aes_ctx *key, u8 *iv,
+			     int update_iv);
+
+/* ecb */
+static int aes_setkey(struct crypto_skcipher *tfm, const u8 *in_key,
+		      unsigned int key_len)
+{
+	struct crypto_aes_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	return riscv64_aes_setkey(ctx, in_key, key_len);
+}
+
+static int ecb_encrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	const struct crypto_aes_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	int err;
+
+	/* If we have error here, the `nbytes` will be zero. */
+	err = skcipher_walk_virt(&walk, req, false);
+	while ((nbytes = walk.nbytes)) {
+		kernel_vector_begin();
+		rv64i_zvkned_ecb_encrypt(walk.src.virt.addr, walk.dst.virt.addr,
+					 nbytes & (~(AES_BLOCK_SIZE - 1)), ctx);
+		kernel_vector_end();
+		err = skcipher_walk_done(&walk, nbytes & (AES_BLOCK_SIZE - 1));
+	}
+
+	return err;
+}
+
+static int ecb_decrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	const struct crypto_aes_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	int err;
+
+	err = skcipher_walk_virt(&walk, req, false);
+	while ((nbytes = walk.nbytes)) {
+		kernel_vector_begin();
+		rv64i_zvkned_ecb_decrypt(walk.src.virt.addr, walk.dst.virt.addr,
+					 nbytes & (~(AES_BLOCK_SIZE - 1)), ctx);
+		kernel_vector_end();
+		err = skcipher_walk_done(&walk, nbytes & (AES_BLOCK_SIZE - 1));
+	}
+
+	return err;
+}
+
+/* cbc */
+static int cbc_encrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	const struct crypto_aes_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	int err;
+
+	err = skcipher_walk_virt(&walk, req, false);
+	while ((nbytes = walk.nbytes)) {
+		kernel_vector_begin();
+		rv64i_zvkned_cbc_encrypt(walk.src.virt.addr, walk.dst.virt.addr,
+					 nbytes & (~(AES_BLOCK_SIZE - 1)), ctx,
+					 walk.iv);
+		kernel_vector_end();
+		err = skcipher_walk_done(&walk, nbytes & (AES_BLOCK_SIZE - 1));
+	}
+
+	return err;
+}
+
+static int cbc_decrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	const struct crypto_aes_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	int err;
+
+	err = skcipher_walk_virt(&walk, req, false);
+	while ((nbytes = walk.nbytes)) {
+		kernel_vector_begin();
+		rv64i_zvkned_cbc_decrypt(walk.src.virt.addr, walk.dst.virt.addr,
+					 nbytes & (~(AES_BLOCK_SIZE - 1)), ctx,
+					 walk.iv);
+		kernel_vector_end();
+		err = skcipher_walk_done(&walk, nbytes & (AES_BLOCK_SIZE - 1));
+	}
+
+	return err;
+}
+
+/* ctr */
+static int ctr_encrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	const struct crypto_aes_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk walk;
+	unsigned int ctr32;
+	unsigned int nbytes;
+	unsigned int blocks;
+	unsigned int current_blocks;
+	unsigned int current_length;
+	int err;
+
+	/* the ctr iv uses big endian */
+	ctr32 = get_unaligned_be32(req->iv + 12);
+	err = skcipher_walk_virt(&walk, req, false);
+	while ((nbytes = walk.nbytes)) {
+		if (nbytes != walk.total) {
+			nbytes &= (~(AES_BLOCK_SIZE - 1));
+			blocks = nbytes / AES_BLOCK_SIZE;
+		} else {
+			/* This is the last walk. We should handle the tail data. */
+			blocks = DIV_ROUND_UP(nbytes, AES_BLOCK_SIZE);
+		}
+		ctr32 += blocks;
+
+		kernel_vector_begin();
+		/*
+		 * The `if` block below detects the overflow, which is then handled by
+		 * limiting the amount of blocks to the exact overflow point.
+		 */
+		if (ctr32 >= blocks) {
+			rv64i_zvkb_zvkned_ctr32_encrypt_blocks(
+				walk.src.virt.addr, walk.dst.virt.addr, nbytes,
+				ctx, req->iv);
+		} else {
+			/* use 2 ctr32 function calls for overflow case */
+			current_blocks = blocks - ctr32;
+			current_length =
+				min(nbytes, current_blocks * AES_BLOCK_SIZE);
+			rv64i_zvkb_zvkned_ctr32_encrypt_blocks(
+				walk.src.virt.addr, walk.dst.virt.addr,
+				current_length, ctx, req->iv);
+			crypto_inc(req->iv, 12);
+
+			if (ctr32) {
+				rv64i_zvkb_zvkned_ctr32_encrypt_blocks(
+					walk.src.virt.addr +
+						current_blocks * AES_BLOCK_SIZE,
+					walk.dst.virt.addr +
+						current_blocks * AES_BLOCK_SIZE,
+					nbytes - current_length, ctx, req->iv);
+			}
+		}
+		kernel_vector_end();
+
+		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
+	}
+
+	return err;
+}
+
+/* xts */
+static int xts_setkey(struct crypto_skcipher *tfm, const u8 *in_key,
+		      unsigned int key_len)
+{
+	struct riscv64_aes_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
+	unsigned int xts_single_key_len = key_len / 2;
+	int ret;
+
+	ret = xts_verify_key(tfm, in_key, key_len);
+	if (ret)
+		return ret;
+	ret = riscv64_aes_setkey(&ctx->ctx1, in_key, xts_single_key_len);
+	if (ret)
+		return ret;
+	return riscv64_aes_setkey(&ctx->ctx2, in_key + xts_single_key_len,
+				  xts_single_key_len);
+}
+
+static int xts_crypt(struct skcipher_request *req, aes_xts_func func)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	const struct riscv64_aes_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_request sub_req;
+	struct scatterlist sg_src[2], sg_dst[2];
+	struct scatterlist *src, *dst;
+	struct skcipher_walk walk;
+	unsigned int walk_size = crypto_skcipher_walksize(tfm);
+	unsigned int tail_bytes;
+	unsigned int head_bytes;
+	unsigned int nbytes;
+	unsigned int update_iv = 1;
+	int err;
+
+	/* xts input size should be bigger than AES_BLOCK_SIZE */
+	if (req->cryptlen < AES_BLOCK_SIZE)
+		return -EINVAL;
+
+	/*
+	 * We split xts-aes cryption into `head` and `tail` parts.
+	 * The head block contains the input from the beginning which doesn't need
+	 * `ciphertext stealing` method.
+	 * The tail block contains at least two AES blocks including ciphertext
+	 * stealing data from the end.
+	 */
+	if (req->cryptlen <= walk_size) {
+		/*
+		 * All data is in one `walk`. We could handle it within one AES-XTS call in
+		 * the end.
+		 */
+		tail_bytes = req->cryptlen;
+		head_bytes = 0;
+	} else {
+		if (req->cryptlen & (AES_BLOCK_SIZE - 1)) {
+			/*
+			 * with ciphertext stealing
+			 *
+			 * Find the largest tail size which is small than `walk` size while the
+			 * head part still fits AES block boundary.
+			 */
+			tail_bytes = req->cryptlen & (AES_BLOCK_SIZE - 1);
+			tail_bytes = walk_size + tail_bytes - AES_BLOCK_SIZE;
+			head_bytes = req->cryptlen - tail_bytes;
+		} else {
+			/* no ciphertext stealing */
+			tail_bytes = 0;
+			head_bytes = req->cryptlen;
+		}
+	}
+
+	riscv64_aes_encrypt_zvkned(&ctx->ctx2, req->iv, req->iv);
+
+	if (head_bytes && tail_bytes) {
+		/* If we have to parts, setup new request for head part only. */
+		skcipher_request_set_tfm(&sub_req, tfm);
+		skcipher_request_set_callback(
+			&sub_req, skcipher_request_flags(req), NULL, NULL);
+		skcipher_request_set_crypt(&sub_req, req->src, req->dst,
+					   head_bytes, req->iv);
+		req = &sub_req;
+	}
+
+	if (head_bytes) {
+		err = skcipher_walk_virt(&walk, req, false);
+		while ((nbytes = walk.nbytes)) {
+			if (nbytes == walk.total)
+				update_iv = (tail_bytes > 0);
+
+			nbytes &= (~(AES_BLOCK_SIZE - 1));
+			kernel_vector_begin();
+			func(walk.src.virt.addr, walk.dst.virt.addr, nbytes,
+			     &ctx->ctx1, req->iv, update_iv);
+			kernel_vector_end();
+
+			err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
+		}
+		if (err || !tail_bytes)
+			return err;
+
+		/*
+		 * Setup new request for tail part.
+		 * We use `scatterwalk_next()` to find the next scatterlist from last
+		 * walk instead of iterating from the beginning.
+		 */
+		dst = src = scatterwalk_next(sg_src, &walk.in);
+		if (req->dst != req->src)
+			dst = scatterwalk_next(sg_dst, &walk.out);
+		skcipher_request_set_crypt(req, src, dst, tail_bytes, req->iv);
+	}
+
+	/* tail */
+	err = skcipher_walk_virt(&walk, req, false);
+	if (err)
+		return err;
+	if (walk.nbytes != tail_bytes)
+		return -EINVAL;
+	kernel_vector_begin();
+	func(walk.src.virt.addr, walk.dst.virt.addr, walk.nbytes, &ctx->ctx1,
+	     req->iv, 0);
+	kernel_vector_end();
+
+	return skcipher_walk_done(&walk, 0);
+}
+
+static int xts_encrypt(struct skcipher_request *req)
+{
+	return xts_crypt(req, rv64i_zvbb_zvkg_zvkned_aes_xts_encrypt);
+}
+
+static int xts_decrypt(struct skcipher_request *req)
+{
+	return xts_crypt(req, rv64i_zvbb_zvkg_zvkned_aes_xts_decrypt);
+}
+
+static struct skcipher_alg riscv64_aes_algs_zvkned[] = {
+	{
+		.setkey = aes_setkey,
+		.encrypt = ecb_encrypt,
+		.decrypt = ecb_decrypt,
+		.min_keysize = AES_MIN_KEY_SIZE,
+		.max_keysize = AES_MAX_KEY_SIZE,
+		.walksize = AES_BLOCK_SIZE * 8,
+		.base = {
+			.cra_flags = CRYPTO_ALG_INTERNAL,
+			.cra_blocksize = AES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct crypto_aes_ctx),
+			.cra_priority = 300,
+			.cra_name	= "__ecb(aes)",
+			.cra_driver_name = "__ecb-aes-riscv64-zvkned",
+			.cra_module = THIS_MODULE,
+		},
+	}, {
+		.setkey = aes_setkey,
+		.encrypt = cbc_encrypt,
+		.decrypt = cbc_decrypt,
+		.min_keysize = AES_MIN_KEY_SIZE,
+		.max_keysize = AES_MAX_KEY_SIZE,
+		.ivsize = AES_BLOCK_SIZE,
+		.walksize = AES_BLOCK_SIZE * 8,
+		.base = {
+			.cra_flags = CRYPTO_ALG_INTERNAL,
+			.cra_blocksize = AES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct crypto_aes_ctx),
+			.cra_priority = 300,
+			.cra_name = "__cbc(aes)",
+			.cra_driver_name = "__cbc-aes-riscv64-zvkned",
+			.cra_module = THIS_MODULE,
+		},
+	}
+};
+
+static struct simd_skcipher_alg
+	*riscv64_aes_simd_algs_zvkned[ARRAY_SIZE(riscv64_aes_algs_zvkned)];
+
+static struct skcipher_alg riscv64_aes_alg_zvkned_zvkb[] = {
+	{
+		.setkey = aes_setkey,
+		.encrypt = ctr_encrypt,
+		.decrypt = ctr_encrypt,
+		.min_keysize = AES_MIN_KEY_SIZE,
+		.max_keysize = AES_MAX_KEY_SIZE,
+		.ivsize = AES_BLOCK_SIZE,
+		.chunksize = AES_BLOCK_SIZE,
+		.walksize = AES_BLOCK_SIZE * 8,
+		.base = {
+			.cra_flags = CRYPTO_ALG_INTERNAL,
+			.cra_blocksize = 1,
+			.cra_ctxsize = sizeof(struct crypto_aes_ctx),
+			.cra_priority = 300,
+			.cra_name = "__ctr(aes)",
+			.cra_driver_name = "__ctr-aes-riscv64-zvkned-zvkb",
+			.cra_module = THIS_MODULE,
+		},
+	}
+};
+
+static struct simd_skcipher_alg *riscv64_aes_simd_alg_zvkned_zvkb[ARRAY_SIZE(
+	riscv64_aes_alg_zvkned_zvkb)];
+
+static struct skcipher_alg riscv64_aes_alg_zvkned_zvbb_zvkg[] = {
+	{
+		.setkey = xts_setkey,
+		.encrypt = xts_encrypt,
+		.decrypt = xts_decrypt,
+		.min_keysize = AES_MIN_KEY_SIZE * 2,
+		.max_keysize = AES_MAX_KEY_SIZE * 2,
+		.ivsize = AES_BLOCK_SIZE,
+		.chunksize = AES_BLOCK_SIZE,
+		.walksize = AES_BLOCK_SIZE * 8,
+		.base = {
+			.cra_flags = CRYPTO_ALG_INTERNAL,
+			.cra_blocksize = AES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct riscv64_aes_xts_ctx),
+			.cra_priority = 300,
+			.cra_name = "__xts(aes)",
+			.cra_driver_name = "__xts-aes-riscv64-zvkned-zvbb-zvkg",
+			.cra_module = THIS_MODULE,
+		},
+	}
+};
+
+static struct simd_skcipher_alg
+	*riscv64_aes_simd_alg_zvkned_zvbb_zvkg[ARRAY_SIZE(
+		riscv64_aes_alg_zvkned_zvbb_zvkg)];
+
+static int __init riscv64_aes_block_mod_init(void)
+{
+	int ret = -ENODEV;
+
+	if (riscv_isa_extension_available(NULL, ZVKNED) &&
+	    riscv_vector_vlen() >= 128 && riscv_vector_vlen() <= 2048) {
+		ret = simd_register_skciphers_compat(
+			riscv64_aes_algs_zvkned,
+			ARRAY_SIZE(riscv64_aes_algs_zvkned),
+			riscv64_aes_simd_algs_zvkned);
+		if (ret)
+			return ret;
+
+		if (riscv_isa_extension_available(NULL, ZVBB)) {
+			ret = simd_register_skciphers_compat(
+				riscv64_aes_alg_zvkned_zvkb,
+				ARRAY_SIZE(riscv64_aes_alg_zvkned_zvkb),
+				riscv64_aes_simd_alg_zvkned_zvkb);
+			if (ret)
+				goto unregister_zvkned;
+
+			if (riscv_isa_extension_available(NULL, ZVKG)) {
+				ret = simd_register_skciphers_compat(
+					riscv64_aes_alg_zvkned_zvbb_zvkg,
+					ARRAY_SIZE(
+						riscv64_aes_alg_zvkned_zvbb_zvkg),
+					riscv64_aes_simd_alg_zvkned_zvbb_zvkg);
+				if (ret)
+					goto unregister_zvkned_zvkb;
+			}
+		}
+	}
+
+	return ret;
+
+unregister_zvkned_zvkb:
+	simd_unregister_skciphers(riscv64_aes_alg_zvkned_zvkb,
+				  ARRAY_SIZE(riscv64_aes_alg_zvkned_zvkb),
+				  riscv64_aes_simd_alg_zvkned_zvkb);
+unregister_zvkned:
+	simd_unregister_skciphers(riscv64_aes_algs_zvkned,
+				  ARRAY_SIZE(riscv64_aes_algs_zvkned),
+				  riscv64_aes_simd_algs_zvkned);
+
+	return ret;
+}
+
+static void __exit riscv64_aes_block_mod_fini(void)
+{
+	simd_unregister_skciphers(riscv64_aes_alg_zvkned_zvbb_zvkg,
+				  ARRAY_SIZE(riscv64_aes_alg_zvkned_zvbb_zvkg),
+				  riscv64_aes_simd_alg_zvkned_zvbb_zvkg);
+	simd_unregister_skciphers(riscv64_aes_alg_zvkned_zvkb,
+				  ARRAY_SIZE(riscv64_aes_alg_zvkned_zvkb),
+				  riscv64_aes_simd_alg_zvkned_zvkb);
+	simd_unregister_skciphers(riscv64_aes_algs_zvkned,
+				  ARRAY_SIZE(riscv64_aes_algs_zvkned),
+				  riscv64_aes_simd_algs_zvkned);
+}
+
+module_init(riscv64_aes_block_mod_init);
+module_exit(riscv64_aes_block_mod_fini);
+
+MODULE_DESCRIPTION("AES-ECB/CBC/CTR/XTS (RISC-V accelerated)");
+MODULE_AUTHOR("Jerry Shih <jerry.shih@sifive.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("cbc(aes)");
+MODULE_ALIAS_CRYPTO("ctr(aes)");
+MODULE_ALIAS_CRYPTO("ecb(aes)");
+MODULE_ALIAS_CRYPTO("xts(aes)");
diff --git a/arch/riscv/crypto/aes-riscv64-zvkned-zvbb-zvkg.pl b/arch/riscv/crypto/aes-riscv64-zvkned-zvbb-zvkg.pl
new file mode 100644
index 000000000000..6b6aad1cc97a
--- /dev/null
+++ b/arch/riscv/crypto/aes-riscv64-zvkned-zvbb-zvkg.pl
@@ -0,0 +1,949 @@
+#! /usr/bin/env perl
+# SPDX-License-Identifier: Apache-2.0 OR BSD-2-Clause
+#
+# This file is dual-licensed, meaning that you can use it under your
+# choice of either of the following two licenses:
+#
+# Copyright 2023 The OpenSSL Project Authors. All Rights Reserved.
+#
+# Licensed under the Apache License 2.0 (the "License"). You can obtain
+# a copy in the file LICENSE in the source distribution or at
+# https://www.openssl.org/source/license.html
+#
+# or
+#
+# Copyright (c) 2023, Jerry Shih <jerry.shih@sifive.com>
+# All rights reserved.
+#
+# Redistribution and use in source and binary forms, with or without
+# modification, are permitted provided that the following conditions
+# are met:
+# 1. Redistributions of source code must retain the above copyright
+#    notice, this list of conditions and the following disclaimer.
+# 2. Redistributions in binary form must reproduce the above copyright
+#    notice, this list of conditions and the following disclaimer in the
+#    documentation and/or other materials provided with the distribution.
+#
+# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+
+# - RV64I
+# - RISC-V Vector ('V') with VLEN >= 128 && VLEN <= 2048
+# - RISC-V Vector Bit-manipulation extension ('Zvbb')
+# - RISC-V Vector GCM/GMAC extension ('Zvkg')
+# - RISC-V Vector AES block cipher extension ('Zvkned')
+
+use strict;
+use warnings;
+
+use FindBin qw($Bin);
+use lib "$Bin";
+use lib "$Bin/../../perlasm";
+use riscv;
+
+# $output is the last argument if it looks like a file (it has an extension)
+# $flavour is the first argument if it doesn't look like a file
+my $output = $#ARGV >= 0 && $ARGV[$#ARGV] =~ m|\.\w+$| ? pop : undef;
+my $flavour = $#ARGV >= 0 && $ARGV[0] !~ m|\.| ? shift : undef;
+
+$output and open STDOUT,">$output";
+
+my $code=<<___;
+.text
+___
+
+{
+################################################################################
+# void rv64i_zvbb_zvkg_zvkned_aes_xts_encrypt(const unsigned char *in,
+#                                             unsigned char *out, size_t length,
+#                                             const AES_KEY *key,
+#                                             unsigned char iv[16],
+#                                             int update_iv)
+my ($INPUT, $OUTPUT, $LENGTH, $KEY, $IV, $UPDATE_IV) = ("a0", "a1", "a2", "a3", "a4", "a5");
+my ($TAIL_LENGTH) = ("a6");
+my ($VL) = ("a7");
+my ($T0, $T1, $T2, $T3) = ("t0", "t1", "t2", "t3");
+my ($STORE_LEN32) = ("t4");
+my ($LEN32) = ("t5");
+my ($V0, $V1, $V2, $V3, $V4, $V5, $V6, $V7,
+    $V8, $V9, $V10, $V11, $V12, $V13, $V14, $V15,
+    $V16, $V17, $V18, $V19, $V20, $V21, $V22, $V23,
+    $V24, $V25, $V26, $V27, $V28, $V29, $V30, $V31,
+) = map("v$_",(0..31));
+
+# load iv to v28
+sub load_xts_iv0 {
+    my $code=<<___;
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vle32_v $V28, $IV]}
+___
+
+    return $code;
+}
+
+# prepare input data(v24), iv(v28), bit-reversed-iv(v16), bit-reversed-iv-multiplier(v20)
+sub init_first_round {
+    my $code=<<___;
+    # load input
+    @{[vsetvli $VL, $LEN32, "e32", "m4", "ta", "ma"]}
+    @{[vle32_v $V24, $INPUT]}
+
+    li $T0, 5
+    # We could simplify the initialization steps if we have `block<=1`.
+    blt $LEN32, $T0, 1f
+
+    # Note: We use `vgmul` for GF(2^128) multiplication. The `vgmul` uses
+    # different order of coefficients. We should use`vbrev8` to reverse the
+    # data when we use `vgmul`.
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vbrev8_v $V0, $V28]}
+    @{[vsetvli "zero", $LEN32, "e32", "m4", "ta", "ma"]}
+    @{[vmv_v_i $V16, 0]}
+    # v16: [r-IV0, r-IV0, ...]
+    @{[vaesz_vs $V16, $V0]}
+
+    # Prepare GF(2^128) multiplier [1, x, x^2, x^3, ...] in v8.
+    # We use `vwsll` to get power of 2 multipliers. Current rvv spec only
+    # supports `SEW<=64`. So, the maximum `VLEN` for this approach is `2048`.
+    #   SEW64_BITS * AES_BLOCK_SIZE / LMUL
+    #   = 64 * 128 / 4 = 2048
+    #
+    # TODO: truncate the vl to `2048` for `vlen>2048` case.
+    slli $T0, $LEN32, 2
+    @{[vsetvli "zero", $T0, "e32", "m1", "ta", "ma"]}
+    # v2: [`1`, `1`, `1`, `1`, ...]
+    @{[vmv_v_i $V2, 1]}
+    # v3: [`0`, `1`, `2`, `3`, ...]
+    @{[vid_v $V3]}
+    @{[vsetvli "zero", $T0, "e64", "m2", "ta", "ma"]}
+    # v4: [`1`, 0, `1`, 0, `1`, 0, `1`, 0, ...]
+    @{[vzext_vf2 $V4, $V2]}
+    # v6: [`0`, 0, `1`, 0, `2`, 0, `3`, 0, ...]
+    @{[vzext_vf2 $V6, $V3]}
+    slli $T0, $LEN32, 1
+    @{[vsetvli "zero", $T0, "e32", "m2", "ta", "ma"]}
+    # v8: [1<<0=1, 0, 0, 0, 1<<1=x, 0, 0, 0, 1<<2=x^2, 0, 0, 0, ...]
+    @{[vwsll_vv $V8, $V4, $V6]}
+
+    # Compute [r-IV0*1, r-IV0*x, r-IV0*x^2, r-IV0*x^3, ...] in v16
+    @{[vsetvli "zero", $LEN32, "e32", "m4", "ta", "ma"]}
+    @{[vbrev8_v $V8, $V8]}
+    @{[vgmul_vv $V16, $V8]}
+
+    # Compute [IV0*1, IV0*x, IV0*x^2, IV0*x^3, ...] in v28.
+    # Reverse the bits order back.
+    @{[vbrev8_v $V28, $V16]}
+
+    # Prepare the x^n multiplier in v20. The `n` is the aes-xts block number
+    # in a LMUL=4 register group.
+    #   n = ((VLEN*LMUL)/(32*4)) = ((VLEN*4)/(32*4))
+    #     = (VLEN/32)
+    # We could use vsetvli with `e32, m1` to compute the `n` number.
+    @{[vsetvli $T0, "zero", "e32", "m1", "ta", "ma"]}
+    li $T1, 1
+    sll $T0, $T1, $T0
+    @{[vsetivli "zero", 2, "e64", "m1", "ta", "ma"]}
+    @{[vmv_v_i $V0, 0]}
+    @{[vsetivli "zero", 1, "e64", "m1", "tu", "ma"]}
+    @{[vmv_v_x $V0, $T0]}
+    @{[vsetivli "zero", 2, "e64", "m1", "ta", "ma"]}
+    @{[vbrev8_v $V0, $V0]}
+    @{[vsetvli "zero", $LEN32, "e32", "m4", "ta", "ma"]}
+    @{[vmv_v_i $V20, 0]}
+    @{[vaesz_vs $V20, $V0]}
+
+    j 2f
+1:
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vbrev8_v $V16, $V28]}
+2:
+___
+
+    return $code;
+}
+
+# prepare xts enc last block's input(v24) and iv(v28)
+sub handle_xts_enc_last_block {
+    my $code=<<___;
+    bnez $TAIL_LENGTH, 2f
+
+    beqz $UPDATE_IV, 1f
+    ## Store next IV
+    addi $VL, $VL, -4
+    @{[vsetivli "zero", 4, "e32", "m4", "ta", "ma"]}
+    # multiplier
+    @{[vslidedown_vx $V16, $V16, $VL]}
+
+    # setup `x` multiplier with byte-reversed order
+    # 0b00000010 => 0b01000000 (0x40)
+    li $T0, 0x40
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vmv_v_i $V28, 0]}
+    @{[vsetivli "zero", 1, "e8", "m1", "tu", "ma"]}
+    @{[vmv_v_x $V28, $T0]}
+
+    # IV * `x`
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vgmul_vv $V16, $V28]}
+    # Reverse the IV's bits order back to big-endian
+    @{[vbrev8_v $V28, $V16]}
+
+    @{[vse32_v $V28, $IV]}
+1:
+
+    ret
+2:
+    # slidedown second to last block
+    addi $VL, $VL, -4
+    @{[vsetivli "zero", 4, "e32", "m4", "ta", "ma"]}
+    # ciphertext
+    @{[vslidedown_vx $V24, $V24, $VL]}
+    # multiplier
+    @{[vslidedown_vx $V16, $V16, $VL]}
+
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vmv_v_v $V25, $V24]}
+
+    # load last block into v24
+    # note: We should load the last block before store the second to last block
+    #       for in-place operation.
+    @{[vsetvli "zero", $TAIL_LENGTH, "e8", "m1", "tu", "ma"]}
+    @{[vle8_v $V24, $INPUT]}
+
+    # setup `x` multiplier with byte-reversed order
+    # 0b00000010 => 0b01000000 (0x40)
+    li $T0, 0x40
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vmv_v_i $V28, 0]}
+    @{[vsetivli "zero", 1, "e8", "m1", "tu", "ma"]}
+    @{[vmv_v_x $V28, $T0]}
+
+    # compute IV for last block
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vgmul_vv $V16, $V28]}
+    @{[vbrev8_v $V28, $V16]}
+
+    # store second to last block
+    @{[vsetvli "zero", $TAIL_LENGTH, "e8", "m1", "ta", "ma"]}
+    @{[vse8_v $V25, $OUTPUT]}
+___
+
+    return $code;
+}
+
+# prepare xts dec second to last block's input(v24) and iv(v29) and
+# last block's and iv(v28)
+sub handle_xts_dec_last_block {
+    my $code=<<___;
+    bnez $TAIL_LENGTH, 2f
+
+    beqz $UPDATE_IV, 1f
+    ## Store next IV
+    # setup `x` multiplier with byte-reversed order
+    # 0b00000010 => 0b01000000 (0x40)
+    li $T0, 0x40
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vmv_v_i $V28, 0]}
+    @{[vsetivli "zero", 1, "e8", "m1", "tu", "ma"]}
+    @{[vmv_v_x $V28, $T0]}
+
+    beqz $LENGTH, 3f
+    addi $VL, $VL, -4
+    @{[vsetivli "zero", 4, "e32", "m4", "ta", "ma"]}
+    # multiplier
+    @{[vslidedown_vx $V16, $V16, $VL]}
+
+3:
+    # IV * `x`
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vgmul_vv $V16, $V28]}
+    # Reverse the IV's bits order back to big-endian
+    @{[vbrev8_v $V28, $V16]}
+
+    @{[vse32_v $V28, $IV]}
+1:
+
+    ret
+2:
+    # load second to last block's ciphertext
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vle32_v $V24, $INPUT]}
+    addi $INPUT, $INPUT, 16
+
+    # setup `x` multiplier with byte-reversed order
+    # 0b00000010 => 0b01000000 (0x40)
+    li $T0, 0x40
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vmv_v_i $V20, 0]}
+    @{[vsetivli "zero", 1, "e8", "m1", "tu", "ma"]}
+    @{[vmv_v_x $V20, $T0]}
+
+    beqz $LENGTH, 1f
+    # slidedown third to last block
+    addi $VL, $VL, -4
+    @{[vsetivli "zero", 4, "e32", "m4", "ta", "ma"]}
+    # multiplier
+    @{[vslidedown_vx $V16, $V16, $VL]}
+
+    # compute IV for last block
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vgmul_vv $V16, $V20]}
+    @{[vbrev8_v $V28, $V16]}
+
+    # compute IV for second to last block
+    @{[vgmul_vv $V16, $V20]}
+    @{[vbrev8_v $V29, $V16]}
+    j 2f
+1:
+    # compute IV for second to last block
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vgmul_vv $V16, $V20]}
+    @{[vbrev8_v $V29, $V16]}
+2:
+___
+
+    return $code;
+}
+
+# Load all 11 round keys to v1-v11 registers.
+sub aes_128_load_key {
+    my $code=<<___;
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vle32_v $V1, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V2, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V3, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V4, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V5, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V6, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V7, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V8, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V9, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V10, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V11, $KEY]}
+___
+
+    return $code;
+}
+
+# Load all 13 round keys to v1-v13 registers.
+sub aes_192_load_key {
+    my $code=<<___;
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vle32_v $V1, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V2, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V3, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V4, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V5, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V6, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V7, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V8, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V9, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V10, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V11, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V12, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V13, $KEY]}
+___
+
+    return $code;
+}
+
+# Load all 15 round keys to v1-v15 registers.
+sub aes_256_load_key {
+    my $code=<<___;
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vle32_v $V1, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V2, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V3, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V4, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V5, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V6, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V7, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V8, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V9, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V10, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V11, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V12, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V13, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V14, $KEY]}
+    addi $KEY, $KEY, 16
+    @{[vle32_v $V15, $KEY]}
+___
+
+    return $code;
+}
+
+# aes-128 enc with round keys v1-v11
+sub aes_128_enc {
+    my $code=<<___;
+    @{[vaesz_vs $V24, $V1]}
+    @{[vaesem_vs $V24, $V2]}
+    @{[vaesem_vs $V24, $V3]}
+    @{[vaesem_vs $V24, $V4]}
+    @{[vaesem_vs $V24, $V5]}
+    @{[vaesem_vs $V24, $V6]}
+    @{[vaesem_vs $V24, $V7]}
+    @{[vaesem_vs $V24, $V8]}
+    @{[vaesem_vs $V24, $V9]}
+    @{[vaesem_vs $V24, $V10]}
+    @{[vaesef_vs $V24, $V11]}
+___
+
+    return $code;
+}
+
+# aes-128 dec with round keys v1-v11
+sub aes_128_dec {
+    my $code=<<___;
+    @{[vaesz_vs $V24, $V11]}
+    @{[vaesdm_vs $V24, $V10]}
+    @{[vaesdm_vs $V24, $V9]}
+    @{[vaesdm_vs $V24, $V8]}
+    @{[vaesdm_vs $V24, $V7]}
+    @{[vaesdm_vs $V24, $V6]}
+    @{[vaesdm_vs $V24, $V5]}
+    @{[vaesdm_vs $V24, $V4]}
+    @{[vaesdm_vs $V24, $V3]}
+    @{[vaesdm_vs $V24, $V2]}
+    @{[vaesdf_vs $V24, $V1]}
+___
+
+    return $code;
+}
+
+# aes-192 enc with round keys v1-v13
+sub aes_192_enc {
+    my $code=<<___;
+    @{[vaesz_vs $V24, $V1]}
+    @{[vaesem_vs $V24, $V2]}
+    @{[vaesem_vs $V24, $V3]}
+    @{[vaesem_vs $V24, $V4]}
+    @{[vaesem_vs $V24, $V5]}
+    @{[vaesem_vs $V24, $V6]}
+    @{[vaesem_vs $V24, $V7]}
+    @{[vaesem_vs $V24, $V8]}
+    @{[vaesem_vs $V24, $V9]}
+    @{[vaesem_vs $V24, $V10]}
+    @{[vaesem_vs $V24, $V11]}
+    @{[vaesem_vs $V24, $V12]}
+    @{[vaesef_vs $V24, $V13]}
+___
+
+    return $code;
+}
+
+# aes-192 dec with round keys v1-v13
+sub aes_192_dec {
+    my $code=<<___;
+    @{[vaesz_vs $V24, $V13]}
+    @{[vaesdm_vs $V24, $V12]}
+    @{[vaesdm_vs $V24, $V11]}
+    @{[vaesdm_vs $V24, $V10]}
+    @{[vaesdm_vs $V24, $V9]}
+    @{[vaesdm_vs $V24, $V8]}
+    @{[vaesdm_vs $V24, $V7]}
+    @{[vaesdm_vs $V24, $V6]}
+    @{[vaesdm_vs $V24, $V5]}
+    @{[vaesdm_vs $V24, $V4]}
+    @{[vaesdm_vs $V24, $V3]}
+    @{[vaesdm_vs $V24, $V2]}
+    @{[vaesdf_vs $V24, $V1]}
+___
+
+    return $code;
+}
+
+# aes-256 enc with round keys v1-v15
+sub aes_256_enc {
+    my $code=<<___;
+    @{[vaesz_vs $V24, $V1]}
+    @{[vaesem_vs $V24, $V2]}
+    @{[vaesem_vs $V24, $V3]}
+    @{[vaesem_vs $V24, $V4]}
+    @{[vaesem_vs $V24, $V5]}
+    @{[vaesem_vs $V24, $V6]}
+    @{[vaesem_vs $V24, $V7]}
+    @{[vaesem_vs $V24, $V8]}
+    @{[vaesem_vs $V24, $V9]}
+    @{[vaesem_vs $V24, $V10]}
+    @{[vaesem_vs $V24, $V11]}
+    @{[vaesem_vs $V24, $V12]}
+    @{[vaesem_vs $V24, $V13]}
+    @{[vaesem_vs $V24, $V14]}
+    @{[vaesef_vs $V24, $V15]}
+___
+
+    return $code;
+}
+
+# aes-256 dec with round keys v1-v15
+sub aes_256_dec {
+    my $code=<<___;
+    @{[vaesz_vs $V24, $V15]}
+    @{[vaesdm_vs $V24, $V14]}
+    @{[vaesdm_vs $V24, $V13]}
+    @{[vaesdm_vs $V24, $V12]}
+    @{[vaesdm_vs $V24, $V11]}
+    @{[vaesdm_vs $V24, $V10]}
+    @{[vaesdm_vs $V24, $V9]}
+    @{[vaesdm_vs $V24, $V8]}
+    @{[vaesdm_vs $V24, $V7]}
+    @{[vaesdm_vs $V24, $V6]}
+    @{[vaesdm_vs $V24, $V5]}
+    @{[vaesdm_vs $V24, $V4]}
+    @{[vaesdm_vs $V24, $V3]}
+    @{[vaesdm_vs $V24, $V2]}
+    @{[vaesdf_vs $V24, $V1]}
+___
+
+    return $code;
+}
+
+$code .= <<___;
+.p2align 3
+.globl rv64i_zvbb_zvkg_zvkned_aes_xts_encrypt
+.type rv64i_zvbb_zvkg_zvkned_aes_xts_encrypt,\@function
+rv64i_zvbb_zvkg_zvkned_aes_xts_encrypt:
+    @{[load_xts_iv0]}
+
+    # aes block size is 16
+    andi $TAIL_LENGTH, $LENGTH, 15
+    mv $STORE_LEN32, $LENGTH
+    beqz $TAIL_LENGTH, 1f
+    sub $LENGTH, $LENGTH, $TAIL_LENGTH
+    addi $STORE_LEN32, $LENGTH, -16
+1:
+    # We make the `LENGTH` become e32 length here.
+    srli $LEN32, $LENGTH, 2
+    srli $STORE_LEN32, $STORE_LEN32, 2
+
+    # Load key length.
+    lwu $T0, 480($KEY)
+    li $T1, 32
+    li $T2, 24
+    li $T3, 16
+    beq $T0, $T1, aes_xts_enc_256
+    beq $T0, $T2, aes_xts_enc_192
+    beq $T0, $T3, aes_xts_enc_128
+.size rv64i_zvbb_zvkg_zvkned_aes_xts_encrypt,.-rv64i_zvbb_zvkg_zvkned_aes_xts_encrypt
+___
+
+$code .= <<___;
+.p2align 3
+aes_xts_enc_128:
+    @{[init_first_round]}
+    @{[aes_128_load_key]}
+
+    @{[vsetvli $VL, $LEN32, "e32", "m4", "ta", "ma"]}
+    j 1f
+
+.Lenc_blocks_128:
+    @{[vsetvli $VL, $LEN32, "e32", "m4", "ta", "ma"]}
+    # load plaintext into v24
+    @{[vle32_v $V24, $INPUT]}
+    # update iv
+    @{[vgmul_vv $V16, $V20]}
+    # reverse the iv's bits order back
+    @{[vbrev8_v $V28, $V16]}
+1:
+    @{[vxor_vv $V24, $V24, $V28]}
+    slli $T0, $VL, 2
+    sub $LEN32, $LEN32, $VL
+    add $INPUT, $INPUT, $T0
+    @{[aes_128_enc]}
+    @{[vxor_vv $V24, $V24, $V28]}
+
+    # store ciphertext
+    @{[vsetvli "zero", $STORE_LEN32, "e32", "m4", "ta", "ma"]}
+    @{[vse32_v $V24, $OUTPUT]}
+    add $OUTPUT, $OUTPUT, $T0
+    sub $STORE_LEN32, $STORE_LEN32, $VL
+
+    bnez $LEN32, .Lenc_blocks_128
+
+    @{[handle_xts_enc_last_block]}
+
+    # xts last block
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vxor_vv $V24, $V24, $V28]}
+    @{[aes_128_enc]}
+    @{[vxor_vv $V24, $V24, $V28]}
+
+    # store last block ciphertext
+    addi $OUTPUT, $OUTPUT, -16
+    @{[vse32_v $V24, $OUTPUT]}
+
+    ret
+.size aes_xts_enc_128,.-aes_xts_enc_128
+___
+
+$code .= <<___;
+.p2align 3
+aes_xts_enc_192:
+    @{[init_first_round]}
+    @{[aes_192_load_key]}
+
+    @{[vsetvli $VL, $LEN32, "e32", "m4", "ta", "ma"]}
+    j 1f
+
+.Lenc_blocks_192:
+    @{[vsetvli $VL, $LEN32, "e32", "m4", "ta", "ma"]}
+    # load plaintext into v24
+    @{[vle32_v $V24, $INPUT]}
+    # update iv
+    @{[vgmul_vv $V16, $V20]}
+    # reverse the iv's bits order back
+    @{[vbrev8_v $V28, $V16]}
+1:
+    @{[vxor_vv $V24, $V24, $V28]}
+    slli $T0, $VL, 2
+    sub $LEN32, $LEN32, $VL
+    add $INPUT, $INPUT, $T0
+    @{[aes_192_enc]}
+    @{[vxor_vv $V24, $V24, $V28]}
+
+    # store ciphertext
+    @{[vsetvli "zero", $STORE_LEN32, "e32", "m4", "ta", "ma"]}
+    @{[vse32_v $V24, $OUTPUT]}
+    add $OUTPUT, $OUTPUT, $T0
+    sub $STORE_LEN32, $STORE_LEN32, $VL
+
+    bnez $LEN32, .Lenc_blocks_192
+
+    @{[handle_xts_enc_last_block]}
+
+    # xts last block
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vxor_vv $V24, $V24, $V28]}
+    @{[aes_192_enc]}
+    @{[vxor_vv $V24, $V24, $V28]}
+
+    # store last block ciphertext
+    addi $OUTPUT, $OUTPUT, -16
+    @{[vse32_v $V24, $OUTPUT]}
+
+    ret
+.size aes_xts_enc_192,.-aes_xts_enc_192
+___
+
+$code .= <<___;
+.p2align 3
+aes_xts_enc_256:
+    @{[init_first_round]}
+    @{[aes_256_load_key]}
+
+    @{[vsetvli $VL, $LEN32, "e32", "m4", "ta", "ma"]}
+    j 1f
+
+.Lenc_blocks_256:
+    @{[vsetvli $VL, $LEN32, "e32", "m4", "ta", "ma"]}
+    # load plaintext into v24
+    @{[vle32_v $V24, $INPUT]}
+    # update iv
+    @{[vgmul_vv $V16, $V20]}
+    # reverse the iv's bits order back
+    @{[vbrev8_v $V28, $V16]}
+1:
+    @{[vxor_vv $V24, $V24, $V28]}
+    slli $T0, $VL, 2
+    sub $LEN32, $LEN32, $VL
+    add $INPUT, $INPUT, $T0
+    @{[aes_256_enc]}
+    @{[vxor_vv $V24, $V24, $V28]}
+
+    # store ciphertext
+    @{[vsetvli "zero", $STORE_LEN32, "e32", "m4", "ta", "ma"]}
+    @{[vse32_v $V24, $OUTPUT]}
+    add $OUTPUT, $OUTPUT, $T0
+    sub $STORE_LEN32, $STORE_LEN32, $VL
+
+    bnez $LEN32, .Lenc_blocks_256
+
+    @{[handle_xts_enc_last_block]}
+
+    # xts last block
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vxor_vv $V24, $V24, $V28]}
+    @{[aes_256_enc]}
+    @{[vxor_vv $V24, $V24, $V28]}
+
+    # store last block ciphertext
+    addi $OUTPUT, $OUTPUT, -16
+    @{[vse32_v $V24, $OUTPUT]}
+
+    ret
+.size aes_xts_enc_256,.-aes_xts_enc_256
+___
+
+################################################################################
+# void rv64i_zvbb_zvkg_zvkned_aes_xts_decrypt(const unsigned char *in,
+#                                             unsigned char *out, size_t length,
+#                                             const AES_KEY *key,
+#                                             unsigned char iv[16],
+#                                             int update_iv)
+$code .= <<___;
+.p2align 3
+.globl rv64i_zvbb_zvkg_zvkned_aes_xts_decrypt
+.type rv64i_zvbb_zvkg_zvkned_aes_xts_decrypt,\@function
+rv64i_zvbb_zvkg_zvkned_aes_xts_decrypt:
+    @{[load_xts_iv0]}
+
+    # aes block size is 16
+    andi $TAIL_LENGTH, $LENGTH, 15
+    beqz $TAIL_LENGTH, 1f
+    sub $LENGTH, $LENGTH, $TAIL_LENGTH
+    addi $LENGTH, $LENGTH, -16
+1:
+    # We make the `LENGTH` become e32 length here.
+    srli $LEN32, $LENGTH, 2
+
+    # Load key length.
+    lwu $T0, 480($KEY)
+    li $T1, 32
+    li $T2, 24
+    li $T3, 16
+    beq $T0, $T1, aes_xts_dec_256
+    beq $T0, $T2, aes_xts_dec_192
+    beq $T0, $T3, aes_xts_dec_128
+.size rv64i_zvbb_zvkg_zvkned_aes_xts_decrypt,.-rv64i_zvbb_zvkg_zvkned_aes_xts_decrypt
+___
+
+$code .= <<___;
+.p2align 3
+aes_xts_dec_128:
+    @{[init_first_round]}
+    @{[aes_128_load_key]}
+
+    beqz $LEN32, 2f
+
+    @{[vsetvli $VL, $LEN32, "e32", "m4", "ta", "ma"]}
+    j 1f
+
+.Ldec_blocks_128:
+    @{[vsetvli $VL, $LEN32, "e32", "m4", "ta", "ma"]}
+    # load ciphertext into v24
+    @{[vle32_v $V24, $INPUT]}
+    # update iv
+    @{[vgmul_vv $V16, $V20]}
+    # reverse the iv's bits order back
+    @{[vbrev8_v $V28, $V16]}
+1:
+    @{[vxor_vv $V24, $V24, $V28]}
+    slli $T0, $VL, 2
+    sub $LEN32, $LEN32, $VL
+    add $INPUT, $INPUT, $T0
+    @{[aes_128_dec]}
+    @{[vxor_vv $V24, $V24, $V28]}
+
+    # store plaintext
+    @{[vse32_v $V24, $OUTPUT]}
+    add $OUTPUT, $OUTPUT, $T0
+
+    bnez $LEN32, .Ldec_blocks_128
+
+2:
+    @{[handle_xts_dec_last_block]}
+
+    ## xts second to last block
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vxor_vv $V24, $V24, $V29]}
+    @{[aes_128_dec]}
+    @{[vxor_vv $V24, $V24, $V29]}
+    @{[vmv_v_v $V25, $V24]}
+
+    # load last block ciphertext
+    @{[vsetvli "zero", $TAIL_LENGTH, "e8", "m1", "tu", "ma"]}
+    @{[vle8_v $V24, $INPUT]}
+
+    # store second to last block plaintext
+    addi $T0, $OUTPUT, 16
+    @{[vse8_v $V25, $T0]}
+
+    ## xts last block
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vxor_vv $V24, $V24, $V28]}
+    @{[aes_128_dec]}
+    @{[vxor_vv $V24, $V24, $V28]}
+
+    # store second to last block plaintext
+    @{[vse32_v $V24, $OUTPUT]}
+
+    ret
+.size aes_xts_dec_128,.-aes_xts_dec_128
+___
+
+$code .= <<___;
+.p2align 3
+aes_xts_dec_192:
+    @{[init_first_round]}
+    @{[aes_192_load_key]}
+
+    beqz $LEN32, 2f
+
+    @{[vsetvli $VL, $LEN32, "e32", "m4", "ta", "ma"]}
+    j 1f
+
+.Ldec_blocks_192:
+    @{[vsetvli $VL, $LEN32, "e32", "m4", "ta", "ma"]}
+    # load ciphertext into v24
+    @{[vle32_v $V24, $INPUT]}
+    # update iv
+    @{[vgmul_vv $V16, $V20]}
+    # reverse the iv's bits order back
+    @{[vbrev8_v $V28, $V16]}
+1:
+    @{[vxor_vv $V24, $V24, $V28]}
+    slli $T0, $VL, 2
+    sub $LEN32, $LEN32, $VL
+    add $INPUT, $INPUT, $T0
+    @{[aes_192_dec]}
+    @{[vxor_vv $V24, $V24, $V28]}
+
+    # store plaintext
+    @{[vse32_v $V24, $OUTPUT]}
+    add $OUTPUT, $OUTPUT, $T0
+
+    bnez $LEN32, .Ldec_blocks_192
+
+2:
+    @{[handle_xts_dec_last_block]}
+
+    ## xts second to last block
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vxor_vv $V24, $V24, $V29]}
+    @{[aes_192_dec]}
+    @{[vxor_vv $V24, $V24, $V29]}
+    @{[vmv_v_v $V25, $V24]}
+
+    # load last block ciphertext
+    @{[vsetvli "zero", $TAIL_LENGTH, "e8", "m1", "tu", "ma"]}
+    @{[vle8_v $V24, $INPUT]}
+
+    # store second to last block plaintext
+    addi $T0, $OUTPUT, 16
+    @{[vse8_v $V25, $T0]}
+
+    ## xts last block
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vxor_vv $V24, $V24, $V28]}
+    @{[aes_192_dec]}
+    @{[vxor_vv $V24, $V24, $V28]}
+
+    # store second to last block plaintext
+    @{[vse32_v $V24, $OUTPUT]}
+
+    ret
+.size aes_xts_dec_192,.-aes_xts_dec_192
+___
+
+$code .= <<___;
+.p2align 3
+aes_xts_dec_256:
+    @{[init_first_round]}
+    @{[aes_256_load_key]}
+
+    beqz $LEN32, 2f
+
+    @{[vsetvli $VL, $LEN32, "e32", "m4", "ta", "ma"]}
+    j 1f
+
+.Ldec_blocks_256:
+    @{[vsetvli $VL, $LEN32, "e32", "m4", "ta", "ma"]}
+    # load ciphertext into v24
+    @{[vle32_v $V24, $INPUT]}
+    # update iv
+    @{[vgmul_vv $V16, $V20]}
+    # reverse the iv's bits order back
+    @{[vbrev8_v $V28, $V16]}
+1:
+    @{[vxor_vv $V24, $V24, $V28]}
+    slli $T0, $VL, 2
+    sub $LEN32, $LEN32, $VL
+    add $INPUT, $INPUT, $T0
+    @{[aes_256_dec]}
+    @{[vxor_vv $V24, $V24, $V28]}
+
+    # store plaintext
+    @{[vse32_v $V24, $OUTPUT]}
+    add $OUTPUT, $OUTPUT, $T0
+
+    bnez $LEN32, .Ldec_blocks_256
+
+2:
+    @{[handle_xts_dec_last_block]}
+
+    ## xts second to last block
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vxor_vv $V24, $V24, $V29]}
+    @{[aes_256_dec]}
+    @{[vxor_vv $V24, $V24, $V29]}
+    @{[vmv_v_v $V25, $V24]}
+
+    # load last block ciphertext
+    @{[vsetvli "zero", $TAIL_LENGTH, "e8", "m1", "tu", "ma"]}
+    @{[vle8_v $V24, $INPUT]}
+
+    # store second to last block plaintext
+    addi $T0, $OUTPUT, 16
+    @{[vse8_v $V25, $T0]}
+
+    ## xts last block
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vxor_vv $V24, $V24, $V28]}
+    @{[aes_256_dec]}
+    @{[vxor_vv $V24, $V24, $V28]}
+
+    # store second to last block plaintext
+    @{[vse32_v $V24, $OUTPUT]}
+
+    ret
+.size aes_xts_dec_256,.-aes_xts_dec_256
+___
+}
+
+print $code;
+
+close STDOUT or die "error closing STDOUT: $!";
diff --git a/arch/riscv/crypto/aes-riscv64-zvkned-zvkb.pl b/arch/riscv/crypto/aes-riscv64-zvkned-zvkb.pl
new file mode 100644
index 000000000000..3b8c324bc4d5
--- /dev/null
+++ b/arch/riscv/crypto/aes-riscv64-zvkned-zvkb.pl
@@ -0,0 +1,415 @@
+#! /usr/bin/env perl
+# SPDX-License-Identifier: Apache-2.0 OR BSD-2-Clause
+#
+# This file is dual-licensed, meaning that you can use it under your
+# choice of either of the following two licenses:
+#
+# Copyright 2023 The OpenSSL Project Authors. All Rights Reserved.
+#
+# Licensed under the Apache License 2.0 (the "License"). You can obtain
+# a copy in the file LICENSE in the source distribution or at
+# https://www.openssl.org/source/license.html
+#
+# or
+#
+# Copyright (c) 2023, Jerry Shih <jerry.shih@sifive.com>
+# All rights reserved.
+#
+# Redistribution and use in source and binary forms, with or without
+# modification, are permitted provided that the following conditions
+# are met:
+# 1. Redistributions of source code must retain the above copyright
+#    notice, this list of conditions and the following disclaimer.
+# 2. Redistributions in binary form must reproduce the above copyright
+#    notice, this list of conditions and the following disclaimer in the
+#    documentation and/or other materials provided with the distribution.
+#
+# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+
+# - RV64I
+# - RISC-V Vector ('V') with VLEN >= 128
+# - RISC-V Vector Cryptography Bit-manipulation extension ('Zvkb')
+# - RISC-V Vector AES block cipher extension ('Zvkned')
+
+use strict;
+use warnings;
+
+use FindBin qw($Bin);
+use lib "$Bin";
+use lib "$Bin/../../perlasm";
+use riscv;
+
+# $output is the last argument if it looks like a file (it has an extension)
+# $flavour is the first argument if it doesn't look like a file
+my $output = $#ARGV >= 0 && $ARGV[$#ARGV] =~ m|\.\w+$| ? pop : undef;
+my $flavour = $#ARGV >= 0 && $ARGV[0] !~ m|\.| ? shift : undef;
+
+$output and open STDOUT,">$output";
+
+my $code=<<___;
+.text
+___
+
+################################################################################
+# void rv64i_zvkb_zvkned_ctr32_encrypt_blocks(const unsigned char *in,
+#                                             unsigned char *out, size_t length,
+#                                             const void *key,
+#                                             unsigned char ivec[16]);
+{
+my ($INP, $OUTP, $LEN, $KEYP, $IVP) = ("a0", "a1", "a2", "a3", "a4");
+my ($T0, $T1, $T2, $T3) = ("t0", "t1", "t2", "t3");
+my ($VL) = ("t4");
+my ($LEN32) = ("t5");
+my ($CTR) = ("t6");
+my ($MASK) = ("v0");
+my ($V0, $V1, $V2, $V3, $V4, $V5, $V6, $V7,
+    $V8, $V9, $V10, $V11, $V12, $V13, $V14, $V15,
+    $V16, $V17, $V18, $V19, $V20, $V21, $V22, $V23,
+    $V24, $V25, $V26, $V27, $V28, $V29, $V30, $V31,
+) = map("v$_",(0..31));
+
+# Prepare the AES ctr input data into v16.
+sub init_aes_ctr_input {
+    my $code=<<___;
+    # Setup mask into v0
+    # The mask pattern for 4*N-th elements
+    # mask v0: [000100010001....]
+    # Note:
+    #   We could setup the mask just for the maximum element length instead of
+    #   the VLMAX.
+    li $T0, 0b10001000
+    @{[vsetvli $T2, "zero", "e8", "m1", "ta", "ma"]}
+    @{[vmv_v_x $MASK, $T0]}
+    # Load IV.
+    # v31:[IV0, IV1, IV2, big-endian count]
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vle32_v $V31, $IVP]}
+    # Convert the big-endian counter into little-endian.
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "mu"]}
+    @{[vrev8_v $V31, $V31, $MASK]}
+    # Splat the IV to v16
+    @{[vsetvli "zero", $LEN32, "e32", "m4", "ta", "ma"]}
+    @{[vmv_v_i $V16, 0]}
+    @{[vaesz_vs $V16, $V31]}
+    # Prepare the ctr pattern into v20
+    # v20: [x, x, x, 0, x, x, x, 1, x, x, x, 2, ...]
+    @{[viota_m $V20, $MASK, $MASK]}
+    # v16:[IV0, IV1, IV2, count+0, IV0, IV1, IV2, count+1, ...]
+    @{[vsetvli $VL, $LEN32, "e32", "m4", "ta", "mu"]}
+    @{[vadd_vv $V16, $V16, $V20, $MASK]}
+___
+
+    return $code;
+}
+
+$code .= <<___;
+.p2align 3
+.globl rv64i_zvkb_zvkned_ctr32_encrypt_blocks
+.type rv64i_zvkb_zvkned_ctr32_encrypt_blocks,\@function
+rv64i_zvkb_zvkned_ctr32_encrypt_blocks:
+    # The aes block size is 16 bytes.
+    # We try to get the minimum aes block number including the tail data.
+    addi $T0, $LEN, 15
+    # the minimum block number
+    srli $T0, $T0, 4
+    # We make the block number become e32 length here.
+    slli $LEN32, $T0, 2
+
+    # Load key length.
+    lwu $T0, 480($KEYP)
+    li $T1, 32
+    li $T2, 24
+    li $T3, 16
+
+    beq $T0, $T1, ctr32_encrypt_blocks_256
+    beq $T0, $T2, ctr32_encrypt_blocks_192
+    beq $T0, $T3, ctr32_encrypt_blocks_128
+
+    ret
+.size rv64i_zvkb_zvkned_ctr32_encrypt_blocks,.-rv64i_zvkb_zvkned_ctr32_encrypt_blocks
+___
+
+$code .= <<___;
+.p2align 3
+ctr32_encrypt_blocks_128:
+    # Load all 11 round keys to v1-v11 registers.
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vle32_v $V1, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V2, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V3, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V4, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V5, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V6, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V7, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V8, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V9, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V10, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V11, $KEYP]}
+
+    @{[init_aes_ctr_input]}
+
+    ##### AES body
+    j 2f
+1:
+    @{[vsetvli $VL, $LEN32, "e32", "m4", "ta", "mu"]}
+    # Increase ctr in v16.
+    @{[vadd_vx $V16, $V16, $CTR, $MASK]}
+2:
+    # Prepare the AES ctr input into v24.
+    # The ctr data uses big-endian form.
+    @{[vmv_v_v $V24, $V16]}
+    @{[vrev8_v $V24, $V24, $MASK]}
+    srli $CTR, $VL, 2
+    sub $LEN32, $LEN32, $VL
+
+    # Load plaintext in bytes into v20.
+    @{[vsetvli $T0, $LEN, "e8", "m4", "ta", "ma"]}
+    @{[vle8_v $V20, $INP]}
+    sub $LEN, $LEN, $T0
+    add $INP, $INP, $T0
+
+    @{[vsetvli "zero", $VL, "e32", "m4", "ta", "ma"]}
+    @{[vaesz_vs $V24, $V1]}
+    @{[vaesem_vs $V24, $V2]}
+    @{[vaesem_vs $V24, $V3]}
+    @{[vaesem_vs $V24, $V4]}
+    @{[vaesem_vs $V24, $V5]}
+    @{[vaesem_vs $V24, $V6]}
+    @{[vaesem_vs $V24, $V7]}
+    @{[vaesem_vs $V24, $V8]}
+    @{[vaesem_vs $V24, $V9]}
+    @{[vaesem_vs $V24, $V10]}
+    @{[vaesef_vs $V24, $V11]}
+
+    # ciphertext
+    @{[vsetvli "zero", $T0, "e8", "m4", "ta", "ma"]}
+    @{[vxor_vv $V24, $V24, $V20]}
+
+    # Store the ciphertext.
+    @{[vse8_v $V24, $OUTP]}
+    add $OUTP, $OUTP, $T0
+
+    bnez $LEN, 1b
+
+    ## store ctr iv
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "mu"]}
+    # Increase ctr in v16.
+    @{[vadd_vx $V16, $V16, $CTR, $MASK]}
+    # Convert ctr data back to big-endian.
+    @{[vrev8_v $V16, $V16, $MASK]}
+    @{[vse32_v $V16, $IVP]}
+
+    ret
+.size ctr32_encrypt_blocks_128,.-ctr32_encrypt_blocks_128
+___
+
+$code .= <<___;
+.p2align 3
+ctr32_encrypt_blocks_192:
+    # Load all 13 round keys to v1-v13 registers.
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vle32_v $V1, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V2, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V3, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V4, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V5, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V6, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V7, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V8, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V9, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V10, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V11, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V12, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V13, $KEYP]}
+
+    @{[init_aes_ctr_input]}
+
+    ##### AES body
+    j 2f
+1:
+    @{[vsetvli $VL, $LEN32, "e32", "m4", "ta", "mu"]}
+    # Increase ctr in v16.
+    @{[vadd_vx $V16, $V16, $CTR, $MASK]}
+2:
+    # Prepare the AES ctr input into v24.
+    # The ctr data uses big-endian form.
+    @{[vmv_v_v $V24, $V16]}
+    @{[vrev8_v $V24, $V24, $MASK]}
+    srli $CTR, $VL, 2
+    sub $LEN32, $LEN32, $VL
+
+    # Load plaintext in bytes into v20.
+    @{[vsetvli $T0, $LEN, "e8", "m4", "ta", "ma"]}
+    @{[vle8_v $V20, $INP]}
+    sub $LEN, $LEN, $T0
+    add $INP, $INP, $T0
+
+    @{[vsetvli "zero", $VL, "e32", "m4", "ta", "ma"]}
+    @{[vaesz_vs $V24, $V1]}
+    @{[vaesem_vs $V24, $V2]}
+    @{[vaesem_vs $V24, $V3]}
+    @{[vaesem_vs $V24, $V4]}
+    @{[vaesem_vs $V24, $V5]}
+    @{[vaesem_vs $V24, $V6]}
+    @{[vaesem_vs $V24, $V7]}
+    @{[vaesem_vs $V24, $V8]}
+    @{[vaesem_vs $V24, $V9]}
+    @{[vaesem_vs $V24, $V10]}
+    @{[vaesem_vs $V24, $V11]}
+    @{[vaesem_vs $V24, $V12]}
+    @{[vaesef_vs $V24, $V13]}
+
+    # ciphertext
+    @{[vsetvli "zero", $T0, "e8", "m4", "ta", "ma"]}
+    @{[vxor_vv $V24, $V24, $V20]}
+
+    # Store the ciphertext.
+    @{[vse8_v $V24, $OUTP]}
+    add $OUTP, $OUTP, $T0
+
+    bnez $LEN, 1b
+
+    ## store ctr iv
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "mu"]}
+    # Increase ctr in v16.
+    @{[vadd_vx $V16, $V16, $CTR, $MASK]}
+    # Convert ctr data back to big-endian.
+    @{[vrev8_v $V16, $V16, $MASK]}
+    @{[vse32_v $V16, $IVP]}
+
+    ret
+.size ctr32_encrypt_blocks_192,.-ctr32_encrypt_blocks_192
+___
+
+$code .= <<___;
+.p2align 3
+ctr32_encrypt_blocks_256:
+    # Load all 15 round keys to v1-v15 registers.
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vle32_v $V1, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V2, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V3, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V4, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V5, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V6, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V7, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V8, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V9, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V10, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V11, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V12, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V13, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V14, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V15, $KEYP]}
+
+    @{[init_aes_ctr_input]}
+
+    ##### AES body
+    j 2f
+1:
+    @{[vsetvli $VL, $LEN32, "e32", "m4", "ta", "mu"]}
+    # Increase ctr in v16.
+    @{[vadd_vx $V16, $V16, $CTR, $MASK]}
+2:
+    # Prepare the AES ctr input into v24.
+    # The ctr data uses big-endian form.
+    @{[vmv_v_v $V24, $V16]}
+    @{[vrev8_v $V24, $V24, $MASK]}
+    srli $CTR, $VL, 2
+    sub $LEN32, $LEN32, $VL
+
+    # Load plaintext in bytes into v20.
+    @{[vsetvli $T0, $LEN, "e8", "m4", "ta", "ma"]}
+    @{[vle8_v $V20, $INP]}
+    sub $LEN, $LEN, $T0
+    add $INP, $INP, $T0
+
+    @{[vsetvli "zero", $VL, "e32", "m4", "ta", "ma"]}
+    @{[vaesz_vs $V24, $V1]}
+    @{[vaesem_vs $V24, $V2]}
+    @{[vaesem_vs $V24, $V3]}
+    @{[vaesem_vs $V24, $V4]}
+    @{[vaesem_vs $V24, $V5]}
+    @{[vaesem_vs $V24, $V6]}
+    @{[vaesem_vs $V24, $V7]}
+    @{[vaesem_vs $V24, $V8]}
+    @{[vaesem_vs $V24, $V9]}
+    @{[vaesem_vs $V24, $V10]}
+    @{[vaesem_vs $V24, $V11]}
+    @{[vaesem_vs $V24, $V12]}
+    @{[vaesem_vs $V24, $V13]}
+    @{[vaesem_vs $V24, $V14]}
+    @{[vaesef_vs $V24, $V15]}
+
+    # ciphertext
+    @{[vsetvli "zero", $T0, "e8", "m4", "ta", "ma"]}
+    @{[vxor_vv $V24, $V24, $V20]}
+
+    # Store the ciphertext.
+    @{[vse8_v $V24, $OUTP]}
+    add $OUTP, $OUTP, $T0
+
+    bnez $LEN, 1b
+
+    ## store ctr iv
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "mu"]}
+    # Increase ctr in v16.
+    @{[vadd_vx $V16, $V16, $CTR, $MASK]}
+    # Convert ctr data back to big-endian.
+    @{[vrev8_v $V16, $V16, $MASK]}
+    @{[vse32_v $V16, $IVP]}
+
+    ret
+.size ctr32_encrypt_blocks_256,.-ctr32_encrypt_blocks_256
+___
+}
+
+print $code;
+
+close STDOUT or die "error closing STDOUT: $!";
diff --git a/arch/riscv/crypto/aes-riscv64-zvkned.pl b/arch/riscv/crypto/aes-riscv64-zvkned.pl
index 303e82d9f6f0..71a9248320c0 100644
--- a/arch/riscv/crypto/aes-riscv64-zvkned.pl
+++ b/arch/riscv/crypto/aes-riscv64-zvkned.pl
@@ -67,6 +67,752 @@ my ($V0, $V1, $V2, $V3, $V4, $V5, $V6, $V7,
     $V24, $V25, $V26, $V27, $V28, $V29, $V30, $V31,
 ) = map("v$_",(0..31));
 
+# Load all 11 round keys to v1-v11 registers.
+sub aes_128_load_key {
+    my $KEYP = shift;
+
+    my $code=<<___;
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vle32_v $V1, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V2, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V3, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V4, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V5, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V6, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V7, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V8, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V9, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V10, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V11, $KEYP]}
+___
+
+    return $code;
+}
+
+# Load all 13 round keys to v1-v13 registers.
+sub aes_192_load_key {
+    my $KEYP = shift;
+
+    my $code=<<___;
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vle32_v $V1, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V2, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V3, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V4, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V5, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V6, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V7, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V8, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V9, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V10, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V11, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V12, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V13, $KEYP]}
+___
+
+    return $code;
+}
+
+# Load all 15 round keys to v1-v15 registers.
+sub aes_256_load_key {
+    my $KEYP = shift;
+
+    my $code=<<___;
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vle32_v $V1, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V2, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V3, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V4, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V5, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V6, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V7, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V8, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V9, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V10, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V11, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V12, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V13, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V14, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V15, $KEYP]}
+___
+
+    return $code;
+}
+
+# aes-128 encryption with round keys v1-v11
+sub aes_128_encrypt {
+    my $code=<<___;
+    @{[vaesz_vs $V24, $V1]}     # with round key w[ 0, 3]
+    @{[vaesem_vs $V24, $V2]}    # with round key w[ 4, 7]
+    @{[vaesem_vs $V24, $V3]}    # with round key w[ 8,11]
+    @{[vaesem_vs $V24, $V4]}    # with round key w[12,15]
+    @{[vaesem_vs $V24, $V5]}    # with round key w[16,19]
+    @{[vaesem_vs $V24, $V6]}    # with round key w[20,23]
+    @{[vaesem_vs $V24, $V7]}    # with round key w[24,27]
+    @{[vaesem_vs $V24, $V8]}    # with round key w[28,31]
+    @{[vaesem_vs $V24, $V9]}    # with round key w[32,35]
+    @{[vaesem_vs $V24, $V10]}   # with round key w[36,39]
+    @{[vaesef_vs $V24, $V11]}   # with round key w[40,43]
+___
+
+    return $code;
+}
+
+# aes-128 decryption with round keys v1-v11
+sub aes_128_decrypt {
+    my $code=<<___;
+    @{[vaesz_vs $V24, $V11]}   # with round key w[40,43]
+    @{[vaesdm_vs $V24, $V10]}  # with round key w[36,39]
+    @{[vaesdm_vs $V24, $V9]}   # with round key w[32,35]
+    @{[vaesdm_vs $V24, $V8]}   # with round key w[28,31]
+    @{[vaesdm_vs $V24, $V7]}   # with round key w[24,27]
+    @{[vaesdm_vs $V24, $V6]}   # with round key w[20,23]
+    @{[vaesdm_vs $V24, $V5]}   # with round key w[16,19]
+    @{[vaesdm_vs $V24, $V4]}   # with round key w[12,15]
+    @{[vaesdm_vs $V24, $V3]}   # with round key w[ 8,11]
+    @{[vaesdm_vs $V24, $V2]}   # with round key w[ 4, 7]
+    @{[vaesdf_vs $V24, $V1]}   # with round key w[ 0, 3]
+___
+
+    return $code;
+}
+
+# aes-192 encryption with round keys v1-v13
+sub aes_192_encrypt {
+    my $code=<<___;
+    @{[vaesz_vs $V24, $V1]}     # with round key w[ 0, 3]
+    @{[vaesem_vs $V24, $V2]}    # with round key w[ 4, 7]
+    @{[vaesem_vs $V24, $V3]}    # with round key w[ 8,11]
+    @{[vaesem_vs $V24, $V4]}    # with round key w[12,15]
+    @{[vaesem_vs $V24, $V5]}    # with round key w[16,19]
+    @{[vaesem_vs $V24, $V6]}    # with round key w[20,23]
+    @{[vaesem_vs $V24, $V7]}    # with round key w[24,27]
+    @{[vaesem_vs $V24, $V8]}    # with round key w[28,31]
+    @{[vaesem_vs $V24, $V9]}    # with round key w[32,35]
+    @{[vaesem_vs $V24, $V10]}   # with round key w[36,39]
+    @{[vaesem_vs $V24, $V11]}   # with round key w[40,43]
+    @{[vaesem_vs $V24, $V12]}   # with round key w[44,47]
+    @{[vaesef_vs $V24, $V13]}   # with round key w[48,51]
+___
+
+    return $code;
+}
+
+# aes-192 decryption with round keys v1-v13
+sub aes_192_decrypt {
+    my $code=<<___;
+    @{[vaesz_vs $V24, $V13]}    # with round key w[48,51]
+    @{[vaesdm_vs $V24, $V12]}   # with round key w[44,47]
+    @{[vaesdm_vs $V24, $V11]}   # with round key w[40,43]
+    @{[vaesdm_vs $V24, $V10]}   # with round key w[36,39]
+    @{[vaesdm_vs $V24, $V9]}    # with round key w[32,35]
+    @{[vaesdm_vs $V24, $V8]}    # with round key w[28,31]
+    @{[vaesdm_vs $V24, $V7]}    # with round key w[24,27]
+    @{[vaesdm_vs $V24, $V6]}    # with round key w[20,23]
+    @{[vaesdm_vs $V24, $V5]}    # with round key w[16,19]
+    @{[vaesdm_vs $V24, $V4]}    # with round key w[12,15]
+    @{[vaesdm_vs $V24, $V3]}    # with round key w[ 8,11]
+    @{[vaesdm_vs $V24, $V2]}    # with round key w[ 4, 7]
+    @{[vaesdf_vs $V24, $V1]}    # with round key w[ 0, 3]
+___
+
+    return $code;
+}
+
+# aes-256 encryption with round keys v1-v15
+sub aes_256_encrypt {
+    my $code=<<___;
+    @{[vaesz_vs $V24, $V1]}     # with round key w[ 0, 3]
+    @{[vaesem_vs $V24, $V2]}    # with round key w[ 4, 7]
+    @{[vaesem_vs $V24, $V3]}    # with round key w[ 8,11]
+    @{[vaesem_vs $V24, $V4]}    # with round key w[12,15]
+    @{[vaesem_vs $V24, $V5]}    # with round key w[16,19]
+    @{[vaesem_vs $V24, $V6]}    # with round key w[20,23]
+    @{[vaesem_vs $V24, $V7]}    # with round key w[24,27]
+    @{[vaesem_vs $V24, $V8]}    # with round key w[28,31]
+    @{[vaesem_vs $V24, $V9]}    # with round key w[32,35]
+    @{[vaesem_vs $V24, $V10]}   # with round key w[36,39]
+    @{[vaesem_vs $V24, $V11]}   # with round key w[40,43]
+    @{[vaesem_vs $V24, $V12]}   # with round key w[44,47]
+    @{[vaesem_vs $V24, $V13]}   # with round key w[48,51]
+    @{[vaesem_vs $V24, $V14]}   # with round key w[52,55]
+    @{[vaesef_vs $V24, $V15]}   # with round key w[56,59]
+___
+
+    return $code;
+}
+
+# aes-256 decryption with round keys v1-v15
+sub aes_256_decrypt {
+    my $code=<<___;
+    @{[vaesz_vs $V24, $V15]}    # with round key w[56,59]
+    @{[vaesdm_vs $V24, $V14]}   # with round key w[52,55]
+    @{[vaesdm_vs $V24, $V13]}   # with round key w[48,51]
+    @{[vaesdm_vs $V24, $V12]}   # with round key w[44,47]
+    @{[vaesdm_vs $V24, $V11]}   # with round key w[40,43]
+    @{[vaesdm_vs $V24, $V10]}   # with round key w[36,39]
+    @{[vaesdm_vs $V24, $V9]}    # with round key w[32,35]
+    @{[vaesdm_vs $V24, $V8]}    # with round key w[28,31]
+    @{[vaesdm_vs $V24, $V7]}    # with round key w[24,27]
+    @{[vaesdm_vs $V24, $V6]}    # with round key w[20,23]
+    @{[vaesdm_vs $V24, $V5]}    # with round key w[16,19]
+    @{[vaesdm_vs $V24, $V4]}    # with round key w[12,15]
+    @{[vaesdm_vs $V24, $V3]}    # with round key w[ 8,11]
+    @{[vaesdm_vs $V24, $V2]}    # with round key w[ 4, 7]
+    @{[vaesdf_vs $V24, $V1]}    # with round key w[ 0, 3]
+___
+
+    return $code;
+}
+
+{
+###############################################################################
+# void rv64i_zvkned_cbc_encrypt(const unsigned char *in, unsigned char *out,
+#                               size_t length, const AES_KEY *key,
+#                               unsigned char *ivec, const int enc);
+my ($INP, $OUTP, $LEN, $KEYP, $IVP, $ENC) = ("a0", "a1", "a2", "a3", "a4", "a5");
+my ($T0, $T1) = ("t0", "t1", "t2");
+
+$code .= <<___;
+.p2align 3
+.globl rv64i_zvkned_cbc_encrypt
+.type rv64i_zvkned_cbc_encrypt,\@function
+rv64i_zvkned_cbc_encrypt:
+    # check whether the length is a multiple of 16 and >= 16
+    li $T1, 16
+    blt $LEN, $T1, L_end
+    andi $T1, $LEN, 15
+    bnez $T1, L_end
+
+    # Load key length.
+    lwu $T0, 480($KEYP)
+
+    # Get proper routine for key length.
+    li $T1, 16
+    beq $T1, $T0, L_cbc_enc_128
+
+    li $T1, 24
+    beq $T1, $T0, L_cbc_enc_192
+
+    li $T1, 32
+    beq $T1, $T0, L_cbc_enc_256
+
+    ret
+.size rv64i_zvkned_cbc_encrypt,.-rv64i_zvkned_cbc_encrypt
+___
+
+$code .= <<___;
+.p2align 3
+L_cbc_enc_128:
+    # Load all 11 round keys to v1-v11 registers.
+    @{[aes_128_load_key $KEYP]}
+
+    # Load IV.
+    @{[vle32_v $V16, $IVP]}
+
+    @{[vle32_v $V24, $INP]}
+    @{[vxor_vv $V24, $V24, $V16]}
+    j 2f
+
+1:
+    @{[vle32_v $V17, $INP]}
+    @{[vxor_vv $V24, $V24, $V17]}
+
+2:
+    # AES body
+    @{[aes_128_encrypt]}
+
+    @{[vse32_v $V24, $OUTP]}
+
+    addi $INP, $INP, 16
+    addi $OUTP, $OUTP, 16
+    addi $LEN, $LEN, -16
+
+    bnez $LEN, 1b
+
+    @{[vse32_v $V24, $IVP]}
+
+    ret
+.size L_cbc_enc_128,.-L_cbc_enc_128
+___
+
+$code .= <<___;
+.p2align 3
+L_cbc_enc_192:
+    # Load all 13 round keys to v1-v13 registers.
+    @{[aes_192_load_key $KEYP]}
+
+    # Load IV.
+    @{[vle32_v $V16, $IVP]}
+
+    @{[vle32_v $V24, $INP]}
+    @{[vxor_vv $V24, $V24, $V16]}
+    j 2f
+
+1:
+    @{[vle32_v $V17, $INP]}
+    @{[vxor_vv $V24, $V24, $V17]}
+
+2:
+    # AES body
+    @{[aes_192_encrypt]}
+
+    @{[vse32_v $V24, $OUTP]}
+
+    addi $INP, $INP, 16
+    addi $OUTP, $OUTP, 16
+    addi $LEN, $LEN, -16
+
+    bnez $LEN, 1b
+
+    @{[vse32_v $V24, $IVP]}
+
+    ret
+.size L_cbc_enc_192,.-L_cbc_enc_192
+___
+
+$code .= <<___;
+.p2align 3
+L_cbc_enc_256:
+    # Load all 15 round keys to v1-v15 registers.
+    @{[aes_256_load_key $KEYP]}
+
+    # Load IV.
+    @{[vle32_v $V16, $IVP]}
+
+    @{[vle32_v $V24, $INP]}
+    @{[vxor_vv $V24, $V24, $V16]}
+    j 2f
+
+1:
+    @{[vle32_v $V17, $INP]}
+    @{[vxor_vv $V24, $V24, $V17]}
+
+2:
+    # AES body
+    @{[aes_256_encrypt]}
+
+    @{[vse32_v $V24, $OUTP]}
+
+    addi $INP, $INP, 16
+    addi $OUTP, $OUTP, 16
+    addi $LEN, $LEN, -16
+
+    bnez $LEN, 1b
+
+    @{[vse32_v $V24, $IVP]}
+
+    ret
+.size L_cbc_enc_256,.-L_cbc_enc_256
+___
+
+###############################################################################
+# void rv64i_zvkned_cbc_decrypt(const unsigned char *in, unsigned char *out,
+#                               size_t length, const AES_KEY *key,
+#                               unsigned char *ivec, const int enc);
+$code .= <<___;
+.p2align 3
+.globl rv64i_zvkned_cbc_decrypt
+.type rv64i_zvkned_cbc_decrypt,\@function
+rv64i_zvkned_cbc_decrypt:
+    # check whether the length is a multiple of 16 and >= 16
+    li $T1, 16
+    blt $LEN, $T1, L_end
+    andi $T1, $LEN, 15
+    bnez $T1, L_end
+
+    # Load key length.
+    lwu $T0, 480($KEYP)
+
+    # Get proper routine for key length.
+    li $T1, 16
+    beq $T1, $T0, L_cbc_dec_128
+
+    li $T1, 24
+    beq $T1, $T0, L_cbc_dec_192
+
+    li $T1, 32
+    beq $T1, $T0, L_cbc_dec_256
+
+    ret
+.size rv64i_zvkned_cbc_decrypt,.-rv64i_zvkned_cbc_decrypt
+___
+
+$code .= <<___;
+.p2align 3
+L_cbc_dec_128:
+    # Load all 11 round keys to v1-v11 registers.
+    @{[aes_128_load_key $KEYP]}
+
+    # Load IV.
+    @{[vle32_v $V16, $IVP]}
+
+    @{[vle32_v $V24, $INP]}
+    @{[vmv_v_v $V17, $V24]}
+    j 2f
+
+1:
+    @{[vle32_v $V24, $INP]}
+    @{[vmv_v_v $V17, $V24]}
+    addi $OUTP, $OUTP, 16
+
+2:
+    # AES body
+    @{[aes_128_decrypt]}
+
+    @{[vxor_vv $V24, $V24, $V16]}
+    @{[vse32_v $V24, $OUTP]}
+    @{[vmv_v_v $V16, $V17]}
+
+    addi $LEN, $LEN, -16
+    addi $INP, $INP, 16
+
+    bnez $LEN, 1b
+
+    @{[vse32_v $V16, $IVP]}
+
+    ret
+.size L_cbc_dec_128,.-L_cbc_dec_128
+___
+
+$code .= <<___;
+.p2align 3
+L_cbc_dec_192:
+    # Load all 13 round keys to v1-v13 registers.
+    @{[aes_192_load_key $KEYP]}
+
+    # Load IV.
+    @{[vle32_v $V16, $IVP]}
+
+    @{[vle32_v $V24, $INP]}
+    @{[vmv_v_v $V17, $V24]}
+    j 2f
+
+1:
+    @{[vle32_v $V24, $INP]}
+    @{[vmv_v_v $V17, $V24]}
+    addi $OUTP, $OUTP, 16
+
+2:
+    # AES body
+    @{[aes_192_decrypt]}
+
+    @{[vxor_vv $V24, $V24, $V16]}
+    @{[vse32_v $V24, $OUTP]}
+    @{[vmv_v_v $V16, $V17]}
+
+    addi $LEN, $LEN, -16
+    addi $INP, $INP, 16
+
+    bnez $LEN, 1b
+
+    @{[vse32_v $V16, $IVP]}
+
+    ret
+.size L_cbc_dec_192,.-L_cbc_dec_192
+___
+
+$code .= <<___;
+.p2align 3
+L_cbc_dec_256:
+    # Load all 15 round keys to v1-v15 registers.
+    @{[aes_256_load_key $KEYP]}
+
+    # Load IV.
+    @{[vle32_v $V16, $IVP]}
+
+    @{[vle32_v $V24, $INP]}
+    @{[vmv_v_v $V17, $V24]}
+    j 2f
+
+1:
+    @{[vle32_v $V24, $INP]}
+    @{[vmv_v_v $V17, $V24]}
+    addi $OUTP, $OUTP, 16
+
+2:
+    # AES body
+    @{[aes_256_decrypt]}
+
+    @{[vxor_vv $V24, $V24, $V16]}
+    @{[vse32_v $V24, $OUTP]}
+    @{[vmv_v_v $V16, $V17]}
+
+    addi $LEN, $LEN, -16
+    addi $INP, $INP, 16
+
+    bnez $LEN, 1b
+
+    @{[vse32_v $V16, $IVP]}
+
+    ret
+.size L_cbc_dec_256,.-L_cbc_dec_256
+___
+}
+
+{
+###############################################################################
+# void rv64i_zvkned_ecb_encrypt(const unsigned char *in, unsigned char *out,
+#                               size_t length, const AES_KEY *key,
+#                               const int enc);
+my ($INP, $OUTP, $LEN, $KEYP, $ENC) = ("a0", "a1", "a2", "a3", "a4");
+my ($VL) = ("a5");
+my ($LEN32) = ("a6");
+my ($T0, $T1) = ("t0", "t1");
+
+$code .= <<___;
+.p2align 3
+.globl rv64i_zvkned_ecb_encrypt
+.type rv64i_zvkned_ecb_encrypt,\@function
+rv64i_zvkned_ecb_encrypt:
+    # Make the LEN become e32 length.
+    srli $LEN32, $LEN, 2
+
+    # Load key length.
+    lwu $T0, 480($KEYP)
+
+    # Get proper routine for key length.
+    li $T1, 16
+    beq $T1, $T0, L_ecb_enc_128
+
+    li $T1, 24
+    beq $T1, $T0, L_ecb_enc_192
+
+    li $T1, 32
+    beq $T1, $T0, L_ecb_enc_256
+
+    ret
+.size rv64i_zvkned_ecb_encrypt,.-rv64i_zvkned_ecb_encrypt
+___
+
+$code .= <<___;
+.p2align 3
+L_ecb_enc_128:
+    # Load all 11 round keys to v1-v11 registers.
+    @{[aes_128_load_key $KEYP]}
+
+1:
+    @{[vsetvli $VL, $LEN32, "e32", "m4", "ta", "ma"]}
+    slli $T0, $VL, 2
+    sub $LEN32, $LEN32, $VL
+
+    @{[vle32_v $V24, $INP]}
+
+    # AES body
+    @{[aes_128_encrypt]}
+
+    @{[vse32_v $V24, $OUTP]}
+
+    add $INP, $INP, $T0
+    add $OUTP, $OUTP, $T0
+
+    bnez $LEN32, 1b
+
+    ret
+.size L_ecb_enc_128,.-L_ecb_enc_128
+___
+
+$code .= <<___;
+.p2align 3
+L_ecb_enc_192:
+    # Load all 13 round keys to v1-v13 registers.
+    @{[aes_192_load_key $KEYP]}
+
+1:
+    @{[vsetvli $VL, $LEN32, "e32", "m4", "ta", "ma"]}
+    slli $T0, $VL, 2
+    sub $LEN32, $LEN32, $VL
+
+    @{[vle32_v $V24, $INP]}
+
+    # AES body
+    @{[aes_192_encrypt]}
+
+    @{[vse32_v $V24, $OUTP]}
+
+    add $INP, $INP, $T0
+    add $OUTP, $OUTP, $T0
+
+    bnez $LEN32, 1b
+
+    ret
+.size L_ecb_enc_192,.-L_ecb_enc_192
+___
+
+$code .= <<___;
+.p2align 3
+L_ecb_enc_256:
+    # Load all 15 round keys to v1-v15 registers.
+    @{[aes_256_load_key $KEYP]}
+
+1:
+    @{[vsetvli $VL, $LEN32, "e32", "m4", "ta", "ma"]}
+    slli $T0, $VL, 2
+    sub $LEN32, $LEN32, $VL
+
+    @{[vle32_v $V24, $INP]}
+
+    # AES body
+    @{[aes_256_encrypt]}
+
+    @{[vse32_v $V24, $OUTP]}
+
+    add $INP, $INP, $T0
+    add $OUTP, $OUTP, $T0
+
+    bnez $LEN32, 1b
+
+    ret
+.size L_ecb_enc_256,.-L_ecb_enc_256
+___
+
+###############################################################################
+# void rv64i_zvkned_ecb_decrypt(const unsigned char *in, unsigned char *out,
+#                               size_t length, const AES_KEY *key,
+#                               const int enc);
+$code .= <<___;
+.p2align 3
+.globl rv64i_zvkned_ecb_decrypt
+.type rv64i_zvkned_ecb_decrypt,\@function
+rv64i_zvkned_ecb_decrypt:
+    # Make the LEN become e32 length.
+    srli $LEN32, $LEN, 2
+
+    # Load key length.
+    lwu $T0, 480($KEYP)
+
+    # Get proper routine for key length.
+    li $T1, 16
+    beq $T1, $T0, L_ecb_dec_128
+
+    li $T1, 24
+    beq $T1, $T0, L_ecb_dec_192
+
+    li $T1, 32
+    beq $T1, $T0, L_ecb_dec_256
+
+    ret
+.size rv64i_zvkned_ecb_decrypt,.-rv64i_zvkned_ecb_decrypt
+___
+
+$code .= <<___;
+.p2align 3
+L_ecb_dec_128:
+    # Load all 11 round keys to v1-v11 registers.
+    @{[aes_128_load_key $KEYP]}
+
+1:
+    @{[vsetvli $VL, $LEN32, "e32", "m4", "ta", "ma"]}
+    slli $T0, $VL, 2
+    sub $LEN32, $LEN32, $VL
+
+    @{[vle32_v $V24, $INP]}
+
+    # AES body
+    @{[aes_128_decrypt]}
+
+    @{[vse32_v $V24, $OUTP]}
+
+    add $INP, $INP, $T0
+    add $OUTP, $OUTP, $T0
+
+    bnez $LEN32, 1b
+
+    ret
+.size L_ecb_dec_128,.-L_ecb_dec_128
+___
+
+$code .= <<___;
+.p2align 3
+L_ecb_dec_192:
+    # Load all 13 round keys to v1-v13 registers.
+    @{[aes_192_load_key $KEYP]}
+
+1:
+    @{[vsetvli $VL, $LEN32, "e32", "m4", "ta", "ma"]}
+    slli $T0, $VL, 2
+    sub $LEN32, $LEN32, $VL
+
+    @{[vle32_v $V24, $INP]}
+
+    # AES body
+    @{[aes_192_decrypt]}
+
+    @{[vse32_v $V24, $OUTP]}
+
+    add $INP, $INP, $T0
+    add $OUTP, $OUTP, $T0
+
+    bnez $LEN32, 1b
+
+    ret
+.size L_ecb_dec_192,.-L_ecb_dec_192
+___
+
+$code .= <<___;
+.p2align 3
+L_ecb_dec_256:
+    # Load all 15 round keys to v1-v15 registers.
+    @{[aes_256_load_key $KEYP]}
+
+1:
+    @{[vsetvli $VL, $LEN32, "e32", "m4", "ta", "ma"]}
+    slli $T0, $VL, 2
+    sub $LEN32, $LEN32, $VL
+
+    @{[vle32_v $V24, $INP]}
+
+    # AES body
+    @{[aes_256_decrypt]}
+
+    @{[vse32_v $V24, $OUTP]}
+
+    add $INP, $INP, $T0
+    add $OUTP, $OUTP, $T0
+
+    bnez $LEN32, 1b
+
+    ret
+.size L_ecb_dec_256,.-L_ecb_dec_256
+___
+}
+
 {
 ################################################################################
 # int rv64i_zvkned_set_encrypt_key(const unsigned char *userKey, const int bytes,
-- 
2.28.0



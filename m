Return-Path: <linux-crypto+bounces-1191-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 413D68217DB
	for <lists+linux-crypto@lfdr.de>; Tue,  2 Jan 2024 07:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A601F21E37
	for <lists+linux-crypto@lfdr.de>; Tue,  2 Jan 2024 06:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097F611C8C;
	Tue,  2 Jan 2024 06:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNrn/mHm"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D7211737;
	Tue,  2 Jan 2024 06:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633E8C433CB;
	Tue,  2 Jan 2024 06:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704178246;
	bh=BgeHCd+Vg1QtSqOZm5wJkkD6opsDGBOeS+KgQcjgYfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VNrn/mHmL4JVELoOGj/i9QdA3lZEJZyOPi4e6F9VrT3+mYKJlZXdHi+gfcsxPAbRW
	 yNBn3TSFuAs7x+Z9vo3h2RvdZQaoWZieN2BUnLdeNabz8BTISOr5s43/kNN0k8AqZJ
	 OuAShHOTeah81eOT+U2B58DDnCC6KNsmOxjJ9Nu6Et0ZwEXJRBjtLDcd9jzJBNGA/V
	 ibB+blM7WypANP4LArVwxnAzZnjYJ39K3F7SpSZ9d2Nm96mGrqpdTj/EjVkHtzau+L
	 K6TLgntso0pil5oxej3qHfirw69bEGwjrFyjzWVbPU3zxB0V9Mple4t6R9VErpq7QO
	 oKUtJjwcSqZ9g==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Jerry Shih <jerry.shih@sifive.com>
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Phoebe Chen <phoebe.chen@sifive.com>,
	hongrong.hsu@sifive.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andy Chiu <andy.chiu@sifive.com>,
	=?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
	Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [RFC PATCH 12/13] crypto: riscv - add vector crypto accelerated SM3
Date: Tue,  2 Jan 2024 00:47:38 -0600
Message-ID: <20240102064743.220490-13-ebiggers@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102064743.220490-1-ebiggers@kernel.org>
References: <20240102064743.220490-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jerry Shih <jerry.shih@sifive.com>

Add an implementation of SM3 using the Zvksh extension.  The assembly
code is derived from OpenSSL code (openssl/openssl#21923) that was
dual-licensed so that it could be reused in the kernel.  Nevertheless,
the assembly has been significantly reworked for integration with the
kernel, for example by using a regular .S file instead of the so-called
perlasm, using the assembler instead of bare '.inst', and greatly
reducing code duplication.

Co-developed-by: Christoph Müllner <christoph.muellner@vrull.eu>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Co-developed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/riscv/crypto/Kconfig                  |  12 ++
 arch/riscv/crypto/Makefile                 |   3 +
 arch/riscv/crypto/sm3-riscv64-glue.c       | 112 +++++++++++++++++++
 arch/riscv/crypto/sm3-riscv64-zvksh-zvkb.S | 123 +++++++++++++++++++++
 4 files changed, 250 insertions(+)
 create mode 100644 arch/riscv/crypto/sm3-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sm3-riscv64-zvksh-zvkb.S

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index ca13895c3e0f6..d44911853fa2d 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -69,11 +69,23 @@ config CRYPTO_SHA512_RISCV64
 	tristate "Hash functions: SHA-384 and SHA-512"
 	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
 	select CRYPTO_SHA512
 	help
 	  SHA-384 and SHA-512 secure hash algorithm (FIPS 180)
 
 	  Architecture: riscv64 using:
 	  - Zvknhb vector crypto extension
 	  - Zvkb vector crypto extension
 
+config CRYPTO_SM3_RISCV64
+	tristate "Hash functions: SM3 (ShangMi 3)"
+	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	select CRYPTO_HASH
+	select CRYPTO_SM3
+	help
+	  SM3 (ShangMi 3) secure hash function (OSCCA GM/T 0004-2012)
+
+	  Architecture: riscv64 using:
+	  - Zvksh vector crypto extension
+	  - Zvkb vector crypto extension
+
 endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index e30a1bcc788bf..4b5efabd1162a 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -13,10 +13,13 @@ obj-$(CONFIG_CRYPTO_CHACHA_RISCV64) += chacha-riscv64.o
 chacha-riscv64-y := chacha-riscv64-glue.o chacha-riscv64-zvkb.o
 
 obj-$(CONFIG_CRYPTO_GHASH_RISCV64) += ghash-riscv64.o
 ghash-riscv64-y := ghash-riscv64-glue.o ghash-riscv64-zvkg.o
 
 obj-$(CONFIG_CRYPTO_SHA256_RISCV64) += sha256-riscv64.o
 sha256-riscv64-y := sha256-riscv64-glue.o sha256-riscv64-zvknha_or_zvknhb-zvkb.o
 
 obj-$(CONFIG_CRYPTO_SHA512_RISCV64) += sha512-riscv64.o
 sha512-riscv64-y := sha512-riscv64-glue.o sha512-riscv64-zvknhb-zvkb.o
+
+obj-$(CONFIG_CRYPTO_SM3_RISCV64) += sm3-riscv64.o
+sm3-riscv64-y := sm3-riscv64-glue.o sm3-riscv64-zvksh-zvkb.o
diff --git a/arch/riscv/crypto/sm3-riscv64-glue.c b/arch/riscv/crypto/sm3-riscv64-glue.c
new file mode 100644
index 0000000000000..c9816ce3043f2
--- /dev/null
+++ b/arch/riscv/crypto/sm3-riscv64-glue.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * SM3 using the RISC-V vector crypto extensions
+ *
+ * Copyright (C) 2023 VRULL GmbH
+ * Author: Heiko Stuebner <heiko.stuebner@vrull.eu>
+ *
+ * Copyright (C) 2023 SiFive, Inc.
+ * Author: Jerry Shih <jerry.shih@sifive.com>
+ */
+
+#include <asm/simd.h>
+#include <asm/vector.h>
+#include <crypto/internal/hash.h>
+#include <crypto/internal/simd.h>
+#include <crypto/sm3_base.h>
+#include <linux/linkage.h>
+#include <linux/module.h>
+
+/*
+ * Note: the asm function only uses the 'state' field of struct sm3_state.
+ * It is assumed to be the first field.
+ */
+asmlinkage void sm3_transform_zvksh_zvkb(
+	struct sm3_state *state, const u8 *data, int num_blocks);
+
+static int riscv64_sm3_update(struct shash_desc *desc, const u8 *data,
+			      unsigned int len)
+{
+	/*
+	 * Ensure struct sm3_state begins directly with the SM3
+	 * 256-bit internal state, as this is what the asm function expects.
+	 */
+	BUILD_BUG_ON(offsetof(struct sm3_state, state) != 0);
+
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		sm3_base_do_update(desc, data, len, sm3_transform_zvksh_zvkb);
+		kernel_vector_end();
+	} else {
+		sm3_update(shash_desc_ctx(desc), data, len);
+	}
+	return 0;
+}
+
+static int riscv64_sm3_finup(struct shash_desc *desc, const u8 *data,
+			     unsigned int len, u8 *out)
+{
+	struct sm3_state *ctx;
+
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		if (len)
+			sm3_base_do_update(desc, data, len,
+					   sm3_transform_zvksh_zvkb);
+		sm3_base_do_finalize(desc, sm3_transform_zvksh_zvkb);
+		kernel_vector_end();
+
+		return sm3_base_finish(desc, out);
+	}
+
+	ctx = shash_desc_ctx(desc);
+	if (len)
+		sm3_update(ctx, data, len);
+	sm3_final(ctx, out);
+
+	return 0;
+}
+
+static int riscv64_sm3_final(struct shash_desc *desc, u8 *out)
+{
+	return riscv64_sm3_finup(desc, NULL, 0, out);
+}
+
+static struct shash_alg riscv64_sm3_alg = {
+	.init = sm3_base_init,
+	.update = riscv64_sm3_update,
+	.final = riscv64_sm3_final,
+	.finup = riscv64_sm3_finup,
+	.descsize = sizeof(struct sm3_state),
+	.digestsize = SM3_DIGEST_SIZE,
+	.base = {
+		.cra_blocksize = SM3_BLOCK_SIZE,
+		.cra_priority = 300,
+		.cra_name = "sm3",
+		.cra_driver_name = "sm3-riscv64-zvksh-zvkb",
+		.cra_module = THIS_MODULE,
+	},
+};
+
+static int __init riscv64_sm3_mod_init(void)
+{
+	if (riscv_isa_extension_available(NULL, ZVKSH) &&
+	    riscv_isa_extension_available(NULL, ZVKB) &&
+	    riscv_vector_vlen() >= 128)
+		return crypto_register_shash(&riscv64_sm3_alg);
+
+	return -ENODEV;
+}
+
+static void __exit riscv64_sm3_mod_fini(void)
+{
+	crypto_unregister_shash(&riscv64_sm3_alg);
+}
+
+module_init(riscv64_sm3_mod_init);
+module_exit(riscv64_sm3_mod_fini);
+
+MODULE_DESCRIPTION("SM3 (RISC-V accelerated)");
+MODULE_AUTHOR("Heiko Stuebner <heiko.stuebner@vrull.eu>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("sm3");
diff --git a/arch/riscv/crypto/sm3-riscv64-zvksh-zvkb.S b/arch/riscv/crypto/sm3-riscv64-zvksh-zvkb.S
new file mode 100644
index 0000000000000..a2b65d961c04a
--- /dev/null
+++ b/arch/riscv/crypto/sm3-riscv64-zvksh-zvkb.S
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: Apache-2.0 OR BSD-2-Clause */
+//
+// This file is dual-licensed, meaning that you can use it under your
+// choice of either of the following two licenses:
+//
+// Copyright 2023 The OpenSSL Project Authors. All Rights Reserved.
+//
+// Licensed under the Apache License 2.0 (the "License"). You can obtain
+// a copy in the file LICENSE in the source distribution or at
+// https://www.openssl.org/source/license.html
+//
+// or
+//
+// Copyright (c) 2023, Christoph Müllner <christoph.muellner@vrull.eu>
+// Copyright (c) 2023, Jerry Shih <jerry.shih@sifive.com>
+// Copyright 2024 Google LLC
+// All rights reserved.
+//
+// Redistribution and use in source and binary forms, with or without
+// modification, are permitted provided that the following conditions
+// are met:
+// 1. Redistributions of source code must retain the above copyright
+//    notice, this list of conditions and the following disclaimer.
+// 2. Redistributions in binary form must reproduce the above copyright
+//    notice, this list of conditions and the following disclaimer in the
+//    documentation and/or other materials provided with the distribution.
+//
+// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+
+// The generated code of this file depends on the following RISC-V extensions:
+// - RV64I
+// - RISC-V Vector ('V') with VLEN >= 128
+// - RISC-V Vector SM3 Secure Hash extension ('Zvksh')
+// - RISC-V Vector Cryptography Bit-manipulation extension ('Zvkb')
+
+#include <linux/cfi_types.h>
+
+.text
+.option arch, +zvksh, +zvkb
+
+#define STATEP		a0
+#define DATA		a1
+#define NUM_BLOCKS	a2
+
+#define STATE		v0	// LMUL=2
+#define PREV_STATE	v2	// LMUL=2
+#define W0		v4	// LMUL=2
+#define W1		v6	// LMUL=2
+#define VTMP		v8	// LMUL=2
+
+.macro	sm3_8rounds	i, w0, w1
+	// Do 4 rounds using W_{0+i}..W_{7+i}.
+	vsm3c.vi	STATE, \w0, \i + 0
+	vslidedown.vi	VTMP, \w0, 2
+	vsm3c.vi	STATE, VTMP, \i + 1
+
+	// Compute W_{4+i}..W_{11+i}.
+	vslidedown.vi	VTMP, \w0, 4
+	vslideup.vi	VTMP, \w1, 4
+
+	// Do 4 rounds using W_{4+i}..W_{11+i}.
+	vsm3c.vi	STATE, VTMP, \i + 2
+	vslidedown.vi	VTMP, VTMP, 2
+	vsm3c.vi	STATE, VTMP, \i + 3
+
+.if \i < 28
+	// Compute W_{16+i}..W_{23+i}.
+	vsm3me.vv	\w0, \w1, \w0
+.endif
+	// For the next 8 rounds, w0 and w1 are swapped.
+.endm
+
+// void sm3_transform_zvksh_zvkb(u32 state[8], const u8 *data, int num_blocks);
+SYM_TYPED_FUNC_START(sm3_transform_zvksh_zvkb)
+
+	// Load the state and endian-swap each 32-bit word.
+	vsetivli	zero, 8, e32, m2, ta, ma
+	vle32.v		STATE, (STATEP)
+	vrev8.v		STATE, STATE
+
+.Lnext_block:
+	addi		NUM_BLOCKS, NUM_BLOCKS, -1
+
+	// Save the previous state, as it's needed later.
+	vmv.v.v		PREV_STATE, STATE
+
+	// Load the next 512-bit message block into W0-W1.
+	vle32.v		W0, (DATA)
+	addi		DATA, DATA, 32
+	vle32.v		W1, (DATA)
+	addi		DATA, DATA, 32
+
+	// Do the 64 rounds of SM3.
+	sm3_8rounds	0, W0, W1
+	sm3_8rounds	4, W1, W0
+	sm3_8rounds	8, W0, W1
+	sm3_8rounds	12, W1, W0
+	sm3_8rounds	16, W0, W1
+	sm3_8rounds	20, W1, W0
+	sm3_8rounds	24, W0, W1
+	sm3_8rounds	28, W1, W0
+
+	// XOR in the previous state.
+	vxor.vv		STATE, STATE, PREV_STATE
+
+	// Repeat if more blocks remain.
+	bnez		NUM_BLOCKS, .Lnext_block
+
+	// Store the new state and return.
+	vrev8.v		STATE, STATE
+	vse32.v		STATE, (STATEP)
+	ret
+SYM_FUNC_END(sm3_transform_zvksh_zvkb)
-- 
2.43.0



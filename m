Return-Path: <linux-crypto+bounces-8133-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73C69D0197
	for <lists+linux-crypto@lfdr.de>; Sun, 17 Nov 2024 01:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BFA51F238A2
	for <lists+linux-crypto@lfdr.de>; Sun, 17 Nov 2024 00:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B376D11187;
	Sun, 17 Nov 2024 00:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhVnyRJc"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AD0D529;
	Sun, 17 Nov 2024 00:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731803035; cv=none; b=hN68wb2Z5AV73wHph4CGeXE02xIjwK6gVZWETZ48N7tXoNp5yBE2Rk67NEyOSfQQ1a9Z8hujgHXzuf0aYD+85G058AD+KQPctyD1Omb0VCKJQ5znT0hUwtmXheSZZWAYGKnDb72wL0S9stDWXlZMjdoNzM1d87Fttd3sqSnt2Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731803035; c=relaxed/simple;
	bh=gzdPLhhkLERJCguDKATRZ050D7HdtyySUPbi/TiqkkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfEaVNmvENP7WTY1avgQ36hACIl4PeD2pUn5B4X0xC55Kh/B8dLqgEuLwMSfATAnyZtDj8qeN2GJ2DxKTy0oU9JIKRmoiJpRlbpwA4ae0A8ZlXElA2+oatgAqmie5tdhgJ+708YWsCcOvjwRZz13UgewMm3Xofd+XycWV478Pj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhVnyRJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05267C4CED2;
	Sun, 17 Nov 2024 00:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731803035;
	bh=gzdPLhhkLERJCguDKATRZ050D7HdtyySUPbi/TiqkkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZhVnyRJcHee6aSGYwXhwyotedN0bibRkeEgtSzh1Rf/aHpK4SyDEc2MgRnxGIMXQt
	 VlouS8AgLVpiBu/BOyEvXD61Oca4Rz3eQtQIlgqfzUW5/02gZ1zpUnX56WKGWdZGIK
	 EN8TUTZ2N7bc0F1Cp0kq0KM+QiPlM7CxVeCDURJzod0IaeFF1M1UyGFVPRZlfGklJZ
	 DVIHEhE86CzX3aSKfvRTSFu060/yNxH6pV1ceFmcP2trn+if4ruwqFVBCj20Y+WyzU
	 +wSvGHjaxO8dHANwyKTwGTR1H8zPM72q4o0WLFzvnlHS20MPs5XRMye4YBUT8BlDAi
	 8oEoLy7ogzILg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org,
	Zhihang Shao <zhihang.shao.iscas@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 04/11] x86/crc-t10dif: expose CRC-T10DIF function through lib
Date: Sat, 16 Nov 2024 16:22:37 -0800
Message-ID: <20241117002244.105200-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241117002244.105200-1-ebiggers@kernel.org>
References: <20241117002244.105200-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Move the x86 CRC-T10DIF assembly code into the lib directory and wire it
up to the library interface.  This allows it to be used without going
through the crypto API.  It remains usable via the crypto API too via
the shash algorithms that use the library interface.  Thus all the
arch-specific "shash" code becomes unnecessary and is removed.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/Kconfig                              |   1 +
 arch/x86/crypto/Kconfig                       |  10 --
 arch/x86/crypto/Makefile                      |   3 -
 arch/x86/crypto/crct10dif-pclmul_glue.c       | 143 ------------------
 arch/x86/lib/Makefile                         |   3 +
 arch/x86/lib/crc-t10dif-glue.c                |  51 +++++++
 .../{crypto => lib}/crct10dif-pcl-asm_64.S    |   0
 7 files changed, 55 insertions(+), 156 deletions(-)
 delete mode 100644 arch/x86/crypto/crct10dif-pclmul_glue.c
 create mode 100644 arch/x86/lib/crc-t10dif-glue.c
 rename arch/x86/{crypto => lib}/crct10dif-pcl-asm_64.S (100%)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e7470de11cec..fd3f9be3b932 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -75,10 +75,11 @@ config X86
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_CPU_PASID		if IOMMU_SVA
 	select ARCH_HAS_CRC32
+	select ARCH_HAS_CRC_T10DIF		if X86_64
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE	if !X86_PAE
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_DMA_OPS			if GART_IOMMU || XEN
diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
index 1ca53e847966..2ab31fda4d88 100644
--- a/arch/x86/crypto/Kconfig
+++ b/arch/x86/crypto/Kconfig
@@ -490,16 +490,6 @@ config CRYPTO_GHASH_CLMUL_NI_INTEL
 	  GCM GHASH hash function (NIST SP800-38D)
 
 	  Architecture: x86_64 using:
 	  - CLMUL-NI (carry-less multiplication new instructions)
 
-config CRYPTO_CRCT10DIF_PCLMUL
-	tristate "CRCT10DIF (PCLMULQDQ)"
-	depends on X86 && 64BIT && CRC_T10DIF
-	select CRYPTO_HASH
-	help
-	  CRC16 CRC algorithm used for the T10 (SCSI) Data Integrity Field (DIF)
-
-	  Architecture: x86_64 using:
-	  - PCLMULQDQ (carry-less multiplication)
-
 endmenu
diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
index 030b925ca4e2..07b00bfca64b 100644
--- a/arch/x86/crypto/Makefile
+++ b/arch/x86/crypto/Makefile
@@ -73,13 +73,10 @@ obj-$(CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL) += ghash-clmulni-intel.o
 ghash-clmulni-intel-y := ghash-clmulni-intel_asm.o ghash-clmulni-intel_glue.o
 
 obj-$(CONFIG_CRYPTO_POLYVAL_CLMUL_NI) += polyval-clmulni.o
 polyval-clmulni-y := polyval-clmulni_asm.o polyval-clmulni_glue.o
 
-obj-$(CONFIG_CRYPTO_CRCT10DIF_PCLMUL) += crct10dif-pclmul.o
-crct10dif-pclmul-y := crct10dif-pcl-asm_64.o crct10dif-pclmul_glue.o
-
 obj-$(CONFIG_CRYPTO_POLY1305_X86_64) += poly1305-x86_64.o
 poly1305-x86_64-y := poly1305-x86_64-cryptogams.o poly1305_glue.o
 targets += poly1305-x86_64-cryptogams.S
 
 obj-$(CONFIG_CRYPTO_NHPOLY1305_SSE2) += nhpoly1305-sse2.o
diff --git a/arch/x86/crypto/crct10dif-pclmul_glue.c b/arch/x86/crypto/crct10dif-pclmul_glue.c
deleted file mode 100644
index 71291d5af9f4..000000000000
--- a/arch/x86/crypto/crct10dif-pclmul_glue.c
+++ /dev/null
@@ -1,143 +0,0 @@
-/*
- * Cryptographic API.
- *
- * T10 Data Integrity Field CRC16 Crypto Transform using PCLMULQDQ Instructions
- *
- * Copyright (C) 2013 Intel Corporation
- * Author: Tim Chen <tim.c.chen@linux.intel.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
- *
- */
-
-#include <linux/types.h>
-#include <linux/module.h>
-#include <linux/crc-t10dif.h>
-#include <crypto/internal/hash.h>
-#include <crypto/internal/simd.h>
-#include <linux/init.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <asm/cpufeatures.h>
-#include <asm/cpu_device_id.h>
-#include <asm/simd.h>
-
-asmlinkage u16 crc_t10dif_pcl(u16 init_crc, const u8 *buf, size_t len);
-
-struct chksum_desc_ctx {
-	__u16 crc;
-};
-
-static int chksum_init(struct shash_desc *desc)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	ctx->crc = 0;
-
-	return 0;
-}
-
-static int chksum_update(struct shash_desc *desc, const u8 *data,
-			 unsigned int length)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	if (length >= 16 && crypto_simd_usable()) {
-		kernel_fpu_begin();
-		ctx->crc = crc_t10dif_pcl(ctx->crc, data, length);
-		kernel_fpu_end();
-	} else
-		ctx->crc = crc_t10dif_generic(ctx->crc, data, length);
-	return 0;
-}
-
-static int chksum_final(struct shash_desc *desc, u8 *out)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	*(__u16 *)out = ctx->crc;
-	return 0;
-}
-
-static int __chksum_finup(__u16 crc, const u8 *data, unsigned int len, u8 *out)
-{
-	if (len >= 16 && crypto_simd_usable()) {
-		kernel_fpu_begin();
-		*(__u16 *)out = crc_t10dif_pcl(crc, data, len);
-		kernel_fpu_end();
-	} else
-		*(__u16 *)out = crc_t10dif_generic(crc, data, len);
-	return 0;
-}
-
-static int chksum_finup(struct shash_desc *desc, const u8 *data,
-			unsigned int len, u8 *out)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	return __chksum_finup(ctx->crc, data, len, out);
-}
-
-static int chksum_digest(struct shash_desc *desc, const u8 *data,
-			 unsigned int length, u8 *out)
-{
-	return __chksum_finup(0, data, length, out);
-}
-
-static struct shash_alg alg = {
-	.digestsize		=	CRC_T10DIF_DIGEST_SIZE,
-	.init		=	chksum_init,
-	.update		=	chksum_update,
-	.final		=	chksum_final,
-	.finup		=	chksum_finup,
-	.digest		=	chksum_digest,
-	.descsize		=	sizeof(struct chksum_desc_ctx),
-	.base			=	{
-		.cra_name		=	"crct10dif",
-		.cra_driver_name	=	"crct10dif-pclmul",
-		.cra_priority		=	200,
-		.cra_blocksize		=	CRC_T10DIF_BLOCK_SIZE,
-		.cra_module		=	THIS_MODULE,
-	}
-};
-
-static const struct x86_cpu_id crct10dif_cpu_id[] = {
-	X86_MATCH_FEATURE(X86_FEATURE_PCLMULQDQ, NULL),
-	{}
-};
-MODULE_DEVICE_TABLE(x86cpu, crct10dif_cpu_id);
-
-static int __init crct10dif_intel_mod_init(void)
-{
-	if (!x86_match_cpu(crct10dif_cpu_id))
-		return -ENODEV;
-
-	return crypto_register_shash(&alg);
-}
-
-static void __exit crct10dif_intel_mod_fini(void)
-{
-	crypto_unregister_shash(&alg);
-}
-
-module_init(crct10dif_intel_mod_init);
-module_exit(crct10dif_intel_mod_fini);
-
-MODULE_AUTHOR("Tim Chen <tim.c.chen@linux.intel.com>");
-MODULE_DESCRIPTION("T10 DIF CRC calculation accelerated with PCLMULQDQ.");
-MODULE_LICENSE("GPL");
-
-MODULE_ALIAS_CRYPTO("crct10dif");
-MODULE_ALIAS_CRYPTO("crct10dif-pclmul");
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 17510da06c9f..8a59c61624c2 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -40,10 +40,13 @@ lib-$(CONFIG_MITIGATION_RETPOLINE) += retpoline.o
 
 obj-$(CONFIG_CRC32_ARCH) += crc32-x86.o
 crc32-x86-y := crc32-glue.o crc32-pclmul.o
 crc32-x86-$(CONFIG_64BIT) += crc32c-3way.o
 
+obj-$(CONFIG_CRC_T10DIF_ARCH) += crc-t10dif-x86.o
+crc-t10dif-x86-y := crc-t10dif-glue.o crct10dif-pcl-asm_64.o
+
 obj-y += msr.o msr-reg.o msr-reg-export.o hweight.o
 obj-y += iomem.o
 
 ifeq ($(CONFIG_X86_32),y)
         obj-y += atomic64_32.o
diff --git a/arch/x86/lib/crc-t10dif-glue.c b/arch/x86/lib/crc-t10dif-glue.c
new file mode 100644
index 000000000000..13f07ddc9122
--- /dev/null
+++ b/arch/x86/lib/crc-t10dif-glue.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * CRC-T10DIF using PCLMULQDQ instructions
+ *
+ * Copyright 2024 Google LLC
+ */
+
+#include <asm/cpufeatures.h>
+#include <asm/simd.h>
+#include <crypto/internal/simd.h>
+#include <linux/crc-t10dif.h>
+#include <linux/module.h>
+
+static DEFINE_STATIC_KEY_FALSE(have_pclmulqdq);
+
+asmlinkage u16 crc_t10dif_pcl(u16 init_crc, const u8 *buf, size_t len);
+
+u16 crc_t10dif_arch(u16 crc, const u8 *p, size_t len)
+{
+	if (len >= 16 &&
+	    static_key_enabled(&have_pclmulqdq) && crypto_simd_usable()) {
+		kernel_fpu_begin();
+		crc = crc_t10dif_pcl(crc, p, len);
+		kernel_fpu_end();
+		return crc;
+	}
+	return crc_t10dif_generic(crc, p, len);
+}
+EXPORT_SYMBOL(crc_t10dif_arch);
+
+static int __init crc_t10dif_x86_init(void)
+{
+	if (boot_cpu_has(X86_FEATURE_PCLMULQDQ))
+		static_branch_enable(&have_pclmulqdq);
+	return 0;
+}
+arch_initcall(crc_t10dif_x86_init);
+
+static void __exit crc_t10dif_x86_exit(void)
+{
+}
+module_exit(crc_t10dif_x86_exit);
+
+bool crc_t10dif_is_optimized(void)
+{
+	return static_key_enabled(&have_pclmulqdq);
+}
+EXPORT_SYMBOL(crc_t10dif_is_optimized);
+
+MODULE_DESCRIPTION("CRC-T10DIF using PCLMULQDQ instructions");
+MODULE_LICENSE("GPL");
diff --git a/arch/x86/crypto/crct10dif-pcl-asm_64.S b/arch/x86/lib/crct10dif-pcl-asm_64.S
similarity index 100%
rename from arch/x86/crypto/crct10dif-pcl-asm_64.S
rename to arch/x86/lib/crct10dif-pcl-asm_64.S
-- 
2.47.0



Return-Path: <linux-crypto+bounces-9465-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1188BA2A27C
	for <lists+linux-crypto@lfdr.de>; Thu,  6 Feb 2025 08:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444E13A4AC4
	for <lists+linux-crypto@lfdr.de>; Thu,  6 Feb 2025 07:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253DB225A27;
	Thu,  6 Feb 2025 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bserjmM1"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF43225799;
	Thu,  6 Feb 2025 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738827625; cv=none; b=nBSBVh0NhIrBheTakC99TsirYHgDJI50wkTPfsLo0Zwq0apZRyiTIpmAMyVKE4RVcqPivLgfvzxoqocjJ88nG7XOIiU/fFOqh501u532VEUvr/sU0BChIYhFHwKW57mHpK6dQ9fYTjq9Nl2PNtKd8Jn3KZW7tftFu7GFOWG3PR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738827625; c=relaxed/simple;
	bh=C8cL1XsRmxe/mGkGlOBuQj7eOApK9RrvJpUEkAeYoVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9eAWpUtdmcP/rZhXCOLIzm7a8mIxETZkZrsaA2QwlTbcm1ejfgr0Mth/8o2nZjM5aJ50yIWcHHZb4tbUfr7/8Zuq1uywxPsI8tvcOib1zN6CTjv1hfcifZ6cekU3fCDNEkOjBRU++/Ol0f0LmE6PCoPY8xc69/ULYOQ71VL3AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bserjmM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C03FC4CEE0;
	Thu,  6 Feb 2025 07:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738827625;
	bh=C8cL1XsRmxe/mGkGlOBuQj7eOApK9RrvJpUEkAeYoVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bserjmM1Sy2puDKJXiCnihbLEFUBW3/i91fEwQO+iAqQCj7AzJ0UUdip868cexPvZ
	 CijYHNUOcHm/kfPXc2B6mZBv9ZdS1y919ohE/F302kzDcuTOl/5/dT5KEoS7nHZvwk
	 3PXoOCNw64/z4wJIVesrB8xg5peKOFx4ulbqYcxHerkK/qpcGgRzFNPw5XgIkpXQ9M
	 0VXhd2uyN1RFikdy/l/UFkyscKl2DERQnTQx2AwuVO3e/z2cmfc9khdUgDLLH9td87
	 81iIyhr0MMLTRHkcx2xxQTNVqM/G87lHwxb9dU7T2SOuQdcwkkHVidZJ9UNo8Z4TA8
	 luRiQRabBqSOw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	x86@kernel.org,
	linux-block@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v3 6/6] x86/crc64: implement crc64_be and crc64_nvme using new template
Date: Wed,  5 Feb 2025 23:39:48 -0800
Message-ID: <20250206073948.181792-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206073948.181792-1-ebiggers@kernel.org>
References: <20250206073948.181792-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Add x86_64 [V]PCLMULQDQ optimized implementations of crc64_be() and
crc64_nvme() by wiring them up to crc-pclmul-template.S.

crc64_be() is used by bcache and bcachefs, and crc64_nvme() is used by
blk-integrity.  Both features can CRC large amounts of data, and the
developers of both features have expressed interest in having these CRCs
be optimized.  So this optimization should be worthwhile.  (See
https://lore.kernel.org/r/v36sousjd5ukqlkpdxslvpu7l37zbu7d7slgc2trjjqwty2bny@qgzew34feo2r
and
https://lore.kernel.org/r/20220222163144.1782447-11-kbusch@kernel.org)

Benchmark results on AMD Ryzen 9 9950X (Zen 5) using crc_kunit:

crc64_be:

	Length     Before        After
	------     ------        -----
	     1     633 MB/s      477 MB/s
	    16     717 MB/s     2517 MB/s
	    64     715 MB/s     7525 MB/s
	   127     714 MB/s    10002 MB/s
	   128     713 MB/s    13344 MB/s
	   200     715 MB/s    15752 MB/s
	   256     714 MB/s    22933 MB/s
	   511     715 MB/s    28025 MB/s
	   512     714 MB/s    49772 MB/s
	  1024     715 MB/s    65261 MB/s
	  3173     714 MB/s    78773 MB/s
	  4096     714 MB/s    83315 MB/s
	 16384     714 MB/s    89487 MB/s

crc64_nvme:

        Length     Before        After
	------     ------        -----
	     1     716 MB/s      474 MB/s
	    16     717 MB/s     3303 MB/s
	    64     713 MB/s     7940 MB/s
	   127     715 MB/s     9867 MB/s
	   128     714 MB/s    13698 MB/s
	   200     715 MB/s    15995 MB/s
	   256     714 MB/s    23479 MB/s
	   511     714 MB/s    28013 MB/s
	   512     715 MB/s    51533 MB/s
	  1024     715 MB/s    66788 MB/s
	  3173     715 MB/s    79182 MB/s
	  4096     715 MB/s    83966 MB/s
	 16384     715 MB/s    89739 MB/s

Acked-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/Kconfig                 |  1 +
 arch/x86/lib/Makefile            |  3 +
 arch/x86/lib/crc-pclmul-consts.h | 98 +++++++++++++++++++++++++++++++-
 arch/x86/lib/crc64-glue.c        | 50 ++++++++++++++++
 arch/x86/lib/crc64-pclmul.S      |  7 +++
 5 files changed, 158 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/lib/crc64-glue.c
 create mode 100644 arch/x86/lib/crc64-pclmul.S

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7f59d73201ce7..aa7c9d57e4d37 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -75,10 +75,11 @@ config X86
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_CPU_PASID		if IOMMU_SVA
 	select ARCH_HAS_CRC32
+	select ARCH_HAS_CRC64			if X86_64
 	select ARCH_HAS_CRC_T10DIF
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE	if !X86_PAE
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 08496e221a7d1..71c14329fd799 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -40,10 +40,13 @@ lib-$(CONFIG_MITIGATION_RETPOLINE) += retpoline.o
 
 obj-$(CONFIG_CRC32_ARCH) += crc32-x86.o
 crc32-x86-y := crc32-glue.o crc32-pclmul.o
 crc32-x86-$(CONFIG_64BIT) += crc32c-3way.o
 
+obj-$(CONFIG_CRC64_ARCH) += crc64-x86.o
+crc64-x86-y := crc64-glue.o crc64-pclmul.o
+
 obj-$(CONFIG_CRC_T10DIF_ARCH) += crc-t10dif-x86.o
 crc-t10dif-x86-y := crc-t10dif-glue.o crc16-msb-pclmul.o
 
 obj-y += msr.o msr-reg.o msr-reg-export.o hweight.o
 obj-y += iomem.o
diff --git a/arch/x86/lib/crc-pclmul-consts.h b/arch/x86/lib/crc-pclmul-consts.h
index 089954988f977..fcc63c0643330 100644
--- a/arch/x86/lib/crc-pclmul-consts.h
+++ b/arch/x86/lib/crc-pclmul-consts.h
@@ -1,10 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * CRC constants generated by:
  *
- *	./scripts/gen-crc-consts.py x86_pclmul crc16_msb_0x8bb7,crc32_lsb_0xedb88320
+ *	./scripts/gen-crc-consts.py x86_pclmul crc16_msb_0x8bb7,crc32_lsb_0xedb88320,crc64_msb_0x42f0e1eba9ea3693,crc64_lsb_0x9a6c9329ac4bc9b5
  *
  * Do not edit manually.
  */
 
 /*
@@ -95,5 +95,101 @@ static const struct {
 	.barrett_reduction_consts = {
 		0xb4e5b025f7011641,	/* HI64_TERMS: floor(x^95 / G) */
 		0x00000001db710640,	/* LO64_TERMS: (G - x^32) * x^31 */
 	},
 };
+
+/*
+ * CRC folding constants generated for most-significant-bit-first CRC-64 using
+ * G(x) = x^64 + x^62 + x^57 + x^55 + x^54 + x^53 + x^52 + x^47 + x^46 + x^45 +
+ *        x^40 + x^39 + x^38 + x^37 + x^35 + x^33 + x^32 + x^31 + x^29 + x^27 +
+ *        x^24 + x^23 + x^22 + x^21 + x^19 + x^17 + x^13 + x^12 + x^10 + x^9 +
+ *        x^7 + x^4 + x^1 + x^0
+ */
+static const struct {
+	u8 bswap_mask[16];
+	u64 fold_across_2048_bits_consts[2];
+	u64 fold_across_1024_bits_consts[2];
+	u64 fold_across_512_bits_consts[2];
+	u64 fold_across_256_bits_consts[2];
+	u64 fold_across_128_bits_consts[2];
+	u8 shuf_table[48];
+	u64 barrett_reduction_consts[2];
+} crc64_msb_0x42f0e1eba9ea3693_consts ____cacheline_aligned __maybe_unused = {
+	.bswap_mask = {15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0},
+	.fold_across_2048_bits_consts = {
+		0x7f52691a60ddc70d,	/* LO64_TERMS: (x^2048 mod G) * x^0 */
+		0x7036b0389f6a0c82,	/* HI64_TERMS: (x^2112 mod G) * x^0 */
+	},
+	.fold_across_1024_bits_consts = {
+		0x05cf79dea9ac37d6,	/* LO64_TERMS: (x^1024 mod G) * x^0 */
+		0x001067e571d7d5c2,	/* HI64_TERMS: (x^1088 mod G) * x^0 */
+	},
+	.fold_across_512_bits_consts = {
+		0x5f6843ca540df020,	/* LO64_TERMS: (x^512 mod G) * x^0 */
+		0xddf4b6981205b83f,	/* HI64_TERMS: (x^576 mod G) * x^0 */
+	},
+	.fold_across_256_bits_consts = {
+		0x571bee0a227ef92b,	/* LO64_TERMS: (x^256 mod G) * x^0 */
+		0x44bef2a201b5200c,	/* HI64_TERMS: (x^320 mod G) * x^0 */
+	},
+	.fold_across_128_bits_consts = {
+		0x05f5c3c7eb52fab6,	/* LO64_TERMS: (x^128 mod G) * x^0 */
+		0x4eb938a7d257740e,	/* HI64_TERMS: (x^192 mod G) * x^0 */
+	},
+	.shuf_table = {
+		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
+		 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
+		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
+	},
+	.barrett_reduction_consts = {
+		0x42f0e1eba9ea3693,	/* LO64_TERMS: (G - x^64) * x^0 */
+		0x578d29d06cc4f872,	/* HI64_TERMS: (floor(x^127 / G) * x) - x^64 */
+	},
+};
+
+/*
+ * CRC folding constants generated for least-significant-bit-first CRC-64 using
+ * G(x) = x^64 + x^63 + x^61 + x^59 + x^58 + x^56 + x^55 + x^52 + x^49 + x^48 +
+ *        x^47 + x^46 + x^44 + x^41 + x^37 + x^36 + x^34 + x^32 + x^31 + x^28 +
+ *        x^26 + x^23 + x^22 + x^19 + x^16 + x^13 + x^12 + x^10 + x^9 + x^6 +
+ *        x^4 + x^3 + x^0
+ */
+static const struct {
+	u64 fold_across_2048_bits_consts[2];
+	u64 fold_across_1024_bits_consts[2];
+	u64 fold_across_512_bits_consts[2];
+	u64 fold_across_256_bits_consts[2];
+	u64 fold_across_128_bits_consts[2];
+	u8 shuf_table[48];
+	u64 barrett_reduction_consts[2];
+} crc64_lsb_0x9a6c9329ac4bc9b5_consts ____cacheline_aligned __maybe_unused = {
+	.fold_across_2048_bits_consts = {
+		0x37ccd3e14069cabc,	/* HI64_TERMS: (x^2111 mod G) * x^0 */
+		0xa043808c0f782663,	/* LO64_TERMS: (x^2047 mod G) * x^0 */
+	},
+	.fold_across_1024_bits_consts = {
+		0xa1ca681e733f9c40,	/* HI64_TERMS: (x^1087 mod G) * x^0 */
+		0x5f852fb61e8d92dc,	/* LO64_TERMS: (x^1023 mod G) * x^0 */
+	},
+	.fold_across_512_bits_consts = {
+		0x0c32cdb31e18a84a,	/* HI64_TERMS: (x^575 mod G) * x^0 */
+		0x62242240ace5045a,	/* LO64_TERMS: (x^511 mod G) * x^0 */
+	},
+	.fold_across_256_bits_consts = {
+		0xb0bc2e589204f500,	/* HI64_TERMS: (x^319 mod G) * x^0 */
+		0xe1e0bb9d45d7a44c,	/* LO64_TERMS: (x^255 mod G) * x^0 */
+	},
+	.fold_across_128_bits_consts = {
+		0xeadc41fd2ba3d420,	/* HI64_TERMS: (x^191 mod G) * x^0 */
+		0x21e9761e252621ac,	/* LO64_TERMS: (x^127 mod G) * x^0 */
+	},
+	.shuf_table = {
+		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
+		 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
+		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
+	},
+	.barrett_reduction_consts = {
+		0x27ecfa329aef9f77,	/* HI64_TERMS: floor(x^127 / G) */
+		0x34d926535897936a,	/* LO64_TERMS: (G - x^64 - x^0) / x */
+	},
+};
diff --git a/arch/x86/lib/crc64-glue.c b/arch/x86/lib/crc64-glue.c
new file mode 100644
index 0000000000000..b0e1b719ecbfb
--- /dev/null
+++ b/arch/x86/lib/crc64-glue.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * CRC64 using [V]PCLMULQDQ instructions
+ *
+ * Copyright 2025 Google LLC
+ */
+
+#include <linux/crc64.h>
+#include <linux/module.h>
+#include "crc-pclmul-template.h"
+
+static DEFINE_STATIC_KEY_FALSE(have_pclmulqdq);
+
+DECLARE_CRC_PCLMUL_FUNCS(crc64_msb, u64);
+DECLARE_CRC_PCLMUL_FUNCS(crc64_lsb, u64);
+
+u64 crc64_be_arch(u64 crc, const u8 *p, size_t len)
+{
+	CRC_PCLMUL(crc, p, len, crc64_msb, crc64_msb_0x42f0e1eba9ea3693_consts,
+		   have_pclmulqdq);
+	return crc64_be_generic(crc, p, len);
+}
+EXPORT_SYMBOL_GPL(crc64_be_arch);
+
+u64 crc64_nvme_arch(u64 crc, const u8 *p, size_t len)
+{
+	CRC_PCLMUL(crc, p, len, crc64_lsb, crc64_lsb_0x9a6c9329ac4bc9b5_consts,
+		   have_pclmulqdq);
+	return crc64_nvme_generic(crc, p, len);
+}
+EXPORT_SYMBOL_GPL(crc64_nvme_arch);
+
+static int __init crc64_x86_init(void)
+{
+	if (boot_cpu_has(X86_FEATURE_PCLMULQDQ)) {
+		static_branch_enable(&have_pclmulqdq);
+		INIT_CRC_PCLMUL(crc64_msb);
+		INIT_CRC_PCLMUL(crc64_lsb);
+	}
+	return 0;
+}
+arch_initcall(crc64_x86_init);
+
+static void __exit crc64_x86_exit(void)
+{
+}
+module_exit(crc64_x86_exit);
+
+MODULE_DESCRIPTION("CRC64 using [V]PCLMULQDQ instructions");
+MODULE_LICENSE("GPL");
diff --git a/arch/x86/lib/crc64-pclmul.S b/arch/x86/lib/crc64-pclmul.S
new file mode 100644
index 0000000000000..4173051b5197c
--- /dev/null
+++ b/arch/x86/lib/crc64-pclmul.S
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+// Copyright 2025 Google LLC
+
+#include "crc-pclmul-template.S"
+
+DEFINE_CRC_PCLMUL_FUNCS(crc64_msb, /* bits= */ 64, /* lsb= */ 0)
+DEFINE_CRC_PCLMUL_FUNCS(crc64_lsb, /* bits= */ 64, /* lsb= */ 1)
-- 
2.48.1



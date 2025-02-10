Return-Path: <linux-crypto+bounces-9628-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDB6A2F5BF
	for <lists+linux-crypto@lfdr.de>; Mon, 10 Feb 2025 18:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD033A9D50
	for <lists+linux-crypto@lfdr.de>; Mon, 10 Feb 2025 17:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133F5257AD0;
	Mon, 10 Feb 2025 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5UCLQ+p"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E96257456;
	Mon, 10 Feb 2025 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209562; cv=none; b=FeBq0HWR/afBNejmYsVE94r26ZDXKRJ/UBaIlCVYoM+9Y97OHdpdbfV2YKj08SUpvAj1MIhcKb3eu/siNt05AkXpd5Zid7x8z1zv37FVUW/iRXgGdYVj1vu4bDh2WHQhcoolgpwDAMVU+q9KkRUOUtNGX3FKeeqJvRQluFYoYHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209562; c=relaxed/simple;
	bh=F4V82h98SHCOKzxf3nBrpwV7MPYF4gyLV1ygLyE8b+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IY0IMapNm2taHVr/Haiu2GUqe/B7Biou4JY42fwFIcq5MgIaXQ7ZMg+TxLv/kolIitdlnu1g+P6FKSnHg+mwx3MIrszOhc/0oFyA0CL8gw70GqDBnmd83m6euI+4Ta776ysXh6Sd9n7L1MyUK+jOWMclnJVYBKR0bsaEq7w7Xcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5UCLQ+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05032C4CEE7;
	Mon, 10 Feb 2025 17:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739209562;
	bh=F4V82h98SHCOKzxf3nBrpwV7MPYF4gyLV1ygLyE8b+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R5UCLQ+puGZaD6dtGGZf6eD0vpXXfDYk3kc9equrs5pMkBGT4MVAMmtpXpo/VYrys
	 lQ6hdCYq2/peAC3NaQR65v6OyKSE7LiTn/QKZpvpWuZ0dQVC8UXZ37ZFSvWhy/GiKY
	 Jr6/8hsEBwhdoxYYN46dDeTDTSrezN8rxd5gNnb8+PPxawDMN/v0+obfLFBi4Y/3Z8
	 SokwXWPBTMTQwFbW/WY1umnIgvR2Hpy/NeV9fBlZLnCYS2+C74pUy5tp8ENvhPX+KW
	 Pq2BHxIK3iEh+7V5ttsUepFcvq6PyOfNngHhaYR7vrd9XfAbIW/MOkosxcvj2aEcG3
	 YcW9zL0p6iHKg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	x86@kernel.org,
	linux-block@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v4 4/6] x86/crc32: implement crc32_le using new template
Date: Mon, 10 Feb 2025 09:45:38 -0800
Message-ID: <20250210174540.161705-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210174540.161705-1-ebiggers@kernel.org>
References: <20250210174540.161705-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Instantiate crc-pclmul-template.S for crc32_le, and delete the original
PCLMULQDQ optimized implementation.  This has the following advantages:

- Less CRC-variant-specific code.
- VPCLMULQDQ support, greatly improving performance on sufficiently long
  messages on newer CPUs.
- A faster reduction from 128 bits to the final CRC.
- Support for lengths not a multiple of 16 bytes, improving performance
  for such lengths.
- Support for misaligned buffers, improving performance in such cases.

Benchmark results on AMD Ryzen 9 9950X (Zen 5) using crc_kunit:

	Length     Before        After
	------     ------        -----
	     1     427 MB/s      605 MB/s
	    16     710 MB/s     3631 MB/s
	    64     704 MB/s     7615 MB/s
	   127    3610 MB/s     9710 MB/s
	   128    8759 MB/s    12702 MB/s
	   200    7083 MB/s    15343 MB/s
	   256   17284 MB/s    22904 MB/s
	   511   10919 MB/s    27309 MB/s
	   512   19849 MB/s    48900 MB/s
	  1024   21216 MB/s    62630 MB/s
	  3173   22150 MB/s    72437 MB/s
	  4096   22496 MB/s    79593 MB/s
	 16384   22018 MB/s    85106 MB/s

Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: "Martin K. Petersen" <martin.petersen@oracle.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/lib/crc-pclmul-consts.h |  53 ++++++++
 arch/x86/lib/crc32-glue.c        |  37 ++----
 arch/x86/lib/crc32-pclmul.S      | 219 +------------------------------
 3 files changed, 65 insertions(+), 244 deletions(-)
 create mode 100644 arch/x86/lib/crc-pclmul-consts.h

diff --git a/arch/x86/lib/crc-pclmul-consts.h b/arch/x86/lib/crc-pclmul-consts.h
new file mode 100644
index 0000000000000..34fdcb0446b03
--- /dev/null
+++ b/arch/x86/lib/crc-pclmul-consts.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * CRC constants generated by:
+ *
+ *	./scripts/gen-crc-consts.py x86_pclmul crc32_lsb_0xedb88320
+ *
+ * Do not edit manually.
+ */
+
+/*
+ * CRC folding constants generated for least-significant-bit-first CRC-32 using
+ * G(x) = x^32 + x^26 + x^23 + x^22 + x^16 + x^12 + x^11 + x^10 + x^8 + x^7 +
+ *        x^5 + x^4 + x^2 + x^1 + x^0
+ */
+static const struct {
+	u64 fold_across_2048_bits_consts[2];
+	u64 fold_across_1024_bits_consts[2];
+	u64 fold_across_512_bits_consts[2];
+	u64 fold_across_256_bits_consts[2];
+	u64 fold_across_128_bits_consts[2];
+	u8 shuf_table[48];
+	u64 barrett_reduction_consts[2];
+} crc32_lsb_0xedb88320_consts ____cacheline_aligned __maybe_unused = {
+	.fold_across_2048_bits_consts = {
+		0x00000000ce3371cb,	/* HI64_TERMS: (x^2079 mod G) * x^32 */
+		0x00000000e95c1271,	/* LO64_TERMS: (x^2015 mod G) * x^32 */
+	},
+	.fold_across_1024_bits_consts = {
+		0x0000000033fff533,	/* HI64_TERMS: (x^1055 mod G) * x^32 */
+		0x00000000910eeec1,	/* LO64_TERMS: (x^991 mod G) * x^32 */
+	},
+	.fold_across_512_bits_consts = {
+		0x000000008f352d95,	/* HI64_TERMS: (x^543 mod G) * x^32 */
+		0x000000001d9513d7,	/* LO64_TERMS: (x^479 mod G) * x^32 */
+	},
+	.fold_across_256_bits_consts = {
+		0x00000000f1da05aa,	/* HI64_TERMS: (x^287 mod G) * x^32 */
+		0x0000000081256527,	/* LO64_TERMS: (x^223 mod G) * x^32 */
+	},
+	.fold_across_128_bits_consts = {
+		0x00000000ae689191,	/* HI64_TERMS: (x^159 mod G) * x^32 */
+		0x00000000ccaa009e,	/* LO64_TERMS: (x^95 mod G) * x^32 */
+	},
+	.shuf_table = {
+		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
+		 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
+		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
+	},
+	.barrett_reduction_consts = {
+		0xb4e5b025f7011641,	/* HI64_TERMS: floor(x^95 / G) */
+		0x00000001db710640,	/* LO64_TERMS: (G - x^32) * x^31 */
+	},
+};
diff --git a/arch/x86/lib/crc32-glue.c b/arch/x86/lib/crc32-glue.c
index 131c305e9ea0d..9c3f9c1b7bb9d 100644
--- a/arch/x86/lib/crc32-glue.c
+++ b/arch/x86/lib/crc32-glue.c
@@ -5,47 +5,24 @@
  * Copyright (C) 2008 Intel Corporation
  * Copyright 2012 Xyratex Technology Limited
  * Copyright 2024 Google LLC
  */
 
-#include <asm/cpufeatures.h>
-#include <asm/simd.h>
-#include <crypto/internal/simd.h>
 #include <linux/crc32.h>
-#include <linux/linkage.h>
 #include <linux/module.h>
-
-/* minimum size of buffer for crc32_pclmul_le_16 */
-#define CRC32_PCLMUL_MIN_LEN	64
+#include "crc-pclmul-template.h"
 
 static DEFINE_STATIC_KEY_FALSE(have_crc32);
 static DEFINE_STATIC_KEY_FALSE(have_pclmulqdq);
 
-u32 crc32_pclmul_le_16(u32 crc, const u8 *buffer, size_t len);
+DECLARE_CRC_PCLMUL_FUNCS(crc32_lsb, u32);
 
 u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
 {
-	if (len >= CRC32_PCLMUL_MIN_LEN + 15 &&
-	    static_branch_likely(&have_pclmulqdq) && crypto_simd_usable()) {
-		size_t n = -(uintptr_t)p & 15;
-
-		/* align p to 16-byte boundary */
-		if (n) {
-			crc = crc32_le_base(crc, p, n);
-			p += n;
-			len -= n;
-		}
-		n = round_down(len, 16);
-		kernel_fpu_begin();
-		crc = crc32_pclmul_le_16(crc, p, n);
-		kernel_fpu_end();
-		p += n;
-		len -= n;
-	}
-	if (len)
-		crc = crc32_le_base(crc, p, len);
-	return crc;
+	CRC_PCLMUL(crc, p, len, crc32_lsb, crc32_lsb_0xedb88320_consts,
+		   have_pclmulqdq);
+	return crc32_le_base(crc, p, len);
 }
 EXPORT_SYMBOL(crc32_le_arch);
 
 #ifdef CONFIG_X86_64
 #define CRC32_INST "crc32q %1, %q0"
@@ -95,12 +72,14 @@ EXPORT_SYMBOL(crc32_be_arch);
 
 static int __init crc32_x86_init(void)
 {
 	if (boot_cpu_has(X86_FEATURE_XMM4_2))
 		static_branch_enable(&have_crc32);
-	if (boot_cpu_has(X86_FEATURE_PCLMULQDQ))
+	if (boot_cpu_has(X86_FEATURE_PCLMULQDQ)) {
 		static_branch_enable(&have_pclmulqdq);
+		INIT_CRC_PCLMUL(crc32_lsb);
+	}
 	return 0;
 }
 arch_initcall(crc32_x86_init);
 
 static void __exit crc32_x86_exit(void)
diff --git a/arch/x86/lib/crc32-pclmul.S b/arch/x86/lib/crc32-pclmul.S
index f9637789cac19..f20f40fb0172d 100644
--- a/arch/x86/lib/crc32-pclmul.S
+++ b/arch/x86/lib/crc32-pclmul.S
@@ -1,217 +1,6 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright 2012 Xyratex Technology Limited
- *
- * Using hardware provided PCLMULQDQ instruction to accelerate the CRC32
- * calculation.
- * CRC32 polynomial:0x04c11db7(BE)/0xEDB88320(LE)
- * PCLMULQDQ is a new instruction in Intel SSE4.2, the reference can be found
- * at:
- * http://www.intel.com/products/processor/manuals/
- * Intel(R) 64 and IA-32 Architectures Software Developer's Manual
- * Volume 2B: Instruction Set Reference, N-Z
- *
- * Authors:   Gregory Prestas <Gregory_Prestas@us.xyratex.com>
- *	      Alexander Boyko <Alexander_Boyko@xyratex.com>
- */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+// Copyright 2025 Google LLC
 
-#include <linux/linkage.h>
+#include "crc-pclmul-template.S"
 
-
-.section .rodata
-.align 16
-/*
- * [x4*128+32 mod P(x) << 32)]'  << 1   = 0x154442bd4
- * #define CONSTANT_R1  0x154442bd4LL
- *
- * [(x4*128-32 mod P(x) << 32)]' << 1   = 0x1c6e41596
- * #define CONSTANT_R2  0x1c6e41596LL
- */
-.Lconstant_R2R1:
-	.octa 0x00000001c6e415960000000154442bd4
-/*
- * [(x128+32 mod P(x) << 32)]'   << 1   = 0x1751997d0
- * #define CONSTANT_R3  0x1751997d0LL
- *
- * [(x128-32 mod P(x) << 32)]'   << 1   = 0x0ccaa009e
- * #define CONSTANT_R4  0x0ccaa009eLL
- */
-.Lconstant_R4R3:
-	.octa 0x00000000ccaa009e00000001751997d0
-/*
- * [(x64 mod P(x) << 32)]'       << 1   = 0x163cd6124
- * #define CONSTANT_R5  0x163cd6124LL
- */
-.Lconstant_R5:
-	.octa 0x00000000000000000000000163cd6124
-.Lconstant_mask32:
-	.octa 0x000000000000000000000000FFFFFFFF
-/*
- * #define CRCPOLY_TRUE_LE_FULL 0x1DB710641LL
- *
- * Barrett Reduction constant (u64`) = u` = (x**64 / P(x))` = 0x1F7011641LL
- * #define CONSTANT_RU  0x1F7011641LL
- */
-.Lconstant_RUpoly:
-	.octa 0x00000001F701164100000001DB710641
-
-#define CONSTANT %xmm0
-
-#ifdef __x86_64__
-#define CRC     %edi
-#define BUF     %rsi
-#define LEN     %rdx
-#else
-#define CRC     %eax
-#define BUF     %edx
-#define LEN     %ecx
-#endif
-
-
-
-.text
-/**
- *      Calculate crc32
- *      CRC - initial crc32
- *      BUF - buffer (16 bytes aligned)
- *      LEN - sizeof buffer (16 bytes aligned), LEN should be greater than 63
- *      return %eax crc32
- *      u32 crc32_pclmul_le_16(u32 crc, const u8 *buffer, size_t len);
- */
-
-SYM_FUNC_START(crc32_pclmul_le_16) /* buffer and buffer size are 16 bytes aligned */
-	movdqa  (BUF), %xmm1
-	movdqa  0x10(BUF), %xmm2
-	movdqa  0x20(BUF), %xmm3
-	movdqa  0x30(BUF), %xmm4
-	movd    CRC, CONSTANT
-	pxor    CONSTANT, %xmm1
-	sub     $0x40, LEN
-	add     $0x40, BUF
-	cmp     $0x40, LEN
-	jb      .Lless_64
-
-#ifdef __x86_64__
-	movdqa .Lconstant_R2R1(%rip), CONSTANT
-#else
-	movdqa .Lconstant_R2R1, CONSTANT
-#endif
-
-.Lloop_64:/*  64 bytes Full cache line folding */
-	prefetchnta    0x40(BUF)
-	movdqa  %xmm1, %xmm5
-	movdqa  %xmm2, %xmm6
-	movdqa  %xmm3, %xmm7
-#ifdef __x86_64__
-	movdqa  %xmm4, %xmm8
-#endif
-	pclmulqdq $0x00, CONSTANT, %xmm1
-	pclmulqdq $0x00, CONSTANT, %xmm2
-	pclmulqdq $0x00, CONSTANT, %xmm3
-#ifdef __x86_64__
-	pclmulqdq $0x00, CONSTANT, %xmm4
-#endif
-	pclmulqdq $0x11, CONSTANT, %xmm5
-	pclmulqdq $0x11, CONSTANT, %xmm6
-	pclmulqdq $0x11, CONSTANT, %xmm7
-#ifdef __x86_64__
-	pclmulqdq $0x11, CONSTANT, %xmm8
-#endif
-	pxor    %xmm5, %xmm1
-	pxor    %xmm6, %xmm2
-	pxor    %xmm7, %xmm3
-#ifdef __x86_64__
-	pxor    %xmm8, %xmm4
-#else
-	/* xmm8 unsupported for x32 */
-	movdqa  %xmm4, %xmm5
-	pclmulqdq $0x00, CONSTANT, %xmm4
-	pclmulqdq $0x11, CONSTANT, %xmm5
-	pxor    %xmm5, %xmm4
-#endif
-
-	pxor    (BUF), %xmm1
-	pxor    0x10(BUF), %xmm2
-	pxor    0x20(BUF), %xmm3
-	pxor    0x30(BUF), %xmm4
-
-	sub     $0x40, LEN
-	add     $0x40, BUF
-	cmp     $0x40, LEN
-	jge     .Lloop_64
-.Lless_64:/*  Folding cache line into 128bit */
-#ifdef __x86_64__
-	movdqa  .Lconstant_R4R3(%rip), CONSTANT
-#else
-	movdqa  .Lconstant_R4R3, CONSTANT
-#endif
-	prefetchnta     (BUF)
-
-	movdqa  %xmm1, %xmm5
-	pclmulqdq $0x00, CONSTANT, %xmm1
-	pclmulqdq $0x11, CONSTANT, %xmm5
-	pxor    %xmm5, %xmm1
-	pxor    %xmm2, %xmm1
-
-	movdqa  %xmm1, %xmm5
-	pclmulqdq $0x00, CONSTANT, %xmm1
-	pclmulqdq $0x11, CONSTANT, %xmm5
-	pxor    %xmm5, %xmm1
-	pxor    %xmm3, %xmm1
-
-	movdqa  %xmm1, %xmm5
-	pclmulqdq $0x00, CONSTANT, %xmm1
-	pclmulqdq $0x11, CONSTANT, %xmm5
-	pxor    %xmm5, %xmm1
-	pxor    %xmm4, %xmm1
-
-	cmp     $0x10, LEN
-	jb      .Lfold_64
-.Lloop_16:/* Folding rest buffer into 128bit */
-	movdqa  %xmm1, %xmm5
-	pclmulqdq $0x00, CONSTANT, %xmm1
-	pclmulqdq $0x11, CONSTANT, %xmm5
-	pxor    %xmm5, %xmm1
-	pxor    (BUF), %xmm1
-	sub     $0x10, LEN
-	add     $0x10, BUF
-	cmp     $0x10, LEN
-	jge     .Lloop_16
-
-.Lfold_64:
-	/* perform the last 64 bit fold, also adds 32 zeroes
-	 * to the input stream */
-	pclmulqdq $0x01, %xmm1, CONSTANT /* R4 * xmm1.low */
-	psrldq  $0x08, %xmm1
-	pxor    CONSTANT, %xmm1
-
-	/* final 32-bit fold */
-	movdqa  %xmm1, %xmm2
-#ifdef __x86_64__
-	movdqa  .Lconstant_R5(%rip), CONSTANT
-	movdqa  .Lconstant_mask32(%rip), %xmm3
-#else
-	movdqa  .Lconstant_R5, CONSTANT
-	movdqa  .Lconstant_mask32, %xmm3
-#endif
-	psrldq  $0x04, %xmm2
-	pand    %xmm3, %xmm1
-	pclmulqdq $0x00, CONSTANT, %xmm1
-	pxor    %xmm2, %xmm1
-
-	/* Finish up with the bit-reversed barrett reduction 64 ==> 32 bits */
-#ifdef __x86_64__
-	movdqa  .Lconstant_RUpoly(%rip), CONSTANT
-#else
-	movdqa  .Lconstant_RUpoly, CONSTANT
-#endif
-	movdqa  %xmm1, %xmm2
-	pand    %xmm3, %xmm1
-	pclmulqdq $0x10, CONSTANT, %xmm1
-	pand    %xmm3, %xmm1
-	pclmulqdq $0x00, CONSTANT, %xmm1
-	pxor    %xmm2, %xmm1
-	pextrd  $0x01, %xmm1, %eax
-
-	RET
-SYM_FUNC_END(crc32_pclmul_le_16)
+DEFINE_CRC_PCLMUL_FUNCS(crc32_lsb, /* bits= */ 32, /* lsb= */ 1)
-- 
2.48.1



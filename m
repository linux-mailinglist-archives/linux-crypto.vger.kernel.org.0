Return-Path: <linux-crypto+bounces-9244-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DFEA20472
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Jan 2025 07:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCE1F18823F8
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Jan 2025 06:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AFD5789D;
	Tue, 28 Jan 2025 06:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buSqFZgy"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB9212F5A5;
	Tue, 28 Jan 2025 06:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738045956; cv=none; b=E7mrujx/ZQwq682gaYjVX4Y3QWnluD82lguYqYV/Ut1nTzGAZVWfZZmY5M1AfjiFHVEhj4BcIFXihG0FQMXfxpMMilvKxG3kclVTK4M08As8UC+EECJRct4eFN4jL0LXBXn9wOdAa90sAwWg9xAqfNPFYgcLBTgHrPTIvvAougw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738045956; c=relaxed/simple;
	bh=DqN0FW0FXn1ItWWST6KPwQSxQ/5Ui1tP7U1q7rclG0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xr56HTqHzR254kOG5QC+SjVaoaja32BXdKEyFyiOGe54vZKGFp9uTJP2QkfQs2KC63UrEEn1Z3OBKk2Artq7ZnS3j1oyMokp+QTKjvBe9HbRiB2Swb+S5j+vIRvJvP7U8NkUCAJgWYL4zLzD5TJygE/Xpjo/gDss3Fw6M1RO3vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buSqFZgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7FDC4CED3;
	Tue, 28 Jan 2025 06:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738045955;
	bh=DqN0FW0FXn1ItWWST6KPwQSxQ/5Ui1tP7U1q7rclG0I=;
	h=From:To:Cc:Subject:Date:From;
	b=buSqFZgyq1t3RK7TK+aL7++cIcZdq2QLkUaorCKaEVd94MN1rq+yttC8yIhOXHc7M
	 RSl/z1pYQcJnHWm7QLih5qc5n/WkdUr+gCGqSe/RWbufprTrhe283+Igf8hpdPLRE7
	 Vtb+73Lwi0S1Hryb7StS5B+SLRywmuKT8wdSofRgoe4oSq5YeuwFDsFo8ww+S0xFxq
	 RLy2AdVag1Q/6lWjoqPefzxfI2GUQ3+r7TYIraqkwzk6rDqgFGc95qrJUx+YQd9xm9
	 tbxlOQfQIUYbE+MCfdYwQgXsLklh68tSwL97QJBwRK6OGEl3tr4UDaIh+jEr88Q3JN
	 ADsIKRIeYVRXA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH] crypto: x86/aes-ctr - rewrite AES-NI optimized CTR and add VAES support
Date: Mon, 27 Jan 2025 22:31:18 -0800
Message-ID: <20250128063118.187690-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Delete aes_ctrby8_avx-x86_64.S and add a new assembly file
aes-ctr-avx-x86_64.S which follows a similar approach to
aes-xts-avx-x86_64.S in that it uses a "template" to provide AESNI+AVX,
VAES+AVX2, VAES+AVX10/256, and VAES+AVX10/512 code, instead of just
AESNI+AVX.  Wire it up to the crypto API accordingly.

This greatly improves the performance of AES-CTR and AES-XCTR on
VAES-capable CPUs, with the best case being AMD Zen 5 where an over 230%
increase in throughput (i.e. over 3.3x faster) is seen on long messages.
Performance on older CPUs remains about the same.  There are some slight
regressions (less than 10%) on some short message lengths on some CPUs;
these are difficult to avoid, given how the previous code was so heavily
unrolled by message length, and they are not particularly important.
Detailed performance results are given in the tables below.

Both CTR and XCTR support is retained.  The main loop remains
8-vector-wide, which differs from the 4-vector-wide main loops that are
used in the XTS and GCM code.  A wider loop is appropriate for CTR and
XCTR since they have fewer other instructions (such as vpclmulqdq) to
interleave with the AES instructions.

Similar to what was the case for AES-GCM, the new assembly code also has
a much smaller binary size, as it fixes the excessive unrolling by data
length and key length present in the old code.  Specifically, the new
assembly file compiles to about 9 KB of text vs. 28 KB for the old file.
This is despite 4x as many implementations being included.

The tables below show the detailed performance results.  The tables show
percentage improvement in single-threaded throughput for repeated
encryption of the given message length; an increase from 6000 MB/s to
12000 MB/s would be listed as 100%.  They were collected by directly
measuring the Linux crypto API performance using a custom kernel module.
The tested CPUs were all server processors from Google Compute Engine
except for Zen 5 which was a Ryzen 9 9950X desktop processor.

Table 1: AES-256-CTR throughput improvement,
         CPU microarchitecture vs. message length in bytes:

                     | 16384 |  4096 |  4095 |  1420 |   512 |   500 |
---------------------+-------+-------+-------+-------+-------+-------+
AMD Zen 5            |  232% |  203% |  212% |  143% |   71% |   95% |
Intel Emerald Rapids |  116% |  116% |  117% |   91% |   78% |   79% |
Intel Ice Lake       |  109% |  103% |  107% |   81% |   54% |   56% |
AMD Zen 4            |  109% |   91% |  100% |   70% |   43% |   59% |
AMD Zen 3            |   92% |   78% |   87% |   57% |   32% |   43% |
AMD Zen 2            |    9% |    8% |   14% |   12% |    8% |   21% |
Intel Skylake        |    7% |    7% |    8% |    5% |    3% |    8% |

                     |   300 |   200 |    64 |    63 |    16 |
---------------------+-------+-------+-------+-------+-------+
AMD Zen 5            |   57% |   39% |   -9% |    7% |   -7% |
Intel Emerald Rapids |   37% |   42% |   -0% |   13% |   -8% |
Intel Ice Lake       |   39% |   30% |   -1% |   14% |   -9% |
AMD Zen 4            |   42% |   38% |   -0% |   18% |   -3% |
AMD Zen 3            |   38% |   35% |    6% |   31% |    5% |
AMD Zen 2            |   24% |   23% |    5% |   30% |    3% |
Intel Skylake        |    9% |    1% |   -4% |   10% |   -7% |

Table 2: AES-256-XCTR throughput improvement,
         CPU microarchitecture vs. message length in bytes:

                     | 16384 |  4096 |  4095 |  1420 |   512 |   500 |
---------------------+-------+-------+-------+-------+-------+-------+
AMD Zen 5            |  240% |  201% |  216% |  151% |   75% |  108% |
Intel Emerald Rapids |  100% |   99% |  102% |   91% |   94% |  104% |
Intel Ice Lake       |   93% |   89% |   92% |   74% |   50% |   64% |
AMD Zen 4            |   86% |   75% |   83% |   60% |   41% |   52% |
AMD Zen 3            |   73% |   63% |   69% |   45% |   21% |   33% |
AMD Zen 2            |   -2% |   -2% |    2% |    3% |   -1% |   11% |
Intel Skylake        |   -1% |   -1% |    1% |    2% |   -1% |    9% |

                     |   300 |   200 |    64 |    63 |    16 |
---------------------+-------+-------+-------+-------+-------+
AMD Zen 5            |   78% |   56% |   -4% |   38% |   -2% |
Intel Emerald Rapids |   61% |   55% |    4% |   32% |   -5% |
Intel Ice Lake       |   57% |   42% |    3% |   44% |   -4% |
AMD Zen 4            |   35% |   28% |   -1% |   17% |   -3% |
AMD Zen 3            |   26% |   23% |   -3% |   11% |   -6% |
AMD Zen 2            |   13% |   24% |   -1% |   14% |   -3% |
Intel Skylake        |   16% |    8% |   -4% |   35% |   -3% |

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/Makefile                |   2 +-
 arch/x86/crypto/aes-ctr-avx-x86_64.S    | 556 ++++++++++++++++++++++
 arch/x86/crypto/aes_ctrby8_avx-x86_64.S | 597 ------------------------
 arch/x86/crypto/aesni-intel_glue.c      | 450 ++++++++----------
 4 files changed, 760 insertions(+), 845 deletions(-)
 create mode 100644 arch/x86/crypto/aes-ctr-avx-x86_64.S
 delete mode 100644 arch/x86/crypto/aes_ctrby8_avx-x86_64.S

diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
index 07b00bfca64b5..5d19f41bde583 100644
--- a/arch/x86/crypto/Makefile
+++ b/arch/x86/crypto/Makefile
@@ -46,11 +46,11 @@ obj-$(CONFIG_CRYPTO_CHACHA20_X86_64) += chacha-x86_64.o
 chacha-x86_64-y := chacha-avx2-x86_64.o chacha-ssse3-x86_64.o chacha_glue.o
 chacha-x86_64-$(CONFIG_AS_AVX512) += chacha-avx512vl-x86_64.o
 
 obj-$(CONFIG_CRYPTO_AES_NI_INTEL) += aesni-intel.o
 aesni-intel-y := aesni-intel_asm.o aesni-intel_glue.o
-aesni-intel-$(CONFIG_64BIT) += aes_ctrby8_avx-x86_64.o \
+aesni-intel-$(CONFIG_64BIT) += aes-ctr-avx-x86_64.o \
 			       aes-gcm-aesni-x86_64.o \
 			       aes-xts-avx-x86_64.o
 ifeq ($(CONFIG_AS_VAES)$(CONFIG_AS_VPCLMULQDQ),yy)
 aesni-intel-$(CONFIG_64BIT) += aes-gcm-avx10-x86_64.o
 endif
diff --git a/arch/x86/crypto/aes-ctr-avx-x86_64.S b/arch/x86/crypto/aes-ctr-avx-x86_64.S
new file mode 100644
index 0000000000000..2a1618e81e12a
--- /dev/null
+++ b/arch/x86/crypto/aes-ctr-avx-x86_64.S
@@ -0,0 +1,556 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+//
+// Copyright 2025 Google LLC
+//
+// Author: Eric Biggers <ebiggers@google.com>
+//
+// This file contains x86_64 assembly implementations of AES-CTR and AES-XCTR
+// using the following sets of CPU features:
+//	- AES-NI && AVX
+//	- VAES && AVX2
+//	- VAES && (AVX10/256 || (AVX512BW && AVX512VL)) && BMI2
+//	- VAES && (AVX10/512 || (AVX512BW && AVX512VL)) && BMI2
+//
+// See the function definitions at the bottom of the file for more information.
+
+#include <linux/linkage.h>
+#include <linux/cfi_types.h>
+
+.section .rodata
+.p2align 4
+
+.Lbswap_mask:
+	.octa	0x000102030405060708090a0b0c0d0e0f
+
+.Lctr_pattern:
+	.quad	0, 0
+.Lone:
+	.quad	1, 0
+.Ltwo:
+	.quad	2, 0
+	.quad	3, 0
+
+.Lfour:
+	.quad	4, 0
+
+.text
+
+// Move a vector between memory and a register.
+// The register operand must be in the first 16 vector registers.
+.macro	_vmovdqu	src, dst
+.if VL < 64
+	vmovdqu		\src, \dst
+.else
+	vmovdqu8	\src, \dst
+.endif
+.endm
+
+// Move a vector between registers.
+// The registers must be in the first 16 vector registers.
+.macro	_vmovdqa	src, dst
+.if VL < 64
+	vmovdqa		\src, \dst
+.else
+	vmovdqa64	\src, \dst
+.endif
+.endm
+
+// Broadcast a 128-bit value from memory to all 128-bit lanes of a vector
+// register.  The register operand must be in the first 16 vector registers.
+.macro	_vbroadcast128	src, dst
+.if VL == 16
+	vmovdqu		\src, \dst
+.elseif VL == 32
+	vbroadcasti128	\src, \dst
+.else
+	vbroadcasti32x4	\src, \dst
+.endif
+.endm
+
+// XOR two vectors together.
+// Any register operands must be in the first 16 vector registers.
+.macro	_vpxor	src1, src2, dst
+.if VL < 64
+	vpxor		\src1, \src2, \dst
+.else
+	vpxord		\src1, \src2, \dst
+.endif
+.endm
+
+// Load 1 <= %ecx <= 15 bytes from the pointer \src into the xmm register \dst
+// and zeroize any remaining bytes.  Clobbers %rax, %rcx, and \tmp{64,32}.
+.macro	_load_partial_block	src, dst, tmp64, tmp32
+	sub		$8, %ecx		// LEN - 8
+	jle		.Lle8\@
+
+	// Load 9 <= LEN <= 15 bytes.
+	vmovq		(\src), \dst		// Load first 8 bytes
+	mov		(\src, %rcx), %rax	// Load last 8 bytes
+	neg		%ecx
+	shl		$3, %ecx
+	shr		%cl, %rax		// Discard overlapping bytes
+	vpinsrq		$1, %rax, \dst, \dst
+	jmp		.Ldone\@
+
+.Lle8\@:
+	add		$4, %ecx		// LEN - 4
+	jl		.Llt4\@
+
+	// Load 4 <= LEN <= 8 bytes.
+	mov		(\src), %eax		// Load first 4 bytes
+	mov		(\src, %rcx), \tmp32	// Load last 4 bytes
+	jmp		.Lcombine\@
+
+.Llt4\@:
+	// Load 1 <= LEN <= 3 bytes.
+	add		$2, %ecx		// LEN - 2
+	movzbl		(\src), %eax		// Load first byte
+	jl		.Lmovq\@
+	movzwl		(\src, %rcx), \tmp32	// Load last 2 bytes
+.Lcombine\@:
+	shl		$3, %ecx
+	shl		%cl, \tmp64
+	or		\tmp64, %rax		// Combine the two parts
+.Lmovq\@:
+	vmovq		%rax, \dst
+.Ldone\@:
+.endm
+
+// Store 1 <= %ecx <= 15 bytes from the xmm register \src to the pointer \dst.
+// Clobbers %rax, %rcx, and \tmp{64,32}.
+.macro	_store_partial_block	src, dst, tmp64, tmp32
+	sub		$8, %ecx		// LEN - 8
+	jl		.Llt8\@
+
+	// Store 8 <= LEN <= 15 bytes.
+	vpextrq		$1, \src, %rax
+	mov		%ecx, \tmp32
+	shl		$3, %ecx
+	ror		%cl, %rax
+	mov		%rax, (\dst, \tmp64)	// Store last LEN - 8 bytes
+	vmovq		\src, (\dst)		// Store first 8 bytes
+	jmp		.Ldone\@
+
+.Llt8\@:
+	add		$4, %ecx		// LEN - 4
+	jl		.Llt4\@
+
+	// Store 4 <= LEN <= 7 bytes.
+	vpextrd		$1, \src, %eax
+	mov		%ecx, \tmp32
+	shl		$3, %ecx
+	ror		%cl, %eax
+	mov		%eax, (\dst, \tmp64)	// Store last LEN - 4 bytes
+	vmovd		\src, (\dst)		// Store first 4 bytes
+	jmp		.Ldone\@
+
+.Llt4\@:
+	// Store 1 <= LEN <= 3 bytes.
+	vpextrb		$0, \src, 0(\dst)
+	cmp		$-2, %ecx		// LEN - 4 == -2, i.e. LEN == 2?
+	jl		.Ldone\@
+	vpextrb		$1, \src, 1(\dst)
+	je		.Ldone\@
+	vpextrb		$2, \src, 2(\dst)
+.Ldone\@:
+.endm
+
+// Prepare the next two vectors of AES inputs in AESDATA\i0 and AESDATA\i1 and
+// XOR each with the zero-th round key.  Also update LE_CTR if !\final.
+.macro	_prepare_2_ctr_vecs	is_xctr, i0, i1, final=0
+.if \is_xctr
+  .if USE_AVX10
+	_vmovdqa	LE_CTR, AESDATA\i0
+	vpternlogd	$0x96, XCTR_IV, RNDKEY0, AESDATA\i0
+  .else
+	vpxor		XCTR_IV, LE_CTR, AESDATA\i0
+	vpxor		RNDKEY0, AESDATA\i0, AESDATA\i0
+  .endif
+	vpaddq		LE_CTR_INC1, LE_CTR, AESDATA\i1
+
+  .if USE_AVX10
+	vpternlogd	$0x96, XCTR_IV, RNDKEY0, AESDATA\i1
+  .else
+	vpxor		XCTR_IV, AESDATA\i1, AESDATA\i1
+	vpxor		RNDKEY0, AESDATA\i1, AESDATA\i1
+  .endif
+.else
+	vpshufb		BSWAP_MASK, LE_CTR, AESDATA\i0
+	_vpxor		RNDKEY0, AESDATA\i0, AESDATA\i0
+	vpaddq		LE_CTR_INC1, LE_CTR, AESDATA\i1
+	vpshufb		BSWAP_MASK, AESDATA\i1, AESDATA\i1
+	_vpxor		RNDKEY0, AESDATA\i1, AESDATA\i1
+.endif
+.if !\final
+	vpaddq		LE_CTR_INC2, LE_CTR, LE_CTR
+.endif
+.endm
+
+// Do all AES rounds on the data in the given AESDATA vectors, excluding the
+// zero-th and last round.
+.macro	_aesenc_loop	vecs
+	mov		KEY, %rax
+1:
+	_vbroadcast128	(%rax), RNDKEY
+.irp i, \vecs
+	vaesenc		RNDKEY, AESDATA\i, AESDATA\i
+.endr
+	add		$16, %rax
+	cmp		%rax, RNDKEYLAST_PTR
+	jne		1b
+.endm
+
+// Finalize the keystream blocks in the given AESDATA vectors by doing the last
+// AES round, then XOR those keystream blocks with the corresponding data.
+// Reduce latency by doing the XOR before the vaesenclast, utilizing the
+// property vaesenclast(key, a) ^ b == vaesenclast(key ^ b, a).
+.macro	_aesenclast_and_xor	vecs
+.irp i, \vecs
+	_vpxor		\i*VL(SRC), RNDKEYLAST, RNDKEY
+	vaesenclast	RNDKEY, AESDATA\i, AESDATA\i
+.endr
+.irp i, \vecs
+	_vmovdqu	AESDATA\i, \i*VL(DST)
+.endr
+.endm
+
+// XOR the keystream blocks in the specified AESDATA vectors with the
+// corresponding data.
+.macro	_xor_data	vecs
+.irp i, \vecs
+	_vpxor		\i*VL(SRC), AESDATA\i, AESDATA\i
+.endr
+.irp i, \vecs
+	_vmovdqu	AESDATA\i, \i*VL(DST)
+.endr
+.endm
+
+.macro	_aes_ctr_crypt		is_xctr
+
+	// Define register aliases V0-V15 that map to the xmm, ymm, or zmm
+	// registers according to the selected Vector Length (VL).
+.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+  .if VL == 16
+	.set	V\i,		%xmm\i
+  .elseif VL == 32
+	.set	V\i,		%ymm\i
+  .elseif VL == 64
+	.set	V\i,		%zmm\i
+  .else
+	.error "Unsupported Vector Length (VL)"
+  .endif
+.endr
+
+	// Function arguments
+	.set	KEY,		%rdi	// Initially points to the start of the
+					// crypto_aes_ctx, then is advanced to
+					// point to the index 1 round key
+	.set	KEY32,		%edi	// Available as temp register after all
+					// keystream blocks have been generated
+	.set	SRC,		%rsi	// Pointer to next source data
+	.set	DST,		%rdx	// Pointer to next destination data
+	.set	LEN,		%ecx	// Remaining length in bytes.
+					// Note: _load_partial_block relies on
+					// this being in %ecx.
+	.set	LEN64,		%rcx	// Zero-extend LEN before using!
+	.set	LEN8,		%cl
+.if \is_xctr
+	.set	XCTR_IV_PTR,	%r8	// const u8 iv[AES_BLOCK_SIZE];
+	.set	XCTR_CTR,	%r9	// u64 ctr;
+	.set	LE_CTR_PTR,	nil
+.else
+	.set	LE_CTR_PTR,	%r8	// const u64 le_ctr[2];
+	.set	XCTR_IV_PTR,	nil
+	.set	XCTR_CTR,	nil
+.endif
+
+	// Additional local variables
+	.set	RNDKEYLAST_PTR,	%r10
+	.set	AESDATA0,	V0
+	.set	AESDATA0_XMM,	%xmm0
+	.set	AESDATA1,	V1
+	.set	AESDATA1_XMM,	%xmm1
+	.set	AESDATA2,	V2
+	.set	AESDATA3,	V3
+	.set	AESDATA4,	V4
+	.set	AESDATA5,	V5
+	.set	AESDATA6,	V6
+	.set	AESDATA7,	V7
+.if \is_xctr
+	.set	XCTR_IV,	V8
+	.set	BSWAP_MASK,	nil
+.else
+	.set	BSWAP_MASK,	V8
+.endif
+	.set	LE_CTR,		V9
+	.set	LE_CTR_XMM,	%xmm9
+	.set	LE_CTR_INC1,	V10
+	.set	LE_CTR_INC2,	V11
+	.set	RNDKEY0,	V12
+	.set	RNDKEYLAST,	V13
+	.set	RNDKEY,		V14
+
+	// Create the first vector of counters.
+.if \is_xctr
+  .if VL == 16
+	vmovq		XCTR_CTR, LE_CTR
+  .elseif VL == 32
+	vmovq		XCTR_CTR, LE_CTR_XMM
+	inc		XCTR_CTR
+	vmovq		XCTR_CTR, AESDATA0_XMM
+	vinserti128	$1, AESDATA0_XMM, LE_CTR, LE_CTR
+  .else
+	vpbroadcastq	XCTR_CTR, LE_CTR
+	vpsrldq		$8, LE_CTR, LE_CTR
+	vpaddq		.Lctr_pattern(%rip), LE_CTR, LE_CTR
+  .endif
+	_vbroadcast128	(XCTR_IV_PTR), XCTR_IV
+.else
+	_vbroadcast128	(LE_CTR_PTR), LE_CTR
+  .if VL > 16
+	vpaddq		.Lctr_pattern(%rip), LE_CTR, LE_CTR
+  .endif
+	_vbroadcast128	.Lbswap_mask(%rip), BSWAP_MASK
+.endif
+
+.if VL == 16
+	_vbroadcast128	.Lone(%rip), LE_CTR_INC1
+.elseif VL == 32
+	_vbroadcast128	.Ltwo(%rip), LE_CTR_INC1
+.else
+	_vbroadcast128	.Lfour(%rip), LE_CTR_INC1
+.endif
+	vpsllq		$1, LE_CTR_INC1, LE_CTR_INC2
+
+	// Load the AES key length: 16 (AES-128), 24 (AES-192), or 32 (AES-256).
+	movl		480(KEY), %eax
+
+	// Compute the pointer to the last round key.
+	lea		6*16(KEY, %rax, 4), RNDKEYLAST_PTR
+
+	// Load the zero-th and last round keys.
+	_vbroadcast128	(KEY), RNDKEY0
+	_vbroadcast128	(RNDKEYLAST_PTR), RNDKEYLAST
+
+	// Make KEY point to the first round key.
+	add		$16, KEY
+
+	// This is the main loop, which encrypts 8 vectors of data at a time.
+	add		$-8*VL, LEN
+	jl		.Lloop_8x_done\@
+.Lloop_8x\@:
+	_prepare_2_ctr_vecs	\is_xctr, 0, 1
+	_prepare_2_ctr_vecs	\is_xctr, 2, 3
+	_prepare_2_ctr_vecs	\is_xctr, 4, 5
+	_prepare_2_ctr_vecs	\is_xctr, 6, 7
+	_aesenc_loop	"0,1,2,3,4,5,6,7"
+	_aesenclast_and_xor "0,1,2,3,4,5,6,7"
+	sub		$-8*VL, SRC
+	sub		$-8*VL, DST
+	add		$-8*VL, LEN
+	jge		.Lloop_8x\@
+.Lloop_8x_done\@:
+	sub		$-8*VL, LEN
+	jz		.Ldone\@
+
+	// 1 <= LEN < 8*VL.  Generate 2, 4, 8 more vectors of keystream blocks,
+	// depending on the remaining LEN.
+
+	_prepare_2_ctr_vecs	\is_xctr, 0, 1
+	_prepare_2_ctr_vecs	\is_xctr, 2, 3
+	cmp		$4*VL, LEN
+	jle		.Lenc_tail_atmost4vecs\@
+
+	// 4*VL < LEN < 8*VL.  Generate 8 vectors of keystream blocks.  Use the
+	// first 4 to XOR 4 full vectors of data.  Then XOR the remaining data.
+	_prepare_2_ctr_vecs	\is_xctr, 4, 5
+	_prepare_2_ctr_vecs	\is_xctr, 6, 7, final=1
+	_aesenc_loop	"0,1,2,3,4,5,6,7"
+	_aesenclast_and_xor "0,1,2,3"
+	vaesenclast	RNDKEYLAST, AESDATA4, AESDATA0
+	vaesenclast	RNDKEYLAST, AESDATA5, AESDATA1
+	vaesenclast	RNDKEYLAST, AESDATA6, AESDATA2
+	vaesenclast	RNDKEYLAST, AESDATA7, AESDATA3
+	sub		$-4*VL, SRC
+	sub		$-4*VL, DST
+	add		$-4*VL, LEN
+	cmp		$1*VL-1, LEN
+	jle		.Lxor_tail_partial_vec_0\@
+	_xor_data	"0"
+	cmp		$2*VL-1, LEN
+	jle		.Lxor_tail_partial_vec_1\@
+	_xor_data	"1"
+	cmp		$3*VL-1, LEN
+	jle		.Lxor_tail_partial_vec_2\@
+	_xor_data	"2"
+	cmp		$4*VL-1, LEN
+	jle		.Lxor_tail_partial_vec_3\@
+	_xor_data	"3"
+	jmp		.Ldone\@
+
+.Lenc_tail_atmost4vecs\@:
+	cmp		$2*VL, LEN
+	jle		.Lenc_tail_atmost2vecs\@
+
+	// 2*VL < LEN <= 4*VL.  Generate 4 vectors of keystream blocks.  Use the
+	// first 2 to XOR 2 full vectors of data.  Then XOR the remaining data.
+	_aesenc_loop	"0,1,2,3"
+	_aesenclast_and_xor "0,1"
+	vaesenclast	RNDKEYLAST, AESDATA2, AESDATA0
+	vaesenclast	RNDKEYLAST, AESDATA3, AESDATA1
+	sub		$-2*VL, SRC
+	sub		$-2*VL, DST
+	add		$-2*VL, LEN
+	jmp		.Lxor_tail_upto2vecs\@
+
+.Lenc_tail_atmost2vecs\@:
+	// 1 <= LEN <= 2*VL.  Generate 2 vectors of keystream blocks.  Then XOR
+	// the remaining data.
+	_aesenc_loop	"0,1"
+.irp i, 0,1
+	vaesenclast	RNDKEYLAST, AESDATA\i, AESDATA\i
+.endr
+
+.Lxor_tail_upto2vecs\@:
+	cmp		$1*VL-1, LEN
+	jle		.Lxor_tail_partial_vec_0\@
+	_xor_data	"0"
+	cmp		$2*VL-1, LEN
+	jle		.Lxor_tail_partial_vec_1\@
+	_xor_data	"1"
+	jmp		.Ldone\@
+
+.Lxor_tail_partial_vec_1\@:
+	add		$-1*VL, LEN
+	jz		.Ldone\@
+	sub		$-1*VL, SRC
+	sub		$-1*VL, DST
+	_vmovdqa	AESDATA1, AESDATA0
+	jmp		.Lxor_tail_partial_vec_0\@
+
+.Lxor_tail_partial_vec_2\@:
+	add		$-2*VL, LEN
+	jz		.Ldone\@
+	sub		$-2*VL, SRC
+	sub		$-2*VL, DST
+	_vmovdqa	AESDATA2, AESDATA0
+	jmp		.Lxor_tail_partial_vec_0\@
+
+.Lxor_tail_partial_vec_3\@:
+	add		$-3*VL, LEN
+	jz		.Ldone\@
+	sub		$-3*VL, SRC
+	sub		$-3*VL, DST
+	_vmovdqa	AESDATA3, AESDATA0
+
+.Lxor_tail_partial_vec_0\@:
+	// XOR the remaining 1 <= LEN < VL bytes.  It's easy if masked
+	// loads/stores are available; otherwise it's a bit harder...
+.if USE_AVX10
+  .if VL <= 32
+	mov		$-1, %eax
+	bzhi		LEN, %eax, %eax
+	kmovd		%eax, %k1
+  .else
+	mov		$-1, %rax
+	bzhi		LEN64, %rax, %rax
+	kmovq		%rax, %k1
+  .endif
+	vmovdqu8	(SRC), AESDATA1{%k1}{z}
+	_vpxor		AESDATA1, AESDATA0, AESDATA0
+	vmovdqu8	AESDATA0, (DST){%k1}
+.else
+  .if VL == 32
+	cmp		$16, LEN
+	jl		1f
+	vpxor		(SRC), AESDATA0_XMM, AESDATA1_XMM
+	vmovdqu		AESDATA1_XMM, (DST)
+	add		$16, SRC
+	add		$16, DST
+	sub		$16, LEN
+	jz		.Ldone\@
+	vextracti128	$1, AESDATA0, AESDATA0_XMM
+1:
+  .endif
+	mov		LEN, %r10d
+	_load_partial_block	SRC, AESDATA1_XMM, KEY, KEY32
+	vpxor		AESDATA1_XMM, AESDATA0_XMM, AESDATA0_XMM
+	mov		%r10d, %ecx
+	_store_partial_block	AESDATA0_XMM, DST, KEY, KEY32
+.endif
+
+.Ldone\@:
+.if VL > 16
+	vzeroupper
+.endif
+	RET
+.endm
+
+// Below are the definitions of the functions generated by the above macro.
+// They have the following prototypes:
+//
+//
+// void aes_ctr64_crypt_##suffix(const struct crypto_aes_ctx *key,
+//				 const u8 *src, u8 *dst, int len,
+//				 const u64 le_ctr[2]);
+//
+// void aes_xctr_crypt_##suffix(const struct crypto_aes_ctx *key,
+//				const u8 *src, u8 *dst, int len,
+//				const u8 iv[AES_BLOCK_SIZE], u64 ctr);
+//
+// Both functions generate |len| bytes of keystream, XOR it with the data from
+// |src|, and write the result to |dst|.  On non-final calls, |len| must be a
+// multiple of 16.  On the final call, |len| can be any value.
+//
+// aes_ctr64_crypt_* implement "regular" CTR, where the keystream is generated
+// from a 128-bit big endian block counter.  HOWEVER, to keep the assembly code
+// simple, some of the counter management is left to the caller.
+// aes_ctr64_crypt_* take the counter in little endian form, only increment the
+// low 64 bits internally, and don't write the updated counter back to memory.
+// The caller is responsible for converting the starting IV to the little endian
+// le_ctr, detecting the (very rare) case of a carry out of the low 64 bits
+// being needed and splitting at that point with a carry done in between, and
+// updating le_ctr after each part if the message is multi-part.
+//
+// aes_xctr_crypt_* implement XCTR as specified in "Length-preserving encryption
+// with HCTR2" (https://eprint.iacr.org/2021/1441.pdf).  XCTR is an
+// easier-to-implement variant of CTR that uses little endian byte order and
+// eliminates carries.  |ctr| is the per-message block counter starting at 1.
+
+.set	VL, 16
+.set	USE_AVX10, 0
+SYM_TYPED_FUNC_START(aes_ctr64_crypt_aesni_avx)
+	_aes_ctr_crypt	0
+SYM_FUNC_END(aes_ctr64_crypt_aesni_avx)
+SYM_TYPED_FUNC_START(aes_xctr_crypt_aesni_avx)
+	_aes_ctr_crypt	1
+SYM_FUNC_END(aes_xctr_crypt_aesni_avx)
+
+#if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
+.set	VL, 32
+.set	USE_AVX10, 0
+SYM_TYPED_FUNC_START(aes_ctr64_crypt_vaes_avx2)
+	_aes_ctr_crypt	0
+SYM_FUNC_END(aes_ctr64_crypt_vaes_avx2)
+SYM_TYPED_FUNC_START(aes_xctr_crypt_vaes_avx2)
+	_aes_ctr_crypt	1
+SYM_FUNC_END(aes_xctr_crypt_vaes_avx2)
+
+.set	VL, 32
+.set	USE_AVX10, 1
+SYM_TYPED_FUNC_START(aes_ctr64_crypt_vaes_avx10_256)
+	_aes_ctr_crypt	0
+SYM_FUNC_END(aes_ctr64_crypt_vaes_avx10_256)
+SYM_TYPED_FUNC_START(aes_xctr_crypt_vaes_avx10_256)
+	_aes_ctr_crypt	1
+SYM_FUNC_END(aes_xctr_crypt_vaes_avx10_256)
+
+.set	VL, 64
+.set	USE_AVX10, 1
+SYM_TYPED_FUNC_START(aes_ctr64_crypt_vaes_avx10_512)
+	_aes_ctr_crypt	0
+SYM_FUNC_END(aes_ctr64_crypt_vaes_avx10_512)
+SYM_TYPED_FUNC_START(aes_xctr_crypt_vaes_avx10_512)
+	_aes_ctr_crypt	1
+SYM_FUNC_END(aes_xctr_crypt_vaes_avx10_512)
+#endif // CONFIG_AS_VAES && CONFIG_AS_VPCLMULQDQ
diff --git a/arch/x86/crypto/aes_ctrby8_avx-x86_64.S b/arch/x86/crypto/aes_ctrby8_avx-x86_64.S
deleted file mode 100644
index 2402b9418cd7a..0000000000000
--- a/arch/x86/crypto/aes_ctrby8_avx-x86_64.S
+++ /dev/null
@@ -1,597 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
-/*
- * AES CTR mode by8 optimization with AVX instructions. (x86_64)
- *
- * Copyright(c) 2014 Intel Corporation.
- *
- * Contact Information:
- * James Guilford <james.guilford@intel.com>
- * Sean Gulley <sean.m.gulley@intel.com>
- * Chandramouli Narayanan <mouli@linux.intel.com>
- */
-/*
- * This is AES128/192/256 CTR mode optimization implementation. It requires
- * the support of Intel(R) AESNI and AVX instructions.
- *
- * This work was inspired by the AES CTR mode optimization published
- * in Intel Optimized IPSEC Cryptographic library.
- * Additional information on it can be found at:
- *    https://github.com/intel/intel-ipsec-mb
- */
-
-#include <linux/linkage.h>
-
-#define VMOVDQ		vmovdqu
-
-/*
- * Note: the "x" prefix in these aliases means "this is an xmm register".  The
- * alias prefixes have no relation to XCTR where the "X" prefix means "XOR
- * counter".
- */
-#define xdata0		%xmm0
-#define xdata1		%xmm1
-#define xdata2		%xmm2
-#define xdata3		%xmm3
-#define xdata4		%xmm4
-#define xdata5		%xmm5
-#define xdata6		%xmm6
-#define xdata7		%xmm7
-#define xcounter	%xmm8	// CTR mode only
-#define xiv		%xmm8	// XCTR mode only
-#define xbyteswap	%xmm9	// CTR mode only
-#define xtmp		%xmm9	// XCTR mode only
-#define xkey0		%xmm10
-#define xkey4		%xmm11
-#define xkey8		%xmm12
-#define xkey12		%xmm13
-#define xkeyA		%xmm14
-#define xkeyB		%xmm15
-
-#define p_in		%rdi
-#define p_iv		%rsi
-#define p_keys		%rdx
-#define p_out		%rcx
-#define num_bytes	%r8
-#define counter		%r9	// XCTR mode only
-#define tmp		%r10
-#define	DDQ_DATA	0
-#define	XDATA		1
-#define KEY_128		1
-#define KEY_192		2
-#define KEY_256		3
-
-.section .rodata
-.align 16
-
-byteswap_const:
-	.octa 0x000102030405060708090A0B0C0D0E0F
-ddq_low_msk:
-	.octa 0x0000000000000000FFFFFFFFFFFFFFFF
-ddq_high_add_1:
-	.octa 0x00000000000000010000000000000000
-ddq_add_1:
-	.octa 0x00000000000000000000000000000001
-ddq_add_2:
-	.octa 0x00000000000000000000000000000002
-ddq_add_3:
-	.octa 0x00000000000000000000000000000003
-ddq_add_4:
-	.octa 0x00000000000000000000000000000004
-ddq_add_5:
-	.octa 0x00000000000000000000000000000005
-ddq_add_6:
-	.octa 0x00000000000000000000000000000006
-ddq_add_7:
-	.octa 0x00000000000000000000000000000007
-ddq_add_8:
-	.octa 0x00000000000000000000000000000008
-
-.text
-
-/* generate a unique variable for ddq_add_x */
-
-/* generate a unique variable for xmm register */
-.macro setxdata n
-	var_xdata = %xmm\n
-.endm
-
-/* club the numeric 'id' to the symbol 'name' */
-
-.macro club name, id
-.altmacro
-	.if \name == XDATA
-		setxdata %\id
-	.endif
-.noaltmacro
-.endm
-
-/*
- * do_aes num_in_par load_keys key_len
- * This increments p_in, but not p_out
- */
-.macro do_aes b, k, key_len, xctr
-	.set by, \b
-	.set load_keys, \k
-	.set klen, \key_len
-
-	.if (load_keys)
-		vmovdqa	0*16(p_keys), xkey0
-	.endif
-
-	.if \xctr
-		movq counter, xtmp
-		.set i, 0
-		.rept (by)
-			club XDATA, i
-			vpaddq	(ddq_add_1 + 16 * i)(%rip), xtmp, var_xdata
-			.set i, (i +1)
-		.endr
-		.set i, 0
-		.rept (by)
-			club	XDATA, i
-			vpxor	xiv, var_xdata, var_xdata
-			.set i, (i +1)
-		.endr
-	.else
-		vpshufb	xbyteswap, xcounter, xdata0
-		.set i, 1
-		.rept (by - 1)
-			club XDATA, i
-			vpaddq	(ddq_add_1 + 16 * (i - 1))(%rip), xcounter, var_xdata
-			vptest	ddq_low_msk(%rip), var_xdata
-			jnz 1f
-			vpaddq	ddq_high_add_1(%rip), var_xdata, var_xdata
-			vpaddq	ddq_high_add_1(%rip), xcounter, xcounter
-			1:
-			vpshufb	xbyteswap, var_xdata, var_xdata
-			.set i, (i +1)
-		.endr
-	.endif
-
-	vmovdqa	1*16(p_keys), xkeyA
-
-	vpxor	xkey0, xdata0, xdata0
-	.if \xctr
-		add $by, counter
-	.else
-		vpaddq	(ddq_add_1 + 16 * (by - 1))(%rip), xcounter, xcounter
-		vptest	ddq_low_msk(%rip), xcounter
-		jnz	1f
-		vpaddq	ddq_high_add_1(%rip), xcounter, xcounter
-		1:
-	.endif
-
-	.set i, 1
-	.rept (by - 1)
-		club XDATA, i
-		vpxor	xkey0, var_xdata, var_xdata
-		.set i, (i +1)
-	.endr
-
-	vmovdqa	2*16(p_keys), xkeyB
-
-	.set i, 0
-	.rept by
-		club XDATA, i
-		vaesenc	xkeyA, var_xdata, var_xdata		/* key 1 */
-		.set i, (i +1)
-	.endr
-
-	.if (klen == KEY_128)
-		.if (load_keys)
-			vmovdqa	3*16(p_keys), xkey4
-		.endif
-	.else
-		vmovdqa	3*16(p_keys), xkeyA
-	.endif
-
-	.set i, 0
-	.rept by
-		club XDATA, i
-		vaesenc	xkeyB, var_xdata, var_xdata		/* key 2 */
-		.set i, (i +1)
-	.endr
-
-	add	$(16*by), p_in
-
-	.if (klen == KEY_128)
-		vmovdqa	4*16(p_keys), xkeyB
-	.else
-		.if (load_keys)
-			vmovdqa	4*16(p_keys), xkey4
-		.endif
-	.endif
-
-	.set i, 0
-	.rept by
-		club XDATA, i
-		/* key 3 */
-		.if (klen == KEY_128)
-			vaesenc	xkey4, var_xdata, var_xdata
-		.else
-			vaesenc	xkeyA, var_xdata, var_xdata
-		.endif
-		.set i, (i +1)
-	.endr
-
-	vmovdqa	5*16(p_keys), xkeyA
-
-	.set i, 0
-	.rept by
-		club XDATA, i
-		/* key 4 */
-		.if (klen == KEY_128)
-			vaesenc	xkeyB, var_xdata, var_xdata
-		.else
-			vaesenc	xkey4, var_xdata, var_xdata
-		.endif
-		.set i, (i +1)
-	.endr
-
-	.if (klen == KEY_128)
-		.if (load_keys)
-			vmovdqa	6*16(p_keys), xkey8
-		.endif
-	.else
-		vmovdqa	6*16(p_keys), xkeyB
-	.endif
-
-	.set i, 0
-	.rept by
-		club XDATA, i
-		vaesenc	xkeyA, var_xdata, var_xdata		/* key 5 */
-		.set i, (i +1)
-	.endr
-
-	vmovdqa	7*16(p_keys), xkeyA
-
-	.set i, 0
-	.rept by
-		club XDATA, i
-		/* key 6 */
-		.if (klen == KEY_128)
-			vaesenc	xkey8, var_xdata, var_xdata
-		.else
-			vaesenc	xkeyB, var_xdata, var_xdata
-		.endif
-		.set i, (i +1)
-	.endr
-
-	.if (klen == KEY_128)
-		vmovdqa	8*16(p_keys), xkeyB
-	.else
-		.if (load_keys)
-			vmovdqa	8*16(p_keys), xkey8
-		.endif
-	.endif
-
-	.set i, 0
-	.rept by
-		club XDATA, i
-		vaesenc	xkeyA, var_xdata, var_xdata		/* key 7 */
-		.set i, (i +1)
-	.endr
-
-	.if (klen == KEY_128)
-		.if (load_keys)
-			vmovdqa	9*16(p_keys), xkey12
-		.endif
-	.else
-		vmovdqa	9*16(p_keys), xkeyA
-	.endif
-
-	.set i, 0
-	.rept by
-		club XDATA, i
-		/* key 8 */
-		.if (klen == KEY_128)
-			vaesenc	xkeyB, var_xdata, var_xdata
-		.else
-			vaesenc	xkey8, var_xdata, var_xdata
-		.endif
-		.set i, (i +1)
-	.endr
-
-	vmovdqa	10*16(p_keys), xkeyB
-
-	.set i, 0
-	.rept by
-		club XDATA, i
-		/* key 9 */
-		.if (klen == KEY_128)
-			vaesenc	xkey12, var_xdata, var_xdata
-		.else
-			vaesenc	xkeyA, var_xdata, var_xdata
-		.endif
-		.set i, (i +1)
-	.endr
-
-	.if (klen != KEY_128)
-		vmovdqa	11*16(p_keys), xkeyA
-	.endif
-
-	.set i, 0
-	.rept by
-		club XDATA, i
-		/* key 10 */
-		.if (klen == KEY_128)
-			vaesenclast	xkeyB, var_xdata, var_xdata
-		.else
-			vaesenc	xkeyB, var_xdata, var_xdata
-		.endif
-		.set i, (i +1)
-	.endr
-
-	.if (klen != KEY_128)
-		.if (load_keys)
-			vmovdqa	12*16(p_keys), xkey12
-		.endif
-
-		.set i, 0
-		.rept by
-			club XDATA, i
-			vaesenc	xkeyA, var_xdata, var_xdata	/* key 11 */
-			.set i, (i +1)
-		.endr
-
-		.if (klen == KEY_256)
-			vmovdqa	13*16(p_keys), xkeyA
-		.endif
-
-		.set i, 0
-		.rept by
-			club XDATA, i
-			.if (klen == KEY_256)
-				/* key 12 */
-				vaesenc	xkey12, var_xdata, var_xdata
-			.else
-				vaesenclast xkey12, var_xdata, var_xdata
-			.endif
-			.set i, (i +1)
-		.endr
-
-		.if (klen == KEY_256)
-			vmovdqa	14*16(p_keys), xkeyB
-
-			.set i, 0
-			.rept by
-				club XDATA, i
-				/* key 13 */
-				vaesenc	xkeyA, var_xdata, var_xdata
-				.set i, (i +1)
-			.endr
-
-			.set i, 0
-			.rept by
-				club XDATA, i
-				/* key 14 */
-				vaesenclast	xkeyB, var_xdata, var_xdata
-				.set i, (i +1)
-			.endr
-		.endif
-	.endif
-
-	.set i, 0
-	.rept (by / 2)
-		.set j, (i+1)
-		VMOVDQ	(i*16 - 16*by)(p_in), xkeyA
-		VMOVDQ	(j*16 - 16*by)(p_in), xkeyB
-		club XDATA, i
-		vpxor	xkeyA, var_xdata, var_xdata
-		club XDATA, j
-		vpxor	xkeyB, var_xdata, var_xdata
-		.set i, (i+2)
-	.endr
-
-	.if (i < by)
-		VMOVDQ	(i*16 - 16*by)(p_in), xkeyA
-		club XDATA, i
-		vpxor	xkeyA, var_xdata, var_xdata
-	.endif
-
-	.set i, 0
-	.rept by
-		club XDATA, i
-		VMOVDQ	var_xdata, i*16(p_out)
-		.set i, (i+1)
-	.endr
-.endm
-
-.macro do_aes_load val, key_len, xctr
-	do_aes \val, 1, \key_len, \xctr
-.endm
-
-.macro do_aes_noload val, key_len, xctr
-	do_aes \val, 0, \key_len, \xctr
-.endm
-
-/* main body of aes ctr load */
-
-.macro do_aes_ctrmain key_len, xctr
-	cmp	$16, num_bytes
-	jb	.Ldo_return2\xctr\key_len
-
-	.if \xctr
-		shr	$4, counter
-		vmovdqu	(p_iv), xiv
-	.else
-		vmovdqa	byteswap_const(%rip), xbyteswap
-		vmovdqu	(p_iv), xcounter
-		vpshufb	xbyteswap, xcounter, xcounter
-	.endif
-
-	mov	num_bytes, tmp
-	and	$(7*16), tmp
-	jz	.Lmult_of_8_blks\xctr\key_len
-
-	/* 1 <= tmp <= 7 */
-	cmp	$(4*16), tmp
-	jg	.Lgt4\xctr\key_len
-	je	.Leq4\xctr\key_len
-
-.Llt4\xctr\key_len:
-	cmp	$(2*16), tmp
-	jg	.Leq3\xctr\key_len
-	je	.Leq2\xctr\key_len
-
-.Leq1\xctr\key_len:
-	do_aes_load	1, \key_len, \xctr
-	add	$(1*16), p_out
-	and	$(~7*16), num_bytes
-	jz	.Ldo_return2\xctr\key_len
-	jmp	.Lmain_loop2\xctr\key_len
-
-.Leq2\xctr\key_len:
-	do_aes_load	2, \key_len, \xctr
-	add	$(2*16), p_out
-	and	$(~7*16), num_bytes
-	jz	.Ldo_return2\xctr\key_len
-	jmp	.Lmain_loop2\xctr\key_len
-
-
-.Leq3\xctr\key_len:
-	do_aes_load	3, \key_len, \xctr
-	add	$(3*16), p_out
-	and	$(~7*16), num_bytes
-	jz	.Ldo_return2\xctr\key_len
-	jmp	.Lmain_loop2\xctr\key_len
-
-.Leq4\xctr\key_len:
-	do_aes_load	4, \key_len, \xctr
-	add	$(4*16), p_out
-	and	$(~7*16), num_bytes
-	jz	.Ldo_return2\xctr\key_len
-	jmp	.Lmain_loop2\xctr\key_len
-
-.Lgt4\xctr\key_len:
-	cmp	$(6*16), tmp
-	jg	.Leq7\xctr\key_len
-	je	.Leq6\xctr\key_len
-
-.Leq5\xctr\key_len:
-	do_aes_load	5, \key_len, \xctr
-	add	$(5*16), p_out
-	and	$(~7*16), num_bytes
-	jz	.Ldo_return2\xctr\key_len
-	jmp	.Lmain_loop2\xctr\key_len
-
-.Leq6\xctr\key_len:
-	do_aes_load	6, \key_len, \xctr
-	add	$(6*16), p_out
-	and	$(~7*16), num_bytes
-	jz	.Ldo_return2\xctr\key_len
-	jmp	.Lmain_loop2\xctr\key_len
-
-.Leq7\xctr\key_len:
-	do_aes_load	7, \key_len, \xctr
-	add	$(7*16), p_out
-	and	$(~7*16), num_bytes
-	jz	.Ldo_return2\xctr\key_len
-	jmp	.Lmain_loop2\xctr\key_len
-
-.Lmult_of_8_blks\xctr\key_len:
-	.if (\key_len != KEY_128)
-		vmovdqa	0*16(p_keys), xkey0
-		vmovdqa	4*16(p_keys), xkey4
-		vmovdqa	8*16(p_keys), xkey8
-		vmovdqa	12*16(p_keys), xkey12
-	.else
-		vmovdqa	0*16(p_keys), xkey0
-		vmovdqa	3*16(p_keys), xkey4
-		vmovdqa	6*16(p_keys), xkey8
-		vmovdqa	9*16(p_keys), xkey12
-	.endif
-.align 16
-.Lmain_loop2\xctr\key_len:
-	/* num_bytes is a multiple of 8 and >0 */
-	do_aes_noload	8, \key_len, \xctr
-	add	$(8*16), p_out
-	sub	$(8*16), num_bytes
-	jne	.Lmain_loop2\xctr\key_len
-
-.Ldo_return2\xctr\key_len:
-	.if !\xctr
-		/* return updated IV */
-		vpshufb	xbyteswap, xcounter, xcounter
-		vmovdqu	xcounter, (p_iv)
-	.endif
-	RET
-.endm
-
-/*
- * routine to do AES128 CTR enc/decrypt "by8"
- * XMM registers are clobbered.
- * Saving/restoring must be done at a higher level
- * aes_ctr_enc_128_avx_by8(void *in, void *iv, void *keys, void *out,
- *			unsigned int num_bytes)
- */
-SYM_FUNC_START(aes_ctr_enc_128_avx_by8)
-	/* call the aes main loop */
-	do_aes_ctrmain KEY_128 0
-
-SYM_FUNC_END(aes_ctr_enc_128_avx_by8)
-
-/*
- * routine to do AES192 CTR enc/decrypt "by8"
- * XMM registers are clobbered.
- * Saving/restoring must be done at a higher level
- * aes_ctr_enc_192_avx_by8(void *in, void *iv, void *keys, void *out,
- *			unsigned int num_bytes)
- */
-SYM_FUNC_START(aes_ctr_enc_192_avx_by8)
-	/* call the aes main loop */
-	do_aes_ctrmain KEY_192 0
-
-SYM_FUNC_END(aes_ctr_enc_192_avx_by8)
-
-/*
- * routine to do AES256 CTR enc/decrypt "by8"
- * XMM registers are clobbered.
- * Saving/restoring must be done at a higher level
- * aes_ctr_enc_256_avx_by8(void *in, void *iv, void *keys, void *out,
- *			unsigned int num_bytes)
- */
-SYM_FUNC_START(aes_ctr_enc_256_avx_by8)
-	/* call the aes main loop */
-	do_aes_ctrmain KEY_256 0
-
-SYM_FUNC_END(aes_ctr_enc_256_avx_by8)
-
-/*
- * routine to do AES128 XCTR enc/decrypt "by8"
- * XMM registers are clobbered.
- * Saving/restoring must be done at a higher level
- * aes_xctr_enc_128_avx_by8(const u8 *in, const u8 *iv, const void *keys,
- * 	u8* out, unsigned int num_bytes, unsigned int byte_ctr)
- */
-SYM_FUNC_START(aes_xctr_enc_128_avx_by8)
-	/* call the aes main loop */
-	do_aes_ctrmain KEY_128 1
-
-SYM_FUNC_END(aes_xctr_enc_128_avx_by8)
-
-/*
- * routine to do AES192 XCTR enc/decrypt "by8"
- * XMM registers are clobbered.
- * Saving/restoring must be done at a higher level
- * aes_xctr_enc_192_avx_by8(const u8 *in, const u8 *iv, const void *keys,
- * 	u8* out, unsigned int num_bytes, unsigned int byte_ctr)
- */
-SYM_FUNC_START(aes_xctr_enc_192_avx_by8)
-	/* call the aes main loop */
-	do_aes_ctrmain KEY_192 1
-
-SYM_FUNC_END(aes_xctr_enc_192_avx_by8)
-
-/*
- * routine to do AES256 XCTR enc/decrypt "by8"
- * XMM registers are clobbered.
- * Saving/restoring must be done at a higher level
- * aes_xctr_enc_256_avx_by8(const u8 *in, const u8 *iv, const void *keys,
- * 	u8* out, unsigned int num_bytes, unsigned int byte_ctr)
- */
-SYM_FUNC_START(aes_xctr_enc_256_avx_by8)
-	/* call the aes main loop */
-	do_aes_ctrmain KEY_256 1
-
-SYM_FUNC_END(aes_xctr_enc_256_avx_by8)
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 11e95fc62636e..150ee2f690151 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -21,11 +21,10 @@
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/err.h>
 #include <crypto/algapi.h>
 #include <crypto/aes.h>
-#include <crypto/ctr.h>
 #include <crypto/b128ops.h>
 #include <crypto/gcm.h>
 #include <crypto/xts.h>
 #include <asm/cpu_device_id.h>
 #include <asm/simd.h>
@@ -79,37 +78,10 @@ asmlinkage void aesni_xts_enc(const struct crypto_aes_ctx *ctx, u8 *out,
 			      const u8 *in, unsigned int len, u8 *iv);
 
 asmlinkage void aesni_xts_dec(const struct crypto_aes_ctx *ctx, u8 *out,
 			      const u8 *in, unsigned int len, u8 *iv);
 
-#ifdef CONFIG_X86_64
-
-asmlinkage void aesni_ctr_enc(struct crypto_aes_ctx *ctx, u8 *out,
-			      const u8 *in, unsigned int len, u8 *iv);
-DEFINE_STATIC_CALL(aesni_ctr_enc_tfm, aesni_ctr_enc);
-
-asmlinkage void aes_ctr_enc_128_avx_by8(const u8 *in, u8 *iv,
-		void *keys, u8 *out, unsigned int num_bytes);
-asmlinkage void aes_ctr_enc_192_avx_by8(const u8 *in, u8 *iv,
-		void *keys, u8 *out, unsigned int num_bytes);
-asmlinkage void aes_ctr_enc_256_avx_by8(const u8 *in, u8 *iv,
-		void *keys, u8 *out, unsigned int num_bytes);
-
-
-asmlinkage void aes_xctr_enc_128_avx_by8(const u8 *in, const u8 *iv,
-	const void *keys, u8 *out, unsigned int num_bytes,
-	unsigned int byte_ctr);
-
-asmlinkage void aes_xctr_enc_192_avx_by8(const u8 *in, const u8 *iv,
-	const void *keys, u8 *out, unsigned int num_bytes,
-	unsigned int byte_ctr);
-
-asmlinkage void aes_xctr_enc_256_avx_by8(const u8 *in, const u8 *iv,
-	const void *keys, u8 *out, unsigned int num_bytes,
-	unsigned int byte_ctr);
-#endif
-
 static inline struct crypto_aes_ctx *aes_ctx(void *raw_ctx)
 {
 	return aes_align_addr(raw_ctx);
 }
 
@@ -373,116 +345,10 @@ static int cts_cbc_decrypt(struct skcipher_request *req)
 	kernel_fpu_end();
 
 	return skcipher_walk_done(&walk, 0);
 }
 
-#ifdef CONFIG_X86_64
-static void aesni_ctr_enc_avx_tfm(struct crypto_aes_ctx *ctx, u8 *out,
-			      const u8 *in, unsigned int len, u8 *iv)
-{
-	/*
-	 * based on key length, override with the by8 version
-	 * of ctr mode encryption/decryption for improved performance
-	 * aes_set_key_common() ensures that key length is one of
-	 * {128,192,256}
-	 */
-	if (ctx->key_length == AES_KEYSIZE_128)
-		aes_ctr_enc_128_avx_by8(in, iv, (void *)ctx, out, len);
-	else if (ctx->key_length == AES_KEYSIZE_192)
-		aes_ctr_enc_192_avx_by8(in, iv, (void *)ctx, out, len);
-	else
-		aes_ctr_enc_256_avx_by8(in, iv, (void *)ctx, out, len);
-}
-
-static int ctr_crypt(struct skcipher_request *req)
-{
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct crypto_aes_ctx *ctx = aes_ctx(crypto_skcipher_ctx(tfm));
-	u8 keystream[AES_BLOCK_SIZE];
-	struct skcipher_walk walk;
-	unsigned int nbytes;
-	int err;
-
-	err = skcipher_walk_virt(&walk, req, false);
-
-	while ((nbytes = walk.nbytes) > 0) {
-		kernel_fpu_begin();
-		if (nbytes & AES_BLOCK_MASK)
-			static_call(aesni_ctr_enc_tfm)(ctx, walk.dst.virt.addr,
-						       walk.src.virt.addr,
-						       nbytes & AES_BLOCK_MASK,
-						       walk.iv);
-		nbytes &= ~AES_BLOCK_MASK;
-
-		if (walk.nbytes == walk.total && nbytes > 0) {
-			aesni_enc(ctx, keystream, walk.iv);
-			crypto_xor_cpy(walk.dst.virt.addr + walk.nbytes - nbytes,
-				       walk.src.virt.addr + walk.nbytes - nbytes,
-				       keystream, nbytes);
-			crypto_inc(walk.iv, AES_BLOCK_SIZE);
-			nbytes = 0;
-		}
-		kernel_fpu_end();
-		err = skcipher_walk_done(&walk, nbytes);
-	}
-	return err;
-}
-
-static void aesni_xctr_enc_avx_tfm(struct crypto_aes_ctx *ctx, u8 *out,
-				   const u8 *in, unsigned int len, u8 *iv,
-				   unsigned int byte_ctr)
-{
-	if (ctx->key_length == AES_KEYSIZE_128)
-		aes_xctr_enc_128_avx_by8(in, iv, (void *)ctx, out, len,
-					 byte_ctr);
-	else if (ctx->key_length == AES_KEYSIZE_192)
-		aes_xctr_enc_192_avx_by8(in, iv, (void *)ctx, out, len,
-					 byte_ctr);
-	else
-		aes_xctr_enc_256_avx_by8(in, iv, (void *)ctx, out, len,
-					 byte_ctr);
-}
-
-static int xctr_crypt(struct skcipher_request *req)
-{
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct crypto_aes_ctx *ctx = aes_ctx(crypto_skcipher_ctx(tfm));
-	u8 keystream[AES_BLOCK_SIZE];
-	struct skcipher_walk walk;
-	unsigned int nbytes;
-	unsigned int byte_ctr = 0;
-	int err;
-	__le32 block[AES_BLOCK_SIZE / sizeof(__le32)];
-
-	err = skcipher_walk_virt(&walk, req, false);
-
-	while ((nbytes = walk.nbytes) > 0) {
-		kernel_fpu_begin();
-		if (nbytes & AES_BLOCK_MASK)
-			aesni_xctr_enc_avx_tfm(ctx, walk.dst.virt.addr,
-				walk.src.virt.addr, nbytes & AES_BLOCK_MASK,
-				walk.iv, byte_ctr);
-		nbytes &= ~AES_BLOCK_MASK;
-		byte_ctr += walk.nbytes - nbytes;
-
-		if (walk.nbytes == walk.total && nbytes > 0) {
-			memcpy(block, walk.iv, AES_BLOCK_SIZE);
-			block[0] ^= cpu_to_le32(1 + byte_ctr / AES_BLOCK_SIZE);
-			aesni_enc(ctx, keystream, (u8 *)block);
-			crypto_xor_cpy(walk.dst.virt.addr + walk.nbytes -
-				       nbytes, walk.src.virt.addr + walk.nbytes
-				       - nbytes, keystream, nbytes);
-			byte_ctr += nbytes;
-			nbytes = 0;
-		}
-		kernel_fpu_end();
-		err = skcipher_walk_done(&walk, nbytes);
-	}
-	return err;
-}
-#endif
-
 static int xts_setkey_aesni(struct crypto_skcipher *tfm, const u8 *key,
 			    unsigned int keylen)
 {
 	struct aesni_xts_ctx *ctx = aes_xts_ctx(tfm);
 	int err;
@@ -713,29 +579,10 @@ static struct skcipher_alg aesni_skciphers[] = {
 		.ivsize		= AES_BLOCK_SIZE,
 		.walksize	= 2 * AES_BLOCK_SIZE,
 		.setkey		= aesni_skcipher_setkey,
 		.encrypt	= cts_cbc_encrypt,
 		.decrypt	= cts_cbc_decrypt,
-#ifdef CONFIG_X86_64
-	}, {
-		.base = {
-			.cra_name		= "__ctr(aes)",
-			.cra_driver_name	= "__ctr-aes-aesni",
-			.cra_priority		= 400,
-			.cra_flags		= CRYPTO_ALG_INTERNAL,
-			.cra_blocksize		= 1,
-			.cra_ctxsize		= CRYPTO_AES_CTX_SIZE,
-			.cra_module		= THIS_MODULE,
-		},
-		.min_keysize	= AES_MIN_KEY_SIZE,
-		.max_keysize	= AES_MAX_KEY_SIZE,
-		.ivsize		= AES_BLOCK_SIZE,
-		.chunksize	= AES_BLOCK_SIZE,
-		.setkey		= aesni_skcipher_setkey,
-		.encrypt	= ctr_crypt,
-		.decrypt	= ctr_crypt,
-#endif
 	}, {
 		.base = {
 			.cra_name		= "__xts(aes)",
 			.cra_driver_name	= "__xts-aes-aesni",
 			.cra_priority		= 401,
@@ -756,39 +603,109 @@ static struct skcipher_alg aesni_skciphers[] = {
 
 static
 struct simd_skcipher_alg *aesni_simd_skciphers[ARRAY_SIZE(aesni_skciphers)];
 
 #ifdef CONFIG_X86_64
-/*
- * XCTR does not have a non-AVX implementation, so it must be enabled
- * conditionally.
- */
-static struct skcipher_alg aesni_xctr = {
-	.base = {
-		.cra_name		= "__xctr(aes)",
-		.cra_driver_name	= "__xctr-aes-aesni",
-		.cra_priority		= 400,
-		.cra_flags		= CRYPTO_ALG_INTERNAL,
-		.cra_blocksize		= 1,
-		.cra_ctxsize		= CRYPTO_AES_CTX_SIZE,
-		.cra_module		= THIS_MODULE,
-	},
-	.min_keysize	= AES_MIN_KEY_SIZE,
-	.max_keysize	= AES_MAX_KEY_SIZE,
-	.ivsize		= AES_BLOCK_SIZE,
-	.chunksize	= AES_BLOCK_SIZE,
-	.setkey		= aesni_skcipher_setkey,
-	.encrypt	= xctr_crypt,
-	.decrypt	= xctr_crypt,
-};
-
-static struct simd_skcipher_alg *aesni_simd_xctr;
-
 asmlinkage void aes_xts_encrypt_iv(const struct crypto_aes_ctx *tweak_key,
 				   u8 iv[AES_BLOCK_SIZE]);
 
-#define DEFINE_XTS_ALG(suffix, driver_name, priority)			       \
+/* __always_inline to avoid indirect call */
+static __always_inline int
+ctr_crypt(struct skcipher_request *req,
+	  void (*ctr64_func)(const struct crypto_aes_ctx *key,
+			     const u8 *src, u8 *dst, int len,
+			     const u64 le_ctr[2]))
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	const struct crypto_aes_ctx *key = aes_ctx(crypto_skcipher_ctx(tfm));
+	unsigned int nbytes, p1_nbytes, nblocks;
+	struct skcipher_walk walk;
+	u64 le_ctr[2];
+	u64 ctr64;
+	int err;
+
+	ctr64 = le_ctr[0] = get_unaligned_be64(&req->iv[8]);
+	le_ctr[1] = get_unaligned_be64(&req->iv[0]);
+
+	err = skcipher_walk_virt(&walk, req, false);
+
+	while ((nbytes = walk.nbytes) != 0) {
+		if (nbytes < walk.total) {
+			/* Not the end yet, so keep the length block-aligned. */
+			nbytes = round_down(nbytes, AES_BLOCK_SIZE);
+			nblocks = nbytes / AES_BLOCK_SIZE;
+		} else {
+			/* It's the end, so include any final partial block. */
+			nblocks = DIV_ROUND_UP(nbytes, AES_BLOCK_SIZE);
+		}
+		ctr64 += nblocks;
+
+		kernel_fpu_begin();
+		if (likely(ctr64 >= nblocks)) {
+			/* The low 64 bits of the counter won't overflow. */
+			(*ctr64_func)(key, walk.src.virt.addr,
+				      walk.dst.virt.addr, nbytes, le_ctr);
+		} else {
+			/*
+			 * The low 64 bits of the counter will overflow.  The
+			 * assembly doesn't handle this case, so split the
+			 * operation into two at the point where the overflow
+			 * will occur.  After the first part, add the carry bit.
+			 */
+			p1_nbytes = min_t(unsigned int, nbytes,
+					  (nblocks - ctr64) * AES_BLOCK_SIZE);
+			(*ctr64_func)(key, walk.src.virt.addr,
+				      walk.dst.virt.addr, p1_nbytes, le_ctr);
+			le_ctr[0] = 0;
+			le_ctr[1]++;
+			(*ctr64_func)(key, walk.src.virt.addr + p1_nbytes,
+				      walk.dst.virt.addr + p1_nbytes,
+				      nbytes - p1_nbytes, le_ctr);
+		}
+		kernel_fpu_end();
+		le_ctr[0] = ctr64;
+
+		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
+	}
+
+	put_unaligned_be64(ctr64, &req->iv[8]);
+	put_unaligned_be64(le_ctr[1], &req->iv[0]);
+
+	return err;
+}
+
+/* __always_inline to avoid indirect call */
+static __always_inline int
+xctr_crypt(struct skcipher_request *req,
+	   void (*xctr_func)(const struct crypto_aes_ctx *key,
+			     const u8 *src, u8 *dst, int len,
+			     const u8 iv[AES_BLOCK_SIZE], u64 ctr))
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	const struct crypto_aes_ctx *key = aes_ctx(crypto_skcipher_ctx(tfm));
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	u64 ctr = 1;
+	int err;
+
+	err = skcipher_walk_virt(&walk, req, false);
+	while ((nbytes = walk.nbytes) != 0) {
+		if (nbytes < walk.total)
+			nbytes = round_down(nbytes, AES_BLOCK_SIZE);
+
+		kernel_fpu_begin();
+		(*xctr_func)(key, walk.src.virt.addr, walk.dst.virt.addr,
+			     nbytes, req->iv, ctr);
+		kernel_fpu_end();
+
+		ctr += DIV_ROUND_UP(nbytes, AES_BLOCK_SIZE);
+		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
+	}
+	return err;
+}
+
+#define DEFINE_AVX_SKCIPHER_ALGS(suffix, driver_name_suffix, priority)	       \
 									       \
 asmlinkage void								       \
 aes_xts_encrypt_##suffix(const struct crypto_aes_ctx *key, const u8 *src,      \
 			 u8 *dst, int len, u8 tweak[AES_BLOCK_SIZE]);	       \
 asmlinkage void								       \
@@ -803,36 +720,84 @@ static int xts_encrypt_##suffix(struct skcipher_request *req)		       \
 static int xts_decrypt_##suffix(struct skcipher_request *req)		       \
 {									       \
 	return xts_crypt(req, aes_xts_encrypt_iv, aes_xts_decrypt_##suffix);   \
 }									       \
 									       \
-static struct skcipher_alg aes_xts_alg_##suffix = {			       \
-	.base = {							       \
-		.cra_name		= "__xts(aes)",			       \
-		.cra_driver_name	= "__" driver_name,		       \
-		.cra_priority		= priority,			       \
-		.cra_flags		= CRYPTO_ALG_INTERNAL,		       \
-		.cra_blocksize		= AES_BLOCK_SIZE,		       \
-		.cra_ctxsize		= XTS_AES_CTX_SIZE,		       \
-		.cra_module		= THIS_MODULE,			       \
-	},								       \
-	.min_keysize	= 2 * AES_MIN_KEY_SIZE,				       \
-	.max_keysize	= 2 * AES_MAX_KEY_SIZE,				       \
-	.ivsize		= AES_BLOCK_SIZE,				       \
-	.walksize	= 2 * AES_BLOCK_SIZE,				       \
-	.setkey		= xts_setkey_aesni,				       \
-	.encrypt	= xts_encrypt_##suffix,				       \
-	.decrypt	= xts_decrypt_##suffix,				       \
-};									       \
+asmlinkage void								       \
+aes_ctr64_crypt_##suffix(const struct crypto_aes_ctx *key,		       \
+			 const u8 *src, u8 *dst, int len, const u64 le_ctr[2]);\
+									       \
+static int ctr_crypt_##suffix(struct skcipher_request *req)		       \
+{									       \
+	return ctr_crypt(req, aes_ctr64_crypt_##suffix);		       \
+}									       \
+									       \
+asmlinkage void								       \
+aes_xctr_crypt_##suffix(const struct crypto_aes_ctx *key,		       \
+			const u8 *src, u8 *dst, int len,		       \
+			const u8 iv[AES_BLOCK_SIZE], u64 ctr);		       \
 									       \
-static struct simd_skcipher_alg *aes_xts_simdalg_##suffix
+static int xctr_crypt_##suffix(struct skcipher_request *req)		       \
+{									       \
+	return xctr_crypt(req, aes_xctr_crypt_##suffix);		       \
+}									       \
+									       \
+static struct skcipher_alg skcipher_algs_##suffix[] = {{		       \
+	.base.cra_name		= "__xts(aes)",				       \
+	.base.cra_driver_name	= "__xts-aes-" driver_name_suffix,	       \
+	.base.cra_priority	= priority,				       \
+	.base.cra_flags		= CRYPTO_ALG_INTERNAL,			       \
+	.base.cra_blocksize	= AES_BLOCK_SIZE,			       \
+	.base.cra_ctxsize	= XTS_AES_CTX_SIZE,			       \
+	.base.cra_module	= THIS_MODULE,				       \
+	.min_keysize		= 2 * AES_MIN_KEY_SIZE,			       \
+	.max_keysize		= 2 * AES_MAX_KEY_SIZE,			       \
+	.ivsize			= AES_BLOCK_SIZE,			       \
+	.walksize		= 2 * AES_BLOCK_SIZE,			       \
+	.setkey			= xts_setkey_aesni,			       \
+	.encrypt		= xts_encrypt_##suffix,			       \
+	.decrypt		= xts_decrypt_##suffix,			       \
+}, {									       \
+	.base.cra_name		= "__ctr(aes)",				       \
+	.base.cra_driver_name	= "__ctr-aes-" driver_name_suffix,	       \
+	.base.cra_priority	= priority,				       \
+	.base.cra_flags		= CRYPTO_ALG_INTERNAL,			       \
+	.base.cra_blocksize	= 1,					       \
+	.base.cra_ctxsize	= CRYPTO_AES_CTX_SIZE,			       \
+	.base.cra_module	= THIS_MODULE,				       \
+	.min_keysize		= AES_MIN_KEY_SIZE,			       \
+	.max_keysize		= AES_MAX_KEY_SIZE,			       \
+	.ivsize			= AES_BLOCK_SIZE,			       \
+	.chunksize		= AES_BLOCK_SIZE,			       \
+	.setkey			= aesni_skcipher_setkey,		       \
+	.encrypt		= ctr_crypt_##suffix,			       \
+	.decrypt		= ctr_crypt_##suffix,			       \
+}, {									       \
+	.base.cra_name		= "__xctr(aes)",			       \
+	.base.cra_driver_name	= "__xctr-aes-" driver_name_suffix,	       \
+	.base.cra_priority	= priority,				       \
+	.base.cra_flags		= CRYPTO_ALG_INTERNAL,			       \
+	.base.cra_blocksize	= 1,					       \
+	.base.cra_ctxsize	= CRYPTO_AES_CTX_SIZE,			       \
+	.base.cra_module	= THIS_MODULE,				       \
+	.min_keysize		= AES_MIN_KEY_SIZE,			       \
+	.max_keysize		= AES_MAX_KEY_SIZE,			       \
+	.ivsize			= AES_BLOCK_SIZE,			       \
+	.chunksize		= AES_BLOCK_SIZE,			       \
+	.setkey			= aesni_skcipher_setkey,		       \
+	.encrypt		= xctr_crypt_##suffix,			       \
+	.decrypt		= xctr_crypt_##suffix,			       \
+}};									       \
+									       \
+static struct simd_skcipher_alg *					       \
+simd_skcipher_algs_##suffix[ARRAY_SIZE(skcipher_algs_##suffix)]
 
-DEFINE_XTS_ALG(aesni_avx, "xts-aes-aesni-avx", 500);
+DEFINE_AVX_SKCIPHER_ALGS(aesni_avx, "aesni-avx", 500);
 #if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
-DEFINE_XTS_ALG(vaes_avx2, "xts-aes-vaes-avx2", 600);
-DEFINE_XTS_ALG(vaes_avx10_256, "xts-aes-vaes-avx10_256", 700);
-DEFINE_XTS_ALG(vaes_avx10_512, "xts-aes-vaes-avx10_512", 800);
+DEFINE_AVX_SKCIPHER_ALGS(vaes_avx2, "vaes-avx2", 600);
+DEFINE_AVX_SKCIPHER_ALGS(vaes_avx10_256, "vaes-avx10_256", 700);
+DEFINE_AVX_SKCIPHER_ALGS(vaes_avx10_512, "vaes-avx10_512", 800);
 #endif
 
 /* The common part of the x86_64 AES-GCM key struct */
 struct aes_gcm_key {
 	/* Expanded AES key and the AES key length in bytes */
@@ -1560,40 +1525,49 @@ static int __init register_avx_algs(void)
 {
 	int err;
 
 	if (!boot_cpu_has(X86_FEATURE_AVX))
 		return 0;
-	err = simd_register_skciphers_compat(&aes_xts_alg_aesni_avx, 1,
-					     &aes_xts_simdalg_aesni_avx);
+	err = simd_register_skciphers_compat(skcipher_algs_aesni_avx,
+					     ARRAY_SIZE(skcipher_algs_aesni_avx),
+					     simd_skcipher_algs_aesni_avx);
 	if (err)
 		return err;
 	err = simd_register_aeads_compat(aes_gcm_algs_aesni_avx,
 					 ARRAY_SIZE(aes_gcm_algs_aesni_avx),
 					 aes_gcm_simdalgs_aesni_avx);
 	if (err)
 		return err;
+	/*
+	 * Note: not all the algorithms registered below actually require
+	 * VPCLMULQDQ.  But in practice every CPU with VAES also has VPCLMULQDQ.
+	 * Similarly, the assembler support was added at about the same time.
+	 * For simplicity, just always check for VAES and VPCLMULQDQ together.
+	 */
 #if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
 	if (!boot_cpu_has(X86_FEATURE_AVX2) ||
 	    !boot_cpu_has(X86_FEATURE_VAES) ||
 	    !boot_cpu_has(X86_FEATURE_VPCLMULQDQ) ||
 	    !boot_cpu_has(X86_FEATURE_PCLMULQDQ) ||
 	    !cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL))
 		return 0;
-	err = simd_register_skciphers_compat(&aes_xts_alg_vaes_avx2, 1,
-					     &aes_xts_simdalg_vaes_avx2);
+	err = simd_register_skciphers_compat(skcipher_algs_vaes_avx2,
+					     ARRAY_SIZE(skcipher_algs_vaes_avx2),
+					     simd_skcipher_algs_vaes_avx2);
 	if (err)
 		return err;
 
 	if (!boot_cpu_has(X86_FEATURE_AVX512BW) ||
 	    !boot_cpu_has(X86_FEATURE_AVX512VL) ||
 	    !boot_cpu_has(X86_FEATURE_BMI2) ||
 	    !cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM |
 			       XFEATURE_MASK_AVX512, NULL))
 		return 0;
 
-	err = simd_register_skciphers_compat(&aes_xts_alg_vaes_avx10_256, 1,
-					     &aes_xts_simdalg_vaes_avx10_256);
+	err = simd_register_skciphers_compat(skcipher_algs_vaes_avx10_256,
+					     ARRAY_SIZE(skcipher_algs_vaes_avx10_256),
+					     simd_skcipher_algs_vaes_avx10_256);
 	if (err)
 		return err;
 	err = simd_register_aeads_compat(aes_gcm_algs_vaes_avx10_256,
 					 ARRAY_SIZE(aes_gcm_algs_vaes_avx10_256),
 					 aes_gcm_simdalgs_vaes_avx10_256);
@@ -1601,17 +1575,19 @@ static int __init register_avx_algs(void)
 		return err;
 
 	if (x86_match_cpu(zmm_exclusion_list)) {
 		int i;
 
-		aes_xts_alg_vaes_avx10_512.base.cra_priority = 1;
+		for (i = 0; i < ARRAY_SIZE(skcipher_algs_vaes_avx10_512); i++)
+			skcipher_algs_vaes_avx10_512[i].base.cra_priority = 1;
 		for (i = 0; i < ARRAY_SIZE(aes_gcm_algs_vaes_avx10_512); i++)
 			aes_gcm_algs_vaes_avx10_512[i].base.cra_priority = 1;
 	}
 
-	err = simd_register_skciphers_compat(&aes_xts_alg_vaes_avx10_512, 1,
-					     &aes_xts_simdalg_vaes_avx10_512);
+	err = simd_register_skciphers_compat(skcipher_algs_vaes_avx10_512,
+					     ARRAY_SIZE(skcipher_algs_vaes_avx10_512),
+					     simd_skcipher_algs_vaes_avx10_512);
 	if (err)
 		return err;
 	err = simd_register_aeads_compat(aes_gcm_algs_vaes_avx10_512,
 					 ARRAY_SIZE(aes_gcm_algs_vaes_avx10_512),
 					 aes_gcm_simdalgs_vaes_avx10_512);
@@ -1621,31 +1597,35 @@ static int __init register_avx_algs(void)
 	return 0;
 }
 
 static void unregister_avx_algs(void)
 {
-	if (aes_xts_simdalg_aesni_avx)
-		simd_unregister_skciphers(&aes_xts_alg_aesni_avx, 1,
-					  &aes_xts_simdalg_aesni_avx);
+	if (simd_skcipher_algs_aesni_avx[0])
+		simd_unregister_skciphers(skcipher_algs_aesni_avx,
+					  ARRAY_SIZE(skcipher_algs_aesni_avx),
+					  simd_skcipher_algs_aesni_avx);
 	if (aes_gcm_simdalgs_aesni_avx[0])
 		simd_unregister_aeads(aes_gcm_algs_aesni_avx,
 				      ARRAY_SIZE(aes_gcm_algs_aesni_avx),
 				      aes_gcm_simdalgs_aesni_avx);
 #if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
-	if (aes_xts_simdalg_vaes_avx2)
-		simd_unregister_skciphers(&aes_xts_alg_vaes_avx2, 1,
-					  &aes_xts_simdalg_vaes_avx2);
-	if (aes_xts_simdalg_vaes_avx10_256)
-		simd_unregister_skciphers(&aes_xts_alg_vaes_avx10_256, 1,
-					  &aes_xts_simdalg_vaes_avx10_256);
+	if (simd_skcipher_algs_vaes_avx2[0])
+		simd_unregister_skciphers(skcipher_algs_vaes_avx2,
+					  ARRAY_SIZE(skcipher_algs_vaes_avx2),
+					  simd_skcipher_algs_vaes_avx2);
+	if (simd_skcipher_algs_vaes_avx10_256[0])
+		simd_unregister_skciphers(skcipher_algs_vaes_avx10_256,
+					  ARRAY_SIZE(skcipher_algs_vaes_avx10_256),
+					  simd_skcipher_algs_vaes_avx10_256);
 	if (aes_gcm_simdalgs_vaes_avx10_256[0])
 		simd_unregister_aeads(aes_gcm_algs_vaes_avx10_256,
 				      ARRAY_SIZE(aes_gcm_algs_vaes_avx10_256),
 				      aes_gcm_simdalgs_vaes_avx10_256);
-	if (aes_xts_simdalg_vaes_avx10_512)
-		simd_unregister_skciphers(&aes_xts_alg_vaes_avx10_512, 1,
-					  &aes_xts_simdalg_vaes_avx10_512);
+	if (simd_skcipher_algs_vaes_avx10_512[0])
+		simd_unregister_skciphers(skcipher_algs_vaes_avx10_512,
+					  ARRAY_SIZE(skcipher_algs_vaes_avx10_512),
+					  simd_skcipher_algs_vaes_avx10_512);
 	if (aes_gcm_simdalgs_vaes_avx10_512[0])
 		simd_unregister_aeads(aes_gcm_algs_vaes_avx10_512,
 				      ARRAY_SIZE(aes_gcm_algs_vaes_avx10_512),
 				      aes_gcm_simdalgs_vaes_avx10_512);
 #endif
@@ -1674,17 +1654,10 @@ static int __init aesni_init(void)
 {
 	int err;
 
 	if (!x86_match_cpu(aesni_cpu_id))
 		return -ENODEV;
-#ifdef CONFIG_X86_64
-	if (boot_cpu_has(X86_FEATURE_AVX)) {
-		/* optimize performance of ctr mode encryption transform */
-		static_call_update(aesni_ctr_enc_tfm, aesni_ctr_enc_avx_tfm);
-		pr_info("AES CTR mode by8 optimization enabled\n");
-	}
-#endif /* CONFIG_X86_64 */
 
 	err = crypto_register_alg(&aesni_cipher_alg);
 	if (err)
 		return err;
 
@@ -1698,31 +1671,18 @@ static int __init aesni_init(void)
 					 ARRAY_SIZE(aes_gcm_algs_aesni),
 					 aes_gcm_simdalgs_aesni);
 	if (err)
 		goto unregister_skciphers;
 
-#ifdef CONFIG_X86_64
-	if (boot_cpu_has(X86_FEATURE_AVX))
-		err = simd_register_skciphers_compat(&aesni_xctr, 1,
-						     &aesni_simd_xctr);
-	if (err)
-		goto unregister_aeads;
-#endif /* CONFIG_X86_64 */
-
 	err = register_avx_algs();
 	if (err)
 		goto unregister_avx;
 
 	return 0;
 
 unregister_avx:
 	unregister_avx_algs();
-#ifdef CONFIG_X86_64
-	if (aesni_simd_xctr)
-		simd_unregister_skciphers(&aesni_xctr, 1, &aesni_simd_xctr);
-unregister_aeads:
-#endif /* CONFIG_X86_64 */
 	simd_unregister_aeads(aes_gcm_algs_aesni,
 			      ARRAY_SIZE(aes_gcm_algs_aesni),
 			      aes_gcm_simdalgs_aesni);
 unregister_skciphers:
 	simd_unregister_skciphers(aesni_skciphers, ARRAY_SIZE(aesni_skciphers),
@@ -1738,14 +1698,10 @@ static void __exit aesni_exit(void)
 			      ARRAY_SIZE(aes_gcm_algs_aesni),
 			      aes_gcm_simdalgs_aesni);
 	simd_unregister_skciphers(aesni_skciphers, ARRAY_SIZE(aesni_skciphers),
 				  aesni_simd_skciphers);
 	crypto_unregister_alg(&aesni_cipher_alg);
-#ifdef CONFIG_X86_64
-	if (boot_cpu_has(X86_FEATURE_AVX))
-		simd_unregister_skciphers(&aesni_xctr, 1, &aesni_simd_xctr);
-#endif /* CONFIG_X86_64 */
 	unregister_avx_algs();
 }
 
 module_init(aesni_init);
 module_exit(aesni_exit);

base-commit: 805ba04cb7ccfc7d72e834ebd796e043142156ba
-- 
2.48.1



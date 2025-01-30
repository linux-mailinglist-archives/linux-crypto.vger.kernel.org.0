Return-Path: <linux-crypto+bounces-9277-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9F8A227FA
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Jan 2025 04:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E05165C4F
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Jan 2025 03:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E81192D70;
	Thu, 30 Jan 2025 03:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHJRdzVM"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28685190055;
	Thu, 30 Jan 2025 03:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738209296; cv=none; b=mrrhW1EfBmzPQGZK75ruWymu7UCjj+l01xvgbzGTTlhQ6Be8PlFbDaiANSMXs/2NfDpPUWS/emuSTh4jN+r0eiPt94EmKpSM82MBGEk0VIPIWevtMdAw6EmGcARcw1ba48OAXrYdJNFeXV18uIzPyEVauLG3k5wY8Avv7dKkpJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738209296; c=relaxed/simple;
	bh=shZTmuMKpE0aqshpdJXhBO0pKQHLExe2RqFppaUmumA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RcJRquOU5Q7aWqXJmMDNwEMczM5J983xgvWdvtcUTepcFW3xUVbDviZ5b2YiVtC0B7Y6GDQp6TLHiScl/msbkhZuYPLpa/NZwSJm3IfNq+Hz0XCcK+6wdsLin8yllLrUCRi1fw1DyncBBDelA+D5zunMJUgFabSNqO9BLwGFp0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHJRdzVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57686C4CEE7;
	Thu, 30 Jan 2025 03:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738209295;
	bh=shZTmuMKpE0aqshpdJXhBO0pKQHLExe2RqFppaUmumA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cHJRdzVMDDVO0p1f2WFiwVU5wMTu02DkGU/Xidw0RVxl+a3TxS2W1JieDF+0hbCoT
	 9pOG60EIatmwdrwnLnU/nwstJsYLWjDTvYli38OVFxwobtQUEo5X+OsyZJ0svuwr7P
	 4OGyA65HX/qHYgP8W02iaKL01LV4P4r4+N34i5gaarJzeWj84ylTKJZQLOFeclU5O5
	 TH9EaLYISsHzPhQSesOWuB6mGIEw55jSq/+4jAA2dN6/E02ZrBIkL1caJ6J+OrjZPL
	 mZV7cqpILpfw3DtWzXWB+7XkBqVJjpaWbGmbUjb+PrOqKBwGhe4T/Jy6o0vDxGn4J5
	 fE2qSou8sKHVw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	x86@kernel.org,
	linux-block@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v2 08/11] x86/crc: add "template" for [V]PCLMULQDQ based CRC functions
Date: Wed, 29 Jan 2025 19:51:27 -0800
Message-ID: <20250130035130.180676-9-ebiggers@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130035130.180676-1-ebiggers@kernel.org>
References: <20250130035130.180676-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

The Linux kernel implements many variants of CRC, such as crc16,
crc_t10dif, crc32_le, crc32c, crc32_be, crc64_nvme, and crc64_be.  On
x86, except for crc32c which has special scalar instructions, the
fastest way to compute any of these CRCs on any message of length
roughly >= 16 bytes is to use the SIMD carryless multiplication
instructions PCLMULQDQ or VPCLMULQDQ.  Depending on the available CPU
features this can mean PCLMULQDQ+SSE4.1, VPCLMULQDQ+AVX2,
VPCLMULQDQ+AVX10/256, or VPCLMULQDQ+AVX10/512 (or the AVX512 equivalents
to AVX10/*).  This results in a total of 20+ CRC implementations being
potentially needed to properly optimize all CRCs that someone cares
about for x86.  Besides crc32c, currently only crc32_le and crc_t10dif
are actually optimized for x86, and they only use PCLMULQDQ, which means
they can be 2-4x slower than what is possible with VPCLMULQDQ.

Fortunately, at a high level the code that is needed for any
[V]PCLMULQDQ based CRC implementation is mostly the same.  Therefore,
this patch introduces an assembly macro that expands into the body of a
[V]PCLMULQDQ based CRC function for a given number of bits (8, 16, 32,
or 64), bit order (LSB or MSB-first), vector length, and AVX level.

The function expects to be passed a constants table, specific to the
polynomial desired, that was generated by the script previously added.
When two CRC variants share the same number of bits and bit order, the
same functions can be reused, with only the constants table differing.

A new C header is also added to make it easy to integrate the new
assembly code using a static call.

The result is that it becomes straightforward to wire up an optimized
implementation of any CRC-8, CRC-16, CRC-32, or CRC-64 for x86.  Later
patches will wire up specific CRC variants.

Although this new template allows easily generating many functions, care
was taken to still keep the binary size fairly low.  Each generated
function is only 550 to 850 bytes depending on the CRC variant and
target CPU features.  And only one function per CRC variant is actually
used at runtime (since all functions support all lengths >= 16 bytes).

Note that a similar approach should also work for other architectures
that have carryless multiplication instructions, such as arm64.

Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/lib/crc-pclmul-template.S | 578 +++++++++++++++++++++++++++++
 arch/x86/lib/crc-pclmul-template.h |  81 ++++
 2 files changed, 659 insertions(+)
 create mode 100644 arch/x86/lib/crc-pclmul-template.S
 create mode 100644 arch/x86/lib/crc-pclmul-template.h

diff --git a/arch/x86/lib/crc-pclmul-template.S b/arch/x86/lib/crc-pclmul-template.S
new file mode 100644
index 000000000000..aeeff26a876a
--- /dev/null
+++ b/arch/x86/lib/crc-pclmul-template.S
@@ -0,0 +1,578 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+//
+// Template to generate [V]PCLMULQDQ-based CRC functions for x86
+//
+// Copyright 2025 Google LLC
+//
+// Author: Eric Biggers <ebiggers@google.com>
+
+#include <linux/linkage.h>
+
+// Offsets within the generated constants table
+.set OFFSETOF_BSWAP_MASK,			-5*16	// only used for MSB CRC
+.set OFFSETOF_FOLD_ACROSS_2048BIT_CONSTS,	-4*16	// must precede next
+.set OFFSETOF_FOLD_ACROSS_1024BIT_CONSTS,	-3*16	// must precede next
+.set OFFSETOF_FOLD_ACROSS_512BIT_CONSTS,	-2*16	// must precede next
+.set OFFSETOF_FOLD_ACROSS_256BIT_CONSTS,	-1*16	// must precede next
+.set OFFSETOF_FOLD_ACROSS_128BIT_CONSTS,	0*16	// must be 0 offset
+.set OFFSETOF_SHUF_TABLE,			1*16
+.set OFFSETOF_BARRETT_REDUCTION_CONSTS,		4*16
+
+// Emit a VEX (or EVEX) coded instruction if allowed, or emulate it using the
+// corresponding non-VEX instruction plus any needed moves.  The supported
+// instruction formats are:
+//
+//     - Two-arg [src, dst], where the non-VEX form is the same.
+//     - Three-arg [src1, src2, dst] where the non-VEX form is
+//	 [src1, src2_and_dst].  If src2 != dst, then src1 must != dst too.
+//
+// \insn gives the instruction without a "v" prefix and including any immediate
+// argument if needed to make the instruction follow one of the above formats.
+// If \unaligned_mem_tmp is given, then the emitted non-VEX code moves \arg1 to
+// it first; this is needed when \arg1 is an unaligned mem operand.
+.macro	_cond_vex	insn:req, arg1:req, arg2:req, arg3, unaligned_mem_tmp
+.if AVX_LEVEL == 0
+  // VEX not allowed.  Emulate it.
+  .ifnb \arg3 // Three-arg [src1, src2, dst]
+    .ifc "\arg2", "\arg3" // src2 == dst?
+      .ifnb \unaligned_mem_tmp
+	movdqu		\arg1, \unaligned_mem_tmp
+	\insn		\unaligned_mem_tmp, \arg3
+      .else
+	\insn		\arg1, \arg3
+      .endif
+    .else // src2 != dst
+      .ifc "\arg1", "\arg3"
+	.error "Can't have src1 == dst when src2 != dst"
+      .endif
+      .ifnb \unaligned_mem_tmp
+	movdqu		\arg1, \unaligned_mem_tmp
+	movdqa		\arg2, \arg3
+	\insn		\unaligned_mem_tmp, \arg3
+      .else
+	movdqa		\arg2, \arg3
+	\insn		\arg1, \arg3
+      .endif
+    .endif
+  .else // Two-arg [src, dst]
+    .ifnb \unaligned_mem_tmp
+	movdqu		\arg1, \unaligned_mem_tmp
+	\insn		\unaligned_mem_tmp, \arg2
+    .else
+	\insn		\arg1, \arg2
+    .endif
+  .endif
+.else
+  // VEX is allowed.  Emit the desired instruction directly.
+  .ifnb \arg3
+	v\insn		\arg1, \arg2, \arg3
+  .else
+	v\insn		\arg1, \arg2
+  .endif
+.endif
+.endm
+
+// Broadcast an aligned 128-bit mem operand to all 128-bit lanes of a vector
+// register of length VL.
+.macro	_vbroadcast	src, dst
+.if VL == 16
+	_cond_vex movdqa,	\src, \dst
+.elseif VL == 32
+	vbroadcasti128		\src, \dst
+.else
+	vbroadcasti32x4		\src, \dst
+.endif
+.endm
+
+// Load \vl bytes from the unaligned mem operand \src into \dst, and if the CRC
+// is MSB-first use \bswap_mask to reflect the bytes within each 128-bit lane.
+.macro	_load_data	vl, src, bswap_mask, dst
+.if \vl < 64
+	_cond_vex movdqu,	"\src", \dst
+.else
+	vmovdqu8		\src, \dst
+.endif
+.if !LSB_CRC
+	_cond_vex pshufb,	\bswap_mask, \dst, \dst
+.endif
+.endm
+
+.macro	_prepare_v0	vl, v0, v1, bswap_mask
+.if LSB_CRC
+  .if \vl < 64
+	_cond_vex pxor,		(BUF), \v0, \v0, unaligned_mem_tmp=\v1
+  .else
+        vpxorq			(BUF), \v0, \v0
+  .endif
+.else
+	_load_data		\vl, (BUF), \bswap_mask, \v1
+  .if \vl < 64
+	_cond_vex pxor,		\v1, \v0, \v0
+  .else
+	vpxorq			\v1, \v0, \v0
+  .endif
+.endif
+.endm
+
+// Fold \acc into \data and store the result back into \acc.  \data can be an
+// unaligned mem operand if using VEX is allowed and the CRC is LSB-first so no
+// byte-reflection is needed; otherwise it must be a vector register.  \consts
+// is a vector register containing the needed fold constants, and \tmp is a
+// temporary vector register.  All arguments must be the same length.
+.macro	_fold_vec	acc, data, consts, tmp
+	_cond_vex "pclmulqdq $0x00,",	\consts, \acc, \tmp
+	_cond_vex "pclmulqdq $0x11,",	\consts, \acc, \acc
+.if AVX_LEVEL < 10
+	_cond_vex pxor,	\data, \tmp, \tmp
+	_cond_vex pxor,	\tmp, \acc, \acc
+.else
+	vpternlogq	$0x96, \data, \tmp, \acc
+.endif
+.endm
+
+// Fold \acc into \data and store the result back into \acc.  \data is an
+// unaligned mem operand, \consts is a vector register containing the needed
+// fold constants, \bswap_mask is a vector register containing the
+// byte-reflection table if the CRC is MSB-first, and \tmp1 and \tmp2 are
+// temporary vector registers.  All arguments must have length \vl.
+.macro	_fold_vec_mem	vl, acc, data, consts, bswap_mask, tmp1, tmp2
+.if AVX_LEVEL == 0 || !LSB_CRC
+	_load_data	\vl, \data, \bswap_mask, \tmp1
+	_fold_vec	\acc, \tmp1, \consts, \tmp2
+.else
+	_fold_vec	\acc, \data, \consts, \tmp1
+.endif
+.endm
+
+// Load the constants for folding across 2**i vectors of length VL at a time
+// into all 128-bit lanes of the vector register CONSTS.
+.macro	_load_vec_folding_consts	i
+	_vbroadcast OFFSETOF_FOLD_ACROSS_128BIT_CONSTS+(4-LOG2_VL-\i)*16(CONSTS_PTR), \
+		    CONSTS
+.endm
+
+// Given vector registers \v0 and \v1 of length \vl, fold \v0 into \v1 and store
+// the result back into \v0.  If the remaining length mod \vl is nonzero, also
+// fold \vl bytes from (BUF).  For both operations the fold distance is \vl.
+// \consts must be a register of length \vl containing the fold constants.
+.macro	_fold_vec_final	vl, v0, v1, consts, bswap_mask, tmp1, tmp2
+	_fold_vec	\v0, \v1, \consts, \tmp1
+	test		$\vl, LEN8
+	jz		.Lfold_vec_final_done\@
+	_fold_vec_mem	\vl, \v0, (BUF), \consts, \bswap_mask, \tmp1, \tmp2
+	add		$\vl, BUF
+.Lfold_vec_final_done\@:
+.endm
+
+// This macro generates the body of a CRC function with the following prototype:
+//
+// crc_t crc_func(crc_t crc, const u8 *buf, size_t len, const void *consts);
+//
+// |crc| is the initial CRC, and crc_t is a data type wide enough to hold it.
+// |buf| is the data to checksum.  |len| is the data length in bytes, which must
+// be at least 16.  |consts| is a pointer to the fold_across_128_bits_consts
+// field of the constants table that was generated for the chosen CRC variant.
+//
+// Moving onto the macro parameters, \crc_bits is the number of bits in the CRC,
+// e.g. 32 for a CRC-32.  Currently the supported values are 8, 16, 32, and 64.
+// If the file is compiled in i386 mode, then the maximum supported value is 32.
+//
+// \lsb_crc is 1 if the CRC processes the least significant bit of each byte
+// first, i.e. maps bit0 to x^7, bit1 to x^6, ..., bit7 to x^0.  \lsb_crc is 0
+// if the CRC processes the most significant bit of each byte first, i.e. maps
+// bit0 to x^0, bit1 to x^1, bit7 to x^7.
+//
+// \vl is the maximum length of vector register to use in bytes: 16, 32, or 64.
+//
+// \avx_level is the level of AVX support to use: 0 for SSE only, 2 for AVX2, or
+// 10 for AVX10 or AVX512.
+//
+// If \vl == 16 && \avx_level == 0, the generated code requires:
+// PCLMULQDQ && SSE4.1.  (Note: all known CPUs with PCLMULQDQ also have SSE4.1.)
+//
+// If \vl == 32 && \avx_level == 2, the generated code requires:
+// VPCLMULQDQ && AVX2.
+//
+// If \vl == 32 && \avx_level == 10, the generated code requires:
+// VPCLMULQDQ && (AVX10/256 || (AVX512BW && AVX512VL))
+//
+// If \vl == 64 && \avx_level == 10, the generated code requires:
+// VPCLMULQDQ && (AVX10/512 || (AVX512BW && AVX512VL))
+//
+// Other \vl and \avx_level combinations are either not supported or not useful.
+.macro	_crc_pclmul	crc_bits, lsb_crc, vl, avx_level
+	.set	LSB_CRC,	\lsb_crc
+	.set	VL,		\vl
+	.set	AVX_LEVEL,	\avx_level
+
+	// Define aliases for the xmm, ymm, or zmm registers according to VL.
+.irp i, 0,1,2,3,4,5,6,7
+  .if VL == 16
+	.set	V\i,		%xmm\i
+	.set	LOG2_VL,	4
+  .elseif VL == 32
+	.set	V\i,		%ymm\i
+	.set	LOG2_VL,	5
+  .elseif VL == 64
+	.set	V\i,		%zmm\i
+	.set	LOG2_VL,	6
+  .else
+	.error "Unsupported vector length"
+  .endif
+.endr
+	// Define aliases for the function parameters.
+	// Note: when crc_t is shorter than u32, zero-extension to 32 bits is
+	// guaranteed by the ABI.  Zero-extension to 64 bits is *not* guaranteed
+	// when crc_t is shorter than u64.
+#ifdef __x86_64__
+.if \crc_bits <= 32
+	.set	CRC,		%edi
+.else
+	.set	CRC,		%rdi
+.endif
+	.set	BUF,		%rsi
+	.set	LEN,		%rdx
+	.set	LEN32,		%edx
+	.set	LEN8,		%dl
+	.set	CONSTS_PTR,	%rcx
+#else
+	// 32-bit support, assuming -mregparm=3 and not including support for
+	// CRC-64 (which would use both eax and edx to pass the crc parameter).
+	.set	CRC,		%eax
+	.set	BUF,		%edx
+	.set	LEN,		%ecx
+	.set	LEN32,		%ecx
+	.set	LEN8,		%cl
+	.set	CONSTS_PTR,	%ebx	// Passed on stack
+#endif
+
+	// Define aliases for some local variables.  V0-V5 are used without
+	// aliases (for accumulators, data, temporary values, etc).  Staying
+	// within the first 8 vector registers keeps the code 32-bit SSE
+	// compatible and reduces the size of 64-bit SSE code slightly.
+	.set	BSWAP_MASK,	V6
+	.set	BSWAP_MASK_YMM,	%ymm6
+	.set	BSWAP_MASK_XMM,	%xmm6
+	.set	CONSTS,		V7
+	.set	CONSTS_YMM,	%ymm7
+	.set	CONSTS_XMM,	%xmm7
+
+#ifdef __i386__
+	push		CONSTS_PTR
+	mov		8(%esp), CONSTS_PTR
+#endif
+
+	// Create a 128-bit vector that contains the initial CRC in the end
+	// representing the high-order polynomial coefficients, and the rest 0.
+.if \crc_bits <= 32
+	_cond_vex movd,		CRC, %xmm0
+.else
+	_cond_vex movq,		CRC, %xmm0
+.endif
+.if !LSB_CRC
+	_cond_vex pslldq,	$(128-\crc_bits)/8, %xmm0, %xmm0
+	_vbroadcast		OFFSETOF_BSWAP_MASK(CONSTS_PTR), BSWAP_MASK
+.endif
+
+	// Load the first vector of data and XOR the initial CRC into the
+	// appropriate end of the first 128-bit lane of data.  If LEN < VL, then
+	// use a short vector and jump to the end to do the final reduction.
+	// (LEN >= 16 is guaranteed here but not necessarily LEN >= VL.)
+.if VL >= 32
+	cmp		$VL, LEN
+	jae		2f
+  .if VL == 64
+	cmp		$32, LEN32
+	jb		1f
+	_prepare_v0	32, %ymm0, %ymm1, BSWAP_MASK_YMM
+	add		$32, BUF
+	jmp		.Lreduce_256bits_to_128bits\@
+1:
+  .endif
+	_prepare_v0	16, %xmm0, %xmm1, BSWAP_MASK_XMM
+	add		$16, BUF
+	vmovdqa		OFFSETOF_FOLD_ACROSS_128BIT_CONSTS(CONSTS_PTR), CONSTS_XMM
+	jmp		.Lcheck_for_partial_block\@
+2:
+.endif
+	_prepare_v0	VL, V0, V1, BSWAP_MASK
+
+	// Handle VL <= LEN < 4*VL.
+	cmp		$4*VL-1, LEN
+	ja		.Lfold_4vecs_prepare\@
+	add		$VL, BUF
+	// If VL <= LEN < 2*VL, then jump to the code at the end that handles
+	// the reduction from 1 vector.  If VL==16 then
+	// fold_across_128bit_consts must be loaded first, as the final
+	// reduction depends on it and it won't be loaded anywhere else.
+	cmp		$2*VL-1, LEN32
+.if VL == 16
+	_cond_vex movdqa, OFFSETOF_FOLD_ACROSS_128BIT_CONSTS(CONSTS_PTR), CONSTS_XMM
+.endif
+	jbe		.Lreduce_1vec_to_128bits\@
+	// Otherwise 2*VL <= LEN < 4*VL.  Load one more vector and jump to the
+	// code at the end that handles the reduction from 2 vectors.
+	_load_data	VL, (BUF), BSWAP_MASK, V1
+	add		$VL, BUF
+	jmp		.Lreduce_2vecs_to_1\@
+
+.Lfold_4vecs_prepare\@:
+	// Load 3 more vectors of data.
+	_load_data	VL, 1*VL(BUF), BSWAP_MASK, V1
+	_load_data	VL, 2*VL(BUF), BSWAP_MASK, V2
+	_load_data	VL, 3*VL(BUF), BSWAP_MASK, V3
+	sub		$-4*VL, BUF	// Shorter than 'add 4*VL' when VL=32
+	add		$-4*VL, LEN	// Shorter than 'sub 4*VL' when VL=32
+
+	// While >= 4 vectors of data remain, fold the 4 vectors V0-V3 into the
+	// next 4 vectors of data and write the result back to V0-V3.
+	cmp		$4*VL-1, LEN	// Shorter than 'cmp 4*VL' when VL=32
+	jbe		.Lreduce_4vecs_to_2\@
+	_load_vec_folding_consts	2
+.Lfold_4vecs_loop\@:
+	_fold_vec_mem	VL, V0, 0*VL(BUF), CONSTS, BSWAP_MASK, V4, V5
+	_fold_vec_mem	VL, V1, 1*VL(BUF), CONSTS, BSWAP_MASK, V4, V5
+	_fold_vec_mem	VL, V2, 2*VL(BUF), CONSTS, BSWAP_MASK, V4, V5
+	_fold_vec_mem	VL, V3, 3*VL(BUF), CONSTS, BSWAP_MASK, V4, V5
+	sub		$-4*VL, BUF
+	add		$-4*VL, LEN
+	cmp		$4*VL-1, LEN
+	ja		.Lfold_4vecs_loop\@
+
+	// Fold V0,V1 into V2,V3 and write the result back to V0,V1.
+	// Then fold two vectors of data, if at least that much remains.
+.Lreduce_4vecs_to_2\@:
+	_load_vec_folding_consts	1
+	_fold_vec	V0, V2, CONSTS, V4
+	_fold_vec	V1, V3, CONSTS, V4
+	test		$2*VL, LEN8
+	jz		.Lreduce_2vecs_to_1\@
+	_fold_vec_mem	VL, V0, 0*VL(BUF), CONSTS, BSWAP_MASK, V4, V5
+	_fold_vec_mem	VL, V1, 1*VL(BUF), CONSTS, BSWAP_MASK, V4, V5
+	sub		$-2*VL, BUF
+
+	// Fold V0 into V1 and write the result back to V0.
+	// Then fold one vector of data, if at least that much remains.
+.Lreduce_2vecs_to_1\@:
+	_load_vec_folding_consts	0
+	_fold_vec_final	VL, V0, V1, CONSTS, BSWAP_MASK, V4, V5
+
+.Lreduce_1vec_to_128bits\@:
+	// Reduce V0 to 128 bits xmm0.
+.if VL == 64
+	// zmm0 => ymm0
+	vbroadcasti128	OFFSETOF_FOLD_ACROSS_256BIT_CONSTS(CONSTS_PTR), CONSTS_YMM
+	vextracti64x4	$1, %zmm0, %ymm1
+	_fold_vec_final	32, %ymm0, %ymm1, CONSTS_YMM, BSWAP_MASK_YMM, %ymm4, %ymm5
+.endif
+.if VL >= 32
+.Lreduce_256bits_to_128bits\@:
+	// ymm0 => xmm0
+	vmovdqa		OFFSETOF_FOLD_ACROSS_128BIT_CONSTS(CONSTS_PTR), CONSTS_XMM
+	vextracti128	$1, %ymm0, %xmm1
+	_fold_vec_final	16, %xmm0, %xmm1, CONSTS_XMM, BSWAP_MASK_XMM, %xmm4, %xmm5
+.endif
+
+.Lcheck_for_partial_block\@:
+	and		$15, LEN32
+	jz		.Lpartial_block_done\@
+
+	// 1 <= LEN <= 15 data bytes remain.  The polynomial is now
+	// A*(x^(8*LEN)) + B, where A = xmm0 and B is the polynomial of the
+	// remaining LEN bytes.  To reduce this to 128 bits without needing fold
+	// constants for each possible LEN, rearrange this expression into
+	// C1*(x^128) + C2, where C1 = floor(A / x^(128 - 8*LEN)) and
+	// C2 = A*x^(8*LEN) + B mod x^128.  Then fold C1 into C2, which is just
+	// another fold across 128 bits.
+
+.if !LSB_CRC || AVX_LEVEL == 0
+	// Load the last 16 bytes.
+	_load_data	16, "-16(BUF,LEN)", BSWAP_MASK_XMM, %xmm1
+.endif // Else will use vpblendvb mem operand later.
+.if !LSB_CRC
+	neg		LEN	// Needed for indexing shuf_table
+.endif
+
+	// tmp = A*x^(8*LEN) mod x^128
+	// LSB CRC: pshufb by [LEN, LEN+1, ..., 15, -1, -1, ..., -1]
+	//	i.e. right-shift by LEN bytes.
+	// MSB CRC: pshufb by [-1, -1, ..., -1, 0, 1, ..., 15-LEN]
+	//	i.e. left-shift by LEN bytes.
+	_cond_vex movdqu,	"OFFSETOF_SHUF_TABLE+16(CONSTS_PTR,LEN)", %xmm3
+	_cond_vex pshufb,	%xmm3, %xmm0, %xmm2
+
+	// C1 = floor(A / x^(128 - 8*LEN))
+	// LSB CRC: pshufb by [-1, -1, ..., -1, 0, 1, ..., LEN-1]
+	//	i.e. left-shift by 16-LEN bytes.
+	// MSB CRC: pshufb by [16-LEN, 16-LEN+1, ..., 15, -1, -1, ..., -1]
+	//	i.e. right-shift by 16-LEN bytes.
+	_cond_vex pshufb,	"OFFSETOF_SHUF_TABLE+32*!LSB_CRC(CONSTS_PTR,LEN)", \
+				%xmm0, %xmm0, unaligned_mem_tmp=%xmm4
+
+	// C2 = tmp + B
+	// LSB CRC: blend 1=last16bytes,0=tmp by [LEN, LEN+1, ..., 15, -1, -1, ..., -1]
+	// MSB CRC: blend 1=last16bytes,0=tmp by [16-LEN, 16-LEN+1, ..., 15, -1, -1, ..., -1]
+.if AVX_LEVEL == 0
+	movdqa		%xmm0, %xmm4
+	movdqa		%xmm3, %xmm0
+	pblendvb	%xmm1, %xmm2	// uses %xmm0 as implicit operand
+	movdqa		%xmm4, %xmm0
+.else
+  .if LSB_CRC
+	vpblendvb	%xmm3, -16(BUF,LEN), %xmm2, %xmm2
+  .else
+	vpblendvb	%xmm3, %xmm1, %xmm2, %xmm2
+  .endif
+.endif
+
+	// Fold C1 into C2 and store the 128-bit result in xmm0.
+	_fold_vec	%xmm0, %xmm2, CONSTS_XMM, %xmm4
+
+.Lpartial_block_done\@:
+	// Compute the final CRC 'A * x^n mod G', where n=\crc_bits and A
+	// denotes the 128-bit polynomial stored in xmm0.  CONSTS_XMM contains
+	// fold_across_128_bits_consts.
+
+	// First, multiply by x^n and reduce to 64+n bits:
+	//
+	//	t0 := ((x^(64+n) mod G) * floor(A / x^64)) + (x^n * (A mod x^64))
+	//
+	// Store the resulting 64+n bit polynomial t0 in the physically low bits
+	// of xmm0 for LSB-first CRCs (with the physically high 64-n bits
+	// zeroed), or in the physically high bits of xmm0 for MSB-first CRCs
+	// (with the physically low 64-n bits zeroed).  In the MSB-first case,
+	// accomplish this by multiplying by an extra factor of x^(64-n).  This
+	// allows the next pclmulqdq to easily select floor(t0 / x^n), i.e. the
+	// high 64 terms of t0, without needing an extra shift to prepare it.
+.if LSB_CRC
+	_cond_vex "pclmulqdq $0x10,",	CONSTS_XMM, %xmm0, %xmm1
+	_cond_vex psrldq,		$8, %xmm0, %xmm0
+	_cond_vex pxor,			%xmm1, %xmm0, %xmm0
+.else
+	_cond_vex "pclmulqdq $0x01,",	CONSTS_XMM, %xmm0, %xmm1
+	_cond_vex pslldq,		$8, %xmm0, %xmm0
+	_cond_vex pxor,			%xmm1, %xmm0, %xmm0
+.endif
+
+	// Compute floor(t0 / G).  This is the polynomial by which G needs to be
+	// multiplied to cancel out the x^n and higher terms of t0.  First do:
+	//
+	//	t1 := floor(x^(m+n) / G) * floor(t0 / x^n)
+	//
+	// Then the desired value floor(t0 / G) is floor(t1 / x^m).
+	//
+	// m >= 63 is required, since floor(t0 / G) has max degree 63.  For
+	// LSB-first CRCs, use m=63.  floor(x^(m+n) / G) then has degree 63 and
+	// the multiplication is of two 64-bit values producing a 127-bit result
+	// t1 in bits 0..126 of xmm1 using LSB-first order; the physically low
+	// qword of xmm1 then contains the desired value floor(t1 / x^63).
+	//
+	// For MSB-first CRCs, use m=64.  m=63 would cause the desired value
+	// floor(t1 / x^63) to be in bits 63..126, which crosses qwords and
+	// would need several instructions to fix.  Instead, use m=64 to get
+	// this value in bits 64..127 instead.  This does mean that the
+	// multiplication becomes a 65-bit by 64-bit multiplication, which
+	// requires an extra XOR to handle multiplying by the x^64 term.
+	_cond_vex movdqa,		OFFSETOF_BARRETT_REDUCTION_CONSTS(CONSTS_PTR), CONSTS_XMM
+.if LSB_CRC
+	_cond_vex "pclmulqdq $0x00,",	CONSTS_XMM, %xmm0, %xmm1
+.else
+	_cond_vex "pclmulqdq $0x01,",	CONSTS_XMM, %xmm0, %xmm1
+	_cond_vex pxor,			%xmm0, %xmm1, %xmm1
+.endif
+
+	// Cancel out the x^n and higher terms of t0 by subtracting the needed
+	// multiple of G.  This gives the final CRC:
+	//
+	//	crc := t0 - (G * floor(t1 / x^m))
+.if LSB_CRC
+	// For LSB-first CRCs, floor(t1 / x^m) is in bits 0..63 of xmm1.
+	// Multiplying by the n+1 bit constant G produces a 64+n bit polynomial
+	// in physical bits 0..(64+n-1) of xmm1, aligned with t0 which is a 64+n
+	// bit polynomial in physical bits 0..(64+n-1) of xmm0.  XOR'ing in t0
+	// cancels out the x^n and above terms, leaving the final CRC in
+	// physical bits 64..(64+n-1), with the higher bits guaranteed be zero.
+	//
+	// When n=64, G is 65-bit and the multiplication has to be broken up
+	// into a 64-bit part and a 1-bit part.  The pclmulqdq handles
+	// multiplying by the physically low 64 bits of G which represent terms
+	// x^1 through x^64.  The multiplication by physical bit 64 of G, which
+	// represents the x^0 term and which we assume is nonzero, is handled
+	// separately using a shuffle and an XOR.
+	//
+	// Note that the x^64 term of G does not affect the result, so an
+	// alternative would be to just multiply by the x^0 through x^63 terms.
+	// But that would leave the result in bits 63..(63+n-1) which is
+	// misaligned, and several instructions would be needed to fix it up.
+  .if \crc_bits == 64
+	_cond_vex punpcklqdq,		%xmm1, %xmm1, %xmm2
+	_cond_vex "pclmulqdq $0x10,",	CONSTS_XMM, %xmm1, %xmm1
+    .if AVX_LEVEL < 10
+	_cond_vex pxor,			%xmm1, %xmm0, %xmm0
+	_cond_vex pxor,			%xmm2, %xmm0, %xmm0
+    .else
+	vpternlogq			$0x96, %xmm2, %xmm1, %xmm0
+    .endif
+  .else
+	_cond_vex "pclmulqdq $0x10,",	CONSTS_XMM, %xmm1, %xmm1
+	_cond_vex pxor,			%xmm1, %xmm0, %xmm0
+  .endif
+  .if \crc_bits <= 32
+	_cond_vex "pextrd $2,",		%xmm0, %eax
+  .else
+	_cond_vex "pextrq $1,",		%xmm0, %rax
+  .endif
+.else
+	// This is the same calculation crc := t0 - (G * floor(t1 / x^m)), but
+	// now in the MSB-first case.  In this case the result is generated in
+	// bits 0..(n-1), where bits n..63 are guaranteed to be zero.  Bit 64 of
+	// G (present when n=64) does not affect the result, so it is ignored
+	// and the multiplication is by just the x^0 through x^63 terms of G.
+	//
+	// When n < 64, a right-shift by 64-n bits is needed to move the low n
+	// terms of t0 into the proper position, considering the extra
+	// multiplication by x^(64-n) that was done earlier.
+  .if \crc_bits < 64
+	_cond_vex psrlq			$64-\crc_bits, %xmm0, %xmm0
+  .endif
+	_cond_vex "pclmulqdq $0x11,",	CONSTS_XMM, %xmm1, %xmm1
+	_cond_vex pxor,			%xmm1, %xmm0, %xmm0
+  .if \crc_bits <= 32
+	_cond_vex movd,			%xmm0, %eax
+  .else
+	_cond_vex movq,			%xmm0, %rax
+  .endif
+.endif
+
+.if VL > 16
+	vzeroupper	// Needed when ymm or zmm registers may have been used.
+.endif
+#ifdef __i386__
+	pop		CONSTS_PTR
+#endif
+	RET
+.endm
+
+#ifdef CONFIG_AS_VPCLMULQDQ
+#define DEFINE_CRC_PCLMUL_FUNCS(prefix, bits, lsb)			\
+SYM_FUNC_START(prefix##_pclmul_sse);					\
+	_crc_pclmul	crc_bits=bits, lsb_crc=lsb, vl=16, avx_level=0;	\
+SYM_FUNC_END(prefix##_pclmul_sse);					\
+									\
+SYM_FUNC_START(prefix##_vpclmul_avx2);					\
+	_crc_pclmul	crc_bits=bits, lsb_crc=lsb, vl=32, avx_level=2;	\
+SYM_FUNC_END(prefix##_vpclmul_avx2);					\
+									\
+SYM_FUNC_START(prefix##_vpclmul_avx10_256);				\
+	_crc_pclmul	crc_bits=bits, lsb_crc=lsb, vl=32, avx_level=10;\
+SYM_FUNC_END(prefix##_vpclmul_avx10_256);				\
+									\
+SYM_FUNC_START(prefix##_vpclmul_avx10_512);				\
+	_crc_pclmul	crc_bits=bits, lsb_crc=lsb, vl=64, avx_level=10;\
+SYM_FUNC_END(prefix##_vpclmul_avx10_512);
+#else
+#define DEFINE_CRC_PCLMUL_FUNCS(prefix, bits, lsb)			\
+SYM_FUNC_START(prefix##_pclmul_sse);					\
+	_crc_pclmul	crc_bits=bits, lsb_crc=lsb, vl=16, avx_level=0;	\
+SYM_FUNC_END(prefix##_pclmul_sse);
+#endif // !CONFIG_AS_VPCLMULQDQ
diff --git a/arch/x86/lib/crc-pclmul-template.h b/arch/x86/lib/crc-pclmul-template.h
new file mode 100644
index 000000000000..7b89f0edbc17
--- /dev/null
+++ b/arch/x86/lib/crc-pclmul-template.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Macros for accessing the [V]PCLMULQDQ-based CRC functions that are
+ * instantiated by crc-pclmul-template.S
+ *
+ * Copyright 2025 Google LLC
+ *
+ * Author: Eric Biggers <ebiggers@google.com>
+ */
+#ifndef _CRC_PCLMUL_TEMPLATE_H
+#define _CRC_PCLMUL_TEMPLATE_H
+
+#include <asm/cpufeatures.h>
+#include <asm/simd.h>
+#include <crypto/internal/simd.h>
+#include <linux/static_call.h>
+#include "crc-pclmul-consts.h"
+
+#define DECLARE_CRC_PCLMUL_FUNCS(prefix, crc_t)				\
+crc_t prefix##_pclmul_sse(crc_t crc, const u8 *p, size_t len,		\
+			  const void *consts_ptr);			\
+crc_t prefix##_vpclmul_avx2(crc_t crc, const u8 *p, size_t len,		\
+			    const void *consts_ptr);			\
+crc_t prefix##_vpclmul_avx10_256(crc_t crc, const u8 *p, size_t len,	\
+				 const void *consts_ptr);		\
+crc_t prefix##_vpclmul_avx10_512(crc_t crc, const u8 *p, size_t len,	\
+				 const void *consts_ptr);		\
+DEFINE_STATIC_CALL(prefix##_pclmul, prefix##_pclmul_sse)
+
+#define INIT_CRC_PCLMUL(prefix)						\
+do {									\
+	if (IS_ENABLED(CONFIG_AS_VPCLMULQDQ) &&				\
+	    boot_cpu_has(X86_FEATURE_VPCLMULQDQ) &&			\
+	    boot_cpu_has(X86_FEATURE_AVX2) &&				\
+	    cpu_has_xfeatures(XFEATURE_MASK_YMM, NULL)) {		\
+		if (boot_cpu_has(X86_FEATURE_AVX512BW) &&		\
+		    boot_cpu_has(X86_FEATURE_AVX512VL) &&		\
+		    cpu_has_xfeatures(XFEATURE_MASK_AVX512, NULL)) {	\
+			if (boot_cpu_has(X86_FEATURE_PREFER_YMM))	\
+				static_call_update(prefix##_pclmul,	\
+						   prefix##_vpclmul_avx10_256); \
+			else						\
+				static_call_update(prefix##_pclmul,	\
+						   prefix##_vpclmul_avx10_512); \
+		} else {						\
+			static_call_update(prefix##_pclmul,		\
+					   prefix##_vpclmul_avx2);	\
+		}							\
+	}								\
+} while (0)
+
+/*
+ * Call a [V]PCLMULQDQ optimized CRC function if the data length is at least 16
+ * bytes, the CPU has PCLMULQDQ support, and the current context may use SIMD.
+ *
+ * 16 bytes is the minimum length supported by the [V]PCLMULQDQ functions.
+ * There is overhead associated with kernel_fpu_begin() and kernel_fpu_end(),
+ * varying by CPU and factors such as which parts of the "FPU" state userspace
+ * has touched, which could result in a larger cutoff being better.  Indeed, a
+ * larger cutoff is usually better for a *single* message.  However, the
+ * overhead of the FPU section gets amortized if multiple FPU sections get
+ * executed before returning to userspace, since the XSAVE and XRSTOR occur only
+ * once.  Considering that and the fact that the [V]PCLMULQDQ code is lighter on
+ * the dcache than the table-based code is, a 16-byte cutoff seems to work well.
+ */
+#define CRC_PCLMUL(crc, p, len, prefix, consts, have_pclmulqdq)		\
+do {									\
+	if ((len) >= 16 && static_branch_likely(&(have_pclmulqdq)) &&	\
+	    crypto_simd_usable()) {					\
+		const void *consts_ptr;					\
+									\
+		consts_ptr = (consts).fold_across_128_bits_consts;	\
+		kernel_fpu_begin();					\
+		crc = static_call(prefix##_pclmul)((crc), (p), (len),	\
+						   consts_ptr);		\
+		kernel_fpu_end();					\
+		return crc;						\
+	}								\
+} while (0)
+
+#endif /* _CRC_PCLMUL_TEMPLATE_H */
-- 
2.48.1



Return-Path: <linux-crypto+bounces-8558-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF129EFE3F
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Dec 2024 22:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319F718895CD
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Dec 2024 21:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3221DA314;
	Thu, 12 Dec 2024 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g95eL9wy"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3581D9A63
	for <linux-crypto@vger.kernel.org>; Thu, 12 Dec 2024 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734038956; cv=none; b=B+tqI5D9mRrFCGVe9PVEcT9cT/6ShCXIFK07VkUJb6LV06wJW+UUI6DanEJv1LDGKTcpOD2KEcmVBkhwTDdlf/O2yjMVH/PHUz23uGggmMwWTdTTeGvEsiwZ4RL8qQ7uDTP115BgmquV7ZfwUd5d+NQxf2gZArZ3UcGO01+GQ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734038956; c=relaxed/simple;
	bh=y9KTABvcRIhwuqNg/VsbNreS5DFEXsz8n6JyaAlYXyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RL+Y++cLvGadStcsmsHEV+nUo0GNJGqgoeZT+/R2HmzOc1gmEp7hQmNnsezm50tbpzYmWUZfuH9SDli3sln0wzdXPfItlU/Of8ju97XeebT9D4Hyx+BnVnybYcW2kagYG28nUsKS0NYda/NOnhrbZ84Rwfz+mSEomDjvVKDTpGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g95eL9wy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9CCC4CED1;
	Thu, 12 Dec 2024 21:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734038956;
	bh=y9KTABvcRIhwuqNg/VsbNreS5DFEXsz8n6JyaAlYXyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g95eL9wyMetVbuiD6h5STAyMgsBqvScp3kgopWWmMLXlgdBow/W7RCI5TriWNEBdq
	 sasHdyA6AW0G12+tXd+s9j0k2b8ehaFcMuq6rvzyK8+TD3aDrflgwimXvqzoXiGp2n
	 uM4V5az8QlLJkI393cPkxjITTLMMC/zXYGVSSL7OMRfTQxukfGzb513NCbmzDGt82W
	 xeettV3x3G2JbnxVcbaOWijzFKx68R6gpdSjLmivVzqDJeH/g1J8alhzxHcw0dkIse
	 4K11IyDIBSV3Obx+X9NtZc9ugxeO6GtPH5q7iwmbOIiI/0CnugqJfgRPDZTpvCSy9l
	 bIiXrSNciZwOA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: x86@kernel.org
Subject: [PATCH v2 8/8] crypto: x86/aes-xts - additional optimizations
Date: Thu, 12 Dec 2024 13:28:45 -0800
Message-ID: <20241212212845.40333-9-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212212845.40333-1-ebiggers@kernel.org>
References: <20241212212845.40333-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Reduce latency by taking advantage of the property vaesenclast(key, a) ^
b == vaesenclast(key ^ b, a), like I did in the AES-GCM code.

Also replace a vpand and vpxor with a vpternlogd.

On AMD Zen 5 this improves performance by about 3%.  Intel performance
remains about the same, with a 0.1% improvement being seen on Icelake.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/aes-xts-avx-x86_64.S | 145 +++++++++++++++++----------
 1 file changed, 90 insertions(+), 55 deletions(-)

diff --git a/arch/x86/crypto/aes-xts-avx-x86_64.S b/arch/x86/crypto/aes-xts-avx-x86_64.S
index 0e6b9ae12e95..8a3e23fbcf85 100644
--- a/arch/x86/crypto/aes-xts-avx-x86_64.S
+++ b/arch/x86/crypto/aes-xts-avx-x86_64.S
@@ -233,12 +233,16 @@
 // (by multiplying by the polynomial 'x') and write it to \dst.
 .macro	_next_tweak	src, tmp, dst
 	vpshufd		$0x13, \src, \tmp
 	vpaddq		\src, \src, \dst
 	vpsrad		$31, \tmp, \tmp
+.if USE_AVX10
+	vpternlogd	$0x78, GF_POLY_XMM, \tmp, \dst
+.else
 	vpand		GF_POLY_XMM, \tmp, \tmp
 	vpxor		\tmp, \dst, \dst
+.endif
 .endm
 
 // Given the XTS tweak(s) in the vector \src, compute the next vector of
 // tweak(s) (by multiplying by the polynomial 'x^(VL/16)') and write it to \dst.
 //
@@ -452,88 +456,98 @@
 	_vbroadcast128	6*16(KEY), KEY13
 	_vbroadcast128	7*16(KEY), KEY14
 .endif
 .endm
 
-// Do a single round of AES encryption (if \enc==1) or decryption (if \enc==0)
-// on the block(s) in \data using the round key(s) in \key.  The register length
-// determines the number of AES blocks en/decrypted.
-.macro	_vaes	enc, last, key, data
+// Do a single non-last round of AES encryption (if \enc==1) or decryption (if
+// \enc==0) on the block(s) in \data using the round key(s) in \key.  The
+// register length determines the number of AES blocks en/decrypted.
+.macro	_vaes	enc, key, data
 .if \enc
-.if \last
-	vaesenclast	\key, \data, \data
-.else
 	vaesenc		\key, \data, \data
-.endif
-.else
-.if \last
-	vaesdeclast	\key, \data, \data
 .else
 	vaesdec		\key, \data, \data
 .endif
+.endm
+
+// Same as _vaes, but does the last round.
+.macro	_vaeslast	enc, key, data
+.if \enc
+	vaesenclast	\key, \data, \data
+.else
+	vaesdeclast	\key, \data, \data
 .endif
 .endm
 
-// Do a single round of AES en/decryption on the block(s) in \data, using the
-// same key for all block(s).  The round key is loaded from the appropriate
-// register or memory location for round \i.  May clobber V4.
-.macro _vaes_1x		enc, last, i, xmm_suffix, data
+// Do a single non-last round of AES en/decryption on the block(s) in \data,
+// using the same key for all block(s).  The round key is loaded from the
+// appropriate register or memory location for round \i.  May clobber \tmp.
+.macro _vaes_1x		enc, i, xmm_suffix, data, tmp
 .if USE_AVX10
-	_vaes		\enc, \last, KEY\i\xmm_suffix, \data
+	_vaes		\enc, KEY\i\xmm_suffix, \data
 .else
 .ifnb \xmm_suffix
-	_vaes		\enc, \last, (\i-7)*16(KEY), \data
+	_vaes		\enc, (\i-7)*16(KEY), \data
 .else
-	_vbroadcast128	(\i-7)*16(KEY), V4
-	_vaes		\enc, \last, V4, \data
+	_vbroadcast128	(\i-7)*16(KEY), \tmp
+	_vaes		\enc, \tmp, \data
 .endif
 .endif
 .endm
 
-// Do a single round of AES en/decryption on the blocks in registers V0-V3,
-// using the same key for all blocks.  The round key is loaded from the
+// Do a single non-last round of AES en/decryption on the blocks in registers
+// V0-V3, using the same key for all blocks.  The round key is loaded from the
 // appropriate register or memory location for round \i.  In addition, does two
 // steps of the computation of the next set of tweaks.  May clobber V4 and V5.
-.macro	_vaes_4x	enc, last, i
+.macro	_vaes_4x	enc, i
 .if USE_AVX10
 	_tweak_step	(2*(\i-5))
-	_vaes		\enc, \last, KEY\i, V0
-	_vaes		\enc, \last, KEY\i, V1
+	_vaes		\enc, KEY\i, V0
+	_vaes		\enc, KEY\i, V1
 	_tweak_step	(2*(\i-5) + 1)
-	_vaes		\enc, \last, KEY\i, V2
-	_vaes		\enc, \last, KEY\i, V3
+	_vaes		\enc, KEY\i, V2
+	_vaes		\enc, KEY\i, V3
 .else
 	_vbroadcast128	(\i-7)*16(KEY), V4
 	_tweak_step	(2*(\i-5))
-	_vaes		\enc, \last, V4, V0
-	_vaes		\enc, \last, V4, V1
+	_vaes		\enc, V4, V0
+	_vaes		\enc, V4, V1
 	_tweak_step	(2*(\i-5) + 1)
-	_vaes		\enc, \last, V4, V2
-	_vaes		\enc, \last, V4, V3
+	_vaes		\enc, V4, V2
+	_vaes		\enc, V4, V3
 .endif
 .endm
 
 // Do tweaked AES en/decryption (i.e., XOR with \tweak, then AES en/decrypt,
 // then XOR with \tweak again) of the block(s) in \data.  To process a single
 // block, use xmm registers and set \xmm_suffix=_XMM.  To process a vector of
-// length VL, use V* registers and leave \xmm_suffix empty.  May clobber V4.
-.macro	_aes_crypt	enc, xmm_suffix, tweak, data
+// length VL, use V* registers and leave \xmm_suffix empty.  Clobbers \tmp.
+.macro	_aes_crypt	enc, xmm_suffix, tweak, data, tmp
 	_xor3		KEY0\xmm_suffix, \tweak, \data
 	cmp		$24, KEYLEN
 	jl		.Laes128\@
 	je		.Laes192\@
-	_vaes_1x	\enc, 0, 1, \xmm_suffix, \data
-	_vaes_1x	\enc, 0, 2, \xmm_suffix, \data
+	_vaes_1x	\enc, 1, \xmm_suffix, \data, tmp=\tmp
+	_vaes_1x	\enc, 2, \xmm_suffix, \data, tmp=\tmp
 .Laes192\@:
-	_vaes_1x	\enc, 0, 3, \xmm_suffix, \data
-	_vaes_1x	\enc, 0, 4, \xmm_suffix, \data
+	_vaes_1x	\enc, 3, \xmm_suffix, \data, tmp=\tmp
+	_vaes_1x	\enc, 4, \xmm_suffix, \data, tmp=\tmp
 .Laes128\@:
 .irp i, 5,6,7,8,9,10,11,12,13
-	_vaes_1x	\enc, 0, \i, \xmm_suffix, \data
+	_vaes_1x	\enc, \i, \xmm_suffix, \data, tmp=\tmp
 .endr
-	_vaes_1x	\enc, 1, 14, \xmm_suffix, \data
-	_vpxor		\tweak, \data, \data
+.if USE_AVX10
+	vpxord		KEY14\xmm_suffix, \tweak, \tmp
+.else
+.ifnb \xmm_suffix
+	vpxor		7*16(KEY), \tweak, \tmp
+.else
+	_vbroadcast128	7*16(KEY), \tmp
+	vpxor		\tweak, \tmp, \tmp
+.endif
+.endif
+	_vaeslast	\enc, \tmp, \data
 .endm
 
 .macro	_aes_xts_crypt	enc
 	_define_aliases
 
@@ -586,26 +600,47 @@
 	cmp		$24, KEYLEN
 	jl		.Laes128\@
 	je		.Laes192\@
 	// Do all the AES rounds on the data blocks, interleaved with
 	// the computation of the next set of tweaks.
-	_vaes_4x	\enc, 0, 1
-	_vaes_4x	\enc, 0, 2
+	_vaes_4x	\enc, 1
+	_vaes_4x	\enc, 2
 .Laes192\@:
-	_vaes_4x	\enc, 0, 3
-	_vaes_4x	\enc, 0, 4
+	_vaes_4x	\enc, 3
+	_vaes_4x	\enc, 4
 .Laes128\@:
 .irp i, 5,6,7,8,9,10,11,12,13
-	_vaes_4x	\enc, 0, \i
+	_vaes_4x	\enc, \i
 .endr
-	_vaes_4x	\enc, 1, 14
-
-	// XOR in the tweaks again.
-	_vpxor		TWEAK0, V0, V0
-	_vpxor		TWEAK1, V1, V1
-	_vpxor		TWEAK2, V2, V2
-	_vpxor		TWEAK3, V3, V3
+	// Do the last AES round, then XOR the results with the tweaks again.
+	// Reduce latency by doing the XOR before the vaesenclast, utilizing the
+	// property vaesenclast(key, a) ^ b == vaesenclast(key ^ b, a)
+	// (and likewise for vaesdeclast).
+.if USE_AVX10
+	_tweak_step	18
+	_tweak_step	19
+	vpxord		TWEAK0, KEY14, V4
+	vpxord		TWEAK1, KEY14, V5
+	_vaeslast	\enc, V4, V0
+	_vaeslast	\enc, V5, V1
+	vpxord		TWEAK2, KEY14, V4
+	vpxord		TWEAK3, KEY14, V5
+	_vaeslast	\enc, V4, V2
+	_vaeslast	\enc, V5, V3
+.else
+	_vbroadcast128	7*16(KEY), V4
+	_tweak_step	18 // uses V5
+	_tweak_step	19 // uses V5
+	vpxor		TWEAK0, V4, V5
+	_vaeslast	\enc, V5, V0
+	vpxor		TWEAK1, V4, V5
+	_vaeslast	\enc, V5, V1
+	vpxor		TWEAK2, V4, V5
+	vpxor		TWEAK3, V4, V4
+	_vaeslast	\enc, V5, V2
+	_vaeslast	\enc, V4, V3
+.endif
 
 	// Store the destination blocks.
 	_vmovdqu	V0, 0*VL(DST)
 	_vmovdqu	V1, 1*VL(DST)
 	_vmovdqu	V2, 2*VL(DST)
@@ -638,11 +673,11 @@
 .if VL > 16
 	add		$3*VL, LEN	// Undo extra sub of 4*VL, then sub VL.
 	jl		.Lvec_at_a_time_done\@
 .Lvec_at_a_time\@:
 	_vmovdqu	(SRC), V0
-	_aes_crypt	\enc, , TWEAK0, V0
+	_aes_crypt	\enc, , TWEAK0, V0, tmp=V1
 	_vmovdqu	V0, (DST)
 	_next_tweakvec	TWEAK0, V0, V1, TWEAK0
 	add		$VL, SRC
 	add		$VL, DST
 	sub		$VL, LEN
@@ -655,11 +690,11 @@
 
 	// En/decrypt any remaining full blocks, one at a time.
 	jl		.Lblock_at_a_time_done\@
 .Lblock_at_a_time\@:
 	vmovdqu		(SRC), %xmm0
-	_aes_crypt	\enc, _XMM, TWEAK0_XMM, %xmm0
+	_aes_crypt	\enc, _XMM, TWEAK0_XMM, %xmm0, tmp=%xmm1
 	vmovdqu		%xmm0, (DST)
 	_next_tweak	TWEAK0_XMM, %xmm0, TWEAK0_XMM
 	add		$16, SRC
 	add		$16, DST
 	sub		$16, LEN
@@ -683,11 +718,11 @@
 	// If decrypting, the main loop didn't decrypt the last full block
 	// because CTS decryption uses the last two tweaks in reverse order.
 	// Do it now by advancing the tweak and decrypting the last full block.
 	_next_tweak	TWEAK0_XMM, %xmm0, TWEAK1_XMM
 	vmovdqu		(SRC), %xmm0
-	_aes_crypt	\enc, _XMM, TWEAK1_XMM, %xmm0
+	_aes_crypt	\enc, _XMM, TWEAK1_XMM, %xmm0, tmp=%xmm1
 .endif
 
 .if USE_AVX10
 	// Create a mask that has the first LEN bits set.
 	mov		$-1, %r9d
@@ -726,11 +761,11 @@
 	// Do a blend to generate the src partial block followed by the second
 	// part of the en/decryption of the last full block.
 	vpblendvb	%xmm3, %xmm0, %xmm1, %xmm0
 .endif
 	// En/decrypt again and store the last full block.
-	_aes_crypt	\enc, _XMM, TWEAK0_XMM, %xmm0
+	_aes_crypt	\enc, _XMM, TWEAK0_XMM, %xmm0, tmp=%xmm1
 	vmovdqu		%xmm0, (DST)
 	jmp		.Ldone\@
 .endm
 
 // void aes_xts_encrypt_iv(const struct crypto_aes_ctx *tweak_key,
-- 
2.47.1



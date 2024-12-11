Return-Path: <linux-crypto+bounces-8513-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131409EBFB2
	for <lists+linux-crypto@lfdr.de>; Wed, 11 Dec 2024 00:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD17F282243
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Dec 2024 23:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B8D22C375;
	Tue, 10 Dec 2024 23:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6322i7K"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97EA22C36C
	for <linux-crypto@vger.kernel.org>; Tue, 10 Dec 2024 23:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733875149; cv=none; b=QcjnFgCUD/GULMZsWdG5FCJ3uG786qLbrz/chn72xnyi0S1PgaUTImryZsILaXP6pMM2Vy5Foc6vYMHENmZoqPe93N2ASPoYcXALj/uvHHn1qTLwL/HYmFPGh2M5flN9jDM7rNBlbtg/rEldwnmneJood4W0hu68k1n/qDFbOyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733875149; c=relaxed/simple;
	bh=S/biDWYIFiHYqfH4/5v3xSMcwvn7HD829lF2LjnG+wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEUoSk6n6S04JUCwhYWbCYRchyP6fMyviHaNmfZIl+PNVOtOiyiunIQfQaZ3lRBAJDzDMAnqY96rE4YbRGsWFm6F9rAQw+j+fLF4G817Y/Pxl82g61FQ5+VMYJht9F6yt011kVEcc/cUZkt8JPHFSIb6ZVljcCOD7yFeFBEPwKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6322i7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601E3C4CEE2;
	Tue, 10 Dec 2024 23:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733875149;
	bh=S/biDWYIFiHYqfH4/5v3xSMcwvn7HD829lF2LjnG+wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I6322i7K7pxrU9sRtfeqX2w2WWc/fHg9dFdkB+InFiwkUtIR3nKE7XwvP/5gLtzFQ
	 xU0Pr3JQd9w1022mTdh4R1SVv4tGItLbesfJI2X6+hqiXxvSQv5HJQA0wzeUm5Z2LJ
	 cly4bqMFAr3lQXoUwBcMuyG8SfWNc7EVPgjt1JR1NBhxtkXfzmqLUREl+F7q35qjxi
	 Tn8Mffyz2/BiZJsTJXdKh+PK5JEKimx/ZkrpQ31d85rtX2FrWPdVwB/txWOncao33y
	 jSiJRC+vRCy7nHYAN5KZ4hdXypDX66+GHLAuuDnXWAI/lIM1OVLRaT3hrA7R57LThQ
	 TQPIvxwcE0b6A==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: x86@kernel.org
Subject: [PATCH 2/7] crypto: x86/aes-gcm - tune better for AMD CPUs
Date: Tue, 10 Dec 2024 15:58:29 -0800
Message-ID: <20241210235834.40862-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210235834.40862-1-ebiggers@kernel.org>
References: <20241210235834.40862-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Reorganize the main loop to free up the RNDKEYLAST[0-3] registers and
use them for more cached round keys.  This improves performance by about
2% on AMD Zen 4 and Zen 5.  Intel performance remains about the same.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/aes-gcm-avx10-x86_64.S | 99 ++++++++++----------------
 1 file changed, 38 insertions(+), 61 deletions(-)

diff --git a/arch/x86/crypto/aes-gcm-avx10-x86_64.S b/arch/x86/crypto/aes-gcm-avx10-x86_64.S
index 8989bf9b8384d..02ee11083d4f8 100644
--- a/arch/x86/crypto/aes-gcm-avx10-x86_64.S
+++ b/arch/x86/crypto/aes-gcm-avx10-x86_64.S
@@ -86,11 +86,11 @@
 .section .rodata
 .p2align 6
 
 	// A shuffle mask that reflects the bytes of 16-byte blocks
 .Lbswap_mask:
-	.octa   0x000102030405060708090a0b0c0d0e0f
+	.octa	0x000102030405060708090a0b0c0d0e0f
 
 	// This is the GHASH reducing polynomial without its constant term, i.e.
 	// x^128 + x^7 + x^2 + x, represented using the backwards mapping
 	// between bits and polynomial coefficients.
 	//
@@ -560,10 +560,36 @@
 	vpxord		RNDKEY0, V1, V1
 	vpxord		RNDKEY0, V2, V2
 	vpxord		RNDKEY0, V3, V3
 .endm
 
+// Do the last AES round for four vectors of counter blocks V0-V3, XOR source
+// data with the resulting keystream, and write the result to DST and
+// GHASHDATA[0-3].  (Implementation differs slightly, but has the same effect.)
+.macro	_aesenclast_and_xor_4x
+	// XOR the source data with the last round key, saving the result in
+	// GHASHDATA[0-3].  This reduces latency by taking advantage of the
+	// property vaesenclast(key, a) ^ b == vaesenclast(key ^ b, a).
+	vpxord		0*VL(SRC), RNDKEYLAST, GHASHDATA0
+	vpxord		1*VL(SRC), RNDKEYLAST, GHASHDATA1
+	vpxord		2*VL(SRC), RNDKEYLAST, GHASHDATA2
+	vpxord		3*VL(SRC), RNDKEYLAST, GHASHDATA3
+
+	// Do the last AES round.  This handles the XOR with the source data
+	// too, as per the optimization described above.
+	vaesenclast	GHASHDATA0, V0, GHASHDATA0
+	vaesenclast	GHASHDATA1, V1, GHASHDATA1
+	vaesenclast	GHASHDATA2, V2, GHASHDATA2
+	vaesenclast	GHASHDATA3, V3, GHASHDATA3
+
+	// Store the en/decrypted data to DST.
+	vmovdqu8	GHASHDATA0, 0*VL(DST)
+	vmovdqu8	GHASHDATA1, 1*VL(DST)
+	vmovdqu8	GHASHDATA2, 2*VL(DST)
+	vmovdqu8	GHASHDATA3, 3*VL(DST)
+.endm
+
 // void aes_gcm_{enc,dec}_update_##suffix(const struct aes_gcm_key_avx10 *key,
 //					  const u32 le_ctr[4], u8 ghash_acc[16],
 //					  const u8 *src, u8 *dst, int datalen);
 //
 // This macro generates a GCM encryption or decryption update function with the
@@ -638,29 +664,24 @@
 	.set	LE_CTR_INC,	V11
 
 	// LE_CTR contains the next set of little-endian counter blocks.
 	.set	LE_CTR,		V12
 
-	// RNDKEY0, RNDKEYLAST, and RNDKEY_M[9-5] contain cached AES round keys,
+	// RNDKEY0, RNDKEYLAST, and RNDKEY_M[9-1] contain cached AES round keys,
 	// copied to all 128-bit lanes.  RNDKEY0 is the zero-th round key,
 	// RNDKEYLAST the last, and RNDKEY_M\i the one \i-th from the last.
 	.set	RNDKEY0,	V13
 	.set	RNDKEYLAST,	V14
 	.set	RNDKEY_M9,	V15
 	.set	RNDKEY_M8,	V16
 	.set	RNDKEY_M7,	V17
 	.set	RNDKEY_M6,	V18
 	.set	RNDKEY_M5,	V19
-
-	// RNDKEYLAST[0-3] temporarily store the last AES round key XOR'd with
-	// the corresponding block of source data.  This is useful because
-	// vaesenclast(key, a) ^ b == vaesenclast(key ^ b, a), and key ^ b can
-	// be computed in parallel with the AES rounds.
-	.set	RNDKEYLAST0,	V20
-	.set	RNDKEYLAST1,	V21
-	.set	RNDKEYLAST2,	V22
-	.set	RNDKEYLAST3,	V23
+	.set	RNDKEY_M4,	V20
+	.set	RNDKEY_M3,	V21
+	.set	RNDKEY_M2,	V22
+	.set	RNDKEY_M1,	V23
 
 	// GHASHTMP[0-2] are temporary variables used by _ghash_step_4x.  These
 	// cannot coincide with anything used for AES encryption, since for
 	// performance reasons GHASH and AES encryption are interleaved.
 	.set	GHASHTMP0,	V24
@@ -746,30 +767,19 @@
 	vbroadcasti32x4	(%rax), RNDKEY
 	_vaesenc_4x	RNDKEY
 	add		$16, %rax
 	cmp		%rax, RNDKEYLAST_PTR
 	jne		1b
-	vpxord		0*VL(SRC), RNDKEYLAST, RNDKEYLAST0
-	vpxord		1*VL(SRC), RNDKEYLAST, RNDKEYLAST1
-	vpxord		2*VL(SRC), RNDKEYLAST, RNDKEYLAST2
-	vpxord		3*VL(SRC), RNDKEYLAST, RNDKEYLAST3
-	vaesenclast	RNDKEYLAST0, V0, GHASHDATA0
-	vaesenclast	RNDKEYLAST1, V1, GHASHDATA1
-	vaesenclast	RNDKEYLAST2, V2, GHASHDATA2
-	vaesenclast	RNDKEYLAST3, V3, GHASHDATA3
-	vmovdqu8	GHASHDATA0, 0*VL(DST)
-	vmovdqu8	GHASHDATA1, 1*VL(DST)
-	vmovdqu8	GHASHDATA2, 2*VL(DST)
-	vmovdqu8	GHASHDATA3, 3*VL(DST)
+	_aesenclast_and_xor_4x
 	sub		$-4*VL, SRC  // shorter than 'add 4*VL' when VL=32
 	sub		$-4*VL, DST
 	add		$-4*VL, DATALEN
 	jl		.Lghash_last_ciphertext_4x\@
 .endif
 
 	// Cache as many additional AES round keys as possible.
-.irp i, 9,8,7,6,5
+.irp i, 9,8,7,6,5,4,3,2,1
 	vbroadcasti32x4	-\i*16(RNDKEYLAST_PTR), RNDKEY_M\i
 .endr
 
 .Lcrypt_loop_4x\@:
 
@@ -797,51 +807,18 @@
 	_vaesenc_4x	RNDKEY
 	vbroadcasti32x4	-10*16(RNDKEYLAST_PTR), RNDKEY
 	_vaesenc_4x	RNDKEY
 128:
 
-	// XOR the source data with the last round key, saving the result in
-	// RNDKEYLAST[0-3].  This reduces latency by taking advantage of the
-	// property vaesenclast(key, a) ^ b == vaesenclast(key ^ b, a).
-.if \enc
-	vpxord		0*VL(SRC), RNDKEYLAST, RNDKEYLAST0
-	vpxord		1*VL(SRC), RNDKEYLAST, RNDKEYLAST1
-	vpxord		2*VL(SRC), RNDKEYLAST, RNDKEYLAST2
-	vpxord		3*VL(SRC), RNDKEYLAST, RNDKEYLAST3
-.else
-	vpxord		GHASHDATA0, RNDKEYLAST, RNDKEYLAST0
-	vpxord		GHASHDATA1, RNDKEYLAST, RNDKEYLAST1
-	vpxord		GHASHDATA2, RNDKEYLAST, RNDKEYLAST2
-	vpxord		GHASHDATA3, RNDKEYLAST, RNDKEYLAST3
-.endif
-
 	// Finish the AES encryption of the counter blocks in V0-V3, interleaved
 	// with the GHASH update of the ciphertext blocks in GHASHDATA[0-3].
-.irp i, 9,8,7,6,5
+.irp i, 9,8,7,6,5,4,3,2,1
+	_ghash_step_4x  (9 - \i)
 	_vaesenc_4x	RNDKEY_M\i
-	_ghash_step_4x	(9 - \i)
-.endr
-.irp i, 4,3,2,1
-	vbroadcasti32x4	-\i*16(RNDKEYLAST_PTR), RNDKEY
-	_vaesenc_4x	RNDKEY
-	_ghash_step_4x	(9 - \i)
 .endr
 	_ghash_step_4x	9
-
-	// Do the last AES round.  This handles the XOR with the source data
-	// too, as per the optimization described above.
-	vaesenclast	RNDKEYLAST0, V0, GHASHDATA0
-	vaesenclast	RNDKEYLAST1, V1, GHASHDATA1
-	vaesenclast	RNDKEYLAST2, V2, GHASHDATA2
-	vaesenclast	RNDKEYLAST3, V3, GHASHDATA3
-
-	// Store the en/decrypted data to DST.
-	vmovdqu8	GHASHDATA0, 0*VL(DST)
-	vmovdqu8	GHASHDATA1, 1*VL(DST)
-	vmovdqu8	GHASHDATA2, 2*VL(DST)
-	vmovdqu8	GHASHDATA3, 3*VL(DST)
-
+	_aesenclast_and_xor_4x
 	sub		$-4*VL, SRC  // shorter than 'add 4*VL' when VL=32
 	sub		$-4*VL, DST
 	add		$-4*VL, DATALEN
 	jge		.Lcrypt_loop_4x\@
 
@@ -938,11 +915,11 @@
 	// be whole block(s) that get processed by the GHASH multiplication and
 	// reduction instructions but should not actually be included in the
 	// GHASH.  However, any such blocks are all-zeroes, and the values that
 	// they're multiplied with are also all-zeroes.  Therefore they just add
 	// 0 * 0 = 0 to the final GHASH result, which makes no difference.
-	vmovdqu8        (POWERS_PTR), H_POW1
+	vmovdqu8	(POWERS_PTR), H_POW1
 .if \enc
 	vmovdqu8	V0, V1{%k1}{z}
 .endif
 	vpshufb		BSWAP_MASK, V1, V0
 	vpxord		GHASH_ACC, V0, V0
-- 
2.47.1



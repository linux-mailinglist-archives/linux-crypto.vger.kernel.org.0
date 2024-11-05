Return-Path: <linux-crypto+bounces-7912-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB219BD1FB
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Nov 2024 17:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B8D1C2222F
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Nov 2024 16:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B4B178389;
	Tue,  5 Nov 2024 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MPFOF4Pq"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A6D225D7
	for <linux-crypto@vger.kernel.org>; Tue,  5 Nov 2024 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730823258; cv=none; b=EZSE8jmS8/+6g0/pNHSmTD8x4s7xN7t/43063grGos4sfMWsbCa97tJ3ptdZ4NIXr+e5K9QMd9IpJYljNAeko7TBagpURt41pBnXQrQcAtcsbTk7eo/2GhsUC6sk92oCFe4/j9SZx+SIm8qfMbl5D6u5CRn/AIx4QTchHKB2UoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730823258; c=relaxed/simple;
	bh=v+j90m5cy+enPV3M78ov1r+R9+AirjCVlh6dK5rnFyQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kdPMVRan2S3ezMzXM2ES2nl0yZTKCU0CMpybws7CVd+FlX9g8IcweeqJ3zyEu4M6H/0GtZWUNwJVzB2DOGwo3iesKz865TNaunZ+FMyAEZP3pY8DA7kRm3TF30XzYOKyKTxGB2iTHsxz85RbhoekqCIU1BsNo6Xq4kVxM2qN+mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MPFOF4Pq; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-37d4922d8c7so3028160f8f.1
        for <linux-crypto@vger.kernel.org>; Tue, 05 Nov 2024 08:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730823255; x=1731428055; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fn14AhmQ6OQTZ360sXt8YVpA23nVVdhA37ni/ACtb1c=;
        b=MPFOF4Pql8EkXloQtV/4Q2hJbEENkuZ3086wuTlVTNkdy+VCz36JGOiYqoHijCmRAu
         /jAi2v73s66qsCgvaC5AQ/JRea/uzcaWLNoCwreSmaV2AnWGUvKErGe2HUBsNTlSlG8d
         LdxpVcgpNwje+DFyR30u3jzwshLpYBPxz6DFmQbT5RHuMZpRIcmKwT3zPKbGE4jRW2cc
         aBJ1sZoE0DqfjBYVJ8l8xu/L07qdlcwnGzmfFDArrEJVaNUtU1ZzICRwBVZwQH3APHGC
         1/oMxMjsrhy5beEoRrUYtEFIXhQvAmEbrykMvpibegAiIJ51mm+Gk2AcUMx5lfOGp81a
         JvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730823255; x=1731428055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fn14AhmQ6OQTZ360sXt8YVpA23nVVdhA37ni/ACtb1c=;
        b=CRzwGkDOo0QvtwXFzfIU40DCSqoEpzy4j+KVtANqGIvKMqKTDy//KMC9h8xpV2Q4U8
         0FXKUEeTj69jA7pQWtTEzg3YTvO80ri0BZLdBVLPKbRTpjtOhYnE47EUxuRH66MBVtw6
         490HyA2bZwe8mKyPZ/t6wyrLGG9xPfsaIeH4HSNH7eu2j+f1PXxHnL1QKbrsehBwiTsQ
         TA9w/SCAL4PCWIuuxGHvUoZFTMnQ0fQ2gnjk6Bp14nfeluRuTZvIii3gsIOTIP1XYZmK
         adNmKHIbeW42rExUq9T7l50kzZpuRwH4qpQvyvDyuOgAzbSO2dTOFi0K8qN37rFPYUFA
         XG4g==
X-Gm-Message-State: AOJu0YyPU6HoG9SKExAEbWTYvvxMcatx5k8Kdw8mtyGyOU4zvfScDTet
	G5WPji77RJv6R9w/ECLiStLLN4R/L/jFZ54KMpYw6t0DPMRohfYfzk+KkgazMmukxwnAtQRfnR3
	ZhbMOeLktN8Df8sAJnvOrrIYwdWk1xbQDFgukcUuRBieK4zaAUTjRY2CAoZKb/lp3DFHG9iP8ew
	/+fM1DXTMeTLU/IS3qZBr+B0jjyf4SAA==
X-Google-Smtp-Source: AGHT+IEwdf0ONVUK6Zt2kw6p8pObMWZdsJrlr5Jei3x3dBdcZfmS1Juvb/jLGZBpeNe9JIrh5xFQoNLb
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a5d:410a:0:b0:37d:4e56:9a42 with SMTP id
 ffacd0b85a97d-381c7a4ee79mr8427f8f.4.1730823254102; Tue, 05 Nov 2024 08:14:14
 -0800 (PST)
Date: Tue,  5 Nov 2024 17:09:03 +0100
In-Reply-To: <20241105160859.1459261-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105160859.1459261-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=11659; i=ardb@kernel.org;
 h=from:subject; bh=5s52W2sO5L/bY0ndSW3KvGbMMMwPHHx3dy2G4v15k4A=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIV3LWeHf38Yk9imzlE/cvnU4alpjxScXke0SR27NuSg9w
 UL10VnljlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCR/+oM/+Njc20kouKjPSe9
 mnPy9hWFNucN3z0fZjBu1FHOyJ/dmc7wP6/ibeDuzkVrQ2c7/DsjfUHofUNx1vQHuYbTfnjYKoc LcwMA
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105160859.1459261-11-ardb+git@google.com>
Subject: [PATCH v2 3/6] crypto: arm64/crct10dif - Remove remaining 64x64 PMULL
 fallback code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-crypto@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, ebiggers@kernel.org, 
	herbert@gondor.apana.org.au, keescook@chromium.org, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The only remaining user of the fallback implementation of 64x64
polynomial multiplication using 8x8 PMULL instructions is the final
reduction from a 16 byte vector to a 16-bit CRC.

The fallback code is complicated and messy, and this reduction has
little impact on the overall performance, so instead, let's calculate
the final CRC by passing the 16 byte vector to the generic CRC-T10DIF
implementation when running the fallback version.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/crypto/crct10dif-ce-core.S | 244 +++++---------------
 arch/arm64/crypto/crct10dif-ce-glue.c |  18 +-
 2 files changed, 68 insertions(+), 194 deletions(-)

diff --git a/arch/arm64/crypto/crct10dif-ce-core.S b/arch/arm64/crypto/crct10dif-ce-core.S
index d2acaa2b5a01..87dd6d46224d 100644
--- a/arch/arm64/crypto/crct10dif-ce-core.S
+++ b/arch/arm64/crypto/crct10dif-ce-core.S
@@ -74,137 +74,18 @@
 	init_crc	.req	w0
 	buf		.req	x1
 	len		.req	x2
-	fold_consts_ptr	.req	x3
+	fold_consts_ptr	.req	x5
 
 	fold_consts	.req	v10
 
-	ad		.req	v14
-
-	k00_16		.req	v15
-	k32_48		.req	v16
-
 	t3		.req	v17
 	t4		.req	v18
 	t5		.req	v19
 	t6		.req	v20
 	t7		.req	v21
 	t8		.req	v22
-	t9		.req	v23
-
-	perm1		.req	v24
-	perm2		.req	v25
-	perm3		.req	v26
-	perm4		.req	v27
-
-	bd1		.req	v28
-	bd2		.req	v29
-	bd3		.req	v30
-	bd4		.req	v31
-
-	.macro		__pmull_init_p64
-	.endm
 
-	.macro		__pmull_pre_p64, bd
-	.endm
-
-	.macro		__pmull_init_p8
-	// k00_16 := 0x0000000000000000_000000000000ffff
-	// k32_48 := 0x00000000ffffffff_0000ffffffffffff
-	movi		k32_48.2d, #0xffffffff
-	mov		k32_48.h[2], k32_48.h[0]
-	ushr		k00_16.2d, k32_48.2d, #32
-
-	// prepare the permutation vectors
-	mov_q		x5, 0x080f0e0d0c0b0a09
-	movi		perm4.8b, #8
-	dup		perm1.2d, x5
-	eor		perm1.16b, perm1.16b, perm4.16b
-	ushr		perm2.2d, perm1.2d, #8
-	ushr		perm3.2d, perm1.2d, #16
-	ushr		perm4.2d, perm1.2d, #24
-	sli		perm2.2d, perm1.2d, #56
-	sli		perm3.2d, perm1.2d, #48
-	sli		perm4.2d, perm1.2d, #40
-
-	// Compose { 0,0,0,0, 8,8,8,8, 1,1,1,1, 9,9,9,9 }
-	movi		bd1.4h, #8, lsl #8
-	orr		bd1.2s, #1, lsl #16
-	orr		bd1.2s, #1, lsl #24
-	zip1		bd1.16b, bd1.16b, bd1.16b
-	zip1		bd1.16b, bd1.16b, bd1.16b
-	.endm
-
-	.macro		__pmull_pre_p8, bd
-	tbl		bd1.16b, {\bd\().16b}, perm1.16b
-	tbl		bd2.16b, {\bd\().16b}, perm2.16b
-	tbl		bd3.16b, {\bd\().16b}, perm3.16b
-	tbl		bd4.16b, {\bd\().16b}, perm4.16b
-	.endm
-
-SYM_FUNC_START_LOCAL(__pmull_p8_core)
-.L__pmull_p8_core:
-	ext		t4.8b, ad.8b, ad.8b, #1			// A1
-	ext		t5.8b, ad.8b, ad.8b, #2			// A2
-	ext		t6.8b, ad.8b, ad.8b, #3			// A3
-
-	pmull		t4.8h, t4.8b, fold_consts.8b		// F = A1*B
-	pmull		t8.8h, ad.8b, bd1.8b			// E = A*B1
-	pmull		t5.8h, t5.8b, fold_consts.8b		// H = A2*B
-	pmull		t7.8h, ad.8b, bd2.8b			// G = A*B2
-	pmull		t6.8h, t6.8b, fold_consts.8b		// J = A3*B
-	pmull		t9.8h, ad.8b, bd3.8b			// I = A*B3
-	pmull		t3.8h, ad.8b, bd4.8b			// K = A*B4
-	b		0f
-
-.L__pmull_p8_core2:
-	tbl		t4.16b, {ad.16b}, perm1.16b		// A1
-	tbl		t5.16b, {ad.16b}, perm2.16b		// A2
-	tbl		t6.16b, {ad.16b}, perm3.16b		// A3
-
-	pmull2		t4.8h, t4.16b, fold_consts.16b		// F = A1*B
-	pmull2		t8.8h, ad.16b, bd1.16b			// E = A*B1
-	pmull2		t5.8h, t5.16b, fold_consts.16b		// H = A2*B
-	pmull2		t7.8h, ad.16b, bd2.16b			// G = A*B2
-	pmull2		t6.8h, t6.16b, fold_consts.16b		// J = A3*B
-	pmull2		t9.8h, ad.16b, bd3.16b			// I = A*B3
-	pmull2		t3.8h, ad.16b, bd4.16b			// K = A*B4
-
-0:	eor		t4.16b, t4.16b, t8.16b			// L = E + F
-	eor		t5.16b, t5.16b, t7.16b			// M = G + H
-	eor		t6.16b, t6.16b, t9.16b			// N = I + J
-
-	uzp1		t8.2d, t4.2d, t5.2d
-	uzp2		t4.2d, t4.2d, t5.2d
-	uzp1		t7.2d, t6.2d, t3.2d
-	uzp2		t6.2d, t6.2d, t3.2d
-
-	// t4 = (L) (P0 + P1) << 8
-	// t5 = (M) (P2 + P3) << 16
-	eor		t8.16b, t8.16b, t4.16b
-	and		t4.16b, t4.16b, k32_48.16b
-
-	// t6 = (N) (P4 + P5) << 24
-	// t7 = (K) (P6 + P7) << 32
-	eor		t7.16b, t7.16b, t6.16b
-	and		t6.16b, t6.16b, k00_16.16b
-
-	eor		t8.16b, t8.16b, t4.16b
-	eor		t7.16b, t7.16b, t6.16b
-
-	zip2		t5.2d, t8.2d, t4.2d
-	zip1		t4.2d, t8.2d, t4.2d
-	zip2		t3.2d, t7.2d, t6.2d
-	zip1		t6.2d, t7.2d, t6.2d
-
-	ext		t4.16b, t4.16b, t4.16b, #15
-	ext		t5.16b, t5.16b, t5.16b, #14
-	ext		t6.16b, t6.16b, t6.16b, #13
-	ext		t3.16b, t3.16b, t3.16b, #12
-
-	eor		t4.16b, t4.16b, t5.16b
-	eor		t6.16b, t6.16b, t3.16b
-	ret
-SYM_FUNC_END(__pmull_p8_core)
+	perm		.req	v27
 
 	.macro		pmull16x64_p64, a16, b64, c64
 	pmull2		\c64\().1q, \a16\().2d, \b64\().2d
@@ -266,7 +147,7 @@ SYM_FUNC_END(__pmull_p8_core)
 	 */
 	.macro		pmull16x64_p8, a16, b64, c64
 	ext		t7.16b, \b64\().16b, \b64\().16b, #1
-	tbl		t5.16b, {\a16\().16b}, bd1.16b
+	tbl		t5.16b, {\a16\().16b}, perm.16b
 	uzp1		t7.16b, \b64\().16b, t7.16b
 	bl		__pmull_p8_16x64
 	ext		\b64\().16b, t4.16b, t4.16b, #15
@@ -292,22 +173,6 @@ SYM_FUNC_START_LOCAL(__pmull_p8_16x64)
 	ret
 SYM_FUNC_END(__pmull_p8_16x64)
 
-	.macro		__pmull_p8, rq, ad, bd, i
-	.ifnc		\bd, fold_consts
-	.err
-	.endif
-	mov		ad.16b, \ad\().16b
-	.ifb		\i
-	pmull		\rq\().8h, \ad\().8b, \bd\().8b		// D = A*B
-	.else
-	pmull2		\rq\().8h, \ad\().16b, \bd\().16b	// D = A*B
-	.endif
-
-	bl		.L__pmull_p8_core\i
-
-	eor		\rq\().16b, \rq\().16b, t4.16b
-	eor		\rq\().16b, \rq\().16b, t6.16b
-	.endm
 
 	// Fold reg1, reg2 into the next 32 data bytes, storing the result back
 	// into reg1, reg2.
@@ -340,16 +205,7 @@ CPU_LE(	ext		v12.16b, v12.16b, v12.16b, #8	)
 	eor		\dst_reg\().16b, \dst_reg\().16b, \src_reg\().16b
 	.endm
 
-	.macro		__pmull_p64, rd, rn, rm, n
-	.ifb		\n
-	pmull		\rd\().1q, \rn\().1d, \rm\().1d
-	.else
-	pmull2		\rd\().1q, \rn\().2d, \rm\().2d
-	.endif
-	.endm
-
 	.macro		crc_t10dif_pmull, p
-	__pmull_init_\p
 
 	// For sizes less than 256 bytes, we can't fold 128 bytes at a time.
 	cmp		len, #256
@@ -479,47 +335,7 @@ CPU_LE(	ext		v0.16b, v0.16b, v0.16b, #8	)
 	pmull16x64_\p	fold_consts, v3, v0
 	eor		v7.16b, v3.16b, v0.16b
 	eor		v7.16b, v7.16b, v2.16b
-
-.Lreduce_final_16_bytes_\@:
-	// Reduce the 128-bit value M(x), stored in v7, to the final 16-bit CRC.
-
-	movi		v2.16b, #0		// init zero register
-
-	// Load 'x^48 * (x^48 mod G(x))' and 'x^48 * (x^80 mod G(x))'.
-	ld1		{fold_consts.2d}, [fold_consts_ptr], #16
-	__pmull_pre_\p	fold_consts
-
-	// Fold the high 64 bits into the low 64 bits, while also multiplying by
-	// x^64.  This produces a 128-bit value congruent to x^64 * M(x) and
-	// whose low 48 bits are 0.
-	ext		v0.16b, v2.16b, v7.16b, #8
-	__pmull_\p	v7, v7, fold_consts, 2	// high bits * x^48 * (x^80 mod G(x))
-	eor		v0.16b, v0.16b, v7.16b	// + low bits * x^64
-
-	// Fold the high 32 bits into the low 96 bits.  This produces a 96-bit
-	// value congruent to x^64 * M(x) and whose low 48 bits are 0.
-	ext		v1.16b, v0.16b, v2.16b, #12	// extract high 32 bits
-	mov		v0.s[3], v2.s[0]	// zero high 32 bits
-	__pmull_\p	v1, v1, fold_consts	// high 32 bits * x^48 * (x^48 mod G(x))
-	eor		v0.16b, v0.16b, v1.16b	// + low bits
-
-	// Load G(x) and floor(x^48 / G(x)).
-	ld1		{fold_consts.2d}, [fold_consts_ptr]
-	__pmull_pre_\p	fold_consts
-
-	// Use Barrett reduction to compute the final CRC value.
-	__pmull_\p	v1, v0, fold_consts, 2	// high 32 bits * floor(x^48 / G(x))
-	ushr		v1.2d, v1.2d, #32	// /= x^32
-	__pmull_\p	v1, v1, fold_consts	// *= G(x)
-	ushr		v0.2d, v0.2d, #48
-	eor		v0.16b, v0.16b, v1.16b	// + low 16 nonzero bits
-	// Final CRC value (x^16 * M(x)) mod G(x) is in low 16 bits of v0.
-
-	umov		w0, v0.h[0]
-	.ifc		\p, p8
-	frame_pop
-	.endif
-	ret
+	b		.Lreduce_final_16_bytes_\@
 
 .Lless_than_256_bytes_\@:
 	// Checksumming a buffer of length 16...255 bytes
@@ -545,6 +361,8 @@ CPU_LE(	ext		v7.16b, v7.16b, v7.16b, #8	)
 	b.ge		.Lfold_16_bytes_loop_\@		// 32 <= len <= 255
 	add		len, len, #16
 	b		.Lhandle_partial_segment_\@	// 17 <= len <= 31
+
+.Lreduce_final_16_bytes_\@:
 	.endm
 
 //
@@ -554,7 +372,22 @@ CPU_LE(	ext		v7.16b, v7.16b, v7.16b, #8	)
 //
 SYM_FUNC_START(crc_t10dif_pmull_p8)
 	frame_push	1
+
+	// Compose { 0,0,0,0, 8,8,8,8, 1,1,1,1, 9,9,9,9 }
+	movi		perm.4h, #8, lsl #8
+	orr		perm.2s, #1, lsl #16
+	orr		perm.2s, #1, lsl #24
+	zip1		perm.16b, perm.16b, perm.16b
+	zip1		perm.16b, perm.16b, perm.16b
+
 	crc_t10dif_pmull p8
+
+CPU_LE(	rev64		v7.16b, v7.16b			)
+CPU_LE(	ext		v7.16b, v7.16b, v7.16b, #8	)
+	str		q7, [x3]
+
+	frame_pop
+	ret
 SYM_FUNC_END(crc_t10dif_pmull_p8)
 
 	.align		5
@@ -565,6 +398,41 @@ SYM_FUNC_END(crc_t10dif_pmull_p8)
 //
 SYM_FUNC_START(crc_t10dif_pmull_p64)
 	crc_t10dif_pmull	p64
+
+	// Reduce the 128-bit value M(x), stored in v7, to the final 16-bit CRC.
+
+	movi		v2.16b, #0		// init zero register
+
+	// Load 'x^48 * (x^48 mod G(x))' and 'x^48 * (x^80 mod G(x))'.
+	ld1		{fold_consts.2d}, [fold_consts_ptr], #16
+
+	// Fold the high 64 bits into the low 64 bits, while also multiplying by
+	// x^64.  This produces a 128-bit value congruent to x^64 * M(x) and
+	// whose low 48 bits are 0.
+	ext		v0.16b, v2.16b, v7.16b, #8
+	pmull2		v7.1q, v7.2d, fold_consts.2d	// high bits * x^48 * (x^80 mod G(x))
+	eor		v0.16b, v0.16b, v7.16b		// + low bits * x^64
+
+	// Fold the high 32 bits into the low 96 bits.  This produces a 96-bit
+	// value congruent to x^64 * M(x) and whose low 48 bits are 0.
+	ext		v1.16b, v0.16b, v2.16b, #12	// extract high 32 bits
+	mov		v0.s[3], v2.s[0]		// zero high 32 bits
+	pmull		v1.1q, v1.1d, fold_consts.1d	// high 32 bits * x^48 * (x^48 mod G(x))
+	eor		v0.16b, v0.16b, v1.16b		// + low bits
+
+	// Load G(x) and floor(x^48 / G(x)).
+	ld1		{fold_consts.2d}, [fold_consts_ptr]
+
+	// Use Barrett reduction to compute the final CRC value.
+	pmull2		v1.1q, v0.2d, fold_consts.2d	// high 32 bits * floor(x^48 / G(x))
+	ushr		v1.2d, v1.2d, #32		// /= x^32
+	pmull		v1.1q, v1.1d, fold_consts.1d	// *= G(x)
+	ushr		v0.2d, v0.2d, #48
+	eor		v0.16b, v0.16b, v1.16b		// + low 16 nonzero bits
+	// Final CRC value (x^16 * M(x)) mod G(x) is in low 16 bits of v0.
+
+	umov		w0, v0.h[0]
+	ret
 SYM_FUNC_END(crc_t10dif_pmull_p64)
 
 	.section	".rodata", "a"
diff --git a/arch/arm64/crypto/crct10dif-ce-glue.c b/arch/arm64/crypto/crct10dif-ce-glue.c
index 7b05094a0480..08bcbd884395 100644
--- a/arch/arm64/crypto/crct10dif-ce-glue.c
+++ b/arch/arm64/crypto/crct10dif-ce-glue.c
@@ -20,7 +20,8 @@
 
 #define CRC_T10DIF_PMULL_CHUNK_SIZE	16U
 
-asmlinkage u16 crc_t10dif_pmull_p8(u16 init_crc, const u8 *buf, size_t len);
+asmlinkage void crc_t10dif_pmull_p8(u16 init_crc, const u8 *buf, size_t len,
+				    u8 out[16]);
 asmlinkage u16 crc_t10dif_pmull_p64(u16 init_crc, const u8 *buf, size_t len);
 
 static int crct10dif_init(struct shash_desc *desc)
@@ -34,16 +35,21 @@ static int crct10dif_init(struct shash_desc *desc)
 static int crct10dif_update_pmull_p8(struct shash_desc *desc, const u8 *data,
 			    unsigned int length)
 {
-	u16 *crc = shash_desc_ctx(desc);
+	u16 *crcp = shash_desc_ctx(desc);
+	u16 crc = *crcp;
+	u8 buf[16];
 
-	if (length >= CRC_T10DIF_PMULL_CHUNK_SIZE && crypto_simd_usable()) {
+	if (length > CRC_T10DIF_PMULL_CHUNK_SIZE && crypto_simd_usable()) {
 		kernel_neon_begin();
-		*crc = crc_t10dif_pmull_p8(*crc, data, length);
+		crc_t10dif_pmull_p8(crc, data, length, buf);
 		kernel_neon_end();
-	} else {
-		*crc = crc_t10dif_generic(*crc, data, length);
+
+		crc = 0;
+		data = buf;
+		length = sizeof(buf);
 	}
 
+	*crcp = crc_t10dif_generic(crc, data, length);
 	return 0;
 }
 
-- 
2.47.0.199.ga7371fff76-goog



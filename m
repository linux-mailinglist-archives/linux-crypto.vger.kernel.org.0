Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88247130512
	for <lists+linux-crypto@lfdr.de>; Sun,  5 Jan 2020 00:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgADXmG (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 4 Jan 2020 18:42:06 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:46447 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgADXmG (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 4 Jan 2020 18:42:06 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id ce319ec4;
        Sat, 4 Jan 2020 22:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=mail; bh=hW/je7R7H4h67p4uwbPejT8c6
        A4=; b=A3IIgwUb2OBSLvtIlNNH1mAczlfAYZLvNHMwOMgx+IGvkeWxHSJMiNSWW
        hZGCiLsnU+tgfFOe2CFRADEcSo5Z6OQst8nxkNojQEpxH25GD7HngQkP+nUivFEd
        VRppMuOsy6sVHJagwoRg+yWQr4i+JLr2+BlU5nn88Vr1t5Rlib6a8YEq6NbtGNTV
        b4IJGCkx4WYjkDznDeFEb/juGky1NGhB3hUi9ikEA70Jx3zO5uBLvegpwuEX2T7u
        FbFS3aK7B5HyaMmR4p2H0odQ9hTKpSL707KikWH3fRN9VAfZp+VfjJ57RxP68EZL
        PTHzlMNhjnSvqoRWnU7tKMj2uBwRA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 74e8107b (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Sat, 4 Jan 2020 22:43:05 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>
Subject: [PATCH v7 3/4] crypto: x86_64/poly1305 - wire up faster implementations for kernel
Date:   Sat,  4 Jan 2020 18:41:40 -0500
Message-Id: <20200104234141.4624-4-Jason@zx2c4.com>
In-Reply-To: <20200104234141.4624-1-Jason@zx2c4.com>
References: <20200104234141.4624-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

These x86_64 vectorized implementations support AVX, AVX-2, and AVX512F.
The AVX-512F implementation is disabled on Skylake, due to throttling,
but it is quite fast on >= Cannonlake.

On the left is cycle counts on a Core i7 6700HQ using the AVX-2
codepath, comparing this implementation ("new") to the implementation in
the current crypto api ("old"). On the right are benchmarks on a Xeon
Gold 5120 using the AVX-512 codepath. The new implementation is faster
on all benchmarks.

        AVX-2                  AVX-512
      ---------              -----------

    size    old     new      size   old     new
    ----    ----    ----     ----   ----    ----
    0       70      68       0      74      70
    16      92      90       16     96      92
    32      134     104      32     136     106
    48      172     120      48     184     124
    64      218     136      64     218     138
    80      254     158      80     260     160
    96      298     174      96     300     176
    112     342     192      112    342     194
    128     388     212      128    384     212
    144     428     228      144    420     226
    160     466     246      160    464     248
    176     510     264      176    504     264
    192     550     282      192    544     282
    208     594     302      208    582     300
    224     628     316      224    624     318
    240     676     334      240    662     338
    256     716     354      256    708     358
    272     764     374      272    748     372
    288     802     352      288    788     358
    304     420     366      304    422     370
    320     428     360      320    432     364
    336     484     378      336    486     380
    352     426     384      352    434     390
    368     478     400      368    480     408
    384     488     394      384    490     398
    400     542     408      400    542     412
    416     486     416      416    492     426
    432     534     430      432    538     436
    448     544     422      448    546     432
    464     600     438      464    600     448
    480     540     448      480    548     456
    496     594     464      496    594     476
    512     602     456      512    606     470
    528     656     476      528    656     480
    544     600     480      544    606     498
    560     650     494      560    652     512
    576     664     490      576    662     508
    592     714     508      592    716     522
    608     656     514      608    664     538
    624     708     532      624    710     552
    640     716     524      640    720     516
    656     770     536      656    772     526
    672     716     548      672    722     544
    688     770     562      688    768     556
    704     774     552      704    778     556
    720     826     568      720    832     568
    736     768     574      736    780     584
    752     822     592      752    826     600
    768     830     584      768    836     560
    784     884     602      784    888     572
    800     828     610      800    838     588
    816     884     628      816    884     604
    832     888     618      832    894     598
    848     942     632      848    946     612
    864     884     644      864    896     628
    880     936     660      880    942     644
    896     948     652      896    952     608
    912     1000    664      912    1004    616
    928     942     676      928    954     634
    944     994     690      944    1000    646
    960     1002    680      960    1008    646
    976     1054    694      976    1062    658
    992     1002    706      992    1012    674
    1008    1052    720      1008   1058    690

This commit wires in the prior implementation from Andy, and makes the
following changes to be suitable for kernel land.

  - Some cosmetic and structural changes, like renaming labels to
    .Lname, constants, and other Linux conventions, as well as making
    the code easy for us to maintain moving forward.

  - CPU feature checking is done in C by the glue code.

  - We avoid jumping into the middle of functions, to appease objtool,
    and instead parameterize shared code.

  - We maintain frame pointers so that stack traces make sense.

  - We remove the dependency on the perl xlate code, which transforms
    the output into things that assemblers we don't care about use.

Importantly, none of our changes affect the arithmetic or core code, but
just involve the differing environment of kernel space.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Samuel Neves <sneves@dei.uc.pt>
Co-developed-by: Samuel Neves <sneves@dei.uc.pt>
---
 arch/x86/crypto/.gitignore             |   1 +
 arch/x86/crypto/Makefile               |  11 +-
 arch/x86/crypto/poly1305-avx2-x86_64.S | 390 --------------
 arch/x86/crypto/poly1305-sse2-x86_64.S | 590 ---------------------
 arch/x86/crypto/poly1305-x86_64.pl     | 682 ++++++++++++++-----------
 arch/x86/crypto/poly1305_glue.c        | 473 ++++++-----------
 lib/crypto/Kconfig                     |   2 +-
 7 files changed, 572 insertions(+), 1577 deletions(-)
 create mode 100644 arch/x86/crypto/.gitignore
 delete mode 100644 arch/x86/crypto/poly1305-avx2-x86_64.S
 delete mode 100644 arch/x86/crypto/poly1305-sse2-x86_64.S

diff --git a/arch/x86/crypto/.gitignore b/arch/x86/crypto/.gitignore
new file mode 100644
index 000000000000..c406ea6571fa
--- /dev/null
+++ b/arch/x86/crypto/.gitignore
@@ -0,0 +1 @@
+poly1305-x86_64.S
diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
index 958440eae27e..6982a2f8863f 100644
--- a/arch/x86/crypto/Makefile
+++ b/arch/x86/crypto/Makefile
@@ -73,6 +73,10 @@ aegis128-aesni-y := aegis128-aesni-asm.o aegis128-aesni-glue.o
 
 nhpoly1305-sse2-y := nh-sse2-x86_64.o nhpoly1305-sse2-glue.o
 blake2s-x86_64-y := blake2s-core.o blake2s-glue.o
+poly1305-x86_64-y := poly1305-x86_64.o poly1305_glue.o
+ifneq ($(CONFIG_CRYPTO_POLY1305_X86_64),)
+targets += poly1305-x86_64.S
+endif
 
 ifeq ($(avx_supported),yes)
 	camellia-aesni-avx-x86_64-y := camellia-aesni-avx-asm_64.o \
@@ -101,10 +105,8 @@ aesni-intel-y := aesni-intel_asm.o aesni-intel_glue.o
 aesni-intel-$(CONFIG_64BIT) += aesni-intel_avx-x86_64.o aes_ctrby8_avx-x86_64.o
 ghash-clmulni-intel-y := ghash-clmulni-intel_asm.o ghash-clmulni-intel_glue.o
 sha1-ssse3-y := sha1_ssse3_asm.o sha1_ssse3_glue.o
-poly1305-x86_64-y := poly1305-sse2-x86_64.o poly1305_glue.o
 ifeq ($(avx2_supported),yes)
 sha1-ssse3-y += sha1_avx2_x86_64_asm.o
-poly1305-x86_64-y += poly1305-avx2-x86_64.o
 endif
 ifeq ($(sha1_ni_supported),yes)
 sha1-ssse3-y += sha1_ni_asm.o
@@ -118,3 +120,8 @@ sha256-ssse3-y += sha256_ni_asm.o
 endif
 sha512-ssse3-y := sha512-ssse3-asm.o sha512-avx-asm.o sha512-avx2-asm.o sha512_ssse3_glue.o
 crct10dif-pclmul-y := crct10dif-pcl-asm_64.o crct10dif-pclmul_glue.o
+
+quiet_cmd_perlasm = PERLASM $@
+      cmd_perlasm = $(PERL) $< > $@
+$(obj)/%.S: $(src)/%.pl FORCE
+	$(call if_changed,perlasm)
diff --git a/arch/x86/crypto/poly1305-avx2-x86_64.S b/arch/x86/crypto/poly1305-avx2-x86_64.S
deleted file mode 100644
index 8f56989ea599..000000000000
--- a/arch/x86/crypto/poly1305-avx2-x86_64.S
+++ /dev/null
@@ -1,390 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Poly1305 authenticator algorithm, RFC7539, x64 AVX2 functions
- *
- * Copyright (C) 2015 Martin Willi
- */
-
-#include <linux/linkage.h>
-
-.section	.rodata.cst32.ANMASK, "aM", @progbits, 32
-.align 32
-ANMASK:	.octa 0x0000000003ffffff0000000003ffffff
-	.octa 0x0000000003ffffff0000000003ffffff
-
-.section	.rodata.cst32.ORMASK, "aM", @progbits, 32
-.align 32
-ORMASK:	.octa 0x00000000010000000000000001000000
-	.octa 0x00000000010000000000000001000000
-
-.text
-
-#define h0 0x00(%rdi)
-#define h1 0x04(%rdi)
-#define h2 0x08(%rdi)
-#define h3 0x0c(%rdi)
-#define h4 0x10(%rdi)
-#define r0 0x00(%rdx)
-#define r1 0x04(%rdx)
-#define r2 0x08(%rdx)
-#define r3 0x0c(%rdx)
-#define r4 0x10(%rdx)
-#define u0 0x00(%r8)
-#define u1 0x04(%r8)
-#define u2 0x08(%r8)
-#define u3 0x0c(%r8)
-#define u4 0x10(%r8)
-#define w0 0x18(%r8)
-#define w1 0x1c(%r8)
-#define w2 0x20(%r8)
-#define w3 0x24(%r8)
-#define w4 0x28(%r8)
-#define y0 0x30(%r8)
-#define y1 0x34(%r8)
-#define y2 0x38(%r8)
-#define y3 0x3c(%r8)
-#define y4 0x40(%r8)
-#define m %rsi
-#define hc0 %ymm0
-#define hc1 %ymm1
-#define hc2 %ymm2
-#define hc3 %ymm3
-#define hc4 %ymm4
-#define hc0x %xmm0
-#define hc1x %xmm1
-#define hc2x %xmm2
-#define hc3x %xmm3
-#define hc4x %xmm4
-#define t1 %ymm5
-#define t2 %ymm6
-#define t1x %xmm5
-#define t2x %xmm6
-#define ruwy0 %ymm7
-#define ruwy1 %ymm8
-#define ruwy2 %ymm9
-#define ruwy3 %ymm10
-#define ruwy4 %ymm11
-#define ruwy0x %xmm7
-#define ruwy1x %xmm8
-#define ruwy2x %xmm9
-#define ruwy3x %xmm10
-#define ruwy4x %xmm11
-#define svxz1 %ymm12
-#define svxz2 %ymm13
-#define svxz3 %ymm14
-#define svxz4 %ymm15
-#define d0 %r9
-#define d1 %r10
-#define d2 %r11
-#define d3 %r12
-#define d4 %r13
-
-SYM_FUNC_START(poly1305_4block_avx2)
-	# %rdi: Accumulator h[5]
-	# %rsi: 64 byte input block m
-	# %rdx: Poly1305 key r[5]
-	# %rcx: Quadblock count
-	# %r8:  Poly1305 derived key r^2 u[5], r^3 w[5], r^4 y[5],
-
-	# This four-block variant uses loop unrolled block processing. It
-	# requires 4 Poly1305 keys: r, r^2, r^3 and r^4:
-	# h = (h + m) * r  =>  h = (h + m1) * r^4 + m2 * r^3 + m3 * r^2 + m4 * r
-
-	vzeroupper
-	push		%rbx
-	push		%r12
-	push		%r13
-
-	# combine r0,u0,w0,y0
-	vmovd		y0,ruwy0x
-	vmovd		w0,t1x
-	vpunpcklqdq	t1,ruwy0,ruwy0
-	vmovd		u0,t1x
-	vmovd		r0,t2x
-	vpunpcklqdq	t2,t1,t1
-	vperm2i128	$0x20,t1,ruwy0,ruwy0
-
-	# combine r1,u1,w1,y1 and s1=r1*5,v1=u1*5,x1=w1*5,z1=y1*5
-	vmovd		y1,ruwy1x
-	vmovd		w1,t1x
-	vpunpcklqdq	t1,ruwy1,ruwy1
-	vmovd		u1,t1x
-	vmovd		r1,t2x
-	vpunpcklqdq	t2,t1,t1
-	vperm2i128	$0x20,t1,ruwy1,ruwy1
-	vpslld		$2,ruwy1,svxz1
-	vpaddd		ruwy1,svxz1,svxz1
-
-	# combine r2,u2,w2,y2 and s2=r2*5,v2=u2*5,x2=w2*5,z2=y2*5
-	vmovd		y2,ruwy2x
-	vmovd		w2,t1x
-	vpunpcklqdq	t1,ruwy2,ruwy2
-	vmovd		u2,t1x
-	vmovd		r2,t2x
-	vpunpcklqdq	t2,t1,t1
-	vperm2i128	$0x20,t1,ruwy2,ruwy2
-	vpslld		$2,ruwy2,svxz2
-	vpaddd		ruwy2,svxz2,svxz2
-
-	# combine r3,u3,w3,y3 and s3=r3*5,v3=u3*5,x3=w3*5,z3=y3*5
-	vmovd		y3,ruwy3x
-	vmovd		w3,t1x
-	vpunpcklqdq	t1,ruwy3,ruwy3
-	vmovd		u3,t1x
-	vmovd		r3,t2x
-	vpunpcklqdq	t2,t1,t1
-	vperm2i128	$0x20,t1,ruwy3,ruwy3
-	vpslld		$2,ruwy3,svxz3
-	vpaddd		ruwy3,svxz3,svxz3
-
-	# combine r4,u4,w4,y4 and s4=r4*5,v4=u4*5,x4=w4*5,z4=y4*5
-	vmovd		y4,ruwy4x
-	vmovd		w4,t1x
-	vpunpcklqdq	t1,ruwy4,ruwy4
-	vmovd		u4,t1x
-	vmovd		r4,t2x
-	vpunpcklqdq	t2,t1,t1
-	vperm2i128	$0x20,t1,ruwy4,ruwy4
-	vpslld		$2,ruwy4,svxz4
-	vpaddd		ruwy4,svxz4,svxz4
-
-.Ldoblock4:
-	# hc0 = [m[48-51] & 0x3ffffff, m[32-35] & 0x3ffffff,
-	#	 m[16-19] & 0x3ffffff, m[ 0- 3] & 0x3ffffff + h0]
-	vmovd		0x00(m),hc0x
-	vmovd		0x10(m),t1x
-	vpunpcklqdq	t1,hc0,hc0
-	vmovd		0x20(m),t1x
-	vmovd		0x30(m),t2x
-	vpunpcklqdq	t2,t1,t1
-	vperm2i128	$0x20,t1,hc0,hc0
-	vpand		ANMASK(%rip),hc0,hc0
-	vmovd		h0,t1x
-	vpaddd		t1,hc0,hc0
-	# hc1 = [(m[51-54] >> 2) & 0x3ffffff, (m[35-38] >> 2) & 0x3ffffff,
-	#	 (m[19-22] >> 2) & 0x3ffffff, (m[ 3- 6] >> 2) & 0x3ffffff + h1]
-	vmovd		0x03(m),hc1x
-	vmovd		0x13(m),t1x
-	vpunpcklqdq	t1,hc1,hc1
-	vmovd		0x23(m),t1x
-	vmovd		0x33(m),t2x
-	vpunpcklqdq	t2,t1,t1
-	vperm2i128	$0x20,t1,hc1,hc1
-	vpsrld		$2,hc1,hc1
-	vpand		ANMASK(%rip),hc1,hc1
-	vmovd		h1,t1x
-	vpaddd		t1,hc1,hc1
-	# hc2 = [(m[54-57] >> 4) & 0x3ffffff, (m[38-41] >> 4) & 0x3ffffff,
-	#	 (m[22-25] >> 4) & 0x3ffffff, (m[ 6- 9] >> 4) & 0x3ffffff + h2]
-	vmovd		0x06(m),hc2x
-	vmovd		0x16(m),t1x
-	vpunpcklqdq	t1,hc2,hc2
-	vmovd		0x26(m),t1x
-	vmovd		0x36(m),t2x
-	vpunpcklqdq	t2,t1,t1
-	vperm2i128	$0x20,t1,hc2,hc2
-	vpsrld		$4,hc2,hc2
-	vpand		ANMASK(%rip),hc2,hc2
-	vmovd		h2,t1x
-	vpaddd		t1,hc2,hc2
-	# hc3 = [(m[57-60] >> 6) & 0x3ffffff, (m[41-44] >> 6) & 0x3ffffff,
-	#	 (m[25-28] >> 6) & 0x3ffffff, (m[ 9-12] >> 6) & 0x3ffffff + h3]
-	vmovd		0x09(m),hc3x
-	vmovd		0x19(m),t1x
-	vpunpcklqdq	t1,hc3,hc3
-	vmovd		0x29(m),t1x
-	vmovd		0x39(m),t2x
-	vpunpcklqdq	t2,t1,t1
-	vperm2i128	$0x20,t1,hc3,hc3
-	vpsrld		$6,hc3,hc3
-	vpand		ANMASK(%rip),hc3,hc3
-	vmovd		h3,t1x
-	vpaddd		t1,hc3,hc3
-	# hc4 = [(m[60-63] >> 8) | (1<<24), (m[44-47] >> 8) | (1<<24),
-	#	 (m[28-31] >> 8) | (1<<24), (m[12-15] >> 8) | (1<<24) + h4]
-	vmovd		0x0c(m),hc4x
-	vmovd		0x1c(m),t1x
-	vpunpcklqdq	t1,hc4,hc4
-	vmovd		0x2c(m),t1x
-	vmovd		0x3c(m),t2x
-	vpunpcklqdq	t2,t1,t1
-	vperm2i128	$0x20,t1,hc4,hc4
-	vpsrld		$8,hc4,hc4
-	vpor		ORMASK(%rip),hc4,hc4
-	vmovd		h4,t1x
-	vpaddd		t1,hc4,hc4
-
-	# t1 = [ hc0[3] * r0, hc0[2] * u0, hc0[1] * w0, hc0[0] * y0 ]
-	vpmuludq	hc0,ruwy0,t1
-	# t1 += [ hc1[3] * s4, hc1[2] * v4, hc1[1] * x4, hc1[0] * z4 ]
-	vpmuludq	hc1,svxz4,t2
-	vpaddq		t2,t1,t1
-	# t1 += [ hc2[3] * s3, hc2[2] * v3, hc2[1] * x3, hc2[0] * z3 ]
-	vpmuludq	hc2,svxz3,t2
-	vpaddq		t2,t1,t1
-	# t1 += [ hc3[3] * s2, hc3[2] * v2, hc3[1] * x2, hc3[0] * z2 ]
-	vpmuludq	hc3,svxz2,t2
-	vpaddq		t2,t1,t1
-	# t1 += [ hc4[3] * s1, hc4[2] * v1, hc4[1] * x1, hc4[0] * z1 ]
-	vpmuludq	hc4,svxz1,t2
-	vpaddq		t2,t1,t1
-	# d0 = t1[0] + t1[1] + t[2] + t[3]
-	vpermq		$0xee,t1,t2
-	vpaddq		t2,t1,t1
-	vpsrldq		$8,t1,t2
-	vpaddq		t2,t1,t1
-	vmovq		t1x,d0
-
-	# t1 = [ hc0[3] * r1, hc0[2] * u1,hc0[1] * w1, hc0[0] * y1 ]
-	vpmuludq	hc0,ruwy1,t1
-	# t1 += [ hc1[3] * r0, hc1[2] * u0, hc1[1] * w0, hc1[0] * y0 ]
-	vpmuludq	hc1,ruwy0,t2
-	vpaddq		t2,t1,t1
-	# t1 += [ hc2[3] * s4, hc2[2] * v4, hc2[1] * x4, hc2[0] * z4 ]
-	vpmuludq	hc2,svxz4,t2
-	vpaddq		t2,t1,t1
-	# t1 += [ hc3[3] * s3, hc3[2] * v3, hc3[1] * x3, hc3[0] * z3 ]
-	vpmuludq	hc3,svxz3,t2
-	vpaddq		t2,t1,t1
-	# t1 += [ hc4[3] * s2, hc4[2] * v2, hc4[1] * x2, hc4[0] * z2 ]
-	vpmuludq	hc4,svxz2,t2
-	vpaddq		t2,t1,t1
-	# d1 = t1[0] + t1[1] + t1[3] + t1[4]
-	vpermq		$0xee,t1,t2
-	vpaddq		t2,t1,t1
-	vpsrldq		$8,t1,t2
-	vpaddq		t2,t1,t1
-	vmovq		t1x,d1
-
-	# t1 = [ hc0[3] * r2, hc0[2] * u2, hc0[1] * w2, hc0[0] * y2 ]
-	vpmuludq	hc0,ruwy2,t1
-	# t1 += [ hc1[3] * r1, hc1[2] * u1, hc1[1] * w1, hc1[0] * y1 ]
-	vpmuludq	hc1,ruwy1,t2
-	vpaddq		t2,t1,t1
-	# t1 += [ hc2[3] * r0, hc2[2] * u0, hc2[1] * w0, hc2[0] * y0 ]
-	vpmuludq	hc2,ruwy0,t2
-	vpaddq		t2,t1,t1
-	# t1 += [ hc3[3] * s4, hc3[2] * v4, hc3[1] * x4, hc3[0] * z4 ]
-	vpmuludq	hc3,svxz4,t2
-	vpaddq		t2,t1,t1
-	# t1 += [ hc4[3] * s3, hc4[2] * v3, hc4[1] * x3, hc4[0] * z3 ]
-	vpmuludq	hc4,svxz3,t2
-	vpaddq		t2,t1,t1
-	# d2 = t1[0] + t1[1] + t1[2] + t1[3]
-	vpermq		$0xee,t1,t2
-	vpaddq		t2,t1,t1
-	vpsrldq		$8,t1,t2
-	vpaddq		t2,t1,t1
-	vmovq		t1x,d2
-
-	# t1 = [ hc0[3] * r3, hc0[2] * u3, hc0[1] * w3, hc0[0] * y3 ]
-	vpmuludq	hc0,ruwy3,t1
-	# t1 += [ hc1[3] * r2, hc1[2] * u2, hc1[1] * w2, hc1[0] * y2 ]
-	vpmuludq	hc1,ruwy2,t2
-	vpaddq		t2,t1,t1
-	# t1 += [ hc2[3] * r1, hc2[2] * u1, hc2[1] * w1, hc2[0] * y1 ]
-	vpmuludq	hc2,ruwy1,t2
-	vpaddq		t2,t1,t1
-	# t1 += [ hc3[3] * r0, hc3[2] * u0, hc3[1] * w0, hc3[0] * y0 ]
-	vpmuludq	hc3,ruwy0,t2
-	vpaddq		t2,t1,t1
-	# t1 += [ hc4[3] * s4, hc4[2] * v4, hc4[1] * x4, hc4[0] * z4 ]
-	vpmuludq	hc4,svxz4,t2
-	vpaddq		t2,t1,t1
-	# d3 = t1[0] + t1[1] + t1[2] + t1[3]
-	vpermq		$0xee,t1,t2
-	vpaddq		t2,t1,t1
-	vpsrldq		$8,t1,t2
-	vpaddq		t2,t1,t1
-	vmovq		t1x,d3
-
-	# t1 = [ hc0[3] * r4, hc0[2] * u4, hc0[1] * w4, hc0[0] * y4 ]
-	vpmuludq	hc0,ruwy4,t1
-	# t1 += [ hc1[3] * r3, hc1[2] * u3, hc1[1] * w3, hc1[0] * y3 ]
-	vpmuludq	hc1,ruwy3,t2
-	vpaddq		t2,t1,t1
-	# t1 += [ hc2[3] * r2, hc2[2] * u2, hc2[1] * w2, hc2[0] * y2 ]
-	vpmuludq	hc2,ruwy2,t2
-	vpaddq		t2,t1,t1
-	# t1 += [ hc3[3] * r1, hc3[2] * u1, hc3[1] * w1, hc3[0] * y1 ]
-	vpmuludq	hc3,ruwy1,t2
-	vpaddq		t2,t1,t1
-	# t1 += [ hc4[3] * r0, hc4[2] * u0, hc4[1] * w0, hc4[0] * y0 ]
-	vpmuludq	hc4,ruwy0,t2
-	vpaddq		t2,t1,t1
-	# d4 = t1[0] + t1[1] + t1[2] + t1[3]
-	vpermq		$0xee,t1,t2
-	vpaddq		t2,t1,t1
-	vpsrldq		$8,t1,t2
-	vpaddq		t2,t1,t1
-	vmovq		t1x,d4
-
-	# Now do a partial reduction mod (2^130)-5, carrying h0 -> h1 -> h2 ->
-	# h3 -> h4 -> h0 -> h1 to get h0,h2,h3,h4 < 2^26 and h1 < 2^26 + a small
-	# amount.  Careful: we must not assume the carry bits 'd0 >> 26',
-	# 'd1 >> 26', 'd2 >> 26', 'd3 >> 26', and '(d4 >> 26) * 5' fit in 32-bit
-	# integers.  It's true in a single-block implementation, but not here.
-
-	# d1 += d0 >> 26
-	mov		d0,%rax
-	shr		$26,%rax
-	add		%rax,d1
-	# h0 = d0 & 0x3ffffff
-	mov		d0,%rbx
-	and		$0x3ffffff,%ebx
-
-	# d2 += d1 >> 26
-	mov		d1,%rax
-	shr		$26,%rax
-	add		%rax,d2
-	# h1 = d1 & 0x3ffffff
-	mov		d1,%rax
-	and		$0x3ffffff,%eax
-	mov		%eax,h1
-
-	# d3 += d2 >> 26
-	mov		d2,%rax
-	shr		$26,%rax
-	add		%rax,d3
-	# h2 = d2 & 0x3ffffff
-	mov		d2,%rax
-	and		$0x3ffffff,%eax
-	mov		%eax,h2
-
-	# d4 += d3 >> 26
-	mov		d3,%rax
-	shr		$26,%rax
-	add		%rax,d4
-	# h3 = d3 & 0x3ffffff
-	mov		d3,%rax
-	and		$0x3ffffff,%eax
-	mov		%eax,h3
-
-	# h0 += (d4 >> 26) * 5
-	mov		d4,%rax
-	shr		$26,%rax
-	lea		(%rax,%rax,4),%rax
-	add		%rax,%rbx
-	# h4 = d4 & 0x3ffffff
-	mov		d4,%rax
-	and		$0x3ffffff,%eax
-	mov		%eax,h4
-
-	# h1 += h0 >> 26
-	mov		%rbx,%rax
-	shr		$26,%rax
-	add		%eax,h1
-	# h0 = h0 & 0x3ffffff
-	andl		$0x3ffffff,%ebx
-	mov		%ebx,h0
-
-	add		$0x40,m
-	dec		%rcx
-	jnz		.Ldoblock4
-
-	vzeroupper
-	pop		%r13
-	pop		%r12
-	pop		%rbx
-	ret
-SYM_FUNC_END(poly1305_4block_avx2)
diff --git a/arch/x86/crypto/poly1305-sse2-x86_64.S b/arch/x86/crypto/poly1305-sse2-x86_64.S
deleted file mode 100644
index d8ea29b96640..000000000000
--- a/arch/x86/crypto/poly1305-sse2-x86_64.S
+++ /dev/null
@@ -1,590 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Poly1305 authenticator algorithm, RFC7539, x64 SSE2 functions
- *
- * Copyright (C) 2015 Martin Willi
- */
-
-#include <linux/linkage.h>
-
-.section	.rodata.cst16.ANMASK, "aM", @progbits, 16
-.align 16
-ANMASK:	.octa 0x0000000003ffffff0000000003ffffff
-
-.section	.rodata.cst16.ORMASK, "aM", @progbits, 16
-.align 16
-ORMASK:	.octa 0x00000000010000000000000001000000
-
-.text
-
-#define h0 0x00(%rdi)
-#define h1 0x04(%rdi)
-#define h2 0x08(%rdi)
-#define h3 0x0c(%rdi)
-#define h4 0x10(%rdi)
-#define r0 0x00(%rdx)
-#define r1 0x04(%rdx)
-#define r2 0x08(%rdx)
-#define r3 0x0c(%rdx)
-#define r4 0x10(%rdx)
-#define s1 0x00(%rsp)
-#define s2 0x04(%rsp)
-#define s3 0x08(%rsp)
-#define s4 0x0c(%rsp)
-#define m %rsi
-#define h01 %xmm0
-#define h23 %xmm1
-#define h44 %xmm2
-#define t1 %xmm3
-#define t2 %xmm4
-#define t3 %xmm5
-#define t4 %xmm6
-#define mask %xmm7
-#define d0 %r8
-#define d1 %r9
-#define d2 %r10
-#define d3 %r11
-#define d4 %r12
-
-SYM_FUNC_START(poly1305_block_sse2)
-	# %rdi: Accumulator h[5]
-	# %rsi: 16 byte input block m
-	# %rdx: Poly1305 key r[5]
-	# %rcx: Block count
-
-	# This single block variant tries to improve performance by doing two
-	# multiplications in parallel using SSE instructions. There is quite
-	# some quardword packing involved, hence the speedup is marginal.
-
-	push		%rbx
-	push		%r12
-	sub		$0x10,%rsp
-
-	# s1..s4 = r1..r4 * 5
-	mov		r1,%eax
-	lea		(%eax,%eax,4),%eax
-	mov		%eax,s1
-	mov		r2,%eax
-	lea		(%eax,%eax,4),%eax
-	mov		%eax,s2
-	mov		r3,%eax
-	lea		(%eax,%eax,4),%eax
-	mov		%eax,s3
-	mov		r4,%eax
-	lea		(%eax,%eax,4),%eax
-	mov		%eax,s4
-
-	movdqa		ANMASK(%rip),mask
-
-.Ldoblock:
-	# h01 = [0, h1, 0, h0]
-	# h23 = [0, h3, 0, h2]
-	# h44 = [0, h4, 0, h4]
-	movd		h0,h01
-	movd		h1,t1
-	movd		h2,h23
-	movd		h3,t2
-	movd		h4,h44
-	punpcklqdq	t1,h01
-	punpcklqdq	t2,h23
-	punpcklqdq	h44,h44
-
-	# h01 += [ (m[3-6] >> 2) & 0x3ffffff, m[0-3] & 0x3ffffff ]
-	movd		0x00(m),t1
-	movd		0x03(m),t2
-	psrld		$2,t2
-	punpcklqdq	t2,t1
-	pand		mask,t1
-	paddd		t1,h01
-	# h23 += [ (m[9-12] >> 6) & 0x3ffffff, (m[6-9] >> 4) & 0x3ffffff ]
-	movd		0x06(m),t1
-	movd		0x09(m),t2
-	psrld		$4,t1
-	psrld		$6,t2
-	punpcklqdq	t2,t1
-	pand		mask,t1
-	paddd		t1,h23
-	# h44 += [ (m[12-15] >> 8) | (1 << 24), (m[12-15] >> 8) | (1 << 24) ]
-	mov		0x0c(m),%eax
-	shr		$8,%eax
-	or		$0x01000000,%eax
-	movd		%eax,t1
-	pshufd		$0xc4,t1,t1
-	paddd		t1,h44
-
-	# t1[0] = h0 * r0 + h2 * s3
-	# t1[1] = h1 * s4 + h3 * s2
-	movd		r0,t1
-	movd		s4,t2
-	punpcklqdq	t2,t1
-	pmuludq		h01,t1
-	movd		s3,t2
-	movd		s2,t3
-	punpcklqdq	t3,t2
-	pmuludq		h23,t2
-	paddq		t2,t1
-	# t2[0] = h0 * r1 + h2 * s4
-	# t2[1] = h1 * r0 + h3 * s3
-	movd		r1,t2
-	movd		r0,t3
-	punpcklqdq	t3,t2
-	pmuludq		h01,t2
-	movd		s4,t3
-	movd		s3,t4
-	punpcklqdq	t4,t3
-	pmuludq		h23,t3
-	paddq		t3,t2
-	# t3[0] = h4 * s1
-	# t3[1] = h4 * s2
-	movd		s1,t3
-	movd		s2,t4
-	punpcklqdq	t4,t3
-	pmuludq		h44,t3
-	# d0 = t1[0] + t1[1] + t3[0]
-	# d1 = t2[0] + t2[1] + t3[1]
-	movdqa		t1,t4
-	punpcklqdq	t2,t4
-	punpckhqdq	t2,t1
-	paddq		t4,t1
-	paddq		t3,t1
-	movq		t1,d0
-	psrldq		$8,t1
-	movq		t1,d1
-
-	# t1[0] = h0 * r2 + h2 * r0
-	# t1[1] = h1 * r1 + h3 * s4
-	movd		r2,t1
-	movd		r1,t2
-	punpcklqdq 	t2,t1
-	pmuludq		h01,t1
-	movd		r0,t2
-	movd		s4,t3
-	punpcklqdq	t3,t2
-	pmuludq		h23,t2
-	paddq		t2,t1
-	# t2[0] = h0 * r3 + h2 * r1
-	# t2[1] = h1 * r2 + h3 * r0
-	movd		r3,t2
-	movd		r2,t3
-	punpcklqdq	t3,t2
-	pmuludq		h01,t2
-	movd		r1,t3
-	movd		r0,t4
-	punpcklqdq	t4,t3
-	pmuludq		h23,t3
-	paddq		t3,t2
-	# t3[0] = h4 * s3
-	# t3[1] = h4 * s4
-	movd		s3,t3
-	movd		s4,t4
-	punpcklqdq	t4,t3
-	pmuludq		h44,t3
-	# d2 = t1[0] + t1[1] + t3[0]
-	# d3 = t2[0] + t2[1] + t3[1]
-	movdqa		t1,t4
-	punpcklqdq	t2,t4
-	punpckhqdq	t2,t1
-	paddq		t4,t1
-	paddq		t3,t1
-	movq		t1,d2
-	psrldq		$8,t1
-	movq		t1,d3
-
-	# t1[0] = h0 * r4 + h2 * r2
-	# t1[1] = h1 * r3 + h3 * r1
-	movd		r4,t1
-	movd		r3,t2
-	punpcklqdq	t2,t1
-	pmuludq		h01,t1
-	movd		r2,t2
-	movd		r1,t3
-	punpcklqdq	t3,t2
-	pmuludq		h23,t2
-	paddq		t2,t1
-	# t3[0] = h4 * r0
-	movd		r0,t3
-	pmuludq		h44,t3
-	# d4 = t1[0] + t1[1] + t3[0]
-	movdqa		t1,t4
-	psrldq		$8,t4
-	paddq		t4,t1
-	paddq		t3,t1
-	movq		t1,d4
-
-	# d1 += d0 >> 26
-	mov		d0,%rax
-	shr		$26,%rax
-	add		%rax,d1
-	# h0 = d0 & 0x3ffffff
-	mov		d0,%rbx
-	and		$0x3ffffff,%ebx
-
-	# d2 += d1 >> 26
-	mov		d1,%rax
-	shr		$26,%rax
-	add		%rax,d2
-	# h1 = d1 & 0x3ffffff
-	mov		d1,%rax
-	and		$0x3ffffff,%eax
-	mov		%eax,h1
-
-	# d3 += d2 >> 26
-	mov		d2,%rax
-	shr		$26,%rax
-	add		%rax,d3
-	# h2 = d2 & 0x3ffffff
-	mov		d2,%rax
-	and		$0x3ffffff,%eax
-	mov		%eax,h2
-
-	# d4 += d3 >> 26
-	mov		d3,%rax
-	shr		$26,%rax
-	add		%rax,d4
-	# h3 = d3 & 0x3ffffff
-	mov		d3,%rax
-	and		$0x3ffffff,%eax
-	mov		%eax,h3
-
-	# h0 += (d4 >> 26) * 5
-	mov		d4,%rax
-	shr		$26,%rax
-	lea		(%rax,%rax,4),%rax
-	add		%rax,%rbx
-	# h4 = d4 & 0x3ffffff
-	mov		d4,%rax
-	and		$0x3ffffff,%eax
-	mov		%eax,h4
-
-	# h1 += h0 >> 26
-	mov		%rbx,%rax
-	shr		$26,%rax
-	add		%eax,h1
-	# h0 = h0 & 0x3ffffff
-	andl		$0x3ffffff,%ebx
-	mov		%ebx,h0
-
-	add		$0x10,m
-	dec		%rcx
-	jnz		.Ldoblock
-
-	# Zeroing of key material
-	mov		%rcx,0x00(%rsp)
-	mov		%rcx,0x08(%rsp)
-
-	add		$0x10,%rsp
-	pop		%r12
-	pop		%rbx
-	ret
-SYM_FUNC_END(poly1305_block_sse2)
-
-
-#define u0 0x00(%r8)
-#define u1 0x04(%r8)
-#define u2 0x08(%r8)
-#define u3 0x0c(%r8)
-#define u4 0x10(%r8)
-#define hc0 %xmm0
-#define hc1 %xmm1
-#define hc2 %xmm2
-#define hc3 %xmm5
-#define hc4 %xmm6
-#define ru0 %xmm7
-#define ru1 %xmm8
-#define ru2 %xmm9
-#define ru3 %xmm10
-#define ru4 %xmm11
-#define sv1 %xmm12
-#define sv2 %xmm13
-#define sv3 %xmm14
-#define sv4 %xmm15
-#undef d0
-#define d0 %r13
-
-SYM_FUNC_START(poly1305_2block_sse2)
-	# %rdi: Accumulator h[5]
-	# %rsi: 16 byte input block m
-	# %rdx: Poly1305 key r[5]
-	# %rcx: Doubleblock count
-	# %r8:  Poly1305 derived key r^2 u[5]
-
-	# This two-block variant further improves performance by using loop
-	# unrolled block processing. This is more straight forward and does
-	# less byte shuffling, but requires a second Poly1305 key r^2:
-	# h = (h + m) * r    =>    h = (h + m1) * r^2 + m2 * r
-
-	push		%rbx
-	push		%r12
-	push		%r13
-
-	# combine r0,u0
-	movd		u0,ru0
-	movd		r0,t1
-	punpcklqdq	t1,ru0
-
-	# combine r1,u1 and s1=r1*5,v1=u1*5
-	movd		u1,ru1
-	movd		r1,t1
-	punpcklqdq	t1,ru1
-	movdqa		ru1,sv1
-	pslld		$2,sv1
-	paddd		ru1,sv1
-
-	# combine r2,u2 and s2=r2*5,v2=u2*5
-	movd		u2,ru2
-	movd		r2,t1
-	punpcklqdq	t1,ru2
-	movdqa		ru2,sv2
-	pslld		$2,sv2
-	paddd		ru2,sv2
-
-	# combine r3,u3 and s3=r3*5,v3=u3*5
-	movd		u3,ru3
-	movd		r3,t1
-	punpcklqdq	t1,ru3
-	movdqa		ru3,sv3
-	pslld		$2,sv3
-	paddd		ru3,sv3
-
-	# combine r4,u4 and s4=r4*5,v4=u4*5
-	movd		u4,ru4
-	movd		r4,t1
-	punpcklqdq	t1,ru4
-	movdqa		ru4,sv4
-	pslld		$2,sv4
-	paddd		ru4,sv4
-
-.Ldoblock2:
-	# hc0 = [ m[16-19] & 0x3ffffff, h0 + m[0-3] & 0x3ffffff ]
-	movd		0x00(m),hc0
-	movd		0x10(m),t1
-	punpcklqdq	t1,hc0
-	pand		ANMASK(%rip),hc0
-	movd		h0,t1
-	paddd		t1,hc0
-	# hc1 = [ (m[19-22] >> 2) & 0x3ffffff, h1 + (m[3-6] >> 2) & 0x3ffffff ]
-	movd		0x03(m),hc1
-	movd		0x13(m),t1
-	punpcklqdq	t1,hc1
-	psrld		$2,hc1
-	pand		ANMASK(%rip),hc1
-	movd		h1,t1
-	paddd		t1,hc1
-	# hc2 = [ (m[22-25] >> 4) & 0x3ffffff, h2 + (m[6-9] >> 4) & 0x3ffffff ]
-	movd		0x06(m),hc2
-	movd		0x16(m),t1
-	punpcklqdq	t1,hc2
-	psrld		$4,hc2
-	pand		ANMASK(%rip),hc2
-	movd		h2,t1
-	paddd		t1,hc2
-	# hc3 = [ (m[25-28] >> 6) & 0x3ffffff, h3 + (m[9-12] >> 6) & 0x3ffffff ]
-	movd		0x09(m),hc3
-	movd		0x19(m),t1
-	punpcklqdq	t1,hc3
-	psrld		$6,hc3
-	pand		ANMASK(%rip),hc3
-	movd		h3,t1
-	paddd		t1,hc3
-	# hc4 = [ (m[28-31] >> 8) | (1<<24), h4 + (m[12-15] >> 8) | (1<<24) ]
-	movd		0x0c(m),hc4
-	movd		0x1c(m),t1
-	punpcklqdq	t1,hc4
-	psrld		$8,hc4
-	por		ORMASK(%rip),hc4
-	movd		h4,t1
-	paddd		t1,hc4
-
-	# t1 = [ hc0[1] * r0, hc0[0] * u0 ]
-	movdqa		ru0,t1
-	pmuludq		hc0,t1
-	# t1 += [ hc1[1] * s4, hc1[0] * v4 ]
-	movdqa		sv4,t2
-	pmuludq		hc1,t2
-	paddq		t2,t1
-	# t1 += [ hc2[1] * s3, hc2[0] * v3 ]
-	movdqa		sv3,t2
-	pmuludq		hc2,t2
-	paddq		t2,t1
-	# t1 += [ hc3[1] * s2, hc3[0] * v2 ]
-	movdqa		sv2,t2
-	pmuludq		hc3,t2
-	paddq		t2,t1
-	# t1 += [ hc4[1] * s1, hc4[0] * v1 ]
-	movdqa		sv1,t2
-	pmuludq		hc4,t2
-	paddq		t2,t1
-	# d0 = t1[0] + t1[1]
-	movdqa		t1,t2
-	psrldq		$8,t2
-	paddq		t2,t1
-	movq		t1,d0
-
-	# t1 = [ hc0[1] * r1, hc0[0] * u1 ]
-	movdqa		ru1,t1
-	pmuludq		hc0,t1
-	# t1 += [ hc1[1] * r0, hc1[0] * u0 ]
-	movdqa		ru0,t2
-	pmuludq		hc1,t2
-	paddq		t2,t1
-	# t1 += [ hc2[1] * s4, hc2[0] * v4 ]
-	movdqa		sv4,t2
-	pmuludq		hc2,t2
-	paddq		t2,t1
-	# t1 += [ hc3[1] * s3, hc3[0] * v3 ]
-	movdqa		sv3,t2
-	pmuludq		hc3,t2
-	paddq		t2,t1
-	# t1 += [ hc4[1] * s2, hc4[0] * v2 ]
-	movdqa		sv2,t2
-	pmuludq		hc4,t2
-	paddq		t2,t1
-	# d1 = t1[0] + t1[1]
-	movdqa		t1,t2
-	psrldq		$8,t2
-	paddq		t2,t1
-	movq		t1,d1
-
-	# t1 = [ hc0[1] * r2, hc0[0] * u2 ]
-	movdqa		ru2,t1
-	pmuludq		hc0,t1
-	# t1 += [ hc1[1] * r1, hc1[0] * u1 ]
-	movdqa		ru1,t2
-	pmuludq		hc1,t2
-	paddq		t2,t1
-	# t1 += [ hc2[1] * r0, hc2[0] * u0 ]
-	movdqa		ru0,t2
-	pmuludq		hc2,t2
-	paddq		t2,t1
-	# t1 += [ hc3[1] * s4, hc3[0] * v4 ]
-	movdqa		sv4,t2
-	pmuludq		hc3,t2
-	paddq		t2,t1
-	# t1 += [ hc4[1] * s3, hc4[0] * v3 ]
-	movdqa		sv3,t2
-	pmuludq		hc4,t2
-	paddq		t2,t1
-	# d2 = t1[0] + t1[1]
-	movdqa		t1,t2
-	psrldq		$8,t2
-	paddq		t2,t1
-	movq		t1,d2
-
-	# t1 = [ hc0[1] * r3, hc0[0] * u3 ]
-	movdqa		ru3,t1
-	pmuludq		hc0,t1
-	# t1 += [ hc1[1] * r2, hc1[0] * u2 ]
-	movdqa		ru2,t2
-	pmuludq		hc1,t2
-	paddq		t2,t1
-	# t1 += [ hc2[1] * r1, hc2[0] * u1 ]
-	movdqa		ru1,t2
-	pmuludq		hc2,t2
-	paddq		t2,t1
-	# t1 += [ hc3[1] * r0, hc3[0] * u0 ]
-	movdqa		ru0,t2
-	pmuludq		hc3,t2
-	paddq		t2,t1
-	# t1 += [ hc4[1] * s4, hc4[0] * v4 ]
-	movdqa		sv4,t2
-	pmuludq		hc4,t2
-	paddq		t2,t1
-	# d3 = t1[0] + t1[1]
-	movdqa		t1,t2
-	psrldq		$8,t2
-	paddq		t2,t1
-	movq		t1,d3
-
-	# t1 = [ hc0[1] * r4, hc0[0] * u4 ]
-	movdqa		ru4,t1
-	pmuludq		hc0,t1
-	# t1 += [ hc1[1] * r3, hc1[0] * u3 ]
-	movdqa		ru3,t2
-	pmuludq		hc1,t2
-	paddq		t2,t1
-	# t1 += [ hc2[1] * r2, hc2[0] * u2 ]
-	movdqa		ru2,t2
-	pmuludq		hc2,t2
-	paddq		t2,t1
-	# t1 += [ hc3[1] * r1, hc3[0] * u1 ]
-	movdqa		ru1,t2
-	pmuludq		hc3,t2
-	paddq		t2,t1
-	# t1 += [ hc4[1] * r0, hc4[0] * u0 ]
-	movdqa		ru0,t2
-	pmuludq		hc4,t2
-	paddq		t2,t1
-	# d4 = t1[0] + t1[1]
-	movdqa		t1,t2
-	psrldq		$8,t2
-	paddq		t2,t1
-	movq		t1,d4
-
-	# Now do a partial reduction mod (2^130)-5, carrying h0 -> h1 -> h2 ->
-	# h3 -> h4 -> h0 -> h1 to get h0,h2,h3,h4 < 2^26 and h1 < 2^26 + a small
-	# amount.  Careful: we must not assume the carry bits 'd0 >> 26',
-	# 'd1 >> 26', 'd2 >> 26', 'd3 >> 26', and '(d4 >> 26) * 5' fit in 32-bit
-	# integers.  It's true in a single-block implementation, but not here.
-
-	# d1 += d0 >> 26
-	mov		d0,%rax
-	shr		$26,%rax
-	add		%rax,d1
-	# h0 = d0 & 0x3ffffff
-	mov		d0,%rbx
-	and		$0x3ffffff,%ebx
-
-	# d2 += d1 >> 26
-	mov		d1,%rax
-	shr		$26,%rax
-	add		%rax,d2
-	# h1 = d1 & 0x3ffffff
-	mov		d1,%rax
-	and		$0x3ffffff,%eax
-	mov		%eax,h1
-
-	# d3 += d2 >> 26
-	mov		d2,%rax
-	shr		$26,%rax
-	add		%rax,d3
-	# h2 = d2 & 0x3ffffff
-	mov		d2,%rax
-	and		$0x3ffffff,%eax
-	mov		%eax,h2
-
-	# d4 += d3 >> 26
-	mov		d3,%rax
-	shr		$26,%rax
-	add		%rax,d4
-	# h3 = d3 & 0x3ffffff
-	mov		d3,%rax
-	and		$0x3ffffff,%eax
-	mov		%eax,h3
-
-	# h0 += (d4 >> 26) * 5
-	mov		d4,%rax
-	shr		$26,%rax
-	lea		(%rax,%rax,4),%rax
-	add		%rax,%rbx
-	# h4 = d4 & 0x3ffffff
-	mov		d4,%rax
-	and		$0x3ffffff,%eax
-	mov		%eax,h4
-
-	# h1 += h0 >> 26
-	mov		%rbx,%rax
-	shr		$26,%rax
-	add		%eax,h1
-	# h0 = h0 & 0x3ffffff
-	andl		$0x3ffffff,%ebx
-	mov		%ebx,h0
-
-	add		$0x20,m
-	dec		%rcx
-	jnz		.Ldoblock2
-
-	pop		%r13
-	pop		%r12
-	pop		%rbx
-	ret
-SYM_FUNC_END(poly1305_2block_sse2)
diff --git a/arch/x86/crypto/poly1305-x86_64.pl b/arch/x86/crypto/poly1305-x86_64.pl
index 342ad7f18aa7..7a6b5380a46f 100644
--- a/arch/x86/crypto/poly1305-x86_64.pl
+++ b/arch/x86/crypto/poly1305-x86_64.pl
@@ -1,11 +1,14 @@
-#! /usr/bin/env perl
-# Copyright 2016-2018 The OpenSSL Project Authors. All Rights Reserved.
+#!/usr/bin/env perl
+# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 #
-# Licensed under the OpenSSL license (the "License").  You may not use
-# this file except in compliance with the License.  You can obtain a copy
-# in the file LICENSE in the source distribution or at
-# https://www.openssl.org/source/license.html
-
+# Copyright (C) 2017-2018 Samuel Neves <sneves@dei.uc.pt>. All Rights Reserved.
+# Copyright (C) 2017-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+# Copyright (C) 2006-2017 CRYPTOGAMS by <appro@openssl.org>. All Rights Reserved.
+#
+# This code is taken from the OpenSSL project but the author, Andy Polyakov,
+# has relicensed it under the licenses specified in the SPDX header above.
+# The original headers, including the original license headers, are
+# included below for completeness.
 #
 # ====================================================================
 # Written by Andy Polyakov <appro@openssl.org> for the OpenSSL
@@ -32,7 +35,7 @@
 # Skylake-X system performance. Since we are likely to suppress
 # AVX512F capability flag [at least on Skylake-X], conversion serves
 # as kind of "investment protection". Note that next *lake processor,
-# Cannolake, has AVX512IFMA code path to execute...
+# Cannonlake, has AVX512IFMA code path to execute...
 #
 # Numbers are cycles per processed byte with poly1305_blocks alone,
 # measured with rdtsc at fixed clock frequency.
@@ -68,39 +71,114 @@ $output  = shift;
 if ($flavour =~ /\./) { $output = $flavour; undef $flavour; }
 
 $win64=0; $win64=1 if ($flavour =~ /[nm]asm|mingw64/ || $output =~ /\.asm$/);
-
-$0 =~ m/(.*[\/\\])[^\/\\]+$/; $dir=$1;
-( $xlate="${dir}x86_64-xlate.pl" and -f $xlate ) or
-( $xlate="${dir}../../perlasm/x86_64-xlate.pl" and -f $xlate) or
-die "can't locate x86_64-xlate.pl";
-
-if (`$ENV{CC} -Wa,-v -c -o /dev/null -x assembler /dev/null 2>&1`
-		=~ /GNU assembler version ([2-9]\.[0-9]+)/) {
-	$avx = ($1>=2.19) + ($1>=2.22) + ($1>=2.25) + ($1>=2.26);
+$kernel=0; $kernel=1 if (!$flavour && !$output);
+
+if (!$kernel) {
+	$0 =~ m/(.*[\/\\])[^\/\\]+$/; $dir=$1;
+	( $xlate="${dir}x86_64-xlate.pl" and -f $xlate ) or
+	( $xlate="${dir}../../perlasm/x86_64-xlate.pl" and -f $xlate) or
+	die "can't locate x86_64-xlate.pl";
+
+	open OUT,"| \"$^X\" \"$xlate\" $flavour \"$output\"";
+	*STDOUT=*OUT;
+
+	if (`$ENV{CC} -Wa,-v -c -o /dev/null -x assembler /dev/null 2>&1`
+	    =~ /GNU assembler version ([2-9]\.[0-9]+)/) {
+		$avx = ($1>=2.19) + ($1>=2.22) + ($1>=2.25);
+	}
+
+	if (!$avx && $win64 && ($flavour =~ /nasm/ || $ENV{ASM} =~ /nasm/) &&
+	    `nasm -v 2>&1` =~ /NASM version ([2-9]\.[0-9]+)(?:\.([0-9]+))?/) {
+		$avx = ($1>=2.09) + ($1>=2.10) + ($1>=2.12);
+		$avx += 1 if ($1==2.11 && $2>=8);
+	}
+
+	if (!$avx && $win64 && ($flavour =~ /masm/ || $ENV{ASM} =~ /ml64/) &&
+	    `ml64 2>&1` =~ /Version ([0-9]+)\./) {
+		$avx = ($1>=10) + ($1>=11);
+	}
+
+	if (!$avx && `$ENV{CC} -v 2>&1` =~ /((?:^clang|LLVM) version|.*based on LLVM) ([3-9]\.[0-9]+)/) {
+		$avx = ($2>=3.0) + ($2>3.0);
+	}
+} else {
+	$avx = 4; # The kernel uses ifdefs for this.
 }
 
-if (!$avx && $win64 && ($flavour =~ /nasm/ || $ENV{ASM} =~ /nasm/) &&
-	   `nasm -v 2>&1` =~ /NASM version ([2-9]\.[0-9]+)(?:\.([0-9]+))?/) {
-	$avx = ($1>=2.09) + ($1>=2.10) + 2 * ($1>=2.12);
-	$avx += 2 if ($1==2.11 && $2>=8);
+sub declare_function() {
+	my ($name, $align, $nargs) = @_;
+	if($kernel) {
+		$code .= ".align $align\n";
+		$code .= "SYM_FUNC_START($name)\n";
+		$code .= ".L$name:\n";
+	} else {
+		$code .= ".globl	$name\n";
+		$code .= ".type	$name,\@function,$nargs\n";
+		$code .= ".align	$align\n";
+		$code .= "$name:\n";
+	}
 }
 
-if (!$avx && $win64 && ($flavour =~ /masm/ || $ENV{ASM} =~ /ml64/) &&
-	   `ml64 2>&1` =~ /Version ([0-9]+)\./) {
-	$avx = ($1>=10) + ($1>=12);
+sub end_function() {
+	my ($name) = @_;
+	if($kernel) {
+		$code .= "SYM_FUNC_END($name)\n";
+	} else {
+		$code .= ".size   $name,.-$name\n";
+	}
 }
 
-if (!$avx && `$ENV{CC} -v 2>&1` =~ /((?:^clang|LLVM) version|.*based on LLVM) ([3-9]\.[0-9]+)/) {
-	$avx = ($2>=3.0) + ($2>3.0);
-}
+$code.=<<___ if $kernel;
+#include <linux/linkage.h>
+___
+
+if ($avx) {
+$code.=<<___ if $kernel;
+.section .rodata
+___
+$code.=<<___;
+.align	64
+.Lconst:
+.Lmask24:
+.long	0x0ffffff,0,0x0ffffff,0,0x0ffffff,0,0x0ffffff,0
+.L129:
+.long	`1<<24`,0,`1<<24`,0,`1<<24`,0,`1<<24`,0
+.Lmask26:
+.long	0x3ffffff,0,0x3ffffff,0,0x3ffffff,0,0x3ffffff,0
+.Lpermd_avx2:
+.long	2,2,2,3,2,0,2,1
+.Lpermd_avx512:
+.long	0,0,0,1, 0,2,0,3, 0,4,0,5, 0,6,0,7
+
+.L2_44_inp_permd:
+.long	0,1,1,2,2,3,7,7
+.L2_44_inp_shift:
+.quad	0,12,24,64
+.L2_44_mask:
+.quad	0xfffffffffff,0xfffffffffff,0x3ffffffffff,0xffffffffffffffff
+.L2_44_shift_rgt:
+.quad	44,44,42,64
+.L2_44_shift_lft:
+.quad	8,8,10,64
 
-open OUT,"| \"$^X\" \"$xlate\" $flavour \"$output\"";
-*STDOUT=*OUT;
+.align	64
+.Lx_mask44:
+.quad	0xfffffffffff,0xfffffffffff,0xfffffffffff,0xfffffffffff
+.quad	0xfffffffffff,0xfffffffffff,0xfffffffffff,0xfffffffffff
+.Lx_mask42:
+.quad	0x3ffffffffff,0x3ffffffffff,0x3ffffffffff,0x3ffffffffff
+.quad	0x3ffffffffff,0x3ffffffffff,0x3ffffffffff,0x3ffffffffff
+___
+}
+$code.=<<___ if (!$kernel);
+.asciz	"Poly1305 for x86_64, CRYPTOGAMS by <appro\@openssl.org>"
+.align	16
+___
 
 my ($ctx,$inp,$len,$padbit)=("%rdi","%rsi","%rdx","%rcx");
 my ($mac,$nonce)=($inp,$len);	# *_emit arguments
-my ($d1,$d2,$d3, $r0,$r1,$s1)=map("%r$_",(8..13));
-my ($h0,$h1,$h2)=("%r14","%rbx","%rbp");
+my ($d1,$d2,$d3, $r0,$r1,$s1)=("%r8","%r9","%rdi","%r11","%r12","%r13");
+my ($h0,$h1,$h2)=("%r14","%rbx","%r10");
 
 sub poly1305_iteration {
 # input:	copy of $r1 in %rax, $h0-$h2, $r0-$r1
@@ -155,19 +233,19 @@ ___
 
 $code.=<<___;
 .text
-
+___
+$code.=<<___ if (!$kernel);
 .extern	OPENSSL_ia32cap_P
 
-.globl	poly1305_init
-.hidden	poly1305_init
-.globl	poly1305_blocks
-.hidden	poly1305_blocks
-.globl	poly1305_emit
-.hidden	poly1305_emit
-
-.type	poly1305_init,\@function,3
-.align	32
-poly1305_init:
+.globl	poly1305_init_x86_64
+.hidden	poly1305_init_x86_64
+.globl	poly1305_blocks_x86_64
+.hidden	poly1305_blocks_x86_64
+.globl	poly1305_emit_x86_64
+.hidden	poly1305_emit_x86_64
+___
+&declare_function("poly1305_init_x86_64", 32, 3);
+$code.=<<___;
 	xor	%rax,%rax
 	mov	%rax,0($ctx)		# initialize hash value
 	mov	%rax,8($ctx)
@@ -175,11 +253,12 @@ poly1305_init:
 
 	cmp	\$0,$inp
 	je	.Lno_key
-
-	lea	poly1305_blocks(%rip),%r10
-	lea	poly1305_emit(%rip),%r11
 ___
-$code.=<<___	if ($avx);
+$code.=<<___ if (!$kernel);
+	lea	poly1305_blocks_x86_64(%rip),%r10
+	lea	poly1305_emit_x86_64(%rip),%r11
+___
+$code.=<<___	if (!$kernel && $avx);
 	mov	OPENSSL_ia32cap_P+4(%rip),%r9
 	lea	poly1305_blocks_avx(%rip),%rax
 	lea	poly1305_emit_avx(%rip),%rcx
@@ -187,12 +266,12 @@ $code.=<<___	if ($avx);
 	cmovc	%rax,%r10
 	cmovc	%rcx,%r11
 ___
-$code.=<<___	if ($avx>1);
+$code.=<<___	if (!$kernel && $avx>1);
 	lea	poly1305_blocks_avx2(%rip),%rax
 	bt	\$`5+32`,%r9		# AVX2?
 	cmovc	%rax,%r10
 ___
-$code.=<<___	if ($avx>3);
+$code.=<<___	if (!$kernel && $avx>3);
 	mov	\$`(1<<31|1<<21|1<<16)`,%rax
 	shr	\$32,%r9
 	and	%rax,%r9
@@ -207,11 +286,11 @@ $code.=<<___;
 	mov	%rax,24($ctx)
 	mov	%rcx,32($ctx)
 ___
-$code.=<<___	if ($flavour !~ /elf32/);
+$code.=<<___	if (!$kernel && $flavour !~ /elf32/);
 	mov	%r10,0(%rdx)
 	mov	%r11,8(%rdx)
 ___
-$code.=<<___	if ($flavour =~ /elf32/);
+$code.=<<___	if (!$kernel && $flavour =~ /elf32/);
 	mov	%r10d,0(%rdx)
 	mov	%r11d,4(%rdx)
 ___
@@ -219,11 +298,11 @@ $code.=<<___;
 	mov	\$1,%eax
 .Lno_key:
 	ret
-.size	poly1305_init,.-poly1305_init
+___
+&end_function("poly1305_init_x86_64");
 
-.type	poly1305_blocks,\@function,4
-.align	32
-poly1305_blocks:
+&declare_function("poly1305_blocks_x86_64", 32, 4);
+$code.=<<___;
 .cfi_startproc
 .Lblocks:
 	shr	\$4,$len
@@ -231,8 +310,6 @@ poly1305_blocks:
 
 	push	%rbx
 .cfi_push	%rbx
-	push	%rbp
-.cfi_push	%rbp
 	push	%r12
 .cfi_push	%r12
 	push	%r13
@@ -241,6 +318,8 @@ poly1305_blocks:
 .cfi_push	%r14
 	push	%r15
 .cfi_push	%r15
+	push	$ctx
+.cfi_push	$ctx
 .Lblocks_body:
 
 	mov	$len,%r15		# reassign $len
@@ -265,26 +344,29 @@ poly1305_blocks:
 	lea	16($inp),$inp
 	adc	$padbit,$h2
 ___
+
 	&poly1305_iteration();
+
 $code.=<<___;
 	mov	$r1,%rax
 	dec	%r15			# len-=16
 	jnz	.Loop
 
+	mov	0(%rsp),$ctx
+.cfi_restore	$ctx
+
 	mov	$h0,0($ctx)		# store hash value
 	mov	$h1,8($ctx)
 	mov	$h2,16($ctx)
 
-	mov	0(%rsp),%r15
+	mov	8(%rsp),%r15
 .cfi_restore	%r15
-	mov	8(%rsp),%r14
+	mov	16(%rsp),%r14
 .cfi_restore	%r14
-	mov	16(%rsp),%r13
+	mov	24(%rsp),%r13
 .cfi_restore	%r13
-	mov	24(%rsp),%r12
+	mov	32(%rsp),%r12
 .cfi_restore	%r12
-	mov	32(%rsp),%rbp
-.cfi_restore	%rbp
 	mov	40(%rsp),%rbx
 .cfi_restore	%rbx
 	lea	48(%rsp),%rsp
@@ -293,11 +375,11 @@ $code.=<<___;
 .Lblocks_epilogue:
 	ret
 .cfi_endproc
-.size	poly1305_blocks,.-poly1305_blocks
+___
+&end_function("poly1305_blocks_x86_64");
 
-.type	poly1305_emit,\@function,3
-.align	32
-poly1305_emit:
+&declare_function("poly1305_emit_x86_64", 32, 3);
+$code.=<<___;
 .Lemit:
 	mov	0($ctx),%r8	# load hash value
 	mov	8($ctx),%r9
@@ -318,10 +400,14 @@ poly1305_emit:
 	mov	%rcx,8($mac)
 
 	ret
-.size	poly1305_emit,.-poly1305_emit
 ___
+&end_function("poly1305_emit_x86_64");
 if ($avx) {
 
+if($kernel) {
+	$code .= "#ifdef CONFIG_AS_AVX\n";
+}
+
 ########################################################################
 # Layout of opaque area is following.
 #
@@ -342,15 +428,19 @@ $code.=<<___;
 .type	__poly1305_block,\@abi-omnipotent
 .align	32
 __poly1305_block:
+	push $ctx
 ___
 	&poly1305_iteration();
 $code.=<<___;
+	pop $ctx
 	ret
 .size	__poly1305_block,.-__poly1305_block
 
 .type	__poly1305_init_avx,\@abi-omnipotent
 .align	32
 __poly1305_init_avx:
+	push %rbp
+	mov %rsp,%rbp
 	mov	$r0,$h0
 	mov	$r1,$h1
 	xor	$h2,$h2
@@ -507,12 +597,13 @@ __poly1305_init_avx:
 	mov	$d1#d,`16*8+8-64`($ctx)
 
 	lea	-48-64($ctx),$ctx	# size [de-]optimization
+	pop %rbp
 	ret
 .size	__poly1305_init_avx,.-__poly1305_init_avx
+___
 
-.type	poly1305_blocks_avx,\@function,4
-.align	32
-poly1305_blocks_avx:
+&declare_function("poly1305_blocks_avx", 32, 4);
+$code.=<<___;
 .cfi_startproc
 	mov	20($ctx),%r8d		# is_base2_26
 	cmp	\$128,$len
@@ -532,10 +623,11 @@ poly1305_blocks_avx:
 	test	\$31,$len
 	jz	.Leven_avx
 
-	push	%rbx
-.cfi_push	%rbx
 	push	%rbp
 .cfi_push	%rbp
+	mov 	%rsp,%rbp
+	push	%rbx
+.cfi_push	%rbx
 	push	%r12
 .cfi_push	%r12
 	push	%r13
@@ -645,20 +737,18 @@ poly1305_blocks_avx:
 	mov	$h2#d,16($ctx)
 .align	16
 .Ldone_avx:
-	mov	0(%rsp),%r15
+	pop 		%r15
 .cfi_restore	%r15
-	mov	8(%rsp),%r14
+	pop 		%r14
 .cfi_restore	%r14
-	mov	16(%rsp),%r13
+	pop 		%r13
 .cfi_restore	%r13
-	mov	24(%rsp),%r12
+	pop 		%r12
 .cfi_restore	%r12
-	mov	32(%rsp),%rbp
-.cfi_restore	%rbp
-	mov	40(%rsp),%rbx
+	pop 		%rbx
 .cfi_restore	%rbx
-	lea	48(%rsp),%rsp
-.cfi_adjust_cfa_offset	-48
+	pop 		%rbp
+.cfi_restore	%rbp
 .Lno_data_avx:
 .Lblocks_avx_epilogue:
 	ret
@@ -667,10 +757,11 @@ poly1305_blocks_avx:
 .align	32
 .Lbase2_64_avx:
 .cfi_startproc
-	push	%rbx
-.cfi_push	%rbx
 	push	%rbp
 .cfi_push	%rbp
+	mov 	%rsp,%rbp
+	push	%rbx
+.cfi_push	%rbx
 	push	%r12
 .cfi_push	%r12
 	push	%r13
@@ -736,22 +827,18 @@ poly1305_blocks_avx:
 
 .Lproceed_avx:
 	mov	%r15,$len
-
-	mov	0(%rsp),%r15
+	pop 		%r15
 .cfi_restore	%r15
-	mov	8(%rsp),%r14
+	pop 		%r14
 .cfi_restore	%r14
-	mov	16(%rsp),%r13
+	pop 		%r13
 .cfi_restore	%r13
-	mov	24(%rsp),%r12
+	pop 		%r12
 .cfi_restore	%r12
-	mov	32(%rsp),%rbp
-.cfi_restore	%rbp
-	mov	40(%rsp),%rbx
+	pop 		%rbx
 .cfi_restore	%rbx
-	lea	48(%rsp),%rax
-	lea	48(%rsp),%rsp
-.cfi_adjust_cfa_offset	-48
+	pop 		%rbp
+.cfi_restore	%rbp
 .Lbase2_64_avx_epilogue:
 	jmp	.Ldo_avx
 .cfi_endproc
@@ -768,8 +855,11 @@ poly1305_blocks_avx:
 .Ldo_avx:
 ___
 $code.=<<___	if (!$win64);
+	lea		8(%rsp),%r10
+.cfi_def_cfa_register	%r10
+	and		\$-32,%rsp
+	sub		\$-8,%rsp
 	lea		-0x58(%rsp),%r11
-.cfi_def_cfa		%r11,0x60
 	sub		\$0x178,%rsp
 ___
 $code.=<<___	if ($win64);
@@ -1361,18 +1451,18 @@ $code.=<<___	if ($win64);
 .Ldo_avx_epilogue:
 ___
 $code.=<<___	if (!$win64);
-	lea		0x58(%r11),%rsp
-.cfi_def_cfa		%rsp,8
+	lea		-8(%r10),%rsp
+.cfi_def_cfa_register	%rsp
 ___
 $code.=<<___;
 	vzeroupper
 	ret
 .cfi_endproc
-.size	poly1305_blocks_avx,.-poly1305_blocks_avx
+___
+&end_function("poly1305_blocks_avx");
 
-.type	poly1305_emit_avx,\@function,3
-.align	32
-poly1305_emit_avx:
+&declare_function("poly1305_emit_avx", 32, 3);
+$code.=<<___;
 	cmpl	\$0,20($ctx)	# is_base2_26?
 	je	.Lemit
 
@@ -1423,41 +1513,51 @@ poly1305_emit_avx:
 	mov	%rcx,8($mac)
 
 	ret
-.size	poly1305_emit_avx,.-poly1305_emit_avx
 ___
+&end_function("poly1305_emit_avx");
+
+if ($kernel) {
+	$code .= "#endif\n";
+}
 
 if ($avx>1) {
+
+if ($kernel) {
+	$code .= "#ifdef CONFIG_AS_AVX2\n";
+}
+
 my ($H0,$H1,$H2,$H3,$H4, $MASK, $T4,$T0,$T1,$T2,$T3, $D0,$D1,$D2,$D3,$D4) =
     map("%ymm$_",(0..15));
 my $S4=$MASK;
 
+sub poly1305_blocks_avxN {
+	my ($avx512) = @_;
+	my $suffix = $avx512 ? "_avx512" : "";
 $code.=<<___;
-.type	poly1305_blocks_avx2,\@function,4
-.align	32
-poly1305_blocks_avx2:
 .cfi_startproc
 	mov	20($ctx),%r8d		# is_base2_26
 	cmp	\$128,$len
-	jae	.Lblocks_avx2
+	jae	.Lblocks_avx2$suffix
 	test	%r8d,%r8d
 	jz	.Lblocks
 
-.Lblocks_avx2:
+.Lblocks_avx2$suffix:
 	and	\$-16,$len
-	jz	.Lno_data_avx2
+	jz	.Lno_data_avx2$suffix
 
 	vzeroupper
 
 	test	%r8d,%r8d
-	jz	.Lbase2_64_avx2
+	jz	.Lbase2_64_avx2$suffix
 
 	test	\$63,$len
-	jz	.Leven_avx2
+	jz	.Leven_avx2$suffix
 
-	push	%rbx
-.cfi_push	%rbx
 	push	%rbp
 .cfi_push	%rbp
+	mov 	%rsp,%rbp
+	push	%rbx
+.cfi_push	%rbx
 	push	%r12
 .cfi_push	%r12
 	push	%r13
@@ -1466,7 +1566,7 @@ poly1305_blocks_avx2:
 .cfi_push	%r14
 	push	%r15
 .cfi_push	%r15
-.Lblocks_avx2_body:
+.Lblocks_avx2_body$suffix:
 
 	mov	$len,%r15		# reassign $len
 
@@ -1513,7 +1613,7 @@ poly1305_blocks_avx2:
 	shr	\$2,$s1
 	add	$r1,$s1			# s1 = r1 + (r1 >> 2)
 
-.Lbase2_26_pre_avx2:
+.Lbase2_26_pre_avx2$suffix:
 	add	0($inp),$h0		# accumulate input
 	adc	8($inp),$h1
 	lea	16($inp),$inp
@@ -1524,10 +1624,10 @@ poly1305_blocks_avx2:
 	mov	$r1,%rax
 
 	test	\$63,%r15
-	jnz	.Lbase2_26_pre_avx2
+	jnz	.Lbase2_26_pre_avx2$suffix
 
 	test	$padbit,$padbit		# if $padbit is zero,
-	jz	.Lstore_base2_64_avx2	# store hash in base 2^64 format
+	jz	.Lstore_base2_64_avx2$suffix	# store hash in base 2^64 format
 
 	################################# base 2^64 -> base 2^26
 	mov	$h0,%rax
@@ -1548,57 +1648,56 @@ poly1305_blocks_avx2:
 	or	$r1,$h2			# h[4]
 
 	test	%r15,%r15
-	jz	.Lstore_base2_26_avx2
+	jz	.Lstore_base2_26_avx2$suffix
 
 	vmovd	%rax#d,%x#$H0
 	vmovd	%rdx#d,%x#$H1
 	vmovd	$h0#d,%x#$H2
 	vmovd	$h1#d,%x#$H3
 	vmovd	$h2#d,%x#$H4
-	jmp	.Lproceed_avx2
+	jmp	.Lproceed_avx2$suffix
 
 .align	32
-.Lstore_base2_64_avx2:
+.Lstore_base2_64_avx2$suffix:
 	mov	$h0,0($ctx)
 	mov	$h1,8($ctx)
 	mov	$h2,16($ctx)		# note that is_base2_26 is zeroed
-	jmp	.Ldone_avx2
+	jmp	.Ldone_avx2$suffix
 
 .align	16
-.Lstore_base2_26_avx2:
+.Lstore_base2_26_avx2$suffix:
 	mov	%rax#d,0($ctx)		# store hash value base 2^26
 	mov	%rdx#d,4($ctx)
 	mov	$h0#d,8($ctx)
 	mov	$h1#d,12($ctx)
 	mov	$h2#d,16($ctx)
 .align	16
-.Ldone_avx2:
-	mov	0(%rsp),%r15
+.Ldone_avx2$suffix:
+	pop 		%r15
 .cfi_restore	%r15
-	mov	8(%rsp),%r14
+	pop 		%r14
 .cfi_restore	%r14
-	mov	16(%rsp),%r13
+	pop 		%r13
 .cfi_restore	%r13
-	mov	24(%rsp),%r12
+	pop 		%r12
 .cfi_restore	%r12
-	mov	32(%rsp),%rbp
-.cfi_restore	%rbp
-	mov	40(%rsp),%rbx
+	pop 		%rbx
 .cfi_restore	%rbx
-	lea	48(%rsp),%rsp
-.cfi_adjust_cfa_offset	-48
-.Lno_data_avx2:
-.Lblocks_avx2_epilogue:
+	pop 		%rbp
+.cfi_restore 	%rbp
+.Lno_data_avx2$suffix:
+.Lblocks_avx2_epilogue$suffix:
 	ret
 .cfi_endproc
 
 .align	32
-.Lbase2_64_avx2:
+.Lbase2_64_avx2$suffix:
 .cfi_startproc
-	push	%rbx
-.cfi_push	%rbx
 	push	%rbp
 .cfi_push	%rbp
+	mov 	%rsp,%rbp
+	push	%rbx
+.cfi_push	%rbx
 	push	%r12
 .cfi_push	%r12
 	push	%r13
@@ -1607,7 +1706,7 @@ poly1305_blocks_avx2:
 .cfi_push	%r14
 	push	%r15
 .cfi_push	%r15
-.Lbase2_64_avx2_body:
+.Lbase2_64_avx2_body$suffix:
 
 	mov	$len,%r15		# reassign $len
 
@@ -1624,9 +1723,9 @@ poly1305_blocks_avx2:
 	add	$r1,$s1			# s1 = r1 + (r1 >> 2)
 
 	test	\$63,$len
-	jz	.Linit_avx2
+	jz	.Linit_avx2$suffix
 
-.Lbase2_64_pre_avx2:
+.Lbase2_64_pre_avx2$suffix:
 	add	0($inp),$h0		# accumulate input
 	adc	8($inp),$h1
 	lea	16($inp),$inp
@@ -1637,9 +1736,9 @@ poly1305_blocks_avx2:
 	mov	$r1,%rax
 
 	test	\$63,%r15
-	jnz	.Lbase2_64_pre_avx2
+	jnz	.Lbase2_64_pre_avx2$suffix
 
-.Linit_avx2:
+.Linit_avx2$suffix:
 	################################# base 2^64 -> base 2^26
 	mov	$h0,%rax
 	mov	$h0,%rdx
@@ -1667,69 +1766,77 @@ poly1305_blocks_avx2:
 
 	call	__poly1305_init_avx
 
-.Lproceed_avx2:
+.Lproceed_avx2$suffix:
 	mov	%r15,$len			# restore $len
-	mov	OPENSSL_ia32cap_P+8(%rip),%r10d
+___
+$code.=<<___ if (!$kernel);
+	mov	OPENSSL_ia32cap_P+8(%rip),%r9d
 	mov	\$`(1<<31|1<<30|1<<16)`,%r11d
-
-	mov	0(%rsp),%r15
+___
+$code.=<<___;
+	pop 		%r15
 .cfi_restore	%r15
-	mov	8(%rsp),%r14
+	pop 		%r14
 .cfi_restore	%r14
-	mov	16(%rsp),%r13
+	pop 		%r13
 .cfi_restore	%r13
-	mov	24(%rsp),%r12
+	pop 		%r12
 .cfi_restore	%r12
-	mov	32(%rsp),%rbp
-.cfi_restore	%rbp
-	mov	40(%rsp),%rbx
+	pop 		%rbx
 .cfi_restore	%rbx
-	lea	48(%rsp),%rax
-	lea	48(%rsp),%rsp
-.cfi_adjust_cfa_offset	-48
-.Lbase2_64_avx2_epilogue:
-	jmp	.Ldo_avx2
+	pop 		%rbp
+.cfi_restore 	%rbp
+.Lbase2_64_avx2_epilogue$suffix:
+	jmp	.Ldo_avx2$suffix
 .cfi_endproc
 
 .align	32
-.Leven_avx2:
+.Leven_avx2$suffix:
 .cfi_startproc
-	mov		OPENSSL_ia32cap_P+8(%rip),%r10d
+___
+$code.=<<___ if (!$kernel);
+	mov		OPENSSL_ia32cap_P+8(%rip),%r9d
+___
+$code.=<<___;
 	vmovd		4*0($ctx),%x#$H0	# load hash value base 2^26
 	vmovd		4*1($ctx),%x#$H1
 	vmovd		4*2($ctx),%x#$H2
 	vmovd		4*3($ctx),%x#$H3
 	vmovd		4*4($ctx),%x#$H4
 
-.Ldo_avx2:
+.Ldo_avx2$suffix:
 ___
-$code.=<<___		if ($avx>2);
+$code.=<<___		if (!$kernel && $avx>2);
 	cmp		\$512,$len
 	jb		.Lskip_avx512
-	and		%r11d,%r10d
-	test		\$`1<<16`,%r10d		# check for AVX512F
+	and		%r11d,%r9d
+	test		\$`1<<16`,%r9d		# check for AVX512F
 	jnz		.Lblocks_avx512
-.Lskip_avx512:
+.Lskip_avx512$suffix:
+___
+$code.=<<___ if ($avx > 2 && $avx512 && $kernel);
+	cmp		\$512,$len
+	jae		.Lblocks_avx512
 ___
 $code.=<<___	if (!$win64);
-	lea		-8(%rsp),%r11
-.cfi_def_cfa		%r11,16
+	lea		8(%rsp),%r10
+.cfi_def_cfa_register	%r10
 	sub		\$0x128,%rsp
 ___
 $code.=<<___	if ($win64);
-	lea		-0xf8(%rsp),%r11
+	lea		8(%rsp),%r10
 	sub		\$0x1c8,%rsp
-	vmovdqa		%xmm6,0x50(%r11)
-	vmovdqa		%xmm7,0x60(%r11)
-	vmovdqa		%xmm8,0x70(%r11)
-	vmovdqa		%xmm9,0x80(%r11)
-	vmovdqa		%xmm10,0x90(%r11)
-	vmovdqa		%xmm11,0xa0(%r11)
-	vmovdqa		%xmm12,0xb0(%r11)
-	vmovdqa		%xmm13,0xc0(%r11)
-	vmovdqa		%xmm14,0xd0(%r11)
-	vmovdqa		%xmm15,0xe0(%r11)
-.Ldo_avx2_body:
+	vmovdqa		%xmm6,-0xb0(%r10)
+	vmovdqa		%xmm7,-0xa0(%r10)
+	vmovdqa		%xmm8,-0x90(%r10)
+	vmovdqa		%xmm9,-0x80(%r10)
+	vmovdqa		%xmm10,-0x70(%r10)
+	vmovdqa		%xmm11,-0x60(%r10)
+	vmovdqa		%xmm12,-0x50(%r10)
+	vmovdqa		%xmm13,-0x40(%r10)
+	vmovdqa		%xmm14,-0x30(%r10)
+	vmovdqa		%xmm15,-0x20(%r10)
+.Ldo_avx2_body$suffix:
 ___
 $code.=<<___;
 	lea		.Lconst(%rip),%rcx
@@ -1794,11 +1901,11 @@ $code.=<<___;
 
 	vpaddq		$H2,$T2,$H2		# accumulate input
 	sub		\$64,$len
-	jz		.Ltail_avx2
-	jmp		.Loop_avx2
+	jz		.Ltail_avx2$suffix
+	jmp		.Loop_avx2$suffix
 
 .align	32
-.Loop_avx2:
+.Loop_avx2$suffix:
 	################################################################
 	# ((inp[0]*r^4+inp[4])*r^4+inp[ 8])*r^4
 	# ((inp[1]*r^4+inp[5])*r^4+inp[ 9])*r^3
@@ -1946,10 +2053,10 @@ $code.=<<___;
 	 vpor		32(%rcx),$T4,$T4	# padbit, yes, always
 
 	sub		\$64,$len
-	jnz		.Loop_avx2
+	jnz		.Loop_avx2$suffix
 
 	.byte		0x66,0x90
-.Ltail_avx2:
+.Ltail_avx2$suffix:
 	################################################################
 	# while above multiplications were by r^4 in all lanes, in last
 	# iteration we multiply least significant lane by r^4 and most
@@ -2087,37 +2194,29 @@ $code.=<<___;
 	vmovd		%x#$H4,`4*4-48-64`($ctx)
 ___
 $code.=<<___	if ($win64);
-	vmovdqa		0x50(%r11),%xmm6
-	vmovdqa		0x60(%r11),%xmm7
-	vmovdqa		0x70(%r11),%xmm8
-	vmovdqa		0x80(%r11),%xmm9
-	vmovdqa		0x90(%r11),%xmm10
-	vmovdqa		0xa0(%r11),%xmm11
-	vmovdqa		0xb0(%r11),%xmm12
-	vmovdqa		0xc0(%r11),%xmm13
-	vmovdqa		0xd0(%r11),%xmm14
-	vmovdqa		0xe0(%r11),%xmm15
-	lea		0xf8(%r11),%rsp
-.Ldo_avx2_epilogue:
+	vmovdqa		-0xb0(%r10),%xmm6
+	vmovdqa		-0xa0(%r10),%xmm7
+	vmovdqa		-0x90(%r10),%xmm8
+	vmovdqa		-0x80(%r10),%xmm9
+	vmovdqa		-0x70(%r10),%xmm10
+	vmovdqa		-0x60(%r10),%xmm11
+	vmovdqa		-0x50(%r10),%xmm12
+	vmovdqa		-0x40(%r10),%xmm13
+	vmovdqa		-0x30(%r10),%xmm14
+	vmovdqa		-0x20(%r10),%xmm15
+	lea		-8(%r10),%rsp
+.Ldo_avx2_epilogue$suffix:
 ___
 $code.=<<___	if (!$win64);
-	lea		8(%r11),%rsp
-.cfi_def_cfa		%rsp,8
+	lea		-8(%r10),%rsp
+.cfi_def_cfa_register	%rsp
 ___
 $code.=<<___;
 	vzeroupper
 	ret
 .cfi_endproc
-.size	poly1305_blocks_avx2,.-poly1305_blocks_avx2
 ___
-#######################################################################
-if ($avx>2) {
-# On entry we have input length divisible by 64. But since inner loop
-# processes 128 bytes per iteration, cases when length is not divisible
-# by 128 are handled by passing tail 64 bytes to .Ltail_avx2. For this
-# reason stack layout is kept identical to poly1305_blocks_avx2. If not
-# for this tail, we wouldn't have to even allocate stack frame...
-
+if($avx > 2 && $avx512) {
 my ($R0,$R1,$R2,$R3,$R4, $S1,$S2,$S3,$S4) = map("%zmm$_",(16..24));
 my ($M0,$M1,$M2,$M3,$M4) = map("%zmm$_",(25..29));
 my $PADBIT="%zmm30";
@@ -2128,32 +2227,29 @@ map(s/%y/%z/,($H0,$H1,$H2,$H3,$H4));
 map(s/%y/%z/,($MASK));
 
 $code.=<<___;
-.type	poly1305_blocks_avx512,\@function,4
-.align	32
-poly1305_blocks_avx512:
 .cfi_startproc
 .Lblocks_avx512:
 	mov		\$15,%eax
 	kmovw		%eax,%k2
 ___
 $code.=<<___	if (!$win64);
-	lea		-8(%rsp),%r11
-.cfi_def_cfa		%r11,16
+	lea		8(%rsp),%r10
+.cfi_def_cfa_register	%r10
 	sub		\$0x128,%rsp
 ___
 $code.=<<___	if ($win64);
-	lea		-0xf8(%rsp),%r11
+	lea		8(%rsp),%r10
 	sub		\$0x1c8,%rsp
-	vmovdqa		%xmm6,0x50(%r11)
-	vmovdqa		%xmm7,0x60(%r11)
-	vmovdqa		%xmm8,0x70(%r11)
-	vmovdqa		%xmm9,0x80(%r11)
-	vmovdqa		%xmm10,0x90(%r11)
-	vmovdqa		%xmm11,0xa0(%r11)
-	vmovdqa		%xmm12,0xb0(%r11)
-	vmovdqa		%xmm13,0xc0(%r11)
-	vmovdqa		%xmm14,0xd0(%r11)
-	vmovdqa		%xmm15,0xe0(%r11)
+	vmovdqa		%xmm6,-0xb0(%r10)
+	vmovdqa		%xmm7,-0xa0(%r10)
+	vmovdqa		%xmm8,-0x90(%r10)
+	vmovdqa		%xmm9,-0x80(%r10)
+	vmovdqa		%xmm10,-0x70(%r10)
+	vmovdqa		%xmm11,-0x60(%r10)
+	vmovdqa		%xmm12,-0x50(%r10)
+	vmovdqa		%xmm13,-0x40(%r10)
+	vmovdqa		%xmm14,-0x30(%r10)
+	vmovdqa		%xmm15,-0x20(%r10)
 .Ldo_avx512_body:
 ___
 $code.=<<___;
@@ -2679,7 +2775,7 @@ $code.=<<___;
 
 	lea		0x90(%rsp),%rax		# size optimization for .Ltail_avx2
 	add		\$64,$len
-	jnz		.Ltail_avx2
+	jnz		.Ltail_avx2$suffix
 
 	vpsubq		$T2,$H2,$H2		# undo input accumulation
 	vmovd		%x#$H0,`4*0-48-64`($ctx)# save partially reduced
@@ -2690,29 +2786,61 @@ $code.=<<___;
 	vzeroall
 ___
 $code.=<<___	if ($win64);
-	movdqa		0x50(%r11),%xmm6
-	movdqa		0x60(%r11),%xmm7
-	movdqa		0x70(%r11),%xmm8
-	movdqa		0x80(%r11),%xmm9
-	movdqa		0x90(%r11),%xmm10
-	movdqa		0xa0(%r11),%xmm11
-	movdqa		0xb0(%r11),%xmm12
-	movdqa		0xc0(%r11),%xmm13
-	movdqa		0xd0(%r11),%xmm14
-	movdqa		0xe0(%r11),%xmm15
-	lea		0xf8(%r11),%rsp
+	movdqa		-0xb0(%r10),%xmm6
+	movdqa		-0xa0(%r10),%xmm7
+	movdqa		-0x90(%r10),%xmm8
+	movdqa		-0x80(%r10),%xmm9
+	movdqa		-0x70(%r10),%xmm10
+	movdqa		-0x60(%r10),%xmm11
+	movdqa		-0x50(%r10),%xmm12
+	movdqa		-0x40(%r10),%xmm13
+	movdqa		-0x30(%r10),%xmm14
+	movdqa		-0x20(%r10),%xmm15
+	lea		-8(%r10),%rsp
 .Ldo_avx512_epilogue:
 ___
 $code.=<<___	if (!$win64);
-	lea		8(%r11),%rsp
-.cfi_def_cfa		%rsp,8
+	lea		-8(%r10),%rsp
+.cfi_def_cfa_register	%rsp
 ___
 $code.=<<___;
 	ret
 .cfi_endproc
-.size	poly1305_blocks_avx512,.-poly1305_blocks_avx512
 ___
-if ($avx>3) {
+
+}
+
+}
+
+&declare_function("poly1305_blocks_avx2", 32, 4);
+poly1305_blocks_avxN(0);
+&end_function("poly1305_blocks_avx2");
+
+if($kernel) {
+	$code .= "#endif\n";
+}
+
+#######################################################################
+if ($avx>2) {
+# On entry we have input length divisible by 64. But since inner loop
+# processes 128 bytes per iteration, cases when length is not divisible
+# by 128 are handled by passing tail 64 bytes to .Ltail_avx2. For this
+# reason stack layout is kept identical to poly1305_blocks_avx2. If not
+# for this tail, we wouldn't have to even allocate stack frame...
+
+if($kernel) {
+	$code .= "#ifdef CONFIG_AS_AVX512\n";
+}
+
+&declare_function("poly1305_blocks_avx512", 32, 4);
+poly1305_blocks_avxN(1);
+&end_function("poly1305_blocks_avx512");
+
+if ($kernel) {
+	$code .= "#endif\n";
+}
+
+if (!$kernel && $avx>3) {
 ########################################################################
 # VPMADD52 version using 2^44 radix.
 #
@@ -3753,45 +3881,9 @@ poly1305_emit_base2_44:
 .size	poly1305_emit_base2_44,.-poly1305_emit_base2_44
 ___
 }	}	}
-$code.=<<___;
-.align	64
-.Lconst:
-.Lmask24:
-.long	0x0ffffff,0,0x0ffffff,0,0x0ffffff,0,0x0ffffff,0
-.L129:
-.long	`1<<24`,0,`1<<24`,0,`1<<24`,0,`1<<24`,0
-.Lmask26:
-.long	0x3ffffff,0,0x3ffffff,0,0x3ffffff,0,0x3ffffff,0
-.Lpermd_avx2:
-.long	2,2,2,3,2,0,2,1
-.Lpermd_avx512:
-.long	0,0,0,1, 0,2,0,3, 0,4,0,5, 0,6,0,7
-
-.L2_44_inp_permd:
-.long	0,1,1,2,2,3,7,7
-.L2_44_inp_shift:
-.quad	0,12,24,64
-.L2_44_mask:
-.quad	0xfffffffffff,0xfffffffffff,0x3ffffffffff,0xffffffffffffffff
-.L2_44_shift_rgt:
-.quad	44,44,42,64
-.L2_44_shift_lft:
-.quad	8,8,10,64
-
-.align	64
-.Lx_mask44:
-.quad	0xfffffffffff,0xfffffffffff,0xfffffffffff,0xfffffffffff
-.quad	0xfffffffffff,0xfffffffffff,0xfffffffffff,0xfffffffffff
-.Lx_mask42:
-.quad	0x3ffffffffff,0x3ffffffffff,0x3ffffffffff,0x3ffffffffff
-.quad	0x3ffffffffff,0x3ffffffffff,0x3ffffffffff,0x3ffffffffff
-___
 }
-$code.=<<___;
-.asciz	"Poly1305 for x86_64, CRYPTOGAMS by <appro\@openssl.org>"
-.align	16
-___
 
+if (!$kernel)
 {	# chacha20-poly1305 helpers
 my ($out,$inp,$otp,$len)=$win64 ? ("%rcx","%rdx","%r8", "%r9") :  # Win64 order
                                   ("%rdi","%rsi","%rdx","%rcx");  # Unix order
@@ -4038,17 +4130,17 @@ avx_handler:
 
 .section	.pdata
 .align	4
-	.rva	.LSEH_begin_poly1305_init
-	.rva	.LSEH_end_poly1305_init
-	.rva	.LSEH_info_poly1305_init
+	.rva	.LSEH_begin_poly1305_init_x86_64
+	.rva	.LSEH_end_poly1305_init_x86_64
+	.rva	.LSEH_info_poly1305_init_x86_64
 
-	.rva	.LSEH_begin_poly1305_blocks
-	.rva	.LSEH_end_poly1305_blocks
-	.rva	.LSEH_info_poly1305_blocks
+	.rva	.LSEH_begin_poly1305_blocks_x86_64
+	.rva	.LSEH_end_poly1305_blocks_x86_64
+	.rva	.LSEH_info_poly1305_blocks_x86_64
 
-	.rva	.LSEH_begin_poly1305_emit
-	.rva	.LSEH_end_poly1305_emit
-	.rva	.LSEH_info_poly1305_emit
+	.rva	.LSEH_begin_poly1305_emit_x86_64
+	.rva	.LSEH_end_poly1305_emit_x86_64
+	.rva	.LSEH_info_poly1305_emit_x86_64
 ___
 $code.=<<___ if ($avx);
 	.rva	.LSEH_begin_poly1305_blocks_avx
@@ -4088,20 +4180,20 @@ ___
 $code.=<<___;
 .section	.xdata
 .align	8
-.LSEH_info_poly1305_init:
+.LSEH_info_poly1305_init_x86_64:
 	.byte	9,0,0,0
 	.rva	se_handler
-	.rva	.LSEH_begin_poly1305_init,.LSEH_begin_poly1305_init
+	.rva	.LSEH_begin_poly1305_init_x86_64,.LSEH_begin_poly1305_init_x86_64
 
-.LSEH_info_poly1305_blocks:
+.LSEH_info_poly1305_blocks_x86_64:
 	.byte	9,0,0,0
 	.rva	se_handler
 	.rva	.Lblocks_body,.Lblocks_epilogue
 
-.LSEH_info_poly1305_emit:
+.LSEH_info_poly1305_emit_x86_64:
 	.byte	9,0,0,0
 	.rva	se_handler
-	.rva	.LSEH_begin_poly1305_emit,.LSEH_begin_poly1305_emit
+	.rva	.LSEH_begin_poly1305_emit_x86_64,.LSEH_begin_poly1305_emit_x86_64
 ___
 $code.=<<___ if ($avx);
 .LSEH_info_poly1305_blocks_avx_1:
@@ -4148,12 +4240,26 @@ $code.=<<___ if ($avx>2);
 ___
 }
 
+open SELF,$0;
+while(<SELF>) {
+	next if (/^#!/);
+	last if (!s/^#/\/\// and !/^$/);
+	print;
+}
+close SELF;
+
 foreach (split('\n',$code)) {
 	s/\`([^\`]*)\`/eval($1)/ge;
 	s/%r([a-z]+)#d/%e$1/g;
 	s/%r([0-9]+)#d/%r$1d/g;
 	s/%x#%[yz]/%x/g or s/%y#%z/%y/g or s/%z#%[yz]/%z/g;
 
+	if ($kernel) {
+		s/(^\.type.*),[0-9]+$/\1/;
+		s/(^\.type.*),\@abi-omnipotent+$/\1,\@function/;
+		next if /^\.cfi.*/;
+	}
+
 	print $_,"\n";
 }
 close STDOUT;
diff --git a/arch/x86/crypto/poly1305_glue.c b/arch/x86/crypto/poly1305_glue.c
index edb7113e36f3..657363588e0c 100644
--- a/arch/x86/crypto/poly1305_glue.c
+++ b/arch/x86/crypto/poly1305_glue.c
@@ -1,8 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Poly1305 authenticator algorithm, RFC7539, SIMD glue code
- *
- * Copyright (C) 2015 Martin Willi
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  */
 
 #include <crypto/algapi.h>
@@ -13,279 +11,170 @@
 #include <linux/jump_label.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <asm/intel-family.h>
 #include <asm/simd.h>
 
-asmlinkage void poly1305_block_sse2(u32 *h, const u8 *src,
-				    const u32 *r, unsigned int blocks);
-asmlinkage void poly1305_2block_sse2(u32 *h, const u8 *src, const u32 *r,
-				     unsigned int blocks, const u32 *u);
-asmlinkage void poly1305_4block_avx2(u32 *h, const u8 *src, const u32 *r,
-				     unsigned int blocks, const u32 *u);
-
-static __ro_after_init DEFINE_STATIC_KEY_FALSE(poly1305_use_simd);
+asmlinkage void poly1305_init_x86_64(void *ctx,
+				     const u8 key[POLY1305_KEY_SIZE]);
+asmlinkage void poly1305_blocks_x86_64(void *ctx, const u8 *inp,
+				       const size_t len, const u32 padbit);
+asmlinkage void poly1305_emit_x86_64(void *ctx, u8 mac[POLY1305_DIGEST_SIZE],
+				     const u32 nonce[4]);
+asmlinkage void poly1305_emit_avx(void *ctx, u8 mac[POLY1305_DIGEST_SIZE],
+				  const u32 nonce[4]);
+asmlinkage void poly1305_blocks_avx(void *ctx, const u8 *inp, const size_t len,
+				    const u32 padbit);
+asmlinkage void poly1305_blocks_avx2(void *ctx, const u8 *inp, const size_t len,
+				     const u32 padbit);
+asmlinkage void poly1305_blocks_avx512(void *ctx, const u8 *inp,
+				       const size_t len, const u32 padbit);
+
+static __ro_after_init DEFINE_STATIC_KEY_FALSE(poly1305_use_avx);
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(poly1305_use_avx2);
+static __ro_after_init DEFINE_STATIC_KEY_FALSE(poly1305_use_avx512);
+
+struct poly1305_arch_internal {
+	union {
+		struct {
+			u32 h[5];
+			u32 is_base2_26;
+		};
+		u64 hs[3];
+	};
+	u64 r[2];
+	u64 pad;
+	struct { u32 r2, r1, r4, r3; } rn[9];
+};
 
-static inline u64 mlt(u64 a, u64 b)
+/* The AVX code uses base 2^26, while the scalar code uses base 2^64. If we hit
+ * the unfortunate situation of using AVX and then having to go back to scalar
+ * -- because the user is silly and has called the update function from two
+ * separate contexts -- then we need to convert back to the original base before
+ * proceeding. It is possible to reason that the initial reduction below is
+ * sufficient given the implementation invariants. However, for an avoidance of
+ * doubt and because this is not performance critical, we do the full reduction
+ * anyway. Z3 proof of below function: https://xn--4db.cc/ltPtHCKN/py
+ */
+static void convert_to_base2_64(void *ctx)
 {
-	return a * b;
-}
+	struct poly1305_arch_internal *state = ctx;
+	u32 cy;
 
-static inline u32 sr(u64 v, u_char n)
-{
-	return v >> n;
-}
+	if (!state->is_base2_26)
+		return;
 
-static inline u32 and(u32 v, u32 mask)
-{
-	return v & mask;
+	cy = state->h[0] >> 26; state->h[0] &= 0x3ffffff; state->h[1] += cy;
+	cy = state->h[1] >> 26; state->h[1] &= 0x3ffffff; state->h[2] += cy;
+	cy = state->h[2] >> 26; state->h[2] &= 0x3ffffff; state->h[3] += cy;
+	cy = state->h[3] >> 26; state->h[3] &= 0x3ffffff; state->h[4] += cy;
+	state->hs[0] = ((u64)state->h[2] << 52) | ((u64)state->h[1] << 26) | state->h[0];
+	state->hs[1] = ((u64)state->h[4] << 40) | ((u64)state->h[3] << 14) | (state->h[2] >> 12);
+	state->hs[2] = state->h[4] >> 24;
+#define ULT(a, b) ((a ^ ((a ^ b) | ((a - b) ^ b))) >> (sizeof(a) * 8 - 1))
+	cy = (state->hs[2] >> 2) + (state->hs[2] & ~3ULL);
+	state->hs[2] &= 3;
+	state->hs[0] += cy;
+	state->hs[1] += (cy = ULT(state->hs[0], cy));
+	state->hs[2] += ULT(state->hs[1], cy);
+#undef ULT
+	state->is_base2_26 = 0;
 }
 
-static void poly1305_simd_mult(u32 *a, const u32 *b)
+static void poly1305_simd_init(void *ctx, const u8 key[POLY1305_KEY_SIZE])
 {
-	u8 m[POLY1305_BLOCK_SIZE];
-
-	memset(m, 0, sizeof(m));
-	/* The poly1305 block function adds a hi-bit to the accumulator which
-	 * we don't need for key multiplication; compensate for it. */
-	a[4] -= 1 << 24;
-	poly1305_block_sse2(a, m, b, 1);
+	poly1305_init_x86_64(ctx, key);
 }
 
-static void poly1305_integer_setkey(struct poly1305_key *key, const u8 *raw_key)
+static void poly1305_simd_blocks(void *ctx, const u8 *inp, size_t len,
+				 const u32 padbit)
 {
-	/* r &= 0xffffffc0ffffffc0ffffffc0fffffff */
-	key->r[0] = (get_unaligned_le32(raw_key +  0) >> 0) & 0x3ffffff;
-	key->r[1] = (get_unaligned_le32(raw_key +  3) >> 2) & 0x3ffff03;
-	key->r[2] = (get_unaligned_le32(raw_key +  6) >> 4) & 0x3ffc0ff;
-	key->r[3] = (get_unaligned_le32(raw_key +  9) >> 6) & 0x3f03fff;
-	key->r[4] = (get_unaligned_le32(raw_key + 12) >> 8) & 0x00fffff;
-}
+	struct poly1305_arch_internal *state = ctx;
 
-static void poly1305_integer_blocks(struct poly1305_state *state,
-				    const struct poly1305_key *key,
-				    const void *src,
-				    unsigned int nblocks, u32 hibit)
-{
-	u32 r0, r1, r2, r3, r4;
-	u32 s1, s2, s3, s4;
-	u32 h0, h1, h2, h3, h4;
-	u64 d0, d1, d2, d3, d4;
+	/* SIMD disables preemption, so relax after processing each page. */
+	BUILD_BUG_ON(PAGE_SIZE < POLY1305_BLOCK_SIZE ||
+		     PAGE_SIZE % POLY1305_BLOCK_SIZE);
 
-	if (!nblocks)
+	if (!IS_ENABLED(CONFIG_AS_AVX) || !static_branch_likely(&poly1305_use_avx) ||
+	    (len < (POLY1305_BLOCK_SIZE * 18) && !state->is_base2_26) ||
+	    !crypto_simd_usable()) {
+		convert_to_base2_64(ctx);
+		poly1305_blocks_x86_64(ctx, inp, len, padbit);
 		return;
+	}
 
-	r0 = key->r[0];
-	r1 = key->r[1];
-	r2 = key->r[2];
-	r3 = key->r[3];
-	r4 = key->r[4];
-
-	s1 = r1 * 5;
-	s2 = r2 * 5;
-	s3 = r3 * 5;
-	s4 = r4 * 5;
-
-	h0 = state->h[0];
-	h1 = state->h[1];
-	h2 = state->h[2];
-	h3 = state->h[3];
-	h4 = state->h[4];
-
-	do {
-		/* h += m[i] */
-		h0 += (get_unaligned_le32(src +  0) >> 0) & 0x3ffffff;
-		h1 += (get_unaligned_le32(src +  3) >> 2) & 0x3ffffff;
-		h2 += (get_unaligned_le32(src +  6) >> 4) & 0x3ffffff;
-		h3 += (get_unaligned_le32(src +  9) >> 6) & 0x3ffffff;
-		h4 += (get_unaligned_le32(src + 12) >> 8) | (hibit << 24);
-
-		/* h *= r */
-		d0 = mlt(h0, r0) + mlt(h1, s4) + mlt(h2, s3) +
-		     mlt(h3, s2) + mlt(h4, s1);
-		d1 = mlt(h0, r1) + mlt(h1, r0) + mlt(h2, s4) +
-		     mlt(h3, s3) + mlt(h4, s2);
-		d2 = mlt(h0, r2) + mlt(h1, r1) + mlt(h2, r0) +
-		     mlt(h3, s4) + mlt(h4, s3);
-		d3 = mlt(h0, r3) + mlt(h1, r2) + mlt(h2, r1) +
-		     mlt(h3, r0) + mlt(h4, s4);
-		d4 = mlt(h0, r4) + mlt(h1, r3) + mlt(h2, r2) +
-		     mlt(h3, r1) + mlt(h4, r0);
-
-		/* (partial) h %= p */
-		d1 += sr(d0, 26);     h0 = and(d0, 0x3ffffff);
-		d2 += sr(d1, 26);     h1 = and(d1, 0x3ffffff);
-		d3 += sr(d2, 26);     h2 = and(d2, 0x3ffffff);
-		d4 += sr(d3, 26);     h3 = and(d3, 0x3ffffff);
-		h0 += sr(d4, 26) * 5; h4 = and(d4, 0x3ffffff);
-		h1 += h0 >> 26;       h0 = h0 & 0x3ffffff;
-
-		src += POLY1305_BLOCK_SIZE;
-	} while (--nblocks);
-
-	state->h[0] = h0;
-	state->h[1] = h1;
-	state->h[2] = h2;
-	state->h[3] = h3;
-	state->h[4] = h4;
+	for (;;) {
+		const size_t bytes = min_t(size_t, len, PAGE_SIZE);
+
+		kernel_fpu_begin();
+		if (IS_ENABLED(CONFIG_AS_AVX512) && static_branch_likely(&poly1305_use_avx512))
+			poly1305_blocks_avx512(ctx, inp, bytes, padbit);
+		else if (IS_ENABLED(CONFIG_AS_AVX2) && static_branch_likely(&poly1305_use_avx2))
+			poly1305_blocks_avx2(ctx, inp, bytes, padbit);
+		else
+			poly1305_blocks_avx(ctx, inp, bytes, padbit);
+		kernel_fpu_end();
+		len -= bytes;
+		if (!len)
+			break;
+		inp += bytes;
+	}
 }
 
-static void poly1305_integer_emit(const struct poly1305_state *state, void *dst)
+static void poly1305_simd_emit(void *ctx, u8 mac[POLY1305_DIGEST_SIZE],
+			       const u32 nonce[4])
 {
-	u32 h0, h1, h2, h3, h4;
-	u32 g0, g1, g2, g3, g4;
-	u32 mask;
-
-	/* fully carry h */
-	h0 = state->h[0];
-	h1 = state->h[1];
-	h2 = state->h[2];
-	h3 = state->h[3];
-	h4 = state->h[4];
-
-	h2 += (h1 >> 26);     h1 = h1 & 0x3ffffff;
-	h3 += (h2 >> 26);     h2 = h2 & 0x3ffffff;
-	h4 += (h3 >> 26);     h3 = h3 & 0x3ffffff;
-	h0 += (h4 >> 26) * 5; h4 = h4 & 0x3ffffff;
-	h1 += (h0 >> 26);     h0 = h0 & 0x3ffffff;
-
-	/* compute h + -p */
-	g0 = h0 + 5;
-	g1 = h1 + (g0 >> 26);             g0 &= 0x3ffffff;
-	g2 = h2 + (g1 >> 26);             g1 &= 0x3ffffff;
-	g3 = h3 + (g2 >> 26);             g2 &= 0x3ffffff;
-	g4 = h4 + (g3 >> 26) - (1 << 26); g3 &= 0x3ffffff;
-
-	/* select h if h < p, or h + -p if h >= p */
-	mask = (g4 >> ((sizeof(u32) * 8) - 1)) - 1;
-	g0 &= mask;
-	g1 &= mask;
-	g2 &= mask;
-	g3 &= mask;
-	g4 &= mask;
-	mask = ~mask;
-	h0 = (h0 & mask) | g0;
-	h1 = (h1 & mask) | g1;
-	h2 = (h2 & mask) | g2;
-	h3 = (h3 & mask) | g3;
-	h4 = (h4 & mask) | g4;
-
-	/* h = h % (2^128) */
-	put_unaligned_le32((h0 >>  0) | (h1 << 26), dst +  0);
-	put_unaligned_le32((h1 >>  6) | (h2 << 20), dst +  4);
-	put_unaligned_le32((h2 >> 12) | (h3 << 14), dst +  8);
-	put_unaligned_le32((h3 >> 18) | (h4 <<  8), dst + 12);
+	struct poly1305_arch_internal *state = ctx;
+
+	if (!IS_ENABLED(CONFIG_AS_AVX) || !static_branch_likely(&poly1305_use_avx) ||
+	    !state->is_base2_26 || !crypto_simd_usable()) {
+		convert_to_base2_64(ctx);
+		poly1305_emit_x86_64(ctx, mac, nonce);
+	} else
+		poly1305_emit_avx(ctx, mac, nonce);
 }
 
-void poly1305_init_arch(struct poly1305_desc_ctx *desc, const u8 *key)
+void poly1305_init_arch(struct poly1305_desc_ctx *dctx, const u8 *key)
 {
-	poly1305_integer_setkey(desc->opaque_r, key);
-	desc->s[0] = get_unaligned_le32(key + 16);
-	desc->s[1] = get_unaligned_le32(key + 20);
-	desc->s[2] = get_unaligned_le32(key + 24);
-	desc->s[3] = get_unaligned_le32(key + 28);
-	poly1305_core_init(&desc->h);
-	desc->buflen = 0;
-	desc->sset = true;
-	desc->rset = 1;
+	poly1305_simd_init(&dctx->h, key);
+	dctx->s[0] = get_unaligned_le32(&key[16]);
+	dctx->s[1] = get_unaligned_le32(&key[20]);
+	dctx->s[2] = get_unaligned_le32(&key[24]);
+	dctx->s[3] = get_unaligned_le32(&key[28]);
+	dctx->buflen = 0;
+	dctx->sset = true;
 }
-EXPORT_SYMBOL_GPL(poly1305_init_arch);
+EXPORT_SYMBOL(poly1305_init_arch);
 
-static unsigned int crypto_poly1305_setdesckey(struct poly1305_desc_ctx *dctx,
-					       const u8 *src, unsigned int srclen)
+static unsigned int crypto_poly1305_setdctxkey(struct poly1305_desc_ctx *dctx,
+					       const u8 *inp, unsigned int len)
 {
-	if (!dctx->sset) {
-		if (!dctx->rset && srclen >= POLY1305_BLOCK_SIZE) {
-			poly1305_integer_setkey(dctx->r, src);
-			src += POLY1305_BLOCK_SIZE;
-			srclen -= POLY1305_BLOCK_SIZE;
+	unsigned int acc = 0;
+	if (unlikely(!dctx->sset)) {
+		if (!dctx->rset && len >= POLY1305_BLOCK_SIZE) {
+			poly1305_simd_init(&dctx->h, inp);
+			inp += POLY1305_BLOCK_SIZE;
+			len -= POLY1305_BLOCK_SIZE;
+			acc += POLY1305_BLOCK_SIZE;
 			dctx->rset = 1;
 		}
-		if (srclen >= POLY1305_BLOCK_SIZE) {
-			dctx->s[0] = get_unaligned_le32(src +  0);
-			dctx->s[1] = get_unaligned_le32(src +  4);
-			dctx->s[2] = get_unaligned_le32(src +  8);
-			dctx->s[3] = get_unaligned_le32(src + 12);
-			src += POLY1305_BLOCK_SIZE;
-			srclen -= POLY1305_BLOCK_SIZE;
+		if (len >= POLY1305_BLOCK_SIZE) {
+			dctx->s[0] = get_unaligned_le32(&inp[0]);
+			dctx->s[1] = get_unaligned_le32(&inp[4]);
+			dctx->s[2] = get_unaligned_le32(&inp[8]);
+			dctx->s[3] = get_unaligned_le32(&inp[12]);
+			inp += POLY1305_BLOCK_SIZE;
+			len -= POLY1305_BLOCK_SIZE;
+			acc += POLY1305_BLOCK_SIZE;
 			dctx->sset = true;
 		}
 	}
-	return srclen;
-}
-
-static unsigned int poly1305_scalar_blocks(struct poly1305_desc_ctx *dctx,
-					   const u8 *src, unsigned int srclen)
-{
-	unsigned int datalen;
-
-	if (unlikely(!dctx->sset)) {
-		datalen = crypto_poly1305_setdesckey(dctx, src, srclen);
-		src += srclen - datalen;
-		srclen = datalen;
-	}
-	if (srclen >= POLY1305_BLOCK_SIZE) {
-		poly1305_integer_blocks(&dctx->h, dctx->opaque_r, src,
-					srclen / POLY1305_BLOCK_SIZE, 1);
-		srclen %= POLY1305_BLOCK_SIZE;
-	}
-	return srclen;
-}
-
-static unsigned int poly1305_simd_blocks(struct poly1305_desc_ctx *dctx,
-					 const u8 *src, unsigned int srclen)
-{
-	unsigned int blocks, datalen;
-
-	if (unlikely(!dctx->sset)) {
-		datalen = crypto_poly1305_setdesckey(dctx, src, srclen);
-		src += srclen - datalen;
-		srclen = datalen;
-	}
-
-	if (IS_ENABLED(CONFIG_AS_AVX2) &&
-	    static_branch_likely(&poly1305_use_avx2) &&
-	    srclen >= POLY1305_BLOCK_SIZE * 4) {
-		if (unlikely(dctx->rset < 4)) {
-			if (dctx->rset < 2) {
-				dctx->r[1] = dctx->r[0];
-				poly1305_simd_mult(dctx->r[1].r, dctx->r[0].r);
-			}
-			dctx->r[2] = dctx->r[1];
-			poly1305_simd_mult(dctx->r[2].r, dctx->r[0].r);
-			dctx->r[3] = dctx->r[2];
-			poly1305_simd_mult(dctx->r[3].r, dctx->r[0].r);
-			dctx->rset = 4;
-		}
-		blocks = srclen / (POLY1305_BLOCK_SIZE * 4);
-		poly1305_4block_avx2(dctx->h.h, src, dctx->r[0].r, blocks,
-				     dctx->r[1].r);
-		src += POLY1305_BLOCK_SIZE * 4 * blocks;
-		srclen -= POLY1305_BLOCK_SIZE * 4 * blocks;
-	}
-
-	if (likely(srclen >= POLY1305_BLOCK_SIZE * 2)) {
-		if (unlikely(dctx->rset < 2)) {
-			dctx->r[1] = dctx->r[0];
-			poly1305_simd_mult(dctx->r[1].r, dctx->r[0].r);
-			dctx->rset = 2;
-		}
-		blocks = srclen / (POLY1305_BLOCK_SIZE * 2);
-		poly1305_2block_sse2(dctx->h.h, src, dctx->r[0].r,
-				     blocks, dctx->r[1].r);
-		src += POLY1305_BLOCK_SIZE * 2 * blocks;
-		srclen -= POLY1305_BLOCK_SIZE * 2 * blocks;
-	}
-	if (srclen >= POLY1305_BLOCK_SIZE) {
-		poly1305_block_sse2(dctx->h.h, src, dctx->r[0].r, 1);
-		srclen -= POLY1305_BLOCK_SIZE;
-	}
-	return srclen;
+	return acc;
 }
 
 void poly1305_update_arch(struct poly1305_desc_ctx *dctx, const u8 *src,
 			  unsigned int srclen)
 {
-	unsigned int bytes;
+	unsigned int bytes, used;
 
 	if (unlikely(dctx->buflen)) {
 		bytes = min(srclen, POLY1305_BLOCK_SIZE - dctx->buflen);
@@ -295,31 +184,19 @@ void poly1305_update_arch(struct poly1305_desc_ctx *dctx, const u8 *src,
 		dctx->buflen += bytes;
 
 		if (dctx->buflen == POLY1305_BLOCK_SIZE) {
-			if (static_branch_likely(&poly1305_use_simd) &&
-			    likely(crypto_simd_usable())) {
-				kernel_fpu_begin();
-				poly1305_simd_blocks(dctx, dctx->buf,
-						     POLY1305_BLOCK_SIZE);
-				kernel_fpu_end();
-			} else {
-				poly1305_scalar_blocks(dctx, dctx->buf,
-						       POLY1305_BLOCK_SIZE);
-			}
+			if (likely(!crypto_poly1305_setdctxkey(dctx, dctx->buf, POLY1305_BLOCK_SIZE)))
+				poly1305_simd_blocks(&dctx->h, dctx->buf, POLY1305_BLOCK_SIZE, 1);
 			dctx->buflen = 0;
 		}
 	}
 
 	if (likely(srclen >= POLY1305_BLOCK_SIZE)) {
-		if (static_branch_likely(&poly1305_use_simd) &&
-		    likely(crypto_simd_usable())) {
-			kernel_fpu_begin();
-			bytes = poly1305_simd_blocks(dctx, src, srclen);
-			kernel_fpu_end();
-		} else {
-			bytes = poly1305_scalar_blocks(dctx, src, srclen);
-		}
-		src += srclen - bytes;
-		srclen = bytes;
+		bytes = round_down(srclen, POLY1305_BLOCK_SIZE);
+		srclen -= bytes;
+		used = crypto_poly1305_setdctxkey(dctx, src, bytes);
+		if (likely(bytes - used))
+			poly1305_simd_blocks(&dctx->h, src + used, bytes - used, 1);
+		src += bytes;
 	}
 
 	if (unlikely(srclen)) {
@@ -329,31 +206,17 @@ void poly1305_update_arch(struct poly1305_desc_ctx *dctx, const u8 *src,
 }
 EXPORT_SYMBOL(poly1305_update_arch);
 
-void poly1305_final_arch(struct poly1305_desc_ctx *desc, u8 *dst)
+void poly1305_final_arch(struct poly1305_desc_ctx *dctx, u8 *dst)
 {
-	__le32 digest[4];
-	u64 f = 0;
-
-	if (unlikely(desc->buflen)) {
-		desc->buf[desc->buflen++] = 1;
-		memset(desc->buf + desc->buflen, 0,
-		       POLY1305_BLOCK_SIZE - desc->buflen);
-		poly1305_integer_blocks(&desc->h, desc->opaque_r, desc->buf, 1, 0);
+	if (unlikely(dctx->buflen)) {
+		dctx->buf[dctx->buflen++] = 1;
+		memset(dctx->buf + dctx->buflen, 0,
+		       POLY1305_BLOCK_SIZE - dctx->buflen);
+		poly1305_simd_blocks(&dctx->h, dctx->buf, POLY1305_BLOCK_SIZE, 0);
 	}
 
-	poly1305_integer_emit(&desc->h, digest);
-
-	/* mac = (h + s) % (2^128) */
-	f = (f >> 32) + le32_to_cpu(digest[0]) + desc->s[0];
-	put_unaligned_le32(f, dst + 0);
-	f = (f >> 32) + le32_to_cpu(digest[1]) + desc->s[1];
-	put_unaligned_le32(f, dst + 4);
-	f = (f >> 32) + le32_to_cpu(digest[2]) + desc->s[2];
-	put_unaligned_le32(f, dst + 8);
-	f = (f >> 32) + le32_to_cpu(digest[3]) + desc->s[3];
-	put_unaligned_le32(f, dst + 12);
-
-	*desc = (struct poly1305_desc_ctx){};
+	poly1305_simd_emit(&dctx->h, dst, dctx->s);
+	*dctx = (struct poly1305_desc_ctx){};
 }
 EXPORT_SYMBOL(poly1305_final_arch);
 
@@ -361,38 +224,34 @@ static int crypto_poly1305_init(struct shash_desc *desc)
 {
 	struct poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
 
-	poly1305_core_init(&dctx->h);
-	dctx->buflen = 0;
-	dctx->rset = 0;
-	dctx->sset = false;
-
+	*dctx = (struct poly1305_desc_ctx){};
 	return 0;
 }
 
-static int crypto_poly1305_final(struct shash_desc *desc, u8 *dst)
+static int crypto_poly1305_update(struct shash_desc *desc,
+				  const u8 *src, unsigned int srclen)
 {
 	struct poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
 
-	if (unlikely(!dctx->sset))
-		return -ENOKEY;
-
-	poly1305_final_arch(dctx, dst);
+	poly1305_update_arch(dctx, src, srclen);
 	return 0;
 }
 
-static int poly1305_simd_update(struct shash_desc *desc,
-				const u8 *src, unsigned int srclen)
+static int crypto_poly1305_final(struct shash_desc *desc, u8 *dst)
 {
 	struct poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
 
-	poly1305_update_arch(dctx, src, srclen);
+	if (unlikely(!dctx->sset))
+		return -ENOKEY;
+
+	poly1305_final_arch(dctx, dst);
 	return 0;
 }
 
 static struct shash_alg alg = {
 	.digestsize	= POLY1305_DIGEST_SIZE,
 	.init		= crypto_poly1305_init,
-	.update		= poly1305_simd_update,
+	.update		= crypto_poly1305_update,
 	.final		= crypto_poly1305_final,
 	.descsize	= sizeof(struct poly1305_desc_ctx),
 	.base		= {
@@ -406,17 +265,19 @@ static struct shash_alg alg = {
 
 static int __init poly1305_simd_mod_init(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_XMM2))
-		return 0;
-
-	static_branch_enable(&poly1305_use_simd);
-
-	if (IS_ENABLED(CONFIG_AS_AVX2) &&
-	    boot_cpu_has(X86_FEATURE_AVX) &&
+	if (IS_ENABLED(CONFIG_AS_AVX) && boot_cpu_has(X86_FEATURE_AVX) &&
+	    cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL))
+		static_branch_enable(&poly1305_use_avx);
+	if (IS_ENABLED(CONFIG_AS_AVX2) && boot_cpu_has(X86_FEATURE_AVX) &&
 	    boot_cpu_has(X86_FEATURE_AVX2) &&
 	    cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL))
 		static_branch_enable(&poly1305_use_avx2);
-
+	if (IS_ENABLED(CONFIG_AS_AVX512) && boot_cpu_has(X86_FEATURE_AVX) &&
+	    boot_cpu_has(X86_FEATURE_AVX2) && boot_cpu_has(X86_FEATURE_AVX512F) &&
+	    cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM | XFEATURE_MASK_AVX512, NULL) &&
+	    /* Skylake downclocks unacceptably much when using zmm, but later generations are fast. */
+	    boot_cpu_data.x86_model != INTEL_FAM6_SKYLAKE_X)
+		static_branch_enable(&poly1305_use_avx512);
 	return IS_REACHABLE(CONFIG_CRYPTO_HASH) ? crypto_register_shash(&alg) : 0;
 }
 
@@ -430,7 +291,7 @@ module_init(poly1305_simd_mod_init);
 module_exit(poly1305_simd_mod_exit);
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Martin Willi <martin@strongswan.org>");
+MODULE_AUTHOR("Jason A. Donenfeld <Jason@zx2c4.com>");
 MODULE_DESCRIPTION("Poly1305 authenticator");
 MODULE_ALIAS_CRYPTO("poly1305");
 MODULE_ALIAS_CRYPTO("poly1305-simd");
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 0b2c4fce26d9..14c032de276e 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -90,7 +90,7 @@ config CRYPTO_LIB_DES
 config CRYPTO_LIB_POLY1305_RSIZE
 	int
 	default 2 if MIPS
-	default 4 if X86_64
+	default 11 if X86_64
 	default 9 if ARM || ARM64
 	default 1
 
-- 
2.24.1


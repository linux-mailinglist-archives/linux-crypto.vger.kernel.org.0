Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5CAC8AC4
	for <lists+linux-crypto@lfdr.de>; Wed,  2 Oct 2019 16:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfJBOR6 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 2 Oct 2019 10:17:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36915 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbfJBOR5 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 2 Oct 2019 10:17:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id f22so7202728wmc.2
        for <linux-crypto@vger.kernel.org>; Wed, 02 Oct 2019 07:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dIXRn7sQ08KOZu4ZphLvSm+Ql4CMGgaZvtaQg+DrrnA=;
        b=QUZbPlemcejQ9iJykirjGP7EdJYG7EtBcvTHWKFLCmRitNljQv/Vs870gFgGUd/m9D
         Wje9o5mnn9NbqKPSIMuP9S4klTpI1QQLy2XLIlvkg52hcv/myIIl4vsdnqrxV7XW0Mel
         ioxs3VzD2qKFN6imvUOpuzQn5P9lk6AP5iMRzcerPSP9sIQ6/lnOqYo8WNPDZQwoME+Q
         rBSPV7VDKKmiGhf8J3RWLkZkCT9ex8GMAVMlm8gUARlIZACXvtX7GvnJu7KCHRyeaPTz
         2pFHdiNTvtkg3IKTkMqMcXaDOWJmaD1/9wuqdfaK9EbogRB4bWNS7lotK7XqxIy1HQtn
         dpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dIXRn7sQ08KOZu4ZphLvSm+Ql4CMGgaZvtaQg+DrrnA=;
        b=ElrJnIFFX6ZVAikQxNuNKZnOG3atlvyIlTM2yZ8dBWDfWRXTyixHgQ2xV/oJtoRa9e
         Nf5bxzdylMCO+h+UAsQmBSmZG4fwtdoIO8GFY+xtCkemHPi/vlC+QTCiN2KMEL6P6ES1
         n6RpvuBecu0Fhhes4UxzFLQ3wEQCXxkvS92Mn6qKM5cxfKzbuvpvWHhLWk7N9RzQmCAO
         ks1FnX47JTZLWdpaUf5SPinqJ0BxolFzRL23TPYNw3Fmmx/HM9vSB6DLEpSy63JPqrY5
         /R5Pz0ncICqtomF2F6IYaETRTeE5lQxEWP75Ihv+ac+9zyGjpU53Hi1nZfDCAICFAKfo
         ciBA==
X-Gm-Message-State: APjAAAVW802lfbQ3JwjjFCbkxrSycqUr+sqX61tN/t8AlVxteJzMGUI1
        e/y9Tb39WhOzkOwXRVB0Ih2YbYtQPEGjpF9m
X-Google-Smtp-Source: APXvYqwWFLgOFDIZs6mGFZ99cWoOvmj3/z8XLgqjzSb65hibYnlioo7HfGVqnHN7dIN3gc6Jj5ZbMg==
X-Received: by 2002:a1c:1d84:: with SMTP id d126mr3022081wmd.58.1570025870735;
        Wed, 02 Oct 2019 07:17:50 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:f145:3252:fc29:76c9])
        by smtp.gmail.com with ESMTPSA id t13sm41078149wra.70.2019.10.02.07.17.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 07:17:49 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Martin Willi <martin@strongswan.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Polyakov <appro@cryptogams.org>
Subject: [PATCH v2 08/20] crypto: arm64/poly1305 - incorporate OpenSSL/CRYPTOGAMS NEON implementation
Date:   Wed,  2 Oct 2019 16:17:01 +0200
Message-Id: <20191002141713.31189-9-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191002141713.31189-1-ard.biesheuvel@linaro.org>
References: <20191002141713.31189-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This is a straight import of the OpenSSL/CRYPTOGAMS Poly1305 implementation
for NEON authored by Andy Polyakov, and contributed by him to the OpenSSL
project. The file 'poly1305-armv8.pl' is taken straight from this upstream
GitHub repository [0] at commit ec55a08dc0244ce570c4fc7cade330c60798952f,
and already contains all the changes required to build it as part of a
Linux kernel module.

[0] https://github.com/dot-asm/cryptogams

Co-developed-by: Andy Polyakov <appro@cryptogams.org>
Signed-off-by: Andy Polyakov <appro@cryptogams.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/Kconfig                 |   5 +
 arch/arm64/crypto/Makefile                |  10 +-
 arch/arm64/crypto/poly1305-armv8.pl       | 913 ++++++++++++++++++++
 arch/arm64/crypto/poly1305-core.S_shipped | 835 ++++++++++++++++++
 arch/arm64/crypto/poly1305-glue.c         | 229 +++++
 crypto/Kconfig                            |   1 +
 6 files changed, 1992 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 09aa69ccc792..05607de28181 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -106,6 +106,11 @@ config CRYPTO_CHACHA20_NEON
 	select CRYPTO_CHACHA20
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 
+config CRYPTO_POLY1305_NEON
+	tristate "Poly1305 hash function using scalar or NEON instructions"
+	depends on KERNEL_MODE_NEON
+	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+
 config CRYPTO_NHPOLY1305_NEON
 	tristate "NHPoly1305 hash function using NEON instructions (for Adiantum)"
 	depends on KERNEL_MODE_NEON
diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
index 0435f2a0610e..d0901e610df3 100644
--- a/arch/arm64/crypto/Makefile
+++ b/arch/arm64/crypto/Makefile
@@ -50,6 +50,10 @@ sha512-arm64-y := sha512-glue.o sha512-core.o
 obj-$(CONFIG_CRYPTO_CHACHA20_NEON) += chacha-neon.o
 chacha-neon-y := chacha-neon-core.o chacha-neon-glue.o
 
+obj-$(CONFIG_CRYPTO_POLY1305_NEON) += poly1305-neon.o
+poly1305-neon-y := poly1305-core.o poly1305-glue.o
+AFLAGS_poly1305-core.o += -Dpoly1305_init=poly1305_init_arm64
+
 obj-$(CONFIG_CRYPTO_NHPOLY1305_NEON) += nhpoly1305-neon.o
 nhpoly1305-neon-y := nh-neon-core.o nhpoly1305-neon-glue.o
 
@@ -68,11 +72,15 @@ ifdef REGENERATE_ARM64_CRYPTO
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $(<) void $(@)
 
+$(src)/poly1305-core.S_shipped: $(src)/poly1305-armv8.pl
+	$(call cmd,perlasm)
+
 $(src)/sha256-core.S_shipped: $(src)/sha512-armv8.pl
 	$(call cmd,perlasm)
 
 $(src)/sha512-core.S_shipped: $(src)/sha512-armv8.pl
 	$(call cmd,perlasm)
+
 endif
 
-clean-files += sha256-core.S sha512-core.S
+clean-files += poly1305-core.S sha256-core.S sha512-core.S
diff --git a/arch/arm64/crypto/poly1305-armv8.pl b/arch/arm64/crypto/poly1305-armv8.pl
new file mode 100644
index 000000000000..6e5576d19af8
--- /dev/null
+++ b/arch/arm64/crypto/poly1305-armv8.pl
@@ -0,0 +1,913 @@
+#!/usr/bin/env perl
+# SPDX-License-Identifier: GPL-1.0+ OR BSD-3-Clause
+#
+# ====================================================================
+# Written by Andy Polyakov, @dot-asm, initially for the OpenSSL
+# project.
+# ====================================================================
+#
+# This module implements Poly1305 hash for ARMv8.
+#
+# June 2015
+#
+# Numbers are cycles per processed byte with poly1305_blocks alone.
+#
+#		IALU/gcc-4.9	NEON
+#
+# Apple A7	1.86/+5%	0.72
+# Cortex-A53	2.69/+58%	1.47
+# Cortex-A57	2.70/+7%	1.14
+# Denver	1.64/+50%	1.18(*)
+# X-Gene	2.13/+68%	2.27
+# Mongoose	1.77/+75%	1.12
+# Kryo		2.70/+55%	1.13
+# ThunderX2	1.17/+95%	1.36
+#
+# (*)	estimate based on resources availability is less than 1.0,
+#	i.e. measured result is worse than expected, presumably binary
+#	translator is not almighty;
+
+$flavour=shift;
+$output=shift;
+
+if ($flavour && $flavour ne "void") {
+    $0 =~ m/(.*[\/\\])[^\/\\]+$/; $dir=$1;
+    ( $xlate="${dir}arm-xlate.pl" and -f $xlate ) or
+    ( $xlate="${dir}../../perlasm/arm-xlate.pl" and -f $xlate) or
+    die "can't locate arm-xlate.pl";
+
+    open STDOUT,"| \"$^X\" $xlate $flavour $output";
+} else {
+    open STDOUT,">$output";
+}
+
+my ($ctx,$inp,$len,$padbit) = map("x$_",(0..3));
+my ($mac,$nonce)=($inp,$len);
+
+my ($h0,$h1,$h2,$r0,$r1,$s1,$t0,$t1,$d0,$d1,$d2) = map("x$_",(4..14));
+
+$code.=<<___;
+#ifndef __KERNEL__
+# include "arm_arch.h"
+.extern	OPENSSL_armcap_P
+#endif
+
+.text
+
+// forward "declarations" are required for Apple
+.globl	poly1305_blocks
+.globl	poly1305_emit
+
+.globl	poly1305_init
+.type	poly1305_init,%function
+.align	5
+poly1305_init:
+	cmp	$inp,xzr
+	stp	xzr,xzr,[$ctx]		// zero hash value
+	stp	xzr,xzr,[$ctx,#16]	// [along with is_base2_26]
+
+	csel	x0,xzr,x0,eq
+	b.eq	.Lno_key
+
+#ifndef	__KERNEL__
+	adrp	x17,OPENSSL_armcap_P
+	ldr	w17,[x17,#:lo12:OPENSSL_armcap_P]
+#endif
+
+	ldp	$r0,$r1,[$inp]		// load key
+	mov	$s1,#0xfffffffc0fffffff
+	movk	$s1,#0x0fff,lsl#48
+#ifdef	__AARCH64EB__
+	rev	$r0,$r0			// flip bytes
+	rev	$r1,$r1
+#endif
+	and	$r0,$r0,$s1		// &=0ffffffc0fffffff
+	and	$s1,$s1,#-4
+	and	$r1,$r1,$s1		// &=0ffffffc0ffffffc
+	mov	w#$s1,#-1
+	stp	$r0,$r1,[$ctx,#32]	// save key value
+	str	w#$s1,[$ctx,#48]	// impossible key power value
+
+#ifndef	__KERNEL__
+	tst	w17,#ARMV7_NEON
+
+	adr	$d0,.Lpoly1305_blocks
+	adr	$r0,.Lpoly1305_blocks_neon
+	adr	$d1,.Lpoly1305_emit
+
+	csel	$d0,$d0,$r0,eq
+
+# ifdef	__ILP32__
+	stp	w#$d0,w#$d1,[$len]
+# else
+	stp	$d0,$d1,[$len]
+# endif
+#endif
+	mov	x0,#1
+.Lno_key:
+	ret
+.size	poly1305_init,.-poly1305_init
+
+.type	poly1305_blocks,%function
+.align	5
+poly1305_blocks:
+.Lpoly1305_blocks:
+	ands	$len,$len,#-16
+	b.eq	.Lno_data
+
+	ldp	$h0,$h1,[$ctx]		// load hash value
+	ldp	$h2,x17,[$ctx,#16]	// [along with is_base2_26]
+	ldp	$r0,$r1,[$ctx,#32]	// load key value
+
+#ifdef	__AARCH64EB__
+	lsr	$d0,$h0,#32
+	mov	w#$d1,w#$h0
+	lsr	$d2,$h1,#32
+	mov	w15,w#$h1
+	lsr	x16,$h2,#32
+#else
+	mov	w#$d0,w#$h0
+	lsr	$d1,$h0,#32
+	mov	w#$d2,w#$h1
+	lsr	x15,$h1,#32
+	mov	w16,w#$h2
+#endif
+
+	add	$d0,$d0,$d1,lsl#26	// base 2^26 -> base 2^64
+	lsr	$d1,$d2,#12
+	adds	$d0,$d0,$d2,lsl#52
+	add	$d1,$d1,x15,lsl#14
+	adc	$d1,$d1,xzr
+	lsr	$d2,x16,#24
+	adds	$d1,$d1,x16,lsl#40
+	adc	$d2,$d2,xzr
+
+	cmp	x17,#0			// is_base2_26?
+	add	$s1,$r1,$r1,lsr#2	// s1 = r1 + (r1 >> 2)
+	csel	$h0,$h0,$d0,eq		// choose between radixes
+	csel	$h1,$h1,$d1,eq
+	csel	$h2,$h2,$d2,eq
+
+.Loop:
+	ldp	$t0,$t1,[$inp],#16	// load input
+	sub	$len,$len,#16
+#ifdef	__AARCH64EB__
+	rev	$t0,$t0
+	rev	$t1,$t1
+#endif
+	adds	$h0,$h0,$t0		// accumulate input
+	adcs	$h1,$h1,$t1
+
+	mul	$d0,$h0,$r0		// h0*r0
+	adc	$h2,$h2,$padbit
+	umulh	$d1,$h0,$r0
+
+	mul	$t0,$h1,$s1		// h1*5*r1
+	umulh	$t1,$h1,$s1
+
+	adds	$d0,$d0,$t0
+	mul	$t0,$h0,$r1		// h0*r1
+	adc	$d1,$d1,$t1
+	umulh	$d2,$h0,$r1
+
+	adds	$d1,$d1,$t0
+	mul	$t0,$h1,$r0		// h1*r0
+	adc	$d2,$d2,xzr
+	umulh	$t1,$h1,$r0
+
+	adds	$d1,$d1,$t0
+	mul	$t0,$h2,$s1		// h2*5*r1
+	adc	$d2,$d2,$t1
+	mul	$t1,$h2,$r0		// h2*r0
+
+	adds	$d1,$d1,$t0
+	adc	$d2,$d2,$t1
+
+	and	$t0,$d2,#-4		// final reduction
+	and	$h2,$d2,#3
+	add	$t0,$t0,$d2,lsr#2
+	adds	$h0,$d0,$t0
+	adcs	$h1,$d1,xzr
+	adc	$h2,$h2,xzr
+
+	cbnz	$len,.Loop
+
+	stp	$h0,$h1,[$ctx]		// store hash value
+	stp	$h2,xzr,[$ctx,#16]	// [and clear is_base2_26]
+
+.Lno_data:
+	ret
+.size	poly1305_blocks,.-poly1305_blocks
+
+.type	poly1305_emit,%function
+.align	5
+poly1305_emit:
+.Lpoly1305_emit:
+	ldp	$h0,$h1,[$ctx]		// load hash base 2^64
+	ldp	$h2,$r0,[$ctx,#16]	// [along with is_base2_26]
+	ldp	$t0,$t1,[$nonce]	// load nonce
+
+#ifdef	__AARCH64EB__
+	lsr	$d0,$h0,#32
+	mov	w#$d1,w#$h0
+	lsr	$d2,$h1,#32
+	mov	w15,w#$h1
+	lsr	x16,$h2,#32
+#else
+	mov	w#$d0,w#$h0
+	lsr	$d1,$h0,#32
+	mov	w#$d2,w#$h1
+	lsr	x15,$h1,#32
+	mov	w16,w#$h2
+#endif
+
+	add	$d0,$d0,$d1,lsl#26	// base 2^26 -> base 2^64
+	lsr	$d1,$d2,#12
+	adds	$d0,$d0,$d2,lsl#52
+	add	$d1,$d1,x15,lsl#14
+	adc	$d1,$d1,xzr
+	lsr	$d2,x16,#24
+	adds	$d1,$d1,x16,lsl#40
+	adc	$d2,$d2,xzr
+
+	cmp	$r0,#0			// is_base2_26?
+	csel	$h0,$h0,$d0,eq		// choose between radixes
+	csel	$h1,$h1,$d1,eq
+	csel	$h2,$h2,$d2,eq
+
+	adds	$d0,$h0,#5		// compare to modulus
+	adcs	$d1,$h1,xzr
+	adc	$d2,$h2,xzr
+
+	tst	$d2,#-4			// see if it's carried/borrowed
+
+	csel	$h0,$h0,$d0,eq
+	csel	$h1,$h1,$d1,eq
+
+#ifdef	__AARCH64EB__
+	ror	$t0,$t0,#32		// flip nonce words
+	ror	$t1,$t1,#32
+#endif
+	adds	$h0,$h0,$t0		// accumulate nonce
+	adc	$h1,$h1,$t1
+#ifdef	__AARCH64EB__
+	rev	$h0,$h0			// flip output bytes
+	rev	$h1,$h1
+#endif
+	stp	$h0,$h1,[$mac]		// write result
+
+	ret
+.size	poly1305_emit,.-poly1305_emit
+___
+my ($R0,$R1,$S1,$R2,$S2,$R3,$S3,$R4,$S4) = map("v$_.4s",(0..8));
+my ($IN01_0,$IN01_1,$IN01_2,$IN01_3,$IN01_4) = map("v$_.2s",(9..13));
+my ($IN23_0,$IN23_1,$IN23_2,$IN23_3,$IN23_4) = map("v$_.2s",(14..18));
+my ($ACC0,$ACC1,$ACC2,$ACC3,$ACC4) = map("v$_.2d",(19..23));
+my ($H0,$H1,$H2,$H3,$H4) = map("v$_.2s",(24..28));
+my ($T0,$T1,$MASK) = map("v$_",(29..31));
+
+my ($in2,$zeros)=("x16","x17");
+my $is_base2_26 = $zeros;		# borrow
+
+$code.=<<___;
+.type	poly1305_mult,%function
+.align	5
+poly1305_mult:
+	mul	$d0,$h0,$r0		// h0*r0
+	umulh	$d1,$h0,$r0
+
+	mul	$t0,$h1,$s1		// h1*5*r1
+	umulh	$t1,$h1,$s1
+
+	adds	$d0,$d0,$t0
+	mul	$t0,$h0,$r1		// h0*r1
+	adc	$d1,$d1,$t1
+	umulh	$d2,$h0,$r1
+
+	adds	$d1,$d1,$t0
+	mul	$t0,$h1,$r0		// h1*r0
+	adc	$d2,$d2,xzr
+	umulh	$t1,$h1,$r0
+
+	adds	$d1,$d1,$t0
+	mul	$t0,$h2,$s1		// h2*5*r1
+	adc	$d2,$d2,$t1
+	mul	$t1,$h2,$r0		// h2*r0
+
+	adds	$d1,$d1,$t0
+	adc	$d2,$d2,$t1
+
+	and	$t0,$d2,#-4		// final reduction
+	and	$h2,$d2,#3
+	add	$t0,$t0,$d2,lsr#2
+	adds	$h0,$d0,$t0
+	adcs	$h1,$d1,xzr
+	adc	$h2,$h2,xzr
+
+	ret
+.size	poly1305_mult,.-poly1305_mult
+
+.type	poly1305_splat,%function
+.align	4
+poly1305_splat:
+	and	x12,$h0,#0x03ffffff	// base 2^64 -> base 2^26
+	ubfx	x13,$h0,#26,#26
+	extr	x14,$h1,$h0,#52
+	and	x14,x14,#0x03ffffff
+	ubfx	x15,$h1,#14,#26
+	extr	x16,$h2,$h1,#40
+
+	str	w12,[$ctx,#16*0]	// r0
+	add	w12,w13,w13,lsl#2	// r1*5
+	str	w13,[$ctx,#16*1]	// r1
+	add	w13,w14,w14,lsl#2	// r2*5
+	str	w12,[$ctx,#16*2]	// s1
+	str	w14,[$ctx,#16*3]	// r2
+	add	w14,w15,w15,lsl#2	// r3*5
+	str	w13,[$ctx,#16*4]	// s2
+	str	w15,[$ctx,#16*5]	// r3
+	add	w15,w16,w16,lsl#2	// r4*5
+	str	w14,[$ctx,#16*6]	// s3
+	str	w16,[$ctx,#16*7]	// r4
+	str	w15,[$ctx,#16*8]	// s4
+
+	ret
+.size	poly1305_splat,.-poly1305_splat
+
+#ifdef	__KERNEL__
+.globl	poly1305_blocks_neon
+#endif
+.type	poly1305_blocks_neon,%function
+.align	5
+poly1305_blocks_neon:
+.Lpoly1305_blocks_neon:
+	ldr	$is_base2_26,[$ctx,#24]
+	cmp	$len,#128
+	b.lo	.Lpoly1305_blocks
+
+	.inst	0xd503233f		// paciasp
+	stp	x29,x30,[sp,#-80]!
+	add	x29,sp,#0
+
+	stp	d8,d9,[sp,#16]		// meet ABI requirements
+	stp	d10,d11,[sp,#32]
+	stp	d12,d13,[sp,#48]
+	stp	d14,d15,[sp,#64]
+
+	cbz	$is_base2_26,.Lbase2_64_neon
+
+	ldp	w10,w11,[$ctx]		// load hash value base 2^26
+	ldp	w12,w13,[$ctx,#8]
+	ldr	w14,[$ctx,#16]
+
+	tst	$len,#31
+	b.eq	.Leven_neon
+
+	ldp	$r0,$r1,[$ctx,#32]	// load key value
+
+	add	$h0,x10,x11,lsl#26	// base 2^26 -> base 2^64
+	lsr	$h1,x12,#12
+	adds	$h0,$h0,x12,lsl#52
+	add	$h1,$h1,x13,lsl#14
+	adc	$h1,$h1,xzr
+	lsr	$h2,x14,#24
+	adds	$h1,$h1,x14,lsl#40
+	adc	$d2,$h2,xzr		// can be partially reduced...
+
+	ldp	$d0,$d1,[$inp],#16	// load input
+	sub	$len,$len,#16
+	add	$s1,$r1,$r1,lsr#2	// s1 = r1 + (r1 >> 2)
+
+#ifdef	__AARCH64EB__
+	rev	$d0,$d0
+	rev	$d1,$d1
+#endif
+	adds	$h0,$h0,$d0		// accumulate input
+	adcs	$h1,$h1,$d1
+	adc	$h2,$h2,$padbit
+
+	bl	poly1305_mult
+
+	and	x10,$h0,#0x03ffffff	// base 2^64 -> base 2^26
+	ubfx	x11,$h0,#26,#26
+	extr	x12,$h1,$h0,#52
+	and	x12,x12,#0x03ffffff
+	ubfx	x13,$h1,#14,#26
+	extr	x14,$h2,$h1,#40
+
+	b	.Leven_neon
+
+.align	4
+.Lbase2_64_neon:
+	ldp	$r0,$r1,[$ctx,#32]	// load key value
+
+	ldp	$h0,$h1,[$ctx]		// load hash value base 2^64
+	ldr	$h2,[$ctx,#16]
+
+	tst	$len,#31
+	b.eq	.Linit_neon
+
+	ldp	$d0,$d1,[$inp],#16	// load input
+	sub	$len,$len,#16
+	add	$s1,$r1,$r1,lsr#2	// s1 = r1 + (r1 >> 2)
+#ifdef	__AARCH64EB__
+	rev	$d0,$d0
+	rev	$d1,$d1
+#endif
+	adds	$h0,$h0,$d0		// accumulate input
+	adcs	$h1,$h1,$d1
+	adc	$h2,$h2,$padbit
+
+	bl	poly1305_mult
+
+.Linit_neon:
+	ldr	w17,[$ctx,#48]		// first table element
+	and	x10,$h0,#0x03ffffff	// base 2^64 -> base 2^26
+	ubfx	x11,$h0,#26,#26
+	extr	x12,$h1,$h0,#52
+	and	x12,x12,#0x03ffffff
+	ubfx	x13,$h1,#14,#26
+	extr	x14,$h2,$h1,#40
+
+	cmp	w17,#-1			// is value impossible?
+	b.ne	.Leven_neon
+
+	fmov	${H0},x10
+	fmov	${H1},x11
+	fmov	${H2},x12
+	fmov	${H3},x13
+	fmov	${H4},x14
+
+	////////////////////////////////// initialize r^n table
+	mov	$h0,$r0			// r^1
+	add	$s1,$r1,$r1,lsr#2	// s1 = r1 + (r1 >> 2)
+	mov	$h1,$r1
+	mov	$h2,xzr
+	add	$ctx,$ctx,#48+12
+	bl	poly1305_splat
+
+	bl	poly1305_mult		// r^2
+	sub	$ctx,$ctx,#4
+	bl	poly1305_splat
+
+	bl	poly1305_mult		// r^3
+	sub	$ctx,$ctx,#4
+	bl	poly1305_splat
+
+	bl	poly1305_mult		// r^4
+	sub	$ctx,$ctx,#4
+	bl	poly1305_splat
+	sub	$ctx,$ctx,#48		// restore original $ctx
+	b	.Ldo_neon
+
+.align	4
+.Leven_neon:
+	fmov	${H0},x10
+	fmov	${H1},x11
+	fmov	${H2},x12
+	fmov	${H3},x13
+	fmov	${H4},x14
+
+.Ldo_neon:
+	ldp	x8,x12,[$inp,#32]	// inp[2:3]
+	subs	$len,$len,#64
+	ldp	x9,x13,[$inp,#48]
+	add	$in2,$inp,#96
+	adr	$zeros,.Lzeros
+
+	lsl	$padbit,$padbit,#24
+	add	x15,$ctx,#48
+
+#ifdef	__AARCH64EB__
+	rev	x8,x8
+	rev	x12,x12
+	rev	x9,x9
+	rev	x13,x13
+#endif
+	and	x4,x8,#0x03ffffff	// base 2^64 -> base 2^26
+	and	x5,x9,#0x03ffffff
+	ubfx	x6,x8,#26,#26
+	ubfx	x7,x9,#26,#26
+	add	x4,x4,x5,lsl#32		// bfi	x4,x5,#32,#32
+	extr	x8,x12,x8,#52
+	extr	x9,x13,x9,#52
+	add	x6,x6,x7,lsl#32		// bfi	x6,x7,#32,#32
+	fmov	$IN23_0,x4
+	and	x8,x8,#0x03ffffff
+	and	x9,x9,#0x03ffffff
+	ubfx	x10,x12,#14,#26
+	ubfx	x11,x13,#14,#26
+	add	x12,$padbit,x12,lsr#40
+	add	x13,$padbit,x13,lsr#40
+	add	x8,x8,x9,lsl#32		// bfi	x8,x9,#32,#32
+	fmov	$IN23_1,x6
+	add	x10,x10,x11,lsl#32	// bfi	x10,x11,#32,#32
+	add	x12,x12,x13,lsl#32	// bfi	x12,x13,#32,#32
+	fmov	$IN23_2,x8
+	fmov	$IN23_3,x10
+	fmov	$IN23_4,x12
+
+	ldp	x8,x12,[$inp],#16	// inp[0:1]
+	ldp	x9,x13,[$inp],#48
+
+	ld1	{$R0,$R1,$S1,$R2},[x15],#64
+	ld1	{$S2,$R3,$S3,$R4},[x15],#64
+	ld1	{$S4},[x15]
+
+#ifdef	__AARCH64EB__
+	rev	x8,x8
+	rev	x12,x12
+	rev	x9,x9
+	rev	x13,x13
+#endif
+	and	x4,x8,#0x03ffffff	// base 2^64 -> base 2^26
+	and	x5,x9,#0x03ffffff
+	ubfx	x6,x8,#26,#26
+	ubfx	x7,x9,#26,#26
+	add	x4,x4,x5,lsl#32		// bfi	x4,x5,#32,#32
+	extr	x8,x12,x8,#52
+	extr	x9,x13,x9,#52
+	add	x6,x6,x7,lsl#32		// bfi	x6,x7,#32,#32
+	fmov	$IN01_0,x4
+	and	x8,x8,#0x03ffffff
+	and	x9,x9,#0x03ffffff
+	ubfx	x10,x12,#14,#26
+	ubfx	x11,x13,#14,#26
+	add	x12,$padbit,x12,lsr#40
+	add	x13,$padbit,x13,lsr#40
+	add	x8,x8,x9,lsl#32		// bfi	x8,x9,#32,#32
+	fmov	$IN01_1,x6
+	add	x10,x10,x11,lsl#32	// bfi	x10,x11,#32,#32
+	add	x12,x12,x13,lsl#32	// bfi	x12,x13,#32,#32
+	movi	$MASK.2d,#-1
+	fmov	$IN01_2,x8
+	fmov	$IN01_3,x10
+	fmov	$IN01_4,x12
+	ushr	$MASK.2d,$MASK.2d,#38
+
+	b.ls	.Lskip_loop
+
+.align	4
+.Loop_neon:
+	////////////////////////////////////////////////////////////////
+	// ((inp[0]*r^4+inp[2]*r^2+inp[4])*r^4+inp[6]*r^2
+	// ((inp[1]*r^4+inp[3]*r^2+inp[5])*r^3+inp[7]*r
+	//   \___________________/
+	// ((inp[0]*r^4+inp[2]*r^2+inp[4])*r^4+inp[6]*r^2+inp[8])*r^2
+	// ((inp[1]*r^4+inp[3]*r^2+inp[5])*r^4+inp[7]*r^2+inp[9])*r
+	//   \___________________/ \____________________/
+	//
+	// Note that we start with inp[2:3]*r^2. This is because it
+	// doesn't depend on reduction in previous iteration.
+	////////////////////////////////////////////////////////////////
+	// d4 = h0*r4 + h1*r3   + h2*r2   + h3*r1   + h4*r0
+	// d3 = h0*r3 + h1*r2   + h2*r1   + h3*r0   + h4*5*r4
+	// d2 = h0*r2 + h1*r1   + h2*r0   + h3*5*r4 + h4*5*r3
+	// d1 = h0*r1 + h1*r0   + h2*5*r4 + h3*5*r3 + h4*5*r2
+	// d0 = h0*r0 + h1*5*r4 + h2*5*r3 + h3*5*r2 + h4*5*r1
+
+	subs	$len,$len,#64
+	umull	$ACC4,$IN23_0,${R4}[2]
+	csel	$in2,$zeros,$in2,lo
+	umull	$ACC3,$IN23_0,${R3}[2]
+	umull	$ACC2,$IN23_0,${R2}[2]
+	 ldp	x8,x12,[$in2],#16	// inp[2:3] (or zero)
+	umull	$ACC1,$IN23_0,${R1}[2]
+	 ldp	x9,x13,[$in2],#48
+	umull	$ACC0,$IN23_0,${R0}[2]
+#ifdef	__AARCH64EB__
+	 rev	x8,x8
+	 rev	x12,x12
+	 rev	x9,x9
+	 rev	x13,x13
+#endif
+
+	umlal	$ACC4,$IN23_1,${R3}[2]
+	 and	x4,x8,#0x03ffffff	// base 2^64 -> base 2^26
+	umlal	$ACC3,$IN23_1,${R2}[2]
+	 and	x5,x9,#0x03ffffff
+	umlal	$ACC2,$IN23_1,${R1}[2]
+	 ubfx	x6,x8,#26,#26
+	umlal	$ACC1,$IN23_1,${R0}[2]
+	 ubfx	x7,x9,#26,#26
+	umlal	$ACC0,$IN23_1,${S4}[2]
+	 add	x4,x4,x5,lsl#32		// bfi	x4,x5,#32,#32
+
+	umlal	$ACC4,$IN23_2,${R2}[2]
+	 extr	x8,x12,x8,#52
+	umlal	$ACC3,$IN23_2,${R1}[2]
+	 extr	x9,x13,x9,#52
+	umlal	$ACC2,$IN23_2,${R0}[2]
+	 add	x6,x6,x7,lsl#32		// bfi	x6,x7,#32,#32
+	umlal	$ACC1,$IN23_2,${S4}[2]
+	 fmov	$IN23_0,x4
+	umlal	$ACC0,$IN23_2,${S3}[2]
+	 and	x8,x8,#0x03ffffff
+
+	umlal	$ACC4,$IN23_3,${R1}[2]
+	 and	x9,x9,#0x03ffffff
+	umlal	$ACC3,$IN23_3,${R0}[2]
+	 ubfx	x10,x12,#14,#26
+	umlal	$ACC2,$IN23_3,${S4}[2]
+	 ubfx	x11,x13,#14,#26
+	umlal	$ACC1,$IN23_3,${S3}[2]
+	 add	x8,x8,x9,lsl#32		// bfi	x8,x9,#32,#32
+	umlal	$ACC0,$IN23_3,${S2}[2]
+	 fmov	$IN23_1,x6
+
+	add	$IN01_2,$IN01_2,$H2
+	 add	x12,$padbit,x12,lsr#40
+	umlal	$ACC4,$IN23_4,${R0}[2]
+	 add	x13,$padbit,x13,lsr#40
+	umlal	$ACC3,$IN23_4,${S4}[2]
+	 add	x10,x10,x11,lsl#32	// bfi	x10,x11,#32,#32
+	umlal	$ACC2,$IN23_4,${S3}[2]
+	 add	x12,x12,x13,lsl#32	// bfi	x12,x13,#32,#32
+	umlal	$ACC1,$IN23_4,${S2}[2]
+	 fmov	$IN23_2,x8
+	umlal	$ACC0,$IN23_4,${S1}[2]
+	 fmov	$IN23_3,x10
+
+	////////////////////////////////////////////////////////////////
+	// (hash+inp[0:1])*r^4 and accumulate
+
+	add	$IN01_0,$IN01_0,$H0
+	 fmov	$IN23_4,x12
+	umlal	$ACC3,$IN01_2,${R1}[0]
+	 ldp	x8,x12,[$inp],#16	// inp[0:1]
+	umlal	$ACC0,$IN01_2,${S3}[0]
+	 ldp	x9,x13,[$inp],#48
+	umlal	$ACC4,$IN01_2,${R2}[0]
+	umlal	$ACC1,$IN01_2,${S4}[0]
+	umlal	$ACC2,$IN01_2,${R0}[0]
+#ifdef	__AARCH64EB__
+	 rev	x8,x8
+	 rev	x12,x12
+	 rev	x9,x9
+	 rev	x13,x13
+#endif
+
+	add	$IN01_1,$IN01_1,$H1
+	umlal	$ACC3,$IN01_0,${R3}[0]
+	umlal	$ACC4,$IN01_0,${R4}[0]
+	 and	x4,x8,#0x03ffffff	// base 2^64 -> base 2^26
+	umlal	$ACC2,$IN01_0,${R2}[0]
+	 and	x5,x9,#0x03ffffff
+	umlal	$ACC0,$IN01_0,${R0}[0]
+	 ubfx	x6,x8,#26,#26
+	umlal	$ACC1,$IN01_0,${R1}[0]
+	 ubfx	x7,x9,#26,#26
+
+	add	$IN01_3,$IN01_3,$H3
+	 add	x4,x4,x5,lsl#32		// bfi	x4,x5,#32,#32
+	umlal	$ACC3,$IN01_1,${R2}[0]
+	 extr	x8,x12,x8,#52
+	umlal	$ACC4,$IN01_1,${R3}[0]
+	 extr	x9,x13,x9,#52
+	umlal	$ACC0,$IN01_1,${S4}[0]
+	 add	x6,x6,x7,lsl#32		// bfi	x6,x7,#32,#32
+	umlal	$ACC2,$IN01_1,${R1}[0]
+	 fmov	$IN01_0,x4
+	umlal	$ACC1,$IN01_1,${R0}[0]
+	 and	x8,x8,#0x03ffffff
+
+	add	$IN01_4,$IN01_4,$H4
+	 and	x9,x9,#0x03ffffff
+	umlal	$ACC3,$IN01_3,${R0}[0]
+	 ubfx	x10,x12,#14,#26
+	umlal	$ACC0,$IN01_3,${S2}[0]
+	 ubfx	x11,x13,#14,#26
+	umlal	$ACC4,$IN01_3,${R1}[0]
+	 add	x8,x8,x9,lsl#32		// bfi	x8,x9,#32,#32
+	umlal	$ACC1,$IN01_3,${S3}[0]
+	 fmov	$IN01_1,x6
+	umlal	$ACC2,$IN01_3,${S4}[0]
+	 add	x12,$padbit,x12,lsr#40
+
+	umlal	$ACC3,$IN01_4,${S4}[0]
+	 add	x13,$padbit,x13,lsr#40
+	umlal	$ACC0,$IN01_4,${S1}[0]
+	 add	x10,x10,x11,lsl#32	// bfi	x10,x11,#32,#32
+	umlal	$ACC4,$IN01_4,${R0}[0]
+	 add	x12,x12,x13,lsl#32	// bfi	x12,x13,#32,#32
+	umlal	$ACC1,$IN01_4,${S2}[0]
+	 fmov	$IN01_2,x8
+	umlal	$ACC2,$IN01_4,${S3}[0]
+	 fmov	$IN01_3,x10
+	 fmov	$IN01_4,x12
+
+	/////////////////////////////////////////////////////////////////
+	// lazy reduction as discussed in "NEON crypto" by D.J. Bernstein
+	// and P. Schwabe
+	//
+	// [see discussion in poly1305-armv4 module]
+
+	ushr	$T0.2d,$ACC3,#26
+	xtn	$H3,$ACC3
+	 ushr	$T1.2d,$ACC0,#26
+	 and	$ACC0,$ACC0,$MASK.2d
+	add	$ACC4,$ACC4,$T0.2d	// h3 -> h4
+	bic	$H3,#0xfc,lsl#24	// &=0x03ffffff
+	 add	$ACC1,$ACC1,$T1.2d	// h0 -> h1
+
+	ushr	$T0.2d,$ACC4,#26
+	xtn	$H4,$ACC4
+	 ushr	$T1.2d,$ACC1,#26
+	 xtn	$H1,$ACC1
+	bic	$H4,#0xfc,lsl#24
+	 add	$ACC2,$ACC2,$T1.2d	// h1 -> h2
+
+	add	$ACC0,$ACC0,$T0.2d
+	shl	$T0.2d,$T0.2d,#2
+	 shrn	$T1.2s,$ACC2,#26
+	 xtn	$H2,$ACC2
+	add	$ACC0,$ACC0,$T0.2d	// h4 -> h0
+	 bic	$H1,#0xfc,lsl#24
+	 add	$H3,$H3,$T1.2s		// h2 -> h3
+	 bic	$H2,#0xfc,lsl#24
+
+	shrn	$T0.2s,$ACC0,#26
+	xtn	$H0,$ACC0
+	 ushr	$T1.2s,$H3,#26
+	 bic	$H3,#0xfc,lsl#24
+	 bic	$H0,#0xfc,lsl#24
+	add	$H1,$H1,$T0.2s		// h0 -> h1
+	 add	$H4,$H4,$T1.2s		// h3 -> h4
+
+	b.hi	.Loop_neon
+
+.Lskip_loop:
+	dup	$IN23_2,${IN23_2}[0]
+	add	$IN01_2,$IN01_2,$H2
+
+	////////////////////////////////////////////////////////////////
+	// multiply (inp[0:1]+hash) or inp[2:3] by r^2:r^1
+
+	adds	$len,$len,#32
+	b.ne	.Long_tail
+
+	dup	$IN23_2,${IN01_2}[0]
+	add	$IN23_0,$IN01_0,$H0
+	add	$IN23_3,$IN01_3,$H3
+	add	$IN23_1,$IN01_1,$H1
+	add	$IN23_4,$IN01_4,$H4
+
+.Long_tail:
+	dup	$IN23_0,${IN23_0}[0]
+	umull2	$ACC0,$IN23_2,${S3}
+	umull2	$ACC3,$IN23_2,${R1}
+	umull2	$ACC4,$IN23_2,${R2}
+	umull2	$ACC2,$IN23_2,${R0}
+	umull2	$ACC1,$IN23_2,${S4}
+
+	dup	$IN23_1,${IN23_1}[0]
+	umlal2	$ACC0,$IN23_0,${R0}
+	umlal2	$ACC2,$IN23_0,${R2}
+	umlal2	$ACC3,$IN23_0,${R3}
+	umlal2	$ACC4,$IN23_0,${R4}
+	umlal2	$ACC1,$IN23_0,${R1}
+
+	dup	$IN23_3,${IN23_3}[0]
+	umlal2	$ACC0,$IN23_1,${S4}
+	umlal2	$ACC3,$IN23_1,${R2}
+	umlal2	$ACC2,$IN23_1,${R1}
+	umlal2	$ACC4,$IN23_1,${R3}
+	umlal2	$ACC1,$IN23_1,${R0}
+
+	dup	$IN23_4,${IN23_4}[0]
+	umlal2	$ACC3,$IN23_3,${R0}
+	umlal2	$ACC4,$IN23_3,${R1}
+	umlal2	$ACC0,$IN23_3,${S2}
+	umlal2	$ACC1,$IN23_3,${S3}
+	umlal2	$ACC2,$IN23_3,${S4}
+
+	umlal2	$ACC3,$IN23_4,${S4}
+	umlal2	$ACC0,$IN23_4,${S1}
+	umlal2	$ACC4,$IN23_4,${R0}
+	umlal2	$ACC1,$IN23_4,${S2}
+	umlal2	$ACC2,$IN23_4,${S3}
+
+	b.eq	.Lshort_tail
+
+	////////////////////////////////////////////////////////////////
+	// (hash+inp[0:1])*r^4:r^3 and accumulate
+
+	add	$IN01_0,$IN01_0,$H0
+	umlal	$ACC3,$IN01_2,${R1}
+	umlal	$ACC0,$IN01_2,${S3}
+	umlal	$ACC4,$IN01_2,${R2}
+	umlal	$ACC1,$IN01_2,${S4}
+	umlal	$ACC2,$IN01_2,${R0}
+
+	add	$IN01_1,$IN01_1,$H1
+	umlal	$ACC3,$IN01_0,${R3}
+	umlal	$ACC0,$IN01_0,${R0}
+	umlal	$ACC4,$IN01_0,${R4}
+	umlal	$ACC1,$IN01_0,${R1}
+	umlal	$ACC2,$IN01_0,${R2}
+
+	add	$IN01_3,$IN01_3,$H3
+	umlal	$ACC3,$IN01_1,${R2}
+	umlal	$ACC0,$IN01_1,${S4}
+	umlal	$ACC4,$IN01_1,${R3}
+	umlal	$ACC1,$IN01_1,${R0}
+	umlal	$ACC2,$IN01_1,${R1}
+
+	add	$IN01_4,$IN01_4,$H4
+	umlal	$ACC3,$IN01_3,${R0}
+	umlal	$ACC0,$IN01_3,${S2}
+	umlal	$ACC4,$IN01_3,${R1}
+	umlal	$ACC1,$IN01_3,${S3}
+	umlal	$ACC2,$IN01_3,${S4}
+
+	umlal	$ACC3,$IN01_4,${S4}
+	umlal	$ACC0,$IN01_4,${S1}
+	umlal	$ACC4,$IN01_4,${R0}
+	umlal	$ACC1,$IN01_4,${S2}
+	umlal	$ACC2,$IN01_4,${S3}
+
+.Lshort_tail:
+	////////////////////////////////////////////////////////////////
+	// horizontal add
+
+	addp	$ACC3,$ACC3,$ACC3
+	 ldp	d8,d9,[sp,#16]		// meet ABI requirements
+	addp	$ACC0,$ACC0,$ACC0
+	 ldp	d10,d11,[sp,#32]
+	addp	$ACC4,$ACC4,$ACC4
+	 ldp	d12,d13,[sp,#48]
+	addp	$ACC1,$ACC1,$ACC1
+	 ldp	d14,d15,[sp,#64]
+	addp	$ACC2,$ACC2,$ACC2
+	 ldr	x30,[sp,#8]
+	 .inst	0xd50323bf		// autiasp
+
+	////////////////////////////////////////////////////////////////
+	// lazy reduction, but without narrowing
+
+	ushr	$T0.2d,$ACC3,#26
+	and	$ACC3,$ACC3,$MASK.2d
+	 ushr	$T1.2d,$ACC0,#26
+	 and	$ACC0,$ACC0,$MASK.2d
+
+	add	$ACC4,$ACC4,$T0.2d	// h3 -> h4
+	 add	$ACC1,$ACC1,$T1.2d	// h0 -> h1
+
+	ushr	$T0.2d,$ACC4,#26
+	and	$ACC4,$ACC4,$MASK.2d
+	 ushr	$T1.2d,$ACC1,#26
+	 and	$ACC1,$ACC1,$MASK.2d
+	 add	$ACC2,$ACC2,$T1.2d	// h1 -> h2
+
+	add	$ACC0,$ACC0,$T0.2d
+	shl	$T0.2d,$T0.2d,#2
+	 ushr	$T1.2d,$ACC2,#26
+	 and	$ACC2,$ACC2,$MASK.2d
+	add	$ACC0,$ACC0,$T0.2d	// h4 -> h0
+	 add	$ACC3,$ACC3,$T1.2d	// h2 -> h3
+
+	ushr	$T0.2d,$ACC0,#26
+	and	$ACC0,$ACC0,$MASK.2d
+	 ushr	$T1.2d,$ACC3,#26
+	 and	$ACC3,$ACC3,$MASK.2d
+	add	$ACC1,$ACC1,$T0.2d	// h0 -> h1
+	 add	$ACC4,$ACC4,$T1.2d	// h3 -> h4
+
+	////////////////////////////////////////////////////////////////
+	// write the result, can be partially reduced
+
+	st4	{$ACC0,$ACC1,$ACC2,$ACC3}[0],[$ctx],#16
+	mov	x4,#1
+	st1	{$ACC4}[0],[$ctx]
+	str	x4,[$ctx,#8]		// set is_base2_26
+
+	ldr	x29,[sp],#80
+	ret
+.size	poly1305_blocks_neon,.-poly1305_blocks_neon
+
+.align	5
+.Lzeros:
+.long	0,0,0,0,0,0,0,0
+.asciz	"Poly1305 for ARMv8, CRYPTOGAMS by \@dot-asm"
+.align	2
+#if !defined(__KERNEL__) && !defined(_WIN64)
+.comm	OPENSSL_armcap_P,4,4
+.hidden	OPENSSL_armcap_P
+#endif
+___
+
+foreach (split("\n",$code)) {
+	s/\b(shrn\s+v[0-9]+)\.[24]d/$1.2s/			or
+	s/\b(fmov\s+)v([0-9]+)[^,]*,\s*x([0-9]+)/$1d$2,x$3/	or
+	(m/\bdup\b/ and (s/\.[24]s/.2d/g or 1))			or
+	(m/\b(eor|and)/ and (s/\.[248][sdh]/.16b/g or 1))	or
+	(m/\bum(ul|la)l\b/ and (s/\.4s/.2s/g or 1))		or
+	(m/\bum(ul|la)l2\b/ and (s/\.2s/.4s/g or 1))		or
+	(m/\bst[1-4]\s+{[^}]+}\[/ and (s/\.[24]d/.s/g or 1));
+
+	s/\.[124]([sd])\[/.$1\[/;
+	s/w#x([0-9]+)/w$1/g;
+
+	print $_,"\n";
+}
+close STDOUT;
diff --git a/arch/arm64/crypto/poly1305-core.S_shipped b/arch/arm64/crypto/poly1305-core.S_shipped
new file mode 100644
index 000000000000..8d1c4e420ccd
--- /dev/null
+++ b/arch/arm64/crypto/poly1305-core.S_shipped
@@ -0,0 +1,835 @@
+#ifndef __KERNEL__
+# include "arm_arch.h"
+.extern	OPENSSL_armcap_P
+#endif
+
+.text
+
+// forward "declarations" are required for Apple
+.globl	poly1305_blocks
+.globl	poly1305_emit
+
+.globl	poly1305_init
+.type	poly1305_init,%function
+.align	5
+poly1305_init:
+	cmp	x1,xzr
+	stp	xzr,xzr,[x0]		// zero hash value
+	stp	xzr,xzr,[x0,#16]	// [along with is_base2_26]
+
+	csel	x0,xzr,x0,eq
+	b.eq	.Lno_key
+
+#ifndef	__KERNEL__
+	adrp	x17,OPENSSL_armcap_P
+	ldr	w17,[x17,#:lo12:OPENSSL_armcap_P]
+#endif
+
+	ldp	x7,x8,[x1]		// load key
+	mov	x9,#0xfffffffc0fffffff
+	movk	x9,#0x0fff,lsl#48
+#ifdef	__AARCH64EB__
+	rev	x7,x7			// flip bytes
+	rev	x8,x8
+#endif
+	and	x7,x7,x9		// &=0ffffffc0fffffff
+	and	x9,x9,#-4
+	and	x8,x8,x9		// &=0ffffffc0ffffffc
+	mov	w9,#-1
+	stp	x7,x8,[x0,#32]	// save key value
+	str	w9,[x0,#48]	// impossible key power value
+
+#ifndef	__KERNEL__
+	tst	w17,#ARMV7_NEON
+
+	adr	x12,.Lpoly1305_blocks
+	adr	x7,.Lpoly1305_blocks_neon
+	adr	x13,.Lpoly1305_emit
+
+	csel	x12,x12,x7,eq
+
+# ifdef	__ILP32__
+	stp	w12,w13,[x2]
+# else
+	stp	x12,x13,[x2]
+# endif
+#endif
+	mov	x0,#1
+.Lno_key:
+	ret
+.size	poly1305_init,.-poly1305_init
+
+.type	poly1305_blocks,%function
+.align	5
+poly1305_blocks:
+.Lpoly1305_blocks:
+	ands	x2,x2,#-16
+	b.eq	.Lno_data
+
+	ldp	x4,x5,[x0]		// load hash value
+	ldp	x6,x17,[x0,#16]	// [along with is_base2_26]
+	ldp	x7,x8,[x0,#32]	// load key value
+
+#ifdef	__AARCH64EB__
+	lsr	x12,x4,#32
+	mov	w13,w4
+	lsr	x14,x5,#32
+	mov	w15,w5
+	lsr	x16,x6,#32
+#else
+	mov	w12,w4
+	lsr	x13,x4,#32
+	mov	w14,w5
+	lsr	x15,x5,#32
+	mov	w16,w6
+#endif
+
+	add	x12,x12,x13,lsl#26	// base 2^26 -> base 2^64
+	lsr	x13,x14,#12
+	adds	x12,x12,x14,lsl#52
+	add	x13,x13,x15,lsl#14
+	adc	x13,x13,xzr
+	lsr	x14,x16,#24
+	adds	x13,x13,x16,lsl#40
+	adc	x14,x14,xzr
+
+	cmp	x17,#0			// is_base2_26?
+	add	x9,x8,x8,lsr#2	// s1 = r1 + (r1 >> 2)
+	csel	x4,x4,x12,eq		// choose between radixes
+	csel	x5,x5,x13,eq
+	csel	x6,x6,x14,eq
+
+.Loop:
+	ldp	x10,x11,[x1],#16	// load input
+	sub	x2,x2,#16
+#ifdef	__AARCH64EB__
+	rev	x10,x10
+	rev	x11,x11
+#endif
+	adds	x4,x4,x10		// accumulate input
+	adcs	x5,x5,x11
+
+	mul	x12,x4,x7		// h0*r0
+	adc	x6,x6,x3
+	umulh	x13,x4,x7
+
+	mul	x10,x5,x9		// h1*5*r1
+	umulh	x11,x5,x9
+
+	adds	x12,x12,x10
+	mul	x10,x4,x8		// h0*r1
+	adc	x13,x13,x11
+	umulh	x14,x4,x8
+
+	adds	x13,x13,x10
+	mul	x10,x5,x7		// h1*r0
+	adc	x14,x14,xzr
+	umulh	x11,x5,x7
+
+	adds	x13,x13,x10
+	mul	x10,x6,x9		// h2*5*r1
+	adc	x14,x14,x11
+	mul	x11,x6,x7		// h2*r0
+
+	adds	x13,x13,x10
+	adc	x14,x14,x11
+
+	and	x10,x14,#-4		// final reduction
+	and	x6,x14,#3
+	add	x10,x10,x14,lsr#2
+	adds	x4,x12,x10
+	adcs	x5,x13,xzr
+	adc	x6,x6,xzr
+
+	cbnz	x2,.Loop
+
+	stp	x4,x5,[x0]		// store hash value
+	stp	x6,xzr,[x0,#16]	// [and clear is_base2_26]
+
+.Lno_data:
+	ret
+.size	poly1305_blocks,.-poly1305_blocks
+
+.type	poly1305_emit,%function
+.align	5
+poly1305_emit:
+.Lpoly1305_emit:
+	ldp	x4,x5,[x0]		// load hash base 2^64
+	ldp	x6,x7,[x0,#16]	// [along with is_base2_26]
+	ldp	x10,x11,[x2]	// load nonce
+
+#ifdef	__AARCH64EB__
+	lsr	x12,x4,#32
+	mov	w13,w4
+	lsr	x14,x5,#32
+	mov	w15,w5
+	lsr	x16,x6,#32
+#else
+	mov	w12,w4
+	lsr	x13,x4,#32
+	mov	w14,w5
+	lsr	x15,x5,#32
+	mov	w16,w6
+#endif
+
+	add	x12,x12,x13,lsl#26	// base 2^26 -> base 2^64
+	lsr	x13,x14,#12
+	adds	x12,x12,x14,lsl#52
+	add	x13,x13,x15,lsl#14
+	adc	x13,x13,xzr
+	lsr	x14,x16,#24
+	adds	x13,x13,x16,lsl#40
+	adc	x14,x14,xzr
+
+	cmp	x7,#0			// is_base2_26?
+	csel	x4,x4,x12,eq		// choose between radixes
+	csel	x5,x5,x13,eq
+	csel	x6,x6,x14,eq
+
+	adds	x12,x4,#5		// compare to modulus
+	adcs	x13,x5,xzr
+	adc	x14,x6,xzr
+
+	tst	x14,#-4			// see if it's carried/borrowed
+
+	csel	x4,x4,x12,eq
+	csel	x5,x5,x13,eq
+
+#ifdef	__AARCH64EB__
+	ror	x10,x10,#32		// flip nonce words
+	ror	x11,x11,#32
+#endif
+	adds	x4,x4,x10		// accumulate nonce
+	adc	x5,x5,x11
+#ifdef	__AARCH64EB__
+	rev	x4,x4			// flip output bytes
+	rev	x5,x5
+#endif
+	stp	x4,x5,[x1]		// write result
+
+	ret
+.size	poly1305_emit,.-poly1305_emit
+.type	poly1305_mult,%function
+.align	5
+poly1305_mult:
+	mul	x12,x4,x7		// h0*r0
+	umulh	x13,x4,x7
+
+	mul	x10,x5,x9		// h1*5*r1
+	umulh	x11,x5,x9
+
+	adds	x12,x12,x10
+	mul	x10,x4,x8		// h0*r1
+	adc	x13,x13,x11
+	umulh	x14,x4,x8
+
+	adds	x13,x13,x10
+	mul	x10,x5,x7		// h1*r0
+	adc	x14,x14,xzr
+	umulh	x11,x5,x7
+
+	adds	x13,x13,x10
+	mul	x10,x6,x9		// h2*5*r1
+	adc	x14,x14,x11
+	mul	x11,x6,x7		// h2*r0
+
+	adds	x13,x13,x10
+	adc	x14,x14,x11
+
+	and	x10,x14,#-4		// final reduction
+	and	x6,x14,#3
+	add	x10,x10,x14,lsr#2
+	adds	x4,x12,x10
+	adcs	x5,x13,xzr
+	adc	x6,x6,xzr
+
+	ret
+.size	poly1305_mult,.-poly1305_mult
+
+.type	poly1305_splat,%function
+.align	4
+poly1305_splat:
+	and	x12,x4,#0x03ffffff	// base 2^64 -> base 2^26
+	ubfx	x13,x4,#26,#26
+	extr	x14,x5,x4,#52
+	and	x14,x14,#0x03ffffff
+	ubfx	x15,x5,#14,#26
+	extr	x16,x6,x5,#40
+
+	str	w12,[x0,#16*0]	// r0
+	add	w12,w13,w13,lsl#2	// r1*5
+	str	w13,[x0,#16*1]	// r1
+	add	w13,w14,w14,lsl#2	// r2*5
+	str	w12,[x0,#16*2]	// s1
+	str	w14,[x0,#16*3]	// r2
+	add	w14,w15,w15,lsl#2	// r3*5
+	str	w13,[x0,#16*4]	// s2
+	str	w15,[x0,#16*5]	// r3
+	add	w15,w16,w16,lsl#2	// r4*5
+	str	w14,[x0,#16*6]	// s3
+	str	w16,[x0,#16*7]	// r4
+	str	w15,[x0,#16*8]	// s4
+
+	ret
+.size	poly1305_splat,.-poly1305_splat
+
+#ifdef	__KERNEL__
+.globl	poly1305_blocks_neon
+#endif
+.type	poly1305_blocks_neon,%function
+.align	5
+poly1305_blocks_neon:
+.Lpoly1305_blocks_neon:
+	ldr	x17,[x0,#24]
+	cmp	x2,#128
+	b.lo	.Lpoly1305_blocks
+
+	.inst	0xd503233f		// paciasp
+	stp	x29,x30,[sp,#-80]!
+	add	x29,sp,#0
+
+	stp	d8,d9,[sp,#16]		// meet ABI requirements
+	stp	d10,d11,[sp,#32]
+	stp	d12,d13,[sp,#48]
+	stp	d14,d15,[sp,#64]
+
+	cbz	x17,.Lbase2_64_neon
+
+	ldp	w10,w11,[x0]		// load hash value base 2^26
+	ldp	w12,w13,[x0,#8]
+	ldr	w14,[x0,#16]
+
+	tst	x2,#31
+	b.eq	.Leven_neon
+
+	ldp	x7,x8,[x0,#32]	// load key value
+
+	add	x4,x10,x11,lsl#26	// base 2^26 -> base 2^64
+	lsr	x5,x12,#12
+	adds	x4,x4,x12,lsl#52
+	add	x5,x5,x13,lsl#14
+	adc	x5,x5,xzr
+	lsr	x6,x14,#24
+	adds	x5,x5,x14,lsl#40
+	adc	x14,x6,xzr		// can be partially reduced...
+
+	ldp	x12,x13,[x1],#16	// load input
+	sub	x2,x2,#16
+	add	x9,x8,x8,lsr#2	// s1 = r1 + (r1 >> 2)
+
+#ifdef	__AARCH64EB__
+	rev	x12,x12
+	rev	x13,x13
+#endif
+	adds	x4,x4,x12		// accumulate input
+	adcs	x5,x5,x13
+	adc	x6,x6,x3
+
+	bl	poly1305_mult
+
+	and	x10,x4,#0x03ffffff	// base 2^64 -> base 2^26
+	ubfx	x11,x4,#26,#26
+	extr	x12,x5,x4,#52
+	and	x12,x12,#0x03ffffff
+	ubfx	x13,x5,#14,#26
+	extr	x14,x6,x5,#40
+
+	b	.Leven_neon
+
+.align	4
+.Lbase2_64_neon:
+	ldp	x7,x8,[x0,#32]	// load key value
+
+	ldp	x4,x5,[x0]		// load hash value base 2^64
+	ldr	x6,[x0,#16]
+
+	tst	x2,#31
+	b.eq	.Linit_neon
+
+	ldp	x12,x13,[x1],#16	// load input
+	sub	x2,x2,#16
+	add	x9,x8,x8,lsr#2	// s1 = r1 + (r1 >> 2)
+#ifdef	__AARCH64EB__
+	rev	x12,x12
+	rev	x13,x13
+#endif
+	adds	x4,x4,x12		// accumulate input
+	adcs	x5,x5,x13
+	adc	x6,x6,x3
+
+	bl	poly1305_mult
+
+.Linit_neon:
+	ldr	w17,[x0,#48]		// first table element
+	and	x10,x4,#0x03ffffff	// base 2^64 -> base 2^26
+	ubfx	x11,x4,#26,#26
+	extr	x12,x5,x4,#52
+	and	x12,x12,#0x03ffffff
+	ubfx	x13,x5,#14,#26
+	extr	x14,x6,x5,#40
+
+	cmp	w17,#-1			// is value impossible?
+	b.ne	.Leven_neon
+
+	fmov	d24,x10
+	fmov	d25,x11
+	fmov	d26,x12
+	fmov	d27,x13
+	fmov	d28,x14
+
+	////////////////////////////////// initialize r^n table
+	mov	x4,x7			// r^1
+	add	x9,x8,x8,lsr#2	// s1 = r1 + (r1 >> 2)
+	mov	x5,x8
+	mov	x6,xzr
+	add	x0,x0,#48+12
+	bl	poly1305_splat
+
+	bl	poly1305_mult		// r^2
+	sub	x0,x0,#4
+	bl	poly1305_splat
+
+	bl	poly1305_mult		// r^3
+	sub	x0,x0,#4
+	bl	poly1305_splat
+
+	bl	poly1305_mult		// r^4
+	sub	x0,x0,#4
+	bl	poly1305_splat
+	sub	x0,x0,#48		// restore original x0
+	b	.Ldo_neon
+
+.align	4
+.Leven_neon:
+	fmov	d24,x10
+	fmov	d25,x11
+	fmov	d26,x12
+	fmov	d27,x13
+	fmov	d28,x14
+
+.Ldo_neon:
+	ldp	x8,x12,[x1,#32]	// inp[2:3]
+	subs	x2,x2,#64
+	ldp	x9,x13,[x1,#48]
+	add	x16,x1,#96
+	adr	x17,.Lzeros
+
+	lsl	x3,x3,#24
+	add	x15,x0,#48
+
+#ifdef	__AARCH64EB__
+	rev	x8,x8
+	rev	x12,x12
+	rev	x9,x9
+	rev	x13,x13
+#endif
+	and	x4,x8,#0x03ffffff	// base 2^64 -> base 2^26
+	and	x5,x9,#0x03ffffff
+	ubfx	x6,x8,#26,#26
+	ubfx	x7,x9,#26,#26
+	add	x4,x4,x5,lsl#32		// bfi	x4,x5,#32,#32
+	extr	x8,x12,x8,#52
+	extr	x9,x13,x9,#52
+	add	x6,x6,x7,lsl#32		// bfi	x6,x7,#32,#32
+	fmov	d14,x4
+	and	x8,x8,#0x03ffffff
+	and	x9,x9,#0x03ffffff
+	ubfx	x10,x12,#14,#26
+	ubfx	x11,x13,#14,#26
+	add	x12,x3,x12,lsr#40
+	add	x13,x3,x13,lsr#40
+	add	x8,x8,x9,lsl#32		// bfi	x8,x9,#32,#32
+	fmov	d15,x6
+	add	x10,x10,x11,lsl#32	// bfi	x10,x11,#32,#32
+	add	x12,x12,x13,lsl#32	// bfi	x12,x13,#32,#32
+	fmov	d16,x8
+	fmov	d17,x10
+	fmov	d18,x12
+
+	ldp	x8,x12,[x1],#16	// inp[0:1]
+	ldp	x9,x13,[x1],#48
+
+	ld1	{v0.4s,v1.4s,v2.4s,v3.4s},[x15],#64
+	ld1	{v4.4s,v5.4s,v6.4s,v7.4s},[x15],#64
+	ld1	{v8.4s},[x15]
+
+#ifdef	__AARCH64EB__
+	rev	x8,x8
+	rev	x12,x12
+	rev	x9,x9
+	rev	x13,x13
+#endif
+	and	x4,x8,#0x03ffffff	// base 2^64 -> base 2^26
+	and	x5,x9,#0x03ffffff
+	ubfx	x6,x8,#26,#26
+	ubfx	x7,x9,#26,#26
+	add	x4,x4,x5,lsl#32		// bfi	x4,x5,#32,#32
+	extr	x8,x12,x8,#52
+	extr	x9,x13,x9,#52
+	add	x6,x6,x7,lsl#32		// bfi	x6,x7,#32,#32
+	fmov	d9,x4
+	and	x8,x8,#0x03ffffff
+	and	x9,x9,#0x03ffffff
+	ubfx	x10,x12,#14,#26
+	ubfx	x11,x13,#14,#26
+	add	x12,x3,x12,lsr#40
+	add	x13,x3,x13,lsr#40
+	add	x8,x8,x9,lsl#32		// bfi	x8,x9,#32,#32
+	fmov	d10,x6
+	add	x10,x10,x11,lsl#32	// bfi	x10,x11,#32,#32
+	add	x12,x12,x13,lsl#32	// bfi	x12,x13,#32,#32
+	movi	v31.2d,#-1
+	fmov	d11,x8
+	fmov	d12,x10
+	fmov	d13,x12
+	ushr	v31.2d,v31.2d,#38
+
+	b.ls	.Lskip_loop
+
+.align	4
+.Loop_neon:
+	////////////////////////////////////////////////////////////////
+	// ((inp[0]*r^4+inp[2]*r^2+inp[4])*r^4+inp[6]*r^2
+	// ((inp[1]*r^4+inp[3]*r^2+inp[5])*r^3+inp[7]*r
+	//   ___________________/
+	// ((inp[0]*r^4+inp[2]*r^2+inp[4])*r^4+inp[6]*r^2+inp[8])*r^2
+	// ((inp[1]*r^4+inp[3]*r^2+inp[5])*r^4+inp[7]*r^2+inp[9])*r
+	//   ___________________/ ____________________/
+	//
+	// Note that we start with inp[2:3]*r^2. This is because it
+	// doesn't depend on reduction in previous iteration.
+	////////////////////////////////////////////////////////////////
+	// d4 = h0*r4 + h1*r3   + h2*r2   + h3*r1   + h4*r0
+	// d3 = h0*r3 + h1*r2   + h2*r1   + h3*r0   + h4*5*r4
+	// d2 = h0*r2 + h1*r1   + h2*r0   + h3*5*r4 + h4*5*r3
+	// d1 = h0*r1 + h1*r0   + h2*5*r4 + h3*5*r3 + h4*5*r2
+	// d0 = h0*r0 + h1*5*r4 + h2*5*r3 + h3*5*r2 + h4*5*r1
+
+	subs	x2,x2,#64
+	umull	v23.2d,v14.2s,v7.s[2]
+	csel	x16,x17,x16,lo
+	umull	v22.2d,v14.2s,v5.s[2]
+	umull	v21.2d,v14.2s,v3.s[2]
+	 ldp	x8,x12,[x16],#16	// inp[2:3] (or zero)
+	umull	v20.2d,v14.2s,v1.s[2]
+	 ldp	x9,x13,[x16],#48
+	umull	v19.2d,v14.2s,v0.s[2]
+#ifdef	__AARCH64EB__
+	 rev	x8,x8
+	 rev	x12,x12
+	 rev	x9,x9
+	 rev	x13,x13
+#endif
+
+	umlal	v23.2d,v15.2s,v5.s[2]
+	 and	x4,x8,#0x03ffffff	// base 2^64 -> base 2^26
+	umlal	v22.2d,v15.2s,v3.s[2]
+	 and	x5,x9,#0x03ffffff
+	umlal	v21.2d,v15.2s,v1.s[2]
+	 ubfx	x6,x8,#26,#26
+	umlal	v20.2d,v15.2s,v0.s[2]
+	 ubfx	x7,x9,#26,#26
+	umlal	v19.2d,v15.2s,v8.s[2]
+	 add	x4,x4,x5,lsl#32		// bfi	x4,x5,#32,#32
+
+	umlal	v23.2d,v16.2s,v3.s[2]
+	 extr	x8,x12,x8,#52
+	umlal	v22.2d,v16.2s,v1.s[2]
+	 extr	x9,x13,x9,#52
+	umlal	v21.2d,v16.2s,v0.s[2]
+	 add	x6,x6,x7,lsl#32		// bfi	x6,x7,#32,#32
+	umlal	v20.2d,v16.2s,v8.s[2]
+	 fmov	d14,x4
+	umlal	v19.2d,v16.2s,v6.s[2]
+	 and	x8,x8,#0x03ffffff
+
+	umlal	v23.2d,v17.2s,v1.s[2]
+	 and	x9,x9,#0x03ffffff
+	umlal	v22.2d,v17.2s,v0.s[2]
+	 ubfx	x10,x12,#14,#26
+	umlal	v21.2d,v17.2s,v8.s[2]
+	 ubfx	x11,x13,#14,#26
+	umlal	v20.2d,v17.2s,v6.s[2]
+	 add	x8,x8,x9,lsl#32		// bfi	x8,x9,#32,#32
+	umlal	v19.2d,v17.2s,v4.s[2]
+	 fmov	d15,x6
+
+	add	v11.2s,v11.2s,v26.2s
+	 add	x12,x3,x12,lsr#40
+	umlal	v23.2d,v18.2s,v0.s[2]
+	 add	x13,x3,x13,lsr#40
+	umlal	v22.2d,v18.2s,v8.s[2]
+	 add	x10,x10,x11,lsl#32	// bfi	x10,x11,#32,#32
+	umlal	v21.2d,v18.2s,v6.s[2]
+	 add	x12,x12,x13,lsl#32	// bfi	x12,x13,#32,#32
+	umlal	v20.2d,v18.2s,v4.s[2]
+	 fmov	d16,x8
+	umlal	v19.2d,v18.2s,v2.s[2]
+	 fmov	d17,x10
+
+	////////////////////////////////////////////////////////////////
+	// (hash+inp[0:1])*r^4 and accumulate
+
+	add	v9.2s,v9.2s,v24.2s
+	 fmov	d18,x12
+	umlal	v22.2d,v11.2s,v1.s[0]
+	 ldp	x8,x12,[x1],#16	// inp[0:1]
+	umlal	v19.2d,v11.2s,v6.s[0]
+	 ldp	x9,x13,[x1],#48
+	umlal	v23.2d,v11.2s,v3.s[0]
+	umlal	v20.2d,v11.2s,v8.s[0]
+	umlal	v21.2d,v11.2s,v0.s[0]
+#ifdef	__AARCH64EB__
+	 rev	x8,x8
+	 rev	x12,x12
+	 rev	x9,x9
+	 rev	x13,x13
+#endif
+
+	add	v10.2s,v10.2s,v25.2s
+	umlal	v22.2d,v9.2s,v5.s[0]
+	umlal	v23.2d,v9.2s,v7.s[0]
+	 and	x4,x8,#0x03ffffff	// base 2^64 -> base 2^26
+	umlal	v21.2d,v9.2s,v3.s[0]
+	 and	x5,x9,#0x03ffffff
+	umlal	v19.2d,v9.2s,v0.s[0]
+	 ubfx	x6,x8,#26,#26
+	umlal	v20.2d,v9.2s,v1.s[0]
+	 ubfx	x7,x9,#26,#26
+
+	add	v12.2s,v12.2s,v27.2s
+	 add	x4,x4,x5,lsl#32		// bfi	x4,x5,#32,#32
+	umlal	v22.2d,v10.2s,v3.s[0]
+	 extr	x8,x12,x8,#52
+	umlal	v23.2d,v10.2s,v5.s[0]
+	 extr	x9,x13,x9,#52
+	umlal	v19.2d,v10.2s,v8.s[0]
+	 add	x6,x6,x7,lsl#32		// bfi	x6,x7,#32,#32
+	umlal	v21.2d,v10.2s,v1.s[0]
+	 fmov	d9,x4
+	umlal	v20.2d,v10.2s,v0.s[0]
+	 and	x8,x8,#0x03ffffff
+
+	add	v13.2s,v13.2s,v28.2s
+	 and	x9,x9,#0x03ffffff
+	umlal	v22.2d,v12.2s,v0.s[0]
+	 ubfx	x10,x12,#14,#26
+	umlal	v19.2d,v12.2s,v4.s[0]
+	 ubfx	x11,x13,#14,#26
+	umlal	v23.2d,v12.2s,v1.s[0]
+	 add	x8,x8,x9,lsl#32		// bfi	x8,x9,#32,#32
+	umlal	v20.2d,v12.2s,v6.s[0]
+	 fmov	d10,x6
+	umlal	v21.2d,v12.2s,v8.s[0]
+	 add	x12,x3,x12,lsr#40
+
+	umlal	v22.2d,v13.2s,v8.s[0]
+	 add	x13,x3,x13,lsr#40
+	umlal	v19.2d,v13.2s,v2.s[0]
+	 add	x10,x10,x11,lsl#32	// bfi	x10,x11,#32,#32
+	umlal	v23.2d,v13.2s,v0.s[0]
+	 add	x12,x12,x13,lsl#32	// bfi	x12,x13,#32,#32
+	umlal	v20.2d,v13.2s,v4.s[0]
+	 fmov	d11,x8
+	umlal	v21.2d,v13.2s,v6.s[0]
+	 fmov	d12,x10
+	 fmov	d13,x12
+
+	/////////////////////////////////////////////////////////////////
+	// lazy reduction as discussed in "NEON crypto" by D.J. Bernstein
+	// and P. Schwabe
+	//
+	// [see discussion in poly1305-armv4 module]
+
+	ushr	v29.2d,v22.2d,#26
+	xtn	v27.2s,v22.2d
+	 ushr	v30.2d,v19.2d,#26
+	 and	v19.16b,v19.16b,v31.16b
+	add	v23.2d,v23.2d,v29.2d	// h3 -> h4
+	bic	v27.2s,#0xfc,lsl#24	// &=0x03ffffff
+	 add	v20.2d,v20.2d,v30.2d	// h0 -> h1
+
+	ushr	v29.2d,v23.2d,#26
+	xtn	v28.2s,v23.2d
+	 ushr	v30.2d,v20.2d,#26
+	 xtn	v25.2s,v20.2d
+	bic	v28.2s,#0xfc,lsl#24
+	 add	v21.2d,v21.2d,v30.2d	// h1 -> h2
+
+	add	v19.2d,v19.2d,v29.2d
+	shl	v29.2d,v29.2d,#2
+	 shrn	v30.2s,v21.2d,#26
+	 xtn	v26.2s,v21.2d
+	add	v19.2d,v19.2d,v29.2d	// h4 -> h0
+	 bic	v25.2s,#0xfc,lsl#24
+	 add	v27.2s,v27.2s,v30.2s		// h2 -> h3
+	 bic	v26.2s,#0xfc,lsl#24
+
+	shrn	v29.2s,v19.2d,#26
+	xtn	v24.2s,v19.2d
+	 ushr	v30.2s,v27.2s,#26
+	 bic	v27.2s,#0xfc,lsl#24
+	 bic	v24.2s,#0xfc,lsl#24
+	add	v25.2s,v25.2s,v29.2s		// h0 -> h1
+	 add	v28.2s,v28.2s,v30.2s		// h3 -> h4
+
+	b.hi	.Loop_neon
+
+.Lskip_loop:
+	dup	v16.2d,v16.d[0]
+	add	v11.2s,v11.2s,v26.2s
+
+	////////////////////////////////////////////////////////////////
+	// multiply (inp[0:1]+hash) or inp[2:3] by r^2:r^1
+
+	adds	x2,x2,#32
+	b.ne	.Long_tail
+
+	dup	v16.2d,v11.d[0]
+	add	v14.2s,v9.2s,v24.2s
+	add	v17.2s,v12.2s,v27.2s
+	add	v15.2s,v10.2s,v25.2s
+	add	v18.2s,v13.2s,v28.2s
+
+.Long_tail:
+	dup	v14.2d,v14.d[0]
+	umull2	v19.2d,v16.4s,v6.4s
+	umull2	v22.2d,v16.4s,v1.4s
+	umull2	v23.2d,v16.4s,v3.4s
+	umull2	v21.2d,v16.4s,v0.4s
+	umull2	v20.2d,v16.4s,v8.4s
+
+	dup	v15.2d,v15.d[0]
+	umlal2	v19.2d,v14.4s,v0.4s
+	umlal2	v21.2d,v14.4s,v3.4s
+	umlal2	v22.2d,v14.4s,v5.4s
+	umlal2	v23.2d,v14.4s,v7.4s
+	umlal2	v20.2d,v14.4s,v1.4s
+
+	dup	v17.2d,v17.d[0]
+	umlal2	v19.2d,v15.4s,v8.4s
+	umlal2	v22.2d,v15.4s,v3.4s
+	umlal2	v21.2d,v15.4s,v1.4s
+	umlal2	v23.2d,v15.4s,v5.4s
+	umlal2	v20.2d,v15.4s,v0.4s
+
+	dup	v18.2d,v18.d[0]
+	umlal2	v22.2d,v17.4s,v0.4s
+	umlal2	v23.2d,v17.4s,v1.4s
+	umlal2	v19.2d,v17.4s,v4.4s
+	umlal2	v20.2d,v17.4s,v6.4s
+	umlal2	v21.2d,v17.4s,v8.4s
+
+	umlal2	v22.2d,v18.4s,v8.4s
+	umlal2	v19.2d,v18.4s,v2.4s
+	umlal2	v23.2d,v18.4s,v0.4s
+	umlal2	v20.2d,v18.4s,v4.4s
+	umlal2	v21.2d,v18.4s,v6.4s
+
+	b.eq	.Lshort_tail
+
+	////////////////////////////////////////////////////////////////
+	// (hash+inp[0:1])*r^4:r^3 and accumulate
+
+	add	v9.2s,v9.2s,v24.2s
+	umlal	v22.2d,v11.2s,v1.2s
+	umlal	v19.2d,v11.2s,v6.2s
+	umlal	v23.2d,v11.2s,v3.2s
+	umlal	v20.2d,v11.2s,v8.2s
+	umlal	v21.2d,v11.2s,v0.2s
+
+	add	v10.2s,v10.2s,v25.2s
+	umlal	v22.2d,v9.2s,v5.2s
+	umlal	v19.2d,v9.2s,v0.2s
+	umlal	v23.2d,v9.2s,v7.2s
+	umlal	v20.2d,v9.2s,v1.2s
+	umlal	v21.2d,v9.2s,v3.2s
+
+	add	v12.2s,v12.2s,v27.2s
+	umlal	v22.2d,v10.2s,v3.2s
+	umlal	v19.2d,v10.2s,v8.2s
+	umlal	v23.2d,v10.2s,v5.2s
+	umlal	v20.2d,v10.2s,v0.2s
+	umlal	v21.2d,v10.2s,v1.2s
+
+	add	v13.2s,v13.2s,v28.2s
+	umlal	v22.2d,v12.2s,v0.2s
+	umlal	v19.2d,v12.2s,v4.2s
+	umlal	v23.2d,v12.2s,v1.2s
+	umlal	v20.2d,v12.2s,v6.2s
+	umlal	v21.2d,v12.2s,v8.2s
+
+	umlal	v22.2d,v13.2s,v8.2s
+	umlal	v19.2d,v13.2s,v2.2s
+	umlal	v23.2d,v13.2s,v0.2s
+	umlal	v20.2d,v13.2s,v4.2s
+	umlal	v21.2d,v13.2s,v6.2s
+
+.Lshort_tail:
+	////////////////////////////////////////////////////////////////
+	// horizontal add
+
+	addp	v22.2d,v22.2d,v22.2d
+	 ldp	d8,d9,[sp,#16]		// meet ABI requirements
+	addp	v19.2d,v19.2d,v19.2d
+	 ldp	d10,d11,[sp,#32]
+	addp	v23.2d,v23.2d,v23.2d
+	 ldp	d12,d13,[sp,#48]
+	addp	v20.2d,v20.2d,v20.2d
+	 ldp	d14,d15,[sp,#64]
+	addp	v21.2d,v21.2d,v21.2d
+	 ldr	x30,[sp,#8]
+	 .inst	0xd50323bf		// autiasp
+
+	////////////////////////////////////////////////////////////////
+	// lazy reduction, but without narrowing
+
+	ushr	v29.2d,v22.2d,#26
+	and	v22.16b,v22.16b,v31.16b
+	 ushr	v30.2d,v19.2d,#26
+	 and	v19.16b,v19.16b,v31.16b
+
+	add	v23.2d,v23.2d,v29.2d	// h3 -> h4
+	 add	v20.2d,v20.2d,v30.2d	// h0 -> h1
+
+	ushr	v29.2d,v23.2d,#26
+	and	v23.16b,v23.16b,v31.16b
+	 ushr	v30.2d,v20.2d,#26
+	 and	v20.16b,v20.16b,v31.16b
+	 add	v21.2d,v21.2d,v30.2d	// h1 -> h2
+
+	add	v19.2d,v19.2d,v29.2d
+	shl	v29.2d,v29.2d,#2
+	 ushr	v30.2d,v21.2d,#26
+	 and	v21.16b,v21.16b,v31.16b
+	add	v19.2d,v19.2d,v29.2d	// h4 -> h0
+	 add	v22.2d,v22.2d,v30.2d	// h2 -> h3
+
+	ushr	v29.2d,v19.2d,#26
+	and	v19.16b,v19.16b,v31.16b
+	 ushr	v30.2d,v22.2d,#26
+	 and	v22.16b,v22.16b,v31.16b
+	add	v20.2d,v20.2d,v29.2d	// h0 -> h1
+	 add	v23.2d,v23.2d,v30.2d	// h3 -> h4
+
+	////////////////////////////////////////////////////////////////
+	// write the result, can be partially reduced
+
+	st4	{v19.s,v20.s,v21.s,v22.s}[0],[x0],#16
+	mov	x4,#1
+	st1	{v23.s}[0],[x0]
+	str	x4,[x0,#8]		// set is_base2_26
+
+	ldr	x29,[sp],#80
+	ret
+.size	poly1305_blocks_neon,.-poly1305_blocks_neon
+
+.align	5
+.Lzeros:
+.long	0,0,0,0,0,0,0,0
+.asciz	"Poly1305 for ARMv8, CRYPTOGAMS by @dot-asm"
+.align	2
+#if !defined(__KERNEL__) && !defined(_WIN64)
+.comm	OPENSSL_armcap_P,4,4
+.hidden	OPENSSL_armcap_P
+#endif
diff --git a/arch/arm64/crypto/poly1305-glue.c b/arch/arm64/crypto/poly1305-glue.c
new file mode 100644
index 000000000000..9cba4d4430fc
--- /dev/null
+++ b/arch/arm64/crypto/poly1305-glue.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * OpenSSL/Cryptogams accelerated Poly1305 transform for arm64
+ *
+ * Copyright (C) 2019 Linaro Ltd. <ard.biesheuvel@linaro.org>
+ */
+
+#include <asm/neon.h>
+#include <asm/simd.h>
+#include <asm/unaligned.h>
+#include <crypto/algapi.h>
+#include <crypto/internal/hash.h>
+#include <crypto/internal/poly1305.h>
+#include <crypto/internal/simd.h>
+#include <linux/cpufeature.h>
+#include <linux/crypto.h>
+#include <linux/module.h>
+
+asmlinkage void poly1305_init_arm64(void *state, const u8 *key);
+asmlinkage void poly1305_blocks(void *state, const u8 *src, u32 len, u32 hibit);
+asmlinkage void poly1305_blocks_neon(void *state, const u8 *src, u32 len, u32 hibit);
+asmlinkage void poly1305_emit(void *state, __le32 *digest, const u32 *nonce);
+
+void poly1305_init(struct poly1305_desc_ctx *dctx, const u8 *key)
+{
+	poly1305_init_arm64(&dctx->h, key);
+	dctx->s[0] = get_unaligned_le32(key + 16);
+	dctx->s[1] = get_unaligned_le32(key + 20);
+	dctx->s[2] = get_unaligned_le32(key + 24);
+	dctx->s[3] = get_unaligned_le32(key + 28);
+	dctx->buflen = 0;
+}
+EXPORT_SYMBOL(poly1305_init);
+
+static int neon_poly1305_init(struct shash_desc *desc)
+{
+	struct poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
+
+	dctx->buflen = 0;
+	dctx->rset = 0;
+	dctx->sset = false;
+
+	return 0;
+}
+
+static void neon_poly1305_blocks(struct poly1305_desc_ctx *dctx, const u8 *src,
+				 u32 len, u32 hibit, bool do_neon)
+{
+	if (unlikely(!dctx->sset)) {
+		if (!dctx->rset) {
+			poly1305_init(dctx, src);
+			src += POLY1305_BLOCK_SIZE;
+			len -= POLY1305_BLOCK_SIZE;
+			dctx->rset = 1;
+		}
+		if (len >= POLY1305_BLOCK_SIZE) {
+			dctx->s[0] = get_unaligned_le32(src +  0);
+			dctx->s[1] = get_unaligned_le32(src +  4);
+			dctx->s[2] = get_unaligned_le32(src +  8);
+			dctx->s[3] = get_unaligned_le32(src + 12);
+			src += POLY1305_BLOCK_SIZE;
+			len -= POLY1305_BLOCK_SIZE;
+			dctx->sset = true;
+		}
+		if (len < POLY1305_BLOCK_SIZE)
+			return;
+	}
+
+	len &= ~(POLY1305_BLOCK_SIZE - 1);
+
+	if (likely(do_neon))
+		poly1305_blocks_neon(&dctx->h, src, len, hibit);
+	else
+		poly1305_blocks(&dctx->h, src, len, hibit);
+}
+
+static void neon_poly1305_do_update(struct poly1305_desc_ctx *dctx,
+				    const u8 *src, u32 len, bool do_neon)
+{
+	if (unlikely(dctx->buflen)) {
+		u32 bytes = min(len, POLY1305_BLOCK_SIZE - dctx->buflen);
+
+		memcpy(dctx->buf + dctx->buflen, src, bytes);
+		src += bytes;
+		len -= bytes;
+		dctx->buflen += bytes;
+
+		if (dctx->buflen == POLY1305_BLOCK_SIZE) {
+			neon_poly1305_blocks(dctx, dctx->buf,
+					     POLY1305_BLOCK_SIZE, 1, false);
+			dctx->buflen = 0;
+		}
+	}
+
+	if (likely(len >= POLY1305_BLOCK_SIZE)) {
+		neon_poly1305_blocks(dctx, src, len, 1, do_neon);
+		src += round_down(len, POLY1305_BLOCK_SIZE);
+		len %= POLY1305_BLOCK_SIZE;
+	}
+
+	if (unlikely(len)) {
+		dctx->buflen = len;
+		memcpy(dctx->buf, src, len);
+	}
+}
+
+static int neon_poly1305_update(struct shash_desc *desc,
+				const u8 *src, unsigned int srclen)
+{
+	bool do_neon = crypto_simd_usable() && srclen > 128;
+	struct poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
+
+	if (do_neon)
+		kernel_neon_begin();
+	neon_poly1305_do_update(dctx, src, srclen, do_neon);
+	if (do_neon)
+		kernel_neon_end();
+	return 0;
+}
+
+void poly1305_update(struct poly1305_desc_ctx *dctx, const u8 *src,
+		     unsigned int nbytes)
+{
+	bool do_neon = crypto_simd_usable() && nbytes > 128;
+
+	if (unlikely(dctx->buflen)) {
+		u32 bytes = min(nbytes, POLY1305_BLOCK_SIZE - dctx->buflen);
+
+		memcpy(dctx->buf + dctx->buflen, src, bytes);
+		src += bytes;
+		nbytes -= bytes;
+		dctx->buflen += bytes;
+
+		if (dctx->buflen == POLY1305_BLOCK_SIZE) {
+			poly1305_blocks(&dctx->h, dctx->buf, POLY1305_BLOCK_SIZE, 1);
+			dctx->buflen = 0;
+		}
+	}
+
+	if (likely(nbytes >= POLY1305_BLOCK_SIZE)) {
+		unsigned int len = round_down(nbytes, POLY1305_BLOCK_SIZE);
+
+		if (do_neon) {
+			kernel_neon_begin();
+			poly1305_blocks_neon(&dctx->h, src, len, 1);
+			kernel_neon_end();
+		} else {
+			poly1305_blocks(&dctx->h, src, len, 1);
+		}
+		src += len;
+		nbytes %= POLY1305_BLOCK_SIZE;
+	}
+
+	if (unlikely(nbytes)) {
+		dctx->buflen = nbytes;
+		memcpy(dctx->buf, src, nbytes);
+	}
+}
+EXPORT_SYMBOL(poly1305_update);
+
+void poly1305_final(struct poly1305_desc_ctx *dctx, u8 *dst)
+{
+	__le32 digest[4];
+	u64 f = 0;
+
+	if (unlikely(dctx->buflen)) {
+		dctx->buf[dctx->buflen++] = 1;
+		memset(dctx->buf + dctx->buflen, 0,
+		       POLY1305_BLOCK_SIZE - dctx->buflen);
+		poly1305_blocks(&dctx->h, dctx->buf, POLY1305_BLOCK_SIZE, 0);
+	}
+
+	poly1305_emit(&dctx->h, digest, dctx->s);
+
+	/* mac = (h + s) % (2^128) */
+	f = (f >> 32) + le32_to_cpu(digest[0]);
+	put_unaligned_le32(f, dst);
+	f = (f >> 32) + le32_to_cpu(digest[1]);
+	put_unaligned_le32(f, dst + 4);
+	f = (f >> 32) + le32_to_cpu(digest[2]);
+	put_unaligned_le32(f, dst + 8);
+	f = (f >> 32) + le32_to_cpu(digest[3]);
+	put_unaligned_le32(f, dst + 12);
+
+	*dctx = (struct poly1305_desc_ctx){};
+}
+EXPORT_SYMBOL(poly1305_final);
+
+static int neon_poly1305_final(struct shash_desc *desc, u8 *dst)
+{
+	struct poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
+
+	if (unlikely(!dctx->sset))
+		return -ENOKEY;
+
+	poly1305_final(dctx, dst);
+	return 0;
+}
+
+static struct shash_alg neon_poly1305_alg = {
+	.init			= neon_poly1305_init,
+	.update			= neon_poly1305_update,
+	.final			= neon_poly1305_final,
+	.digestsize		= POLY1305_DIGEST_SIZE,
+	.descsize		= sizeof(struct poly1305_desc_ctx),
+
+	.base.cra_name		= "poly1305",
+	.base.cra_driver_name	= "poly1305-neon",
+	.base.cra_priority	= 200,
+	.base.cra_blocksize	= POLY1305_BLOCK_SIZE,
+	.base.cra_module	= THIS_MODULE,
+};
+
+static int __init neon_poly1305_mod_init(void)
+{
+	return crypto_register_shash(&neon_poly1305_alg);
+}
+
+static void __exit neon_poly1305_mod_exit(void)
+{
+	crypto_unregister_shash(&neon_poly1305_alg);
+}
+
+module_init(neon_poly1305_mod_init);
+module_exit(neon_poly1305_mod_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS_CRYPTO("poly1305");
+MODULE_ALIAS_CRYPTO("poly1305-neon");
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 8aae0907ca4e..964fae50245c 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -688,6 +688,7 @@ config CRYPTO_ARCH_HAVE_LIB_POLY1305
 config CRYPTO_LIB_POLY1305_RSIZE
 	int
 	default 4 if X86_64
+	default 9 if ARM64
 	default 1
 
 config CRYPTO_LIB_POLY1305
-- 
2.20.1


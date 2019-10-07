Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7F8CE9BB
	for <lists+linux-crypto@lfdr.de>; Mon,  7 Oct 2019 18:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfJGQqw (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 7 Oct 2019 12:46:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36421 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbfJGQqw (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 7 Oct 2019 12:46:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so16169486wrd.3
        for <linux-crypto@vger.kernel.org>; Mon, 07 Oct 2019 09:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WRUYKAvicaxLiGSl5wQgvt2+oKTdpWapCBBjFfq9jOA=;
        b=T8XKVm8qIxnLBIWWFpj+Sx6rK4S9G5Etqh0wdmjSoRFZP7fvatxoQQu1yWJ04nLccI
         AsUlPIKb9qzjgeAp3bUQs1lSdXxefrx4G4gS6TEnfCOKZ+S2q6ErK6YHod64gKofjb/Z
         DQ7BiNhhHQRd3jTHYMee8nthU4kI9PtCyijNF2x/47H16zdoXzr53+udkFJBciZOuQjH
         YGlvv0ZT9MgBNz1uONHIGJ/oBNblqGCNcBlwcqhED857DhUHuDM84sG1Ni3hzILVJJDX
         uY2udnAUrsGmU6AN6XHdNdtd6iZHc1BgRkT3uJs1Gcmf29NbxoWUZYIJWMV1py5NnMjB
         tUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WRUYKAvicaxLiGSl5wQgvt2+oKTdpWapCBBjFfq9jOA=;
        b=D/kS5SQax57fHXnMLBh8ZKy4T/BucPQ1hWSGK8KTXoAMgo7t1Ce8SbbGb9daJ11HUA
         FlCRtIMJk6kvGVdjZ8I5tvPB8CXCL4ff83C1o3uYOWaMs6LobOY07owfkcuFW3FVlkYy
         FZJzkJKyswWPpVWG60eXdyLbWQpWsDpOJ2vfLS+lvGSg6HrZLSUzdlp063KIkxx/oU6N
         VOXNAzfV030rPCv2HSM9FPkVgdbKL7Og82qItTKDqv6HilsbbZqenKvcdu3Nn7A3szd5
         caI+YE5jwW2j6ycRTKHEk/LozWesjVRXglXYMo4jQGRr0Gf7zQ+R863ZCIEhPs85sZX8
         q9lQ==
X-Gm-Message-State: APjAAAWTVw8JkZywvCfhC4+ezILCOviPPXpN0sdQIZbrr1KWGyuprw+y
        izgoKrYAaOPFxO8dbbRyCG7WzTj3pCM94A==
X-Google-Smtp-Source: APXvYqw3yR9WOoIokzQgenoNa5dDTCntY9tFBaP0/7LekgBYef/FE3jpMI/x3Saezftbo66TovbyPw==
X-Received: by 2002:adf:e791:: with SMTP id n17mr25343249wrm.388.1570466803761;
        Mon, 07 Oct 2019 09:46:43 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
        by smtp.gmail.com with ESMTPSA id b22sm68507wmj.36.2019.10.07.09.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 09:46:43 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Martin Willi <martin@strongswan.org>,
        Rene van Dorst <opensource@vdorst.com>,
        Andy Polyakov <appro@cryptogams.org>
Subject: [PATCH v3 18/29] crypto: arm/poly1305 - incorporate OpenSSL/CRYPTOGAMS NEON implementation
Date:   Mon,  7 Oct 2019 18:45:59 +0200
Message-Id: <20191007164610.6881-19-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191007164610.6881-1-ard.biesheuvel@linaro.org>
References: <20191007164610.6881-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This is a straight import of the OpenSSL/CRYPTOGAMS Poly1305 implementation
for NEON authored by Andy Polyakov, and contributed by him to the OpenSSL
project. The file 'poly1305-armv4.pl' is taken straight from this upstream
GitHub repository [0] at commit ec55a08dc0244ce570c4fc7cade330c60798952f,
and already contains all the changes required to build it as part of a
Linux kernel module.

[0] https://github.com/dot-asm/cryptogams

Co-developed-by: Andy Polyakov <appro@cryptogams.org>
Signed-off-by: Andy Polyakov <appro@cryptogams.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/crypto/Kconfig                 |    5 +
 arch/arm/crypto/Makefile                |   11 +-
 arch/arm/crypto/poly1305-armv4.pl       | 1236 ++++++++++++++++++++
 arch/arm/crypto/poly1305-core.S_shipped | 1158 ++++++++++++++++++
 arch/arm/crypto/poly1305-glue.c         |  273 +++++
 crypto/Kconfig                          |    2 +-
 6 files changed, 2683 insertions(+), 2 deletions(-)

diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
index 265da3801e4f..19411f82468e 100644
--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -130,6 +130,11 @@ config CRYPTO_CHACHA20_NEON
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 
+config CRYPTO_POLY1305_ARM
+	tristate "Accelerated scalar and SIMD Poly1305 hash implementations"
+	select CRYPTO_HASH
+	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+
 config CRYPTO_NHPOLY1305_NEON
 	tristate "NEON accelerated NHPoly1305 hash function (for Adiantum)"
 	depends on KERNEL_MODE_NEON
diff --git a/arch/arm/crypto/Makefile b/arch/arm/crypto/Makefile
index 6b97dffcf90f..521bca069457 100644
--- a/arch/arm/crypto/Makefile
+++ b/arch/arm/crypto/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_CRYPTO_SHA1_ARM_NEON) += sha1-arm-neon.o
 obj-$(CONFIG_CRYPTO_SHA256_ARM) += sha256-arm.o
 obj-$(CONFIG_CRYPTO_SHA512_ARM) += sha512-arm.o
 obj-$(CONFIG_CRYPTO_CHACHA20_NEON) += chacha-neon.o
+obj-$(CONFIG_CRYPTO_POLY1305_ARM) += poly1305-arm.o
 obj-$(CONFIG_CRYPTO_NHPOLY1305_NEON) += nhpoly1305-neon.o
 
 ce-obj-$(CONFIG_CRYPTO_AES_ARM_CE) += aes-arm-ce.o
@@ -55,12 +56,16 @@ crct10dif-arm-ce-y	:= crct10dif-ce-core.o crct10dif-ce-glue.o
 crc32-arm-ce-y:= crc32-ce-core.o crc32-ce-glue.o
 chacha-neon-y := chacha-scalar-core.o chacha-glue.o
 chacha-neon-$(CONFIG_KERNEL_MODE_NEON) += chacha-neon-core.o
+poly1305-arm-y := poly1305-core.o poly1305-glue.o
 nhpoly1305-neon-y := nh-neon-core.o nhpoly1305-neon-glue.o
 
 ifdef REGENERATE_ARM_CRYPTO
 quiet_cmd_perl = PERL    $@
       cmd_perl = $(PERL) $(<) > $(@)
 
+$(src)/poly1305-core.S_shipped: $(src)/poly1305-armv4.pl
+	$(call cmd,perl)
+
 $(src)/sha256-core.S_shipped: $(src)/sha256-armv4.pl
 	$(call cmd,perl)
 
@@ -68,4 +73,8 @@ $(src)/sha512-core.S_shipped: $(src)/sha512-armv4.pl
 	$(call cmd,perl)
 endif
 
-clean-files += sha256-core.S sha512-core.S
+clean-files += poly1305-core.S sha256-core.S sha512-core.S
+
+poly1305-aflags-y := -Dpoly1305_blocks_neon=poly1305_blocks_arm
+poly1305-aflags-$(CONFIG_KERNEL_MODE_NEON) := -U__LINUX_ARM_ARCH__ -D__LINUX_ARM_ARCH__=7
+AFLAGS_poly1305-core.o += $(poly1305-aflags-y)
diff --git a/arch/arm/crypto/poly1305-armv4.pl b/arch/arm/crypto/poly1305-armv4.pl
new file mode 100644
index 000000000000..6d79498d3115
--- /dev/null
+++ b/arch/arm/crypto/poly1305-armv4.pl
@@ -0,0 +1,1236 @@
+#!/usr/bin/env perl
+# SPDX-License-Identifier: GPL-1.0+ OR BSD-3-Clause
+#
+# ====================================================================
+# Written by Andy Polyakov, @dot-asm, initially for the OpenSSL
+# project.
+# ====================================================================
+#
+#			IALU(*)/gcc-4.4		NEON
+#
+# ARM11xx(ARMv6)	7.78/+100%		-
+# Cortex-A5		6.35/+130%		3.00
+# Cortex-A8		6.25/+115%		2.36
+# Cortex-A9		5.10/+95%		2.55
+# Cortex-A15		3.85/+85%		1.25(**)
+# Snapdragon S4		5.70/+100%		1.48(**)
+#
+# (*)	this is for -march=armv6, i.e. with bunch of ldrb loading data;
+# (**)	these are trade-off results, they can be improved by ~8% but at
+#	the cost of 15/12% regression on Cortex-A5/A7, it's even possible
+#	to improve Cortex-A9 result, but then A5/A7 loose more than 20%;
+
+$flavour = shift;
+if ($flavour=~/\w[\w\-]*\.\w+$/) { $output=$flavour; undef $flavour; }
+else { while (($output=shift) && ($output!~/\w[\w\-]*\.\w+$/)) {} }
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
+($ctx,$inp,$len,$padbit)=map("r$_",(0..3));
+
+$code.=<<___;
+#ifndef	__KERNEL__
+# include "arm_arch.h"
+#else
+# define __ARM_ARCH__ __LINUX_ARM_ARCH__
+# define __ARM_MAX_ARCH__ __LINUX_ARM_ARCH__
+# define poly1305_init   poly1305_init_arm
+# define poly1305_blocks poly1305_blocks_arm
+# define poly1305_emit   poly1305_emit_arm
+.globl	poly1305_blocks_neon
+#endif
+
+#if defined(__thumb2__)
+.syntax	unified
+.thumb
+#else
+.code	32
+#endif
+
+.text
+
+.globl	poly1305_emit
+.globl	poly1305_blocks
+.globl	poly1305_init
+.type	poly1305_init,%function
+.align	5
+poly1305_init:
+.Lpoly1305_init:
+	stmdb	sp!,{r4-r11}
+
+	eor	r3,r3,r3
+	cmp	$inp,#0
+	str	r3,[$ctx,#0]		@ zero hash value
+	str	r3,[$ctx,#4]
+	str	r3,[$ctx,#8]
+	str	r3,[$ctx,#12]
+	str	r3,[$ctx,#16]
+	str	r3,[$ctx,#36]		@ clear is_base2_26
+	add	$ctx,$ctx,#20
+
+#ifdef	__thumb2__
+	it	eq
+#endif
+	moveq	r0,#0
+	beq	.Lno_key
+
+#if	__ARM_MAX_ARCH__>=7
+	mov	r3,#-1
+	str	r3,[$ctx,#28]		@ impossible key power value
+# ifndef __KERNEL__
+	adr	r11,.Lpoly1305_init
+	ldr	r12,.LOPENSSL_armcap
+# endif
+#endif
+	ldrb	r4,[$inp,#0]
+	mov	r10,#0x0fffffff
+	ldrb	r5,[$inp,#1]
+	and	r3,r10,#-4		@ 0x0ffffffc
+	ldrb	r6,[$inp,#2]
+	ldrb	r7,[$inp,#3]
+	orr	r4,r4,r5,lsl#8
+	ldrb	r5,[$inp,#4]
+	orr	r4,r4,r6,lsl#16
+	ldrb	r6,[$inp,#5]
+	orr	r4,r4,r7,lsl#24
+	ldrb	r7,[$inp,#6]
+	and	r4,r4,r10
+
+#if	__ARM_MAX_ARCH__>=7 && !defined(__KERNEL__)
+# if !defined(_WIN32)
+	ldr	r12,[r11,r12]		@ OPENSSL_armcap_P
+# endif
+# if defined(__APPLE__) || defined(_WIN32)
+	ldr	r12,[r12]
+# endif
+#endif
+	ldrb	r8,[$inp,#7]
+	orr	r5,r5,r6,lsl#8
+	ldrb	r6,[$inp,#8]
+	orr	r5,r5,r7,lsl#16
+	ldrb	r7,[$inp,#9]
+	orr	r5,r5,r8,lsl#24
+	ldrb	r8,[$inp,#10]
+	and	r5,r5,r3
+
+#if	__ARM_MAX_ARCH__>=7 && !defined(__KERNEL__)
+	tst	r12,#ARMV7_NEON		@ check for NEON
+# ifdef	__thumb2__
+	adr	r9,.Lpoly1305_blocks_neon
+	adr	r11,.Lpoly1305_blocks
+	it	ne
+	movne	r11,r9
+	adr	r12,.Lpoly1305_emit
+	orr	r11,r11,#1		@ thumb-ify addresses
+	orr	r12,r12,#1
+# else
+	add	r12,r11,#(.Lpoly1305_emit-.Lpoly1305_init)
+	ite	eq
+	addeq	r11,r11,#(.Lpoly1305_blocks-.Lpoly1305_init)
+	addne	r11,r11,#(.Lpoly1305_blocks_neon-.Lpoly1305_init)
+# endif
+#endif
+	ldrb	r9,[$inp,#11]
+	orr	r6,r6,r7,lsl#8
+	ldrb	r7,[$inp,#12]
+	orr	r6,r6,r8,lsl#16
+	ldrb	r8,[$inp,#13]
+	orr	r6,r6,r9,lsl#24
+	ldrb	r9,[$inp,#14]
+	and	r6,r6,r3
+
+	ldrb	r10,[$inp,#15]
+	orr	r7,r7,r8,lsl#8
+	str	r4,[$ctx,#0]
+	orr	r7,r7,r9,lsl#16
+	str	r5,[$ctx,#4]
+	orr	r7,r7,r10,lsl#24
+	str	r6,[$ctx,#8]
+	and	r7,r7,r3
+	str	r7,[$ctx,#12]
+#if	__ARM_MAX_ARCH__>=7 && !defined(__KERNEL__)
+	stmia	r2,{r11,r12}		@ fill functions table
+	mov	r0,#1
+#else
+	mov	r0,#0
+#endif
+.Lno_key:
+	ldmia	sp!,{r4-r11}
+#if	__ARM_ARCH__>=5
+	ret				@ bx	lr
+#else
+	tst	lr,#1
+	moveq	pc,lr			@ be binary compatible with V4, yet
+	bx	lr			@ interoperable with Thumb ISA:-)
+#endif
+.size	poly1305_init,.-poly1305_init
+___
+{
+my ($h0,$h1,$h2,$h3,$h4,$r0,$r1,$r2,$r3)=map("r$_",(4..12));
+my ($s1,$s2,$s3)=($r1,$r2,$r3);
+
+$code.=<<___;
+.type	poly1305_blocks,%function
+.align	5
+poly1305_blocks:
+.Lpoly1305_blocks:
+	stmdb	sp!,{r3-r11,lr}
+
+	ands	$len,$len,#-16
+	beq	.Lno_data
+
+	add	$len,$len,$inp		@ end pointer
+	sub	sp,sp,#32
+
+#if __ARM_ARCH__<7
+	ldmia	$ctx,{$h0-$r3}		@ load context
+	add	$ctx,$ctx,#20
+	str	$len,[sp,#16]		@ offload stuff
+	str	$ctx,[sp,#12]
+#else
+	ldr	lr,[$ctx,#36]		@ is_base2_26
+	ldmia	$ctx!,{$h0-$h4}		@ load hash value
+	str	$len,[sp,#16]		@ offload stuff
+	str	$ctx,[sp,#12]
+
+	adds	$r0,$h0,$h1,lsl#26	@ base 2^26 -> base 2^32
+	mov	$r1,$h1,lsr#6
+	adcs	$r1,$r1,$h2,lsl#20
+	mov	$r2,$h2,lsr#12
+	adcs	$r2,$r2,$h3,lsl#14
+	mov	$r3,$h3,lsr#18
+	adcs	$r3,$r3,$h4,lsl#8
+	mov	$len,#0
+	teq	lr,#0
+	str	$len,[$ctx,#16]		@ clear is_base2_26
+	adc	$len,$len,$h4,lsr#24
+
+	itttt	ne
+	movne	$h0,$r0			@ choose between radixes
+	movne	$h1,$r1
+	movne	$h2,$r2
+	movne	$h3,$r3
+	ldmia	$ctx,{$r0-$r3}		@ load key
+	it	ne
+	movne	$h4,$len
+#endif
+
+	mov	lr,$inp
+	cmp	$padbit,#0
+	str	$r1,[sp,#20]
+	str	$r2,[sp,#24]
+	str	$r3,[sp,#28]
+	b	.Loop
+
+.align	4
+.Loop:
+#if __ARM_ARCH__<7
+	ldrb	r0,[lr],#16		@ load input
+# ifdef	__thumb2__
+	it	hi
+# endif
+	addhi	$h4,$h4,#1		@ 1<<128
+	ldrb	r1,[lr,#-15]
+	ldrb	r2,[lr,#-14]
+	ldrb	r3,[lr,#-13]
+	orr	r1,r0,r1,lsl#8
+	ldrb	r0,[lr,#-12]
+	orr	r2,r1,r2,lsl#16
+	ldrb	r1,[lr,#-11]
+	orr	r3,r2,r3,lsl#24
+	ldrb	r2,[lr,#-10]
+	adds	$h0,$h0,r3		@ accumulate input
+
+	ldrb	r3,[lr,#-9]
+	orr	r1,r0,r1,lsl#8
+	ldrb	r0,[lr,#-8]
+	orr	r2,r1,r2,lsl#16
+	ldrb	r1,[lr,#-7]
+	orr	r3,r2,r3,lsl#24
+	ldrb	r2,[lr,#-6]
+	adcs	$h1,$h1,r3
+
+	ldrb	r3,[lr,#-5]
+	orr	r1,r0,r1,lsl#8
+	ldrb	r0,[lr,#-4]
+	orr	r2,r1,r2,lsl#16
+	ldrb	r1,[lr,#-3]
+	orr	r3,r2,r3,lsl#24
+	ldrb	r2,[lr,#-2]
+	adcs	$h2,$h2,r3
+
+	ldrb	r3,[lr,#-1]
+	orr	r1,r0,r1,lsl#8
+	str	lr,[sp,#8]		@ offload input pointer
+	orr	r2,r1,r2,lsl#16
+	add	$s1,$r1,$r1,lsr#2
+	orr	r3,r2,r3,lsl#24
+#else
+	ldr	r0,[lr],#16		@ load input
+	it	hi
+	addhi	$h4,$h4,#1		@ padbit
+	ldr	r1,[lr,#-12]
+	ldr	r2,[lr,#-8]
+	ldr	r3,[lr,#-4]
+# ifdef	__ARMEB__
+	rev	r0,r0
+	rev	r1,r1
+	rev	r2,r2
+	rev	r3,r3
+# endif
+	adds	$h0,$h0,r0		@ accumulate input
+	str	lr,[sp,#8]		@ offload input pointer
+	adcs	$h1,$h1,r1
+	add	$s1,$r1,$r1,lsr#2
+	adcs	$h2,$h2,r2
+#endif
+	add	$s2,$r2,$r2,lsr#2
+	adcs	$h3,$h3,r3
+	add	$s3,$r3,$r3,lsr#2
+
+	umull	r2,r3,$h1,$r0
+	 adc	$h4,$h4,#0
+	umull	r0,r1,$h0,$r0
+	umlal	r2,r3,$h4,$s1
+	umlal	r0,r1,$h3,$s1
+	ldr	$r1,[sp,#20]		@ reload $r1
+	umlal	r2,r3,$h2,$s3
+	umlal	r0,r1,$h1,$s3
+	umlal	r2,r3,$h3,$s2
+	umlal	r0,r1,$h2,$s2
+	umlal	r2,r3,$h0,$r1
+	str	r0,[sp,#0]		@ future $h0
+	 mul	r0,$s2,$h4
+	ldr	$r2,[sp,#24]		@ reload $r2
+	adds	r2,r2,r1		@ d1+=d0>>32
+	 eor	r1,r1,r1
+	adc	lr,r3,#0		@ future $h2
+	str	r2,[sp,#4]		@ future $h1
+
+	mul	r2,$s3,$h4
+	eor	r3,r3,r3
+	umlal	r0,r1,$h3,$s3
+	ldr	$r3,[sp,#28]		@ reload $r3
+	umlal	r2,r3,$h3,$r0
+	umlal	r0,r1,$h2,$r0
+	umlal	r2,r3,$h2,$r1
+	umlal	r0,r1,$h1,$r1
+	umlal	r2,r3,$h1,$r2
+	umlal	r0,r1,$h0,$r2
+	umlal	r2,r3,$h0,$r3
+	ldr	$h0,[sp,#0]
+	mul	$h4,$r0,$h4
+	ldr	$h1,[sp,#4]
+
+	adds	$h2,lr,r0		@ d2+=d1>>32
+	ldr	lr,[sp,#8]		@ reload input pointer
+	adc	r1,r1,#0
+	adds	$h3,r2,r1		@ d3+=d2>>32
+	ldr	r0,[sp,#16]		@ reload end pointer
+	adc	r3,r3,#0
+	add	$h4,$h4,r3		@ h4+=d3>>32
+
+	and	r1,$h4,#-4
+	and	$h4,$h4,#3
+	add	r1,r1,r1,lsr#2		@ *=5
+	adds	$h0,$h0,r1
+	adcs	$h1,$h1,#0
+	adcs	$h2,$h2,#0
+	adcs	$h3,$h3,#0
+	adc	$h4,$h4,#0
+
+	cmp	r0,lr			@ done yet?
+	bhi	.Loop
+
+	ldr	$ctx,[sp,#12]
+	add	sp,sp,#32
+	stmdb	$ctx,{$h0-$h4}		@ store the result
+
+.Lno_data:
+#if	__ARM_ARCH__>=5
+	ldmia	sp!,{r3-r11,pc}
+#else
+	ldmia	sp!,{r3-r11,lr}
+	tst	lr,#1
+	moveq	pc,lr			@ be binary compatible with V4, yet
+	bx	lr			@ interoperable with Thumb ISA:-)
+#endif
+.size	poly1305_blocks,.-poly1305_blocks
+___
+}
+{
+my ($ctx,$mac,$nonce)=map("r$_",(0..2));
+my ($h0,$h1,$h2,$h3,$h4,$g0,$g1,$g2,$g3)=map("r$_",(3..11));
+my $g4=$ctx;
+
+$code.=<<___;
+.type	poly1305_emit,%function
+.align	5
+poly1305_emit:
+.Lpoly1305_emit:
+	stmdb	sp!,{r4-r11}
+
+	ldmia	$ctx,{$h0-$h4}
+
+#if __ARM_ARCH__>=7
+	ldr	ip,[$ctx,#36]		@ is_base2_26
+
+	adds	$g0,$h0,$h1,lsl#26	@ base 2^26 -> base 2^32
+	mov	$g1,$h1,lsr#6
+	adcs	$g1,$g1,$h2,lsl#20
+	mov	$g2,$h2,lsr#12
+	adcs	$g2,$g2,$h3,lsl#14
+	mov	$g3,$h3,lsr#18
+	adcs	$g3,$g3,$h4,lsl#8
+	mov	$g4,#0
+	adc	$g4,$g4,$h4,lsr#24
+
+	tst	ip,ip
+	itttt	ne
+	movne	$h0,$g0
+	movne	$h1,$g1
+	movne	$h2,$g2
+	movne	$h3,$g3
+	it	ne
+	movne	$h4,$g4
+#endif
+
+	adds	$g0,$h0,#5		@ compare to modulus
+	adcs	$g1,$h1,#0
+	adcs	$g2,$h2,#0
+	adcs	$g3,$h3,#0
+	adc	$g4,$h4,#0
+	tst	$g4,#4			@ did it carry/borrow?
+
+#ifdef	__thumb2__
+	it	ne
+#endif
+	movne	$h0,$g0
+	ldr	$g0,[$nonce,#0]
+#ifdef	__thumb2__
+	it	ne
+#endif
+	movne	$h1,$g1
+	ldr	$g1,[$nonce,#4]
+#ifdef	__thumb2__
+	it	ne
+#endif
+	movne	$h2,$g2
+	ldr	$g2,[$nonce,#8]
+#ifdef	__thumb2__
+	it	ne
+#endif
+	movne	$h3,$g3
+	ldr	$g3,[$nonce,#12]
+
+	adds	$h0,$h0,$g0
+	adcs	$h1,$h1,$g1
+	adcs	$h2,$h2,$g2
+	adc	$h3,$h3,$g3
+
+#if __ARM_ARCH__>=7
+# ifdef __ARMEB__
+	rev	$h0,$h0
+	rev	$h1,$h1
+	rev	$h2,$h2
+	rev	$h3,$h3
+# endif
+	str	$h0,[$mac,#0]
+	str	$h1,[$mac,#4]
+	str	$h2,[$mac,#8]
+	str	$h3,[$mac,#12]
+#else
+	strb	$h0,[$mac,#0]
+	mov	$h0,$h0,lsr#8
+	strb	$h1,[$mac,#4]
+	mov	$h1,$h1,lsr#8
+	strb	$h2,[$mac,#8]
+	mov	$h2,$h2,lsr#8
+	strb	$h3,[$mac,#12]
+	mov	$h3,$h3,lsr#8
+
+	strb	$h0,[$mac,#1]
+	mov	$h0,$h0,lsr#8
+	strb	$h1,[$mac,#5]
+	mov	$h1,$h1,lsr#8
+	strb	$h2,[$mac,#9]
+	mov	$h2,$h2,lsr#8
+	strb	$h3,[$mac,#13]
+	mov	$h3,$h3,lsr#8
+
+	strb	$h0,[$mac,#2]
+	mov	$h0,$h0,lsr#8
+	strb	$h1,[$mac,#6]
+	mov	$h1,$h1,lsr#8
+	strb	$h2,[$mac,#10]
+	mov	$h2,$h2,lsr#8
+	strb	$h3,[$mac,#14]
+	mov	$h3,$h3,lsr#8
+
+	strb	$h0,[$mac,#3]
+	strb	$h1,[$mac,#7]
+	strb	$h2,[$mac,#11]
+	strb	$h3,[$mac,#15]
+#endif
+	ldmia	sp!,{r4-r11}
+#if	__ARM_ARCH__>=5
+	ret				@ bx	lr
+#else
+	tst	lr,#1
+	moveq	pc,lr			@ be binary compatible with V4, yet
+	bx	lr			@ interoperable with Thumb ISA:-)
+#endif
+.size	poly1305_emit,.-poly1305_emit
+___
+{
+my ($R0,$R1,$S1,$R2,$S2,$R3,$S3,$R4,$S4) = map("d$_",(0..9));
+my ($D0,$D1,$D2,$D3,$D4, $H0,$H1,$H2,$H3,$H4) = map("q$_",(5..14));
+my ($T0,$T1,$MASK) = map("q$_",(15,4,0));
+
+my ($in2,$zeros,$tbl0,$tbl1) = map("r$_",(4..7));
+
+$code.=<<___;
+#if	__ARM_MAX_ARCH__>=7
+.fpu	neon
+
+.type	poly1305_init_neon,%function
+.align	5
+poly1305_init_neon:
+.Lpoly1305_init_neon:
+	ldr	r3,[$ctx,#48]		@ first table element
+	cmp	r3,#-1			@ is value impossible?
+	bne	.Lno_init_neon
+
+	ldr	r4,[$ctx,#20]		@ load key base 2^32
+	ldr	r5,[$ctx,#24]
+	ldr	r6,[$ctx,#28]
+	ldr	r7,[$ctx,#32]
+
+	and	r2,r4,#0x03ffffff	@ base 2^32 -> base 2^26
+	mov	r3,r4,lsr#26
+	mov	r4,r5,lsr#20
+	orr	r3,r3,r5,lsl#6
+	mov	r5,r6,lsr#14
+	orr	r4,r4,r6,lsl#12
+	mov	r6,r7,lsr#8
+	orr	r5,r5,r7,lsl#18
+	and	r3,r3,#0x03ffffff
+	and	r4,r4,#0x03ffffff
+	and	r5,r5,#0x03ffffff
+
+	vdup.32	$R0,r2			@ r^1 in both lanes
+	add	r2,r3,r3,lsl#2		@ *5
+	vdup.32	$R1,r3
+	add	r3,r4,r4,lsl#2
+	vdup.32	$S1,r2
+	vdup.32	$R2,r4
+	add	r4,r5,r5,lsl#2
+	vdup.32	$S2,r3
+	vdup.32	$R3,r5
+	add	r5,r6,r6,lsl#2
+	vdup.32	$S3,r4
+	vdup.32	$R4,r6
+	vdup.32	$S4,r5
+
+	mov	$zeros,#2		@ counter
+
+.Lsquare_neon:
+	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
+	@ d0 = h0*r0 + h4*5*r1 + h3*5*r2 + h2*5*r3 + h1*5*r4
+	@ d1 = h1*r0 + h0*r1   + h4*5*r2 + h3*5*r3 + h2*5*r4
+	@ d2 = h2*r0 + h1*r1   + h0*r2   + h4*5*r3 + h3*5*r4
+	@ d3 = h3*r0 + h2*r1   + h1*r2   + h0*r3   + h4*5*r4
+	@ d4 = h4*r0 + h3*r1   + h2*r2   + h1*r3   + h0*r4
+
+	vmull.u32	$D0,$R0,${R0}[1]
+	vmull.u32	$D1,$R1,${R0}[1]
+	vmull.u32	$D2,$R2,${R0}[1]
+	vmull.u32	$D3,$R3,${R0}[1]
+	vmull.u32	$D4,$R4,${R0}[1]
+
+	vmlal.u32	$D0,$R4,${S1}[1]
+	vmlal.u32	$D1,$R0,${R1}[1]
+	vmlal.u32	$D2,$R1,${R1}[1]
+	vmlal.u32	$D3,$R2,${R1}[1]
+	vmlal.u32	$D4,$R3,${R1}[1]
+
+	vmlal.u32	$D0,$R3,${S2}[1]
+	vmlal.u32	$D1,$R4,${S2}[1]
+	vmlal.u32	$D3,$R1,${R2}[1]
+	vmlal.u32	$D2,$R0,${R2}[1]
+	vmlal.u32	$D4,$R2,${R2}[1]
+
+	vmlal.u32	$D0,$R2,${S3}[1]
+	vmlal.u32	$D3,$R0,${R3}[1]
+	vmlal.u32	$D1,$R3,${S3}[1]
+	vmlal.u32	$D2,$R4,${S3}[1]
+	vmlal.u32	$D4,$R1,${R3}[1]
+
+	vmlal.u32	$D3,$R4,${S4}[1]
+	vmlal.u32	$D0,$R1,${S4}[1]
+	vmlal.u32	$D1,$R2,${S4}[1]
+	vmlal.u32	$D2,$R3,${S4}[1]
+	vmlal.u32	$D4,$R0,${R4}[1]
+
+	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
+	@ lazy reduction as discussed in "NEON crypto" by D.J. Bernstein
+	@ and P. Schwabe
+	@
+	@ H0>>+H1>>+H2>>+H3>>+H4
+	@ H3>>+H4>>*5+H0>>+H1
+	@
+	@ Trivia.
+	@
+	@ Result of multiplication of n-bit number by m-bit number is
+	@ n+m bits wide. However! Even though 2^n is a n+1-bit number,
+	@ m-bit number multiplied by 2^n is still n+m bits wide.
+	@
+	@ Sum of two n-bit numbers is n+1 bits wide, sum of three - n+2,
+	@ and so is sum of four. Sum of 2^m n-m-bit numbers and n-bit
+	@ one is n+1 bits wide.
+	@
+	@ >>+ denotes Hnext += Hn>>26, Hn &= 0x3ffffff. This means that
+	@ H0, H2, H3 are guaranteed to be 26 bits wide, while H1 and H4
+	@ can be 27. However! In cases when their width exceeds 26 bits
+	@ they are limited by 2^26+2^6. This in turn means that *sum*
+	@ of the products with these values can still be viewed as sum
+	@ of 52-bit numbers as long as the amount of addends is not a
+	@ power of 2. For example,
+	@
+	@ H4 = H4*R0 + H3*R1 + H2*R2 + H1*R3 + H0 * R4,
+	@
+	@ which can't be larger than 5 * (2^26 + 2^6) * (2^26 + 2^6), or
+	@ 5 * (2^52 + 2*2^32 + 2^12), which in turn is smaller than
+	@ 8 * (2^52) or 2^55. However, the value is then multiplied by
+	@ by 5, so we should be looking at 5 * 5 * (2^52 + 2^33 + 2^12),
+	@ which is less than 32 * (2^52) or 2^57. And when processing
+	@ data we are looking at triple as many addends...
+	@
+	@ In key setup procedure pre-reduced H0 is limited by 5*4+1 and
+	@ 5*H4 - by 5*5 52-bit addends, or 57 bits. But when hashing the
+	@ input H0 is limited by (5*4+1)*3 addends, or 58 bits, while
+	@ 5*H4 by 5*5*3, or 59[!] bits. How is this relevant? vmlal.u32
+	@ instruction accepts 2x32-bit input and writes 2x64-bit result.
+	@ This means that result of reduction have to be compressed upon
+	@ loop wrap-around. This can be done in the process of reduction
+	@ to minimize amount of instructions [as well as amount of
+	@ 128-bit instructions, which benefits low-end processors], but
+	@ one has to watch for H2 (which is narrower than H0) and 5*H4
+	@ not being wider than 58 bits, so that result of right shift
+	@ by 26 bits fits in 32 bits. This is also useful on x86,
+	@ because it allows to use paddd in place for paddq, which
+	@ benefits Atom, where paddq is ridiculously slow.
+
+	vshr.u64	$T0,$D3,#26
+	vmovn.i64	$D3#lo,$D3
+	 vshr.u64	$T1,$D0,#26
+	 vmovn.i64	$D0#lo,$D0
+	vadd.i64	$D4,$D4,$T0		@ h3 -> h4
+	vbic.i32	$D3#lo,#0xfc000000	@ &=0x03ffffff
+	 vadd.i64	$D1,$D1,$T1		@ h0 -> h1
+	 vbic.i32	$D0#lo,#0xfc000000
+
+	vshrn.u64	$T0#lo,$D4,#26
+	vmovn.i64	$D4#lo,$D4
+	 vshr.u64	$T1,$D1,#26
+	 vmovn.i64	$D1#lo,$D1
+	 vadd.i64	$D2,$D2,$T1		@ h1 -> h2
+	vbic.i32	$D4#lo,#0xfc000000
+	 vbic.i32	$D1#lo,#0xfc000000
+
+	vadd.i32	$D0#lo,$D0#lo,$T0#lo
+	vshl.u32	$T0#lo,$T0#lo,#2
+	 vshrn.u64	$T1#lo,$D2,#26
+	 vmovn.i64	$D2#lo,$D2
+	vadd.i32	$D0#lo,$D0#lo,$T0#lo	@ h4 -> h0
+	 vadd.i32	$D3#lo,$D3#lo,$T1#lo	@ h2 -> h3
+	 vbic.i32	$D2#lo,#0xfc000000
+
+	vshr.u32	$T0#lo,$D0#lo,#26
+	vbic.i32	$D0#lo,#0xfc000000
+	 vshr.u32	$T1#lo,$D3#lo,#26
+	 vbic.i32	$D3#lo,#0xfc000000
+	vadd.i32	$D1#lo,$D1#lo,$T0#lo	@ h0 -> h1
+	 vadd.i32	$D4#lo,$D4#lo,$T1#lo	@ h3 -> h4
+
+	subs		$zeros,$zeros,#1
+	beq		.Lsquare_break_neon
+
+	add		$tbl0,$ctx,#(48+0*9*4)
+	add		$tbl1,$ctx,#(48+1*9*4)
+
+	vtrn.32		$R0,$D0#lo		@ r^2:r^1
+	vtrn.32		$R2,$D2#lo
+	vtrn.32		$R3,$D3#lo
+	vtrn.32		$R1,$D1#lo
+	vtrn.32		$R4,$D4#lo
+
+	vshl.u32	$S2,$R2,#2		@ *5
+	vshl.u32	$S3,$R3,#2
+	vshl.u32	$S1,$R1,#2
+	vshl.u32	$S4,$R4,#2
+	vadd.i32	$S2,$S2,$R2
+	vadd.i32	$S1,$S1,$R1
+	vadd.i32	$S3,$S3,$R3
+	vadd.i32	$S4,$S4,$R4
+
+	vst4.32		{${R0}[0],${R1}[0],${S1}[0],${R2}[0]},[$tbl0]!
+	vst4.32		{${R0}[1],${R1}[1],${S1}[1],${R2}[1]},[$tbl1]!
+	vst4.32		{${S2}[0],${R3}[0],${S3}[0],${R4}[0]},[$tbl0]!
+	vst4.32		{${S2}[1],${R3}[1],${S3}[1],${R4}[1]},[$tbl1]!
+	vst1.32		{${S4}[0]},[$tbl0,:32]
+	vst1.32		{${S4}[1]},[$tbl1,:32]
+
+	b		.Lsquare_neon
+
+.align	4
+.Lsquare_break_neon:
+	add		$tbl0,$ctx,#(48+2*4*9)
+	add		$tbl1,$ctx,#(48+3*4*9)
+
+	vmov		$R0,$D0#lo		@ r^4:r^3
+	vshl.u32	$S1,$D1#lo,#2		@ *5
+	vmov		$R1,$D1#lo
+	vshl.u32	$S2,$D2#lo,#2
+	vmov		$R2,$D2#lo
+	vshl.u32	$S3,$D3#lo,#2
+	vmov		$R3,$D3#lo
+	vshl.u32	$S4,$D4#lo,#2
+	vmov		$R4,$D4#lo
+	vadd.i32	$S1,$S1,$D1#lo
+	vadd.i32	$S2,$S2,$D2#lo
+	vadd.i32	$S3,$S3,$D3#lo
+	vadd.i32	$S4,$S4,$D4#lo
+
+	vst4.32		{${R0}[0],${R1}[0],${S1}[0],${R2}[0]},[$tbl0]!
+	vst4.32		{${R0}[1],${R1}[1],${S1}[1],${R2}[1]},[$tbl1]!
+	vst4.32		{${S2}[0],${R3}[0],${S3}[0],${R4}[0]},[$tbl0]!
+	vst4.32		{${S2}[1],${R3}[1],${S3}[1],${R4}[1]},[$tbl1]!
+	vst1.32		{${S4}[0]},[$tbl0]
+	vst1.32		{${S4}[1]},[$tbl1]
+
+.Lno_init_neon:
+	ret				@ bx	lr
+.size	poly1305_init_neon,.-poly1305_init_neon
+
+.type	poly1305_blocks_neon,%function
+.align	5
+poly1305_blocks_neon:
+.Lpoly1305_blocks_neon:
+	ldr	ip,[$ctx,#36]		@ is_base2_26
+
+	cmp	$len,#64
+	blo	.Lpoly1305_blocks
+
+	stmdb	sp!,{r4-r7}
+	vstmdb	sp!,{d8-d15}		@ ABI specification says so
+
+	tst	ip,ip			@ is_base2_26?
+	bne	.Lbase2_26_neon
+
+	stmdb	sp!,{r1-r3,lr}
+	bl	.Lpoly1305_init_neon
+
+	ldr	r4,[$ctx,#0]		@ load hash value base 2^32
+	ldr	r5,[$ctx,#4]
+	ldr	r6,[$ctx,#8]
+	ldr	r7,[$ctx,#12]
+	ldr	ip,[$ctx,#16]
+
+	and	r2,r4,#0x03ffffff	@ base 2^32 -> base 2^26
+	mov	r3,r4,lsr#26
+	 veor	$D0#lo,$D0#lo,$D0#lo
+	mov	r4,r5,lsr#20
+	orr	r3,r3,r5,lsl#6
+	 veor	$D1#lo,$D1#lo,$D1#lo
+	mov	r5,r6,lsr#14
+	orr	r4,r4,r6,lsl#12
+	 veor	$D2#lo,$D2#lo,$D2#lo
+	mov	r6,r7,lsr#8
+	orr	r5,r5,r7,lsl#18
+	 veor	$D3#lo,$D3#lo,$D3#lo
+	and	r3,r3,#0x03ffffff
+	orr	r6,r6,ip,lsl#24
+	 veor	$D4#lo,$D4#lo,$D4#lo
+	and	r4,r4,#0x03ffffff
+	mov	r1,#1
+	and	r5,r5,#0x03ffffff
+	str	r1,[$ctx,#36]		@ set is_base2_26
+
+	vmov.32	$D0#lo[0],r2
+	vmov.32	$D1#lo[0],r3
+	vmov.32	$D2#lo[0],r4
+	vmov.32	$D3#lo[0],r5
+	vmov.32	$D4#lo[0],r6
+	adr	$zeros,.Lzeros
+
+	ldmia	sp!,{r1-r3,lr}
+	b	.Lhash_loaded
+
+.align	4
+.Lbase2_26_neon:
+	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
+	@ load hash value
+
+	veor		$D0#lo,$D0#lo,$D0#lo
+	veor		$D1#lo,$D1#lo,$D1#lo
+	veor		$D2#lo,$D2#lo,$D2#lo
+	veor		$D3#lo,$D3#lo,$D3#lo
+	veor		$D4#lo,$D4#lo,$D4#lo
+	vld4.32		{$D0#lo[0],$D1#lo[0],$D2#lo[0],$D3#lo[0]},[$ctx]!
+	adr		$zeros,.Lzeros
+	vld1.32		{$D4#lo[0]},[$ctx]
+	sub		$ctx,$ctx,#16		@ rewind
+
+.Lhash_loaded:
+	add		$in2,$inp,#32
+	mov		$padbit,$padbit,lsl#24
+	tst		$len,#31
+	beq		.Leven
+
+	vld4.32		{$H0#lo[0],$H1#lo[0],$H2#lo[0],$H3#lo[0]},[$inp]!
+	vmov.32		$H4#lo[0],$padbit
+	sub		$len,$len,#16
+	add		$in2,$inp,#32
+
+# ifdef	__ARMEB__
+	vrev32.8	$H0,$H0
+	vrev32.8	$H3,$H3
+	vrev32.8	$H1,$H1
+	vrev32.8	$H2,$H2
+# endif
+	vsri.u32	$H4#lo,$H3#lo,#8	@ base 2^32 -> base 2^26
+	vshl.u32	$H3#lo,$H3#lo,#18
+
+	vsri.u32	$H3#lo,$H2#lo,#14
+	vshl.u32	$H2#lo,$H2#lo,#12
+	vadd.i32	$H4#hi,$H4#lo,$D4#lo	@ add hash value and move to #hi
+
+	vbic.i32	$H3#lo,#0xfc000000
+	vsri.u32	$H2#lo,$H1#lo,#20
+	vshl.u32	$H1#lo,$H1#lo,#6
+
+	vbic.i32	$H2#lo,#0xfc000000
+	vsri.u32	$H1#lo,$H0#lo,#26
+	vadd.i32	$H3#hi,$H3#lo,$D3#lo
+
+	vbic.i32	$H0#lo,#0xfc000000
+	vbic.i32	$H1#lo,#0xfc000000
+	vadd.i32	$H2#hi,$H2#lo,$D2#lo
+
+	vadd.i32	$H0#hi,$H0#lo,$D0#lo
+	vadd.i32	$H1#hi,$H1#lo,$D1#lo
+
+	mov		$tbl1,$zeros
+	add		$tbl0,$ctx,#48
+
+	cmp		$len,$len
+	b		.Long_tail
+
+.align	4
+.Leven:
+	subs		$len,$len,#64
+	it		lo
+	movlo		$in2,$zeros
+
+	vmov.i32	$H4,#1<<24		@ padbit, yes, always
+	vld4.32		{$H0#lo,$H1#lo,$H2#lo,$H3#lo},[$inp]	@ inp[0:1]
+	add		$inp,$inp,#64
+	vld4.32		{$H0#hi,$H1#hi,$H2#hi,$H3#hi},[$in2]	@ inp[2:3] (or 0)
+	add		$in2,$in2,#64
+	itt		hi
+	addhi		$tbl1,$ctx,#(48+1*9*4)
+	addhi		$tbl0,$ctx,#(48+3*9*4)
+
+# ifdef	__ARMEB__
+	vrev32.8	$H0,$H0
+	vrev32.8	$H3,$H3
+	vrev32.8	$H1,$H1
+	vrev32.8	$H2,$H2
+# endif
+	vsri.u32	$H4,$H3,#8		@ base 2^32 -> base 2^26
+	vshl.u32	$H3,$H3,#18
+
+	vsri.u32	$H3,$H2,#14
+	vshl.u32	$H2,$H2,#12
+
+	vbic.i32	$H3,#0xfc000000
+	vsri.u32	$H2,$H1,#20
+	vshl.u32	$H1,$H1,#6
+
+	vbic.i32	$H2,#0xfc000000
+	vsri.u32	$H1,$H0,#26
+
+	vbic.i32	$H0,#0xfc000000
+	vbic.i32	$H1,#0xfc000000
+
+	bls		.Lskip_loop
+
+	vld4.32		{${R0}[1],${R1}[1],${S1}[1],${R2}[1]},[$tbl1]!	@ load r^2
+	vld4.32		{${R0}[0],${R1}[0],${S1}[0],${R2}[0]},[$tbl0]!	@ load r^4
+	vld4.32		{${S2}[1],${R3}[1],${S3}[1],${R4}[1]},[$tbl1]!
+	vld4.32		{${S2}[0],${R3}[0],${S3}[0],${R4}[0]},[$tbl0]!
+	b		.Loop_neon
+
+.align	5
+.Loop_neon:
+	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
+	@ ((inp[0]*r^4+inp[2]*r^2+inp[4])*r^4+inp[6]*r^2
+	@ ((inp[1]*r^4+inp[3]*r^2+inp[5])*r^3+inp[7]*r
+	@   \___________________/
+	@ ((inp[0]*r^4+inp[2]*r^2+inp[4])*r^4+inp[6]*r^2+inp[8])*r^2
+	@ ((inp[1]*r^4+inp[3]*r^2+inp[5])*r^4+inp[7]*r^2+inp[9])*r
+	@   \___________________/ \____________________/
+	@
+	@ Note that we start with inp[2:3]*r^2. This is because it
+	@ doesn't depend on reduction in previous iteration.
+	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
+	@ d4 = h4*r0 + h3*r1   + h2*r2   + h1*r3   + h0*r4
+	@ d3 = h3*r0 + h2*r1   + h1*r2   + h0*r3   + h4*5*r4
+	@ d2 = h2*r0 + h1*r1   + h0*r2   + h4*5*r3 + h3*5*r4
+	@ d1 = h1*r0 + h0*r1   + h4*5*r2 + h3*5*r3 + h2*5*r4
+	@ d0 = h0*r0 + h4*5*r1 + h3*5*r2 + h2*5*r3 + h1*5*r4
+
+	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
+	@ inp[2:3]*r^2
+
+	vadd.i32	$H2#lo,$H2#lo,$D2#lo	@ accumulate inp[0:1]
+	vmull.u32	$D2,$H2#hi,${R0}[1]
+	vadd.i32	$H0#lo,$H0#lo,$D0#lo
+	vmull.u32	$D0,$H0#hi,${R0}[1]
+	vadd.i32	$H3#lo,$H3#lo,$D3#lo
+	vmull.u32	$D3,$H3#hi,${R0}[1]
+	vmlal.u32	$D2,$H1#hi,${R1}[1]
+	vadd.i32	$H1#lo,$H1#lo,$D1#lo
+	vmull.u32	$D1,$H1#hi,${R0}[1]
+
+	vadd.i32	$H4#lo,$H4#lo,$D4#lo
+	vmull.u32	$D4,$H4#hi,${R0}[1]
+	subs		$len,$len,#64
+	vmlal.u32	$D0,$H4#hi,${S1}[1]
+	it		lo
+	movlo		$in2,$zeros
+	vmlal.u32	$D3,$H2#hi,${R1}[1]
+	vld1.32		${S4}[1],[$tbl1,:32]
+	vmlal.u32	$D1,$H0#hi,${R1}[1]
+	vmlal.u32	$D4,$H3#hi,${R1}[1]
+
+	vmlal.u32	$D0,$H3#hi,${S2}[1]
+	vmlal.u32	$D3,$H1#hi,${R2}[1]
+	vmlal.u32	$D4,$H2#hi,${R2}[1]
+	vmlal.u32	$D1,$H4#hi,${S2}[1]
+	vmlal.u32	$D2,$H0#hi,${R2}[1]
+
+	vmlal.u32	$D3,$H0#hi,${R3}[1]
+	vmlal.u32	$D0,$H2#hi,${S3}[1]
+	vmlal.u32	$D4,$H1#hi,${R3}[1]
+	vmlal.u32	$D1,$H3#hi,${S3}[1]
+	vmlal.u32	$D2,$H4#hi,${S3}[1]
+
+	vmlal.u32	$D3,$H4#hi,${S4}[1]
+	vmlal.u32	$D0,$H1#hi,${S4}[1]
+	vmlal.u32	$D4,$H0#hi,${R4}[1]
+	vmlal.u32	$D1,$H2#hi,${S4}[1]
+	vmlal.u32	$D2,$H3#hi,${S4}[1]
+
+	vld4.32		{$H0#hi,$H1#hi,$H2#hi,$H3#hi},[$in2]	@ inp[2:3] (or 0)
+	add		$in2,$in2,#64
+
+	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
+	@ (hash+inp[0:1])*r^4 and accumulate
+
+	vmlal.u32	$D3,$H3#lo,${R0}[0]
+	vmlal.u32	$D0,$H0#lo,${R0}[0]
+	vmlal.u32	$D4,$H4#lo,${R0}[0]
+	vmlal.u32	$D1,$H1#lo,${R0}[0]
+	vmlal.u32	$D2,$H2#lo,${R0}[0]
+	vld1.32		${S4}[0],[$tbl0,:32]
+
+	vmlal.u32	$D3,$H2#lo,${R1}[0]
+	vmlal.u32	$D0,$H4#lo,${S1}[0]
+	vmlal.u32	$D4,$H3#lo,${R1}[0]
+	vmlal.u32	$D1,$H0#lo,${R1}[0]
+	vmlal.u32	$D2,$H1#lo,${R1}[0]
+
+	vmlal.u32	$D3,$H1#lo,${R2}[0]
+	vmlal.u32	$D0,$H3#lo,${S2}[0]
+	vmlal.u32	$D4,$H2#lo,${R2}[0]
+	vmlal.u32	$D1,$H4#lo,${S2}[0]
+	vmlal.u32	$D2,$H0#lo,${R2}[0]
+
+	vmlal.u32	$D3,$H0#lo,${R3}[0]
+	vmlal.u32	$D0,$H2#lo,${S3}[0]
+	vmlal.u32	$D4,$H1#lo,${R3}[0]
+	vmlal.u32	$D1,$H3#lo,${S3}[0]
+	vmlal.u32	$D3,$H4#lo,${S4}[0]
+
+	vmlal.u32	$D2,$H4#lo,${S3}[0]
+	vmlal.u32	$D0,$H1#lo,${S4}[0]
+	vmlal.u32	$D4,$H0#lo,${R4}[0]
+	vmov.i32	$H4,#1<<24		@ padbit, yes, always
+	vmlal.u32	$D1,$H2#lo,${S4}[0]
+	vmlal.u32	$D2,$H3#lo,${S4}[0]
+
+	vld4.32		{$H0#lo,$H1#lo,$H2#lo,$H3#lo},[$inp]	@ inp[0:1]
+	add		$inp,$inp,#64
+# ifdef	__ARMEB__
+	vrev32.8	$H0,$H0
+	vrev32.8	$H1,$H1
+	vrev32.8	$H2,$H2
+	vrev32.8	$H3,$H3
+# endif
+
+	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
+	@ lazy reduction interleaved with base 2^32 -> base 2^26 of
+	@ inp[0:3] previously loaded to $H0-$H3 and smashed to $H0-$H4.
+
+	vshr.u64	$T0,$D3,#26
+	vmovn.i64	$D3#lo,$D3
+	 vshr.u64	$T1,$D0,#26
+	 vmovn.i64	$D0#lo,$D0
+	vadd.i64	$D4,$D4,$T0		@ h3 -> h4
+	vbic.i32	$D3#lo,#0xfc000000
+	  vsri.u32	$H4,$H3,#8		@ base 2^32 -> base 2^26
+	 vadd.i64	$D1,$D1,$T1		@ h0 -> h1
+	  vshl.u32	$H3,$H3,#18
+	 vbic.i32	$D0#lo,#0xfc000000
+
+	vshrn.u64	$T0#lo,$D4,#26
+	vmovn.i64	$D4#lo,$D4
+	 vshr.u64	$T1,$D1,#26
+	 vmovn.i64	$D1#lo,$D1
+	 vadd.i64	$D2,$D2,$T1		@ h1 -> h2
+	  vsri.u32	$H3,$H2,#14
+	vbic.i32	$D4#lo,#0xfc000000
+	  vshl.u32	$H2,$H2,#12
+	 vbic.i32	$D1#lo,#0xfc000000
+
+	vadd.i32	$D0#lo,$D0#lo,$T0#lo
+	vshl.u32	$T0#lo,$T0#lo,#2
+	  vbic.i32	$H3,#0xfc000000
+	 vshrn.u64	$T1#lo,$D2,#26
+	 vmovn.i64	$D2#lo,$D2
+	vaddl.u32	$D0,$D0#lo,$T0#lo	@ h4 -> h0 [widen for a sec]
+	  vsri.u32	$H2,$H1,#20
+	 vadd.i32	$D3#lo,$D3#lo,$T1#lo	@ h2 -> h3
+	  vshl.u32	$H1,$H1,#6
+	 vbic.i32	$D2#lo,#0xfc000000
+	  vbic.i32	$H2,#0xfc000000
+
+	vshrn.u64	$T0#lo,$D0,#26		@ re-narrow
+	vmovn.i64	$D0#lo,$D0
+	  vsri.u32	$H1,$H0,#26
+	  vbic.i32	$H0,#0xfc000000
+	 vshr.u32	$T1#lo,$D3#lo,#26
+	 vbic.i32	$D3#lo,#0xfc000000
+	vbic.i32	$D0#lo,#0xfc000000
+	vadd.i32	$D1#lo,$D1#lo,$T0#lo	@ h0 -> h1
+	 vadd.i32	$D4#lo,$D4#lo,$T1#lo	@ h3 -> h4
+	  vbic.i32	$H1,#0xfc000000
+
+	bhi		.Loop_neon
+
+.Lskip_loop:
+	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
+	@ multiply (inp[0:1]+hash) or inp[2:3] by r^2:r^1
+
+	add		$tbl1,$ctx,#(48+0*9*4)
+	add		$tbl0,$ctx,#(48+1*9*4)
+	adds		$len,$len,#32
+	it		ne
+	movne		$len,#0
+	bne		.Long_tail
+
+	vadd.i32	$H2#hi,$H2#lo,$D2#lo	@ add hash value and move to #hi
+	vadd.i32	$H0#hi,$H0#lo,$D0#lo
+	vadd.i32	$H3#hi,$H3#lo,$D3#lo
+	vadd.i32	$H1#hi,$H1#lo,$D1#lo
+	vadd.i32	$H4#hi,$H4#lo,$D4#lo
+
+.Long_tail:
+	vld4.32		{${R0}[1],${R1}[1],${S1}[1],${R2}[1]},[$tbl1]!	@ load r^1
+	vld4.32		{${R0}[0],${R1}[0],${S1}[0],${R2}[0]},[$tbl0]!	@ load r^2
+
+	vadd.i32	$H2#lo,$H2#lo,$D2#lo	@ can be redundant
+	vmull.u32	$D2,$H2#hi,$R0
+	vadd.i32	$H0#lo,$H0#lo,$D0#lo
+	vmull.u32	$D0,$H0#hi,$R0
+	vadd.i32	$H3#lo,$H3#lo,$D3#lo
+	vmull.u32	$D3,$H3#hi,$R0
+	vadd.i32	$H1#lo,$H1#lo,$D1#lo
+	vmull.u32	$D1,$H1#hi,$R0
+	vadd.i32	$H4#lo,$H4#lo,$D4#lo
+	vmull.u32	$D4,$H4#hi,$R0
+
+	vmlal.u32	$D0,$H4#hi,$S1
+	vld4.32		{${S2}[1],${R3}[1],${S3}[1],${R4}[1]},[$tbl1]!
+	vmlal.u32	$D3,$H2#hi,$R1
+	vld4.32		{${S2}[0],${R3}[0],${S3}[0],${R4}[0]},[$tbl0]!
+	vmlal.u32	$D1,$H0#hi,$R1
+	vmlal.u32	$D4,$H3#hi,$R1
+	vmlal.u32	$D2,$H1#hi,$R1
+
+	vmlal.u32	$D3,$H1#hi,$R2
+	vld1.32		${S4}[1],[$tbl1,:32]
+	vmlal.u32	$D0,$H3#hi,$S2
+	vld1.32		${S4}[0],[$tbl0,:32]
+	vmlal.u32	$D4,$H2#hi,$R2
+	vmlal.u32	$D1,$H4#hi,$S2
+	vmlal.u32	$D2,$H0#hi,$R2
+
+	vmlal.u32	$D3,$H0#hi,$R3
+	 it		ne
+	 addne		$tbl1,$ctx,#(48+2*9*4)
+	vmlal.u32	$D0,$H2#hi,$S3
+	 it		ne
+	 addne		$tbl0,$ctx,#(48+3*9*4)
+	vmlal.u32	$D4,$H1#hi,$R3
+	vmlal.u32	$D1,$H3#hi,$S3
+	vmlal.u32	$D2,$H4#hi,$S3
+
+	vmlal.u32	$D3,$H4#hi,$S4
+	 vorn		$MASK,$MASK,$MASK	@ all-ones, can be redundant
+	vmlal.u32	$D0,$H1#hi,$S4
+	 vshr.u64	$MASK,$MASK,#38
+	vmlal.u32	$D4,$H0#hi,$R4
+	vmlal.u32	$D1,$H2#hi,$S4
+	vmlal.u32	$D2,$H3#hi,$S4
+
+	beq		.Lshort_tail
+
+	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
+	@ (hash+inp[0:1])*r^4:r^3 and accumulate
+
+	vld4.32		{${R0}[1],${R1}[1],${S1}[1],${R2}[1]},[$tbl1]!	@ load r^3
+	vld4.32		{${R0}[0],${R1}[0],${S1}[0],${R2}[0]},[$tbl0]!	@ load r^4
+
+	vmlal.u32	$D2,$H2#lo,$R0
+	vmlal.u32	$D0,$H0#lo,$R0
+	vmlal.u32	$D3,$H3#lo,$R0
+	vmlal.u32	$D1,$H1#lo,$R0
+	vmlal.u32	$D4,$H4#lo,$R0
+
+	vmlal.u32	$D0,$H4#lo,$S1
+	vld4.32		{${S2}[1],${R3}[1],${S3}[1],${R4}[1]},[$tbl1]!
+	vmlal.u32	$D3,$H2#lo,$R1
+	vld4.32		{${S2}[0],${R3}[0],${S3}[0],${R4}[0]},[$tbl0]!
+	vmlal.u32	$D1,$H0#lo,$R1
+	vmlal.u32	$D4,$H3#lo,$R1
+	vmlal.u32	$D2,$H1#lo,$R1
+
+	vmlal.u32	$D3,$H1#lo,$R2
+	vld1.32		${S4}[1],[$tbl1,:32]
+	vmlal.u32	$D0,$H3#lo,$S2
+	vld1.32		${S4}[0],[$tbl0,:32]
+	vmlal.u32	$D4,$H2#lo,$R2
+	vmlal.u32	$D1,$H4#lo,$S2
+	vmlal.u32	$D2,$H0#lo,$R2
+
+	vmlal.u32	$D3,$H0#lo,$R3
+	vmlal.u32	$D0,$H2#lo,$S3
+	vmlal.u32	$D4,$H1#lo,$R3
+	vmlal.u32	$D1,$H3#lo,$S3
+	vmlal.u32	$D2,$H4#lo,$S3
+
+	vmlal.u32	$D3,$H4#lo,$S4
+	 vorn		$MASK,$MASK,$MASK	@ all-ones
+	vmlal.u32	$D0,$H1#lo,$S4
+	 vshr.u64	$MASK,$MASK,#38
+	vmlal.u32	$D4,$H0#lo,$R4
+	vmlal.u32	$D1,$H2#lo,$S4
+	vmlal.u32	$D2,$H3#lo,$S4
+
+.Lshort_tail:
+	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
+	@ horizontal addition
+
+	vadd.i64	$D3#lo,$D3#lo,$D3#hi
+	vadd.i64	$D0#lo,$D0#lo,$D0#hi
+	vadd.i64	$D4#lo,$D4#lo,$D4#hi
+	vadd.i64	$D1#lo,$D1#lo,$D1#hi
+	vadd.i64	$D2#lo,$D2#lo,$D2#hi
+
+	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
+	@ lazy reduction, but without narrowing
+
+	vshr.u64	$T0,$D3,#26
+	vand.i64	$D3,$D3,$MASK
+	 vshr.u64	$T1,$D0,#26
+	 vand.i64	$D0,$D0,$MASK
+	vadd.i64	$D4,$D4,$T0		@ h3 -> h4
+	 vadd.i64	$D1,$D1,$T1		@ h0 -> h1
+
+	vshr.u64	$T0,$D4,#26
+	vand.i64	$D4,$D4,$MASK
+	 vshr.u64	$T1,$D1,#26
+	 vand.i64	$D1,$D1,$MASK
+	 vadd.i64	$D2,$D2,$T1		@ h1 -> h2
+
+	vadd.i64	$D0,$D0,$T0
+	vshl.u64	$T0,$T0,#2
+	 vshr.u64	$T1,$D2,#26
+	 vand.i64	$D2,$D2,$MASK
+	vadd.i64	$D0,$D0,$T0		@ h4 -> h0
+	 vadd.i64	$D3,$D3,$T1		@ h2 -> h3
+
+	vshr.u64	$T0,$D0,#26
+	vand.i64	$D0,$D0,$MASK
+	 vshr.u64	$T1,$D3,#26
+	 vand.i64	$D3,$D3,$MASK
+	vadd.i64	$D1,$D1,$T0		@ h0 -> h1
+	 vadd.i64	$D4,$D4,$T1		@ h3 -> h4
+
+	cmp		$len,#0
+	bne		.Leven
+
+	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
+	@ store hash value
+
+	vst4.32		{$D0#lo[0],$D1#lo[0],$D2#lo[0],$D3#lo[0]},[$ctx]!
+	vst1.32		{$D4#lo[0]},[$ctx]
+
+	vldmia	sp!,{d8-d15}			@ epilogue
+	ldmia	sp!,{r4-r7}
+	ret					@ bx	lr
+.size	poly1305_blocks_neon,.-poly1305_blocks_neon
+
+.align	5
+.Lzeros:
+.long	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
+#ifndef	__KERNEL__
+.LOPENSSL_armcap:
+# ifdef	_WIN32
+.word	OPENSSL_armcap_P
+# else
+.word	OPENSSL_armcap_P-.Lpoly1305_init
+# endif
+.comm	OPENSSL_armcap_P,4,4
+.hidden	OPENSSL_armcap_P
+#endif
+#endif
+___
+}	}
+$code.=<<___;
+.asciz	"Poly1305 for ARMv4/NEON, CRYPTOGAMS by \@dot-asm"
+.align	2
+___
+
+foreach (split("\n",$code)) {
+	s/\`([^\`]*)\`/eval $1/geo;
+
+	s/\bq([0-9]+)#(lo|hi)/sprintf "d%d",2*$1+($2 eq "hi")/geo	or
+	s/\bret\b/bx	lr/go						or
+	s/\bbx\s+lr\b/.word\t0xe12fff1e/go;	# make it possible to compile with -march=armv4
+
+	print $_,"\n";
+}
+close STDOUT; # enforce flush
diff --git a/arch/arm/crypto/poly1305-core.S_shipped b/arch/arm/crypto/poly1305-core.S_shipped
new file mode 100644
index 000000000000..37b71d990293
--- /dev/null
+++ b/arch/arm/crypto/poly1305-core.S_shipped
@@ -0,0 +1,1158 @@
+#ifndef	__KERNEL__
+# include "arm_arch.h"
+#else
+# define __ARM_ARCH__ __LINUX_ARM_ARCH__
+# define __ARM_MAX_ARCH__ __LINUX_ARM_ARCH__
+# define poly1305_init   poly1305_init_arm
+# define poly1305_blocks poly1305_blocks_arm
+# define poly1305_emit   poly1305_emit_arm
+.globl	poly1305_blocks_neon
+#endif
+
+#if defined(__thumb2__)
+.syntax	unified
+.thumb
+#else
+.code	32
+#endif
+
+.text
+
+.globl	poly1305_emit
+.globl	poly1305_blocks
+.globl	poly1305_init
+.type	poly1305_init,%function
+.align	5
+poly1305_init:
+.Lpoly1305_init:
+	stmdb	sp!,{r4-r11}
+
+	eor	r3,r3,r3
+	cmp	r1,#0
+	str	r3,[r0,#0]		@ zero hash value
+	str	r3,[r0,#4]
+	str	r3,[r0,#8]
+	str	r3,[r0,#12]
+	str	r3,[r0,#16]
+	str	r3,[r0,#36]		@ clear is_base2_26
+	add	r0,r0,#20
+
+#ifdef	__thumb2__
+	it	eq
+#endif
+	moveq	r0,#0
+	beq	.Lno_key
+
+#if	__ARM_MAX_ARCH__>=7
+	mov	r3,#-1
+	str	r3,[r0,#28]		@ impossible key power value
+# ifndef __KERNEL__
+	adr	r11,.Lpoly1305_init
+	ldr	r12,.LOPENSSL_armcap
+# endif
+#endif
+	ldrb	r4,[r1,#0]
+	mov	r10,#0x0fffffff
+	ldrb	r5,[r1,#1]
+	and	r3,r10,#-4		@ 0x0ffffffc
+	ldrb	r6,[r1,#2]
+	ldrb	r7,[r1,#3]
+	orr	r4,r4,r5,lsl#8
+	ldrb	r5,[r1,#4]
+	orr	r4,r4,r6,lsl#16
+	ldrb	r6,[r1,#5]
+	orr	r4,r4,r7,lsl#24
+	ldrb	r7,[r1,#6]
+	and	r4,r4,r10
+
+#if	__ARM_MAX_ARCH__>=7 && !defined(__KERNEL__)
+# if !defined(_WIN32)
+	ldr	r12,[r11,r12]		@ OPENSSL_armcap_P
+# endif
+# if defined(__APPLE__) || defined(_WIN32)
+	ldr	r12,[r12]
+# endif
+#endif
+	ldrb	r8,[r1,#7]
+	orr	r5,r5,r6,lsl#8
+	ldrb	r6,[r1,#8]
+	orr	r5,r5,r7,lsl#16
+	ldrb	r7,[r1,#9]
+	orr	r5,r5,r8,lsl#24
+	ldrb	r8,[r1,#10]
+	and	r5,r5,r3
+
+#if	__ARM_MAX_ARCH__>=7 && !defined(__KERNEL__)
+	tst	r12,#ARMV7_NEON		@ check for NEON
+# ifdef	__thumb2__
+	adr	r9,.Lpoly1305_blocks_neon
+	adr	r11,.Lpoly1305_blocks
+	it	ne
+	movne	r11,r9
+	adr	r12,.Lpoly1305_emit
+	orr	r11,r11,#1		@ thumb-ify addresses
+	orr	r12,r12,#1
+# else
+	add	r12,r11,#(.Lpoly1305_emit-.Lpoly1305_init)
+	ite	eq
+	addeq	r11,r11,#(.Lpoly1305_blocks-.Lpoly1305_init)
+	addne	r11,r11,#(.Lpoly1305_blocks_neon-.Lpoly1305_init)
+# endif
+#endif
+	ldrb	r9,[r1,#11]
+	orr	r6,r6,r7,lsl#8
+	ldrb	r7,[r1,#12]
+	orr	r6,r6,r8,lsl#16
+	ldrb	r8,[r1,#13]
+	orr	r6,r6,r9,lsl#24
+	ldrb	r9,[r1,#14]
+	and	r6,r6,r3
+
+	ldrb	r10,[r1,#15]
+	orr	r7,r7,r8,lsl#8
+	str	r4,[r0,#0]
+	orr	r7,r7,r9,lsl#16
+	str	r5,[r0,#4]
+	orr	r7,r7,r10,lsl#24
+	str	r6,[r0,#8]
+	and	r7,r7,r3
+	str	r7,[r0,#12]
+#if	__ARM_MAX_ARCH__>=7 && !defined(__KERNEL__)
+	stmia	r2,{r11,r12}		@ fill functions table
+	mov	r0,#1
+#else
+	mov	r0,#0
+#endif
+.Lno_key:
+	ldmia	sp!,{r4-r11}
+#if	__ARM_ARCH__>=5
+	bx	lr				@ bx	lr
+#else
+	tst	lr,#1
+	moveq	pc,lr			@ be binary compatible with V4, yet
+	.word	0xe12fff1e			@ interoperable with Thumb ISA:-)
+#endif
+.size	poly1305_init,.-poly1305_init
+.type	poly1305_blocks,%function
+.align	5
+poly1305_blocks:
+.Lpoly1305_blocks:
+	stmdb	sp!,{r3-r11,lr}
+
+	ands	r2,r2,#-16
+	beq	.Lno_data
+
+	add	r2,r2,r1		@ end pointer
+	sub	sp,sp,#32
+
+#if __ARM_ARCH__<7
+	ldmia	r0,{r4-r12}		@ load context
+	add	r0,r0,#20
+	str	r2,[sp,#16]		@ offload stuff
+	str	r0,[sp,#12]
+#else
+	ldr	lr,[r0,#36]		@ is_base2_26
+	ldmia	r0!,{r4-r8}		@ load hash value
+	str	r2,[sp,#16]		@ offload stuff
+	str	r0,[sp,#12]
+
+	adds	r9,r4,r5,lsl#26	@ base 2^26 -> base 2^32
+	mov	r10,r5,lsr#6
+	adcs	r10,r10,r6,lsl#20
+	mov	r11,r6,lsr#12
+	adcs	r11,r11,r7,lsl#14
+	mov	r12,r7,lsr#18
+	adcs	r12,r12,r8,lsl#8
+	mov	r2,#0
+	teq	lr,#0
+	str	r2,[r0,#16]		@ clear is_base2_26
+	adc	r2,r2,r8,lsr#24
+
+	itttt	ne
+	movne	r4,r9			@ choose between radixes
+	movne	r5,r10
+	movne	r6,r11
+	movne	r7,r12
+	ldmia	r0,{r9-r12}		@ load key
+	it	ne
+	movne	r8,r2
+#endif
+
+	mov	lr,r1
+	cmp	r3,#0
+	str	r10,[sp,#20]
+	str	r11,[sp,#24]
+	str	r12,[sp,#28]
+	b	.Loop
+
+.align	4
+.Loop:
+#if __ARM_ARCH__<7
+	ldrb	r0,[lr],#16		@ load input
+# ifdef	__thumb2__
+	it	hi
+# endif
+	addhi	r8,r8,#1		@ 1<<128
+	ldrb	r1,[lr,#-15]
+	ldrb	r2,[lr,#-14]
+	ldrb	r3,[lr,#-13]
+	orr	r1,r0,r1,lsl#8
+	ldrb	r0,[lr,#-12]
+	orr	r2,r1,r2,lsl#16
+	ldrb	r1,[lr,#-11]
+	orr	r3,r2,r3,lsl#24
+	ldrb	r2,[lr,#-10]
+	adds	r4,r4,r3		@ accumulate input
+
+	ldrb	r3,[lr,#-9]
+	orr	r1,r0,r1,lsl#8
+	ldrb	r0,[lr,#-8]
+	orr	r2,r1,r2,lsl#16
+	ldrb	r1,[lr,#-7]
+	orr	r3,r2,r3,lsl#24
+	ldrb	r2,[lr,#-6]
+	adcs	r5,r5,r3
+
+	ldrb	r3,[lr,#-5]
+	orr	r1,r0,r1,lsl#8
+	ldrb	r0,[lr,#-4]
+	orr	r2,r1,r2,lsl#16
+	ldrb	r1,[lr,#-3]
+	orr	r3,r2,r3,lsl#24
+	ldrb	r2,[lr,#-2]
+	adcs	r6,r6,r3
+
+	ldrb	r3,[lr,#-1]
+	orr	r1,r0,r1,lsl#8
+	str	lr,[sp,#8]		@ offload input pointer
+	orr	r2,r1,r2,lsl#16
+	add	r10,r10,r10,lsr#2
+	orr	r3,r2,r3,lsl#24
+#else
+	ldr	r0,[lr],#16		@ load input
+	it	hi
+	addhi	r8,r8,#1		@ padbit
+	ldr	r1,[lr,#-12]
+	ldr	r2,[lr,#-8]
+	ldr	r3,[lr,#-4]
+# ifdef	__ARMEB__
+	rev	r0,r0
+	rev	r1,r1
+	rev	r2,r2
+	rev	r3,r3
+# endif
+	adds	r4,r4,r0		@ accumulate input
+	str	lr,[sp,#8]		@ offload input pointer
+	adcs	r5,r5,r1
+	add	r10,r10,r10,lsr#2
+	adcs	r6,r6,r2
+#endif
+	add	r11,r11,r11,lsr#2
+	adcs	r7,r7,r3
+	add	r12,r12,r12,lsr#2
+
+	umull	r2,r3,r5,r9
+	 adc	r8,r8,#0
+	umull	r0,r1,r4,r9
+	umlal	r2,r3,r8,r10
+	umlal	r0,r1,r7,r10
+	ldr	r10,[sp,#20]		@ reload r10
+	umlal	r2,r3,r6,r12
+	umlal	r0,r1,r5,r12
+	umlal	r2,r3,r7,r11
+	umlal	r0,r1,r6,r11
+	umlal	r2,r3,r4,r10
+	str	r0,[sp,#0]		@ future r4
+	 mul	r0,r11,r8
+	ldr	r11,[sp,#24]		@ reload r11
+	adds	r2,r2,r1		@ d1+=d0>>32
+	 eor	r1,r1,r1
+	adc	lr,r3,#0		@ future r6
+	str	r2,[sp,#4]		@ future r5
+
+	mul	r2,r12,r8
+	eor	r3,r3,r3
+	umlal	r0,r1,r7,r12
+	ldr	r12,[sp,#28]		@ reload r12
+	umlal	r2,r3,r7,r9
+	umlal	r0,r1,r6,r9
+	umlal	r2,r3,r6,r10
+	umlal	r0,r1,r5,r10
+	umlal	r2,r3,r5,r11
+	umlal	r0,r1,r4,r11
+	umlal	r2,r3,r4,r12
+	ldr	r4,[sp,#0]
+	mul	r8,r9,r8
+	ldr	r5,[sp,#4]
+
+	adds	r6,lr,r0		@ d2+=d1>>32
+	ldr	lr,[sp,#8]		@ reload input pointer
+	adc	r1,r1,#0
+	adds	r7,r2,r1		@ d3+=d2>>32
+	ldr	r0,[sp,#16]		@ reload end pointer
+	adc	r3,r3,#0
+	add	r8,r8,r3		@ h4+=d3>>32
+
+	and	r1,r8,#-4
+	and	r8,r8,#3
+	add	r1,r1,r1,lsr#2		@ *=5
+	adds	r4,r4,r1
+	adcs	r5,r5,#0
+	adcs	r6,r6,#0
+	adcs	r7,r7,#0
+	adc	r8,r8,#0
+
+	cmp	r0,lr			@ done yet?
+	bhi	.Loop
+
+	ldr	r0,[sp,#12]
+	add	sp,sp,#32
+	stmdb	r0,{r4-r8}		@ store the result
+
+.Lno_data:
+#if	__ARM_ARCH__>=5
+	ldmia	sp!,{r3-r11,pc}
+#else
+	ldmia	sp!,{r3-r11,lr}
+	tst	lr,#1
+	moveq	pc,lr			@ be binary compatible with V4, yet
+	.word	0xe12fff1e			@ interoperable with Thumb ISA:-)
+#endif
+.size	poly1305_blocks,.-poly1305_blocks
+.type	poly1305_emit,%function
+.align	5
+poly1305_emit:
+.Lpoly1305_emit:
+	stmdb	sp!,{r4-r11}
+
+	ldmia	r0,{r3-r7}
+
+#if __ARM_ARCH__>=7
+	ldr	ip,[r0,#36]		@ is_base2_26
+
+	adds	r8,r3,r4,lsl#26	@ base 2^26 -> base 2^32
+	mov	r9,r4,lsr#6
+	adcs	r9,r9,r5,lsl#20
+	mov	r10,r5,lsr#12
+	adcs	r10,r10,r6,lsl#14
+	mov	r11,r6,lsr#18
+	adcs	r11,r11,r7,lsl#8
+	mov	r0,#0
+	adc	r0,r0,r7,lsr#24
+
+	tst	ip,ip
+	itttt	ne
+	movne	r3,r8
+	movne	r4,r9
+	movne	r5,r10
+	movne	r6,r11
+	it	ne
+	movne	r7,r0
+#endif
+
+	adds	r8,r3,#5		@ compare to modulus
+	adcs	r9,r4,#0
+	adcs	r10,r5,#0
+	adcs	r11,r6,#0
+	adc	r0,r7,#0
+	tst	r0,#4			@ did it carry/borrow?
+
+#ifdef	__thumb2__
+	it	ne
+#endif
+	movne	r3,r8
+	ldr	r8,[r2,#0]
+#ifdef	__thumb2__
+	it	ne
+#endif
+	movne	r4,r9
+	ldr	r9,[r2,#4]
+#ifdef	__thumb2__
+	it	ne
+#endif
+	movne	r5,r10
+	ldr	r10,[r2,#8]
+#ifdef	__thumb2__
+	it	ne
+#endif
+	movne	r6,r11
+	ldr	r11,[r2,#12]
+
+	adds	r3,r3,r8
+	adcs	r4,r4,r9
+	adcs	r5,r5,r10
+	adc	r6,r6,r11
+
+#if __ARM_ARCH__>=7
+# ifdef __ARMEB__
+	rev	r3,r3
+	rev	r4,r4
+	rev	r5,r5
+	rev	r6,r6
+# endif
+	str	r3,[r1,#0]
+	str	r4,[r1,#4]
+	str	r5,[r1,#8]
+	str	r6,[r1,#12]
+#else
+	strb	r3,[r1,#0]
+	mov	r3,r3,lsr#8
+	strb	r4,[r1,#4]
+	mov	r4,r4,lsr#8
+	strb	r5,[r1,#8]
+	mov	r5,r5,lsr#8
+	strb	r6,[r1,#12]
+	mov	r6,r6,lsr#8
+
+	strb	r3,[r1,#1]
+	mov	r3,r3,lsr#8
+	strb	r4,[r1,#5]
+	mov	r4,r4,lsr#8
+	strb	r5,[r1,#9]
+	mov	r5,r5,lsr#8
+	strb	r6,[r1,#13]
+	mov	r6,r6,lsr#8
+
+	strb	r3,[r1,#2]
+	mov	r3,r3,lsr#8
+	strb	r4,[r1,#6]
+	mov	r4,r4,lsr#8
+	strb	r5,[r1,#10]
+	mov	r5,r5,lsr#8
+	strb	r6,[r1,#14]
+	mov	r6,r6,lsr#8
+
+	strb	r3,[r1,#3]
+	strb	r4,[r1,#7]
+	strb	r5,[r1,#11]
+	strb	r6,[r1,#15]
+#endif
+	ldmia	sp!,{r4-r11}
+#if	__ARM_ARCH__>=5
+	bx	lr				@ bx	lr
+#else
+	tst	lr,#1
+	moveq	pc,lr			@ be binary compatible with V4, yet
+	.word	0xe12fff1e			@ interoperable with Thumb ISA:-)
+#endif
+.size	poly1305_emit,.-poly1305_emit
+#if	__ARM_MAX_ARCH__>=7
+.fpu	neon
+
+.type	poly1305_init_neon,%function
+.align	5
+poly1305_init_neon:
+.Lpoly1305_init_neon:
+	ldr	r3,[r0,#48]		@ first table element
+	cmp	r3,#-1			@ is value impossible?
+	bne	.Lno_init_neon
+
+	ldr	r4,[r0,#20]		@ load key base 2^32
+	ldr	r5,[r0,#24]
+	ldr	r6,[r0,#28]
+	ldr	r7,[r0,#32]
+
+	and	r2,r4,#0x03ffffff	@ base 2^32 -> base 2^26
+	mov	r3,r4,lsr#26
+	mov	r4,r5,lsr#20
+	orr	r3,r3,r5,lsl#6
+	mov	r5,r6,lsr#14
+	orr	r4,r4,r6,lsl#12
+	mov	r6,r7,lsr#8
+	orr	r5,r5,r7,lsl#18
+	and	r3,r3,#0x03ffffff
+	and	r4,r4,#0x03ffffff
+	and	r5,r5,#0x03ffffff
+
+	vdup.32	d0,r2			@ r^1 in both lanes
+	add	r2,r3,r3,lsl#2		@ *5
+	vdup.32	d1,r3
+	add	r3,r4,r4,lsl#2
+	vdup.32	d2,r2
+	vdup.32	d3,r4
+	add	r4,r5,r5,lsl#2
+	vdup.32	d4,r3
+	vdup.32	d5,r5
+	add	r5,r6,r6,lsl#2
+	vdup.32	d6,r4
+	vdup.32	d7,r6
+	vdup.32	d8,r5
+
+	mov	r5,#2		@ counter
+
+.Lsquare_neon:
+	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
+	@ d0 = h0*r0 + h4*5*r1 + h3*5*r2 + h2*5*r3 + h1*5*r4
+	@ d1 = h1*r0 + h0*r1   + h4*5*r2 + h3*5*r3 + h2*5*r4
+	@ d2 = h2*r0 + h1*r1   + h0*r2   + h4*5*r3 + h3*5*r4
+	@ d3 = h3*r0 + h2*r1   + h1*r2   + h0*r3   + h4*5*r4
+	@ d4 = h4*r0 + h3*r1   + h2*r2   + h1*r3   + h0*r4
+
+	vmull.u32	q5,d0,d0[1]
+	vmull.u32	q6,d1,d0[1]
+	vmull.u32	q7,d3,d0[1]
+	vmull.u32	q8,d5,d0[1]
+	vmull.u32	q9,d7,d0[1]
+
+	vmlal.u32	q5,d7,d2[1]
+	vmlal.u32	q6,d0,d1[1]
+	vmlal.u32	q7,d1,d1[1]
+	vmlal.u32	q8,d3,d1[1]
+	vmlal.u32	q9,d5,d1[1]
+
+	vmlal.u32	q5,d5,d4[1]
+	vmlal.u32	q6,d7,d4[1]
+	vmlal.u32	q8,d1,d3[1]
+	vmlal.u32	q7,d0,d3[1]
+	vmlal.u32	q9,d3,d3[1]
+
+	vmlal.u32	q5,d3,d6[1]
+	vmlal.u32	q8,d0,d5[1]
+	vmlal.u32	q6,d5,d6[1]
+	vmlal.u32	q7,d7,d6[1]
+	vmlal.u32	q9,d1,d5[1]
+
+	vmlal.u32	q8,d7,d8[1]
+	vmlal.u32	q5,d1,d8[1]
+	vmlal.u32	q6,d3,d8[1]
+	vmlal.u32	q7,d5,d8[1]
+	vmlal.u32	q9,d0,d7[1]
+
+	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
+	@ lazy reduction as discussed in "NEON crypto" by D.J. Bernstein
+	@ and P. Schwabe
+	@
+	@ H0>>+H1>>+H2>>+H3>>+H4
+	@ H3>>+H4>>*5+H0>>+H1
+	@
+	@ Trivia.
+	@
+	@ Result of multiplication of n-bit number by m-bit number is
+	@ n+m bits wide. However! Even though 2^n is a n+1-bit number,
+	@ m-bit number multiplied by 2^n is still n+m bits wide.
+	@
+	@ Sum of two n-bit numbers is n+1 bits wide, sum of three - n+2,
+	@ and so is sum of four. Sum of 2^m n-m-bit numbers and n-bit
+	@ one is n+1 bits wide.
+	@
+	@ >>+ denotes Hnext += Hn>>26, Hn &= 0x3ffffff. This means that
+	@ H0, H2, H3 are guaranteed to be 26 bits wide, while H1 and H4
+	@ can be 27. However! In cases when their width exceeds 26 bits
+	@ they are limited by 2^26+2^6. This in turn means that *sum*
+	@ of the products with these values can still be viewed as sum
+	@ of 52-bit numbers as long as the amount of addends is not a
+	@ power of 2. For example,
+	@
+	@ H4 = H4*R0 + H3*R1 + H2*R2 + H1*R3 + H0 * R4,
+	@
+	@ which can't be larger than 5 * (2^26 + 2^6) * (2^26 + 2^6), or
+	@ 5 * (2^52 + 2*2^32 + 2^12), which in turn is smaller than
+	@ 8 * (2^52) or 2^55. However, the value is then multiplied by
+	@ by 5, so we should be looking at 5 * 5 * (2^52 + 2^33 + 2^12),
+	@ which is less than 32 * (2^52) or 2^57. And when processing
+	@ data we are looking at triple as many addends...
+	@
+	@ In key setup procedure pre-reduced H0 is limited by 5*4+1 and
+	@ 5*H4 - by 5*5 52-bit addends, or 57 bits. But when hashing the
+	@ input H0 is limited by (5*4+1)*3 addends, or 58 bits, while
+	@ 5*H4 by 5*5*3, or 59[!] bits. How is this relevant? vmlal.u32
+	@ instruction accepts 2x32-bit input and writes 2x64-bit result.
+	@ This means that result of reduction have to be compressed upon
+	@ loop wrap-around. This can be done in the process of reduction
+	@ to minimize amount of instructions [as well as amount of
+	@ 128-bit instructions, which benefits low-end processors], but
+	@ one has to watch for H2 (which is narrower than H0) and 5*H4
+	@ not being wider than 58 bits, so that result of right shift
+	@ by 26 bits fits in 32 bits. This is also useful on x86,
+	@ because it allows to use paddd in place for paddq, which
+	@ benefits Atom, where paddq is ridiculously slow.
+
+	vshr.u64	q15,q8,#26
+	vmovn.i64	d16,q8
+	 vshr.u64	q4,q5,#26
+	 vmovn.i64	d10,q5
+	vadd.i64	q9,q9,q15		@ h3 -> h4
+	vbic.i32	d16,#0xfc000000	@ &=0x03ffffff
+	 vadd.i64	q6,q6,q4		@ h0 -> h1
+	 vbic.i32	d10,#0xfc000000
+
+	vshrn.u64	d30,q9,#26
+	vmovn.i64	d18,q9
+	 vshr.u64	q4,q6,#26
+	 vmovn.i64	d12,q6
+	 vadd.i64	q7,q7,q4		@ h1 -> h2
+	vbic.i32	d18,#0xfc000000
+	 vbic.i32	d12,#0xfc000000
+
+	vadd.i32	d10,d10,d30
+	vshl.u32	d30,d30,#2
+	 vshrn.u64	d8,q7,#26
+	 vmovn.i64	d14,q7
+	vadd.i32	d10,d10,d30	@ h4 -> h0
+	 vadd.i32	d16,d16,d8	@ h2 -> h3
+	 vbic.i32	d14,#0xfc000000
+
+	vshr.u32	d30,d10,#26
+	vbic.i32	d10,#0xfc000000
+	 vshr.u32	d8,d16,#26
+	 vbic.i32	d16,#0xfc000000
+	vadd.i32	d12,d12,d30	@ h0 -> h1
+	 vadd.i32	d18,d18,d8	@ h3 -> h4
+
+	subs		r5,r5,#1
+	beq		.Lsquare_break_neon
+
+	add		r6,r0,#(48+0*9*4)
+	add		r7,r0,#(48+1*9*4)
+
+	vtrn.32		d0,d10		@ r^2:r^1
+	vtrn.32		d3,d14
+	vtrn.32		d5,d16
+	vtrn.32		d1,d12
+	vtrn.32		d7,d18
+
+	vshl.u32	d4,d3,#2		@ *5
+	vshl.u32	d6,d5,#2
+	vshl.u32	d2,d1,#2
+	vshl.u32	d8,d7,#2
+	vadd.i32	d4,d4,d3
+	vadd.i32	d2,d2,d1
+	vadd.i32	d6,d6,d5
+	vadd.i32	d8,d8,d7
+
+	vst4.32		{d0[0],d1[0],d2[0],d3[0]},[r6]!
+	vst4.32		{d0[1],d1[1],d2[1],d3[1]},[r7]!
+	vst4.32		{d4[0],d5[0],d6[0],d7[0]},[r6]!
+	vst4.32		{d4[1],d5[1],d6[1],d7[1]},[r7]!
+	vst1.32		{d8[0]},[r6,:32]
+	vst1.32		{d8[1]},[r7,:32]
+
+	b		.Lsquare_neon
+
+.align	4
+.Lsquare_break_neon:
+	add		r6,r0,#(48+2*4*9)
+	add		r7,r0,#(48+3*4*9)
+
+	vmov		d0,d10		@ r^4:r^3
+	vshl.u32	d2,d12,#2		@ *5
+	vmov		d1,d12
+	vshl.u32	d4,d14,#2
+	vmov		d3,d14
+	vshl.u32	d6,d16,#2
+	vmov		d5,d16
+	vshl.u32	d8,d18,#2
+	vmov		d7,d18
+	vadd.i32	d2,d2,d12
+	vadd.i32	d4,d4,d14
+	vadd.i32	d6,d6,d16
+	vadd.i32	d8,d8,d18
+
+	vst4.32		{d0[0],d1[0],d2[0],d3[0]},[r6]!
+	vst4.32		{d0[1],d1[1],d2[1],d3[1]},[r7]!
+	vst4.32		{d4[0],d5[0],d6[0],d7[0]},[r6]!
+	vst4.32		{d4[1],d5[1],d6[1],d7[1]},[r7]!
+	vst1.32		{d8[0]},[r6]
+	vst1.32		{d8[1]},[r7]
+
+.Lno_init_neon:
+	bx	lr				@ bx	lr
+.size	poly1305_init_neon,.-poly1305_init_neon
+
+.type	poly1305_blocks_neon,%function
+.align	5
+poly1305_blocks_neon:
+.Lpoly1305_blocks_neon:
+	ldr	ip,[r0,#36]		@ is_base2_26
+
+	cmp	r2,#64
+	blo	.Lpoly1305_blocks
+
+	stmdb	sp!,{r4-r7}
+	vstmdb	sp!,{d8-d15}		@ ABI specification says so
+
+	tst	ip,ip			@ is_base2_26?
+	bne	.Lbase2_26_neon
+
+	stmdb	sp!,{r1-r3,lr}
+	bl	.Lpoly1305_init_neon
+
+	ldr	r4,[r0,#0]		@ load hash value base 2^32
+	ldr	r5,[r0,#4]
+	ldr	r6,[r0,#8]
+	ldr	r7,[r0,#12]
+	ldr	ip,[r0,#16]
+
+	and	r2,r4,#0x03ffffff	@ base 2^32 -> base 2^26
+	mov	r3,r4,lsr#26
+	 veor	d10,d10,d10
+	mov	r4,r5,lsr#20
+	orr	r3,r3,r5,lsl#6
+	 veor	d12,d12,d12
+	mov	r5,r6,lsr#14
+	orr	r4,r4,r6,lsl#12
+	 veor	d14,d14,d14
+	mov	r6,r7,lsr#8
+	orr	r5,r5,r7,lsl#18
+	 veor	d16,d16,d16
+	and	r3,r3,#0x03ffffff
+	orr	r6,r6,ip,lsl#24
+	 veor	d18,d18,d18
+	and	r4,r4,#0x03ffffff
+	mov	r1,#1
+	and	r5,r5,#0x03ffffff
+	str	r1,[r0,#36]		@ set is_base2_26
+
+	vmov.32	d10[0],r2
+	vmov.32	d12[0],r3
+	vmov.32	d14[0],r4
+	vmov.32	d16[0],r5
+	vmov.32	d18[0],r6
+	adr	r5,.Lzeros
+
+	ldmia	sp!,{r1-r3,lr}
+	b	.Lhash_loaded
+
+.align	4
+.Lbase2_26_neon:
+	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
+	@ load hash value
+
+	veor		d10,d10,d10
+	veor		d12,d12,d12
+	veor		d14,d14,d14
+	veor		d16,d16,d16
+	veor		d18,d18,d18
+	vld4.32		{d10[0],d12[0],d14[0],d16[0]},[r0]!
+	adr		r5,.Lzeros
+	vld1.32		{d18[0]},[r0]
+	sub		r0,r0,#16		@ rewind
+
+.Lhash_loaded:
+	add		r4,r1,#32
+	mov		r3,r3,lsl#24
+	tst		r2,#31
+	beq		.Leven
+
+	vld4.32		{d20[0],d22[0],d24[0],d26[0]},[r1]!
+	vmov.32		d28[0],r3
+	sub		r2,r2,#16
+	add		r4,r1,#32
+
+# ifdef	__ARMEB__
+	vrev32.8	q10,q10
+	vrev32.8	q13,q13
+	vrev32.8	q11,q11
+	vrev32.8	q12,q12
+# endif
+	vsri.u32	d28,d26,#8	@ base 2^32 -> base 2^26
+	vshl.u32	d26,d26,#18
+
+	vsri.u32	d26,d24,#14
+	vshl.u32	d24,d24,#12
+	vadd.i32	d29,d28,d18	@ add hash value and move to #hi
+
+	vbic.i32	d26,#0xfc000000
+	vsri.u32	d24,d22,#20
+	vshl.u32	d22,d22,#6
+
+	vbic.i32	d24,#0xfc000000
+	vsri.u32	d22,d20,#26
+	vadd.i32	d27,d26,d16
+
+	vbic.i32	d20,#0xfc000000
+	vbic.i32	d22,#0xfc000000
+	vadd.i32	d25,d24,d14
+
+	vadd.i32	d21,d20,d10
+	vadd.i32	d23,d22,d12
+
+	mov		r7,r5
+	add		r6,r0,#48
+
+	cmp		r2,r2
+	b		.Long_tail
+
+.align	4
+.Leven:
+	subs		r2,r2,#64
+	it		lo
+	movlo		r4,r5
+
+	vmov.i32	q14,#1<<24		@ padbit, yes, always
+	vld4.32		{d20,d22,d24,d26},[r1]	@ inp[0:1]
+	add		r1,r1,#64
+	vld4.32		{d21,d23,d25,d27},[r4]	@ inp[2:3] (or 0)
+	add		r4,r4,#64
+	itt		hi
+	addhi		r7,r0,#(48+1*9*4)
+	addhi		r6,r0,#(48+3*9*4)
+
+# ifdef	__ARMEB__
+	vrev32.8	q10,q10
+	vrev32.8	q13,q13
+	vrev32.8	q11,q11
+	vrev32.8	q12,q12
+# endif
+	vsri.u32	q14,q13,#8		@ base 2^32 -> base 2^26
+	vshl.u32	q13,q13,#18
+
+	vsri.u32	q13,q12,#14
+	vshl.u32	q12,q12,#12
+
+	vbic.i32	q13,#0xfc000000
+	vsri.u32	q12,q11,#20
+	vshl.u32	q11,q11,#6
+
+	vbic.i32	q12,#0xfc000000
+	vsri.u32	q11,q10,#26
+
+	vbic.i32	q10,#0xfc000000
+	vbic.i32	q11,#0xfc000000
+
+	bls		.Lskip_loop
+
+	vld4.32		{d0[1],d1[1],d2[1],d3[1]},[r7]!	@ load r^2
+	vld4.32		{d0[0],d1[0],d2[0],d3[0]},[r6]!	@ load r^4
+	vld4.32		{d4[1],d5[1],d6[1],d7[1]},[r7]!
+	vld4.32		{d4[0],d5[0],d6[0],d7[0]},[r6]!
+	b		.Loop_neon
+
+.align	5
+.Loop_neon:
+	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
+	@ ((inp[0]*r^4+inp[2]*r^2+inp[4])*r^4+inp[6]*r^2
+	@ ((inp[1]*r^4+inp[3]*r^2+inp[5])*r^3+inp[7]*r
+	@   ___________________/
+	@ ((inp[0]*r^4+inp[2]*r^2+inp[4])*r^4+inp[6]*r^2+inp[8])*r^2
+	@ ((inp[1]*r^4+inp[3]*r^2+inp[5])*r^4+inp[7]*r^2+inp[9])*r
+	@   ___________________/ ____________________/
+	@
+	@ Note that we start with inp[2:3]*r^2. This is because it
+	@ doesn't depend on reduction in previous iteration.
+	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
+	@ d4 = h4*r0 + h3*r1   + h2*r2   + h1*r3   + h0*r4
+	@ d3 = h3*r0 + h2*r1   + h1*r2   + h0*r3   + h4*5*r4
+	@ d2 = h2*r0 + h1*r1   + h0*r2   + h4*5*r3 + h3*5*r4
+	@ d1 = h1*r0 + h0*r1   + h4*5*r2 + h3*5*r3 + h2*5*r4
+	@ d0 = h0*r0 + h4*5*r1 + h3*5*r2 + h2*5*r3 + h1*5*r4
+
+	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
+	@ inp[2:3]*r^2
+
+	vadd.i32	d24,d24,d14	@ accumulate inp[0:1]
+	vmull.u32	q7,d25,d0[1]
+	vadd.i32	d20,d20,d10
+	vmull.u32	q5,d21,d0[1]
+	vadd.i32	d26,d26,d16
+	vmull.u32	q8,d27,d0[1]
+	vmlal.u32	q7,d23,d1[1]
+	vadd.i32	d22,d22,d12
+	vmull.u32	q6,d23,d0[1]
+
+	vadd.i32	d28,d28,d18
+	vmull.u32	q9,d29,d0[1]
+	subs		r2,r2,#64
+	vmlal.u32	q5,d29,d2[1]
+	it		lo
+	movlo		r4,r5
+	vmlal.u32	q8,d25,d1[1]
+	vld1.32		d8[1],[r7,:32]
+	vmlal.u32	q6,d21,d1[1]
+	vmlal.u32	q9,d27,d1[1]
+
+	vmlal.u32	q5,d27,d4[1]
+	vmlal.u32	q8,d23,d3[1]
+	vmlal.u32	q9,d25,d3[1]
+	vmlal.u32	q6,d29,d4[1]
+	vmlal.u32	q7,d21,d3[1]
+
+	vmlal.u32	q8,d21,d5[1]
+	vmlal.u32	q5,d25,d6[1]
+	vmlal.u32	q9,d23,d5[1]
+	vmlal.u32	q6,d27,d6[1]
+	vmlal.u32	q7,d29,d6[1]
+
+	vmlal.u32	q8,d29,d8[1]
+	vmlal.u32	q5,d23,d8[1]
+	vmlal.u32	q9,d21,d7[1]
+	vmlal.u32	q6,d25,d8[1]
+	vmlal.u32	q7,d27,d8[1]
+
+	vld4.32		{d21,d23,d25,d27},[r4]	@ inp[2:3] (or 0)
+	add		r4,r4,#64
+
+	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
+	@ (hash+inp[0:1])*r^4 and accumulate
+
+	vmlal.u32	q8,d26,d0[0]
+	vmlal.u32	q5,d20,d0[0]
+	vmlal.u32	q9,d28,d0[0]
+	vmlal.u32	q6,d22,d0[0]
+	vmlal.u32	q7,d24,d0[0]
+	vld1.32		d8[0],[r6,:32]
+
+	vmlal.u32	q8,d24,d1[0]
+	vmlal.u32	q5,d28,d2[0]
+	vmlal.u32	q9,d26,d1[0]
+	vmlal.u32	q6,d20,d1[0]
+	vmlal.u32	q7,d22,d1[0]
+
+	vmlal.u32	q8,d22,d3[0]
+	vmlal.u32	q5,d26,d4[0]
+	vmlal.u32	q9,d24,d3[0]
+	vmlal.u32	q6,d28,d4[0]
+	vmlal.u32	q7,d20,d3[0]
+
+	vmlal.u32	q8,d20,d5[0]
+	vmlal.u32	q5,d24,d6[0]
+	vmlal.u32	q9,d22,d5[0]
+	vmlal.u32	q6,d26,d6[0]
+	vmlal.u32	q8,d28,d8[0]
+
+	vmlal.u32	q7,d28,d6[0]
+	vmlal.u32	q5,d22,d8[0]
+	vmlal.u32	q9,d20,d7[0]
+	vmov.i32	q14,#1<<24		@ padbit, yes, always
+	vmlal.u32	q6,d24,d8[0]
+	vmlal.u32	q7,d26,d8[0]
+
+	vld4.32		{d20,d22,d24,d26},[r1]	@ inp[0:1]
+	add		r1,r1,#64
+# ifdef	__ARMEB__
+	vrev32.8	q10,q10
+	vrev32.8	q11,q11
+	vrev32.8	q12,q12
+	vrev32.8	q13,q13
+# endif
+
+	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
+	@ lazy reduction interleaved with base 2^32 -> base 2^26 of
+	@ inp[0:3] previously loaded to q10-q13 and smashed to q10-q14.
+
+	vshr.u64	q15,q8,#26
+	vmovn.i64	d16,q8
+	 vshr.u64	q4,q5,#26
+	 vmovn.i64	d10,q5
+	vadd.i64	q9,q9,q15		@ h3 -> h4
+	vbic.i32	d16,#0xfc000000
+	  vsri.u32	q14,q13,#8		@ base 2^32 -> base 2^26
+	 vadd.i64	q6,q6,q4		@ h0 -> h1
+	  vshl.u32	q13,q13,#18
+	 vbic.i32	d10,#0xfc000000
+
+	vshrn.u64	d30,q9,#26
+	vmovn.i64	d18,q9
+	 vshr.u64	q4,q6,#26
+	 vmovn.i64	d12,q6
+	 vadd.i64	q7,q7,q4		@ h1 -> h2
+	  vsri.u32	q13,q12,#14
+	vbic.i32	d18,#0xfc000000
+	  vshl.u32	q12,q12,#12
+	 vbic.i32	d12,#0xfc000000
+
+	vadd.i32	d10,d10,d30
+	vshl.u32	d30,d30,#2
+	  vbic.i32	q13,#0xfc000000
+	 vshrn.u64	d8,q7,#26
+	 vmovn.i64	d14,q7
+	vaddl.u32	q5,d10,d30	@ h4 -> h0 [widen for a sec]
+	  vsri.u32	q12,q11,#20
+	 vadd.i32	d16,d16,d8	@ h2 -> h3
+	  vshl.u32	q11,q11,#6
+	 vbic.i32	d14,#0xfc000000
+	  vbic.i32	q12,#0xfc000000
+
+	vshrn.u64	d30,q5,#26		@ re-narrow
+	vmovn.i64	d10,q5
+	  vsri.u32	q11,q10,#26
+	  vbic.i32	q10,#0xfc000000
+	 vshr.u32	d8,d16,#26
+	 vbic.i32	d16,#0xfc000000
+	vbic.i32	d10,#0xfc000000
+	vadd.i32	d12,d12,d30	@ h0 -> h1
+	 vadd.i32	d18,d18,d8	@ h3 -> h4
+	  vbic.i32	q11,#0xfc000000
+
+	bhi		.Loop_neon
+
+.Lskip_loop:
+	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
+	@ multiply (inp[0:1]+hash) or inp[2:3] by r^2:r^1
+
+	add		r7,r0,#(48+0*9*4)
+	add		r6,r0,#(48+1*9*4)
+	adds		r2,r2,#32
+	it		ne
+	movne		r2,#0
+	bne		.Long_tail
+
+	vadd.i32	d25,d24,d14	@ add hash value and move to #hi
+	vadd.i32	d21,d20,d10
+	vadd.i32	d27,d26,d16
+	vadd.i32	d23,d22,d12
+	vadd.i32	d29,d28,d18
+
+.Long_tail:
+	vld4.32		{d0[1],d1[1],d2[1],d3[1]},[r7]!	@ load r^1
+	vld4.32		{d0[0],d1[0],d2[0],d3[0]},[r6]!	@ load r^2
+
+	vadd.i32	d24,d24,d14	@ can be redundant
+	vmull.u32	q7,d25,d0
+	vadd.i32	d20,d20,d10
+	vmull.u32	q5,d21,d0
+	vadd.i32	d26,d26,d16
+	vmull.u32	q8,d27,d0
+	vadd.i32	d22,d22,d12
+	vmull.u32	q6,d23,d0
+	vadd.i32	d28,d28,d18
+	vmull.u32	q9,d29,d0
+
+	vmlal.u32	q5,d29,d2
+	vld4.32		{d4[1],d5[1],d6[1],d7[1]},[r7]!
+	vmlal.u32	q8,d25,d1
+	vld4.32		{d4[0],d5[0],d6[0],d7[0]},[r6]!
+	vmlal.u32	q6,d21,d1
+	vmlal.u32	q9,d27,d1
+	vmlal.u32	q7,d23,d1
+
+	vmlal.u32	q8,d23,d3
+	vld1.32		d8[1],[r7,:32]
+	vmlal.u32	q5,d27,d4
+	vld1.32		d8[0],[r6,:32]
+	vmlal.u32	q9,d25,d3
+	vmlal.u32	q6,d29,d4
+	vmlal.u32	q7,d21,d3
+
+	vmlal.u32	q8,d21,d5
+	 it		ne
+	 addne		r7,r0,#(48+2*9*4)
+	vmlal.u32	q5,d25,d6
+	 it		ne
+	 addne		r6,r0,#(48+3*9*4)
+	vmlal.u32	q9,d23,d5
+	vmlal.u32	q6,d27,d6
+	vmlal.u32	q7,d29,d6
+
+	vmlal.u32	q8,d29,d8
+	 vorn		q0,q0,q0	@ all-ones, can be redundant
+	vmlal.u32	q5,d23,d8
+	 vshr.u64	q0,q0,#38
+	vmlal.u32	q9,d21,d7
+	vmlal.u32	q6,d25,d8
+	vmlal.u32	q7,d27,d8
+
+	beq		.Lshort_tail
+
+	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
+	@ (hash+inp[0:1])*r^4:r^3 and accumulate
+
+	vld4.32		{d0[1],d1[1],d2[1],d3[1]},[r7]!	@ load r^3
+	vld4.32		{d0[0],d1[0],d2[0],d3[0]},[r6]!	@ load r^4
+
+	vmlal.u32	q7,d24,d0
+	vmlal.u32	q5,d20,d0
+	vmlal.u32	q8,d26,d0
+	vmlal.u32	q6,d22,d0
+	vmlal.u32	q9,d28,d0
+
+	vmlal.u32	q5,d28,d2
+	vld4.32		{d4[1],d5[1],d6[1],d7[1]},[r7]!
+	vmlal.u32	q8,d24,d1
+	vld4.32		{d4[0],d5[0],d6[0],d7[0]},[r6]!
+	vmlal.u32	q6,d20,d1
+	vmlal.u32	q9,d26,d1
+	vmlal.u32	q7,d22,d1
+
+	vmlal.u32	q8,d22,d3
+	vld1.32		d8[1],[r7,:32]
+	vmlal.u32	q5,d26,d4
+	vld1.32		d8[0],[r6,:32]
+	vmlal.u32	q9,d24,d3
+	vmlal.u32	q6,d28,d4
+	vmlal.u32	q7,d20,d3
+
+	vmlal.u32	q8,d20,d5
+	vmlal.u32	q5,d24,d6
+	vmlal.u32	q9,d22,d5
+	vmlal.u32	q6,d26,d6
+	vmlal.u32	q7,d28,d6
+
+	vmlal.u32	q8,d28,d8
+	 vorn		q0,q0,q0	@ all-ones
+	vmlal.u32	q5,d22,d8
+	 vshr.u64	q0,q0,#38
+	vmlal.u32	q9,d20,d7
+	vmlal.u32	q6,d24,d8
+	vmlal.u32	q7,d26,d8
+
+.Lshort_tail:
+	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
+	@ horizontal addition
+
+	vadd.i64	d16,d16,d17
+	vadd.i64	d10,d10,d11
+	vadd.i64	d18,d18,d19
+	vadd.i64	d12,d12,d13
+	vadd.i64	d14,d14,d15
+
+	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
+	@ lazy reduction, but without narrowing
+
+	vshr.u64	q15,q8,#26
+	vand.i64	q8,q8,q0
+	 vshr.u64	q4,q5,#26
+	 vand.i64	q5,q5,q0
+	vadd.i64	q9,q9,q15		@ h3 -> h4
+	 vadd.i64	q6,q6,q4		@ h0 -> h1
+
+	vshr.u64	q15,q9,#26
+	vand.i64	q9,q9,q0
+	 vshr.u64	q4,q6,#26
+	 vand.i64	q6,q6,q0
+	 vadd.i64	q7,q7,q4		@ h1 -> h2
+
+	vadd.i64	q5,q5,q15
+	vshl.u64	q15,q15,#2
+	 vshr.u64	q4,q7,#26
+	 vand.i64	q7,q7,q0
+	vadd.i64	q5,q5,q15		@ h4 -> h0
+	 vadd.i64	q8,q8,q4		@ h2 -> h3
+
+	vshr.u64	q15,q5,#26
+	vand.i64	q5,q5,q0
+	 vshr.u64	q4,q8,#26
+	 vand.i64	q8,q8,q0
+	vadd.i64	q6,q6,q15		@ h0 -> h1
+	 vadd.i64	q9,q9,q4		@ h3 -> h4
+
+	cmp		r2,#0
+	bne		.Leven
+
+	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
+	@ store hash value
+
+	vst4.32		{d10[0],d12[0],d14[0],d16[0]},[r0]!
+	vst1.32		{d18[0]},[r0]
+
+	vldmia	sp!,{d8-d15}			@ epilogue
+	ldmia	sp!,{r4-r7}
+	bx	lr					@ bx	lr
+.size	poly1305_blocks_neon,.-poly1305_blocks_neon
+
+.align	5
+.Lzeros:
+.long	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
+#ifndef	__KERNEL__
+.LOPENSSL_armcap:
+# ifdef	_WIN32
+.word	OPENSSL_armcap_P
+# else
+.word	OPENSSL_armcap_P-.Lpoly1305_init
+# endif
+.comm	OPENSSL_armcap_P,4,4
+.hidden	OPENSSL_armcap_P
+#endif
+#endif
+.asciz	"Poly1305 for ARMv4/NEON, CRYPTOGAMS by @dot-asm"
+.align	2
diff --git a/arch/arm/crypto/poly1305-glue.c b/arch/arm/crypto/poly1305-glue.c
new file mode 100644
index 000000000000..9b8713f96441
--- /dev/null
+++ b/arch/arm/crypto/poly1305-glue.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * OpenSSL/Cryptogams accelerated Poly1305 transform for ARM
+ *
+ * Copyright (C) 2019 Linaro Ltd. <ard.biesheuvel@linaro.org>
+ */
+
+#include <asm/hwcap.h>
+#include <asm/neon.h>
+#include <asm/simd.h>
+#include <asm/unaligned.h>
+#include <crypto/algapi.h>
+#include <crypto/internal/hash.h>
+#include <crypto/internal/poly1305.h>
+#include <crypto/internal/simd.h>
+#include <linux/cpufeature.h>
+#include <linux/crypto.h>
+#include <linux/jump_label.h>
+#include <linux/module.h>
+
+asmlinkage void poly1305_init_arm(void *state, const u8 *key);
+asmlinkage void poly1305_blocks_arm(void *state, const u8 *src, u32 len, u32 hibit);
+asmlinkage void poly1305_blocks_neon(void *state, const u8 *src, u32 len, u32 hibit);
+asmlinkage void poly1305_emit_arm(void *state, __le32 *digest, const u32 *nonce);
+
+static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_neon);
+
+void poly1305_init(struct poly1305_desc_ctx *dctx, const u8 *key)
+{
+	poly1305_init_arm(&dctx->h, key);
+	dctx->s[0] = get_unaligned_le32(key + 16);
+	dctx->s[1] = get_unaligned_le32(key + 20);
+	dctx->s[2] = get_unaligned_le32(key + 24);
+	dctx->s[3] = get_unaligned_le32(key + 28);
+	dctx->buflen = 0;
+}
+EXPORT_SYMBOL(poly1305_init);
+
+static int arm_poly1305_init(struct shash_desc *desc)
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
+static void arm_poly1305_blocks(struct poly1305_desc_ctx *dctx, const u8 *src,
+				 u32 len, u32 hibit, bool do_neon)
+{
+	if (unlikely(!dctx->sset)) {
+		if (!dctx->rset) {
+			poly1305_init_arm(&dctx->h, src);
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
+	if (static_branch_likely(&have_neon) && likely(do_neon))
+		poly1305_blocks_neon(&dctx->h, src, len, hibit);
+	else
+		poly1305_blocks_arm(&dctx->h, src, len, hibit);
+}
+
+static void arm_poly1305_do_update(struct poly1305_desc_ctx *dctx,
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
+			arm_poly1305_blocks(dctx, dctx->buf,
+					    POLY1305_BLOCK_SIZE, 1, false);
+			dctx->buflen = 0;
+		}
+	}
+
+	if (likely(len >= POLY1305_BLOCK_SIZE)) {
+		arm_poly1305_blocks(dctx, src, len, 1, do_neon);
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
+static int arm_poly1305_update(struct shash_desc *desc,
+			       const u8 *src, unsigned int srclen)
+{
+	struct poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
+
+	arm_poly1305_do_update(dctx, src, srclen, false);
+	return 0;
+}
+
+static int __maybe_unused arm_poly1305_update_neon(struct shash_desc *desc,
+						   const u8 *src,
+						   unsigned int srclen)
+{
+	struct poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
+	bool do_neon = crypto_simd_usable() && srclen > 128;
+
+	if (static_branch_likely(&have_neon) && do_neon)
+		kernel_neon_begin();
+	arm_poly1305_do_update(dctx, src, srclen, do_neon);
+	if (static_branch_likely(&have_neon) && do_neon)
+		kernel_neon_end();
+	return 0;
+}
+
+void poly1305_update(struct poly1305_desc_ctx *dctx, const u8 *src,
+		     unsigned int nbytes)
+{
+	bool do_neon = IS_ENABLED(CONFIG_KERNEL_MODE_NEON) &&
+		       crypto_simd_usable() && nbytes > 128;
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
+			poly1305_blocks_arm(&dctx->h, dctx->buf,
+					    POLY1305_BLOCK_SIZE, 1);
+			dctx->buflen = 0;
+		}
+	}
+
+	if (likely(nbytes >= POLY1305_BLOCK_SIZE)) {
+		unsigned int len = round_down(nbytes, POLY1305_BLOCK_SIZE);
+
+		if (static_branch_likely(&have_neon) && do_neon) {
+			kernel_neon_begin();
+			poly1305_blocks_neon(&dctx->h, src, len, 1);
+			kernel_neon_end();
+		} else {
+			poly1305_blocks_arm(&dctx->h, src, len, 1);
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
+		poly1305_blocks_arm(&dctx->h, dctx->buf, POLY1305_BLOCK_SIZE, 0);
+	}
+
+	poly1305_emit_arm(&dctx->h, digest, dctx->s);
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
+static int arm_poly1305_final(struct shash_desc *desc, u8 *dst)
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
+static struct shash_alg arm_poly1305_algs[] = {{
+	.init			= arm_poly1305_init,
+	.update			= arm_poly1305_update,
+	.final			= arm_poly1305_final,
+	.digestsize		= POLY1305_DIGEST_SIZE,
+	.descsize		= sizeof(struct poly1305_desc_ctx),
+
+	.base.cra_name		= "poly1305",
+	.base.cra_driver_name	= "poly1305-arm",
+	.base.cra_priority	= 150,
+	.base.cra_blocksize	= POLY1305_BLOCK_SIZE,
+	.base.cra_module	= THIS_MODULE,
+#ifdef CONFIG_KERNEL_MODE_NEON
+}, {
+	.init			= arm_poly1305_init,
+	.update			= arm_poly1305_update_neon,
+	.final			= arm_poly1305_final,
+	.digestsize		= POLY1305_DIGEST_SIZE,
+	.descsize		= sizeof(struct poly1305_desc_ctx),
+
+	.base.cra_name		= "poly1305",
+	.base.cra_driver_name	= "poly1305-neon",
+	.base.cra_priority	= 200,
+	.base.cra_blocksize	= POLY1305_BLOCK_SIZE,
+	.base.cra_module	= THIS_MODULE,
+#endif
+}};
+
+static int __init arm_poly1305_mod_init(void)
+{
+	if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) &&
+	    (elf_hwcap & HWCAP_NEON))
+		static_branch_enable(&have_neon);
+	else
+		/* register only the first entry */
+		return crypto_register_shash(&arm_poly1305_algs[0]);
+
+	return crypto_register_shashes(arm_poly1305_algs,
+				       ARRAY_SIZE(arm_poly1305_algs));
+}
+
+static void __exit arm_poly1305_mod_exit(void)
+{
+	if (!static_branch_likely(&have_neon)) {
+		crypto_unregister_shash(&arm_poly1305_algs[0]);
+		return;
+	}
+	crypto_unregister_shashes(arm_poly1305_algs,
+				  ARRAY_SIZE(arm_poly1305_algs));
+}
+
+module_init(arm_poly1305_mod_init);
+module_exit(arm_poly1305_mod_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS_CRYPTO("poly1305");
+MODULE_ALIAS_CRYPTO("poly1305-arm");
+MODULE_ALIAS_CRYPTO("poly1305-neon");
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 8292b4925eeb..ddda2bcdf5b7 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -688,7 +688,7 @@ config CRYPTO_ARCH_HAVE_LIB_POLY1305
 config CRYPTO_LIB_POLY1305_RSIZE
 	int
 	default 4 if X86_64
-	default 9 if ARM64
+	default 9 if ARM || ARM64
 	default 1
 
 config CRYPTO_LIB_POLY1305
-- 
2.20.1


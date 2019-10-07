Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75C5BCE9BA
	for <lists+linux-crypto@lfdr.de>; Mon,  7 Oct 2019 18:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfJGQqu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 7 Oct 2019 12:46:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43429 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbfJGQqu (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 7 Oct 2019 12:46:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id j18so15345745wrq.10
        for <linux-crypto@vger.kernel.org>; Mon, 07 Oct 2019 09:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LRHbc5uz7YTzypuBMgPyUy9zQarygo5Q03xggE4Zo5c=;
        b=afivOIYJcnReDnp6CXD8085/Uu832n68n7/tHyeGr0iGsBQZhGC6wo6PcaWoVbiIbx
         vrjiBvEzoKdw2JqlBrymwjoI4XmH6RfWK9TucMXj5T81SpCvt4PaHYJz4vM448orer3s
         VZBVS2H86EdSobKwWzAB1BXbtRHIUsuSd+Asx3hcOyIpVlDMMO6ho8REeIxtungy3DPh
         XpvfeXx+mbWwYoCA06yUb2fKotB5+0rY1In+7r8d+Pp9RjKBVGlyN1coqEPTtoylbz4M
         8y9q5XOmv38kulCsW/6vpeNskf0tSTO3V4osKe2xEKqyvEvwIh/jDr0PHGYMZEIYx/3T
         jiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LRHbc5uz7YTzypuBMgPyUy9zQarygo5Q03xggE4Zo5c=;
        b=jQ5u1oaXajK0KP/LHQjW3jlPmhkZlrfbNtmwBQMf7NJ1Vv/M9xorOc4HPtf9uaZeJv
         Sm+az0BiN/TeaqNNuZtP6RpQjs3fPPzh23N+oTsBSQVo8WizSqtbMmyVJnS2fqO7hUF/
         /tKCL/W1YUj8xp/HH+nx/tt0KDJRhdRmXjL4IYXOEh92xc7aTm8IQSlJvenKRff/VtPQ
         QSjp7D+WFM/jkzRZuH67WTEcr7rmQlZW7bzWb7yD+i2vUVnkTZVKZmA1fkoWU2AukSuE
         w133fatq6iiJB56sQjYaS5QifQqoHCu8r20KgTFu8s0mPFuwd/QXwDkpBce4ONrmN/6Q
         6Fjg==
X-Gm-Message-State: APjAAAUeSrU2FSK3IS1bHhYQawvWyIWVLXjIEwpNw0RasQ7W/xBCN3QO
        NjWFHuKxoEg/S6v5saRzcpA5cLfoa7a3Mw==
X-Google-Smtp-Source: APXvYqzJRL86e1k0S+MyLwAi9PloQfL06o2MWKk930nUxpOstMRrA91/CMkqlCO4lbmqdz6A+bg1ug==
X-Received: by 2002:adf:8163:: with SMTP id 90mr19686328wrm.129.1570466805117;
        Mon, 07 Oct 2019 09:46:45 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
        by smtp.gmail.com with ESMTPSA id b22sm68507wmj.36.2019.10.07.09.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 09:46:44 -0700 (PDT)
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
Subject: [PATCH v3 19/29] crypto: mips/poly1305 - incorporate OpenSSL/CRYPTOGAMS optimized implementation
Date:   Mon,  7 Oct 2019 18:46:00 +0200
Message-Id: <20191007164610.6881-20-ard.biesheuvel@linaro.org>
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
for MIPS authored by Andy Polyakov, and contributed by him to the OpenSSL
project. The file 'poly1305-mips.pl' is taken straight from this upstream
GitHub repository [0] at commit 57c3a63be70b4f68b9eec1b043164ea790db6499,
and already contains all the changes required to build it as part of a
Linux kernel module.

[0] https://github.com/dot-asm/cryptogams

Co-developed-by: Andy Polyakov <appro@cryptogams.org>
Signed-off-by: Andy Polyakov <appro@cryptogams.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/mips/crypto/Makefile         |   14 +
 arch/mips/crypto/poly1305-glue.c  |  203 ++++
 arch/mips/crypto/poly1305-mips.pl | 1246 ++++++++++++++++++++
 crypto/Kconfig                    |    6 +
 4 files changed, 1469 insertions(+)

diff --git a/arch/mips/crypto/Makefile b/arch/mips/crypto/Makefile
index b528b9d300f1..8e1deaf00e0c 100644
--- a/arch/mips/crypto/Makefile
+++ b/arch/mips/crypto/Makefile
@@ -8,3 +8,17 @@ obj-$(CONFIG_CRYPTO_CRC32_MIPS) += crc32-mips.o
 obj-$(CONFIG_CRYPTO_CHACHA_MIPS) += chacha-mips.o
 chacha-mips-y := chacha-core.o chacha-glue.o
 AFLAGS_chacha-core.o += -O2 # needed to fill branch delay slots
+
+obj-$(CONFIG_CRYPTO_POLY1305_MIPS) += poly1305-mips.o
+poly1305-mips-y := poly1305-core.o poly1305-glue.o
+
+perlasm-flavour-$(CONFIG_CPU_MIPS32) := o32
+perlasm-flavour-$(CONFIG_CPU_MIPS64) := 64
+
+quiet_cmd_perlasm = PERLASM $@
+      cmd_perlasm = $(PERL) $(<) $(perlasm-flavour-y) $(@)
+
+$(obj)/poly1305-core.S: $(src)/poly1305-mips.pl FORCE
+	$(call if_changed,perlasm)
+
+targets += poly1305-core.S
diff --git a/arch/mips/crypto/poly1305-glue.c b/arch/mips/crypto/poly1305-glue.c
new file mode 100644
index 000000000000..7e1742cdc5a4
--- /dev/null
+++ b/arch/mips/crypto/poly1305-glue.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * OpenSSL/Cryptogams accelerated Poly1305 transform for MIPS
+ *
+ * Copyright (C) 2019 Linaro Ltd. <ard.biesheuvel@linaro.org>
+ */
+
+#include <asm/unaligned.h>
+#include <crypto/algapi.h>
+#include <crypto/internal/hash.h>
+#include <crypto/internal/poly1305.h>
+#include <linux/cpufeature.h>
+#include <linux/crypto.h>
+#include <linux/module.h>
+
+asmlinkage void poly1305_init_mips(void *state, const u8 *key);
+asmlinkage void poly1305_blocks_mips(void *state, const u8 *src, u32 len, u32 hibit);
+asmlinkage void poly1305_emit_mips(void *state, __le32 *digest, const u32 *nonce);
+
+void poly1305_init(struct poly1305_desc_ctx *dctx, const u8 *key)
+{
+	poly1305_init_mips(&dctx->h, key);
+	dctx->s[0] = get_unaligned_le32(key + 16);
+	dctx->s[1] = get_unaligned_le32(key + 20);
+	dctx->s[2] = get_unaligned_le32(key + 24);
+	dctx->s[3] = get_unaligned_le32(key + 28);
+	dctx->buflen = 0;
+}
+EXPORT_SYMBOL(poly1305_init);
+
+static int mips_poly1305_init(struct shash_desc *desc)
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
+static void mips_poly1305_blocks(struct poly1305_desc_ctx *dctx, const u8 *src,
+				 u32 len, u32 hibit)
+{
+	if (unlikely(!dctx->sset)) {
+		if (!dctx->rset) {
+			poly1305_init_mips(&dctx->h, src);
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
+	poly1305_blocks_mips(&dctx->h, src, len, hibit);
+}
+
+static int mips_poly1305_update(struct shash_desc *desc, const u8 *src,
+				unsigned int len)
+{
+	struct poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
+
+	if (unlikely(dctx->buflen)) {
+		u32 bytes = min(len, POLY1305_BLOCK_SIZE - dctx->buflen);
+
+		memcpy(dctx->buf + dctx->buflen, src, bytes);
+		src += bytes;
+		len -= bytes;
+		dctx->buflen += bytes;
+
+		if (dctx->buflen == POLY1305_BLOCK_SIZE) {
+			mips_poly1305_blocks(dctx, dctx->buf, POLY1305_BLOCK_SIZE, 1);
+			dctx->buflen = 0;
+		}
+	}
+
+	if (likely(len >= POLY1305_BLOCK_SIZE)) {
+		mips_poly1305_blocks(dctx, src, len, 1);
+		src += round_down(len, POLY1305_BLOCK_SIZE);
+		len %= POLY1305_BLOCK_SIZE;
+	}
+
+	if (unlikely(len)) {
+		dctx->buflen = len;
+		memcpy(dctx->buf, src, len);
+	}
+	return 0;
+}
+
+void poly1305_update(struct poly1305_desc_ctx *dctx, const u8 *src,
+		     unsigned int nbytes)
+{
+	if (unlikely(dctx->buflen)) {
+		u32 bytes = min(nbytes, POLY1305_BLOCK_SIZE - dctx->buflen);
+
+		memcpy(dctx->buf + dctx->buflen, src, bytes);
+		src += bytes;
+		nbytes -= bytes;
+		dctx->buflen += bytes;
+
+		if (dctx->buflen == POLY1305_BLOCK_SIZE) {
+			poly1305_blocks_mips(&dctx->h, dctx->buf,
+					     POLY1305_BLOCK_SIZE, 1);
+			dctx->buflen = 0;
+		}
+	}
+
+	if (likely(nbytes >= POLY1305_BLOCK_SIZE)) {
+		unsigned int len = round_down(nbytes, POLY1305_BLOCK_SIZE);
+
+		poly1305_blocks_mips(&dctx->h, src, len, 1);
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
+		poly1305_blocks_mips(&dctx->h, dctx->buf, POLY1305_BLOCK_SIZE, 0);
+	}
+
+	poly1305_emit_mips(&dctx->h, digest, dctx->s);
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
+static int mips_poly1305_final(struct shash_desc *desc, u8 *dst)
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
+static struct shash_alg mips_poly1305_alg = {
+	.init			= mips_poly1305_init,
+	.update			= mips_poly1305_update,
+	.final			= mips_poly1305_final,
+	.digestsize		= POLY1305_DIGEST_SIZE,
+	.descsize		= sizeof(struct poly1305_desc_ctx),
+
+	.base.cra_name		= "poly1305",
+	.base.cra_driver_name	= "poly1305-mips",
+	.base.cra_priority	= 200,
+	.base.cra_blocksize	= POLY1305_BLOCK_SIZE,
+	.base.cra_module	= THIS_MODULE,
+};
+
+static int __init mips_poly1305_mod_init(void)
+{
+	return crypto_register_shash(&mips_poly1305_alg);
+}
+
+static void __exit mips_poly1305_mod_exit(void)
+{
+	crypto_unregister_shash(&mips_poly1305_alg);
+}
+
+module_init(mips_poly1305_mod_init);
+module_exit(mips_poly1305_mod_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS_CRYPTO("poly1305");
+MODULE_ALIAS_CRYPTO("poly1305-mips");
diff --git a/arch/mips/crypto/poly1305-mips.pl b/arch/mips/crypto/poly1305-mips.pl
new file mode 100644
index 000000000000..02928df00a88
--- /dev/null
+++ b/arch/mips/crypto/poly1305-mips.pl
@@ -0,0 +1,1246 @@
+#!/usr/bin/env perl
+# SPDX-License-Identifier: GPL-1.0+ OR BSD-3-Clause
+#
+# ====================================================================
+# Written by Andy Polyakov, @dot-asm, originally for the OpenSSL
+# project.
+# ====================================================================
+
+# Poly1305 hash for MIPS.
+#
+# May 2016
+#
+# Numbers are cycles per processed byte with poly1305_blocks alone.
+#
+#		IALU/gcc
+# R1x000	5.64/+120%	(big-endian)
+# Octeon II	3.80/+280%	(little-endian)
+#
+# March 2019
+#
+# Add 32-bit code path.
+#
+#		IALU/gcc
+# R1x000	10.3/?		(big-endian)
+# Octeon II	4.64/+90%	(little-endian)
+#
+######################################################################
+# There is a number of MIPS ABI in use, O32 and N32/64 are most
+# widely used. Then there is a new contender: NUBI. It appears that if
+# one picks the latter, it's possible to arrange code in ABI neutral
+# manner. Therefore let's stick to NUBI register layout:
+#
+($zero,$at,$t0,$t1,$t2)=map("\$$_",(0..2,24,25));
+($a0,$a1,$a2,$a3,$a4,$a5,$a6,$a7)=map("\$$_",(4..11));
+($s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7,$s8,$s9,$s10,$s11)=map("\$$_",(12..23));
+($gp,$tp,$sp,$fp,$ra)=map("\$$_",(3,28..31));
+#
+# The return value is placed in $a0. Following coding rules facilitate
+# interoperability:
+#
+# - never ever touch $tp, "thread pointer", former $gp [o32 can be
+#   excluded from the rule, because it's specified volatile];
+# - copy return value to $t0, former $v0 [or to $a0 if you're adapting
+#   old code];
+# - on O32 populate $a4-$a7 with 'lw $aN,4*N($sp)' if necessary;
+#
+# For reference here is register layout for N32/64 MIPS ABIs:
+#
+# ($zero,$at,$v0,$v1)=map("\$$_",(0..3));
+# ($a0,$a1,$a2,$a3,$a4,$a5,$a6,$a7)=map("\$$_",(4..11));
+# ($t0,$t1,$t2,$t3,$t8,$t9)=map("\$$_",(12..15,24,25));
+# ($s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7)=map("\$$_",(16..23));
+# ($gp,$sp,$fp,$ra)=map("\$$_",(28..31));
+#
+# <appro@openssl.org>
+#
+######################################################################
+
+$flavour = shift || "64"; # supported flavours are o32,n32,64,nubi32,nubi64
+
+$v0 = ($flavour =~ /nubi/i) ? $a0 : $t0;
+
+if ($flavour =~ /64|n32/i) {{{
+######################################################################
+# 64-bit code path
+#
+
+my ($ctx,$inp,$len,$padbit) = ($a0,$a1,$a2,$a3);
+my ($in0,$in1,$tmp0,$tmp1,$tmp2,$tmp3,$tmp4) = ($a4,$a5,$a6,$a7,$at,$t0,$t1);
+
+$code.=<<___;
+#if (defined(_MIPS_ARCH_MIPS64R3) || defined(_MIPS_ARCH_MIPS64R5) || \\
+     defined(_MIPS_ARCH_MIPS64R6)) \\
+     && !defined(_MIPS_ARCH_MIPS64R2)
+# define _MIPS_ARCH_MIPS64R2
+#endif
+
+#if defined(_MIPS_ARCH_MIPS64R6)
+# define dmultu(rs,rt)
+# define mflo(rd,rs,rt)	dmulu	rd,rs,rt
+# define mfhi(rd,rs,rt)	dmuhu	rd,rs,rt
+#else
+# define dmultu(rs,rt)		dmultu	rs,rt
+# define mflo(rd,rs,rt)	mflo	rd
+# define mfhi(rd,rs,rt)	mfhi	rd
+#endif
+
+#ifdef	__KERNEL__
+# define poly1305_init   poly1305_init_mips
+# define poly1305_blocks poly1305_blocks_mips
+# define poly1305_emit   poly1305_emit_mips
+#endif
+
+#if defined(__MIPSEB__) && !defined(MIPSEB)
+# define MIPSEB
+#endif
+
+#ifdef MIPSEB
+# define MSB 0
+# define LSB 7
+#else
+# define MSB 7
+# define LSB 0
+#endif
+
+.text
+.set	noat
+.set	noreorder
+
+.align	5
+.globl	poly1305_init
+.ent	poly1305_init
+poly1305_init:
+	.frame	$sp,0,$ra
+	.set	reorder
+
+	sd	$zero,0($ctx)
+	sd	$zero,8($ctx)
+	sd	$zero,16($ctx)
+
+	beqz	$inp,.Lno_key
+
+#if defined(_MIPS_ARCH_MIPS64R6)
+	andi	$tmp0,$inp,7		# $inp % 8
+	dsubu	$inp,$inp,$tmp0		# align $inp
+	sll	$tmp0,$tmp0,3		# byte to bit offset
+	ld	$in0,0($inp)
+	ld	$in1,8($inp)
+	beqz	$tmp0,.Laligned_key
+	ld	$tmp2,16($inp)
+
+	subu	$tmp1,$zero,$tmp0
+# ifdef	MIPSEB
+	dsllv	$in0,$in0,$tmp0
+	dsrlv	$tmp3,$in1,$tmp1
+	dsllv	$in1,$in1,$tmp0
+	dsrlv	$tmp2,$tmp2,$tmp1
+# else
+	dsrlv	$in0,$in0,$tmp0
+	dsllv	$tmp3,$in1,$tmp1
+	dsrlv	$in1,$in1,$tmp0
+	dsllv	$tmp2,$tmp2,$tmp1
+# endif
+	or	$in0,$in0,$tmp3
+	or	$in1,$in1,$tmp2
+.Laligned_key:
+#else
+	ldl	$in0,0+MSB($inp)
+	ldl	$in1,8+MSB($inp)
+	ldr	$in0,0+LSB($inp)
+	ldr	$in1,8+LSB($inp)
+#endif
+#ifdef	MIPSEB
+# if defined(_MIPS_ARCH_MIPS64R2)
+	dsbh	$in0,$in0		# byte swap
+	 dsbh	$in1,$in1
+	dshd	$in0,$in0
+	 dshd	$in1,$in1
+# else
+	ori	$tmp0,$zero,0xFF
+	dsll	$tmp2,$tmp0,32
+	or	$tmp0,$tmp2		# 0x000000FF000000FF
+
+	and	$tmp1,$in0,$tmp0	# byte swap
+	 and	$tmp3,$in1,$tmp0
+	dsrl	$tmp2,$in0,24
+	 dsrl	$tmp4,$in1,24
+	dsll	$tmp1,24
+	 dsll	$tmp3,24
+	and	$tmp2,$tmp0
+	 and	$tmp4,$tmp0
+	dsll	$tmp0,8			# 0x0000FF000000FF00
+	or	$tmp1,$tmp2
+	 or	$tmp3,$tmp4
+	and	$tmp2,$in0,$tmp0
+	 and	$tmp4,$in1,$tmp0
+	dsrl	$in0,8
+	 dsrl	$in1,8
+	dsll	$tmp2,8
+	 dsll	$tmp4,8
+	and	$in0,$tmp0
+	 and	$in1,$tmp0
+	or	$tmp1,$tmp2
+	 or	$tmp3,$tmp4
+	or	$in0,$tmp1
+	 or	$in1,$tmp3
+	dsrl	$tmp1,$in0,32
+	 dsrl	$tmp3,$in1,32
+	dsll	$in0,32
+	 dsll	$in1,32
+	or	$in0,$tmp1
+	 or	$in1,$tmp3
+# endif
+#endif
+	li	$tmp0,1
+	dsll	$tmp0,32		# 0x0000000100000000
+	daddiu	$tmp0,-63		# 0x00000000ffffffc1
+	dsll	$tmp0,28		# 0x0ffffffc10000000
+	daddiu	$tmp0,-1		# 0x0ffffffc0fffffff
+
+	and	$in0,$tmp0
+	daddiu	$tmp0,-3		# 0x0ffffffc0ffffffc
+	and	$in1,$tmp0
+
+	sd	$in0,24($ctx)
+	dsrl	$tmp0,$in1,2
+	sd	$in1,32($ctx)
+	daddu	$tmp0,$in1		# s1 = r1 + (r1 >> 2)
+	sd	$tmp0,40($ctx)
+
+.Lno_key:
+	li	$v0,0			# return 0
+	jr	$ra
+.end	poly1305_init
+___
+{
+my $SAVED_REGS_MASK = ($flavour =~ /nubi/i) ? "0x0003f000" : "0x00030000";
+
+my ($h0,$h1,$h2,$r0,$r1,$rs1,$d0,$d1,$d2) =
+   ($s0,$s1,$s2,$s3,$s4,$s5,$in0,$in1,$t2);
+my ($shr,$shl) = ($s6,$s7);		# used on R6
+
+$code.=<<___;
+.align	5
+.globl	poly1305_blocks
+.ent	poly1305_blocks
+poly1305_blocks:
+	.set	noreorder
+	dsrl	$len,4			# number of complete blocks
+	bnez	$len,poly1305_blocks_internal
+	nop
+	jr	$ra
+	nop
+.end	poly1305_blocks
+
+.align	5
+.ent	poly1305_blocks_internal
+poly1305_blocks_internal:
+	.frame	$sp,6*8,$ra
+	.mask	$SAVED_REGS_MASK,-8
+	.set	noreorder
+#if defined(_MIPS_ARCH_MIPS64R6)
+	dsubu	$sp,8*8
+	sd	$s7,56($sp)
+	sd	$s6,48($sp)
+#else
+	dsubu	$sp,6*8
+#endif
+	sd	$s5,40($sp)
+	sd	$s4,32($sp)
+___
+$code.=<<___ if ($flavour =~ /nubi/i);	# optimize non-nubi prologue
+	sd	$s3,24($sp)
+	sd	$s2,16($sp)
+	sd	$s1,8($sp)
+	sd	$s0,0($sp)
+___
+$code.=<<___;
+	.set	reorder
+
+	ld	$h0,0($ctx)		# load hash value
+	ld	$h1,8($ctx)
+	ld	$h2,16($ctx)
+
+	ld	$r0,24($ctx)		# load key
+	ld	$r1,32($ctx)
+	ld	$rs1,40($ctx)
+
+#if defined(_MIPS_ARCH_MIPS64R6)
+	andi	$shr,$inp,7
+	dsubu	$inp,$inp,$shr		# align $inp
+	sll	$shr,$shr,3		# byte to bit offset
+	subu	$shl,$zero,$shr
+#endif
+
+.Loop:
+#if defined(_MIPS_ARCH_MIPS64R6)
+	ld	$in0,0($inp)		# load input
+	ld	$in1,8($inp)
+	beqz	$shr,.Laligned_inp
+	ld	$tmp2,16($inp)
+
+# ifdef	MIPSEB
+	dsllv	$in0,$in0,$shr
+	dsrlv	$tmp3,$in1,$shl
+	dsllv	$in1,$in1,$shr
+	dsrlv	$tmp2,$tmp2,$shl
+# else
+	dsrlv	$in0,$in0,$shr
+	dsllv	$tmp3,$in1,$shl
+	dsrlv	$in1,$in1,$shr
+	dsllv	$tmp2,$tmp2,$shl
+# endif
+	or	$in0,$in0,$tmp3
+	or	$in1,$in1,$tmp2
+.Laligned_inp:
+#else
+	ldl	$in0,0+MSB($inp)	# load input
+	ldl	$in1,8+MSB($inp)
+	ldr	$in0,0+LSB($inp)
+	ldr	$in1,8+LSB($inp)
+#endif
+	daddiu	$len,-1
+	daddiu	$inp,16
+#ifdef	MIPSEB
+# if defined(_MIPS_ARCH_MIPS64R2)
+	dsbh	$in0,$in0		# byte swap
+	 dsbh	$in1,$in1
+	dshd	$in0,$in0
+	 dshd	$in1,$in1
+# else
+	ori	$tmp0,$zero,0xFF
+	dsll	$tmp2,$tmp0,32
+	or	$tmp0,$tmp2		# 0x000000FF000000FF
+
+	and	$tmp1,$in0,$tmp0	# byte swap
+	 and	$tmp3,$in1,$tmp0
+	dsrl	$tmp2,$in0,24
+	 dsrl	$tmp4,$in1,24
+	dsll	$tmp1,24
+	 dsll	$tmp3,24
+	and	$tmp2,$tmp0
+	 and	$tmp4,$tmp0
+	dsll	$tmp0,8			# 0x0000FF000000FF00
+	or	$tmp1,$tmp2
+	 or	$tmp3,$tmp4
+	and	$tmp2,$in0,$tmp0
+	 and	$tmp4,$in1,$tmp0
+	dsrl	$in0,8
+	 dsrl	$in1,8
+	dsll	$tmp2,8
+	 dsll	$tmp4,8
+	and	$in0,$tmp0
+	 and	$in1,$tmp0
+	or	$tmp1,$tmp2
+	 or	$tmp3,$tmp4
+	or	$in0,$tmp1
+	 or	$in1,$tmp3
+	dsrl	$tmp1,$in0,32
+	 dsrl	$tmp3,$in1,32
+	dsll	$in0,32
+	 dsll	$in1,32
+	or	$in0,$tmp1
+	 or	$in1,$tmp3
+# endif
+#endif
+	daddu	$h0,$in0		# accumulate input
+	daddu	$h1,$in1
+	sltu	$tmp0,$h0,$in0
+	sltu	$tmp1,$h1,$in1
+	daddu	$h1,$tmp0
+
+	dmultu	($r0,$h0)		# h0*r0
+	 daddu	$h2,$padbit
+	 sltu	$tmp0,$h1,$tmp0
+	mflo	($d0,$r0,$h0)
+	mfhi	($d1,$r0,$h0)
+
+	dmultu	($rs1,$h1)		# h1*5*r1
+	 daddu	$tmp0,$tmp1
+	 daddu	$h2,$tmp0
+	mflo	($tmp0,$rs1,$h1)
+	mfhi	($tmp1,$rs1,$h1)
+
+	dmultu	($r1,$h0)		# h0*r1
+	 daddu	$d0,$tmp0
+	 daddu	$d1,$tmp1
+	mflo	($tmp2,$r1,$h0)
+	mfhi	($d2,$r1,$h0)
+	 sltu	$tmp0,$d0,$tmp0
+	 daddu	$d1,$tmp0
+
+	dmultu	($r0,$h1)		# h1*r0
+	 daddu	$d1,$tmp2
+	 sltu	$tmp2,$d1,$tmp2
+	mflo	($tmp0,$r0,$h1)
+	mfhi	($tmp1,$r0,$h1)
+	 daddu	$d2,$tmp2
+
+	dmultu	($rs1,$h2)		# h2*5*r1
+	 daddu	$d1,$tmp0
+	 daddu	$d2,$tmp1
+	mflo	($tmp2,$rs1,$h2)
+
+	dmultu	($r0,$h2)		# h2*r0
+	 sltu	$tmp0,$d1,$tmp0
+	 daddu	$d2,$tmp0
+	mflo	($tmp3,$r0,$h2)
+
+	daddu	$d1,$tmp2
+	daddu	$d2,$tmp3
+	sltu	$tmp2,$d1,$tmp2
+	daddu	$d2,$tmp2
+
+	li	$tmp0,-4		# final reduction
+	and	$tmp0,$d2
+	dsrl	$tmp1,$d2,2
+	andi	$h2,$d2,3
+	daddu	$tmp0,$tmp1
+	daddu	$h0,$d0,$tmp0
+	sltu	$tmp0,$h0,$tmp0
+	daddu	$h1,$d1,$tmp0
+	sltu	$tmp0,$h1,$tmp0
+	daddu	$h2,$h2,$tmp0
+
+	bnez	$len,.Loop
+
+	sd	$h0,0($ctx)		# store hash value
+	sd	$h1,8($ctx)
+	sd	$h2,16($ctx)
+
+	.set	noreorder
+#if defined(_MIPS_ARCH_MIPS64R6)
+	ld	$s7,56($sp)
+	ld	$s6,48($sp)
+#endif
+	ld	$s5,40($sp)		# epilogue
+	ld	$s4,32($sp)
+___
+$code.=<<___ if ($flavour =~ /nubi/i);	# optimize non-nubi epilogue
+	ld	$s3,24($sp)
+	ld	$s2,16($sp)
+	ld	$s1,8($sp)
+	ld	$s0,0($sp)
+___
+$code.=<<___;
+	jr	$ra
+#if defined(_MIPS_ARCH_MIPS64R6)
+	daddu	$sp,8*8
+#else
+	daddu	$sp,6*8
+#endif
+.end	poly1305_blocks_internal
+___
+}
+{
+my ($ctx,$mac,$nonce) = ($a0,$a1,$a2);
+
+$code.=<<___;
+.align	5
+.globl	poly1305_emit
+.ent	poly1305_emit
+poly1305_emit:
+	.frame	$sp,0,$ra
+	.set	reorder
+
+	ld	$tmp0,0($ctx)
+	ld	$tmp1,8($ctx)
+	ld	$tmp2,16($ctx)
+
+	daddiu	$in0,$tmp0,5		# compare to modulus
+	sltiu	$tmp3,$in0,5
+	daddu	$in1,$tmp1,$tmp3
+	sltu	$tmp3,$in1,$tmp3
+	daddu	$tmp2,$tmp2,$tmp3
+
+	dsrl	$tmp2,2			# see if it carried/borrowed
+	dsubu	$tmp2,$zero,$tmp2
+
+	xor	$in0,$tmp0
+	xor	$in1,$tmp1
+	and	$in0,$tmp2
+	and	$in1,$tmp2
+	xor	$in0,$tmp0
+	xor	$in1,$tmp1
+
+	lwu	$tmp0,0($nonce)		# load nonce
+	lwu	$tmp1,4($nonce)
+	lwu	$tmp2,8($nonce)
+	lwu	$tmp3,12($nonce)
+	dsll	$tmp1,32
+	dsll	$tmp3,32
+	or	$tmp0,$tmp1
+	or	$tmp2,$tmp3
+
+	daddu	$in0,$tmp0		# accumulate nonce
+	daddu	$in1,$tmp2
+	sltu	$tmp0,$in0,$tmp0
+	daddu	$in1,$tmp0
+
+	dsrl	$tmp0,$in0,8		# write mac value
+	dsrl	$tmp1,$in0,16
+	dsrl	$tmp2,$in0,24
+	sb	$in0,0($mac)
+	dsrl	$tmp3,$in0,32
+	sb	$tmp0,1($mac)
+	dsrl	$tmp0,$in0,40
+	sb	$tmp1,2($mac)
+	dsrl	$tmp1,$in0,48
+	sb	$tmp2,3($mac)
+	dsrl	$tmp2,$in0,56
+	sb	$tmp3,4($mac)
+	dsrl	$tmp3,$in1,8
+	sb	$tmp0,5($mac)
+	dsrl	$tmp0,$in1,16
+	sb	$tmp1,6($mac)
+	dsrl	$tmp1,$in1,24
+	sb	$tmp2,7($mac)
+
+	sb	$in1,8($mac)
+	dsrl	$tmp2,$in1,32
+	sb	$tmp3,9($mac)
+	dsrl	$tmp3,$in1,40
+	sb	$tmp0,10($mac)
+	dsrl	$tmp0,$in1,48
+	sb	$tmp1,11($mac)
+	dsrl	$tmp1,$in1,56
+	sb	$tmp2,12($mac)
+	sb	$tmp3,13($mac)
+	sb	$tmp0,14($mac)
+	sb	$tmp1,15($mac)
+
+	jr	$ra
+.end	poly1305_emit
+.rdata
+.asciiz	"Poly1305 for MIPS64, CRYPTOGAMS by \@dot-asm"
+.align	2
+___
+}
+}}} else {{{
+######################################################################
+# 32-bit code path
+#
+
+my ($ctx,$inp,$len,$padbit) = ($a0,$a1,$a2,$a3);
+my ($in0,$in1,$in2,$in3,$tmp0,$tmp1,$tmp2,$tmp3) =
+   ($a4,$a5,$a6,$a7,$at,$t0,$t1,$t2);
+
+$code.=<<___;
+#if (defined(_MIPS_ARCH_MIPS32R3) || defined(_MIPS_ARCH_MIPS32R5) || \\
+     defined(_MIPS_ARCH_MIPS32R6)) \\
+     && !defined(_MIPS_ARCH_MIPS32R2)
+# define _MIPS_ARCH_MIPS32R2
+#endif
+
+#if defined(_MIPS_ARCH_MIPS32R6)
+# define multu(rs,rt)
+# define mflo(rd,rs,rt)	mulu	rd,rs,rt
+# define mfhi(rd,rs,rt)	muhu	rd,rs,rt
+#else
+# define multu(rs,rt)	multu	rs,rt
+# define mflo(rd,rs,rt)	mflo	rd
+# define mfhi(rd,rs,rt)	mfhi	rd
+#endif
+
+#ifdef	__KERNEL__
+# define poly1305_init   poly1305_init_mips
+# define poly1305_blocks poly1305_blocks_mips
+# define poly1305_emit   poly1305_emit_mips
+#endif
+
+#if defined(__MIPSEB__) && !defined(MIPSEB)
+# define MIPSEB
+#endif
+
+#ifdef MIPSEB
+# define MSB 0
+# define LSB 3
+#else
+# define MSB 3
+# define LSB 0
+#endif
+
+.text
+.set	noat
+.set	noreorder
+
+.align	5
+.globl	poly1305_init
+.ent	poly1305_init
+poly1305_init:
+	.frame	$sp,0,$ra
+	.set	reorder
+
+	sw	$zero,0($ctx)
+	sw	$zero,4($ctx)
+	sw	$zero,8($ctx)
+	sw	$zero,12($ctx)
+	sw	$zero,16($ctx)
+
+	beqz	$inp,.Lno_key
+
+#if defined(_MIPS_ARCH_MIPS32R6)
+	andi	$tmp0,$inp,3		# $inp % 4
+	subu	$inp,$inp,$tmp0		# align $inp
+	sll	$tmp0,$tmp0,3		# byte to bit offset
+	lw	$in0,0($inp)
+	lw	$in1,4($inp)
+	lw	$in2,8($inp)
+	lw	$in3,12($inp)
+	beqz	$tmp0,.Laligned_key
+
+	lw	$tmp2,16($inp)
+	subu	$tmp1,$zero,$tmp0
+# ifdef	MIPSEB
+	sllv	$in0,$in0,$tmp0
+	srlv	$tmp3,$in1,$tmp1
+	sllv	$in1,$in1,$tmp0
+	or	$in0,$in0,$tmp3
+	srlv	$tmp3,$in2,$tmp1
+	sllv	$in2,$in2,$tmp0
+	or	$in1,$in1,$tmp3
+	srlv	$tmp3,$in3,$tmp1
+	sllv	$in3,$in3,$tmp0
+	or	$in2,$in2,$tmp3
+	srlv	$tmp2,$tmp2,$tmp1
+	or	$in3,$in3,$tmp2
+# else
+	srlv	$in0,$in0,$tmp0
+	sllv	$tmp3,$in1,$tmp1
+	srlv	$in1,$in1,$tmp0
+	or	$in0,$in0,$tmp3
+	sllv	$tmp3,$in2,$tmp1
+	srlv	$in2,$in2,$tmp0
+	or	$in1,$in1,$tmp3
+	sllv	$tmp3,$in3,$tmp1
+	srlv	$in3,$in3,$tmp0
+	or	$in2,$in2,$tmp3
+	sllv	$tmp2,$tmp2,$tmp1
+	or	$in3,$in3,$tmp2
+# endif
+.Laligned_key:
+#else
+	lwl	$in0,0+MSB($inp)
+	lwl	$in1,4+MSB($inp)
+	lwl	$in2,8+MSB($inp)
+	lwl	$in3,12+MSB($inp)
+	lwr	$in0,0+LSB($inp)
+	lwr	$in1,4+LSB($inp)
+	lwr	$in2,8+LSB($inp)
+	lwr	$in3,12+LSB($inp)
+#endif
+#ifdef	MIPSEB
+# if defined(_MIPS_ARCH_MIPS32R2)
+	wsbh	$in0,$in0		# byte swap
+	wsbh	$in1,$in1
+	wsbh	$in2,$in2
+	wsbh	$in3,$in3
+	rotr	$in0,$in0,16
+	rotr	$in1,$in1,16
+	rotr	$in2,$in2,16
+	rotr	$in3,$in3,16
+# else
+	srl	$tmp0,$in0,24		# byte swap
+	srl	$tmp1,$in0,8
+	andi	$tmp2,$in0,0xFF00
+	sll	$in0,$in0,24
+	andi	$tmp1,0xFF00
+	sll	$tmp2,$tmp2,8
+	or	$in0,$tmp0
+	 srl	$tmp0,$in1,24
+	or	$tmp1,$tmp2
+	 srl	$tmp2,$in1,8
+	or	$in0,$tmp1
+	 andi	$tmp1,$in1,0xFF00
+	 sll	$in1,$in1,24
+	 andi	$tmp2,0xFF00
+	 sll	$tmp1,$tmp1,8
+	 or	$in1,$tmp0
+	srl	$tmp0,$in2,24
+	 or	$tmp2,$tmp1
+	srl	$tmp1,$in2,8
+	 or	$in1,$tmp2
+	andi	$tmp2,$in2,0xFF00
+	sll	$in2,$in2,24
+	andi	$tmp1,0xFF00
+	sll	$tmp2,$tmp2,8
+	or	$in2,$tmp0
+	 srl	$tmp0,$in3,24
+	or	$tmp1,$tmp2
+	 srl	$tmp2,$in3,8
+	or	$in2,$tmp1
+	 andi	$tmp1,$in3,0xFF00
+	 sll	$in3,$in3,24
+	 andi	$tmp2,0xFF00
+	 sll	$tmp1,$tmp1,8
+	 or	$in3,$tmp0
+	 or	$tmp2,$tmp1
+	 or	$in3,$tmp2
+# endif
+#endif
+	lui	$tmp0,0x0fff
+	ori	$tmp0,0xffff		# 0x0fffffff
+	and	$in0,$in0,$tmp0
+	subu	$tmp0,3			# 0x0ffffffc
+	and	$in1,$in1,$tmp0
+	and	$in2,$in2,$tmp0
+	and	$in3,$in3,$tmp0
+
+	sw	$in0,20($ctx)
+	sw	$in1,24($ctx)
+	sw	$in2,28($ctx)
+	sw	$in3,32($ctx)
+
+	srl	$tmp1,$in1,2
+	srl	$tmp2,$in2,2
+	srl	$tmp3,$in3,2
+	addu	$in1,$in1,$tmp1		# s1 = r1 + (r1 >> 2)
+	addu	$in2,$in2,$tmp2
+	addu	$in3,$in3,$tmp3
+	sw	$in1,36($ctx)
+	sw	$in2,40($ctx)
+	sw	$in3,44($ctx)
+.Lno_key:
+	li	$v0,0
+	jr	$ra
+.end	poly1305_init
+___
+{
+my $SAVED_REGS_MASK = ($flavour =~ /nubi/i) ? "0x00fff000" : "0x00ff0000";
+
+my ($h0,$h1,$h2,$h3,$h4, $r0,$r1,$r2,$r3, $rs1,$rs2,$rs3) =
+   ($s0,$s1,$s2,$s3,$s4, $s5,$s6,$s7,$s8, $s9,$s10,$s11);
+my ($d0,$d1,$d2,$d3) =
+   ($a4,$a5,$a6,$a7);
+my $shr = $t2;		# used on R6
+
+$code.=<<___;
+.globl	poly1305_blocks
+.align	5
+.ent	poly1305_blocks
+poly1305_blocks:
+	.frame	$sp,16*4,$ra
+	.mask	$SAVED_REGS_MASK,-4
+	.set	noreorder
+	subu	$sp, $sp,4*12
+	sw	$s11,4*11($sp)
+	sw	$s10,4*10($sp)
+	sw	$s9, 4*9($sp)
+	sw	$s8, 4*8($sp)
+	sw	$s7, 4*7($sp)
+	sw	$s6, 4*6($sp)
+	sw	$s5, 4*5($sp)
+	sw	$s4, 4*4($sp)
+___
+$code.=<<___ if ($flavour =~ /nubi/i);	# optimize non-nubi prologue
+	sw	$s3, 4*3($sp)
+	sw	$s2, 4*2($sp)
+	sw	$s1, 4*1($sp)
+	sw	$s0, 4*0($sp)
+___
+$code.=<<___;
+	.set	reorder
+
+	srl	$len,4			# number of complete blocks
+	beqz	$len,.Labort
+
+	lw	$h0,0($ctx)		# load hash value
+	lw	$h1,4($ctx)
+	lw	$h2,8($ctx)
+	lw	$h3,12($ctx)
+	lw	$h4,16($ctx)
+
+	lw	$r0,20($ctx)		# load key
+	lw	$r1,24($ctx)
+	lw	$r2,28($ctx)
+	lw	$r3,32($ctx)
+	lw	$rs1,36($ctx)
+	lw	$rs2,40($ctx)
+	lw	$rs3,44($ctx)
+
+#if defined(_MIPS_ARCH_MIPS32R6)
+	andi	$shr,$inp,3
+	subu	$inp,$inp,$shr		# align $inp
+	sll	$shr,$shr,3		# byte to bit offset
+#endif
+
+.Loop:
+#if defined(_MIPS_ARCH_MIPS32R6)
+	lw	$d0,0($inp)		# load input
+	lw	$d1,4($inp)
+	lw	$d2,8($inp)
+	lw	$d3,12($inp)
+	beqz	$shr,.Laligned_inp
+
+	lw	$t0,16($inp)
+	subu	$t1,$zero,$shr
+# ifdef	MIPSEB
+	sllv	$d0,$d0,$shr
+	srlv	$at,$d1,$t1
+	sllv	$d1,$d1,$shr
+	or	$d0,$d0,$at
+	srlv	$at,$d2,$t1
+	sllv	$d2,$d2,$shr
+	or	$d1,$d1,$at
+	srlv	$at,$d3,$t1
+	sllv	$d3,$d3,$shr
+	or	$d2,$d2,$at
+	srlv	$t0,$t0,$t1
+	or	$d3,$d3,$t0
+# else
+	srlv	$d0,$d0,$shr
+	sllv	$at,$d1,$t1
+	srlv	$d1,$d1,$shr
+	or	$d0,$d0,$at
+	sllv	$at,$d2,$t1
+	srlv	$d2,$d2,$shr
+	or	$d1,$d1,$at
+	sllv	$at,$d3,$t1
+	srlv	$d3,$d3,$shr
+	or	$d2,$d2,$at
+	sllv	$t0,$t0,$t1
+	or	$d3,$d3,$t0
+# endif
+.Laligned_inp:
+#else
+	lwl	$d0,0+MSB($inp)		# load input
+	lwl	$d1,4+MSB($inp)
+	lwl	$d2,8+MSB($inp)
+	lwl	$d3,12+MSB($inp)
+	lwr	$d0,0+LSB($inp)
+	lwr	$d1,4+LSB($inp)
+	lwr	$d2,8+LSB($inp)
+	lwr	$d3,12+LSB($inp)
+#endif
+	addiu	$len,$len,-1
+	addiu	$inp,$inp,16
+#ifdef	MIPSEB
+# if defined(_MIPS_ARCH_MIPS32R2)
+	wsbh	$d0,$d0			# byte swap
+	wsbh	$d1,$d1
+	wsbh	$d2,$d2
+	wsbh	$d3,$d3
+	rotr	$d0,$d0,16
+	rotr	$d1,$d1,16
+	rotr	$d2,$d2,16
+	rotr	$d3,$d3,16
+# else
+	srl	$at,$d0,24		# byte swap
+	srl	$t0,$d0,8
+	andi	$t1,$d0,0xFF00
+	sll	$d0,$d0,24
+	andi	$t0,0xFF00
+	sll	$t1,$t1,8
+	or	$d0,$at
+	 srl	$at,$d1,24
+	or	$t0,$t1
+	 srl	$t1,$d1,8
+	or	$d0,$t0
+	 andi	$t0,$d1,0xFF00
+	 sll	$d1,$d1,24
+	 andi	$t1,0xFF00
+	 sll	$t0,$t0,8
+	 or	$d1,$at
+	srl	$at,$d2,24
+	 or	$t1,$t0
+	srl	$t0,$d2,8
+	 or	$d1,$t1
+	andi	$t1,$d2,0xFF00
+	sll	$d2,$d2,24
+	andi	$t0,0xFF00
+	sll	$t1,$t1,8
+	or	$d2,$at
+	 srl	$at,$d3,24
+	or	$t0,$t1
+	 srl	$t1,$d3,8
+	or	$d2,$t0
+	 andi	$t0,$d3,0xFF00
+	 sll	$d3,$d3,24
+	 andi	$t1,0xFF00
+	 sll	$t0,$t0,8
+	 or	$d3,$at
+	 or	$t1,$t0
+	 or	$d3,$t1
+# endif
+#endif
+	addu	$h0,$h0,$d0		# accumulate input
+	sltu	$d0,$h0,$d0		# carry
+
+	addu	$h1,$h1,$d1
+	sltu	$d1,$h1,$d1
+	addu	$h1,$h1,$d0
+	sltu	$d0,$h1,$d0
+	addu	$d1,$d1,$d0		# carry
+
+	addu	$h2,$h2,$d2
+	sltu	$d2,$h2,$d2
+	addu	$h2,$h2,$d1
+	sltu	$d1,$h2,$d1
+	addu	$d2,$d2,$d1		# carry
+
+	addu	$h3,$h3,$d3
+	sltu	$d3,$h3,$d3
+	addu	$h3,$h3,$d2
+
+#if defined(_MIPS_ARCH_MIPS32R2) && !defined(_MIPS_ARCH_MIPS32R6)
+	multu	$r0,$h0			# h0*r0
+	maddu	$rs3,$h1		# h1*s3
+	maddu	$rs2,$h2		# h2*s2
+	maddu	$rs1,$h3		# h3*s1
+	mflo	$d0
+	mfhi	$at
+
+	 sltu	$d2,$h3,$d2
+	 addu	$d3,$d3,$d2		# carry
+	 addu	$h4,$h4,$padbit
+	 addu	$h4,$h4,$d3
+
+	multu	$r1,$h0			# h0*r1
+	maddu	$r0,$h1			# h1*r0
+	maddu	$rs3,$h2		# h2*s3
+	maddu	$rs2,$h3		# h3*s2
+	maddu	$rs1,$h4		# h4*s1
+	mflo	$d1
+	mfhi	$d2
+
+	multu	$r2,$h0			# h0*r2
+	maddu	$r1,$h1			# h1*r1
+	maddu	$r0,$h2			# h2*r0
+	maddu	$rs3,$h3		# h3*s3
+	maddu	$rs2,$h4		# h4*s2
+	 addu	$d1,$d1,$at
+	 sltu	$at,$d1,$at
+	 addu	$at,$d2,$at
+	mflo	$d2
+	mfhi	$d3
+
+	multu	$r3,$h0			# h0*r3
+	maddu	$r2,$h1			# h1*r2
+	maddu	$r1,$h2			# h2*r1
+	maddu	$r0,$h3			# h3*r0
+	maddu	$rs3,$h4		# h4*s3
+	 addu	$d2,$d2,$at
+	 sltu	$at,$d2,$at
+	 addu	$d3,$d3,$at
+	mflo	$h3
+	mfhi	$at
+
+	multu	$r0,$h4			# h4*r0
+	 addu	$h3,$h3,$d3
+	 sltu	$d3,$h3,$d3
+	 addu	$at,$d3,$at
+	mflo	$h4
+
+	addu	$h4,$at,$h4
+#else
+	multu	($r0,$h0)		# h0*r0
+	mflo	($d0,$r0,$h0)
+	mfhi	($d1,$r0,$h0)
+
+	 sltu	$d2,$h3,$d2
+	 addu	$d3,$d3,$d2		# carry
+
+	multu	($rs3,$h1)		# h1*s3
+	mflo	($at,$rs3,$h1)
+	mfhi	($t0,$rs3,$h1)
+
+	 addu	$h4,$h4,$padbit
+	 addu	$h4,$h4,$d3
+
+	multu	($rs2,$h2)		# h2*s2
+	mflo	($a3,$rs2,$h2)
+	mfhi	($t1,$rs2,$h2)
+	 addu	$d0,$d0,$at
+	 addu	$d1,$d1,$t0
+	multu	($rs1,$h3)		# h3*s1
+	 sltu	$at,$d0,$at
+	 addu	$d1,$d1,$at
+
+	mflo	($at,$rs1,$h3)
+	mfhi	($t0,$rs1,$h3)
+	 addu	$d0,$d0,$a3
+	 addu	$d1,$d1,$t1
+	multu	($r1,$h0)		# h0*r1
+	 sltu	$a3,$d0,$a3
+	 addu	$d1,$d1,$a3
+
+
+	mflo	($a3,$r1,$h0)
+	mfhi	($d2,$r1,$h0)
+	 addu	$d0,$d0,$at
+	 addu	$d1,$d1,$t0
+	multu	($r0,$h1)		# h1*r0
+	 sltu	$at,$d0,$at
+	 addu	$d1,$d1,$at
+
+	mflo	($at,$r0,$h1)
+	mfhi	($t0,$r0,$h1)
+	 addu	$d1,$d1,$a3
+	 sltu	$a3,$d1,$a3
+	multu	($rs3,$h2)		# h2*s3
+	 addu	$d2,$d2,$a3
+
+	mflo	($a3,$rs3,$h2)
+	mfhi	($t1,$rs3,$h2)
+	 addu	$d1,$d1,$at
+	 addu	$d2,$d2,$t0
+	multu	($rs2,$h3)		# h3*s2
+	 sltu	$at,$d1,$at
+	 addu	$d2,$d2,$at
+
+	mflo	($at,$rs2,$h3)
+	mfhi	($t0,$rs2,$h3)
+	 addu	$d1,$d1,$a3
+	 addu	$d2,$d2,$t1
+	multu	($rs1,$h4)		# h4*s1
+	 sltu	$a3,$d1,$a3
+	 addu	$d2,$d2,$a3
+
+	mflo	($a3,$rs1,$h4)
+	 addu	$d1,$d1,$at
+	 addu	$d2,$d2,$t0
+	multu	($r2,$h0)		# h0*r2
+	 sltu	$at,$d1,$at
+	 addu	$d2,$d2,$at
+
+
+	mflo	($at,$r2,$h0)
+	mfhi	($d3,$r2,$h0)
+	 addu	$d1,$d1,$a3
+	 sltu	$a3,$d1,$a3
+	multu	($r1,$h1)		# h1*r1
+	 addu	$d2,$d2,$a3
+
+	mflo	($a3,$r1,$h1)
+	mfhi	($t1,$r1,$h1)
+	 addu	$d2,$d2,$at
+	 sltu	$at,$d2,$at
+	multu	($r0,$h2)		# h2*r0
+	 addu	$d3,$d3,$at
+
+	mflo	($at,$r0,$h2)
+	mfhi	($t0,$r0,$h2)
+	 addu	$d2,$d2,$a3
+	 addu	$d3,$d3,$t1
+	multu	($rs3,$h3)		# h3*s3
+	 sltu	$a3,$d2,$a3
+	 addu	$d3,$d3,$a3
+
+	mflo	($a3,$rs3,$h3)
+	mfhi	($t1,$rs3,$h3)
+	 addu	$d2,$d2,$at
+	 addu	$d3,$d3,$t0
+	multu	($rs2,$h4)		# h4*s2
+	 sltu	$at,$d2,$at
+	 addu	$d3,$d3,$at
+
+	mflo	($at,$rs2,$h4)
+	 addu	$d2,$d2,$a3
+	 addu	$d3,$d3,$t1
+	multu	($r3,$h0)		# h0*r3
+	 sltu	$a3,$d2,$a3
+	 addu	$d3,$d3,$a3
+
+
+	mflo	($a3,$r3,$h0)
+	mfhi	($t1,$r3,$h0)
+	 addu	$d2,$d2,$at
+	 sltu	$at,$d2,$at
+	multu	($r2,$h1)		# h1*r2
+	 addu	$d3,$d3,$at
+
+	mflo	($at,$r2,$h1)
+	mfhi	($t0,$r2,$h1)
+	 addu	$d3,$d3,$a3
+	 sltu	$a3,$d3,$a3
+	multu	($r0,$h3)		# h3*r0
+	 addu	$t1,$t1,$a3
+
+	mflo	($a3,$r0,$h3)
+	mfhi	($h3,$r0,$h3)
+	 addu	$d3,$d3,$at
+	 addu	$t1,$t1,$t0
+	multu	($r1,$h2)		# h2*r1
+	 sltu	$at,$d3,$at
+	 addu	$t1,$t1,$at
+
+	mflo	($at,$r1,$h2)
+	mfhi	($t0,$r1,$h2)
+	 addu	$d3,$d3,$a3
+	 addu	$t1,$t1,$h3
+	multu	($rs3,$h4)		# h4*s3
+	 sltu	$a3,$d3,$a3
+	 addu	$t1,$t1,$a3
+
+	mflo	($a3,$rs3,$h4)
+	 addu	$d3,$d3,$at
+	 addu	$t1,$t1,$t0
+	multu	($r0,$h4)		# h4*r0
+	 sltu	$at,$d3,$at
+	 addu	$t1,$t1,$at
+
+
+	mflo	($h4,$r0,$h4)
+	 addu	$h3,$d3,$a3
+	 sltu	$a3,$h3,$a3
+	 addu	$t1,$t1,$a3
+	addu	$h4,$t1,$h4
+
+	li	$padbit,1		# if we loop, padbit is 1
+#endif
+
+	li	$at,-4			# final reduction
+	srl	$h0,$h4,2
+	and	$at,$at,$h4
+	andi	$h4,$h4,3
+	addu	$h0,$h0,$at
+
+	addu	$h0,$h0,$d0
+	sltu	$at,$h0,$d0
+	addu	$h1,$d1,$at
+	sltu	$at,$h1,$at
+	addu	$h2,$d2,$at
+	sltu	$at,$h2,$at
+	addu	$h3,$h3,$at
+	sltu	$at,$h3,$at
+	addu	$h4,$h4,$at
+
+	bnez	$len,.Loop
+
+	sw	$h0,0($ctx)		# store hash value
+	sw	$h1,4($ctx)
+	sw	$h2,8($ctx)
+	sw	$h3,12($ctx)
+	sw	$h4,16($ctx)
+
+	.set	noreorder
+.Labort:
+	lw	$s11,4*11($sp)
+	lw	$s10,4*10($sp)
+	lw	$s9, 4*9($sp)
+	lw	$s8, 4*8($sp)
+	lw	$s7, 4*7($sp)
+	lw	$s6, 4*6($sp)
+	lw	$s5, 4*5($sp)
+	lw	$s4, 4*4($sp)
+___
+$code.=<<___ if ($flavour =~ /nubi/i);	# optimize non-nubi prologue
+	lw	$s3, 4*3($sp)
+	lw	$s2, 4*2($sp)
+	lw	$s1, 4*1($sp)
+	lw	$s0, 4*0($sp)
+___
+$code.=<<___;
+	jr	$ra
+	addu	$sp,$sp,4*12
+.end	poly1305_blocks
+___
+}
+{
+my ($ctx,$mac,$nonce,$tmp4) = ($a0,$a1,$a2,$a3);
+
+$code.=<<___;
+.align	5
+.globl	poly1305_emit
+.ent	poly1305_emit
+poly1305_emit:
+	.frame	$sp,0,$ra
+	.set	reorder
+
+	lw	$tmp0,0($ctx)
+	lw	$tmp1,4($ctx)
+	lw	$tmp2,8($ctx)
+	lw	$tmp3,12($ctx)
+	lw	$tmp4,16($ctx)
+
+	addiu	$in0,$tmp0,5		# compare to modulus
+	sltiu	$ctx,$in0,5
+	addu	$in1,$tmp1,$ctx
+	sltu	$ctx,$in1,$ctx
+	addu	$in2,$tmp2,$ctx
+	sltu	$ctx,$in2,$ctx
+	addu	$in3,$tmp3,$ctx
+	sltu	$ctx,$in3,$ctx
+	addu	$ctx,$tmp4
+
+	srl	$ctx,2			# see if it carried/borrowed
+	subu	$ctx,$zero,$ctx
+
+	xor	$in0,$tmp0
+	xor	$in1,$tmp1
+	xor	$in2,$tmp2
+	xor	$in3,$tmp3
+	and	$in0,$ctx
+	and	$in1,$ctx
+	and	$in2,$ctx
+	and	$in3,$ctx
+	xor	$in0,$tmp0
+	xor	$in1,$tmp1
+	xor	$in2,$tmp2
+	xor	$in3,$tmp3
+
+	lw	$tmp0,0($nonce)		# load nonce
+	lw	$tmp1,4($nonce)
+	lw	$tmp2,8($nonce)
+	lw	$tmp3,12($nonce)
+
+	addu	$in0,$tmp0		# accumulate nonce
+	sltu	$ctx,$in0,$tmp0
+
+	addu	$in1,$tmp1
+	sltu	$tmp1,$in1,$tmp1
+	addu	$in1,$ctx
+	sltu	$ctx,$in1,$ctx
+	addu	$ctx,$tmp1
+
+	addu	$in2,$tmp2
+	sltu	$tmp2,$in2,$tmp2
+	addu	$in2,$ctx
+	sltu	$ctx,$in2,$ctx
+	addu	$ctx,$tmp2
+
+	addu	$in3,$tmp3
+	addu	$in3,$ctx
+
+	srl	$tmp0,$in0,8		# write mac value
+	srl	$tmp1,$in0,16
+	srl	$tmp2,$in0,24
+	sb	$in0, 0($mac)
+	sb	$tmp0,1($mac)
+	srl	$tmp0,$in1,8
+	sb	$tmp1,2($mac)
+	srl	$tmp1,$in1,16
+	sb	$tmp2,3($mac)
+	srl	$tmp2,$in1,24
+	sb	$in1, 4($mac)
+	sb	$tmp0,5($mac)
+	srl	$tmp0,$in2,8
+	sb	$tmp1,6($mac)
+	srl	$tmp1,$in2,16
+	sb	$tmp2,7($mac)
+	srl	$tmp2,$in2,24
+	sb	$in2, 8($mac)
+	sb	$tmp0,9($mac)
+	srl	$tmp0,$in3,8
+	sb	$tmp1,10($mac)
+	srl	$tmp1,$in3,16
+	sb	$tmp2,11($mac)
+	srl	$tmp2,$in3,24
+	sb	$in3, 12($mac)
+	sb	$tmp0,13($mac)
+	sb	$tmp1,14($mac)
+	sb	$tmp2,15($mac)
+
+	jr	$ra
+.end	poly1305_emit
+.rdata
+.asciiz	"Poly1305 for MIPS, CRYPTOGAMS by \@dot-asm"
+.align	2
+___
+}
+}}}
+
+$output=pop and open STDOUT,">$output";
+print $code;
+close STDOUT;
diff --git a/crypto/Kconfig b/crypto/Kconfig
index ddda2bcdf5b7..49ffa9babfc5 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -687,6 +687,7 @@ config CRYPTO_ARCH_HAVE_LIB_POLY1305
 
 config CRYPTO_LIB_POLY1305_RSIZE
 	int
+	default 2 if MIPS
 	default 4 if X86_64
 	default 9 if ARM || ARM64
 	default 1
@@ -722,6 +723,11 @@ config CRYPTO_POLY1305_X86_64
 	  in IETF protocols. This is the x86_64 assembler implementation using SIMD
 	  instructions.
 
+config CRYPTO_POLY1305_MIPS
+	tristate "Poly1305 authenticator algorithm (MIPS optimized)"
+	depends on CPU_MIPS32 || (CPU_MIPS64 && 64BIT)
+	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+
 config CRYPTO_MD4
 	tristate "MD4 digest algorithm"
 	select CRYPTO_HASH
-- 
2.20.1


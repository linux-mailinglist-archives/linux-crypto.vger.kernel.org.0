Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56E6BF4B6A
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Nov 2019 13:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732317AbfKHMXe (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 Nov 2019 07:23:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:38010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727598AbfKHMXe (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 8 Nov 2019 07:23:34 -0500
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr [92.154.90.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D6192245B;
        Fri,  8 Nov 2019 12:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573215813;
        bh=17HGi54uCLgRLlIiMZK4Iaz8vcusNAsIJs2X1Q0i4vw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MbM5FnXNDCln91cc7lSqf5aagOkGk71xMNvnVkv2QKqckWYx5Zp+N+2sTyGz3N2Lz
         GQ29SdQ5SBgrPZFjJQxcH7yJUTy698JSj4lTMy6EZnzgQN0gBrYhSXnWCPPwRzQiUa
         HpyyGCku5RPJSnAX9KPTWLr1ws3ewuyw/K0kmwTc=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Martin Willi <martin@strongswan.org>,
        Rene van Dorst <opensource@vdorst.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v5 11/34] crypto: mips/chacha - wire up accelerated 32r2 code from Zinc
Date:   Fri,  8 Nov 2019 13:22:17 +0100
Message-Id: <20191108122240.28479-12-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108122240.28479-1-ardb@kernel.org>
References: <20191108122240.28479-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This integrates the accelerated MIPS 32r2 implementation of ChaCha
into both the API and library interfaces of the kernel crypto stack.

The significance of this is that, in addition to becoming available
as an accelerated library implementation, it can also be used by
existing crypto API code such as Adiantum (for block encryption on
ultra low performance cores) or IPsec using chacha20poly1305. These
are use cases that have already opted into using the abstract crypto
API. In order to support Adiantum, the core assembler routine has
been adapted to take the round count as a function argument rather
than hardcoding it to 20.

Co-developed-by: René van Dorst <opensource@vdorst.com>
Signed-off-by: René van Dorst <opensource@vdorst.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/mips/Makefile             |   2 +-
 arch/mips/crypto/Makefile      |   4 +
 arch/mips/crypto/chacha-core.S | 159 ++++++++++++++------
 arch/mips/crypto/chacha-glue.c | 150 ++++++++++++++++++
 crypto/Kconfig                 |   6 +
 5 files changed, 277 insertions(+), 44 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index cdc09b71febe..8584c047ea59 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -323,7 +323,7 @@ libs-$(CONFIG_MIPS_FP_SUPPORT) += arch/mips/math-emu/
 # See arch/mips/Kbuild for content of core part of the kernel
 core-y += arch/mips/
 
-drivers-$(CONFIG_MIPS_CRC_SUPPORT) += arch/mips/crypto/
+drivers-y			+= arch/mips/crypto/
 drivers-$(CONFIG_OPROFILE)	+= arch/mips/oprofile/
 
 # suspend and hibernation support
diff --git a/arch/mips/crypto/Makefile b/arch/mips/crypto/Makefile
index e07aca572c2e..b528b9d300f1 100644
--- a/arch/mips/crypto/Makefile
+++ b/arch/mips/crypto/Makefile
@@ -4,3 +4,7 @@
 #
 
 obj-$(CONFIG_CRYPTO_CRC32_MIPS) += crc32-mips.o
+
+obj-$(CONFIG_CRYPTO_CHACHA_MIPS) += chacha-mips.o
+chacha-mips-y := chacha-core.o chacha-glue.o
+AFLAGS_chacha-core.o += -O2 # needed to fill branch delay slots
diff --git a/arch/mips/crypto/chacha-core.S b/arch/mips/crypto/chacha-core.S
index a81e02db95e7..5755f69cfe00 100644
--- a/arch/mips/crypto/chacha-core.S
+++ b/arch/mips/crypto/chacha-core.S
@@ -125,7 +125,7 @@
 #define CONCAT3(a,b,c)	_CONCAT3(a,b,c)
 
 #define STORE_UNALIGNED(x) \
-CONCAT3(.Lchacha20_mips_xor_unaligned_, PLUS_ONE(x), _b: ;) \
+CONCAT3(.Lchacha_mips_xor_unaligned_, PLUS_ONE(x), _b: ;) \
 	.if (x != 12); \
 		lw	T0, (x*4)(STATE); \
 	.endif; \
@@ -142,7 +142,7 @@ CONCAT3(.Lchacha20_mips_xor_unaligned_, PLUS_ONE(x), _b: ;) \
 	swr	X ## x, (x*4)+LSB ## (OUT);
 
 #define STORE_ALIGNED(x) \
-CONCAT3(.Lchacha20_mips_xor_aligned_, PLUS_ONE(x), _b: ;) \
+CONCAT3(.Lchacha_mips_xor_aligned_, PLUS_ONE(x), _b: ;) \
 	.if (x != 12); \
 		lw	T0, (x*4)(STATE); \
 	.endif; \
@@ -162,9 +162,9 @@ CONCAT3(.Lchacha20_mips_xor_aligned_, PLUS_ONE(x), _b: ;) \
  * Every jumptable entry must be equal in size.
  */
 #define JMPTBL_ALIGNED(x) \
-.Lchacha20_mips_jmptbl_aligned_ ## x: ; \
+.Lchacha_mips_jmptbl_aligned_ ## x: ; \
 	.set	noreorder; \
-	b	.Lchacha20_mips_xor_aligned_ ## x ## _b; \
+	b	.Lchacha_mips_xor_aligned_ ## x ## _b; \
 	.if (x == 12); \
 		addu	SAVED_X, X ## x, NONCE_0; \
 	.else; \
@@ -173,9 +173,9 @@ CONCAT3(.Lchacha20_mips_xor_aligned_, PLUS_ONE(x), _b: ;) \
 	.set	reorder
 
 #define JMPTBL_UNALIGNED(x) \
-.Lchacha20_mips_jmptbl_unaligned_ ## x: ; \
+.Lchacha_mips_jmptbl_unaligned_ ## x: ; \
 	.set	noreorder; \
-	b	.Lchacha20_mips_xor_unaligned_ ## x ## _b; \
+	b	.Lchacha_mips_xor_unaligned_ ## x ## _b; \
 	.if (x == 12); \
 		addu	SAVED_X, X ## x, NONCE_0; \
 	.else; \
@@ -200,15 +200,18 @@ CONCAT3(.Lchacha20_mips_xor_aligned_, PLUS_ONE(x), _b: ;) \
 .text
 .set	reorder
 .set	noat
-.globl	chacha20_mips
-.ent	chacha20_mips
-chacha20_mips:
+.globl	chacha_crypt_arch
+.ent	chacha_crypt_arch
+chacha_crypt_arch:
 	.frame	$sp, STACK_SIZE, $ra
 
+	/* Load number of rounds */
+	lw	$at, 16($sp)
+
 	addiu	$sp, -STACK_SIZE
 
 	/* Return bytes = 0. */
-	beqz	BYTES, .Lchacha20_mips_end
+	beqz	BYTES, .Lchacha_mips_end
 
 	lw	NONCE_0, 48(STATE)
 
@@ -228,18 +231,15 @@ chacha20_mips:
 	or	IS_UNALIGNED, IN, OUT
 	andi	IS_UNALIGNED, 0x3
 
-	/* Set number of rounds */
-	li	$at, 20
-
-	b	.Lchacha20_rounds_start
+	b	.Lchacha_rounds_start
 
 .align 4
-.Loop_chacha20_rounds:
+.Loop_chacha_rounds:
 	addiu	IN,  CHACHA20_BLOCK_SIZE
 	addiu	OUT, CHACHA20_BLOCK_SIZE
 	addiu	NONCE_0, 1
 
-.Lchacha20_rounds_start:
+.Lchacha_rounds_start:
 	lw	X0,  0(STATE)
 	lw	X1,  4(STATE)
 	lw	X2,  8(STATE)
@@ -259,7 +259,7 @@ chacha20_mips:
 	lw	X14, 56(STATE)
 	lw	X15, 60(STATE)
 
-.Loop_chacha20_xor_rounds:
+.Loop_chacha_xor_rounds:
 	addiu	$at, -2
 	AXR( 0, 1, 2, 3,  4, 5, 6, 7, 12,13,14,15, 16);
 	AXR( 8, 9,10,11, 12,13,14,15,  4, 5, 6, 7, 12);
@@ -269,31 +269,31 @@ chacha20_mips:
 	AXR(10,11, 8, 9, 15,12,13,14,  5, 6, 7, 4, 12);
 	AXR( 0, 1, 2, 3,  5, 6, 7, 4, 15,12,13,14,  8);
 	AXR(10,11, 8, 9, 15,12,13,14,  5, 6, 7, 4,  7);
-	bnez	$at, .Loop_chacha20_xor_rounds
+	bnez	$at, .Loop_chacha_xor_rounds
 
 	addiu	BYTES, -(CHACHA20_BLOCK_SIZE)
 
 	/* Is data src/dst unaligned? Jump */
-	bnez	IS_UNALIGNED, .Loop_chacha20_unaligned
+	bnez	IS_UNALIGNED, .Loop_chacha_unaligned
 
 	/* Set number rounds here to fill delayslot. */
-	li	$at, 20
+	lw	$at, (STACK_SIZE+16)($sp)
 
 	/* BYTES < 0, it has no full block. */
-	bltz	BYTES, .Lchacha20_mips_no_full_block_aligned
+	bltz	BYTES, .Lchacha_mips_no_full_block_aligned
 
 	FOR_EACH_WORD_REV(STORE_ALIGNED)
 
 	/* BYTES > 0? Loop again. */
-	bgtz	BYTES, .Loop_chacha20_rounds
+	bgtz	BYTES, .Loop_chacha_rounds
 
 	/* Place this here to fill delay slot */
 	addiu	NONCE_0, 1
 
 	/* BYTES < 0? Handle last bytes */
-	bltz	BYTES, .Lchacha20_mips_xor_bytes
+	bltz	BYTES, .Lchacha_mips_xor_bytes
 
-.Lchacha20_mips_xor_done:
+.Lchacha_mips_xor_done:
 	/* Restore used registers */
 	lw	$s0,  0($sp)
 	lw	$s1,  4($sp)
@@ -307,11 +307,11 @@ chacha20_mips:
 	/* Write NONCE_0 back to right location in state */
 	sw	NONCE_0, 48(STATE)
 
-.Lchacha20_mips_end:
+.Lchacha_mips_end:
 	addiu	$sp, STACK_SIZE
 	jr	$ra
 
-.Lchacha20_mips_no_full_block_aligned:
+.Lchacha_mips_no_full_block_aligned:
 	/* Restore the offset on BYTES */
 	addiu	BYTES, CHACHA20_BLOCK_SIZE
 
@@ -319,7 +319,7 @@ chacha20_mips:
 	andi	$at, BYTES, MASK_U32
 
 	/* Load upper half of jump table addr */
-	lui	T0, %hi(.Lchacha20_mips_jmptbl_aligned_0)
+	lui	T0, %hi(.Lchacha_mips_jmptbl_aligned_0)
 
 	/* Calculate lower half jump table offset */
 	ins	T0, $at, 1, 6
@@ -328,7 +328,7 @@ chacha20_mips:
 	addu	T1, STATE, $at
 
 	/* Add lower half jump table addr */
-	addiu	T0, %lo(.Lchacha20_mips_jmptbl_aligned_0)
+	addiu	T0, %lo(.Lchacha_mips_jmptbl_aligned_0)
 
 	/* Read value from STATE */
 	lw	SAVED_CA, 0(T1)
@@ -342,31 +342,31 @@ chacha20_mips:
 	FOR_EACH_WORD(JMPTBL_ALIGNED)
 
 
-.Loop_chacha20_unaligned:
+.Loop_chacha_unaligned:
 	/* Set number rounds here to fill delayslot. */
-	li	$at, 20
+	lw	$at, (STACK_SIZE+16)($sp)
 
 	/* BYTES > 0, it has no full block. */
-	bltz	BYTES, .Lchacha20_mips_no_full_block_unaligned
+	bltz	BYTES, .Lchacha_mips_no_full_block_unaligned
 
 	FOR_EACH_WORD_REV(STORE_UNALIGNED)
 
 	/* BYTES > 0? Loop again. */
-	bgtz	BYTES, .Loop_chacha20_rounds
+	bgtz	BYTES, .Loop_chacha_rounds
 
 	/* Write NONCE_0 back to right location in state */
 	sw	NONCE_0, 48(STATE)
 
 	.set noreorder
 	/* Fall through to byte handling */
-	bgez	BYTES, .Lchacha20_mips_xor_done
-.Lchacha20_mips_xor_unaligned_0_b:
-.Lchacha20_mips_xor_aligned_0_b:
+	bgez	BYTES, .Lchacha_mips_xor_done
+.Lchacha_mips_xor_unaligned_0_b:
+.Lchacha_mips_xor_aligned_0_b:
 	/* Place this here to fill delay slot */
 	addiu	NONCE_0, 1
 	.set reorder
 
-.Lchacha20_mips_xor_bytes:
+.Lchacha_mips_xor_bytes:
 	addu	IN, $at
 	addu	OUT, $at
 	/* First byte */
@@ -376,22 +376,22 @@ chacha20_mips:
 	ROTR(SAVED_X)
 	xor	T1, SAVED_X
 	sb	T1, 0(OUT)
-	beqz	$at, .Lchacha20_mips_xor_done
+	beqz	$at, .Lchacha_mips_xor_done
 	/* Second byte */
 	lbu	T1, 1(IN)
 	addiu	$at, BYTES, 2
 	ROTx	SAVED_X, 8
 	xor	T1, SAVED_X
 	sb	T1, 1(OUT)
-	beqz	$at, .Lchacha20_mips_xor_done
+	beqz	$at, .Lchacha_mips_xor_done
 	/* Third byte */
 	lbu	T1, 2(IN)
 	ROTx	SAVED_X, 8
 	xor	T1, SAVED_X
 	sb	T1, 2(OUT)
-	b	.Lchacha20_mips_xor_done
+	b	.Lchacha_mips_xor_done
 
-.Lchacha20_mips_no_full_block_unaligned:
+.Lchacha_mips_no_full_block_unaligned:
 	/* Restore the offset on BYTES */
 	addiu	BYTES, CHACHA20_BLOCK_SIZE
 
@@ -399,7 +399,7 @@ chacha20_mips:
 	andi	$at, BYTES, MASK_U32
 
 	/* Load upper half of jump table addr */
-	lui	T0, %hi(.Lchacha20_mips_jmptbl_unaligned_0)
+	lui	T0, %hi(.Lchacha_mips_jmptbl_unaligned_0)
 
 	/* Calculate lower half jump table offset */
 	ins	T0, $at, 1, 6
@@ -408,7 +408,7 @@ chacha20_mips:
 	addu	T1, STATE, $at
 
 	/* Add lower half jump table addr */
-	addiu	T0, %lo(.Lchacha20_mips_jmptbl_unaligned_0)
+	addiu	T0, %lo(.Lchacha_mips_jmptbl_unaligned_0)
 
 	/* Read value from STATE */
 	lw	SAVED_CA, 0(T1)
@@ -420,5 +420,78 @@ chacha20_mips:
 
 	/* Jump table */
 	FOR_EACH_WORD(JMPTBL_UNALIGNED)
-.end chacha20_mips
+.end chacha_crypt_arch
+.set at
+
+/* Input arguments
+ * STATE	$a0
+ * OUT		$a1
+ * NROUND	$a2
+ */
+
+#undef X12
+#undef X13
+#undef X14
+#undef X15
+
+#define X12	$a3
+#define X13	$at
+#define X14	$v0
+#define X15	STATE
+
+.set noat
+.globl	hchacha_block_arch
+.ent	hchacha_block_arch
+hchacha_block_arch:
+	.frame	$sp, STACK_SIZE, $ra
+
+	addiu	$sp, -STACK_SIZE
+
+	/* Save X11(s6) */
+	sw	X11, 0($sp)
+
+	lw	X0,  0(STATE)
+	lw	X1,  4(STATE)
+	lw	X2,  8(STATE)
+	lw	X3,  12(STATE)
+	lw	X4,  16(STATE)
+	lw	X5,  20(STATE)
+	lw	X6,  24(STATE)
+	lw	X7,  28(STATE)
+	lw	X8,  32(STATE)
+	lw	X9,  36(STATE)
+	lw	X10, 40(STATE)
+	lw	X11, 44(STATE)
+	lw	X12, 48(STATE)
+	lw	X13, 52(STATE)
+	lw	X14, 56(STATE)
+	lw	X15, 60(STATE)
+
+.Loop_hchacha_xor_rounds:
+	addiu	$a2, -2
+	AXR( 0, 1, 2, 3,  4, 5, 6, 7, 12,13,14,15, 16);
+	AXR( 8, 9,10,11, 12,13,14,15,  4, 5, 6, 7, 12);
+	AXR( 0, 1, 2, 3,  4, 5, 6, 7, 12,13,14,15,  8);
+	AXR( 8, 9,10,11, 12,13,14,15,  4, 5, 6, 7,  7);
+	AXR( 0, 1, 2, 3,  5, 6, 7, 4, 15,12,13,14, 16);
+	AXR(10,11, 8, 9, 15,12,13,14,  5, 6, 7, 4, 12);
+	AXR( 0, 1, 2, 3,  5, 6, 7, 4, 15,12,13,14,  8);
+	AXR(10,11, 8, 9, 15,12,13,14,  5, 6, 7, 4,  7);
+	bnez	$a2, .Loop_hchacha_xor_rounds
+
+	/* Restore used register */
+	lw	X11, 0($sp)
+
+	sw	X0,  0(OUT)
+	sw	X1,  4(OUT)
+	sw	X2,  8(OUT)
+	sw	X3,  12(OUT)
+	sw	X12, 16(OUT)
+	sw	X13, 20(OUT)
+	sw	X14, 24(OUT)
+	sw	X15, 28(OUT)
+
+	addiu	$sp, STACK_SIZE
+	jr	$ra
+.end hchacha_block_arch
 .set at
diff --git a/arch/mips/crypto/chacha-glue.c b/arch/mips/crypto/chacha-glue.c
new file mode 100644
index 000000000000..779e399c9bef
--- /dev/null
+++ b/arch/mips/crypto/chacha-glue.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MIPS accelerated ChaCha and XChaCha stream ciphers,
+ * including ChaCha20 (RFC7539)
+ *
+ * Copyright (C) 2019 Linaro, Ltd. <ard.biesheuvel@linaro.org>
+ */
+
+#include <asm/byteorder.h>
+#include <crypto/algapi.h>
+#include <crypto/internal/chacha.h>
+#include <crypto/internal/skcipher.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+asmlinkage void chacha_crypt_arch(u32 *state, u8 *dst, const u8 *src,
+				  unsigned int bytes, int nrounds);
+EXPORT_SYMBOL(chacha_crypt_arch);
+
+asmlinkage void hchacha_block_arch(const u32 *state, u32 *stream, int nrounds);
+EXPORT_SYMBOL(hchacha_block_arch);
+
+void chacha_init_arch(u32 *state, const u32 *key, const u8 *iv)
+{
+	chacha_init_generic(state, key, iv);
+}
+EXPORT_SYMBOL(chacha_init_arch);
+
+static int chacha_mips_stream_xor(struct skcipher_request *req,
+				  const struct chacha_ctx *ctx, const u8 *iv)
+{
+	struct skcipher_walk walk;
+	u32 state[16];
+	int err;
+
+	err = skcipher_walk_virt(&walk, req, false);
+
+	chacha_init_generic(state, ctx->key, iv);
+
+	while (walk.nbytes > 0) {
+		unsigned int nbytes = walk.nbytes;
+
+		if (nbytes < walk.total)
+			nbytes = round_down(nbytes, walk.stride);
+
+		chacha_crypt(state, walk.dst.virt.addr, walk.src.virt.addr,
+			     nbytes, ctx->nrounds);
+		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
+	}
+
+	return err;
+}
+
+static int chacha_mips(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct chacha_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	return chacha_mips_stream_xor(req, ctx, req->iv);
+}
+
+static int xchacha_mips(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct chacha_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct chacha_ctx subctx;
+	u32 state[16];
+	u8 real_iv[16];
+
+	chacha_init_generic(state, ctx->key, req->iv);
+
+	hchacha_block(state, subctx.key, ctx->nrounds);
+	subctx.nrounds = ctx->nrounds;
+
+	memcpy(&real_iv[0], req->iv + 24, 8);
+	memcpy(&real_iv[8], req->iv + 16, 8);
+	return chacha_mips_stream_xor(req, &subctx, real_iv);
+}
+
+static struct skcipher_alg algs[] = {
+	{
+		.base.cra_name		= "chacha20",
+		.base.cra_driver_name	= "chacha20-mips",
+		.base.cra_priority	= 200,
+		.base.cra_blocksize	= 1,
+		.base.cra_ctxsize	= sizeof(struct chacha_ctx),
+		.base.cra_module	= THIS_MODULE,
+
+		.min_keysize		= CHACHA_KEY_SIZE,
+		.max_keysize		= CHACHA_KEY_SIZE,
+		.ivsize			= CHACHA_IV_SIZE,
+		.chunksize		= CHACHA_BLOCK_SIZE,
+		.setkey			= chacha20_setkey,
+		.encrypt		= chacha_mips,
+		.decrypt		= chacha_mips,
+	}, {
+		.base.cra_name		= "xchacha20",
+		.base.cra_driver_name	= "xchacha20-mips",
+		.base.cra_priority	= 200,
+		.base.cra_blocksize	= 1,
+		.base.cra_ctxsize	= sizeof(struct chacha_ctx),
+		.base.cra_module	= THIS_MODULE,
+
+		.min_keysize		= CHACHA_KEY_SIZE,
+		.max_keysize		= CHACHA_KEY_SIZE,
+		.ivsize			= XCHACHA_IV_SIZE,
+		.chunksize		= CHACHA_BLOCK_SIZE,
+		.setkey			= chacha20_setkey,
+		.encrypt		= xchacha_mips,
+		.decrypt		= xchacha_mips,
+	}, {
+		.base.cra_name		= "xchacha12",
+		.base.cra_driver_name	= "xchacha12-mips",
+		.base.cra_priority	= 200,
+		.base.cra_blocksize	= 1,
+		.base.cra_ctxsize	= sizeof(struct chacha_ctx),
+		.base.cra_module	= THIS_MODULE,
+
+		.min_keysize		= CHACHA_KEY_SIZE,
+		.max_keysize		= CHACHA_KEY_SIZE,
+		.ivsize			= XCHACHA_IV_SIZE,
+		.chunksize		= CHACHA_BLOCK_SIZE,
+		.setkey			= chacha12_setkey,
+		.encrypt		= xchacha_mips,
+		.decrypt		= xchacha_mips,
+	}
+};
+
+static int __init chacha_simd_mod_init(void)
+{
+	return crypto_register_skciphers(algs, ARRAY_SIZE(algs));
+}
+
+static void __exit chacha_simd_mod_fini(void)
+{
+	crypto_unregister_skciphers(algs, ARRAY_SIZE(algs));
+}
+
+module_init(chacha_simd_mod_init);
+module_exit(chacha_simd_mod_fini);
+
+MODULE_DESCRIPTION("ChaCha and XChaCha stream ciphers (MIPS accelerated)");
+MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS_CRYPTO("chacha20");
+MODULE_ALIAS_CRYPTO("chacha20-mips");
+MODULE_ALIAS_CRYPTO("xchacha20");
+MODULE_ALIAS_CRYPTO("xchacha20-mips");
+MODULE_ALIAS_CRYPTO("xchacha12");
+MODULE_ALIAS_CRYPTO("xchacha12-mips");
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 07762de1237f..34c4938febeb 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1442,6 +1442,12 @@ config CRYPTO_CHACHA20_X86_64
 	  SSSE3, AVX2, and AVX-512VL optimized implementations of the ChaCha20,
 	  XChaCha20, and XChaCha12 stream ciphers.
 
+config CRYPTO_CHACHA_MIPS
+	tristate "ChaCha stream cipher algorithms (MIPS 32r2 optimized)"
+	depends on CPU_MIPS32_R2
+	select CRYPTO_BLKCIPHER
+	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+
 config CRYPTO_SEED
 	tristate "SEED cipher algorithm"
 	select CRYPTO_ALGAPI
-- 
2.20.1


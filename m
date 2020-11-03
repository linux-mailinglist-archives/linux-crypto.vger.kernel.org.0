Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958432A4B67
	for <lists+linux-crypto@lfdr.de>; Tue,  3 Nov 2020 17:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgKCQ2R (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 3 Nov 2020 11:28:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:52774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbgKCQ2R (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 3 Nov 2020 11:28:17 -0500
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94519206DF;
        Tue,  3 Nov 2020 16:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604420896;
        bh=FDr82e5XLXaA/5p2QOhTZxnB/3VWOgegCifjHuJvs80=;
        h=From:To:Cc:Subject:Date:From;
        b=RQIYEuIhEqKl/J8b4wJMvJwXtS+WHLEYHlxX6gU5OQXZ9zKY/XJmtLzgKeff9/eto
         1CclWFUAF06G5huOSazlbbfMO+BJdOIuP2K11kGSOdHfK1Y7Oq1reMASUUP4nPApCu
         nCJhgT1tI58N5GujAeAMvXtAr1OHMSw0kc8e71gI=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, andre.przywara@arm.com,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2] crypto: arm/chacha-neon - optimize for non-block size multiples
Date:   Tue,  3 Nov 2020 17:28:09 +0100
Message-Id: <20201103162809.28167-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The current NEON based ChaCha implementation for ARM is optimized for
multiples of 4x the ChaCha block size (64 bytes). This makes sense for
block encryption, but given that ChaCha is also often used in the
context of networking, it makes sense to consider arbitrary length
inputs as well.

For example, WireGuard typically uses 1420 byte packets, and performing
ChaCha encryption involves 5 invocations of chacha_4block_xor_neon()
and 3 invocations of chacha_block_xor_neon(), where the last one also
involves a memcpy() using a buffer on the stack to process the final
chunk of 1420 % 64 == 12 bytes.

Let's optimize for this case as well, by letting chacha_4block_xor_neon()
deal with any input size between 64 and 256 bytes, using NEON permutation
instructions and overlapping loads and stores. This way, the 140 byte
tail of a 1420 byte input buffer can simply be processed in one go.

This results in the following performance improvements for 1420 byte
blocks, without significant impact on power-of-2 input sizes. (Note
that Raspberry Pi is widely used in combination with a 32-bit kernel,
even though the core is 64-bit capable)

   Cortex-A8  (BeagleBone)       :   7%
   Cortex-A15 (Calxeda Midway)   :  21%
   Cortex-A53 (Raspberry Pi 3)   :   3%
   Cortex-A72 (Raspberry Pi 4)   :  19%

Cc: Eric Biggers <ebiggers@google.com>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
v2:
- avoid memcpy() if the residual byte count is exactly 64 bytes
- get rid of register based post increments, and simply rewind the src
  pointer as needed (the dst pointer did not need the register post
  increment in the first place)
- add benchmark results for 32-bit CPUs to commit log.

 arch/arm/crypto/chacha-glue.c      | 34 +++----
 arch/arm/crypto/chacha-neon-core.S | 97 ++++++++++++++++++--
 2 files changed, 107 insertions(+), 24 deletions(-)

diff --git a/arch/arm/crypto/chacha-glue.c b/arch/arm/crypto/chacha-glue.c
index 59da6c0b63b6..7b5cf8430c6d 100644
--- a/arch/arm/crypto/chacha-glue.c
+++ b/arch/arm/crypto/chacha-glue.c
@@ -23,7 +23,7 @@
 asmlinkage void chacha_block_xor_neon(const u32 *state, u8 *dst, const u8 *src,
 				      int nrounds);
 asmlinkage void chacha_4block_xor_neon(const u32 *state, u8 *dst, const u8 *src,
-				       int nrounds);
+				       int nrounds, unsigned int nbytes);
 asmlinkage void hchacha_block_arm(const u32 *state, u32 *out, int nrounds);
 asmlinkage void hchacha_block_neon(const u32 *state, u32 *out, int nrounds);
 
@@ -42,24 +42,24 @@ static void chacha_doneon(u32 *state, u8 *dst, const u8 *src,
 {
 	u8 buf[CHACHA_BLOCK_SIZE];
 
-	while (bytes >= CHACHA_BLOCK_SIZE * 4) {
-		chacha_4block_xor_neon(state, dst, src, nrounds);
-		bytes -= CHACHA_BLOCK_SIZE * 4;
-		src += CHACHA_BLOCK_SIZE * 4;
-		dst += CHACHA_BLOCK_SIZE * 4;
-		state[12] += 4;
-	}
-	while (bytes >= CHACHA_BLOCK_SIZE) {
-		chacha_block_xor_neon(state, dst, src, nrounds);
-		bytes -= CHACHA_BLOCK_SIZE;
-		src += CHACHA_BLOCK_SIZE;
-		dst += CHACHA_BLOCK_SIZE;
-		state[12]++;
+	while (bytes > CHACHA_BLOCK_SIZE) {
+		unsigned int l = min(bytes, CHACHA_BLOCK_SIZE * 4U);
+
+		chacha_4block_xor_neon(state, dst, src, nrounds, l);
+		bytes -= l;
+		src += l;
+		dst += l;
+		state[12] += DIV_ROUND_UP(l, CHACHA_BLOCK_SIZE);
 	}
 	if (bytes) {
-		memcpy(buf, src, bytes);
-		chacha_block_xor_neon(state, buf, buf, nrounds);
-		memcpy(dst, buf, bytes);
+		const u8 *s = src;
+		u8 *d = dst;
+
+		if (bytes != CHACHA_BLOCK_SIZE)
+			s = d = memcpy(buf, src, bytes);
+		chacha_block_xor_neon(state, d, s, nrounds);
+		if (d != dst)
+			memcpy(dst, buf, bytes);
 	}
 }
 
diff --git a/arch/arm/crypto/chacha-neon-core.S b/arch/arm/crypto/chacha-neon-core.S
index eb22926d4912..13d12f672656 100644
--- a/arch/arm/crypto/chacha-neon-core.S
+++ b/arch/arm/crypto/chacha-neon-core.S
@@ -47,6 +47,7 @@
   */
 
 #include <linux/linkage.h>
+#include <asm/cache.h>
 
 	.text
 	.fpu		neon
@@ -205,7 +206,7 @@ ENDPROC(hchacha_block_neon)
 
 	.align		5
 ENTRY(chacha_4block_xor_neon)
-	push		{r4-r5}
+	push		{r4, lr}
 	mov		r4, sp			// preserve the stack pointer
 	sub		ip, sp, #0x20		// allocate a 32 byte buffer
 	bic		ip, ip, #0x1f		// aligned to 32 bytes
@@ -229,10 +230,10 @@ ENTRY(chacha_4block_xor_neon)
 	vld1.32		{q0-q1}, [r0]
 	vld1.32		{q2-q3}, [ip]
 
-	adr		r5, .Lctrinc
+	adr		lr, .Lctrinc
 	vdup.32		q15, d7[1]
 	vdup.32		q14, d7[0]
-	vld1.32		{q4}, [r5, :128]
+	vld1.32		{q4}, [lr, :128]
 	vdup.32		q13, d6[1]
 	vdup.32		q12, d6[0]
 	vdup.32		q11, d5[1]
@@ -455,7 +456,7 @@ ENTRY(chacha_4block_xor_neon)
 
 	// Re-interleave the words in the first two rows of each block (x0..7).
 	// Also add the counter values 0-3 to x12[0-3].
-	  vld1.32	{q8}, [r5, :128]	// load counter values 0-3
+	  vld1.32	{q8}, [lr, :128]	// load counter values 0-3
 	vzip.32		q0, q1			// => (0 1 0 1) (0 1 0 1)
 	vzip.32		q2, q3			// => (2 3 2 3) (2 3 2 3)
 	vzip.32		q4, q5			// => (4 5 4 5) (4 5 4 5)
@@ -493,6 +494,8 @@ ENTRY(chacha_4block_xor_neon)
 
 	// Re-interleave the words in the last two rows of each block (x8..15).
 	vld1.32		{q8-q9}, [sp, :256]
+	  mov		sp, r4		// restore original stack pointer
+	  ldr		r4, [r4, #8]	// load number of bytes
 	vzip.32		q12, q13	// => (12 13 12 13) (12 13 12 13)
 	vzip.32		q14, q15	// => (14 15 14 15) (14 15 14 15)
 	vzip.32		q8, q9		// => (8 9 8 9) (8 9 8 9)
@@ -520,41 +523,121 @@ ENTRY(chacha_4block_xor_neon)
 	// XOR the rest of the data with the keystream
 
 	vld1.8		{q0-q1}, [r2]!
+	subs		r4, r4, #96
 	veor		q0, q0, q8
 	veor		q1, q1, q12
+	ble		.Lle96
 	vst1.8		{q0-q1}, [r1]!
 
 	vld1.8		{q0-q1}, [r2]!
+	subs		r4, r4, #32
 	veor		q0, q0, q2
 	veor		q1, q1, q6
+	ble		.Lle128
 	vst1.8		{q0-q1}, [r1]!
 
 	vld1.8		{q0-q1}, [r2]!
+	subs		r4, r4, #32
 	veor		q0, q0, q10
 	veor		q1, q1, q14
+	ble		.Lle160
 	vst1.8		{q0-q1}, [r1]!
 
 	vld1.8		{q0-q1}, [r2]!
+	subs		r4, r4, #32
 	veor		q0, q0, q4
 	veor		q1, q1, q5
+	ble		.Lle192
 	vst1.8		{q0-q1}, [r1]!
 
 	vld1.8		{q0-q1}, [r2]!
+	subs		r4, r4, #32
 	veor		q0, q0, q9
 	veor		q1, q1, q13
+	ble		.Lle224
 	vst1.8		{q0-q1}, [r1]!
 
 	vld1.8		{q0-q1}, [r2]!
+	subs		r4, r4, #32
 	veor		q0, q0, q3
 	veor		q1, q1, q7
+	blt		.Llt256
+.Lout:
 	vst1.8		{q0-q1}, [r1]!
 
 	vld1.8		{q0-q1}, [r2]
-	  mov		sp, r4		// restore original stack pointer
 	veor		q0, q0, q11
 	veor		q1, q1, q15
 	vst1.8		{q0-q1}, [r1]
 
-	pop		{r4-r5}
-	bx		lr
+	pop		{r4, pc}
+
+.Lle192:
+	vmov		q4, q9
+	vmov		q5, q13
+
+.Lle160:
+	// nothing to do
+
+.Lfinalblock:
+	// Process the final block if processing less than 4 full blocks.
+	// Entered with 32 bytes of ChaCha cipher stream in q4-q5, and the
+	// previous 32 byte output block that still needs to be written at
+	// [r1] in q0-q1.
+	beq		.Lfullblock
+
+.Lpartialblock:
+	adr		lr, .Lpermute + 32
+	add		r2, r2, r4
+	add		lr, lr, r4
+	add		r4, r4, r1
+
+	vld1.8		{q2-q3}, [lr]
+	vld1.8		{q6-q7}, [r2]
+
+	add		r4, r4, #32
+
+	vtbl.8		d4, {q4-q5}, d4
+	vtbl.8		d5, {q4-q5}, d5
+	vtbl.8		d6, {q4-q5}, d6
+	vtbl.8		d7, {q4-q5}, d7
+
+	veor		q6, q6, q2
+	veor		q7, q7, q3
+
+	vst1.8		{q6-q7}, [r4]	// overlapping stores
+	vst1.8		{q0-q1}, [r1]
+	pop		{r4, pc}
+
+.Lfullblock:
+	vmov		q11, q4
+	vmov		q15, q5
+	b		.Lout
+.Lle96:
+	vmov		q4, q2
+	vmov		q5, q6
+	b		.Lfinalblock
+.Lle128:
+	vmov		q4, q10
+	vmov		q5, q14
+	b		.Lfinalblock
+.Lle224:
+	vmov		q4, q3
+	vmov		q5, q7
+	b		.Lfinalblock
+.Llt256:
+	vmov		q4, q11
+	vmov		q5, q15
+	b		.Lpartialblock
 ENDPROC(chacha_4block_xor_neon)
+
+	.align		L1_CACHE_SHIFT
+.Lpermute:
+	.byte		0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07
+	.byte		0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f
+	.byte		0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17
+	.byte		0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f
+	.byte		0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07
+	.byte		0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f
+	.byte		0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17
+	.byte		0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f
-- 
2.17.1


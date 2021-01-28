Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55373076C2
	for <lists+linux-crypto@lfdr.de>; Thu, 28 Jan 2021 14:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhA1NII (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 28 Jan 2021 08:08:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:33750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231284AbhA1NID (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 28 Jan 2021 08:08:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B0D064DE0;
        Thu, 28 Jan 2021 13:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611839218;
        bh=3Ny3jggBnaZQkwhi1V74h6OPD201uTArNfDM6yhFTkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eyZHso4Y7jQr73DSRtgfK+AMcMNd8gkwMYxNSI5ZlTAmgaqqP66lVV44GSmpJzN2i
         RXrI7sQeQ7UUen7RVrWAwMoqtM+vmzblTMOpJ5uMIzFboBYCndmsDibU98E05bUaw3
         K6kuccIQlquppwQzBSnI3roe6tp/YGBGVNfoh1Zpg5hf02+04ubU7JbSbKHGjucGS8
         vEOT3e322K9ZohEDumJdoMUaejgvEXpe+RvazT+vwO6g5ZEBv+VvU6J2nHQhxUOs/m
         yVEbtCSVVg962fYjQ5tgECkoBKgzcFTECGowzBaKAqhxgBG/kRyJgN+DQjsRoDPSNi
         BFQlDREOqOITw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Dave Martin <dave.martin@arm.com>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 7/9] crypto: arm64/aes-ce-mac - simplify NEON yield
Date:   Thu, 28 Jan 2021 14:06:23 +0100
Message-Id: <20210128130625.54076-8-ardb@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128130625.54076-1-ardb@kernel.org>
References: <20210128130625.54076-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/crypto/aes-glue.c  | 21 +++++---
 arch/arm64/crypto/aes-modes.S | 52 +++++++-------------
 2 files changed, 33 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/crypto/aes-glue.c b/arch/arm64/crypto/aes-glue.c
index e7f116d833b9..17e735931a0c 100644
--- a/arch/arm64/crypto/aes-glue.c
+++ b/arch/arm64/crypto/aes-glue.c
@@ -105,9 +105,9 @@ asmlinkage void aes_essiv_cbc_decrypt(u8 out[], u8 const in[], u32 const rk1[],
 				      int rounds, int blocks, u8 iv[],
 				      u32 const rk2[]);
 
-asmlinkage void aes_mac_update(u8 const in[], u32 const rk[], int rounds,
-			       int blocks, u8 dg[], int enc_before,
-			       int enc_after);
+asmlinkage int aes_mac_update(u8 const in[], u32 const rk[], int rounds,
+			      int blocks, u8 dg[], int enc_before,
+			      int enc_after);
 
 struct crypto_aes_xts_ctx {
 	struct crypto_aes_ctx key1;
@@ -856,10 +856,17 @@ static void mac_do_update(struct crypto_aes_ctx *ctx, u8 const in[], int blocks,
 	int rounds = 6 + ctx->key_length / 4;
 
 	if (crypto_simd_usable()) {
-		kernel_neon_begin();
-		aes_mac_update(in, ctx->key_enc, rounds, blocks, dg, enc_before,
-			       enc_after);
-		kernel_neon_end();
+		int rem;
+
+		do {
+			kernel_neon_begin();
+			rem = aes_mac_update(in, ctx->key_enc, rounds, blocks,
+					     dg, enc_before, enc_after);
+			kernel_neon_end();
+			in += (blocks - rem) * AES_BLOCK_SIZE;
+			blocks = rem;
+			enc_before = 0;
+		} while (blocks);
 	} else {
 		if (enc_before)
 			aes_encrypt(ctx, dg, dg);
diff --git a/arch/arm64/crypto/aes-modes.S b/arch/arm64/crypto/aes-modes.S
index 3d1f97799899..bbdb54702aa7 100644
--- a/arch/arm64/crypto/aes-modes.S
+++ b/arch/arm64/crypto/aes-modes.S
@@ -678,61 +678,47 @@ AES_FUNC_END(aes_xts_decrypt)
 	 *		  int blocks, u8 dg[], int enc_before, int enc_after)
 	 */
 AES_FUNC_START(aes_mac_update)
-	frame_push	6
-
-	mov		x19, x0
-	mov		x20, x1
-	mov		x21, x2
-	mov		x22, x3
-	mov		x23, x4
-	mov		x24, x6
-
-	ld1		{v0.16b}, [x23]			/* get dg */
+	ld1		{v0.16b}, [x4]			/* get dg */
 	enc_prepare	w2, x1, x7
 	cbz		w5, .Lmacloop4x
 
 	encrypt_block	v0, w2, x1, x7, w8
 
 .Lmacloop4x:
-	subs		w22, w22, #4
+	subs		w3, w3, #4
 	bmi		.Lmac1x
-	ld1		{v1.16b-v4.16b}, [x19], #64	/* get next pt block */
+	ld1		{v1.16b-v4.16b}, [x0], #64	/* get next pt block */
 	eor		v0.16b, v0.16b, v1.16b		/* ..and xor with dg */
-	encrypt_block	v0, w21, x20, x7, w8
+	encrypt_block	v0, w2, x1, x7, w8
 	eor		v0.16b, v0.16b, v2.16b
-	encrypt_block	v0, w21, x20, x7, w8
+	encrypt_block	v0, w2, x1, x7, w8
 	eor		v0.16b, v0.16b, v3.16b
-	encrypt_block	v0, w21, x20, x7, w8
+	encrypt_block	v0, w2, x1, x7, w8
 	eor		v0.16b, v0.16b, v4.16b
-	cmp		w22, wzr
-	csinv		x5, x24, xzr, eq
+	cmp		w3, wzr
+	csinv		x5, x6, xzr, eq
 	cbz		w5, .Lmacout
-	encrypt_block	v0, w21, x20, x7, w8
-	st1		{v0.16b}, [x23]			/* return dg */
-	cond_yield_neon	.Lmacrestart
+	encrypt_block	v0, w2, x1, x7, w8
+	st1		{v0.16b}, [x4]			/* return dg */
+	cond_yield	.Lmacout, x7
 	b		.Lmacloop4x
 .Lmac1x:
-	add		w22, w22, #4
+	add		w3, w3, #4
 .Lmacloop:
-	cbz		w22, .Lmacout
-	ld1		{v1.16b}, [x19], #16		/* get next pt block */
+	cbz		w3, .Lmacout
+	ld1		{v1.16b}, [x0], #16		/* get next pt block */
 	eor		v0.16b, v0.16b, v1.16b		/* ..and xor with dg */
 
-	subs		w22, w22, #1
-	csinv		x5, x24, xzr, eq
+	subs		w3, w3, #1
+	csinv		x5, x6, xzr, eq
 	cbz		w5, .Lmacout
 
 .Lmacenc:
-	encrypt_block	v0, w21, x20, x7, w8
+	encrypt_block	v0, w2, x1, x7, w8
 	b		.Lmacloop
 
 .Lmacout:
-	st1		{v0.16b}, [x23]			/* return dg */
-	frame_pop
+	st1		{v0.16b}, [x4]			/* return dg */
+	mov		w0, w3
 	ret
-
-.Lmacrestart:
-	ld1		{v0.16b}, [x23]			/* get dg */
-	enc_prepare	w21, x20, x0
-	b		.Lmacloop4x
 AES_FUNC_END(aes_mac_update)
-- 
2.29.2


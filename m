Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B102EB07D
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Jan 2021 17:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbhAEQuO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 5 Jan 2021 11:50:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:44042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728499AbhAEQuO (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 5 Jan 2021 11:50:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EA9322D02;
        Tue,  5 Jan 2021 16:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609865341;
        bh=XAVqDW0bAWsrKd+67L2IKk7dIn9+Ngq/EVd/jpxzSaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h99+LC6GmjzleqArbG0UUpcb41/+J7GuDZffevm2mkefCiz9PFZjbGBYRLmIcHva3
         l1Pwt6V2UofB/g76P8BxEjbbtEUqEqQ0hg76YtN895R1ZMUu3fXultVAaLEw6kCGeb
         Zs55704l5iFXSWG/HuB24Pt/jEqUTq8pbmx05zCK2HTSlHjopou0NWV+r+INT/agU3
         rRczyMLF5k4LOwMqOKrcz8o+hosQHc8qBkuVsAi2Ce/63W0cHrZzBmsMMCQDY5+MPp
         yUq6Ew9yjMiN0HPpE8anc8YksC3yImyZgnjFQvgfp+sj61jPkqMRLfKrsZ4v0jZSBs
         qYHXHxuebtwZw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Megha Dey <megha.dey@intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Milan Broz <gmazyland@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH v2 07/21] crypto: x86/serpent - drop CTR mode implementation
Date:   Tue,  5 Jan 2021 17:47:55 +0100
Message-Id: <20210105164809.8594-8-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105164809.8594-1-ardb@kernel.org>
References: <20210105164809.8594-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Serpent in CTR mode is never used by the kernel directly, and is highly
unlikely to be relied upon by dm-crypt or algif_skcipher. So let's drop
the accelerated CTR mode implementation, and instead, rely on the CTR
template and the bare cipher.

Acked-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/crypto/serpent-avx-x86_64-asm_64.S | 20 ------
 arch/x86/crypto/serpent-avx2-asm_64.S       | 25 --------
 arch/x86/crypto/serpent_avx2_glue.c         | 38 -----------
 arch/x86/crypto/serpent_avx_glue.c          | 51 ---------------
 arch/x86/crypto/serpent_sse2_glue.c         | 67 --------------------
 crypto/Kconfig                              |  3 +
 6 files changed, 3 insertions(+), 201 deletions(-)

diff --git a/arch/x86/crypto/serpent-avx-x86_64-asm_64.S b/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
index 6b41f46bcc76..b7ee24df7fba 100644
--- a/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
@@ -711,23 +711,3 @@ SYM_FUNC_START(serpent_cbc_dec_8way_avx)
 	FRAME_END
 	ret;
 SYM_FUNC_END(serpent_cbc_dec_8way_avx)
-
-SYM_FUNC_START(serpent_ctr_8way_avx)
-	/* input:
-	 *	%rdi: ctx, CTX
-	 *	%rsi: dst
-	 *	%rdx: src
-	 *	%rcx: iv (little endian, 128bit)
-	 */
-	FRAME_BEGIN
-
-	load_ctr_8way(%rcx, .Lbswap128_mask, RA1, RB1, RC1, RD1, RA2, RB2, RC2,
-		      RD2, RK0, RK1, RK2);
-
-	call __serpent_enc_blk8_avx;
-
-	store_ctr_8way(%rdx, %rsi, RA1, RB1, RC1, RD1, RA2, RB2, RC2, RD2);
-
-	FRAME_END
-	ret;
-SYM_FUNC_END(serpent_ctr_8way_avx)
diff --git a/arch/x86/crypto/serpent-avx2-asm_64.S b/arch/x86/crypto/serpent-avx2-asm_64.S
index a510a949f02f..9161b6e441f3 100644
--- a/arch/x86/crypto/serpent-avx2-asm_64.S
+++ b/arch/x86/crypto/serpent-avx2-asm_64.S
@@ -724,28 +724,3 @@ SYM_FUNC_START(serpent_cbc_dec_16way)
 	FRAME_END
 	ret;
 SYM_FUNC_END(serpent_cbc_dec_16way)
-
-SYM_FUNC_START(serpent_ctr_16way)
-	/* input:
-	 *	%rdi: ctx, CTX
-	 *	%rsi: dst (16 blocks)
-	 *	%rdx: src (16 blocks)
-	 *	%rcx: iv (little endian, 128bit)
-	 */
-	FRAME_BEGIN
-
-	vzeroupper;
-
-	load_ctr_16way(%rcx, .Lbswap128_mask, RA1, RB1, RC1, RD1, RA2, RB2, RC2,
-		       RD2, RK0, RK0x, RK1, RK1x, RK2, RK2x, RK3, RK3x, RNOT,
-		       tp);
-
-	call __serpent_enc_blk16;
-
-	store_ctr_16way(%rdx, %rsi, RA1, RB1, RC1, RD1, RA2, RB2, RC2, RD2);
-
-	vzeroupper;
-
-	FRAME_END
-	ret;
-SYM_FUNC_END(serpent_ctr_16way)
diff --git a/arch/x86/crypto/serpent_avx2_glue.c b/arch/x86/crypto/serpent_avx2_glue.c
index 9cdf2c078e21..28e542c6512a 100644
--- a/arch/x86/crypto/serpent_avx2_glue.c
+++ b/arch/x86/crypto/serpent_avx2_glue.c
@@ -22,8 +22,6 @@ asmlinkage void serpent_ecb_enc_16way(const void *ctx, u8 *dst, const u8 *src);
 asmlinkage void serpent_ecb_dec_16way(const void *ctx, u8 *dst, const u8 *src);
 asmlinkage void serpent_cbc_dec_16way(const void *ctx, u8 *dst, const u8 *src);
 
-asmlinkage void serpent_ctr_16way(const void *ctx, u8 *dst, const u8 *src,
-				  le128 *iv);
 static int serpent_setkey_skcipher(struct crypto_skcipher *tfm,
 				   const u8 *key, unsigned int keylen)
 {
@@ -46,22 +44,6 @@ static const struct common_glue_ctx serpent_enc = {
 	} }
 };
 
-static const struct common_glue_ctx serpent_ctr = {
-	.num_funcs = 3,
-	.fpu_blocks_limit = 8,
-
-	.funcs = { {
-		.num_blocks = 16,
-		.fn_u = { .ctr = serpent_ctr_16way }
-	},  {
-		.num_blocks = 8,
-		.fn_u = { .ctr = serpent_ctr_8way_avx }
-	}, {
-		.num_blocks = 1,
-		.fn_u = { .ctr = __serpent_crypt_ctr }
-	} }
-};
-
 static const struct common_glue_ctx serpent_dec = {
 	.num_funcs = 3,
 	.fpu_blocks_limit = 8,
@@ -114,11 +96,6 @@ static int cbc_decrypt(struct skcipher_request *req)
 	return glue_cbc_decrypt_req_128bit(&serpent_dec_cbc, req);
 }
 
-static int ctr_crypt(struct skcipher_request *req)
-{
-	return glue_ctr_req_128bit(&serpent_ctr, req);
-}
-
 static struct skcipher_alg serpent_algs[] = {
 	{
 		.base.cra_name		= "__ecb(serpent)",
@@ -147,21 +124,6 @@ static struct skcipher_alg serpent_algs[] = {
 		.setkey			= serpent_setkey_skcipher,
 		.encrypt		= cbc_encrypt,
 		.decrypt		= cbc_decrypt,
-	}, {
-		.base.cra_name		= "__ctr(serpent)",
-		.base.cra_driver_name	= "__ctr-serpent-avx2",
-		.base.cra_priority	= 600,
-		.base.cra_flags		= CRYPTO_ALG_INTERNAL,
-		.base.cra_blocksize	= 1,
-		.base.cra_ctxsize	= sizeof(struct serpent_ctx),
-		.base.cra_module	= THIS_MODULE,
-		.min_keysize		= SERPENT_MIN_KEY_SIZE,
-		.max_keysize		= SERPENT_MAX_KEY_SIZE,
-		.ivsize			= SERPENT_BLOCK_SIZE,
-		.chunksize		= SERPENT_BLOCK_SIZE,
-		.setkey			= serpent_setkey_skcipher,
-		.encrypt		= ctr_crypt,
-		.decrypt		= ctr_crypt,
 	},
 };
 
diff --git a/arch/x86/crypto/serpent_avx_glue.c b/arch/x86/crypto/serpent_avx_glue.c
index b17a08b57a91..aa4605baf9d4 100644
--- a/arch/x86/crypto/serpent_avx_glue.c
+++ b/arch/x86/crypto/serpent_avx_glue.c
@@ -31,24 +31,6 @@ asmlinkage void serpent_cbc_dec_8way_avx(const void *ctx, u8 *dst,
 					 const u8 *src);
 EXPORT_SYMBOL_GPL(serpent_cbc_dec_8way_avx);
 
-asmlinkage void serpent_ctr_8way_avx(const void *ctx, u8 *dst, const u8 *src,
-				     le128 *iv);
-EXPORT_SYMBOL_GPL(serpent_ctr_8way_avx);
-
-void __serpent_crypt_ctr(const void *ctx, u8 *d, const u8 *s, le128 *iv)
-{
-	be128 ctrblk;
-	u128 *dst = (u128 *)d;
-	const u128 *src = (const u128 *)s;
-
-	le128_to_be128(&ctrblk, iv);
-	le128_inc(iv);
-
-	__serpent_encrypt(ctx, (u8 *)&ctrblk, (u8 *)&ctrblk);
-	u128_xor(dst, src, (u128 *)&ctrblk);
-}
-EXPORT_SYMBOL_GPL(__serpent_crypt_ctr);
-
 static int serpent_setkey_skcipher(struct crypto_skcipher *tfm,
 				   const u8 *key, unsigned int keylen)
 {
@@ -68,19 +50,6 @@ static const struct common_glue_ctx serpent_enc = {
 	} }
 };
 
-static const struct common_glue_ctx serpent_ctr = {
-	.num_funcs = 2,
-	.fpu_blocks_limit = SERPENT_PARALLEL_BLOCKS,
-
-	.funcs = { {
-		.num_blocks = SERPENT_PARALLEL_BLOCKS,
-		.fn_u = { .ctr = serpent_ctr_8way_avx }
-	}, {
-		.num_blocks = 1,
-		.fn_u = { .ctr = __serpent_crypt_ctr }
-	} }
-};
-
 static const struct common_glue_ctx serpent_dec = {
 	.num_funcs = 2,
 	.fpu_blocks_limit = SERPENT_PARALLEL_BLOCKS,
@@ -127,11 +96,6 @@ static int cbc_decrypt(struct skcipher_request *req)
 	return glue_cbc_decrypt_req_128bit(&serpent_dec_cbc, req);
 }
 
-static int ctr_crypt(struct skcipher_request *req)
-{
-	return glue_ctr_req_128bit(&serpent_ctr, req);
-}
-
 static struct skcipher_alg serpent_algs[] = {
 	{
 		.base.cra_name		= "__ecb(serpent)",
@@ -160,21 +124,6 @@ static struct skcipher_alg serpent_algs[] = {
 		.setkey			= serpent_setkey_skcipher,
 		.encrypt		= cbc_encrypt,
 		.decrypt		= cbc_decrypt,
-	}, {
-		.base.cra_name		= "__ctr(serpent)",
-		.base.cra_driver_name	= "__ctr-serpent-avx",
-		.base.cra_priority	= 500,
-		.base.cra_flags		= CRYPTO_ALG_INTERNAL,
-		.base.cra_blocksize	= 1,
-		.base.cra_ctxsize	= sizeof(struct serpent_ctx),
-		.base.cra_module	= THIS_MODULE,
-		.min_keysize		= SERPENT_MIN_KEY_SIZE,
-		.max_keysize		= SERPENT_MAX_KEY_SIZE,
-		.ivsize			= SERPENT_BLOCK_SIZE,
-		.chunksize		= SERPENT_BLOCK_SIZE,
-		.setkey			= serpent_setkey_skcipher,
-		.encrypt		= ctr_crypt,
-		.decrypt		= ctr_crypt,
 	},
 };
 
diff --git a/arch/x86/crypto/serpent_sse2_glue.c b/arch/x86/crypto/serpent_sse2_glue.c
index 4fed8d26b91a..9acb3bf28feb 100644
--- a/arch/x86/crypto/serpent_sse2_glue.c
+++ b/arch/x86/crypto/serpent_sse2_glue.c
@@ -10,8 +10,6 @@
  *
  * CBC & ECB parts based on code (crypto/cbc.c,ecb.c) by:
  *   Copyright (c) 2006 Herbert Xu <herbert@gondor.apana.org.au>
- * CTR part based on code (crypto/ctr.c) by:
- *   (C) Copyright IBM Corp. 2007 - Joy Latten <latten@us.ibm.com>
  */
 
 #include <linux/module.h>
@@ -47,38 +45,6 @@ static void serpent_decrypt_cbc_xway(const void *ctx, u8 *d, const u8 *s)
 		u128_xor(dst + (j + 1), dst + (j + 1), ivs + j);
 }
 
-static void serpent_crypt_ctr(const void *ctx, u8 *d, const u8 *s, le128 *iv)
-{
-	be128 ctrblk;
-	u128 *dst = (u128 *)d;
-	const u128 *src = (const u128 *)s;
-
-	le128_to_be128(&ctrblk, iv);
-	le128_inc(iv);
-
-	__serpent_encrypt(ctx, (u8 *)&ctrblk, (u8 *)&ctrblk);
-	u128_xor(dst, src, (u128 *)&ctrblk);
-}
-
-static void serpent_crypt_ctr_xway(const void *ctx, u8 *d, const u8 *s,
-				   le128 *iv)
-{
-	be128 ctrblks[SERPENT_PARALLEL_BLOCKS];
-	u128 *dst = (u128 *)d;
-	const u128 *src = (const u128 *)s;
-	unsigned int i;
-
-	for (i = 0; i < SERPENT_PARALLEL_BLOCKS; i++) {
-		if (dst != src)
-			dst[i] = src[i];
-
-		le128_to_be128(&ctrblks[i], iv);
-		le128_inc(iv);
-	}
-
-	serpent_enc_blk_xway_xor(ctx, (u8 *)dst, (u8 *)ctrblks);
-}
-
 static const struct common_glue_ctx serpent_enc = {
 	.num_funcs = 2,
 	.fpu_blocks_limit = SERPENT_PARALLEL_BLOCKS,
@@ -92,19 +58,6 @@ static const struct common_glue_ctx serpent_enc = {
 	} }
 };
 
-static const struct common_glue_ctx serpent_ctr = {
-	.num_funcs = 2,
-	.fpu_blocks_limit = SERPENT_PARALLEL_BLOCKS,
-
-	.funcs = { {
-		.num_blocks = SERPENT_PARALLEL_BLOCKS,
-		.fn_u = { .ctr = serpent_crypt_ctr_xway }
-	}, {
-		.num_blocks = 1,
-		.fn_u = { .ctr = serpent_crypt_ctr }
-	} }
-};
-
 static const struct common_glue_ctx serpent_dec = {
 	.num_funcs = 2,
 	.fpu_blocks_limit = SERPENT_PARALLEL_BLOCKS,
@@ -152,11 +105,6 @@ static int cbc_decrypt(struct skcipher_request *req)
 	return glue_cbc_decrypt_req_128bit(&serpent_dec_cbc, req);
 }
 
-static int ctr_crypt(struct skcipher_request *req)
-{
-	return glue_ctr_req_128bit(&serpent_ctr, req);
-}
-
 static struct skcipher_alg serpent_algs[] = {
 	{
 		.base.cra_name		= "__ecb(serpent)",
@@ -185,21 +133,6 @@ static struct skcipher_alg serpent_algs[] = {
 		.setkey			= serpent_setkey_skcipher,
 		.encrypt		= cbc_encrypt,
 		.decrypt		= cbc_decrypt,
-	}, {
-		.base.cra_name		= "__ctr(serpent)",
-		.base.cra_driver_name	= "__ctr-serpent-sse2",
-		.base.cra_priority	= 400,
-		.base.cra_flags		= CRYPTO_ALG_INTERNAL,
-		.base.cra_blocksize	= 1,
-		.base.cra_ctxsize	= sizeof(struct serpent_ctx),
-		.base.cra_module	= THIS_MODULE,
-		.min_keysize		= SERPENT_MIN_KEY_SIZE,
-		.max_keysize		= SERPENT_MAX_KEY_SIZE,
-		.ivsize			= SERPENT_BLOCK_SIZE,
-		.chunksize		= SERPENT_BLOCK_SIZE,
-		.setkey			= serpent_setkey_skcipher,
-		.encrypt		= ctr_crypt,
-		.decrypt		= ctr_crypt,
 	},
 };
 
diff --git a/crypto/Kconfig b/crypto/Kconfig
index ea788cab8c7d..dd48c3bab3f5 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1539,6 +1539,7 @@ config CRYPTO_SERPENT_SSE2_X86_64
 	select CRYPTO_GLUE_HELPER_X86
 	select CRYPTO_SERPENT
 	select CRYPTO_SIMD
+	imply CRYPTO_CTR
 	help
 	  Serpent cipher algorithm, by Anderson, Biham & Knudsen.
 
@@ -1558,6 +1559,7 @@ config CRYPTO_SERPENT_SSE2_586
 	select CRYPTO_GLUE_HELPER_X86
 	select CRYPTO_SERPENT
 	select CRYPTO_SIMD
+	imply CRYPTO_CTR
 	help
 	  Serpent cipher algorithm, by Anderson, Biham & Knudsen.
 
@@ -1578,6 +1580,7 @@ config CRYPTO_SERPENT_AVX_X86_64
 	select CRYPTO_SERPENT
 	select CRYPTO_SIMD
 	imply CRYPTO_XTS
+	imply CRYPTO_CTR
 	help
 	  Serpent cipher algorithm, by Anderson, Biham & Knudsen.
 
-- 
2.17.1


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0872E8168
	for <lists+linux-crypto@lfdr.de>; Thu, 31 Dec 2020 18:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgLaRYl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 31 Dec 2020 12:24:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:54758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgLaRYk (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 31 Dec 2020 12:24:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 234312242A;
        Thu, 31 Dec 2020 17:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609435439;
        bh=RVUOgzblhVxXipF+TH0F1dBrD2if8f5ZJNxV4J4xNV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k37Cem8O6+IRr0iM01P410y3YlQwpSR4lwRNSXFR2OkoWZkDHsW7MdbmG3qiz2hMQ
         d3wECijLyiVWldSkxQo5r8wkj19sybYipqyZHgOZKP0w3/qjV65KPzXubVzF1lREly
         rtWGsnlBIMY/ghxxSgg0x1c2ur3Cwi7/ZnWGyWRhI3GMm7LuA0HgMYHBNEt/Aa9J7W
         /m41EQ5Y0kRBZowDg7JoE+6hbR7Gf2iu1jA6AhycV2xsUcJJM6w6L+rd3rYEY7MKaA
         3er/fs0iS9iJqvJuVpIrBhN5OpADfj6qsIRmxVQsHx/ZNLyIZSm5fbRwQ2pOk8MTQQ
         cPWxLqrqPlK3Q==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Megha Dey <megha.dey@intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Milan Broz <gmazyland@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 04/21] crypto: x86/twofish - switch to XTS template
Date:   Thu, 31 Dec 2020 18:23:20 +0100
Message-Id: <20201231172337.23073-5-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201231172337.23073-1-ardb@kernel.org>
References: <20201231172337.23073-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Now that the XTS template can wrap accelerated ECB modes, it can be
used to implement Twofish in XTS mode as well, which turns out to
be at least as fast, and sometimes even faster

Acked-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/crypto/twofish-avx-x86_64-asm_64.S | 53 -----------
 arch/x86/crypto/twofish_avx_glue.c          | 98 --------------------
 crypto/Kconfig                              |  1 +
 3 files changed, 1 insertion(+), 151 deletions(-)

diff --git a/arch/x86/crypto/twofish-avx-x86_64-asm_64.S b/arch/x86/crypto/twofish-avx-x86_64-asm_64.S
index a5151393bb2f..84e61ef03638 100644
--- a/arch/x86/crypto/twofish-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/twofish-avx-x86_64-asm_64.S
@@ -19,11 +19,6 @@
 .Lbswap128_mask:
 	.byte 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0
 
-.section	.rodata.cst16.xts_gf128mul_and_shl1_mask, "aM", @progbits, 16
-.align 16
-.Lxts_gf128mul_and_shl1_mask:
-	.byte 0x87, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0
-
 .text
 
 /* structure of crypto context */
@@ -406,51 +401,3 @@ SYM_FUNC_START(twofish_ctr_8way)
 	FRAME_END
 	ret;
 SYM_FUNC_END(twofish_ctr_8way)
-
-SYM_FUNC_START(twofish_xts_enc_8way)
-	/* input:
-	 *	%rdi: ctx, CTX
-	 *	%rsi: dst
-	 *	%rdx: src
-	 *	%rcx: iv (t ⊕ αⁿ ∈ GF(2¹²⁸))
-	 */
-	FRAME_BEGIN
-
-	movq %rsi, %r11;
-
-	/* regs <= src, dst <= IVs, regs <= regs xor IVs */
-	load_xts_8way(%rcx, %rdx, %rsi, RA1, RB1, RC1, RD1, RA2, RB2, RC2, RD2,
-		      RX0, RX1, RY0, .Lxts_gf128mul_and_shl1_mask);
-
-	call __twofish_enc_blk8;
-
-	/* dst <= regs xor IVs(in dst) */
-	store_xts_8way(%r11, RC1, RD1, RA1, RB1, RC2, RD2, RA2, RB2);
-
-	FRAME_END
-	ret;
-SYM_FUNC_END(twofish_xts_enc_8way)
-
-SYM_FUNC_START(twofish_xts_dec_8way)
-	/* input:
-	 *	%rdi: ctx, CTX
-	 *	%rsi: dst
-	 *	%rdx: src
-	 *	%rcx: iv (t ⊕ αⁿ ∈ GF(2¹²⁸))
-	 */
-	FRAME_BEGIN
-
-	movq %rsi, %r11;
-
-	/* regs <= src, dst <= IVs, regs <= regs xor IVs */
-	load_xts_8way(%rcx, %rdx, %rsi, RC1, RD1, RA1, RB1, RC2, RD2, RA2, RB2,
-		      RX0, RX1, RY0, .Lxts_gf128mul_and_shl1_mask);
-
-	call __twofish_dec_blk8;
-
-	/* dst <= regs xor IVs(in dst) */
-	store_xts_8way(%r11, RA1, RB1, RC1, RD1, RA2, RB2, RC2, RD2);
-
-	FRAME_END
-	ret;
-SYM_FUNC_END(twofish_xts_dec_8way)
diff --git a/arch/x86/crypto/twofish_avx_glue.c b/arch/x86/crypto/twofish_avx_glue.c
index 2dbc8ce3730e..7b539bbb108f 100644
--- a/arch/x86/crypto/twofish_avx_glue.c
+++ b/arch/x86/crypto/twofish_avx_glue.c
@@ -15,7 +15,6 @@
 #include <crypto/algapi.h>
 #include <crypto/internal/simd.h>
 #include <crypto/twofish.h>
-#include <crypto/xts.h>
 #include <asm/crypto/glue_helper.h>
 #include <asm/crypto/twofish.h>
 
@@ -29,11 +28,6 @@ asmlinkage void twofish_cbc_dec_8way(const void *ctx, u8 *dst, const u8 *src);
 asmlinkage void twofish_ctr_8way(const void *ctx, u8 *dst, const u8 *src,
 				 le128 *iv);
 
-asmlinkage void twofish_xts_enc_8way(const void *ctx, u8 *dst, const u8 *src,
-				     le128 *iv);
-asmlinkage void twofish_xts_dec_8way(const void *ctx, u8 *dst, const u8 *src,
-				     le128 *iv);
-
 static int twofish_setkey_skcipher(struct crypto_skcipher *tfm,
 				   const u8 *key, unsigned int keylen)
 {
@@ -45,40 +39,6 @@ static inline void twofish_enc_blk_3way(const void *ctx, u8 *dst, const u8 *src)
 	__twofish_enc_blk_3way(ctx, dst, src, false);
 }
 
-static void twofish_xts_enc(const void *ctx, u8 *dst, const u8 *src, le128 *iv)
-{
-	glue_xts_crypt_128bit_one(ctx, dst, src, iv, twofish_enc_blk);
-}
-
-static void twofish_xts_dec(const void *ctx, u8 *dst, const u8 *src, le128 *iv)
-{
-	glue_xts_crypt_128bit_one(ctx, dst, src, iv, twofish_dec_blk);
-}
-
-struct twofish_xts_ctx {
-	struct twofish_ctx tweak_ctx;
-	struct twofish_ctx crypt_ctx;
-};
-
-static int xts_twofish_setkey(struct crypto_skcipher *tfm, const u8 *key,
-			      unsigned int keylen)
-{
-	struct twofish_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
-	int err;
-
-	err = xts_verify_key(tfm, key, keylen);
-	if (err)
-		return err;
-
-	/* first half of xts-key is for crypt */
-	err = __twofish_setkey(&ctx->crypt_ctx, key, keylen / 2);
-	if (err)
-		return err;
-
-	/* second half of xts-key is for tweak */
-	return __twofish_setkey(&ctx->tweak_ctx, key + keylen / 2, keylen / 2);
-}
-
 static const struct common_glue_ctx twofish_enc = {
 	.num_funcs = 3,
 	.fpu_blocks_limit = TWOFISH_PARALLEL_BLOCKS,
@@ -111,19 +71,6 @@ static const struct common_glue_ctx twofish_ctr = {
 	} }
 };
 
-static const struct common_glue_ctx twofish_enc_xts = {
-	.num_funcs = 2,
-	.fpu_blocks_limit = TWOFISH_PARALLEL_BLOCKS,
-
-	.funcs = { {
-		.num_blocks = TWOFISH_PARALLEL_BLOCKS,
-		.fn_u = { .xts = twofish_xts_enc_8way }
-	}, {
-		.num_blocks = 1,
-		.fn_u = { .xts = twofish_xts_enc }
-	} }
-};
-
 static const struct common_glue_ctx twofish_dec = {
 	.num_funcs = 3,
 	.fpu_blocks_limit = TWOFISH_PARALLEL_BLOCKS,
@@ -156,19 +103,6 @@ static const struct common_glue_ctx twofish_dec_cbc = {
 	} }
 };
 
-static const struct common_glue_ctx twofish_dec_xts = {
-	.num_funcs = 2,
-	.fpu_blocks_limit = TWOFISH_PARALLEL_BLOCKS,
-
-	.funcs = { {
-		.num_blocks = TWOFISH_PARALLEL_BLOCKS,
-		.fn_u = { .xts = twofish_xts_dec_8way }
-	}, {
-		.num_blocks = 1,
-		.fn_u = { .xts = twofish_xts_dec }
-	} }
-};
-
 static int ecb_encrypt(struct skcipher_request *req)
 {
 	return glue_ecb_req_128bit(&twofish_enc, req);
@@ -194,24 +128,6 @@ static int ctr_crypt(struct skcipher_request *req)
 	return glue_ctr_req_128bit(&twofish_ctr, req);
 }
 
-static int xts_encrypt(struct skcipher_request *req)
-{
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct twofish_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
-
-	return glue_xts_req_128bit(&twofish_enc_xts, req, twofish_enc_blk,
-				   &ctx->tweak_ctx, &ctx->crypt_ctx, false);
-}
-
-static int xts_decrypt(struct skcipher_request *req)
-{
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct twofish_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
-
-	return glue_xts_req_128bit(&twofish_dec_xts, req, twofish_enc_blk,
-				   &ctx->tweak_ctx, &ctx->crypt_ctx, true);
-}
-
 static struct skcipher_alg twofish_algs[] = {
 	{
 		.base.cra_name		= "__ecb(twofish)",
@@ -255,20 +171,6 @@ static struct skcipher_alg twofish_algs[] = {
 		.setkey			= twofish_setkey_skcipher,
 		.encrypt		= ctr_crypt,
 		.decrypt		= ctr_crypt,
-	}, {
-		.base.cra_name		= "__xts(twofish)",
-		.base.cra_driver_name	= "__xts-twofish-avx",
-		.base.cra_priority	= 400,
-		.base.cra_flags		= CRYPTO_ALG_INTERNAL,
-		.base.cra_blocksize	= TF_BLOCK_SIZE,
-		.base.cra_ctxsize	= sizeof(struct twofish_xts_ctx),
-		.base.cra_module	= THIS_MODULE,
-		.min_keysize		= 2 * TF_MIN_KEY_SIZE,
-		.max_keysize		= 2 * TF_MAX_KEY_SIZE,
-		.ivsize			= TF_BLOCK_SIZE,
-		.setkey			= xts_twofish_setkey,
-		.encrypt		= xts_encrypt,
-		.decrypt		= xts_decrypt,
 	},
 };
 
diff --git a/crypto/Kconfig b/crypto/Kconfig
index ce69a5ae26b5..7ad9bf84f4a0 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1731,6 +1731,7 @@ config CRYPTO_TWOFISH_AVX_X86_64
 	select CRYPTO_TWOFISH_COMMON
 	select CRYPTO_TWOFISH_X86_64
 	select CRYPTO_TWOFISH_X86_64_3WAY
+	imply CRYPTO_XTS
 	help
 	  Twofish cipher algorithm (x86_64/AVX).
 
-- 
2.17.1


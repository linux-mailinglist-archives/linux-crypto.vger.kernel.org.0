Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F0B2EB077
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Jan 2021 17:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbhAEQtf (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 5 Jan 2021 11:49:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:43778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbhAEQtf (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 5 Jan 2021 11:49:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 104EE22CBE;
        Tue,  5 Jan 2021 16:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609865334;
        bh=jnpRkMCxKXk4JHRKJPJ8KaTGW9pSuv2eZARbURmztK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mEgsJsT87uoJQ+aBRpRlO72JK5A3kgvQQolUvM/kwJDoqXtntXpdm//H2HsTjfbFY
         2y+hmAgUCY67vTRh+QzZNvOCncxbVfrb8X9LM6yWPL1QFXrszu37O2yNfSFyRCtB9U
         QTOmu7F5hXH3ZIlQH3T4+Vlm3mL4DwK/iH+kMDMO1GQVDH7r903uamFQ6KxyPLkkQt
         OJe0n9W0GzCNwO6ivCwww3PX6Clla/tQQBromAXlbvSUepu/SQoXVbv07WUvQSVkhr
         aoc/gqQYro4bYvUsBJuFR80N92AhOf68rh3evu8euNsntd1MwZt5fYbCd01jVkHkA1
         VxJ1WM7OdKG2A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Megha Dey <megha.dey@intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Milan Broz <gmazyland@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH v2 03/21] crypto: x86/serpent- switch to XTS template
Date:   Tue,  5 Jan 2021 17:47:51 +0100
Message-Id: <20210105164809.8594-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105164809.8594-1-ardb@kernel.org>
References: <20210105164809.8594-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Now that the XTS template can wrap accelerated ECB modes, it can be
used to implement Serpent in XTS mode as well, which turns out to
be at least as fast, and sometimes even faster

Acked-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/crypto/serpent-avx-x86_64-asm_64.S |  48 ----------
 arch/x86/crypto/serpent-avx2-asm_64.S       |  62 ------------
 arch/x86/crypto/serpent_avx2_glue.c         |  72 --------------
 arch/x86/crypto/serpent_avx_glue.c          | 101 --------------------
 arch/x86/include/asm/crypto/serpent-avx.h   |  21 ----
 crypto/Kconfig                              |   2 +-
 6 files changed, 1 insertion(+), 305 deletions(-)

diff --git a/arch/x86/crypto/serpent-avx-x86_64-asm_64.S b/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
index ba9e4c1e7f5c..6b41f46bcc76 100644
--- a/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
@@ -18,10 +18,6 @@
 .align 16
 .Lbswap128_mask:
 	.byte 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0
-.section	.rodata.cst16.xts_gf128mul_and_shl1_mask, "aM", @progbits, 16
-.align 16
-.Lxts_gf128mul_and_shl1_mask:
-	.byte 0x87, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0
 
 .text
 
@@ -735,47 +731,3 @@ SYM_FUNC_START(serpent_ctr_8way_avx)
 	FRAME_END
 	ret;
 SYM_FUNC_END(serpent_ctr_8way_avx)
-
-SYM_FUNC_START(serpent_xts_enc_8way_avx)
-	/* input:
-	 *	%rdi: ctx, CTX
-	 *	%rsi: dst
-	 *	%rdx: src
-	 *	%rcx: iv (t ⊕ αⁿ ∈ GF(2¹²⁸))
-	 */
-	FRAME_BEGIN
-
-	/* regs <= src, dst <= IVs, regs <= regs xor IVs */
-	load_xts_8way(%rcx, %rdx, %rsi, RA1, RB1, RC1, RD1, RA2, RB2, RC2, RD2,
-		      RK0, RK1, RK2, .Lxts_gf128mul_and_shl1_mask);
-
-	call __serpent_enc_blk8_avx;
-
-	/* dst <= regs xor IVs(in dst) */
-	store_xts_8way(%rsi, RA1, RB1, RC1, RD1, RA2, RB2, RC2, RD2);
-
-	FRAME_END
-	ret;
-SYM_FUNC_END(serpent_xts_enc_8way_avx)
-
-SYM_FUNC_START(serpent_xts_dec_8way_avx)
-	/* input:
-	 *	%rdi: ctx, CTX
-	 *	%rsi: dst
-	 *	%rdx: src
-	 *	%rcx: iv (t ⊕ αⁿ ∈ GF(2¹²⁸))
-	 */
-	FRAME_BEGIN
-
-	/* regs <= src, dst <= IVs, regs <= regs xor IVs */
-	load_xts_8way(%rcx, %rdx, %rsi, RA1, RB1, RC1, RD1, RA2, RB2, RC2, RD2,
-		      RK0, RK1, RK2, .Lxts_gf128mul_and_shl1_mask);
-
-	call __serpent_dec_blk8_avx;
-
-	/* dst <= regs xor IVs(in dst) */
-	store_xts_8way(%rsi, RC1, RD1, RB1, RE1, RC2, RD2, RB2, RE2);
-
-	FRAME_END
-	ret;
-SYM_FUNC_END(serpent_xts_dec_8way_avx)
diff --git a/arch/x86/crypto/serpent-avx2-asm_64.S b/arch/x86/crypto/serpent-avx2-asm_64.S
index c9648aeae705..a510a949f02f 100644
--- a/arch/x86/crypto/serpent-avx2-asm_64.S
+++ b/arch/x86/crypto/serpent-avx2-asm_64.S
@@ -20,16 +20,6 @@
 .Lbswap128_mask:
 	.byte 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0
 
-.section	.rodata.cst16.xts_gf128mul_and_shl1_mask_0, "aM", @progbits, 16
-.align 16
-.Lxts_gf128mul_and_shl1_mask_0:
-	.byte 0x87, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0
-
-.section	.rodata.cst16.xts_gf128mul_and_shl1_mask_1, "aM", @progbits, 16
-.align 16
-.Lxts_gf128mul_and_shl1_mask_1:
-	.byte 0x0e, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0
-
 .text
 
 #define CTX %rdi
@@ -759,55 +749,3 @@ SYM_FUNC_START(serpent_ctr_16way)
 	FRAME_END
 	ret;
 SYM_FUNC_END(serpent_ctr_16way)
-
-SYM_FUNC_START(serpent_xts_enc_16way)
-	/* input:
-	 *	%rdi: ctx, CTX
-	 *	%rsi: dst (16 blocks)
-	 *	%rdx: src (16 blocks)
-	 *	%rcx: iv (t ⊕ αⁿ ∈ GF(2¹²⁸))
-	 */
-	FRAME_BEGIN
-
-	vzeroupper;
-
-	load_xts_16way(%rcx, %rdx, %rsi, RA1, RB1, RC1, RD1, RA2, RB2, RC2,
-		       RD2, RK0, RK0x, RK1, RK1x, RK2, RK2x, RK3, RK3x, RNOT,
-		       .Lxts_gf128mul_and_shl1_mask_0,
-		       .Lxts_gf128mul_and_shl1_mask_1);
-
-	call __serpent_enc_blk16;
-
-	store_xts_16way(%rsi, RA1, RB1, RC1, RD1, RA2, RB2, RC2, RD2);
-
-	vzeroupper;
-
-	FRAME_END
-	ret;
-SYM_FUNC_END(serpent_xts_enc_16way)
-
-SYM_FUNC_START(serpent_xts_dec_16way)
-	/* input:
-	 *	%rdi: ctx, CTX
-	 *	%rsi: dst (16 blocks)
-	 *	%rdx: src (16 blocks)
-	 *	%rcx: iv (t ⊕ αⁿ ∈ GF(2¹²⁸))
-	 */
-	FRAME_BEGIN
-
-	vzeroupper;
-
-	load_xts_16way(%rcx, %rdx, %rsi, RA1, RB1, RC1, RD1, RA2, RB2, RC2,
-		       RD2, RK0, RK0x, RK1, RK1x, RK2, RK2x, RK3, RK3x, RNOT,
-		       .Lxts_gf128mul_and_shl1_mask_0,
-		       .Lxts_gf128mul_and_shl1_mask_1);
-
-	call __serpent_dec_blk16;
-
-	store_xts_16way(%rsi, RC1, RD1, RB1, RE1, RC2, RD2, RB2, RE2);
-
-	vzeroupper;
-
-	FRAME_END
-	ret;
-SYM_FUNC_END(serpent_xts_dec_16way)
diff --git a/arch/x86/crypto/serpent_avx2_glue.c b/arch/x86/crypto/serpent_avx2_glue.c
index f973ace44ad3..9cdf2c078e21 100644
--- a/arch/x86/crypto/serpent_avx2_glue.c
+++ b/arch/x86/crypto/serpent_avx2_glue.c
@@ -12,7 +12,6 @@
 #include <crypto/algapi.h>
 #include <crypto/internal/simd.h>
 #include <crypto/serpent.h>
-#include <crypto/xts.h>
 #include <asm/crypto/glue_helper.h>
 #include <asm/crypto/serpent-avx.h>
 
@@ -25,11 +24,6 @@ asmlinkage void serpent_cbc_dec_16way(const void *ctx, u8 *dst, const u8 *src);
 
 asmlinkage void serpent_ctr_16way(const void *ctx, u8 *dst, const u8 *src,
 				  le128 *iv);
-asmlinkage void serpent_xts_enc_16way(const void *ctx, u8 *dst, const u8 *src,
-				      le128 *iv);
-asmlinkage void serpent_xts_dec_16way(const void *ctx, u8 *dst, const u8 *src,
-				      le128 *iv);
-
 static int serpent_setkey_skcipher(struct crypto_skcipher *tfm,
 				   const u8 *key, unsigned int keylen)
 {
@@ -68,22 +62,6 @@ static const struct common_glue_ctx serpent_ctr = {
 	} }
 };
 
-static const struct common_glue_ctx serpent_enc_xts = {
-	.num_funcs = 3,
-	.fpu_blocks_limit = 8,
-
-	.funcs = { {
-		.num_blocks = 16,
-		.fn_u = { .xts = serpent_xts_enc_16way }
-	}, {
-		.num_blocks = 8,
-		.fn_u = { .xts = serpent_xts_enc_8way_avx }
-	}, {
-		.num_blocks = 1,
-		.fn_u = { .xts = serpent_xts_enc }
-	} }
-};
-
 static const struct common_glue_ctx serpent_dec = {
 	.num_funcs = 3,
 	.fpu_blocks_limit = 8,
@@ -116,22 +94,6 @@ static const struct common_glue_ctx serpent_dec_cbc = {
 	} }
 };
 
-static const struct common_glue_ctx serpent_dec_xts = {
-	.num_funcs = 3,
-	.fpu_blocks_limit = 8,
-
-	.funcs = { {
-		.num_blocks = 16,
-		.fn_u = { .xts = serpent_xts_dec_16way }
-	}, {
-		.num_blocks = 8,
-		.fn_u = { .xts = serpent_xts_dec_8way_avx }
-	}, {
-		.num_blocks = 1,
-		.fn_u = { .xts = serpent_xts_dec }
-	} }
-};
-
 static int ecb_encrypt(struct skcipher_request *req)
 {
 	return glue_ecb_req_128bit(&serpent_enc, req);
@@ -157,26 +119,6 @@ static int ctr_crypt(struct skcipher_request *req)
 	return glue_ctr_req_128bit(&serpent_ctr, req);
 }
 
-static int xts_encrypt(struct skcipher_request *req)
-{
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct serpent_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
-
-	return glue_xts_req_128bit(&serpent_enc_xts, req,
-				   __serpent_encrypt, &ctx->tweak_ctx,
-				   &ctx->crypt_ctx, false);
-}
-
-static int xts_decrypt(struct skcipher_request *req)
-{
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct serpent_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
-
-	return glue_xts_req_128bit(&serpent_dec_xts, req,
-				   __serpent_encrypt, &ctx->tweak_ctx,
-				   &ctx->crypt_ctx, true);
-}
-
 static struct skcipher_alg serpent_algs[] = {
 	{
 		.base.cra_name		= "__ecb(serpent)",
@@ -220,20 +162,6 @@ static struct skcipher_alg serpent_algs[] = {
 		.setkey			= serpent_setkey_skcipher,
 		.encrypt		= ctr_crypt,
 		.decrypt		= ctr_crypt,
-	}, {
-		.base.cra_name		= "__xts(serpent)",
-		.base.cra_driver_name	= "__xts-serpent-avx2",
-		.base.cra_priority	= 600,
-		.base.cra_flags		= CRYPTO_ALG_INTERNAL,
-		.base.cra_blocksize	= SERPENT_BLOCK_SIZE,
-		.base.cra_ctxsize	= sizeof(struct serpent_xts_ctx),
-		.base.cra_module	= THIS_MODULE,
-		.min_keysize		= 2 * SERPENT_MIN_KEY_SIZE,
-		.max_keysize		= 2 * SERPENT_MAX_KEY_SIZE,
-		.ivsize			= SERPENT_BLOCK_SIZE,
-		.setkey			= xts_serpent_setkey,
-		.encrypt		= xts_encrypt,
-		.decrypt		= xts_decrypt,
 	},
 };
 
diff --git a/arch/x86/crypto/serpent_avx_glue.c b/arch/x86/crypto/serpent_avx_glue.c
index 7806d1cbe854..b17a08b57a91 100644
--- a/arch/x86/crypto/serpent_avx_glue.c
+++ b/arch/x86/crypto/serpent_avx_glue.c
@@ -15,7 +15,6 @@
 #include <crypto/algapi.h>
 #include <crypto/internal/simd.h>
 #include <crypto/serpent.h>
-#include <crypto/xts.h>
 #include <asm/crypto/glue_helper.h>
 #include <asm/crypto/serpent-avx.h>
 
@@ -36,14 +35,6 @@ asmlinkage void serpent_ctr_8way_avx(const void *ctx, u8 *dst, const u8 *src,
 				     le128 *iv);
 EXPORT_SYMBOL_GPL(serpent_ctr_8way_avx);
 
-asmlinkage void serpent_xts_enc_8way_avx(const void *ctx, u8 *dst,
-					 const u8 *src, le128 *iv);
-EXPORT_SYMBOL_GPL(serpent_xts_enc_8way_avx);
-
-asmlinkage void serpent_xts_dec_8way_avx(const void *ctx, u8 *dst,
-					 const u8 *src, le128 *iv);
-EXPORT_SYMBOL_GPL(serpent_xts_dec_8way_avx);
-
 void __serpent_crypt_ctr(const void *ctx, u8 *d, const u8 *s, le128 *iv)
 {
 	be128 ctrblk;
@@ -58,44 +49,12 @@ void __serpent_crypt_ctr(const void *ctx, u8 *d, const u8 *s, le128 *iv)
 }
 EXPORT_SYMBOL_GPL(__serpent_crypt_ctr);
 
-void serpent_xts_enc(const void *ctx, u8 *dst, const u8 *src, le128 *iv)
-{
-	glue_xts_crypt_128bit_one(ctx, dst, src, iv, __serpent_encrypt);
-}
-EXPORT_SYMBOL_GPL(serpent_xts_enc);
-
-void serpent_xts_dec(const void *ctx, u8 *dst, const u8 *src, le128 *iv)
-{
-	glue_xts_crypt_128bit_one(ctx, dst, src, iv, __serpent_decrypt);
-}
-EXPORT_SYMBOL_GPL(serpent_xts_dec);
-
 static int serpent_setkey_skcipher(struct crypto_skcipher *tfm,
 				   const u8 *key, unsigned int keylen)
 {
 	return __serpent_setkey(crypto_skcipher_ctx(tfm), key, keylen);
 }
 
-int xts_serpent_setkey(struct crypto_skcipher *tfm, const u8 *key,
-		       unsigned int keylen)
-{
-	struct serpent_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
-	int err;
-
-	err = xts_verify_key(tfm, key, keylen);
-	if (err)
-		return err;
-
-	/* first half of xts-key is for crypt */
-	err = __serpent_setkey(&ctx->crypt_ctx, key, keylen / 2);
-	if (err)
-		return err;
-
-	/* second half of xts-key is for tweak */
-	return __serpent_setkey(&ctx->tweak_ctx, key + keylen / 2, keylen / 2);
-}
-EXPORT_SYMBOL_GPL(xts_serpent_setkey);
-
 static const struct common_glue_ctx serpent_enc = {
 	.num_funcs = 2,
 	.fpu_blocks_limit = SERPENT_PARALLEL_BLOCKS,
@@ -122,19 +81,6 @@ static const struct common_glue_ctx serpent_ctr = {
 	} }
 };
 
-static const struct common_glue_ctx serpent_enc_xts = {
-	.num_funcs = 2,
-	.fpu_blocks_limit = SERPENT_PARALLEL_BLOCKS,
-
-	.funcs = { {
-		.num_blocks = SERPENT_PARALLEL_BLOCKS,
-		.fn_u = { .xts = serpent_xts_enc_8way_avx }
-	}, {
-		.num_blocks = 1,
-		.fn_u = { .xts = serpent_xts_enc }
-	} }
-};
-
 static const struct common_glue_ctx serpent_dec = {
 	.num_funcs = 2,
 	.fpu_blocks_limit = SERPENT_PARALLEL_BLOCKS,
@@ -161,19 +107,6 @@ static const struct common_glue_ctx serpent_dec_cbc = {
 	} }
 };
 
-static const struct common_glue_ctx serpent_dec_xts = {
-	.num_funcs = 2,
-	.fpu_blocks_limit = SERPENT_PARALLEL_BLOCKS,
-
-	.funcs = { {
-		.num_blocks = SERPENT_PARALLEL_BLOCKS,
-		.fn_u = { .xts = serpent_xts_dec_8way_avx }
-	}, {
-		.num_blocks = 1,
-		.fn_u = { .xts = serpent_xts_dec }
-	} }
-};
-
 static int ecb_encrypt(struct skcipher_request *req)
 {
 	return glue_ecb_req_128bit(&serpent_enc, req);
@@ -199,26 +132,6 @@ static int ctr_crypt(struct skcipher_request *req)
 	return glue_ctr_req_128bit(&serpent_ctr, req);
 }
 
-static int xts_encrypt(struct skcipher_request *req)
-{
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct serpent_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
-
-	return glue_xts_req_128bit(&serpent_enc_xts, req,
-				   __serpent_encrypt, &ctx->tweak_ctx,
-				   &ctx->crypt_ctx, false);
-}
-
-static int xts_decrypt(struct skcipher_request *req)
-{
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct serpent_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
-
-	return glue_xts_req_128bit(&serpent_dec_xts, req,
-				   __serpent_encrypt, &ctx->tweak_ctx,
-				   &ctx->crypt_ctx, true);
-}
-
 static struct skcipher_alg serpent_algs[] = {
 	{
 		.base.cra_name		= "__ecb(serpent)",
@@ -262,20 +175,6 @@ static struct skcipher_alg serpent_algs[] = {
 		.setkey			= serpent_setkey_skcipher,
 		.encrypt		= ctr_crypt,
 		.decrypt		= ctr_crypt,
-	}, {
-		.base.cra_name		= "__xts(serpent)",
-		.base.cra_driver_name	= "__xts-serpent-avx",
-		.base.cra_priority	= 500,
-		.base.cra_flags		= CRYPTO_ALG_INTERNAL,
-		.base.cra_blocksize	= SERPENT_BLOCK_SIZE,
-		.base.cra_ctxsize	= sizeof(struct serpent_xts_ctx),
-		.base.cra_module	= THIS_MODULE,
-		.min_keysize		= 2 * SERPENT_MIN_KEY_SIZE,
-		.max_keysize		= 2 * SERPENT_MAX_KEY_SIZE,
-		.ivsize			= SERPENT_BLOCK_SIZE,
-		.setkey			= xts_serpent_setkey,
-		.encrypt		= xts_encrypt,
-		.decrypt		= xts_decrypt,
 	},
 };
 
diff --git a/arch/x86/include/asm/crypto/serpent-avx.h b/arch/x86/include/asm/crypto/serpent-avx.h
index 251c2c89d7cf..23f3361a0e72 100644
--- a/arch/x86/include/asm/crypto/serpent-avx.h
+++ b/arch/x86/include/asm/crypto/serpent-avx.h
@@ -10,11 +10,6 @@ struct crypto_skcipher;
 
 #define SERPENT_PARALLEL_BLOCKS 8
 
-struct serpent_xts_ctx {
-	struct serpent_ctx tweak_ctx;
-	struct serpent_ctx crypt_ctx;
-};
-
 asmlinkage void serpent_ecb_enc_8way_avx(const void *ctx, u8 *dst,
 					 const u8 *src);
 asmlinkage void serpent_ecb_dec_8way_avx(const void *ctx, u8 *dst,
@@ -22,21 +17,5 @@ asmlinkage void serpent_ecb_dec_8way_avx(const void *ctx, u8 *dst,
 
 asmlinkage void serpent_cbc_dec_8way_avx(const void *ctx, u8 *dst,
 					 const u8 *src);
-asmlinkage void serpent_ctr_8way_avx(const void *ctx, u8 *dst, const u8 *src,
-				     le128 *iv);
-
-asmlinkage void serpent_xts_enc_8way_avx(const void *ctx, u8 *dst,
-					 const u8 *src, le128 *iv);
-asmlinkage void serpent_xts_dec_8way_avx(const void *ctx, u8 *dst,
-					 const u8 *src, le128 *iv);
-
-extern void __serpent_crypt_ctr(const void *ctx, u8 *dst, const u8 *src,
-				le128 *iv);
-
-extern void serpent_xts_enc(const void *ctx, u8 *dst, const u8 *src, le128 *iv);
-extern void serpent_xts_dec(const void *ctx, u8 *dst, const u8 *src, le128 *iv);
-
-extern int xts_serpent_setkey(struct crypto_skcipher *tfm, const u8 *key,
-			      unsigned int keylen);
 
 #endif
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 03e8468e57df..ce69a5ae26b5 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1576,7 +1576,7 @@ config CRYPTO_SERPENT_AVX_X86_64
 	select CRYPTO_GLUE_HELPER_X86
 	select CRYPTO_SERPENT
 	select CRYPTO_SIMD
-	select CRYPTO_XTS
+	imply CRYPTO_XTS
 	help
 	  Serpent cipher algorithm, by Anderson, Biham & Knudsen.
 
-- 
2.17.1


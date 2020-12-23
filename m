Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488272E227F
	for <lists+linux-crypto@lfdr.de>; Wed, 23 Dec 2020 23:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgLWWk2 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 23 Dec 2020 17:40:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:59410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726662AbgLWWk2 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 23 Dec 2020 17:40:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 453E92253A;
        Wed, 23 Dec 2020 22:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608763163;
        bh=OIRH+BbthxHl/rjCstDZNorJmgFvhqADaPgq0/iYUDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KuUDeROZPzcYguBMKUgMJTWwH5hvM9oqufAQwMgj7pQ1ELEspOlpGdLiki7kXdnRl
         obsRBV3q/L2x7/uJWMHH5DgQqgjKIPGM9OOrngEqBkqg4DzKHpJv64eT+EkCxWrxLp
         0BmGDb02sjtuI/R58yzRaws5Lmxpwq09Jx1wNk5go9zKulmLPrGJPP2XBDMnurj4Dd
         QEfphAq+xhb8Cj4hOpZEiYvIldGYB6LUKpdLmLcpzpdYjct/J1uR5A16lguBWHO5ta
         GZKi5DkXFy29IkTFqMvmFTLzcZlr+EnGtcnna/+TD6fa1I+QnPMTu7vpOqJ5ySc8GW
         BZE5IUEc6geoA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     dm-devel@redhat.com, Ard Biesheuvel <ardb@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Milan Broz <gmazyland@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [RFC PATCH 09/10] crypto: x86/twofish - drop CTR mode implementation
Date:   Wed, 23 Dec 2020 23:38:40 +0100
Message-Id: <20201223223841.11311-10-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201223223841.11311-1-ardb@kernel.org>
References: <20201223223841.11311-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Twofish in CTR mode is never used by the kernel directly, and is highly
unlikely to be relied upon by dm-crypt or algif_skcipher. So let's drop
the accelerated CTR mode implementation, and instead, rely on the CTR
template and the bare cipher.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/crypto/twofish-avx-x86_64-asm_64.S | 27 --------
 arch/x86/crypto/twofish_avx_glue.c          | 38 -----------
 arch/x86/crypto/twofish_glue_3way.c         | 72 --------------------
 arch/x86/include/asm/crypto/twofish.h       |  4 --
 4 files changed, 141 deletions(-)

diff --git a/arch/x86/crypto/twofish-avx-x86_64-asm_64.S b/arch/x86/crypto/twofish-avx-x86_64-asm_64.S
index 84e61ef03638..37e63b3c664e 100644
--- a/arch/x86/crypto/twofish-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/twofish-avx-x86_64-asm_64.S
@@ -374,30 +374,3 @@ SYM_FUNC_START(twofish_cbc_dec_8way)
 	FRAME_END
 	ret;
 SYM_FUNC_END(twofish_cbc_dec_8way)
-
-SYM_FUNC_START(twofish_ctr_8way)
-	/* input:
-	 *	%rdi: ctx, CTX
-	 *	%rsi: dst
-	 *	%rdx: src
-	 *	%rcx: iv (little endian, 128bit)
-	 */
-	FRAME_BEGIN
-
-	pushq %r12;
-
-	movq %rsi, %r11;
-	movq %rdx, %r12;
-
-	load_ctr_8way(%rcx, .Lbswap128_mask, RA1, RB1, RC1, RD1, RA2, RB2, RC2,
-		      RD2, RX0, RX1, RY0);
-
-	call __twofish_enc_blk8;
-
-	store_ctr_8way(%r12, %r11, RC1, RD1, RA1, RB1, RC2, RD2, RA2, RB2);
-
-	popq %r12;
-
-	FRAME_END
-	ret;
-SYM_FUNC_END(twofish_ctr_8way)
diff --git a/arch/x86/crypto/twofish_avx_glue.c b/arch/x86/crypto/twofish_avx_glue.c
index 7b539bbb108f..13f810b61034 100644
--- a/arch/x86/crypto/twofish_avx_glue.c
+++ b/arch/x86/crypto/twofish_avx_glue.c
@@ -25,8 +25,6 @@ asmlinkage void twofish_ecb_enc_8way(const void *ctx, u8 *dst, const u8 *src);
 asmlinkage void twofish_ecb_dec_8way(const void *ctx, u8 *dst, const u8 *src);
 
 asmlinkage void twofish_cbc_dec_8way(const void *ctx, u8 *dst, const u8 *src);
-asmlinkage void twofish_ctr_8way(const void *ctx, u8 *dst, const u8 *src,
-				 le128 *iv);
 
 static int twofish_setkey_skcipher(struct crypto_skcipher *tfm,
 				   const u8 *key, unsigned int keylen)
@@ -55,22 +53,6 @@ static const struct common_glue_ctx twofish_enc = {
 	} }
 };
 
-static const struct common_glue_ctx twofish_ctr = {
-	.num_funcs = 3,
-	.fpu_blocks_limit = TWOFISH_PARALLEL_BLOCKS,
-
-	.funcs = { {
-		.num_blocks = TWOFISH_PARALLEL_BLOCKS,
-		.fn_u = { .ctr = twofish_ctr_8way }
-	}, {
-		.num_blocks = 3,
-		.fn_u = { .ctr = twofish_enc_blk_ctr_3way }
-	}, {
-		.num_blocks = 1,
-		.fn_u = { .ctr = twofish_enc_blk_ctr }
-	} }
-};
-
 static const struct common_glue_ctx twofish_dec = {
 	.num_funcs = 3,
 	.fpu_blocks_limit = TWOFISH_PARALLEL_BLOCKS,
@@ -123,11 +105,6 @@ static int cbc_decrypt(struct skcipher_request *req)
 	return glue_cbc_decrypt_req_128bit(&twofish_dec_cbc, req);
 }
 
-static int ctr_crypt(struct skcipher_request *req)
-{
-	return glue_ctr_req_128bit(&twofish_ctr, req);
-}
-
 static struct skcipher_alg twofish_algs[] = {
 	{
 		.base.cra_name		= "__ecb(twofish)",
@@ -156,21 +133,6 @@ static struct skcipher_alg twofish_algs[] = {
 		.setkey			= twofish_setkey_skcipher,
 		.encrypt		= cbc_encrypt,
 		.decrypt		= cbc_decrypt,
-	}, {
-		.base.cra_name		= "__ctr(twofish)",
-		.base.cra_driver_name	= "__ctr-twofish-avx",
-		.base.cra_priority	= 400,
-		.base.cra_flags		= CRYPTO_ALG_INTERNAL,
-		.base.cra_blocksize	= 1,
-		.base.cra_ctxsize	= sizeof(struct twofish_ctx),
-		.base.cra_module	= THIS_MODULE,
-		.min_keysize		= TF_MIN_KEY_SIZE,
-		.max_keysize		= TF_MAX_KEY_SIZE,
-		.ivsize			= TF_BLOCK_SIZE,
-		.chunksize		= TF_BLOCK_SIZE,
-		.setkey			= twofish_setkey_skcipher,
-		.encrypt		= ctr_crypt,
-		.decrypt		= ctr_crypt,
 	},
 };
 
diff --git a/arch/x86/crypto/twofish_glue_3way.c b/arch/x86/crypto/twofish_glue_3way.c
index 768af6075479..b70f757403a3 100644
--- a/arch/x86/crypto/twofish_glue_3way.c
+++ b/arch/x86/crypto/twofish_glue_3way.c
@@ -52,46 +52,6 @@ void twofish_dec_blk_cbc_3way(const void *ctx, u8 *d, const u8 *s)
 }
 EXPORT_SYMBOL_GPL(twofish_dec_blk_cbc_3way);
 
-void twofish_enc_blk_ctr(const void *ctx, u8 *d, const u8 *s, le128 *iv)
-{
-	be128 ctrblk;
-	u128 *dst = (u128 *)d;
-	const u128 *src = (const u128 *)s;
-
-	if (dst != src)
-		*dst = *src;
-
-	le128_to_be128(&ctrblk, iv);
-	le128_inc(iv);
-
-	twofish_enc_blk(ctx, (u8 *)&ctrblk, (u8 *)&ctrblk);
-	u128_xor(dst, dst, (u128 *)&ctrblk);
-}
-EXPORT_SYMBOL_GPL(twofish_enc_blk_ctr);
-
-void twofish_enc_blk_ctr_3way(const void *ctx, u8 *d, const u8 *s, le128 *iv)
-{
-	be128 ctrblks[3];
-	u128 *dst = (u128 *)d;
-	const u128 *src = (const u128 *)s;
-
-	if (dst != src) {
-		dst[0] = src[0];
-		dst[1] = src[1];
-		dst[2] = src[2];
-	}
-
-	le128_to_be128(&ctrblks[0], iv);
-	le128_inc(iv);
-	le128_to_be128(&ctrblks[1], iv);
-	le128_inc(iv);
-	le128_to_be128(&ctrblks[2], iv);
-	le128_inc(iv);
-
-	twofish_enc_blk_xor_3way(ctx, (u8 *)dst, (u8 *)ctrblks);
-}
-EXPORT_SYMBOL_GPL(twofish_enc_blk_ctr_3way);
-
 static const struct common_glue_ctx twofish_enc = {
 	.num_funcs = 2,
 	.fpu_blocks_limit = -1,
@@ -105,19 +65,6 @@ static const struct common_glue_ctx twofish_enc = {
 	} }
 };
 
-static const struct common_glue_ctx twofish_ctr = {
-	.num_funcs = 2,
-	.fpu_blocks_limit = -1,
-
-	.funcs = { {
-		.num_blocks = 3,
-		.fn_u = { .ctr = twofish_enc_blk_ctr_3way }
-	}, {
-		.num_blocks = 1,
-		.fn_u = { .ctr = twofish_enc_blk_ctr }
-	} }
-};
-
 static const struct common_glue_ctx twofish_dec = {
 	.num_funcs = 2,
 	.fpu_blocks_limit = -1,
@@ -164,11 +111,6 @@ static int cbc_decrypt(struct skcipher_request *req)
 	return glue_cbc_decrypt_req_128bit(&twofish_dec_cbc, req);
 }
 
-static int ctr_crypt(struct skcipher_request *req)
-{
-	return glue_ctr_req_128bit(&twofish_ctr, req);
-}
-
 static struct skcipher_alg tf_skciphers[] = {
 	{
 		.base.cra_name		= "ecb(twofish)",
@@ -195,20 +137,6 @@ static struct skcipher_alg tf_skciphers[] = {
 		.setkey			= twofish_setkey_skcipher,
 		.encrypt		= cbc_encrypt,
 		.decrypt		= cbc_decrypt,
-	}, {
-		.base.cra_name		= "ctr(twofish)",
-		.base.cra_driver_name	= "ctr-twofish-3way",
-		.base.cra_priority	= 300,
-		.base.cra_blocksize	= 1,
-		.base.cra_ctxsize	= sizeof(struct twofish_ctx),
-		.base.cra_module	= THIS_MODULE,
-		.min_keysize		= TF_MIN_KEY_SIZE,
-		.max_keysize		= TF_MAX_KEY_SIZE,
-		.ivsize			= TF_BLOCK_SIZE,
-		.chunksize		= TF_BLOCK_SIZE,
-		.setkey			= twofish_setkey_skcipher,
-		.encrypt		= ctr_crypt,
-		.decrypt		= ctr_crypt,
 	},
 };
 
diff --git a/arch/x86/include/asm/crypto/twofish.h b/arch/x86/include/asm/crypto/twofish.h
index 2c377a8042e1..12df400e6d53 100644
--- a/arch/x86/include/asm/crypto/twofish.h
+++ b/arch/x86/include/asm/crypto/twofish.h
@@ -17,9 +17,5 @@ asmlinkage void twofish_dec_blk_3way(const void *ctx, u8 *dst, const u8 *src);
 
 /* helpers from twofish_x86_64-3way module */
 extern void twofish_dec_blk_cbc_3way(const void *ctx, u8 *dst, const u8 *src);
-extern void twofish_enc_blk_ctr(const void *ctx, u8 *dst, const u8 *src,
-				le128 *iv);
-extern void twofish_enc_blk_ctr_3way(const void *ctx, u8 *dst, const u8 *src,
-				     le128 *iv);
 
 #endif /* ASM_X86_TWOFISH_H */
-- 
2.17.1


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE632E817B
	for <lists+linux-crypto@lfdr.de>; Thu, 31 Dec 2020 18:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgLaRZ4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 31 Dec 2020 12:25:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:55272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727143AbgLaRZz (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 31 Dec 2020 12:25:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A5BE224D3;
        Thu, 31 Dec 2020 17:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609435468;
        bh=VqT/ENg3u52jjY/a1U5tgh7ke9DkjPAElNY3tRpx3NM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m6Tp6zv5prdHthjRKG32D4k4XILtnS5IgVMRPW6Pj5ELKpei0VB4wW9Xin6XLLhKf
         0/GiyqDJCNllE1tRRe6GPI8muw9G6JKrnwgMxKFYqj8LeMDSkschboHj3doefcZlCP
         1NqhgZQahANGLiJtEGNwlGx35aeJs5r2BbtUn5vPUjQe/qNUNMHgez48DicKey1eA3
         javx6Qa3GTqq8Vzv55lcAQd7Yn7rUU7FubLbGGaHblPGthnrxni6Nrkwumt9TxcITh
         zP+EOobqx6G6RPNPfdG0o95X0RzFQfh7GOe8rdiri7doFF49WUa4QrUq5T9Odzm3FV
         I1X25SwfIyFyw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Megha Dey <megha.dey@intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Milan Broz <gmazyland@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 16/21] crypto: x86/serpent - drop dependency on glue helper
Date:   Thu, 31 Dec 2020 18:23:32 +0100
Message-Id: <20201231172337.23073-17-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201231172337.23073-1-ardb@kernel.org>
References: <20201231172337.23073-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Replace the glue helper dependency with implementations of ECB and CBC
based on the new CPP macros, which avoid the need for indirect calls.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/crypto/serpent_avx2_glue.c | 73 +++++-------------
 arch/x86/crypto/serpent_avx_glue.c  | 61 ++++-----------
 arch/x86/crypto/serpent_sse2_glue.c | 81 ++++++--------------
 crypto/Kconfig                      |  3 -
 4 files changed, 61 insertions(+), 157 deletions(-)

diff --git a/arch/x86/crypto/serpent_avx2_glue.c b/arch/x86/crypto/serpent_avx2_glue.c
index 28e542c6512a..261c9ac2d762 100644
--- a/arch/x86/crypto/serpent_avx2_glue.c
+++ b/arch/x86/crypto/serpent_avx2_glue.c
@@ -12,9 +12,10 @@
 #include <crypto/algapi.h>
 #include <crypto/internal/simd.h>
 #include <crypto/serpent.h>
-#include <asm/crypto/glue_helper.h>
 #include <asm/crypto/serpent-avx.h>
 
+#include "ecb_cbc_helpers.h"
+
 #define SERPENT_AVX2_PARALLEL_BLOCKS 16
 
 /* 16-way AVX2 parallel cipher functions */
@@ -28,72 +29,38 @@ static int serpent_setkey_skcipher(struct crypto_skcipher *tfm,
 	return __serpent_setkey(crypto_skcipher_ctx(tfm), key, keylen);
 }
 
-static const struct common_glue_ctx serpent_enc = {
-	.num_funcs = 3,
-	.fpu_blocks_limit = 8,
-
-	.funcs = { {
-		.num_blocks = 16,
-		.fn_u = { .ecb = serpent_ecb_enc_16way }
-	}, {
-		.num_blocks = 8,
-		.fn_u = { .ecb = serpent_ecb_enc_8way_avx }
-	}, {
-		.num_blocks = 1,
-		.fn_u = { .ecb = __serpent_encrypt }
-	} }
-};
-
-static const struct common_glue_ctx serpent_dec = {
-	.num_funcs = 3,
-	.fpu_blocks_limit = 8,
-
-	.funcs = { {
-		.num_blocks = 16,
-		.fn_u = { .ecb = serpent_ecb_dec_16way }
-	}, {
-		.num_blocks = 8,
-		.fn_u = { .ecb = serpent_ecb_dec_8way_avx }
-	}, {
-		.num_blocks = 1,
-		.fn_u = { .ecb = __serpent_decrypt }
-	} }
-};
-
-static const struct common_glue_ctx serpent_dec_cbc = {
-	.num_funcs = 3,
-	.fpu_blocks_limit = 8,
-
-	.funcs = { {
-		.num_blocks = 16,
-		.fn_u = { .cbc = serpent_cbc_dec_16way }
-	}, {
-		.num_blocks = 8,
-		.fn_u = { .cbc = serpent_cbc_dec_8way_avx }
-	}, {
-		.num_blocks = 1,
-		.fn_u = { .cbc = __serpent_decrypt }
-	} }
-};
-
 static int ecb_encrypt(struct skcipher_request *req)
 {
-	return glue_ecb_req_128bit(&serpent_enc, req);
+	ECB_WALK_START(req, SERPENT_BLOCK_SIZE, SERPENT_PARALLEL_BLOCKS);
+	ECB_BLOCK(SERPENT_AVX2_PARALLEL_BLOCKS, serpent_ecb_enc_16way);
+	ECB_BLOCK(SERPENT_PARALLEL_BLOCKS, serpent_ecb_enc_8way_avx);
+	ECB_BLOCK(1, __serpent_encrypt);
+	ECB_WALK_END();
 }
 
 static int ecb_decrypt(struct skcipher_request *req)
 {
-	return glue_ecb_req_128bit(&serpent_dec, req);
+	ECB_WALK_START(req, SERPENT_BLOCK_SIZE, SERPENT_PARALLEL_BLOCKS);
+	ECB_BLOCK(SERPENT_AVX2_PARALLEL_BLOCKS, serpent_ecb_dec_16way);
+	ECB_BLOCK(SERPENT_PARALLEL_BLOCKS, serpent_ecb_dec_8way_avx);
+	ECB_BLOCK(1, __serpent_decrypt);
+	ECB_WALK_END();
 }
 
 static int cbc_encrypt(struct skcipher_request *req)
 {
-	return glue_cbc_encrypt_req_128bit(__serpent_encrypt, req);
+	CBC_WALK_START(req, SERPENT_BLOCK_SIZE, -1);
+	CBC_ENC_BLOCK(__serpent_encrypt);
+	CBC_WALK_END();
 }
 
 static int cbc_decrypt(struct skcipher_request *req)
 {
-	return glue_cbc_decrypt_req_128bit(&serpent_dec_cbc, req);
+	CBC_WALK_START(req, SERPENT_BLOCK_SIZE, SERPENT_PARALLEL_BLOCKS);
+	CBC_DEC_BLOCK(SERPENT_AVX2_PARALLEL_BLOCKS, serpent_cbc_dec_16way);
+	CBC_DEC_BLOCK(SERPENT_PARALLEL_BLOCKS, serpent_cbc_dec_8way_avx);
+	CBC_DEC_BLOCK(1, __serpent_decrypt);
+	CBC_WALK_END();
 }
 
 static struct skcipher_alg serpent_algs[] = {
diff --git a/arch/x86/crypto/serpent_avx_glue.c b/arch/x86/crypto/serpent_avx_glue.c
index aa4605baf9d4..5fe01d2a5b1d 100644
--- a/arch/x86/crypto/serpent_avx_glue.c
+++ b/arch/x86/crypto/serpent_avx_glue.c
@@ -15,9 +15,10 @@
 #include <crypto/algapi.h>
 #include <crypto/internal/simd.h>
 #include <crypto/serpent.h>
-#include <asm/crypto/glue_helper.h>
 #include <asm/crypto/serpent-avx.h>
 
+#include "ecb_cbc_helpers.h"
+
 /* 8-way parallel cipher functions */
 asmlinkage void serpent_ecb_enc_8way_avx(const void *ctx, u8 *dst,
 					 const u8 *src);
@@ -37,63 +38,35 @@ static int serpent_setkey_skcipher(struct crypto_skcipher *tfm,
 	return __serpent_setkey(crypto_skcipher_ctx(tfm), key, keylen);
 }
 
-static const struct common_glue_ctx serpent_enc = {
-	.num_funcs = 2,
-	.fpu_blocks_limit = SERPENT_PARALLEL_BLOCKS,
-
-	.funcs = { {
-		.num_blocks = SERPENT_PARALLEL_BLOCKS,
-		.fn_u = { .ecb = serpent_ecb_enc_8way_avx }
-	}, {
-		.num_blocks = 1,
-		.fn_u = { .ecb = __serpent_encrypt }
-	} }
-};
-
-static const struct common_glue_ctx serpent_dec = {
-	.num_funcs = 2,
-	.fpu_blocks_limit = SERPENT_PARALLEL_BLOCKS,
-
-	.funcs = { {
-		.num_blocks = SERPENT_PARALLEL_BLOCKS,
-		.fn_u = { .ecb = serpent_ecb_dec_8way_avx }
-	}, {
-		.num_blocks = 1,
-		.fn_u = { .ecb = __serpent_decrypt }
-	} }
-};
-
-static const struct common_glue_ctx serpent_dec_cbc = {
-	.num_funcs = 2,
-	.fpu_blocks_limit = SERPENT_PARALLEL_BLOCKS,
-
-	.funcs = { {
-		.num_blocks = SERPENT_PARALLEL_BLOCKS,
-		.fn_u = { .cbc = serpent_cbc_dec_8way_avx }
-	}, {
-		.num_blocks = 1,
-		.fn_u = { .cbc = __serpent_decrypt }
-	} }
-};
-
 static int ecb_encrypt(struct skcipher_request *req)
 {
-	return glue_ecb_req_128bit(&serpent_enc, req);
+	ECB_WALK_START(req, SERPENT_BLOCK_SIZE, SERPENT_PARALLEL_BLOCKS);
+	ECB_BLOCK(SERPENT_PARALLEL_BLOCKS, serpent_ecb_enc_8way_avx);
+	ECB_BLOCK(1, __serpent_encrypt);
+	ECB_WALK_END();
 }
 
 static int ecb_decrypt(struct skcipher_request *req)
 {
-	return glue_ecb_req_128bit(&serpent_dec, req);
+	ECB_WALK_START(req, SERPENT_BLOCK_SIZE, SERPENT_PARALLEL_BLOCKS);
+	ECB_BLOCK(SERPENT_PARALLEL_BLOCKS, serpent_ecb_dec_8way_avx);
+	ECB_BLOCK(1, __serpent_decrypt);
+	ECB_WALK_END();
 }
 
 static int cbc_encrypt(struct skcipher_request *req)
 {
-	return glue_cbc_encrypt_req_128bit(__serpent_encrypt, req);
+	CBC_WALK_START(req, SERPENT_BLOCK_SIZE, -1);
+	CBC_ENC_BLOCK(__serpent_encrypt);
+	CBC_WALK_END();
 }
 
 static int cbc_decrypt(struct skcipher_request *req)
 {
-	return glue_cbc_decrypt_req_128bit(&serpent_dec_cbc, req);
+	CBC_WALK_START(req, SERPENT_BLOCK_SIZE, SERPENT_PARALLEL_BLOCKS);
+	CBC_DEC_BLOCK(SERPENT_PARALLEL_BLOCKS, serpent_cbc_dec_8way_avx);
+	CBC_DEC_BLOCK(1, __serpent_decrypt);
+	CBC_WALK_END();
 }
 
 static struct skcipher_alg serpent_algs[] = {
diff --git a/arch/x86/crypto/serpent_sse2_glue.c b/arch/x86/crypto/serpent_sse2_glue.c
index 9acb3bf28feb..e28d60949c16 100644
--- a/arch/x86/crypto/serpent_sse2_glue.c
+++ b/arch/x86/crypto/serpent_sse2_glue.c
@@ -21,7 +21,8 @@
 #include <crypto/internal/simd.h>
 #include <crypto/serpent.h>
 #include <asm/crypto/serpent-sse2.h>
-#include <asm/crypto/glue_helper.h>
+
+#include "ecb_cbc_helpers.h"
 
 static int serpent_setkey_skcipher(struct crypto_skcipher *tfm,
 				   const u8 *key, unsigned int keylen)
@@ -29,80 +30,46 @@ static int serpent_setkey_skcipher(struct crypto_skcipher *tfm,
 	return __serpent_setkey(crypto_skcipher_ctx(tfm), key, keylen);
 }
 
-static void serpent_decrypt_cbc_xway(const void *ctx, u8 *d, const u8 *s)
+static void serpent_decrypt_cbc_xway(const void *ctx, u8 *dst, const u8 *src)
 {
-	u128 ivs[SERPENT_PARALLEL_BLOCKS - 1];
-	u128 *dst = (u128 *)d;
-	const u128 *src = (const u128 *)s;
-	unsigned int j;
-
-	for (j = 0; j < SERPENT_PARALLEL_BLOCKS - 1; j++)
-		ivs[j] = src[j];
+	u8 buf[SERPENT_PARALLEL_BLOCKS - 1][SERPENT_BLOCK_SIZE];
+	const u8 *s = src;
 
-	serpent_dec_blk_xway(ctx, (u8 *)dst, (u8 *)src);
-
-	for (j = 0; j < SERPENT_PARALLEL_BLOCKS - 1; j++)
-		u128_xor(dst + (j + 1), dst + (j + 1), ivs + j);
+	if (dst == src)
+		s = memcpy(buf, src, sizeof(buf));
+	serpent_dec_blk_xway(ctx, dst, src);
+	crypto_xor(dst + SERPENT_BLOCK_SIZE, s, sizeof(buf));
 }
 
-static const struct common_glue_ctx serpent_enc = {
-	.num_funcs = 2,
-	.fpu_blocks_limit = SERPENT_PARALLEL_BLOCKS,
-
-	.funcs = { {
-		.num_blocks = SERPENT_PARALLEL_BLOCKS,
-		.fn_u = { .ecb = serpent_enc_blk_xway }
-	}, {
-		.num_blocks = 1,
-		.fn_u = { .ecb = __serpent_encrypt }
-	} }
-};
-
-static const struct common_glue_ctx serpent_dec = {
-	.num_funcs = 2,
-	.fpu_blocks_limit = SERPENT_PARALLEL_BLOCKS,
-
-	.funcs = { {
-		.num_blocks = SERPENT_PARALLEL_BLOCKS,
-		.fn_u = { .ecb = serpent_dec_blk_xway }
-	}, {
-		.num_blocks = 1,
-		.fn_u = { .ecb = __serpent_decrypt }
-	} }
-};
-
-static const struct common_glue_ctx serpent_dec_cbc = {
-	.num_funcs = 2,
-	.fpu_blocks_limit = SERPENT_PARALLEL_BLOCKS,
-
-	.funcs = { {
-		.num_blocks = SERPENT_PARALLEL_BLOCKS,
-		.fn_u = { .cbc = serpent_decrypt_cbc_xway }
-	}, {
-		.num_blocks = 1,
-		.fn_u = { .cbc = __serpent_decrypt }
-	} }
-};
-
 static int ecb_encrypt(struct skcipher_request *req)
 {
-	return glue_ecb_req_128bit(&serpent_enc, req);
+	ECB_WALK_START(req, SERPENT_BLOCK_SIZE, SERPENT_PARALLEL_BLOCKS);
+	ECB_BLOCK(SERPENT_PARALLEL_BLOCKS, serpent_enc_blk_xway);
+	ECB_BLOCK(1, __serpent_encrypt);
+	ECB_WALK_END();
 }
 
 static int ecb_decrypt(struct skcipher_request *req)
 {
-	return glue_ecb_req_128bit(&serpent_dec, req);
+	ECB_WALK_START(req, SERPENT_BLOCK_SIZE, SERPENT_PARALLEL_BLOCKS);
+	ECB_BLOCK(SERPENT_PARALLEL_BLOCKS, serpent_dec_blk_xway);
+	ECB_BLOCK(1, __serpent_decrypt);
+	ECB_WALK_END();
 }
 
 static int cbc_encrypt(struct skcipher_request *req)
 {
-	return glue_cbc_encrypt_req_128bit(__serpent_encrypt,
-					   req);
+	CBC_WALK_START(req, SERPENT_BLOCK_SIZE, -1);
+	CBC_ENC_BLOCK(__serpent_encrypt);
+	CBC_WALK_END();
 }
 
 static int cbc_decrypt(struct skcipher_request *req)
 {
-	return glue_cbc_decrypt_req_128bit(&serpent_dec_cbc, req);
+	CBC_WALK_START(req, SERPENT_BLOCK_SIZE, SERPENT_PARALLEL_BLOCKS);
+	CBC_DEC_BLOCK(SERPENT_PARALLEL_BLOCKS, serpent_decrypt_cbc_xway);
+	CBC_DEC_BLOCK(1, __serpent_decrypt);
+	CBC_WALK_END();
 }
 
 static struct skcipher_alg serpent_algs[] = {
diff --git a/crypto/Kconfig b/crypto/Kconfig
index f8518ff389bb..29dce7efc443 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1538,7 +1538,6 @@ config CRYPTO_SERPENT_SSE2_X86_64
 	tristate "Serpent cipher algorithm (x86_64/SSE2)"
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
-	select CRYPTO_GLUE_HELPER_X86
 	select CRYPTO_SERPENT
 	select CRYPTO_SIMD
 	imply CRYPTO_CTR
@@ -1558,7 +1557,6 @@ config CRYPTO_SERPENT_SSE2_586
 	tristate "Serpent cipher algorithm (i586/SSE2)"
 	depends on X86 && !64BIT
 	select CRYPTO_SKCIPHER
-	select CRYPTO_GLUE_HELPER_X86
 	select CRYPTO_SERPENT
 	select CRYPTO_SIMD
 	imply CRYPTO_CTR
@@ -1578,7 +1576,6 @@ config CRYPTO_SERPENT_AVX_X86_64
 	tristate "Serpent cipher algorithm (x86_64/AVX)"
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
-	select CRYPTO_GLUE_HELPER_X86
 	select CRYPTO_SERPENT
 	select CRYPTO_SIMD
 	imply CRYPTO_XTS
-- 
2.17.1


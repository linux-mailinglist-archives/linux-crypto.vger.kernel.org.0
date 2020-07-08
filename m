Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8A7217D21
	for <lists+linux-crypto@lfdr.de>; Wed,  8 Jul 2020 04:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgGHCoF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 7 Jul 2020 22:44:05 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59602 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728530AbgGHCoF (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 7 Jul 2020 22:44:05 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jt042-00043f-6j; Wed, 08 Jul 2020 12:44:03 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 08 Jul 2020 12:44:02 +1000
Date:   Wed, 8 Jul 2020 12:44:02 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [v3 PATCH] crypto: chacha - Add DEFINE_CHACHA_STATE macro
Message-ID: <20200708024402.GA10648@gondor.apana.org.au>
References: <20200706133733.GA6479@gondor.apana.org.au>
 <20200706190717.GB736284@gmail.com>
 <20200706223716.GA10958@gondor.apana.org.au>
 <20200708023108.GK839@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708023108.GK839@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jul 07, 2020 at 07:31:08PM -0700, Eric Biggers wrote:
> 
> Hmm, __chacha20poly1305_encrypt() already uses:
> 
> 	memzero_explicit(chacha_state, CHACHA_STATE_WORDS * sizeof(u32));
> 
> That's equivalent to CHACHA_BLOCK_SIZE now, but it would be best to use the same
> constant everywhere.  Can you pick one or the other to use?
> 
> Also, in chacha20poly1305-selftest.c there's a state array that needs to be
> converted to use the new macro:
> 
>         u32 chacha20_state[CHACHA_STATE_WORDS];

Thanks, here's v3:

---8<---
As it stands the chacha state array is made 12 bytes bigger on
x86 in order for it to be 16-byte aligned.  However, the array
is not actually aligned until it hits the x86 code.

This patch moves the alignment to where the state array is defined.
To do so a macro DEFINE_CHACHA_STATE has been added which takes
care of all the work to ensure that it is actually aligned on the
stack.

This patch also changes an awkward use of CHACHA_STATE_WORDS to
CHACHA_BLOCK_SIZE.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/arch/x86/crypto/chacha_glue.c b/arch/x86/crypto/chacha_glue.c
index 22250091cdbec..20d0252f11aa5 100644
--- a/arch/x86/crypto/chacha_glue.c
+++ b/arch/x86/crypto/chacha_glue.c
@@ -14,8 +14,6 @@
 #include <linux/module.h>
 #include <asm/simd.h>
 
-#define CHACHA_STATE_ALIGN 16
-
 asmlinkage void chacha_block_xor_ssse3(u32 *state, u8 *dst, const u8 *src,
 				       unsigned int len, int nrounds);
 asmlinkage void chacha_4block_xor_ssse3(u32 *state, u8 *dst, const u8 *src,
@@ -124,8 +122,6 @@ static void chacha_dosimd(u32 *state, u8 *dst, const u8 *src,
 
 void hchacha_block_arch(const u32 *state, u32 *stream, int nrounds)
 {
-	state = PTR_ALIGN(state, CHACHA_STATE_ALIGN);
-
 	if (!static_branch_likely(&chacha_use_simd) || !crypto_simd_usable()) {
 		hchacha_block_generic(state, stream, nrounds);
 	} else {
@@ -138,8 +134,6 @@ EXPORT_SYMBOL(hchacha_block_arch);
 
 void chacha_init_arch(u32 *state, const u32 *key, const u8 *iv)
 {
-	state = PTR_ALIGN(state, CHACHA_STATE_ALIGN);
-
 	chacha_init_generic(state, key, iv);
 }
 EXPORT_SYMBOL(chacha_init_arch);
@@ -147,8 +141,6 @@ EXPORT_SYMBOL(chacha_init_arch);
 void chacha_crypt_arch(u32 *state, u8 *dst, const u8 *src, unsigned int bytes,
 		       int nrounds)
 {
-	state = PTR_ALIGN(state, CHACHA_STATE_ALIGN);
-
 	if (!static_branch_likely(&chacha_use_simd) || !crypto_simd_usable() ||
 	    bytes <= CHACHA_BLOCK_SIZE)
 		return chacha_crypt_generic(state, dst, src, bytes, nrounds);
@@ -170,15 +162,12 @@ EXPORT_SYMBOL(chacha_crypt_arch);
 static int chacha_simd_stream_xor(struct skcipher_request *req,
 				  const struct chacha_ctx *ctx, const u8 *iv)
 {
-	u32 *state, state_buf[16 + 2] __aligned(8);
+	DEFINE_CHACHA_STATE(state);
 	struct skcipher_walk walk;
 	int err;
 
 	err = skcipher_walk_virt(&walk, req, false);
 
-	BUILD_BUG_ON(CHACHA_STATE_ALIGN != 16);
-	state = PTR_ALIGN(state_buf + 0, CHACHA_STATE_ALIGN);
-
 	chacha_init_generic(state, ctx->key, iv);
 
 	while (walk.nbytes > 0) {
@@ -217,12 +206,10 @@ static int xchacha_simd(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct chacha_ctx *ctx = crypto_skcipher_ctx(tfm);
-	u32 *state, state_buf[16 + 2] __aligned(8);
+	DEFINE_CHACHA_STATE(state);
 	struct chacha_ctx subctx;
 	u8 real_iv[16];
 
-	BUILD_BUG_ON(CHACHA_STATE_ALIGN != 16);
-	state = PTR_ALIGN(state_buf + 0, CHACHA_STATE_ALIGN);
 	chacha_init_generic(state, ctx->key, req->iv);
 
 	if (req->cryptlen > CHACHA_BLOCK_SIZE && crypto_simd_usable()) {
diff --git a/include/crypto/chacha.h b/include/crypto/chacha.h
index 2676f4fbd4c16..dcc8cfe2debb9 100644
--- a/include/crypto/chacha.h
+++ b/include/crypto/chacha.h
@@ -16,7 +16,7 @@
 #define _CRYPTO_CHACHA_H
 
 #include <asm/unaligned.h>
-#include <linux/types.h>
+#include <linux/kernel.h>
 
 /* 32-bit stream position, then 96-bit nonce (RFC7539 convention) */
 #define CHACHA_IV_SIZE		16
@@ -25,10 +25,14 @@
 #define CHACHA_BLOCK_SIZE	64
 #define CHACHAPOLY_IV_SIZE	12
 
+#define CHACHA_STATE_WORDS	(CHACHA_BLOCK_SIZE / sizeof(u32))
+
 #ifdef CONFIG_X86_64
-#define CHACHA_STATE_WORDS	((CHACHA_BLOCK_SIZE + 12) / sizeof(u32))
+#define DEFINE_CHACHA_STATE(name) \
+	u32 __##name##_buf[CHACHA_STATE_WORDS + 2] __aligned(8); \
+	u32 *name = PTR_ALIGN((u32 *)__##name##_buf, 16)
 #else
-#define CHACHA_STATE_WORDS	(CHACHA_BLOCK_SIZE / sizeof(u32))
+#define DEFINE_CHACHA_STATE(name) u32 name[CHACHA_STATE_WORDS]
 #endif
 
 /* 192-bit nonce, then 64-bit stream position */
diff --git a/lib/crypto/chacha20poly1305-selftest.c b/lib/crypto/chacha20poly1305-selftest.c
index fa43deda2660d..b8569b22ef549 100644
--- a/lib/crypto/chacha20poly1305-selftest.c
+++ b/lib/crypto/chacha20poly1305-selftest.c
@@ -8832,7 +8832,7 @@ chacha20poly1305_encrypt_bignonce(u8 *dst, const u8 *src, const size_t src_len,
 {
 	const u8 *pad0 = page_address(ZERO_PAGE(0));
 	struct poly1305_desc_ctx poly1305_state;
-	u32 chacha20_state[CHACHA_STATE_WORDS];
+	DEFINE_CHACHA_STATE(chacha20_state);
 	union {
 		u8 block0[POLY1305_KEY_SIZE];
 		__le64 lens[2];
diff --git a/lib/crypto/chacha20poly1305.c b/lib/crypto/chacha20poly1305.c
index ad0699ce702f9..c6baa946ccb1a 100644
--- a/lib/crypto/chacha20poly1305.c
+++ b/lib/crypto/chacha20poly1305.c
@@ -85,7 +85,7 @@ __chacha20poly1305_encrypt(u8 *dst, const u8 *src, const size_t src_len,
 
 	poly1305_final(&poly1305_state, dst + src_len);
 
-	memzero_explicit(chacha_state, CHACHA_STATE_WORDS * sizeof(u32));
+	memzero_explicit(chacha_state, CHACHA_BLOCK_SIZE);
 	memzero_explicit(&b, sizeof(b));
 }
 
@@ -94,7 +94,7 @@ void chacha20poly1305_encrypt(u8 *dst, const u8 *src, const size_t src_len,
 			      const u64 nonce,
 			      const u8 key[CHACHA20POLY1305_KEY_SIZE])
 {
-	u32 chacha_state[CHACHA_STATE_WORDS];
+	DEFINE_CHACHA_STATE(chacha_state);
 	u32 k[CHACHA_KEY_WORDS];
 	__le64 iv[2];
 
@@ -116,7 +116,7 @@ void xchacha20poly1305_encrypt(u8 *dst, const u8 *src, const size_t src_len,
 			       const u8 nonce[XCHACHA20POLY1305_NONCE_SIZE],
 			       const u8 key[CHACHA20POLY1305_KEY_SIZE])
 {
-	u32 chacha_state[CHACHA_STATE_WORDS];
+	DEFINE_CHACHA_STATE(chacha_state);
 
 	xchacha_init(chacha_state, key, nonce);
 	__chacha20poly1305_encrypt(dst, src, src_len, ad, ad_len, chacha_state);
@@ -172,7 +172,7 @@ bool chacha20poly1305_decrypt(u8 *dst, const u8 *src, const size_t src_len,
 			      const u64 nonce,
 			      const u8 key[CHACHA20POLY1305_KEY_SIZE])
 {
-	u32 chacha_state[CHACHA_STATE_WORDS];
+	DEFINE_CHACHA_STATE(chacha_state);
 	u32 k[CHACHA_KEY_WORDS];
 	__le64 iv[2];
 	bool ret;
@@ -186,7 +186,7 @@ bool chacha20poly1305_decrypt(u8 *dst, const u8 *src, const size_t src_len,
 	ret = __chacha20poly1305_decrypt(dst, src, src_len, ad, ad_len,
 					 chacha_state);
 
-	memzero_explicit(chacha_state, sizeof(chacha_state));
+	memzero_explicit(chacha_state, CHACHA_BLOCK_SIZE);
 	memzero_explicit(iv, sizeof(iv));
 	memzero_explicit(k, sizeof(k));
 	return ret;
@@ -198,7 +198,7 @@ bool xchacha20poly1305_decrypt(u8 *dst, const u8 *src, const size_t src_len,
 			       const u8 nonce[XCHACHA20POLY1305_NONCE_SIZE],
 			       const u8 key[CHACHA20POLY1305_KEY_SIZE])
 {
-	u32 chacha_state[CHACHA_STATE_WORDS];
+	DEFINE_CHACHA_STATE(chacha_state);
 
 	xchacha_init(chacha_state, key, nonce);
 	return __chacha20poly1305_decrypt(dst, src, src_len, ad, ad_len,
@@ -216,7 +216,7 @@ bool chacha20poly1305_crypt_sg_inplace(struct scatterlist *src,
 {
 	const u8 *pad0 = page_address(ZERO_PAGE(0));
 	struct poly1305_desc_ctx poly1305_state;
-	u32 chacha_state[CHACHA_STATE_WORDS];
+	DEFINE_CHACHA_STATE(chacha_state);
 	struct sg_mapping_iter miter;
 	size_t partial = 0;
 	unsigned int flags;
@@ -328,7 +328,7 @@ bool chacha20poly1305_crypt_sg_inplace(struct scatterlist *src,
 		      !crypto_memneq(b.mac[0], b.mac[1], POLY1305_DIGEST_SIZE);
 	}
 
-	memzero_explicit(chacha_state, sizeof(chacha_state));
+	memzero_explicit(chacha_state, CHACHA_BLOCK_SIZE);
 	memzero_explicit(&b, sizeof(b));
 
 	return ret;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

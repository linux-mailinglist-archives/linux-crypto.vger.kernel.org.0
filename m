Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84542EB08C
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Jan 2021 17:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbhAEQuw (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 5 Jan 2021 11:50:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:44160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729510AbhAEQuw (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 5 Jan 2021 11:50:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FAA222CF7;
        Tue,  5 Jan 2021 16:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609865360;
        bh=ramcYp+zGue4pzvvJI1BED96WN/qqHnlkYnFH5oUiro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oH1hOHsM9TnQumxd9YKMe1MBZgDKcxtnLzC0ffK2iqDK8zL/fOAfM/I4U0/MnzRkY
         WJ7p8oNEeCljdaCmw1F/nHTicUabRo4VRPdwubUsbeyXv8PfsefTppwWwld4swGyGq
         oNk6PLoKylF3TvcQZ+PJbI34b73VsS3VR0HhtCviMwC5y3ihDyYOEJ7rmHGEzfOSKq
         AnVqbhVNtddCy6wQ8lX7/eaJ5Q8fjJP6wmJmltVUW7Gt4d8QbthfmaNf1IL/LEB7m5
         oB6zMx8c3FuOtENUmKCf6wZBIzAUSZhiJkq340mBx1Lni9H2GjfDrKsAbBZNIooof4
         duWcVZ086LBAA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Megha Dey <megha.dey@intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Milan Broz <gmazyland@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH v2 17/21] crypto: x86/cast5 - drop dependency on glue helper
Date:   Tue,  5 Jan 2021 17:48:05 +0100
Message-Id: <20210105164809.8594-18-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105164809.8594-1-ardb@kernel.org>
References: <20210105164809.8594-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Replace the glue helper dependency with implementations of ECB and CBC
based on the new CPP macros, which avoid the need for indirect calls.

Acked-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/crypto/cast5_avx_glue.c | 184 ++------------------
 1 file changed, 17 insertions(+), 167 deletions(-)

diff --git a/arch/x86/crypto/cast5_avx_glue.c b/arch/x86/crypto/cast5_avx_glue.c
index e0d1c7903b29..3976a87f92ad 100644
--- a/arch/x86/crypto/cast5_avx_glue.c
+++ b/arch/x86/crypto/cast5_avx_glue.c
@@ -6,7 +6,6 @@
  *     <Johannes.Goetzfried@informatik.stud.uni-erlangen.de>
  */
 
-#include <asm/crypto/glue_helper.h>
 #include <crypto/algapi.h>
 #include <crypto/cast5.h>
 #include <crypto/internal/simd.h>
@@ -15,6 +14,8 @@
 #include <linux/module.h>
 #include <linux/types.h>
 
+#include "ecb_cbc_helpers.h"
+
 #define CAST5_PARALLEL_BLOCKS 16
 
 asmlinkage void cast5_ecb_enc_16way(struct cast5_ctx *ctx, u8 *dst,
@@ -30,186 +31,35 @@ static int cast5_setkey_skcipher(struct crypto_skcipher *tfm, const u8 *key,
 	return cast5_setkey(&tfm->base, key, keylen);
 }
 
-static inline bool cast5_fpu_begin(bool fpu_enabled, struct skcipher_walk *walk,
-				   unsigned int nbytes)
-{
-	return glue_fpu_begin(CAST5_BLOCK_SIZE, CAST5_PARALLEL_BLOCKS,
-			      walk, fpu_enabled, nbytes);
-}
-
-static inline void cast5_fpu_end(bool fpu_enabled)
-{
-	return glue_fpu_end(fpu_enabled);
-}
-
-static int ecb_crypt(struct skcipher_request *req, bool enc)
-{
-	bool fpu_enabled = false;
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct cast5_ctx *ctx = crypto_skcipher_ctx(tfm);
-	struct skcipher_walk walk;
-	const unsigned int bsize = CAST5_BLOCK_SIZE;
-	unsigned int nbytes;
-	void (*fn)(struct cast5_ctx *ctx, u8 *dst, const u8 *src);
-	int err;
-
-	err = skcipher_walk_virt(&walk, req, false);
-
-	while ((nbytes = walk.nbytes)) {
-		u8 *wsrc = walk.src.virt.addr;
-		u8 *wdst = walk.dst.virt.addr;
-
-		fpu_enabled = cast5_fpu_begin(fpu_enabled, &walk, nbytes);
-
-		/* Process multi-block batch */
-		if (nbytes >= bsize * CAST5_PARALLEL_BLOCKS) {
-			fn = (enc) ? cast5_ecb_enc_16way : cast5_ecb_dec_16way;
-			do {
-				fn(ctx, wdst, wsrc);
-
-				wsrc += bsize * CAST5_PARALLEL_BLOCKS;
-				wdst += bsize * CAST5_PARALLEL_BLOCKS;
-				nbytes -= bsize * CAST5_PARALLEL_BLOCKS;
-			} while (nbytes >= bsize * CAST5_PARALLEL_BLOCKS);
-
-			if (nbytes < bsize)
-				goto done;
-		}
-
-		fn = (enc) ? __cast5_encrypt : __cast5_decrypt;
-
-		/* Handle leftovers */
-		do {
-			fn(ctx, wdst, wsrc);
-
-			wsrc += bsize;
-			wdst += bsize;
-			nbytes -= bsize;
-		} while (nbytes >= bsize);
-
-done:
-		err = skcipher_walk_done(&walk, nbytes);
-	}
-
-	cast5_fpu_end(fpu_enabled);
-	return err;
-}
-
 static int ecb_encrypt(struct skcipher_request *req)
 {
-	return ecb_crypt(req, true);
+	ECB_WALK_START(req, CAST5_BLOCK_SIZE, CAST5_PARALLEL_BLOCKS);
+	ECB_BLOCK(CAST5_PARALLEL_BLOCKS, cast5_ecb_enc_16way);
+	ECB_BLOCK(1, __cast5_encrypt);
+	ECB_WALK_END();
 }
 
 static int ecb_decrypt(struct skcipher_request *req)
 {
-	return ecb_crypt(req, false);
+	ECB_WALK_START(req, CAST5_BLOCK_SIZE, CAST5_PARALLEL_BLOCKS);
+	ECB_BLOCK(CAST5_PARALLEL_BLOCKS, cast5_ecb_dec_16way);
+	ECB_BLOCK(1, __cast5_decrypt);
+	ECB_WALK_END();
 }
 
 static int cbc_encrypt(struct skcipher_request *req)
 {
-	const unsigned int bsize = CAST5_BLOCK_SIZE;
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct cast5_ctx *ctx = crypto_skcipher_ctx(tfm);
-	struct skcipher_walk walk;
-	unsigned int nbytes;
-	int err;
-
-	err = skcipher_walk_virt(&walk, req, false);
-
-	while ((nbytes = walk.nbytes)) {
-		u64 *src = (u64 *)walk.src.virt.addr;
-		u64 *dst = (u64 *)walk.dst.virt.addr;
-		u64 *iv = (u64 *)walk.iv;
-
-		do {
-			*dst = *src ^ *iv;
-			__cast5_encrypt(ctx, (u8 *)dst, (u8 *)dst);
-			iv = dst;
-			src++;
-			dst++;
-			nbytes -= bsize;
-		} while (nbytes >= bsize);
-
-		*(u64 *)walk.iv = *iv;
-		err = skcipher_walk_done(&walk, nbytes);
-	}
-
-	return err;
-}
-
-static unsigned int __cbc_decrypt(struct cast5_ctx *ctx,
-				  struct skcipher_walk *walk)
-{
-	const unsigned int bsize = CAST5_BLOCK_SIZE;
-	unsigned int nbytes = walk->nbytes;
-	u64 *src = (u64 *)walk->src.virt.addr;
-	u64 *dst = (u64 *)walk->dst.virt.addr;
-	u64 last_iv;
-
-	/* Start of the last block. */
-	src += nbytes / bsize - 1;
-	dst += nbytes / bsize - 1;
-
-	last_iv = *src;
-
-	/* Process multi-block batch */
-	if (nbytes >= bsize * CAST5_PARALLEL_BLOCKS) {
-		do {
-			nbytes -= bsize * (CAST5_PARALLEL_BLOCKS - 1);
-			src -= CAST5_PARALLEL_BLOCKS - 1;
-			dst -= CAST5_PARALLEL_BLOCKS - 1;
-
-			cast5_cbc_dec_16way(ctx, (u8 *)dst, (u8 *)src);
-
-			nbytes -= bsize;
-			if (nbytes < bsize)
-				goto done;
-
-			*dst ^= *(src - 1);
-			src -= 1;
-			dst -= 1;
-		} while (nbytes >= bsize * CAST5_PARALLEL_BLOCKS);
-	}
-
-	/* Handle leftovers */
-	for (;;) {
-		__cast5_decrypt(ctx, (u8 *)dst, (u8 *)src);
-
-		nbytes -= bsize;
-		if (nbytes < bsize)
-			break;
-
-		*dst ^= *(src - 1);
-		src -= 1;
-		dst -= 1;
-	}
-
-done:
-	*dst ^= *(u64 *)walk->iv;
-	*(u64 *)walk->iv = last_iv;
-
-	return nbytes;
+	CBC_WALK_START(req, CAST5_BLOCK_SIZE, -1);
+	CBC_ENC_BLOCK(__cast5_encrypt);
+	CBC_WALK_END();
 }
 
 static int cbc_decrypt(struct skcipher_request *req)
 {
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct cast5_ctx *ctx = crypto_skcipher_ctx(tfm);
-	bool fpu_enabled = false;
-	struct skcipher_walk walk;
-	unsigned int nbytes;
-	int err;
-
-	err = skcipher_walk_virt(&walk, req, false);
-
-	while ((nbytes = walk.nbytes)) {
-		fpu_enabled = cast5_fpu_begin(fpu_enabled, &walk, nbytes);
-		nbytes = __cbc_decrypt(ctx, &walk);
-		err = skcipher_walk_done(&walk, nbytes);
-	}
-
-	cast5_fpu_end(fpu_enabled);
-	return err;
+	CBC_WALK_START(req, CAST5_BLOCK_SIZE, CAST5_PARALLEL_BLOCKS);
+	CBC_DEC_BLOCK(CAST5_PARALLEL_BLOCKS, cast5_cbc_dec_16way);
+	CBC_DEC_BLOCK(1, __cast5_decrypt);
+	CBC_WALK_END();
 }
 
 static struct skcipher_alg cast5_algs[] = {
-- 
2.17.1


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A4E391470
	for <lists+linux-crypto@lfdr.de>; Wed, 26 May 2021 12:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhEZKJI (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 26 May 2021 06:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233771AbhEZKJH (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 26 May 2021 06:09:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 033BD6124C;
        Wed, 26 May 2021 10:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622023656;
        bh=GRl77FY0MNG/tyz4J+RivEDKCEfrHh5ZhI6D2OCWqB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZFlxdqhpKVAUZdk90CHzVJrSt5JhlL9d6fem02GR/fm9K0h4J5/EJ3Fvdov0KuYVT
         HL8093muumEli79EXaJPX8jiiWtvrOb5aH62xMUA/uZ2q+5evtqfvVPErfkEh/U9kS
         S1phVvcFeeLw5rMNXP0yksZM1jR1634ZmQEj3aPnI5BS5ANhF9iGoto3Od5DdbxEbi
         QYuVgHR8h3x20QuvZRgpc5MDmRN2d8EJa58qmJC6G/wlUWQ72RFhBOYT05acJk9TKe
         Uj/OwF5XTse6z41WhB2KF5twgc81qcfAJRCjIV1Az+jgnXIfThn354sFlzfR0kC5Et
         kWiRiATKHq1kQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, will@kernel.org,
        kernel-team@android.com, Ard Biesheuvel <ardb@kernel.org>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH v6 1/6] crypto: arm64/gcm-aes-ce - remove non-SIMD fallback path
Date:   Wed, 26 May 2021 12:07:24 +0200
Message-Id: <20210526100729.12939-2-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210526100729.12939-1-ardb@kernel.org>
References: <20210526100729.12939-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Now that kernel mode SIMD is guaranteed to be available when executing
in task or softirq context, we no longer need scalar fallbacks to use
when the NEON is unavailable. So get rid of them.

Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/crypto/ghash-ce-glue.c | 209 +++++---------------
 1 file changed, 51 insertions(+), 158 deletions(-)

diff --git a/arch/arm64/crypto/ghash-ce-glue.c b/arch/arm64/crypto/ghash-ce-glue.c
index 720cd3a58da3..15794fe21a0b 100644
--- a/arch/arm64/crypto/ghash-ce-glue.c
+++ b/arch/arm64/crypto/ghash-ce-glue.c
@@ -362,84 +362,36 @@ static int gcm_encrypt(struct aead_request *req)
 
 	err = skcipher_walk_aead_encrypt(&walk, req, false);
 
-	if (likely(crypto_simd_usable())) {
-		do {
-			const u8 *src = walk.src.virt.addr;
-			u8 *dst = walk.dst.virt.addr;
-			int nbytes = walk.nbytes;
-
-			tag = (u8 *)&lengths;
-
-			if (unlikely(nbytes > 0 && nbytes < AES_BLOCK_SIZE)) {
-				src = dst = memcpy(buf + sizeof(buf) - nbytes,
-						   src, nbytes);
-			} else if (nbytes < walk.total) {
-				nbytes &= ~(AES_BLOCK_SIZE - 1);
-				tag = NULL;
-			}
-
-			kernel_neon_begin();
-			pmull_gcm_encrypt(nbytes, dst, src, ctx->ghash_key.h,
-					  dg, iv, ctx->aes_key.key_enc, nrounds,
-					  tag);
-			kernel_neon_end();
-
-			if (unlikely(!nbytes))
-				break;
-
-			if (unlikely(nbytes > 0 && nbytes < AES_BLOCK_SIZE))
-				memcpy(walk.dst.virt.addr,
-				       buf + sizeof(buf) - nbytes, nbytes);
-
-			err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
-		} while (walk.nbytes);
-	} else {
-		while (walk.nbytes >= AES_BLOCK_SIZE) {
-			int blocks = walk.nbytes / AES_BLOCK_SIZE;
-			const u8 *src = walk.src.virt.addr;
-			u8 *dst = walk.dst.virt.addr;
-			int remaining = blocks;
-
-			do {
-				aes_encrypt(&ctx->aes_key, buf, iv);
-				crypto_xor_cpy(dst, src, buf, AES_BLOCK_SIZE);
-				crypto_inc(iv, AES_BLOCK_SIZE);
-
-				dst += AES_BLOCK_SIZE;
-				src += AES_BLOCK_SIZE;
-			} while (--remaining > 0);
-
-			ghash_do_update(blocks, dg, walk.dst.virt.addr,
-					&ctx->ghash_key, NULL);
-
-			err = skcipher_walk_done(&walk,
-						 walk.nbytes % AES_BLOCK_SIZE);
-		}
-
-		/* handle the tail */
-		if (walk.nbytes) {
-			aes_encrypt(&ctx->aes_key, buf, iv);
+	do {
+		const u8 *src = walk.src.virt.addr;
+		u8 *dst = walk.dst.virt.addr;
+		int nbytes = walk.nbytes;
 
-			crypto_xor_cpy(walk.dst.virt.addr, walk.src.virt.addr,
-				       buf, walk.nbytes);
+		tag = (u8 *)&lengths;
 
-			memcpy(buf, walk.dst.virt.addr, walk.nbytes);
-			memset(buf + walk.nbytes, 0, sizeof(buf) - walk.nbytes);
+		if (unlikely(nbytes > 0 && nbytes < AES_BLOCK_SIZE)) {
+			src = dst = memcpy(buf + sizeof(buf) - nbytes,
+					   src, nbytes);
+		} else if (nbytes < walk.total) {
+			nbytes &= ~(AES_BLOCK_SIZE - 1);
+			tag = NULL;
 		}
 
-		tag = (u8 *)&lengths;
-		ghash_do_update(1, dg, tag, &ctx->ghash_key,
-				walk.nbytes ? buf : NULL);
+		kernel_neon_begin();
+		pmull_gcm_encrypt(nbytes, dst, src, ctx->ghash_key.h,
+				  dg, iv, ctx->aes_key.key_enc, nrounds,
+				  tag);
+		kernel_neon_end();
 
-		if (walk.nbytes)
-			err = skcipher_walk_done(&walk, 0);
+		if (unlikely(!nbytes))
+			break;
 
-		put_unaligned_be64(dg[1], tag);
-		put_unaligned_be64(dg[0], tag + 8);
-		put_unaligned_be32(1, iv + GCM_IV_SIZE);
-		aes_encrypt(&ctx->aes_key, iv, iv);
-		crypto_xor(tag, iv, AES_BLOCK_SIZE);
-	}
+		if (unlikely(nbytes > 0 && nbytes < AES_BLOCK_SIZE))
+			memcpy(walk.dst.virt.addr,
+			       buf + sizeof(buf) - nbytes, nbytes);
+
+		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
+	} while (walk.nbytes);
 
 	if (err)
 		return err;
@@ -464,6 +416,7 @@ static int gcm_decrypt(struct aead_request *req)
 	u64 dg[2] = {};
 	be128 lengths;
 	u8 *tag;
+	int ret;
 	int err;
 
 	lengths.a = cpu_to_be64(req->assoclen * 8);
@@ -481,101 +434,41 @@ static int gcm_decrypt(struct aead_request *req)
 
 	err = skcipher_walk_aead_decrypt(&walk, req, false);
 
-	if (likely(crypto_simd_usable())) {
-		int ret;
-
-		do {
-			const u8 *src = walk.src.virt.addr;
-			u8 *dst = walk.dst.virt.addr;
-			int nbytes = walk.nbytes;
-
-			tag = (u8 *)&lengths;
-
-			if (unlikely(nbytes > 0 && nbytes < AES_BLOCK_SIZE)) {
-				src = dst = memcpy(buf + sizeof(buf) - nbytes,
-						   src, nbytes);
-			} else if (nbytes < walk.total) {
-				nbytes &= ~(AES_BLOCK_SIZE - 1);
-				tag = NULL;
-			}
-
-			kernel_neon_begin();
-			ret = pmull_gcm_decrypt(nbytes, dst, src,
-						ctx->ghash_key.h,
-						dg, iv, ctx->aes_key.key_enc,
-						nrounds, tag, otag, authsize);
-			kernel_neon_end();
-
-			if (unlikely(!nbytes))
-				break;
-
-			if (unlikely(nbytes > 0 && nbytes < AES_BLOCK_SIZE))
-				memcpy(walk.dst.virt.addr,
-				       buf + sizeof(buf) - nbytes, nbytes);
-
-			err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
-		} while (walk.nbytes);
-
-		if (err)
-			return err;
-		if (ret)
-			return -EBADMSG;
-	} else {
-		while (walk.nbytes >= AES_BLOCK_SIZE) {
-			int blocks = walk.nbytes / AES_BLOCK_SIZE;
-			const u8 *src = walk.src.virt.addr;
-			u8 *dst = walk.dst.virt.addr;
-
-			ghash_do_update(blocks, dg, walk.src.virt.addr,
-					&ctx->ghash_key, NULL);
-
-			do {
-				aes_encrypt(&ctx->aes_key, buf, iv);
-				crypto_xor_cpy(dst, src, buf, AES_BLOCK_SIZE);
-				crypto_inc(iv, AES_BLOCK_SIZE);
-
-				dst += AES_BLOCK_SIZE;
-				src += AES_BLOCK_SIZE;
-			} while (--blocks > 0);
+	do {
+		const u8 *src = walk.src.virt.addr;
+		u8 *dst = walk.dst.virt.addr;
+		int nbytes = walk.nbytes;
 
-			err = skcipher_walk_done(&walk,
-						 walk.nbytes % AES_BLOCK_SIZE);
-		}
+		tag = (u8 *)&lengths;
 
-		/* handle the tail */
-		if (walk.nbytes) {
-			memcpy(buf, walk.src.virt.addr, walk.nbytes);
-			memset(buf + walk.nbytes, 0, sizeof(buf) - walk.nbytes);
+		if (unlikely(nbytes > 0 && nbytes < AES_BLOCK_SIZE)) {
+			src = dst = memcpy(buf + sizeof(buf) - nbytes,
+					   src, nbytes);
+		} else if (nbytes < walk.total) {
+			nbytes &= ~(AES_BLOCK_SIZE - 1);
+			tag = NULL;
 		}
 
-		tag = (u8 *)&lengths;
-		ghash_do_update(1, dg, tag, &ctx->ghash_key,
-				walk.nbytes ? buf : NULL);
-
-		if (walk.nbytes) {
-			aes_encrypt(&ctx->aes_key, buf, iv);
+		kernel_neon_begin();
+		ret = pmull_gcm_decrypt(nbytes, dst, src, ctx->ghash_key.h,
+					dg, iv, ctx->aes_key.key_enc,
+					nrounds, tag, otag, authsize);
+		kernel_neon_end();
 
-			crypto_xor_cpy(walk.dst.virt.addr, walk.src.virt.addr,
-				       buf, walk.nbytes);
+		if (unlikely(!nbytes))
+			break;
 
-			err = skcipher_walk_done(&walk, 0);
-		}
+		if (unlikely(nbytes > 0 && nbytes < AES_BLOCK_SIZE))
+			memcpy(walk.dst.virt.addr,
+			       buf + sizeof(buf) - nbytes, nbytes);
 
-		if (err)
-			return err;
+		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
+	} while (walk.nbytes);
 
-		put_unaligned_be64(dg[1], tag);
-		put_unaligned_be64(dg[0], tag + 8);
-		put_unaligned_be32(1, iv + GCM_IV_SIZE);
-		aes_encrypt(&ctx->aes_key, iv, iv);
-		crypto_xor(tag, iv, AES_BLOCK_SIZE);
+	if (err)
+		return err;
 
-		if (crypto_memneq(tag, otag, authsize)) {
-			memzero_explicit(tag, AES_BLOCK_SIZE);
-			return -EBADMSG;
-		}
-	}
-	return 0;
+	return ret ? -EBADMSG : 0;
 }
 
 static struct aead_alg gcm_aes_alg = {
-- 
2.20.1


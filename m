Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4B92ADF0A
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Nov 2020 20:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbgKJTEx (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 10 Nov 2020 14:04:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:51110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730775AbgKJTEx (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 10 Nov 2020 14:04:53 -0500
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE30C20809;
        Tue, 10 Nov 2020 19:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605035093;
        bh=gSZR+Ff7g9spBCQz3eQtudFEpCncWXr4csxZH83Oho4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VU2hR9WEh476uvS/e1gXp58RBaUOVKZ9vENCuZ+tYXQqKIpwe7qrSOR7iTyTaptCf
         NnZ4DG9+8JWPz/t1/Dbg5OEBsaJ1IW1VUB6AbaR8YXxhkAFs9EnuDjPEhV81uvcWNQ
         MS1CEKBHyweCfdGP1qHLO6y/b/m05RKK/zwP+Wng=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, Ard Biesheuvel <ardb@kernel.org>,
        Ondrej Mosnacek <omosnacek@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 1/4] crypto: aegis128 - wipe plaintext and tag if decryption fails
Date:   Tue, 10 Nov 2020 20:04:41 +0100
Message-Id: <20201110190444.10634-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201110190444.10634-1-ardb@kernel.org>
References: <20201110190444.10634-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The AEGIS spec mentions explicitly that the security guarantees hold
only if the resulting plaintext and tag of a failed decryption are
not disclosed. So ensure that we abide by this.

While at it, drop the unused struct aead_request *req parameter from
crypto_aegis128_process_crypt().

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 crypto/aegis128-core.c | 32 ++++++++++++++++----
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/crypto/aegis128-core.c b/crypto/aegis128-core.c
index 44fb4956f0dd..3a71235892f5 100644
--- a/crypto/aegis128-core.c
+++ b/crypto/aegis128-core.c
@@ -154,6 +154,12 @@ static void crypto_aegis128_ad(struct aegis_state *state,
 	}
 }
 
+static void crypto_aegis128_wipe_chunk(struct aegis_state *state, u8 *dst,
+				       const u8 *src, unsigned int size)
+{
+	memzero_explicit(dst, size);
+}
+
 static void crypto_aegis128_encrypt_chunk(struct aegis_state *state, u8 *dst,
 					  const u8 *src, unsigned int size)
 {
@@ -324,7 +330,6 @@ static void crypto_aegis128_process_ad(struct aegis_state *state,
 
 static __always_inline
 int crypto_aegis128_process_crypt(struct aegis_state *state,
-				  struct aead_request *req,
 				  struct skcipher_walk *walk,
 				  void (*crypt)(struct aegis_state *state,
 					        u8 *dst, const u8 *src,
@@ -403,14 +408,14 @@ static int crypto_aegis128_encrypt(struct aead_request *req)
 	if (aegis128_do_simd()) {
 		crypto_aegis128_init_simd(&state, &ctx->key, req->iv);
 		crypto_aegis128_process_ad(&state, req->src, req->assoclen);
-		crypto_aegis128_process_crypt(&state, req, &walk,
+		crypto_aegis128_process_crypt(&state, &walk,
 					      crypto_aegis128_encrypt_chunk_simd);
 		crypto_aegis128_final_simd(&state, &tag, req->assoclen,
 					   cryptlen);
 	} else {
 		crypto_aegis128_init(&state, &ctx->key, req->iv);
 		crypto_aegis128_process_ad(&state, req->src, req->assoclen);
-		crypto_aegis128_process_crypt(&state, req, &walk,
+		crypto_aegis128_process_crypt(&state, &walk,
 					      crypto_aegis128_encrypt_chunk);
 		crypto_aegis128_final(&state, &tag, req->assoclen, cryptlen);
 	}
@@ -438,19 +443,34 @@ static int crypto_aegis128_decrypt(struct aead_request *req)
 	if (aegis128_do_simd()) {
 		crypto_aegis128_init_simd(&state, &ctx->key, req->iv);
 		crypto_aegis128_process_ad(&state, req->src, req->assoclen);
-		crypto_aegis128_process_crypt(&state, req, &walk,
+		crypto_aegis128_process_crypt(&state, &walk,
 					      crypto_aegis128_decrypt_chunk_simd);
 		crypto_aegis128_final_simd(&state, &tag, req->assoclen,
 					   cryptlen);
 	} else {
 		crypto_aegis128_init(&state, &ctx->key, req->iv);
 		crypto_aegis128_process_ad(&state, req->src, req->assoclen);
-		crypto_aegis128_process_crypt(&state, req, &walk,
+		crypto_aegis128_process_crypt(&state, &walk,
 					      crypto_aegis128_decrypt_chunk);
 		crypto_aegis128_final(&state, &tag, req->assoclen, cryptlen);
 	}
 
-	return crypto_memneq(tag.bytes, zeros, authsize) ? -EBADMSG : 0;
+	if (unlikely(crypto_memneq(tag.bytes, zeros, authsize))) {
+		/*
+		 * From Chapter 4. 'Security Analysis' of the AEGIS spec [0]
+		 *
+		 * "3. If verification fails, the decrypted plaintext and the
+		 *     wrong authentication tag should not be given as output."
+		 *
+		 * [0] https://competitions.cr.yp.to/round3/aegisv11.pdf
+		 */
+		skcipher_walk_aead_decrypt(&walk, req, false);
+		crypto_aegis128_process_crypt(NULL, &walk,
+					      crypto_aegis128_wipe_chunk);
+		memzero_explicit(&tag, sizeof(tag));
+		return -EBADMSG;
+	}
+	return 0;
 }
 
 static struct aead_alg crypto_aegis128_alg = {
-- 
2.17.1


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071452B64DD
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Nov 2020 14:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733267AbgKQNu2 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 17 Nov 2020 08:50:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732324AbgKQNcn (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 17 Nov 2020 08:32:43 -0500
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 238B7207BC;
        Tue, 17 Nov 2020 13:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605619962;
        bh=5TM+nvyVaaEjZdNFdJSIc1Owr0opm4PwH+sR4gtEzSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sRg/MqDR46Hmq9ICFWqnyKBMAiZmvaG51QO/czEYr2d6q1/0bwkeDVxKbmY6GqWnD
         JslpMiw3dWPuSLg3OK6WB+7skicXBTlk+0RI0XrMt7u4KOoBECfHECfR0keZpsZPgR
         1HESKj5P4PZRWSm2b/8vUsYl5egR92zszYTp5HOA=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Ondrej Mosnacek <omosnacek@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v3 3/4] crypto: aegis128/neon - move final tag check to SIMD domain
Date:   Tue, 17 Nov 2020 14:32:13 +0100
Message-Id: <20201117133214.29114-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117133214.29114-1-ardb@kernel.org>
References: <20201117133214.29114-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Instead of calculating the tag and returning it to the caller on
decryption, use a SIMD compare and min across vector to perform
the comparison. This is slightly more efficient, and removes the
need on the caller's part to wipe the tag from memory if the
decryption failed.

While at it, switch to unsigned int when passing cryptlen and
assoclen - we don't support input sizes where it matters anyway.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 crypto/aegis128-core.c       | 21 +++++++++----
 crypto/aegis128-neon-inner.c | 33 ++++++++++++++++----
 crypto/aegis128-neon.c       | 21 +++++++++----
 3 files changed, 57 insertions(+), 18 deletions(-)

diff --git a/crypto/aegis128-core.c b/crypto/aegis128-core.c
index 3a71235892f5..859c7b905618 100644
--- a/crypto/aegis128-core.c
+++ b/crypto/aegis128-core.c
@@ -67,9 +67,11 @@ void crypto_aegis128_encrypt_chunk_simd(struct aegis_state *state, u8 *dst,
 					const u8 *src, unsigned int size);
 void crypto_aegis128_decrypt_chunk_simd(struct aegis_state *state, u8 *dst,
 					const u8 *src, unsigned int size);
-void crypto_aegis128_final_simd(struct aegis_state *state,
-				union aegis_block *tag_xor,
-				u64 assoclen, u64 cryptlen);
+int crypto_aegis128_final_simd(struct aegis_state *state,
+			       union aegis_block *tag_xor,
+			       unsigned int assoclen,
+			       unsigned int cryptlen,
+			       unsigned int authsize);
 
 static void crypto_aegis128_update(struct aegis_state *state)
 {
@@ -411,7 +413,7 @@ static int crypto_aegis128_encrypt(struct aead_request *req)
 		crypto_aegis128_process_crypt(&state, &walk,
 					      crypto_aegis128_encrypt_chunk_simd);
 		crypto_aegis128_final_simd(&state, &tag, req->assoclen,
-					   cryptlen);
+					   cryptlen, 0);
 	} else {
 		crypto_aegis128_init(&state, &ctx->key, req->iv);
 		crypto_aegis128_process_ad(&state, req->src, req->assoclen);
@@ -445,8 +447,15 @@ static int crypto_aegis128_decrypt(struct aead_request *req)
 		crypto_aegis128_process_ad(&state, req->src, req->assoclen);
 		crypto_aegis128_process_crypt(&state, &walk,
 					      crypto_aegis128_decrypt_chunk_simd);
-		crypto_aegis128_final_simd(&state, &tag, req->assoclen,
-					   cryptlen);
+		if (unlikely(crypto_aegis128_final_simd(&state, &tag,
+							req->assoclen,
+							cryptlen, authsize))) {
+			skcipher_walk_aead_decrypt(&walk, req, false);
+			crypto_aegis128_process_crypt(NULL, req, &walk,
+						      crypto_aegis128_wipe_chunk);
+			return -EBADMSG;
+		}
+		return 0;
 	} else {
 		crypto_aegis128_init(&state, &ctx->key, req->iv);
 		crypto_aegis128_process_ad(&state, req->src, req->assoclen);
diff --git a/crypto/aegis128-neon-inner.c b/crypto/aegis128-neon-inner.c
index cd1b3ad1d1f3..7de485907d81 100644
--- a/crypto/aegis128-neon-inner.c
+++ b/crypto/aegis128-neon-inner.c
@@ -199,6 +199,17 @@ static uint8x16_t vqtbx1q_u8(uint8x16_t v, uint8x16_t a, uint8x16_t b)
 	return vcombine_u8(vtbx2_u8(vget_low_u8(v), __a.pair, vget_low_u8(b)),
 			   vtbx2_u8(vget_high_u8(v), __a.pair, vget_high_u8(b)));
 }
+
+static int8_t vminvq_s8(int8x16_t v)
+{
+	int8x8_t s = vpmin_s8(vget_low_s8(v), vget_high_s8(v));
+
+	s = vpmin_s8(s, s);
+	s = vpmin_s8(s, s);
+	s = vpmin_s8(s, s);
+
+	return vget_lane_s8(s, 0);
+}
 #endif
 
 static const uint8_t permute[] __aligned(64) = {
@@ -302,8 +313,10 @@ void crypto_aegis128_decrypt_chunk_neon(void *state, void *dst, const void *src,
 	aegis128_save_state_neon(st, state);
 }
 
-void crypto_aegis128_final_neon(void *state, void *tag_xor, uint64_t assoclen,
-				uint64_t cryptlen)
+int crypto_aegis128_final_neon(void *state, void *tag_xor,
+			       unsigned int assoclen,
+			       unsigned int cryptlen,
+			       unsigned int authsize)
 {
 	struct aegis128_state st = aegis128_load_state_neon(state);
 	uint8x16_t v;
@@ -311,13 +324,21 @@ void crypto_aegis128_final_neon(void *state, void *tag_xor, uint64_t assoclen,
 
 	preload_sbox();
 
-	v = st.v[3] ^ (uint8x16_t)vcombine_u64(vmov_n_u64(8 * assoclen),
-					       vmov_n_u64(8 * cryptlen));
+	v = st.v[3] ^ (uint8x16_t)vcombine_u64(vmov_n_u64(8ULL * assoclen),
+					       vmov_n_u64(8ULL * cryptlen));
 
 	for (i = 0; i < 7; i++)
 		st = aegis128_update_neon(st, v);
 
-	v = vld1q_u8(tag_xor);
-	v ^= st.v[0] ^ st.v[1] ^ st.v[2] ^ st.v[3] ^ st.v[4];
+	v = st.v[0] ^ st.v[1] ^ st.v[2] ^ st.v[3] ^ st.v[4];
+
+	if (authsize > 0) {
+		v = vqtbl1q_u8(~vceqq_u8(v, vld1q_u8(tag_xor)),
+			       vld1q_u8(permute + authsize));
+
+		return vminvq_s8((int8x16_t)v);
+	}
+
 	vst1q_u8(tag_xor, v);
+	return 0;
 }
diff --git a/crypto/aegis128-neon.c b/crypto/aegis128-neon.c
index 8271b1fa0fbc..94d591a002a4 100644
--- a/crypto/aegis128-neon.c
+++ b/crypto/aegis128-neon.c
@@ -14,8 +14,10 @@ void crypto_aegis128_encrypt_chunk_neon(void *state, void *dst, const void *src,
 					unsigned int size);
 void crypto_aegis128_decrypt_chunk_neon(void *state, void *dst, const void *src,
 					unsigned int size);
-void crypto_aegis128_final_neon(void *state, void *tag_xor, uint64_t assoclen,
-				uint64_t cryptlen);
+int crypto_aegis128_final_neon(void *state, void *tag_xor,
+			       unsigned int assoclen,
+			       unsigned int cryptlen,
+			       unsigned int authsize);
 
 int aegis128_have_aes_insn __ro_after_init;
 
@@ -60,11 +62,18 @@ void crypto_aegis128_decrypt_chunk_simd(union aegis_block *state, u8 *dst,
 	kernel_neon_end();
 }
 
-void crypto_aegis128_final_simd(union aegis_block *state,
-				union aegis_block *tag_xor,
-				u64 assoclen, u64 cryptlen)
+int crypto_aegis128_final_simd(union aegis_block *state,
+			       union aegis_block *tag_xor,
+			       unsigned int assoclen,
+			       unsigned int cryptlen,
+			       unsigned int authsize)
 {
+	int ret;
+
 	kernel_neon_begin();
-	crypto_aegis128_final_neon(state, tag_xor, assoclen, cryptlen);
+	ret = crypto_aegis128_final_neon(state, tag_xor, assoclen, cryptlen,
+					 authsize);
 	kernel_neon_end();
+
+	return ret;
 }
-- 
2.17.1


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC50F4B6C
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Nov 2019 13:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732340AbfKHMXk (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 Nov 2019 07:23:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:38082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727598AbfKHMXk (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 8 Nov 2019 07:23:40 -0500
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr [92.154.90.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F73B2246A;
        Fri,  8 Nov 2019 12:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573215818;
        bh=2nuv9VXQtOzHeFCmAQiXqvGQoB1SvQPZxiEOErY3Lwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d1+l/DiFNMIuSANtPeYmu7O0avsh9wMxX7Clb3VyKI/kttomy/4fT+ML+JuYI24N2
         P2ifsJp1RYsPaQixQ5/HDDRyyxRePLqnqJRlCkeDjUiVvdrY+zzoCeGnJvbnZPh5kI
         zmh/iBM65hYuYTtzykeAQpze7MwS/euHcG3Lv9xs=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Martin Willi <martin@strongswan.org>,
        Rene van Dorst <opensource@vdorst.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v5 13/34] crypto: poly1305 - move core routines into a separate library
Date:   Fri,  8 Nov 2019 13:22:19 +0100
Message-Id: <20191108122240.28479-14-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108122240.28479-1-ardb@kernel.org>
References: <20191108122240.28479-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Move the core Poly1305 routines shared between the generic Poly1305
shash driver and the Adiantum and NHPoly1305 drivers into a separate
library so that using just this pieces does not pull in the crypto
API pieces of the generic Poly1305 routine.

In a subsequent patch, we will augment this generic library with
init/update/final routines so that Poyl1305 algorithm can be used
directly without the need for using the crypto API's shash abstraction.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/crypto/poly1305_glue.c    |   2 +-
 crypto/Kconfig                     |   5 +-
 crypto/adiantum.c                  |   5 +-
 crypto/nhpoly1305.c                |   3 +-
 crypto/poly1305_generic.c          | 195 +-------------------
 include/crypto/internal/poly1305.h |  67 +++++++
 include/crypto/poly1305.h          |  23 ---
 lib/crypto/Kconfig                 |   3 +
 lib/crypto/Makefile                |   3 +
 lib/crypto/poly1305.c              | 158 ++++++++++++++++
 10 files changed, 248 insertions(+), 216 deletions(-)

diff --git a/arch/x86/crypto/poly1305_glue.c b/arch/x86/crypto/poly1305_glue.c
index 4a1c05dce950..6ccf8eb26324 100644
--- a/arch/x86/crypto/poly1305_glue.c
+++ b/arch/x86/crypto/poly1305_glue.c
@@ -7,8 +7,8 @@
 
 #include <crypto/algapi.h>
 #include <crypto/internal/hash.h>
+#include <crypto/internal/poly1305.h>
 #include <crypto/internal/simd.h>
-#include <crypto/poly1305.h>
 #include <linux/crypto.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 34c4938febeb..362dd6ae6aca 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -446,7 +446,7 @@ config CRYPTO_KEYWRAP
 config CRYPTO_NHPOLY1305
 	tristate
 	select CRYPTO_HASH
-	select CRYPTO_POLY1305
+	select CRYPTO_LIB_POLY1305_GENERIC
 
 config CRYPTO_NHPOLY1305_SSE2
 	tristate "NHPoly1305 hash function (x86_64 SSE2 implementation)"
@@ -467,7 +467,7 @@ config CRYPTO_NHPOLY1305_AVX2
 config CRYPTO_ADIANTUM
 	tristate "Adiantum support"
 	select CRYPTO_CHACHA20
-	select CRYPTO_POLY1305
+	select CRYPTO_LIB_POLY1305_GENERIC
 	select CRYPTO_NHPOLY1305
 	select CRYPTO_MANAGER
 	help
@@ -703,6 +703,7 @@ config CRYPTO_GHASH
 config CRYPTO_POLY1305
 	tristate "Poly1305 authenticator algorithm"
 	select CRYPTO_HASH
+	select CRYPTO_LIB_POLY1305_GENERIC
 	help
 	  Poly1305 authenticator algorithm, RFC7539.
 
diff --git a/crypto/adiantum.c b/crypto/adiantum.c
index 395a3ddd3707..aded26092268 100644
--- a/crypto/adiantum.c
+++ b/crypto/adiantum.c
@@ -33,6 +33,7 @@
 #include <crypto/b128ops.h>
 #include <crypto/chacha.h>
 #include <crypto/internal/hash.h>
+#include <crypto/internal/poly1305.h>
 #include <crypto/internal/skcipher.h>
 #include <crypto/nhpoly1305.h>
 #include <crypto/scatterwalk.h>
@@ -242,11 +243,11 @@ static void adiantum_hash_header(struct skcipher_request *req)
 
 	BUILD_BUG_ON(sizeof(header) % POLY1305_BLOCK_SIZE != 0);
 	poly1305_core_blocks(&state, &tctx->header_hash_key,
-			     &header, sizeof(header) / POLY1305_BLOCK_SIZE);
+			     &header, sizeof(header) / POLY1305_BLOCK_SIZE, 1);
 
 	BUILD_BUG_ON(TWEAK_SIZE % POLY1305_BLOCK_SIZE != 0);
 	poly1305_core_blocks(&state, &tctx->header_hash_key, req->iv,
-			     TWEAK_SIZE / POLY1305_BLOCK_SIZE);
+			     TWEAK_SIZE / POLY1305_BLOCK_SIZE, 1);
 
 	poly1305_core_emit(&state, &rctx->header_hash);
 }
diff --git a/crypto/nhpoly1305.c b/crypto/nhpoly1305.c
index 9ab4e07cde4d..f6b6a52092b4 100644
--- a/crypto/nhpoly1305.c
+++ b/crypto/nhpoly1305.c
@@ -33,6 +33,7 @@
 #include <asm/unaligned.h>
 #include <crypto/algapi.h>
 #include <crypto/internal/hash.h>
+#include <crypto/internal/poly1305.h>
 #include <crypto/nhpoly1305.h>
 #include <linux/crypto.h>
 #include <linux/kernel.h>
@@ -78,7 +79,7 @@ static void process_nh_hash_value(struct nhpoly1305_state *state,
 	BUILD_BUG_ON(NH_HASH_BYTES % POLY1305_BLOCK_SIZE != 0);
 
 	poly1305_core_blocks(&state->poly_state, &key->poly_key, state->nh_hash,
-			     NH_HASH_BYTES / POLY1305_BLOCK_SIZE);
+			     NH_HASH_BYTES / POLY1305_BLOCK_SIZE, 1);
 }
 
 /*
diff --git a/crypto/poly1305_generic.c b/crypto/poly1305_generic.c
index adc40298c749..067f493c2504 100644
--- a/crypto/poly1305_generic.c
+++ b/crypto/poly1305_generic.c
@@ -13,27 +13,12 @@
 
 #include <crypto/algapi.h>
 #include <crypto/internal/hash.h>
-#include <crypto/poly1305.h>
+#include <crypto/internal/poly1305.h>
 #include <linux/crypto.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <asm/unaligned.h>
 
-static inline u64 mlt(u64 a, u64 b)
-{
-	return a * b;
-}
-
-static inline u32 sr(u64 v, u_char n)
-{
-	return v >> n;
-}
-
-static inline u32 and(u32 v, u32 mask)
-{
-	return v & mask;
-}
-
 int crypto_poly1305_init(struct shash_desc *desc)
 {
 	struct poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
@@ -47,124 +32,8 @@ int crypto_poly1305_init(struct shash_desc *desc)
 }
 EXPORT_SYMBOL_GPL(crypto_poly1305_init);
 
-void poly1305_core_setkey(struct poly1305_key *key, const u8 *raw_key)
-{
-	/* r &= 0xffffffc0ffffffc0ffffffc0fffffff */
-	key->r[0] = (get_unaligned_le32(raw_key +  0) >> 0) & 0x3ffffff;
-	key->r[1] = (get_unaligned_le32(raw_key +  3) >> 2) & 0x3ffff03;
-	key->r[2] = (get_unaligned_le32(raw_key +  6) >> 4) & 0x3ffc0ff;
-	key->r[3] = (get_unaligned_le32(raw_key +  9) >> 6) & 0x3f03fff;
-	key->r[4] = (get_unaligned_le32(raw_key + 12) >> 8) & 0x00fffff;
-}
-EXPORT_SYMBOL_GPL(poly1305_core_setkey);
-
-/*
- * Poly1305 requires a unique key for each tag, which implies that we can't set
- * it on the tfm that gets accessed by multiple users simultaneously. Instead we
- * expect the key as the first 32 bytes in the update() call.
- */
-unsigned int crypto_poly1305_setdesckey(struct poly1305_desc_ctx *dctx,
-					const u8 *src, unsigned int srclen)
-{
-	if (!dctx->sset) {
-		if (!dctx->rset && srclen >= POLY1305_BLOCK_SIZE) {
-			poly1305_core_setkey(&dctx->r, src);
-			src += POLY1305_BLOCK_SIZE;
-			srclen -= POLY1305_BLOCK_SIZE;
-			dctx->rset = true;
-		}
-		if (srclen >= POLY1305_BLOCK_SIZE) {
-			dctx->s[0] = get_unaligned_le32(src +  0);
-			dctx->s[1] = get_unaligned_le32(src +  4);
-			dctx->s[2] = get_unaligned_le32(src +  8);
-			dctx->s[3] = get_unaligned_le32(src + 12);
-			src += POLY1305_BLOCK_SIZE;
-			srclen -= POLY1305_BLOCK_SIZE;
-			dctx->sset = true;
-		}
-	}
-	return srclen;
-}
-EXPORT_SYMBOL_GPL(crypto_poly1305_setdesckey);
-
-static void poly1305_blocks_internal(struct poly1305_state *state,
-				     const struct poly1305_key *key,
-				     const void *src, unsigned int nblocks,
-				     u32 hibit)
-{
-	u32 r0, r1, r2, r3, r4;
-	u32 s1, s2, s3, s4;
-	u32 h0, h1, h2, h3, h4;
-	u64 d0, d1, d2, d3, d4;
-
-	if (!nblocks)
-		return;
-
-	r0 = key->r[0];
-	r1 = key->r[1];
-	r2 = key->r[2];
-	r3 = key->r[3];
-	r4 = key->r[4];
-
-	s1 = r1 * 5;
-	s2 = r2 * 5;
-	s3 = r3 * 5;
-	s4 = r4 * 5;
-
-	h0 = state->h[0];
-	h1 = state->h[1];
-	h2 = state->h[2];
-	h3 = state->h[3];
-	h4 = state->h[4];
-
-	do {
-		/* h += m[i] */
-		h0 += (get_unaligned_le32(src +  0) >> 0) & 0x3ffffff;
-		h1 += (get_unaligned_le32(src +  3) >> 2) & 0x3ffffff;
-		h2 += (get_unaligned_le32(src +  6) >> 4) & 0x3ffffff;
-		h3 += (get_unaligned_le32(src +  9) >> 6) & 0x3ffffff;
-		h4 += (get_unaligned_le32(src + 12) >> 8) | hibit;
-
-		/* h *= r */
-		d0 = mlt(h0, r0) + mlt(h1, s4) + mlt(h2, s3) +
-		     mlt(h3, s2) + mlt(h4, s1);
-		d1 = mlt(h0, r1) + mlt(h1, r0) + mlt(h2, s4) +
-		     mlt(h3, s3) + mlt(h4, s2);
-		d2 = mlt(h0, r2) + mlt(h1, r1) + mlt(h2, r0) +
-		     mlt(h3, s4) + mlt(h4, s3);
-		d3 = mlt(h0, r3) + mlt(h1, r2) + mlt(h2, r1) +
-		     mlt(h3, r0) + mlt(h4, s4);
-		d4 = mlt(h0, r4) + mlt(h1, r3) + mlt(h2, r2) +
-		     mlt(h3, r1) + mlt(h4, r0);
-
-		/* (partial) h %= p */
-		d1 += sr(d0, 26);     h0 = and(d0, 0x3ffffff);
-		d2 += sr(d1, 26);     h1 = and(d1, 0x3ffffff);
-		d3 += sr(d2, 26);     h2 = and(d2, 0x3ffffff);
-		d4 += sr(d3, 26);     h3 = and(d3, 0x3ffffff);
-		h0 += sr(d4, 26) * 5; h4 = and(d4, 0x3ffffff);
-		h1 += h0 >> 26;       h0 = h0 & 0x3ffffff;
-
-		src += POLY1305_BLOCK_SIZE;
-	} while (--nblocks);
-
-	state->h[0] = h0;
-	state->h[1] = h1;
-	state->h[2] = h2;
-	state->h[3] = h3;
-	state->h[4] = h4;
-}
-
-void poly1305_core_blocks(struct poly1305_state *state,
-			  const struct poly1305_key *key,
-			  const void *src, unsigned int nblocks)
-{
-	poly1305_blocks_internal(state, key, src, nblocks, 1 << 24);
-}
-EXPORT_SYMBOL_GPL(poly1305_core_blocks);
-
-static void poly1305_blocks(struct poly1305_desc_ctx *dctx,
-			    const u8 *src, unsigned int srclen, u32 hibit)
+static void poly1305_blocks(struct poly1305_desc_ctx *dctx, const u8 *src,
+			    unsigned int srclen)
 {
 	unsigned int datalen;
 
@@ -174,8 +43,8 @@ static void poly1305_blocks(struct poly1305_desc_ctx *dctx,
 		srclen = datalen;
 	}
 
-	poly1305_blocks_internal(&dctx->h, &dctx->r,
-				 src, srclen / POLY1305_BLOCK_SIZE, hibit);
+	poly1305_core_blocks(&dctx->h, &dctx->r, src,
+			     srclen / POLY1305_BLOCK_SIZE, 1);
 }
 
 int crypto_poly1305_update(struct shash_desc *desc,
@@ -193,13 +62,13 @@ int crypto_poly1305_update(struct shash_desc *desc,
 
 		if (dctx->buflen == POLY1305_BLOCK_SIZE) {
 			poly1305_blocks(dctx, dctx->buf,
-					POLY1305_BLOCK_SIZE, 1 << 24);
+					POLY1305_BLOCK_SIZE);
 			dctx->buflen = 0;
 		}
 	}
 
 	if (likely(srclen >= POLY1305_BLOCK_SIZE)) {
-		poly1305_blocks(dctx, src, srclen, 1 << 24);
+		poly1305_blocks(dctx, src, srclen);
 		src += srclen - (srclen % POLY1305_BLOCK_SIZE);
 		srclen %= POLY1305_BLOCK_SIZE;
 	}
@@ -213,54 +82,6 @@ int crypto_poly1305_update(struct shash_desc *desc,
 }
 EXPORT_SYMBOL_GPL(crypto_poly1305_update);
 
-void poly1305_core_emit(const struct poly1305_state *state, void *dst)
-{
-	u32 h0, h1, h2, h3, h4;
-	u32 g0, g1, g2, g3, g4;
-	u32 mask;
-
-	/* fully carry h */
-	h0 = state->h[0];
-	h1 = state->h[1];
-	h2 = state->h[2];
-	h3 = state->h[3];
-	h4 = state->h[4];
-
-	h2 += (h1 >> 26);     h1 = h1 & 0x3ffffff;
-	h3 += (h2 >> 26);     h2 = h2 & 0x3ffffff;
-	h4 += (h3 >> 26);     h3 = h3 & 0x3ffffff;
-	h0 += (h4 >> 26) * 5; h4 = h4 & 0x3ffffff;
-	h1 += (h0 >> 26);     h0 = h0 & 0x3ffffff;
-
-	/* compute h + -p */
-	g0 = h0 + 5;
-	g1 = h1 + (g0 >> 26);             g0 &= 0x3ffffff;
-	g2 = h2 + (g1 >> 26);             g1 &= 0x3ffffff;
-	g3 = h3 + (g2 >> 26);             g2 &= 0x3ffffff;
-	g4 = h4 + (g3 >> 26) - (1 << 26); g3 &= 0x3ffffff;
-
-	/* select h if h < p, or h + -p if h >= p */
-	mask = (g4 >> ((sizeof(u32) * 8) - 1)) - 1;
-	g0 &= mask;
-	g1 &= mask;
-	g2 &= mask;
-	g3 &= mask;
-	g4 &= mask;
-	mask = ~mask;
-	h0 = (h0 & mask) | g0;
-	h1 = (h1 & mask) | g1;
-	h2 = (h2 & mask) | g2;
-	h3 = (h3 & mask) | g3;
-	h4 = (h4 & mask) | g4;
-
-	/* h = h % (2^128) */
-	put_unaligned_le32((h0 >>  0) | (h1 << 26), dst +  0);
-	put_unaligned_le32((h1 >>  6) | (h2 << 20), dst +  4);
-	put_unaligned_le32((h2 >> 12) | (h3 << 14), dst +  8);
-	put_unaligned_le32((h3 >> 18) | (h4 <<  8), dst + 12);
-}
-EXPORT_SYMBOL_GPL(poly1305_core_emit);
-
 int crypto_poly1305_final(struct shash_desc *desc, u8 *dst)
 {
 	struct poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
@@ -274,7 +95,7 @@ int crypto_poly1305_final(struct shash_desc *desc, u8 *dst)
 		dctx->buf[dctx->buflen++] = 1;
 		memset(dctx->buf + dctx->buflen, 0,
 		       POLY1305_BLOCK_SIZE - dctx->buflen);
-		poly1305_blocks(dctx, dctx->buf, POLY1305_BLOCK_SIZE, 0);
+		poly1305_core_blocks(&dctx->h, &dctx->r, dctx->buf, 1, 0);
 	}
 
 	poly1305_core_emit(&dctx->h, digest);
diff --git a/include/crypto/internal/poly1305.h b/include/crypto/internal/poly1305.h
new file mode 100644
index 000000000000..cb58e61f73a7
--- /dev/null
+++ b/include/crypto/internal/poly1305.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Common values for the Poly1305 algorithm
+ */
+
+#ifndef _CRYPTO_INTERNAL_POLY1305_H
+#define _CRYPTO_INTERNAL_POLY1305_H
+
+#include <asm/unaligned.h>
+#include <linux/types.h>
+#include <crypto/poly1305.h>
+
+struct shash_desc;
+
+/*
+ * Poly1305 core functions.  These implement the ε-almost-∆-universal hash
+ * function underlying the Poly1305 MAC, i.e. they don't add an encrypted nonce
+ * ("s key") at the end.  They also only support block-aligned inputs.
+ */
+void poly1305_core_setkey(struct poly1305_key *key, const u8 *raw_key);
+static inline void poly1305_core_init(struct poly1305_state *state)
+{
+	*state = (struct poly1305_state){};
+}
+
+void poly1305_core_blocks(struct poly1305_state *state,
+			  const struct poly1305_key *key, const void *src,
+			  unsigned int nblocks, u32 hibit);
+void poly1305_core_emit(const struct poly1305_state *state, void *dst);
+
+/* Crypto API helper functions for the Poly1305 MAC */
+int crypto_poly1305_init(struct shash_desc *desc);
+
+int crypto_poly1305_update(struct shash_desc *desc,
+			   const u8 *src, unsigned int srclen);
+int crypto_poly1305_final(struct shash_desc *desc, u8 *dst);
+
+/*
+ * Poly1305 requires a unique key for each tag, which implies that we can't set
+ * it on the tfm that gets accessed by multiple users simultaneously. Instead we
+ * expect the key as the first 32 bytes in the update() call.
+ */
+static inline
+unsigned int crypto_poly1305_setdesckey(struct poly1305_desc_ctx *dctx,
+					const u8 *src, unsigned int srclen)
+{
+	if (!dctx->sset) {
+		if (!dctx->rset && srclen >= POLY1305_BLOCK_SIZE) {
+			poly1305_core_setkey(&dctx->r, src);
+			src += POLY1305_BLOCK_SIZE;
+			srclen -= POLY1305_BLOCK_SIZE;
+			dctx->rset = true;
+		}
+		if (srclen >= POLY1305_BLOCK_SIZE) {
+			dctx->s[0] = get_unaligned_le32(src +  0);
+			dctx->s[1] = get_unaligned_le32(src +  4);
+			dctx->s[2] = get_unaligned_le32(src +  8);
+			dctx->s[3] = get_unaligned_le32(src + 12);
+			src += POLY1305_BLOCK_SIZE;
+			srclen -= POLY1305_BLOCK_SIZE;
+			dctx->sset = true;
+		}
+	}
+	return srclen;
+}
+
+#endif
diff --git a/include/crypto/poly1305.h b/include/crypto/poly1305.h
index 34317ed2071e..f5a4319c2a1f 100644
--- a/include/crypto/poly1305.h
+++ b/include/crypto/poly1305.h
@@ -38,27 +38,4 @@ struct poly1305_desc_ctx {
 	bool sset;
 };
 
-/*
- * Poly1305 core functions.  These implement the ε-almost-∆-universal hash
- * function underlying the Poly1305 MAC, i.e. they don't add an encrypted nonce
- * ("s key") at the end.  They also only support block-aligned inputs.
- */
-void poly1305_core_setkey(struct poly1305_key *key, const u8 *raw_key);
-static inline void poly1305_core_init(struct poly1305_state *state)
-{
-	memset(state->h, 0, sizeof(state->h));
-}
-void poly1305_core_blocks(struct poly1305_state *state,
-			  const struct poly1305_key *key,
-			  const void *src, unsigned int nblocks);
-void poly1305_core_emit(const struct poly1305_state *state, void *dst);
-
-/* Crypto API helper functions for the Poly1305 MAC */
-int crypto_poly1305_init(struct shash_desc *desc);
-unsigned int crypto_poly1305_setdesckey(struct poly1305_desc_ctx *dctx,
-					const u8 *src, unsigned int srclen);
-int crypto_poly1305_update(struct shash_desc *desc,
-			   const u8 *src, unsigned int srclen);
-int crypto_poly1305_final(struct shash_desc *desc, u8 *dst);
-
 #endif
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 6a11931ae105..c4882d29879e 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -37,5 +37,8 @@ config CRYPTO_LIB_CHACHA
 config CRYPTO_LIB_DES
 	tristate
 
+config CRYPTO_LIB_POLY1305_GENERIC
+	tristate
+
 config CRYPTO_LIB_SHA256
 	tristate
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 0ce40604e104..b58ab6843a9d 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -13,5 +13,8 @@ libarc4-y					:= arc4.o
 obj-$(CONFIG_CRYPTO_LIB_DES)			+= libdes.o
 libdes-y					:= des.o
 
+obj-$(CONFIG_CRYPTO_LIB_POLY1305_GENERIC)	+= libpoly1305.o
+libpoly1305-y					:= poly1305.o
+
 obj-$(CONFIG_CRYPTO_LIB_SHA256)			+= libsha256.o
 libsha256-y					:= sha256.o
diff --git a/lib/crypto/poly1305.c b/lib/crypto/poly1305.c
new file mode 100644
index 000000000000..f019a57dbc1b
--- /dev/null
+++ b/lib/crypto/poly1305.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Poly1305 authenticator algorithm, RFC7539
+ *
+ * Copyright (C) 2015 Martin Willi
+ *
+ * Based on public domain code by Andrew Moon and Daniel J. Bernstein.
+ */
+
+#include <crypto/internal/poly1305.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <asm/unaligned.h>
+
+static inline u64 mlt(u64 a, u64 b)
+{
+	return a * b;
+}
+
+static inline u32 sr(u64 v, u_char n)
+{
+	return v >> n;
+}
+
+static inline u32 and(u32 v, u32 mask)
+{
+	return v & mask;
+}
+
+void poly1305_core_setkey(struct poly1305_key *key, const u8 *raw_key)
+{
+	/* r &= 0xffffffc0ffffffc0ffffffc0fffffff */
+	key->r[0] = (get_unaligned_le32(raw_key +  0) >> 0) & 0x3ffffff;
+	key->r[1] = (get_unaligned_le32(raw_key +  3) >> 2) & 0x3ffff03;
+	key->r[2] = (get_unaligned_le32(raw_key +  6) >> 4) & 0x3ffc0ff;
+	key->r[3] = (get_unaligned_le32(raw_key +  9) >> 6) & 0x3f03fff;
+	key->r[4] = (get_unaligned_le32(raw_key + 12) >> 8) & 0x00fffff;
+}
+EXPORT_SYMBOL_GPL(poly1305_core_setkey);
+
+void poly1305_core_blocks(struct poly1305_state *state,
+			  const struct poly1305_key *key, const void *src,
+			  unsigned int nblocks, u32 hibit)
+{
+	u32 r0, r1, r2, r3, r4;
+	u32 s1, s2, s3, s4;
+	u32 h0, h1, h2, h3, h4;
+	u64 d0, d1, d2, d3, d4;
+
+	if (!nblocks)
+		return;
+
+	r0 = key->r[0];
+	r1 = key->r[1];
+	r2 = key->r[2];
+	r3 = key->r[3];
+	r4 = key->r[4];
+
+	s1 = r1 * 5;
+	s2 = r2 * 5;
+	s3 = r3 * 5;
+	s4 = r4 * 5;
+
+	h0 = state->h[0];
+	h1 = state->h[1];
+	h2 = state->h[2];
+	h3 = state->h[3];
+	h4 = state->h[4];
+
+	do {
+		/* h += m[i] */
+		h0 += (get_unaligned_le32(src +  0) >> 0) & 0x3ffffff;
+		h1 += (get_unaligned_le32(src +  3) >> 2) & 0x3ffffff;
+		h2 += (get_unaligned_le32(src +  6) >> 4) & 0x3ffffff;
+		h3 += (get_unaligned_le32(src +  9) >> 6) & 0x3ffffff;
+		h4 += (get_unaligned_le32(src + 12) >> 8) | (hibit << 24);
+
+		/* h *= r */
+		d0 = mlt(h0, r0) + mlt(h1, s4) + mlt(h2, s3) +
+		     mlt(h3, s2) + mlt(h4, s1);
+		d1 = mlt(h0, r1) + mlt(h1, r0) + mlt(h2, s4) +
+		     mlt(h3, s3) + mlt(h4, s2);
+		d2 = mlt(h0, r2) + mlt(h1, r1) + mlt(h2, r0) +
+		     mlt(h3, s4) + mlt(h4, s3);
+		d3 = mlt(h0, r3) + mlt(h1, r2) + mlt(h2, r1) +
+		     mlt(h3, r0) + mlt(h4, s4);
+		d4 = mlt(h0, r4) + mlt(h1, r3) + mlt(h2, r2) +
+		     mlt(h3, r1) + mlt(h4, r0);
+
+		/* (partial) h %= p */
+		d1 += sr(d0, 26);     h0 = and(d0, 0x3ffffff);
+		d2 += sr(d1, 26);     h1 = and(d1, 0x3ffffff);
+		d3 += sr(d2, 26);     h2 = and(d2, 0x3ffffff);
+		d4 += sr(d3, 26);     h3 = and(d3, 0x3ffffff);
+		h0 += sr(d4, 26) * 5; h4 = and(d4, 0x3ffffff);
+		h1 += h0 >> 26;       h0 = h0 & 0x3ffffff;
+
+		src += POLY1305_BLOCK_SIZE;
+	} while (--nblocks);
+
+	state->h[0] = h0;
+	state->h[1] = h1;
+	state->h[2] = h2;
+	state->h[3] = h3;
+	state->h[4] = h4;
+}
+EXPORT_SYMBOL_GPL(poly1305_core_blocks);
+
+void poly1305_core_emit(const struct poly1305_state *state, void *dst)
+{
+	u32 h0, h1, h2, h3, h4;
+	u32 g0, g1, g2, g3, g4;
+	u32 mask;
+
+	/* fully carry h */
+	h0 = state->h[0];
+	h1 = state->h[1];
+	h2 = state->h[2];
+	h3 = state->h[3];
+	h4 = state->h[4];
+
+	h2 += (h1 >> 26);     h1 = h1 & 0x3ffffff;
+	h3 += (h2 >> 26);     h2 = h2 & 0x3ffffff;
+	h4 += (h3 >> 26);     h3 = h3 & 0x3ffffff;
+	h0 += (h4 >> 26) * 5; h4 = h4 & 0x3ffffff;
+	h1 += (h0 >> 26);     h0 = h0 & 0x3ffffff;
+
+	/* compute h + -p */
+	g0 = h0 + 5;
+	g1 = h1 + (g0 >> 26);             g0 &= 0x3ffffff;
+	g2 = h2 + (g1 >> 26);             g1 &= 0x3ffffff;
+	g3 = h3 + (g2 >> 26);             g2 &= 0x3ffffff;
+	g4 = h4 + (g3 >> 26) - (1 << 26); g3 &= 0x3ffffff;
+
+	/* select h if h < p, or h + -p if h >= p */
+	mask = (g4 >> ((sizeof(u32) * 8) - 1)) - 1;
+	g0 &= mask;
+	g1 &= mask;
+	g2 &= mask;
+	g3 &= mask;
+	g4 &= mask;
+	mask = ~mask;
+	h0 = (h0 & mask) | g0;
+	h1 = (h1 & mask) | g1;
+	h2 = (h2 & mask) | g2;
+	h3 = (h3 & mask) | g3;
+	h4 = (h4 & mask) | g4;
+
+	/* h = h % (2^128) */
+	put_unaligned_le32((h0 >>  0) | (h1 << 26), dst +  0);
+	put_unaligned_le32((h1 >>  6) | (h2 << 20), dst +  4);
+	put_unaligned_le32((h2 >> 12) | (h3 << 14), dst +  8);
+	put_unaligned_le32((h3 >> 18) | (h4 <<  8), dst + 12);
+}
+EXPORT_SYMBOL_GPL(poly1305_core_emit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Martin Willi <martin@strongswan.org>");
-- 
2.20.1


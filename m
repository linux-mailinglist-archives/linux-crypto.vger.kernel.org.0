Return-Path: <linux-crypto+bounces-12349-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B310A9DE1C
	for <lists+linux-crypto@lfdr.de>; Sun, 27 Apr 2025 03:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD02921A38
	for <lists+linux-crypto@lfdr.de>; Sun, 27 Apr 2025 00:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C7E227EBB;
	Sun, 27 Apr 2025 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="nJaHE3pK"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B88228CA9
	for <linux-crypto@vger.kernel.org>; Sun, 27 Apr 2025 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745715608; cv=none; b=BzWoN9Ub37ZZoAw8wYsDCizZSnirDks13GObtDG3fdNE5YRmgN0qqTcrvO5MYMJA7SHF8w5byGWw1B0noL/jdW9nuEkTwgKIN4ITRCwXM7bHcZu1hKk7g0dUfssrXIUe0lwgWyljXCUfNGs0GT4HR9wWuQI/PZnpgsKDI7x6lhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745715608; c=relaxed/simple;
	bh=EYfVg5BQsig0N53N641PZ1sJfB/wmVxhZ7I1I3FM3NE=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=kWTPXbCPSbqvw+/mTktK/JM8TAK//h4kdz2mr59hufjNL6C9joJE5NwKVvh9Zfq5TkMtckSOIkfo7Dd3AhRP2jI1teE9w3+gl3jI6E01n+0l0fW3gc+12ZMRfM92SiSjKn0VVQhiyQXv9bOibk9C2ysqgeBbjJK5Wge+ESnX060=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=nJaHE3pK; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=To:Subject:From:References:In-Reply-To:Message-Id:Date:Sender:
	Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=y1+LiWbwWvYvr3hLcPYL+cSvLmPZC8ToCI/c4pVVyEk=; b=nJaHE3pKi2Y4tcCxcYZDJuvOht
	fOTC8jSLaUWHz61v4kKn82ZUCe8DvOG3efXmlEsy190tKfOGoFg8CNr6y39GaI5I8yzMxReyhn6Ug
	cU/HoKsCmz85cStodZH+4g2xMp3EXBCi/jPFulK2sFfTKGQl9Jz51+aY1hjcrv7wVLXEyNOusU87/
	SqRddLCh5+6IvLy3xS+xwdI46G04+I83ICvxqXVPIWBAwKGJEt1qPOJP2H5Omgd+3ezOihQHt7ZYs
	ABHHKJo8uPFvwMTub59dujsD33kUJA3liScBRUIuPYuQB5/HBag4PxV2nFkjMUC2ddJJr5533r+DS
	iOCLE61g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u8qNF-001JGy-15;
	Sun, 27 Apr 2025 09:00:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 27 Apr 2025 09:00:01 +0800
Date: Sun, 27 Apr 2025 09:00:01 +0800
Message-Id: <2e1b5bd4083b32fad4083ee34304d222802d5659.1745714715.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1745714715.git.herbert@gondor.apana.org.au>
References: <cover.1745714715.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v2 PATCH 02/11] crypto: lib/poly1305 - Add block-only interface
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

Add a block-only interface for poly1305.  Implement the generic
code first.

Also use the generic partial block helper.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 include/crypto/internal/poly1305.h | 28 ++++++++++++++--
 include/crypto/poly1305.h          | 25 ++++++++++----
 lib/crypto/poly1305.c              | 54 +++++++++++++-----------------
 3 files changed, 68 insertions(+), 39 deletions(-)

diff --git a/include/crypto/internal/poly1305.h b/include/crypto/internal/poly1305.h
index e614594f88c1..c60315f47562 100644
--- a/include/crypto/internal/poly1305.h
+++ b/include/crypto/internal/poly1305.h
@@ -6,9 +6,8 @@
 #ifndef _CRYPTO_INTERNAL_POLY1305_H
 #define _CRYPTO_INTERNAL_POLY1305_H
 
-#include <linux/unaligned.h>
-#include <linux/types.h>
 #include <crypto/poly1305.h>
+#include <linux/types.h>
 
 /*
  * Poly1305 core functions.  These only accept whole blocks; the caller must
@@ -31,4 +30,29 @@ void poly1305_core_blocks(struct poly1305_state *state,
 void poly1305_core_emit(const struct poly1305_state *state, const u32 nonce[4],
 			void *dst);
 
+void poly1305_block_init_arch(struct poly1305_block_state *state,
+			      const u8 raw_key[POLY1305_BLOCK_SIZE]);
+void poly1305_block_init_generic(struct poly1305_block_state *state,
+				 const u8 raw_key[POLY1305_BLOCK_SIZE]);
+void poly1305_blocks_arch(struct poly1305_block_state *state, const u8 *src,
+			  unsigned int len, u32 padbit);
+
+static inline void poly1305_blocks_generic(struct poly1305_block_state *state,
+					   const u8 *src, unsigned int len,
+					   u32 padbit)
+{
+	poly1305_core_blocks(&state->h, &state->core_r, src,
+			     len / POLY1305_BLOCK_SIZE, padbit);
+}
+
+void poly1305_emit_arch(const struct poly1305_state *state,
+			u8 digest[POLY1305_DIGEST_SIZE], const u32 nonce[4]);
+
+static inline void poly1305_emit_generic(const struct poly1305_state *state,
+					 u8 digest[POLY1305_DIGEST_SIZE],
+					 const u32 nonce[4])
+{
+	poly1305_core_emit(state, nonce, digest);
+}
+
 #endif
diff --git a/include/crypto/poly1305.h b/include/crypto/poly1305.h
index 6e21ec2d1dc2..027d74842cd5 100644
--- a/include/crypto/poly1305.h
+++ b/include/crypto/poly1305.h
@@ -7,7 +7,6 @@
 #define _CRYPTO_POLY1305_H
 
 #include <linux/types.h>
-#include <linux/crypto.h>
 
 #define POLY1305_BLOCK_SIZE	16
 #define POLY1305_KEY_SIZE	32
@@ -38,6 +37,17 @@ struct poly1305_state {
 	};
 };
 
+/* Combined state for block function. */
+struct poly1305_block_state {
+	/* accumulator */
+	struct poly1305_state h;
+	/* key */
+	union {
+		struct poly1305_key opaque_r[CONFIG_CRYPTO_LIB_POLY1305_RSIZE];
+		struct poly1305_core_key core_r;
+	};
+};
+
 struct poly1305_desc_ctx {
 	/* partial buffer */
 	u8 buf[POLY1305_BLOCK_SIZE];
@@ -45,12 +55,15 @@ struct poly1305_desc_ctx {
 	unsigned int buflen;
 	/* finalize key */
 	u32 s[4];
-	/* accumulator */
-	struct poly1305_state h;
-	/* key */
 	union {
-		struct poly1305_key opaque_r[CONFIG_CRYPTO_LIB_POLY1305_RSIZE];
-		struct poly1305_core_key core_r;
+		struct {
+			struct poly1305_state h;
+			union {
+				struct poly1305_key opaque_r[CONFIG_CRYPTO_LIB_POLY1305_RSIZE];
+				struct poly1305_core_key core_r;
+			};
+		};
+		struct poly1305_block_state state;
 	};
 };
 
diff --git a/lib/crypto/poly1305.c b/lib/crypto/poly1305.c
index b633b043f0f6..f35692376acf 100644
--- a/lib/crypto/poly1305.c
+++ b/lib/crypto/poly1305.c
@@ -7,54 +7,45 @@
  * Based on public domain code by Andrew Moon and Daniel J. Bernstein.
  */
 
+#include <crypto/internal/blockhash.h>
 #include <crypto/internal/poly1305.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/string.h>
 #include <linux/unaligned.h>
 
+void poly1305_block_init_generic(struct poly1305_block_state *desc,
+				 const u8 raw_key[POLY1305_BLOCK_SIZE])
+{
+	poly1305_core_init(&desc->h);
+	poly1305_core_setkey(&desc->core_r, raw_key);
+}
+EXPORT_SYMBOL_GPL(poly1305_block_init_generic);
+
 void poly1305_init_generic(struct poly1305_desc_ctx *desc,
 			   const u8 key[POLY1305_KEY_SIZE])
 {
-	poly1305_core_setkey(&desc->core_r, key);
 	desc->s[0] = get_unaligned_le32(key + 16);
 	desc->s[1] = get_unaligned_le32(key + 20);
 	desc->s[2] = get_unaligned_le32(key + 24);
 	desc->s[3] = get_unaligned_le32(key + 28);
-	poly1305_core_init(&desc->h);
 	desc->buflen = 0;
+	poly1305_block_init_generic(&desc->state, key);
 }
 EXPORT_SYMBOL_GPL(poly1305_init_generic);
 
+static inline void poly1305_blocks(struct poly1305_block_state *state,
+				   const u8 *src, unsigned int len)
+{
+	poly1305_blocks_generic(state, src, len, 1);
+}
+
 void poly1305_update_generic(struct poly1305_desc_ctx *desc, const u8 *src,
 			     unsigned int nbytes)
 {
-	unsigned int bytes;
-
-	if (unlikely(desc->buflen)) {
-		bytes = min(nbytes, POLY1305_BLOCK_SIZE - desc->buflen);
-		memcpy(desc->buf + desc->buflen, src, bytes);
-		src += bytes;
-		nbytes -= bytes;
-		desc->buflen += bytes;
-
-		if (desc->buflen == POLY1305_BLOCK_SIZE) {
-			poly1305_core_blocks(&desc->h, &desc->core_r, desc->buf,
-					     1, 1);
-			desc->buflen = 0;
-		}
-	}
-
-	if (likely(nbytes >= POLY1305_BLOCK_SIZE)) {
-		poly1305_core_blocks(&desc->h, &desc->core_r, src,
-				     nbytes / POLY1305_BLOCK_SIZE, 1);
-		src += nbytes - (nbytes % POLY1305_BLOCK_SIZE);
-		nbytes %= POLY1305_BLOCK_SIZE;
-	}
-
-	if (unlikely(nbytes)) {
-		desc->buflen = nbytes;
-		memcpy(desc->buf, src, nbytes);
-	}
+	desc->buflen = BLOCK_HASH_UPDATE(&poly1305_blocks, &desc->state,
+					 src, nbytes, POLY1305_BLOCK_SIZE,
+					 desc->buf, desc->buflen);
 }
 EXPORT_SYMBOL_GPL(poly1305_update_generic);
 
@@ -64,10 +55,11 @@ void poly1305_final_generic(struct poly1305_desc_ctx *desc, u8 *dst)
 		desc->buf[desc->buflen++] = 1;
 		memset(desc->buf + desc->buflen, 0,
 		       POLY1305_BLOCK_SIZE - desc->buflen);
-		poly1305_core_blocks(&desc->h, &desc->core_r, desc->buf, 1, 0);
+		poly1305_blocks_generic(&desc->state, desc->buf,
+					POLY1305_BLOCK_SIZE, 0);
 	}
 
-	poly1305_core_emit(&desc->h, desc->s, dst);
+	poly1305_emit_generic(&desc->h, dst, desc->s);
 	*desc = (struct poly1305_desc_ctx){};
 }
 EXPORT_SYMBOL_GPL(poly1305_final_generic);
-- 
2.39.5



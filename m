Return-Path: <linux-crypto+bounces-11775-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34231A8B0B9
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Apr 2025 08:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537DA189C4A0
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Apr 2025 06:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20B522D7A0;
	Wed, 16 Apr 2025 06:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="kTkQkY+r"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888C2225419
	for <linux-crypto@vger.kernel.org>; Wed, 16 Apr 2025 06:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785775; cv=none; b=dKBLe3ggSMEfMfF8T3rFXmFDSttWlchM1JVsCcmvaxFz5Lf+NExD+mpZ2EycSrUQS+8Vw9lrIdg5JdwYgtra1gt4nhRt9eX965+FLM4O6kPSmnqgf2U9EIOuwWbD33R90Rud+T/XcPVO26MxHTDBS/YIViDDGoOsWGfwVLcN2Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785775; c=relaxed/simple;
	bh=x70Qi5KBv1jZ0EBmnznReTL/gXm/SP7rI4c5icZuTic=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=d5WnxFtzLmE+fUzrtZ27tVfGa/DX7N2XnEn0Vqi664+LNoEtGFnF9cs4/ws/vIgaGTMqh6LGOtLbzis/PJ3oWhcd196qNUG7Y2sBK6uNQejNqq+ff8wQQaBx58EX2Vb1UBgSB8sVMhADJToct/ZmBEvPJP3IjiIwqABQgV1lFzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=kTkQkY+r; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=To:Subject:From:References:In-Reply-To:Message-Id:Date:Sender:
	Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5USs5sUEVHFzip/MdSruNOm86OF1747LG7L0ox+qlek=; b=kTkQkY+r4xgtY6gZP+1Zxzy46X
	xTjOR2R8orTG+/RGH9PxeijrpRXGvTd3aOBSDDZszNoI2uCX72KffqggMl/zKYdXRon4BZ+QQnWvL
	BiZTtakv4dqKjJvizd3Hi+VzUiCT4Lx8sX385hLIVaZrP8f77XgaWDrz7HVlBQLuPa9pi7axIvmSc
	fbcT88Jy+pCuEkIFNeKKgYybg1RNRd1OEp+C0pvTAvrpjLfyec42Ebfla5IRT1ZGS7IFna6WJA7ZS
	BP7Crr54KlWjrbe3NNuTGXCJagAwToE5F6H4Kj2kbLEeBLPoYF128Ui8tNmlEmlBj7SDmCO34VSKK
	8kcgDDMA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u4wTv-00G6Gf-1Y;
	Wed, 16 Apr 2025 14:42:48 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 16 Apr 2025 14:42:47 +0800
Date: Wed, 16 Apr 2025 14:42:47 +0800
Message-Id: <16ad0ff37c87e9a3d110eb13841cc16aa22ab1d9.1744784515.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1744784515.git.herbert@gondor.apana.org.au>
References: <cover.1744784515.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 02/67] crypto: blake2b-generic - Use API partial block
 handling
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

Use the Crypto API partial block handling.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 crypto/blake2b_generic.c          | 31 ++++++++------
 include/crypto/blake2b.h          | 14 ++-----
 include/crypto/internal/blake2b.h | 70 ++++++++++++++++++++++++++-----
 3 files changed, 80 insertions(+), 35 deletions(-)

diff --git a/crypto/blake2b_generic.c b/crypto/blake2b_generic.c
index 04a712ddfb43..6fa38965a493 100644
--- a/crypto/blake2b_generic.c
+++ b/crypto/blake2b_generic.c
@@ -15,12 +15,12 @@
  * More information about BLAKE2 can be found at https://blake2.net.
  */
 
-#include <linux/unaligned.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/bitops.h>
 #include <crypto/internal/blake2b.h>
 #include <crypto/internal/hash.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/unaligned.h>
 
 static const u8 blake2b_sigma[12][16] = {
 	{  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15 },
@@ -111,8 +111,8 @@ static void blake2b_compress_one_generic(struct blake2b_state *S,
 #undef G
 #undef ROUND
 
-void blake2b_compress_generic(struct blake2b_state *state,
-			      const u8 *block, size_t nblocks, u32 inc)
+static void blake2b_compress_generic(struct blake2b_state *state,
+				     const u8 *block, size_t nblocks, u32 inc)
 {
 	do {
 		blake2b_increment_counter(state, inc);
@@ -120,17 +120,19 @@ void blake2b_compress_generic(struct blake2b_state *state,
 		block += BLAKE2B_BLOCK_SIZE;
 	} while (--nblocks);
 }
-EXPORT_SYMBOL(blake2b_compress_generic);
 
 static int crypto_blake2b_update_generic(struct shash_desc *desc,
 					 const u8 *in, unsigned int inlen)
 {
-	return crypto_blake2b_update(desc, in, inlen, blake2b_compress_generic);
+	return crypto_blake2b_update_bo(desc, in, inlen,
+					blake2b_compress_generic);
 }
 
-static int crypto_blake2b_final_generic(struct shash_desc *desc, u8 *out)
+static int crypto_blake2b_finup_generic(struct shash_desc *desc, const u8 *in,
+					unsigned int inlen, u8 *out)
 {
-	return crypto_blake2b_final(desc, out, blake2b_compress_generic);
+	return crypto_blake2b_finup(desc, in, inlen, out,
+				    blake2b_compress_generic);
 }
 
 #define BLAKE2B_ALG(name, driver_name, digest_size)			\
@@ -138,7 +140,9 @@ static int crypto_blake2b_final_generic(struct shash_desc *desc, u8 *out)
 		.base.cra_name		= name,				\
 		.base.cra_driver_name	= driver_name,			\
 		.base.cra_priority	= 100,				\
-		.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,	\
+		.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY |	\
+					  CRYPTO_AHASH_ALG_BLOCK_ONLY |	\
+					  CRYPTO_AHASH_ALG_FINAL_NONZERO, \
 		.base.cra_blocksize	= BLAKE2B_BLOCK_SIZE,		\
 		.base.cra_ctxsize	= sizeof(struct blake2b_tfm_ctx), \
 		.base.cra_module	= THIS_MODULE,			\
@@ -146,8 +150,9 @@ static int crypto_blake2b_final_generic(struct shash_desc *desc, u8 *out)
 		.setkey			= crypto_blake2b_setkey,	\
 		.init			= crypto_blake2b_init,		\
 		.update			= crypto_blake2b_update_generic, \
-		.final			= crypto_blake2b_final_generic,	\
-		.descsize		= sizeof(struct blake2b_state),	\
+		.finup			= crypto_blake2b_finup_generic,	\
+		.descsize		= BLAKE2B_DESC_SIZE,		\
+		.statesize		= BLAKE2B_STATE_SIZE,		\
 	}
 
 static struct shash_alg blake2b_algs[] = {
diff --git a/include/crypto/blake2b.h b/include/crypto/blake2b.h
index 0c0176285349..68da368dc182 100644
--- a/include/crypto/blake2b.h
+++ b/include/crypto/blake2b.h
@@ -11,6 +11,8 @@ enum blake2b_lengths {
 	BLAKE2B_BLOCK_SIZE = 128,
 	BLAKE2B_HASH_SIZE = 64,
 	BLAKE2B_KEY_SIZE = 64,
+	BLAKE2B_STATE_SIZE = 80,
+	BLAKE2B_DESC_SIZE = 96,
 
 	BLAKE2B_160_HASH_SIZE = 20,
 	BLAKE2B_256_HASH_SIZE = 32,
@@ -25,7 +27,6 @@ struct blake2b_state {
 	u64 f[2];
 	u8 buf[BLAKE2B_BLOCK_SIZE];
 	unsigned int buflen;
-	unsigned int outlen;
 };
 
 enum blake2b_iv {
@@ -40,7 +41,7 @@ enum blake2b_iv {
 };
 
 static inline void __blake2b_init(struct blake2b_state *state, size_t outlen,
-				  const void *key, size_t keylen)
+				  size_t keylen)
 {
 	state->h[0] = BLAKE2B_IV0 ^ (0x01010000 | keylen << 8 | outlen);
 	state->h[1] = BLAKE2B_IV1;
@@ -52,15 +53,6 @@ static inline void __blake2b_init(struct blake2b_state *state, size_t outlen,
 	state->h[7] = BLAKE2B_IV7;
 	state->t[0] = 0;
 	state->t[1] = 0;
-	state->f[0] = 0;
-	state->f[1] = 0;
-	state->buflen = 0;
-	state->outlen = outlen;
-	if (keylen) {
-		memcpy(state->buf, key, keylen);
-		memset(&state->buf[keylen], 0, BLAKE2B_BLOCK_SIZE - keylen);
-		state->buflen = BLAKE2B_BLOCK_SIZE;
-	}
 }
 
 #endif /* _CRYPTO_BLAKE2B_H */
diff --git a/include/crypto/internal/blake2b.h b/include/crypto/internal/blake2b.h
index 982fe5e8471c..48dc9830400d 100644
--- a/include/crypto/internal/blake2b.h
+++ b/include/crypto/internal/blake2b.h
@@ -7,16 +7,27 @@
 #ifndef _CRYPTO_INTERNAL_BLAKE2B_H
 #define _CRYPTO_INTERNAL_BLAKE2B_H
 
+#include <asm/byteorder.h>
 #include <crypto/blake2b.h>
 #include <crypto/internal/hash.h>
+#include <linux/array_size.h>
+#include <linux/compiler.h>
+#include <linux/build_bug.h>
+#include <linux/errno.h>
+#include <linux/math.h>
 #include <linux/string.h>
-
-void blake2b_compress_generic(struct blake2b_state *state,
-			      const u8 *block, size_t nblocks, u32 inc);
+#include <linux/types.h>
 
 static inline void blake2b_set_lastblock(struct blake2b_state *state)
 {
 	state->f[0] = -1;
+	state->f[1] = 0;
+}
+
+static inline void blake2b_set_nonlast(struct blake2b_state *state)
+{
+	state->f[0] = 0;
+	state->f[1] = 0;
 }
 
 typedef void (*blake2b_compress_t)(struct blake2b_state *state,
@@ -30,6 +41,7 @@ static inline void __blake2b_update(struct blake2b_state *state,
 
 	if (unlikely(!inlen))
 		return;
+	blake2b_set_nonlast(state);
 	if (inlen > fill) {
 		memcpy(state->buf + state->buflen, in, fill);
 		(*compress)(state, state->buf, 1, BLAKE2B_BLOCK_SIZE);
@@ -49,6 +61,7 @@ static inline void __blake2b_update(struct blake2b_state *state,
 }
 
 static inline void __blake2b_final(struct blake2b_state *state, u8 *out,
+				   unsigned int outlen,
 				   blake2b_compress_t compress)
 {
 	int i;
@@ -59,13 +72,13 @@ static inline void __blake2b_final(struct blake2b_state *state, u8 *out,
 	(*compress)(state, state->buf, 1, state->buflen);
 	for (i = 0; i < ARRAY_SIZE(state->h); i++)
 		__cpu_to_le64s(&state->h[i]);
-	memcpy(out, state->h, state->outlen);
+	memcpy(out, state->h, outlen);
 }
 
 /* Helper functions for shash implementations of BLAKE2b */
 
 struct blake2b_tfm_ctx {
-	u8 key[BLAKE2B_KEY_SIZE];
+	u8 key[BLAKE2B_BLOCK_SIZE];
 	unsigned int keylen;
 };
 
@@ -74,10 +87,13 @@ static inline int crypto_blake2b_setkey(struct crypto_shash *tfm,
 {
 	struct blake2b_tfm_ctx *tctx = crypto_shash_ctx(tfm);
 
-	if (keylen == 0 || keylen > BLAKE2B_KEY_SIZE)
+	if (keylen > BLAKE2B_KEY_SIZE)
 		return -EINVAL;
 
+	BUILD_BUG_ON(BLAKE2B_KEY_SIZE > BLAKE2B_BLOCK_SIZE);
+
 	memcpy(tctx->key, key, keylen);
+	memset(tctx->key + keylen, 0, BLAKE2B_BLOCK_SIZE - keylen);
 	tctx->keylen = keylen;
 
 	return 0;
@@ -89,8 +105,9 @@ static inline int crypto_blake2b_init(struct shash_desc *desc)
 	struct blake2b_state *state = shash_desc_ctx(desc);
 	unsigned int outlen = crypto_shash_digestsize(desc->tfm);
 
-	__blake2b_init(state, outlen, tctx->key, tctx->keylen);
-	return 0;
+	__blake2b_init(state, outlen, tctx->keylen);
+	return tctx->keylen ?
+	       crypto_shash_update(desc, tctx->key, BLAKE2B_BLOCK_SIZE) : 0;
 }
 
 static inline int crypto_blake2b_update(struct shash_desc *desc,
@@ -103,12 +120,43 @@ static inline int crypto_blake2b_update(struct shash_desc *desc,
 	return 0;
 }
 
-static inline int crypto_blake2b_final(struct shash_desc *desc, u8 *out,
-				       blake2b_compress_t compress)
+static inline int crypto_blake2b_update_bo(struct shash_desc *desc,
+					   const u8 *in, unsigned int inlen,
+					   blake2b_compress_t compress)
 {
 	struct blake2b_state *state = shash_desc_ctx(desc);
 
-	__blake2b_final(state, out, compress);
+	blake2b_set_nonlast(state);
+	compress(state, in, inlen / BLAKE2B_BLOCK_SIZE, BLAKE2B_BLOCK_SIZE);
+	return inlen - round_down(inlen, BLAKE2B_BLOCK_SIZE);
+}
+
+static inline int crypto_blake2b_final(struct shash_desc *desc, u8 *out,
+				       blake2b_compress_t compress)
+{
+	unsigned int outlen = crypto_shash_digestsize(desc->tfm);
+	struct blake2b_state *state = shash_desc_ctx(desc);
+
+	__blake2b_final(state, out, outlen, compress);
+	return 0;
+}
+
+static inline int crypto_blake2b_finup(struct shash_desc *desc, const u8 *in,
+				       unsigned int inlen, u8 *out,
+				       blake2b_compress_t compress)
+{
+	struct blake2b_state *state = shash_desc_ctx(desc);
+	u8 buf[BLAKE2B_BLOCK_SIZE];
+	int i;
+
+	memcpy(buf, in, inlen);
+	memset(buf + inlen, 0, BLAKE2B_BLOCK_SIZE - inlen);
+	blake2b_set_lastblock(state);
+	compress(state, buf, 1, inlen);
+	for (i = 0; i < ARRAY_SIZE(state->h); i++)
+		__cpu_to_le64s(&state->h[i]);
+	memcpy(out, state->h, crypto_shash_digestsize(desc->tfm));
+	memzero_explicit(buf, sizeof(buf));
 	return 0;
 }
 
-- 
2.39.5



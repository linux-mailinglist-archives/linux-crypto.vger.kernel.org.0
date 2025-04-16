Return-Path: <linux-crypto+bounces-11817-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34B8A8B0E6
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Apr 2025 08:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBCD217F32C
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Apr 2025 06:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C28622D4C7;
	Wed, 16 Apr 2025 06:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Yab83KyK"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A40422CBF7
	for <linux-crypto@vger.kernel.org>; Wed, 16 Apr 2025 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785870; cv=none; b=aKsuIzwOwbv7fIgNlt0tZ3/J4Kmt22wOBVHJz5rqyzYLoEEirYWECHQpanS5EQDXojP/SJmFtKJO231JFiUCk52swGLidRyb/edhvaEdeuyqmivnjhUi2uApCr1urZuTQe4PkdKc24zznGb+TIq7VpwVB5/clUp8D1EDVrktlqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785870; c=relaxed/simple;
	bh=PGPXyoRkh+P/KyHpgJxeayybp+DWdUZpptPRS7QEKuI=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=NHy5TcDHLMZ9yFjkzxmKk1duUki0rTrsIKYpflngI7N47Mb6XjR24mRnCh9qH/VJL4iK1OmfG642HSuuD0VlAer70+s/mLu1xrHwFJ8sFR7Pa2sqCevaXO7Q6EdD0NmHlDeymX1JMkvMtzMYw6O30dYfyh9tifgb9y1no1hRsqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Yab83KyK; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=To:Subject:From:References:In-Reply-To:Message-Id:Date:Sender:
	Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=b94ooEKlqlYjFWw6S6vLac/TUl6o8Q6QLEq1tvu/81Y=; b=Yab83KyKltaihL30f1mndytTUb
	leb47SxspS7yXvbcl8xMXwKuc43IkExvjyD2uFmUoNkiJLIt2zrHNi/KeF4+exfNxMAOo5G5Og91w
	ZR54LvoJ11ZHo2yV8mOGLTC26wfo9NPJfNOyQmorNcfdhTkY44tiz8NnrFL9Q2aBPpcrTdqS4gSlq
	UYMBKFl2UWV4njhDq4T46q87tQg3D1EGHlGqaGgwYYIU/0VhokqOPq1guic+Ph+s9vAXA7T97/Jo9
	S0zWomGocBo9U4gyzue4ATN8nPHGXjgOPm92ivrUhz0DWNF6aEdzgzghkHVd4zQridnlnPE0v8bOV
	hmjHl07g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u4wVU-00G6P6-17;
	Wed, 16 Apr 2025 14:44:25 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 16 Apr 2025 14:44:24 +0800
Date: Wed, 16 Apr 2025 14:44:24 +0800
Message-Id: <d2406e9ad5e7f7c6405e5655e86527179e05ab51.1744784515.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1744784515.git.herbert@gondor.apana.org.au>
References: <cover.1744784515.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 44/67] crypto: x86/sha512 - Use API partial block handling
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

Use the Crypto API partial block handling.

Also remove the unnecessary SIMD fallback path.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 arch/x86/crypto/sha512_ssse3_glue.c | 79 ++++++++++-------------------
 include/crypto/sha2.h               |  1 +
 include/crypto/sha512_base.h        | 54 ++++++++++++++++++--
 3 files changed, 77 insertions(+), 57 deletions(-)

diff --git a/arch/x86/crypto/sha512_ssse3_glue.c b/arch/x86/crypto/sha512_ssse3_glue.c
index 6d3b85e53d0e..067684c54395 100644
--- a/arch/x86/crypto/sha512_ssse3_glue.c
+++ b/arch/x86/crypto/sha512_ssse3_glue.c
@@ -27,17 +27,13 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
-#include <crypto/internal/hash.h>
-#include <crypto/internal/simd.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/mm.h>
-#include <linux/string.h>
-#include <linux/types.h>
-#include <crypto/sha2.h>
-#include <crypto/sha512_base.h>
 #include <asm/cpu_device_id.h>
 #include <asm/simd.h>
+#include <crypto/internal/hash.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <crypto/sha2.h>
+#include <crypto/sha512_base.h>
 
 asmlinkage void sha512_transform_ssse3(struct sha512_state *state,
 				       const u8 *data, int blocks);
@@ -45,11 +41,7 @@ asmlinkage void sha512_transform_ssse3(struct sha512_state *state,
 static int sha512_update(struct shash_desc *desc, const u8 *data,
 		       unsigned int len, sha512_block_fn *sha512_xform)
 {
-	struct sha512_state *sctx = shash_desc_ctx(desc);
-
-	if (!crypto_simd_usable() ||
-	    (sctx->count[0] % SHA512_BLOCK_SIZE) + len < SHA512_BLOCK_SIZE)
-		return crypto_sha512_update(desc, data, len);
+	int remain;
 
 	/*
 	 * Make sure struct sha512_state begins directly with the SHA512
@@ -58,22 +50,17 @@ static int sha512_update(struct shash_desc *desc, const u8 *data,
 	BUILD_BUG_ON(offsetof(struct sha512_state, state) != 0);
 
 	kernel_fpu_begin();
-	sha512_base_do_update(desc, data, len, sha512_xform);
+	remain = sha512_base_do_update_blocks(desc, data, len, sha512_xform);
 	kernel_fpu_end();
 
-	return 0;
+	return remain;
 }
 
 static int sha512_finup(struct shash_desc *desc, const u8 *data,
 	      unsigned int len, u8 *out, sha512_block_fn *sha512_xform)
 {
-	if (!crypto_simd_usable())
-		return crypto_sha512_finup(desc, data, len, out);
-
 	kernel_fpu_begin();
-	if (len)
-		sha512_base_do_update(desc, data, len, sha512_xform);
-	sha512_base_do_finalize(desc, sha512_xform);
+	sha512_base_do_finup(desc, data, len, sha512_xform);
 	kernel_fpu_end();
 
 	return sha512_base_finish(desc, out);
@@ -91,23 +78,18 @@ static int sha512_ssse3_finup(struct shash_desc *desc, const u8 *data,
 	return sha512_finup(desc, data, len, out, sha512_transform_ssse3);
 }
 
-/* Add padding and return the message digest. */
-static int sha512_ssse3_final(struct shash_desc *desc, u8 *out)
-{
-	return sha512_ssse3_finup(desc, NULL, 0, out);
-}
-
 static struct shash_alg sha512_ssse3_algs[] = { {
 	.digestsize	=	SHA512_DIGEST_SIZE,
 	.init		=	sha512_base_init,
 	.update		=	sha512_ssse3_update,
-	.final		=	sha512_ssse3_final,
 	.finup		=	sha512_ssse3_finup,
-	.descsize	=	sizeof(struct sha512_state),
+	.descsize	=	SHA512_STATE_SIZE,
 	.base		=	{
 		.cra_name	=	"sha512",
 		.cra_driver_name =	"sha512-ssse3",
 		.cra_priority	=	150,
+		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
+					CRYPTO_AHASH_ALG_FINUP_MAX,
 		.cra_blocksize	=	SHA512_BLOCK_SIZE,
 		.cra_module	=	THIS_MODULE,
 	}
@@ -115,13 +97,14 @@ static struct shash_alg sha512_ssse3_algs[] = { {
 	.digestsize	=	SHA384_DIGEST_SIZE,
 	.init		=	sha384_base_init,
 	.update		=	sha512_ssse3_update,
-	.final		=	sha512_ssse3_final,
 	.finup		=	sha512_ssse3_finup,
-	.descsize	=	sizeof(struct sha512_state),
+	.descsize	=	SHA512_STATE_SIZE,
 	.base		=	{
 		.cra_name	=	"sha384",
 		.cra_driver_name =	"sha384-ssse3",
 		.cra_priority	=	150,
+		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
+					CRYPTO_AHASH_ALG_FINUP_MAX,
 		.cra_blocksize	=	SHA384_BLOCK_SIZE,
 		.cra_module	=	THIS_MODULE,
 	}
@@ -167,23 +150,18 @@ static int sha512_avx_finup(struct shash_desc *desc, const u8 *data,
 	return sha512_finup(desc, data, len, out, sha512_transform_avx);
 }
 
-/* Add padding and return the message digest. */
-static int sha512_avx_final(struct shash_desc *desc, u8 *out)
-{
-	return sha512_avx_finup(desc, NULL, 0, out);
-}
-
 static struct shash_alg sha512_avx_algs[] = { {
 	.digestsize	=	SHA512_DIGEST_SIZE,
 	.init		=	sha512_base_init,
 	.update		=	sha512_avx_update,
-	.final		=	sha512_avx_final,
 	.finup		=	sha512_avx_finup,
-	.descsize	=	sizeof(struct sha512_state),
+	.descsize	=	SHA512_STATE_SIZE,
 	.base		=	{
 		.cra_name	=	"sha512",
 		.cra_driver_name =	"sha512-avx",
 		.cra_priority	=	160,
+		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
+					CRYPTO_AHASH_ALG_FINUP_MAX,
 		.cra_blocksize	=	SHA512_BLOCK_SIZE,
 		.cra_module	=	THIS_MODULE,
 	}
@@ -191,13 +169,14 @@ static struct shash_alg sha512_avx_algs[] = { {
 	.digestsize	=	SHA384_DIGEST_SIZE,
 	.init		=	sha384_base_init,
 	.update		=	sha512_avx_update,
-	.final		=	sha512_avx_final,
 	.finup		=	sha512_avx_finup,
-	.descsize	=	sizeof(struct sha512_state),
+	.descsize	=	SHA512_STATE_SIZE,
 	.base		=	{
 		.cra_name	=	"sha384",
 		.cra_driver_name =	"sha384-avx",
 		.cra_priority	=	160,
+		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
+					CRYPTO_AHASH_ALG_FINUP_MAX,
 		.cra_blocksize	=	SHA384_BLOCK_SIZE,
 		.cra_module	=	THIS_MODULE,
 	}
@@ -233,23 +212,18 @@ static int sha512_avx2_finup(struct shash_desc *desc, const u8 *data,
 	return sha512_finup(desc, data, len, out, sha512_transform_rorx);
 }
 
-/* Add padding and return the message digest. */
-static int sha512_avx2_final(struct shash_desc *desc, u8 *out)
-{
-	return sha512_avx2_finup(desc, NULL, 0, out);
-}
-
 static struct shash_alg sha512_avx2_algs[] = { {
 	.digestsize	=	SHA512_DIGEST_SIZE,
 	.init		=	sha512_base_init,
 	.update		=	sha512_avx2_update,
-	.final		=	sha512_avx2_final,
 	.finup		=	sha512_avx2_finup,
-	.descsize	=	sizeof(struct sha512_state),
+	.descsize	=	SHA512_STATE_SIZE,
 	.base		=	{
 		.cra_name	=	"sha512",
 		.cra_driver_name =	"sha512-avx2",
 		.cra_priority	=	170,
+		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
+					CRYPTO_AHASH_ALG_FINUP_MAX,
 		.cra_blocksize	=	SHA512_BLOCK_SIZE,
 		.cra_module	=	THIS_MODULE,
 	}
@@ -257,13 +231,14 @@ static struct shash_alg sha512_avx2_algs[] = { {
 	.digestsize	=	SHA384_DIGEST_SIZE,
 	.init		=	sha384_base_init,
 	.update		=	sha512_avx2_update,
-	.final		=	sha512_avx2_final,
 	.finup		=	sha512_avx2_finup,
-	.descsize	=	sizeof(struct sha512_state),
+	.descsize	=	SHA512_STATE_SIZE,
 	.base		=	{
 		.cra_name	=	"sha384",
 		.cra_driver_name =	"sha384-avx2",
 		.cra_priority	=	170,
+		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
+					CRYPTO_AHASH_ALG_FINUP_MAX,
 		.cra_blocksize	=	SHA384_BLOCK_SIZE,
 		.cra_module	=	THIS_MODULE,
 	}
diff --git a/include/crypto/sha2.h b/include/crypto/sha2.h
index a913bad5dd3b..e9ad7ab955aa 100644
--- a/include/crypto/sha2.h
+++ b/include/crypto/sha2.h
@@ -19,6 +19,7 @@
 
 #define SHA512_DIGEST_SIZE      64
 #define SHA512_BLOCK_SIZE       128
+#define SHA512_STATE_SIZE       80
 
 #define SHA224_H0	0xc1059ed8UL
 #define SHA224_H1	0x367cd507UL
diff --git a/include/crypto/sha512_base.h b/include/crypto/sha512_base.h
index 679916a84cb2..8cb172e52dc0 100644
--- a/include/crypto/sha512_base.h
+++ b/include/crypto/sha512_base.h
@@ -10,10 +10,7 @@
 
 #include <crypto/internal/hash.h>
 #include <crypto/sha2.h>
-#include <linux/crypto.h>
-#include <linux/module.h>
 #include <linux/string.h>
-
 #include <linux/unaligned.h>
 
 typedef void (sha512_block_fn)(struct sha512_state *sst, u8 const *src,
@@ -93,6 +90,55 @@ static inline int sha512_base_do_update(struct shash_desc *desc,
 	return 0;
 }
 
+static inline int sha512_base_do_update_blocks(struct shash_desc *desc,
+					       const u8 *data,
+					       unsigned int len,
+					       sha512_block_fn *block_fn)
+{
+	unsigned int remain = len - round_down(len, SHA512_BLOCK_SIZE);
+	struct sha512_state *sctx = shash_desc_ctx(desc);
+
+	len -= remain;
+	sctx->count[0] += len;
+	if (sctx->count[0] < len)
+		sctx->count[1]++;
+	block_fn(sctx, data, len / SHA512_BLOCK_SIZE);
+	return remain;
+}
+
+static inline int sha512_base_do_finup(struct shash_desc *desc, const u8 *src,
+				       unsigned int len,
+				       sha512_block_fn *block_fn)
+{
+	unsigned int bit_offset = SHA512_BLOCK_SIZE / 8 - 2;
+	struct sha512_state *sctx = shash_desc_ctx(desc);
+	union {
+		__be64 b64[SHA512_BLOCK_SIZE / 4];
+		u8 u8[SHA512_BLOCK_SIZE * 2];
+	} block = {};
+
+	if (len >= SHA512_BLOCK_SIZE) {
+		int remain;
+
+		remain = sha512_base_do_update_blocks(desc, src, len, block_fn);
+		src += len - remain;
+		len = remain;
+	}
+
+	if (len >= bit_offset * 8)
+		bit_offset += SHA512_BLOCK_SIZE / 8;
+	memcpy(&block, src, len);
+	block.u8[len] = 0x80;
+	sctx->count[0] += len;
+	block.b64[bit_offset] = cpu_to_be64(sctx->count[1] << 3 |
+					    sctx->count[0] >> 61);
+	block.b64[bit_offset + 1] = cpu_to_be64(sctx->count[0] << 3);
+	block_fn(sctx, block.u8, (bit_offset + 2) * 8 / SHA512_BLOCK_SIZE);
+	memzero_explicit(&block, sizeof(block));
+
+	return 0;
+}
+
 static inline int sha512_base_do_finalize(struct shash_desc *desc,
 					  sha512_block_fn *block_fn)
 {
@@ -126,8 +172,6 @@ static inline int sha512_base_finish(struct shash_desc *desc, u8 *out)
 
 	for (i = 0; digest_size > 0; i++, digest_size -= sizeof(__be64))
 		put_unaligned_be64(sctx->state[i], digest++);
-
-	memzero_explicit(sctx, sizeof(*sctx));
 	return 0;
 }
 
-- 
2.39.5



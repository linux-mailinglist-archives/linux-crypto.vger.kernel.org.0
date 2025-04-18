Return-Path: <linux-crypto+bounces-11930-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C60FA93066
	for <lists+linux-crypto@lfdr.de>; Fri, 18 Apr 2025 05:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B12B8E3BD9
	for <lists+linux-crypto@lfdr.de>; Fri, 18 Apr 2025 03:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23FA26982A;
	Fri, 18 Apr 2025 02:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="V8wXZEIB"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A3B269817
	for <linux-crypto@vger.kernel.org>; Fri, 18 Apr 2025 02:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744945187; cv=none; b=cbmUwjoYb/n1bSsB14lPXGtwUb4jEA0lD2GGSMnzvFxdVhRv0qMlB65qfVaYuP1UmLJ/q2/Tt8OPtPNP9fuRuuArSMyZt6utK8ZaqIxT8KJxMzfC6SlGdDpYCwqNvEv3qMiQ50XfzFIWmof4P11TBJQjpJjO544/xpUL3iXK8lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744945187; c=relaxed/simple;
	bh=NgvX9mJ3VEWJfq7wwUrh5X/l2E40PXmWHCjIxrkeI2s=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=JmSzlURssMDeYQgsWJZAkqJIbRj70RfmxM7O9wWowE/HCt6xr4BWifux0fqLILZDOM90HTXx+bt3y5bjgspoyuhaXBIBgeh/6qHBCSFv4EWZEMbwR8rHqTMT+PwMrKDGzyKCScgUj/WkSzMjxePoVwOZ8G8+oNIa+UaSK1NQNOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=V8wXZEIB; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=To:Subject:From:References:In-Reply-To:Message-Id:Date:Sender:
	Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Cou/jZ1H56aoHLbX2TFvAwtgtxKIMUc+zpPe8kd1/28=; b=V8wXZEIBonVtSPvSWST9Hty42S
	VmrJkp1g4hLcwzi+vYAaxWZ58nqoer0Rjjyz5XnPYdiihYf/KL4tAlbEf5KKHSJZ2D1YqzOKTKoUd
	KqPtCIlBEHd3Wkllb1re7vJr73mdTLIvL0AyuJjSP7NaBdhHsbUeUPDJXYIvOz5/y74NKhmigONsq
	xmf3STReivdfFnzJcgsIhaRzXIKjJ0JPQobzXYJdSRVmTTfUN43qfgieOgZNlgaJLeMbFPrv9EcYe
	TdZwQ2jvC9p7PFtvtzl8ZpIa2n0BlBwbwzQF3dT73zKxMJ9zNahvWijmrFdewr7s7tj1rpfv0f+82
	zyBBwHZA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u5bx7-00Ge8J-0v;
	Fri, 18 Apr 2025 10:59:42 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Apr 2025 10:59:41 +0800
Date: Fri, 18 Apr 2025 10:59:41 +0800
Message-Id: <90dc6c4603dbd8fa7ec67baa17471b441ae0ddb8.1744945025.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1744945025.git.herbert@gondor.apana.org.au>
References: <cover.1744945025.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v2 PATCH 27/67] crypto: x86/sha256 - Use API partial block handling
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
 arch/x86/crypto/sha256_ssse3_glue.c | 106 +++++++++++-----------------
 include/crypto/sha2.h               |   5 ++
 include/crypto/sha256_base.h        |  80 +++++++++++++++++++--
 3 files changed, 118 insertions(+), 73 deletions(-)

diff --git a/arch/x86/crypto/sha256_ssse3_glue.c b/arch/x86/crypto/sha256_ssse3_glue.c
index 429a3cefbab4..7c5b498c1a85 100644
--- a/arch/x86/crypto/sha256_ssse3_glue.c
+++ b/arch/x86/crypto/sha256_ssse3_glue.c
@@ -29,19 +29,14 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
+#include <asm/cpu_device_id.h>
 #include <crypto/internal/hash.h>
-#include <crypto/internal/simd.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/mm.h>
-#include <linux/types.h>
 #include <crypto/sha2.h>
 #include <crypto/sha256_base.h>
-#include <linux/string.h>
-#include <asm/cpu_device_id.h>
-#include <asm/simd.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 
-asmlinkage void sha256_transform_ssse3(struct sha256_state *state,
+asmlinkage void sha256_transform_ssse3(struct crypto_sha256_state *state,
 				       const u8 *data, int blocks);
 
 static const struct x86_cpu_id module_cpu_ids[] = {
@@ -54,37 +49,29 @@ static const struct x86_cpu_id module_cpu_ids[] = {
 MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
 static int _sha256_update(struct shash_desc *desc, const u8 *data,
-			  unsigned int len, sha256_block_fn *sha256_xform)
+			  unsigned int len,
+			  crypto_sha256_block_fn *sha256_xform)
 {
-	struct sha256_state *sctx = shash_desc_ctx(desc);
-
-	if (!crypto_simd_usable() ||
-	    (sctx->count % SHA256_BLOCK_SIZE) + len < SHA256_BLOCK_SIZE)
-		return crypto_sha256_update(desc, data, len);
+	int remain;
 
 	/*
-	 * Make sure struct sha256_state begins directly with the SHA256
+	 * Make sure struct crypto_sha256_state begins directly with the SHA256
 	 * 256-bit internal state, as this is what the asm functions expect.
 	 */
-	BUILD_BUG_ON(offsetof(struct sha256_state, state) != 0);
+	BUILD_BUG_ON(offsetof(struct crypto_sha256_state, state) != 0);
 
 	kernel_fpu_begin();
-	sha256_base_do_update(desc, data, len, sha256_xform);
+	remain = sha256_base_do_update_blocks(desc, data, len, sha256_xform);
 	kernel_fpu_end();
 
-	return 0;
+	return remain;
 }
 
 static int sha256_finup(struct shash_desc *desc, const u8 *data,
-	      unsigned int len, u8 *out, sha256_block_fn *sha256_xform)
+	      unsigned int len, u8 *out, crypto_sha256_block_fn *sha256_xform)
 {
-	if (!crypto_simd_usable())
-		return crypto_sha256_finup(desc, data, len, out);
-
 	kernel_fpu_begin();
-	if (len)
-		sha256_base_do_update(desc, data, len, sha256_xform);
-	sha256_base_do_finalize(desc, sha256_xform);
+	sha256_base_do_finup(desc, data, len, sha256_xform);
 	kernel_fpu_end();
 
 	return sha256_base_finish(desc, out);
@@ -102,12 +89,6 @@ static int sha256_ssse3_finup(struct shash_desc *desc, const u8 *data,
 	return sha256_finup(desc, data, len, out, sha256_transform_ssse3);
 }
 
-/* Add padding and return the message digest. */
-static int sha256_ssse3_final(struct shash_desc *desc, u8 *out)
-{
-	return sha256_ssse3_finup(desc, NULL, 0, out);
-}
-
 static int sha256_ssse3_digest(struct shash_desc *desc, const u8 *data,
 	      unsigned int len, u8 *out)
 {
@@ -119,14 +100,15 @@ static struct shash_alg sha256_ssse3_algs[] = { {
 	.digestsize	=	SHA256_DIGEST_SIZE,
 	.init		=	sha256_base_init,
 	.update		=	sha256_ssse3_update,
-	.final		=	sha256_ssse3_final,
 	.finup		=	sha256_ssse3_finup,
 	.digest		=	sha256_ssse3_digest,
-	.descsize	=	sizeof(struct sha256_state),
+	.descsize	=	sizeof(struct crypto_sha256_state),
 	.base		=	{
 		.cra_name	=	"sha256",
 		.cra_driver_name =	"sha256-ssse3",
 		.cra_priority	=	150,
+		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
+					CRYPTO_AHASH_ALG_FINUP_MAX,
 		.cra_blocksize	=	SHA256_BLOCK_SIZE,
 		.cra_module	=	THIS_MODULE,
 	}
@@ -134,13 +116,14 @@ static struct shash_alg sha256_ssse3_algs[] = { {
 	.digestsize	=	SHA224_DIGEST_SIZE,
 	.init		=	sha224_base_init,
 	.update		=	sha256_ssse3_update,
-	.final		=	sha256_ssse3_final,
 	.finup		=	sha256_ssse3_finup,
-	.descsize	=	sizeof(struct sha256_state),
+	.descsize	=	sizeof(struct crypto_sha256_state),
 	.base		=	{
 		.cra_name	=	"sha224",
 		.cra_driver_name =	"sha224-ssse3",
 		.cra_priority	=	150,
+		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
+					CRYPTO_AHASH_ALG_FINUP_MAX,
 		.cra_blocksize	=	SHA224_BLOCK_SIZE,
 		.cra_module	=	THIS_MODULE,
 	}
@@ -161,7 +144,7 @@ static void unregister_sha256_ssse3(void)
 				ARRAY_SIZE(sha256_ssse3_algs));
 }
 
-asmlinkage void sha256_transform_avx(struct sha256_state *state,
+asmlinkage void sha256_transform_avx(struct crypto_sha256_state *state,
 				     const u8 *data, int blocks);
 
 static int sha256_avx_update(struct shash_desc *desc, const u8 *data,
@@ -176,11 +159,6 @@ static int sha256_avx_finup(struct shash_desc *desc, const u8 *data,
 	return sha256_finup(desc, data, len, out, sha256_transform_avx);
 }
 
-static int sha256_avx_final(struct shash_desc *desc, u8 *out)
-{
-	return sha256_avx_finup(desc, NULL, 0, out);
-}
-
 static int sha256_avx_digest(struct shash_desc *desc, const u8 *data,
 		      unsigned int len, u8 *out)
 {
@@ -192,14 +170,15 @@ static struct shash_alg sha256_avx_algs[] = { {
 	.digestsize	=	SHA256_DIGEST_SIZE,
 	.init		=	sha256_base_init,
 	.update		=	sha256_avx_update,
-	.final		=	sha256_avx_final,
 	.finup		=	sha256_avx_finup,
 	.digest		=	sha256_avx_digest,
-	.descsize	=	sizeof(struct sha256_state),
+	.descsize	=	sizeof(struct crypto_sha256_state),
 	.base		=	{
 		.cra_name	=	"sha256",
 		.cra_driver_name =	"sha256-avx",
 		.cra_priority	=	160,
+		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
+					CRYPTO_AHASH_ALG_FINUP_MAX,
 		.cra_blocksize	=	SHA256_BLOCK_SIZE,
 		.cra_module	=	THIS_MODULE,
 	}
@@ -207,13 +186,14 @@ static struct shash_alg sha256_avx_algs[] = { {
 	.digestsize	=	SHA224_DIGEST_SIZE,
 	.init		=	sha224_base_init,
 	.update		=	sha256_avx_update,
-	.final		=	sha256_avx_final,
 	.finup		=	sha256_avx_finup,
-	.descsize	=	sizeof(struct sha256_state),
+	.descsize	=	sizeof(struct crypto_sha256_state),
 	.base		=	{
 		.cra_name	=	"sha224",
 		.cra_driver_name =	"sha224-avx",
 		.cra_priority	=	160,
+		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
+					CRYPTO_AHASH_ALG_FINUP_MAX,
 		.cra_blocksize	=	SHA224_BLOCK_SIZE,
 		.cra_module	=	THIS_MODULE,
 	}
@@ -245,7 +225,7 @@ static void unregister_sha256_avx(void)
 				ARRAY_SIZE(sha256_avx_algs));
 }
 
-asmlinkage void sha256_transform_rorx(struct sha256_state *state,
+asmlinkage void sha256_transform_rorx(struct crypto_sha256_state *state,
 				      const u8 *data, int blocks);
 
 static int sha256_avx2_update(struct shash_desc *desc, const u8 *data,
@@ -260,11 +240,6 @@ static int sha256_avx2_finup(struct shash_desc *desc, const u8 *data,
 	return sha256_finup(desc, data, len, out, sha256_transform_rorx);
 }
 
-static int sha256_avx2_final(struct shash_desc *desc, u8 *out)
-{
-	return sha256_avx2_finup(desc, NULL, 0, out);
-}
-
 static int sha256_avx2_digest(struct shash_desc *desc, const u8 *data,
 		      unsigned int len, u8 *out)
 {
@@ -276,14 +251,15 @@ static struct shash_alg sha256_avx2_algs[] = { {
 	.digestsize	=	SHA256_DIGEST_SIZE,
 	.init		=	sha256_base_init,
 	.update		=	sha256_avx2_update,
-	.final		=	sha256_avx2_final,
 	.finup		=	sha256_avx2_finup,
 	.digest		=	sha256_avx2_digest,
-	.descsize	=	sizeof(struct sha256_state),
+	.descsize	=	sizeof(struct crypto_sha256_state),
 	.base		=	{
 		.cra_name	=	"sha256",
 		.cra_driver_name =	"sha256-avx2",
 		.cra_priority	=	170,
+		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
+					CRYPTO_AHASH_ALG_FINUP_MAX,
 		.cra_blocksize	=	SHA256_BLOCK_SIZE,
 		.cra_module	=	THIS_MODULE,
 	}
@@ -291,13 +267,14 @@ static struct shash_alg sha256_avx2_algs[] = { {
 	.digestsize	=	SHA224_DIGEST_SIZE,
 	.init		=	sha224_base_init,
 	.update		=	sha256_avx2_update,
-	.final		=	sha256_avx2_final,
 	.finup		=	sha256_avx2_finup,
-	.descsize	=	sizeof(struct sha256_state),
+	.descsize	=	sizeof(struct crypto_sha256_state),
 	.base		=	{
 		.cra_name	=	"sha224",
 		.cra_driver_name =	"sha224-avx2",
 		.cra_priority	=	170,
+		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
+					CRYPTO_AHASH_ALG_FINUP_MAX,
 		.cra_blocksize	=	SHA224_BLOCK_SIZE,
 		.cra_module	=	THIS_MODULE,
 	}
@@ -327,7 +304,7 @@ static void unregister_sha256_avx2(void)
 				ARRAY_SIZE(sha256_avx2_algs));
 }
 
-asmlinkage void sha256_ni_transform(struct sha256_state *digest,
+asmlinkage void sha256_ni_transform(struct crypto_sha256_state *digest,
 				    const u8 *data, int rounds);
 
 static int sha256_ni_update(struct shash_desc *desc, const u8 *data,
@@ -342,11 +319,6 @@ static int sha256_ni_finup(struct shash_desc *desc, const u8 *data,
 	return sha256_finup(desc, data, len, out, sha256_ni_transform);
 }
 
-static int sha256_ni_final(struct shash_desc *desc, u8 *out)
-{
-	return sha256_ni_finup(desc, NULL, 0, out);
-}
-
 static int sha256_ni_digest(struct shash_desc *desc, const u8 *data,
 		      unsigned int len, u8 *out)
 {
@@ -358,14 +330,15 @@ static struct shash_alg sha256_ni_algs[] = { {
 	.digestsize	=	SHA256_DIGEST_SIZE,
 	.init		=	sha256_base_init,
 	.update		=	sha256_ni_update,
-	.final		=	sha256_ni_final,
 	.finup		=	sha256_ni_finup,
 	.digest		=	sha256_ni_digest,
-	.descsize	=	sizeof(struct sha256_state),
+	.descsize	=	sizeof(struct crypto_sha256_state),
 	.base		=	{
 		.cra_name	=	"sha256",
 		.cra_driver_name =	"sha256-ni",
 		.cra_priority	=	250,
+		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
+					CRYPTO_AHASH_ALG_FINUP_MAX,
 		.cra_blocksize	=	SHA256_BLOCK_SIZE,
 		.cra_module	=	THIS_MODULE,
 	}
@@ -373,13 +346,14 @@ static struct shash_alg sha256_ni_algs[] = { {
 	.digestsize	=	SHA224_DIGEST_SIZE,
 	.init		=	sha224_base_init,
 	.update		=	sha256_ni_update,
-	.final		=	sha256_ni_final,
 	.finup		=	sha256_ni_finup,
-	.descsize	=	sizeof(struct sha256_state),
+	.descsize	=	sizeof(struct crypto_sha256_state),
 	.base		=	{
 		.cra_name	=	"sha224",
 		.cra_driver_name =	"sha224-ni",
 		.cra_priority	=	250,
+		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
+					CRYPTO_AHASH_ALG_FINUP_MAX,
 		.cra_blocksize	=	SHA224_BLOCK_SIZE,
 		.cra_module	=	THIS_MODULE,
 	}
diff --git a/include/crypto/sha2.h b/include/crypto/sha2.h
index b9e9281d76c9..d9b1b9932393 100644
--- a/include/crypto/sha2.h
+++ b/include/crypto/sha2.h
@@ -64,6 +64,11 @@ extern const u8 sha384_zero_message_hash[SHA384_DIGEST_SIZE];
 
 extern const u8 sha512_zero_message_hash[SHA512_DIGEST_SIZE];
 
+struct crypto_sha256_state {
+	u32 state[SHA256_DIGEST_SIZE / 4];
+	u64 count;
+};
+
 struct sha256_state {
 	u32 state[SHA256_DIGEST_SIZE / 4];
 	u64 count;
diff --git a/include/crypto/sha256_base.h b/include/crypto/sha256_base.h
index e0418818d63c..727a1b63e1e9 100644
--- a/include/crypto/sha256_base.h
+++ b/include/crypto/sha256_base.h
@@ -8,15 +8,17 @@
 #ifndef _CRYPTO_SHA256_BASE_H
 #define _CRYPTO_SHA256_BASE_H
 
-#include <asm/byteorder.h>
-#include <linux/unaligned.h>
 #include <crypto/internal/hash.h>
 #include <crypto/sha2.h>
+#include <linux/math.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/unaligned.h>
 
 typedef void (sha256_block_fn)(struct sha256_state *sst, u8 const *src,
 			       int blocks);
+typedef void (crypto_sha256_block_fn)(struct crypto_sha256_state *sst,
+				      u8 const *src, int blocks);
 
 static inline int sha224_base_init(struct shash_desc *desc)
 {
@@ -81,6 +83,64 @@ static inline int sha256_base_do_update(struct shash_desc *desc,
 	return lib_sha256_base_do_update(sctx, data, len, block_fn);
 }
 
+static inline int lib_sha256_base_do_update_blocks(
+	struct crypto_sha256_state *sctx, const u8 *data, unsigned int len,
+	crypto_sha256_block_fn *block_fn)
+{
+	unsigned int remain = len - round_down(len, SHA256_BLOCK_SIZE);
+
+	sctx->count += len - remain;
+	block_fn(sctx, data, len / SHA256_BLOCK_SIZE);
+	return remain;
+}
+
+static inline int sha256_base_do_update_blocks(
+	struct shash_desc *desc, const u8 *data, unsigned int len,
+	crypto_sha256_block_fn *block_fn)
+{
+	return lib_sha256_base_do_update_blocks(shash_desc_ctx(desc), data,
+						len, block_fn);
+}
+
+static inline int lib_sha256_base_do_finup(struct crypto_sha256_state *sctx,
+					   const u8 *src, unsigned int len,
+					   crypto_sha256_block_fn *block_fn)
+{
+	unsigned int bit_offset = SHA256_BLOCK_SIZE / 8 - 1;
+	union {
+		__be64 b64[SHA256_BLOCK_SIZE / 4];
+		u8 u8[SHA256_BLOCK_SIZE * 2];
+	} block = {};
+
+	if (len >= bit_offset * 8)
+		bit_offset += SHA256_BLOCK_SIZE / 8;
+	memcpy(&block, src, len);
+	block.u8[len] = 0x80;
+	sctx->count += len;
+	block.b64[bit_offset] = cpu_to_be64(sctx->count << 3);
+	block_fn(sctx, block.u8, (bit_offset + 1) * 8 / SHA256_BLOCK_SIZE);
+	memzero_explicit(&block, sizeof(block));
+
+	return 0;
+}
+
+static inline int sha256_base_do_finup(struct shash_desc *desc,
+				       const u8 *src, unsigned int len,
+				       crypto_sha256_block_fn *block_fn)
+{
+	struct crypto_sha256_state *sctx = shash_desc_ctx(desc);
+
+	if (len >= SHA256_BLOCK_SIZE) {
+		int remain;
+
+		remain = lib_sha256_base_do_update_blocks(sctx, src, len,
+							  block_fn);
+		src += len - remain;
+		len = remain;
+	}
+	return lib_sha256_base_do_finup(sctx, src, len, block_fn);
+}
+
 static inline int lib_sha256_base_do_finalize(struct sha256_state *sctx,
 					      sha256_block_fn *block_fn)
 {
@@ -111,15 +171,21 @@ static inline int sha256_base_do_finalize(struct shash_desc *desc,
 	return lib_sha256_base_do_finalize(sctx, block_fn);
 }
 
-static inline int lib_sha256_base_finish(struct sha256_state *sctx, u8 *out,
-					 unsigned int digest_size)
+static inline int __sha256_base_finish(u32 state[SHA256_DIGEST_SIZE / 4],
+				       u8 *out, unsigned int digest_size)
 {
 	__be32 *digest = (__be32 *)out;
 	int i;
 
 	for (i = 0; digest_size > 0; i++, digest_size -= sizeof(__be32))
-		put_unaligned_be32(sctx->state[i], digest++);
+		put_unaligned_be32(state[i], digest++);
+	return 0;
+}
 
+static inline int lib_sha256_base_finish(struct sha256_state *sctx, u8 *out,
+					 unsigned int digest_size)
+{
+	__sha256_base_finish(sctx->state, out, digest_size);
 	memzero_explicit(sctx, sizeof(*sctx));
 	return 0;
 }
@@ -127,9 +193,9 @@ static inline int lib_sha256_base_finish(struct sha256_state *sctx, u8 *out,
 static inline int sha256_base_finish(struct shash_desc *desc, u8 *out)
 {
 	unsigned int digest_size = crypto_shash_digestsize(desc->tfm);
-	struct sha256_state *sctx = shash_desc_ctx(desc);
+	struct crypto_sha256_state *sctx = shash_desc_ctx(desc);
 
-	return lib_sha256_base_finish(sctx, out, digest_size);
+	return __sha256_base_finish(sctx->state, out, digest_size);
 }
 
 #endif /* _CRYPTO_SHA256_BASE_H */
-- 
2.39.5



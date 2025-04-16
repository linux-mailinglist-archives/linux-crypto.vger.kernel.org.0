Return-Path: <linux-crypto+bounces-11807-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8770A8B0DA
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Apr 2025 08:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047C41902C0C
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Apr 2025 06:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310CE23875A;
	Wed, 16 Apr 2025 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="d63iEHoh"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2528E22B8BC
	for <linux-crypto@vger.kernel.org>; Wed, 16 Apr 2025 06:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785847; cv=none; b=Zh0C8BjIXC4gIfNwgG1L/KjMFE7PXhbO4+8wgR1YSd3GGL3BfWC6+pEuBYG+va9zGMXBzzql9GGqhirVCYUl+VmayIxJo2+PIjrd7EZ2teQRKyYzR4UX7NuNu/2e5kh8mgBE/ffasc35DufjJnVnyoxO0x+xt7ocblKF7ZQMpdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785847; c=relaxed/simple;
	bh=EzQTdQX4nKOaG+NE29ABjG5Kd1ERn4XcEi0KFs0a6zo=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=Rn/lV4mbbzopUi6/gljrPRkZBTpHPvw2/LxUr4CTbdvnd5Ehr3k3NHraKzJiiqjke/3yqYl58QF6NEIBIZW5GkCzq2Ol2ZLrfEXcUeO2Px9Qt94NzYLq3HXA+1OMFIiZSd0tIhuVsaEQdEWviCv+QjmVNXFMVTnWvDW5wPsb/hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=d63iEHoh; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=To:Subject:From:References:In-Reply-To:Message-Id:Date:Sender:
	Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Weml+9fW5NJY0MlmDSp0+EubRWyD/Ar09KevBxT+8Vs=; b=d63iEHohJ9qUUQx1StRiwI985x
	4lZnWn8ijJHuY6RC4jJaEb3ooJJGK5ZsJylmvZHOjexvK4MGVBsjgcxbvXKqWuwuzO1Og+X9GM+zX
	a/ee7USWtO1pl0Hy1/eI3OdotxO52ErsB4T2SNxkBLirMDTsnMTKVyu6uxUwgFrPalMnp8Zocgyjp
	xGGi1+p/UDlEhuXuA5xJvKS5CmfV7cdg43UTg2dx+O398EmrskMnZTdcGe9SDFcHB6s9n/x2R9y9N
	JOAqfUcDRIbkbnE6JNw33oImQz4Y6WSlDcOUBIGodAKSGK06f6dDHqk10zDSI6Vj6kMvblmT/IZo0
	2nuIC92g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u4wV7-00G6Mm-0h;
	Wed, 16 Apr 2025 14:44:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 16 Apr 2025 14:44:01 +0800
Date: Wed, 16 Apr 2025 14:44:01 +0800
Message-Id: <a1bd92682a28ccefc2e707262e5d9d011bcc2559.1744784515.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1744784515.git.herbert@gondor.apana.org.au>
References: <cover.1744784515.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 34/67] crypto: arm64/sha256-ce - Use API partial block
 handling
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
 arch/arm64/crypto/sha2-ce-glue.c | 90 +++++++-------------------------
 1 file changed, 18 insertions(+), 72 deletions(-)

diff --git a/arch/arm64/crypto/sha2-ce-glue.c b/arch/arm64/crypto/sha2-ce-glue.c
index 6b4866a88ded..912c215101eb 100644
--- a/arch/arm64/crypto/sha2-ce-glue.c
+++ b/arch/arm64/crypto/sha2-ce-glue.c
@@ -6,15 +6,13 @@
  */
 
 #include <asm/neon.h>
-#include <asm/simd.h>
-#include <linux/unaligned.h>
 #include <crypto/internal/hash.h>
-#include <crypto/internal/simd.h>
 #include <crypto/sha2.h>
 #include <crypto/sha256_base.h>
 #include <linux/cpufeature.h>
-#include <linux/crypto.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/string.h>
 
 MODULE_DESCRIPTION("SHA-224/SHA-256 secure hash using ARMv8 Crypto Extensions");
 MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
@@ -23,7 +21,7 @@ MODULE_ALIAS_CRYPTO("sha224");
 MODULE_ALIAS_CRYPTO("sha256");
 
 struct sha256_ce_state {
-	struct sha256_state	sst;
+	struct crypto_sha256_state sst;
 	u32			finalize;
 };
 
@@ -33,7 +31,7 @@ extern const u32 sha256_ce_offsetof_finalize;
 asmlinkage int __sha256_ce_transform(struct sha256_ce_state *sst, u8 const *src,
 				     int blocks);
 
-static void sha256_ce_transform(struct sha256_state *sst, u8 const *src,
+static void sha256_ce_transform(struct crypto_sha256_state *sst, u8 const *src,
 				int blocks)
 {
 	while (blocks) {
@@ -54,42 +52,21 @@ const u32 sha256_ce_offsetof_count = offsetof(struct sha256_ce_state,
 const u32 sha256_ce_offsetof_finalize = offsetof(struct sha256_ce_state,
 						 finalize);
 
-asmlinkage void sha256_block_data_order(u32 *digest, u8 const *src, int blocks);
-
-static void sha256_arm64_transform(struct sha256_state *sst, u8 const *src,
-				   int blocks)
-{
-	sha256_block_data_order(sst->state, src, blocks);
-}
-
 static int sha256_ce_update(struct shash_desc *desc, const u8 *data,
 			    unsigned int len)
 {
 	struct sha256_ce_state *sctx = shash_desc_ctx(desc);
 
-	if (!crypto_simd_usable())
-		return sha256_base_do_update(desc, data, len,
-					     sha256_arm64_transform);
-
 	sctx->finalize = 0;
-	sha256_base_do_update(desc, data, len, sha256_ce_transform);
-
-	return 0;
+	return sha256_base_do_update_blocks(desc, data, len,
+					    sha256_ce_transform);
 }
 
 static int sha256_ce_finup(struct shash_desc *desc, const u8 *data,
 			   unsigned int len, u8 *out)
 {
 	struct sha256_ce_state *sctx = shash_desc_ctx(desc);
-	bool finalize = !sctx->sst.count && !(len % SHA256_BLOCK_SIZE) && len;
-
-	if (!crypto_simd_usable()) {
-		if (len)
-			sha256_base_do_update(desc, data, len,
-					      sha256_arm64_transform);
-		sha256_base_do_finalize(desc, sha256_arm64_transform);
-		return sha256_base_finish(desc, out);
-	}
+	bool finalize = !(len % SHA256_BLOCK_SIZE) && len;
 
 	/*
 	 * Allow the asm code to perform the finalization if there is no
@@ -97,23 +74,11 @@ static int sha256_ce_finup(struct shash_desc *desc, const u8 *data,
 	 */
 	sctx->finalize = finalize;
 
-	sha256_base_do_update(desc, data, len, sha256_ce_transform);
-	if (!finalize)
-		sha256_base_do_finalize(desc, sha256_ce_transform);
-	return sha256_base_finish(desc, out);
-}
-
-static int sha256_ce_final(struct shash_desc *desc, u8 *out)
-{
-	struct sha256_ce_state *sctx = shash_desc_ctx(desc);
-
-	if (!crypto_simd_usable()) {
-		sha256_base_do_finalize(desc, sha256_arm64_transform);
-		return sha256_base_finish(desc, out);
-	}
-
-	sctx->finalize = 0;
-	sha256_base_do_finalize(desc, sha256_ce_transform);
+	if (finalize)
+		sha256_base_do_update_blocks(desc, data, len,
+					     sha256_ce_transform);
+	else
+		sha256_base_do_finup(desc, data, len, sha256_ce_transform);
 	return sha256_base_finish(desc, out);
 }
 
@@ -124,55 +89,36 @@ static int sha256_ce_digest(struct shash_desc *desc, const u8 *data,
 	return sha256_ce_finup(desc, data, len, out);
 }
 
-static int sha256_ce_export(struct shash_desc *desc, void *out)
-{
-	struct sha256_ce_state *sctx = shash_desc_ctx(desc);
-
-	memcpy(out, &sctx->sst, sizeof(struct sha256_state));
-	return 0;
-}
-
-static int sha256_ce_import(struct shash_desc *desc, const void *in)
-{
-	struct sha256_ce_state *sctx = shash_desc_ctx(desc);
-
-	memcpy(&sctx->sst, in, sizeof(struct sha256_state));
-	sctx->finalize = 0;
-	return 0;
-}
-
 static struct shash_alg algs[] = { {
 	.init			= sha224_base_init,
 	.update			= sha256_ce_update,
-	.final			= sha256_ce_final,
 	.finup			= sha256_ce_finup,
-	.export			= sha256_ce_export,
-	.import			= sha256_ce_import,
 	.descsize		= sizeof(struct sha256_ce_state),
-	.statesize		= sizeof(struct sha256_state),
+	.statesize		= sizeof(struct crypto_sha256_state),
 	.digestsize		= SHA224_DIGEST_SIZE,
 	.base			= {
 		.cra_name		= "sha224",
 		.cra_driver_name	= "sha224-ce",
 		.cra_priority		= 200,
+		.cra_flags		= CRYPTO_AHASH_ALG_BLOCK_ONLY |
+					  CRYPTO_AHASH_ALG_FINUP_MAX,
 		.cra_blocksize		= SHA256_BLOCK_SIZE,
 		.cra_module		= THIS_MODULE,
 	}
 }, {
 	.init			= sha256_base_init,
 	.update			= sha256_ce_update,
-	.final			= sha256_ce_final,
 	.finup			= sha256_ce_finup,
 	.digest			= sha256_ce_digest,
-	.export			= sha256_ce_export,
-	.import			= sha256_ce_import,
 	.descsize		= sizeof(struct sha256_ce_state),
-	.statesize		= sizeof(struct sha256_state),
+	.statesize		= sizeof(struct crypto_sha256_state),
 	.digestsize		= SHA256_DIGEST_SIZE,
 	.base			= {
 		.cra_name		= "sha256",
 		.cra_driver_name	= "sha256-ce",
 		.cra_priority		= 200,
+		.cra_flags		= CRYPTO_AHASH_ALG_BLOCK_ONLY |
+					  CRYPTO_AHASH_ALG_FINUP_MAX,
 		.cra_blocksize		= SHA256_BLOCK_SIZE,
 		.cra_module		= THIS_MODULE,
 	}
-- 
2.39.5



Return-Path: <linux-crypto+bounces-12383-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E66A9DF22
	for <lists+linux-crypto@lfdr.de>; Sun, 27 Apr 2025 07:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE3817B29D9
	for <lists+linux-crypto@lfdr.de>; Sun, 27 Apr 2025 05:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890561FF5EA;
	Sun, 27 Apr 2025 05:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="MgjfYMEk"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411E81CD213
	for <linux-crypto@vger.kernel.org>; Sun, 27 Apr 2025 05:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745731354; cv=none; b=oIArsQ3tAuZCGJAHKZqc6yEoZPxTSVKxVFNODgQuXTCSOrSFWZ7t1doZzp8BaaydqFc/npjVnzarWCQLplTaOBWczx5mQRnkBoJgbiWIUx5cJL/V77MjrcHmtvc1Kt5/NteebA0pbvAki9dBxkIDd6qPjaqiwHKTp7B8kH5P9OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745731354; c=relaxed/simple;
	bh=GGPLUur+XQbGCpfpOGxbeTjysautuHWthtv7hz5cZqI=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=PiyJMGFIApCuo3KBEtABLihT80Ws8rlzHubJlSyT29weWl83Rq/6HVkgTZ9ji8V4nKQhpjL69kgtkU8Clf792MJNG0FPaQzATil46wZzM9zC0JxYaHYz9iJAwGJn5qc8WOTzJ739L3pL9PqgzNwvQm5vbBiQuZ64IZHD18qQB7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=MgjfYMEk; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=To:Subject:From:References:In-Reply-To:Message-Id:Date:Sender:
	Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+fFJOhU2X9/nYaSwK1s3nOIEjyF2K8vgL0+iXMOzn3A=; b=MgjfYMEkzPRDf+2csfnfBgJFHP
	G2rjPU9Om8iIw79oS52FVufjZx1nqfGmS3TwDWUQd8C+IgJWuU/OR4upDfrND4A7mtMbtVhfDE8zH
	orr5Zv1vfY/pemKFPHm7ZZ1gHCtjjz9qqgMBvk7WbNUDaVb2svAja2o+aVN0UKYPnD1lDS8NTshmF
	CzVO2xH5rBIiQzNWu7h7KJD1NXvtFB1lQuqsMyOpV5Z8N4Km+6YQsGJVH77qO6mhZ074DnKKByPdX
	1/cyqe5GeM4zENxiR9yJTU3KszpfJ5dZhDygWtJJGytJEjcj3ypsKvUZiT0ndpr4y6sYdWEPjnbam
	ooLCn7ZQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u8uTE-001L1J-0d;
	Sun, 27 Apr 2025 13:22:29 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 27 Apr 2025 13:22:28 +0800
Date: Sun, 27 Apr 2025 13:22:28 +0800
Message-Id: <d28be0330a3fc986d2de2fc704d21f937c0d5579.1745730947.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1745730946.git.herbert@gondor.apana.org.au>
References: <cover.1745730946.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v3 PATCH 10/11] crypto: poly1305 - Remove algorithm
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

As there are no in-kernel users of the Crypto API poly1305 left,
remove it.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 crypto/Kconfig    |  12 ----
 crypto/Makefile   |   2 -
 crypto/poly1305.c | 152 ----------------------------------------------
 3 files changed, 166 deletions(-)
 delete mode 100644 crypto/poly1305.c

diff --git a/crypto/Kconfig b/crypto/Kconfig
index f87e2a26d2dd..3cb5563dc4ab 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -953,18 +953,6 @@ config CRYPTO_POLYVAL
 	  This is used in HCTR2.  It is not a general-purpose
 	  cryptographic hash function.
 
-config CRYPTO_POLY1305
-	tristate "Poly1305"
-	select CRYPTO_HASH
-	select CRYPTO_LIB_POLY1305
-	select CRYPTO_LIB_POLY1305_GENERIC
-	help
-	  Poly1305 authenticator algorithm (RFC7539)
-
-	  Poly1305 is an authenticator algorithm designed by Daniel J. Bernstein.
-	  It is used for the ChaCha20-Poly1305 AEAD, specified in RFC7539 for use
-	  in IETF protocols. This is the portable C implementation of Poly1305.
-
 config CRYPTO_RMD160
 	tristate "RIPEMD-160"
 	select CRYPTO_HASH
diff --git a/crypto/Makefile b/crypto/Makefile
index 5d2f2a28d8a0..587bc74b6d74 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -149,8 +149,6 @@ obj-$(CONFIG_CRYPTO_SEED) += seed.o
 obj-$(CONFIG_CRYPTO_ARIA) += aria_generic.o
 obj-$(CONFIG_CRYPTO_CHACHA20) += chacha.o
 CFLAGS_chacha.o += -DARCH=$(ARCH)
-obj-$(CONFIG_CRYPTO_POLY1305) += poly1305.o
-CFLAGS_poly1305.o += -DARCH=$(ARCH)
 obj-$(CONFIG_CRYPTO_DEFLATE) += deflate.o
 obj-$(CONFIG_CRYPTO_MICHAEL_MIC) += michael_mic.o
 obj-$(CONFIG_CRYPTO_CRC32C) += crc32c_generic.o
diff --git a/crypto/poly1305.c b/crypto/poly1305.c
deleted file mode 100644
index e0436bdc462b..000000000000
--- a/crypto/poly1305.c
+++ /dev/null
@@ -1,152 +0,0 @@
-/*
- * Crypto API wrapper for the Poly1305 library functions
- *
- * Copyright (C) 2015 Martin Willi
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#include <crypto/algapi.h>
-#include <crypto/internal/hash.h>
-#include <crypto/internal/poly1305.h>
-#include <linux/crypto.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-
-struct crypto_poly1305_desc_ctx {
-	struct poly1305_desc_ctx base;
-	u8 key[POLY1305_KEY_SIZE];
-	unsigned int keysize;
-};
-
-static int crypto_poly1305_init(struct shash_desc *desc)
-{
-	struct crypto_poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
-
-	dctx->keysize = 0;
-	return 0;
-}
-
-static int crypto_poly1305_update(struct shash_desc *desc,
-				  const u8 *src, unsigned int srclen, bool arch)
-{
-	struct crypto_poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
-	unsigned int bytes;
-
-	/*
-	 * The key is passed as the first 32 "data" bytes.  The actual
-	 * poly1305_init() can be called only once the full key is available.
-	 */
-	if (dctx->keysize < POLY1305_KEY_SIZE) {
-		bytes = min(srclen, POLY1305_KEY_SIZE - dctx->keysize);
-		memcpy(&dctx->key[dctx->keysize], src, bytes);
-		dctx->keysize += bytes;
-		if (dctx->keysize < POLY1305_KEY_SIZE)
-			return 0;
-		if (arch)
-			poly1305_init(&dctx->base, dctx->key);
-		else
-			poly1305_init_generic(&dctx->base, dctx->key);
-		src += bytes;
-		srclen -= bytes;
-	}
-
-	if (arch)
-		poly1305_update(&dctx->base, src, srclen);
-	else
-		poly1305_update_generic(&dctx->base, src, srclen);
-
-	return 0;
-}
-
-static int crypto_poly1305_update_generic(struct shash_desc *desc,
-					  const u8 *src, unsigned int srclen)
-{
-	return crypto_poly1305_update(desc, src, srclen, false);
-}
-
-static int crypto_poly1305_update_arch(struct shash_desc *desc,
-				       const u8 *src, unsigned int srclen)
-{
-	return crypto_poly1305_update(desc, src, srclen, true);
-}
-
-static int crypto_poly1305_final(struct shash_desc *desc, u8 *dst, bool arch)
-{
-	struct crypto_poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
-
-	if (unlikely(dctx->keysize != POLY1305_KEY_SIZE))
-		return -ENOKEY;
-
-	if (arch)
-		poly1305_final(&dctx->base, dst);
-	else
-		poly1305_final_generic(&dctx->base, dst);
-	memzero_explicit(&dctx->key, sizeof(dctx->key));
-	return 0;
-}
-
-static int crypto_poly1305_final_generic(struct shash_desc *desc, u8 *dst)
-{
-	return crypto_poly1305_final(desc, dst, false);
-}
-
-static int crypto_poly1305_final_arch(struct shash_desc *desc, u8 *dst)
-{
-	return crypto_poly1305_final(desc, dst, true);
-}
-
-static struct shash_alg poly1305_algs[] = {
-	{
-		.base.cra_name		= "poly1305",
-		.base.cra_driver_name	= "poly1305-generic",
-		.base.cra_priority	= 100,
-		.base.cra_blocksize	= POLY1305_BLOCK_SIZE,
-		.base.cra_module	= THIS_MODULE,
-		.digestsize		= POLY1305_DIGEST_SIZE,
-		.init			= crypto_poly1305_init,
-		.update			= crypto_poly1305_update_generic,
-		.final			= crypto_poly1305_final_generic,
-		.descsize		= sizeof(struct crypto_poly1305_desc_ctx),
-	},
-	{
-		.base.cra_name		= "poly1305",
-		.base.cra_driver_name	= "poly1305-" __stringify(ARCH),
-		.base.cra_priority	= 300,
-		.base.cra_blocksize	= POLY1305_BLOCK_SIZE,
-		.base.cra_module	= THIS_MODULE,
-		.digestsize		= POLY1305_DIGEST_SIZE,
-		.init			= crypto_poly1305_init,
-		.update			= crypto_poly1305_update_arch,
-		.final			= crypto_poly1305_final_arch,
-		.descsize		= sizeof(struct crypto_poly1305_desc_ctx),
-	},
-};
-
-static int num_algs;
-
-static int __init poly1305_mod_init(void)
-{
-	/* register the arch flavours only if they differ from generic */
-	num_algs = poly1305_is_arch_optimized() ? 2 : 1;
-
-	return crypto_register_shashes(poly1305_algs, num_algs);
-}
-
-static void __exit poly1305_mod_exit(void)
-{
-	crypto_unregister_shashes(poly1305_algs, num_algs);
-}
-
-subsys_initcall(poly1305_mod_init);
-module_exit(poly1305_mod_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Martin Willi <martin@strongswan.org>");
-MODULE_DESCRIPTION("Crypto API wrapper for the Poly1305 library functions");
-MODULE_ALIAS_CRYPTO("poly1305");
-MODULE_ALIAS_CRYPTO("poly1305-generic");
-MODULE_ALIAS_CRYPTO("poly1305-" __stringify(ARCH));
-- 
2.39.5



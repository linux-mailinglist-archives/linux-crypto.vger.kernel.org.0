Return-Path: <linux-crypto+bounces-12418-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3204FA9E73B
	for <lists+linux-crypto@lfdr.de>; Mon, 28 Apr 2025 06:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9D018863DE
	for <lists+linux-crypto@lfdr.de>; Mon, 28 Apr 2025 04:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F285619D084;
	Mon, 28 Apr 2025 04:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="TKhhHaEI"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B9928E0F
	for <linux-crypto@vger.kernel.org>; Mon, 28 Apr 2025 04:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745816191; cv=none; b=Z5fa9uisf19x7Fk1+J4inQEL8ct7ZUaI93PmVY7qojUoHNn7DMqttb+Xhs0oepl7IxCrmBcNs+NuddJgFt08l3wWi6RjGldivD5wmqjgoj6OkRtxi2qAxx33zaoXgHRzJP9yHtlLgL5Qlo+tTOt+Q0cfIfeO3YLmgdXOphuebo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745816191; c=relaxed/simple;
	bh=GGPLUur+XQbGCpfpOGxbeTjysautuHWthtv7hz5cZqI=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=Vbk4T9sash0N5upGz115J6pCfQ2eOA5mB/79E4DNHTwFyDaZ1IbCkwYx4ue1WHWpppqsKk61iXhaPNjCSPA4kbDA6CZ2I7hMfC5STef6OxD9kGWAXJmuSnn/JTg1+f9JtYJc5YaIW3D7x3vdb4FF5t+OS5EmWbVSwmWBzAd9Cms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=TKhhHaEI; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=To:Subject:From:References:In-Reply-To:Message-Id:Date:Sender:
	Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+fFJOhU2X9/nYaSwK1s3nOIEjyF2K8vgL0+iXMOzn3A=; b=TKhhHaEIgBiA9MsQU1G18WYIcO
	26AJ8RHEbsT/vBuv//T4O3JQJ2CX+NzjjsqSLsW2vY2obMouJ1XGt6jZfFFQWr8+OH5OITlNiDOHX
	No5kCqM3gdPfK9T/0Aw6UsjNS/sJKLCK/D1g7x1gQIHGkbDB7qejgqqBaWPEbn3ktxsrrc/xNxbr1
	f2IjvU7fBFLHM5xro9KBCtF/Z0xKCEZHLk1LMjKxpnHWWLpyIqS7Xv851S9yGMGHnR3bj71q5W36T
	1ani3ffAPZ7taspeEMm2TuVG5FL11VStU5D1Mi7pvYYSJJAXkqLm+gX0sMp37UlRKhjtq1z4y+8Bq
	UMC8PhNQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u9GXZ-001WH6-2R;
	Mon, 28 Apr 2025 12:56:26 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 28 Apr 2025 12:56:25 +0800
Date: Mon, 28 Apr 2025 12:56:25 +0800
Message-Id: <44211d959d0c77c69293f8e4d3d3b509446513d2.1745815528.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1745815528.git.herbert@gondor.apana.org.au>
References: <cover.1745815528.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v4 PATCH 10/11] crypto: poly1305 - Remove algorithm
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



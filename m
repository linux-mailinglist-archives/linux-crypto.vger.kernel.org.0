Return-Path: <linux-crypto+bounces-11966-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D48EA93090
	for <lists+linux-crypto@lfdr.de>; Fri, 18 Apr 2025 05:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ADCA7B646A
	for <lists+linux-crypto@lfdr.de>; Fri, 18 Apr 2025 03:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1675E268C7C;
	Fri, 18 Apr 2025 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Xte6tCmZ"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB8A268C78
	for <linux-crypto@vger.kernel.org>; Fri, 18 Apr 2025 03:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744945269; cv=none; b=aC2fA9uw5g1MB1kcp6YcTEtrAeKVISdUcC1T/M+JfPYVhNjVzIZ52IqpMpo994G6nQhBKGZYAp2RXRcXYTwNlpMSaCgvy+CKAvk3yYL/Pxa/tHYFsPgO+yS7SyUjV4DKqVdaDvRePhP5Dp8eak6AcmY3FgH4SbYOrppbFXr7z2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744945269; c=relaxed/simple;
	bh=7DBsfMZ4HhwgvpJsX4ZNrax8Hol+AYqZEln7+abfDC8=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=estM7r8Pw1TDjhCaZ0yPMijvCQQDN153EiKR9DBq92w2QwlDdzVcuIXVZ9VuES02A4NFH+4HFsq1JCUVOQyh+Zanw3zI+9KzUKg48xqmhl9x8NuTm7UMSqHN4U2ECiQSi+iRziHERsJbuouLqzRxJ0HvLgQHuABWjC2+awhiFL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Xte6tCmZ; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=To:Subject:From:References:In-Reply-To:Message-Id:Date:Sender:
	Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=68gBAjJk4aYEPDuAYEToMTZSPqsEOkzKBUjKhw22PRE=; b=Xte6tCmZinEOwRPnooyHVNuVIa
	ECOpxNLouIIHIZfKeehmKoGUQEfBpbCwSLyoW9ZiT/nhEVXArW0T6b1bVGNMYb+klc+oMlRVFzmOB
	hLX1rA7PwPK5yEmRrjv2VTcVg6uDbTGnkZmvCN8KLFzDTBuiosW6ZFkGspM59YhQSR3xR7meKlfCw
	4LwuIdUAF8twiQikXtNVY+Rl+tokrOG9aq/uNSUgjUwYXYKbdM6VxYqUHs42OghzpJIRHXaQNWkZb
	qMOVWTPmZUPCU1ARCJyZEpRt8O+JJPgEWmVjm/t1CQD+pUc0v4RvtcLZ3EDaWjHrESis6JlFJP7Kg
	mAWoT5FA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u5byS-00GeIy-1h;
	Fri, 18 Apr 2025 11:01:05 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Apr 2025 11:01:04 +0800
Date: Fri, 18 Apr 2025 11:01:04 +0800
Message-Id: <e02dce4452e0b6ba6c1abec8a3ed47bb54c319e5.1744945025.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1744945025.git.herbert@gondor.apana.org.au>
References: <cover.1744945025.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v2 PATCH 63/67] crypto: xcbc - Use API partial block handling
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

Use the Crypto API partial block handling.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 crypto/xcbc.c | 92 ++++++++++-----------------------------------------
 1 file changed, 18 insertions(+), 74 deletions(-)

diff --git a/crypto/xcbc.c b/crypto/xcbc.c
index fc785667b134..970ff581dc58 100644
--- a/crypto/xcbc.c
+++ b/crypto/xcbc.c
@@ -8,9 +8,12 @@
 
 #include <crypto/internal/cipher.h>
 #include <crypto/internal/hash.h>
+#include <crypto/utils.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 
 static u_int32_t ks[12] = {0x01010101, 0x01010101, 0x01010101, 0x01010101,
 			   0x02020202, 0x02020202, 0x02020202, 0x02020202,
@@ -30,22 +33,6 @@ struct xcbc_tfm_ctx {
 	u8 consts[];
 };
 
-/*
- * +------------------------
- * | <shash desc>
- * +------------------------
- * | xcbc_desc_ctx
- * +------------------------
- * | odds (block size)
- * +------------------------
- * | prev (block size)
- * +------------------------
- */
-struct xcbc_desc_ctx {
-	unsigned int len;
-	u8 odds[];
-};
-
 #define XCBC_BLOCKSIZE	16
 
 static int crypto_xcbc_digest_setkey(struct crypto_shash *parent,
@@ -70,13 +57,10 @@ static int crypto_xcbc_digest_setkey(struct crypto_shash *parent,
 
 static int crypto_xcbc_digest_init(struct shash_desc *pdesc)
 {
-	struct xcbc_desc_ctx *ctx = shash_desc_ctx(pdesc);
 	int bs = crypto_shash_blocksize(pdesc->tfm);
-	u8 *prev = &ctx->odds[bs];
+	u8 *prev = shash_desc_ctx(pdesc);
 
-	ctx->len = 0;
 	memset(prev, 0, bs);
-
 	return 0;
 }
 
@@ -85,77 +69,36 @@ static int crypto_xcbc_digest_update(struct shash_desc *pdesc, const u8 *p,
 {
 	struct crypto_shash *parent = pdesc->tfm;
 	struct xcbc_tfm_ctx *tctx = crypto_shash_ctx(parent);
-	struct xcbc_desc_ctx *ctx = shash_desc_ctx(pdesc);
 	struct crypto_cipher *tfm = tctx->child;
 	int bs = crypto_shash_blocksize(parent);
-	u8 *odds = ctx->odds;
-	u8 *prev = odds + bs;
+	u8 *prev = shash_desc_ctx(pdesc);
 
-	/* checking the data can fill the block */
-	if ((ctx->len + len) <= bs) {
-		memcpy(odds + ctx->len, p, len);
-		ctx->len += len;
-		return 0;
-	}
-
-	/* filling odds with new data and encrypting it */
-	memcpy(odds + ctx->len, p, bs - ctx->len);
-	len -= bs - ctx->len;
-	p += bs - ctx->len;
-
-	crypto_xor(prev, odds, bs);
-	crypto_cipher_encrypt_one(tfm, prev, prev);
-
-	/* clearing the length */
-	ctx->len = 0;
-
-	/* encrypting the rest of data */
-	while (len > bs) {
+	do {
 		crypto_xor(prev, p, bs);
 		crypto_cipher_encrypt_one(tfm, prev, prev);
 		p += bs;
 		len -= bs;
-	}
-
-	/* keeping the surplus of blocksize */
-	if (len) {
-		memcpy(odds, p, len);
-		ctx->len = len;
-	}
-
-	return 0;
+	} while (len >= bs);
+	return len;
 }
 
-static int crypto_xcbc_digest_final(struct shash_desc *pdesc, u8 *out)
+static int crypto_xcbc_digest_finup(struct shash_desc *pdesc, const u8 *src,
+				    unsigned int len, u8 *out)
 {
 	struct crypto_shash *parent = pdesc->tfm;
 	struct xcbc_tfm_ctx *tctx = crypto_shash_ctx(parent);
-	struct xcbc_desc_ctx *ctx = shash_desc_ctx(pdesc);
 	struct crypto_cipher *tfm = tctx->child;
 	int bs = crypto_shash_blocksize(parent);
-	u8 *odds = ctx->odds;
-	u8 *prev = odds + bs;
+	u8 *prev = shash_desc_ctx(pdesc);
 	unsigned int offset = 0;
 
-	if (ctx->len != bs) {
-		unsigned int rlen;
-		u8 *p = odds + ctx->len;
-
-		*p = 0x80;
-		p++;
-
-		rlen = bs - ctx->len -1;
-		if (rlen)
-			memset(p, 0, rlen);
-
+	crypto_xor(prev, src, len);
+	if (len != bs) {
+		prev[len] ^= 0x80;
 		offset += bs;
 	}
-
-	crypto_xor(prev, odds, bs);
 	crypto_xor(prev, &tctx->consts[offset], bs);
-
 	crypto_cipher_encrypt_one(tfm, out, prev);
-
 	return 0;
 }
 
@@ -216,17 +159,18 @@ static int xcbc_create(struct crypto_template *tmpl, struct rtattr **tb)
 	inst->alg.base.cra_blocksize = alg->cra_blocksize;
 	inst->alg.base.cra_ctxsize = sizeof(struct xcbc_tfm_ctx) +
 				     alg->cra_blocksize * 2;
+	inst->alg.base.cra_flags = CRYPTO_AHASH_ALG_BLOCK_ONLY |
+				   CRYPTO_AHASH_ALG_FINAL_NONZERO;
 
 	inst->alg.digestsize = alg->cra_blocksize;
-	inst->alg.descsize = sizeof(struct xcbc_desc_ctx) +
-			     alg->cra_blocksize * 2;
+	inst->alg.descsize = alg->cra_blocksize;
 
 	inst->alg.base.cra_init = xcbc_init_tfm;
 	inst->alg.base.cra_exit = xcbc_exit_tfm;
 
 	inst->alg.init = crypto_xcbc_digest_init;
 	inst->alg.update = crypto_xcbc_digest_update;
-	inst->alg.final = crypto_xcbc_digest_final;
+	inst->alg.finup = crypto_xcbc_digest_finup;
 	inst->alg.setkey = crypto_xcbc_digest_setkey;
 
 	inst->free = shash_free_singlespawn_instance;
-- 
2.39.5



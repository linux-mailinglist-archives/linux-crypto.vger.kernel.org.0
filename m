Return-Path: <linux-crypto+bounces-11798-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDDEA8B0D2
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Apr 2025 08:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C1D1902A7E
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Apr 2025 06:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506FA236A84;
	Wed, 16 Apr 2025 06:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="BOmAadA1"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA77236A9C
	for <linux-crypto@vger.kernel.org>; Wed, 16 Apr 2025 06:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785826; cv=none; b=uJTNRNhgxnfYAyWhvat88i8P5DlGXLOtteDouuFid4NGUYIbJe/AHxgc6Yu4rZKOvgDscl8z5frN7xouLpRf/b/rKpEZQro1M/ySVqBFc8a57gbBcKyRv5aE0Yi0Lo0a+xU121Iq4zHEAtwxvUr/FfeeuLbRTGdgWeduvxteZx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785826; c=relaxed/simple;
	bh=XieLnX3taPIQqQqWLbBMQZOWl996I9mJq/G95WcMlRk=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=MnHD+fVg2Yz7QqRQsxos4OLZAgx2eUCXOF1ouraSO9U1rFaN33OrluXgYy4qsRLK45CjT+6JUKg0KQDUsY9aAYmzqlUWuzUkJnYDuhdbbmKB4uLMqMWCL0mSPluZPiSX8+/Uuptg1LoMVxdXiTEIhE9TM2jb25VfGqR85pXgbak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=BOmAadA1; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=To:Subject:From:References:In-Reply-To:Message-Id:Date:Sender:
	Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=SjXY8FwNyK9noWhnhKMektIaBGSUD2WzM1FAJnFhAZk=; b=BOmAadA143gAnx3OlqmND6ysbs
	u3Tx448cEY5LqTG5ZQu7xeWFbuOy3lYRij0j51wnN7c/EBwROv0BcTSeWt7FXZUp2WhinBk4yZnSD
	Oy6vj7/6P+xobdnSIbdre+uN8knCacCThDF4lqrlTi5gRaSvZXDHJCqEo1zMnx3/O6FQj9bxuSDdG
	uPDbtcd5BC30GG74sHww8Htpqbf92BRQs33x6qSUXZIXJPAko7MsEOjKYjpYWQ41znpPXgxIzxDgY
	AAUoUOvEL3Gfk9rXhtdPuDbwHL++/tE/weCOmkq/2VDvpHel7L613YWp7qyPP5DLsEA0XlqaOiAIJ
	pJEUjOhQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u4wUm-00G6Kl-1c;
	Wed, 16 Apr 2025 14:43:41 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 16 Apr 2025 14:43:40 +0800
Date: Wed, 16 Apr 2025 14:43:40 +0800
Message-Id: <d5dadc172d0921bd48e6f66a443d1f47fdbf6b7c.1744784515.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1744784515.git.herbert@gondor.apana.org.au>
References: <cover.1744784515.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 25/67] crypto: sparc/sha1 - Use API partial block handling
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

Use the Crypto API partial block handling.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 arch/sparc/crypto/sha1_glue.c | 109 +++++-----------------------------
 1 file changed, 15 insertions(+), 94 deletions(-)

diff --git a/arch/sparc/crypto/sha1_glue.c b/arch/sparc/crypto/sha1_glue.c
index 06b7becfcb21..ec5a06948e0d 100644
--- a/arch/sparc/crypto/sha1_glue.c
+++ b/arch/sparc/crypto/sha1_glue.c
@@ -11,124 +11,45 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
+#include <asm/elf.h>
+#include <asm/pstate.h>
 #include <crypto/internal/hash.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/mm.h>
-#include <linux/types.h>
 #include <crypto/sha1.h>
 #include <crypto/sha1_base.h>
-
-#include <asm/pstate.h>
-#include <asm/elf.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 
 #include "opcodes.h"
 
-asmlinkage void sha1_sparc64_transform(u32 *digest, const char *data,
-				       unsigned int rounds);
-
-static void __sha1_sparc64_update(struct sha1_state *sctx, const u8 *data,
-				  unsigned int len, unsigned int partial)
-{
-	unsigned int done = 0;
-
-	sctx->count += len;
-	if (partial) {
-		done = SHA1_BLOCK_SIZE - partial;
-		memcpy(sctx->buffer + partial, data, done);
-		sha1_sparc64_transform(sctx->state, sctx->buffer, 1);
-	}
-	if (len - done >= SHA1_BLOCK_SIZE) {
-		const unsigned int rounds = (len - done) / SHA1_BLOCK_SIZE;
-
-		sha1_sparc64_transform(sctx->state, data + done, rounds);
-		done += rounds * SHA1_BLOCK_SIZE;
-	}
-
-	memcpy(sctx->buffer, data + done, len - done);
-}
+asmlinkage void sha1_sparc64_transform(struct sha1_state *digest,
+				       const u8 *data, int rounds);
 
 static int sha1_sparc64_update(struct shash_desc *desc, const u8 *data,
 			       unsigned int len)
 {
-	struct sha1_state *sctx = shash_desc_ctx(desc);
-	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
-
-	/* Handle the fast case right here */
-	if (partial + len < SHA1_BLOCK_SIZE) {
-		sctx->count += len;
-		memcpy(sctx->buffer + partial, data, len);
-	} else
-		__sha1_sparc64_update(sctx, data, len, partial);
-
-	return 0;
+	return sha1_base_do_update_blocks(desc, data, len,
+					  sha1_sparc64_transform);
 }
 
 /* Add padding and return the message digest. */
-static int sha1_sparc64_final(struct shash_desc *desc, u8 *out)
+static int sha1_sparc64_finup(struct shash_desc *desc, const u8 *src,
+			      unsigned int len, u8 *out)
 {
-	struct sha1_state *sctx = shash_desc_ctx(desc);
-	unsigned int i, index, padlen;
-	__be32 *dst = (__be32 *)out;
-	__be64 bits;
-	static const u8 padding[SHA1_BLOCK_SIZE] = { 0x80, };
-
-	bits = cpu_to_be64(sctx->count << 3);
-
-	/* Pad out to 56 mod 64 and append length */
-	index = sctx->count % SHA1_BLOCK_SIZE;
-	padlen = (index < 56) ? (56 - index) : ((SHA1_BLOCK_SIZE+56) - index);
-
-	/* We need to fill a whole block for __sha1_sparc64_update() */
-	if (padlen <= 56) {
-		sctx->count += padlen;
-		memcpy(sctx->buffer + index, padding, padlen);
-	} else {
-		__sha1_sparc64_update(sctx, padding, padlen, index);
-	}
-	__sha1_sparc64_update(sctx, (const u8 *)&bits, sizeof(bits), 56);
-
-	/* Store state in digest */
-	for (i = 0; i < 5; i++)
-		dst[i] = cpu_to_be32(sctx->state[i]);
-
-	/* Wipe context */
-	memset(sctx, 0, sizeof(*sctx));
-
-	return 0;
-}
-
-static int sha1_sparc64_export(struct shash_desc *desc, void *out)
-{
-	struct sha1_state *sctx = shash_desc_ctx(desc);
-
-	memcpy(out, sctx, sizeof(*sctx));
-
-	return 0;
-}
-
-static int sha1_sparc64_import(struct shash_desc *desc, const void *in)
-{
-	struct sha1_state *sctx = shash_desc_ctx(desc);
-
-	memcpy(sctx, in, sizeof(*sctx));
-
-	return 0;
+	sha1_base_do_finup(desc, src, len, sha1_sparc64_transform);
+	return sha1_base_finish(desc, out);
 }
 
 static struct shash_alg alg = {
 	.digestsize	=	SHA1_DIGEST_SIZE,
 	.init		=	sha1_base_init,
 	.update		=	sha1_sparc64_update,
-	.final		=	sha1_sparc64_final,
-	.export		=	sha1_sparc64_export,
-	.import		=	sha1_sparc64_import,
-	.descsize	=	sizeof(struct sha1_state),
-	.statesize	=	sizeof(struct sha1_state),
+	.finup		=	sha1_sparc64_finup,
+	.descsize	=	SHA1_STATE_SIZE,
 	.base		=	{
 		.cra_name	=	"sha1",
 		.cra_driver_name=	"sha1-sparc64",
 		.cra_priority	=	SPARC_CR_OPCODE_PRIORITY,
+		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY,
 		.cra_blocksize	=	SHA1_BLOCK_SIZE,
 		.cra_module	=	THIS_MODULE,
 	}
-- 
2.39.5



Return-Path: <linux-crypto+bounces-11826-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B449DA8B0F5
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Apr 2025 08:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C935A18DA
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Apr 2025 06:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8BB23A9BB;
	Wed, 16 Apr 2025 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="MxBfLIM0"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CDA23AE70
	for <linux-crypto@vger.kernel.org>; Wed, 16 Apr 2025 06:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785890; cv=none; b=Q47TxrMNLHSFZgGaD07em+m/zlTHCC6H2I7Peh6gXT9has0xu1W7U48ZKPYL4iD0M1Jlfc2MBSlVLH+Sr7wmfzEnVH8ICl3piO9vqiNmPVyEIS8ECTi1FeFyn6lC6Fby8sX+Jt/oJ54mFuauNGNsIZM1r1Yp47DJlfb2wz4uSNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785890; c=relaxed/simple;
	bh=0bWv0eFZuDgELDXJXhJqHwUxS+yt9wnjW4IJKUE9O5k=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=WN7VAtOM8hVGyF5x8sXChV+TRhsFJboWyeZqpl8Z+xzfhIsw5FgUzVn4H9yKIIor6GovoesG1U7Q9AJkMYhY5yVIlR2qdl1xblXR4OM+tVoZ5e12Wq5cY1CdA8p9ZnanApLvCWRuxZRMN0xBW7kQUMjSVGCWG/yMX31KoKyiASU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=MxBfLIM0; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=To:Subject:From:References:In-Reply-To:Message-Id:Date:Sender:
	Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=NC/KuPrFJtJ2padWEF2HTX24+neLDpHBjWLC2Svg884=; b=MxBfLIM0DypNNITQFQMYepAoBu
	wCbQxleWD72BAn/+NaE3aIsWANr7M+udw6d9NVZiSdP/oyoVhgOhIMMvEf44625Sy06VeFMbLLcxx
	c5FoFaw7aSjV3bI70wDGGR3/PVAKTo5EKk/Ev/63xJ4nzL6sHPSZ4ZRHDZZXQlAj86cvB2GCTw/P1
	3TvTD2OOQIMDwy60GfxuagmK8qjDD15wXLCDuyvcgXTqJ6EVHlfkKixPLiSJDi6ZAj7S8Ez9RO5u7
	MMvvFJ0n9OdwzmclzS0ai/FoQYzFivha14fy5ql1fRJhuFiY9OlJLUwUa8twjB+8nMfTbayNJbA2r
	HUd8kXEg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u4wVp-00G6Qv-0i;
	Wed, 16 Apr 2025 14:44:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 16 Apr 2025 14:44:45 +0800
Date: Wed, 16 Apr 2025 14:44:45 +0800
Message-Id: <4fe90045073424ddbf687f9609db4a0ad09dc230.1744784515.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1744784515.git.herbert@gondor.apana.org.au>
References: <cover.1744784515.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 53/67] crypto: sparc/sha512 - Use API partial block handling
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

Use the Crypto API partial block handling.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 arch/sparc/crypto/sha512_glue.c | 102 +++++---------------------------
 1 file changed, 15 insertions(+), 87 deletions(-)

diff --git a/arch/sparc/crypto/sha512_glue.c b/arch/sparc/crypto/sha512_glue.c
index d66efa4ec59a..1d0e1f98ca46 100644
--- a/arch/sparc/crypto/sha512_glue.c
+++ b/arch/sparc/crypto/sha512_glue.c
@@ -10,115 +10,43 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
+#include <asm/elf.h>
+#include <asm/pstate.h>
 #include <crypto/internal/hash.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/mm.h>
-#include <linux/types.h>
 #include <crypto/sha2.h>
 #include <crypto/sha512_base.h>
-
-#include <asm/pstate.h>
-#include <asm/elf.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 
 #include "opcodes.h"
 
 asmlinkage void sha512_sparc64_transform(u64 *digest, const char *data,
 					 unsigned int rounds);
 
-static void __sha512_sparc64_update(struct sha512_state *sctx, const u8 *data,
-				    unsigned int len, unsigned int partial)
+static void sha512_block(struct sha512_state *sctx, const u8 *src, int blocks)
 {
-	unsigned int done = 0;
-
-	if ((sctx->count[0] += len) < len)
-		sctx->count[1]++;
-	if (partial) {
-		done = SHA512_BLOCK_SIZE - partial;
-		memcpy(sctx->buf + partial, data, done);
-		sha512_sparc64_transform(sctx->state, sctx->buf, 1);
-	}
-	if (len - done >= SHA512_BLOCK_SIZE) {
-		const unsigned int rounds = (len - done) / SHA512_BLOCK_SIZE;
-
-		sha512_sparc64_transform(sctx->state, data + done, rounds);
-		done += rounds * SHA512_BLOCK_SIZE;
-	}
-
-	memcpy(sctx->buf, data + done, len - done);
+	sha512_sparc64_transform(sctx->state, src, blocks);
 }
 
 static int sha512_sparc64_update(struct shash_desc *desc, const u8 *data,
 				 unsigned int len)
 {
-	struct sha512_state *sctx = shash_desc_ctx(desc);
-	unsigned int partial = sctx->count[0] % SHA512_BLOCK_SIZE;
-
-	/* Handle the fast case right here */
-	if (partial + len < SHA512_BLOCK_SIZE) {
-		if ((sctx->count[0] += len) < len)
-			sctx->count[1]++;
-		memcpy(sctx->buf + partial, data, len);
-	} else
-		__sha512_sparc64_update(sctx, data, len, partial);
-
-	return 0;
+	return sha512_base_do_update_blocks(desc, data, len, sha512_block);
 }
 
-static int sha512_sparc64_final(struct shash_desc *desc, u8 *out)
+static int sha512_sparc64_finup(struct shash_desc *desc, const u8 *src,
+				unsigned int len, u8 *out)
 {
-	struct sha512_state *sctx = shash_desc_ctx(desc);
-	unsigned int i, index, padlen;
-	__be64 *dst = (__be64 *)out;
-	__be64 bits[2];
-	static const u8 padding[SHA512_BLOCK_SIZE] = { 0x80, };
-
-	/* Save number of bits */
-	bits[1] = cpu_to_be64(sctx->count[0] << 3);
-	bits[0] = cpu_to_be64(sctx->count[1] << 3 | sctx->count[0] >> 61);
-
-	/* Pad out to 112 mod 128 and append length */
-	index = sctx->count[0] % SHA512_BLOCK_SIZE;
-	padlen = (index < 112) ? (112 - index) : ((SHA512_BLOCK_SIZE+112) - index);
-
-	/* We need to fill a whole block for __sha512_sparc64_update() */
-	if (padlen <= 112) {
-		if ((sctx->count[0] += padlen) < padlen)
-			sctx->count[1]++;
-		memcpy(sctx->buf + index, padding, padlen);
-	} else {
-		__sha512_sparc64_update(sctx, padding, padlen, index);
-	}
-	__sha512_sparc64_update(sctx, (const u8 *)&bits, sizeof(bits), 112);
-
-	/* Store state in digest */
-	for (i = 0; i < 8; i++)
-		dst[i] = cpu_to_be64(sctx->state[i]);
-
-	/* Wipe context */
-	memset(sctx, 0, sizeof(*sctx));
-
-	return 0;
-}
-
-static int sha384_sparc64_final(struct shash_desc *desc, u8 *hash)
-{
-	u8 D[64];
-
-	sha512_sparc64_final(desc, D);
-
-	memcpy(hash, D, 48);
-	memzero_explicit(D, 64);
-
-	return 0;
+	sha512_base_do_finup(desc, src, len, sha512_block);
+	return sha512_base_finish(desc, out);
 }
 
 static struct shash_alg sha512 = {
 	.digestsize	=	SHA512_DIGEST_SIZE,
 	.init		=	sha512_base_init,
 	.update		=	sha512_sparc64_update,
-	.final		=	sha512_sparc64_final,
-	.descsize	=	sizeof(struct sha512_state),
+	.finup		=	sha512_sparc64_finup,
+	.descsize	=	SHA512_STATE_SIZE,
 	.base		=	{
 		.cra_name	=	"sha512",
 		.cra_driver_name=	"sha512-sparc64",
@@ -132,8 +60,8 @@ static struct shash_alg sha384 = {
 	.digestsize	=	SHA384_DIGEST_SIZE,
 	.init		=	sha384_base_init,
 	.update		=	sha512_sparc64_update,
-	.final		=	sha384_sparc64_final,
-	.descsize	=	sizeof(struct sha512_state),
+	.finup		=	sha512_sparc64_finup,
+	.descsize	=	SHA512_STATE_SIZE,
 	.base		=	{
 		.cra_name	=	"sha384",
 		.cra_driver_name=	"sha384-sparc64",
-- 
2.39.5



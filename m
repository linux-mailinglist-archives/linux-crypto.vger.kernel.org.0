Return-Path: <linux-crypto+bounces-11810-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06ECA8B0E4
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Apr 2025 08:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F04FC5A0940
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Apr 2025 06:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D281D1AB6C8;
	Wed, 16 Apr 2025 06:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="YzJxdPRg"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6F12397A4
	for <linux-crypto@vger.kernel.org>; Wed, 16 Apr 2025 06:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785853; cv=none; b=P4OyjKE4YEsGXyEGhU/J5RbaFHhG1gcrrYPq19ZzNc01Au6EnAF1MeLVDmu4VuQazmBGCiuFkYhRD1CVkFbZwVy/n08ZL/8DHwJ1kEFgErG4DbejPwUumg5DJnKpx45tqavzEEW22yTQi//7xqhmyx3aBvT8aqhoZTt21hMmDxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785853; c=relaxed/simple;
	bh=pCAfilLs1RK5gROzz+r7PWi2hfWLLYsRfqITvBsZ3wA=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=QKbJJD/1i229C8UCFgs81mAu+6zhPlPDLetXgH/+v07mLNIfsrosRoQbgtZ4dqnAQ2V+RI7092JGBOzFxw49efEa/S/MIbs2Iig/DGVJtFicKnvNcq++bLGuDy0S4MGxU6Ht/q+ee6h6R+lijeAb7mZopXz67DO4leru2Sl5I8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=YzJxdPRg; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=To:Subject:From:References:In-Reply-To:Message-Id:Date:Sender:
	Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=htST6EdzYU1Ktvr6Q9rc/GEOMyhFvuWKwgMRGC0pk9E=; b=YzJxdPRgmK8LbVPbMelfmpTXzW
	tA0bvGoBMIbGZhO6PeXhIdlh3jmm/HadldOvWxotQ+LqId8IyUru+PCYbVVcmtSBLTluAMxoFSKqa
	OhV2lcLZO8JhwolAvl7VXyyTnL1VG3lhaWjJ6sUoqBwacP7nTQCWTfhVOIy+8PkcQE3jw1qUu/nFs
	D1A7HsN6nwPsbKsnlEtkUyPru3qm6/OyFfnqhD+w6o3RuIMUSpHbjZvZOLOEIMXY9PcPT1xz2BTRu
	ypeh1Af6BY/CdRUgmgSkoVqCtjKhzdN/A+Tp5mxEMenqLtI+h3Ce538nETkc6wHbJ7+l1ehVT/N6F
	sjfT3azw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u4wVE-00G6NJ-0N;
	Wed, 16 Apr 2025 14:44:09 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 16 Apr 2025 14:44:08 +0800
Date: Wed, 16 Apr 2025 14:44:08 +0800
Message-Id: <c762af0a8590ecfdc07787c728d990911c9f7b58.1744784515.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1744784515.git.herbert@gondor.apana.org.au>
References: <cover.1744784515.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 37/67] crypto: s390/sha256 - Use API partial block handling
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

Use the Crypto API partial block handling.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 arch/s390/crypto/sha256_s390.c | 35 +++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/s390/crypto/sha256_s390.c b/arch/s390/crypto/sha256_s390.c
index 6f1ccdf93d3e..e6876c49414d 100644
--- a/arch/s390/crypto/sha256_s390.c
+++ b/arch/s390/crypto/sha256_s390.c
@@ -8,12 +8,13 @@
  *   Copyright IBM Corp. 2005, 2011
  *   Author(s): Jan Glauber (jang@de.ibm.com)
  */
-#include <crypto/internal/hash.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/cpufeature.h>
-#include <crypto/sha2.h>
 #include <asm/cpacf.h>
+#include <crypto/internal/hash.h>
+#include <crypto/sha2.h>
+#include <linux/cpufeature.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/string.h>
 
 #include "sha.h"
 
@@ -38,22 +39,20 @@ static int s390_sha256_init(struct shash_desc *desc)
 static int sha256_export(struct shash_desc *desc, void *out)
 {
 	struct s390_sha_ctx *sctx = shash_desc_ctx(desc);
-	struct sha256_state *octx = out;
+	struct crypto_sha256_state *octx = out;
 
 	octx->count = sctx->count;
 	memcpy(octx->state, sctx->state, sizeof(octx->state));
-	memcpy(octx->buf, sctx->buf, sizeof(octx->buf));
 	return 0;
 }
 
 static int sha256_import(struct shash_desc *desc, const void *in)
 {
 	struct s390_sha_ctx *sctx = shash_desc_ctx(desc);
-	const struct sha256_state *ictx = in;
+	const struct crypto_sha256_state *ictx = in;
 
 	sctx->count = ictx->count;
 	memcpy(sctx->state, ictx->state, sizeof(ictx->state));
-	memcpy(sctx->buf, ictx->buf, sizeof(ictx->buf));
 	sctx->func = CPACF_KIMD_SHA_256;
 	return 0;
 }
@@ -61,16 +60,17 @@ static int sha256_import(struct shash_desc *desc, const void *in)
 static struct shash_alg sha256_alg = {
 	.digestsize	=	SHA256_DIGEST_SIZE,
 	.init		=	s390_sha256_init,
-	.update		=	s390_sha_update,
-	.final		=	s390_sha_final,
+	.update		=	s390_sha_update_blocks,
+	.finup		=	s390_sha_finup,
 	.export		=	sha256_export,
 	.import		=	sha256_import,
-	.descsize	=	sizeof(struct s390_sha_ctx),
-	.statesize	=	sizeof(struct sha256_state),
+	.descsize	=	S390_SHA_CTX_SIZE,
+	.statesize	=	sizeof(struct crypto_sha256_state),
 	.base		=	{
 		.cra_name	=	"sha256",
 		.cra_driver_name=	"sha256-s390",
 		.cra_priority	=	300,
+		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY,
 		.cra_blocksize	=	SHA256_BLOCK_SIZE,
 		.cra_module	=	THIS_MODULE,
 	}
@@ -97,16 +97,17 @@ static int s390_sha224_init(struct shash_desc *desc)
 static struct shash_alg sha224_alg = {
 	.digestsize	=	SHA224_DIGEST_SIZE,
 	.init		=	s390_sha224_init,
-	.update		=	s390_sha_update,
-	.final		=	s390_sha_final,
+	.update		=	s390_sha_update_blocks,
+	.finup		=	s390_sha_finup,
 	.export		=	sha256_export,
 	.import		=	sha256_import,
-	.descsize	=	sizeof(struct s390_sha_ctx),
-	.statesize	=	sizeof(struct sha256_state),
+	.descsize	=	S390_SHA_CTX_SIZE,
+	.statesize	=	sizeof(struct crypto_sha256_state),
 	.base		=	{
 		.cra_name	=	"sha224",
 		.cra_driver_name=	"sha224-s390",
 		.cra_priority	=	300,
+		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY,
 		.cra_blocksize	=	SHA224_BLOCK_SIZE,
 		.cra_module	=	THIS_MODULE,
 	}
-- 
2.39.5



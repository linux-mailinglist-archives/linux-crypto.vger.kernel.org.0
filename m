Return-Path: <linux-crypto+bounces-7016-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D66985943
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Sep 2024 13:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EADDD1C237A6
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Sep 2024 11:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BFC19E828;
	Wed, 25 Sep 2024 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/uz/Kb5"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3E819DFA2;
	Wed, 25 Sep 2024 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264316; cv=none; b=BRpD6n7AQpVop8hpi5fy/JF49ja6/8zHKeyuOLVwklCEdH08Z5gPjTnGaEq5G3jmDx3nmDN8Vm/qylkiU2fVezQmPBwYPSH2ZDup47SV4G4KZnwUVC+WLdDma3SDPCgWEQcYwtPEzMPdxnRX3XRw9fSCSRqLKYh7EL3UENtqLSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264316; c=relaxed/simple;
	bh=6khm0XMHdIQxMonYwQMoYj2dT//yFTy3xINi3N4KwNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6tZ74b+QHzn3ylpB6wZOhOzC0/z0mpteeHhH+Z9jx2NjTsoI+JNd1WAGmK7fxjTjeg5kZzfK73tooUpGoKb71mM5o+wwFE0az5/yBCDUPZDmrkF+zrKbhtTWwYasQaQJnkrw9tKy6oA8IqVMERFLWQ8biQGEghtzYCro0851jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/uz/Kb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B399C4CEC7;
	Wed, 25 Sep 2024 11:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264316;
	bh=6khm0XMHdIQxMonYwQMoYj2dT//yFTy3xINi3N4KwNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a/uz/Kb5f/DXk2kfMk8O8faylvCnQjl1oingfFukj6GbLWFg4VimF0qQEHtfvpG9v
	 qS4zRo0Cza8szq3ENyp/KGLOhU7BLVdZZpx+hvf+nePzW0cEUIJT0EejSa6mJdFj7r
	 kgbaQHt4FKaMhK4eOUuQIYTEs4C35pGj+ueSenZt5ymS/2U9wXOqwBZn4oqQ87X0Nm
	 vcS/1dFkQYXVmYcRCkvjwbTMCI/qmpWhYfBZean5vCRqDMdO0R1Dy3Y/IBXOfkt7VS
	 +zRDwNrNrFB0vvwS470iRHQxV5uEOxHT7r2GUbd3lg8XMacTvERczaUsEMdbc9Mmva
	 CFtfC92oDyQdw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	linux@armlinux.org.uk,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 055/244] crypto: simd - Do not call crypto_alloc_tfm during registration
Date: Wed, 25 Sep 2024 07:24:36 -0400
Message-ID: <20240925113641.1297102-55-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit 3c44d31cb34ce4eb8311a2e73634d57702948230 ]

Algorithm registration is usually carried out during module init,
where as little work as possible should be carried out.  The SIMD
code violated this rule by allocating a tfm, this then triggers a
full test of the algorithm which may dead-lock in certain cases.

SIMD is only allocating the tfm to get at the alg object, which is
in fact already available as it is what we are registering.  Use
that directly and remove the crypto_alloc_tfm call.

Also remove some obsolete and unused SIMD API.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/crypto/aes-ce-glue.c     |  2 +-
 arch/arm/crypto/aes-neonbs-glue.c |  2 +-
 crypto/simd.c                     | 76 ++++++-------------------------
 include/crypto/internal/simd.h    | 12 +----
 4 files changed, 19 insertions(+), 73 deletions(-)

diff --git a/arch/arm/crypto/aes-ce-glue.c b/arch/arm/crypto/aes-ce-glue.c
index b668c97663ec0..f5b66f4cf45d9 100644
--- a/arch/arm/crypto/aes-ce-glue.c
+++ b/arch/arm/crypto/aes-ce-glue.c
@@ -711,7 +711,7 @@ static int __init aes_init(void)
 		algname = aes_algs[i].base.cra_name + 2;
 		drvname = aes_algs[i].base.cra_driver_name + 2;
 		basename = aes_algs[i].base.cra_driver_name;
-		simd = simd_skcipher_create_compat(algname, drvname, basename);
+		simd = simd_skcipher_create_compat(aes_algs + i, algname, drvname, basename);
 		err = PTR_ERR(simd);
 		if (IS_ERR(simd))
 			goto unregister_simds;
diff --git a/arch/arm/crypto/aes-neonbs-glue.c b/arch/arm/crypto/aes-neonbs-glue.c
index 201eb35dde37e..735a2441ad484 100644
--- a/arch/arm/crypto/aes-neonbs-glue.c
+++ b/arch/arm/crypto/aes-neonbs-glue.c
@@ -540,7 +540,7 @@ static int __init aes_init(void)
 		algname = aes_algs[i].base.cra_name + 2;
 		drvname = aes_algs[i].base.cra_driver_name + 2;
 		basename = aes_algs[i].base.cra_driver_name;
-		simd = simd_skcipher_create_compat(algname, drvname, basename);
+		simd = simd_skcipher_create_compat(aes_algs + i, algname, drvname, basename);
 		err = PTR_ERR(simd);
 		if (IS_ERR(simd))
 			goto unregister_simds;
diff --git a/crypto/simd.c b/crypto/simd.c
index 2aa4f72e224fd..b07721d1f3f6e 100644
--- a/crypto/simd.c
+++ b/crypto/simd.c
@@ -136,27 +136,19 @@ static int simd_skcipher_init(struct crypto_skcipher *tfm)
 	return 0;
 }
 
-struct simd_skcipher_alg *simd_skcipher_create_compat(const char *algname,
+struct simd_skcipher_alg *simd_skcipher_create_compat(struct skcipher_alg *ialg,
+						      const char *algname,
 						      const char *drvname,
 						      const char *basename)
 {
 	struct simd_skcipher_alg *salg;
-	struct crypto_skcipher *tfm;
-	struct skcipher_alg *ialg;
 	struct skcipher_alg *alg;
 	int err;
 
-	tfm = crypto_alloc_skcipher(basename, CRYPTO_ALG_INTERNAL,
-				    CRYPTO_ALG_INTERNAL | CRYPTO_ALG_ASYNC);
-	if (IS_ERR(tfm))
-		return ERR_CAST(tfm);
-
-	ialg = crypto_skcipher_alg(tfm);
-
 	salg = kzalloc(sizeof(*salg), GFP_KERNEL);
 	if (!salg) {
 		salg = ERR_PTR(-ENOMEM);
-		goto out_put_tfm;
+		goto out;
 	}
 
 	salg->ialg_name = basename;
@@ -195,30 +187,16 @@ struct simd_skcipher_alg *simd_skcipher_create_compat(const char *algname,
 	if (err)
 		goto out_free_salg;
 
-out_put_tfm:
-	crypto_free_skcipher(tfm);
+out:
 	return salg;
 
 out_free_salg:
 	kfree(salg);
 	salg = ERR_PTR(err);
-	goto out_put_tfm;
+	goto out;
 }
 EXPORT_SYMBOL_GPL(simd_skcipher_create_compat);
 
-struct simd_skcipher_alg *simd_skcipher_create(const char *algname,
-					       const char *basename)
-{
-	char drvname[CRYPTO_MAX_ALG_NAME];
-
-	if (snprintf(drvname, CRYPTO_MAX_ALG_NAME, "simd-%s", basename) >=
-	    CRYPTO_MAX_ALG_NAME)
-		return ERR_PTR(-ENAMETOOLONG);
-
-	return simd_skcipher_create_compat(algname, drvname, basename);
-}
-EXPORT_SYMBOL_GPL(simd_skcipher_create);
-
 void simd_skcipher_free(struct simd_skcipher_alg *salg)
 {
 	crypto_unregister_skcipher(&salg->alg);
@@ -246,7 +224,7 @@ int simd_register_skciphers_compat(struct skcipher_alg *algs, int count,
 		algname = algs[i].base.cra_name + 2;
 		drvname = algs[i].base.cra_driver_name + 2;
 		basename = algs[i].base.cra_driver_name;
-		simd = simd_skcipher_create_compat(algname, drvname, basename);
+		simd = simd_skcipher_create_compat(algs + i, algname, drvname, basename);
 		err = PTR_ERR(simd);
 		if (IS_ERR(simd))
 			goto err_unregister;
@@ -383,27 +361,19 @@ static int simd_aead_init(struct crypto_aead *tfm)
 	return 0;
 }
 
-struct simd_aead_alg *simd_aead_create_compat(const char *algname,
-					      const char *drvname,
-					      const char *basename)
+static struct simd_aead_alg *simd_aead_create_compat(struct aead_alg *ialg,
+						     const char *algname,
+						     const char *drvname,
+						     const char *basename)
 {
 	struct simd_aead_alg *salg;
-	struct crypto_aead *tfm;
-	struct aead_alg *ialg;
 	struct aead_alg *alg;
 	int err;
 
-	tfm = crypto_alloc_aead(basename, CRYPTO_ALG_INTERNAL,
-				CRYPTO_ALG_INTERNAL | CRYPTO_ALG_ASYNC);
-	if (IS_ERR(tfm))
-		return ERR_CAST(tfm);
-
-	ialg = crypto_aead_alg(tfm);
-
 	salg = kzalloc(sizeof(*salg), GFP_KERNEL);
 	if (!salg) {
 		salg = ERR_PTR(-ENOMEM);
-		goto out_put_tfm;
+		goto out;
 	}
 
 	salg->ialg_name = basename;
@@ -442,36 +412,20 @@ struct simd_aead_alg *simd_aead_create_compat(const char *algname,
 	if (err)
 		goto out_free_salg;
 
-out_put_tfm:
-	crypto_free_aead(tfm);
+out:
 	return salg;
 
 out_free_salg:
 	kfree(salg);
 	salg = ERR_PTR(err);
-	goto out_put_tfm;
-}
-EXPORT_SYMBOL_GPL(simd_aead_create_compat);
-
-struct simd_aead_alg *simd_aead_create(const char *algname,
-				       const char *basename)
-{
-	char drvname[CRYPTO_MAX_ALG_NAME];
-
-	if (snprintf(drvname, CRYPTO_MAX_ALG_NAME, "simd-%s", basename) >=
-	    CRYPTO_MAX_ALG_NAME)
-		return ERR_PTR(-ENAMETOOLONG);
-
-	return simd_aead_create_compat(algname, drvname, basename);
+	goto out;
 }
-EXPORT_SYMBOL_GPL(simd_aead_create);
 
-void simd_aead_free(struct simd_aead_alg *salg)
+static void simd_aead_free(struct simd_aead_alg *salg)
 {
 	crypto_unregister_aead(&salg->alg);
 	kfree(salg);
 }
-EXPORT_SYMBOL_GPL(simd_aead_free);
 
 int simd_register_aeads_compat(struct aead_alg *algs, int count,
 			       struct simd_aead_alg **simd_algs)
@@ -493,7 +447,7 @@ int simd_register_aeads_compat(struct aead_alg *algs, int count,
 		algname = algs[i].base.cra_name + 2;
 		drvname = algs[i].base.cra_driver_name + 2;
 		basename = algs[i].base.cra_driver_name;
-		simd = simd_aead_create_compat(algname, drvname, basename);
+		simd = simd_aead_create_compat(algs + i, algname, drvname, basename);
 		err = PTR_ERR(simd);
 		if (IS_ERR(simd))
 			goto err_unregister;
diff --git a/include/crypto/internal/simd.h b/include/crypto/internal/simd.h
index d2316242a9884..be97b97a75dd2 100644
--- a/include/crypto/internal/simd.h
+++ b/include/crypto/internal/simd.h
@@ -14,11 +14,10 @@
 struct simd_skcipher_alg;
 struct skcipher_alg;
 
-struct simd_skcipher_alg *simd_skcipher_create_compat(const char *algname,
+struct simd_skcipher_alg *simd_skcipher_create_compat(struct skcipher_alg *ialg,
+						      const char *algname,
 						      const char *drvname,
 						      const char *basename);
-struct simd_skcipher_alg *simd_skcipher_create(const char *algname,
-					       const char *basename);
 void simd_skcipher_free(struct simd_skcipher_alg *alg);
 
 int simd_register_skciphers_compat(struct skcipher_alg *algs, int count,
@@ -32,13 +31,6 @@ void simd_unregister_skciphers(struct skcipher_alg *algs, int count,
 struct simd_aead_alg;
 struct aead_alg;
 
-struct simd_aead_alg *simd_aead_create_compat(const char *algname,
-					      const char *drvname,
-					      const char *basename);
-struct simd_aead_alg *simd_aead_create(const char *algname,
-				       const char *basename);
-void simd_aead_free(struct simd_aead_alg *alg);
-
 int simd_register_aeads_compat(struct aead_alg *algs, int count,
 			       struct simd_aead_alg **simd_algs);
 
-- 
2.43.0



Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6658B12C01C
	for <lists+linux-crypto@lfdr.de>; Sun, 29 Dec 2019 03:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfL2C6M (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 28 Dec 2019 21:58:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfL2C6K (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 28 Dec 2019 21:58:10 -0500
Received: from zzz.tds (h75-100-12-111.burkwi.broadband.dynamic.tds.net [75.100.12.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5922F222C2
        for <linux-crypto@vger.kernel.org>; Sun, 29 Dec 2019 02:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577588289;
        bh=qy6VnRYwU8EPVATG6o5TQ21TXGyLMkuHWO1MYs1OH08=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QoP3+nXMZuwdsON7YmRfVrHmu69eElYufvi450UdZelqZmxdgVVdRE3BGR67cR/p6
         ZxBSoCGiTMpOinpW/NoR46E17AsBV35PnOyAFUNyHVv5z5FIQL41/0ZCawSiV3iSWy
         NapZO8B88wTHuTI9yzQAeJs+TZLVrRuO0Oxq6To4=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Subject: [PATCH 16/28] crypto: authencesn - use crypto_grab_ahash() and simplify error paths
Date:   Sat, 28 Dec 2019 20:57:02 -0600
Message-Id: <20191229025714.544159-17-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229025714.544159-1-ebiggers@kernel.org>
References: <20191229025714.544159-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Make the authencesn template use the new function crypto_grab_ahash() to
initialize its ahash spawn.

This is needed to make all spawns be initialized in a consistent way.

Also simplify the error handling by taking advantage of crypto_drop_*()
now accepting (as a no-op) spawns that haven't been initialized yet, and
by taking advantage of crypto_grab_*() now handling ERR_PTR() names.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/authencesn.c | 51 ++++++++++++---------------------------------
 1 file changed, 13 insertions(+), 38 deletions(-)

diff --git a/crypto/authencesn.c b/crypto/authencesn.c
index 48582c3741dc..8510373affe2 100644
--- a/crypto/authencesn.c
+++ b/crypto/authencesn.c
@@ -403,11 +403,10 @@ static int crypto_authenc_esn_create(struct crypto_template *tmpl,
 	struct crypto_attr_type *algt;
 	u32 mask;
 	struct aead_instance *inst;
+	struct authenc_esn_instance_ctx *ctx;
 	struct hash_alg_common *auth;
 	struct crypto_alg *auth_base;
 	struct skcipher_alg *enc;
-	struct authenc_esn_instance_ctx *ctx;
-	const char *enc_name;
 	int err;
 
 	algt = crypto_get_attr_type(tb);
@@ -419,47 +418,34 @@ static int crypto_authenc_esn_create(struct crypto_template *tmpl,
 
 	mask = crypto_requires_sync(algt->type, algt->mask);
 
-	auth = ahash_attr_alg(tb[1], CRYPTO_ALG_TYPE_HASH,
-			      CRYPTO_ALG_TYPE_AHASH_MASK | mask);
-	if (IS_ERR(auth))
-		return PTR_ERR(auth);
-
-	auth_base = &auth->base;
-
-	enc_name = crypto_attr_alg_name(tb[2]);
-	err = PTR_ERR(enc_name);
-	if (IS_ERR(enc_name))
-		goto out_put_auth;
-
 	inst = kzalloc(sizeof(*inst) + sizeof(*ctx), GFP_KERNEL);
-	err = -ENOMEM;
 	if (!inst)
-		goto out_put_auth;
-
+		return -ENOMEM;
 	ctx = aead_instance_ctx(inst);
 
-	err = crypto_init_ahash_spawn(&ctx->auth, auth,
-				      aead_crypto_instance(inst));
+	err = crypto_grab_ahash(&ctx->auth, aead_crypto_instance(inst),
+				crypto_attr_alg_name(tb[1]), 0, mask);
 	if (err)
-		goto err_free_inst;
+		goto out;
+	auth = crypto_spawn_ahash_alg(&ctx->auth);
+	auth_base = &auth->base;
 
 	err = crypto_grab_skcipher(&ctx->enc, aead_crypto_instance(inst),
-				   enc_name, 0, mask);
+				   crypto_attr_alg_name(tb[2]), 0, mask);
 	if (err)
-		goto err_drop_auth;
-
+		goto out;
 	enc = crypto_spawn_skcipher_alg(&ctx->enc);
 
 	err = -ENAMETOOLONG;
 	if (snprintf(inst->alg.base.cra_name, CRYPTO_MAX_ALG_NAME,
 		     "authencesn(%s,%s)", auth_base->cra_name,
 		     enc->base.cra_name) >= CRYPTO_MAX_ALG_NAME)
-		goto err_drop_enc;
+		goto out;
 
 	if (snprintf(inst->alg.base.cra_driver_name, CRYPTO_MAX_ALG_NAME,
 		     "authencesn(%s,%s)", auth_base->cra_driver_name,
 		     enc->base.cra_driver_name) >= CRYPTO_MAX_ALG_NAME)
-		goto err_drop_enc;
+		goto out;
 
 	inst->alg.base.cra_flags = (auth_base->cra_flags |
 				    enc->base.cra_flags) & CRYPTO_ALG_ASYNC;
@@ -485,21 +471,10 @@ static int crypto_authenc_esn_create(struct crypto_template *tmpl,
 	inst->free = crypto_authenc_esn_free,
 
 	err = aead_register_instance(tmpl, inst);
-	if (err)
-		goto err_drop_enc;
-
 out:
-	crypto_mod_put(auth_base);
+	if (err)
+		crypto_authenc_esn_free(inst);
 	return err;
-
-err_drop_enc:
-	crypto_drop_skcipher(&ctx->enc);
-err_drop_auth:
-	crypto_drop_ahash(&ctx->auth);
-err_free_inst:
-	kfree(inst);
-out_put_auth:
-	goto out;
 }
 
 static struct crypto_template crypto_authenc_esn_tmpl = {
-- 
2.24.1


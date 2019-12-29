Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35DFC12C026
	for <lists+linux-crypto@lfdr.de>; Sun, 29 Dec 2019 03:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfL2C6R (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 28 Dec 2019 21:58:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbfL2C6L (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 28 Dec 2019 21:58:11 -0500
Received: from zzz.tds (h75-100-12-111.burkwi.broadband.dynamic.tds.net [75.100.12.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00CFF218AC
        for <linux-crypto@vger.kernel.org>; Sun, 29 Dec 2019 02:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577588291;
        bh=35uGRs8Mw+Egw214ZqfsVQH9wmDMPthoDPJBCg2YkzY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pDDOwjMM7io9V+JsVVEu1o9WOkoRWpK2fWkeQZBW6MS3DipyUbYzCltAzGOvhQpcC
         AXG/p0EDuwlweA2XeL3UUkTL2Z72asP4VxWneCnKJr8vW4C0T5ciNSIf6O3ZgQxOrp
         vKIHlWwPAcHn7IsRklXblIXOv/bbx97/enT3H9mU=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Subject: [PATCH 20/28] crypto: skcipher - use crypto_grab_cipher() and simplify error paths
Date:   Sat, 28 Dec 2019 20:57:06 -0600
Message-Id: <20191229025714.544159-21-ebiggers@kernel.org>
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

Make skcipher_alloc_instance_simple() use the new function
crypto_grab_cipher() to initialize its cipher spawn.

This is needed to make all spawns be initialized in a consistent way.

Also simplify the error handling by taking advantage of crypto_drop_*()
now accepting (as a no-op) spawns that haven't been initialized yet, and
by taking advantage of crypto_grab_*() now handling ERR_PTR() names.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/skcipher.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/crypto/skcipher.c b/crypto/skcipher.c
index a9418a7e80a9..0615fead1529 100644
--- a/crypto/skcipher.c
+++ b/crypto/skcipher.c
@@ -923,7 +923,7 @@ static void skcipher_exit_tfm_simple(struct crypto_skcipher *tfm)
 
 static void skcipher_free_instance_simple(struct skcipher_instance *inst)
 {
-	crypto_drop_spawn(skcipher_instance_ctx(inst));
+	crypto_drop_cipher(skcipher_instance_ctx(inst));
 	kfree(inst);
 }
 
@@ -947,10 +947,10 @@ struct skcipher_instance *skcipher_alloc_instance_simple(
 	struct crypto_template *tmpl, struct rtattr **tb)
 {
 	struct crypto_attr_type *algt;
-	struct crypto_alg *cipher_alg;
-	struct skcipher_instance *inst;
-	struct crypto_spawn *spawn;
 	u32 mask;
+	struct skcipher_instance *inst;
+	struct crypto_cipher_spawn *spawn;
+	struct crypto_alg *cipher_alg;
 	int err;
 
 	algt = crypto_get_attr_type(tb);
@@ -964,28 +964,22 @@ struct skcipher_instance *skcipher_alloc_instance_simple(
 		crypto_requires_off(algt->type, algt->mask,
 				    CRYPTO_ALG_NEED_FALLBACK);
 
-	cipher_alg = crypto_get_attr_alg(tb, CRYPTO_ALG_TYPE_CIPHER, mask);
-	if (IS_ERR(cipher_alg))
-		return ERR_CAST(cipher_alg);
-
 	inst = kzalloc(sizeof(*inst) + sizeof(*spawn), GFP_KERNEL);
-	if (!inst) {
-		err = -ENOMEM;
-		goto err_put_cipher_alg;
-	}
+	if (!inst)
+		return ERR_PTR(-ENOMEM);
 	spawn = skcipher_instance_ctx(inst);
 
-	err = crypto_inst_setname(skcipher_crypto_instance(inst), tmpl->name,
-				  cipher_alg);
+	err = crypto_grab_cipher(spawn, skcipher_crypto_instance(inst),
+				 crypto_attr_alg_name(tb[1]), 0, mask);
 	if (err)
 		goto err_free_inst;
+	cipher_alg = crypto_spawn_cipher_alg(spawn);
 
-	spawn->dropref = true;
-	err = crypto_init_spawn(spawn, cipher_alg,
-				skcipher_crypto_instance(inst),
-				CRYPTO_ALG_TYPE_MASK);
+	err = crypto_inst_setname(skcipher_crypto_instance(inst), tmpl->name,
+				  cipher_alg);
 	if (err)
 		goto err_free_inst;
+
 	inst->free = skcipher_free_instance_simple;
 
 	/* Default algorithm properties, can be overridden */
@@ -1005,9 +999,7 @@ struct skcipher_instance *skcipher_alloc_instance_simple(
 	return inst;
 
 err_free_inst:
-	kfree(inst);
-err_put_cipher_alg:
-	crypto_mod_put(cipher_alg);
+	skcipher_free_instance_simple(inst);
 	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(skcipher_alloc_instance_simple);
-- 
2.24.1


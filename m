Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD2E312F3AF
	for <lists+linux-crypto@lfdr.de>; Fri,  3 Jan 2020 05:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgACEB2 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 2 Jan 2020 23:01:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:33554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgACEB0 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 2 Jan 2020 23:01:26 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A78352253D
        for <linux-crypto@vger.kernel.org>; Fri,  3 Jan 2020 04:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578024085;
        bh=T3wXyJUd3JddE1g429EumTNn10IDMcTcuSRCr0rOByY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GZpeq/DJYh4gMX/n3j4X5P3+/crzElntoeY4269uBsC1wuQ8TQBarblwUzWVi4sPM
         kE8CZgFO+evP0S7euOSASUhOx2Yp+DnwXsIo0d5F/O7hJyEWlKuijVrv0HRwiu/yDw
         bQuT+kjDbjviiOP9vQbEk64pUxMhqew8uWHIJvkU=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Subject: [PATCH v2 08/28] crypto: algapi - pass instance to crypto_grab_spawn()
Date:   Thu,  2 Jan 2020 19:58:48 -0800
Message-Id: <20200103035908.12048-9-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200103035908.12048-1-ebiggers@kernel.org>
References: <20200103035908.12048-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Currently, crypto_spawn::inst is first used temporarily to pass the
instance to crypto_grab_spawn().  Then crypto_init_spawn() overwrites it
with crypto_spawn::next, which shares the same union.  Finally,
crypto_spawn::inst is set again when the instance is registered.

Make this less convoluted by just passing the instance as an argument to
crypto_grab_spawn() instead.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/adiantum.c       |  6 +++---
 crypto/aead.c           |  3 +--
 crypto/akcipher.c       |  3 +--
 crypto/algapi.c         |  6 +++---
 crypto/skcipher.c       |  3 +--
 include/crypto/algapi.h | 10 ++--------
 6 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/crypto/adiantum.c b/crypto/adiantum.c
index aaf8a66f871c..9e44180111c8 100644
--- a/crypto/adiantum.c
+++ b/crypto/adiantum.c
@@ -550,9 +550,9 @@ static int adiantum_create(struct crypto_template *tmpl, struct rtattr **tb)
 	streamcipher_alg = crypto_spawn_skcipher_alg(&ictx->streamcipher_spawn);
 
 	/* Block cipher, e.g. "aes" */
-	crypto_set_spawn(&ictx->blockcipher_spawn,
-			 skcipher_crypto_instance(inst));
-	err = crypto_grab_spawn(&ictx->blockcipher_spawn, blockcipher_name,
+	err = crypto_grab_spawn(&ictx->blockcipher_spawn,
+				skcipher_crypto_instance(inst),
+				blockcipher_name,
 				CRYPTO_ALG_TYPE_CIPHER, CRYPTO_ALG_TYPE_MASK);
 	if (err)
 		goto out_drop_streamcipher;
diff --git a/crypto/aead.c b/crypto/aead.c
index c7135e00b8ea..02a0db076d7e 100644
--- a/crypto/aead.c
+++ b/crypto/aead.c
@@ -211,9 +211,8 @@ int crypto_grab_aead(struct crypto_aead_spawn *spawn,
 		     struct crypto_instance *inst,
 		     const char *name, u32 type, u32 mask)
 {
-	spawn->base.inst = inst;
 	spawn->base.frontend = &crypto_aead_type;
-	return crypto_grab_spawn(&spawn->base, name, type, mask);
+	return crypto_grab_spawn(&spawn->base, inst, name, type, mask);
 }
 EXPORT_SYMBOL_GPL(crypto_grab_aead);
 
diff --git a/crypto/akcipher.c b/crypto/akcipher.c
index 84ccf9b02bbe..eeed6c151d2f 100644
--- a/crypto/akcipher.c
+++ b/crypto/akcipher.c
@@ -94,9 +94,8 @@ int crypto_grab_akcipher(struct crypto_akcipher_spawn *spawn,
 			 struct crypto_instance *inst,
 			 const char *name, u32 type, u32 mask)
 {
-	spawn->base.inst = inst;
 	spawn->base.frontend = &crypto_akcipher_type;
-	return crypto_grab_spawn(&spawn->base, name, type, mask);
+	return crypto_grab_spawn(&spawn->base, inst, name, type, mask);
 }
 EXPORT_SYMBOL_GPL(crypto_grab_akcipher);
 
diff --git a/crypto/algapi.c b/crypto/algapi.c
index a5223c5f2275..a25ce02918f8 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -714,8 +714,8 @@ int crypto_init_spawn2(struct crypto_spawn *spawn, struct crypto_alg *alg,
 }
 EXPORT_SYMBOL_GPL(crypto_init_spawn2);
 
-int crypto_grab_spawn(struct crypto_spawn *spawn, const char *name,
-		      u32 type, u32 mask)
+int crypto_grab_spawn(struct crypto_spawn *spawn, struct crypto_instance *inst,
+		      const char *name, u32 type, u32 mask)
 {
 	struct crypto_alg *alg;
 	int err;
@@ -729,7 +729,7 @@ int crypto_grab_spawn(struct crypto_spawn *spawn, const char *name,
 		return PTR_ERR(alg);
 
 	spawn->dropref = true;
-	err = crypto_init_spawn(spawn, alg, spawn->inst, mask);
+	err = crypto_init_spawn(spawn, alg, inst, mask);
 	if (err)
 		crypto_mod_put(alg);
 	return err;
diff --git a/crypto/skcipher.c b/crypto/skcipher.c
index e5083dccccdc..a9418a7e80a9 100644
--- a/crypto/skcipher.c
+++ b/crypto/skcipher.c
@@ -761,9 +761,8 @@ int crypto_grab_skcipher(struct crypto_skcipher_spawn *spawn,
 			 struct crypto_instance *inst,
 			 const char *name, u32 type, u32 mask)
 {
-	spawn->base.inst = inst;
 	spawn->base.frontend = &crypto_skcipher_type;
-	return crypto_grab_spawn(&spawn->base, name, type, mask);
+	return crypto_grab_spawn(&spawn->base, inst, name, type, mask);
 }
 EXPORT_SYMBOL_GPL(crypto_grab_skcipher);
 
diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index 5022cada4fc6..2779c8d34ba9 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -116,20 +116,14 @@ int crypto_init_spawn(struct crypto_spawn *spawn, struct crypto_alg *alg,
 int crypto_init_spawn2(struct crypto_spawn *spawn, struct crypto_alg *alg,
 		       struct crypto_instance *inst,
 		       const struct crypto_type *frontend);
-int crypto_grab_spawn(struct crypto_spawn *spawn, const char *name,
-		      u32 type, u32 mask);
+int crypto_grab_spawn(struct crypto_spawn *spawn, struct crypto_instance *inst,
+		      const char *name, u32 type, u32 mask);
 
 void crypto_drop_spawn(struct crypto_spawn *spawn);
 struct crypto_tfm *crypto_spawn_tfm(struct crypto_spawn *spawn, u32 type,
 				    u32 mask);
 void *crypto_spawn_tfm2(struct crypto_spawn *spawn);
 
-static inline void crypto_set_spawn(struct crypto_spawn *spawn,
-				    struct crypto_instance *inst)
-{
-	spawn->inst = inst;
-}
-
 struct crypto_attr_type *crypto_get_attr_type(struct rtattr **tb);
 int crypto_check_attr_type(struct rtattr **tb, u32 type);
 const char *crypto_attr_alg_name(struct rtattr *rta);
-- 
2.24.1


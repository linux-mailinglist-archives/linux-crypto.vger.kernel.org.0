Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49BD912F3B0
	for <lists+linux-crypto@lfdr.de>; Fri,  3 Jan 2020 05:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgACEBb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 2 Jan 2020 23:01:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:33654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727249AbgACEBa (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 2 Jan 2020 23:01:30 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B68E2464B
        for <linux-crypto@vger.kernel.org>; Fri,  3 Jan 2020 04:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578024088;
        bh=53NpCC9PIB7NmhV6O++rQmXftGOGfBPNMfBa5ZdhHVI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JUrVEHdDIKLNbdg/ZuYONKMRXyUBEhuj4deooXnqVuNOEK7XpEdQ5I8btXXkdfcfZ
         diTri4q6Jt7HWPSRAxX+DYiT/TjV+HCurjOAdW6cXwuErdFr/C1LbqIMXY/Nu3Q5mi
         47cQ8SMcIPNR/4vXecNPLyhLg+oq/jGjZEgz/ERk=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Subject: [PATCH v2 22/28] crypto: cmac - use crypto_grab_cipher() and simplify error paths
Date:   Thu,  2 Jan 2020 19:59:02 -0800
Message-Id: <20200103035908.12048-23-ebiggers@kernel.org>
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

Make the cmac template use the new function crypto_grab_cipher() to
initialize its cipher spawn.

This is needed to make all spawns be initialized in a consistent way.

This required making cmac_create() allocate the instance directly rather
than use shash_alloc_instance().

Also simplify the error handling by taking advantage of crypto_drop_*()
now accepting (as a no-op) spawns that haven't been initialized yet, and
by taking advantage of crypto_grab_*() now handling ERR_PTR() names.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/cmac.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/crypto/cmac.c b/crypto/cmac.c
index 0928aebc6205..c6bf78b5321a 100644
--- a/crypto/cmac.c
+++ b/crypto/cmac.c
@@ -222,6 +222,7 @@ static void cmac_exit_tfm(struct crypto_tfm *tfm)
 static int cmac_create(struct crypto_template *tmpl, struct rtattr **tb)
 {
 	struct shash_instance *inst;
+	struct crypto_cipher_spawn *spawn;
 	struct crypto_alg *alg;
 	unsigned long alignmask;
 	int err;
@@ -230,10 +231,16 @@ static int cmac_create(struct crypto_template *tmpl, struct rtattr **tb)
 	if (err)
 		return err;
 
-	alg = crypto_get_attr_alg(tb, CRYPTO_ALG_TYPE_CIPHER,
-				  CRYPTO_ALG_TYPE_MASK);
-	if (IS_ERR(alg))
-		return PTR_ERR(alg);
+	inst = kzalloc(sizeof(*inst) + sizeof(*spawn), GFP_KERNEL);
+	if (!inst)
+		return -ENOMEM;
+	spawn = shash_instance_ctx(inst);
+
+	err = crypto_grab_cipher(spawn, shash_crypto_instance(inst),
+				 crypto_attr_alg_name(tb[1]), 0, 0);
+	if (err)
+		goto err_free_inst;
+	alg = crypto_spawn_cipher_alg(spawn);
 
 	switch (alg->cra_blocksize) {
 	case 16:
@@ -241,19 +248,12 @@ static int cmac_create(struct crypto_template *tmpl, struct rtattr **tb)
 		break;
 	default:
 		err = -EINVAL;
-		goto out_put_alg;
+		goto err_free_inst;
 	}
 
-	inst = shash_alloc_instance("cmac", alg);
-	err = PTR_ERR(inst);
-	if (IS_ERR(inst))
-		goto out_put_alg;
-
-	err = crypto_init_spawn(shash_instance_ctx(inst), alg,
-				shash_crypto_instance(inst),
-				CRYPTO_ALG_TYPE_MASK);
+	err = crypto_inst_setname(shash_crypto_instance(inst), tmpl->name, alg);
 	if (err)
-		goto out_free_inst;
+		goto err_free_inst;
 
 	alignmask = alg->cra_alignmask;
 	inst->alg.base.cra_alignmask = alignmask;
@@ -282,12 +282,9 @@ static int cmac_create(struct crypto_template *tmpl, struct rtattr **tb)
 
 	err = shash_register_instance(tmpl, inst);
 	if (err) {
-out_free_inst:
+err_free_inst:
 		shash_free_instance(shash_crypto_instance(inst));
 	}
-
-out_put_alg:
-	crypto_mod_put(alg);
 	return err;
 }
 
-- 
2.24.1


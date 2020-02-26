Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF5E16F6AF
	for <lists+linux-crypto@lfdr.de>; Wed, 26 Feb 2020 06:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgBZFBA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 26 Feb 2020 00:01:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:50554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgBZFBA (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 26 Feb 2020 00:01:00 -0500
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D3F120726
        for <linux-crypto@vger.kernel.org>; Wed, 26 Feb 2020 05:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582693260;
        bh=LyuWWg9skpodxMCZVIHiqEZ0MIEfa09EvTHzQKrp8KI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=d2aumOgG38twj5BaN1SKQeigwXipSiv3enGJNRp/wKvobr06vVTtwDJuKXN/GZYrx
         +Nm4Vkw2S/5lGtlZKYCzdM4e6ZR2cpHgeKO4FCxOwlQDnC/TvH/hjQGTfKPTNqXGoH
         2wh7LkssI5XwvCW12TOIQ0C/BoZnlgHlkL7BQoh0=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Subject: [PATCH 02/12] crypto: ccm - simplify error handling in crypto_rfc4309_create()
Date:   Tue, 25 Feb 2020 20:59:14 -0800
Message-Id: <20200226045924.97053-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200226045924.97053-1-ebiggers@kernel.org>
References: <20200226045924.97053-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Simplify the error handling in crypto_rfc4309_create() by taking
advantage of crypto_grab_aead() now handling an ERR_PTR() name and by
taking advantage of crypto_drop_aead() now accepting (as a no-op) a
spawn that hasn't been grabbed yet.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/ccm.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/crypto/ccm.c b/crypto/ccm.c
index 241ecdc5c4e0e..d1fb01bbc8143 100644
--- a/crypto/ccm.c
+++ b/crypto/ccm.c
@@ -717,7 +717,6 @@ static int crypto_rfc4309_create(struct crypto_template *tmpl,
 	struct aead_instance *inst;
 	struct crypto_aead_spawn *spawn;
 	struct aead_alg *alg;
-	const char *ccm_name;
 	int err;
 
 	algt = crypto_get_attr_type(tb);
@@ -729,19 +728,15 @@ static int crypto_rfc4309_create(struct crypto_template *tmpl,
 
 	mask = crypto_requires_sync(algt->type, algt->mask);
 
-	ccm_name = crypto_attr_alg_name(tb[1]);
-	if (IS_ERR(ccm_name))
-		return PTR_ERR(ccm_name);
-
 	inst = kzalloc(sizeof(*inst) + sizeof(*spawn), GFP_KERNEL);
 	if (!inst)
 		return -ENOMEM;
 
 	spawn = aead_instance_ctx(inst);
 	err = crypto_grab_aead(spawn, aead_crypto_instance(inst),
-			       ccm_name, 0, mask);
+			       crypto_attr_alg_name(tb[1]), 0, mask);
 	if (err)
-		goto out_free_inst;
+		goto err_free_inst;
 
 	alg = crypto_spawn_aead_alg(spawn);
 
@@ -749,11 +744,11 @@ static int crypto_rfc4309_create(struct crypto_template *tmpl,
 
 	/* We only support 16-byte blocks. */
 	if (crypto_aead_alg_ivsize(alg) != 16)
-		goto out_drop_alg;
+		goto err_free_inst;
 
 	/* Not a stream cipher? */
 	if (alg->base.cra_blocksize != 1)
-		goto out_drop_alg;
+		goto err_free_inst;
 
 	err = -ENAMETOOLONG;
 	if (snprintf(inst->alg.base.cra_name, CRYPTO_MAX_ALG_NAME,
@@ -762,7 +757,7 @@ static int crypto_rfc4309_create(struct crypto_template *tmpl,
 	    snprintf(inst->alg.base.cra_driver_name, CRYPTO_MAX_ALG_NAME,
 		     "rfc4309(%s)", alg->base.cra_driver_name) >=
 	    CRYPTO_MAX_ALG_NAME)
-		goto out_drop_alg;
+		goto err_free_inst;
 
 	inst->alg.base.cra_flags = alg->base.cra_flags & CRYPTO_ALG_ASYNC;
 	inst->alg.base.cra_priority = alg->base.cra_priority;
@@ -786,17 +781,11 @@ static int crypto_rfc4309_create(struct crypto_template *tmpl,
 	inst->free = crypto_rfc4309_free;
 
 	err = aead_register_instance(tmpl, inst);
-	if (err)
-		goto out_drop_alg;
-
-out:
+	if (err) {
+err_free_inst:
+		crypto_rfc4309_free(inst);
+	}
 	return err;
-
-out_drop_alg:
-	crypto_drop_aead(spawn);
-out_free_inst:
-	kfree(inst);
-	goto out;
 }
 
 static int crypto_cbcmac_digest_setkey(struct crypto_shash *parent,
-- 
2.25.1


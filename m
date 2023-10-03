Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E8E7B5F78
	for <lists+linux-crypto@lfdr.de>; Tue,  3 Oct 2023 05:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjJCDou (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 2 Oct 2023 23:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjJCDoq (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 2 Oct 2023 23:44:46 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC49C6
        for <linux-crypto@vger.kernel.org>; Mon,  2 Oct 2023 20:44:43 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qnWKs-002wRL-DK; Tue, 03 Oct 2023 11:44:39 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 03 Oct 2023 11:44:42 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 07/16] crypto: authencesn - Only access common skcipher fields on spawn
Date:   Tue,  3 Oct 2023 11:43:24 +0800
Message-Id: <20231003034333.1441826-8-herbert@gondor.apana.org.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003034333.1441826-1-herbert@gondor.apana.org.au>
References: <20231003034333.1441826-1-herbert@gondor.apana.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

As skcipher spawns may be of the type lskcipher, only the common
fields may be accessed.  This was already the case but use the
correct helpers to make this more obvious.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 crypto/authencesn.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/crypto/authencesn.c b/crypto/authencesn.c
index 91424e791d5c..60e9568f023f 100644
--- a/crypto/authencesn.c
+++ b/crypto/authencesn.c
@@ -390,9 +390,9 @@ static int crypto_authenc_esn_create(struct crypto_template *tmpl,
 	u32 mask;
 	struct aead_instance *inst;
 	struct authenc_esn_instance_ctx *ctx;
+	struct skcipher_alg_common *enc;
 	struct hash_alg_common *auth;
 	struct crypto_alg *auth_base;
-	struct skcipher_alg *enc;
 	int err;
 
 	err = crypto_check_attr_type(tb, CRYPTO_ALG_TYPE_AEAD, &mask);
@@ -415,7 +415,7 @@ static int crypto_authenc_esn_create(struct crypto_template *tmpl,
 				   crypto_attr_alg_name(tb[2]), 0, mask);
 	if (err)
 		goto err_free_inst;
-	enc = crypto_spawn_skcipher_alg(&ctx->enc);
+	enc = crypto_spawn_skcipher_alg_common(&ctx->enc);
 
 	err = -ENAMETOOLONG;
 	if (snprintf(inst->alg.base.cra_name, CRYPTO_MAX_ALG_NAME,
@@ -435,8 +435,8 @@ static int crypto_authenc_esn_create(struct crypto_template *tmpl,
 				       enc->base.cra_alignmask;
 	inst->alg.base.cra_ctxsize = sizeof(struct crypto_authenc_esn_ctx);
 
-	inst->alg.ivsize = crypto_skcipher_alg_ivsize(enc);
-	inst->alg.chunksize = crypto_skcipher_alg_chunksize(enc);
+	inst->alg.ivsize = enc->ivsize;
+	inst->alg.chunksize = enc->chunksize;
 	inst->alg.maxauthsize = auth->digestsize;
 
 	inst->alg.init = crypto_authenc_esn_init_tfm;
-- 
2.39.2


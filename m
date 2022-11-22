Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAD16334E3
	for <lists+linux-crypto@lfdr.de>; Tue, 22 Nov 2022 06:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiKVFxp (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 22 Nov 2022 00:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKVFxo (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 22 Nov 2022 00:53:44 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7C2264AE
        for <linux-crypto@vger.kernel.org>; Mon, 21 Nov 2022 21:53:42 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oxMDy-00Gvqf-V0; Tue, 22 Nov 2022 13:53:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 22 Nov 2022 13:53:38 +0800
Date:   Tue, 22 Nov 2022 13:53:38 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andrzej Zaborowski <andrew.zaborowski@intel.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: rsa-pkcs1pad - Use helper to set reqsize
Message-ID: <Y3xj4iGlW2lgMYpk@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The value of reqsize must only be changed through the helper.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/rsa-pkcs1pad.c b/crypto/rsa-pkcs1pad.c
index 3285e3af43e1..3bc76edb3f8a 100644
--- a/crypto/rsa-pkcs1pad.c
+++ b/crypto/rsa-pkcs1pad.c
@@ -579,6 +579,10 @@ static int pkcs1pad_init_tfm(struct crypto_akcipher *tfm)
 		return PTR_ERR(child_tfm);
 
 	ctx->child = child_tfm;
+
+	akcipher_set_reqsize(tfm, sizeof(struct pkcs1pad_request) +
+				  crypto_akcipher_reqsize(child_tfm));
+
 	return 0;
 }
 
@@ -674,7 +678,6 @@ static int pkcs1pad_create(struct crypto_template *tmpl, struct rtattr **tb)
 	inst->alg.set_pub_key = pkcs1pad_set_pub_key;
 	inst->alg.set_priv_key = pkcs1pad_set_priv_key;
 	inst->alg.max_size = pkcs1pad_get_max_size;
-	inst->alg.reqsize = sizeof(struct pkcs1pad_request) + rsa_alg->reqsize;
 
 	inst->free = pkcs1pad_free;
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

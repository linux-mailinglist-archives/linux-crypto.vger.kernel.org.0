Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7FB6E8EFC
	for <lists+linux-crypto@lfdr.de>; Thu, 20 Apr 2023 12:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjDTKGZ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 20 Apr 2023 06:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbjDTKFy (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 20 Apr 2023 06:05:54 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8361730DC
        for <linux-crypto@vger.kernel.org>; Thu, 20 Apr 2023 03:05:47 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1ppRAa-000YE4-N4; Thu, 20 Apr 2023 18:05:42 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 20 Apr 2023 18:05:41 +0800
Date:   Thu, 20 Apr 2023 18:05:41 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: hash - Make crypto_ahash_alg helper available
Message-ID: <ZEEOdfbxSY8EayoO@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Move the crypto_ahash_alg helper into include/crypto/internal so
that drivers can use it.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 crypto/ahash.c                 |    6 ------
 include/crypto/internal/hash.h |    6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/crypto/ahash.c b/crypto/ahash.c
index ad21101107bd..8e756e7b1f6d 100644
--- a/crypto/ahash.c
+++ b/crypto/ahash.c
@@ -31,12 +31,6 @@ struct ahash_request_priv {
 	void *ubuf[] CRYPTO_MINALIGN_ATTR;
 };
 
-static inline struct ahash_alg *crypto_ahash_alg(struct crypto_ahash *hash)
-{
-	return container_of(crypto_hash_alg_common(hash), struct ahash_alg,
-			    halg);
-}
-
 static int hash_walk_next(struct crypto_hash_walk *walk)
 {
 	unsigned int alignmask = walk->alignmask;
diff --git a/include/crypto/internal/hash.h b/include/crypto/internal/hash.h
index b925f82206ef..cf65676e45f4 100644
--- a/include/crypto/internal/hash.h
+++ b/include/crypto/internal/hash.h
@@ -149,6 +149,12 @@ static inline struct ahash_alg *__crypto_ahash_alg(struct crypto_alg *alg)
 			    halg);
 }
 
+static inline struct ahash_alg *crypto_ahash_alg(struct crypto_ahash *hash)
+{
+	return container_of(crypto_hash_alg_common(hash), struct ahash_alg,
+			    halg);
+}
+
 static inline void crypto_ahash_set_statesize(struct crypto_ahash *tfm,
 					      unsigned int size)
 {
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

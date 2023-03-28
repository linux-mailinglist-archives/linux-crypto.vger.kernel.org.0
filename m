Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C46E6CB538
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Mar 2023 05:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjC1D5a (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 27 Mar 2023 23:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjC1D5Q (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 27 Mar 2023 23:57:16 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C79CE9
        for <linux-crypto@vger.kernel.org>; Mon, 27 Mar 2023 20:57:14 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1ph0SL-009OXl-Af; Tue, 28 Mar 2023 11:57:10 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 28 Mar 2023 11:57:09 +0800
Date:   Tue, 28 Mar 2023 11:57:09 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas BOURGOIN <thomas.bourgoin@foss.st.com>
Subject: [PATCH] crypto: hash - Remove maximum statesize limit
Message-ID: <ZCJllZQBWfjMCaoQ@gondor.apana.org.au>
References: <ZCJk8JQV+0N3VwPS@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCJk8JQV+0N3VwPS@gondor.apana.org.au>
X-Spam-Status: No, score=4.3 required=5.0 tests=HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Remove the HASH_MAX_STATESIZE limit now that it is unused.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/shash.c b/crypto/shash.c
index dcc6a7170ce4..4cefa614dbbd 100644
--- a/crypto/shash.c
+++ b/crypto/shash.c
@@ -569,8 +569,7 @@ int hash_prepare_alg(struct hash_alg_common *alg)
 	struct crypto_istat_hash *istat = hash_get_stat(alg);
 	struct crypto_alg *base = &alg->base;
 
-	if (alg->digestsize > HASH_MAX_DIGESTSIZE ||
-	    alg->statesize > HASH_MAX_STATESIZE)
+	if (alg->digestsize > HASH_MAX_DIGESTSIZE)
 		return -EINVAL;
 
 	base->cra_flags &= ~CRYPTO_ALG_TYPE_MASK;
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 1ed674ba8429..3a04e601ad6a 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -183,8 +183,6 @@ struct shash_desc {
  */
 #define HASH_MAX_DESCSIZE	(sizeof(struct shash_desc) + 360)
 
-#define HASH_MAX_STATESIZE	512
-
 #define SHASH_DESC_ON_STACK(shash, ctx)					     \
 	char __##shash##_desc[sizeof(struct shash_desc) + HASH_MAX_DESCSIZE] \
 		__aligned(__alignof__(struct shash_desc));		     \
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

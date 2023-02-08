Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5AF68EB62
	for <lists+linux-crypto@lfdr.de>; Wed,  8 Feb 2023 10:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjBHJad (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 8 Feb 2023 04:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjBHJaK (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 8 Feb 2023 04:30:10 -0500
Received: from formenos.hmeau.com (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C359647091
        for <linux-crypto@vger.kernel.org>; Wed,  8 Feb 2023 01:28:42 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pPgjn-008oXL-RK; Wed, 08 Feb 2023 17:27:36 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 08 Feb 2023 17:27:35 +0800
Date:   Wed, 8 Feb 2023 17:27:35 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Clemens Lang <cllang@redhat.com>
Subject: [PATCH] crypto: testmgr - Disable raw RSA in FIPS mode
Message-ID: <Y+NrB5q1VcIIa+jk@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

As FIPS is only able to verify the compliance of pkcs1pad the
underlying "rsa" algorithm should not be marked as fips_allowed.

Reported-by: Clemens Lang <cllang@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index dd748832ed4a..6fbb56c6bd4c 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -5467,7 +5467,6 @@ static const struct alg_test_desc alg_test_descs[] = {
 	}, {
 		.alg = "rsa",
 		.test = alg_test_akcipher,
-		.fips_allowed = 1,
 		.suite = {
 			.akcipher = __VECS(rsa_tv_template)
 		}
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

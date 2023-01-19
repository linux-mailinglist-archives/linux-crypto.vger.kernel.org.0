Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29E2673419
	for <lists+linux-crypto@lfdr.de>; Thu, 19 Jan 2023 10:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjASJBq (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 19 Jan 2023 04:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjASJBp (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 19 Jan 2023 04:01:45 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCCA6796A
        for <linux-crypto@vger.kernel.org>; Thu, 19 Jan 2023 01:01:42 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pIQnj-001ge2-Eh; Thu, 19 Jan 2023 17:01:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 19 Jan 2023 17:01:39 +0800
Date:   Thu, 19 Jan 2023 17:01:39 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: cryptd - Remove unnecessary skcipher_request_zero
Message-ID: <Y8kG84TrzsjoR3Zp@gondor.apana.org.au>
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

Previously the child skcipher request was stored on the stack and
therefore needed to be zeroed.  As it is now dynamically allocated
we no longer need to do so.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/cryptd.c b/crypto/cryptd.c
index ca3a40fc7da9..1ff58a021d57 100644
--- a/crypto/cryptd.c
+++ b/crypto/cryptd.c
@@ -272,7 +272,6 @@ static void cryptd_skcipher_encrypt(struct crypto_async_request *base,
 				   req->iv);
 
 	err = crypto_skcipher_encrypt(subreq);
-	skcipher_request_zero(subreq);
 
 	req->base.complete = rctx->complete;
 
@@ -300,7 +299,6 @@ static void cryptd_skcipher_decrypt(struct crypto_async_request *base,
 				   req->iv);
 
 	err = crypto_skcipher_decrypt(subreq);
-	skcipher_request_zero(subreq);
 
 	req->base.complete = rctx->complete;
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

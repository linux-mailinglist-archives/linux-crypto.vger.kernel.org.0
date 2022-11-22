Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C84A6338B7
	for <lists+linux-crypto@lfdr.de>; Tue, 22 Nov 2022 10:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiKVJk5 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 22 Nov 2022 04:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiKVJk4 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 22 Nov 2022 04:40:56 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1678F24F28
        for <linux-crypto@vger.kernel.org>; Tue, 22 Nov 2022 01:40:54 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oxPlr-00H3ED-Ao; Tue, 22 Nov 2022 17:40:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 22 Nov 2022 17:40:51 +0800
Date:   Tue, 22 Nov 2022 17:40:51 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: caam - Use helper to set reqsize
Message-ID: <Y3yZI18QRK0kdaX0@gondor.apana.org.au>
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

diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index 886727576710..642846693d7c 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -1099,6 +1099,8 @@ static int caam_rsa_init_tfm(struct crypto_akcipher *tfm)
 {
 	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
 
+	akcipher_set_reqsize(tfm, sizeof(struct caam_rsa_req_ctx));
+
 	ctx->dev = caam_jr_alloc();
 
 	if (IS_ERR(ctx->dev)) {
@@ -1141,7 +1143,6 @@ static struct caam_akcipher_alg caam_rsa = {
 		.max_size = caam_rsa_max_size,
 		.init = caam_rsa_init_tfm,
 		.exit = caam_rsa_exit_tfm,
-		.reqsize = sizeof(struct caam_rsa_req_ctx),
 		.base = {
 			.cra_name = "rsa",
 			.cra_driver_name = "rsa-caam",
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

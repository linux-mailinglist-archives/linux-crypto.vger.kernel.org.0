Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174974B035C
	for <lists+linux-crypto@lfdr.de>; Thu, 10 Feb 2022 03:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiBJCbQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 9 Feb 2022 21:31:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiBJCbP (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 9 Feb 2022 21:31:15 -0500
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1B8237C6
        for <linux-crypto@vger.kernel.org>; Wed,  9 Feb 2022 18:31:16 -0800 (PST)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nHzEn-0006gZ-SA; Thu, 10 Feb 2022 13:31:15 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 10 Feb 2022 13:31:13 +1100
Date:   Thu, 10 Feb 2022 13:31:13 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: lrw - Add dependency on ecb
Message-ID: <YgR48fFF6LGzkLRe@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The lrw template relies on ecb to work.  So we need to declare
a Kconfig dependency as well as a module softdep on it.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/Kconfig b/crypto/Kconfig
index e63d9ad55cb5..1bc4150850b7 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -428,6 +428,7 @@ config CRYPTO_LRW
 	select CRYPTO_SKCIPHER
 	select CRYPTO_MANAGER
 	select CRYPTO_GF128MUL
+	select CRYPTO_ECB
 	help
 	  LRW: Liskov Rivest Wagner, a tweakable, non malleable, non movable
 	  narrow block cipher mode for dm-crypt.  Use it with cipher
diff --git a/crypto/lrw.c b/crypto/lrw.c
index bcf09fbc750a..8d59a66b6525 100644
--- a/crypto/lrw.c
+++ b/crypto/lrw.c
@@ -428,3 +428,4 @@ module_exit(lrw_module_exit);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("LRW block cipher mode");
 MODULE_ALIAS_CRYPTO("lrw");
+MODULE_SOFTDEP("pre: ecb");
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

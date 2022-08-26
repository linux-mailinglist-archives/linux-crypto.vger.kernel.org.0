Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837695A268E
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Aug 2022 13:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344313AbiHZLGh (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 26 Aug 2022 07:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344486AbiHZLFt (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 26 Aug 2022 07:05:49 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BFD12A95
        for <linux-crypto@vger.kernel.org>; Fri, 26 Aug 2022 04:05:34 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oRX9X-00FQ4y-2m; Fri, 26 Aug 2022 21:05:32 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Aug 2022 19:05:31 +0800
Date:   Fri, 26 Aug 2022 19:05:31 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: aspeed - Enable compile testing
Message-ID: <Ywio+53/JNNpoNhU@gondor.apana.org.au>
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

This driver compile tests just fine.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/aspeed/Kconfig b/drivers/crypto/aspeed/Kconfig
index 001bf2e09a72..ae3eb0eb57f6 100644
--- a/drivers/crypto/aspeed/Kconfig
+++ b/drivers/crypto/aspeed/Kconfig
@@ -1,6 +1,6 @@
 config CRYPTO_DEV_ASPEED
 	tristate "Support for Aspeed cryptographic engine driver"
-	depends on ARCH_ASPEED
+	depends on ARCH_ASPEED || COMPILE_TEST
 	help
 	  Hash and Crypto Engine (HACE) is designed to accelerate the
 	  throughput of hash data digest, encryption and decryption.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

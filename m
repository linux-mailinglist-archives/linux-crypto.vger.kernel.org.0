Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11F06978EE
	for <lists+linux-crypto@lfdr.de>; Wed, 15 Feb 2023 10:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjBOJ0O (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 15 Feb 2023 04:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbjBOJZ5 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 15 Feb 2023 04:25:57 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10863757D
        for <linux-crypto@vger.kernel.org>; Wed, 15 Feb 2023 01:25:28 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pSE2W-00BVm0-2d; Wed, 15 Feb 2023 17:25:25 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 15 Feb 2023 17:25:24 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Wed, 15 Feb 2023 17:25:24 +0800
Subject: [PATCH 9/10] crypto: api - Move MODULE_ALIAS_CRYPTO to algapi.h
References: <Y+ykvcAIAH5Rsn7C@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Message-Id: <E1pSE2W-00BVm0-2d@formenos.hmeau.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This is part of the low-level API and should not be exposed to
top-level Crypto API users.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 include/crypto/algapi.h |   13 +++++++++++++
 include/linux/crypto.h  |   13 -------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index dcc1fd4ef1b4..e28957993b56 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -34,6 +34,19 @@
 
 #define CRYPTO_DMA_PADDING ((CRYPTO_DMA_ALIGN - 1) & ~(CRYPTO_MINALIGN - 1))
 
+/*
+ * Autoloaded crypto modules should only use a prefixed name to avoid allowing
+ * arbitrary modules to be loaded. Loading from userspace may still need the
+ * unprefixed names, so retains those aliases as well.
+ * This uses __MODULE_INFO directly instead of MODULE_ALIAS because pre-4.3
+ * gcc (e.g. avr32 toolchain) uses __LINE__ for uniqueness, and this macro
+ * expands twice on the same line. Instead, use a separate base name for the
+ * alias.
+ */
+#define MODULE_ALIAS_CRYPTO(name)	\
+		__MODULE_INFO(alias, alias_userspace, name);	\
+		__MODULE_INFO(alias, alias_crypto, "crypto-" name)
+
 struct crypto_aead;
 struct crypto_instance;
 struct module;
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index c26e59bb7bca..d57597ebef6e 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -20,19 +20,6 @@
 #include <linux/slab.h>
 #include <linux/completion.h>
 
-/*
- * Autoloaded crypto modules should only use a prefixed name to avoid allowing
- * arbitrary modules to be loaded. Loading from userspace may still need the
- * unprefixed names, so retains those aliases as well.
- * This uses __MODULE_INFO directly instead of MODULE_ALIAS because pre-4.3
- * gcc (e.g. avr32 toolchain) uses __LINE__ for uniqueness, and this macro
- * expands twice on the same line. Instead, use a separate base name for the
- * alias.
- */
-#define MODULE_ALIAS_CRYPTO(name)	\
-		__MODULE_INFO(alias, alias_userspace, name);	\
-		__MODULE_INFO(alias, alias_crypto, "crypto-" name)
-
 /*
  * Algorithm masks and types.
  */

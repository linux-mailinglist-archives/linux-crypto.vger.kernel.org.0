Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097E27789CF
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Aug 2023 11:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbjHKJab (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 11 Aug 2023 05:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbjHKJaQ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 11 Aug 2023 05:30:16 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D41630EE
        for <linux-crypto@vger.kernel.org>; Fri, 11 Aug 2023 02:30:14 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qUOTB-0020dJ-8i; Fri, 11 Aug 2023 17:30:10 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 11 Aug 2023 17:30:09 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Fri, 11 Aug 2023 17:30:09 +0800
Subject: [PATCH 15/36] crypto: engine - Move crypto inclusions out of header file
References: <ZNX/BwEkV3SDpsAS@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Gaurav Jain <gaurav.jain@nxp.com>
Message-Id: <E1qUOTB-0020dJ-8i@formenos.hmeau.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The engine file does not need the actual crypto type definitions
so move those header inclusions to where they are actually used.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 crypto/crypto_engine.c  |    7 ++++++-
 include/crypto/engine.h |   17 +++++++----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/crypto/crypto_engine.c b/crypto/crypto_engine.c
index 17f7955500a0..ba43dfba2fa9 100644
--- a/crypto/crypto_engine.c
+++ b/crypto/crypto_engine.c
@@ -7,10 +7,15 @@
  * Author: Baolin Wang <baolin.wang@linaro.org>
  */
 
+#include <crypto/aead.h>
+#include <crypto/akcipher.h>
+#include <crypto/engine.h>
+#include <crypto/hash.h>
+#include <crypto/kpp.h>
+#include <crypto/skcipher.h>
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/device.h>
-#include <crypto/engine.h>
 #include <uapi/linux/sched/types.h>
 #include "internal.h"
 
diff --git a/include/crypto/engine.h b/include/crypto/engine.h
index 1b02f69e0a79..643639c3227c 100644
--- a/include/crypto/engine.h
+++ b/include/crypto/engine.h
@@ -7,20 +7,17 @@
 #ifndef _CRYPTO_ENGINE_H
 #define _CRYPTO_ENGINE_H
 
-#include <linux/crypto.h>
-#include <linux/list.h>
+#include <crypto/algapi.h>
 #include <linux/kthread.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/types.h>
 
-#include <crypto/algapi.h>
-#include <crypto/aead.h>
-#include <crypto/akcipher.h>
-#include <crypto/hash.h>
-#include <crypto/skcipher.h>
-#include <crypto/kpp.h>
-
+struct aead_request;
+struct ahash_request;
+struct akcipher_request;
 struct device;
+struct kpp_request;
+struct skcipher_request;
 
 #define ENGINE_NAME_LEN	30
 /*

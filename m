Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5743177A544
	for <lists+linux-crypto@lfdr.de>; Sun, 13 Aug 2023 08:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjHMGzC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 13 Aug 2023 02:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjHMGyo (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 13 Aug 2023 02:54:44 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B0B1719
        for <linux-crypto@vger.kernel.org>; Sat, 12 Aug 2023 23:54:45 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qV4zo-002bmE-Mp; Sun, 13 Aug 2023 14:54:41 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 13 Aug 2023 14:54:41 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Sun, 13 Aug 2023 14:54:41 +0800
Subject: [v2 PATCH 17/36] crypto: engine - Create internal/engine.h
References: <ZNh94a7YYnvx0l8C@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Gaurav Jain <gaurav.jain@nxp.com>
Message-Id: <E1qV4zo-002bmE-Mp@formenos.hmeau.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Create crypto/internal/engine.h to house details that should not
be used by drivers.  It is empty for the time being.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 crypto/crypto_engine.c           |    2 +-
 include/crypto/internal/engine.h |   13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/crypto/crypto_engine.c b/crypto/crypto_engine.c
index ba43dfba2fa9..a75162bc1bf4 100644
--- a/crypto/crypto_engine.c
+++ b/crypto/crypto_engine.c
@@ -9,8 +9,8 @@
 
 #include <crypto/aead.h>
 #include <crypto/akcipher.h>
-#include <crypto/engine.h>
 #include <crypto/hash.h>
+#include <crypto/internal/engine.h>
 #include <crypto/kpp.h>
 #include <crypto/skcipher.h>
 #include <linux/err.h>
diff --git a/include/crypto/internal/engine.h b/include/crypto/internal/engine.h
new file mode 100644
index 000000000000..ffa1bb39d5e4
--- /dev/null
+++ b/include/crypto/internal/engine.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Crypto engine API
+ *
+ * Copyright (c) 2016 Baolin Wang <baolin.wang@linaro.org>
+ * Copyright (c) 2023 Herbert Xu <herbert@gondor.apana.org.au>
+ */
+#ifndef _CRYPTO_INTERNAL_ENGINE_H
+#define _CRYPTO_INTERNAL_ENGINE_H
+
+#include <crypto/engine.h>
+
+#endif

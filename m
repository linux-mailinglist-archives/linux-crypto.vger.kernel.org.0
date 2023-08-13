Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244C577A546
	for <lists+linux-crypto@lfdr.de>; Sun, 13 Aug 2023 08:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjHMGzE (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 13 Aug 2023 02:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjHMGys (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 13 Aug 2023 02:54:48 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D4D1712
        for <linux-crypto@vger.kernel.org>; Sat, 12 Aug 2023 23:54:49 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qV4zs-002bmb-Se; Sun, 13 Aug 2023 14:54:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 13 Aug 2023 14:54:45 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Sun, 13 Aug 2023 14:54:45 +0800
Subject: [v2 PATCH 19/36] crypto: caam - Include internal/engine.h
References: <ZNh94a7YYnvx0l8C@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Gaurav Jain <gaurav.jain@nxp.com>
Message-Id: <E1qV4zs-002bmb-Se@formenos.hmeau.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Inlucde internal/engine.h because this driver uses directly
accesses attributes inside struct crypto_engine.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 drivers/crypto/caam/caamalg.c  |    4 ++--
 drivers/crypto/caam/caamhash.c |    2 +-
 drivers/crypto/caam/caampkc.c  |    1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index feb86013dbf6..da8182ee86fe 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -56,9 +56,9 @@
 #include "sg_sw_sec4.h"
 #include "key_gen.h"
 #include "caamalg_desc.h"
-#include <crypto/engine.h>
-#include <crypto/xts.h>
 #include <asm/unaligned.h>
+#include <crypto/internal/engine.h>
+#include <crypto/xts.h>
 #include <linux/dma-mapping.h>
 #include <linux/device.h>
 #include <linux/err.h>
diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index 641c3afd59ca..9ef25387f6b6 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -65,7 +65,7 @@
 #include "sg_sw_sec4.h"
 #include "key_gen.h"
 #include "caamhash_desc.h"
-#include <crypto/engine.h>
+#include <crypto/internal/engine.h>
 #include <linux/dma-mapping.h>
 #include <linux/kernel.h>
 
diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index 72afc249d42f..72670cd10b87 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -16,6 +16,7 @@
 #include "desc_constr.h"
 #include "sg_sw_sec4.h"
 #include "caampkc.h"
+#include <crypto/internal/engine.h>
 #include <linux/dma-mapping.h>
 #include <linux/kernel.h>
 

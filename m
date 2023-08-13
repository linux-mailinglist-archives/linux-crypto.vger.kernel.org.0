Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E2777A55B
	for <lists+linux-crypto@lfdr.de>; Sun, 13 Aug 2023 08:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjHMG4C (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 13 Aug 2023 02:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjHMGzX (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 13 Aug 2023 02:55:23 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801E2172D
        for <linux-crypto@vger.kernel.org>; Sat, 12 Aug 2023 23:55:25 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qV50S-002bx0-LS; Sun, 13 Aug 2023 14:55:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 13 Aug 2023 14:55:20 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Sun, 13 Aug 2023 14:55:20 +0800
Subject: [v2 PATCH 36/36] crypto: engine - Remove crypto_engine_ctx
References: <ZNh94a7YYnvx0l8C@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Gaurav Jain <gaurav.jain@nxp.com>
Message-Id: <E1qV50S-002bx0-LS@formenos.hmeau.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Remove the obsolete crypto_engine_ctx structure.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 crypto/crypto_engine.c  |   12 +++---------
 include/crypto/engine.h |    4 ----
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/crypto/crypto_engine.c b/crypto/crypto_engine.c
index abfb1e6bfa48..108d9d55c509 100644
--- a/crypto/crypto_engine.c
+++ b/crypto/crypto_engine.c
@@ -79,7 +79,6 @@ static void crypto_pump_requests(struct crypto_engine *engine,
 	unsigned long flags;
 	bool was_busy = false;
 	int ret;
-	struct crypto_engine_ctx *enginectx;
 
 	spin_lock_irqsave(&engine->queue_lock, flags);
 
@@ -154,14 +153,9 @@ static void crypto_pump_requests(struct crypto_engine *engine,
 				   struct crypto_engine_alg, base);
 		op = &alg->op;
 	} else {
-		enginectx = crypto_tfm_ctx(async_req->tfm);
-		op = &enginectx->op;
-
-		if (!op->do_one_request) {
-			dev_err(engine->dev, "failed to do request\n");
-			ret = -EINVAL;
-			goto req_err_1;
-		}
+		dev_err(engine->dev, "failed to do request\n");
+		ret = -EINVAL;
+		goto req_err_1;
 	}
 
 	ret = op->do_one_request(engine, async_req);
diff --git a/include/crypto/engine.h b/include/crypto/engine.h
index cf57e732566b..2835069c5997 100644
--- a/include/crypto/engine.h
+++ b/include/crypto/engine.h
@@ -26,10 +26,6 @@ struct crypto_engine_op {
 			      void *areq);
 };
 
-struct crypto_engine_ctx {
-	struct crypto_engine_op op;
-};
-
 struct aead_engine_alg {
 	struct aead_alg base;
 	struct crypto_engine_op op;

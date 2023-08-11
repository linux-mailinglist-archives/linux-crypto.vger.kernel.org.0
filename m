Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F707789C6
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Aug 2023 11:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbjHKJaC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 11 Aug 2023 05:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbjHKJaA (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 11 Aug 2023 05:30:00 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE42D2D5B
        for <linux-crypto@vger.kernel.org>; Fri, 11 Aug 2023 02:29:59 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qUOSw-0020Zm-I2; Fri, 11 Aug 2023 17:29:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 11 Aug 2023 17:29:54 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Fri, 11 Aug 2023 17:29:54 +0800
Subject: [PATCH 8/36] crypto: rk3288 - Remove prepare/unprepare request
References: <ZNX/BwEkV3SDpsAS@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Gaurav Jain <gaurav.jain@nxp.com>
Message-Id: <E1qUOSw-0020Zm-I2@formenos.hmeau.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The callbacks for prepare and unprepare request in crypto_engine
is superfluous.  They can be done directly from do_one_request.

Move the code into do_one_request and remove the unused callbacks.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 drivers/crypto/rockchip/rk3288_crypto_ahash.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
index a78ff3dcd0b1..1519aa0a0f7c 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -240,14 +240,13 @@ static int rk_hash_prepare(struct crypto_engine *engine, void *breq)
 	return 0;
 }
 
-static int rk_hash_unprepare(struct crypto_engine *engine, void *breq)
+static void rk_hash_unprepare(struct crypto_engine *engine, void *breq)
 {
 	struct ahash_request *areq = container_of(breq, struct ahash_request, base);
 	struct rk_ahash_rctx *rctx = ahash_request_ctx(areq);
 	struct rk_crypto_info *rkc = rctx->dev;
 
 	dma_unmap_sg(rkc->dev, areq->src, rctx->nrsg, DMA_TO_DEVICE);
-	return 0;
 }
 
 static int rk_hash_run(struct crypto_engine *engine, void *breq)
@@ -259,7 +258,7 @@ static int rk_hash_run(struct crypto_engine *engine, void *breq)
 	struct rk_crypto_tmp *algt = container_of(alg, struct rk_crypto_tmp, alg.hash);
 	struct scatterlist *sg = areq->src;
 	struct rk_crypto_info *rkc = rctx->dev;
-	int err = 0;
+	int err;
 	int i;
 	u32 v;
 
@@ -267,6 +266,10 @@ static int rk_hash_run(struct crypto_engine *engine, void *breq)
 	if (err)
 		return err;
 
+	err = rk_hash_prepare(engine, breq);
+	if (err)
+		goto theend;
+
 	rctx->mode = 0;
 
 	algt->stat_req++;
@@ -327,6 +330,8 @@ static int rk_hash_run(struct crypto_engine *engine, void *breq)
 	crypto_finalize_hash_request(engine, breq, err);
 	local_bh_enable();
 
+	rk_hash_unprepare(engine, breq);
+
 	return 0;
 }
 
@@ -350,8 +355,6 @@ static int rk_cra_hash_init(struct crypto_tfm *tfm)
 				 crypto_ahash_reqsize(tctx->fallback_tfm));
 
 	tctx->enginectx.op.do_one_request = rk_hash_run;
-	tctx->enginectx.op.prepare_request = rk_hash_prepare;
-	tctx->enginectx.op.unprepare_request = rk_hash_unprepare;
 
 	return 0;
 }

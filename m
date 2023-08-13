Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F9E77A53A
	for <lists+linux-crypto@lfdr.de>; Sun, 13 Aug 2023 08:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjHMGy2 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 13 Aug 2023 02:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjHMGyX (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 13 Aug 2023 02:54:23 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8440E1719
        for <linux-crypto@vger.kernel.org>; Sat, 12 Aug 2023 23:54:24 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qV4zT-002bkH-KB; Sun, 13 Aug 2023 14:54:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 13 Aug 2023 14:54:19 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Sun, 13 Aug 2023 14:54:19 +0800
Subject: [v2 PATCH 7/36] crypto: omap - Remove prepare/unprepare request
References: <ZNh94a7YYnvx0l8C@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Gaurav Jain <gaurav.jain@nxp.com>
Message-Id: <E1qV4zT-002bkH-KB@formenos.hmeau.com>
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

 drivers/crypto/omap-aes-gcm.c |   14 +++++++-------
 drivers/crypto/omap-aes.c     |   19 ++++---------------
 drivers/crypto/omap-des.c     |   19 ++++---------------
 drivers/crypto/omap-sham.c    |    6 ++++--
 4 files changed, 19 insertions(+), 39 deletions(-)

diff --git a/drivers/crypto/omap-aes-gcm.c b/drivers/crypto/omap-aes-gcm.c
index 9f937bdc53a7..d02363e976e7 100644
--- a/drivers/crypto/omap-aes-gcm.c
+++ b/drivers/crypto/omap-aes-gcm.c
@@ -212,12 +212,10 @@ static int omap_aes_gcm_handle_queue(struct omap_aes_dev *dd,
 	return 0;
 }
 
-static int omap_aes_gcm_prepare_req(struct crypto_engine *engine, void *areq)
+static int omap_aes_gcm_prepare_req(struct aead_request *req,
+				    struct omap_aes_dev *dd)
 {
-	struct aead_request *req = container_of(areq, struct aead_request,
-						base);
 	struct omap_aes_reqctx *rctx = aead_request_ctx(req);
-	struct omap_aes_dev *dd = rctx->dd;
 	struct omap_aes_gcm_ctx *ctx = crypto_aead_ctx(crypto_aead_reqtfm(req));
 	int err;
 
@@ -362,11 +360,15 @@ static int omap_aes_gcm_crypt_req(struct crypto_engine *engine, void *areq)
 						base);
 	struct omap_aes_reqctx *rctx = aead_request_ctx(req);
 	struct omap_aes_dev *dd = rctx->dd;
-	int ret = 0;
+	int ret;
 
 	if (!dd)
 		return -ENODEV;
 
+	ret = omap_aes_gcm_prepare_req(req, dd);
+	if (ret)
+		return ret;
+
 	if (dd->in_sg_len)
 		ret = omap_aes_crypt_dma_start(dd);
 	else
@@ -379,8 +381,6 @@ int omap_aes_gcm_cra_init(struct crypto_aead *tfm)
 {
 	struct omap_aes_ctx *ctx = crypto_aead_ctx(tfm);
 
-	ctx->enginectx.op.prepare_request = omap_aes_gcm_prepare_req;
-	ctx->enginectx.op.unprepare_request = NULL;
 	ctx->enginectx.op.do_one_request = omap_aes_gcm_crypt_req;
 
 	crypto_aead_set_reqsize(tfm, sizeof(struct omap_aes_reqctx));
diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
index 67a99c760bc4..d6fb8676f6cc 100644
--- a/drivers/crypto/omap-aes.c
+++ b/drivers/crypto/omap-aes.c
@@ -426,20 +426,15 @@ static int omap_aes_handle_queue(struct omap_aes_dev *dd,
 	return 0;
 }
 
-static int omap_aes_prepare_req(struct crypto_engine *engine,
-				void *areq)
+static int omap_aes_prepare_req(struct skcipher_request *req,
+				struct omap_aes_dev *dd)
 {
-	struct skcipher_request *req = container_of(areq, struct skcipher_request, base);
 	struct omap_aes_ctx *ctx = crypto_skcipher_ctx(
 			crypto_skcipher_reqtfm(req));
 	struct omap_aes_reqctx *rctx = skcipher_request_ctx(req);
-	struct omap_aes_dev *dd = rctx->dd;
 	int ret;
 	u16 flags;
 
-	if (!dd)
-		return -ENODEV;
-
 	/* assign new request to device */
 	dd->req = req;
 	dd->total = req->cryptlen;
@@ -491,7 +486,8 @@ static int omap_aes_crypt_req(struct crypto_engine *engine,
 	if (!dd)
 		return -ENODEV;
 
-	return omap_aes_crypt_dma_start(dd);
+	return omap_aes_prepare_req(req, dd) ?:
+	       omap_aes_crypt_dma_start(dd);
 }
 
 static void omap_aes_copy_ivout(struct omap_aes_dev *dd, u8 *ivbuf)
@@ -629,11 +625,6 @@ static int omap_aes_ctr_decrypt(struct skcipher_request *req)
 	return omap_aes_crypt(req, FLAGS_CTR);
 }
 
-static int omap_aes_prepare_req(struct crypto_engine *engine,
-				void *req);
-static int omap_aes_crypt_req(struct crypto_engine *engine,
-			      void *req);
-
 static int omap_aes_init_tfm(struct crypto_skcipher *tfm)
 {
 	const char *name = crypto_tfm_alg_name(&tfm->base);
@@ -649,8 +640,6 @@ static int omap_aes_init_tfm(struct crypto_skcipher *tfm)
 	crypto_skcipher_set_reqsize(tfm, sizeof(struct omap_aes_reqctx) +
 					 crypto_skcipher_reqsize(blk));
 
-	ctx->enginectx.op.prepare_request = omap_aes_prepare_req;
-	ctx->enginectx.op.unprepare_request = NULL;
 	ctx->enginectx.op.do_one_request = omap_aes_crypt_req;
 
 	return 0;
diff --git a/drivers/crypto/omap-des.c b/drivers/crypto/omap-des.c
index 371a51094e34..29a3b4c9edaf 100644
--- a/drivers/crypto/omap-des.c
+++ b/drivers/crypto/omap-des.c
@@ -522,20 +522,15 @@ static int omap_des_handle_queue(struct omap_des_dev *dd,
 	return 0;
 }
 
-static int omap_des_prepare_req(struct crypto_engine *engine,
-				void *areq)
+static int omap_des_prepare_req(struct skcipher_request *req,
+				struct omap_des_dev *dd)
 {
-	struct skcipher_request *req = container_of(areq, struct skcipher_request, base);
 	struct omap_des_ctx *ctx = crypto_skcipher_ctx(
 			crypto_skcipher_reqtfm(req));
-	struct omap_des_dev *dd = omap_des_find_dev(ctx);
 	struct omap_des_reqctx *rctx;
 	int ret;
 	u16 flags;
 
-	if (!dd)
-		return -ENODEV;
-
 	/* assign new request to device */
 	dd->req = req;
 	dd->total = req->cryptlen;
@@ -590,7 +585,8 @@ static int omap_des_crypt_req(struct crypto_engine *engine,
 	if (!dd)
 		return -ENODEV;
 
-	return omap_des_crypt_dma_start(dd);
+	return omap_des_prepare_req(req, dd) ?:
+	       omap_des_crypt_dma_start(dd);
 }
 
 static void omap_des_done_task(unsigned long data)
@@ -709,11 +705,6 @@ static int omap_des_cbc_decrypt(struct skcipher_request *req)
 	return omap_des_crypt(req, FLAGS_CBC);
 }
 
-static int omap_des_prepare_req(struct crypto_engine *engine,
-				void *areq);
-static int omap_des_crypt_req(struct crypto_engine *engine,
-			      void *areq);
-
 static int omap_des_init_tfm(struct crypto_skcipher *tfm)
 {
 	struct omap_des_ctx *ctx = crypto_skcipher_ctx(tfm);
@@ -722,8 +713,6 @@ static int omap_des_init_tfm(struct crypto_skcipher *tfm)
 
 	crypto_skcipher_set_reqsize(tfm, sizeof(struct omap_des_reqctx));
 
-	ctx->enginectx.op.prepare_request = omap_des_prepare_req;
-	ctx->enginectx.op.unprepare_request = NULL;
 	ctx->enginectx.op.do_one_request = omap_des_crypt_req;
 
 	return 0;
diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index cbeda59c6b19..2ef92301969f 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -1074,6 +1074,10 @@ static int omap_sham_hash_one_req(struct crypto_engine *engine, void *areq)
 	dev_dbg(dd->dev, "hash-one: op: %u, total: %u, digcnt: %zd, final: %d",
 		ctx->op, ctx->total, ctx->digcnt, final);
 
+	err = omap_sham_prepare_request(engine, areq);
+	if (err)
+		return err;
+
 	err = pm_runtime_resume_and_get(dd->dev);
 	if (err < 0) {
 		dev_err(dd->dev, "failed to get sync: %d\n", err);
@@ -1350,8 +1354,6 @@ static int omap_sham_cra_init_alg(struct crypto_tfm *tfm, const char *alg_base)
 	}
 
 	tctx->enginectx.op.do_one_request = omap_sham_hash_one_req;
-	tctx->enginectx.op.prepare_request = omap_sham_prepare_request;
-	tctx->enginectx.op.unprepare_request = NULL;
 
 	return 0;
 }

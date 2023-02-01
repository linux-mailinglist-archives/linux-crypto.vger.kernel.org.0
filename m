Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D78D682606
	for <lists+linux-crypto@lfdr.de>; Tue, 31 Jan 2023 09:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjAaIC0 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 31 Jan 2023 03:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjAaICL (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 31 Jan 2023 03:02:11 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223E842BF0
        for <linux-crypto@vger.kernel.org>; Tue, 31 Jan 2023 00:02:09 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pMlag-005viF-F5; Tue, 31 Jan 2023 16:02:07 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 31 Jan 2023 16:02:06 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Tue, 31 Jan 2023 16:02:06 +0800
Subject: [PATCH 11/32] crypto: cryptd - Use request_complete helpers
References: <Y9jKmRsdHsIwfFLo@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        linux-arm-kernel@axis.com,
        Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>,
        George Cherian <gcherian@marvell.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        Kai Ye <yekai13@huawei.com>,
        Longfang Liu <liulongfang@huawei.com>,
        Antoine Tenart <atenart@kernel.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        qat-linux@intel.com, Thara Gopinath <thara.gopinath@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>
Message-Id: <E1pMlag-005viF-F5@formenos.hmeau.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Use the request_complete helpers instead of calling the completion
function directly.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 crypto/cryptd.c |  228 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 120 insertions(+), 108 deletions(-)

diff --git a/crypto/cryptd.c b/crypto/cryptd.c
index c0c416eda8e8..06ef3fcbe4ae 100644
--- a/crypto/cryptd.c
+++ b/crypto/cryptd.c
@@ -72,7 +72,6 @@ struct cryptd_skcipher_ctx {
 };
 
 struct cryptd_skcipher_request_ctx {
-	crypto_completion_t complete;
 	struct skcipher_request req;
 };
 
@@ -83,6 +82,7 @@ struct cryptd_hash_ctx {
 
 struct cryptd_hash_request_ctx {
 	crypto_completion_t complete;
+	void *data;
 	struct shash_desc desc;
 };
 
@@ -92,7 +92,6 @@ struct cryptd_aead_ctx {
 };
 
 struct cryptd_aead_request_ctx {
-	crypto_completion_t complete;
 	struct aead_request req;
 };
 
@@ -178,8 +177,8 @@ static void cryptd_queue_worker(struct work_struct *work)
 		return;
 
 	if (backlog)
-		backlog->complete(backlog, -EINPROGRESS);
-	req->complete(req, 0);
+		crypto_request_complete(backlog, -EINPROGRESS);
+	crypto_request_complete(req, 0);
 
 	if (cpu_queue->queue.qlen)
 		queue_work(cryptd_wq, &cpu_queue->work);
@@ -238,18 +237,47 @@ static int cryptd_skcipher_setkey(struct crypto_skcipher *parent,
 	return crypto_skcipher_setkey(child, key, keylen);
 }
 
-static void cryptd_skcipher_complete(struct skcipher_request *req, int err)
+static struct skcipher_request *cryptd_skcipher_prepare(
+	struct skcipher_request *req, int err)
+{
+	struct cryptd_skcipher_request_ctx *rctx = skcipher_request_ctx(req);
+	struct skcipher_request *subreq = &rctx->req;
+	struct cryptd_skcipher_ctx *ctx;
+	struct crypto_skcipher *child;
+
+	req->base.complete = subreq->base.complete;
+	req->base.data = subreq->base.data;
+
+	if (unlikely(err == -EINPROGRESS))
+		return NULL;
+
+	ctx = crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
+	child = ctx->child;
+
+	skcipher_request_set_tfm(subreq, child);
+	skcipher_request_set_callback(subreq, CRYPTO_TFM_REQ_MAY_SLEEP,
+				      NULL, NULL);
+	skcipher_request_set_crypt(subreq, req->src, req->dst, req->cryptlen,
+				   req->iv);
+
+	return subreq;
+}
+
+static void cryptd_skcipher_complete(struct skcipher_request *req, int err,
+				     crypto_completion_t complete)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct cryptd_skcipher_ctx *ctx = crypto_skcipher_ctx(tfm);
-	struct cryptd_skcipher_request_ctx *rctx = skcipher_request_ctx(req);
 	int refcnt = refcount_read(&ctx->refcnt);
 
 	local_bh_disable();
-	rctx->complete(&req->base, err);
+	skcipher_request_complete(req, err);
 	local_bh_enable();
 
-	if (err != -EINPROGRESS && refcnt && refcount_dec_and_test(&ctx->refcnt))
+	if (unlikely(err == -EINPROGRESS)) {
+		req->base.complete = complete;
+		req->base.data = req;
+	} else if (refcnt && refcount_dec_and_test(&ctx->refcnt))
 		crypto_free_skcipher(tfm);
 }
 
@@ -257,54 +285,26 @@ static void cryptd_skcipher_encrypt(struct crypto_async_request *base,
 				    int err)
 {
 	struct skcipher_request *req = skcipher_request_cast(base);
-	struct cryptd_skcipher_request_ctx *rctx = skcipher_request_ctx(req);
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct cryptd_skcipher_ctx *ctx = crypto_skcipher_ctx(tfm);
-	struct skcipher_request *subreq = &rctx->req;
-	struct crypto_skcipher *child = ctx->child;
-
-	if (unlikely(err == -EINPROGRESS))
-		goto out;
-
-	skcipher_request_set_tfm(subreq, child);
-	skcipher_request_set_callback(subreq, CRYPTO_TFM_REQ_MAY_SLEEP,
-				      NULL, NULL);
-	skcipher_request_set_crypt(subreq, req->src, req->dst, req->cryptlen,
-				   req->iv);
-
-	err = crypto_skcipher_encrypt(subreq);
+	struct skcipher_request *subreq;
 
-	req->base.complete = rctx->complete;
+	subreq = cryptd_skcipher_prepare(req, err);
+	if (likely(subreq))
+		err = crypto_skcipher_encrypt(subreq);
 
-out:
-	cryptd_skcipher_complete(req, err);
+	cryptd_skcipher_complete(req, err, cryptd_skcipher_encrypt);
 }
 
 static void cryptd_skcipher_decrypt(struct crypto_async_request *base,
 				    int err)
 {
 	struct skcipher_request *req = skcipher_request_cast(base);
-	struct cryptd_skcipher_request_ctx *rctx = skcipher_request_ctx(req);
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct cryptd_skcipher_ctx *ctx = crypto_skcipher_ctx(tfm);
-	struct skcipher_request *subreq = &rctx->req;
-	struct crypto_skcipher *child = ctx->child;
+	struct skcipher_request *subreq;
 
-	if (unlikely(err == -EINPROGRESS))
-		goto out;
-
-	skcipher_request_set_tfm(subreq, child);
-	skcipher_request_set_callback(subreq, CRYPTO_TFM_REQ_MAY_SLEEP,
-				      NULL, NULL);
-	skcipher_request_set_crypt(subreq, req->src, req->dst, req->cryptlen,
-				   req->iv);
-
-	err = crypto_skcipher_decrypt(subreq);
-
-	req->base.complete = rctx->complete;
+	subreq = cryptd_skcipher_prepare(req, err);
+	if (likely(subreq))
+		err = crypto_skcipher_decrypt(subreq);
 
-out:
-	cryptd_skcipher_complete(req, err);
+	cryptd_skcipher_complete(req, err, cryptd_skcipher_decrypt);
 }
 
 static int cryptd_skcipher_enqueue(struct skcipher_request *req,
@@ -312,11 +312,14 @@ static int cryptd_skcipher_enqueue(struct skcipher_request *req,
 {
 	struct cryptd_skcipher_request_ctx *rctx = skcipher_request_ctx(req);
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct skcipher_request *subreq = &rctx->req;
 	struct cryptd_queue *queue;
 
 	queue = cryptd_get_queue(crypto_skcipher_tfm(tfm));
-	rctx->complete = req->base.complete;
+	subreq->base.complete = req->base.complete;
+	subreq->base.data = req->base.data;
 	req->base.complete = compl;
+	req->base.data = req;
 
 	return cryptd_enqueue_request(queue, &req->base);
 }
@@ -469,45 +472,63 @@ static int cryptd_hash_enqueue(struct ahash_request *req,
 		cryptd_get_queue(crypto_ahash_tfm(tfm));
 
 	rctx->complete = req->base.complete;
+	rctx->data = req->base.data;
 	req->base.complete = compl;
+	req->base.data = req;
 
 	return cryptd_enqueue_request(queue, &req->base);
 }
 
-static void cryptd_hash_complete(struct ahash_request *req, int err)
+static struct shash_desc *cryptd_hash_prepare(struct ahash_request *req,
+					      int err)
+{
+	struct cryptd_hash_request_ctx *rctx = ahash_request_ctx(req);
+
+	req->base.complete = rctx->complete;
+	req->base.data = rctx->data;
+
+	if (unlikely(err == -EINPROGRESS))
+		return NULL;
+
+	return &rctx->desc;
+}
+
+static void cryptd_hash_complete(struct ahash_request *req, int err,
+				 crypto_completion_t complete)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct cryptd_hash_ctx *ctx = crypto_ahash_ctx(tfm);
-	struct cryptd_hash_request_ctx *rctx = ahash_request_ctx(req);
 	int refcnt = refcount_read(&ctx->refcnt);
 
 	local_bh_disable();
-	rctx->complete(&req->base, err);
+	ahash_request_complete(req, err);
 	local_bh_enable();
 
-	if (err != -EINPROGRESS && refcnt && refcount_dec_and_test(&ctx->refcnt))
+	if (err == -EINPROGRESS) {
+		req->base.complete = complete;
+		req->base.data = req;
+	} else if (refcnt && refcount_dec_and_test(&ctx->refcnt))
 		crypto_free_ahash(tfm);
 }
 
 static void cryptd_hash_init(struct crypto_async_request *req_async, int err)
 {
-	struct cryptd_hash_ctx *ctx = crypto_tfm_ctx(req_async->tfm);
-	struct crypto_shash *child = ctx->child;
 	struct ahash_request *req = ahash_request_cast(req_async);
-	struct cryptd_hash_request_ctx *rctx = ahash_request_ctx(req);
-	struct shash_desc *desc = &rctx->desc;
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct cryptd_hash_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct crypto_shash *child = ctx->child;
+	struct shash_desc *desc;
 
-	if (unlikely(err == -EINPROGRESS))
+	desc = cryptd_hash_prepare(req, err);
+	if (unlikely(!desc))
 		goto out;
 
 	desc->tfm = child;
 
 	err = crypto_shash_init(desc);
 
-	req->base.complete = rctx->complete;
-
 out:
-	cryptd_hash_complete(req, err);
+	cryptd_hash_complete(req, err, cryptd_hash_init);
 }
 
 static int cryptd_hash_init_enqueue(struct ahash_request *req)
@@ -518,19 +539,13 @@ static int cryptd_hash_init_enqueue(struct ahash_request *req)
 static void cryptd_hash_update(struct crypto_async_request *req_async, int err)
 {
 	struct ahash_request *req = ahash_request_cast(req_async);
-	struct cryptd_hash_request_ctx *rctx;
-
-	rctx = ahash_request_ctx(req);
-
-	if (unlikely(err == -EINPROGRESS))
-		goto out;
-
-	err = shash_ahash_update(req, &rctx->desc);
+	struct shash_desc *desc;
 
-	req->base.complete = rctx->complete;
+	desc = cryptd_hash_prepare(req, err);
+	if (likely(desc))
+		err = shash_ahash_update(req, desc);
 
-out:
-	cryptd_hash_complete(req, err);
+	cryptd_hash_complete(req, err, cryptd_hash_update);
 }
 
 static int cryptd_hash_update_enqueue(struct ahash_request *req)
@@ -541,17 +556,13 @@ static int cryptd_hash_update_enqueue(struct ahash_request *req)
 static void cryptd_hash_final(struct crypto_async_request *req_async, int err)
 {
 	struct ahash_request *req = ahash_request_cast(req_async);
-	struct cryptd_hash_request_ctx *rctx = ahash_request_ctx(req);
-
-	if (unlikely(err == -EINPROGRESS))
-		goto out;
-
-	err = crypto_shash_final(&rctx->desc, req->result);
+	struct shash_desc *desc;
 
-	req->base.complete = rctx->complete;
+	desc = cryptd_hash_prepare(req, err);
+	if (likely(desc))
+		err = crypto_shash_final(desc, req->result);
 
-out:
-	cryptd_hash_complete(req, err);
+	cryptd_hash_complete(req, err, cryptd_hash_final);
 }
 
 static int cryptd_hash_final_enqueue(struct ahash_request *req)
@@ -562,17 +573,13 @@ static int cryptd_hash_final_enqueue(struct ahash_request *req)
 static void cryptd_hash_finup(struct crypto_async_request *req_async, int err)
 {
 	struct ahash_request *req = ahash_request_cast(req_async);
-	struct cryptd_hash_request_ctx *rctx = ahash_request_ctx(req);
+	struct shash_desc *desc;
 
-	if (unlikely(err == -EINPROGRESS))
-		goto out;
-
-	err = shash_ahash_finup(req, &rctx->desc);
+	desc = cryptd_hash_prepare(req, err);
+	if (likely(desc))
+		err = shash_ahash_finup(req, desc);
 
-	req->base.complete = rctx->complete;
-
-out:
-	cryptd_hash_complete(req, err);
+	cryptd_hash_complete(req, err, cryptd_hash_finup);
 }
 
 static int cryptd_hash_finup_enqueue(struct ahash_request *req)
@@ -582,23 +589,22 @@ static int cryptd_hash_finup_enqueue(struct ahash_request *req)
 
 static void cryptd_hash_digest(struct crypto_async_request *req_async, int err)
 {
-	struct cryptd_hash_ctx *ctx = crypto_tfm_ctx(req_async->tfm);
-	struct crypto_shash *child = ctx->child;
 	struct ahash_request *req = ahash_request_cast(req_async);
-	struct cryptd_hash_request_ctx *rctx = ahash_request_ctx(req);
-	struct shash_desc *desc = &rctx->desc;
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct cryptd_hash_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct crypto_shash *child = ctx->child;
+	struct shash_desc *desc;
 
-	if (unlikely(err == -EINPROGRESS))
+	desc = cryptd_hash_prepare(req, err);
+	if (unlikely(!desc))
 		goto out;
 
 	desc->tfm = child;
 
 	err = shash_ahash_digest(req, desc);
 
-	req->base.complete = rctx->complete;
-
 out:
-	cryptd_hash_complete(req, err);
+	cryptd_hash_complete(req, err, cryptd_hash_digest);
 }
 
 static int cryptd_hash_digest_enqueue(struct ahash_request *req)
@@ -711,20 +717,20 @@ static int cryptd_aead_setauthsize(struct crypto_aead *parent,
 }
 
 static void cryptd_aead_crypt(struct aead_request *req,
-			struct crypto_aead *child,
-			int err,
-			int (*crypt)(struct aead_request *req))
+			      struct crypto_aead *child, int err,
+			      int (*crypt)(struct aead_request *req),
+			      crypto_completion_t compl)
 {
 	struct cryptd_aead_request_ctx *rctx;
 	struct aead_request *subreq;
 	struct cryptd_aead_ctx *ctx;
-	crypto_completion_t compl;
 	struct crypto_aead *tfm;
 	int refcnt;
 
 	rctx = aead_request_ctx(req);
-	compl = rctx->complete;
 	subreq = &rctx->req;
+	req->base.complete = subreq->base.complete;
+	req->base.data = subreq->base.data;
 
 	tfm = crypto_aead_reqtfm(req);
 
@@ -740,17 +746,18 @@ static void cryptd_aead_crypt(struct aead_request *req,
 
 	err = crypt( req );
 
-	req->base.complete = compl;
-
 out:
 	ctx = crypto_aead_ctx(tfm);
 	refcnt = refcount_read(&ctx->refcnt);
 
 	local_bh_disable();
-	compl(&req->base, err);
+	aead_request_complete(req, err);
 	local_bh_enable();
 
-	if (err != -EINPROGRESS && refcnt && refcount_dec_and_test(&ctx->refcnt))
+	if (err == -EINPROGRESS) {
+		req->base.complete = compl;
+		req->base.data = req;
+	} else if (refcnt && refcount_dec_and_test(&ctx->refcnt))
 		crypto_free_aead(tfm);
 }
 
@@ -761,7 +768,8 @@ static void cryptd_aead_encrypt(struct crypto_async_request *areq, int err)
 	struct aead_request *req;
 
 	req = container_of(areq, struct aead_request, base);
-	cryptd_aead_crypt(req, child, err, crypto_aead_alg(child)->encrypt);
+	cryptd_aead_crypt(req, child, err, crypto_aead_alg(child)->encrypt,
+			  cryptd_aead_encrypt);
 }
 
 static void cryptd_aead_decrypt(struct crypto_async_request *areq, int err)
@@ -771,7 +779,8 @@ static void cryptd_aead_decrypt(struct crypto_async_request *areq, int err)
 	struct aead_request *req;
 
 	req = container_of(areq, struct aead_request, base);
-	cryptd_aead_crypt(req, child, err, crypto_aead_alg(child)->decrypt);
+	cryptd_aead_crypt(req, child, err, crypto_aead_alg(child)->decrypt,
+			  cryptd_aead_decrypt);
 }
 
 static int cryptd_aead_enqueue(struct aead_request *req,
@@ -780,9 +789,12 @@ static int cryptd_aead_enqueue(struct aead_request *req,
 	struct cryptd_aead_request_ctx *rctx = aead_request_ctx(req);
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct cryptd_queue *queue = cryptd_get_queue(crypto_aead_tfm(tfm));
+	struct aead_request *subreq = &rctx->req;
 
-	rctx->complete = req->base.complete;
+	subreq->base.complete = req->base.complete;
+	subreq->base.data = req->base.data;
 	req->base.complete = compl;
+	req->base.data = req;
 	return cryptd_enqueue_request(queue, &req->base);
 }
 

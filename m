Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05A877A559
	for <lists+linux-crypto@lfdr.de>; Sun, 13 Aug 2023 08:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjHMG4A (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 13 Aug 2023 02:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjHMGzT (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 13 Aug 2023 02:55:19 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C62B1998
        for <linux-crypto@vger.kernel.org>; Sat, 12 Aug 2023 23:55:21 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qV50O-002bwc-FO; Sun, 13 Aug 2023 14:55:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 13 Aug 2023 14:55:16 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Sun, 13 Aug 2023 14:55:16 +0800
Subject: [v2 PATCH 34/36] crypto: virtio - Use new crypto_engine_op interface
References: <ZNh94a7YYnvx0l8C@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Gaurav Jain <gaurav.jain@nxp.com>
Message-Id: <E1qV50O-002bwc-FO@formenos.hmeau.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Use the new crypto_engine_op interface where the callback is stored
in the algorithm object.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c |   33 +++++++++++---------
 drivers/crypto/virtio/virtio_crypto_skcipher_algs.c |   23 ++++++-------
 2 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index ff3369ca319f..2621ff8a9376 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -7,15 +7,16 @@
   * Copyright 2022 Bytedance CO., LTD.
   */
 
-#include <linux/mpi.h>
-#include <linux/scatterlist.h>
-#include <crypto/algapi.h>
+#include <crypto/engine.h>
 #include <crypto/internal/akcipher.h>
 #include <crypto/internal/rsa.h>
-#include <linux/err.h>
 #include <crypto/scatterwalk.h>
-#include <linux/atomic.h>
-
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/mpi.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 #include <uapi/linux/virtio_crypto.h>
 #include "virtio_crypto_common.h"
 
@@ -24,7 +25,6 @@ struct virtio_crypto_rsa_ctx {
 };
 
 struct virtio_crypto_akcipher_ctx {
-	struct crypto_engine_ctx enginectx;
 	struct virtio_crypto *vcrypto;
 	struct crypto_akcipher *tfm;
 	bool session_valid;
@@ -47,7 +47,7 @@ struct virtio_crypto_akcipher_algo {
 	uint32_t algonum;
 	uint32_t service;
 	unsigned int active_devs;
-	struct akcipher_alg algo;
+	struct akcipher_engine_alg algo;
 };
 
 static DEFINE_MUTEX(algs_lock);
@@ -475,7 +475,6 @@ static int virtio_crypto_rsa_init_tfm(struct crypto_akcipher *tfm)
 	struct virtio_crypto_akcipher_ctx *ctx = akcipher_tfm_ctx(tfm);
 
 	ctx->tfm = tfm;
-	ctx->enginectx.op.do_one_request = virtio_crypto_rsa_do_req;
 
 	akcipher_set_reqsize(tfm,
 			     sizeof(struct virtio_crypto_akcipher_request));
@@ -498,7 +497,7 @@ static struct virtio_crypto_akcipher_algo virtio_crypto_akcipher_algs[] = {
 	{
 		.algonum = VIRTIO_CRYPTO_AKCIPHER_RSA,
 		.service = VIRTIO_CRYPTO_SERVICE_AKCIPHER,
-		.algo = {
+		.algo.base = {
 			.encrypt = virtio_crypto_rsa_encrypt,
 			.decrypt = virtio_crypto_rsa_decrypt,
 			.set_pub_key = virtio_crypto_rsa_raw_set_pub_key,
@@ -514,11 +513,14 @@ static struct virtio_crypto_akcipher_algo virtio_crypto_akcipher_algs[] = {
 				.cra_ctxsize = sizeof(struct virtio_crypto_akcipher_ctx),
 			},
 		},
+		.algo.op = {
+			.do_one_request = virtio_crypto_rsa_do_req,
+		},
 	},
 	{
 		.algonum = VIRTIO_CRYPTO_AKCIPHER_RSA,
 		.service = VIRTIO_CRYPTO_SERVICE_AKCIPHER,
-		.algo = {
+		.algo.base = {
 			.encrypt = virtio_crypto_rsa_encrypt,
 			.decrypt = virtio_crypto_rsa_decrypt,
 			.sign = virtio_crypto_rsa_sign,
@@ -536,6 +538,9 @@ static struct virtio_crypto_akcipher_algo virtio_crypto_akcipher_algs[] = {
 				.cra_ctxsize = sizeof(struct virtio_crypto_akcipher_ctx),
 			},
 		},
+		.algo.op = {
+			.do_one_request = virtio_crypto_rsa_do_req,
+		},
 	},
 };
 
@@ -554,14 +559,14 @@ int virtio_crypto_akcipher_algs_register(struct virtio_crypto *vcrypto)
 			continue;
 
 		if (virtio_crypto_akcipher_algs[i].active_devs == 0) {
-			ret = crypto_register_akcipher(&virtio_crypto_akcipher_algs[i].algo);
+			ret = crypto_engine_register_akcipher(&virtio_crypto_akcipher_algs[i].algo);
 			if (ret)
 				goto unlock;
 		}
 
 		virtio_crypto_akcipher_algs[i].active_devs++;
 		dev_info(&vcrypto->vdev->dev, "Registered akcipher algo %s\n",
-			 virtio_crypto_akcipher_algs[i].algo.base.cra_name);
+			 virtio_crypto_akcipher_algs[i].algo.base.base.cra_name);
 	}
 
 unlock:
@@ -584,7 +589,7 @@ void virtio_crypto_akcipher_algs_unregister(struct virtio_crypto *vcrypto)
 			continue;
 
 		if (virtio_crypto_akcipher_algs[i].active_devs == 1)
-			crypto_unregister_akcipher(&virtio_crypto_akcipher_algs[i].algo);
+			crypto_engine_unregister_akcipher(&virtio_crypto_akcipher_algs[i].algo);
 
 		virtio_crypto_akcipher_algs[i].active_devs--;
 	}
diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
index 71b8751ab5ab..23c41d87d835 100644
--- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
@@ -6,19 +6,16 @@
   * Copyright 2016 HUAWEI TECHNOLOGIES CO., LTD.
   */
 
-#include <linux/scatterlist.h>
-#include <crypto/algapi.h>
+#include <crypto/engine.h>
 #include <crypto/internal/skcipher.h>
-#include <linux/err.h>
 #include <crypto/scatterwalk.h>
-#include <linux/atomic.h>
-
+#include <linux/err.h>
+#include <linux/scatterlist.h>
 #include <uapi/linux/virtio_crypto.h>
 #include "virtio_crypto_common.h"
 
 
 struct virtio_crypto_skcipher_ctx {
-	struct crypto_engine_ctx enginectx;
 	struct virtio_crypto *vcrypto;
 	struct crypto_skcipher *tfm;
 
@@ -42,7 +39,7 @@ struct virtio_crypto_algo {
 	uint32_t algonum;
 	uint32_t service;
 	unsigned int active_devs;
-	struct skcipher_alg algo;
+	struct skcipher_engine_alg algo;
 };
 
 /*
@@ -523,7 +520,6 @@ static int virtio_crypto_skcipher_init(struct crypto_skcipher *tfm)
 	crypto_skcipher_set_reqsize(tfm, sizeof(struct virtio_crypto_sym_request));
 	ctx->tfm = tfm;
 
-	ctx->enginectx.op.do_one_request = virtio_crypto_skcipher_crypt_req;
 	return 0;
 }
 
@@ -578,7 +574,7 @@ static void virtio_crypto_skcipher_finalize_req(
 static struct virtio_crypto_algo virtio_crypto_algs[] = { {
 	.algonum = VIRTIO_CRYPTO_CIPHER_AES_CBC,
 	.service = VIRTIO_CRYPTO_SERVICE_CIPHER,
-	.algo = {
+	.algo.base = {
 		.base.cra_name		= "cbc(aes)",
 		.base.cra_driver_name	= "virtio_crypto_aes_cbc",
 		.base.cra_priority	= 150,
@@ -596,6 +592,9 @@ static struct virtio_crypto_algo virtio_crypto_algs[] = { {
 		.max_keysize		= AES_MAX_KEY_SIZE,
 		.ivsize			= AES_BLOCK_SIZE,
 	},
+	.algo.op = {
+		.do_one_request = virtio_crypto_skcipher_crypt_req,
+	},
 } };
 
 int virtio_crypto_skcipher_algs_register(struct virtio_crypto *vcrypto)
@@ -614,14 +613,14 @@ int virtio_crypto_skcipher_algs_register(struct virtio_crypto *vcrypto)
 			continue;
 
 		if (virtio_crypto_algs[i].active_devs == 0) {
-			ret = crypto_register_skcipher(&virtio_crypto_algs[i].algo);
+			ret = crypto_engine_register_skcipher(&virtio_crypto_algs[i].algo);
 			if (ret)
 				goto unlock;
 		}
 
 		virtio_crypto_algs[i].active_devs++;
 		dev_info(&vcrypto->vdev->dev, "Registered algo %s\n",
-			 virtio_crypto_algs[i].algo.base.cra_name);
+			 virtio_crypto_algs[i].algo.base.base.cra_name);
 	}
 
 unlock:
@@ -645,7 +644,7 @@ void virtio_crypto_skcipher_algs_unregister(struct virtio_crypto *vcrypto)
 			continue;
 
 		if (virtio_crypto_algs[i].active_devs == 1)
-			crypto_unregister_skcipher(&virtio_crypto_algs[i].algo);
+			crypto_engine_unregister_skcipher(&virtio_crypto_algs[i].algo);
 
 		virtio_crypto_algs[i].active_devs--;
 	}

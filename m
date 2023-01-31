Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF3A68261A
	for <lists+linux-crypto@lfdr.de>; Tue, 31 Jan 2023 09:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjAaIDo (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 31 Jan 2023 03:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjAaIDE (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 31 Jan 2023 03:03:04 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A9D42BEB
        for <linux-crypto@vger.kernel.org>; Tue, 31 Jan 2023 00:02:49 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pMlbK-005vuQ-Mb; Tue, 31 Jan 2023 16:02:47 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 31 Jan 2023 16:02:46 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Tue, 31 Jan 2023 16:02:46 +0800
Subject: [PATCH 30/32] crypto: s5p-sss - Use request_complete helpers
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
Message-Id: <E1pMlbK-005vuQ-Mb@formenos.hmeau.com>
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

 drivers/crypto/s5p-sss.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
index b79e49aa724f..1c4d5fb05d69 100644
--- a/drivers/crypto/s5p-sss.c
+++ b/drivers/crypto/s5p-sss.c
@@ -499,7 +499,7 @@ static void s5p_sg_done(struct s5p_aes_dev *dev)
 /* Calls the completion. Cannot be called with dev->lock hold. */
 static void s5p_aes_complete(struct skcipher_request *req, int err)
 {
-	req->base.complete(&req->base, err);
+	skcipher_request_complete(req, err);
 }
 
 static void s5p_unset_outdata(struct s5p_aes_dev *dev)
@@ -1355,7 +1355,7 @@ static void s5p_hash_finish_req(struct ahash_request *req, int err)
 	spin_unlock_irqrestore(&dd->hash_lock, flags);
 
 	if (req->base.complete)
-		req->base.complete(&req->base, err);
+		ahash_request_complete(req, err);
 }
 
 /**
@@ -1397,7 +1397,7 @@ static int s5p_hash_handle_queue(struct s5p_aes_dev *dd,
 		return ret;
 
 	if (backlog)
-		backlog->complete(backlog, -EINPROGRESS);
+		crypto_request_complete(backlog, -EINPROGRESS);
 
 	req = ahash_request_cast(async_req);
 	dd->hash_req = req;
@@ -1991,7 +1991,7 @@ static void s5p_tasklet_cb(unsigned long data)
 	spin_unlock_irqrestore(&dev->lock, flags);
 
 	if (backlog)
-		backlog->complete(backlog, -EINPROGRESS);
+		crypto_request_complete(backlog, -EINPROGRESS);
 
 	dev->req = skcipher_request_cast(async_req);
 	dev->ctx = crypto_tfm_ctx(dev->req->base.tfm);

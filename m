Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC82917D49C
	for <lists+linux-crypto@lfdr.de>; Sun,  8 Mar 2020 16:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgCHP5i (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 8 Mar 2020 11:57:38 -0400
Received: from foss.arm.com ([217.140.110.172]:45776 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgCHP5g (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 8 Mar 2020 11:57:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10F5B1FB;
        Sun,  8 Mar 2020 08:57:35 -0700 (PDT)
Received: from e110176-lin.kfn.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD3733F6CF;
        Sun,  8 Mar 2020 08:57:33 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] crypto: ccree - use crypto_ipsec_check_assoclen()
Date:   Sun,  8 Mar 2020 17:57:08 +0200
Message-Id: <20200308155710.14546-6-gilad@benyossef.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200308155710.14546-1-gilad@benyossef.com>
References: <20200308155710.14546-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Use crypto_ipsec_check_assoclen() instead of home grown functions.
Clean up some unneeded code as a result. Delete stale comments
while we're at it.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/ccree/cc_aead.c | 73 ++++++++++------------------------
 1 file changed, 20 insertions(+), 53 deletions(-)

diff --git a/drivers/crypto/ccree/cc_aead.c b/drivers/crypto/ccree/cc_aead.c
index cce103e3b822..ede16e37d453 100644
--- a/drivers/crypto/ccree/cc_aead.c
+++ b/drivers/crypto/ccree/cc_aead.c
@@ -6,6 +6,8 @@
 #include <crypto/algapi.h>
 #include <crypto/internal/aead.h>
 #include <crypto/authenc.h>
+#include <crypto/gcm.h>
+#include <linux/rtnetlink.h>
 #include <crypto/internal/des.h>
 #include <linux/rtnetlink.h>
 #include "cc_driver.h"
@@ -60,11 +62,6 @@ struct cc_aead_ctx {
 	enum drv_hash_mode auth_mode;
 };
 
-static inline bool valid_assoclen(struct aead_request *req)
-{
-	return ((req->assoclen == 16) || (req->assoclen == 20));
-}
-
 static void cc_aead_exit(struct crypto_aead *tfm)
 {
 	struct cc_aead_ctx *ctx = crypto_aead_ctx(tfm);
@@ -2050,15 +2047,11 @@ static int cc_rfc4309_ccm_encrypt(struct aead_request *req)
 	/* Very similar to cc_aead_encrypt() above. */
 
 	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
-	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	struct cc_aead_ctx *ctx = crypto_aead_ctx(tfm);
-	struct device *dev = drvdata_to_dev(ctx->drvdata);
-	int rc = -EINVAL;
+	int rc;
 
-	if (!valid_assoclen(req)) {
-		dev_dbg(dev, "invalid Assoclen:%u\n", req->assoclen);
+	rc = crypto_ipsec_check_assoclen(req->assoclen);
+	if (rc)
 		goto out;
-	}
 
 	memset(areq_ctx, 0, sizeof(*areq_ctx));
 
@@ -2099,16 +2092,12 @@ static int cc_aead_decrypt(struct aead_request *req)
 
 static int cc_rfc4309_ccm_decrypt(struct aead_request *req)
 {
-	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	struct cc_aead_ctx *ctx = crypto_aead_ctx(tfm);
-	struct device *dev = drvdata_to_dev(ctx->drvdata);
 	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
-	int rc = -EINVAL;
+	int rc;
 
-	if (!valid_assoclen(req)) {
-		dev_dbg(dev, "invalid Assoclen:%u\n", req->assoclen);
+	rc = crypto_ipsec_check_assoclen(req->assoclen);
+	if (rc)
 		goto out;
-	}
 
 	memset(areq_ctx, 0, sizeof(*areq_ctx));
 
@@ -2216,18 +2205,12 @@ static int cc_rfc4543_gcm_setauthsize(struct crypto_aead *authenc,
 
 static int cc_rfc4106_gcm_encrypt(struct aead_request *req)
 {
-	/* Very similar to cc_aead_encrypt() above. */
-
-	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	struct cc_aead_ctx *ctx = crypto_aead_ctx(tfm);
-	struct device *dev = drvdata_to_dev(ctx->drvdata);
 	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
-	int rc = -EINVAL;
+	int rc;
 
-	if (!valid_assoclen(req)) {
-		dev_dbg(dev, "invalid Assoclen:%u\n", req->assoclen);
+	rc = crypto_ipsec_check_assoclen(req->assoclen);
+	if (rc)
 		goto out;
-	}
 
 	memset(areq_ctx, 0, sizeof(*areq_ctx));
 
@@ -2248,17 +2231,12 @@ static int cc_rfc4106_gcm_encrypt(struct aead_request *req)
 
 static int cc_rfc4543_gcm_encrypt(struct aead_request *req)
 {
-	/* Very similar to cc_aead_encrypt() above. */
-	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	struct cc_aead_ctx *ctx = crypto_aead_ctx(tfm);
-	struct device *dev = drvdata_to_dev(ctx->drvdata);
 	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
-	int rc = -EINVAL;
+	int rc;
 
-	if (!valid_assoclen(req)) {
-		dev_dbg(dev, "invalid Assoclen:%u\n", req->assoclen);
+	rc = crypto_ipsec_check_assoclen(req->assoclen);
+	if (rc)
 		goto out;
-	}
 
 	memset(areq_ctx, 0, sizeof(*areq_ctx));
 
@@ -2281,18 +2259,12 @@ static int cc_rfc4543_gcm_encrypt(struct aead_request *req)
 
 static int cc_rfc4106_gcm_decrypt(struct aead_request *req)
 {
-	/* Very similar to cc_aead_decrypt() above. */
-
-	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	struct cc_aead_ctx *ctx = crypto_aead_ctx(tfm);
-	struct device *dev = drvdata_to_dev(ctx->drvdata);
 	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
-	int rc = -EINVAL;
+	int rc;
 
-	if (!valid_assoclen(req)) {
-		dev_dbg(dev, "invalid Assoclen:%u\n", req->assoclen);
+	rc = crypto_ipsec_check_assoclen(req->assoclen);
+	if (rc)
 		goto out;
-	}
 
 	memset(areq_ctx, 0, sizeof(*areq_ctx));
 
@@ -2313,17 +2285,12 @@ static int cc_rfc4106_gcm_decrypt(struct aead_request *req)
 
 static int cc_rfc4543_gcm_decrypt(struct aead_request *req)
 {
-	/* Very similar to cc_aead_decrypt() above. */
-	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	struct cc_aead_ctx *ctx = crypto_aead_ctx(tfm);
-	struct device *dev = drvdata_to_dev(ctx->drvdata);
 	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
-	int rc = -EINVAL;
+	int rc;
 
-	if (!valid_assoclen(req)) {
-		dev_dbg(dev, "invalid Assoclen:%u\n", req->assoclen);
+	rc = crypto_ipsec_check_assoclen(req->assoclen);
+	if (rc)
 		goto out;
-	}
 
 	memset(areq_ctx, 0, sizeof(*areq_ctx));
 
-- 
2.25.1


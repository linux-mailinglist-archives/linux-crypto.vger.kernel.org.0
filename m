Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 996856D773
	for <lists+linux-crypto@lfdr.de>; Fri, 19 Jul 2019 01:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfGRX6j (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 18 Jul 2019 19:58:39 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54614 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfGRX6U (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 18 Jul 2019 19:58:20 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4CFAF1A0364;
        Fri, 19 Jul 2019 01:58:17 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3EED31A0135;
        Fri, 19 Jul 2019 01:58:17 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id E0FB6205D1;
        Fri, 19 Jul 2019 01:58:16 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: [PATCH v2 13/14] crypto: caam - unregister algorithm only if the registration succeeded
Date:   Fri, 19 Jul 2019 02:57:55 +0300
Message-Id: <1563494276-3993-14-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1563494276-3993-1-git-send-email-iuliana.prodan@nxp.com>
References: <1563494276-3993-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

To know if a registration succeeded added a new struct,
caam_akcipher_alg, that keeps, also, the registration status.
This status is updated in caam_pkc_init and verified in
caam_pkc_exit to unregister an algorithm.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 drivers/crypto/caam/caampkc.c | 49 ++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index cfdf7a2..a669688 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -35,6 +35,11 @@ static u8 *zero_buffer;
  */
 static bool init_done;
 
+struct caam_akcipher_alg {
+	struct akcipher_alg akcipher;
+	bool registered;
+};
+
 static void rsa_io_unmap(struct device *dev, struct rsa_edesc *edesc,
 			 struct akcipher_request *req)
 {
@@ -1063,22 +1068,24 @@ static void caam_rsa_exit_tfm(struct crypto_akcipher *tfm)
 	caam_jr_free(ctx->dev);
 }
 
-static struct akcipher_alg caam_rsa = {
-	.encrypt = caam_rsa_enc,
-	.decrypt = caam_rsa_dec,
-	.set_pub_key = caam_rsa_set_pub_key,
-	.set_priv_key = caam_rsa_set_priv_key,
-	.max_size = caam_rsa_max_size,
-	.init = caam_rsa_init_tfm,
-	.exit = caam_rsa_exit_tfm,
-	.reqsize = sizeof(struct caam_rsa_req_ctx),
-	.base = {
-		.cra_name = "rsa",
-		.cra_driver_name = "rsa-caam",
-		.cra_priority = 3000,
-		.cra_module = THIS_MODULE,
-		.cra_ctxsize = sizeof(struct caam_rsa_ctx),
-	},
+static struct caam_akcipher_alg caam_rsa = {
+	.akcipher = {
+		.encrypt = caam_rsa_enc,
+		.decrypt = caam_rsa_dec,
+		.set_pub_key = caam_rsa_set_pub_key,
+		.set_priv_key = caam_rsa_set_priv_key,
+		.max_size = caam_rsa_max_size,
+		.init = caam_rsa_init_tfm,
+		.exit = caam_rsa_exit_tfm,
+		.reqsize = sizeof(struct caam_rsa_req_ctx),
+		.base = {
+			.cra_name = "rsa",
+			.cra_driver_name = "rsa-caam",
+			.cra_priority = 3000,
+			.cra_module = THIS_MODULE,
+			.cra_ctxsize = sizeof(struct caam_rsa_ctx),
+		},
+	}
 };
 
 /* Public Key Cryptography module initialization handler */
@@ -1106,13 +1113,15 @@ int caam_pkc_init(struct device *ctrldev)
 	if (!zero_buffer)
 		return -ENOMEM;
 
-	err = crypto_register_akcipher(&caam_rsa);
+	err = crypto_register_akcipher(&caam_rsa.akcipher);
+
 	if (err) {
 		kfree(zero_buffer);
 		dev_warn(ctrldev, "%s alg registration failed\n",
-			 caam_rsa.base.cra_driver_name);
+			 caam_rsa.akcipher.base.cra_driver_name);
 	} else {
 		init_done = true;
+		caam_rsa.registered = true;
 		dev_info(ctrldev, "caam pkc algorithms registered in /proc/crypto\n");
 	}
 
@@ -1124,6 +1133,8 @@ void caam_pkc_exit(void)
 	if (!init_done)
 		return;
 
+	if (caam_rsa.registered)
+		crypto_unregister_akcipher(&caam_rsa.akcipher);
+
 	kfree(zero_buffer);
-	crypto_unregister_akcipher(&caam_rsa);
 }
-- 
2.1.0


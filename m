Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D09437A69A
	for <lists+linux-crypto@lfdr.de>; Tue, 30 Jul 2019 13:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfG3LHf (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 30 Jul 2019 07:07:35 -0400
Received: from inva021.nxp.com ([92.121.34.21]:55662 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730310AbfG3LGz (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 30 Jul 2019 07:06:55 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1EE9F20066A;
        Tue, 30 Jul 2019 13:06:54 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1282B20065E;
        Tue, 30 Jul 2019 13:06:54 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 98221204D6;
        Tue, 30 Jul 2019 13:06:53 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: [PATCH v4 11/14] crypto: caam - free resources in case caam_rng registration failed
Date:   Tue, 30 Jul 2019 14:06:42 +0300
Message-Id: <1564484805-28735-12-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1564484805-28735-1-git-send-email-iuliana.prodan@nxp.com>
References: <1564484805-28735-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Check the return value of the hardware registration for caam_rng and free
resources in case of failure.

Fixes: e24f7c9e87d4 ("crypto: caam - hwrng support")
Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
---
Changes since v3:
- update Fixes tag with 12 characters of the SHA1.
---
 drivers/crypto/caam/caamrng.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/caamrng.c b/drivers/crypto/caam/caamrng.c
index 561bcb5..54c32d5 100644
--- a/drivers/crypto/caam/caamrng.c
+++ b/drivers/crypto/caam/caamrng.c
@@ -333,7 +333,10 @@ int caam_rng_init(struct device *ctrldev)
 		goto free_rng_ctx;
 
 	dev_info(dev, "registering rng-caam\n");
-	return hwrng_register(&caam_rng);
+
+	err = hwrng_register(&caam_rng);
+	if (!err)
+		return err;
 
 free_rng_ctx:
 	kfree(rng_ctx);
-- 
2.1.0


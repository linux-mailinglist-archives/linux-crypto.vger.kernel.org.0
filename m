Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6B5758EAB
	for <lists+linux-crypto@lfdr.de>; Wed, 19 Jul 2023 09:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjGSHUQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 19 Jul 2023 03:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGSHUO (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 19 Jul 2023 03:20:14 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BC9E43;
        Wed, 19 Jul 2023 00:20:13 -0700 (PDT)
Received: from ipservice-092-217-093-053.092.217.pools.vodafone-ip.de ([92.217.93.53] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qM1Tn-0008I7-ES; Wed, 19 Jul 2023 09:20:12 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/4] hwrng: cctrng - merge cc_trng_clk_init into its only caller
Date:   Wed, 19 Jul 2023 09:18:05 +0200
Message-Id: <20230719071806.335718-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230719071806.335718-1-martin@kaiser.cx>
References: <20230719071806.335718-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

cc_trng_clk_init is called only from the probe function. Merge the two
functions, this saves some lines of code.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/cctrng.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/char/hw_random/cctrng.c b/drivers/char/hw_random/cctrng.c
index ac4a2fbc6a0f..2a1887f6483f 100644
--- a/drivers/char/hw_random/cctrng.c
+++ b/drivers/char/hw_random/cctrng.c
@@ -455,21 +455,6 @@ static void cc_trng_startwork_handler(struct work_struct *w)
 	cc_trng_hw_trigger(drvdata);
 }
 
-
-static int cc_trng_clk_init(struct cctrng_drvdata *drvdata)
-{
-	struct clk *clk;
-	struct device *dev = &(drvdata->pdev->dev);
-
-	clk = devm_clk_get_optional_enabled(dev, NULL);
-	if (IS_ERR(clk))
-		return dev_err_probe(dev, PTR_ERR(clk),
-				     "Failed to get or enable the clock\n");
-
-	drvdata->clk = clk;
-	return 0;
-}
-
 static int cctrng_probe(struct platform_device *pdev)
 {
 	struct cctrng_drvdata *drvdata;
@@ -517,11 +502,10 @@ static int cctrng_probe(struct platform_device *pdev)
 		return rc;
 	}
 
-	rc = cc_trng_clk_init(drvdata);
-	if (rc) {
-		dev_err(dev, "cc_trng_clk_init failed\n");
-		return rc;
-	}
+	drvdata->clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(drvdata->clk))
+		return dev_err_probe(dev, PTR_ERR(drvdata->clk),
+				     "Failed to get or enable the clock\n");
 
 	INIT_WORK(&drvdata->compwork, cc_trng_compwork_handler);
 	INIT_WORK(&drvdata->startwork, cc_trng_startwork_handler);
-- 
2.30.2


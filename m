Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C675514B3A7
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Jan 2020 12:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgA1LnM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 28 Jan 2020 06:43:12 -0500
Received: from viti.kaiser.cx ([85.214.81.225]:38960 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgA1LnM (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 28 Jan 2020 06:43:12 -0500
Received: from dslb-088-068-095-017.088.068.pools.vodafone-ip.de ([88.68.95.17] helo=martin-debian-1.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1iwOch-0008Dy-DF; Tue, 28 Jan 2020 12:01:35 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/6] hwrng: imx-rngc - use devres for registration
Date:   Tue, 28 Jan 2020 12:00:59 +0100
Message-Id: <20200128110102.11522-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200128110102.11522-1-martin@kaiser.cx>
References: <20200128110102.11522-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Use devres to register the rngc with the hwrng core. Drop the explicit
deregistration.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/imx-rngc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index 903894518c8d..1381ddd5b891 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -263,7 +263,7 @@ static int imx_rngc_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = hwrng_register(&rngc->rng);
+	ret = devm_hwrng_register(&pdev->dev, &rngc->rng);
 	if (ret) {
 		dev_err(&pdev->dev, "FSL RNGC registering failed (%d)\n", ret);
 		goto err;
@@ -282,8 +282,6 @@ static int __exit imx_rngc_remove(struct platform_device *pdev)
 {
 	struct imx_rngc *rngc = platform_get_drvdata(pdev);
 
-	hwrng_unregister(&rngc->rng);
-
 	clk_disable_unprepare(rngc->clk);
 
 	return 0;
-- 
2.20.1


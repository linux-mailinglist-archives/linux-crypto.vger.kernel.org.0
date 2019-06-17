Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBEFA47D77
	for <lists+linux-crypto@lfdr.de>; Mon, 17 Jun 2019 10:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfFQIql (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 17 Jun 2019 04:46:41 -0400
Received: from foss.arm.com ([217.140.110.172]:41806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfFQIqk (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 17 Jun 2019 04:46:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4BC5360;
        Mon, 17 Jun 2019 01:46:39 -0700 (PDT)
Received: from e110176-lin.kfn.arm.com (unknown [10.50.4.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F96C3F246;
        Mon, 17 Jun 2019 01:46:38 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] crypto: ccree: Relocate driver irq registration after clk init
Date:   Mon, 17 Jun 2019 11:46:27 +0300
Message-Id: <20190617084631.23551-2-gilad@benyossef.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190617084631.23551-1-gilad@benyossef.com>
References: <20190617084631.23551-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Ofir Drang <ofir.drang@arm.com>

      Relocate driver interrupt registration after clk gate enabling.

Signed-off-by: Ofir Drang <ofir.drang@arm.com>
---
 drivers/crypto/ccree/cc_driver.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/ccree/cc_driver.c b/drivers/crypto/ccree/cc_driver.c
index 86ac7b443355..0f80cb4f79fb 100644
--- a/drivers/crypto/ccree/cc_driver.c
+++ b/drivers/crypto/ccree/cc_driver.c
@@ -315,15 +315,6 @@ static int init_cc_resources(struct platform_device *plat_dev)
 		return new_drvdata->irq;
 	}
 
-	rc = devm_request_irq(dev, new_drvdata->irq, cc_isr,
-			      IRQF_SHARED, "ccree", new_drvdata);
-	if (rc) {
-		dev_err(dev, "Could not register to interrupt %d\n",
-			new_drvdata->irq);
-		return rc;
-	}
-	dev_dbg(dev, "Registered to IRQ: %d\n", new_drvdata->irq);
-
 	init_completion(&new_drvdata->hw_queue_avail);
 
 	if (!plat_dev->dev.dma_mask)
@@ -401,6 +392,15 @@ static int init_cc_resources(struct platform_device *plat_dev)
 	/* Display HW versions */
 	dev_info(dev, "ARM CryptoCell %s Driver: HW version 0x%08X/0x%8X, Driver version %s\n",
 		 hw_rev->name, hw_rev_pidr, sig_cidr, DRV_MODULE_VERSION);
+	/* register the driver isr function */
+	rc = devm_request_irq(dev, new_drvdata->irq, cc_isr,
+			      IRQF_SHARED, "ccree", new_drvdata);
+	if (rc) {
+		dev_err(dev, "Could not register to interrupt %d\n",
+			new_drvdata->irq);
+		return rc;
+	}
+	dev_dbg(dev, "Registered to IRQ: %d\n", new_drvdata->irq);
 
 	rc = init_cc_regs(new_drvdata, true);
 	if (rc) {
-- 
2.21.0


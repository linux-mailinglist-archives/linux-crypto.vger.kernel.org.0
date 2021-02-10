Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748C9315C0E
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Feb 2021 02:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbhBJBSQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 9 Feb 2021 20:18:16 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12160 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbhBJBQM (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 9 Feb 2021 20:16:12 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Db1x04nN0zlJCC;
        Wed, 10 Feb 2021 09:13:40 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Wed, 10 Feb 2021 09:15:23 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <f.fainelli@gmail.com>, <sbranden@broadcom.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <nsaenzjulienne@suse.de>
CC:     <linux-crypto@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] hwrng: bcm2835 - remove redundant null check
Date:   Wed, 10 Feb 2021 09:14:58 +0800
Message-ID: <1612919698-60261-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

clk_prepare_enable() and clk_disable_unprepare() will check
NULL clock parameter, so It is not necessary to add additional checks.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
v2:
change devm_clk_get() to devm_clk_get_optional() which will deal with
-ENOENT and return NULL in that case.
---
 drivers/char/hw_random/bcm2835-rng.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/char/hw_random/bcm2835-rng.c b/drivers/char/hw_random/bcm2835-rng.c
index 1a7c43b..be5be39 100644
--- a/drivers/char/hw_random/bcm2835-rng.c
+++ b/drivers/char/hw_random/bcm2835-rng.c
@@ -88,11 +88,9 @@ static int bcm2835_rng_init(struct hwrng *rng)
 	int ret = 0;
 	u32 val;
 
-	if (!IS_ERR(priv->clk)) {
-		ret = clk_prepare_enable(priv->clk);
-		if (ret)
-			return ret;
-	}
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
 
 	if (priv->mask_interrupts) {
 		/* mask the interrupt */
@@ -115,8 +113,7 @@ static void bcm2835_rng_cleanup(struct hwrng *rng)
 	/* disable rng hardware */
 	rng_writel(priv, 0, RNG_CTRL);
 
-	if (!IS_ERR(priv->clk))
-		clk_disable_unprepare(priv->clk);
+	clk_disable_unprepare(priv->clk);
 }
 
 struct bcm2835_rng_of_data {
@@ -155,9 +152,9 @@ static int bcm2835_rng_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->base);
 
 	/* Clock is optional on most platforms */
-	priv->clk = devm_clk_get(dev, NULL);
-	if (PTR_ERR(priv->clk) == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
+	priv->clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
 
 	priv->rng.name = pdev->name;
 	priv->rng.init = bcm2835_rng_init;
-- 
2.7.4


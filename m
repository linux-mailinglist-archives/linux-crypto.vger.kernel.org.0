Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF00343A00
	for <lists+linux-crypto@lfdr.de>; Mon, 22 Mar 2021 07:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhCVGvt (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 22 Mar 2021 02:51:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14052 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhCVGvT (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 22 Mar 2021 02:51:19 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F3lTD1FT1zNpsw
        for <linux-crypto@vger.kernel.org>; Mon, 22 Mar 2021 14:48:48 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Mon, 22 Mar 2021 14:51:15 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>
Subject: [PATCH] hwrng: omap - Use of_device_get_match_data() helper
Date:   Mon, 22 Mar 2021 14:51:51 +0800
Message-ID: <1616395911-36618-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Use the of_device_get_match_data() helper instead of open coding.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/char/hw_random/omap-rng.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
index 4380c23..cede9f1 100644
--- a/drivers/char/hw_random/omap-rng.c
+++ b/drivers/char/hw_random/omap-rng.c
@@ -377,16 +377,13 @@ MODULE_DEVICE_TABLE(of, omap_rng_of_match);
 static int of_get_omap_rng_device_details(struct omap_rng_dev *priv,
 					  struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
 	int irq, err;
 
-	match = of_match_device(of_match_ptr(omap_rng_of_match), dev);
-	if (!match) {
-		dev_err(dev, "no compatible OF match\n");
-		return -EINVAL;
-	}
-	priv->pdata = match->data;
+	priv->pdata = of_device_get_match_data(dev);
+	if (!priv->pdata)
+		return -ENODEV;
+
 
 	if (of_device_is_compatible(dev->of_node, "ti,omap4-rng") ||
 	    of_device_is_compatible(dev->of_node, "inside-secure,safexcel-eip76")) {
-- 
2.7.4


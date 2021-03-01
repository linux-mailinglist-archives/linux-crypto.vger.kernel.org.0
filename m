Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E40327669
	for <lists+linux-crypto@lfdr.de>; Mon,  1 Mar 2021 04:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhCADYx (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 28 Feb 2021 22:24:53 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13025 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhCADYt (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 28 Feb 2021 22:24:49 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DpltK36nVzMgKZ;
        Mon,  1 Mar 2021 11:22:01 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Mon, 1 Mar 2021 11:24:02 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <mpm@selenic.com>, <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>
Subject: [PATCH] hwrng: pic32 - Use device-managed registration API
Date:   Mon, 1 Mar 2021 11:24:53 +0800
Message-ID: <1614569093-31192-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Use devm_hwrng_register to get rid of manual unregistration.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/char/hw_random/pic32-rng.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/pic32-rng.c b/drivers/char/hw_random/pic32-rng.c
index e8210c1..99c8bd0 100644
--- a/drivers/char/hw_random/pic32-rng.c
+++ b/drivers/char/hw_random/pic32-rng.c
@@ -96,7 +96,7 @@ static int pic32_rng_probe(struct platform_device *pdev)
 	priv->rng.name = pdev->name;
 	priv->rng.read = pic32_rng_read;
 
-	ret = hwrng_register(&priv->rng);
+	ret = devm_hwrng_register(&pdev->dev, &priv->rng);
 	if (ret)
 		goto err_register;
 
@@ -113,7 +113,6 @@ static int pic32_rng_remove(struct platform_device *pdev)
 {
 	struct pic32_rng *rng = platform_get_drvdata(pdev);
 
-	hwrng_unregister(&rng->rng);
 	writel(0, rng->base + RNGCON);
 	clk_disable_unprepare(rng->clk);
 	return 0;
-- 
2.7.4


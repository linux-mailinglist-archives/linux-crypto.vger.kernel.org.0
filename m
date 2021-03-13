Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7949F339AF0
	for <lists+linux-crypto@lfdr.de>; Sat, 13 Mar 2021 02:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhCMBre (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 12 Mar 2021 20:47:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13597 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhCMBrF (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 12 Mar 2021 20:47:05 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dy5915hP2z17KNq;
        Sat, 13 Mar 2021 09:45:09 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Sat, 13 Mar 2021 09:46:55 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <mpm@selenic.com>, <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>
Subject: [PATCH] hwrng: ba431 - use devm_platform_ioremap_resource() to simplify
Date:   Sat, 13 Mar 2021 09:47:38 +0800
Message-ID: <1615600058-35478-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify the code.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/char/hw_random/ba431-rng.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/ba431-rng.c b/drivers/char/hw_random/ba431-rng.c
index 4f514e2..5b7ca04 100644
--- a/drivers/char/hw_random/ba431-rng.c
+++ b/drivers/char/hw_random/ba431-rng.c
@@ -170,7 +170,6 @@ static int ba431_trng_init(struct hwrng *rng)
 static int ba431_trng_probe(struct platform_device *pdev)
 {
 	struct ba431_trng *ba431;
-	struct resource *res;
 	int ret;
 
 	ba431 = devm_kzalloc(&pdev->dev, sizeof(*ba431), GFP_KERNEL);
@@ -179,8 +178,7 @@ static int ba431_trng_probe(struct platform_device *pdev)
 
 	ba431->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ba431->base = devm_ioremap_resource(&pdev->dev, res);
+	ba431->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ba431->base))
 		return PTR_ERR(ba431->base);
 
-- 
2.7.4


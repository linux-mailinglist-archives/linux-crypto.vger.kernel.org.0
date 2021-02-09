Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010313149EE
	for <lists+linux-crypto@lfdr.de>; Tue,  9 Feb 2021 09:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhBIIEz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 9 Feb 2021 03:04:55 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11718 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhBIIEz (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 9 Feb 2021 03:04:55 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DZb3073sfzlHTL;
        Tue,  9 Feb 2021 16:02:20 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Tue, 9 Feb 2021 16:04:03 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <mpm@selenic.com>, <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>
Subject: [PATCH] hwrng: xiphera-trng: use devm_platform_ioremap_resource() to simplify
Date:   Tue, 9 Feb 2021 16:03:37 +0800
Message-ID: <1612857817-33858-1-git-send-email-tiantao6@hisilicon.com>
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
 drivers/char/hw_random/xiphera-trng.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/xiphera-trng.c b/drivers/char/hw_random/xiphera-trng.c
index 7bdab8c..2a9fea7 100644
--- a/drivers/char/hw_random/xiphera-trng.c
+++ b/drivers/char/hw_random/xiphera-trng.c
@@ -63,14 +63,12 @@ static int xiphera_trng_probe(struct platform_device *pdev)
 	int ret;
 	struct xiphera_trng *trng;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 
 	trng = devm_kzalloc(dev, sizeof(*trng), GFP_KERNEL);
 	if (!trng)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	trng->mem = devm_ioremap_resource(dev, res);
+	trng->mem = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(trng->mem))
 		return PTR_ERR(trng->mem);
 
-- 
2.7.4


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7EB38E66B
	for <lists+linux-crypto@lfdr.de>; Mon, 24 May 2021 14:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhEXMRm (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 24 May 2021 08:17:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3928 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbhEXMRl (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 24 May 2021 08:17:41 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fpbhc3SLGzBvpQ;
        Mon, 24 May 2021 20:13:20 +0800 (CST)
Received: from dggeme759-chm.china.huawei.com (10.3.19.105) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 20:16:11 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggeme759-chm.china.huawei.com (10.3.19.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 24 May 2021 20:16:10 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <dsaxena@plexity.net>, <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH] hwrng: omap - Use pm_runtime_resume_and_get() to replace open coding
Date:   Mon, 24 May 2021 20:16:05 +0800
Message-ID: <1621858565-36172-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme759-chm.china.huawei.com (10.3.19.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

use pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. this change is just to simplify the code, no
actual functional changes.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/char/hw_random/omap-rng.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
index cede9f1..5794635 100644
--- a/drivers/char/hw_random/omap-rng.c
+++ b/drivers/char/hw_random/omap-rng.c
@@ -454,10 +454,9 @@ static int omap_rng_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_enable(&pdev->dev);
-	ret = pm_runtime_get_sync(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to runtime_get device: %d\n", ret);
-		pm_runtime_put_noidle(&pdev->dev);
 		goto err_ioremap;
 	}
 
-- 
2.7.4


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED9D34367A
	for <lists+linux-crypto@lfdr.de>; Mon, 22 Mar 2021 03:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhCVCDP (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 21 Mar 2021 22:03:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14117 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhCVCDM (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 21 Mar 2021 22:03:12 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F3d5P2QbWz19GY9
        for <linux-crypto@vger.kernel.org>; Mon, 22 Mar 2021 10:01:13 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Mon, 22 Mar 2021 10:02:48 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>
Subject: [PATCH] hwrng: cctrng - remove the redundant log
Date:   Mon, 22 Mar 2021 10:03:24 +0800
Message-ID: <1616378604-35134-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Fix the following coccicheck warning:
drivers/char/hw_random//cctrng.c:531:2-9: line 531 is redundant because
platform_get_irq() already prints an error.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/char/hw_random/cctrng.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/cctrng.c b/drivers/char/hw_random/cctrng.c
index 0efb37a..ae0621f 100644
--- a/drivers/char/hw_random/cctrng.c
+++ b/drivers/char/hw_random/cctrng.c
@@ -527,10 +527,8 @@ static int cctrng_probe(struct platform_device *pdev)
 
 	/* Then IRQ */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "Failed getting IRQ resource\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	/* parse sampling rate from device tree */
 	rc = cc_trng_parse_sampling_ratio(drvdata);
-- 
2.7.4


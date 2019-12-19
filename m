Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6E6125A1B
	for <lists+linux-crypto@lfdr.de>; Thu, 19 Dec 2019 04:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfLSDwX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 18 Dec 2019 22:52:23 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7716 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726777AbfLSDwW (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 18 Dec 2019 22:52:22 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 815FF1152FD0BD0C9E16;
        Thu, 19 Dec 2019 11:52:20 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Thu, 19 Dec 2019 11:52:10 +0800
From:   Ma Feng <mafeng.ma@huawei.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ma Feng <mafeng.ma@huawei.com>
Subject: [PATCH] crypto: allwinner - Remove unneeded semicolon
Date:   Thu, 19 Dec 2019 11:53:05 +0800
Message-ID: <1576727585-113063-1-git-send-email-mafeng.ma@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Fixes coccicheck warning:

drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c:558:52-53: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index 73a7649..5373950 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -555,7 +555,7 @@ static int sun8i_ce_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}

-	ce->base = devm_platform_ioremap_resource(pdev, 0);;
+	ce->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ce->base))
 		return PTR_ERR(ce->base);

--
2.6.2


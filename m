Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 125A4A7923
	for <lists+linux-crypto@lfdr.de>; Wed,  4 Sep 2019 05:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfIDDEX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 3 Sep 2019 23:04:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5749 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727692AbfIDDEX (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 3 Sep 2019 23:04:23 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 86B82D3A8C19B60C797D;
        Wed,  4 Sep 2019 11:04:21 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Wed, 4 Sep 2019 11:04:14 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
        <arno@natisbad.org>, <joro@8bytes.org>,
        <gregkh@linuxfoundation.org>
CC:     <zhongjiang@huawei.com>, <iommu@lists.linux-foundation.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] iommu/pamu: Use kzfree rather than its implementation
Date:   Wed, 4 Sep 2019 11:01:18 +0800
Message-ID: <1567566079-7412-3-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1567566079-7412-1-git-send-email-zhongjiang@huawei.com>
References: <1567566079-7412-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Use kzfree instead of memset() + kfree().

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/iommu/fsl_pamu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index cde281b..ca6d147 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -1174,10 +1174,8 @@ static int fsl_pamu_probe(struct platform_device *pdev)
 	if (irq != NO_IRQ)
 		free_irq(irq, data);
 
-	if (data) {
-		memset(data, 0, sizeof(struct pamu_isr_data));
-		kfree(data);
-	}
+	if (data)
+		kzfree(data);
 
 	if (pamu_regs)
 		iounmap(pamu_regs);
-- 
1.7.12.4


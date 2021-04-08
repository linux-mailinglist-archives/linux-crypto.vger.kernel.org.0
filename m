Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B206358089
	for <lists+linux-crypto@lfdr.de>; Thu,  8 Apr 2021 12:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhDHK0u (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 8 Apr 2021 06:26:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15184 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhDHK0s (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 8 Apr 2021 06:26:48 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGHRS6r8QzpWLN;
        Thu,  8 Apr 2021 18:23:48 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 18:26:25 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yekai13@huawei.com>
Subject: [PATCH 2/2] crypto: hisilicon/sec_drv - use the correct print format
Date:   Thu, 8 Apr 2021 18:23:51 +0800
Message-ID: <1617877431-38290-3-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617877431-38290-1-git-send-email-yekai13@huawei.com>
References: <1617877431-38290-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

According to Documentation/core-api/printk-formats.rst, Use
the correct print format. Printing an unsigned int value should use %u
instead of %d.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/sec/sec_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec/sec_drv.c b/drivers/crypto/hisilicon/sec/sec_drv.c
index 91ee2bb..819bbb5 100644
--- a/drivers/crypto/hisilicon/sec/sec_drv.c
+++ b/drivers/crypto/hisilicon/sec/sec_drv.c
@@ -233,7 +233,7 @@ static int sec_queue_map_io(struct sec_queue *queue)
 				    IORESOURCE_MEM,
 				    2 + queue->queue_id);
 	if (!res) {
-		dev_err(dev, "Failed to get queue %d memory resource\n",
+		dev_err(dev, "Failed to get queue %u memory resource\n",
 			queue->queue_id);
 		return -ENOMEM;
 	}
@@ -653,12 +653,12 @@ static int sec_queue_free(struct sec_queue *queue)
 	struct sec_dev_info *info = queue->dev_info;
 
 	if (queue->queue_id >= SEC_Q_NUM) {
-		dev_err(info->dev, "No queue %d\n", queue->queue_id);
+		dev_err(info->dev, "No queue %u\n", queue->queue_id);
 		return -ENODEV;
 	}
 
 	if (!queue->in_use) {
-		dev_err(info->dev, "Queue %d is idle\n", queue->queue_id);
+		dev_err(info->dev, "Queue %u is idle\n", queue->queue_id);
 		return -ENODEV;
 	}
 
-- 
2.8.1


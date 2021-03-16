Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104F933D3EA
	for <lists+linux-crypto@lfdr.de>; Tue, 16 Mar 2021 13:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhCPMe0 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 16 Mar 2021 08:34:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13965 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbhCPMdt (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 16 Mar 2021 08:33:49 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F0CMt5nd6zrTtX
        for <linux-crypto@vger.kernel.org>; Tue, 16 Mar 2021 20:31:54 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 16 Mar 2021 20:33:36 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <herbert@gondor.apana.org.au>, <linux-crypto@vger.kernel.org>
CC:     <tangzihao1@hisilicon.com>, <huangdaode@huawei.com>
Subject: [PATCH] hwrng: core - convert sysfs sprintf/snprintf family to sysfs_emit
Date:   Tue, 16 Mar 2021 20:34:12 +0800
Message-ID: <1615898052-31279-1-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Zihao Tang <tangzihao1@hisilicon.com>

Fix the following coccicheck warning:

drivers/char/hw_random/core.c:399:8-16: WARNING: use scnprintf or sprintf.

Signed-off-by: Zihao Tang <tangzihao1@hisilicon.com>
Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/char/hw_random/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 8c1c47d..adb3c2b 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -396,7 +396,7 @@ static ssize_t hwrng_attr_selected_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", cur_rng_set_by_user);
+	return sysfs_emit(buf, "%d\n", cur_rng_set_by_user);
 }
 
 static DEVICE_ATTR(rng_current, S_IRUGO | S_IWUSR,
-- 
2.7.4


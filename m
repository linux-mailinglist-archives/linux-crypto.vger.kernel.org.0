Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA63C343662
	for <lists+linux-crypto@lfdr.de>; Mon, 22 Mar 2021 02:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhCVBoX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 21 Mar 2021 21:44:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13650 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhCVBoE (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 21 Mar 2021 21:44:04 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F3cfh5gDLznTdC
        for <linux-crypto@vger.kernel.org>; Mon, 22 Mar 2021 09:41:32 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Mon, 22 Mar 2021 09:43:59 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>
Subject: [PATCH] hwrng: core - Use sysfs_emit to replace snprintf
Date:   Mon, 22 Mar 2021 09:44:36 +0800
Message-ID: <1616377476-27337-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Fix the following coccicheck warning:
drivers/char/hw_random//core.c:399:8-16: WARNING: use scnprintf or
sprintf

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
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


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3236130ED47
	for <lists+linux-crypto@lfdr.de>; Thu,  4 Feb 2021 08:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbhBDHZk (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 4 Feb 2021 02:25:40 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:43437 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230146AbhBDHZi (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 4 Feb 2021 02:25:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UNpwDV6_1612423454;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UNpwDV6_1612423454)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 04 Feb 2021 15:24:19 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jamie@jamieiles.com
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] crypto: picoxcell - convert sysfs sprintf/snprintf family to sysfs_emit
Date:   Thu,  4 Feb 2021 15:24:13 +0800
Message-Id: <1612423453-78809-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Fix the following coccicheck warning:

 ./drivers/crypto/picoxcell_crypto.c:1201:8-16: WARNING: use scnprintf
or sprintf.

Reported-by: Abaci Robot<abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/crypto/picoxcell_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/picoxcell_crypto.c b/drivers/crypto/picoxcell_crypto.c
index 84f9c16..d7a7def 100644
--- a/drivers/crypto/picoxcell_crypto.c
+++ b/drivers/crypto/picoxcell_crypto.c
@@ -1198,7 +1198,7 @@ static ssize_t spacc_stat_irq_thresh_show(struct device *dev,
 {
 	struct spacc_engine *engine = spacc_dev_to_engine(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", engine->stat_irq_thresh);
+	return sysfs_emit(buf, "%u\n", engine->stat_irq_thresh);
 }
 
 static ssize_t spacc_stat_irq_thresh_store(struct device *dev,
-- 
1.8.3.1


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2088238E358
	for <lists+linux-crypto@lfdr.de>; Mon, 24 May 2021 11:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhEXJ3y (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 24 May 2021 05:29:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5529 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhEXJ3y (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 24 May 2021 05:29:54 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FpWz24ClCzkYZ9;
        Mon, 24 May 2021 17:25:34 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 17:28:24 +0800
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 24 May 2021 17:28:24 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <wangzhou1@hisilicon.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next v3] crypto: hisilicon - switch to memdup_user_nul()
Date:   Mon, 24 May 2021 17:47:08 +0800
Message-ID: <1621849628-108717-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggemi762-chm.china.huawei.com (10.1.198.148)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Use memdup_user_nul() helper instead of open-coding to
simplify the code.

v1-->v2:
   fixed patch title error
v2-->v3:
   return the actual error

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 8f7ea50..8b389c2 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -1571,16 +1571,9 @@ static ssize_t qm_cmd_write(struct file *filp, const char __user *buffer,
 	if (count > QM_DBG_WRITE_LEN)
 		return -ENOSPC;
 
-	cmd_buf = kzalloc(count + 1, GFP_KERNEL);
-	if (!cmd_buf)
-		return -ENOMEM;
-
-	if (copy_from_user(cmd_buf, buffer, count)) {
-		kfree(cmd_buf);
-		return -EFAULT;
-	}
-
-	cmd_buf[count] = '\0';
+	cmd_buf = memdup_user_nul(buffer, count);
+	if (IS_ERR(cmd_buf))
+		return PTR_ERR(cmd_buf);
 
 	cmd_buf_tmp = strchr(cmd_buf, '\n');
 	if (cmd_buf_tmp) {
-- 
2.6.2


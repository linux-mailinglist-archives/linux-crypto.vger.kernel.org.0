Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF8926EA84
	for <lists+linux-crypto@lfdr.de>; Fri, 18 Sep 2020 03:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgIRBaw (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 17 Sep 2020 21:30:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39402 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726249AbgIRBar (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 17 Sep 2020 21:30:47 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B1178FD116BE2EAA8614;
        Fri, 18 Sep 2020 09:30:45 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 09:30:38 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH -next v2] crypto: hisilicon/qm - Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Fri, 18 Sep 2020 09:31:13 +0800
Message-ID: <20200918013113.82740-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
v2: based on linux-next(20200917), and can be applied to
    mainline cleanly now.

 drivers/crypto/hisilicon/qm.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 07efc5283..1923f153d 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -1050,17 +1050,7 @@ static int qm_regs_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int qm_regs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, qm_regs_show, inode->i_private);
-}
-
-static const struct file_operations qm_regs_fops = {
-	.owner = THIS_MODULE,
-	.open = qm_regs_open,
-	.read = seq_read,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(qm_regs);
 
 static ssize_t qm_cmd_read(struct file *filp, char __user *buffer,
 			   size_t count, loff_t *pos)
-- 
2.23.0


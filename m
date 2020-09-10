Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364EC26467B
	for <lists+linux-crypto@lfdr.de>; Thu, 10 Sep 2020 15:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbgIJNA7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 10 Sep 2020 09:00:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11787 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730905AbgIJM6O (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 10 Sep 2020 08:58:14 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 860E4D250F1DEF30FDF8
        for <linux-crypto@vger.kernel.org>; Thu, 10 Sep 2020 20:58:02 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 20:57:56 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>
Subject: [PATCH 2/5] crypto: hisilicon - update HPRE module parameter description
Date:   Thu, 10 Sep 2020 20:56:49 +0800
Message-ID: <1599742610-33571-2-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1599742610-33571-1-git-send-email-liulongfang@huawei.com>
References: <1599742610-33571-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

In order to pass kernel CRYPTO test, HPRE module parameter
'pf_q_num' needs to be set as greater than 1.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 45741d2..cf9169d 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -190,7 +190,7 @@ static const struct kernel_param_ops hpre_pf_q_num_ops = {
 
 static u32 pf_q_num = HPRE_PF_DEF_Q_NUM;
 module_param_cb(pf_q_num, &hpre_pf_q_num_ops, &pf_q_num, 0444);
-MODULE_PARM_DESC(pf_q_num, "Number of queues in PF of CS(1-1024)");
+MODULE_PARM_DESC(pf_q_num, "Number of queues in PF of CS(2-1024)");
 
 static const struct kernel_param_ops vfs_num_ops = {
 	.set = vfs_num_set,
-- 
2.8.1


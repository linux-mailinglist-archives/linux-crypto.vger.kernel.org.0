Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D3F2645A1
	for <lists+linux-crypto@lfdr.de>; Thu, 10 Sep 2020 14:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgIJMBy (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 10 Sep 2020 08:01:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11771 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730189AbgIJL6F (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 10 Sep 2020 07:58:05 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C924836589ABF2BC5FD8
        for <linux-crypto@vger.kernel.org>; Thu, 10 Sep 2020 19:57:53 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 19:57:51 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>
Subject: [PATCH 4/5] crypto: hisilicon - update ZIP module parameter description
Date:   Thu, 10 Sep 2020 19:56:42 +0800
Message-ID: <1599739003-23448-5-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1599739003-23448-1-git-send-email-liulongfang@huawei.com>
References: <1599739003-23448-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

In order to pass kernel CRYPTO test, ZIP module parameter
'pf_q_num' needs to be set as greater than 1.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/crypto/hisilicon/zip/zip_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 7e86b0f..9ca10be 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -220,7 +220,7 @@ static const struct kernel_param_ops pf_q_num_ops = {
 
 static u32 pf_q_num = HZIP_PF_DEF_Q_NUM;
 module_param_cb(pf_q_num, &pf_q_num_ops, &pf_q_num, 0444);
-MODULE_PARM_DESC(pf_q_num, "Number of queues in PF(v1 1-4096, v2 1-1024)");
+MODULE_PARM_DESC(pf_q_num, "Number of queues in PF(v1 2-4096, v2 2-1024)");
 
 static const struct kernel_param_ops vfs_num_ops = {
 	.set = vfs_num_set,
-- 
2.8.1


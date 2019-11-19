Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06B4D1015BA
	for <lists+linux-crypto@lfdr.de>; Tue, 19 Nov 2019 06:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbfKSFqm (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 19 Nov 2019 00:46:42 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7142 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731140AbfKSFqm (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 19 Nov 2019 00:46:42 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B90C4932C7B6DDD39447;
        Tue, 19 Nov 2019 13:46:39 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Tue, 19 Nov 2019 13:46:31 +0800
From:   Zhou Wang <wangzhou1@hisilicon.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linuxarm@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH 3/3] crypto: hisilicon - Remove useless MODULE macros
Date:   Tue, 19 Nov 2019 13:42:58 +0800
Message-ID: <1574142178-76514-4-git-send-email-wangzhou1@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1574142178-76514-1-git-send-email-wangzhou1@hisilicon.com>
References: <1574142178-76514-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

As we already merge hardware sgl into hisi_qm module, remove useless
MODULE macros.

Fixes: 48c1cd40fae3 (crypto: hisilicon - merge sgl support to hisi_qm module)
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/sgl.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/crypto/hisilicon/sgl.c b/drivers/crypto/hisilicon/sgl.c
index 1e153a0..0e8c7e3 100644
--- a/drivers/crypto/hisilicon/sgl.c
+++ b/drivers/crypto/hisilicon/sgl.c
@@ -263,7 +263,3 @@ void hisi_acc_sg_buf_unmap(struct device *dev, struct scatterlist *sgl,
 	hw_sgl->entry_length_in_sgl = 0;
 }
 EXPORT_SYMBOL_GPL(hisi_acc_sg_buf_unmap);
-
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Zhou Wang <wangzhou1@hisilicon.com>");
-MODULE_DESCRIPTION("HiSilicon Accelerator SGL support");
-- 
2.8.1


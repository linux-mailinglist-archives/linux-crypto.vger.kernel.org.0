Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDFA22A987
	for <lists+linux-crypto@lfdr.de>; Thu, 23 Jul 2020 09:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgGWHV6 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 23 Jul 2020 03:21:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8363 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726947AbgGWHV5 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 23 Jul 2020 03:21:57 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 27D1B9A9E227E5D1C5C6;
        Thu, 23 Jul 2020 15:21:52 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Thu, 23 Jul 2020 15:21:43 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>
Subject: [PATCH v3 03/10] crypto: hisilicon/qm - fix print frequence in hisi_qp_send
Date:   Thu, 23 Jul 2020 15:19:33 +0800
Message-ID: <1595488780-22085-4-git-send-email-shenyang39@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595488780-22085-1-git-send-email-shenyang39@huawei.com>
References: <1595488780-22085-1-git-send-email-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Requests will be sent continuously as resetting, which will cause 'printk'
flooding. Using 'dev_info_ratelimited' can solve this problem well.

Fixes: b67202e8ed30("crypto: hisilicon/qm - add state machine for QM")
Signed-off-by: Yang Shen <shenyang39@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/qm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index e89d9b6..406fca3 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -1983,7 +1983,7 @@ int hisi_qp_send(struct hisi_qp *qp, const void *msg)
 	if (unlikely(atomic_read(&qp->qp_status.flags) == QP_STOP ||
 		     atomic_read(&qp->qm->status.flags) == QM_STOP ||
 		     qp->is_resetting)) {
-		dev_info(&qp->qm->pdev->dev, "QP is stopped or resetting\n");
+		dev_info_ratelimited(&qp->qm->pdev->dev, "QP is stopped or resetting\n");
 		return -EAGAIN;
 	}
 
-- 
2.7.4


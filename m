Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1154C245539
	for <lists+linux-crypto@lfdr.de>; Sun, 16 Aug 2020 03:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbgHPBoS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 15 Aug 2020 21:44:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33844 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729388AbgHPBoR (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 15 Aug 2020 21:44:17 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 204008EB390444B5516F;
        Sat, 15 Aug 2020 17:58:34 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Sat, 15 Aug 2020 17:58:23 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH v5 03/10] crypto: hisilicon/qm - fix print frequence in hisi_qp_send
Date:   Sat, 15 Aug 2020 17:56:10 +0800
Message-ID: <1597485377-2678-4-git-send-email-shenyang39@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597485377-2678-1-git-send-email-shenyang39@huawei.com>
References: <1597485377-2678-1-git-send-email-shenyang39@huawei.com>
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
index 1e49931..95a1b6c 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -1984,7 +1984,7 @@ int hisi_qp_send(struct hisi_qp *qp, const void *msg)
 	if (unlikely(atomic_read(&qp->qp_status.flags) == QP_STOP ||
 		     atomic_read(&qp->qm->status.flags) == QM_STOP ||
 		     qp->is_resetting)) {
-		dev_info(&qp->qm->pdev->dev, "QP is stopped or resetting\n");
+		dev_info_ratelimited(&qp->qm->pdev->dev, "QP is stopped or resetting\n");
 		return -EAGAIN;
 	}
 
-- 
2.7.4


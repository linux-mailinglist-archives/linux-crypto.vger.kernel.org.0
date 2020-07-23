Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84CD22A988
	for <lists+linux-crypto@lfdr.de>; Thu, 23 Jul 2020 09:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgGWHWA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 23 Jul 2020 03:22:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8359 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726833AbgGWHV6 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 23 Jul 2020 03:21:58 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1522CB5ADED9C007A61B;
        Thu, 23 Jul 2020 15:21:52 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Thu, 23 Jul 2020 15:21:42 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>
Subject: [PATCH v3 02/10] crypto: hisilicon/qm - clear used reference count when start qp
Date:   Thu, 23 Jul 2020 15:19:32 +0800
Message-ID: <1595488780-22085-3-git-send-email-shenyang39@huawei.com>
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

From: Shukun Tan <tanshukun1@huawei.com>

The used reference count is used for counting the number of 'sqe' which
is under processing. This reference count should be cleared as starting
'qp', otherwise the 'used' will be messy when allocating this 'qp' again.

Fixes: 5308f6600a39("crypto: hisilicon - QM memory management...")
Signed-off-by: Shukun Tan <tanshukun1@huawei.com>
Signed-off-by: Yang Shen <shenyang39@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/qm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index ffb28cc..e89d9b6 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -755,6 +755,7 @@ static void qm_init_qp_status(struct hisi_qp *qp)
 	qp_status->cq_head = 0;
 	qp_status->cqc_phase = true;
 	atomic_set(&qp_status->flags, 0);
+	atomic_set(&qp_status->used, 0);
 }
 
 static void qm_vft_data_cfg(struct hisi_qm *qm, enum vft_type type, u32 base,
-- 
2.7.4


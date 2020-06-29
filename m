Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6301320D33F
	for <lists+linux-crypto@lfdr.de>; Mon, 29 Jun 2020 21:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbgF2S5I (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 29 Jun 2020 14:57:08 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59520 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729810AbgF2S5E (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:04 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2EF2D262C820835CE9CE;
        Mon, 29 Jun 2020 19:10:58 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 29 Jun 2020 19:10:44 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>
Subject: [PATCH 2/9] crypto: hisilicon/qm - clear used reference count when start qp
Date:   Mon, 29 Jun 2020 19:09:01 +0800
Message-ID: <1593428948-64634-3-git-send-email-shenyang39@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593428948-64634-1-git-send-email-shenyang39@huawei.com>
References: <1593428948-64634-1-git-send-email-shenyang39@huawei.com>
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
is under processing. This reference count should be cleared as starting 'qp',
otherwise the 'used' will be messy when allocating this 'qp' again.

Fixes: 5308f6600a39("crypto: hisilicon - QM memory management...")
Signed-off-by: Shukun Tan <tanshukun1@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index ad0adcc..79d17a0 100644
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


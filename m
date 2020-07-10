Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C7F21B06F
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Jul 2020 09:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgGJHmw (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 10 Jul 2020 03:42:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54858 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726768AbgGJHlg (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 10 Jul 2020 03:41:36 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A5A2F8D50A1D3B2595D3;
        Fri, 10 Jul 2020 15:41:32 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 10 Jul 2020 15:41:23 +0800
From:   Meng Yu <yumeng18@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/6] crypto: hisilicon/hpre - Init the value of current_q of debugfs
Date:   Fri, 10 Jul 2020 15:40:41 +0800
Message-ID: <1594366846-1313-2-git-send-email-yumeng18@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1594366846-1313-1-git-send-email-yumeng18@huawei.com>
References: <1594366846-1313-1-git-send-email-yumeng18@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Initialize current queue number as HPRE_PF_DEF_Q_NUM, or it is zero
and we can't set its value by "current_q_write".

Signed-off-by: Meng Yu <yumeng18@huawei.com>
Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
Reviewed-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index a3ee127..3131347 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -732,6 +732,7 @@ static int hpre_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 	if (qm->fun_type == QM_HW_PF) {
 		qm->qp_base = HPRE_PF_DEF_Q_BASE;
 		qm->qp_num = pf_q_num;
+		qm->debug.curr_qm_qp_num = pf_q_num;
 		qm->qm_list = &hpre_devices;
 	}
 
-- 
2.8.1


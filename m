Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7401659E1
	for <lists+linux-crypto@lfdr.de>; Thu, 20 Feb 2020 10:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgBTJJJ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 20 Feb 2020 04:09:09 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:56072 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726934AbgBTJJJ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 20 Feb 2020 04:09:09 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 43C66B634BA2E04535D6;
        Thu, 20 Feb 2020 17:09:06 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 20 Feb 2020 17:08:57 +0800
From:   Zaibo Xu <xuzaibo@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <wangzhou1@hisilicon.com>,
        <linuxarm@huawei.com>, <fanghao11@huawei.com>,
        <yekai13@huawei.com>, <tanshukun1@huawei.com>,
        <qianweili@huawei.com>, <shenyang39@huawei.com>,
        <zhangwei375@huawei.com>, <tanghui20@huawei.com>,
        <liulongfang@huawei.com>, <forest.zhouchang@huawei.com>
Subject: [PATCH 2/4] crypto: hisilicon/sec2 - Add workqueue for SEC driver.
Date:   Thu, 20 Feb 2020 17:04:53 +0800
Message-ID: <1582189495-38051-3-git-send-email-xuzaibo@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1582189495-38051-1-git-send-email-xuzaibo@huawei.com>
References: <1582189495-38051-1-git-send-email-xuzaibo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: yekai13 <yekai13@huawei.com>

Allocate one workqueue for each QM instead of one for all QMs,
we found the throughput of SEC engine can be increased to
the hardware limit throughput during testing sec2 performance.
so we added this scheme.

Signed-off-by: yekai13 <yekai13@huawei.com>
Signed-off-by: liulongfang <liulongfang@huawei.com>
Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_main.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 3767fdb..ebafc1c 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -774,12 +774,24 @@ static void sec_qm_uninit(struct hisi_qm *qm)
 
 static int sec_probe_init(struct hisi_qm *qm, struct sec_dev *sec)
 {
+	int ret;
+
+	qm->wq = alloc_workqueue("%s", WQ_HIGHPRI | WQ_CPU_INTENSIVE |
+		WQ_MEM_RECLAIM | WQ_UNBOUND, num_online_cpus(),
+		pci_name(qm->pdev));
+	if (!qm->wq) {
+		pci_err(qm->pdev, "fail to alloc workqueue\n");
+		return -ENOMEM;
+	}
+
 	if (qm->fun_type == QM_HW_PF) {
 		qm->qp_base = SEC_PF_DEF_Q_BASE;
 		qm->qp_num = pf_q_num;
 		qm->debug.curr_qm_qp_num = pf_q_num;
 
-		return sec_pf_probe_init(sec);
+		ret = sec_pf_probe_init(sec);
+		if (ret)
+			goto err_probe_uninit;
 	} else if (qm->fun_type == QM_HW_VF) {
 		/*
 		 * have no way to get qm configure in VM in v1 hardware,
@@ -792,18 +804,26 @@ static int sec_probe_init(struct hisi_qm *qm, struct sec_dev *sec)
 			qm->qp_num = SEC_QUEUE_NUM_V1 - SEC_PF_DEF_Q_NUM;
 		} else if (qm->ver == QM_HW_V2) {
 			/* v2 starts to support get vft by mailbox */
-			return hisi_qm_get_vft(qm, &qm->qp_base, &qm->qp_num);
+			ret = hisi_qm_get_vft(qm, &qm->qp_base, &qm->qp_num);
+			if (ret)
+				goto err_probe_uninit;
 		}
 	} else {
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_probe_uninit;
 	}
 
 	return 0;
+err_probe_uninit:
+	destroy_workqueue(qm->wq);
+	return ret;
 }
 
 static void sec_probe_uninit(struct hisi_qm *qm)
 {
 	hisi_qm_dev_err_uninit(qm);
+
+	destroy_workqueue(qm->wq);
 }
 
 static int sec_probe(struct pci_dev *pdev, const struct pci_device_id *id)
-- 
2.8.1


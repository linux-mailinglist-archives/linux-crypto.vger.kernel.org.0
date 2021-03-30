Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D762D34E2B2
	for <lists+linux-crypto@lfdr.de>; Tue, 30 Mar 2021 10:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhC3IF1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 30 Mar 2021 04:05:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14195 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhC3IFQ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 30 Mar 2021 04:05:16 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F8hkd6BbrzmbPH;
        Tue, 30 Mar 2021 16:02:33 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Tue, 30 Mar 2021
 16:05:00 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <herbert@gondor.apana.org.au>, <wangzhou1@hisilicon.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liulongfang@huawei.com>
Subject: [PATCH v2] crypto: hisilicon/sec - Fix a module parameter error
Date:   Tue, 30 Mar 2021 16:02:32 +0800
Message-ID: <1617091352-52938-1-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

ctx_q_num is a module parameter set by the user to specify the
number of qp queues required to create a ctx.

When the number of qp queues allocated by PF or VF is less than
the ctx_q_num, an error will be reported when ctx is initialized
in kernel mode, which leads to the problem that the registered
algorithms cannot be used.

Therefore, when PF or VF is initialized, if the number of qp queues
is not enough to create a ctx, the kernel mode cannot be used,
and there is no need to register the kernel mode algorithms.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---

Changes in V2:
 - Add algorithms unregistration processing

 drivers/crypto/hisilicon/sec2/sec_main.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index b1818f7..8e2e2b1 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -867,10 +867,15 @@ static int sec_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		pci_warn(pdev, "Failed to init debugfs!\n");
 
-	ret = hisi_qm_alg_register(qm, &sec_devices);
-	if (ret < 0) {
-		pr_err("Failed to register driver to crypto.\n");
-		goto err_qm_stop;
+	if (qm->qp_num >= ctx_q_num) {
+		ret = hisi_qm_alg_register(qm, &sec_devices);
+		if (ret < 0) {
+			pr_err("Failed to register driver to crypto.\n");
+			goto err_qm_stop;
+		}
+	} else {
+		pci_warn(qm->pdev,
+			"Failed to use kernel mode, qp not enough!\n");
 	}
 
 	if (qm->uacce) {
@@ -906,7 +911,9 @@ static void sec_remove(struct pci_dev *pdev)
 	struct hisi_qm *qm = pci_get_drvdata(pdev);
 
 	hisi_qm_wait_task_finish(qm, &sec_devices);
-	hisi_qm_alg_unregister(qm, &sec_devices);
+	if (qm->qp_num >= ctx_q_num)
+		hisi_qm_alg_unregister(qm, &sec_devices);
+
 	if (qm->fun_type == QM_HW_PF && qm->vfs_num)
 		hisi_qm_sriov_disable(pdev, true);
 
-- 
2.8.1


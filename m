Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695BA1CA4AF
	for <lists+linux-crypto@lfdr.de>; Fri,  8 May 2020 08:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgEHG7K (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 May 2020 02:59:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42792 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726761AbgEHG7J (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 8 May 2020 02:59:09 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 223C0A0A04ADCE39A178;
        Fri,  8 May 2020 14:59:00 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 14:58:53 +0800
From:   Shukun Tan <tanshukun1@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>
Subject: [PATCH 08/13] crypto: hisilicon - unify initial value assignment into QM
Date:   Fri, 8 May 2020 14:57:43 +0800
Message-ID: <1588921068-20739-9-git-send-email-tanshukun1@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588921068-20739-1-git-send-email-tanshukun1@huawei.com>
References: <1588921068-20739-1-git-send-email-tanshukun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Weili Qian <qianweili@huawei.com>

Some initial value assignment of struct hisi_qm could put into QM.

Signed-off-by: Weili Qian <qianweili@huawei.com>
Signed-off-by: Shukun Tan <tanshukun1@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 22 +++++++-------
 drivers/crypto/hisilicon/qm.c             | 44 +++++++++++++++++++--------
 drivers/crypto/hisilicon/sec2/sec_main.c  | 50 +++++++++++++++----------------
 drivers/crypto/hisilicon/zip/zip_main.c   | 37 ++++++++++-------------
 4 files changed, 81 insertions(+), 72 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 7662a8f..93df31a 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -672,12 +672,13 @@ static int hpre_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 	qm->ver = rev_id;
 	qm->sqe_size = HPRE_SQE_SIZE;
 	qm->dev_name = hpre_name;
-	qm->fun_type = (pdev->device == HPRE_PCI_DEVICE_ID) ?
-		       QM_HW_PF : QM_HW_VF;
 
-	if (pdev->is_physfn) {
+	qm->fun_type = (pdev->device == HPRE_PCI_DEVICE_ID) ?
+			QM_HW_PF : QM_HW_VF;
+	if (qm->fun_type == QM_HW_PF) {
 		qm->qp_base = HPRE_PF_DEF_Q_BASE;
 		qm->qp_num = pf_q_num;
+		qm->qm_list = &hpre_devices;
 	}
 
 	return hisi_qm_init(qm);
@@ -748,7 +749,6 @@ static int hpre_pf_probe_init(struct hpre *hpre)
 	if (ret)
 		return ret;
 
-	qm->qm_list = &hpre_devices;
 	qm->err_ini = &hpre_err_ini;
 	hisi_qm_dev_err_init(qm);
 
@@ -758,15 +758,15 @@ static int hpre_pf_probe_init(struct hpre *hpre)
 static int hpre_probe_init(struct hpre *hpre)
 {
 	struct hisi_qm *qm = &hpre->qm;
-	int ret = -ENODEV;
+	int ret;
 
-	if (qm->fun_type == QM_HW_PF)
+	if (qm->fun_type == QM_HW_PF) {
 		ret = hpre_pf_probe_init(hpre);
-	else if (qm->fun_type == QM_HW_VF && qm->ver == QM_HW_V2)
-		/* v2 starts to support get vft by mailbox */
-		ret = hisi_qm_get_vft(qm, &qm->qp_base, &qm->qp_num);
+		if (ret)
+			return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 static int hpre_probe(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -779,8 +779,6 @@ static int hpre_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!hpre)
 		return -ENOMEM;
 
-	pci_set_drvdata(pdev, hpre);
-
 	qm = &hpre->qm;
 	ret = hpre_qm_init(qm, pdev);
 	if (ret) {
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 800beef..e401638 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -1916,6 +1916,27 @@ int hisi_qm_get_free_qp_num(struct hisi_qm *qm)
 }
 EXPORT_SYMBOL_GPL(hisi_qm_get_free_qp_num);
 
+static void hisi_qm_pre_init(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+
+	switch (qm->ver) {
+	case QM_HW_V1:
+		qm->ops = &qm_hw_ops_v1;
+		break;
+	case QM_HW_V2:
+		qm->ops = &qm_hw_ops_v2;
+		break;
+	default:
+		return;
+	}
+
+	pci_set_drvdata(pdev, qm);
+	mutex_init(&qm->mailbox_lock);
+	init_rwsem(&qm->qps_lock);
+	qm->qp_in_used = 0;
+}
+
 /**
  * hisi_qm_init() - Initialize configures about qm.
  * @qm: The qm needing init.
@@ -1929,16 +1950,7 @@ int hisi_qm_init(struct hisi_qm *qm)
 	unsigned int num_vec;
 	int ret;
 
-	switch (qm->ver) {
-	case QM_HW_V1:
-		qm->ops = &qm_hw_ops_v1;
-		break;
-	case QM_HW_V2:
-		qm->ops = &qm_hw_ops_v2;
-		break;
-	default:
-		return -EINVAL;
-	}
+	hisi_qm_pre_init(qm);
 
 	ret = qm_alloc_uacce(qm);
 	if (ret < 0)
@@ -1984,15 +1996,21 @@ int hisi_qm_init(struct hisi_qm *qm)
 	if (ret)
 		goto err_free_irq_vectors;
 
-	qm->qp_in_used = 0;
-	mutex_init(&qm->mailbox_lock);
-	init_rwsem(&qm->qps_lock);
+	if (qm->fun_type == QM_HW_VF && qm->ver == QM_HW_V2) {
+		/* v2 starts to support get vft by mailbox */
+		ret = hisi_qm_get_vft(qm, &qm->qp_base, &qm->qp_num);
+		if (ret)
+			goto err_irq_unregister;
+	}
+
 	INIT_WORK(&qm->work, qm_work_process);
 
 	atomic_set(&qm->status.flags, QM_INIT);
 
 	return 0;
 
+err_irq_unregister:
+	qm_irq_unregister(qm);
 err_free_irq_vectors:
 	pci_free_irq_vectors(pdev);
 err_iounmap:
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 499c554..703b8b1 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -722,6 +722,7 @@ static int sec_pf_probe_init(struct sec_dev *sec)
 static int sec_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 {
 	enum qm_hw_ver rev_id;
+	int ret;
 
 	rev_id = hisi_qm_get_hw_version(pdev);
 	if (rev_id == QM_HW_UNKNOWN)
@@ -729,9 +730,9 @@ static int sec_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 
 	qm->pdev = pdev;
 	qm->ver = rev_id;
-
 	qm->sqe_size = SEC_SQE_SIZE;
 	qm->dev_name = sec_name;
+
 	qm->fun_type = (pdev->device == SEC_PF_PCI_DEVICE_ID) ?
 			QM_HW_PF : QM_HW_VF;
 	if (qm->fun_type == QM_HW_PF) {
@@ -750,7 +751,25 @@ static int sec_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		qm->qp_num = SEC_QUEUE_NUM_V1 - SEC_PF_DEF_Q_NUM;
 	}
 
-	return hisi_qm_init(qm);
+	/*
+	 * WQ_HIGHPRI: SEC request must be low delayed,
+	 * so need a high priority workqueue.
+	 * WQ_UNBOUND: SEC task is likely with long
+	 * running CPU intensive workloads.
+	 */
+	qm->wq = alloc_workqueue("%s", WQ_HIGHPRI | WQ_MEM_RECLAIM |
+				 WQ_UNBOUND, num_online_cpus(),
+				 pci_name(qm->pdev));
+	if (!qm->wq) {
+		pci_err(qm->pdev, "fail to alloc workqueue\n");
+		return -ENOMEM;
+	}
+
+	ret = hisi_qm_init(qm);
+	if (ret)
+		destroy_workqueue(qm->wq);
+
+	return ret;
 }
 
 static void sec_qm_uninit(struct hisi_qm *qm)
@@ -763,29 +782,10 @@ static int sec_probe_init(struct sec_dev *sec)
 	struct hisi_qm *qm = &sec->qm;
 	int ret;
 
-	/*
-	 * WQ_HIGHPRI: SEC request must be low delayed,
-	 * so need a high priority workqueue.
-	 * WQ_UNBOUND: SEC task is likely with long
-	 * running CPU intensive workloads.
-	 */
-	qm->wq = alloc_workqueue("%s", WQ_HIGHPRI |
-		WQ_MEM_RECLAIM | WQ_UNBOUND, num_online_cpus(),
-		pci_name(qm->pdev));
-	if (!qm->wq) {
-		pci_err(qm->pdev, "fail to alloc workqueue\n");
-		return -ENOMEM;
-	}
-
-	if (qm->fun_type == QM_HW_PF)
+	if (qm->fun_type == QM_HW_PF) {
 		ret = sec_pf_probe_init(sec);
-	else if (qm->fun_type == QM_HW_VF && qm->ver == QM_HW_V2)
-		/* v2 starts to support get vft by mailbox */
-		ret = hisi_qm_get_vft(qm, &qm->qp_base, &qm->qp_num);
-
-	if (ret) {
-		destroy_workqueue(qm->wq);
-		return ret;
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -825,8 +825,6 @@ static int sec_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!sec)
 		return -ENOMEM;
 
-	pci_set_drvdata(pdev, sec);
-
 	qm = &sec->qm;
 	ret = sec_qm_init(qm, pdev);
 	if (ret) {
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 6a1a824..1a5a6e3 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -694,12 +694,27 @@ static int hisi_zip_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 
 	qm->pdev = pdev;
 	qm->ver = rev_id;
-
 	qm->algs = "zlib\ngzip";
 	qm->sqe_size = HZIP_SQE_SIZE;
 	qm->dev_name = hisi_zip_name;
+
 	qm->fun_type = (pdev->device == PCI_DEVICE_ID_ZIP_PF) ?
 			QM_HW_PF : QM_HW_VF;
+	if (qm->fun_type == QM_HW_PF) {
+		qm->qp_base = HZIP_PF_DEF_Q_BASE;
+		qm->qp_num = pf_q_num;
+		qm->qm_list = &zip_devices;
+	} else if (qm->fun_type == QM_HW_VF && qm->ver == QM_HW_V1) {
+		/*
+		 * have no way to get qm configure in VM in v1 hardware,
+		 * so currently force PF to uses HZIP_PF_DEF_Q_NUM, and force
+		 * to trigger only one VF in v1 hardware.
+		 *
+		 * v2 hardware has no such problem.
+		 */
+		qm->qp_base = HZIP_PF_DEF_Q_NUM;
+		qm->qp_num = HZIP_QUEUE_NUM_V1 - HZIP_PF_DEF_Q_NUM;
+	}
 
 	return hisi_qm_init(qm);
 }
@@ -713,24 +728,6 @@ static int hisi_zip_probe_init(struct hisi_zip *hisi_zip)
 		ret = hisi_zip_pf_probe_init(hisi_zip);
 		if (ret)
 			return ret;
-
-		qm->qp_base = HZIP_PF_DEF_Q_BASE;
-		qm->qp_num = pf_q_num;
-		qm->qm_list = &zip_devices;
-	} else if (qm->fun_type == QM_HW_VF) {
-		/*
-		 * have no way to get qm configure in VM in v1 hardware,
-		 * so currently force PF to uses HZIP_PF_DEF_Q_NUM, and force
-		 * to trigger only one VF in v1 hardware.
-		 *
-		 * v2 hardware has no such problem.
-		 */
-		if (qm->ver == QM_HW_V1) {
-			qm->qp_base = HZIP_PF_DEF_Q_NUM;
-			qm->qp_num = HZIP_QUEUE_NUM_V1 - HZIP_PF_DEF_Q_NUM;
-		} else if (qm->ver == QM_HW_V2)
-			/* v2 starts to support get vft by mailbox */
-			return hisi_qm_get_vft(qm, &qm->qp_base, &qm->qp_num);
 	}
 
 	return 0;
@@ -746,8 +743,6 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!hisi_zip)
 		return -ENOMEM;
 
-	pci_set_drvdata(pdev, hisi_zip);
-
 	qm = &hisi_zip->qm;
 
 	ret = hisi_zip_qm_init(qm, pdev);
-- 
2.7.4


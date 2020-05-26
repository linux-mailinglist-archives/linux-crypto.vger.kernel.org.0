Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E8E1CA4B0
	for <lists+linux-crypto@lfdr.de>; Fri,  8 May 2020 08:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgEHG7L (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 May 2020 02:59:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42788 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726809AbgEHG7K (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 8 May 2020 02:59:10 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1E3CD8E5A9B88D988B16;
        Fri,  8 May 2020 14:59:00 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 14:58:53 +0800
From:   Shukun Tan <tanshukun1@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>
Subject: [PATCH 07/13] crypto: hisilicon - remove use_dma_api related codes
Date:   Fri, 8 May 2020 14:57:42 +0800
Message-ID: <1588921068-20739-8-git-send-email-tanshukun1@huawei.com>
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

The codes related use_dma_api is useless which should be removed.

Signed-off-by: Shukun Tan <tanshukun1@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c |  1 -
 drivers/crypto/hisilicon/qm.c             | 34 ++++++++++++-------------------
 drivers/crypto/hisilicon/qm.h             |  1 -
 drivers/crypto/hisilicon/sec2/sec_main.c  |  1 -
 drivers/crypto/hisilicon/zip/zip_main.c   |  1 -
 5 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 1948fd3..7662a8f 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -679,7 +679,6 @@ static int hpre_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		qm->qp_base = HPRE_PF_DEF_Q_BASE;
 		qm->qp_num = pf_q_num;
 	}
-	qm->use_dma_api = true;
 
 	return hisi_qm_init(qm);
 }
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index c30df08..800beef 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -1267,20 +1267,18 @@ static struct hisi_qp *qm_create_qp_nolock(struct hisi_qm *qm, u8 alg_type)
 	qm->qp_in_used++;
 	qp->qm = qm;
 
-	if (qm->use_dma_api) {
-		qp->qdma.size = qm->sqe_size * QM_Q_DEPTH +
-				sizeof(struct qm_cqe) * QM_Q_DEPTH;
-		qp->qdma.va = dma_alloc_coherent(dev, qp->qdma.size,
-						 &qp->qdma.dma, GFP_KERNEL);
-		if (!qp->qdma.va) {
-			ret = -ENOMEM;
-			goto err_clear_bit;
-		}
-
-		dev_dbg(dev, "allocate qp dma buf(va=%pK, dma=%pad, size=%zx)\n",
-			qp->qdma.va, &qp->qdma.dma, qp->qdma.size);
+	qp->qdma.size = qm->sqe_size * QM_Q_DEPTH +
+			sizeof(struct qm_cqe) * QM_Q_DEPTH;
+	qp->qdma.va = dma_alloc_coherent(dev, qp->qdma.size,
+					 &qp->qdma.dma, GFP_KERNEL);
+	if (!qp->qdma.va) {
+		ret = -ENOMEM;
+		goto err_clear_bit;
 	}
 
+	dev_dbg(dev, "allocate qp dma buf(va=%pK, dma=%pad, size=%zx)\n",
+		qp->qdma.va, &qp->qdma.dma, qp->qdma.size);
+
 	qp->qp_id = qp_id;
 	qp->alg_type = alg_type;
 	atomic_set(&qp->qp_status.flags, QP_INIT);
@@ -1334,7 +1332,7 @@ void hisi_qm_release_qp(struct hisi_qp *qp)
 		return;
 	}
 
-	if (qm->use_dma_api && qdma->va)
+	if (qdma->va)
 		dma_free_coherent(dev, qdma->size, qdma->va, qdma->dma);
 
 	qm->qp_array[qp->qp_id] = NULL;
@@ -1992,8 +1990,6 @@ int hisi_qm_init(struct hisi_qm *qm)
 	INIT_WORK(&qm->work, qm_work_process);
 
 	atomic_set(&qm->status.flags, QM_INIT);
-	dev_dbg(dev, "init qm %s with %s\n", pdev->is_physfn ? "pf" : "vf",
-		qm->use_dma_api ? "dma api" : "iommu api");
 
 	return 0;
 
@@ -2034,7 +2030,7 @@ void hisi_qm_uninit(struct hisi_qm *qm)
 	uacce_remove(qm->uacce);
 	qm->uacce = NULL;
 
-	if (qm->use_dma_api && qm->qdma.va) {
+	if (qm->qdma.va) {
 		hisi_qm_cache_wb(qm);
 		dma_free_coherent(dev, qm->qdma.size,
 				  qm->qdma.va, qm->qdma.dma);
@@ -2259,11 +2255,7 @@ int hisi_qm_start(struct hisi_qm *qm)
 		}
 	}
 
-	if (!qm->use_dma_api) {
-		dev_dbg(&qm->pdev->dev, "qm delay start\n");
-		up_write(&qm->qps_lock);
-		return 0;
-	} else if (!qm->qdma.va) {
+	if (!qm->qdma.va) {
 		qm->qdma.size = QMC_ALIGN(sizeof(struct qm_eqe) * QM_Q_DEPTH) +
 				QMC_ALIGN(sizeof(struct qm_aeqe) * QM_Q_DEPTH) +
 				QMC_ALIGN(sizeof(struct qm_sqc) * qm->qp_num) +
diff --git a/drivers/crypto/hisilicon/qm.h b/drivers/crypto/hisilicon/qm.h
index 25934e3..743cb63 100644
--- a/drivers/crypto/hisilicon/qm.h
+++ b/drivers/crypto/hisilicon/qm.h
@@ -230,7 +230,6 @@ struct hisi_qm {
 	struct work_struct work;
 
 	const char *algs;
-	bool use_dma_api;
 	bool use_sva;
 	resource_size_t phys_base;
 	resource_size_t phys_size;
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 437e8788..499c554 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -749,7 +749,6 @@ static int sec_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		qm->qp_base = SEC_PF_DEF_Q_NUM;
 		qm->qp_num = SEC_QUEUE_NUM_V1 - SEC_PF_DEF_Q_NUM;
 	}
-	qm->use_dma_api = true;
 
 	return hisi_qm_init(qm);
 }
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index a7f0c6a..6a1a824 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -692,7 +692,6 @@ static int hisi_zip_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 	if (rev_id == QM_HW_UNKNOWN)
 		return -EINVAL;
 
-	qm->use_dma_api = true;
 	qm->pdev = pdev;
 	qm->ver = rev_id;
 
-- 
2.7.4


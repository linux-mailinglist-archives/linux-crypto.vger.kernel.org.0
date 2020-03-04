Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62524178BE8
	for <lists+linux-crypto@lfdr.de>; Wed,  4 Mar 2020 08:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgCDHuF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 4 Mar 2020 02:50:05 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:36698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728530AbgCDHuE (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 4 Mar 2020 02:50:04 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6481CB5A0C791847E5A6;
        Wed,  4 Mar 2020 15:50:02 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Wed, 4 Mar 2020 15:49:52 +0800
From:   Shukun Tan <tanshukun1@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH 3/4] crypto: hisilicon/hpre - Optimize finding hpre device process
Date:   Wed, 4 Mar 2020 15:49:24 +0800
Message-ID: <1583308165-16800-4-git-send-email-tanshukun1@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583308165-16800-1-git-send-email-tanshukun1@huawei.com>
References: <1583308165-16800-1-git-send-email-tanshukun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Hui Tang <tanghui20@huawei.com>

Optimize finding hpre device process according to priority of numa
distance.

Signed-off-by: Hui Tang <tanghui20@huawei.com>
Signed-off-by: Shukun Tan <tanshukun1@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre.h        |  3 +-
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 20 ++++-------
 drivers/crypto/hisilicon/hpre/hpre_main.c   | 52 ++++++++---------------------
 3 files changed, 20 insertions(+), 55 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre.h b/drivers/crypto/hisilicon/hpre/hpre.h
index ddf13ea..03d512e 100644
--- a/drivers/crypto/hisilicon/hpre/hpre.h
+++ b/drivers/crypto/hisilicon/hpre/hpre.h
@@ -46,7 +46,6 @@ struct hpre_debug {
 
 struct hpre {
 	struct hisi_qm qm;
-	struct list_head list;
 	struct hpre_debug debug;
 	u32 num_vfs;
 	unsigned long status;
@@ -76,7 +75,7 @@ struct hpre_sqe {
 	__le32 rsvd1[_HPRE_SQE_ALIGN_EXT];
 };
 
-struct hpre *hpre_find_device(int node);
+struct hisi_qp *hpre_create_qp(void);
 int hpre_algs_register(void);
 void hpre_algs_unregister(void);
 
diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index 5d400d6..6542525 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -147,26 +147,18 @@ static void hpre_rm_req_from_ctx(struct hpre_asym_request *hpre_req)
 static struct hisi_qp *hpre_get_qp_and_start(void)
 {
 	struct hisi_qp *qp;
-	struct hpre *hpre;
 	int ret;
 
-	/* find the proper hpre device, which is near the current CPU core */
-	hpre = hpre_find_device(cpu_to_node(smp_processor_id()));
-	if (!hpre) {
-		pr_err("Can not find proper hpre device!\n");
-		return ERR_PTR(-ENODEV);
-	}
-
-	qp = hisi_qm_create_qp(&hpre->qm, 0);
-	if (IS_ERR(qp)) {
-		pci_err(hpre->qm.pdev, "Can not create qp!\n");
+	qp = hpre_create_qp();
+	if (!qp) {
+		pr_err("Can not create hpre qp!\n");
 		return ERR_PTR(-ENODEV);
 	}
 
 	ret = hisi_qm_start_qp(qp, 0);
 	if (ret < 0) {
-		hisi_qm_release_qp(qp);
-		pci_err(hpre->qm.pdev, "Can not start qp!\n");
+		hisi_qm_free_qps(&qp, 1);
+		pci_err(qp->qm->pdev, "Can not start qp!\n");
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -338,7 +330,7 @@ static void hpre_ctx_clear(struct hpre_ctx *ctx, bool is_clear_all)
 	if (is_clear_all) {
 		idr_destroy(&ctx->req_idr);
 		kfree(ctx->req_list);
-		hisi_qm_release_qp(ctx->qp);
+		hisi_qm_free_qps(&ctx->qp, 1);
 	}
 
 	ctx->crt_g2_mode = false;
diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 0ba4a92..88be53b 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -82,8 +82,7 @@
 
 #define HPRE_VIA_MSI_DSM		1
 
-static LIST_HEAD(hpre_list);
-static DEFINE_MUTEX(hpre_list_lock);
+static struct hisi_qm_list hpre_devices;
 static const char hpre_name[] = "hisi_hpre";
 static struct dentry *hpre_debugfs_root;
 static const struct pci_device_id hpre_dev_ids[] = {
@@ -196,43 +195,17 @@ static u32 hpre_pf_q_num = HPRE_PF_DEF_Q_NUM;
 module_param_cb(hpre_pf_q_num, &hpre_pf_q_num_ops, &hpre_pf_q_num, 0444);
 MODULE_PARM_DESC(hpre_pf_q_num, "Number of queues in PF of CS(1-1024)");
 
-static inline void hpre_add_to_list(struct hpre *hpre)
+struct hisi_qp *hpre_create_qp(void)
 {
-	mutex_lock(&hpre_list_lock);
-	list_add_tail(&hpre->list, &hpre_list);
-	mutex_unlock(&hpre_list_lock);
-}
-
-static inline void hpre_remove_from_list(struct hpre *hpre)
-{
-	mutex_lock(&hpre_list_lock);
-	list_del(&hpre->list);
-	mutex_unlock(&hpre_list_lock);
-}
-
-struct hpre *hpre_find_device(int node)
-{
-	struct hpre *hpre, *ret = NULL;
-	int min_distance = INT_MAX;
-	struct device *dev;
-	int dev_node = 0;
+	int node = cpu_to_node(smp_processor_id());
+	struct hisi_qp *qp = NULL;
+	int ret;
 
-	mutex_lock(&hpre_list_lock);
-	list_for_each_entry(hpre, &hpre_list, list) {
-		dev = &hpre->qm.pdev->dev;
-#ifdef CONFIG_NUMA
-		dev_node = dev->numa_node;
-		if (dev_node < 0)
-			dev_node = 0;
-#endif
-		if (node_distance(dev_node, node) < min_distance) {
-			ret = hpre;
-			min_distance = node_distance(dev_node, node);
-		}
-	}
-	mutex_unlock(&hpre_list_lock);
+	ret = hisi_qm_alloc_qps_node(&hpre_devices, 1, 0, node, &qp);
+	if (!ret)
+		return qp;
 
-	return ret;
+	return NULL;
 }
 
 static int hpre_cfg_by_dsm(struct hisi_qm *qm)
@@ -799,17 +772,17 @@ static int hpre_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		dev_warn(&pdev->dev, "init debugfs fail!\n");
 
-	hpre_add_to_list(hpre);
+	hisi_qm_add_to_list(qm, &hpre_devices);
 
 	ret = hpre_algs_register();
 	if (ret < 0) {
-		hpre_remove_from_list(hpre);
 		pci_err(pdev, "fail to register algs to crypto!\n");
 		goto err_with_qm_start;
 	}
 	return 0;
 
 err_with_qm_start:
+	hisi_qm_del_from_list(qm, &hpre_devices);
 	hisi_qm_stop(qm);
 
 err_with_err_init:
@@ -929,7 +902,7 @@ static void hpre_remove(struct pci_dev *pdev)
 	int ret;
 
 	hpre_algs_unregister();
-	hpre_remove_from_list(hpre);
+	hisi_qm_del_from_list(qm, &hpre_devices);
 	if (qm->fun_type == QM_HW_PF && hpre->num_vfs != 0) {
 		ret = hpre_sriov_disable(pdev);
 		if (ret) {
@@ -979,6 +952,7 @@ static int __init hpre_init(void)
 {
 	int ret;
 
+	hisi_qm_init_list(&hpre_devices);
 	hpre_register_debugfs();
 
 	ret = pci_register_driver(&hpre_pci_driver);
-- 
2.7.4


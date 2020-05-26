Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEEC19BC15
	for <lists+linux-crypto@lfdr.de>; Thu,  2 Apr 2020 08:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgDBGyW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 2 Apr 2020 02:54:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728135AbgDBGyW (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 2 Apr 2020 02:54:22 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EAADC46B16608B6628F0;
        Thu,  2 Apr 2020 14:54:03 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 2 Apr 2020 14:53:54 +0800
From:   Shukun Tan <tanshukun1@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <fanghao11@huawei.com>,
        Shukun Tan <tanshukun1@huawei.com>
Subject: [PATCH 1/3] crypto: hisilicon - put vfs_num into struct hisi_qm
Date:   Thu, 2 Apr 2020 14:53:01 +0800
Message-ID: <1585810383-49392-2-git-send-email-tanshukun1@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585810383-49392-1-git-send-email-tanshukun1@huawei.com>
References: <1585810383-49392-1-git-send-email-tanshukun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

We plan to move vfs_num related code into qm.c, put the param
vfs_num into struct hisi_qm first.

Signed-off-by: Shukun Tan <tanshukun1@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre.h      |  1 -
 drivers/crypto/hisilicon/hpre/hpre_main.c | 12 +++++-------
 drivers/crypto/hisilicon/qm.h             |  1 +
 drivers/crypto/hisilicon/sec2/sec.h       |  1 -
 drivers/crypto/hisilicon/sec2/sec_main.c  | 17 ++++++++---------
 drivers/crypto/hisilicon/zip/zip_main.c   | 19 ++++++++-----------
 6 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre.h b/drivers/crypto/hisilicon/hpre/hpre.h
index 03d512e..0a8ba46 100644
--- a/drivers/crypto/hisilicon/hpre/hpre.h
+++ b/drivers/crypto/hisilicon/hpre/hpre.h
@@ -47,7 +47,6 @@ struct hpre_debug {
 struct hpre {
 	struct hisi_qm qm;
 	struct hpre_debug debug;
-	u32 num_vfs;
 	unsigned long status;
 };
 
diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 88be53b..5269e5b 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -354,9 +354,7 @@ static u32 hpre_current_qm_read(struct hpre_debugfs_file *file)
 static int hpre_current_qm_write(struct hpre_debugfs_file *file, u32 val)
 {
 	struct hisi_qm *qm = hpre_file_to_qm(file);
-	struct hpre_debug *debug = file->debug;
-	struct hpre *hpre = container_of(debug, struct hpre, debug);
-	u32 num_vfs = hpre->num_vfs;
+	u32 num_vfs = qm->vfs_num;
 	u32 vfq_num, tmp;
 
 
@@ -827,7 +825,7 @@ static int hpre_vf_q_assign(struct hpre *hpre, int num_vfs)
 static int hpre_clear_vft_config(struct hpre *hpre)
 {
 	struct hisi_qm *qm = &hpre->qm;
-	u32 num_vfs = hpre->num_vfs;
+	u32 num_vfs = qm->vfs_num;
 	int ret;
 	u32 i;
 
@@ -836,7 +834,7 @@ static int hpre_clear_vft_config(struct hpre *hpre)
 		if (ret)
 			return ret;
 	}
-	hpre->num_vfs = 0;
+	qm->vfs_num = 0;
 
 	return 0;
 }
@@ -860,7 +858,7 @@ static int hpre_sriov_enable(struct pci_dev *pdev, int max_vfs)
 		return ret;
 	}
 
-	hpre->num_vfs = num_vfs;
+	hpre->qm.vfs_num = num_vfs;
 
 	ret = pci_enable_sriov(pdev, num_vfs);
 	if (ret) {
@@ -903,7 +901,7 @@ static void hpre_remove(struct pci_dev *pdev)
 
 	hpre_algs_unregister();
 	hisi_qm_del_from_list(qm, &hpre_devices);
-	if (qm->fun_type == QM_HW_PF && hpre->num_vfs != 0) {
+	if (qm->fun_type == QM_HW_PF && qm->vfs_num) {
 		ret = hpre_sriov_disable(pdev);
 		if (ret) {
 			pci_err(pdev, "Disable SRIOV fail!\n");
diff --git a/drivers/crypto/hisilicon/qm.h b/drivers/crypto/hisilicon/qm.h
index ec5b6f4..33c5a8e 100644
--- a/drivers/crypto/hisilicon/qm.h
+++ b/drivers/crypto/hisilicon/qm.h
@@ -161,6 +161,7 @@ struct hisi_qm {
 	u32 qp_num;
 	u32 qp_in_used;
 	u32 ctrl_qp_num;
+	u32 vfs_num;
 	struct list_head list;
 
 	struct qm_dma qdma;
diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index 3598fa1..2326634 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -172,7 +172,6 @@ struct sec_dev {
 	struct sec_debug debug;
 	u32 ctx_q_num;
 	bool iommu_used;
-	u32 num_vfs;
 	unsigned long status;
 };
 
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 1f54ebe..ef26239 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -424,23 +424,22 @@ static u32 sec_current_qm_read(struct sec_debug_file *file)
 static int sec_current_qm_write(struct sec_debug_file *file, u32 val)
 {
 	struct hisi_qm *qm = file->qm;
-	struct sec_dev *sec = container_of(qm, struct sec_dev, qm);
 	u32 vfq_num;
 	u32 tmp;
 
-	if (val > sec->num_vfs)
+	if (val > qm->vfs_num)
 		return -EINVAL;
 
 	/* According PF or VF Dev ID to calculation curr_qm_qp_num and store */
 	if (!val) {
 		qm->debug.curr_qm_qp_num = qm->qp_num;
 	} else {
-		vfq_num = (qm->ctrl_qp_num - qm->qp_num) / sec->num_vfs;
+		vfq_num = (qm->ctrl_qp_num - qm->qp_num) / qm->vfs_num;
 
-		if (val == sec->num_vfs)
+		if (val == qm->vfs_num)
 			qm->debug.curr_qm_qp_num =
 				qm->ctrl_qp_num - qm->qp_num -
-				(sec->num_vfs - 1) * vfq_num;
+				(qm->vfs_num - 1) * vfq_num;
 		else
 			qm->debug.curr_qm_qp_num = vfq_num;
 	}
@@ -926,7 +925,7 @@ static int sec_vf_q_assign(struct sec_dev *sec, u32 num_vfs)
 static int sec_clear_vft_config(struct sec_dev *sec)
 {
 	struct hisi_qm *qm = &sec->qm;
-	u32 num_vfs = sec->num_vfs;
+	u32 num_vfs = qm->vfs_num;
 	int ret;
 	u32 i;
 
@@ -936,7 +935,7 @@ static int sec_clear_vft_config(struct sec_dev *sec)
 			return ret;
 	}
 
-	sec->num_vfs = 0;
+	qm->vfs_num = 0;
 
 	return 0;
 }
@@ -962,7 +961,7 @@ static int sec_sriov_enable(struct pci_dev *pdev, int max_vfs)
 		return ret;
 	}
 
-	sec->num_vfs = num_vfs;
+	sec->qm.vfs_num = num_vfs;
 
 	ret = pci_enable_sriov(pdev, num_vfs);
 	if (ret) {
@@ -1006,7 +1005,7 @@ static void sec_remove(struct pci_dev *pdev)
 
 	hisi_qm_del_from_list(qm, &sec_devices);
 
-	if (qm->fun_type == QM_HW_PF && sec->num_vfs)
+	if (qm->fun_type == QM_HW_PF && qm->vfs_num)
 		(void)sec_sriov_disable(pdev);
 
 	sec_debugfs_exit(sec);
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index fcc85d2..f5ffa02 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -134,7 +134,6 @@ struct ctrl_debug_file {
  * Just relevant for PF.
  */
 struct hisi_zip_ctrl {
-	u32 num_vfs;
 	struct hisi_zip *hisi_zip;
 	struct dentry *debug_root;
 	struct ctrl_debug_file files[HZIP_DEBUG_FILE_NUM];
@@ -342,21 +341,20 @@ static u32 current_qm_read(struct ctrl_debug_file *file)
 static int current_qm_write(struct ctrl_debug_file *file, u32 val)
 {
 	struct hisi_qm *qm = file_to_qm(file);
-	struct hisi_zip_ctrl *ctrl = file->ctrl;
 	u32 vfq_num;
 	u32 tmp;
 
-	if (val > ctrl->num_vfs)
+	if (val > qm->vfs_num)
 		return -EINVAL;
 
 	/* Calculate curr_qm_qp_num and store */
 	if (val == 0) {
 		qm->debug.curr_qm_qp_num = qm->qp_num;
 	} else {
-		vfq_num = (qm->ctrl_qp_num - qm->qp_num) / ctrl->num_vfs;
-		if (val == ctrl->num_vfs)
+		vfq_num = (qm->ctrl_qp_num - qm->qp_num) / qm->vfs_num;
+		if (val == qm->vfs_num)
 			qm->debug.curr_qm_qp_num = qm->ctrl_qp_num -
-				qm->qp_num - (ctrl->num_vfs - 1) * vfq_num;
+				qm->qp_num - (qm->vfs_num - 1) * vfq_num;
 		else
 			qm->debug.curr_qm_qp_num = vfq_num;
 	}
@@ -686,9 +684,8 @@ static int hisi_zip_vf_q_assign(struct hisi_zip *hisi_zip, int num_vfs)
 
 static int hisi_zip_clear_vft_config(struct hisi_zip *hisi_zip)
 {
-	struct hisi_zip_ctrl *ctrl = hisi_zip->ctrl;
 	struct hisi_qm *qm = &hisi_zip->qm;
-	u32 i, num_vfs = ctrl->num_vfs;
+	u32 i, num_vfs = qm->vfs_num;
 	int ret;
 
 	for (i = 1; i <= num_vfs; i++) {
@@ -697,7 +694,7 @@ static int hisi_zip_clear_vft_config(struct hisi_zip *hisi_zip)
 			return ret;
 	}
 
-	ctrl->num_vfs = 0;
+	qm->vfs_num = 0;
 
 	return 0;
 }
@@ -723,7 +720,7 @@ static int hisi_zip_sriov_enable(struct pci_dev *pdev, int max_vfs)
 		return ret;
 	}
 
-	hisi_zip->ctrl->num_vfs = num_vfs;
+	hisi_zip->qm.vfs_num = num_vfs;
 
 	ret = pci_enable_sriov(pdev, num_vfs);
 	if (ret) {
@@ -852,7 +849,7 @@ static void hisi_zip_remove(struct pci_dev *pdev)
 	struct hisi_zip *hisi_zip = pci_get_drvdata(pdev);
 	struct hisi_qm *qm = &hisi_zip->qm;
 
-	if (qm->fun_type == QM_HW_PF && hisi_zip->ctrl->num_vfs != 0)
+	if (qm->fun_type == QM_HW_PF && qm->vfs_num)
 		hisi_zip_sriov_disable(pdev);
 
 	hisi_zip_debugfs_exit(hisi_zip);
-- 
2.7.4


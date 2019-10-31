Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 017CFEAB07
	for <lists+linux-crypto@lfdr.de>; Thu, 31 Oct 2019 08:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfJaHjN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 31 Oct 2019 03:39:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52446 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbfJaHjN (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 31 Oct 2019 03:39:13 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 29B489AF7775EF7F4C1F;
        Thu, 31 Oct 2019 15:39:10 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Thu, 31 Oct 2019 15:39:02 +0800
From:   Zaibo Xu <xuzaibo@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <jonathan.cameron@huawei.com>,
        <liulongfang@huawei.com>, <wangzhou1@hisilicon.com>,
        <linuxarm@huawei.com>, <zhangwei375@huawei.com>,
        <yekai13@huawei.com>, <forest.zhouchang@huawei.com>
Subject: [PATCH 2/5] crypto: hisilicon - add SRIOV for HiSilicon SEC
Date:   Thu, 31 Oct 2019 15:35:27 +0800
Message-ID: <1572507330-34502-3-git-send-email-xuzaibo@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1572507330-34502-1-git-send-email-xuzaibo@huawei.com>
References: <1572507330-34502-1-git-send-email-xuzaibo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

HiSilicon SEC engine supports PCI SRIOV. This patch enable this feature.
User can enable VFs and pass through them to VM, same SEC driver can work
in VM to provide skcipher algorithms.

Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec.h      |   1 +
 drivers/crypto/hisilicon/sec2/sec_main.c | 155 ++++++++++++++++++++++++++++++-
 2 files changed, 153 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index 443b6c5..69b37f2 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -123,6 +123,7 @@ struct sec_dev {
 	struct hisi_qm qm;
 	struct list_head list;
 	u32 ctx_q_num;
+	u32 num_vfs;
 	unsigned long status;
 };
 
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 95d24ed..00dd4c3 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -14,9 +14,11 @@
 
 #include "sec.h"
 
+#define SEC_VF_NUM			63
 #define SEC_QUEUE_NUM_V1		4096
 #define SEC_QUEUE_NUM_V2		1024
 #define SEC_PF_PCI_DEVICE_ID		0xa255
+#define SEC_VF_PCI_DEVICE_ID		0xa256
 
 #define SEC_XTS_MIV_ENABLE_REG		0x301384
 #define SEC_XTS_MIV_ENABLE_MSK		0x7FFFFFFF
@@ -202,6 +204,7 @@ MODULE_PARM_DESC(ctx_q_num, "Number of queue in ctx (2, 4, 6, ..., 1024)");
 
 static const struct pci_device_id sec_dev_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, SEC_PF_PCI_DEVICE_ID) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, SEC_VF_PCI_DEVICE_ID) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, sec_dev_ids);
@@ -225,6 +228,15 @@ static u8 sec_get_endian(struct sec_dev *sec)
 	struct hisi_qm *qm = &sec->qm;
 	u32 reg;
 
+	/*
+	 * As for VF, it is a wrong way to get endian setting by
+	 * reading a register of the engine
+	 */
+	if (qm->pdev->is_virtfn) {
+		dev_err_ratelimited(&qm->pdev->dev,
+				    "cannot access a register in VF!\n");
+		return SEC_LE;
+	}
 	reg = readl_relaxed(qm->io_base + SEC_ENGINE_PF_CFG_OFF +
 			    SEC_ACC_COMMON_REG_OFF + SEC_CONTROL_REG);
 
@@ -376,6 +388,9 @@ static void sec_hw_error_disable(struct sec_dev *sec)
 
 static void sec_hw_error_init(struct sec_dev *sec)
 {
+	if (sec->qm.fun_type == QM_HW_VF)
+		return;
+
 	hisi_qm_hw_error_init(&sec->qm, QM_BASE_CE,
 			      QM_BASE_NFE | QM_ACC_DO_TASK_TIMEOUT
 			      | QM_ACC_WB_NOT_READY_TIMEOUT, 0,
@@ -385,6 +400,9 @@ static void sec_hw_error_init(struct sec_dev *sec)
 
 static void sec_hw_error_uninit(struct sec_dev *sec)
 {
+	if (sec->qm.fun_type == QM_HW_VF)
+		return;
+
 	sec_hw_error_disable(sec);
 	writel(GENMASK(12, 0), sec->qm.io_base + SEC_QM_ABNORMAL_INT_MASK);
 }
@@ -443,10 +461,30 @@ static void sec_qm_uninit(struct hisi_qm *qm)
 
 static int sec_probe_init(struct hisi_qm *qm, struct sec_dev *sec)
 {
-	qm->qp_base = SEC_PF_DEF_Q_BASE;
-	qm->qp_num = pf_q_num;
+	if (qm->fun_type == QM_HW_PF) {
+		qm->qp_base = SEC_PF_DEF_Q_BASE;
+		qm->qp_num = pf_q_num;
+
+		return sec_pf_probe_init(sec);
+	} else if (qm->fun_type == QM_HW_VF) {
+		/*
+		 * have no way to get qm configure in VM in v1 hardware,
+		 * so currently force PF to uses SEC_PF_DEF_Q_NUM, and force
+		 * to trigger only one VF in v1 hardware.
+		 * v2 hardware has no such problem.
+		 */
+		if (qm->ver == QM_HW_V1) {
+			qm->qp_base = SEC_PF_DEF_Q_NUM;
+			qm->qp_num = SEC_QUEUE_NUM_V1 - SEC_PF_DEF_Q_NUM;
+		} else if (qm->ver == QM_HW_V2) {
+			/* v2 starts to support get vft by mailbox */
+			return hisi_qm_get_vft(qm, &qm->qp_base, &qm->qp_num);
+		}
+	} else {
+		return -ENODEV;
+	}
 
-	return sec_pf_probe_init(sec);
+	return 0;
 }
 
 static void sec_probe_uninit(struct sec_dev *sec)
@@ -511,6 +549,110 @@ static int sec_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ret;
 }
 
+/* now we only support equal assignment */
+static int sec_vf_q_assign(struct sec_dev *sec, u32 num_vfs)
+{
+	struct hisi_qm *qm = &sec->qm;
+	u32 qp_num = qm->qp_num;
+	u32 q_base = qp_num;
+	u32 q_num, remain_q_num;
+	int i, j, ret;
+
+	if (!num_vfs)
+		return -EINVAL;
+
+	remain_q_num = qm->ctrl_qp_num - qp_num;
+	q_num = remain_q_num / num_vfs;
+
+	for (i = 1; i <= num_vfs; i++) {
+		if (i == num_vfs)
+			q_num += remain_q_num % num_vfs;
+		ret = hisi_qm_set_vft(qm, i, q_base, q_num);
+		if (ret) {
+			for (j = i; j > 0; j--)
+				hisi_qm_set_vft(qm, j, 0, 0);
+			return ret;
+		}
+		q_base += q_num;
+	}
+
+	return 0;
+}
+
+static int sec_clear_vft_config(struct sec_dev *sec)
+{
+	struct hisi_qm *qm = &sec->qm;
+	u32 num_vfs = sec->num_vfs;
+	int ret;
+	u32 i;
+
+	for (i = 1; i <= num_vfs; i++) {
+		ret = hisi_qm_set_vft(qm, i, 0, 0);
+		if (ret)
+			return ret;
+	}
+
+	sec->num_vfs = 0;
+
+	return 0;
+}
+
+static int sec_sriov_enable(struct pci_dev *pdev, int max_vfs)
+{
+	struct sec_dev *sec = pci_get_drvdata(pdev);
+	int pre_existing_vfs, ret;
+	u32 num_vfs;
+
+	pre_existing_vfs = pci_num_vf(pdev);
+
+	if (pre_existing_vfs) {
+		pci_err(pdev, "Can't enable VF. Please disable at first!\n");
+		return 0;
+	}
+
+	num_vfs = min_t(u32, max_vfs, SEC_VF_NUM);
+
+	ret = sec_vf_q_assign(sec, num_vfs);
+	if (ret) {
+		pci_err(pdev, "Can't assign queues for VF!\n");
+		return ret;
+	}
+
+	sec->num_vfs = num_vfs;
+
+	ret = pci_enable_sriov(pdev, num_vfs);
+	if (ret) {
+		pci_err(pdev, "Can't enable VF!\n");
+		sec_clear_vft_config(sec);
+		return ret;
+	}
+
+	return num_vfs;
+}
+
+static int sec_sriov_disable(struct pci_dev *pdev)
+{
+	struct sec_dev *sec = pci_get_drvdata(pdev);
+
+	if (pci_vfs_assigned(pdev)) {
+		pci_err(pdev, "Can't disable VFs while VFs are assigned!\n");
+		return -EPERM;
+	}
+
+	/* remove in sec_pci_driver will be called to free VF resources */
+	pci_disable_sriov(pdev);
+
+	return sec_clear_vft_config(sec);
+}
+
+static int sec_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	if (num_vfs)
+		return sec_sriov_enable(pdev, num_vfs);
+	else
+		return sec_sriov_disable(pdev);
+}
+
 static void sec_remove(struct pci_dev *pdev)
 {
 	struct sec_dev *sec = pci_get_drvdata(pdev);
@@ -520,6 +662,9 @@ static void sec_remove(struct pci_dev *pdev)
 
 	sec_remove_from_list(sec);
 
+	if (qm->fun_type == QM_HW_PF && sec->num_vfs)
+		(void)sec_sriov_disable(pdev);
+
 	(void)hisi_qm_stop(qm);
 
 	sec_probe_uninit(sec);
@@ -593,6 +738,9 @@ static pci_ers_result_t sec_process_hw_error(struct pci_dev *pdev)
 static pci_ers_result_t sec_error_detected(struct pci_dev *pdev,
 					   pci_channel_state_t state)
 {
+	if (pdev->is_virtfn)
+		return PCI_ERS_RESULT_NONE;
+
 	pci_info(pdev, "PCI error detected, state(=%d)!!\n", state);
 	if (state == pci_channel_io_perm_failure)
 		return PCI_ERS_RESULT_DISCONNECT;
@@ -610,6 +758,7 @@ static struct pci_driver sec_pci_driver = {
 	.probe = sec_probe,
 	.remove = sec_remove,
 	.err_handler = &sec_err_handler,
+	.sriov_configure = sec_sriov_configure,
 };
 
 static int __init sec_init(void)
-- 
2.8.1


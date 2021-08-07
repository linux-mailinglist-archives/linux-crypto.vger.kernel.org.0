Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CB13E34CF
	for <lists+linux-crypto@lfdr.de>; Sat,  7 Aug 2021 12:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhHGKgh (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 7 Aug 2021 06:36:37 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:16992 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhHGKgg (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 7 Aug 2021 06:36:36 -0400
Received: from dggeme768-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ghdvs3Yq8zZxlS;
        Sat,  7 Aug 2021 18:32:41 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 dggeme768-chm.china.huawei.com (10.3.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 7 Aug 2021 18:36:17 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>
Subject: [PATCH 2/5] crypto: hisilicon - add runtime PM ops
Date:   Sat, 7 Aug 2021 18:32:33 +0800
Message-ID: <1628332356-33278-3-git-send-email-qianweili@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1628332356-33278-1-git-send-email-qianweili@huawei.com>
References: <1628332356-33278-1-git-send-email-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme768-chm.china.huawei.com (10.3.19.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Accelerator devices support runtime PM to reduce power consumption.
This patch adds the runtime PM suspend/resume callbacks to the
accelerator devices.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 118 ++++++++++++++++++++++++++++++++++++++++++
 drivers/crypto/hisilicon/qm.h |   2 +
 2 files changed, 120 insertions(+)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index e417cd0..dbe162a 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -5692,6 +5692,124 @@ int hisi_qm_init(struct hisi_qm *qm)
 }
 EXPORT_SYMBOL_GPL(hisi_qm_init);
 
+
+static int qm_prepare_for_suspend(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+	int ret;
+	u32 val;
+
+	ret = qm->ops->set_msi(qm, false);
+	if (ret) {
+		pci_err(pdev, "failed to disable MSI before suspending!\n");
+		return ret;
+	}
+
+	/* shutdown OOO register */
+	writel(ACC_MASTER_GLOBAL_CTRL_SHUTDOWN,
+	       qm->io_base + ACC_MASTER_GLOBAL_CTRL);
+
+	ret = readl_relaxed_poll_timeout(qm->io_base + ACC_MASTER_TRANS_RETURN,
+					 val,
+					 (val == ACC_MASTER_TRANS_RETURN_RW),
+					 POLL_PERIOD, POLL_TIMEOUT);
+	if (ret) {
+		pci_emerg(pdev, "Bus lock! Please reset system.\n");
+		return ret;
+	}
+
+	ret = qm_set_pf_mse(qm, false);
+	if (ret)
+		pci_err(pdev, "failed to disable MSE before suspending!\n");
+
+	return ret;
+}
+
+static int qm_rebuild_for_resume(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+	int ret;
+
+	ret = qm_set_pf_mse(qm, true);
+	if (ret) {
+		pci_err(pdev, "failed to enable MSE after resuming!\n");
+		return ret;
+	}
+
+	ret = qm->ops->set_msi(qm, true);
+	if (ret) {
+		pci_err(pdev, "failed to enable MSI after resuming!\n");
+		return ret;
+	}
+
+	ret = qm_dev_hw_init(qm);
+	if (ret) {
+		pci_err(pdev, "failed to init device after resuming\n");
+		return ret;
+	}
+
+	qm_cmd_init(qm);
+	hisi_qm_dev_err_init(qm);
+
+	return 0;
+}
+
+/**
+ * hisi_qm_suspend() - Runtime suspend of given device.
+ * @dev: device to suspend.
+ *
+ * Function that suspend the device.
+ */
+int hisi_qm_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct hisi_qm *qm = pci_get_drvdata(pdev);
+	int ret;
+
+	pci_info(pdev, "entering suspended state\n");
+
+	ret = hisi_qm_stop(qm, QM_NORMAL);
+	if (ret) {
+		pci_err(pdev, "failed to stop qm(%d)\n", ret);
+		return ret;
+	}
+
+	ret = qm_prepare_for_suspend(qm);
+	if (ret)
+		pci_err(pdev, "failed to prepare suspended(%d)\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hisi_qm_suspend);
+
+/**
+ * hisi_qm_resume() - Runtime resume of given device.
+ * @dev: device to resume.
+ *
+ * Function that resume the device.
+ */
+int hisi_qm_resume(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct hisi_qm *qm = pci_get_drvdata(pdev);
+	int ret;
+
+	pci_info(pdev, "resuming from suspend state\n");
+
+	ret = qm_rebuild_for_resume(qm);
+	if (ret) {
+		pci_err(pdev, "failed to rebuild resume(%d)\n", ret);
+		return ret;
+	}
+
+	ret = hisi_qm_start(qm);
+	if (ret)
+		pci_err(pdev, "failed to start qm(%d)\n", ret);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hisi_qm_resume);
+
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Zhou Wang <wangzhou1@hisilicon.com>");
 MODULE_DESCRIPTION("HiSilicon Accelerator queue manager driver");
diff --git a/drivers/crypto/hisilicon/qm.h b/drivers/crypto/hisilicon/qm.h
index 0e5df1c..59e1646 100644
--- a/drivers/crypto/hisilicon/qm.h
+++ b/drivers/crypto/hisilicon/qm.h
@@ -431,5 +431,7 @@ void hisi_qm_dev_shutdown(struct pci_dev *pdev);
 void hisi_qm_wait_task_finish(struct hisi_qm *qm, struct hisi_qm_list *qm_list);
 int hisi_qm_alg_register(struct hisi_qm *qm, struct hisi_qm_list *qm_list);
 void hisi_qm_alg_unregister(struct hisi_qm *qm, struct hisi_qm_list *qm_list);
+int hisi_qm_resume(struct device *dev);
+int hisi_qm_suspend(struct device *dev);
 void hisi_qm_regs_dump(struct seq_file *s, struct debugfs_regset32 *regset);
 #endif
-- 
2.8.1


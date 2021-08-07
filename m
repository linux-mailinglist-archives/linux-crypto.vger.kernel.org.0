Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EC03E34D2
	for <lists+linux-crypto@lfdr.de>; Sat,  7 Aug 2021 12:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhHGKgu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 7 Aug 2021 06:36:50 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7807 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhHGKgh (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 7 Aug 2021 06:36:37 -0400
Received: from dggeme768-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ghdzq5MJzzYdDR;
        Sat,  7 Aug 2021 18:36:07 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 dggeme768-chm.china.huawei.com (10.3.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 7 Aug 2021 18:36:17 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>
Subject: [PATCH 3/5] crypto: hisilicon - support runtime PM for accelerator device
Date:   Sat, 7 Aug 2021 18:32:34 +0800
Message-ID: <1628332356-33278-4-git-send-email-qianweili@huawei.com>
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

Add runtime PM support for Kunpeng930 accelerator device.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c |  35 ++++-
 drivers/crypto/hisilicon/qm.c             | 218 +++++++++++++++++++++++++++---
 drivers/crypto/hisilicon/qm.h             |   4 +
 drivers/crypto/hisilicon/sec2/sec_main.c  |  36 ++++-
 drivers/crypto/hisilicon/zip/zip_main.c   |  34 ++++-
 5 files changed, 297 insertions(+), 30 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index df302e0..2819b4e 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include <linux/topology.h>
 #include <linux/uacce.h>
 #include "hpre.h"
@@ -595,10 +596,15 @@ static ssize_t hpre_ctrl_debug_read(struct file *filp, char __user *buf,
 				    size_t count, loff_t *pos)
 {
 	struct hpre_debugfs_file *file = filp->private_data;
+	struct hisi_qm *qm = hpre_file_to_qm(file);
 	char tbuf[HPRE_DBGFS_VAL_MAX_LEN];
 	u32 val;
 	int ret;
 
+	ret = hisi_qm_get_dfx_access(qm);
+	if (ret)
+		return ret;
+
 	spin_lock_irq(&file->lock);
 	switch (file->type) {
 	case HPRE_CLEAR_ENABLE:
@@ -608,18 +614,25 @@ static ssize_t hpre_ctrl_debug_read(struct file *filp, char __user *buf,
 		val = hpre_cluster_inqry_read(file);
 		break;
 	default:
-		spin_unlock_irq(&file->lock);
-		return -EINVAL;
+		goto err_input;
 	}
 	spin_unlock_irq(&file->lock);
+
+	hisi_qm_put_dfx_access(qm);
 	ret = snprintf(tbuf, HPRE_DBGFS_VAL_MAX_LEN, "%u\n", val);
 	return simple_read_from_buffer(buf, count, pos, tbuf, ret);
+
+err_input:
+	spin_unlock_irq(&file->lock);
+	hisi_qm_put_dfx_access(qm);
+	return -EINVAL;
 }
 
 static ssize_t hpre_ctrl_debug_write(struct file *filp, const char __user *buf,
 				     size_t count, loff_t *pos)
 {
 	struct hpre_debugfs_file *file = filp->private_data;
+	struct hisi_qm *qm = hpre_file_to_qm(file);
 	char tbuf[HPRE_DBGFS_VAL_MAX_LEN];
 	unsigned long val;
 	int len, ret;
@@ -639,6 +652,10 @@ static ssize_t hpre_ctrl_debug_write(struct file *filp, const char __user *buf,
 	if (kstrtoul(tbuf, 0, &val))
 		return -EFAULT;
 
+	ret = hisi_qm_get_dfx_access(qm);
+	if (ret)
+		return ret;
+
 	spin_lock_irq(&file->lock);
 	switch (file->type) {
 	case HPRE_CLEAR_ENABLE:
@@ -655,12 +672,12 @@ static ssize_t hpre_ctrl_debug_write(struct file *filp, const char __user *buf,
 		ret = -EINVAL;
 		goto err_input;
 	}
-	spin_unlock_irq(&file->lock);
 
-	return count;
+	ret = count;
 
 err_input:
 	spin_unlock_irq(&file->lock);
+	hisi_qm_put_dfx_access(qm);
 	return ret;
 }
 
@@ -755,6 +772,7 @@ static int hpre_pf_comm_regs_debugfs_init(struct hisi_qm *qm)
 	regset->regs = hpre_com_dfx_regs;
 	regset->nregs = ARRAY_SIZE(hpre_com_dfx_regs);
 	regset->base = qm->io_base;
+	regset->dev = dev;
 
 	debugfs_create_file("regs", 0444, qm->debug.debug_root,
 			    regset, &hpre_com_regs_fops);
@@ -784,6 +802,7 @@ static int hpre_cluster_debugfs_init(struct hisi_qm *qm)
 		regset->regs = hpre_cluster_dfx_regs;
 		regset->nregs = ARRAY_SIZE(hpre_cluster_dfx_regs);
 		regset->base = qm->io_base + hpre_cluster_offsets[i];
+		regset->dev = dev;
 
 		debugfs_create_file("regs", 0444, tmp_d, regset,
 				    &hpre_cluster_regs_fops);
@@ -1038,6 +1057,8 @@ static int hpre_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			goto err_with_alg_register;
 	}
 
+	hisi_qm_pm_init(qm);
+
 	return 0;
 
 err_with_alg_register:
@@ -1061,6 +1082,7 @@ static void hpre_remove(struct pci_dev *pdev)
 	struct hisi_qm *qm = pci_get_drvdata(pdev);
 	int ret;
 
+	hisi_qm_pm_uninit(qm);
 	hisi_qm_wait_task_finish(qm, &hpre_devices);
 	hisi_qm_alg_unregister(qm, &hpre_devices);
 	if (qm->fun_type == QM_HW_PF && qm->vfs_num) {
@@ -1083,6 +1105,10 @@ static void hpre_remove(struct pci_dev *pdev)
 	hisi_qm_uninit(qm);
 }
 
+const struct dev_pm_ops hpre_pm_ops = {
+	SET_RUNTIME_PM_OPS(hisi_qm_suspend, hisi_qm_resume, NULL)
+};
+
 static const struct pci_error_handlers hpre_err_handler = {
 	.error_detected		= hisi_qm_dev_err_detected,
 	.slot_reset		= hisi_qm_dev_slot_reset,
@@ -1099,6 +1125,7 @@ static struct pci_driver hpre_pci_driver = {
 				  hisi_qm_sriov_configure : NULL,
 	.err_handler		= &hpre_err_handler,
 	.shutdown		= hisi_qm_dev_shutdown,
+	.driver.pm		= &hpre_pm_ops,
 };
 
 static void hpre_register_debugfs(void)
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index dbe162a..7474003 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <linux/irqreturn.h>
 #include <linux/log2.h>
+#include <linux/pm_runtime.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/uacce.h>
@@ -269,6 +270,8 @@
 #define QM_QOS_MAX_CIR_S		11
 #define QM_QOS_VAL_MAX_LEN		32
 
+#define QM_AUTOSUSPEND_DELAY		3000
+
 #define QM_MK_CQC_DW3_V1(hop_num, pg_sz, buf_sz, cqe_sz) \
 	(((hop_num) << QM_CQ_HOP_NUM_SHIFT)	| \
 	((pg_sz) << QM_CQ_PAGE_SIZE_SHIFT)	| \
@@ -733,6 +736,34 @@ static u32 qm_get_irq_num_v3(struct hisi_qm *qm)
 	return QM_IRQ_NUM_VF_V3;
 }
 
+static int qm_pm_get_sync(struct hisi_qm *qm)
+{
+	struct device *dev = &qm->pdev->dev;
+	int ret;
+
+	if (qm->fun_type == QM_HW_VF || qm->ver < QM_HW_V3)
+		return 0;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0) {
+		dev_err(dev, "failed to get_sync(%d).\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void qm_pm_put_sync(struct hisi_qm *qm)
+{
+	struct device *dev = &qm->pdev->dev;
+
+	if (qm->fun_type == QM_HW_VF || qm->ver < QM_HW_V3)
+		return;
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+}
+
 static struct hisi_qp *qm_to_hisi_qp(struct hisi_qm *qm, struct qm_eqe *eqe)
 {
 	u16 cqn = le32_to_cpu(eqe->dw0) & QM_EQE_CQN_MASK;
@@ -1258,10 +1289,15 @@ static ssize_t qm_debug_read(struct file *filp, char __user *buf,
 {
 	struct debugfs_file *file = filp->private_data;
 	enum qm_debug_file index = file->index;
+	struct hisi_qm *qm = file_to_qm(file);
 	char tbuf[QM_DBG_TMP_BUF_LEN];
 	u32 val;
 	int ret;
 
+	ret = hisi_qm_get_dfx_access(qm);
+	if (ret)
+		return ret;
+
 	mutex_lock(&file->lock);
 	switch (index) {
 	case CURRENT_QM:
@@ -1274,13 +1310,18 @@ static ssize_t qm_debug_read(struct file *filp, char __user *buf,
 		val = clear_enable_read(file);
 		break;
 	default:
-		mutex_unlock(&file->lock);
-		return -EINVAL;
+		goto err_input;
 	}
 	mutex_unlock(&file->lock);
 
+	hisi_qm_put_dfx_access(qm);
 	ret = scnprintf(tbuf, QM_DBG_TMP_BUF_LEN, "%u\n", val);
 	return simple_read_from_buffer(buf, count, pos, tbuf, ret);
+
+err_input:
+	mutex_unlock(&file->lock);
+	hisi_qm_put_dfx_access(qm);
+	return -EINVAL;
 }
 
 static ssize_t qm_debug_write(struct file *filp, const char __user *buf,
@@ -1288,6 +1329,7 @@ static ssize_t qm_debug_write(struct file *filp, const char __user *buf,
 {
 	struct debugfs_file *file = filp->private_data;
 	enum qm_debug_file index = file->index;
+	struct hisi_qm *qm = file_to_qm(file);
 	unsigned long val;
 	char tbuf[QM_DBG_TMP_BUF_LEN];
 	int len, ret;
@@ -1307,6 +1349,10 @@ static ssize_t qm_debug_write(struct file *filp, const char __user *buf,
 	if (kstrtoul(tbuf, 0, &val))
 		return -EFAULT;
 
+	ret = hisi_qm_get_dfx_access(qm);
+	if (ret)
+		return ret;
+
 	mutex_lock(&file->lock);
 	switch (index) {
 	case CURRENT_QM:
@@ -1323,6 +1369,8 @@ static ssize_t qm_debug_write(struct file *filp, const char __user *buf,
 	}
 	mutex_unlock(&file->lock);
 
+	hisi_qm_put_dfx_access(qm);
+
 	if (ret)
 		return ret;
 
@@ -1378,15 +1426,23 @@ static const struct debugfs_reg32 qm_vf_dfx_regs[] = {
  */
 void hisi_qm_regs_dump(struct seq_file *s, struct debugfs_regset32 *regset)
 {
+	struct pci_dev *pdev = to_pci_dev(regset->dev);
+	struct hisi_qm *qm = pci_get_drvdata(pdev);
 	const struct debugfs_reg32 *regs = regset->regs;
 	int regs_len = regset->nregs;
+	int i, ret;
 	u32 val;
-	int i;
+
+	ret = hisi_qm_get_dfx_access(qm);
+	if (ret)
+		return;
 
 	for (i = 0; i < regs_len; i++) {
 		val = readl(regset->base + regs[i].offset);
 		seq_printf(s, "%s= 0x%08x\n", regs[i].name, val);
 	}
+
+	hisi_qm_put_dfx_access(qm);
 }
 EXPORT_SYMBOL_GPL(hisi_qm_regs_dump);
 
@@ -1404,6 +1460,8 @@ static int qm_regs_show(struct seq_file *s, void *unused)
 	}
 
 	regset.base = qm->io_base;
+	regset.dev = &qm->pdev->dev;
+
 	hisi_qm_regs_dump(s, &regset);
 
 	return 0;
@@ -1835,16 +1893,24 @@ static ssize_t qm_cmd_write(struct file *filp, const char __user *buffer,
 	if (*pos)
 		return 0;
 
+	ret = hisi_qm_get_dfx_access(qm);
+	if (ret)
+		return ret;
+
 	/* Judge if the instance is being reset. */
 	if (unlikely(atomic_read(&qm->status.flags) == QM_STOP))
 		return 0;
 
-	if (count > QM_DBG_WRITE_LEN)
-		return -ENOSPC;
+	if (count > QM_DBG_WRITE_LEN) {
+		ret = -ENOSPC;
+		goto put_dfx_access;
+	}
 
 	cmd_buf = memdup_user_nul(buffer, count);
-	if (IS_ERR(cmd_buf))
-		return PTR_ERR(cmd_buf);
+	if (IS_ERR(cmd_buf)) {
+		ret = PTR_ERR(cmd_buf);
+		goto put_dfx_access;
+	}
 
 	cmd_buf_tmp = strchr(cmd_buf, '\n');
 	if (cmd_buf_tmp) {
@@ -1855,12 +1921,16 @@ static ssize_t qm_cmd_write(struct file *filp, const char __user *buffer,
 	ret = qm_cmd_write_dump(qm, cmd_buf);
 	if (ret) {
 		kfree(cmd_buf);
-		return ret;
+		goto put_dfx_access;
 	}
 
 	kfree(cmd_buf);
 
-	return count;
+	ret = count;
+
+put_dfx_access:
+	hisi_qm_put_dfx_access(qm);
+	return ret;
 }
 
 static const struct file_operations qm_cmd_fops = {
@@ -2457,11 +2527,19 @@ static struct hisi_qp *qm_create_qp_nolock(struct hisi_qm *qm, u8 alg_type)
 struct hisi_qp *hisi_qm_create_qp(struct hisi_qm *qm, u8 alg_type)
 {
 	struct hisi_qp *qp;
+	int ret;
+
+	ret = qm_pm_get_sync(qm);
+	if (ret)
+		return ERR_PTR(ret);
 
 	down_write(&qm->qps_lock);
 	qp = qm_create_qp_nolock(qm, alg_type);
 	up_write(&qm->qps_lock);
 
+	if (IS_ERR(qp))
+		qm_pm_put_sync(qm);
+
 	return qp;
 }
 EXPORT_SYMBOL_GPL(hisi_qm_create_qp);
@@ -2487,6 +2565,8 @@ void hisi_qm_release_qp(struct hisi_qp *qp)
 	idr_remove(&qm->qp_idr, qp->qp_id);
 
 	up_write(&qm->qps_lock);
+
+	qm_pm_put_sync(qm);
 }
 EXPORT_SYMBOL_GPL(hisi_qm_release_qp);
 
@@ -4069,10 +4149,15 @@ static ssize_t qm_algqos_read(struct file *filp, char __user *buf,
 	u32 qos_val, ir;
 	int ret;
 
+	ret = hisi_qm_get_dfx_access(qm);
+	if (ret)
+		return ret;
+
 	/* Mailbox and reset cannot be operated at the same time */
 	if (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
 		pci_err(qm->pdev, "dev resetting, read alg qos failed!\n");
-		return  -EAGAIN;
+		ret = -EAGAIN;
+		goto err_put_dfx_access;
 	}
 
 	if (qm->fun_type == QM_HW_PF) {
@@ -4091,6 +4176,8 @@ static ssize_t qm_algqos_read(struct file *filp, char __user *buf,
 
 err_get_status:
 	clear_bit(QM_RESETTING, &qm->misc_ctl);
+err_put_dfx_access:
+	hisi_qm_put_dfx_access(qm);
 	return ret;
 }
 
@@ -4171,15 +4258,23 @@ static ssize_t qm_algqos_write(struct file *filp, const char __user *buf,
 
 	fun_index = device * 8 + function;
 
+	ret = qm_pm_get_sync(qm);
+	if (ret) {
+		ret = -EINVAL;
+		goto err_get_status;
+	}
+
 	ret = qm_func_shaper_enable(qm, fun_index, val);
 	if (ret) {
 		pci_err(qm->pdev, "failed to enable function shaper!\n");
 		ret = -EINVAL;
-		goto err_get_status;
+		goto err_put_sync;
 	}
 
-	ret =  count;
+	ret = count;
 
+err_put_sync:
+	qm_pm_put_sync(qm);
 err_get_status:
 	clear_bit(QM_RESETTING, &qm->misc_ctl);
 	return ret;
@@ -4299,19 +4394,23 @@ int hisi_qm_sriov_enable(struct pci_dev *pdev, int max_vfs)
 	struct hisi_qm *qm = pci_get_drvdata(pdev);
 	int pre_existing_vfs, num_vfs, total_vfs, ret;
 
+	ret = qm_pm_get_sync(qm);
+	if (ret)
+		return ret;
+
 	total_vfs = pci_sriov_get_totalvfs(pdev);
 	pre_existing_vfs = pci_num_vf(pdev);
 	if (pre_existing_vfs) {
 		pci_err(pdev, "%d VFs already enabled. Please disable pre-enabled VFs!\n",
 			pre_existing_vfs);
-		return 0;
+		goto err_put_sync;
 	}
 
 	num_vfs = min_t(int, max_vfs, total_vfs);
 	ret = qm_vf_q_assign(qm, num_vfs);
 	if (ret) {
 		pci_err(pdev, "Can't assign queues for VF!\n");
-		return ret;
+		goto err_put_sync;
 	}
 
 	qm->vfs_num = num_vfs;
@@ -4320,12 +4419,16 @@ int hisi_qm_sriov_enable(struct pci_dev *pdev, int max_vfs)
 	if (ret) {
 		pci_err(pdev, "Can't enable VF!\n");
 		qm_clear_vft_config(qm);
-		return ret;
+		goto err_put_sync;
 	}
 
 	pci_info(pdev, "VF enabled, vfs_num(=%d)!\n", num_vfs);
 
 	return num_vfs;
+
+err_put_sync:
+	qm_pm_put_sync(qm);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(hisi_qm_sriov_enable);
 
@@ -4340,6 +4443,7 @@ int hisi_qm_sriov_disable(struct pci_dev *pdev, bool is_frozen)
 {
 	struct hisi_qm *qm = pci_get_drvdata(pdev);
 	int total_vfs = pci_sriov_get_totalvfs(qm->pdev);
+	int ret;
 
 	if (pci_vfs_assigned(pdev)) {
 		pci_err(pdev, "Failed to disable VFs as VFs are assigned!\n");
@@ -4355,8 +4459,13 @@ int hisi_qm_sriov_disable(struct pci_dev *pdev, bool is_frozen)
 	pci_disable_sriov(pdev);
 	/* clear vf function shaper configure array */
 	memset(qm->factor + 1, 0, sizeof(struct qm_shaper_factor) * total_vfs);
+	ret = qm_clear_vft_config(qm);
+	if (ret)
+		return ret;
+
+	qm_pm_put_sync(qm);
 
-	return qm_clear_vft_config(qm);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(hisi_qm_sriov_disable);
 
@@ -5176,11 +5285,18 @@ static void hisi_qm_controller_reset(struct work_struct *rst_work)
 	struct hisi_qm *qm = container_of(rst_work, struct hisi_qm, rst_work);
 	int ret;
 
+	ret = qm_pm_get_sync(qm);
+	if (ret) {
+		clear_bit(QM_RST_SCHED, &qm->misc_ctl);
+		return;
+	}
+
 	/* reset pcie device controller */
 	ret = qm_controller_reset(qm);
 	if (ret)
 		dev_err(&qm->pdev->dev, "controller reset failed (%d)\n", ret);
 
+	qm_pm_put_sync(qm);
 }
 
 static void qm_pf_reset_vf_prepare(struct hisi_qm *qm,
@@ -5692,6 +5808,76 @@ int hisi_qm_init(struct hisi_qm *qm)
 }
 EXPORT_SYMBOL_GPL(hisi_qm_init);
 
+/**
+ * hisi_qm_get_dfx_access() - Try to get dfx access.
+ * @qm: pointer to accelerator device.
+ *
+ * Try to get dfx access, then user can get message.
+ *
+ * If device is in suspended, return failure, otherwise
+ * bump up the runtime PM usage counter.
+ */
+int hisi_qm_get_dfx_access(struct hisi_qm *qm)
+{
+	struct device *dev = &qm->pdev->dev;
+
+	if (pm_runtime_suspended(dev)) {
+		dev_info(dev, "can not read/write - device in suspended.\n");
+		return -EAGAIN;
+	}
+
+	return qm_pm_get_sync(qm);
+}
+EXPORT_SYMBOL_GPL(hisi_qm_get_dfx_access);
+
+/**
+ * hisi_qm_put_dfx_access() - Put dfx access.
+ * @qm: pointer to accelerator device.
+ *
+ * Put dfx access, drop runtime PM usage counter.
+ */
+void hisi_qm_put_dfx_access(struct hisi_qm *qm)
+{
+	qm_pm_put_sync(qm);
+}
+EXPORT_SYMBOL_GPL(hisi_qm_put_dfx_access);
+
+/**
+ * hisi_qm_pm_init() - Initialize qm runtime PM.
+ * @qm: pointer to accelerator device.
+ *
+ * Function that initialize qm runtime PM.
+ */
+void hisi_qm_pm_init(struct hisi_qm *qm)
+{
+	struct device *dev = &qm->pdev->dev;
+
+	if (qm->fun_type == QM_HW_VF || qm->ver < QM_HW_V3)
+		return;
+
+	pm_runtime_set_autosuspend_delay(dev, QM_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_put_noidle(dev);
+}
+EXPORT_SYMBOL_GPL(hisi_qm_pm_init);
+
+/**
+ * hisi_qm_pm_uninit() - Uninitialize qm runtime PM.
+ * @qm: pointer to accelerator device.
+ *
+ * Function that uninitialize qm runtime PM.
+ */
+void hisi_qm_pm_uninit(struct hisi_qm *qm)
+{
+	struct device *dev = &qm->pdev->dev;
+
+	if (qm->fun_type == QM_HW_VF || qm->ver < QM_HW_V3)
+		return;
+
+	pm_runtime_get_noresume(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+}
+EXPORT_SYMBOL_GPL(hisi_qm_pm_uninit);
 
 static int qm_prepare_for_suspend(struct hisi_qm *qm)
 {
diff --git a/drivers/crypto/hisilicon/qm.h b/drivers/crypto/hisilicon/qm.h
index 59e1646..3068093 100644
--- a/drivers/crypto/hisilicon/qm.h
+++ b/drivers/crypto/hisilicon/qm.h
@@ -433,5 +433,9 @@ int hisi_qm_alg_register(struct hisi_qm *qm, struct hisi_qm_list *qm_list);
 void hisi_qm_alg_unregister(struct hisi_qm *qm, struct hisi_qm_list *qm_list);
 int hisi_qm_resume(struct device *dev);
 int hisi_qm_suspend(struct device *dev);
+void hisi_qm_pm_uninit(struct hisi_qm *qm);
+void hisi_qm_pm_init(struct hisi_qm *qm);
+int hisi_qm_get_dfx_access(struct hisi_qm *qm);
+void hisi_qm_put_dfx_access(struct hisi_qm *qm);
 void hisi_qm_regs_dump(struct seq_file *s, struct debugfs_regset32 *regset);
 #endif
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index bc9b766..aafa627 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include <linux/seq_file.h>
 #include <linux/topology.h>
 #include <linux/uacce.h>
@@ -561,9 +562,14 @@ static ssize_t sec_debug_read(struct file *filp, char __user *buf,
 {
 	struct sec_debug_file *file = filp->private_data;
 	char tbuf[SEC_DBGFS_VAL_MAX_LEN];
+	struct hisi_qm *qm = file->qm;
 	u32 val;
 	int ret;
 
+	ret = hisi_qm_get_dfx_access(qm);
+	if (ret)
+		return ret;
+
 	spin_lock_irq(&file->lock);
 
 	switch (file->index) {
@@ -571,14 +577,19 @@ static ssize_t sec_debug_read(struct file *filp, char __user *buf,
 		val = sec_clear_enable_read(file);
 		break;
 	default:
-		spin_unlock_irq(&file->lock);
-		return -EINVAL;
+		goto err_input;
 	}
 
 	spin_unlock_irq(&file->lock);
-	ret = snprintf(tbuf, SEC_DBGFS_VAL_MAX_LEN, "%u\n", val);
 
+	hisi_qm_put_dfx_access(qm);
+	ret = snprintf(tbuf, SEC_DBGFS_VAL_MAX_LEN, "%u\n", val);
 	return simple_read_from_buffer(buf, count, pos, tbuf, ret);
+
+err_input:
+	spin_unlock_irq(&file->lock);
+	hisi_qm_put_dfx_access(qm);
+	return -EINVAL;
 }
 
 static ssize_t sec_debug_write(struct file *filp, const char __user *buf,
@@ -586,6 +597,7 @@ static ssize_t sec_debug_write(struct file *filp, const char __user *buf,
 {
 	struct sec_debug_file *file = filp->private_data;
 	char tbuf[SEC_DBGFS_VAL_MAX_LEN];
+	struct hisi_qm *qm = file->qm;
 	unsigned long val;
 	int len, ret;
 
@@ -604,6 +616,10 @@ static ssize_t sec_debug_write(struct file *filp, const char __user *buf,
 	if (kstrtoul(tbuf, 0, &val))
 		return -EFAULT;
 
+	ret = hisi_qm_get_dfx_access(qm);
+	if (ret)
+		return ret;
+
 	spin_lock_irq(&file->lock);
 
 	switch (file->index) {
@@ -617,12 +633,11 @@ static ssize_t sec_debug_write(struct file *filp, const char __user *buf,
 		goto err_input;
 	}
 
-	spin_unlock_irq(&file->lock);
-
-	return count;
+	ret = count;
 
  err_input:
 	spin_unlock_irq(&file->lock);
+	hisi_qm_put_dfx_access(qm);
 	return ret;
 }
 
@@ -680,6 +695,7 @@ static int sec_core_debug_init(struct hisi_qm *qm)
 	regset->regs = sec_dfx_regs;
 	regset->nregs = ARRAY_SIZE(sec_dfx_regs);
 	regset->base = qm->io_base;
+	regset->dev = dev;
 
 	if (qm->pdev->device == SEC_PF_PCI_DEVICE_ID)
 		debugfs_create_file("regs", 0444, tmp_d, regset, &sec_regs_fops);
@@ -990,6 +1006,8 @@ static int sec_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			goto err_alg_unregister;
 	}
 
+	hisi_qm_pm_init(qm);
+
 	return 0;
 
 err_alg_unregister:
@@ -1008,6 +1026,7 @@ static void sec_remove(struct pci_dev *pdev)
 {
 	struct hisi_qm *qm = pci_get_drvdata(pdev);
 
+	hisi_qm_pm_uninit(qm);
 	hisi_qm_wait_task_finish(qm, &sec_devices);
 	if (qm->qp_num >= ctx_q_num)
 		hisi_qm_alg_unregister(qm, &sec_devices);
@@ -1027,6 +1046,10 @@ static void sec_remove(struct pci_dev *pdev)
 	sec_qm_uninit(qm);
 }
 
+static const struct dev_pm_ops sec_pm_ops = {
+	SET_RUNTIME_PM_OPS(hisi_qm_suspend, hisi_qm_resume, NULL)
+};
+
 static const struct pci_error_handlers sec_err_handler = {
 	.error_detected = hisi_qm_dev_err_detected,
 	.slot_reset	= hisi_qm_dev_slot_reset,
@@ -1042,6 +1065,7 @@ static struct pci_driver sec_pci_driver = {
 	.err_handler = &sec_err_handler,
 	.sriov_configure = hisi_qm_sriov_configure,
 	.shutdown = hisi_qm_dev_shutdown,
+	.driver.pm = &sec_pm_ops,
 };
 
 static void sec_register_debugfs(void)
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index a85e4b4..61d3d94 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include <linux/seq_file.h>
 #include <linux/topology.h>
 #include <linux/uacce.h>
@@ -450,22 +451,33 @@ static ssize_t hisi_zip_ctrl_debug_read(struct file *filp, char __user *buf,
 					size_t count, loff_t *pos)
 {
 	struct ctrl_debug_file *file = filp->private_data;
+	struct hisi_qm *qm = file_to_qm(file);
 	char tbuf[HZIP_BUF_SIZE];
 	u32 val;
 	int ret;
 
+	ret = hisi_qm_get_dfx_access(qm);
+	if (ret)
+		return ret;
+
 	spin_lock_irq(&file->lock);
 	switch (file->index) {
 	case HZIP_CLEAR_ENABLE:
 		val = clear_enable_read(file);
 		break;
 	default:
-		spin_unlock_irq(&file->lock);
-		return -EINVAL;
+		goto err_input;
 	}
 	spin_unlock_irq(&file->lock);
+
+	hisi_qm_put_dfx_access(qm);
 	ret = scnprintf(tbuf, sizeof(tbuf), "%u\n", val);
 	return simple_read_from_buffer(buf, count, pos, tbuf, ret);
+
+err_input:
+	spin_unlock_irq(&file->lock);
+	hisi_qm_put_dfx_access(qm);
+	return -EINVAL;
 }
 
 static ssize_t hisi_zip_ctrl_debug_write(struct file *filp,
@@ -473,6 +485,7 @@ static ssize_t hisi_zip_ctrl_debug_write(struct file *filp,
 					 size_t count, loff_t *pos)
 {
 	struct ctrl_debug_file *file = filp->private_data;
+	struct hisi_qm *qm = file_to_qm(file);
 	char tbuf[HZIP_BUF_SIZE];
 	unsigned long val;
 	int len, ret;
@@ -491,6 +504,10 @@ static ssize_t hisi_zip_ctrl_debug_write(struct file *filp,
 	if (kstrtoul(tbuf, 0, &val))
 		return -EFAULT;
 
+	ret = hisi_qm_get_dfx_access(qm);
+	if (ret)
+		return ret;
+
 	spin_lock_irq(&file->lock);
 	switch (file->index) {
 	case HZIP_CLEAR_ENABLE:
@@ -502,12 +519,12 @@ static ssize_t hisi_zip_ctrl_debug_write(struct file *filp,
 		ret = -EINVAL;
 		goto err_input;
 	}
-	spin_unlock_irq(&file->lock);
 
-	return count;
+	ret = count;
 
 err_input:
 	spin_unlock_irq(&file->lock);
+	hisi_qm_put_dfx_access(qm);
 	return ret;
 }
 
@@ -569,6 +586,7 @@ static int hisi_zip_core_debug_init(struct hisi_qm *qm)
 		regset->regs = hzip_dfx_regs;
 		regset->nregs = ARRAY_SIZE(hzip_dfx_regs);
 		regset->base = qm->io_base + core_offsets[i];
+		regset->dev = dev;
 
 		tmp_d = debugfs_create_dir(buf, qm->debug.debug_root);
 		debugfs_create_file("regs", 0444, tmp_d, regset,
@@ -908,6 +926,8 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			goto err_qm_alg_unregister;
 	}
 
+	hisi_qm_pm_init(qm);
+
 	return 0;
 
 err_qm_alg_unregister:
@@ -930,6 +950,7 @@ static void hisi_zip_remove(struct pci_dev *pdev)
 {
 	struct hisi_qm *qm = pci_get_drvdata(pdev);
 
+	hisi_qm_pm_uninit(qm);
 	hisi_qm_wait_task_finish(qm, &zip_devices);
 	hisi_qm_alg_unregister(qm, &zip_devices);
 
@@ -942,6 +963,10 @@ static void hisi_zip_remove(struct pci_dev *pdev)
 	hisi_zip_qm_uninit(qm);
 }
 
+static const struct dev_pm_ops hisi_zip_pm_ops = {
+	SET_RUNTIME_PM_OPS(hisi_qm_suspend, hisi_qm_resume, NULL)
+};
+
 static const struct pci_error_handlers hisi_zip_err_handler = {
 	.error_detected	= hisi_qm_dev_err_detected,
 	.slot_reset	= hisi_qm_dev_slot_reset,
@@ -958,6 +983,7 @@ static struct pci_driver hisi_zip_pci_driver = {
 					hisi_qm_sriov_configure : NULL,
 	.err_handler		= &hisi_zip_err_handler,
 	.shutdown		= hisi_qm_dev_shutdown,
+	.driver.pm		= &hisi_zip_pm_ops,
 };
 
 static void hisi_zip_register_debugfs(void)
-- 
2.8.1


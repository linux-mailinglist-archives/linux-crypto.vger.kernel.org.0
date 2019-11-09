Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5456F5CE8
	for <lists+linux-crypto@lfdr.de>; Sat,  9 Nov 2019 03:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfKICFr (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 Nov 2019 21:05:47 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:55346 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbfKICFr (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 8 Nov 2019 21:05:47 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 15F25A920D975FFD7C4A;
        Sat,  9 Nov 2019 10:05:44 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Sat, 9 Nov 2019 10:05:34 +0800
From:   Zaibo Xu <xuzaibo@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <jonathan.cameron@huawei.com>,
        <wangzhou1@hisilicon.com>, <linuxarm@huawei.com>,
        <fanghao11@huawei.com>, <yekai13@huawei.com>,
        <zhangwei375@huawei.com>, <forest.zhouchang@huawei.com>
Subject: [PATCH v2 4/5] crypto: hisilicon - add DebugFS for HiSilicon SEC
Date:   Sat, 9 Nov 2019 10:01:56 +0800
Message-ID: <1573264917-14588-5-git-send-email-xuzaibo@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1573264917-14588-1-git-send-email-xuzaibo@huawei.com>
References: <1573264917-14588-1-git-send-email-xuzaibo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The HiSilicon SEC engine driver uses DebugFS
to provide main debug information for user space.

Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec.h        |  23 +++
 drivers/crypto/hisilicon/sec2/sec_crypto.c |   3 +
 drivers/crypto/hisilicon/sec2/sec_main.c   | 306 +++++++++++++++++++++++++++++
 3 files changed, 332 insertions(+)

diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index 69b37f2..26754d0 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -119,9 +119,32 @@ enum sec_endian {
 	SEC_64BE
 };
 
+enum sec_debug_file_index {
+	SEC_CURRENT_QM,
+	SEC_CLEAR_ENABLE,
+	SEC_DEBUG_FILE_NUM,
+};
+
+struct sec_debug_file {
+	enum sec_debug_file_index index;
+	spinlock_t lock;
+	struct hisi_qm *qm;
+};
+
+struct sec_dfx {
+	u64 send_cnt;
+	u64 recv_cnt;
+};
+
+struct sec_debug {
+	struct sec_dfx dfx;
+	struct sec_debug_file files[SEC_DEBUG_FILE_NUM];
+};
+
 struct sec_dev {
 	struct hisi_qm qm;
 	struct list_head list;
+	struct sec_debug debug;
 	u32 ctx_q_num;
 	u32 num_vfs;
 	unsigned long status;
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index b22dac7..98360f6 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -120,6 +120,8 @@ static void sec_req_cb(struct hisi_qp *qp, void *resp)
 		return;
 	}
 
+	__sync_add_and_fetch(&req->ctx->sec->debug.dfx.recv_cnt, 1);
+
 	req->ctx->req_op->buf_unmap(req->ctx, req);
 
 	req->ctx->req_op->callback(req->ctx, req);
@@ -133,6 +135,7 @@ static int sec_bd_send(struct sec_ctx *ctx, struct sec_req *req)
 	mutex_lock(&qp_ctx->req_lock);
 	ret = hisi_qp_send(qp_ctx->qp, &req->sec_sqe);
 	mutex_unlock(&qp_ctx->req_lock);
+	__sync_add_and_fetch(&ctx->sec->debug.dfx.send_cnt, 1);
 
 	if (ret == -EBUSY)
 		return -ENOBUFS;
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 00dd4c3..74f0654 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -4,6 +4,7 @@
 #include <linux/acpi.h>
 #include <linux/aer.h>
 #include <linux/bitops.h>
+#include <linux/debugfs.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -32,6 +33,8 @@
 #define SEC_PF_DEF_Q_BASE		0
 #define SEC_CTX_Q_NUM_DEF		24
 
+#define SEC_CTRL_CNT_CLR_CE		0x301120
+#define SEC_CTRL_CNT_CLR_CE_BIT		BIT(0)
 #define SEC_ENGINE_PF_CFG_OFF		0x300000
 #define SEC_ACC_COMMON_REG_OFF		0x1000
 #define SEC_CORE_INT_SOURCE		0x301010
@@ -72,6 +75,8 @@
 
 #define SEC_DELAY_10_US			10
 #define SEC_POLL_TIMEOUT_US		1000
+#define SEC_VF_CNT_MASK			0xffffffc0
+#define SEC_DBGFS_VAL_MAX_LEN		20
 
 #define SEC_ADDR(qm, offset) ((qm)->io_base + (offset) + \
 			     SEC_ENGINE_PF_CFG_OFF + SEC_ACC_COMMON_REG_OFF)
@@ -82,6 +87,7 @@ struct sec_hw_error {
 };
 
 static const char sec_name[] = "hisi_sec2";
+static struct dentry *sec_debugfs_root;
 static LIST_HEAD(sec_list);
 static DEFINE_MUTEX(sec_list_lock);
 
@@ -129,6 +135,35 @@ struct sec_dev *sec_find_device(int node)
 	return ret;
 }
 
+static const char * const sec_dbg_file_name[] = {
+	[SEC_CURRENT_QM] = "current_qm",
+	[SEC_CLEAR_ENABLE] = "clear_enable",
+};
+
+static struct debugfs_reg32 sec_dfx_regs[] = {
+	{"SEC_PF_ABNORMAL_INT_SOURCE    ",  0x301010},
+	{"SEC_SAA_EN                    ",  0x301270},
+	{"SEC_BD_LATENCY_MIN            ",  0x301600},
+	{"SEC_BD_LATENCY_MAX            ",  0x301608},
+	{"SEC_BD_LATENCY_AVG            ",  0x30160C},
+	{"SEC_BD_NUM_IN_SAA0            ",  0x301670},
+	{"SEC_BD_NUM_IN_SAA1            ",  0x301674},
+	{"SEC_BD_NUM_IN_SEC             ",  0x301680},
+	{"SEC_ECC_1BIT_CNT              ",  0x301C00},
+	{"SEC_ECC_1BIT_INFO             ",  0x301C04},
+	{"SEC_ECC_2BIT_CNT              ",  0x301C10},
+	{"SEC_ECC_2BIT_INFO             ",  0x301C14},
+	{"SEC_BD_SAA0                   ",  0x301C20},
+	{"SEC_BD_SAA1                   ",  0x301C24},
+	{"SEC_BD_SAA2                   ",  0x301C28},
+	{"SEC_BD_SAA3                   ",  0x301C2C},
+	{"SEC_BD_SAA4                   ",  0x301C30},
+	{"SEC_BD_SAA5                   ",  0x301C34},
+	{"SEC_BD_SAA6                   ",  0x301C38},
+	{"SEC_BD_SAA7                   ",  0x301C3C},
+	{"SEC_BD_SAA8                   ",  0x301C40},
+};
+
 static int sec_pf_q_num_set(const char *val, const struct kernel_param *kp)
 {
 	struct pci_dev *pdev;
@@ -335,6 +370,19 @@ static int sec_set_user_domain_and_cache(struct sec_dev *sec)
 	return sec_engine_init(sec);
 }
 
+/* sec_debug_regs_clear() - clear the sec debug regs */
+static void sec_debug_regs_clear(struct hisi_qm *qm)
+{
+	/* clear current_qm */
+	writel(0x0, qm->io_base + QM_DFX_MB_CNT_VF);
+	writel(0x0, qm->io_base + QM_DFX_DB_CNT_VF);
+
+	/* clear rdclr_en */
+	writel(0x0, qm->io_base + SEC_CTRL_CNT_CLR_CE);
+
+	hisi_qm_debug_regs_clear(qm);
+}
+
 static void sec_hw_error_enable(struct sec_dev *sec)
 {
 	struct hisi_qm *qm = &sec->qm;
@@ -407,6 +455,235 @@ static void sec_hw_error_uninit(struct sec_dev *sec)
 	writel(GENMASK(12, 0), sec->qm.io_base + SEC_QM_ABNORMAL_INT_MASK);
 }
 
+static u32 sec_current_qm_read(struct sec_debug_file *file)
+{
+	struct hisi_qm *qm = file->qm;
+
+	return readl(qm->io_base + QM_DFX_MB_CNT_VF);
+}
+
+static int sec_current_qm_write(struct sec_debug_file *file, u32 val)
+{
+	struct hisi_qm *qm = file->qm;
+	struct sec_dev *sec = container_of(qm, struct sec_dev, qm);
+	u32 vfq_num;
+	u32 tmp;
+
+	if (val > sec->num_vfs)
+		return -EINVAL;
+
+	/* According PF or VF Dev ID to calculation curr_qm_qp_num and store */
+	if (!val) {
+		qm->debug.curr_qm_qp_num = qm->qp_num;
+	} else {
+		vfq_num = (qm->ctrl_qp_num - qm->qp_num) / sec->num_vfs;
+
+		if (val == sec->num_vfs)
+			qm->debug.curr_qm_qp_num =
+				qm->ctrl_qp_num - qm->qp_num -
+				(sec->num_vfs - 1) * vfq_num;
+		else
+			qm->debug.curr_qm_qp_num = vfq_num;
+	}
+
+	writel(val, qm->io_base + QM_DFX_MB_CNT_VF);
+	writel(val, qm->io_base + QM_DFX_DB_CNT_VF);
+
+	tmp = val |
+	      (readl(qm->io_base + QM_DFX_SQE_CNT_VF_SQN) & CURRENT_Q_MASK);
+	writel(tmp, qm->io_base + QM_DFX_SQE_CNT_VF_SQN);
+
+	tmp = val |
+	      (readl(qm->io_base + QM_DFX_CQE_CNT_VF_CQN) & CURRENT_Q_MASK);
+	writel(tmp, qm->io_base + QM_DFX_CQE_CNT_VF_CQN);
+
+	return 0;
+}
+
+static u32 sec_clear_enable_read(struct sec_debug_file *file)
+{
+	struct hisi_qm *qm = file->qm;
+
+	return readl(qm->io_base + SEC_CTRL_CNT_CLR_CE) &
+			SEC_CTRL_CNT_CLR_CE_BIT;
+}
+
+static int sec_clear_enable_write(struct sec_debug_file *file, u32 val)
+{
+	struct hisi_qm *qm = file->qm;
+	u32 tmp;
+
+	if (val != 1 && val)
+		return -EINVAL;
+
+	tmp = (readl(qm->io_base + SEC_CTRL_CNT_CLR_CE) &
+	       ~SEC_CTRL_CNT_CLR_CE_BIT) | val;
+	writel(tmp, qm->io_base + SEC_CTRL_CNT_CLR_CE);
+
+	return 0;
+}
+
+static ssize_t sec_debug_read(struct file *filp, char __user *buf,
+			       size_t count, loff_t *pos)
+{
+	struct sec_debug_file *file = filp->private_data;
+	char tbuf[SEC_DBGFS_VAL_MAX_LEN];
+	u32 val;
+	int ret;
+
+	spin_lock_irq(&file->lock);
+
+	switch (file->index) {
+	case SEC_CURRENT_QM:
+		val = sec_current_qm_read(file);
+		break;
+	case SEC_CLEAR_ENABLE:
+		val = sec_clear_enable_read(file);
+		break;
+	default:
+		spin_unlock_irq(&file->lock);
+		return -EINVAL;
+	}
+
+	spin_unlock_irq(&file->lock);
+	ret = snprintf(tbuf, SEC_DBGFS_VAL_MAX_LEN, "%u\n", val);
+
+	return simple_read_from_buffer(buf, count, pos, tbuf, ret);
+}
+
+static ssize_t sec_debug_write(struct file *filp, const char __user *buf,
+			       size_t count, loff_t *pos)
+{
+	struct sec_debug_file *file = filp->private_data;
+	char tbuf[SEC_DBGFS_VAL_MAX_LEN];
+	unsigned long val;
+	int len, ret;
+
+	if (*pos != 0)
+		return 0;
+
+	if (count >= SEC_DBGFS_VAL_MAX_LEN)
+		return -ENOSPC;
+
+	len = simple_write_to_buffer(tbuf, SEC_DBGFS_VAL_MAX_LEN - 1,
+				     pos, buf, count);
+	if (len < 0)
+		return len;
+
+	tbuf[len] = '\0';
+	if (kstrtoul(tbuf, 0, &val))
+		return -EFAULT;
+
+	spin_lock_irq(&file->lock);
+
+	switch (file->index) {
+	case SEC_CURRENT_QM:
+		ret = sec_current_qm_write(file, val);
+		if (ret)
+			goto err_input;
+		break;
+	case SEC_CLEAR_ENABLE:
+		ret = sec_clear_enable_write(file, val);
+		if (ret)
+			goto err_input;
+		break;
+	default:
+		ret = -EINVAL;
+		goto err_input;
+	}
+
+	spin_unlock_irq(&file->lock);
+
+	return count;
+
+ err_input:
+	spin_unlock_irq(&file->lock);
+	return ret;
+}
+
+static const struct file_operations sec_dbg_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = sec_debug_read,
+	.write = sec_debug_write,
+};
+
+static int sec_core_debug_init(struct sec_dev *sec)
+{
+	struct hisi_qm *qm = &sec->qm;
+	struct device *dev = &qm->pdev->dev;
+	struct sec_dfx *dfx = &sec->debug.dfx;
+	struct debugfs_regset32 *regset;
+	struct dentry *tmp_d;
+
+	tmp_d = debugfs_create_dir("sec_dfx", sec->qm.debug.debug_root);
+
+	regset = devm_kzalloc(dev, sizeof(*regset), GFP_KERNEL);
+	if (!regset)
+		return -ENOENT;
+
+	regset->regs = sec_dfx_regs;
+	regset->nregs = ARRAY_SIZE(sec_dfx_regs);
+	regset->base = qm->io_base;
+
+	debugfs_create_regset32("regs", 0444, tmp_d, regset);
+
+	debugfs_create_u64("send_cnt", 0444, tmp_d, &dfx->send_cnt);
+
+	debugfs_create_u64("recv_cnt", 0444, tmp_d, &dfx->recv_cnt);
+
+	return 0;
+}
+
+static int sec_debug_init(struct sec_dev *sec)
+{
+	int i;
+
+	for (i = SEC_CURRENT_QM; i < SEC_DEBUG_FILE_NUM; i++) {
+		spin_lock_init(&sec->debug.files[i].lock);
+		sec->debug.files[i].index = i;
+		sec->debug.files[i].qm = &sec->qm;
+
+		debugfs_create_file(sec_dbg_file_name[i], 0600,
+				    sec->qm.debug.debug_root,
+				    sec->debug.files + i,
+				    &sec_dbg_fops);
+	}
+
+	return sec_core_debug_init(sec);
+}
+
+static int sec_debugfs_init(struct sec_dev *sec)
+{
+	struct hisi_qm *qm = &sec->qm;
+	struct device *dev = &qm->pdev->dev;
+	int ret;
+
+	qm->debug.debug_root = debugfs_create_dir(dev_name(dev),
+						  sec_debugfs_root);
+	ret = hisi_qm_debug_init(qm);
+	if (ret)
+		goto failed_to_create;
+
+	if (qm->pdev->device == SEC_PF_PCI_DEVICE_ID) {
+		ret = sec_debug_init(sec);
+		if (ret)
+			goto failed_to_create;
+	}
+
+	return 0;
+
+failed_to_create:
+	debugfs_remove_recursive(sec_debugfs_root);
+
+	return ret;
+}
+
+static void sec_debugfs_exit(struct sec_dev *sec)
+{
+	debugfs_remove_recursive(sec->qm.debug.debug_root);
+}
+
 static int sec_pf_probe_init(struct sec_dev *sec)
 {
 	struct hisi_qm *qm = &sec->qm;
@@ -430,6 +707,7 @@ static int sec_pf_probe_init(struct sec_dev *sec)
 		return ret;
 
 	sec_hw_error_init(sec);
+	sec_debug_regs_clear(qm);
 
 	return 0;
 }
@@ -464,6 +742,7 @@ static int sec_probe_init(struct hisi_qm *qm, struct sec_dev *sec)
 	if (qm->fun_type == QM_HW_PF) {
 		qm->qp_base = SEC_PF_DEF_Q_BASE;
 		qm->qp_num = pf_q_num;
+		qm->debug.curr_qm_qp_num = pf_q_num;
 
 		return sec_pf_probe_init(sec);
 	} else if (qm->fun_type == QM_HW_VF) {
@@ -526,6 +805,10 @@ static int sec_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_probe_uninit;
 	}
 
+	ret = sec_debugfs_init(sec);
+	if (ret)
+		pci_warn(pdev, "Failed to init debugfs!\n");
+
 	sec_add_to_list(sec);
 
 	ret = sec_register_to_crypto();
@@ -538,6 +821,7 @@ static int sec_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 err_remove_from_list:
 	sec_remove_from_list(sec);
+	sec_debugfs_exit(sec);
 	hisi_qm_stop(qm);
 
 err_probe_uninit:
@@ -665,8 +949,13 @@ static void sec_remove(struct pci_dev *pdev)
 	if (qm->fun_type == QM_HW_PF && sec->num_vfs)
 		(void)sec_sriov_disable(pdev);
 
+	sec_debugfs_exit(sec);
+
 	(void)hisi_qm_stop(qm);
 
+	if (qm->fun_type == QM_HW_PF)
+		sec_debug_regs_clear(qm);
+
 	sec_probe_uninit(sec);
 
 	sec_qm_uninit(qm);
@@ -761,12 +1050,28 @@ static struct pci_driver sec_pci_driver = {
 	.sriov_configure = sec_sriov_configure,
 };
 
+static void sec_register_debugfs(void)
+{
+	if (!debugfs_initialized())
+		return;
+
+	sec_debugfs_root = debugfs_create_dir("hisi_sec2", NULL);
+}
+
+static void sec_unregister_debugfs(void)
+{
+	debugfs_remove_recursive(sec_debugfs_root);
+}
+
 static int __init sec_init(void)
 {
 	int ret;
 
+	sec_register_debugfs();
+
 	ret = pci_register_driver(&sec_pci_driver);
 	if (ret < 0) {
+		sec_unregister_debugfs();
 		pr_err("Failed to register pci driver.\n");
 		return ret;
 	}
@@ -777,6 +1082,7 @@ static int __init sec_init(void)
 static void __exit sec_exit(void)
 {
 	pci_unregister_driver(&sec_pci_driver);
+	sec_unregister_debugfs();
 }
 
 module_init(sec_init);
-- 
2.8.1


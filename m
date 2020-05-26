Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57401D4935
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2020 11:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgEOJPX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 15 May 2020 05:15:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58104 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727882AbgEOJPX (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 15 May 2020 05:15:23 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B877FC5E5C58780133AB;
        Fri, 15 May 2020 17:15:18 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Fri, 15 May 2020 17:15:09 +0800
From:   Shukun Tan <tanshukun1@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>
Subject: [PATCH 6/7] crypto: hisilicon/qm - add DebugFS for xQC and xQE dump
Date:   Fri, 15 May 2020 17:13:59 +0800
Message-ID: <1589534040-50725-7-git-send-email-tanshukun1@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589534040-50725-1-git-send-email-tanshukun1@huawei.com>
References: <1589534040-50725-1-git-send-email-tanshukun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add dump information of SQC/CQC/EQC/AEQC/SQE/CQE/EQE/AEQE.

Signed-off-by: Shukun Tan <tanshukun1@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c |   4 +
 drivers/crypto/hisilicon/qm.c             | 511 +++++++++++++++++++++++++++---
 drivers/crypto/hisilicon/qm.h             |   2 +
 drivers/crypto/hisilicon/sec2/sec_main.c  |   6 +
 drivers/crypto/hisilicon/zip/zip_main.c   |   4 +
 5 files changed, 488 insertions(+), 39 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index fb3988f..38405b5 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -84,6 +84,8 @@
 #define HPRE_OOO_ECC_2BIT_ERR		BIT(5)
 
 #define HPRE_VIA_MSI_DSM		1
+#define HPRE_SQE_MASK_OFFSET		8
+#define HPRE_SQE_MASK_LEN		24
 
 static struct hisi_qm_list hpre_devices;
 static const char hpre_name[] = "hisi_hpre";
@@ -683,6 +685,8 @@ static int hpre_debugfs_init(struct hpre *hpre)
 
 	dir = debugfs_create_dir(dev_name(dev), hpre_debugfs_root);
 	qm->debug.debug_root = dir;
+	qm->debug.sqe_mask_offset = HPRE_SQE_MASK_OFFSET;
+	qm->debug.sqe_mask_len = HPRE_SQE_MASK_LEN;
 
 	ret = hisi_qm_debug_init(qm);
 	if (ret)
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 7c1982f..57ad131 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -176,9 +176,12 @@
 #define QMC_ALIGN(sz)			ALIGN(sz, 32)
 
 #define QM_DBG_READ_LEN		256
+#define QM_DBG_WRITE_LEN		1024
 #define QM_DBG_TMP_BUF_LEN		22
 #define QM_PCI_COMMAND_INVALID		~0
 
+#define QM_SQE_ADDR_MASK		GENMASK(7, 0)
+
 #define QM_MK_CQC_DW3_V1(hop_num, pg_sz, buf_sz, cqe_sz) \
 	(((hop_num) << QM_CQ_HOP_NUM_SHIFT)	| \
 	((pg_sz) << QM_CQ_PAGE_SIZE_SHIFT)	| \
@@ -1064,6 +1067,473 @@ static const struct file_operations qm_regs_fops = {
 	.release = single_release,
 };
 
+static ssize_t qm_cmd_read(struct file *filp, char __user *buffer,
+			   size_t count, loff_t *pos)
+{
+	char buf[QM_DBG_READ_LEN];
+	int len;
+
+	if (*pos)
+		return 0;
+
+	if (count < QM_DBG_READ_LEN)
+		return -ENOSPC;
+
+	len = snprintf(buf, QM_DBG_READ_LEN, "%s\n",
+		       "Please echo help to cmd to get help information");
+
+	if (copy_to_user(buffer, buf, len))
+		return -EFAULT;
+
+	return (*pos = len);
+}
+
+static void *qm_ctx_alloc(struct hisi_qm *qm, size_t ctx_size,
+			  dma_addr_t *dma_addr)
+{
+	struct device *dev = &qm->pdev->dev;
+	void *ctx_addr;
+
+	ctx_addr = kzalloc(ctx_size, GFP_KERNEL);
+	if (!ctx_addr)
+		return ERR_PTR(-ENOMEM);
+
+	*dma_addr = dma_map_single(dev, ctx_addr, ctx_size, DMA_FROM_DEVICE);
+	if (dma_mapping_error(dev, *dma_addr)) {
+		dev_err(dev, "DMA mapping error!\n");
+		kfree(ctx_addr);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return ctx_addr;
+}
+
+static void qm_ctx_free(struct hisi_qm *qm, size_t ctx_size,
+			const void *ctx_addr, dma_addr_t *dma_addr)
+{
+	struct device *dev = &qm->pdev->dev;
+
+	dma_unmap_single(dev, *dma_addr, ctx_size, DMA_FROM_DEVICE);
+	kfree(ctx_addr);
+}
+
+static int dump_show(struct hisi_qm *qm, void *info,
+		     unsigned int info_size, char *info_name)
+{
+	struct device *dev = &qm->pdev->dev;
+	u8 *info_buf, *info_curr = info;
+	u32 i;
+#define BYTE_PER_DW	4
+
+	info_buf = kzalloc(info_size, GFP_KERNEL);
+	if (!info_buf)
+		return -ENOMEM;
+
+	for (i = 0; i < info_size; i++, info_curr++) {
+		if (i % BYTE_PER_DW == 0)
+			info_buf[i + 3UL] = *info_curr;
+		else if (i % BYTE_PER_DW == 1)
+			info_buf[i + 1UL] = *info_curr;
+		else if (i % BYTE_PER_DW == 2)
+			info_buf[i - 1] = *info_curr;
+		else if (i % BYTE_PER_DW == 3)
+			info_buf[i - 3] = *info_curr;
+	}
+
+	dev_info(dev, "%s DUMP\n", info_name);
+	for (i = 0; i < info_size; i += BYTE_PER_DW) {
+		pr_info("DW%d: %02X%02X %02X%02X\n", i / BYTE_PER_DW,
+			info_buf[i], info_buf[i + 1UL],
+			info_buf[i + 2UL], info_buf[i + 3UL]);
+	}
+
+	kfree(info_buf);
+
+	return 0;
+}
+
+static int qm_dump_sqc_raw(struct hisi_qm *qm, dma_addr_t dma_addr, u16 qp_id)
+{
+	return qm_mb(qm, QM_MB_CMD_SQC, dma_addr, qp_id, 1);
+}
+
+static int qm_dump_cqc_raw(struct hisi_qm *qm, dma_addr_t dma_addr, u16 qp_id)
+{
+	return qm_mb(qm, QM_MB_CMD_CQC, dma_addr, qp_id, 1);
+}
+
+static int qm_sqc_dump(struct hisi_qm *qm, const char *s)
+{
+	struct device *dev = &qm->pdev->dev;
+	struct qm_sqc *sqc, *sqc_curr;
+	dma_addr_t sqc_dma;
+	u32 qp_id;
+	int ret;
+
+	if (!s)
+		return -EINVAL;
+
+	ret = kstrtou32(s, 0, &qp_id);
+	if (ret || qp_id >= qm->qp_num) {
+		dev_err(dev, "Please input qp num (0-%d)", qm->qp_num - 1);
+		return -EINVAL;
+	}
+
+	sqc = qm_ctx_alloc(qm, sizeof(*sqc), &sqc_dma);
+	if (IS_ERR(sqc))
+		return PTR_ERR(sqc);
+
+	ret = qm_dump_sqc_raw(qm, sqc_dma, qp_id);
+	if (ret) {
+		down_read(&qm->qps_lock);
+		if (qm->sqc) {
+			sqc_curr = qm->sqc + qp_id;
+
+			ret = dump_show(qm, sqc_curr, sizeof(*sqc),
+					"SOFT SQC");
+			if (ret)
+				dev_info(dev, "Show soft sqc failed!\n");
+		}
+		up_read(&qm->qps_lock);
+
+		goto err_free_ctx;
+	}
+
+	ret = dump_show(qm, sqc, sizeof(*sqc), "SQC");
+	if (ret)
+		dev_info(dev, "Show hw sqc failed!\n");
+
+err_free_ctx:
+	qm_ctx_free(qm, sizeof(*sqc), sqc, &sqc_dma);
+	return ret;
+}
+
+static int qm_cqc_dump(struct hisi_qm *qm, const char *s)
+{
+	struct device *dev = &qm->pdev->dev;
+	struct qm_cqc *cqc, *cqc_curr;
+	dma_addr_t cqc_dma;
+	u32 qp_id;
+	int ret;
+
+	if (!s)
+		return -EINVAL;
+
+	ret = kstrtou32(s, 0, &qp_id);
+	if (ret || qp_id >= qm->qp_num) {
+		dev_err(dev, "Please input qp num (0-%d)", qm->qp_num - 1);
+		return -EINVAL;
+	}
+
+	cqc = qm_ctx_alloc(qm, sizeof(*cqc), &cqc_dma);
+	if (IS_ERR(cqc))
+		return PTR_ERR(cqc);
+
+	ret = qm_dump_cqc_raw(qm, cqc_dma, qp_id);
+	if (ret) {
+		down_read(&qm->qps_lock);
+		if (qm->cqc) {
+			cqc_curr = qm->cqc + qp_id;
+
+			ret = dump_show(qm, cqc_curr, sizeof(*cqc),
+					"SOFT CQC");
+			if (ret)
+				dev_info(dev, "Show soft cqc failed!\n");
+		}
+		up_read(&qm->qps_lock);
+
+		goto err_free_ctx;
+	}
+
+	ret = dump_show(qm, cqc, sizeof(*cqc), "CQC");
+	if (ret)
+		dev_info(dev, "Show hw cqc failed!\n");
+
+err_free_ctx:
+	qm_ctx_free(qm, sizeof(*cqc), cqc, &cqc_dma);
+	return ret;
+}
+
+static int qm_eqc_aeqc_dump(struct hisi_qm *qm, char *s, size_t size,
+			    int cmd, char *name)
+{
+	struct device *dev = &qm->pdev->dev;
+	dma_addr_t xeqc_dma;
+	void *xeqc;
+	int ret;
+
+	if (strsep(&s, " ")) {
+		dev_err(dev, "Please do not input extra characters!\n");
+		return -EINVAL;
+	}
+
+	xeqc = qm_ctx_alloc(qm, size, &xeqc_dma);
+	if (IS_ERR(xeqc))
+		return PTR_ERR(xeqc);
+
+	ret = qm_mb(qm, cmd, xeqc_dma, 0, 1);
+	if (ret)
+		goto err_free_ctx;
+
+	ret = dump_show(qm, xeqc, size, name);
+	if (ret)
+		dev_info(dev, "Show hw %s failed!\n", name);
+
+err_free_ctx:
+	qm_ctx_free(qm, size, xeqc, &xeqc_dma);
+	return ret;
+}
+
+static int q_dump_param_parse(struct hisi_qm *qm, char *s,
+			      u32 *e_id, u32 *q_id)
+{
+	struct device *dev = &qm->pdev->dev;
+	unsigned int qp_num = qm->qp_num;
+	char *presult;
+	int ret;
+
+	presult = strsep(&s, " ");
+	if (!presult) {
+		dev_err(dev, "Please input qp number!\n");
+		return -EINVAL;
+	}
+
+	ret = kstrtou32(presult, 0, q_id);
+	if (ret || *q_id >= qp_num) {
+		dev_err(dev, "Please input qp num (0-%d)", qp_num - 1);
+		return -EINVAL;
+	}
+
+	presult = strsep(&s, " ");
+	if (!presult) {
+		dev_err(dev, "Please input sqe number!\n");
+		return -EINVAL;
+	}
+
+	ret = kstrtou32(presult, 0, e_id);
+	if (ret || *e_id >= QM_Q_DEPTH) {
+		dev_err(dev, "Please input sqe num (0-%d)", QM_Q_DEPTH - 1);
+		return -EINVAL;
+	}
+
+	if (strsep(&s, " ")) {
+		dev_err(dev, "Please do not input extra characters!\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int qm_sq_dump(struct hisi_qm *qm, char *s)
+{
+	struct device *dev = &qm->pdev->dev;
+	void *sqe, *sqe_curr;
+	struct hisi_qp *qp;
+	u32 qp_id, sqe_id;
+	int ret;
+
+	ret = q_dump_param_parse(qm, s, &sqe_id, &qp_id);
+	if (ret)
+		return ret;
+
+	sqe = kzalloc(qm->sqe_size * QM_Q_DEPTH, GFP_KERNEL);
+	if (!sqe)
+		return -ENOMEM;
+
+	qp = &qm->qp_array[qp_id];
+	memcpy(sqe, qp->sqe, qm->sqe_size * QM_Q_DEPTH);
+	sqe_curr = sqe + (u32)(sqe_id * qm->sqe_size);
+	memset(sqe_curr + qm->debug.sqe_mask_offset, QM_SQE_ADDR_MASK,
+	       qm->debug.sqe_mask_len);
+
+	ret = dump_show(qm, sqe_curr, qm->sqe_size, "SQE");
+	if (ret)
+		dev_info(dev, "Show sqe failed!\n");
+
+	kfree(sqe);
+
+	return ret;
+}
+
+static int qm_cq_dump(struct hisi_qm *qm, char *s)
+{
+	struct device *dev = &qm->pdev->dev;
+	struct qm_cqe *cqe_curr;
+	struct hisi_qp *qp;
+	u32 qp_id, cqe_id;
+	int ret;
+
+	ret = q_dump_param_parse(qm, s, &cqe_id, &qp_id);
+	if (ret)
+		return ret;
+
+	qp = &qm->qp_array[qp_id];
+	cqe_curr = qp->cqe + cqe_id;
+	ret = dump_show(qm, cqe_curr, sizeof(struct qm_cqe), "CQE");
+	if (ret)
+		dev_info(dev, "Show cqe failed!\n");
+
+	return ret;
+}
+
+static int qm_eq_aeq_dump(struct hisi_qm *qm, const char *s,
+			  size_t size, char *name)
+{
+	struct device *dev = &qm->pdev->dev;
+	void *xeqe;
+	u32 xeqe_id;
+	int ret;
+
+	if (!s)
+		return -EINVAL;
+
+	ret = kstrtou32(s, 0, &xeqe_id);
+	if (ret || xeqe_id >= QM_Q_DEPTH) {
+		dev_err(dev, "Please input aeqe num (0-%d)", QM_Q_DEPTH - 1);
+		return -EINVAL;
+	}
+
+	down_read(&qm->qps_lock);
+
+	if (qm->eqe && !strcmp(name, "EQE")) {
+		xeqe = qm->eqe + xeqe_id;
+	} else if (qm->aeqe && !strcmp(name, "AEQE")) {
+		xeqe = qm->aeqe + xeqe_id;
+	} else {
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+
+	ret = dump_show(qm, xeqe, size, name);
+	if (ret)
+		dev_info(dev, "Show %s failed!\n", name);
+
+err_unlock:
+	up_read(&qm->qps_lock);
+	return ret;
+}
+
+static int qm_dbg_help(struct hisi_qm *qm, char *s)
+{
+	struct device *dev = &qm->pdev->dev;
+
+	if (strsep(&s, " ")) {
+		dev_err(dev, "Please do not input extra characters!\n");
+		return -EINVAL;
+	}
+
+	dev_info(dev, "available commands:\n");
+	dev_info(dev, "sqc <num>\n");
+	dev_info(dev, "cqc <num>\n");
+	dev_info(dev, "eqc\n");
+	dev_info(dev, "aeqc\n");
+	dev_info(dev, "sq <num> <e>\n");
+	dev_info(dev, "cq <num> <e>\n");
+	dev_info(dev, "eq <e>\n");
+	dev_info(dev, "aeq <e>\n");
+
+	return 0;
+}
+
+static int qm_cmd_write_dump(struct hisi_qm *qm, const char *cmd_buf)
+{
+	struct device *dev = &qm->pdev->dev;
+	char *presult, *s;
+	int ret;
+
+	s = kstrdup(cmd_buf, GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+
+	presult = strsep(&s, " ");
+	if (!presult) {
+		kfree(s);
+		return -EINVAL;
+	}
+
+	if (!strcmp(presult, "sqc"))
+		ret = qm_sqc_dump(qm, s);
+	else if (!strcmp(presult, "cqc"))
+		ret = qm_cqc_dump(qm, s);
+	else if (!strcmp(presult, "eqc"))
+		ret = qm_eqc_aeqc_dump(qm, s, sizeof(struct qm_eqc),
+				       QM_MB_CMD_EQC, "EQC");
+	else if (!strcmp(presult, "aeqc"))
+		ret = qm_eqc_aeqc_dump(qm, s, sizeof(struct qm_aeqc),
+				       QM_MB_CMD_AEQC, "AEQC");
+	else if (!strcmp(presult, "sq"))
+		ret = qm_sq_dump(qm, s);
+	else if (!strcmp(presult, "cq"))
+		ret = qm_cq_dump(qm, s);
+	else if (!strcmp(presult, "eq"))
+		ret = qm_eq_aeq_dump(qm, s, sizeof(struct qm_eqe), "EQE");
+	else if (!strcmp(presult, "aeq"))
+		ret = qm_eq_aeq_dump(qm, s, sizeof(struct qm_aeqe), "AEQE");
+	else if (!strcmp(presult, "help"))
+		ret = qm_dbg_help(qm, s);
+	else
+		ret = -EINVAL;
+
+	if (ret)
+		dev_info(dev, "Please echo help\n");
+
+	kfree(s);
+
+	return ret;
+}
+
+static ssize_t qm_cmd_write(struct file *filp, const char __user *buffer,
+			    size_t count, loff_t *pos)
+{
+	struct hisi_qm *qm = filp->private_data;
+	char *cmd_buf, *cmd_buf_tmp;
+	int ret;
+
+	if (*pos)
+		return 0;
+
+	/* Judge if the instance is being reset. */
+	if (unlikely(atomic_read(&qm->status.flags) == QM_STOP))
+		return 0;
+
+	if (count > QM_DBG_WRITE_LEN)
+		return -ENOSPC;
+
+	cmd_buf = kzalloc(count + 1, GFP_KERNEL);
+	if (!cmd_buf)
+		return -ENOMEM;
+
+	if (copy_from_user(cmd_buf, buffer, count)) {
+		kfree(cmd_buf);
+		return -EFAULT;
+	}
+
+	cmd_buf[count] = '\0';
+
+	cmd_buf_tmp = strchr(cmd_buf, '\n');
+	if (cmd_buf_tmp) {
+		*cmd_buf_tmp = '\0';
+		count = cmd_buf_tmp - cmd_buf + 1;
+	}
+
+	ret = qm_cmd_write_dump(qm, cmd_buf);
+	if (ret) {
+		kfree(cmd_buf);
+		return ret;
+	}
+
+	kfree(cmd_buf);
+
+	return count;
+}
+
+static const struct file_operations qm_cmd_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = qm_cmd_read,
+	.write = qm_cmd_write,
+};
+
 static int qm_create_debugfs_file(struct hisi_qm *qm, enum qm_debug_file index)
 {
 	struct dentry *qm_d = qm->debug.qm_d;
@@ -1389,45 +1859,6 @@ int hisi_qm_start_qp(struct hisi_qp *qp, unsigned long arg)
 }
 EXPORT_SYMBOL_GPL(hisi_qm_start_qp);
 
-static void *qm_ctx_alloc(struct hisi_qm *qm, size_t ctx_size,
-			  dma_addr_t *dma_addr)
-{
-	struct device *dev = &qm->pdev->dev;
-	void *ctx_addr;
-
-	ctx_addr = kzalloc(ctx_size, GFP_KERNEL);
-	if (!ctx_addr)
-		return ERR_PTR(-ENOMEM);
-
-	*dma_addr = dma_map_single(dev, ctx_addr, ctx_size, DMA_FROM_DEVICE);
-	if (dma_mapping_error(dev, *dma_addr)) {
-		dev_err(dev, "DMA mapping error!\n");
-		kfree(ctx_addr);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	return ctx_addr;
-}
-
-static void qm_ctx_free(struct hisi_qm *qm, size_t ctx_size,
-			const void *ctx_addr, dma_addr_t *dma_addr)
-{
-	struct device *dev = &qm->pdev->dev;
-
-	dma_unmap_single(dev, *dma_addr, ctx_size, DMA_FROM_DEVICE);
-	kfree(ctx_addr);
-}
-
-static int qm_dump_sqc_raw(struct hisi_qm *qm, dma_addr_t dma_addr, u16 qp_id)
-{
-	return qm_mb(qm, QM_MB_CMD_SQC, dma_addr, qp_id, 1);
-}
-
-static int qm_dump_cqc_raw(struct hisi_qm *qm, dma_addr_t dma_addr, u16 qp_id)
-{
-	return qm_mb(qm, QM_MB_CMD_CQC, dma_addr, qp_id, 1);
-}
-
 /**
  * Determine whether the queue is cleared by judging the tail pointers of
  * sq and cq.
@@ -2346,6 +2777,8 @@ int hisi_qm_debug_init(struct hisi_qm *qm)
 
 	debugfs_create_file("qm_regs", 0444, qm->debug.qm_d, qm, &qm_regs_fops);
 
+	debugfs_create_file("cmd", 0444, qm->debug.qm_d, qm, &qm_cmd_fops);
+
 	debugfs_create_file("status", 0444, qm->debug.qm_d, qm,
 			&qm_status_fops);
 	for (i = 0; i < ARRAY_SIZE(qm_dfx_files); i++) {
diff --git a/drivers/crypto/hisilicon/qm.h b/drivers/crypto/hisilicon/qm.h
index e4b46a7..6326744 100644
--- a/drivers/crypto/hisilicon/qm.h
+++ b/drivers/crypto/hisilicon/qm.h
@@ -137,6 +137,8 @@ struct debugfs_file {
 
 struct qm_debug {
 	u32 curr_qm_qp_num;
+	u32 sqe_mask_offset;
+	u32 sqe_mask_len;
 	struct qm_dfx dfx;
 	struct dentry *debug_root;
 	struct dentry *qm_d;
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 5ea44ad..829959b 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -80,6 +80,9 @@
 #define SEC_VF_CNT_MASK			0xffffffc0
 #define SEC_DBGFS_VAL_MAX_LEN		20
 
+#define SEC_SQE_MASK_OFFSET		64
+#define SEC_SQE_MASK_LEN		48
+
 #define SEC_ADDR(qm, offset) ((qm)->io_base + (offset) + \
 			     SEC_ENGINE_PF_CFG_OFF + SEC_ACC_COMMON_REG_OFF)
 
@@ -632,6 +635,9 @@ static int sec_debugfs_init(struct sec_dev *sec)
 
 	qm->debug.debug_root = debugfs_create_dir(dev_name(dev),
 						  sec_debugfs_root);
+
+	qm->debug.sqe_mask_offset = SEC_SQE_MASK_OFFSET;
+	qm->debug.sqe_mask_len = SEC_SQE_MASK_LEN;
 	ret = hisi_qm_debug_init(qm);
 	if (ret)
 		goto failed_to_create;
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index cb3ed6b..87db2e1 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -89,6 +89,8 @@
 #define HZIP_WR_PORT			BIT(11)
 
 #define HZIP_BUF_SIZE			22
+#define HZIP_SQE_MASK_OFFSET		64
+#define HZIP_SQE_MASK_LEN		48
 
 static const char hisi_zip_name[] = "hisi_zip";
 static struct dentry *hzip_debugfs_root;
@@ -578,6 +580,8 @@ static int hisi_zip_debugfs_init(struct hisi_zip *hisi_zip)
 
 	dev_d = debugfs_create_dir(dev_name(dev), hzip_debugfs_root);
 
+	qm->debug.sqe_mask_offset = HZIP_SQE_MASK_OFFSET;
+	qm->debug.sqe_mask_len = HZIP_SQE_MASK_LEN;
 	qm->debug.debug_root = dev_d;
 	ret = hisi_qm_debug_init(qm);
 	if (ret)
-- 
2.7.4


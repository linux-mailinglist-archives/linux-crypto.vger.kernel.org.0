Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B59C61D944
	for <lists+linux-crypto@lfdr.de>; Sat,  5 Nov 2022 11:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiKEKAN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 5 Nov 2022 06:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiKEKAC (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 5 Nov 2022 06:00:02 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC61F193F1;
        Sat,  5 Nov 2022 02:59:58 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N4Cdx11QtzmVVM;
        Sat,  5 Nov 2022 17:59:49 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 5 Nov 2022 17:59:57 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 5 Nov
 2022 17:59:56 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH v2 2/4] crypto: hisilicon/qm - split a debugfs.c from qm
Date:   Sat, 5 Nov 2022 09:53:55 +0000
Message-ID: <20221105095357.21199-3-yekai13@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221105095357.21199-1-yekai13@huawei.com>
References: <20221105095357.21199-1-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Considering that the qm file is already very large. So move
some debugfs code to new file from qm file. The qm code logic
is not modified. And maintainability is enhanced.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/Makefile    |    2 +-
 drivers/crypto/hisilicon/debugfs.c   | 1115 +++++++++++++++++++++
 drivers/crypto/hisilicon/qm.c        | 1352 ++------------------------
 drivers/crypto/hisilicon/qm_common.h |   87 ++
 4 files changed, 1295 insertions(+), 1261 deletions(-)
 create mode 100644 drivers/crypto/hisilicon/debugfs.c
 create mode 100644 drivers/crypto/hisilicon/qm_common.h

diff --git a/drivers/crypto/hisilicon/Makefile b/drivers/crypto/hisilicon/Makefile
index 1e89269a2e4b..8595a5a5d228 100644
--- a/drivers/crypto/hisilicon/Makefile
+++ b/drivers/crypto/hisilicon/Makefile
@@ -3,6 +3,6 @@ obj-$(CONFIG_CRYPTO_DEV_HISI_HPRE) += hpre/
 obj-$(CONFIG_CRYPTO_DEV_HISI_SEC) += sec/
 obj-$(CONFIG_CRYPTO_DEV_HISI_SEC2) += sec2/
 obj-$(CONFIG_CRYPTO_DEV_HISI_QM) += hisi_qm.o
-hisi_qm-objs = qm.o sgl.o
+hisi_qm-objs = qm.o sgl.o debugfs.o
 obj-$(CONFIG_CRYPTO_DEV_HISI_ZIP) += zip/
 obj-$(CONFIG_CRYPTO_DEV_HISI_TRNG) += trng/
diff --git a/drivers/crypto/hisilicon/debugfs.c b/drivers/crypto/hisilicon/debugfs.c
new file mode 100644
index 000000000000..17befc09b0d4
--- /dev/null
+++ b/drivers/crypto/hisilicon/debugfs.c
@@ -0,0 +1,1115 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 HiSilicon Limited. */
+#include <linux/hisi_acc_qm.h>
+#include "qm_common.h"
+
+#define QM_DFX_BASE			0x0100000
+#define QM_DFX_STATE1			0x0104000
+#define QM_DFX_STATE2			0x01040C8
+#define QM_DFX_COMMON			0x0000
+#define QM_DFX_BASE_LEN			0x5A
+#define QM_DFX_STATE1_LEN		0x2E
+#define QM_DFX_STATE2_LEN		0x11
+#define QM_DFX_COMMON_LEN		0xC3
+#define QM_DFX_REGS_LEN			4UL
+#define QM_DBG_TMP_BUF_LEN		22
+#define CURRENT_FUN_MASK		GENMASK(5, 0)
+#define CURRENT_Q_MASK			GENMASK(31, 16)
+#define QM_SQE_ADDR_MASK		GENMASK(7, 0)
+
+#define QM_DFX_MB_CNT_VF		0x104010
+#define QM_DFX_DB_CNT_VF		0x104020
+#define QM_DFX_SQE_CNT_VF_SQN		0x104030
+#define QM_DFX_CQE_CNT_VF_CQN		0x104040
+#define QM_DFX_QN_SHIFT			16
+#define QM_DFX_CNT_CLR_CE		0x100118
+#define QM_DBG_WRITE_LEN		1024
+
+static const char * const qm_debug_file_name[] = {
+	[CURRENT_QM]   = "current_qm",
+	[CURRENT_Q]    = "current_q",
+	[CLEAR_ENABLE] = "clear_enable",
+};
+
+struct qm_dfx_item {
+	const char *name;
+	u32 offset;
+};
+
+static struct qm_dfx_item qm_dfx_files[] = {
+	{"err_irq", offsetof(struct qm_dfx, err_irq_cnt)},
+	{"aeq_irq", offsetof(struct qm_dfx, aeq_irq_cnt)},
+	{"abnormal_irq", offsetof(struct qm_dfx, abnormal_irq_cnt)},
+	{"create_qp_err", offsetof(struct qm_dfx, create_qp_err_cnt)},
+	{"mb_err", offsetof(struct qm_dfx, mb_err_cnt)},
+};
+
+#define CNT_CYC_REGS_NUM		10
+static const struct debugfs_reg32 qm_dfx_regs[] = {
+	/* XXX_CNT are reading clear register */
+	{"QM_ECC_1BIT_CNT               ",  0x104000ull},
+	{"QM_ECC_MBIT_CNT               ",  0x104008ull},
+	{"QM_DFX_MB_CNT                 ",  0x104018ull},
+	{"QM_DFX_DB_CNT                 ",  0x104028ull},
+	{"QM_DFX_SQE_CNT                ",  0x104038ull},
+	{"QM_DFX_CQE_CNT                ",  0x104048ull},
+	{"QM_DFX_SEND_SQE_TO_ACC_CNT    ",  0x104050ull},
+	{"QM_DFX_WB_SQE_FROM_ACC_CNT    ",  0x104058ull},
+	{"QM_DFX_ACC_FINISH_CNT         ",  0x104060ull},
+	{"QM_DFX_CQE_ERR_CNT            ",  0x1040b4ull},
+	{"QM_DFX_FUNS_ACTIVE_ST         ",  0x200ull},
+	{"QM_ECC_1BIT_INF               ",  0x104004ull},
+	{"QM_ECC_MBIT_INF               ",  0x10400cull},
+	{"QM_DFX_ACC_RDY_VLD0           ",  0x1040a0ull},
+	{"QM_DFX_ACC_RDY_VLD1           ",  0x1040a4ull},
+	{"QM_DFX_AXI_RDY_VLD            ",  0x1040a8ull},
+	{"QM_DFX_FF_ST0                 ",  0x1040c8ull},
+	{"QM_DFX_FF_ST1                 ",  0x1040ccull},
+	{"QM_DFX_FF_ST2                 ",  0x1040d0ull},
+	{"QM_DFX_FF_ST3                 ",  0x1040d4ull},
+	{"QM_DFX_FF_ST4                 ",  0x1040d8ull},
+	{"QM_DFX_FF_ST5                 ",  0x1040dcull},
+	{"QM_DFX_FF_ST6                 ",  0x1040e0ull},
+	{"QM_IN_IDLE_ST                 ",  0x1040e4ull},
+};
+
+static const struct debugfs_reg32 qm_vf_dfx_regs[] = {
+	{"QM_DFX_FUNS_ACTIVE_ST         ",  0x200ull},
+};
+
+/* define the QM's dfx regs region and region length */
+static struct dfx_diff_registers qm_diff_regs[] = {
+	{
+		.reg_offset = QM_DFX_BASE,
+		.reg_len = QM_DFX_BASE_LEN,
+	}, {
+		.reg_offset = QM_DFX_STATE1,
+		.reg_len = QM_DFX_STATE1_LEN,
+	}, {
+		.reg_offset = QM_DFX_STATE2,
+		.reg_len = QM_DFX_STATE2_LEN,
+	}, {
+		.reg_offset = QM_DFX_COMMON,
+		.reg_len = QM_DFX_COMMON_LEN,
+	},
+};
+
+static struct hisi_qm *file_to_qm(struct debugfs_file *file)
+{
+	struct qm_debug *debug = file->debug;
+
+	return container_of(debug, struct hisi_qm, debug);
+}
+
+static ssize_t qm_cmd_read(struct file *filp, char __user *buffer,
+			   size_t count, loff_t *pos)
+{
+	char buf[QM_DBG_READ_LEN];
+	int len;
+
+	len = scnprintf(buf, QM_DBG_READ_LEN, "%s\n",
+			"Please echo help to cmd to get help information");
+
+	return simple_read_from_buffer(buffer, count, pos, buf, len);
+}
+
+static void dump_show(struct hisi_qm *qm, void *info,
+		     unsigned int info_size, char *info_name)
+{
+	struct device *dev = &qm->pdev->dev;
+	u8 *info_curr = info;
+	u32 i;
+#define BYTE_PER_DW	4
+
+	dev_info(dev, "%s DUMP\n", info_name);
+	for (i = 0; i < info_size; i += BYTE_PER_DW, info_curr += BYTE_PER_DW) {
+		pr_info("DW%u: %02X%02X %02X%02X\n", i / BYTE_PER_DW,
+			*(info_curr + 3), *(info_curr + 2), *(info_curr + 1), *(info_curr));
+	}
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
+		dev_err(dev, "Please input qp num (0-%u)", qm->qp_num - 1);
+		return -EINVAL;
+	}
+
+	sqc = hisi_qm_ctx_alloc(qm, sizeof(*sqc), &sqc_dma);
+	if (IS_ERR(sqc))
+		return PTR_ERR(sqc);
+
+	/* Mailbox and reset cannot be operated at the same time */
+	if (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
+		ret = -EBUSY;
+	} else {
+		ret = hisi_qm_mb(qm, QM_MB_CMD_SQC, sqc_dma, qp_id, 1);
+		clear_bit(QM_RESETTING, &qm->misc_ctl);
+	}
+
+	if (ret) {
+		down_read(&qm->qps_lock);
+		if (qm->sqc) {
+			sqc_curr = qm->sqc + qp_id;
+
+			dump_show(qm, sqc_curr, sizeof(*sqc), "SOFT SQC");
+		}
+		up_read(&qm->qps_lock);
+
+		goto free_ctx;
+	}
+
+	dump_show(qm, sqc, sizeof(*sqc), "SQC");
+
+free_ctx:
+	hisi_qm_ctx_free(qm, sizeof(*sqc), sqc, &sqc_dma);
+	return 0;
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
+		dev_err(dev, "Please input qp num (0-%u)", qm->qp_num - 1);
+		return -EINVAL;
+	}
+
+	cqc = hisi_qm_ctx_alloc(qm, sizeof(*cqc), &cqc_dma);
+	if (IS_ERR(cqc))
+		return PTR_ERR(cqc);
+
+	/* Mailbox and reset cannot be operated at the same time */
+	if (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
+		ret = -EBUSY;
+	} else {
+		ret = hisi_qm_mb(qm, QM_MB_CMD_CQC, cqc_dma, qp_id, 1);
+		clear_bit(QM_RESETTING, &qm->misc_ctl);
+	}
+
+	if (ret) {
+		down_read(&qm->qps_lock);
+		if (qm->cqc) {
+			cqc_curr = qm->cqc + qp_id;
+
+			dump_show(qm, cqc_curr, sizeof(*cqc), "SOFT CQC");
+		}
+		up_read(&qm->qps_lock);
+
+		goto free_ctx;
+	}
+
+	dump_show(qm, cqc, sizeof(*cqc), "CQC");
+
+free_ctx:
+	hisi_qm_ctx_free(qm, sizeof(*cqc), cqc, &cqc_dma);
+	return 0;
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
+	xeqc = hisi_qm_ctx_alloc(qm, size, &xeqc_dma);
+	if (IS_ERR(xeqc))
+		return PTR_ERR(xeqc);
+
+	ret = hisi_qm_mb(qm, cmd, xeqc_dma, 0, 1);
+	if (ret)
+		goto err_free_ctx;
+
+	dump_show(qm, xeqc, size, name);
+
+err_free_ctx:
+	hisi_qm_ctx_free(qm, size, xeqc, &xeqc_dma);
+	return ret;
+}
+
+static int q_dump_param_parse(struct hisi_qm *qm, char *s,
+			      u32 *e_id, u32 *q_id, u16 q_depth)
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
+		dev_err(dev, "Please input qp num (0-%u)", qp_num - 1);
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
+	if (ret || *e_id >= q_depth) {
+		dev_err(dev, "Please input sqe num (0-%u)", q_depth - 1);
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
+	u16 sq_depth = qm->qp_array->cq_depth;
+	void *sqe, *sqe_curr;
+	struct hisi_qp *qp;
+	u32 qp_id, sqe_id;
+	int ret;
+
+	ret = q_dump_param_parse(qm, s, &sqe_id, &qp_id, sq_depth);
+	if (ret)
+		return ret;
+
+	sqe = kzalloc(qm->sqe_size * sq_depth, GFP_KERNEL);
+	if (!sqe)
+		return -ENOMEM;
+
+	qp = &qm->qp_array[qp_id];
+	memcpy(sqe, qp->sqe, qm->sqe_size * sq_depth);
+	sqe_curr = sqe + (u32)(sqe_id * qm->sqe_size);
+	memset(sqe_curr + qm->debug.sqe_mask_offset, QM_SQE_ADDR_MASK,
+	       qm->debug.sqe_mask_len);
+
+	dump_show(qm, sqe_curr, qm->sqe_size, "SQE");
+
+	kfree(sqe);
+
+	return 0;
+}
+
+static int qm_cq_dump(struct hisi_qm *qm, char *s)
+{
+	struct qm_cqe *cqe_curr;
+	struct hisi_qp *qp;
+	u32 qp_id, cqe_id;
+	int ret;
+
+	ret = q_dump_param_parse(qm, s, &cqe_id, &qp_id, qm->qp_array->cq_depth);
+	if (ret)
+		return ret;
+
+	qp = &qm->qp_array[qp_id];
+	cqe_curr = qp->cqe + cqe_id;
+	dump_show(qm, cqe_curr, sizeof(struct qm_cqe), "CQE");
+
+	return 0;
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
+	if (ret)
+		return -EINVAL;
+
+	if (!strcmp(name, "EQE") && xeqe_id >= qm->eq_depth) {
+		dev_err(dev, "Please input eqe num (0-%u)", qm->eq_depth - 1);
+		return -EINVAL;
+	} else if (!strcmp(name, "AEQE") && xeqe_id >= qm->aeq_depth) {
+		dev_err(dev, "Please input aeqe num (0-%u)", qm->eq_depth - 1);
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
+	dump_show(qm, xeqe, size, name);
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
+	char *presult, *s, *s_tmp;
+	int ret;
+
+	s = kstrdup(cmd_buf, GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+
+	s_tmp = s;
+	presult = strsep(&s, " ");
+	if (!presult) {
+		ret = -EINVAL;
+		goto err_buffer_free;
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
+err_buffer_free:
+	kfree(s_tmp);
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
+	ret = hisi_qm_get_dfx_access(qm);
+	if (ret)
+		return ret;
+
+	/* Judge if the instance is being reset. */
+	if (unlikely(atomic_read(&qm->status.flags) == QM_STOP)) {
+		ret = 0;
+		goto put_dfx_access;
+	}
+
+	if (count > QM_DBG_WRITE_LEN) {
+		ret = -ENOSPC;
+		goto put_dfx_access;
+	}
+
+	cmd_buf = memdup_user_nul(buffer, count);
+	if (IS_ERR(cmd_buf)) {
+		ret = PTR_ERR(cmd_buf);
+		goto put_dfx_access;
+	}
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
+		goto put_dfx_access;
+	}
+
+	kfree(cmd_buf);
+
+	ret = count;
+
+put_dfx_access:
+	hisi_qm_put_dfx_access(qm);
+	return ret;
+}
+
+static const struct file_operations qm_cmd_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = qm_cmd_read,
+	.write = qm_cmd_write,
+};
+
+/**
+ * hisi_qm_regs_dump() - Dump registers's value.
+ * @s: debugfs file handle.
+ * @regset: accelerator registers information.
+ *
+ * Dump accelerator registers.
+ */
+void hisi_qm_regs_dump(struct seq_file *s, struct debugfs_regset32 *regset)
+{
+	struct pci_dev *pdev = to_pci_dev(regset->dev);
+	struct hisi_qm *qm = pci_get_drvdata(pdev);
+	const struct debugfs_reg32 *regs = regset->regs;
+	int regs_len = regset->nregs;
+	int i, ret;
+	u32 val;
+
+	ret = hisi_qm_get_dfx_access(qm);
+	if (ret)
+		return;
+
+	for (i = 0; i < regs_len; i++) {
+		val = readl(regset->base + regs[i].offset);
+		seq_printf(s, "%s= 0x%08x\n", regs[i].name, val);
+	}
+
+	hisi_qm_put_dfx_access(qm);
+}
+EXPORT_SYMBOL_GPL(hisi_qm_regs_dump);
+
+static int qm_regs_show(struct seq_file *s, void *unused)
+{
+	struct hisi_qm *qm = s->private;
+	struct debugfs_regset32 regset;
+
+	if (qm->fun_type == QM_HW_PF) {
+		regset.regs = qm_dfx_regs;
+		regset.nregs = ARRAY_SIZE(qm_dfx_regs);
+	} else {
+		regset.regs = qm_vf_dfx_regs;
+		regset.nregs = ARRAY_SIZE(qm_vf_dfx_regs);
+	}
+
+	regset.base = qm->io_base;
+	regset.dev = &qm->pdev->dev;
+
+	hisi_qm_regs_dump(s, &regset);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(qm_regs);
+
+static u32 current_q_read(struct hisi_qm *qm)
+{
+	return readl(qm->io_base + QM_DFX_SQE_CNT_VF_SQN) >> QM_DFX_QN_SHIFT;
+}
+
+static int current_q_write(struct hisi_qm *qm, u32 val)
+{
+	u32 tmp;
+
+	if (val >= qm->debug.curr_qm_qp_num)
+		return -EINVAL;
+
+	tmp = val << QM_DFX_QN_SHIFT |
+	      (readl(qm->io_base + QM_DFX_SQE_CNT_VF_SQN) & CURRENT_FUN_MASK);
+	writel(tmp, qm->io_base + QM_DFX_SQE_CNT_VF_SQN);
+
+	tmp = val << QM_DFX_QN_SHIFT |
+	      (readl(qm->io_base + QM_DFX_CQE_CNT_VF_CQN) & CURRENT_FUN_MASK);
+	writel(tmp, qm->io_base + QM_DFX_CQE_CNT_VF_CQN);
+
+	return 0;
+}
+
+static u32 clear_enable_read(struct hisi_qm *qm)
+{
+	return readl(qm->io_base + QM_DFX_CNT_CLR_CE);
+}
+
+/* rd_clr_ctrl 1 enable read clear, otherwise 0 disable it */
+static int clear_enable_write(struct hisi_qm *qm, u32 rd_clr_ctrl)
+{
+	if (rd_clr_ctrl > 1)
+		return -EINVAL;
+
+	writel(rd_clr_ctrl, qm->io_base + QM_DFX_CNT_CLR_CE);
+
+	return 0;
+}
+
+static u32 current_qm_read(struct hisi_qm *qm)
+{
+	return readl(qm->io_base + QM_DFX_MB_CNT_VF);
+}
+
+static int qm_get_vf_qp_num(struct hisi_qm *qm, u32 fun_num)
+{
+	u32 remain_q_num, vfq_num;
+	u32 num_vfs = qm->vfs_num;
+
+	vfq_num = (qm->ctrl_qp_num - qm->qp_num) / num_vfs;
+	if (vfq_num >= qm->max_qp_num)
+		return qm->max_qp_num;
+
+	remain_q_num = (qm->ctrl_qp_num - qm->qp_num) % num_vfs;
+	if (vfq_num + remain_q_num <= qm->max_qp_num)
+		return fun_num == num_vfs ? vfq_num + remain_q_num : vfq_num;
+
+	/*
+	 * if vfq_num + remain_q_num > max_qp_num, the last VFs,
+	 * each with one more queue.
+	 */
+	return fun_num + remain_q_num > num_vfs ? vfq_num + 1 : vfq_num;
+}
+
+static int current_qm_write(struct hisi_qm *qm, u32 val)
+{
+	u32 tmp;
+
+	if (val > qm->vfs_num)
+		return -EINVAL;
+
+	/* According PF or VF Dev ID to calculation curr_qm_qp_num and store */
+	if (!val)
+		qm->debug.curr_qm_qp_num = qm->qp_num;
+	else
+		qm->debug.curr_qm_qp_num = qm_get_vf_qp_num(qm, val);
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
+static ssize_t qm_debug_read(struct file *filp, char __user *buf,
+			     size_t count, loff_t *pos)
+{
+	struct debugfs_file *file = filp->private_data;
+	enum qm_debug_file index = file->index;
+	struct hisi_qm *qm = file_to_qm(file);
+	char tbuf[QM_DBG_TMP_BUF_LEN];
+	u32 val;
+	int ret;
+
+	ret = hisi_qm_get_dfx_access(qm);
+	if (ret)
+		return ret;
+
+	mutex_lock(&file->lock);
+	switch (index) {
+	case CURRENT_QM:
+		val = current_qm_read(qm);
+		break;
+	case CURRENT_Q:
+		val = current_q_read(qm);
+		break;
+	case CLEAR_ENABLE:
+		val = clear_enable_read(qm);
+		break;
+	default:
+		goto err_input;
+	}
+	mutex_unlock(&file->lock);
+
+	hisi_qm_put_dfx_access(qm);
+	ret = scnprintf(tbuf, QM_DBG_TMP_BUF_LEN, "%u\n", val);
+	return simple_read_from_buffer(buf, count, pos, tbuf, ret);
+
+err_input:
+	mutex_unlock(&file->lock);
+	hisi_qm_put_dfx_access(qm);
+	return -EINVAL;
+}
+
+static ssize_t qm_debug_write(struct file *filp, const char __user *buf,
+			      size_t count, loff_t *pos)
+{
+	struct debugfs_file *file = filp->private_data;
+	enum qm_debug_file index = file->index;
+	struct hisi_qm *qm = file_to_qm(file);
+	unsigned long val;
+	char tbuf[QM_DBG_TMP_BUF_LEN];
+	int len, ret;
+
+	if (*pos != 0)
+		return 0;
+
+	if (count >= QM_DBG_TMP_BUF_LEN)
+		return -ENOSPC;
+
+	len = simple_write_to_buffer(tbuf, QM_DBG_TMP_BUF_LEN - 1, pos, buf,
+				     count);
+	if (len < 0)
+		return len;
+
+	tbuf[len] = '\0';
+	if (kstrtoul(tbuf, 0, &val))
+		return -EFAULT;
+
+	ret = hisi_qm_get_dfx_access(qm);
+	if (ret)
+		return ret;
+
+	mutex_lock(&file->lock);
+	switch (index) {
+	case CURRENT_QM:
+		ret = current_qm_write(qm, val);
+		break;
+	case CURRENT_Q:
+		ret = current_q_write(qm, val);
+		break;
+	case CLEAR_ENABLE:
+		ret = clear_enable_write(qm, val);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	mutex_unlock(&file->lock);
+
+	hisi_qm_put_dfx_access(qm);
+
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static const struct file_operations qm_debug_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = qm_debug_read,
+	.write = qm_debug_write,
+};
+
+static void dfx_regs_uninit(struct hisi_qm *qm,
+		struct dfx_diff_registers *dregs, int reg_len)
+{
+	int i;
+
+	/* Setting the pointer is NULL to prevent double free */
+	for (i = 0; i < reg_len; i++) {
+		kfree(dregs[i].regs);
+		dregs[i].regs = NULL;
+	}
+	kfree(dregs);
+	dregs = NULL;
+}
+
+static struct dfx_diff_registers *dfx_regs_init(struct hisi_qm *qm,
+	const struct dfx_diff_registers *cregs, u32 reg_len)
+{
+	struct dfx_diff_registers *diff_regs;
+	u32 j, base_offset;
+	int i;
+
+	diff_regs = kcalloc(reg_len, sizeof(*diff_regs), GFP_KERNEL);
+	if (!diff_regs)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < reg_len; i++) {
+		if (!cregs[i].reg_len)
+			continue;
+
+		diff_regs[i].reg_offset = cregs[i].reg_offset;
+		diff_regs[i].reg_len = cregs[i].reg_len;
+		diff_regs[i].regs = kcalloc(QM_DFX_REGS_LEN, cregs[i].reg_len,
+					 GFP_KERNEL);
+		if (!diff_regs[i].regs)
+			goto alloc_error;
+
+		for (j = 0; j < diff_regs[i].reg_len; j++) {
+			base_offset = diff_regs[i].reg_offset +
+					j * QM_DFX_REGS_LEN;
+			diff_regs[i].regs[j] = readl(qm->io_base + base_offset);
+		}
+	}
+
+	return diff_regs;
+
+alloc_error:
+	while (i > 0) {
+		i--;
+		kfree(diff_regs[i].regs);
+	}
+	kfree(diff_regs);
+	return ERR_PTR(-ENOMEM);
+}
+
+static int qm_diff_regs_init(struct hisi_qm *qm,
+		struct dfx_diff_registers *dregs, u32 reg_len)
+{
+	qm->debug.qm_diff_regs = dfx_regs_init(qm, qm_diff_regs,
+					       ARRAY_SIZE(qm_diff_regs));
+	if (IS_ERR(qm->debug.qm_diff_regs))
+		return PTR_ERR(qm->debug.qm_diff_regs);
+
+	qm->debug.acc_diff_regs = dfx_regs_init(qm, dregs, reg_len);
+	if (IS_ERR(qm->debug.acc_diff_regs)) {
+		dfx_regs_uninit(qm, qm->debug.qm_diff_regs,
+				ARRAY_SIZE(qm_diff_regs));
+		return PTR_ERR(qm->debug.acc_diff_regs);
+	}
+
+	return 0;
+}
+
+static void qm_last_regs_uninit(struct hisi_qm *qm)
+{
+	struct qm_debug *debug = &qm->debug;
+
+	if (qm->fun_type == QM_HW_VF || !debug->qm_last_words)
+		return;
+
+	kfree(debug->qm_last_words);
+	debug->qm_last_words = NULL;
+}
+
+static int qm_last_regs_init(struct hisi_qm *qm)
+{
+	int dfx_regs_num = ARRAY_SIZE(qm_dfx_regs);
+	struct qm_debug *debug = &qm->debug;
+	int i;
+
+	if (qm->fun_type == QM_HW_VF)
+		return 0;
+
+	debug->qm_last_words = kcalloc(dfx_regs_num, sizeof(unsigned int),
+								GFP_KERNEL);
+	if (!debug->qm_last_words)
+		return -ENOMEM;
+
+	for (i = 0; i < dfx_regs_num; i++) {
+		debug->qm_last_words[i] = readl_relaxed(qm->io_base +
+			qm_dfx_regs[i].offset);
+	}
+
+	return 0;
+}
+
+static void qm_diff_regs_uninit(struct hisi_qm *qm, u32 reg_len)
+{
+	dfx_regs_uninit(qm, qm->debug.acc_diff_regs, reg_len);
+	dfx_regs_uninit(qm, qm->debug.qm_diff_regs, ARRAY_SIZE(qm_diff_regs));
+}
+
+/**
+ * hisi_qm_regs_debugfs_init() - Allocate memory for registers.
+ * @qm: device qm handle.
+ * @dregs: diff registers handle.
+ * @reg_len: diff registers region length.
+ */
+int hisi_qm_regs_debugfs_init(struct hisi_qm *qm,
+		struct dfx_diff_registers *dregs, u32 reg_len)
+{
+	int ret;
+
+	if (!qm || !dregs)
+		return -EINVAL;
+
+	if (qm->fun_type != QM_HW_PF)
+		return 0;
+
+	ret = qm_last_regs_init(qm);
+	if (ret) {
+		dev_info(&qm->pdev->dev, "failed to init qm words memory.\n");
+		return ret;
+	}
+
+	ret = qm_diff_regs_init(qm, dregs, reg_len);
+	if (ret) {
+		qm_last_regs_uninit(qm);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hisi_qm_regs_debugfs_init);
+
+/**
+ * hisi_qm_regs_debugfs_uninit() - Free memory for registers.
+ * @qm: device qm handle.
+ * @reg_len: diff registers region length.
+ */
+void hisi_qm_regs_debugfs_uninit(struct hisi_qm *qm, u32 reg_len)
+{
+	if (!qm || qm->fun_type != QM_HW_PF)
+		return;
+
+	qm_diff_regs_uninit(qm, reg_len);
+	qm_last_regs_uninit(qm);
+}
+EXPORT_SYMBOL_GPL(hisi_qm_regs_debugfs_uninit);
+
+/**
+ * hisi_qm_acc_diff_regs_dump() - Dump registers's value.
+ * @qm: device qm handle.
+ * @s: Debugfs file handle.
+ * @dregs: diff registers handle.
+ * @regs_len: diff registers region length.
+ */
+void hisi_qm_acc_diff_regs_dump(struct hisi_qm *qm, struct seq_file *s,
+	struct dfx_diff_registers *dregs, u32 regs_len)
+{
+	u32 j, val, base_offset;
+	int i, ret;
+
+	if (!qm || !s || !dregs)
+		return;
+
+	ret = hisi_qm_get_dfx_access(qm);
+	if (ret)
+		return;
+
+	down_read(&qm->qps_lock);
+	for (i = 0; i < regs_len; i++) {
+		if (!dregs[i].reg_len)
+			continue;
+
+		for (j = 0; j < dregs[i].reg_len; j++) {
+			base_offset = dregs[i].reg_offset + j * QM_DFX_REGS_LEN;
+			val = readl(qm->io_base + base_offset);
+			if (val != dregs[i].regs[j])
+				seq_printf(s, "0x%08x = 0x%08x ---> 0x%08x\n",
+					   base_offset, dregs[i].regs[j], val);
+		}
+	}
+	up_read(&qm->qps_lock);
+
+	hisi_qm_put_dfx_access(qm);
+}
+EXPORT_SYMBOL_GPL(hisi_qm_acc_diff_regs_dump);
+
+void hisi_qm_show_last_dfx_regs(struct hisi_qm *qm)
+{
+	struct qm_debug *debug = &qm->debug;
+	struct pci_dev *pdev = qm->pdev;
+	u32 val;
+	int i;
+
+	if (qm->fun_type == QM_HW_VF || !debug->qm_last_words)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(qm_dfx_regs); i++) {
+		val = readl_relaxed(qm->io_base + qm_dfx_regs[i].offset);
+		if (debug->qm_last_words[i] != val)
+			pci_info(pdev, "%s \t= 0x%08x => 0x%08x\n",
+			qm_dfx_regs[i].name, debug->qm_last_words[i], val);
+	}
+}
+
+static int qm_diff_regs_show(struct seq_file *s, void *unused)
+{
+	struct hisi_qm *qm = s->private;
+
+	hisi_qm_acc_diff_regs_dump(qm, s, qm->debug.qm_diff_regs,
+					ARRAY_SIZE(qm_diff_regs));
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(qm_diff_regs);
+
+static ssize_t qm_status_read(struct file *filp, char __user *buffer,
+			      size_t count, loff_t *pos)
+{
+	struct hisi_qm *qm = filp->private_data;
+	char buf[QM_DBG_READ_LEN];
+	int val, len;
+
+	val = atomic_read(&qm->status.flags);
+	len = scnprintf(buf, QM_DBG_READ_LEN, "%s\n", qm_s[val]);
+
+	return simple_read_from_buffer(buffer, count, pos, buf, len);
+}
+
+static const struct file_operations qm_status_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = qm_status_read,
+};
+
+static void qm_create_debugfs_file(struct hisi_qm *qm, struct dentry *dir,
+				   enum qm_debug_file index)
+{
+	struct debugfs_file *file = qm->debug.files + index;
+
+	debugfs_create_file(qm_debug_file_name[index], 0600, dir, file,
+			    &qm_debug_fops);
+
+	file->index = index;
+	mutex_init(&file->lock);
+	file->debug = &qm->debug;
+}
+
+static int qm_debugfs_atomic64_set(void *data, u64 val)
+{
+	if (val)
+		return -EINVAL;
+
+	atomic64_set((atomic64_t *)data, 0);
+
+	return 0;
+}
+
+static int qm_debugfs_atomic64_get(void *data, u64 *val)
+{
+	*val = atomic64_read((atomic64_t *)data);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(qm_atomic64_ops, qm_debugfs_atomic64_get,
+			 qm_debugfs_atomic64_set, "%llu\n");
+
+/**
+ * hisi_qm_debug_init() - Initialize qm related debugfs files.
+ * @qm: The qm for which we want to add debugfs files.
+ *
+ * Create qm related debugfs files.
+ */
+void hisi_qm_debug_init(struct hisi_qm *qm)
+{
+	struct dfx_diff_registers *qm_regs = qm->debug.qm_diff_regs;
+	struct qm_dfx *dfx = &qm->debug.dfx;
+	struct dentry *qm_d;
+	void *data;
+	int i;
+
+	qm_d = debugfs_create_dir("qm", qm->debug.debug_root);
+	qm->debug.qm_d = qm_d;
+
+	/* only show this in PF */
+	if (qm->fun_type == QM_HW_PF) {
+		qm_create_debugfs_file(qm, qm->debug.debug_root, CURRENT_QM);
+		for (i = CURRENT_Q; i < DEBUG_FILE_NUM; i++)
+			qm_create_debugfs_file(qm, qm->debug.qm_d, i);
+	}
+
+	if (qm_regs)
+		debugfs_create_file("diff_regs", 0444, qm->debug.qm_d,
+					qm, &qm_diff_regs_fops);
+
+	debugfs_create_file("regs", 0444, qm->debug.qm_d, qm, &qm_regs_fops);
+
+	debugfs_create_file("cmd", 0600, qm->debug.qm_d, qm, &qm_cmd_fops);
+
+	debugfs_create_file("status", 0444, qm->debug.qm_d, qm,
+			&qm_status_fops);
+	for (i = 0; i < ARRAY_SIZE(qm_dfx_files); i++) {
+		data = (atomic64_t *)((uintptr_t)dfx + qm_dfx_files[i].offset);
+		debugfs_create_file(qm_dfx_files[i].name,
+			0644,
+			qm_d,
+			data,
+			&qm_atomic64_ops);
+	}
+
+	if (test_bit(QM_SUPPORT_FUNC_QOS, &qm->caps))
+		hisi_qm_set_algqos_init(qm);
+}
+EXPORT_SYMBOL_GPL(hisi_qm_debug_init);
+
+/**
+ * hisi_qm_debug_regs_clear() - clear qm debug related registers.
+ * @qm: The qm for which we want to clear its debug registers.
+ */
+void hisi_qm_debug_regs_clear(struct hisi_qm *qm)
+{
+	const struct debugfs_reg32 *regs;
+	int i;
+
+	/* clear current_qm */
+	writel(0x0, qm->io_base + QM_DFX_MB_CNT_VF);
+	writel(0x0, qm->io_base + QM_DFX_DB_CNT_VF);
+
+	/* clear current_q */
+	writel(0x0, qm->io_base + QM_DFX_SQE_CNT_VF_SQN);
+	writel(0x0, qm->io_base + QM_DFX_CQE_CNT_VF_CQN);
+
+	/*
+	 * these registers are reading and clearing, so clear them after
+	 * reading them.
+	 */
+	writel(0x1, qm->io_base + QM_DFX_CNT_CLR_CE);
+
+	regs = qm_dfx_regs;
+	for (i = 0; i < CNT_CYC_REGS_NUM; i++) {
+		readl(qm->io_base + regs->offset);
+		regs++;
+	}
+
+	/* clear clear_enable */
+	writel(0x0, qm->io_base + QM_DFX_CNT_CLR_CE);
+}
+EXPORT_SYMBOL_GPL(hisi_qm_debug_regs_clear);
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 832cfd9a7728..36d70b9f6117 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -16,6 +16,7 @@
 #include <linux/uaccess.h>
 #include <uapi/misc/uacce/hisi_qm.h>
 #include <linux/hisi_acc_qm.h>
+#include "qm_common.h"
 
 /* eq/aeq irq enable */
 #define QM_VF_AEQ_INT_SOURCE		0x0
@@ -119,8 +120,6 @@
 #define QM_SQC_VFT_NUM_SHIFT_V2		45
 #define QM_SQC_VFT_NUM_MASK_v2		GENMASK(9, 0)
 
-#define QM_DFX_CNT_CLR_CE		0x100118
-
 #define QM_ABNORMAL_INT_SOURCE		0x100000
 #define QM_ABNORMAL_INT_MASK		0x100004
 #define QM_ABNORMAL_INT_MASK_VALUE	0x7fff
@@ -187,14 +186,6 @@
 #define QM_VF_RESET_WAIT_TIMEOUT_US    \
 	(QM_VF_RESET_WAIT_US * QM_VF_RESET_WAIT_CNT)
 
-#define QM_DFX_MB_CNT_VF		0x104010
-#define QM_DFX_DB_CNT_VF		0x104020
-#define QM_DFX_SQE_CNT_VF_SQN		0x104030
-#define QM_DFX_CQE_CNT_VF_CQN		0x104040
-#define QM_DFX_QN_SHIFT			16
-#define CURRENT_FUN_MASK		GENMASK(5, 0)
-#define CURRENT_Q_MASK			GENMASK(31, 16)
-
 #define POLL_PERIOD			10
 #define POLL_TIMEOUT			1000
 #define WAIT_PERIOD_US_MAX		200
@@ -211,19 +202,15 @@
 #define QMC_ALIGN(sz)			ALIGN(sz, 32)
 
 #define QM_DBG_READ_LEN		256
-#define QM_DBG_WRITE_LEN		1024
-#define QM_DBG_TMP_BUF_LEN		22
 #define QM_PCI_COMMAND_INVALID		~0
 #define QM_RESET_STOP_TX_OFFSET		1
 #define QM_RESET_STOP_RX_OFFSET		2
 
 #define WAIT_PERIOD			20
 #define REMOVE_WAIT_DELAY		10
-#define QM_SQE_ADDR_MASK		GENMASK(7, 0)
 
 #define QM_DRIVER_REMOVING		0
 #define QM_RST_SCHED			1
-#define QM_RESETTING			2
 #define QM_QOS_PARAM_NUM		2
 #define QM_QOS_VAL_NUM			1
 #define QM_QOS_BDF_PARAM_NUM		4
@@ -250,15 +237,6 @@
 #define QM_QOS_MIN_CIR_B		100
 #define QM_QOS_MAX_CIR_U		6
 #define QM_QOS_MAX_CIR_S		11
-#define QM_DFX_BASE		0x0100000
-#define QM_DFX_STATE1		0x0104000
-#define QM_DFX_STATE2		0x01040C8
-#define QM_DFX_COMMON		0x0000
-#define QM_DFX_BASE_LEN		0x5A
-#define QM_DFX_STATE1_LEN		0x2E
-#define QM_DFX_STATE2_LEN		0x11
-#define QM_DFX_COMMON_LEN		0xC3
-#define QM_DFX_REGS_LEN		4UL
 #define QM_AUTOSUSPEND_DELAY		3000
 
 #define QM_MK_CQC_DW3_V1(hop_num, pg_sz, buf_sz, cqe_sz) \
@@ -368,73 +346,6 @@ static const struct hisi_qm_cap_info qm_basic_info[] = {
 	{QM_VF_IRQ_NUM_CAP,     0x311c,   0,  GENMASK(15, 0), 0x1,       0x2,       0x3},
 };
 
-struct qm_cqe {
-	__le32 rsvd0;
-	__le16 cmd_id;
-	__le16 rsvd1;
-	__le16 sq_head;
-	__le16 sq_num;
-	__le16 rsvd2;
-	__le16 w7;
-};
-
-struct qm_eqe {
-	__le32 dw0;
-};
-
-struct qm_aeqe {
-	__le32 dw0;
-};
-
-struct qm_sqc {
-	__le16 head;
-	__le16 tail;
-	__le32 base_l;
-	__le32 base_h;
-	__le32 dw3;
-	__le16 w8;
-	__le16 rsvd0;
-	__le16 pasid;
-	__le16 w11;
-	__le16 cq_num;
-	__le16 w13;
-	__le32 rsvd1;
-};
-
-struct qm_cqc {
-	__le16 head;
-	__le16 tail;
-	__le32 base_l;
-	__le32 base_h;
-	__le32 dw3;
-	__le16 w8;
-	__le16 rsvd0;
-	__le16 pasid;
-	__le16 w11;
-	__le32 dw6;
-	__le32 rsvd1;
-};
-
-struct qm_eqc {
-	__le16 head;
-	__le16 tail;
-	__le32 base_l;
-	__le32 base_h;
-	__le32 dw3;
-	__le32 rsvd[2];
-	__le32 dw6;
-};
-
-struct qm_aeqc {
-	__le16 head;
-	__le16 tail;
-	__le32 base_l;
-	__le32 base_h;
-	__le32 dw3;
-	__le32 rsvd[2];
-	__le32 dw6;
-};
-
 struct qm_mailbox {
 	__le16 w0;
 	__le16 queue_num;
@@ -467,25 +378,6 @@ struct hisi_qm_hw_ops {
 	int (*set_msi)(struct hisi_qm *qm, bool set);
 };
 
-struct qm_dfx_item {
-	const char *name;
-	u32 offset;
-};
-
-static struct qm_dfx_item qm_dfx_files[] = {
-	{"err_irq", offsetof(struct qm_dfx, err_irq_cnt)},
-	{"aeq_irq", offsetof(struct qm_dfx, aeq_irq_cnt)},
-	{"abnormal_irq", offsetof(struct qm_dfx, abnormal_irq_cnt)},
-	{"create_qp_err", offsetof(struct qm_dfx, create_qp_err_cnt)},
-	{"mb_err", offsetof(struct qm_dfx, mb_err_cnt)},
-};
-
-static const char * const qm_debug_file_name[] = {
-	[CURRENT_QM]   = "current_qm",
-	[CURRENT_Q]    = "current_q",
-	[CLEAR_ENABLE] = "clear_enable",
-};
-
 struct hisi_qm_hw_error {
 	u32 int_msk;
 	const char *msg;
@@ -510,23 +402,6 @@ static const struct hisi_qm_hw_error qm_hw_error[] = {
 	{ /* sentinel */ }
 };
 
-/* define the QM's dfx regs region and region length */
-static struct dfx_diff_registers qm_diff_regs[] = {
-	{
-		.reg_offset = QM_DFX_BASE,
-		.reg_len = QM_DFX_BASE_LEN,
-	}, {
-		.reg_offset = QM_DFX_STATE1,
-		.reg_len = QM_DFX_STATE1_LEN,
-	}, {
-		.reg_offset = QM_DFX_STATE2,
-		.reg_len = QM_DFX_STATE2_LEN,
-	}, {
-		.reg_offset = QM_DFX_COMMON,
-		.reg_len = QM_DFX_COMMON_LEN,
-	},
-};
-
 static const char * const qm_db_timeout[] = {
 	"sq", "cq", "eq", "aeq",
 };
@@ -535,10 +410,6 @@ static const char * const qm_fifo_overflow[] = {
 	"cq", "eq", "aeq",
 };
 
-static const char * const qm_s[] = {
-	"init", "start", "close", "stop",
-};
-
 static const char * const qp_s[] = {
 	"none", "init", "start", "stop", "close",
 };
@@ -1332,1050 +1203,150 @@ static void qm_vft_data_cfg(struct hisi_qm *qm, enum vft_type type, u32 base,
 				(QM_SHAPER_CBS_B << QM_SHAPER_FACTOR_CBS_B_SHIFT) |
 				(factor->cbs_s << QM_SHAPER_FACTOR_CBS_S_SHIFT);
 			}
-			break;
-		}
-	}
-
-	writel(lower_32_bits(tmp), qm->io_base + QM_VFT_CFG_DATA_L);
-	writel(upper_32_bits(tmp), qm->io_base + QM_VFT_CFG_DATA_H);
-}
-
-static int qm_set_vft_common(struct hisi_qm *qm, enum vft_type type,
-			     u32 fun_num, u32 base, u32 number)
-{
-	struct qm_shaper_factor *factor = NULL;
-	unsigned int val;
-	int ret;
-
-	if (type == SHAPER_VFT && test_bit(QM_SUPPORT_FUNC_QOS, &qm->caps))
-		factor = &qm->factor[fun_num];
-
-	ret = readl_relaxed_poll_timeout(qm->io_base + QM_VFT_CFG_RDY, val,
-					 val & BIT(0), POLL_PERIOD,
-					 POLL_TIMEOUT);
-	if (ret)
-		return ret;
-
-	writel(0x0, qm->io_base + QM_VFT_CFG_OP_WR);
-	writel(type, qm->io_base + QM_VFT_CFG_TYPE);
-	if (type == SHAPER_VFT)
-		fun_num |= base << QM_SHAPER_VFT_OFFSET;
-
-	writel(fun_num, qm->io_base + QM_VFT_CFG);
-
-	qm_vft_data_cfg(qm, type, base, number, factor);
-
-	writel(0x0, qm->io_base + QM_VFT_CFG_RDY);
-	writel(0x1, qm->io_base + QM_VFT_CFG_OP_ENABLE);
-
-	return readl_relaxed_poll_timeout(qm->io_base + QM_VFT_CFG_RDY, val,
-					  val & BIT(0), POLL_PERIOD,
-					  POLL_TIMEOUT);
-}
-
-static int qm_shaper_init_vft(struct hisi_qm *qm, u32 fun_num)
-{
-	u32 qos = qm->factor[fun_num].func_qos;
-	int ret, i;
-
-	ret = qm_get_shaper_para(qos * QM_QOS_RATE, &qm->factor[fun_num]);
-	if (ret) {
-		dev_err(&qm->pdev->dev, "failed to calculate shaper parameter!\n");
-		return ret;
-	}
-	writel(qm->type_rate, qm->io_base + QM_SHAPER_CFG);
-	for (i = ALG_TYPE_0; i <= ALG_TYPE_1; i++) {
-		/* The base number of queue reuse for different alg type */
-		ret = qm_set_vft_common(qm, SHAPER_VFT, fun_num, i, 1);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-/* The config should be conducted after qm_dev_mem_reset() */
-static int qm_set_sqc_cqc_vft(struct hisi_qm *qm, u32 fun_num, u32 base,
-			      u32 number)
-{
-	int ret, i;
-
-	for (i = SQC_VFT; i <= CQC_VFT; i++) {
-		ret = qm_set_vft_common(qm, i, fun_num, base, number);
-		if (ret)
-			return ret;
-	}
-
-	/* init default shaper qos val */
-	if (test_bit(QM_SUPPORT_FUNC_QOS, &qm->caps)) {
-		ret = qm_shaper_init_vft(qm, fun_num);
-		if (ret)
-			goto back_sqc_cqc;
-	}
-
-	return 0;
-back_sqc_cqc:
-	for (i = SQC_VFT; i <= CQC_VFT; i++)
-		qm_set_vft_common(qm, i, fun_num, 0, 0);
-
-	return ret;
-}
-
-static int qm_get_vft_v2(struct hisi_qm *qm, u32 *base, u32 *number)
-{
-	u64 sqc_vft;
-	int ret;
-
-	ret = hisi_qm_mb(qm, QM_MB_CMD_SQC_VFT_V2, 0, 0, 1);
-	if (ret)
-		return ret;
-
-	sqc_vft = readl(qm->io_base + QM_MB_CMD_DATA_ADDR_L) |
-		  ((u64)readl(qm->io_base + QM_MB_CMD_DATA_ADDR_H) << 32);
-	*base = QM_SQC_VFT_BASE_MASK_V2 & (sqc_vft >> QM_SQC_VFT_BASE_SHIFT_V2);
-	*number = (QM_SQC_VFT_NUM_MASK_v2 &
-		   (sqc_vft >> QM_SQC_VFT_NUM_SHIFT_V2)) + 1;
-
-	return 0;
-}
-
-static int qm_get_vf_qp_num(struct hisi_qm *qm, u32 fun_num)
-{
-	u32 remain_q_num, vfq_num;
-	u32 num_vfs = qm->vfs_num;
-
-	vfq_num = (qm->ctrl_qp_num - qm->qp_num) / num_vfs;
-	if (vfq_num >= qm->max_qp_num)
-		return qm->max_qp_num;
-
-	remain_q_num = (qm->ctrl_qp_num - qm->qp_num) % num_vfs;
-	if (vfq_num + remain_q_num <= qm->max_qp_num)
-		return fun_num == num_vfs ? vfq_num + remain_q_num : vfq_num;
-
-	/*
-	 * if vfq_num + remain_q_num > max_qp_num, the last VFs,
-	 * each with one more queue.
-	 */
-	return fun_num + remain_q_num > num_vfs ? vfq_num + 1 : vfq_num;
-}
-
-static struct hisi_qm *file_to_qm(struct debugfs_file *file)
-{
-	struct qm_debug *debug = file->debug;
-
-	return container_of(debug, struct hisi_qm, debug);
-}
-
-static u32 current_q_read(struct hisi_qm *qm)
-{
-	return readl(qm->io_base + QM_DFX_SQE_CNT_VF_SQN) >> QM_DFX_QN_SHIFT;
-}
-
-static int current_q_write(struct hisi_qm *qm, u32 val)
-{
-	u32 tmp;
-
-	if (val >= qm->debug.curr_qm_qp_num)
-		return -EINVAL;
-
-	tmp = val << QM_DFX_QN_SHIFT |
-	      (readl(qm->io_base + QM_DFX_SQE_CNT_VF_SQN) & CURRENT_FUN_MASK);
-	writel(tmp, qm->io_base + QM_DFX_SQE_CNT_VF_SQN);
-
-	tmp = val << QM_DFX_QN_SHIFT |
-	      (readl(qm->io_base + QM_DFX_CQE_CNT_VF_CQN) & CURRENT_FUN_MASK);
-	writel(tmp, qm->io_base + QM_DFX_CQE_CNT_VF_CQN);
-
-	return 0;
-}
-
-static u32 clear_enable_read(struct hisi_qm *qm)
-{
-	return readl(qm->io_base + QM_DFX_CNT_CLR_CE);
-}
-
-/* rd_clr_ctrl 1 enable read clear, otherwise 0 disable it */
-static int clear_enable_write(struct hisi_qm *qm, u32 rd_clr_ctrl)
-{
-	if (rd_clr_ctrl > 1)
-		return -EINVAL;
-
-	writel(rd_clr_ctrl, qm->io_base + QM_DFX_CNT_CLR_CE);
-
-	return 0;
-}
-
-static u32 current_qm_read(struct hisi_qm *qm)
-{
-	return readl(qm->io_base + QM_DFX_MB_CNT_VF);
-}
-
-static int current_qm_write(struct hisi_qm *qm, u32 val)
-{
-	u32 tmp;
-
-	if (val > qm->vfs_num)
-		return -EINVAL;
-
-	/* According PF or VF Dev ID to calculation curr_qm_qp_num and store */
-	if (!val)
-		qm->debug.curr_qm_qp_num = qm->qp_num;
-	else
-		qm->debug.curr_qm_qp_num = qm_get_vf_qp_num(qm, val);
-
-	writel(val, qm->io_base + QM_DFX_MB_CNT_VF);
-	writel(val, qm->io_base + QM_DFX_DB_CNT_VF);
-
-	tmp = val |
-	      (readl(qm->io_base + QM_DFX_SQE_CNT_VF_SQN) & CURRENT_Q_MASK);
-	writel(tmp, qm->io_base + QM_DFX_SQE_CNT_VF_SQN);
-
-	tmp = val |
-	      (readl(qm->io_base + QM_DFX_CQE_CNT_VF_CQN) & CURRENT_Q_MASK);
-	writel(tmp, qm->io_base + QM_DFX_CQE_CNT_VF_CQN);
-
-	return 0;
-}
-
-static ssize_t qm_debug_read(struct file *filp, char __user *buf,
-			     size_t count, loff_t *pos)
-{
-	struct debugfs_file *file = filp->private_data;
-	enum qm_debug_file index = file->index;
-	struct hisi_qm *qm = file_to_qm(file);
-	char tbuf[QM_DBG_TMP_BUF_LEN];
-	u32 val;
-	int ret;
-
-	ret = hisi_qm_get_dfx_access(qm);
-	if (ret)
-		return ret;
-
-	mutex_lock(&file->lock);
-	switch (index) {
-	case CURRENT_QM:
-		val = current_qm_read(qm);
-		break;
-	case CURRENT_Q:
-		val = current_q_read(qm);
-		break;
-	case CLEAR_ENABLE:
-		val = clear_enable_read(qm);
-		break;
-	default:
-		goto err_input;
-	}
-	mutex_unlock(&file->lock);
-
-	hisi_qm_put_dfx_access(qm);
-	ret = scnprintf(tbuf, QM_DBG_TMP_BUF_LEN, "%u\n", val);
-	return simple_read_from_buffer(buf, count, pos, tbuf, ret);
-
-err_input:
-	mutex_unlock(&file->lock);
-	hisi_qm_put_dfx_access(qm);
-	return -EINVAL;
-}
-
-static ssize_t qm_debug_write(struct file *filp, const char __user *buf,
-			      size_t count, loff_t *pos)
-{
-	struct debugfs_file *file = filp->private_data;
-	enum qm_debug_file index = file->index;
-	struct hisi_qm *qm = file_to_qm(file);
-	unsigned long val;
-	char tbuf[QM_DBG_TMP_BUF_LEN];
-	int len, ret;
-
-	if (*pos != 0)
-		return 0;
-
-	if (count >= QM_DBG_TMP_BUF_LEN)
-		return -ENOSPC;
-
-	len = simple_write_to_buffer(tbuf, QM_DBG_TMP_BUF_LEN - 1, pos, buf,
-				     count);
-	if (len < 0)
-		return len;
-
-	tbuf[len] = '\0';
-	if (kstrtoul(tbuf, 0, &val))
-		return -EFAULT;
-
-	ret = hisi_qm_get_dfx_access(qm);
-	if (ret)
-		return ret;
-
-	mutex_lock(&file->lock);
-	switch (index) {
-	case CURRENT_QM:
-		ret = current_qm_write(qm, val);
-		break;
-	case CURRENT_Q:
-		ret = current_q_write(qm, val);
-		break;
-	case CLEAR_ENABLE:
-		ret = clear_enable_write(qm, val);
-		break;
-	default:
-		ret = -EINVAL;
-	}
-	mutex_unlock(&file->lock);
-
-	hisi_qm_put_dfx_access(qm);
-
-	if (ret)
-		return ret;
-
-	return count;
-}
-
-static const struct file_operations qm_debug_fops = {
-	.owner = THIS_MODULE,
-	.open = simple_open,
-	.read = qm_debug_read,
-	.write = qm_debug_write,
-};
-
-#define CNT_CYC_REGS_NUM		10
-static const struct debugfs_reg32 qm_dfx_regs[] = {
-	/* XXX_CNT are reading clear register */
-	{"QM_ECC_1BIT_CNT               ",  0x104000ull},
-	{"QM_ECC_MBIT_CNT               ",  0x104008ull},
-	{"QM_DFX_MB_CNT                 ",  0x104018ull},
-	{"QM_DFX_DB_CNT                 ",  0x104028ull},
-	{"QM_DFX_SQE_CNT                ",  0x104038ull},
-	{"QM_DFX_CQE_CNT                ",  0x104048ull},
-	{"QM_DFX_SEND_SQE_TO_ACC_CNT    ",  0x104050ull},
-	{"QM_DFX_WB_SQE_FROM_ACC_CNT    ",  0x104058ull},
-	{"QM_DFX_ACC_FINISH_CNT         ",  0x104060ull},
-	{"QM_DFX_CQE_ERR_CNT            ",  0x1040b4ull},
-	{"QM_DFX_FUNS_ACTIVE_ST         ",  0x200ull},
-	{"QM_ECC_1BIT_INF               ",  0x104004ull},
-	{"QM_ECC_MBIT_INF               ",  0x10400cull},
-	{"QM_DFX_ACC_RDY_VLD0           ",  0x1040a0ull},
-	{"QM_DFX_ACC_RDY_VLD1           ",  0x1040a4ull},
-	{"QM_DFX_AXI_RDY_VLD            ",  0x1040a8ull},
-	{"QM_DFX_FF_ST0                 ",  0x1040c8ull},
-	{"QM_DFX_FF_ST1                 ",  0x1040ccull},
-	{"QM_DFX_FF_ST2                 ",  0x1040d0ull},
-	{"QM_DFX_FF_ST3                 ",  0x1040d4ull},
-	{"QM_DFX_FF_ST4                 ",  0x1040d8ull},
-	{"QM_DFX_FF_ST5                 ",  0x1040dcull},
-	{"QM_DFX_FF_ST6                 ",  0x1040e0ull},
-	{"QM_IN_IDLE_ST                 ",  0x1040e4ull},
-};
-
-static const struct debugfs_reg32 qm_vf_dfx_regs[] = {
-	{"QM_DFX_FUNS_ACTIVE_ST         ",  0x200ull},
-};
-
-/**
- * hisi_qm_regs_dump() - Dump registers's value.
- * @s: debugfs file handle.
- * @regset: accelerator registers information.
- *
- * Dump accelerator registers.
- */
-void hisi_qm_regs_dump(struct seq_file *s, struct debugfs_regset32 *regset)
-{
-	struct pci_dev *pdev = to_pci_dev(regset->dev);
-	struct hisi_qm *qm = pci_get_drvdata(pdev);
-	const struct debugfs_reg32 *regs = regset->regs;
-	int regs_len = regset->nregs;
-	int i, ret;
-	u32 val;
-
-	ret = hisi_qm_get_dfx_access(qm);
-	if (ret)
-		return;
-
-	for (i = 0; i < regs_len; i++) {
-		val = readl(regset->base + regs[i].offset);
-		seq_printf(s, "%s= 0x%08x\n", regs[i].name, val);
-	}
-
-	hisi_qm_put_dfx_access(qm);
-}
-EXPORT_SYMBOL_GPL(hisi_qm_regs_dump);
-
-static int qm_regs_show(struct seq_file *s, void *unused)
-{
-	struct hisi_qm *qm = s->private;
-	struct debugfs_regset32 regset;
-
-	if (qm->fun_type == QM_HW_PF) {
-		regset.regs = qm_dfx_regs;
-		regset.nregs = ARRAY_SIZE(qm_dfx_regs);
-	} else {
-		regset.regs = qm_vf_dfx_regs;
-		regset.nregs = ARRAY_SIZE(qm_vf_dfx_regs);
-	}
-
-	regset.base = qm->io_base;
-	regset.dev = &qm->pdev->dev;
-
-	hisi_qm_regs_dump(s, &regset);
-
-	return 0;
-}
-
-DEFINE_SHOW_ATTRIBUTE(qm_regs);
-
-static void dfx_regs_uninit(struct hisi_qm *qm,
-		struct dfx_diff_registers *dregs, int reg_len)
-{
-	int i;
-
-	/* Setting the pointer is NULL to prevent double free */
-	for (i = 0; i < reg_len; i++) {
-		kfree(dregs[i].regs);
-		dregs[i].regs = NULL;
-	}
-	kfree(dregs);
-	dregs = NULL;
-}
-
-static struct dfx_diff_registers *dfx_regs_init(struct hisi_qm *qm,
-	const struct dfx_diff_registers *cregs, u32 reg_len)
-{
-	struct dfx_diff_registers *diff_regs;
-	u32 j, base_offset;
-	int i;
-
-	diff_regs = kcalloc(reg_len, sizeof(*diff_regs), GFP_KERNEL);
-	if (!diff_regs)
-		return ERR_PTR(-ENOMEM);
-
-	for (i = 0; i < reg_len; i++) {
-		if (!cregs[i].reg_len)
-			continue;
-
-		diff_regs[i].reg_offset = cregs[i].reg_offset;
-		diff_regs[i].reg_len = cregs[i].reg_len;
-		diff_regs[i].regs = kcalloc(QM_DFX_REGS_LEN, cregs[i].reg_len,
-					 GFP_KERNEL);
-		if (!diff_regs[i].regs)
-			goto alloc_error;
-
-		for (j = 0; j < diff_regs[i].reg_len; j++) {
-			base_offset = diff_regs[i].reg_offset +
-					j * QM_DFX_REGS_LEN;
-			diff_regs[i].regs[j] = readl(qm->io_base + base_offset);
-		}
-	}
-
-	return diff_regs;
-
-alloc_error:
-	while (i > 0) {
-		i--;
-		kfree(diff_regs[i].regs);
-	}
-	kfree(diff_regs);
-	return ERR_PTR(-ENOMEM);
-}
-
-static int qm_diff_regs_init(struct hisi_qm *qm,
-		struct dfx_diff_registers *dregs, u32 reg_len)
-{
-	qm->debug.qm_diff_regs = dfx_regs_init(qm, qm_diff_regs,
-					       ARRAY_SIZE(qm_diff_regs));
-	if (IS_ERR(qm->debug.qm_diff_regs))
-		return PTR_ERR(qm->debug.qm_diff_regs);
-
-	qm->debug.acc_diff_regs = dfx_regs_init(qm, dregs, reg_len);
-	if (IS_ERR(qm->debug.acc_diff_regs)) {
-		dfx_regs_uninit(qm, qm->debug.qm_diff_regs,
-				ARRAY_SIZE(qm_diff_regs));
-		return PTR_ERR(qm->debug.acc_diff_regs);
-	}
-
-	return 0;
-}
-
-static void qm_last_regs_uninit(struct hisi_qm *qm)
-{
-	struct qm_debug *debug = &qm->debug;
-
-	if (qm->fun_type == QM_HW_VF || !debug->qm_last_words)
-		return;
-
-	kfree(debug->qm_last_words);
-	debug->qm_last_words = NULL;
-}
-
-static int qm_last_regs_init(struct hisi_qm *qm)
-{
-	int dfx_regs_num = ARRAY_SIZE(qm_dfx_regs);
-	struct qm_debug *debug = &qm->debug;
-	int i;
-
-	if (qm->fun_type == QM_HW_VF)
-		return 0;
-
-	debug->qm_last_words = kcalloc(dfx_regs_num, sizeof(unsigned int),
-								GFP_KERNEL);
-	if (!debug->qm_last_words)
-		return -ENOMEM;
-
-	for (i = 0; i < dfx_regs_num; i++) {
-		debug->qm_last_words[i] = readl_relaxed(qm->io_base +
-			qm_dfx_regs[i].offset);
-	}
-
-	return 0;
-}
-
-static void qm_diff_regs_uninit(struct hisi_qm *qm, u32 reg_len)
-{
-	dfx_regs_uninit(qm, qm->debug.acc_diff_regs, reg_len);
-	dfx_regs_uninit(qm, qm->debug.qm_diff_regs, ARRAY_SIZE(qm_diff_regs));
-}
-
-/**
- * hisi_qm_regs_debugfs_init() - Allocate memory for registers.
- * @qm: device qm handle.
- * @dregs: diff registers handle.
- * @reg_len: diff registers region length.
- */
-int hisi_qm_regs_debugfs_init(struct hisi_qm *qm,
-		struct dfx_diff_registers *dregs, u32 reg_len)
-{
-	int ret;
-
-	if (!qm || !dregs)
-		return -EINVAL;
-
-	if (qm->fun_type != QM_HW_PF)
-		return 0;
-
-	ret = qm_last_regs_init(qm);
-	if (ret) {
-		dev_info(&qm->pdev->dev, "failed to init qm words memory.\n");
-		return ret;
-	}
-
-	ret = qm_diff_regs_init(qm, dregs, reg_len);
-	if (ret) {
-		qm_last_regs_uninit(qm);
-		return ret;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(hisi_qm_regs_debugfs_init);
-
-/**
- * hisi_qm_regs_debugfs_uninit() - Free memory for registers.
- * @qm: device qm handle.
- * @reg_len: diff registers region length.
- */
-void hisi_qm_regs_debugfs_uninit(struct hisi_qm *qm, u32 reg_len)
-{
-	if (!qm || qm->fun_type != QM_HW_PF)
-		return;
-
-	qm_diff_regs_uninit(qm, reg_len);
-	qm_last_regs_uninit(qm);
-}
-EXPORT_SYMBOL_GPL(hisi_qm_regs_debugfs_uninit);
-
-/**
- * hisi_qm_acc_diff_regs_dump() - Dump registers's value.
- * @qm: device qm handle.
- * @s: Debugfs file handle.
- * @dregs: diff registers handle.
- * @regs_len: diff registers region length.
- */
-void hisi_qm_acc_diff_regs_dump(struct hisi_qm *qm, struct seq_file *s,
-	struct dfx_diff_registers *dregs, u32 regs_len)
-{
-	u32 j, val, base_offset;
-	int i, ret;
-
-	if (!qm || !s || !dregs)
-		return;
-
-	ret = hisi_qm_get_dfx_access(qm);
-	if (ret)
-		return;
-
-	down_read(&qm->qps_lock);
-	for (i = 0; i < regs_len; i++) {
-		if (!dregs[i].reg_len)
-			continue;
-
-		for (j = 0; j < dregs[i].reg_len; j++) {
-			base_offset = dregs[i].reg_offset + j * QM_DFX_REGS_LEN;
-			val = readl(qm->io_base + base_offset);
-			if (val != dregs[i].regs[j])
-				seq_printf(s, "0x%08x = 0x%08x ---> 0x%08x\n",
-					   base_offset, dregs[i].regs[j], val);
-		}
-	}
-	up_read(&qm->qps_lock);
-
-	hisi_qm_put_dfx_access(qm);
-}
-EXPORT_SYMBOL_GPL(hisi_qm_acc_diff_regs_dump);
-
-static int qm_diff_regs_show(struct seq_file *s, void *unused)
-{
-	struct hisi_qm *qm = s->private;
-
-	hisi_qm_acc_diff_regs_dump(qm, s, qm->debug.qm_diff_regs,
-					ARRAY_SIZE(qm_diff_regs));
-
-	return 0;
-}
-DEFINE_SHOW_ATTRIBUTE(qm_diff_regs);
-
-static ssize_t qm_cmd_read(struct file *filp, char __user *buffer,
-			   size_t count, loff_t *pos)
-{
-	char buf[QM_DBG_READ_LEN];
-	int len;
-
-	len = scnprintf(buf, QM_DBG_READ_LEN, "%s\n",
-			"Please echo help to cmd to get help information");
-
-	return simple_read_from_buffer(buffer, count, pos, buf, len);
-}
-
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
-static void dump_show(struct hisi_qm *qm, void *info,
-		     unsigned int info_size, char *info_name)
-{
-	struct device *dev = &qm->pdev->dev;
-	u8 *info_curr = info;
-	u32 i;
-#define BYTE_PER_DW	4
-
-	dev_info(dev, "%s DUMP\n", info_name);
-	for (i = 0; i < info_size; i += BYTE_PER_DW, info_curr += BYTE_PER_DW) {
-		pr_info("DW%u: %02X%02X %02X%02X\n", i / BYTE_PER_DW,
-			*(info_curr + 3), *(info_curr + 2), *(info_curr + 1), *(info_curr));
-	}
-}
-
-static int qm_dump_sqc_raw(struct hisi_qm *qm, dma_addr_t dma_addr, u16 qp_id)
-{
-	return hisi_qm_mb(qm, QM_MB_CMD_SQC, dma_addr, qp_id, 1);
-}
-
-static int qm_dump_cqc_raw(struct hisi_qm *qm, dma_addr_t dma_addr, u16 qp_id)
-{
-	return hisi_qm_mb(qm, QM_MB_CMD_CQC, dma_addr, qp_id, 1);
-}
-
-static int qm_sqc_dump(struct hisi_qm *qm, const char *s)
-{
-	struct device *dev = &qm->pdev->dev;
-	struct qm_sqc *sqc, *sqc_curr;
-	dma_addr_t sqc_dma;
-	u32 qp_id;
-	int ret;
-
-	if (!s)
-		return -EINVAL;
-
-	ret = kstrtou32(s, 0, &qp_id);
-	if (ret || qp_id >= qm->qp_num) {
-		dev_err(dev, "Please input qp num (0-%u)", qm->qp_num - 1);
-		return -EINVAL;
-	}
-
-	sqc = qm_ctx_alloc(qm, sizeof(*sqc), &sqc_dma);
-	if (IS_ERR(sqc))
-		return PTR_ERR(sqc);
-
-	ret = qm_dump_sqc_raw(qm, sqc_dma, qp_id);
-	if (ret) {
-		down_read(&qm->qps_lock);
-		if (qm->sqc) {
-			sqc_curr = qm->sqc + qp_id;
-
-			dump_show(qm, sqc_curr, sizeof(*sqc), "SOFT SQC");
-		}
-		up_read(&qm->qps_lock);
-
-		goto free_ctx;
-	}
-
-	dump_show(qm, sqc, sizeof(*sqc), "SQC");
-
-free_ctx:
-	qm_ctx_free(qm, sizeof(*sqc), sqc, &sqc_dma);
-	return 0;
-}
-
-static int qm_cqc_dump(struct hisi_qm *qm, const char *s)
-{
-	struct device *dev = &qm->pdev->dev;
-	struct qm_cqc *cqc, *cqc_curr;
-	dma_addr_t cqc_dma;
-	u32 qp_id;
-	int ret;
-
-	if (!s)
-		return -EINVAL;
-
-	ret = kstrtou32(s, 0, &qp_id);
-	if (ret || qp_id >= qm->qp_num) {
-		dev_err(dev, "Please input qp num (0-%u)", qm->qp_num - 1);
-		return -EINVAL;
-	}
-
-	cqc = qm_ctx_alloc(qm, sizeof(*cqc), &cqc_dma);
-	if (IS_ERR(cqc))
-		return PTR_ERR(cqc);
-
-	ret = qm_dump_cqc_raw(qm, cqc_dma, qp_id);
-	if (ret) {
-		down_read(&qm->qps_lock);
-		if (qm->cqc) {
-			cqc_curr = qm->cqc + qp_id;
-
-			dump_show(qm, cqc_curr, sizeof(*cqc), "SOFT CQC");
+			break;
 		}
-		up_read(&qm->qps_lock);
-
-		goto free_ctx;
 	}
 
-	dump_show(qm, cqc, sizeof(*cqc), "CQC");
-
-free_ctx:
-	qm_ctx_free(qm, sizeof(*cqc), cqc, &cqc_dma);
-	return 0;
+	writel(lower_32_bits(tmp), qm->io_base + QM_VFT_CFG_DATA_L);
+	writel(upper_32_bits(tmp), qm->io_base + QM_VFT_CFG_DATA_H);
 }
 
-static int qm_eqc_aeqc_dump(struct hisi_qm *qm, char *s, size_t size,
-			    int cmd, char *name)
+static int qm_set_vft_common(struct hisi_qm *qm, enum vft_type type,
+			     u32 fun_num, u32 base, u32 number)
 {
-	struct device *dev = &qm->pdev->dev;
-	dma_addr_t xeqc_dma;
-	void *xeqc;
+	struct qm_shaper_factor *factor = NULL;
+	unsigned int val;
 	int ret;
 
-	if (strsep(&s, " ")) {
-		dev_err(dev, "Please do not input extra characters!\n");
-		return -EINVAL;
-	}
-
-	xeqc = qm_ctx_alloc(qm, size, &xeqc_dma);
-	if (IS_ERR(xeqc))
-		return PTR_ERR(xeqc);
+	if (type == SHAPER_VFT && test_bit(QM_SUPPORT_FUNC_QOS, &qm->caps))
+		factor = &qm->factor[fun_num];
 
-	ret = hisi_qm_mb(qm, cmd, xeqc_dma, 0, 1);
+	ret = readl_relaxed_poll_timeout(qm->io_base + QM_VFT_CFG_RDY, val,
+					 val & BIT(0), POLL_PERIOD,
+					 POLL_TIMEOUT);
 	if (ret)
-		goto err_free_ctx;
+		return ret;
 
-	dump_show(qm, xeqc, size, name);
+	writel(0x0, qm->io_base + QM_VFT_CFG_OP_WR);
+	writel(type, qm->io_base + QM_VFT_CFG_TYPE);
+	if (type == SHAPER_VFT)
+		fun_num |= base << QM_SHAPER_VFT_OFFSET;
 
-err_free_ctx:
-	qm_ctx_free(qm, size, xeqc, &xeqc_dma);
-	return ret;
-}
+	writel(fun_num, qm->io_base + QM_VFT_CFG);
 
-static int q_dump_param_parse(struct hisi_qm *qm, char *s,
-			      u32 *e_id, u32 *q_id, u16 q_depth)
-{
-	struct device *dev = &qm->pdev->dev;
-	unsigned int qp_num = qm->qp_num;
-	char *presult;
-	int ret;
+	qm_vft_data_cfg(qm, type, base, number, factor);
 
-	presult = strsep(&s, " ");
-	if (!presult) {
-		dev_err(dev, "Please input qp number!\n");
-		return -EINVAL;
-	}
+	writel(0x0, qm->io_base + QM_VFT_CFG_RDY);
+	writel(0x1, qm->io_base + QM_VFT_CFG_OP_ENABLE);
 
-	ret = kstrtou32(presult, 0, q_id);
-	if (ret || *q_id >= qp_num) {
-		dev_err(dev, "Please input qp num (0-%u)", qp_num - 1);
-		return -EINVAL;
-	}
+	return readl_relaxed_poll_timeout(qm->io_base + QM_VFT_CFG_RDY, val,
+					  val & BIT(0), POLL_PERIOD,
+					  POLL_TIMEOUT);
+}
 
-	presult = strsep(&s, " ");
-	if (!presult) {
-		dev_err(dev, "Please input sqe number!\n");
-		return -EINVAL;
-	}
+static int qm_shaper_init_vft(struct hisi_qm *qm, u32 fun_num)
+{
+	u32 qos = qm->factor[fun_num].func_qos;
+	int ret, i;
 
-	ret = kstrtou32(presult, 0, e_id);
-	if (ret || *e_id >= q_depth) {
-		dev_err(dev, "Please input sqe num (0-%u)", q_depth - 1);
-		return -EINVAL;
+	ret = qm_get_shaper_para(qos * QM_QOS_RATE, &qm->factor[fun_num]);
+	if (ret) {
+		dev_err(&qm->pdev->dev, "failed to calculate shaper parameter!\n");
+		return ret;
 	}
-
-	if (strsep(&s, " ")) {
-		dev_err(dev, "Please do not input extra characters!\n");
-		return -EINVAL;
+	writel(qm->type_rate, qm->io_base + QM_SHAPER_CFG);
+	for (i = ALG_TYPE_0; i <= ALG_TYPE_1; i++) {
+		/* The base number of queue reuse for different alg type */
+		ret = qm_set_vft_common(qm, SHAPER_VFT, fun_num, i, 1);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
 }
 
-static int qm_sq_dump(struct hisi_qm *qm, char *s)
+/* The config should be conducted after qm_dev_mem_reset() */
+static int qm_set_sqc_cqc_vft(struct hisi_qm *qm, u32 fun_num, u32 base,
+			      u32 number)
 {
-	u16 sq_depth = qm->qp_array->cq_depth;
-	void *sqe, *sqe_curr;
-	struct hisi_qp *qp;
-	u32 qp_id, sqe_id;
-	int ret;
-
-	ret = q_dump_param_parse(qm, s, &sqe_id, &qp_id, sq_depth);
-	if (ret)
-		return ret;
-
-	sqe = kzalloc(qm->sqe_size * sq_depth, GFP_KERNEL);
-	if (!sqe)
-		return -ENOMEM;
-
-	qp = &qm->qp_array[qp_id];
-	memcpy(sqe, qp->sqe, qm->sqe_size * sq_depth);
-	sqe_curr = sqe + (u32)(sqe_id * qm->sqe_size);
-	memset(sqe_curr + qm->debug.sqe_mask_offset, QM_SQE_ADDR_MASK,
-	       qm->debug.sqe_mask_len);
+	int ret, i;
 
-	dump_show(qm, sqe_curr, qm->sqe_size, "SQE");
+	for (i = SQC_VFT; i <= CQC_VFT; i++) {
+		ret = qm_set_vft_common(qm, i, fun_num, base, number);
+		if (ret)
+			return ret;
+	}
 
-	kfree(sqe);
+	/* init default shaper qos val */
+	if (test_bit(QM_SUPPORT_FUNC_QOS, &qm->caps)) {
+		ret = qm_shaper_init_vft(qm, fun_num);
+		if (ret)
+			goto back_sqc_cqc;
+	}
 
 	return 0;
+back_sqc_cqc:
+	for (i = SQC_VFT; i <= CQC_VFT; i++)
+		qm_set_vft_common(qm, i, fun_num, 0, 0);
+
+	return ret;
 }
 
-static int qm_cq_dump(struct hisi_qm *qm, char *s)
+static int qm_get_vft_v2(struct hisi_qm *qm, u32 *base, u32 *number)
 {
-	struct qm_cqe *cqe_curr;
-	struct hisi_qp *qp;
-	u32 qp_id, cqe_id;
+	u64 sqc_vft;
 	int ret;
 
-	ret = q_dump_param_parse(qm, s, &cqe_id, &qp_id, qm->qp_array->cq_depth);
+	ret = hisi_qm_mb(qm, QM_MB_CMD_SQC_VFT_V2, 0, 0, 1);
 	if (ret)
 		return ret;
 
-	qp = &qm->qp_array[qp_id];
-	cqe_curr = qp->cqe + cqe_id;
-	dump_show(qm, cqe_curr, sizeof(struct qm_cqe), "CQE");
+	sqc_vft = readl(qm->io_base + QM_MB_CMD_DATA_ADDR_L) |
+		  ((u64)readl(qm->io_base + QM_MB_CMD_DATA_ADDR_H) << 32);
+	*base = QM_SQC_VFT_BASE_MASK_V2 & (sqc_vft >> QM_SQC_VFT_BASE_SHIFT_V2);
+	*number = (QM_SQC_VFT_NUM_MASK_v2 &
+		   (sqc_vft >> QM_SQC_VFT_NUM_SHIFT_V2)) + 1;
 
 	return 0;
 }
 
-static int qm_eq_aeq_dump(struct hisi_qm *qm, const char *s,
-			  size_t size, char *name)
+void *hisi_qm_ctx_alloc(struct hisi_qm *qm, size_t ctx_size,
+			  dma_addr_t *dma_addr)
 {
 	struct device *dev = &qm->pdev->dev;
-	void *xeqe;
-	u32 xeqe_id;
-	int ret;
-
-	if (!s)
-		return -EINVAL;
-
-	ret = kstrtou32(s, 0, &xeqe_id);
-	if (ret)
-		return -EINVAL;
-
-	if (!strcmp(name, "EQE") && xeqe_id >= qm->eq_depth) {
-		dev_err(dev, "Please input eqe num (0-%u)", qm->eq_depth - 1);
-		return -EINVAL;
-	} else if (!strcmp(name, "AEQE") && xeqe_id >= qm->aeq_depth) {
-		dev_err(dev, "Please input aeqe num (0-%u)", qm->eq_depth - 1);
-		return -EINVAL;
-	}
-
-	down_read(&qm->qps_lock);
-
-	if (qm->eqe && !strcmp(name, "EQE")) {
-		xeqe = qm->eqe + xeqe_id;
-	} else if (qm->aeqe && !strcmp(name, "AEQE")) {
-		xeqe = qm->aeqe + xeqe_id;
-	} else {
-		ret = -EINVAL;
-		goto err_unlock;
-	}
-
-	dump_show(qm, xeqe, size, name);
-
-err_unlock:
-	up_read(&qm->qps_lock);
-	return ret;
-}
+	void *ctx_addr;
 
-static int qm_dbg_help(struct hisi_qm *qm, char *s)
-{
-	struct device *dev = &qm->pdev->dev;
+	ctx_addr = kzalloc(ctx_size, GFP_KERNEL);
+	if (!ctx_addr)
+		return ERR_PTR(-ENOMEM);
 
-	if (strsep(&s, " ")) {
-		dev_err(dev, "Please do not input extra characters!\n");
-		return -EINVAL;
+	*dma_addr = dma_map_single(dev, ctx_addr, ctx_size, DMA_FROM_DEVICE);
+	if (dma_mapping_error(dev, *dma_addr)) {
+		dev_err(dev, "DMA mapping error!\n");
+		kfree(ctx_addr);
+		return ERR_PTR(-ENOMEM);
 	}
 
-	dev_info(dev, "available commands:\n");
-	dev_info(dev, "sqc <num>\n");
-	dev_info(dev, "cqc <num>\n");
-	dev_info(dev, "eqc\n");
-	dev_info(dev, "aeqc\n");
-	dev_info(dev, "sq <num> <e>\n");
-	dev_info(dev, "cq <num> <e>\n");
-	dev_info(dev, "eq <e>\n");
-	dev_info(dev, "aeq <e>\n");
-
-	return 0;
+	return ctx_addr;
 }
 
-static int qm_cmd_write_dump(struct hisi_qm *qm, const char *cmd_buf)
+void hisi_qm_ctx_free(struct hisi_qm *qm, size_t ctx_size,
+			const void *ctx_addr, dma_addr_t *dma_addr)
 {
 	struct device *dev = &qm->pdev->dev;
-	char *presult, *s, *s_tmp;
-	int ret;
-
-	s = kstrdup(cmd_buf, GFP_KERNEL);
-	if (!s)
-		return -ENOMEM;
-
-	s_tmp = s;
-	presult = strsep(&s, " ");
-	if (!presult) {
-		ret = -EINVAL;
-		goto err_buffer_free;
-	}
-
-	if (!strcmp(presult, "sqc"))
-		ret = qm_sqc_dump(qm, s);
-	else if (!strcmp(presult, "cqc"))
-		ret = qm_cqc_dump(qm, s);
-	else if (!strcmp(presult, "eqc"))
-		ret = qm_eqc_aeqc_dump(qm, s, sizeof(struct qm_eqc),
-				       QM_MB_CMD_EQC, "EQC");
-	else if (!strcmp(presult, "aeqc"))
-		ret = qm_eqc_aeqc_dump(qm, s, sizeof(struct qm_aeqc),
-				       QM_MB_CMD_AEQC, "AEQC");
-	else if (!strcmp(presult, "sq"))
-		ret = qm_sq_dump(qm, s);
-	else if (!strcmp(presult, "cq"))
-		ret = qm_cq_dump(qm, s);
-	else if (!strcmp(presult, "eq"))
-		ret = qm_eq_aeq_dump(qm, s, sizeof(struct qm_eqe), "EQE");
-	else if (!strcmp(presult, "aeq"))
-		ret = qm_eq_aeq_dump(qm, s, sizeof(struct qm_aeqe), "AEQE");
-	else if (!strcmp(presult, "help"))
-		ret = qm_dbg_help(qm, s);
-	else
-		ret = -EINVAL;
-
-	if (ret)
-		dev_info(dev, "Please echo help\n");
-
-err_buffer_free:
-	kfree(s_tmp);
 
-	return ret;
+	dma_unmap_single(dev, *dma_addr, ctx_size, DMA_FROM_DEVICE);
+	kfree(ctx_addr);
 }
 
-static ssize_t qm_cmd_write(struct file *filp, const char __user *buffer,
-			    size_t count, loff_t *pos)
+static int qm_dump_sqc_raw(struct hisi_qm *qm, dma_addr_t dma_addr, u16 qp_id)
 {
-	struct hisi_qm *qm = filp->private_data;
-	char *cmd_buf, *cmd_buf_tmp;
-	int ret;
-
-	if (*pos)
-		return 0;
-
-	ret = hisi_qm_get_dfx_access(qm);
-	if (ret)
-		return ret;
-
-	/* Judge if the instance is being reset. */
-	if (unlikely(atomic_read(&qm->status.flags) == QM_STOP)) {
-		ret = 0;
-		goto put_dfx_access;
-	}
-
-	if (count > QM_DBG_WRITE_LEN) {
-		ret = -ENOSPC;
-		goto put_dfx_access;
-	}
-
-	cmd_buf = memdup_user_nul(buffer, count);
-	if (IS_ERR(cmd_buf)) {
-		ret = PTR_ERR(cmd_buf);
-		goto put_dfx_access;
-	}
-
-	cmd_buf_tmp = strchr(cmd_buf, '\n');
-	if (cmd_buf_tmp) {
-		*cmd_buf_tmp = '\0';
-		count = cmd_buf_tmp - cmd_buf + 1;
-	}
-
-	ret = qm_cmd_write_dump(qm, cmd_buf);
-	if (ret) {
-		kfree(cmd_buf);
-		goto put_dfx_access;
-	}
-
-	kfree(cmd_buf);
-
-	ret = count;
-
-put_dfx_access:
-	hisi_qm_put_dfx_access(qm);
-	return ret;
+	return hisi_qm_mb(qm, QM_MB_CMD_SQC, dma_addr, qp_id, 1);
 }
 
-static const struct file_operations qm_cmd_fops = {
-	.owner = THIS_MODULE,
-	.open = simple_open,
-	.read = qm_cmd_read,
-	.write = qm_cmd_write,
-};
-
-static void qm_create_debugfs_file(struct hisi_qm *qm, struct dentry *dir,
-				   enum qm_debug_file index)
+static int qm_dump_cqc_raw(struct hisi_qm *qm, dma_addr_t dma_addr, u16 qp_id)
 {
-	struct debugfs_file *file = qm->debug.files + index;
-
-	debugfs_create_file(qm_debug_file_name[index], 0600, dir, file,
-			    &qm_debug_fops);
-
-	file->index = index;
-	mutex_init(&file->lock);
-	file->debug = &qm->debug;
+	return hisi_qm_mb(qm, QM_MB_CMD_CQC, dma_addr, qp_id, 1);
 }
 
 static void qm_hw_error_init_v1(struct hisi_qm *qm)
@@ -3159,7 +2130,7 @@ static int qm_drain_qp(struct hisi_qp *qp)
 		return ret;
 	}
 
-	addr = qm_ctx_alloc(qm, size, &dma_addr);
+	addr = hisi_qm_ctx_alloc(qm, size, &dma_addr);
 	if (IS_ERR(addr)) {
 		dev_err(dev, "Failed to alloc ctx for sqc and cqc!\n");
 		return -ENOMEM;
@@ -3194,7 +2165,7 @@ static int qm_drain_qp(struct hisi_qp *qp)
 		usleep_range(WAIT_PERIOD_US_MIN, WAIT_PERIOD_US_MAX);
 	}
 
-	qm_ctx_free(qm, size, addr, &dma_addr);
+	hisi_qm_ctx_free(qm, size, addr, &dma_addr);
 
 	return ret;
 }
@@ -4177,45 +3148,6 @@ int hisi_qm_stop(struct hisi_qm *qm, enum qm_stop_reason r)
 }
 EXPORT_SYMBOL_GPL(hisi_qm_stop);
 
-static ssize_t qm_status_read(struct file *filp, char __user *buffer,
-			      size_t count, loff_t *pos)
-{
-	struct hisi_qm *qm = filp->private_data;
-	char buf[QM_DBG_READ_LEN];
-	int val, len;
-
-	val = atomic_read(&qm->status.flags);
-	len = scnprintf(buf, QM_DBG_READ_LEN, "%s\n", qm_s[val]);
-
-	return simple_read_from_buffer(buffer, count, pos, buf, len);
-}
-
-static const struct file_operations qm_status_fops = {
-	.owner = THIS_MODULE,
-	.open = simple_open,
-	.read = qm_status_read,
-};
-
-static int qm_debugfs_atomic64_set(void *data, u64 val)
-{
-	if (val)
-		return -EINVAL;
-
-	atomic64_set((atomic64_t *)data, 0);
-
-	return 0;
-}
-
-static int qm_debugfs_atomic64_get(void *data, u64 *val)
-{
-	*val = atomic64_read((atomic64_t *)data);
-
-	return 0;
-}
-
-DEFINE_DEBUGFS_ATTRIBUTE(qm_atomic64_ops, qm_debugfs_atomic64_get,
-			 qm_debugfs_atomic64_set, "%llu\n");
-
 static void qm_hw_error_init(struct hisi_qm *qm)
 {
 	if (!qm->ops->hw_error_init) {
@@ -4736,7 +3668,7 @@ static const struct file_operations qm_algqos_fops = {
  *
  * Create function qos debugfs files, VF ping PF to get function qos.
  */
-static void hisi_qm_set_algqos_init(struct hisi_qm *qm)
+void hisi_qm_set_algqos_init(struct hisi_qm *qm)
 {
 	if (qm->fun_type == QM_HW_PF)
 		debugfs_create_file("alg_qos", 0644, qm->debug.debug_root,
@@ -4746,88 +3678,6 @@ static void hisi_qm_set_algqos_init(struct hisi_qm *qm)
 				    qm, &qm_algqos_fops);
 }
 
-/**
- * hisi_qm_debug_init() - Initialize qm related debugfs files.
- * @qm: The qm for which we want to add debugfs files.
- *
- * Create qm related debugfs files.
- */
-void hisi_qm_debug_init(struct hisi_qm *qm)
-{
-	struct dfx_diff_registers *qm_regs = qm->debug.qm_diff_regs;
-	struct qm_dfx *dfx = &qm->debug.dfx;
-	struct dentry *qm_d;
-	void *data;
-	int i;
-
-	qm_d = debugfs_create_dir("qm", qm->debug.debug_root);
-	qm->debug.qm_d = qm_d;
-
-	/* only show this in PF */
-	if (qm->fun_type == QM_HW_PF) {
-		qm_create_debugfs_file(qm, qm->debug.debug_root, CURRENT_QM);
-		for (i = CURRENT_Q; i < DEBUG_FILE_NUM; i++)
-			qm_create_debugfs_file(qm, qm->debug.qm_d, i);
-	}
-
-	if (qm_regs)
-		debugfs_create_file("diff_regs", 0444, qm->debug.qm_d,
-					qm, &qm_diff_regs_fops);
-
-	debugfs_create_file("regs", 0444, qm->debug.qm_d, qm, &qm_regs_fops);
-
-	debugfs_create_file("cmd", 0600, qm->debug.qm_d, qm, &qm_cmd_fops);
-
-	debugfs_create_file("status", 0444, qm->debug.qm_d, qm,
-			&qm_status_fops);
-	for (i = 0; i < ARRAY_SIZE(qm_dfx_files); i++) {
-		data = (atomic64_t *)((uintptr_t)dfx + qm_dfx_files[i].offset);
-		debugfs_create_file(qm_dfx_files[i].name,
-			0644,
-			qm_d,
-			data,
-			&qm_atomic64_ops);
-	}
-
-	if (test_bit(QM_SUPPORT_FUNC_QOS, &qm->caps))
-		hisi_qm_set_algqos_init(qm);
-}
-EXPORT_SYMBOL_GPL(hisi_qm_debug_init);
-
-/**
- * hisi_qm_debug_regs_clear() - clear qm debug related registers.
- * @qm: The qm for which we want to clear its debug registers.
- */
-void hisi_qm_debug_regs_clear(struct hisi_qm *qm)
-{
-	const struct debugfs_reg32 *regs;
-	int i;
-
-	/* clear current_qm */
-	writel(0x0, qm->io_base + QM_DFX_MB_CNT_VF);
-	writel(0x0, qm->io_base + QM_DFX_DB_CNT_VF);
-
-	/* clear current_q */
-	writel(0x0, qm->io_base + QM_DFX_SQE_CNT_VF_SQN);
-	writel(0x0, qm->io_base + QM_DFX_CQE_CNT_VF_CQN);
-
-	/*
-	 * these registers are reading and clearing, so clear them after
-	 * reading them.
-	 */
-	writel(0x1, qm->io_base + QM_DFX_CNT_CLR_CE);
-
-	regs = qm_dfx_regs;
-	for (i = 0; i < CNT_CYC_REGS_NUM; i++) {
-		readl(qm->io_base + regs->offset);
-		regs++;
-	}
-
-	/* clear clear_enable */
-	writel(0x0, qm->io_base + QM_DFX_CNT_CLR_CE);
-}
-EXPORT_SYMBOL_GPL(hisi_qm_debug_regs_clear);
-
 static void hisi_qm_init_vf_qos(struct hisi_qm *qm, int total_func)
 {
 	int i;
@@ -5466,24 +4316,6 @@ static int qm_controller_reset_done(struct hisi_qm *qm)
 	return 0;
 }
 
-static void qm_show_last_dfx_regs(struct hisi_qm *qm)
-{
-	struct qm_debug *debug = &qm->debug;
-	struct pci_dev *pdev = qm->pdev;
-	u32 val;
-	int i;
-
-	if (qm->fun_type == QM_HW_VF || !debug->qm_last_words)
-		return;
-
-	for (i = 0; i < ARRAY_SIZE(qm_dfx_regs); i++) {
-		val = readl_relaxed(qm->io_base + qm_dfx_regs[i].offset);
-		if (debug->qm_last_words[i] != val)
-			pci_info(pdev, "%s \t= 0x%08x => 0x%08x\n",
-			qm_dfx_regs[i].name, debug->qm_last_words[i], val);
-	}
-}
-
 static int qm_controller_reset(struct hisi_qm *qm)
 {
 	struct pci_dev *pdev = qm->pdev;
@@ -5499,7 +4331,7 @@ static int qm_controller_reset(struct hisi_qm *qm)
 		return ret;
 	}
 
-	qm_show_last_dfx_regs(qm);
+	hisi_qm_show_last_dfx_regs(qm);
 	if (qm->err_ini->show_last_dfx_regs)
 		qm->err_ini->show_last_dfx_regs(qm);
 
diff --git a/drivers/crypto/hisilicon/qm_common.h b/drivers/crypto/hisilicon/qm_common.h
new file mode 100644
index 000000000000..1406a422d455
--- /dev/null
+++ b/drivers/crypto/hisilicon/qm_common.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2022 HiSilicon Limited. */
+#ifndef QM_COMMON_H
+#define QM_COMMON_H
+
+#define QM_DBG_READ_LEN		256
+#define QM_RESETTING		2
+
+struct qm_cqe {
+	__le32 rsvd0;
+	__le16 cmd_id;
+	__le16 rsvd1;
+	__le16 sq_head;
+	__le16 sq_num;
+	__le16 rsvd2;
+	__le16 w7;
+};
+
+struct qm_eqe {
+	__le32 dw0;
+};
+
+struct qm_aeqe {
+	__le32 dw0;
+};
+
+struct qm_sqc {
+	__le16 head;
+	__le16 tail;
+	__le32 base_l;
+	__le32 base_h;
+	__le32 dw3;
+	__le16 w8;
+	__le16 rsvd0;
+	__le16 pasid;
+	__le16 w11;
+	__le16 cq_num;
+	__le16 w13;
+	__le32 rsvd1;
+};
+
+struct qm_cqc {
+	__le16 head;
+	__le16 tail;
+	__le32 base_l;
+	__le32 base_h;
+	__le32 dw3;
+	__le16 w8;
+	__le16 rsvd0;
+	__le16 pasid;
+	__le16 w11;
+	__le32 dw6;
+	__le32 rsvd1;
+};
+
+struct qm_eqc {
+	__le16 head;
+	__le16 tail;
+	__le32 base_l;
+	__le32 base_h;
+	__le32 dw3;
+	__le32 rsvd[2];
+	__le32 dw6;
+};
+
+struct qm_aeqc {
+	__le16 head;
+	__le16 tail;
+	__le32 base_l;
+	__le32 base_h;
+	__le32 dw3;
+	__le32 rsvd[2];
+	__le32 dw6;
+};
+
+static const char * const qm_s[] = {
+	"init", "start", "close", "stop",
+};
+
+void *hisi_qm_ctx_alloc(struct hisi_qm *qm, size_t ctx_size,
+			dma_addr_t *dma_addr);
+void hisi_qm_ctx_free(struct hisi_qm *qm, size_t ctx_size,
+		      const void *ctx_addr, dma_addr_t *dma_addr);
+void hisi_qm_show_last_dfx_regs(struct hisi_qm *qm);
+void hisi_qm_set_algqos_init(struct hisi_qm *qm);
+
+#endif
-- 
2.17.1


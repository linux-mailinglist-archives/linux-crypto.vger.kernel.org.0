Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76E1C7EEA5
	for <lists+linux-crypto@lfdr.de>; Fri,  2 Aug 2019 10:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390754AbfHBIQz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 2 Aug 2019 04:16:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49872 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390803AbfHBIQy (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 2 Aug 2019 04:16:54 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6DE33FD53DF85E3DE290;
        Fri,  2 Aug 2019 16:16:50 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Fri, 2 Aug 2019 16:16:44 +0800
From:   Zhou Wang <wangzhou1@hisilicon.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        Hao Fang <fanghao11@huawei.com>
Subject: [PATCH v3 1/7] crypto: hisilicon - add queue management driver for HiSilicon QM module
Date:   Fri, 2 Aug 2019 15:57:50 +0800
Message-ID: <1564732676-35987-2-git-send-email-wangzhou1@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1564732676-35987-1-git-send-email-wangzhou1@hisilicon.com>
References: <1564732676-35987-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

QM is a general IP used by HiSilicon accelerators. It provides a general
PCIe interface for the CPU and the accelerator to share a group of queues.

A QM integrated in an accelerator provides queue management service.
Queues can be assigned to PF and VFs, and queues can be controlled by
unified mailboxes and doorbells. Specific task request are descripted by
specific description buffer, which will be controlled and pass to related
accelerator IP by QM.

This patch adds a QM driver used by the accelerator driver to access
the QM hardware.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Hao Fang <fanghao11@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: John Garry <john.garry@huawei.com>
---
 drivers/crypto/hisilicon/Kconfig  |    7 +
 drivers/crypto/hisilicon/Makefile |    1 +
 drivers/crypto/hisilicon/qm.c     | 1550 +++++++++++++++++++++++++++++++++++++
 drivers/crypto/hisilicon/qm.h     |  182 +++++
 4 files changed, 1740 insertions(+)
 create mode 100644 drivers/crypto/hisilicon/qm.c
 create mode 100644 drivers/crypto/hisilicon/qm.h

diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
index 8ca9c50..b79be8d 100644
--- a/drivers/crypto/hisilicon/Kconfig
+++ b/drivers/crypto/hisilicon/Kconfig
@@ -12,3 +12,10 @@ config CRYPTO_DEV_HISI_SEC
 
 	  To compile this as a module, choose M here: the module
 	  will be called hisi_sec.
+
+config CRYPTO_DEV_HISI_QM
+	tristate
+	depends on ARM64 && PCI && PCI_MSI
+	help
+	  HiSilicon accelerator engines use a common queue management
+	  interface. Specific engine driver may use this module.
diff --git a/drivers/crypto/hisilicon/Makefile b/drivers/crypto/hisilicon/Makefile
index 463f46a..05e9052 100644
--- a/drivers/crypto/hisilicon/Makefile
+++ b/drivers/crypto/hisilicon/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CRYPTO_DEV_HISI_SEC) += sec/
+obj-$(CONFIG_CRYPTO_DEV_HISI_QM) += qm.o
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
new file mode 100644
index 0000000..c095d47
--- /dev/null
+++ b/drivers/crypto/hisilicon/qm.c
@@ -0,0 +1,1550 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2019 HiSilicon Limited. */
+#include <asm/page.h>
+#include <linux/bitmap.h>
+#include <linux/dma-mapping.h>
+#include <linux/io.h>
+#include <linux/irqreturn.h>
+#include <linux/log2.h>
+#include <linux/slab.h>
+#include "qm.h"
+
+/* eq/aeq irq enable */
+#define QM_VF_AEQ_INT_SOURCE		0x0
+#define QM_VF_AEQ_INT_MASK		0x4
+#define QM_VF_EQ_INT_SOURCE		0x8
+#define QM_VF_EQ_INT_MASK		0xc
+#define QM_IRQ_NUM_V1			1
+#define QM_IRQ_NUM_PF_V2		4
+
+#define QM_EQ_EVENT_IRQ_VECTOR		0
+#define QM_AEQ_EVENT_IRQ_VECTOR		1
+#define QM_ABNORMAL_EVENT_IRQ_VECTOR	3
+
+/* mailbox */
+#define QM_MB_CMD_SQC			0x0
+#define QM_MB_CMD_CQC			0x1
+#define QM_MB_CMD_EQC			0x2
+#define QM_MB_CMD_AEQC			0x3
+#define QM_MB_CMD_SQC_BT		0x4
+#define QM_MB_CMD_CQC_BT		0x5
+#define QM_MB_CMD_SQC_VFT_V2		0x6
+
+#define QM_MB_CMD_SEND_BASE		0x300
+#define QM_MB_EVENT_SHIFT		8
+#define QM_MB_BUSY_SHIFT		13
+#define QM_MB_OP_SHIFT			14
+#define QM_MB_CMD_DATA_ADDR_L		0x304
+#define QM_MB_CMD_DATA_ADDR_H		0x308
+
+/* sqc shift */
+#define QM_SQ_HOP_NUM_SHIFT		0
+#define QM_SQ_PAGE_SIZE_SHIFT		4
+#define QM_SQ_BUF_SIZE_SHIFT		8
+#define QM_SQ_SQE_SIZE_SHIFT		12
+#define QM_SQ_PRIORITY_SHIFT		0
+#define QM_SQ_ORDERS_SHIFT		4
+#define QM_SQ_TYPE_SHIFT		8
+
+#define QM_SQ_TYPE_MASK			GENMASK(3, 0)
+
+/* cqc shift */
+#define QM_CQ_HOP_NUM_SHIFT		0
+#define QM_CQ_PAGE_SIZE_SHIFT		4
+#define QM_CQ_BUF_SIZE_SHIFT		8
+#define QM_CQ_CQE_SIZE_SHIFT		12
+#define QM_CQ_PHASE_SHIFT		0
+#define QM_CQ_FLAG_SHIFT		1
+
+#define QM_CQE_PHASE(cqe)		((cqe)->w7 & 0x1)
+#define QM_QC_CQE_SIZE			4
+
+/* eqc shift */
+#define QM_EQE_AEQE_SIZE		(2UL << 12)
+#define QM_EQC_PHASE_SHIFT		16
+
+#define QM_EQE_PHASE(eqe)		(((eqe)->dw0 >> 16) & 0x1)
+#define QM_EQE_CQN_MASK			GENMASK(15, 0)
+
+#define QM_AEQE_PHASE(aeqe)		(((aeqe)->dw0 >> 16) & 0x1)
+#define QM_AEQE_TYPE_SHIFT		17
+
+#define QM_DOORBELL_CMD_SQ		0
+#define QM_DOORBELL_CMD_CQ		1
+#define QM_DOORBELL_CMD_EQ		2
+#define QM_DOORBELL_CMD_AEQ		3
+
+#define QM_DOORBELL_BASE_V1		0x340
+#define QM_DB_CMD_SHIFT_V1		16
+#define QM_DB_INDEX_SHIFT_V1		32
+#define QM_DB_PRIORITY_SHIFT_V1		48
+#define QM_DOORBELL_SQ_CQ_BASE_V2	0x1000
+#define QM_DOORBELL_EQ_AEQ_BASE_V2	0x2000
+#define QM_DB_CMD_SHIFT_V2		12
+#define QM_DB_RAND_SHIFT_V2		16
+#define QM_DB_INDEX_SHIFT_V2		32
+#define QM_DB_PRIORITY_SHIFT_V2		48
+
+#define QM_MEM_START_INIT		0x100040
+#define QM_MEM_INIT_DONE		0x100044
+#define QM_VFT_CFG_RDY			0x10006c
+#define QM_VFT_CFG_OP_WR		0x100058
+#define QM_VFT_CFG_TYPE			0x10005c
+#define QM_SQC_VFT			0x0
+#define QM_CQC_VFT			0x1
+#define QM_VFT_CFG			0x100060
+#define QM_VFT_CFG_OP_ENABLE		0x100054
+
+#define QM_VFT_CFG_DATA_L		0x100064
+#define QM_VFT_CFG_DATA_H		0x100068
+#define QM_SQC_VFT_BUF_SIZE		(7ULL << 8)
+#define QM_SQC_VFT_SQC_SIZE		(5ULL << 12)
+#define QM_SQC_VFT_INDEX_NUMBER		(1ULL << 16)
+#define QM_SQC_VFT_START_SQN_SHIFT	28
+#define QM_SQC_VFT_VALID		(1ULL << 44)
+#define QM_SQC_VFT_SQN_SHIFT		45
+#define QM_CQC_VFT_BUF_SIZE		(7ULL << 8)
+#define QM_CQC_VFT_SQC_SIZE		(5ULL << 12)
+#define QM_CQC_VFT_INDEX_NUMBER		(1ULL << 16)
+#define QM_CQC_VFT_VALID		(1ULL << 28)
+
+#define QM_SQC_VFT_BASE_SHIFT_V2	28
+#define QM_SQC_VFT_BASE_MASK_V2		GENMASK(5, 0)
+#define QM_SQC_VFT_NUM_SHIFT_V2		45
+#define QM_SQC_VFT_NUM_MASK_v2		GENMASK(9, 0)
+
+
+#define QM_ABNORMAL_INT_SOURCE		0x100000
+#define QM_ABNORMAL_INT_MASK		0x100004
+#define QM_ABNORMAL_INT_MASK_VALUE	0x1fff
+#define QM_ABNORMAL_INT_STATUS		0x100008
+#define QM_ABNORMAL_INF00		0x100010
+#define QM_FIFO_OVERFLOW_TYPE		0xc0
+#define QM_FIFO_OVERFLOW_TYPE_SHIFT	6
+#define QM_FIFO_OVERFLOW_VF		0x3f
+#define QM_ABNORMAL_INF01		0x100014
+#define QM_DB_TIMEOUT_TYPE		0xc0
+#define QM_DB_TIMEOUT_TYPE_SHIFT	6
+#define QM_DB_TIMEOUT_VF		0x3f
+#define QM_RAS_CE_ENABLE		0x1000ec
+#define QM_RAS_FE_ENABLE		0x1000f0
+#define QM_RAS_NFE_ENABLE		0x1000f4
+#define QM_RAS_CE_THRESHOLD		0x1000f8
+#define QM_RAS_CE_TIMES_PER_IRQ		1
+#define QM_RAS_MSI_INT_SEL		0x1040f4
+
+#define QM_CACHE_WB_START		0x204
+#define QM_CACHE_WB_DONE		0x208
+
+#define PCI_BAR_2			2
+#define QM_SQE_DATA_ALIGN_MASK		GENMASK(6, 0)
+#define QMC_ALIGN(sz)			ALIGN(sz, 32)
+
+
+#define QM_MK_CQC_DW3_V1(hop_num, pg_sz, buf_sz, cqe_sz) \
+	(((hop_num) << QM_CQ_HOP_NUM_SHIFT)	| \
+	((pg_sz) << QM_CQ_PAGE_SIZE_SHIFT)	| \
+	((buf_sz) << QM_CQ_BUF_SIZE_SHIFT)	| \
+	((cqe_sz) << QM_CQ_CQE_SIZE_SHIFT))
+
+#define QM_MK_CQC_DW3_V2(cqe_sz) \
+	((QM_Q_DEPTH - 1) | ((cqe_sz) << QM_CQ_CQE_SIZE_SHIFT))
+
+#define QM_MK_SQC_W13(priority, orders, alg_type) \
+	(((priority) << QM_SQ_PRIORITY_SHIFT)	| \
+	((orders) << QM_SQ_ORDERS_SHIFT)	| \
+	(((alg_type) & QM_SQ_TYPE_MASK) << QM_SQ_TYPE_SHIFT))
+
+#define QM_MK_SQC_DW3_V1(hop_num, pg_sz, buf_sz, sqe_sz) \
+	(((hop_num) << QM_SQ_HOP_NUM_SHIFT)	| \
+	((pg_sz) << QM_SQ_PAGE_SIZE_SHIFT)	| \
+	((buf_sz) << QM_SQ_BUF_SIZE_SHIFT)	| \
+	((u32)ilog2(sqe_sz) << QM_SQ_SQE_SIZE_SHIFT))
+
+#define QM_MK_SQC_DW3_V2(sqe_sz) \
+	((QM_Q_DEPTH - 1) | ((u32)ilog2(sqe_sz) << QM_SQ_SQE_SIZE_SHIFT))
+
+#define INIT_QC_COMMON(qc, base, pasid) do {	\
+	(qc)->head = 0;				\
+	(qc)->tail = 0;				\
+	(qc)->base_l = lower_32_bits(base);	\
+	(qc)->base_h = upper_32_bits(base);	\
+	(qc)->dw3 = 0;				\
+	(qc)->w8 = 0;				\
+	(qc)->rsvd0 = 0;			\
+	(qc)->pasid = pasid;			\
+	(qc)->w11 = 0;				\
+	(qc)->rsvd1 = 0;			\
+} while (0)
+
+enum vft_type {
+	SQC_VFT = 0,
+	CQC_VFT,
+};
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
+struct qm_mailbox {
+	__le16 w0;
+	__le16 queue_num;
+	__le32 base_l;
+	__le32 base_h;
+	__le32 rsvd;
+};
+
+struct qm_doorbell {
+	__le16 queue_num;
+	__le16 cmd;
+	__le16 index;
+	__le16 priority;
+};
+
+struct hisi_qm_hw_ops {
+	void (*qm_db)(struct hisi_qm *qm, u16 qn,
+		      u8 cmd, u16 index, u8 priority);
+	u32 (*get_irq_num)(struct hisi_qm *qm);
+	void (*hw_error_init)(struct hisi_qm *qm, u32 ce, u32 nfe, u32 fe,
+			      u32 msi);
+	pci_ers_result_t (*hw_error_handle)(struct hisi_qm *qm);
+};
+
+struct hisi_qm_hw_error {
+	u32 int_msk;
+	const char *msg;
+};
+
+static const struct hisi_qm_hw_error qm_hw_error[] = {
+	{ .int_msk = BIT(0), .msg = "qm_axi_rresp" },
+	{ .int_msk = BIT(1), .msg = "qm_axi_bresp" },
+	{ .int_msk = BIT(2), .msg = "qm_ecc_mbit" },
+	{ .int_msk = BIT(3), .msg = "qm_ecc_1bit" },
+	{ .int_msk = BIT(4), .msg = "qm_acc_get_task_timeout" },
+	{ .int_msk = BIT(5), .msg = "qm_acc_do_task_timeout" },
+	{ .int_msk = BIT(6), .msg = "qm_acc_wb_not_ready_timeout" },
+	{ .int_msk = BIT(7), .msg = "qm_sq_cq_vf_invalid" },
+	{ .int_msk = BIT(8), .msg = "qm_cq_vf_invalid" },
+	{ .int_msk = BIT(9), .msg = "qm_sq_vf_invalid" },
+	{ .int_msk = BIT(10), .msg = "qm_db_timeout" },
+	{ .int_msk = BIT(11), .msg = "qm_of_fifo_of" },
+	{ .int_msk = BIT(12), .msg = "qm_db_random_invalid" },
+	{ /* sentinel */ }
+};
+
+static const char * const qm_db_timeout[] = {
+	"sq", "cq", "eq", "aeq",
+};
+
+static const char * const qm_fifo_overflow[] = {
+	"cq", "eq", "aeq",
+};
+
+/* return 0 mailbox ready, -ETIMEDOUT hardware timeout */
+static int qm_wait_mb_ready(struct hisi_qm *qm)
+{
+	u32 val;
+
+	return readl_relaxed_poll_timeout(qm->io_base + QM_MB_CMD_SEND_BASE,
+					  val, !((val >> QM_MB_BUSY_SHIFT) &
+					  0x1), 10, 1000);
+}
+
+/* 128 bit should be written to hardware at one time to trigger a mailbox */
+static void qm_mb_write(struct hisi_qm *qm, const void *src)
+{
+	void __iomem *fun_base = qm->io_base + QM_MB_CMD_SEND_BASE;
+	unsigned long tmp0 = 0, tmp1 = 0;
+
+	asm volatile("ldp %0, %1, %3\n"
+		     "stp %0, %1, %2\n"
+		     "dsb sy\n"
+		     : "=&r" (tmp0),
+		       "=&r" (tmp1),
+		       "+Q" (*((char *)fun_base))
+		     : "Q" (*((char *)src))
+		     : "memory");
+}
+
+static int qm_mb(struct hisi_qm *qm, u8 cmd, dma_addr_t dma_addr, u16 queue,
+		 bool op)
+{
+	struct qm_mailbox mailbox;
+	int ret = 0;
+
+	dev_dbg(&qm->pdev->dev, "QM mailbox request to q%u: %u-%llx\n", queue,
+		cmd, dma_addr);
+
+	mailbox.w0 = cmd |
+		     (op ? 0x1 << QM_MB_OP_SHIFT : 0) |
+		     (0x1 << QM_MB_BUSY_SHIFT);
+	mailbox.queue_num = queue;
+	mailbox.base_l = lower_32_bits(dma_addr);
+	mailbox.base_h = upper_32_bits(dma_addr);
+	mailbox.rsvd = 0;
+
+	mutex_lock(&qm->mailbox_lock);
+
+	if (unlikely(qm_wait_mb_ready(qm))) {
+		ret = -EBUSY;
+		dev_err(&qm->pdev->dev, "QM mailbox is busy to start!\n");
+		goto busy_unlock;
+	}
+
+	qm_mb_write(qm, &mailbox);
+
+	if (unlikely(qm_wait_mb_ready(qm))) {
+		ret = -EBUSY;
+		dev_err(&qm->pdev->dev, "QM mailbox operation timeout!\n");
+		goto busy_unlock;
+	}
+
+busy_unlock:
+	mutex_unlock(&qm->mailbox_lock);
+
+	return ret;
+}
+
+static void qm_db_v1(struct hisi_qm *qm, u16 qn, u8 cmd, u16 index, u8 priority)
+{
+	u64 doorbell;
+
+	doorbell = qn | ((u64)cmd << QM_DB_CMD_SHIFT_V1) |
+		   ((u64)index << QM_DB_INDEX_SHIFT_V1)  |
+		   ((u64)priority << QM_DB_PRIORITY_SHIFT_V1);
+
+	writeq(doorbell, qm->io_base + QM_DOORBELL_BASE_V1);
+}
+
+static void qm_db_v2(struct hisi_qm *qm, u16 qn, u8 cmd, u16 index, u8 priority)
+{
+	u64 doorbell;
+	u64 dbase;
+	u16 randata = 0;
+
+	if (cmd == QM_DOORBELL_CMD_SQ || cmd == QM_DOORBELL_CMD_CQ)
+		dbase = QM_DOORBELL_SQ_CQ_BASE_V2;
+	else
+		dbase = QM_DOORBELL_EQ_AEQ_BASE_V2;
+
+	doorbell = qn | ((u64)cmd << QM_DB_CMD_SHIFT_V2) |
+		   ((u64)randata << QM_DB_RAND_SHIFT_V2) |
+		   ((u64)index << QM_DB_INDEX_SHIFT_V2)	 |
+		   ((u64)priority << QM_DB_PRIORITY_SHIFT_V2);
+
+	writeq(doorbell, qm->io_base + dbase);
+}
+
+static void qm_db(struct hisi_qm *qm, u16 qn, u8 cmd, u16 index, u8 priority)
+{
+	dev_dbg(&qm->pdev->dev, "QM doorbell request: qn=%u, cmd=%u, index=%u\n",
+		qn, cmd, index);
+
+	qm->ops->qm_db(qm, qn, cmd, index, priority);
+}
+
+static int qm_dev_mem_reset(struct hisi_qm *qm)
+{
+	u32 val;
+
+	writel(0x1, qm->io_base + QM_MEM_START_INIT);
+	return readl_relaxed_poll_timeout(qm->io_base + QM_MEM_INIT_DONE, val,
+					  val & BIT(0), 10, 1000);
+}
+
+static u32 qm_get_irq_num_v1(struct hisi_qm *qm)
+{
+	return QM_IRQ_NUM_V1;
+}
+
+static u32 qm_get_irq_num_v2(struct hisi_qm *qm)
+{
+	return QM_IRQ_NUM_PF_V2;
+}
+
+static struct hisi_qp *qm_to_hisi_qp(struct hisi_qm *qm, struct qm_eqe *eqe)
+{
+	u16 cqn = eqe->dw0 & QM_EQE_CQN_MASK;
+
+	return qm->qp_array[cqn];
+}
+
+static void qm_cq_head_update(struct hisi_qp *qp)
+{
+	if (qp->qp_status.cq_head == QM_Q_DEPTH - 1) {
+		qp->qp_status.cqc_phase = !qp->qp_status.cqc_phase;
+		qp->qp_status.cq_head = 0;
+	} else {
+		qp->qp_status.cq_head++;
+	}
+}
+
+static void qm_poll_qp(struct hisi_qp *qp, struct hisi_qm *qm)
+{
+	struct qm_cqe *cqe = qp->cqe + qp->qp_status.cq_head;
+
+	if (qp->req_cb) {
+		while (QM_CQE_PHASE(cqe) == qp->qp_status.cqc_phase) {
+			dma_rmb();
+			qp->req_cb(qp, qp->sqe + qm->sqe_size * cqe->sq_head);
+			qm_cq_head_update(qp);
+			cqe = qp->cqe + qp->qp_status.cq_head;
+			qm_db(qm, qp->qp_id, QM_DOORBELL_CMD_CQ,
+			      qp->qp_status.cq_head, 0);
+			atomic_dec(&qp->qp_status.used);
+		}
+
+		/* set c_flag */
+		qm_db(qm, qp->qp_id, QM_DOORBELL_CMD_CQ,
+		      qp->qp_status.cq_head, 1);
+	}
+}
+
+static void qm_qp_work_func(struct work_struct *work)
+{
+	struct hisi_qp *qp;
+
+	qp = container_of(work, struct hisi_qp, work);
+	qm_poll_qp(qp, qp->qm);
+}
+
+static irqreturn_t qm_irq_handler(int irq, void *data)
+{
+	struct hisi_qm *qm = data;
+	struct qm_eqe *eqe = qm->eqe + qm->status.eq_head;
+	struct hisi_qp *qp;
+	int eqe_num = 0;
+
+	while (QM_EQE_PHASE(eqe) == qm->status.eqc_phase) {
+		eqe_num++;
+		qp = qm_to_hisi_qp(qm, eqe);
+		if (qp)
+			queue_work(qp->wq, &qp->work);
+
+		if (qm->status.eq_head == QM_Q_DEPTH - 1) {
+			qm->status.eqc_phase = !qm->status.eqc_phase;
+			eqe = qm->eqe;
+			qm->status.eq_head = 0;
+		} else {
+			eqe++;
+			qm->status.eq_head++;
+		}
+
+		if (eqe_num == QM_Q_DEPTH / 2 - 1) {
+			eqe_num = 0;
+			qm_db(qm, 0, QM_DOORBELL_CMD_EQ, qm->status.eq_head, 0);
+		}
+	}
+
+	qm_db(qm, 0, QM_DOORBELL_CMD_EQ, qm->status.eq_head, 0);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t qm_irq(int irq, void *data)
+{
+	struct hisi_qm *qm = data;
+
+	if (readl(qm->io_base + QM_VF_EQ_INT_SOURCE))
+		return qm_irq_handler(irq, data);
+
+	dev_err(&qm->pdev->dev, "invalid int source\n");
+	qm_db(qm, 0, QM_DOORBELL_CMD_EQ, qm->status.eq_head, 0);
+
+	return IRQ_NONE;
+}
+
+static irqreturn_t qm_aeq_irq(int irq, void *data)
+{
+	struct hisi_qm *qm = data;
+	struct qm_aeqe *aeqe = qm->aeqe + qm->status.aeq_head;
+	u32 type;
+
+	if (!readl(qm->io_base + QM_VF_AEQ_INT_SOURCE))
+		return IRQ_NONE;
+
+	while (QM_AEQE_PHASE(aeqe) == qm->status.aeqc_phase) {
+		type = aeqe->dw0 >> QM_AEQE_TYPE_SHIFT;
+		if (type < ARRAY_SIZE(qm_fifo_overflow))
+			dev_err(&qm->pdev->dev, "%s overflow\n",
+				qm_fifo_overflow[type]);
+		else
+			dev_err(&qm->pdev->dev, "unknown error type %d\n",
+				type);
+
+		if (qm->status.aeq_head == QM_Q_DEPTH - 1) {
+			qm->status.aeqc_phase = !qm->status.aeqc_phase;
+			aeqe = qm->aeqe;
+			qm->status.aeq_head = 0;
+		} else {
+			aeqe++;
+			qm->status.aeq_head++;
+		}
+
+		qm_db(qm, 0, QM_DOORBELL_CMD_AEQ, qm->status.aeq_head, 0);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t qm_abnormal_irq(int irq, void *data)
+{
+	const struct hisi_qm_hw_error *err = qm_hw_error;
+	struct hisi_qm *qm = data;
+	struct device *dev = &qm->pdev->dev;
+	u32 error_status, tmp;
+
+	/* read err sts */
+	tmp = readl(qm->io_base + QM_ABNORMAL_INT_STATUS);
+	error_status = qm->msi_mask & tmp;
+
+	while (err->msg) {
+		if (err->int_msk & error_status)
+			dev_err(dev, "%s [error status=0x%x] found\n",
+				err->msg, err->int_msk);
+
+		err++;
+	}
+
+	/* clear err sts */
+	writel(error_status, qm->io_base + QM_ABNORMAL_INT_SOURCE);
+
+	return IRQ_HANDLED;
+}
+
+static int qm_irq_register(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+	int ret;
+
+	ret = request_irq(pci_irq_vector(pdev, QM_EQ_EVENT_IRQ_VECTOR),
+			  qm_irq, IRQF_SHARED, qm->dev_name, qm);
+	if (ret)
+		return ret;
+
+	if (qm->ver == QM_HW_V2) {
+		ret = request_irq(pci_irq_vector(pdev, QM_AEQ_EVENT_IRQ_VECTOR),
+				  qm_aeq_irq, IRQF_SHARED, qm->dev_name, qm);
+		if (ret)
+			goto err_aeq_irq;
+
+		ret = request_irq(pci_irq_vector(pdev,
+				  QM_ABNORMAL_EVENT_IRQ_VECTOR),
+				  qm_abnormal_irq, IRQF_SHARED,
+				  qm->dev_name, qm);
+		if (ret)
+			goto err_abonormal_irq;
+	}
+
+	return 0;
+
+err_abonormal_irq:
+	free_irq(pci_irq_vector(pdev, QM_AEQ_EVENT_IRQ_VECTOR), qm);
+err_aeq_irq:
+	free_irq(pci_irq_vector(pdev, QM_EQ_EVENT_IRQ_VECTOR), qm);
+	return ret;
+}
+
+static void qm_irq_unregister(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+
+	free_irq(pci_irq_vector(pdev, QM_EQ_EVENT_IRQ_VECTOR), qm);
+
+	if (qm->ver == QM_HW_V2) {
+		free_irq(pci_irq_vector(pdev, QM_AEQ_EVENT_IRQ_VECTOR), qm);
+		free_irq(pci_irq_vector(pdev,
+					QM_ABNORMAL_EVENT_IRQ_VECTOR), qm);
+	}
+}
+
+static void qm_init_qp_status(struct hisi_qp *qp)
+{
+	struct hisi_qp_status *qp_status = &qp->qp_status;
+
+	qp_status->sq_tail = 0;
+	qp_status->cq_head = 0;
+	qp_status->cqc_phase = 1;
+	qp_status->flags = 0;
+}
+
+static void qm_vft_data_cfg(struct hisi_qm *qm, enum vft_type type, u32 base,
+			    u32 number)
+{
+	u64 tmp = 0;
+
+	if (number > 0) {
+		switch (type) {
+		case SQC_VFT:
+			switch (qm->ver) {
+			case QM_HW_V1:
+				tmp = QM_SQC_VFT_BUF_SIZE	|
+				      QM_SQC_VFT_SQC_SIZE	|
+				      QM_SQC_VFT_INDEX_NUMBER	|
+				      QM_SQC_VFT_VALID		|
+				      (u64)base << QM_SQC_VFT_START_SQN_SHIFT;
+				break;
+			case QM_HW_V2:
+				tmp = (u64)base << QM_SQC_VFT_START_SQN_SHIFT |
+				      QM_SQC_VFT_VALID |
+				      (u64)(number - 1) << QM_SQC_VFT_SQN_SHIFT;
+				break;
+			case QM_HW_UNKNOWN:
+				break;
+			}
+			break;
+		case CQC_VFT:
+			switch (qm->ver) {
+			case QM_HW_V1:
+				tmp = QM_CQC_VFT_BUF_SIZE	|
+				      QM_CQC_VFT_SQC_SIZE	|
+				      QM_CQC_VFT_INDEX_NUMBER	|
+				      QM_CQC_VFT_VALID;
+				break;
+			case QM_HW_V2:
+				tmp = QM_CQC_VFT_VALID;
+				break;
+			case QM_HW_UNKNOWN:
+				break;
+			}
+			break;
+		}
+	}
+
+	writel(lower_32_bits(tmp), qm->io_base + QM_VFT_CFG_DATA_L);
+	writel(upper_32_bits(tmp), qm->io_base + QM_VFT_CFG_DATA_H);
+}
+
+static int qm_set_vft_common(struct hisi_qm *qm, enum vft_type type,
+			     u32 fun_num, u32 base, u32 number)
+{
+	unsigned int val;
+	int ret;
+
+	ret = readl_relaxed_poll_timeout(qm->io_base + QM_VFT_CFG_RDY, val,
+					 val & BIT(0), 10, 1000);
+	if (ret)
+		return ret;
+
+	writel(0x0, qm->io_base + QM_VFT_CFG_OP_WR);
+	writel(type, qm->io_base + QM_VFT_CFG_TYPE);
+	writel(fun_num, qm->io_base + QM_VFT_CFG);
+
+	qm_vft_data_cfg(qm, type, base, number);
+
+	writel(0x0, qm->io_base + QM_VFT_CFG_RDY);
+	writel(0x1, qm->io_base + QM_VFT_CFG_OP_ENABLE);
+
+	return readl_relaxed_poll_timeout(qm->io_base + QM_VFT_CFG_RDY, val,
+					  val & BIT(0), 10, 1000);
+}
+
+/* The config should be conducted after qm_dev_mem_reset() */
+static int qm_set_sqc_cqc_vft(struct hisi_qm *qm, u32 fun_num, u32 base,
+			      u32 number)
+{
+	int ret, i;
+
+	for (i = SQC_VFT; i <= CQC_VFT; i++) {
+		ret = qm_set_vft_common(qm, i, fun_num, base, number);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void qm_hw_error_init_v1(struct hisi_qm *qm, u32 ce, u32 nfe, u32 fe,
+				u32 msi)
+{
+	dev_info(&qm->pdev->dev,
+		 "QM v%d does not support hw error handle\n", qm->ver);
+
+	writel(QM_ABNORMAL_INT_MASK_VALUE, qm->io_base + QM_ABNORMAL_INT_MASK);
+}
+
+static void qm_hw_error_init_v2(struct hisi_qm *qm, u32 ce, u32 nfe, u32 fe,
+				u32 msi)
+{
+	u32 irq_enable = ce | nfe | fe | msi;
+	u32 irq_unmask = ~irq_enable;
+
+	qm->error_mask = ce | nfe | fe;
+	qm->msi_mask = msi;
+
+	/* configure error type */
+	writel(ce, qm->io_base + QM_RAS_CE_ENABLE);
+	writel(QM_RAS_CE_TIMES_PER_IRQ, qm->io_base + QM_RAS_CE_THRESHOLD);
+	writel(nfe, qm->io_base + QM_RAS_NFE_ENABLE);
+	writel(fe, qm->io_base + QM_RAS_FE_ENABLE);
+
+	/* use RAS irq default, so only set QM_RAS_MSI_INT_SEL for MSI */
+	writel(msi, qm->io_base + QM_RAS_MSI_INT_SEL);
+
+	irq_unmask &= readl(qm->io_base + QM_ABNORMAL_INT_MASK);
+	writel(irq_unmask, qm->io_base + QM_ABNORMAL_INT_MASK);
+}
+
+static void qm_log_hw_error(struct hisi_qm *qm, u32 error_status)
+{
+	const struct hisi_qm_hw_error *err = qm_hw_error;
+	struct device *dev = &qm->pdev->dev;
+	u32 reg_val, type, vf_num;
+
+	while (err->msg) {
+		if (err->int_msk & error_status) {
+			dev_err(dev, "%s [error status=0x%x] found\n",
+				err->msg, err->int_msk);
+
+			if (error_status & QM_DB_TIMEOUT) {
+				reg_val = readl(qm->io_base +
+						QM_ABNORMAL_INF01);
+				type = (reg_val & QM_DB_TIMEOUT_TYPE) >>
+				       QM_DB_TIMEOUT_TYPE_SHIFT;
+				vf_num = reg_val & QM_DB_TIMEOUT_VF;
+				dev_err(dev, "qm %s doorbell timeout in function %u\n",
+					qm_db_timeout[type], vf_num);
+			}
+
+			if (error_status & QM_OF_FIFO_OF) {
+				reg_val = readl(qm->io_base +
+						QM_ABNORMAL_INF00);
+				type = (reg_val & QM_FIFO_OVERFLOW_TYPE) >>
+				       QM_FIFO_OVERFLOW_TYPE_SHIFT;
+				vf_num = reg_val & QM_FIFO_OVERFLOW_VF;
+
+				if (type < ARRAY_SIZE(qm_fifo_overflow))
+					dev_err(dev, "qm %s fifo overflow in function %u\n",
+						qm_fifo_overflow[type],
+						vf_num);
+				else
+					dev_err(dev, "unknown error type\n");
+			}
+		}
+		err++;
+	}
+}
+
+static pci_ers_result_t qm_hw_error_handle_v2(struct hisi_qm *qm)
+{
+	u32 error_status, tmp;
+
+	/* read err sts */
+	tmp = readl(qm->io_base + QM_ABNORMAL_INT_STATUS);
+	error_status = qm->error_mask & tmp;
+
+	if (error_status) {
+		qm_log_hw_error(qm, error_status);
+
+		/* clear err sts */
+		writel(error_status, qm->io_base + QM_ABNORMAL_INT_SOURCE);
+
+		return PCI_ERS_RESULT_NEED_RESET;
+	}
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+static const struct hisi_qm_hw_ops qm_hw_ops_v1 = {
+	.qm_db = qm_db_v1,
+	.get_irq_num = qm_get_irq_num_v1,
+	.hw_error_init = qm_hw_error_init_v1,
+};
+
+static const struct hisi_qm_hw_ops qm_hw_ops_v2 = {
+	.qm_db = qm_db_v2,
+	.get_irq_num = qm_get_irq_num_v2,
+	.hw_error_init = qm_hw_error_init_v2,
+	.hw_error_handle = qm_hw_error_handle_v2,
+};
+
+static void *qm_get_avail_sqe(struct hisi_qp *qp)
+{
+	struct hisi_qp_status *qp_status = &qp->qp_status;
+	u16 sq_tail = qp_status->sq_tail;
+
+	if (unlikely(atomic_read(&qp->qp_status.used) == QM_Q_DEPTH))
+		return NULL;
+
+	return qp->sqe + sq_tail * qp->qm->sqe_size;
+}
+
+/**
+ * hisi_qm_create_qp() - Create a queue pair from qm.
+ * @qm: The qm we create a qp from.
+ * @alg_type: Accelerator specific algorithm type in sqc.
+ *
+ * return created qp, -EBUSY if all qps in qm allocated, -ENOMEM if allocating
+ * qp memory fails.
+ */
+struct hisi_qp *hisi_qm_create_qp(struct hisi_qm *qm, u8 alg_type)
+{
+	struct device *dev = &qm->pdev->dev;
+	struct hisi_qp *qp;
+	int qp_id, ret;
+
+	qp = kzalloc(sizeof(*qp), GFP_KERNEL);
+	if (!qp)
+		return ERR_PTR(-ENOMEM);
+
+	write_lock(&qm->qps_lock);
+
+	qp_id = find_first_zero_bit(qm->qp_bitmap, qm->qp_num);
+	if (qp_id >= qm->qp_num) {
+		write_unlock(&qm->qps_lock);
+		dev_info(&qm->pdev->dev, "QM all queues are busy!\n");
+		ret = -EBUSY;
+		goto err_free_qp;
+	}
+	set_bit(qp_id, qm->qp_bitmap);
+	qm->qp_array[qp_id] = qp;
+
+	write_unlock(&qm->qps_lock);
+
+	qp->qm = qm;
+
+	if (qm->use_dma_api) {
+		qp->qdma.size = qm->sqe_size * QM_Q_DEPTH +
+				sizeof(struct qm_cqe) * QM_Q_DEPTH;
+		qp->qdma.va = dma_alloc_coherent(dev, qp->qdma.size,
+						 &qp->qdma.dma, GFP_KERNEL);
+		if (!qp->qdma.va) {
+			ret = -ENOMEM;
+			goto err_clear_bit;
+		}
+
+		dev_dbg(dev, "allocate qp dma buf(va=%pK, dma=%pad, size=%lx)\n",
+			qp->qdma.va, &qp->qdma.dma, qp->qdma.size);
+	}
+
+	qp->qp_id = qp_id;
+	qp->alg_type = alg_type;
+	INIT_WORK(&qp->work, qm_qp_work_func);
+	qp->wq = alloc_workqueue("hisi_qm", WQ_UNBOUND | WQ_HIGHPRI |
+				 WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM, 0);
+	if (!qp->wq) {
+		ret = -EFAULT;
+		goto err_free_qp_mem;
+	}
+
+	return qp;
+
+err_free_qp_mem:
+	if (qm->use_dma_api)
+		dma_free_coherent(dev, qp->qdma.size, qp->qdma.va,
+				  qp->qdma.dma);
+err_clear_bit:
+	write_lock(&qm->qps_lock);
+	qm->qp_array[qp_id] = NULL;
+	clear_bit(qp_id, qm->qp_bitmap);
+	write_unlock(&qm->qps_lock);
+err_free_qp:
+	kfree(qp);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(hisi_qm_create_qp);
+
+/**
+ * hisi_qm_release_qp() - Release a qp back to its qm.
+ * @qp: The qp we want to release.
+ *
+ * This function releases the resource of a qp.
+ */
+void hisi_qm_release_qp(struct hisi_qp *qp)
+{
+	struct hisi_qm *qm = qp->qm;
+	struct qm_dma *qdma = &qp->qdma;
+	struct device *dev = &qm->pdev->dev;
+
+	if (qm->use_dma_api && qdma->va)
+		dma_free_coherent(dev, qdma->size, qdma->va, qdma->dma);
+
+	write_lock(&qm->qps_lock);
+	qm->qp_array[qp->qp_id] = NULL;
+	clear_bit(qp->qp_id, qm->qp_bitmap);
+	write_unlock(&qm->qps_lock);
+
+	kfree(qp);
+}
+EXPORT_SYMBOL_GPL(hisi_qm_release_qp);
+
+static int qm_qp_ctx_cfg(struct hisi_qp *qp, int qp_id, int pasid)
+{
+	struct hisi_qm *qm = qp->qm;
+	struct device *dev = &qm->pdev->dev;
+	enum qm_hw_ver ver = qm->ver;
+	struct qm_sqc *sqc;
+	struct qm_cqc *cqc;
+	dma_addr_t sqc_dma;
+	dma_addr_t cqc_dma;
+	int ret;
+
+	qm_init_qp_status(qp);
+
+	sqc = kzalloc(sizeof(struct qm_sqc), GFP_KERNEL);
+	if (!sqc)
+		return -ENOMEM;
+	sqc_dma = dma_map_single(dev, sqc, sizeof(struct qm_sqc),
+				 DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, sqc_dma)) {
+		kfree(sqc);
+		return -ENOMEM;
+	}
+
+	INIT_QC_COMMON(sqc, qp->sqe_dma, pasid);
+	if (ver == QM_HW_V1) {
+		sqc->dw3 = QM_MK_SQC_DW3_V1(0, 0, 0, qm->sqe_size);
+		sqc->w8 = QM_Q_DEPTH - 1;
+	} else if (ver == QM_HW_V2) {
+		sqc->dw3 = QM_MK_SQC_DW3_V2(qm->sqe_size);
+		sqc->w8 = 0; /* rand_qc */
+	}
+	sqc->cq_num = qp_id;
+	sqc->w13 = QM_MK_SQC_W13(0, 1, qp->alg_type);
+
+	ret = qm_mb(qm, QM_MB_CMD_SQC, sqc_dma, qp_id, 0);
+	dma_unmap_single(dev, sqc_dma, sizeof(struct qm_sqc), DMA_TO_DEVICE);
+	kfree(sqc);
+	if (ret)
+		return ret;
+
+	cqc = kzalloc(sizeof(struct qm_cqc), GFP_KERNEL);
+	if (!cqc)
+		return -ENOMEM;
+	cqc_dma = dma_map_single(dev, cqc, sizeof(struct qm_cqc),
+				 DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, cqc_dma)) {
+		kfree(cqc);
+		return -ENOMEM;
+	}
+
+	INIT_QC_COMMON(cqc, qp->cqe_dma, pasid);
+	if (ver == QM_HW_V1) {
+		cqc->dw3 = QM_MK_CQC_DW3_V1(0, 0, 0, 4);
+		cqc->w8 = QM_Q_DEPTH - 1;
+	} else if (ver == QM_HW_V2) {
+		cqc->dw3 = QM_MK_CQC_DW3_V2(4);
+		cqc->w8 = 0;
+	}
+	cqc->dw6 = 1 << QM_CQ_PHASE_SHIFT | 1 << QM_CQ_FLAG_SHIFT;
+
+	ret = qm_mb(qm, QM_MB_CMD_CQC, cqc_dma, qp_id, 0);
+	dma_unmap_single(dev, cqc_dma, sizeof(struct qm_cqc), DMA_TO_DEVICE);
+	kfree(cqc);
+
+	return ret;
+}
+
+/**
+ * hisi_qm_start_qp() - Start a qp into running.
+ * @qp: The qp we want to start to run.
+ * @arg: Accelerator specific argument.
+ *
+ * After this function, qp can receive request from user. Return qp_id if
+ * successful, Return -EBUSY if failed.
+ */
+int hisi_qm_start_qp(struct hisi_qp *qp, unsigned long arg)
+{
+	struct hisi_qm *qm = qp->qm;
+	struct device *dev = &qm->pdev->dev;
+	enum qm_hw_ver ver = qm->ver;
+	int qp_id = qp->qp_id;
+	int pasid = arg;
+	size_t off = 0;
+	int ret;
+
+#define QP_INIT_BUF(qp, type, size) do { \
+	(qp)->type = ((qp)->qdma.va + (off)); \
+	(qp)->type##_dma = (qp)->qdma.dma + (off); \
+	off += (size); \
+} while (0)
+
+	if (!qp->qdma.dma) {
+		dev_err(dev, "cannot get qm dma buffer\n");
+		return -EINVAL;
+	}
+
+	/* sq need 128 bytes alignment */
+	if (qp->qdma.dma & QM_SQE_DATA_ALIGN_MASK) {
+		dev_err(dev, "qm sq is not aligned to 128 byte\n");
+		return -EINVAL;
+	}
+
+	QP_INIT_BUF(qp, sqe, qm->sqe_size * QM_Q_DEPTH);
+	QP_INIT_BUF(qp, cqe, sizeof(struct qm_cqe) * QM_Q_DEPTH);
+
+	dev_dbg(dev, "init qp buffer(v%d):\n"
+		     " sqe	(%pK, %lx)\n"
+		     " cqe	(%pK, %lx)\n",
+		     ver, qp->sqe, (unsigned long)qp->sqe_dma,
+		     qp->cqe, (unsigned long)qp->cqe_dma);
+
+	ret = qm_qp_ctx_cfg(qp, qp_id, pasid);
+	if (ret)
+		return ret;
+
+	dev_dbg(dev, "queue %d started\n", qp_id);
+
+	return qp_id;
+}
+EXPORT_SYMBOL_GPL(hisi_qm_start_qp);
+
+/**
+ * hisi_qm_stop_qp() - Stop a qp in qm.
+ * @qp: The qp we want to stop.
+ *
+ * This function is reverse of hisi_qm_start_qp. Return 0 if successful.
+ */
+int hisi_qm_stop_qp(struct hisi_qp *qp)
+{
+	struct device *dev = &qp->qm->pdev->dev;
+	int i = 0;
+
+	/* it is stopped */
+	if (test_bit(QP_STOP, &qp->qp_status.flags))
+		return 0;
+
+	while (atomic_read(&qp->qp_status.used)) {
+		i++;
+		msleep(20);
+		if (i == 10) {
+			dev_err(dev, "Cannot drain out data for stopping, Force to stop!\n");
+			return 0;
+		}
+	}
+
+	set_bit(QP_STOP, &qp->qp_status.flags);
+
+	dev_dbg(dev, "stop queue %u!", qp->qp_id);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hisi_qm_stop_qp);
+
+/**
+ * hisi_qp_send() - Queue up a task in the hardware queue.
+ * @qp: The qp in which to put the message.
+ * @msg: The message.
+ *
+ * This function will return -EBUSY if qp is currently full, and -EAGAIN
+ * if qp related qm is resetting.
+ */
+int hisi_qp_send(struct hisi_qp *qp, const void *msg)
+{
+	struct hisi_qp_status *qp_status = &qp->qp_status;
+	u16 sq_tail = qp_status->sq_tail;
+	u16 sq_tail_next = (sq_tail + 1) % QM_Q_DEPTH;
+	void *sqe = qm_get_avail_sqe(qp);
+
+	if (unlikely(test_bit(QP_STOP, &qp->qp_status.flags))) {
+		dev_info(&qp->qm->pdev->dev, "QP is stopped or resetting\n");
+		return -EAGAIN;
+	}
+
+	if (!sqe)
+		return -EBUSY;
+
+	memcpy(sqe, msg, qp->qm->sqe_size);
+
+	qm_db(qp->qm, qp->qp_id, QM_DOORBELL_CMD_SQ, sq_tail_next, 0);
+	atomic_inc(&qp->qp_status.used);
+	qp_status->sq_tail = sq_tail_next;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hisi_qp_send);
+
+static void hisi_qm_cache_wb(struct hisi_qm *qm)
+{
+	unsigned int val;
+
+	if (qm->ver == QM_HW_V2) {
+		writel(0x1, qm->io_base + QM_CACHE_WB_START);
+		if (readl_relaxed_poll_timeout(qm->io_base + QM_CACHE_WB_DONE,
+					       val, val & BIT(0), 10, 1000))
+			dev_err(&qm->pdev->dev, "QM writeback sqc cache fail!\n");
+	}
+}
+
+/**
+ * hisi_qm_init() - Initialize configures about qm.
+ * @qm: The qm needing init.
+ *
+ * This function init qm, then we can call hisi_qm_start to put qm into work.
+ */
+int hisi_qm_init(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+	struct device *dev = &pdev->dev;
+	unsigned int num_vec;
+	int ret;
+
+	switch (qm->ver) {
+	case QM_HW_V1:
+		qm->ops = &qm_hw_ops_v1;
+		break;
+	case QM_HW_V2:
+		qm->ops = &qm_hw_ops_v2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = pci_enable_device_mem(pdev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to enable device mem!\n");
+		return ret;
+	}
+
+	ret = pci_request_mem_regions(pdev, qm->dev_name);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to request mem regions!\n");
+		goto err_disable_pcidev;
+	}
+
+	qm->io_base = ioremap(pci_resource_start(pdev, PCI_BAR_2),
+			      pci_resource_len(qm->pdev, PCI_BAR_2));
+	if (!qm->io_base) {
+		ret = -EIO;
+		goto err_release_mem_regions;
+	}
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (ret < 0)
+		goto err_iounmap;
+	pci_set_master(pdev);
+
+	if (!qm->ops->get_irq_num) {
+		ret = -EOPNOTSUPP;
+		goto err_iounmap;
+	}
+	num_vec = qm->ops->get_irq_num(qm);
+	ret = pci_alloc_irq_vectors(pdev, num_vec, num_vec, PCI_IRQ_MSI);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable MSI vectors!\n");
+		goto err_iounmap;
+	}
+
+	ret = qm_irq_register(qm);
+	if (ret)
+		goto err_free_irq_vectors;
+
+	mutex_init(&qm->mailbox_lock);
+	rwlock_init(&qm->qps_lock);
+
+	return 0;
+
+err_free_irq_vectors:
+	pci_free_irq_vectors(pdev);
+err_iounmap:
+	iounmap(qm->io_base);
+err_release_mem_regions:
+	pci_release_mem_regions(pdev);
+err_disable_pcidev:
+	pci_disable_device(pdev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hisi_qm_init);
+
+/**
+ * hisi_qm_uninit() - Uninitialize qm.
+ * @qm: The qm needed uninit.
+ *
+ * This function uninits qm related device resources.
+ */
+void hisi_qm_uninit(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+	struct device *dev = &pdev->dev;
+
+	if (qm->use_dma_api && qm->qdma.va) {
+		hisi_qm_cache_wb(qm);
+		dma_free_coherent(dev, qm->qdma.size,
+				  qm->qdma.va, qm->qdma.dma);
+		memset(&qm->qdma, 0, sizeof(qm->qdma));
+	}
+
+	qm_irq_unregister(qm);
+	pci_free_irq_vectors(pdev);
+	iounmap(qm->io_base);
+	pci_release_mem_regions(pdev);
+	pci_disable_device(pdev);
+}
+EXPORT_SYMBOL_GPL(hisi_qm_uninit);
+
+/**
+ * hisi_qm_set_vft() - Set "virtual function table" for a qm.
+ * @fun_num: Number of operated function.
+ * @qm: The qm in which to set vft, alway in a PF.
+ * @base: The base number of queue in vft.
+ * @number: The number of queues in vft. 0 means invalid vft.
+ *
+ * This function is alway called in PF driver, it is used to assign queues
+ * among PF and VFs.
+ *
+ * Assign queues A~B to PF: hisi_qm_set_vft(qm, 0, A, B - A + 1)
+ * Assign queues A~B to VF: hisi_qm_set_vft(qm, 2, A, B - A + 1)
+ * (VF function number 0x2)
+ */
+int hisi_qm_set_vft(struct hisi_qm *qm, u32 fun_num, u32 base,
+		    u32 number)
+{
+	u32 max_q_num = qm->ctrl_qp_num;
+
+	if (base >= max_q_num || number > max_q_num ||
+	    (base + number) > max_q_num)
+		return -EINVAL;
+
+	return qm_set_sqc_cqc_vft(qm, fun_num, base, number);
+}
+EXPORT_SYMBOL_GPL(hisi_qm_set_vft);
+
+static void qm_init_eq_aeq_status(struct hisi_qm *qm)
+{
+	struct hisi_qm_status *status = &qm->status;
+
+	status->eq_head = 0;
+	status->aeq_head = 0;
+	status->eqc_phase = 1;
+	status->aeqc_phase = 1;
+}
+
+static int qm_eq_ctx_cfg(struct hisi_qm *qm)
+{
+	struct device *dev = &qm->pdev->dev;
+	struct qm_eqc *eqc;
+	struct qm_aeqc *aeqc;
+	dma_addr_t eqc_dma;
+	dma_addr_t aeqc_dma;
+	int ret;
+
+	qm_init_eq_aeq_status(qm);
+
+	eqc = kzalloc(sizeof(struct qm_eqc), GFP_KERNEL);
+	if (!eqc)
+		return -ENOMEM;
+	eqc_dma = dma_map_single(dev, eqc, sizeof(struct qm_eqc),
+				 DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, eqc_dma)) {
+		kfree(eqc);
+		return -ENOMEM;
+	}
+
+	eqc->base_l = lower_32_bits(qm->eqe_dma);
+	eqc->base_h = upper_32_bits(qm->eqe_dma);
+	if (qm->ver == QM_HW_V1)
+		eqc->dw3 = QM_EQE_AEQE_SIZE;
+	eqc->dw6 = (QM_Q_DEPTH - 1) | (1 << QM_EQC_PHASE_SHIFT);
+	ret = qm_mb(qm, QM_MB_CMD_EQC, eqc_dma, 0, 0);
+	dma_unmap_single(dev, eqc_dma, sizeof(struct qm_eqc), DMA_TO_DEVICE);
+	kfree(eqc);
+	if (ret)
+		return ret;
+
+	aeqc = kzalloc(sizeof(struct qm_aeqc), GFP_KERNEL);
+	if (!aeqc)
+		return -ENOMEM;
+	aeqc_dma = dma_map_single(dev, aeqc, sizeof(struct qm_aeqc),
+				  DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, aeqc_dma)) {
+		kfree(aeqc);
+		return -ENOMEM;
+	}
+
+	aeqc->base_l = lower_32_bits(qm->aeqe_dma);
+	aeqc->base_h = upper_32_bits(qm->aeqe_dma);
+	aeqc->dw6 = (QM_Q_DEPTH - 1) | (1 << QM_EQC_PHASE_SHIFT);
+
+	ret = qm_mb(qm, QM_MB_CMD_AEQC, aeqc_dma, 0, 0);
+	dma_unmap_single(dev, aeqc_dma, sizeof(struct qm_aeqc), DMA_TO_DEVICE);
+	kfree(aeqc);
+
+	return ret;
+}
+
+static int __hisi_qm_start(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+	struct device *dev = &pdev->dev;
+	size_t off = 0;
+	int ret;
+
+#define QM_INIT_BUF(qm, type, num) do { \
+	(qm)->type = ((qm)->qdma.va + (off)); \
+	(qm)->type##_dma = (qm)->qdma.dma + (off); \
+	off += QMC_ALIGN(sizeof(struct qm_##type) * (num)); \
+} while (0)
+
+	WARN_ON(!qm->qdma.dma);
+
+	if (qm->qp_num == 0)
+		return -EINVAL;
+
+	ret = qm_dev_mem_reset(qm);
+	if (ret)
+		return ret;
+
+	ret = hisi_qm_set_vft(qm, 0, qm->qp_base, qm->qp_num);
+	if (ret)
+		return ret;
+
+	QM_INIT_BUF(qm, eqe, QM_Q_DEPTH);
+	QM_INIT_BUF(qm, aeqe, QM_Q_DEPTH);
+	QM_INIT_BUF(qm, sqc, qm->qp_num);
+	QM_INIT_BUF(qm, cqc, qm->qp_num);
+
+	dev_dbg(dev, "init qm buffer:\n"
+		     " eqe	(%pK, %lx)\n"
+		     " aeqe	(%pK, %lx)\n"
+		     " sqc	(%pK, %lx)\n"
+		     " cqc	(%pK, %lx)\n",
+		     qm->eqe, (unsigned long)qm->eqe_dma,
+		     qm->aeqe, (unsigned long)qm->aeqe_dma,
+		     qm->sqc, (unsigned long)qm->sqc_dma,
+		     qm->cqc, (unsigned long)qm->cqc_dma);
+
+	ret = qm_eq_ctx_cfg(qm);
+	if (ret)
+		return ret;
+
+	ret = qm_mb(qm, QM_MB_CMD_SQC_BT, qm->sqc_dma, 0, 0);
+	if (ret)
+		return ret;
+
+	ret = qm_mb(qm, QM_MB_CMD_CQC_BT, qm->cqc_dma, 0, 0);
+	if (ret)
+		return ret;
+
+	writel(0x0, qm->io_base + QM_VF_EQ_INT_MASK);
+	writel(0x0, qm->io_base + QM_VF_AEQ_INT_MASK);
+
+	return 0;
+}
+
+/**
+ * hisi_qm_start() - start qm
+ * @qm: The qm to be started.
+ *
+ * This function starts a qm, then we can allocate qp from this qm.
+ */
+int hisi_qm_start(struct hisi_qm *qm)
+{
+	struct device *dev = &qm->pdev->dev;
+
+	dev_dbg(dev, "qm start with %d queue pairs\n", qm->qp_num);
+
+	if (!qm->qp_num) {
+		dev_err(dev, "qp_num should not be 0\n");
+		return -EINVAL;
+	}
+
+	if (!qm->qp_bitmap) {
+		qm->qp_bitmap = devm_kcalloc(dev, BITS_TO_LONGS(qm->qp_num),
+					     sizeof(long), GFP_KERNEL);
+		qm->qp_array = devm_kcalloc(dev, qm->qp_num,
+					    sizeof(struct hisi_qp *),
+					    GFP_KERNEL);
+		if (!qm->qp_bitmap || !qm->qp_array)
+			return -ENOMEM;
+	}
+
+	if (!qm->use_dma_api) {
+		dev_dbg(&qm->pdev->dev, "qm delay start\n");
+		return 0;
+	} else if (!qm->qdma.va) {
+		qm->qdma.size = QMC_ALIGN(sizeof(struct qm_eqe) * QM_Q_DEPTH) +
+				QMC_ALIGN(sizeof(struct qm_aeqe) * QM_Q_DEPTH) +
+				QMC_ALIGN(sizeof(struct qm_sqc) * qm->qp_num) +
+				QMC_ALIGN(sizeof(struct qm_cqc) * qm->qp_num);
+		qm->qdma.va = dma_alloc_coherent(dev, qm->qdma.size,
+						 &qm->qdma.dma, GFP_KERNEL);
+		dev_dbg(dev, "allocate qm dma buf(va=%pK, dma=%pad, size=%lx)\n",
+			qm->qdma.va, &qm->qdma.dma, qm->qdma.size);
+		if (!qm->qdma.va)
+			return -ENOMEM;
+	}
+
+	return __hisi_qm_start(qm);
+}
+EXPORT_SYMBOL_GPL(hisi_qm_start);
+
+/**
+ * hisi_qm_stop() - Stop a qm.
+ * @qm: The qm which will be stopped.
+ *
+ * This function stops qm and its qps, then qm can not accept request.
+ * Related resources are not released at this state, we can use hisi_qm_start
+ * to let qm start again.
+ */
+int hisi_qm_stop(struct hisi_qm *qm)
+{
+	struct device *dev;
+	struct hisi_qp *qp;
+	int ret = 0, i;
+
+	if (!qm || !qm->pdev) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	dev = &qm->pdev->dev;
+
+	/* Mask eq and aeq irq */
+	writel(0x1, qm->io_base + QM_VF_EQ_INT_MASK);
+	writel(0x1, qm->io_base + QM_VF_AEQ_INT_MASK);
+
+	/* Stop all qps belong to this qm */
+	for (i = 0; i < qm->qp_num; i++) {
+		qp = qm->qp_array[i];
+		if (qp) {
+			ret = hisi_qm_stop_qp(qp);
+			if (ret < 0) {
+				dev_err(dev, "Failed to stop qp%d!\n", i);
+				return -EBUSY;
+			}
+		}
+	}
+
+	ret = hisi_qm_set_vft(qm, 0, 0, 0);
+	if (ret < 0)
+		dev_err(dev, "Failed to set vft!\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hisi_qm_stop);
+
+/**
+ * hisi_qm_hw_error_init() - Configure qm hardware error report method.
+ * @qm: The qm which we want to configure.
+ * @ce: Bit mask of correctable error configure.
+ * @nfe: Bit mask of non-fatal error configure.
+ * @fe: Bit mask of fatal error configure.
+ * @msi: Bit mask of error reported by message signal interrupt.
+ *
+ * Hardware errors of qm can be reported either by RAS interrupts which will
+ * be handled by UEFI and then PCIe AER or by device MSI. User can configure
+ * each error to use either of above two methods. For RAS interrupts, we can
+ * configure an error as one of correctable error, non-fatal error or
+ * fatal error.
+ *
+ * Bits indicating errors can be configured to ce, nfe, fe and msi to enable
+ * related report methods. Error report will be masked if related error bit
+ * does not configure.
+ */
+void hisi_qm_hw_error_init(struct hisi_qm *qm, u32 ce, u32 nfe, u32 fe,
+			   u32 msi)
+{
+	if (!qm->ops->hw_error_init) {
+		dev_err(&qm->pdev->dev, "QM version %d doesn't support hw error handling!\n",
+			qm->ver);
+		return;
+	}
+
+	qm->ops->hw_error_init(qm, ce, nfe, fe, msi);
+}
+EXPORT_SYMBOL_GPL(hisi_qm_hw_error_init);
+
+/**
+ * hisi_qm_hw_error_handle() - Handle qm non-fatal hardware errors.
+ * @qm: The qm which has non-fatal hardware errors.
+ *
+ * Accelerators use this function to handle qm non-fatal hardware errors.
+ */
+int hisi_qm_hw_error_handle(struct hisi_qm *qm)
+{
+	if (!qm->ops->hw_error_handle) {
+		dev_err(&qm->pdev->dev, "QM version %d doesn't support hw error report!\n",
+			qm->ver);
+		return PCI_ERS_RESULT_NONE;
+	}
+
+	return qm->ops->hw_error_handle(qm);
+}
+EXPORT_SYMBOL_GPL(hisi_qm_hw_error_handle);
+
+/**
+ * hisi_qm_get_hw_version() - Get hardware version of a qm.
+ * @pdev: The device which hardware version we want to get.
+ *
+ * This function gets the hardware version of a qm. Return QM_HW_UNKNOWN
+ * if the hardware version is not supported.
+ */
+enum qm_hw_ver hisi_qm_get_hw_version(struct pci_dev *pdev)
+{
+	switch (pdev->revision) {
+	case QM_HW_V1:
+	case QM_HW_V2:
+		return pdev->revision;
+	default:
+		return QM_HW_UNKNOWN;
+	}
+}
+EXPORT_SYMBOL_GPL(hisi_qm_get_hw_version);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Zhou Wang <wangzhou1@hisilicon.com>");
+MODULE_DESCRIPTION("HiSilicon Accelerator queue manager driver");
diff --git a/drivers/crypto/hisilicon/qm.h b/drivers/crypto/hisilicon/qm.h
new file mode 100644
index 0000000..a5849db
--- /dev/null
+++ b/drivers/crypto/hisilicon/qm.h
@@ -0,0 +1,182 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2019 HiSilicon Limited. */
+#ifndef HISI_ACC_QM_H
+#define HISI_ACC_QM_H
+
+#include <linux/bitfield.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+/* qm user domain */
+#define QM_ARUSER_M_CFG_1		0x100088
+#define AXUSER_SNOOP_ENABLE		BIT(30)
+#define AXUSER_CMD_TYPE			GENMASK(14, 12)
+#define AXUSER_CMD_SMMU_NORMAL		1
+#define AXUSER_NS			BIT(6)
+#define AXUSER_NO			BIT(5)
+#define AXUSER_FP			BIT(4)
+#define AXUSER_SSV			BIT(0)
+#define AXUSER_BASE			(AXUSER_SNOOP_ENABLE |		\
+					FIELD_PREP(AXUSER_CMD_TYPE,	\
+					AXUSER_CMD_SMMU_NORMAL) |	\
+					AXUSER_NS | AXUSER_NO | AXUSER_FP)
+#define QM_ARUSER_M_CFG_ENABLE		0x100090
+#define ARUSER_M_CFG_ENABLE		0xfffffffe
+#define QM_AWUSER_M_CFG_1		0x100098
+#define QM_AWUSER_M_CFG_ENABLE		0x1000a0
+#define AWUSER_M_CFG_ENABLE		0xfffffffe
+#define QM_WUSER_M_CFG_ENABLE		0x1000a8
+#define WUSER_M_CFG_ENABLE		0xffffffff
+
+/* qm cache */
+#define QM_CACHE_CTL			0x100050
+#define SQC_CACHE_ENABLE		BIT(0)
+#define CQC_CACHE_ENABLE		BIT(1)
+#define SQC_CACHE_WB_ENABLE		BIT(4)
+#define SQC_CACHE_WB_THRD		GENMASK(10, 5)
+#define CQC_CACHE_WB_ENABLE		BIT(11)
+#define CQC_CACHE_WB_THRD		GENMASK(17, 12)
+#define QM_AXI_M_CFG			0x1000ac
+#define AXI_M_CFG			0xffff
+#define QM_AXI_M_CFG_ENABLE		0x1000b0
+#define AXI_M_CFG_ENABLE		0xffffffff
+#define QM_PEH_AXUSER_CFG		0x1000cc
+#define QM_PEH_AXUSER_CFG_ENABLE	0x1000d0
+#define PEH_AXUSER_CFG			0x401001
+#define PEH_AXUSER_CFG_ENABLE		0xffffffff
+
+
+#define QM_AXI_RRESP			BIT(0)
+#define QM_AXI_BRESP			BIT(1)
+#define QM_ECC_MBIT			BIT(2)
+#define QM_ECC_1BIT			BIT(3)
+#define QM_ACC_GET_TASK_TIMEOUT		BIT(4)
+#define QM_ACC_DO_TASK_TIMEOUT		BIT(5)
+#define QM_ACC_WB_NOT_READY_TIMEOUT	BIT(6)
+#define QM_SQ_CQ_VF_INVALID		BIT(7)
+#define QM_CQ_VF_INVALID		BIT(8)
+#define QM_SQ_VF_INVALID		BIT(9)
+#define QM_DB_TIMEOUT			BIT(10)
+#define QM_OF_FIFO_OF			BIT(11)
+#define QM_DB_RANDOM_INVALID		BIT(12)
+
+#define QM_BASE_NFE	(QM_AXI_RRESP | QM_AXI_BRESP | QM_ECC_MBIT | \
+			 QM_ACC_GET_TASK_TIMEOUT | QM_DB_TIMEOUT | \
+			 QM_OF_FIFO_OF)
+#define QM_BASE_CE			QM_ECC_1BIT
+
+#define QM_Q_DEPTH			1024
+
+enum qp_state {
+	QP_STOP,
+};
+
+enum qm_hw_ver {
+	QM_HW_UNKNOWN = -1,
+	QM_HW_V1 = 0x20,
+	QM_HW_V2 = 0x21,
+};
+
+enum qm_fun_type {
+	QM_HW_PF,
+};
+
+struct qm_dma {
+	void *va;
+	dma_addr_t dma;
+	size_t size;
+};
+
+struct hisi_qm_status {
+	u32 eq_head;
+	bool eqc_phase;
+	u32 aeq_head;
+	bool aeqc_phase;
+	unsigned long flags;
+};
+
+struct hisi_qm {
+	enum qm_hw_ver ver;
+	const char *dev_name;
+	struct pci_dev *pdev;
+	void __iomem *io_base;
+	u32 sqe_size;
+	u32 qp_base;
+	u32 qp_num;
+	u32 ctrl_qp_num;
+
+	struct qm_dma qdma;
+	struct qm_sqc *sqc;
+	struct qm_cqc *cqc;
+	struct qm_eqe *eqe;
+	struct qm_aeqe *aeqe;
+	dma_addr_t sqc_dma;
+	dma_addr_t cqc_dma;
+	dma_addr_t eqe_dma;
+	dma_addr_t aeqe_dma;
+
+	struct hisi_qm_status status;
+
+	rwlock_t qps_lock;
+	unsigned long *qp_bitmap;
+	struct hisi_qp **qp_array;
+
+	struct mutex mailbox_lock;
+
+	const struct hisi_qm_hw_ops *ops;
+
+	u32 error_mask;
+	u32 msi_mask;
+
+	bool use_dma_api;
+};
+
+struct hisi_qp_status {
+	atomic_t used;
+	u16 sq_tail;
+	u16 cq_head;
+	bool cqc_phase;
+	unsigned long flags;
+};
+
+struct hisi_qp_ops {
+	int (*fill_sqe)(void *sqe, void *q_parm, void *d_parm);
+};
+
+struct hisi_qp {
+	u32 qp_id;
+	u8 alg_type;
+	u8 req_type;
+
+	struct qm_dma qdma;
+	void *sqe;
+	struct qm_cqe *cqe;
+	dma_addr_t sqe_dma;
+	dma_addr_t cqe_dma;
+
+	struct hisi_qp_status qp_status;
+	struct hisi_qp_ops *hw_ops;
+	void *qp_ctx;
+	void (*req_cb)(struct hisi_qp *qp, void *data);
+	struct work_struct work;
+	struct workqueue_struct *wq;
+
+	struct hisi_qm *qm;
+};
+
+int hisi_qm_init(struct hisi_qm *qm);
+void hisi_qm_uninit(struct hisi_qm *qm);
+int hisi_qm_start(struct hisi_qm *qm);
+int hisi_qm_stop(struct hisi_qm *qm);
+struct hisi_qp *hisi_qm_create_qp(struct hisi_qm *qm, u8 alg_type);
+int hisi_qm_start_qp(struct hisi_qp *qp, unsigned long arg);
+int hisi_qm_stop_qp(struct hisi_qp *qp);
+void hisi_qm_release_qp(struct hisi_qp *qp);
+int hisi_qp_send(struct hisi_qp *qp, const void *msg);
+int hisi_qm_set_vft(struct hisi_qm *qm, u32 fun_num, u32 base, u32 number);
+void hisi_qm_hw_error_init(struct hisi_qm *qm, u32 ce, u32 nfe, u32 fe,
+			   u32 msi);
+int hisi_qm_hw_error_handle(struct hisi_qm *qm);
+enum qm_hw_ver hisi_qm_get_hw_version(struct pci_dev *pdev);
+#endif
-- 
2.8.1


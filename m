Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9512E19D1FC
	for <lists+linux-crypto@lfdr.de>; Fri,  3 Apr 2020 10:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390512AbgDCISG (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 3 Apr 2020 04:18:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36410 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390296AbgDCISG (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 3 Apr 2020 04:18:06 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DE5AEEDAE4D336CDC1B8;
        Fri,  3 Apr 2020 16:17:44 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 3 Apr 2020 16:17:37 +0800
From:   Shukun Tan <tanshukun1@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, Shukun Tan <tanshukun1@huawei.com>
Subject: [PATCH 1/5] crypto: hisilicon/qm - add controller reset interface
Date:   Fri, 3 Apr 2020 16:16:38 +0800
Message-ID: <1585901802-48945-2-git-send-email-tanshukun1@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585901802-48945-1-git-send-email-tanshukun1@huawei.com>
References: <1585901802-48945-1-git-send-email-tanshukun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add the main implementation of the controller reset interface, which is
roughly divided into three parts, stop, reset, and reinitialization.

Signed-off-by: Shukun Tan <tanshukun1@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 544 ++++++++++++++++++++++++++++++++++++++++++
 drivers/crypto/hisilicon/qm.h |  16 ++
 2 files changed, 560 insertions(+)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 7c2dedc..2a44ccb 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 HiSilicon Limited. */
 #include <asm/page.h>
+#include <linux/acpi.h>
+#include <linux/aer.h>
 #include <linux/bitmap.h>
 #include <linux/debugfs.h>
 #include <linux/dma-mapping.h>
@@ -122,9 +124,11 @@
 #define QM_DFX_CNT_CLR_CE		0x100118
 
 #define QM_ABNORMAL_INT_SOURCE		0x100000
+#define QM_ABNORMAL_INT_SOURCE_CLR	GENMASK(12, 0)
 #define QM_ABNORMAL_INT_MASK		0x100004
 #define QM_ABNORMAL_INT_MASK_VALUE	0x1fff
 #define QM_ABNORMAL_INT_STATUS		0x100008
+#define QM_ABNORMAL_INT_SET		0x10000c
 #define QM_ABNORMAL_INF00		0x100010
 #define QM_FIFO_OVERFLOW_TYPE		0xc0
 #define QM_FIFO_OVERFLOW_TYPE_SHIFT	6
@@ -140,6 +144,25 @@
 #define QM_RAS_CE_TIMES_PER_IRQ		1
 #define QM_RAS_MSI_INT_SEL		0x1040f4
 
+#define QM_DEV_RESET_FLAG		0
+#define QM_RESET_WAIT_TIMEOUT		400
+#define QM_PEH_VENDOR_ID		0x1000d8
+#define ACC_VENDOR_ID_VALUE		0x5a5a
+#define QM_PEH_DFX_INFO0		0x1000fc
+#define ACC_PEH_SRIOV_CTRL_VF_MSE_SHIFT	3
+#define ACC_PEH_MSI_DISABLE		GENMASK(31, 0)
+#define ACC_MASTER_GLOBAL_CTRL_SHUTDOWN	0x1
+#define ACC_MASTER_TRANS_RETURN_RW	3
+#define ACC_MASTER_TRANS_RETURN		0x300150
+#define ACC_MASTER_GLOBAL_CTRL		0x300000
+#define ACC_AM_CFG_PORT_WR_EN		0x30001c
+#define QM_RAS_NFE_MBIT_DISABLE		~QM_ECC_MBIT
+#define ACC_AM_ROB_ECC_INT_STS		0x300104
+#define ACC_ROB_ECC_ERR_MULTPL		BIT(1)
+
+#define POLL_PERIOD			10
+#define POLL_TIMEOUT			1000
+#define MAX_WAIT_COUNTS			1000
 #define QM_CACHE_WB_START		0x204
 #define QM_CACHE_WB_DONE		0x208
 
@@ -1012,10 +1035,18 @@ static void qm_hw_error_init_v2(struct hisi_qm *qm, u32 ce, u32 nfe, u32 fe,
 {
 	u32 irq_enable = ce | nfe | fe | msi;
 	u32 irq_unmask = ~irq_enable;
+	u32 error_status;
 
 	qm->error_mask = ce | nfe | fe;
 	qm->msi_mask = msi;
 
+	/* clear QM hw residual error source */
+	error_status = readl(qm->io_base + QM_ABNORMAL_INT_STATUS);
+	if (error_status) {
+		error_status &= qm->error_mask;
+		writel(error_status, qm->io_base + QM_ABNORMAL_INT_SOURCE);
+	}
+
 	/* configure error type */
 	writel(ce, qm->io_base + QM_RAS_CE_ENABLE);
 	writel(QM_RAS_CE_TIMES_PER_IRQ, qm->io_base + QM_RAS_CE_THRESHOLD);
@@ -1080,6 +1111,9 @@ static pci_ers_result_t qm_hw_error_handle_v2(struct hisi_qm *qm)
 	error_status = qm->error_mask & tmp;
 
 	if (error_status) {
+		if (error_status & QM_ECC_MBIT)
+			qm->err_status.is_qm_ecc_mbit = true;
+
 		qm_log_hw_error(qm, error_status);
 
 		/* clear err sts */
@@ -1971,6 +2005,52 @@ int hisi_qm_start(struct hisi_qm *qm)
 }
 EXPORT_SYMBOL_GPL(hisi_qm_start);
 
+static int qm_restart(struct hisi_qm *qm)
+{
+	struct device *dev = &qm->pdev->dev;
+	struct hisi_qp *qp;
+	int ret, i;
+
+	ret = hisi_qm_start(qm);
+	if (ret < 0)
+		return ret;
+
+	write_lock(&qm->qps_lock);
+	for (i = 0; i < qm->qp_num; i++) {
+		qp = qm->qp_array[i];
+		if (qp) {
+			ret = hisi_qm_start_qp(qp, 0);
+			if (ret < 0) {
+				dev_err(dev, "Failed to start qp%d!\n", i);
+
+				write_unlock(&qm->qps_lock);
+				return ret;
+			}
+		}
+	}
+	write_unlock(&qm->qps_lock);
+
+	return 0;
+}
+
+/**
+ * This function clears all queues memory in a qm. Reset of accelerator can
+ * use this to clear queues.
+ */
+static void qm_clear_queues(struct hisi_qm *qm)
+{
+	struct hisi_qp *qp;
+	int i;
+
+	for (i = 0; i < qm->qp_num; i++) {
+		qp = qm->qp_array[i];
+		if (qp)
+			memset(qp->qdma.va, 0, qp->qdma.size);
+	}
+
+	memset(qm->qdma.va, 0, qm->qdma.size);
+}
+
 /**
  * hisi_qm_stop() - Stop a qm.
  * @qm: The qm which will be stopped.
@@ -2014,6 +2094,8 @@ int hisi_qm_stop(struct hisi_qm *qm)
 			dev_err(dev, "Failed to set vft!\n");
 	}
 
+	qm_clear_queues(qm);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(hisi_qm_stop);
@@ -2431,6 +2513,9 @@ static pci_ers_result_t qm_dev_err_handle(struct hisi_qm *qm)
 	/* get device hardware error status */
 	err_sts = qm->err_ini->get_dev_hw_err_status(qm);
 	if (err_sts) {
+		if (err_sts & qm->err_ini->err_info.ecc_2bits_mask)
+			qm->err_status.is_dev_ecc_mbit = true;
+
 		if (!qm->err_ini->log_dev_hw_err) {
 			dev_err(&qm->pdev->dev, "Device doesn't support log hw error!\n");
 			return PCI_ERS_RESULT_NEED_RESET;
@@ -2481,6 +2566,465 @@ pci_ers_result_t hisi_qm_dev_err_detected(struct pci_dev *pdev,
 }
 EXPORT_SYMBOL_GPL(hisi_qm_dev_err_detected);
 
+static int qm_check_req_recv(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+	int ret;
+	u32 val;
+
+	writel(ACC_VENDOR_ID_VALUE, qm->io_base + QM_PEH_VENDOR_ID);
+	ret = readl_relaxed_poll_timeout(qm->io_base + QM_PEH_VENDOR_ID, val,
+					 (val == ACC_VENDOR_ID_VALUE),
+					 POLL_PERIOD, POLL_TIMEOUT);
+	if (ret) {
+		dev_err(&pdev->dev, "Fails to read QM reg!\n");
+		return ret;
+	}
+
+	writel(PCI_VENDOR_ID_HUAWEI, qm->io_base + QM_PEH_VENDOR_ID);
+	ret = readl_relaxed_poll_timeout(qm->io_base + QM_PEH_VENDOR_ID, val,
+					 (val == PCI_VENDOR_ID_HUAWEI),
+					 POLL_PERIOD, POLL_TIMEOUT);
+	if (ret)
+		dev_err(&pdev->dev, "Fails to read QM reg in the second time!\n");
+
+	return ret;
+}
+
+static int qm_set_pf_mse(struct hisi_qm *qm, bool set)
+{
+	struct pci_dev *pdev = qm->pdev;
+	u16 cmd;
+	int i;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	if (set)
+		cmd |= PCI_COMMAND_MEMORY;
+	else
+		cmd &= ~PCI_COMMAND_MEMORY;
+
+	pci_write_config_word(pdev, PCI_COMMAND, cmd);
+	for (i = 0; i < MAX_WAIT_COUNTS; i++) {
+		pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+		if (set == ((cmd & PCI_COMMAND_MEMORY) >> 1))
+			return 0;
+
+		udelay(1);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int qm_set_vf_mse(struct hisi_qm *qm, bool set)
+{
+	struct pci_dev *pdev = qm->pdev;
+	u16 sriov_ctrl;
+	int pos;
+	int i;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
+	pci_read_config_word(pdev, pos + PCI_SRIOV_CTRL, &sriov_ctrl);
+	if (set)
+		sriov_ctrl |= PCI_SRIOV_CTRL_MSE;
+	else
+		sriov_ctrl &= ~PCI_SRIOV_CTRL_MSE;
+	pci_write_config_word(pdev, pos + PCI_SRIOV_CTRL, sriov_ctrl);
+
+	for (i = 0; i < MAX_WAIT_COUNTS; i++) {
+		pci_read_config_word(pdev, pos + PCI_SRIOV_CTRL, &sriov_ctrl);
+		if (set == (sriov_ctrl & PCI_SRIOV_CTRL_MSE) >>
+		    ACC_PEH_SRIOV_CTRL_VF_MSE_SHIFT)
+			return 0;
+
+		udelay(1);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int qm_set_msi(struct hisi_qm *qm, bool set)
+{
+	struct pci_dev *pdev = qm->pdev;
+
+	if (set) {
+		pci_write_config_dword(pdev, pdev->msi_cap + PCI_MSI_MASK_64,
+				       0);
+	} else {
+		pci_write_config_dword(pdev, pdev->msi_cap + PCI_MSI_MASK_64,
+				       ACC_PEH_MSI_DISABLE);
+		if (qm->err_status.is_qm_ecc_mbit ||
+		    qm->err_status.is_dev_ecc_mbit)
+			return 0;
+
+		mdelay(1);
+		if (readl(qm->io_base + QM_PEH_DFX_INFO0))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int qm_vf_reset_prepare(struct hisi_qm *qm)
+{
+	struct hisi_qm_list *qm_list = qm->qm_list;
+	struct pci_dev *pdev = qm->pdev;
+	struct pci_dev *virtfn;
+	struct hisi_qm *vf_qm;
+	int ret = 0;
+
+	mutex_lock(&qm_list->lock);
+	list_for_each_entry(vf_qm, &qm_list->list, list) {
+		virtfn = vf_qm->pdev;
+		if (virtfn == pdev)
+			continue;
+
+		if (pci_physfn(virtfn) == pdev) {
+			ret = hisi_qm_stop(vf_qm);
+			if (ret)
+				goto stop_fail;
+		}
+	}
+
+stop_fail:
+	mutex_unlock(&qm_list->lock);
+	return ret;
+}
+
+static int qm_reset_prepare_ready(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+	struct hisi_qm *pf_qm = pci_get_drvdata(pci_physfn(pdev));
+	int delay = 0;
+
+	/* All reset requests need to be queued for processing */
+	while (test_and_set_bit(QM_DEV_RESET_FLAG, &pf_qm->reset_flag)) {
+		msleep(++delay);
+		if (delay > QM_RESET_WAIT_TIMEOUT)
+			return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int qm_controller_reset_prepare(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+	int ret;
+
+	ret = qm_reset_prepare_ready(qm);
+	if (ret) {
+		pci_err(pdev, "Controller reset not ready!\n");
+		return ret;
+	}
+
+	if (qm->vfs_num) {
+		ret = qm_vf_reset_prepare(qm);
+		if (ret) {
+			pci_err(pdev, "Fails to stop VFs!\n");
+			return ret;
+		}
+	}
+
+	ret = hisi_qm_stop(qm);
+	if (ret) {
+		pci_err(pdev, "Fails to stop QM!\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void qm_dev_ecc_mbit_handle(struct hisi_qm *qm)
+{
+	u32 nfe_enb = 0;
+
+	if (!qm->err_status.is_dev_ecc_mbit &&
+	    qm->err_status.is_qm_ecc_mbit &&
+	    qm->err_ini->close_axi_master_ooo) {
+
+		qm->err_ini->close_axi_master_ooo(qm);
+
+	} else if (qm->err_status.is_dev_ecc_mbit &&
+		   !qm->err_status.is_qm_ecc_mbit &&
+		   !qm->err_ini->close_axi_master_ooo) {
+
+		nfe_enb = readl(qm->io_base + QM_RAS_NFE_ENABLE);
+		writel(nfe_enb & QM_RAS_NFE_MBIT_DISABLE,
+		       qm->io_base + QM_RAS_NFE_ENABLE);
+		writel(QM_ECC_MBIT, qm->io_base + QM_ABNORMAL_INT_SET);
+	}
+}
+
+static int qm_soft_reset(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+	int ret;
+	u32 val;
+
+	/* Ensure all doorbells and mailboxes received by QM */
+	ret = qm_check_req_recv(qm);
+	if (ret)
+		return ret;
+
+	if (qm->vfs_num) {
+		ret = qm_set_vf_mse(qm, false);
+		if (ret) {
+			pci_err(pdev, "Fails to disable vf MSE bit.\n");
+			return ret;
+		}
+	}
+
+	ret = qm_set_msi(qm, false);
+	if (ret) {
+		pci_err(pdev, "Fails to disable PEH MSI bit.\n");
+		return ret;
+	}
+
+	qm_dev_ecc_mbit_handle(qm);
+
+	/* OOO register set and check */
+	writel(ACC_MASTER_GLOBAL_CTRL_SHUTDOWN,
+	       qm->io_base + ACC_MASTER_GLOBAL_CTRL);
+
+	/* If bus lock, reset chip */
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
+	if (ret) {
+		pci_err(pdev, "Fails to disable pf MSE bit.\n");
+		return ret;
+	}
+
+	/* The reset related sub-control registers are not in PCI BAR */
+	if (ACPI_HANDLE(&pdev->dev)) {
+		unsigned long long value = 0;
+		acpi_status s;
+
+		s = acpi_evaluate_integer(ACPI_HANDLE(&pdev->dev),
+					  qm->err_ini->err_info.acpi_rst,
+					  NULL, &value);
+		if (ACPI_FAILURE(s)) {
+			pci_err(pdev, "NO controller reset method!\n");
+			return -EIO;
+		}
+
+		if (value) {
+			pci_err(pdev, "Reset step %llu failed!\n", value);
+			return -EIO;
+		}
+	} else {
+		pci_err(pdev, "No reset method!\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int qm_vf_reset_done(struct hisi_qm *qm)
+{
+	struct hisi_qm_list *qm_list = qm->qm_list;
+	struct pci_dev *pdev = qm->pdev;
+	struct pci_dev *virtfn;
+	struct hisi_qm *vf_qm;
+	int ret = 0;
+
+	mutex_lock(&qm_list->lock);
+	list_for_each_entry(vf_qm, &qm_list->list, list) {
+		virtfn = vf_qm->pdev;
+		if (virtfn == pdev)
+			continue;
+
+		if (pci_physfn(virtfn) == pdev) {
+			ret = qm_restart(vf_qm);
+			if (ret)
+				goto restart_fail;
+		}
+	}
+
+restart_fail:
+	mutex_unlock(&qm_list->lock);
+	return ret;
+}
+
+static int qm_get_dev_err_status(struct hisi_qm *qm)
+{
+
+	return(qm->err_ini->get_dev_hw_err_status(qm) &
+	       qm->err_ini->err_info.ecc_2bits_mask);
+}
+
+static int qm_dev_hw_init(struct hisi_qm *qm)
+{
+	return qm->err_ini->hw_init(qm);
+}
+
+static void qm_restart_prepare(struct hisi_qm *qm)
+{
+	u32 value;
+
+	if (!qm->err_status.is_qm_ecc_mbit &&
+	    !qm->err_status.is_dev_ecc_mbit)
+		return;
+
+	/* temporarily close the OOO port used for PEH to write out MSI */
+	value = readl(qm->io_base + ACC_AM_CFG_PORT_WR_EN);
+	writel(value & ~qm->err_ini->err_info.msi_wr_port,
+	       qm->io_base + ACC_AM_CFG_PORT_WR_EN);
+
+	/* clear dev ecc 2bit error source if having */
+	value = qm_get_dev_err_status(qm);
+	if (value && qm->err_ini->clear_dev_hw_err_status)
+		qm->err_ini->clear_dev_hw_err_status(qm, value);
+
+	/* clear QM ecc mbit error source */
+	writel(QM_ECC_MBIT, qm->io_base + QM_ABNORMAL_INT_SOURCE);
+
+	/* clear AM Reorder Buffer ecc mbit source */
+	writel(ACC_ROB_ECC_ERR_MULTPL, qm->io_base + ACC_AM_ROB_ECC_INT_STS);
+
+	if (qm->err_ini->open_axi_master_ooo)
+		qm->err_ini->open_axi_master_ooo(qm);
+}
+
+static void qm_restart_done(struct hisi_qm *qm)
+{
+	u32 value;
+
+	if (!qm->err_status.is_qm_ecc_mbit &&
+	    !qm->err_status.is_dev_ecc_mbit)
+		return;
+
+	/* open the OOO port for PEH to write out MSI */
+	value = readl(qm->io_base + ACC_AM_CFG_PORT_WR_EN);
+	value |= qm->err_ini->err_info.msi_wr_port;
+	writel(value, qm->io_base + ACC_AM_CFG_PORT_WR_EN);
+
+	qm->err_status.is_qm_ecc_mbit = false;
+	qm->err_status.is_dev_ecc_mbit = false;
+}
+
+static int qm_controller_reset_done(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+	int ret;
+
+	ret = qm_set_msi(qm, true);
+	if (ret) {
+		pci_err(pdev, "Fails to enable PEH MSI bit!\n");
+		return ret;
+	}
+
+	ret = qm_set_pf_mse(qm, true);
+	if (ret) {
+		pci_err(pdev, "Fails to enable pf MSE bit!\n");
+		return ret;
+	}
+
+	if (qm->vfs_num) {
+		ret = qm_set_vf_mse(qm, true);
+		if (ret) {
+			pci_err(pdev, "Fails to enable vf MSE bit!\n");
+			return ret;
+		}
+	}
+
+	ret = qm_dev_hw_init(qm);
+	if (ret) {
+		pci_err(pdev, "Failed to init device\n");
+		return ret;
+	}
+
+	qm_restart_prepare(qm);
+
+	ret = qm_restart(qm);
+	if (ret) {
+		pci_err(pdev, "Failed to start QM!\n");
+		return ret;
+	}
+
+	if (qm->vfs_num) {
+		ret = qm_vf_q_assign(qm, qm->vfs_num);
+		if (ret) {
+			pci_err(pdev, "Failed to assign queue!\n");
+			return ret;
+		}
+	}
+
+	ret = qm_vf_reset_done(qm);
+	if (ret) {
+		pci_err(pdev, "Failed to start VFs!\n");
+		return -EPERM;
+	}
+
+	hisi_qm_dev_err_init(qm);
+	qm_restart_done(qm);
+
+	clear_bit(QM_DEV_RESET_FLAG, &qm->reset_flag);
+
+	return 0;
+}
+
+int qm_controller_reset(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+	int ret;
+
+	pci_info(pdev, "Controller resetting...\n");
+
+	ret = qm_controller_reset_prepare(qm);
+	if (ret)
+		return ret;
+
+	ret = qm_soft_reset(qm);
+	if (ret) {
+		pci_err(pdev, "Controller reset failed (%d)\n", ret);
+		return ret;
+	}
+
+	ret = qm_controller_reset_done(qm);
+	if (ret)
+		return ret;
+
+	pci_info(pdev, "Controller reset complete\n");
+
+	return 0;
+}
+
+/**
+ * hisi_qm_dev_slot_reset() - slot reset
+ * @pdev: the PCIe device
+ *
+ * This function offers QM relate PCIe device reset interface. Drivers which
+ * use QM can use this function as slot_reset in its struct pci_error_handlers.
+ */
+pci_ers_result_t hisi_qm_dev_slot_reset(struct pci_dev *pdev)
+{
+	struct hisi_qm *qm = pci_get_drvdata(pdev);
+	int ret;
+
+	if (pdev->is_virtfn)
+		return PCI_ERS_RESULT_RECOVERED;
+
+	pci_cleanup_aer_uncorrect_error_status(pdev);
+
+	/* reset pcie device controller */
+	ret = qm_controller_reset(qm);
+	if (ret) {
+		pci_err(pdev, "Controller reset failed (%d)\n", ret);
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+EXPORT_SYMBOL_GPL(hisi_qm_dev_slot_reset);
+
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Zhou Wang <wangzhou1@hisilicon.com>");
 MODULE_DESCRIPTION("HiSilicon Accelerator queue manager driver");
diff --git a/drivers/crypto/hisilicon/qm.h b/drivers/crypto/hisilicon/qm.h
index 1b5171b..9d17167 100644
--- a/drivers/crypto/hisilicon/qm.h
+++ b/drivers/crypto/hisilicon/qm.h
@@ -133,16 +133,28 @@ struct hisi_qm_status {
 struct hisi_qm;
 
 struct hisi_qm_err_info {
+	char *acpi_rst;
+	u32 msi_wr_port;
+	u32 ecc_2bits_mask;
 	u32 ce;
 	u32 nfe;
 	u32 fe;
 	u32 msi;
 };
 
+struct hisi_qm_err_status {
+	u32 is_qm_ecc_mbit;
+	u32 is_dev_ecc_mbit;
+};
+
 struct hisi_qm_err_ini {
+	int (*hw_init)(struct hisi_qm *qm);
 	void (*hw_err_enable)(struct hisi_qm *qm);
 	void (*hw_err_disable)(struct hisi_qm *qm);
 	u32 (*get_dev_hw_err_status)(struct hisi_qm *qm);
+	void (*clear_dev_hw_err_status)(struct hisi_qm *qm, u32 err_sts);
+	void (*open_axi_master_ooo)(struct hisi_qm *qm);
+	void (*close_axi_master_ooo)(struct hisi_qm *qm);
 	void (*log_dev_hw_err)(struct hisi_qm *qm, u32 err_sts);
 	struct hisi_qm_err_info err_info;
 };
@@ -165,6 +177,7 @@ struct hisi_qm {
 	u32 ctrl_qp_num;
 	u32 vfs_num;
 	struct list_head list;
+	struct hisi_qm_list *qm_list;
 
 	struct qm_dma qdma;
 	struct qm_sqc *sqc;
@@ -178,6 +191,8 @@ struct hisi_qm {
 
 	struct hisi_qm_status status;
 	const struct hisi_qm_err_ini *err_ini;
+	struct hisi_qm_err_status err_status;
+	unsigned long reset_flag;
 
 	rwlock_t qps_lock;
 	unsigned long *qp_bitmap;
@@ -298,6 +313,7 @@ void hisi_qm_dev_err_init(struct hisi_qm *qm);
 void hisi_qm_dev_err_uninit(struct hisi_qm *qm);
 pci_ers_result_t hisi_qm_dev_err_detected(struct pci_dev *pdev,
 					  pci_channel_state_t state);
+pci_ers_result_t hisi_qm_dev_slot_reset(struct pci_dev *pdev);
 
 struct hisi_acc_sgl_pool;
 struct hisi_acc_hw_sgl *hisi_acc_sg_buf_map_to_hw_sgl(struct device *dev,
-- 
2.7.4


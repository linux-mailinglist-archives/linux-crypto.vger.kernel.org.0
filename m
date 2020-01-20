Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A37BB14243F
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Jan 2020 08:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgATHaZ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 20 Jan 2020 02:30:25 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:43086 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726451AbgATHaY (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 20 Jan 2020 02:30:24 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C9C5D638743608204639;
        Mon, 20 Jan 2020 15:30:22 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Mon, 20 Jan 2020 15:30:12 +0800
From:   Shukun Tan <tanshukun1@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH 3/4] crypto: hisilicon: Unify error detect process into qm
Date:   Mon, 20 Jan 2020 15:30:08 +0800
Message-ID: <1579505409-3776-4-git-send-email-tanshukun1@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579505409-3776-1-git-send-email-tanshukun1@huawei.com>
References: <1579505409-3776-1-git-send-email-tanshukun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

In error detect process, a lot of duplicate code can put into qm. We add
two callback(get_dev_hw_err_status and log_dev_hw_err) into struct
hisi_qm_err_ini to handle device error detect, meanwhile the qm error
detect not changed.

Signed-off-by: Shukun Tan <tanshukun1@huawei.com>
Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c |  93 +++++++--------------
 drivers/crypto/hisilicon/qm.c             |  71 ++++++++++++++--
 drivers/crypto/hisilicon/qm.h             |   5 +-
 drivers/crypto/hisilicon/sec2/sec_main.c  | 127 ++++++++++------------------
 drivers/crypto/hisilicon/zip/zip_main.c   | 133 +++++++++++-------------------
 5 files changed, 185 insertions(+), 244 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 5bf274c..0ba4a92 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -709,14 +709,36 @@ static int hpre_qm_pre_init(struct hisi_qm *qm, struct pci_dev *pdev)
 	return 0;
 }
 
+static void hpre_log_hw_error(struct hisi_qm *qm, u32 err_sts)
+{
+	const struct hpre_hw_error *err = hpre_hw_errors;
+	struct device *dev = &qm->pdev->dev;
+
+	while (err->msg) {
+		if (err->int_msk & err_sts)
+			dev_warn(dev, "%s [error status=0x%x] found\n",
+				 err->msg, err->int_msk);
+		err++;
+	}
+
+	writel(err_sts, qm->io_base + HPRE_HAC_SOURCE_INT);
+}
+
+static u32 hpre_get_hw_err_status(struct hisi_qm *qm)
+{
+	return readl(qm->io_base + HPRE_HAC_INT_STATUS);
+}
+
 static const struct hisi_qm_err_ini hpre_err_ini = {
-	.hw_err_enable	= hpre_hw_error_enable,
-	.hw_err_disable	= hpre_hw_error_disable,
-	.err_info	= {
-		.ce		= QM_BASE_CE,
-		.nfe		= QM_BASE_NFE | QM_ACC_DO_TASK_TIMEOUT,
-		.fe		= 0,
-		.msi		= QM_DB_RANDOM_INVALID,
+	.hw_err_enable		= hpre_hw_error_enable,
+	.hw_err_disable		= hpre_hw_error_disable,
+	.get_dev_hw_err_status	= hpre_get_hw_err_status,
+	.log_dev_hw_err		= hpre_log_hw_error,
+	.err_info		= {
+		.ce			= QM_BASE_CE,
+		.nfe			= QM_BASE_NFE | QM_ACC_DO_TASK_TIMEOUT,
+		.fe			= 0,
+		.msi			= QM_DB_RANDOM_INVALID,
 	}
 };
 
@@ -926,64 +948,9 @@ static void hpre_remove(struct pci_dev *pdev)
 	hisi_qm_uninit(qm);
 }
 
-static void hpre_log_hw_error(struct hpre *hpre, u32 err_sts)
-{
-	const struct hpre_hw_error *err = hpre_hw_errors;
-	struct device *dev = &hpre->qm.pdev->dev;
-
-	while (err->msg) {
-		if (err->int_msk & err_sts)
-			dev_warn(dev, "%s [error status=0x%x] found\n",
-				 err->msg, err->int_msk);
-		err++;
-	}
-}
-
-static pci_ers_result_t hpre_hw_error_handle(struct hpre *hpre)
-{
-	u32 err_sts;
-
-	/* read err sts */
-	err_sts = readl(hpre->qm.io_base + HPRE_HAC_INT_STATUS);
-	if (err_sts) {
-		hpre_log_hw_error(hpre, err_sts);
-
-		/* clear error interrupts */
-		writel(err_sts, hpre->qm.io_base + HPRE_HAC_SOURCE_INT);
-		return PCI_ERS_RESULT_NEED_RESET;
-	}
-
-	return PCI_ERS_RESULT_RECOVERED;
-}
-
-static pci_ers_result_t hpre_process_hw_error(struct pci_dev *pdev)
-{
-	struct hpre *hpre = pci_get_drvdata(pdev);
-	pci_ers_result_t qm_ret, hpre_ret;
-
-	/* log qm error */
-	qm_ret = hisi_qm_hw_error_handle(&hpre->qm);
-
-	/* log hpre error */
-	hpre_ret = hpre_hw_error_handle(hpre);
-
-	return (qm_ret == PCI_ERS_RESULT_NEED_RESET ||
-		hpre_ret == PCI_ERS_RESULT_NEED_RESET) ?
-		PCI_ERS_RESULT_NEED_RESET : PCI_ERS_RESULT_RECOVERED;
-}
-
-static pci_ers_result_t hpre_error_detected(struct pci_dev *pdev,
-					    pci_channel_state_t state)
-{
-	pci_info(pdev, "PCI error detected, state(=%d)!!\n", state);
-	if (state == pci_channel_io_perm_failure)
-		return PCI_ERS_RESULT_DISCONNECT;
-
-	return hpre_process_hw_error(pdev);
-}
 
 static const struct pci_error_handlers hpre_err_handler = {
-	.error_detected		= hpre_error_detected,
+	.error_detected		= hisi_qm_dev_err_detected,
 };
 
 static struct pci_driver hpre_pci_driver = {
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index e1d08e8..2c0e22f 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -1886,13 +1886,7 @@ static void qm_hw_error_uninit(struct hisi_qm *qm)
 	qm->ops->hw_error_uninit(qm);
 }
 
-/**
- * hisi_qm_hw_error_handle() - Handle qm non-fatal hardware errors.
- * @qm: The qm which has non-fatal hardware errors.
- *
- * Accelerators use this function to handle qm non-fatal hardware errors.
- */
-pci_ers_result_t hisi_qm_hw_error_handle(struct hisi_qm *qm)
+static pci_ers_result_t qm_hw_error_handle(struct hisi_qm *qm)
 {
 	if (!qm->ops->hw_error_handle) {
 		dev_err(&qm->pdev->dev, "QM doesn't support hw error report!\n");
@@ -1901,7 +1895,6 @@ pci_ers_result_t hisi_qm_hw_error_handle(struct hisi_qm *qm)
 
 	return qm->ops->hw_error_handle(qm);
 }
-EXPORT_SYMBOL_GPL(hisi_qm_hw_error_handle);
 
 /**
  * hisi_qm_get_hw_version() - Get hardware version of a qm.
@@ -1964,6 +1957,68 @@ void hisi_qm_dev_err_uninit(struct hisi_qm *qm)
 }
 EXPORT_SYMBOL_GPL(hisi_qm_dev_err_uninit);
 
+static pci_ers_result_t qm_dev_err_handle(struct hisi_qm *qm)
+{
+	u32 err_sts;
+
+	if (!qm->err_ini->get_dev_hw_err_status) {
+		dev_err(&qm->pdev->dev, "Device doesn't support get hw error status!\n");
+		return PCI_ERS_RESULT_NONE;
+	}
+
+	/* get device hardware error status */
+	err_sts = qm->err_ini->get_dev_hw_err_status(qm);
+	if (err_sts) {
+		if (!qm->err_ini->log_dev_hw_err) {
+			dev_err(&qm->pdev->dev, "Device doesn't support log hw error!\n");
+			return PCI_ERS_RESULT_NEED_RESET;
+		}
+
+		qm->err_ini->log_dev_hw_err(qm, err_sts);
+		return PCI_ERS_RESULT_NEED_RESET;
+	}
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+static pci_ers_result_t qm_process_dev_error(struct pci_dev *pdev)
+{
+	struct hisi_qm *qm = pci_get_drvdata(pdev);
+	pci_ers_result_t qm_ret, dev_ret;
+
+	/* log qm error */
+	qm_ret = qm_hw_error_handle(qm);
+
+	/* log device error */
+	dev_ret = qm_dev_err_handle(qm);
+
+	return (qm_ret == PCI_ERS_RESULT_NEED_RESET ||
+		dev_ret == PCI_ERS_RESULT_NEED_RESET) ?
+		PCI_ERS_RESULT_NEED_RESET : PCI_ERS_RESULT_RECOVERED;
+}
+
+/**
+ * hisi_qm_dev_err_detected() - Get device and qm error status then log it.
+ * @pdev: The PCI device which need report error.
+ * @state: The connectivity between CPU and device.
+ *
+ * We register this function into PCIe AER handlers, It will report device or
+ * qm hardware error status when error occur.
+ */
+pci_ers_result_t hisi_qm_dev_err_detected(struct pci_dev *pdev,
+					  pci_channel_state_t state)
+{
+	if (pdev->is_virtfn)
+		return PCI_ERS_RESULT_NONE;
+
+	pci_info(pdev, "PCI error detected, state(=%d)!!\n", state);
+	if (state == pci_channel_io_perm_failure)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	return qm_process_dev_error(pdev);
+}
+EXPORT_SYMBOL_GPL(hisi_qm_dev_err_detected);
+
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Zhou Wang <wangzhou1@hisilicon.com>");
 MODULE_DESCRIPTION("HiSilicon Accelerator queue manager driver");
diff --git a/drivers/crypto/hisilicon/qm.h b/drivers/crypto/hisilicon/qm.h
index 325f6d5..cae26ea 100644
--- a/drivers/crypto/hisilicon/qm.h
+++ b/drivers/crypto/hisilicon/qm.h
@@ -137,6 +137,8 @@ struct hisi_qm_err_info {
 struct hisi_qm_err_ini {
 	void (*hw_err_enable)(struct hisi_qm *qm);
 	void (*hw_err_disable)(struct hisi_qm *qm);
+	u32 (*get_dev_hw_err_status)(struct hisi_qm *qm);
+	void (*log_dev_hw_err)(struct hisi_qm *qm, u32 err_sts);
 	struct hisi_qm_err_info err_info;
 };
 
@@ -227,11 +229,12 @@ int hisi_qm_get_free_qp_num(struct hisi_qm *qm);
 int hisi_qm_get_vft(struct hisi_qm *qm, u32 *base, u32 *number);
 int hisi_qm_set_vft(struct hisi_qm *qm, u32 fun_num, u32 base, u32 number);
 int hisi_qm_debug_init(struct hisi_qm *qm);
-pci_ers_result_t hisi_qm_hw_error_handle(struct hisi_qm *qm);
 enum qm_hw_ver hisi_qm_get_hw_version(struct pci_dev *pdev);
 void hisi_qm_debug_regs_clear(struct hisi_qm *qm);
 void hisi_qm_dev_err_init(struct hisi_qm *qm);
 void hisi_qm_dev_err_uninit(struct hisi_qm *qm);
+pci_ers_result_t hisi_qm_dev_err_detected(struct pci_dev *pdev,
+					  pci_channel_state_t state);
 
 struct hisi_acc_sgl_pool;
 struct hisi_acc_hw_sgl *hisi_acc_sg_buf_map_to_hw_sgl(struct device *dev,
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 3cb5fd3..3767fdb 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -672,15 +672,48 @@ static void sec_debugfs_exit(struct sec_dev *sec)
 	debugfs_remove_recursive(sec->qm.debug.debug_root);
 }
 
+static void sec_log_hw_error(struct hisi_qm *qm, u32 err_sts)
+{
+	const struct sec_hw_error *errs = sec_hw_errors;
+	struct device *dev = &qm->pdev->dev;
+	u32 err_val;
+
+	while (errs->msg) {
+		if (errs->int_msk & err_sts) {
+			dev_err(dev, "%s [error status=0x%x] found\n",
+				errs->msg, errs->int_msk);
+
+			if (SEC_CORE_INT_STATUS_M_ECC & errs->int_msk) {
+				err_val = readl(qm->io_base +
+						SEC_CORE_SRAM_ECC_ERR_INFO);
+				dev_err(dev, "multi ecc sram num=0x%x\n",
+					SEC_ECC_NUM(err_val));
+				dev_err(dev, "multi ecc sram addr=0x%x\n",
+					SEC_ECC_ADDR(err_val));
+			}
+		}
+		errs++;
+	}
+
+	writel(err_sts, qm->io_base + SEC_CORE_INT_SOURCE);
+}
+
+static u32 sec_get_hw_err_status(struct hisi_qm *qm)
+{
+	return readl(qm->io_base + SEC_CORE_INT_STATUS);
+}
+
 static const struct hisi_qm_err_ini sec_err_ini = {
-	.hw_err_enable	= sec_hw_error_enable,
-	.hw_err_disable	= sec_hw_error_disable,
-	.err_info	= {
-		.ce		= QM_BASE_CE,
-		.nfe		= QM_BASE_NFE | QM_ACC_DO_TASK_TIMEOUT |
-				  QM_ACC_WB_NOT_READY_TIMEOUT,
-		.fe		= 0,
-		.msi		= QM_DB_RANDOM_INVALID,
+	.hw_err_enable		= sec_hw_error_enable,
+	.hw_err_disable		= sec_hw_error_disable,
+	.get_dev_hw_err_status	= sec_get_hw_err_status,
+	.log_dev_hw_err		= sec_log_hw_error,
+	.err_info		= {
+		.ce			= QM_BASE_CE,
+		.nfe			= QM_BASE_NFE | QM_ACC_DO_TASK_TIMEOUT |
+					  QM_ACC_WB_NOT_READY_TIMEOUT,
+		.fe			= 0,
+		.msi			= QM_DB_RANDOM_INVALID,
 	}
 };
 
@@ -963,84 +996,8 @@ static void sec_remove(struct pci_dev *pdev)
 	sec_qm_uninit(qm);
 }
 
-static void sec_log_hw_error(struct sec_dev *sec, u32 err_sts)
-{
-	const struct sec_hw_error *errs = sec_hw_errors;
-	struct device *dev = &sec->qm.pdev->dev;
-	u32 err_val;
-
-	while (errs->msg) {
-		if (errs->int_msk & err_sts) {
-			dev_err(dev, "%s [error status=0x%x] found\n",
-				errs->msg, errs->int_msk);
-
-			if (SEC_CORE_INT_STATUS_M_ECC & err_sts) {
-				err_val = readl(sec->qm.io_base +
-						SEC_CORE_SRAM_ECC_ERR_INFO);
-				dev_err(dev, "multi ecc sram num=0x%x\n",
-					SEC_ECC_NUM(err_val));
-				dev_err(dev, "multi ecc sram addr=0x%x\n",
-					SEC_ECC_ADDR(err_val));
-			}
-		}
-		errs++;
-	}
-}
-
-static pci_ers_result_t sec_hw_error_handle(struct sec_dev *sec)
-{
-	u32 err_sts;
-
-	/* read err sts */
-	err_sts = readl(sec->qm.io_base + SEC_CORE_INT_STATUS);
-	if (err_sts) {
-		sec_log_hw_error(sec, err_sts);
-
-		/* clear error interrupts */
-		writel(err_sts, sec->qm.io_base + SEC_CORE_INT_SOURCE);
-
-		return PCI_ERS_RESULT_NEED_RESET;
-	}
-
-	return PCI_ERS_RESULT_RECOVERED;
-}
-
-static pci_ers_result_t sec_process_hw_error(struct pci_dev *pdev)
-{
-	struct sec_dev *sec = pci_get_drvdata(pdev);
-	pci_ers_result_t qm_ret, sec_ret;
-
-	if (!sec) {
-		pci_err(pdev, "Can't recover error during device init\n");
-		return PCI_ERS_RESULT_NONE;
-	}
-
-	/* log qm error */
-	qm_ret = hisi_qm_hw_error_handle(&sec->qm);
-
-	/* log sec error */
-	sec_ret = sec_hw_error_handle(sec);
-
-	return (qm_ret == PCI_ERS_RESULT_NEED_RESET ||
-		sec_ret == PCI_ERS_RESULT_NEED_RESET) ?
-		PCI_ERS_RESULT_NEED_RESET : PCI_ERS_RESULT_RECOVERED;
-}
-
-static pci_ers_result_t sec_error_detected(struct pci_dev *pdev,
-					   pci_channel_state_t state)
-{
-	if (pdev->is_virtfn)
-		return PCI_ERS_RESULT_NONE;
-
-	pci_info(pdev, "PCI error detected, state(=%d)!!\n", state);
-	if (state == pci_channel_io_perm_failure)
-		return PCI_ERS_RESULT_DISCONNECT;
-
-	return sec_process_hw_error(pdev);
-}
-
 static const struct pci_error_handlers sec_err_handler = {
-	.error_detected = sec_error_detected,
+	.error_detected = hisi_qm_dev_err_detected,
 };
 
 static struct pci_driver sec_pci_driver = {
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index ec2408e..f4aec18 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -68,8 +68,8 @@
 #define HZIP_CORE_INT_RAS_NFE_ENB	0x301164
 #define HZIP_CORE_INT_RAS_FE_ENB        0x301168
 #define HZIP_CORE_INT_RAS_NFE_ENABLE	0x7FE
-#define SRAM_ECC_ERR_NUM_SHIFT		16
-#define SRAM_ECC_ERR_ADDR_SHIFT		24
+#define HZIP_SRAM_ECC_ERR_NUM_SHIFT	16
+#define HZIP_SRAM_ECC_ERR_ADDR_SHIFT	24
 #define HZIP_CORE_INT_MASK_ALL		GENMASK(10, 0)
 #define HZIP_COMP_CORE_NUM		2
 #define HZIP_DECOMP_CORE_NUM		6
@@ -647,14 +647,50 @@ static void hisi_zip_debugfs_exit(struct hisi_zip *hisi_zip)
 		hisi_zip_debug_regs_clear(hisi_zip);
 }
 
+static void hisi_zip_log_hw_error(struct hisi_qm *qm, u32 err_sts)
+{
+	const struct hisi_zip_hw_error *err = zip_hw_error;
+	struct device *dev = &qm->pdev->dev;
+	u32 err_val;
+
+	while (err->msg) {
+		if (err->int_msk & err_sts) {
+			dev_err(dev, "%s [error status=0x%x] found\n",
+				 err->msg, err->int_msk);
+
+			if (err->int_msk & HZIP_CORE_INT_STATUS_M_ECC) {
+				err_val = readl(qm->io_base +
+						HZIP_CORE_SRAM_ECC_ERR_INFO);
+				dev_err(dev, "hisi-zip multi ecc sram num=0x%x\n",
+					((err_val >>
+					HZIP_SRAM_ECC_ERR_NUM_SHIFT) & 0xFF));
+				dev_err(dev, "hisi-zip multi ecc sram addr=0x%x\n",
+					(err_val >>
+					HZIP_SRAM_ECC_ERR_ADDR_SHIFT));
+			}
+		}
+		err++;
+	}
+
+	writel(err_sts, qm->io_base + HZIP_CORE_INT_SOURCE);
+}
+
+static u32 hisi_zip_get_hw_err_status(struct hisi_qm *qm)
+{
+	return readl(qm->io_base + HZIP_CORE_INT_STATUS);
+}
+
 static const struct hisi_qm_err_ini hisi_zip_err_ini = {
-	.hw_err_enable	= hisi_zip_hw_error_enable,
-	.hw_err_disable	= hisi_zip_hw_error_disable,
-	.err_info	= {
-		.ce		= QM_BASE_CE,
-		.nfe		= QM_BASE_NFE | QM_ACC_WB_NOT_READY_TIMEOUT,
-		.fe		= 0,
-		.msi		= QM_DB_RANDOM_INVALID,
+	.hw_err_enable		= hisi_zip_hw_error_enable,
+	.hw_err_disable		= hisi_zip_hw_error_disable,
+	.get_dev_hw_err_status	= hisi_zip_get_hw_err_status,
+	.log_dev_hw_err		= hisi_zip_log_hw_error,
+	.err_info		= {
+		.ce			= QM_BASE_CE,
+		.nfe			= QM_BASE_NFE |
+					  QM_ACC_WB_NOT_READY_TIMEOUT,
+		.fe			= 0,
+		.msi			= QM_DB_RANDOM_INVALID,
 	}
 };
 
@@ -906,85 +942,8 @@ static void hisi_zip_remove(struct pci_dev *pdev)
 	hisi_zip_remove_from_list(hisi_zip);
 }
 
-static void hisi_zip_log_hw_error(struct hisi_zip *hisi_zip, u32 err_sts)
-{
-	const struct hisi_zip_hw_error *err = zip_hw_error;
-	struct device *dev = &hisi_zip->qm.pdev->dev;
-	u32 err_val;
-
-	while (err->msg) {
-		if (err->int_msk & err_sts) {
-			dev_warn(dev, "%s [error status=0x%x] found\n",
-				 err->msg, err->int_msk);
-
-			if (HZIP_CORE_INT_STATUS_M_ECC & err->int_msk) {
-				err_val = readl(hisi_zip->qm.io_base +
-						HZIP_CORE_SRAM_ECC_ERR_INFO);
-				dev_warn(dev, "hisi-zip multi ecc sram num=0x%x\n",
-					 ((err_val >> SRAM_ECC_ERR_NUM_SHIFT) &
-					  0xFF));
-				dev_warn(dev, "hisi-zip multi ecc sram addr=0x%x\n",
-					 (err_val >> SRAM_ECC_ERR_ADDR_SHIFT));
-			}
-		}
-		err++;
-	}
-}
-
-static pci_ers_result_t hisi_zip_hw_error_handle(struct hisi_zip *hisi_zip)
-{
-	u32 err_sts;
-
-	/* read err sts */
-	err_sts = readl(hisi_zip->qm.io_base + HZIP_CORE_INT_STATUS);
-
-	if (err_sts) {
-		hisi_zip_log_hw_error(hisi_zip, err_sts);
-		/* clear error interrupts */
-		writel(err_sts, hisi_zip->qm.io_base + HZIP_CORE_INT_SOURCE);
-
-		return PCI_ERS_RESULT_NEED_RESET;
-	}
-
-	return PCI_ERS_RESULT_RECOVERED;
-}
-
-static pci_ers_result_t hisi_zip_process_hw_error(struct pci_dev *pdev)
-{
-	struct hisi_zip *hisi_zip = pci_get_drvdata(pdev);
-	struct device *dev = &pdev->dev;
-	pci_ers_result_t qm_ret, zip_ret;
-
-	if (!hisi_zip) {
-		dev_err(dev,
-			"Can't recover ZIP-error occurred during device init\n");
-		return PCI_ERS_RESULT_NONE;
-	}
-
-	qm_ret = hisi_qm_hw_error_handle(&hisi_zip->qm);
-
-	zip_ret = hisi_zip_hw_error_handle(hisi_zip);
-
-	return (qm_ret == PCI_ERS_RESULT_NEED_RESET ||
-		zip_ret == PCI_ERS_RESULT_NEED_RESET) ?
-	       PCI_ERS_RESULT_NEED_RESET : PCI_ERS_RESULT_RECOVERED;
-}
-
-static pci_ers_result_t hisi_zip_error_detected(struct pci_dev *pdev,
-						pci_channel_state_t state)
-{
-	if (pdev->is_virtfn)
-		return PCI_ERS_RESULT_NONE;
-
-	dev_info(&pdev->dev, "PCI error detected, state(=%d)!!\n", state);
-	if (state == pci_channel_io_perm_failure)
-		return PCI_ERS_RESULT_DISCONNECT;
-
-	return hisi_zip_process_hw_error(pdev);
-}
-
 static const struct pci_error_handlers hisi_zip_err_handler = {
-	.error_detected	= hisi_zip_error_detected,
+	.error_detected	= hisi_qm_dev_err_detected,
 };
 
 static struct pci_driver hisi_zip_pci_driver = {
-- 
2.7.4


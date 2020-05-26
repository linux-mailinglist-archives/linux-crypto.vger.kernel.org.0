Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DECC1CA4A6
	for <lists+linux-crypto@lfdr.de>; Fri,  8 May 2020 08:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgEHG7G (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 May 2020 02:59:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42654 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726771AbgEHG7F (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 8 May 2020 02:59:05 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 06A23AA4FB1D2D762366;
        Fri,  8 May 2020 14:59:00 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 14:58:53 +0800
From:   Shukun Tan <tanshukun1@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>
Subject: [PATCH 06/13] crypto: hisilicon - add FLR support
Date:   Fri, 8 May 2020 14:57:41 +0800
Message-ID: <1588921068-20739-7-git-send-email-tanshukun1@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588921068-20739-1-git-send-email-tanshukun1@huawei.com>
References: <1588921068-20739-1-git-send-email-tanshukun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add callback reset_prepare and reset_done in QM, The callback
reset_prepare will uninit device error configuration and stop
the QM, the callback reset_done will init the device error
configuration and restart the QM.

Uninit the error configuration will disable device block master OOO
when Multi-bit ECC error occurs to avoid the request of FLR will not
return.

Signed-off-by: Shukun Tan <tanshukun1@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c |  16 ++++
 drivers/crypto/hisilicon/qm.c             | 133 +++++++++++++++++++++++++++++-
 drivers/crypto/hisilicon/qm.h             |   2 +
 drivers/crypto/hisilicon/sec2/sec_main.c  |   2 +
 drivers/crypto/hisilicon/zip/zip_main.c   |  16 ++++
 5 files changed, 165 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index f1bb626..1948fd3 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -310,12 +310,21 @@ static void hpre_cnt_regs_clear(struct hisi_qm *qm)
 
 static void hpre_hw_error_disable(struct hisi_qm *qm)
 {
+	u32 val;
+
 	/* disable hpre hw error interrupts */
 	writel(HPRE_CORE_INT_DISABLE, qm->io_base + HPRE_INT_MASK);
+
+	/* disable HPRE block master OOO when m-bit error occur */
+	val = readl(qm->io_base + HPRE_AM_OOO_SHUTDOWN_ENB);
+	val &= ~HPRE_AM_OOO_SHUTDOWN_ENABLE;
+	writel(val, qm->io_base + HPRE_AM_OOO_SHUTDOWN_ENB);
 }
 
 static void hpre_hw_error_enable(struct hisi_qm *qm)
 {
+	u32 val;
+
 	/* clear HPRE hw error source if having */
 	writel(HPRE_CORE_INT_DISABLE, qm->io_base + HPRE_HAC_SOURCE_INT);
 
@@ -324,6 +333,11 @@ static void hpre_hw_error_enable(struct hisi_qm *qm)
 	writel(HPRE_HAC_RAS_CE_ENABLE, qm->io_base + HPRE_RAS_CE_ENB);
 	writel(HPRE_HAC_RAS_NFE_ENABLE, qm->io_base + HPRE_RAS_NFE_ENB);
 	writel(HPRE_HAC_RAS_FE_ENABLE, qm->io_base + HPRE_RAS_FE_ENB);
+
+	/* enable HPRE block master OOO when m-bit error occur */
+	val = readl(qm->io_base + HPRE_AM_OOO_SHUTDOWN_ENB);
+	val |= HPRE_AM_OOO_SHUTDOWN_ENABLE;
+	writel(val, qm->io_base + HPRE_AM_OOO_SHUTDOWN_ENB);
 }
 
 static inline struct hisi_qm *hpre_file_to_qm(struct hpre_debugfs_file *file)
@@ -851,6 +865,8 @@ static void hpre_remove(struct pci_dev *pdev)
 static const struct pci_error_handlers hpre_err_handler = {
 	.error_detected		= hisi_qm_dev_err_detected,
 	.slot_reset		= hisi_qm_dev_slot_reset,
+	.reset_prepare		= hisi_qm_reset_prepare,
+	.reset_done		= hisi_qm_reset_done,
 };
 
 static struct pci_driver hpre_pci_driver = {
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index e42097e..c30df08 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -175,6 +175,7 @@
 #define QMC_ALIGN(sz)			ALIGN(sz, 32)
 
 #define QM_DBG_TMP_BUF_LEN		22
+#define QM_PCI_COMMAND_INVALID		~0
 
 #define QM_MK_CQC_DW3_V1(hop_num, pg_sz, buf_sz, cqe_sz) \
 	(((hop_num) << QM_CQ_HOP_NUM_SHIFT)	| \
@@ -2874,6 +2875,11 @@ pci_ers_result_t hisi_qm_dev_err_detected(struct pci_dev *pdev,
 }
 EXPORT_SYMBOL_GPL(hisi_qm_dev_err_detected);
 
+static int qm_get_hw_error_status(struct hisi_qm *qm)
+{
+	return readl(qm->io_base + QM_ABNORMAL_INT_STATUS);
+}
+
 static int qm_check_req_recv(struct hisi_qm *qm)
 {
 	struct pci_dev *pdev = qm->pdev;
@@ -3166,9 +3172,7 @@ static int qm_vf_reset_done(struct hisi_qm *qm)
 
 static int qm_get_dev_err_status(struct hisi_qm *qm)
 {
-
-	return(qm->err_ini->get_dev_hw_err_status(qm) &
-	       qm->err_ini->err_info.ecc_2bits_mask);
+	return qm->err_ini->get_dev_hw_err_status(qm);
 }
 
 static int qm_dev_hw_init(struct hisi_qm *qm)
@@ -3190,7 +3194,8 @@ static void qm_restart_prepare(struct hisi_qm *qm)
 	       qm->io_base + ACC_AM_CFG_PORT_WR_EN);
 
 	/* clear dev ecc 2bit error source if having */
-	value = qm_get_dev_err_status(qm);
+	value = qm_get_dev_err_status(qm) &
+		qm->err_ini->err_info.ecc_2bits_mask;
 	if (value && qm->err_ini->clear_dev_hw_err_status)
 		qm->err_ini->clear_dev_hw_err_status(qm, value);
 
@@ -3336,6 +3341,126 @@ pci_ers_result_t hisi_qm_dev_slot_reset(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(hisi_qm_dev_slot_reset);
 
+/* check the interrupt is ecc-mbit error or not */
+static int qm_check_dev_error(struct hisi_qm *qm)
+{
+	int ret;
+
+	if (qm->fun_type == QM_HW_VF)
+		return 0;
+
+	ret = qm_get_hw_error_status(qm) & QM_ECC_MBIT;
+	if (ret)
+		return ret;
+
+	return (qm_get_dev_err_status(qm) &
+		qm->err_ini->err_info.ecc_2bits_mask);
+}
+
+void hisi_qm_reset_prepare(struct pci_dev *pdev)
+{
+	struct hisi_qm *pf_qm = pci_get_drvdata(pci_physfn(pdev));
+	struct hisi_qm *qm = pci_get_drvdata(pdev);
+	u32 delay = 0;
+	int ret;
+
+	hisi_qm_dev_err_uninit(pf_qm);
+
+	/*
+	 * Check whether there is an ECC mbit error, If it occurs, need to
+	 * wait for soft reset to fix it.
+	 */
+	while (qm_check_dev_error(pf_qm)) {
+		msleep(++delay);
+		if (delay > QM_RESET_WAIT_TIMEOUT)
+			return;
+	}
+
+	ret = qm_reset_prepare_ready(qm);
+	if (ret) {
+		pci_err(pdev, "FLR not ready!\n");
+		return;
+	}
+
+	if (qm->vfs_num) {
+		ret = qm_vf_reset_prepare(qm);
+		if (ret) {
+			pci_err(pdev, "Failed to prepare reset, ret = %d.\n",
+				ret);
+			return;
+		}
+	}
+
+	ret = hisi_qm_stop(qm);
+	if (ret) {
+		pci_err(pdev, "Failed to stop QM, ret = %d.\n", ret);
+		return;
+	}
+
+	pci_info(pdev, "FLR resetting...\n");
+}
+EXPORT_SYMBOL_GPL(hisi_qm_reset_prepare);
+
+static bool qm_flr_reset_complete(struct pci_dev *pdev)
+{
+	struct pci_dev *pf_pdev = pci_physfn(pdev);
+	struct hisi_qm *qm = pci_get_drvdata(pf_pdev);
+	u32 id;
+
+	pci_read_config_dword(qm->pdev, PCI_COMMAND, &id);
+	if (id == QM_PCI_COMMAND_INVALID) {
+		pci_err(pdev, "Device can not be used!\n");
+		return false;
+	}
+
+	clear_bit(QM_DEV_RESET_FLAG, &qm->reset_flag);
+
+	return true;
+}
+
+void hisi_qm_reset_done(struct pci_dev *pdev)
+{
+	struct hisi_qm *pf_qm = pci_get_drvdata(pci_physfn(pdev));
+	struct hisi_qm *qm = pci_get_drvdata(pdev);
+	int ret;
+
+	hisi_qm_dev_err_init(pf_qm);
+
+	ret = qm_restart(qm);
+	if (ret) {
+		pci_err(pdev, "Failed to start QM, ret = %d.\n", ret);
+		goto flr_done;
+	}
+
+	if (qm->fun_type == QM_HW_PF) {
+		ret = qm_dev_hw_init(qm);
+		if (ret) {
+			pci_err(pdev, "Failed to init PF, ret = %d.\n", ret);
+			goto flr_done;
+		}
+
+		if (!qm->vfs_num)
+			goto flr_done;
+
+		ret = qm_vf_q_assign(qm, qm->vfs_num);
+		if (ret) {
+			pci_err(pdev, "Failed to assign VFs, ret = %d.\n", ret);
+			goto flr_done;
+		}
+
+		ret = qm_vf_reset_done(qm);
+		if (ret) {
+			pci_err(pdev, "Failed to start VFs, ret = %d.\n", ret);
+			goto flr_done;
+		}
+	}
+
+flr_done:
+	if (qm_flr_reset_complete(pdev))
+		pci_info(pdev, "FLR reset complete\n");
+}
+EXPORT_SYMBOL_GPL(hisi_qm_reset_done);
+
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Zhou Wang <wangzhou1@hisilicon.com>");
 MODULE_DESCRIPTION("HiSilicon Accelerator queue manager driver");
diff --git a/drivers/crypto/hisilicon/qm.h b/drivers/crypto/hisilicon/qm.h
index eff156a..25934e3 100644
--- a/drivers/crypto/hisilicon/qm.h
+++ b/drivers/crypto/hisilicon/qm.h
@@ -371,6 +371,8 @@ void hisi_qm_dev_err_uninit(struct hisi_qm *qm);
 pci_ers_result_t hisi_qm_dev_err_detected(struct pci_dev *pdev,
 					  pci_channel_state_t state);
 pci_ers_result_t hisi_qm_dev_slot_reset(struct pci_dev *pdev);
+void hisi_qm_reset_prepare(struct pci_dev *pdev);
+void hisi_qm_reset_done(struct pci_dev *pdev);
 
 struct hisi_acc_sgl_pool;
 struct hisi_acc_hw_sgl *hisi_acc_sg_buf_map_to_hw_sgl(struct device *dev,
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 5aba775..437e8788 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -914,6 +914,8 @@ static void sec_remove(struct pci_dev *pdev)
 static const struct pci_error_handlers sec_err_handler = {
 	.error_detected = hisi_qm_dev_err_detected,
 	.slot_reset =  hisi_qm_dev_slot_reset,
+	.reset_prepare		= hisi_qm_reset_prepare,
+	.reset_done		= hisi_qm_reset_done,
 };
 
 static struct pci_driver sec_pci_driver = {
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 3c838e2..a7f0c6a 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -278,6 +278,8 @@ static int hisi_zip_set_user_domain_and_cache(struct hisi_qm *qm)
 
 static void hisi_zip_hw_error_enable(struct hisi_qm *qm)
 {
+	u32 val;
+
 	if (qm->ver == QM_HW_V1) {
 		writel(HZIP_CORE_INT_MASK_ALL,
 		       qm->io_base + HZIP_CORE_INT_MASK_REG);
@@ -296,12 +298,24 @@ static void hisi_zip_hw_error_enable(struct hisi_qm *qm)
 
 	/* enable ZIP hw error interrupts */
 	writel(0, qm->io_base + HZIP_CORE_INT_MASK_REG);
+
+	/* enable ZIP block master OOO when m-bit error occur */
+	val = readl(qm->io_base + HZIP_SOFT_CTRL_ZIP_CONTROL);
+	val = val | HZIP_AXI_SHUTDOWN_ENABLE;
+	writel(val, qm->io_base + HZIP_SOFT_CTRL_ZIP_CONTROL);
 }
 
 static void hisi_zip_hw_error_disable(struct hisi_qm *qm)
 {
+	u32 val;
+
 	/* disable ZIP hw error interrupts */
 	writel(HZIP_CORE_INT_MASK_ALL, qm->io_base + HZIP_CORE_INT_MASK_REG);
+
+	/* disable ZIP block master OOO when m-bit error occur */
+	val = readl(qm->io_base + HZIP_SOFT_CTRL_ZIP_CONTROL);
+	val = val & ~HZIP_AXI_SHUTDOWN_ENABLE;
+	writel(val, qm->io_base + HZIP_SOFT_CTRL_ZIP_CONTROL);
 }
 
 static inline struct hisi_qm *file_to_qm(struct ctrl_debug_file *file)
@@ -802,6 +816,8 @@ static void hisi_zip_remove(struct pci_dev *pdev)
 static const struct pci_error_handlers hisi_zip_err_handler = {
 	.error_detected	= hisi_qm_dev_err_detected,
 	.slot_reset	= hisi_qm_dev_slot_reset,
+	.reset_prepare	= hisi_qm_reset_prepare,
+	.reset_done	= hisi_qm_reset_done,
 };
 
 static struct pci_driver hisi_zip_pci_driver = {
-- 
2.7.4


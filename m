Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085E2779171
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Aug 2023 16:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjHKOKw (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 11 Aug 2023 10:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbjHKOKv (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 11 Aug 2023 10:10:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A6910E4
        for <linux-crypto@vger.kernel.org>; Fri, 11 Aug 2023 07:10:49 -0700 (PDT)
Received: from kwepemm600009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RMlwg1cH2zcd4L
        for <linux-crypto@vger.kernel.org>; Fri, 11 Aug 2023 22:07:15 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 22:10:46 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <shenyang39@huawei.com>,
        <liulongfang@huawei.com>, Weili Qian <qianweili@huawei.com>
Subject: [PATCH v2 3/7] crypto: hisilicon/qm - fix PF queue parameter issue
Date:   Fri, 11 Aug 2023 22:07:45 +0800
Message-ID: <20230811140749.5202-4-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230811140749.5202-1-qianweili@huawei.com>
References: <20230811140749.5202-1-qianweili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Longfang Liu <liulongfang@huawei.com>

If the queue isolation feature is enabled, the number of queues
supported by the device changes. When PF is enabled using the
current default number of queues, the default number of queues may
be greater than the number supported by the device. As a result,
the PF fails to be bound to the driver.

After modification, if queue isolation feature is enabled, when
the default queue parameter is greater than the number supported
by the device, the number of enabled queues will be changed to
the number supported by the device, so that the PF and driver
can be properly bound.

Fixes: 8bbecfb402f7 ("crypto: hisilicon/qm - add queue isolation support for Kunpeng930")
Signed-off-by: Longfang Liu <liulongfang@huawei.com>
Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c |  5 +++++
 drivers/crypto/hisilicon/qm.c             | 18 ++++++++++++------
 drivers/crypto/hisilicon/qm_common.h      |  1 -
 drivers/crypto/hisilicon/sec2/sec_main.c  |  5 +++++
 drivers/crypto/hisilicon/zip/zip_main.c   |  5 +++++
 include/linux/hisi_acc_qm.h               |  7 +++++++
 6 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 39297ce70f44..1709e649f0d1 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -433,8 +433,11 @@ static u32 uacce_mode = UACCE_MODE_NOUACCE;
 module_param_cb(uacce_mode, &hpre_uacce_mode_ops, &uacce_mode, 0444);
 MODULE_PARM_DESC(uacce_mode, UACCE_MODE_DESC);
 
+static bool pf_q_num_flag;
 static int pf_q_num_set(const char *val, const struct kernel_param *kp)
 {
+	pf_q_num_flag = true;
+
 	return q_num_set(val, kp, PCI_DEVICE_ID_HUAWEI_HPRE_PF);
 }
 
@@ -1157,6 +1160,8 @@ static int hpre_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		qm->qp_num = pf_q_num;
 		qm->debug.curr_qm_qp_num = pf_q_num;
 		qm->qm_list = &hpre_devices;
+		if (pf_q_num_flag)
+			set_bit(QM_MODULE_PARAM, &qm->misc_ctl);
 	}
 
 	ret = hisi_qm_init(qm);
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index d0b923dc5415..6623707363bb 100755
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -210,8 +210,6 @@
 #define WAIT_PERIOD			20
 #define REMOVE_WAIT_DELAY		10
 
-#define QM_DRIVER_REMOVING		0
-#define QM_RST_SCHED			1
 #define QM_QOS_PARAM_NUM		2
 #define QM_QOS_MAX_VAL			1000
 #define QM_QOS_RATE			100
@@ -2826,7 +2824,6 @@ static void hisi_qm_pre_init(struct hisi_qm *qm)
 	mutex_init(&qm->mailbox_lock);
 	init_rwsem(&qm->qps_lock);
 	qm->qp_in_used = 0;
-	qm->misc_ctl = false;
 	if (test_bit(QM_SUPPORT_RPM, &qm->caps)) {
 		if (!acpi_device_power_manageable(ACPI_COMPANION(&pdev->dev)))
 			dev_info(&pdev->dev, "_PS0 and _PR0 are not defined");
@@ -5068,6 +5065,7 @@ static int qm_irqs_register(struct hisi_qm *qm)
 
 static int qm_get_qp_num(struct hisi_qm *qm)
 {
+	struct device *dev = &qm->pdev->dev;
 	bool is_db_isolation;
 
 	/* VF's qp_num assigned by PF in v2, and VF can get qp_num by vft. */
@@ -5084,13 +5082,21 @@ static int qm_get_qp_num(struct hisi_qm *qm)
 	qm->max_qp_num = hisi_qm_get_hw_info(qm, qm_basic_info,
 					     QM_FUNC_MAX_QP_CAP, is_db_isolation);
 
-	/* check if qp number is valid */
-	if (qm->qp_num > qm->max_qp_num) {
-		dev_err(&qm->pdev->dev, "qp num(%u) is more than max qp num(%u)!\n",
+	if (qm->qp_num <= qm->max_qp_num)
+		return 0;
+
+	if (test_bit(QM_MODULE_PARAM, &qm->misc_ctl)) {
+		/* Check whether the set qp number is valid */
+		dev_err(dev, "qp num(%u) is more than max qp num(%u)!\n",
 			qm->qp_num, qm->max_qp_num);
 		return -EINVAL;
 	}
 
+	dev_info(dev, "Default qp num(%u) is too big, reset it to Function's max qp num(%u)!\n",
+		 qm->qp_num, qm->max_qp_num);
+	qm->qp_num = qm->max_qp_num;
+	qm->debug.curr_qm_qp_num = qm->qp_num;
+
 	return 0;
 }
 
diff --git a/drivers/crypto/hisilicon/qm_common.h b/drivers/crypto/hisilicon/qm_common.h
index db96c8bf9692..7b0b15c83ec1 100644
--- a/drivers/crypto/hisilicon/qm_common.h
+++ b/drivers/crypto/hisilicon/qm_common.h
@@ -4,7 +4,6 @@
 #define QM_COMMON_H
 
 #define QM_DBG_READ_LEN		256
-#define QM_RESETTING		2
 
 struct qm_cqe {
 	__le32 rsvd0;
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 77f9f131b850..62bd8936a915 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -311,8 +311,11 @@ static int sec_diff_regs_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(sec_diff_regs);
 
+static bool pf_q_num_flag;
 static int sec_pf_q_num_set(const char *val, const struct kernel_param *kp)
 {
+	pf_q_num_flag = true;
+
 	return q_num_set(val, kp, PCI_DEVICE_ID_HUAWEI_SEC_PF);
 }
 
@@ -1120,6 +1123,8 @@ static int sec_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		qm->qp_num = pf_q_num;
 		qm->debug.curr_qm_qp_num = pf_q_num;
 		qm->qm_list = &sec_devices;
+		if (pf_q_num_flag)
+			set_bit(QM_MODULE_PARAM, &qm->misc_ctl);
 	} else if (qm->fun_type == QM_HW_VF && qm->ver == QM_HW_V1) {
 		/*
 		 * have no way to get qm configure in VM in v1 hardware,
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index f3ce34198775..84dbaeb07ea8 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -364,8 +364,11 @@ static u32 uacce_mode = UACCE_MODE_NOUACCE;
 module_param_cb(uacce_mode, &zip_uacce_mode_ops, &uacce_mode, 0444);
 MODULE_PARM_DESC(uacce_mode, UACCE_MODE_DESC);
 
+static bool pf_q_num_flag;
 static int pf_q_num_set(const char *val, const struct kernel_param *kp)
 {
+	pf_q_num_flag = true;
+
 	return q_num_set(val, kp, PCI_DEVICE_ID_HUAWEI_ZIP_PF);
 }
 
@@ -1139,6 +1142,8 @@ static int hisi_zip_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		qm->qp_num = pf_q_num;
 		qm->debug.curr_qm_qp_num = pf_q_num;
 		qm->qm_list = &zip_devices;
+		if (pf_q_num_flag)
+			set_bit(QM_MODULE_PARAM, &qm->misc_ctl);
 	} else if (qm->fun_type == QM_HW_VF && qm->ver == QM_HW_V1) {
 		/*
 		 * have no way to get qm configure in VM in v1 hardware,
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 3f33d6d99999..576a0601c72e 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -143,6 +143,13 @@ enum qm_vf_state {
 	QM_NOT_READY,
 };
 
+enum qm_mist_ctl_bits {
+	QM_DRIVER_REMOVING = 0x0,
+	QM_RST_SCHED,
+	QM_RESETTING,
+	QM_MODULE_PARAM,
+};
+
 enum qm_cap_bits {
 	QM_SUPPORT_DB_ISOLATION = 0x0,
 	QM_SUPPORT_FUNC_QOS,
-- 
2.33.0


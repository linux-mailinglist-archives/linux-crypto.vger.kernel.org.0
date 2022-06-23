Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C165572F8
	for <lists+linux-crypto@lfdr.de>; Thu, 23 Jun 2022 08:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiFWGVb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 23 Jun 2022 02:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiFWGV3 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 23 Jun 2022 02:21:29 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D0331367;
        Wed, 22 Jun 2022 23:21:21 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LT99T5NRdzDsC8;
        Thu, 23 Jun 2022 14:20:45 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 14:21:19 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 23 Jun
 2022 14:21:19 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <gregkh@linuxfoundation.org>, <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>,
        <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>, <wangzhou1@hisilicon.com>,
        <yekai13@huawei.com>
Subject: [PATCH v4 3/3] crypto: hisilicon/qm - defining the device isolation strategy
Date:   Thu, 23 Jun 2022 14:14:52 +0800
Message-ID: <20220623061452.40732-4-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220623061452.40732-1-yekai13@huawei.com>
References: <20220623061452.40732-1-yekai13@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Define the device isolation strategy by the device driver. The
user configures a frequency value by uacce interface. If the
slot reset frequency exceeds the value of setting for a certain
period of time, the device will not be available in user space.
This frequency is an abstract number of times that can be
considered to occur in a time window. The time window can be set
to one hour or one day. The VF device use the PF device isolation
strategy. All the hardware errors are processed by PF driver.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 177 +++++++++++++++++++++++++++++++---
 include/linux/hisi_acc_qm.h   |   9 ++
 2 files changed, 174 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index ad83c194d664..f92cf20fc84e 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -417,6 +417,16 @@ struct hisi_qm_resource {
 	struct list_head list;
 };
 
+/**
+ * struct qm_hw_err - structure of describes the device err
+ * @list: hardware error list
+ * @timestamp: timestamp when the error occurred
+ */
+struct qm_hw_err {
+	struct list_head list;
+	unsigned long long timestamp;
+};
+
 struct hisi_qm_hw_ops {
 	int (*get_vft)(struct hisi_qm *qm, u32 *base, u32 *number);
 	void (*qm_db)(struct hisi_qm *qm, u16 qn,
@@ -3410,6 +3420,125 @@ static long hisi_qm_uacce_ioctl(struct uacce_queue *q, unsigned int cmd,
 	return 0;
 }
 
+/**
+ * qm_hw_err_isolate() - Try to isolate the uacce device with its VFs
+ * according to user's configuration of isolation strategy. Warning: this
+ * API should be called while there the users on this device are suspended
+ * by slot resetting preparation of PCI AER.
+ * @qm: the uacce device
+ */
+static int qm_hw_err_isolate(struct hisi_qm *qm)
+{
+	struct qm_hw_err *err, *tmp, *hw_err;
+	struct qm_err_isolate *isolate;
+	u32 count = 0;
+
+	isolate = &qm->isolate_data;
+
+#define SECONDS_PER_HOUR	3600
+
+	/* All the hw errs are processed by PF driver */
+	if (qm->uacce->is_vf || atomic_read(&isolate->is_isolate) ||
+	    !isolate->hw_err_isolate_hz)
+		return 0;
+
+	hw_err = kzalloc(sizeof(*hw_err), GFP_ATOMIC);
+	if (!hw_err)
+		return -ENOMEM;
+
+	mutex_lock(&isolate->isolate_lock);
+	hw_err->timestamp = jiffies;
+	list_for_each_entry_safe(err, tmp, &qm->uacce_hw_errs, list) {
+		if ((hw_err->timestamp - err->timestamp) / HZ >
+		    SECONDS_PER_HOUR) {
+			list_del(&err->list);
+			kfree(err);
+		} else {
+			count++;
+		}
+	}
+	list_add(&hw_err->list, &qm->uacce_hw_errs);
+	mutex_unlock(&isolate->isolate_lock);
+
+	if (count >= isolate->hw_err_isolate_hz)
+		atomic_set(&isolate->is_isolate, 1);
+
+	return 0;
+}
+
+static void qm_hw_err_destroy(struct hisi_qm *qm)
+{
+	struct qm_hw_err *err, *tmp;
+
+	mutex_lock(&qm->isolate_data.isolate_lock);
+	list_for_each_entry_safe(err, tmp, &qm->uacce_hw_errs, list) {
+		list_del(&err->list);
+		kfree(err);
+	}
+	mutex_unlock(&qm->isolate_data.isolate_lock);
+}
+
+static enum uacce_dev_state hisi_qm_get_isolate_state(struct uacce_device *uacce)
+{
+	struct hisi_qm *qm = uacce->priv;
+	struct hisi_qm *pf_qm;
+
+	if (uacce->is_vf)
+		pf_qm = pci_get_drvdata(pci_physfn(qm->pdev));
+	else
+		pf_qm = qm;
+
+	return atomic_read(&pf_qm->isolate_data.is_isolate) ?
+			UACCE_DEV_ISOLATE : UACCE_DEV_NORMAL;
+}
+
+static int hisi_qm_isolate_strategy_write(struct uacce_device *uacce,
+					  const char *buf, size_t len)
+{
+	struct hisi_qm *qm = uacce->priv;
+	unsigned long val;
+
+#define MAX_ISOLATE_STRATEGY	65535
+
+	/* Must be set by PF */
+	if (uacce->is_vf) {
+		dev_info(&qm->pdev->dev, "the isolation strategy must be set by PF.\n");
+		return -EINVAL;
+	}
+
+	if (atomic_read(&qm->isolate_data.is_isolate))
+		return -EINVAL;
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val > MAX_ISOLATE_STRATEGY)
+		return -EINVAL;
+
+	qm->isolate_data.hw_err_isolate_hz = val;
+
+	/* After the policy is updated, need to reset the hardware err list */
+	qm_hw_err_destroy(qm);
+
+	return 0;
+}
+
+static int hisi_qm_isolate_strategy_read(struct uacce_device *uacce, char *buf)
+{
+	struct hisi_qm *qm = uacce->priv;
+	struct hisi_qm *pf_qm;
+	unsigned long val;
+
+	if (uacce->is_vf) {
+		pf_qm = pci_get_drvdata(pci_physfn(qm->pdev));
+		val = pf_qm->isolate_data.hw_err_isolate_hz;
+	} else {
+		val = qm->isolate_data.hw_err_isolate_hz;
+	}
+
+	return sysfs_emit(buf, "%lu\n", val);
+}
+
 static const struct uacce_ops uacce_qm_ops = {
 	.get_available_instances = hisi_qm_get_available_instances,
 	.get_queue = hisi_qm_uacce_get_queue,
@@ -3419,8 +3548,22 @@ static const struct uacce_ops uacce_qm_ops = {
 	.mmap = hisi_qm_uacce_mmap,
 	.ioctl = hisi_qm_uacce_ioctl,
 	.is_q_updated = hisi_qm_is_q_updated,
+	.get_isolate_state = hisi_qm_get_isolate_state,
+	.isolate_strategy_write = hisi_qm_isolate_strategy_write,
+	.isolate_strategy_read = hisi_qm_isolate_strategy_read,
 };
 
+static void qm_remove_uacce(struct hisi_qm *qm)
+{
+	struct uacce_device *uacce = qm->uacce;
+
+	if (qm->use_sva) {
+		qm_hw_err_destroy(qm);
+		uacce_remove(uacce);
+		qm->uacce = NULL;
+	}
+}
+
 static int qm_alloc_uacce(struct hisi_qm *qm)
 {
 	struct pci_dev *pdev = qm->pdev;
@@ -3433,6 +3576,8 @@ static int qm_alloc_uacce(struct hisi_qm *qm)
 	};
 	int ret;
 
+	INIT_LIST_HEAD(&qm->uacce_hw_errs);
+	mutex_init(&qm->isolate_data.isolate_lock);
 	ret = strscpy(interface.name, dev_driver_string(&pdev->dev),
 		      sizeof(interface.name));
 	if (ret < 0)
@@ -3446,8 +3591,7 @@ static int qm_alloc_uacce(struct hisi_qm *qm)
 		qm->use_sva = true;
 	} else {
 		/* only consider sva case */
-		uacce_remove(uacce);
-		qm->uacce = NULL;
+		qm_remove_uacce(qm);
 		return -EINVAL;
 	}
 
@@ -5109,6 +5253,12 @@ static int qm_controller_reset_prepare(struct hisi_qm *qm)
 		return ret;
 	}
 
+	if (qm->use_sva) {
+		ret = qm_hw_err_isolate(qm);
+		if (ret)
+			pci_err(pdev, "failed to isolate hw err!\n");
+	}
+
 	ret = qm_wait_vf_prepare_finish(qm);
 	if (ret)
 		pci_err(pdev, "failed to stop by vfs in soft reset!\n");
@@ -5436,19 +5586,25 @@ static int qm_controller_reset(struct hisi_qm *qm)
 	ret = qm_soft_reset(qm);
 	if (ret) {
 		pci_err(pdev, "Controller reset failed (%d)\n", ret);
-		qm_reset_bit_clear(qm);
-		return ret;
+		goto err_reset;
 	}
 
 	ret = qm_controller_reset_done(qm);
-	if (ret) {
-		qm_reset_bit_clear(qm);
-		return ret;
-	}
+	if (ret)
+		goto err_reset;
 
 	pci_info(pdev, "Controller reset complete\n");
 
 	return 0;
+
+err_reset:
+	pci_err(pdev, "Controller reset failed (%d)\n", ret);
+	qm_reset_bit_clear(qm);
+
+	/* if resetting fails, isolate the device */
+	if (qm->use_sva && !qm->uacce->is_vf)
+		atomic_set(&qm->isolate_data.is_isolate, 1);
+	return ret;
 }
 
 /**
@@ -6246,10 +6402,7 @@ int hisi_qm_init(struct hisi_qm *qm)
 err_free_qm_memory:
 	hisi_qm_memory_uninit(qm);
 err_alloc_uacce:
-	if (qm->use_sva) {
-		uacce_remove(qm->uacce);
-		qm->uacce = NULL;
-	}
+	qm_remove_uacce(qm);
 err_irq_register:
 	qm_irq_unregister(qm);
 err_pci_init:
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 116e8bd68c99..44454150c205 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -271,6 +271,13 @@ struct hisi_qm_poll_data {
 	u16 *qp_finish_id;
 };
 
+struct qm_err_isolate {
+	struct mutex isolate_lock;
+	/* user cfg freq which triggers isolation */
+	u32 hw_err_isolate_hz;
+	atomic_t is_isolate;
+};
+
 struct hisi_qm {
 	enum qm_hw_ver ver;
 	enum qm_fun_type fun_type;
@@ -335,6 +342,8 @@ struct hisi_qm {
 	struct qm_shaper_factor *factor;
 	u32 mb_qos;
 	u32 type_rate;
+	struct list_head uacce_hw_errs;
+	struct qm_err_isolate isolate_data;
 };
 
 struct hisi_qp_status {
-- 
2.33.0


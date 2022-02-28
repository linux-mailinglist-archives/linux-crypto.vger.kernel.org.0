Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CCA4C6553
	for <lists+linux-crypto@lfdr.de>; Mon, 28 Feb 2022 10:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiB1JEq (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 28 Feb 2022 04:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbiB1JEN (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 28 Feb 2022 04:04:13 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AD342A3F;
        Mon, 28 Feb 2022 01:03:18 -0800 (PST)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K6ZD206Snz67ySD;
        Mon, 28 Feb 2022 17:03:14 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 10:03:15 +0100
Received: from A2006125610.china.huawei.com (10.47.94.1) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 09:03:08 +0000
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>
CC:     <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <cohuck@redhat.com>, <mgurtovoy@nvidia.com>, <yishaih@nvidia.com>,
        <linuxarm@huawei.com>, <liulongfang@huawei.com>,
        <prime.zeng@hisilicon.com>, <jonathan.cameron@huawei.com>,
        <wangzhou1@hisilicon.com>
Subject: [PATCH v6 10/10] hisi_acc_vfio_pci: Use its own PCI reset_done error handler
Date:   Mon, 28 Feb 2022 09:01:21 +0000
Message-ID: <20220228090121.1903-11-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220228090121.1903-1-shameerali.kolothum.thodi@huawei.com>
References: <20220228090121.1903-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.94.1]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Register private handler for pci_error_handlers.reset_done and update
state accordingly.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 56 ++++++++++++++++++-
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |  4 +-
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index ce57c230d1a0..cdd278d6be11 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -868,6 +868,26 @@ hisi_acc_vf_set_device_state(struct hisi_acc_vf_core_device *hisi_acc_vdev,
 	return ERR_PTR(-EINVAL);
 }
 
+/*
+ * This function is called in all state_mutex unlock cases to
+ * handle a 'deferred_reset' if exists.
+ */
+static void hisi_acc_vf_state_mutex_unlock(struct hisi_acc_vf_core_device *hisi_acc_vdev)
+{
+again:
+	spin_lock(&hisi_acc_vdev->reset_lock);
+	if (hisi_acc_vdev->deferred_reset) {
+		hisi_acc_vdev->deferred_reset = false;
+		spin_unlock(&hisi_acc_vdev->reset_lock);
+		hisi_acc_vdev->vf_qm_state = QM_NOT_READY;
+		hisi_acc_vdev->mig_state = VFIO_DEVICE_STATE_RUNNING;
+		hisi_acc_vf_disable_fds(hisi_acc_vdev);
+		goto again;
+	}
+	mutex_unlock(&hisi_acc_vdev->state_mutex);
+	spin_unlock(&hisi_acc_vdev->reset_lock);
+}
+
 static struct file *
 hisi_acc_vfio_pci_set_device_state(struct vfio_device *vdev,
 				   enum vfio_device_mig_state new_state)
@@ -898,7 +918,7 @@ hisi_acc_vfio_pci_set_device_state(struct vfio_device *vdev,
 			break;
 		}
 	}
-	mutex_unlock(&hisi_acc_vdev->state_mutex);
+	hisi_acc_vf_state_mutex_unlock(hisi_acc_vdev);
 	return res;
 }
 
@@ -911,10 +931,35 @@ hisi_acc_vfio_pci_get_device_state(struct vfio_device *vdev,
 
 	mutex_lock(&hisi_acc_vdev->state_mutex);
 	*curr_state = hisi_acc_vdev->mig_state;
-	mutex_unlock(&hisi_acc_vdev->state_mutex);
+	hisi_acc_vf_state_mutex_unlock(hisi_acc_vdev);
 	return 0;
 }
 
+static void hisi_acc_vf_pci_aer_reset_done(struct pci_dev *pdev)
+{
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = dev_get_drvdata(&pdev->dev);
+
+	if (hisi_acc_vdev->core_device.vdev.migration_flags !=
+				VFIO_MIGRATION_STOP_COPY)
+		return;
+
+	/*
+	 * As the higher VFIO layers are holding locks across reset and using
+	 * those same locks with the mm_lock we need to prevent ABBA deadlock
+	 * with the state_mutex and mm_lock.
+	 * In case the state_mutex was taken already we defer the cleanup work
+	 * to the unlock flow of the other running context.
+	 */
+	spin_lock(&hisi_acc_vdev->reset_lock);
+	hisi_acc_vdev->deferred_reset = true;
+	if (!mutex_trylock(&hisi_acc_vdev->state_mutex)) {
+		spin_unlock(&hisi_acc_vdev->reset_lock);
+		return;
+	}
+	spin_unlock(&hisi_acc_vdev->reset_lock);
+	hisi_acc_vf_state_mutex_unlock(hisi_acc_vdev);
+}
+
 static int hisi_acc_vf_qm_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
 {
 	struct vfio_pci_core_device *vdev = &hisi_acc_vdev->core_device;
@@ -1257,12 +1302,17 @@ static const struct pci_device_id hisi_acc_vfio_pci_table[] = {
 
 MODULE_DEVICE_TABLE(pci, hisi_acc_vfio_pci_table);
 
+static const struct pci_error_handlers hisi_acc_vf_err_handlers = {
+	.reset_done = hisi_acc_vf_pci_aer_reset_done,
+	.error_detected = vfio_pci_core_aer_err_detected,
+};
+
 static struct pci_driver hisi_acc_vfio_pci_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = hisi_acc_vfio_pci_table,
 	.probe = hisi_acc_vfio_pci_probe,
 	.remove = hisi_acc_vfio_pci_remove,
-	.err_handler = &vfio_pci_core_err_handlers,
+	.err_handler = &hisi_acc_vf_err_handlers,
 };
 
 module_pci_driver(hisi_acc_vfio_pci_driver);
diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
index 51bc7e92a776..6c18f7c74f34 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
@@ -96,6 +96,7 @@ struct hisi_acc_vf_migration_file {
 struct hisi_acc_vf_core_device {
 	struct vfio_pci_core_device core_device;
 	u8 match_done:1;
+	u8 deferred_reset:1;
 	/* for migration state */
 	struct mutex state_mutex;
 	enum vfio_device_mig_state mig_state;
@@ -105,7 +106,8 @@ struct hisi_acc_vf_core_device {
 	struct hisi_qm vf_qm;
 	u32 vf_qm_state;
 	int vf_id;
-
+	/* for reset handler */
+	spinlock_t reset_lock;
 	struct hisi_acc_vf_migration_file resuming_migf;
 	struct hisi_acc_vf_migration_file saving_migf;
 };
-- 
2.25.1


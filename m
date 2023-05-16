Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728AD7059CF
	for <lists+linux-crypto@lfdr.de>; Tue, 16 May 2023 23:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjEPVuR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 16 May 2023 17:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjEPVuR (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 16 May 2023 17:50:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70805FEB;
        Tue, 16 May 2023 14:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684273815; x=1715809815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SyKW6JrZfMcvLfkyFZ3M9bz5hNTG2QzGOEc1iHyFTGw=;
  b=n5iWD/BHsRhRjWU5Sr1m3RD8twlBJIRDiOZdCKtL0jmqQJkrm4wh8GE3
   sOslF+2xlZDnpZnv7j9FWmUnoCXDAtJ28J7G8WPmx5ferBmIXqoJ1N4TY
   wVnsLEc5II7XUicpwPG2g9rqLSBQyYtOVQXlr+Cq0lAvy/8NARFaBlQ4y
   4+eUDXLTkq+GpL0BOUvi8WPjh7wbFoE3AKeNRAYKkcyrdc+PXSeZ8w6TW
   zvtog7jxFwT0/3iX2frFN71aHXx4VDhTG75pL3otOwplEE9XLABMoe8Y/
   YH8gbe+1uFneWvwOsSyv2f/pKhxzUC+2hyT/kjF6jtv0zASeCI1Njhney
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="331961630"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="331961630"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 14:50:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="704564752"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="704564752"
Received: from fmunozug-mobl1.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.83.116])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 14:50:14 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, giovanni.cabiddu@intel.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: [PATCH v5 01/15] dmaengine: idxd: add wq driver name support for accel-config user tool
Date:   Tue, 16 May 2023 16:49:55 -0500
Message-Id: <20230516215009.51794-2-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516215009.51794-1-tom.zanussi@linux.intel.com>
References: <20230516215009.51794-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

With the possibility of multiple wq drivers that can be bound to the wq,
the user config tool accel-config needs a way to know which wq driver to
bind to the wq. Introduce per wq driver_name sysfs attribute where the user
can indicate the driver to be bound to the wq. This allows accel-config to
just bind to the driver using wq->driver_name.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 .../ABI/stable/sysfs-driver-dma-idxd          |  6 ++++
 drivers/dma/idxd/cdev.c                       |  7 +++++
 drivers/dma/idxd/dma.c                        |  6 ++++
 drivers/dma/idxd/idxd.h                       |  9 ++++++
 drivers/dma/idxd/sysfs.c                      | 28 +++++++++++++++++++
 include/uapi/linux/idxd.h                     |  1 +
 6 files changed, 57 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index 534b7a3d59fc..6e45e5bfce58 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -270,6 +270,12 @@ Description:	Shows the operation capability bits displayed in bitmap format
 		correlates to the operations allowed. It's visible only
 		on platforms that support the capability.
 
+What:		/sys/bus/dsa/devices/wq<m>.<n>/driver_name
+Date:		Mar 27, 2023
+KernelVersion:	6.5.0
+Contact:	dmaengine@vger.kernel.org
+Description:	Name of driver to be bounded to the wq.
+
 What:           /sys/bus/dsa/devices/engine<m>.<n>/group_id
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index ecbf67c2ad2b..b1ecfb71d95e 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -510,6 +510,7 @@ void idxd_wq_del_cdev(struct idxd_wq *wq)
 
 static int idxd_user_drv_probe(struct idxd_dev *idxd_dev)
 {
+	struct device *dev = &idxd_dev->conf_dev;
 	struct idxd_wq *wq = idxd_dev_to_wq(idxd_dev);
 	struct idxd_device *idxd = wq->idxd;
 	int rc;
@@ -537,6 +538,12 @@ static int idxd_user_drv_probe(struct idxd_dev *idxd_dev)
 
 	mutex_lock(&wq->wq_lock);
 
+	if (!idxd_wq_driver_name_match(wq, dev)) {
+		idxd->cmd_status = IDXD_SCMD_WQ_NO_DRV_NAME;
+		rc = -ENODEV;
+		goto wq_err;
+	}
+
 	wq->wq = create_workqueue(dev_name(wq_confdev(wq)));
 	if (!wq->wq) {
 		rc = -ENOMEM;
diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index eb35ca313684..8bb7e7ff8d6a 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -305,6 +305,12 @@ static int idxd_dmaengine_drv_probe(struct idxd_dev *idxd_dev)
 		return -ENXIO;
 
 	mutex_lock(&wq->wq_lock);
+	if (!idxd_wq_driver_name_match(wq, dev)) {
+		idxd->cmd_status = IDXD_SCMD_WQ_NO_DRV_NAME;
+		rc = -ENODEV;
+		goto err;
+	}
+
 	wq->type = IDXD_WQT_KERNEL;
 
 	rc = drv_enable_wq(wq);
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 5428a2e1b1ec..c62c78e1c9fa 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -159,6 +159,8 @@ struct idxd_cdev {
 	int minor;
 };
 
+#define DRIVER_NAME_SIZE		128
+
 #define IDXD_ALLOCATED_BATCH_SIZE	128U
 #define WQ_NAME_SIZE   1024
 #define WQ_TYPE_SIZE   10
@@ -227,6 +229,8 @@ struct idxd_wq {
 	/* Lock to protect upasid_xa access. */
 	struct mutex uc_lock;
 	struct xarray upasid_xa;
+
+	char driver_name[DRIVER_NAME_SIZE + 1];
 };
 
 struct idxd_engine {
@@ -637,6 +641,11 @@ static inline void idxd_wqcfg_set_max_batch_shift(int idxd_type, union wqcfg *wq
 		wqcfg->max_batch_shift = max_batch_shift;
 }
 
+static inline int idxd_wq_driver_name_match(struct idxd_wq *wq, struct device *dev)
+{
+	return (strncmp(wq->driver_name, dev->driver->name, strlen(dev->driver->name)) == 0);
+}
+
 int __must_check __idxd_driver_register(struct idxd_device_driver *idxd_drv,
 					struct module *module, const char *mod_name);
 #define idxd_driver_register(driver) \
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 293739ac5596..6caad044f506 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1266,6 +1266,33 @@ static ssize_t wq_op_config_store(struct device *dev, struct device_attribute *a
 static struct device_attribute dev_attr_wq_op_config =
 		__ATTR(op_config, 0644, wq_op_config_show, wq_op_config_store);
 
+static ssize_t wq_driver_name_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct idxd_wq *wq = confdev_to_wq(dev);
+
+	return sysfs_emit(buf, "%s\n", wq->driver_name);
+}
+
+static ssize_t wq_driver_name_store(struct device *dev, struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct idxd_wq *wq = confdev_to_wq(dev);
+
+	if (wq->state != IDXD_WQ_DISABLED)
+		return -EPERM;
+
+	if (strlen(buf) > DRIVER_NAME_SIZE || strlen(buf) == 0)
+		return -EINVAL;
+
+	memset(wq->driver_name, 0, DRIVER_NAME_SIZE + 1);
+	strncpy(wq->driver_name, buf, DRIVER_NAME_SIZE);
+	strreplace(wq->name, '\n', '\0');
+	return count;
+}
+
+static struct device_attribute dev_attr_wq_driver_name =
+		__ATTR(driver_name, 0644, wq_driver_name_show, wq_driver_name_store);
+
 static struct attribute *idxd_wq_attributes[] = {
 	&dev_attr_wq_clients.attr,
 	&dev_attr_wq_state.attr,
@@ -1285,6 +1312,7 @@ static struct attribute *idxd_wq_attributes[] = {
 	&dev_attr_wq_occupancy.attr,
 	&dev_attr_wq_enqcmds_retries.attr,
 	&dev_attr_wq_op_config.attr,
+	&dev_attr_wq_driver_name.attr,
 	NULL,
 };
 
diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
index 606b52e88ce3..3d1987e1bb2d 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -31,6 +31,7 @@ enum idxd_scmd_stat {
 	IDXD_SCMD_WQ_IRQ_ERR = 0x80100000,
 	IDXD_SCMD_WQ_USER_NO_IOMMU = 0x80110000,
 	IDXD_SCMD_DEV_EVL_ERR = 0x80120000,
+	IDXD_SCMD_WQ_NO_DRV_NAME = 0x80200000,
 };
 
 #define IDXD_SCMD_SOFTERR_MASK	0x80000000
-- 
2.34.1


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A831D736D35
	for <lists+linux-crypto@lfdr.de>; Tue, 20 Jun 2023 15:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjFTNXn (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 20 Jun 2023 09:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbjFTNX1 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 20 Jun 2023 09:23:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B721991
        for <linux-crypto@vger.kernel.org>; Tue, 20 Jun 2023 06:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687267367; x=1718803367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+tBs9uwMBchzwy0HvCj35xEnDC58+0yfz9UCQGzTB60=;
  b=Pcm8gVjLAiD4iS65idBePxlevkJ4fw2UVk274ES0aaBP49GhFGgZcIia
   5OO7mZdtsqfMWRSQ9RlMQldISau8+1M3DM1oUMYuljcLW69WLwz+5xMSG
   r7qqxfPtYdI+nMPiSf8Py1Y2pmLQ5v7r38yZi/k0+N+/K8MaNu9xJSEv1
   sg5na3a2Ppw9re0LR3zYnQ7hoPNorWPEqrXkkVrp4BPj2Rk4sx0LyKJHI
   GRLY7/gm9Hm1oJyBYYcJHc2PWi8jDy0EmLLjgHAiaNfwdb31R5S06iubK
   2fZXorrhhwHyEBQx1iItcv1BkVSJb9f9U5UmkmJV1+nK6HNgNCeHRlamX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="446229741"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="446229741"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 06:22:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="743785411"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="743785411"
Received: from r031s002_zp31l10c01.gv.intel.com (HELO localhost.localdomain) ([10.219.171.29])
  by orsmga008.jf.intel.com with ESMTP; 20 Jun 2023 06:22:15 -0700
From:   Damian Muszynski <damian.muszynski@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Damian Muszynski <damian.muszynski@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/5] crypto: qat - add internal timer for qat 4xxx
Date:   Tue, 20 Jun 2023 15:08:19 +0200
Message-Id: <20230620130823.27004-2-damian.muszynski@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620130823.27004-1-damian.muszynski@intel.com>
References: <20230620130823.27004-1-damian.muszynski@intel.com>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The power management feature in QAT 4xxx devices can disable clock
sources used to implement timers. Because of that, the firmware needs to
get an external reliable source of time.

Add a kernel delayed work that periodically sends an event to the
firmware. This is triggered every 200ms. At each execution, the driver
sends a sync request to the firmware reporting the current timestamp
counter value.

This is a pre-requisite for enabling the heartbeat, telemetry and
rate limiting features.

Signed-off-by: Damian Muszynski <damian.muszynski@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     |  3 +
 drivers/crypto/intel/qat/qat_common/Makefile  |  1 +
 .../intel/qat/qat_common/adf_accel_devices.h  |  3 +
 .../crypto/intel/qat/qat_common/adf_admin.c   | 12 ++++
 .../intel/qat/qat_common/adf_common_drv.h     |  3 +
 .../intel/qat/qat_common/adf_gen4_timer.c     | 70 +++++++++++++++++++
 .../intel/qat/qat_common/adf_gen4_timer.h     | 21 ++++++
 .../crypto/intel/qat/qat_common/adf_init.c    | 13 ++++
 drivers/crypto/intel/qat/qat_common/adf_isr.c |  6 ++
 .../qat/qat_common/icp_qat_fw_init_admin.h    |  5 ++
 10 files changed, 137 insertions(+)
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen4_timer.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen4_timer.h

diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
index e543a9e24a06..831d460bc503 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -8,6 +8,7 @@
 #include <adf_gen4_hw_data.h>
 #include <adf_gen4_pfvf.h>
 #include <adf_gen4_pm.h>
+#include <adf_gen4_timer.h>
 #include "adf_4xxx_hw_data.h"
 #include "icp_qat_hw.h"
 
@@ -508,6 +509,8 @@ void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data, u32 dev_id)
 	hw_data->enable_pm = adf_gen4_enable_pm;
 	hw_data->handle_pm_interrupt = adf_gen4_handle_pm_interrupt;
 	hw_data->dev_config = adf_gen4_dev_config;
+	hw_data->start_timer = adf_gen4_timer_start;
+	hw_data->stop_timer = adf_gen4_timer_stop;
 
 	adf_gen4_init_hw_csr_ops(&hw_data->csr_ops);
 	adf_gen4_init_pf_pfvf_ops(&hw_data->pfvf_ops);
diff --git a/drivers/crypto/intel/qat/qat_common/Makefile b/drivers/crypto/intel/qat/qat_common/Makefile
index f541046cdf9a..6a82ef8df733 100644
--- a/drivers/crypto/intel/qat/qat_common/Makefile
+++ b/drivers/crypto/intel/qat/qat_common/Makefile
@@ -17,6 +17,7 @@ intel_qat-objs := adf_cfg.o \
 	adf_gen4_pm.o \
 	adf_gen2_dc.o \
 	adf_gen4_dc.o \
+	adf_gen4_timer.o \
 	qat_crypto.o \
 	qat_compression.o \
 	qat_comp_algs.o \
diff --git a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
index a54a994b5e27..2198b410b029 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
@@ -188,6 +188,8 @@ struct adf_hw_device_data {
 	int (*init_admin_comms)(struct adf_accel_dev *accel_dev);
 	void (*exit_admin_comms)(struct adf_accel_dev *accel_dev);
 	int (*send_admin_init)(struct adf_accel_dev *accel_dev);
+	int (*start_timer)(struct adf_accel_dev *accel_dev);
+	void (*stop_timer)(struct adf_accel_dev *accel_dev);
 	int (*init_arb)(struct adf_accel_dev *accel_dev);
 	void (*exit_arb)(struct adf_accel_dev *accel_dev);
 	const u32 *(*get_arb_mapping)(struct adf_accel_dev *accel_dev);
@@ -296,6 +298,7 @@ struct adf_accel_dev {
 	struct list_head list;
 	struct module *owner;
 	struct adf_accel_pci accel_pci_dev;
+	struct adf_timer *timer;
 	union {
 		struct {
 			/* protects VF2PF interrupts access */
diff --git a/drivers/crypto/intel/qat/qat_common/adf_admin.c b/drivers/crypto/intel/qat/qat_common/adf_admin.c
index 4716b82d48ec..d6cb7f50bb5a 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_admin.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_admin.c
@@ -241,6 +241,18 @@ int adf_get_ae_fw_counters(struct adf_accel_dev *accel_dev, u16 ae, u64 *reqs, u
 	return 0;
 }
 
+int adf_send_admin_tim_sync(struct adf_accel_dev *accel_dev, u32 cnt)
+{
+	u32 ae_mask = accel_dev->hw_device->ae_mask;
+	struct icp_qat_fw_init_admin_req req = { };
+	struct icp_qat_fw_init_admin_resp resp = { };
+
+	req.cmd_id = ICP_QAT_FW_SYNC;
+	req.int_timer_ticks = cnt;
+
+	return adf_send_admin(accel_dev, &req, &resp, ae_mask);
+}
+
 /**
  * adf_send_admin_init() - Function sends init message to FW
  * @accel_dev: Pointer to acceleration device.
diff --git a/drivers/crypto/intel/qat/qat_common/adf_common_drv.h b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
index 4682be073c99..e0d472071354 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
@@ -96,6 +96,7 @@ void adf_exit_admin_comms(struct adf_accel_dev *accel_dev);
 int adf_send_admin_init(struct adf_accel_dev *accel_dev);
 int adf_get_ae_fw_counters(struct adf_accel_dev *accel_dev, u16 ae, u64 *reqs, u64 *resps);
 int adf_init_admin_pm(struct adf_accel_dev *accel_dev, u32 idle_delay);
+int adf_send_admin_tim_sync(struct adf_accel_dev *accel_dev, u32 cnt);
 int adf_init_arb(struct adf_accel_dev *accel_dev);
 void adf_exit_arb(struct adf_accel_dev *accel_dev);
 void adf_update_ring_arb(struct adf_etr_ring_data *ring);
@@ -194,6 +195,8 @@ int qat_uclo_set_cfg_ae_mask(struct icp_qat_fw_loader_handle *handle,
 int adf_init_misc_wq(void);
 void adf_exit_misc_wq(void);
 bool adf_misc_wq_queue_work(struct work_struct *work);
+bool adf_misc_wq_queue_delayed_work(struct delayed_work *work,
+				    unsigned long delay);
 #if defined(CONFIG_PCI_IOV)
 int adf_sriov_configure(struct pci_dev *pdev, int numvfs);
 void adf_disable_sriov(struct adf_accel_dev *accel_dev);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_timer.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_timer.c
new file mode 100644
index 000000000000..646c57922fcd
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_timer.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation */
+
+#include <linux/container_of.h>
+#include <linux/dev_printk.h>
+#include <linux/export.h>
+#include <linux/jiffies.h>
+#include <linux/ktime.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+
+#include "adf_accel_devices.h"
+#include "adf_common_drv.h"
+#include "adf_gen4_timer.h"
+
+#define ADF_GEN4_TIMER_PERIOD_MS 200
+
+/* This periodic update is used to trigger HB, RL & TL fw events */
+static void work_handler(struct work_struct *work)
+{
+	struct adf_accel_dev *accel_dev;
+	struct adf_timer *timer_ctx;
+	u32 time_periods;
+
+	timer_ctx = container_of(to_delayed_work(work), struct adf_timer, work_ctx);
+	accel_dev = timer_ctx->accel_dev;
+
+	adf_misc_wq_queue_delayed_work(&timer_ctx->work_ctx,
+				       msecs_to_jiffies(ADF_GEN4_TIMER_PERIOD_MS));
+
+	time_periods = div_u64(ktime_ms_delta(ktime_get_real(), timer_ctx->initial_ktime),
+			       ADF_GEN4_TIMER_PERIOD_MS);
+
+	if (adf_send_admin_tim_sync(accel_dev, time_periods))
+		dev_err(&GET_DEV(accel_dev), "Failed to synchronize qat timer\n");
+}
+
+int adf_gen4_timer_start(struct adf_accel_dev *accel_dev)
+{
+	struct adf_timer *timer_ctx;
+
+	timer_ctx = kzalloc(sizeof(*timer_ctx), GFP_KERNEL);
+	if (!timer_ctx)
+		return -ENOMEM;
+
+	timer_ctx->accel_dev = accel_dev;
+	accel_dev->timer = timer_ctx;
+	timer_ctx->initial_ktime = ktime_get_real();
+
+	INIT_DELAYED_WORK(&timer_ctx->work_ctx, work_handler);
+	adf_misc_wq_queue_delayed_work(&timer_ctx->work_ctx,
+				       msecs_to_jiffies(ADF_GEN4_TIMER_PERIOD_MS));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(adf_gen4_timer_start);
+
+void adf_gen4_timer_stop(struct adf_accel_dev *accel_dev)
+{
+	struct adf_timer *timer_ctx = accel_dev->timer;
+
+	if (!timer_ctx)
+		return;
+
+	cancel_delayed_work_sync(&timer_ctx->work_ctx);
+
+	kfree(timer_ctx);
+	accel_dev->timer = NULL;
+}
+EXPORT_SYMBOL_GPL(adf_gen4_timer_stop);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_timer.h b/drivers/crypto/intel/qat/qat_common/adf_gen4_timer.h
new file mode 100644
index 000000000000..66a709e7b358
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_timer.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2023 Intel Corporation */
+
+#ifndef ADF_GEN4_TIMER_H_
+#define ADF_GEN4_TIMER_H_
+
+#include <linux/ktime.h>
+#include <linux/workqueue.h>
+
+struct adf_accel_dev;
+
+struct adf_timer {
+	struct adf_accel_dev *accel_dev;
+	struct delayed_work work_ctx;
+	ktime_t initial_ktime;
+};
+
+int adf_gen4_timer_start(struct adf_accel_dev *accel_dev);
+void adf_gen4_timer_stop(struct adf_accel_dev *accel_dev);
+
+#endif /* ADF_GEN4_TIMER_H_ */
diff --git a/drivers/crypto/intel/qat/qat_common/adf_init.c b/drivers/crypto/intel/qat/qat_common/adf_init.c
index 826179c98524..0acba0f988da 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_init.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_init.c
@@ -163,6 +163,7 @@ static int adf_dev_start(struct adf_accel_dev *accel_dev)
 	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
 	struct service_hndl *service;
 	struct list_head *list_itr;
+	int ret;
 
 	set_bit(ADF_STATUS_STARTING, &accel_dev->status);
 
@@ -187,6 +188,14 @@ static int adf_dev_start(struct adf_accel_dev *accel_dev)
 		return -EFAULT;
 	}
 
+	if (hw_data->start_timer) {
+		ret = hw_data->start_timer(accel_dev);
+		if (ret) {
+			dev_err(&GET_DEV(accel_dev), "Failed to start internal sync timer\n");
+			return ret;
+		}
+	}
+
 	list_for_each(list_itr, &service_table) {
 		service = list_entry(list_itr, struct service_hndl, list);
 		if (service->event_hld(accel_dev, ADF_EVENT_START)) {
@@ -235,6 +244,7 @@ static int adf_dev_start(struct adf_accel_dev *accel_dev)
  */
 static void adf_dev_stop(struct adf_accel_dev *accel_dev)
 {
+	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
 	struct service_hndl *service;
 	struct list_head *list_itr;
 	bool wait = false;
@@ -270,6 +280,9 @@ static void adf_dev_stop(struct adf_accel_dev *accel_dev)
 		}
 	}
 
+	if (hw_data->stop_timer)
+		hw_data->stop_timer(accel_dev);
+
 	if (wait)
 		msleep(100);
 
diff --git a/drivers/crypto/intel/qat/qat_common/adf_isr.c b/drivers/crypto/intel/qat/qat_common/adf_isr.c
index ad9e135b8560..2aba194a7c29 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_isr.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_isr.c
@@ -380,3 +380,9 @@ bool adf_misc_wq_queue_work(struct work_struct *work)
 {
 	return queue_work(adf_misc_wq, work);
 }
+
+bool adf_misc_wq_queue_delayed_work(struct delayed_work *work,
+				    unsigned long delay)
+{
+	return queue_delayed_work(adf_misc_wq, work, delay);
+}
diff --git a/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h b/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h
index 56cb827f93ea..d853c9242acf 100644
--- a/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h
+++ b/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h
@@ -37,6 +37,9 @@ struct icp_qat_fw_init_admin_req {
 			__u16 ibuf_size_in_kb;
 			__u16 resrvd3;
 		};
+		struct {
+			__u32 int_timer_ticks;
+		};
 		__u32 idle_filter;
 	};
 
@@ -97,6 +100,8 @@ struct icp_qat_fw_init_admin_resp {
 	};
 } __packed;
 
+#define ICP_QAT_FW_SYNC ICP_QAT_FW_HEARTBEAT_SYNC
+
 #define ICP_QAT_FW_COMN_HEARTBEAT_OK 0
 #define ICP_QAT_FW_COMN_HEARTBEAT_BLOCKED 1
 #define ICP_QAT_FW_COMN_HEARTBEAT_FLAG_BITPOS 0
-- 
2.40.1


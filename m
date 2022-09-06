Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243F25ADE13
	for <lists+linux-crypto@lfdr.de>; Tue,  6 Sep 2022 05:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiIFDgD (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 5 Sep 2022 23:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbiIFDgB (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 5 Sep 2022 23:36:01 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EE258B43;
        Mon,  5 Sep 2022 20:36:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VOavPaE_1662435357;
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0VOavPaE_1662435357)
          by smtp.aliyun-inc.com;
          Tue, 06 Sep 2022 11:35:58 +0800
From:   'Guanjun' <guanjun@linux.alibaba.com>
To:     herbert@gondor.apana.org.au, elliott@hpe.com
Cc:     zelin.deng@linux.alibaba.com, guanjun@linux.alibaba.com,
        xuchun.shang@linux.alibaba.com, artie.ding@linux.alibaba.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v1 3/9] crypto/ycc: Add irq support for ycc kernel rings
Date:   Tue,  6 Sep 2022 11:35:47 +0800
Message-Id: <1662435353-114812-4-git-send-email-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1662435353-114812-1-git-send-email-guanjun@linux.alibaba.com>
References: <1662435353-114812-1-git-send-email-guanjun@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Zelin Deng <zelin.deng@linux.alibaba.com>

Each kernel ring has its own command done irq. Temporarily user rings
will not enable irq.

Signed-off-by: Zelin Deng <zelin.deng@linux.alibaba.com>
---
 drivers/crypto/ycc/ycc_isr.c | 92 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 80 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/ycc/ycc_isr.c b/drivers/crypto/ycc/ycc_isr.c
index cd2a2d7..a86c8d7 100644
--- a/drivers/crypto/ycc/ycc_isr.c
+++ b/drivers/crypto/ycc/ycc_isr.c
@@ -12,6 +12,17 @@
 #include <linux/interrupt.h>
 
 #include "ycc_isr.h"
+#include "ycc_dev.h"
+#include "ycc_ring.h"
+
+
+static irqreturn_t ycc_resp_isr(int irq, void *data)
+{
+	struct ycc_ring *ring = (struct ycc_ring *)data;
+
+	tasklet_hi_schedule(&ring->resp_handler);
+	return IRQ_HANDLED;
+}
 
 /*
  * TODO: will implement when ycc ring actually work.
@@ -38,11 +49,13 @@ static irqreturn_t ycc_g_err_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-/*
- * TODO: will implement when ycc ring actually work.
- */
 void ycc_resp_process(uintptr_t ring_addr)
 {
+	struct ycc_ring *ring = (struct ycc_ring *)ring_addr;
+
+	ycc_dequeue(ring);
+	if (ring->ydev->is_polling)
+		tasklet_hi_schedule(&ring->resp_handler);
 }
 
 int ycc_enable_msix(struct ycc_dev *ydev)
@@ -83,34 +96,89 @@ static void ycc_cleanup_global_err_workqueue(struct ycc_dev *ydev)
 		destroy_workqueue(ydev->dev_err_q);
 }
 
-/*
- * TODO: Just request irq for global err. Irq for each ring
- * will be requested when ring actually work.
- */
 int ycc_alloc_irqs(struct ycc_dev *ydev)
 {
 	struct pci_dev *rcec_pdev = ydev->assoc_dev->pdev;
 	int num = ydev->is_vf ? 1 : YCC_RINGPAIR_NUM;
-	int ret;
+	int cpu, cpus = num_online_cpus();
+	int ret, i, j;
 
+	/* The 0 - (YCC_RINGPAIR_NUM-1) are rings irqs, the last one is dev error irq */
 	sprintf(ydev->err_irq_name, "ycc_dev_%d_global_err", ydev->id);
 	ret = request_irq(pci_irq_vector(rcec_pdev, num),
 			  ycc_g_err_isr, 0, ydev->err_irq_name, ydev);
-	if (ret)
+	if (ret) {
 		pr_err("Failed to alloc global irq interrupt for dev: %d\n", ydev->id);
+		goto out;
+	}
+
+	if (ydev->is_polling)
+		goto out;
+
+	for (i = 0; i < num; i++) {
+		if (ydev->rings[i].type != KERN_RING)
+			continue;
+
+		ydev->msi_name[i] = kzalloc(16, GFP_KERNEL);
+		if (!ydev->msi_name[i])
+			goto free_irq;
+		snprintf(ydev->msi_name[i], 16, "ycc_ring_%d", i);
+		ret = request_irq(pci_irq_vector(rcec_pdev, i), ycc_resp_isr,
+				  0, ydev->msi_name[i], &ydev->rings[i]);
+		if (ret) {
+			kfree(ydev->msi_name[i]);
+			goto free_irq;
+		}
+		if (!ydev->is_vf)
+			cpu = (i % YCC_RINGPAIR_NUM) % cpus;
+		else
+			cpu = smp_processor_id() % cpus;
+
+		ret = irq_set_affinity_hint(pci_irq_vector(rcec_pdev, i),
+					    get_cpu_mask(cpu));
+		if (ret) {
+			free_irq(pci_irq_vector(rcec_pdev, i), &ydev->rings[i]);
+			kfree(ydev->msi_name[i]);
+			goto free_irq;
+		}
+	}
+
+	return 0;
+
+free_irq:
+	for (j = 0; j < i; j++) {
+		if (ydev->rings[i].type != KERN_RING)
+			continue;
+
+		free_irq(pci_irq_vector(rcec_pdev, j), &ydev->rings[j]);
+		kfree(ydev->msi_name[j]);
+	}
+	free_irq(pci_irq_vector(rcec_pdev, num), ydev);
+out:
 
 	return ret;
 }
 
-/*
- * TODO: Same as the allocate action.
- */
 void ycc_free_irqs(struct ycc_dev *ydev)
 {
 	struct pci_dev *rcec_pdev = ydev->assoc_dev->pdev;
 	int num = ydev->is_vf ? 1 : YCC_RINGPAIR_NUM;
+	int i;
 
+	/* Free device err irq */
 	free_irq(pci_irq_vector(rcec_pdev, num), ydev);
+
+	if (ydev->is_polling)
+		return;
+
+	for (i = 0; i < num; i++) {
+		if (ydev->rings[i].type != KERN_RING)
+			continue;
+
+		irq_set_affinity_hint(pci_irq_vector(rcec_pdev, i), NULL);
+		free_irq(pci_irq_vector(rcec_pdev, i), &ydev->rings[i]);
+		kfree(ydev->msi_name[i]);
+	}
 }
 
 int ycc_init_global_err(struct ycc_dev *ydev)
-- 
1.8.3.1


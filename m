Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BD328B331
	for <lists+linux-crypto@lfdr.de>; Mon, 12 Oct 2020 12:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgJLK6v (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 12 Oct 2020 06:58:51 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:23038 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729649AbgJLK6u (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 12 Oct 2020 06:58:50 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09CAt7WX005945;
        Mon, 12 Oct 2020 03:58:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=MKvmOECBGW/xMUU9GCjzgrMOcTmkuKrw6J2yRGjAetA=;
 b=hmIUGjzCAH2F9n+yo+VJeGNP0X9DjTOE2E1SuujOoqJD9Vzp5oEF71QgwcwFO3UM7D6+
 TgGPPUrqnHmHBhvcWLSSmx12YqAaDMfxhBBNEfPKgxmNsOf1d9hwXWzQJuTRi6hCLzZa
 LbkY/XiL8DNi0lUo9mikTVNdw+VPcPIwghUfeJvIBj+aoQmW2qRmX0VfrWIqw8kndM2S
 ki2ZpsAP/EdTMsx20TCtMS1gcNAj9DfVqRmaWsreEHbL6B6nI4K3ulojmikp0CVyDWGc
 rXXz/DK9UWzhx98Pzky6jYaa+Xyy29rrhRfefXlAGEMxIFuw64uqnDV+NSC/6zxsIH7e PA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 343cfj5cxd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 03:58:43 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Oct
 2020 03:58:42 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Oct
 2020 03:58:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Oct 2020 03:58:42 -0700
Received: from hyd1schalla-dt.marvell.com (hyd1schalla-dt.marvell.com [10.29.8.39])
        by maili.marvell.com (Postfix) with ESMTP id 444053F703F;
        Mon, 12 Oct 2020 03:58:39 -0700 (PDT)
From:   Srujana Challa <schalla@marvell.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <kuba@kernel.org>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <schandran@marvell.com>,
        <pathreya@marvell.com>, Srujana Challa <schalla@marvell.com>
Subject: [PATCH v7,net-next,05/13] crypto: octeontx2: add mailbox communication with AF
Date:   Mon, 12 Oct 2020 16:27:11 +0530
Message-ID: <20201012105719.12492-6-schalla@marvell.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012105719.12492-1-schalla@marvell.com>
References: <20201012105719.12492-1-schalla@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_08:2020-10-12,2020-10-12 signatures=0
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

In the resource virtualization unit (RVU) each of the PF and AF
(admin function) share a 64KB of reserved memory region for
communication. This patch initializes PF <=> AF mailbox IRQs,
registers handlers for processing these communication messages.

Signed-off-by: Suheil Chandran <schandran@marvell.com>
Signed-off-by: Srujana Challa <schalla@marvell.com>
---
 drivers/crypto/marvell/octeontx2/Makefile     |   3 +-
 .../marvell/octeontx2/otx2_cpt_common.h       |   4 +
 .../marvell/octeontx2/otx2_cpt_mbox_common.c  |  37 +++++++
 drivers/crypto/marvell/octeontx2/otx2_cptpf.h |  12 +++
 .../marvell/octeontx2/otx2_cptpf_main.c       | 101 +++++++++++++++++-
 .../marvell/octeontx2/otx2_cptpf_mbox.c       |  80 ++++++++++++++
 6 files changed, 235 insertions(+), 2 deletions(-)
 create mode 100644 drivers/crypto/marvell/octeontx2/otx2_cpt_mbox_common.c
 create mode 100644 drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c

diff --git a/drivers/crypto/marvell/octeontx2/Makefile b/drivers/crypto/marvell/octeontx2/Makefile
index db763ad46a91..8c8262e94f78 100644
--- a/drivers/crypto/marvell/octeontx2/Makefile
+++ b/drivers/crypto/marvell/octeontx2/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_CRYPTO_DEV_OCTEONTX2_CPT) += octeontx2-cpt.o
 
-octeontx2-cpt-objs := otx2_cptpf_main.o
+octeontx2-cpt-objs := otx2_cptpf_main.o otx2_cptpf_mbox.o \
+		      otx2_cpt_mbox_common.o
 
 ccflags-y += -I$(srctree)/drivers/net/ethernet/marvell/octeontx2/af
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h b/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h
index eff4ffa58dc4..b677f8c7e724 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h
+++ b/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h
@@ -12,6 +12,7 @@
 #include <linux/crypto.h>
 #include "otx2_cpt_hw_types.h"
 #include "rvu.h"
+#include "mbox.h"
 
 #define OTX2_CPT_RVU_FUNC_ADDR_S(blk, slot, offs) \
 		(((blk) << 20) | ((slot) << 12) | (offs))
@@ -29,4 +30,7 @@ static inline u64 otx2_cpt_read64(void __iomem *reg_base, u64 blk, u64 slot,
 	return readq_relaxed(reg_base +
 			     OTX2_CPT_RVU_FUNC_ADDR_S(blk, slot, offs));
 }
+
+int otx2_cpt_send_ready_msg(struct otx2_mbox *mbox, struct pci_dev *pdev);
+int otx2_cpt_send_mbox_msg(struct otx2_mbox *mbox, struct pci_dev *pdev);
 #endif /* __OTX2_CPT_COMMON_H */
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cpt_mbox_common.c b/drivers/crypto/marvell/octeontx2/otx2_cpt_mbox_common.c
new file mode 100644
index 000000000000..a122483b5976
--- /dev/null
+++ b/drivers/crypto/marvell/octeontx2/otx2_cpt_mbox_common.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2020 Marvell. */
+
+#include "otx2_cpt_common.h"
+
+int otx2_cpt_send_mbox_msg(struct otx2_mbox *mbox, struct pci_dev *pdev)
+{
+	int ret;
+
+	otx2_mbox_msg_send(mbox, 0);
+	ret = otx2_mbox_wait_for_rsp(mbox, 0);
+	if (ret == -EIO) {
+		dev_err(&pdev->dev, "RVU MBOX timeout.\n");
+		return ret;
+	} else if (ret) {
+		dev_err(&pdev->dev, "RVU MBOX error: %d.\n", ret);
+		return -EFAULT;
+	}
+	return ret;
+}
+
+int otx2_cpt_send_ready_msg(struct otx2_mbox *mbox, struct pci_dev *pdev)
+{
+	struct mbox_msghdr *req;
+
+	req = otx2_mbox_alloc_msg_rsp(mbox, 0, sizeof(*req),
+				      sizeof(struct ready_msg_rsp));
+	if (req == NULL) {
+		dev_err(&pdev->dev, "RVU MBOX failed to get message.\n");
+		return -EFAULT;
+	}
+	req->id = MBOX_MSG_READY;
+	req->sig = OTX2_MBOX_REQ_SIG;
+	req->pcifunc = 0;
+
+	return otx2_cpt_send_mbox_msg(mbox, pdev);
+}
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf.h b/drivers/crypto/marvell/octeontx2/otx2_cptpf.h
index 84cdc8cc2c15..87fe4c6838e5 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf.h
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf.h
@@ -5,9 +5,21 @@
 #ifndef __OTX2_CPTPF_H
 #define __OTX2_CPTPF_H
 
+#include "otx2_cpt_common.h"
+
 struct otx2_cptpf_dev {
 	void __iomem *reg_base;		/* CPT PF registers start address */
+	void __iomem *afpf_mbox_base;	/* PF-AF mbox start address */
 	struct pci_dev *pdev;		/* PCI device handle */
+	/* AF <=> PF mbox */
+	struct otx2_mbox	afpf_mbox;
+	struct work_struct	afpf_mbox_work;
+	struct workqueue_struct *afpf_mbox_wq;
+
+	u8 pf_id;               /* RVU PF number */
 };
 
+irqreturn_t otx2_cptpf_afpf_mbox_intr(int irq, void *arg);
+void otx2_cptpf_afpf_mbox_handler(struct work_struct *work);
+
 #endif /* __OTX2_CPTPF_H */
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
index 9ec1f0cada9a..4742af70a194 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
@@ -10,6 +10,74 @@
 #define OTX2_CPT_DRV_NAME    "octeontx2-cpt"
 #define OTX2_CPT_DRV_STRING  "Marvell OcteonTX2 CPT Physical Function Driver"
 
+static void cptpf_disable_afpf_mbox_intr(struct otx2_cptpf_dev *cptpf)
+{
+	/* Disable AF-PF interrupt */
+	otx2_cpt_write64(cptpf->reg_base, BLKADDR_RVUM, 0, RVU_PF_INT_ENA_W1C,
+			 0x1ULL);
+	/* Clear interrupt if any */
+	otx2_cpt_write64(cptpf->reg_base, BLKADDR_RVUM, 0, RVU_PF_INT, 0x1ULL);
+}
+
+static int cptpf_register_afpf_mbox_intr(struct otx2_cptpf_dev *cptpf)
+{
+	struct pci_dev *pdev = cptpf->pdev;
+	struct device *dev = &pdev->dev;
+	int ret, irq;
+
+	irq = pci_irq_vector(pdev, RVU_PF_INT_VEC_AFPF_MBOX);
+	/* Register AF-PF mailbox interrupt handler */
+	ret = devm_request_irq(dev, irq, otx2_cptpf_afpf_mbox_intr, 0,
+			       "CPTAFPF Mbox", cptpf);
+	if (ret) {
+		dev_err(dev,
+			"IRQ registration failed for PFAF mbox irq\n");
+		return ret;
+	}
+	/* Clear interrupt if any, to avoid spurious interrupts */
+	otx2_cpt_write64(cptpf->reg_base, BLKADDR_RVUM, 0, RVU_PF_INT, 0x1ULL);
+	/* Enable AF-PF interrupt */
+	otx2_cpt_write64(cptpf->reg_base, BLKADDR_RVUM, 0, RVU_PF_INT_ENA_W1S,
+			 0x1ULL);
+
+	ret = otx2_cpt_send_ready_msg(&cptpf->afpf_mbox, cptpf->pdev);
+	if (ret) {
+		dev_warn(dev,
+			 "AF not responding to mailbox, deferring probe\n");
+		cptpf_disable_afpf_mbox_intr(cptpf);
+		return -EPROBE_DEFER;
+	}
+	return 0;
+}
+
+static int cptpf_afpf_mbox_init(struct otx2_cptpf_dev *cptpf)
+{
+	int err;
+
+	cptpf->afpf_mbox_wq = alloc_workqueue("cpt_afpf_mailbox",
+					      WQ_UNBOUND | WQ_HIGHPRI |
+					      WQ_MEM_RECLAIM, 1);
+	if (!cptpf->afpf_mbox_wq)
+		return -ENOMEM;
+
+	err = otx2_mbox_init(&cptpf->afpf_mbox, cptpf->afpf_mbox_base,
+			     cptpf->pdev, cptpf->reg_base, MBOX_DIR_PFAF, 1);
+	if (err)
+		goto error;
+
+	INIT_WORK(&cptpf->afpf_mbox_work, otx2_cptpf_afpf_mbox_handler);
+	return 0;
+error:
+	destroy_workqueue(cptpf->afpf_mbox_wq);
+	return err;
+}
+
+static void cptpf_afpf_mbox_destroy(struct otx2_cptpf_dev *cptpf)
+{
+	destroy_workqueue(cptpf->afpf_mbox_wq);
+	otx2_mbox_destroy(&cptpf->afpf_mbox);
+}
+
 static int cpt_is_pf_usable(struct otx2_cptpf_dev *cptpf)
 {
 	u64 rev;
@@ -33,6 +101,7 @@ static int otx2_cptpf_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *ent)
 {
 	struct device *dev = &pdev->dev;
+	resource_size_t offset, size;
 	struct otx2_cptpf_dev *cptpf;
 	int err;
 
@@ -76,7 +145,34 @@ static int otx2_cptpf_probe(struct pci_dev *pdev,
 	if (err)
 		goto clear_drvdata;
 
+	offset = pci_resource_start(pdev, PCI_MBOX_BAR_NUM);
+	size = pci_resource_len(pdev, PCI_MBOX_BAR_NUM);
+	/* Map AF-PF mailbox memory */
+	cptpf->afpf_mbox_base = devm_ioremap_wc(dev, offset, size);
+	if (!cptpf->afpf_mbox_base) {
+		dev_err(&pdev->dev, "Unable to map BAR4\n");
+		err = -ENODEV;
+		goto clear_drvdata;
+	}
+	err = pci_alloc_irq_vectors(pdev, RVU_PF_INT_VEC_CNT,
+				    RVU_PF_INT_VEC_CNT, PCI_IRQ_MSIX);
+	if (err < 0) {
+		dev_err(dev, "Request for %d msix vectors failed\n",
+			RVU_PF_INT_VEC_CNT);
+		goto clear_drvdata;
+	}
+	/* Initialize AF-PF mailbox */
+	err = cptpf_afpf_mbox_init(cptpf);
+	if (err)
+		goto clear_drvdata;
+	/* Register mailbox interrupt */
+	err = cptpf_register_afpf_mbox_intr(cptpf);
+	if (err)
+		goto destroy_afpf_mbox;
+
 	return 0;
+destroy_afpf_mbox:
+	cptpf_afpf_mbox_destroy(cptpf);
 clear_drvdata:
 	pci_set_drvdata(pdev, NULL);
 	return err;
@@ -88,7 +184,10 @@ static void otx2_cptpf_remove(struct pci_dev *pdev)
 
 	if (!cptpf)
 		return;
-
+	/* Disable AF-PF mailbox interrupt */
+	cptpf_disable_afpf_mbox_intr(cptpf);
+	/* Destroy AF-PF mbox */
+	cptpf_afpf_mbox_destroy(cptpf);
 	pci_set_drvdata(pdev, NULL);
 }
 
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c
new file mode 100644
index 000000000000..0a8bd46b5686
--- /dev/null
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2020 Marvell. */
+
+#include "otx2_cpt_common.h"
+#include "otx2_cptpf.h"
+#include "rvu_reg.h"
+
+irqreturn_t otx2_cptpf_afpf_mbox_intr(int __always_unused irq, void *arg)
+{
+	struct otx2_cptpf_dev *cptpf = arg;
+	u64 intr;
+
+	/* Read the interrupt bits */
+	intr = otx2_cpt_read64(cptpf->reg_base, BLKADDR_RVUM, 0, RVU_PF_INT);
+
+	if (intr & 0x1ULL) {
+		/* Schedule work queue function to process the MBOX request */
+		queue_work(cptpf->afpf_mbox_wq, &cptpf->afpf_mbox_work);
+		/* Clear and ack the interrupt */
+		otx2_cpt_write64(cptpf->reg_base, BLKADDR_RVUM, 0, RVU_PF_INT,
+				 0x1ULL);
+	}
+	return IRQ_HANDLED;
+}
+
+static void process_afpf_mbox_msg(struct otx2_cptpf_dev *cptpf,
+				  struct mbox_msghdr *msg)
+{
+	struct device *dev = &cptpf->pdev->dev;
+
+	if (msg->id >= MBOX_MSG_MAX) {
+		dev_err(dev, "MBOX msg with unknown ID %d\n", msg->id);
+		return;
+	}
+	if (msg->sig != OTX2_MBOX_RSP_SIG) {
+		dev_err(dev, "MBOX msg with wrong signature %x, ID %d\n",
+			msg->sig, msg->id);
+		return;
+	}
+
+	switch (msg->id) {
+	case MBOX_MSG_READY:
+		cptpf->pf_id = (msg->pcifunc >> RVU_PFVF_PF_SHIFT) &
+				RVU_PFVF_PF_MASK;
+		break;
+	default:
+		dev_err(dev,
+			"Unsupported msg %d received.\n", msg->id);
+		break;
+	}
+}
+
+/* Handle mailbox messages received from AF */
+void otx2_cptpf_afpf_mbox_handler(struct work_struct *work)
+{
+	struct otx2_cptpf_dev *cptpf;
+	struct otx2_mbox *afpf_mbox;
+	struct otx2_mbox_dev *mdev;
+	struct mbox_hdr *rsp_hdr;
+	struct mbox_msghdr *msg;
+	int offset, i;
+
+	cptpf = container_of(work, struct otx2_cptpf_dev, afpf_mbox_work);
+	afpf_mbox = &cptpf->afpf_mbox;
+	mdev = &afpf_mbox->dev[0];
+	/* Sync mbox data into memory */
+	smp_wmb();
+
+	rsp_hdr = (struct mbox_hdr *)(mdev->mbase + afpf_mbox->rx_start);
+	offset = ALIGN(sizeof(*rsp_hdr), MBOX_MSG_ALIGN);
+
+	for (i = 0; i < rsp_hdr->num_msgs; i++) {
+		msg = (struct mbox_msghdr *)(mdev->mbase + afpf_mbox->rx_start +
+					     offset);
+		process_afpf_mbox_msg(cptpf, msg);
+		offset = msg->next_msgoff;
+		mdev->msgs_acked++;
+	}
+	otx2_mbox_reset(afpf_mbox, 0);
+}
-- 
2.28.0


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEC6318327
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Feb 2021 02:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhBKBr7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 10 Feb 2021 20:47:59 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:31484 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229564AbhBKBrw (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 10 Feb 2021 20:47:52 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11B1kgKs000423;
        Wed, 10 Feb 2021 17:47:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=aCFx8DkoPL+BqO4by2gnSH5BcyPsnZqU/7jiujV1YuI=;
 b=ZxCB3zhY5qGd0MpDU5/Nb7v4mScE0ohIrwC+Ztt6vlYUM3ufYxrxzJTpE59mbyHsravY
 PHe5b1CJKSDhExN9sbmtcRjeSGt213UkQ5A9dIkJf1TZ+bjQoJBKqabarUSx51K8SZfp
 syke/nX90hUlyVahKIMY8yotoY32nXhSrxm5r71i7IyIpDehJhfvrMsargv+eL4m1U0y
 dlURp3Wk1OU+eKBvLXEjMTZcdRszXxt4KPNI01UPQF3wiN4d2n4P14EfbUYoezjMc/vX
 XmQReS8Xb+1zsg85g4QOr/FTY8PtPXYC715rJUyfDomSF9Koe7bHOK8xstlpjnWWEqqw Mw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 36hugqdhba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 17:47:07 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Feb
 2021 17:47:05 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Feb
 2021 17:47:04 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Feb 2021 17:47:04 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id A29043F7040;
        Wed, 10 Feb 2021 17:47:00 -0800 (PST)
From:   Geetha sowjanya <gakula@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>, <jerinj@marvell.com>,
        <bbrezillon@kernel.org>, <arno@natisbad.org>,
        <schalla@marvell.com>, Geetha sowjanya <gakula@marvell.com>
Subject: [net-next v5 01/14] octeontx2-af: cn10k: Add mbox support for CN10K platform
Date:   Thu, 11 Feb 2021 07:16:18 +0530
Message-ID: <20210211014631.9578-2-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210211014631.9578-1-gakula@marvell.com>
References: <20210211014631.9578-1-gakula@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_11:2021-02-10,2021-02-10 signatures=0
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Subbaraya Sundeep <sbhatta@marvell.com>

Firmware allocates memory regions for PFs and VFs in DRAM.
The PFs memory region is used for AF-PF and PF-VF mailbox.
This mbox facilitates communication between AF-PF and PF-VF.

On CN10K platform:
The DRAM region allocated to PF is enumerated as PF BAR4 memory.
PF BAR4 contains AF-PF mbox region followed by its VFs mbox region.
AF-PF mbox region base address is configured at RVU_AF_PFX_BAR4_ADDR
PF-VF mailbox base address is configured at
RVU_PF(x)_VF_MBOX_ADDR = RVU_AF_PF()_BAR4_ADDR+64KB. PF access its
mbox region via BAR4, whereas VF accesses PF-VF DRAM mailboxes via
BAR2 indirect access.

On CN9XX platform:
Mailbox region in DRAM is divided into two parts AF-PF mbox region and
PF-VF mbox region i.e all PFs mbox region is contiguous similarly all
VFs.
The base address of the AF-PF mbox region is configured at
RVU_AF_PF_BAR4_ADDR.
AF-PF1 mbox address can be calculated as RVU_AF_PF_BAR4_ADDR * mbox
size.
The base address of PF-VF mbox region for each PF is configure at
RVU_AF_PF(0..15)_VF_BAR4_ADDR.PF access its mbox region via BAR4 and its
VF mbox regions from RVU_PF_VF_BAR4_ADDR register, whereas VF access its
mbox region via BAR4.

This patch changes mbox initialization to support both CN9XX and CN10K
platform.

This patch also adds CN10K PTP subsystem and device IDs to ptp
driver id table.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.c  |  59 +++++++--
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   4 +
 .../net/ethernet/marvell/octeontx2/af/ptp.c   |  12 ++
 .../net/ethernet/marvell/octeontx2/af/rvu.c   | 122 ++++++++++++++----
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  23 ++++
 .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   7 +
 6 files changed, 191 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
index bbabb8e64201..0a37ca96aab8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
@@ -20,9 +20,9 @@ static const u16 msgs_offset = ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
 
 void __otx2_mbox_reset(struct otx2_mbox *mbox, int devid)
 {
-	void *hw_mbase = mbox->hwbase + (devid * MBOX_SIZE);
 	struct otx2_mbox_dev *mdev = &mbox->dev[devid];
 	struct mbox_hdr *tx_hdr, *rx_hdr;
+	void *hw_mbase = mdev->hwbase;
 
 	tx_hdr = hw_mbase + mbox->tx_start;
 	rx_hdr = hw_mbase + mbox->rx_start;
@@ -56,12 +56,9 @@ void otx2_mbox_destroy(struct otx2_mbox *mbox)
 }
 EXPORT_SYMBOL(otx2_mbox_destroy);
 
-int otx2_mbox_init(struct otx2_mbox *mbox, void *hwbase, struct pci_dev *pdev,
-		   void *reg_base, int direction, int ndevs)
+static int otx2_mbox_setup(struct otx2_mbox *mbox, struct pci_dev *pdev,
+			   void *reg_base, int direction, int ndevs)
 {
-	struct otx2_mbox_dev *mdev;
-	int devid;
-
 	switch (direction) {
 	case MBOX_DIR_AFPF:
 	case MBOX_DIR_PFVF:
@@ -121,7 +118,6 @@ int otx2_mbox_init(struct otx2_mbox *mbox, void *hwbase, struct pci_dev *pdev,
 	}
 
 	mbox->reg_base = reg_base;
-	mbox->hwbase = hwbase;
 	mbox->pdev = pdev;
 
 	mbox->dev = kcalloc(ndevs, sizeof(struct otx2_mbox_dev), GFP_KERNEL);
@@ -129,11 +125,27 @@ int otx2_mbox_init(struct otx2_mbox *mbox, void *hwbase, struct pci_dev *pdev,
 		otx2_mbox_destroy(mbox);
 		return -ENOMEM;
 	}
-
 	mbox->ndevs = ndevs;
+
+	return 0;
+}
+
+int otx2_mbox_init(struct otx2_mbox *mbox, void *hwbase, struct pci_dev *pdev,
+		   void *reg_base, int direction, int ndevs)
+{
+	struct otx2_mbox_dev *mdev;
+	int devid, err;
+
+	err = otx2_mbox_setup(mbox, pdev, reg_base, direction, ndevs);
+	if (err)
+		return err;
+
+	mbox->hwbase = hwbase;
+
 	for (devid = 0; devid < ndevs; devid++) {
 		mdev = &mbox->dev[devid];
 		mdev->mbase = mbox->hwbase + (devid * MBOX_SIZE);
+		mdev->hwbase = mdev->mbase;
 		spin_lock_init(&mdev->mbox_lock);
 		/* Init header to reset value */
 		otx2_mbox_reset(mbox, devid);
@@ -143,6 +155,35 @@ int otx2_mbox_init(struct otx2_mbox *mbox, void *hwbase, struct pci_dev *pdev,
 }
 EXPORT_SYMBOL(otx2_mbox_init);
 
+/* Initialize mailbox with the set of mailbox region addresses
+ * in the array hwbase.
+ */
+int otx2_mbox_regions_init(struct otx2_mbox *mbox, void **hwbase,
+			   struct pci_dev *pdev, void *reg_base,
+			   int direction, int ndevs)
+{
+	struct otx2_mbox_dev *mdev;
+	int devid, err;
+
+	err = otx2_mbox_setup(mbox, pdev, reg_base, direction, ndevs);
+	if (err)
+		return err;
+
+	mbox->hwbase = hwbase[0];
+
+	for (devid = 0; devid < ndevs; devid++) {
+		mdev = &mbox->dev[devid];
+		mdev->mbase = hwbase[devid];
+		mdev->hwbase = hwbase[devid];
+		spin_lock_init(&mdev->mbox_lock);
+		/* Init header to reset value */
+		otx2_mbox_reset(mbox, devid);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(otx2_mbox_regions_init);
+
 int otx2_mbox_wait_for_rsp(struct otx2_mbox *mbox, int devid)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(MBOX_RSP_TIMEOUT);
@@ -175,9 +216,9 @@ EXPORT_SYMBOL(otx2_mbox_busy_poll_for_rsp);
 
 void otx2_mbox_msg_send(struct otx2_mbox *mbox, int devid)
 {
-	void *hw_mbase = mbox->hwbase + (devid * MBOX_SIZE);
 	struct otx2_mbox_dev *mdev = &mbox->dev[devid];
 	struct mbox_hdr *tx_hdr, *rx_hdr;
+	void *hw_mbase = mdev->hwbase;
 
 	tx_hdr = hw_mbase + mbox->tx_start;
 	rx_hdr = hw_mbase + mbox->rx_start;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index a0fa44941204..5a08f3e13933 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -52,6 +52,7 @@
 
 struct otx2_mbox_dev {
 	void	    *mbase;   /* This dev's mbox region */
+	void	    *hwbase;
 	spinlock_t  mbox_lock;
 	u16         msg_size; /* Total msg size to be sent */
 	u16         rsp_size; /* Total rsp size to be sure the reply is ok */
@@ -98,6 +99,9 @@ void otx2_mbox_destroy(struct otx2_mbox *mbox);
 int otx2_mbox_init(struct otx2_mbox *mbox, void __force *hwbase,
 		   struct pci_dev *pdev, void __force *reg_base,
 		   int direction, int ndevs);
+int otx2_mbox_regions_init(struct otx2_mbox *mbox, void __force **hwbase,
+			   struct pci_dev *pdev, void __force *reg_base,
+			   int direction, int ndevs);
 void otx2_mbox_msg_send(struct otx2_mbox *mbox, int devid);
 int otx2_mbox_wait_for_rsp(struct otx2_mbox *mbox, int devid);
 int otx2_mbox_busy_poll_for_rsp(struct otx2_mbox *mbox, int devid);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
index f69f4f35ae48..1ee37853f338 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
@@ -21,6 +21,9 @@
 #define PCI_SUBSYS_DEVID_OCTX2_95XX_PTP		0xB300
 #define PCI_SUBSYS_DEVID_OCTX2_LOKI_PTP		0xB400
 #define PCI_SUBSYS_DEVID_OCTX2_95MM_PTP		0xB500
+#define PCI_SUBSYS_DEVID_CN10K_A_PTP		0xB900
+#define PCI_SUBSYS_DEVID_CNF10K_A_PTP		0xBA00
+#define PCI_SUBSYS_DEVID_CNF10K_B_PTP		0xBC00
 #define PCI_DEVID_OCTEONTX2_RST			0xA085
 
 #define PCI_PTP_BAR_NO				0
@@ -234,6 +237,15 @@ static const struct pci_device_id ptp_id_table[] = {
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_OCTEONTX2_PTP,
 			 PCI_VENDOR_ID_CAVIUM,
 			 PCI_SUBSYS_DEVID_OCTX2_95MM_PTP) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_OCTEONTX2_PTP,
+			 PCI_VENDOR_ID_CAVIUM,
+			 PCI_SUBSYS_DEVID_CN10K_A_PTP) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_OCTEONTX2_PTP,
+			 PCI_VENDOR_ID_CAVIUM,
+			 PCI_SUBSYS_DEVID_CNF10K_A_PTP) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_OCTEONTX2_PTP,
+			 PCI_VENDOR_ID_CAVIUM,
+			 PCI_SUBSYS_DEVID_CNF10K_B_PTP) },
 	{ 0, }
 };
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 50c2a1d800f4..1729a2ad093e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -78,6 +78,9 @@ static void rvu_setup_hw_capabilities(struct rvu *rvu)
 		if (is_rvu_96xx_A0(rvu))
 			hw->cap.nix_rx_multicast = false;
 	}
+
+	if (!is_rvu_otx2(rvu))
+		hw->cap.per_pf_mbox_regs = true;
 }
 
 /* Poll a RVU block's register 'offset', for a 'zero'
@@ -1936,41 +1939,105 @@ static inline void rvu_afvf_mbox_up_handler(struct work_struct *work)
 	__rvu_mbox_up_handler(mwork, TYPE_AFVF);
 }
 
+static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
+				int num, int type)
+{
+	struct rvu_hwinfo *hw = rvu->hw;
+	int region;
+	u64 bar4;
+
+	/* For cn10k platform VF mailbox regions of a PF follows after the
+	 * PF <-> AF mailbox region. Whereas for Octeontx2 it is read from
+	 * RVU_PF_VF_BAR4_ADDR register.
+	 */
+	if (type == TYPE_AFVF) {
+		for (region = 0; region < num; region++) {
+			if (hw->cap.per_pf_mbox_regs) {
+				bar4 = rvu_read64(rvu, BLKADDR_RVUM,
+						  RVU_AF_PFX_BAR4_ADDR(0)) +
+						  MBOX_SIZE;
+				bar4 += region * MBOX_SIZE;
+			} else {
+				bar4 = rvupf_read64(rvu, RVU_PF_VF_BAR4_ADDR);
+				bar4 += region * MBOX_SIZE;
+			}
+			mbox_addr[region] = (void *)ioremap_wc(bar4, MBOX_SIZE);
+			if (!mbox_addr[region])
+				goto error;
+		}
+		return 0;
+	}
+
+	/* For cn10k platform AF <-> PF mailbox region of a PF is read from per
+	 * PF registers. Whereas for Octeontx2 it is read from
+	 * RVU_AF_PF_BAR4_ADDR register.
+	 */
+	for (region = 0; region < num; region++) {
+		if (hw->cap.per_pf_mbox_regs) {
+			bar4 = rvu_read64(rvu, BLKADDR_RVUM,
+					  RVU_AF_PFX_BAR4_ADDR(region));
+		} else {
+			bar4 = rvu_read64(rvu, BLKADDR_RVUM,
+					  RVU_AF_PF_BAR4_ADDR);
+			bar4 += region * MBOX_SIZE;
+		}
+		mbox_addr[region] = (void *)ioremap_wc(bar4, MBOX_SIZE);
+		if (!mbox_addr[region])
+			goto error;
+	}
+	return 0;
+
+error:
+	while (region--)
+		iounmap((void __iomem *)mbox_addr[region]);
+	return -ENOMEM;
+}
+
 static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 			 int type, int num,
 			 void (mbox_handler)(struct work_struct *),
 			 void (mbox_up_handler)(struct work_struct *))
 {
-	void __iomem *hwbase = NULL, *reg_base;
-	int err, i, dir, dir_up;
+	int err = -EINVAL, i, dir, dir_up;
+	void __iomem *reg_base;
 	struct rvu_work *mwork;
+	void **mbox_regions;
 	const char *name;
-	u64 bar4_addr;
+
+	mbox_regions = kcalloc(num, sizeof(void *), GFP_KERNEL);
+	if (!mbox_regions)
+		return -ENOMEM;
 
 	switch (type) {
 	case TYPE_AFPF:
 		name = "rvu_afpf_mailbox";
-		bar4_addr = rvu_read64(rvu, BLKADDR_RVUM, RVU_AF_PF_BAR4_ADDR);
 		dir = MBOX_DIR_AFPF;
 		dir_up = MBOX_DIR_AFPF_UP;
 		reg_base = rvu->afreg_base;
+		err = rvu_get_mbox_regions(rvu, mbox_regions, num, TYPE_AFPF);
+		if (err)
+			goto free_regions;
 		break;
 	case TYPE_AFVF:
 		name = "rvu_afvf_mailbox";
-		bar4_addr = rvupf_read64(rvu, RVU_PF_VF_BAR4_ADDR);
 		dir = MBOX_DIR_PFVF;
 		dir_up = MBOX_DIR_PFVF_UP;
 		reg_base = rvu->pfreg_base;
+		err = rvu_get_mbox_regions(rvu, mbox_regions, num, TYPE_AFVF);
+		if (err)
+			goto free_regions;
 		break;
 	default:
-		return -EINVAL;
+		return err;
 	}
 
 	mw->mbox_wq = alloc_workqueue(name,
 				      WQ_UNBOUND | WQ_HIGHPRI | WQ_MEM_RECLAIM,
 				      num);
-	if (!mw->mbox_wq)
-		return -ENOMEM;
+	if (!mw->mbox_wq) {
+		err = -ENOMEM;
+		goto unmap_regions;
+	}
 
 	mw->mbox_wrk = devm_kcalloc(rvu->dev, num,
 				    sizeof(struct rvu_work), GFP_KERNEL);
@@ -1986,23 +2053,13 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 		goto exit;
 	}
 
-	/* Mailbox is a reserved memory (in RAM) region shared between
-	 * RVU devices, shouldn't be mapped as device memory to allow
-	 * unaligned accesses.
-	 */
-	hwbase = ioremap_wc(bar4_addr, MBOX_SIZE * num);
-	if (!hwbase) {
-		dev_err(rvu->dev, "Unable to map mailbox region\n");
-		err = -ENOMEM;
-		goto exit;
-	}
-
-	err = otx2_mbox_init(&mw->mbox, hwbase, rvu->pdev, reg_base, dir, num);
+	err = otx2_mbox_regions_init(&mw->mbox, mbox_regions, rvu->pdev,
+				     reg_base, dir, num);
 	if (err)
 		goto exit;
 
-	err = otx2_mbox_init(&mw->mbox_up, hwbase, rvu->pdev,
-			     reg_base, dir_up, num);
+	err = otx2_mbox_regions_init(&mw->mbox_up, mbox_regions, rvu->pdev,
+				     reg_base, dir_up, num);
 	if (err)
 		goto exit;
 
@@ -2015,25 +2072,36 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 		mwork->rvu = rvu;
 		INIT_WORK(&mwork->work, mbox_up_handler);
 	}
-
+	kfree(mbox_regions);
 	return 0;
+
 exit:
-	if (hwbase)
-		iounmap((void __iomem *)hwbase);
 	destroy_workqueue(mw->mbox_wq);
+unmap_regions:
+	while (num--)
+		iounmap((void __iomem *)mbox_regions[num]);
+free_regions:
+	kfree(mbox_regions);
 	return err;
 }
 
 static void rvu_mbox_destroy(struct mbox_wq_info *mw)
 {
+	struct otx2_mbox *mbox = &mw->mbox;
+	struct otx2_mbox_dev *mdev;
+	int devid;
+
 	if (mw->mbox_wq) {
 		flush_workqueue(mw->mbox_wq);
 		destroy_workqueue(mw->mbox_wq);
 		mw->mbox_wq = NULL;
 	}
 
-	if (mw->mbox.hwbase)
-		iounmap((void __iomem *)mw->mbox.hwbase);
+	for (devid = 0; devid < mbox->ndevs; devid++) {
+		mdev = &mbox->dev[devid];
+		if (mdev->hwbase)
+			iounmap((void __iomem *)mdev->hwbase);
+	}
 
 	otx2_mbox_destroy(&mw->mbox);
 	otx2_mbox_destroy(&mw->mbox_up);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index ce931d86600b..381055a6b6a4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -25,6 +25,7 @@
 
 /* Subsystem Device ID */
 #define PCI_SUBSYS_DEVID_96XX                  0xB200
+#define PCI_SUBSYS_DEVID_CN10K_A	       0xB900
 
 /* PCI BAR nos */
 #define	PCI_AF_REG_BAR_NUM			0
@@ -303,6 +304,7 @@ struct hw_cap {
 	bool	nix_shaping;		 /* Is shaping and coloring supported */
 	bool	nix_tx_link_bp;		 /* Can link backpressure TL queues ? */
 	bool	nix_rx_multicast;	 /* Rx packet replication support */
+	bool	per_pf_mbox_regs; /* PF mbox specified in per PF registers ? */
 };
 
 struct rvu_hwinfo {
@@ -472,6 +474,27 @@ static inline bool is_rvu_96xx_B0(struct rvu *rvu)
 		(pdev->subsystem_device == PCI_SUBSYS_DEVID_96XX);
 }
 
+/* REVID for PCIe devices.
+ * Bits 0..1: minor pass, bit 3..2: major pass
+ * bits 7..4: midr id
+ */
+#define PCI_REVISION_ID_96XX		0x00
+#define PCI_REVISION_ID_95XX		0x10
+#define PCI_REVISION_ID_LOKI		0x20
+#define PCI_REVISION_ID_98XX		0x30
+#define PCI_REVISION_ID_95XXMM		0x40
+
+static inline bool is_rvu_otx2(struct rvu *rvu)
+{
+	struct pci_dev *pdev = rvu->pdev;
+
+	u8 midr = pdev->revision & 0xF0;
+
+	return (midr == PCI_REVISION_ID_96XX || midr == PCI_REVISION_ID_95XX ||
+		midr == PCI_REVISION_ID_LOKI || midr == PCI_REVISION_ID_98XX ||
+		midr == PCI_REVISION_ID_95XXMM);
+}
+
 /* Function Prototypes
  * RVU
  */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
index 79a6dcf0e3c0..78395c740c39 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
@@ -44,6 +44,11 @@
 #define RVU_AF_PFME_INT_W1S                 (0x28c8)
 #define RVU_AF_PFME_INT_ENA_W1S             (0x28d0)
 #define RVU_AF_PFME_INT_ENA_W1C             (0x28d8)
+#define RVU_AF_PFX_BAR4_ADDR(a)             (0x5000 | (a) << 4)
+#define RVU_AF_PFX_BAR4_CFG                 (0x5200 | (a) << 4)
+#define RVU_AF_PFX_VF_BAR4_ADDR             (0x5400 | (a) << 4)
+#define RVU_AF_PFX_VF_BAR4_CFG              (0x5600 | (a) << 4)
+#define RVU_AF_PFX_LMTLINE_ADDR             (0x5800 | (a) << 4)
 
 /* Admin function's privileged PF/VF registers */
 #define RVU_PRIV_CONST                      (0x8000000)
@@ -100,6 +105,8 @@
 #define RVU_PF_MSIX_VECX_ADDR(a)            (0x000 | (a) << 4)
 #define RVU_PF_MSIX_VECX_CTL(a)             (0x008 | (a) << 4)
 #define RVU_PF_MSIX_PBAX(a)                 (0xF0000 | (a) << 3)
+#define RVU_PF_VF_MBOX_ADDR                 (0xC40)
+#define RVU_PF_LMTLINE_ADDR                 (0xC48)
 
 /* RVU VF registers */
 #define	RVU_VF_VFPF_MBOX0		    (0x00000)
-- 
2.17.1


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D886EE39B
	for <lists+linux-crypto@lfdr.de>; Tue, 25 Apr 2023 16:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbjDYOGj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 25 Apr 2023 10:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbjDYOGh (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 25 Apr 2023 10:06:37 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D240A659F
        for <linux-crypto@vger.kernel.org>; Tue, 25 Apr 2023 07:06:34 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P9EsNa013403;
        Tue, 25 Apr 2023 07:06:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=g0cQxvqtI68BsaaqYISM+FCQglv8wPN5Z5pFFh8K3fE=;
 b=ZaEKjrpO/H38tlb74KBEafIKAEBh48YGU4TtCezNJBqbGsDecati2hPbXguVnYRFVaBB
 3UinLB573naRrtNDCiBpeI1qb2p9zzLlxI41YE2qGBPzBC2g+3aie6/TpVPnGWOVTA1X
 hkZT2TRKu+ompEBwJYbs8g+UUNmaH7+Nfrb7BbW8yFqCZ7v1OEt8oF33TgeB+OPWxFf2
 G/VjnGm8O7lfDXZ3FJom+ujwdfe/itqIt9kDEK+EDtvzyS2vL+efo0x4NbEKar9nE81Y
 9ysa5oEbg2cfg22RFFDcgp5WPvce1PKD2vobvH49M8A2eELgI0qHyu5+MFIDopdEBsuV Fw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3q6c2f94kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 07:06:28 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 25 Apr
 2023 07:06:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 25 Apr 2023 07:06:27 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
        by maili.marvell.com (Postfix) with ESMTP id 8F0A83F7068;
        Tue, 25 Apr 2023 07:06:25 -0700 (PDT)
From:   Srujana Challa <schalla@marvell.com>
To:     <linux-crypto@vger.kernel.org>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <bbrezillon@kernel.org>, <arno@natisbad.org>
Subject: [PATCH 2/2] crypto: octeontx2: hardware configuration for inline IPsec
Date:   Tue, 25 Apr 2023 19:36:20 +0530
Message-ID: <20230425140620.2031480-3-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230425140620.2031480-1-schalla@marvell.com>
References: <20230425140620.2031480-1-schalla@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: zkhThYSunzPglIuQ-DDpfUfzLftSBtVI
X-Proofpoint-ORIG-GUID: zkhThYSunzPglIuQ-DDpfUfzLftSBtVI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On OcteonTX2/OctoenTX3 variants of silicon, Admin function (AF)
handles resource allocation and configuration for PFs and their VFs.
PFs request the AF directly, via mailboxes.
Unlike PFs, VFs cannot send a mailbox request directly. A VF sends
mailbox messages to its parent PF, with which it shares a
mailbox region. The PF then forwards these messages to the AF.

This patch adds code to configure inline-IPsec HW resources for
CPT VFs as CPT VFs cannot send a mailbox request directly to AF.

Signed-off-by: Srujana Challa <schalla@marvell.com>
---
 .../marvell/octeontx2/otx2_cpt_common.h       |  15 ++
 .../marvell/octeontx2/otx2_cpt_mbox_common.c  |   3 +
 drivers/crypto/marvell/octeontx2/otx2_cptlf.c |  34 ++--
 drivers/crypto/marvell/octeontx2/otx2_cptlf.h |  33 +++-
 drivers/crypto/marvell/octeontx2/otx2_cptpf.h |   3 +
 .../marvell/octeontx2/otx2_cptpf_main.c       |  31 ++++
 .../marvell/octeontx2/otx2_cptpf_mbox.c       | 161 +++++++++++++++++-
 .../marvell/octeontx2/otx2_cptpf_ucode.c      |  10 +-
 drivers/crypto/marvell/octeontx2/otx2_cptvf.h |   1 +
 .../marvell/octeontx2/otx2_cptvf_main.c       |   8 +-
 10 files changed, 261 insertions(+), 38 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h b/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h
index 6019066a6451..46b778bbbee4 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h
+++ b/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h
@@ -40,10 +40,25 @@ enum otx2_cpt_eng_type {
 };
 
 /* Take mbox id from end of CPT mbox range in AF (range 0xA00 - 0xBFF) */
+#define MBOX_MSG_RX_INLINE_IPSEC_LF_CFG 0xBFE
 #define MBOX_MSG_GET_ENG_GRP_NUM        0xBFF
 #define MBOX_MSG_GET_CAPS               0xBFD
 #define MBOX_MSG_GET_KVF_LIMITS         0xBFC
 
+/*
+ * Message request to config cpt lf for inline inbound ipsec.
+ * This message is only used between CPT PF <-> CPT VF
+ */
+struct otx2_cpt_rx_inline_lf_cfg {
+	struct mbox_msghdr hdr;
+	u16 sso_pf_func;
+	u16 param1;
+	u16 param2;
+	u16 opcode;
+	u32 credit;
+	u32 reserved;
+};
+
 /*
  * Message request and response to get engine group number
  * which has attached a given type of engines (SE, AE, IE)
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cpt_mbox_common.c b/drivers/crypto/marvell/octeontx2/otx2_cpt_mbox_common.c
index 115997475beb..273ee5352a50 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cpt_mbox_common.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cpt_mbox_common.c
@@ -141,6 +141,8 @@ int otx2_cpt_attach_rscrs_msg(struct otx2_cptlfs_info *lfs)
 	req->hdr.sig = OTX2_MBOX_REQ_SIG;
 	req->hdr.pcifunc = 0;
 	req->cptlfs = lfs->lfs_num;
+	req->cpt_blkaddr = lfs->blkaddr;
+	req->modify = 1;
 	ret = otx2_cpt_send_mbox_msg(mbox, lfs->pdev);
 	if (ret)
 		return ret;
@@ -168,6 +170,7 @@ int otx2_cpt_detach_rsrcs_msg(struct otx2_cptlfs_info *lfs)
 	req->hdr.id = MBOX_MSG_DETACH_RESOURCES;
 	req->hdr.sig = OTX2_MBOX_REQ_SIG;
 	req->hdr.pcifunc = 0;
+	req->cptlfs = 1;
 	ret = otx2_cpt_send_mbox_msg(mbox, lfs->pdev);
 	if (ret)
 		return ret;
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptlf.c b/drivers/crypto/marvell/octeontx2/otx2_cptlf.c
index 71e5f79431af..6edd27ff8c4e 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptlf.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptlf.c
@@ -13,10 +13,10 @@ static void cptlf_do_set_done_time_wait(struct otx2_cptlf_info *lf,
 {
 	union otx2_cptx_lf_done_wait done_wait;
 
-	done_wait.u = otx2_cpt_read64(lf->lfs->reg_base, BLKADDR_CPT0, lf->slot,
-				      OTX2_CPT_LF_DONE_WAIT);
+	done_wait.u = otx2_cpt_read64(lf->lfs->reg_base, lf->lfs->blkaddr,
+				      lf->slot, OTX2_CPT_LF_DONE_WAIT);
 	done_wait.s.time_wait = time_wait;
-	otx2_cpt_write64(lf->lfs->reg_base, BLKADDR_CPT0, lf->slot,
+	otx2_cpt_write64(lf->lfs->reg_base, lf->lfs->blkaddr, lf->slot,
 			 OTX2_CPT_LF_DONE_WAIT, done_wait.u);
 }
 
@@ -24,10 +24,10 @@ static void cptlf_do_set_done_num_wait(struct otx2_cptlf_info *lf, int num_wait)
 {
 	union otx2_cptx_lf_done_wait done_wait;
 
-	done_wait.u = otx2_cpt_read64(lf->lfs->reg_base, BLKADDR_CPT0, lf->slot,
-				      OTX2_CPT_LF_DONE_WAIT);
+	done_wait.u = otx2_cpt_read64(lf->lfs->reg_base, lf->lfs->blkaddr,
+				      lf->slot, OTX2_CPT_LF_DONE_WAIT);
 	done_wait.s.num_wait = num_wait;
-	otx2_cpt_write64(lf->lfs->reg_base, BLKADDR_CPT0, lf->slot,
+	otx2_cpt_write64(lf->lfs->reg_base, lf->lfs->blkaddr, lf->slot,
 			 OTX2_CPT_LF_DONE_WAIT, done_wait.u);
 }
 
@@ -147,7 +147,7 @@ static void cptlf_set_misc_intrs(struct otx2_cptlfs_info *lfs, u8 enable)
 	irq_misc.s.nwrp = 0x1;
 
 	for (slot = 0; slot < lfs->lfs_num; slot++)
-		otx2_cpt_write64(lfs->reg_base, BLKADDR_CPT0, slot, reg,
+		otx2_cpt_write64(lfs->reg_base, lfs->blkaddr, slot, reg,
 				 irq_misc.u);
 }
 
@@ -157,7 +157,7 @@ static void cptlf_enable_intrs(struct otx2_cptlfs_info *lfs)
 
 	/* Enable done interrupts */
 	for (slot = 0; slot < lfs->lfs_num; slot++)
-		otx2_cpt_write64(lfs->reg_base, BLKADDR_CPT0, slot,
+		otx2_cpt_write64(lfs->reg_base, lfs->blkaddr, slot,
 				 OTX2_CPT_LF_DONE_INT_ENA_W1S, 0x1);
 	/* Enable Misc interrupts */
 	cptlf_set_misc_intrs(lfs, true);
@@ -168,7 +168,7 @@ static void cptlf_disable_intrs(struct otx2_cptlfs_info *lfs)
 	int slot;
 
 	for (slot = 0; slot < lfs->lfs_num; slot++)
-		otx2_cpt_write64(lfs->reg_base, BLKADDR_CPT0, slot,
+		otx2_cpt_write64(lfs->reg_base, lfs->blkaddr, slot,
 				 OTX2_CPT_LF_DONE_INT_ENA_W1C, 0x1);
 	cptlf_set_misc_intrs(lfs, false);
 }
@@ -177,7 +177,7 @@ static inline int cptlf_read_done_cnt(struct otx2_cptlf_info *lf)
 {
 	union otx2_cptx_lf_done irq_cnt;
 
-	irq_cnt.u = otx2_cpt_read64(lf->lfs->reg_base, BLKADDR_CPT0, lf->slot,
+	irq_cnt.u = otx2_cpt_read64(lf->lfs->reg_base, lf->lfs->blkaddr, lf->slot,
 				    OTX2_CPT_LF_DONE);
 	return irq_cnt.s.done;
 }
@@ -189,8 +189,8 @@ static irqreturn_t cptlf_misc_intr_handler(int __always_unused irq, void *arg)
 	struct device *dev;
 
 	dev = &lf->lfs->pdev->dev;
-	irq_misc.u = otx2_cpt_read64(lf->lfs->reg_base, BLKADDR_CPT0, lf->slot,
-				     OTX2_CPT_LF_MISC_INT);
+	irq_misc.u = otx2_cpt_read64(lf->lfs->reg_base, lf->lfs->blkaddr,
+				     lf->slot, OTX2_CPT_LF_MISC_INT);
 	irq_misc_ack.u = 0x0;
 
 	if (irq_misc.s.fault) {
@@ -222,7 +222,7 @@ static irqreturn_t cptlf_misc_intr_handler(int __always_unused irq, void *arg)
 	}
 
 	/* Acknowledge interrupts */
-	otx2_cpt_write64(lf->lfs->reg_base, BLKADDR_CPT0, lf->slot,
+	otx2_cpt_write64(lf->lfs->reg_base, lf->lfs->blkaddr, lf->slot,
 			 OTX2_CPT_LF_MISC_INT, irq_misc_ack.u);
 
 	return IRQ_HANDLED;
@@ -237,13 +237,13 @@ static irqreturn_t cptlf_done_intr_handler(int irq, void *arg)
 	/* Read the number of completed requests */
 	irq_cnt = cptlf_read_done_cnt(lf);
 	if (irq_cnt) {
-		done_wait.u = otx2_cpt_read64(lf->lfs->reg_base, BLKADDR_CPT0,
+		done_wait.u = otx2_cpt_read64(lf->lfs->reg_base, lf->lfs->blkaddr,
 					      lf->slot, OTX2_CPT_LF_DONE_WAIT);
 		/* Acknowledge the number of completed requests */
-		otx2_cpt_write64(lf->lfs->reg_base, BLKADDR_CPT0, lf->slot,
+		otx2_cpt_write64(lf->lfs->reg_base, lf->lfs->blkaddr, lf->slot,
 				 OTX2_CPT_LF_DONE_ACK, irq_cnt);
 
-		otx2_cpt_write64(lf->lfs->reg_base, BLKADDR_CPT0, lf->slot,
+		otx2_cpt_write64(lf->lfs->reg_base, lf->lfs->blkaddr, lf->slot,
 				 OTX2_CPT_LF_DONE_WAIT, done_wait.u);
 		if (unlikely(!lf->wqe)) {
 			dev_err(&lf->lfs->pdev->dev, "No work for LF %d\n",
@@ -393,7 +393,7 @@ int otx2_cptlf_init(struct otx2_cptlfs_info *lfs, u8 eng_grp_mask, int pri,
 						 OTX2_CPT_LMT_LF_LMTLINEX(0));
 
 		lfs->lf[slot].ioreg = lfs->reg_base +
-			OTX2_CPT_RVU_FUNC_ADDR_S(BLKADDR_CPT0, slot,
+			OTX2_CPT_RVU_FUNC_ADDR_S(lfs->blkaddr, slot,
 						 OTX2_CPT_LF_NQX(0));
 	}
 	/* Send request to attach LFs */
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptlf.h b/drivers/crypto/marvell/octeontx2/otx2_cptlf.h
index 4fcaf61a70e3..5302fe3d0e6f 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptlf.h
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptlf.h
@@ -180,7 +180,7 @@ static inline void otx2_cptlf_set_iqueues_base_addr(
 
 	for (slot = 0; slot < lfs->lfs_num; slot++) {
 		lf_q_base.u = lfs->lf[slot].iqueue.dma_addr;
-		otx2_cpt_write64(lfs->reg_base, BLKADDR_CPT0, slot,
+		otx2_cpt_write64(lfs->reg_base, lfs->blkaddr, slot,
 				 OTX2_CPT_LF_Q_BASE, lf_q_base.u);
 	}
 }
@@ -191,7 +191,7 @@ static inline void otx2_cptlf_do_set_iqueue_size(struct otx2_cptlf_info *lf)
 
 	lf_q_size.s.size_div40 = OTX2_CPT_SIZE_DIV40 +
 				 OTX2_CPT_EXTRA_SIZE_DIV40;
-	otx2_cpt_write64(lf->lfs->reg_base, BLKADDR_CPT0, lf->slot,
+	otx2_cpt_write64(lf->lfs->reg_base, lf->lfs->blkaddr, lf->slot,
 			 OTX2_CPT_LF_Q_SIZE, lf_q_size.u);
 }
 
@@ -207,15 +207,16 @@ static inline void otx2_cptlf_do_disable_iqueue(struct otx2_cptlf_info *lf)
 {
 	union otx2_cptx_lf_ctl lf_ctl = { .u = 0x0 };
 	union otx2_cptx_lf_inprog lf_inprog;
+	u8 blkaddr = lf->lfs->blkaddr;
 	int timeout = 20;
 
 	/* Disable instructions enqueuing */
-	otx2_cpt_write64(lf->lfs->reg_base, BLKADDR_CPT0, lf->slot,
+	otx2_cpt_write64(lf->lfs->reg_base, blkaddr, lf->slot,
 			 OTX2_CPT_LF_CTL, lf_ctl.u);
 
 	/* Wait for instruction queue to become empty */
 	do {
-		lf_inprog.u = otx2_cpt_read64(lf->lfs->reg_base, BLKADDR_CPT0,
+		lf_inprog.u = otx2_cpt_read64(lf->lfs->reg_base, blkaddr,
 					      lf->slot, OTX2_CPT_LF_INPROG);
 		if (!lf_inprog.s.inflight)
 			break;
@@ -234,7 +235,7 @@ static inline void otx2_cptlf_do_disable_iqueue(struct otx2_cptlf_info *lf)
 	 * the queue should be empty at this point
 	 */
 	lf_inprog.s.eena = 0x0;
-	otx2_cpt_write64(lf->lfs->reg_base, BLKADDR_CPT0, lf->slot,
+	otx2_cpt_write64(lf->lfs->reg_base, blkaddr, lf->slot,
 			 OTX2_CPT_LF_INPROG, lf_inprog.u);
 }
 
@@ -249,14 +250,15 @@ static inline void otx2_cptlf_disable_iqueues(struct otx2_cptlfs_info *lfs)
 static inline void otx2_cptlf_set_iqueue_enq(struct otx2_cptlf_info *lf,
 					     bool enable)
 {
+	u8 blkaddr = lf->lfs->blkaddr;
 	union otx2_cptx_lf_ctl lf_ctl;
 
-	lf_ctl.u = otx2_cpt_read64(lf->lfs->reg_base, BLKADDR_CPT0, lf->slot,
+	lf_ctl.u = otx2_cpt_read64(lf->lfs->reg_base, blkaddr, lf->slot,
 				   OTX2_CPT_LF_CTL);
 
 	/* Set iqueue's enqueuing */
 	lf_ctl.s.ena = enable ? 0x1 : 0x0;
-	otx2_cpt_write64(lf->lfs->reg_base, BLKADDR_CPT0, lf->slot,
+	otx2_cpt_write64(lf->lfs->reg_base, blkaddr, lf->slot,
 			 OTX2_CPT_LF_CTL, lf_ctl.u);
 }
 
@@ -269,13 +271,14 @@ static inline void otx2_cptlf_set_iqueue_exec(struct otx2_cptlf_info *lf,
 					      bool enable)
 {
 	union otx2_cptx_lf_inprog lf_inprog;
+	u8 blkaddr = lf->lfs->blkaddr;
 
-	lf_inprog.u = otx2_cpt_read64(lf->lfs->reg_base, BLKADDR_CPT0, lf->slot,
+	lf_inprog.u = otx2_cpt_read64(lf->lfs->reg_base, blkaddr, lf->slot,
 				      OTX2_CPT_LF_INPROG);
 
 	/* Set iqueue's execution */
 	lf_inprog.s.eena = enable ? 0x1 : 0x0;
-	otx2_cpt_write64(lf->lfs->reg_base, BLKADDR_CPT0, lf->slot,
+	otx2_cpt_write64(lf->lfs->reg_base, blkaddr, lf->slot,
 			 OTX2_CPT_LF_INPROG, lf_inprog.u);
 }
 
@@ -364,6 +367,18 @@ static inline bool otx2_cptlf_started(struct otx2_cptlfs_info *lfs)
 	return atomic_read(&lfs->state) == OTX2_CPTLF_STARTED;
 }
 
+static inline void otx2_cptlf_set_dev_info(struct otx2_cptlfs_info *lfs,
+					   struct pci_dev *pdev,
+					   void __iomem *reg_base,
+					   struct otx2_mbox *mbox,
+					   int blkaddr)
+{
+	lfs->pdev = pdev;
+	lfs->reg_base = reg_base;
+	lfs->mbox = mbox;
+	lfs->blkaddr = blkaddr;
+}
+
 int otx2_cptlf_init(struct otx2_cptlfs_info *lfs, u8 eng_grp_msk, int pri,
 		    int lfs_num);
 void otx2_cptlf_shutdown(struct otx2_cptlfs_info *lfs);
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf.h b/drivers/crypto/marvell/octeontx2/otx2_cptpf.h
index 67ea070d5849..a209ec5af381 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf.h
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf.h
@@ -31,6 +31,7 @@ struct otx2_cptpf_dev {
 	struct otx2_cptvf_info vf[OTX2_CPT_MAX_VFS_NUM];
 	struct otx2_cpt_eng_grps eng_grps;/* Engine groups information */
 	struct otx2_cptlfs_info lfs;      /* CPT LFs attached to this PF */
+	struct otx2_cptlfs_info cpt1_lfs; /* CPT1 LFs attached to this PF */
 	/* HW capabilities for each engine type */
 	union otx2_cpt_eng_caps eng_caps[OTX2_CPT_MAX_ENG_TYPES];
 	bool is_eng_caps_discovered;
@@ -55,8 +56,10 @@ struct otx2_cptpf_dev {
 	u8 pf_id;               /* RVU PF number */
 	u8 max_vfs;		/* Maximum number of VFs supported by CPT */
 	u8 enabled_vfs;		/* Number of enabled VFs */
+	u8 sso_pf_func_ovrd;	/* SSO PF_FUNC override bit */
 	u8 kvf_limits;		/* Kernel crypto limits */
 	bool has_cpt1;
+	u8 rsrc_req_blkaddr;
 
 	/* Devlink */
 	struct devlink *dl;
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
index 612a764b8a8c..91855e9f9f8f 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
@@ -13,6 +13,8 @@
 #define OTX2_CPT_DRV_NAME    "rvu_cptpf"
 #define OTX2_CPT_DRV_STRING  "Marvell RVU CPT Physical Function Driver"
 
+#define CPT_UC_RID_CN9K_B0   1
+
 static void cptpf_enable_vfpf_mbox_intr(struct otx2_cptpf_dev *cptpf,
 					int num_vfs)
 {
@@ -498,6 +500,32 @@ static void cptpf_afpf_mbox_destroy(struct otx2_cptpf_dev *cptpf)
 	otx2_mbox_destroy(&cptpf->afpf_mbox_up);
 }
 
+static ssize_t sso_pf_func_ovrd_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct otx2_cptpf_dev *cptpf = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", cptpf->sso_pf_func_ovrd);
+}
+
+static ssize_t sso_pf_func_ovrd_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct otx2_cptpf_dev *cptpf = dev_get_drvdata(dev);
+	u8 sso_pf_func_ovrd;
+
+	if (!(cptpf->pdev->revision == CPT_UC_RID_CN9K_B0))
+		return count;
+
+	if (kstrtou8(buf, 0, &sso_pf_func_ovrd))
+		return -EINVAL;
+
+	cptpf->sso_pf_func_ovrd = sso_pf_func_ovrd;
+
+	return count;
+}
+
 static ssize_t kvf_limits_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
@@ -528,8 +556,11 @@ static ssize_t kvf_limits_store(struct device *dev,
 }
 
 static DEVICE_ATTR_RW(kvf_limits);
+static DEVICE_ATTR_RW(sso_pf_func_ovrd);
+
 static struct attribute *cptpf_attrs[] = {
 	&dev_attr_kvf_limits.attr,
+	&dev_attr_sso_pf_func_ovrd.attr,
 	NULL
 };
 
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c
index d2216d1e9c2e..480b3720f15a 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c
@@ -5,6 +5,20 @@
 #include "otx2_cptpf.h"
 #include "rvu_reg.h"
 
+/* Fastpath ipsec opcode with inplace processing */
+#define CPT_INLINE_RX_OPCODE (0x26 | (1 << 6))
+#define CN10K_CPT_INLINE_RX_OPCODE (0x29 | (1 << 6))
+
+#define cpt_inline_rx_opcode(pdev)                      \
+({                                                      \
+	u8 opcode;                                      \
+	if (is_dev_otx2(pdev))                          \
+		opcode = CPT_INLINE_RX_OPCODE;          \
+	else                                            \
+		opcode = CN10K_CPT_INLINE_RX_OPCODE;    \
+	(opcode);                                       \
+})
+
 /*
  * CPT PF driver version, It will be incremented by 1 for every feature
  * addition in CPT mailbox messages.
@@ -112,6 +126,139 @@ static int handle_msg_kvf_limits(struct otx2_cptpf_dev *cptpf,
 	return 0;
 }
 
+static int send_inline_ipsec_inbound_msg(struct otx2_cptpf_dev *cptpf,
+					 int sso_pf_func, u8 slot)
+{
+	struct cpt_inline_ipsec_cfg_msg *req;
+	struct pci_dev *pdev = cptpf->pdev;
+
+	req = (struct cpt_inline_ipsec_cfg_msg *)
+	      otx2_mbox_alloc_msg_rsp(&cptpf->afpf_mbox, 0,
+				      sizeof(*req), sizeof(struct msg_rsp));
+	if (req == NULL) {
+		dev_err(&pdev->dev, "RVU MBOX failed to get message.\n");
+		return -EFAULT;
+	}
+	memset(req, 0, sizeof(*req));
+	req->hdr.id = MBOX_MSG_CPT_INLINE_IPSEC_CFG;
+	req->hdr.sig = OTX2_MBOX_REQ_SIG;
+	req->hdr.pcifunc = OTX2_CPT_RVU_PFFUNC(cptpf->pf_id, 0);
+	req->dir = CPT_INLINE_INBOUND;
+	req->slot = slot;
+	req->sso_pf_func_ovrd = cptpf->sso_pf_func_ovrd;
+	req->sso_pf_func = sso_pf_func;
+	req->enable = 1;
+
+	return otx2_cpt_send_mbox_msg(&cptpf->afpf_mbox, pdev);
+}
+
+static int rx_inline_ipsec_lf_cfg(struct otx2_cptpf_dev *cptpf, u8 egrp,
+				  struct otx2_cpt_rx_inline_lf_cfg *req)
+{
+	struct nix_inline_ipsec_cfg *nix_req;
+	struct pci_dev *pdev = cptpf->pdev;
+	int ret;
+
+	nix_req = (struct nix_inline_ipsec_cfg *)
+		   otx2_mbox_alloc_msg_rsp(&cptpf->afpf_mbox, 0,
+					   sizeof(*nix_req),
+					   sizeof(struct msg_rsp));
+	if (nix_req == NULL) {
+		dev_err(&pdev->dev, "RVU MBOX failed to get message.\n");
+		return -EFAULT;
+	}
+	memset(nix_req, 0, sizeof(*nix_req));
+	nix_req->hdr.id = MBOX_MSG_NIX_INLINE_IPSEC_CFG;
+	nix_req->hdr.sig = OTX2_MBOX_REQ_SIG;
+	nix_req->enable = 1;
+	if (!req->credit || req->credit > OTX2_CPT_INST_QLEN_MSGS)
+		nix_req->cpt_credit = OTX2_CPT_INST_QLEN_MSGS - 1;
+	else
+		nix_req->cpt_credit = req->credit - 1;
+	nix_req->gen_cfg.egrp = egrp;
+	if (req->opcode)
+		nix_req->gen_cfg.opcode = req->opcode;
+	else
+		nix_req->gen_cfg.opcode = cpt_inline_rx_opcode(pdev);
+	nix_req->gen_cfg.param1 = req->param1;
+	nix_req->gen_cfg.param2 = req->param2;
+	nix_req->inst_qsel.cpt_pf_func = OTX2_CPT_RVU_PFFUNC(cptpf->pf_id, 0);
+	nix_req->inst_qsel.cpt_slot = 0;
+	ret = otx2_cpt_send_mbox_msg(&cptpf->afpf_mbox, pdev);
+	if (ret)
+		return ret;
+
+	if (cptpf->has_cpt1) {
+		ret = send_inline_ipsec_inbound_msg(cptpf, req->sso_pf_func, 1);
+		if (ret)
+			return ret;
+	}
+
+	return send_inline_ipsec_inbound_msg(cptpf, req->sso_pf_func, 0);
+}
+
+static int handle_msg_rx_inline_ipsec_lf_cfg(struct otx2_cptpf_dev *cptpf,
+					     struct mbox_msghdr *req)
+{
+	struct otx2_cpt_rx_inline_lf_cfg *cfg_req;
+	u8 egrp;
+	int ret;
+
+	cfg_req = (struct otx2_cpt_rx_inline_lf_cfg *)req;
+	if (cptpf->lfs.lfs_num) {
+		dev_err(&cptpf->pdev->dev,
+			"LF is already configured for RX inline ipsec.\n");
+		return -EEXIST;
+	}
+	/*
+	 * Allow LFs to execute requests destined to only grp IE_TYPES and
+	 * set queue priority of each LF to high
+	 */
+	egrp = otx2_cpt_get_eng_grp(&cptpf->eng_grps, OTX2_CPT_IE_TYPES);
+	if (egrp == OTX2_CPT_INVALID_CRYPTO_ENG_GRP) {
+		dev_err(&cptpf->pdev->dev,
+			"Engine group for inline ipsec is not available\n");
+		return -ENOENT;
+	}
+
+	otx2_cptlf_set_dev_info(&cptpf->lfs, cptpf->pdev, cptpf->reg_base,
+				&cptpf->afpf_mbox, BLKADDR_CPT0);
+	ret = otx2_cptlf_init(&cptpf->lfs, 1 << egrp, OTX2_CPT_QUEUE_HI_PRIO,
+			      1);
+	if (ret) {
+		dev_err(&cptpf->pdev->dev,
+			"LF configuration failed for RX inline ipsec.\n");
+		return ret;
+	}
+
+	if (cptpf->has_cpt1) {
+		cptpf->rsrc_req_blkaddr = BLKADDR_CPT1;
+		otx2_cptlf_set_dev_info(&cptpf->cpt1_lfs, cptpf->pdev,
+					cptpf->reg_base, &cptpf->afpf_mbox,
+					BLKADDR_CPT1);
+		ret = otx2_cptlf_init(&cptpf->cpt1_lfs, 1 << egrp,
+				      OTX2_CPT_QUEUE_HI_PRIO, 1);
+		if (ret) {
+			dev_err(&cptpf->pdev->dev,
+				"LF configuration failed for RX inline ipsec.\n");
+			goto lf_cleanup;
+		}
+		cptpf->rsrc_req_blkaddr = 0;
+	}
+
+	ret = rx_inline_ipsec_lf_cfg(cptpf, egrp, cfg_req);
+	if (ret)
+		goto lf1_cleanup;
+
+	return 0;
+
+lf1_cleanup:
+	otx2_cptlf_shutdown(&cptpf->cpt1_lfs);
+lf_cleanup:
+	otx2_cptlf_shutdown(&cptpf->lfs);
+	return ret;
+}
+
 static int cptpf_handle_vf_req(struct otx2_cptpf_dev *cptpf,
 			       struct otx2_cptvf_info *vf,
 			       struct mbox_msghdr *req, int size)
@@ -132,6 +279,10 @@ static int cptpf_handle_vf_req(struct otx2_cptpf_dev *cptpf,
 	case MBOX_MSG_GET_KVF_LIMITS:
 		err = handle_msg_kvf_limits(cptpf, vf, req);
 		break;
+	case MBOX_MSG_RX_INLINE_IPSEC_LF_CFG:
+		err = handle_msg_rx_inline_ipsec_lf_cfg(cptpf, req);
+		break;
+
 	default:
 		err = forward_to_af(cptpf, vf, req, size);
 		break;
@@ -256,6 +407,7 @@ irqreturn_t otx2_cptpf_afpf_mbox_intr(int __always_unused irq, void *arg)
 static void process_afpf_mbox_msg(struct otx2_cptpf_dev *cptpf,
 				  struct mbox_msghdr *msg)
 {
+	struct otx2_cptlfs_info *lfs = &cptpf->lfs;
 	struct device *dev = &cptpf->pdev->dev;
 	struct cpt_rd_wr_reg_msg *rsp_rd_wr;
 
@@ -268,6 +420,8 @@ static void process_afpf_mbox_msg(struct otx2_cptpf_dev *cptpf,
 			msg->sig, msg->id);
 		return;
 	}
+	if (cptpf->rsrc_req_blkaddr == BLKADDR_CPT1)
+		lfs = &cptpf->cpt1_lfs;
 
 	switch (msg->id) {
 	case MBOX_MSG_READY:
@@ -287,11 +441,14 @@ static void process_afpf_mbox_msg(struct otx2_cptpf_dev *cptpf,
 		break;
 	case MBOX_MSG_ATTACH_RESOURCES:
 		if (!msg->rc)
-			cptpf->lfs.are_lfs_attached = 1;
+			lfs->are_lfs_attached = 1;
 		break;
 	case MBOX_MSG_DETACH_RESOURCES:
 		if (!msg->rc)
-			cptpf->lfs.are_lfs_attached = 0;
+			lfs->are_lfs_attached = 0;
+		break;
+	case MBOX_MSG_CPT_INLINE_IPSEC_CFG:
+	case MBOX_MSG_NIX_INLINE_IPSEC_CFG:
 		break;
 
 	default:
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
index 1577986677f6..1958b797a421 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
@@ -1504,11 +1504,9 @@ int otx2_cpt_discover_eng_capabilities(struct otx2_cptpf_dev *cptpf)
 	if (ret)
 		goto delete_grps;
 
-	lfs->pdev = pdev;
-	lfs->reg_base = cptpf->reg_base;
-	lfs->mbox = &cptpf->afpf_mbox;
-	lfs->blkaddr = BLKADDR_CPT0;
-	ret = otx2_cptlf_init(&cptpf->lfs, OTX2_CPT_ALL_ENG_GRPS_MASK,
+	otx2_cptlf_set_dev_info(lfs, cptpf->pdev, cptpf->reg_base,
+				&cptpf->afpf_mbox, BLKADDR_CPT0);
+	ret = otx2_cptlf_init(lfs, OTX2_CPT_ALL_ENG_GRPS_MASK,
 			      OTX2_CPT_QUEUE_HI_PRIO, 1);
 	if (ret)
 		goto delete_grps;
@@ -1562,7 +1560,7 @@ int otx2_cpt_discover_eng_capabilities(struct otx2_cptpf_dev *cptpf)
 free_result:
 	kfree(result);
 lf_cleanup:
-	otx2_cptlf_shutdown(&cptpf->lfs);
+	otx2_cptlf_shutdown(lfs);
 delete_grps:
 	delete_engine_grps(pdev, &cptpf->eng_grps);
 
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf.h b/drivers/crypto/marvell/octeontx2/otx2_cptvf.h
index 4207e2236903..994291e90da1 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf.h
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf.h
@@ -19,6 +19,7 @@ struct otx2_cptvf_dev {
 	struct otx2_mbox	pfvf_mbox;
 	struct work_struct	pfvf_mbox_work;
 	struct workqueue_struct *pfvf_mbox_wq;
+	int blkaddr;
 	void *bbuf_base;
 	unsigned long cap_flag;
 };
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
index 392e9fee05e8..3ce3146b6f31 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
@@ -277,12 +277,11 @@ static int cptvf_lf_init(struct otx2_cptvf_dev *cptvf)
 	if (ret)
 		return ret;
 
-	lfs->reg_base = cptvf->reg_base;
-	lfs->pdev = cptvf->pdev;
-	lfs->mbox = &cptvf->pfvf_mbox;
-
 	lfs_num = cptvf->lfs.kvf_limits ? cptvf->lfs.kvf_limits :
 		  num_online_cpus();
+
+	otx2_cptlf_set_dev_info(lfs, cptvf->pdev, cptvf->reg_base,
+				&cptvf->pfvf_mbox, cptvf->blkaddr);
 	ret = otx2_cptlf_init(lfs, eng_grp_msk, OTX2_CPT_QUEUE_HI_PRIO,
 			      lfs_num);
 	if (ret)
@@ -380,6 +379,7 @@ static int otx2_cptvf_probe(struct pci_dev *pdev,
 	if (ret)
 		goto destroy_pfvf_mbox;
 
+	cptvf->blkaddr = BLKADDR_CPT0;
 	/* Initialize CPT LFs */
 	ret = cptvf_lf_init(cptvf);
 	if (ret)
-- 
2.25.1


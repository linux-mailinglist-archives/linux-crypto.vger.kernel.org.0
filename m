Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBB420AFC1
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2020 12:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgFZKcq (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 26 Jun 2020 06:32:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6830 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726671AbgFZKcp (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 26 Jun 2020 06:32:45 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8666F84047603A390FA8
        for <linux-crypto@vger.kernel.org>; Fri, 26 Jun 2020 18:32:43 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Fri, 26 Jun 2020
 18:32:39 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>
Subject: [PATCH 3/5] crypto: hisilicon/sec2 - update SEC initialization and reset
Date:   Fri, 26 Jun 2020 18:32:07 +0800
Message-ID: <1593167529-22463-4-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1593167529-22463-1-git-send-email-liulongfang@huawei.com>
References: <1593167529-22463-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Updates the initialization and reset of SEC driver's
register operation.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/crypto/hisilicon/qm.h            |  1 +
 drivers/crypto/hisilicon/sec2/sec_main.c | 55 ++++++++++++++++----------------
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.h b/drivers/crypto/hisilicon/qm.h
index 0a351de..6c1d3c7 100644
--- a/drivers/crypto/hisilicon/qm.h
+++ b/drivers/crypto/hisilicon/qm.h
@@ -44,6 +44,7 @@
 #define QM_AXI_M_CFG			0x1000ac
 #define AXI_M_CFG			0xffff
 #define QM_AXI_M_CFG_ENABLE		0x1000b0
+#define AM_CFG_SINGLE_PORT_MAX_TRANS	0x300014
 #define AXI_M_CFG_ENABLE		0xffffffff
 #define QM_PEH_AXUSER_CFG		0x1000cc
 #define QM_PEH_AXUSER_CFG_ENABLE	0x1000d0
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index f9c1b7d..16bb3d7 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -22,11 +22,9 @@
 #define SEC_PF_PCI_DEVICE_ID		0xa255
 #define SEC_VF_PCI_DEVICE_ID		0xa256
 
-#define SEC_XTS_MIV_ENABLE_REG		0x301384
-#define SEC_XTS_MIV_ENABLE_MSK		0x7FFFFFFF
-#define SEC_XTS_MIV_DISABLE_MSK		0xFFFFFFFF
-#define SEC_BD_ERR_CHK_EN1		0xfffff7fd
-#define SEC_BD_ERR_CHK_EN2		0xffffbfff
+#define SEC_BD_ERR_CHK_EN0		0xEFFFFFFF
+#define SEC_BD_ERR_CHK_EN1		0x7ffff7fd
+#define SEC_BD_ERR_CHK_EN3		0xffffbfff
 
 #define SEC_SQE_SIZE			128
 #define SEC_SQ_SIZE			(SEC_SQE_SIZE * QM_Q_DEPTH)
@@ -47,17 +45,18 @@
 #define SEC_ECC_ADDR(err)			((err) >> 0)
 #define SEC_CORE_INT_DISABLE		0x0
 #define SEC_CORE_INT_ENABLE		0x1ff
+#define SEC_CORE_INT_CLEAR		0x1ff
+#define SEC_SAA_ENABLE			0x17f
 
-#define SEC_RAS_CE_REG			0x50
-#define SEC_RAS_FE_REG			0x54
-#define SEC_RAS_NFE_REG			0x58
+#define SEC_RAS_CE_REG			0x301050
+#define SEC_RAS_FE_REG			0x301054
+#define SEC_RAS_NFE_REG			0x301058
 #define SEC_RAS_CE_ENB_MSK		0x88
 #define SEC_RAS_FE_ENB_MSK		0x0
 #define SEC_RAS_NFE_ENB_MSK		0x177
 #define SEC_RAS_DISABLE			0x0
 #define SEC_MEM_START_INIT_REG		0x0100
 #define SEC_MEM_INIT_DONE_REG		0x0104
-#define SEC_QM_ABNORMAL_INT_MASK	0x100004
 
 #define SEC_CONTROL_REG			0x0200
 #define SEC_TRNG_EN_SHIFT		8
@@ -68,8 +67,10 @@
 
 #define SEC_INTERFACE_USER_CTRL0_REG	0x0220
 #define SEC_INTERFACE_USER_CTRL1_REG	0x0224
+#define SEC_SAA_EN_REG					0x0270
+#define SEC_BD_ERR_CHK_EN_REG0		0x0380
 #define SEC_BD_ERR_CHK_EN_REG1		0x0384
-#define SEC_BD_ERR_CHK_EN_REG2		0x038c
+#define SEC_BD_ERR_CHK_EN_REG3		0x038c
 
 #define SEC_USER0_SMMU_NORMAL		(BIT(23) | BIT(15))
 #define SEC_USER1_SMMU_NORMAL		(BIT(31) | BIT(23) | BIT(15) | BIT(7))
@@ -77,8 +78,8 @@
 
 #define SEC_DELAY_10_US			10
 #define SEC_POLL_TIMEOUT_US		1000
-#define SEC_VF_CNT_MASK			0xffffffc0
 #define SEC_DBGFS_VAL_MAX_LEN		20
+#define SEC_SINGLE_PORT_MAX_TRANS	0x2060
 
 #define SEC_SQE_MASK_OFFSET		64
 #define SEC_SQE_MASK_LEN		48
@@ -297,25 +298,25 @@ static int sec_engine_init(struct hisi_qm *qm)
 	reg |= SEC_USER1_SMMU_NORMAL;
 	writel_relaxed(reg, SEC_ADDR(qm, SEC_INTERFACE_USER_CTRL1_REG));
 
+	writel(SEC_SINGLE_PORT_MAX_TRANS,
+	       qm->io_base + AM_CFG_SINGLE_PORT_MAX_TRANS);
+
+	writel(SEC_SAA_ENABLE, SEC_ADDR(qm, SEC_SAA_EN_REG));
+
+	/* Enable sm4 extra mode, as ctr/ecb */
+	writel_relaxed(SEC_BD_ERR_CHK_EN0,
+		       SEC_ADDR(qm, SEC_BD_ERR_CHK_EN_REG0));
+	/* Enable sm4 xts mode multiple iv */
 	writel_relaxed(SEC_BD_ERR_CHK_EN1,
 		       SEC_ADDR(qm, SEC_BD_ERR_CHK_EN_REG1));
-	writel_relaxed(SEC_BD_ERR_CHK_EN2,
-		       SEC_ADDR(qm, SEC_BD_ERR_CHK_EN_REG2));
-
-	/* enable clock gate control */
-	reg = readl_relaxed(SEC_ADDR(qm, SEC_CONTROL_REG));
-	reg |= SEC_CLK_GATE_ENABLE;
-	writel_relaxed(reg, SEC_ADDR(qm, SEC_CONTROL_REG));
+	writel_relaxed(SEC_BD_ERR_CHK_EN3,
+		       SEC_ADDR(qm, SEC_BD_ERR_CHK_EN_REG3));
 
 	/* config endian */
 	reg = readl_relaxed(SEC_ADDR(qm, SEC_CONTROL_REG));
 	reg |= sec_get_endian(qm);
 	writel_relaxed(reg, SEC_ADDR(qm, SEC_CONTROL_REG));
 
-	/* Enable sm4 xts mode multiple iv */
-	writel_relaxed(SEC_XTS_MIV_ENABLE_MSK,
-		       qm->io_base + SEC_XTS_MIV_ENABLE_REG);
-
 	return 0;
 }
 
@@ -374,10 +375,10 @@ static void sec_hw_error_enable(struct hisi_qm *qm)
 		return;
 	}
 
-	val = readl(qm->io_base + SEC_CONTROL_REG);
+	val = readl(SEC_ADDR(qm, SEC_CONTROL_REG));
 
 	/* clear SEC hw error source if having */
-	writel(SEC_CORE_INT_DISABLE, qm->io_base + SEC_CORE_INT_SOURCE);
+	writel(SEC_CORE_INT_CLEAR, qm->io_base + SEC_CORE_INT_SOURCE);
 
 	/* enable SEC hw error interrupts */
 	writel(SEC_CORE_INT_ENABLE, qm->io_base + SEC_CORE_INT_MASK);
@@ -390,14 +391,14 @@ static void sec_hw_error_enable(struct hisi_qm *qm)
 	/* enable SEC block master OOO when m-bit error occur */
 	val = val | SEC_AXI_SHUTDOWN_ENABLE;
 
-	writel(val, qm->io_base + SEC_CONTROL_REG);
+	writel(val, SEC_ADDR(qm, SEC_CONTROL_REG));
 }
 
 static void sec_hw_error_disable(struct hisi_qm *qm)
 {
 	u32 val;
 
-	val = readl(qm->io_base + SEC_CONTROL_REG);
+	val = readl(SEC_ADDR(qm, SEC_CONTROL_REG));
 
 	/* disable RAS int */
 	writel(SEC_RAS_DISABLE, qm->io_base + SEC_RAS_CE_REG);
@@ -410,7 +411,7 @@ static void sec_hw_error_disable(struct hisi_qm *qm)
 	/* disable SEC block master OOO when m-bit error occur */
 	val = val & SEC_AXI_SHUTDOWN_DISABLE;
 
-	writel(val, qm->io_base + SEC_CONTROL_REG);
+	writel(val, SEC_ADDR(qm, SEC_CONTROL_REG));
 }
 
 static u32 sec_current_qm_read(struct sec_debug_file *file)
-- 
2.8.1


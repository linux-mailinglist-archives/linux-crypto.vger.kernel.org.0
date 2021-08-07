Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4BB33E33C5
	for <lists+linux-crypto@lfdr.de>; Sat,  7 Aug 2021 08:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhHGGdP (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 7 Aug 2021 02:33:15 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13399 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhHGGdO (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 7 Aug 2021 02:33:14 -0400
Received: from dggeme768-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GhXW35Ys5zclFR;
        Sat,  7 Aug 2021 14:29:19 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 dggeme768-chm.china.huawei.com (10.3.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 7 Aug 2021 14:32:55 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 2/3] crypto: hisilicon - enable sec device clock gating
Date:   Sat, 7 Aug 2021 14:29:10 +0800
Message-ID: <1628317751-3396-3-git-send-email-qianweili@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1628317751-3396-1-git-send-email-qianweili@huawei.com>
References: <1628317751-3396-1-git-send-email-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme768-chm.china.huawei.com (10.3.19.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Kunpeng930 sec device supports dynamic clock gating. When doing tasks,
the algorithm core is opened, and when idle, the algorithm core is closed.
This patch enables sec dynamic clock gating by writing hardware registers.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_main.c | 46 ++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 490db7b..db4dbcf 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -57,10 +57,16 @@
 #define SEC_MEM_START_INIT_REG	0x301100
 #define SEC_MEM_INIT_DONE_REG		0x301104
 
+/* clock gating */
 #define SEC_CONTROL_REG		0x301200
-#define SEC_TRNG_EN_SHIFT		8
+#define SEC_DYNAMIC_GATE_REG		0x30121c
+#define SEC_CORE_AUTO_GATE		0x30212c
+#define SEC_DYNAMIC_GATE_EN		0x7bff
+#define SEC_CORE_AUTO_GATE_EN		GENMASK(3, 0)
 #define SEC_CLK_GATE_ENABLE		BIT(3)
 #define SEC_CLK_GATE_DISABLE		(~BIT(3))
+
+#define SEC_TRNG_EN_SHIFT		8
 #define SEC_AXI_SHUTDOWN_ENABLE	BIT(12)
 #define SEC_AXI_SHUTDOWN_DISABLE	0xFFFFEFFF
 
@@ -378,15 +384,43 @@ static void sec_close_sva_prefetch(struct hisi_qm *qm)
 		pci_err(qm->pdev, "failed to close sva prefetch\n");
 }
 
+static void sec_enable_clock_gate(struct hisi_qm *qm)
+{
+	u32 val;
+
+	if (qm->ver < QM_HW_V3)
+		return;
+
+	val = readl_relaxed(qm->io_base + SEC_CONTROL_REG);
+	val |= SEC_CLK_GATE_ENABLE;
+	writel_relaxed(val, qm->io_base + SEC_CONTROL_REG);
+
+	val = readl(qm->io_base + SEC_DYNAMIC_GATE_REG);
+	val |= SEC_DYNAMIC_GATE_EN;
+	writel(val, qm->io_base + SEC_DYNAMIC_GATE_REG);
+
+	val = readl(qm->io_base + SEC_CORE_AUTO_GATE);
+	val |= SEC_CORE_AUTO_GATE_EN;
+	writel(val, qm->io_base + SEC_CORE_AUTO_GATE);
+}
+
+static void sec_disable_clock_gate(struct hisi_qm *qm)
+{
+	u32 val;
+
+	/* Kunpeng920 needs to close clock gating */
+	val = readl_relaxed(qm->io_base + SEC_CONTROL_REG);
+	val &= SEC_CLK_GATE_DISABLE;
+	writel_relaxed(val, qm->io_base + SEC_CONTROL_REG);
+}
+
 static int sec_engine_init(struct hisi_qm *qm)
 {
 	int ret;
 	u32 reg;
 
-	/* disable clock gate control */
-	reg = readl_relaxed(qm->io_base + SEC_CONTROL_REG);
-	reg &= SEC_CLK_GATE_DISABLE;
-	writel_relaxed(reg, qm->io_base + SEC_CONTROL_REG);
+	/* disable clock gate control before mem init */
+	sec_disable_clock_gate(qm);
 
 	writel_relaxed(0x1, qm->io_base + SEC_MEM_START_INIT_REG);
 
@@ -433,6 +467,8 @@ static int sec_engine_init(struct hisi_qm *qm)
 	reg |= sec_get_endian(qm);
 	writel_relaxed(reg, qm->io_base + SEC_CONTROL_REG);
 
+	sec_enable_clock_gate(qm);
+
 	return 0;
 }
 
-- 
2.8.1


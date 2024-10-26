Return-Path: <linux-crypto+bounces-7683-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4169B169A
	for <lists+linux-crypto@lfdr.de>; Sat, 26 Oct 2024 11:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0AC1C20A41
	for <lists+linux-crypto@lfdr.de>; Sat, 26 Oct 2024 09:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3624618562F;
	Sat, 26 Oct 2024 09:47:02 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF8E13792B;
	Sat, 26 Oct 2024 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729936022; cv=none; b=ihzvMd06ZqDnu5/loMcFYRlNau5dPk7FDORnhkbRqp8fhtMwmLcFyv/A8KfdOBFew7ROuouh357q3Yn8Hps4NibnKS/g5t1l0pyclGlPqYs4bRB10SrfahGUWSwfLMjrKk3pV1LbltPO0lbp2+mpsmlw81ff/Uj+MSiuW8o86W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729936022; c=relaxed/simple;
	bh=DzZJt6wo71aC9xueuapBZPmpBn9XSo8Bjbc/WYBiaw4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RxE0omgpiKexqQtLHr2Tt5oXGKc4kv8vPW6E4aKpVbolOChnyNSsj/e0mrmbu93uSoDkI5xPH4VZ4dHZjTCUQIBZ1iC5A0A7DqZgU3V4QmVT4lB9LLWIMMMg9zDajaN12Vcnzd7QqTRevUU49mEGcB5K2u6F+EyIz0er0btXjZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XbF9K3rgQzdkLb;
	Sat, 26 Oct 2024 17:44:21 +0800 (CST)
Received: from kwepemd200024.china.huawei.com (unknown [7.221.188.85])
	by mail.maildlp.com (Postfix) with ESMTPS id 3ACB41402C7;
	Sat, 26 Oct 2024 17:46:53 +0800 (CST)
Received: from localhost.huawei.com (10.90.30.45) by
 kwepemd200024.china.huawei.com (7.221.188.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 26 Oct 2024 17:46:52 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<liulongfang@huawei.com>, <shenyang39@huawei.com>, <qianweili@huawei.com>,
	<taoqi10@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH] crypto: hisilicon - support querying the capability register
Date: Sat, 26 Oct 2024 17:46:51 +0800
Message-ID: <20241026094651.1648131-1-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200024.china.huawei.com (7.221.188.85)

From: Qi Tao <taoqi10@huawei.com>

Query the capability register status of accelerator devices
(SEC, HPRE and ZIP) through the debugfs interface, for example:
cat cap_regs. The purpose is to improve the robustness and
locability of hardware devices and drivers.

Signed-off-by: Qi Tao <taoqi10@huawei.com>
Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 Documentation/ABI/testing/debugfs-hisi-hpre |   7 ++
 Documentation/ABI/testing/debugfs-hisi-sec  |   7 ++
 Documentation/ABI/testing/debugfs-hisi-zip  |   7 ++
 drivers/crypto/hisilicon/hpre/hpre.h        |  23 ++++
 drivers/crypto/hisilicon/hpre/hpre_main.c   | 121 +++++++++++++++-----
 drivers/crypto/hisilicon/qm.c               |  88 +++++++++-----
 drivers/crypto/hisilicon/sec2/sec.h         |  26 ++++-
 drivers/crypto/hisilicon/sec2/sec_crypto.c  |   8 +-
 drivers/crypto/hisilicon/sec2/sec_main.c    |  71 ++++++++++--
 drivers/crypto/hisilicon/zip/zip.h          |  18 +++
 drivers/crypto/hisilicon/zip/zip_main.c     | 116 +++++++++++++------
 include/linux/hisi_acc_qm.h                 |  15 +++
 12 files changed, 396 insertions(+), 111 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-hisi-hpre b/Documentation/ABI/testing/debugfs-hisi-hpre
index d4e16ef9ac9a..29fb7d5ffc69 100644
--- a/Documentation/ABI/testing/debugfs-hisi-hpre
+++ b/Documentation/ABI/testing/debugfs-hisi-hpre
@@ -184,3 +184,10 @@ Date:		Apr 2020
 Contact:	linux-crypto@vger.kernel.org
 Description:	Dump the total number of time out requests.
 		Available for both PF and VF, and take no other effect on HPRE.
+
+What:           /sys/kernel/debug/hisi_hpre/<bdf>/cap_regs
+Date:           Oct 2024
+Contact:        linux-crypto@vger.kernel.org
+Description:    Dump the values of the qm and hpre capability bit registers and
+                support the query of device specifications to facilitate fault locating.
+                Available for both PF and VF, and take no other effect on HPRE.
diff --git a/Documentation/ABI/testing/debugfs-hisi-sec b/Documentation/ABI/testing/debugfs-hisi-sec
index 6c6c9a6e150a..82bf4a0dc7f7 100644
--- a/Documentation/ABI/testing/debugfs-hisi-sec
+++ b/Documentation/ABI/testing/debugfs-hisi-sec
@@ -157,3 +157,10 @@ Contact:	linux-crypto@vger.kernel.org
 Description:	Dump the total number of completed but marked error requests
 		to be received.
 		Available for both PF and VF, and take no other effect on SEC.
+
+What:           /sys/kernel/debug/hisi_sec2/<bdf>/cap_regs
+Date:           Oct 2024
+Contact:        linux-crypto@vger.kernel.org
+Description:    Dump the values of the qm and sec capability bit registers and
+                support the query of device specifications to facilitate fault locating.
+                Available for both PF and VF, and take no other effect on SEC.
diff --git a/Documentation/ABI/testing/debugfs-hisi-zip b/Documentation/ABI/testing/debugfs-hisi-zip
index a22dd6942219..0abd65d27e9b 100644
--- a/Documentation/ABI/testing/debugfs-hisi-zip
+++ b/Documentation/ABI/testing/debugfs-hisi-zip
@@ -158,3 +158,10 @@ Contact:	linux-crypto@vger.kernel.org
 Description:	Dump the total number of BD type error requests
 		to be received.
 		Available for both PF and VF, and take no other effect on ZIP.
+
+What:           /sys/kernel/debug/hisi_zip/<bdf>/cap_regs
+Date:           Oct 2024
+Contact:        linux-crypto@vger.kernel.org
+Description:    Dump the values of the qm and zip capability bit registers and
+                support the query of device specifications to facilitate fault locating.
+                Available for both PF and VF, and take no other effect on ZIP.
diff --git a/drivers/crypto/hisilicon/hpre/hpre.h b/drivers/crypto/hisilicon/hpre/hpre.h
index 9f0b94c8e03d..0f3ddbadbcf9 100644
--- a/drivers/crypto/hisilicon/hpre/hpre.h
+++ b/drivers/crypto/hisilicon/hpre/hpre.h
@@ -100,6 +100,29 @@ struct hpre_sqe {
 	__le32 rsvd1[_HPRE_SQE_ALIGN_EXT];
 };
 
+enum hpre_cap_table_type {
+	QM_RAS_NFE_TYPE = 0x0,
+	QM_RAS_NFE_RESET,
+	QM_RAS_CE_TYPE,
+	HPRE_RAS_NFE_TYPE,
+	HPRE_RAS_NFE_RESET,
+	HPRE_RAS_CE_TYPE,
+	HPRE_CORE_INFO,
+	HPRE_CORE_EN,
+	HPRE_DRV_ALG_BITMAP,
+	HPRE_ALG_BITMAP,
+	HPRE_CORE1_BITMAP_CAP,
+	HPRE_CORE2_BITMAP_CAP,
+	HPRE_CORE3_BITMAP_CAP,
+	HPRE_CORE4_BITMAP_CAP,
+	HPRE_CORE5_BITMAP_CAP,
+	HPRE_CORE6_BITMAP_CAP,
+	HPRE_CORE7_BITMAP_CAP,
+	HPRE_CORE8_BITMAP_CAP,
+	HPRE_CORE9_BITMAP_CAP,
+	HPRE_CORE10_BITMAP_CAP,
+};
+
 struct hisi_qp *hpre_create_qp(u8 type);
 int hpre_algs_register(struct hisi_qm *qm);
 void hpre_algs_unregister(struct hisi_qm *qm);
diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index f129878559c8..c5de1f6b6d3b 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -13,6 +13,7 @@
 #include <linux/uacce.h>
 #include "hpre.h"
 
+#define CAP_FILE_PERMISSION		0444
 #define HPRE_CTRL_CNT_CLR_CE_BIT	BIT(0)
 #define HPRE_CTRL_CNT_CLR_CE		0x301000
 #define HPRE_FSM_MAX_CNT		0x301008
@@ -203,7 +204,7 @@ static const struct hisi_qm_cap_info hpre_basic_info[] = {
 	{HPRE_RESET_MASK_CAP, 0x3134, 0, GENMASK(31, 0), 0x0, 0x3FFFFE, 0xBFFC3E},
 	{HPRE_OOO_SHUTDOWN_MASK_CAP, 0x3134, 0, GENMASK(31, 0), 0x0, 0x22, 0xBFFC3E},
 	{HPRE_CE_MASK_CAP, 0x3138, 0, GENMASK(31, 0), 0x0, 0x1, 0x1},
-	{HPRE_CLUSTER_NUM_CAP, 0x313c, 20, GENMASK(3, 0), 0x0,  0x4, 0x1},
+	{HPRE_CLUSTER_NUM_CAP, 0x313c, 20, GENMASK(3, 0), 0x0, 0x4, 0x1},
 	{HPRE_CORE_TYPE_NUM_CAP, 0x313c, 16, GENMASK(3, 0), 0x0, 0x2, 0x2},
 	{HPRE_CORE_NUM_CAP, 0x313c, 8, GENMASK(7, 0), 0x0, 0x8, 0xA},
 	{HPRE_CLUSTER_CORE_NUM_CAP, 0x313c, 0, GENMASK(7, 0), 0x0, 0x2, 0xA},
@@ -222,18 +223,27 @@ static const struct hisi_qm_cap_info hpre_basic_info[] = {
 	{HPRE_CORE10_ALG_BITMAP_CAP, 0x3170, 0, GENMASK(31, 0), 0x0, 0x10, 0x10}
 };
 
-enum hpre_pre_store_cap_idx {
-	HPRE_CLUSTER_NUM_CAP_IDX = 0x0,
-	HPRE_CORE_ENABLE_BITMAP_CAP_IDX,
-	HPRE_DRV_ALG_BITMAP_CAP_IDX,
-	HPRE_DEV_ALG_BITMAP_CAP_IDX,
-};
-
-static const u32 hpre_pre_store_caps[] = {
-	HPRE_CLUSTER_NUM_CAP,
-	HPRE_CORE_ENABLE_BITMAP_CAP,
-	HPRE_DRV_ALG_BITMAP_CAP,
-	HPRE_DEV_ALG_BITMAP_CAP,
+static const struct hisi_qm_cap_query_info hpre_cap_query_info[] = {
+	{QM_RAS_NFE_TYPE, "QM_RAS_NFE_TYPE             ", 0x3124, 0x0, 0x1C37, 0x7C37},
+	{QM_RAS_NFE_RESET, "QM_RAS_NFE_RESET            ", 0x3128, 0x0, 0xC77, 0x6C77},
+	{QM_RAS_CE_TYPE, "QM_RAS_CE_TYPE              ", 0x312C, 0x0, 0x8, 0x8},
+	{HPRE_RAS_NFE_TYPE, "HPRE_RAS_NFE_TYPE           ", 0x3130, 0x0, 0x3FFFFE, 0x1FFFC3E},
+	{HPRE_RAS_NFE_RESET, "HPRE_RAS_NFE_RESET          ", 0x3134, 0x0, 0x3FFFFE, 0xBFFC3E},
+	{HPRE_RAS_CE_TYPE, "HPRE_RAS_CE_TYPE            ", 0x3138, 0x0, 0x1, 0x1},
+	{HPRE_CORE_INFO, "HPRE_CORE_INFO              ", 0x313c, 0x0, 0x420802, 0x120A0A},
+	{HPRE_CORE_EN, "HPRE_CORE_EN                ", 0x3140, 0x0, 0xF, 0x3FF},
+	{HPRE_DRV_ALG_BITMAP, "HPRE_DRV_ALG_BITMAP         ", 0x3144, 0x0, 0x03, 0x27},
+	{HPRE_ALG_BITMAP, "HPRE_ALG_BITMAP             ", 0x3148, 0x0, 0x03, 0x7F},
+	{HPRE_CORE1_BITMAP_CAP, "HPRE_CORE1_BITMAP_CAP       ", 0x314c, 0x0, 0x7F, 0x7F},
+	{HPRE_CORE2_BITMAP_CAP, "HPRE_CORE2_BITMAP_CAP       ", 0x3150, 0x0, 0x7F, 0x7F},
+	{HPRE_CORE3_BITMAP_CAP, "HPRE_CORE3_BITMAP_CAP       ", 0x3154, 0x0, 0x7F, 0x7F},
+	{HPRE_CORE4_BITMAP_CAP, "HPRE_CORE4_BITMAP_CAP       ", 0x3158, 0x0, 0x7F, 0x7F},
+	{HPRE_CORE5_BITMAP_CAP, "HPRE_CORE5_BITMAP_CAP       ", 0x315c, 0x0, 0x7F, 0x7F},
+	{HPRE_CORE6_BITMAP_CAP, "HPRE_CORE6_BITMAP_CAP       ", 0x3160, 0x0, 0x7F, 0x7F},
+	{HPRE_CORE7_BITMAP_CAP, "HPRE_CORE7_BITMAP_CAP       ", 0x3164, 0x0, 0x7F, 0x7F},
+	{HPRE_CORE8_BITMAP_CAP, "HPRE_CORE8_BITMAP_CAP       ", 0x3168, 0x0, 0x7F, 0x7F},
+	{HPRE_CORE9_BITMAP_CAP, "HPRE_CORE9_BITMAP_CAP       ", 0x316c, 0x0, 0x10, 0x10},
+	{HPRE_CORE10_BITMAP_CAP, "HPRE_CORE10_BITMAP_CAP      ", 0x3170, 0x0, 0x10, 0x10},
 };
 
 static const struct hpre_hw_error hpre_hw_errors[] = {
@@ -360,7 +370,7 @@ bool hpre_check_alg_support(struct hisi_qm *qm, u32 alg)
 {
 	u32 cap_val;
 
-	cap_val = qm->cap_tables.dev_cap_table[HPRE_DRV_ALG_BITMAP_CAP_IDX].cap_val;
+	cap_val = qm->cap_tables.dev_cap_table[HPRE_DRV_ALG_BITMAP].cap_val;
 	if (alg & cap_val)
 		return true;
 
@@ -503,14 +513,17 @@ static int hpre_cfg_by_dsm(struct hisi_qm *qm)
 static int hpre_set_cluster(struct hisi_qm *qm)
 {
 	struct device *dev = &qm->pdev->dev;
-	unsigned long offset;
 	u32 cluster_core_mask;
+	unsigned long offset;
+	u32 hpre_core_info;
 	u8 clusters_num;
 	u32 val = 0;
 	int ret, i;
 
-	cluster_core_mask = qm->cap_tables.dev_cap_table[HPRE_CORE_ENABLE_BITMAP_CAP_IDX].cap_val;
-	clusters_num = qm->cap_tables.dev_cap_table[HPRE_CLUSTER_NUM_CAP_IDX].cap_val;
+	cluster_core_mask = qm->cap_tables.dev_cap_table[HPRE_CORE_EN].cap_val;
+	hpre_core_info = qm->cap_tables.dev_cap_table[HPRE_CORE_INFO].cap_val;
+	clusters_num = (hpre_core_info >> hpre_basic_info[HPRE_CLUSTER_NUM_CAP].shift) &
+			hpre_basic_info[HPRE_CLUSTER_NUM_CAP].mask;
 	for (i = 0; i < clusters_num; i++) {
 		offset = i * HPRE_CLSTR_ADDR_INTRVL;
 
@@ -595,6 +608,7 @@ static void hpre_enable_clock_gate(struct hisi_qm *qm)
 {
 	unsigned long offset;
 	u8 clusters_num, i;
+	u32 hpre_core_info;
 	u32 val;
 
 	if (qm->ver < QM_HW_V3)
@@ -608,7 +622,9 @@ static void hpre_enable_clock_gate(struct hisi_qm *qm)
 	val |= HPRE_PEH_CFG_AUTO_GATE_EN;
 	writel(val, qm->io_base + HPRE_PEH_CFG_AUTO_GATE);
 
-	clusters_num = qm->cap_tables.dev_cap_table[HPRE_CLUSTER_NUM_CAP_IDX].cap_val;
+	hpre_core_info = qm->cap_tables.dev_cap_table[HPRE_CORE_INFO].cap_val;
+	clusters_num = (hpre_core_info >> hpre_basic_info[HPRE_CLUSTER_NUM_CAP].shift) &
+			hpre_basic_info[HPRE_CLUSTER_NUM_CAP].mask;
 	for (i = 0; i < clusters_num; i++) {
 		offset = (unsigned long)i * HPRE_CLSTR_ADDR_INTRVL;
 		val = readl(qm->io_base + offset + HPRE_CLUSTER_DYN_CTL);
@@ -625,6 +641,7 @@ static void hpre_disable_clock_gate(struct hisi_qm *qm)
 {
 	unsigned long offset;
 	u8 clusters_num, i;
+	u32 hpre_core_info;
 	u32 val;
 
 	if (qm->ver < QM_HW_V3)
@@ -638,7 +655,9 @@ static void hpre_disable_clock_gate(struct hisi_qm *qm)
 	val &= ~HPRE_PEH_CFG_AUTO_GATE_EN;
 	writel(val, qm->io_base + HPRE_PEH_CFG_AUTO_GATE);
 
-	clusters_num = qm->cap_tables.dev_cap_table[HPRE_CLUSTER_NUM_CAP_IDX].cap_val;
+	hpre_core_info = qm->cap_tables.dev_cap_table[HPRE_CORE_INFO].cap_val;
+	clusters_num = (hpre_core_info >> hpre_basic_info[HPRE_CLUSTER_NUM_CAP].shift) &
+			hpre_basic_info[HPRE_CLUSTER_NUM_CAP].mask;
 	for (i = 0; i < clusters_num; i++) {
 		offset = (unsigned long)i * HPRE_CLSTR_ADDR_INTRVL;
 		val = readl(qm->io_base + offset + HPRE_CLUSTER_DYN_CTL);
@@ -711,11 +730,14 @@ static int hpre_set_user_domain_and_cache(struct hisi_qm *qm)
 static void hpre_cnt_regs_clear(struct hisi_qm *qm)
 {
 	unsigned long offset;
+	u32 hpre_core_info;
 	u8 clusters_num;
 	int i;
 
 	/* clear clusterX/cluster_ctrl */
-	clusters_num = qm->cap_tables.dev_cap_table[HPRE_CLUSTER_NUM_CAP_IDX].cap_val;
+	hpre_core_info = qm->cap_tables.dev_cap_table[HPRE_CORE_INFO].cap_val;
+	clusters_num = (hpre_core_info >> hpre_basic_info[HPRE_CLUSTER_NUM_CAP].shift) &
+			hpre_basic_info[HPRE_CLUSTER_NUM_CAP].mask;
 	for (i = 0; i < clusters_num; i++) {
 		offset = HPRE_CLSTR_BASE + i * HPRE_CLSTR_ADDR_INTRVL;
 		writel(0x0, qm->io_base + offset + HPRE_CLUSTER_INQURY);
@@ -1007,10 +1029,13 @@ static int hpre_cluster_debugfs_init(struct hisi_qm *qm)
 	char buf[HPRE_DBGFS_VAL_MAX_LEN];
 	struct debugfs_regset32 *regset;
 	struct dentry *tmp_d;
+	u32 hpre_core_info;
 	u8 clusters_num;
 	int i, ret;
 
-	clusters_num = qm->cap_tables.dev_cap_table[HPRE_CLUSTER_NUM_CAP_IDX].cap_val;
+	hpre_core_info = qm->cap_tables.dev_cap_table[HPRE_CORE_INFO].cap_val;
+	clusters_num = (hpre_core_info >> hpre_basic_info[HPRE_CLUSTER_NUM_CAP].shift) &
+			hpre_basic_info[HPRE_CLUSTER_NUM_CAP].mask;
 	for (i = 0; i < clusters_num; i++) {
 		ret = snprintf(buf, HPRE_DBGFS_VAL_MAX_LEN, "cluster%d", i);
 		if (ret >= HPRE_DBGFS_VAL_MAX_LEN)
@@ -1053,6 +1078,26 @@ static int hpre_ctrl_debug_init(struct hisi_qm *qm)
 	return hpre_cluster_debugfs_init(qm);
 }
 
+static int hpre_cap_regs_show(struct seq_file *s, void *unused)
+{
+	struct hisi_qm *qm = s->private;
+	u32 i, size;
+
+	size = qm->cap_tables.qm_cap_size;
+	for (i = 0; i < size; i++)
+		seq_printf(s, "%s= 0x%08x\n", qm->cap_tables.qm_cap_table[i].name,
+			   qm->cap_tables.qm_cap_table[i].cap_val);
+
+	size = qm->cap_tables.dev_cap_size;
+	for (i = 0; i < size; i++)
+		seq_printf(s, "%s= 0x%08x\n", qm->cap_tables.dev_cap_table[i].name,
+			   qm->cap_tables.dev_cap_table[i].cap_val);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(hpre_cap_regs);
+
 static void hpre_dfx_debug_init(struct hisi_qm *qm)
 {
 	struct dfx_diff_registers *hpre_regs = qm->debug.acc_diff_regs;
@@ -1071,6 +1116,9 @@ static void hpre_dfx_debug_init(struct hisi_qm *qm)
 	if (qm->fun_type == QM_HW_PF && hpre_regs)
 		debugfs_create_file("diff_regs", 0444, parent,
 				      qm, &hpre_diff_regs_fops);
+
+	debugfs_create_file("cap_regs", CAP_FILE_PERMISSION,
+			    qm->debug.debug_root, qm, &hpre_cap_regs_fops);
 }
 
 static int hpre_debugfs_init(struct hisi_qm *qm)
@@ -1118,26 +1166,33 @@ static int hpre_pre_store_cap_reg(struct hisi_qm *qm)
 {
 	struct hisi_qm_cap_record *hpre_cap;
 	struct device *dev = &qm->pdev->dev;
+	u32 hpre_core_info;
+	u8 clusters_num;
 	size_t i, size;
 
-	size = ARRAY_SIZE(hpre_pre_store_caps);
+	size = ARRAY_SIZE(hpre_cap_query_info);
 	hpre_cap = devm_kzalloc(dev, sizeof(*hpre_cap) * size, GFP_KERNEL);
 	if (!hpre_cap)
 		return -ENOMEM;
 
 	for (i = 0; i < size; i++) {
-		hpre_cap[i].type = hpre_pre_store_caps[i];
-		hpre_cap[i].cap_val = hisi_qm_get_hw_info(qm, hpre_basic_info,
-				      hpre_pre_store_caps[i], qm->cap_ver);
+		hpre_cap[i].type = hpre_cap_query_info[i].type;
+		hpre_cap[i].name = hpre_cap_query_info[i].name;
+		hpre_cap[i].cap_val = hisi_qm_get_cap_value(qm, hpre_cap_query_info,
+					i, qm->cap_ver);
 	}
 
-	if (hpre_cap[HPRE_CLUSTER_NUM_CAP_IDX].cap_val > HPRE_CLUSTERS_NUM_MAX) {
+	hpre_core_info = hpre_cap[HPRE_CORE_INFO].cap_val;
+	clusters_num = (hpre_core_info >> hpre_basic_info[HPRE_CLUSTER_NUM_CAP].shift) &
+			hpre_basic_info[HPRE_CLUSTER_NUM_CAP].mask;
+	if (clusters_num > HPRE_CLUSTERS_NUM_MAX) {
 		dev_err(dev, "Device cluster num %u is out of range for driver supports %d!\n",
-			hpre_cap[HPRE_CLUSTER_NUM_CAP_IDX].cap_val, HPRE_CLUSTERS_NUM_MAX);
+			clusters_num, HPRE_CLUSTERS_NUM_MAX);
 		return -EINVAL;
 	}
 
 	qm->cap_tables.dev_cap_table = hpre_cap;
+	qm->cap_tables.dev_cap_size = size;
 
 	return 0;
 }
@@ -1184,7 +1239,7 @@ static int hpre_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		return ret;
 	}
 
-	alg_msk = qm->cap_tables.dev_cap_table[HPRE_DEV_ALG_BITMAP_CAP_IDX].cap_val;
+	alg_msk = qm->cap_tables.dev_cap_table[HPRE_ALG_BITMAP].cap_val;
 	ret = hisi_qm_set_algs(qm, alg_msk, hpre_dev_algs, ARRAY_SIZE(hpre_dev_algs));
 	if (ret) {
 		pci_err(pdev, "Failed to set hpre algs!\n");
@@ -1200,10 +1255,13 @@ static int hpre_show_last_regs_init(struct hisi_qm *qm)
 	int com_dfx_regs_num = ARRAY_SIZE(hpre_com_dfx_regs);
 	struct qm_debug *debug = &qm->debug;
 	void __iomem *io_base;
+	u32 hpre_core_info;
 	u8 clusters_num;
 	int i, j, idx;
 
-	clusters_num = qm->cap_tables.dev_cap_table[HPRE_CLUSTER_NUM_CAP_IDX].cap_val;
+	hpre_core_info = qm->cap_tables.dev_cap_table[HPRE_CORE_INFO].cap_val;
+	clusters_num = (hpre_core_info >> hpre_basic_info[HPRE_CLUSTER_NUM_CAP].shift) &
+			hpre_basic_info[HPRE_CLUSTER_NUM_CAP].mask;
 	debug->last_words = kcalloc(cluster_dfx_regs_num * clusters_num +
 			com_dfx_regs_num, sizeof(unsigned int), GFP_KERNEL);
 	if (!debug->last_words)
@@ -1243,6 +1301,7 @@ static void hpre_show_last_dfx_regs(struct hisi_qm *qm)
 	struct qm_debug *debug = &qm->debug;
 	struct pci_dev *pdev = qm->pdev;
 	void __iomem *io_base;
+	u32 hpre_core_info;
 	u8 clusters_num;
 	int i, j, idx;
 	u32 val;
@@ -1258,7 +1317,9 @@ static void hpre_show_last_dfx_regs(struct hisi_qm *qm)
 			  hpre_com_dfx_regs[i].name, debug->last_words[i], val);
 	}
 
-	clusters_num = qm->cap_tables.dev_cap_table[HPRE_CLUSTER_NUM_CAP_IDX].cap_val;
+	hpre_core_info = qm->cap_tables.dev_cap_table[HPRE_CORE_INFO].cap_val;
+	clusters_num = (hpre_core_info >> hpre_basic_info[HPRE_CLUSTER_NUM_CAP].shift) &
+			hpre_basic_info[HPRE_CLUSTER_NUM_CAP].mask;
 	for (i = 0; i < clusters_num; i++) {
 		io_base = qm->io_base + hpre_cluster_offsets[i];
 		for (j = 0; j <  cluster_dfx_regs_num; j++) {
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index f7e8237e3a93..1cdda09ee817 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -307,11 +307,29 @@ enum qm_basic_type {
 	QM_VF_IRQ_NUM_CAP,
 };
 
-enum qm_pre_store_cap_idx {
-	QM_EQ_IRQ_TYPE_CAP_IDX = 0x0,
-	QM_AEQ_IRQ_TYPE_CAP_IDX,
-	QM_ABN_IRQ_TYPE_CAP_IDX,
-	QM_PF2VF_IRQ_TYPE_CAP_IDX,
+enum qm_cap_table_type {
+	QM_CAP_VF  = 0x0,
+	QM_AEQE_NUM,
+	QM_SCQE_NUM,
+	QM_EQ_IRQ,
+	QM_AEQ_IRQ,
+	QM_ABNORMAL_IRQ,
+	QM_MB_IRQ,
+	MAX_IRQ_NUM,
+	EXT_BAR_INDEX,
+};
+
+static const struct hisi_qm_cap_query_info qm_cap_query_info[] = {
+	{QM_CAP_VF, "QM_CAP_VF                   ", 0x3100, 0x0, 0x0, 0x6F01},
+	{QM_AEQE_NUM, "QM_AEQE_NUM                 ", 0x3104, 0x800, 0x4000800, 0x4000800},
+	{QM_SCQE_NUM, "QM_SCQE_NUM                 ",
+						0x3108, 0x4000400, 0x4000400, 0x4000400},
+	{QM_EQ_IRQ, "QM_EQ_IRQ                   ", 0x310c, 0x10000, 0x10000, 0x10000},
+	{QM_AEQ_IRQ, "QM_AEQ_IRQ                  ", 0x3110, 0x0, 0x10001, 0x10001},
+	{QM_ABNORMAL_IRQ, "QM_ABNORMAL_IRQ             ", 0x3114, 0x0, 0x10003, 0x10003},
+	{QM_MB_IRQ, "QM_MB_IRQ                   ", 0x3118, 0x0, 0x0, 0x10002},
+	{MAX_IRQ_NUM, "MAX_IRQ_NUM                 ", 0x311c, 0x10001, 0x40002, 0x40003},
+	{EXT_BAR_INDEX, "EXT_BAR_INDEX               ", 0x3120, 0x0, 0x0, 0x14},
 };
 
 static const struct hisi_qm_cap_info qm_cap_info_comm[] = {
@@ -344,13 +362,6 @@ static const struct hisi_qm_cap_info qm_basic_info[] = {
 	{QM_VF_IRQ_NUM_CAP,     0x311c,   0,  GENMASK(15, 0), 0x1,       0x2,       0x3},
 };
 
-static const u32 qm_pre_store_caps[] = {
-	QM_EQ_IRQ_TYPE_CAP,
-	QM_AEQ_IRQ_TYPE_CAP,
-	QM_ABN_IRQ_TYPE_CAP,
-	QM_PF2VF_IRQ_TYPE_CAP,
-};
-
 struct qm_mailbox {
 	__le16 w0;
 	__le16 queue_num;
@@ -794,6 +805,27 @@ u32 hisi_qm_get_hw_info(struct hisi_qm *qm,
 }
 EXPORT_SYMBOL_GPL(hisi_qm_get_hw_info);
 
+u32 hisi_qm_get_cap_value(struct hisi_qm *qm,
+			const struct hisi_qm_cap_query_info *info_table,
+			u32 index, bool is_read)
+{
+	u32 val;
+
+	switch (qm->ver) {
+	case QM_HW_V1:
+		return info_table[index].v1_val;
+	case QM_HW_V2:
+		return info_table[index].v2_val;
+	default:
+		if (!is_read)
+			return info_table[index].v3_val;
+
+		val = readl(qm->io_base + info_table[index].offset);
+		return val;
+	}
+}
+EXPORT_SYMBOL_GPL(hisi_qm_get_cap_value);
+
 static void qm_get_xqc_depth(struct hisi_qm *qm, u16 *low_bits,
 			     u16 *high_bits, enum qm_basic_type type)
 {
@@ -4897,7 +4929,7 @@ static void qm_unregister_abnormal_irq(struct hisi_qm *qm)
 	if (qm->fun_type == QM_HW_VF)
 		return;
 
-	val = qm->cap_tables.qm_cap_table[QM_ABN_IRQ_TYPE_CAP_IDX].cap_val;
+	val = qm->cap_tables.qm_cap_table[QM_ABNORMAL_IRQ].cap_val;
 	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_ABN_IRQ_TYPE_MASK))
 		return;
 
@@ -4914,7 +4946,7 @@ static int qm_register_abnormal_irq(struct hisi_qm *qm)
 	if (qm->fun_type == QM_HW_VF)
 		return 0;
 
-	val = qm->cap_tables.qm_cap_table[QM_ABN_IRQ_TYPE_CAP_IDX].cap_val;
+	val = qm->cap_tables.qm_cap_table[QM_ABNORMAL_IRQ].cap_val;
 	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_ABN_IRQ_TYPE_MASK))
 		return 0;
 
@@ -4931,7 +4963,7 @@ static void qm_unregister_mb_cmd_irq(struct hisi_qm *qm)
 	struct pci_dev *pdev = qm->pdev;
 	u32 irq_vector, val;
 
-	val = qm->cap_tables.qm_cap_table[QM_PF2VF_IRQ_TYPE_CAP_IDX].cap_val;
+	val = qm->cap_tables.qm_cap_table[QM_MB_IRQ].cap_val;
 	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_IRQ_TYPE_MASK))
 		return;
 
@@ -4945,7 +4977,7 @@ static int qm_register_mb_cmd_irq(struct hisi_qm *qm)
 	u32 irq_vector, val;
 	int ret;
 
-	val = qm->cap_tables.qm_cap_table[QM_PF2VF_IRQ_TYPE_CAP_IDX].cap_val;
+	val = qm->cap_tables.qm_cap_table[QM_MB_IRQ].cap_val;
 	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_IRQ_TYPE_MASK))
 		return 0;
 
@@ -4962,7 +4994,7 @@ static void qm_unregister_aeq_irq(struct hisi_qm *qm)
 	struct pci_dev *pdev = qm->pdev;
 	u32 irq_vector, val;
 
-	val = qm->cap_tables.qm_cap_table[QM_AEQ_IRQ_TYPE_CAP_IDX].cap_val;
+	val = qm->cap_tables.qm_cap_table[QM_AEQ_IRQ].cap_val;
 	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_IRQ_TYPE_MASK))
 		return;
 
@@ -4976,7 +5008,7 @@ static int qm_register_aeq_irq(struct hisi_qm *qm)
 	u32 irq_vector, val;
 	int ret;
 
-	val = qm->cap_tables.qm_cap_table[QM_AEQ_IRQ_TYPE_CAP_IDX].cap_val;
+	val = qm->cap_tables.qm_cap_table[QM_AEQ_IRQ].cap_val;
 	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_IRQ_TYPE_MASK))
 		return 0;
 
@@ -4994,7 +5026,7 @@ static void qm_unregister_eq_irq(struct hisi_qm *qm)
 	struct pci_dev *pdev = qm->pdev;
 	u32 irq_vector, val;
 
-	val = qm->cap_tables.qm_cap_table[QM_EQ_IRQ_TYPE_CAP_IDX].cap_val;
+	val = qm->cap_tables.qm_cap_table[QM_EQ_IRQ].cap_val;
 	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_IRQ_TYPE_MASK))
 		return;
 
@@ -5008,7 +5040,7 @@ static int qm_register_eq_irq(struct hisi_qm *qm)
 	u32 irq_vector, val;
 	int ret;
 
-	val = qm->cap_tables.qm_cap_table[QM_EQ_IRQ_TYPE_CAP_IDX].cap_val;
+	val = qm->cap_tables.qm_cap_table[QM_EQ_IRQ].cap_val;
 	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_IRQ_TYPE_MASK))
 		return 0;
 
@@ -5096,24 +5128,26 @@ static int qm_get_qp_num(struct hisi_qm *qm)
 	return 0;
 }
 
-static int qm_pre_store_irq_type_caps(struct hisi_qm *qm)
+static int qm_pre_store_caps(struct hisi_qm *qm)
 {
 	struct hisi_qm_cap_record *qm_cap;
 	struct pci_dev *pdev = qm->pdev;
 	size_t i, size;
 
-	size = ARRAY_SIZE(qm_pre_store_caps);
+	size = ARRAY_SIZE(qm_cap_query_info);
 	qm_cap = devm_kzalloc(&pdev->dev, sizeof(*qm_cap) * size, GFP_KERNEL);
 	if (!qm_cap)
 		return -ENOMEM;
 
 	for (i = 0; i < size; i++) {
-		qm_cap[i].type = qm_pre_store_caps[i];
-		qm_cap[i].cap_val = hisi_qm_get_hw_info(qm, qm_basic_info,
-							qm_pre_store_caps[i], qm->cap_ver);
+		qm_cap[i].type = qm_cap_query_info[i].type;
+		qm_cap[i].name = qm_cap_query_info[i].name;
+		qm_cap[i].cap_val = hisi_qm_get_cap_value(qm, qm_cap_query_info,
+							i, qm->cap_ver);
 	}
 
 	qm->cap_tables.qm_cap_table = qm_cap;
+	qm->cap_tables.qm_cap_size = size;
 
 	return 0;
 }
@@ -5150,8 +5184,8 @@ static int qm_get_hw_caps(struct hisi_qm *qm)
 			set_bit(cap_info[i].type, &qm->caps);
 	}
 
-	/* Fetch and save the value of irq type related capability registers */
-	return qm_pre_store_irq_type_caps(qm);
+	/* Fetch and save the value of qm capability registers */
+	return qm_pre_store_caps(qm);
 }
 
 static int qm_get_pci_res(struct hisi_qm *qm)
diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index c29a92214996..c6443e74a930 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -220,11 +220,27 @@ enum sec_cap_type {
 	SEC_CORE4_ALG_BITMAP_HIGH,
 };
 
-enum sec_cap_reg_record_idx {
-	SEC_DRV_ALG_BITMAP_LOW_IDX = 0x0,
-	SEC_DRV_ALG_BITMAP_HIGH_IDX,
-	SEC_DEV_ALG_BITMAP_LOW_IDX,
-	SEC_DEV_ALG_BITMAP_HIGH_IDX,
+enum sec_cap_table_type {
+	QM_RAS_NFE_TYPE = 0x0,
+	QM_RAS_NFE_RESET,
+	QM_RAS_CE_TYPE,
+	SEC_RAS_NFE_TYPE,
+	SEC_RAS_NFE_RESET,
+	SEC_RAS_CE_TYPE,
+	SEC_CORE_INFO,
+	SEC_CORE_EN,
+	SEC_DRV_ALG_BITMAP_LOW_TB,
+	SEC_DRV_ALG_BITMAP_HIGH_TB,
+	SEC_ALG_BITMAP_LOW,
+	SEC_ALG_BITMAP_HIGH,
+	SEC_CORE1_BITMAP_LOW,
+	SEC_CORE1_BITMAP_HIGH,
+	SEC_CORE2_BITMAP_LOW,
+	SEC_CORE2_BITMAP_HIGH,
+	SEC_CORE3_BITMAP_LOW,
+	SEC_CORE3_BITMAP_HIGH,
+	SEC_CORE4_BITMAP_LOW,
+	SEC_CORE4_BITMAP_HIGH,
 };
 
 void sec_destroy_qps(struct hisi_qp **qps, int qp_num);
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 3806d0546f19..58dc8f51fa3d 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -2500,8 +2500,8 @@ int sec_register_to_crypto(struct hisi_qm *qm)
 	u64 alg_mask;
 	int ret = 0;
 
-	alg_mask = sec_get_alg_bitmap(qm, SEC_DRV_ALG_BITMAP_HIGH_IDX,
-				      SEC_DRV_ALG_BITMAP_LOW_IDX);
+	alg_mask = sec_get_alg_bitmap(qm, SEC_DRV_ALG_BITMAP_HIGH_TB,
+				      SEC_DRV_ALG_BITMAP_LOW_TB);
 
 	mutex_lock(&sec_algs_lock);
 	if (sec_available_devs) {
@@ -2533,8 +2533,8 @@ void sec_unregister_from_crypto(struct hisi_qm *qm)
 {
 	u64 alg_mask;
 
-	alg_mask = sec_get_alg_bitmap(qm, SEC_DRV_ALG_BITMAP_HIGH_IDX,
-				      SEC_DRV_ALG_BITMAP_LOW_IDX);
+	alg_mask = sec_get_alg_bitmap(qm, SEC_DRV_ALG_BITMAP_HIGH_TB,
+				      SEC_DRV_ALG_BITMAP_LOW_TB);
 
 	mutex_lock(&sec_algs_lock);
 	if (--sec_available_devs)
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 3abd12017250..316ab385e335 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -14,9 +14,9 @@
 #include <linux/seq_file.h>
 #include <linux/topology.h>
 #include <linux/uacce.h>
-
 #include "sec.h"
 
+#define CAP_FILE_PERMISSION		0444
 #define SEC_VF_NUM			63
 #define SEC_QUEUE_NUM_V1		4096
 #define PCI_DEVICE_ID_HUAWEI_SEC_PF	0xa255
@@ -167,11 +167,34 @@ static const struct hisi_qm_cap_info sec_basic_info[] = {
 	{SEC_CORE4_ALG_BITMAP_HIGH, 0x3170, 0, GENMASK(31, 0), 0x3FFF, 0x3FFF, 0x3FFF},
 };
 
-static const u32 sec_pre_store_caps[] = {
-	SEC_DRV_ALG_BITMAP_LOW,
-	SEC_DRV_ALG_BITMAP_HIGH,
-	SEC_DEV_ALG_BITMAP_LOW,
-	SEC_DEV_ALG_BITMAP_HIGH,
+static const struct hisi_qm_cap_query_info sec_cap_query_info[] = {
+	{QM_RAS_NFE_TYPE, "QM_RAS_NFE_TYPE             ", 0x3124, 0x0, 0x1C77, 0x7C77},
+	{QM_RAS_NFE_RESET, "QM_RAS_NFE_RESET            ", 0x3128, 0x0, 0xC77, 0x6C77},
+	{QM_RAS_CE_TYPE, "QM_RAS_CE_TYPE              ", 0x312C, 0x0, 0x8, 0x8},
+	{SEC_RAS_NFE_TYPE, "SEC_RAS_NFE_TYPE            ", 0x3130, 0x0, 0x177, 0x60177},
+	{SEC_RAS_NFE_RESET, "SEC_RAS_NFE_RESET           ", 0x3134, 0x0, 0x177, 0x177},
+	{SEC_RAS_CE_TYPE, "SEC_RAS_CE_TYPE             ", 0x3138, 0x0, 0x88, 0xC088},
+	{SEC_CORE_INFO, "SEC_CORE_INFO               ", 0x313c, 0x110404, 0x110404, 0x110404},
+	{SEC_CORE_EN, "SEC_CORE_EN                 ", 0x3140, 0x17F, 0x17F, 0xF},
+	{SEC_DRV_ALG_BITMAP_LOW_TB, "SEC_DRV_ALG_BITMAP_LOW      ",
+					0x3144, 0x18050CB, 0x18050CB, 0x18670CF},
+	{SEC_DRV_ALG_BITMAP_HIGH_TB, "SEC_DRV_ALG_BITMAP_HIGH     ",
+					0x3148, 0x395C, 0x395C, 0x395C},
+	{SEC_ALG_BITMAP_LOW, "SEC_ALG_BITMAP_LOW          ",
+					0x314c, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF},
+	{SEC_ALG_BITMAP_HIGH, "SEC_ALG_BITMAP_HIGH         ", 0x3150, 0x3FFF, 0x3FFF, 0x3FFF},
+	{SEC_CORE1_BITMAP_LOW, "SEC_CORE1_BITMAP_LOW        ",
+					0x3154, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF},
+	{SEC_CORE1_BITMAP_HIGH, "SEC_CORE1_BITMAP_HIGH       ", 0x3158, 0x3FFF, 0x3FFF, 0x3FFF},
+	{SEC_CORE2_BITMAP_LOW, "SEC_CORE2_BITMAP_LOW        ",
+					0x315c, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF},
+	{SEC_CORE2_BITMAP_HIGH, "SEC_CORE2_BITMAP_HIGH       ", 0x3160, 0x3FFF, 0x3FFF, 0x3FFF},
+	{SEC_CORE3_BITMAP_LOW, "SEC_CORE3_BITMAP_LOW        ",
+					0x3164, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF},
+	{SEC_CORE3_BITMAP_HIGH, "SEC_CORE3_BITMAP_HIGH       ", 0x3168, 0x3FFF, 0x3FFF, 0x3FFF},
+	{SEC_CORE4_BITMAP_LOW, "SEC_CORE4_BITMAP_LOW        ",
+					0x316c, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF},
+	{SEC_CORE4_BITMAP_HIGH, "SEC_CORE4_BITMAP_HIGH       ", 0x3170, 0x3FFF, 0x3FFF, 0x3FFF},
 };
 
 static const struct qm_dev_alg sec_dev_algs[] = { {
@@ -838,6 +861,26 @@ static int sec_regs_show(struct seq_file *s, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(sec_regs);
 
+static int sec_cap_regs_show(struct seq_file *s, void *unused)
+{
+	struct hisi_qm *qm = s->private;
+	u32 i, size;
+
+	size = qm->cap_tables.qm_cap_size;
+	for (i = 0; i < size; i++)
+		seq_printf(s, "%s= 0x%08x\n", qm->cap_tables.qm_cap_table[i].name,
+			   qm->cap_tables.qm_cap_table[i].cap_val);
+
+	size = qm->cap_tables.dev_cap_size;
+	for (i = 0; i < size; i++)
+		seq_printf(s, "%s= 0x%08x\n", qm->cap_tables.dev_cap_table[i].name,
+			   qm->cap_tables.dev_cap_table[i].cap_val);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(sec_cap_regs);
+
 static int sec_core_debug_init(struct hisi_qm *qm)
 {
 	struct dfx_diff_registers *sec_regs = qm->debug.acc_diff_regs;
@@ -872,6 +915,9 @@ static int sec_core_debug_init(struct hisi_qm *qm)
 				   tmp_d, data, &sec_atomic64_ops);
 	}
 
+	debugfs_create_file("cap_regs", CAP_FILE_PERMISSION,
+			    qm->debug.debug_root, qm, &sec_cap_regs_fops);
+
 	return 0;
 }
 
@@ -1085,18 +1131,20 @@ static int sec_pre_store_cap_reg(struct hisi_qm *qm)
 	struct pci_dev *pdev = qm->pdev;
 	size_t i, size;
 
-	size = ARRAY_SIZE(sec_pre_store_caps);
+	size = ARRAY_SIZE(sec_cap_query_info);
 	sec_cap = devm_kzalloc(&pdev->dev, sizeof(*sec_cap) * size, GFP_KERNEL);
 	if (!sec_cap)
 		return -ENOMEM;
 
 	for (i = 0; i < size; i++) {
-		sec_cap[i].type = sec_pre_store_caps[i];
-		sec_cap[i].cap_val = hisi_qm_get_hw_info(qm, sec_basic_info,
-				     sec_pre_store_caps[i], qm->cap_ver);
+		sec_cap[i].type = sec_cap_query_info[i].type;
+		sec_cap[i].name = sec_cap_query_info[i].name;
+		sec_cap[i].cap_val = hisi_qm_get_cap_value(qm, sec_cap_query_info,
+				     i, qm->cap_ver);
 	}
 
 	qm->cap_tables.dev_cap_table = sec_cap;
+	qm->cap_tables.dev_cap_size = size;
 
 	return 0;
 }
@@ -1146,8 +1194,7 @@ static int sec_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		hisi_qm_uninit(qm);
 		return ret;
 	}
-
-	alg_msk = sec_get_alg_bitmap(qm, SEC_DEV_ALG_BITMAP_HIGH_IDX, SEC_DEV_ALG_BITMAP_LOW_IDX);
+	alg_msk = sec_get_alg_bitmap(qm, SEC_ALG_BITMAP_HIGH, SEC_ALG_BITMAP_LOW);
 	ret = hisi_qm_set_algs(qm, alg_msk, sec_dev_algs, ARRAY_SIZE(sec_dev_algs));
 	if (ret) {
 		pci_err(qm->pdev, "Failed to set sec algs!\n");
diff --git a/drivers/crypto/hisilicon/zip/zip.h b/drivers/crypto/hisilicon/zip/zip.h
index f2e6da3240ae..2fecf346c3c9 100644
--- a/drivers/crypto/hisilicon/zip/zip.h
+++ b/drivers/crypto/hisilicon/zip/zip.h
@@ -81,6 +81,24 @@ struct hisi_zip_sqe {
 	u32 rsvd1[4];
 };
 
+enum zip_cap_table_type {
+	QM_RAS_NFE_TYPE,
+	QM_RAS_NFE_RESET,
+	QM_RAS_CE_TYPE,
+	ZIP_RAS_NFE_TYPE,
+	ZIP_RAS_NFE_RESET,
+	ZIP_RAS_CE_TYPE,
+	ZIP_CORE_INFO,
+	ZIP_CORE_EN,
+	ZIP_DRV_ALG_BITMAP_TB,
+	ZIP_ALG_BITMAP,
+	ZIP_CORE1_BITMAP,
+	ZIP_CORE2_BITMAP,
+	ZIP_CORE3_BITMAP,
+	ZIP_CORE4_BITMAP,
+	ZIP_CORE5_BITMAP,
+};
+
 int zip_create_qps(struct hisi_qp **qps, int qp_num, int node);
 int hisi_zip_register_to_crypto(struct hisi_qm *qm);
 void hisi_zip_unregister_from_crypto(struct hisi_qm *qm);
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index f547e6732bf5..638adfc6f683 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -14,6 +14,7 @@
 #include <linux/uacce.h>
 #include "zip.h"
 
+#define CAP_FILE_PERMISSION		0444
 #define PCI_DEVICE_ID_HUAWEI_ZIP_PF	0xa250
 
 #define HZIP_QUEUE_NUM_V1		4096
@@ -250,24 +251,22 @@ static struct hisi_qm_cap_info zip_basic_cap_info[] = {
 	{ZIP_CAP_MAX, 0x317c, 0, GENMASK(0, 0), 0x0, 0x0, 0x0}
 };
 
-enum zip_pre_store_cap_idx {
-	ZIP_CORE_NUM_CAP_IDX = 0x0,
-	ZIP_CLUSTER_COMP_NUM_CAP_IDX,
-	ZIP_CLUSTER_DECOMP_NUM_CAP_IDX,
-	ZIP_DECOMP_ENABLE_BITMAP_IDX,
-	ZIP_COMP_ENABLE_BITMAP_IDX,
-	ZIP_DRV_ALG_BITMAP_IDX,
-	ZIP_DEV_ALG_BITMAP_IDX,
-};
-
-static const u32 zip_pre_store_caps[] = {
-	ZIP_CORE_NUM_CAP,
-	ZIP_CLUSTER_COMP_NUM_CAP,
-	ZIP_CLUSTER_DECOMP_NUM_CAP,
-	ZIP_DECOMP_ENABLE_BITMAP,
-	ZIP_COMP_ENABLE_BITMAP,
-	ZIP_DRV_ALG_BITMAP,
-	ZIP_DEV_ALG_BITMAP,
+static const struct hisi_qm_cap_query_info zip_cap_query_info[] = {
+	{QM_RAS_NFE_TYPE, "QM_RAS_NFE_TYPE             ", 0x3124, 0x0, 0x1C57, 0x7C77},
+	{QM_RAS_NFE_RESET, "QM_RAS_NFE_RESET            ", 0x3128, 0x0, 0xC57, 0x6C77},
+	{QM_RAS_CE_TYPE, "QM_RAS_CE_TYPE              ", 0x312C, 0x0, 0x8, 0x8},
+	{ZIP_RAS_NFE_TYPE, "ZIP_RAS_NFE_TYPE            ", 0x3130, 0x0, 0x7FE, 0x1FFE},
+	{ZIP_RAS_NFE_RESET, "ZIP_RAS_NFE_RESET           ", 0x3134, 0x0, 0x7FE, 0x7FE},
+	{ZIP_RAS_CE_TYPE, "ZIP_RAS_CE_TYPE             ", 0x3138, 0x0, 0x1, 0x1},
+	{ZIP_CORE_INFO, "ZIP_CORE_INFO               ", 0x313C, 0x12080206, 0x12080206, 0x12050203},
+	{ZIP_CORE_EN, "ZIP_CORE_EN                 ", 0x3140, 0xFC0003, 0xFC0003, 0x1C0003},
+	{ZIP_DRV_ALG_BITMAP_TB, "ZIP_DRV_ALG_BITMAP          ", 0x3144, 0x0, 0x0, 0x30},
+	{ZIP_ALG_BITMAP, "ZIP_ALG_BITMAP              ", 0x3148, 0xF, 0xF, 0x3F},
+	{ZIP_CORE1_BITMAP, "ZIP_CORE1_BITMAP            ", 0x314C, 0x5, 0x5, 0xD5},
+	{ZIP_CORE2_BITMAP, "ZIP_CORE2_BITMAP            ", 0x3150, 0x5, 0x5, 0xD5},
+	{ZIP_CORE3_BITMAP, "ZIP_CORE3_BITMAP            ", 0x3154, 0xA, 0xA, 0x2A},
+	{ZIP_CORE4_BITMAP, "ZIP_CORE4_BITMAP            ", 0x3158, 0xA, 0xA, 0x2A},
+	{ZIP_CORE5_BITMAP, "ZIP_CORE5_BITMAP            ", 0x315C, 0xA, 0xA, 0x2A},
 };
 
 static const struct debugfs_reg32 hzip_dfx_regs[] = {
@@ -442,7 +441,7 @@ bool hisi_zip_alg_support(struct hisi_qm *qm, u32 alg)
 {
 	u32 cap_val;
 
-	cap_val = qm->cap_tables.dev_cap_table[ZIP_DRV_ALG_BITMAP_IDX].cap_val;
+	cap_val = qm->cap_tables.dev_cap_table[ZIP_DRV_ALG_BITMAP_TB].cap_val;
 	if ((alg & cap_val) == alg)
 		return true;
 
@@ -530,6 +529,7 @@ static int hisi_zip_set_user_domain_and_cache(struct hisi_qm *qm)
 {
 	void __iomem *base = qm->io_base;
 	u32 dcomp_bm, comp_bm;
+	u32 zip_core_en;
 
 	/* qm user domain */
 	writel(AXUSER_BASE, base + QM_ARUSER_M_CFG_1);
@@ -567,8 +567,12 @@ static int hisi_zip_set_user_domain_and_cache(struct hisi_qm *qm)
 	}
 
 	/* let's open all compression/decompression cores */
-	dcomp_bm = qm->cap_tables.dev_cap_table[ZIP_DECOMP_ENABLE_BITMAP_IDX].cap_val;
-	comp_bm = qm->cap_tables.dev_cap_table[ZIP_COMP_ENABLE_BITMAP_IDX].cap_val;
+
+	zip_core_en = qm->cap_tables.dev_cap_table[ZIP_CORE_EN].cap_val;
+	dcomp_bm = (zip_core_en >> zip_basic_cap_info[ZIP_DECOMP_ENABLE_BITMAP].shift) &
+			zip_basic_cap_info[ZIP_DECOMP_ENABLE_BITMAP].mask;
+	comp_bm = (zip_core_en >> zip_basic_cap_info[ZIP_COMP_ENABLE_BITMAP].shift) &
+			zip_basic_cap_info[ZIP_COMP_ENABLE_BITMAP].mask;
 	writel(HZIP_DECOMP_CHECK_ENABLE | dcomp_bm | comp_bm, base + HZIP_CLOCK_GATE_CTRL);
 
 	/* enable sqc,cqc writeback */
@@ -788,7 +792,12 @@ DEFINE_SHOW_ATTRIBUTE(hisi_zip_regs);
 
 static void __iomem *get_zip_core_addr(struct hisi_qm *qm, int core_num)
 {
-	u32 zip_comp_core_num = qm->cap_tables.dev_cap_table[ZIP_CLUSTER_COMP_NUM_CAP_IDX].cap_val;
+	u8 zip_comp_core_num;
+	u32 zip_core_info;
+
+	zip_core_info =  qm->cap_tables.dev_cap_table[ZIP_CORE_INFO].cap_val;
+	zip_comp_core_num = (zip_core_info >> zip_basic_cap_info[ZIP_CLUSTER_COMP_NUM_CAP].shift) &
+			     zip_basic_cap_info[ZIP_CLUSTER_COMP_NUM_CAP].mask;
 
 	if (core_num < zip_comp_core_num)
 		return qm->io_base + HZIP_CORE_DFX_BASE +
@@ -803,12 +812,16 @@ static int hisi_zip_core_debug_init(struct hisi_qm *qm)
 	u32 zip_core_num, zip_comp_core_num;
 	struct device *dev = &qm->pdev->dev;
 	struct debugfs_regset32 *regset;
+	u32 zip_core_info;
 	struct dentry *tmp_d;
 	char buf[HZIP_BUF_SIZE];
 	int i;
 
-	zip_core_num = qm->cap_tables.dev_cap_table[ZIP_CORE_NUM_CAP_IDX].cap_val;
-	zip_comp_core_num = qm->cap_tables.dev_cap_table[ZIP_CLUSTER_COMP_NUM_CAP_IDX].cap_val;
+	zip_core_info =  qm->cap_tables.dev_cap_table[ZIP_CORE_INFO].cap_val;
+	zip_core_num = (zip_core_info >> zip_basic_cap_info[ZIP_CORE_NUM_CAP].shift) &
+			zip_basic_cap_info[ZIP_CORE_NUM_CAP].mask;
+	zip_comp_core_num = (zip_core_info >> zip_basic_cap_info[ZIP_CLUSTER_COMP_NUM_CAP].shift) &
+			zip_basic_cap_info[ZIP_CLUSTER_COMP_NUM_CAP].mask;
 
 	for (i = 0; i < zip_core_num; i++) {
 		if (i < zip_comp_core_num)
@@ -834,6 +847,26 @@ static int hisi_zip_core_debug_init(struct hisi_qm *qm)
 	return 0;
 }
 
+static int zip_cap_regs_show(struct seq_file *s, void *unused)
+{
+	struct hisi_qm *qm = s->private;
+	u32 i, size;
+
+	size = qm->cap_tables.qm_cap_size;
+	for (i = 0; i < size; i++)
+		seq_printf(s, "%s= 0x%08x\n", qm->cap_tables.qm_cap_table[i].name,
+			   qm->cap_tables.qm_cap_table[i].cap_val);
+
+	size = qm->cap_tables.dev_cap_size;
+	for (i = 0; i < size; i++)
+		seq_printf(s, "%s= 0x%08x\n", qm->cap_tables.dev_cap_table[i].name,
+			   qm->cap_tables.dev_cap_table[i].cap_val);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(zip_cap_regs);
+
 static void hisi_zip_dfx_debug_init(struct hisi_qm *qm)
 {
 	struct dfx_diff_registers *hzip_regs = qm->debug.acc_diff_regs;
@@ -854,6 +887,9 @@ static void hisi_zip_dfx_debug_init(struct hisi_qm *qm)
 	if (qm->fun_type == QM_HW_PF && hzip_regs)
 		debugfs_create_file("diff_regs", 0444, tmp_dir,
 				      qm, &hzip_diff_regs_fops);
+
+	debugfs_create_file("cap_regs", CAP_FILE_PERMISSION,
+			    qm->debug.debug_root, qm, &zip_cap_regs_fops);
 }
 
 static int hisi_zip_ctrl_debug_init(struct hisi_qm *qm)
@@ -912,9 +948,14 @@ static int hisi_zip_debugfs_init(struct hisi_qm *qm)
 /* hisi_zip_debug_regs_clear() - clear the zip debug regs */
 static void hisi_zip_debug_regs_clear(struct hisi_qm *qm)
 {
-	u32 zip_core_num = qm->cap_tables.dev_cap_table[ZIP_CORE_NUM_CAP_IDX].cap_val;
+	u32 zip_core_info;
+	u8 zip_core_num;
 	int i, j;
 
+	zip_core_info = qm->cap_tables.dev_cap_table[ZIP_CORE_INFO].cap_val;
+	zip_core_num = (zip_core_info >> zip_basic_cap_info[ZIP_CORE_NUM_CAP].shift) &
+			zip_basic_cap_info[ZIP_CORE_NUM_CAP].mask;
+
 	/* enable register read_clear bit */
 	writel(HZIP_RD_CNT_CLR_CE_EN, qm->io_base + HZIP_SOFT_CTRL_CNT_CLR_CE);
 	for (i = 0; i < zip_core_num; i++)
@@ -946,10 +987,13 @@ static int hisi_zip_show_last_regs_init(struct hisi_qm *qm)
 	int com_dfx_regs_num = ARRAY_SIZE(hzip_com_dfx_regs);
 	struct qm_debug *debug = &qm->debug;
 	void __iomem *io_base;
+	u32 zip_core_info;
 	u32 zip_core_num;
 	int i, j, idx;
 
-	zip_core_num = qm->cap_tables.dev_cap_table[ZIP_CORE_NUM_CAP_IDX].cap_val;
+	zip_core_info = qm->cap_tables.dev_cap_table[ZIP_CORE_INFO].cap_val;
+	zip_core_num = (zip_core_info >> zip_basic_cap_info[ZIP_CORE_NUM_CAP].shift) &
+			zip_basic_cap_info[ZIP_CORE_NUM_CAP].mask;
 
 	debug->last_words = kcalloc(core_dfx_regs_num * zip_core_num + com_dfx_regs_num,
 				    sizeof(unsigned int), GFP_KERNEL);
@@ -991,6 +1035,7 @@ static void hisi_zip_show_last_dfx_regs(struct hisi_qm *qm)
 	u32 zip_core_num, zip_comp_core_num;
 	struct qm_debug *debug = &qm->debug;
 	char buf[HZIP_BUF_SIZE];
+	u32 zip_core_info;
 	void __iomem *base;
 	int i, j, idx;
 	u32 val;
@@ -1005,8 +1050,11 @@ static void hisi_zip_show_last_dfx_regs(struct hisi_qm *qm)
 				 hzip_com_dfx_regs[i].name, debug->last_words[i], val);
 	}
 
-	zip_core_num = qm->cap_tables.dev_cap_table[ZIP_CORE_NUM_CAP_IDX].cap_val;
-	zip_comp_core_num = qm->cap_tables.dev_cap_table[ZIP_CLUSTER_COMP_NUM_CAP_IDX].cap_val;
+	zip_core_info = qm->cap_tables.dev_cap_table[ZIP_CORE_INFO].cap_val;
+	zip_core_num = (zip_core_info >> zip_basic_cap_info[ZIP_CORE_NUM_CAP].shift) &
+			zip_basic_cap_info[ZIP_CORE_NUM_CAP].mask;
+	zip_comp_core_num = (zip_core_info >> zip_basic_cap_info[ZIP_CLUSTER_COMP_NUM_CAP].shift) &
+			zip_basic_cap_info[ZIP_CLUSTER_COMP_NUM_CAP].mask;
 
 	for (i = 0; i < zip_core_num; i++) {
 		if (i < zip_comp_core_num)
@@ -1167,18 +1215,20 @@ static int zip_pre_store_cap_reg(struct hisi_qm *qm)
 	struct pci_dev *pdev = qm->pdev;
 	size_t i, size;
 
-	size = ARRAY_SIZE(zip_pre_store_caps);
+	size = ARRAY_SIZE(zip_cap_query_info);
 	zip_cap = devm_kzalloc(&pdev->dev, sizeof(*zip_cap) * size, GFP_KERNEL);
 	if (!zip_cap)
 		return -ENOMEM;
 
 	for (i = 0; i < size; i++) {
-		zip_cap[i].type = zip_pre_store_caps[i];
-		zip_cap[i].cap_val = hisi_qm_get_hw_info(qm, zip_basic_cap_info,
-				     zip_pre_store_caps[i], qm->cap_ver);
+		zip_cap[i].type = zip_cap_query_info[i].type;
+		zip_cap[i].name = zip_cap_query_info[i].name;
+		zip_cap[i].cap_val = hisi_qm_get_cap_value(qm, zip_cap_query_info,
+				     i, qm->cap_ver);
 	}
 
 	qm->cap_tables.dev_cap_table = zip_cap;
+	qm->cap_tables.dev_cap_size = size;
 
 	return 0;
 }
@@ -1230,7 +1280,7 @@ static int hisi_zip_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		return ret;
 	}
 
-	alg_msk = qm->cap_tables.dev_cap_table[ZIP_DEV_ALG_BITMAP_IDX].cap_val;
+	alg_msk = qm->cap_tables.dev_cap_table[ZIP_ALG_BITMAP].cap_val;
 	ret = hisi_qm_set_algs(qm, alg_msk, zip_dev_algs, ARRAY_SIZE(zip_dev_algs));
 	if (ret) {
 		pci_err(qm->pdev, "Failed to set zip algs!\n");
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 389e95754776..7272eac850e8 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -274,13 +274,25 @@ struct hisi_qm_cap_info {
 	u32 v3_val;
 };
 
+struct hisi_qm_cap_query_info {
+	u32 type;
+	const char *name;
+	u32 offset;
+	u32 v1_val;
+	u32 v2_val;
+	u32 v3_val;
+};
+
 struct hisi_qm_cap_record {
 	u32 type;
+	const char *name;
 	u32 cap_val;
 };
 
 struct hisi_qm_cap_tables {
+	u32 qm_cap_size;
 	struct hisi_qm_cap_record *qm_cap_table;
+	u32 dev_cap_size;
 	struct hisi_qm_cap_record *dev_cap_table;
 };
 
@@ -554,6 +566,9 @@ void hisi_qm_regs_dump(struct seq_file *s, struct debugfs_regset32 *regset);
 u32 hisi_qm_get_hw_info(struct hisi_qm *qm,
 			const struct hisi_qm_cap_info *info_table,
 			u32 index, bool is_read);
+u32 hisi_qm_get_cap_value(struct hisi_qm *qm,
+			const struct hisi_qm_cap_query_info *info_table,
+			u32 index, bool is_read);
 int hisi_qm_set_algs(struct hisi_qm *qm, u64 alg_msk, const struct qm_dev_alg *dev_algs,
 		     u32 dev_algs_size);
 
-- 
2.33.0



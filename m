Return-Path: <linux-crypto+bounces-503-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 930B2801C38
	for <lists+linux-crypto@lfdr.de>; Sat,  2 Dec 2023 11:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9581F21181
	for <lists+linux-crypto@lfdr.de>; Sat,  2 Dec 2023 10:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE3416424
	for <lists+linux-crypto@lfdr.de>; Sat,  2 Dec 2023 10:32:36 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4FB19F;
	Sat,  2 Dec 2023 01:20:58 -0800 (PST)
Received: from dggpeml500005.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Sj4CD1d0kzWh8q;
	Sat,  2 Dec 2023 17:20:08 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 dggpeml500005.china.huawei.com (7.185.36.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 2 Dec 2023 17:20:56 +0800
From: Zhiqi Song <songzhiqi1@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wangzhou1@hisilicon.com>, <fanghao11@huawei.com>, <liulongfang@huawei.com>,
	<qianweili@huawei.com>, <shenyang39@huawei.com>
Subject: [PATCH 4/5] crypto: hisilicon/sec2 - save capability registers in probe process
Date: Sat, 2 Dec 2023 17:17:21 +0800
Message-ID: <20231202091722.1974582-5-songzhiqi1@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231202091722.1974582-1-songzhiqi1@huawei.com>
References: <20231202091722.1974582-1-songzhiqi1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500005.china.huawei.com (7.185.36.59)
X-CFilter-Loop: Reflected

Pre-store the valid value of the sec alg support related capability
register in sec_qm_init(), which will be called by probe process.
It can reduce the number of capability register queries and avoid
obtaining incorrect values in abnormal scenarios, such as reset
failed and the memory space disabled.

Fixes: 921715b6b782 ("crypto: hisilicon/sec - get algorithm bitmap from registers")
Signed-off-by: Zhiqi Song <songzhiqi1@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec.h        |  7 ++++
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 10 ++++-
 drivers/crypto/hisilicon/sec2/sec_main.c   | 43 ++++++++++++++++++++--
 3 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index 3e57fc04b377..410c83712e28 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -220,6 +220,13 @@ enum sec_cap_type {
 	SEC_CORE4_ALG_BITMAP_HIGH,
 };
 
+enum sec_cap_reg_record_idx {
+	SEC_DRV_ALG_BITMAP_LOW_IDX = 0x0,
+	SEC_DRV_ALG_BITMAP_HIGH_IDX,
+	SEC_DEV_ALG_BITMAP_LOW_IDX,
+	SEC_DEV_ALG_BITMAP_HIGH_IDX,
+};
+
 void sec_destroy_qps(struct hisi_qp **qps, int qp_num);
 struct hisi_qp **sec_create_qps(void);
 int sec_register_to_crypto(struct hisi_qm *qm);
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 6fcabbc87860..ba7f305d43c1 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -2547,9 +2547,12 @@ static int sec_register_aead(u64 alg_mask)
 
 int sec_register_to_crypto(struct hisi_qm *qm)
 {
-	u64 alg_mask = sec_get_alg_bitmap(qm, SEC_DRV_ALG_BITMAP_HIGH, SEC_DRV_ALG_BITMAP_LOW);
+	u64 alg_mask;
 	int ret = 0;
 
+	alg_mask = sec_get_alg_bitmap(qm, SEC_DRV_ALG_BITMAP_HIGH_IDX,
+				      SEC_DRV_ALG_BITMAP_LOW_IDX);
+
 	mutex_lock(&sec_algs_lock);
 	if (sec_available_devs) {
 		sec_available_devs++;
@@ -2578,7 +2581,10 @@ int sec_register_to_crypto(struct hisi_qm *qm)
 
 void sec_unregister_from_crypto(struct hisi_qm *qm)
 {
-	u64 alg_mask = sec_get_alg_bitmap(qm, SEC_DRV_ALG_BITMAP_HIGH, SEC_DRV_ALG_BITMAP_LOW);
+	u64 alg_mask;
+
+	alg_mask = sec_get_alg_bitmap(qm, SEC_DRV_ALG_BITMAP_HIGH_IDX,
+				      SEC_DRV_ALG_BITMAP_LOW_IDX);
 
 	mutex_lock(&sec_algs_lock);
 	if (--sec_available_devs)
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 2eceab7600ca..878d94ab5d6d 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -167,6 +167,13 @@ static const struct hisi_qm_cap_info sec_basic_info[] = {
 	{SEC_CORE4_ALG_BITMAP_HIGH, 0x3170, 0, GENMASK(31, 0), 0x3FFF, 0x3FFF, 0x3FFF},
 };
 
+static const u32 sec_pre_store_caps[] = {
+	SEC_DRV_ALG_BITMAP_LOW,
+	SEC_DRV_ALG_BITMAP_HIGH,
+	SEC_DEV_ALG_BITMAP_LOW,
+	SEC_DEV_ALG_BITMAP_HIGH,
+};
+
 static const struct qm_dev_alg sec_dev_algs[] = { {
 		.alg_msk = SEC_CIPHER_BITMAP,
 		.alg = "cipher\n",
@@ -388,8 +395,8 @@ u64 sec_get_alg_bitmap(struct hisi_qm *qm, u32 high, u32 low)
 {
 	u32 cap_val_h, cap_val_l;
 
-	cap_val_h = hisi_qm_get_hw_info(qm, sec_basic_info, high, qm->cap_ver);
-	cap_val_l = hisi_qm_get_hw_info(qm, sec_basic_info, low, qm->cap_ver);
+	cap_val_h = qm->cap_tables.dev_cap_table[high].cap_val;
+	cap_val_l = qm->cap_tables.dev_cap_table[low].cap_val;
 
 	return ((u64)cap_val_h << SEC_ALG_BITMAP_SHIFT) | (u64)cap_val_l;
 }
@@ -1071,6 +1078,28 @@ static int sec_pf_probe_init(struct sec_dev *sec)
 	return ret;
 }
 
+static int sec_pre_store_cap_reg(struct hisi_qm *qm)
+{
+	struct hisi_qm_cap_record *sec_cap;
+	struct pci_dev *pdev = qm->pdev;
+	size_t i, size;
+
+	size = ARRAY_SIZE(sec_pre_store_caps);
+	sec_cap = devm_kzalloc(&pdev->dev, sizeof(*sec_cap) * size, GFP_KERNEL);
+	if (!sec_cap)
+		return -ENOMEM;
+
+	for (i = 0; i < size; i++) {
+		sec_cap[i].type = sec_pre_store_caps[i];
+		sec_cap[i].cap_val = hisi_qm_get_hw_info(qm, sec_basic_info,
+				     sec_pre_store_caps[i], qm->cap_ver);
+	}
+
+	qm->cap_tables.dev_cap_table = sec_cap;
+
+	return 0;
+}
+
 static int sec_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 {
 	u64 alg_msk;
@@ -1108,7 +1137,15 @@ static int sec_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		return ret;
 	}
 
-	alg_msk = sec_get_alg_bitmap(qm, SEC_DEV_ALG_BITMAP_HIGH, SEC_DEV_ALG_BITMAP_LOW);
+	/* Fetch and save the value of capability registers */
+	ret = sec_pre_store_cap_reg(qm);
+	if (ret) {
+		pci_err(qm->pdev, "Failed to pre-store capability registers!\n");
+		hisi_qm_uninit(qm);
+		return ret;
+	}
+
+	alg_msk = sec_get_alg_bitmap(qm, SEC_DEV_ALG_BITMAP_HIGH_IDX, SEC_DEV_ALG_BITMAP_LOW_IDX);
 	ret = hisi_qm_set_algs(qm, alg_msk, sec_dev_algs, ARRAY_SIZE(sec_dev_algs));
 	if (ret) {
 		pci_err(qm->pdev, "Failed to set sec algs!\n");
-- 
2.30.0



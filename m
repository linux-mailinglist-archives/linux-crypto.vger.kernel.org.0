Return-Path: <linux-crypto+bounces-278-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0BC7F8AC5
	for <lists+linux-crypto@lfdr.de>; Sat, 25 Nov 2023 13:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6323D2814BB
	for <lists+linux-crypto@lfdr.de>; Sat, 25 Nov 2023 12:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D44FC1D
	for <lists+linux-crypto@lfdr.de>; Sat, 25 Nov 2023 12:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-crypto@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BEC10E4;
	Sat, 25 Nov 2023 03:50:12 -0800 (PST)
Received: from kwepemm000009.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Scqm36n0HzMnNC;
	Sat, 25 Nov 2023 19:45:23 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm000009.china.huawei.com (7.193.23.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 25 Nov 2023 19:50:10 +0800
From: Weili Qian <qianweili@huawei.com>
To: <herbert@gondor.apana.org.au>
CC: <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH 3/3] crypto: hisilicon/qm - add comments and remove redundant array element
Date: Sat, 25 Nov 2023 19:50:11 +0800
Message-ID: <20231125115011.22519-4-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231125115011.22519-1-qianweili@huawei.com>
References: <20231125115011.22519-1-qianweili@huawei.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000009.china.huawei.com (7.193.23.227)
X-CFilter-Loop: Reflected

1. Remove redundant array element, prevent the size obtained by
ARRAY_SIZE() from qm_log_hw_error is greater than actual size.
2. Add comments in function qm_set_vf_mse() and qm_cq_ctx_cfg()
to make it easier to understand.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 7d22412774ba..7ed079a9c929 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -391,7 +391,6 @@ static const struct hisi_qm_hw_error qm_hw_error[] = {
 	{ .int_msk = BIT(12), .msg = "qm_db_random_invalid" },
 	{ .int_msk = BIT(13), .msg = "qm_mailbox_timeout" },
 	{ .int_msk = BIT(14), .msg = "qm_flr_timeout" },
-	{ /* sentinel */ }
 };
 
 static const char * const qm_db_timeout[] = {
@@ -1889,6 +1888,11 @@ static int qm_cq_ctx_cfg(struct hisi_qp *qp, int qp_id, u32 pasid)
 		cqc.dw3 = cpu_to_le32(QM_MK_CQC_DW3_V2(QM_QC_CQE_SIZE, qp->cq_depth));
 		cqc.w8 = 0; /* rand_qc */
 	}
+	/*
+	 * Enable request finishing interrupts defaultly.
+	 * So, there will be some interrupts until disabling
+	 * this.
+	 */
 	cqc.dw6 = cpu_to_le32(1 << QM_CQ_PHASE_SHIFT | 1 << QM_CQ_FLAG_SHIFT);
 	cqc.base_l = cpu_to_le32(lower_32_bits(qp->cqe_dma));
 	cqc.base_h = cpu_to_le32(upper_32_bits(qp->cqe_dma));
@@ -3879,6 +3883,11 @@ static int qm_set_vf_mse(struct hisi_qm *qm, bool set)
 	int pos;
 	int i;
 
+	/*
+	 * Since function qm_set_vf_mse is called only after SRIOV is enabled,
+	 * pci_find_ext_capability cannot return 0, pos does not need to be
+	 * checked.
+	 */
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
 	pci_read_config_word(pdev, pos + PCI_SRIOV_CTRL, &sriov_ctrl);
 	if (set)
-- 
2.33.0



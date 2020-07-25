Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FA822D45E
	for <lists+linux-crypto@lfdr.de>; Sat, 25 Jul 2020 05:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgGYDqx (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 24 Jul 2020 23:46:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8277 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726747AbgGYDqx (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 24 Jul 2020 23:46:53 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F2DEFAD5A263A8BF6BA3;
        Sat, 25 Jul 2020 11:46:49 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Sat, 25 Jul 2020 11:46:42 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH 10/10] crypto: hisilicon/zip - fix some coding styles
Date:   Sat, 25 Jul 2020 11:44:43 +0800
Message-ID: <1595648683-50590-11-git-send-email-shenyang39@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595648683-50590-1-git-send-email-shenyang39@huawei.com>
References: <1595648683-50590-1-git-send-email-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

1.Unified alignment styles
2.Remove unnecessary goto branch
3.Remove address printf

Signed-off-by: Yang Shen <shenyang39@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/zip/zip_crypto.c | 13 ++++++-------
 drivers/crypto/hisilicon/zip/zip_main.c   | 16 ++++------------
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index 7757e33..10b7adb 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -38,8 +38,10 @@
 #define HZIP_SGL_SGE_NR				10

 static const u8 zlib_head[HZIP_ZLIB_HEAD_SIZE] = {0x78, 0x9c};
-static const u8 gzip_head[HZIP_GZIP_HEAD_SIZE] = {0x1f, 0x8b, 0x08, 0x0, 0x0,
-						  0x0, 0x0, 0x0, 0x0, 0x03};
+static const u8 gzip_head[HZIP_GZIP_HEAD_SIZE] = {
+	0x1f, 0x8b, 0x08, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x03
+};
+
 enum hisi_zip_alg_type {
 	HZIP_ALG_TYPE_COMP = 0,
 	HZIP_ALG_TYPE_DECOMP = 1,
@@ -359,7 +361,6 @@ static void hisi_zip_acomp_cb(struct hisi_qp *qp, void *data)

 	atomic64_inc(&dfx->recv_cnt);
 	status = sqe->dw3 & HZIP_BD_STATUS_M;
-
 	if (status != 0 && status != HZIP_NC_ERR) {
 		dev_err(dev, "%scompress fail in qp%u: %u, output: %u\n",
 			(qp->alg_type == 0) ? "" : "de", qp->qp_id, status,
@@ -520,8 +521,7 @@ static int hisi_zip_do_work(struct hisi_zip_req *req,
 	struct hisi_acc_sgl_pool *pool = qp_ctx->sgl_pool;
 	struct hisi_zip_dfx *dfx = &qp_ctx->zip_dev->dfx;
 	struct hisi_zip_sqe zip_sqe;
-	dma_addr_t input;
-	dma_addr_t output;
+	dma_addr_t input, output;
 	int ret;

 	if (!a_req->src || !a_req->slen || !a_req->dst || !a_req->dlen)
@@ -540,9 +540,8 @@ static int hisi_zip_do_work(struct hisi_zip_req *req,
 						    (req->req_id << 1) + 1,
 						    &output);
 	if (IS_ERR(req->hw_dst)) {
-		dev_err(dev, "The dst map to hw SGL failed (%ld)!\n",
-			PTR_ERR(req->hw_dst));
 		ret = PTR_ERR(req->hw_dst);
+		dev_err(dev, "The dst map to hw SGL failed (%d)!\n", ret);
 		goto err_unmap_input;
 	}
 	req->dma_dst = output;
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 49fad18..8bbae28 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -258,6 +258,7 @@ static int hisi_zip_set_user_domain_and_cache(struct hisi_qm *qm)
 	/* qm cache */
 	writel(AXI_M_CFG, base + QM_AXI_M_CFG);
 	writel(AXI_M_CFG_ENABLE, base + QM_AXI_M_CFG_ENABLE);
+
 	/* disable FLR triggered by BME(bus master enable) */
 	writel(PEH_AXUSER_CFG, base + QM_PEH_AXUSER_CFG);
 	writel(PEH_AXUSER_CFG_ENABLE, base + QM_PEH_AXUSER_CFG_ENABLE);
@@ -311,7 +312,7 @@ static void hisi_zip_hw_error_enable(struct hisi_qm *qm)
 	writel(0x1, qm->io_base + HZIP_CORE_INT_RAS_CE_ENB);
 	writel(0x0, qm->io_base + HZIP_CORE_INT_RAS_FE_ENB);
 	writel(HZIP_CORE_INT_RAS_NFE_ENABLE,
-		qm->io_base + HZIP_CORE_INT_RAS_NFE_ENB);
+	       qm->io_base + HZIP_CORE_INT_RAS_NFE_ENB);

 	/* enable ZIP hw error interrupts */
 	writel(0, qm->io_base + HZIP_CORE_INT_MASK_REG);
@@ -487,7 +488,6 @@ static const struct file_operations ctrl_debug_fops = {
 	.write = hisi_zip_ctrl_debug_write,
 };

-
 static int zip_debugfs_atomic64_set(void *data, u64 val)
 {
 	if (val)
@@ -634,7 +634,7 @@ static void hisi_zip_log_hw_error(struct hisi_qm *qm, u32 err_sts)
 	while (err->msg) {
 		if (err->int_msk & err_sts) {
 			dev_err(dev, "%s [error status=0x%x] found\n",
-				 err->msg, err->int_msk);
+				err->msg, err->int_msk);

 			if (err->int_msk & HZIP_CORE_INT_STATUS_M_ECC) {
 				err_val = readl(qm->io_base +
@@ -642,9 +642,6 @@ static void hisi_zip_log_hw_error(struct hisi_qm *qm, u32 err_sts)
 				dev_err(dev, "hisi-zip multi ecc sram num=0x%x\n",
 					((err_val >>
 					HZIP_SRAM_ECC_ERR_NUM_SHIFT) & 0xFF));
-				dev_err(dev, "hisi-zip multi ecc sram addr=0x%x\n",
-					(err_val >>
-					HZIP_SRAM_ECC_ERR_ADDR_SHIFT));
 			}
 		}
 		err++;
@@ -904,15 +901,10 @@ static int __init hisi_zip_init(void)

 	ret = pci_register_driver(&hisi_zip_pci_driver);
 	if (ret < 0) {
+		hisi_zip_unregister_debugfs();
 		pr_err("Failed to register pci driver.\n");
-		goto err_pci;
 	}

-	return 0;
-
-err_pci:
-	hisi_zip_unregister_debugfs();
-
 	return ret;
 }

--
2.7.4


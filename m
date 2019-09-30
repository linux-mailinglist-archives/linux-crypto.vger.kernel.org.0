Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC5FC1BF2
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Sep 2019 09:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfI3HMY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 30 Sep 2019 03:12:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3179 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729487AbfI3HMY (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 30 Sep 2019 03:12:24 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4427E645D99C92D79A71;
        Mon, 30 Sep 2019 15:12:19 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Mon, 30 Sep 2019 15:12:11 +0800
From:   Zhou Wang <wangzhou1@hisilicon.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linuxarm@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Shukun Tan <tanshukun1@huawei.com>
Subject: [PATCH 1/4] crypto: hisilicon - merge sgl support to hisi_qm module
Date:   Mon, 30 Sep 2019 15:08:52 +0800
Message-ID: <1569827335-21822-2-git-send-email-wangzhou1@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1569827335-21822-1-git-send-email-wangzhou1@hisilicon.com>
References: <1569827335-21822-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

As HW SGL can be seen as a data format of QM's sqe, we merge sgl code into
qm module and rename it as hisi_qm, which reduces the number of module and
make the name less generic.

This patch also modify the interface of SGL:
 - Create/free hisi_acc_sgl_pool inside.
 - Let user to pass the SGE number in one SGL when creating sgl pool, which
   is better than a unified module parameter for sgl module before.
 - Modify zip driver according to sgl interface change.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Shukun Tan <tanshukun1@huawei.com>
---
 MAINTAINERS                               |  1 -
 drivers/crypto/hisilicon/Kconfig          |  9 ----
 drivers/crypto/hisilicon/Makefile         |  4 +-
 drivers/crypto/hisilicon/qm.h             | 11 +++++
 drivers/crypto/hisilicon/sgl.c            | 73 ++++++++++++++-----------------
 drivers/crypto/hisilicon/sgl.h            | 24 ----------
 drivers/crypto/hisilicon/zip/zip.h        |  1 -
 drivers/crypto/hisilicon/zip/zip_crypto.c | 20 +++++----
 8 files changed, 58 insertions(+), 85 deletions(-)
 delete mode 100644 drivers/crypto/hisilicon/sgl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a97f1be..8671e1e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7417,7 +7417,6 @@ S:	Maintained
 F:	drivers/crypto/hisilicon/qm.c
 F:	drivers/crypto/hisilicon/qm.h
 F:	drivers/crypto/hisilicon/sgl.c
-F:	drivers/crypto/hisilicon/sgl.h
 F:	drivers/crypto/hisilicon/zip/
 F:	Documentation/ABI/testing/debugfs-hisi-zip
 
diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
index 7bfcaa7..79c82ba 100644
--- a/drivers/crypto/hisilicon/Kconfig
+++ b/drivers/crypto/hisilicon/Kconfig
@@ -22,21 +22,12 @@ config CRYPTO_DEV_HISI_QM
 	  HiSilicon accelerator engines use a common queue management
 	  interface. Specific engine driver may use this module.
 
-config CRYPTO_HISI_SGL
-	tristate
-	depends on ARM64 || COMPILE_TEST
-	help
-	  HiSilicon accelerator engines use a common hardware scatterlist
-	  interface for data format. Specific engine driver may use this
-	  module.
-
 config CRYPTO_DEV_HISI_ZIP
 	tristate "Support for HiSilicon ZIP accelerator"
 	depends on PCI && PCI_MSI
 	depends on ARM64 || (COMPILE_TEST && 64BIT)
 	depends on !CPU_BIG_ENDIAN || COMPILE_TEST
 	select CRYPTO_DEV_HISI_QM
-	select CRYPTO_HISI_SGL
 	select SG_SPLIT
 	help
 	  Support for HiSilicon ZIP Driver
diff --git a/drivers/crypto/hisilicon/Makefile b/drivers/crypto/hisilicon/Makefile
index 45a2797..4978d14 100644
--- a/drivers/crypto/hisilicon/Makefile
+++ b/drivers/crypto/hisilicon/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CRYPTO_DEV_HISI_SEC) += sec/
-obj-$(CONFIG_CRYPTO_DEV_HISI_QM) += qm.o
-obj-$(CONFIG_CRYPTO_HISI_SGL) += sgl.o
+obj-$(CONFIG_CRYPTO_DEV_HISI_QM) += hisi_qm.o
+hisi_qm-objs = qm.o sgl.o
 obj-$(CONFIG_CRYPTO_DEV_HISI_ZIP) += zip/
diff --git a/drivers/crypto/hisilicon/qm.h b/drivers/crypto/hisilicon/qm.h
index 70e672ae..978d2ae 100644
--- a/drivers/crypto/hisilicon/qm.h
+++ b/drivers/crypto/hisilicon/qm.h
@@ -212,4 +212,15 @@ void hisi_qm_hw_error_init(struct hisi_qm *qm, u32 ce, u32 nfe, u32 fe,
 int hisi_qm_hw_error_handle(struct hisi_qm *qm);
 enum qm_hw_ver hisi_qm_get_hw_version(struct pci_dev *pdev);
 void hisi_qm_debug_regs_clear(struct hisi_qm *qm);
+
+struct hisi_acc_sgl_pool;
+struct hisi_acc_hw_sgl *hisi_acc_sg_buf_map_to_hw_sgl(struct device *dev,
+	struct scatterlist *sgl, struct hisi_acc_sgl_pool *pool,
+	u32 index, dma_addr_t *hw_sgl_dma);
+void hisi_acc_sg_buf_unmap(struct device *dev, struct scatterlist *sgl,
+			   struct hisi_acc_hw_sgl *hw_sgl);
+struct hisi_acc_sgl_pool *hisi_acc_create_sgl_pool(struct device *dev,
+						   u32 count, u32 sge_nr);
+void hisi_acc_free_sgl_pool(struct device *dev,
+			    struct hisi_acc_sgl_pool *pool);
 #endif
diff --git a/drivers/crypto/hisilicon/sgl.c b/drivers/crypto/hisilicon/sgl.c
index e083d17..81a9040 100644
--- a/drivers/crypto/hisilicon/sgl.c
+++ b/drivers/crypto/hisilicon/sgl.c
@@ -2,38 +2,13 @@
 /* Copyright (c) 2019 HiSilicon Limited. */
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
-#include "./sgl.h"
+#include <linux/slab.h>
 
 #define HISI_ACC_SGL_SGE_NR_MIN		1
 #define HISI_ACC_SGL_SGE_NR_MAX		255
-#define HISI_ACC_SGL_SGE_NR_DEF		10
 #define HISI_ACC_SGL_NR_MAX		256
 #define HISI_ACC_SGL_ALIGN_SIZE		64
 
-static int acc_sgl_sge_set(const char *val, const struct kernel_param *kp)
-{
-	int ret;
-	u32 n;
-
-	if (!val)
-		return -EINVAL;
-
-	ret = kstrtou32(val, 10, &n);
-	if (ret != 0 || n > HISI_ACC_SGL_SGE_NR_MAX || n == 0)
-		return -EINVAL;
-
-	return param_set_int(val, kp);
-}
-
-static const struct kernel_param_ops acc_sgl_sge_ops = {
-	.set = acc_sgl_sge_set,
-	.get = param_get_int,
-};
-
-static u32 acc_sgl_sge_nr = HISI_ACC_SGL_SGE_NR_DEF;
-module_param_cb(acc_sgl_sge_nr, &acc_sgl_sge_ops, &acc_sgl_sge_nr, 0444);
-MODULE_PARM_DESC(acc_sgl_sge_nr, "Number of sge in sgl(1-255)");
-
 struct acc_hw_sge {
 	dma_addr_t buf;
 	void *page_ctrl;
@@ -55,37 +30,54 @@ struct hisi_acc_hw_sgl {
 	struct acc_hw_sge sge_entries[];
 } __aligned(1);
 
+struct hisi_acc_sgl_pool {
+	struct hisi_acc_hw_sgl *sgl;
+	dma_addr_t sgl_dma;
+	size_t size;
+	u32 count;
+	u32 sge_nr;
+	size_t sgl_size;
+};
+
 /**
  * hisi_acc_create_sgl_pool() - Create a hw sgl pool.
  * @dev: The device which hw sgl pool belongs to.
- * @pool: Pointer of pool.
  * @count: Count of hisi_acc_hw_sgl in pool.
+ * @sge_nr: The count of sge in hw_sgl
  *
  * This function creates a hw sgl pool, after this user can get hw sgl memory
  * from it.
  */
-int hisi_acc_create_sgl_pool(struct device *dev,
-			     struct hisi_acc_sgl_pool *pool, u32 count)
+struct hisi_acc_sgl_pool *hisi_acc_create_sgl_pool(struct device *dev,
+						   u32 count, u32 sge_nr)
 {
+	struct hisi_acc_sgl_pool *pool;
 	u32 sgl_size;
 	u32 size;
 
-	if (!dev || !pool || !count)
-		return -EINVAL;
+	if (!dev || !count || !sge_nr || sge_nr > HISI_ACC_SGL_SGE_NR_MAX)
+		return ERR_PTR(-EINVAL);
 
-	sgl_size = sizeof(struct acc_hw_sge) * acc_sgl_sge_nr +
+	sgl_size = sizeof(struct acc_hw_sge) * sge_nr +
 		   sizeof(struct hisi_acc_hw_sgl);
 	size = sgl_size * count;
 
+	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
+	if (!pool)
+		return ERR_PTR(-ENOMEM);
+
 	pool->sgl = dma_alloc_coherent(dev, size, &pool->sgl_dma, GFP_KERNEL);
-	if (!pool->sgl)
-		return -ENOMEM;
+	if (!pool->sgl) {
+		kfree(pool);
+		return ERR_PTR(-ENOMEM);
+	}
 
 	pool->size = size;
 	pool->count = count;
 	pool->sgl_size = sgl_size;
+	pool->sge_nr = sge_nr;
 
-	return 0;
+	return pool;
 }
 EXPORT_SYMBOL_GPL(hisi_acc_create_sgl_pool);
 
@@ -98,8 +90,11 @@ EXPORT_SYMBOL_GPL(hisi_acc_create_sgl_pool);
  */
 void hisi_acc_free_sgl_pool(struct device *dev, struct hisi_acc_sgl_pool *pool)
 {
+	if (!dev || !pool)
+		return;
+
 	dma_free_coherent(dev, pool->size, pool->sgl, pool->sgl_dma);
-	memset(pool, 0, sizeof(struct hisi_acc_sgl_pool));
+	kfree(pool);
 }
 EXPORT_SYMBOL_GPL(hisi_acc_free_sgl_pool);
 
@@ -156,7 +151,7 @@ hisi_acc_sg_buf_map_to_hw_sgl(struct device *dev,
 	int sg_n = sg_nents(sgl);
 	int i, ret;
 
-	if (!dev || !sgl || !pool || !hw_sgl_dma || sg_n > acc_sgl_sge_nr)
+	if (!dev || !sgl || !pool || !hw_sgl_dma || sg_n > pool->sge_nr)
 		return ERR_PTR(-EINVAL);
 
 	ret = dma_map_sg(dev, sgl, sg_n, DMA_BIDIRECTIONAL);
@@ -168,7 +163,7 @@ hisi_acc_sg_buf_map_to_hw_sgl(struct device *dev,
 		ret = -ENOMEM;
 		goto err_unmap_sg;
 	}
-	curr_hw_sgl->entry_length_in_sgl = acc_sgl_sge_nr;
+	curr_hw_sgl->entry_length_in_sgl = pool->sge_nr;
 	curr_hw_sge = curr_hw_sgl->sge_entries;
 
 	for_each_sg(sgl, sg, sg_n, i) {
@@ -177,7 +172,7 @@ hisi_acc_sg_buf_map_to_hw_sgl(struct device *dev,
 		curr_hw_sge++;
 	}
 
-	update_hw_sgl_sum_sge(curr_hw_sgl, acc_sgl_sge_nr);
+	update_hw_sgl_sum_sge(curr_hw_sgl, pool->sge_nr);
 	*hw_sgl_dma = curr_sgl_dma;
 
 	return curr_hw_sgl;
diff --git a/drivers/crypto/hisilicon/sgl.h b/drivers/crypto/hisilicon/sgl.h
deleted file mode 100644
index 3ac8871..0000000
--- a/drivers/crypto/hisilicon/sgl.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (c) 2019 HiSilicon Limited. */
-#ifndef HISI_ACC_SGL_H
-#define HISI_ACC_SGL_H
-
-struct hisi_acc_sgl_pool {
-	struct hisi_acc_hw_sgl *sgl;
-	dma_addr_t sgl_dma;
-	size_t size;
-	u32 count;
-	size_t sgl_size;
-};
-
-struct hisi_acc_hw_sgl *
-hisi_acc_sg_buf_map_to_hw_sgl(struct device *dev,
-			      struct scatterlist *sgl,
-			      struct hisi_acc_sgl_pool *pool,
-			      u32 index, dma_addr_t *hw_sgl_dma);
-void hisi_acc_sg_buf_unmap(struct device *dev, struct scatterlist *sgl,
-			   struct hisi_acc_hw_sgl *hw_sgl);
-int hisi_acc_create_sgl_pool(struct device *dev, struct hisi_acc_sgl_pool *pool,
-			     u32 count);
-void hisi_acc_free_sgl_pool(struct device *dev, struct hisi_acc_sgl_pool *pool);
-#endif
diff --git a/drivers/crypto/hisilicon/zip/zip.h b/drivers/crypto/hisilicon/zip/zip.h
index ffb00d9..79fc4dd 100644
--- a/drivers/crypto/hisilicon/zip/zip.h
+++ b/drivers/crypto/hisilicon/zip/zip.h
@@ -8,7 +8,6 @@
 
 #include <linux/list.h>
 #include "../qm.h"
-#include "../sgl.h"
 
 /* hisi_zip_sqe dw3 */
 #define HZIP_BD_STATUS_M			GENMASK(7, 0)
diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index 5902354..a82bee5 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -22,6 +22,7 @@
 #define HZIP_CTX_Q_NUM				2
 #define HZIP_GZIP_HEAD_BUF			256
 #define HZIP_ALG_PRIORITY			300
+#define HZIP_SGL_SGE_NR				10
 
 static const u8 zlib_head[HZIP_ZLIB_HEAD_SIZE] = {0x78, 0x9c};
 static const u8 gzip_head[HZIP_GZIP_HEAD_SIZE] = {0x1f, 0x8b, 0x08, 0x0, 0x0,
@@ -67,7 +68,7 @@ struct hisi_zip_qp_ctx {
 	struct hisi_qp *qp;
 	struct hisi_zip_sqe zip_sqe;
 	struct hisi_zip_req_q req_q;
-	struct hisi_acc_sgl_pool sgl_pool;
+	struct hisi_acc_sgl_pool *sgl_pool;
 	struct hisi_zip *zip_dev;
 	struct hisi_zip_ctx *ctx;
 };
@@ -265,14 +266,15 @@ static void hisi_zip_release_req_q(struct hisi_zip_ctx *ctx)
 static int hisi_zip_create_sgl_pool(struct hisi_zip_ctx *ctx)
 {
 	struct hisi_zip_qp_ctx *tmp;
-	int i, ret;
+	struct device *dev;
+	int i;
 
 	for (i = 0; i < HZIP_CTX_Q_NUM; i++) {
 		tmp = &ctx->qp_ctx[i];
-		ret = hisi_acc_create_sgl_pool(&tmp->qp->qm->pdev->dev,
-					       &tmp->sgl_pool,
-					       QM_Q_DEPTH << 1);
-		if (ret < 0) {
+		dev = &tmp->qp->qm->pdev->dev;
+		tmp->sgl_pool = hisi_acc_create_sgl_pool(dev, QM_Q_DEPTH << 1,
+							 HZIP_SGL_SGE_NR);
+		if (IS_ERR(tmp->sgl_pool)) {
 			if (i == 1)
 				goto err_free_sgl_pool0;
 			return -ENOMEM;
@@ -283,7 +285,7 @@ static int hisi_zip_create_sgl_pool(struct hisi_zip_ctx *ctx)
 
 err_free_sgl_pool0:
 	hisi_acc_free_sgl_pool(&ctx->qp_ctx[QPC_COMP].qp->qm->pdev->dev,
-			       &ctx->qp_ctx[QPC_COMP].sgl_pool);
+			       ctx->qp_ctx[QPC_COMP].sgl_pool);
 	return -ENOMEM;
 }
 
@@ -293,7 +295,7 @@ static void hisi_zip_release_sgl_pool(struct hisi_zip_ctx *ctx)
 
 	for (i = 0; i < HZIP_CTX_Q_NUM; i++)
 		hisi_acc_free_sgl_pool(&ctx->qp_ctx[i].qp->qm->pdev->dev,
-				       &ctx->qp_ctx[i].sgl_pool);
+				       ctx->qp_ctx[i].sgl_pool);
 }
 
 static void hisi_zip_remove_req(struct hisi_zip_qp_ctx *qp_ctx,
@@ -512,7 +514,7 @@ static int hisi_zip_do_work(struct hisi_zip_req *req,
 	struct hisi_zip_sqe *zip_sqe = &qp_ctx->zip_sqe;
 	struct hisi_qp *qp = qp_ctx->qp;
 	struct device *dev = &qp->qm->pdev->dev;
-	struct hisi_acc_sgl_pool *pool = &qp_ctx->sgl_pool;
+	struct hisi_acc_sgl_pool *pool = qp_ctx->sgl_pool;
 	dma_addr_t input;
 	dma_addr_t output;
 	int ret;
-- 
2.8.1


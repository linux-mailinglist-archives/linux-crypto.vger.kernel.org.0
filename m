Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3AA7137B2B
	for <lists+linux-crypto@lfdr.de>; Sat, 11 Jan 2020 03:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgAKCpy (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 10 Jan 2020 21:45:54 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45378 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728182AbgAKCpw (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 10 Jan 2020 21:45:52 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 452B18B1822567B7299E;
        Sat, 11 Jan 2020 10:45:49 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Sat, 11 Jan 2020 10:45:42 +0800
From:   Zaibo Xu <xuzaibo@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linuxarm@huawei.com>,
        <jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>,
        <tanghui20@huawei.com>, <yekai13@huawei.com>,
        <liulongfang@huawei.com>, <qianweili@huawei.com>,
        <zhangwei375@huawei.com>, <fanghao11@huawei.com>,
        <forest.zhouchang@huawei.com>
Subject: [PATCH v2 4/9] crypto: hisilicon - Update QP resources of SEC V2
Date:   Sat, 11 Jan 2020 10:41:51 +0800
Message-ID: <1578710516-40535-5-git-send-email-xuzaibo@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1578710516-40535-1-git-send-email-xuzaibo@huawei.com>
References: <1578710516-40535-1-git-send-email-xuzaibo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

1.Put resource including request and resource list into
  QP context structure to avoid allocate memory repeatedly.
2.Add max context queue number to void kcalloc large memory for QP context.
3.Remove the resource allocation operation.
4.Redefine resource allocation APIs to be shared by other algorithms.
5.Move resource allocation and free inner functions out of
  operations 'struct sec_req_op', and they are called directly.

Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec.h        |  12 +--
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 135 ++++++++++++-----------------
 drivers/crypto/hisilicon/sec2/sec_main.c   |   5 +-
 3 files changed, 59 insertions(+), 93 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index 40139ba..c3b6012 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -21,8 +21,6 @@ struct sec_cipher_req {
 	dma_addr_t c_in_dma;
 	struct hisi_acc_hw_sgl *c_out;
 	dma_addr_t c_out_dma;
-	u8 *c_ivin;
-	dma_addr_t c_ivin_dma;
 	struct skcipher_request *sk_req;
 	u32 c_len;
 	bool encrypt;
@@ -45,9 +43,6 @@ struct sec_req {
 
 /**
  * struct sec_req_op - Operations for SEC request
- * @get_res: Get resources for TFM on the SEC device
- * @resource_alloc: Allocate resources for queue context on the SEC device
- * @resource_free: Free resources for queue context on the SEC device
  * @buf_map: DMA map the SGL buffers of the request
  * @buf_unmap: DMA unmap the SGL buffers of the request
  * @bd_fill: Fill the SEC queue BD
@@ -56,9 +51,6 @@ struct sec_req {
  * @process: Main processing logic of Skcipher
  */
 struct sec_req_op {
-	int (*get_res)(struct sec_ctx *ctx, struct sec_req *req);
-	int (*resource_alloc)(struct sec_ctx *ctx, struct sec_qp_ctx *qp_ctx);
-	void (*resource_free)(struct sec_ctx *ctx, struct sec_qp_ctx *qp_ctx);
 	int (*buf_map)(struct sec_ctx *ctx, struct sec_req *req);
 	void (*buf_unmap)(struct sec_ctx *ctx, struct sec_req *req);
 	void (*do_transfer)(struct sec_ctx *ctx, struct sec_req *req);
@@ -83,9 +75,9 @@ struct sec_cipher_ctx {
 /* SEC queue context which defines queue's relatives */
 struct sec_qp_ctx {
 	struct hisi_qp *qp;
-	struct sec_req **req_list;
+	struct sec_req *req_list[QM_Q_DEPTH];
 	struct idr req_idr;
-	void *alg_meta_data;
+	struct sec_alg_res res[QM_Q_DEPTH];
 	struct sec_ctx *ctx;
 	struct mutex req_lock;
 	struct hisi_acc_sgl_pool *c_in_pool;
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 5ef11da..bef88c7 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -150,6 +150,47 @@ static int sec_bd_send(struct sec_ctx *ctx, struct sec_req *req)
 	return ret;
 }
 
+/* Get DMA memory resources */
+static int sec_alloc_civ_resource(struct device *dev, struct sec_alg_res *res)
+{
+	int i;
+
+	res->c_ivin = dma_alloc_coherent(dev, SEC_TOTAL_IV_SZ,
+					 &res->c_ivin_dma, GFP_KERNEL);
+	if (!res->c_ivin)
+		return -ENOMEM;
+
+	for (i = 1; i < QM_Q_DEPTH; i++) {
+		res[i].c_ivin_dma = res->c_ivin_dma + i * SEC_IV_SIZE;
+		res[i].c_ivin = res->c_ivin + i * SEC_IV_SIZE;
+	}
+
+	return 0;
+}
+
+static void sec_free_civ_resource(struct device *dev, struct sec_alg_res *res)
+{
+	if (res->c_ivin)
+		dma_free_coherent(dev, SEC_TOTAL_IV_SZ,
+				  res->c_ivin, res->c_ivin_dma);
+}
+
+static int sec_alg_resource_alloc(struct sec_ctx *ctx,
+				  struct sec_qp_ctx *qp_ctx)
+{
+	struct device *dev = SEC_CTX_DEV(ctx);
+
+	return sec_alloc_civ_resource(dev, qp_ctx->res);
+}
+
+static void sec_alg_resource_free(struct sec_ctx *ctx,
+				  struct sec_qp_ctx *qp_ctx)
+{
+	struct device *dev = SEC_CTX_DEV(ctx);
+
+	sec_free_civ_resource(dev, qp_ctx->res);
+}
+
 static int sec_create_qp_ctx(struct hisi_qm *qm, struct sec_ctx *ctx,
 			     int qp_ctx_id, int alg_type)
 {
@@ -173,15 +214,11 @@ static int sec_create_qp_ctx(struct hisi_qm *qm, struct sec_ctx *ctx,
 	atomic_set(&qp_ctx->pending_reqs, 0);
 	idr_init(&qp_ctx->req_idr);
 
-	qp_ctx->req_list = kcalloc(QM_Q_DEPTH, sizeof(void *), GFP_ATOMIC);
-	if (!qp_ctx->req_list)
-		goto err_destroy_idr;
-
 	qp_ctx->c_in_pool = hisi_acc_create_sgl_pool(dev, QM_Q_DEPTH,
 						     SEC_SGL_SGE_NR);
 	if (IS_ERR(qp_ctx->c_in_pool)) {
 		dev_err(dev, "fail to create sgl pool for input!\n");
-		goto err_free_req_list;
+		goto err_destroy_idr;
 	}
 
 	qp_ctx->c_out_pool = hisi_acc_create_sgl_pool(dev, QM_Q_DEPTH,
@@ -191,7 +228,7 @@ static int sec_create_qp_ctx(struct hisi_qm *qm, struct sec_ctx *ctx,
 		goto err_free_c_in_pool;
 	}
 
-	ret = ctx->req_op->resource_alloc(ctx, qp_ctx);
+	ret = sec_alg_resource_alloc(ctx, qp_ctx);
 	if (ret)
 		goto err_free_c_out_pool;
 
@@ -202,13 +239,11 @@ static int sec_create_qp_ctx(struct hisi_qm *qm, struct sec_ctx *ctx,
 	return 0;
 
 err_queue_free:
-	ctx->req_op->resource_free(ctx, qp_ctx);
+	sec_alg_resource_free(ctx, qp_ctx);
 err_free_c_out_pool:
 	hisi_acc_free_sgl_pool(dev, qp_ctx->c_out_pool);
 err_free_c_in_pool:
 	hisi_acc_free_sgl_pool(dev, qp_ctx->c_in_pool);
-err_free_req_list:
-	kfree(qp_ctx->req_list);
 err_destroy_idr:
 	idr_destroy(&qp_ctx->req_idr);
 	hisi_qm_release_qp(qp);
@@ -222,13 +257,12 @@ static void sec_release_qp_ctx(struct sec_ctx *ctx,
 	struct device *dev = SEC_CTX_DEV(ctx);
 
 	hisi_qm_stop_qp(qp_ctx->qp);
-	ctx->req_op->resource_free(ctx, qp_ctx);
+	sec_alg_resource_free(ctx, qp_ctx);
 
 	hisi_acc_free_sgl_pool(dev, qp_ctx->c_out_pool);
 	hisi_acc_free_sgl_pool(dev, qp_ctx->c_in_pool);
 
 	idr_destroy(&qp_ctx->req_idr);
-	kfree(qp_ctx->req_list);
 	hisi_qm_release_qp(qp_ctx->qp);
 }
 
@@ -420,60 +454,6 @@ GEN_SEC_SETKEY_FUNC(3des_cbc, SEC_CALG_3DES, SEC_CMODE_CBC)
 GEN_SEC_SETKEY_FUNC(sm4_xts, SEC_CALG_SM4, SEC_CMODE_XTS)
 GEN_SEC_SETKEY_FUNC(sm4_cbc, SEC_CALG_SM4, SEC_CMODE_CBC)
 
-static int sec_skcipher_get_res(struct sec_ctx *ctx,
-				struct sec_req *req)
-{
-	struct sec_qp_ctx *qp_ctx = req->qp_ctx;
-	struct sec_alg_res *c_res = qp_ctx->alg_meta_data;
-	struct sec_cipher_req *c_req = &req->c_req;
-	int req_id = req->req_id;
-
-	c_req->c_ivin = c_res[req_id].c_ivin;
-	c_req->c_ivin_dma = c_res[req_id].c_ivin_dma;
-
-	return 0;
-}
-
-static int sec_skcipher_resource_alloc(struct sec_ctx *ctx,
-				       struct sec_qp_ctx *qp_ctx)
-{
-	struct device *dev = SEC_CTX_DEV(ctx);
-	struct sec_alg_res *res;
-	int i;
-
-	res = kcalloc(QM_Q_DEPTH, sizeof(*res), GFP_KERNEL);
-	if (!res)
-		return -ENOMEM;
-
-	res->c_ivin = dma_alloc_coherent(dev, SEC_TOTAL_IV_SZ,
-					   &res->c_ivin_dma, GFP_KERNEL);
-	if (!res->c_ivin) {
-		kfree(res);
-		return -ENOMEM;
-	}
-
-	for (i = 1; i < QM_Q_DEPTH; i++) {
-		res[i].c_ivin_dma = res->c_ivin_dma + i * SEC_IV_SIZE;
-		res[i].c_ivin = res->c_ivin + i * SEC_IV_SIZE;
-	}
-	qp_ctx->alg_meta_data = res;
-
-	return 0;
-}
-
-static void sec_skcipher_resource_free(struct sec_ctx *ctx,
-				      struct sec_qp_ctx *qp_ctx)
-{
-	struct sec_alg_res *res = qp_ctx->alg_meta_data;
-	struct device *dev = SEC_CTX_DEV(ctx);
-
-	if (!res)
-		return;
-
-	dma_free_coherent(dev, SEC_TOTAL_IV_SZ, res->c_ivin, res->c_ivin_dma);
-	kfree(res);
-}
-
 static int sec_cipher_map(struct device *dev, struct sec_req *req,
 			  struct scatterlist *src, struct scatterlist *dst)
 {
@@ -564,10 +544,11 @@ static void sec_request_untransfer(struct sec_ctx *ctx, struct sec_req *req)
 static void sec_skcipher_copy_iv(struct sec_ctx *ctx, struct sec_req *req)
 {
 	struct skcipher_request *sk_req = req->c_req.sk_req;
+	u8 *c_ivin = req->qp_ctx->res[req->req_id].c_ivin;
 	struct sec_cipher_req *c_req = &req->c_req;
 
 	c_req->c_len = sk_req->cryptlen;
-	memcpy(c_req->c_ivin, sk_req->iv, ctx->c_ctx.ivsize);
+	memcpy(c_ivin, sk_req->iv, ctx->c_ctx.ivsize);
 }
 
 static int sec_skcipher_bd_fill(struct sec_ctx *ctx, struct sec_req *req)
@@ -575,14 +556,15 @@ static int sec_skcipher_bd_fill(struct sec_ctx *ctx, struct sec_req *req)
 	struct sec_cipher_ctx *c_ctx = &ctx->c_ctx;
 	struct sec_cipher_req *c_req = &req->c_req;
 	struct sec_sqe *sec_sqe = &req->sec_sqe;
-	u8 de = 0;
 	u8 scene, sa_type, da_type;
 	u8 bd_type, cipher;
+	u8 de = 0;
 
 	memset(sec_sqe, 0, sizeof(struct sec_sqe));
 
 	sec_sqe->type2.c_key_addr = cpu_to_le64(c_ctx->c_key_dma);
-	sec_sqe->type2.c_ivin_addr = cpu_to_le64(c_req->c_ivin_dma);
+	sec_sqe->type2.c_ivin_addr =
+		cpu_to_le64(req->qp_ctx->res[req->req_id].c_ivin_dma);
 	sec_sqe->type2.data_src_addr = cpu_to_le64(c_req->c_in_dma);
 	sec_sqe->type2.data_dst_addr = cpu_to_le64(c_req->c_out_dma);
 
@@ -664,7 +646,7 @@ static void sec_request_uninit(struct sec_ctx *ctx, struct sec_req *req)
 static int sec_request_init(struct sec_ctx *ctx, struct sec_req *req)
 {
 	struct sec_qp_ctx *qp_ctx;
-	int queue_id, ret;
+	int queue_id;
 
 	/* To load balance */
 	queue_id = sec_alloc_queue_id(ctx, req);
@@ -681,14 +663,7 @@ static int sec_request_init(struct sec_ctx *ctx, struct sec_req *req)
 	else
 		req->fake_busy = false;
 
-	ret = ctx->req_op->get_res(ctx, req);
-	if (ret) {
-		atomic_dec(&qp_ctx->pending_reqs);
-		sec_request_uninit(ctx, req);
-		dev_err(SEC_CTX_DEV(ctx), "get resources failed!\n");
-	}
-
-	return ret;
+	return 0;
 }
 
 static int sec_process(struct sec_ctx *ctx, struct sec_req *req)
@@ -718,7 +693,8 @@ static int sec_process(struct sec_ctx *ctx, struct sec_req *req)
 err_send_req:
 	/* As failing, restore the IV from user */
 	if (ctx->c_ctx.c_mode == SEC_CMODE_CBC && !req->c_req.encrypt)
-		memcpy(req->c_req.sk_req->iv, req->c_req.c_ivin,
+		memcpy(req->c_req.sk_req->iv,
+		       req->qp_ctx->res[req->req_id].c_ivin,
 		       ctx->c_ctx.ivsize);
 
 	sec_request_untransfer(ctx, req);
@@ -729,9 +705,6 @@ static int sec_process(struct sec_ctx *ctx, struct sec_req *req)
 }
 
 static const struct sec_req_op sec_skcipher_req_ops = {
-	.get_res	= sec_skcipher_get_res,
-	.resource_alloc	= sec_skcipher_resource_alloc,
-	.resource_free	= sec_skcipher_resource_free,
 	.buf_map	= sec_skcipher_sgl_map,
 	.buf_unmap	= sec_skcipher_sgl_unmap,
 	.do_transfer	= sec_skcipher_copy_iv,
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index d40e2da..2bbaf1e 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -32,6 +32,7 @@
 #define SEC_PF_DEF_Q_NUM		64
 #define SEC_PF_DEF_Q_BASE		0
 #define SEC_CTX_Q_NUM_DEF		24
+#define SEC_CTX_Q_NUM_MAX		32
 
 #define SEC_CTRL_CNT_CLR_CE		0x301120
 #define SEC_CTRL_CNT_CLR_CE_BIT		BIT(0)
@@ -221,7 +222,7 @@ static int sec_ctx_q_num_set(const char *val, const struct kernel_param *kp)
 	if (ret)
 		return -EINVAL;
 
-	if (!ctx_q_num || ctx_q_num > QM_Q_DEPTH || ctx_q_num & 0x1) {
+	if (!ctx_q_num || ctx_q_num > SEC_CTX_Q_NUM_MAX || ctx_q_num & 0x1) {
 		pr_err("ctx queue num[%u] is invalid!\n", ctx_q_num);
 		return -EINVAL;
 	}
@@ -235,7 +236,7 @@ static const struct kernel_param_ops sec_ctx_q_num_ops = {
 };
 static u32 ctx_q_num = SEC_CTX_Q_NUM_DEF;
 module_param_cb(ctx_q_num, &sec_ctx_q_num_ops, &ctx_q_num, 0444);
-MODULE_PARM_DESC(ctx_q_num, "Number of queue in ctx (2, 4, 6, ..., 1024)");
+MODULE_PARM_DESC(ctx_q_num, "Queue num in ctx (24 default, 2, 4, ..., 32)");
 
 static const struct pci_device_id sec_dev_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, SEC_PF_PCI_DEVICE_ID) },
-- 
2.8.1


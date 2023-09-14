Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA61579FFBA
	for <lists+linux-crypto@lfdr.de>; Thu, 14 Sep 2023 11:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbjINJKN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 14 Sep 2023 05:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236903AbjINJJp (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 14 Sep 2023 05:09:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F2C1FE7;
        Thu, 14 Sep 2023 02:09:12 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RmWcG356PztSfw;
        Thu, 14 Sep 2023 17:05:02 +0800 (CST)
Received: from localhost.huawei.com (10.50.163.32) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 14 Sep 2023 17:09:10 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>
Subject: [PATCH 2/2] crypto: hisilicon/zip - remove zlib and gzip
Date:   Thu, 14 Sep 2023 17:09:08 +0800
Message-ID: <20230914090908.3849318-3-shenyang39@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230914090908.3849318-1-shenyang39@huawei.com>
References: <20230914090908.3849318-1-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Remove the support of zlib-deflate and gzip.

Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 drivers/crypto/hisilicon/zip/zip_crypto.c | 308 ++--------------------
 drivers/crypto/hisilicon/zip/zip_main.c   |   2 +-
 2 files changed, 22 insertions(+), 288 deletions(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index 09f60f786779..636ac794ebb7 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -17,38 +17,14 @@
 /* hisi_zip_sqe dw9 */
 #define HZIP_REQ_TYPE_M				GENMASK(7, 0)
 #define HZIP_ALG_TYPE_DEFLATE			0x01
-#define HZIP_ALG_TYPE_ZLIB			0x02
-#define HZIP_ALG_TYPE_GZIP			0x03
 #define HZIP_BUF_TYPE_M				GENMASK(11, 8)
-#define HZIP_PBUFFER				0x0
 #define HZIP_SGL				0x1
 
-#define HZIP_ZLIB_HEAD_SIZE			2
-#define HZIP_GZIP_HEAD_SIZE			10
-
-#define GZIP_HEAD_FHCRC_BIT			BIT(1)
-#define GZIP_HEAD_FEXTRA_BIT			BIT(2)
-#define GZIP_HEAD_FNAME_BIT			BIT(3)
-#define GZIP_HEAD_FCOMMENT_BIT			BIT(4)
-
-#define GZIP_HEAD_FLG_SHIFT			3
-#define GZIP_HEAD_FEXTRA_SHIFT			10
-#define GZIP_HEAD_FEXTRA_XLEN			2UL
-#define GZIP_HEAD_FHCRC_SIZE			2
-
-#define HZIP_GZIP_HEAD_BUF			256
 #define HZIP_ALG_PRIORITY			300
 #define HZIP_SGL_SGE_NR				10
 
-#define HZIP_ALG_ZLIB				GENMASK(1, 0)
-#define HZIP_ALG_GZIP				GENMASK(3, 2)
 #define HZIP_ALG_DEFLATE			GENMASK(5, 4)
 
-static const u8 zlib_head[HZIP_ZLIB_HEAD_SIZE] = {0x78, 0x9c};
-static const u8 gzip_head[HZIP_GZIP_HEAD_SIZE] = {
-	0x1f, 0x8b, 0x08, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x03
-};
-
 enum hisi_zip_alg_type {
 	HZIP_ALG_TYPE_COMP = 0,
 	HZIP_ALG_TYPE_DECOMP = 1,
@@ -61,22 +37,10 @@ enum {
 };
 
 #define COMP_NAME_TO_TYPE(alg_name)					\
-	(!strcmp((alg_name), "deflate") ? HZIP_ALG_TYPE_DEFLATE :	\
-	(!strcmp((alg_name), "zlib-deflate") ? HZIP_ALG_TYPE_ZLIB :	\
-	 !strcmp((alg_name), "gzip") ? HZIP_ALG_TYPE_GZIP : 0))		\
-
-#define TO_HEAD_SIZE(req_type)						\
-	(((req_type) == HZIP_ALG_TYPE_ZLIB) ? sizeof(zlib_head) :	\
-	 ((req_type) == HZIP_ALG_TYPE_GZIP) ? sizeof(gzip_head) : 0)	\
-
-#define TO_HEAD(req_type)						\
-	(((req_type) == HZIP_ALG_TYPE_ZLIB) ? zlib_head :		\
-	 ((req_type) == HZIP_ALG_TYPE_GZIP) ? gzip_head : NULL)		\
+	(!strcmp((alg_name), "deflate") ? HZIP_ALG_TYPE_DEFLATE : 0)
 
 struct hisi_zip_req {
 	struct acomp_req *req;
-	u32 sskip;
-	u32 dskip;
 	struct hisi_acc_hw_sgl *hw_src;
 	struct hisi_acc_hw_sgl *hw_dst;
 	dma_addr_t dma_src;
@@ -141,85 +105,8 @@ static u16 sgl_sge_nr = HZIP_SGL_SGE_NR;
 module_param_cb(sgl_sge_nr, &sgl_sge_nr_ops, &sgl_sge_nr, 0444);
 MODULE_PARM_DESC(sgl_sge_nr, "Number of sge in sgl(1-255)");
 
-static u32 get_extra_field_size(const u8 *start)
-{
-	return *((u16 *)start) + GZIP_HEAD_FEXTRA_XLEN;
-}
-
-static u32 get_name_field_size(const u8 *start)
-{
-	return strlen(start) + 1;
-}
-
-static u32 get_comment_field_size(const u8 *start)
-{
-	return strlen(start) + 1;
-}
-
-static u32 __get_gzip_head_size(const u8 *src)
-{
-	u8 head_flg = *(src + GZIP_HEAD_FLG_SHIFT);
-	u32 size = GZIP_HEAD_FEXTRA_SHIFT;
-
-	if (head_flg & GZIP_HEAD_FEXTRA_BIT)
-		size += get_extra_field_size(src + size);
-	if (head_flg & GZIP_HEAD_FNAME_BIT)
-		size += get_name_field_size(src + size);
-	if (head_flg & GZIP_HEAD_FCOMMENT_BIT)
-		size += get_comment_field_size(src + size);
-	if (head_flg & GZIP_HEAD_FHCRC_BIT)
-		size += GZIP_HEAD_FHCRC_SIZE;
-
-	return size;
-}
-
-static u32 __maybe_unused get_gzip_head_size(struct scatterlist *sgl)
-{
-	char buf[HZIP_GZIP_HEAD_BUF];
-
-	sg_copy_to_buffer(sgl, sg_nents(sgl), buf, sizeof(buf));
-
-	return __get_gzip_head_size(buf);
-}
-
-static int add_comp_head(struct scatterlist *dst, u8 req_type)
-{
-	int head_size = TO_HEAD_SIZE(req_type);
-	const u8 *head = TO_HEAD(req_type);
-	int ret;
-
-	ret = sg_copy_from_buffer(dst, sg_nents(dst), head, head_size);
-	if (unlikely(ret != head_size)) {
-		pr_err("the head size of buffer is wrong (%d)!\n", ret);
-		return -ENOMEM;
-	}
-
-	return head_size;
-}
-
-static int get_comp_head_size(struct acomp_req *acomp_req, u8 req_type)
-{
-	if (unlikely(!acomp_req->src || !acomp_req->slen))
-		return -EINVAL;
-
-	if (unlikely(req_type == HZIP_ALG_TYPE_GZIP &&
-		     acomp_req->slen < GZIP_HEAD_FEXTRA_SHIFT))
-		return -EINVAL;
-
-	switch (req_type) {
-	case HZIP_ALG_TYPE_ZLIB:
-		return TO_HEAD_SIZE(HZIP_ALG_TYPE_ZLIB);
-	case HZIP_ALG_TYPE_GZIP:
-		return TO_HEAD_SIZE(HZIP_ALG_TYPE_GZIP);
-	default:
-		pr_err("request type does not support!\n");
-		return -EINVAL;
-	}
-}
-
-static struct hisi_zip_req *hisi_zip_create_req(struct acomp_req *req,
-						struct hisi_zip_qp_ctx *qp_ctx,
-						size_t head_size, bool is_comp)
+static struct hisi_zip_req *hisi_zip_create_req(struct hisi_zip_qp_ctx *qp_ctx,
+						struct acomp_req *req)
 {
 	struct hisi_zip_req_q *req_q = &qp_ctx->req_q;
 	struct hisi_zip_req *q = req_q->q;
@@ -242,14 +129,6 @@ static struct hisi_zip_req *hisi_zip_create_req(struct acomp_req *req,
 	req_cache->req_id = req_id;
 	req_cache->req = req;
 
-	if (is_comp) {
-		req_cache->sskip = 0;
-		req_cache->dskip = head_size;
-	} else {
-		req_cache->sskip = head_size;
-		req_cache->dskip = 0;
-	}
-
 	return req_cache;
 }
 
@@ -275,10 +154,8 @@ static void hisi_zip_fill_buf_size(struct hisi_zip_sqe *sqe, struct hisi_zip_req
 {
 	struct acomp_req *a_req = req->req;
 
-	sqe->input_data_length = a_req->slen - req->sskip;
-	sqe->dest_avail_out = a_req->dlen - req->dskip;
-	sqe->dw7 = FIELD_PREP(HZIP_IN_SGE_DATA_OFFSET_M, req->sskip);
-	sqe->dw8 = FIELD_PREP(HZIP_OUT_SGE_DATA_OFFSET_M, req->dskip);
+	sqe->input_data_length = a_req->slen;
+	sqe->dest_avail_out = a_req->dlen;
 }
 
 static void hisi_zip_fill_buf_type(struct hisi_zip_sqe *sqe, u8 buf_type)
@@ -299,12 +176,7 @@ static void hisi_zip_fill_req_type(struct hisi_zip_sqe *sqe, u8 req_type)
 	sqe->dw9 = val;
 }
 
-static void hisi_zip_fill_tag_v1(struct hisi_zip_sqe *sqe, struct hisi_zip_req *req)
-{
-	sqe->dw13 = req->req_id;
-}
-
-static void hisi_zip_fill_tag_v2(struct hisi_zip_sqe *sqe, struct hisi_zip_req *req)
+static void hisi_zip_fill_tag(struct hisi_zip_sqe *sqe, struct hisi_zip_req *req)
 {
 	sqe->dw26 = req->req_id;
 }
@@ -333,8 +205,8 @@ static void hisi_zip_fill_sqe(struct hisi_zip_ctx *ctx, struct hisi_zip_sqe *sqe
 	ops->fill_sqe_type(sqe, ops->sqe_type);
 }
 
-static int hisi_zip_do_work(struct hisi_zip_req *req,
-			    struct hisi_zip_qp_ctx *qp_ctx)
+static int hisi_zip_do_work(struct hisi_zip_qp_ctx *qp_ctx,
+			    struct hisi_zip_req *req)
 {
 	struct hisi_acc_sgl_pool *pool = qp_ctx->sgl_pool;
 	struct hisi_zip_dfx *dfx = &qp_ctx->zip_dev->dfx;
@@ -386,12 +258,7 @@ static int hisi_zip_do_work(struct hisi_zip_req *req,
 	return ret;
 }
 
-static u32 hisi_zip_get_tag_v1(struct hisi_zip_sqe *sqe)
-{
-	return sqe->dw13;
-}
-
-static u32 hisi_zip_get_tag_v2(struct hisi_zip_sqe *sqe)
+static u32 hisi_zip_get_tag(struct hisi_zip_sqe *sqe)
 {
 	return sqe->dw26;
 }
@@ -417,8 +284,8 @@ static void hisi_zip_acomp_cb(struct hisi_qp *qp, void *data)
 	u32 tag = ops->get_tag(sqe);
 	struct hisi_zip_req *req = req_q->q + tag;
 	struct acomp_req *acomp_req = req->req;
-	u32 status, dlen, head_size;
 	int err = 0;
+	u32 status;
 
 	atomic64_inc(&dfx->recv_cnt);
 	status = ops->get_status(sqe);
@@ -430,13 +297,10 @@ static void hisi_zip_acomp_cb(struct hisi_qp *qp, void *data)
 		err = -EIO;
 	}
 
-	dlen = ops->get_dstlen(sqe);
-
 	hisi_acc_sg_buf_unmap(dev, acomp_req->src, req->hw_src);
 	hisi_acc_sg_buf_unmap(dev, acomp_req->dst, req->hw_dst);
 
-	head_size = (qp->alg_type == 0) ? TO_HEAD_SIZE(qp->req_type) : 0;
-	acomp_req->dlen = dlen + head_size;
+	acomp_req->dlen = ops->get_dstlen(sqe);
 
 	if (acomp_req->base.complete)
 		acomp_request_complete(acomp_req, err);
@@ -450,24 +314,13 @@ static int hisi_zip_acompress(struct acomp_req *acomp_req)
 	struct hisi_zip_qp_ctx *qp_ctx = &ctx->qp_ctx[HZIP_QPC_COMP];
 	struct device *dev = &qp_ctx->qp->qm->pdev->dev;
 	struct hisi_zip_req *req;
-	int head_size = 0;
 	int ret;
 
-	/* let's output compression head now */
-	if (qp_ctx->qp->req_type != HZIP_ALG_TYPE_DEFLATE) {
-		head_size = add_comp_head(acomp_req->dst, qp_ctx->qp->req_type);
-		if (unlikely(head_size < 0)) {
-			dev_err_ratelimited(dev, "failed to add comp head (%d)!\n",
-					head_size);
-			return head_size;
-		}
-	}
-
-	req = hisi_zip_create_req(acomp_req, qp_ctx, head_size, true);
+	req = hisi_zip_create_req(qp_ctx, acomp_req);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	ret = hisi_zip_do_work(req, qp_ctx);
+	ret = hisi_zip_do_work(qp_ctx, req);
 	if (unlikely(ret != -EINPROGRESS)) {
 		dev_info_ratelimited(dev, "failed to do compress (%d)!\n", ret);
 		hisi_zip_remove_req(qp_ctx, req);
@@ -482,22 +335,13 @@ static int hisi_zip_adecompress(struct acomp_req *acomp_req)
 	struct hisi_zip_qp_ctx *qp_ctx = &ctx->qp_ctx[HZIP_QPC_DECOMP];
 	struct device *dev = &qp_ctx->qp->qm->pdev->dev;
 	struct hisi_zip_req *req;
-	int head_size = 0, ret;
-
-	if (qp_ctx->qp->req_type != HZIP_ALG_TYPE_DEFLATE) {
-		head_size = get_comp_head_size(acomp_req, qp_ctx->qp->req_type);
-		if (unlikely(head_size < 0)) {
-			dev_err_ratelimited(dev, "failed to get comp head size (%d)!\n",
-					head_size);
-			return head_size;
-		}
-	}
+	int ret;
 
-	req = hisi_zip_create_req(acomp_req, qp_ctx, head_size, false);
+	req = hisi_zip_create_req(qp_ctx, acomp_req);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	ret = hisi_zip_do_work(req, qp_ctx);
+	ret = hisi_zip_do_work(qp_ctx, req);
 	if (unlikely(ret != -EINPROGRESS)) {
 		dev_info_ratelimited(dev, "failed to do decompress (%d)!\n",
 				     ret);
@@ -534,28 +378,15 @@ static void hisi_zip_release_qp(struct hisi_zip_qp_ctx *qp_ctx)
 	hisi_qm_free_qps(&qp_ctx->qp, 1);
 }
 
-static const struct hisi_zip_sqe_ops hisi_zip_ops_v1 = {
-	.sqe_type		= 0,
-	.fill_addr		= hisi_zip_fill_addr,
-	.fill_buf_size		= hisi_zip_fill_buf_size,
-	.fill_buf_type		= hisi_zip_fill_buf_type,
-	.fill_req_type		= hisi_zip_fill_req_type,
-	.fill_tag		= hisi_zip_fill_tag_v1,
-	.fill_sqe_type		= hisi_zip_fill_sqe_type,
-	.get_tag		= hisi_zip_get_tag_v1,
-	.get_status		= hisi_zip_get_status,
-	.get_dstlen		= hisi_zip_get_dstlen,
-};
-
-static const struct hisi_zip_sqe_ops hisi_zip_ops_v2 = {
+static const struct hisi_zip_sqe_ops hisi_zip_ops = {
 	.sqe_type		= 0x3,
 	.fill_addr		= hisi_zip_fill_addr,
 	.fill_buf_size		= hisi_zip_fill_buf_size,
 	.fill_buf_type		= hisi_zip_fill_buf_type,
 	.fill_req_type		= hisi_zip_fill_req_type,
-	.fill_tag		= hisi_zip_fill_tag_v2,
+	.fill_tag		= hisi_zip_fill_tag,
 	.fill_sqe_type		= hisi_zip_fill_sqe_type,
-	.get_tag		= hisi_zip_get_tag_v2,
+	.get_tag		= hisi_zip_get_tag,
 	.get_status		= hisi_zip_get_status,
 	.get_dstlen		= hisi_zip_get_dstlen,
 };
@@ -591,10 +422,7 @@ static int hisi_zip_ctx_init(struct hisi_zip_ctx *hisi_zip_ctx, u8 req_type, int
 		qp_ctx->zip_dev = hisi_zip;
 	}
 
-	if (hisi_zip->qm.ver < QM_HW_V3)
-		hisi_zip_ctx->ops = &hisi_zip_ops_v1;
-	else
-		hisi_zip_ctx->ops = &hisi_zip_ops_v2;
+	hisi_zip_ctx->ops = &hisi_zip_ops;
 
 	return 0;
 }
@@ -788,106 +616,12 @@ static void hisi_zip_unregister_deflate(struct hisi_qm *qm)
 	crypto_unregister_acomp(&hisi_zip_acomp_deflate);
 }
 
-static struct acomp_alg hisi_zip_acomp_zlib = {
-	.init			= hisi_zip_acomp_init,
-	.exit			= hisi_zip_acomp_exit,
-	.compress		= hisi_zip_acompress,
-	.decompress		= hisi_zip_adecompress,
-	.base			= {
-		.cra_name		= "zlib-deflate",
-		.cra_driver_name	= "hisi-zlib-acomp",
-		.cra_module		= THIS_MODULE,
-		.cra_priority           = HZIP_ALG_PRIORITY,
-		.cra_ctxsize		= sizeof(struct hisi_zip_ctx),
-	}
-};
-
-static int hisi_zip_register_zlib(struct hisi_qm *qm)
-{
-	int ret;
-
-	if (!hisi_zip_alg_support(qm, HZIP_ALG_ZLIB))
-		return 0;
-
-	ret = crypto_register_acomp(&hisi_zip_acomp_zlib);
-	if (ret)
-		dev_err(&qm->pdev->dev, "failed to register to zlib (%d)!\n", ret);
-
-	return ret;
-}
-
-static void hisi_zip_unregister_zlib(struct hisi_qm *qm)
-{
-	if (!hisi_zip_alg_support(qm, HZIP_ALG_ZLIB))
-		return;
-
-	crypto_unregister_acomp(&hisi_zip_acomp_zlib);
-}
-
-static struct acomp_alg hisi_zip_acomp_gzip = {
-	.init			= hisi_zip_acomp_init,
-	.exit			= hisi_zip_acomp_exit,
-	.compress		= hisi_zip_acompress,
-	.decompress		= hisi_zip_adecompress,
-	.base			= {
-		.cra_name		= "gzip",
-		.cra_driver_name	= "hisi-gzip-acomp",
-		.cra_module		= THIS_MODULE,
-		.cra_priority           = HZIP_ALG_PRIORITY,
-		.cra_ctxsize		= sizeof(struct hisi_zip_ctx),
-	}
-};
-
-static int hisi_zip_register_gzip(struct hisi_qm *qm)
-{
-	int ret;
-
-	if (!hisi_zip_alg_support(qm, HZIP_ALG_GZIP))
-		return 0;
-
-	ret = crypto_register_acomp(&hisi_zip_acomp_gzip);
-	if (ret)
-		dev_err(&qm->pdev->dev, "failed to register to gzip (%d)!\n", ret);
-
-	return ret;
-}
-
-static void hisi_zip_unregister_gzip(struct hisi_qm *qm)
-{
-	if (!hisi_zip_alg_support(qm, HZIP_ALG_GZIP))
-		return;
-
-	crypto_unregister_acomp(&hisi_zip_acomp_gzip);
-}
-
 int hisi_zip_register_to_crypto(struct hisi_qm *qm)
 {
-	int ret = 0;
-
-	ret = hisi_zip_register_deflate(qm);
-	if (ret)
-		return ret;
-
-	ret = hisi_zip_register_zlib(qm);
-	if (ret)
-		goto err_unreg_deflate;
-
-	ret = hisi_zip_register_gzip(qm);
-	if (ret)
-		goto err_unreg_zlib;
-
-	return 0;
-
-err_unreg_zlib:
-	hisi_zip_unregister_zlib(qm);
-err_unreg_deflate:
-	hisi_zip_unregister_deflate(qm);
-	return ret;
+	return hisi_zip_register_deflate(qm);
 }
 
 void hisi_zip_unregister_from_crypto(struct hisi_qm *qm)
 {
 	hisi_zip_unregister_deflate(qm);
-	hisi_zip_unregister_zlib(qm);
-	hisi_zip_unregister_gzip(qm);
 }
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index da7a23c0e594..0d5d1ee363e4 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -236,7 +236,7 @@ static struct hisi_qm_cap_info zip_basic_cap_info[] = {
 	{ZIP_CLUSTER_DECOMP_NUM_CAP, 0x313C, 0, GENMASK(7, 0), 0x6, 0x6, 0x3},
 	{ZIP_DECOMP_ENABLE_BITMAP, 0x3140, 16, GENMASK(15, 0), 0xFC, 0xFC, 0x1C},
 	{ZIP_COMP_ENABLE_BITMAP, 0x3140, 0, GENMASK(15, 0), 0x3, 0x3, 0x3},
-	{ZIP_DRV_ALG_BITMAP, 0x3144, 0, GENMASK(31, 0), 0xF, 0xF, 0x3F},
+	{ZIP_DRV_ALG_BITMAP, 0x3144, 0, GENMASK(31, 0), 0x0, 0x0, 0x30},
 	{ZIP_DEV_ALG_BITMAP, 0x3148, 0, GENMASK(31, 0), 0xF, 0xF, 0x3F},
 	{ZIP_CORE1_ALG_BITMAP, 0x314C, 0, GENMASK(31, 0), 0x5, 0x5, 0xD5},
 	{ZIP_CORE2_ALG_BITMAP, 0x3150, 0, GENMASK(31, 0), 0x5, 0x5, 0xD5},
-- 
2.33.0


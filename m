Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0539010170D
	for <lists+linux-crypto@lfdr.de>; Tue, 19 Nov 2019 07:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbfKSFqg (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 19 Nov 2019 00:46:36 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:54768 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731121AbfKSFqg (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 19 Nov 2019 00:46:36 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A7ECD31ACDFCB584D468;
        Tue, 19 Nov 2019 13:46:34 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Tue, 19 Nov 2019 13:46:27 +0800
From:   Zhou Wang <wangzhou1@hisilicon.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linuxarm@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH 2/3] crypto: hisilicon - Use the offset fields in sqe to avoid need to split scatterlists
Date:   Tue, 19 Nov 2019 13:42:57 +0800
Message-ID: <1574142178-76514-3-git-send-email-wangzhou1@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1574142178-76514-1-git-send-email-wangzhou1@hisilicon.com>
References: <1574142178-76514-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

We can configure sgl offset fields in ZIP sqe to let ZIP engine read/write
sgl data with skipped data. Hence no need to splite the sgl.

Fixes: 62c455ca853e (crypto: hisilicon - add HiSilicon ZIP accelerator support)
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/Kconfig          |  1 -
 drivers/crypto/hisilicon/zip/zip.h        |  4 ++
 drivers/crypto/hisilicon/zip/zip_crypto.c | 92 ++++++++-----------------------
 3 files changed, 27 insertions(+), 70 deletions(-)

diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
index 3e07ae2..17cb12b 100644
--- a/drivers/crypto/hisilicon/Kconfig
+++ b/drivers/crypto/hisilicon/Kconfig
@@ -28,7 +28,6 @@ config CRYPTO_DEV_HISI_ZIP
 	depends on ARM64 || (COMPILE_TEST && 64BIT)
 	depends on !CPU_BIG_ENDIAN || COMPILE_TEST
 	select CRYPTO_DEV_HISI_QM
-	select SG_SPLIT
 	help
 	  Support for HiSilicon ZIP Driver
 
diff --git a/drivers/crypto/hisilicon/zip/zip.h b/drivers/crypto/hisilicon/zip/zip.h
index 79fc4dd..bc1db26 100644
--- a/drivers/crypto/hisilicon/zip/zip.h
+++ b/drivers/crypto/hisilicon/zip/zip.h
@@ -11,6 +11,10 @@
 
 /* hisi_zip_sqe dw3 */
 #define HZIP_BD_STATUS_M			GENMASK(7, 0)
+/* hisi_zip_sqe dw7 */
+#define HZIP_IN_SGE_DATA_OFFSET_M		GENMASK(23, 0)
+/* hisi_zip_sqe dw8 */
+#define HZIP_OUT_SGE_DATA_OFFSET_M		GENMASK(23, 0)
 /* hisi_zip_sqe dw9 */
 #define HZIP_REQ_TYPE_M				GENMASK(7, 0)
 #define HZIP_ALG_TYPE_ZLIB			0x02
diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index 795428c..9815d5e 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -46,10 +46,8 @@ enum hisi_zip_alg_type {
 
 struct hisi_zip_req {
 	struct acomp_req *req;
-	struct scatterlist *src;
-	struct scatterlist *dst;
-	size_t slen;
-	size_t dlen;
+	int sskip;
+	int dskip;
 	struct hisi_acc_hw_sgl *hw_src;
 	struct hisi_acc_hw_sgl *hw_dst;
 	dma_addr_t dma_src;
@@ -119,13 +117,15 @@ static void hisi_zip_config_tag(struct hisi_zip_sqe *sqe, u32 tag)
 
 static void hisi_zip_fill_sqe(struct hisi_zip_sqe *sqe, u8 req_type,
 			      dma_addr_t s_addr, dma_addr_t d_addr, u32 slen,
-			      u32 dlen)
+			      u32 dlen, int sskip, int dskip)
 {
 	memset(sqe, 0, sizeof(struct hisi_zip_sqe));
 
-	sqe->input_data_length = slen;
+	sqe->input_data_length = slen - sskip;
+	sqe->dw7 = FIELD_PREP(HZIP_IN_SGE_DATA_OFFSET_M, sskip);
+	sqe->dw8 = FIELD_PREP(HZIP_OUT_SGE_DATA_OFFSET_M, dskip);
 	sqe->dw9 = FIELD_PREP(HZIP_REQ_TYPE_M, req_type);
-	sqe->dest_avail_out = dlen;
+	sqe->dest_avail_out = dlen - dskip;
 	sqe->source_addr_l = lower_32_bits(s_addr);
 	sqe->source_addr_h = upper_32_bits(s_addr);
 	sqe->dest_addr_l = lower_32_bits(d_addr);
@@ -327,11 +327,6 @@ static void hisi_zip_remove_req(struct hisi_zip_qp_ctx *qp_ctx,
 {
 	struct hisi_zip_req_q *req_q = &qp_ctx->req_q;
 
-	if (qp_ctx->qp->alg_type == HZIP_ALG_TYPE_COMP)
-		kfree(req->dst);
-	else
-		kfree(req->src);
-
 	write_lock(&req_q->req_lock);
 	clear_bit(req->req_id, req_q->req_bitmap);
 	memset(req, 0, sizeof(struct hisi_zip_req));
@@ -359,8 +354,8 @@ static void hisi_zip_acomp_cb(struct hisi_qp *qp, void *data)
 	}
 	dlen = sqe->produced;
 
-	hisi_acc_sg_buf_unmap(dev, req->src, req->hw_src);
-	hisi_acc_sg_buf_unmap(dev, req->dst, req->hw_dst);
+	hisi_acc_sg_buf_unmap(dev, acomp_req->src, req->hw_src);
+	hisi_acc_sg_buf_unmap(dev, acomp_req->dst, req->hw_dst);
 
 	head_size = (qp->alg_type == 0) ? TO_HEAD_SIZE(qp->req_type) : 0;
 	acomp_req->dlen = dlen + head_size;
@@ -454,20 +449,6 @@ static size_t get_comp_head_size(struct scatterlist *src, u8 req_type)
 	}
 }
 
-static int get_sg_skip_bytes(struct scatterlist *sgl, size_t bytes,
-			     size_t remains, struct scatterlist **out)
-{
-#define SPLIT_NUM 2
-	size_t split_sizes[SPLIT_NUM];
-	int out_mapped_nents[SPLIT_NUM];
-
-	split_sizes[0] = bytes;
-	split_sizes[1] = remains;
-
-	return sg_split(sgl, 0, 0, SPLIT_NUM, split_sizes, out,
-			out_mapped_nents, GFP_KERNEL);
-}
-
 static struct hisi_zip_req *hisi_zip_create_req(struct acomp_req *req,
 						struct hisi_zip_qp_ctx *qp_ctx,
 						size_t head_size, bool is_comp)
@@ -475,31 +456,7 @@ static struct hisi_zip_req *hisi_zip_create_req(struct acomp_req *req,
 	struct hisi_zip_req_q *req_q = &qp_ctx->req_q;
 	struct hisi_zip_req *q = req_q->q;
 	struct hisi_zip_req *req_cache;
-	struct scatterlist *out[2];
-	struct scatterlist *sgl;
-	size_t len;
-	int ret, req_id;
-
-	/*
-	 * remove/add zlib/gzip head, as hardware operations do not include
-	 * comp head. so split req->src to get sgl without heads in acomp, or
-	 * add comp head to req->dst ahead of that hardware output compressed
-	 * data in sgl splited from req->dst without comp head.
-	 */
-	if (is_comp) {
-		sgl = req->dst;
-		len = req->dlen - head_size;
-	} else {
-		sgl = req->src;
-		len = req->slen - head_size;
-	}
-
-	ret = get_sg_skip_bytes(sgl, head_size, len, out);
-	if (ret)
-		return ERR_PTR(ret);
-
-	/* sgl for comp head is useless, so free it now */
-	kfree(out[0]);
+	int req_id;
 
 	write_lock(&req_q->req_lock);
 
@@ -507,7 +464,6 @@ static struct hisi_zip_req *hisi_zip_create_req(struct acomp_req *req,
 	if (req_id >= req_q->size) {
 		write_unlock(&req_q->req_lock);
 		dev_dbg(&qp_ctx->qp->qm->pdev->dev, "req cache is full!\n");
-		kfree(out[1]);
 		return ERR_PTR(-EBUSY);
 	}
 	set_bit(req_id, req_q->req_bitmap);
@@ -515,16 +471,13 @@ static struct hisi_zip_req *hisi_zip_create_req(struct acomp_req *req,
 	req_cache = q + req_id;
 	req_cache->req_id = req_id;
 	req_cache->req = req;
+
 	if (is_comp) {
-		req_cache->src = req->src;
-		req_cache->dst = out[1];
-		req_cache->slen = req->slen;
-		req_cache->dlen = req->dlen - head_size;
+		req_cache->sskip = 0;
+		req_cache->dskip = head_size;
 	} else {
-		req_cache->src = out[1];
-		req_cache->dst = req->dst;
-		req_cache->slen = req->slen - head_size;
-		req_cache->dlen = req->dlen;
+		req_cache->sskip = head_size;
+		req_cache->dskip = 0;
 	}
 
 	write_unlock(&req_q->req_lock);
@@ -536,6 +489,7 @@ static int hisi_zip_do_work(struct hisi_zip_req *req,
 			    struct hisi_zip_qp_ctx *qp_ctx)
 {
 	struct hisi_zip_sqe *zip_sqe = &qp_ctx->zip_sqe;
+	struct acomp_req *a_req = req->req;
 	struct hisi_qp *qp = qp_ctx->qp;
 	struct device *dev = &qp->qm->pdev->dev;
 	struct hisi_acc_sgl_pool *pool = qp_ctx->sgl_pool;
@@ -543,16 +497,16 @@ static int hisi_zip_do_work(struct hisi_zip_req *req,
 	dma_addr_t output;
 	int ret;
 
-	if (!req->src || !req->slen || !req->dst || !req->dlen)
+	if (!a_req->src || !a_req->slen || !a_req->dst || !a_req->dlen)
 		return -EINVAL;
 
-	req->hw_src = hisi_acc_sg_buf_map_to_hw_sgl(dev, req->src, pool,
+	req->hw_src = hisi_acc_sg_buf_map_to_hw_sgl(dev, a_req->src, pool,
 						    req->req_id << 1, &input);
 	if (IS_ERR(req->hw_src))
 		return PTR_ERR(req->hw_src);
 	req->dma_src = input;
 
-	req->hw_dst = hisi_acc_sg_buf_map_to_hw_sgl(dev, req->dst, pool,
+	req->hw_dst = hisi_acc_sg_buf_map_to_hw_sgl(dev, a_req->dst, pool,
 						    (req->req_id << 1) + 1,
 						    &output);
 	if (IS_ERR(req->hw_dst)) {
@@ -561,8 +515,8 @@ static int hisi_zip_do_work(struct hisi_zip_req *req,
 	}
 	req->dma_dst = output;
 
-	hisi_zip_fill_sqe(zip_sqe, qp->req_type, input, output, req->slen,
-			  req->dlen);
+	hisi_zip_fill_sqe(zip_sqe, qp->req_type, input, output, a_req->slen,
+			  a_req->dlen, req->sskip, req->dskip);
 	hisi_zip_config_buf_type(zip_sqe, HZIP_SGL);
 	hisi_zip_config_tag(zip_sqe, req->req_id);
 
@@ -574,9 +528,9 @@ static int hisi_zip_do_work(struct hisi_zip_req *req,
 	return -EINPROGRESS;
 
 err_unmap_output:
-	hisi_acc_sg_buf_unmap(dev, req->dst, req->hw_dst);
+	hisi_acc_sg_buf_unmap(dev, a_req->dst, req->hw_dst);
 err_unmap_input:
-	hisi_acc_sg_buf_unmap(dev, req->src, req->hw_src);
+	hisi_acc_sg_buf_unmap(dev, a_req->src, req->hw_src);
 	return ret;
 }
 
-- 
2.8.1


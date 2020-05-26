Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEB81D4931
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2020 11:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgEOJPV (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 15 May 2020 05:15:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57972 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727837AbgEOJPV (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 15 May 2020 05:15:21 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A0DC2ED3F5066C9426B4;
        Fri, 15 May 2020 17:15:18 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Fri, 15 May 2020 17:15:09 +0800
From:   Shukun Tan <tanshukun1@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>
Subject: [PATCH 4/7] crypto: hisilicon/hpre - add debugfs for Hisilicon HPRE
Date:   Fri, 15 May 2020 17:13:57 +0800
Message-ID: <1589534040-50725-5-git-send-email-tanshukun1@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589534040-50725-1-git-send-email-tanshukun1@huawei.com>
References: <1589534040-50725-1-git-send-email-tanshukun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Hui Tang <tanghui20@huawei.com>

Add debugfs to provides IO operation debug information
and add BD processing timeout count function

Signed-off-by: Hui Tang <tanghui20@huawei.com>
Signed-off-by: Longfang Liu <liulongfang@huawei.com>
Signed-off-by: Shukun Tan <tanshukun1@huawei.com>
Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 Documentation/ABI/testing/debugfs-hisi-hpre | 45 +++++++++++++
 drivers/crypto/hisilicon/hpre/hpre.h        | 17 +++++
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 99 ++++++++++++++++++++++++-----
 drivers/crypto/hisilicon/hpre/hpre_main.c   | 56 ++++++++++++++++
 4 files changed, 202 insertions(+), 15 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-hisi-hpre b/Documentation/ABI/testing/debugfs-hisi-hpre
index 093cf46..1fe3eae 100644
--- a/Documentation/ABI/testing/debugfs-hisi-hpre
+++ b/Documentation/ABI/testing/debugfs-hisi-hpre
@@ -93,3 +93,48 @@ Contact:        linux-crypto@vger.kernel.org
 Description:    Dump the status of the QM.
 		Four states: initiated, started, stopped and closed.
 		Available for both PF and VF, and take no other effect on HPRE.
+
+What:           /sys/kernel/debug/hisi_hpre/<bdf>/hpre_dfx/send_cnt
+Date:           Apr 2020
+Contact:        linux-crypto@vger.kernel.org
+Description:    Dump the total number of sent requests.
+		Available for both PF and VF, and take no other effect on HPRE.
+
+What:           /sys/kernel/debug/hisi_hpre/<bdf>/hpre_dfx/recv_cnt
+Date:           Apr 2020
+Contact:        linux-crypto@vger.kernel.org
+Description:    Dump the total number of received requests.
+		Available for both PF and VF, and take no other effect on HPRE.
+
+What:           /sys/kernel/debug/hisi_hpre/<bdf>/hpre_dfx/send_busy_cnt
+Date:           Apr 2020
+Contact:        linux-crypto@vger.kernel.org
+Description:    Dump the total number of requests sent
+		with returning busy.
+		Available for both PF and VF, and take no other effect on HPRE.
+
+What:           /sys/kernel/debug/hisi_hpre/<bdf>/hpre_dfx/send_fail_cnt
+Date:           Apr 2020
+Contact:        linux-crypto@vger.kernel.org
+Description:    Dump the total number of completed but error requests.
+		Available for both PF and VF, and take no other effect on HPRE.
+
+What:           /sys/kernel/debug/hisi_hpre/<bdf>/hpre_dfx/invalid_req_cnt
+Date:           Apr 2020
+Contact:        linux-crypto@vger.kernel.org
+Description:    Dump the total number of invalid requests being received.
+		Available for both PF and VF, and take no other effect on HPRE.
+
+What:           /sys/kernel/debug/hisi_hpre/<bdf>/hpre_dfx/overtime_thrhld
+Date:           Apr 2020
+Contact:        linux-crypto@vger.kernel.org
+Description:    Set the threshold time for counting the request which is
+		processed longer than the threshold.
+		0: disable(default), 1: 1 microsecond.
+		Available for both PF and VF, and take no other effect on HPRE.
+
+What:           /sys/kernel/debug/hisi_hpre/<bdf>/hpre_dfx/over_thrhld_cnt
+Date:           Apr 2020
+Contact:        linux-crypto@vger.kernel.org
+Description:    Dump the total number of time out requests.
+		Available for both PF and VF, and take no other effect on HPRE.
diff --git a/drivers/crypto/hisilicon/hpre/hpre.h b/drivers/crypto/hisilicon/hpre/hpre.h
index 0a8ba46..ed730d1 100644
--- a/drivers/crypto/hisilicon/hpre/hpre.h
+++ b/drivers/crypto/hisilicon/hpre/hpre.h
@@ -25,6 +25,17 @@ enum hpre_ctrl_dbgfs_file {
 	HPRE_DEBUG_FILE_NUM,
 };
 
+enum hpre_dfx_dbgfs_file {
+	HPRE_SEND_CNT,
+	HPRE_RECV_CNT,
+	HPRE_SEND_FAIL_CNT,
+	HPRE_SEND_BUSY_CNT,
+	HPRE_OVER_THRHLD_CNT,
+	HPRE_OVERTIME_THRHLD,
+	HPRE_INVALID_REQ_CNT,
+	HPRE_DFX_FILE_NUM
+};
+
 #define HPRE_DEBUGFS_FILE_NUM    (HPRE_DEBUG_FILE_NUM + HPRE_CLUSTERS_NUM - 1)
 
 struct hpre_debugfs_file {
@@ -34,6 +45,11 @@ struct hpre_debugfs_file {
 	struct hpre_debug *debug;
 };
 
+struct hpre_dfx {
+	atomic64_t value;
+	enum hpre_dfx_dbgfs_file type;
+};
+
 /*
  * One HPRE controller has one PF and multiple VFs, some global configurations
  * which PF has need this structure.
@@ -41,6 +57,7 @@ struct hpre_debugfs_file {
  */
 struct hpre_debug {
 	struct dentry *debug_root;
+	struct hpre_dfx dfx[HPRE_DFX_FILE_NUM];
 	struct hpre_debugfs_file files[HPRE_DEBUGFS_FILE_NUM];
 };
 
diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index 6542525..7b5cb27 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -10,6 +10,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/fips.h>
 #include <linux/module.h>
+#include <linux/time.h>
 #include "hpre.h"
 
 struct hpre_ctx;
@@ -32,6 +33,9 @@ struct hpre_ctx;
 #define HPRE_SQE_DONE_SHIFT	30
 #define HPRE_DH_MAX_P_SZ	512
 
+#define HPRE_DFX_SEC_TO_US	1000000
+#define HPRE_DFX_US_TO_NS	1000
+
 typedef void (*hpre_cb)(struct hpre_ctx *ctx, void *sqe);
 
 struct hpre_rsa_ctx {
@@ -68,6 +72,7 @@ struct hpre_dh_ctx {
 struct hpre_ctx {
 	struct hisi_qp *qp;
 	struct hpre_asym_request **req_list;
+	struct hpre *hpre;
 	spinlock_t req_lock;
 	unsigned int key_sz;
 	bool crt_g2_mode;
@@ -90,6 +95,7 @@ struct hpre_asym_request {
 	int err;
 	int req_id;
 	hpre_cb cb;
+	struct timespec64 req_time;
 };
 
 static DEFINE_MUTEX(hpre_alg_lock);
@@ -119,6 +125,7 @@ static void hpre_free_req_id(struct hpre_ctx *ctx, int req_id)
 static int hpre_add_req_to_ctx(struct hpre_asym_request *hpre_req)
 {
 	struct hpre_ctx *ctx;
+	struct hpre_dfx *dfx;
 	int id;
 
 	ctx = hpre_req->ctx;
@@ -129,6 +136,10 @@ static int hpre_add_req_to_ctx(struct hpre_asym_request *hpre_req)
 	ctx->req_list[id] = hpre_req;
 	hpre_req->req_id = id;
 
+	dfx = ctx->hpre->debug.dfx;
+	if (atomic64_read(&dfx[HPRE_OVERTIME_THRHLD].value))
+		ktime_get_ts64(&hpre_req->req_time);
+
 	return id;
 }
 
@@ -309,12 +320,16 @@ static int hpre_alg_res_post_hf(struct hpre_ctx *ctx, struct hpre_sqe *sqe,
 
 static int hpre_ctx_set(struct hpre_ctx *ctx, struct hisi_qp *qp, int qlen)
 {
+	struct hpre *hpre;
+
 	if (!ctx || !qp || qlen < 0)
 		return -EINVAL;
 
 	spin_lock_init(&ctx->req_lock);
 	ctx->qp = qp;
 
+	hpre = container_of(ctx->qp->qm, struct hpre, qm);
+	ctx->hpre = hpre;
 	ctx->req_list = kcalloc(qlen, sizeof(void *), GFP_KERNEL);
 	if (!ctx->req_list)
 		return -ENOMEM;
@@ -337,38 +352,80 @@ static void hpre_ctx_clear(struct hpre_ctx *ctx, bool is_clear_all)
 	ctx->key_sz = 0;
 }
 
+static bool hpre_is_bd_timeout(struct hpre_asym_request *req,
+			       u64 overtime_thrhld)
+{
+	struct timespec64 reply_time;
+	u64 time_use_us;
+
+	ktime_get_ts64(&reply_time);
+	time_use_us = (reply_time.tv_sec - req->req_time.tv_sec) *
+		HPRE_DFX_SEC_TO_US +
+		(reply_time.tv_nsec - req->req_time.tv_nsec) /
+		HPRE_DFX_US_TO_NS;
+
+	if (time_use_us <= overtime_thrhld)
+		return false;
+
+	return true;
+}
+
 static void hpre_dh_cb(struct hpre_ctx *ctx, void *resp)
 {
+	struct hpre_dfx *dfx = ctx->hpre->debug.dfx;
 	struct hpre_asym_request *req;
 	struct kpp_request *areq;
+	u64 overtime_thrhld;
 	int ret;
 
 	ret = hpre_alg_res_post_hf(ctx, resp, (void **)&req);
 	areq = req->areq.dh;
 	areq->dst_len = ctx->key_sz;
+
+	overtime_thrhld = atomic64_read(&dfx[HPRE_OVERTIME_THRHLD].value);
+	if (overtime_thrhld && hpre_is_bd_timeout(req, overtime_thrhld))
+		atomic64_inc(&dfx[HPRE_OVER_THRHLD_CNT].value);
+
 	hpre_hw_data_clr_all(ctx, req, areq->dst, areq->src);
 	kpp_request_complete(areq, ret);
+	atomic64_inc(&dfx[HPRE_RECV_CNT].value);
 }
 
 static void hpre_rsa_cb(struct hpre_ctx *ctx, void *resp)
 {
+	struct hpre_dfx *dfx = ctx->hpre->debug.dfx;
 	struct hpre_asym_request *req;
 	struct akcipher_request *areq;
+	u64 overtime_thrhld;
 	int ret;
 
 	ret = hpre_alg_res_post_hf(ctx, resp, (void **)&req);
+
+	overtime_thrhld = atomic64_read(&dfx[HPRE_OVERTIME_THRHLD].value);
+	if (overtime_thrhld && hpre_is_bd_timeout(req, overtime_thrhld))
+		atomic64_inc(&dfx[HPRE_OVER_THRHLD_CNT].value);
+
 	areq = req->areq.rsa;
 	areq->dst_len = ctx->key_sz;
 	hpre_hw_data_clr_all(ctx, req, areq->dst, areq->src);
 	akcipher_request_complete(areq, ret);
+	atomic64_inc(&dfx[HPRE_RECV_CNT].value);
 }
 
 static void hpre_alg_cb(struct hisi_qp *qp, void *resp)
 {
 	struct hpre_ctx *ctx = qp->qp_ctx;
+	struct hpre_dfx *dfx = ctx->hpre->debug.dfx;
 	struct hpre_sqe *sqe = resp;
+	struct hpre_asym_request *req = ctx->req_list[le16_to_cpu(sqe->tag)];
 
-	ctx->req_list[le16_to_cpu(sqe->tag)]->cb(ctx, resp);
+
+	if (unlikely(!req)) {
+		atomic64_inc(&dfx[HPRE_INVALID_REQ_CNT].value);
+		return;
+	}
+
+	req->cb(ctx, resp);
 }
 
 static int hpre_ctx_init(struct hpre_ctx *ctx)
@@ -436,6 +493,29 @@ static int hpre_msg_request_set(struct hpre_ctx *ctx, void *req, bool is_rsa)
 	return 0;
 }
 
+static int hpre_send(struct hpre_ctx *ctx, struct hpre_sqe *msg)
+{
+	struct hpre_dfx *dfx = ctx->hpre->debug.dfx;
+	int ctr = 0;
+	int ret;
+
+	do {
+		atomic64_inc(&dfx[HPRE_SEND_CNT].value);
+		ret = hisi_qp_send(ctx->qp, msg);
+		if (ret != -EBUSY)
+			break;
+		atomic64_inc(&dfx[HPRE_SEND_BUSY_CNT].value);
+	} while (ctr++ < HPRE_TRY_SEND_TIMES);
+
+	if (likely(!ret))
+		return ret;
+
+	if (ret != -EBUSY)
+		atomic64_inc(&dfx[HPRE_SEND_FAIL_CNT].value);
+
+	return ret;
+}
+
 #ifdef CONFIG_CRYPTO_DH
 static int hpre_dh_compute_value(struct kpp_request *req)
 {
@@ -444,7 +524,6 @@ static int hpre_dh_compute_value(struct kpp_request *req)
 	void *tmp = kpp_request_ctx(req);
 	struct hpre_asym_request *hpre_req = PTR_ALIGN(tmp, HPRE_ALIGN_SZ);
 	struct hpre_sqe *msg = &hpre_req->req;
-	int ctr = 0;
 	int ret;
 
 	ret = hpre_msg_request_set(ctx, req, false);
@@ -465,11 +544,9 @@ static int hpre_dh_compute_value(struct kpp_request *req)
 		msg->dw0 = cpu_to_le32(le32_to_cpu(msg->dw0) | HPRE_ALG_DH_G2);
 	else
 		msg->dw0 = cpu_to_le32(le32_to_cpu(msg->dw0) | HPRE_ALG_DH);
-	do {
-		ret = hisi_qp_send(ctx->qp, msg);
-	} while (ret == -EBUSY && ctr++ < HPRE_TRY_SEND_TIMES);
 
 	/* success */
+	ret = hpre_send(ctx, msg);
 	if (likely(!ret))
 		return -EINPROGRESS;
 
@@ -647,7 +724,6 @@ static int hpre_rsa_enc(struct akcipher_request *req)
 	void *tmp = akcipher_request_ctx(req);
 	struct hpre_asym_request *hpre_req = PTR_ALIGN(tmp, HPRE_ALIGN_SZ);
 	struct hpre_sqe *msg = &hpre_req->req;
-	int ctr = 0;
 	int ret;
 
 	/* For 512 and 1536 bits key size, use soft tfm instead */
@@ -677,11 +753,8 @@ static int hpre_rsa_enc(struct akcipher_request *req)
 	if (unlikely(ret))
 		goto clear_all;
 
-	do {
-		ret = hisi_qp_send(ctx->qp, msg);
-	} while (ret == -EBUSY && ctr++ < HPRE_TRY_SEND_TIMES);
-
 	/* success */
+	ret = hpre_send(ctx, msg);
 	if (likely(!ret))
 		return -EINPROGRESS;
 
@@ -699,7 +772,6 @@ static int hpre_rsa_dec(struct akcipher_request *req)
 	void *tmp = akcipher_request_ctx(req);
 	struct hpre_asym_request *hpre_req = PTR_ALIGN(tmp, HPRE_ALIGN_SZ);
 	struct hpre_sqe *msg = &hpre_req->req;
-	int ctr = 0;
 	int ret;
 
 	/* For 512 and 1536 bits key size, use soft tfm instead */
@@ -736,11 +808,8 @@ static int hpre_rsa_dec(struct akcipher_request *req)
 	if (unlikely(ret))
 		goto clear_all;
 
-	do {
-		ret = hisi_qp_send(ctx->qp, msg);
-	} while (ret == -EBUSY && ctr++ < HPRE_TRY_SEND_TIMES);
-
 	/* success */
+	ret = hpre_send(ctx, msg);
 	if (likely(!ret))
 		return -EINPROGRESS;
 
diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index c5ddd3a..fb3988f 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -159,6 +159,16 @@ static const struct debugfs_reg32 hpre_com_dfx_regs[] = {
 	{"INT_STATUS               ",  HPRE_INT_STATUS},
 };
 
+static const char *hpre_dfx_files[HPRE_DFX_FILE_NUM] = {
+	"send_cnt",
+	"recv_cnt",
+	"send_fail_cnt",
+	"send_busy_cnt",
+	"over_thrhld_cnt",
+	"overtime_thrhld",
+	"invalid_req_cnt"
+};
+
 static int pf_q_num_set(const char *val, const struct kernel_param *kp)
 {
 	return q_num_set(val, kp, HPRE_PCI_DEVICE_ID);
@@ -524,6 +534,33 @@ static const struct file_operations hpre_ctrl_debug_fops = {
 	.write = hpre_ctrl_debug_write,
 };
 
+static int hpre_debugfs_atomic64_get(void *data, u64 *val)
+{
+	struct hpre_dfx *dfx_item = data;
+
+	*val = atomic64_read(&dfx_item->value);
+
+	return 0;
+}
+
+static int hpre_debugfs_atomic64_set(void *data, u64 val)
+{
+	struct hpre_dfx *dfx_item = data;
+	struct hpre_dfx *hpre_dfx = dfx_item - HPRE_OVERTIME_THRHLD;
+
+	if (val)
+		return -EINVAL;
+
+	if (dfx_item->type == HPRE_OVERTIME_THRHLD)
+		atomic64_set(&hpre_dfx[HPRE_OVER_THRHLD_CNT].value, 0);
+	atomic64_set(&dfx_item->value, val);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(hpre_atomic64_ops, hpre_debugfs_atomic64_get,
+			 hpre_debugfs_atomic64_set, "%llu\n");
+
 static int hpre_create_debugfs_file(struct hpre_debug *dbg, struct dentry *dir,
 				    enum hpre_ctrl_dbgfs_file type, int indx)
 {
@@ -621,6 +658,22 @@ static int hpre_ctrl_debug_init(struct hpre_debug *debug)
 	return hpre_cluster_debugfs_init(debug);
 }
 
+static void hpre_dfx_debug_init(struct hpre_debug *debug)
+{
+	struct hpre *hpre = container_of(debug, struct hpre, debug);
+	struct hpre_dfx *dfx = hpre->debug.dfx;
+	struct hisi_qm *qm = &hpre->qm;
+	struct dentry *parent;
+	int i;
+
+	parent = debugfs_create_dir("hpre_dfx", qm->debug.debug_root);
+	for (i = 0; i < HPRE_DFX_FILE_NUM; i++) {
+		dfx[i].type = i;
+		debugfs_create_file(hpre_dfx_files[i], 0644, parent, &dfx[i],
+				    &hpre_atomic64_ops);
+	}
+}
+
 static int hpre_debugfs_init(struct hpre *hpre)
 {
 	struct hisi_qm *qm = &hpre->qm;
@@ -641,6 +694,9 @@ static int hpre_debugfs_init(struct hpre *hpre)
 		if (ret)
 			goto failed_to_create;
 	}
+
+	hpre_dfx_debug_init(&hpre->debug);
+
 	return 0;
 
 failed_to_create:
-- 
2.7.4


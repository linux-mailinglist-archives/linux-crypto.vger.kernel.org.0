Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67EDAF5CE4
	for <lists+linux-crypto@lfdr.de>; Sat,  9 Nov 2019 03:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfKICFo (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 Nov 2019 21:05:44 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:42026 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbfKICFo (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 8 Nov 2019 21:05:44 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F28EAD164DC802732F43;
        Sat,  9 Nov 2019 10:05:38 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Sat, 9 Nov 2019 10:05:33 +0800
From:   Zaibo Xu <xuzaibo@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <jonathan.cameron@huawei.com>,
        <wangzhou1@hisilicon.com>, <linuxarm@huawei.com>,
        <fanghao11@huawei.com>, <yekai13@huawei.com>,
        <zhangwei375@huawei.com>, <forest.zhouchang@huawei.com>
Subject: [PATCH v2 1/5] crypto: hisilicon - add HiSilicon SEC V2 driver
Date:   Sat, 9 Nov 2019 10:01:53 +0800
Message-ID: <1573264917-14588-2-git-send-email-xuzaibo@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1573264917-14588-1-git-send-email-xuzaibo@huawei.com>
References: <1573264917-14588-1-git-send-email-xuzaibo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

SEC driver provides PCIe hardware device initiation with
AES, SM4, and 3DES skcipher algorithms registered to Crypto.
It uses Hisilicon QM as interface to CPU.

Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/crypto/hisilicon/Kconfig           |  16 +
 drivers/crypto/hisilicon/Makefile          |   1 +
 drivers/crypto/hisilicon/sec2/Makefile     |   2 +
 drivers/crypto/hisilicon/sec2/sec.h        | 132 +++++
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 859 +++++++++++++++++++++++++++++
 drivers/crypto/hisilicon/sec2/sec_crypto.h | 198 +++++++
 drivers/crypto/hisilicon/sec2/sec_main.c   | 640 +++++++++++++++++++++
 7 files changed, 1848 insertions(+)
 create mode 100644 drivers/crypto/hisilicon/sec2/Makefile
 create mode 100644 drivers/crypto/hisilicon/sec2/sec.h
 create mode 100644 drivers/crypto/hisilicon/sec2/sec_crypto.c
 create mode 100644 drivers/crypto/hisilicon/sec2/sec_crypto.h
 create mode 100644 drivers/crypto/hisilicon/sec2/sec_main.c

diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
index 82fb810d..72bc3d5 100644
--- a/drivers/crypto/hisilicon/Kconfig
+++ b/drivers/crypto/hisilicon/Kconfig
@@ -14,6 +14,22 @@ config CRYPTO_DEV_HISI_SEC
 	  To compile this as a module, choose M here: the module
 	  will be called hisi_sec.
 
+config CRYPTO_DEV_HISI_SEC2
+	tristate "Support for HiSilicon SEC2 crypto block cipher accelerator"
+	select CRYPTO_BLKCIPHER
+	select CRYPTO_ALGAPI
+	select CRYPTO_LIB_DES
+	select CRYPTO_DEV_HISI_QM
+	depends on PCI && PCI_MSI
+	depends on ARM64 || (COMPILE_TEST && 64BIT)
+	help
+	  Support for HiSilicon SEC Engine of version 2 in crypto subsystem.
+	  It provides AES, SM4, and 3DES algorithms with ECB
+	  CBC, and XTS cipher mode.
+
+	  To compile this as a module, choose M here: the module
+          will be called hisi_sec2.
+
 config CRYPTO_DEV_HISI_QM
 	tristate
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/crypto/hisilicon/Makefile b/drivers/crypto/hisilicon/Makefile
index 6cbfba0..7f5f74c 100644
--- a/drivers/crypto/hisilicon/Makefile
+++ b/drivers/crypto/hisilicon/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CRYPTO_DEV_HISI_HPRE) += hpre/
 obj-$(CONFIG_CRYPTO_DEV_HISI_SEC) += sec/
+obj-$(CONFIG_CRYPTO_DEV_HISI_SEC2) += sec2/
 obj-$(CONFIG_CRYPTO_DEV_HISI_QM) += hisi_qm.o
 hisi_qm-objs = qm.o sgl.o
 obj-$(CONFIG_CRYPTO_DEV_HISI_ZIP) += zip/
diff --git a/drivers/crypto/hisilicon/sec2/Makefile b/drivers/crypto/hisilicon/sec2/Makefile
new file mode 100644
index 0000000..b4f6cf1
--- /dev/null
+++ b/drivers/crypto/hisilicon/sec2/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_CRYPTO_DEV_HISI_SEC2) += hisi_sec2.o
+hisi_sec2-objs = sec_main.o sec_crypto.o
diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
new file mode 100644
index 0000000..443b6c5
--- /dev/null
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2019 HiSilicon Limited. */
+
+#ifndef __HISI_SEC_V2_H
+#define __HISI_SEC_V2_H
+
+#include <linux/list.h>
+
+#include "../qm.h"
+#include "sec_crypto.h"
+
+/* Cipher resource per hardware SEC queue */
+struct sec_cipher_res {
+	u8 *c_ivin;
+	dma_addr_t c_ivin_dma;
+};
+
+/* Cipher request of SEC private */
+struct sec_cipher_req {
+	struct hisi_acc_hw_sgl *c_in;
+	dma_addr_t c_in_dma;
+	struct hisi_acc_hw_sgl *c_out;
+	dma_addr_t c_out_dma;
+	u8 *c_ivin;
+	dma_addr_t c_ivin_dma;
+	struct skcipher_request *sk_req;
+	u32 c_len;
+	bool encrypt;
+};
+
+/* SEC request of Crypto */
+struct sec_req {
+	struct sec_sqe sec_sqe;
+	struct sec_ctx *ctx;
+	struct sec_qp_ctx *qp_ctx;
+
+	/* Cipher supported only at present */
+	struct sec_cipher_req c_req;
+	int err_type;
+	int req_id;
+
+	/* Status of the SEC request */
+	int fake_busy;
+};
+
+/**
+ * struct sec_req_op - Operations for SEC request
+ * @get_res: Get resources for TFM on the SEC device
+ * @resource_alloc: Allocate resources for queue context on the SEC device
+ * @resource_free: Free resources for queue context on the SEC device
+ * @buf_map: DMA map the SGL buffers of the request
+ * @buf_unmap: DMA unmap the SGL buffers of the request
+ * @bd_fill: Fill the SEC queue BD
+ * @bd_send: Send the SEC BD into the hardware queue
+ * @callback: Call back for the request
+ * @process: Main processing logic of Skcipher
+ */
+struct sec_req_op {
+	int (*get_res)(struct sec_ctx *ctx, struct sec_req *req);
+	int (*resource_alloc)(struct sec_ctx *ctx, struct sec_qp_ctx *qp_ctx);
+	void (*resource_free)(struct sec_ctx *ctx, struct sec_qp_ctx *qp_ctx);
+	int (*buf_map)(struct sec_ctx *ctx, struct sec_req *req);
+	void (*buf_unmap)(struct sec_ctx *ctx, struct sec_req *req);
+	void (*do_transfer)(struct sec_ctx *ctx, struct sec_req *req);
+	int (*bd_fill)(struct sec_ctx *ctx, struct sec_req *req);
+	int (*bd_send)(struct sec_ctx *ctx, struct sec_req *req);
+	void (*callback)(struct sec_ctx *ctx, struct sec_req *req);
+	int (*process)(struct sec_ctx *ctx, struct sec_req *req);
+};
+
+/* SEC cipher context which cipher's relatives */
+struct sec_cipher_ctx {
+	u8 *c_key;
+	dma_addr_t c_key_dma;
+	sector_t iv_offset;
+	u32 c_gran_size;
+	u32 ivsize;
+	u8 c_mode;
+	u8 c_alg;
+	u8 c_key_len;
+};
+
+/* SEC queue context which defines queue's relatives */
+struct sec_qp_ctx {
+	struct hisi_qp *qp;
+	struct sec_req **req_list;
+	struct idr req_idr;
+	void *alg_meta_data;
+	struct sec_ctx *ctx;
+	struct mutex req_lock;
+	struct hisi_acc_sgl_pool *c_in_pool;
+	struct hisi_acc_sgl_pool *c_out_pool;
+	atomic_t pending_reqs;
+};
+
+/* SEC Crypto TFM context which defines queue and cipher .etc relatives */
+struct sec_ctx {
+	struct sec_qp_ctx *qp_ctx;
+	struct sec_dev *sec;
+	const struct sec_req_op *req_op;
+
+	/* Half queues for encipher, and half for decipher */
+	u32 hlf_q_num;
+
+	/* Threshold for fake busy, trigger to return -EBUSY to user */
+	u32 fake_req_limit;
+
+	/* Currrent cyclic index to select a queue for encipher */
+	atomic_t enc_qcyclic;
+
+	 /* Currrent cyclic index to select a queue for decipher */
+	atomic_t dec_qcyclic;
+	struct sec_cipher_ctx c_ctx;
+};
+
+enum sec_endian {
+	SEC_LE = 0,
+	SEC_32BE,
+	SEC_64BE
+};
+
+struct sec_dev {
+	struct hisi_qm qm;
+	struct list_head list;
+	u32 ctx_q_num;
+	unsigned long status;
+};
+
+struct sec_dev *sec_find_device(int node);
+int sec_register_to_crypto(void);
+void sec_unregister_from_crypto(void);
+#endif
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
new file mode 100644
index 0000000..b22dac7
--- /dev/null
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -0,0 +1,859 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2019 HiSilicon Limited. */
+
+#include <crypto/aes.h>
+#include <crypto/algapi.h>
+#include <crypto/des.h>
+#include <crypto/skcipher.h>
+#include <crypto/xts.h>
+#include <linux/crypto.h>
+#include <linux/dma-mapping.h>
+#include <linux/idr.h>
+
+#include "sec.h"
+#include "sec_crypto.h"
+
+#define SEC_PRIORITY		4001
+#define SEC_XTS_MIN_KEY_SIZE	(2 * AES_MIN_KEY_SIZE)
+#define SEC_XTS_MAX_KEY_SIZE	(2 * AES_MAX_KEY_SIZE)
+#define SEC_DES3_2KEY_SIZE	(2 * DES_KEY_SIZE)
+#define SEC_DES3_3KEY_SIZE	(3 * DES_KEY_SIZE)
+
+/* SEC sqe(bd) bit operational relative MACRO */
+#define SEC_DE_OFFSET		1
+#define SEC_CIPHER_OFFSET	4
+#define SEC_SCENE_OFFSET	3
+#define SEC_DST_SGL_OFFSET	2
+#define SEC_SRC_SGL_OFFSET	7
+#define SEC_CKEY_OFFSET		9
+#define SEC_CMODE_OFFSET	12
+#define SEC_FLAG_OFFSET		7
+#define SEC_FLAG_MASK		0x0780
+#define SEC_TYPE_MASK		0x0F
+#define SEC_DONE_MASK		0x0001
+
+#define SEC_TOTAL_IV_SZ		(SEC_IV_SIZE * QM_Q_DEPTH)
+#define SEC_SGL_SGE_NR		128
+#define SEC_CTX_DEV(ctx)	(&(ctx)->sec->qm.pdev->dev)
+
+static DEFINE_MUTEX(sec_algs_lock);
+static unsigned int sec_active_devs;
+
+/* Get an en/de-cipher queue cyclically to balance load over queues of TFM */
+static inline int sec_get_queue_id(struct sec_ctx *ctx, struct sec_req *req)
+{
+	if (req->c_req.encrypt)
+		return (u32)atomic_inc_return(&ctx->enc_qcyclic) %
+				 ctx->hlf_q_num;
+
+	return (u32)atomic_inc_return(&ctx->dec_qcyclic) % ctx->hlf_q_num +
+				 ctx->hlf_q_num;
+}
+
+static inline void sec_put_queue_id(struct sec_ctx *ctx, struct sec_req *req)
+{
+	if (req->c_req.encrypt)
+		atomic_dec(&ctx->enc_qcyclic);
+	else
+		atomic_dec(&ctx->dec_qcyclic);
+}
+
+static int sec_alloc_req_id(struct sec_req *req, struct sec_qp_ctx *qp_ctx)
+{
+	int req_id;
+
+	mutex_lock(&qp_ctx->req_lock);
+
+	req_id = idr_alloc_cyclic(&qp_ctx->req_idr, NULL,
+				  0, QM_Q_DEPTH, GFP_ATOMIC);
+	mutex_unlock(&qp_ctx->req_lock);
+	if (req_id < 0) {
+		dev_err(SEC_CTX_DEV(req->ctx), "alloc req id fail!\n");
+		return req_id;
+	}
+
+	req->qp_ctx = qp_ctx;
+	qp_ctx->req_list[req_id] = req;
+	return req_id;
+}
+
+static void sec_free_req_id(struct sec_req *req)
+{
+	struct sec_qp_ctx *qp_ctx = req->qp_ctx;
+	int req_id = req->req_id;
+
+	if (req_id < 0 || req_id >= QM_Q_DEPTH) {
+		dev_err(SEC_CTX_DEV(req->ctx), "free request id invalid!\n");
+		return;
+	}
+
+	qp_ctx->req_list[req_id] = NULL;
+	req->qp_ctx = NULL;
+
+	mutex_lock(&qp_ctx->req_lock);
+	idr_remove(&qp_ctx->req_idr, req_id);
+	mutex_unlock(&qp_ctx->req_lock);
+}
+
+static void sec_req_cb(struct hisi_qp *qp, void *resp)
+{
+	struct sec_qp_ctx *qp_ctx = qp->qp_ctx;
+	struct sec_sqe *bd = resp;
+	u16 done, flag;
+	u8 type;
+	struct sec_req *req;
+
+	type = bd->type_cipher_auth & SEC_TYPE_MASK;
+	if (type == SEC_BD_TYPE2) {
+		req = qp_ctx->req_list[le16_to_cpu(bd->type2.tag)];
+		req->err_type = bd->type2.error_type;
+
+		done = le16_to_cpu(bd->type2.done_flag) & SEC_DONE_MASK;
+		flag = (le16_to_cpu(bd->type2.done_flag) &
+				   SEC_FLAG_MASK) >> SEC_FLAG_OFFSET;
+		if (req->err_type || done != 0x1 || flag != 0x2)
+			dev_err(SEC_CTX_DEV(req->ctx),
+				"err_type[%d],done[%d],flag[%d]\n",
+				req->err_type, done, flag);
+	} else {
+		pr_err("err bd type [%d]\n", type);
+		return;
+	}
+
+	req->ctx->req_op->buf_unmap(req->ctx, req);
+
+	req->ctx->req_op->callback(req->ctx, req);
+}
+
+static int sec_bd_send(struct sec_ctx *ctx, struct sec_req *req)
+{
+	struct sec_qp_ctx *qp_ctx = req->qp_ctx;
+	int ret;
+
+	mutex_lock(&qp_ctx->req_lock);
+	ret = hisi_qp_send(qp_ctx->qp, &req->sec_sqe);
+	mutex_unlock(&qp_ctx->req_lock);
+
+	if (ret == -EBUSY)
+		return -ENOBUFS;
+
+	if (!ret) {
+		if (req->fake_busy)
+			ret = -EBUSY;
+		else
+			ret = -EINPROGRESS;
+	}
+
+	return ret;
+}
+
+static int sec_create_qp_ctx(struct hisi_qm *qm, struct sec_ctx *ctx,
+			     int qp_ctx_id, int alg_type)
+{
+	struct device *dev = SEC_CTX_DEV(ctx);
+	struct sec_qp_ctx *qp_ctx;
+	struct hisi_qp *qp;
+	int ret = -ENOMEM;
+
+	qp = hisi_qm_create_qp(qm, alg_type);
+	if (IS_ERR(qp))
+		return PTR_ERR(qp);
+
+	qp_ctx = &ctx->qp_ctx[qp_ctx_id];
+	qp->req_type = 0;
+	qp->qp_ctx = qp_ctx;
+	qp->req_cb = sec_req_cb;
+	qp_ctx->qp = qp;
+	qp_ctx->ctx = ctx;
+
+	mutex_init(&qp_ctx->req_lock);
+	atomic_set(&qp_ctx->pending_reqs, 0);
+	idr_init(&qp_ctx->req_idr);
+
+	qp_ctx->req_list = kcalloc(QM_Q_DEPTH, sizeof(void *), GFP_ATOMIC);
+	if (!qp_ctx->req_list)
+		goto err_destroy_idr;
+
+	qp_ctx->c_in_pool = hisi_acc_create_sgl_pool(dev, QM_Q_DEPTH,
+						     SEC_SGL_SGE_NR);
+	if (!qp_ctx->c_in_pool) {
+		dev_err(dev, "fail to create sgl pool for input!\n");
+		goto err_free_req_list;
+	}
+
+	qp_ctx->c_out_pool = hisi_acc_create_sgl_pool(dev, QM_Q_DEPTH,
+						      SEC_SGL_SGE_NR);
+	if (!qp_ctx->c_out_pool) {
+		dev_err(dev, "fail to create sgl pool for output!\n");
+		goto err_free_c_in_pool;
+	}
+
+	ret = ctx->req_op->resource_alloc(ctx, qp_ctx);
+	if (ret)
+		goto err_free_c_out_pool;
+
+	ret = hisi_qm_start_qp(qp, 0);
+	if (ret < 0)
+		goto err_queue_free;
+
+	return 0;
+
+err_queue_free:
+	ctx->req_op->resource_free(ctx, qp_ctx);
+err_free_c_out_pool:
+	hisi_acc_free_sgl_pool(dev, qp_ctx->c_out_pool);
+err_free_c_in_pool:
+	hisi_acc_free_sgl_pool(dev, qp_ctx->c_in_pool);
+err_free_req_list:
+	kfree(qp_ctx->req_list);
+err_destroy_idr:
+	idr_destroy(&qp_ctx->req_idr);
+	hisi_qm_release_qp(qp);
+
+	return ret;
+}
+
+static void sec_release_qp_ctx(struct sec_ctx *ctx,
+			       struct sec_qp_ctx *qp_ctx)
+{
+	struct device *dev = SEC_CTX_DEV(ctx);
+
+	hisi_qm_stop_qp(qp_ctx->qp);
+	ctx->req_op->resource_free(ctx, qp_ctx);
+
+	hisi_acc_free_sgl_pool(dev, qp_ctx->c_out_pool);
+	hisi_acc_free_sgl_pool(dev, qp_ctx->c_in_pool);
+
+	idr_destroy(&qp_ctx->req_idr);
+	kfree(qp_ctx->req_list);
+	hisi_qm_release_qp(qp_ctx->qp);
+}
+
+static int sec_skcipher_init(struct crypto_skcipher *tfm)
+{
+	struct sec_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct sec_cipher_ctx *c_ctx;
+	struct sec_dev *sec;
+	struct device *dev;
+	struct hisi_qm *qm;
+	int i, ret;
+
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct sec_req));
+
+	sec = sec_find_device(cpu_to_node(smp_processor_id()));
+	if (!sec) {
+		pr_err("find no Hisilicon SEC device!\n");
+		return -ENODEV;
+	}
+	ctx->sec = sec;
+	qm = &sec->qm;
+	dev = &qm->pdev->dev;
+	ctx->hlf_q_num = sec->ctx_q_num >> 0x1;
+
+	/* Half of queue depth is taken as fake requests limit in the queue. */
+	ctx->fake_req_limit = QM_Q_DEPTH >> 0x1;
+	ctx->qp_ctx = kcalloc(sec->ctx_q_num, sizeof(struct sec_qp_ctx),
+			      GFP_KERNEL);
+	if (!ctx->qp_ctx)
+		return -ENOMEM;
+
+	for (i = 0; i < sec->ctx_q_num; i++) {
+		ret = sec_create_qp_ctx(qm, ctx, i, 0);
+		if (ret)
+			goto err_sec_release_qp_ctx;
+	}
+
+	c_ctx = &ctx->c_ctx;
+	c_ctx->ivsize = crypto_skcipher_ivsize(tfm);
+	if (c_ctx->ivsize > SEC_IV_SIZE) {
+		dev_err(dev, "get error iv size!\n");
+		ret = -EINVAL;
+		goto err_sec_release_qp_ctx;
+	}
+	c_ctx->c_key = dma_alloc_coherent(dev, SEC_MAX_KEY_SIZE,
+					  &c_ctx->c_key_dma, GFP_KERNEL);
+	if (!c_ctx->c_key) {
+		ret = -ENOMEM;
+		goto err_sec_release_qp_ctx;
+	}
+
+	return 0;
+
+err_sec_release_qp_ctx:
+	for (i = i - 1; i >= 0; i--)
+		sec_release_qp_ctx(ctx, &ctx->qp_ctx[i]);
+
+	kfree(ctx->qp_ctx);
+	return ret;
+}
+
+static void sec_skcipher_exit(struct crypto_skcipher *tfm)
+{
+	struct sec_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct sec_cipher_ctx *c_ctx = &ctx->c_ctx;
+	int i = 0;
+
+	if (c_ctx->c_key) {
+		dma_free_coherent(SEC_CTX_DEV(ctx), SEC_MAX_KEY_SIZE,
+				  c_ctx->c_key, c_ctx->c_key_dma);
+		c_ctx->c_key = NULL;
+	}
+
+	for (i = 0; i < ctx->sec->ctx_q_num; i++)
+		sec_release_qp_ctx(ctx, &ctx->qp_ctx[i]);
+
+	kfree(ctx->qp_ctx);
+}
+
+static int sec_skcipher_3des_setkey(struct sec_cipher_ctx *c_ctx,
+				    const u32 keylen,
+				    const enum sec_cmode c_mode)
+{
+	switch (keylen) {
+	case SEC_DES3_2KEY_SIZE:
+		c_ctx->c_key_len = SEC_CKEY_3DES_2KEY;
+		break;
+	case SEC_DES3_3KEY_SIZE:
+		c_ctx->c_key_len = SEC_CKEY_3DES_3KEY;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int sec_skcipher_aes_sm4_setkey(struct sec_cipher_ctx *c_ctx,
+				       const u32 keylen,
+				       const enum sec_cmode c_mode)
+{
+	if (c_mode == SEC_CMODE_XTS) {
+		switch (keylen) {
+		case SEC_XTS_MIN_KEY_SIZE:
+			c_ctx->c_key_len = SEC_CKEY_128BIT;
+			break;
+		case SEC_XTS_MAX_KEY_SIZE:
+			c_ctx->c_key_len = SEC_CKEY_256BIT;
+			break;
+		default:
+			pr_err("hisi_sec2: xts mode key error!\n");
+			return -EINVAL;
+		}
+	} else {
+		switch (keylen) {
+		case AES_KEYSIZE_128:
+			c_ctx->c_key_len = SEC_CKEY_128BIT;
+			break;
+		case AES_KEYSIZE_192:
+			c_ctx->c_key_len = SEC_CKEY_192BIT;
+			break;
+		case AES_KEYSIZE_256:
+			c_ctx->c_key_len = SEC_CKEY_256BIT;
+			break;
+		default:
+			pr_err("hisi_sec2: aes key error!\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int sec_skcipher_setkey(struct crypto_skcipher *tfm, const u8 *key,
+			       const u32 keylen, const enum sec_calg c_alg,
+			       const enum sec_cmode c_mode)
+{
+	struct sec_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct sec_cipher_ctx *c_ctx = &ctx->c_ctx;
+	int ret;
+
+	if (c_mode == SEC_CMODE_XTS) {
+		ret = xts_verify_key(tfm, key, keylen);
+		if (ret) {
+			dev_err(SEC_CTX_DEV(ctx), "xts mode key err!\n");
+			return ret;
+		}
+	}
+
+	c_ctx->c_alg  = c_alg;
+	c_ctx->c_mode = c_mode;
+
+	switch (c_alg) {
+	case SEC_CALG_3DES:
+		ret = sec_skcipher_3des_setkey(c_ctx, keylen, c_mode);
+		break;
+	case SEC_CALG_AES:
+	case SEC_CALG_SM4:
+		ret = sec_skcipher_aes_sm4_setkey(c_ctx, keylen, c_mode);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ret) {
+		dev_err(SEC_CTX_DEV(ctx), "set sec key err!\n");
+		return ret;
+	}
+
+	memcpy(c_ctx->c_key, key, keylen);
+
+	return 0;
+}
+
+#define GEN_SEC_SETKEY_FUNC(name, c_alg, c_mode)			\
+static int sec_setkey_##name(struct crypto_skcipher *tfm, const u8 *key,\
+	u32 keylen)							\
+{									\
+	return sec_skcipher_setkey(tfm, key, keylen, c_alg, c_mode);	\
+}
+
+GEN_SEC_SETKEY_FUNC(aes_ecb, SEC_CALG_AES, SEC_CMODE_ECB)
+GEN_SEC_SETKEY_FUNC(aes_cbc, SEC_CALG_AES, SEC_CMODE_CBC)
+GEN_SEC_SETKEY_FUNC(aes_xts, SEC_CALG_AES, SEC_CMODE_XTS)
+
+GEN_SEC_SETKEY_FUNC(3des_ecb, SEC_CALG_3DES, SEC_CMODE_ECB)
+GEN_SEC_SETKEY_FUNC(3des_cbc, SEC_CALG_3DES, SEC_CMODE_CBC)
+
+GEN_SEC_SETKEY_FUNC(sm4_xts, SEC_CALG_SM4, SEC_CMODE_XTS)
+GEN_SEC_SETKEY_FUNC(sm4_cbc, SEC_CALG_SM4, SEC_CMODE_CBC)
+
+static int sec_skcipher_get_res(struct sec_ctx *ctx,
+				struct sec_req *req)
+{
+	struct sec_qp_ctx *qp_ctx = req->qp_ctx;
+	struct sec_cipher_res *c_res = qp_ctx->alg_meta_data;
+	struct sec_cipher_req *c_req = &req->c_req;
+	int req_id = req->req_id;
+
+	c_req->c_ivin = c_res[req_id].c_ivin;
+	c_req->c_ivin_dma = c_res[req_id].c_ivin_dma;
+
+	return 0;
+}
+
+static int sec_skcipher_resource_alloc(struct sec_ctx *ctx,
+				       struct sec_qp_ctx *qp_ctx)
+{
+	struct device *dev = SEC_CTX_DEV(ctx);
+	struct sec_cipher_res *res;
+	int i;
+
+	res = kcalloc(QM_Q_DEPTH, sizeof(struct sec_cipher_res), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	res->c_ivin = dma_alloc_coherent(dev, SEC_TOTAL_IV_SZ,
+					   &res->c_ivin_dma, GFP_KERNEL);
+	if (!res->c_ivin) {
+		kfree(res);
+		return -ENOMEM;
+	}
+
+	for (i = 1; i < QM_Q_DEPTH; i++) {
+		res[i].c_ivin_dma = res->c_ivin_dma + i * SEC_IV_SIZE;
+		res[i].c_ivin = res->c_ivin + i * SEC_IV_SIZE;
+	}
+	qp_ctx->alg_meta_data = res;
+
+	return 0;
+}
+
+static void sec_skcipher_resource_free(struct sec_ctx *ctx,
+				      struct sec_qp_ctx *qp_ctx)
+{
+	struct sec_cipher_res *res = qp_ctx->alg_meta_data;
+	struct device *dev = SEC_CTX_DEV(ctx);
+
+	if (!res)
+		return;
+
+	dma_free_coherent(dev, SEC_TOTAL_IV_SZ, res->c_ivin, res->c_ivin_dma);
+	kfree(res);
+}
+
+static int sec_skcipher_map(struct device *dev, struct sec_req *req,
+			    struct scatterlist *src, struct scatterlist *dst)
+{
+	struct sec_cipher_req *c_req = &req->c_req;
+	struct sec_qp_ctx *qp_ctx = req->qp_ctx;
+
+	c_req->c_in = hisi_acc_sg_buf_map_to_hw_sgl(dev, src,
+						    qp_ctx->c_in_pool,
+						    req->req_id,
+						    &c_req->c_in_dma);
+
+	if (IS_ERR(c_req->c_in)) {
+		dev_err(dev, "fail to dma map input sgl buffers!\n");
+		return PTR_ERR(c_req->c_in);
+	}
+
+	if (dst == src) {
+		c_req->c_out = c_req->c_in;
+		c_req->c_out_dma = c_req->c_in_dma;
+	} else {
+		c_req->c_out = hisi_acc_sg_buf_map_to_hw_sgl(dev, dst,
+							     qp_ctx->c_out_pool,
+							     req->req_id,
+							     &c_req->c_out_dma);
+
+		if (IS_ERR(c_req->c_out)) {
+			dev_err(dev, "fail to dma map output sgl buffers!\n");
+			hisi_acc_sg_buf_unmap(dev, src, c_req->c_in);
+			return PTR_ERR(c_req->c_out);
+		}
+	}
+
+	return 0;
+}
+
+static int sec_skcipher_sgl_map(struct sec_ctx *ctx, struct sec_req *req)
+{
+	struct sec_cipher_req *c_req = &req->c_req;
+
+	return sec_skcipher_map(SEC_CTX_DEV(ctx), req,
+				c_req->sk_req->src, c_req->sk_req->dst);
+}
+
+static void sec_skcipher_sgl_unmap(struct sec_ctx *ctx, struct sec_req *req)
+{
+	struct device *dev = SEC_CTX_DEV(ctx);
+	struct sec_cipher_req *c_req = &req->c_req;
+	struct skcipher_request *sk_req = c_req->sk_req;
+
+	if (sk_req->dst != sk_req->src)
+		hisi_acc_sg_buf_unmap(dev, sk_req->src, c_req->c_in);
+
+	hisi_acc_sg_buf_unmap(dev, sk_req->dst, c_req->c_out);
+}
+
+static int sec_request_transfer(struct sec_ctx *ctx, struct sec_req *req)
+{
+	int ret;
+
+	ret = ctx->req_op->buf_map(ctx, req);
+	if (ret)
+		return ret;
+
+	ctx->req_op->do_transfer(ctx, req);
+
+	ret = ctx->req_op->bd_fill(ctx, req);
+	if (ret)
+		goto unmap_req_buf;
+
+	return ret;
+
+unmap_req_buf:
+	ctx->req_op->buf_unmap(ctx, req);
+
+	return ret;
+}
+
+static void sec_request_untransfer(struct sec_ctx *ctx, struct sec_req *req)
+{
+	ctx->req_op->buf_unmap(ctx, req);
+}
+
+static void sec_skcipher_copy_iv(struct sec_ctx *ctx, struct sec_req *req)
+{
+	struct skcipher_request *sk_req = req->c_req.sk_req;
+	struct sec_cipher_req *c_req = &req->c_req;
+
+	c_req->c_len = sk_req->cryptlen;
+	memcpy(c_req->c_ivin, sk_req->iv, ctx->c_ctx.ivsize);
+}
+
+static int sec_skcipher_bd_fill(struct sec_ctx *ctx, struct sec_req *req)
+{
+	struct sec_cipher_ctx *c_ctx = &ctx->c_ctx;
+	struct sec_cipher_req *c_req = &req->c_req;
+	struct sec_sqe *sec_sqe = &req->sec_sqe;
+	u8 de = 0;
+	u8 scene, sa_type, da_type;
+	u8 bd_type, cipher;
+
+	if (!c_req->c_len) {
+		dev_err(SEC_CTX_DEV(ctx), "cipher length is zero!\n");
+		return -EINVAL;
+	}
+
+	memset(sec_sqe, 0, sizeof(struct sec_sqe));
+
+	sec_sqe->type2.c_key_addr = cpu_to_le64(c_ctx->c_key_dma);
+	sec_sqe->type2.c_ivin_addr = cpu_to_le64(c_req->c_ivin_dma);
+	sec_sqe->type2.data_src_addr = cpu_to_le64(c_req->c_in_dma);
+	sec_sqe->type2.data_dst_addr = cpu_to_le64(c_req->c_out_dma);
+
+	sec_sqe->type2.icvw_kmode |= cpu_to_le16(((u16)c_ctx->c_mode) <<
+						SEC_CMODE_OFFSET);
+	sec_sqe->type2.c_alg = c_ctx->c_alg;
+	sec_sqe->type2.icvw_kmode |= cpu_to_le16(((u16)c_ctx->c_key_len) <<
+						SEC_CKEY_OFFSET);
+
+	bd_type = SEC_BD_TYPE2;
+	if (c_req->encrypt)
+		cipher = SEC_CIPHER_ENC << SEC_CIPHER_OFFSET;
+	else
+		cipher = SEC_CIPHER_DEC << SEC_CIPHER_OFFSET;
+	sec_sqe->type_cipher_auth = bd_type | cipher;
+
+	sa_type = SEC_SGL << SEC_SRC_SGL_OFFSET;
+	scene = SEC_COMM_SCENE << SEC_SCENE_OFFSET;
+	if (c_req->c_in_dma != c_req->c_out_dma)
+		de = 0x1 << SEC_DE_OFFSET;
+
+	sec_sqe->sds_sa_type = (de | scene | sa_type);
+
+	/* Just set DST address type */
+	da_type = SEC_SGL << SEC_DST_SGL_OFFSET;
+	sec_sqe->sdm_addr_type |= da_type;
+
+	sec_sqe->type2.clen_ivhlen |= cpu_to_le32(c_req->c_len);
+	sec_sqe->type2.tag = cpu_to_le16((u16)req->req_id);
+
+	return 0;
+}
+
+static void sec_update_iv(struct sec_req *req)
+{
+	struct skcipher_request *sk_req = req->c_req.sk_req;
+	u32 iv_size = req->ctx->c_ctx.ivsize;
+	struct scatterlist *sgl;
+	size_t sz;
+
+	if (req->c_req.encrypt)
+		sgl = sk_req->dst;
+	else
+		sgl = sk_req->src;
+
+	sz = sg_pcopy_to_buffer(sgl, sg_nents(sgl), sk_req->iv,
+				iv_size, sk_req->cryptlen - iv_size);
+	if (sz != iv_size)
+		dev_err(SEC_CTX_DEV(req->ctx), "copy output iv error!\n");
+}
+
+static void sec_skcipher_callback(struct sec_ctx *ctx, struct sec_req *req)
+{
+	struct skcipher_request *sk_req = req->c_req.sk_req;
+	struct sec_qp_ctx *qp_ctx = req->qp_ctx;
+
+	atomic_dec(&qp_ctx->pending_reqs);
+	sec_free_req_id(req);
+
+	/* IV output at encrypto of CBC mode */
+	if (ctx->c_ctx.c_mode == SEC_CMODE_CBC && req->c_req.encrypt)
+		sec_update_iv(req);
+
+	if (__sync_bool_compare_and_swap(&req->fake_busy, 1, 0))
+		sk_req->base.complete(&sk_req->base, -EINPROGRESS);
+
+	sk_req->base.complete(&sk_req->base, req->err_type);
+}
+
+static void sec_request_uninit(struct sec_ctx *ctx, struct sec_req *req)
+{
+	struct sec_qp_ctx *qp_ctx = req->qp_ctx;
+
+	atomic_dec(&qp_ctx->pending_reqs);
+	sec_free_req_id(req);
+	sec_put_queue_id(ctx, req);
+}
+
+static int sec_request_init(struct sec_ctx *ctx, struct sec_req *req)
+{
+	struct sec_qp_ctx *qp_ctx;
+	int issue_id, ret;
+
+	/* To load balance */
+	issue_id = sec_get_queue_id(ctx, req);
+	qp_ctx = &ctx->qp_ctx[issue_id];
+
+	req->req_id = sec_alloc_req_id(req, qp_ctx);
+	if (req->req_id < 0) {
+		sec_put_queue_id(ctx, req);
+		return req->req_id;
+	}
+
+	if (ctx->fake_req_limit <= atomic_inc_return(&qp_ctx->pending_reqs))
+		req->fake_busy = 1;
+	else
+		req->fake_busy = 0;
+
+	ret = ctx->req_op->get_res(ctx, req);
+	if (ret) {
+		atomic_dec(&qp_ctx->pending_reqs);
+		sec_request_uninit(ctx, req);
+		dev_err(SEC_CTX_DEV(ctx), "get resources failed!\n");
+	}
+
+	return ret;
+}
+
+static int sec_process(struct sec_ctx *ctx, struct sec_req *req)
+{
+	int ret;
+
+	ret = sec_request_init(ctx, req);
+	if (ret)
+		return ret;
+
+	ret = sec_request_transfer(ctx, req);
+	if (ret)
+		goto err_uninit_req;
+
+	/* Output IV as decrypto */
+	if (ctx->c_ctx.c_mode == SEC_CMODE_CBC && !req->c_req.encrypt)
+		sec_update_iv(req);
+
+	ret = ctx->req_op->bd_send(ctx, req);
+	if (ret != -EBUSY && ret != -EINPROGRESS) {
+		dev_err(SEC_CTX_DEV(ctx), "send sec request failed!\n");
+		goto err_send_req;
+	}
+
+	return ret;
+
+err_send_req:
+	/* As failing, restore the IV from user */
+	if (ctx->c_ctx.c_mode == SEC_CMODE_CBC && !req->c_req.encrypt)
+		memcpy(req->c_req.sk_req->iv, req->c_req.c_ivin,
+		       ctx->c_ctx.ivsize);
+
+	sec_request_untransfer(ctx, req);
+err_uninit_req:
+	sec_request_uninit(ctx, req);
+
+	return ret;
+}
+
+static struct sec_req_op sec_req_ops_tbl = {
+	.get_res	= sec_skcipher_get_res,
+	.resource_alloc	= sec_skcipher_resource_alloc,
+	.resource_free	= sec_skcipher_resource_free,
+	.buf_map	= sec_skcipher_sgl_map,
+	.buf_unmap	= sec_skcipher_sgl_unmap,
+	.do_transfer	= sec_skcipher_copy_iv,
+	.bd_fill	= sec_skcipher_bd_fill,
+	.bd_send	= sec_bd_send,
+	.callback	= sec_skcipher_callback,
+	.process	= sec_process,
+};
+
+static int sec_skcipher_ctx_init(struct crypto_skcipher *tfm)
+{
+	struct sec_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	ctx->req_op = &sec_req_ops_tbl;
+
+	return sec_skcipher_init(tfm);
+}
+
+static void sec_skcipher_ctx_exit(struct crypto_skcipher *tfm)
+{
+	sec_skcipher_exit(tfm);
+}
+
+static int sec_skcipher_crypto(struct skcipher_request *sk_req, bool encrypt)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(sk_req);
+	struct sec_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct sec_req *req = skcipher_request_ctx(sk_req);
+
+	if (!sk_req->src || !sk_req->dst || !sk_req->cryptlen) {
+		dev_err(SEC_CTX_DEV(ctx), "skcipher input param error!\n");
+		return -EINVAL;
+	}
+
+	req->c_req.sk_req = sk_req;
+	req->c_req.encrypt = encrypt;
+	req->ctx = ctx;
+
+	return ctx->req_op->process(ctx, req);
+}
+
+static int sec_skcipher_encrypt(struct skcipher_request *sk_req)
+{
+	return sec_skcipher_crypto(sk_req, true);
+}
+
+static int sec_skcipher_decrypt(struct skcipher_request *sk_req)
+{
+	return sec_skcipher_crypto(sk_req, false);
+}
+
+#define SEC_SKCIPHER_GEN_ALG(sec_cra_name, sec_set_key, sec_min_key_size, \
+	sec_max_key_size, ctx_init, ctx_exit, blk_size, iv_size)\
+{\
+	.base = {\
+		.cra_name = sec_cra_name,\
+		.cra_driver_name = "hisi_sec_"sec_cra_name,\
+		.cra_priority = SEC_PRIORITY,\
+		.cra_flags = CRYPTO_ALG_ASYNC,\
+		.cra_blocksize = blk_size,\
+		.cra_ctxsize = sizeof(struct sec_ctx),\
+		.cra_module = THIS_MODULE,\
+	},\
+	.init = ctx_init,\
+	.exit = ctx_exit,\
+	.setkey = sec_set_key,\
+	.decrypt = sec_skcipher_decrypt,\
+	.encrypt = sec_skcipher_encrypt,\
+	.min_keysize = sec_min_key_size,\
+	.max_keysize = sec_max_key_size,\
+	.ivsize = iv_size,\
+},
+
+#define SEC_SKCIPHER_ALG(name, key_func, min_key_size, \
+	max_key_size, blk_size, iv_size) \
+	SEC_SKCIPHER_GEN_ALG(name, key_func, min_key_size, max_key_size, \
+	sec_skcipher_ctx_init, sec_skcipher_ctx_exit, blk_size, iv_size)
+
+static struct skcipher_alg sec_algs[] = {
+	SEC_SKCIPHER_ALG("ecb(aes)", sec_setkey_aes_ecb,
+			 AES_MIN_KEY_SIZE, AES_MAX_KEY_SIZE,
+			 AES_BLOCK_SIZE, 0)
+
+	SEC_SKCIPHER_ALG("cbc(aes)", sec_setkey_aes_cbc,
+			 AES_MIN_KEY_SIZE, AES_MAX_KEY_SIZE,
+			 AES_BLOCK_SIZE, AES_BLOCK_SIZE)
+
+	SEC_SKCIPHER_ALG("xts(aes)", sec_setkey_aes_xts,
+			 SEC_XTS_MIN_KEY_SIZE, SEC_XTS_MAX_KEY_SIZE,
+			 AES_BLOCK_SIZE, AES_BLOCK_SIZE)
+
+	SEC_SKCIPHER_ALG("ecb(des3_ede)", sec_setkey_3des_ecb,
+			 SEC_DES3_2KEY_SIZE, SEC_DES3_3KEY_SIZE,
+			 DES3_EDE_BLOCK_SIZE, 0)
+
+	SEC_SKCIPHER_ALG("cbc(des3_ede)", sec_setkey_3des_cbc,
+			 SEC_DES3_2KEY_SIZE, SEC_DES3_3KEY_SIZE,
+			 DES3_EDE_BLOCK_SIZE, DES3_EDE_BLOCK_SIZE)
+
+	SEC_SKCIPHER_ALG("xts(sm4)", sec_setkey_sm4_xts,
+			 SEC_XTS_MIN_KEY_SIZE, SEC_XTS_MIN_KEY_SIZE,
+			 AES_BLOCK_SIZE, AES_BLOCK_SIZE)
+
+	SEC_SKCIPHER_ALG("cbc(sm4)", sec_setkey_sm4_cbc,
+			 AES_MIN_KEY_SIZE, AES_MIN_KEY_SIZE,
+			 AES_BLOCK_SIZE, AES_BLOCK_SIZE)
+};
+
+int sec_register_to_crypto(void)
+{
+	int ret = 0;
+
+	/* To avoid repeat register */
+	mutex_lock(&sec_algs_lock);
+	if (++sec_active_devs == 1)
+		ret = crypto_register_skciphers(sec_algs, ARRAY_SIZE(sec_algs));
+	mutex_unlock(&sec_algs_lock);
+
+	return ret;
+}
+
+void sec_unregister_from_crypto(void)
+{
+	mutex_lock(&sec_algs_lock);
+	if (--sec_active_devs == 0)
+		crypto_unregister_skciphers(sec_algs, ARRAY_SIZE(sec_algs));
+	mutex_unlock(&sec_algs_lock);
+}
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.h b/drivers/crypto/hisilicon/sec2/sec_crypto.h
new file mode 100644
index 0000000..097dce8
--- /dev/null
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.h
@@ -0,0 +1,198 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2019 HiSilicon Limited. */
+
+#ifndef __HISI_SEC_V2_CRYPTO_H
+#define __HISI_SEC_V2_CRYPTO_H
+
+#define SEC_IV_SIZE		24
+#define SEC_MAX_KEY_SIZE	64
+#define SEC_COMM_SCENE		0
+
+enum sec_calg {
+	SEC_CALG_3DES = 0x1,
+	SEC_CALG_AES  = 0x2,
+	SEC_CALG_SM4  = 0x3,
+};
+
+enum sec_cmode {
+	SEC_CMODE_ECB    = 0x0,
+	SEC_CMODE_CBC    = 0x1,
+	SEC_CMODE_CTR    = 0x4,
+	SEC_CMODE_XTS    = 0x7,
+};
+
+enum sec_ckey_type {
+	SEC_CKEY_128BIT = 0x0,
+	SEC_CKEY_192BIT = 0x1,
+	SEC_CKEY_256BIT = 0x2,
+	SEC_CKEY_3DES_3KEY = 0x1,
+	SEC_CKEY_3DES_2KEY = 0x3,
+};
+
+enum sec_bd_type {
+	SEC_BD_TYPE1 = 0x1,
+	SEC_BD_TYPE2 = 0x2,
+};
+
+enum sec_cipher_dir {
+	SEC_CIPHER_ENC = 0x1,
+	SEC_CIPHER_DEC = 0x2,
+};
+
+enum sec_addr_type {
+	SEC_PBUF = 0x0,
+	SEC_SGL  = 0x1,
+	SEC_PRP  = 0x2,
+};
+
+struct sec_sqe_type2 {
+
+	/*
+	 * mac_len: 0~5 bits
+	 * a_key_len: 6~10 bits
+	 * a_alg: 11~16 bits
+	 */
+	__le32 mac_key_alg;
+
+	/*
+	 * c_icv_len: 0~5 bits
+	 * c_width: 6~8 bits
+	 * c_key_len: 9~11 bits
+	 * c_mode: 12~15 bits
+	 */
+	__le16 icvw_kmode;
+
+	/* c_alg: 0~3 bits */
+	__u8 c_alg;
+	__u8 rsvd4;
+
+	/*
+	 * a_len: 0~23 bits
+	 * iv_offset_l: 24~31 bits
+	 */
+	__le32 alen_ivllen;
+
+	/*
+	 * c_len: 0~23 bits
+	 * iv_offset_h: 24~31 bits
+	 */
+	__le32 clen_ivhlen;
+
+	__le16 auth_src_offset;
+	__le16 cipher_src_offset;
+	__le16 cs_ip_header_offset;
+	__le16 cs_udp_header_offset;
+	__le16 pass_word_len;
+	__le16 dk_len;
+	__u8 salt3;
+	__u8 salt2;
+	__u8 salt1;
+	__u8 salt0;
+
+	__le16 tag;
+	__le16 rsvd5;
+
+	/*
+	 * c_pad_type: 0~3 bits
+	 * c_pad_len: 4~11 bits
+	 * c_pad_data_type: 12~15 bits
+	 */
+	__le16 cph_pad;
+
+	/* c_pad_len_field: 0~1 bits */
+	__le16 c_pad_len_field;
+
+
+	__le64 long_a_data_len;
+	__le64 a_ivin_addr;
+	__le64 a_key_addr;
+	__le64 mac_addr;
+	__le64 c_ivin_addr;
+	__le64 c_key_addr;
+
+	__le64 data_src_addr;
+	__le64 data_dst_addr;
+
+	/*
+	 * done: 0 bit
+	 * icv: 1~3 bits
+	 * csc: 4~6 bits
+	 * flag: 7-10 bits
+	 * dif_check: 11~13 bits
+	 */
+	__le16 done_flag;
+
+	__u8 error_type;
+	__u8 warning_type;
+	__u8 mac_i3;
+	__u8 mac_i2;
+	__u8 mac_i1;
+	__u8 mac_i0;
+	__le16 check_sum_i;
+	__u8 tls_pad_len_i;
+	__u8 rsvd12;
+	__le32 counter;
+};
+
+struct sec_sqe {
+	/*
+	 * type:	0~3 bits
+	 * cipher:	4~5 bits
+	 * auth:	6~7 bit s
+	 */
+	__u8 type_cipher_auth;
+
+	/*
+	 * seq:	0 bit
+	 * de:	1~2 bits
+	 * scene:	3~6 bits
+	 * src_addr_type: ~7 bit, with sdm_addr_type 0-1 bits
+	 */
+	__u8 sds_sa_type;
+
+	/*
+	 * src_addr_type: 0~1 bits, not used now,
+	 * if support PRP, set this field, or set zero.
+	 * dst_addr_type: 2~4 bits
+	 * mac_addr_type: 5~7 bits
+	 */
+	__u8 sdm_addr_type;
+	__u8 rsvd0;
+
+	/*
+	 * nonce_len(type2): 0~3 bits
+	 * huk(type2): 4 bit
+	 * key_s(type2): 5 bit
+	 * ci_gen: 6~7 bits
+	 */
+	__u8 huk_key_ci;
+
+	/*
+	 * ai_gen: 0~1 bits
+	 * a_pad(type2): 2~3 bits
+	 * c_s(type2): 4~5 bits
+	 */
+	__u8 ai_apd_cs;
+
+	/*
+	 * rhf(type2): 0 bit
+	 * c_key_type: 1~2 bits
+	 * a_key_type: 3~4 bits
+	 * write_frame_len(type2): 5~7 bits
+	 */
+	__u8 rca_key_frm;
+
+	/*
+	 * cal_iv_addr_en(type2): 0 bit
+	 * tls_up(type2): 1 bit
+	 * inveld: 7 bit
+	 */
+	__u8 iv_tls_ld;
+
+	/* Just using type2 BD now */
+	struct sec_sqe_type2 type2;
+};
+
+int sec_register_to_crypto(void);
+void sec_unregister_from_crypto(void);
+#endif
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
new file mode 100644
index 0000000..95d24ed
--- /dev/null
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -0,0 +1,640 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2019 HiSilicon Limited. */
+
+#include <linux/acpi.h>
+#include <linux/aer.h>
+#include <linux/bitops.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/seq_file.h>
+#include <linux/topology.h>
+
+#include "sec.h"
+
+#define SEC_QUEUE_NUM_V1		4096
+#define SEC_QUEUE_NUM_V2		1024
+#define SEC_PF_PCI_DEVICE_ID		0xa255
+
+#define SEC_XTS_MIV_ENABLE_REG		0x301384
+#define SEC_XTS_MIV_ENABLE_MSK		0x7FFFFFFF
+#define SEC_XTS_MIV_DISABLE_MSK		0xFFFFFFFF
+#define SEC_BD_ERR_CHK_EN1		0xfffff7fd
+#define SEC_BD_ERR_CHK_EN2		0xffffbfff
+
+#define SEC_SQE_SIZE			128
+#define SEC_SQ_SIZE			(SEC_SQE_SIZE * QM_Q_DEPTH)
+#define SEC_PF_DEF_Q_NUM		64
+#define SEC_PF_DEF_Q_BASE		0
+#define SEC_CTX_Q_NUM_DEF		24
+
+#define SEC_ENGINE_PF_CFG_OFF		0x300000
+#define SEC_ACC_COMMON_REG_OFF		0x1000
+#define SEC_CORE_INT_SOURCE		0x301010
+#define SEC_CORE_INT_MASK		0x301000
+#define SEC_CORE_INT_STATUS		0x301008
+#define SEC_CORE_SRAM_ECC_ERR_INFO	0x301C14
+#define SEC_ECC_NUM(err)			(((err) >> 16) & 0xFF)
+#define SEC_ECC_ADDR(err)			((err) >> 0)
+#define SEC_CORE_INT_DISABLE		0x0
+#define SEC_CORE_INT_ENABLE		0x1ff
+
+#define SEC_RAS_CE_REG			0x50
+#define SEC_RAS_FE_REG			0x54
+#define SEC_RAS_NFE_REG			0x58
+#define SEC_RAS_CE_ENB_MSK		0x88
+#define SEC_RAS_FE_ENB_MSK		0x0
+#define SEC_RAS_NFE_ENB_MSK		0x177
+#define SEC_RAS_DISABLE			0x0
+#define SEC_MEM_START_INIT_REG		0x0100
+#define SEC_MEM_INIT_DONE_REG		0x0104
+#define SEC_QM_ABNORMAL_INT_MASK	0x100004
+
+#define SEC_CONTROL_REG			0x0200
+#define SEC_TRNG_EN_SHIFT		8
+#define SEC_CLK_GATE_ENABLE		BIT(3)
+#define SEC_CLK_GATE_DISABLE		(~BIT(3))
+#define SEC_AXI_SHUTDOWN_ENABLE	BIT(12)
+#define SEC_AXI_SHUTDOWN_DISABLE	0xFFFFEFFF
+
+#define SEC_INTERFACE_USER_CTRL0_REG	0x0220
+#define SEC_INTERFACE_USER_CTRL1_REG	0x0224
+#define SEC_BD_ERR_CHK_EN_REG1		0x0384
+#define SEC_BD_ERR_CHK_EN_REG2		0x038c
+
+#define SEC_USER0_SMMU_NORMAL		(BIT(23) | BIT(15))
+#define SEC_USER1_SMMU_NORMAL		(BIT(31) | BIT(23) | BIT(15) | BIT(7))
+#define SEC_CORE_INT_STATUS_M_ECC	BIT(2)
+
+#define SEC_DELAY_10_US			10
+#define SEC_POLL_TIMEOUT_US		1000
+
+#define SEC_ADDR(qm, offset) ((qm)->io_base + (offset) + \
+			     SEC_ENGINE_PF_CFG_OFF + SEC_ACC_COMMON_REG_OFF)
+
+struct sec_hw_error {
+	u32 int_msk;
+	const char *msg;
+};
+
+static const char sec_name[] = "hisi_sec2";
+static LIST_HEAD(sec_list);
+static DEFINE_MUTEX(sec_list_lock);
+
+static const struct sec_hw_error sec_hw_errors[] = {
+	{.int_msk = BIT(0), .msg = "sec_axi_rresp_err_rint"},
+	{.int_msk = BIT(1), .msg = "sec_axi_bresp_err_rint"},
+	{.int_msk = BIT(2), .msg = "sec_ecc_2bit_err_rint"},
+	{.int_msk = BIT(3), .msg = "sec_ecc_1bit_err_rint"},
+	{.int_msk = BIT(4), .msg = "sec_req_trng_timeout_rint"},
+	{.int_msk = BIT(5), .msg = "sec_fsm_hbeat_rint"},
+	{.int_msk = BIT(6), .msg = "sec_channel_req_rng_timeout_rint"},
+	{.int_msk = BIT(7), .msg = "sec_bd_err_rint"},
+	{.int_msk = BIT(8), .msg = "sec_chain_buff_err_rint"},
+	{ /* sentinel */ }
+};
+
+struct sec_dev *sec_find_device(int node)
+{
+#define SEC_NUMA_MAX_DISTANCE	100
+	int min_distance = SEC_NUMA_MAX_DISTANCE;
+	int dev_node = 0, free_qp_num = 0;
+	struct sec_dev *sec, *ret = NULL;
+	struct hisi_qm *qm;
+	struct device *dev;
+
+	mutex_lock(&sec_list_lock);
+	list_for_each_entry(sec, &sec_list, list) {
+		qm = &sec->qm;
+		dev = &qm->pdev->dev;
+#ifdef CONFIG_NUMA
+		dev_node = dev->numa_node;
+		if (dev_node < 0)
+			dev_node = 0;
+#endif
+		if (node_distance(dev_node, node) < min_distance) {
+			free_qp_num = hisi_qm_get_free_qp_num(qm);
+			if (free_qp_num >= sec->ctx_q_num) {
+				ret = sec;
+				min_distance = node_distance(dev_node, node);
+			}
+		}
+	}
+	mutex_unlock(&sec_list_lock);
+
+	return ret;
+}
+
+static int sec_pf_q_num_set(const char *val, const struct kernel_param *kp)
+{
+	struct pci_dev *pdev;
+	u32 n, q_num;
+	u8 rev_id;
+	int ret;
+
+	if (!val)
+		return -EINVAL;
+
+	pdev = pci_get_device(PCI_VENDOR_ID_HUAWEI,
+			      SEC_PF_PCI_DEVICE_ID, NULL);
+	if (!pdev) {
+		q_num = min_t(u32, SEC_QUEUE_NUM_V1, SEC_QUEUE_NUM_V2);
+		pr_info("No device, suppose queue number is %d!\n", q_num);
+	} else {
+		rev_id = pdev->revision;
+
+		switch (rev_id) {
+		case QM_HW_V1:
+			q_num = SEC_QUEUE_NUM_V1;
+			break;
+		case QM_HW_V2:
+			q_num = SEC_QUEUE_NUM_V2;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	ret = kstrtou32(val, 10, &n);
+	if (ret || !n || n > q_num)
+		return -EINVAL;
+
+	return param_set_int(val, kp);
+}
+
+static const struct kernel_param_ops sec_pf_q_num_ops = {
+	.set = sec_pf_q_num_set,
+	.get = param_get_int,
+};
+static u32 pf_q_num = SEC_PF_DEF_Q_NUM;
+module_param_cb(pf_q_num, &sec_pf_q_num_ops, &pf_q_num, 0444);
+MODULE_PARM_DESC(pf_q_num, "Number of queues in PF(v1 0-4096, v2 0-1024)");
+
+static int sec_ctx_q_num_set(const char *val, const struct kernel_param *kp)
+{
+	u32 ctx_q_num;
+	int ret;
+
+	if (!val)
+		return -EINVAL;
+
+	ret = kstrtou32(val, 10, &ctx_q_num);
+	if (ret)
+		return -EINVAL;
+
+	if (!ctx_q_num || ctx_q_num > QM_Q_DEPTH || ctx_q_num & 0x1) {
+		pr_err("ctx queue num[%u] is invalid!\n", ctx_q_num);
+		return -EINVAL;
+	}
+
+	return param_set_int(val, kp);
+}
+
+static const struct kernel_param_ops sec_ctx_q_num_ops = {
+	.set = sec_ctx_q_num_set,
+	.get = param_get_int,
+};
+static u32 ctx_q_num = SEC_CTX_Q_NUM_DEF;
+module_param_cb(ctx_q_num, &sec_ctx_q_num_ops, &ctx_q_num, 0444);
+MODULE_PARM_DESC(ctx_q_num, "Number of queue in ctx (2, 4, 6, ..., 1024)");
+
+static const struct pci_device_id sec_dev_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, SEC_PF_PCI_DEVICE_ID) },
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, sec_dev_ids);
+
+static inline void sec_add_to_list(struct sec_dev *sec)
+{
+	mutex_lock(&sec_list_lock);
+	list_add_tail(&sec->list, &sec_list);
+	mutex_unlock(&sec_list_lock);
+}
+
+static inline void sec_remove_from_list(struct sec_dev *sec)
+{
+	mutex_lock(&sec_list_lock);
+	list_del(&sec->list);
+	mutex_unlock(&sec_list_lock);
+}
+
+static u8 sec_get_endian(struct sec_dev *sec)
+{
+	struct hisi_qm *qm = &sec->qm;
+	u32 reg;
+
+	reg = readl_relaxed(qm->io_base + SEC_ENGINE_PF_CFG_OFF +
+			    SEC_ACC_COMMON_REG_OFF + SEC_CONTROL_REG);
+
+	/* BD little endian mode */
+	if (!(reg & BIT(0)))
+		return SEC_LE;
+
+	/* BD 32-bits big endian mode */
+	else if (!(reg & BIT(1)))
+		return SEC_32BE;
+
+	/* BD 64-bits big endian mode */
+	else
+		return SEC_64BE;
+}
+
+static int sec_engine_init(struct sec_dev *sec)
+{
+	struct hisi_qm *qm = &sec->qm;
+	int ret;
+	u32 reg;
+
+	/* disable clock gate control */
+	reg = readl_relaxed(SEC_ADDR(qm, SEC_CONTROL_REG));
+	reg &= SEC_CLK_GATE_DISABLE;
+	writel_relaxed(reg, SEC_ADDR(qm, SEC_CONTROL_REG));
+
+	writel_relaxed(0x1, SEC_ADDR(qm, SEC_MEM_START_INIT_REG));
+
+	ret = readl_relaxed_poll_timeout(SEC_ADDR(qm, SEC_MEM_INIT_DONE_REG),
+					 reg, reg & 0x1, SEC_DELAY_10_US,
+					 SEC_POLL_TIMEOUT_US);
+	if (ret) {
+		dev_err(&qm->pdev->dev, "fail to init sec mem\n");
+		return ret;
+	}
+
+	reg = readl_relaxed(SEC_ADDR(qm, SEC_CONTROL_REG));
+	reg |= (0x1 << SEC_TRNG_EN_SHIFT);
+	writel_relaxed(reg, SEC_ADDR(qm, SEC_CONTROL_REG));
+
+	reg = readl_relaxed(SEC_ADDR(qm, SEC_INTERFACE_USER_CTRL0_REG));
+	reg |= SEC_USER0_SMMU_NORMAL;
+	writel_relaxed(reg, SEC_ADDR(qm, SEC_INTERFACE_USER_CTRL0_REG));
+
+	reg = readl_relaxed(SEC_ADDR(qm, SEC_INTERFACE_USER_CTRL1_REG));
+	reg |= SEC_USER1_SMMU_NORMAL;
+	writel_relaxed(reg, SEC_ADDR(qm, SEC_INTERFACE_USER_CTRL1_REG));
+
+	writel_relaxed(SEC_BD_ERR_CHK_EN1,
+		       SEC_ADDR(qm, SEC_BD_ERR_CHK_EN_REG1));
+	writel_relaxed(SEC_BD_ERR_CHK_EN2,
+		       SEC_ADDR(qm, SEC_BD_ERR_CHK_EN_REG2));
+
+	/* enable clock gate control */
+	reg = readl_relaxed(SEC_ADDR(qm, SEC_CONTROL_REG));
+	reg |= SEC_CLK_GATE_ENABLE;
+	writel_relaxed(reg, SEC_ADDR(qm, SEC_CONTROL_REG));
+
+	/* config endian */
+	reg = readl_relaxed(SEC_ADDR(qm, SEC_CONTROL_REG));
+	reg |= sec_get_endian(sec);
+	writel_relaxed(reg, SEC_ADDR(qm, SEC_CONTROL_REG));
+
+	/* Enable sm4 xts mode multiple iv */
+	writel_relaxed(SEC_XTS_MIV_ENABLE_MSK,
+		       qm->io_base + SEC_XTS_MIV_ENABLE_REG);
+
+	return 0;
+}
+
+static int sec_set_user_domain_and_cache(struct sec_dev *sec)
+{
+	struct hisi_qm *qm = &sec->qm;
+
+	/* qm user domain */
+	writel(AXUSER_BASE, qm->io_base + QM_ARUSER_M_CFG_1);
+	writel(ARUSER_M_CFG_ENABLE, qm->io_base + QM_ARUSER_M_CFG_ENABLE);
+	writel(AXUSER_BASE, qm->io_base + QM_AWUSER_M_CFG_1);
+	writel(AWUSER_M_CFG_ENABLE, qm->io_base + QM_AWUSER_M_CFG_ENABLE);
+	writel(WUSER_M_CFG_ENABLE, qm->io_base + QM_WUSER_M_CFG_ENABLE);
+
+	/* qm cache */
+	writel(AXI_M_CFG, qm->io_base + QM_AXI_M_CFG);
+	writel(AXI_M_CFG_ENABLE, qm->io_base + QM_AXI_M_CFG_ENABLE);
+
+	/* disable FLR triggered by BME(bus master enable) */
+	writel(PEH_AXUSER_CFG, qm->io_base + QM_PEH_AXUSER_CFG);
+	writel(PEH_AXUSER_CFG_ENABLE, qm->io_base + QM_PEH_AXUSER_CFG_ENABLE);
+
+	/* enable sqc,cqc writeback */
+	writel(SQC_CACHE_ENABLE | CQC_CACHE_ENABLE | SQC_CACHE_WB_ENABLE |
+	       CQC_CACHE_WB_ENABLE | FIELD_PREP(SQC_CACHE_WB_THRD, 1) |
+	       FIELD_PREP(CQC_CACHE_WB_THRD, 1), qm->io_base + QM_CACHE_CTL);
+
+	return sec_engine_init(sec);
+}
+
+static void sec_hw_error_enable(struct sec_dev *sec)
+{
+	struct hisi_qm *qm = &sec->qm;
+	u32 val;
+
+	if (qm->ver == QM_HW_V1) {
+		writel(SEC_CORE_INT_DISABLE, qm->io_base + SEC_CORE_INT_MASK);
+		dev_info(&qm->pdev->dev, "V1 not support hw error handle\n");
+		return;
+	}
+
+	val = readl(qm->io_base + SEC_CONTROL_REG);
+
+	/* clear SEC hw error source if having */
+	writel(SEC_CORE_INT_DISABLE, qm->io_base + SEC_CORE_INT_SOURCE);
+
+	/* enable SEC hw error interrupts */
+	writel(SEC_CORE_INT_ENABLE, qm->io_base + SEC_CORE_INT_MASK);
+
+	/* enable RAS int */
+	writel(SEC_RAS_CE_ENB_MSK, qm->io_base + SEC_RAS_CE_REG);
+	writel(SEC_RAS_FE_ENB_MSK, qm->io_base + SEC_RAS_FE_REG);
+	writel(SEC_RAS_NFE_ENB_MSK, qm->io_base + SEC_RAS_NFE_REG);
+
+	/* enable SEC block master OOO when m-bit error occur */
+	val = val | SEC_AXI_SHUTDOWN_ENABLE;
+
+	writel(val, qm->io_base + SEC_CONTROL_REG);
+}
+
+static void sec_hw_error_disable(struct sec_dev *sec)
+{
+	struct hisi_qm *qm = &sec->qm;
+	u32 val;
+
+	val = readl(qm->io_base + SEC_CONTROL_REG);
+
+	/* disable RAS int */
+	writel(SEC_RAS_DISABLE, qm->io_base + SEC_RAS_CE_REG);
+	writel(SEC_RAS_DISABLE, qm->io_base + SEC_RAS_FE_REG);
+	writel(SEC_RAS_DISABLE, qm->io_base + SEC_RAS_NFE_REG);
+
+	/* disable SEC hw error interrupts */
+	writel(SEC_CORE_INT_DISABLE, qm->io_base + SEC_CORE_INT_MASK);
+
+	/* disable SEC block master OOO when m-bit error occur */
+	val = val & SEC_AXI_SHUTDOWN_DISABLE;
+
+	writel(val, qm->io_base + SEC_CONTROL_REG);
+}
+
+static void sec_hw_error_init(struct sec_dev *sec)
+{
+	hisi_qm_hw_error_init(&sec->qm, QM_BASE_CE,
+			      QM_BASE_NFE | QM_ACC_DO_TASK_TIMEOUT
+			      | QM_ACC_WB_NOT_READY_TIMEOUT, 0,
+			      QM_DB_RANDOM_INVALID);
+	sec_hw_error_enable(sec);
+}
+
+static void sec_hw_error_uninit(struct sec_dev *sec)
+{
+	sec_hw_error_disable(sec);
+	writel(GENMASK(12, 0), sec->qm.io_base + SEC_QM_ABNORMAL_INT_MASK);
+}
+
+static int sec_pf_probe_init(struct sec_dev *sec)
+{
+	struct hisi_qm *qm = &sec->qm;
+	int ret;
+
+	switch (qm->ver) {
+	case QM_HW_V1:
+		qm->ctrl_qp_num = SEC_QUEUE_NUM_V1;
+		break;
+
+	case QM_HW_V2:
+		qm->ctrl_qp_num = SEC_QUEUE_NUM_V2;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	ret = sec_set_user_domain_and_cache(sec);
+	if (ret)
+		return ret;
+
+	sec_hw_error_init(sec);
+
+	return 0;
+}
+
+static int sec_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
+{
+	enum qm_hw_ver rev_id;
+
+	rev_id = hisi_qm_get_hw_version(pdev);
+	if (rev_id == QM_HW_UNKNOWN)
+		return -ENODEV;
+
+	qm->pdev = pdev;
+	qm->ver = rev_id;
+
+	qm->sqe_size = SEC_SQE_SIZE;
+	qm->dev_name = sec_name;
+	qm->fun_type = (pdev->device == SEC_PF_PCI_DEVICE_ID) ?
+			QM_HW_PF : QM_HW_VF;
+	qm->use_dma_api = true;
+
+	return hisi_qm_init(qm);
+}
+
+static void sec_qm_uninit(struct hisi_qm *qm)
+{
+	hisi_qm_uninit(qm);
+}
+
+static int sec_probe_init(struct hisi_qm *qm, struct sec_dev *sec)
+{
+	qm->qp_base = SEC_PF_DEF_Q_BASE;
+	qm->qp_num = pf_q_num;
+
+	return sec_pf_probe_init(sec);
+}
+
+static void sec_probe_uninit(struct sec_dev *sec)
+{
+	sec_hw_error_uninit(sec);
+}
+
+static int sec_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct sec_dev *sec;
+	struct hisi_qm *qm;
+	int ret;
+
+	sec = devm_kzalloc(&pdev->dev, sizeof(*sec), GFP_KERNEL);
+	if (!sec)
+		return -ENOMEM;
+
+	pci_set_drvdata(pdev, sec);
+
+	sec->ctx_q_num = ctx_q_num;
+
+	qm = &sec->qm;
+
+	ret = sec_qm_init(qm, pdev);
+	if (ret) {
+		pci_err(pdev, "Failed to pre init qm!\n");
+		return ret;
+	}
+
+	ret = sec_probe_init(qm, sec);
+	if (ret) {
+		pci_err(pdev, "Failed to probe!\n");
+		goto err_qm_uninit;
+	}
+
+	ret = hisi_qm_start(qm);
+	if (ret) {
+		pci_err(pdev, "Failed to start sec qm!\n");
+		goto err_probe_uninit;
+	}
+
+	sec_add_to_list(sec);
+
+	ret = sec_register_to_crypto();
+	if (ret < 0) {
+		pr_err("Failed to register driver to crypto.\n");
+		goto err_remove_from_list;
+	}
+
+	return 0;
+
+err_remove_from_list:
+	sec_remove_from_list(sec);
+	hisi_qm_stop(qm);
+
+err_probe_uninit:
+	sec_probe_uninit(sec);
+
+err_qm_uninit:
+	sec_qm_uninit(qm);
+
+	return ret;
+}
+
+static void sec_remove(struct pci_dev *pdev)
+{
+	struct sec_dev *sec = pci_get_drvdata(pdev);
+	struct hisi_qm *qm = &sec->qm;
+
+	sec_unregister_from_crypto();
+
+	sec_remove_from_list(sec);
+
+	(void)hisi_qm_stop(qm);
+
+	sec_probe_uninit(sec);
+
+	sec_qm_uninit(qm);
+}
+
+static void sec_log_hw_error(struct sec_dev *sec, u32 err_sts)
+{
+	const struct sec_hw_error *errs = sec_hw_errors;
+	struct device *dev = &sec->qm.pdev->dev;
+	u32 err_val;
+
+	while (errs->msg) {
+		if (errs->int_msk & err_sts) {
+			dev_err(dev, "%s [error status=0x%x] found\n",
+				errs->msg, errs->int_msk);
+
+			if (SEC_CORE_INT_STATUS_M_ECC & err_sts) {
+				err_val = readl(sec->qm.io_base +
+						SEC_CORE_SRAM_ECC_ERR_INFO);
+				dev_err(dev, "multi ecc sram num=0x%x\n",
+					SEC_ECC_NUM(err_val));
+				dev_err(dev, "multi ecc sram addr=0x%x\n",
+					SEC_ECC_ADDR(err_val));
+			}
+		}
+		errs++;
+	}
+}
+
+static pci_ers_result_t sec_hw_error_handle(struct sec_dev *sec)
+{
+	u32 err_sts;
+
+	/* read err sts */
+	err_sts = readl(sec->qm.io_base + SEC_CORE_INT_STATUS);
+	if (err_sts) {
+		sec_log_hw_error(sec, err_sts);
+
+		/* clear error interrupts */
+		writel(err_sts, sec->qm.io_base + SEC_CORE_INT_SOURCE);
+
+		return PCI_ERS_RESULT_NEED_RESET;
+	}
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+static pci_ers_result_t sec_process_hw_error(struct pci_dev *pdev)
+{
+	struct sec_dev *sec = pci_get_drvdata(pdev);
+	pci_ers_result_t qm_ret, sec_ret;
+
+	if (!sec) {
+		pci_err(pdev, "Can't recover error during device init\n");
+		return PCI_ERS_RESULT_NONE;
+	}
+
+	/* log qm error */
+	qm_ret = hisi_qm_hw_error_handle(&sec->qm);
+
+	/* log sec error */
+	sec_ret = sec_hw_error_handle(sec);
+
+	return (qm_ret == PCI_ERS_RESULT_NEED_RESET ||
+		sec_ret == PCI_ERS_RESULT_NEED_RESET) ?
+		PCI_ERS_RESULT_NEED_RESET : PCI_ERS_RESULT_RECOVERED;
+}
+
+static pci_ers_result_t sec_error_detected(struct pci_dev *pdev,
+					   pci_channel_state_t state)
+{
+	pci_info(pdev, "PCI error detected, state(=%d)!!\n", state);
+	if (state == pci_channel_io_perm_failure)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	return sec_process_hw_error(pdev);
+}
+
+static const struct pci_error_handlers sec_err_handler = {
+	.error_detected = sec_error_detected,
+};
+
+static struct pci_driver sec_pci_driver = {
+	.name = "hisi_sec2",
+	.id_table = sec_dev_ids,
+	.probe = sec_probe,
+	.remove = sec_remove,
+	.err_handler = &sec_err_handler,
+};
+
+static int __init sec_init(void)
+{
+	int ret;
+
+	ret = pci_register_driver(&sec_pci_driver);
+	if (ret < 0) {
+		pr_err("Failed to register pci driver.\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit sec_exit(void)
+{
+	pci_unregister_driver(&sec_pci_driver);
+}
+
+module_init(sec_init);
+module_exit(sec_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Zaibo Xu <xuzaibo@huawei.com>");
+MODULE_AUTHOR("Longfang Liu <liulongfang@huawei.com>");
+MODULE_AUTHOR("Wei Zhang <zhangwei375@huawei.com>");
+MODULE_DESCRIPTION("Driver for HiSilicon SEC accelerator");
-- 
2.8.1


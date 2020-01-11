Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64448137B28
	for <lists+linux-crypto@lfdr.de>; Sat, 11 Jan 2020 03:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgAKCpy (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 10 Jan 2020 21:45:54 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45452 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728203AbgAKCpx (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 10 Jan 2020 21:45:53 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5AD7212F72B471935EEA;
        Sat, 11 Jan 2020 10:45:49 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Sat, 11 Jan 2020 10:45:43 +0800
From:   Zaibo Xu <xuzaibo@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linuxarm@huawei.com>,
        <jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>,
        <tanghui20@huawei.com>, <yekai13@huawei.com>,
        <liulongfang@huawei.com>, <qianweili@huawei.com>,
        <zhangwei375@huawei.com>, <fanghao11@huawei.com>,
        <forest.zhouchang@huawei.com>
Subject: [PATCH v2 8/9] crypto: hisilicon - redefine skcipher initiation
Date:   Sat, 11 Jan 2020 10:41:55 +0800
Message-ID: <1578710516-40535-9-git-send-email-xuzaibo@huawei.com>
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

1.Define base initiation of QP for context which can be reused.
2.Define cipher initiation for other algorithms.

Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 96 +++++++++++++++++++-----------
 1 file changed, 61 insertions(+), 35 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 521bab8..f919dea 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -273,25 +273,17 @@ static void sec_release_qp_ctx(struct sec_ctx *ctx,
 	hisi_qm_release_qp(qp_ctx->qp);
 }
 
-static int sec_skcipher_init(struct crypto_skcipher *tfm)
+static int sec_ctx_base_init(struct sec_ctx *ctx)
 {
-	struct sec_ctx *ctx = crypto_skcipher_ctx(tfm);
-	struct sec_cipher_ctx *c_ctx;
 	struct sec_dev *sec;
-	struct device *dev;
-	struct hisi_qm *qm;
 	int i, ret;
 
-	crypto_skcipher_set_reqsize(tfm, sizeof(struct sec_req));
-
 	sec = sec_find_device(cpu_to_node(smp_processor_id()));
 	if (!sec) {
 		pr_err("Can not find proper Hisilicon SEC device!\n");
 		return -ENODEV;
 	}
 	ctx->sec = sec;
-	qm = &sec->qm;
-	dev = &qm->pdev->dev;
 	ctx->hlf_q_num = sec->ctx_q_num >> 1;
 
 	/* Half of queue depth is taken as fake requests limit in the queue. */
@@ -302,27 +294,12 @@ static int sec_skcipher_init(struct crypto_skcipher *tfm)
 		return -ENOMEM;
 
 	for (i = 0; i < sec->ctx_q_num; i++) {
-		ret = sec_create_qp_ctx(qm, ctx, i, 0);
+		ret = sec_create_qp_ctx(&sec->qm, ctx, i, 0);
 		if (ret)
 			goto err_sec_release_qp_ctx;
 	}
 
-	c_ctx = &ctx->c_ctx;
-	c_ctx->ivsize = crypto_skcipher_ivsize(tfm);
-	if (c_ctx->ivsize > SEC_IV_SIZE) {
-		dev_err(dev, "get error iv size!\n");
-		ret = -EINVAL;
-		goto err_sec_release_qp_ctx;
-	}
-	c_ctx->c_key = dma_alloc_coherent(dev, SEC_MAX_KEY_SIZE,
-					  &c_ctx->c_key_dma, GFP_KERNEL);
-	if (!c_ctx->c_key) {
-		ret = -ENOMEM;
-		goto err_sec_release_qp_ctx;
-	}
-
 	return 0;
-
 err_sec_release_qp_ctx:
 	for (i = i - 1; i >= 0; i--)
 		sec_release_qp_ctx(ctx, &ctx->qp_ctx[i]);
@@ -331,17 +308,9 @@ static int sec_skcipher_init(struct crypto_skcipher *tfm)
 	return ret;
 }
 
-static void sec_skcipher_uninit(struct crypto_skcipher *tfm)
+static void sec_ctx_base_uninit(struct sec_ctx *ctx)
 {
-	struct sec_ctx *ctx = crypto_skcipher_ctx(tfm);
-	struct sec_cipher_ctx *c_ctx = &ctx->c_ctx;
-	int i = 0;
-
-	if (c_ctx->c_key) {
-		dma_free_coherent(SEC_CTX_DEV(ctx), SEC_MAX_KEY_SIZE,
-				  c_ctx->c_key, c_ctx->c_key_dma);
-		c_ctx->c_key = NULL;
-	}
+	int i;
 
 	for (i = 0; i < ctx->sec->ctx_q_num; i++)
 		sec_release_qp_ctx(ctx, &ctx->qp_ctx[i]);
@@ -349,6 +318,63 @@ static void sec_skcipher_uninit(struct crypto_skcipher *tfm)
 	kfree(ctx->qp_ctx);
 }
 
+static int sec_cipher_init(struct sec_ctx *ctx)
+{
+	struct sec_cipher_ctx *c_ctx = &ctx->c_ctx;
+
+	c_ctx->c_key = dma_alloc_coherent(SEC_CTX_DEV(ctx), SEC_MAX_KEY_SIZE,
+					  &c_ctx->c_key_dma, GFP_KERNEL);
+	if (!c_ctx->c_key)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void sec_cipher_uninit(struct sec_ctx *ctx)
+{
+	struct sec_cipher_ctx *c_ctx = &ctx->c_ctx;
+
+	memzero_explicit(c_ctx->c_key, SEC_MAX_KEY_SIZE);
+	dma_free_coherent(SEC_CTX_DEV(ctx), SEC_MAX_KEY_SIZE,
+			  c_ctx->c_key, c_ctx->c_key_dma);
+}
+
+static int sec_skcipher_init(struct crypto_skcipher *tfm)
+{
+	struct sec_ctx *ctx = crypto_skcipher_ctx(tfm);
+	int ret;
+
+	ctx = crypto_skcipher_ctx(tfm);
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct sec_req));
+	ctx->c_ctx.ivsize = crypto_skcipher_ivsize(tfm);
+	if (ctx->c_ctx.ivsize > SEC_IV_SIZE) {
+		dev_err(SEC_CTX_DEV(ctx), "get error skcipher iv size!\n");
+		return -EINVAL;
+	}
+
+	ret = sec_ctx_base_init(ctx);
+	if (ret)
+		return ret;
+
+	ret = sec_cipher_init(ctx);
+	if (ret)
+		goto err_cipher_init;
+
+	return 0;
+err_cipher_init:
+	sec_ctx_base_uninit(ctx);
+
+	return ret;
+}
+
+static void sec_skcipher_uninit(struct crypto_skcipher *tfm)
+{
+	struct sec_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	sec_cipher_uninit(ctx);
+	sec_ctx_base_uninit(ctx);
+}
+
 static int sec_skcipher_3des_setkey(struct sec_cipher_ctx *c_ctx,
 				    const u32 keylen,
 				    const enum sec_cmode c_mode)
-- 
2.8.1


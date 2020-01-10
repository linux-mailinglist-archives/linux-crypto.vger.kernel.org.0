Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 705B5136893
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Jan 2020 08:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgAJHyF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 10 Jan 2020 02:54:05 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:42536 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726608AbgAJHyE (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 10 Jan 2020 02:54:04 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1AD1252A8FFD2DCD3B5B;
        Fri, 10 Jan 2020 15:53:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Fri, 10 Jan 2020 15:53:42 +0800
From:   Zaibo Xu <xuzaibo@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linuxarm@huawei.com>,
        <jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>,
        <tanghui20@huawei.com>, <yekai13@huawei.com>,
        <liulongfang@huawei.com>, <qianweili@huawei.com>,
        <zhangwei375@huawei.com>, <fanghao11@huawei.com>,
        <forest.zhouchang@huawei.com>
Subject: [PATCH 2/9] crypto: hisilicon - fix print/comment of SEC V2
Date:   Fri, 10 Jan 2020 15:49:51 +0800
Message-ID: <1578642598-8584-3-git-send-email-xuzaibo@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1578642598-8584-1-git-send-email-xuzaibo@huawei.com>
References: <1578642598-8584-1-git-send-email-xuzaibo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Fixed some print, coding style and comments of HiSilicon SEC V2.

Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 8 ++++----
 drivers/crypto/hisilicon/sec2/sec_crypto.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 2475aaf..9dca958 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -245,16 +245,16 @@ static int sec_skcipher_init(struct crypto_skcipher *tfm)
 
 	sec = sec_find_device(cpu_to_node(smp_processor_id()));
 	if (!sec) {
-		pr_err("find no Hisilicon SEC device!\n");
+		pr_err("Can not find proper Hisilicon SEC device!\n");
 		return -ENODEV;
 	}
 	ctx->sec = sec;
 	qm = &sec->qm;
 	dev = &qm->pdev->dev;
-	ctx->hlf_q_num = sec->ctx_q_num >> 0x1;
+	ctx->hlf_q_num = sec->ctx_q_num >> 1;
 
 	/* Half of queue depth is taken as fake requests limit in the queue. */
-	ctx->fake_req_limit = QM_Q_DEPTH >> 0x1;
+	ctx->fake_req_limit = QM_Q_DEPTH >> 1;
 	ctx->qp_ctx = kcalloc(sec->ctx_q_num, sizeof(struct sec_qp_ctx),
 			      GFP_KERNEL);
 	if (!ctx->qp_ctx)
@@ -704,7 +704,7 @@ static int sec_process(struct sec_ctx *ctx, struct sec_req *req)
 
 	ret = ctx->req_op->bd_send(ctx, req);
 	if (ret != -EBUSY && ret != -EINPROGRESS) {
-		dev_err(SEC_CTX_DEV(ctx), "send sec request failed!\n");
+		dev_err_ratelimited(SEC_CTX_DEV(ctx), "send sec request failed!\n");
 		goto err_send_req;
 	}
 
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.h b/drivers/crypto/hisilicon/sec2/sec_crypto.h
index 097dce8..46b3a35 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.h
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.h
@@ -48,8 +48,8 @@ enum sec_addr_type {
 struct sec_sqe_type2 {
 
 	/*
-	 * mac_len: 0~5 bits
-	 * a_key_len: 6~10 bits
+	 * mac_len: 0~4 bits
+	 * a_key_len: 5~10 bits
 	 * a_alg: 11~16 bits
 	 */
 	__le32 mac_key_alg;
-- 
2.8.1


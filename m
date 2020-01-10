Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19A1613688E
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Jan 2020 08:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgAJHxz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 10 Jan 2020 02:53:55 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:42438 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726401AbgAJHxy (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 10 Jan 2020 02:53:54 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F06C69CB4F3436C2AF8C;
        Fri, 10 Jan 2020 15:53:51 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Fri, 10 Jan 2020 15:53:44 +0800
From:   Zaibo Xu <xuzaibo@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linuxarm@huawei.com>,
        <jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>,
        <tanghui20@huawei.com>, <yekai13@huawei.com>,
        <liulongfang@huawei.com>, <qianweili@huawei.com>,
        <zhangwei375@huawei.com>, <fanghao11@huawei.com>,
        <forest.zhouchang@huawei.com>
Subject: [PATCH 6/9] crypto: hisilicon - Add callback error check
Date:   Fri, 10 Jan 2020 15:49:55 +0800
Message-ID: <1578642598-8584-7-git-send-email-xuzaibo@huawei.com>
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

Add error type parameter for call back checking inside.

Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec.h        |  2 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 14 +++++++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index c3b6012..97d5150 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -56,7 +56,7 @@ struct sec_req_op {
 	void (*do_transfer)(struct sec_ctx *ctx, struct sec_req *req);
 	int (*bd_fill)(struct sec_ctx *ctx, struct sec_req *req);
 	int (*bd_send)(struct sec_ctx *ctx, struct sec_req *req);
-	void (*callback)(struct sec_ctx *ctx, struct sec_req *req);
+	void (*callback)(struct sec_ctx *ctx, struct sec_req *req, int err);
 	int (*process)(struct sec_ctx *ctx, struct sec_req *req);
 };
 
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index a6d5207..568c174 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -104,6 +104,7 @@ static void sec_req_cb(struct hisi_qp *qp, void *resp)
 	struct sec_ctx *ctx;
 	struct sec_req *req;
 	u16 done, flag;
+	int err = 0;
 	u8 type;
 
 	type = bd->type_cipher_auth & SEC_TYPE_MASK;
@@ -119,16 +120,18 @@ static void sec_req_cb(struct hisi_qp *qp, void *resp)
 	flag = (le16_to_cpu(bd->type2.done_flag) &
 		SEC_FLAG_MASK) >> SEC_FLAG_OFFSET;
 	if (req->err_type || done != SEC_SQE_DONE ||
-	    flag != SEC_SQE_CFLAG)
+	    flag != SEC_SQE_CFLAG) {
 		dev_err(SEC_CTX_DEV(ctx),
 			"err_type[%d],done[%d],flag[%d]\n",
 			req->err_type, done, flag);
+		err = -EIO;
+	}
 
 	atomic64_inc(&ctx->sec->debug.dfx.recv_cnt);
 
 	ctx->req_op->buf_unmap(ctx, req);
 
-	ctx->req_op->callback(ctx, req);
+	ctx->req_op->callback(ctx, req, err);
 }
 
 static int sec_bd_send(struct sec_ctx *ctx, struct sec_req *req)
@@ -618,7 +621,8 @@ static void sec_update_iv(struct sec_req *req)
 		dev_err(SEC_CTX_DEV(req->ctx), "copy output iv error!\n");
 }
 
-static void sec_skcipher_callback(struct sec_ctx *ctx, struct sec_req *req)
+static void sec_skcipher_callback(struct sec_ctx *ctx, struct sec_req *req,
+				  int err)
 {
 	struct skcipher_request *sk_req = req->c_req.sk_req;
 	struct sec_qp_ctx *qp_ctx = req->qp_ctx;
@@ -627,13 +631,13 @@ static void sec_skcipher_callback(struct sec_ctx *ctx, struct sec_req *req)
 	sec_free_req_id(req);
 
 	/* IV output at encrypto of CBC mode */
-	if (ctx->c_ctx.c_mode == SEC_CMODE_CBC && req->c_req.encrypt)
+	if (!err && ctx->c_ctx.c_mode == SEC_CMODE_CBC && req->c_req.encrypt)
 		sec_update_iv(req);
 
 	if (req->fake_busy)
 		sk_req->base.complete(&sk_req->base, -EINPROGRESS);
 
-	sk_req->base.complete(&sk_req->base, req->err_type);
+	sk_req->base.complete(&sk_req->base, err);
 }
 
 static void sec_request_uninit(struct sec_ctx *ctx, struct sec_req *req)
-- 
2.8.1


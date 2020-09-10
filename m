Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4332653F6
	for <lists+linux-crypto@lfdr.de>; Thu, 10 Sep 2020 23:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgIJVmf (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 10 Sep 2020 17:42:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11767 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730338AbgIJL6D (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 10 Sep 2020 07:58:03 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BE17D38075CA3ECD775F
        for <linux-crypto@vger.kernel.org>; Thu, 10 Sep 2020 19:57:53 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 19:57:51 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>
Subject: [PATCH 5/5] crypto: hisilicon - fixed memory allocation error
Date:   Thu, 10 Sep 2020 19:56:43 +0800
Message-ID: <1599739003-23448-6-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1599739003-23448-1-git-send-email-liulongfang@huawei.com>
References: <1599739003-23448-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

1. Fix the bug of 'mac' memory leak as allocating 'pbuf' failing.
2. Fix the bug of 'qps' leak as allocating 'qp_ctx' failing.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 543d9ee..bb49342 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -340,11 +340,14 @@ static int sec_alg_resource_alloc(struct sec_ctx *ctx,
 		ret = sec_alloc_pbuf_resource(dev, res);
 		if (ret) {
 			dev_err(dev, "fail to alloc pbuf dma resource!\n");
-			goto alloc_fail;
+			goto alloc_pbuf_fail;
 		}
 	}
 
 	return 0;
+alloc_pbuf_fail:
+	if (ctx->alg_type == SEC_AEAD)
+		sec_free_mac_resource(dev, qp_ctx->res);
 alloc_fail:
 	sec_free_civ_resource(dev, res);
 
@@ -455,8 +458,10 @@ static int sec_ctx_base_init(struct sec_ctx *ctx)
 	ctx->fake_req_limit = QM_Q_DEPTH >> 1;
 	ctx->qp_ctx = kcalloc(sec->ctx_q_num, sizeof(struct sec_qp_ctx),
 			      GFP_KERNEL);
-	if (!ctx->qp_ctx)
-		return -ENOMEM;
+	if (!ctx->qp_ctx) {
+		ret = -ENOMEM;
+		goto err_destroy_qps;
+	}
 
 	for (i = 0; i < sec->ctx_q_num; i++) {
 		ret = sec_create_qp_ctx(&sec->qm, ctx, i, 0);
@@ -465,12 +470,15 @@ static int sec_ctx_base_init(struct sec_ctx *ctx)
 	}
 
 	return 0;
+
 err_sec_release_qp_ctx:
 	for (i = i - 1; i >= 0; i--)
 		sec_release_qp_ctx(ctx, &ctx->qp_ctx[i]);
 
-	sec_destroy_qps(ctx->qps, sec->ctx_q_num);
 	kfree(ctx->qp_ctx);
+err_destroy_qps:
+	sec_destroy_qps(ctx->qps, sec->ctx_q_num);
+
 	return ret;
 }
 
-- 
2.8.1


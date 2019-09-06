Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60711AB818
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Sep 2019 14:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391464AbfIFMZX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 6 Sep 2019 08:25:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57302 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731928AbfIFMZX (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 6 Sep 2019 08:25:23 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3DFD49630CBDFC79E2B7;
        Fri,  6 Sep 2019 20:25:21 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Sep 2019
 20:25:10 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] crypto: essiv - Remove unnecessary NULL checks
Date:   Fri, 6 Sep 2019 20:25:02 +0800
Message-ID: <20190906122502.27236-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

NULL check before kfree is not needed.
Generated-by: scripts/coccinelle/free/ifnullfree.cocci

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 crypto/essiv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/crypto/essiv.c b/crypto/essiv.c
index a8befc8..3d3f9d7 100644
--- a/crypto/essiv.c
+++ b/crypto/essiv.c
@@ -188,8 +188,7 @@ static void essiv_aead_done(struct crypto_async_request *areq, int err)
 	struct aead_request *req = areq->data;
 	struct essiv_aead_request_ctx *rctx = aead_request_ctx(req);
 
-	if (rctx->assoc)
-		kfree(rctx->assoc);
+	kfree(rctx->assoc);
 	aead_request_complete(req, err);
 }
 
-- 
2.7.4



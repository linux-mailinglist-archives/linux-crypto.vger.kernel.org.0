Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCF3FFEAFD
	for <lists+linux-crypto@lfdr.de>; Sat, 16 Nov 2019 07:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfKPGoX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 16 Nov 2019 01:44:23 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:60154 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726154AbfKPGoW (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 16 Nov 2019 01:44:22 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 98ECDBF089C18B1D5264;
        Sat, 16 Nov 2019 14:44:18 +0800 (CST)
Received: from localhost.localdomain (10.90.53.225) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Sat, 16 Nov 2019 14:44:09 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <chenwandun@huawei.com>
Subject: [PATCH] crypto: essiv: remove redundant null pointer check before kfree
Date:   Sat, 16 Nov 2019 14:51:00 +0800
Message-ID: <1573887060-100725-1-git-send-email-chenwandun@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

kfree has taken null pointer check into account. so it is safe to
remove the unnecessary check.

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 crypto/essiv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/crypto/essiv.c b/crypto/essiv.c
index efea5af..75d810d 100644
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


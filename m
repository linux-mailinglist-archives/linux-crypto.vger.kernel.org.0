Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1A981002C9
	for <lists+linux-crypto@lfdr.de>; Mon, 18 Nov 2019 11:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfKRKqp (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 18 Nov 2019 05:46:45 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40600 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726460AbfKRKqp (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 18 Nov 2019 05:46:45 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 39A2E5FFD6C589ED04F9;
        Mon, 18 Nov 2019 18:46:43 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 18 Nov 2019
 18:46:32 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <antoine.tenart@bootlin.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <linux-crypto@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH -next] crypto: inside-secure: Use PTR_ERR_OR_ZERO() to simplify code
Date:   Mon, 18 Nov 2019 18:53:56 +0800
Message-ID: <1574074436-32134-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Fixes coccicheck warning:

drivers/crypto/inside-secure/safexcel_cipher.c:2534:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/crypto/inside-secure/safexcel_cipher.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel_cipher.c b/drivers/crypto/inside-secure/safexcel_cipher.c
index c029956..08cb495 100644
--- a/drivers/crypto/inside-secure/safexcel_cipher.c
+++ b/drivers/crypto/inside-secure/safexcel_cipher.c
@@ -2532,10 +2532,7 @@ static int safexcel_aead_gcm_cra_init(struct crypto_tfm *tfm)
 	ctx->mode = CONTEXT_CONTROL_CRYPTO_MODE_XCM; /* override default */

 	ctx->hkaes = crypto_alloc_cipher("aes", 0, 0);
-	if (IS_ERR(ctx->hkaes))
-		return PTR_ERR(ctx->hkaes);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(ctx->hkaes);
 }

 static void safexcel_aead_gcm_cra_exit(struct crypto_tfm *tfm)
--
2.7.4


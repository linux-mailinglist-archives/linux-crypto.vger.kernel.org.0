Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8B2E7E3E
	for <lists+linux-crypto@lfdr.de>; Tue, 29 Oct 2019 02:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbfJ2Bzy (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 28 Oct 2019 21:55:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43598 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728432AbfJ2Bzy (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 28 Oct 2019 21:55:54 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5B94AC70F17D91E33609;
        Tue, 29 Oct 2019 09:55:49 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Tue, 29 Oct 2019 09:55:41 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Corentin Labbe <clabbe@baylibre.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] crypto: amlogic - Use kmemdup in meson_aes_setkey()
Date:   Tue, 29 Oct 2019 01:55:23 +0000
Message-ID: <20191029015523.126987-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Use kmemdup rather than duplicating its implementation

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/crypto/amlogic/amlogic-gxl-cipher.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
index e9283ffdbd23..78e776c58705 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
@@ -372,10 +372,9 @@ int meson_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
 		kfree(op->key);
 	}
 	op->keylen = keylen;
-	op->key = kmalloc(keylen, GFP_KERNEL | GFP_DMA);
+	op->key = kmemdup(key, keylen, GFP_KERNEL | GFP_DMA);
 	if (!op->key)
 		return -ENOMEM;
-	memcpy(op->key, key, keylen);
 
 	return crypto_sync_skcipher_setkey(op->fallback_tfm, key, keylen);
 }




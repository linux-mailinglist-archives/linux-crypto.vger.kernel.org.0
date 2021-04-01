Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E9A350CE1
	for <lists+linux-crypto@lfdr.de>; Thu,  1 Apr 2021 05:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhDADEd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 31 Mar 2021 23:04:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15422 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhDADEU (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 31 Mar 2021 23:04:20 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F9nzb2QzDzjXR5;
        Thu,  1 Apr 2021 11:02:35 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Thu, 1 Apr 2021
 11:04:09 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <heiko@sntech.de>, <linux-rockchip@lists.infradead.org>,
        <shenyang39@huawei.com>, <yekai13@huawei.com>
Subject: [PATCH] crypto: rockchip/rk3288_crypto_ahash - delete unneeded variable initialization
Date:   Thu, 1 Apr 2021 11:01:39 +0800
Message-ID: <1617246099-2157-1-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Delete unneeded variable initialization

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/rockchip/rk3288_crypto_ahash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
index 81befe7..ed03058 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -48,7 +48,7 @@ static void rk_ahash_reg_init(struct rk_crypto_info *dev)
 {
 	struct ahash_request *req = ahash_request_cast(dev->async_req);
 	struct rk_ahash_rctx *rctx = ahash_request_ctx(req);
-	int reg_status = 0;
+	int reg_status;
 
 	reg_status = CRYPTO_READ(dev, RK_CRYPTO_CTRL) |
 		     RK_CRYPTO_HASH_FLUSH | _SBF(0xffff, 16);
-- 
2.8.1


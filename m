Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10EA8A6202
	for <lists+linux-crypto@lfdr.de>; Tue,  3 Sep 2019 08:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfICG5T (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 3 Sep 2019 02:57:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49374 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbfICG5T (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 3 Sep 2019 02:57:19 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 65F0365CFEEEB187FB60;
        Tue,  3 Sep 2019 14:57:17 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Tue, 3 Sep 2019 14:57:10 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <catalin.marinas@arm.com>
CC:     <will@kernel.org>, <zhongjiang@huawei.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] crypto: arm64: Use PTR_ERR_OR_ZERO rather than its implementation.
Date:   Tue, 3 Sep 2019 14:54:16 +0800
Message-ID: <1567493656-19916-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

PTR_ERR_OR_ZERO contains if(IS_ERR(...)) + PTR_ERR. It is better to
use it directly. hence just replace it.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 arch/arm64/crypto/aes-glue.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/crypto/aes-glue.c b/arch/arm64/crypto/aes-glue.c
index ca0c84d..2a2e0a3 100644
--- a/arch/arm64/crypto/aes-glue.c
+++ b/arch/arm64/crypto/aes-glue.c
@@ -409,10 +409,8 @@ static int essiv_cbc_init_tfm(struct crypto_skcipher *tfm)
 	struct crypto_aes_essiv_cbc_ctx *ctx = crypto_skcipher_ctx(tfm);
 
 	ctx->hash = crypto_alloc_shash("sha256", 0, 0);
-	if (IS_ERR(ctx->hash))
-		return PTR_ERR(ctx->hash);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(ctx->hash);
 }
 
 static void essiv_cbc_exit_tfm(struct crypto_skcipher *tfm)
-- 
1.7.12.4


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF4A1BED1A
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Apr 2020 02:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgD3AsO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 29 Apr 2020 20:48:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3386 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726309AbgD3AsO (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 29 Apr 2020 20:48:14 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4B90C99083E5249DB887;
        Thu, 30 Apr 2020 08:48:12 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.201.159) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 30 Apr 2020 08:48:03 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH] crypto: acomp - search acomp with scomp backend in crypto_has_acomp
Date:   Thu, 30 Apr 2020 12:47:32 +1200
Message-ID: <20200430004732.24092-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.201.159]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

users may call crypto_has_acomp to confirm the existence of acomp before using
crypto_acomp APIs. Right now, many of acomp have scomp backend, for example,
lz4, lzo, deflate etc. crypto_has_acomp will return false for them even though
they support acomp APIs.

One possible way to make has_acomp true for them is calling this APIs like
crypto_has_acomp("xxx", CRYPTO_ALG_TYPE_SCOMPRESS, 0);
But it looks quite weird.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 include/crypto/acompress.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index d873f999b334..a7170848e6c2 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -156,7 +156,7 @@ static inline void crypto_free_acomp(struct crypto_acomp *tfm)
 static inline int crypto_has_acomp(const char *alg_name, u32 type, u32 mask)
 {
 	type &= ~CRYPTO_ALG_TYPE_MASK;
-	type |= CRYPTO_ALG_TYPE_ACOMPRESS;
+	type |= CRYPTO_ALG_TYPE_ACOMPRESS | CRYPTO_ALG_TYPE_SCOMPRESS;
 	mask |= CRYPTO_ALG_TYPE_MASK;
 
 	return crypto_has_alg(alg_name, type, mask);
-- 
2.23.0



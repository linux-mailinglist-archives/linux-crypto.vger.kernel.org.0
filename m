Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9A91BEF98
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Apr 2020 07:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgD3FLB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 30 Apr 2020 01:11:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3346 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726040AbgD3FLB (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 30 Apr 2020 01:11:01 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AA2E48E90DCB2FABEFC0;
        Thu, 30 Apr 2020 13:10:59 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.201.159) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 30 Apr 2020 13:10:50 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v2] crypto: acomp - search acomp with scomp backend in crypto_has_acomp
Date:   Thu, 30 Apr 2020 17:10:18 +1200
Message-ID: <20200430051018.24220-1-song.bao.hua@hisilicon.com>
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
crypto_acomp APIs. Right now, many acomp have scomp backend, for example, lz4,
lzo, deflate etc. crypto_has_acomp will return false for them even though they
support acomp APIs.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v2: fixed the mask according to herbert's feedback

 include/crypto/acompress.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index d873f999b334..2b4d2b06ccbd 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -157,7 +157,7 @@ static inline int crypto_has_acomp(const char *alg_name, u32 type, u32 mask)
 {
 	type &= ~CRYPTO_ALG_TYPE_MASK;
 	type |= CRYPTO_ALG_TYPE_ACOMPRESS;
-	mask |= CRYPTO_ALG_TYPE_MASK;
+	mask |= CRYPTO_ALG_TYPE_ACOMPRESS_MASK;
 
 	return crypto_has_alg(alg_name, type, mask);
 }
-- 
2.23.0



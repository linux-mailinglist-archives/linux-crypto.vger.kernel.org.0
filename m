Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9626087408
	for <lists+linux-crypto@lfdr.de>; Fri,  9 Aug 2019 10:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405415AbfHIIaK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 9 Aug 2019 04:30:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4207 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727063AbfHIIaJ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 9 Aug 2019 04:30:09 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EC09F52A59B69BE39AF9;
        Fri,  9 Aug 2019 16:29:51 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 9 Aug 2019
 16:29:42 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] crypto: aes-generic - remove unused variable 'rco_tab'
Date:   Fri, 9 Aug 2019 16:29:19 +0800
Message-ID: <20190809082919.62776-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

crypto/aes_generic.c:64:18: warning:
 rco_tab defined but not used [-Wunused-const-variable=]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 crypto/aes_generic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/crypto/aes_generic.c b/crypto/aes_generic.c
index 71a5c19..22e5867 100644
--- a/crypto/aes_generic.c
+++ b/crypto/aes_generic.c
@@ -61,8 +61,6 @@ static inline u8 byte(const u32 x, const unsigned n)
 	return x >> (n << 3);
 }
 
-static const u32 rco_tab[10] = { 1, 2, 4, 8, 16, 32, 64, 128, 27, 54 };
-
 /* cacheline-aligned to facilitate prefetching into cache */
 __visible const u32 crypto_ft_tab[4][256] ____cacheline_aligned = {
 	{
-- 
2.7.4



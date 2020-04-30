Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378ED1BF259
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Apr 2020 10:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgD3IMz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 30 Apr 2020 04:12:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3348 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726127AbgD3IMy (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 30 Apr 2020 04:12:54 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1DB083B724FE325DDA59;
        Thu, 30 Apr 2020 16:12:53 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 30 Apr 2020 16:12:42 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Stephan Mueller <smueller@chronox.de>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-crypto@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] crypto: drbg - fix error return code in drbg_alloc_state()
Date:   Thu, 30 Apr 2020 08:13:53 +0000
Message-ID: <20200430081353.112449-1-weiyongjun1@huawei.com>
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

Fix to return negative error code -ENOMEM from the kzalloc error handling
case instead of 0, as done elsewhere in this function.

Fixes: db07cd26ac6a ("crypto: drbg - add FIPS 140-2 CTRNG for noise source")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 crypto/drbg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index e57901d8545b..37526eb8c5d5 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -1306,8 +1306,10 @@ static inline int drbg_alloc_state(struct drbg_state *drbg)
 	if (IS_ENABLED(CONFIG_CRYPTO_FIPS)) {
 		drbg->prev = kzalloc(drbg_sec_strength(drbg->core->flags),
 				     GFP_KERNEL);
-		if (!drbg->prev)
+		if (!drbg->prev) {
+			ret = -ENOMEM;
 			goto fini;
+		}
 		drbg->fips_primed = false;
 	}




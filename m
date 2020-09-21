Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616C3271CCF
	for <lists+linux-crypto@lfdr.de>; Mon, 21 Sep 2020 10:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgIUICS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 21 Sep 2020 04:02:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13784 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726405AbgIUICQ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 21 Sep 2020 04:02:16 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6E7146C3D7A003C06059;
        Mon, 21 Sep 2020 16:02:11 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Mon, 21 Sep 2020
 16:02:03 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     George Cherian <gcherian@marvell.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] crypto: cpt - simplify the return expression of cav_register_algs
Date:   Mon, 21 Sep 2020 16:24:28 +0800
Message-ID: <20200921082428.2591094-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Simplify the return expression.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/crypto/cavium/cpt/cptvf_algs.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/crypto/cavium/cpt/cptvf_algs.c b/drivers/crypto/cavium/cpt/cptvf_algs.c
index 5af0dc2a8909..ce3b91c612f0 100644
--- a/drivers/crypto/cavium/cpt/cptvf_algs.c
+++ b/drivers/crypto/cavium/cpt/cptvf_algs.c
@@ -451,13 +451,7 @@ static struct skcipher_alg algs[] = { {
 
 static inline int cav_register_algs(void)
 {
-	int err = 0;
-
-	err = crypto_register_skciphers(algs, ARRAY_SIZE(algs));
-	if (err)
-		return err;
-
-	return 0;
+	return crypto_register_skciphers(algs, ARRAY_SIZE(algs));
 }
 
 static inline void cav_unregister_algs(void)
-- 
2.25.1


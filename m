Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D90E1F638D
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2020 10:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgFKI1J (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 11 Jun 2020 04:27:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5879 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726697AbgFKI1J (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 11 Jun 2020 04:27:09 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8D54A3010D6E6A3E5577;
        Thu, 11 Jun 2020 16:26:59 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Thu, 11 Jun 2020
 16:26:51 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <smueller@chronox.de>, <linux-crypto@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH] crypto: drbg - Fix memleak in drbg_prepare_hrng
Date:   Thu, 11 Jun 2020 16:33:56 +0800
Message-ID: <20200611083356.88600-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

drbg_prepare_hrng
  drbg->jent = crypto_alloc_rng
  err = add_random_ready_callback
  default:
    drbg->random_ready.func = NULL  -->set NULL, if fail

drbg_uninstantiate
  if (drbg->random_ready.func)      -->If NULL, will not free drbg->jent
    crypto_free_rng(drbg->jent)

Need to free drbg->jent if add_random_ready_callback return fail.

Fixes: 97f2650e5040 ("crypto: drbg - always seeded with SP800-90B compliant noise source")
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 crypto/drbg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index 37526eb8c5d5..a643ab7eac7a 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -1524,6 +1524,8 @@ static int drbg_prepare_hrng(struct drbg_state *drbg)
 		/* fall through */

 	default:
+		crypto_free_rng(drbg->jent);
+		drbg->jent = NULL;
 		drbg->random_ready.func = NULL;
 		return err;
 	}
--
2.26.0.106.g9fadedd


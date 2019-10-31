Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2AF2EAAD1
	for <lists+linux-crypto@lfdr.de>; Thu, 31 Oct 2019 08:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfJaHCR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 31 Oct 2019 03:02:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5658 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726535AbfJaHCR (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 31 Oct 2019 03:02:17 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 269BFEE5CC8800A2EB72;
        Thu, 31 Oct 2019 15:02:15 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Thu, 31 Oct 2019
 15:02:08 +0800
Subject: [PATCH v3] crypto: arm64/aes-neonbs - add return value of
 skcipher_walk_done() in __xts_crypt()
From:   Yunfeng Ye <yeyunfeng@huawei.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <ard.biesheuvel@linaro.org>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
References: <aaf0f585-3a06-8af1-e2f1-ab301e560d49@huawei.com>
Message-ID: <32b39396-d514-524f-a85c-3bc627454ba7@huawei.com>
Date:   Thu, 31 Oct 2019 15:01:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <aaf0f585-3a06-8af1-e2f1-ab301e560d49@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

A warning is found by the static code analysis tool:
  "Identical condition 'err', second condition is always false"

Fix this by adding return value of skcipher_walk_done().

Fixes: 67cfa5d3b721 ("crypto: arm64/aes-neonbs - implement ciphertext stealing for XTS")
Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
v2 -> v3:
 - add "Acked-by:"

v1 -> v2:
 - update the subject and comment
 - add return value of skcipher_walk_done()

 arch/arm64/crypto/aes-neonbs-glue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/crypto/aes-neonbs-glue.c b/arch/arm64/crypto/aes-neonbs-glue.c
index ea873b8904c4..e3e27349a9fe 100644
--- a/arch/arm64/crypto/aes-neonbs-glue.c
+++ b/arch/arm64/crypto/aes-neonbs-glue.c
@@ -384,7 +384,7 @@ static int __xts_crypt(struct skcipher_request *req, bool encrypt,
 			goto xts_tail;

 		kernel_neon_end();
-		skcipher_walk_done(&walk, nbytes);
+		err = skcipher_walk_done(&walk, nbytes);
 	}

 	if (err || likely(!tail))
-- 
2.7.4.3



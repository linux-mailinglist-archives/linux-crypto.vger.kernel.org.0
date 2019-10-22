Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D021DFE48
	for <lists+linux-crypto@lfdr.de>; Tue, 22 Oct 2019 09:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbfJVH2a (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 22 Oct 2019 03:28:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47846 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726160AbfJVH2a (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 22 Oct 2019 03:28:30 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BC5A6C0F48EC10878760;
        Tue, 22 Oct 2019 15:28:27 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 22 Oct 2019
 15:28:18 +0800
To:     Herbert Xu <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <ard.biesheuvel@linaro.org>
CC:     <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <hushiyuan@huawei.com>,
        <linfeilong@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH v2] crypto: arm64/aes-neonbs - add return value of
 skcipher_walk_done() in __xts_crypt()
Message-ID: <0812dca3-8447-be46-b84c-e89f25176cbf@huawei.com>
Date:   Tue, 22 Oct 2019 15:28:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
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
---
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


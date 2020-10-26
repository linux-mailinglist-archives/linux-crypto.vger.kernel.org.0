Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC944298E24
	for <lists+linux-crypto@lfdr.de>; Mon, 26 Oct 2020 14:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780292AbgJZNh3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 26 Oct 2020 09:37:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3129 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780222AbgJZNh3 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 26 Oct 2020 09:37:29 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CKbVg5N4QzLn0N;
        Mon, 26 Oct 2020 21:37:31 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Mon, 26 Oct 2020
 21:37:22 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux-crypto@vger.kernel.org>
Subject: [PATCH -next] crypto: atmel-sha: discard unnecessary break
Date:   Mon, 26 Oct 2020 21:48:07 +0800
Message-ID: <20201026134807.13947-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The 'break' is unnecessary because of previous
'return', discard it.

Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/crypto/atmel-sha.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
index 75ccf41a7cb9..0eb6f54e3b66 100644
--- a/drivers/crypto/atmel-sha.c
+++ b/drivers/crypto/atmel-sha.c
@@ -459,7 +459,6 @@ static int atmel_sha_init(struct ahash_request *req)
 		break;
 	default:
 		return -EINVAL;
-		break;
 	}
 
 	ctx->bufcnt = 0;
-- 
2.17.1


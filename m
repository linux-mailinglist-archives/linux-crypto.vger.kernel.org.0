Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57373DD5CD
	for <lists+linux-crypto@lfdr.de>; Sat, 19 Oct 2019 02:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfJSAo3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 18 Oct 2019 20:44:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4690 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726718AbfJSAo3 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 18 Oct 2019 20:44:29 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B31A8EB5CADE15A0E1F4;
        Sat, 19 Oct 2019 08:44:26 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Sat, 19 Oct 2019 08:44:15 +0800
From:   Tian Tao <tiantao6@huawei.com>
To:     <gilad@benyossef.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <linux-crypto@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH v2] crypto: fix comparison of unsigned expression warning
Date:   Sat, 19 Oct 2019 08:41:37 +0800
Message-ID: <1571445697-33824-1-git-send-email-tiantao6@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch fixes the following warnings:
drivers/crypto/ccree/cc_aead.c:630:5-12: WARNING: Unsigned expression
compared with zero: seq_len > 0

Signed-off-by: Tian Tao <tiantao6@huawei.com>

v2:
change hmac_setkey() return type to unsigned int to fix the warning.
---
 drivers/crypto/ccree/cc_aead.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ccree/cc_aead.c b/drivers/crypto/ccree/cc_aead.c
index d3e8faa..64d318d 100644
--- a/drivers/crypto/ccree/cc_aead.c
+++ b/drivers/crypto/ccree/cc_aead.c
@@ -293,7 +293,8 @@ static unsigned int xcbc_setkey(struct cc_hw_desc *desc,
 	return 4;
 }
 
-static int hmac_setkey(struct cc_hw_desc *desc, struct cc_aead_ctx *ctx)
+static unsigned int hmac_setkey(struct cc_hw_desc *desc,
+				struct cc_aead_ctx *ctx)
 {
 	unsigned int hmac_pad_const[2] = { HMAC_IPAD_CONST, HMAC_OPAD_CONST };
 	unsigned int digest_ofs = 0;
-- 
2.7.4


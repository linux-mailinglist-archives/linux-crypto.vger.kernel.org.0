Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372F03047B0
	for <lists+linux-crypto@lfdr.de>; Tue, 26 Jan 2021 20:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbhAZF6u (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 26 Jan 2021 00:58:50 -0500
Received: from mail-m975.mail.163.com ([123.126.97.5]:51558 "EHLO
        mail-m975.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbhAZEXh (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 25 Jan 2021 23:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5Qzhy
        HkOIhzhyDKQmARRKm/yKJdbh50BiqAFk60dd7M=; b=HQv1XYRkgJvVvwKz2p6MX
        m2HfOT5CjTGyT18MnKmQfxiqV85u7AWSyu03/iTYhPwWaUy8m+qf3d7XBCgq8gwJ
        wedBfvtUsKhEoKCxBE6gVoWq26FjRfP5V6atMD4vOTgGSX7CmCfjfIuq8TY+ZUhm
        WeGj6Nymf10UjaozghbmMA=
Received: from COOL-20201222LC.ccdomain.com (unknown [218.94.48.178])
        by smtp5 (Coremail) with SMTP id HdxpCgD3_4FpkA9gI1qZAA--.101S2;
        Tue, 26 Jan 2021 11:45:52 +0800 (CST)
From:   dingsenjie@163.com
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        dingsenjie <dingsenjie@yulong.com>
Subject: [PATCH] crypto/ccree: fix spelling typo of allocated
Date:   Tue, 26 Jan 2021 11:45:53 +0800
Message-Id: <20210126034553.44496-1-dingsenjie@163.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgD3_4FpkA9gI1qZAA--.101S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw4xWrWDurW5tr43AF1DJrb_yoW3Awb_u3
        yxWay7Xryj9wn3tr4UJw48ZrWF9343uFs2gr4jqrW5XFy3Zrs5uFy7ur13Ar17JrWrXryk
        uws2g3Wayw43ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5cNVDUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5glqw25hqmxvi6rwjhhfrp/1tbiThEmyFUDHcZbaAAAsP
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: dingsenjie <dingsenjie@yulong.com>

allocted -> allocated

Signed-off-by: dingsenjie <dingsenjie@yulong.com>
---
 drivers/crypto/ccree/cc_cipher.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_cipher.c
index cdfee50..78833491 100644
--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -921,7 +921,7 @@ static int cc_cipher_process(struct skcipher_request *req,
 			return crypto_skcipher_decrypt(subreq);
 	}
 
-	/* The IV we are handed may be allocted from the stack so
+	/* The IV we are handed may be allocated from the stack so
 	 * we must copy it to a DMAable buffer before use.
 	 */
 	req_ctx->iv = kmemdup(iv, ivsize, flags);
-- 
1.9.1


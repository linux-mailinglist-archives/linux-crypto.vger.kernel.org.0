Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31175168F50
	for <lists+linux-crypto@lfdr.de>; Sat, 22 Feb 2020 15:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgBVOYW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 22 Feb 2020 09:24:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54623 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbgBVOYW (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 22 Feb 2020 09:24:22 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1j5VhS-0002wG-2x; Sat, 22 Feb 2020 14:24:10 +0000
From:   Colin King <colin.king@canonical.com>
To:     Zaibo Xu <xuzaibo@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: hisilicon: remove redundant assignment of pointer ctx
Date:   Sat, 22 Feb 2020 14:24:09 +0000
Message-Id: <20200222142409.141057-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer ctx is being re-assigned with the same value as it
was initialized with. The second assignment is redundant and
can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index a2cfcc9ccd94..acd15507eb8a 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -447,7 +447,6 @@ static int sec_skcipher_init(struct crypto_skcipher *tfm)
 	struct sec_ctx *ctx = crypto_skcipher_ctx(tfm);
 	int ret;
 
-	ctx = crypto_skcipher_ctx(tfm);
 	ctx->alg_type = SEC_SKCIPHER;
 	crypto_skcipher_set_reqsize(tfm, sizeof(struct sec_req));
 	ctx->c_ctx.ivsize = crypto_skcipher_ivsize(tfm);
-- 
2.25.0


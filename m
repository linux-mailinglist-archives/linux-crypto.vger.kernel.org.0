Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0CE3A7B89
	for <lists+linux-crypto@lfdr.de>; Tue, 15 Jun 2021 12:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhFOKOG (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 15 Jun 2021 06:14:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54820 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbhFOKOF (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 15 Jun 2021 06:14:05 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lt62z-0001AH-K8; Tue, 15 Jun 2021 10:11:53 +0000
From:   Colin King <colin.king@canonical.com>
To:     Zaibo Xu <xuzaibo@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] crypto: hisilicon/sec: Fix spelling mistake "fallbcak" -> "fallback"
Date:   Tue, 15 Jun 2021 11:11:53 +0100
Message-Id: <20210615101153.9298-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index f23af61661de..6a45bd23b363 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -2290,7 +2290,7 @@ static int sec_aead_soft_crypto(struct sec_ctx *ctx,
 
 	/* Kunpeng920 aead mode not support input 0 size */
 	if (!a_ctx->fallback_aead_tfm) {
-		dev_err(dev, "aead fallbcak tfm is NULL!\n");
+		dev_err(dev, "aead fallback tfm is NULL!\n");
 		return -EINVAL;
 	}
 
-- 
2.31.1


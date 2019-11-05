Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCC1EFE6A
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Nov 2019 14:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389191AbfKEN3D (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 5 Nov 2019 08:29:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:46946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389188AbfKEN3D (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 5 Nov 2019 08:29:03 -0500
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr [92.154.90.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79C5521D71;
        Tue,  5 Nov 2019 13:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572960542;
        bh=VYUc7H1Xh4KIjG/XZ8hBFMZNaIpuAv8g4BLpVaCaXFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zlqJMH4nP7n+w7GuJtHx6OBpYMOe8mMYS/5zL8i/AepqC750sLHKLiWmkWkpp7HIA
         wFIueqSCR6rebJUp+t+ZfdoUJ5IrtE2Wd0fd/1tEK4uJ6m/LYCiI9Px5wViyoZpWDf
         c0aC6orZK/kmRTu6g9nZ7ko1OjN/u9lvqfpdhLr8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 11/29] crypto: nitrox - remove cra_type reference to ablkcipher
Date:   Tue,  5 Nov 2019 14:28:08 +0100
Message-Id: <20191105132826.1838-12-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191105132826.1838-1-ardb@kernel.org>
References: <20191105132826.1838-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Setting the cra_type field is not necessary for skciphers, and ablkcipher
will be removed, so drop the assignment from the nitrox driver.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/crypto/cavium/nitrox/nitrox_skcipher.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_skcipher.c b/drivers/crypto/cavium/nitrox/nitrox_skcipher.c
index ec3aaadc6fd7..97af4d50d003 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_skcipher.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_skcipher.c
@@ -493,7 +493,6 @@ static struct skcipher_alg nitrox_skciphers[] = { {
 		.cra_blocksize = AES_BLOCK_SIZE,
 		.cra_ctxsize = sizeof(struct nitrox_crypto_ctx),
 		.cra_alignmask = 0,
-		.cra_type = &crypto_ablkcipher_type,
 		.cra_module = THIS_MODULE,
 	},
 	.min_keysize = AES_MIN_KEY_SIZE,
-- 
2.20.1


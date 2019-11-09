Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61B70F606D
	for <lists+linux-crypto@lfdr.de>; Sat,  9 Nov 2019 18:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfKIRLE (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 9 Nov 2019 12:11:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:40808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfKIRLE (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 9 Nov 2019 12:11:04 -0500
Received: from e123331-lin.home (lfbn-mar-1-643-104.w90-118.abo.wanadoo.fr [90.118.215.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7EBE207FF;
        Sat,  9 Nov 2019 17:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573319463;
        bh=t/cjLXJWZqPlPd37A7euREnEzsShkS0Z5pt1SmPn+Eg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wgTWjVatZQvc0L4lGyLiNc3tEWapYrS5fq8JgpN+bHDsVRUHIxuux5rjwDxeGBz7W
         n4iBK6AR4UqtDrobkLMyZkHKjlDAuJGfY1x6YJ+N38nZHkv/aGZ/csH+W4tcGv+WFq
         v6FzrdbosC3jXv2p39Av1Ij6bCZWPYqqWki+Z1ms=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 11/29] crypto: nitrox - remove cra_type reference to ablkcipher
Date:   Sat,  9 Nov 2019 18:09:36 +0100
Message-Id: <20191109170954.756-12-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191109170954.756-1-ardb@kernel.org>
References: <20191109170954.756-1-ardb@kernel.org>
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
2.17.1


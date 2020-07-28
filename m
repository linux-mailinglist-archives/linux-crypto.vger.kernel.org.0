Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B002303E4
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Jul 2020 09:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgG1HTs (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 28 Jul 2020 03:19:48 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:54950 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbgG1HTs (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 28 Jul 2020 03:19:48 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k0Jtp-0006XK-DW; Tue, 28 Jul 2020 17:19:46 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 28 Jul 2020 17:19:45 +1000
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Tue, 28 Jul 2020 17:19:45 +1000
Subject: [v3 PATCH 29/31] crypto: ccree - Set final_chunksize on essiv
References: <20200728071746.GA22352@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Message-Id: <E1k0Jtp-0006XK-DW@fornost.hmeau.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The ccree essiv implementation does not support partial operation
and therefore this patch sets its final_chunksize to -1 to mark this
fact.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 drivers/crypto/ccree/cc_cipher.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_cipher.c
index 83567b60d6908..a380391b2186a 100644
--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -1067,6 +1067,7 @@ static const struct cc_alg_template skcipher_algs[] = {
 			.min_keysize = CC_HW_KEY_SIZE,
 			.max_keysize = CC_HW_KEY_SIZE,
 			.ivsize = AES_BLOCK_SIZE,
+			.final_chunksize = -1,
 			},
 		.cipher_mode = DRV_CIPHER_ESSIV,
 		.flow_mode = S_DIN_to_AES,
@@ -1198,6 +1199,7 @@ static const struct cc_alg_template skcipher_algs[] = {
 			.min_keysize = AES_MIN_KEY_SIZE,
 			.max_keysize = AES_MAX_KEY_SIZE,
 			.ivsize = AES_BLOCK_SIZE,
+			.final_chunksize = -1,
 			},
 		.cipher_mode = DRV_CIPHER_ESSIV,
 		.flow_mode = S_DIN_to_AES,

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1062303E3
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Jul 2020 09:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgG1HTq (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 28 Jul 2020 03:19:46 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:54942 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbgG1HTq (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 28 Jul 2020 03:19:46 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k0Jtn-0006Wn-1L; Tue, 28 Jul 2020 17:19:44 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 28 Jul 2020 17:19:43 +1000
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Tue, 28 Jul 2020 17:19:43 +1000
Subject: [v3 PATCH 28/31] crypto: arm64/essiv - Set final_chunksize
References: <20200728071746.GA22352@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Message-Id: <E1k0Jtn-0006Wn-1L@fornost.hmeau.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The arm64 essiv implementation does not support partial operation
and therefore this patch sets its final_chunksize to -1 to mark this
fact.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 arch/arm64/crypto/aes-glue.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/crypto/aes-glue.c b/arch/arm64/crypto/aes-glue.c
index f63feb00e354d..a0ac7bf070d53 100644
--- a/arch/arm64/crypto/aes-glue.c
+++ b/arch/arm64/crypto/aes-glue.c
@@ -769,6 +769,7 @@ static struct skcipher_alg aes_algs[] = { {
 	.min_keysize	= AES_MIN_KEY_SIZE,
 	.max_keysize	= AES_MAX_KEY_SIZE,
 	.ivsize		= AES_BLOCK_SIZE,
+	.final_chunksize = -1,
 	.setkey		= essiv_cbc_set_key,
 	.encrypt	= essiv_cbc_encrypt,
 	.decrypt	= essiv_cbc_decrypt,

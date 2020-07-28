Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25B42303D7
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Jul 2020 09:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgG1HTS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 28 Jul 2020 03:19:18 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:54846 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbgG1HTR (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 28 Jul 2020 03:19:17 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k0JtK-0006QL-VA; Tue, 28 Jul 2020 17:19:16 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 28 Jul 2020 17:19:14 +1000
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Tue, 28 Jul 2020 17:19:14 +1000
Subject: [v3 PATCH 16/31] crypto: caam/qi2 - Set final_chunksize on chacha
References: <20200728071746.GA22352@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Message-Id: <E1k0JtK-0006QL-VA@fornost.hmeau.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The chacha implementation in caam/qi2 does not support partial
operation and therefore this patch sets its final_chunksize to -1
to mark this fact.

This patch also sets the chunksize to the chacha block size.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 drivers/crypto/caam/caamalg_qi2.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 1b0c286759065..6294c104bf7a9 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -1689,6 +1689,8 @@ static struct caam_skcipher_alg driver_algs[] = {
 			.min_keysize = CHACHA_KEY_SIZE,
 			.max_keysize = CHACHA_KEY_SIZE,
 			.ivsize = CHACHA_IV_SIZE,
+			.chunksize = CHACHA_BLOCK_SIZE,
+			.final_chunksize = -1,
 		},
 		.caam.class1_alg_type = OP_ALG_ALGSEL_CHACHA20,
 	},

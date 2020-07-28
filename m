Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704282303E2
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Jul 2020 09:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgG1HTn (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 28 Jul 2020 03:19:43 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:54934 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbgG1HTn (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 28 Jul 2020 03:19:43 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k0Jtk-0006WG-Oz; Tue, 28 Jul 2020 17:19:41 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 28 Jul 2020 17:19:40 +1000
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Tue, 28 Jul 2020 17:19:40 +1000
Subject: [v3 PATCH 27/31] crypto: simd - Add support for chaining
References: <20200728071746.GA22352@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Message-Id: <E1k0Jtk-0006WG-Oz@fornost.hmeau.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch sets the simd final chunk size from its child skcipher.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 crypto/simd.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/simd.c b/crypto/simd.c
index edaa479a1ec5e..260c26ad92fdf 100644
--- a/crypto/simd.c
+++ b/crypto/simd.c
@@ -181,6 +181,7 @@ struct simd_skcipher_alg *simd_skcipher_create_compat(const char *algname,
 
 	alg->ivsize = ialg->ivsize;
 	alg->chunksize = ialg->chunksize;
+	alg->final_chunksize = ialg->final_chunksize;
 	alg->min_keysize = ialg->min_keysize;
 	alg->max_keysize = ialg->max_keysize;
 

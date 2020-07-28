Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2502303E5
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Jul 2020 09:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgG1HTu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 28 Jul 2020 03:19:50 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:54956 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbgG1HTu (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 28 Jul 2020 03:19:50 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k0Jtr-0006Xr-RA; Tue, 28 Jul 2020 17:19:48 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 28 Jul 2020 17:19:47 +1000
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Tue, 28 Jul 2020 17:19:47 +1000
Subject: [v3 PATCH 30/31] crypto: kw - Set final_chunksize
References: <20200728071746.GA22352@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Message-Id: <E1k0Jtr-0006Xr-RA@fornost.hmeau.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The kw algorithm does not support partial operation and therefore
this patch sets its final_chunksize to -1 to mark this fact.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 crypto/keywrap.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/keywrap.c b/crypto/keywrap.c
index 0355cce21b1e2..b99568c6d032c 100644
--- a/crypto/keywrap.c
+++ b/crypto/keywrap.c
@@ -280,6 +280,7 @@ static int crypto_kw_create(struct crypto_template *tmpl, struct rtattr **tb)
 	inst->alg.base.cra_blocksize = SEMIBSIZE;
 	inst->alg.base.cra_alignmask = 0;
 	inst->alg.ivsize = SEMIBSIZE;
+	inst->alg.final_chunksize = -1;
 
 	inst->alg.encrypt = crypto_kw_encrypt;
 	inst->alg.decrypt = crypto_kw_decrypt;

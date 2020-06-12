Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77901F77AA
	for <lists+linux-crypto@lfdr.de>; Fri, 12 Jun 2020 14:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgFLMGu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 12 Jun 2020 08:06:50 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:39478 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbgFLMGu (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 12 Jun 2020 08:06:50 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jjiSJ-00059o-Fc; Fri, 12 Jun 2020 22:06:44 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 Jun 2020 22:06:43 +1000
Date:   Fri, 12 Jun 2020 22:06:43 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Stephan Mueller <smueller@chronox.de>
Subject: [PATCH 0/3] crypto: skcipher - Add support for no chaining and
 partial chaining
Message-ID: <20200612120643.GA15724@gondor.apana.org.au>
References: <CAMj1kXGkvLP1YnDimdLOM6xMXSQKXPKCEBGRCGBRsWKAQR5Stg@mail.gmail.com>
 <20200529080508.GA2880@gondor.apana.org.au>
 <CAMj1kXE43VvEXyYQF=s5HybhF6Wq23wDTrvTfNV9d4fUVZZ8aw@mail.gmail.com>
 <20200529115126.GA3573@gondor.apana.org.au>
 <CAMj1kXFFPKWwwSpLnPmNa_Up1syMb7T5STG7Tw8mRuRqSzc9vw@mail.gmail.com>
 <20200529120216.GA3752@gondor.apana.org.au>
 <CAMj1kXF2-jJ6yGh9m759V2858_c45txoUBgKirvR-4z4GOHUfQ@mail.gmail.com>
 <20200529131953.GA9187@gondor.apana.org.au>
 <CAMj1kXHnQhLWUC_dPeuscEutOZPGzW4ZGaqphT2mSExmfChtsg@mail.gmail.com>
 <20200529134215.GA9458@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529134215.GA9458@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch-set adds support to the Crypto API and algif_skcipher
for algorithms that cannot be chained, as well as ones that can
be chained if you withhold a certain number of blocks at the end.

It only modifies one algorithm to utilise this, namely cts-generic.
Changing others should be fairly straightforward.  In particular,
we should mark all the ones that don't support chaining (e.g., most
stream ciphers).

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

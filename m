Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5104C1F77D6
	for <lists+linux-crypto@lfdr.de>; Fri, 12 Jun 2020 14:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgFLMVJ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 12 Jun 2020 08:21:09 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:39522 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgFLMVJ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 12 Jun 2020 08:21:09 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jjigE-0005P8-3M; Fri, 12 Jun 2020 22:21:07 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 Jun 2020 22:21:06 +1000
Date:   Fri, 12 Jun 2020 22:21:06 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephan Mueller <smueller@chronox.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [v2 PATCH 0/3] crypto: skcipher - Add support for no chaining and
 partial chaining
Message-ID: <20200612122105.GA18892@gondor.apana.org.au>
References: <20200612120643.GA15724@gondor.apana.org.au>
 <E1jjiTA-0005BO-9n@fornost.hmeau.com>
 <1688262.LSb4nGpegl@tauon.chronox.de>
 <20200612121651.GA15849@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612121651.GA15849@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

v2

Fixed return type of crypto_skcipher_fcsize.

--

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

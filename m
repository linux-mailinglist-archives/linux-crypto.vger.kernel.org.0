Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2645A30D86C
	for <lists+linux-crypto@lfdr.de>; Wed,  3 Feb 2021 12:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbhBCLUn (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 3 Feb 2021 06:20:43 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:48546 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234052AbhBCLUl (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 3 Feb 2021 06:20:41 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l7GCO-0002IK-OO; Wed, 03 Feb 2021 22:19:53 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 03 Feb 2021 22:19:52 +1100
Date:   Wed, 3 Feb 2021 22:19:52 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH 0/9] crypto: fix alignmask handling
Message-ID: <20210203111952.GA3285@gondor.apana.org.au>
References: <20210201180237.3171-1-ardb@kernel.org>
 <YBnQF3KU9Y5YKSmp@gmail.com>
 <CAMj1kXGh0RgK79QWO_VVHKWJiL_50UuXtxHD=nm+pEPDmwzSAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGh0RgK79QWO_VVHKWJiL_50UuXtxHD=nm+pEPDmwzSAw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Feb 03, 2021 at 10:37:10AM +0100, Ard Biesheuvel wrote:
>
> One thing that became apparent to me while looking into this stuff is
> that the skcipher encrypt/decrypt API ignores alignmasks altogether,
> so this is something we should probably look into at some point, i.e.,
> whether the alignmask handling in the core API is still worth it, and
> if it is, make skcipher calls honour them.
> 
> In the ablkcipher->skcipher conversion I did, I was not aware of this,
> but I don't remember seeing any issues being reported in this area
> either, so I wonder how many cases actually exist where alignmasks
> actually matter.

What do you mean? With both ablkcipher/skcipher the alignmask was
usually enforced through the walker mechanism.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

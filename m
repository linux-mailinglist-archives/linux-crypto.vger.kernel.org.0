Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA152310EB
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Jul 2020 19:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbgG1RaP (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 28 Jul 2020 13:30:15 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:56292 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731912AbgG1RaP (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 28 Jul 2020 13:30:15 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k0TQX-0001qD-PF; Wed, 29 Jul 2020 03:30:10 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 29 Jul 2020 03:30:09 +1000
Date:   Wed, 29 Jul 2020 03:30:09 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [v3 PATCH 1/31] crypto: skcipher - Add final chunk size field
 for chaining
Message-ID: <20200728173009.GA3620@gondor.apana.org.au>
References: <20200728071746.GA22352@gondor.apana.org.au>
 <E1k0Jsl-0006Ho-Gf@fornost.hmeau.com>
 <20200728171512.GB4053562@gmail.com>
 <20200728172239.GA3539@gondor.apana.org.au>
 <CAMj1kXEGPFeqW2LYCAPHBkR_ruUTnV7AbX7yHgytkRoTfj5Msw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEGPFeqW2LYCAPHBkR_ruUTnV7AbX7yHgytkRoTfj5Msw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jul 28, 2020 at 08:26:38PM +0300, Ard Biesheuvel wrote:
>
> So how does one allocate a tfm that supports chaining if their use
> case requires it? Having different implementations of the same algo
> where one does support it while the other one doesn't means we will
> need some flag to request this at alloc time.

Yes we could add a flag for it.  However, for the two users that
I'm looking at right now (algif_skcipher and sunrpc) this is not
required.  For algif_skcipher it'll simply fall back to the current
behaviour if chaining is not supported, while sunrpc would only
use chaining with cts where it is always supported.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

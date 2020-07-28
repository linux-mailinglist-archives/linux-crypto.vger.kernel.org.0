Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE833230933
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Jul 2020 13:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgG1Lx4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 28 Jul 2020 07:53:56 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55528 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbgG1Lx4 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 28 Jul 2020 07:53:56 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k0OB6-00036O-0H; Tue, 28 Jul 2020 21:53:53 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 28 Jul 2020 21:53:51 +1000
Date:   Tue, 28 Jul 2020 21:53:51 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Stephan Mueller <smueller@chronox.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [v3 PATCH 3/31] crypto: cts - Add support for chaining
Message-ID: <20200728115351.GA30933@gondor.apana.org.au>
References: <20200728071746.GA22352@gondor.apana.org.au>
 <E1k0Jsq-0006I8-1l@fornost.hmeau.com>
 <CAMj1kXHoKQhMjHxsGk55xEu+FF87Bu2CGqFWPcp-G6RLUFFAHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHoKQhMjHxsGk55xEu+FF87Bu2CGqFWPcp-G6RLUFFAHg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jul 28, 2020 at 02:05:58PM +0300, Ard Biesheuvel wrote:
>
> But isn't the final chunksize a function of cryptlen? What happens if
> i try to use cts(cbc(aes)) to encrypt 16 bytes with the MORE flag, and
> <16 additional bytes as the final chunk?

The final chunksize is an attribute that the caller has to act on.
So for cts it tells the caller that it must withhold at least two
blocks (32 bytes) of data unless it is the final chunk.

Of course the implementation should not crash when given malformed
input like the ones you suggested but the content of the output will
be undefined.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

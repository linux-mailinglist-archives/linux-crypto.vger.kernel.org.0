Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BE523098A
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Jul 2020 14:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgG1MD4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 28 Jul 2020 08:03:56 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55538 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728560AbgG1MD4 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 28 Jul 2020 08:03:56 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k0OKn-0003Ni-1p; Tue, 28 Jul 2020 22:03:54 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 28 Jul 2020 22:03:53 +1000
Date:   Tue, 28 Jul 2020 22:03:53 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Stephan Mueller <smueller@chronox.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [v3 PATCH 3/31] crypto: cts - Add support for chaining
Message-ID: <20200728120352.GA31012@gondor.apana.org.au>
References: <20200728071746.GA22352@gondor.apana.org.au>
 <E1k0Jsq-0006I8-1l@fornost.hmeau.com>
 <CAMj1kXHoKQhMjHxsGk55xEu+FF87Bu2CGqFWPcp-G6RLUFFAHg@mail.gmail.com>
 <20200728115351.GA30933@gondor.apana.org.au>
 <CAMj1kXGuOiWmctpCak0beMONGAjbW=QG8tLMi+=9pTxbgX0nWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGuOiWmctpCak0beMONGAjbW=QG8tLMi+=9pTxbgX0nWQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jul 28, 2020 at 02:59:24PM +0300, Ard Biesheuvel wrote:
>
> How is it malformed? Between 16 and 31 bytes of input is perfectly
> valid for cts(cbc(aes)), and splitting it up after the first chunk
> should be as well, no?

This is the whole point of final_chunksize.  If you're going to
do chaining then you must always withhold at least final_chunksize
bytes until you're at the final chunk.

If you disobey that then you get undefined results.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

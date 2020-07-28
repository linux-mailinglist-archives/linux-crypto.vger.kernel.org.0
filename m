Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99892309D6
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Jul 2020 14:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbgG1MTu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 28 Jul 2020 08:19:50 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55560 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728825AbgG1MTu (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 28 Jul 2020 08:19:50 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k0OaA-0003jU-M3; Tue, 28 Jul 2020 22:19:47 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 28 Jul 2020 22:19:46 +1000
Date:   Tue, 28 Jul 2020 22:19:46 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Stephan Mueller <smueller@chronox.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [v3 PATCH 3/31] crypto: cts - Add support for chaining
Message-ID: <20200728121946.GA31104@gondor.apana.org.au>
References: <20200728071746.GA22352@gondor.apana.org.au>
 <E1k0Jsq-0006I8-1l@fornost.hmeau.com>
 <CAMj1kXHoKQhMjHxsGk55xEu+FF87Bu2CGqFWPcp-G6RLUFFAHg@mail.gmail.com>
 <20200728115351.GA30933@gondor.apana.org.au>
 <CAMj1kXGuOiWmctpCak0beMONGAjbW=QG8tLMi+=9pTxbgX0nWQ@mail.gmail.com>
 <20200728120352.GA31012@gondor.apana.org.au>
 <CAMj1kXE-nZ9R0ObyWgRtkGoNSz7vE=KuT8+0LwYnvPEo9MpO-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE-nZ9R0ObyWgRtkGoNSz7vE=KuT8+0LwYnvPEo9MpO-w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jul 28, 2020 at 03:08:58PM +0300, Ard Biesheuvel wrote:
>
> So the contract is that using CRYPTO_TFM_REQ_MORE is only permitted if
> you take the final chunksize into account. If you don't use that flag,
> you can ignore it.

Right.

I think at least sunrpc could use this right away.  We could extend
this to algif_aead too but I wouldn't worry about it unless a real
in-kernel user like sunrpc also showed up.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

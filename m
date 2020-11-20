Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2AB2BA716
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Nov 2020 11:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgKTKJj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Nov 2020 05:09:39 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:35300 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbgKTKJj (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Nov 2020 05:09:39 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kg3MG-00042J-Nk; Fri, 20 Nov 2020 21:09:37 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Nov 2020 21:09:36 +1100
Date:   Fri, 20 Nov 2020 21:09:36 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 2/3] crypto: tcrypt - permit tcrypt.ko to be builtin
Message-ID: <20201120100936.GA22225@gondor.apana.org.au>
References: <20201109083143.2884-1-ardb@kernel.org>
 <20201109083143.2884-3-ardb@kernel.org>
 <20201120034440.GA18047@gondor.apana.org.au>
 <CAMj1kXFd1ab2uLbQ7UvL7_+ObLGbfh=p3aRm3GhAvH0tcOYQ5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFd1ab2uLbQ7UvL7_+ObLGbfh=p3aRm3GhAvH0tcOYQ5g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Nov 20, 2020 at 10:24:44AM +0100, Ard Biesheuvel wrote:
>
> OK, I'll apply this on top
> 
> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index 9ff2d687e334..959ee48f66a8 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -202,7 +202,7 @@ config CRYPTO_AUTHENC
>  config CRYPTO_TEST
>         tristate "Testing module"
>         depends on m || CRYPTO_MANAGER_EXTRA_TESTS
> -       select CRYPTO_MANAGER
> +       depends on CRYPTO_MANAGER

How about just removing the depends line altogether?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

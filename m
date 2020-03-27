Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1570C195033
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Mar 2020 05:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgC0Ezu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 27 Mar 2020 00:55:50 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:57082 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgC0Ezu (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 27 Mar 2020 00:55:50 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jHh20-0000Ej-Aa; Fri, 27 Mar 2020 15:55:45 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Mar 2020 15:55:44 +1100
Date:   Fri, 27 Mar 2020 15:55:44 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH crypto] crypto: arm[64]/poly1305 - add artifact to
 .gitignore files
Message-ID: <20200327045543.GA19982@gondor.apana.org.au>
References: <20200319180114.6437-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319180114.6437-1-Jason@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Mar 19, 2020 at 12:01:14PM -0600, Jason A. Donenfeld wrote:
> The .S_shipped yields a .S, and the pattern in these directories is to
> add that to .gitignore so that git-status doesn't raise a fuss.
> 
> Fixes: a6b803b3ddc7 ("crypto: arm/poly1305 - incorporate OpenSSL/CRYPTOGAMS NEON implementation")
> Fixes: f569ca164751 ("crypto: arm64/poly1305 - incorporate OpenSSL/CRYPTOGAMS NEON implementation")
> Reported-by: Emil Renner Berthing <kernel@esmil.dk>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/arm/crypto/.gitignore   | 1 +
>  arch/arm64/crypto/.gitignore | 1 +
>  2 files changed, 2 insertions(+)

Patch applied.

> diff --git a/arch/arm64/crypto/.gitignore b/arch/arm64/crypto/.gitignore
> index 879df8781ed5..e403b1343328 100644
> --- a/arch/arm64/crypto/.gitignore
> +++ b/arch/arm64/crypto/.gitignore
> @@ -1,2 +1,3 @@
>  sha256-core.S
>  sha512-core.S
> +poly1305-core.S

This didn't apply because a similar patch had already been added
to cryptodev a month ago.  Please base your patches on the latest
cryptodev in future.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

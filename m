Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D8E3F9639
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Aug 2021 10:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbhH0Ifz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 27 Aug 2021 04:35:55 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:54408 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231940AbhH0Ify (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 27 Aug 2021 04:35:54 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mJXKI-0007YN-AV; Fri, 27 Aug 2021 16:35:02 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mJXKG-0005cL-62; Fri, 27 Aug 2021 16:35:00 +0800
Date:   Fri, 27 Aug 2021 16:35:00 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: remove rmd320 in Makefile
Message-ID: <20210827083500.GA21571@gondor.apana.org.au>
References: <20210816124433.10411-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816124433.10411-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Aug 16, 2021 at 02:44:33PM +0200, Lukas Bulwahn wrote:
> Commit 93f64202926f ("crypto: rmd320 - remove RIPE-MD 320 hash algorithm")
> removes the Kconfig and code, but misses to adjust the Makefile.
> 
> Hence, ./scripts/checkkconfigsymbols.py warns:
> 
> CRYPTO_RMD320
> Referencing files: crypto/Makefile
> 
> Remove the missing piece of this code removal.
> 
> Fixes: 93f64202926f ("crypto: rmd320 - remove RIPE-MD 320 hash algorithm")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  crypto/Makefile | 1 -
>  1 file changed, 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

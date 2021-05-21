Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B967938C074
	for <lists+linux-crypto@lfdr.de>; Fri, 21 May 2021 09:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbhEUHMO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 21 May 2021 03:12:14 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55478 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235491AbhEUHMO (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 21 May 2021 03:12:14 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1ljzJ0-0003uS-AR; Fri, 21 May 2021 15:10:46 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ljzJ0-0005l5-7D; Fri, 21 May 2021 15:10:46 +0800
Date:   Fri, 21 May 2021 15:10:46 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Matt Mackall <mpm@selenic.com>,
        Deepak Saxena <dsaxena@plexity.net>,
        linux-crypto@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/5] hw_random: ixp4xx: Use SPDX license tag
Message-ID: <20210521071046.krjgxjmy3xrs3zwm@gondor.apana.org.au>
References: <20210511132928.814697-1-linus.walleij@linaro.org>
 <20210511132928.814697-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511132928.814697-2-linus.walleij@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, May 11, 2021 at 03:29:25PM +0200, Linus Walleij wrote:
> This switches the IXP4xx hardware random driver to use
> the SPDX type license tag.
> 
> Cc: Deepak Saxena <dsaxena@plexity.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> The idea is to apply this through the ARM SoC tree along
> with other IXP4xx refactorings.
> Please tell me if you prefer another solution.
> ---
>  drivers/char/hw_random/ixp4xx-rng.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

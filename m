Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3383B57E1
	for <lists+linux-crypto@lfdr.de>; Mon, 28 Jun 2021 05:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhF1Des (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 27 Jun 2021 23:34:48 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51018 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231933AbhF1Der (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 27 Jun 2021 23:34:47 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lxi0N-0001tZ-5x; Mon, 28 Jun 2021 11:32:15 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lxi0G-0002oI-TC; Mon, 28 Jun 2021 11:32:08 +0800
Date:   Mon, 28 Jun 2021 11:32:08 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        "David S . Miller" <davem@davemloft.net>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 1/2] crypto: Typo s/Stormlink/Storlink/
Message-ID: <20210628033208.GC10694@gondor.apana.org.au>
References: <20210625132724.1165706-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625132724.1165706-1-geert@linux-m68k.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jun 25, 2021 at 03:27:23PM +0200, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> According to Documentation/devicetree/bindings/arm/gemini.txt, the
> company was originally named "Storlink Semiconductor", and later renamed
> to "Storm Semiconductor".
> 
> Fixes: 46c5338db7bd45b2 ("crypto: sl3516 - Add sl3516 crypto engine")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/crypto/Kconfig                   | 2 +-
>  drivers/crypto/gemini/sl3516-ce-cipher.c | 2 +-
>  drivers/crypto/gemini/sl3516-ce-core.c   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

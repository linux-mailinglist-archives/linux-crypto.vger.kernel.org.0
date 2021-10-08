Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1837426AA6
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Oct 2021 14:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhJHM0W (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 Oct 2021 08:26:22 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55920 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241199AbhJHM0W (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 8 Oct 2021 08:26:22 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mYovH-0003dn-28; Fri, 08 Oct 2021 20:24:23 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mYovD-00086s-P6; Fri, 08 Oct 2021 20:24:19 +0800
Date:   Fri, 8 Oct 2021 20:24:19 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Markus Schneider-Pargmann <msp@baylibre.com>
Cc:     Sean Wang <sean.wang@mediatek.com>, Matt Mackall <mpm@selenic.com>,
        linux-mediatek@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] hwrng: mediatek - Force runtime pm ops for sleep ops
Message-ID: <20211008122419.GE31060@gondor.apana.org.au>
References: <20210930191242.2542315-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930191242.2542315-1-msp@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Sep 30, 2021 at 09:12:42PM +0200, Markus Schneider-Pargmann wrote:
> Currently mtk_rng_runtime_suspend/resume is called for both runtime pm
> and system sleep operations.
> 
> This is wrong as these should only be runtime ops as the name already
> suggests. Currently freezing the system will lead to a call to
> mtk_rng_runtime_suspend even if the device currently isn't active. This
> leads to a clock warning because it is disabled/unprepared although it
> isn't enabled/prepared currently.
> 
> This patch fixes this by only setting the runtime pm ops and forces to
> call the runtime pm ops from the system sleep ops as well if active but
> not otherwise.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  drivers/char/hw_random/mtk-rng.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

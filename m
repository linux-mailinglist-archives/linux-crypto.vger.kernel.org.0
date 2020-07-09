Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D294321A04B
	for <lists+linux-crypto@lfdr.de>; Thu,  9 Jul 2020 14:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgGIMy3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 9 Jul 2020 08:54:29 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:36132 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgGIMy2 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 9 Jul 2020 08:54:28 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jtW3t-0003wI-Qc; Thu, 09 Jul 2020 22:54:03 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 09 Jul 2020 22:54:01 +1000
Date:   Thu, 9 Jul 2020 22:54:01 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Olivier Sobrie <olivier.sobrie@silexinsight.com>,
        Waleed Ziad <waleed94ziad@gmail.com>,
        Matt Mackall <mpm@selenic.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwrng: ba431 - HW_RANDOM_BA431 should not default to y
Message-ID: <20200709125401.GC31057@gondor.apana.org.au>
References: <20200630133941.28696-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630133941.28696-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jun 30, 2020 at 03:39:41PM +0200, Geert Uytterhoeven wrote:
> As HW_RANDOM_BA431 does not have any platform dependency, it should not
> default to enabled.
> 
> Fixes: 0289e9be5dc26d84 ("hwrng: ba431 - add support for BA431 hwrng")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/char/hw_random/Kconfig | 3 ---
>  1 file changed, 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

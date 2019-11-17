Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED951FF636
	for <lists+linux-crypto@lfdr.de>; Sun, 17 Nov 2019 01:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfKQAmk (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 16 Nov 2019 19:42:40 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57150 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbfKQAmk (ORCPT <rfc822;linux-crypto@vger.kernel.orG>);
        Sat, 16 Nov 2019 19:42:40 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iW8eB-0003Ix-F5; Sun, 17 Nov 2019 08:42:35 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iW8e5-0002Xc-Ho; Sun, 17 Nov 2019 08:42:29 +0800
Date:   Sun, 17 Nov 2019 08:42:29 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Matt Mackall <mpm@selenic.com>,
        Vitaly Andrianov <vitalya@ti.com>
Subject: Re: [PATCH] hwrng: ks-sa: Add minimum sleep time before ready-polling
Message-ID: <20191117004229.xrkvij6vcd3aodnx@gondor.apana.org.au>
References: <20191106093019.117233-1-alexander.sverdlin@nokia.com>
 <20191115060610.2sjw7stopxr73jhn@gondor.apana.org.au>
 <20191116073229.GA161720@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191116073229.GA161720@sol.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Nov 15, 2019 at 11:32:29PM -0800, Eric Biggers wrote:
>
> This is causing a build error.  Seems that a line of the patch in
> ks_sa_rng_init() went missing when it was applied...?
> 
> drivers/char/hw_random/ks-sa-rng.c: In function 'ks_sa_rng_init':
> drivers/char/hw_random/ks-sa-rng.c:146:47: error: 'clk_rate' undeclared (first use in this function)
>   146 |  ks_sa_rng->refill_delay_ns = refill_delay_ns(clk_rate);
>       |                                               ^~~~~~~~
> drivers/char/hw_random/ks-sa-rng.c:146:47: note: each undeclared identifier is reported only once for each function it appears in

Sorry, I missed that line when applying this patch byhand as it
conflicted with another change.

It should be fixed now.  I'll also enable COMPILE_TEST on this
driver.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

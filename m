Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFE5AD4F8B
	for <lists+linux-crypto@lfdr.de>; Sat, 12 Oct 2019 14:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbfJLMJp (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 12 Oct 2019 08:09:45 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:46660 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfJLMJo (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 12 Oct 2019 08:09:44 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iJGDE-0001Ae-Q3; Sat, 12 Oct 2019 23:09:34 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 12 Oct 2019 23:09:28 +1100
Date:   Sat, 12 Oct 2019 23:09:28 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Matt Mackall <mpm@selenic.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-crypto@vger.kernel.org,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH v2] hwrng: core - move add_early_randomness() out of
 rng_mutex
Message-ID: <20191012120928.GA24544@gondor.apana.org.au>
References: <20191011134724.28651-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011134724.28651-1-lvivier@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Oct 11, 2019 at 03:47:24PM +0200, Laurent Vivier wrote:
> add_early_randomness() is called every time a new rng backend is added
> and every time it is set as the current rng provider.
> 
> add_early_randomness() is called from functions locking rng_mutex,
> and if it hangs all the hw_random framework hangs: we can't read sysfs,
> add or remove a backend.
> 
> This patch moves add_early_randomness() out of the rng_mutex zone.
> It only needs the reading_mutex.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
> 
> Notes:
>     v2: in hwrng_register, take rng->ref only if rng is the new current_rng
> 
>  drivers/char/hw_random/core.c | 61 +++++++++++++++++++++++++----------
>  1 file changed, 44 insertions(+), 17 deletions(-)

Please rebase your patch on top of the cryptodev tree, i.e., make
this an incremental patch with a Fixes header.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD09CCBD0D
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Oct 2019 16:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbfJDO0L (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Oct 2019 10:26:11 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42150 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727587AbfJDO0L (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Oct 2019 10:26:11 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iGOX0-00075c-PG; Sat, 05 Oct 2019 00:26:07 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 05 Oct 2019 00:26:03 +1000
Date:   Sat, 5 Oct 2019 00:26:03 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] hw_random: move add_early_randomness() out of rng_mutex
Message-ID: <20191004142603.GA29787@gondor.apana.org.au>
References: <20190912133022.14870-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912133022.14870-1-lvivier@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Sep 12, 2019 at 03:30:22PM +0200, Laurent Vivier wrote:
>
> @@ -496,19 +510,24 @@ int hwrng_register(struct hwrng *rng)
>  			goto out_unlock;
>  	}
>  
> -	if (old_rng && !rng->init) {
> +	new_rng = rng;
> +	kref_get(&new_rng->ref);
> +out_unlock:
> +	mutex_unlock(&rng_mutex);
> +
> +	if (new_rng) {
> +		if (new_rng != old_rng || !rng->init) {

Is this really supposed to be || instead of &&?

>  		/*
>  		 * Use a new device's input to add some randomness to
>  		 * the system.  If this rng device isn't going to be
>  		 * used right away, its init function hasn't been
> -		 * called yet; so only use the randomness from devices
> -		 * that don't need an init callback.
> +		 * called yet by set_current_rng(); so only use the
> +		 * randomness from devices that don't need an init callback
>  		 */
> -		add_early_randomness(rng);
> +			add_early_randomness(new_rng);
> +		}
> +		put_rng(new_rng);
>  	}

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

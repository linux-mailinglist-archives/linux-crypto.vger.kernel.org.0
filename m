Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0211AB7CC
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Apr 2020 08:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407520AbgDPGPl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Apr 2020 02:15:41 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:41216 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407264AbgDPGPi (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Apr 2020 02:15:38 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jOxo9-0004bg-UH; Thu, 16 Apr 2020 16:15:31 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 16 Apr 2020 16:15:29 +1000
Date:   Thu, 16 Apr 2020 16:15:29 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH 1/2] crypto: Jitter RNG SP800-90B compliance
Message-ID: <20200416061529.GB19267@gondor.apana.org.au>
References: <16276478.9hrKPGv45q@positron.chronox.de>
 <4128830.EzT7ouGoCQ@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4128830.EzT7ouGoCQ@positron.chronox.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Apr 11, 2020 at 09:35:03PM +0200, Stephan M�ller wrote:
>
> @@ -142,7 +143,47 @@ static int jent_kcapi_random(struct crypto_rng *tfm,
>  	int ret = 0;
>  
>  	spin_lock(&rng->jent_lock);
> +
> +	/* Return a permanent error in case we had too many resets in a row. */
> +	if (rng->reset_cnt > (1<<10)) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
>  	ret = jent_read_entropy(rng->entropy_collector, rdata, dlen);
> +
> +	/* Reset RNG in case of health failures */
> +	if (ret < -1) {
> +		pr_warn_ratelimited("Reset Jitter RNG due to health test failure: %s failure\n",
> +				    (ret == -2) ? "Repetition Count Test" :
> +						  "Adaptive Proportion Test");
> +
> +		rng->reset_cnt++;
> +
> +		ret = jent_entropy_init();
> +		if (ret) {
> +			pr_warn_ratelimited("Jitter RNG self-tests failed: %d\n",
> +					    ret);
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +		jent_entropy_collector_free(rng->entropy_collector);
> +		rng->entropy_collector = jent_entropy_collector_alloc(1, 0);

You can't do a GFP_KERNEL allocation inside spin-locks.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

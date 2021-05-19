Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6085B388CCC
	for <lists+linux-crypto@lfdr.de>; Wed, 19 May 2021 13:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350740AbhESLa4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 19 May 2021 07:30:56 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:54000 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350685AbhESLa4 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 19 May 2021 07:30:56 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1ljKOL-0002kJ-Op; Wed, 19 May 2021 19:29:33 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ljKOI-00076p-DX; Wed, 19 May 2021 19:29:30 +0800
Date:   Wed, 19 May 2021 19:29:30 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ebiggers@kernel.org, will@kernel.org, kernel-team@android.com
Subject: Re: [PATCH v4 2/7] crypto: aead - disallow en/decrypt for non-task
 or non-softirq context
Message-ID: <20210519112930.sgy3trqczyfok7mn@gondor.apana.org.au>
References: <20210519112239.33664-1-ardb@kernel.org>
 <20210519112239.33664-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519112239.33664-3-ardb@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, May 19, 2021 at 01:22:34PM +0200, Ard Biesheuvel wrote:
>
>  	crypto_stats_get(alg);
> -	if (crypto_aead_get_flags(aead) & CRYPTO_TFM_NEED_KEY)
> +	if (!(alg->cra_flags & CRYPTO_ALG_ASYNC) &&
> +	    WARN_ONCE(!in_task() && !in_serving_softirq(),
> +		      "synchronous call from invalid context\n"))
> +		ret = -EBUSY;

I don't think we've ever supported crypto in hard IRQ contexts.
So this should be done regardless of ASYNC.

Then again, do we really need this since the assumption has
always been that the crypto API can only be invoked in user or
softirq context?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

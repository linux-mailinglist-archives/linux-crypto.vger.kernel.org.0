Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95AA23109C
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Jul 2020 19:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731673AbgG1RLB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 28 Jul 2020 13:11:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731070AbgG1RLB (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 28 Jul 2020 13:11:01 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C70AA20792;
        Tue, 28 Jul 2020 17:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595956260;
        bh=9oxBzkq/ZEInOnc0uPmHumJaSd4D/57DBn/RH9M+6Hk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EQRKg/D4BACeVW3NqOfhky6tjofxHWFF2l0D/aSaLuqoYbqFsWIp8xuI8pmykoi/g
         DkZkDCz+hWGbaQVC+v0dof4M5np/MZmFTHb+MJiwibC2Y73miqxvnwo3Z+K9k//GlL
         z/klIids6Ejcv34JlAqvJD/Falb6eb+TUF/g4vYY=
Date:   Tue, 28 Jul 2020 10:10:59 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [v3 PATCH 8/31] crypto: skcipher - Initialise requests to zero
Message-ID: <20200728171059.GA4053562@gmail.com>
References: <20200728071746.GA22352@gondor.apana.org.au>
 <E1k0Jt1-0006LB-SV@fornost.hmeau.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1k0Jt1-0006LB-SV@fornost.hmeau.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jul 28, 2020 at 05:18:55PM +1000, Herbert Xu wrote:
> This patch initialises skcipher requests to zero.  This allows
> algorithms to distinguish between the first operation versus
> subsequent ones.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> ---
> 
>  include/crypto/skcipher.h |   18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/crypto/skcipher.h b/include/crypto/skcipher.h
> index c46ea1c157b29..6db5f83d6e482 100644
> --- a/include/crypto/skcipher.h
> +++ b/include/crypto/skcipher.h
> @@ -129,13 +129,14 @@ struct skcipher_alg {
>   * This performs a type-check against the "tfm" argument to make sure
>   * all users have the correct skcipher tfm for doing on-stack requests.
>   */
> -#define SYNC_SKCIPHER_REQUEST_ON_STACK(name, tfm) \
> -	char __##name##_desc[sizeof(struct skcipher_request) + \
> -			     MAX_SYNC_SKCIPHER_REQSIZE + \
> -			     (!(sizeof((struct crypto_sync_skcipher *)1 == \
> -				       (typeof(tfm))1))) \
> -			    ] CRYPTO_MINALIGN_ATTR; \
> -	struct skcipher_request *name = (void *)__##name##_desc
> +#define SYNC_SKCIPHER_REQUEST_ON_STACK(name, sync) \
> +	struct { \
> +		struct skcipher_request req; \
> +		char ext[MAX_SYNC_SKCIPHER_REQSIZE]; \
> +	} __##name##_desc = { \
> +		.req.base.tfm = crypto_skcipher_tfm(&sync->base), \
> +	}; \
> +	struct skcipher_request *name = &__##name##_desc.req
>  
>  /**
>   * DOC: Symmetric Key Cipher API
> @@ -519,8 +520,7 @@ static inline struct skcipher_request *skcipher_request_alloc(
>  {
>  	struct skcipher_request *req;
>  
> -	req = kmalloc(sizeof(struct skcipher_request) +
> -		      crypto_skcipher_reqsize(tfm), gfp);
> +	req = kzalloc(sizeof(*req) + crypto_skcipher_reqsize(tfm), gfp);
>  
>  	if (likely(req))
>  		skcipher_request_set_tfm(req, tfm);

Does this really work?  Some users allocate memory themselves without using
*_request_alloc().

- Eric

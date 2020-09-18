Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7223826F614
	for <lists+linux-crypto@lfdr.de>; Fri, 18 Sep 2020 08:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgIRGny (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 18 Sep 2020 02:43:54 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:57426 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbgIRGny (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 18 Sep 2020 02:43:54 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kJA7Y-0002Sf-Mv; Fri, 18 Sep 2020 16:43:49 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Sep 2020 16:43:48 +1000
Date:   Fri, 18 Sep 2020 16:43:48 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Elena Petrova <lenaptr@google.com>
Cc:     linux-crypto@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v8] crypto: af_alg - add extra parameters for DRBG
 interface
Message-ID: <20200918064348.GA9479@gondor.apana.org.au>
References: <20200909210017.GA1080156@gmail.com>
 <20200916110731.598437-1-lenaptr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916110731.598437-1-lenaptr@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Sep 16, 2020 at 12:07:31PM +0100, Elena Petrova wrote:
>
> @@ -148,20 +260,58 @@ static int rng_accept_parent(void *private, struct sock *sk)
>  	 * state of the RNG.
>  	 */
>  
> -	ctx->drng = private;
> +	ctx->drng = pctx->drng;
>  	ask->private = ctx;
>  	sk->sk_destruct = rng_sock_destruct;
>  
> +	/*
> +	 * Non NULL pctx->entropy means that CAVP test has been initiated on
> +	 * this socket, replace proto_ops algif_rng_ops with algif_rng_test_ops.
> +	 */
> +	if (pctx->entropy)
> +		sk->sk_socket->ops = &algif_rng_test_ops;
> +

Please make that

	if (IS_ENABLED(CONFIG_CRYPTO_USER_API_RNG_CAVP) && pctx->entropy)

so that this and the rest of the new code simply disappears when
the Kconfig option is off.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

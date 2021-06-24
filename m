Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688E23B315A
	for <lists+linux-crypto@lfdr.de>; Thu, 24 Jun 2021 16:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhFXOcn (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 24 Jun 2021 10:32:43 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50862 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230170AbhFXOcm (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 24 Jun 2021 10:32:42 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lwQN4-0005Ye-IP; Thu, 24 Jun 2021 22:30:22 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lwQN1-0005HE-Eo; Thu, 24 Jun 2021 22:30:19 +0800
Date:   Thu, 24 Jun 2021 22:30:19 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc:     linux-crypto@vger.kernel.org, Vlad Dronov <vdronov@redhat.com>
Subject: Re: [PATCH] crypto: DRBG - switch to HMAC SHA512 DRBG as default DRBG
Message-ID: <20210624143019.GA20222@gondor.apana.org.au>
References: <3171520.o5pSzXOnS6@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3171520.o5pSzXOnS6@positron.chronox.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, May 20, 2021 at 09:31:11PM +0200, Stephan M�ller wrote:
>
> diff --git a/crypto/drbg.c b/crypto/drbg.c
> index 1b4587e0ddad..ea85d4a0fe9e 100644
> --- a/crypto/drbg.c
> +++ b/crypto/drbg.c
> @@ -176,18 +176,18 @@ static const struct drbg_core drbg_cores[] = {
>  		.blocklen_bytes = 48,
>  		.cra_name = "hmac_sha384",
>  		.backend_cra_name = "hmac(sha384)",
> -	}, {
> -		.flags = DRBG_HMAC | DRBG_STRENGTH256,
> -		.statelen = 64, /* block length of cipher */
> -		.blocklen_bytes = 64,
> -		.cra_name = "hmac_sha512",
> -		.backend_cra_name = "hmac(sha512)",
>  	}, {
>  		.flags = DRBG_HMAC | DRBG_STRENGTH256,
>  		.statelen = 32, /* block length of cipher */
>  		.blocklen_bytes = 32,
>  		.cra_name = "hmac_sha256",
>  		.backend_cra_name = "hmac(sha256)",
> +	}, {
> +		.flags = DRBG_HMAC | DRBG_STRENGTH256,
> +		.statelen = 64, /* block length of cipher */
> +		.blocklen_bytes = 64,
> +		.cra_name = "hmac_sha512",
> +		.backend_cra_name = "hmac(sha512)",
>  	},

Hi Stephan:

I just noticed that unlike hmac(sha256) drbg with hmac(sha512)
doesn't have a self-test.  Could you add one for it please?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24EA1BEF2C
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Apr 2020 06:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgD3E3z (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 30 Apr 2020 00:29:55 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59834 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbgD3E3z (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 30 Apr 2020 00:29:55 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jU0oP-0004Ne-66; Thu, 30 Apr 2020 14:28:38 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 30 Apr 2020 14:29:28 +1000
Date:   Thu, 30 Apr 2020 14:29:28 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] crypto: acomp - search acomp with scomp backend in
 crypto_has_acomp
Message-ID: <20200430042928.GA13396@gondor.apana.org.au>
References: <20200430004732.24092-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430004732.24092-1-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Apr 30, 2020 at 12:47:32PM +1200, Barry Song wrote:
>
> diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
> index d873f999b334..a7170848e6c2 100644
> --- a/include/crypto/acompress.h
> +++ b/include/crypto/acompress.h
> @@ -156,7 +156,7 @@ static inline void crypto_free_acomp(struct crypto_acomp *tfm)
>  static inline int crypto_has_acomp(const char *alg_name, u32 type, u32 mask)
>  {
>  	type &= ~CRYPTO_ALG_TYPE_MASK;
> -	type |= CRYPTO_ALG_TYPE_ACOMPRESS;
> +	type |= CRYPTO_ALG_TYPE_ACOMPRESS | CRYPTO_ALG_TYPE_SCOMPRESS;
>  	mask |= CRYPTO_ALG_TYPE_MASK;

I don't think this does what you think it does.  To find both
ACOMP and SCOMP, you should keep the type as is, but change the
mask to CRYPTO_ALG_TYPE_ACOMPRESS_MASK.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

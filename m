Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7CDEE106F
	for <lists+linux-crypto@lfdr.de>; Wed, 23 Oct 2019 05:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731007AbfJWDQJ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 22 Oct 2019 23:16:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730197AbfJWDQJ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 22 Oct 2019 23:16:09 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D3F620659;
        Wed, 23 Oct 2019 03:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571800568;
        bh=S5xr00xPsIM7AFMKj51TUExkBUKKivn6/ydgOEOMNsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X/rRSp9zcyY4Bb0BlgDE7b+Zvt/d8zLzxfaE24YPxUqrAuOMWyXs9Y++rLB3r16PW
         EYooXWd8KDMe3HX1UBmrwH7kVdpPigL3exXVQZp+D/L3W8zxtcFti/Aqs9gGgytolg
         h+8QHP8a3ElXKPV3p26pDgake48sa3Eyr7uC+rvc=
Date:   Tue, 22 Oct 2019 20:16:06 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Martin Willi <martin@strongswan.org>,
        Rene van Dorst <opensource@vdorst.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v4 06/35] crypto: arm64/chacha - expose arm64 ChaCha
 routine as library function
Message-ID: <20191023031606.GE4278@sol.localdomain>
Mail-Followup-To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Martin Willi <martin@strongswan.org>,
        Rene van Dorst <opensource@vdorst.com>,
        David Sterba <dsterba@suse.com>
References: <20191017190932.1947-1-ard.biesheuvel@linaro.org>
 <20191017190932.1947-7-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017190932.1947-7-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Oct 17, 2019 at 09:09:03PM +0200, Ard Biesheuvel wrote:
> +void hchacha_block_arch(const u32 *state, u32 *stream, int nrounds)
> +{
> +	if (!static_branch_likely(&have_neon) || !crypto_simd_usable()) {
> +		hchacha_block_generic(state, stream, nrounds);
> +	} else {
> +		kernel_neon_begin();
> +		hchacha_block_neon(state, stream, nrounds);
> +		kernel_neon_end();
> +	}
> +}
> +EXPORT_SYMBOL(hchacha_block_arch);
[...]

> @@ -110,7 +145,7 @@ static int xchacha_neon(struct skcipher_request *req)
>  
>  	chacha_init_generic(state, ctx->key, req->iv);
>  
> -	if (crypto_simd_usable()) {
> +	if (static_branch_likely(&have_neon) && crypto_simd_usable()) {
>  		kernel_neon_begin();
>  		hchacha_block_neon(state, subctx.key, ctx->nrounds);
>  		kernel_neon_end();

Shouldn't xchacha_neon() call hchacha_block_arch(), rather than implement the
same logic itself?

- Eric

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D065586DE
	for <lists+linux-crypto@lfdr.de>; Thu, 27 Jun 2019 18:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfF0QTI (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 27 Jun 2019 12:19:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbfF0QTI (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 27 Jun 2019 12:19:08 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B7B820659;
        Thu, 27 Jun 2019 16:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561652347;
        bh=FPJJURDlaIY9x5Cexw4tp0OEfNXY2YEn5QMaxm6i/js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SjY/VKdIaAAM3FQkFxG2yOe9ViQDZEqhfFAl90rfMGhyOERpNyCUhidY2bJiZyI0i
         oXcsYMPWeyapxa0hZSwC5SghzI46DnPL2iTganzqKBQAYsCLweoNKIIKgbr8bsSxuZ
         q7zrH4aynt0cY1crXZl0JyGm9LPSxkC/tDKDtCL8=
Date:   Thu, 27 Jun 2019 09:19:06 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        horia.geanta@nxp.com
Subject: Re: [PATCH v2 11/30] crypto: hifn/des - switch to new verification
 routines
Message-ID: <20190627161906.GB686@sol.localdomain>
References: <20190627120314.7197-1-ard.biesheuvel@linaro.org>
 <20190627120314.7197-12-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627120314.7197-12-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jun 27, 2019 at 02:02:55PM +0200, Ard Biesheuvel wrote:
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/crypto/hifn_795x.c | 30 +++++---------------
>  1 file changed, 7 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/crypto/hifn_795x.c b/drivers/crypto/hifn_795x.c
> index d656be0a142b..000477e4a429 100644
> --- a/drivers/crypto/hifn_795x.c
> +++ b/drivers/crypto/hifn_795x.c
> @@ -30,7 +30,7 @@
>  #include <linux/ktime.h>
>  
>  #include <crypto/algapi.h>
> -#include <crypto/des.h>
> +#include <crypto/internal/des.h>
>  
>  static char hifn_pll_ref[sizeof("extNNN")] = "ext";
>  module_param_string(hifn_pll_ref, hifn_pll_ref, sizeof(hifn_pll_ref), 0444);
> @@ -1948,25 +1948,13 @@ static void hifn_flush(struct hifn_device *dev)
>  static int hifn_setkey(struct crypto_ablkcipher *cipher, const u8 *key,
>  		unsigned int len)
>  {
> -	struct crypto_tfm *tfm = crypto_ablkcipher_tfm(cipher);
>  	struct hifn_context *ctx = crypto_tfm_ctx(tfm);
>  	struct hifn_device *dev = ctx->dev;
> +	int err;

Also a build error here:

drivers/crypto/hifn_795x.c: In function 'hifn_setkey':
drivers/crypto/hifn_795x.c:1951:44: error: 'tfm' undeclared (first use in this function); did you mean 'tm'?
  struct hifn_context *ctx = crypto_tfm_ctx(tfm);
                                            ^~~
                                            tm
drivers/crypto/hifn_795x.c:1951:44: note: each undeclared identifier is reported only once for each function it appears in

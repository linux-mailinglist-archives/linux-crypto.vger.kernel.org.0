Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1F48F5902
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Nov 2019 22:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfKHVAj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 Nov 2019 16:00:39 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39285 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfKHVAj (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 8 Nov 2019 16:00:39 -0500
Received: by mail-pg1-f196.google.com with SMTP id 29so4705054pgm.6
        for <linux-crypto@vger.kernel.org>; Fri, 08 Nov 2019 13:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/6fKp6CqSBNNTOH5oGG1bShIqpaCFBeopQl1N5ozmL8=;
        b=Q3LChfPNrqBoMIG+qk93Z/uRgabqJU5Yonk/5lavcG+A5aoQNZBbgh8W+gvdW+O3WF
         Ph6NUvQFnHQa7qpWvvFQPpx6nX+S2/K9cuYiXfe1HqfaHUUDASWrTZfdctHnYl7VXUQ4
         H0NfOV+Xg64eoLm+H0RV9vZZrnHE8UMtJ3A5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/6fKp6CqSBNNTOH5oGG1bShIqpaCFBeopQl1N5ozmL8=;
        b=MOtLRQaXmJgeoXZyBZPyAhDnFOP/SPHgNUIXEOzpdlu0bPWk+GALmZm3x9fu6OpUXC
         EXkZZ+N7p13yZ4uMldZiFlpjQqJQtUvlu2RRQxpekPem42zxP45klEVbhOHapVzPc6RW
         mnXtaYA/xcNBeeiOzaRpMdNwohNZU/VHyv14/Im7QNxYIP6Sk8QXqyQ5RTgM7e3i0slg
         EuqN4Sg/kxBEjyelAf1hFb7ogpMPp2xtH3+mKcI3KlRb07zUSjiVMH5JVMTCf9+OYtIb
         YFWjx7usfDgr5vWyMYgQqvv6j+thFhsmuW9kSsKxQb2VB45c20IFAHOwjFCh1z6aO+bl
         iZ6g==
X-Gm-Message-State: APjAAAWSWVgvG8cEUerRnYzq9Mn+SE57MuWFdHn20JVaHoTi2nYmmpGE
        bnf/oVeJrOkIFv9dlHiWHEPdbQ==
X-Google-Smtp-Source: APXvYqx76TYGNxxUb3yK5CBsoS/H4otOJib03kZygL8sBTWdWl3BQi6ZSlS+rjuyQyVx9kxt8prGIQ==
X-Received: by 2002:a63:f849:: with SMTP id v9mr12888750pgj.99.1573246838531;
        Fri, 08 Nov 2019 13:00:38 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j22sm6388221pff.42.2019.11.08.13.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 13:00:37 -0800 (PST)
Date:   Fri, 8 Nov 2019 13:00:36 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        keescook+coverity-bot@chromium.org, narmstrong@baylibre.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: amlogic - fix two resources leak
Message-ID: <201911081300.B869D22BB@keescook>
References: <1573206317-9926-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573206317-9926-1-git-send-email-clabbe@baylibre.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Nov 08, 2019 at 09:45:17AM +0000, Corentin Labbe wrote:
> This patch fixes two resources leak that occur on error path.
> 
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1487403 ("RESOURCE_LEAK")
> Addresses-Coverity-ID: 1487401 ("Resource leaks")
> Fixes: 48fe583fe541 ("crypto: amlogic - Add crypto accelerator for amlogic GXL")
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/crypto/amlogic/amlogic-gxl-cipher.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> index e9283ffdbd23..58b717aab6e8 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> +++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> @@ -131,7 +131,8 @@ static int meson_cipher(struct skcipher_request *areq)
>  	if (areq->iv && ivsize > 0) {
>  		if (ivsize > areq->cryptlen) {
>  			dev_err(mc->dev, "invalid ivsize=%d vs len=%d\n", ivsize, areq->cryptlen);
> -			return -EINVAL;
> +			err = -EINVAL;
> +			goto theend;
>  		}
>  		memcpy(bkeyiv + 32, areq->iv, ivsize);
>  		keyivlen = 48;
> @@ -151,9 +152,10 @@ static int meson_cipher(struct skcipher_request *areq)
>  
>  	phykeyiv = dma_map_single(mc->dev, bkeyiv, keyivlen,
>  				  DMA_TO_DEVICE);
> -	if (dma_mapping_error(mc->dev, phykeyiv)) {
> +	err = dma_mapping_error(mc->dev, phykeyiv);
> +	if (err) {
>  		dev_err(mc->dev, "Cannot DMA MAP KEY IV\n");
> -		return -EFAULT;
> +		goto theend;
>  	}
>  
>  	tloffset = 0;
> @@ -245,7 +247,6 @@ static int meson_cipher(struct skcipher_request *areq)
>  	if (areq->iv && ivsize > 0) {
>  		if (rctx->op_dir == MESON_DECRYPT) {
>  			memcpy(areq->iv, backup_iv, ivsize);
> -			kzfree(backup_iv);
>  		} else {
>  			scatterwalk_map_and_copy(areq->iv, areq->dst,
>  						 areq->cryptlen - ivsize,
> @@ -254,6 +255,7 @@ static int meson_cipher(struct skcipher_request *areq)
>  	}
>  theend:
>  	kzfree(bkeyiv);
> +	kzfree(backup_iv);
>  
>  	return err;
>  }
> -- 
> 2.23.0
> 

-- 
Kees Cook

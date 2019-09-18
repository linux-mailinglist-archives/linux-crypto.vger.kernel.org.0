Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAB78B684C
	for <lists+linux-crypto@lfdr.de>; Wed, 18 Sep 2019 18:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387647AbfIRQht (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 18 Sep 2019 12:37:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36787 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387641AbfIRQht (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 18 Sep 2019 12:37:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id f19so214919plr.3
        for <linux-crypto@vger.kernel.org>; Wed, 18 Sep 2019 09:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J1GkKLG6lvp/GtC0MAMhWfOb994e64EiCwfOJPxf8RM=;
        b=I0HjyZYmt7lgF05P8+nOoOIyNjRfcLWECZitfwk5PAP2klJk3jejiBnRCUDDt09hJg
         BH+gAJQa+UeOpN53giu+MThtAinc39ChY9NOwhYQAA34u97TKZnaYLUxjjJJq5i8/oee
         85iANBtFodXnXr5Fv6FzHWHQkSHdrOux63uLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J1GkKLG6lvp/GtC0MAMhWfOb994e64EiCwfOJPxf8RM=;
        b=AKru/QG7C8+UJc5TtchJqBBWOD2zAfCNNrJ/TLOd+FrSzYLa0zIUPdbRB8A1vXx/aS
         xBZTtz2aLvzjxfo3l2IrtTIbut8aqC4ZOpwLxqL19HoKZiC1JcTXQROvf6s23M3mbYAH
         UqDfKYjffWyL/i7Ud0EyQ8jUU4CdvVKRKOx20we3NfBsQtCik78fKveYI8HIrTQk6F6F
         31RIonfjCVq5cislo8yWzDnj2tfW588kCfk7Z/uXstwGrSsKN2ISRlcPJidJ87Um20C0
         UsR4oFgO2LeJJp7uWroa1KPWX5C2ulECU8qpvEvIhZwJV5jzWCuoY5jbHIWiKnLsG1f7
         sjEQ==
X-Gm-Message-State: APjAAAX+ArTzSE6kn0iveI90p+z8ZuqH8QpMoEjcJ5EMDrcouhtI1q0i
        jc3IxyKg6vdlZsMJkbcftQ0uFg==
X-Google-Smtp-Source: APXvYqznLi1akMyvUhQjFSDE6RFyBEIeeFSwv7tfyPa8JsRx7uUSxWx9D9JPEV56WoHDBaJwAZ3Bvw==
X-Received: by 2002:a17:902:7489:: with SMTP id h9mr1598620pll.166.1568824668412;
        Wed, 18 Sep 2019 09:37:48 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id g12sm5367137pgb.26.2019.09.18.09.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 09:37:47 -0700 (PDT)
Subject: Re: [PATCH] hwrng: iproc-rng200 - Use
 devm_platform_ioremap_resource() in iproc_rng200_probe()
To:     Markus Elfring <Markus.Elfring@web.de>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Matt Mackall <mpm@selenic.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
References: <0ecb0679-0558-6cbe-af2f-6ee9122a4a7e@web.de>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <667911b3-602e-e5a9-5e83-bd8c17625bb7@broadcom.com>
Date:   Wed, 18 Sep 2019 09:37:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0ecb0679-0558-6cbe-af2f-6ee9122a4a7e@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org



On 9/18/19 12:19 AM, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 18 Sep 2019 09:09:22 +0200
> 
> Simplify this function implementation by using a known wrapper function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   drivers/char/hw_random/iproc-rng200.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/char/hw_random/iproc-rng200.c b/drivers/char/hw_random/iproc-rng200.c
> index 92be1c0ab99f..899ff25f4f28 100644
> --- a/drivers/char/hw_random/iproc-rng200.c
> +++ b/drivers/char/hw_random/iproc-rng200.c
> @@ -181,7 +181,6 @@ static void iproc_rng200_cleanup(struct hwrng *rng)
>   static int iproc_rng200_probe(struct platform_device *pdev)
>   {
>   	struct iproc_rng200_dev *priv;
> -	struct resource *res;
>   	struct device *dev = &pdev->dev;
>   	int ret;
> 
> @@ -190,13 +189,7 @@ static int iproc_rng200_probe(struct platform_device *pdev)
>   		return -ENOMEM;
> 
>   	/* Map peripheral */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(dev, "failed to get rng resources\n");
> -		return -EINVAL;
> -	}
> -
> -	priv->base = devm_ioremap_resource(dev, res);
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(priv->base)) {
>   		dev_err(dev, "failed to remap rng regs\n");
>   		return PTR_ERR(priv->base);
> --
> 2.23.0
> 

Change looks good to me, thanks!

Reviewed-by: Ray Jui <ray.jui@broadcom.com>

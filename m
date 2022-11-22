Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF10633604
	for <lists+linux-crypto@lfdr.de>; Tue, 22 Nov 2022 08:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbiKVHms (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 22 Nov 2022 02:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbiKVHmq (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 22 Nov 2022 02:42:46 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65AE1173
        for <linux-crypto@vger.kernel.org>; Mon, 21 Nov 2022 23:42:44 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso10676851wmo.1
        for <linux-crypto@vger.kernel.org>; Mon, 21 Nov 2022 23:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QA8MIxpIapkC8rEFteuXA52vQ4uYeexAZXXoL3SYQDg=;
        b=j9/erFQZhyBUbV56VTTVREPvqvvwUBRXSGqaVS/BckbFM00YyHGVlZJjQHBu66+Uhy
         Nc8eyOJol/nhlpYY8ymw08M8wg8i/cPXaTrRdBvavolILqnQwLrveHQY61RbDm16JSP4
         fCdjDGqu1vkVWbxNYrZl6mK0q0TGsNQRTl+mOVJ/XcqiCK2xS55uH58l54jhxwQpr7wa
         z1vOHW4O9HVhinBazEUBY7ZIpq5pNTZiSbwPsAox4k82nVSithVEZl06lkHTOCu8mNvg
         +yfMERxrxxgKPC5Uy/zQlAaw9yPyX1oqTIyRDq+AJsmGz24j7cEHHSqc889e51NvKmVf
         9VJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QA8MIxpIapkC8rEFteuXA52vQ4uYeexAZXXoL3SYQDg=;
        b=HQ7r4CroRTbJvAQm+yaEIKlkmfHZDBcBCzy3L2qrUkX0GY9EOCB2uv2g3C4d9NLGkv
         AsEYs4/xxfQxQN6isZdocR4Ef1mAhfSlAMVwVHEAKE9C7cxtiM9dDQA11Wyy6ywNi0Mg
         fX4l4UU3NBw5bcLMS1VEUm9ebIwyV1aOYmPOxmuXNQnDvcMaAp/IlwEXDtwLDufDfMr9
         mfqEOtMrkOJc4en2C1AAvun9f0sl88LmwdmGcTO5rvDds1cpHaV1Y1jfiQQBGLwl3flx
         jzkobMN+spNaD8aiL2dgkkffKBbgxKaxbexHoGyDKKLt/i/kY2Qw4tTfAn8EkSKQWBJh
         eaNg==
X-Gm-Message-State: ANoB5pm3AkeoueeOeI3dwqsF/vyUiN8gQfumg+SMsrvI1Pyj+qDozj5Q
        Yh1XZKC6tOwKcmZ4qr6uyniDYw==
X-Google-Smtp-Source: AA0mqf4Ei//KY2A6ZGaG99iMhX8fGi7uYrNGLNXKBpd4mjqaLK9ggmNUXVO9NMVN9iSmOxMHvtie8g==
X-Received: by 2002:a1c:f006:0:b0:3cf:7b68:631 with SMTP id a6-20020a1cf006000000b003cf7b680631mr19316735wmb.55.1669102963360;
        Mon, 21 Nov 2022 23:42:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:6969:11a1:a2af:e8c0? ([2a01:e0a:982:cbb0:6969:11a1:a2af:e8c0])
        by smtp.gmail.com with ESMTPSA id f8-20020a5d4dc8000000b002366c3eefccsm13187908wru.109.2022.11.21.23.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 23:42:42 -0800 (PST)
Message-ID: <0df30bbf-3b7e-ed20-e316-41192bf3cc2b@linaro.org>
Date:   Tue, 22 Nov 2022 08:42:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] crypto: amlogic - Add check for devm_kcalloc
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, clabbe@baylibre.com,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221122062230.22024-1-jiasheng@iscas.ac.cn>
Content-Language: en-US
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20221122062230.22024-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 22/11/2022 07:22, Jiasheng Jiang wrote:
> As the devm_kcalloc may return NULL pointer,
> it should be better to add check for the return
> value, as same as the others.
> 
> Fixes: 48fe583fe541 ("crypto: amlogic - Add crypto accelerator for amlogic GXL")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>   drivers/crypto/amlogic/amlogic-gxl-core.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
> index 6e7ae896717c..b243d6382664 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl-core.c
> +++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
> @@ -238,6 +238,9 @@ static int meson_crypto_probe(struct platform_device *pdev)
>   	}
>   
>   	mc->irqs = devm_kcalloc(mc->dev, MAXFLOW, sizeof(int), GFP_KERNEL);
> +	if (!mc->irqs)
> +		return -ENOMEM;
> +
>   	for (i = 0; i < MAXFLOW; i++) {
>   		mc->irqs[i] = platform_get_irq(pdev, i);
>   		if (mc->irqs[i] < 0)


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E9E4AF331
	for <lists+linux-crypto@lfdr.de>; Wed,  9 Feb 2022 14:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbiBINqX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 9 Feb 2022 08:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbiBINqM (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 9 Feb 2022 08:46:12 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64069C061355
        for <linux-crypto@vger.kernel.org>; Wed,  9 Feb 2022 05:46:15 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BB1313F1B4
        for <linux-crypto@vger.kernel.org>; Wed,  9 Feb 2022 13:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644414373;
        bh=uPmwK2Sajk0B7/rIDbd45YqogfWkOlduqJZAInEIkls=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=s3NiHe1O+0iVu8JVmKiGvY4+24juU0rzo7icL+Wqu4nz/uIGwCS548E26lqcMKvop
         9JB+mbJZii467b5x87LP2KGscl1XWYaW1ONJFjzIlAXYt/NU7TYVZry0cC/qXUMKQm
         qStdyXt46cwqeNTPgZR/VS9PPQZN0kudKLxtZ5LcjM0bp3Z9LdUG7YiV0pDxZd2ukJ
         InUqwdZm6QIIsrG8KlpQjyxq48zbH9DpEzPhqOgrJKV+p3oUQNaLoFV/g3y/Ety4Wk
         JYBAlFQE9Jnub1ux6RKAfOWkTdzE7sIVzLDZ6Pr5Enhv/qhDQREdzAKlYu7YBEZP8C
         r4Uc1/Lbg7vRw==
Received: by mail-ej1-f71.google.com with SMTP id k16-20020a17090632d000b006ae1cdb0f07so1190020ejk.16
        for <linux-crypto@vger.kernel.org>; Wed, 09 Feb 2022 05:46:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uPmwK2Sajk0B7/rIDbd45YqogfWkOlduqJZAInEIkls=;
        b=buw325OA7TNirnk1+TN7l6k3y4iOXKGQxl2Xcc2CWJs2js9vcl1rnCAZ9bRtP+T/gw
         n13/HF510/5gXKrn6+YEtIX73fPzH+OK8skNSm1SThLNW5GwZQTO1/nZ+dIh92WeLcek
         FoyvlghHJRURV9mtn/p8hqd442cXJcdWqiQXuiuXDyDavqxlzNOxLgj/YNtA/DUVZXPT
         bHYj0UHb6Szhr2Jr35vg+UmqqbtGzzqexFHSlw5KEDO8+wOQid0NyKkhUogUNB7F4rsa
         YlorFqayaoYtdgtRAwPP7J//+P5NUeuPqoeq4YjOSCHTU/DL9nuofEHpgjm0Qx7Yo3m1
         YjZQ==
X-Gm-Message-State: AOAM532/4nHfOefryj1mHq230wQM7QIh+H/KdPOO+mQfO/RdHom3kQ1y
        RVH6imUuxApcQDR4C2Ue6lbN9pMbrbtZn5/iyPJNmt6DYFmehGurBAZGFajK0Oz7u8j8oNZL+Kf
        xc06LS60wKSoidqsGMNXLbpd33kMs5CzxxsPkcqb4Xw==
X-Received: by 2002:a05:6402:3596:: with SMTP id y22mr2613091edc.370.1644414372808;
        Wed, 09 Feb 2022 05:46:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwkZKjTUYePrgBC0lsw8CSQ+1aXWr69tlBK1fCM0/xVCywpwRzP01Ct4mgEz/qhm2ljFlSOXw==
X-Received: by 2002:a05:6402:3596:: with SMTP id y22mr2613072edc.370.1644414372627;
        Wed, 09 Feb 2022 05:46:12 -0800 (PST)
Received: from [192.168.0.94] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id i18sm2482081ejy.190.2022.02.09.05.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 05:46:11 -0800 (PST)
Message-ID: <a835458d-2612-6ed6-e4fb-2b47c6c69871@canonical.com>
Date:   Wed, 9 Feb 2022 14:46:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: crypto: convert rockchip-crypto to yaml
Content-Language: en-US
To:     Corentin Labbe <clabbe@baylibre.com>, davem@davemloft.net,
        heiko@sntech.de, herbert@gondor.apana.org.au, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20220209124725.2080986-1-clabbe@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220209124725.2080986-1-clabbe@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 09/02/2022 13:47, Corentin Labbe wrote:
> Convert rockchip-crypto to yaml.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../bindings/crypto/rockchip-crypto.txt       | 28 --------
>  .../bindings/crypto/rockchip-crypto.yaml      | 64 +++++++++++++++++++
>  2 files changed, 64 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
>  create mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.yaml
> 
> diff --git a/Documentation/devicetree/bindings/crypto/rockchip-crypto.txt b/Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
> deleted file mode 100644
> index 5e2ba385b8c9..000000000000
> --- a/Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -Rockchip Electronics And Security Accelerator
> -
> -Required properties:
> -- compatible: Should be "rockchip,rk3288-crypto"
> -- reg: Base physical address of the engine and length of memory mapped
> -       region
> -- interrupts: Interrupt number
> -- clocks: Reference to the clocks about crypto
> -- clock-names: "aclk" used to clock data
> -	       "hclk" used to clock data
> -	       "sclk" used to clock crypto accelerator
> -	       "apb_pclk" used to clock dma
> -- resets: Must contain an entry for each entry in reset-names.
> -	  See ../reset/reset.txt for details.
> -- reset-names: Must include the name "crypto-rst".
> -
> -Examples:
> -
> -	crypto: cypto-controller@ff8a0000 {
> -		compatible = "rockchip,rk3288-crypto";
> -		reg = <0xff8a0000 0x4000>;
> -		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&cru ACLK_CRYPTO>, <&cru HCLK_CRYPTO>,
> -			 <&cru SCLK_CRYPTO>, <&cru ACLK_DMAC1>;
> -		clock-names = "aclk", "hclk", "sclk", "apb_pclk";
> -		resets = <&cru SRST_CRYPTO>;
> -		reset-names = "crypto-rst";
> -	};
> diff --git a/Documentation/devicetree/bindings/crypto/rockchip-crypto.yaml b/Documentation/devicetree/bindings/crypto/rockchip-crypto.yaml
> new file mode 100644
> index 000000000000..392d89055398
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/rockchip-crypto.yaml

file name: rockchip,crypto.yaml or rockchip,rk3288-crypto.yaml.
Kind of depends whether there is another binding possible for newer
Crypto blocks from Rockchip. I guess it is quite possible, so maybe the
latter version.


> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/crypto/rockchip-crypto.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip Electronics And Security Accelerator
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    const: rockchip,rk3288-crypto
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: clock data
> +      - description: clock data
> +      - description: clock crypto accelerator
> +      - description: clock dma
> +
> +  clock-names:
> +    items:
> +      - const: aclk
> +      - const: hclk
> +      - const: sclk
> +      - const: apb_pclk
> +
> +  resets:
> +    minItems: 1

Instead maxItems: 1

> +
> +  reset-names:
> +    const: crypto-rst
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    crypto: crypto@ff8a0000 {
> +      compatible = "rockchip,rk3288-crypto";
> +      reg = <0xff8a0000 0x4000>;
> +      interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&cru ACLK_CRYPTO>, <&cru HCLK_CRYPTO>,
> +               <&cru SCLK_CRYPTO>, <&cru ACLK_DMAC1>;

Does it work? Did you run dt_binding_check?

> +      clock-names = "aclk", "hclk", "sclk", "apb_pclk";
> +      resets = <&cru SRST_CRYPTO>;
> +      reset-names = "crypto-rst";
> +    };


Best regards,
Krzysztof

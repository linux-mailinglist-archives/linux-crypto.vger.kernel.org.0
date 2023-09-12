Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCA279D3E4
	for <lists+linux-crypto@lfdr.de>; Tue, 12 Sep 2023 16:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbjILOjH (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 12 Sep 2023 10:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbjILOjG (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 12 Sep 2023 10:39:06 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B52C1AE
        for <linux-crypto@vger.kernel.org>; Tue, 12 Sep 2023 07:39:02 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-501bd164fbfso9323508e87.0
        for <linux-crypto@vger.kernel.org>; Tue, 12 Sep 2023 07:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694529540; x=1695134340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=90jC6lxpRCDPUe28BcYQwA0xCL7xf56sZ85Q5b+uKGA=;
        b=aqAhKfuyhcfd/L9Fom5gVmpiQCjpykKy0PepnjX0APVDNn1YFDCBaIm9FPqhkjpAGx
         QRKWtmwPrNCe0C/tiAld1SYGyL0ybuqCXC8mL/mRSiebw+JNLR9fdknpe0OgmVbd3waX
         XudS8qKPBAQ9uaucP1DvnuFU8ws8x4YTclJ0RK3bO8RFzYAOEqDdsK3WJ+QFCWqXh0j1
         xLXmMG08br6DxSDa8Qe7xjbriS9siMocmLIwSYZicQF0ZEG19Y6hSVKenQQczWkPQn4R
         9GXPfkaytRnSIB08kqECRGGnQZLlyjEtheerYXb/5mygfnlp2mYZ5TEjylHsyhgEbGit
         CrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694529540; x=1695134340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=90jC6lxpRCDPUe28BcYQwA0xCL7xf56sZ85Q5b+uKGA=;
        b=k/O7h/EaFuV361dvTv4h4vTHhqhK2HRP0bUyqhYyfq2NYsBb3tbQG4eZ2hfPBTXXBh
         LROf0I2xiivQKYtuxyK2BpCsKlXeYwyxqWFI9KgLLdutWroEHMmb8GuNrgxvoXE5CUm3
         a6jXPDqye0FG1S++jotMBXwrHggV+rC+sK72e9U+vmuG2XqDE7pN5vZ1csnosi2eSAzM
         nDEX3pBRuwaXWW74R2feVtyilIM0O1ND50jIFXrU5JMUMmf5B1coHZ6q8670sw/rkZTN
         nsB+sFPlzQGnh9rJpTTnINlmer9s4spAQkR+9qODQ4VvIko3W6s1D/kb3JlW21VcE3xY
         BrEQ==
X-Gm-Message-State: AOJu0Yxp4rBi30BdUP99IU24c8DcC9iUOXcA2GmEs+TfL22mlsREu+cZ
        1ygTsap62APURI6qvdzANuFIAQ==
X-Google-Smtp-Source: AGHT+IGTLkWR/G9NZRRA7prqCKEl3s/MsYlgvEESmIxQqGWWdnJSzY4il2hoUqsAEx+R0TwNJNs6YQ==
X-Received: by 2002:a05:6512:b95:b0:500:a6c1:36f7 with SMTP id b21-20020a0565120b9500b00500a6c136f7mr12163748lfv.3.1694529540570;
        Tue, 12 Sep 2023 07:39:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id d32-20020a056402402000b00521d2f7459fsm4484835eda.49.2023.09.12.07.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 07:39:00 -0700 (PDT)
Message-ID: <327ff0b3-21c9-1452-af1b-e9b6ece52924@linaro.org>
Date:   Tue, 12 Sep 2023 16:38:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 10/10] ARM: dts: stm32: add RNG node for STM32MP13x
 platforms
Content-Language: en-US
To:     Gatien Chevallier <gatien.chevallier@foss.st.com>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Lionel Debieve <lionel.debieve@foss.st.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230911120203.774632-1-gatien.chevallier@foss.st.com>
 <20230911120203.774632-11-gatien.chevallier@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230911120203.774632-11-gatien.chevallier@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 11/09/2023 14:02, Gatien Chevallier wrote:
> The RNG on STM32MP13 offers upgrades like customization of its
> configuration and the conditional reset.
> 
> The hardware RNG should be managed in the secure world for but it
> is supported on Linux. Therefore, is it not default enabled.
> 
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> ---
>  arch/arm/boot/dts/st/stm32mp131.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm32mp131.dtsi
> index ac90fcbf0c09..39db82b782eb 100644
> --- a/arch/arm/boot/dts/st/stm32mp131.dtsi
> +++ b/arch/arm/boot/dts/st/stm32mp131.dtsi
> @@ -1220,6 +1220,14 @@ mdma: dma-controller@58000000 {
>  			dma-requests = <48>;
>  		};
>  
> +		rng: rng@54004000 {
> +			compatible = "st,stm32mp13-rng";
> +			reg = <0x54004000 0x400>;
> +			clocks = <&rcc RNG1_K>;
> +			resets = <&rcc RNG1_R>;
> +			status = "disabled";

Why? What other resources are missing?

Best regards,
Krzysztof


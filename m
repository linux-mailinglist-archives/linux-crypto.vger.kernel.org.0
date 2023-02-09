Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0AF690388
	for <lists+linux-crypto@lfdr.de>; Thu,  9 Feb 2023 10:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjBIJYY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 9 Feb 2023 04:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjBIJYE (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 9 Feb 2023 04:24:04 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FA35DC1C
        for <linux-crypto@vger.kernel.org>; Thu,  9 Feb 2023 01:23:57 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id e3so1073041wrs.10
        for <linux-crypto@vger.kernel.org>; Thu, 09 Feb 2023 01:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TXSo8vM/L+jU+SLl1S9VoN49X6K4wt52xlassGBxJU0=;
        b=i943EPtUIdT6HET1bgLpNd7jKrHP2ChtIA/UFnJZeY87pwCdxXCyz3BHznrSdTFpbp
         7Na72mUj9oJ4nBtDEgLwIRq+tAii9Orh91PXtlOiHSAcbjdT0dAd+GZSqI9hp3A5G9Vw
         hMwGNuZ8U2zBgric7XHZF5syWQMQIInIWKGWVB3ckj7COYB5i2dqLbw0zc+tCEs7FqVE
         85DatUstqkqh3E/15dHWV6dZnW58BGTMMkExNSvLP/d4o3x+yCDMsSdGjKIlAaSlNj5l
         N0pARUr4fO0rywK/1HcL6eEDdkcVZwVNYVj9BfaI6/AG0l+juqrP04b5XgMj0Ys6wKxG
         olzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXSo8vM/L+jU+SLl1S9VoN49X6K4wt52xlassGBxJU0=;
        b=Tnn9WwiZ6OS8JvBiba+vKnFOzUQLG56qpcscLxTF4TMud8AEF47LkMRAKc5qSLcr/A
         a7SyD7FZMvb+2PUMFDk6P5BQh7v9IdFnTatyWF2Zh/uMkwYqcpDlO3GcUEaQU+TmlaKo
         OyvLGb1ppFhMjelV0MhnuTaZ2xsY3B2BHTzWSE23dVzDYAjT51m5pWxbC0+lq4T58Gg+
         BIkK5eSDK1U4QIm9+0VzILCUv6xwDCL8DOl19k2q7f95Gn4MkRjNVq5mrDOExPFB7Mqo
         Ic0g96SKaGtzzArMNrXyOxO7qgifekr9g1Gq67rU0BfKh0U05vRnW/+R5X74rzWRS1wt
         eHVw==
X-Gm-Message-State: AO0yUKVnC4DpDES0TNs4EwJvz6kLUdi3RPnC/v4eg/GMrRnjLc0dOCl6
        nZKU1Ic+0tp85q1NuwedHLfURg==
X-Google-Smtp-Source: AK7set+RPruXgW+Ty6YaiwCMcV08L31oHqtk+oNjOxPq6cEUzia1Ml2Z+2CsUrPoTqp+GLP2Bfar4A==
X-Received: by 2002:adf:e0c2:0:b0:2c4:503:7afc with SMTP id m2-20020adfe0c2000000b002c405037afcmr4758140wri.7.1675934635919;
        Thu, 09 Feb 2023 01:23:55 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y1-20020a5d4ac1000000b002c3be6ae0b1sm753098wrs.65.2023.02.09.01.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 01:23:55 -0800 (PST)
Message-ID: <4191bf6e-7670-ea32-ff29-65f291ccc97f@linaro.org>
Date:   Thu, 9 Feb 2023 10:23:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v9 10/14] arm64: dts: qcom: sm8550: add a family
 compatible for QCE IP
Content-Language: en-US
To:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org
References: <20230208183755.2907771-1-vladimir.zapolskiy@linaro.org>
 <20230208183755.2907771-11-vladimir.zapolskiy@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230208183755.2907771-11-vladimir.zapolskiy@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 08/02/2023 19:37, Vladimir Zapolskiy wrote:
> Add a family compatible for QCE IP on SM8550 SoC, which is equal to
> QCE IP found on SM8150 SoC and described in the device tree bindings
> documentation.
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This one is ok:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


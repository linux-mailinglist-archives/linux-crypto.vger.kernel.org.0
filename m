Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5169144E486
	for <lists+linux-crypto@lfdr.de>; Fri, 12 Nov 2021 11:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbhKLK2I (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 12 Nov 2021 05:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbhKLK2H (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 12 Nov 2021 05:28:07 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C99C061767
        for <linux-crypto@vger.kernel.org>; Fri, 12 Nov 2021 02:25:16 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 1so17691387ljv.2
        for <linux-crypto@vger.kernel.org>; Fri, 12 Nov 2021 02:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dod3q4e99IOgDr8tfF0eheG1Nlghs1gEHrmxtpebURI=;
        b=kPXMTs85jziTejHO4EVuL8RPqHNBGCt0NlDjdDSLAOxmmNjRDSVYTXMXn518AY2BVO
         H6zOo0S4ll6B0wLmhfjp/Iv5ElrZpt0/34h1wLQ/JsOjJcxqN/co/ME+rhgSxB5JlmO5
         Bd3S3aG28/BepYr1qfkaMhukW9yGW/OqBfkNocb8Qust52puxl3jhnxkvuuwptqmef94
         hEfyIdM/y+q6Gp8d62APPRRKJ1Jj/EGXHuT3zrHSyCjLd2tPfTQC0pExCcwrxtcBZpVB
         Fi4xAmi/8lWfd0LHe9jr9j/w6eNUqhx7JGIWHgeCmR+H445ivGdsxWlcVMyCCNKUUDg1
         hpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dod3q4e99IOgDr8tfF0eheG1Nlghs1gEHrmxtpebURI=;
        b=w1SOXieF1y+3qUPPVMJWrgmagpGw2tKsjhcC3syMOi3ykPaY+MX4hqanYkK/NS/X3j
         CoDr+PcRxQLSc9ttZn0C0VgF2MVyMCuXAfmkTa8FZj7YiO9/pQJudnChBhdnkmd8/pkJ
         0ksyPjb1hyIzrMWh9c1Ej1UIwXe3tX6hMTd3WUt8G68qxsH6TtPg7QAsg3VyCh62bSsc
         XhSNPV5d0nPQ0EvQAaUkLY5R8jsuuZ4WpGeVT3mvwky4zQFOZl2X9vxpKP3uS+LCdr5/
         LJtJ7XNwrTNSAPP0CryRLz0kmqpqJorvx1pw0YyVWYRHXWeSmKup3M3QdrTF+Pzt7q6E
         t2vA==
X-Gm-Message-State: AOAM530QekxY0RzqcjPEEBsJsLrVxS0VQy9ojFZPoXBNpLnrW47rWFpz
        DB+QUVuzbyxy12L0imOiN0GMJA==
X-Google-Smtp-Source: ABdhPJxCRV1Oowtf6KkbtbZHyzyBa02lstB8BrVVi+Q7jRojHAaAHD/eOGE5DbNZvKByzewuFYvBmw==
X-Received: by 2002:a2e:a361:: with SMTP id i1mr14317511ljn.32.1636712714806;
        Fri, 12 Nov 2021 02:25:14 -0800 (PST)
Received: from [192.168.1.102] (62-248-207-242.elisa-laajakaista.fi. [62.248.207.242])
        by smtp.gmail.com with ESMTPSA id d39sm525443lfv.78.2021.11.12.02.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 02:25:14 -0800 (PST)
Subject: Re: [PATCH v5 11/22] dt-bindings: crypto : Add new compatible strings
 for qcom-qce
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, agross@kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        stephan@gerhold.net, Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>
References: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
 <20211110105922.217895-12-bhupesh.sharma@linaro.org>
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Message-ID: <3d02334e-d4eb-499e-7523-cd446ad0818f@linaro.org>
Date:   Fri, 12 Nov 2021 12:25:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20211110105922.217895-12-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Bhupesh,

On 11/10/21 12:59 PM, Bhupesh Sharma wrote:
> Newer qcom chips support newer versions of the qce crypto IP, so add
> soc specific compatible strings for qcom-qce instead of using crypto
> IP version specific ones.
> 
> Keep the old strings for backward-compatibility, but mark them as
> deprecated.
> 
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>   Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> index efe349e66ae7..77b9f544f32f 100644
> --- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> +++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> @@ -15,7 +15,13 @@ description: |
>   
>   properties:
>     compatible:
> -    const: qcom,crypto-v5.1
> +    enum:
> +      - qcom,crypto-v5.1 # Deprecated. Kept only for backward compatibility
> +      - qcom,ipq6018-qce
> +      - qcom,sdm845-qce
> +      - qcom,sm8150-qce
> +      - qcom,sm8250-qce
> +      - qcom,sm8350-qce

let me ask you to add at least two more compatibles to the list: qcom,ipq8074-qce
and qcom,msm8996-qce.

>   
>     reg:
>       maxItems: 1
> @@ -68,7 +74,7 @@ examples:
>     - |
>       #include <dt-bindings/clock/qcom,gcc-apq8084.h>
>       crypto-engine@fd45a000 {
> -        compatible = "qcom,crypto-v5.1";
> +        compatible = "qcom,ipq6018-qce";
>           reg = <0xfd45a000 0x6000>;
>           clocks = <&gcc GCC_CE2_AHB_CLK>,
>                    <&gcc GCC_CE2_AXI_CLK>,
> 

--
Best wishes,
Vladimir

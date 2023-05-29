Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C827143F0
	for <lists+linux-crypto@lfdr.de>; Mon, 29 May 2023 08:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjE2GNc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 29 May 2023 02:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjE2GN2 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 29 May 2023 02:13:28 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01105AD
        for <linux-crypto@vger.kernel.org>; Sun, 28 May 2023 23:13:26 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f6ffc2b314so4950885e9.0
        for <linux-crypto@vger.kernel.org>; Sun, 28 May 2023 23:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685340805; x=1687932805;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N0GoosA+9uka02/xKEt1rQ6orV6x3wMmK2ZhU5cav+I=;
        b=K46+v7wYyQems0d2CvKbmd9LpTmOQUbsYBKc1WWH8U65Zrgp5Fe5s8mYfCviEyRAUV
         R5NPDDZlDkCsV394FnSuNk+p96qQ7TJQU5P1J9rCaKpCHZXP3zxtlFexRdADTSaszglY
         gtKU0lTE0Oq7P1LJ8k4yWW9RYFoXAvPLqBPjqk4MhQtCKyDYcLDTXOER8xq4vLiTNta1
         VAPZ3b5ktwOBUwseYrVuD9/+CJhZSTzPVSmNUzAJSfpp869uBcIYXdUayLr7K5sc0iuX
         fA+i+wxiTw7sYD2Le/5bBduMLw3NGHzYyy2NK9vZiGorPo46V9tZB5F5Wj0IRR5cD7gU
         WThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685340805; x=1687932805;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0GoosA+9uka02/xKEt1rQ6orV6x3wMmK2ZhU5cav+I=;
        b=lhWfOAVs8/vpgLqKLHBa2agGzlHgFkfz1+PJ+ieKoiS1cpFsvlRvdCpZEyoqwd4Nx7
         wqnuvWZaF88oS5Fbjv0XpF1wpgf9qoLBWhC/MOFUun4xjJLy/GMTL61sEHjLswntn/Bu
         Y1ihgDZDXeBGNt02JyLvus+ktQD5eJnOEJUpuZL/XC6wQu/zUgBkujHtOyr7in/RHqXk
         7Nk+CnBTnxChtZSzjUtPJ0QFHVsc+BNrnaNXraU/XeGetGMoe0iZo+DjizkIh5raUIzp
         AXAv4eFhn6atzbcXzz60oelDMp0U6Kw/t56WsjQUcW5s+6ooYOwENuTfBjYcid+HrrVi
         JEjw==
X-Gm-Message-State: AC+VfDwzswbrZZtIvXLPjORRXhsqre2LaVo7ued0D6ckfWAA93wWnP1u
        N/yjES2ZeTXzLiRgGRyUiiBbkQE8+AbluZRSPlEthQ==
X-Google-Smtp-Source: ACHHUZ6G1tf+Gf5X/mMh8v33xYphjI7AZtG1DORt+A6DQvoqWXp2ntBRnYy5vqfrG+UbsUuNLaIQL7it7ADddzUT1vg=
X-Received: by 2002:a05:6000:18c4:b0:309:5889:b86a with SMTP id
 w4-20020a05600018c400b003095889b86amr5935028wrq.27.1685340805413; Sun, 28 May
 2023 23:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230526192210.3146896-1-bhupesh.sharma@linaro.org> <20230526192210.3146896-2-bhupesh.sharma@linaro.org>
In-Reply-To: <20230526192210.3146896-2-bhupesh.sharma@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Mon, 29 May 2023 11:43:11 +0530
Message-ID: <CAH=2Ntx+4F+ZP_Y+=e4p9rdTRQV8FHaepJCyqVFtWUPjDehoNg@mail.gmail.com>
Subject: Re: [PATCH v8 01/11] dt-bindings: dma: Add support for SM6115 and
 QCM2290 SoCs
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org,
        vladimir.zapolskiy@linaro.org, rfoss@kernel.org,
        neil.armstrong@linaro.org, djakov@kernel.org, stephan@gerhold.net,
        Rob Herring <robh@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Vinod,

> On Sat, 27 May 2023 at 00:52, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>
> Add new compatible for BAM DMA engine version v1.7.4 which is
> found on Qualcomm SM6115 and QCM2290 SoCs. Since its very similar
> to v1.7.0 used on SM8150 like SoCs, mark the comptible scheme
> accordingly.
>
> While at it, also update qcom,bam-dma bindings to add comments
> which describe the BAM DMA versions used in SM8150 and SM8250 SoCs.
> This provides an easy reference for identifying the actual BAM DMA
> version available on Qualcomm SoCs.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../devicetree/bindings/dma/qcom,bam-dma.yaml | 20 ++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> index f1ddcf672261..c663b6102f50 100644
> --- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> @@ -15,13 +15,19 @@ allOf:
>
>  properties:
>    compatible:
> -    enum:
> -        # APQ8064, IPQ8064 and MSM8960
> -      - qcom,bam-v1.3.0
> -        # MSM8974, APQ8074 and APQ8084
> -      - qcom,bam-v1.4.0
> -        # MSM8916 and SDM845
> -      - qcom,bam-v1.7.0
> +    oneOf:
> +      - enum:
> +          # APQ8064, IPQ8064 and MSM8960
> +          - qcom,bam-v1.3.0
> +          # MSM8974, APQ8074 and APQ8084
> +          - qcom,bam-v1.4.0
> +          # MSM8916, SDM630
> +          - qcom,bam-v1.7.0
> +      - items:
> +          - enum:
> +              # SDM845, SM6115, SM8150, SM8250 and QCM2290
> +              - qcom,bam-v1.7.4
> +          - const: qcom,bam-v1.7.0
>
>    clocks:
>      maxItems: 1
> --
> 2.38.1

Bjorn has applied the dts patches from this series to his tree.
As suggested by him, can you please pick patches [PATCH 1/11] and
[PATCH 2/11] from this series via the 'dmaengine' tree.

Seems some Cc fields got messed up while sending the patchset, so
Cc'ing the dmaengine list again.

Thanks,
Bhupesh

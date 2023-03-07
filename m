Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587966AF7F0
	for <lists+linux-crypto@lfdr.de>; Tue,  7 Mar 2023 22:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjCGVs3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 7 Mar 2023 16:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjCGVsY (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 7 Mar 2023 16:48:24 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A169C93E0D
        for <linux-crypto@vger.kernel.org>; Tue,  7 Mar 2023 13:48:21 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so80888pjb.3
        for <linux-crypto@vger.kernel.org>; Tue, 07 Mar 2023 13:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112; t=1678225701;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sOfYQC5Wms7nFLMbnCTJxEUtyV2SFvfbKCb8Kcs7zcA=;
        b=D9b9TY1UnnYGSB7zyK3QEHUXYMFmPnmCZ6NUoUZpQPwqUxRpJkwyi9CgxZCm34fGRd
         gOAEakDjL4IkU+ar3tjfsxBvWovUGxm5Ijr8HhtJG2bioYGxTyOPQMKhdXLvPWH9RCTF
         bZvqjp4FRiuaBYeaxK0JpS/o2vGhgYDcD9pY6ulyBfusRXNupF+K2AxpeCTR7OsUz+Jb
         0TzA6sFwIKcElDFmfY1SuhiKk+CZl4hU1uAEVSzXhY8MsApXJa454UMAlox8HY6DwYtm
         wA66apI6BqwHvXc24WwGgRkAnS7lJDXSGUiLZjrHwDe+K36XHmsO2JzNJNvF2JjRivdK
         9pAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678225701;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOfYQC5Wms7nFLMbnCTJxEUtyV2SFvfbKCb8Kcs7zcA=;
        b=flTS6Vw3qRaQ3sQU8JNl62c/uBGFXqnj0SX7DlfQpKGP9RHW1CvEqw9rDhe0UvfcD5
         J0kjXZzQW84ZdbrthJe7Y+wARSloJOHWDjsu/YrggjMVF1d0k4z9q7Kni+Zw0lYA2HGM
         N5u3hPpff29WXdRzQTYxkwMEkYEpYWzmzeThWmfovhOTuKp5sAdPkJ5pg9WsqrlwNgdh
         LmmyNn7HWQG0dorBI8cROfmCNxhusolinBmcEoUauBr/XHgsONYdChPaxI4MoHVRfiSP
         1ZD0Spz3wgBYfftJUvMuWlitfgvAeoswVua4P4DChp27T3di+NTiWn7QaNRgNNe+Q9hr
         jFgQ==
X-Gm-Message-State: AO0yUKXxdUVKmAp+6v9DlIzgApb4gGCiq84tWXeljRmgNo0K+CyfQCLd
        Jyh+LFGHt5PZa4BXTqhCqKqg9g==
X-Google-Smtp-Source: AK7set+GSVUL8t2kstOPArFwcKWIRajlkBT610ShNArrVGOJGOk5DsdDySSxduqsq1T9rnAQXWYMtw==
X-Received: by 2002:a17:90b:4f84:b0:233:ca48:540b with SMTP id qe4-20020a17090b4f8400b00233ca48540bmr16902419pjb.3.1678225700429;
        Tue, 07 Mar 2023 13:48:20 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id z6-20020a17090abd8600b00233b18e6fb3sm7731237pjr.1.2023.03.07.13.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 13:48:20 -0800 (PST)
Date:   Tue, 07 Mar 2023 13:48:20 -0800 (PST)
X-Google-Original-Date: Tue, 07 Mar 2023 13:47:30 PST (-0800)
Subject:     Re: [PATCH v2 3/4] riscv: dts: starfive: Add crypto and DMA node for VisionFive 2
In-Reply-To: <20230130154242.112613-4-jiajie.ho@starfivetech.com>
CC:     herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kernel@esmil.dk, Conor Dooley <conor.dooley@microchip.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jiajie.ho@starfivetech.com
Message-ID: <mhng-c02e5405-6c88-4709-b4b0-80baae83584a@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, 30 Jan 2023 07:42:41 PST (-0800), jiajie.ho@starfivetech.com wrote:
> Add StarFive cryptographic module and dedicated DMA controller node to
> VisionFive 2 SoCs.
>
> Co-developed-by: Huan Feng <huan.feng@starfivetech.com>
> Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
> Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 27 ++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index 4ac159d79d66..bb134a8a89c9 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -455,5 +455,32 @@ uart5: serial@12020000 {
>  			reg-shift = <2>;
>  			status = "disabled";
>  		};
> +
> +		sdma: dma@16008000 {
> +			compatible = "arm,pl080", "arm,primecell";
> +			arm,primecell-periphid = <0x00041080>;
> +			reg = <0x0 0x16008000 0x0 0x4000>;
> +			interrupts = <29>;
> +			clocks = <&stgcrg JH7110_STGCLK_SEC_HCLK>,
> +				 <&stgcrg JH7110_STGCLK_SEC_MISCAHB>;
> +			clock-names = "hclk", "apb_pclk";
> +			resets = <&stgcrg JH7110_STGRST_SEC_TOP_HRESETN>;
> +			lli-bus-interface-ahb1;
> +			mem-bus-interface-ahb1;
> +			memcpy-burst-size = <256>;
> +			memcpy-bus-width = <32>;
> +			#dma-cells = <2>;
> +		};
> +
> +		crypto: crypto@16000000 {
> +			compatible = "starfive,jh7110-crypto";
> +			reg = <0x0 0x16000000 0x0 0x4000>;
> +			clocks = <&stgcrg JH7110_STGCLK_SEC_HCLK>,
> +				 <&stgcrg JH7110_STGCLK_SEC_MISCAHB>;
> +			clock-names = "hclk", "ahb";
> +			resets = <&stgcrg JH7110_STGRST_SEC_TOP_HRESETN>;
> +			dmas = <&sdma 1 2>, <&sdma 0 2>;
> +			dma-names = "tx", "rx";
> +		};
>  	};
>  };

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

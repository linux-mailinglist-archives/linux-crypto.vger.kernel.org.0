Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589464AC509
	for <lists+linux-crypto@lfdr.de>; Mon,  7 Feb 2022 17:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241682AbiBGQHY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 7 Feb 2022 11:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377838AbiBGP5A (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 7 Feb 2022 10:57:00 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE553C0401CC
        for <linux-crypto@vger.kernel.org>; Mon,  7 Feb 2022 07:56:59 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A370A4003B
        for <linux-crypto@vger.kernel.org>; Mon,  7 Feb 2022 15:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644249418;
        bh=3KCJtIIAHid1u1Ypwj6pcJ1BKiFWLA7ETi2tEpWd/KM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=d3zYrg8/QwD5CAPs29nqw1oSk42TU4EDHDXDvbIJfOkP3OHO0KGY5Ay4x3iBxtmhR
         bo0lvQiVA1GRvjqzCWdEk5l5ggl53NysepRAOzq60aEQJ4h4k8QmE9XsvYz/zNlprS
         alcWO5kK9g+EJ67kQvqcffhUV6djdDrCveI5+4F7qLGqx5y0mEUFxqap3rhajbuuRK
         Q/7hp5dwu7dPnL8NbT2mMCYj8UgAOk6pbeI9vluwK0geu2zGIlDNyr6vHBiSCPC8dI
         fchcJ8zu5gC2jXXv7U67H5/qq9CGhQuoelrVJ07dEFL/Qzx8YDk86O9mx5gMnDY+XS
         RYsNGfgCHR8/A==
Received: by mail-ej1-f69.google.com with SMTP id l18-20020a1709063d3200b006a93f7d4941so4510075ejf.1
        for <linux-crypto@vger.kernel.org>; Mon, 07 Feb 2022 07:56:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3KCJtIIAHid1u1Ypwj6pcJ1BKiFWLA7ETi2tEpWd/KM=;
        b=Hg2eZ2TiOcxL2yUvIurFh6RAvF4pu8nM6gN8VdxVgqmlvcMsHVM+AaUzV5UZG/dEcS
         BtnlwJ1J5FzalNSGfpoVkyllPqYijOeuRAoTYFNNKyZgp1qkUW19h0Ydu2IeuJbkapfB
         DmGCI87zSOG55SK0IWw3Te1hn9QIqe6X0ZqVV6x83KOY3WcO3eCXUbn5g77dUtxUUiuE
         +dsmotxIoBD1dTW+LjZ4DZi6kANAhGouGjH+JohBNtoE4cW8hCd4YznOrG5FHfZ/0eHP
         EHk3MV1bP38BXc6pLIMRqW9Z5uhVni/aad/J0nkecehvP7hGB5KW6l3L43Uze5S1grAd
         kp6w==
X-Gm-Message-State: AOAM5328IvFQd5oTRA4epxfvDkhUNzSllscQ2Veghy+8YIw58EIMUMu+
        qiWYu6JaRXK54j6kNVA5l6ABdBHhwwt5H+lQpB/CuOd8bpJOzXXY8vsPpj/QsAGyNoLiydyHx5D
        Y9jL5ikKBdaBuOfnZV07KDfvToQ/3OQnVCXfzGeL7Jw==
X-Received: by 2002:a17:907:ca6:: with SMTP id gi38mr290862ejc.353.1644249418353;
        Mon, 07 Feb 2022 07:56:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNtGmRyRii7O51uydqBLa9NhyKzrDOTW8Z28l8gq9kBDum2SUHT7YCiJHTkDya3nBusEaO7g==
X-Received: by 2002:a17:907:ca6:: with SMTP id gi38mr290850ejc.353.1644249418176;
        Mon, 07 Feb 2022 07:56:58 -0800 (PST)
Received: from [192.168.0.90] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id v19sm3356879edw.39.2022.02.07.07.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 07:56:57 -0800 (PST)
Message-ID: <f8387f12-24f9-4a39-e9b8-3b83f1de078d@canonical.com>
Date:   Mon, 7 Feb 2022 16:56:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] dt-bindings: crypto: Convert Atmel AES to yaml
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        herbert@gondor.apana.org.au, robh+dt@kernel.org
Cc:     davem@davemloft.net, nicolas.ferre@microchip.com,
        claudiu.beznea@microchip.com, alexandre.belloni@bootlin.com,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220207032405.70733-1-tudor.ambarus@microchip.com>
 <20220207032405.70733-2-tudor.ambarus@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220207032405.70733-2-tudor.ambarus@microchip.com>
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

On 07/02/2022 04:24, Tudor Ambarus wrote:
> Convert Atmel AES documentation to yaml format. With the conversion the
> clock and clock-names properties are made mandatory. The driver returns
> -EINVAL if "aes_clk" is not found, reflect that in the bindings and make
> the clock and clock-names properties mandatory. Update the example to
> better describe how one should define the dt node.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  .../devicetree/bindings/crypto/atmel,aes.yaml | 65 +++++++++++++++++++
>  .../bindings/crypto/atmel-crypto.txt          | 20 ------
>  2 files changed, 65 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/crypto/atmel,aes.yaml
> 
> diff --git a/Documentation/devicetree/bindings/crypto/atmel,aes.yaml b/Documentation/devicetree/bindings/crypto/atmel,aes.yaml
> new file mode 100644
> index 000000000000..f77ec04dbabe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/atmel,aes.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/crypto/atmel,aes.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel Advanced Encryption Standard (AES) HW cryptographic accelerator
> +
> +maintainers:
> +  - Tudor Ambarus <tudor.ambarus@microchip.com>
> +
> +properties:
> +  compatible:
> +    const: atmel,at91sam9g46-aes
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: aes_clk
> +
> +  dmas:
> +    items:
> +      - description: TX DMA Channel
> +      - description: RX DMA Channel
> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - dmas
> +  - dma-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/at91.h>
> +    #include <dt-bindings/dma/at91.h>

One empty line for readability.

> +    aes: aes@f8038000 {

Generic node name, so "crypto".

> +      compatible = "atmel,at91sam9g46-aes";
> +      reg = <0xe1810000 0x100>;
> +      interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&pmc PMC_TYPE_PERIPHERAL 27>;
> +      clock-names = "aes_clk";
> +      dmas = <&dma0 AT91_XDMAC_DT_PERID(1)>,
> +             <&dma0 AT91_XDMAC_DT_PERID(2)>;
> +      dma-names = "tx", "rx";
> +      status= "okay";
> +    };

Drop the status property.

Best regards,
Krzysztof

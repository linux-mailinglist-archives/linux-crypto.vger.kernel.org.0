Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC7A6603A8
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Jan 2023 16:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjAFPp1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 6 Jan 2023 10:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjAFPp0 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 6 Jan 2023 10:45:26 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962B46DBB3
        for <linux-crypto@vger.kernel.org>; Fri,  6 Jan 2023 07:45:24 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s5so2692930edc.12
        for <linux-crypto@vger.kernel.org>; Fri, 06 Jan 2023 07:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VoWsHDbgF7d4naag7KiOSwAw6taeTKQG9cbHgJ97+VU=;
        b=W45pN3AFGnH+GXrfyyQM0fnd1RpOlcJ+g6li4CKTUiWRt2b9Yt6k7IL50GCJ1d19oN
         pq5q4ZLSOGn8JTvSo1M4Mhs09VPFQ68byJewuMl2unhcyrXKqocIo7fH8oipP/OaXenh
         RDSMJXwOtBWa7wBy0Qdi5sjO5ejac1Rb/bZIRFAj7Vsr0odAOO5ztAi55+2+K3+E9Slz
         LXll49+aI7Q6Uk2bi1D4Ax5TTBKymY4CqNY8EhiFM087mSQC93lBHY+YT0BG+hWRtEvH
         nXru+g05DajsMS0rrqv16AMHRgCkVOoEPqPjjh+aXrep06ItzNZTmiW2j74mT14E9Lhj
         XtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VoWsHDbgF7d4naag7KiOSwAw6taeTKQG9cbHgJ97+VU=;
        b=yipSarpwXqd5u9iT1YGGWKRGChC6QOprSH8lm2zkGIBIc8bnTzBu1clgQUnvlaZ6Q9
         hME6S/snRLbW04TwHP5QmNR1j5XprQ7qTn9D1ejuTk400ChOjKYlYHOXl2o+V5W2taQk
         Gu+Z4xLPWDNAUs74CFzqDAL1zGDUBkpSFFYkiafMc82jGmwYmQE8KTq9RuW5XPW8WhGl
         suPDV40EYA5jeOaAcaN0KfjTBFzK8PonU8To7pXvVqQ7KcMwYVDgkKrFvGn1lbnD4PF9
         uQy3KlBb1WvTqg4SiwKalKkstfG1YtS1Ohf5jAP/Zw9KUL/q+4iPNSuMb6Oq+14s/W8j
         BCdQ==
X-Gm-Message-State: AFqh2ko9uNBbVrp+ePOJvRjwf/9qeggm5UnkG5tq0yt1hx0psQ1M5Yqw
        W0zm/q9/dyoJMfhsE0AqgyBcPg==
X-Google-Smtp-Source: AMrXdXugbB26ZkfaH0NsOnnZ+txgk0mUgVPZ2wwx5sr3bbCUi2ohYcwQRrugp9DHu/RnIHx8DgUu5g==
X-Received: by 2002:aa7:cb4b:0:b0:491:3a5c:6e2 with SMTP id w11-20020aa7cb4b000000b004913a5c06e2mr7535330edt.5.1673019923096;
        Fri, 06 Jan 2023 07:45:23 -0800 (PST)
Received: from [192.168.0.104] ([82.77.81.242])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7c90f000000b004615f7495e0sm607442edt.8.2023.01.06.07.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 07:45:22 -0800 (PST)
Message-ID: <678ad800-7a3b-e2bf-6428-f06d696d8edb@linaro.org>
Date:   Fri, 6 Jan 2023 17:45:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] MAINTAINERS: Update email of Tudor Ambarus
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     arnd@arndb.de, richard@nod.at, miquel.raynal@bootlin.com
Cc:     krzysztof.kozlowski+dt@linaro.org, herbert@gondor.apana.org.au,
        robh+dt@kernel.org, akpm@linux-foundation.org,
        nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, pratyush@kernel.org,
        michael@walle.cc, Tudor Ambarus <tudor.ambarus@microchip.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20221226144043.367706-1-tudor.ambarus@linaro.org>
 <feb09bac-0ea4-9154-362b-6d81cba352a8@linaro.org>
In-Reply-To: <feb09bac-0ea4-9154-362b-6d81cba352a8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Miquel,

Since we don't have an answer from Arnd, would you please queue this to
mtd/fixes?

Thanks,
ta

On 26.12.2022 16:49, Tudor Ambarus wrote:
> Hi, Arnd,
> 
> We have all the required Acked-by tags to queue this patch. Do you still
> plan to take it throught the SoC fixes branch? The alternative is to
> queue it to mtd/fixes.
> 
> Thanks,
> ta
> 
> On 26.12.2022 16:40, Tudor Ambarus wrote:
>> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>>
>> My professional email will change and the microchip one will bounce after
>> mid-november of 2022.
>>
>> Update the MAINTAINERS file, the YAML bindings, MODULE_AUTHOR entries and
>> author mentions, and add an entry in the .mailmap file.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Acked-by: Pratyush Yadav <pratyush@kernel.org>
>> Acked-by: Mark Brown <broonie@kernel.org>
>> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>> v2: rebase on top of v6.2-rc1, collect Acked-by tags.
>>
>>   .mailmap                                               |  1 +
>>   .../bindings/crypto/atmel,at91sam9g46-aes.yaml         |  2 +-
>>   .../bindings/crypto/atmel,at91sam9g46-sha.yaml         |  2 +-
>>   .../bindings/crypto/atmel,at91sam9g46-tdes.yaml        |  2 +-
>>   .../devicetree/bindings/spi/atmel,at91rm9200-spi.yaml  |  2 +-
>>   .../devicetree/bindings/spi/atmel,quadspi.yaml         |  2 +-
>>   MAINTAINERS                                            | 10 +++++-----
>>   drivers/crypto/atmel-ecc.c                             |  4 ++--
>>   drivers/crypto/atmel-i2c.c                             |  4 ++--
>>   drivers/crypto/atmel-i2c.h                             |  2 +-
>>   10 files changed, 16 insertions(+), 15 deletions(-)
>>
>> diff --git a/.mailmap b/.mailmap
>> index ccba4cf0d893..562f70d3b6a5 100644
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -422,6 +422,7 @@ Tony Luck <tony.luck@intel.com>
>>   TripleX Chung <xxx.phy@gmail.com> <triplex@zh-kernel.org>
>>   TripleX Chung <xxx.phy@gmail.com> <zhongyu@18mail.cn>
>>   Tsuneo Yoshioka <Tsuneo.Yoshioka@f-secure.com>
>> +Tudor Ambarus <tudor.ambarus@linaro.org> <tudor.ambarus@microchip.com>
>>   Tycho Andersen <tycho@tycho.pizza> <tycho@tycho.ws>
>>   Tzung-Bi Shih <tzungbi@kernel.org> <tzungbi@google.com>
>>   Uwe Kleine-König <ukleinek@informatik.uni-freiburg.de>
>> diff --git 
>> a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml 
>> b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
>> index 0ccaab16dc61..0b7383b3106b 100644
>> --- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
>> +++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
>> @@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>>   title: Atmel Advanced Encryption Standard (AES) HW cryptographic 
>> accelerator
>>   maintainers:
>> -  - Tudor Ambarus <tudor.ambarus@microchip.com>
>> +  - Tudor Ambarus <tudor.ambarus@linaro.org>
>>   properties:
>>     compatible:
>> diff --git 
>> a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml 
>> b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
>> index 5163c51b4547..ee2ffb034325 100644
>> --- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
>> +++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
>> @@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>>   title: Atmel Secure Hash Algorithm (SHA) HW cryptographic accelerator
>>   maintainers:
>> -  - Tudor Ambarus <tudor.ambarus@microchip.com>
>> +  - Tudor Ambarus <tudor.ambarus@linaro.org>
>>   properties:
>>     compatible:
>> diff --git 
>> a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml 
>> b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
>> index fcc5adf03cad..3d6ed24b1b00 100644
>> --- 
>> a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
>> +++ 
>> b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
>> @@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>>   title: Atmel Triple Data Encryption Standard (TDES) HW cryptographic 
>> accelerator
>>   maintainers:
>> -  - Tudor Ambarus <tudor.ambarus@microchip.com>
>> +  - Tudor Ambarus <tudor.ambarus@linaro.org>
>>   properties:
>>     compatible:
>> diff --git 
>> a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml 
>> b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
>> index 4dd973e341e6..6c57dd6c3a36 100644
>> --- a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
>> @@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>>   title: Atmel SPI device
>>   maintainers:
>> -  - Tudor Ambarus <tudor.ambarus@microchip.com>
>> +  - Tudor Ambarus <tudor.ambarus@linaro.org>
>>   allOf:
>>     - $ref: spi-controller.yaml#
>> diff --git a/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml 
>> b/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
>> index 1d493add4053..b0d99bc10535 100644
>> --- a/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
>> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>>   title: Atmel Quad Serial Peripheral Interface (QSPI)
>>   maintainers:
>> -  - Tudor Ambarus <tudor.ambarus@microchip.com>
>> +  - Tudor Ambarus <tudor.ambarus@linaro.org>
>>   allOf:
>>     - $ref: spi-controller.yaml#
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index f61eb221415b..8fa9386559f8 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13620,7 +13620,7 @@ F:    arch/microblaze/
>>   MICROCHIP AT91 DMA DRIVERS
>>   M:    Ludovic Desroches <ludovic.desroches@microchip.com>
>> -M:    Tudor Ambarus <tudor.ambarus@microchip.com>
>> +M:    Tudor Ambarus <tudor.ambarus@linaro.org>
>>   L:    linux-arm-kernel@lists.infradead.org (moderated for 
>> non-subscribers)
>>   L:    dmaengine@vger.kernel.org
>>   S:    Supported
>> @@ -13665,7 +13665,7 @@ F:    
>> Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
>>   F:    drivers/media/platform/microchip/microchip-csi2dc.c
>>   MICROCHIP ECC DRIVER
>> -M:    Tudor Ambarus <tudor.ambarus@microchip.com>
>> +M:    Tudor Ambarus <tudor.ambarus@linaro.org>
>>   L:    linux-crypto@vger.kernel.org
>>   S:    Maintained
>>   F:    drivers/crypto/atmel-ecc.*
>> @@ -13762,7 +13762,7 @@ S:    Maintained
>>   F:    drivers/mmc/host/atmel-mci.c
>>   MICROCHIP NAND DRIVER
>> -M:    Tudor Ambarus <tudor.ambarus@microchip.com>
>> +M:    Tudor Ambarus <tudor.ambarus@linaro.org>
>>   L:    linux-mtd@lists.infradead.org
>>   S:    Supported
>>   F:    Documentation/devicetree/bindings/mtd/atmel-nand.txt
>> @@ -13814,7 +13814,7 @@ S:    Supported
>>   F:    drivers/power/reset/at91-sama5d2_shdwc.c
>>   MICROCHIP SPI DRIVER
>> -M:    Tudor Ambarus <tudor.ambarus@microchip.com>
>> +M:    Tudor Ambarus <tudor.ambarus@linaro.org>
>>   S:    Supported
>>   F:    drivers/spi/spi-atmel.*
>> @@ -19664,7 +19664,7 @@ F:    drivers/clk/spear/
>>   F:    drivers/pinctrl/spear/
>>   SPI NOR SUBSYSTEM
>> -M:    Tudor Ambarus <tudor.ambarus@microchip.com>
>> +M:    Tudor Ambarus <tudor.ambarus@linaro.org>
>>   M:    Pratyush Yadav <pratyush@kernel.org>
>>   R:    Michael Walle <michael@walle.cc>
>>   L:    linux-mtd@lists.infradead.org
>> diff --git a/drivers/crypto/atmel-ecc.c b/drivers/crypto/atmel-ecc.c
>> index 53100fb9b07b..12205e2b53b4 100644
>> --- a/drivers/crypto/atmel-ecc.c
>> +++ b/drivers/crypto/atmel-ecc.c
>> @@ -3,7 +3,7 @@
>>    * Microchip / Atmel ECC (I2C) driver.
>>    *
>>    * Copyright (c) 2017, Microchip Technology Inc.
>> - * Author: Tudor Ambarus <tudor.ambarus@microchip.com>
>> + * Author: Tudor Ambarus
>>    */
>>   #include <linux/delay.h>
>> @@ -411,6 +411,6 @@ static void __exit atmel_ecc_exit(void)
>>   module_init(atmel_ecc_init);
>>   module_exit(atmel_ecc_exit);
>> -MODULE_AUTHOR("Tudor Ambarus <tudor.ambarus@microchip.com>");
>> +MODULE_AUTHOR("Tudor Ambarus");
>>   MODULE_DESCRIPTION("Microchip / Atmel ECC (I2C) driver");
>>   MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/crypto/atmel-i2c.c b/drivers/crypto/atmel-i2c.c
>> index 81ce09bedda8..55bff1e13142 100644
>> --- a/drivers/crypto/atmel-i2c.c
>> +++ b/drivers/crypto/atmel-i2c.c
>> @@ -3,7 +3,7 @@
>>    * Microchip / Atmel ECC (I2C) driver.
>>    *
>>    * Copyright (c) 2017, Microchip Technology Inc.
>> - * Author: Tudor Ambarus <tudor.ambarus@microchip.com>
>> + * Author: Tudor Ambarus
>>    */
>>   #include <linux/bitrev.h>
>> @@ -390,6 +390,6 @@ static void __exit atmel_i2c_exit(void)
>>   module_init(atmel_i2c_init);
>>   module_exit(atmel_i2c_exit);
>> -MODULE_AUTHOR("Tudor Ambarus <tudor.ambarus@microchip.com>");
>> +MODULE_AUTHOR("Tudor Ambarus");
>>   MODULE_DESCRIPTION("Microchip / Atmel ECC (I2C) driver");
>>   MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/crypto/atmel-i2c.h b/drivers/crypto/atmel-i2c.h
>> index 48929efe2a5b..35f7857a7f7c 100644
>> --- a/drivers/crypto/atmel-i2c.h
>> +++ b/drivers/crypto/atmel-i2c.h
>> @@ -1,7 +1,7 @@
>>   /* SPDX-License-Identifier: GPL-2.0 */
>>   /*
>>    * Copyright (c) 2017, Microchip Technology Inc.
>> - * Author: Tudor Ambarus <tudor.ambarus@microchip.com>
>> + * Author: Tudor Ambarus
>>    */
>>   #ifndef __ATMEL_I2C_H__

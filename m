Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042A0479047
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Dec 2021 16:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhLQPrm (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 17 Dec 2021 10:47:42 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60688
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235533AbhLQPrl (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 17 Dec 2021 10:47:41 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 67EBB3FFCF
        for <linux-crypto@vger.kernel.org>; Fri, 17 Dec 2021 15:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639756060;
        bh=hhDHhyLf8ciLV/pb2fq9VsORYOGJ7hjmmAlIVCJH7WY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=aQq7/hCGPbFg/bKpuDhxmMdGsPCz2nESFfYYOtxbUGf73njWF2ysqdelDGWVTPYjN
         0qPGbVq69gfCb+TJiTc4RBMJAwqw/XmYWIC7IDNwShAYaQEsDGg/If/avYIbe9j3aC
         m306ygumpQ8/zdLkEk/qCZVciqFtXmn+HaaPlBnd4vm6SaV3gB6culYsSxyb0SliYx
         24hxS+QbqY/cKNblCEeRAaX+cqkJBCOcG9iZ7XolZbcdZhYQtlzjDDyW5Z8PuiT0+x
         JVYiDJIDuaDk3A7gxyWo3ss4JVIAYA3zuBmyunmU860NYPJwTe+lNYo2rOlZH4EokP
         qsbhx7QFxTwLg==
Received: by mail-lj1-f200.google.com with SMTP id q19-20020a05651c055300b0021a259ae8bbso826795ljp.4
        for <linux-crypto@vger.kernel.org>; Fri, 17 Dec 2021 07:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hhDHhyLf8ciLV/pb2fq9VsORYOGJ7hjmmAlIVCJH7WY=;
        b=SwID/mxxpPlNvy/7o5S2Ax7swG5tcg9zAphcoVy4cqJMf2mzgGd9lBoWflfvla9HlG
         gejmHx/4W5Jr5bPP+1vLRA8v/wopAlCtojjvD5FJpyG3s1k+zAZm/uZHaTZar8Rhq6nX
         nIAWub8AG/aYNppLYdEWNVkOOqh9gvm4jp4ZEczv31Yj2qK3qrDte/b/XmDJLiIu93wT
         7XLA+FmFbbg3AUxzRPIlZP8lW7h3FH/MfaRGLk8Htu9fojORwIYJmg7oGYu3kB64Tv6Y
         8DFfpX9/QvqcPmOlS5c01P6xY0h49G5CXNfE9xhjSEpwR/X2JBDQKmZYMSQi23i17ydR
         C5Wg==
X-Gm-Message-State: AOAM5326oCpZzNxrDi/ZDjzbU57d+cGuuYsE9WIKgx+SFol3yPjjJt3U
        sOvHfKIVnHeVcE1F1+FUHtLHZFuf7FP0oMWga/aWM/+k7rn4BMiVHlZGmbp9ETrrnkcq5WSVDfC
        LQ1qGsQPf880+L1x17cDxp/6m0tJxlcaFKbK8IabxuQ==
X-Received: by 2002:a05:6512:2150:: with SMTP id s16mr3408757lfr.519.1639756059693;
        Fri, 17 Dec 2021 07:47:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwt9tJHIq/B3JqqY9RpHltS5AsBubgidwCcIwxibp52U1LQxYs+vVjkCeSXk+SDsWN3QzhEUw==
X-Received: by 2002:a05:6512:2150:: with SMTP id s16mr3408731lfr.519.1639756059505;
        Fri, 17 Dec 2021 07:47:39 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id w25sm356919lfl.33.2021.12.17.07.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 07:47:39 -0800 (PST)
Message-ID: <2e7588e5-9dc5-571f-d7e9-0ee5c89ab39e@canonical.com>
Date:   Fri, 17 Dec 2021 16:47:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 06/17] dt-bindings: rng: add bindings for microchip
 mpfs rng
Content-Language: en-US
To:     Conor.Dooley@microchip.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     geert@linux-m68k.org, bin.meng@windriver.com, heiko@sntech.de,
        Lewis.Hanly@microchip.com, Daire.McNamara@microchip.com,
        Ivan.Griffin@microchip.com, atish.patra@wdc.com
References: <20211217093325.30612-1-conor.dooley@microchip.com>
 <20211217093325.30612-7-conor.dooley@microchip.com>
 <e59a60d5-4397-1f7f-66ab-3dd522e166a0@canonical.com>
 <19cbe2ba-7df5-7c7c-289f-6dc419d9f477@canonical.com>
 <422126ac-ce26-2940-5b4d-fe79a1fa89c5@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <422126ac-ce26-2940-5b4d-fe79a1fa89c5@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 17/12/2021 16:22, Conor.Dooley@microchip.com wrote:
> On 17/12/2021 15:07, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 17/12/2021 15:53, Krzysztof Kozlowski wrote:
>>> On 17/12/2021 10:33, conor.dooley@microchip.com wrote:
>>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>>
>>>> Add device tree bindings for the hardware rng device accessed via
>>>> the system services on the Microchip PolarFire SoC.
>>>>
>>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>>>> ---
>>>>   .../bindings/rng/microchip,mpfs-rng.yaml      | 29 +++++++++++++++++++
>>>>   1 file changed, 29 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/rng/microchip,mpfs-rng.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/rng/microchip,mpfs-rng.yaml b/Documentation/devicetree/bindings/rng/microchip,mpfs-rng.yaml
>>>> new file mode 100644
>>>> index 000000000000..32cbc37c9292
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/rng/microchip,mpfs-rng.yaml
>>>> @@ -0,0 +1,29 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: "http://devicetree.org/schemas/rng/microchip,mpfs-rng.yaml#"
>>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>>> +
>>>> +title: Microchip MPFS random number generator
>>>> +
>>>> +maintainers:
>>>> +  - Conor Dooley <conor.dooley@microchip.com>
>>>> +
>>>> +description: |
>>>> +  The hardware random number generator on the Polarfire SoC is
>>>> +  accessed via the mailbox interface provided by the system controller
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: microchip,mpfs-rng
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    hwrandom: hwrandom {
>>>
>>> Three topics:
>>> 1. Node name (as most of others are using): rng
>>> 2. skip the label, not helping in example.
>>> 3. This looks very simple, so I wonder if the bindings are complete. No
>>> IO space/address... How is it going to be instantiated?
>>>
>>
>> OK, now I saw the usage in DTS. I have doubts this makes sense as
>> separate bindings. It looks like integrated part of syscontroller, so
>> maybe make it part of that binding? Or at least add ref to syscontroller
>> bindings that such child is expected.
> Acking the rest of this, re: adding the ref: is what is being done in 
> patch 03/17 insufficient?

Ops, I missed the 03/17. Yeah, it looks it is sufficient and in such
case I think you do not need this patch. The compatible is documented in
03/17. The same for sysserv.


Best regards,
Krzysztof

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B4F322F8B
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Feb 2021 18:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbhBWRW5 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 23 Feb 2021 12:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbhBWRW4 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 23 Feb 2021 12:22:56 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CCEC06178A;
        Tue, 23 Feb 2021 09:22:15 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id x16so3183547wmk.3;
        Tue, 23 Feb 2021 09:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=EaX5p5UPuTekYiXa10smOCPJuQoIdYNBNNKlPwDQoIw=;
        b=L2ExbvjtqbSYd6Z4BLFj7QppJJtr04m2tmQa4eq/AdspS/bMn6RGU0ab6qYxp37rjM
         jXq8pZE08iisojwN+2NcgiMtCzBgetBCIXbLjX7UQ3hDn0lF/2s+1EuvESH6ScTZiRmY
         scESElzSej0ZbOhuQu2avYH335ihr19oPxQpgxSMqh1VoyQo0VSp9p1NRkcKOOSdoGR5
         4J201N79nc/t4eYe3QCx8TintIeOMSxWndKm9IRPqTU4cM1uN9pJNNeAl4rhRQWG8r1R
         f65nW8jnp+GvOgx6l30YfXl9wBoe3kr3RS7z7wBgLn65ZfTFx2DnamZrcbI8a9z+kewg
         IRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EaX5p5UPuTekYiXa10smOCPJuQoIdYNBNNKlPwDQoIw=;
        b=qryaimKT8YeLDxGr5kBSyaBXj+GTmS+KB4PDG4v3cfYJ0aJ9qAhfMLPs/bSdPQm+br
         UlZYKJ4Yd4wsZFVNKU9mGdacOezNw4CbJT1gKf16k6vgH+voalmpbj19koUfzs9Ih9K3
         /CbJDKWic1ucPUUUFXp6aoMKzixrzSYPvDcWmbA9NLIBBYlC107F/8y6XQ50/aSN0xkg
         qoFnbkgwGG0HIJ6YSn6wp23nJKmJVGKV4/ubs8OCv5xzGdzTPyn0G4VDjv4Pw5vFD5xE
         CqPd7qqNLYOcRgV7ErWyyZ11hIzDjjEEmLKOh9hxiMxpWo6xPCQp1Mu+0FI78VjyGwrz
         6UYw==
X-Gm-Message-State: AOAM532t8htQHnCQjckl3KT5M3xjGg8Y2r2d5gRX2STI14KjuaQyGlmA
        M66/NDGyPUgxpwPSNvc6svsp2DSpSjeL9Poi
X-Google-Smtp-Source: ABdhPJymfVnvLYj6gmqlN/GCzYyIAkPBbG7VFBpvS13m6zCAi9+YtXqstsO2jMc2r/8H8q4zIFN2zA==
X-Received: by 2002:a1c:ba05:: with SMTP id k5mr24935188wmf.111.1614100934162;
        Tue, 23 Feb 2021 09:22:14 -0800 (PST)
Received: from [192.168.1.10] (170.red-88-1-105.dynamicip.rima-tde.net. [88.1.105.170])
        by smtp.gmail.com with ESMTPSA id m4sm17653589wrb.87.2021.02.23.09.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 09:22:13 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: rng: bcm2835: document reset support
To:     Scott Branden <scott.branden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@protonmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210222194510.14004-1-noltari@gmail.com>
 <20210223160131.29053-1-noltari@gmail.com>
 <20210223160131.29053-2-noltari@gmail.com>
 <1b854f38-9322-71ee-5745-ee650ae92c9b@gmail.com>
 <23b28f9f-786d-8cdc-338f-efb4b23020a9@broadcom.com>
From:   =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>
Message-ID: <110b59a6-2359-89e1-5f20-7d2e1fd32a2f@gmail.com>
Date:   Tue, 23 Feb 2021 18:22:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <23b28f9f-786d-8cdc-338f-efb4b23020a9@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hello Scott,

El 23/02/2021 a las 18:17, Scott Branden escribió:
> On 2021-02-23 8:36 a.m., Florian Fainelli wrote:
>>
>>
>> On 2/23/2021 8:01 AM, Álvaro Fernández Rojas wrote:
>>> Some devices may need to perform a reset before using the RNG, such as the
>>> BCM6368.
>>>
>>> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
>>
>> Since the reset is unique to the 6368, you may want to make the property
>> mandatory for the 6368 compatible string and optional otherwise.
>>
> Perhaps the reset could be done at an earlier boot stage as well and then the
> reset would even be optional on 6368?
> 

No, this isn't possible on bmips, which is device tree only.
However, it's how is done in bcm63xx, which is why it wasn't needed before.

Best regards,
Álvaro.

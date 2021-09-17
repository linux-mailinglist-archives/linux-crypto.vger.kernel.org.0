Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E3240FEA8
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Sep 2021 19:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhIQRbl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 17 Sep 2021 13:31:41 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:43668
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231855AbhIQRbl (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 17 Sep 2021 13:31:41 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5FCF740267
        for <linux-crypto@vger.kernel.org>; Fri, 17 Sep 2021 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631899816;
        bh=3S5XrNnYw9mQJ4cjT/e6jDqp9tZbCCKdg1eBLA71yrk=;
        h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=UVqnVfwwvYwT/zJLKaa+0p2a6PeBRTM39+n+05gVWgCbY6mDdt0oLzN2C1nQ9Oto0
         HiUlJuUwp9XxwpzHZLrjB4SLnYgAaKsKM+w249drt/Gou3i6rGFzpOm3UkN+RnMixG
         Zq9KHOAfT/7QjGyEkchayA+UIm5UZJkRI9+cgKWJSm4fErKX6OGv9nNPmN0RzO54XZ
         O/Vz4C/TugdtFBMWzBPsEQ2ouLDtmfpUgf3tkV6kZa38PQ0dpOEqhAktC1HHy+uFyV
         TulIteDXOps4962wTqoX1SXaijXwY9TRT5BGfcce2aovc3y2ZVC69t2fvCKAy/V0m6
         KyzKj2gsM6PdA==
Received: by mail-ed1-f69.google.com with SMTP id j6-20020aa7de86000000b003d4ddaf2bf9so9730496edv.7
        for <linux-crypto@vger.kernel.org>; Fri, 17 Sep 2021 10:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3S5XrNnYw9mQJ4cjT/e6jDqp9tZbCCKdg1eBLA71yrk=;
        b=iE7E+ACB2D73LEbLa0W/ablyJl8AxjNir8te+AL/TdRg1eSLjjgHwvZ/almCk0TlgD
         HQO7cp/eIyXNKxKUgxjLUz2odVq/nUaSematVpNmTkBUKKWq+rfpJ1hUq8XxMWYzp42V
         p9fbsr30snaBuCmahiJfwKZAMiJ8DSBHGICAnuM0d1DW4WIQrsGKoiSIXetT8VYT5fzP
         xwEedSSvKrX4qpl+u8bAi87h2XUMhnpA0Lin8ct775E3BrsZeob/l3xKu/UtDqcracrr
         N9JEFq9dPUC0gcC4FD/J7cNx5S6w4paO8l/RJCFXD5hK7DVF6Wi1J6w6DY1KFD+DJak6
         AZ0w==
X-Gm-Message-State: AOAM5328LyUcfHAr48VROS/B43Ad4qT5t9IcpDd1yx+D4Q/9/TmUf9PU
        CrrYcR5cfggY/Do+g6W2JwVTR0uiw6YDSvek8p/vRL26nF+3Ahm0xNHcMgLcJFGEJpafFvW0Jz3
        78RY4+vg92K055L1kBBzXY8k4WpHQe9NIK9h+BxZLyw==
X-Received: by 2002:a17:906:1901:: with SMTP id a1mr13618794eje.129.1631899812917;
        Fri, 17 Sep 2021 10:30:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6uxFprEP5pdPGxSMEoP4e68kWfQH6+/pyRv3QCyfNr+QpYMA4KCw6ooFAEX/F6xr37ENCKA==
X-Received: by 2002:a17:906:1901:: with SMTP id a1mr13618782eje.129.1631899812761;
        Fri, 17 Sep 2021 10:30:12 -0700 (PDT)
Received: from [192.168.2.211] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n15sm2926625edw.70.2021.09.17.10.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 10:30:12 -0700 (PDT)
Subject: Re: [RFC][PATCH] crypto: caam - Add missing MODULE_ALIAS
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Marek Vasut <marex@denx.de>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Cc:     "ch@denx.de" <ch@denx.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
References: <20210916134154.8764-1-marex@denx.de>
 <441a7e2e-7ac8-5000-72e0-3793ae7e58d5@canonical.com>
 <08afb147-07c7-9fbb-4a0c-8a79717b06b7@denx.de>
 <ea7e5aae-be43-057a-2710-fbcb57d40ddc@nxp.com>
 <a8900033-d84d-d741-7d72-b266f973e0d6@canonical.com>
 <bc94681c-58e5-8c6f-42d3-0e51ddd060c7@nxp.com>
 <77467cbf-afad-d7e1-5042-569d5a276c20@canonical.com>
Message-ID: <b1a68e04-b0ce-9610-9992-6eb2f110d36f@canonical.com>
Date:   Fri, 17 Sep 2021 19:30:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <77467cbf-afad-d7e1-5042-569d5a276c20@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 17/09/2021 18:21, Krzysztof Kozlowski wrote:
> On 17/09/2021 16:44, Horia Geantă wrote:
>> On 9/17/2021 1:33 PM, Krzysztof Kozlowski wrote:
>>> On 17/09/2021 11:51, Horia Geantă wrote:
>>>> On 9/16/2021 5:06 PM, Marek Vasut wrote:
>>>>> On 9/16/21 3:59 PM, Krzysztof Kozlowski wrote:
>>>>>> On 16/09/2021 15:41, Marek Vasut wrote:
>>>>>>> Add MODULE_ALIAS for caam and caam_jr modules, so they can be auto-loaded.
>>>>>>>
>>>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>>>> Cc: Herbert Xu <herbert@gondor.apana.org.au>
>>>>>>> Cc: Horia Geantă <horia.geanta@nxp.com>
>>>>>>> Cc: Iuliana Prodan <iuliana.prodan@nxp.com>
>>>>>>> Cc: Krzysztof Kozlowski <krzk@kernel.org>
>>>>>>> ---
>>>>>>>   drivers/crypto/caam/ctrl.c | 1 +
>>>>>>>   drivers/crypto/caam/jr.c   | 1 +
>>>>>>>   2 files changed, 2 insertions(+)
>>>>>>>
>>>>>>
>>>>>> Since you marked it as RFC, let me share a comment - would be nice to
>>>>>> see here explanation why do you need module alias.
>>>>>>
>>>>>> Drivers usually do not need module alias to be auto-loaded, unless the
>>>>>> subsystem/bus reports different alias than one used for binding. Since
>>>>>> the CAAM can bind only via OF, I wonder what is really missing here. Is
>>>>>> it a MFD child (it's one of cases this can happen)?
>>>>>
>>>>> I noticed the CAAM is not being auto-loaded on boot, and then I noticed 
>>>>> the MODULE_ALIAS fixes cropping up in the kernel log, but I couldn't 
>>>>> find a good documentation for that MODULE_ALIAS. So I was hoping to get 
>>>>> a feedback on it.
>>>>>
>>>> What platform are you using?
>>>>
>>>> "make modules_install" should take care of adding the proper aliases,
>>>> relying on the MODULE_DEVICE_TABLE() macro in the caam, caam_jr drivers.
>>>>
>>>> modules.alias file should contain:
>>>> alias of:N*T*Cfsl,sec4.0C* caam
>>>> alias of:N*T*Cfsl,sec4.0 caam
>>>> alias of:N*T*Cfsl,sec-v4.0C* caam
>>>> alias of:N*T*Cfsl,sec-v4.0 caam
>>>> alias of:N*T*Cfsl,sec4.0-job-ringC* caam_jr
>>>> alias of:N*T*Cfsl,sec4.0-job-ring caam_jr
>>>> alias of:N*T*Cfsl,sec-v4.0-job-ringC* caam_jr
>>>> alias of:N*T*Cfsl,sec-v4.0-job-ring caam_jr
>>>
>>> Marek added a platform alias which is not present here on the list
>>> (because there are no platform device IDs). The proper question is who
>>> requests this device via a platform match? Who sends such event?
>>>
>> AFAICS the platform bus adds the "platform:" alias to uevent env.
>> in its .uevent callback - platform_uevent().
>>
>> When caam (platform) device is added, the uevent is generated with this env.,
>> which contains both OF-style and "platform:" modaliases.
> 
> I am not saying about theoretical case, I know that platform bus will
> send platform uevent. How did this device end up in platform bus so this
> uevent is being sent? It should be instantiated from OF on for example
> amba bus or directly from OF FDT scanning.
> 
> Therefore I have the same question - who requests device via a platform
> match? Is it used out-of-tree in different configuration?

I tried to reproduce such situation in case of a board I have with me
(Exynos5422). I have a platform_driver only with of_device_id table. The
driver is built as module. In my DTS the device node is like
(exynos5.dtsi and device is modified exynos-chipid to be a module):

       soc: soc {
                compatible = "simple-bus";
                #address-cells = <1>;
                #size-cells = <1>;
                ranges;

                chipid: chipid@10000000 {
                        compatible = "samsung,exynos4210-chipid";
                        reg = <0x10000000 0x100>;
                };

		...
	};

The module was properly autoloaded (via OF aliases/events) and device
was matched.

Best regards,
Krzysztof

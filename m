Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8D1411607
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Sep 2021 15:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbhITNpX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 20 Sep 2021 09:45:23 -0400
Received: from phobos.denx.de ([85.214.62.61]:51278 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234964AbhITNpX (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 20 Sep 2021 09:45:23 -0400
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C185080EC5;
        Mon, 20 Sep 2021 15:43:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1632145435;
        bh=8VKqwQU2AAHWC8ArqFgvE45bUcox/BQk4bXFvGbFIiE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rXC5fQihBkcNP+3oO+U2/3Eg7+56ChzZTsBJWJLM3IT2znpiq4Nc/TmekTJ/vMCbm
         SolsDYdlZvd8Udptfex8A8vywzXiYsfwu5dsEIMC3wr+OxKuzRAhLMY0rj8kjScxYR
         Bz3SHK245/BLrODXow1yGfP7F5G9AZogaXouZjvUGkFQPKStRXC7GC7gjN1+pHybfj
         1/ACHXh3IwESj01YVE6BtnEW1pnUz+kBJ4PLdg8caQhjB0PuGhXitjIzSpVEgq81th
         tMiEY0y1RHjtgFGLxRgr/hQ58vnmKmDHxWorcZddC4e0m3VYZsFdunABxYzdMClzhJ
         JO1GtWa8+i2Fg==
Subject: Re: [RFC][PATCH] crypto: caam - Add missing MODULE_ALIAS
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
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
 <b1a68e04-b0ce-9610-9992-6eb2f110d36f@canonical.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <04c9705b-9fd8-dde1-33ee-fa58aad96d4a@denx.de>
Date:   Mon, 20 Sep 2021 15:43:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <b1a68e04-b0ce-9610-9992-6eb2f110d36f@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 9/17/21 7:30 PM, Krzysztof Kozlowski wrote:
> On 17/09/2021 18:21, Krzysztof Kozlowski wrote:
>> On 17/09/2021 16:44, Horia Geantă wrote:
>>> On 9/17/2021 1:33 PM, Krzysztof Kozlowski wrote:
>>>> On 17/09/2021 11:51, Horia Geantă wrote:
>>>>> On 9/16/2021 5:06 PM, Marek Vasut wrote:
>>>>>> On 9/16/21 3:59 PM, Krzysztof Kozlowski wrote:
>>>>>>> On 16/09/2021 15:41, Marek Vasut wrote:
>>>>>>>> Add MODULE_ALIAS for caam and caam_jr modules, so they can be auto-loaded.
>>>>>>>>
>>>>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>>>>> Cc: Herbert Xu <herbert@gondor.apana.org.au>
>>>>>>>> Cc: Horia Geantă <horia.geanta@nxp.com>
>>>>>>>> Cc: Iuliana Prodan <iuliana.prodan@nxp.com>
>>>>>>>> Cc: Krzysztof Kozlowski <krzk@kernel.org>
>>>>>>>> ---
>>>>>>>>    drivers/crypto/caam/ctrl.c | 1 +
>>>>>>>>    drivers/crypto/caam/jr.c   | 1 +
>>>>>>>>    2 files changed, 2 insertions(+)
>>>>>>>>
>>>>>>>
>>>>>>> Since you marked it as RFC, let me share a comment - would be nice to
>>>>>>> see here explanation why do you need module alias.
>>>>>>>
>>>>>>> Drivers usually do not need module alias to be auto-loaded, unless the
>>>>>>> subsystem/bus reports different alias than one used for binding. Since
>>>>>>> the CAAM can bind only via OF, I wonder what is really missing here. Is
>>>>>>> it a MFD child (it's one of cases this can happen)?
>>>>>>
>>>>>> I noticed the CAAM is not being auto-loaded on boot, and then I noticed
>>>>>> the MODULE_ALIAS fixes cropping up in the kernel log, but I couldn't
>>>>>> find a good documentation for that MODULE_ALIAS. So I was hoping to get
>>>>>> a feedback on it.
>>>>>>
>>>>> What platform are you using?
>>>>>
>>>>> "make modules_install" should take care of adding the proper aliases,
>>>>> relying on the MODULE_DEVICE_TABLE() macro in the caam, caam_jr drivers.
>>>>>
>>>>> modules.alias file should contain:
>>>>> alias of:N*T*Cfsl,sec4.0C* caam
>>>>> alias of:N*T*Cfsl,sec4.0 caam
>>>>> alias of:N*T*Cfsl,sec-v4.0C* caam
>>>>> alias of:N*T*Cfsl,sec-v4.0 caam
>>>>> alias of:N*T*Cfsl,sec4.0-job-ringC* caam_jr
>>>>> alias of:N*T*Cfsl,sec4.0-job-ring caam_jr
>>>>> alias of:N*T*Cfsl,sec-v4.0-job-ringC* caam_jr
>>>>> alias of:N*T*Cfsl,sec-v4.0-job-ring caam_jr
>>>>
>>>> Marek added a platform alias which is not present here on the list
>>>> (because there are no platform device IDs). The proper question is who
>>>> requests this device via a platform match? Who sends such event?
>>>>
>>> AFAICS the platform bus adds the "platform:" alias to uevent env.
>>> in its .uevent callback - platform_uevent().
>>>
>>> When caam (platform) device is added, the uevent is generated with this env.,
>>> which contains both OF-style and "platform:" modaliases.
>>
>> I am not saying about theoretical case, I know that platform bus will
>> send platform uevent. How did this device end up in platform bus so this
>> uevent is being sent? It should be instantiated from OF on for example
>> amba bus or directly from OF FDT scanning.
>>
>> Therefore I have the same question - who requests device via a platform
>> match? Is it used out-of-tree in different configuration?
> 
> I tried to reproduce such situation in case of a board I have with me
> (Exynos5422). I have a platform_driver only with of_device_id table. The
> driver is built as module. In my DTS the device node is like
> (exynos5.dtsi and device is modified exynos-chipid to be a module):
> 
>         soc: soc {
>                  compatible = "simple-bus";
>                  #address-cells = <1>;
>                  #size-cells = <1>;
>                  ranges;
> 
>                  chipid: chipid@10000000 {
>                          compatible = "samsung,exynos4210-chipid";
>                          reg = <0x10000000 0x100>;
>                  };
> 
> 		...
> 	};
> 
> The module was properly autoloaded (via OF aliases/events) and device
> was matched.

Please put this on hold for a bit, I need a colleague to check the udev 
event on this platform before we can move on any further.

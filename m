Return-Path: <linux-crypto+bounces-101-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A917E8D22
	for <lists+linux-crypto@lfdr.de>; Sat, 11 Nov 2023 23:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238E41F20F47
	for <lists+linux-crypto@lfdr.de>; Sat, 11 Nov 2023 22:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AF1208BA
	for <lists+linux-crypto@lfdr.de>; Sat, 11 Nov 2023 22:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CHufhVKK"
X-Original-To: linux-crypto@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C561DA2B
	for <linux-crypto@vger.kernel.org>; Sat, 11 Nov 2023 21:29:06 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB583253
	for <linux-crypto@vger.kernel.org>; Sat, 11 Nov 2023 13:29:03 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40853c639abso23632615e9.0
        for <linux-crypto@vger.kernel.org>; Sat, 11 Nov 2023 13:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699738142; x=1700342942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=il5a4mbjfp6qYPjpY8z0zXKOKaQkNXf9hTpSlP/X8x8=;
        b=CHufhVKK8b6k7H1cF/QKqGwH/wSje+zZKShHMorSF3CrK8vbWPntey2R4GFvQSFl9U
         sEmPD1vYJHTlO1NzcqwskKMDCZrFMQ/u96IA876CZhoRrTB1AZmojKQZWOQasSlYcHxp
         Dj+Mgj5JW2Y5K6SY9K0Z/MW+YPy4HWWEzRoCne47MI6hbllr9vd9Ei+QoI6kp4WX3pzo
         orbqXQWseLW9d30UkemzZKqNzO4tnFmrXQgx4v8M5XZWg8O8GHaMHYOCvz1+dHMeIkQd
         PvG7/yvIK4sIneYCBGBE07OVrh3fBfWWJgghx/ht1WUev5856pKaqELBdWC9e1rwCzsj
         kh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699738142; x=1700342942;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=il5a4mbjfp6qYPjpY8z0zXKOKaQkNXf9hTpSlP/X8x8=;
        b=gkZhTdLa5RIU4lbd67l4XPr4Bt+25vzFsN3/T8/pRkclNBhzN9v9o18HOYl4DKf15r
         +7LRPWlnd9+1qf4/J1PUC0PV8RzYwbnbcLzISDeFF/hPbeNABqGPVVaA3rnoKgGaKZrM
         PzuE2quNlndLPwZj1KkCPEYn5FOG5OC8Qnl95P9E+atZREOEE2I/t7RHpHn/yTz4/6AH
         YcFy3iSs3wW9QrFFrss6H9nAQR8HQP2VkALcclhZSvfXSt2JR7zkju74e9QgqtIk737f
         FxceGMOTpK5RhL9QHMdxvuAciZbguD+xWwKCFRvR77oEpOjPeT5Sv7B06eqlHh6YIPbc
         ODjw==
X-Gm-Message-State: AOJu0YwvwrziBPuv7Fkf+QnPvch3ky94wj/bYJsn5xnbhHBeV8kgmvKT
	TiDZP88eLXrKR+CDcKpXta+xLQ==
X-Google-Smtp-Source: AGHT+IFmJM//n2BpN8QWzWKDeOiZydZ4twNs/PlDpqlz97EvOPZ1UKP9Um29/iMFiC6QTfvJK4Epyg==
X-Received: by 2002:a05:600c:348f:b0:406:411f:742e with SMTP id a15-20020a05600c348f00b00406411f742emr2401642wmq.34.1699738141508;
        Sat, 11 Nov 2023 13:29:01 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id hg14-20020a05600c538e00b004064288597bsm3158406wmb.30.2023.11.11.13.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Nov 2023 13:29:00 -0800 (PST)
Message-ID: <4f86c7da-5589-4451-89cb-739b97b67170@linaro.org>
Date: Sat, 11 Nov 2023 22:28:59 +0100
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] reset: rockchip: secure reset must be used by SCMI
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Corentin Labbe <clabbe@baylibre.com>, davem@davemloft.net,
 herbert@gondor.apana.org.au, krzysztof.kozlowski+dt@linaro.org,
 mturquette@baylibre.com, p.zabel@pengutronix.de, robh+dt@kernel.org,
 sboyd@kernel.org, ricardo@pardini.net, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org
References: <20231107155532.3747113-1-clabbe@baylibre.com>
 <20231107155532.3747113-6-clabbe@baylibre.com>
 <f1b24f19-c210-4f55-b40f-ab063e7eeb22@linaro.org> <11278271.CDJkKcVGEf@diego>
 <d82865bc-29a7-4150-876e-489e0d797699@linaro.org>
 <20231111205115.6hkhjj37ypeq45ax@mercury.elektranox.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231111205115.6hkhjj37ypeq45ax@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/11/2023 21:51, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Nov 07, 2023 at 06:45:03PM +0100, Krzysztof Kozlowski wrote:
>> On 07/11/2023 18:35, Heiko Stübner wrote:
>>> Am Dienstag, 7. November 2023, 17:21:41 CET schrieb Krzysztof Kozlowski:
>>>> On 07/11/2023 16:55, Corentin Labbe wrote:
>>>>> While working on the rk3588 crypto driver, I loose lot of time
>>>>> understanding why resetting the IP failed.
>>>>> This is due to RK3588_SECURECRU_RESET_OFFSET being in the secure world,
>>>>> so impossible to operate on it from the kernel.
>>>>> All resets in this block must be handled via SCMI call.
>>>>>
>>>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>>>> ---
>>>>>  drivers/clk/rockchip/rst-rk3588.c             | 42 ------------
>>>>>  .../dt-bindings/reset/rockchip,rk3588-cru.h   | 68 +++++++++----------
>>>>
>>>> Please run scripts/checkpatch.pl and fix reported warnings. Some
>>>> warnings can be ignored, but the code here looks like it needs a fix.
>>>> Feel free to get in touch if the warning is not clear.
>>>>
>>>>>  2 files changed, 34 insertions(+), 76 deletions(-)
>>>>>
>>>>> diff --git a/drivers/clk/rockchip/rst-rk3588.c b/drivers/clk/rockchip/rst-rk3588.c
>>>>> index e855bb8d5413..6556d9d3c7ab 100644
>>>>> --- a/drivers/clk/rockchip/rst-rk3588.c
>>>>> +++ b/drivers/clk/rockchip/rst-rk3588.c
>>>>> @@ -16,9 +16,6 @@
>>>>>  /* 0xFD7C8000 + 0x0A00 */
>>>>>  #define RK3588_PHPTOPCRU_RESET_OFFSET(id, reg, bit) [id] = (0x8000*4 + reg * 16 + bit)
>>>>>  
>>>>> -/* 0xFD7D0000 + 0x0A00 */
>>>>> -#define RK3588_SECURECRU_RESET_OFFSET(id, reg, bit) [id] = (0x10000*4 + reg * 16 + bit)
>>>>> -
>>>>>  /* 0xFD7F0000 + 0x0A00 */
>>>>>  #define RK3588_PMU1CRU_RESET_OFFSET(id, reg, bit) [id] = (0x30000*4 + reg * 16 + bit)
>>>>>  
>>>>> @@ -806,45 +803,6 @@ static const int rk3588_register_offset[] = {
>>>>>  	RK3588_PMU1CRU_RESET_OFFSET(SRST_P_PMU0IOC, 5, 4),
>>>>>  	RK3588_PMU1CRU_RESET_OFFSET(SRST_P_GPIO0, 5, 5),
>>>>>  	RK3588_PMU1CRU_RESET_OFFSET(SRST_GPIO0, 5, 6),
>>>>> -
>>>>> -	/* SECURECRU_SOFTRST_CON00 */
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_A_SECURE_NS_BIU, 0, 10),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_SECURE_NS_BIU, 0, 11),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_A_SECURE_S_BIU, 0, 12),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_SECURE_S_BIU, 0, 13),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_P_SECURE_S_BIU, 0, 14),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_CRYPTO_CORE, 0, 15),
>>>>> -
>>>>> -	/* SECURECRU_SOFTRST_CON01 */
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_CRYPTO_PKA, 1, 0),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_CRYPTO_RNG, 1, 1),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_A_CRYPTO, 1, 2),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_CRYPTO, 1, 3),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_KEYLADDER_CORE, 1, 9),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_KEYLADDER_RNG, 1, 10),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_A_KEYLADDER, 1, 11),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_KEYLADDER, 1, 12),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_P_OTPC_S, 1, 13),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_OTPC_S, 1, 14),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_WDT_S, 1, 15),
>>>>> -
>>>>> -	/* SECURECRU_SOFTRST_CON02 */
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_T_WDT_S, 2, 0),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_BOOTROM, 2, 1),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_A_DCF, 2, 2),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_P_DCF, 2, 3),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_BOOTROM_NS, 2, 5),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_P_KEYLADDER, 2, 14),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_TRNG_S, 2, 15),
>>>>> -
>>>>> -	/* SECURECRU_SOFTRST_CON03 */
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_TRNG_NS, 3, 0),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_D_SDMMC_BUFFER, 3, 1),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_SDMMC, 3, 2),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_SDMMC_BUFFER, 3, 3),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_SDMMC, 3, 4),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_P_TRNG_CHK, 3, 5),
>>>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_TRNG_S, 3, 6),
>>>>>  };
>>>>>  
>>>>>  void rk3588_rst_init(struct device_node *np, void __iomem *reg_base)
>>>>> diff --git a/include/dt-bindings/reset/rockchip,rk3588-cru.h b/include/dt-bindings/reset/rockchip,rk3588-cru.h
>>>>> index d4264db2a07f..c0d08ae78cd5 100644
>>>>> --- a/include/dt-bindings/reset/rockchip,rk3588-cru.h
>>>>> +++ b/include/dt-bindings/reset/rockchip,rk3588-cru.h
>>>>> @@ -716,39 +716,39 @@
>>>>>  #define SRST_P_GPIO0			627
>>>>>  #define SRST_GPIO0			628
>>>>>  
>>>>> -#define SRST_A_SECURE_NS_BIU		629
>>>>> -#define SRST_H_SECURE_NS_BIU		630
>>>>> -#define SRST_A_SECURE_S_BIU		631
>>>>> -#define SRST_H_SECURE_S_BIU		632
>>>>> -#define SRST_P_SECURE_S_BIU		633
>>>>> -#define SRST_CRYPTO_CORE		634
>>>>> -
>>>>> -#define SRST_CRYPTO_PKA			635
>>>>> -#define SRST_CRYPTO_RNG			636
>>>>> -#define SRST_A_CRYPTO			637
>>>>> -#define SRST_H_CRYPTO			638
>>>>> -#define SRST_KEYLADDER_CORE		639
>>>>> -#define SRST_KEYLADDER_RNG		640
>>>>> -#define SRST_A_KEYLADDER		641
>>>>> -#define SRST_H_KEYLADDER		642
>>>>> -#define SRST_P_OTPC_S			643
>>>>> -#define SRST_OTPC_S			644
>>>>> -#define SRST_WDT_S			645
>>>>> -
>>>>> -#define SRST_T_WDT_S			646
>>>>> -#define SRST_H_BOOTROM			647
>>>>> -#define SRST_A_DCF			648
>>>>> -#define SRST_P_DCF			649
>>>>> -#define SRST_H_BOOTROM_NS		650
>>>>> -#define SRST_P_KEYLADDER		651
>>>>> -#define SRST_H_TRNG_S			652
>>>>> -
>>>>> -#define SRST_H_TRNG_NS			653
>>>>> -#define SRST_D_SDMMC_BUFFER		654
>>>>> -#define SRST_H_SDMMC			655
>>>>> -#define SRST_H_SDMMC_BUFFER		656
>>>>> -#define SRST_SDMMC			657
>>>>> -#define SRST_P_TRNG_CHK			658
>>>>> -#define SRST_TRNG_S			659
>>>>> +#define SRST_A_SECURE_NS_BIU		10
>>>>
>>>> NAK. You just broke all users.
>>>
>>> If I'm reading the commit message correctly, all resets in that area
>>> couldn't have any users to begin with, as the registers controlling them
>>> are in the secure space, and need a higher exception level
>>>
>>> So if  anything is trying to handle these resets, would end up with some
>>> security exception right now.
>>>
>>> Though I guess we might want to use different names and not reuse the
>>> existing ones. scmi clocks use a SCMI_CLK_* id scheme, so maybe SCMI_SRST_* ?
>>
>> I don't quite get what the patch wants to achieve. Why dropping driver
>> support for given reset ID is connected with changing the value of
>> binding for given reset?
>>
>> What is the point of this define SRST_A_SECURE_NS_BIU 10?
> 
> This is about two different reset controllers. The IDs defined here
> are used by the operating system to access the correct registers.
> The kernel has a LUT from the ID to a register addresses, which is
> something you asked for during upstreaming.
> 
> The ID defined by Corentin is for reset control via SCMI firmware,
> which has different number scheme than Linux. To me the suggestion
> from Heiko looks sensible (i.e. create a new ID scheme and keep the
> current one unchanged).

So the binding is not for Linux but for FW? This should be explained in
the commit msg.

Best regards,
Krzysztof



Return-Path: <linux-crypto+bounces-1378-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 208E782AB01
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jan 2024 10:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB081F23835
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jan 2024 09:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA44611704;
	Thu, 11 Jan 2024 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xhbOqDX1"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2582014A98
	for <linux-crypto@vger.kernel.org>; Thu, 11 Jan 2024 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a28d61ba65eso576576366b.3
        for <linux-crypto@vger.kernel.org>; Thu, 11 Jan 2024 01:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704965474; x=1705570274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Eor6lImS7ySePlUmbye/lNdlPbDxWcSpzNk/0V1lmvk=;
        b=xhbOqDX1gcf+xuQdqaFkzKm3nkB6C5TFHK7Ffkt9MTSEAxytdHiJK4/a2WY1mKTCcC
         vDfNt8+9bM72vSOb+pZx3Gu/RsHJljwMqaWYYaGL4OXk/BpK83loZ8keX8QJxdr8rXWF
         AWMO3CUSPMpRIvW3wi4EIkhJp8BtiaHCrzuplK26kCnlBj9eXNVc/qIWPk0vnWIIpiFu
         vTOm84cPWDy0RTWLwD1e6QS6dEivAhc8PxiGMa16sSrdsokCgHsiIkHuvSoHwgB9DmRR
         lD+BU7mFTF2uKfrwTSJj2q5CNFw6tw4TMQgDgyNYfRgDd2O0u+/itA5A7fXwAnrjBkSv
         avzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704965474; x=1705570274;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eor6lImS7ySePlUmbye/lNdlPbDxWcSpzNk/0V1lmvk=;
        b=hbiyimbKyyBviN/k8eYNUtTkkiaTBHUedigNXzRW8YJLynbr98M2Oa66T4U9ES3S8c
         TMJGRSMyeyP4ZXDfQiYDvdhn+d/x7UW7eIjR7c+4NGaXBlaCy2BQtjPQo8fgH8aMdD0x
         WWEgPle/snkCCZCmr8DKg2LAsIg+tebkGqpte5NzsVKEjj+o8UaXr8qmbgybBdpyRY2p
         hM5FsMyA4eeXlG02Asj7g+yHKvvzBimB///MfK07l6le10a/DguezGqoX0fUwAkEllIm
         SaO8rU/cbq+NhlrlvsskZ9YnHjucB/eS1WFWIlqW1CXDScAk5V2wXQ0qF7RqCacyRZFO
         Teww==
X-Gm-Message-State: AOJu0YzpdJQgnuNUncUqgyFm8d/8RKDoZLVdLdbfvKliPTFU/0xRQKag
	YLeyBXcf7hl0SnYkbegf3xWBEHwBfk35nw==
X-Google-Smtp-Source: AGHT+IGD9nTnB2PCUwRoN7P9hfHTaak6Rf6N5a7I+i6QTcDjkE0MZWvuwl97F/xmIbbqjFd1l3G8BA==
X-Received: by 2002:a17:906:2459:b0:a2b:643:322 with SMTP id a25-20020a170906245900b00a2b06430322mr243390ejb.138.1704965474275;
        Thu, 11 Jan 2024 01:31:14 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id b4-20020a170906150400b00a2a37f63216sm353336ejd.171.2024.01.11.01.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 01:31:13 -0800 (PST)
Message-ID: <039a4223-3412-415e-a5e6-c5dca53c96e1@linaro.org>
Date: Thu, 11 Jan 2024 10:31:11 +0100
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/24] Support more Amlogic SoC families in crypto
 driver
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Alexey Romanov <avromanov@salutedevices.com>,
 Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "clabbe@baylibre.com" <clabbe@baylibre.com>,
 "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "khilman@baylibre.com" <khilman@baylibre.com>,
 "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
 "artin.blumenstingl@googlemail.com" <artin.blumenstingl@googlemail.com>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, kernel <kernel@sberdevices.ru>
References: <20240110201216.18016-1-avromanov@salutedevices.com>
 <ZZ8HP7dJgVaZLMw5@Red> <20240111091840.7fe4lqx225rdlwly@cab-wsm-0029881>
 <910736a3-069f-430c-ba6c-221777ddcda2@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <910736a3-069f-430c-ba6c-221777ddcda2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/01/2024 10:29, Krzysztof Kozlowski wrote:
> On 11/01/2024 10:18, Alexey Romanov wrote:
>> Hello!
>>
>> On Wed, Jan 10, 2024 at 10:08:15PM +0100, Corentin Labbe wrote:
>>> Le Wed, Jan 10, 2024 at 11:11:16PM +0300, Alexey Romanov a 'ecrit :
>>>> Hello!
>>>>
>>>> This patchset expand the funcionality of the Amlogic
>>>> crypto driver by adding support for more SoC families: 
>>>> AXG, G12A, G12B, SM1, A1, S4.
>>>>
>>>> Also specify and enable crypto node in device tree
>>>> for reference Amlogic devices.
>>>>
>>>> Tested on AXG, G12A/B, SM1, A1 and S4 devices via
>>>> custom tests and trcypt module.
>>>
>>> Hello
>>>
>>> Thanks for your patch series.
>>> Unfortunatly, I fail to apply it for testing on top of linux-next.
>>> On top of which tree did you have tested ?
>>
>> We use 6.5-rc3.
> 
> Don't develop on old trees... I mean, internally you can do whatever you
> wish, but don't work upstream on such trees.

Number of email bounces also prove the point: you did not Cc right
people due to work on some ancient files.

Best regards,
Krzysztof



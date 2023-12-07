Return-Path: <linux-crypto+bounces-622-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3CB807FAC
	for <lists+linux-crypto@lfdr.de>; Thu,  7 Dec 2023 05:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6037B281CA0
	for <lists+linux-crypto@lfdr.de>; Thu,  7 Dec 2023 04:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2806F4C95
	for <lists+linux-crypto@lfdr.de>; Thu,  7 Dec 2023 04:34:43 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9187D4B;
	Wed,  6 Dec 2023 18:33:43 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id A81898008;
	Thu,  7 Dec 2023 10:33:42 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 7 Dec
 2023 10:33:42 +0800
Received: from [192.168.155.133] (202.188.176.82) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 7 Dec
 2023 10:33:39 +0800
Message-ID: <fca024e0-de9e-4165-8a84-0429e2fc2683@starfivetech.com>
Date: Thu, 7 Dec 2023 10:33:38 +0800
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: rng: starfive: Add jh8100 compatible
 string
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Olivia Mackall
	<olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20231206014236.1109832-1-jiajie.ho@starfivetech.com>
 <20231206014236.1109832-2-jiajie.ho@starfivetech.com>
 <c006dd3a-07a2-4d14-899b-72373540ad37@linaro.org>
Content-Language: en-US
From: Jia Jie Ho <jiajie.ho@starfivetech.com>
In-Reply-To: <c006dd3a-07a2-4d14-899b-72373540ad37@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag

On 6/12/2023 6:17 pm, Krzysztof Kozlowski wrote:
> On 06/12/2023 02:42, Jia Jie Ho wrote:
>> Add compatible string for StarFive JH8100 trng.
>> 
>> Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
>> ---
>>  .../devicetree/bindings/rng/starfive,jh7110-trng.yaml         | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/rng/starfive,jh7110-trng.yaml b/Documentation/devicetree/bindings/rng/starfive,jh7110-trng.yaml
>> index 2b76ce25acc4..d275bdc4d009 100644
>> --- a/Documentation/devicetree/bindings/rng/starfive,jh7110-trng.yaml
>> +++ b/Documentation/devicetree/bindings/rng/starfive,jh7110-trng.yaml
>> @@ -11,7 +11,9 @@ maintainers:
>>  
>>  properties:
>>    compatible:
>> -    const: starfive,jh7110-trng
>> +    enum:
>> +      - starfive,jh7110-trng
>> +      - starfive,jh8100-trng
> 
> Your driver change suggests these are compatible, so express this here
> and drop driver change.
> 

I'll update the series accordingly. Thanks for reviewing this.

Best regards,
Jia Jie



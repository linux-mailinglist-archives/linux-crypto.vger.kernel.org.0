Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9766C7CDF
	for <lists+linux-crypto@lfdr.de>; Fri, 24 Mar 2023 11:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjCXKvt (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 24 Mar 2023 06:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjCXKvs (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 24 Mar 2023 06:51:48 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A875241F2
        for <linux-crypto@vger.kernel.org>; Fri, 24 Mar 2023 03:51:47 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ek18so6245980edb.6
        for <linux-crypto@vger.kernel.org>; Fri, 24 Mar 2023 03:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679655106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Es5Zj8ZXJ7+ZNmQgL15R+ALbyXTkugPpIYfE2O75ZBU=;
        b=CXBdPye3PRCRSuXjVDdN7jhjXHh+6oyf+1bBlIxXRNKDQLgCkUqULD/H/T7lF7oRN+
         7Yyp7JjJ7mycVtXrF3TSNlxfXzhQUfgUGr1DwtNi+7sQEqfHqJD+pF4Ociu0YFg5nfqi
         5UM/cLMU4cCLDziY45EI6QiQb9MUv1tXESuwdsvT3TYPyGyj2fLboMBXgB2ir2S6j1J9
         IVX38Ud9LWsDj1CsVqOw3NiwBfkd0iJIz2Wh42+fRrQJ1sJNVDUT13TTdYGLKdDNtNBe
         5WiTeINDrev7l0q4swaFRpbU2UVxD2Smv1B9GWHIH2kIbLCFlwPHo4Dg6EHdHQ9RQoO9
         miiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679655106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Es5Zj8ZXJ7+ZNmQgL15R+ALbyXTkugPpIYfE2O75ZBU=;
        b=k+RQgcnblRt38U29tuoxiCAIZnwPlRvG6514Qjo4zRVITZWW+/QERS55cA07G9rL3+
         K5IgktV7w9r1sFOhBZxQmJv03fa4zGlpvQ5CDiIkMyGX8ahvqmMtfYJIJVpXGLLyxocU
         XH/aoeUTrxx0acM5KHyZyAw5M/cK7gI+zBZl8N7rEdxG5GBMDEpFE0CaidTE2z2izMnn
         Vvb0T3Uaqsv1LrJt08dmpFhDvZlNNS2LRtPHKoNTvj12mQIsh8a1fYCRXRBmf3GUM00X
         /l3i3MFgiBinrKsm/qvJqRuQpfiSVMspqdh7SdbazxbYMxbJadp0Pd4DvFBvHSomrG/f
         Apyw==
X-Gm-Message-State: AAQBX9eE5o+/OhgE5Q7n/9h9wcFlUyLJ39l+uthWd3eVthdmwiegKOEd
        sKQm7otiI9M7gBpccG0X6H8wGA==
X-Google-Smtp-Source: AKy350aErcL5avhfKGOpWseo+06TK2BrPxMGJrLNIuMn/QfBynVnd5H6M9Amrih8BJ0biropoVOBPQ==
X-Received: by 2002:aa7:c1d7:0:b0:4fa:ba31:6c66 with SMTP id d23-20020aa7c1d7000000b004faba316c66mr2493240edp.42.1679655105779;
        Fri, 24 Mar 2023 03:51:45 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:3027:fb0b:ae08:588? ([2a02:810d:15c0:828:3027:fb0b:ae08:588])
        by smtp.gmail.com with ESMTPSA id k19-20020a508ad3000000b00501c0eaf10csm7596212edk.40.2023.03.24.03.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 03:51:45 -0700 (PDT)
Message-ID: <2dd13286-c518-66a7-44f4-b6c4f8acd061@linaro.org>
Date:   Fri, 24 Mar 2023 11:51:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] crypto - img-hash: Depend on OF and silence compile
 test warning
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
References: <20230319144439.31399-1-krzysztof.kozlowski@linaro.org>
 <ZB14gXqnkBzhdm0i@gondor.apana.org.au>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZB14gXqnkBzhdm0i@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 24/03/2023 11:16, Herbert Xu wrote:
> On Sun, Mar 19, 2023 at 03:44:39PM +0100, Krzysztof Kozlowski wrote:
>> The driver is specific to OF platforms (can match only via OF table),
>> thus add dependency on CONFIG_OF.  Mark the of_device_id table as
>> unused.  This also fixes W=1 warning:
>>
>>   drivers/crypto/img-hash.c:930:34: error: ‘img_hash_match’ defined but not used [-Werror=unused-const-variable=]
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> You should either add a dependency on OF or __maybe_unused.
> Adding both makes no sense.

Of course it makes, otherwise you have warnings which is also fixed here.

> 
> Anyway, what is your final goal here? If it is to get rid of
> of_match_ptr because of_match_table has been unconditinoal for
> over 10 years then just do it in one giant patch rather than
> evaluating every single driver with of_match_table as to whether
> they can be used through ACPI or not.

My current goal is to pass compile tests. The final goal is not yet
decided because final approach is not known. Different people disagree
on details, e.g. whether ACPI && !OF should have of_device_id or not.


Best regards,
Krzysztof


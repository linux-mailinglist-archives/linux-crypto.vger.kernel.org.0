Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA459693302
	for <lists+linux-crypto@lfdr.de>; Sat, 11 Feb 2023 19:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjBKSaR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 11 Feb 2023 13:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBKSaQ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 11 Feb 2023 13:30:16 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97B818B1F
        for <linux-crypto@vger.kernel.org>; Sat, 11 Feb 2023 10:30:15 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 7so5797924pga.1
        for <linux-crypto@vger.kernel.org>; Sat, 11 Feb 2023 10:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OpygrhJ2ETwt4o+ET50PFNDHORjzb5TT1EGbEX5emd0=;
        b=kmAIpZu4d8XwE89DyyVRtNTdQJhlS3u/rt0U4Ya6sbBSunTC1LoUneZwoF8l1+tOzz
         cN2Cu3zVzvp33IEaeFjZhgt4AEa8CEteApMcwZLZg/ipYMtIom4FPPQpBfovnbj2+Sim
         nciTCcIUf/OoqE0axf9INasJM1Yp6BIPvva6q6cbRIg7lwHkGTEeK1l1DbcyLojj39Pf
         H4/g0vNHMz6dNF1/lypLMLZEDNi4YRB6WCzi2NSYearsE6VcbIuL01NVCHRRN9dCWINE
         8Dwg8pFJa3nM6ZpElGRpfEkp9JEbNoeU1v3ShBmWQEf3LS6Pwd714CUzJw0elBBlODWQ
         2HBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OpygrhJ2ETwt4o+ET50PFNDHORjzb5TT1EGbEX5emd0=;
        b=OHFwHUGDQp79QLNydoOCva9B8hUAEACE5/AdCLbVAXOnGyq6+I3hSFbBU9r8sFomWL
         XYNIyROA44sG451gijOTZpirkP3rJisuy+0loR4Crf+gGXh8TXRVUjSA9zTbkdNhTgeg
         CcL085h0douIBqsuLl2P8TkHxxFNYJR52wk8GByfO+xg7m46xknyJ6MNVNID50ccDmpT
         4bEAQ8SBYY3Zl2U8VeAURebSYRLj15es9ktocYo+TDtCxwD+UBDqa6kf7pBm9DEjlyTx
         EFy2SB1oFkD4/dKP5li3sFUSEGl1lXfhJ5Llta1+4QqE5d4uTP+eLbGgUvtf6zZJkR4F
         JzFw==
X-Gm-Message-State: AO0yUKXXM0jmy7J/WhlMbQrVwY9iA7nQax4mYCw18iLgaiaEb82JKA+c
        wlqBdAxrP0QucffnxyZmYRpXcHpHXxs5pA==
X-Google-Smtp-Source: AK7set/dyAtodJRyGddzZ4FIWK3pryhbQzOwTb/TABTZV+XZpKtHkArgNPxzHphjG9R0tq2nsNdBmA==
X-Received: by 2002:a62:6d86:0:b0:5a8:577e:f80d with SMTP id i128-20020a626d86000000b005a8577ef80dmr8124620pfc.25.1676140215041;
        Sat, 11 Feb 2023 10:30:15 -0800 (PST)
Received: from [192.168.0.4] ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id m6-20020aa78a06000000b005772d55df03sm5206211pfa.35.2023.02.11.10.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 10:30:14 -0800 (PST)
Message-ID: <96fd2f5c-26af-c995-d6c5-c1e94f65b6a9@gmail.com>
Date:   Sun, 12 Feb 2023 03:30:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] crypto: x86/aria-avx - fix using avx2 instructions
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "erhard_f@mailbox.org" <erhard_f@mailbox.org>
References: <20230210181541.2895144-1-ap420073@gmail.com>
 <MW5PR84MB18427D089F66544E76648A70ABDE9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Content-Language: en-US
From:   Taehee Yoo <ap420073@gmail.com>
In-Reply-To: <MW5PR84MB18427D089F66544E76648A70ABDE9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 2/11/23 04:08, Elliott, Robert (Servers) wrote:

Hi Elliott,
Thank you so much for your review!

 >> Unfortunately, this change reduces performance by about 5%.
 >
 > The driver could continue to use functions with AVX2 instructions
 > if AVX2 is supported, and fallback to functions using only
 > AVX instructions if not (assuming AVX is supported).
 >

If CPU supports AVX2, ARIA-AVX2 driver will be worked and it is faster.
But, currently AVX driver requires 16 blocks and AVX2 driver requires 32 
blocks.
So, input block size is less than 32, AVX driver is worked even if cpu 
supports AVX2.
I think the best solution is to make AVX, AVX2, and AVX512 drivers 
support various blocks.
If so, we can use the best performance of ARIA algorithm regardless of 
input block size.
As far as I know, SM4 driver already supports it.
So, I think it would be better for ARIA follows this strategy instead of 
supporting AVX2 instruction in the ARIA-AVX.

Thank you so much!
Taehee Yoo

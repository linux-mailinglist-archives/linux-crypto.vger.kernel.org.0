Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E7C635335
	for <lists+linux-crypto@lfdr.de>; Wed, 23 Nov 2022 09:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbiKWIvM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 23 Nov 2022 03:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236572AbiKWIvK (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 23 Nov 2022 03:51:10 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5A4F2C07
        for <linux-crypto@vger.kernel.org>; Wed, 23 Nov 2022 00:51:08 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id u2so20636725ljl.3
        for <linux-crypto@vger.kernel.org>; Wed, 23 Nov 2022 00:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vE++5vLwb67DahKEwL1NXxuRxUTeETw1sq0DG9JKnPs=;
        b=eDPSn7/6kb1CMEWfq46VqkmkHK/vBYGMlzLNxKGhcHC96gnEGPfsDj2hRC3D3+0K/K
         nEe7kVfSMcDnBMpcslsPmZD7sycWxZurDwfbzuNXkZsvnUyFZd8egtiOWOewnIuGrSX1
         CwSlY6i3mfcQCE1BONVmlepyH/mlLpEdIIogM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vE++5vLwb67DahKEwL1NXxuRxUTeETw1sq0DG9JKnPs=;
        b=UYecUfulo45joejPuGz7eB06yLrI7DTa10JjswS1miyFCXNkCXW7F1TJWT+pch9+Wk
         Riaqn16TWDltAmCbw8zSToa3Ed8MDGfGq3iQXeNo1l88iS+bOKmZDLWkda3APG4zmxmf
         DtKlyXduSs85RoBr/mLjbzTPghsxQcbRxrgzh/Duia4Zo8JXkVrUxScO4Iwyk4O+/L4m
         t0uhbFDAEqKJN3iBgi1fvp5uNenjkmmpYPoxF7Irj2x742rKioQTEafuPKbvd3zrQmUq
         fElHfRai33Z4WgZ+dxsYHee6Q3dU6np8nOyjKZzED+1j+tbTZa8jg0hI5zNODKmGI0uf
         Yqzw==
X-Gm-Message-State: ANoB5pkhRQfiLW1+9tKVK2qgx14zMRBfoMOZ3MLxd06YHPN4Lo914Dh/
        4aoKXVFfhRGjRtTHYxw49fz85A==
X-Google-Smtp-Source: AA0mqf4HD7o0V7cctrri/bgHQuP2OrT988YzhpJ2yA34/vUS3vxMKihKLGVVQkl9eSFRAmwtZ6M03Q==
X-Received: by 2002:a2e:9117:0:b0:279:4f30:da0f with SMTP id m23-20020a2e9117000000b002794f30da0fmr3713652ljg.366.1669193466652;
        Wed, 23 Nov 2022 00:51:06 -0800 (PST)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id l7-20020a2e7007000000b0027776efa48csm2134522ljc.91.2022.11.23.00.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 00:51:05 -0800 (PST)
Message-ID: <842fd97b-c958-7b0d-2c77-6927c7ab4d72@rasmusvillemoes.dk>
Date:   Wed, 23 Nov 2022 09:51:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v6 2/3] random: introduce generic vDSO getrandom()
 implementation
Content-Language: en-US, da
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de
Cc:     linux-crypto@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Linux API <linux-api@vger.kernel.org>
References: <20221121152909.3414096-1-Jason@zx2c4.com>
 <20221121152909.3414096-3-Jason@zx2c4.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20221121152909.3414096-3-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 21/11/2022 16.29, Jason A. Donenfeld wrote:

Cc += linux-api

> 
>       if (!new_block)
>         goto out;
>       new_cap = grnd_allocator.cap + num;
>       new_states = reallocarray(grnd_allocator.states, new_cap, sizeof(*grnd_allocator.states));
>       if (!new_states) {
>         munmap(new_block, num * size_per_each);

Hm. This does leak an implementation detail of vgetrandom_alloc(),
namely that it is based on mmap() of that size rounded up to page size.
Do we want to commit to this being the proper way of disposing of a
succesful vgetrandom_alloc(), or should there also be a
vgetrandom_free(void *states, long num, long size_per_each)?

And if so, what color should the bikeshed really have. I.e.,

- does it need to take that size_per_each parameter which the kernel knows

- should it rather take the product so it can for now be a simple alias
for munmap

- should it also have a flags argument just because that's what all
well-behaving syscalls have these days...

Also, should vgetrandom_alloc() take a void *hint argument that
would/could be passed through to mmap() to give userspace some control
over where the memory is located - possibly only in the future, i.e.
insist on it being NULL for now, but it could open the possibility for
adding e.g. VGRND_MAP_FIXED[_NOREPLACE] that would translate to the
corresponding MAP_ flags.

Rasmus


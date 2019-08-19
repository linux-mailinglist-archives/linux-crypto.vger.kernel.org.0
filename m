Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B229992800
	for <lists+linux-crypto@lfdr.de>; Mon, 19 Aug 2019 17:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfHSPIy (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 19 Aug 2019 11:08:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42057 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfHSPIy (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 19 Aug 2019 11:08:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id b16so9088572wrq.9
        for <linux-crypto@vger.kernel.org>; Mon, 19 Aug 2019 08:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0bqiUr7mK9fXp6x96uMwj7WX8Izkcyt+7fK1L9Oqq/I=;
        b=dB+yi2FJTVQMiJeiyhxAbdyArUD3IvCoIAbeA/Gn3tvwj1a7Tsfj9Qh4cSVY/QCz0i
         M97oicuE4a6Qk/4Tek6Kshj4jGp1HT3hblPEDnOIhwcriEJxKfJ+0kwvlay1u46F8Gcb
         /sXwNJrCnoIw9D9KjNLTy28PQmZY2418/wkqxehnMjiM4Tov6b6X7KLgHk+cW15rHm/M
         uMfZ9pbQ0N8F5FSdt8i++SfEx87pVFtAjwLWAB7WjpE7ILYbywelNZ5cM28fZrHJWyD2
         UBvgSyBNACwkjjG68egjbcPWBFn5LqlFZd1DJ/HyR62DZrlZySQPKYSPD669d3y095kW
         iyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0bqiUr7mK9fXp6x96uMwj7WX8Izkcyt+7fK1L9Oqq/I=;
        b=DdwsqDiaNbqU80oc11d7PxuSzQQ3S8+DI+oxVGRNyBjAH8Jb/BumM6Y7RoqClIO0VA
         8nIvx5QunU6J0YKEhp15jlrxCxWYrmySawc9Ei7Gfd7g0kz8jS+L3mV6VvrvDFQFf+kg
         E4sqFVoeylEul/uxJVhLuUkDYhbcgAwswjeFMU941o8RcuTq0+t4kdiPgfAe1HOuU7g+
         9DhTXTexpJgZBloay16NmW/2xsexF7JBr+9Kpv0kOEd1IFAOWog1yRvVxM2syOzhi4w3
         v00SdVOcVrjLbQhw6n3f+WzrHnFGNyPxunEeBcke3m9u+UW3nmq7SH4dWAIzQ+vmFPK0
         7YDA==
X-Gm-Message-State: APjAAAWL1XI844y33ix1y6dlZ33AuTPJveMzsVLM2844gDd+Jwh8UTQk
        ukESLqG8TU/w09uMq4DqSrqBf+omA+XMlAbhC7Kk5g==
X-Google-Smtp-Source: APXvYqxXXdkUqXANlStsk1lenJDmPI7xPnaoeWDCjml03nCZHiiMxeQ6Lcs34F/mDcvZcefaoGTe/GUtceMB6TU8lc4=
X-Received: by 2002:adf:9e09:: with SMTP id u9mr28292550wre.169.1566227332245;
 Mon, 19 Aug 2019 08:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190817142435.8532-1-hdegoede@redhat.com>
In-Reply-To: <20190817142435.8532-1-hdegoede@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 19 Aug 2019 18:08:34 +0300
Message-ID: <CAKv+Gu_bdcEQVnUcBpucgxk8zJ3EgsS=mBUpqfECOq_k1YYN9w@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] crypto: sha256 - Merge 2 separate C
 implementations into 1, put into separate library
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, 17 Aug 2019 at 17:24, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> Here is v2 of my patch series refactoring the current 2 separate SHA256
> C implementations into 1 and put it into a separate library.
>
> There are 3 reasons for this:
>
> 1) Remove the code duplication of having 2 separate implementations
>
> 2) Offer a separate library SHA256 implementation which can be used
> without having to call crypto_alloc_shash first. This is especially
> useful for use during early boot when crypto_alloc_shash does not
> work yet.
>
> 3) Having the purgatory code using the same code as the crypto subsys means
> that the purgratory code will be tested by the crypto subsys selftests.
>
> This has been tested on x86, including checking that kecec still works.
>
> This has NOT been tested on s390, if someone with access to s390 can
> test that things still build with this series applied and that
> kexec still works, that would be great.
>
> Changes in v2:
> - Use put_unaligned_be32 to store the hash to allow callers to use an
>   unaligned buffer for storing the hash
> - Add a comment to include/crypto/sha256.h explaining that these functions
>   now may be used outside of the purgatory too (and that using the crypto
>   API instead is preferred)
> - Add sha224 support to the lib/crypto/sha256 library code
> - Make crypto/sha256_generic.c not only use sha256_transform from
>   lib/crypto/sha256.c but also switch it to using sha256_init, sha256_update
>   and sha256_final from there so that the crypto subsys selftests fully test
>   the lib/crypto/sha256.c implementation
>

This looks fine to me, although I agree with Eric's feedback regarding
further cleanups. Also, now that we have a C library, I'd like to drop
the dependency of the mips and x86 sha256 algo implementations up
sha256_generic.c, and use the library directly instead (so that
sha256-generic is no longer needed on x86 or mips)

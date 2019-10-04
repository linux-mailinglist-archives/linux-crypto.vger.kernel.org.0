Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6C8CBF15
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Oct 2019 17:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389591AbfJDPYk (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Oct 2019 11:24:40 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41501 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389224AbfJDPYk (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Oct 2019 11:24:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id d16so9039000qtq.8
        for <linux-crypto@vger.kernel.org>; Fri, 04 Oct 2019 08:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=luv+ikUBv6958J4UzuJUBohBTEWpoJGUBlvlrb5tyLk=;
        b=JbKMgI7nD6Wfh7EgY4oE3sT62trGjRK6UbYXQyaMA1L1zxGCrxxm0sjHnvODa6OSeU
         5fCa0KmUUQjM4dBx4A6MfyHWj/U5vJj3o7MszqFfO8musxN7sGK2hE4V4G0d/yGbnxPv
         jpEq/bKKUpfaupeoN4zEL6W5HmyXUsCLcu71UC+QloQM2VNWWbICnh3YEydpc69hrFth
         ErpjqNkz3Q9f5uIJgBXwFbKM0WAmz+93ShlNmfk5JR1+xm+WQUxnYE+jQKELfiZ/zxSb
         Bi3BnL56iojHorbfkli8ViFTuFwtbOq7J+941u3ALFgLWxq8WOZehF1DiW4sFq89rff6
         fB2w==
X-Gm-Message-State: APjAAAXVqxZXMvTtQ2fjrBcWBeTvZ26/SF6G26fS/VPezTeRg8zzCSqf
        8tdbgwkx7yK+/Rck+vLxUKqVqruWvKrhrDKBHKk=
X-Google-Smtp-Source: APXvYqzDH9GucBz1BF4ETkc4bGz+I/0qf65iuCf1nO1kqpyDbfpDmRwFUdR2/KCCh1p0XK/xTkQDPwdY+keVJb0ZfkE=
X-Received: by 2002:a0c:9289:: with SMTP id b9mr2395350qvb.211.1570202679059;
 Fri, 04 Oct 2019 08:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191002141713.31189-1-ard.biesheuvel@linaro.org>
 <20191002141713.31189-5-ard.biesheuvel@linaro.org> <CAHmME9p3a-sNp_MmMKxX7z9PsTi3DdUrVtX=X4vhr_ep=KdCJw@mail.gmail.com>
 <CAKv+Gu8urn0K5pCHr4Y1qJH+8-wcQ=BXAHVSXO9xt4PwZ14xiw@mail.gmail.com>
In-Reply-To: <CAKv+Gu8urn0K5pCHr4Y1qJH+8-wcQ=BXAHVSXO9xt4PwZ14xiw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 4 Oct 2019 17:24:21 +0200
Message-ID: <CAK8P3a2At0YUwZ7xSOd12QPKcxvnjeG49nfMuDz3E4wO7Tr1fQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/20] crypto: arm/chacha - expose ARM ChaCha routine
 as library function
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Eric Biggers <ebiggers@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Martin Willi <martin@strongswan.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Oct 4, 2019 at 4:23 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> How is it relevant whether the boot CPU is A5 or A7? These are bL
> little cores that only implement NEON for feature parity with their bl
> big counterparts, but CPU intensive tasks are scheduled on big cores,
> where NEON performance is much better than scalar.
>
> If we need a policy for this in the kernel, I'd prefer it to be one at
> the arch/arm level where we disable kernel mode NEON entirely, either
> via a command line option, or via a policy based on the the types of
> all CPUs.

I don't think there was ever a b.L system with an A5, and most of the
A7+A15 systems did not age well, being high-end phone chips in
2014 that quickly got replaced with A53 parts and that no longer
get kernel upgrades.

The only chips I can think of that one might still care about here
are Exynos 542x (Chromebook 2 EOL 2019, Odroid XU4 ) and
Allwinner A80 (Cubieboard 4).

Just checking for Cortex-A7 being the boot CPU is probably
sufficient, that takes care of the common case of all the
A7-only embedded chips that people definitely are going to care
about for a long time.

      Arnd

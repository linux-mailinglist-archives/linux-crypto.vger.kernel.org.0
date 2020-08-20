Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C473F24B00B
	for <lists+linux-crypto@lfdr.de>; Thu, 20 Aug 2020 09:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgHTHTa (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 20 Aug 2020 03:19:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbgHTHT3 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 20 Aug 2020 03:19:29 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10EAD2078B
        for <linux-crypto@vger.kernel.org>; Thu, 20 Aug 2020 07:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597907968;
        bh=yVy6zSdwrvfP1gMnoQr8XKMGwGHU/nBIgrwQucYiBrM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A6JO/MI5mqWJ7JNRLlq7mu+vn7VybVesm/SqpgdGFA0kvLjX7Jg02qpo/3dA8sfMG
         9tlIkK/d4NOmvHPGaZ3RkLmRNXTf/TBrx3cQdCQTEv8asnlxtFYN4jcrxsF6reXuI5
         dt/UWZocbWbmc4RSw9Z7ZUHjRlrLsnQJsaowekb0=
Received: by mail-ot1-f45.google.com with SMTP id q9so691054oth.5
        for <linux-crypto@vger.kernel.org>; Thu, 20 Aug 2020 00:19:28 -0700 (PDT)
X-Gm-Message-State: AOAM531BJ8q4e/ewuN32AFpz2fy7LbNJ9I3T0XOu1X+N7uO7LCx2hHV2
        ltfZMPWHEAA1D+R1GuBmfHnOGsw6mxrKYvzjvbc=
X-Google-Smtp-Source: ABdhPJyPxF9GIlTwXpEpMjhgKPQ3cP/IOe9svgp4/rflXiFPQbrnzHdtXv4l8N1WhTR1w7jG3jbTPlXUFOqPAlexpRQ=
X-Received: by 2002:a9d:6251:: with SMTP id i17mr1183961otk.90.1597907967346;
 Thu, 20 Aug 2020 00:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200818140532.GA25807@gondor.apana.org.au> <be188471-b75f-d2e2-d657-265a1cd9831b@candelatech.com>
 <20200818221550.GA27421@gondor.apana.org.au> <20200818222719.GA27622@gondor.apana.org.au>
 <bee1a9ce-25d1-2520-5f6a-3966bfa501d2@candelatech.com> <20200818223359.GA27712@gondor.apana.org.au>
 <8b248ef3-d4c7-43fd-6ae4-1c3381597579@candelatech.com> <CAMj1kXFaQsCw_7x8NKNHfMfEC=NdWCxd7V6S3VnAFdOg+-Letg@mail.gmail.com>
 <20200820070142.GA21343@gondor.apana.org.au> <CAMj1kXEdkQUZ_d33N5T5_ELyqRomBKF8Nn+gquo7nrVBMMP-gA@mail.gmail.com>
 <20200820070645.GA21395@gondor.apana.org.au>
In-Reply-To: <20200820070645.GA21395@gondor.apana.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 20 Aug 2020 09:19:16 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE6QDxjNKSpzTrxe+QU0DF9CYp-W7bGe1AyFzYHOJQ41Q@mail.gmail.com>
Message-ID: <CAMj1kXE6QDxjNKSpzTrxe+QU0DF9CYp-W7bGe1AyFzYHOJQ41Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] crypto: Implement cmac based on cbc skcipher
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ben Greear <greearb@candelatech.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, 20 Aug 2020 at 09:06, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Thu, Aug 20, 2020 at 09:04:26AM +0200, Ard Biesheuvel wrote:
> >
> > I don't disagree with that, especially given all the effort that went
> > into optimizing FPU preserve/restore on both arm64 and x86. But the
> > bottom line is that this is what is causing the degradation in Ben's
> > case, so we cannot disregard it.
>
> If he's having problems with the performance when SIMD is in use
> due to preserve/restore, I'd hate to see his numbers when SIMD is
> not available.
>

Actually, I'm not so sure that they will be so much worse. The
expensive FPU preserve/restore occurs for every 16 bytes of data
processed by the AES cipher, which I'd estimate to take ~10 cycles per
byte for an unaccelerated implementation. But table based AES should
be avoided, especially for MAC algorithms where the plaintext may be
known to an attacker who is after the key.

However, the CCMP handling is invoked from softirq context or from
task context, and so SIMD is generally available unless the softirq
happens to be taken over the back of a hardirq that interrupted a task
running in the kernel that was using the SIMD already. IOW, this
happens so rarely in practice that I would not expect it to be
noticeable in the performance stats.

> IOW if this really matters to him, then wireless code needs to switch
> over to ahash.
>
> Solving half of the problem simply makes no sense.
>

My v2 attempt at cbcmac(aesni) implements an ahash, but a synchronous
one. This means we can amortize the FPU preserve/restore over the
entire scatterlist, instead of relying on the ahash walk to present
the data in virtually mapped chunks.

I'd still like to explore this approach, but I simply haven't had the
spare cycles to spend on this.

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7D2945C6E
	for <lists+linux-crypto@lfdr.de>; Fri, 14 Jun 2019 14:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfFNMOi (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 14 Jun 2019 08:14:38 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46381 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbfFNMOi (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 14 Jun 2019 08:14:38 -0400
Received: by mail-yb1-f195.google.com with SMTP id p8so971722ybo.13
        for <linux-crypto@vger.kernel.org>; Fri, 14 Jun 2019 05:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fxAyGD5vJ/kR9ginAE3Gfq7t4d2qI4aWOePQcKJ48hY=;
        b=GsreJhurrOR0opg8FhYeHPEU0dU+jqlkQFjq6LaQEUssfUF+4qzJywmHePvgFA6XbY
         rNfXDi3GrpJHzn9g13UzG8VZiHOunSq5RASabtPNhx7qduZweU+/U8Slp1Q5QBJIklJ/
         W8BRjk6byvGFN0pp89JDcEdDC/E8CSG2SHo4gBMFP1D7GFvMtrs9tm/RytXVteUrxRX2
         pIE/i6DCaM3denM4Efj3kbbKJICRrmR3QLJJRvLrpdfFXZXwTEeJw3LGMsd05O/uktw9
         dv1MWRFzPQcna2OvUGtEhGzIeQUfPUHJnLGuTqshAeTRjmvmWU2pdFUqafamXpJlxeF0
         clsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fxAyGD5vJ/kR9ginAE3Gfq7t4d2qI4aWOePQcKJ48hY=;
        b=kb1KHb/APGz4l8L05eTUNwQ8Hq2ejH9j+QAtgwGmOJ2GOiHnUnt4Cub95zKYiW1i+0
         z3C37VyxCj1rlxZwcuWAbd3ZiM/XyATm7IC0yuH8espiMkCr5HPsvMjcHk6OVSMhf7JK
         cQUZbvGwyEetyikPVdZ8vYHWK9uycHCqVhFxJ0rbdYLGN4+6WYzrgaa34rC6V+f8LyHd
         m5AHzJ+BWqVKAdPuHuDjx0xphXIXYPYDyObAlgvfehTJeL17OBPeCzFTg6+nMy2TMeFv
         mTp0P71TuADxOiofUM02JoILgSs0lClDahVJoUah1wpmwipfoV2LI0GPFlgsoSnpP7LJ
         IYvg==
X-Gm-Message-State: APjAAAUTyxR7fxZ1T+ALjHKQqBSbi9cSOf98WQ2FoOqJUCceaWdxHd8B
        uwt2fsSas/MZ64IK8z/bpRePvSu/tJUMIBtnVFIldg==
X-Google-Smtp-Source: APXvYqwvARY/fYj5Wa7rpR0X0gcbqSHGBnBz7sAevY/M/KUSUEs4MvxCKPaDgDrSHn/HC5ZxJREXKd+gbkeRU62rRpM=
X-Received: by 2002:a25:7642:: with SMTP id r63mr49787764ybc.253.1560514477257;
 Fri, 14 Jun 2019 05:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190614111407.26725-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20190614111407.26725-1-ard.biesheuvel@linaro.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 14 Jun 2019 05:14:26 -0700
Message-ID: <CANn89iKNKKCF_yFAwjCvMqscOkRUFeDRXyFT0+s_hRbjG4wi8A@mail.gmail.com>
Subject: Re: [RFC PATCH] net: ipv4: move tcp_fastopen server side code to
 SipHash library
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     netdev <netdev@vger.kernel.org>, linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>, ebigger@kernel.org,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jun 14, 2019 at 4:14 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> Using a bare block cipher in non-crypto code is almost always a bad idea,
> not only for security reasons (and we've seen some examples of this in
> the kernel in the past), but also for performance reasons.
>
> In the TCP fastopen case, we call into the bare AES block cipher one or
> two times (depending on whether the connection is IPv4 or IPv6). On most
> systems, this results in a call chain such as
>
>   crypto_cipher_encrypt_one(ctx, dst, src)
>     crypto_cipher_crt(tfm)->cit_encrypt_one(crypto_cipher_tfm(tfm), ...);
>       aesni_encrypt
>         kernel_fpu_begin();
>         aesni_enc(ctx, dst, src); // asm routine
>         kernel_fpu_end();
>
> It is highly unlikely that the use of special AES instructions has a
> benefit in this case, especially since we are doing the above twice
> for IPv6 connections, instead of using a transform which can process
> the entire input in one go.
>
> We could switch to the cbcmac(aes) shash, which would at least get
> rid of the duplicated overhead in *some* cases (i.e., today, only
> arm64 has an accelerated implementation of cbcmac(aes), while x86 will
> end up using the generic cbcmac template wrapping the AES-NI cipher,
> which basically ends up doing exactly the above). However, in the given
> context, it makes more sense to use a light-weight MAC algorithm that
> is more suitable for the purpose at hand, such as SipHash.
>
> Since the output size of SipHash already matches our chosen value for
> TCP_FASTOPEN_COOKIE_SIZE, and given that it accepts arbitrary input
> sizes, this greatly simplifies the code as well.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> NOTE: This approach assumes that there are no external dependencies,
>       i.e., that there are no tools that implement the same algorithm
>       to calculate TCP fastopen cookies outside of the kernel.
>

SGTM, but please base your patch on top of David Miller net-next tree,
since fastopen has changed a bit for 5.3
with Jason Baron and Christoph Paasch work.

(Also please CC them at next submission)

Thanks !

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6461278819
	for <lists+linux-crypto@lfdr.de>; Mon, 29 Jul 2019 11:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfG2JPd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 29 Jul 2019 05:15:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41157 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfG2JPd (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 29 Jul 2019 05:15:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so57757049wrm.8
        for <linux-crypto@vger.kernel.org>; Mon, 29 Jul 2019 02:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E1yR84bClXFejvIv66A/1YKdP2hURoK+rSEdIsELqNA=;
        b=TC13eg35S5aFfrNOl1sByVKG3DE1uFRSzGcggWqZ4eK5DoVtavlmZmHhOhymflfTb9
         JiVUWPlIyeT/C+2vXsTA00teoN73CLmh7eW+8Qx3etNs5djAeUN88LdNuUy0dgTf635k
         gS91qB4g70ryMSrUbn1cYprK4lm0uX2kKBpoezlSq6dB4Gh1q+ZCSzicRJmj0WVcm0gQ
         ESgVF/xD2utRgjJkSghjKGJPxtGEbHFAPdYAUPELVNFTaW92WNeUbgX31kkAR2jAm+nQ
         hXUMwsWE2DUUm1LVFw8G7b2Hm25iSs8P0cggYbnL2IfWZq+v3FsV/IUWzgENlzgZ8RDf
         IVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1yR84bClXFejvIv66A/1YKdP2hURoK+rSEdIsELqNA=;
        b=as1BMT0ajN2nM8R4dTipFwnnftrwpKyRVf/liNYpVTYU9sWrK16tgKIQbaqkYAKst5
         +HJPdO/Gvmv8EFceYlXILtNcG9txttk6tAZe4ZC3V8abW0cS/lGJorUfnwCWeCkLmrOY
         NrhQ3lC5T4fh2FCKAKd0vXjkFgMjV8P7irm7kZkefiTEMYUoKZ8ZuVmoPg5Gs1JS0+cC
         FNbPlk7FQxZsUfLXZCIHQubSY/hTzW8mBxSKHr0OfYG6Zl3/wk/N7bRz6HC4rEztGn0H
         aHMqcykcHDM/TTJWmWLRcbDZ3Gox2iFEI9jQ2tBu0Y96RS5jlR1Q1Bor8u4MiabuLaeO
         mtAw==
X-Gm-Message-State: APjAAAUU0VgtA+TEjVM3rxN9qlHKTnjCOV5/qW5r0HB9+F5P4I9DAJLF
        2HSRa2oSR2vCnByaOcgDK0tNp8DHnI0XX2rAepm0fw==
X-Google-Smtp-Source: APXvYqz+Hn/cjMpMhlaaNCdTrHpoz9MZ3XQTlT6U8CpC2BOh16FwbHuplvybwlTg0fwB0fhBwxTq9F1U/kuih8rfvXQ=
X-Received: by 2002:a5d:428b:: with SMTP id k11mr85712971wrq.174.1564391731465;
 Mon, 29 Jul 2019 02:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190729074434.21064-1-ard.biesheuvel@linaro.org> <20190729091204.GA32006@gondor.apana.org.au>
In-Reply-To: <20190729091204.GA32006@gondor.apana.org.au>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 29 Jul 2019 12:15:20 +0300
Message-ID: <CAKv+Gu9WW_wGKZaXHjLxgUF0zNYBpEFZnjVyFy0tGmiGmb0-ag@mail.gmail.com>
Subject: Re: [PATCH] crypto: aegis128 - deal with missing simd.h header on
 some architecures
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, 29 Jul 2019 at 12:12, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > The generic aegis128 driver has been updated to support using SIMD
> > intrinsics to implement the core AES based transform, and this has
> > been wired up for ARM and arm64, which both provide a simd.h header.
> >
> > As it turns out, most architectures don't provide this header, even
> > though a version of it exists in include/asm-generic, and this is
> > not taken into account by the aegis128 driver, resulting in build
> > failures on those architectures.
> >
> > So update the aegis128 code to only import simd.h (and the related
> > header in internal/crypto) if the SIMD functionality is enabled for
> > this driver.
> >
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> > crypto/aegis128-core.c | 22 +++++++++++++++++-----
> > 1 file changed, 17 insertions(+), 5 deletions(-)
>
> I think we should dig a little deeper into why asm-generic isn't
> working for this case.  AFAICS we rely on the same mechanism for
> errno.h on m68k and that obviously works.
>

It is simply a matter of adding simd.h to the various
arch/<...>/include/asm/Kbuild files, but we'd have to do that for all
architectures.

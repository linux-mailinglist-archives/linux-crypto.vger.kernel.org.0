Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E062BA79C
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Nov 2020 11:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbgKTKkh (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Nov 2020 05:40:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727430AbgKTKkh (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Nov 2020 05:40:37 -0500
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 521D722255
        for <linux-crypto@vger.kernel.org>; Fri, 20 Nov 2020 10:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605868836;
        bh=IB8/J4dUorHKD2I8nDGmEwgUNca8AEkwk+GaYrnzx6k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2M76zuI+u8312RGEVQTAC5+gAzzKb0Q8wc4W2JLZESG2ktNlSGsVgzrZqq0OdV9Ib
         L5JLRIon5QUwl368+/iY9LnQokrgg2/yqArdGdT1C0LfqbLuZXLWErdn5Z5WbEoC1A
         Qz4SHisU3wGhWRUYHa0ub3B9TJGAhhfNkg89zg5s=
Received: by mail-oo1-f52.google.com with SMTP id f8so2112882oou.0
        for <linux-crypto@vger.kernel.org>; Fri, 20 Nov 2020 02:40:36 -0800 (PST)
X-Gm-Message-State: AOAM533BhLNgiAJ0Hq7+6ZqOazVZFCt/oAEZUGscgI160KZ8b5nD4UWm
        /YyIBs8BPd5Zuo5XcX695FzChS8B4GExErNCtSI=
X-Google-Smtp-Source: ABdhPJwIc+AQ+Jl/Y5/5t/pV131oGyc21F2dshWNU9BgX1+V0TVAWwAyUGzqV5QN4jwOXmFllqHFS5YsUD3SXUpT1EM=
X-Received: by 2002:a4a:45c3:: with SMTP id y186mr4150861ooa.13.1605868835536;
 Fri, 20 Nov 2020 02:40:35 -0800 (PST)
MIME-Version: 1.0
References: <20201109083143.2884-1-ardb@kernel.org> <20201109083143.2884-3-ardb@kernel.org>
 <20201120034440.GA18047@gondor.apana.org.au> <CAMj1kXFd1ab2uLbQ7UvL7_+ObLGbfh=p3aRm3GhAvH0tcOYQ5g@mail.gmail.com>
 <20201120100936.GA22225@gondor.apana.org.au> <CAMj1kXGu67h96=RvVDRM2z9-N4KcvOLnr6EurjkpbPdZQfh6qw@mail.gmail.com>
 <20201120103750.GA22319@gondor.apana.org.au>
In-Reply-To: <20201120103750.GA22319@gondor.apana.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 20 Nov 2020 11:40:24 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFdhZ8RZp6MQVJ6bgXNoLNr3pfDBkhhVvEGuLFb1xQo3g@mail.gmail.com>
Message-ID: <CAMj1kXFdhZ8RZp6MQVJ6bgXNoLNr3pfDBkhhVvEGuLFb1xQo3g@mail.gmail.com>
Subject: Re: [PATCH 2/3] crypto: tcrypt - permit tcrypt.ko to be builtin
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, 20 Nov 2020 at 11:37, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Fri, Nov 20, 2020 at 11:34:14AM +0100, Ard Biesheuvel wrote:
> > On Fri, 20 Nov 2020 at 11:09, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > >
> > > On Fri, Nov 20, 2020 at 10:24:44AM +0100, Ard Biesheuvel wrote:
> > > >
> > > > OK, I'll apply this on top
> > > >
> > > > diff --git a/crypto/Kconfig b/crypto/Kconfig
> > > > index 9ff2d687e334..959ee48f66a8 100644
> > > > --- a/crypto/Kconfig
> > > > +++ b/crypto/Kconfig
> > > > @@ -202,7 +202,7 @@ config CRYPTO_AUTHENC
> > > >  config CRYPTO_TEST
> > > >         tristate "Testing module"
> > > >         depends on m || CRYPTO_MANAGER_EXTRA_TESTS
> > > > -       select CRYPTO_MANAGER
> > > > +       depends on CRYPTO_MANAGER
> > >
> > > How about just removing the depends line altogether?
> >
> > That may break the build, and therefore randconfig build testing:
> >
> > crypto/tcrypt.o: In function `do_mult_aead_op':
> > tcrypt.c:(.text+0x180): undefined reference to `crypto_aead_encrypt'
> > tcrypt.c:(.text+0x194): undefined reference to `crypto_aead_decrypt'
>
> Did you keep the select CRYPTO_MANAGER? That should bring in
> everything that's needed.
>

Ah right, you mean the /other/ depends line.

Yeah, that would work, but enabling it as a builtin produces a lot of
bogus output if you fail to set the tcrypt.mode=xxx kernel command
line option, so it is really only intended for deliberate use.

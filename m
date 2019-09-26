Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAF0EBF54C
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Sep 2019 16:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfIZOxB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 26 Sep 2019 10:53:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56255 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfIZOxB (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 26 Sep 2019 10:53:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id a6so3114679wma.5
        for <linux-crypto@vger.kernel.org>; Thu, 26 Sep 2019 07:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0L51IWSSTfk/ZgR589XaHykPl4YJGMDUDTMAzq4FuKw=;
        b=zJ+8+Mu9e9sQfXzWkDgdVOFboQmUWwf/E/zxLwUo8GPnNrov9tfjb1ao+KG6uD0Di8
         7vbyMnj1Sh0KxxA2HT3B5Hlbs+yB8h4M5KnWnZ7/1sAe52ax4ZzrJMxF6yRfmNqjMvR+
         o54CiGYKc4MsZdPmXjQzh5TC4GGVrH02B4dEWjdv+v+PHN6jPnIT/XeOYwRVs27UZxmV
         jDxrL8iFf7Lld6Tx6+fhYJZvuhcLk6IYV7To3o/1bqyDaPrsQHJE/SGpY7Z4w3nfQPR8
         1FS8sAQoocQBtDGRFqyKj1cdsPV4Pbi52pimuLJdjQB8LgqJ7zncySww/irR4Dqa10Q2
         cDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0L51IWSSTfk/ZgR589XaHykPl4YJGMDUDTMAzq4FuKw=;
        b=Y0fHA7xrzWQlfOXecCsuEZqMkD7bx4DCfmBuO8HlSZ4Em9u52AJDaQcymyZ/oszh/T
         YPwIJBt+Cas3z2RisRsqjBbe71MHnixmMjYLV2T2D9IrSxn6DhhAKuYQA9xYySMbQ7v2
         v9jYwpRV/q2RiDzk6uproLR6v/jotKIzDi+ipdMYa9fz7XKZjVogizpOnrL4Y3Uf8m7L
         YWHxCPnvcDWrIphoZdLFVl3K3LxMdECfi2coq2rvQwpR0YoeNBJSxx8nLJxFpCZwS6eJ
         maixpe8USUUVOsU3MVXim+HBhsVHKL9WUmNxGj0xsnbM+lw3cfsHceua4vlpCAMplhXd
         PUtA==
X-Gm-Message-State: APjAAAUaquwHAHOGr8ylatwp9UMyHQNfrmzloYJBgE0hkAEmKKboP1U5
        cgrIUMNpxMSdMZxpmI3UwyFsiWQdZJJ1qzHOLGvcXg==
X-Google-Smtp-Source: APXvYqxcWxypHYHisklhmMNNuyFYUMuqTzC/ZaBeHUfpWnFabBoUGaC/VDYPFS5uBqgwKlPi2JJYpJovMI+mXBXpVPo=
X-Received: by 2002:a7b:c451:: with SMTP id l17mr3039573wmi.61.1569509578884;
 Thu, 26 Sep 2019 07:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190925161255.1871-1-ard.biesheuvel@linaro.org>
 <CAHmME9oDhnv7aX77oEERof0TGihk4mDe9B_A3AntaTTVsg9aoA@mail.gmail.com>
 <CAKv+Gu-RLRhwDahgvfvr2J9R+3GPM6vh4mjO73VcekusdzbuMA@mail.gmail.com>
 <MN2PR20MB29731267C4670FBD46D6C743CA860@MN2PR20MB2973.namprd20.prod.outlook.com>
 <CAKv+Gu_eNK1HFxTY379kpCpF8FQQFHEdC1Th=s5f7Fy3bebOjQ@mail.gmail.com> <MN2PR20MB297313B598D8EBBE06477B1CCA860@MN2PR20MB2973.namprd20.prod.outlook.com>
In-Reply-To: <MN2PR20MB297313B598D8EBBE06477B1CCA860@MN2PR20MB2973.namprd20.prod.outlook.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 26 Sep 2019 16:52:47 +0200
Message-ID: <CAKv+Gu-P58Uar2jUNdN5VvG1g45=V_+3FMXCD+0sFY7y2RPeag@mail.gmail.com>
Subject: Re: [RFC PATCH 00/18] crypto: wireguard using the existing crypto API
To:     Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, 26 Sep 2019 at 16:03, Pascal Van Leeuwen
<pvanleeuwen@verimatrix.com> wrote:
>
> > -----Original Message-----
> > From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Sent: Thursday, September 26, 2019 3:16 PM
> > To: Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
> > Cc: Jason A. Donenfeld <Jason@zx2c4.com>; Linux Crypto Mailing List <linux-
> > crypto@vger.kernel.org>; linux-arm-kernel <linux-arm-kernel@lists.infradead.org>;
> > Herbert Xu <herbert@gondor.apana.org.au>; David Miller <davem@davemloft.net>; Greg KH
> > <gregkh@linuxfoundation.org>; Linus Torvalds <torvalds@linux-foundation.org>; Samuel
> > Neves <sneves@dei.uc.pt>; Dan Carpenter <dan.carpenter@oracle.com>; Arnd Bergmann
> > <arnd@arndb.de>; Eric Biggers <ebiggers@google.com>; Andy Lutomirski <luto@kernel.org>;
> > Will Deacon <will@kernel.org>; Marc Zyngier <maz@kernel.org>; Catalin Marinas
> > <catalin.marinas@arm.com>
> > Subject: Re: [RFC PATCH 00/18] crypto: wireguard using the existing crypto API
> >
> > On Thu, 26 Sep 2019 at 15:06, Pascal Van Leeuwen
> > <pvanleeuwen@verimatrix.com> wrote:
> > ...
> > > >
> > > > My preference would be to address this by permitting per-request keys
> > > > in the AEAD layer. That way, we can instantiate the transform only
> > > > once, and just invoke it with the appropriate key on the hot path (and
> > > > avoid any per-keypair allocations)
> > > >
> > > This part I do not really understand. Why would you need to allocate a
> > > new transform if you change the key? Why can't you just call setkey()
> > > on the already allocated transform?
> > >
> >
> > Because the single transform will be shared between all users running
> > on different CPUs etc, and so the key should not be part of the TFM
> > state but of the request state.
> >
> So you need a transform per user, such that each user can have his own
> key. But you shouldn't need to reallocate it when the user changes his
> key. I also don't see how the "different CPUs" is relevant here? I can
> share a single key across multiple CPUs here just fine ...
>

We need two transforms per connection, one for each direction. That is
how I currently implemented it, and it seems to me that, if
allocating/freeing those on the same path as where the keypair object
itself is allocated is too costly, I wonder why allocating the keypair
object itself is fine.

But what I am suggesting is to use a single TFM which gets shared by
all the connections, where the key for each operation is provided
per-request. That TFM cannot have a key set, because each user may use
a different key.

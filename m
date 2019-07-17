Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9E56C0CC
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Jul 2019 20:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfGQSIl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 17 Jul 2019 14:08:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38378 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbfGQSIl (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 17 Jul 2019 14:08:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so1701374wmj.3
        for <linux-crypto@vger.kernel.org>; Wed, 17 Jul 2019 11:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=zv8wcEa6GYy4YZQahLdN/TanAjq6LmsiMTWLNjQH94k=;
        b=q/7J3fU6PDaEBbr2nkuxyzQoz8cgHtbgf1YxcPMSWfEEMq3Dd1ksOdnSWjURBlC98A
         qjsT1x0lucqEByJrWHSW3THwpHO65XHtupbPeXRHbAuRSidwiw/Npdt64jcJHcVV1mRu
         hGls0hJ6cD30K/z4YfGF/Rdzr0KQPyqvI8Ywye2UUv2BbmTdTH0deB7YdjZzvqV9tKRn
         G1pyJNahzIOMs3jPotbId7bvnCRz9skPp4QRBTkZXZAizSAZFSMQVtukLbqYS6w1howW
         hWBUg/VDShpjx1CGZYfcquUrpp4qTuuO/Q49aSblWjAajzgwm5GBBmE6h3o7a34FaG/K
         fZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=zv8wcEa6GYy4YZQahLdN/TanAjq6LmsiMTWLNjQH94k=;
        b=Cum+INhpeO4alW7PTJSkWwGasdJg5IlyRM1Y3EvmOqNoX3wDyQrpvO9swEcLs0RYJG
         jdEBCZLkt0W6RAp+jsytUgnpRn1FspT8puVdrVeKc6gOunqznO5HtCbHKjw6bUWunM6A
         yx9d2ydFJZhWIKMSjl1koINcPVY9sfnaRkIjRLFBbX+FTewQwMZLDnT5A1FjCexOFc5p
         tsziq7FUbuU2U9QRuZihrjOsISIUPWR2GW+86bak38KJL+Ib7U498nVTl+G6Efz6vJsZ
         GA96gE9yAzn9n82wkhiRA7XGPmwEI0QpgA5zbTcVi6NyN2CY9c4KB1oaDermR6T3GR9R
         qyHg==
X-Gm-Message-State: APjAAAUeC5PaHouJnCxm/GEnKJtlMFTRl3bPxt9NbMs4VbJXdbNsIwES
        BvYbd5CUwWny1XTiZpu7FQYxIw149m5eOWLro/uyZA==
X-Google-Smtp-Source: APXvYqxmjONHtcsZZASFx3N2OTq1HdgdMKU6bkt0xXd/bpop34cTFabMv0RftY+oyh6eAThyKpuQePlIdxwqOm7TMJ0=
X-Received: by 2002:a05:600c:21d4:: with SMTP id x20mr34589939wmj.61.1563386918556;
 Wed, 17 Jul 2019 11:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR0402MB34858E4EF0ACA7CDB446FF5798CE0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <20190716221639.GA44406@gmail.com> <VI1PR0402MB34857BBB18C2BB8CBA2DEC7198C90@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <20190717172823.GA205944@gmail.com>
In-Reply-To: <20190717172823.GA205944@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 17 Jul 2019 20:08:27 +0200
Message-ID: <CAKv+Gu__offPaWvyURJr8v56ig58q-Deo16QhP26EJ32uf5m3w@mail.gmail.com>
Subject: Re: xts fuzz testing and lack of ciphertext stealing support
To:     Horia Geanta <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, 17 Jul 2019 at 19:28, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Jul 17, 2019 at 05:09:31PM +0000, Horia Geanta wrote:
> > On 7/17/2019 1:16 AM, Eric Biggers wrote:
> > > Hi Horia,
> > >
> > > On Tue, Jul 16, 2019 at 05:46:29PM +0000, Horia Geanta wrote:
> > >> Hi,
> > >>
> > >> With fuzz testing enabled, I am seeing xts(aes) failures on caam dri=
vers.
> > >>
> > >> Below are several failures, extracted from different runs:
> > >>
> > >> [    3.921654] alg: skcipher: xts-aes-caam encryption unexpectedly s=
ucceeded on test vector "random: len=3D40 klen=3D64"; expected_error=3D-22,=
 cfg=3D"random: inplace use_finup nosimd src_divs=3D[57.93%@+11, 37.18%@+16=
4, <reimport>0.68%@+4, 0.50%@+305, 3.71%@alignmask+3975]"
> > >>
> > >> [    3.726698] alg: skcipher: xts-aes-caam encryption unexpectedly s=
ucceeded on test vector "random: len=3D369 klen=3D64"; expected_error=3D-22=
, cfg=3D"random: inplace may_sleep use_digest src_divs=3D[100.0%@alignmask+=
584]"
> > >>
> > >> [    3.741082] alg: skcipher: xts-aes-caam encryption unexpectedly s=
ucceeded on test vector "random: len=3D2801 klen=3D64"; expected_error=3D-2=
2, cfg=3D"random: inplace may_sleep use_digest src_divs=3D[100.0%@+6] iv_of=
fset=3D18"
> > >>
> > >> It looks like the problem is not in CAAM driver.
> > >> More exactly, fuzz testing is generating random test vectors and run=
ning
> > >> them through both SW generic (crypto/xts.c) and CAAM implementation:
> > >> -SW generic implementation of xts(aes) does not support ciphertext s=
tealing
> > >> and throws -EINVAL when input is not a multiple of AES block size (1=
6B)
> > >> -caam has support for ciphertext stealing, and allows for any input =
size
> > >> which results in "unexpectedly succeeded" error messages.
> > >>
> > >> Any suggestion how this should be fixed?
> > >>
> > >> Thanks,
> > >> Horia
> > >
> > > I don't think drivers should allow inputs the generic implementation =
doesn't,
> > > since those inputs aren't tested by the crypto self-tests (so how do =
you know
> > How about implementation adding static test vectors and using them to v=
alidate
> > the standard feature set that's not supported by the generic implementa=
tion?
> >
> > > it's even correct?), and people could accidentally rely on the driver=
-specific
> > > behavior and then be unable to migrate to another platform or impleme=
ntation.
> > >
> > People could also *intentionally* rely on a driver offering an implemen=
tation
> > that is closer to the spec / standard.
> >
> > > So for now I recommend just updating the caam driver to return -EINVA=
L on XTS
> > > inputs not evenly divisible by the block size.
> > >
> > I was hoping for something more constructive...
> >
> > > Of course, if there are actual use cases for XTS with ciphertext stea=
ling in the
> > > kernel, we could add it to all the other implementations too.  But I'=
m not aware
> > > of any currently.  Don't all XTS users in the kernel pass whole block=
s?
> > >
> > That's my guess too.
> >
> > What about user space relying on offloading and xts working
> > according to the spec?
> >
>
> Sure, AF_ALG users could expect ciphertext stealing to work.  I don't kno=
w of
> any actual examples of people saying they want it, but it's possible.
>
> My point is simply that we add this, we need to find a way to support it =
in all
> implementations.  It's not helpful to add it to only one specific driver,=
 as
> then it's inconsistent and is untestable with the common tests.
>

IIRC there are different ways to implement CTS, and the cts template
we have in the kernel (which is used for CBC in some cases) implements
the flavor where the last two blocks are reordered if the input size
is an exact multiple of the block size. If your CTS implementation
does not implement this reordering (which seems to be the case since
it is compatible with plain XTS), it implements CTS in an incompatible
way.

Since the kernel does not support CTS for XTS any way, and since no
AF_ALG users can portably rely on this, I agree with Eric that the
only sensible way to address this is to disable this functionality in
the driver.

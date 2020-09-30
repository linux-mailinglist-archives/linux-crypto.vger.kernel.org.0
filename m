Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D925327EE34
	for <lists+linux-crypto@lfdr.de>; Wed, 30 Sep 2020 18:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgI3QDq (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 30 Sep 2020 12:03:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgI3QDq (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 30 Sep 2020 12:03:46 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A59920B1F;
        Wed, 30 Sep 2020 16:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601481825;
        bh=d/UjG1nCA1JG1VOl7i+9DvO19UCGEZ9Pdk/X/fb/ck8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wzDoDL/qM/Yr0keCU1jzREn08ZPYsNisltjAzc3f4vAn4wsl2W7uoUPhxPImmzpst
         SImiiaeh80Tv1oN/CLEQChq5Iqy+flOvgDHDeU3xdikc55FFlI7tjsYp744z/LiyWi
         X/k2vJcHsoB3xILrSG+mxNRc7rPsb/SoV4T3acYI=
Received: by mail-ot1-f42.google.com with SMTP id 60so2339861otw.3;
        Wed, 30 Sep 2020 09:03:45 -0700 (PDT)
X-Gm-Message-State: AOAM5305egLXfsphWrFZkEF95gMd4nU/7c2tuT2BOjKuZVExJ4uvkhFj
        L+hnz/JmUkb9okCaps1UFcipwsSo18IK0JSOWyc=
X-Google-Smtp-Source: ABdhPJx9uZma2udofiaFu+pMAJ3U7PlPQjF1ps5+9/+UIA10uI7fIWGY7tBvGFRSGepCVP85EfK3bYfKIoTWI8TWRjY=
X-Received: by 2002:a9d:6193:: with SMTP id g19mr1938806otk.108.1601481824405;
 Wed, 30 Sep 2020 09:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200930130123.8064-1-colin.king@canonical.com> <CAAUqJDuDsgLZ_7i=knqFNkqWJn+G3FqE3Yv=RBLr27mBMJk1Cg@mail.gmail.com>
In-Reply-To: <CAAUqJDuDsgLZ_7i=knqFNkqWJn+G3FqE3Yv=RBLr27mBMJk1Cg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 30 Sep 2020 18:03:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF2AzFkcyWzUHagq4xD_4BHpiscrPurndmJmJyp2KgXJg@mail.gmail.com>
Message-ID: <CAMj1kXF2AzFkcyWzUHagq4xD_4BHpiscrPurndmJmJyp2KgXJg@mail.gmail.com>
Subject: Re: [PATCH][next][resend] lib/mpi: fix off-by-one check on index "no"
To:     =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc:     Colin King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Waiman Long <longman@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, 30 Sep 2020 at 16:36, Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.co=
m> wrote:
>
> st 30. 9. 2020 o 15:04 Colin King <colin.king@canonical.com> nap=C3=ADsal=
(a):
> >
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > There is an off-by-one range check on the upper limit of
> > index "no".  Fix this by changing the > comparison to >=3D
>
> Note that this doesn't completely fix the bug though... (see below)
>

And by the same reasoning, it does not address the coverity issue
either, since the out of bounds read is still executed.


> >
> > Addresses-Coverity: ("Out-of-bounds read")
> > Fixes: a8ea8bdd9df9 ("lib/mpi: Extend the MPI library")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >
> > resend to Cc linux-crypto
> >
> > ---
> >  lib/mpi/mpiutil.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/mpi/mpiutil.c b/lib/mpi/mpiutil.c
> > index 3c63710c20c6..632d0a4bf93f 100644
> > --- a/lib/mpi/mpiutil.c
> > +++ b/lib/mpi/mpiutil.c
> > @@ -69,7 +69,7 @@ postcore_initcall(mpi_init);
> >   */
> >  MPI mpi_const(enum gcry_mpi_constants no)
> >  {
> > -       if ((int)no < 0 || no > MPI_NUMBER_OF_CONSTANTS)
> > +       if ((int)no < 0 || no >=3D MPI_NUMBER_OF_CONSTANTS)
> >                 pr_err("MPI: invalid mpi_const selector %d\n", no);
>
> What the code does is it just logs an error if the value is out of
> range, but then it happily continues dereferencing the array anyway...
> In the original libgcrypt code [1] (which BTW needs this patch, too),
> there is log_bug() instead of pr_err(), which doesn't just log the
> error, but also abort()'s the program. BUG() would be the correct
> kernel equivalent for log_bug(). It seems the whole kernel's MPI
> library clone should be re-audited for other instances of pr_*()'s
> that should in fact be BUG()'s (or even better, WARN_ONCE()'s with
> proper error handling, but that might diverge the code from libgcrypt
> too much...).
>
> [1] https://github.com/gpg/libgcrypt/blob/9cd92ebae21900e54cc3d8b607c8ed1=
afbf2eb9b/mpi/mpiutil.c#L773
>
> >         if (!constants[no])
> >                 pr_err("MPI: MPI subsystem not initialized\n");
> > --
> > 2.27.0
> >

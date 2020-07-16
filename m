Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC442226C8
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Jul 2020 17:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgGPPU3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Jul 2020 11:20:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbgGPPUX (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Jul 2020 11:20:23 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3BFA2083B
        for <linux-crypto@vger.kernel.org>; Thu, 16 Jul 2020 15:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594912821;
        bh=oUgm/EuJa3rPuMdC1GCupJ84JH7kj9z9B8yh/XTG10k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SvPHOlsnyG/lUXyDbL9RU3Uvl7Jn503DtY3yWmU2I16PtuJXQ4uwGu4IXrCtU75Ky
         1Xo5bZAzq5rGCG9VlCa11JtkCthXjp6kCnEiA2obYER1kO1RNhdlTkKGpkZcUHlD8J
         YQEOtRFEUH4fknxYogp+mHpntaxGUAYiRqcLWUZY=
Received: by mail-ot1-f42.google.com with SMTP id 18so4480154otv.6
        for <linux-crypto@vger.kernel.org>; Thu, 16 Jul 2020 08:20:20 -0700 (PDT)
X-Gm-Message-State: AOAM530HrL2Qz9RhJeFE5vXnIlJsdyt2Ew695AcDEn7FK8D1V6TCUUOm
        5TaNCwAGVHZFIk4iIq2aWhqfcCyp7MA8BhmG0BE=
X-Google-Smtp-Source: ABdhPJxRMsfF9VOBOwwSVfLTho/RNdjPFp0RjLPKYwuzNJjRvl8cCytWevot8BCQMkrxersUA+evNJh7uxZmE9lUX5U=
X-Received: by 2002:a9d:7553:: with SMTP id b19mr5173994otl.77.1594912819924;
 Thu, 16 Jul 2020 08:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <5722559.lOV4Wx5bFT@positron.chronox.de> <4650810.GXAFRqVoOG@positron.chronox.de>
 <20200716073032.GA28173@gondor.apana.org.au> <CAMj1kXHNM5pwjSuVgxP2SA5juTnVxpj0ULUkjNWuoHqVTjuE8Q@mail.gmail.com>
 <20200716125002.oxr7yyeehz74mgq4@valinor> <CAMj1kXHBmgaQKDQoVd-wN0JpKunE53QRg6uQ=3fRZmpNw=drYg@mail.gmail.com>
 <20200716134128.7br6npd2nsck33qm@valinor> <CAMj1kXGJMBLxPX9RuHai9JK_5wQSufEzN4arHLVE_pSnsbGzuQ@mail.gmail.com>
 <20200716142345.bpnenw5j6yhrhjq5@valinor> <CAMj1kXHD4_nXydFnCwsjV_fyvmiD=L8QPBVudmnQfAJYfhu82g@mail.gmail.com>
 <20200716145649.zjhccwgty5i5pfpp@valinor>
In-Reply-To: <20200716145649.zjhccwgty5i5pfpp@valinor>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 16 Jul 2020 18:20:08 +0300
X-Gmail-Original-Message-ID: <CAMj1kXH4i=4YwDnH3C9zLHapFw9ViUNr7nFwirnrnZPJOKQkdA@mail.gmail.com>
Message-ID: <CAMj1kXH4i=4YwDnH3C9zLHapFw9ViUNr7nFwirnrnZPJOKQkdA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] lib/mpi: Add mpi_sub_ui()
To:     Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        =?UTF-8?Q?Stephan_M=C3=BCller?= <smueller@chronox.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, nhorman@redhat.com,
        simo@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, 16 Jul 2020 at 17:56, Marcelo Henrique Cerri
<marcelo.cerri@canonical.com> wrote:
>
> On Thu, Jul 16, 2020 at 05:37:32PM +0300, Ard Biesheuvel wrote:
> > On Thu, 16 Jul 2020 at 17:23, Marcelo Henrique Cerri
> > <marcelo.cerri@canonical.com> wrote:
> > >
> > > On Thu, Jul 16, 2020 at 04:53:24PM +0300, Ard Biesheuvel wrote:
> > > > On Thu, 16 Jul 2020 at 16:41, Marcelo Henrique Cerri
> > > > <marcelo.cerri@canonical.com> wrote:
> > > > >
> > > > > On Thu, Jul 16, 2020 at 04:09:39PM +0300, Ard Biesheuvel wrote:
> > > > > > On Thu, 16 Jul 2020 at 15:50, Marcelo Henrique Cerri
> > > > > > <marcelo.cerri@canonical.com> wrote:
> > > > > > >
> > > > > > > No. The code is really based on Gnu MP. I used the header fro=
m
> > > > > > > lib/mpi/mpi-pow.c as reference and that's source of the menti=
on to
> > > > > > > GnuPG that went unnoticed by me.
> > > > > > >
> > > > > >
> > > > > > So where did the file lib/mpi/mpi-sub-ui.c come from? From GnuP=
G or
> > > > > > from GnuMP? Did you modify the license statement? Because as pr=
oposed,
> > > > > > this patch clearly is not acceptable from GPL compliance  point=
 of
> > > > > > view.
> > > > >
> > > > > Sorry for the confusion. The code is from Gnu MP (not GnuPG).
> > > > >
> > > > > Gnu MP is distributed under either LGPLv3 or later or GPLv2 or la=
ter
> > > > > (check their license statement on the aors_ui.h file below).
> > > > >
> > > > > For mpi-sub-ui.h I added a SPDX identifier for GPLv2 or later and=
 I
> > > > > kept the FSF copyright line.
> > > > >
> > > > > I also used the header from mpi-powm.c as a reference basically t=
o
> > > > > inform the code was changed from its original form.
> > > > >
> > > > > Here lies my mistake, I didn't notice that part was referring to =
GnuPG
> > > > > instead of Gnu MP.
> > > > >
> > > > > So mpi-sub-ui.h header was actually intended to be:
> > > > >
> > > > >     // SPDX-License-Identifier: GPL-2.0-or-later
> > > > >     /* mpi-sub-ui.c  -  MPI functions
> > > > >      *      Copyright 1991, 1993, 1994, 1996, 1999-2002, 2004, 20=
12, 2013, 2015
> > > > >      *      Free Software Foundation, Inc.
> > > > >      *
> > > > >      * This file is part of Gnu MP.
> > > > >      *
> > > > >      * Note: This code is heavily based on the GNU MP Library.
> > > > >      *      Actually it's the same code with only minor changes i=
n the
> > > > >      *      way the data is stored; this is to support the abstra=
ction
> > > > >      *      of an optional secure memory allocation which may be =
used
> > > > >      *      to avoid revealing of sensitive data due to paging et=
c.
> > > > >      *      The GNU MP Library itself is published under the LGPL=
;
> > > > >      *      however I decided to publish this code under the plai=
n GPL.
> > > > >      */
> > > > >
> > > > > Or maybe instead of "This file is part of Gnu MP.", "This file is
> > > > > based on Gnu MP" might be more appropriate.
> > > > >
> > > > > Do you have any license concerns considering this updated header?
> > > > >
> > > >
> > > > Yes. How can this code be both part of GnuMP *and* be heavily based=
 on
> > > > it, but with changes?
> > > >
>
> The final mpi-sub-ui.c is not part of Gnu MP, but heavily based on it
> sounds very accurate to me.
>
> >
> > You haven't answered this question yet. I suppose you just slapped a
> > different license text on this file, one that already existed in
> > lib/mpi?
>
> Correct. The copyright line I used matches the original copyright from
> Gnu MP.
>
> The "This file is part..." line and the Note is the same from
> mpi/lib/mpi-powm.c.
>
> However I'm proposing the removal of that part in favor of the new
> header I listed below based on Gnu MP header.
>
> >
> > > > Please avoid making changes to the original header, just add the SP=
DX
> > > > header in front, and add a clear justification in the commit log wh=
ere
> > > > the file came from (preferably including git url and commit ID), an=
d
> > > > what you based your assertion on that its license is compatible wit=
h
> > > > GPLv2.
> > >
> > > The commit message is stating the origin, but I can add a reference t=
o
> > > the mercurial repo with its corresponding id.
> > >
> >
> > Yes, please.
> >
> > > >
> > > > Ideally, you would import the file *exactly* as it appears in the
> > > > upstream in one patch (with the above justification), and apply any
> > > > necessary changes in a subsequent patch, so it's  crystal clear tha=
t
> > > > we are complying with the original license.
> > >
> > > I'm not sure that's the ideal approach for this case. The logic is th=
e
> > > same but since naming convention, macros, data types and etc are
> > > pretty different everything was basically re-written to fit the
> > > kernel. Adding the original file and then massively changing will jus=
t
> > > add unnecessary noise.
> > >
> >
> > Do any of these modifications resemble the changes made to the GnuPG
> > versions of these routines?
>
> I haven't looked at the GnuPG code at all. Neither while I was
> preparing this patch, neither after or before. So I can affirm this
> patch has no influence of GnuPG code at all.
>
> But if you want to be sure I can check that. Please let me know.
>

No please don't. If you never looked at it, no reason to do it now.

> As I said, the GnuPG reference came from me trying to re-use the
> header from kernel's lib/mpi/mpi-powm.c file.
>

Fair enough. In that case, i have no objections.


> >
> > > If you agree I will update the commit message with more details about
> > > the original source and then just update the comment header in
> > > mpi-sub-ui.c following closely the original header with minor
> > > adjustments to explain its origin and to fix some checkpatch warnings=
.
> > >
> >
> > That is fine, provided that none of our modifications were taken from
> > the GnuPG version of this file without giving credit.
>
> I can assure I haven't used any code from GnuPG at all.
>
> >
> >
> > > Something like that:
> > >
> > > // SPDX-License-Identifier: GPL-2.0-or-later
> > > /* mpi-sub-ui.c - Subtract an unsigned integer from an MPI.
> > >  *
> > >  * Copyright 1991, 1993, 1994, 1996, 1999-2002, 2004, 2012, 2013, 201=
5
> > >  * Free Software Foundation, Inc.
> > >  *
> > >  * This file was based on the GNU MP Library source file:
> > >  * https://gmplib.org/repo/gmp-6.2/file/tip/mpz/aors_ui.h
> > >  *
> > >  * The GNU MP Library is free software; you can redistribute it and/o=
r modify
> > >  * it under the terms of either:
> > >  *
> > >  *   * the GNU Lesser General Public License as published by the Free
> > >  *     Software Foundation; either version 3 of the License, or (at y=
our
> > >  *     option) any later version.
> > >  *
> > >  * or
> > >  *
> > >  *   * the GNU General Public License as published by the Free Softwa=
re
> > >  *     Foundation; either version 2 of the License, or (at your optio=
n) any
> > >  *     later version.
> > >  *
> > >  * or both in parallel, as here.
> > >  *
> > >  * The GNU MP Library is distributed in the hope that it will be usef=
ul, but
> > >  * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHAN=
TABILITY
> > >  * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public L=
icense
> > >  * for more details.
> > >  *
> > >  * You should have received copies of the GNU General Public License =
and the
> > >  * GNU Lesser General Public License along with the GNU MP Library.  =
If not,
> > >  * see https://www.gnu.org/licenses/.
> > >  */
> > >
> > > >
> > > >
> > > >
> > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > > You can find the original Gnu MP source that I used as refere=
nce in
> > > > > > > the file gmp-6.2.0/mpz/aors_ui.h from:
> > > > > > >
> > > > > > > https://gmplib.org/download/gmp/gmp-6.2.0.tar.lz
> > > > > > >
> > > > > > > I'm pasting the contents of gmp-6.2.0/mpz/aors_ui.h below for
> > > > > > > reference. Do you think we should use or adapt the original h=
eader
> > > > > > > instead?
> > > > > > >
> > > > > > > That said, assuming the patch set submitted by Tianjia is upd=
ated to
> > > > > > > ensure that mpi_sub_ui() and other functions are returning al=
location
> > > > > > > errors, we could drop this patch in favor of that patch set t=
hat is
> > > > > > > more extensive and also provides an implementation to mpi_sub=
_ui().
> > > > > > >
> > > > > > >
> > > > > > > --->8---
> > > > > > > /* mpz_add_ui, mpz_sub_ui -- Add or subtract an mpz_t and an =
unsigned
> > > > > > >    one-word integer.
> > > > > > >
> > > > > > > Copyright 1991, 1993, 1994, 1996, 1999-2002, 2004, 2012, 2013=
, 2015
> > > > > > > Free Software Foundation, Inc.
> > > > > > >
> > > > >
> > > > >
> > > > > Gnu MP license -.
> > > > >                 V
> > > > >
> > > > >
> > > > > > > This file is part of the GNU MP Library.
> > > > > > >
> > > > > > > The GNU MP Library is free software; you can redistribute it =
and/or modify
> > > > > > > it under the terms of either:
> > > > > > >
> > > > > > >   * the GNU Lesser General Public License as published by the=
 Free
> > > > > > >     Software Foundation; either version 3 of the License, or =
(at your
> > > > > > >     option) any later version.
> > > > > > >
> > > > > > > or
> > > > > > >
> > > > > > >   * the GNU General Public License as published by the Free S=
oftware
> > > > > > >     Foundation; either version 2 of the License, or (at your =
option) any
> > > > > > >     later version.
> > > > > > >
> > > > > > > or both in parallel, as here.
> > > > > > >
> > > > > > > The GNU MP Library is distributed in the hope that it will be=
 useful, but
> > > > > > > WITHOUT ANY WARRANTY; without even the implied warranty of ME=
RCHANTABILITY
> > > > > > > or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Pub=
lic License
> > > > > > > for more details.
> > > > > > >
> > > > > > > You should have received copies of the GNU General Public Lic=
ense and the
> > > > > > > GNU Lesser General Public License along with the GNU MP Libra=
ry.  If not,
> > > > > > > see https://www.gnu.org/licenses/.  */
> > > > > > >
> > > > > > > #include "gmp-impl.h"
> > > > > > >
> > > > > > >
> > > > > > > #ifdef OPERATION_add_ui
> > > > > > > #define FUNCTION          mpz_add_ui
> > > > > > > #define FUNCTION2         mpz_add
> > > > > > > #define VARIATION_CMP     >=3D
> > > > > > > #define VARIATION_NEG
> > > > > > > #define VARIATION_UNNEG   -
> > > > > > > #endif
> > > > > > >
> > > > > > > #ifdef OPERATION_sub_ui
> > > > > > > #define FUNCTION          mpz_sub_ui
> > > > > > > #define FUNCTION2         mpz_sub
> > > > > > > #define VARIATION_CMP     <
> > > > > > > #define VARIATION_NEG     -
> > > > > > > #define VARIATION_UNNEG
> > > > > > > #endif
> > > > > > >
> > > > > > > #ifndef FUNCTION
> > > > > > > Error, need OPERATION_add_ui or OPERATION_sub_ui
> > > > > > > #endif
> > > > > > >
> > > > > > >
> > > > > > > void
> > > > > > > FUNCTION (mpz_ptr w, mpz_srcptr u, unsigned long int vval)
> > > > > > > {
> > > > > > >   mp_srcptr up;
> > > > > > >   mp_ptr wp;
> > > > > > >   mp_size_t usize, wsize;
> > > > > > >   mp_size_t abs_usize;
> > > > > > >
> > > > > > > #if BITS_PER_ULONG > GMP_NUMB_BITS  /* avoid warnings about s=
hift amount */
> > > > > > >   if (vval > GMP_NUMB_MAX)
> > > > > > >     {
> > > > > > >       mpz_t v;
> > > > > > >       mp_limb_t vl[2];
> > > > > > >       PTR(v) =3D vl;
> > > > > > >       vl[0] =3D vval & GMP_NUMB_MASK;
> > > > > > >       vl[1] =3D vval >> GMP_NUMB_BITS;
> > > > > > >       SIZ(v) =3D 2;
> > > > > > >       FUNCTION2 (w, u, v);
> > > > > > >       return;
> > > > > > >     }
> > > > > > > #endif
> > > > > > >
> > > > > > >   usize =3D SIZ (u);
> > > > > > >   if (usize =3D=3D 0)
> > > > > > >     {
> > > > > > >       MPZ_NEWALLOC (w, 1)[0] =3D vval;
> > > > > > >       SIZ (w) =3D VARIATION_NEG (vval !=3D 0);
> > > > > > >       return;
> > > > > > >     }
> > > > > > >
> > > > > > >   abs_usize =3D ABS (usize);
> > > > > > >
> > > > > > >   /* If not space for W (and possible carry), increase space.=
  */
> > > > > > >   wp =3D MPZ_REALLOC (w, abs_usize + 1);
> > > > > > >
> > > > > > >   /* These must be after realloc (U may be the same as W).  *=
/
> > > > > > >   up =3D PTR (u);
> > > > > > >
> > > > > > >   if (usize VARIATION_CMP 0)
> > > > > > >     {
> > > > > > >       mp_limb_t cy;
> > > > > > >       cy =3D mpn_add_1 (wp, up, abs_usize, (mp_limb_t) vval);
> > > > > > >       wp[abs_usize] =3D cy;
> > > > > > >       wsize =3D VARIATION_NEG (abs_usize + cy);
> > > > > > >     }
> > > > > > >   else
> > > > > > >     {
> > > > > > >       /* The signs are different.  Need exact comparison to d=
etermine
> > > > > > >          which operand to subtract from which.  */
> > > > > > >       if (abs_usize =3D=3D 1 && up[0] < vval)
> > > > > > >         {
> > > > > > >           wp[0] =3D vval - up[0];
> > > > > > >           wsize =3D VARIATION_NEG 1;
> > > > > > >         }
> > > > > > >       else
> > > > > > >         {
> > > > > > >           mpn_sub_1 (wp, up, abs_usize, (mp_limb_t) vval);
> > > > > > >           /* Size can decrease with at most one limb.  */
> > > > > > >           wsize =3D VARIATION_UNNEG (abs_usize - (wp[abs_usiz=
e - 1] =3D=3D 0));
> > > > > > >         }
> > > > > > >     }
> > > > > > >
> > > > > > >   SIZ (w) =3D wsize;
> > > > > > > }
> > > > > > > --->*---
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > On Thu, Jul 16, 2020 at 11:41:17AM +0300, Ard Biesheuvel wrot=
e:
> > > > > > > > On Thu, 16 Jul 2020 at 10:30, Herbert Xu <herbert@gondor.ap=
ana.org.au> wrote:
> > > > > > > > >
> > > > > > > > > On Sun, Jul 12, 2020 at 06:39:54PM +0200, Stephan M=C3=BC=
ller wrote:
> > > > > > > > > >
> > > > > > > > > > diff --git a/lib/mpi/mpi-sub-ui.c b/lib/mpi/mpi-sub-ui.=
c
> > > > > > > > > > new file mode 100644
> > > > > > > > > > index 000000000000..fa6b085bac36
> > > > > > > > > > --- /dev/null
> > > > > > > > > > +++ b/lib/mpi/mpi-sub-ui.c
> > > > > > > > > > @@ -0,0 +1,60 @@
> > > > > > > > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > > > > > > > +/* mpi-sub-ui.c  -  MPI functions
> > > > > > > > > > + *      Copyright 1991, 1993, 1994, 1996, 1999-2002, 2=
004, 2012, 2013, 2015
> > > > > > > > > > + *      Free Software Foundation, Inc.
> > > > > > > > > > + *
> > > > > > > > > > + * This file is part of GnuPG.
> > > > > > > > > > + *
> > > > > > > > > > + * Note: This code is heavily based on the GNU MP Libr=
ary.
> > > > > > > > > > + *    Actually it's the same code with only minor chan=
ges in the
> > > > > > > > > > + *    way the data is stored; this is to support the a=
bstraction
> > > > > > > > > > + *    of an optional secure memory allocation which ma=
y be used
> > > > > > > > > > + *    to avoid revealing of sensitive data due to pagi=
ng etc.
> > > > > > > > > > + *    The GNU MP Library itself is published under the=
 LGPL;
> > > > > > > > > > + *    however I decided to publish this code under the=
 plain GPL.
> > > > > > > > > > + */
> > > > > > > > >
> > > > > > > > > Hmm, you said that this code is from GNU MP.  But this no=
tice clearly
> > > > > > > > > says that it's part of GnuPG and is under GPL.  Though it=
 doesn't
> > > > > > > > > clarify what version of GPL it is.  Can you please clarif=
y this with
> > > > > > > > > the author?
> > > > > > > > >
> > > > > > > >
> > > > > > > > GnuPG was relicensed under GPLv3 in ~2007, IIRC, so given t=
he
> > > > > > > > copyright years and the explicit statements that the file i=
s part of
> > > > > > > > GnuPG and not under the original LGPL license, there is no =
way we can
> > > > > > > > take this code under the kernel's GPLv2 license.
> > > > > > >
> > > > > > > --
> > > > > > > Regards,
> > > > > > > Marcelo
> > > > > > >
> > > > >
> > > > > --
> > > > > Regards,
> > > > > Marcelo
> > > > >
> > >
> > > --
> > > Regards,
> > > Marcelo
> > >
>
> --
> Regards,
> Marcelo
>

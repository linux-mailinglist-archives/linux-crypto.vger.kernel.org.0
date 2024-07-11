Return-Path: <linux-crypto+bounces-5553-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC99092F008
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jul 2024 21:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE7D1C20ED7
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jul 2024 19:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C1B19E83B;
	Thu, 11 Jul 2024 19:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qptw++qi"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69C6450FA
	for <linux-crypto@vger.kernel.org>; Thu, 11 Jul 2024 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720727978; cv=none; b=pPOlnbTTxVfcNKiL+9+03pMHKg5VZl1S46YvcwRpwiAd1GfYttqCksvdtf/lIe34H9rHviI8iLR7H14TRGXJn9iwxqvRCCMIJ6N9QQpPybwBvynEl7L3EamkuH9ZdhFtwcMzb3H3xnJJUKSN9mSWAKeYT282Sn9eOBMj8nk92Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720727978; c=relaxed/simple;
	bh=EwcI560szzXCbpyfgDyYof692YXwxRMkFI4AdQM+lcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cG/oJJseen+s8geOB26bHJ/dkllEvsWc0nhPqQZ7XpNzHCX4M8HQ+L2I8EgDB5JK3Pct+8prO3dQp9GPpcVmcmpIQU/vf5BZgQnEUJJpFfEEzVZ1M04eJWwJT7aT5ktdPydm9CIs9Xpn9OvLPZcxmBDkswhrzPqmjnd2McTew4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qptw++qi; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44a8b140a1bso57081cf.0
        for <linux-crypto@vger.kernel.org>; Thu, 11 Jul 2024 12:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720727975; x=1721332775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usQgq2qcD076ORgLl9lg0b15V7evrXBpIxDm3sw86OY=;
        b=qptw++qixRwPsC5loItR03SgoDryBucQvldLH8j3mPnYCa8Jl8M3xp2NHqaIJCioDB
         B1d05m+xuXwQc29IaOwe1MvIxtyUmzeIe/ZsJbe22tAdezD8FdnXYz32lpCHKwnkdq9n
         ykah1rR7z3JUj8z3KXcnqtzTUpDtjXBHcIKL6nh5awf/Pg9Ut5+NulBBPsNCxFGmOIGL
         nDvVnNyNuicZ/lK2O5ZdcXh/UCQi6lNN3Gbi6E8p6tKKQN/M464qxYfoOc7HFM+cZxPp
         MhWyBLccduYxNp4FQvot/iwxDOkicyeW2xly7PAAKFW77W9ipQOp3iQzOhLnb8UvhdJ+
         uOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720727975; x=1721332775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usQgq2qcD076ORgLl9lg0b15V7evrXBpIxDm3sw86OY=;
        b=G7bRY9i67HYCp1YOzB2FLaetJejle7OyeC5Bi58Qo80rK1yUzMu8mfOoJWdY0nLBuA
         eZp8X9T9G4JPVkfBTdRoG1U84n3B5xoYKqAuTNaVzXvzQxLIP9GDvam32IRqqUo1Ls7u
         Hngv87hsYiZy50jcIYjzgwyp480Aigzkm+TDWxZWMwh2vcS+NLOx4aMgg3WrQ1yidEAP
         KUaKyz5Z9+4/j/k1YXfXB0n1cvxyN8Ng+0Inb4o++Glu+6bUuBRTe4RPms6DjaRGaKUr
         UoVykmKojFYoY/UUsCtfEsxuUdOvK+3jm7zVt2DMZmgaeqK/uzxjsr0aw9062gg8DFbR
         vp+A==
X-Forwarded-Encrypted: i=1; AJvYcCU64J+jAP4vhrtPAW3+pXGfiFup8MIIZJ3C2wjI/CJYmjzM9Z1Mzca+vjw4bWRA27CSYIcLv42u9ptJMv2pHhvmcdnpHH9PhjwqufoK
X-Gm-Message-State: AOJu0YyEhkbWYpCG42Xi6dktSZukDjBDi/EkbmFlic+k/1P7ZoixyTN7
	mbxiAuODrJWdJVxiSW0Ak9yqVhVs68h31LVbEU34HcKU76hNXZuIAPhxb+TAGUS78FpxYC3pxCK
	7vJNiMMjLBH6wdBR2XvBYjHax0eY6d+PlOKk7
X-Google-Smtp-Source: AGHT+IEM7irFssvF1uct5oQd7x7Vaba9daG5UqSQAd7zGLlxjvcWer92aqHngywJVogpDpoHiV+PdmFmORbjnMYXigE=
X-Received: by 2002:ac8:7193:0:b0:447:d555:7035 with SMTP id
 d75a77b69052e-44e793e6f9dmr475651cf.13.1720727974558; Thu, 11 Jul 2024
 12:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bf51a483-8725-4222-937f-3d6c66876d34@redhat.com>
 <CAHk-=wh=vzhiDSNaLJdmjkhLqevB8+rhE49pqh0uBwhsV=1ccQ@mail.gmail.com>
 <ZpAR0CgLc28gEkV3@zx2c4.com> <ZpATx21F_01SBRnO@zx2c4.com> <98798483-dfcd-451e-94bb-57d830bf68d8@redhat.com>
 <54b6de32-f127-4928-9f4a-acb8653e5c81@redhat.com> <ZpAcWvij59AzUD9u@zx2c4.com>
 <ZpAc118_U7p3u2gZ@zx2c4.com> <ZpAfigBHfHdVeyNO@zx2c4.com> <8586b19c-2e14-4164-888f-8c3b86f3f963@redhat.com>
 <ZpAqbh3TnB9hIRRh@zx2c4.com> <443146f4-9db8-4a19-91f1-b6822fad8ce8@redhat.com>
 <1c8632b4-06a5-49da-be0c-6fc7ac2b3257@redhat.com> <2c464271-1c61-4cd8-bd4e-4bd8aa01fa00@redhat.com>
 <CAOUHufYsxCb=taWWfUbuzi1Hmmug=ThQMoTjsxrtFkt=UXEu6w@mail.gmail.com> <da3ea234-d6dd-4809-b2f5-fbfedacb9748@redhat.com>
In-Reply-To: <da3ea234-d6dd-4809-b2f5-fbfedacb9748@redhat.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 11 Jul 2024 13:58:57 -0600
Message-ID: <CAOUHufZuMdN31WnbwctyFv+o8nAfVBaiHZa9Ud_cz6QAoNQHxw@mail.gmail.com>
Subject: Re: [PATCH v22 1/4] mm: add MAP_DROPPABLE for designating always
 lazily freeable mappings
To: David Hildenbrand <david@redhat.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, tglx@linutronix.de, 
	linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, "Carlos O'Donell" <carlos@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 1:53=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 11.07.24 21:49, Yu Zhao wrote:
> > On Thu, Jul 11, 2024 at 1:20=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 11.07.24 21:18, David Hildenbrand wrote:
> >>> On 11.07.24 20:56, David Hildenbrand wrote:
> >>>> On 11.07.24 20:54, Jason A. Donenfeld wrote:
> >>>>> On Thu, Jul 11, 2024 at 08:24:07PM +0200, David Hildenbrand wrote:
> >>>>>>> And PG_large_rmappable seems to only be used for hugetlb branches=
.
> >>>>>>
> >>>>>> It should be set for THP/large folios.
> >>>>>
> >>>>> And it's tested too, apparently.
> >>>>>
> >>>>> Okay, well, how disappointing is this below? Because I'm running ou=
t of
> >>>>> tricks for flag reuse.
> >>>>>
> >>>>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.=
h
> >>>>> index b9e914e1face..c1ea49a7f198 100644
> >>>>> --- a/include/linux/page-flags.h
> >>>>> +++ b/include/linux/page-flags.h
> >>>>> @@ -110,6 +110,7 @@ enum pageflags {
> >>>>>              PG_workingset,
> >>>>>              PG_error,
> >>>>>              PG_owner_priv_1,        /* Owner use. If pagecache, fs=
 may use*/
> >>>>> +   PG_owner_priv_2,
> >>>>
> >>>> Oh no, no new page flags please :)
> >>>>
> >>>> Maybe just follow what Linux suggested: pass vma to pte_dirty() and
> >>>> always return false for these special VMAs.
> >>>
> >>> ... or look into removing that one case that gives us headake.
> >>>
> >>> No idea what would happen if we do the following:
> >>>
> >>> CCing Yu Zhao.
> >>>
> >>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >>> index 0761f91b407f..d1dfbd4fd38d 100644
> >>> --- a/mm/vmscan.c
> >>> +++ b/mm/vmscan.c
> >>> @@ -4280,14 +4280,9 @@ static bool sort_folio(struct lruvec *lruvec, =
struct folio *folio, struct scan_c
> >>>                    return true;
> >>>            }
> >>>
> >>> -       /* dirty lazyfree */
> >>> -       if (type =3D=3D LRU_GEN_FILE && folio_test_anon(folio) && fol=
io_test_dirty(folio)) {
> >>> -               success =3D lru_gen_del_folio(lruvec, folio, true);
> >>> -               VM_WARN_ON_ONCE_FOLIO(!success, folio);
> >>> -               folio_set_swapbacked(folio);
> >>> -               lruvec_add_folio_tail(lruvec, folio);
> >>> -               return true;
> >>> -       }
> >>> +       /* lazyfree: we may not be allowed to set swapbacked: MAP_DRO=
PPABLE */
> >>> +       if (type =3D=3D LRU_GEN_FILE && folio_test_anon(folio) && fol=
io_test_dirty(folio))
> >>> +               return false;
> >
> > This is an optimization to avoid an unnecessary trip to
> > shrink_folio_list(), so it's safe to delete the entire 'if' block, and
> > that would be preferable than leaving a dangling 'if'.
>
> Great, thanks.
>
> >
> >> Note that something is unclear to me: are we maybe running into that
> >> code also if folio_set_swapbacked() is already set and we are not in t=
he
> >> lazyfree path (in contrast to what is documented)?
> >
> > Not sure what you mean: either rmap sees pte_dirty() and does
> > folio_mark_dirty() and then folio_set_swapbacked(); or MGLRU does the
> > same sequence, with the first two steps in walk_pte_range() and the
> > last one here.
>
> Let me rephrase:
>
> Checking for lazyfree is
>
> "folio_test_anon(folio) && !folio_test_swapbacked(folio)"
>
> Testing for dirtied lazyfree is
>
> "folio_test_anon(folio) && !folio_test_swapbacked(folio) &&
>   folio_test)dirty(folio)"
>
> So I'm wondering about the missing folio_test_swapbacked() test.

It's not missing: type =3D=3D LRU_GEN_FILE means folio_is_file_lru(),
which in turn means !folio_test_swapbacked().


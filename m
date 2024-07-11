Return-Path: <linux-crypto+bounces-5551-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6642192EFF7
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jul 2024 21:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9FFAB21F67
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jul 2024 19:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4484B19E81D;
	Thu, 11 Jul 2024 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qjHISNC9"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DC8450FA
	for <linux-crypto@vger.kernel.org>; Thu, 11 Jul 2024 19:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720727577; cv=none; b=alTt789f455rIGkQVhpHN9fpjPtfGeL+49anvME2aokjxton9ob7+x+Ttf8ll24BmwdE2NN2ALsgrHIUO97Lr/Nbspb5wDXlnYD/stEZXrYe0OowpBdTrCjd+HkEpWLK9bNomxNtkEbGv0PwqJQw278KG8ouEy6RwI0NaF4rIWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720727577; c=relaxed/simple;
	bh=BHLYCw9AiDdDxI02/i1N/Y551p8ZdRGtZbwhDkLhftU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VyggmZAYAIcCMRzq0o/ljyOGKZFzejUrHRJTexeAOG1afOj17N0P6Y3RPJTpYbJsYfvF0uJv4kRs0aRCB+RhXZemeiCfHRDlaDpcLAPorgrylIAgjRJMTxgt20og2QG32DWJ5/9p9BtZaLz8oajiDpstzRnxdcvZXsvD/iBxEOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qjHISNC9; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-447f8aa87bfso64411cf.0
        for <linux-crypto@vger.kernel.org>; Thu, 11 Jul 2024 12:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720727574; x=1721332374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHgAo3rRH4U5qc7BWrC4nFyLG2iKDrJjpANnSFrKmzE=;
        b=qjHISNC9sj4C2iB6II8rOo012x6EIO9e82xioP12eOI/e2uB0j7j9DbzpyprwJFKZj
         jd8oC+1BD8WQXlLTKdDPdEyuvdU68o+rXQgH0a8YIbbCdR8cxMaq9ExhZ+aBom5SNLbz
         40uwQC5Cf7BFW6NU2Gz/T4CoMWOV+2YzCkq/rZdVS6OCpFi8vuKeSu0lAbkPVBVPXUKs
         gQWjNuX2JfzVer65znLhdqbmB+BRMHgUm3hqJdwOs4dDEaovCkEym4cYHDtF4/LI6qxQ
         stzgeH1pRIfrLSWlI7PwBDtwnSYU1r49FhXJJxcIMXQDP4zM/Phr3DDC5iSAn1FeNEKy
         2Ewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720727574; x=1721332374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHgAo3rRH4U5qc7BWrC4nFyLG2iKDrJjpANnSFrKmzE=;
        b=RU4vOiMaCgujqW5Df3qP32nBEBW8Fp2kllXR792cbgCsj7AXNyE9FLn5CkuPcC9M6M
         BsQyPSbFo1BZ63d4qcnw4FRIJp3hG1Kgt8SHwVstuUhGksFHSctcdL0TW224+Tn5Pe3o
         MBxd0xW/h/hq3/TNqYXjpoQzpM5/PGlPeOWdQrqPAFEZ9ev1mlTvkcWyw6Zqo16Rk5ev
         yl0jyYjgZ5QCjpF0r2KGnN+i+ZWTf1FD9KIioKXLaMOXJ4mzydH2I2qySQpeQReDNlKV
         wG6vbQpwaqlWOCChy7ttbqzSWABJMGKWOZRoDPgGHt2L3Uy+/Sodm77uuXmepuT8HAmY
         sMMA==
X-Forwarded-Encrypted: i=1; AJvYcCUY2EsGJU/P6fCYg4JF58FxNjesFC7s1u2ynJOO/tP/UWsdjeSHVqAOwb34PdT7sXi1cC1zVIirE/gcTLFOFOAclcBu2DHsdg9eHI3N
X-Gm-Message-State: AOJu0YzcRd0zvuPQOD6jv/nWL7DtbZ20xbI+ckQeyF30DRIHY5m/LvJw
	5P5L65mEJ8CzIPSA465ll1Co+3TKDLF9aT1GnBizKT62iC0Z1QqhonFaLmrxIdre9+5ozkskM9+
	xjlWu1lvqtK935bvWsdW3+0Lz86Oq2D9k10AA
X-Google-Smtp-Source: AGHT+IGKeJkhx6a4XleRbKMjIagaY0t0QQL4n9Gqq4+cocfHOlkStXS33F9UWAPAExqqLh8CHJRMXRGS62R1i6kGvs4=
X-Received: by 2002:ac8:4247:0:b0:444:fd8a:f1a0 with SMTP id
 d75a77b69052e-44e795d4e6dmr405751cf.25.1720727574342; Thu, 11 Jul 2024
 12:52:54 -0700 (PDT)
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
 <CAOUHufYsxCb=taWWfUbuzi1Hmmug=ThQMoTjsxrtFkt=UXEu6w@mail.gmail.com>
In-Reply-To: <CAOUHufYsxCb=taWWfUbuzi1Hmmug=ThQMoTjsxrtFkt=UXEu6w@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 11 Jul 2024 13:52:17 -0600
Message-ID: <CAOUHufZ83xV_k30pHf5zP+9bx_tm=qsSr3+FfkFLXhARjxhT=w@mail.gmail.com>
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

On Thu, Jul 11, 2024 at 1:49=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Thu, Jul 11, 2024 at 1:20=E2=80=AFPM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > On 11.07.24 21:18, David Hildenbrand wrote:
> > > On 11.07.24 20:56, David Hildenbrand wrote:
> > >> On 11.07.24 20:54, Jason A. Donenfeld wrote:
> > >>> On Thu, Jul 11, 2024 at 08:24:07PM +0200, David Hildenbrand wrote:
> > >>>>> And PG_large_rmappable seems to only be used for hugetlb branches=
.
> > >>>>
> > >>>> It should be set for THP/large folios.
> > >>>
> > >>> And it's tested too, apparently.
> > >>>
> > >>> Okay, well, how disappointing is this below? Because I'm running ou=
t of
> > >>> tricks for flag reuse.
> > >>>
> > >>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.=
h
> > >>> index b9e914e1face..c1ea49a7f198 100644
> > >>> --- a/include/linux/page-flags.h
> > >>> +++ b/include/linux/page-flags.h
> > >>> @@ -110,6 +110,7 @@ enum pageflags {
> > >>>             PG_workingset,
> > >>>             PG_error,
> > >>>             PG_owner_priv_1,        /* Owner use. If pagecache, fs =
may use*/
> > >>> +   PG_owner_priv_2,
> > >>
> > >> Oh no, no new page flags please :)
> > >>
> > >> Maybe just follow what Linux suggested: pass vma to pte_dirty() and
> > >> always return false for these special VMAs.
> > >
> > > ... or look into removing that one case that gives us headake.
> > >
> > > No idea what would happen if we do the following:
> > >
> > > CCing Yu Zhao.
> > >
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index 0761f91b407f..d1dfbd4fd38d 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -4280,14 +4280,9 @@ static bool sort_folio(struct lruvec *lruvec, =
struct folio *folio, struct scan_c
> > >                   return true;
> > >           }
> > >
> > > -       /* dirty lazyfree */
> > > -       if (type =3D=3D LRU_GEN_FILE && folio_test_anon(folio) && fol=
io_test_dirty(folio)) {
> > > -               success =3D lru_gen_del_folio(lruvec, folio, true);
> > > -               VM_WARN_ON_ONCE_FOLIO(!success, folio);
> > > -               folio_set_swapbacked(folio);
> > > -               lruvec_add_folio_tail(lruvec, folio);
> > > -               return true;
> > > -       }
> > > +       /* lazyfree: we may not be allowed to set swapbacked: MAP_DRO=
PPABLE */
> > > +       if (type =3D=3D LRU_GEN_FILE && folio_test_anon(folio) && fol=
io_test_dirty(folio))
> > > +               return false;
>
> This is an optimization to avoid an unnecessary trip to
> shrink_folio_list(), so it's safe to delete the entire 'if' block, and
> that would be preferable than leaving a dangling 'if'.
>
> > Note that something is unclear to me: are we maybe running into that
> > code also if folio_set_swapbacked() is already set and we are not in th=
e
> > lazyfree path (in contrast to what is documented)?
>
> Not sure what you mean: either rmap sees pte_dirty() and does
> folio_mark_dirty() and then folio_set_swapbacked(); or MGLRU does the
> same sequence, with the first two steps in walk_pte_range() and the
> last one here.

Rationale: rmap is expensive (cache unfriendly) and MGLRU tries to
avoid using it.


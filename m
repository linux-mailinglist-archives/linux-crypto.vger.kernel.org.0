Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358DB23C094
	for <lists+linux-crypto@lfdr.de>; Tue,  4 Aug 2020 22:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgHDUMj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 4 Aug 2020 16:12:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbgHDUMj (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 4 Aug 2020 16:12:39 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C21622B42
        for <linux-crypto@vger.kernel.org>; Tue,  4 Aug 2020 20:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596571958;
        bh=hofIGEXiXYLUFR1OAmkJHxE17oCYb40RkJ3l/pW8exU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pVqa6ApaS4U2wOKdI7cdcyayx62F9vWLudOdMl0GM2ZTU1vAL3xv/KWR5W4/KSmZt
         yVTTJEIxGf4KJ4P1ahNlvp96Ir0m1Fmu9/e7zWB+qrJOYDMBAoQ4aA5q6xrxMT9CUl
         vQeVXDHEy6ZGc11PH6CKv/Iy9T8tB85trjmcT9+I=
Received: by mail-oo1-f51.google.com with SMTP id g18so7434126ooa.0
        for <linux-crypto@vger.kernel.org>; Tue, 04 Aug 2020 13:12:38 -0700 (PDT)
X-Gm-Message-State: AOAM533hscd5z2E16YsQhRed3pFccfrmZ2Qnukts9dVJMxxsQIACzHhL
        8iZaZb7WmYzDs9IBjcEAMGUpW/w14eXmgth1IBk=
X-Google-Smtp-Source: ABdhPJxO/VCcxBE3YSVZEEciDnqjHRQhblvAsaMR4dMop3I9ajk3CIWKkoF2mz8FB8Sq91bkI3E3/3O9kQ82NJPFeT0=
X-Received: by 2002:a4a:b006:: with SMTP id f6mr20339067oon.13.1596571957779;
 Tue, 04 Aug 2020 13:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200802090616.1328-1-ardb@kernel.org> <25776a56-4c6a-3976-f4bc-fa53ba4a1550@candelatech.com>
 <CAMj1kXFAbip567hFaFtoqdevrSEpqFOGQ1+ejL98XrDOaTeggA@mail.gmail.com>
 <9c137bbf-2892-df7a-e6fa-8cce417ecd45@candelatech.com> <CAMj1kXFnfYKj1JE4NLsxXtaeKuAOKyBYDbayLr-mHDUYqnV1bA@mail.gmail.com>
 <d7f44f7a-d00e-cef4-5c91-86119e240038@candelatech.com>
In-Reply-To: <d7f44f7a-d00e-cef4-5c91-86119e240038@candelatech.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 4 Aug 2020 22:12:26 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGCatgAHQintKXRQZhmmvz5hvoBdYoeH11R_dJ62DDjGg@mail.gmail.com>
Message-ID: <CAMj1kXGCatgAHQintKXRQZhmmvz5hvoBdYoeH11R_dJ62DDjGg@mail.gmail.com>
Subject: Re: [PATCH] crypto: x86/aesni - implement accelerated CBCMAC, CMAC
 and XCBC shashes
To:     Ben Greear <greearb@candelatech.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, 4 Aug 2020 at 21:45, Ben Greear <greearb@candelatech.com> wrote:
>
> On 8/4/20 6:08 AM, Ard Biesheuvel wrote:
> > On Tue, 4 Aug 2020 at 15:01, Ben Greear <greearb@candelatech.com> wrote:
> >>
> >> On 8/4/20 5:55 AM, Ard Biesheuvel wrote:
> >>> On Mon, 3 Aug 2020 at 21:11, Ben Greear <greearb@candelatech.com> wrote:
> >>>>
> >>>> Hello,
> >>>>
> >>>> This helps a bit...now download sw-crypt performance is about 150Mbps,
> >>>> but still not as good as with my patch on 5.4 kernel, and fpu is still
> >>>> high in perf top:
> >>>>
> >>>>       13.89%  libc-2.29.so   [.] __memset_sse2_unaligned_erms
> >>>>         6.62%  [kernel]       [k] kernel_fpu_begin
> >>>>         4.14%  [kernel]       [k] _aesni_enc1
> >>>>         2.06%  [kernel]       [k] __crypto_xor
> >>>>         1.95%  [kernel]       [k] copy_user_generic_string
> >>>>         1.93%  libjvm.so      [.] SpinPause
> >>>>         1.01%  [kernel]       [k] aesni_encrypt
> >>>>         0.98%  [kernel]       [k] crypto_ctr_crypt
> >>>>         0.93%  [kernel]       [k] udp_sendmsg
> >>>>         0.78%  [kernel]       [k] crypto_inc
> >>>>         0.74%  [kernel]       [k] __ip_append_data.isra.53
> >>>>         0.65%  [kernel]       [k] aesni_cbc_enc
> >>>>         0.64%  [kernel]       [k] __dev_queue_xmit
> >>>>         0.62%  [kernel]       [k] ipt_do_table
> >>>>         0.62%  [kernel]       [k] igb_xmit_frame_ring
> >>>>         0.59%  [kernel]       [k] ip_route_output_key_hash_rcu
> >>>>         0.57%  [kernel]       [k] memcpy
> >>>>         0.57%  libjvm.so      [.] InstanceKlass::oop_follow_contents
> >>>>         0.56%  [kernel]       [k] irq_fpu_usable
> >>>>         0.56%  [kernel]       [k] mac_do_update
> >>>>
> >>>> If you'd like help setting up a test rig and have an ath10k pcie NIC or ath9k pcie NIC,
> >>>> then I can help.  Possibly hwsim would also be a good test case, but I have not tried
> >>>> that.
> >>>>
> >>>
> >>> I don't think this is likely to be reproducible on other
> >>> micro-architectures, so setting up a test rig is unlikely to help.
> >>>
> >>> I'll send out a v2 which implements a ahash instead of a shash (and
> >>> implements some other tweaks) so that kernel_fpu_begin() is only
> >>> called twice for each packet on the cbcmac path.
> >>>
> >>> Do you have any numbers for the old kernel without your patch? This
> >>> pathological FPU preserve/restore behavior could be caused be the
> >>> optimizations, or by other changes that landed in the meantime, so I
> >>> would like to know if kernel_fpu_begin() is as prominent in those
> >>> traces as well.
> >>>
> >>
> >> This same patch makes i7 mobile processors able to handle 1Gbps+ software
> >> decrypt rates, where without the patch, the rate was badly constrained and CPU
> >> load was much higher, so it is definitely noticeable on other processors too.
> >
> > OK
> >
> >> The weak processor on the current test rig is convenient because the problem
> >> is so noticeable even at slower wifi speeds.
> >>
> >> We can do some tests on 5.4 with our patch reverted.
> >>
> >
> > The issue with your CCM patch is that it keeps the FPU enabled for the
> > entire input, which also means that preemption is disabled, which
> > makes the -rt people grumpy. (Of course, it also uses APIs that no
> > longer exists, but that should be easy to fix)
> >
> > Do you happen to have any ballpark figures for the packet sizes and
> > the time spent doing encryption?
> >
>
> My tester reports this last patch appears to break wpa-2 entirely, so we
> cannot test it as is.
>

Ah, that is unfortunate. It passed the internal selftests we have in
the kernel, but apparently, the coverage is not 100%.

I will take another look into this next week.

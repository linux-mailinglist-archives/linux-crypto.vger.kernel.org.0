Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE71726A2C6
	for <lists+linux-crypto@lfdr.de>; Tue, 15 Sep 2020 12:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgIOKIp (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 15 Sep 2020 06:08:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgIOKIn (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 15 Sep 2020 06:08:43 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20C4821D7B;
        Tue, 15 Sep 2020 10:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600164523;
        bh=oVxC3QyxPJ/+tr+5qGi/WrwvDWq87ex4HnrI2z4OGxw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y7Y5E/pWxtJi7AAp0dXHWHDgJ9RL+9jHFlviwb6EAzCoD4mdktXMpUrPqeQFzhPH7
         V0IPDX1NtsHEymitwE0magQ/mHoZG72sweCCRmCZs+B6++3CGOCzZsQJwrZNUEG55M
         T++QYr0pLlc9QKsALbqaoC7fJZHYw42ECKaBwciU=
Received: by mail-ot1-f44.google.com with SMTP id e23so2683822otk.7;
        Tue, 15 Sep 2020 03:08:43 -0700 (PDT)
X-Gm-Message-State: AOAM5338Ev2KkjsAyYKQUJK6OkSXHT2H4jSoCs/hfoWrAkb+aWcwi6lI
        8tvNVPHPeNrUecRGwwJC60pOLGxdpvQPj3v9/V4=
X-Google-Smtp-Source: ABdhPJxakfqPU6ysOCwxFi4nwOF5w944Y6bVLgrA2HH0kMZv8d7DO9TRfyqoDSntqVGOaOEcEa5DQ7hJBpEZmpu2kOI=
X-Received: by 2002:a9d:69c9:: with SMTP id v9mr11619738oto.90.1600164522438;
 Tue, 15 Sep 2020 03:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
 <871rj4owfn.fsf@nanos.tec.linutronix.de> <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
 <CAHk-=wjOV6f_ddg+QVCF6RUe+pXPhSR2WevnNyOs9oT+q2ihEA@mail.gmail.com>
 <20200915033024.GB25789@gondor.apana.org.au> <CAHk-=wgX=ynJAXYYOAM7J8Tee8acERrGOopNu6ZcLN=SEXdGKA@mail.gmail.com>
 <CAHk-=wie0Kb-+XOZNasoay7AKCaQ8Ew8=LyvWTBeiPXC3v2GSA@mail.gmail.com>
 <20200915070523.GA26629@gondor.apana.org.au> <878sdb5qp5.fsf@nanos.tec.linutronix.de>
 <CAMj1kXHsqZzfJ2qmsrUWEU_XWxmR1PhY3zo-yz9Vau90-WphXg@mail.gmail.com> <20200915100506.GA27268@gondor.apana.org.au>
In-Reply-To: <20200915100506.GA27268@gondor.apana.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 15 Sep 2020 13:08:31 +0300
X-Gmail-Original-Message-ID: <CAMj1kXHAHrCCCTce3aLX0v=TDiWDiiwGaUPZQfqekKAsByMSvg@mail.gmail.com>
Message-ID: <CAMj1kXHAHrCCCTce3aLX0v=TDiWDiiwGaUPZQfqekKAsByMSvg@mail.gmail.com>
Subject: Re: [PATCH] crypto: lib/chacha20poly1305 - Set SG_MITER_ATOMIC unconditionally
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, 15 Sep 2020 at 13:05, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Tue, Sep 15, 2020 at 01:02:10PM +0300, Ard Biesheuvel wrote:
> >
> > > I'd rather go for a preemptible/sleepable version of highmem mapping
> > > which is in itself consistent for both highmen and not highmem.
> >
> > I don't think we need to obsess about highmem, although we should
> > obviously take care not to regress its performance unnecessarily. What
> > I want to avoid is to burden a brand new subsystem with legacy highmem
> > baggage simply because we could not agree on how to avoid that.
>
> I think what Thomas is proposing should address your concerns Ard.
> As long as nobody objects to the slight performance degradation on
> legacy highmem platforms it should make kmap_atomic just go away on
> modern platforms.
>

But making atomic kmap preemptible/sleepable creates the exact same
problem, i.e., that we have no idea which existing callers are
currently relying on those preemption disabling semantics, so we can't
just take them away. Or am I missing something?

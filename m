Return-Path: <linux-crypto+bounces-13954-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B184ADA332
	for <lists+linux-crypto@lfdr.de>; Sun, 15 Jun 2025 21:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CBB17A7578
	for <lists+linux-crypto@lfdr.de>; Sun, 15 Jun 2025 19:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0E727CCF0;
	Sun, 15 Jun 2025 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XbbBwb9x"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93F926B08F
	for <linux-crypto@vger.kernel.org>; Sun, 15 Jun 2025 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750016271; cv=none; b=MJnjuGX1jIeulEOgw2jtu/CvbV+eCmVZcAI5mj/eQspcQBjPuyFwO0PfyCiKVZ7MOi5HP6lC9WRfxKhGI+eDvPkoFKawqpv/Ki786qyJLZpDWuBsCE+YvBXlalf/5m9jKzktMhpFct4/Va6clN4/WB4vTIsm+g8pRZESxVexkOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750016271; c=relaxed/simple;
	bh=+DdLJhNZpkF0mq6V6riPNHi40jkfNk/Fbp6sB9glqNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/ktLraFDqONgUclRt6ZPWRuqwyYelan5etIHPMtzT4gb7rwvBYqjsFD7y07OQXZzym5sJezwxqomZphgQSIKW9BbP7WaAXu9fdgpVmn8n1wKZDpdjWEtXKG2IwG1Y0NVXFDoZj3Da4WV7AgP8DGwak91kCHjO7iS7BdtB6RcUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XbbBwb9x; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-606c5c9438fso7898815a12.2
        for <linux-crypto@vger.kernel.org>; Sun, 15 Jun 2025 12:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1750016268; x=1750621068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Bm1Ypz9xIQ9oSWoxmBY5SZFvMd6ktsJLpK/MNzMMqc=;
        b=XbbBwb9x0ravc+f0FvEQyaH6KRw5Ql9+dOM9gOA809dtqSMOXCwW5EvXmP7KOwndAi
         AF+w8TcehqMCjC7Lg/VfoRGzblQxJx/3L/STaEeHvNnZp101vIzLP5RvCtxaH4/FLmi4
         6l6OnahKKWc02zjXcar7rVlr1Y9VzdtjAbPk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750016268; x=1750621068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Bm1Ypz9xIQ9oSWoxmBY5SZFvMd6ktsJLpK/MNzMMqc=;
        b=gkc+6mCMkzNgtHS9/mlT2sEu4Ee71o1POOkm2W9kq/Deh4tQZ0KtZ2+Yv6RTBxwhuv
         qHwhj5Lifj4FGBNbOZ0nVYPpjc/bwOLohpH2ddQoefbOTT/J8psSC+GjZHh/UrqjpTsY
         pC2UCh1yuAQhv12StE467uj9BIOQGzcFwYEmspo9Mv0476YqZYrgWtepuW3/bi2pFHlS
         R4JIgXT+Ps4xupsTGutftWkEpMaGuo8mzn5DcOpb0JL5/LBXNRzOKi5aFhWf6hg2niwx
         5p9D3uZaXL5zj/nDP7FpNwFIZHvQEp77gZExyl5+cPnUuQHbDzA7xLveFGMDzxYfrONN
         0Kwg==
X-Forwarded-Encrypted: i=1; AJvYcCUa26dFpW8Mbk7zpfNaF/ufWOOmB7FLbiQfhQ1N56Q5rstSdU7rVIJzKc+umWVKII8Zsp9QoxPo+CSOCbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydqcQ4acN1hukRuVZr1wA/cN1ji8Q/pn4l/QuRgWmFRyK+/1d6
	U5GEiPmPmU6RfgxVari/dbru+T1Luqn8NWBwJgIcQaotK3FD6xcxBN7bXmUan1LIy5s68K4Dg5o
	ZojMnD9g=
X-Gm-Gg: ASbGncue9dEBFoSUcnkFNKZVYSFD4SHwlHIyIBWTBDMb6aktpdgMHqcLwvoYx13LbGg
	Wei7PYV2j7hJh6l9t2Ify6rH24PfGNABxIbzG7QLta0UX/xf6/UTG4xdDDGpNicegT3twot+cg4
	ZTkqDBQihaaONDMJ/a2pF7BwMu7mMiI0NY7qGme2YUxK8/945wvHgcW7T3ranrDSEYic31dy7kc
	jSCBjcHcAI9gTVuV94a2xwLyljIEXbGlEP9DNDKCxCGJBf6YOW06c6K/ZXzg7FIF0tnpVR8LPsz
	RGi+/9Eoqmh9T7HwGJsBaf6KFLO/LoT+/KFyENC3QCkPjVPEvwQqMc6u9ufJMW1iRcD8So441rA
	2QmwwGDB4bwkManaYVAsR2pDw2Qb8fAzkKvCSg5c/etOxY3g=
X-Google-Smtp-Source: AGHT+IHBPMTcnXzkfxmf0JT7lLsjI0/MFOZhz+r76KVTEOyrdtZkvlCAIcfOspU0okK9Qg1q2L7e7Q==
X-Received: by 2002:a05:6402:50cc:b0:5f3:26bb:8858 with SMTP id 4fb4d7f45d1cf-608d09a2d16mr6285743a12.34.1750016267773;
        Sun, 15 Jun 2025 12:37:47 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b4a94ce7sm4776925a12.58.2025.06.15.12.37.46
        for <linux-crypto@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jun 2025 12:37:46 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-607c5715ef2so6421590a12.0
        for <linux-crypto@vger.kernel.org>; Sun, 15 Jun 2025 12:37:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUs1W2aPN1wI214SxomtF3DhOOuiau4EFCPWUJQN7NDjXwscCi6JBsFw46i7WcXKb+rHpOsf1CQCRmAvVo=@vger.kernel.org
X-Received: by 2002:a05:6402:50cc:b0:5f3:26bb:8858 with SMTP id
 4fb4d7f45d1cf-608d09a2d16mr6285703a12.34.1750016266135; Sun, 15 Jun 2025
 12:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aEjo6YZn59m5FnZ_@gondor.apana.org.au> <20250611033957.GA1484147@sol>
 <aEj8J3ZIYEFp_XT4@gondor.apana.org.au> <20250611035842.GB1484147@sol>
 <20250613053624.GA163131@sol> <aEu5cyDOMcKteW_b@gondor.apana.org.au>
 <20250613055439.GB163131@sol> <aEvmmr0huGGd2Psv@gondor.apana.org.au>
 <20250615031807.GA81869@sol> <CAMj1kXGd93Kg0Vs8ExLhK=fxhRBASU9sOPfgYUogv+rwVqgUsg@mail.gmail.com>
 <20250615184638.GA1480@sol>
In-Reply-To: <20250615184638.GA1480@sol>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 15 Jun 2025 12:37:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAh0fnfm-LomMWDV=OGhCHCp0C_7xZASE_8pZ3ZP0CXg@mail.gmail.com>
X-Gm-Features: AX0GCFsirgA8Ga0u26X0ToUgNd-a86j5gL8Na8fIUJo1Hy2_joO0gogaJwm_iSM
Message-ID: <CAHk-=wiAh0fnfm-LomMWDV=OGhCHCp0C_7xZASE_8pZ3ZP0CXg@mail.gmail.com>
Subject: Re: [PATCH] crypto: ahash - Stop legacy tfms from using the set_virt
 fallback path
To: Eric Biggers <ebiggers@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, x86@kernel.org, Jason@zx2c4.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 15 Jun 2025 at 11:47, Eric Biggers <ebiggers@kernel.org> wrote:
>
> So yes, QCE seems to have only one queue, and even that one queue is *much*
> slower than just using the CPU.  It's even slower than the generic C code.

Honestly, I have *NEVER* seen an external crypto accelerator that is
worth using unless it's integrated with the target IO.

Now, it's not my area of expertise either, so there may well be some
random case that I haven't heard about, but the only sensible use-case
I'm aware of is when the network card just does all the offloading and
just does the whole SSL thing (or IPsec or whatever, but if you care
about performance you'd be better off using wireguard and doing it all
on the CPU anyway)

And even then, people tend to not be happy with the results, because
the hardware is too inflexible or too rare.

(Replace "network card" with "disk controller" if that's your thing -
the basic idea is the same: it's worthwhile if it's done natively by
the IO target, not done by some third party accelerator - and while
I'm convinced encryption on the disk controller makes sense, I'm not
sure I'd actually *trust* it from a real cryptographic standpoint if
you really care about it, because some of those are most definitely
black boxes with the trust model seemingly being based on the "Trust
me, Bro" approach to security).

The other case is the "key is physically separate and isn't even under
kernel control at all", but then it's never about performance in the
first place (ie security keys etc).

Even if the hardware crypto engine is fast - and as you see, no they
aren't - any possible performance is absolutely killed by lack of
caches and the IO overhead.

This seems to also be pretty much true of async SMP crypto on the CPU
as well.  You can get better benchmarks by offloading the crypto to
other CPU's, but I'm not convinced it's actually a good trade-off in
reality. The cost of scheduling and just all the overhead of
synchronization is very very real, and the benchmarks where it looks
good tend to be the "we do nothing else, and we don't actually touch
the data anyway, it's just purely about pointless benchmarking".

Just the set-up costs for doing things asynchronously can be higher
than the cost of just doing the operation itself.

             Linus


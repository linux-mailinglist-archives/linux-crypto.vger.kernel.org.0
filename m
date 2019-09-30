Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C27B5C1A40
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Sep 2019 04:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfI3CwN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 29 Sep 2019 22:52:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44411 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbfI3CwN (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 29 Sep 2019 22:52:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id m13so7735926ljj.11
        for <linux-crypto@vger.kernel.org>; Sun, 29 Sep 2019 19:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kSukY035Lf9VZ3+D0BgN3PlibSf+XC/ghSVonBEEL78=;
        b=Kxr9xyygU3xkRbfdMRzgfZaLfI7ZqnsHrZJ5IW7K1znbpgC5Bqu2bVWo3LrV1+CBfo
         50Y2EES3KsbUkrH6pCS+OGQ3ZimPAeHmTbD0nDhaN+8gNbI4xHImMCbY/T66QSikAIFL
         oINclApdbKU+XpnvaF55DjungYLphcQCnGzwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kSukY035Lf9VZ3+D0BgN3PlibSf+XC/ghSVonBEEL78=;
        b=lRirjythUWRaiPlaVcYskb6VYx2rG1LRjYZfNII+DBnkz6QFuB2WzVzNUg8QKQryzV
         AQqvnNOjo07jRICwCSk5R3nF6RKs80P1bKY9lMSy6RLmdWpmABiuosDlc7kI1p7uPS8c
         +PlmYrWYvd3yLdJ4LnDUBrqL5Rs9q//BLitx4/fPuaDoKjM+/SQcnggEw2HpmQOSf50S
         Rg6+G4enkGhK2VIA9kgWJl4UxTkIhvy4hmZTiefYiH24NDqE3/Vz243FKSRBdGgrcikx
         zdzVFYZiEVTb7XKd/hHzGY/GT6/hC36Odgedm97J8UjoOVvCRYzzOy9Sz1x1GoF/FUih
         G08w==
X-Gm-Message-State: APjAAAUD4SWB+5z5WwwngTx1AKS5RqLzkZxW3mCdGPaUqDmpuOd5NF6Y
        oR4xvSbreylqb1trnTAvzbg1u/WWtBg=
X-Google-Smtp-Source: APXvYqyfWxzw0Zm+K4IT0FVcBj6MhzrJdBhlQMv3kcOe1E9hrfqIz65aAQNXbWRRjxeKXdfGqfLb1A==
X-Received: by 2002:a05:651c:110f:: with SMTP id d15mr10532532ljo.43.1569811929840;
        Sun, 29 Sep 2019 19:52:09 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id t8sm2783406lfc.80.2019.09.29.19.52.08
        for <linux-crypto@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2019 19:52:09 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id v24so7777809ljj.3
        for <linux-crypto@vger.kernel.org>; Sun, 29 Sep 2019 19:52:08 -0700 (PDT)
X-Received: by 2002:a2e:1208:: with SMTP id t8mr10053985lje.84.1569811928396;
 Sun, 29 Sep 2019 19:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190929173850.26055-1-ard.biesheuvel@linaro.org>
 <20190929173850.26055-12-ard.biesheuvel@linaro.org> <CAHmME9q=72-iKnHh0nB2+mO3uNoUerOVoHDY=eBKSoPB32XSsA@mail.gmail.com>
In-Reply-To: <CAHmME9q=72-iKnHh0nB2+mO3uNoUerOVoHDY=eBKSoPB32XSsA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Sep 2019 19:51:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+8TpXFcQ96ouw1o1nznCzg2hNy2XGcV9H_h94u3D16A@mail.gmail.com>
Message-ID: <CAHk-=wh+8TpXFcQ96ouw1o1nznCzg2hNy2XGcV9H_h94u3D16A@mail.gmail.com>
Subject: Re: [RFC PATCH 11/20] crypto: BLAKE2s - x86_64 implementation
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Martin Willi <martin@strongswan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Sep 29, 2019 at 7:42 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> I had previously put quite some effort into the simd_get, simd_put,
> simd_relax mechanism, so that the simd state could be persisted during
> both several calls to the same function and within long loops like
> below, with simd_relax existing to reenable preemption briefly if
> things were getting out of hand. Ard got rid of this and has moved the
> kernel_fpu_begin and kernel_fpu_end calls into the inner loop:

Actually, that should be ok these days.

What has happened fairly recently (it got merged into 5.2 back in May)
is that we no longer do the FPU save/restore on each
kernel_fpu_begin/end.

Instead, we save it on kernel_fpu_begin(), and set a flag that it
needs to be restored when returning to user space.

So the kernel now on its own merges that FPU save/restore overhead
when you do it repeatedly.

The core change happened in

     5f409e20b794 ("x86/fpu: Defer FPU state load until return to userspace")

but there are a few commits around it for cleanups etc. The code was merged in

     8ff468c29e9a ("Merge branch 'x86-fpu-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")

if you want to see the whole series.

That said, it would be _lovely_ if you or somebody else actually
double-checked that it works as expected and that the numbers bear out
the improvements.

It should be superior to the old model of manually trying to merge FPU
use regions, both from a performance angle (because it will merge much
more), but also from a code simplicity angle and the whole preemption
latency worry also basically goes away.

             Linus

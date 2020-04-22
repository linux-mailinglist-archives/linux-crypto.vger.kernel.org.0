Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E278C1B4334
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Apr 2020 13:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDVL2g (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 22 Apr 2020 07:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725808AbgDVL2g (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 22 Apr 2020 07:28:36 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7697AC03C1A8;
        Wed, 22 Apr 2020 04:28:36 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jRDYN-0006fw-5o; Wed, 22 Apr 2020 13:28:31 +0200
Date:   Wed, 22 Apr 2020 13:28:31 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-rt-users@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH crypto-stable] crypto: arch/lib - limit simd usage to
 PAGE_SIZE chunks
Message-ID: <20200422112831.5352gcpo42jgz2dj@linutronix.de>
References: <20200420075711.2385190-1-Jason@zx2c4.com>
 <20200422040415.GA2881@sol.localdomain>
 <CAMj1kXGRNCEkTFPGM03h1N+HtOiLVMcm89UJYMZcuWjyFAp5Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGRNCEkTFPGM03h1N+HtOiLVMcm89UJYMZcuWjyFAp5Ag@mail.gmail.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 2020-04-22 09:23:34 [+0200], Ard Biesheuvel wrote:
> My memory is a bit fuzzy here. I remember talking to the linux-rt guys
> about what delay is actually acceptable, which was a lot higher than I
> had thought based on their initial reports about scheduling blackouts
> on arm64 due to preemption remaining disabled for too long. I intended
> to revisit this with more accurate bounds but then I apparently
> forgot.
> 
> So SIMD chacha20 and SIMD poly1305 both run in <5 cycles per bytes,
> both on x86 and ARM. If we take 20 microseconds as a ballpark upper
> bound for how long preemption may be disabled, that gives us ~4000
> bytes of ChaCha20 or Poly1305 on a hypothetical 1 GHz core.
> 
> So I think 4 KB is indeed a reasonable quantum of work here. Only
> PAGE_SIZE is not necessarily equal to 4 KB on arm64, so we should use
> SZ_4K instead.
> 
> *However*, at the time, the report was triggered by the fact that we
> were keeping SIMD enabled across calls into the scatterwalk API, which
> may call kmalloc()/kfree() etc. There is no need for that anymore, now
> that the FPU begin/end routines all have been optimized to restore the
> userland SIMD state lazily.

The 20usec sound reasonable. The other concern was memory allocation
within the preempt-disable section. If this is no longer the case,
perfect.

Sebastian

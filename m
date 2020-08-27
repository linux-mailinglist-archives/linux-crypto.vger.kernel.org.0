Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAE2254C79
	for <lists+linux-crypto@lfdr.de>; Thu, 27 Aug 2020 19:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgH0Rzx (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 27 Aug 2020 13:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgH0Rzw (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 27 Aug 2020 13:55:52 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2E6C061264
        for <linux-crypto@vger.kernel.org>; Thu, 27 Aug 2020 10:55:52 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w14so7446417ljj.4
        for <linux-crypto@vger.kernel.org>; Thu, 27 Aug 2020 10:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aBxw2hdQPG9HwPnbg4ROvvprorSoqDpTe8GqtXP5pJ0=;
        b=gEx+R3IPWaIJ1rgeNNwr+K1FkcP5eJOLC7ZA9dQ9Cv0uo0pZjd3WeqmWckEgGWoYrU
         ZAG7LNkdYBfRW3VrlUxFVNYbKu1wyi/QwU3U8A/KnnoM89gRInpWvJhvjjqCkfZnBCSn
         5eQEyXLyrqPdWNsvej8MpXfKFNrgFKsRiKyn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aBxw2hdQPG9HwPnbg4ROvvprorSoqDpTe8GqtXP5pJ0=;
        b=SAl71iDXXPSAlU6kLBSx0FL4C9x4sXq2Kze25lg1ElID3HrLAwraHVn3kojHiemyh5
         wcfi1H/mabaSI8Jl715TM8rBLr1M2fSuseCkG+uKFZrLeU46KPGteanqkE01bE76vzS3
         NAdXKjeVobaiK4jbY39mDlzNJ+2HNSTYM5esuAwHetPdRcc5zSs9V1Z9YwzCFsyuDQwJ
         V5ixj7OtjUUUtZbt6O+BfcZ8p16/HkyBOhEAzt4yR+Nc5wHQ5lEtmg3ay/6UEbyq2kZ4
         0mcM5lEe0Y+8fmAgzpuN7vANgIaR4FAczoh5wKxyaLMM/J54hpJTx67mr1e5z2yS9Zyl
         apvg==
X-Gm-Message-State: AOAM530S2I/+JQigHgZ/W73Zu1qnkOpyWWiwythL8RwqXsllyKI/oYbh
        dnZ9qnShEnNVcvvnG7paL+P2zxpI9tfqrw==
X-Google-Smtp-Source: ABdhPJzaotAksgukUKgbbvyl+eB4yeCblc1LpJkuI4g8iDDQ0D6xYAwI8/nHtGmCUn9/Idh2v7htIw==
X-Received: by 2002:a2e:97da:: with SMTP id m26mr11065733ljj.9.1598550950499;
        Thu, 27 Aug 2020 10:55:50 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id u18sm621251ljj.3.2020.08.27.10.55.48
        for <linux-crypto@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 10:55:49 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id r13so4011513ljm.0
        for <linux-crypto@vger.kernel.org>; Thu, 27 Aug 2020 10:55:48 -0700 (PDT)
X-Received: by 2002:a2e:b008:: with SMTP id y8mr9098156ljk.421.1598550948550;
 Thu, 27 Aug 2020 10:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <202008271145.xE8qIAjp%lkp@intel.com> <20200827080558.GA3024@gondor.apana.org.au>
 <CAMj1kXHJrLtnJWYBKBYRtNHVS6rv51+crMsjLEnSqkud0BBaWw@mail.gmail.com>
 <20200827082447.GA3185@gondor.apana.org.au> <CAHk-=wg2RCgmW_KM8Gf9-3VJW1K2-FTXQsGeGHirBFsG5zPbsg@mail.gmail.com>
In-Reply-To: <CAHk-=wg2RCgmW_KM8Gf9-3VJW1K2-FTXQsGeGHirBFsG5zPbsg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Aug 2020 10:55:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXW=YLxGN0QVpp-1w5GDd2pf1W-FqY15poKzoVfik2qA@mail.gmail.com>
Message-ID: <CAHk-=wgXW=YLxGN0QVpp-1w5GDd2pf1W-FqY15poKzoVfik2qA@mail.gmail.com>
Subject: Re: lib/crypto/chacha.c:65:1: warning: the frame size of 1604 bytes
 is larger than 1024 bytes
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Aug 27, 2020 at 10:34 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> How are you guys testing? I have UBSAN and GCOV on, and don't see
> crazy frames on either i386 or x86-64.

Oh, never mind. I also have COMPILE_TEST on, so it ends up disabling
GCOV_PROFILE_ALL and UBSAN_SANITIZE_ALL.

And yeah, this seems to be a gcc bug. It generates a ton of stack
slots for temporaries. It's -fsanitize=object-size that seems to do
it.

And "-fstack-reuse=all" doesn't seem to make any difference.

So I think

 (a) our stack size check is good to catch this

 (b) gcc and -fsanitize=object-size is basically an unusable combination

and it's not a bug in the kernel.

                Linus

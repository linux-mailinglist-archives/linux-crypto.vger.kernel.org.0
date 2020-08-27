Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCCE254C3E
	for <lists+linux-crypto@lfdr.de>; Thu, 27 Aug 2020 19:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgH0RfK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 27 Aug 2020 13:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgH0RfJ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 27 Aug 2020 13:35:09 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DA9C061264
        for <linux-crypto@vger.kernel.org>; Thu, 27 Aug 2020 10:35:08 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 185so7347366ljj.7
        for <linux-crypto@vger.kernel.org>; Thu, 27 Aug 2020 10:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+BC/JcdsJrh7D1baGdsMISOmKuvWwQO6PTtPOyfbkKo=;
        b=eCSI0FOCZRGoIZSFsgWImch53XxylRdRW9nBxdCujM9/5e9Icmd99didgqiTQNpgqR
         sKrz0tsPtlMub2w7SYON4tyaIZXXNlhBhfBuwtSxuJO7vV+6HrKtKFS4DbuKiBlL7msf
         NRDW5/K/GBZxy0t/NmYf5fzKOw12bYm48anO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+BC/JcdsJrh7D1baGdsMISOmKuvWwQO6PTtPOyfbkKo=;
        b=CKJ4B/2LIVDA78ezQNbKpCu2yaBZ6Rg2JdCtRO5VT5UfwiZtxEHsgSPl7JM40PvHc6
         pLibKLiUSQrL7BoVXrRParkjLq41z2eBI3F0TnbAMcOjupMkeGSkgMBJqf+PM8JImrPr
         ldCB1kk8zscDbPhA5cpXr2jHU3CLMXCj8whTuZNZ5jIEYp1PXfpJ4Nwn7fP3YEjX2Qza
         vd0K8PswAao6oXDsJg7QddYjsVR/2g1vpPwK0wFYFEegy30P0LVn+w3d7niMqcJmhKVF
         xWDi4RoBkT5HWo0c1WAz3aV0GJ9UpvR6ZrUzuoaWoOdlz/QotFGVmhHVlxLiCYrJDCBb
         OYLQ==
X-Gm-Message-State: AOAM533hLyMcsqsbZH3/KyLRSi5pfFycikuYP7HZTcD51IIRS7CQpYbm
        nfMZ+9apsDFhZt5Wvbh9f9NBX6kn3MAVYw==
X-Google-Smtp-Source: ABdhPJz2h0DCyVZmC3w6LfJg0i+lKbfKq3UyPcBe0oaidUuj5stiDnjG+J4mJuSnUcIdowHeiQV/yg==
X-Received: by 2002:a05:651c:201b:: with SMTP id s27mr10474846ljo.468.1598549706658;
        Thu, 27 Aug 2020 10:35:06 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id g19sm601289ljk.125.2020.08.27.10.35.05
        for <linux-crypto@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 10:35:05 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id q8so971998lfb.6
        for <linux-crypto@vger.kernel.org>; Thu, 27 Aug 2020 10:35:05 -0700 (PDT)
X-Received: by 2002:ac2:58db:: with SMTP id u27mr5435779lfo.142.1598549704843;
 Thu, 27 Aug 2020 10:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <202008271145.xE8qIAjp%lkp@intel.com> <20200827080558.GA3024@gondor.apana.org.au>
 <CAMj1kXHJrLtnJWYBKBYRtNHVS6rv51+crMsjLEnSqkud0BBaWw@mail.gmail.com> <20200827082447.GA3185@gondor.apana.org.au>
In-Reply-To: <20200827082447.GA3185@gondor.apana.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Aug 2020 10:34:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2RCgmW_KM8Gf9-3VJW1K2-FTXQsGeGHirBFsG5zPbsg@mail.gmail.com>
Message-ID: <CAHk-=wg2RCgmW_KM8Gf9-3VJW1K2-FTXQsGeGHirBFsG5zPbsg@mail.gmail.com>
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

On Thu, Aug 27, 2020 at 1:25 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Interestingly this particular file fails with those options on
> gcc 8, 9 and 10.

How are you guys testing? I have UBSAN and GCOV on, and don't see
crazy frames on either i386 or x86-64.

I see 72 bytes and 64 bytes respectively for chacha_permute() (plus
the register pushes, which is about the same size)

                  Linus

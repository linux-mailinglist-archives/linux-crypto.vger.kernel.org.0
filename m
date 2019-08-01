Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6217D637
	for <lists+linux-crypto@lfdr.de>; Thu,  1 Aug 2019 09:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbfHAHYP (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 1 Aug 2019 03:24:15 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35922 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729459AbfHAHYP (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 1 Aug 2019 03:24:15 -0400
Received: by mail-qk1-f194.google.com with SMTP id g18so51213439qkl.3;
        Thu, 01 Aug 2019 00:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qACHlYDouY/gOyPBmMG0l5FE+0ThM7Kh9luMgCb13Sw=;
        b=iWy+6OYFNdEHERBjlSrEwepwewhNmK4ms43xTvwqqB61wojuol88x6azPzLMDLPe0I
         dWzhzvJ0Bmdqf6r6RK9wx+qtAd90QU0Q4YkgtfFy/E8IE7fI/Kn4t6mIhW5aFobG0Zq4
         bKVirkshUZhAC5L+MIDerX3XzlvMM0VCzoSTfF+/tx4Nz4iV6Xkghh2pyhSBV8yV5571
         ctDbnQaCLhqoyLhnagIPWw1eGrlcClo3YUs9lX+s4cPD78vrNYIjBP3zgead7+4TsCJE
         MLpTAkkhywJLqTbj8Gal5pO3YjtJHS30gZE9EsinxqZw4Bi0ZtRgGma8OCacXwXhH4+M
         8qlA==
X-Gm-Message-State: APjAAAV16AXgl7qXOUdrwM5z6IhYlkzgkMrBNDWIW2gPht+tonEW9HV/
        UR82ii+apYMnby1Z98Y7hIsa7nCYKjGRGQu6SuM=
X-Google-Smtp-Source: APXvYqyH0dmirrq32o84JCYuI4wfKi/T3tffDm2sveAme5f/8hPf+pjvfXIg7BNB25bLJwF/fPONgfzdiad5ON4RcQ8=
X-Received: by 2002:a05:620a:b:: with SMTP id j11mr50117301qki.352.1564644253905;
 Thu, 01 Aug 2019 00:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190801115346.77439e35@canb.auug.org.au> <20190801021133.GA1428@gondor.apana.org.au>
In-Reply-To: <20190801021133.GA1428@gondor.apana.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 1 Aug 2019 09:23:58 +0200
Message-ID: <CAK8P3a0XHqcB=-x0=mQDMeax8cbh+p+XytfUPhqqjLkV3naucA@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: Remove redundant arch-specific rules for simd.h
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Aug 1, 2019 at 4:11 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Now that simd.h is in include/asm-generic/Kbuild we don't need
> the arch-specific Kbuild rules for them.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 82cb54856874 ("asm-generic: make simd.h a mandatory...")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Acked-by: Arnd Bergmann <arnd@arndb.de>

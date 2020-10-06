Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31DF2853EC
	for <lists+linux-crypto@lfdr.de>; Tue,  6 Oct 2020 23:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgJFVf6 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 6 Oct 2020 17:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgJFVf5 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 6 Oct 2020 17:35:57 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B665EC061755
        for <linux-crypto@vger.kernel.org>; Tue,  6 Oct 2020 14:35:57 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id c63so75319vkb.7
        for <linux-crypto@vger.kernel.org>; Tue, 06 Oct 2020 14:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DIhoEkw7QDnbqFkt4C/9ORTsJfEnPY9bxYmbo8CQgVc=;
        b=AWXmY+d1jW5xLVG2U3KjH2+I/C9SAPMyWonGsFb/wqdX9qsJLV7BcxDMfPgm+XYkuq
         qW7X/XM4vvp58ZAGXnbJrxnOnQxHoYEjTqf8yi1DUMNER8y5ICvPGz2uHu9+x4k+CN67
         kCEPT9uxDaiJizFsMIpDft7iGunXpB8baaDaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DIhoEkw7QDnbqFkt4C/9ORTsJfEnPY9bxYmbo8CQgVc=;
        b=oVsdUy8wvSmVyUixglj81PRynlzGXFQd41qGGXrJrWUo7fzRFIz+cOUoY7YDivbILP
         V0bU6rmX42+ksLy6fHQt8KHLS+IEr9AN3Zjy2LKkqvvwPQs/6ykFeHKrL+1/iFWjs/Zb
         /BdeU62BarqYwwV3NFQk0gGIuKdrA/GePdP2nH//zMa3x1GUHW2IzrWFpD/M5iIm56eG
         CFp4kn8Zhwy7iPLFfscO0bzmhNuDPKPOCRAeE9FWJ6d9bHxDKA5/vJvphZunTn0Je7wU
         CkVlJ1OT6BfDdQgV0hECTQTU0kRYOwuPTD7g/yOei7GvzJWcO3mijxnd7tQs6bWcwCIw
         aygQ==
X-Gm-Message-State: AOAM532jCmWl6r8WZAnIbcqOCGroCGXlMVZFOCa7RWd4uWYngZPHcsYi
        moWMj8np30aUj6AB8qqwz02EfwiKcArQfg==
X-Google-Smtp-Source: ABdhPJwlYPiGHeJY9x5yhtSf5yGEZMbntktVPd2zsYoSRq98kP/q5rq7BUNvWBsIcU9I11RE+W0ztw==
X-Received: by 2002:a1f:a655:: with SMTP id p82mr146468vke.23.1602020156803;
        Tue, 06 Oct 2020 14:35:56 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id r14sm645031uao.14.2020.10.06.14.35.55
        for <linux-crypto@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 14:35:56 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id f8so50367vsl.3
        for <linux-crypto@vger.kernel.org>; Tue, 06 Oct 2020 14:35:55 -0700 (PDT)
X-Received: by 2002:a67:ec9a:: with SMTP id h26mr17365vsp.34.1602020155557;
 Tue, 06 Oct 2020 14:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201006195848.707504-1-natechancellor@gmail.com>
In-Reply-To: <20201006195848.707504-1-natechancellor@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 6 Oct 2020 14:35:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VKud6KXYSXG79qOU-feKJqhOLeAf_eWuummotdBSyHcw@mail.gmail.com>
Message-ID: <CAD=FV=VKud6KXYSXG79qOU-feKJqhOLeAf_eWuummotdBSyHcw@mail.gmail.com>
Subject: Re: [PATCH] crypto: xor - Remove unused variable count in do_xor_speed
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi,

On Tue, Oct 6, 2020 at 12:59 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> crypto/xor.c:101:4: warning: variable 'count' is uninitialized when used
> here [-Wuninitialized]
>                         count++;
>                         ^~~~~
> crypto/xor.c:86:17: note: initialize the variable 'count' to silence
> this warning
>         int i, j, count;
>                        ^
>                         = 0
> 1 warning generated.
>
> After the refactoring to use ktime that happened in this function, count
> is only assigned, never read. Just remove the variable to get rid of the
> warning.
>
> Fixes: c055e3eae0f1 ("crypto: xor - use ktime for template benchmarking")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1171
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  crypto/xor.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Whoops!  Sorry for missing this in my review.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

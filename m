Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 959AE10C0BD
	for <lists+linux-crypto@lfdr.de>; Thu, 28 Nov 2019 00:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfK0XnG (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 27 Nov 2019 18:43:06 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:40231 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfK0XnG (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 27 Nov 2019 18:43:06 -0500
Received: by mail-vk1-f195.google.com with SMTP id i18so721319vkk.7
        for <linux-crypto@vger.kernel.org>; Wed, 27 Nov 2019 15:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5V1U7K9kHqSmBC9GKmbu10OmsvEfDZWHZBAkdynx/3A=;
        b=PvBbnjafdCvEjlwAHLsw4Jkf5UKDz6s7witD5jd3/x70kOObX+EhN8IhEu1l0vMDao
         eyFB2VR6+BiVNsnhas396vPiie5zwGNVANUKDHufBAXVc0+9hKfbW030dFWNG3Cv/J7l
         hqmrKydCIurQVBzzegb3UutaspJwhtGXO/gKSvIA6Sq2HhXhwRAghpC1UbE1oDheTz8S
         qX4ZaH6B1tEQxHPimTogvOFaHeUSQzd1sKhIPU+fef2bGXQspLHe1EyC9nEza/asyLzJ
         b/YquzQ4e8aWWFpfl2u+fQMt+7m4lbuhnN1p9eHjdQdOaCsEYyXNqrWJj/1kRgyr8e+w
         v8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5V1U7K9kHqSmBC9GKmbu10OmsvEfDZWHZBAkdynx/3A=;
        b=Q9FjgMgoSUApOtLea4yd4x957/f1wh19wSdpatJlraIWJZRTWykPQAyPNS3aY07q03
         QLurYqBVp76Fd+hRsfT0av2yoT7U8crBUE83FPMT65AVpRMbmIksPKKtlGLiMFNQQTNA
         j/J8RwerP+MGKE3JQu4bq7pLXsxBbuq/L97gWQJKk/TBJTJwp+xdBs6SuYKL/SsbYbP3
         9vf2gC0Y5xbApCMZxtj/JaG/nhxhkyZz8M0Ip5AWi/XfkSsKfCtUuari+C/vL8QpMSN3
         D5W8vdFkJ5PrUtvanQgEaaBcZREZRKT/9ZDWX2cSo5OJglQiiqBP02KC221iqjmQokz+
         YNew==
X-Gm-Message-State: APjAAAXmpgT17hWkm2myaQrO/fuXrbrA0GpJXQlgtO+XwuNmcWVXFgVF
        5FTIfXo+SbUmlJUiNKVKMmK/7RQgXU30HuT/unsXPA==
X-Google-Smtp-Source: APXvYqx1i0KATXqkxu2iu7n10l5sJYYFz7lSnecvNV9HWF093zCgA7YZz4hfleScYvfvsSSdbbjLOGlrCFIaftAte+A=
X-Received: by 2002:a1f:7d88:: with SMTP id y130mr4689848vkc.71.1574898185282;
 Wed, 27 Nov 2019 15:43:05 -0800 (PST)
MIME-Version: 1.0
References: <20191112223046.176097-1-samitolvanen@google.com>
 <20191119201353.2589-1-samitolvanen@google.com> <20191127181940.GB49214@sol.localdomain>
In-Reply-To: <20191127181940.GB49214@sol.localdomain>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 27 Nov 2019 15:42:53 -0800
Message-ID: <CABCJKud-JRT8mNmP8yMobeFajk1gU_iwss9w43keZyX9jasPXw@mail.gmail.com>
Subject: Re: [PATCH v3] crypto: arm64/sha: fix function types
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Nov 27, 2019 at 10:19 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Nov 19, 2019 at 12:13:53PM -0800, Sami Tolvanen wrote:
> > +static void __sha1_ce_transform(struct sha1_state *sst, u8 const *src,
> > +                             int blocks)
> > +{
> > +     return sha1_ce_transform(container_of(sst, struct sha1_ce_state, sst),
> > +                              src, blocks);
> > +}
> > +
>
> 'return' isn't needed in functions that return void.
>
> Likewise everywhere else in this patch.
>
> Otherwise this patch looks fine.

Thanks for taking a look, Eric. I'll send out v4 with this fixed.

Sami

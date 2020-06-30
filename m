Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502A820F24D
	for <lists+linux-crypto@lfdr.de>; Tue, 30 Jun 2020 12:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgF3KKC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 30 Jun 2020 06:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732189AbgF3KKC (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 30 Jun 2020 06:10:02 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A86362078B
        for <linux-crypto@vger.kernel.org>; Tue, 30 Jun 2020 10:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593511801;
        bh=Qb8UJ9UKslgy8Grgbb2TcL+yWw1lhizz0OxstWxse3w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YLFLWM4B5mgsN+m7kVsthMkRWGOpVVRvSiZh+s9jyJ7G4RxMA8p4qYz2LCYhCm4Ju
         Xo1yc46WmU1BNSrnVRqgQg/QJwI7k1T/6D9NlpVp1bQkiBm1RNVb7sYLRvdwqWGFGX
         x/ERlQEuFUx2kVHwZLZUkIxxbyDCw4JA9w/fG39w=
Received: by mail-oi1-f179.google.com with SMTP id s21so16951473oic.9
        for <linux-crypto@vger.kernel.org>; Tue, 30 Jun 2020 03:10:01 -0700 (PDT)
X-Gm-Message-State: AOAM530qyQpZCStj2e746TRRrJlFM/dxo+zYNwr3P+ziG2mHMb2FzQMX
        67m4m3NNq39YV6ciQP5u3/EJhMxFtdajY4sUa48=
X-Google-Smtp-Source: ABdhPJzkP36HrxoMSPg+SrIuVtIS4eOcIx6zuyvO0IJZuRBBK5Yfv7xYAZOZpiBByxKB1LgKnoeGIl86NkIx6BFceq0=
X-Received: by 2002:aca:f257:: with SMTP id q84mr1286462oih.174.1593511797563;
 Tue, 30 Jun 2020 03:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200626080429.155450-1-giovanni.cabiddu@intel.com>
 <20200626080429.155450-5-giovanni.cabiddu@intel.com> <CAMj1kXGu4_Fp=0i9FUJuRUknsUrf0Ci=r9gMb5+Zf+hVXN4-rw@mail.gmail.com>
 <20200629170353.GA2750@silpixa00400314>
In-Reply-To: <20200629170353.GA2750@silpixa00400314>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 30 Jun 2020 12:09:46 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFW00GxG1dzqKMAqRjLT=6u4sWQAmft5k+f0E7++LcD=A@mail.gmail.com>
Message-ID: <CAMj1kXFW00GxG1dzqKMAqRjLT=6u4sWQAmft5k+f0E7++LcD=A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] crypto: qat - fallback for xts with 192 bit keys
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        qat-linux@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, 29 Jun 2020 at 19:05, Giovanni Cabiddu
<giovanni.cabiddu@intel.com> wrote:
>
> Thanks for your feedback Ard.
>
> On Fri, Jun 26, 2020 at 08:15:16PM +0200, Ard Biesheuvel wrote:
> > On Fri, 26 Jun 2020 at 10:04, Giovanni Cabiddu
> > <giovanni.cabiddu@intel.com> wrote:
> > >
> > > +static int qat_alg_skcipher_init_xts_tfm(struct crypto_skcipher *tfm)
> > > +{
> > > +       struct qat_alg_skcipher_ctx *ctx = crypto_skcipher_ctx(tfm);
> > > +       int reqsize;
> > > +
> > > +       ctx->ftfm = crypto_alloc_skcipher("xts(aes)", 0, CRYPTO_ALG_ASYNC);
> >
> > Why are you only permitting synchronous fallbacks? If the logic above
> > is sound, and copies the base.complete and base.data fields as well,
> > the fallback can complete asynchronously without problems.
> > Note that SIMD s/w implementations of XTS(AES) are asynchronous as
> > well, as they use the crypto_simd helper which queues requests for
> > asynchronous completion if the context from which the request was
> > issued does not permit access to the SIMD register file (e.g., softirq
> > context on some architectures, if the interrupted context is also
> > using SIMD)
> I did it this way since I though I didn't have a way to test it with an
> asynchronous sw implementation.
> I changed this line to avoid masking the asynchronous implementations
> and test it by forcing simd.c to use always cryptd (don't know if there
> is a simpler way to do it).
>

This is exactly how I tested it in the past, but note that the
extended testing that Eric implemented will also run from a context
where SIMD is disabled artificially, and so you should be getting this
behavior in any case.

> Also, I added to the mask CRYPTO_ALG_NEED_FALLBACK so I don't get another
> implementation that requires a fallback.
>
> I'm going to send a v3.
>
> Regards,
>
> --
> Giovanni

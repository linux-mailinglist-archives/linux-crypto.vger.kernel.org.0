Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7344284E
	for <lists+linux-crypto@lfdr.de>; Wed, 12 Jun 2019 16:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfFLOAe (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 12 Jun 2019 10:00:34 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52141 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfFLOAe (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 12 Jun 2019 10:00:34 -0400
Received: by mail-it1-f194.google.com with SMTP id m3so10961789itl.1
        for <linux-crypto@vger.kernel.org>; Wed, 12 Jun 2019 07:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lNz38gVScH0ZwwXvZkA7lMudaa552h7GcsXKvCgK7n8=;
        b=ZDBcRF02811s+WSMjtbQKUc3cu4oy5WYhiiDmv32leJtdNBnhdCpMoup+0zyYfahvY
         SF9ELNHUnXtz76GV6EmYvqhViKW83l1mK+QaKO8K0shTZVum8usa5lKLHO/gJfZT1Mm6
         TZlh30TC9qoknmanOSeTwnHcYB8ys6A4G9D17t3auUOIlZKAumPnmimzGsoOknC3UkcF
         pURsxKVE033qhEExP68wYT4Y6Sxa/q7s1NainUELd86WPaRZnFEmigkJl/CyhpfB1hU9
         HqBJsOJozWYYjxwd78mht9jHSi9nB1DKyzWev+0TIkCpBYLTUBAeW+LJm0hYpw9KQg6R
         LHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lNz38gVScH0ZwwXvZkA7lMudaa552h7GcsXKvCgK7n8=;
        b=bW1/IvYuT7jH5MAr/Ap794raT6NkOp2zwhRcEAxXyOlXr+nFwoDeivAZ72MqgzuwC1
         ajB+tszEf86oMCaiLAT6iJnTxhQ3aANczc4My2GVOmRKXKtr0FtuYHZUkpBmytRiUppi
         Q2Bg+KsZSoKDPNzxI3KnlN+ccmSzwUc3Ijp3XXP5KETlEN42Kj0qibjMuB5ZUDcsHrZo
         b0MgKMijLED0c3BcbCO41HNDtlRGod970zSScgktgKYQnU1VfSBKwhLX2aEGN6jaF5V8
         xneX+HYDKHUDTGMjYrYGYoiMuTccrIhUbF+uT8dvfZ8abkw1iwEVtGocaVZX8q54liaY
         mbzw==
X-Gm-Message-State: APjAAAX09f2eEjvOQS6RpfCVndKXbwTawvBSWJqssALet1G6vcXxLJId
        FJu4cWXsi/POA53BMYlZnkqNiADkVqTALnWys/ZOWBJwE/I=
X-Google-Smtp-Source: APXvYqw7/sEbaUteIwmblPQFjFM+lCFMOD3TIl/N8yU/hAnc3dFy9GTBIsWEbA8rFzGhV+wbmDAKo5sqQbxDMnkvJx8=
X-Received: by 2002:a05:660c:44a:: with SMTP id d10mr20502727itl.153.1560348033660;
 Wed, 12 Jun 2019 07:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190612124838.2492-1-ard.biesheuvel@linaro.org> <20190612135823.5w2dkibl4r7qcxx4@gondor.apana.org.au>
In-Reply-To: <20190612135823.5w2dkibl4r7qcxx4@gondor.apana.org.au>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 12 Jun 2019 16:00:20 +0200
Message-ID: <CAKv+Gu83M9_3DbAz9u_nmLs=4VL-BJh_L-FsEcFRAf4c2P=Gpw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/20] AES cleanup
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, 12 Jun 2019 at 15:58, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Wed, Jun 12, 2019 at 02:48:18PM +0200, Ard Biesheuvel wrote:
> >
> > All the patches leading up to that are cleanups for the AES code, to reduce
> > the dependency on the generic table based AES code, or in some cases, hardcoded
> > dependencies on the scalar arm64 asm code which suffers from the same problem.
> > It also removes redundant key expansion routines, and gets rid of the x86
> > scalar asm code, which is a maintenance burden and is not actually faster than
> > the generic code built with a modern compiler.
>
> Nice, I like this a lot.
>
> I presume you'll be converting the AES cipher users throughout
> the kernel (such as net/ipv4/tcp_fastopen) at some point, right?
>

Yes. I am currently surveying which users need to switch to a proper
mode, and which ones can just use the unoptimized library version
(such as tcp_fastopen).

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33F2243CE9
	for <lists+linux-crypto@lfdr.de>; Thu, 13 Aug 2020 18:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgHMQAm (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 13 Aug 2020 12:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgHMQAk (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 13 Aug 2020 12:00:40 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10263C061757
        for <linux-crypto@vger.kernel.org>; Thu, 13 Aug 2020 09:00:40 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id z3so5983519ilh.3
        for <linux-crypto@vger.kernel.org>; Thu, 13 Aug 2020 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Uz/cNk20B4Pdm+eJU2YEuMj3D+DxHPGJTVcvZP/a3A0=;
        b=oufo0qJRy+zUdMu2RRLiOPpc+oFdYwxzBrxeA2RO2v1Hq7EVwY6GcUUTumYFYOhqAV
         JNn95j8Txy9qR+TEnohzUY2uHBV6oTcN61e7BKaxzkaH6r5hlvjMPJ8a48njOqRKHaGy
         ou68AOWO0apfRAB/FYnW71DOUKQ0q3f/yk5zdKStoapzf/kUzt3vg8yl7y54/ZzOv7o3
         M+BfEwgPqY02DSqhHSKw8fJs44VsrEPS4pEUBqHXFmREi/NaSIdnxasTiihH4Hytqy+J
         +++PAcQFaerNbF+Sml9B3CvPGZHU4IVkDQKHCj04ZQYBVXQtHoQDlIKecwvn672PBMlr
         GV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Uz/cNk20B4Pdm+eJU2YEuMj3D+DxHPGJTVcvZP/a3A0=;
        b=mNyIs49yL7EC/QKaaS7NNJ+2VK9p2j3TZCLtbJL7kYvZYUOQudLx8S3ldWMwuFF7hk
         DifIFtfm4VNUady51NXNqLyBcLo46YzYyvSwtW1OiAqudL5wqp+Iia8OP/n6HtnAoqkZ
         SAnIZSXlfR1ADSlrpNe2d24olk8yQztk3BnXT0nV0VHWHq8OVOCjWpzpRmwfpMVCva+K
         wlufq8l1cqieeKcZSal58hc4qoIqxbrxgddxFOHtoGjf3O0wGeSh9/zO4D5a8AbWN3Z2
         3nRqi/kdOy8tCMWuotkVyq2XWt3NAX2lxT2SUm71/BbqA/AND9aFoPKJYoHMvtQvGkwd
         HIXQ==
X-Gm-Message-State: AOAM532Z5e3G73iw9fgkY8P3lITnwnrzCmBKE6AXQyqHNSm6iFustU9p
        azcmJWveB2kUyzomxAiqKW2jcGYWlRUmLcoXkzbqvw==
X-Google-Smtp-Source: ABdhPJwKqPqcruBTSV9njnp+FvydcJNbp87iYi13v4mGMy05g5pWk8X+GVk8lyQJCQrtt7yn5LABftixZOTvUQcIlOk=
X-Received: by 2002:a92:da0a:: with SMTP id z10mr5241022ilm.275.1597334439072;
 Thu, 13 Aug 2020 09:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200713172511.GB722906@gmail.com> <20200731072654.GA17312@gondor.apana.org.au>
In-Reply-To: <20200731072654.GA17312@gondor.apana.org.au>
From:   Elena Petrova <lenaptr@google.com>
Date:   Thu, 13 Aug 2020 17:00:27 +0100
Message-ID: <CABvBcwbQY9nnDu5LSRUDHqPcmnedwa-juQaFdirDY3zTuZB0yA@mail.gmail.com>
Subject: Re: [PATCH 1/1] crypto: af_alg - add extra parameters for DRBG interface
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Herbert,

On Fri, 31 Jul 2020 at 08:27, Herbert Xu <herbert@gondor.apana.org.au> wrot=
e:
>
> How about you fork the code in rng_accept_parent so that you have
> a separate proto_ops for the test path that is used only if
> setentropy has been called? That way all of this code could
> magically go away if the CONFIG option wasn't set.

I tried doing `ask->type->ops =3D &algif_rng_test_ops;` in
accept_parent, to which the compiler complained "error: assignment of
member =E2=80=98ops=E2=80=99 in read-only object". So I'm setting `.ops` ac=
cordingly
at compile-time instead, together with `.setentropy`, in v5.

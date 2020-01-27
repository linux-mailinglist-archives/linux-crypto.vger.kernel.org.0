Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACE614A71B
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Jan 2020 16:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgA0PXG (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 27 Jan 2020 10:23:06 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33210 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729321AbgA0PXG (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 27 Jan 2020 10:23:06 -0500
Received: by mail-oi1-f195.google.com with SMTP id q81so7020387oig.0;
        Mon, 27 Jan 2020 07:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QjMETMAiTJJTMebxmvIOpTK7NVSsq+l6+TUBDAz7YBI=;
        b=l+mgQm9Ck7Wa4k0wcJBjI5Tbt1OmwKNIoGXfNYNgSHQHc9YnvbN3UwGH3Pvkar+l5f
         Itj72vMZ4AC9qn1ySoXfBoyCDiCtkzREeRRBiJ7wOZ8fNA9E+8i6GMB3mShBDmGehgT1
         l+TnkQBmmmUkDuROcIxkaNZAOLaiu/6V1A9BYupGZCEG6HrzN18R3ttqvMRpW5NGneCL
         bhtfOiHKGCtxFt32P4QXT23ak2zCnS93gg6Y2rOX6GoCaHyq+ecQrjbsx0Gmm+QlhSE0
         WX/zFnBRA6uIV51oDS7hwjgdZ3rfUcdHv1SMBWDvA4LhjHwB3/ifF+bA4yYlxqJmXChk
         ozew==
X-Gm-Message-State: APjAAAVjm2nBmhm0HL5PTAtBnJWg48nZbx7tBDZsUDoJBH9BDU9QbZwh
        mgj/LSU2JTXW13I4vUgm6OatvMHxoKC7WwOprs0=
X-Google-Smtp-Source: APXvYqyW430rZeoGKx0G2SJ+AsecepsCGqYv+wt0UG2cgxYfnOE26nbnPWxdzrg6jFL8pApJnjrjGGpLXYgKKHKH6pw=
X-Received: by 2002:aca:5905:: with SMTP id n5mr7883509oib.54.1580138585003;
 Mon, 27 Jan 2020 07:23:05 -0800 (PST)
MIME-Version: 1.0
References: <20200127150822.12126-1-gilad@benyossef.com>
In-Reply-To: <20200127150822.12126-1-gilad@benyossef.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Jan 2020 16:22:53 +0100
Message-ID: <CAMuHMdVFcsS9K=7+LfT_Tmmpz4LMS69=+EO+8_BkJoXCOfPzPA@mail.gmail.com>
Subject: Re: [RFC v3] crypto: ccree - protect against short scatterlists
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Gilad,

On Mon, Jan 27, 2020 at 4:08 PM Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> Deal gracefully with the event of being handed a scatterlist
> which is shorter than expected.
>
> This mitigates a crash in some cases due to
> attempt to map empty (but not NULL) scatterlists with none
> zero lengths.
>
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thank you, boots fine on Salvator-XS with R-Car H3ES2.0, and
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

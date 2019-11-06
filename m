Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 921B6F0EFD
	for <lists+linux-crypto@lfdr.de>; Wed,  6 Nov 2019 07:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbfKFGj3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 6 Nov 2019 01:39:29 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36148 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729470AbfKFGj3 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 6 Nov 2019 01:39:29 -0500
Received: by mail-vs1-f66.google.com with SMTP id q21so15253739vsg.3
        for <linux-crypto@vger.kernel.org>; Tue, 05 Nov 2019 22:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=naIjmil/eDlIhuN1fRpN8utbfrj7V2f7nfg6i0zi9os=;
        b=O8lvHuCYOsjSvIspZjZEamNdAc57lSBhmQ4BHC0WDcT4VZ6sGPlb8JILexnhOnK5uk
         C+/pbM6qg/RShmMIJccN1TdVIsXzH1Ast6gI9pUXWwnoZFK3BqBKfTdsm/dwNGR9kqg8
         YqllsdJCRsf/MRH3XLhBVT6BtP8wOvN4UWElp70sZNQBnQA8M4OQr+NMWr4D+fBOnzX4
         oV2gc1kFuavAza+0lWf4HkSgyoZKkJiaVdd2UNHd+NH5Wj7VG3fDt6BCAUVOpTmNo5k1
         e1Jl3oMoAkNSQgDZ+0IeK9AZb1z5WHXlZFzwziF6CCXfipjcjeaoWpEgiBzaD6jNR+ft
         Hqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=naIjmil/eDlIhuN1fRpN8utbfrj7V2f7nfg6i0zi9os=;
        b=J66ex49s3zsVzrpViTs8bKoITdsZD2ysICgeaHx5u53MDlIrE4UIu6ZcVfQjGT6LIb
         5lG2OQ5PMDezslXgUP8MIksAb5h4q8DXdVKC80Qmu+t0kpM1bLYtl8h1PJu1F1IB59es
         eKk+fiTuiqEVmFBiUeP0+5OEIiQcPdln8Nz1mvG9Dj/9Sd71X3Oct8I7hXzwufzG72ot
         Y23sRQq3ZqfTB2WNiw7RIaYiY+PepPlJ7V91H3GAQbAjUNUajt+OSjIiEdG6NyCEN5Hn
         piXlmVhbt+0DnWmy0q4YPqF9+oPFwDHbo+NxDmA4tomUdg4iVCmwYxI48DyEQu0TSt0a
         xBiw==
X-Gm-Message-State: APjAAAV1oEqbUCqMLihn4ndE77hfIsi9o1icxq3xOEFyad4lU0mNaxVL
        +IYg+iSWd+CGSUlb40UK/I7jbXzDIgRF6sE7t8dHzKtNyjevHw==
X-Google-Smtp-Source: APXvYqwx1zhWLMrwogf094GTv2o+PG1mzKh4ezkBNg26UoMeRywODdweQCGivqRbHtYgcJ5q6W1s0Kqvq8Xf1BLrOEc=
X-Received: by 2002:a67:324d:: with SMTP id y74mr504583vsy.193.1573022367862;
 Tue, 05 Nov 2019 22:39:27 -0800 (PST)
MIME-Version: 1.0
References: <20191017122549.4634-1-t-kristo@ti.com> <20191017122549.4634-10-t-kristo@ti.com>
In-Reply-To: <20191017122549.4634-10-t-kristo@ti.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Wed, 6 Nov 2019 08:39:16 +0200
Message-ID: <CAOtvUMeBXjDBhSVgMOW=hshEx_AkNPg-Zk2c2jCDzY8vyXWW5g@mail.gmail.com>
Subject: Re: [PATCH 09/10] crypto: add timeout to crypto_wait_req
To:     Tero Kristo <t-kristo@ti.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        David Miller <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-omap@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi,


On Thu, Oct 17, 2019 at 3:26 PM Tero Kristo <t-kristo@ti.com> wrote:
>
> Currently crypto_wait_req waits indefinitely for an async crypto request
> to complete. This is bad as it can cause for example the crypto test
> manager to hang without any notification as to why it has happened.
> Instead of waiting indefinitely, add a 1 second timeout to the call,
> and provide a warning print if a timeout happens.

While the incentive is clear and positive, this suggested solution
creates problems of its own.
In many (most?) cases where we are waiting here, we are waiting for a
DMA operation to finish from hardware.
Exiting while this pending DMA operation is not finished, even with a
proper error return value, is dangerous because
unless the calling code takes great care to not release the memory the
DMA is being done from/to, this can have disastrous effects.

As Eric has already mentioned, one second might seem like a long time,
but we don't really know if it is enough.

How about adding a second API (ig. crypto_wait_req_timeout) which
supports a calee specified timeout where
the calle knows how to correctly deal with timeout and port the
relevant call sites to use this?

Thanks!
Gilad


>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  include/linux/crypto.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/crypto.h b/include/linux/crypto.h
> index 19ea3a371d7b..b8f0e5c3cc0c 100644
> --- a/include/linux/crypto.h
> +++ b/include/linux/crypto.h
> @@ -682,8 +682,15 @@ static inline int crypto_wait_req(int err, struct cr=
ypto_wait *wait)
>         switch (err) {
>         case -EINPROGRESS:
>         case -EBUSY:
> -               wait_for_completion(&wait->completion);
> +               err =3D wait_for_completion_timeout(&wait->completion,
> +                                                 msecs_to_jiffies(1000))=
;
>                 reinit_completion(&wait->completion);
> +               if (!err) {
> +                       pr_err("%s: timeout for %p\n", __func__, wait);
> +                       err =3D -ETIMEDOUT;
> +                       break;
> +               }
> +
>                 err =3D wait->err;
>                 break;
>         };
> --
> 2.17.1
>
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/=
Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki



--
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!

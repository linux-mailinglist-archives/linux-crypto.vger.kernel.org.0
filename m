Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06F752C8D6
	for <lists+linux-crypto@lfdr.de>; Tue, 28 May 2019 16:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfE1Oaj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 28 May 2019 10:30:39 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36471 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfE1Oaj (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 28 May 2019 10:30:39 -0400
Received: by mail-oi1-f194.google.com with SMTP id y124so14433702oiy.3
        for <linux-crypto@vger.kernel.org>; Tue, 28 May 2019 07:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lpp7ccSUbaTg2wXqVqozx7r8Gn8naMF1nG94XiI2Q9g=;
        b=HnCwTxfsJnlmsP08ZQ0PdvAHAod51xM4PwwImHTeKCfsDkMxvnk8KQjmWr3woHeiRP
         ia25bF/13+tiyXaUnwL8jdenYbMjGUugUhu0LQ2RHBL+mLpvZ3mO+c3JEcidpBEmuOwy
         +mo6su5gYPLNYOGjy9udW4Q8oG/7Kr23n6VOKjjsAELPF429CpkCLl8tCkkxfE7Zq6nV
         YRqUhdG12U5Il4Ks5xCsNTve69Zm0LlKz3hxqCX8oKYkeb2/5r60zBODPJptLQJq/gKu
         ylbLk70QH4pVt7WfaNdqYC77dbU9hw9Q6+ew1kakZMvKb7keONqGPA5nBvnHAzMSIOfq
         pFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lpp7ccSUbaTg2wXqVqozx7r8Gn8naMF1nG94XiI2Q9g=;
        b=ogqpYdNpmpU1zyEmz0TMdWihae8yHFOWVdm/HpWAcnjzYSTOij2h/Pv+perNLY8b3T
         zoy8mSaR+eqz8r8pIZOtmzNyS6magjBnktuKVTYF2HaEbQVlPVoiwtx5ZOPdOhsdExiT
         8V/ukx+IBi6c2llYjnuzJqcn2dNp9jdhrTZRERIXY8GdwaRbz8yXDA8sn5U3/TokgxtS
         l0OIKU2/JwWVGsvC2OyD7yJl8z8iTIz23077A0NGZD6B9ZBHDV4a2AelKzxrIZTCpfMe
         uzO6yTb156j+spdE0ZICaTbb3J7o9etLeptNlcEJDdfljGDjlLSD+zFyBvOK+OhDi2/I
         xRag==
X-Gm-Message-State: APjAAAW5hHYEbSUASwzTiCjDJcKX5OoMoxV1HnuKlcqN3jEHWbTynMHZ
        Yfb5gDskn6g3f8IM0Qi0IlCAKAamhzFDZG27J89EFg==
X-Google-Smtp-Source: APXvYqwtRY1qZkkr7pOUSUxZXKWWl1KraL9oQkS+ZtGpNkzeRus8PXqAm1up7i9MOE3zDldklzMklrWSokbuG6ekzcM=
X-Received: by 2002:aca:418a:: with SMTP id o132mr2810723oia.16.1559053838114;
 Tue, 28 May 2019 07:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190528124152.191773-1-lenaptr@google.com> <CAKv+Gu-Bzb6bucFXgW+EgU2bh9Kp-rAJWq5TSNrk7n_rMGkx9g@mail.gmail.com>
In-Reply-To: <CAKv+Gu-Bzb6bucFXgW+EgU2bh9Kp-rAJWq5TSNrk7n_rMGkx9g@mail.gmail.com>
From:   Elena Petrova <lenaptr@google.com>
Date:   Tue, 28 May 2019 15:30:27 +0100
Message-ID: <CABvBcwYuimLrM3fDK5tjHT3G3=nHLd=rUiPSCCWqAyPK4E_3SA@mail.gmail.com>
Subject: Re: [PATCH] arm64 sha1-ce finup: correct digest for empty data
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Yep, sha2 also has the bug, I'll be sending the fix soon, thanks!

On Tue, 28 May 2019 at 14:03, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Tue, 28 May 2019 at 14:42, Elena Petrova <lenaptr@google.com> wrote:
> >
> > The sha1-ce finup implementation for ARM64 produces wrong digest
> > for empty input (len=0). Expected: da39a3ee..., result: 67452301...
> > (initial value of SHA internal state). The error is in sha1_ce_finup:
> > for empty data `finalize` will be 1, so the code is relying on
> > sha1_ce_transform to make the final round. However, in
> > sha1_base_do_update, the block function will not be called when
> > len == 0.
> >
> > Fix it by setting finalize to 0 if data is empty.
> >
> > Fixes: 07eb54d306f4 ("crypto: arm64/sha1-ce - move SHA-1 ARMv8 implementation to base layer")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Elena Petrova <lenaptr@google.com>
>
> Thanks for the fix
>
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> It looks like the sha224/256 suffers from the same issue. Would you
> mind sending out a fix for that as well? Thanks.
>
> > ---
> >  arch/arm64/crypto/sha1-ce-glue.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/crypto/sha1-ce-glue.c b/arch/arm64/crypto/sha1-ce-glue.c
> > index eaa7a8258f1c..0652f5f07ed1 100644
> > --- a/arch/arm64/crypto/sha1-ce-glue.c
> > +++ b/arch/arm64/crypto/sha1-ce-glue.c
> > @@ -55,7 +55,7 @@ static int sha1_ce_finup(struct shash_desc *desc, const u8 *data,
> >                          unsigned int len, u8 *out)
> >  {
> >         struct sha1_ce_state *sctx = shash_desc_ctx(desc);
> > -       bool finalize = !sctx->sst.count && !(len % SHA1_BLOCK_SIZE);
> > +       bool finalize = !sctx->sst.count && !(len % SHA1_BLOCK_SIZE) && len;
> >
> >         if (!crypto_simd_usable())
> >                 return crypto_sha1_finup(desc, data, len, out);
> > --
> > 2.22.0.rc1.257.g3120a18244-goog
> >

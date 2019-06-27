Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56EDB584E1
	for <lists+linux-crypto@lfdr.de>; Thu, 27 Jun 2019 16:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfF0OvN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 27 Jun 2019 10:51:13 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46567 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfF0OvM (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 27 Jun 2019 10:51:12 -0400
Received: by mail-io1-f66.google.com with SMTP id i10so5275015iol.13
        for <linux-crypto@vger.kernel.org>; Thu, 27 Jun 2019 07:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nf6sFKs4LT9dSO7MfCf0aImYMK46j5gTzbsiLnA+kfQ=;
        b=Mr/gMatrfMJXugdmNpA6/qQhR2MDqzzZsNlLYR5sufdkU36CtPai/XG+mYNpEaj+qy
         mIa38FSQ/VwpCTkEl3VbPhPlgqqjK/X0JKJMND5CsITRVoG5I2OII4cNmN8z5u1kZ7EL
         KpT2ZHWLfLchbr6jyG7jQcB5f8F+SOkkGXHrzi3hO2KNk2MKtpKh3jExysLdOcnYRGZx
         kx5XzwEThB6Dx0yEtBSzKvsd+PRI5AxCwu16z37ZS5O0y7X9McUES/fLbDItnuChAsFU
         ZOCc90P9Q8babUGkEAB9t4FmWemYqbWGzHsiRqC6P/aSWOncD+YyqFuW15ZSUXtB4ej2
         7DVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nf6sFKs4LT9dSO7MfCf0aImYMK46j5gTzbsiLnA+kfQ=;
        b=T0vXLlTU0RTtp4FoyrA0JI9AzAY+xpp14EPuTbtTjWEZmJYVLR7m+7YpZPRNHLoRve
         csQIP4gcajv2YOZlwBY+PvtGpVAmNxcSl+gwwwILH7IrfvloMZUrWmpXCNvAbvf2mzu3
         Jabj0mDbwsx++4zV84pEXRezXFMfCmL6C5SgxVbsMD9FeDK2uhbdv1JMF1iwmfxiDUhF
         Ehomuiieub13Pgv7UK5jkS8uYQ4JWH1n2mjRdMivk1OWGYi5lKpYGCEX3q2a8zW5/yir
         pq3tpvBSD5RK43FuHPiZzhD9/xNIcW0AEL081rAqOezfHKOg0YNwBcn0lDbQAI9vk4ZE
         jFMw==
X-Gm-Message-State: APjAAAU6C5Vhz3EUPUrwiGZsHEltXL5L+JCyKcvUBZsZFpAgMGIbt2My
        5PROVBn8dgjuUVRms462a9PTjbHb2IEJIYhkAIWrpA==
X-Google-Smtp-Source: APXvYqyQPNSmypoEar24diS4kfQj9Z2MZQUlzGY9I7lMXoH85XMSKWgLIuBHgBHdLvJZh9QgEvIjVkLGdeNfR+sDFXg=
X-Received: by 2002:a05:6602:98:: with SMTP id h24mr5050261iob.49.1561647072129;
 Thu, 27 Jun 2019 07:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190627120314.7197-1-ard.biesheuvel@linaro.org> <VI1PR0402MB348548C6873044033C94F63998FD0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0402MB348548C6873044033C94F63998FD0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 27 Jun 2019 16:50:59 +0200
Message-ID: <CAKv+Gu-JtxJ9KHRx6f6pAKKd17BojJqy-nrju64oKTT0tM2KrA@mail.gmail.com>
Subject: Re: [PATCH v2 00/30] crypto: DES/3DES cleanup
To:     Horia Geanta <horia.geanta@nxp.com>
Cc:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, 27 Jun 2019 at 16:44, Horia Geanta <horia.geanta@nxp.com> wrote:
>
> On 6/27/2019 3:03 PM, Ard Biesheuvel wrote:
> > n my effort to remove crypto_alloc_cipher() invocations from non-crypto
> > code, i ran into a DES call in the CIFS driver. This is addressed in
> > patch #30.
> >
> > The other patches are cleanups for the quirky DES interface, and lots
> > of duplication of the weak key checks etc.
> >
> > Changes since vpub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/fixes1/RFC:
> > - fix build errors in various drivers that i failed to catch in my
> >   initial testing
> > - put all caam changes into the correct patch
> > - fix weak key handling error flagged by the self tests, as reported
> >   by Eric.
> I am seeing a similar (?) issue:
> alg: skcipher: ecb-des-caam setkey failed on test vector 4; expected_error=-22, actual_error=-126, flags=0x100101
>
> crypto_des_verify_key() in include/crypto/internal/des.h returns -ENOKEY,
> while testmgr expects -EINVAL (setkey_error = -EINVAL in the test vector).
>
> I assume crypto_des_verify_key() should return -EINVAL, not -ENOKEY.
>

Yes, but I tried to keep handling of the crypto_tfm flags out of the
library interface.

I will try to find a way to solve this cleanly.

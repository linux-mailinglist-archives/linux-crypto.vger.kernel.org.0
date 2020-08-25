Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAD4251A74
	for <lists+linux-crypto@lfdr.de>; Tue, 25 Aug 2020 16:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgHYODl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 25 Aug 2020 10:03:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgHYN71 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 25 Aug 2020 09:59:27 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D688F2075F
        for <linux-crypto@vger.kernel.org>; Tue, 25 Aug 2020 13:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598363967;
        bh=JUtbshDiaqT1abUNYm22UsrMzF65PvCYAKmKkgX37is=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WCXNF2cgC8BTqW48R2a4J7798vAgaKoERgWz8F6WZGl9gQ+5r+U1sfVV8p4hPzyQn
         7CW0X5B5BAF1y9FdNQj8tbPfWByeV9zTYP/H9gDJTDWHwilLnwx+F2G0WLwBVjZ38K
         9mfcZJhj4GJ5JuoZY+KnO/F5L9mLD36/eVKmjzrM=
Received: by mail-oi1-f169.google.com with SMTP id b9so8239257oiy.3
        for <linux-crypto@vger.kernel.org>; Tue, 25 Aug 2020 06:59:26 -0700 (PDT)
X-Gm-Message-State: AOAM530mtI86sjju57GR8Fk6cl422BBa848dhf+AJHho07F5DpalB6tO
        5QNr0szsxjuQSW9SK+9Ri4xRVIxURarDSDxUxQo=
X-Google-Smtp-Source: ABdhPJy3nEfd6uI97/6QE72ErSZH4qiw9sQ+yjnPjzpbfrf+4FPUFC4/ZHF0KynKlWRV9NYzKr9rCOZDDvISbd4+yY0=
X-Received: by 2002:a05:6808:b37:: with SMTP id t23mr1131302oij.174.1598363966153;
 Tue, 25 Aug 2020 06:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200825013801.GA16040@gondor.apana.org.au>
In-Reply-To: <20200825013801.GA16040@gondor.apana.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 25 Aug 2020 15:59:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXECU_-VNy0xB+ZLHpB2mLh5MJiFP62ufgKCqWg7H1iCyg@mail.gmail.com>
Message-ID: <CAMj1kXECU_-VNy0xB+ZLHpB2mLh5MJiFP62ufgKCqWg7H1iCyg@mail.gmail.com>
Subject: Re: [PATCH] crypto: arm64/gcm - Fix endianness warnings
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, 25 Aug 2020 at 03:41, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> This patch changes a couple u128's to be128 which is the correct
> type to use and fixes a few sparse warnings.
>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

>
> diff --git a/arch/arm64/crypto/ghash-ce-glue.c b/arch/arm64/crypto/ghash-ce-glue.c
> index da1034867aaa..8536008e3e35 100644
> --- a/arch/arm64/crypto/ghash-ce-glue.c
> +++ b/arch/arm64/crypto/ghash-ce-glue.c
> @@ -347,7 +347,7 @@ static int gcm_encrypt(struct aead_request *req)
>         u8 buf[AES_BLOCK_SIZE];
>         u8 iv[AES_BLOCK_SIZE];
>         u64 dg[2] = {};
> -       u128 lengths;
> +       be128 lengths;
>         u8 *tag;
>         int err;
>
> @@ -461,7 +461,7 @@ static int gcm_decrypt(struct aead_request *req)
>         u8 buf[AES_BLOCK_SIZE];
>         u8 iv[AES_BLOCK_SIZE];
>         u64 dg[2] = {};
> -       u128 lengths;
> +       be128 lengths;
>         u8 *tag;
>         int err;
>
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

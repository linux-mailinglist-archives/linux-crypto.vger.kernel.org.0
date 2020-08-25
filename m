Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D9C251329
	for <lists+linux-crypto@lfdr.de>; Tue, 25 Aug 2020 09:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgHYH2l (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 25 Aug 2020 03:28:41 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:60439 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729194AbgHYH2k (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 25 Aug 2020 03:28:40 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 13883660
        for <linux-crypto@vger.kernel.org>;
        Tue, 25 Aug 2020 07:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=NMENzzTX1zhasNayqo4q92jUkVg=; b=3QWB8M
        OazKF7r+G/Ert0IxmicXqb2Fjl7qd8YjwwI8m6IIArX5UfS/rq82ufM3AmFz1hCt
        BembXEtpcHb4fYB98lD3Gr8iY4yUoUyzqrlPvk0llv8Nn7Sfx1XRZv104+dLbC5Z
        j3ulxDrFkP/i7sopdcEJzr9+zCFezIEGtUJSQng3awh9dX4jh3iakgg2hkVPgqff
        KTdf9ZMRhrUcerxbBH0mmIH2CjZNal5rnpp2AubJPNuDw/vKoYB/mUdYNd+rPfKq
        gS+KGDmRVrTKyQCLLKDWlaD6cZlaGjvlZwRexTY5v4AeXqvH/5Pv29+eULviQdda
        Gf9KajEXuZVwrNfQ==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c3a401b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-crypto@vger.kernel.org>;
        Tue, 25 Aug 2020 07:01:34 +0000 (UTC)
Received: by mail-il1-f172.google.com with SMTP id e11so9578880ils.10
        for <linux-crypto@vger.kernel.org>; Tue, 25 Aug 2020 00:28:37 -0700 (PDT)
X-Gm-Message-State: AOAM532uJ+lbDyiJQUoWwShy5JQpPd12+PTZHqCxJwWyO/0lrEH6Coy9
        DDn5r+H94gN/oppY2IbkisjybM6dD744aGkiSkU=
X-Google-Smtp-Source: ABdhPJyCkUWlguZLJVB3BFku7Rtkm6WCZS+TuVMOzSXWQhfPVyGmWnu+TikJW726e1YpK2ToufzTCdsfgLXH67XlEeE=
X-Received: by 2002:a92:cf09:: with SMTP id c9mr8647326ilo.38.1598340517019;
 Tue, 25 Aug 2020 00:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200825012300.GA10236@gondor.apana.org.au>
In-Reply-To: <20200825012300.GA10236@gondor.apana.org.au>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 25 Aug 2020 09:28:25 +0200
X-Gmail-Original-Message-ID: <CAHmME9pUFC2TVsYvCRaXR8Bop4WkpwuB_4paXy+B7Ou53G4GhQ@mail.gmail.com>
Message-ID: <CAHmME9pUFC2TVsYvCRaXR8Bop4WkpwuB_4paXy+B7Ou53G4GhQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: arm/poly1305 - Add prototype for poly1305_blocks_neon
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Aug 25, 2020 at 3:23 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> This patch adds a prototype for poly1305_blocks_neon to slience
> a compiler warning:
>
>   CC [M]  arch/arm/crypto/poly1305-glue.o
> ../arch/arm/crypto/poly1305-glue.c:25:13: warning: no previous prototype for `poly1305_blocks_neon' [-Wmissing-prototypes]
>  void __weak poly1305_blocks_neon(void *state, const u8 *src, u32 len, u32 hibit)
>              ^~~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
> diff --git a/arch/arm/crypto/poly1305-glue.c b/arch/arm/crypto/poly1305-glue.c
> index 13cfef4ae22e..3023c1acfa19 100644
> --- a/arch/arm/crypto/poly1305-glue.c
> +++ b/arch/arm/crypto/poly1305-glue.c
> @@ -20,6 +20,7 @@
>
>  void poly1305_init_arm(void *state, const u8 *key);
>  void poly1305_blocks_arm(void *state, const u8 *src, u32 len, u32 hibit);
> +void poly1305_blocks_neon(void *state, const u8 *src, u32 len, u32 hibit);

LGTM.

Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>

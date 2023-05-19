Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD3E709334
	for <lists+linux-crypto@lfdr.de>; Fri, 19 May 2023 11:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjESJct (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 19 May 2023 05:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjESJcD (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 19 May 2023 05:32:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AB3173F;
        Fri, 19 May 2023 02:31:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F16464CDE;
        Fri, 19 May 2023 09:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677DCC433EF;
        Fri, 19 May 2023 09:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684488704;
        bh=Wo6aGM9cMseGU3T2MfA5XaiUStVvCxymzAqjTPuQrOc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jQPVl6A2pn0VQIrA1hVc1PlCbtNaL0uZhzqZNUzJwSWKH+Ic92iBAtIzk3CLt8qp5
         +iaiLUHZv01bLmM3eUtVSJmUsB3MtvJDjGNibAmqqtF67kWMPEfEecnp7iqsnL8+vM
         xdBSA4o2KZPbkXs15rDyAg7mgLbX+FNZ3DFcUQfehCeDMl5C7jHVke2XdCPzdB26FE
         jWmoVpIzLR6UIWvAZVuP42wbiop4lB1XswWmdjPKUn/Zw7yLLWNB2rnvIEWnCetrss
         TB1F5JJ81ZEJWG6jGMfnw25IlqqZDjkfIFJTJjOpw37U0HK7H5iD2aosJjSwr3l3T5
         p/9zBfQVMQxjQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f27977aed6so3408683e87.2;
        Fri, 19 May 2023 02:31:43 -0700 (PDT)
X-Gm-Message-State: AC+VfDz8gBZ0V1H49dzS1URe8wQcytUVM/N73dVg7gViqqNw3G1FkF3S
        uwtjkcjOzX6R5WPl2RvvhBnlBoHVihsro8UJSvU=
X-Google-Smtp-Source: ACHHUZ5YHw31xc+H7E05DkWGGdkgHKQ45BBiWSUzd7O64DAUqT19DMJBcQtsqj+slsJOdFkPrwkiDdynE120Hq8wA3Q=
X-Received: by 2002:ac2:519c:0:b0:4ef:efb5:bfea with SMTP id
 u28-20020ac2519c000000b004efefb5bfeamr668495lfi.37.1684488701391; Fri, 19 May
 2023 02:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <ZGcyuyjJwZhdYS/G@gondor.apana.org.au> <E1pzvTZ-00AnMQ-5M@formenos.hmeau.com>
 <CAMj1kXGwS03zUBTGb7jmk1-6r+=a-HH+A-S9ZFTYRyJSzN0Xcg@mail.gmail.com> <ZGc7hCaDrnEFG8Lr@gondor.apana.org.au>
In-Reply-To: <ZGc7hCaDrnEFG8Lr@gondor.apana.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 19 May 2023 11:31:30 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEkz1QvkXWc8dCGhU_MPf+1M3P2+rAiLciuixnKCmRESg@mail.gmail.com>
Message-ID: <CAMj1kXEkz1QvkXWc8dCGhU_MPf+1M3P2+rAiLciuixnKCmRESg@mail.gmail.com>
Subject: Re: [PATCH] crypto: shash - Allow cloning on algorithms with no init_tfm
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Dmitry Safonov <dima@arista.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, 19 May 2023 at 11:04, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Fri, May 19, 2023 at 10:54:11AM +0200, Ard Biesheuvel wrote:
> >
> > Does this imply that the cmac-aes-ce and cmac-aes-neon implementations
> > for arm64 need a similar treatment?
>
> Good catch.  Since these don't have init functions we can deal
> with them at a higher level:
>
> ---8<---
> Some shash algorithms are so simple that they don't have an init_tfm
> function.  These can be cloned trivially.  Check this before failing
> in crypto_clone_shash.
>

OK. So IIUC, cloning a keyless hash just shares the TFM and bumps the
refcount, but here we must actually allocate a new TFM referring to
the same algo, and this new TFM needs its key to be set before use, as
it doesn't inherit it from the clonee, right? And this works in the
same way as cloning an instance of the generic HMAC template, as this
will just clone the inner shash too, and will also leave the key
unset.

If so,

Acked-by: Ard Biesheuvel <ardb@kernel.org>

If not, could you explain it to me again? :-)


> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
> diff --git a/crypto/shash.c b/crypto/shash.c
> index 717b42df3495..1fadb6b59bdc 100644
> --- a/crypto/shash.c
> +++ b/crypto/shash.c
> @@ -597,7 +597,7 @@ struct crypto_shash *crypto_clone_shash(struct crypto_shash *hash)
>                 return hash;
>         }
>
> -       if (!alg->clone_tfm)
> +       if (!alg->clone_tfm && (alg->init_tfm || alg->base.cra_init))
>                 return ERR_PTR(-ENOSYS);
>
>         nhash = crypto_clone_tfm(&crypto_shash_type, tfm);
> @@ -606,10 +606,12 @@ struct crypto_shash *crypto_clone_shash(struct crypto_shash *hash)
>
>         nhash->descsize = hash->descsize;
>
> -       err = alg->clone_tfm(nhash, hash);
> -       if (err) {
> -               crypto_free_shash(nhash);
> -               return ERR_PTR(err);
> +       if (alg->clone_tfm) {
> +               err = alg->clone_tfm(nhash, hash);
> +               if (err) {
> +                       crypto_free_shash(nhash);
> +                       return ERR_PTR(err);
> +               }
>         }
>
>         return nhash;
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

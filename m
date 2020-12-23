Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B13B2E1A59
	for <lists+linux-crypto@lfdr.de>; Wed, 23 Dec 2020 10:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgLWJHi (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 23 Dec 2020 04:07:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:32872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727940AbgLWJHh (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 23 Dec 2020 04:07:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 41477207CD
        for <linux-crypto@vger.kernel.org>; Wed, 23 Dec 2020 09:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608714416;
        bh=02kZNEDLbTf74ZQw5TBK/SmUg9cNEWO6F2RbmGNGwBM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a1MCjmYXdDSsDJ6jRro/zmoZuTe6vOW2tGs56MX5hh7ccLgI+RUXpO5gr9R1Ekg7x
         baa90kLzrw6KEQdxov3AoXS6kTRkC9LrcP/HMDsm2dSO4G3op8rDnZ92IGzHVE3dKe
         kKFOgf1Xlay5yWO63Pf7OFYoGElRce358vLy3WcqNmmZEpqxlKsZNddVW46Pr0fc/n
         tn2KW4X+Hr0sNPjztMBvSt2w7nxdlLP54PqfOrvyNntNhWjbW41oWsZgQtLmula49M
         W+kZSGEQVQYzLMVg1YupcEkLTc/fnca3aPSKOC7V3YO9fI0yN1tVY0LlJbxBZAOeV7
         ZWYnkVpQm/8zg==
Received: by mail-oi1-f181.google.com with SMTP id s75so17645749oih.1
        for <linux-crypto@vger.kernel.org>; Wed, 23 Dec 2020 01:06:56 -0800 (PST)
X-Gm-Message-State: AOAM533htf7wK/VFouF6ggdWK39ybHvdvwBfHz6mNZv+K6Hk527BA+E4
        /nZoIJPBSwq1GL1uDEmIBfkRLBu+103CYPIiD/M=
X-Google-Smtp-Source: ABdhPJwFARdFj4DHOSqQciQ/rfbHNVXlyqoEVwJUueo5le+jj+/LCMSeHJ+yyoTTfTCFBGgFpHxXNXIChfq3O9tCENQ=
X-Received: by 2002:aca:dd03:: with SMTP id u3mr17297513oig.47.1608714415591;
 Wed, 23 Dec 2020 01:06:55 -0800 (PST)
MIME-Version: 1.0
References: <20201223081003.373663-1-ebiggers@kernel.org> <20201223081003.373663-7-ebiggers@kernel.org>
In-Reply-To: <20201223081003.373663-7-ebiggers@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 23 Dec 2020 10:06:44 +0100
X-Gmail-Original-Message-ID: <CAMj1kXECQh_U+N2XqUdijy+rAfX035DWH+23ZBb7g49b8mdPog@mail.gmail.com>
Message-ID: <CAMj1kXECQh_U+N2XqUdijy+rAfX035DWH+23ZBb7g49b8mdPog@mail.gmail.com>
Subject: Re: [PATCH v3 06/14] crypto: blake2s - optimize blake2s initialization
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Sterba <dsterba@suse.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Paul Crowley <paulcrowley@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, 23 Dec 2020 at 09:12, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> If no key was provided, then don't waste time initializing the block
> buffer, as its initial contents won't be used.
>
> Also, make crypto_blake2s_init() and blake2s() call a single internal
> function __blake2s_init() which treats the key as optional, rather than
> conditionally calling blake2s_init() or blake2s_init_key().  This
> reduces the compiled code size, as previously both blake2s_init() and
> blake2s_init_key() were being inlined into these two callers, except
> when the key size passed to blake2s() was a compile-time constant.
>
> These optimizations aren't that significant for BLAKE2s.  However, the
> equivalent optimizations will be more significant for BLAKE2b, as
> everything is twice as big in BLAKE2b.  And it's good to keep things
> consistent rather than making optimizations for BLAKE2b but not BLAKE2s.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  include/crypto/blake2s.h          | 53 ++++++++++++++++---------------
>  include/crypto/internal/blake2s.h |  5 +--
>  2 files changed, 28 insertions(+), 30 deletions(-)
>
> diff --git a/include/crypto/blake2s.h b/include/crypto/blake2s.h
> index b471deac28ff8..734ed22b7a6aa 100644
> --- a/include/crypto/blake2s.h
> +++ b/include/crypto/blake2s.h
> @@ -43,29 +43,34 @@ enum blake2s_iv {
>         BLAKE2S_IV7 = 0x5BE0CD19UL,
>  };
>
> -void blake2s_update(struct blake2s_state *state, const u8 *in, size_t inlen);
> -void blake2s_final(struct blake2s_state *state, u8 *out);
> -
> -static inline void blake2s_init_param(struct blake2s_state *state,
> -                                     const u32 param)
> +static inline void __blake2s_init(struct blake2s_state *state, size_t outlen,
> +                                 const void *key, size_t keylen)
>  {
> -       *state = (struct blake2s_state){{
> -               BLAKE2S_IV0 ^ param,
> -               BLAKE2S_IV1,
> -               BLAKE2S_IV2,
> -               BLAKE2S_IV3,
> -               BLAKE2S_IV4,
> -               BLAKE2S_IV5,
> -               BLAKE2S_IV6,
> -               BLAKE2S_IV7,
> -       }};
> +       state->h[0] = BLAKE2S_IV0 ^ (0x01010000 | keylen << 8 | outlen);
> +       state->h[1] = BLAKE2S_IV1;
> +       state->h[2] = BLAKE2S_IV2;
> +       state->h[3] = BLAKE2S_IV3;
> +       state->h[4] = BLAKE2S_IV4;
> +       state->h[5] = BLAKE2S_IV5;
> +       state->h[6] = BLAKE2S_IV6;
> +       state->h[7] = BLAKE2S_IV7;
> +       state->t[0] = 0;
> +       state->t[1] = 0;
> +       state->f[0] = 0;
> +       state->f[1] = 0;
> +       state->buflen = 0;
> +       state->outlen = outlen;
> +       if (keylen) {
> +               memcpy(state->buf, key, keylen);
> +               memset(&state->buf[keylen], 0, BLAKE2S_BLOCK_SIZE - keylen);
> +               state->buflen = BLAKE2S_BLOCK_SIZE;
> +       }
>  }
>
>  static inline void blake2s_init(struct blake2s_state *state,
>                                 const size_t outlen)
>  {
> -       blake2s_init_param(state, 0x01010000 | outlen);
> -       state->outlen = outlen;
> +       __blake2s_init(state, outlen, NULL, 0);
>  }
>
>  static inline void blake2s_init_key(struct blake2s_state *state,
> @@ -75,12 +80,12 @@ static inline void blake2s_init_key(struct blake2s_state *state,
>         WARN_ON(IS_ENABLED(DEBUG) && (!outlen || outlen > BLAKE2S_HASH_SIZE ||
>                 !key || !keylen || keylen > BLAKE2S_KEY_SIZE));
>
> -       blake2s_init_param(state, 0x01010000 | keylen << 8 | outlen);
> -       memcpy(state->buf, key, keylen);
> -       state->buflen = BLAKE2S_BLOCK_SIZE;
> -       state->outlen = outlen;
> +       __blake2s_init(state, outlen, key, keylen);
>  }
>
> +void blake2s_update(struct blake2s_state *state, const u8 *in, size_t inlen);
> +void blake2s_final(struct blake2s_state *state, u8 *out);
> +
>  static inline void blake2s(u8 *out, const u8 *in, const u8 *key,
>                            const size_t outlen, const size_t inlen,
>                            const size_t keylen)
> @@ -91,11 +96,7 @@ static inline void blake2s(u8 *out, const u8 *in, const u8 *key,
>                 outlen > BLAKE2S_HASH_SIZE || keylen > BLAKE2S_KEY_SIZE ||
>                 (!key && keylen)));
>
> -       if (keylen)
> -               blake2s_init_key(&state, outlen, key, keylen);
> -       else
> -               blake2s_init(&state, outlen);
> -
> +       __blake2s_init(&state, outlen, key, keylen);
>         blake2s_update(&state, in, inlen);
>         blake2s_final(&state, out);
>  }
> diff --git a/include/crypto/internal/blake2s.h b/include/crypto/internal/blake2s.h
> index 2ea0a8f5e7f41..867ef3753f5c1 100644
> --- a/include/crypto/internal/blake2s.h
> +++ b/include/crypto/internal/blake2s.h
> @@ -93,10 +93,7 @@ static inline int crypto_blake2s_init(struct shash_desc *desc)
>         struct blake2s_state *state = shash_desc_ctx(desc);
>         unsigned int outlen = crypto_shash_digestsize(desc->tfm);
>
> -       if (tctx->keylen)
> -               blake2s_init_key(state, outlen, tctx->key, tctx->keylen);
> -       else
> -               blake2s_init(state, outlen);
> +       __blake2s_init(state, outlen, tctx->key, tctx->keylen);
>         return 0;
>  }
>
> --
> 2.29.2
>

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCB285CED
	for <lists+linux-crypto@lfdr.de>; Thu,  8 Aug 2019 10:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731839AbfHHIdK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 8 Aug 2019 04:33:10 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:38888 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731592AbfHHIdK (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 8 Aug 2019 04:33:10 -0400
Received: by mail-wm1-f41.google.com with SMTP id s15so1519875wmj.3
        for <linux-crypto@vger.kernel.org>; Thu, 08 Aug 2019 01:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZwOjAixu53iXhu+MExgUcuWlE2oyVjoRxP9rOnuR8w4=;
        b=mGdB9ebEHmz0DnyaPGOJoDutXUs9RwmG1IyqDrVN7oCvHLOIpdin9Bjb/MdkgDS1LA
         YDD1uxVUQ1JkbF/bIgn2CJOLTaEgMOmR2Zid0vPZTZjT+O8eFqD3npBoTzo+4oA++IGT
         qnKGhjCgNNr7dpJ+uXLaCLK2ZmKX/ciqb2UILR/TdLuryti5xqX61xPFW2DR2GKslBZf
         xceEYFDGuD/DMw/v5byI6bUfAitrctArNM4dWmW/Cvx6kgEXJanPswmL/dUntGby7axD
         CeivBbTXQ2iwPGBFL64WAMDhf+3n7aRItSzMzxzXkajsa4f1YM2IBGuepU2fHrkkG73d
         Tp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZwOjAixu53iXhu+MExgUcuWlE2oyVjoRxP9rOnuR8w4=;
        b=btWdAZ+KrRjHzKVJlzltSOQVq5nDD3KQtk0FBhaJZIAbupzdySr+WEQdK4VSWgN+OV
         8n4H8f/+l0v5AHUMVvKCEa+oBBpAn1/1PtHQspkOnrXciugjmsZMrBmlHRdC//jmFMDH
         uzAmw4V5mCf8RQC1ABWVO9ztvZNJI3RMw3qEo9cfpTrUseGRAEgcdo5t23admkiUaMgt
         ILRogB0dqFI6MZsjHnafrv8Wi1lG1wQzZ+6hy9kiqgSfZbzIsw+6odyWwo/zmzj+XMyx
         oTos+rpFvT6Y+HPGprOuTCBwmz6Iy51RyMX56N76NB8cOXo6ljjWLUFzmvc//g5F54u5
         7Crw==
X-Gm-Message-State: APjAAAWqXJNsmQ779UN3cjyg8F8GK9Z7AZAWiKpl80+MzAhBrerZ5gKC
        WXgHbkBjq9TztXblT6I5RjgEPn8aFa+bhGeKUOMtqOfYA38=
X-Google-Smtp-Source: APXvYqzexKVvUxExLAUBjQnrntopqNzM8zM3jrGOQTUmViart2FMiJwFnrN3zGVrz+GykaXSX/c7YUWjqro4gMb7kgo=
X-Received: by 2002:a05:600c:21d4:: with SMTP id x20mr2663627wmj.61.1565253185836;
 Thu, 08 Aug 2019 01:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <1565245094-8584-1-git-send-email-pvanleeuwen@verimatrix.com>
 <CAKv+Gu_r+iF=gWk_sMesKSyxSZB5Z5pC6jNQmi8uf+0cY7K-6g@mail.gmail.com> <CH2PR20MB296824F38C44E32D8C82D0B8CAD70@CH2PR20MB2968.namprd20.prod.outlook.com>
In-Reply-To: <CH2PR20MB296824F38C44E32D8C82D0B8CAD70@CH2PR20MB2968.namprd20.prod.outlook.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 8 Aug 2019 11:32:52 +0300
Message-ID: <CAKv+Gu_uzt-cQF9ZPuM=4zot7UTogifWk3Pjr7Rcz1QWnqKaog@mail.gmail.com>
Subject: Re: [PATCHv2] crypto: xts - Add support for Cipher Text Stealing
To:     Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
Cc:     Pascal van Leeuwen <pascalvanl@gmail.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, 8 Aug 2019 at 11:18, Pascal Van Leeuwen
<pvanleeuwen@verimatrix.com> wrote:
>
> Ard,
>
> > -----Original Message-----
> > From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Sent: Thursday, August 8, 2019 9:45 AM
> > To: Pascal van Leeuwen <pascalvanl@gmail.com>
> > Cc: open list:HARDWARE RANDOM NUMBER GENERATOR CORE <linux-crypto@vger.kernel.org>;
> > Herbert Xu <herbert@gondor.apana.org.au>; David S. Miller <davem@davemloft.net>; Pascal
> > Van Leeuwen <pvanleeuwen@verimatrix.com>
> > Subject: Re: [PATCHv2] crypto: xts - Add support for Cipher Text Stealing
> >
> > Hello Pascal,
> >
> > Thanks for looking into this.
> >
> > On Thu, 8 Aug 2019 at 10:20, Pascal van Leeuwen <pascalvanl@gmail.com> wrote:
> > >
> > > This adds support for Cipher Text Stealing for data blocks that are not an
> > > integer multiple of the cipher block size in size, bringing it fully in
> > > line with the IEEE P1619/D16 standard.
> > >
> > > This has been tested with the AES-XTS test vectors from the IEEE P1619/D16
> > > specification as well as some additional test vectors supplied to the
> > > linux_crypto mailing list previously. It has also been fuzzed against
> > > Inside Secure AES-XTS hardware which has been actively used in the field
> > > for more than a decade already.
> > >
> > > changes since v1:
> > > - Fixed buffer overflow issue due to subreq not being the last entry in
> > >   rctx, this turns out to be a crypto API requirement. Thanks to Milan
> > >   Broz <gmazyland@gmail.com> for finding this and providing the solution.
> > > - Removed some redundant error returning code from the _finish_cts()
> > >   functions that currently cannot fail, therefore would always return 0.
> > > - removed rem_bytes computation behind init_crypt() in the encrypt() and
> > >   decrypt() functions, no need to compute for lengths < 16
> > > - Fixed comment style for single line comments
> > >
> >
> > Please put the changelog below the ---
> >
> Ok, I can resubmit with that fixed
>
> > > Signed-off-by: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
> > > ---
> > >  crypto/xts.c | 229 +++++++++++++++++++++++++++++++++++++++++++++++++++++------
> > >  1 file changed, 209 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/crypto/xts.c b/crypto/xts.c
> > > index 33cf726..17b551d 100644
> > > --- a/crypto/xts.c
> > > +++ b/crypto/xts.c
> > > @@ -1,7 +1,5 @@
> > >  /* XTS: as defined in IEEE1619/D16
> > >   *     http://grouper.ieee.org/groups/1619/email/pdf00086.pdf
> > > - *     (sector sizes which are not a multiple of 16 bytes are,
> > > - *     however currently unsupported)
> > >   *
> > >   * Copyright (c) 2007 Rik Snel <rsnel@cube.dyndns.org>
> > >   *
> > > @@ -28,6 +26,7 @@
> > >
> > >  struct priv {
> > >         struct crypto_skcipher *child;
> > > +       struct crypto_cipher *base;
> >
> > Why do you need a separate cipher for the ciphertext stealing? ECB can
> > be invoked with a single block just fine, and it will behave exactly
> > like the bare cipher.
> >
> As you already pointed out, it may be a different key from the tweak,
> and as I myself already explained I really do *not* want to use the
> skcipher which may be HW accelerated with terrible latency.
>

I think using the skcipher directly should be the default, regardless
of the latency, especially since you are doing a 'correctness first'
implementation.

In reality, I think very few users that care about performance would
opt for the XTS template wrapping a ecb(xx) implementation. In that
case, you are more likely to stick with something that your hardware
supports natively.

> I want some SW implementation that's fast on a single block here. And I
> can't call a library function directly as the underlying cipher can be
> anything (with a 128 bit blocksize).
>

True. Which is another historical mistake imo, since XTS is only
specified for AES, but I digress ... :-)

> Also, pushing it through the main skcipher was a bit more complexity
> than I could manage, not being a software engineer by profession.
> I leave the optimizations to people better equipped to do them :-)
>

It shouldn't be that complicated. It is simply a matter of setting up
the subrequest.


> > >         struct crypto_cipher *tweak;
> > >  };
> > >
> > > @@ -37,7 +36,9 @@ struct xts_instance_ctx {
> > >  };
> > >
> > >  struct rctx {
> > > -       le128 t;
> > > +       le128 t, tcur;
> > > +       int rem_bytes, is_encrypt;
> >
> > Instead of adding the is_encrypt flag, could we change crypt_done into
> > encrypt_done/decrypt_done?
> >
> That's possible, but what would be the advantage? Ok, it would save one
> conditional branch for the case where you do need CTS. But I doubt that
> is significant on the total CTS overhead. The implementation is far from
> optimal anyway, as the goal was to get something functional first ...
>

It is not about the conditional branch, but about having clean code.
Sharing code between the encrypt and decrypt paths only makes sense if
there is sufficient overlap, but given how simply crypt_done is, I'd
prefer to just have two versions.

> > > +       /* must be the last, expanded beyond end of struct! */
> > >         struct skcipher_request subreq;
> >
> > This is not sufficient. You have to add a TFM init() function which
> > sets the request size. Please look at the cts code for an example.
> >
> I believe that is already done correctly (then again I'm no expert).
> Note that I did *not* add the subreq, it was already there. I just
> added some more struct members that needed to be above, not below.
> I originally did not even know it could grow beyond its struct size.
>

Ah, my bad. I didn't look at the code itself, only at the patch and I
did not spot the init() function.

> > >  };
> > >
> > > @@ -47,6 +48,7 @@ static int setkey(struct crypto_skcipher *parent, const u8 *key,
> > >         struct priv *ctx = crypto_skcipher_ctx(parent);
> > >         struct crypto_skcipher *child;
> > >         struct crypto_cipher *tweak;
> > > +       struct crypto_cipher *base;
> > >         int err;
> > >
> > >         err = xts_verify_key(parent, key, keylen);
> > > @@ -55,9 +57,11 @@ static int setkey(struct crypto_skcipher *parent, const u8 *key,
> > >
> > >         keylen /= 2;
> > >
> > > -       /* we need two cipher instances: one to compute the initial 'tweak'
> > > -        * by encrypting the IV (usually the 'plain' iv) and the other
> > > -        * one to encrypt and decrypt the data */
> > > +       /* we need three cipher instances: one to compute the initial 'tweak'
> > > +        * by encrypting the IV (usually the 'plain' iv), one to encrypt and
> > > +        * decrypt the data and finally one to encrypt the last block(s) for
> > > +        * cipher text stealing
> > > +        */
> > >
> > >         /* tweak cipher, uses Key2 i.e. the second half of *key */
> > >         tweak = ctx->tweak;
> > > @@ -79,6 +83,13 @@ static int setkey(struct crypto_skcipher *parent, const u8 *key,
> > >         crypto_skcipher_set_flags(parent, crypto_skcipher_get_flags(child) &
> > >                                           CRYPTO_TFM_RES_MASK);
> > >
> > > +       /* Also data cipher, using Key1, for applying CTS */
> > > +       base = ctx->base;
> > > +       crypto_cipher_clear_flags(base, CRYPTO_TFM_REQ_MASK);
> > > +       crypto_cipher_set_flags(base, crypto_skcipher_get_flags(parent) &
> > > +                                     CRYPTO_TFM_REQ_MASK);
> > > +       err = crypto_cipher_setkey(base, key, keylen);
> > > +
> > >         return err;
> > >  }
> > >
> > > @@ -88,13 +99,12 @@ static int setkey(struct crypto_skcipher *parent, const u8 *key,
> > >   * mutliple calls to the 'ecb(..)' instance, which usually would be slower than
> > >   * just doing the gf128mul_x_ble() calls again.
> > >   */
> > > -static int xor_tweak(struct skcipher_request *req, bool second_pass)
> > > +static int xor_tweak(struct skcipher_request *req, bool second_pass, le128 *t)
> > >  {
> > >         struct rctx *rctx = skcipher_request_ctx(req);
> > >         struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
> > >         const int bs = XTS_BLOCK_SIZE;
> > >         struct skcipher_walk w;
> > > -       le128 t = rctx->t;
> > >         int err;
> > >
> > >         if (second_pass) {
> > > @@ -104,6 +114,7 @@ static int xor_tweak(struct skcipher_request *req, bool second_pass)
> > >         }
> > >         err = skcipher_walk_virt(&w, req, false);
> > >
> > > +       *t = rctx->t;
> > >         while (w.nbytes) {
> > >                 unsigned int avail = w.nbytes;
> > >                 le128 *wsrc;
> > > @@ -113,8 +124,8 @@ static int xor_tweak(struct skcipher_request *req, bool second_pass)
> > >                 wdst = w.dst.virt.addr;
> > >
> > >                 do {
> > > -                       le128_xor(wdst++, &t, wsrc++);
> > > -                       gf128mul_x_ble(&t, &t);
> > > +                       le128_xor(wdst++, t, wsrc++);
> > > +                       gf128mul_x_ble(t, t);
> > >                 } while ((avail -= bs) >= bs);
> > >
> > >                 err = skcipher_walk_done(&w, avail);
> > > @@ -123,14 +134,97 @@ static int xor_tweak(struct skcipher_request *req, bool
> > second_pass)
> > >         return err;
> > >  }
> > >
> > > -static int xor_tweak_pre(struct skcipher_request *req)
> > > +static int xor_tweak_pre(struct skcipher_request *req, le128 *t)
> > > +{
> > > +       return xor_tweak(req, false, t);
> > > +}
> > > +
> > > +static int xor_tweak_post(struct skcipher_request *req, le128 *t)
> > >  {
> > > -       return xor_tweak(req, false);
> > > +       return xor_tweak(req, true, t);
> > > +}
> > > +
> > > +static void encrypt_finish_cts(struct skcipher_request *req)
> > > +{
> > > +       struct rctx *rctx = skcipher_request_ctx(req);
> > > +       /* Not a multiple of cipher blocksize, need CTS applied */
> > > +       struct priv *ctx = crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
> > > +       le128 lastblock, lastptext;
> > > +
> > > +       /* Handle last partial block - apply Cipher Text Stealing */
> > > +
> > > +       /* Copy last ciphertext block just processed to buffer  */
> > > +       sg_pcopy_to_buffer(req->dst, sg_nents(req->dst), &lastblock,
> > > +                          XTS_BLOCK_SIZE,
> > > +                          req->cryptlen - XTS_BLOCK_SIZE);
> > > +       /* Save last plaintext bytes, next step may overwrite!! */
> > > +       sg_pcopy_to_buffer(req->src, sg_nents(req->src), &lastptext,
> > > +                          rctx->rem_bytes, req->cryptlen);
> > > +       /* Copy first rem_bytes of ciphertext behind last full block */
> > > +       sg_pcopy_from_buffer(req->dst, sg_nents(req->dst), &lastblock,
> > > +                            rctx->rem_bytes, req->cryptlen);
> > > +       /*
> > > +        * Copy last remaining bytes of plaintext to combine buffer,
> > > +        * replacing part of the ciphertext
> > > +        */
> > > +       memcpy(&lastblock, &lastptext, rctx->rem_bytes);
> > > +       /* XTS encrypt the combined block */
> > > +       le128_xor(&lastblock, &rctx->tcur, &lastblock);
> > > +       crypto_cipher_encrypt_one(ctx->base, (u8 *)&lastblock,
> > > +                                 (u8 *)&lastblock);
> > > +       le128_xor(&lastblock, &rctx->tcur, &lastblock);
> > > +       /* Write combined block to dst as 2nd last cipherblock */
> > > +       sg_pcopy_from_buffer(req->dst, sg_nents(req->dst), &lastblock,
> > > +                            XTS_BLOCK_SIZE,
> > > +                            req->cryptlen - XTS_BLOCK_SIZE);
> > > +
> > > +       /* Fix up original request length */
> > > +       req->cryptlen += rctx->rem_bytes;
> > > +       return;
> > >  }
> > >
> > > -static int xor_tweak_post(struct skcipher_request *req)
> > > +static void decrypt_finish_cts(struct skcipher_request *req)
> > >  {
> > > -       return xor_tweak(req, true);
> > > +       struct rctx *rctx = skcipher_request_ctx(req);
> > > +       /* Not a multiple of cipher blocksize, need CTS applied */
> > > +       struct priv *ctx = crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
> > > +       le128 tnext, lastblock, lastctext;
> > > +
> > > +       /* Handle last 2 (partial) blocks - apply Cipher Text Stealing */
> > > +
> > > +       /* Copy last full ciphertext block to buffer  */
> > > +       sg_pcopy_to_buffer(req->src, sg_nents(req->src), &lastblock,
> > > +                          XTS_BLOCK_SIZE, req->cryptlen);
> > > +       /* Decrypt last full block using *next* tweak */
> > > +       gf128mul_x_ble(&tnext, &rctx->tcur);
> > > +       le128_xor(&lastblock, &tnext, &lastblock);
> > > +       crypto_cipher_decrypt_one(ctx->base, (u8 *)&lastblock,
> > > +                                 (u8 *)&lastblock);
> > > +       le128_xor(&lastblock, &tnext, &lastblock);
> > > +       /* Save last ciphertext bytes, next step may overwrite!! */
> > > +       sg_pcopy_to_buffer(req->src, sg_nents(req->src), &lastctext,
> > > +                          rctx->rem_bytes, req->cryptlen + XTS_BLOCK_SIZE);
> > > +       /* Copy first rem_bytes of this ptext as last partial block */
> > > +       sg_pcopy_from_buffer(req->dst, sg_nents(req->dst), &lastblock,
> > > +                            rctx->rem_bytes,
> > > +                            req->cryptlen + XTS_BLOCK_SIZE);
> > > +       /*
> > > +        * Copy last remaining bytes of "plaintext" to combine buffer,
> > > +        * replacing part of the ciphertext
> > > +        */
> > > +       memcpy(&lastblock, &lastctext, rctx->rem_bytes);
> > > +       /* XTS decrypt the combined block */
> > > +       le128_xor(&lastblock, &rctx->tcur, &lastblock);
> > > +       crypto_cipher_decrypt_one(ctx->base, (u8 *)&lastblock,
> > > +                                 (u8 *)&lastblock);
> > > +       le128_xor(&lastblock, &rctx->tcur, &lastblock);
> > > +       /* Write combined block to dst as 2nd last plaintext block */
> > > +       sg_pcopy_from_buffer(req->dst, sg_nents(req->dst), &lastblock,
> > > +                            XTS_BLOCK_SIZE, req->cryptlen);
> > > +
> > > +       /* Fix up original request length */
> > > +       req->cryptlen += rctx->rem_bytes + XTS_BLOCK_SIZE;
> > > +       return;
> > >  }
> > >
> > >  static void crypt_done(struct crypto_async_request *areq, int err)
> > > @@ -139,9 +233,16 @@ static void crypt_done(struct crypto_async_request *areq, int err)
> > >
> > >         if (!err) {
> > >                 struct rctx *rctx = skcipher_request_ctx(req);
> > > +               le128 t;
> > >
> > >                 rctx->subreq.base.flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
> > > -               err = xor_tweak_post(req);
> > > +               err = xor_tweak_post(req, &t);
> > > +
> > > +               if (unlikely(!err && rctx->rem_bytes)) {
> > > +                       rctx->is_encrypt ?
> > > +                         encrypt_finish_cts(req) :
> > > +                         decrypt_finish_cts(req);
> > > +               }
> > >         }
> > >
> > >         skcipher_request_complete(req, err);
> > > @@ -167,10 +268,45 @@ static int encrypt(struct skcipher_request *req)
> > >         struct rctx *rctx = skcipher_request_ctx(req);
> > >         struct skcipher_request *subreq = &rctx->subreq;
> > >
> > > +       /* IEEE P1619 does not allow less data than block cipher blocksize */
> > > +       if (unlikely(req->cryptlen < XTS_BLOCK_SIZE))
> > > +               return -EINVAL;
> > > +
> > >         init_crypt(req);
> > > -       return xor_tweak_pre(req) ?:
> > > +
> > > +       /* valid bytes in last crypto block */
> > > +       rctx->rem_bytes = req->cryptlen & (XTS_BLOCK_SIZE - 1);
> > > +       if (unlikely(rctx->rem_bytes)) {
> > > +               /* Not a multiple of cipher blocksize, need CTS applied */
> > > +               int err = 0;
> > > +
> > > +               /* First process all *full* cipher blocks */
> > > +               req->cryptlen -= rctx->rem_bytes;
> > > +               subreq->cryptlen -= rctx->rem_bytes;
> > > +               err = xor_tweak_pre(req, &rctx->tcur);
> > > +               if (err)
> > > +                       goto encrypt_exit;
> > > +               rctx->is_encrypt = 1;
> > > +               err = crypto_skcipher_encrypt(subreq);
> > > +               if (err)
> > > +                       goto encrypt_exit;
> > > +               err = xor_tweak_post(req, &rctx->tcur);
> > > +               if (err)
> > > +                       goto encrypt_exit;
> > > +
> > > +               encrypt_finish_cts(req);
> > > +               return 0;
> > > +
> > > +encrypt_exit:
> > > +               /* Fix up original request length */
> > > +               req->cryptlen += rctx->rem_bytes;
> > > +               return err;
> > > +       }
> > > +
> > > +       /* Multiple of cipher blocksize, no CTS required */
> > > +       return xor_tweak_pre(req, &rctx->tcur) ?:
> > >                 crypto_skcipher_encrypt(subreq) ?:
> > > -               xor_tweak_post(req);
> > > +               xor_tweak_post(req, &rctx->tcur);
> > >  }
> > >
> > >  static int decrypt(struct skcipher_request *req)
> > > @@ -178,10 +314,50 @@ static int decrypt(struct skcipher_request *req)
> > >         struct rctx *rctx = skcipher_request_ctx(req);
> > >         struct skcipher_request *subreq = &rctx->subreq;
> > >
> > > +       /* IEEE P1619 does not allow less data than block cipher blocksize */
> > > +       if (unlikely(req->cryptlen < XTS_BLOCK_SIZE))
> > > +               return -EINVAL;
> > > +
> > >         init_crypt(req);
> > > -       return xor_tweak_pre(req) ?:
> > > +
> > > +       /* valid bytes in last crypto block */
> > > +       rctx->rem_bytes = req->cryptlen & (XTS_BLOCK_SIZE - 1);
> > > +       if (unlikely(rctx->rem_bytes)) {
> > > +               int err = 0;
> > > +
> > > +               /* First process all but the last(!) full cipher blocks */
> > > +               req->cryptlen -= rctx->rem_bytes + XTS_BLOCK_SIZE;
> > > +               subreq->cryptlen -= rctx->rem_bytes + XTS_BLOCK_SIZE;
> > > +               /* May not have any full blocks to process here */
> > > +               if (req->cryptlen) {
> > > +                       err = xor_tweak_pre(req, &rctx->tcur);
> > > +                       if (err)
> > > +                               goto decrypt_exit;
> > > +                       rctx->is_encrypt = 0;
> > > +                       err = crypto_skcipher_decrypt(subreq);
> > > +                       if (err)
> > > +                               goto decrypt_exit;
> > > +                       err = xor_tweak_post(req, &rctx->tcur);
> > > +                       if (err)
> > > +                               goto decrypt_exit;
> > > +               } else {
> > > +                       /* Start from initial tweak */
> > > +                       rctx->tcur = rctx->t;
> > > +               }
> > > +
> > > +               decrypt_finish_cts(req);
> > > +               return 0;
> > > +
> > > +decrypt_exit:
> > > +               /* Fix up original request length */
> > > +               req->cryptlen += rctx->rem_bytes + XTS_BLOCK_SIZE;
> > > +               return err;
> > > +       }
> > > +
> > > +       /* Multiple of cipher blocksize, no CTS required */
> > > +       return xor_tweak_pre(req, &rctx->tcur) ?:
> > >                 crypto_skcipher_decrypt(subreq) ?:
> > > -               xor_tweak_post(req);
> > > +               xor_tweak_post(req, &rctx->tcur);
> > >  }
> > >
> > >  static int init_tfm(struct crypto_skcipher *tfm)
> > > @@ -191,6 +367,7 @@ static int init_tfm(struct crypto_skcipher *tfm)
> > >         struct priv *ctx = crypto_skcipher_ctx(tfm);
> > >         struct crypto_skcipher *child;
> > >         struct crypto_cipher *tweak;
> > > +       struct crypto_cipher *base;
> > >
> > >         child = crypto_spawn_skcipher(&ictx->spawn);
> > >         if (IS_ERR(child))
> > > @@ -206,6 +383,16 @@ static int init_tfm(struct crypto_skcipher *tfm)
> > >
> > >         ctx->tweak = tweak;
> > >
> > > +       base = crypto_alloc_cipher(ictx->name, 0, 0);
> > > +       if (IS_ERR(base)) {
> > > +               crypto_free_skcipher(ctx->child);
> > > +               crypto_free_cipher(ctx->tweak);
> > > +               return PTR_ERR(base);
> > > +       }
> > > +
> > > +       ctx->base = base;
> > > +
> > > +       /* struct rctx expanded by sub cipher request size! */
> > >         crypto_skcipher_set_reqsize(tfm, crypto_skcipher_reqsize(child) +
> > >                                          sizeof(struct rctx));
> > >
> > > @@ -218,6 +405,7 @@ static void exit_tfm(struct crypto_skcipher *tfm)
> > >
> > >         crypto_free_skcipher(ctx->child);
> > >         crypto_free_cipher(ctx->tweak);
> > > +       crypto_free_cipher(ctx->base);
> > >  }
> > >
> > >  static void free(struct skcipher_instance *inst)
> > > @@ -314,11 +502,12 @@ static int create(struct crypto_template *tmpl, struct rtattr
> > **tb)
> > >
> > >         inst->alg.base.cra_flags = alg->base.cra_flags & CRYPTO_ALG_ASYNC;
> > >         inst->alg.base.cra_priority = alg->base.cra_priority;
> > > -       inst->alg.base.cra_blocksize = XTS_BLOCK_SIZE;
> > > +       inst->alg.base.cra_blocksize = 1;
> >
> > I don't think this is necessary or correct.
> >
> > >         inst->alg.base.cra_alignmask = alg->base.cra_alignmask |
> > >                                        (__alignof__(u64) - 1);
> > >
> > >         inst->alg.ivsize = XTS_BLOCK_SIZE;
> > > +       inst->alg.chunksize = XTS_BLOCK_SIZE;
> >
> > ... and you don't need this if you drop the above change.
> >

Any comments here?


> > >         inst->alg.min_keysize = crypto_skcipher_alg_min_keysize(alg) * 2;
> > >         inst->alg.max_keysize = crypto_skcipher_alg_max_keysize(alg) * 2;
> > >
> > > --
> > > 1.8.3.1
>
> Regards,
> Pascal van Leeuwen
> Silicon IP Architect, Multi-Protocol Engines @ Verimatrix
> www.insidesecure.com
>

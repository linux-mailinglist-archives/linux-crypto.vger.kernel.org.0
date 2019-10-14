Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 109CCD62C6
	for <lists+linux-crypto@lfdr.de>; Mon, 14 Oct 2019 14:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbfJNMkF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 14 Oct 2019 08:40:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37230 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730733AbfJNMkF (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 14 Oct 2019 08:40:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id p14so19551674wro.4
        for <linux-crypto@vger.kernel.org>; Mon, 14 Oct 2019 05:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qxqhJoxdjh4AjpluVAjMFm9F70n5PQ7T2iO5hHpE/DE=;
        b=TNJAb3RID6birb4/E8PqVYHep/YLbHvjcZiS+7oHfW6VC5Q50CrFEFfA0Wt6JRa1T/
         DNPV9fen98GNAbDsutGI+7AOEilah8rwOI5s8u53B6dUgK7O1bUMnUcNcboPZas/f58h
         zHRZ+K6g8ZK9FFa62Lam+FM9Xtb4CInNT8KJSOU9JZ9JsvMkbaGLIm/zsjZQF9yc/rVn
         POGt8psb5TweCS/YWGiZyLxXq3usd8EFZrvihr1NcbCX9i/kpMQ8JgQ1IEPV3qD8y8eU
         U0h15962nMyHYL8ukiv5ebk3QdWexUGSzuIVuiXQbH0IcQYncLTvqYRol890/GTsqOT4
         eHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qxqhJoxdjh4AjpluVAjMFm9F70n5PQ7T2iO5hHpE/DE=;
        b=K5xK0pYDfSxpfcof3hZnnaiFSJbH1388PglfcXzN8ekg98DSLPRbCjkJi4e/kyNff5
         ykA/8ucpxFGsB/i2h1c/+128iG0EHWPKdtC/Qz/jEHyEXo4d53vhPcm/lnB06WZl663K
         cJfnJsV83htMVxajAXDzriqp8YqMf46fnXzCCmoVK20/GCLA0XSZyxj/BXCvGho+1A1D
         0hGGhFeVaR36UBqv0oVDaZsd35YsSmr5jQe0A+Xvy02Egn6E7ubSj4ucAc1Nbh4KMZTy
         ZW6af93/yC+OiP5SMMcnCgkPs3Vcic4J+1WBoCtWOyH3Yq/R0dAuqJoL1QiidV6aavjF
         +c4g==
X-Gm-Message-State: APjAAAWfldrFiXswd3hr84Z8fPlgb/FFKiNxj93m9Yi2MDiDAZpGZwCy
        1XT0QGpD/c+vHnh9urulPEdxcv2WdMP8oY34U5uaJA==
X-Google-Smtp-Source: APXvYqz+/5TKtAubqflHrCtpjVt6Ttqec5j3CXxIXUn/20bViZw6XvcN1sHkcufMrUDHoO9UJvXZIa8GM5ilhKzm4MU=
X-Received: by 2002:a5d:6b0a:: with SMTP id v10mr24158026wrw.32.1571056801154;
 Mon, 14 Oct 2019 05:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191013043918.337113-1-ebiggers@kernel.org> <20191013043918.337113-5-ebiggers@kernel.org>
In-Reply-To: <20191013043918.337113-5-ebiggers@kernel.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 14 Oct 2019 14:39:50 +0200
Message-ID: <CAKv+Gu8AmyQHa=ficw3h1UWup2S3uU6G4=U8joD6nZF1fEoisw@mail.gmail.com>
Subject: Re: [PATCH 4/4] crypto: nx - convert AES-CTR to skcipher API
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        =?UTF-8?Q?Breno_Leit=C3=A3o?= <leitao@debian.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paulo Flabiano Smorigo <pfsmorigo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, 13 Oct 2019 at 06:40, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Convert the PowerPC Nest (NX) implementation of AES-CTR from the
> deprecated "blkcipher" API to the "skcipher" API.  This is needed in
> order for the blkcipher API to be removed.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  drivers/crypto/nx/nx-aes-ctr.c | 84 +++++++++++++++-------------------
>  drivers/crypto/nx/nx.c         | 25 +++-------
>  drivers/crypto/nx/nx.h         |  4 +-
>  3 files changed, 46 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/crypto/nx/nx-aes-ctr.c b/drivers/crypto/nx/nx-aes-ctr.c
> index 05e558cefe94..6d5ce1a66f1e 100644
> --- a/drivers/crypto/nx/nx-aes-ctr.c
> +++ b/drivers/crypto/nx/nx-aes-ctr.c
> @@ -19,11 +19,11 @@
>  #include "nx.h"
>
>
> -static int ctr_aes_nx_set_key(struct crypto_tfm *tfm,
> -                             const u8          *in_key,
> -                             unsigned int       key_len)
> +static int ctr_aes_nx_set_key(struct crypto_skcipher *tfm,
> +                             const u8               *in_key,
> +                             unsigned int            key_len)
>  {
> -       struct nx_crypto_ctx *nx_ctx = crypto_tfm_ctx(tfm);
> +       struct nx_crypto_ctx *nx_ctx = crypto_skcipher_ctx(tfm);
>         struct nx_csbcpb *csbcpb = nx_ctx->csbcpb;
>
>         nx_ctx_init(nx_ctx, HCOP_FC_AES);
> @@ -51,11 +51,11 @@ static int ctr_aes_nx_set_key(struct crypto_tfm *tfm,
>         return 0;
>  }
>
> -static int ctr3686_aes_nx_set_key(struct crypto_tfm *tfm,
> -                                 const u8          *in_key,
> -                                 unsigned int       key_len)
> +static int ctr3686_aes_nx_set_key(struct crypto_skcipher *tfm,
> +                                 const u8               *in_key,
> +                                 unsigned int            key_len)
>  {
> -       struct nx_crypto_ctx *nx_ctx = crypto_tfm_ctx(tfm);
> +       struct nx_crypto_ctx *nx_ctx = crypto_skcipher_ctx(tfm);
>
>         if (key_len < CTR_RFC3686_NONCE_SIZE)
>                 return -EINVAL;
> @@ -69,12 +69,10 @@ static int ctr3686_aes_nx_set_key(struct crypto_tfm *tfm,
>         return ctr_aes_nx_set_key(tfm, in_key, key_len);
>  }
>
> -static int ctr_aes_nx_crypt(struct blkcipher_desc *desc,
> -                           struct scatterlist    *dst,
> -                           struct scatterlist    *src,
> -                           unsigned int           nbytes)
> +static int ctr_aes_nx_crypt(struct skcipher_request *req, u8 *iv)
>  {
> -       struct nx_crypto_ctx *nx_ctx = crypto_blkcipher_ctx(desc->tfm);
> +       struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
> +       struct nx_crypto_ctx *nx_ctx = crypto_skcipher_ctx(tfm);
>         struct nx_csbcpb *csbcpb = nx_ctx->csbcpb;
>         unsigned long irq_flags;
>         unsigned int processed = 0, to_process;
> @@ -83,9 +81,9 @@ static int ctr_aes_nx_crypt(struct blkcipher_desc *desc,
>         spin_lock_irqsave(&nx_ctx->lock, irq_flags);
>
>         do {
> -               to_process = nbytes - processed;
> +               to_process = req->cryptlen - processed;
>
> -               rc = nx_build_sg_lists(nx_ctx, desc->info, dst, src,
> +               rc = nx_build_sg_lists(nx_ctx, iv, req->dst, req->src,
>                                        &to_process, processed,
>                                        csbcpb->cpb.aes_ctr.iv);
>                 if (rc)
> @@ -97,59 +95,51 @@ static int ctr_aes_nx_crypt(struct blkcipher_desc *desc,
>                 }
>
>                 rc = nx_hcall_sync(nx_ctx, &nx_ctx->op,
> -                                  desc->flags & CRYPTO_TFM_REQ_MAY_SLEEP);
> +                                  req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP);
>                 if (rc)
>                         goto out;
>
> -               memcpy(desc->info, csbcpb->cpb.aes_cbc.cv, AES_BLOCK_SIZE);
> +               memcpy(iv, csbcpb->cpb.aes_cbc.cv, AES_BLOCK_SIZE);
>
>                 atomic_inc(&(nx_ctx->stats->aes_ops));
>                 atomic64_add(csbcpb->csb.processed_byte_count,
>                              &(nx_ctx->stats->aes_bytes));
>
>                 processed += to_process;
> -       } while (processed < nbytes);
> +       } while (processed < req->cryptlen);
>  out:
>         spin_unlock_irqrestore(&nx_ctx->lock, irq_flags);
>         return rc;
>  }
>
> -static int ctr3686_aes_nx_crypt(struct blkcipher_desc *desc,
> -                               struct scatterlist    *dst,
> -                               struct scatterlist    *src,
> -                               unsigned int           nbytes)
> +static int ctr3686_aes_nx_crypt(struct skcipher_request *req)
>  {
> -       struct nx_crypto_ctx *nx_ctx = crypto_blkcipher_ctx(desc->tfm);
> +       struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
> +       struct nx_crypto_ctx *nx_ctx = crypto_skcipher_ctx(tfm);
>         u8 iv[16];
>
>         memcpy(iv, nx_ctx->priv.ctr.nonce, CTR_RFC3686_IV_SIZE);
> -       memcpy(iv + CTR_RFC3686_NONCE_SIZE,
> -              desc->info, CTR_RFC3686_IV_SIZE);
> +       memcpy(iv + CTR_RFC3686_NONCE_SIZE, req->iv, CTR_RFC3686_IV_SIZE);
>         iv[12] = iv[13] = iv[14] = 0;
>         iv[15] = 1;
>
> -       desc->info = iv;
> -
> -       return ctr_aes_nx_crypt(desc, dst, src, nbytes);
> +       return ctr_aes_nx_crypt(req, iv);
>  }
>
> -struct crypto_alg nx_ctr3686_aes_alg = {
> -       .cra_name        = "rfc3686(ctr(aes))",
> -       .cra_driver_name = "rfc3686-ctr-aes-nx",
> -       .cra_priority    = 300,
> -       .cra_flags       = CRYPTO_ALG_TYPE_BLKCIPHER,
> -       .cra_blocksize   = 1,
> -       .cra_ctxsize     = sizeof(struct nx_crypto_ctx),
> -       .cra_type        = &crypto_blkcipher_type,
> -       .cra_module      = THIS_MODULE,
> -       .cra_init        = nx_crypto_ctx_aes_ctr_init,
> -       .cra_exit        = nx_crypto_ctx_exit,
> -       .cra_blkcipher = {
> -               .min_keysize = AES_MIN_KEY_SIZE + CTR_RFC3686_NONCE_SIZE,
> -               .max_keysize = AES_MAX_KEY_SIZE + CTR_RFC3686_NONCE_SIZE,
> -               .ivsize      = CTR_RFC3686_IV_SIZE,
> -               .setkey      = ctr3686_aes_nx_set_key,
> -               .encrypt     = ctr3686_aes_nx_crypt,
> -               .decrypt     = ctr3686_aes_nx_crypt,
> -       }
> +struct skcipher_alg nx_ctr3686_aes_alg = {
> +       .base.cra_name          = "rfc3686(ctr(aes))",
> +       .base.cra_driver_name   = "rfc3686-ctr-aes-nx",
> +       .base.cra_priority      = 300,
> +       .base.cra_blocksize     = 1,
> +       .base.cra_ctxsize       = sizeof(struct nx_crypto_ctx),
> +       .base.cra_module        = THIS_MODULE,
> +       .init                   = nx_crypto_ctx_aes_ctr_init,
> +       .exit                   = nx_crypto_ctx_skcipher_exit,
> +       .min_keysize            = AES_MIN_KEY_SIZE + CTR_RFC3686_NONCE_SIZE,
> +       .max_keysize            = AES_MAX_KEY_SIZE + CTR_RFC3686_NONCE_SIZE,
> +       .ivsize                 = CTR_RFC3686_IV_SIZE,
> +       .setkey                 = ctr3686_aes_nx_set_key,
> +       .encrypt                = ctr3686_aes_nx_crypt,
> +       .decrypt                = ctr3686_aes_nx_crypt,
> +       .chunksize              = AES_BLOCK_SIZE,
>  };
> diff --git a/drivers/crypto/nx/nx.c b/drivers/crypto/nx/nx.c
> index 8e5367776ca0..f03c238f5a31 100644
> --- a/drivers/crypto/nx/nx.c
> +++ b/drivers/crypto/nx/nx.c
> @@ -511,12 +511,6 @@ static bool nx_check_props(struct device *dev, u32 fc, u32 mode)
>         return true;
>  }
>
> -static int nx_register_alg(struct crypto_alg *alg, u32 fc, u32 mode)
> -{
> -       return nx_check_props(&nx_driver.viodev->dev, fc, mode) ?
> -              crypto_register_alg(alg) : 0;
> -}
> -
>  static int nx_register_skcipher(struct skcipher_alg *alg, u32 fc, u32 mode)
>  {
>         return nx_check_props(&nx_driver.viodev->dev, fc, mode) ?
> @@ -537,12 +531,6 @@ static int nx_register_shash(struct shash_alg *alg, u32 fc, u32 mode, int slot)
>                crypto_register_shash(alg) : 0;
>  }
>
> -static void nx_unregister_alg(struct crypto_alg *alg, u32 fc, u32 mode)
> -{
> -       if (nx_check_props(NULL, fc, mode))
> -               crypto_unregister_alg(alg);
> -}
> -
>  static void nx_unregister_skcipher(struct skcipher_alg *alg, u32 fc, u32 mode)
>  {
>         if (nx_check_props(NULL, fc, mode))
> @@ -593,7 +581,8 @@ static int nx_register_algs(void)
>         if (rc)
>                 goto out_unreg_ecb;
>
> -       rc = nx_register_alg(&nx_ctr3686_aes_alg, NX_FC_AES, NX_MODE_AES_CTR);
> +       rc = nx_register_skcipher(&nx_ctr3686_aes_alg, NX_FC_AES,
> +                                 NX_MODE_AES_CTR);
>         if (rc)
>                 goto out_unreg_cbc;
>
> @@ -645,7 +634,7 @@ static int nx_register_algs(void)
>  out_unreg_gcm:
>         nx_unregister_aead(&nx_gcm_aes_alg, NX_FC_AES, NX_MODE_AES_GCM);
>  out_unreg_ctr3686:
> -       nx_unregister_alg(&nx_ctr3686_aes_alg, NX_FC_AES, NX_MODE_AES_CTR);
> +       nx_unregister_skcipher(&nx_ctr3686_aes_alg, NX_FC_AES, NX_MODE_AES_CTR);
>  out_unreg_cbc:
>         nx_unregister_skcipher(&nx_cbc_aes_alg, NX_FC_AES, NX_MODE_AES_CBC);
>  out_unreg_ecb:
> @@ -716,9 +705,9 @@ int nx_crypto_ctx_aes_gcm_init(struct crypto_aead *tfm)
>                                   NX_MODE_AES_GCM);
>  }
>
> -int nx_crypto_ctx_aes_ctr_init(struct crypto_tfm *tfm)
> +int nx_crypto_ctx_aes_ctr_init(struct crypto_skcipher *tfm)
>  {
> -       return nx_crypto_ctx_init(crypto_tfm_ctx(tfm), NX_FC_AES,
> +       return nx_crypto_ctx_init(crypto_skcipher_ctx(tfm), NX_FC_AES,
>                                   NX_MODE_AES_CTR);
>  }
>
> @@ -815,8 +804,8 @@ static int nx_remove(struct vio_dev *viodev)
>                                    NX_FC_AES, NX_MODE_AES_GCM);
>                 nx_unregister_aead(&nx_gcm_aes_alg,
>                                    NX_FC_AES, NX_MODE_AES_GCM);
> -               nx_unregister_alg(&nx_ctr3686_aes_alg,
> -                                 NX_FC_AES, NX_MODE_AES_CTR);
> +               nx_unregister_skcipher(&nx_ctr3686_aes_alg,
> +                                      NX_FC_AES, NX_MODE_AES_CTR);
>                 nx_unregister_skcipher(&nx_cbc_aes_alg, NX_FC_AES,
>                                        NX_MODE_AES_CBC);
>                 nx_unregister_skcipher(&nx_ecb_aes_alg, NX_FC_AES,
> diff --git a/drivers/crypto/nx/nx.h b/drivers/crypto/nx/nx.h
> index 2e1a3e5e65cb..91c54289124a 100644
> --- a/drivers/crypto/nx/nx.h
> +++ b/drivers/crypto/nx/nx.h
> @@ -145,7 +145,7 @@ struct crypto_aead;
>  int nx_crypto_ctx_aes_ccm_init(struct crypto_aead *tfm);
>  int nx_crypto_ctx_aes_gcm_init(struct crypto_aead *tfm);
>  int nx_crypto_ctx_aes_xcbc_init(struct crypto_tfm *tfm);
> -int nx_crypto_ctx_aes_ctr_init(struct crypto_tfm *tfm);
> +int nx_crypto_ctx_aes_ctr_init(struct crypto_skcipher *tfm);
>  int nx_crypto_ctx_aes_cbc_init(struct crypto_skcipher *tfm);
>  int nx_crypto_ctx_aes_ecb_init(struct crypto_skcipher *tfm);
>  int nx_crypto_ctx_sha_init(struct crypto_tfm *tfm);
> @@ -180,7 +180,7 @@ extern struct skcipher_alg nx_cbc_aes_alg;
>  extern struct skcipher_alg nx_ecb_aes_alg;
>  extern struct aead_alg nx_gcm_aes_alg;
>  extern struct aead_alg nx_gcm4106_aes_alg;
> -extern struct crypto_alg nx_ctr3686_aes_alg;
> +extern struct skcipher_alg nx_ctr3686_aes_alg;
>  extern struct aead_alg nx_ccm_aes_alg;
>  extern struct aead_alg nx_ccm4309_aes_alg;
>  extern struct shash_alg nx_shash_aes_xcbc_alg;
> --
> 2.23.0
>

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1A4321118
	for <lists+linux-crypto@lfdr.de>; Fri, 17 May 2019 01:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfEPXpR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 May 2019 19:45:17 -0400
Received: from ozlabs.org ([203.11.71.1]:56185 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfEPXpR (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 May 2019 19:45:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 454p214BXJz9s7h;
        Fri, 17 May 2019 09:45:13 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Daniel Axtens <dja@axtens.net>, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     marcelo.cerri@canonical.com, Stephan Mueller <smueller@chronox.de>,
        leo.barbosa@canonical.com, linuxppc-dev@lists.ozlabs.org,
        nayna@linux.ibm.com, pfsmorigo@gmail.com, leitao@debian.org,
        gcwilson@linux.ibm.com, omosnacek@gmail.com
Subject: Re: [PATCH] crypto: vmx - ghash: do nosimd fallback manually
In-Reply-To: <20190516154002.26246-1-dja@axtens.net>
References: <20190516154002.26246-1-dja@axtens.net>
Date:   Fri, 17 May 2019 09:45:11 +1000
Message-ID: <87bm02hsl4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Daniel Axtens <dja@axtens.net> writes:
> VMX ghash was using a fallback that did not support interleaving simd
> and nosimd operations, leading to failures in the extended test suite.
>
> If I understood correctly, Eric's suggestion was to use the same
> data format that the generic code uses, allowing us to call into it
> with the same contexts. I wasn't able to get that to work - I think
> there's a very different key structure and data layout being used.
>
> So instead steal the arm64 approach and perform the fallback
> operations directly if required.
>
> Reported-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

This probably needs a fixes tag?

I assume it goes back to the original submission, ie.

  Fixes: cc333cd68dfa ("crypto: vmx - Adding GHASH routines for VMX module")
  Cc: stable@vger.kernel.org # v4.1+

Or did something change in the interim to expose this?


> ---
>
> Tested on BE and LE in qemu-tcg, so more testing would be lovely.

I tested this on power8 with fuzz_iterations=10000, no problems.
Previously it would fail very quickly.

Tested-by: Michael Ellerman <mpe@ellerman.id.au>


cheers


> diff --git a/drivers/crypto/vmx/ghash.c b/drivers/crypto/vmx/ghash.c
> index b5a6883bb09e..14807ac2e3b9 100644
> --- a/drivers/crypto/vmx/ghash.c
> +++ b/drivers/crypto/vmx/ghash.c
> @@ -1,22 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /**
>   * GHASH routines supporting VMX instructions on the Power 8
>   *
> - * Copyright (C) 2015 International Business Machines Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; version 2 only.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + * Copyright (C) 2015, 2019 International Business Machines Inc.
>   *
>   * Author: Marcelo Henrique Cerri <mhcerri@br.ibm.com>
> + *
> + * Extended by Daniel Axtens <dja@axtens.net> to replace the fallback
> + * mechanism. The new approach is based on arm64 code, which is:
> + *   Copyright (C) 2014 - 2018 Linaro Ltd. <ard.biesheuvel@linaro.org>
>   */
>  
>  #include <linux/types.h>
> @@ -38,70 +30,25 @@ void gcm_ghash_p8(u64 Xi[2], const u128 htable[16],
>  		  const u8 *in, size_t len);
>  
>  struct p8_ghash_ctx {
> +	/* key used by vector asm */
>  	u128 htable[16];
> -	struct crypto_shash *fallback;
> +	/* key used by software fallback */
> +	be128 key;
>  };
>  
>  struct p8_ghash_desc_ctx {
>  	u64 shash[2];
>  	u8 buffer[GHASH_DIGEST_SIZE];
>  	int bytes;
> -	struct shash_desc fallback_desc;
>  };
>  
> -static int p8_ghash_init_tfm(struct crypto_tfm *tfm)
> -{
> -	const char *alg = "ghash-generic";
> -	struct crypto_shash *fallback;
> -	struct crypto_shash *shash_tfm = __crypto_shash_cast(tfm);
> -	struct p8_ghash_ctx *ctx = crypto_tfm_ctx(tfm);
> -
> -	fallback = crypto_alloc_shash(alg, 0, CRYPTO_ALG_NEED_FALLBACK);
> -	if (IS_ERR(fallback)) {
> -		printk(KERN_ERR
> -		       "Failed to allocate transformation for '%s': %ld\n",
> -		       alg, PTR_ERR(fallback));
> -		return PTR_ERR(fallback);
> -	}
> -
> -	crypto_shash_set_flags(fallback,
> -			       crypto_shash_get_flags((struct crypto_shash
> -						       *) tfm));
> -
> -	/* Check if the descsize defined in the algorithm is still enough. */
> -	if (shash_tfm->descsize < sizeof(struct p8_ghash_desc_ctx)
> -	    + crypto_shash_descsize(fallback)) {
> -		printk(KERN_ERR
> -		       "Desc size of the fallback implementation (%s) does not match the expected value: %lu vs %u\n",
> -		       alg,
> -		       shash_tfm->descsize - sizeof(struct p8_ghash_desc_ctx),
> -		       crypto_shash_descsize(fallback));
> -		return -EINVAL;
> -	}
> -	ctx->fallback = fallback;
> -
> -	return 0;
> -}
> -
> -static void p8_ghash_exit_tfm(struct crypto_tfm *tfm)
> -{
> -	struct p8_ghash_ctx *ctx = crypto_tfm_ctx(tfm);
> -
> -	if (ctx->fallback) {
> -		crypto_free_shash(ctx->fallback);
> -		ctx->fallback = NULL;
> -	}
> -}
> -
>  static int p8_ghash_init(struct shash_desc *desc)
>  {
> -	struct p8_ghash_ctx *ctx = crypto_tfm_ctx(crypto_shash_tfm(desc->tfm));
>  	struct p8_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
>  
>  	dctx->bytes = 0;
>  	memset(dctx->shash, 0, GHASH_DIGEST_SIZE);
> -	dctx->fallback_desc.tfm = ctx->fallback;
> -	return crypto_shash_init(&dctx->fallback_desc);
> +	return 0;
>  }
>  
>  static int p8_ghash_setkey(struct crypto_shash *tfm, const u8 *key,
> @@ -119,7 +66,51 @@ static int p8_ghash_setkey(struct crypto_shash *tfm, const u8 *key,
>  	disable_kernel_vsx();
>  	pagefault_enable();
>  	preempt_enable();
> -	return crypto_shash_setkey(ctx->fallback, key, keylen);
> +
> +	memcpy(&ctx->key, key, GHASH_BLOCK_SIZE);
> +
> +	return 0;
> +}
> +
> +static inline void __ghash_block(struct p8_ghash_ctx *ctx,
> +				 struct p8_ghash_desc_ctx *dctx)
> +{
> +	if (crypto_simd_usable()) {
> +		preempt_disable();
> +		pagefault_disable();
> +		enable_kernel_vsx();
> +		gcm_ghash_p8(dctx->shash, ctx->htable,
> +				dctx->buffer, GHASH_DIGEST_SIZE);
> +		disable_kernel_vsx();
> +		pagefault_enable();
> +		preempt_enable();
> +	} else {
> +		crypto_xor((u8 *)dctx->shash, dctx->buffer, GHASH_BLOCK_SIZE);
> +		gf128mul_lle((be128 *)dctx->shash, &ctx->key);
> +	}
> +}
> +
> +static inline void __ghash_blocks(struct p8_ghash_ctx *ctx,
> +				  struct p8_ghash_desc_ctx *dctx,
> +				  const u8 *src, unsigned int srclen)
> +{
> +	if (crypto_simd_usable()) {
> +		preempt_disable();
> +		pagefault_disable();
> +		enable_kernel_vsx();
> +		gcm_ghash_p8(dctx->shash, ctx->htable,
> +				src, srclen);
> +		disable_kernel_vsx();
> +		pagefault_enable();
> +		preempt_enable();
> +	} else {
> +		while (srclen >= GHASH_BLOCK_SIZE) {
> +			crypto_xor((u8 *)dctx->shash, src, GHASH_BLOCK_SIZE);
> +			gf128mul_lle((be128 *)dctx->shash, &ctx->key);
> +			srclen -= GHASH_BLOCK_SIZE;
> +			src += GHASH_BLOCK_SIZE;
> +		}
> +	}
>  }
>  
>  static int p8_ghash_update(struct shash_desc *desc,
> @@ -129,49 +120,33 @@ static int p8_ghash_update(struct shash_desc *desc,
>  	struct p8_ghash_ctx *ctx = crypto_tfm_ctx(crypto_shash_tfm(desc->tfm));
>  	struct p8_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
>  
> -	if (!crypto_simd_usable()) {
> -		return crypto_shash_update(&dctx->fallback_desc, src,
> -					   srclen);
> -	} else {
> -		if (dctx->bytes) {
> -			if (dctx->bytes + srclen < GHASH_DIGEST_SIZE) {
> -				memcpy(dctx->buffer + dctx->bytes, src,
> -				       srclen);
> -				dctx->bytes += srclen;
> -				return 0;
> -			}
> +	if (dctx->bytes) {
> +		if (dctx->bytes + srclen < GHASH_DIGEST_SIZE) {
>  			memcpy(dctx->buffer + dctx->bytes, src,
> -			       GHASH_DIGEST_SIZE - dctx->bytes);
> -			preempt_disable();
> -			pagefault_disable();
> -			enable_kernel_vsx();
> -			gcm_ghash_p8(dctx->shash, ctx->htable,
> -				     dctx->buffer, GHASH_DIGEST_SIZE);
> -			disable_kernel_vsx();
> -			pagefault_enable();
> -			preempt_enable();
> -			src += GHASH_DIGEST_SIZE - dctx->bytes;
> -			srclen -= GHASH_DIGEST_SIZE - dctx->bytes;
> -			dctx->bytes = 0;
> -		}
> -		len = srclen & ~(GHASH_DIGEST_SIZE - 1);
> -		if (len) {
> -			preempt_disable();
> -			pagefault_disable();
> -			enable_kernel_vsx();
> -			gcm_ghash_p8(dctx->shash, ctx->htable, src, len);
> -			disable_kernel_vsx();
> -			pagefault_enable();
> -			preempt_enable();
> -			src += len;
> -			srclen -= len;
> -		}
> -		if (srclen) {
> -			memcpy(dctx->buffer, src, srclen);
> -			dctx->bytes = srclen;
> +				srclen);
> +			dctx->bytes += srclen;
> +			return 0;
>  		}
> -		return 0;
> +		memcpy(dctx->buffer + dctx->bytes, src,
> +			GHASH_DIGEST_SIZE - dctx->bytes);
> +
> +		__ghash_block(ctx, dctx);
> +
> +		src += GHASH_DIGEST_SIZE - dctx->bytes;
> +		srclen -= GHASH_DIGEST_SIZE - dctx->bytes;
> +		dctx->bytes = 0;
> +	}
> +	len = srclen & ~(GHASH_DIGEST_SIZE - 1);
> +	if (len) {
> +		__ghash_blocks(ctx, dctx, src, len);
> +		src += len;
> +		srclen -= len;
>  	}
> +	if (srclen) {
> +		memcpy(dctx->buffer, src, srclen);
> +		dctx->bytes = srclen;
> +	}
> +	return 0;
>  }
>  
>  static int p8_ghash_final(struct shash_desc *desc, u8 *out)
> @@ -180,25 +155,14 @@ static int p8_ghash_final(struct shash_desc *desc, u8 *out)
>  	struct p8_ghash_ctx *ctx = crypto_tfm_ctx(crypto_shash_tfm(desc->tfm));
>  	struct p8_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
>  
> -	if (!crypto_simd_usable()) {
> -		return crypto_shash_final(&dctx->fallback_desc, out);
> -	} else {
> -		if (dctx->bytes) {
> -			for (i = dctx->bytes; i < GHASH_DIGEST_SIZE; i++)
> -				dctx->buffer[i] = 0;
> -			preempt_disable();
> -			pagefault_disable();
> -			enable_kernel_vsx();
> -			gcm_ghash_p8(dctx->shash, ctx->htable,
> -				     dctx->buffer, GHASH_DIGEST_SIZE);
> -			disable_kernel_vsx();
> -			pagefault_enable();
> -			preempt_enable();
> -			dctx->bytes = 0;
> -		}
> -		memcpy(out, dctx->shash, GHASH_DIGEST_SIZE);
> -		return 0;
> +	if (dctx->bytes) {
> +		for (i = dctx->bytes; i < GHASH_DIGEST_SIZE; i++)
> +			dctx->buffer[i] = 0;
> +		__ghash_block(ctx, dctx);
> +		dctx->bytes = 0;
>  	}
> +	memcpy(out, dctx->shash, GHASH_DIGEST_SIZE);
> +	return 0;
>  }
>  
>  struct shash_alg p8_ghash_alg = {
> @@ -213,11 +177,8 @@ struct shash_alg p8_ghash_alg = {
>  		 .cra_name = "ghash",
>  		 .cra_driver_name = "p8_ghash",
>  		 .cra_priority = 1000,
> -		 .cra_flags = CRYPTO_ALG_NEED_FALLBACK,
>  		 .cra_blocksize = GHASH_BLOCK_SIZE,
>  		 .cra_ctxsize = sizeof(struct p8_ghash_ctx),
>  		 .cra_module = THIS_MODULE,
> -		 .cra_init = p8_ghash_init_tfm,
> -		 .cra_exit = p8_ghash_exit_tfm,
>  	},
>  };
> -- 
> 2.19.1

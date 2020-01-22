Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADA9145224
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Jan 2020 11:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgAVKIu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 22 Jan 2020 05:08:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37246 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgAVKIu (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 22 Jan 2020 05:08:50 -0500
Received: by mail-pg1-f196.google.com with SMTP id q127so3219904pga.4
        for <linux-crypto@vger.kernel.org>; Wed, 22 Jan 2020 02:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9kDIIRSN/Kwx1b2G2jZ9WNyo/3OUNFcC5U2y0DUdFXs=;
        b=V4k14KvSpaL8+qFSZsTUajTveOhvJDBuD7oFRsFkzN9U+bqVJFP4k9r5jj+C7Ww2cb
         VeGRLU8s8BlEKrWkSiivjOPUqkk4wXQVor3XsVENxaUbosywz11zF3ZQA+i3vIZcHmFx
         Kg+3+XJBn5dAGO4LqhT9+PWuXIMHXAaKRaX4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9kDIIRSN/Kwx1b2G2jZ9WNyo/3OUNFcC5U2y0DUdFXs=;
        b=DmY57IaT9UZoVklz7KGTRzqK+tMxet7XTbl/M8XGyJwkS1kgFFhY32yC92VqkRJHm1
         x6G+qxLp+JCFP50vMvdr6Zdnwj9RiJ4dc0CpGaMpvwKnlIwme7+XOH2qlk8Z99Fx1jzx
         LMUkOURN0fU3xO/lzyETdbchKceDRLxEz4m6ndTVzrD/qOLEy6On1KA3NS2YZoLfuxY5
         77kmEasKxZCMApOgHk/QAZ+0OotOjab8TJt0ydGagik7FJGcoe7dG+uLXV8UQkBw+H2V
         vvZ4GTJjFVbTPrrkdbFlSTcJ75JQdw04g9rS54Un4ZBwKqAKZ7yoxLBV7vHuyaaewO0n
         UBKw==
X-Gm-Message-State: APjAAAUEr9qmS+42+jxMOw/VBAlhtE5JVsVq6/SIeO0wI8NzCb0hyi41
        4XF/0vtA4U//m/wt9Y1ZSNDTPA==
X-Google-Smtp-Source: APXvYqzxqMTAAykeU+y57aexjPAIbqWazHxSSDiqHB+wcSsTSQBBrpuleNzhG9GHMeV5mmZa3IPJlw==
X-Received: by 2002:a63:1d1d:: with SMTP id d29mr9796839pgd.387.1579687728751;
        Wed, 22 Jan 2020 02:08:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 73sm45758342pgc.13.2020.01.22.02.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 02:08:47 -0800 (PST)
Date:   Wed, 22 Jan 2020 02:08:46 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-crypto@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v3] crypto, x86/sha: Eliminate casts on asm
 implementations
Message-ID: <202001220208.BCE739C620@keescook>
References: <202001141955.C4136E9C5@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202001141955.C4136E9C5@keescook>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jan 14, 2020 at 07:57:29PM -0800, Kees Cook wrote:
> In order to avoid CFI function prototype mismatches, this removes the
> casts on assembly implementations of sha1/256/512 accelerators. The
> safety checks from BUILD_BUG_ON() remain.
> 
> Additionally, this renames various arguments for clarity, as suggested
> by Eric Biggers.

Friendly ping. :) Hopefully this looks okay now?

-Kees

> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v3: fix missed variable name change, now correctly allmodconfig build tested
> v2: https://lore.kernel.org/lkml/202001141825.8CD52D0@keescook
> v1: https://lore.kernel.org/lkml/20191122030620.GD32523@sol.localdomain/
> ---
>  arch/x86/crypto/sha1_avx2_x86_64_asm.S |  6 +--
>  arch/x86/crypto/sha1_ssse3_asm.S       | 14 ++++--
>  arch/x86/crypto/sha1_ssse3_glue.c      | 70 +++++++++++---------------
>  arch/x86/crypto/sha256-avx-asm.S       |  4 +-
>  arch/x86/crypto/sha256-avx2-asm.S      |  4 +-
>  arch/x86/crypto/sha256-ssse3-asm.S     |  6 ++-
>  arch/x86/crypto/sha256_ssse3_glue.c    | 34 ++++++-------
>  arch/x86/crypto/sha512-avx-asm.S       | 11 ++--
>  arch/x86/crypto/sha512-avx2-asm.S      | 11 ++--
>  arch/x86/crypto/sha512-ssse3-asm.S     | 13 +++--
>  arch/x86/crypto/sha512_ssse3_glue.c    | 31 ++++++------
>  11 files changed, 102 insertions(+), 102 deletions(-)
> 
> diff --git a/arch/x86/crypto/sha1_avx2_x86_64_asm.S b/arch/x86/crypto/sha1_avx2_x86_64_asm.S
> index 6decc85ef7b7..1e594d60afa5 100644
> --- a/arch/x86/crypto/sha1_avx2_x86_64_asm.S
> +++ b/arch/x86/crypto/sha1_avx2_x86_64_asm.S
> @@ -62,11 +62,11 @@
>   *Visit http://software.intel.com/en-us/articles/
>   *and refer to improving-the-performance-of-the-secure-hash-algorithm-1/
>   *
> - *Updates 20-byte SHA-1 record in 'hash' for even number of
> - *'num_blocks' consecutive 64-byte blocks
> + *Updates 20-byte SHA-1 record at start of 'state', from 'input', for
> + *even number of 'blocks' consecutive 64-byte blocks.
>   *
>   *extern "C" void sha1_transform_avx2(
> - *	int *hash, const char* input, size_t num_blocks );
> + *	struct sha1_state *state, const u8* input, int blocks );
>   */
>  
>  #include <linux/linkage.h>
> diff --git a/arch/x86/crypto/sha1_ssse3_asm.S b/arch/x86/crypto/sha1_ssse3_asm.S
> index 5d03c1173690..12e2d19d7402 100644
> --- a/arch/x86/crypto/sha1_ssse3_asm.S
> +++ b/arch/x86/crypto/sha1_ssse3_asm.S
> @@ -457,9 +457,13 @@ W_PRECALC_SSSE3
>  	movdqu	\a,\b
>  .endm
>  
> -/* SSSE3 optimized implementation:
> - *  extern "C" void sha1_transform_ssse3(u32 *digest, const char *data, u32 *ws,
> - *                                       unsigned int rounds);
> +/*
> + * SSSE3 optimized implementation:
> + *
> + * extern "C" void sha1_transform_ssse3(struct sha1_state *state,
> + *					const u8 *data, int blocks);
> + *
> + * Note that struct sha1_state is assumed to begin with u32 state[5].
>   */
>  SHA1_VECTOR_ASM     sha1_transform_ssse3
>  
> @@ -545,8 +549,8 @@ W_PRECALC_AVX
>  
>  
>  /* AVX optimized implementation:
> - *  extern "C" void sha1_transform_avx(u32 *digest, const char *data, u32 *ws,
> - *                                     unsigned int rounds);
> + *  extern "C" void sha1_transform_avx(struct sha1_state *state,
> + *				       const u8 *data, int blocks);
>   */
>  SHA1_VECTOR_ASM     sha1_transform_avx
>  
> diff --git a/arch/x86/crypto/sha1_ssse3_glue.c b/arch/x86/crypto/sha1_ssse3_glue.c
> index 639d4c2fd6a8..d70b40ad594c 100644
> --- a/arch/x86/crypto/sha1_ssse3_glue.c
> +++ b/arch/x86/crypto/sha1_ssse3_glue.c
> @@ -27,11 +27,8 @@
>  #include <crypto/sha1_base.h>
>  #include <asm/simd.h>
>  
> -typedef void (sha1_transform_fn)(u32 *digest, const char *data,
> -				unsigned int rounds);
> -
>  static int sha1_update(struct shash_desc *desc, const u8 *data,
> -			     unsigned int len, sha1_transform_fn *sha1_xform)
> +			     unsigned int len, sha1_block_fn *sha1_xform)
>  {
>  	struct sha1_state *sctx = shash_desc_ctx(desc);
>  
> @@ -39,48 +36,47 @@ static int sha1_update(struct shash_desc *desc, const u8 *data,
>  	    (sctx->count % SHA1_BLOCK_SIZE) + len < SHA1_BLOCK_SIZE)
>  		return crypto_sha1_update(desc, data, len);
>  
> -	/* make sure casting to sha1_block_fn() is safe */
> +	/*
> +	 * Make sure struct sha1_state begins directly with the SHA1
> +	 * 160-bit internal state, as this is what the asm functions expect.
> +	 */
>  	BUILD_BUG_ON(offsetof(struct sha1_state, state) != 0);
>  
>  	kernel_fpu_begin();
> -	sha1_base_do_update(desc, data, len,
> -			    (sha1_block_fn *)sha1_xform);
> +	sha1_base_do_update(desc, data, len, sha1_xform);
>  	kernel_fpu_end();
>  
>  	return 0;
>  }
>  
>  static int sha1_finup(struct shash_desc *desc, const u8 *data,
> -		      unsigned int len, u8 *out, sha1_transform_fn *sha1_xform)
> +		      unsigned int len, u8 *out, sha1_block_fn *sha1_xform)
>  {
>  	if (!crypto_simd_usable())
>  		return crypto_sha1_finup(desc, data, len, out);
>  
>  	kernel_fpu_begin();
>  	if (len)
> -		sha1_base_do_update(desc, data, len,
> -				    (sha1_block_fn *)sha1_xform);
> -	sha1_base_do_finalize(desc, (sha1_block_fn *)sha1_xform);
> +		sha1_base_do_update(desc, data, len, sha1_xform);
> +	sha1_base_do_finalize(desc, sha1_xform);
>  	kernel_fpu_end();
>  
>  	return sha1_base_finish(desc, out);
>  }
>  
> -asmlinkage void sha1_transform_ssse3(u32 *digest, const char *data,
> -				     unsigned int rounds);
> +asmlinkage void sha1_transform_ssse3(struct sha1_state *state,
> +				     const u8 *data, int blocks);
>  
>  static int sha1_ssse3_update(struct shash_desc *desc, const u8 *data,
>  			     unsigned int len)
>  {
> -	return sha1_update(desc, data, len,
> -			(sha1_transform_fn *) sha1_transform_ssse3);
> +	return sha1_update(desc, data, len, sha1_transform_ssse3);
>  }
>  
>  static int sha1_ssse3_finup(struct shash_desc *desc, const u8 *data,
>  			      unsigned int len, u8 *out)
>  {
> -	return sha1_finup(desc, data, len, out,
> -			(sha1_transform_fn *) sha1_transform_ssse3);
> +	return sha1_finup(desc, data, len, out, sha1_transform_ssse3);
>  }
>  
>  /* Add padding and return the message digest. */
> @@ -119,21 +115,19 @@ static void unregister_sha1_ssse3(void)
>  }
>  
>  #ifdef CONFIG_AS_AVX
> -asmlinkage void sha1_transform_avx(u32 *digest, const char *data,
> -				   unsigned int rounds);
> +asmlinkage void sha1_transform_avx(struct sha1_state *state,
> +				   const u8 *data, int blocks);
>  
>  static int sha1_avx_update(struct shash_desc *desc, const u8 *data,
>  			     unsigned int len)
>  {
> -	return sha1_update(desc, data, len,
> -			(sha1_transform_fn *) sha1_transform_avx);
> +	return sha1_update(desc, data, len, sha1_transform_avx);
>  }
>  
>  static int sha1_avx_finup(struct shash_desc *desc, const u8 *data,
>  			      unsigned int len, u8 *out)
>  {
> -	return sha1_finup(desc, data, len, out,
> -			(sha1_transform_fn *) sha1_transform_avx);
> +	return sha1_finup(desc, data, len, out, sha1_transform_avx);
>  }
>  
>  static int sha1_avx_final(struct shash_desc *desc, u8 *out)
> @@ -190,8 +184,8 @@ static inline void unregister_sha1_avx(void) { }
>  #if defined(CONFIG_AS_AVX2) && (CONFIG_AS_AVX)
>  #define SHA1_AVX2_BLOCK_OPTSIZE	4	/* optimal 4*64 bytes of SHA1 blocks */
>  
> -asmlinkage void sha1_transform_avx2(u32 *digest, const char *data,
> -				    unsigned int rounds);
> +asmlinkage void sha1_transform_avx2(struct sha1_state *state,
> +				    const u8 *data, int blocks);
>  
>  static bool avx2_usable(void)
>  {
> @@ -203,28 +197,26 @@ static bool avx2_usable(void)
>  	return false;
>  }
>  
> -static void sha1_apply_transform_avx2(u32 *digest, const char *data,
> -				unsigned int rounds)
> +static void sha1_apply_transform_avx2(struct sha1_state *state,
> +				      const u8 *data, int blocks)
>  {
>  	/* Select the optimal transform based on data block size */
> -	if (rounds >= SHA1_AVX2_BLOCK_OPTSIZE)
> -		sha1_transform_avx2(digest, data, rounds);
> +	if (blocks >= SHA1_AVX2_BLOCK_OPTSIZE)
> +		sha1_transform_avx2(state, data, blocks);
>  	else
> -		sha1_transform_avx(digest, data, rounds);
> +		sha1_transform_avx(state, data, blocks);
>  }
>  
>  static int sha1_avx2_update(struct shash_desc *desc, const u8 *data,
>  			     unsigned int len)
>  {
> -	return sha1_update(desc, data, len,
> -		(sha1_transform_fn *) sha1_apply_transform_avx2);
> +	return sha1_update(desc, data, len, sha1_apply_transform_avx2);
>  }
>  
>  static int sha1_avx2_finup(struct shash_desc *desc, const u8 *data,
>  			      unsigned int len, u8 *out)
>  {
> -	return sha1_finup(desc, data, len, out,
> -		(sha1_transform_fn *) sha1_apply_transform_avx2);
> +	return sha1_finup(desc, data, len, out, sha1_apply_transform_avx2);
>  }
>  
>  static int sha1_avx2_final(struct shash_desc *desc, u8 *out)
> @@ -267,21 +259,19 @@ static inline void unregister_sha1_avx2(void) { }
>  #endif
>  
>  #ifdef CONFIG_AS_SHA1_NI
> -asmlinkage void sha1_ni_transform(u32 *digest, const char *data,
> -				   unsigned int rounds);
> +asmlinkage void sha1_ni_transform(struct sha1_state *digest, const u8 *data,
> +				  int rounds);
>  
>  static int sha1_ni_update(struct shash_desc *desc, const u8 *data,
>  			     unsigned int len)
>  {
> -	return sha1_update(desc, data, len,
> -		(sha1_transform_fn *) sha1_ni_transform);
> +	return sha1_update(desc, data, len, sha1_ni_transform);
>  }
>  
>  static int sha1_ni_finup(struct shash_desc *desc, const u8 *data,
>  			      unsigned int len, u8 *out)
>  {
> -	return sha1_finup(desc, data, len, out,
> -		(sha1_transform_fn *) sha1_ni_transform);
> +	return sha1_finup(desc, data, len, out, sha1_ni_transform);
>  }
>  
>  static int sha1_ni_final(struct shash_desc *desc, u8 *out)
> diff --git a/arch/x86/crypto/sha256-avx-asm.S b/arch/x86/crypto/sha256-avx-asm.S
> index 22e14c8dd2e4..fcbc30f58c38 100644
> --- a/arch/x86/crypto/sha256-avx-asm.S
> +++ b/arch/x86/crypto/sha256-avx-asm.S
> @@ -341,8 +341,8 @@ a = TMP_
>  .endm
>  
>  ########################################################################
> -## void sha256_transform_avx(void *input_data, UINT32 digest[8], UINT64 num_blks)
> -## arg 1 : pointer to digest
> +## void sha256_transform_avx(state sha256_state *state, const u8 *data, int blocks)
> +## arg 1 : pointer to state
>  ## arg 2 : pointer to input data
>  ## arg 3 : Num blocks
>  ########################################################################
> diff --git a/arch/x86/crypto/sha256-avx2-asm.S b/arch/x86/crypto/sha256-avx2-asm.S
> index 519b551ad576..499d9ec129de 100644
> --- a/arch/x86/crypto/sha256-avx2-asm.S
> +++ b/arch/x86/crypto/sha256-avx2-asm.S
> @@ -520,8 +520,8 @@ STACK_SIZE	= _RSP      + _RSP_SIZE
>  .endm
>  
>  ########################################################################
> -## void sha256_transform_rorx(void *input_data, UINT32 digest[8], UINT64 num_blks)
> -## arg 1 : pointer to digest
> +## void sha256_transform_rorx(struct sha256_state *state, const u8 *data, int blocks)
> +## arg 1 : pointer to state
>  ## arg 2 : pointer to input data
>  ## arg 3 : Num blocks
>  ########################################################################
> diff --git a/arch/x86/crypto/sha256-ssse3-asm.S b/arch/x86/crypto/sha256-ssse3-asm.S
> index 69cc2f91dc4c..ddfa863b4ee3 100644
> --- a/arch/x86/crypto/sha256-ssse3-asm.S
> +++ b/arch/x86/crypto/sha256-ssse3-asm.S
> @@ -347,8 +347,10 @@ a = TMP_
>  .endm
>  
>  ########################################################################
> -## void sha256_transform_ssse3(void *input_data, UINT32 digest[8], UINT64 num_blks)
> -## arg 1 : pointer to digest
> +## void sha256_transform_ssse3(struct sha256_state *state, const u8 *data,
> +##			       int blocks);
> +## arg 1 : pointer to state
> +##	   (struct sha256_state is assumed to begin with u32 state[8])
>  ## arg 2 : pointer to input data
>  ## arg 3 : Num blocks
>  ########################################################################
> diff --git a/arch/x86/crypto/sha256_ssse3_glue.c b/arch/x86/crypto/sha256_ssse3_glue.c
> index f9aff31fe59e..03ad657c04bd 100644
> --- a/arch/x86/crypto/sha256_ssse3_glue.c
> +++ b/arch/x86/crypto/sha256_ssse3_glue.c
> @@ -41,12 +41,11 @@
>  #include <linux/string.h>
>  #include <asm/simd.h>
>  
> -asmlinkage void sha256_transform_ssse3(u32 *digest, const char *data,
> -				       u64 rounds);
> -typedef void (sha256_transform_fn)(u32 *digest, const char *data, u64 rounds);
> +asmlinkage void sha256_transform_ssse3(struct sha256_state *state,
> +				       const u8 *data, int blocks);
>  
>  static int _sha256_update(struct shash_desc *desc, const u8 *data,
> -			  unsigned int len, sha256_transform_fn *sha256_xform)
> +			  unsigned int len, sha256_block_fn *sha256_xform)
>  {
>  	struct sha256_state *sctx = shash_desc_ctx(desc);
>  
> @@ -54,28 +53,29 @@ static int _sha256_update(struct shash_desc *desc, const u8 *data,
>  	    (sctx->count % SHA256_BLOCK_SIZE) + len < SHA256_BLOCK_SIZE)
>  		return crypto_sha256_update(desc, data, len);
>  
> -	/* make sure casting to sha256_block_fn() is safe */
> +	/*
> +	 * Make sure struct sha256_state begins directly with the SHA256
> +	 * 256-bit internal state, as this is what the asm functions expect.
> +	 */
>  	BUILD_BUG_ON(offsetof(struct sha256_state, state) != 0);
>  
>  	kernel_fpu_begin();
> -	sha256_base_do_update(desc, data, len,
> -			      (sha256_block_fn *)sha256_xform);
> +	sha256_base_do_update(desc, data, len, sha256_xform);
>  	kernel_fpu_end();
>  
>  	return 0;
>  }
>  
>  static int sha256_finup(struct shash_desc *desc, const u8 *data,
> -	      unsigned int len, u8 *out, sha256_transform_fn *sha256_xform)
> +	      unsigned int len, u8 *out, sha256_block_fn *sha256_xform)
>  {
>  	if (!crypto_simd_usable())
>  		return crypto_sha256_finup(desc, data, len, out);
>  
>  	kernel_fpu_begin();
>  	if (len)
> -		sha256_base_do_update(desc, data, len,
> -				      (sha256_block_fn *)sha256_xform);
> -	sha256_base_do_finalize(desc, (sha256_block_fn *)sha256_xform);
> +		sha256_base_do_update(desc, data, len, sha256_xform);
> +	sha256_base_do_finalize(desc, sha256_xform);
>  	kernel_fpu_end();
>  
>  	return sha256_base_finish(desc, out);
> @@ -145,8 +145,8 @@ static void unregister_sha256_ssse3(void)
>  }
>  
>  #ifdef CONFIG_AS_AVX
> -asmlinkage void sha256_transform_avx(u32 *digest, const char *data,
> -				     u64 rounds);
> +asmlinkage void sha256_transform_avx(struct sha256_state *state,
> +				     const u8 *data, int blocks);
>  
>  static int sha256_avx_update(struct shash_desc *desc, const u8 *data,
>  			 unsigned int len)
> @@ -227,8 +227,8 @@ static inline void unregister_sha256_avx(void) { }
>  #endif
>  
>  #if defined(CONFIG_AS_AVX2) && defined(CONFIG_AS_AVX)
> -asmlinkage void sha256_transform_rorx(u32 *digest, const char *data,
> -				      u64 rounds);
> +asmlinkage void sha256_transform_rorx(struct sha256_state *state,
> +				      const u8 *data, int blocks);
>  
>  static int sha256_avx2_update(struct shash_desc *desc, const u8 *data,
>  			 unsigned int len)
> @@ -307,8 +307,8 @@ static inline void unregister_sha256_avx2(void) { }
>  #endif
>  
>  #ifdef CONFIG_AS_SHA256_NI
> -asmlinkage void sha256_ni_transform(u32 *digest, const char *data,
> -				   u64 rounds); /*unsigned int rounds);*/
> +asmlinkage void sha256_ni_transform(struct sha256_state *digest,
> +				    const u8 *data, int rounds);
>  
>  static int sha256_ni_update(struct shash_desc *desc, const u8 *data,
>  			 unsigned int len)
> diff --git a/arch/x86/crypto/sha512-avx-asm.S b/arch/x86/crypto/sha512-avx-asm.S
> index 3704ddd7e5d5..90ea945ba5e6 100644
> --- a/arch/x86/crypto/sha512-avx-asm.S
> +++ b/arch/x86/crypto/sha512-avx-asm.S
> @@ -271,11 +271,12 @@ frame_size = frame_GPRSAVE + GPRSAVE_SIZE
>  .endm
>  
>  ########################################################################
> -# void sha512_transform_avx(void* D, const void* M, u64 L)
> -# Purpose: Updates the SHA512 digest stored at D with the message stored in M.
> -# The size of the message pointed to by M must be an integer multiple of SHA512
> -# message blocks.
> -# L is the message length in SHA512 blocks
> +# void sha512_transform_avx(sha512_state *state, const u8 *data, int blocks)
> +# Purpose: Updates the SHA512 digest stored at "state" with the message
> +# stored in "data".
> +# The size of the message pointed to by "data" must be an integer multiple
> +# of SHA512 message blocks.
> +# "blocks" is the message length in SHA512 blocks
>  ########################################################################
>  SYM_FUNC_START(sha512_transform_avx)
>  	cmp $0, msglen
> diff --git a/arch/x86/crypto/sha512-avx2-asm.S b/arch/x86/crypto/sha512-avx2-asm.S
> index 80d830e7ee09..3dd886b14e7d 100644
> --- a/arch/x86/crypto/sha512-avx2-asm.S
> +++ b/arch/x86/crypto/sha512-avx2-asm.S
> @@ -563,11 +563,12 @@ frame_size = frame_GPRSAVE + GPRSAVE_SIZE
>  .endm
>  
>  ########################################################################
> -# void sha512_transform_rorx(void* D, const void* M, uint64_t L)#
> -# Purpose: Updates the SHA512 digest stored at D with the message stored in M.
> -# The size of the message pointed to by M must be an integer multiple of SHA512
> -#   message blocks.
> -# L is the message length in SHA512 blocks
> +# void sha512_transform_rorx(sha512_state *state, const u8 *data, int blocks)
> +# Purpose: Updates the SHA512 digest stored at "state" with the message
> +# stored in "data".
> +# The size of the message pointed to by "data" must be an integer multiple
> +# of SHA512 message blocks.
> +# "blocks" is the message length in SHA512 blocks
>  ########################################################################
>  SYM_FUNC_START(sha512_transform_rorx)
>  	# Allocate Stack Space
> diff --git a/arch/x86/crypto/sha512-ssse3-asm.S b/arch/x86/crypto/sha512-ssse3-asm.S
> index 838f984e95d9..7946a1bee85b 100644
> --- a/arch/x86/crypto/sha512-ssse3-asm.S
> +++ b/arch/x86/crypto/sha512-ssse3-asm.S
> @@ -269,11 +269,14 @@ frame_size = frame_GPRSAVE + GPRSAVE_SIZE
>  .endm
>  
>  ########################################################################
> -# void sha512_transform_ssse3(void* D, const void* M, u64 L)#
> -# Purpose: Updates the SHA512 digest stored at D with the message stored in M.
> -# The size of the message pointed to by M must be an integer multiple of SHA512
> -#   message blocks.
> -# L is the message length in SHA512 blocks.
> +## void sha512_transform_ssse3(struct sha512_state *state, const u8 *data,
> +##			       int blocks);
> +# (struct sha512_state is assumed to begin with u64 state[8])
> +# Purpose: Updates the SHA512 digest stored at "state" with the message
> +# stored in "data".
> +# The size of the message pointed to by "data" must be an integer multiple
> +# of SHA512 message blocks.
> +# "blocks" is the message length in SHA512 blocks.
>  ########################################################################
>  SYM_FUNC_START(sha512_transform_ssse3)
>  
> diff --git a/arch/x86/crypto/sha512_ssse3_glue.c b/arch/x86/crypto/sha512_ssse3_glue.c
> index 458356a3f124..1c444f41037c 100644
> --- a/arch/x86/crypto/sha512_ssse3_glue.c
> +++ b/arch/x86/crypto/sha512_ssse3_glue.c
> @@ -39,13 +39,11 @@
>  #include <crypto/sha512_base.h>
>  #include <asm/simd.h>
>  
> -asmlinkage void sha512_transform_ssse3(u64 *digest, const char *data,
> -				       u64 rounds);
> -
> -typedef void (sha512_transform_fn)(u64 *digest, const char *data, u64 rounds);
> +asmlinkage void sha512_transform_ssse3(struct sha512_state *state,
> +				       const u8 *data, int blocks);
>  
>  static int sha512_update(struct shash_desc *desc, const u8 *data,
> -		       unsigned int len, sha512_transform_fn *sha512_xform)
> +		       unsigned int len, sha512_block_fn *sha512_xform)
>  {
>  	struct sha512_state *sctx = shash_desc_ctx(desc);
>  
> @@ -53,28 +51,29 @@ static int sha512_update(struct shash_desc *desc, const u8 *data,
>  	    (sctx->count[0] % SHA512_BLOCK_SIZE) + len < SHA512_BLOCK_SIZE)
>  		return crypto_sha512_update(desc, data, len);
>  
> -	/* make sure casting to sha512_block_fn() is safe */
> +	/*
> +	 * Make sure struct sha512_state begins directly with the SHA512
> +	 * 512-bit internal state, as this is what the asm functions expect.
> +	 */
>  	BUILD_BUG_ON(offsetof(struct sha512_state, state) != 0);
>  
>  	kernel_fpu_begin();
> -	sha512_base_do_update(desc, data, len,
> -			      (sha512_block_fn *)sha512_xform);
> +	sha512_base_do_update(desc, data, len, sha512_xform);
>  	kernel_fpu_end();
>  
>  	return 0;
>  }
>  
>  static int sha512_finup(struct shash_desc *desc, const u8 *data,
> -	      unsigned int len, u8 *out, sha512_transform_fn *sha512_xform)
> +	      unsigned int len, u8 *out, sha512_block_fn *sha512_xform)
>  {
>  	if (!crypto_simd_usable())
>  		return crypto_sha512_finup(desc, data, len, out);
>  
>  	kernel_fpu_begin();
>  	if (len)
> -		sha512_base_do_update(desc, data, len,
> -				      (sha512_block_fn *)sha512_xform);
> -	sha512_base_do_finalize(desc, (sha512_block_fn *)sha512_xform);
> +		sha512_base_do_update(desc, data, len, sha512_xform);
> +	sha512_base_do_finalize(desc, sha512_xform);
>  	kernel_fpu_end();
>  
>  	return sha512_base_finish(desc, out);
> @@ -144,8 +143,8 @@ static void unregister_sha512_ssse3(void)
>  }
>  
>  #ifdef CONFIG_AS_AVX
> -asmlinkage void sha512_transform_avx(u64 *digest, const char *data,
> -				     u64 rounds);
> +asmlinkage void sha512_transform_avx(struct sha512_state *state,
> +				     const u8 *data, int blocks);
>  static bool avx_usable(void)
>  {
>  	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL)) {
> @@ -225,8 +224,8 @@ static inline void unregister_sha512_avx(void) { }
>  #endif
>  
>  #if defined(CONFIG_AS_AVX2) && defined(CONFIG_AS_AVX)
> -asmlinkage void sha512_transform_rorx(u64 *digest, const char *data,
> -				      u64 rounds);
> +asmlinkage void sha512_transform_rorx(struct sha512_state *state,
> +				      const u8 *data, int blocks);
>  
>  static int sha512_avx2_update(struct shash_desc *desc, const u8 *data,
>  		       unsigned int len)
> -- 
> 2.20.1
> 
> 
> -- 
> Kees Cook

-- 
Kees Cook

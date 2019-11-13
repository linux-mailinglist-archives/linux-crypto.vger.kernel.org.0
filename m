Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05292FB8EC
	for <lists+linux-crypto@lfdr.de>; Wed, 13 Nov 2019 20:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfKMTec (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 13 Nov 2019 14:34:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:42988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfKMTeb (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 13 Nov 2019 14:34:31 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95EE6206D7;
        Wed, 13 Nov 2019 19:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573673671;
        bh=o2wXCRnJvMNzkoYmM+/9D8Kea21XKX9mhE/7gJ8wZcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xuMmI97cuv61wfFEfbfqXOMSOfwEvQTrHtTzND2TYmYYbeZFqz/HhuTliEczNVTj7
         5JVjuWDZoM6PaIjFYWPJPyQHf9VdG61hnR9vKnsKIkpFfUupVwVmdy0xefMgz7akDc
         knhhNzA11N96sh9u6IwjmEDlGR/qGjbRpZYoyvoA=
Date:   Wed, 13 Nov 2019 11:34:29 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        =?iso-8859-1?Q?Jo=E3o?= Moreira <joao.moreira@intel.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Stephan Mueller <smueller@chronox.de>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v5 2/8] crypto: x86/serpent: Remove glue function macros
 usage
Message-ID: <20191113193428.GB221701@gmail.com>
Mail-Followup-To: Kees Cook <keescook@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        =?iso-8859-1?Q?Jo=E3o?= Moreira <joao.moreira@intel.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Stephan Mueller <smueller@chronox.de>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
References: <20191113182516.13545-1-keescook@chromium.org>
 <20191113182516.13545-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113182516.13545-3-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Nov 13, 2019 at 10:25:10AM -0800, Kees Cook wrote:
> diff --git a/arch/x86/include/asm/crypto/serpent-sse2.h b/arch/x86/include/asm/crypto/serpent-sse2.h
> index 1a345e8a7496..491a5a7d4e15 100644
> --- a/arch/x86/include/asm/crypto/serpent-sse2.h
> +++ b/arch/x86/include/asm/crypto/serpent-sse2.h
> @@ -41,8 +41,7 @@ asmlinkage void __serpent_enc_blk_8way(struct serpent_ctx *ctx, u8 *dst,
>  asmlinkage void serpent_dec_blk_8way(struct serpent_ctx *ctx, u8 *dst,
>  				     const u8 *src);
>  
> -static inline void serpent_enc_blk_xway(struct serpent_ctx *ctx, u8 *dst,
> -				   const u8 *src)
> +static inline void serpent_enc_blk_xway(void *ctx, u8 *dst, const u8 *src)
>  {
>  	__serpent_enc_blk_8way(ctx, dst, src, false);
>  }
> @@ -53,8 +52,7 @@ static inline void serpent_enc_blk_xway_xor(struct serpent_ctx *ctx, u8 *dst,
>  	__serpent_enc_blk_8way(ctx, dst, src, true);
>  }
>  
> -static inline void serpent_dec_blk_xway(struct serpent_ctx *ctx, u8 *dst,
> -				   const u8 *src)
> +static inline void serpent_dec_blk_xway(void *ctx, u8 *dst, const u8 *src)
>  {
>  	serpent_dec_blk_8way(ctx, dst, src);
>  }

Please read this whole file --- these functions are also defined under an #ifdef
CONFIG_X86_32 block, so that part needs to be updated too.

- Eric

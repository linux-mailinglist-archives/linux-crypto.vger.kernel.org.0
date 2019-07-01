Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D15103B8F8
	for <lists+linux-crypto@lfdr.de>; Mon, 10 Jun 2019 18:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391444AbfFJQGZ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 10 Jun 2019 12:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391391AbfFJQGZ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 10 Jun 2019 12:06:25 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03C4420820;
        Mon, 10 Jun 2019 16:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560182785;
        bh=znNtSWGQypxPL8cS71W/bMvErPhY56fSOlbR5J3uIuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ehOcKrLXTRNNi+2CLiWA7yJ7STCf9XRcOjiB0Dz64dk3BgJh7mpEP2cyruDyOsReZ
         z8CPgDbFoxziPDkJid6ui9AQvmDW5VUAJD6YzS4itzuW5VpZx2xPQXR9Y6Mxnb1Tbm
         FEpflXMdHraHXuJfWWbGr/LlmSA/dKyhUJpB+22w=
Date:   Mon, 10 Jun 2019 09:06:23 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 1/7] crypto: arc4 - refactor arc4 core code into
 separate library
Message-ID: <20190610160622.GA63833@gmail.com>
References: <20190609115509.26260-1-ard.biesheuvel@linaro.org>
 <20190609115509.26260-2-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190609115509.26260-2-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Just some bike shedding:

On Sun, Jun 09, 2019 at 01:55:03PM +0200, Ard Biesheuvel wrote:
> diff --git a/include/crypto/arc4.h b/include/crypto/arc4.h
> index 5b2c24ab0139..62ac95ec6860 100644
> --- a/include/crypto/arc4.h
> +++ b/include/crypto/arc4.h
> @@ -6,8 +6,21 @@
>  #ifndef _CRYPTO_ARC4_H
>  #define _CRYPTO_ARC4_H
>  
> +#include <linux/types.h>
> +
>  #define ARC4_MIN_KEY_SIZE	1
>  #define ARC4_MAX_KEY_SIZE	256
>  #define ARC4_BLOCK_SIZE		1
>  
> +struct crypto_arc4_ctx {
> +	u32 S[256];
> +	u32 x, y;
> +};
> +
> +int crypto_arc4_set_key(struct crypto_arc4_ctx *ctx, const u8 *in_key,
> +			unsigned int key_len);
> +
> +void crypto_arc4_crypt(struct crypto_arc4_ctx *ctx, u8 *out, const u8 *in,
> +		       unsigned int len);

How about naming these just arc4_* instead of crypto_arc4_*?  The crypto_*
prefix is already used mostly for crypto API helper functions, i.e. functions
that take take one of the abstract crypto API types like crypto_skcipher,
shash_desc, etc.  For lib functions, the bare name seems more appropriate.  See
e.g. sha256_update() vs. crypto_sha256_update().

> +++ b/lib/crypto/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_CRYPTO_LIB_ARC4) += libarc4.o
> diff --git a/lib/crypto/libarc4.c b/lib/crypto/libarc4.c
> new file mode 100644
> index 000000000000..b828af2cc03b
> --- /dev/null
> +++ b/lib/crypto/libarc4.c
> @@ -0,0 +1,74 @@

How about arc4.c instead of libarc4.c?  The second "lib" is redundant, given
that the file is already in the lib/ directory.

- Eric

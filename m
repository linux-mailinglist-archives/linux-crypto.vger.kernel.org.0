Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648C42B153F
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Nov 2020 06:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgKMFJy (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 13 Nov 2020 00:09:54 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:33668 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgKMFJy (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 13 Nov 2020 00:09:54 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kdRLJ-0000qR-PI; Fri, 13 Nov 2020 16:09:50 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 Nov 2020 16:09:49 +1100
Date:   Fri, 13 Nov 2020 16:09:49 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH crypto] crypto: Kconfig - CRYPTO_MANAGER_EXTRA_TESTS
 requires the manager
Message-ID: <20201113050949.GA8350@gondor.apana.org.au>
References: <20201102134815.512866-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102134815.512866-1-Jason@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Nov 02, 2020 at 02:48:15PM +0100, Jason A. Donenfeld wrote:
> The extra tests in the manager actually require the manager to be
> selected too. Otherwise the linker gives errors like:
> 
> ld: arch/x86/crypto/chacha_glue.o: in function `chacha_simd_stream_xor':
> chacha_glue.c:(.text+0x422): undefined reference to `crypto_simd_disabled_for_test'
> 
> Fixes: 2343d1529aff ("crypto: Kconfig - allow tests to be disabled when manager is disabled")
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  crypto/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

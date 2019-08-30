Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFCC9A31F2
	for <lists+linux-crypto@lfdr.de>; Fri, 30 Aug 2019 10:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfH3IO1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 30 Aug 2019 04:14:27 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59582 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfH3IO1 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 30 Aug 2019 04:14:27 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1i3c36-00048O-BC; Fri, 30 Aug 2019 18:14:25 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 30 Aug 2019 18:14:23 +1000
Date:   Fri, 30 Aug 2019 18:14:23 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-crypto@vger.kernel.org, natechancellor@gmail.com
Subject: Re: [PATCH] crypto: arm64/aegis128 - use explicit vector load for
 permute vectors
Message-ID: <20190830081422.GB7573@gondor.apana.org.au>
References: <20190819141500.1070-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819141500.1070-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Aug 19, 2019 at 05:15:00PM +0300, Ard Biesheuvel wrote:
> When building the new aegis128 NEON code in big endian mode, Clang
> complains about the const uint8x16_t permute vectors in the following
> way:
> 
>   crypto/aegis128-neon-inner.c:58:40: warning: vector initializers are not
>       compatible with NEON intrinsics in big endian mode
>       [-Wnonportable-vector-initialization]
>                 static const uint8x16_t shift_rows = {
>                                                      ^
>   crypto/aegis128-neon-inner.c:58:40: note: consider using vld1q_u8() to
>       initialize a vector from memory, or vcombine_u8(vcreate_u8(), vcreate_u8())
>       to initialize from integer constants
> 
> Since the same issue applies to the uint8x16x4_t loads of the AES Sbox,
> update those references as well. However, since GCC does not implement
> the vld1q_u8_x4() intrinsic, switch from IS_ENABLED() to a preprocessor
> conditional to conditionally include this code.
> 
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  crypto/aegis128-neon-inner.c | 38 ++++++++++----------
>  1 file changed, 19 insertions(+), 19 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A923B338E74
	for <lists+linux-crypto@lfdr.de>; Fri, 12 Mar 2021 14:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhCLNNO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 12 Mar 2021 08:13:14 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:54496 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230491AbhCLNMn (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 12 Mar 2021 08:12:43 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lKham-0006Fj-3e; Sat, 13 Mar 2021 00:12:37 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 13 Mar 2021 00:12:36 +1100
Date:   Sat, 13 Mar 2021 00:12:36 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org,
        syzbot+12cf5fbfdeba210a89dd@syzkaller.appspotmail.com,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v3] crypto: api - check for ERR pointers in
 crypto_destroy_tfm()
Message-ID: <20210312131235.GF31502@gondor.apana.org.au>
References: <20210302203303.40881-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302203303.40881-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Mar 02, 2021 at 09:33:03PM +0100, Ard Biesheuvel wrote:
> Given that crypto_alloc_tfm() may return ERR pointers, and to avoid
> crashes on obscure error paths where such pointers are presented to
> crypto_destroy_tfm() (such as [0]), add an ERR_PTR check there
> before dereferencing the second argument as a struct crypto_tfm
> pointer.
> 
> [0] https://lore.kernel.org/linux-crypto/000000000000de949705bc59e0f6@google.com/
> 
> Reported-by: syzbot+12cf5fbfdeba210a89dd@syzkaller.appspotmail.com
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> v3: missed crypto_free_shash() in v2
>     add Eric's Rb
> v2: update kerneldoc comments of callers to crypto_destroy_tfm() that NULL or
>     error pointers are ignored.
> 
>  crypto/api.c               | 2 +-
>  include/crypto/acompress.h | 2 ++
>  include/crypto/aead.h      | 2 ++
>  include/crypto/akcipher.h  | 2 ++
>  include/crypto/hash.h      | 4 ++++
>  include/crypto/kpp.h       | 2 ++
>  include/crypto/rng.h       | 2 ++
>  include/crypto/skcipher.h  | 2 ++
>  8 files changed, 17 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62D839C2F4
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Jun 2021 23:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhFDVwg (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Jun 2021 17:52:36 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:47394 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229929AbhFDVwg (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Jun 2021 17:52:36 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lpHiK-0005OW-8V; Sat, 05 Jun 2021 05:50:48 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lpHiH-00014j-NG; Sat, 05 Jun 2021 05:50:45 +0800
Date:   Sat, 5 Jun 2021 05:50:45 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org, ebiggers@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] crypto: shash - stop comparing function pointers to
 avoid breaking CFI
Message-ID: <20210604215045.GA4052@gondor.apana.org.au>
References: <20210604190009.33022-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604190009.33022-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jun 04, 2021 at 09:00:09PM +0200, Ard Biesheuvel wrote:
> crypto_shash_alg_has_setkey() is implemented by testing whether the
> .setkey() member of a struct shash_alg points to the default version
> called shash_no_setkey(). As crypto_shash_alg_has_setkey() is a static
> inline, this requires shash_no_setkey() to be exported to modules.
> 
> Unfortunately, when building with CFI, function pointers are routed
> via CFI stubs which are private to each module (or to the kernel proper)
> and so this function pointer comparison may fail spuriously.
> 
> Let's fix this by turning crypto_shash_alg_has_setkey() into an out of
> line function, which makes the problem go away.
> 
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  crypto/shash.c                 | 11 ++++++++---
>  include/crypto/internal/hash.h |  8 +-------
>  2 files changed, 9 insertions(+), 10 deletions(-)

I think this deserves a comment in the code.

> +bool crypto_shash_alg_has_setkey(struct shash_alg *alg)
> +{
> +       return alg->setkey != shash_no_setkey;
> +}
> +EXPORT_SYMBOL_GPL(crypto_shash_alg_has_setkey);

This would be a good spot for the comment so someone doesn't try
to make it inline again later.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

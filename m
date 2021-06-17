Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3C93AAE4A
	for <lists+linux-crypto@lfdr.de>; Thu, 17 Jun 2021 10:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhFQIDM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 17 Jun 2021 04:03:12 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50726 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229783AbhFQIDL (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 17 Jun 2021 04:03:11 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1ltmxT-0003ht-FX; Thu, 17 Jun 2021 16:01:03 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ltmxT-0002n5-63; Thu, 17 Jun 2021 16:01:03 +0800
Date:   Thu, 17 Jun 2021 16:01:03 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v3] crypto: shash - avoid comparing pointers to exported
 functions under CFI
Message-ID: <20210617080103.GC10662@gondor.apana.org.au>
References: <20210610062150.212779-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610062150.212779-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jun 10, 2021 at 08:21:50AM +0200, Ard Biesheuvel wrote:
> crypto_shash_alg_has_setkey() is implemented by testing whether the
> .setkey() member of a struct shash_alg points to the default version,
> called shash_no_setkey(). As crypto_shash_alg_has_setkey() is a static
> inline, this requires shash_no_setkey() to be exported to modules.
> 
> Unfortunately, when building with CFI, function pointers are routed
> via CFI stubs which are private to each module (or to the kernel proper)
> and so this function pointer comparison may fail spuriously.
> 
> Let's fix this by turning crypto_shash_alg_has_setkey() into an out of
> line function.
> 
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> v3: improve comment as per Eric's suggestion
> v2: add code comment to explain why the function needs to remain out of
> line
> 
>  crypto/shash.c                 | 18 +++++++++++++++---
>  include/crypto/internal/hash.h |  8 +-------
>  2 files changed, 16 insertions(+), 10 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

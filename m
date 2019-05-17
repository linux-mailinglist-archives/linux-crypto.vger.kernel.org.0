Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAA1721395
	for <lists+linux-crypto@lfdr.de>; Fri, 17 May 2019 08:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfEQGAx (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 17 May 2019 02:00:53 -0400
Received: from [128.1.224.119] ([128.1.224.119]:54078 "EHLO deadmen.hmeau.com"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727242AbfEQGAx (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 17 May 2019 02:00:53 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hRVvE-0007sM-0Z; Fri, 17 May 2019 14:00:48 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hRVvD-0000Z1-SS; Fri, 17 May 2019 14:00:47 +0800
Date:   Fri, 17 May 2019 14:00:47 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Daniel Axtens <dja@axtens.net>
Cc:     mpe@ellerman.id.au, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, marcelo.cerri@canonical.com,
        Stephan Mueller <smueller@chronox.de>,
        leo.barbosa@canonical.com, linuxppc-dev@lists.ozlabs.org,
        nayna@linux.ibm.com, pfsmorigo@gmail.com, leitao@debian.org,
        gcwilson@linux.ibm.com, omosnacek@gmail.com
Subject: Re: [PATCH] crypto: vmx - ghash: do nosimd fallback manually
Message-ID: <20190517060047.jelbwbn66qdoshwu@gondor.apana.org.au>
References: <20190516154002.26246-1-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516154002.26246-1-dja@axtens.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, May 17, 2019 at 01:40:02AM +1000, Daniel Axtens wrote:
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
> 
> ---
> 
> Tested on BE and LE in qemu-tcg, so more testing would be lovely.
> ---
>  drivers/crypto/vmx/ghash.c | 211 +++++++++++++++----------------------
>  1 file changed, 86 insertions(+), 125 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

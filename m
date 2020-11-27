Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20BE2C600D
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Nov 2020 07:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389406AbgK0GY6 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 27 Nov 2020 01:24:58 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:33406 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728043AbgK0GY6 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 27 Nov 2020 01:24:58 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kiXBf-0000tH-5Y; Fri, 27 Nov 2020 17:24:56 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Nov 2020 17:24:55 +1100
Date:   Fri, 27 Nov 2020 17:24:55 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ondrej Mosnacek <omosnacek@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v3 0/4] crypto: aegis128 enhancements
Message-ID: <20201127062454.GA11448@gondor.apana.org.au>
References: <20201117133214.29114-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117133214.29114-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Nov 17, 2020 at 02:32:10PM +0100, Ard Biesheuvel wrote:
> This series supersedes [0] '[PATCH] crypto: aegis128/neon - optimize tail
> block handling', which is included as patch #3 here, but hasn't been
> modified substantially.
> 
> Patch #1 should probably go to -stable, even though aegis128 does not appear
> to be widely used.
> 
> Patches #2 and #3 improve the SIMD code paths.
> 
> Patch #4 enables fuzz testing for the SIMD code by registering the generic
> code as a separate driver if the SIMD code path is enabled.
> 
> Changes since v2:
> - add Ondrej's ack to #1
> - fix an issue spotted by Ondrej in #4 where the generic code path would still
>   use some of the SIMD helpers
> 
> Cc: Ondrej Mosnacek <omosnacek@gmail.com>
> Cc: Eric Biggers <ebiggers@kernel.org>
> 
> [0] https://lore.kernel.org/linux-crypto/20201107195516.13952-1-ardb@kernel.org/
> 
> Ard Biesheuvel (4):
>   crypto: aegis128 - wipe plaintext and tag if decryption fails
>   crypto: aegis128/neon - optimize tail block handling
>   crypto: aegis128/neon - move final tag check to SIMD domain
>   crypto: aegis128 - expose SIMD code path as separate driver
> 
>  crypto/aegis128-core.c       | 245 ++++++++++++++------
>  crypto/aegis128-neon-inner.c | 122 ++++++++--
>  crypto/aegis128-neon.c       |  21 +-
>  3 files changed, 287 insertions(+), 101 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

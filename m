Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2332221BA
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Jul 2020 13:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgGPLyL (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Jul 2020 07:54:11 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:40062 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbgGPLyL (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Jul 2020 07:54:11 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jw2Sm-0008KH-M7; Thu, 16 Jul 2020 21:54:09 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 16 Jul 2020 21:54:08 +1000
Date:   Thu, 16 Jul 2020 21:54:08 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org, Martin Willi <martin@strongswan.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] crypto: x86/chacha-sse3 - use unaligned loads for state
 array
Message-ID: <20200716115408.GC31166@gondor.apana.org.au>
References: <20200708091118.1389-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708091118.1389-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Jul 08, 2020 at 12:11:18PM +0300, Ard Biesheuvel wrote:
> Due to the fact that the x86 port does not support allocating objects
> on the stack with an alignment that exceeds 8 bytes, we have a rather
> ugly hack in the x86 code for ChaCha to ensure that the state array is
> aligned to 16 bytes, allowing the SSE3 implementation of the algorithm
> to use aligned loads.
> 
> Given that the performance benefit of using of aligned loads appears to
> be limited (~0.25% for 1k blocks using tcrypt on a Corei7-8650U), and
> the fact that this hack has leaked into generic ChaCha code, let's just
> remove it.
> 
> Cc: Martin Willi <martin@strongswan.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/crypto/chacha-ssse3-x86_64.S | 16 ++++++++--------
>  arch/x86/crypto/chacha_glue.c         | 17 ++---------------
>  include/crypto/chacha.h               |  4 ----
>  3 files changed, 10 insertions(+), 27 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

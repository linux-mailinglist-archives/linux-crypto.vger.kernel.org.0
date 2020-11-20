Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03CA2BA2B5
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Nov 2020 07:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgKTG4V (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Nov 2020 01:56:21 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:34188 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgKTG4V (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Nov 2020 01:56:21 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kg0LC-0007iH-Uz; Fri, 20 Nov 2020 17:56:20 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Nov 2020 17:56:18 +1100
Date:   Fri, 20 Nov 2020 17:56:18 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2] crypto: arm64/gcm - move authentication tag check to
 SIMD domain
Message-ID: <20201120065618.GB20581@gondor.apana.org.au>
References: <20201110091042.2847-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110091042.2847-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Nov 10, 2020 at 10:10:42AM +0100, Ard Biesheuvel wrote:
> Instead of copying the calculated authentication tag to memory and
> calling crypto_memneq() to verify it, use vector bytewise compare and
> min across vector instructions to decide whether the tag is valid. This
> is more efficient, and given that the tag is only transiently held in a
> NEON register, it is also safer, given that calculated tags for failed
> decryptions should be withheld.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> v2: drop superfluous ')'
> 
>  arch/arm64/crypto/ghash-ce-core.S | 15 +++++++
>  arch/arm64/crypto/ghash-ce-glue.c | 46 ++++++++++++--------
>  2 files changed, 43 insertions(+), 18 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

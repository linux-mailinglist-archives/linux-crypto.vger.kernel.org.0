Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA6B341B04
	for <lists+linux-crypto@lfdr.de>; Fri, 19 Mar 2021 12:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhCSLE2 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 19 Mar 2021 07:04:28 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60750 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230355AbhCSLEF (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 19 Mar 2021 07:04:05 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lNCv3-00087G-UB; Fri, 19 Mar 2021 22:03:55 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 19 Mar 2021 22:03:53 +1100
Date:   Fri, 19 Mar 2021 22:03:53 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nicolas Pitre <nico@fluxnic.net>,
        Eric Biggers <ebiggers@google.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 0/2] crypto: arm - clean up redundant helper macros
Message-ID: <20210319110353.GA8367@gondor.apana.org.au>
References: <20210310101421.173689-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310101421.173689-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Mar 10, 2021 at 11:14:19AM +0100, Ard Biesheuvel wrote:
> Now that ARM's asm/assembler.h provides mov_l and rev_l macros, let's get
> rid of the locally defined ones that live in the ChaCha and AES crypto code.
> 
> Changes since v2:
> - fix rev_32->rev_l in the patch subject lines
> - add Eric's ack
> 
> Changes since v1:
> - drop the patch that introduces rev_l, it has been merged in v5.12-rc
> - rev_32 was renamed to rev_l, so both patches were updated to reflect that
> - add acks from Nico, Geert and Linus
> 
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Eric Biggers <ebiggers@google.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> 
> Ard Biesheuvel (2):
>   crypto: arm/aes-scalar - switch to common rev_l/mov_l macros
>   crypto: arm/chacha-scalar - switch to common rev_l macro
> 
>  arch/arm/crypto/aes-cipher-core.S    | 42 +++++--------------
>  arch/arm/crypto/chacha-scalar-core.S | 43 ++++++--------------
>  2 files changed, 23 insertions(+), 62 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

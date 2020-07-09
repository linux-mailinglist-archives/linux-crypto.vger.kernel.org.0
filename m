Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828F4219FE5
	for <lists+linux-crypto@lfdr.de>; Thu,  9 Jul 2020 14:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgGIMUV (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 9 Jul 2020 08:20:21 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:36016 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgGIMUV (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 9 Jul 2020 08:20:21 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jtVXE-0003JN-OL; Thu, 09 Jul 2020 22:20:17 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 09 Jul 2020 22:20:16 +1000
Date:   Thu, 9 Jul 2020 22:20:16 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH 0/5] crypto: clean up ARM/arm64 glue code for GHASH and
 GCM
Message-ID: <20200709122016.GA17502@gondor.apana.org.au>
References: <20200629073925.127538-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629073925.127538-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jun 29, 2020 at 09:39:20AM +0200, Ard Biesheuvel wrote:
> Get rid of pointless indirect calls where the target of the call is decided
> at boot and never changes. Also, make the size of the key struct variable,
> and only carry the extra keys needed for aggregation when using a version
> of the algorithm that makes use of them.
> 
> Ard Biesheuvel (5):
>   crypto: arm64/ghash - drop PMULL based shash
>   crypto: arm64/gcm - disentangle ghash and gcm setkey() routines
>   crypto: arm64/gcm - use variably sized key struct
>   crypto: arm64/gcm - use inline helper to suppress indirect calls
>   crypto: arm/ghash - use variably sized key struct
> 
>  arch/arm/crypto/ghash-ce-glue.c   |  51 ++--
>  arch/arm64/crypto/ghash-ce-glue.c | 257 +++++++-------------
>  2 files changed, 118 insertions(+), 190 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B06219AB0
	for <lists+linux-crypto@lfdr.de>; Thu,  9 Jul 2020 10:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgGIIWE (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 9 Jul 2020 04:22:04 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35076 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbgGIIWE (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 9 Jul 2020 04:22:04 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jtRoe-000729-CB; Thu, 09 Jul 2020 18:22:01 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 09 Jul 2020 18:22:00 +1000
Date:   Thu, 9 Jul 2020 18:22:00 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH 5/5] crypto: arm/ghash - use variably sized key struct
Message-ID: <20200709082200.GA1892@gondor.apana.org.au>
References: <20200629073925.127538-1-ardb@kernel.org>
 <20200629073925.127538-6-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629073925.127538-6-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jun 29, 2020 at 09:39:25AM +0200, Ard Biesheuvel wrote:
> Of the two versions of GHASH that the ARM driver implements, only one
> performs aggregation, and so the other one has no use for the powers
> of H to be precomputed, or space to be allocated for them in the key
> struct. So make the context size dependent on which version is being
> selected, and while at it, use a static key to carry this decision,
> and get rid of the function pointer.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm/crypto/ghash-ce-glue.c | 51 +++++++++-----------
>  1 file changed, 24 insertions(+), 27 deletions(-)

This introduces some new sparse warnings:

../arch/arm/crypto/ghash-ce-glue.c:67:65: warning: incorrect type in argument 4 (different modifiers)
../arch/arm/crypto/ghash-ce-glue.c:67:65:    expected unsigned long long const [usertype] ( *h )[2]
../arch/arm/crypto/ghash-ce-glue.c:67:65:    got unsigned long long [usertype] ( * )[2]
../arch/arm/crypto/ghash-ce-glue.c:69:64: warning: incorrect type in argument 4 (different modifiers)
../arch/arm/crypto/ghash-ce-glue.c:69:64:    expected unsigned long long const [usertype] ( *h )[2]
../arch/arm/crypto/ghash-ce-glue.c:69:64:    got unsigned long long [usertype] ( * )[2]

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F982CE884
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Dec 2020 08:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgLDHQG (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Dec 2020 02:16:06 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:60972 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbgLDHQG (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Dec 2020 02:16:06 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kl5JF-0006dB-Us; Fri, 04 Dec 2020 18:15:19 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 04 Dec 2020 18:15:17 +1100
Date:   Fri, 4 Dec 2020 18:15:17 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: ecdh - avoid unaligned accesses in
 ecdh_set_secret()
Message-ID: <20201204071517.GA31775@gondor.apana.org.au>
References: <20201124104719.13415-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124104719.13415-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Nov 24, 2020 at 11:47:19AM +0100, Ard Biesheuvel wrote:
> ecdh_set_secret() casts a void* pointer to a const u64* in order to
> feed it into ecc_is_key_valid(). This is not generally permitted by
> the C standard, and leads to actual misalignment faults on ARMv6
> cores. In some cases, these are fixed up in software, but this still
> leads to performance hits that are entirely avoidable.
> 
> So let's copy the key into the ctx buffer first, which we will do
> anyway in the common case, and which guarantees correct alignment.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  crypto/ecdh.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

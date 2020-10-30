Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E9729FDF9
	for <lists+linux-crypto@lfdr.de>; Fri, 30 Oct 2020 07:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgJ3Gs0 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 30 Oct 2020 02:48:26 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60464 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgJ3Gs0 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 30 Oct 2020 02:48:26 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kYOCw-0004on-FN; Fri, 30 Oct 2020 17:48:19 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 30 Oct 2020 17:48:18 +1100
Date:   Fri, 30 Oct 2020 17:48:18 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] crypto: talitos - Endianess in current_desc_hdr()
Message-ID: <20201030064818.GB25453@gondor.apana.org.au>
References: <facca5935decb8ddefa4c4898b2aeedc7ec4f860.1602149660.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <facca5935decb8ddefa4c4898b2aeedc7ec4f860.1602149660.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Oct 08, 2020 at 09:34:55AM +0000, Christophe Leroy wrote:
> current_desc_hdr() compares the value of the current descriptor
> with the next_desc member of the talitos_desc struct.
> 
> While the current descriptor is obtained from in_be32() which
> return CPU ordered bytes, next_desc member is in big endian order.
> 
> Convert the current descriptor into big endian before comparing it
> with next_desc.
> 
> This fixes a sparse warning.
> 
> Fixes: 37b5e8897eb5 ("crypto: talitos - chain in buffered data for ahash on SEC1")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/crypto/talitos.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

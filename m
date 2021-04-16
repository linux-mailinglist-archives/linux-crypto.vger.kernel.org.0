Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAF6361EDA
	for <lists+linux-crypto@lfdr.de>; Fri, 16 Apr 2021 13:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242604AbhDPLe3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 16 Apr 2021 07:34:29 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:53170 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235505AbhDPLe2 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 16 Apr 2021 07:34:28 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lXMjT-0003am-Jc; Fri, 16 Apr 2021 21:33:56 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 16 Apr 2021 21:33:55 +1000
Date:   Fri, 16 Apr 2021 21:33:55 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] crypto: crc32-generic - Use SPDX-License-Identifier
Message-ID: <20210416113355.GP16633@gondor.apana.org.au>
References: <c7fb3d1f92d95cedd74b5caff8dbfe2f16370814.1618086551.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7fb3d1f92d95cedd74b5caff8dbfe2f16370814.1618086551.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Apr 10, 2021 at 10:30:16PM +0200, Christophe JAILLET wrote:
> Use SPDX-License-Identifier: GPL-2.0-only, instead of hand writing it.
> 
> This also removes a reference to http://www.xyratex.com which seems to be
> down.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  crypto/crc32_generic.c | 24 +-----------------------
>  1 file changed, 1 insertion(+), 23 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

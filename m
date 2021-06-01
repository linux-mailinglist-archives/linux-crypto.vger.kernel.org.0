Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6FE393DD3
	for <lists+linux-crypto@lfdr.de>; Fri, 28 May 2021 09:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbhE1H2k (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 28 May 2021 03:28:40 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50280 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235358AbhE1H2a (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 28 May 2021 03:28:30 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lmWtT-0003ff-3G; Fri, 28 May 2021 15:26:55 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lmWtS-0001zw-5v; Fri, 28 May 2021 15:26:54 +0800
Date:   Fri, 28 May 2021 15:26:54 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: DRBG - switch to HMAC SHA512 DRBG as default DRBG
Message-ID: <20210528072654.GJ7392@gondor.apana.org.au>
References: <3171520.o5pSzXOnS6@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3171520.o5pSzXOnS6@positron.chronox.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, May 20, 2021 at 09:31:11PM +0200, Stephan M�ller wrote:
> The default DRBG is the one that has the highest priority. The priority
> is defined based on the order of the list drbg_cores[] where the highest
> priority is given to the last entry by drbg_fill_array.
> 
> With this patch the default DRBG is switched from HMAC SHA256 to HMAC
> SHA512 to support compliance with SP800-90B and SP800-90C (current
> draft).
> 
> The user of the crypto API is completely unaffected by the change.
> 
> Signed-off-by: Stephan Mueller <smueller@chronox.de>
> ---
>  crypto/drbg.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

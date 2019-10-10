Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47027D2A20
	for <lists+linux-crypto@lfdr.de>; Thu, 10 Oct 2019 14:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387662AbfJJM45 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 10 Oct 2019 08:56:57 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37658 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733300AbfJJM45 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 10 Oct 2019 08:56:57 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iIXzr-0001ts-7h; Thu, 10 Oct 2019 23:56:48 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 10 Oct 2019 23:56:43 +1100
Date:   Thu, 10 Oct 2019 23:56:43 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tudor.Ambarus@microchip.com
Cc:     Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: atmel-aes - Fix IV handling when req->nbytes <
 ivsize
Message-ID: <20191010125643.GG31566@gondor.apana.org.au>
References: <20191004085528.12323-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004085528.12323-1-tudor.ambarus@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Oct 04, 2019 at 08:55:37AM +0000, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> commit 394a9e044702 ("crypto: cfb - add missing 'chunksize' property")
> adds a test vector where the input length is smaller than the IV length
> (the second test vector). This revealed a NULL pointer dereference in
> the atmel-aes driver, that is caused by passing an incorrect offset in
> scatterwalk_map_and_copy() when atmel_aes_complete() is called.
> 
> Do not save the IV in req->info of ablkcipher_request (or equivalently
> req->iv of skcipher_request) when req->nbytes < ivsize, because the IV
> will not be further used.
> 
> While touching the code, modify the type of ivsize from int to
> unsigned int, to comply with the return type of
> crypto_ablkcipher_ivsize().
> 
> Fixes: 91308019ecb4 ("crypto: atmel-aes - properly set IV after {en,de}crypt")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/crypto/atmel-aes.c | 53 ++++++++++++++++++++++++++--------------------
>  1 file changed, 30 insertions(+), 23 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

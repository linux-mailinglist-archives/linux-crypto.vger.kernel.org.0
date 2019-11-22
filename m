Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4915E106E8C
	for <lists+linux-crypto@lfdr.de>; Fri, 22 Nov 2019 12:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKVLJc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 22 Nov 2019 06:09:32 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:53330 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731399AbfKVLDF (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 22 Nov 2019 06:03:05 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iY6iB-0004Ri-J1; Fri, 22 Nov 2019 19:02:51 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iY6iA-0002dc-SI; Fri, 22 Nov 2019 19:02:50 +0800
Date:   Fri, 22 Nov 2019 19:02:50 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, cyrille.pitchen@atmel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 -next] crypto: atmel - Fix build error of
 CRYPTO_AUTHENC
Message-ID: <20191122110250.3cs2fmgpjptxmbt6@gondor.apana.org.au>
References: <20191112072405.40268-1-yuehaibing@huawei.com>
 <20191113095550.15104-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113095550.15104-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Nov 13, 2019 at 05:55:50PM +0800, YueHaibing wrote:
> If CRYPTO_DEV_ATMEL_AUTHENC is m, CRYPTO_DEV_ATMEL_SHA is m,
> but CRYPTO_DEV_ATMEL_AES is y, building will fail:
> 
> drivers/crypto/atmel-aes.o: In function `atmel_aes_authenc_init_tfm':
> atmel-aes.c:(.text+0x670): undefined reference to `atmel_sha_authenc_get_reqsize'
> atmel-aes.c:(.text+0x67a): undefined reference to `atmel_sha_authenc_spawn'
> drivers/crypto/atmel-aes.o: In function `atmel_aes_authenc_setkey':
> atmel-aes.c:(.text+0x7e5): undefined reference to `atmel_sha_authenc_setkey'
> 
> Make CRYPTO_DEV_ATMEL_AUTHENC depend on CRYPTO_DEV_ATMEL_AES,
> and select CRYPTO_DEV_ATMEL_SHA and CRYPTO_AUTHENC for it under there.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
> Fixes: 89a82ef87e01 ("crypto: atmel-authenc - add support to...")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
> v3: fix log typo
> v2: make CRYPTO_DEV_ATMEL_AUTHENC depends on DEV_ATMEL_AES
> ---
>  drivers/crypto/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

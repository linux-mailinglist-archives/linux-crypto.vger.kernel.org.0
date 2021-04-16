Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972E3361EB4
	for <lists+linux-crypto@lfdr.de>; Fri, 16 Apr 2021 13:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbhDPLb3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 16 Apr 2021 07:31:29 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:53072 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhDPLb3 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 16 Apr 2021 07:31:29 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lXMgb-0003Ov-Qt; Fri, 16 Apr 2021 21:30:59 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 16 Apr 2021 21:30:57 +1000
Date:   Fri, 16 Apr 2021 21:30:57 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 0/5] Remove redundant dev_err call
Message-ID: <20210416113057.GG16633@gondor.apana.org.au>
References: <20210407141819.32588-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407141819.32588-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Apr 07, 2021 at 10:18:14PM +0800, YueHaibing wrote:
> This patchset remove some redundant dev_err calls
> 
> YueHaibing (5):
>   crypto: atmel-tdes - Remove redundant dev_err call in
>     atmel_tdes_probe()
>   crypto: img-hash - Remove redundant dev_err call in img_hash_probe()
>   crypto: ux500 - Remove redundant dev_err calls
>   crypto: keembay - Remove redundant dev_err calls
>   crypto: ccree - Remove redundant dev_err call in init_cc_resources()
> 
>  drivers/crypto/atmel-tdes.c                   | 1 -
>  drivers/crypto/ccree/cc_driver.c              | 4 +---
>  drivers/crypto/img-hash.c                     | 3 ---
>  drivers/crypto/keembay/keembay-ocs-aes-core.c | 4 +---
>  drivers/crypto/keembay/keembay-ocs-hcu-core.c | 4 +---
>  drivers/crypto/ux500/cryp/cryp_core.c         | 1 -
>  drivers/crypto/ux500/hash/hash_core.c         | 1 -
>  7 files changed, 3 insertions(+), 15 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

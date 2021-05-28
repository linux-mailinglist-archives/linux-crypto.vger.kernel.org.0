Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A12F393DC2
	for <lists+linux-crypto@lfdr.de>; Fri, 28 May 2021 09:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhE1H1Y (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 28 May 2021 03:27:24 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50222 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229642AbhE1H1X (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 28 May 2021 03:27:23 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lmWsM-0003af-1Y; Fri, 28 May 2021 15:25:46 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lmWsK-0001xb-Ij; Fri, 28 May 2021 15:25:44 +0800
Date:   Fri, 28 May 2021 15:25:44 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] crypto: qce - Fix some error handling path
Message-ID: <20210528072544.GE7392@gondor.apana.org.au>
References: <20210519141650.3059054-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519141650.3059054-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, May 19, 2021 at 02:16:50PM +0000, Wei Yongjun wrote:
> Fix to return negative error code from the error handling
> cases instead of 0.
> 
> Fixes: 9363efb4181c ("crypto: qce - Add support for AEAD algorithms")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/crypto/qce/aead.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

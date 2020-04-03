Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7326219CF6E
	for <lists+linux-crypto@lfdr.de>; Fri,  3 Apr 2020 06:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732830AbgDCEmR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 3 Apr 2020 00:42:17 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51584 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732595AbgDCEmR (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 3 Apr 2020 00:42:17 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jKE9B-00075o-SB; Fri, 03 Apr 2020 15:41:38 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 Apr 2020 15:41:37 +1100
Date:   Fri, 3 Apr 2020 15:41:37 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, wangzhou1@hisilicon.com,
        Jonathan.Cameron@huawei.com, xuzaibo@huawei.com,
        shiju.jose@huawei.com, ebiggers@google.com, yaohongbo@huawei.com,
        maowenan@huawei.com, arnd@arndb.de, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] crypto: hisilicon - Fix build error
Message-ID: <20200403044137.GA26315@gondor.apana.org.au>
References: <20200330083643.28824-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330083643.28824-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Mar 30, 2020 at 04:36:43PM +0800, YueHaibing wrote:
> When UACCE is m, CRYPTO_DEV_HISI_QM cannot be built-in.
> But CRYPTO_DEV_HISI_QM is selected by CRYPTO_DEV_HISI_SEC2
> and CRYPTO_DEV_HISI_HPRE unconditionally, which may leads this:
> 
> drivers/crypto/hisilicon/qm.o: In function 'qm_alloc_uacce':
> drivers/crypto/hisilicon/qm.c:1579: undefined reference to 'uacce_alloc'
> 
> Add Kconfig dependency to enforce usable configurations.
> 
> Fixes: 47c16b449921 ("crypto: hisilicon - qm depends on UACCE")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/crypto/hisilicon/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

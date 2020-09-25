Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF20278249
	for <lists+linux-crypto@lfdr.de>; Fri, 25 Sep 2020 10:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgIYILi (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 25 Sep 2020 04:11:38 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:53180 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbgIYILh (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 25 Sep 2020 04:11:37 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kLipD-00072d-0j; Fri, 25 Sep 2020 18:11:28 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 25 Sep 2020 18:11:26 +1000
Date:   Fri, 25 Sep 2020 18:11:26 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] crypto: atmel-aes - convert to use be32_add_cpu()
Message-ID: <20200925081126.GC6381@gondor.apana.org.au>
References: <20200914041746.3701896-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914041746.3701896-1-liushixin2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Sep 14, 2020 at 12:17:46PM +0800, Liu Shixin wrote:
> Convert cpu_to_be32(be32_to_cpu(E1) + E2) to use be32_add_cpu().
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/crypto/atmel-aes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

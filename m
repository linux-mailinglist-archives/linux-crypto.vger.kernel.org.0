Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2C2233FF6
	for <lists+linux-crypto@lfdr.de>; Fri, 31 Jul 2020 09:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbgGaH3A (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 31 Jul 2020 03:29:00 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:39896 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731601AbgGaH27 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 31 Jul 2020 03:28:59 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k1PTI-0001Jw-Jp; Fri, 31 Jul 2020 17:28:53 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 31 Jul 2020 17:28:52 +1000
Date:   Fri, 31 Jul 2020 17:28:52 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Keerthy <j-keerthy@ti.com>, linux-crypto@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] crypto: sa2ul - fix wrong pointer passed to
 PTR_ERR()
Message-ID: <20200731072852.GA17380@gondor.apana.org.au>
References: <20200725063440.172238-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725063440.172238-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Jul 25, 2020 at 06:34:40AM +0000, Wei Yongjun wrote:
> PTR_ERR should access the value just tested by IS_ERR, otherwise
> the wrong error code will be returned.
> 
> Fixes: 7694b6ca649f ("crypto: sa2ul - Add crypto driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/crypto/sa2ul.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Someone has sent a similar patch already.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

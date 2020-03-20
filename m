Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48F2618C61D
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Mar 2020 04:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgCTDvi (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 19 Mar 2020 23:51:38 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:33928 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbgCTDvi (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 19 Mar 2020 23:51:38 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jF8gx-0001Y1-PC; Fri, 20 Mar 2020 14:51:28 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Mar 2020 14:51:27 +1100
Date:   Fri, 20 Mar 2020 14:51:27 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Ayush Sawal <ayush.sawal@chelsio.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Rohit Maheshwari <rohitm@chelsio.com>,
        linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] crypto: chelsio - remove set but not used variable
 'adap'
Message-ID: <20200320035127.GG27372@gondor.apana.org.au>
References: <20200314104441.79953-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314104441.79953-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Mar 14, 2020 at 10:44:41AM +0000, YueHaibing wrote:
> drivers/crypto/chelsio/chcr_algo.c: In function 'chcr_device_init':
> drivers/crypto/chelsio/chcr_algo.c:1440:18: warning:
>  variable 'adap' set but not used [-Wunused-but-set-variable]
>  
> commit 567be3a5d227 ("crypto: chelsio - Use multiple txq/rxq per tfm
> to process the requests") involved this unused variable.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/crypto/chelsio/chcr_algo.c | 2 --
>  1 file changed, 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

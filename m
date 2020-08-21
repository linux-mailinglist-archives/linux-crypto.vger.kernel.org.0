Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2E024D014
	for <lists+linux-crypto@lfdr.de>; Fri, 21 Aug 2020 09:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgHUH4Y (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 21 Aug 2020 03:56:24 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49956 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgHUH4X (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 21 Aug 2020 03:56:23 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k91u6-0003wk-JG; Fri, 21 Aug 2020 17:56:03 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 21 Aug 2020 17:56:02 +1000
Date:   Fri, 21 Aug 2020 17:56:02 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     mpm@selenic.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        zhouyanjie@wanyeetech.com, prasannatsmkumar@gmail.com,
        linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] crypto: ingenic - Drop kfree for memory allocated with
 devm_kzalloc
Message-ID: <20200821075602.GF25143@gondor.apana.org.au>
References: <20200804081153.45342-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804081153.45342-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Aug 04, 2020 at 08:11:53AM +0000, Wei Yongjun wrote:
> It's not necessary to free memory allocated with devm_kzalloc
> and using kfree leads to a double free.
> 
> Fixes: 190873a0ea45 ("crypto: ingenic - Add hardware RNG for Ingenic JZ4780 and X1000")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/char/hw_random/ingenic-rng.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

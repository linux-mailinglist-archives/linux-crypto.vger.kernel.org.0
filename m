Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6244740F057
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Sep 2021 05:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240837AbhIQDWS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Sep 2021 23:22:18 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55252 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243767AbhIQDWS (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Sep 2021 23:22:18 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mR4Qk-0006EJ-9G; Fri, 17 Sep 2021 11:20:50 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mR4Qi-0001lY-T9; Fri, 17 Sep 2021 11:20:48 +0800
Date:   Fri, 17 Sep 2021 11:20:48 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Deepak Saxena <dsaxena@plexity.net>,
        Matt Mackall <mpm@selenic.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hw_random: ixp4xx: Make use of the helper function
 devm_platform_ioremap_resource()
Message-ID: <20210917032048.GF6559@gondor.apana.org.au>
References: <20210907074042.1992-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907074042.1992-1-caihuoqing@baidu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Sep 07, 2021 at 03:40:41PM +0800, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/char/hw_random/ixp4xx-rng.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

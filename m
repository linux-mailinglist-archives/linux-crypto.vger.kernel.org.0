Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD3F3596C6
	for <lists+linux-crypto@lfdr.de>; Fri,  9 Apr 2021 09:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhDIHwp (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 9 Apr 2021 03:52:45 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:52030 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230181AbhDIHwm (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 9 Apr 2021 03:52:42 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lUlwJ-0006H2-Sz; Fri, 09 Apr 2021 17:52:29 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 09 Apr 2021 17:52:27 +1000
Date:   Fri, 9 Apr 2021 17:52:27 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ruiqi Gong <gongruiqi1@huawei.com>
Cc:     Zaibo Xu <xuzaibo@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>
Subject: Re: [PATCH -next] crypto: hisilicon/hpre - fix a typo in
 hpre_crypto.c
Message-ID: <20210409075227.GE31447@gondor.apana.org.au>
References: <20210330115124.15508-1-gongruiqi1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330115124.15508-1-gongruiqi1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Mar 30, 2021 at 07:51:24AM -0400, Ruiqi Gong wrote:
> Do a trivial typo fix.
> s/discribed/described
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ruiqi Gong <gongruiqi1@huawei.com>
> ---
>  drivers/crypto/hisilicon/hpre/hpre_crypto.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E29BDBF45
	for <lists+linux-crypto@lfdr.de>; Fri, 18 Oct 2019 10:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504696AbfJRICx (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 18 Oct 2019 04:02:53 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37302 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729376AbfJRICw (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 18 Oct 2019 04:02:52 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iLNDW-0001qP-2k; Fri, 18 Oct 2019 19:02:35 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Oct 2019 19:02:34 +1100
Date:   Fri, 18 Oct 2019 19:02:34 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] crypto: Use PTR_ERR_OR_ZERO in
 safexcel_xcbcmac_cra_init()
Message-ID: <20191018080233.GC25128@gondor.apana.org.au>
References: <20191009120621.45834-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009120621.45834-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Oct 09, 2019 at 12:06:21PM +0000, YueHaibing wrote:
> Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/crypto/inside-secure/safexcel_hash.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A913596DB
	for <lists+linux-crypto@lfdr.de>; Fri,  9 Apr 2021 09:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhDIHyq (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 9 Apr 2021 03:54:46 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:52084 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231952AbhDIHyn (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 9 Apr 2021 03:54:43 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lUlyD-0006Lt-Cs; Fri, 09 Apr 2021 17:54:26 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 09 Apr 2021 17:54:25 +1000
Date:   Fri, 9 Apr 2021 17:54:25 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Colin King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] crypto: sa2ul: Fix memory leak of rxd
Message-ID: <20210409075425.GI31447@gondor.apana.org.au>
References: <20210401152839.2016363-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401152839.2016363-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Apr 01, 2021 at 04:28:39PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are two error return paths that are not freeing rxd and causing
> memory leaks.  Fix these.
> 
> Addresses-Coverity: ("Resource leak")
> Fixes: 00c9211f60db ("crypto: sa2ul - Fix DMA mapping API usage")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> 
> V2: Fix typo in $SUBJECT
> 
> ---
>  drivers/crypto/sa2ul.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

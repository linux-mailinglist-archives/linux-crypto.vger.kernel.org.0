Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A79B3AAE4F
	for <lists+linux-crypto@lfdr.de>; Thu, 17 Jun 2021 10:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhFQIDb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 17 Jun 2021 04:03:31 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50728 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhFQIDZ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 17 Jun 2021 04:03:25 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1ltmxe-0003ib-Mc; Thu, 17 Jun 2021 16:01:14 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ltmxe-0002nt-K4; Thu, 17 Jun 2021 16:01:14 +0800
Date:   Thu, 17 Jun 2021 16:01:14 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] crypto: remove CRYPTOA_U32 and related functions
Message-ID: <20210617080114.GD10662@gondor.apana.org.au>
References: <20210611020100.2008894-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611020100.2008894-1-liushixin2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jun 11, 2021 at 10:01:00AM +0800, Liu Shixin wrote:
> According to the advice of Eric and Herbert, type CRYPTOA_U32
> has been unused for over a decade, so remove the code related to
> CRYPTOA_U32.
> 
> After removing CRYPTOA_U32, the type of the variable attrs can be
> changed from union to struct.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> ---
> v1->v2: Fix format issue.
> 
>  crypto/algapi.c         | 18 ------------------
>  crypto/algboss.c        | 31 ++++++-------------------------
>  include/crypto/algapi.h |  1 -
>  include/linux/crypto.h  |  5 -----
>  4 files changed, 6 insertions(+), 49 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

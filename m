Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009B4367B5D
	for <lists+linux-crypto@lfdr.de>; Thu, 22 Apr 2021 09:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhDVHrT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 22 Apr 2021 03:47:19 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:48740 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235146AbhDVHrS (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 22 Apr 2021 03:47:18 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lZU2s-00034p-AT; Thu, 22 Apr 2021 17:46:43 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 22 Apr 2021 17:46:42 +1000
Date:   Thu, 22 Apr 2021 17:46:42 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Vinay Kumar Yadav <vinay.yadav@chelsio.com>
Cc:     linux-crypto@vger.kernel.org, davem@davemloft.net,
        secdev@chelsio.com
Subject: Re: [PATCH] chelsio/chcr: Remove useless MODULE_VERSION
Message-ID: <20210422074642.GF14354@gondor.apana.org.au>
References: <20210415100607.422838-1-vinay.yadav@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415100607.422838-1-vinay.yadav@chelsio.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Apr 15, 2021 at 03:36:07PM +0530, Vinay Kumar Yadav wrote:
> kernel version describes module state more accurately.
> hence remove chcr versioning.
> 
> Signed-off-by: Vinay Kumar Yadav <vinay.yadav@chelsio.com>
> ---
>  drivers/crypto/chelsio/chcr_core.c | 3 +--
>  drivers/crypto/chelsio/chcr_core.h | 1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

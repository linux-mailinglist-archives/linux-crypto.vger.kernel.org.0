Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4670B2F5AF0
	for <lists+linux-crypto@lfdr.de>; Thu, 14 Jan 2021 07:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbhANGsY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 14 Jan 2021 01:48:24 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:42232 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbhANGsY (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 14 Jan 2021 01:48:24 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kzwPx-00088M-49; Thu, 14 Jan 2021 17:47:38 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 14 Jan 2021 17:47:36 +1100
Date:   Thu, 14 Jan 2021 17:47:36 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Declan Murphy <declan.murphy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] crypto: keembay-ocs-hcu - Fix a WARN() message
Message-ID: <20210114064736.GJ12584@gondor.apana.org.au>
References: <X/WB9IlpyIi+5p5s@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/WB9IlpyIi+5p5s@mwanda>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Jan 06, 2021 at 12:25:08PM +0300, Dan Carpenter wrote:
> The first argument to WARN() is a condition and the messages is the
> second argument is the string, so this WARN() will only display the
> __func__ part of the message.
> 
> Fixes: ae832e329a8d ("crypto: keembay-ocs-hcu - Add HMAC support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/crypto/keembay/keembay-ocs-hcu-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

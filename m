Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0654B338E6F
	for <lists+linux-crypto@lfdr.de>; Fri, 12 Mar 2021 14:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhCLNMn (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 12 Mar 2021 08:12:43 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:54490 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231450AbhCLNMW (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 12 Mar 2021 08:12:22 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lKhaJ-0006ES-2N; Sat, 13 Mar 2021 00:12:08 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 13 Mar 2021 00:12:06 +1100
Date:   Sat, 13 Mar 2021 00:12:06 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Colin King <colin.king@canonical.com>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: sun8i-ss: Fix memory leak of object d when
 dma_iv fails to map
Message-ID: <20210312131206.GE31502@gondor.apana.org.au>
References: <20210302163446.21047-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302163446.21047-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Mar 02, 2021 at 04:34:46PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case where the dma_iv mapping fails, the return error path leaks
> the memory allocated to object d.  Fix this by adding a new error return
> label and jumping to this to ensure d is free'd before the return.
> 
> Addresses-Coverity: ("Resource leak")
> Fixes: ac2614d721de ("crypto: sun8i-ss - Add support for the PRNG")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

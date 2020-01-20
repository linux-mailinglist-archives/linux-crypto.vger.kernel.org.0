Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA6AA142F12
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Jan 2020 16:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgATP4r (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 20 Jan 2020 10:56:47 -0500
Received: from charlotte.tuxdriver.com ([70.61.120.58]:52650 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATP4r (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 20 Jan 2020 10:56:47 -0500
Received: from [107.15.85.130] (helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1itZPe-0003o3-Rx; Mon, 20 Jan 2020 10:56:33 -0500
Date:   Mon, 20 Jan 2020 10:56:21 -0500
From:   Neil Horman <nhorman@tuxdriver.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] crypto: rng - Fix a refcounting bug in crypto_rng_reset()
Message-ID: <20200120155621.GA22044@hmswarspite.think-freely.org>
References: <20200120143804.pbmnrh72v2gogx43@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120143804.pbmnrh72v2gogx43@kili.mountain>
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jan 20, 2020 at 05:38:04PM +0300, Dan Carpenter wrote:
> We need to decrement this refcounter on these error paths.
> 
> Fixes: f7d76e05d058 ("crypto: user - fix use_after_free of struct xxx_request")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  crypto/rng.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/crypto/rng.c b/crypto/rng.c
> index 1e21231f71c9..1490d210f1a1 100644
> --- a/crypto/rng.c
> +++ b/crypto/rng.c
> @@ -37,12 +37,16 @@ int crypto_rng_reset(struct crypto_rng *tfm, const u8 *seed, unsigned int slen)
>  	crypto_stats_get(alg);
>  	if (!seed && slen) {
>  		buf = kmalloc(slen, GFP_KERNEL);
> -		if (!buf)
> +		if (!buf) {
> +			crypto_alg_put(alg);
>  			return -ENOMEM;
> +		}
>  
>  		err = get_random_bytes_wait(buf, slen);
> -		if (err)
> +		if (err) {
> +			crypto_alg_put(alg);
>  			goto out;
> +		}
>  		seed = buf;
>  	}
>  
> -- 
> 2.11.0
> 
> 
LGTM
Acked-by: Neil Horman <nhorman@tuxdriver.com>

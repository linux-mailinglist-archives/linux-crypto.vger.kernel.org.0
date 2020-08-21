Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC27824CB77
	for <lists+linux-crypto@lfdr.de>; Fri, 21 Aug 2020 05:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgHUDmN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 20 Aug 2020 23:42:13 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49722 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbgHUDmN (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 20 Aug 2020 23:42:13 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k8xwP-0008HY-MW; Fri, 21 Aug 2020 13:42:10 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 21 Aug 2020 13:42:09 +1000
Date:   Fri, 21 Aug 2020 13:42:09 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Amit Shah <amit@kernel.org>
Subject: Re: [PATCH] hwrng: core - allocate a one page buffer
Message-ID: <20200821034209.GA25401@gondor.apana.org.au>
References: <20200806152814.1325776-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806152814.1325776-1-lvivier@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Aug 06, 2020 at 05:28:14PM +0200, Laurent Vivier wrote:
.
> +static size_t rng_max_buffer_size(struct hwrng *rng)
> +{
> +	size_t size;
> +
> +	size = max_t(size_t, rng->buffer_size, SMP_CACHE_BYTES);
> +
> +	/* rng_buffer can store up to PAGE_SIZE */
> +	return min(PAGE_SIZE, size);
>  }

Rather than checking this on every read, just do it once at driver
registration time.

> @@ -614,11 +629,11 @@ static int __init hwrng_modinit(void)
>  	int ret;
>  
>  	/* kmalloc makes this safe for virt_to_page() in virtio_rng.c */
> -	rng_buffer = kmalloc(rng_buffer_size(), GFP_KERNEL);
> +	rng_buffer = (u8 *)get_zeroed_page(GFP_KERNEL);
>  	if (!rng_buffer)
>  		return -ENOMEM;

Why a zeroed page? Also please fix the out-of-sync comment.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

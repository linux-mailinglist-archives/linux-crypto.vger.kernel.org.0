Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AF33EA2A9
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Aug 2021 12:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbhHLKGA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 12 Aug 2021 06:06:00 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:52718 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234895AbhHLKF7 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 12 Aug 2021 06:05:59 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mE7Zz-0002tI-K9; Thu, 12 Aug 2021 18:04:51 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mE7Zl-0001K7-WA; Thu, 12 Aug 2021 18:04:38 +0800
Date:   Thu, 12 Aug 2021 18:04:37 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crypto: sun8i-ce: fix multiple memory leaks in
 sun8i_ce_hash_run
Message-ID: <20210812100437.GA5055@gondor.apana.org.au>
References: <20210803063149.2821093-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803063149.2821093-1-mudongliangabcd@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Aug 03, 2021 at 02:31:38PM +0800, Dongliang Mu wrote:
>
> -theend:
> -	kfree(buf);
> +err_result:
>  	kfree(result);
> -	crypto_finalize_hash_request(engine, breq, err);
> +err_buf:
> +	kfree(buf);
> +out:
> +	if (!err)
> +		crypto_finalize_hash_request(engine, breq, err);
>  	return 0;

This does not look right.  You're returning zero in case of an error

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

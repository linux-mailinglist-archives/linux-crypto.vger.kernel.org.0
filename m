Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052C6361EC3
	for <lists+linux-crypto@lfdr.de>; Fri, 16 Apr 2021 13:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242267AbhDPLcW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 16 Apr 2021 07:32:22 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:53100 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240600AbhDPLcV (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 16 Apr 2021 07:32:21 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lXMhI-0003Rk-B3; Fri, 16 Apr 2021 21:31:41 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 16 Apr 2021 21:31:40 +1000
Date:   Fri, 16 Apr 2021 21:31:40 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Shixin Liu <liushixin2@huawei.com>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 1/7] crypto: sun4i-ss - Fix PM reference leak when
 pm_runtime_get_sync() fails
Message-ID: <20210416113140.GI16633@gondor.apana.org.au>
References: <20210408071831.836638-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408071831.836638-1-liushixin2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Apr 08, 2021 at 03:18:31PM +0800, Shixin Liu wrote:
> pm_runtime_get_sync will increment pm usage counter even it failed.
> Forgetting to putting operation will result in reference leak here.
> Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> counter balanced.
> 
> Signed-off-by: Shixin Liu <liushixin2@huawei.com>
> ---
>  drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c | 2 +-
>  drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c   | 2 +-
>  drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c   | 2 +-
>  drivers/crypto/allwinner/sun4i-ss/sun4i-ss-prng.c   | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

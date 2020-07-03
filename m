Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABEF621331A
	for <lists+linux-crypto@lfdr.de>; Fri,  3 Jul 2020 06:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgGCEsj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 3 Jul 2020 00:48:39 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:40240 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgGCEsi (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 3 Jul 2020 00:48:38 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jrDc8-000819-82; Fri, 03 Jul 2020 14:47:53 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 Jul 2020 14:47:52 +1000
Date:   Fri, 3 Jul 2020 14:47:52 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Corentin Labbe <clabbe.montjoie@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: sun8i-ce - Fix runtime PM imbalance in
 sun8i_ce_cipher_init
Message-ID: <20200703044752.GA23200@gondor.apana.org.au>
References: <20200622024014.11347-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622024014.11347-1-dinghao.liu@zju.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jun 22, 2020 at 10:40:08AM +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> the call returns an error code. Thus a corresponding decrement is
> needed on the error handling path to keep the counter balanced.
> 
> Fix this by adding the missed function call.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

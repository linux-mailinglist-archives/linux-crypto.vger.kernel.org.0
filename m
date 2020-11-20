Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E8D2BA2C1
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Nov 2020 08:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgKTG6O (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Nov 2020 01:58:14 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:34234 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgKTG6N (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Nov 2020 01:58:13 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kg0Mz-0007lV-7s; Fri, 20 Nov 2020 17:58:10 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Nov 2020 17:58:09 +1100
Date:   Fri, 20 Nov 2020 17:58:09 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: omap-aes - Fix PM disable depth imbalance in
 omap_aes_probe
Message-ID: <20201120065809.GF20581@gondor.apana.org.au>
References: <20201113131728.2099091-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113131728.2099091-1-zhangqilong3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Nov 13, 2020 at 09:17:28PM +0800, Zhang Qilong wrote:
> The pm_runtime_enable will increase power disable depth.
> Thus a pairing decrement is needed on the error handling
> path to keep it balanced according to context.
> 
> Fixes: f7b2b5dd6a62a ("crypto: omap-aes - add error check for pm_runtime_get_sync")
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
>  drivers/crypto/omap-aes.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

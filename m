Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5B92A8D80
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Nov 2020 04:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgKFDa4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 5 Nov 2020 22:30:56 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:34042 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgKFDa4 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 5 Nov 2020 22:30:56 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kasSc-0005kn-Fz; Fri, 06 Nov 2020 14:30:47 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 06 Nov 2020 14:30:46 +1100
Date:   Fri, 6 Nov 2020 14:30:46 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org
Subject: Re: [PATCH -next] crypto: omap-aes - fix the reference count leak of
 omap device
Message-ID: <20201106033046.GA25372@gondor.apana.org.au>
References: <20201027132510.81076-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027132510.81076-1-zhangqilong3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Oct 27, 2020 at 09:25:10PM +0800, Zhang Qilong wrote:
> pm_runtime_get_sync() will increment  pm usage counter even
> when it returns an error code. We should call put operation
> in error handling paths of omap_aes_hw_init.
> 
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
>  drivers/crypto/omap-aes.c | 1 +
>  1 file changed, 1 insertion(+)

Your patch has already been applied:

commit 383e8a823014532ffd81c787ef9009f1c2bd3b79
Author: Zhang Qilong <zhangqilong3@huawei.com>
Date:   Fri Oct 16 17:05:36 2020 +0800

    crypto: omap-aes - fix the reference count leak of omap device

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

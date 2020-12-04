Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877932CE845
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Dec 2020 07:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgLDGpH (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Dec 2020 01:45:07 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:60766 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbgLDGpG (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Dec 2020 01:45:06 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kl4p5-0006Gg-QY; Fri, 04 Dec 2020 17:44:08 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 04 Dec 2020 17:44:07 +1100
Date:   Fri, 4 Dec 2020 17:44:07 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Wang Xiaojun <wangxiaojun11@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: omap-sham - fix several reference count leaks
 due to pm_runtime_get_sync
Message-ID: <20201204064407.GA26285@gondor.apana.org.au>
References: <20201123134115.2702127-1-wangxiaojun11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123134115.2702127-1-wangxiaojun11@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Nov 23, 2020 at 09:41:15PM +0800, Wang Xiaojun wrote:
> On calling pm_runtime_get_sync() the reference count of the device
> is incremented. In case of failure, should decrement the reference
> count before returning the error. So we fixed it by replacing it
> with pm_runtime_resume_and_get.
> 
> Signed-off-by: Wang Xiaojun <wangxiaojun11@huawei.com>
> ---
>  drivers/crypto/omap-sham.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

This function doesn't exist in the current cryptodev tree.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

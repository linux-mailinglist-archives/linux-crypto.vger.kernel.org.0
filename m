Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654311F7415
	for <lists+linux-crypto@lfdr.de>; Fri, 12 Jun 2020 08:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgFLGrb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 12 Jun 2020 02:47:31 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:38936 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbgFLGrb (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 12 Jun 2020 02:47:31 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jjdSI-0000ld-OU; Fri, 12 Jun 2020 16:46:23 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 Jun 2020 16:46:22 +1000
Date:   Fri, 12 Jun 2020 16:46:22 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Matt Mackall <mpm@selenic.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        YueHaibing <yuehaibing@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] hwrng: ks-sa - Fix runtime PM imbalance on error
Message-ID: <20200612064622.GA16987@gondor.apana.org.au>
References: <20200528072106.5191-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528072106.5191-1-dinghao.liu@zju.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, May 28, 2020 at 03:21:04PM +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> the call returns an error code. Thus a pairing decrement is needed
> on the error handling path to keep the counter balanced.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
> 
> Changelog:
> 
> v2: - Use pm_runtime_put_noidle() instead of pm_runtime_put_sync().
> ---
>  drivers/char/hw_random/ks-sa-rng.c | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

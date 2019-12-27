Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 347AA12B3FA
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Dec 2019 11:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfL0KiP (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 27 Dec 2019 05:38:15 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:60234 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfL0KiP (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 27 Dec 2019 05:38:15 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ikn0I-0007NS-4x; Fri, 27 Dec 2019 18:37:58 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ikn0E-0005mS-GD; Fri, 27 Dec 2019 18:37:54 +0800
Date:   Fri, 27 Dec 2019 18:37:54 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] crypto: sun4i-ss: make unexported sun4i_ss_pm_ops static
Message-ID: <20191227103754.khyipr5avcuhd4or@gondor.apana.org.au>
References: <20191217113024.2109457-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217113024.2109457-1-ben.dooks@codethink.co.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Dec 17, 2019 at 11:30:24AM +0000, Ben Dooks (Codethink) wrote:
> The sun4i_ss_pm_ops is not referenced outside the driver
> except via a pointer, so make it static to avoid the following
> warning:
> 
> drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c:276:25: warning: symbol 'sun4i_ss_pm_ops' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
> ---
> Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: YueHaibing <yuehaibing@huawei.com>
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

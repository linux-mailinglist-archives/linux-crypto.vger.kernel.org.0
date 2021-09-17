Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E46F40F051
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Sep 2021 05:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243818AbhIQDUa (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Sep 2021 23:20:30 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55244 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243721AbhIQDU2 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Sep 2021 23:20:28 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mR4Ol-00068C-Pl; Fri, 17 Sep 2021 11:18:47 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mR4Od-0001iq-Uw; Fri, 17 Sep 2021 11:18:39 +0800
Date:   Fri, 17 Sep 2021 11:18:39 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     mpm@selenic.com, broonie@kernel.org, zhouyanjie@wanyeetech.com,
        s-anna@ti.com, andre.przywara@arm.com, chris.obbard@collabora.com,
        qianweili@huawei.com, juerg.haefliger@canonical.com,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH] hwrng: Add helper dependency on COMPILE_TEST
Message-ID: <20210917031839.GA6559@gondor.apana.org.au>
References: <20210825040552.2265-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825040552.2265-1-caihuoqing@baidu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Aug 25, 2021 at 12:05:52PM +0800, Cai Huoqing wrote:
> it's helpful to do a complie test in other platform(e.g.X86)
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/char/hw_random/Kconfig | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

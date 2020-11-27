Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E932C6016
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Nov 2020 07:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392605AbgK0G0i (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 27 Nov 2020 01:26:38 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:33452 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392604AbgK0G0i (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 27 Nov 2020 01:26:38 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kiXD2-0000yE-3A; Fri, 27 Nov 2020 17:26:21 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Nov 2020 17:26:19 +1100
Date:   Fri, 27 Nov 2020 17:26:19 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Weili Qian <qianweili@huawei.com>
Cc:     davem@davemloft.net, mpm@selenic.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, xuzaibo@huawei.com,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH 0/4] crypto: hisilicon/trng - add HiSilicon TRNG driver
 support
Message-ID: <20201127062619.GD11448@gondor.apana.org.au>
References: <1605862623-37584-1-git-send-email-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605862623-37584-1-git-send-email-qianweili@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Nov 20, 2020 at 04:56:59PM +0800, Weili Qian wrote:
> 1. Move HiSilicon TRNG driver form 'drivers/char/hw_random/'
>    to 'drivers/crypto/hisilicon/'.
> 2. Add support for PRNG in Crypto subsystem.
> 
> Weili Qian (4):
>   hwrng: hisi - remove HiSilicon TRNG driver
>   crypto: hisilicon/trng - add HiSilicon TRNG driver support
>   crypto: hisilicon/trng - add support for PRNG
>   MAINTAINERS: Move HiSilicon TRNG V2 driver
> 
>  MAINTAINERS                            |   2 +-
>  arch/arm64/configs/defconfig           |   1 +
>  drivers/char/hw_random/Kconfig         |  13 --
>  drivers/char/hw_random/Makefile        |   1 -
>  drivers/char/hw_random/hisi-trng-v2.c  |  99 ----------
>  drivers/crypto/hisilicon/Kconfig       |   8 +
>  drivers/crypto/hisilicon/Makefile      |   1 +
>  drivers/crypto/hisilicon/trng/Makefile |   2 +
>  drivers/crypto/hisilicon/trng/trng.c   | 334 +++++++++++++++++++++++++++++++++
>  9 files changed, 347 insertions(+), 114 deletions(-)
>  delete mode 100644 drivers/char/hw_random/hisi-trng-v2.c
>  create mode 100644 drivers/crypto/hisilicon/trng/Makefile
>  create mode 100644 drivers/crypto/hisilicon/trng/trng.c

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

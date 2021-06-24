Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5393B2976
	for <lists+linux-crypto@lfdr.de>; Thu, 24 Jun 2021 09:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhFXHjf (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 24 Jun 2021 03:39:35 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50852 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231754AbhFXHjc (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 24 Jun 2021 03:39:32 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lwJvB-0006I2-QA; Thu, 24 Jun 2021 15:37:09 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lwJvB-0004iL-Mc; Thu, 24 Jun 2021 15:37:09 +0800
Date:   Thu, 24 Jun 2021 15:37:09 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     davem@davemloft.net, linus.walleij@linaro.org,
        ulli.kroll@googlemail.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lkp@intel.com
Subject: Re: [PATCH] crypto: sl3516: depends on HAS_IOMEM
Message-ID: <20210624073709.GG17892@gondor.apana.org.au>
References: <20210621185926.4181785-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621185926.4181785-1-clabbe@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jun 21, 2021 at 06:59:26PM +0000, Corentin Labbe wrote:
> The sl3516 driver need to depend on HAS_IOMEM.
> This fixes a build error:
> ERROR: modpost: "devm_platform_ioremap_resource" [drivers/crypto/gemini/sl3516-ce.ko] undefined!
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/crypto/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

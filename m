Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BB6265856
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Sep 2020 06:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725446AbgIKE2g (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 11 Sep 2020 00:28:36 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:58490 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgIKE2g (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 11 Sep 2020 00:28:36 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kGafY-0006EF-TW; Fri, 11 Sep 2020 14:28:18 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 11 Sep 2020 14:28:16 +1000
Date:   Fri, 11 Sep 2020 14:28:16 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nicolas Toromanoff <nicolas.toromanoff@st.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: stm32/crc32 - Avoid lock if hardware is already
 used
Message-ID: <20200911042816.GA5531@gondor.apana.org.au>
References: <20200904112527.15677-1-nicolas.toromanoff@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904112527.15677-1-nicolas.toromanoff@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Sep 04, 2020 at 01:25:27PM +0200, Nicolas Toromanoff wrote:
> If STM32 CRC device is already in use, calculate CRC by software.
> 
> This will release CPU constraint for a concurrent access to the
> hardware, and avoid masking irqs during the whole block processing.
> 
> Fixes: 7795c0baf5ac ("crypto: stm32/crc32 - protect from concurrent accesses")
> 
> Signed-off-by: Nicolas Toromanoff <nicolas.toromanoff@st.com>
> ---
>  drivers/crypto/stm32/Kconfig       |  2 ++
>  drivers/crypto/stm32/stm32-crc32.c | 15 ++++++++++++---
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/crypto/stm32/Kconfig b/drivers/crypto/stm32/Kconfig
> index 4ef3eb11361c..8d605b07571f 100644
> --- a/drivers/crypto/stm32/Kconfig
> +++ b/drivers/crypto/stm32/Kconfig
> @@ -3,6 +3,8 @@ config CRYPTO_DEV_STM32_CRC
>  	tristate "Support for STM32 crc accelerators"
>  	depends on ARCH_STM32
>  	select CRYPTO_HASH
> +	select CRYPTO_CRC32
> +	select CRYPTO_CRC32C

Shouldn't this be "select CRC32"?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9131D2E1980
	for <lists+linux-crypto@lfdr.de>; Wed, 23 Dec 2020 08:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgLWHvd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 23 Dec 2020 02:51:33 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:36572 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbgLWHvd (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 23 Dec 2020 02:51:33 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kryun-0006aQ-Qa; Wed, 23 Dec 2020 18:50:34 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 23 Dec 2020 18:50:33 +1100
Date:   Wed, 23 Dec 2020 18:50:33 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mark Gross <mgross@linux.intel.com>,
        Mike Healy <mikex.healy@intel.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: CRYPTO_DEV_KEEMBAY_OCS_AES_SM4 should depend on
 ARCH_KEEMBAY
Message-ID: <20201223075033.GA8269@gondor.apana.org.au>
References: <20201216131459.1320396-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216131459.1320396-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Dec 16, 2020 at 02:14:59PM +0100, Geert Uytterhoeven wrote:
> The Intel Keem Bay Offload and Crypto Subsystem (OCS) is only present on
> Intel Keem Bay SoCs.  Hence add a dependency on ARCH_KEEMBAY, to prevent
> asking the user about this driver when configuring a kernel without
> Intel Keem Bay platform support.
> 
> While at it, fix a misspelling of "cipher".
> 
> Fixes: 88574332451380f4 ("crypto: keembay - Add support for Keem Bay OCS AES/SM4")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/crypto/keembay/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

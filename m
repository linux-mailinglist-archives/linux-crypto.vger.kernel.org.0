Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B1D32CCD6
	for <lists+linux-crypto@lfdr.de>; Thu,  4 Mar 2021 07:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbhCDG2s (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 4 Mar 2021 01:28:48 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:52116 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235216AbhCDG2i (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 4 Mar 2021 01:28:38 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lHhRd-0007I3-Am; Thu, 04 Mar 2021 17:26:46 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 Mar 2021 17:26:44 +1100
Date:   Thu, 4 Mar 2021 17:26:44 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Allen Pais <allen.lkml@gmail.com>
Cc:     davem@davemloft.net, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        jesper.nilsson@axis.com, lars.persson@axis.com,
        horia.geanta@nxp.com, aymen.sghaier@nxp.com, gcherian@marvell.com,
        thomas.lendacky@amd.com, john.allen@amd.com, gilad@benyossef.com,
        bbrezillon@kernel.org, arno@natisbad.org, schalla@marvell.com,
        matthias.bgg@gmail.com, jamie@jamieiles.com,
        giovanni.cabiddu@intel.com, heiko@sntech.de, krzk@kernel.org,
        vz@mleia.com, k.konieczny@samsung.com,
        linux-crypto@vger.kernel.org, linux-mediatek@lists.infradead.org,
        qat-linux@intel.com, linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Allen Pais <apais@linux.microsoft.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: Re: [PATCH v5 01/19] crypto: amcc: convert tasklets to use new
 tasklet_setup() API
Message-ID: <20210304062644.GA5107@gondor.apana.org.au>
References: <20210208094238.571015-1-allen.lkml@gmail.com>
 <20210208094238.571015-2-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208094238.571015-2-allen.lkml@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Feb 08, 2021 at 03:12:20PM +0530, Allen Pais wrote:
> From: Allen Pais <apais@linux.microsoft.com>
> 
> In preparation for unconditionally passing the
> struct tasklet_struct pointer to all tasklet
> callbacks, switch to using the new tasklet_setup()
> and from_tasklet() to pass the tasklet pointer explicitly.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> Signed-off-by: Allen Pais <apais@linux.microsoft.com>
> ---
>  drivers/crypto/amcc/crypto4xx_core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

This introduces a compiler warning with C=1 W=1.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

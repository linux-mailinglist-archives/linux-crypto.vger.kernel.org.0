Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9880F127635
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Dec 2019 08:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfLTHHt (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Dec 2019 02:07:49 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58924 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbfLTHHt (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Dec 2019 02:07:49 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iiCO1-000059-7j; Fri, 20 Dec 2019 15:07:45 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iiCO0-0007rP-98; Fri, 20 Dec 2019 15:07:44 +0800
Date:   Fri, 20 Dec 2019 15:07:44 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tudor.Ambarus@microchip.com
Cc:     Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] crypto: atmel-{aes,sha} - Fix incorrect use of
 dmaengine_terminate_all()
Message-ID: <20191220070744.zovhmup6bbeunlzr@gondor.apana.org.au>
References: <20191213095423.6687-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213095423.6687-1-tudor.ambarus@microchip.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Dec 13, 2019 at 09:54:42AM +0000, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> device_terminate_all() is used to abort all the pending and
> ongoing transfers on the channel, it should be used just in the
> error path.
> 
> Also, dmaengine_terminate_all() is deprecated and one should use
> dmaengine_terminate_async() or dmaengine_terminate_sync(). The method
> is not used in atomic context, use dmaengine_terminate_sync().
> 
> A secondary aspect of this patch is that it luckily avoids a deadlock
> between atmel_aes and at_hdmac.c. While in tasklet with the lock held,
> the dma controller invokes the client callback (dmaengine_terminate_all),
> which tries to get the same lock. The at_hdmac fix would be to drop the
> lock before invoking the client callback, a fix on at_hdmac will follow.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/crypto/atmel-aes.c | 32 ++------------------------------
>  drivers/crypto/atmel-sha.c |  1 -
>  2 files changed, 2 insertions(+), 31 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 588CA7EBA4
	for <lists+linux-crypto@lfdr.de>; Fri,  2 Aug 2019 06:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732030AbfHBEyQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 2 Aug 2019 00:54:16 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:48610 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732011AbfHBEyQ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 2 Aug 2019 00:54:16 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1htPZs-0006F6-DW; Fri, 02 Aug 2019 14:54:04 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1htPZo-0004hp-C4; Fri, 02 Aug 2019 14:54:00 +1000
Date:   Fri, 2 Aug 2019 14:54:00 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: atmel-sha204a: Use device-managed registration
 API
Message-ID: <20190802045400.GA18077@gondor.apana.org.au>
References: <20190723071934.12528-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723071934.12528-1-hslester96@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jul 23, 2019 at 03:19:36PM +0800, Chuhong Yuan wrote:
> Use devm_hwrng_register to get rid of manual
> unregistration.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/crypto/atmel-sha204a.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

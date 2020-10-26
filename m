Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7F0299854
	for <lists+linux-crypto@lfdr.de>; Mon, 26 Oct 2020 21:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgJZU7V (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 26 Oct 2020 16:59:21 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:47376 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgJZU7V (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 26 Oct 2020 16:59:21 -0400
Received: from relay10.mail.gandi.net (unknown [217.70.178.230])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 162563B3D90
        for <linux-crypto@vger.kernel.org>; Mon, 26 Oct 2020 20:43:32 +0000 (UTC)
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 2F6A224000C;
        Mon, 26 Oct 2020 20:43:05 +0000 (UTC)
Date:   Mon, 26 Oct 2020 21:43:04 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     trix@redhat.com
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: atmel-sha: remove unneeded break
Message-ID: <20201026204304.GB75353@piout.net>
References: <20201019193653.13757-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019193653.13757-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 19/10/2020 12:36:53-0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A break is not needed if it is preceded by a return
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/crypto/atmel-sha.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
> index 75ccf41a7cb9..0eb6f54e3b66 100644
> --- a/drivers/crypto/atmel-sha.c
> +++ b/drivers/crypto/atmel-sha.c
> @@ -459,7 +459,6 @@ static int atmel_sha_init(struct ahash_request *req)
>  		break;
>  	default:
>  		return -EINVAL;
> -		break;
>  	}
>  
>  	ctx->bufcnt = 0;
> -- 
> 2.18.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C360A299875
	for <lists+linux-crypto@lfdr.de>; Mon, 26 Oct 2020 22:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgJZVCo (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 26 Oct 2020 17:02:44 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:54914 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729404AbgJZVCo (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 26 Oct 2020 17:02:44 -0400
Received: from relay7-d.mail.gandi.net (unknown [217.70.183.200])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 87AB63A71A6
        for <linux-crypto@vger.kernel.org>; Mon, 26 Oct 2020 20:45:20 +0000 (UTC)
X-Originating-IP: 90.65.88.165
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 5A01320005;
        Mon, 26 Oct 2020 20:44:57 +0000 (UTC)
Date:   Mon, 26 Oct 2020 21:44:56 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH -next] crypto: atmel-sha: discard unnecessary break
Message-ID: <20201026204456.GC75353@piout.net>
References: <20201026134807.13947-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026134807.13947-1-zhangqilong3@huawei.com>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi,

On 26/10/2020 21:48:07+0800, Zhang Qilong wrote:
> The 'break' is unnecessary because of previous
> 'return', discard it.
> 

This is a duplicate of https://lore.kernel.org/linux-crypto/20201019193653.13757-1-trix@redhat.com/T/#u

> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
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
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

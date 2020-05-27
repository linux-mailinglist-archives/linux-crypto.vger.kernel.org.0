Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046101E43EE
	for <lists+linux-crypto@lfdr.de>; Wed, 27 May 2020 15:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388299AbgE0NiU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 27 May 2020 09:38:20 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:57507 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387682AbgE0NiU (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 27 May 2020 09:38:20 -0400
Received: from [10.193.177.220] (saravanakumars.asicdesigners.com [10.193.177.220] (may be forged))
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 04RDc47U001690;
        Wed, 27 May 2020 06:38:05 -0700
Cc:     ayush.sawal@asicdesigners.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: chelsio: remove redundant premature assignment to
 iv
To:     Colin King <colin.king@canonical.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Rohit Maheshwari <rohitm@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
References: <20200527112922.171745-1-colin.king@canonical.com>
From:   Ayush Sawal <ayush.sawal@chelsio.com>
Message-ID: <224c28f6-27ba-a671-958a-4d72e7933864@chelsio.com>
Date:   Wed, 27 May 2020 19:09:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527112922.171745-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Colin,

On 5/27/2020 4:59 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Variable iv is being assigned twice with the same value, the first
> assignment is redundant and can be removed and instead keep the
> latter assignment of iv as it is closer to the point it is being
> used.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/crypto/chelsio/chcr_ipsec.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/crypto/chelsio/chcr_ipsec.c b/drivers/crypto/chelsio/chcr_ipsec.c
> index af961dcd317b..f9ad8c93e5ff 100644
> --- a/drivers/crypto/chelsio/chcr_ipsec.c
> +++ b/drivers/crypto/chelsio/chcr_ipsec.c
> @@ -398,7 +398,6 @@ inline void *copy_esn_pktxt(struct sk_buff *skb,
>   	memset(pos, 0, len);
>   	aadiv = (struct chcr_ipsec_aadiv *)pos;
>   	esphdr = (struct ip_esp_hdr *)skb_transport_header(skb);
> -	iv = skb_transport_header(skb) + sizeof(struct ip_esp_hdr);
>   	xo = xfrm_offload(skb);
>   
>   	aadiv->spi = (esphdr->spi);

Patch looks good, thank you for correcting.




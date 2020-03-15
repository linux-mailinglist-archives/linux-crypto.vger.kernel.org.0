Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01B7B185E67
	for <lists+linux-crypto@lfdr.de>; Sun, 15 Mar 2020 17:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgCOQLD (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 15 Mar 2020 12:11:03 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:53477 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbgCOQLC (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 15 Mar 2020 12:11:02 -0400
Received: from [10.193.177.146] (balakrishna-l.asicdesigners.com [10.193.177.146] (may be forged))
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 02FGAkc9006956;
        Sun, 15 Mar 2020 09:10:47 -0700
Subject: Re: [PATCH -next] crypto: chelsio - remove set but not used variable
 'adap'
To:     YueHaibing <yuehaibing@huawei.com>,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200314104441.79953-1-yuehaibing@huawei.com>
From:   rohit maheshwari <rohitm@chelsio.com>
Message-ID: <fcf6f896-8d60-836c-cdad-b5ca9c95b562@chelsio.com>
Date:   Sun, 15 Mar 2020 21:40:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20200314104441.79953-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org


On 14/03/20 4:14 PM, YueHaibing wrote:
> drivers/crypto/chelsio/chcr_algo.c: In function 'chcr_device_init':
> drivers/crypto/chelsio/chcr_algo.c:1440:18: warning:
>   variable 'adap' set but not used [-Wunused-but-set-variable]
>   
> commit 567be3a5d227 ("crypto: chelsio - Use multiple txq/rxq per tfm
> to process the requests") involved this unused variable.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/crypto/chelsio/chcr_algo.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
> index 8952732c0b7d..c29b80dd30d8 100644
> --- a/drivers/crypto/chelsio/chcr_algo.c
> +++ b/drivers/crypto/chelsio/chcr_algo.c
> @@ -1437,7 +1437,6 @@ static int chcr_aes_decrypt(struct skcipher_request *req)
>   static int chcr_device_init(struct chcr_context *ctx)
>   {
>   	struct uld_ctx *u_ctx = NULL;
> -	struct adapter *adap;
>   	int txq_perchan, ntxq;
>   	int err = 0, rxq_perchan;
>   
> @@ -1448,7 +1447,6 @@ static int chcr_device_init(struct chcr_context *ctx)
>   			goto out;
>   		}
>   		ctx->dev = &u_ctx->dev;
> -		adap = padap(ctx->dev);
>   		ntxq = u_ctx->lldi.ntxq;
>   		rxq_perchan = u_ctx->lldi.nrxq / u_ctx->lldi.nchan;
>   		txq_perchan = ntxq / u_ctx->lldi.nchan;
>
Thanks for fixing it. Looks good to me.
>

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34754D8585
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Oct 2019 03:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfJPBep (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 15 Oct 2019 21:34:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3775 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726083AbfJPBep (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 15 Oct 2019 21:34:45 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 94D242E291AD95F441B4;
        Wed, 16 Oct 2019 09:34:43 +0800 (CST)
Received: from [127.0.0.1] (10.57.77.109) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 09:34:33 +0800
Subject: Re: [PATCH] crypto: hisilicon: Fix misuse of GENMASK macro
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
References: <1569835209-44326-2-git-send-email-xuzaibo@huawei.com>
 <20191015201330.25973-1-rikard.falkeborn@gmail.com>
CC:     <davem@davemloft.net>, <forest.zhouchang@huawei.com>,
        <herbert@gondor.apana.org.au>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <tanghui20@huawei.com>
From:   Xu Zaibo <xuzaibo@huawei.com>
Message-ID: <006a5fca-3493-9b35-7621-aa9b2a9290d7@huawei.com>
Date:   Wed, 16 Oct 2019 09:34:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20191015201330.25973-1-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.77.109]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Agree with you, thanks!

Zaibo

.

On 2019/10/16 4:13, Rikard Falkeborn wrote:
> Arguments are supposed to be ordered high then low.
>
> Fixes: c8b4b477079d ("crypto: hisilicon - add HiSilicon HPRE accelerator")
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
> Spotted when trying to introduce compile time checking that the order
> of the arguments to GENMASK are correct [0]. I have only compile tested
> the patch.
>
> [0]: https://lore.kernel.org/lkml/20191009214502.637875-1-rikard.falkeborn@gmail.com/
>
>   drivers/crypto/hisilicon/hpre/hpre_main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
> index ca945b29632b..34e0424410bf 100644
> --- a/drivers/crypto/hisilicon/hpre/hpre_main.c
> +++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
> @@ -116,8 +116,8 @@ static const struct hpre_hw_error hpre_hw_errors[] = {
>   	{ .int_msk = BIT(7), .msg = "hpre_cltr2_htbt_tm_out_err" },
>   	{ .int_msk = BIT(8), .msg = "hpre_cltr3_htbt_tm_out_err" },
>   	{ .int_msk = BIT(9), .msg = "hpre_cltr4_htbt_tm_out_err" },
> -	{ .int_msk = GENMASK(10, 15), .msg = "hpre_ooo_rdrsp_err" },
> -	{ .int_msk = GENMASK(16, 21), .msg = "hpre_ooo_wrrsp_err" },
> +	{ .int_msk = GENMASK(15, 10), .msg = "hpre_ooo_rdrsp_err" },
> +	{ .int_msk = GENMASK(21, 16), .msg = "hpre_ooo_wrrsp_err" },
>   	{ /* sentinel */ }
>   };
>   



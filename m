Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72CC310DC2D
	for <lists+linux-crypto@lfdr.de>; Sat, 30 Nov 2019 03:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfK3CgQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 29 Nov 2019 21:36:16 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:39456 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727142AbfK3CgQ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 29 Nov 2019 21:36:16 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D72A1E1B3E783837C68D;
        Sat, 30 Nov 2019 10:36:10 +0800 (CST)
Received: from [127.0.0.1] (10.67.101.242) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Sat, 30 Nov 2019
 10:36:04 +0800
Subject: Re: [PATCH] crypto: hisilicon - select CRYPTO_SKCIPHER, not
 CRYPTO_BLKCIPHER
To:     Eric Biggers <ebiggers@kernel.org>, <linux-crypto@vger.kernel.org>
References: <20191129181556.45422-1-ebiggers@kernel.org>
CC:     Longfang Liu <liulongfang@huawei.com>
From:   Xu Zaibo <xuzaibo@huawei.com>
Message-ID: <e024f85b-a89e-fd0f-9945-0d30b5964093@huawei.com>
Date:   Sat, 30 Nov 2019 10:36:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20191129181556.45422-1-ebiggers@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.242]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org


On 2019/11/30 2:15, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
>
> Another instance of CRYPTO_BLKCIPHER made it in just after it was
> renamed to CRYPTO_SKCIPHER.  Fix it.
Yes, thanks.

Cheers,
Zaibo
.
>
> Fixes: 416d82204df4 ("crypto: hisilicon - add HiSilicon SEC V2 driver")
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   drivers/crypto/hisilicon/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
> index c0e7a85fe129..da749f6ecbea 100644
> --- a/drivers/crypto/hisilicon/Kconfig
> +++ b/drivers/crypto/hisilicon/Kconfig
> @@ -16,7 +16,7 @@ config CRYPTO_DEV_HISI_SEC
>   
>   config CRYPTO_DEV_HISI_SEC2
>   	tristate "Support for HiSilicon SEC2 crypto block cipher accelerator"
> -	select CRYPTO_BLKCIPHER
> +	select CRYPTO_SKCIPHER
>   	select CRYPTO_ALGAPI
>   	select CRYPTO_LIB_DES
>   	select CRYPTO_DEV_HISI_QM



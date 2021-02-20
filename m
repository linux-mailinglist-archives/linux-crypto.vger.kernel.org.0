Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B74E3204D7
	for <lists+linux-crypto@lfdr.de>; Sat, 20 Feb 2021 10:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhBTJwN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 20 Feb 2021 04:52:13 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13366 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhBTJwN (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 20 Feb 2021 04:52:13 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DjNw569vNz7nCJ;
        Sat, 20 Feb 2021 17:49:57 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Sat, 20 Feb 2021 17:51:22 +0800
Subject: Re: [PATCH 3/3] crypto: hisilicon/sec - fixes shash test error
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     <wangzhou1@hisilicon.com>, <xuzaibo@huawei.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Ard Biesheuvel" <ardb@kernel.org>
References: <1612519857-30714-1-git-send-email-liulongfang@huawei.com>
 <1612519857-30714-4-git-send-email-liulongfang@huawei.com>
 <20210205114435.GA17031@gondor.apana.org.au>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <6e5d529d-07df-5db0-d5c0-72e90e13852d@huawei.com>
Date:   Sat, 20 Feb 2021 17:51:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210205114435.GA17031@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 2021/2/5 19:44, Herbert Xu Wrote:
> On Fri, Feb 05, 2021 at 06:10:57PM +0800, Longfang Liu wrote:
>> If this configuration item is not turned on,
>> the allocation of crypto_tfm will fail when
>> the shash algorithm calculates the hash
>> through the software.
>>
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>  arch/arm64/configs/defconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 8383016..7cfc9b6 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -117,7 +117,7 @@ CONFIG_KVM=y
>>  CONFIG_ARM64_CRYPTO=y
>>  CONFIG_CRYPTO_SHA1_ARM64_CE=y
>>  CONFIG_CRYPTO_SHA2_ARM64_CE=y
>> -CONFIG_CRYPTO_SHA512_ARM64_CE=m
>> +CONFIG_CRYPTO_SHA512_ARM64_CE=y
> 
> If this is truly needed then it should be enabled through Kconfig.
> 
> Cheers,
> 
Hi,
Since patch3 is an unnecessary patch,
can you just remove it and merge patch1 and patch2?
Thanks,
Longfang.

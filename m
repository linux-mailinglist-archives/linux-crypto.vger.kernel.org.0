Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3C1360090
	for <lists+linux-crypto@lfdr.de>; Thu, 15 Apr 2021 05:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhDODiT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 14 Apr 2021 23:38:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17337 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhDODiS (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 14 Apr 2021 23:38:18 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FLQ3D6wZZzB178;
        Thu, 15 Apr 2021 11:35:36 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.144) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Thu, 15 Apr 2021
 11:37:45 +0800
Subject: Re: [PATCH] crypto: ccp - Fix to return the correct return value
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, John Allen <john.allen@amd.com>
References: <1618391864-55601-1-git-send-email-tiantao6@hisilicon.com>
 <ab70b5f7-6501-f6be-c879-29f764780b1a@amd.com>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <d7526eba-1c8b-055f-c1c8-db742e77016b@huawei.com>
Date:   Thu, 15 Apr 2021 11:37:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ab70b5f7-6501-f6be-c879-29f764780b1a@amd.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.188.144]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org


在 2021/4/15 6:48, Tom Lendacky 写道:
> On 4/14/21 4:17 AM, Tian Tao wrote:
>> ccp_dev_suspend and ccp_dev_resume return 0 on error, which causes
>> ret to equal 0 in sp_suspend and sp_resume, making the if condition
>> impossible to use.
> Why do you think that is an error and why do you think it should return
> -ENXIO? Since ccp_dev_suspend() and ccp_dev_resume() only return 0 it

thank you for helping reivew.

I think that ccp equals null might just be wrong, now after listening to 
your

explanation, my understanding was wrong, I will send a new patch as you 
suggested.

> might be a more appropriate fix to have these be void functions and
> eliminate the if condition in sp_suspend() and sp_resume().
>
> Thanks,
> Tom
>
>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
>> ---
>>   drivers/crypto/ccp/ccp-dev.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/crypto/ccp/ccp-dev.c b/drivers/crypto/ccp/ccp-dev.c
>> index 0971ee6..6f2af7b 100644
>> --- a/drivers/crypto/ccp/ccp-dev.c
>> +++ b/drivers/crypto/ccp/ccp-dev.c
>> @@ -556,7 +556,7 @@ int ccp_dev_suspend(struct sp_device *sp)
>>   
>>   	/* If there's no device there's nothing to do */
>>   	if (!ccp)
>> -		return 0;
>> +		return -ENXIO;
>>   
>>   	spin_lock_irqsave(&ccp->cmd_lock, flags);
>>   
>> @@ -584,7 +584,7 @@ int ccp_dev_resume(struct sp_device *sp)
>>   
>>   	/* If there's no device there's nothing to do */
>>   	if (!ccp)
>> -		return 0;
>> +		return -ENXIO;
>>   
>>   	spin_lock_irqsave(&ccp->cmd_lock, flags);
>>   
>>
> .
>


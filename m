Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23239A7F8E
	for <lists+linux-crypto@lfdr.de>; Wed,  4 Sep 2019 11:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbfIDJiV (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 4 Sep 2019 05:38:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5755 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbfIDJiV (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 4 Sep 2019 05:38:21 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 86C12F2FF5C3E59212E6;
        Wed,  4 Sep 2019 17:38:19 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 17:38:15 +0800
Message-ID: <5D6F8606.8030109@huawei.com>
Date:   Wed, 4 Sep 2019 17:38:14 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Joerg Roedel <joro@8bytes.org>
CC:     <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
        <arno@natisbad.org>, <gregkh@linuxfoundation.org>,
        <iommu@lists.linux-foundation.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] iommu/pamu: Use kzfree rather than its implementation
References: <1567566079-7412-1-git-send-email-zhongjiang@huawei.com> <1567566079-7412-3-git-send-email-zhongjiang@huawei.com> <20190904081517.GA29855@8bytes.org>
In-Reply-To: <20190904081517.GA29855@8bytes.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 2019/9/4 16:15, Joerg Roedel wrote:
> On Wed, Sep 04, 2019 at 11:01:18AM +0800, zhong jiang wrote:
>> Use kzfree instead of memset() + kfree().
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  drivers/iommu/fsl_pamu.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
>> index cde281b..ca6d147 100644
>> --- a/drivers/iommu/fsl_pamu.c
>> +++ b/drivers/iommu/fsl_pamu.c
>> @@ -1174,10 +1174,8 @@ static int fsl_pamu_probe(struct platform_device *pdev)
>>  	if (irq != NO_IRQ)
>>  		free_irq(irq, data);
>>  
>> -	if (data) {
>> -		memset(data, 0, sizeof(struct pamu_isr_data));
>> -		kfree(data);
>> -	}
>> +	if (data)
>> +		kzfree(data);
> kzfree() is doing its own NULL-ptr check, no need to do it here.
Yep,   we should also remove the condition before kzfree.  will repost.

Thanks,
zhong jiang
> Regards,
>
> 	Joerg


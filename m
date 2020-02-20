Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFF2165D6E
	for <lists+linux-crypto@lfdr.de>; Thu, 20 Feb 2020 13:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgBTMUW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 20 Feb 2020 07:20:22 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2450 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727393AbgBTMUW (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 20 Feb 2020 07:20:22 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id DFCF6F25C691815EB3BF;
        Thu, 20 Feb 2020 12:20:20 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 20 Feb 2020 12:20:20 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 20 Feb
 2020 12:20:20 +0000
Subject: Re: [PATCH 4/4] crypto: hisilicon/sec2 - Add pbuffer mode for SEC
 driver
To:     Xu Zaibo <xuzaibo@huawei.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>
CC:     <qianweili@huawei.com>, <tanghui20@huawei.com>,
        <forest.zhouchang@huawei.com>, <linuxarm@huawei.com>,
        <zhangwei375@huawei.com>, <shenyang39@huawei.com>,
        <yekai13@huawei.com>, <linux-crypto@vger.kernel.org>
References: <1582189495-38051-1-git-send-email-xuzaibo@huawei.com>
 <1582189495-38051-5-git-send-email-xuzaibo@huawei.com>
 <011d8794-b4ab-a5ad-b765-e6e2c09991aa@huawei.com>
 <69fe2d60-428e-9747-b7c0-d69cf25efc0e@huawei.com>
 <87591c1f-5c6b-64bd-5dc2-900e1481b5ca@huawei.com>
 <bac7ec3e-43e6-9061-fbbe-03f4404f1c50@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <07f82b86-fa3a-c4e5-f4bc-f12c4dbefd09@huawei.com>
Date:   Thu, 20 Feb 2020 12:20:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <bac7ec3e-43e6-9061-fbbe-03f4404f1c50@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 20/02/2020 12:16, Xu Zaibo wrote:
> 
> On 2020/2/20 19:07, John Garry wrote:
>> On 20/02/2020 10:10, Xu Zaibo wrote:
>>> Hi,
>>>
>>>
>>> On 2020/2/20 17:50, John Garry wrote:
>>>> On 20/02/2020 09:04, Zaibo Xu wrote:
>>>>> From: liulongfang <liulongfang@huawei.com>
>>>>>
>>>>> In the scenario of SMMU translation, the SEC performance of short 
>>>>> messages
>>>>> (<512Bytes) cannot meet our expectations. To avoid this, we reserve 
>>>>> the
>>>>> plat buffer (PBUF) memory for small packets when creating TFM.
>>>>>
>>>>
>>>> I haven't gone through the code here, but why not use this method 
>>>> also for non-translated? What are the pros and cons?
>>> Because non-translated has no performance or throughput problems.
>>>
>>
>> OK, so no problem, but I was asking could it be improved, and, if so, 
>> what would be the drawbacks?
>>
>> As for the change to check if the IOMMU is translating, it seems exact 
>> same as that for the hi1616 driver...
>>
> Currently, I find the only drawback is needing more memory :),

OK, so that is a drawback.

> what's 
> your idea?

I am just asking if we get any performance gain for using this same 
method for non-IOMMU case, and does the gain (if any) in performance 
outweigh the additional memory usage?

> Yes, the same as SEC V1.

So it could be factored out :)

thanks,
john

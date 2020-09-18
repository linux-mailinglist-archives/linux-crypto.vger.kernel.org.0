Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D3326F896
	for <lists+linux-crypto@lfdr.de>; Fri, 18 Sep 2020 10:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgIRIpK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 18 Sep 2020 04:45:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48344 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725900AbgIRIpK (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 18 Sep 2020 04:45:10 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 275CCA90FA84136E5385;
        Fri, 18 Sep 2020 16:45:05 +0800 (CST)
Received: from [10.67.103.10] (10.67.103.10) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 16:44:55 +0800
Subject: Re: [PATCH 3/3] crypto: hisilicon/hpre - fix a bug in dh algorithm
To:     Herbert Xu <herbert@gondor.apana.org.au>
References: <1599737122-20734-1-git-send-email-yumeng18@huawei.com>
 <1599737122-20734-4-git-send-email-yumeng18@huawei.com>
 <20200918071112.GA9883@gondor.apana.org.au>
CC:     <davem@davemloft.net>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>,
        <linux-kernel@vger.kernel.org>
From:   yumeng <yumeng18@huawei.com>
Message-ID: <25ea9f7b-1a96-6cbe-2154-ba14bf5e5e97@huawei.com>
Date:   Fri, 18 Sep 2020 16:44:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200918071112.GA9883@gondor.apana.org.au>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.10]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Yes, 'u64' is redundant,  I will resend one!
                         Thank you!


On 2020/9/18 15:11, Herbert Xu wrote:
> On Thu, Sep 10, 2020 at 07:25:22PM +0800, Meng Yu wrote:
>>
>> diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
>> index 0cbe99a1..2d91593 100644
>> --- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
>> +++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
>> @@ -528,6 +528,8 @@ static int hpre_dh_compute_value(struct kpp_request *req)
>>  		ret = hpre_hw_data_init(hpre_req, req->src, req->src_len, 1, 1);
>>  		if (unlikely(ret))
>>  			goto clear_all;
>> +	} else {
>> +		msg->in = cpu_to_le64((u64)ctx->dh.dma_g);
>
> Why do you need the u64 cast?
>
> Cheers,
>

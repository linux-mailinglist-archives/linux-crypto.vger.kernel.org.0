Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9501125D3DD
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Sep 2020 10:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbgIDIn0 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Sep 2020 04:43:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10769 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729572AbgIDInZ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Sep 2020 04:43:25 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0574DC728D346BA190B7;
        Fri,  4 Sep 2020 16:43:24 +0800 (CST)
Received: from [127.0.0.1] (10.74.173.29) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 4 Sep 2020
 16:43:14 +0800
Subject: Re: [PATCH RESEND 04/10] crypto: hisilicon/zip - replace 'sprintf'
 with 'scnprintf'
To:     Herbert Xu <herbert@gondor.apana.org.au>
References: <1598238709-58699-1-git-send-email-shenyang39@huawei.com>
 <1598238709-58699-5-git-send-email-shenyang39@huawei.com>
 <d1102aca2bdc4df4acc31d8b082cacce@AcuMS.aculab.com>
 <abc0c78e-3232-9081-c330-3d5b8db9e683@huawei.com>
 <20200904074004.GA24815@gondor.apana.org.au>
CC:     David Laight <David.Laight@ACULAB.COM>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
        "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>
From:   "shenyang (M)" <shenyang39@huawei.com>
Message-ID: <4af18f59-9e91-7a16-bb6b-1a66a9056c10@huawei.com>
Date:   Fri, 4 Sep 2020 16:43:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200904074004.GA24815@gondor.apana.org.au>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.173.29]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org



On 2020/9/4 15:40, Herbert Xu wrote:
> On Wed, Aug 26, 2020 at 04:56:40PM +0800, shenyang (M) wrote:
>>
>>>> @@ -514,13 +514,16 @@ static int hisi_zip_core_debug_init(struct hisi_qm *qm)
>>>>  	struct debugfs_regset32 *regset;
>>>>  	struct dentry *tmp_d;
>>>>  	char buf[HZIP_BUF_SIZE];
>>>> -	int i;
>>>> +	int i, ret;
>>>>
>>>>  	for (i = 0; i < HZIP_CORE_NUM; i++) {
>>>>  		if (i < HZIP_COMP_CORE_NUM)
>>>> -			sprintf(buf, "comp_core%d", i);
>>>> +			ret = scnprintf(buf, HZIP_BUF_SIZE, "comp_core%d", i);
>>>>  		else
>>>> -			sprintf(buf, "decomp_core%d", i - HZIP_COMP_CORE_NUM);
>>>> +			ret = scnprintf(buf, HZIP_BUF_SIZE, "decomp_core%d",
>>>> +					i - HZIP_COMP_CORE_NUM);
>>>> +		if (!ret)
>>>> +			return -ENOMEM;
>>>
>>> and that is just so wrong - did you even try to test
>>> the 'buffer too small' code path?
>>
>> Do you means the check is unnecessary?
>
> No he's saying that your patch does the wrong thing when the string
> is truncated.
>
> Also ENOMEM is a strange error for that case.
>
> Cheers,
>

Here 'HZIP_BUF_SIZE' is 22, so the buf is enough for the string.

The check for the return is really unnecessary, I will remove it in the
next version.

Thanks,
Yang


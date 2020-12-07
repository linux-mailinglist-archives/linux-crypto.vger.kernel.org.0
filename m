Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF622D0955
	for <lists+linux-crypto@lfdr.de>; Mon,  7 Dec 2020 04:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgLGDRv (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 6 Dec 2020 22:17:51 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9387 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgLGDRv (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 6 Dec 2020 22:17:51 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Cq7kv5dHNz79Wn;
        Mon,  7 Dec 2020 11:16:39 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Dec 2020 11:17:08 +0800
Subject: Re: [PATCH 0/5] crypto: hisilicon - add some new algorithms
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1606357086-9785-1-git-send-email-liulongfang@huawei.com>
 <20201204070525.GA26479@gondor.apana.org.au>
 <c74d3ea8-4286-b34f-36ef-8e0425b2dd19@huawei.com>
 <20201207013359.GA9845@gondor.apana.org.au>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <0ff75e08-5e90-f4d2-228c-90730a793b77@huawei.com>
Date:   Mon, 7 Dec 2020 11:17:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20201207013359.GA9845@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 2020/12/7 9:33, Herbert Xu wrote:
> On Mon, Dec 07, 2020 at 09:20:05AM +0800, liulongfang wrote:
>>
>> Did any test case tests fail?
> 
> You tell me :)
> 
> If it passed all of the tests in your testing, please state that
> in the cover letter or in one of the patches.
> 
> Thanks,
> 
OK, I will add new algorithms test results in the next patchset
Thanks,
Longfang.

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E21D35986D
	for <lists+linux-crypto@lfdr.de>; Fri,  9 Apr 2021 11:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhDIJAT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 9 Apr 2021 05:00:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16858 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbhDIJAS (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 9 Apr 2021 05:00:18 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FGsTn5cQtz7tpW;
        Fri,  9 Apr 2021 16:57:49 +0800 (CST)
Received: from [10.40.246.206] (10.40.246.206) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Fri, 9 Apr 2021 16:59:56 +0800
Subject: Re: [PATCH] crypto: api - fix coding style
To:     Herbert Xu <herbert@gondor.apana.org.au>
References: <1617261649-35947-1-git-send-email-songzhiqi1@huawei.com>
 <20210409072728.GA23134@gondor.apana.org.au>
CC:     <davem@davemloft.net>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangzhou1@hisilicon.com>,
        <fanghao11@huawei.com>, <prime.zeng@hisilicon.com>
From:   "songzhiqi (A)" <songzhiqi1@huawei.com>
Message-ID: <9e36e254-3d63-868d-5b93-3e676b073dd1@huawei.com>
Date:   Fri, 9 Apr 2021 16:59:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210409072728.GA23134@gondor.apana.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.246.206]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org



On 2021/4/9 15:27, Herbert Xu wrote:
> On Thu, Apr 01, 2021 at 03:20:49PM +0800, Zhiqi Song wrote:
>> Fixed following checkpatch error:
>> - do not use assignment in if condition
>> Fixed following checkpatch warning:
>> - prefer strscpy over strlcpy
>> - delete repeated word
>>
>> Signed-off-by: Zhiqi Song <songzhiqi1@huawei.com>
>> ---
>>  crypto/api.c | 20 ++++++++++++--------
>>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> Please don't mix unrelated changes in a single patch.
> 
> Thanks,
> 
OK, I will split this patch.
Thanks.

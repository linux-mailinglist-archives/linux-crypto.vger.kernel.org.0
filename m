Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C39B35993C
	for <lists+linux-crypto@lfdr.de>; Fri,  9 Apr 2021 11:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhDIJbB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 9 Apr 2021 05:31:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16116 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbhDIJbB (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 9 Apr 2021 05:31:01 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGt9G3zxyz19L8g;
        Fri,  9 Apr 2021 17:28:34 +0800 (CST)
Received: from [10.67.101.248] (10.67.101.248) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Fri, 9 Apr 2021 17:30:40 +0800
Subject: Re: [PATCH v2] crypto: hisilicon/hpre - delete redundant log
To:     Herbert Xu <herbert@gondor.apana.org.au>
References: <1617362669-40372-1-git-send-email-tanghui20@huawei.com>
 <20210409073334.GC23134@gondor.apana.org.au>
CC:     <davem@davemloft.net>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>,
        <linux-kernel@vger.kernel.org>
From:   Hui Tang <tanghui20@huawei.com>
Message-ID: <b91fbd1e-0d4c-c0db-d879-3c661ad26a50@huawei.com>
Date:   Fri, 9 Apr 2021 17:30:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210409073334.GC23134@gondor.apana.org.au>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.248]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org



On 2021/4/9 15:33, Herbert Xu wrote:
> On Fri, Apr 02, 2021 at 07:24:29PM +0800, Hui Tang wrote:
>> 'hpre_cfg_by_dsm' has checked and printed error path internally. It is not
>> necessary to do it here, so remove it.
>>
>> Signed-off-by: Hui Tang <tanghui20@huawei.com>
>>
>> v1 -> v2:
>> - Return immediately when return value of 'hpre_cfg_by_dsm' is non-zero.
>> ---
>>  drivers/crypto/hisilicon/hpre/hpre_main.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Your patch description is misleading as the patch does moe than
> just remove the redundant printk.  Please rephrase so that it is
> clear that the patch is in fact changing behaviour.

Okay, I will fix it in next version.
>

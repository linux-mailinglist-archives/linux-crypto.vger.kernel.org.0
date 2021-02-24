Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A944323559
	for <lists+linux-crypto@lfdr.de>; Wed, 24 Feb 2021 02:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhBXBdR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 23 Feb 2021 20:33:17 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12948 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbhBXBa1 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 23 Feb 2021 20:30:27 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DldbW1Q3hzjQpq;
        Wed, 24 Feb 2021 09:28:23 +0800 (CST)
Received: from [10.67.103.10] (10.67.103.10) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Wed, 24 Feb 2021
 09:29:34 +0800
Subject: Re: [PATCH v9 3/7] crypto: move curve_id of ECDH from the key to
 algorithm name
To:     <Tudor.Ambarus@microchip.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <marcel@holtmann.org>,
        <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>,
        <Nicolas.Ferre@microchip.com>
References: <1614064219-40701-1-git-send-email-yumeng18@huawei.com>
 <1614064219-40701-4-git-send-email-yumeng18@huawei.com>
 <8b96c136-dca9-5b6a-2221-e906d265c40b@microchip.com>
From:   yumeng <yumeng18@huawei.com>
Message-ID: <fd3b7c0f-d7f2-3d27-cfef-98ec3614dd1a@huawei.com>
Date:   Wed, 24 Feb 2021 09:29:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <8b96c136-dca9-5b6a-2221-e906d265c40b@microchip.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.10]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org



在 2021/2/23 18:44, Tudor.Ambarus@microchip.com 写道:
> Hi,
> 
> On 2/23/21 9:10 AM, Meng Yu wrote:
>> --- a/drivers/crypto/atmel-ecc.c
>> +++ b/drivers/crypto/atmel-ecc.c
>> @@ -104,7 +104,7 @@ static int atmel_ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
>>                  return -EINVAL;
>>          }
>>
>> -       ctx->n_sz = atmel_ecdh_supported_curve(params.curve_id);
>> +       ctx->n_sz = atmel_ecdh_supported_curve(ctx->curve_id);
>>          if (!ctx->n_sz || params.key_size) {
>>                  /* fallback to ecdh software implementation */
>>                  ctx->do_fallback = true;
> 
> Now that you moved the curve id info into the alg name, and it is
> no longer dynamically discovered when decoding the key, does it
> still make sense to keep the curve id, the key size checks, and
> the fallback to the software implementation?
>I think we can keep the curve id, the key size check if 'atmel-ecc' may
support other curves in the future, and if you're sure P256 is the only
curve 'atmel-ecc' uses, and it will be changed, we can delete it.

And fallback to ecdh software implementation is needed when
params.key_size is zero.

> I don't have an atecc508 at hand to test the changes, but I expect
> your changes won't affect the functionality.
> 

OK, if you or your team members have an atecc508, please help test.


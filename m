Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FD91E0861
	for <lists+linux-crypto@lfdr.de>; Mon, 25 May 2020 10:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbgEYIDM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 25 May 2020 04:03:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46200 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729898AbgEYIDM (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 25 May 2020 04:03:12 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 548EDF6E323DEA338751;
        Mon, 25 May 2020 16:03:09 +0800 (CST)
Received: from [10.174.151.115] (10.174.151.115) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 25 May
 2020 16:03:01 +0800
Subject: Re: [2/2] crypto: virtio: Fix use-after-free in
 virtio_crypto_skcipher_finalize_req()
To:     Markus Elfring <Markus.Elfring@web.de>,
        <linux-crypto@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     Arei Gonglei <arei.gonglei@huawei.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <a5ef5d51-e35c-983f-8e7f-5f19552abe9e@web.de>
 <a17850bb-f70d-1f77-3823-afd70816ce57@huawei.com>
 <cbd8ab27-71c3-2fb0-2fa3-263901596773@web.de>
From:   "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Message-ID: <c81e5d74-b664-8941-149f-8b916986e8cf@huawei.com>
Date:   Mon, 25 May 2020 16:03:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cbd8ab27-71c3-2fb0-2fa3-263901596773@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.151.115]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org



On 2020/5/25 15:36, Markus Elfring wrote:
>> Could you help me to make the sentence better?
> 
> How do you think about a wording variant like the following?
> 
>   So the system will crash when this memory will be used again.
> 
Uh, it's much better, thanks.

> 
>>> * You proposed to move a call of the function “crypto_finalize_skcipher_request”.
>>>   How does this change fit to the mentioned position?
>>>
>> The resources which need to be freed is not used anymore, but the pointers
>> of these resources may be changed in the function
>> "crypto_finalize_skcipher_request", so free these resources before call the
>> function is suitable.
> 
> Another alternative:
>   The resources which need to be cleaned up are not used any more.
>   But the pointers of these resources may be changed in the
>   function “crypto_finalize_skcipher_request”.
>   Thus release specific resources before calling this function.
> 
Oh great! Thanks.

> Regards,
> Markus
> 

-- 
---
Regards,
Longpeng(Mike)

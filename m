Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14B11E073E
	for <lists+linux-crypto@lfdr.de>; Mon, 25 May 2020 08:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388710AbgEYGqi (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 25 May 2020 02:46:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56790 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388385AbgEYGqi (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 25 May 2020 02:46:38 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C22CEDDD0DEDD6AD6D3;
        Mon, 25 May 2020 14:46:35 +0800 (CST)
Received: from [10.174.151.115] (10.174.151.115) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 25 May
 2020 14:46:25 +0800
Subject: Re: [PATCH 1/2] crypto: virtio: Fix src/dst scatterlist calculation
 in __virtio_crypto_skcipher_do_req()
To:     Markus Elfring <Markus.Elfring@web.de>,
        <linux-crypto@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>,
        Arei Gonglei <arei.gonglei@huawei.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <21478291-9191-1da3-a7e5-65e87c743a3c@web.de>
From:   "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Message-ID: <7b2ac2f8-7d92-1bd7-8ad8-9866d9b1d634@huawei.com>
Date:   Mon, 25 May 2020 14:46:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <21478291-9191-1da3-a7e5-65e87c743a3c@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.151.115]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Markus,

On 2020/5/25 14:05, Markus Elfring wrote:
>> The system will crash when we insmod crypto/tcrypt.ko whit mode=38.
> 
> * I suggest to use the word “with” in this sentence.
> 
OK, it's a typo.

> * Will it be helpful to explain the passed mode number?
> 
> 
>> BTW I add a check for sg_nents_for_len() its return value since
>> sg_nents_for_len() function could fail.
> 
> Please reconsider also development consequences for this suggestion.
> Will a separate update step be more appropriate for the addition of
> an input parameter validation?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=9cb1fd0efd195590b828b9b865421ad345a4a145#n138
> 
> Would you like to add the tag “Fixes” to the commit message?
>
Will take all of your suggestions in v2, thanks.

> Regards,
> Markus
> 

-- 
---
Regards,
Longpeng(Mike)

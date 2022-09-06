Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74165AE0B5
	for <lists+linux-crypto@lfdr.de>; Tue,  6 Sep 2022 09:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbiIFHOa (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 6 Sep 2022 03:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238788AbiIFHO2 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 6 Sep 2022 03:14:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2A9279
        for <linux-crypto@vger.kernel.org>; Tue,  6 Sep 2022 00:14:22 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MMGkZ4fYhzmV94;
        Tue,  6 Sep 2022 15:10:46 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 6 Sep 2022 15:14:19 +0800
Message-ID: <da20a9a4-4445-bb8e-b019-8116fcaee582@huawei.com>
Date:   Tue, 6 Sep 2022 15:14:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Inquiry about the removal of flag O_NONBLOCK on /dev/random
Content-Language: en-US
From:   "Guozihua (Scott)" <guozihua@huawei.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     Eric Biggers <ebiggers@kernel.org>, <linux-crypto@vger.kernel.org>,
        <luto@kernel.org>, <tytso@mit.edu>,
        zhongguohua <zhongguohua1@huawei.com>
References: <13e1fa9d-4df8-1a99-ca22-d9d655f2d023@huawei.com>
 <YtaPJPkewin5uWdn@zx2c4.com>
 <b9cb514c-30ed-0b8b-5d54-75001e07bd36@huawei.com>
 <YtjREZMzuppTJHeR@sol.localdomain>
 <a93995db-a738-8e4f-68f2-42d7efd3c77d@huawei.com>
 <Ytj3RnGtWqg18bxO@sol.localdomain> <YtksefZvcFiugeC1@zx2c4.com>
 <29c4a3ec-f23f-f17f-da49-7d79ad88e284@huawei.com>
 <Yt/LPr0uJVheDuuW@zx2c4.com>
 <4a794339-7aaa-8951-8d24-9bc8a79fa9f3@huawei.com>
 <761e849c-3b9d-418e-eb68-664f09b3c661@huawei.com>
In-Reply-To: <761e849c-3b9d-418e-eb68-664f09b3c661@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 2022/7/28 16:24, Guozihua (Scott) wrote:
> On 2022/7/26 19:33, Guozihua (Scott) wrote:
>> On 2022/7/26 19:08, Jason A. Donenfeld wrote:
>>> Hi,
>>>
>>> On Tue, Jul 26, 2022 at 03:43:31PM +0800, Guozihua (Scott) wrote:
>>>> Thanks for all the comments on this inquiry. Does the community has any
>>>> channel to publishes changes like these? And will the man pages get
>>>> updated? If so, are there any time frame?
>>>
>>> I was under the impression you were ultimately okay with the status quo.
>>> Have I misunderstood you?
>>>
>>> Thanks,
>>> Jason
>>> .
>>
>> Hi Jason.
>>
>> To clarify, I does not have any issue with this change. I asked here 
>> only because I would like some background knowledge on this flag, to 
>> ensure I am on the same page as the community regarding this flag and 
>> the change. And it seems that I understands it correctly.
>>
>> However I do think it's a good idea to update the document soon to 
>> avoid any misunderstanding in the future.
>>
> 
> Our colleague suggests that we should inform users clearly about the 
> change on the flag by returning -EINVAL when /dev/random gets this flag 
> during boot process. Otherwise programs might silently block for a long 
> time, causing other issues. Do you think this is a good way to prevent 
> similar issues on this flag?
> 
Hi,

Any comment on this?

-- 
Best
GUO Zihua

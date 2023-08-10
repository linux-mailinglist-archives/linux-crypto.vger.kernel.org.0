Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BC0777900
	for <lists+linux-crypto@lfdr.de>; Thu, 10 Aug 2023 15:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbjHJNCe (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 10 Aug 2023 09:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjHJNCe (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 10 Aug 2023 09:02:34 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770102691
        for <linux-crypto@vger.kernel.org>; Thu, 10 Aug 2023 06:02:33 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RM6SN6p5yzcdW9;
        Thu, 10 Aug 2023 20:59:00 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 21:02:31 +0800
Message-ID: <57c0c8bc-03ea-6306-1110-3bf2260d109f@huawei.com>
Date:   Thu, 10 Aug 2023 21:02:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] hwrng: Remove duplicated include
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     <olivia@selenic.com>, <linux-crypto@vger.kernel.org>
References: <20230810115858.24735-1-guozihua@huawei.com>
 <ZNTUp37QJaGwt5d9@gondor.apana.org.au>
Content-Language: en-US
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <ZNTUp37QJaGwt5d9@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 2023/8/10 20:14, Herbert Xu wrote:
> On Thu, Aug 10, 2023 at 07:58:58PM +0800, GUO Zihua wrote:
>> Remove duplicated include of linux/random.h. Resolves checkincludes
>> message.
>>
>> Signed-off-by: GUO Zihua <guozihua@huawei.com>
>> ---
>>  drivers/char/hw_random/core.c | 1 -
>>  1 file changed, 1 deletion(-)
> 
> Please sort the header files alphabetically.
> 
> Thanks,
Hi Herbert,

Thanks for the incredibly timely reply! A v2 has been sent.

-- 
Best
GUO Zihua


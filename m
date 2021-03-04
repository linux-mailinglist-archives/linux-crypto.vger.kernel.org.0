Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F3832CA64
	for <lists+linux-crypto@lfdr.de>; Thu,  4 Mar 2021 03:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhCDCUA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 3 Mar 2021 21:20:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13467 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhCDCTk (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 3 Mar 2021 21:19:40 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DrZJC1zdnzjVC0;
        Thu,  4 Mar 2021 10:17:15 +0800 (CST)
Received: from [127.0.0.1] (10.40.193.166) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Thu, 4 Mar 2021
 10:18:51 +0800
Subject: Re: [PATCH 2/4] crypto: cavium - Fix the parameter of dma_unmap_sg()
To:     Herbert Xu <herbert@gondor.apana.org.au>
References: <1612853965-67777-1-git-send-email-chenxiang66@hisilicon.com>
 <1612853965-67777-3-git-send-email-chenxiang66@hisilicon.com>
 <20210303085907.GA8134@gondor.apana.org.au>
CC:     <clabbe.montjoie@gmail.com>, <clabbe@baylibre.com>,
        <gcherian@marvell.com>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linuxarm@openeuler.org>,
        <prime.zeng@huawei.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <e70ae2a0-9b96-ed86-c7fe-8410965342f5@hisilicon.com>
Date:   Thu, 4 Mar 2021 10:18:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20210303085907.GA8134@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Herbert,


在 2021/3/3 16:59, Herbert Xu 写道:
> On Tue, Feb 09, 2021 at 02:59:23PM +0800, chenxiang wrote:
>> From: Xiang Chen <chenxiang66@hisilicon.com>
>>
>> For function dma_unmap_sg(), the <nents> parameter should be number of
>> elements in the scatterlist prior to the mapping, not after the mapping.
>> So fix this usage.
>>
>> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
>> ---
>>   drivers/crypto/cavium/nitrox/nitrox_reqmgr.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c b/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
>> index 53ef067..1263194 100644
>> --- a/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
>> +++ b/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
>> @@ -170,7 +170,7 @@ static int dma_map_inbufs(struct nitrox_softreq *sr,
>>   		sr->in.total_bytes += sg_dma_len(sg);
>>   
>>   	sr->in.sg = req->src;
>> -	sr->in.sgmap_cnt = nents;
>> +	sr->in.sgmap_cnt = sg_nents(req->src);
>>   	ret = create_sg_component(sr, &sr->in, sr->in.sgmap_cnt);
> So you're changing the count passed to create_sg_component.  Are you
> sure that's correct? Even if it is correct you should change your
> patch description to document this change.

Thank you for reminding me about this. I didn't notice that it changes 
the count passed to create_sg_component.
I have a change on this patch as follows, and please have a check on it:

--- a/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
@@ -58,14 +58,14 @@ static void softreq_unmap_sgbufs(struct 
nitrox_softreq *sr)
         struct device *dev = DEV(ndev);


-       dma_unmap_sg(dev, sr->in.sg, sr->in.sgmap_cnt, DMA_BIDIRECTIONAL);
+       dma_unmap_sg(dev, sr->in.sg, sg_nents(sr->in.sg), 
DMA_BIDIRECTIONAL);
         dma_unmap_single(dev, sr->in.sgcomp_dma, sr->in.sgcomp_len,
                          DMA_TO_DEVICE);
         kfree(sr->in.sgcomp);
         sr->in.sg = NULL;
         sr->in.sgmap_cnt = 0;

-       dma_unmap_sg(dev, sr->out.sg, sr->out.sgmap_cnt,
+       dma_unmap_sg(dev, sr->out.sg, sg_nents(sr->out.sg),
                      DMA_BIDIRECTIONAL);
         dma_unmap_single(dev, sr->out.sgcomp_dma, sr->out.sgcomp_len,
                          DMA_TO_DEVICE);
@@ -178,7 +178,8 @@ static int dma_map_inbufs(struct nitrox_softreq *sr,
         return 0;

  incomp_err:
-       dma_unmap_sg(dev, req->src, nents, DMA_BIDIRECTIONAL);
+       dma_unmap_sg(dev, req->src, sg_nents(req->src),
+                    DMA_BIDIRECTIONAL);
         sr->in.sgmap_cnt = 0;
         return ret;
  }
@@ -203,7 +204,8 @@ static int dma_map_outbufs(struct nitrox_softreq *sr,
         return 0;

  outcomp_map_err:
-       dma_unmap_sg(dev, req->dst, nents, DMA_BIDIRECTIONAL);
+       dma_unmap_sg(dev, req->dst, sg_nents(req->dst),
+                    DMA_BIDIRECTIONAL);
         sr->out.sgmap_cnt = 0;
         sr->out.sg = NULL;
         return ret;



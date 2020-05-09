Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843331CBD22
	for <lists+linux-crypto@lfdr.de>; Sat,  9 May 2020 06:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgEIEGs (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 9 May 2020 00:06:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4363 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725613AbgEIEGs (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 9 May 2020 00:06:48 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5C3456FF66906F70912C;
        Sat,  9 May 2020 12:06:46 +0800 (CST)
Received: from [10.63.139.185] (10.63.139.185) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 12:06:36 +0800
Subject: Re: [PATCH 13/13] crypto: hisilicon/zip - Make negative compression
 not an error
To:     Song Bao Hua <song.bao.hua@hisilicon.com>,
        "tanshukun (A)" <tanshukun1@huawei.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
References: <1588921068-20739-1-git-send-email-tanshukun1@huawei.com>
 <1588921068-20739-14-git-send-email-tanshukun1@huawei.com>
 <B926444035E5E2439431908E3842AFD249C8DC@DGGEMI525-MBS.china.huawei.com>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Xu Zaibo <xuzaibo@huawei.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5EB62C36.3070005@hisilicon.com>
Date:   Sat, 9 May 2020 12:06:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <B926444035E5E2439431908E3842AFD249C8DC@DGGEMI525-MBS.china.huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 2020/5/9 11:25, Song Bao Hua wrote:
>> -----Original Message-----
>> From: linux-crypto-owner@vger.kernel.org [mailto:linux-crypto-owner@vger.kernel.org] On Behalf Of Shukun Tan
>> Sent: Friday, May 8, 2020 6:58 PM
>> To: herbert@gondor.apana.org.au; davem@davemloft.net
>> Cc: linux-crypto@vger.kernel.org; Xu Zaibo <xuzaibo@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>
>> Subject: [PATCH 13/13] crypto: hisilicon/zip - Make negative compression not an error
> 
>> From: Zhou Wang <wangzhou1@hisilicon.com>
> 
>> Users can decide whether to use negative compression result, so it should not be reported as an error by driver.
> 
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>> Signed-off-by: Shukun Tan <tanshukun1@huawei.com>
>> ---
>>  drivers/crypto/hisilicon/zip/zip_crypto.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
>> diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
>> index 5fb9d4b..0f158d4 100644
>> --- a/drivers/crypto/hisilicon/zip/zip_crypto.c
>> +++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
> @@ -341,7 +341,7 @@ static void hisi_zip_acomp_cb(struct hisi_qp *qp, void *data)
>  
>>  	status = sqe->dw3 & HZIP_BD_STATUS_M;
>  
>> -	if (status != 0 && status != HZIP_NC_ERR) {
>> +	if (status != 0) {
> 
> Hi Zhou, it seems your comment is saying we won't report errors for some cases. But the code seems to report more errors by removing the "&&" as the condition becomes weaker.
> Anything have I lost?

My bad here. We already did this in driver. Please drop this patch.

Best,
Zhou

> 
>>  		dev_err(dev, "%scompress fail in qp%u: %u, output: %u\n",
>>  			(qp->alg_type == 0) ? "" : "de", qp->qp_id, status,
>>  			sqe->produced);
> 
> Best Regards
> Barry
> 
> .
> 

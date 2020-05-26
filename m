Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CE81CBE2C
	for <lists+linux-crypto@lfdr.de>; Sat,  9 May 2020 08:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgEIGts (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 9 May 2020 02:49:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4311 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728818AbgEIGts (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 9 May 2020 02:49:48 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F2BE9253CB718FD44F48;
        Sat,  9 May 2020 14:49:46 +0800 (CST)
Received: from [10.63.139.185] (10.63.139.185) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 14:49:37 +0800
Subject: Re: [PATCH 12/13] crypto: hisilicon/zip - Use temporary sqe when
 doing work
To:     Song Bao Hua <song.bao.hua@hisilicon.com>,
        "tanshukun (A)" <tanshukun1@huawei.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
References: <1588921068-20739-1-git-send-email-tanshukun1@huawei.com>
 <1588921068-20739-13-git-send-email-tanshukun1@huawei.com>
 <B926444035E5E2439431908E3842AFD249C8F3@DGGEMI525-MBS.china.huawei.com>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Xu Zaibo <xuzaibo@huawei.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5EB6526A.20804@hisilicon.com>
Date:   Sat, 9 May 2020 14:49:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <B926444035E5E2439431908E3842AFD249C8F3@DGGEMI525-MBS.china.huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 2020/5/9 11:42, Song Bao Hua wrote:
>> -----Original Message-----
>> From: linux-crypto-owner@vger.kernel.org [mailto:linux-crypto-owner@vger.kernel.org] On Behalf Of Shukun Tan
>> Sent: Friday, May 8, 2020 6:58 PM
>> To: herbert@gondor.apana.org.au; davem@davemloft.net
>> Cc: linux-crypto@vger.kernel.org; Xu Zaibo <xuzaibo@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>
>> Subject: [PATCH 12/13] crypto: hisilicon/zip - Use temporary sqe when doing work
> 
>> From: Zhou Wang <wangzhou1@hisilicon.com>
> 
>> Currently zip sqe is stored in hisi_zip_qp_ctx, which will bring corruption with multiple parallel users of the crypto tfm.
> 
>> This patch removes the zip_sqe in hisi_zip_qp_ctx and uses a temporary sqe instead.
> 
> This looks like a quite correct fix as in the old code, the 2nd request will overwrite the zip_sqe of the 1st request if we send the 2nd request before the 1st one is completed.
> So this will lead to the mistakes of both request1 and request2.

Yes.

> 
> unfortunately, it seems the hang issue can still be reproduced with this patch applied if we ask multi-threads running on multi-cores to send requests in parallel. Maybe something more needs fix?

Currently we do not support multi-threads using one crypto_acomp in this driver.
If you tested like this, it may go wrong, as we do not protect queue which is in zip ctx.

Best,
Zhou

> 
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Shukun Tan <tanshukun1@huawei.com>
>> ---
>>  drivers/crypto/hisilicon/zip/zip_crypto.c | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
>> diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
>> index 369ec32..5fb9d4b 100644
>> --- a/drivers/crypto/hisilicon/zip/zip_crypto.c
>> +++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
>> @@ -64,7 +64,6 @@ struct hisi_zip_req_q {
>>  
>>  struct hisi_zip_qp_ctx {
>>  	struct hisi_qp *qp;
>> -	struct hisi_zip_sqe zip_sqe;
>>  	struct hisi_zip_req_q req_q;
>>  	struct hisi_acc_sgl_pool *sgl_pool;
>>  	struct hisi_zip *zip_dev;
>> @@ -484,11 +483,11 @@ static struct hisi_zip_req *hisi_zip_create_req(struct acomp_req *req,  static int hisi_zip_do_work(struct hisi_zip_req *req,
>>  			    struct hisi_zip_qp_ctx *qp_ctx)
>>  {
>> -	struct hisi_zip_sqe *zip_sqe = &qp_ctx->zip_sqe;
>>  	struct acomp_req *a_req = req->req;
>>  	struct hisi_qp *qp = qp_ctx->qp;
>>  	struct device *dev = &qp->qm->pdev->dev;
>>  	struct hisi_acc_sgl_pool *pool = qp_ctx->sgl_pool;
>> +	struct hisi_zip_sqe zip_sqe;
>>  	dma_addr_t input;
>>  	dma_addr_t output;
>>  	int ret;
>> @@ -511,13 +510,13 @@ static int hisi_zip_do_work(struct hisi_zip_req *req,
>>  	}
>>  	req->dma_dst = output;
>>  
>> -	hisi_zip_fill_sqe(zip_sqe, qp->req_type, input, output, a_req->slen,
>> +	hisi_zip_fill_sqe(&zip_sqe, qp->req_type, input, output, a_req->slen,
>>  			  a_req->dlen, req->sskip, req->dskip);
>> -	hisi_zip_config_buf_type(zip_sqe, HZIP_SGL);
>> -	hisi_zip_config_tag(zip_sqe, req->req_id);
>> +	hisi_zip_config_buf_type(&zip_sqe, HZIP_SGL);
>> +	hisi_zip_config_tag(&zip_sqe, req->req_id);
>>  
>>  	/* send command to start a task */
>> -	ret = hisi_qp_send(qp, zip_sqe);
>> +	ret = hisi_qp_send(qp, &zip_sqe);
>>  	if (ret < 0)
>>  		goto err_unmap_output;
>>  
> 
> Best Regards
> Barry
> 
> .
> 

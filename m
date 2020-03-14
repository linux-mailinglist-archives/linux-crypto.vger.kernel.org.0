Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF71185923
	for <lists+linux-crypto@lfdr.de>; Sun, 15 Mar 2020 03:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgCOCfv (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 14 Mar 2020 22:35:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11649 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726840AbgCOCfv (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 14 Mar 2020 22:35:51 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 87C62D1832B87DD2F636;
        Sat, 14 Mar 2020 18:49:34 +0800 (CST)
Received: from [127.0.0.1] (10.173.223.234) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Sat, 14 Mar 2020
 18:49:33 +0800
Subject: Re: [PATCH net-next] chcr: remove set but not used variable 'status'
To:     <ayush.sawal@chelsio.com>, <vinay.yadav@chelsio.com>,
        <rohitm@chelsio.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>
References: <20200314101915.25008-1-yuehaibing@huawei.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <73fd96bd-efa9-b1a0-68b5-788d590e6d38@huawei.com>
Date:   Sat, 14 Mar 2020 18:49:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20200314101915.25008-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This should apply to net-next, will resend.

On 2020/3/14 18:19, YueHaibing wrote:
> drivers/crypto/chelsio/chcr_ktls.c: In function chcr_ktls_cpl_set_tcb_rpl:
> drivers/crypto/chelsio/chcr_ktls.c:662:11: warning:
>  variable status set but not used [-Wunused-but-set-variable]
> 
> commit 8a30923e1598 ("cxgb4/chcr: Save tx keys and handle HW response")
> involved this unused variable, remove it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/crypto/chelsio/chcr_ktls.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/chelsio/chcr_ktls.c b/drivers/crypto/chelsio/chcr_ktls.c
> index f0c3834eda4f..00099e793e63 100644
> --- a/drivers/crypto/chelsio/chcr_ktls.c
> +++ b/drivers/crypto/chelsio/chcr_ktls.c
> @@ -659,10 +659,9 @@ int chcr_ktls_cpl_set_tcb_rpl(struct adapter *adap, unsigned char *input)
>  	const struct cpl_set_tcb_rpl *p = (void *)input;
>  	struct chcr_ktls_info *tx_info = NULL;
>  	struct tid_info *t;
> -	u32 tid, status;
> +	u32 tid;
>  
>  	tid = GET_TID(p);
> -	status = p->status;
>  
>  	t = &adap->tids;
>  	tx_info = lookup_tid(t, tid);
> 


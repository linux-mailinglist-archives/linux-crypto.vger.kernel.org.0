Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F36C17B4AA
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Mar 2020 03:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCFCuC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 5 Mar 2020 21:50:02 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11160 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726351AbgCFCuC (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 5 Mar 2020 21:50:02 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C23742D16CA3E2772B25;
        Fri,  6 Mar 2020 10:50:00 +0800 (CST)
Received: from [127.0.0.1] (10.63.139.185) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Mar 2020
 10:49:50 +0800
Subject: Re: [PATCH v2] crypto: hisilicon - qm depends on UACCE
To:     Herbert Xu <herbert@gondor.apana.org.au>
References: <1582787548-28201-1-git-send-email-wangzhou1@hisilicon.com>
 <20200306015132.GI30653@gondor.apana.org.au>
CC:     "David S. Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, Hongbo Yao <yaohongbo@huawei.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5E61BA4D.1090502@hisilicon.com>
Date:   Fri, 6 Mar 2020 10:49:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20200306015132.GI30653@gondor.apana.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 2020/3/6 9:51, Herbert Xu wrote:
> On Thu, Feb 27, 2020 at 03:12:28PM +0800, Zhou Wang wrote:
>> From: Hongbo Yao <yaohongbo@huawei.com>
>>
>> If UACCE=m and CRYPTO_DEV_HISI_QM=y, the following error
>> is seen while building qm.o:
>>
>> drivers/crypto/hisilicon/qm.o: In function `hisi_qm_init':
>> (.text+0x23c6): undefined reference to `uacce_alloc'
>> (.text+0x2474): undefined reference to `uacce_remove'
>> (.text+0x286b): undefined reference to `uacce_remove'
>> drivers/crypto/hisilicon/qm.o: In function `hisi_qm_uninit':
>> (.text+0x2918): undefined reference to `uacce_remove'
>> make[1]: *** [vmlinux] Error 1
>> make: *** [autoksyms_recursive] Error 2
>>
>> This patch fixes the config dependency for QM and ZIP.
>>
>> reported-by: Hulk Robot <hulkci@huawei.com>
>> Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
>> Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>> ---
>>  drivers/crypto/hisilicon/Kconfig | 2 ++
>>  1 file changed, 2 insertions(+)
> 
> Patch applied.  Thanks.

Thanks and Best,

Zhou

> 


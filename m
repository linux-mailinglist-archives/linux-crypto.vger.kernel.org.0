Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 122A4DE2CF
	for <lists+linux-crypto@lfdr.de>; Mon, 21 Oct 2019 05:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfJUDxS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 20 Oct 2019 23:53:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51480 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726847AbfJUDxS (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 20 Oct 2019 23:53:18 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E90B5860FE84CA23C83D;
        Mon, 21 Oct 2019 11:53:15 +0800 (CST)
Received: from [127.0.0.1] (10.63.139.185) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Mon, 21 Oct 2019
 11:53:10 +0800
Subject: Re: [PATCH 1/2] crypto: hisilicon - select NEED_SG_DMA_LENGTH in qm
 Kconfig
To:     Herbert Xu <herbert@gondor.apana.org.au>
References: <1570792690-74597-1-git-send-email-wangzhou1@hisilicon.com>
 <20191018080433.GH25128@gondor.apana.org.au>
CC:     "David S. Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5DAD2BA5.7050805@hisilicon.com>
Date:   Mon, 21 Oct 2019 11:53:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20191018080433.GH25128@gondor.apana.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 2019/10/18 16:04, Herbert Xu wrote:
> On Fri, Oct 11, 2019 at 07:18:10PM +0800, Zhou Wang wrote:
>> To avoid compile error in some platforms, select NEED_SG_DMA_LENGTH in
>> qm Kconfig.
>>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>> Reported-by: kbuild test robot <lkp@intel.com>
>> ---
>>  drivers/crypto/hisilicon/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
> 
> Patch applied.  Thanks.

Thanks :)

> 


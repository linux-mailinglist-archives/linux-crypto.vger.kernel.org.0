Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E77D11AA25
	for <lists+linux-crypto@lfdr.de>; Wed, 11 Dec 2019 12:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfLKLpd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 11 Dec 2019 06:45:33 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727365AbfLKLpd (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 11 Dec 2019 06:45:33 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4CA078F1AA9E42983428;
        Wed, 11 Dec 2019 19:45:30 +0800 (CST)
Received: from [127.0.0.1] (10.63.139.185) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 11 Dec 2019
 19:45:22 +0800
Subject: Re: [PATCH 0/3] crypto: hisilicon - Misc qm/zip fixes
To:     Herbert Xu <herbert@gondor.apana.org.au>
References: <1574142178-76514-1-git-send-email-wangzhou1@hisilicon.com>
 <20191211093135.2htsnguoke5ngvv3@gondor.apana.org.au>
CC:     "David S. Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linuxarm@huawei.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5DF0D6D1.5050307@hisilicon.com>
Date:   Wed, 11 Dec 2019 19:45:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20191211093135.2htsnguoke5ngvv3@gondor.apana.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 2019/12/11 17:31, Herbert Xu wrote:
> On Tue, Nov 19, 2019 at 01:42:55PM +0800, Zhou Wang wrote:
>> These patches are independent fixes about qm and zip.
>>
>> Jonathan Cameron (2):
>>   crypto: hisilicon - Fix issue with wrong number of sg elements after
>>     dma map
>>   crypto: hisilicon - Use the offset fields in sqe to avoid need to
>>     split scatterlists
>>
>> Zhou Wang (1):
>>   crypto: hisilicon - Remove useless MODULE macros
>>
>>  drivers/crypto/hisilicon/Kconfig          |  1 -
>>  drivers/crypto/hisilicon/sgl.c            | 17 +++---
>>  drivers/crypto/hisilicon/zip/zip.h        |  4 ++
>>  drivers/crypto/hisilicon/zip/zip_crypto.c | 92 ++++++++-----------------------
>>  4 files changed, 35 insertions(+), 79 deletions(-)
> 
> All applied.  Thanks.

Thanks!

> 


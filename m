Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDDBEBE4E
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Nov 2019 08:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfKAHEX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 1 Nov 2019 03:04:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5678 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727038AbfKAHEX (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 1 Nov 2019 03:04:23 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E5EF8A8D770151638263;
        Fri,  1 Nov 2019 15:04:20 +0800 (CST)
Received: from [127.0.0.1] (10.63.139.185) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Fri, 1 Nov 2019
 15:04:16 +0800
Subject: Re: [PATCH] crypto: hisilicon - use sgl API to get sgl dma addr and
 len
To:     Herbert Xu <herbert@gondor.apana.org.au>
References: <1572058641-173376-1-git-send-email-wangzhou1@hisilicon.com>
 <20191101061307.xu2d7hjjhxddlzyw@gondor.apana.org.au>
CC:     "David S. Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5DBBD8F1.2020605@hisilicon.com>
Date:   Fri, 1 Nov 2019 15:04:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20191101061307.xu2d7hjjhxddlzyw@gondor.apana.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 2019/11/1 14:13, Herbert Xu wrote:
> On Sat, Oct 26, 2019 at 10:57:21AM +0800, Zhou Wang wrote:
>> Use sgl API to get sgl dma addr and len, this will help to avoid compile
>> error in some platforms. So NEED_SG_DMA_LENGTH can be removed here, which
>> can only be selected by arch code.
>>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>> Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
>> ---
>>  drivers/crypto/hisilicon/Kconfig | 1 -
>>  drivers/crypto/hisilicon/sgl.c   | 4 ++--
>>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> Patch applied.  Thanks.

Thanks.

> 


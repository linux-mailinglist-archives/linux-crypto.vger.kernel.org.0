Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE2B8ED8E
	for <lists+linux-crypto@lfdr.de>; Thu, 15 Aug 2019 16:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbfHOOAX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 15 Aug 2019 10:00:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4715 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731849AbfHOOAX (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 15 Aug 2019 10:00:23 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F3DA76031D735BFCD28E;
        Thu, 15 Aug 2019 22:00:19 +0800 (CST)
Received: from [127.0.0.1] (10.63.139.185) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Thu, 15 Aug 2019
 22:00:11 +0800
Subject: Re: [PATCH 0/5] crypto: hisilicon: Misc fixes
To:     Herbert Xu <herbert@gondor.apana.org.au>
References: <1565774919-31853-1-git-send-email-wangzhou1@hisilicon.com>
 <20190815120838.GA29793@gondor.apana.org.au>
CC:     <davem@davemloft.net>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5D55656B.6040907@hisilicon.com>
Date:   Thu, 15 Aug 2019 22:00:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190815120838.GA29793@gondor.apana.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 2019/8/15 20:08, Herbert Xu wrote:
> On Wed, Aug 14, 2019 at 05:28:34PM +0800, Zhou Wang wrote:
>> Patch 1~3 are fixes about kbuild errors, patch 4,5 are tiny fixes about qm
>> and zip.
>>
>> This series is based on cryptodev-2.6.
>>
>> Zhou Wang (5):
>>   crypto: hisilicon - fix kbuild warnings
>>   crypto: hisilicon - add dependency for CRYPTO_DEV_HISI_ZIP
>>   crypto: hisilicon - init curr_sgl_dma to fix compile warning
>>   crypto: hisilicon - add missing single_release
>>   crypto: hisilicon - fix error handle in hisi_zip_create_req_q
>>
>>  drivers/crypto/hisilicon/Kconfig          | 1 +
>>  drivers/crypto/hisilicon/qm.c             | 7 ++++---
>>  drivers/crypto/hisilicon/sgl.c            | 2 +-
>>  drivers/crypto/hisilicon/zip/zip_crypto.c | 6 ++++--
>>  4 files changed, 10 insertions(+), 6 deletions(-)
> 
> All applied.  Thanks.
> 

Thanks for taking this series!


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D874730A0AA
	for <lists+linux-crypto@lfdr.de>; Mon,  1 Feb 2021 04:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhBADqH (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 31 Jan 2021 22:46:07 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11993 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbhBADqG (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 31 Jan 2021 22:46:06 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DTYhn0WRRzjH7m;
        Mon,  1 Feb 2021 11:44:09 +0800 (CST)
Received: from [10.67.103.10] (10.67.103.10) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Mon, 1 Feb 2021
 11:45:16 +0800
Subject: Re: [PATCH v7 4/7] crypto: add ecc curve and expose them
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     <davem@davemloft.net>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>,
        <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        "Daniele Alessandrelli" <daniele.alessandrelli@linux.intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Khurana, Prabhjot" <prabhjot.khurana@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>
References: <1611299395-675-1-git-send-email-yumeng18@huawei.com>
 <1611299395-675-5-git-send-email-yumeng18@huawei.com>
 <20210128050354.GA30874@gondor.apana.org.au>
From:   yumeng <yumeng18@huawei.com>
Message-ID: <f319d30d-4bd5-a8de-bd0a-bde9e6838ed1@huawei.com>
Date:   Mon, 1 Feb 2021 11:45:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210128050354.GA30874@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.10]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org



ÔÚ 2021/1/28 13:03, Herbert Xu Ð´µÀ:
> On Fri, Jan 22, 2021 at 03:09:52PM +0800, Meng Yu wrote:
>> 1. Add ecc curves(P224, P384, P521) for ECDH;
> 
> OK I think this is getting unwieldy.
> 
> In light of the fact that we already have hardware that supports
> a specific subset of curves, I think perhaps it would be better
> to move the curve ID from the key into the algorithm name instead.
> 
> IOW, instead of allocating ecdh, you would allocate ecdh-nist-pXXX.
> 
> Any comments?
> 
> Thanks,
> 

Yes£¬It is a good idea, thank you!

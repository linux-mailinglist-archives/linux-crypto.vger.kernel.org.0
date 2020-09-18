Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF1426EA6E
	for <lists+linux-crypto@lfdr.de>; Fri, 18 Sep 2020 03:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgIRBZ1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 17 Sep 2020 21:25:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13246 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726055AbgIRBZ1 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 17 Sep 2020 21:25:27 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 94FC8C7571C518629ECF;
        Fri, 18 Sep 2020 09:25:25 +0800 (CST)
Received: from [10.174.179.91] (10.174.179.91) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 09:25:23 +0800
Subject: Re: [PATCH -next] crypto: caam: Convert to DEFINE_SHOW_ATTRIBUTE
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        <gregkh@linuxfoundation.org>, <aymen.sghaier@nxp.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200723072511.GA6095@gondor.apana.org.au>
 <62dc973d-71b6-c8ec-9f7a-f1c421a7b1d3@huawei.com>
 <20200725120552.GA20145@gondor.apana.org.au>
From:   miaoqinglang <miaoqinglang@huawei.com>
Message-ID: <b1808cad-a481-432e-3c49-5d49375dc652@huawei.com>
Date:   Fri, 18 Sep 2020 09:25:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200725120552.GA20145@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org



ÔÚ 2020/7/25 20:05, Herbert Xu Ð´µÀ:
> On Sat, Jul 25, 2020 at 05:00:02PM +0800, miaoqinglang wrote:
>>
>> Or If you don't mind, I can resend a patch besed on mainline rather than
>> -next now.
> 
> Please don't as that will just cause more conflicts.
> 
Hi Herbert,

I've resent a new patch against linux-next(20200917), and it can
be applied to mainline cleanly now. There won't be conflicts anymore,

Thanks.

> Thanks,
> 

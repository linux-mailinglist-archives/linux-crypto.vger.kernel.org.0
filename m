Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F21CCF8952
	for <lists+linux-crypto@lfdr.de>; Tue, 12 Nov 2019 08:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfKLHIh (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 12 Nov 2019 02:08:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6637 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725781AbfKLHIg (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 12 Nov 2019 02:08:36 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 239FFB84DB08AD78415;
        Tue, 12 Nov 2019 15:08:27 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 12 Nov 2019
 15:08:25 +0800
Subject: Re: [PATCH -next] crypto: sun8i-ss - Fix memdup.cocci warnings
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
References: <20191109024403.47106-1-yuehaibing@huawei.com>
 <20191112070309.GA18647@Red>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <43dff5e6-dc85-a631-2e6a-1dc07540e5a4@huawei.com>
Date:   Tue, 12 Nov 2019 15:08:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20191112070309.GA18647@Red>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 2019/11/12 15:03, Corentin Labbe wrote:
> On Sat, Nov 09, 2019 at 02:44:03AM +0000, YueHaibing wrote:
>> Use kmemdup rather than duplicating its implementation
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
> 
> Hello
> 
> Thanks but the patch was already sent by kbuild robot and merged.

Sorry, this patch title should be "sun8i-ce" instead of "sun8i-ss",

kbuild robot indeed fix 'sun8i-ss' warning,  will resend v2.

> 
> Regards
> 
> 


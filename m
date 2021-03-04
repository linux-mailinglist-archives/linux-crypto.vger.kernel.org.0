Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14AD132CC3C
	for <lists+linux-crypto@lfdr.de>; Thu,  4 Mar 2021 06:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbhCDF5p (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 4 Mar 2021 00:57:45 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13429 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbhCDF5T (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 4 Mar 2021 00:57:19 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Drg7h1zJ1zjV5c;
        Thu,  4 Mar 2021 13:55:12 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Mar 2021 13:56:28 +0800
Subject: Re: [PATCH 3/3] crypto: hisilicon/sec - fixes shash test error
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     <wangzhou1@hisilicon.com>, <xuzaibo@huawei.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Ard Biesheuvel" <ardb@kernel.org>
References: <1612519857-30714-1-git-send-email-liulongfang@huawei.com>
 <1612519857-30714-4-git-send-email-liulongfang@huawei.com>
 <20210205114435.GA17031@gondor.apana.org.au>
 <6e5d529d-07df-5db0-d5c0-72e90e13852d@huawei.com>
 <20210304044109.GA25972@gondor.apana.org.au>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <43a4ee70-ac0c-b72c-3f37-1df5eced8aac@huawei.com>
Date:   Thu, 4 Mar 2021 13:56:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210304044109.GA25972@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 2021/3/4 12:41, Herbert Xu wrote:
> On Sat, Feb 20, 2021 at 05:51:22PM +0800, liulongfang wrote:
> .
>> Since patch3 is an unnecessary patch,
>> can you just remove it and merge patch1 and patch2?
> 
> Please repost.
> 
> Thanks,
> 
Ok.
Thanks,
Longfang

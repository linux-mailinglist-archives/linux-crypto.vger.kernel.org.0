Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8256FD05CA
	for <lists+linux-crypto@lfdr.de>; Wed,  9 Oct 2019 05:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbfJIDP1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 8 Oct 2019 23:15:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34394 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726490AbfJIDP1 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 8 Oct 2019 23:15:27 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B840BF727BB0DF941D83;
        Wed,  9 Oct 2019 11:15:25 +0800 (CST)
Received: from [127.0.0.1] (10.57.77.109) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 9 Oct 2019
 11:15:16 +0800
Subject: Re: [PATCH 0/5] crypto: hisilicon - add HPRE support
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
References: <1569835209-44326-1-git-send-email-xuzaibo@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linuxarm@huawei.com>, <forest.zhouchang@huawei.com>
From:   Xu Zaibo <xuzaibo@huawei.com>
Message-ID: <261ec663-1842-d3c0-89df-da756b7ed287@huawei.com>
Date:   Wed, 9 Oct 2019 11:15:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1569835209-44326-1-git-send-email-xuzaibo@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.77.109]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi,


On 2019/9/30 17:20, Zaibo Xu wrote:
> This series adds HiSilicon high performance RSA engine(HPRE) driver
> in crypto subsystem. HPRE driver provides PCIe hardware device initiation
> with RSA and DH algorithms registered to Crypto. Meanwhile, some debug
> supporting of DebugFS is given.
>
> Zaibo Xu (5):
>    crypto: hisilicon - add HiSilicon HPRE accelerator
>    crypto: hisilicon - add SRIOV support for HPRE
>    Documentation: Add debugfs doc for hisi_hpre
>    crypto: hisilicon: Add debugfs for HPRE
>    MAINTAINERS: Add maintainer for HiSilicon HPRE driver
>
>   Documentation/ABI/testing/debugfs-hisi-hpre |   57 ++
>   MAINTAINERS                                 |    9 +
>   drivers/crypto/hisilicon/Kconfig            |   11 +
>   drivers/crypto/hisilicon/Makefile           |    1 +
>   drivers/crypto/hisilicon/hpre/Makefile      |    2 +
>   drivers/crypto/hisilicon/hpre/hpre.h        |   83 ++
>   drivers/crypto/hisilicon/hpre/hpre_crypto.c | 1137 +++++++++++++++++++++++++++
>   drivers/crypto/hisilicon/hpre/hpre_main.c   | 1052 +++++++++++++++++++++++++
>   8 files changed, 2352 insertions(+)
>   create mode 100644 Documentation/ABI/testing/debugfs-hisi-hpre
>   create mode 100644 drivers/crypto/hisilicon/hpre/Makefile
>   create mode 100644 drivers/crypto/hisilicon/hpre/hpre.h
>   create mode 100644 drivers/crypto/hisilicon/hpre/hpre_crypto.c
>   create mode 100644 drivers/crypto/hisilicon/hpre/hpre_main.c
>
Any comments for this version?

Best,
Zaibo


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72AE6165A7B
	for <lists+linux-crypto@lfdr.de>; Thu, 20 Feb 2020 10:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgBTJuK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 20 Feb 2020 04:50:10 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2446 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726759AbgBTJuK (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 20 Feb 2020 04:50:10 -0500
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id A024241A6EDEDEE025EB;
        Thu, 20 Feb 2020 09:50:07 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML713-CAH.china.huawei.com (10.201.108.36) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 20 Feb 2020 09:50:07 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 20 Feb
 2020 09:50:07 +0000
Subject: Re: [PATCH 4/4] crypto: hisilicon/sec2 - Add pbuffer mode for SEC
 driver
To:     Zaibo Xu <xuzaibo@huawei.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>
CC:     <qianweili@huawei.com>, <tanghui20@huawei.com>,
        <forest.zhouchang@huawei.com>, <linuxarm@huawei.com>,
        <zhangwei375@huawei.com>, <shenyang39@huawei.com>,
        <yekai13@huawei.com>, <linux-crypto@vger.kernel.org>
References: <1582189495-38051-1-git-send-email-xuzaibo@huawei.com>
 <1582189495-38051-5-git-send-email-xuzaibo@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <011d8794-b4ab-a5ad-b765-e6e2c09991aa@huawei.com>
Date:   Thu, 20 Feb 2020 09:50:06 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1582189495-38051-5-git-send-email-xuzaibo@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 20/02/2020 09:04, Zaibo Xu wrote:
> From: liulongfang <liulongfang@huawei.com>
> 
> In the scenario of SMMU translation, the SEC performance of short messages
> (<512Bytes) cannot meet our expectations. To avoid this, we reserve the
> plat buffer (PBUF) memory for small packets when creating TFM.
> 

I haven't gone through the code here, but why not use this method also 
for non-translated? What are the pros and cons?

The commit message is very light on details.

Thanks
john


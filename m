Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1CF31769F8
	for <lists+linux-crypto@lfdr.de>; Tue,  3 Mar 2020 02:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgCCBZs (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 2 Mar 2020 20:25:48 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39602 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbgCCBZs (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 2 Mar 2020 20:25:48 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E88E9D1ECAAC6DC48451;
        Tue,  3 Mar 2020 09:25:46 +0800 (CST)
Received: from [127.0.0.1] (10.67.101.242) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Mar 2020
 09:25:36 +0800
Subject: Re: [PATCH v2 3/5] crypto: hisilicon/sec2 - Add iommu status check
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <1583129716-28382-1-git-send-email-xuzaibo@huawei.com>
 <1583129716-28382-4-git-send-email-xuzaibo@huawei.com>
 <20200302115409.0000685e@Huawei.com>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <qianweili@huawei.com>, <tanghui20@huawei.com>,
        <forest.zhouchang@huawei.com>, <linuxarm@huawei.com>,
        <zhangwei375@huawei.com>, <yekai13@huawei.com>,
        <linux-crypto@vger.kernel.org>
From:   Xu Zaibo <xuzaibo@huawei.com>
Message-ID: <91e74cb0-0a1f-a222-68cb-745a0d5f5ea5@huawei.com>
Date:   Tue, 3 Mar 2020 09:25:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200302115409.0000685e@Huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.242]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi,


On 2020/3/2 19:54, Jonathan Cameron wrote:
> On Mon, 2 Mar 2020 14:15:14 +0800
> Zaibo Xu <xuzaibo@huawei.com> wrote:
>
>> From: liulongfang <liulongfang@huawei.com>
>>
>> In order to improve performance of small packets (<512Bytes)
>> in SMMU translation scenario,We need to identify the type of IOMMU
>> in the SEC probe to process small packets by a different method.
>>
>> Signed-off-by: liulongfang <liulongfang@huawei.com>
>> Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
> This looks like what we ended up with for the SECv1 driver.
Yes.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Okay

.
>> ---
>>   drivers/crypto/hisilicon/sec2/sec.h      |  1 +
>>   drivers/crypto/hisilicon/sec2/sec_main.c | 19 +++++++++++++++++++
>>   2 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
>> index 13e2d8d..eab0d22 100644
>> --- a/drivers/crypto/hisilicon/sec2/sec.h
>> +++ b/drivers/crypto/hisilicon/sec2/sec.h
>> @@ -165,6 +165,7 @@ struct sec_dev {
>>   	struct list_head list;
>>   	struct sec_debug debug;
>>   	u32 ctx_q_num;
>> +	bool iommu_used;
>>   	u32 num_vfs;
>>   	unsigned long status;
>>   };
>> diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
>> index ebafc1c..6466d90 100644
>> --- a/drivers/crypto/hisilicon/sec2/sec_main.c
>> +++ b/drivers/crypto/hisilicon/sec2/sec_main.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/debugfs.h>
>>   #include <linux/init.h>
>>   #include <linux/io.h>
>> +#include <linux/iommu.h>
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/pci.h>
>> @@ -826,6 +827,23 @@ static void sec_probe_uninit(struct hisi_qm *qm)
>>   	destroy_workqueue(qm->wq);
>>   }
>>   
>> +static void sec_iommu_used_check(struct sec_dev *sec)
>> +{
>> +	struct iommu_domain *domain;
>> +	struct device *dev = &sec->qm.pdev->dev;
>> +
>> +	domain = iommu_get_domain_for_dev(dev);
>> +
>> +	/* Check if iommu is used */
>> +	sec->iommu_used = false;
>> +	if (domain) {
>> +		if (domain->type & __IOMMU_DOMAIN_PAGING)
>> +			sec->iommu_used = true;
>> +		dev_info(dev, "SMMU Opened, the iommu type = %u\n",
>> +			domain->type);
>> +	}
>> +}
>> +
>>   static int sec_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   {
>>   	struct sec_dev *sec;
>> @@ -839,6 +857,7 @@ static int sec_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	pci_set_drvdata(pdev, sec);
>>   
>>   	sec->ctx_q_num = ctx_q_num;
>> +	sec_iommu_used_check(sec);
>>   
>>   	qm = &sec->qm;
>>   
>
> .
>



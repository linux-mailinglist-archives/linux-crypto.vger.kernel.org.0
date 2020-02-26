Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA7C116F4EA
	for <lists+linux-crypto@lfdr.de>; Wed, 26 Feb 2020 02:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgBZBQp (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 25 Feb 2020 20:16:45 -0500
Received: from mga03.intel.com ([134.134.136.65]:24629 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729170AbgBZBQo (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 25 Feb 2020 20:16:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 17:16:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,486,1574150400"; 
   d="scan'208";a="226547626"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga007.jf.intel.com with ESMTP; 25 Feb 2020 17:16:38 -0800
Subject: Re: [PATCH] MAINTAINERS: add maintainers for uacce
To:     zhangfei <zhangfei.gao@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jonathan.cameron@huawei.com, grant.likely@arm.com,
        jean-philippe <jean-philippe@linaro.org>,
        Jerome Glisse <jglisse@redhat.com>,
        ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        "haojian . zhuang" <haojian.zhuang@linaro.org>,
        guodong.xu@linaro.org
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org
References: <1582611475-32691-1-git-send-email-zhangfei.gao@linaro.org>
 <b424d911-7293-0048-3270-0f7c1502c928@intel.com>
 <0ed68faa-63f1-2bcb-6044-11629a610b9b@linaro.org>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <1cd21ae1-f318-e15c-a155-c34483d9ff56@intel.com>
Date:   Tue, 25 Feb 2020 18:16:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0ed68faa-63f1-2bcb-6044-11629a610b9b@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org



On 2/25/20 6:11 PM, zhangfei wrote:
> 
> 
> On 2020/2/26 上午12:02, Dave Jiang wrote:
>>
>>
>> On 2/24/20 11:17 PM, Zhangfei Gao wrote:
>>> Add Zhangfei Gao and Zhou Wang as maintainers for uacce
>>>
>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>>> ---
>>>   MAINTAINERS | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 38fe2f3..22e647f 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -17039,6 +17039,16 @@ W:    http://linuxtv.org
>>>   S:    Maintained
>>>   F:    drivers/media/pci/tw686x/
>>>   +UACCE ACCELERATOR FRAMEWORK
>>> +M:    Zhangfei Gao <zhangfei.gao@linaro.org>
>>> +M:    Zhou Wang <wangzhou1@hisilicon.com>
>>> +S:    Maintained
>>> +F:    Documentation/ABI/testing/sysfs-driver-uacce
>>> +F:    Documentation/misc-devices/uacce.rst
>>> +F:    drivers/misc/uacce/
>>> +F:    include/linux/uacce.h
>>> +F:    include/uapi/misc/uacce/
>>
>> Mailing list for patch submission?
>> +L: linux-accelerators@lists.ozlabs.org ?
> 
> Thanks Dave
> 
> How about adding both
> linux-accelerators@lists.ozlabs.org
> linux-kernel@vger.kernel.org
> Since the patches will go to misc tree.

That is entirely up to you. But having guidance on somewhere to submit 
patches will be good.

> 
> Thanks

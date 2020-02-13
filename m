Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0105315C817
	for <lists+linux-crypto@lfdr.de>; Thu, 13 Feb 2020 17:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgBMQTU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 13 Feb 2020 11:19:20 -0500
Received: from os.inf.tu-dresden.de ([141.76.48.99]:51834 "EHLO
        os.inf.tu-dresden.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbgBMQTU (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 13 Feb 2020 11:19:20 -0500
Received: from [2002:8d4c:3001:48::120:84]
        by os.inf.tu-dresden.de with esmtpsa (TLS1.3:TLS_AES_128_GCM_SHA256:128) (Exim 4.93.0.3)
        id 1j2HCw-0004Br-Lm; Thu, 13 Feb 2020 17:19:18 +0100
Subject: Re: Remove WQ_CPU_INTENSIVE flag from unbound wq's
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Song Liu <song@kernel.org>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-erofs@lists.ozlabs.org
References: <20200213141823.2174236-1-mplaneta@os.inf.tu-dresden.de>
 <20200213153645.GA11313@redhat.com>
From:   Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Message-ID: <82715589-8b59-5cfd-a32f-1e57871327fe@os.inf.tu-dresden.de>
Date:   Thu, 13 Feb 2020 17:19:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200213153645.GA11313@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org



On 13/02/2020 16:36, Mike Snitzer wrote:
> On Thu, Feb 13 2020 at  9:18am -0500,
> Maksym Planeta <mplaneta@os.inf.tu-dresden.de> wrote:
> 
>> The documentation [1] says that WQ_CPU_INTENSIVE is "meaningless" for
>> unbound wq. I remove this flag from places where unbound queue is
>> allocated. This is supposed to improve code readability.
>>
>> 1. https://www.kernel.org/doc/html/latest/core-api/workqueue.html#flags
>>
>> Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
> 
> What the Documentation says aside, have you cross referenced with the
> code?  And/or have you done benchmarks to verify no changes?
> 

It seems so from the code. Although, I'm not 100% confident. I did not 
run benchmarks, instead I relied that on the assumption that 
documentation is correct.

> Thanks,
> Mike
> 

-- 
Regards,
Maksym Planeta

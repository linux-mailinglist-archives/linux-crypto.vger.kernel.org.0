Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1A823C043
	for <lists+linux-crypto@lfdr.de>; Tue,  4 Aug 2020 21:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgHDTpQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 4 Aug 2020 15:45:16 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:48920 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHDTpP (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 4 Aug 2020 15:45:15 -0400
Received: from [192.168.254.5] (unknown [50.34.202.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 28ED713C2B0;
        Tue,  4 Aug 2020 12:45:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 28ED713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1596570315;
        bh=PJwz/qlqM3M13CuJTrZ3ZbPJEoZhYExma9u4TbEaEM8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oIqek+2TZcmgaDMAl5nuLLwxOibhPX1tSLPUx4ni4/HcOHNQRmTK9ddGjlNhjHxlC
         jNeXU8YAsggqAxpNF8ZrS9h3liSEEzjU4Se+lNzbW6YQjsme3FtSHv8ssM/uTrd+zG
         2jIC4cxJRoCUhG5BOKvrh1h0I8YnMxfaxUztabqo=
Subject: Re: [PATCH] crypto: x86/aesni - implement accelerated CBCMAC, CMAC
 and XCBC shashes
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@kernel.org>
References: <20200802090616.1328-1-ardb@kernel.org>
 <25776a56-4c6a-3976-f4bc-fa53ba4a1550@candelatech.com>
 <CAMj1kXFAbip567hFaFtoqdevrSEpqFOGQ1+ejL98XrDOaTeggA@mail.gmail.com>
 <9c137bbf-2892-df7a-e6fa-8cce417ecd45@candelatech.com>
 <CAMj1kXFnfYKj1JE4NLsxXtaeKuAOKyBYDbayLr-mHDUYqnV1bA@mail.gmail.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <d7f44f7a-d00e-cef4-5c91-86119e240038@candelatech.com>
Date:   Tue, 4 Aug 2020 12:45:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXFnfYKj1JE4NLsxXtaeKuAOKyBYDbayLr-mHDUYqnV1bA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 8/4/20 6:08 AM, Ard Biesheuvel wrote:
> On Tue, 4 Aug 2020 at 15:01, Ben Greear <greearb@candelatech.com> wrote:
>>
>> On 8/4/20 5:55 AM, Ard Biesheuvel wrote:
>>> On Mon, 3 Aug 2020 at 21:11, Ben Greear <greearb@candelatech.com> wrote:
>>>>
>>>> Hello,
>>>>
>>>> This helps a bit...now download sw-crypt performance is about 150Mbps,
>>>> but still not as good as with my patch on 5.4 kernel, and fpu is still
>>>> high in perf top:
>>>>
>>>>       13.89%  libc-2.29.so   [.] __memset_sse2_unaligned_erms
>>>>         6.62%  [kernel]       [k] kernel_fpu_begin
>>>>         4.14%  [kernel]       [k] _aesni_enc1
>>>>         2.06%  [kernel]       [k] __crypto_xor
>>>>         1.95%  [kernel]       [k] copy_user_generic_string
>>>>         1.93%  libjvm.so      [.] SpinPause
>>>>         1.01%  [kernel]       [k] aesni_encrypt
>>>>         0.98%  [kernel]       [k] crypto_ctr_crypt
>>>>         0.93%  [kernel]       [k] udp_sendmsg
>>>>         0.78%  [kernel]       [k] crypto_inc
>>>>         0.74%  [kernel]       [k] __ip_append_data.isra.53
>>>>         0.65%  [kernel]       [k] aesni_cbc_enc
>>>>         0.64%  [kernel]       [k] __dev_queue_xmit
>>>>         0.62%  [kernel]       [k] ipt_do_table
>>>>         0.62%  [kernel]       [k] igb_xmit_frame_ring
>>>>         0.59%  [kernel]       [k] ip_route_output_key_hash_rcu
>>>>         0.57%  [kernel]       [k] memcpy
>>>>         0.57%  libjvm.so      [.] InstanceKlass::oop_follow_contents
>>>>         0.56%  [kernel]       [k] irq_fpu_usable
>>>>         0.56%  [kernel]       [k] mac_do_update
>>>>
>>>> If you'd like help setting up a test rig and have an ath10k pcie NIC or ath9k pcie NIC,
>>>> then I can help.  Possibly hwsim would also be a good test case, but I have not tried
>>>> that.
>>>>
>>>
>>> I don't think this is likely to be reproducible on other
>>> micro-architectures, so setting up a test rig is unlikely to help.
>>>
>>> I'll send out a v2 which implements a ahash instead of a shash (and
>>> implements some other tweaks) so that kernel_fpu_begin() is only
>>> called twice for each packet on the cbcmac path.
>>>
>>> Do you have any numbers for the old kernel without your patch? This
>>> pathological FPU preserve/restore behavior could be caused be the
>>> optimizations, or by other changes that landed in the meantime, so I
>>> would like to know if kernel_fpu_begin() is as prominent in those
>>> traces as well.
>>>
>>
>> This same patch makes i7 mobile processors able to handle 1Gbps+ software
>> decrypt rates, where without the patch, the rate was badly constrained and CPU
>> load was much higher, so it is definitely noticeable on other processors too.
> 
> OK
> 
>> The weak processor on the current test rig is convenient because the problem
>> is so noticeable even at slower wifi speeds.
>>
>> We can do some tests on 5.4 with our patch reverted.
>>
> 
> The issue with your CCM patch is that it keeps the FPU enabled for the
> entire input, which also means that preemption is disabled, which
> makes the -rt people grumpy. (Of course, it also uses APIs that no
> longer exists, but that should be easy to fix)
> 
> Do you happen to have any ballpark figures for the packet sizes and
> the time spent doing encryption?
> 

My tester reports this last patch appears to break wpa-2 entirely, so we
cannot test it as is.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

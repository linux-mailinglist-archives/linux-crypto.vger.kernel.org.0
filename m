Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19BC233B9A
	for <lists+linux-crypto@lfdr.de>; Fri, 31 Jul 2020 00:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbgG3W5B (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 30 Jul 2020 18:57:01 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:47164 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgG3W5B (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 30 Jul 2020 18:57:01 -0400
Received: from [192.168.254.5] (unknown [50.34.202.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 3A59E13C2B1;
        Thu, 30 Jul 2020 15:57:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3A59E13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1596149820;
        bh=rxmG25WCH1LXBkXziQEUz98H6opV2riq2IlbU9ubUb4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kNPIEo1LhnkOoh+L4mdDRhAQ0gnRd9JdYB6DQMXtuYf2AvgrAaglxdXofnAp72eI0
         GrZDJjryUPxONkqGC40czReErDHdrBAMy2CosEeTQQpkTIqzFBZqC2L8oIPYJUbHnp
         2/BScWxNgBNNkb+u5f0T4yIYxZQexy7sMR+hpLvQ=
Subject: Re: Help getting aesni crypto patch upstream
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
References: <2a55b661-512b-9479-9fff-0f2e2a581765@candelatech.com>
 <CAMj1kXFwPPDfm1hvW+LgnfuPO-wfguTZ0NcLyeyesGeBcuDKGQ@mail.gmail.com>
 <04d8e7e3-700b-44b2-e8f2-5126abf21a62@candelatech.com>
 <CAMj1kXFK4xkieEpjW+ekYf9am6Ob15aGsnmWJMfn=LD_4oCuXg@mail.gmail.com>
 <9e6927a6-8f70-009a-ad76-4f11a396e43a@candelatech.com>
 <CAMj1kXEDBSfuTxi6CCPGdpdC6h+F18gutz3h2xJaGtdN8kS40Q@mail.gmail.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <d71f2800-baef-b97f-62cb-0fbe798c35ed@candelatech.com>
Date:   Thu, 30 Jul 2020 15:56:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXEDBSfuTxi6CCPGdpdC6h+F18gutz3h2xJaGtdN8kS40Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 7/29/20 1:06 PM, Ard Biesheuvel wrote:
> On Wed, 29 Jul 2020 at 22:29, Ben Greear <greearb@candelatech.com> wrote:
>>
>> On 7/29/20 12:09 PM, Ard Biesheuvel wrote:
>>> On Wed, 29 Jul 2020 at 15:27, Ben Greear <greearb@candelatech.com> wrote:
>>>>
>>>> On 7/28/20 11:06 PM, Ard Biesheuvel wrote:
>>>>> On Wed, 29 Jul 2020 at 01:03, Ben Greear <greearb@candelatech.com> wrote:
>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> As part of my wifi test tool, I need to do decrypt AES on the CPU, and the only way this
>>>>>> performs well is to use aesni.  I've been using a patch for years that does this, but
>>>>>> recently somewhere between 5.4 and 5.7, the API I've been using has been removed.
>>>>>>
>>>>>> Would anyone be interested in getting this support upstream?  I'd be happy to pay for
>>>>>> the effort.
>>>>>>
>>>>>> Here is the patch in question:
>>>>>>
>>>>>> https://github.com/greearb/linux-ct-5.7/blob/master/wip/0001-crypto-aesni-add-ccm-aes-algorithm-implementation.patch
>>>>>>
>>>>>> Please keep me in CC, I'm not subscribed to this list.
>>>>>>
>>>>>
>>>>> Hi Ben,
>>>>>
>>>>> Recently, the x86 FPU handling was improved to remove the overhead of
>>>>> preserving/restoring of the register state, so the issue that this
>>>>> patch fixes may no longer exist. Did you try?
>>>>>
>>>>> In any case, according to the commit log on that patch, the problem is
>>>>> in the MAC generation, so it might be better to add a cbcmac(aes)
>>>>> implementation only, and not duplicate all the CCM boilerplate.
>>>>>
>>>>
>>>> Hello,
>>>>
>>>> I don't know all of the details, and do not understand the crypto subsystem,
>>>> but I am pretty sure that I need at least some of this patch.
>>>>
>>>
>>> Whether this is true is what I am trying to get clarified.
>>>
>>> Your patch works around a performance bottleneck related to the use of
>>> AES-NI instructions in the kernel, which has been addressed recently.
>>> If the issue still exists, we can attempt to devise a fix for it,
>>> which may or may not be based on this patch.
>>
>> Ok, I can do the testing.  Do you expect 5.7-stable has all the needed
>> performance improvements?
>>
> 
> Yes.

It does not, as far as we can tell.

We did a download test on an apu2 (small embedded AMD CPU, but with
aesni support).  A WiFi station is in software-decrypt mode (ath10k-ct driver/firmware,
but ath9k would be valid to reproduce the issue as well.)

On our 5.4 kernel with the aesni patch applied, we get
about 220Mbps wpa2 download throughput.  With open, we get about 260Mbps
download throughput.

On 5.7, without any aesni patch, we see about 116Mbps download wpa2 throughput,
and about 265Mbps open download throughput.


perf-top on 5.4 during download test with our aesni patch looks like this:

    11.73%  libc-2.29.so   [.] __memset_sse2_unaligned_erms
      4.79%  [kernel]       [k] _aesni_enc1
      1.71%  [kernel]       [k] ___bpf_prog_run
      1.66%  [kernel]       [k] memcpy
      1.25%  [kernel]       [k] copy_user_generic_string
      1.18%  libjvm.so      [.] InstanceKlass::oop_follow_contents
      1.07%  [kernel]       [k] _aesni_enc4
      0.98%  [kernel]       [k] csum_partial_copy_generic
      0.96%  libjvm.so      [.] SpinPause
      0.84%  [kernel]       [k] get_data_to_compute
      0.81%  libjvm.so      [.] ParMarkBitMap::mark_obj
      0.64%  [kernel]       [k] udp_sendmsg
      0.62%  [kernel]       [k] __ip_append_data.isra.53
      0.58%  [kernel]       [k] ipt_do_table
      0.56%  [kernel]       [k] _aesni_inc
      0.56%  [kernel]       [k] fib_table_lookup
      0.55%  [kernel]       [k] __rcu_read_unlock
      0.52%  libc-2.29.so   [.] __GI___strcmp_ssse3
      0.50%  [kernel]       [k] igb_xmit_frame_ring


on 5.7, we see this:

    11.36%  libc-2.29.so   [.] __memset_sse2_unaligned_erms
      9.03%  [kernel]       [k] kernel_fpu_begin
      4.75%  libjvm.so      [.] SpinPause
      2.89%  [kernel]       [k] __crypto_xor
      2.35%  [kernel]       [k] _aesni_enc1
      1.94%  [kernel]       [k] copy_user_generic_string
      1.29%  [kernel]       [k] aesni_encrypt
      0.85%  [kernel]       [k] udp_sendmsg
      0.85%  [kernel]       [k] crypto_cipher_encrypt_one
      0.71%  [kernel]       [k] crypto_cbcmac_digest_update
      0.69%  [kernel]       [k] __ip_append_data.isra.53
      0.69%  [kernel]       [k] memcpy
      0.68%  [kernel]       [k] crypto_ctr_crypt
      0.61%  [kernel]       [k] irq_fpu_usable
      0.58%  [kernel]       [k] ipt_do_table
      0.55%  [kernel]       [k] __dev_queue_xmit
      0.54%  [kernel]       [k] crypto_inc
      0.49%  libc-2.29.so   [.] __GI___strcmp_ssse3
      0.45%  libjvm.so      [.] InstanceKlass::oop_follow_contents
      0.45%  [kernel]       [k] ip_route_output_key_hash_rcu



So, I think there is still some good improvement possible, likely with something like
the aesni patch I showed, but re-worked to function in 5.7+ kernels.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

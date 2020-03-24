Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68E691903E1
	for <lists+linux-crypto@lfdr.de>; Tue, 24 Mar 2020 04:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgCXDlw (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 23 Mar 2020 23:41:52 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59069 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbgCXDlw (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 23 Mar 2020 23:41:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48mcW21Lfbz9sRf;
        Tue, 24 Mar 2020 14:41:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1585021310;
        bh=H6/itYAfy5Zw7sfa+Et/FKqLqq3c0OxUkcczCOcjPnA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bvDvGTG9TWCECh4NbKeeMxa5EH2WXXULDFMRMCsRiuYoywkrzl8QqiNcXU9XSp16m
         wmivvqiCW4mbe7hBJWcghicI0Hy05EjK4RVlDGiQAxb+AyAG2/F6QCRVzaD2uczQME
         Fzbu9HAVqcHZmaZI+CMkQWZ3o7lHatvNTzSou7KekCCXcIW8gVOrJAucHfaSkBJLKU
         NlMp6OFh41C8F1+EBa78caGSKbIr04cGYAGGOsC4mnExzD3V6qC6NPnUPlsbQb3xCi
         WOpHmcWOgQg3O1cOePLSvBhEYLvtAvnnIF10sL357L5mEdwgPPJKhYux+G1tK736an
         64kxy8bunolbw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Daniel Axtens <dja@axtens.net>, Haren Myneni <haren@linux.ibm.com>,
        herbert@gondor.apana.org.au
Cc:     mikey@neuling.org, sukadev@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        npiggin@gmail.com
Subject: Re: [PATCH v4 3/9] powerpc/vas: Add VAS user space API
In-Reply-To: <875zevw61j.fsf@dja-thinkpad.axtens.net>
References: <1584934879.9256.15321.camel@hbabu-laptop> <1584936142.9256.15325.camel@hbabu-laptop> <878sjrwm72.fsf@dja-thinkpad.axtens.net> <878sjrclmz.fsf@mpe.ellerman.id.au> <875zevw61j.fsf@dja-thinkpad.axtens.net>
Date:   Tue, 24 Mar 2020 14:41:55 +1100
Message-ID: <87zhc6xvuk.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Daniel Axtens <dja@axtens.net> writes:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>> Daniel Axtens <dja@axtens.net> writes:
>>> Haren Myneni <haren@linux.ibm.com> writes:
>>>> diff --git a/arch/powerpc/platforms/powernv/vas-api.c b/arch/powerpc/platforms/powernv/vas-api.c
>>>> new file mode 100644
>>>> index 0000000..7d049af
>>>> --- /dev/null
>>>> +++ b/arch/powerpc/platforms/powernv/vas-api.c
>>>> @@ -0,0 +1,257 @@
>> ...
>>>> +
>>>> +static int coproc_mmap(struct file *fp, struct vm_area_struct *vma)
>>>> +{
>>>> +	struct vas_window *txwin = fp->private_data;
>>>> +	unsigned long pfn;
>>>> +	u64 paste_addr;
>>>> +	pgprot_t prot;
>>>> +	int rc;
>>>> +
>>>> +	if ((vma->vm_end - vma->vm_start) > PAGE_SIZE) {
>>>
>>> I think you said this should be 4096 rather than 64k, regardless of what
>>> PAGE_SIZE you are compiled with?
>>
>> You can't mmap less than a page, a page is PAGE_SIZE bytes.
>>
>> So if that checked for 4K explicitly it would prevent mmap on 64K
>> kernels always, which seems like not what you want?
>
> Ah. My bad. Carry on then :)

Well you were just quoting something from Haren, so I think it's over to
him.

cheers

Return-Path: <linux-crypto+bounces-4121-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4558C2867
	for <lists+linux-crypto@lfdr.de>; Fri, 10 May 2024 18:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2A6CB23EB6
	for <lists+linux-crypto@lfdr.de>; Fri, 10 May 2024 16:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C51171E7C;
	Fri, 10 May 2024 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGZPAbFB"
X-Original-To: linux-crypto@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82655F4EB
	for <linux-crypto@vger.kernel.org>; Fri, 10 May 2024 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715356922; cv=none; b=AJxlPFp3hhiIltgKIRZ0RGwG2GbbPD0dVC9nsB0LPeJ4y1RV48+087u6EtIXftzaRrA+9xZlhY9kjvkOyzml2w2/d8q/ldqcDXh5U5z3B2cc1ffhgUwOjeGyFSEFmngszlGRIrg3L7nuc59v5vKrgXvkC88iA7/AI3C4NBWY0nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715356922; c=relaxed/simple;
	bh=mC96V8Ws5NnOmU4XRx5IIQZgPfMRXWTrxQfOExY61pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFiO4nJQsbYbD+H7uGmSvpNydY6WRs2nUMajj+9w0Y0R9czoOj/LsZaBsfWHZ6jCfUYwXHjhhMawnOANvsG6YlpKxF6JcFmD8/y/6zfr8ItSE9b8De2hnQVNWGLjAonhpBgteaDGUtZrvlbDAtvJbMJZVd8jYyx5DShjhtSoUfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MGZPAbFB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715356919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XEweVzuXk9Nl8kIRn1D6Og8vyZm+06CghOgjLCvkUZ4=;
	b=MGZPAbFB8uFdq48qdO2FHPSu3vuuDpvZwDJ7ljt1844zngDjysJMigHzB5N6Bykib3rCvm
	ymYyTmWk6CHTkXrZjXOyHCTnP/EUyHKTCGqpkC7oFascaMsFVU4ccyDg2J1B633dOslRl9
	800chA82hVEK/v2BJnh9PaME+OA7pdk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-G2uyjg7sPcmv3doCZ1h4MQ-1; Fri, 10 May 2024 12:01:58 -0400
X-MC-Unique: G2uyjg7sPcmv3doCZ1h4MQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5733eed0c19so864159a12.2
        for <linux-crypto@vger.kernel.org>; Fri, 10 May 2024 09:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715356917; x=1715961717;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XEweVzuXk9Nl8kIRn1D6Og8vyZm+06CghOgjLCvkUZ4=;
        b=EW0Jz9Es4P+Ht3f0YhnnzfzA2AUlQrZyTLu0CwzbiOOP7UgXzEcOF7Krf9ghjYQvF7
         YIRzksMK8DQbFpbppR/abp5it8COr8D4CdiLVgYdUe/VusgmipcplXKSSZpjUE0aRANW
         XKHGat0XnytFKxTa5tqJGId7JpZ47qFiZujUzxIimbCNSKW1D7sVnsJCJuuQ+y4eOJOG
         QtlcqkJqadp8lQIZwbgh8E5616+V6Hbx4OOTdCLB++zs8BNCugAEGhd77i2UObtQvCj7
         Zf/9YJhNfZj1yNGse7SUHptepCpOs+qhRS5Gwesc+96a9pjgBi0wh5oxeHtiq+5Az1KP
         hdRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9gtRyjCsw0HWJOijo8DRuJf5GH+TljjPZtzjPAP5JExdETKZXctzorR6qmf8hhRkrRE2paOIKdemBZumoctPwQ3l2lKsHp+wC4zG7
X-Gm-Message-State: AOJu0Yx4T05DBj8BVuDHIPYUHl7yN4FKTVfsCNQX/piQSEwttfNdd1NH
	8V2wpBRc9JdkCKxJgOYjo1VwIK1HMM20uDsgDsLmwGDJf/y/tH6fmiIgGk7OdvBRdC51sVa8x34
	IyC3q/xRcZuQNmDzxr5g4a8g4Z8do0iBwf+dnmHAl1yS0bKbuRD8SxDAcRz5fbw==
X-Received: by 2002:a50:ab59:0:b0:56e:238e:372c with SMTP id 4fb4d7f45d1cf-5734d67ab0fmr2148517a12.26.1715356917188;
        Fri, 10 May 2024 09:01:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwDW7Zdiqefqy6/qqc/upaOXcCLAV24nf7L7k4NUD7zh+JFcxK63AO5jZdtXNTpm0lbHaQmg==
X-Received: by 2002:a50:ab59:0:b0:56e:238e:372c with SMTP id 4fb4d7f45d1cf-5734d67ab0fmr2148461a12.26.1715356916665;
        Fri, 10 May 2024 09:01:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.155.52])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5733bebb6casm1934867a12.29.2024.05.10.09.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 09:01:55 -0700 (PDT)
Message-ID: <566b57c0-27cd-4591-bded-9a397a1d44d5@redhat.com>
Date: Fri, 10 May 2024 18:01:52 +0200
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 22/23] KVM: SEV: Fix return code interpretation for
 RMP nested page faults
To: Sean Christopherson <seanjc@google.com>,
 Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-mm@kvack.org,
 linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, mingo@redhat.com, jroedel@suse.de,
 thomas.lendacky@amd.com, hpa@zytor.com, ardb@kernel.org,
 vkuznets@redhat.com, jmattson@google.com, luto@kernel.org,
 dave.hansen@linux.intel.com, slp@redhat.com, pgonda@google.com,
 peterz@infradead.org, srinivas.pandruvada@linux.intel.com,
 rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de,
 vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com,
 tony.luck@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 alpergun@google.com, jarkko@kernel.org, ashish.kalra@amd.com,
 nikunj.dadhania@amd.com, pankaj.gupta@amd.com, liam.merwick@oracle.com,
 papaluri@amd.com
References: <20240501085210.2213060-1-michael.roth@amd.com>
 <20240510015822.503071-1-michael.roth@amd.com>
 <20240510015822.503071-2-michael.roth@amd.com> <Zj4oFffc7OQivyV-@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Zj4oFffc7OQivyV-@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/10/24 15:58, Sean Christopherson wrote:
> On Thu, May 09, 2024, Michael Roth wrote:
>> The intended logic when handling #NPFs with the RMP bit set (31) is to
>> first check to see if the #NPF requires a shared<->private transition
>> and, if so, to go ahead and let the corresponding KVM_EXIT_MEMORY_FAULT
>> get forwarded on to userspace before proceeding with any handling of
>> other potential RMP fault conditions like needing to PSMASH the RMP
>> entry/etc (which will be done later if the guest still re-faults after
>> the KVM_EXIT_MEMORY_FAULT is processed by userspace).
>>
>> The determination of whether any userspace handling of
>> KVM_EXIT_MEMORY_FAULT is needed is done by interpreting the return code
>> of kvm_mmu_page_fault(). However, the current code misinterprets the
>> return code, expecting 0 to indicate a userspace exit rather than less
>> than 0 (-EFAULT). This leads to the following unexpected behavior:
>>
>>    - for KVM_EXIT_MEMORY_FAULTs resulting for implicit shared->private
>>      conversions, warnings get printed from sev_handle_rmp_fault()
>>      because it does not expect to be called for GPAs where
>>      KVM_MEMORY_ATTRIBUTE_PRIVATE is not set. Standard linux guests don't
>>      generally do this, but it is allowed and should be handled
>>      similarly to private->shared conversions rather than triggering any
>>      sort of warnings
>>
>>    - if gmem support for 2MB folios is enabled (via currently out-of-tree
>>      code), implicit shared<->private conversions will always result in
>>      a PSMASH being attempted, even if it's not actually needed to
>>      resolve the RMP fault. This doesn't cause any harm, but results in a
>>      needless PSMASH and zapping of the sPTE
>>
>> Resolve these issues by calling sev_handle_rmp_fault() only when
>> kvm_mmu_page_fault()'s return code is greater than or equal to 0,
>> indicating a KVM_MEMORY_EXIT_FAULT/-EFAULT isn't needed. While here,
>> simplify the code slightly and fix up the associated comments for better
>> clarity.
>>
>> Fixes: ccc9d836c5c3 ("KVM: SEV: Add support to handle RMP nested page faults")
>>
>> Signed-off-by: Michael Roth <michael.roth@amd.com>
>> ---
>>   arch/x86/kvm/svm/svm.c | 10 ++++------
>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index 426ad49325d7..9431ce74c7d4 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -2070,14 +2070,12 @@ static int npf_interception(struct kvm_vcpu *vcpu)
>>   				svm->vmcb->control.insn_len);
>>   
>>   	/*
>> -	 * rc == 0 indicates a userspace exit is needed to handle page
>> -	 * transitions, so do that first before updating the RMP table.
>> +	 * rc < 0 indicates a userspace exit may be needed to handle page
>> +	 * attribute updates, so deal with that first before handling other
>> +	 * potential RMP fault conditions.
>>   	 */
>> -	if (error_code & PFERR_GUEST_RMP_MASK) {
>> -		if (rc == 0)
>> -			return rc;
>> +	if (rc >= 0 && error_code & PFERR_GUEST_RMP_MASK)
> 
> This isn't correct either.  A return of '0' also indiciates "exit to userspace",
> it just doesn't happen with SNP because '0' is returned only when KVM attempts
> emulation, and that too gets short-circuited by svm_check_emulate_instruction().
> 
> And I would honestly drop the comment, KVM's less-than-pleasant 1/0/-errno return
> values overload is ubiquitous enough that it should be relatively self-explanatory.
> 
> Or if you prefer to keep a comment, drop the part that specifically calls out
> attributes updates, because that incorrectly implies that's the _only_ reason
> why KVM checks the return.  But my vote is to drop the comment, because it
> essentially becomes "don't proceed to step 2 if step 1 failed", which kind of
> makes the reader go "well, yeah".

So IIUC you're suggesting

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 426ad49325d7..c39eaeb21981 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2068,16 +2068,11 @@ static int npf_interception(struct kvm_vcpu *vcpu)
  				static_cpu_has(X86_FEATURE_DECODEASSISTS) ?
  				svm->vmcb->control.insn_bytes : NULL,
  				svm->vmcb->control.insn_len);
+	if (rc <= 0)
+		return rc;
  
-	/*
-	 * rc == 0 indicates a userspace exit is needed to handle page
-	 * transitions, so do that first before updating the RMP table.
-	 */
-	if (error_code & PFERR_GUEST_RMP_MASK) {
-		if (rc == 0)
-			return rc;
+	if (error_code & PFERR_GUEST_RMP_MASK)
  		sev_handle_rmp_fault(vcpu, fault_address, error_code);
-	}
  
  	return rc;
  }

?

So, we're... a bit tight for 6.10 to include SNP and that is an
understatement.  My plan is to merge it for 6.11, but do so
immediately after the merge window ends.  In other words, it
is a delay in terms of release but not in terms of time.  I
don't want QEMU and kvm-unit-tests work to be delayed any
further, in particular.

Once we sort out the loose ends of patches 21-23, you could send
it as a pull request.

Paolo



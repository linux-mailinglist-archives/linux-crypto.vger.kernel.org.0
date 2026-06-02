Return-Path: <linux-crypto+bounces-24836-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zgAQC9olH2qMiAAAu9opvQ
	(envelope-from <linux-crypto+bounces-24836-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 02 Jun 2026 20:50:02 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 903D7631344
	for <lists+linux-crypto@lfdr.de>; Tue, 02 Jun 2026 20:50:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=TbiXWH97;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24836-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24836-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 892F4308846B
	for <lists+linux-crypto@lfdr.de>; Tue,  2 Jun 2026 18:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281DE3998A6;
	Tue,  2 Jun 2026 18:45:05 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770513909A4
	for <linux-crypto@vger.kernel.org>; Tue,  2 Jun 2026 18:45:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425904; cv=none; b=mNcGrWk9qPEvUAgwmn3Rf9pGS6prL1kd3wQbEye1Gp5UJk8TUOUsuiQ9sKCdL+TJSdSjrWw/e+e+Fz5oEp6U7bq4xL+QLAPrBWgAFdpY0TB6AANWmKUDsyr5w+GIoRta6r3qFvQoexVxslk8jOO+zGoZO1GG9Aj1zXCbUYvpEBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425904; c=relaxed/simple;
	bh=mII4M3T9V53JqO8KFebIJB5RYzAb69uiYF7BjywVILA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgqnhuZaj1THmHw5M2jGGjVI5ZchHwguZR5/yOgr6wWzWCgpvDYAI+NX2WZW92Q7u2ki9nGQsVleaXVMdoKyfYunPwH/R3JhJRH1y+4btJKZqXWGGv0+KGWF2xjya+kT9yIkjFXeYBtxoOJTOb9SaNyCpPd8hqJ457qEYaIbv6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TbiXWH97; arc=none smtp.client-ip=95.215.58.180
Message-ID: <2fb74fd3-c67c-4311-a850-16dbf0da39e9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780425891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/KjihzjRvX97rw+gmB11nyILK6Vj1Lk2bHpGiUdh8Qs=;
	b=TbiXWH97plXQYDb4V0rQM7USSlkYQdyywRkC0e+ZEeB0v11cxNMVgZtUQy7OVWaP3yApIf
	N3Y6RE8CZltBN3huHU/uvfoWYxw06QQ4OtdB+GERjZzR66MS8C9XYLDhe9y8FJ3SXB1OFv
	it5GQXUuEpgcW3dn3VfLAgCihO1xWCc=
Date: Tue, 2 Jun 2026 11:44:42 -0700
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/4] KVM: SEV: Do not allow intra-host
 migration/mirroring of SNP VMs
To: Tom Lendacky <thomas.lendacky@amd.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Gonda <pgonda@google.com>,
 Brijesh Singh <brijesh.singh@amd.com>, Youngjae Lee <youngjaelee@meta.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>,
 John Allen <john.allen@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: clm@meta.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, stable@vger.kernel.org,
 Atish Patra <atishp@meta.com>, Sashiko <sashiko-bot@kernel.org>
References: <20260601-sev_snp_fixes-v2-0-611891b28a86@meta.com>
 <20260601-sev_snp_fixes-v2-1-611891b28a86@meta.com>
 <ec31f685-e766-42e0-8239-eb6202cabdde@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <ec31f685-e766-42e0-8239-eb6202cabdde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24836-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[atish.patra@linux.dev,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:thomas.lendacky@amd.com,m:seanjc@google.com,m:pbonzini@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:pgonda@google.com,m:brijesh.singh@amd.com,m:youngjaelee@meta.com,m:ashish.kalra@amd.com,m:michael.roth@amd.com,m:john.allen@amd.com,m:herbert@gondor.apana.org.au,m:clm@meta.com,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:stable@vger.kernel.org,m:atishp@meta.com,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atish.patra@linux.dev,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 903D7631344


On 6/2/26 7:38 AM, Tom Lendacky wrote:
> On 6/1/26 18:04, Atish Patra wrote:
>> From: Atish Patra <atishp@meta.com>
>>
>> The intra-host migration/mirroring feature is not fully implemented for
>> SEV-SNP VMs. The proper migration requires additional SNP-specific
>> state such as guest_req_mutex, guest_req_buf, and guest_resp_buf to be
>> transferred or initialized on the destination.
>>
>> The SNP VM mirroring requires vmsa features to be copied as well otherwise
>> ASID would be bound to SNP range while VM is detected as a SEV VM.
>>
>> Reject SNP source VMs in migration/mirroring until proper SNP state
>> transfer is implemented.
>>
>> Fixes: 0b020f5af092 ("KVM: SEV: Add support for SEV-ES intra host migration")
> Probably not the correct Fixes: tag. It should the tag that first
> introduces SNP hypervisor support.

Ahh yes. Fixed.

> And adding a comment above the if statements that indicate additional
> support is required for SNP, so don't allow it for now, would be nice.
Added.
> Otherwise, for the actual code...
>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
>
>> Reported-by: Chris Mason <clm@meta.com>
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Assisted-by: Claude:claude-opus-4-6
>> Signed-off-by: Atish Patra <atishp@meta.com>
>> ---
>>   arch/x86/kvm/svm/sev.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index c2126b3c3072..e6ad6af128c9 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
>> @@ -2142,7 +2142,8 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
>>   		return ret;
>>   
>>   	if (kvm->arch.vm_type != source_kvm->arch.vm_type ||
>> -	    sev_guest(kvm) || !sev_guest(source_kvm)) {
>> +	    sev_guest(kvm) || !sev_guest(source_kvm) ||
>> +	    sev_snp_guest(source_kvm)) {
>>   		ret = -EINVAL;
>>   		goto out_unlock;
>>   	}
>> @@ -2865,6 +2866,7 @@ int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
>>   	 * created after SEV/SEV-ES initialization, e.g. to init intercepts.
>>   	 */
>>   	if (sev_guest(kvm) || !sev_guest(source_kvm) ||
>> +	    sev_snp_guest(source_kvm) ||
>>   	    is_mirroring_enc_context(source_kvm) || kvm->created_vcpus) {
>>   		ret = -EINVAL;
>>   		goto e_unlock;
>>


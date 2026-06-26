Return-Path: <linux-crypto+bounces-25423-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2XgBGQ1APmp0CAkAu9opvQ
	(envelope-from <linux-crypto+bounces-25423-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 11:02:05 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF34C6CB89C
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 11:02:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25423-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25423-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D288F300AD99
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 09:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5613E8660;
	Fri, 26 Jun 2026 09:01:55 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4273E866C;
	Fri, 26 Jun 2026 09:01:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782464514; cv=none; b=A/yJV0o+0aYSuDiF+YUyqtH6I+b8yfGZCPtcLaADgxK6/NWru44EPebsGJA9SB7oX3Y+PyCg2hGWtTBg8EBBENPz1Ae3zvlcB37wvDfw2vbkXjI32R8u3SfmvWp4lh+wqDFhDG+OqC6j7qLYCpxgGznXinRDKLdv5Wn7osmoE0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782464514; c=relaxed/simple;
	bh=sEWrR8kYZ2BiJFak+x25+Vh8Z+DSlNqSjgiodK9Lmmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dVkZYCnC7UVMJRzKpxfm1HtPfemBqrGIjoEgLadoUP5iPZ2JqiUuGJG5HXY3wm5Mj7tMXDXyxosKCNdyu6i2x/t62KXRHj2hFYSOim83ZaGPujW2puEayW1LqSFk5N65q0rMXM2+endOjJlSgYEjWd6r4h2BkV7+Gha+mQRk1iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cambridgegreys.com; spf=pass smtp.mailfrom=cambridgegreys.com; arc=none smtp.client-ip=217.160.28.25
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1wd1ot-001u1R-T0; Fri, 26 Jun 2026 08:21:51 +0000
Received: from [192.168.21.56]
	by jain.kot-begemot.co.uk with esmtp (Exim 4.98.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1wd1kq-0000000BoSt-0qIQ;
	Fri, 26 Jun 2026 09:21:50 +0100
Message-ID: <6a20b442-b97f-4cae-9168-30201d5ef82c@cambridgegreys.com>
Date: Fri, 26 Jun 2026 09:21:49 +0100
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] um: Check for missing AVX and AVX-512 xstate bits
To: David Laight <david.laight.linux@gmail.com>,
 Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, linux-um@lists.infradead.org, linux-raid@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>
References: <20260626043731.319287-1-ebiggers@kernel.org>
 <20260626043731.319287-3-ebiggers@kernel.org>
 <20260626084113.42eae31c@pumpkin>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20260626084113.42eae31c@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25423-lists,linux-crypto=lfdr.de];
	DMARC_NA(0.00)[cambridgegreys.com];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:ebiggers@kernel.org,m:x86@kernel.org,m:linux-um@lists.infradead.org,m:linux-raid@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hch@lst.de,m:akpm@linux-foundation.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[anton.ivanov@cambridgegreys.com,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anton.ivanov@cambridgegreys.com,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF34C6CB89C



On 26/06/2026 08:41, David Laight wrote:
> On Thu, 25 Jun 2026 21:37:25 -0700
> Eric Biggers <ebiggers@kernel.org> wrote:
> 
>> If the CPU declares AVX or AVX-512 support, verify that all the
>> corresponding xstate bits are also set.  If any are missing, warn and
>> don't set the corresponding X86_FEATURE_* flags.
>>
>> This eliminates the perceived need for UML-supporting AVX and AVX-512
>> optimized code in the kernel (that is, lib/raid/ currently) to start
>> checking the xstate bits in addition to X86_FEATURE_AVX*.
>>
> ...
>>   static void __init parse_host_cpu_flags(char *line)
>>   {
>> +	u64 xcr0 = read_xcr0();
>>   	int i;
>> +
>>   	for (i = 0; i < 32*NCAPINTS; i++) {
>>   		if ((x86_cap_flags[i] != NULL) && strstr(line, x86_cap_flags[i]))
> 
> 'line' comes from /proc/cpuinfo
> Surely something would be terribly wrong if that included something the kernel
> had disabled (or didn't support).
> 
> 	David
> 
> 
>> -			set_cpu_cap(&boot_cpu_data, i);
>> +			validate_and_set_cpu_cap(i, xcr0);
>>   	}
>>   }
>>   
>>   static void __init parse_cache_line(char *line)
>>   {
> 
> 
> 
 >
Lots of other stuff will go wrong before that. Glibc, things compiled with LLVM, python, perl, etc.

Half of the userland will go belly up, because AVX is used in string operations and hashing if it is available.

UML is just another userland application from this perspective, so there is no reason for it to behave any different from the rest of the userland.
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661




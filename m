Return-Path: <linux-crypto+bounces-25440-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h70ME5oqP2qCPgkAu9opvQ
	(envelope-from <linux-crypto+bounces-25440-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 27 Jun 2026 03:42:50 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAE36D0B9E
	for <lists+linux-crypto@lfdr.de>; Sat, 27 Jun 2026 03:42:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=zytor.com header.s=2026052701 header.b=ieVY684F;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25440-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25440-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=zytor.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 50DBD3010C89
	for <lists+linux-crypto@lfdr.de>; Sat, 27 Jun 2026 01:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789232472AF;
	Sat, 27 Jun 2026 01:42:39 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A001862;
	Sat, 27 Jun 2026 01:42:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782524559; cv=none; b=MgZQoxrhdXS7a6EHjCiRCAfW81V8kj3XiDhd98zOyI725U6Ha5n7TiI2zLZZpIK5vl7mogeFqX4JXlf1CgvaeqtZh7wSwdUCn1Kh29fjiUtYjRkLHltO4MHyULIEuh0d/LEWUX4fyaESqMMNykcMbZt/icO4u5DtGGrrdYXvaBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782524559; c=relaxed/simple;
	bh=jC1FioIpIuBtK6CQyzkvitIy/jJmxmVOYdOtUFK0xSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXsfUwLl5UlBTJYRA4MHxOpmtLwgUUnfiN0fhRYYMO4B7R/X+4GJjpHcPabqU6u9pfX/Q4JOBFwTpW5RhZs1/jhA0skE2uEPK0p95tSIshw7cL1Cm+eLMUsq8ZZXrKVyDBsXXQtfvnWnuvRErHBEkJiZ8giYzHXzHHDIAD8sEVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ieVY684F; arc=none smtp.client-ip=198.137.202.136
Received: from [IPV6:2601:646:8081:7da1:dcd4:e1f8:5d79:bdb4] ([IPv6:2601:646:8081:7da1:dcd4:e1f8:5d79:bdb4])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 65R1EHQ12354017
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 26 Jun 2026 18:14:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 65R1EHQ12354017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026052701; t=1782522861;
	bh=a3misQc9HlKUNeYqqO4Fnmvv4Fv9RkyhsTgdLQ0BWz0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ieVY684FxDj35+1OdJbAri1pdBhTN2gqeIU7j2Y370sBUQ30QPhmIZvW75cKJPbdR
	 IMWIkamCPLrfWfNgBKcB3PhaMkYzKHTrmnUKLa1e+ZLSJhv19+SOXDBLXcwGBwQUQm
	 r/XHx5z9usnk9iv+AszJJxJtR+3sMk9VLHHsh52YfG3DsQ64mFPl5qVJWfAy/D+2Rh
	 S+WMDllsVtD5pOEp++Uf505LlYCJ5QwZinre3Oi8+jbt4xxPtHa6lglEWhLpIlBWBv
	 8Y8Cvo1WqplQrMHkk6CviVuUOV0LSl6zFgnbsOyQby5POoRmSu/3wfwF+nNtjeJn02
	 kxE798jNrTxdQ==
Message-ID: <33ef4e7b-3139-4cb8-9545-6d445bf6e5f1@zytor.com>
Date: Fri, 26 Jun 2026 18:14:11 -0700
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/18] raid6: warn when using less than four devices
To: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Song Liu <song@kernel.org>,
        Yu Kuai <yukuai@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com>,
        Li Nan <linan122@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-raid@vger.kernel.org
References: <20260518051804.462141-1-hch@lst.de>
 <20260518051804.462141-9-hch@lst.de>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260518051804.462141-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026052701];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25440-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:akpm@linux-foundation.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:ardb@kernel.org,m:chenhuacai@kernel.org,m:kernel@xen0n.name,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:herbert@gondor.apana.org.au,m:dan.j.williams@intel.com,m:clm@fb.com,m:dsterba@suse.com,m:arnd@arndb.de,m:song@kernel.org,m:yukuai@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com,m:linan122@huawei.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:loongarch@lists.linux.dev,m:linuxppc-dev@lists.ozlabs.org,m:linux-riscv@lists.infradead.org,m:linux-s390@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-btrfs@vger.k
 ernel.org,m:linux-arch@vger.kernel.org,m:linux-raid@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hpa@zytor.com,linux-crypto@vger.kernel.org];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,redhat.com,alien8.de,linux.intel.com,gondor.apana.org.au,intel.com,fb.com,suse.com,arndb.de,alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com,huawei.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[43];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[zytor.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,zytor.com:dkim,zytor.com:mid,zytor.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CAE36D0B9E

On 2026-05-17 22:17, Christoph Hellwig wrote:
> Quoting H. Peter Anvin who came up with the RAID6 P/Q algorithm, and
> who wrote the initial implementation, then still part of the md driver:
> 
>   The RAID-6 code has *never* supported only 3 units, and if it ever
>   worked for *any* of the implementations it was purely by accident.
>   Speaking as the original author I should know; this was deliberate as
>   in some cases the degenerate case (3) would have required extra trays

Stupid autocorrect. That was of course supposed to be "tests" (as in extra
code paths) not "trays" :)

>   in the code to no user benefit.
> 
> While md never allowed less than 4 devices, btrfs does.  This new
> warning will trigger for such file systems, but given how it already
> causes havoc that is a good thing.  If btrfs wants to fix third, it
> should switch to transparently use three-way mirroring underneath,
> which will work as P and Q are copies of the single data device by
> the definition of the Linux RAID 6 P/Q algorithm.

For what it's worth, this is also true in the degenerate two-drive RAID-4|5
case (D = P).

	-hpa



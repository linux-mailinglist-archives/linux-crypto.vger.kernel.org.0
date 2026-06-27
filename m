Return-Path: <linux-crypto+bounces-25439-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Bz4HGkkpP2osPgkAu9opvQ
	(envelope-from <linux-crypto+bounces-25439-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 27 Jun 2026 03:37:13 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BED3A6D0B5A
	for <lists+linux-crypto@lfdr.de>; Sat, 27 Jun 2026 03:37:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=zytor.com header.s=2026052701 header.b=qMyBFc1g;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25439-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25439-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=zytor.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F226303D2E7
	for <lists+linux-crypto@lfdr.de>; Sat, 27 Jun 2026 01:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2198F233D9E;
	Sat, 27 Jun 2026 01:36:58 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C57146D5A;
	Sat, 27 Jun 2026 01:36:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782524217; cv=none; b=GG3z24Y8jgsaEmL9lYxfbBnRYAZD4n4SQRWf8IYId9y5KnjeR7XAwCxAugYOix5PKG7+2kD7fK2emsExyso5+NN8DNDEKnUURHaOtezhINYZSpFWf1sB+eZCBmIov3A9VzpO/Zx5mu6T4M+A2U2BKrl+1U2i/6PHFTXG9YN0Qgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782524217; c=relaxed/simple;
	bh=vlFmuIXNikKGJcM/rV+RwQGeISv45Ze+30sLXQvpSug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=szZyCKuy/+bRIchGnwD3bXDx7kkZ4Y4QSSXOTc2F+K7GA7xscXv0EVxgIMIh1APr7aBDTmwpzRlAETlSak9PqVgwXLzV9UNJfNB4l10yBKHCC6POVMGoCqj6ime4K2WtlAZrIsHj4E3i9yBShpAEI5DJOoB+1C+JUoUzqZ3k1w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=qMyBFc1g; arc=none smtp.client-ip=198.137.202.136
Received: from [IPV6:2601:646:8081:7da1:dcd4:e1f8:5d79:bdb4] ([IPv6:2601:646:8081:7da1:dcd4:e1f8:5d79:bdb4])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 65R0qN0N2285168
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 26 Jun 2026 17:52:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 65R0qN0N2285168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026052701; t=1782521550;
	bh=CoKSivJMaQDV2sSkRTRw7olGkcZfQ72Xwmih/Aa0td0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qMyBFc1gnGXRksBwsJ1/rUznZgiE7lPuLPv/lWpmOM+5Q3Fqu1GkBtPV/i01hTsmm
	 FyrrwODPBIMXlAoyCpEVfCiClmUhwPWsNagz78j3LDMf+Ut0XXJAAidVe9l1aTOAut
	 7WQuEQASgzET2NWeiLHKYC5brvZfsPACaGhvlYNW5X1iG8c+02aTJiS4yaJSFbtRty
	 RzVpKhz70FSqCBKm8TK2gLW8sDPukFdgs1lqJ60AGqtpglwDIA/PnerR6f0L+dvu0f
	 tzL0aZnBm0Ed9q+Fj1E4zhVGr5LPAVMhZk4GFV4YP0Rst/9nwzTfe9CuWNPpW58FjU
	 Q8Foj51/YA5sw==
Message-ID: <7d8efc7c-65e3-49f8-9381-910de7affef2@zytor.com>
Date: Fri, 26 Jun 2026 17:52:18 -0700
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cleanup the RAID6 P/Q library v3
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
 <20260518141205.c100f76eec5f58e78bbbf7af@linux-foundation.org>
 <20260519082432.GA14956@lst.de>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260519082432.GA14956@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026052701];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25439-lists,linux-crypto=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BED3A6D0B5A

On 2026-05-19 01:24, Christoph Hellwig wrote:
> 
> raid6: rework registration of optimized algorithms
> 
>  - avx2 instead of avx512 is probably the right thing for no
>    benchmarking, but if it was intentional (it wasn't), that should
>    be document.  So I'll just switch back to the previous version to
>    keep the state of the art

It is unlikely to be the right thing *going forward*, though.

The very unfortunate performance inversion is likely model-specific. It is one
of those things where you largely would have to have a list of quirks :(

	-hpa



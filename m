Return-Path: <linux-crypto+bounces-25486-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8xwMI+JvQmqw7AkAu9opvQ
	(envelope-from <linux-crypto+bounces-25486-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 29 Jun 2026 15:15:14 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1414D6DAED9
	for <lists+linux-crypto@lfdr.de>; Mon, 29 Jun 2026 15:15:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=zytor.com header.s=2026062701 header.b=ItDa3yOy;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25486-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25486-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=zytor.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9955030A889A
	for <lists+linux-crypto@lfdr.de>; Mon, 29 Jun 2026 12:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AC1402451;
	Mon, 29 Jun 2026 12:47:38 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B5140149E;
	Mon, 29 Jun 2026 12:47:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782737257; cv=none; b=p/5238a4eh4VbKGdcmV5xCK6u4pMsP4cJ9/kcm3NUxkoTBOQISJ94YWxiv+/cFRe5mhaFW89dywTifQ6ezuEiG4lsCumy9Ucy5NjxxwnqaJGtFep8+f/O3H8nfdUKC1ILzcq92U0vr8sZYJG+AV9IKafpQF5dAkPB4xjmlfLuZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782737257; c=relaxed/simple;
	bh=z/WphS08I3Q3YI1k39FHOZlyjeIMdtgSIvsLXR1+OYs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=BHyeU7BlOJ+U4mjacCa7QcYdXGSNKBKeitBlhU/iBEowdXMiCBzQDDx9lGd5Oi4nLo6h2Lgp4fnUCVudiE5tblMyilfogK5jNh2iE+86q6cxcXnrDJJRlQfK4V+vjtssV/Kp1s1bug5iGInXhzpy1X+389p2cMc7KZvx3wrkgiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ItDa3yOy; arc=none smtp.client-ip=198.137.202.136
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 65TCYlVH219229
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 29 Jun 2026 05:34:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 65TCYlVH219229
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026062701; t=1782736492;
	bh=F5eNBCeca9FFTuFbHhVBFOemJYWYzDmHgzejZkXlIwM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ItDa3yOyOnzgUJtBSZCdhS4zlYRD1XzlbHnWBCrsgDuyOKDQnLXWfugxh1RYrcnHj
	 Wo6d2ASe4aa2kENlvakDGwv3s+KtWwghI1YzuSK4mfraTOB1p7+BurPnKzbMpbQKQL
	 FArnwwcKd8vhlMO88QNlKM8z1OAEuHhiE7bWCyq/7xJ09JZm9//17j5avtQhx3ZQCW
	 62VMIArJVSZ3KSFw9+v6qyIZPgiOE1KxeelvfNkr5eljLOhZuntNE2qq7OnkyMcON6
	 lCC018LGMBA4PoGUZ03daik0PWEEF4Ej3Y7mFmcxCoVSXT9w4uUsvXWEvA5Jy73wT+
	 n9LoSC8sobApw==
Date: Mon, 29 Jun 2026 05:34:41 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Christoph Hellwig <hch@lst.de>
CC: Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
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
Subject: Re: cleanup the RAID6 P/Q library v3
User-Agent: K-9 Mail for Android
In-Reply-To: <20260629122152.GA21344@lst.de>
References: <20260518051804.462141-1-hch@lst.de> <20260518141205.c100f76eec5f58e78bbbf7af@linux-foundation.org> <20260519082432.GA14956@lst.de> <7d8efc7c-65e3-49f8-9381-910de7affef2@zytor.com> <20260629122152.GA21344@lst.de>
Message-ID: <8684FEC2-AD56-4BDA-874F-1D3D7170F880@zytor.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026062701];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25486-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:akpm@linux-foundation.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:ardb@kernel.org,m:chenhuacai@kernel.org,m:kernel@xen0n.name,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:herbert@gondor.apana.org.au,m:dan.j.williams@intel.com,m:clm@fb.com,m:dsterba@suse.com,m:arnd@arndb.de,m:song@kernel.org,m:yukuai@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com,m:linan122@huawei.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:loongarch@lists.linux.dev,m:linuxppc-dev@lists.ozlabs.org,m:linux-riscv@lists.infradead.org,m:linux-s390@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-btrfs@vger.k
 ernel.org,m:linux-arch@vger.kernel.org,m:linux-raid@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hpa@zytor.com,linux-crypto@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,arm.com,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,redhat.com,alien8.de,linux.intel.com,gondor.apana.org.au,intel.com,fb.com,suse.com,arndb.de,alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com,huawei.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,zytor.com:dkim,zytor.com:mid,zytor.com:from_mime,lst.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1414D6DAED9

On June 29, 2026 5:21:52 AM PDT, Christoph Hellwig <hch@lst=2Ede> wrote:
>On Fri, Jun 26, 2026 at 05:52:18PM -0700, H=2E Peter Anvin wrote:
>> On 2026-05-19 01:24, Christoph Hellwig wrote:
>> >=20
>> > raid6: rework registration of optimized algorithms
>> >=20
>> >  - avx2 instead of avx512 is probably the right thing for no
>> >    benchmarking, but if it was intentional (it wasn't), that should
>> >    be document=2E  So I'll just switch back to the previous version t=
o
>> >    keep the state of the art
>>=20
>> It is unlikely to be the right thing *going forward*, though=2E
>>=20
>> The very unfortunate performance inversion is likely model-specific=2E =
It is one
>> of those things where you largely would have to have a list of quirks :=
(
>
>Note that the default is still to benchmark the implementations=2E
>This is just about the case where the user explicitly disabled that
>benchmark-based selection=2E
>

The real issue though is that the benchmarking isn't really helpful, eithe=
r=2E=20

It has to do with power across the whole chip, so it perversely enough dep=
ends on what *else* is going on=2E=2E=2E


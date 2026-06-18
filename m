Return-Path: <linux-crypto+bounces-25255-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W7TALAhRNGq7UgYAu9opvQ
	(envelope-from <linux-crypto+bounces-25255-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 18 Jun 2026 22:11:52 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 050A86A2760
	for <lists+linux-crypto@lfdr.de>; Thu, 18 Jun 2026 22:11:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=alien8.de header.s=alien8 header.b=DFsDXOVY;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25255-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25255-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=alien8.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7FBF3038AF7
	for <lists+linux-crypto@lfdr.de>; Thu, 18 Jun 2026 20:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B354330305;
	Thu, 18 Jun 2026 20:11:38 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFBA30675D;
	Thu, 18 Jun 2026 20:11:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813497; cv=none; b=Szah8+vuzk2+DZbYWlBqIAs2sU3vEkhWNY1wBvWnohDhQbLO3s0gazkvpNlWJXKoE+bjragVsG+y5L1hBtBBjiFd3nPMvQAj668YQuGI8ktUOFZoKoXdgvqyVmap+waSbE66w63ZtBKK9rndA+pJi3jZCkicvFdUk7jaarlylKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813497; c=relaxed/simple;
	bh=bR6CgrTL8L9kbMWcBO10mVoLhF34gJMLuouRnWjZ564=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ju001wtmIAEnfZXL1Cv7DdpEG0QxAvIZlwd0KPWmNGPTCgaHjywo0LYMvzid1ID8XOhABAhg/MTAzDEX7ocibhhrHIUKp6AV4yW5ZsmneRvfDx6cs1J6iNLZIhXvQakVWePJEYG5OAx6qEYMRsOQ0s+QSod1yDBUS3ziRYNRjEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DFsDXOVY; arc=none smtp.client-ip=65.109.113.108
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4F09840E02A2;
	Thu, 18 Jun 2026 20:11:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6gZYi2X4M_Mh; Thu, 18 Jun 2026 20:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1781813484; bh=WymufkYy9irEHcYu9yFQ9mnRS4Zsr6ANxKVWzHI9Ae4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DFsDXOVY9N3yVMWpXubiXdLevyL3JPmotJBGGhpNsaC3jyA4SiPH0g1EW3gUfE2hn
	 IjShW55ybqtjgL8Rt3kIj0PnlLyl9bhKz97huLZdhO6aZMdmtQxqk5HnSb6eqEdi/c
	 QjG5XnRckfd4NFxJBWitnlSq7uoIEwwOFLJEJSgCwIX1uCIMtb5pfS8WANErCdEyb+
	 zHnvHx2Zhyuhi+xv2qW+h40lNdWbTJpE9iBw5tdA4cOJEzrLyPMKlEajNQmVP3iWHK
	 +KFh892XDMCWZUEt0bgjutD3zh63DNo8h7jdDnq3AELf4u3bcBugJ6O2IdXWeA7vU+
	 pq0ctKvkUsUrldfpE5DAhtmHmPYfjENLI6ZYR4/JHVVP0CR55s7K2lL1YEtYMMlfom
	 2oC4tu88AjywYSrQPwbauBQtRjWR+rgni6VbbGITBXMEkTbdHZr0rugOJW3V8tcofx
	 fBlluw+onGgQs8v4Ql8ABw4FVxmRqmnsNR/EdFt4xZtdqhV+gWF6GsxHzPaweNEo8I
	 YHVKhgEh2ADBsXTHi6IekekoW/+MdYMcyHDwposvnTTvt0WXdqA3K93tGaZhQe3rTL
	 loX06M5tT1rwL1EIwRU8i5TerLv3Q5lBaXKUCjRPrKpvl+Br2wLVcQpG9Baxk9f68i
	 6P3sRLxn7rbNldxPhQidBazw=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6E77540E01D8;
	Thu, 18 Jun 2026 20:10:49 +0000 (UTC)
Date: Thu, 18 Jun 2026 13:10:46 -0700
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: tglx@kernel.org, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, seanjc@google.com,
	peterz@infradead.org, thomas.lendacky@amd.com,
	herbert@gondor.apana.org.au, davem@davemloft.net, ardb@kernel.org,
	pbonzini@redhat.com, aik@amd.com, Michael.Roth@amd.com,
	KPrateek.Nayak@amd.com, Tycho.Andersen@amd.com,
	Nathan.Fontenot@amd.com, ackerleytng@google.com, jackyli@google.com,
	pgonda@google.com, rientjes@google.com, jacobhxu@google.com,
	xin@zytor.com, pawan.kumar.gupta@linux.intel.com,
	babu.moger@amd.com, dyoung@redhat.com, nikunj@amd.com,
	john.allen@amd.com, darwi@linutronix.de,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	kvm@vger.kernel.org, linux-coco@lists.linux.dev
Subject: Re: [PATCH v8 7/7] x86/sev: Add debugfs support for RMPOPT
Message-ID: <20260618201046.GGajRQxrh8ekVMeyJS@fat_crate.local>
References: <cover.1781419998.git.ashish.kalra@amd.com>
 <cc9aa9b6cfa2ce826f2ad53f8a13d3b7bf0790b6.1781419998.git.ashish.kalra@amd.com>
 <20260618180814.GCajQ0Dv0CoRMJxbP0@fat_crate.local>
 <5849645c-f701-4768-8cdf-1f9032e3226f@amd.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5849645c-f701-4768-8cdf-1f9032e3226f@amd.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25255-lists,linux-crypto=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bp@alien8.de,linux-crypto@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_RECIPIENTS(0.00)[m:ashish.kalra@amd.com,m:tglx@kernel.org,m:mingo@redhat.com,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:seanjc@google.com,m:peterz@infradead.org,m:thomas.lendacky@amd.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:ardb@kernel.org,m:pbonzini@redhat.com,m:aik@amd.com,m:Michael.Roth@amd.com,m:KPrateek.Nayak@amd.com,m:Tycho.Andersen@amd.com,m:Nathan.Fontenot@amd.com,m:ackerleytng@google.com,m:jackyli@google.com,m:pgonda@google.com,m:rientjes@google.com,m:jacobhxu@google.com,m:xin@zytor.com,m:pawan.kumar.gupta@linux.intel.com,m:babu.moger@amd.com,m:dyoung@redhat.com,m:nikunj@amd.com,m:john.allen@amd.com,m:darwi@linutronix.de,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-coco@lists.linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[alien8.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alien8.de:dkim,alien8.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 050A86A2760

On Thu, Jun 18, 2026 at 02:57:45PM -0500, Kalra, Ashish wrote:
> Maybe i can add a line to this patch's commit message stating it's a debug-only interface
> with no stability guarantee.

Sounds to me like you didn't really read that article.

> We have to provide some method/interface for users to verify if RMP optimizations
> are enabled for a GB range of memory.

Sounds to me like this wants to be a facility which is present in the kernel
and it is going to be an ABI.

I am unclear on the real use case but I'm open to being persuaded otherwise.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


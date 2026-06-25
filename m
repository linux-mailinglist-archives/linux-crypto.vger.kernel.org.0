Return-Path: <linux-crypto+bounces-25378-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lFXCIL1DPWoB0ggAu9opvQ
	(envelope-from <linux-crypto+bounces-25378-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 25 Jun 2026 17:05:33 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7266C6ECD
	for <lists+linux-crypto@lfdr.de>; Thu, 25 Jun 2026 17:05:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=alien8.de header.s=alien8 header.b=iQfR2mKs;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25378-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25378-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=alien8.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74849301F181
	for <lists+linux-crypto@lfdr.de>; Thu, 25 Jun 2026 15:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBC026ED25;
	Thu, 25 Jun 2026 15:04:04 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A002236D503;
	Thu, 25 Jun 2026 15:03:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782399843; cv=none; b=ZQ56rJCGDRKa1CJWJaKORSmhWf5x7ZOl6TiARNpBWIGgt5gH/RuVeft8ob4iolMh5wFfKmjI5X4S56T+C9szeV0UfZXLnqWpDQsATODMVjDndmpS+amUnkynHHugnP+YkTeK49yDYMgywO6PDFELmbISBZtDRBjx3Vab+f9wYgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782399843; c=relaxed/simple;
	bh=Uac3s/FkLZu5nWQvtVOiyODe+/g5II1WqX00+hlx0Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmYqzZ/yKmWh7zMe0/LbDj7fk44yNEKI9uYAoLA1TFlHv22lXjriV1DHGgA66CGOovuRRG20k94WqZsXxccZTe1KpMxIt/HHQWuy3WtJ0pT8EsK+dSP9l2I/6A7aN8E2NSCnaV9M5xH3nzzrStT7vH+fxOr30X4PneGAR8toXeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iQfR2mKs; arc=none smtp.client-ip=65.109.113.108
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7508D40E00BF;
	Thu, 25 Jun 2026 15:03:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id eHJzs-crGVFb; Thu, 25 Jun 2026 15:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1782399812; bh=gCbhzWJy0h7/sYHbIeCE/SlEs5Mm3OwXOOEFuRKFBz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iQfR2mKsH6/4iRn5OS5IvrsKEeoUmzF9LkUzPCcf7YVenE/soQ6PsAKMUoLDVJmuQ
	 PGoTr5pLrgnatv6RrMKZzf312NxvxFBvxScjLM61iIBKMEv8P9HoGvspyYgUM+/HHt
	 y+X3bj47cVwMYt048FuJNSDfan7NVCMsbD9iFfPkZ+PynDYAW1eTodbHLiGewZ+1Dg
	 qUT1g2fYK614+p33CJzDbzS+gwXL2U2rtK6VLdNezoOx8eJw2E/V4Svt+Lxhzv2S14
	 WFTAVilpeZDhBDGJlGdTm9LAvD3Ldzc4yHUcKqrG2CPLzZErjQxxfp4lJ/TC38SQIr
	 Phk0d+v8eFilPvOi0dIZn2VnMCYa89K65AlVD/PPRPGRwJMt7Pfg3J27Hx5Yl6Lr+3
	 XKuOptIbrsuC//PcpPASAgXTCi4g7nuAIO1guoOfMthJuoS5OizMD4HBdnwkEwnshr
	 A+5Vgi44j/qeOqOCGJwXzpJtESqthaXOv73g0NiLjpv5dylu8utndj1dYcpK2COGXw
	 6zV680j4z0QVFPAb8SPsIhJR1wMwAheYozw/e8ocW/m6TW4n/eft4FLJBuwljRRcZy
	 96h8e8qcPO7tNuPWVEayz2sH0NCuwINaiUUcvBu9nlJAYdhQ6CDUA6Ir26J9063ZCg
	 7nPKVdJSOhcqlYYnMDpTIIuM=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7C91540E0031;
	Thu, 25 Jun 2026 15:02:57 +0000 (UTC)
Date: Thu, 25 Jun 2026 08:02:53 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
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
Subject: Re: [PATCH v9 3/6] x86/sev: Disable CPU hotplug while SNP is active
Message-ID: <20260625150253.GAaj1DHZC8ULg6PzbI@fat_crate.local>
References: <cover.1782336473.git.ashish.kalra@amd.com>
 <ba146ca15b7f76eee386c8c073fb3f1cc36e5781.1782336473.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba146ca15b7f76eee386c8c073fb3f1cc36e5781.1782336473.git.ashish.kalra@amd.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25378-lists,linux-crypto=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bp@alien8.de,linux-crypto@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_RECIPIENTS(0.00)[m:Ashish.Kalra@amd.com,m:tglx@kernel.org,m:mingo@redhat.com,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:seanjc@google.com,m:peterz@infradead.org,m:thomas.lendacky@amd.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:ardb@kernel.org,m:pbonzini@redhat.com,m:aik@amd.com,m:Michael.Roth@amd.com,m:KPrateek.Nayak@amd.com,m:Tycho.Andersen@amd.com,m:Nathan.Fontenot@amd.com,m:ackerleytng@google.com,m:jackyli@google.com,m:pgonda@google.com,m:rientjes@google.com,m:jacobhxu@google.com,m:xin@zytor.com,m:pawan.kumar.gupta@linux.intel.com,m:babu.moger@amd.com,m:dyoung@redhat.com,m:nikunj@amd.com,m:john.allen@amd.com,m:darwi@linutronix.de,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-coco@lists.linux.dev,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: CE7266C6ECD

On Wed, Jun 24, 2026 at 09:56:49PM +0000, Ashish Kalra wrote:
> +/* Set while SNP has CPU hotplug disabled (kernel-lifetime; survives ccp reload). */
> +static bool snp_cpu_hotplug_disabled;

Do you really need this?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


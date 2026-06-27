Return-Path: <linux-crypto+bounces-25441-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BJYLLa9UP2rbRgkAu9opvQ
	(envelope-from <linux-crypto+bounces-25441-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 27 Jun 2026 06:42:23 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AAB6D1237
	for <lists+linux-crypto@lfdr.de>; Sat, 27 Jun 2026 06:42:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=alien8.de header.s=alien8 header.b=UfUGMpPV;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25441-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25441-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=alien8.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B2593035B73
	for <lists+linux-crypto@lfdr.de>; Sat, 27 Jun 2026 04:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE4C318EE1;
	Sat, 27 Jun 2026 04:42:12 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24801255F28;
	Sat, 27 Jun 2026 04:42:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782535330; cv=none; b=EdkvTy9VK61bPF76M5Ft9e2dvS/e3y2eMPwkOqgiYhLf2aKP7NNI5oKXYsP8X7K5GAKMA3vlS3EvrsBmIpZOuigEgWjMzDDMEsO6iZ4jGFq5eWEWYFuws5+AudWJVSgxm+FNInu6SXCZKyUt0bXzalmDMcb5aYhQoClBRxWs0ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782535330; c=relaxed/simple;
	bh=Dgkw6I0I8RngkbwnY3gthwrXSR/yIF6taaRLVq2DOJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHme5YiMPkqc7OgWciefMT4vYjrDWfjbNg7OsRvcR5tbhUqWcEwu3T3uqa7APtvyDN19/6M0T/cOZ0LEupTYLEarBm7cHy8MwbhpzN+wvqqMS5rcq9Mvl8LvgJO93aDaKlfHIv9lT48EIvzKgJ/Dlhe/OB/kJPCOaeLsfmA9r0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UfUGMpPV; arc=none smtp.client-ip=65.109.113.108
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 98C6340E0031;
	Sat, 27 Jun 2026 04:42:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QMWryNQa_auT; Sat, 27 Jun 2026 04:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1782535315; bh=Hg5YVEN2E3ZCxT1JsO3LxWwlPcxZZD62Wso7eowdbLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UfUGMpPVYc7eio76isweyOY9nyz/Q1E8BiXvGSUyoueWGJfHBtFTE5mIN6C3HsZ0z
	 hHJdBZEjjt5Bs5ifx17kZbiRF9UiTFY3f+XP+GrQDS+ApZ46s7y4yGP7693CwPmP4z
	 NyNOeMQUB9+CzLkPOdkBLRlrDUPYtXSobZVHbQVqeHvjdUnI9ul5Xy6kMvm2IkXjy1
	 O9Pq+mf4473in7kWNQEyDsEyyvOVRhcoumJws1IiKj9jZeGHT8+mmgBZR7Rm8gni5g
	 w33l+HcQc1jpCN9An5Nz9/OJn/9owhvJ0isq6jTGsc9lFiZstpzEUZ5wl2YduAlhfC
	 HW7YP227tXuYho6P0S/P/fZRWZO9zJqrvqYohk+Y+VWSrv1dHZdi6znMoJ8bpAB49z
	 spPGYYaA9x/Snhc4Fg8kS+0/mN1f4G8IGRbAHBV6OK0WT2YxT/UKKlczO12rQ2qmgD
	 CXep+KbUsCfnCEka6HUNOPXbf9F0zfnJpJptTTAljRVWhb2v905WneyiFyOFqhZ7EA
	 4k+BgljTJHQyAddQ+v+S6VLrx/IYX+r3Oz+Q+YW5fpsFO58UQcaRk5TakI6NPjlMtD
	 cCBLHlZELXnJgP06v46LnLdZyjfMbtStEEJdyrt3f32RoHIkBEfOjTNY1Y7VSI9Dv1
	 A1Uxl3MgMBSMexkDHdsnaO5A=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C19A40E00BA;
	Sat, 27 Jun 2026 04:41:20 +0000 (UTC)
Date: Fri, 26 Jun 2026 21:41:17 -0700
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
Subject: Re: [PATCH v9 3/6] x86/sev: Disable CPU hotplug while SNP is active
Message-ID: <20260627044117.GEaj9UbSvTExfmFilu@fat_crate.local>
References: <cover.1782336473.git.ashish.kalra@amd.com>
 <ba146ca15b7f76eee386c8c073fb3f1cc36e5781.1782336473.git.ashish.kalra@amd.com>
 <20260625150253.GAaj1DHZC8ULg6PzbI@fat_crate.local>
 <7c64d96f-f932-4db9-8119-b9e40d5b7fd9@amd.com>
 <20260626164032.GDaj6rgHq4xPd-qjvG@fat_crate.local>
 <9d019b55-739d-429c-bb34-ce792e8340b6@amd.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d019b55-739d-429c-bb34-ce792e8340b6@amd.com>
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
	TAGGED_FROM(0.00)[bounces-25441-lists,linux-crypto=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fat_crate.local:mid,alien8.de:dkim,alien8.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12AAB6D1237

On Fri, Jun 26, 2026 at 03:59:34PM -0500, Kalra, Ashish wrote:
> It can be that simple, and flag-free, by following the SNP_EN state:

Maybe. But that doesn't mean that you should not clean things up first where
needed. But I'll do a proper review once the dust from patchsets flying around
settles.

> We also have to re-enable cpu hotplug on the init failure paths 
> (snp_prepare()'s online != present check, and the SNP_INIT_EX / DF_FLUSH failures in 
> __sev_snp_init_locked()), so a failed init leaves hotplug enabled, as it was before
> this support.

You could also block hotplug for the time being by grabbing cpus_read_lock().
And only when you know you are all clear to disable hotplug, then you can do
that in the end and drop the hotplug lock.

> The only extra case is a kexec target that boots with SNP_EN already set (legacy
> firmware -- on X86_SNP_SHUTDOWN firmware the full shutdown required before kexec
> clears SNP_EN, so the target re-inits normally). There snp_prepare() bails, so I
> do the disable once at boot in snp_rmptable_init() when SNP_EN is already set.
> That and the snp_prepare() disable can't both run -- SNP_EN is either already set
> at boot, or it gets programmed by snp_prepare().

Ok.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


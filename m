Return-Path: <linux-crypto+bounces-25280-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9oF5JYnAN2pcRwcAu9opvQ
	(envelope-from <linux-crypto+bounces-25280-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 21 Jun 2026 12:44:25 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0055C6AA9DB
	for <lists+linux-crypto@lfdr.de>; Sun, 21 Jun 2026 12:44:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mE4NV8SU;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25280-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25280-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 288EF300B556
	for <lists+linux-crypto@lfdr.de>; Sun, 21 Jun 2026 10:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864A03403F1;
	Sun, 21 Jun 2026 10:44:18 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC071A6829;
	Sun, 21 Jun 2026 10:44:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782038658; cv=none; b=hDJYwuatwHsO5B1nNqCNJ4Jv+7rRS0L7pjf838XNtLJaPFOdTHE2eXW8giezcbwgUhaiaJRojWD7ahOoQ0PMT45cTeLS+QBzKcHn1xGPT8TfIWUFnPE5hxwBBySvJhBnXRKSjBLsWdwK9bnr+aoO+cyX2ZWb4s4SgfA8pKwAbek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782038658; c=relaxed/simple;
	bh=QM4BW+Se0xS0feWQ0RySLRmnpDhsQ2somB3WvhbhRHM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OwY15T7j5mLtz7O+cA6CRsOfy0gCCAjN4eVoVn/TR1PRSIMMOklD850TutOJ7Qw6YrS+L7yU4QiySMmbFH1InwOIJ8Zs7QIaTv/Z9nu/Z8kb2oMdk6Rh+qH28UzSfAJ6UZDIIRwY+2QULdKy5mG+3bJnavK4uE5p7gmyg7Nt3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mE4NV8SU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AC21F000E9;
	Sun, 21 Jun 2026 10:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782038657;
	bh=65JqXxMqQ34nDFxTpNu1D7QubbJQ2zgWdNEBKESFgc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=mE4NV8SU9Yxbw+x62c3ej466A4D2vbNkkezUwYsLGovWSkcZLkntr7p0QeO1bs2e6
	 1S3X8vPTE/a7lCu2Jm7Eu639RLwy8piMQHnXtPGq5yaPKH5NAjjYNGavilDfcoxf4r
	 0JIdVv6/sk1NMeJdVTI8WXw4/22khm6DWVN6gWOdPnuxkrsz67K4y+Mzn+VfEmA83h
	 VKZ65gS9/KmXkXc1XVilz+0Kd9XkETcYAGiW+eckOISVFYHozvUuK2YBv4k8gjdqRS
	 Z00jPZp7od0X5j7ANkctfg//RRKQ7ktMAzn03tNvssxGe0+IGDBWhrx6A4E6N2qilO
	 wrl+BmW2uhmsw==
From: Thomas Gleixner <tglx@kernel.org>
To: "Kalra, Ashish" <ashish.kalra@amd.com>, Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 seanjc@google.com, peterz@infradead.org, thomas.lendacky@amd.com,
 herbert@gondor.apana.org.au, davem@davemloft.net, ardb@kernel.org,
 pbonzini@redhat.com, aik@amd.com, Michael.Roth@amd.com,
 KPrateek.Nayak@amd.com, Tycho.Andersen@amd.com, Nathan.Fontenot@amd.com,
 ackerleytng@google.com, jackyli@google.com, pgonda@google.com,
 rientjes@google.com, jacobhxu@google.com, xin@zytor.com,
 pawan.kumar.gupta@linux.intel.com, babu.moger@amd.com, dyoung@redhat.com,
 nikunj@amd.com, john.allen@amd.com, darwi@linutronix.de,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev
Subject: Re: [PATCH v8 3/7] crypto/ccp: Disable CPU hotplug while SNP is active
In-Reply-To: <e68a126a-6f2e-4a76-a691-f514b7f37489@amd.com>
References: <cover.1781419998.git.ashish.kalra@amd.com>
 <1feccf6e2a56d949b30f403c0ca7949f580e5982.1781419998.git.ashish.kalra@amd.com>
 <49380c3e-c275-4211-876a-c51f644aeb17@intel.com>
 <bd2dc2e0-e975-40a9-8e0a-4403db858316@amd.com>
 <20260619221022.GBajW-TvxyCuGo0FWX@fat_crate.local>
 <d91bf0a8-0c4a-4552-9009-0ecef46aa279@amd.com>
 <20260619232007.GCajXOpyPbiu4FVZIW@fat_crate.local>
 <e68a126a-6f2e-4a76-a691-f514b7f37489@amd.com>
Date: Sun, 21 Jun 2026 12:44:13 +0200
Message-ID: <87fr2gmav6.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ashish.kalra@amd.com,m:bp@alien8.de,m:dave.hansen@intel.com,m:mingo@redhat.com,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:seanjc@google.com,m:peterz@infradead.org,m:thomas.lendacky@amd.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:ardb@kernel.org,m:pbonzini@redhat.com,m:aik@amd.com,m:Michael.Roth@amd.com,m:KPrateek.Nayak@amd.com,m:Tycho.Andersen@amd.com,m:Nathan.Fontenot@amd.com,m:ackerleytng@google.com,m:jackyli@google.com,m:pgonda@google.com,m:rientjes@google.com,m:jacobhxu@google.com,m:xin@zytor.com,m:pawan.kumar.gupta@linux.intel.com,m:babu.moger@amd.com,m:dyoung@redhat.com,m:nikunj@amd.com,m:john.allen@amd.com,m:darwi@linutronix.de,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-coco@lists.linux.dev,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORGED_SENDER(0.00)[tglx@kernel.org,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25280-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fw13:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0055C6AA9DB

On Fri, Jun 19 2026 at 18:51, Ashish Kalra wrote:
> On 6/19/2026 6:20 PM, Borislav Petkov wrote:
>> I'd let tglx maybe give a better idea but this cpu_hotplug_disable stati=
c var
>> in kernel/cpu.c could get a getter function and be used instead of you
>> reinventing the wheel in here.
>
> I don't follow =E2=80=94 I'm not reinventing anything here. Patch 3 will =
use
> the existing CPU-hotplug callback interface: cpuhp_setup_state() with
> a down callback that returns -EBUSY to refuse the offline while SNP is
> active. That's the standard mechanism for conditionally preventing a
> CPU offline, and it keeps no private "hotplug disabled" state of its
> own =E2=80=94 so there's nothing here for a getter on cpu_hotplug_disable=
d to
> replace.

That's not a standard mechanism. That's a hack as you have to start the
offlining operation in order to prevent something you already know.

The return code which prevents offlining is there for situations where
the subsystem/driver is momentarily in a state which cannot be
resolved.

That's a very different story than knowing that state at the point of
installing the callback already.

> I chose the cpuhp callback specifically over
> cpu_hotplug_disable_offlining(): the callback can be torn down with
> cpuhp_remove_state() when SNP is fully shut down, which re-enables CPU
> offlining. cpu_hotplug_disable_offlining() sets
> cpu_hotplug_offline_disabled, which is __ro_after_init and one-way =E2=80=
=94
> there's no interface to clear it, and adding one would mean dropping
> the __ro_after_init marking and a new core "re-enable offlining"
> API. So that route can't re-enable offlining on SNP shutdown without
> new core plumbing, whereas the cpuhp callback gives me that for free.

That's exactly the wrong attitude. Hack around a core limitation in a
random driver by abusing the provided mechanism instead of sitting down
and doing the extra five lines of code which makes it entirely clear
what's going on.

When Boris asked me how to disable hotplug, I had the impression that
this is about permanently preventing it. So I pointed him to
cpu_hotplug_disable_offlining().

If I had known that it's about temporary prevention during runtime of
something, then I'd pointed him to cpu_hotplug_disable()/enable() which
is five lines farther down in cpu.c. It's not rocket science to find
them. The first AI chatbot I asked pointed me to it immediately.

cpu_hotplug_disable()/enable() is _the_ standard mechanism to prevent
hotplug operations temporarily. They return -EBUSY without invoking any
callback or changing any related state.

So what's exactly the new core plumbing you need?

Thanks,

        tglx



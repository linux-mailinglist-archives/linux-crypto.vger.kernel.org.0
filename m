Return-Path: <linux-crypto+bounces-25176-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BFD5E75uMGoGTAUAu9opvQ
	(envelope-from <linux-crypto+bounces-25176-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 15 Jun 2026 23:29:34 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2A268A2B9
	for <lists+linux-crypto@lfdr.de>; Mon, 15 Jun 2026 23:29:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BQ2gnviW;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25176-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25176-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15141302EA81
	for <lists+linux-crypto@lfdr.de>; Mon, 15 Jun 2026 21:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6563B6370;
	Mon, 15 Jun 2026 21:29:25 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBFD3AC0DE;
	Mon, 15 Jun 2026 21:29:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781558965; cv=none; b=GeVNtjZgFaHHa5Ln+SGSmKTXyl6cVUJtXDOOBK6QTCCDk1SQcTJjqIaNwNb0E2YXo+Oow4UGS7pNJsdW41dZLcZ/3Oz26tgIZ4aW3VT6BoxWg8CDHJzv2JqYdjylEnIb/R64ULQhHpVjfKULapg0TedQwkKmmXZeY17sEX4FRuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781558965; c=relaxed/simple;
	bh=1QyGAUHP8NHnhNgxPVSSS9PQo/FTFaghbcd5ZkSK9Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZRXWQGZnEZUsYyYBvLEHajZmN1tsp7alfj5wjwYtR7semwvajfXwUblPnkc4qPXkwhft5tZ17r+sbyt8E19hYeoECZepOdK8mPKqcmXFiJdUUPNq9hWANOhEJDqQ5P4gKfvUaL0O86/KajZULfeZ0XohNSyHgR7ytmFx+bSRks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQ2gnviW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B22A1F000E9;
	Mon, 15 Jun 2026 21:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781558964;
	bh=NtZ5XkX1ehA204kS+Yeeagx3kh9JgNZcgIjpxIhdmzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BQ2gnviW42fKkTOjkZvSWdr1TzWfFOnw5PsOuGsJK3oESFjbP7Q7w4RIl1vy2EMRt
	 2GobcbP0msa3beec2tf9BOSHvKBYrzdnUC7h7JdKL6RaPODbiGUvgUgHyTZPoBKr+i
	 TRouRsuiWZchxWjZk1crUY7IdllvJrMte4LQ9i/f8Br23KgW7Hw3LSMjo4fqBZJAUL
	 JLUyPc00hKziXkoPiGUeUb63qwF31a2mFdqCZTw/9jfabJFPibm1fcuLvOPYVHTxtk
	 QT4zYVajL63ukEV2a7TrUuCiLyn76yXb1RXgcfkglq6ZHlcSqFS7hGP7BR6nrkSdWw
	 MJ93nFWvPk2zw==
Date: Mon, 15 Jun 2026 14:29:22 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Christoph Hellwig <hch@lst.de>,
	linux-crypto@vger.kernel.org,
	David Laight <david.laight.linux@gmail.com>,
	linux-raid@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] lib/raid/xor: x86: Add AVX-512 optimized xor_gen()
Message-ID: <20260615212922.GA28589@quark>
References: <20260615190338.26581-1-ebiggers@kernel.org>
 <20260615201050.GB1764@quark>
 <255CAE3E-7FD3-4DC2-B3DE-46BE67EF22A8@alien8.de>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <255CAE3E-7FD3-4DC2-B3DE-46BE67EF22A8@alien8.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25176-lists,linux-crypto=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:bp@alien8.de,m:x86@kernel.org,m:hch@lst.de,m:linux-crypto@vger.kernel.org,m:david.laight.linux@gmail.com,m:linux-raid@vger.kernel.org,m:akpm@linux-foundation.org,m:linux-kernel@vger.kernel.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lst.de,vger.kernel.org,gmail.com,linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC2A268A2B9

On Mon, Jun 15, 2026 at 09:16:55PM +0000, Borislav Petkov wrote:
> On June 15, 2026 8:10:50 PM UTC, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> >But I wanted to ask: do we really care about the case where features are
> >"supported" but their XCR0 bits aren't set?  Perhaps the kernel just
> >doesn't/shouldn't support weird cases like "-cpu max,xsave=off"?
> >
> 
> Yes, our aim is to support only configurations which are actually
> present in real hardware and not a "oh, it would be good if it did
> that, just because..."

Seems reasonable to me.  Would the same apply to UML here?

> >If this case indeed needs to be handled, could we make things easier for
> >the kernel's AVX and AVX-512 optimized code?  Currently AVX-512 needs:
> >
> >        if (boot_cpu_has(X86_FEATURE_AVX512F) &&
> >            cpu_has_xfeatures(XFEATURE_MASK_FP | XFEATURE_MASK_SSE |
> >                              XFEATURE_MASK_YMM | XFEATURE_MASK_AVX512, NULL))
> >
> >How about we make X86_FEATURE_AVX512F depend on XCR0=111xx111, and
> >X86_FEATURE_AVX depend on XCR0=xxxxx111?  Then the cpu_has_xfeatures()
> >check wouldn't be needed.  Is there any reason not to do that?
> 
>  How do you want to accomplish that? Very early during boot on the BSP
>  you sanity-check XCR0 and clear feature flags if components are not
>  set? 

That would be the idea.  Something similar to what
arch/x86/kernel/cpu/cpuid-deps.c does.  Except that seems to only
enforce the dependencies when the kernel itself is disabling things; if
the hypervisor is broken then it just warns.

In any case, I'd like these to go away:

    $ git grep cpu_has_xfeatures | wc -l
    31

- Eric


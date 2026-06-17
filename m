Return-Path: <linux-crypto+bounces-25208-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GbUCAbg0MmoJwwUAu9opvQ
	(envelope-from <linux-crypto+bounces-25208-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Jun 2026 07:46:32 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 845BD696A97
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Jun 2026 07:46:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25208-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25208-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7DD630873F7
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Jun 2026 05:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04D63A3E87;
	Wed, 17 Jun 2026 05:45:09 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02E33E351;
	Wed, 17 Jun 2026 05:45:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781675109; cv=none; b=f4+AHaaAQLb3o9BYmg3h/2aq4Lcg+/BIc3sQ1MhAltEpw2xaEZweMcYXH7I7Zp6QM0/p7T+eoEp+Z93pKDzT/atSAHN9UO9kd58NfJDjDcEtdUH6gS5vWbilfARazJZBbW7u66fgwaOSurSnPf/phJgMPThsaesmOX699qkow+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781675109; c=relaxed/simple;
	bh=ItZc8XWqX890nlY47RSC4Plq76j3f4jdB22w3KvoZec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucFA1V8FdFliyNIH7V416piKKNvprdvq4apfI0o+5+eGtf7VO1TZPVkQL1tar2MnWO9XA2/FjkuOPXi7/RVLzlJ/4evuAfoOc6A2IzBK8YEM0+lJiE5vVnUsOiyFml+z1rpZj/EHm0TltwO1efLht2z37HReFtcEnV4xdUH0Wl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Received: by verein.lst.de (Postfix, from userid 2407)
	id 212A968C4E; Wed, 17 Jun 2026 07:44:56 +0200 (CEST)
Date: Wed, 17 Jun 2026 07:44:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Eric Biggers <ebiggers@kernel.org>,
	Richard Weinberger <richard@nod.at>, x86@kernel.org,
	Christoph Hellwig <hch@lst.de>, linux-crypto@vger.kernel.org,
	David Laight <david.laight.linux@gmail.com>,
	linux-raid@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH v3] lib/raid/xor: x86: Add AVX-512 optimized xor_gen()
Message-ID: <20260617054456.GA19125@lst.de>
References: <20260615190338.26581-1-ebiggers@kernel.org> <20260615201050.GB1764@quark> <255CAE3E-7FD3-4DC2-B3DE-46BE67EF22A8@alien8.de> <20260615212922.GA28589@quark> <20260615235318.GBajCQbuy9dBgKH8L_@fat_crate.local> <a832eee3-55ec-4cf4-907f-346ff98870ca@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a832eee3-55ec-4cf4-907f-346ff98870ca@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dave.hansen@intel.com,m:bp@alien8.de,m:ebiggers@kernel.org,m:richard@nod.at,m:x86@kernel.org,m:hch@lst.de,m:linux-crypto@vger.kernel.org,m:david.laight.linux@gmail.com,m:linux-raid@vger.kernel.org,m:akpm@linux-foundation.org,m:linux-kernel@vger.kernel.org,m:linux-um@lists.infradead.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hch@lst.de,linux-crypto@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-25208-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-crypto@vger.kernel.org];
	FREEMAIL_CC(0.00)[alien8.de,kernel.org,nod.at,lst.de,vger.kernel.org,gmail.com,linux-foundation.org,lists.infradead.org];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 845BD696A97

On Mon, Jun 15, 2026 at 05:29:58PM -0700, Dave Hansen wrote:
> On 6/15/26 16:53, Borislav Petkov wrote:
> > 
> >> In any case, I'd like these to go away:
> >>
> >>     $ git grep cpu_has_xfeatures | wc -l
> >>     31
> > Yeah, all in crypto. I can certainly see why.
> > 
> > @dhansen, any other thoughts?
> 
> If we can get rid of cpu_has_xfeatures(), I'm all for it. I'm not quite
> sure how the code would look so I'm reserving judgement until I see the
> patches. But it's worth a try.

I think the most important part is to be consistent.  Either use it
everywhere or not at all.


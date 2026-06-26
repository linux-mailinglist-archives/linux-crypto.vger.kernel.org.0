Return-Path: <linux-crypto+bounces-25416-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E0SDHhwRPmrd/QgAu9opvQ
	(envelope-from <linux-crypto+bounces-25416-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 07:41:48 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ABF6CA734
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 07:41:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25416-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25416-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56A90303E2FF
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 05:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3233C819B;
	Fri, 26 Jun 2026 05:39:58 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72AD3C555B;
	Fri, 26 Jun 2026 05:39:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782452398; cv=none; b=UZI35z5adcgVU7dEhtSpR2VwB443coPtSRaD0YUwe6fLXg2c8pxjQQPI0kw3ztHbLqNNbMyk+1+lQ2cUdezhJB0EEjLdMMTX9P4Tn829Yk91CeY3G2X1bdd0aKMh1Nm4JSMm95ipgqp1Va80IaCmB/D9CR+xJt9+x8Sqm2amrmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782452398; c=relaxed/simple;
	bh=TQSzTw9EAFYugue+JZNGZyvxo8PM1nt9mOtOsEaMWQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoKKTQkqovneFes02pXIWOKe0t28dTYi0CuayQ6zf1uoVWnv5xpuaGgAG8sSHzTiSMiVoAdPXcjHLYL4pE47Ohzgc1nrjfe99Ip7iH/+Hu8ELNHAM7h/aCqkWC1AXskthdFIuunUC6nz3q/zmR2oS2/zUW88K30CX/J8+XCU1DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Received: by verein.lst.de (Postfix, from userid 2407)
	id 53D4268B05; Fri, 26 Jun 2026 07:39:55 +0200 (CEST)
Date: Fri, 26 Jun 2026 07:39:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/8] x86/fpu: Check for missing AVX and AVX-512 xstate
 bits
Message-ID: <20260626053955.GA9629@lst.de>
References: <20260626043731.319287-1-ebiggers@kernel.org> <20260626043731.319287-2-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626043731.319287-2-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25416-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:x86@kernel.org,m:linux-um@lists.infradead.org,m:linux-raid@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hch@lst.de,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hch@lst.de,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9ABF6CA734

On Thu, Jun 25, 2026 at 09:37:24PM -0700, Eric Biggers wrote:
> If the CPU declares AVX or AVX-512 support, verify that the
> corresponding xstate bits are also set.  If not, warn and clear them.
> 
> This eliminates the perceived need for AVX and AVX-512 optimized code in
> the kernel to call cpu_has_xfeatures().  That has never been universally
> done, which strongly suggests that it has never really been needed in
> practice, but this should remove any remaining doubt.

I'll leave it to the x86-experts if the low-level details are right,
but the model behind this makes life so much easier, thanks a lot!



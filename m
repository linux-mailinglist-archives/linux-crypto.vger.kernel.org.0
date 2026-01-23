Return-Path: <linux-crypto+bounces-20277-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fZHgBubrcmn7rAAAu9opvQ
	(envelope-from <linux-crypto+bounces-20277-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Jan 2026 04:32:54 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EBF70213
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Jan 2026 04:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 38E023003812
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Jan 2026 03:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5CE3002D1;
	Fri, 23 Jan 2026 03:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="cMC8nvBy"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3723016F1;
	Fri, 23 Jan 2026 03:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769139164; cv=none; b=XkL7WcnPKwoQNn3J5jmRqoJ2a1tftH4CeeTWMYNiucTR9MTlLYGDejWoCGNefm+JdW6Pq3F5glSWHLwHTauqjSsXIe3M8xHzjDGCnBWKDXQablBsa+AXFXs/HXyCP4tHtHqPIqBqlUgWxqCz6N7guinOrJIjseggoZPVCk53VP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769139164; c=relaxed/simple;
	bh=gF/i4IR8y19R6gRrX02AJfQOJqwtpg4uh2p5qqwacpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otOwbUOGJG5/V70fIu1yT+Zl76THyvtqwqmgM+LE6koRLrkksyGzuCwhagz/8yfxkLDlFRoX8+cArULhyYtBRskFaZQbmhY7q9aH7ow57kCCNE0O++m2BE2V6kYJXAXVgGdS13GW6s1P107duQXYPmOvgnoeGPXdiPjPZURNmgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=cMC8nvBy; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=1xvQICTrNsOTRoGyM7s8BzLHZBzr1UcMJo3Az5JyZf0=; 
	b=cMC8nvByJUyj4mhnMtNH0ZglLFZqQC2q19ZCxFMBTGe7Qodm/nF28LPKnang9n/IbNXAi/zW99T
	H0rT0azOp6eVW6/+NwS1mRC3G6JGvaEwD42Dh2g3fLynSPvnp0gMmuPNj4bCq+RuPespLbrR0L1Bz
	DQF+pJIJdtY87hHMQ/QkJv8f/kWzmdsPGmcAWg2TMyz5V+CrIjRNQQnG8ge2dvvNmzyg8O6NlAMeM
	SYhtA5g5LtpJQizm1/ru3b6uinw1sDuPXfXp53jQQ+GL0C199xiYFL5s7HLM0f/DiN42plkvjvaMw
	hqGgxiBVIBvAO0LT1u2Y+JANcgZSF9f6BCRA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vj7uH-001U9T-2w;
	Fri, 23 Jan 2026 11:32:22 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 23 Jan 2026 11:32:21 +0800
Date: Fri, 23 Jan 2026 11:32:21 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Lianjie Wang <karin0.zst@gmail.com>
Cc: Olivia Mackall <olivia@selenic.com>,
	David Laight <david.laight.linux@gmail.com>,
	Jonathan McDowell <noodles@meta.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwrng: core - fix racing condition when stopping
 hwrng_fill
Message-ID: <aXLrxVR0tmPuzIyM@gondor.apana.org.au>
References: <20251221122448.246531-1-karin0.zst@gmail.com>
 <aXLiYQuXehWtvRrx@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXLiYQuXehWtvRrx@gondor.apana.org.au>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[selenic.com,gmail.com,meta.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20277-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.957];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: C7EBF70213
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 10:52:17AM +0800, Herbert Xu wrote:
> On Sun, Dec 21, 2025 at 09:24:48PM +0900, Lianjie Wang wrote:
> > 
> > Besides, if the hwrng_unregister() call happens immediately after a
> > hwrng_register() before, the stopped thread may have never been running,
> 
> How can this happen? Surely that would mean that the kthread_* API is
> broken?

OK, kthread_stop can stop the thread without ever calling threadfn.

However, rather than having unregisters/registers firing off in
parallel, let's just make sure that register cannot start until
the unregister is actually done.

The thing that's stopping us from waiting on kthread while holding
the mutex is the get_current_rng() call in the kthread.

We could get around this by converting the lock for get_current_rng
to RCU instead.  That should allow hwrng_unregister to safely wait
on the kthread without dead-lock.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


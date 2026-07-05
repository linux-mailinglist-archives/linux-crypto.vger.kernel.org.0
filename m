Return-Path: <linux-crypto+bounces-25607-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QKoHO6UYSmox+QAAu9opvQ
	(envelope-from <linux-crypto+bounces-25607-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 05 Jul 2026 10:41:09 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D26709813
	for <lists+linux-crypto@lfdr.de>; Sun, 05 Jul 2026 10:41:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=KwNILoaH;
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25607-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25607-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB7DD300B129
	for <lists+linux-crypto@lfdr.de>; Sun,  5 Jul 2026 08:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3665336E47F;
	Sun,  5 Jul 2026 08:40:42 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6816C3655E4;
	Sun,  5 Jul 2026 08:40:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783240842; cv=none; b=M5MfPHu+DpFn9OHWc3I+Eh7DhRTUfIwRv+0i5mWo7NKbQtmf6y0x7ANgYPdF3esMNh/uiMhF/GnnP/k0RUbOxCG/xaZDsRcAyRwjmKagVpmeEjGbCv1vNyRkSyNiFnumnKswU35wJu6yvNDX3OdHv/7JiG/bugEWDd62C25Bjuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783240842; c=relaxed/simple;
	bh=VuEaAkyppu/R2pvv0B3sw6YTS2Iy7EgVM3Z42uemsMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gf33+bwViDhYA3E9G9FPV6JwBBF21M7EgFntmN5SmqKsmQU0d3tppKwmFK1wFMh8GZl+Lq7n4uKPewTSXENohfPugUOuO+9qq5JcaY4E0ceRyD8eYwz/Y9j3rjOx7CAXhAnAtN0IhRQDJNtmBncQLwhlYKMcYBugydTvmLY80yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=KwNILoaH; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=fgN10qr9rzMiZz95whcT5IzNS4P92S8rLU/+wxOsYew=; 
	b=KwNILoaHbaEy/ggQu/+zEXUC+d46ZY33rNmvVY2y+383CEHjwM7aXMdRG7JFrb/LW8Kgxa2EerN
	mx1obithbkZo0v4wgEZCDSKlVPAmzJ/BHaXSx01D2t77dLkRcxuCekgMrOOR4JhtjsicVGj+Slxyj
	zuSM/ZgAo1QW6V4/WVZxVzkp0albR5C70vSbe/XYtuRijkviVtR7UjSiRxSFLAHb4NqB+icW8lpaO
	qLx8Fv55Wq0fqtic1fvDAfcwakqqLk9oTb784x8DIse4vDf0YZvbB6EbD3iLr8X2dXhmqNDeoWY9/
	g2Aqa1N8eGxDNe7KXbUjT9SfeYPY1k7IYldw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wgIOx-0000000Al7a-3zCW;
	Sun, 05 Jul 2026 16:40:37 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 05 Jul 2026 16:40:35 +0800
Date: Sun, 5 Jul 2026 16:40:35 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Deepak Saxena <dsaxena@plexity.net>,
	Olivia Mackall <olivia@selenic.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] hwrng: omap: Fix probe error path cleanup
Message-ID: <akoYg-74TuBEaXJ4@gondor.apana.org.au>
References: <20260623084612.58054-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623084612.58054-1-mhun512@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25607-lists,linux-crypto=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:mhun512@gmail.com,m:dsaxena@plexity.net,m:olivia@selenic.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ae878000@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FREEMAIL_CC(0.00)[plexity.net,selenic.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,apana.org.au:url,apana.org.au:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,gondor.apana.org.au:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42D26709813

On Tue, Jun 23, 2026 at 05:42:23PM +0900, Myeonghun Pak wrote:
> omap_rng_probe() enables runtime PM before acquiring and enabling the
> functional clocks.  Several later error paths returned or unwound without
> undoing all state acquired so far.
> 
> If pm_runtime_resume_and_get() failed, the driver returned through the
> generic ioremap error label and left runtime PM enabled.  If either clock
> lookup returned -EPROBE_DEFER, the function returned directly and skipped
> the runtime PM cleanup; the register clock defer path could also leave the
> already enabled functional clock prepared.
> 
> Route these failures through the existing unwind labels so each path only
> undoes resources that were acquired successfully.  Keep the resume failure
> path limited to pm_runtime_disable(), and use the later labels only after
> the runtime PM usage count or clocks have been acquired.
> 
> This issue was identified during our ongoing static-analysis research while
> reviewing kernel code.
> 
> Fixes: 61dc0a446e5d ("hwrng: omap - Fix assumption that runtime_get_sync will always succeed")
> Fixes: 43ec540e6f9b ("hwrng: omap - move clock related code to omap_rng_probe()")
> Fixes: b166be004491 ("hwrng: omap - Fix clock resource by adding a register clock")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> 
> ---
>  drivers/char/hw_random/omap-rng.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


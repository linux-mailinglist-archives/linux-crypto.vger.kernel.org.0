Return-Path: <linux-crypto+bounces-25597-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CA8gN0MWSmrL+AAAu9opvQ
	(envelope-from <linux-crypto+bounces-25597-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 05 Jul 2026 10:30:59 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5F170973F
	for <lists+linux-crypto@lfdr.de>; Sun, 05 Jul 2026 10:30:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=aKGFPoFW;
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25597-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25597-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69ED33025D2E
	for <lists+linux-crypto@lfdr.de>; Sun,  5 Jul 2026 08:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D6436E468;
	Sun,  5 Jul 2026 08:30:35 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A246369D67;
	Sun,  5 Jul 2026 08:30:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783240235; cv=none; b=RgefY4y4Q6iqTjjWQBXcA/Uzage/A40mQ9B7L7qgRpUyUGZl/ryq9XErcpRfFWAD7vSqE/9LQuaxE2NrsyQ6YgM792Dvwmx2sI6W1sAqOLjNGeKKziJeIEQT8Atkdc8pDB1S5U+Ib6KIoCNSOiZJz4PyWtIm071aX1uCU5C2C/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783240235; c=relaxed/simple;
	bh=T5VMi9AtI423nze0MHwUpvqJg3rDe2kcWX2Z9/7gHTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uq/ImfAJPl0GAXgEipTjavfWH1fdZnHFPqNHOd0e9SPli19GGOcYlM9QcrbJzVRLI2GtqHeMXkJr5qPg4QULhjJMt4GkXDmnP39mv8Rbyck8D6adlBofUwBWflB+f8b4r5MASHgqM0w9+Jgye3YkSgdLgnXuDBROlR4lPxvkf8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=aKGFPoFW; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=ncYdBTDKwnyVdvlOqydNM/W0W9BJ6MKobd1nuSlkn1U=; 
	b=aKGFPoFWCA0370pN0vS51SOgTImWfEyUY/bk4kuDMWlbEMjxpn9eC715rfipK2b6RF75obz8EN6
	aDxHa9KosC5+Ee0EByTVqHpQWt0P5YXYNkwxD6mmaQlGXaN1Kif3t9IQjzrBlj6KwtLZ1TeXfMy0s
	kYSeGi6izxkAV9m3W5Ikn8GtIG3sD4hemTo0RpfEklqgYh8B1LNs7t0Ry/RpdPUzGw+6O5r6V0QLl
	QI9IVWhFmN4ZmKPM1YnJxJBrqBD9MK36CgJgacDMNPILHDBC/YzC1BG4pq1gatnwGwSFR9nZQHNlc
	HtLzk43m6HGFaS+fDV3IWrRUgZE5RbitrlJg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wgIF6-0000000Akxs-2I9Q;
	Sun, 05 Jul 2026 16:30:25 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 05 Jul 2026 16:30:24 +0800
Date: Sun, 5 Jul 2026 16:30:24 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: thorsten.blum@linux.dev, davem@davemloft.net,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, ardb@kernel.org, krzk+dt@kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] crypto: atmel-sha204a - fix heap info leak on I2C
 transfer failure
Message-ID: <akoWIPq1p0YUIdyF@gondor.apana.org.au>
References: <20260613202037.47744-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613202037.47744-1-l.rubusch@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25597-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:l.rubusch@gmail.com,m:thorsten.blum@linux.dev,m:davem@davemloft.net,m:nicolas.ferre@microchip.com,m:alexandre.belloni@bootlin.com,m:claudiu.beznea@tuxon.dev,m:ardb@kernel.org,m:krzk+dt@kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:lrubusch@gmail.com,m:krzk@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,apana.org.au:url,apana.org.au:email,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F5F170973F

On Sat, Jun 13, 2026 at 08:20:37PM +0000, Lothar Rubusch wrote:
> The nonblocking RNG path allocates a work_data structure to track the
> state of an in-flight asynchronous I2C request. This pointer is stored
> in rng->priv and later consumed by the read path once the transaction
> completes.
> 
> If the underlying I2C transfer fails, the completion callback is invoked
> with a non-zero status. In this case, the allocated work_data is not
> usable for producing RNG output and must not remain associated with the
> hwrng state.
> 
> Previously, the failure path only logged a warning but left the pointer
> state uncleared, which can result in subsequent read attempts observing
> stale state and interpreting it as valid completion data.
> 
> Fix this by freeing the pending work_data. The I2C transaction reports
> an error. This ensures that failed requests do not leave residual state
> behind that could be interpreted as valid RNG data on later reads.
> Clearing rng->priv is done at the subsequent call to nonblocking read.
> 
> Fixes: da001fb651b0 ("crypto: atmel-i2c - add support for SHA204A random number generator")
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> Assisted-by: Gemini:1.5 Pro [google]
> Reviewed-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> v2 -> v3:
> - remove existing error-path cleanup behavior [`rng->priv = 0;`],
>   update commit msg
> - rebased
> 
> v1 -> v2:
> - reword commit message for clarity and precision
> - keep existing error-path cleanup behavior unchanged, update commit msg
> 
>  drivers/crypto/atmel-sha204a.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


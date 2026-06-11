Return-Path: <linux-crypto+bounces-25074-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NX9kG8J4KmqzqAMAu9opvQ
	(envelope-from <linux-crypto+bounces-25074-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 10:58:42 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A786701A6
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 10:58:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=HIvbi4vk;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25074-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25074-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAB0631C3223
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 08:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295B539A4B3;
	Thu, 11 Jun 2026 08:54:14 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4F23D76;
	Thu, 11 Jun 2026 08:54:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168053; cv=none; b=VixGFDaSukWmJxPC1VhJp+QKpPlEUMKyKWCneP5FJftq9qKMzdGtq0gk4269YJovzI1KNH9e35NkPaSv6fdXRLgZPGJ/BUuqhZB26IKQ+TQkV6uAyBQqw9ydOPGmEvAodKwU7bCBtPSBfYESB6rJT36PfzZCFV3Oopz86vyztfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168053; c=relaxed/simple;
	bh=M+cUBQ61Srmxt6XFPltv9FRXDHD7Fyobob8NNiHAcnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hS2yT1+N83ByGI3zhIGg+L1M7yKR2gXrj4Wwx4DO+fAdKyXuOVcAFfMTHL0Rn7LnVrFYLLW848WhD92eR4bW4yiaINX+KRR4AdxSzUTyXTAHfx2HYLdg22retGBZPybzx1pziX2NHTFBM3peVv5dibkmBJIHsu085GxiQ2hUYAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=HIvbi4vk; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=MUHMqAo3ugkJlQ7EQw5/NEt8gRDDAZp7dOjD/4On6zw=; 
	b=HIvbi4vkfxLc7vIm1tnPzdvsNs306ER5vwg2S148SID/lAeHvRIuW9EiDmgdkbbxEbFDff4hhhA
	hPEEwrpXH3qqp6hU+n6uFjpR9TKQy9CiQqe8QzqLJBSx3c2jECDKhklmURv8I+V5HmKvKzvctZbII
	5XE32vlaEQ5uaOREvIy2KBnvSsvvwBZkdUXmTOaX3cVxQAqijKsTAXShyIgYYbyJddalUyYAMxyRQ
	OR3izP/b166mcYXKOhwhLNA7WH+Gzd1gDtQ2pklC5sIFxKmOhaMsbczEY3pKMcfrjtiwZ8wy+bJgW
	SptALvrenmInFWmZ7Pd9KxI2sZ88pBY+cmkg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wXbAv-00000004XcN-1VyX;
	Thu, 11 Jun 2026 16:54:10 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 11 Jun 2026 16:54:09 +0800
Date: Thu, 11 Jun 2026 16:54:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Felix Gu <ustc.gu@gmail.com>
Cc: George Cherian <gcherian@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Daney <david.daney@cavium.com>,
	George Cherian <george.cherian@cavium.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: cavium/cpt - fix DMA cleanup using wrong loop
 index
Message-ID: <aip3sczoMrtq7qOf@gondor.apana.org.au>
References: <20260602-cptvf-v1-1-d68e58e59173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-cptvf-v1-1-d68e58e59173@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-25074-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ustc.gu@gmail.com,m:gcherian@marvell.com,m:davem@davemloft.net,m:david.daney@cavium.com,m:george.cherian@cavium.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ustcgu@gmail.com,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,apana.org.au:url,apana.org.au:email,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2A786701A6

On Tue, Jun 02, 2026 at 10:55:35PM +0800, Felix Gu wrote:
> The sg_cleanup error path used list[i] instead of list[j] when unmapping
> DMA buffers, leaking successfully mapped entries and repeatedly unmapping
> the failed one.
> 
> Fixes: c694b233295b ("crypto: cavium - Add the Virtual Function driver for CPT")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>  drivers/crypto/cavium/cpt/cptvf_reqmanager.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


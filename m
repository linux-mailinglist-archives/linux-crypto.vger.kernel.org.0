Return-Path: <linux-crypto+bounces-25892-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hbKdLT9fVGr1lAMAu9opvQ
	(envelope-from <linux-crypto+bounces-25892-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 05:45:03 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 062E4746FC6
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 05:45:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b="l//rRRH1";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25892-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25892-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BE3D300AB28
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 03:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE0C33A00C;
	Mon, 13 Jul 2026 03:44:58 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CD72116F4;
	Mon, 13 Jul 2026 03:44:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783914298; cv=none; b=JV3foBFEkBsp4a7v2q5K1HOe7qHds0yhDiitNw+DYc43oaFvoHDkLYM1W6yiCrr0NcNORct4ByHoBIr/b8996cKaF7fA5y+XRNg+nrqkB+MZKl/LALhQctwp37KyEGhkUXhv30xbcVncvqM44tjek90tSmWvqzo0zckY/d1iOKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783914298; c=relaxed/simple;
	bh=r8sfdbqN1zs6K8NiXsx1BVuNZ9M2YhYO4Ctgpt76Edw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDRxFOO27bRHI8rD3i/i1Rg7ozufg8S5uhQoYtozHV3kIeBRqru8mCpRnn8QMOcAMIURQGDD4A4h6NngI/dxGBAiecfArtZgK5IpX0cb4XcheDnFzSoT+YduDwgGmKVjqcLdoW6rwZuQ1O51Vs1TFqkxU1X/mZpItzr4F6OqABY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=l//rRRH1; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=RREQle099gdxdz7gtCoh4ys0y9zML3oLj26BLgi/8GE=; 
	b=l//rRRH1MwZXJiVab728G6psnKp8my4yzdw2/SuqSldp8ojJWtpcuhpnDRxZ+sELPkfaaL35CSJ
	CGslQQUJygsEP47uRZ6iFY8p1jvBGnOKGsf54VoaD6/HhI6I6DPWZJh6LVhnTF26xcJYnbuniZjmE
	hVw3IkJdV2uQeIhRLq97EFB3FdviM+9lJIMk18nRNotBCOqlfcnCsvo6GcP8bbU6ZHBuIO+KwuHGG
	Z2KqxHgRdJq3PVwh8RWEY+0IRUs6/+8jnj29YX76zIHBBixOpWQXG1w1OfL4HfS+di15P1e0l80HI
	zmQxCbof8LCLLvRA9IfWCVEoSs8TIhRMyAWA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wj7b9-0000000CyH7-3rWD;
	Mon, 13 Jul 2026 11:44:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 13 Jul 2026 13:44:51 +1000
Date: Mon, 13 Jul 2026 13:44:51 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Yuho Choi <dbgh9129@gmail.com>
Cc: Olivia Mackall <olivia@selenic.com>,
	Alexander Sverdlin <alex@sverdlin.org>, Nishanth Menon <nm@ti.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] hwrng: ks-sa: Fix runtime PM cleanup on registration
 failure
Message-ID: <alRfM-Ygtmk1UNa2@gondor.apana.org.au>
References: <20260702233921.100478-1-dbgh9129@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702233921.100478-1-dbgh9129@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25892-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dbgh9129@gmail.com,m:olivia@selenic.com,m:alex@sverdlin.org,m:nm@ti.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:url,apana.org.au:email,vger.kernel.org:from_smtp,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,gondor.apana.org.au:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 062E4746FC6

On Thu, Jul 02, 2026 at 07:39:21PM -0400, Yuho Choi wrote:
> ks_sa_rng_probe() enables runtime PM and resumes the device before
> registering the hwrng. If devm_hwrng_register() fails, probe returns
> without dropping the runtime PM usage count or disabling runtime PM.
> 
> Unwind the runtime PM state on the registration failure path, matching
> the cleanup done by remove().
> 
> Fixes: e9009fb227fa ("hwrng: ks-sa - Use pm_runtime_resume_and_get() to replace open coding")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> ---
>  drivers/char/hw_random/ks-sa-rng.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


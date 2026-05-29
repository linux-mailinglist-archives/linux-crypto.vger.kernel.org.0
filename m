Return-Path: <linux-crypto+bounces-24707-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHKMGp07GWpVtAgAu9opvQ
	(envelope-from <linux-crypto+bounces-24707-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 29 May 2026 09:09:17 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E52AF5FE582
	for <lists+linux-crypto@lfdr.de>; Fri, 29 May 2026 09:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A12DE310F30C
	for <lists+linux-crypto@lfdr.de>; Fri, 29 May 2026 07:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F173AEF3B;
	Fri, 29 May 2026 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XnwYGh/o"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9FF3AE713
	for <linux-crypto@vger.kernel.org>; Fri, 29 May 2026 07:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780038337; cv=none; b=IkOwU3hHnDztyaBUfmtTw2Jt7bnyD5fsEPpasg6NHElmOXtqCoNvCvcPncogHnteMc8KO5Wjs7pcrC1O6sgCZt/8vGfpYaz/2T5prNPpgwgbU6R5iudvVEZfzSmZTpinSVz/V74O5GcvzVzY0mZgp4IeBhq7aPlUBspwcIVlwLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780038337; c=relaxed/simple;
	bh=yS1XlYDjTMgxwgN2DZGzDYeL5SarwMcWqXtVsPpG4iU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=qlHkB9Drdb7+7lRuLsdzSpqr7fYncwQpT3xqj76QYNoZiyVXgdgnC2rTjKrEfcpAFHY/LmxFq7NFHHW6GWC3LTxpyJRY8z2A++IoFvCxcFwXzlbFRnKkS0IVUU0mEVBRiByGwzmw14Z0OK79WD2MNCNSx82crp8MmPFzaKh8zmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XnwYGh/o; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780038331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1/AzmjwYbvz5ac6FUFa2AXbd/guUDNm7WSGUACd+fE=;
	b=XnwYGh/o1rfZsynwCJXEx2rjmGjHm/owl7jHyuy0Vc0OrpofbU7dzYUkbSlAaUFJjPR4/p
	xQPqAlKZN1UOhyKM3lEBNMxrtajO6d7x/ot20UyfuhDIhBX6uwlSjN5ReQvSMwk4DDxicw
	KOVYDCuWjg7i/lyFRKx5guKlq+7jKBU=
Date: Fri, 29 May 2026 07:05:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Tianchu Chen" <tianchu.chen@linux.dev>
Message-ID: <554bc5c03d16e7a76db35be4a1c0d23cda2d4df6@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] crypto: sun4i-ss: restrict PRNG seed length to prevent
 heap overflow
To: "Herbert Xu" <herbert@gondor.apana.org.au>
Cc: clabbe.montjoie@gmail.com, davem@davemloft.net, wens@kernel.org,
 jernej.skrabec@gmail.com, samuel@sholland.org,
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <ahkuI-Z2w0sea_ba@gondor.apana.org.au>
References: <af749a8447bd7f0e9dd26ca6c87e9c6afecb09d9@linux.dev>
 <ahkuI-Z2w0sea_ba@gondor.apana.org.au>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,sholland.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-24707-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tianchu.chen@linux.dev,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E52AF5FE582
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

May 29, 2026 at 2:11 PM, "Herbert Xu" <herbert@gondor.apana.org.au mailto=
:herbert@gondor.apana.org.au?to=3D%22Herbert%20Xu%22%20%3Cherbert%40gondo=
r.apana.org.au%3E > wrote:


>=20
>=20On Thu, May 28, 2026 at 02:53:17PM +0000, Tianchu Chen wrote:
>=20
>=20>=20
>=20> diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-prng.c b/dr=
ivers/crypto/allwinner/sun4i-ss/sun4i-ss-prng.c
> >  index 491fcb7b8..010fa891c 100644
> >  --- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-prng.c
> >  +++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-prng.c
> >  @@ -8,6 +8,8 @@ int sun4i_ss_prng_seed(struct crypto_rng *tfm, const=
 u8 *seed,
> >  struct rng_alg *alg =3D crypto_rng_alg(tfm);
> >=20=20
>=20>  algt =3D container_of(alg, struct sun4i_ss_alg_template, alg.rng);
> >  + if (slen > sizeof(algt->ss->seed))
> >  + return -EINVAL;
> >=20
>=20This should simply ignore the extra data instead of failing.


Thanks for pointing out, silent truncation is more appropriate here.=20

I'll=20send a v2 patch with min_t soon.

Best regards,
Tianchu Chen


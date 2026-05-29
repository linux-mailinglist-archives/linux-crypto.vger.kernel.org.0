Return-Path: <linux-crypto+bounces-24725-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FbpEhHWGWqjzQgAu9opvQ
	(envelope-from <linux-crypto+bounces-24725-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 29 May 2026 20:08:17 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E71056070ED
	for <lists+linux-crypto@lfdr.de>; Fri, 29 May 2026 20:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1755D305331D
	for <lists+linux-crypto@lfdr.de>; Fri, 29 May 2026 17:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24507386C20;
	Fri, 29 May 2026 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3bIEa3d"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BD9384CFD;
	Fri, 29 May 2026 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076024; cv=none; b=a9B2biMoFKfFliRMg/k4E71bBtA4Z/0/Kzu27GLdy+4ALu7JZU5yrEcQ7eSR0jGccM9C4BWCA3Qeqkj6ml7vxM8pT5QPbTnWJT/9Um95tnaJJt0GvhjkFXNc/h2He0ZhjMot4HV0S9MoMrkuwBy9FvDtJMYvvpj+7bxu9um++D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076024; c=relaxed/simple;
	bh=KRRxdza7dhy6bb7auU0Zq6MtMt79Qeh3lUIwL0gFeyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GX1hHS+/zT5nQEnhhbBE5+WuyOwOndSXKTfyKZcGqlmLBY5/7O218Y3kEN6O1TQ/0N/QZgmpGMz0O6CGp0q722MJz6ixIzeHToALZdq8jkuVaOTazZDcKNdANIFgwKfvuqsreGjt5jmkZclFpa7GUQ8YNx2W2LL1IbcXQbhFGzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3bIEa3d; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FFE1F00893;
	Fri, 29 May 2026 17:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780076023;
	bh=09m9/dI4VNwurVTMTiHelmZjlbvOjlIIZGnjwo6EtJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a3bIEa3dzzWq8vYKccqH6FC5FopQed8OyCxJh0qxo3GGXZwcRjp9qF6xvVlZ4XKGD
	 LloeYeZ85DPU+4zd/zR0is/oOAVth8w041SNpSRHLSp+i/QUdycJ63P5jCFwMiScLf
	 Tji3ol9I6UJ0h8Qp6eLmvs0fLzqwcmo1lm96n7kLcV7O1WdF81457H3I1w6v13O2gd
	 ALIQpTnd89O+azhHEb5hnlcW9DBcjkN+dPLzTlIpKHVCT4pJYg4hVltN9INK2sQ6Zy
	 q5eePjwbA3q57T4FWo9d34VP8Y7JyWMwAYufntZRyM2TADWD5CKsu83DhycWMU6C7l
	 QSmf+iCNOnlcw==
Date: Fri, 29 May 2026 17:33:41 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: Tianchu Chen <tianchu.chen@linux.dev>, herbert@gondor.apana.org.au,
	davem@davemloft.net, wens@kernel.org, jernej.skrabec@gmail.com,
	samuel@sholland.org, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crypto: sun4i-ss - clamp PRNG seed length to prevent
 heap overflow
Message-ID: <20260529173341.GA566433@google.com>
References: <af749a8447bd7f0e9dd26ca6c87e9c6afecb09d9@linux.dev>
 <4d4407c05835a50413fa1e974e3aa3f4abfe2d5b@linux.dev>
 <20260529161057.GA2706@sol>
 <ahnIbpBLyn5z_siT@Red>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahnIbpBLyn5z_siT@Red>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24725-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.dev,gondor.apana.org.au,davemloft.net,kernel.org,gmail.com,sholland.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tencent.com:email]
X-Rspamd-Queue-Id: E71056070ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 07:10:06PM +0200, Corentin Labbe wrote:
> Le Fri, May 29, 2026 at 09:10:57AM -0700, Eric Biggers a écrit :
> > On Fri, May 29, 2026 at 08:08:01AM +0000, Tianchu Chen wrote:
> > > From: Tianchu Chen <flynnnchen@tencent.com>
> > > 
> > > sun4i_ss_prng_seed() copies the user-supplied seed into ss->seed
> > > using the user-provided length with no bounds check. The crypto core
> > > does not enforce slen <= seedsize before calling into the driver, so a
> > > userspace caller via AF_ALG setsockopt(ALG_SET_KEY) can pass up to
> > > sysctl_optmem_max bytes, overflowing the fixed-size buffer and
> > > corrupting adjacent heap memory.
> > > 
> > > Clamp the copy length to the buffer size, matching the approach used by
> > > loongson-rng for oversized seeds.
> > > 
> > > Discovered by Atuin - Automated Vulnerability Discovery Engine.
> > > 
> > > Fixes: 6298e948215f ("crypto: sunxi-ss - Add Allwinner Security System crypto accelerator")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Tianchu Chen <flynnnchen@tencent.com>
> > > ---
> > > v2: Silently clamp oversized seeds with min_t instead of returning
> > >     -EINVAL (Herbert Xu).
> > 
> > sun4i-ss-prng.c is useless, is still broken, and should just be deleted.
> 
> Hello
> 
> useless ? clearly no, it helped a lot on devices where it is.

The only way this code is reachable is via "rng" algorithm type in
AF_ALG, which is almost never used.  Everyone just uses the regular
Linux RNG (/dev/random etc) instead, as they should.

In fact, anyone were to accidentally use this it would be a security
vulnerability, seeing as sun4i_ss_prng_generate() doesn't actually fill
in all the bytes that were requested.  It also doesn't wait for the FIFO
to be ready when reading data from it.

Is it possible that there's a misunderstanding here and you think this
provides entropy to the regular Linux RNG?  It doesn't.  hwrng does
that, crypto_rng does not.

The correct fix is to mark CRYPTO_DEV_SUN8I_CE_PRNG as BROKEN or remove
it entirely.  Doing otherwise is not responsible.

- Eric


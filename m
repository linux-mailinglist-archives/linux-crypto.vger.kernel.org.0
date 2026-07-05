Return-Path: <linux-crypto+bounces-25585-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZmyGFEzsSWpA8gAAu9opvQ
	(envelope-from <linux-crypto+bounces-25585-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 05 Jul 2026 07:31:56 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D44709061
	for <lists+linux-crypto@lfdr.de>; Sun, 05 Jul 2026 07:31:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b="Xa/aBT/0";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25585-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25585-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67226300CCAC
	for <lists+linux-crypto@lfdr.de>; Sun,  5 Jul 2026 05:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F398E22541C;
	Sun,  5 Jul 2026 05:31:50 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75D812B94;
	Sun,  5 Jul 2026 05:31:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783229510; cv=none; b=Wh/8i75CrDWwryupTq0OwPuhus12eo0w1deebxJwP7wXOwZgnFb6W48yFiZ2liCrGN6FsPBpCLRxWIcxxSc/KJ/gQ/rJ9lxFDioJOqzmMJS7mBJiLEo9Ssa4rCKPvz7K1oV0VtrwPs0XWfgkPQVud96TZLuh8stwDJrH96Zw4Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783229510; c=relaxed/simple;
	bh=E7nUGitEE/r0cDHqzqXKRyc7GCK5lG/uilNvbwAxGTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=by+zRurhu7m+fHDNmRfiFFYK+PxlDjZTVhuCRo4e/Gcdh5TOjYQYpXu1OMWXUsnH3BRj5yOTL1jVjg65li6zicoqd9h6YePztk/6msrg6gDaYe0jHhnMfjMb3Ck0St28vwp8Mu17GOVMp3ACS8KW9u1m7+ktbY20zvzfaqykvwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=Xa/aBT/0; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=ocYHhDBt0KElBTDMdzYyH7sibDgLVdUqmfT8KH4XuQI=; 
	b=Xa/aBT/0H8hKLRYlnrUAzv2merApOTWuebA0BQtcLu/QSJHNYEvsXtoZRm0sp8/UGXIb/ZO8Ckw
	JjPufEx+V2QStez4icDFgq2RFOXIXGHjCxt6vYtony8gShZqmgEhcPJu/cbODf0mLKmROLaNd3XMU
	2Jeg/niFMEY/8YvItxhsN69uuJYMJH72t84ColZNVBQYwazphXHPwi7CYjI08VMtaMR/neqsZ496W
	wRNVcyqstMbNUMOcuXBcmI3sbREYGNvpRHwg9hSEuRfewt8MnKnn/H7+5lk3fcKnyzdH0+3Bll6d+
	Vh9DXSCqJtPWDOa/lsQU+kDGKa5Akeh9YMOg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wgFS3-0000000Ajbg-1r9H;
	Sun, 05 Jul 2026 13:31:36 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 05 Jul 2026 13:31:35 +0800
Date: Sun, 5 Jul 2026 13:31:35 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Manos Pitsidianakis <manos@pitsidianak.is>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hw_random/core: fix rng list on registration error
Message-ID: <aknsN0PT1rarFbWd@gondor.apana.org.au>
References: <20260605-hw_random_registration_rng_list-v2-1-d98b8ccbe16e@pitsidianak.is>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605-hw_random_registration_rng_list-v2-1-d98b8ccbe16e@pitsidianak.is>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25585-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:manos@pitsidianak.is,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:url,apana.org.au:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 96D44709061

On Fri, Jun 05, 2026 at 02:23:51PM +0300, Manos Pitsidianakis wrote:
> hwrng_register(rng) does the following:
> 
> 1. Checks if rng has name and read methods set
> 2. Checks if the name already exists
> 3. Adds rng to global rng_list
> 4. May try to set rng to current_rng
> 
> If step 4 fails, it returns an error. However, it does not remove the
> rng from rng_list, causing a dangling reference which can result in
> use-after-free if the caller frees rng, since registration failed.
> 
> Add a list_del_init() cleanup step.
> 
> Fixes: 2bbb6983887f ("hwrng: use rng source with best quality")
> Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
> ---
> Changes in v2:
> - Add Fixes: trailer
> - Link to v1: https://lore.kernel.org/r/20260525-hw_random_registration_rng_list-v1-1-ee1c215d544d@pitsidianak.is
> ---
>  drivers/char/hw_random/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


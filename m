Return-Path: <linux-crypto+bounces-21285-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGPZBptnomlA2wQAu9opvQ
	(envelope-from <linux-crypto+bounces-21285-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 28 Feb 2026 04:57:15 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F4E1C039D
	for <lists+linux-crypto@lfdr.de>; Sat, 28 Feb 2026 04:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FC723046EA1
	for <lists+linux-crypto@lfdr.de>; Sat, 28 Feb 2026 03:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163B5307AF2;
	Sat, 28 Feb 2026 03:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="JeM4WsT3"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B00C21507F;
	Sat, 28 Feb 2026 03:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772251022; cv=none; b=VdgenTF/Iye4FS6emlbMrBBRZVLm8JCTGtS5gAdbc0L2OQAdzyrP1fLhYQ5VDuSmkZ4CUYIsskP5np6HocWD4kI6UM0+v2SSLVrIFTdkSXEwlFWX0I9K660Iy6ipHCFT6zb6OnFHK0T0PjXZLFeO0HcAvCRJVFOs0ZMaRiC1CKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772251022; c=relaxed/simple;
	bh=kpdvnsrplsaoW/LBNAp0MldZofcWFVJvmTvIIq0ZZNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q63DvFgWphPqIZ8VO5KB0DCC2Wc2J6R71rO4Jb6fk/Nid02ENb04OtCB8evZxeQ5f2la1bok5y9l9kbDjhqNfyGlxz79LKNFFak+tC2d/AjeFUveWRvvmd0oNFhWTOL5eTmvK/87Gvqb+ZnKH2h3KVerECRW6ipc/pinwt4nxEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=JeM4WsT3; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=O0xbxFowrILMl0xjkBlcfsGGIBPWbn8Nu8QCTIieKDk=; 
	b=JeM4WsT31PdP4pvGjAQOA1h8qq8aiNEx+G14y1vsibBU2rHY99Mk/G+tj/vQMr3n+iZRXSSknWl
	NJX+hMZuBQO8fA7/tA8KhsYRpHyaDOf7wYyC8g67Ey36uLQNg8Q6g2NNT1/SdnrK1Xs1DI6cG7Pee
	CfQrS02c6ch0rjvOdJ5jjXfax9oFCvcL+DT64pXVmFxw4UakcZII8QrTnGYffK6V3+jZ9U4Hxomue
	GNFwEvhNW0txgmo0CS2FSbf8m3gEfnxEBFG7rxWn+yF8Nhmak41tOEPE2P2uJefRIi/OOYDqmnN4c
	k51VJV7hH0K08ZAfkYj4i7w5kIByiOwqNf5A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vwAso-00ABPm-0y;
	Sat, 28 Feb 2026 11:20:47 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 28 Feb 2026 12:20:46 +0900
Date: Sat, 28 Feb 2026 12:20:46 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Subject: Re: [PATCH] crypto: drbg - convert to guard(mutex)
Message-ID: <aaJfDsCLKfy34dSP@gondor.apana.org.au>
References: <20260207232925.80976-1-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207232925.80976-1-rajveer.chaudhari.linux@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21285-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gondor.apana.org.au:mid,gondor.apana.org.au:dkim,apana.org.au:url,apana.org.au:email]
X-Rspamd-Queue-Id: 82F4E1C039D
X-Rspamd-Action: no action

On Sun, Feb 08, 2026 at 04:59:25AM +0530, Rajveer Chaudhari wrote:
> Replaced old manual mutex locking/unlocking with
> new safe guard(mutex) in drbg_instantiate().
> This ensures mutex gets unlocked on every return and prevents deadlocks.
> 
> Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
> ---
>  crypto/drbg.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/crypto/drbg.c b/crypto/drbg.c
> index 1d433dae9955..d52a7bd07322 100644
> --- a/crypto/drbg.c
> +++ b/crypto/drbg.c
> @@ -103,6 +103,7 @@
>  #include <linux/kernel.h>
>  #include <linux/jiffies.h>
>  #include <linux/string_choices.h>
> +#include <linux/cleanup.h>

Please keep the headers sorted alphabetically.

>  free_everything:
> -	mutex_unlock(&drbg->drbg_mutex);
>  	drbg_uninstantiate(drbg);
>  	return ret;

This is a subtle change and now drbg_uninstantiate will be called
within the critical section.  Are you sure this is safe?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


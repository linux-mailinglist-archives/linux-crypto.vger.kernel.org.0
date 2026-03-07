Return-Path: <linux-crypto+bounces-21692-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NPYJVy5q2n7fwEAu9opvQ
	(envelope-from <linux-crypto+bounces-21692-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 07 Mar 2026 06:36:28 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA8722A4EF
	for <lists+linux-crypto@lfdr.de>; Sat, 07 Mar 2026 06:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D189301073B
	for <lists+linux-crypto@lfdr.de>; Sat,  7 Mar 2026 05:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FE330BBBC;
	Sat,  7 Mar 2026 05:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="B6KoEVns"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580613368B0;
	Sat,  7 Mar 2026 05:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772861781; cv=none; b=qXDmOLLVI7sPK3EnpYgXB0aSIrWMmuPzk/vDhKEtG7ACprHSBXrUl76E0F4eRHtovjfFoKMlhzz0peRmRA5lhhNLfIvqY7e3lo84+tt4JNmEULEJXujscss8KZFLdL3Z82wA2Me7EWa9KYeYPd7PHzAPn1SgCqej5v27jpko6Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772861781; c=relaxed/simple;
	bh=VQ5zPYOBI/rwIQoo2vVHUqldVHGjoJ7CmG6UM2WQIQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMX1PCeZ98VjI390Q5oE5hehKP5ltcFtxDATsKE0OzwbVZAHDZ4KQKLczLK0IV4H/F3b+t0Ox0Y92B0PLBRQ+pb36rNq3odcWLB+4/hlsfFmrU41g1YJAYeQa05pZqKqPIXqudABw3696NGKWabQNZB0WaDB4EAaMhX4P4jfKA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=B6KoEVns; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=ne7KG7Ae/T1QzwvnrcsHo0sjk1sY0y8RIuqRaAf1Vck=; 
	b=B6KoEVnsvHNiR7w6X2DT26H+fZUrx/3J0PBVcLLqXRY0K3skUtFRGAtiYfQ5GwHy7xm11qDKdeP
	ihOGDYvUoLVz/ULD78/j4Qt4N39LMwvxrQnLRVitFlN3JQuWfxHu5z89CtVwfytELUp0domez0fMN
	TBfR9JzJqPln6nf8+huL02Ri/ZCj46haaYKU3HNIjcwqQSe2gcU+1zau/gG0PiaxoyEdlppwjjUCL
	8xED05Uj8x8pHPHHAb522gcbOHBdVh6kGg6YpFBf5wmbFHNFdsrqFF1Q6xHBwTRIWhlUwZE7BnlsV
	MXmHlOYf3eKH86oZXhJNCQPBFZ3y9LONAPTw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vykKX-00CJeG-0V;
	Sat, 07 Mar 2026 13:36:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 07 Mar 2026 14:36:01 +0900
Date: Sat, 7 Mar 2026 14:36:01 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Alexander Dahl <ada@thorsis.com>
Cc: linux-doc@vger.kernel.org, Stephan Mueller <smueller@chronox.de>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs: crypto: userspace-if: Fix outdated links
Message-ID: <aau5QS7oIUx0ntvw@gondor.apana.org.au>
References: <20260226155627.3243344-1-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226155627.3243344-1-ada@thorsis.com>
X-Rspamd-Queue-Id: 8BA8722A4EF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21692-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.951];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:url,apana.org.au:email,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 04:56:27PM +0100, Alexander Dahl wrote:
> According to archive.org the site threw HTTP errors 404 since early 2024.
> The last snapshot in the archive having actual content was from late 2023.
> The page behind the new URL has more or less the same content as the
> archived page from 2023, so it probably was just moved without setting
> up a redirect.
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>  Documentation/crypto/userspace-if.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


Return-Path: <linux-crypto+bounces-20289-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHd4CkINc2ncrwAAu9opvQ
	(envelope-from <linux-crypto+bounces-20289-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Jan 2026 06:55:14 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9524B7098F
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Jan 2026 06:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 330873017241
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Jan 2026 05:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848EA39F332;
	Fri, 23 Jan 2026 05:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="CPKvfaJW"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6336439CEDF;
	Fri, 23 Jan 2026 05:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769147707; cv=none; b=AKCSEOQtkdh5BjvATfpOhW/C0BiuC3w7E+R5Omjyw46GxM1Et0Od6Qw1LIqJWeivIFToBT4zuRREqbTVyRP83Yrw99xOWY5ezSKaiQVRzcZh+C098A6Ws92+Rh45VfOZwjIJ/ZfEZ7SgRhaXlDAx5KVBLCkdN7kuJ8kphltkNL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769147707; c=relaxed/simple;
	bh=FZ94ySsXikXbZRT2P9ePbXU5/dPQsfauHcekVaBYxss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGnFw3evYzS30oO9FAMmi4HRZqkVI3oHoxVXexsS5HB1SKU51rK3vYk3e6l95V2ltxYpJbU+lFKG2Gj7tOX6GXvVWa8CJS4Fc/1DiC/+c3sthgJro/RQr+DwEI/9mYEXlCtUtTcdqpxOBBRIytFJrVMZS4P6zLAMSUKvGU4xDnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=CPKvfaJW; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=RSKFV1uMDNWEub8kD3U8vQ+036rXKwQDRuMYQAt+CV8=; 
	b=CPKvfaJW+uMOEvfoIy9Op8Z2AzfRqRxOr1q+8RIhYcw6wTBOqW0fQypEr+tbDSvik8oW9sHTvog
	EvR1J0yXwkxBDqDatU4/Ne4iGGaQX3oCZ6sSsib6N4wkuJp/pXWCzYWvUWiwWoo4TnRLDn4HWB/bX
	nDFr+OasQMd1NyTlqx+Z6NAdaOpRncMmaTrioAtyXckB7OJB2JDQ+UmcTmMyRaQryve4nSP4i59M1
	mXF3ydYu13XvANANXv+upDmIVW5KfhcrzjE6kppZVBd+lG+rXI0ATdfB5Oa52CcD+WOe02VZjdrbW
	JbU1wSBsl63FnfwxIKhHijO4ub90qLcI/Sjw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vjA7w-001VLs-1H;
	Fri, 23 Jan 2026 13:54:37 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 23 Jan 2026 13:54:36 +0800
Date: Fri, 23 Jan 2026 13:54:36 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Neil Horman <nhorman@tuxdriver.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto - remove unnecessary forward declarations
Message-ID: <aXMNHPgDJqlBDwdZ@gondor.apana.org.au>
References: <20251222104457.635513-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222104457.635513-1-thorsten.blum@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20289-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 9524B7098F
X-Rspamd-Action: no action

On Mon, Dec 22, 2025 at 11:44:55AM +0100, Thorsten Blum wrote:
> Add the __maybe_unused attribute to the function definitions and remove
> the now-unnecessary forward declarations.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  crypto/acompress.c | 6 ++----
>  crypto/aead.c      | 5 ++---
>  crypto/ahash.c     | 5 ++---
>  crypto/akcipher.c  | 6 ++----
>  crypto/kpp.c       | 6 ++----
>  crypto/rng.c       | 5 ++---
>  crypto/shash.c     | 5 ++---
>  crypto/skcipher.c  | 5 ++---
>  8 files changed, 16 insertions(+), 27 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


Return-Path: <linux-crypto+bounces-22935-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJbnGsoO2Wl+lggAu9opvQ
	(envelope-from <linux-crypto+bounces-22935-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Apr 2026 16:52:58 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 463333D8D03
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Apr 2026 16:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18A5F3012BD6
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Apr 2026 14:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E60393DE9;
	Fri, 10 Apr 2026 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="DGnksAlX"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042BF1DD877;
	Fri, 10 Apr 2026 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775832767; cv=none; b=Zp5sLxWCSnGG4e60ijbK/MLz+ZzbwgYmbK+Tti3AMtKddu/QR5ufRhB6WGONxlsMHMiZbv6Ot0gCnFLiTWO1UY1DZNnRCyvKI6gbnu48XLJ9pIfjnqrBkW7kByzRkORPi6ib2x8iKP8CVXxcCwDpZCVTq2u2MOK7dz+hpWVbYZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775832767; c=relaxed/simple;
	bh=4Y8ew7iAzGYo1xsFDDEr4uF92GPuWACkrxsTVwCawBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9HHbRqjIGEOusC0ZriC1H1rgH9uqoawK5QdaYFoiS515Sq73E3qz1GkSWQOOyjeXOqaGYH5YUFmvACcI6KkB/Zg/+ymPa4k5oV/kBFFcyRO3Mhgh60+gutjybRufNGaGi8vEzM5koaONsZYHXFuXbx55f8QKpTJ9Ct15pcCQGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=DGnksAlX; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=K8P0sXiqNKH95lwGaVsNzH2sZpDkCYRnB/vJsFTxNAw=; 
	b=DGnksAlX3poThZtBsVC+W0ED28r+NEfZoQ2FVpmexVXKhoDSI2OgPcCSUp3LuWVOwAJmRUglqIX
	kD4fhWrR8b8WUO9xg0+82MVX2aFbUmwxJjUVtUgIdrxWzrcILRFQullP2JhSOAmuaSJPQt2V6zRLZ
	VXsz3q+babRLSuSDOSxvZT8MoMXdUv05NX1AZ48W9JygZDam9XDCKzx4X1NxfFkn2TCLxZpFDMrOs
	kY//eQlAl0QOPuE0mBMXjD3YmWUvwuCFYFO0oeXn2z5ZHDlwv3kU11ZQ715ts/IkD7NC1PQVgfPVd
	+mXaDMyttOaiwfClsZwaWO3Y6X9wdwf2QSGA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wBCoH-0058BN-0m;
	Fri, 10 Apr 2026 22:52:33 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Apr 2026 22:52:32 +0800
Date: Fri, 10 Apr 2026 22:52:32 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Taeyang Lee <0wn@theori.io>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>, davem@davemloft.net,
	Brian Pak <bpak@theori.io>, Juno Im <juno@theori.io>,
	Jungwon Lim <setuid0@theori.io>, douzzer@mega.nu,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH] crypto: algif_aead - Revert to operating out-of-place
Message-ID: <adkOsK-uPRsv49Yz@gondor.apana.org.au>
References: <acOpDrnN3cVfiASk@gondor.apana.org.au>
 <CAH-2XvLZD_-CVQT0omao2+GrdQt1Loq+oo4X6q=0NUAeUk==1w@mail.gmail.com>
 <acTSfLPWDGTaGIf7@gondor.apana.org.au>
 <73ab5267-57b8-4394-9c10-4ee3bf92e444@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73ab5267-57b8-4394-9c10-4ee3bf92e444@leemhuis.info>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:?];
	TAGGED_FROM(0.00)[bounces-22935-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	R_DKIM_TEMPFAIL(0.00)[gondor.apana.org.au:s=h01];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DMARC_DNSFAIL(0.00)[apana.org.au : SPF/DKIM temp error,quarantine];
	NEURAL_HAM(-0.00)[-0.988];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,apana.org.au:email,apana.org.au:url,test.sh:url]
X-Rspamd-Queue-Id: 463333D8D03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 05:24:49PM +0200, Thorsten Leemhuis wrote:
>
> This meanwhile became a664bf3d603dc3 ("crypto: algif_aead - Revert to
> operating out-of-place") [v7.0-rc7] and according to Daniel Pouzzner
> causes a regression reported here:
> https://bugzilla.kernel.org/show_bug.cgi?id=221332
> 
> To quote: """Seeing Oopses and some kernel panics in 7.0_rc7 under
> modest load, roughly 10% of test runs.  Discovered by serendipity
> running libkcapi test.sh to test our own crypto module (libwolfssl.ko),
> then reproduced on native crypto to exclude us as the cause.

Please try these patches which are in the queue:

https://patchwork.kernel.org/project/linux-crypto/patch/adCAFOgQ0y_I7SC7@gondor.apana.org.au/
https://patchwork.kernel.org/project/linux-crypto/patch/adBbht8ERe0z-z3B@gondor.apana.org.au/

Both fix pre-existing bugs that were uncovered by the aformentioned
change and syzbot.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


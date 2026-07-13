Return-Path: <linux-crypto+bounces-25882-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FyU4LOFTVGrOkgMAu9opvQ
	(envelope-from <linux-crypto+bounces-25882-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 04:56:33 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 076D7746D0D
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 04:56:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=iMR60PEG;
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25882-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25882-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 821BD3007E20
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 02:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663E433FE02;
	Mon, 13 Jul 2026 02:56:16 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098D22D063E;
	Mon, 13 Jul 2026 02:56:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783911376; cv=none; b=FGukwPBiv0uchO+SrE9pQ5iW/YrL9pFko65GzBhK3GFHst8y6bm/81PtgL7WRyJHYV3w/JvHVp8Bkq4zezv8HJNDB3t/zedzf5e6zpb6xCt9Gzy5Mpi742bHQZCfZPZxAiJRzK6nX3HYVCQL/9HbdvMvxcROCl4jw8vW4IqNmyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783911376; c=relaxed/simple;
	bh=Q3VWxP2Aosr38s+o78mvDbTOTJjPSbzrpK8aDT7fTqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/088iotdP4cJXCSJgHJz8+/NMkOOROuUNA3OeVJCiNybrGMzuKDWHVRv983mOGnZlv5iAmz6tEnjXRHz7oV5vZ4aKBJafc6/vQf0IXCbeA2LcOJtmaG/JpNBq3WKenJnlP8KNQocyoD/rZZEi0UCA+bsmfIHyQC/8KQpUo/qtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=iMR60PEG; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=HTHF4UFEv4mimtOWDGeAgbcciT0GXjtdrHlVT3qzmBk=; 
	b=iMR60PEGodnvL5dNrFJbQIusp0RKmOj8ribL12jP5h+o0Odo7pQl1tIfFiACk4lbi1vpOkrivMA
	Rvb08q1HvJPDU1Ad4ADY4UYhrXorULumSWZQEWcwxMK8mLisNmw29yBKcxB8qVlQahnmltWv5sOlE
	moR2OTtO2pSggJH5LUo6xoUzZgjFF7cFfW4oYtfPDlv+l970KP9Z2b+E6v1eLBuY5L9H8opnRma8e
	n0fB3H9A/2Rk/aGpqXNpPkOp/EiJfnpSgd3o8LaRCe5DR/jmL4gK9xLi9Md+nmeoMEUWC528XLzBL
	IpXQXXapMTixr1WpyBjrUP4fJ5ZDC7FgOBpw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wj6pw-0000000Cxlu-07QQ;
	Mon, 13 Jul 2026 10:56:05 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 13 Jul 2026 12:56:04 +1000
Date: Mon, 13 Jul 2026 12:56:04 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Thomas Huth <thuth@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] crypto: pcrypt - Disallow nesting of the pcrypt
 wrapper
Message-ID: <alRTxL8UaKaI4qS4@gondor.apana.org.au>
References: <20260701143947.944593-1-thuth@redhat.com>
 <alRNusgXIT06hTow@gondor.apana.org.au>
 <20260713024654.GE4362@quark>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713024654.GE4362@quark>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25882-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:thuth@redhat.com,m:steffen.klassert@secunet.com,m:davem@davemloft.net,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:url,apana.org.au:email,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 076D7746D0D

On Sun, Jul 12, 2026 at 10:46:54PM -0400, Eric Biggers wrote:
>
> Could we just delete pcrypt instead of continuing to try to fix all the
> weird problems it has?  A web search for pcrypt just finds CVEs and
> advice not to use it, e.g.
> https://github.com/libreswan/libreswan/wiki/Internals:-Cryptographic-Acceleration#obsoleted-ipsec-accelerations
> 
> What is the rationale for keeping it?  Who cares about it, other than
> people looking for vulnerabilities?

I wouldn't object.  Last time I tried it the start-up time was
about 20,000 cycles, which is just pointless these days.

Please send a patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


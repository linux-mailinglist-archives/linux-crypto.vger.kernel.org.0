Return-Path: <linux-crypto+bounces-25196-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4aUnCtTWMGp1XwUAu9opvQ
	(envelope-from <linux-crypto+bounces-25196-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 16 Jun 2026 06:53:40 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 123DB68BF6B
	for <lists+linux-crypto@lfdr.de>; Tue, 16 Jun 2026 06:53:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=VmPsuxtx;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25196-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25196-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 727E33036D4D
	for <lists+linux-crypto@lfdr.de>; Tue, 16 Jun 2026 04:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE8C3C9889;
	Tue, 16 Jun 2026 04:53:35 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099933C6A29;
	Tue, 16 Jun 2026 04:53:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781585615; cv=none; b=BJH8xwBJ74N/IR0NkIZGxh36m5+ZCD7F9WvbG2XeoOB6OpvA1Ds1OpQ8sbXn8Q3Rv+exxxDri/Qvo7V24yEgVZMnr+AHOgjZ3J44+h1d15jQVmYPXnMrst2xlu6eVXJfxF1q/ZPlVxQbfcwOJ5kE1DNVeF/EUh69xPbDVdbZ7iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781585615; c=relaxed/simple;
	bh=se6JjSFqEhcNOcO5yXaTc4lQy0fzqgSqIPAWH1BewYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYI/t68vaNZVExiC2KgznbAOtRWsSotzGc7F87wtHMs75dikgcVr24AuEs6W2GuG3ij1JkD+klwigxTBGL0sKYyyth0fzy5eHMmz6w/1IHlpi9jVShiMMfYDjlaq9RBT7OhHZv8DcCK5FXuDTVQORgPc9YmcA8mWVt0iC86wJ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=VmPsuxtx; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=Drc4fXjipljDF28wMil4aX3O9W2wJZel/OFv8NyFnHk=; 
	b=VmPsuxtx+9Bg8KvHv/jo8rkDWN8e5B9NelDNvldK4sqHaOvY7kBjn36NTuRuakXklslItoeNIyQ
	fUZb+fhu5jE/C/xc3lCQRbcky3ffEu0x2YWR6HZ4x0rxGzNAxu2ixPJfO+tUnrmxhjdgGPrT/CFdD
	LJrE9e6041bBLhJJQvvfTl7J39KdXI7b/uQq33PoG5c3ykJyCZXB4mpmmsoR5f663smt0pjDLd8i2
	SVHerGdf2znKxnYpToC+S9XgVzsmP5YVUgIcwUAKd8gKXUpcWOhgEzyxKkyOF80LZozXIxvz2AfRV
	2vF540NGMOhUUH1MRjZO53OHeloOumdSGr2w==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wZLng-00000005lJC-0YMs;
	Tue, 16 Jun 2026 12:53:25 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 16 Jun 2026 12:53:23 +0800
Date: Tue, 16 Jun 2026 12:53:23 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Leonid Ravich <lravich@amazon.com>, Alasdair Kergon <agk@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Horia Geanta <horia.geanta@nxp.com>,
	Gilad Ben-Yossef <gilad@benyossef.com>,
	linux-crypto@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v4 0/3] crypto: skcipher - per-request multi-data-unit
 batching
Message-ID: <ajDWww8OgNcXs73c@gondor.apana.org.au>
References: <20260615111459.9452-1-lravich@amazon.com>
 <20260615225317.GB28589@quark>
 <ajDNT5jVGgRtiNH6@gondor.apana.org.au>
 <20260616045023.GA113934@sol>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616045023.GA113934@sol>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25196-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:lravich@amazon.com,m:agk@redhat.com,m:ardb@kernel.org,m:axboe@kernel.dk,m:horia.geanta@nxp.com,m:gilad@benyossef.com,m:linux-crypto@vger.kernel.org,m:dm-devel@lists.linux.dev,m:linux-block@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 123DB68BF6B

On Mon, Jun 15, 2026 at 09:50:23PM -0700, Eric Biggers wrote:
>
> Have you checked the code?  This patchset adds overhead in multiple
> places.  Dynamically allocating multiple scatterlists and then parsing
> them, adding a new field to skcipher_request for everyone, new checks in
> crypto_skcipher_en/decrypt for everyone, new checks to validate the data
> unit size that the caller knew was valid in the first place, etc.

No I have not :)

I'm just stating the general principle.

Of course I will not apply the patch-set until I have reviewed it
properly.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


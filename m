Return-Path: <linux-crypto+bounces-25900-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M0kJHrN0VGrmmAMAu9opvQ
	(envelope-from <linux-crypto+bounces-25900-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 07:16:35 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9360747392
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 07:16:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=r1qpNT6z;
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25900-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25900-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9711E302BA64
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 05:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542AA360ECE;
	Mon, 13 Jul 2026 05:15:29 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232493546C7;
	Mon, 13 Jul 2026 05:15:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783919729; cv=none; b=C2tkbR8v5sAXgAfgtol7BrjqY0HG6RDWXmGCuHCT1nhzKp7YbH4Tea8S+bOUZBVMUh0ZohPmLotrVFUJQ+2tQmLgY806Wb2JfIYIDjEC0AUZS0DXNzzlBGbBZBIkglI7BTWEeh3TvyXeTUO7Q6/KccpRxWgV10zju4I2wNVUb8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783919729; c=relaxed/simple;
	bh=FMwoXKgt/66LmyVRP8/Blbd2HF2YsjDyH0jX1MI6WVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUNNoh+O9lWrwGVwJX1OU7we2LwTwNe+ksmZMnn0gTzzyrmH+NZc3iVjvjnpjWx+7oKcsxUa0aQ/ssEuVQdeePj4SSc4uoS8KAAv38I2B2QEqsK8CoxfY+l7BKFd160ym7+KxilVQh7RjgypKueXcc2pt6h96v2PFSeK/c+FiXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=r1qpNT6z; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=W3A/KaKrG9kFNeF/9Jpjyh+rlFeZTpLWeLsBrxYd7/Q=; 
	b=r1qpNT6z2MeUG28TKQntSINtHBj9mHUpQDDX4jPjdk7pi+BFTFxfZMp3wDXFAraMdlHb61j8gGW
	swP8siMmTvfisEAX8FbpjcqyXeiAe8DT7DQW9hokSV1UWLfXZOlWHb5GaNZSwkCZTinhkmXv0n7pb
	1/j39LERZHHmd+Jft3fURJi7J4DDoWKrNmPLFiqtjC7OjSU+LdE6QT1tEpauo92OdM4B1FRyyX55R
	6tjEAP6hFk0aaF0A50SYwsXJgQJTEiK6niBYqGG+oigMWuozhNjwHq1mKom9MA3FGnnDNO9vNIsho
	ezAPGsKq6qJEkrykDomkyvJX4F09WLoPQo1A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wj90i-0000000CyxY-3jTC;
	Mon, 13 Jul 2026 13:15:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 13 Jul 2026 15:15:20 +1000
Date: Mon, 13 Jul 2026 15:15:20 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neil@brown.name>
Cc: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, tgraf@suug.ch,
	akpm@linux-foundation.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com, kys@microsoft.com
Subject: Re: [PATCH v3] lib/rhashtable: clear stale iter->p on table restart
Message-ID: <alR0aECzoQyjBuhY@gondor.apana.org.au>
References: <20260707164115.4979-1-blbllhy@gmail.com>
 <alMDzpDrUzdB8e0r@gondor.apana.org.au>
 <178391853109.3371781.15191213695629915459@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178391853109.3371781.15191213695629915459@noble.neil.brown.name>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suug.ch,linux-foundation.org,vger.kernel.org,microsoft.com,linux.microsoft.com];
	TAGGED_FROM(0.00)[bounces-25900-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:blbllhy@gmail.com,m:tgraf@suug.ch,m:akpm@linux-foundation.org,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:url,apana.org.au:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9360747392

On Mon, Jul 13, 2026 at 02:55:31PM +1000, NeilBrown wrote:
>
> I think that patch is good and fixes a problem that needs fixing.

Oh I get it now.  It was rhashtable_walk_next that was dereferencing
iter->p, not rhashtable_walk_start_check.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


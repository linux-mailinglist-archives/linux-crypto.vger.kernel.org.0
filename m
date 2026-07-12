Return-Path: <linux-crypto+bounces-25862-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f6cJKecDU2o1WAMAu9opvQ
	(envelope-from <linux-crypto+bounces-25862-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 12 Jul 2026 05:03:03 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 635A9743A18
	for <lists+linux-crypto@lfdr.de>; Sun, 12 Jul 2026 05:03:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=O+bt4UU8;
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25862-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25862-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E56A3004CAB
	for <lists+linux-crypto@lfdr.de>; Sun, 12 Jul 2026 03:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E745127A476;
	Sun, 12 Jul 2026 03:02:55 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F8B17C203;
	Sun, 12 Jul 2026 03:02:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783825375; cv=none; b=Hzl3nzNmv28ijWsRDmmlK+EXxEWcGF5HFYls21MKpYUkNcWOyzPrN8BnVcLTDioV/t/wBmopMm8YXNFroF7uKn3dJUFk+1E56G2xQGbcli8yeKn/6YgEu6ERow/mq8X/DtzzB/cSOgrdKOWpnBTH1ULujW9Chk+8KHJb375wAIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783825375; c=relaxed/simple;
	bh=DOR0ni7bbfAXQwbOUWpkehrUfd6sxGsr17SmA2tr3LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eg1XtGLr7i3gMFGn1CaxdjCoSg4jG3fdRQ2oKMN2F0Kj8LyM5c098TVcf5V+DhEdaqDYiB4F2ixdoCZW+/P/Ir1B6QSFeHm8mABEyoE6Oqg+PGmcFHrLe60LrhZsJTA3yVQvPx/eBNK8/Yp/5KLHxkNQNoL1BlNyNrpXj31RyRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=O+bt4UU8; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=IGjzba5R0fPfNAYmwgs2ccd2zCCepjFwAJcMABMNhjM=; 
	b=O+bt4UU8ISQOPLom94qxJjvSLJJ5wjmCwJMj3ppiJehc04bSFYIEcYHO7NpRL7nH5LbnZYcon3a
	CMg8eQV9xTwMP9YdzemuS32v+9FVaOmvXPvCbHkuA5CezNuncLheJyIq0KSHqsKYNYfJ0ba9o+8st
	aelLXzfZQhs1VXp+vn8Lan/DsCCcRlKv5eA/Hk4v5fl4pXoe4Y8rET6J39nqGG0fRTO41pqSsjQpk
	On0KCNb4g9zaQKr5HWXUeVlwRoacD6dsgtmNVDlwhEdqa818451L0zS/pHU/q9MTPjxy6YFeBlpUj
	PSYWDl4BQxSDl50j4OwFi6cxEQpg42jTpy5g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wikSk-0000000Cm3O-2wIM;
	Sun, 12 Jul 2026 11:02:39 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 12 Jul 2026 11:02:38 +0800
Date: Sun, 12 Jul 2026 11:02:38 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: tgraf@suug.ch, akpm@linux-foundation.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com, kys@microsoft.com,
	Neil Brown <neilb@suse.de>
Subject: Re: [PATCH v3] lib/rhashtable: clear stale iter->p on table restart
Message-ID: <alMDzpDrUzdB8e0r@gondor.apana.org.au>
References: <20260707164115.4979-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707164115.4979-1-blbllhy@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25862-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:blbllhy@gmail.com,m:tgraf@suug.ch,m:akpm@linux-foundation.org,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:neilb@suse.de,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,apana.org.au:url,apana.org.au:email,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,gondor.apana.org.au:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 635A9743A18

On Tue, Jul 07, 2026 at 12:41:15PM -0400, Cen Zhang (Microsoft) wrote:
> rhashtable_walk_start_check() has two restart paths when resuming a walk.
> When iter->walker.tbl is valid, it re-validates iter->p against the table
> and sets iter->p = NULL if the object is gone.  When iter->walker.tbl is
> NULL (table was freed during resize), it resets slot and skip but forgets
> to clear iter->p.
> 
> rhashtable_walk_next() then dereferences the stale iter->p, reading
> freed memory.  This is a use-after-free.

Maybe I'm misreading the original patch (in the Fixes header).  But
it seems the whole point of having it is to look for iter->p in the
new table.  Even if the hash table remains the same iter->p could have
been freed since we hold no reference to that object.

If that is the case, then resetting iter->p on a resize doesn't
fix this at all since the root cause is that iter->p is being
held with no reference.

I think we should just revert the original patch since the whole
concept doesn't seem to work (although it's salvageable for the
non-rhlist case).

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


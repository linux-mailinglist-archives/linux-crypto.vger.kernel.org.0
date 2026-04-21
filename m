Return-Path: <linux-crypto+bounces-23275-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HirC8Po5mlx1wEAu9opvQ
	(envelope-from <linux-crypto+bounces-23275-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Apr 2026 05:02:27 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB2B435A7D
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Apr 2026 05:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07F4C300D159
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Apr 2026 03:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03CF317176;
	Tue, 21 Apr 2026 03:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="GPjfwvGC"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF57311968;
	Tue, 21 Apr 2026 03:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740536; cv=none; b=UXln7Ys0QukY9zIUDGGqCNBDjpOp7opU7Av8cHf+37oWouAiWjJOlNHsvcMylmW0GGzmUke5dlyqWVja1sMumJdN6H1kAzMgX6PWH+g6HLSI5FWKJeHru+VeoYLHSlF+D3+nEcWAX11qmXKOf2UQPmvkY+CSaXevRbANnwmSvGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740536; c=relaxed/simple;
	bh=NcusopJuv4HIWTtyNT1HwnHLAGevOuHazzsa5P2nsDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmlZTgB0WRshw8XERhImcPjwhTZM8KMypfwBKIQTwb8//dbHFulMY+XPbT4+IGKcvoSKyw/J3n/9EgdriBPbzh+bcxzvyIT5pdLvGgukY6xQ/Haw2CDa18+OJzhVFGERWzxcmR8qzugPkfRCisJFuHIygh8TJrvCQJzgh+S0Htg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=GPjfwvGC; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=lqGzlhc3HOGYAUoAFGjYhElEUQ9buJDeLJujlYxnyBA=; 
	b=GPjfwvGCbzNkZuDP8fJLjGjYOSvD6VDab9VL3idJXcu1xxeTUqZMbfOM5NJfabFYuhzV+SwPkQJ
	rh6ONvVU8F9AhsUFHq6994xOHE0+pUMh7cAjFxIyJy3/YF56DDBAOy/n/uHQTiWsQeHiPAdD0oiuJ
	pNaFfmLyhAHsSUNx8sX6K1tOXXZu8YhiJzL1H+b5QZoOgNr/AZKumtseGANqV2sbJtCiquyAlXogO
	YzDHAYLtGFyVLPgOOA/i4p2aW7qh2kYwOvb6CG9VVor7y1A5qW6Jb3pJKSEZA8kQYn5xd9E+CFlhs
	OAdXSt8Xyj1c8LRdJzyxo0xay3mqvkzYyzUg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wF1NB-007b9c-0H;
	Tue, 21 Apr 2026 11:02:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 21 Apr 2026 11:02:01 +0800
Date: Tue, 21 Apr 2026 11:02:01 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Tejun Heo <tj@kernel.org>
Cc: Thomas Graf <tgraf@suug.ch>, Andrew Morton <akpm@linux-foundation.org>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rhashtable: Bounce deferred worker kick through
 irq_work
Message-ID: <aeboqS39EwdEKbuN@gondor.apana.org.au>
References: <67fedbf2-914b-44f7-9422-1fe97d833705@kernel.org>
 <aeXnak9Yl84a-kho@gondor.apana.org.au>
 <4ff731fc-3791-4b96-a997-89c3bcd2d69b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ff731fc-3791-4b96-a997-89c3bcd2d69b@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23275-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:url,apana.org.au:email,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7CB2B435A7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 08:12:58AM -1000, Tejun Heo wrote:
> Inserts past 75% load call schedule_work(&ht->run_work) to kick an
> async resize. If a caller holds a raw spinlock (e.g. an
> insecure_elasticity user), schedule_work() under that lock records
> 
>   caller_lock -> pool->lock -> pi_lock -> rq->__lock
> 
> A cycle forms if any of these locks is acquired in the reverse
> direction elsewhere. sched_ext, the only current insecure_elasticity
> user, hits this: it holds scx_sched_lock across rhashtable inserts of
> sub-schedulers, while scx_bypass() takes rq->__lock -> scx_sched_lock.
> Exercising the resize path produces:
> 
>   Chain exists of:
>     &pool->lock --> &rq->__lock --> scx_sched_lock
> 
> Route the kick unconditionally through irq_work so schedule_work() runs
> from hard IRQ context with the caller's lock no longer held.
> 
> v2: bounce unconditionally instead of gating on insecure_elasticity, as
>     suggested by Herbert.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> Herbert, any preference on how this should be routed?

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Please feel free to take this through your tree.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


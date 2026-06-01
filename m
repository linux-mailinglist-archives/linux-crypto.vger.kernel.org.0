Return-Path: <linux-crypto+bounces-24808-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AuYLDqvHWondAkAu9opvQ
	(envelope-from <linux-crypto+bounces-24808-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 01 Jun 2026 18:11:38 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3474C6225C7
	for <lists+linux-crypto@lfdr.de>; Mon, 01 Jun 2026 18:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E0FE30DDB53
	for <lists+linux-crypto@lfdr.de>; Mon,  1 Jun 2026 15:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791D33DB628;
	Mon,  1 Jun 2026 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2Z6eq++"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E3828DB46;
	Mon,  1 Jun 2026 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780329247; cv=none; b=FNwIvXaxwYz9pClmLVkFRQs9xVfzmKeNLfSrHwBSfkI3pRmYJsxwiZzCDD3xgcVef2uXCgkbTYDb+UnsISlu9tngpXzpQDpgq3RKixaZ5GAKNiiOB8vngX6ROWg4HaOzAKOKLiYRC/0gKuEn0UewfmscK3KzoTJK6/JYMC5aYVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780329247; c=relaxed/simple;
	bh=2Fomk4rMRzau1G5Xg5wV0yhwpMyHkx9k6Oc5yPSaNOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qC+gaY7peYJnLiFZ0ATPOKpFzuHEVOpqnJ7RcOUHahqE3Tc+RYL4pq5PrRQ3Hbx5Zu0dKhjNCxew5rQeXn0jLbGvFBgURmmqS0X2gxA0B32QK1fpng9fe1IRnt5g1r173kghjv3pLNvL5/Ep9mJFdWn5RxDwwETBMCVfaTUoYQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2Z6eq++; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9EB1F00898;
	Mon,  1 Jun 2026 15:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780329245;
	bh=eFK98zJBVlExZPZ7BYPDcuAkfMaYtqhrE5uX7SuoqxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b2Z6eq++QWvIC1YxNs1Ew6Po6agmLyUDGb0pdVyijseE+LFJWf4Jcm43ScTjaNq/M
	 NSVeA9ZrKi4Xo7Hvb64/jo0zR6k9r9XkStJzqGe1oWzmLcaUbIAyDdQDzLChJScbI8
	 0qqIf7ZD6VcXIhAu3hhIj18lmdUPnFfgmdQNnLafgloWR/ZvBjl/4Twuy3l56d/ksV
	 KOQ60LzUlo/sW9HGYxF5wT/K5zuPA8/Xj8V9+ehZigk+w/DvShiqRCjSkXuM0QBFiY
	 CuZmWRRkEtTisN25GtmADlxBeH1KMy6KoxO3sTSzim7h05Nh0X4QdcZUN4MJHVARo2
	 7e5YA/4o7gA8Q==
Date: Mon, 1 Jun 2026 15:54:03 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Tianchu Chen <tianchu.chen@linux.dev>
Cc: clabbe.montjoie@gmail.com, herbert@gondor.apana.org.au,
	jernej.skrabec@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev, samuel@sholland.org,
	stable@vger.kernel.org, wens@kernel.org
Subject: Re: [PATCH] crypto: sun4i-ss - Remove insecure and unused rng_alg
Message-ID: <20260601155403.GB17375@google.com>
References: <d52449abfd8e1e46c8bfe9ebdc00d931fc0e4147@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d52449abfd8e1e46c8bfe9ebdc00d931fc0e4147@linux.dev>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24808-lists,linux-crypto=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,gondor.apana.org.au,lists.infradead.org,vger.kernel.org,lists.linux.dev,sholland.org,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tencent.com:email]
X-Rspamd-Queue-Id: 3474C6225C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 09:19:23AM +0000, Tianchu Chen wrote:
> From: Tianchu Chen <flynnnchen@tencent.com>
> In-Reply-To: <20260529193648.18172-1-ebiggers@kernel.org>
> References: <20260529193648.18172-1-ebiggers@kernel.org>
> 
> On Fri, May 29, 2026 at 12:36:48PM -0700, Eric Biggers wrote:
> > Remove sun4i_ss_rng, as it is insecure and unused:
> >
> > - It has multiple vulnerabilities.  sun4i_ss_prng_seed() is missing
> >   locking and has a buffer overflow.
> 
> Thanks for cleaning this up.
> 
> For the record, the sun4i_ss_prng_seed() buffer overflow you mention here
> is the same issue we reported earlier with a targeted fix:
>   https://lore.kernel.org/linux-crypto/20260529194152.GA3628@quark/
> 
> It is an unauthenticated, unbounded memcpy() into the 24-byte ss->seed[]
> buffer, reachable from any user via AF_ALG ALG_SET_KEY with no privileges
> on affected Allwinner sun4i hardware.
> 
> Please note that this should be treated as a security fix. For the earlier
> stable releases, keeping the rng_alg but adding a proper bounds check in
> sun4i_ss_prng_seed() might still be a preferable option to consider.
> 
> Given the above, would you mind adding the following trailers to the commit
> message?  Besides crediting the discovery and report, they would also make
> this security issue easier to track and reference across the stable trees:
> 
>   Discovered by Atuin - Automated Vulnerability Discovery Engine
>   Reported-by: Tianchu Chen <flynnnchen@tencent.com>

Yes I'll add those, sorry for forgetting them.

I do think we should proceed with removal, seeing as this driver is
unused, and I found three additional vulnerabilities in it.  So four
security fixes would be needed.  But then we'd be removing the driver
anyway due to it being pointless, so it would just be busy work.

- Eric


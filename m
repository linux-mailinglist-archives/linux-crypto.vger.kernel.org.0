Return-Path: <linux-crypto+bounces-24330-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L6aMX7RDGrImQUAu9opvQ
	(envelope-from <linux-crypto+bounces-24330-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 19 May 2026 23:09:18 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DEF585009
	for <lists+linux-crypto@lfdr.de>; Tue, 19 May 2026 23:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78AB3301BC1D
	for <lists+linux-crypto@lfdr.de>; Tue, 19 May 2026 21:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF033B52F5;
	Tue, 19 May 2026 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTdKMwgu"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0C63E2ABA
	for <linux-crypto@vger.kernel.org>; Tue, 19 May 2026 21:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224837; cv=none; b=ijabXq1jKnuoW0PR5hgk2KJzv1IpQF0xsfEpbFjDeVbiGHECJYFk5xLi/e6fWOZ18I7vE2oyEbph6WSbuqzMBgsvUih31PDY235iG1CRnuMjj46GanHKGUBrxcCLgX116jawQmIGys06UTwqA8gkZ3I9gunCf7qlIAJHlnsx3ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224837; c=relaxed/simple;
	bh=U9iDPDpVT94+lCmCK0EMWw3CyWJQ1GHru/EB4+W39yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVkodssA40/6xFFT+34RkQhtPtKyf7XsHSTKPfCVaD6y7LajEaD3z72SDmT99Ja4L5IvOK3/z9abpOxUH4ZPjJZpuNyIGHz/FODGMw4GUluNduIqmxtPRBNnRzE1DsDNBTGWPg+jA29LyeZXhjXNH3OquOSQFiv1y8vk4tsU+8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTdKMwgu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB091F000E9;
	Tue, 19 May 2026 21:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779224836;
	bh=uyUQZCjeK4lCCRQ8jEnZOHnLHqRi9BJ/mOdvARIkkDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lTdKMwguFbU7LkOy+bRwZRYFLWi2uy0WhNG/yDVpRa9iKQnNd5sbJyGoY8bVMDerL
	 y+aP50rfNhJc8xKcyb9hOdKB2jBvVOs98dGw7CZ8jKGBLK9Jxal6yPuowDxZeNSs4N
	 1DKemjdpzX+Lef5acWy79SxUvCk5oXywCUw/IJrKRH4+2bZBzx7ZSRhWCVUz492vZS
	 kCPq2byolKWCAC8LvMOnUJpEEgibEZWplkEJQlsQvTrbBrR3i18jqpFGcfr//530B1
	 eJ7HH4ySli05PpNqHn0dKTupqGQDWQ0yCd6hcYp+z8TYDhdJDtlmRAqfXMIKlP3oIW
	 lRN+KvWBJQ4Nw==
Date: Tue, 19 May 2026 21:07:14 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: Demi Marie Obenour <demiobenour@gmail.com>,
	linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Which, if any, of the async crypto drivers are ever useful in
 the real world?
Message-ID: <20260519210714.GB1875993@google.com>
References: <d7084ad8-92e7-4959-8f47-c61029c2ea73@gmail.com>
 <e07dc0ab-fcc3-4525-a758-f7b4808953c8@hogyros.de>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e07dc0ab-fcc3-4525-a758-f7b4808953c8@hogyros.de>
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-24330-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,gondor.apana.org.au];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 29DEF585009
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 05:36:04AM +0900, Simon Richter wrote:
> Hi,
> 
> On 5/18/26 19:11, Demi Marie Obenour wrote:
> 
> > Is it really *always* better to do the cryptography inline or on the
> > CPU?
> 
> If there is an inline crypto engine, that is preferable, because we can
> submit a single async request and have the hardware mediate the async
> requests to the lower layers for us, reducing overhead.
> 
> The CPU is a good choice if there is some acceleration built into it (like
> AES-NI or NEON), request sizes are small, there is no batching, the CPU is
> otherwise idle and total throughput per stream is manageable with a single
> core.
> 
> That's a lot of conditions, but they happen to be fulfilled in a typical
> desktop PC use case, and usually there is no async offload option there
> anyway, so we end up on a CPU.

CPU is often preferable even when those conditions aren't met.

It's really the other way around.  There's a long list of things that
would have to go right for a standalone symmetric crypto engine to be
worthwhile.

Here are the results of some real world tests:

    - https://lore.kernel.org/linux-crypto/20250615184638.GA1480@sol/
    - https://lore.kernel.org/linux-crypto/20250616164752.GB1373@sol/
    - https://lore.kernel.org/linux-fscrypt/20250704070322.20692-1-ebiggers@kernel.org/

> fscrypt went the other direction, splitting requests from upper layers into
> individual data objects, submitting each separately and waiting for
> completion, which I can understand from a software complexity perspective,
> but it maximizes overhead for offloading.

Most kernel code that uses cryptography is synchronous.  So this is the
norm, not the exception.  Using the async callbacks is the exception,
and history has shown that it's very hard to implement correctly: it
typically results in lots of bug fixes being needed.  It's also very
common for the async drivers themselves to have bugs, so anyone
prioritizing correctness can't really use them anyway.
    
> In general, if an offload engine with an async driver exists, I would expect
> that it provides a benefit over the CPU, in the worst case it frees up a CPU
> core even if there is no significant performance difference, and it uses
> less energy than a general-purpose core would.

For standalone symmetric crypto engines, real-world tests show
otherwise.

- Eric


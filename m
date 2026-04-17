Return-Path: <linux-crypto+bounces-23089-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sk5pAp2E4WkiuQAAu9opvQ
	(envelope-from <linux-crypto+bounces-23089-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Apr 2026 02:53:49 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8E9415DD3
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Apr 2026 02:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C3553030CAA
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Apr 2026 00:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE58F1F7916;
	Fri, 17 Apr 2026 00:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnzVoyBp"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B011619995E;
	Fri, 17 Apr 2026 00:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776387222; cv=none; b=Ms5gPBCXF7lZiPFpfAKPwtUtamgjGcqwHMNpFBvr5bq3w7iT/Dxjygm+cIkBwuaA2OlxdLjDM6h9pnzYujmYjC6/sRFmfEpNtjjhkxkntnNa38wJh1yinY8+rWGlln5ZlNbWZPjcHRUK6mBlDpE5JVi2tuyTGgkUiwNxOxGIjvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776387222; c=relaxed/simple;
	bh=8rkM/jOESM4F0Kq8fM+yDFPwKlvoOf0TFX6JyDkY1y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXGH3boLJE9peg0cS7yZ7+8jyHoM5sUqwqMsis8PWTZc3L4m1VO0q7nxz/u3GDjDHb34EW/FEE/xHCUYjWQHrCl/2mrbJGYT26cUeKlbGnw7DgIzSv3SEyyEG1cp0ISIDTqflnAkNLuCKwvGKgpRP1EuEBppC7/hgfOxi978sFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnzVoyBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D23C2BCB3;
	Fri, 17 Apr 2026 00:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776387222;
	bh=8rkM/jOESM4F0Kq8fM+yDFPwKlvoOf0TFX6JyDkY1y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hnzVoyBpG/lWJiJm8qmwRA+WXZp/vpvFvdDPi9J7t8EnTQ40K1oQ5xfFrBmkTGm4m
	 oAJlNhUol6SMSkYLvADCyE+7Lb1EjfnnJHi9kuoP7GoLldgaiu3QghkMTkM8bgT7ZR
	 +7elpI+X1UMMw4VICy05IdnQtX8ZyAA2UA9uXssdkurbebQOlMBH+7t8Gb7a5B2HAN
	 8dBPip1gGeRq/ZqL1fu0rM/f8p8BJ5A5ldUFk40RyWgVvVNmNropd0H7eknzYKk7Af
	 VKtpo/lHeVb9NsT6Or+eS1Vdj+b99IiXFIfziBQQYKtAvIh5L6FdZrRVUvc48ju6JS
	 mlKW3kBA1BOAA==
Date: Thu, 16 Apr 2026 14:53:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Thomas Graf <tgraf@suug.ch>, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-crypto@vger.kernel.org, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-7.1-fixes 1/2] rhashtable: add no_sync_grow option
Message-ID: <aeGElQ-TcCclEHwo@slm.duckdns.org>
References: <20260417002449.2290577-1-tj@kernel.org>
 <aeGCMkdg5Fgv8UMS@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeGCMkdg5Fgv8UMS@gondor.apana.org.au>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23089-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[slm.duckdns.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E8E9415DD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On Fri, Apr 17, 2026 at 08:43:30AM +0800, Herbert Xu wrote:
> On Thu, Apr 16, 2026 at 02:24:48PM -1000, Tejun Heo wrote:
> > The sync grow path on insert calls get_random_u32() and kvmalloc(), both of
> 
> Where does the sync grow path call kvmalloc? I think it's supposed

Oops, that's a mistake. I meant GFP_ATOMIC kmalloc allocation. kmalloc uses
regular spin_lock so can't be called under raw_spin_lock. There's the new
kmalloc_nolock() but that means even smaller reserve size, so higher chance
of failing. I'm not sure it can even accomodate larger allocations.

Another aspect is that for some use cases, it's more problematic to fail
insertion than delaying hash table resize (e.g. that can lead to fork
failures on a thrashing system).

> to use GFP_ATOMIC kmalloc only.  Only the normal growth path does
> the kvmalloc for a linear hash table.  The emergency path is supposed
> to do page-by-page allocations to minimise failures.
> 
> As to get_random_u32, we can probably avoid doing it for emergency
> growing and continue to reuse the existing seed.

Oh, that's great.

Thanks.

-- 
tejun


Return-Path: <linux-crypto+bounces-22272-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oINcJRiNwWlxTwQAu9opvQ
	(envelope-from <linux-crypto+bounces-22272-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 23 Mar 2026 19:57:28 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 362602FBB52
	for <lists+linux-crypto@lfdr.de>; Mon, 23 Mar 2026 19:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4440D330D616
	for <lists+linux-crypto@lfdr.de>; Mon, 23 Mar 2026 18:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ACE3BD22B;
	Mon, 23 Mar 2026 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULYcJxMC"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC263A5E85;
	Mon, 23 Mar 2026 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774289994; cv=none; b=r7wdSc8Ujoo23BYkvC0YnzB9sDYG3D+EZLDrI1opHa8besa5KknQFlWPD2YflLTm0z752hcbCT6jtT0/n7UrZIhphW3TJge3fTHnoRdYY1DH5NqZ5zga/8DOegG+3C/f1bqyL0EbGEcRUFZjUwYwNK21fS+jXvLys6hN8F0/lKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774289994; c=relaxed/simple;
	bh=4wxpOyklf0R2XiN92izrinwc+Y/UCGsNqfcUGq1tncg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0CFUoR2cUzNWWctKu2bPIFU373PIVQVRGf6yIcVOrhAXuLe9ZQ15ketZSVoeLDbmausmNvE40g7z10PIn1EewVOaobEqlT6hdB4dveniuOZn4XoKgOxuzsMhTwJBXv+iFs1C3rceCsd1NFO3fE1UdRePeDHU9m35pEKvkUBj/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULYcJxMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E33C4CEF7;
	Mon, 23 Mar 2026 18:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774289993;
	bh=4wxpOyklf0R2XiN92izrinwc+Y/UCGsNqfcUGq1tncg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ULYcJxMCOlOX5abYtvkiGFmJayVoEANH6C7eC/b+GMzZ2bG1Xbucw702ICEeu55CU
	 8lmmV/O5RY3YZMoCaQIZQ161Y+/DpK9AhczzLukFop+2s//UMgHJeG6T6M1Dlwakt4
	 Xh8mKWbyqDDidZjrOuOgcP6zh1sFppJLbA6+7hBuyolChvLgbJFqJI+Iq+aByMYn4X
	 0UGTN59LIuaCBGh5NDLjR0eRXn3BsGQMYFK3qXj6Ufq3gwHGoqdQLFpeXyVAwNUxPK
	 imz3b7WDEuIo+Be4f/JVxqfmfhHb7mN6YpXmgAsaWSEbXBoruzpiozD31VTddxk406
	 WD10xpxfegk9Q==
Date: Mon, 23 Mar 2026 08:19:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, puranjay@kernel.org,
	linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Michael van der Westhuizen <rmikey@meta.com>, kernel-team@meta.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 0/5] workqueue: Introduce a sharded cache affinity
 scope
Message-ID: <acGESIKl0Aqa318l@slm.duckdns.org>
References: <20260320-workqueue_sharded-v2-0-8372930931af@debian.org>
 <04af531d-d8a3-4fbb-993d-e1da2df62a03@app.fastmail.com>
 <acFVEr7iVnU_70yh@gmail.com>
 <f2f7fff3-2f6a-4ebb-aa5e-33188be4dd9a@kernel.org>
 <acFmcCcbPfznH_it@gmail.com>
 <53a8bc40-f22a-4447-a233-1cf88f837bbf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53a8bc40-f22a-4447-a233-1cf88f837bbf@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22272-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[debian.org,gmail.com,linux-foundation.org,vger.kernel.org,kernel.org,meta.com,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 362602FBB52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On Mon, Mar 23, 2026 at 02:04:57PM -0400, Chuck Lever wrote:
> > I don't see why the cores-per-shard approach wouldn't scale down
> > effectively.
> 
> Sharding the UNBOUND pool is fine. But with a fixed cores-per-shard
> ratio of 8, it doesn't scale down to smaller systems.

You aren't making a lot of sense. Contention is primarily the function of
the number of CPUs competing, not inverse of how many cores are in the LLC.

> A shard size of 2 clearly won't scale properly to hundreds of cores. A
> varying default cores-per-shard ratio would help scaling in both
> directions, without having to manually tune.

If your workload is bottlenecked on pool lock on small machines, the right
course of action is either making the offending workqueue per-cpu or
configure the unbound workqueue for that specific use case. That's why it's
progrmatically configurable in the first place.

Thanks.

-- 
tejun


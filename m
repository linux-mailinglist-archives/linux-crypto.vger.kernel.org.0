Return-Path: <linux-crypto+bounces-21304-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJ2tF+qqomlF4wQAu9opvQ
	(envelope-from <linux-crypto+bounces-21304-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 28 Feb 2026 09:44:26 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B048B1C1791
	for <lists+linux-crypto@lfdr.de>; Sat, 28 Feb 2026 09:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ECA7303FFD8
	for <lists+linux-crypto@lfdr.de>; Sat, 28 Feb 2026 08:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CF032E134;
	Sat, 28 Feb 2026 08:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="MHDdtYr1"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AA821D3F5;
	Sat, 28 Feb 2026 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772268239; cv=none; b=fafXiWmACWowRrFUVTLJlTrZzcpDBgX4+JnxLPeywR/0AY4VlTb+FG2TunqzFisXpiT1M36YaqVl5WftY6cvtCaciRkTxaUBGit1ZSjpDz+vZIQlxSN0jC8VjMSxHdDBjZDJO/716roOCfHBCJy0FbRrWcaxDqyU8Z7d33qXp3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772268239; c=relaxed/simple;
	bh=4iaAHWC4biAuYTJ6o/yTiaP7lKPF0Mf9dmz+H5vUDXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEoSSpM/GazJJ+K8EoFAVBsv9ZBxxZKrJi15Jl4lp31KzHblJ+VIoDEG76+eD8W6ofZIjdFvlq62Gllh9HuegLIWBHEUeGhngZRsy3Uy4DbGC5ylSINuvhV+AJA8J3N+HLNfyny6JI1UTkIg4vR9kCa0WifFbxtx/71IwpbIV1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=MHDdtYr1; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=0Z0tyLtFgEtwsUhTUiZ6caFZvQ/+L2LWS0mCkowImJk=; 
	b=MHDdtYr1dlgk9sE0wYLo4CiupCTibtHISpdlrI4z6OMju99hfpuLJTt+Oe5tA9Oxbba5bCIhtEA
	3q4ukKxprE8PqaBBgMu72qJWzrKUTjcGxNnnkdr7h3WITPDDEl2qLoT1tI2sI3WDJVfExaCmMJ4N4
	VftpQJ2F8oxC3mufHoWvWPwBvRvHwmjUefNBiXCmJRAeB5/duJXSY6K4xECHjgjHsrSeJ+nfGT1B8
	Slw2j70waadWIpvjl4c6kHV56LIYT1kdQajyuiumdlJPpQu8Ul4SIKkxLZh9HealXlzm8uvuLpeBd
	y5nnEYmuyaMfGtwdwqxZbt4SD2t52aZSyCVw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vwFvF-00ADms-0G;
	Sat, 28 Feb 2026 16:43:38 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 28 Feb 2026 17:43:37 +0900
Date: Sat, 28 Feb 2026 17:43:37 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Pat Somaru <patso@likewhatevs.io>
Cc: Gonglei <arei.gonglei@huawei.com>,
	"David S . Miller" <davem@davemloft.net>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Tejun Heo <tj@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: virtio: Convert from tasklet to BH workqueue
Message-ID: <aaKquVKecG8mCDXU@gondor.apana.org.au>
References: <20260207182001.2242836-1-patso@likewhatevs.io>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207182001.2242836-1-patso@likewhatevs.io>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21304-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:url,apana.org.au:email,gondor.apana.org.au:mid,gondor.apana.org.au:dkim,likewhatevs.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B048B1C1791
X-Rspamd-Action: no action

On Sat, Feb 07, 2026 at 01:20:01PM -0500, Pat Somaru wrote:
> The only generic interface to execute asynchronously in the BH context
> is tasklet; however, it's marked deprecated and has some design flaws
> such as the execution code accessing the tasklet item after the
> execution is complete which can lead to subtle use-after-free in certain
> usage scenarios and less-developed flush and cancel mechanisms.
> 
> To replace tasklets, BH workqueue support was recently added. A BH
> workqueue behaves similarly to regular workqueues except that the queued
> work items are executed in the BH context.
> 
> Convert virtio_crypto_core.c from tasklet to BH workqueue.
> 
> Semantically, this is an equivalent conversion and there shouldn't be
> any user-visible behavior changes. The BH workqueue implementation uses
> the same softirq infrastructure, and performance-critical networking
> conversions have shown no measurable performance impact.
> 
> Signed-off-by: Pat Somaru <patso@likewhatevs.io>
> ---
>  Hi, I'm working on converting tasklet usages to the BH WQ API.
> 
>  The virtio-crypto driver uses a tasklet per data queue to process
>  completed crypto operations in BH context. This converts that tasklet
>  to use the BH workqueue infrastructure.
> 
>  This patch was tested by:
>     - Building with allmodconfig: no new warnings (compared to v6.18)
>     - Building with allyesconfig: no new warnings (compared to v6.18)
>     - Booting defconfig kernel via vng and running `uname -a`:
>     Linux virtme-ng 6.18.0-virtme #1 SMP PREEMPT_DYNAMIC 0 x86_64 GNU/Linux
> 
>  Maintainers can apply this directly to the crypto subsystem tree or ack
>  it for the workqueue tree to carry.
> 
>  drivers/crypto/virtio/virtio_crypto_common.h |  3 ++-
>  drivers/crypto/virtio/virtio_crypto_core.c   | 11 +++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


Return-Path: <linux-crypto+bounces-22387-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHsuJFVExGm1xwQAu9opvQ
	(envelope-from <linux-crypto+bounces-22387-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Mar 2026 21:23:49 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F65D32BC2A
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Mar 2026 21:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4588B3059710
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Mar 2026 20:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAB7367F20;
	Wed, 25 Mar 2026 20:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9kHOsCX"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506883537C9;
	Wed, 25 Mar 2026 20:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774470056; cv=none; b=Vzc4ECgQVnRSPffvtD0fMQIc9wD/Lm0qigSqPdHTTACY0KZInrL33Exfq0ip1j7Mm1KXJX0BmRkUnzkq/3WGb+cD1rsW0NmKfj1VLuBSKhpaOWOrXHRa/E/eYvg22L7eRvzIRgLWudzWmMmHRVxsJRL9xE20PuJRepFwXZYEkhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774470056; c=relaxed/simple;
	bh=vfTpAReEB03EgkWwWTy/7/I4kxr0oycMmdpafvTBqbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3MxrhZCBLYOBKdymJjiP+l1UwZqoMg/20om0gEWU+tKg5ui+MXf0vp+EFmaaQcX8kwJfaX8GsFldu4QexeRZN71JQz7q1rL2UqnbdwtFyq64w19n9qzQjYwEhN2fzYXqEmnwYBqz1h587knjv81onfC3oF+Rp/9CKuXS9UgvhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9kHOsCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93746C4CEF7;
	Wed, 25 Mar 2026 20:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774470056;
	bh=vfTpAReEB03EgkWwWTy/7/I4kxr0oycMmdpafvTBqbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X9kHOsCXpbnqPbnws8Re1eQA1H0SC5Du96Mv2YFteUdfF5XVSruS0MaMTDfc02+p+
	 Svq2FldytMFbjAf6QQfwXPa2nGNmdr7ziLF5MYKcLFsV9spuJUZoEcstFZmr8fepyW
	 1FWoY/dt7/8moXmt3csOCobXx4XTiZurUJFWdRZ6pSFjDwQ7kFdjYPZC8XeLZ5Sk34
	 Ir56s8WaJNUt/5mwssDfToL5ha/j/5tmd5/xPjPS7YrydBUg9UbjN+cY/17Hv29YTP
	 2eTzOBUlCi5P196CUBaq4fGzA5EjcX0NrxZyFzKHFHshDeLz7YSPGlNyMOJKekOblU
	 PJE8z6vGMVKwg==
Date: Wed, 25 Mar 2026 13:20:53 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 00/21] nvme-auth: use crypto library for HMAC and hashing
Message-ID: <20260325202053.GE2305@quark>
References: <20260302075959.338638-1-ebiggers@kernel.org>
 <20260304132327.GA15515@lst.de>
 <20260305193150.GF2796@quark>
 <aanbGwda2pHmMTMx@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aanbGwda2pHmMTMx@kbusch-mbp>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22387-lists,linux-crypto=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F65D32BC2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 05, 2026 at 12:35:55PM -0700, Keith Busch wrote:
> On Thu, Mar 05, 2026 at 11:31:50AM -0800, Eric Biggers wrote:
> > On Wed, Mar 04, 2026 at 02:23:27PM +0100, Christoph Hellwig wrote:
> > > Thanks, this looks really great:
> > > 
> > > Acked-by: Christoph Hellwig <hch@lst.de>
> > > 
> > 
> > Thanks.  I assume Keith will pick this series up for 7.1.  Keith, I
> > forgot to include you explicitly on the recipients list (I must have run
> > get_maintainer on drivers/nvme/target/ instead of drivers/nvme/common/),
> > but I assume you received this series via linux-nvme anyway.
> 
> No worries, I'll start up a 7.1 branch and get this queued up. Thanks!

This hasn't made its way into linux-next yet.  Is that expected?

- Eric


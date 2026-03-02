Return-Path: <linux-crypto+bounces-21467-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDyyBfUipmkiLAAAu9opvQ
	(envelope-from <linux-crypto+bounces-21467-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Mar 2026 00:53:25 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 990101E6DB1
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Mar 2026 00:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2E153059FC1
	for <lists+linux-crypto@lfdr.de>; Mon,  2 Mar 2026 23:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A33358387;
	Mon,  2 Mar 2026 23:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOD83Aq9"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE04F349B16;
	Mon,  2 Mar 2026 23:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772495601; cv=none; b=fXYw1cWuCBgLAYsKpE7HEM+NdernHE49B+ZRxYog3kxZ7iuI3NzfVj5sDJ7TBVR1aDoaFzub3pRIYJieSVbUsGHJY1c4FweGdtA3tA+idP774rI6s9A4xdDYDdvwRpa4JGFNIAc6F6A8SJpmyJW7UsOFS2GHPMSYte7DuzjA20g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772495601; c=relaxed/simple;
	bh=44cMeGZr/l5eYry48qvh4fYrPN4/ezc2BGolvQEwZcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpEdqqT9PO86DXvOXgo7x8KS91sZ3KNsTyijljzKmFcFbkgMSme9Qv4y6bsN+c55oQLxv36887XJQ0G8lMZwDDi9KqUFCu0fsjCCggCEHllghxi2xyQUNuJ7+4qba+Kr9ZcpfAq+0alxo4C8iMLMp6dT4/4q8hsdzigIWcaCK3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOD83Aq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB98C19423;
	Mon,  2 Mar 2026 23:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772495601;
	bh=44cMeGZr/l5eYry48qvh4fYrPN4/ezc2BGolvQEwZcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NOD83Aq93vDhuSJZC6nInxhLwfcgbL1UQJR7sGFh7xp8XQFbyiN4RNNlhWX3PffNO
	 s1W8+SJksbF8P/9tteHUOkLR8syoaongW5t7IFwOu4bWAlS8G8YL4eIFKKS5G9somd
	 3eYp9zNhudI3RUjvasFNKuy7Nm4ygXLH6KKBs0+7VHhqEE2guVQrXZO9cH+IiRjPyY
	 CyeOLmjGZm9IE6Bj3qFNeSgFfAVCK7ADrP9Nr6I6ypMyjERKzoEtXttAYOepNwbzFF
	 Y48Kfv7x1MNIt+6BJNsivtW0YRDvrSEP/LLRNYcOABEyYh+oxqE0wA9acepL7BjAnq
	 gFgt3cfiAqgcw==
Date: Mon, 2 Mar 2026 15:53:13 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-crypto@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: testmgr - Add test vectors for
 authenc(hmac(md5),cbc(des))
Message-ID: <20260302235313.GD20209@quark>
References: <20260207145113.375192-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207145113.375192-1-olek2@wp.pl>
X-Rspamd-Queue-Id: 990101E6DB1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[wp.pl];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21467-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gondor.apana.org.au,davemloft.net,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Feb 07, 2026 at 03:51:03PM +0100, Aleksander Jan Bajkowski wrote:
> Test vector was generated using a software implementation and then double
> checked on Mediatek MT7981 (safexcel) and NXP P2020 (talitos). Both
> platforms pass self-tests.

It would be better to just remove the support for these obsolete
algorithms from the drivers that support them.

- Eric


Return-Path: <linux-crypto+bounces-25873-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ewIbK/xJVGoCkQMAu9opvQ
	(envelope-from <linux-crypto+bounces-25873-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 04:14:20 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F054B7468C4
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 04:14:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=G61dKqki;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25873-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25873-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 50FD9300185C
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 02:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ED22DA765;
	Mon, 13 Jul 2026 02:14:14 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D494E2BE02C;
	Mon, 13 Jul 2026 02:14:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783908853; cv=none; b=sFDIwgeDZRTuCMnZDnk7S1er9fFQI3ueb5fjZZxCpGUREAgbPlhgmy2uft9MycVg/l9knfWNHqLZBtTjGywBYpVpxHWSwARDG0qV6ahJAnOu7v1VG2h+fdRVixB56cIwHuZ28t5JoGvszU2jFjRrWonp+2kgO/5bJSJbOngt2oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783908853; c=relaxed/simple;
	bh=x/6Aybh8qMwzxuoqkJ8AFNGVMGMKpjGANuAHy9C2Za0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoH4kQN3A6fFxKyuLdVs6BaEehPUeiM/M4Ia9BvUxkYlsYrwIPQY/g03jo+1Ko21+EftsSPxlob3bMcRsh3hLlQ/I2tmzEQykOt98H5Z3iRqGI7b2xtbHmgfdBqUGpkkORVPo4+4b0Z7SIKG4i5BR3Nba8nGvEeOluoxqPvRELo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G61dKqki; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C75E1F000E9;
	Mon, 13 Jul 2026 02:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783908852;
	bh=kJrJvnR4QUfDBiFR/fI81D6iOTTw+jkEAND0yFvGwRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G61dKqkimz4p/aQpzztQzmXtrTl4SSpMaEDA9JfOEY2riPER3tPuaZrCgtpkGgpie
	 nw5apxWuubJ+Ljau0rJJyyuYj8TvwwnE5SHqEYaD+Y3jubk0gmSNtFlwEoCjqAohzu
	 NSZcLnro74hn1+IILJ9nwCFygSG/KgO2Nr4k6mcgmrdDpKF+ZVu5puUPK0Tn9yn8rZ
	 vYVgZqwJMxT2sQIxWSwnY4zGe18iUJg9mJcuOlnpPfBTO5E1mezROEV5RGc+YF/QIq
	 ZjKRwXPujr6Egwkw/1R7lawf0tvqFOO1TIv5BDvveUCjY35kTfzA04fDJrpNUCScsE
	 EJScjkwNGv3Yg==
Date: Sun, 12 Jul 2026 22:14:10 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] lib/crypto: md5: Remove support for md5_mod_init_arch()
Message-ID: <20260713021410.GA4362@quark>
References: <20260629032552.26100-1-ebiggers@kernel.org>
 <20260705195008.GE41916@quark>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705195008.GE41916@quark>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ardb@kernel.org,m:Jason@zx2c4.com,m:herbert@gondor.apana.org.au,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25873-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F054B7468C4

On Sun, Jul 05, 2026 at 12:50:08PM -0700, Eric Biggers wrote:
> On Sun, Jun 28, 2026 at 08:25:52PM -0700, Eric Biggers wrote:
> > No definitions of md5_mod_init_arch() remain, so remove the code that
> > handles it.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> 
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-next
> 
> - Eric
> 

Moved to libcrypto-fixes instead.

- Eric


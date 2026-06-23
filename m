Return-Path: <linux-crypto+bounces-25340-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LqpuFNfKOmp3HAgAu9opvQ
	(envelope-from <linux-crypto+bounces-25340-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Jun 2026 20:05:11 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAEC6B95AF
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Jun 2026 20:05:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LOuNqKAa;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25340-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25340-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A68D304438C
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Jun 2026 18:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945463921CD;
	Tue, 23 Jun 2026 18:05:05 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765F438A722;
	Tue, 23 Jun 2026 18:05:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237905; cv=none; b=iXWlHGpqPjrjmq8LyBMo1Uv/z4TMucVtNBwLhRbpZX957QNfL78DMsDTGauyWsYfmV1/ehS0UHpW6AzRPtKgcIv/iYpAFTEvjxvQXDNNvuNpFeTqTenVfoGqKH7RLEX0in/dGAnLesHdyS8PSlvMPOyPJEt4gmJSZ+QCFWwTcZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237905; c=relaxed/simple;
	bh=laPZuoKzOlRgjMu009Sv1XuC5u1F5zM24h/pb88UUgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gvzn2ZmUWOejzase+GBWEw3pFDxTYm0jtIkYJ/7PUrjeYxCKpfmJ0ZtICpWfJyPWIcF78Fzk6GXw+z+/eRcfNM3w51FSJtfSjpxovoGoWVr5GjDCAdYN6DMBPimKW5lA/qEd7q50OtXn5LDFW36OSVp7j9I/SuKhCsaN7WwAFkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOuNqKAa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE4F1F000E9;
	Tue, 23 Jun 2026 18:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782237904;
	bh=DcbPuct3JcioZ7MKEBA7Z8jvWe10D5XpmKWh6eWGb4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LOuNqKAa9bECpMHiIJ8rhDaCCQpm6/yHxaGtZrvh8/E4Z2q40mqJ3tKyCL6745HV8
	 x6GAW3AtEFeW/BFVRLXn3gEITy3i/MLrxsoicNPIUuF8GlEvNdEurHp0LHeejWM3i2
	 tj2jsrBf3KM1a0oOLrlLZaI/JhUYqL5bDGo1ki+dklz42tz76Ogh7AWA3AG5HSSXMx
	 OFLm1bBiI4U3eq/Cnl/cqg8SREI57wgZ6BXkPCQXUFSCgwAwf318FOEbd/OYVTSW02
	 Nd9rGlZYX8uzFJ5MWMQRNxHe8pSKdhW3t0Vapq5uwLwTA+tMc625EWDpZ4nPoZ9mXt
	 nouimSdmHgFSw==
Date: Tue, 23 Jun 2026 18:05:02 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, iwd@lists.linux.dev,
	linux-hardening@vger.kernel.org, Milan Broz <gmazyland@gmail.com>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH] crypto: af_alg - Add af_alg_restrict sysctl, defaulting
 to 1
Message-ID: <20260623180502.GC1850517@google.com>
References: <20260622234803.6982-1-ebiggers@kernel.org>
 <CABBYNZ+QLvkYkn_EcBZ4+GopyhKqJLcfCoABYcw1VamavbSvhg@mail.gmail.com>
 <20260623165208.GB1793@sol>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623165208.GB1793@sol>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-25340-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:luiz.dentz@gmail.com,m:linux-crypto@vger.kernel.org,m:herbert@gondor.apana.org.au,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:iwd@lists.linux.dev,m:linux-hardening@vger.kernel.org,m:gmazyland@gmail.com,m:demiobenour@gmail.com,m:luto@amacapital.net,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gondor.apana.org.au,lists.linux.dev,gmail.com,amacapital.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2BAEC6B95AF

On Tue, Jun 23, 2026 at 09:52:08AM -0700, Eric Biggers wrote:
> On Tue, Jun 23, 2026 at 11:04:14AM -0400, Luiz Augusto von Dentz wrote:
> > > +===  ==================================================================
> > > +0    AF_ALG is unrestricted.
> > > +
> > > +1    AF_ALG is supported with a limited list of algorithms. The list
> > > +     is designed for compatibility with known users such as iwd and
> > > +     bluez that haven't yet been fixed to use userspace crypto code.
> > 
> > Is the expectation that we go shopping for userspace crypto here?
> 
> Yes, same as what 99% of userspace already does.  Probably you'll just
> want to link to OpenSSL, but it could be something else if you want.
> 
> - Eric

By the way you do know that bluez already has a local implementation of
ECDH, right?  See src/shared/ecc.c.

- Eric


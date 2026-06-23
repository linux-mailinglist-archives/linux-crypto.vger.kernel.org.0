Return-Path: <linux-crypto+bounces-25336-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A1bEBmDGOmpLGggAu9opvQ
	(envelope-from <linux-crypto+bounces-25336-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Jun 2026 19:46:08 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6864A6B933E
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Jun 2026 19:46:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KZb6fF0r;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25336-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25336-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30143306127E
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Jun 2026 17:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5354838E5DF;
	Tue, 23 Jun 2026 17:45:43 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADFC38D402;
	Tue, 23 Jun 2026 17:45:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236743; cv=none; b=sPWiLE80ZJAKx3pJeFOd5UKlfZXjOxjkc3uVY0xnVqpNlUTTBH9Vsme5CGkyPzd4cIOF6sl1iPcfUmD3Sv55u04KX57PPWvniLxPbVhHS9/F9o/L2AgXgI+s8fcoQU1WHOXJ7FiPEljgzVWGSLFDlyCt8/24knvCMg91QuY1OME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236743; c=relaxed/simple;
	bh=3F9JITuCL3Q6WQ6xO8GFZEPkn54o5MhYIkDteUmsJQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXgJA250LwXiLWLDrfBk/INuj5keUNlawOkRL0rR1VNyb7IzWjjOZw+moSUoGW0RqTtNF48/Lht+ZeLHC6q9aL+4BZMaxX6IFY0fQUDNRBgYkfQD863HZ5cytzV87agGomOu0Px8+MoecGPZiaxmznyz++6gdB/NSYgpE5YZE34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZb6fF0r; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8631F000E9;
	Tue, 23 Jun 2026 17:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782236742;
	bh=Z+KZ7eLxT5XKrkOXLovvKv/03+JktkzJGUFB56VR1HU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KZb6fF0rRvPTq0y+NX7mUS2XZkwqXbOXxp5+J+3YS1qDcDb8BilWCDG2+zBOz1SMV
	 mbMl/oiDXG1zuZlQzVwpwdTiEFdmFCSyUoXgu+xNV4dAYf7GR47W1UP4et+BYNN0G3
	 LvWO+F52Fbrxz6Qp405L7NSQXe738vxss7zru9Q6f29Zz9eAw2CQyKo2iXOLY6bE5Q
	 Od8M+lZCB6/o9AKwUoFrpuIhaGLmbvhH8nuZqMJsGjlYW5OfYBet3qhk5ls4g6u4np
	 sMwbFOYD5QCjmPLcQ2DZysn+uLEr/VWYx+oXg77XJZ+Hzm/FqjfzKyz5xZGriOf00N
	 OMt64tfFkuw2A==
Date: Tue, 23 Jun 2026 17:45:39 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, iwd@lists.linux.dev,
	linux-hardening@vger.kernel.org, Milan Broz <gmazyland@gmail.com>,
	Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH] crypto: af_alg - Add af_alg_restrict sysctl, defaulting
 to 1
Message-ID: <20260623174539.GA1850517@google.com>
References: <20260622234803.6982-1-ebiggers@kernel.org>
 <CABBYNZ+QLvkYkn_EcBZ4+GopyhKqJLcfCoABYcw1VamavbSvhg@mail.gmail.com>
 <20260623165208.GB1793@sol>
 <01b73988-b35c-4ce8-8463-4589fe18b0b0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01b73988-b35c-4ce8-8463-4589fe18b0b0@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-25336-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:demiobenour@gmail.com,m:luiz.dentz@gmail.com,m:linux-crypto@vger.kernel.org,m:herbert@gondor.apana.org.au,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:iwd@lists.linux.dev,m:linux-hardening@vger.kernel.org,m:gmazyland@gmail.com,m:luto@amacapital.net,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,gondor.apana.org.au,lists.linux.dev,amacapital.net];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,cryptography.io:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6864A6B933E

On Tue, Jun 23, 2026 at 01:29:20PM -0400, Demi Marie Obenour wrote:
> On 6/23/26 12:52, Eric Biggers wrote:
> > On Tue, Jun 23, 2026 at 11:04:14AM -0400, Luiz Augusto von Dentz wrote:
> >>> +===  ==================================================================
> >>> +0    AF_ALG is unrestricted.
> >>> +
> >>> +1    AF_ALG is supported with a limited list of algorithms. The list
> >>> +     is designed for compatibility with known users such as iwd and
> >>> +     bluez that haven't yet been fixed to use userspace crypto code.
> >>
> >> Is the expectation that we go shopping for userspace crypto here?
> > 
> > Yes, same as what 99% of userspace already does.  Probably you'll just
> > want to link to OpenSSL, but it could be something else if you want.
> 
> Hard disagree on OpenSSL.  It's not a good library.
> 
> See <https://cryptography.io/en/latest/statements/state-of-openssl/>.
> 
> Distributions should ship AWS-LC and either rebuild reverse
> dependencies when needed, or work with upstream to catch ABI breaks.

I don't like OpenSSL either, but it's the de facto standard on most
distros.  While perhaps distros should make that switch, there's no need
to wait for that to move away from AF_ALG.

- Eric


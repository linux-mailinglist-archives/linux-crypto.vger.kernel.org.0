Return-Path: <linux-crypto+bounces-25844-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j0A3E55eUmqnOwMAu9opvQ
	(envelope-from <linux-crypto+bounces-25844-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 11 Jul 2026 17:17:50 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C754A741EFD
	for <lists+linux-crypto@lfdr.de>; Sat, 11 Jul 2026 17:17:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25844-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25844-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 356EE301158A
	for <lists+linux-crypto@lfdr.de>; Sat, 11 Jul 2026 15:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D232BEFE8;
	Sat, 11 Jul 2026 15:17:46 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36553274670;
	Sat, 11 Jul 2026 15:17:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783783065; cv=none; b=InOn0CtUQ84ENxBDUQZZj1lzaRApYPoItrH1DBeIaoCmRGL29sgO7uM0Gxs6RUs7baxkTB7jGEziGNqSFP5fRG6x/F/Zlvia3xIh/WcEXjJKxRUWH9sHPHqn5AZf0/HKyCL7ovNrAEUyU/R+nJgrHTTVJhWnYTlyx27GbUZuL+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783783065; c=relaxed/simple;
	bh=fqARJc+NNvnL8YxWY/v+n0HfzhSYBAagWQc7F5R+A74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgTQUKKhGRE9ocsFiJR1UJVsRjiIaMFDM4Azjmg2SykYfg60n/R33yTqvG4WqBt5cP3vBypA5Zn/df1dSxpYCZ42PsEAAAcbPi1fzrhpKe/jbalBwjJrqbPC7JtSI/NhXpCmdTPXRFRhT2+j1/57PdU4FBmEevJc5epYrmomwKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id CFEEF35B;
	Sat, 11 Jul 2026 17:17:32 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B8E136035026; Sat, 11 Jul 2026 17:17:32 +0200 (CEST)
Date: Sat, 11 Jul 2026 17:17:32 +0200
From: Lukas Wunner <lukas@wunner.de>
To: David Gall <david.ccm.gall@googlemail.com>
Cc: Ignat Korchagin <ignat@linux.win>, Greg KH <gregkh@linuxfoundation.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: rsassa-pkcs1: use constant-time comparison for
 digest and signature verification
Message-ID: <alJejMW5JwNQWw7C@wunner.de>
References: <alEr_e-G0L2nxxv-@fudgebox>
 <20260710213718.GD1911@quark>
 <2026071156-masculine-unsold-3567@gregkh>
 <CAOs+rJUPQq88D7YwHyrbTFF-G9Lw7cJ9pcaZBpACP89ES9z00w@mail.gmail.com>
 <alInuM5TquLTv5QE@fudgebox>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alInuM5TquLTv5QE@fudgebox>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25844-lists,linux-crypto=lfdr.de];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	FORGED_RECIPIENTS(0.00)[m:david.ccm.gall@googlemail.com,m:ignat@linux.win,m:gregkh@linuxfoundation.org,m:ebiggers@kernel.org,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davidccmgall@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[googlemail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lukas@wunner.de,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C754A741EFD

On Sat, Jul 11, 2026 at 01:23:36PM +0200, David Gall wrote:
> That said, this function [rsassa_pkcs1_verify()] already uses
> crypto_memneq() for the hash-prefix check a few lines above.
> I'd argue for consistency it's worth using it for the digest
> comparison too.

I'd prefer the other way round, i.e. to use memcmp() for the hash_prefix
comparison.

Thanks,

Lukas


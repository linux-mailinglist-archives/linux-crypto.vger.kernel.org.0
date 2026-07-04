Return-Path: <linux-crypto+bounces-25579-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +BBvOopWSGrCpAAAu9opvQ
	(envelope-from <linux-crypto+bounces-25579-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 04 Jul 2026 02:40:42 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B387064B8
	for <lists+linux-crypto@lfdr.de>; Sat, 04 Jul 2026 02:40:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=D55dS1Nj;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25579-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25579-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4A603023DBA
	for <lists+linux-crypto@lfdr.de>; Sat,  4 Jul 2026 00:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C631F4631;
	Sat,  4 Jul 2026 00:40:40 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92C218AE3;
	Sat,  4 Jul 2026 00:40:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783125640; cv=none; b=XwO7c6UEvtfX+j6F91EeckTGbVbM2tkRBo0reX8MZJHMR3MWSP7Pg7lW5VrXw1lIYXoZkRKu0mU7pWLeQPtyqx8aXLIEz7smfFPThvP/yYqCjHn3XUqC/+GY/fnaD7Qkwf7C6PvYkU91c0V/rtehY9VHbR3Q8LP7G0D8SgtYyh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783125640; c=relaxed/simple;
	bh=gBI3Zs4ek2eYMGiLZswJFa3WoIBsKoZAyHs/qlK83Kc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ir89IzvVeGXVdVV5unZmi/L5qqoomqMh0PUNLkLK3616RPib1CFroU36lwkbsHPxIEdxur4hDZ0tQwtrTNfkOfgld0M4LXIpT7N2vZDPeCxOUEMQvLPGi15CWpRY4HNe53LVZQdnAkP9pzVeX8GzRH85g/q6jlC+KcNakJE1ml8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D55dS1Nj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DAA1F000E9;
	Sat,  4 Jul 2026 00:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783125638;
	bh=dK9o71yrpEUNlGSVfJCX9fcW6yA3yYMits5n7r1NLzE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=D55dS1NjfGgE1Q3hi7Iwlqz7ZqJwmv/ins/CGf56Y5HA/p898N+Z9kse6xuyhjCoa
	 WLzVsydQbMieBNw7fZ51V2RurzWxLLMe6ObkX4wKluRwpnxTcaUQvz4adwcCdhxGZd
	 unLSKWbx2e3HKigrTOYyXB/lpMRVOiUL4ujZh2fg=
Date: Fri, 3 Jul 2026 17:40:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Mark Gross <markgross@kernel.org>, Konstantin Ryabitsev
 <konstantin@linuxfoundation.org>, linux-edac@vger.kernel.org, Borislav
 Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 linux-crypto@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3] MAINTAINERS: Drop Mark Gross
Message-Id: <20260703174037.b0065a1700ccf814b8a5d760@linux-foundation.org>
In-Reply-To: <20260703173803.3589003-2-ukleinek@kernel.org>
References: <20260703173803.3589003-2-ukleinek@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:markgross@kernel.org,m:konstantin@linuxfoundation.org,m:linux-edac@vger.kernel.org,m:bp@alien8.de,m:tony.luck@intel.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:linux-crypto@vger.kernel.org,m:arnd@arndb.de,m:gregkh@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:andriy.shevchenko@linux.intel.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25579-lists,linux-crypto=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux-foundation.org:from_mime,linux-foundation.org:dkim,linux-foundation.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86B387064B8

On Fri,  3 Jul 2026 19:38:03 +0200 Uwe Kleine-K=F6nig <ukleinek@kernel.org>=
 wrote:

> Sending mail to Mark's Intel address results in the intel mail
> server rejecting the mail. Dave Hansen confirmed he left Intel.
> The kernel.org address seems to work, but there was no reply from Mark
> on the discussion about broken email settings and his maintainer
> entries.
>=20
> So drop him from all maintainer entries.

These seem good grounds for altering MAINTAINERS.  It happens.


But

hp2:/usr/src/25> egrep "(Author|Acked|Reviewed).*Mark Gross" ../gitlog|wc -l
52

all gone poof?

Please send a v2 with the subject

	MAINTAINERS: move Mark Gross to CREDITS

Thanks.


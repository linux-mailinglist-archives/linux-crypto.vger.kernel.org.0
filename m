Return-Path: <linux-crypto+bounces-25902-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ILcsErp7VGoQmgMAu9opvQ
	(envelope-from <linux-crypto+bounces-25902-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 07:46:34 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 911B874754C
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 07:46:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iVQ9EyNA;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25902-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25902-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DC6330182A7
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 05:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F4735F185;
	Mon, 13 Jul 2026 05:46:31 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9480425C804;
	Mon, 13 Jul 2026 05:46:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783921591; cv=none; b=qQeyyJE5t0NaqAIrh95RK3SZYUvKTDZ1a5WMsiDUly4DNiXjTSLQhjYkKupvAEBCNxVep7dydNjKB+2HdCZywzuG1Rd+6X947hQAeKMSqYspBUIEaAdWjPNcr1OIeShZYzXvGq6zQz+fzUWRsax+dfdX9HglVYB2sVJ0bvrQZzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783921591; c=relaxed/simple;
	bh=IH9+XhLTCg2d0PsasILExIUhxCLy1Xq4zpUtShtN4w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEUtssrySdgIe9uE5oNbihDMxs5j2zxeGu31eU87sUBF94Mfq7O6KbshSwiXQ13NkQLafN5mrIsG8WcgtqC+C6CwEdR821iSzuGdNCtZemsd4o4sSLC/10fLpFnyhKekMdD/AL19TRezd7RTf0ZGibIjNm05QjEjZmbzJ6vRhwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVQ9EyNA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 734D91F000E9;
	Mon, 13 Jul 2026 05:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783921590;
	bh=TslgJxPDu2FoohwrHHfEY80wcLwj5lAHu6Z5tKoMi4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iVQ9EyNAiglnejOK6JjxXr9UuEqXtokYOdkR+LNDbmo0LjyVuV0w4Bsu4Mlygf73u
	 CxCwSW3nlEKkeLcT8HAeucvqwgM7U17faBa0yqsHLIWYX/qRfHjA+x4Bw1dH/wRjL1
	 yZT5Bgtb6TY5D7rJ7A4z4HSQNl9okgTjCjIHRXuwvAaXn6A9v9SprjEhTNyPDq31tA
	 p93HP8ZutPwKtdS3yi336PUujTbOJDSlpPOqs19TtHFWbrnUPMPFEdrkZPU24vkqDs
	 YeklAdUCIbZUkzYi5e0dxxJjxVxBVsXa/HkAB1I+NH6G0UctPAfed6AWGtBXf0isRO
	 C1T+YVlW6uEjQ==
Date: Mon, 13 Jul 2026 07:46:26 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Mark Gross <markgross@kernel.org>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
	linux-edac@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3] MAINTAINERS: Drop Mark Gross
Message-ID: <alR7WaRFM25AcvJh@monoceros>
References: <20260703173803.3589003-2-ukleinek@kernel.org>
 <alRfWpuiEiRC72u3@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j4bc4txee6jzbdzs"
Content-Disposition: inline
In-Reply-To: <alRfWpuiEiRC72u3@gondor.apana.org.au>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:akpm@linux-foundation.org,m:markgross@kernel.org,m:konstantin@linuxfoundation.org,m:linux-edac@vger.kernel.org,m:bp@alien8.de,m:tony.luck@intel.com,m:davem@davemloft.net,m:linux-crypto@vger.kernel.org,m:arnd@arndb.de,m:gregkh@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:andriy.shevchenko@linux.intel.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ukleinek@kernel.org,linux-crypto@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-crypto@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-25902-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,monoceros:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 911B874754C


--j4bc4txee6jzbdzs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v3] MAINTAINERS: Drop Mark Gross
MIME-Version: 1.0

Hello Herbert,

On Mon, Jul 13, 2026 at 01:45:30PM +1000, Herbert Xu wrote:
> Patch applied.  Thanks.

Note that Boris already took this patch. It's already in next for a
while as 97dfcb871ba776ba0e1ded1cdcbe94a357c2817e.

Best regards
Uwe

--j4bc4txee6jzbdzs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpUe7AACgkQj4D7WH0S
/k4Luwf7BmhMfqLK1e7DXmVCka6JcVYawnOTTaSY9uV1MDjTklYTCLvgYnyBXmra
6ajrv9bd12XpwMKukx4cZ+raB50wDP2o8XQPsKIlRHco5xgi4MLkk9W/mRFtodZP
S66q474WR7z/8ar8rM9O+9KjcnbvqkW+/VM8xiFFkdPIzo1fI4fWmDMZVHVgeK0K
Rzj+4VjMwstHbnHoLcOH0Rk0rfATsTp5Ldv70gjFcJo7S+MyDvkV3BgfXEWdumOB
pSCOYwwtBko06zcydXT2VOrE/67kUIlG35+S9l/63fpjnBYM7Y3KtnFJYNKrxTKr
PH25Ki09UWrC3sEALqfpxBMoSZWq/w==
=XP2N
-----END PGP SIGNATURE-----

--j4bc4txee6jzbdzs--


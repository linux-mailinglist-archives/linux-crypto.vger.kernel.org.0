Return-Path: <linux-crypto+bounces-25863-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FTOXOshLU2p9ZgMAu9opvQ
	(envelope-from <linux-crypto+bounces-25863-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 12 Jul 2026 10:09:44 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 576197441CB
	for <lists+linux-crypto@lfdr.de>; Sun, 12 Jul 2026 10:09:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sang-engineering.com header.s=k1 header.b=IzlypMh7;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25863-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25863-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AE8D300D6B4
	for <lists+linux-crypto@lfdr.de>; Sun, 12 Jul 2026 08:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48770371D01;
	Sun, 12 Jul 2026 08:09:40 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38A02DA765
	for <linux-crypto@vger.kernel.org>; Sun, 12 Jul 2026 08:09:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783843780; cv=none; b=FcF+utGOyPPtTM14WxtfaHtLrRub7jzfA6fJ5wzpOu3qb8ppQwN9zH9Mlw/PsDctKEp8ROOhQdLOyDT4EPNA5guUHhuo/JT/ZV+1daOFSnAfwwNjuzwm5Hy3ZhXWcpBVeN+DoomWcKDQTX26OdcIV26BRs/GY9G1q7+shi05BjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783843780; c=relaxed/simple;
	bh=1/h0853WPj4v9Xa/Ikld7lLSrbwCPyDbQ05j6cpCsgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngR7PSeLAVVy7V2zVit5UWBH8AOyhnXOEwHsTqwoQdfBbAXsLrBODsyoA6k6zvCJ67ALq3CbXs6UUYegT80s2hMAc2S7b4PLmYDbsH9IsNYJ5OFZsro3M/TMthKpaU+1AKfUqehNVhxbW9NW2Eg14fPd0WjpXkgy+DRciNH2TiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=IzlypMh7; arc=none smtp.client-ip=194.117.254.33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=1/h0
	853WPj4v9Xa/Ikld7lLSrbwCPyDbQ05j6cpCsgw=; b=IzlypMh74eMkR4Km+/Uh
	ZQQTQQ2T3/qN9/HYVBuOvqjMCWKBeF8EjVpcm/bklPxGCHMFAgsuMGOoS316bx3b
	8YkvMtOAO1pFQLp4TAr0JTceM1LAYgwnvyhvEre0T0S6wllJ2D0dnRGMNPWDT4HZ
	L8tc1JXRy84uWooUcQ+kN1P++5COS66V7dcurNSxRWm11uwmwMHXXkpYhLr7O96y
	C641b5DYX3ozd0nfCpA72EUmOlbpxCL46oo2x/wORP2sz9P8/f8PRfaSNHBcKbvX
	mPIO56oix1xmhlMZnHBbG4jlTG0vMxa/acU07p54f1neMtgO6dnt5HR6IheYlE2e
	4A==
Received: (qmail 2158249 invoked from network); 12 Jul 2026 10:09:33 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Jul 2026 10:09:33 +0200
X-UD-Smtp-Session: l3s3148p1@RTtpfmVWxuAujnun
Date: Sun, 12 Jul 2026 10:09:32 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Cc: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pascal EBERHARD <pascal.eberhard@se.com>,
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: rng: Rename the title of the EIP-76
 file
Message-ID: <alNLvB5okFx5A9RE@shikoro>
References: <20260710-schneider-v7-2-rc1-eip76-upstream-v2-0-4eab557b0e70@bootlin.com>
 <20260710-schneider-v7-2-rc1-eip76-upstream-v2-1-4eab557b0e70@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+IS7JJhj9ssZMeKS"
Content-Disposition: inline
In-Reply-To: <20260710-schneider-v7-2-rc1-eip76-upstream-v2-1-4eab557b0e70@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[sang-engineering.com:s=k1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:miquel.raynal@bootlin.com,m:olivia@selenic.com,m:herbert@gondor.apana.org.au,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:j-choudhary@ti.com,m:thomas.petazzoni@bootlin.com,m:pascal.eberhard@se.com,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[wsa@sang-engineering.com,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[sang-engineering.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25863-lists,linux-crypto=lfdr.de,renesas];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wsa@sang-engineering.com,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[sang-engineering.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email,vger.kernel.org:from_smtp,shikoro:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 576197441CB


--+IS7JJhj9ssZMeKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 08:20:32PM +0200, Miquel Raynal (Schneider Electric=
) wrote:
> Be a little more precise in the title by giving the family name and the
> own name of the hardware block. Despite the original compatibles, this
> file describes a SafeXcel EIP-76 hardware random number generator.
>=20
> Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.=
com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Yes, more precise.

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--+IS7JJhj9ssZMeKS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpTS7gACgkQFA3kzBSg
KbYt6BAAqn+qMy4odzL4PISBY3K00+ej1VaTYy69lS7Ui3DwjZIs1SFdS/FwQLP1
scGz9UDtDFTyvqEr4ljSTvnIch7UxOSXRj/Ty1OWaU7Sw/eYUlKyA3YJA9Xci7ZM
e8O08cM/lT6iHwnepl6cDSK/NaYaSe2PCLq14hqCuB31HcOaEtmP7I2knzup3nOL
tD2Ek0y1t1Tf14QVeDMSD4eFZemf5CiULoCiopBCLzhWJ/xFUQjAuVtS5fH4546w
WdnccljZis0lAxD1Rz3aGeAng/Lwe9ebNM7P8xjm3HFUBctJcdcrczuxpfKgEmkt
cf/HT/Vrr/5DdJx/UnmeUj9Jcsjxb+Uj9B3vz7B2uUv18IvySpEXmMs+ATbknqFP
ck/i4X0VeDuu9Z3jOLx96LlcFFfXA/xlResoJHDzJRxW1dkOqZ3mco+EGPwWlQdD
ZpVe2NfaV8ZSAsNZw747KkA5V2LnRrNYRMI0RC6mkypQT/OF6f4WmbhFQ4PiS+Df
sDOFX/RxGDN5lWU01qGDpqeupY2n2NGMevJsQKRI+WhPN21Jw02h+EbwSZlIkU9o
6wkM5TuWVZHOLkUVqfiCxNEi6hyqy/znXfCJQKLIROGj/aYnsstNqP8qtKP6prCX
9ETiIcqUMc3ytNwB7FAoNFY/W3IAfNyI3TDxoIkaYXrTwKmlVQI=
=sMt2
-----END PGP SIGNATURE-----

--+IS7JJhj9ssZMeKS--


Return-Path: <linux-crypto+bounces-25864-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HZF3KLZMU2qfZgMAu9opvQ
	(envelope-from <linux-crypto+bounces-25864-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 12 Jul 2026 10:13:42 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C46744203
	for <lists+linux-crypto@lfdr.de>; Sun, 12 Jul 2026 10:13:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sang-engineering.com header.s=k1 header.b=mearCb4N;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25864-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25864-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29B333010170
	for <lists+linux-crypto@lfdr.de>; Sun, 12 Jul 2026 08:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AE7375F83;
	Sun, 12 Jul 2026 08:13:35 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EC1372EC6
	for <linux-crypto@vger.kernel.org>; Sun, 12 Jul 2026 08:13:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783844015; cv=none; b=qhPI/qkkpYIYtW3cm5/mAMf/W/9FSaa9eOBJ5YP4nLvgBu/z81akV8cuTwVJ+3TKtAfNdBBwVz3h/DTlTyLuCDDp2k5SSI7IlwGgWt62zPm9c8bDVJboqxW7KnPJMphuHVtHFIpFqCZF5Zmxj1GU9HR0d0wQCwnCEgpsdCe0O60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783844015; c=relaxed/simple;
	bh=HJd/iyE1L08rvgqBeJSEVBvoYo+Y5iwJ7CrdeDu+mQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDpHn9GSdtfV9gExhCIKeaBYOQb6/NvZl6ZWt9JiUQ0hcdxf7NJ/m1KFWe04OYkOTlmQQ2jHx9BO5xDdLy70B4EUyeT0d6qflqZWf2nx4bVcQrmcwxNd7/ak2xEmRN16gCWIBcy9kwyQ42Q+bzmv+XUVv8ZIC3IwkojApwWjp+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=mearCb4N; arc=none smtp.client-ip=194.117.254.33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=HJd/
	iyE1L08rvgqBeJSEVBvoYo+Y5iwJ7CrdeDu+mQo=; b=mearCb4NG7+DUb1Zp5EZ
	BcesaZp9IZ/wDmjuxZ3Ev9hA//yR3u10f4qYzQmU3ld2nq04ir41T70vHjyOAtGz
	1sQhB/3XDWji9QSg5SebEt1ESkcSfcOckQ2sqGwZujSN3Mfwe8C8j0HzgqQLJokY
	kPk0awVwGeu1iH3kxE18+nuNG6uIoXPa+X7HGPdkjKY+fhM+zp2gp9x43yEI6aTQ
	k1COp5N71ws16cQ4URCiOgecUIZmGEHf8IUhujtAN4CESReXkYpb5Zir8l+H/SZi
	IUtFAtCxeRhq+FVT9UBVJGMJYDNJnW6jN5dOb4pM3tl3RR5ZUpDu4JDFz7g79PKB
	uQ==
Received: (qmail 2159428 invoked from network); 12 Jul 2026 10:13:30 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Jul 2026 10:13:30 +0200
X-UD-Smtp-Session: l3s3148p1@x+eQjGVW6Lsujnun
Date: Sun, 12 Jul 2026 10:13:30 +0200
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
Subject: Re: [PATCH v2 2/2] hwrng: omap: Enable on Renesas RZ/N1D
Message-ID: <alNMqvOy5DEz_4nf@shikoro>
References: <20260710-schneider-v7-2-rc1-eip76-upstream-v2-0-4eab557b0e70@bootlin.com>
 <20260710-schneider-v7-2-rc1-eip76-upstream-v2-2-4eab557b0e70@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HvtI8ZeixoIEYXu9"
Content-Disposition: inline
In-Reply-To: <20260710-schneider-v7-2-rc1-eip76-upstream-v2-2-4eab557b0e70@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[sang-engineering.com:s=k1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:miquel.raynal@bootlin.com,m:olivia@selenic.com,m:herbert@gondor.apana.org.au,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:j-choudhary@ti.com,m:thomas.petazzoni@bootlin.com,m:pascal.eberhard@se.com,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[wsa@sang-engineering.com,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[sang-engineering.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25864-lists,linux-crypto=lfdr.de,renesas];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shikoro:mid,sang-engineering.com:from_mime,sang-engineering.com:email,sang-engineering.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8C46744203


--HvtI8ZeixoIEYXu9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 08:20:33PM +0200, Miquel Raynal (Schneider Electric=
) wrote:
> The Kconfig symbol and associated seem to be badly named as they have
> nothing OMAP specific but instead refer to Inside Secure Safexcel
> devices which have been used in many SoCs from different
> manufacturers (like OMAP, Marvell but also eg. Renesas).
>=20
> The Renesas RZ/N1D features this IP, so add this architecture to the
> dependency allow list. In practice this dependency list does not seem
> very relevant and could be entirely dropped, given the fact that this IP
> has been implemented by many different vendors and seems to be
> architecture agnostic.

I thought the same. But I am also fine with adding one more:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--HvtI8ZeixoIEYXu9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpTTKoACgkQFA3kzBSg
KbaTMw//cwOJonuD2ZlfeuRusk00ZjdhM/N/aDKZxt/JTatIS4kWvQDwZwQSzdMD
h+HJstrlCW8MseQ4k12KJOpqs2H7Qd7wVvaNUTDJnSIeb6JqiRobqq59HItwTfp7
6EP7JuDtX8VCXaUf+WdNg90zpGn4BQ6IshiuWJJuuVceHNlnTbVywMl90CjX2VVl
IQiyuSEOuV5K37bvSmldtnfdqikin6k5tl+adi6dtWXsw/MkIwE5DwSBs6b6vahW
2ydth49rXR1qPY+TuMFfSs10aHl5Jm8AfADZNv6RMrTyJ/wi5K5EBRrYYP5imfV1
oMnFGmWwxIqjRZpKvvdhX7OvFLmZc+zvw3fdSKF2sq06Iv2Udaa+VuFw/CsqJu4/
YZ4l8t7vgrUBTBk6Tc6wESKIzygKSCdCrorA41KwFYI05Borcm0IOhSHaF+/fehB
RSD/tzH9X3h/4O/GnjVFK91gt/7AjOMzJV3nbi8UmqjBDIt3G7UVTqF+rL5MGbfB
jUkfr/6pUiayDJ3YBxaylc1ac2kgMJs8xuGnhsqduOi/T5PBble9uQa81W8jFynK
agWs3QC80bvpJVzmsJf7wUUrqKD28DTSNvitwA44g5G0ICdE7iVdiSMXze/OskwD
tyn8VNwLNoa82ooQPfegiCUHo+cSA1MA6aOL//Tk1uJh1iaYN54=
=0RyS
-----END PGP SIGNATURE-----

--HvtI8ZeixoIEYXu9--


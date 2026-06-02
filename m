Return-Path: <linux-crypto+bounces-24833-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WD3jOXIOH2otewAAu9opvQ
	(envelope-from <linux-crypto+bounces-24833-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 02 Jun 2026 19:10:10 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D120A6308B0
	for <lists+linux-crypto@lfdr.de>; Tue, 02 Jun 2026 19:10:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=h25FyAdp;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24833-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24833-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05FBB30069A5
	for <lists+linux-crypto@lfdr.de>; Tue,  2 Jun 2026 16:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290CD38C427;
	Tue,  2 Jun 2026 16:59:18 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121D7357D07;
	Tue,  2 Jun 2026 16:59:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419557; cv=none; b=FW12jOBw+ntiE0LPsVmGM4sNRTVpn/6MW5OtxHvVlv1w8cSpv+KuWMX/LcsXQiSdPE8vuPEd2mmBMaP1jS/uVyNq0yBz18UqzE2tckZSrTRc5MNWnoVCeYnJB35MjxWcJemFMiGEMaF5s51uiNX6j8lBZ342sIzBpp0/Y94OGrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419557; c=relaxed/simple;
	bh=P8hsqb49G0SN50czZNQWl8HIQ19BJZjUwz9RXuVw6ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raw0nHQd6mvqwz5T2PpKvH6s1fEDK2W4Awtabn8BYbSl9NsEq15PAUBnYwXTqHzIwfSJOQkZWoAXJhr7twXtOnuwI6GJvPT/Sd/YiH/xQ5XWcWEPBqTFVvksuK3NV2o0ITYKufbEMjBspFWy8qMFF8nhBE2jqr5ZFNDQxSDMPhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h25FyAdp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFA31F00893;
	Tue,  2 Jun 2026 16:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780419556;
	bh=ihjvTG8bUTk74TyBzjsPKCeSdhfuewiWVtTZyub5lgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h25FyAdpjOyBvIhtUfhmSSFlSrFgDlY2smeHP10ztP3mMHzWcrGKEmTWvVYwI8ZMs
	 UpGh/GyGGAHzx1kDczQUKqBv+imRWL2zApjpjuwhQvudIEA8UwO68OWRwE1C1fK9mq
	 Uj3uI7opHVS+XlOE+IQoFDAPO8BtjmF8P49nYjXnKBffyc/GIL0ysw/H96gfrodtGt
	 KMqCOVHjvFrlrBSWaC5VkpnWIqMYoSvy9DbHI7CHNC1VkxsjUyvkNMWmwVyuDq/her
	 rtRzQO6gT1ZjNQ7p34mgVytoH77lgda3dGdSffBIsA5qTuaRjcyzpQn8tWy7lR/0Iz
	 GiBPEmzHl0Yyw==
Date: Tue, 2 Jun 2026 17:59:12 +0100
From: Conor Dooley <conor@kernel.org>
To: "lianfeng.ouyang" <lianfeng.ouyang@starfivetech.com>
Cc: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: rng: starfive,jh7110-trng: add
 jhb100, drop jh8100
Message-ID: <20260602-staple-rehire-00045d4cb667@spud>
References: <20260601093744.84210-1-lianfeng.ouyang@starfivetech.com>
 <20260601093744.84210-2-lianfeng.ouyang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TcxcuW3GM/PibzPD"
Content-Disposition: inline
In-Reply-To: <20260601093744.84210-2-lianfeng.ouyang@starfivetech.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24833-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lianfeng.ouyang@starfivetech.com,m:olivia@selenic.com,m:herbert@gondor.apana.org.au,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:p.zabel@pengutronix.de,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[conor@kernel.org,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,spud:mid,starfivetech.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D120A6308B0


--TcxcuW3GM/PibzPD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 01, 2026 at 05:37:43PM +0800, lianfeng.ouyang wrote:
> From: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
>=20
> - Drop "starfive,jh8100-trng" since JH8100 SoC is no longer
>   supported
> - Add "starfive,jhb100-trng" for the JHB100 SoC TRNG.
> - Update maintainer to current owner
>=20
> Signed-off-by: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

Although, commit messages really should not be bullet point lists,
please keep that in mind for the future.

--TcxcuW3GM/PibzPD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCah8L4AAKCRB4tDGHoIJi
0pvPAP48c69zeUJZcxblJ2W9Dl/b5QIv7K3GBR22LJXNAsuvnwD+J3e4mzRolRhB
8oCZVxOOzoXm17S6Rrlr+ocxLq++pA4=
=EXL0
-----END PGP SIGNATURE-----

--TcxcuW3GM/PibzPD--


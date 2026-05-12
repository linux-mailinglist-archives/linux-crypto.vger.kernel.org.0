Return-Path: <linux-crypto+bounces-23972-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wArZLiJjA2oq5gEAu9opvQ
	(envelope-from <linux-crypto+bounces-23972-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 12 May 2026 19:28:02 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEAF525D08
	for <lists+linux-crypto@lfdr.de>; Tue, 12 May 2026 19:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4EBE93094ED6
	for <lists+linux-crypto@lfdr.de>; Tue, 12 May 2026 17:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19E43D79F9;
	Tue, 12 May 2026 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NR5LIg70"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914173D5C29;
	Tue, 12 May 2026 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778606112; cv=none; b=kCY99tjD7UZNUWDx8KYK7m25mzZAisqKwlWxTkXskbp97x7dud+03WG+5x0k8OvlILQDC8EIHWWXrj27+eLOohmhVC1XYkk9XfQTGLOYKJ/4S0zaVTQ7N/rmwz+5SVLkwbcK7bCEJoTl0R7poGwkMWA/P1dm3ztY4eDwoyqQcQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778606112; c=relaxed/simple;
	bh=ep93CDl4nn734nWNxmF1I9r2iyKXnDKuCzqoraqtGrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NL81Hypqx1YbnZ/ohKgbv65MTGID+ftCIxnPnafJA4CMoYUjUHCBHRuyatbWKIBeNoZXvJ1tt8x3pLiwnf4xh4EbHqEg2C8nCVRrgYQHUt1Kx9AEJJggrMVFdXrxOnHZrvZUvu1bQR+6EWgKcimyBFnc0WkUdJVopkzxST9bqDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NR5LIg70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EE3C2BCB0;
	Tue, 12 May 2026 17:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778606112;
	bh=ep93CDl4nn734nWNxmF1I9r2iyKXnDKuCzqoraqtGrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NR5LIg700su+JAsrKRexnZMTLxagb3ZhNcs1d0+zmNAMOkEUslcCPH8kBUy0ga2my
	 HXoCfKPYzppxV+IPXNOJhpWsS3eCkRDnOUEonyak3NH9WkOmj5tcBQTgLnCGK8uXF1
	 t801pWCqg546p/Hyzvg+Me8dvcU3JMECgzCuSaeNTiAU+ajpzq9nnQbm6yfNB24jhv
	 EXBP6ShY3Ulwudb887tuEsEhOyflcqD2CBvml6FLtcEIdG5/krBHiiZ4IKdfkz2pvW
	 5Z2mRIX43um7wqHYKH19mm74zlu07AKmtE9r+tYQq1Vu5nZjBdzdCLHbLXhgpFpI3O
	 z6vtoDmysk7xw==
Date: Tue, 12 May 2026 18:15:07 +0100
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
Subject: Re: [PATCH v1 1/2] dt-bindings: Add bindings for StarFive JHB100 SoC
 trng controller.
Message-ID: <20260512-seventeen-deduct-fa7eead281ef@spud>
References: <20260512062404.4540-1-lianfeng.ouyang@starfivetech.com>
 <20260512062404.4540-2-lianfeng.ouyang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rOdvJ2xqvy0gb4XE"
Content-Disposition: inline
In-Reply-To: <20260512062404.4540-2-lianfeng.ouyang@starfivetech.com>
X-Rspamd-Queue-Id: CDEAF525D08
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[starfivetech.com:server fail,sin.lore.kernel.org:server fail];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-23972-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,starfivetech.com:email]
X-Rspamd-Action: no action


--rOdvJ2xqvy0gb4XE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 02:24:03PM +0800, lianfeng.ouyang wrote:
> From: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
>=20
> Signed-off-by: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
> ---
>  Documentation/devicetree/bindings/rng/starfive,jh7110-trng.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/rng/starfive,jh7110-trng.y=
aml b/Documentation/devicetree/bindings/rng/starfive,jh7110-trng.yaml
> index 4639247e9e51..11346d77b2f6 100644
> --- a/Documentation/devicetree/bindings/rng/starfive,jh7110-trng.yaml
> +++ b/Documentation/devicetree/bindings/rng/starfive,jh7110-trng.yaml
> @@ -13,8 +13,8 @@ properties:
>    compatible:
>      oneOf:
>        - items:
> -          - const: starfive,jh8100-trng
>            - const: starfive,jh7110-trng
> +          - const: starfive,jhb100-trng

You need to add a commit message here explaining why removing the jh8100
is okay.
pw-bot: changes-requested

>        - const: starfive,jh7110-trng
> =20
>    reg:
> --=20
> 2.43.0
>=20
>=20

--rOdvJ2xqvy0gb4XE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagNgGwAKCRB4tDGHoIJi
0mqkAP4yj9VMhN6pcb7sydjcsP4jbFwPsGl1fQMJhMd2G5cvNwEA4ctH4F2i6lAN
JyRWH7LxV8wcG89RrElP4a5GF9EW+w0=
=kyDE
-----END PGP SIGNATURE-----

--rOdvJ2xqvy0gb4XE--


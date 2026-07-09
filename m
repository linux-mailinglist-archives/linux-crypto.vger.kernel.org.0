Return-Path: <linux-crypto+bounces-25759-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hOq+DAFJT2oPdgIAu9opvQ
	(envelope-from <linux-crypto+bounces-25759-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 09 Jul 2026 09:08:49 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9780E72D76E
	for <lists+linux-crypto@lfdr.de>; Thu, 09 Jul 2026 09:08:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sntech.de header.s=gloria202408 header.b=wzpkFYTS;
	dmarc=pass (policy=quarantine) header.from=sntech.de;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25759-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25759-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF90E300C818
	for <lists+linux-crypto@lfdr.de>; Thu,  9 Jul 2026 07:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FB73B38AF;
	Thu,  9 Jul 2026 07:07:50 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73D3233955;
	Thu,  9 Jul 2026 07:07:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783580870; cv=none; b=qRc1UkOV8SdYMaFya6XcxFSI7knIDEBgVNAGmVsI7SG3C7S6yAvb89DGOAAZbKFCASEpjsMkq8Tje6ZNjUxyHjmL8kh6Uk4mNTqNepvQfOBIJ+fheFmy2Ucx5jElMfh4LnA3zX/gz92hGHdTqJhOb5K0icQJc/VTJQVL5s+4gog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783580870; c=relaxed/simple;
	bh=dr+5FgGKUdCueZyGgCiTv2gSI67Cx1yifBwDoBjQuXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gb458e/jPHSH9YTbSGB+KHpWDsWd+pcq2POw1scjKkKm8wnlmTZaQ4bipcQomAZbCk6ILURIsCCSNfV32YI02gp37pKCHLUepPjAauu2E18UA9I8ICJ5DghOgu+BBVUN58L1vjDuY8SvVPjxpjzn8UFf9tOGTWiWBjEJR92G46g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=wzpkFYTS; arc=none smtp.client-ip=185.11.138.130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=pdSw+G21z2NrE5iHKTKAJzseZhloGwIrHZmDJjo4p4c=; b=wzpkFYTSB2o038W334C7hu8s9v
	7+L3+hqneJ1n9ursKNn/qF9aAa80jolpgMvJtb93jbbHpRHdG7+hl4Hfgwotw3LsMcvvE7NGnbpHi
	9bFxj2FYvyUZbgVxteLRtrPMAZUOt0YENy0Hg9DFimz1NYygsj0BXE2v77IoA+8H4/3fPk0tX6Qai
	9MNf5M9KYENWFUWpkudTS1bInIn8spWFtpDgqpeTmTaYvRRZrzRS3ULHq7/RMFB+tahmMaQ2B0uXo
	l5z9MVr1Xc+4GJPPZKcA1sh1Xo4ASqn09/xQX2HsOyMt+jqVybBUP0gYe8w8Vm4iOpudzcyPjxnsF
	08GKkryQ==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Dawid Olesinski <dawidro@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Corentin Labbe <clabbe@baylibre.com>, linux-crypto@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 3/4] arm64: dts: rockchip: Add crypto node to rk356x-base
Date: Thu, 09 Jul 2026 09:07:23 +0200
Message-ID: <4011768.FjKLVJYuhi@diego>
In-Reply-To: <ak7jEYTAGgeDdi1W@venus>
References:
 <20260708175837.1718437-1-dawidro@gmail.com>
 <20260708175837.1718437-4-dawidro@gmail.com> <ak7jEYTAGgeDdi1W@venus>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dawidro@gmail.com,m:sebastian.reichel@collabora.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:clabbe@baylibre.com,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[heiko@sntech.de,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,collabora.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25759-lists,linux-crypto=lfdr.de];
	DKIM_TRACE(0.00)[sntech.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,linux-crypto@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9780E72D76E

Am Donnerstag, 9. Juli 2026, 01:56:10 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb Sebastian Reichel:
> Hi,
>=20
> On Wed, Jul 08, 2026 at 06:58:24PM +0100, Dawid Olesinski wrote:
> > Add the device tree node for the V2 cryptographic hardware accelerator
> > on RK356x SoCs (RK3566, RK3568).
> >=20
> > The IP block sits in the non-secure peripheral domain. Its three clocks
> > (core, aclk, hclk) and reset line are accessible directly through the
> > main non-secure CRU, so no firmware intermediary is required.
> >=20
> > The node is disabled by default; board files that wish to use hardware
> > crypto offload must enable it.
>=20
> Why is it disabled by default? It doesn't seem to be board specific
> at all to me (the same question applies to the RK3588 DT).

You're definitly right about that ... there are no board specific resources
needed, so Dawid please drop the status from both nodes.


Heiko

> >=20
> > Signed-off-by: Dawid Olesinski <dawidro@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64=
/boot/dts/rockchip/rk356x-base.dtsi
> > index a5832895bd39..9de7e7487ca1 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> > @@ -1112,6 +1112,18 @@ sdhci: mmc@fe310000 {
> >  		status =3D "disabled";
> >  	};
> > =20
> > +	crypto: crypto@fe380000 {
> > +		compatible =3D "rockchip,rk3568-crypto";
> > +		reg =3D <0x0 0xfe380000 0x0 0x2000>;
> > +		interrupts =3D <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> > +		clocks =3D <&cru CLK_CRYPTO_NS_CORE>, <&cru ACLK_CRYPTO_NS>,
> > +			 <&cru HCLK_CRYPTO_NS>;
> > +		clock-names =3D "core", "aclk", "hclk";
> > +		resets =3D <&cru SRST_CRYPTO_NS_CORE>;
> > +		reset-names =3D "core";
> > +		status =3D "disabled";
> > +	};
> > +
> >  	/*
> >  	 * Testing showed that the HWRNG found in RK3566 produces unacceptably
> >  	 * low quality of random data, so the HWRNG isn't enabled for all RK3=
56x
>=20






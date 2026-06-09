Return-Path: <linux-crypto+bounces-25000-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id piH0GCw+KGqDAwMAu9opvQ
	(envelope-from <linux-crypto+bounces-25000-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 09 Jun 2026 18:24:12 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD05662514
	for <lists+linux-crypto@lfdr.de>; Tue, 09 Jun 2026 18:24:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=S+PTFrEE;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25000-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25000-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FB4131D28F2
	for <lists+linux-crypto@lfdr.de>; Tue,  9 Jun 2026 16:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A81379C38;
	Tue,  9 Jun 2026 16:13:10 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24259377EBA;
	Tue,  9 Jun 2026 16:13:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021590; cv=none; b=jFIwsu17Ug8vLw1V+VIUoLOAGtsMMm6i+/lJPemUReDWzXHai3c6WX7I1sj9ibBsfSeMOKP59Sbl79rqFF8yIVXQkeDnTyQttc5Pu0bSjjgdgIcgyHj41IH+nPb5HIqcgC0UynmJgZRL1aJnHtehhjCW2/7/jcMmPejZn4N96Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021590; c=relaxed/simple;
	bh=n8UWQHRfngrNcosp9Oy8IoumVeE29kBIVStca2EBYuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpR5g+xadCc21Gd0n+lmxEI+6DeugOdCbv9/UPmfFQ0PUyLf+QKq16r4tp5v0hDkik/6LGpAn8FGqtFcc/QZsy/IsIqBHvDOeIRq2NfYqScIBThEyw/F1QhP9oW3TgS2p6wCxN7HKekAQcIPgOQRhTXFJfi2xrRln3etToJGVTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+PTFrEE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C081F00893;
	Tue,  9 Jun 2026 16:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781021588;
	bh=n8UWQHRfngrNcosp9Oy8IoumVeE29kBIVStca2EBYuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S+PTFrEEQ1Qr5Zmy5zxS99GhWZ4ByQEAXix22Kr+j3zKvXHCJmdfEwyXl1It9D4Rb
	 jwqwejWp+Kt8UuF9OeHUtf7JiQiT2eWtAnPW9dVJfoXP+uZwXn4HjRQfrcQWqm5wQL
	 GhkKeZcTAqdIpgiu6XLWQeaavaIRBvj1yk4paoRAFItc1fRuJhQa4TL9RZ4JSp/NAr
	 Muc9B5LFhNtdKl/XLkDbapJSA4tjzBbjMyJywSUR7wMTJu/NUTHsh2iZmGlxOz8HFn
	 MvsynBkCe+qXuBdLhFBPDItIaMSJZK8F1NzBhSRaf6fp9jfWwEXnvA5jZWT6rmYwjQ
	 qqIGPwNzGelBw==
Date: Tue, 9 Jun 2026 17:13:04 +0100
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
Subject: Re: [PATCH v4 1/2] dt-bindings: rng: starfive,jh7110-trng: add
 jhb100, drop jh8100
Message-ID: <20260609-prefix-eastward-f98bb6be1a69@spud>
References: <20260609095726.160559-1-lianfeng.ouyang@starfivetech.com>
 <20260609095726.160559-2-lianfeng.ouyang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VRZzHBdtYtMenYE5"
Content-Disposition: inline
In-Reply-To: <20260609095726.160559-2-lianfeng.ouyang@starfivetech.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25000-lists,linux-crypto=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[conor@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:lianfeng.ouyang@starfivetech.com,m:olivia@selenic.com,m:herbert@gondor.apana.org.au,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:p.zabel@pengutronix.de,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[spud:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ADD05662514


--VRZzHBdtYtMenYE5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--VRZzHBdtYtMenYE5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaig7kAAKCRB4tDGHoIJi
0hlMAQDYh1ptYp8Yx8p3qOU2dirZCNlVM91riYnsIVmJzMywjgEA+wl7n/zjaltD
z91QmKM+M2zJiUe1nKeXbmFbCpxRRwc=
=9lAQ
-----END PGP SIGNATURE-----

--VRZzHBdtYtMenYE5--


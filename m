Return-Path: <linux-crypto+bounces-20472-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IK1dG8nfe2lyJAIAu9opvQ
	(envelope-from <linux-crypto+bounces-20472-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 29 Jan 2026 23:31:37 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E47B5577
	for <lists+linux-crypto@lfdr.de>; Thu, 29 Jan 2026 23:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA5243004DC7
	for <lists+linux-crypto@lfdr.de>; Thu, 29 Jan 2026 22:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F69368282;
	Thu, 29 Jan 2026 22:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="maXuXDBD"
X-Original-To: linux-crypto@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB3E2C3256;
	Thu, 29 Jan 2026 22:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769725891; cv=none; b=eLC4pqOnR0f3C+s4PmhZoMNzBb26z4OgCHPeNVUsjAutFlylHtuc5kAhudgqXLhGzonG8EqrhsRj2aip0q1I4z2KSCSC8YZpkdJcmDjpK+VHpWGUkfnrtKSNvCo/u9Sxjcgy58qYPZ9VGj/33tgYiVtaxRt5KU8rwvOAV7sJhEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769725891; c=relaxed/simple;
	bh=XeDMpJ65mp+98QISIa6zGzqYGRyHyE/0c63dQ1J//No=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C6Xt06ye0+IDjsRH17jr2xSaEr3rN4gMzhUt28HFc0jvMyY2bhO68SJUgA1mqhEGvA1w4OzHdlmJwa/6tRi6XBgCM67xyUUeqbZvB4gCRgWYAY04HE1QwAdmppXQ4nn4P+pVfpgMt+9viYcw1JK5fYS0xbbY6j1aZn7RwgIQ/2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=maXuXDBD; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1769725886;
	bh=XeDMpJ65mp+98QISIa6zGzqYGRyHyE/0c63dQ1J//No=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=maXuXDBDY5E82w+PEupDgyz4HMJpbKuw1UzO+dIkS5jxTm1C/okzqrlbeKVwP5/2u
	 Qmlwe1QlE+tToivLA+Co71fnsoyIwW+7Ac7wb/oLse0BIQHmHL1b4kESpKUryAJSH5
	 zz1AYVHdKrtJxdw68fXAgjGC3zdLRRl+DqEIzH7+zSxuwZgFryX4FpjGLfaHjLSBnh
	 N4LG5nd9/2dhd4+30p/dIoCMLGZn24TWDGPOKEniU5PKzNcg2d1CNTXMLAUg1Az/hM
	 20YqxQthcjTdbkupxPsQgS4k/x+Blm/TSTl02Q1sKw5XjzbabaZ9c7kQExTjo8WmXj
	 K0yNxc7jhe70g==
Received: from [192.168.68.117] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 679D860035;
	Fri, 30 Jan 2026 06:31:25 +0800 (AWST)
Message-ID: <547396d9f2aaea032fa62e7adcafb423a9467446.camel@codeconstruct.com.au>
Subject: Re: [PATCH RFC 05/16] ARM: dts: aspeed: Remove unspecified LPC host
 controller node
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,  Linus Walleij <linusw@kernel.org>, Joel Stanley
 <joel@jms.id.au>, linux-hwmon@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, 	openbmc@lists.ozlabs.org,
 linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-iio@vger.kernel.org
Date: Fri, 30 Jan 2026 09:01:20 +1030
In-Reply-To: <CAL_JsqJxfVaLqzTwm7iEvc4maBzVvpc-i5uD6CZRtiv+V+7+1Q@mail.gmail.com>
References: 
	<20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
	 <20251211-dev-dt-warnings-all-v1-5-21b18b9ada77@codeconstruct.com.au>
	 <CAL_JsqJxfVaLqzTwm7iEvc4maBzVvpc-i5uD6CZRtiv+V+7+1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20472-lists,linux-crypto=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@codeconstruct.com.au,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18E47B5577
X-Rspamd-Action: no action

On Thu, 2026-01-29 at 09:16 -0600, Rob Herring wrote:
> On Thu, Dec 11, 2025 at 2:46=E2=80=AFAM Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
> >=20
> > For the AST2500 the node was used for pinctrl purposes, and while
> > the
> > hardware capability is also present in the AST2400 and AST2600, the
> > their pinctrl no relationship to it. Further, there's no
> > corresponding
> > binding, remove the node for now to
> > eliminate the warnings.
>=20
> Odd line break.

Ha. The preceding sentence is also a mess. Not sure what happened
there. I've extracted the pinctrl-related patches to their own series
locally, I'll send that out when I have a moment.

Andrew


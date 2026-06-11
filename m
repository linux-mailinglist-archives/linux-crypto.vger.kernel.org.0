Return-Path: <linux-crypto+bounces-25069-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5FoXNU93KmqwpwMAu9opvQ
	(envelope-from <linux-crypto+bounces-25069-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 10:52:31 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5613667009F
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 10:52:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=D+zVFGlY;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25069-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25069-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1AAA3210C6C
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 08:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DEF30C366;
	Thu, 11 Jun 2026 08:49:32 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB6A1A6806;
	Thu, 11 Jun 2026 08:49:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167771; cv=none; b=sq2wZzyZey/QfldelN1fll0Zv2/mqKn/xEUlQJAEgfoolUD+htlJI7Xy5rwluHp8N+BGbBbK90jbBEwWKZuaaDnoHRytxjao0vE9FkIebBfa6oBiyDr+l03JKo5lgS+war6khgKBmoD6GuOoFbKwURZBCIu9Bw6qa+bVf4MeETQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167771; c=relaxed/simple;
	bh=E1Gr1Id4w3mQ5K1sQxgzJR9XvmddJt0qNOu3eB+wJs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVROY3revT1IUFBrxzkMw9b0Rb/Fr4h+GuzKr0TmFtOme6iGZQu1CP5kohMl51pFfpPe6mZ9VHWJwPXu4l38N8VvWQ5KojUTU25oHR3pm8hz6xkdhZsnWyU47lMrQWiyLovKfrwidwMZsfchjGrBF690jmn9aeay4JmNOc4L4mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=D+zVFGlY; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=mjrPPBq+iR4nnSkwtllKiL42WjmcB34JK/l+415Ki0c=; 
	b=D+zVFGlYVBiAlCc+qMJqwMjeeX27SaN7ui+bRf5XgLO1qdr5xH3LJ3PpF13CZDsMDT7cWQB4Yay
	PMcfuIrOC9tOyZzO4g74R52TPN9cWtkMi4Y6HpxITewMspw4xOVKyi4f0oS8dMXmjryrEKtJ8mwnN
	L96by4VuAvPAyIO+xzFFyVMn6Ynp/EBdq/dwUrv3mMejw1OEZgeZYbxcmMJ0EFO3wuqdZA+QehUwA
	M7nKdbxyMzkz3J0bJeXkUzhFu/w33VCFxD1goHWWxNN/6ujoIhxShyyksnwrt/6GFcxXXTaa9d+Df
	ig6MF0/i53VK2V9A6gS5fPN+rdqPp6FSppLg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wXb6N-00000004XVq-0UA2;
	Thu, 11 Jun 2026 16:49:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 11 Jun 2026 16:49:27 +0800
Date: Thu, 11 Jun 2026 16:49:27 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mounika Botcha <mounika.botcha@amd.com>,
	Harsh Jain <h.jain@amd.com>, Olivia Mackall <olivia@selenic.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] Xilinx TRNG fix and simplification
Message-ID: <aip2l1pwMY4UDBdA@gondor.apana.org.au>
References: <20260531191738.55843-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531191738.55843-1-ebiggers@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25069-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mounika.botcha@amd.com,m:h.jain@amd.com,m:olivia@selenic.com,m:michal.simek@amd.com,m:linux-arm-kernel@lists.infradead.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,apana.org.au:url,apana.org.au:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5613667009F

On Sun, May 31, 2026 at 12:17:34PM -0700, Eric Biggers wrote:
> This series fixes and greatly simplifies the Xilinx TRNG driver by:
> 
> - Removing the gratuitous crypto_rng interface, leaving just hwrng which
>   is the one that actually matters.
> 
> - Replacing the really complicated AES based entropy extraction
>   algorithm with a much simpler one.
> 
> Note that this mirrors similar changes in other drivers.
> 
> Eric Biggers (4):
>   crypto: xilinx-trng - Remove crypto_rng interface
>   crypto: xilinx-trng - Fix return value of xtrng_hwrng_trng_read()
>   crypto: xilinx-trng - Replace crypto_drbg_ctr_df() with HMAC-SHA512
>   hwrng: xilinx - Move xilinx-rng into drivers/char/hw_random/
> 
>  MAINTAINERS                                   |   2 +-
>  arch/arm64/configs/defconfig                  |   2 +-
>  crypto/Kconfig                                |   5 -
>  crypto/Makefile                               |   2 -
>  crypto/df_sp80090a.c                          | 222 ------------------
>  drivers/char/hw_random/Kconfig                |  11 +
>  drivers/char/hw_random/Makefile               |   1 +
>  .../xilinx => char/hw_random}/xilinx-trng.c   | 134 ++---------
>  drivers/crypto/Kconfig                        |  13 -
>  drivers/crypto/xilinx/Makefile                |   1 -
>  include/crypto/df_sp80090a.h                  |  53 -----
>  11 files changed, 37 insertions(+), 409 deletions(-)
>  delete mode 100644 crypto/df_sp80090a.c
>  rename drivers/{crypto/xilinx => char/hw_random}/xilinx-trng.c (75%)
>  delete mode 100644 include/crypto/df_sp80090a.h
> 
> 
> base-commit: 5624ea54f3ba5c83d2e5503411a31a8be0278c1e
> prerequisite-patch-id: 07e982b663ac3f8312ca524f6b91b5b38661df5e
> prerequisite-patch-id: 72064361a8f36e015ab0b7e1fa4d364b40d90506
> prerequisite-patch-id: 8978b8e0db7f47935e5f6f0aff14a97f55d3073c
> prerequisite-patch-id: 6aa0e3e93a008279d71e535a3d0cf48643f55e19
> -- 
> 2.54.0

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


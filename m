Return-Path: <linux-crypto+bounces-25068-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SFNQODJ3KmqfpwMAu9opvQ
	(envelope-from <linux-crypto+bounces-25068-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 10:52:02 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 493DF670087
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 10:52:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=cg1X5iXa;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25068-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25068-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CD17319654F
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 08:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE8D368276;
	Thu, 11 Jun 2026 08:49:14 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3026C3D76;
	Thu, 11 Jun 2026 08:49:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167754; cv=none; b=t2Gpn2ISq0NxleBKObBFQn9zyqVBGo5GrDw4PDhFdu9CRhVa+tQIV+8XlAtTmSGXhgTDND6LKsHogkLt56Jn5+E17Oq18Hd3wWo+yFdLfoJpznRo4ev/y3olmNKHzcOfbw3QaAMGVABvZLm+QwfmMBC1D5TssRQcyMC47O75e3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167754; c=relaxed/simple;
	bh=Sh8DtzAtEaaONFPu8J7mdOxs8YqBVuZ8faYzps/SF+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lziXAl3tLIR5RbxF2s5l3AbRjWa7zLxZUd4jPsZzfACKlw3snLNFxPVkY79ciXuvtvAVM+qzxR7PC7bdjTZt8O754IcPk17kfFKGaouLDRkxaiG4MLKrZY2TmHF78t0HPAsoXGKg0C9Ip8XzbuzxqDSAvVvJxh13BP6VxC2u+AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=cg1X5iXa; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=Vxnwla4AZxmN0V+dRHGleQO3LIjMPtj8WL9mYuCfzic=; 
	b=cg1X5iXaonOWKvS23sHFkuP/Z9or91ujEXWbUd2E8NPidijV0j+lJcYiMXnkpUeHpvZtGuMIJU8
	DZJgo1BPgVN/pJpxFlb7A3w1K1cQ1/HEMku83F49vTkaAbbpHUaTGM7u5CAz2UH2FFYUsWceJ2YNH
	yqM2/SotzBVWGcr3RDifFBRsV6hGOEWODSdlkIUPgNrXwNrj5+yz/VQGow8FLNeQanQiaePsU4yJA
	S3g3e9+EC7uCVuR4M9Z2/y7NlSsDwapGRb0KSsiABgR9sZE9ORdmOpqJKhPrtBYFMTcLGn4+BKCmN
	I2ha+od5kDt5fF91WRfR4DItZOAGAJhG2raQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wXb65-00000004XVI-2vpu;
	Thu, 11 Jun 2026 16:49:10 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 11 Jun 2026 16:49:09 +0800
Date: Thu, 11 Jun 2026 16:49:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: exynos-rng - Remove exynos-rng driver
Message-ID: <aip2hV8tlSNL3zpM@gondor.apana.org.au>
References: <20260531175932.32171-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531175932.32171-1-ebiggers@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25068-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:linux-crypto@vger.kernel.org,m:linux-samsung-soc@vger.kernel.org,m:krzk@kernel.org,m:alim.akhtar@samsung.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,apana.org.au:url,apana.org.au:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 493DF670087

On Sun, May 31, 2026 at 10:59:31AM -0700, Eric Biggers wrote:
> This driver has no purpose.  It doesn't feed into the Linux RNG, nor
> does it implement the hwrng interface.  It is accessible only via the
> "rng" algorithm type of AF_ALG, which isn't used in practice.  Everyone
> uses either the Linux RNG, or rarely /dev/hwrng.
> 
> Moreover, this is a PRNG whose only source of entropy is the 160-bit
> seed the user passes in.  So this can be used only by a user who already
> has a source of cryptographically secure random numbers, such as
> /dev/random.  Which they can, and do, just use in the first place.
> 
> Just remove this driver.  There's no need to keep useless code around.
> 
> Note that the other crypto_rng drivers in drivers/crypto/ are similarly
> unused and are being removed too.  This commit just handles exynos-rng.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  MAINTAINERS                         |   8 -
>  arch/arm/configs/exynos_defconfig   |   1 -
>  arch/arm/configs/multi_v7_defconfig |   1 -
>  drivers/crypto/Kconfig              |  18 --
>  drivers/crypto/Makefile             |   1 -
>  drivers/crypto/exynos-rng.c         | 399 ----------------------------
>  6 files changed, 428 deletions(-)
>  delete mode 100644 drivers/crypto/exynos-rng.c

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


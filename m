Return-Path: <linux-crypto+bounces-25023-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H5BeCqivKWr6bwMAu9opvQ
	(envelope-from <linux-crypto+bounces-25023-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Jun 2026 20:40:40 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A39CE66C553
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Jun 2026 20:40:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=L1ObFPr2;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25023-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25023-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 887BB31CA93E
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Jun 2026 18:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B76356742;
	Wed, 10 Jun 2026 18:39:05 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB73134D901;
	Wed, 10 Jun 2026 18:39:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781116745; cv=none; b=rnwaKcR8FhV+BrjtLDgCylkEtFQgG8LiEU8aips/VEbqFtlMFBjCFNyfOvOHdIqWdqx4CFCDrn1Dvfc7/ymvaYJIVE+QPEs9V4SHNr6MzVu04UbambkZigSG2EAA3DR1O7OzCnLGQy48p+hq2bYyHO/Hgd/JWSuk22Aj5BzmmFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781116745; c=relaxed/simple;
	bh=GxMar0oLEIQoe7sHtEEfoKoR0HEcjBy+/l3pVm1wND8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFCVGnNzWYgejpEOzB4ZPX5+64K0DQixJ6qnEI5vGhajbKvHT9JcHTy1aMf8h6LJl/tAQ6a61KZph0iZ5EGqWmGzMWd5YRDn07GCUC97tNKS32SmxH/nk9aLc/MQe2jv7VSaImiqYv8ixMsTGTu1+4ihpZ0IN7KSyaHqcyhU86Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1ObFPr2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DC01F00893;
	Wed, 10 Jun 2026 18:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781116744;
	bh=4o1VtWCXoWoxZBd6EawCUnJfQ/1lp18t/RARZHM0h5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L1ObFPr2OvgTYrOIIO4/YtP6lSqMh682GiOhOkJWrOkn11BH1KN8+D4dLayTtyAQk
	 OCKltKKSoaFudM5UTbZ+sDqvJaKgF28LSWLxitUx48re7IN69YoiqhAv4HE7aKihIh
	 +XbGlAD2J3OJ+EZixK+Wo8iw8K4CDmoLOe6pazU99tWs+FmU0aQMs8QPKLuPd74MHr
	 w9hezWha/VMuYab5un8ehjztSILHjkRN9dG/0/4SoZ9dQxe4+t+NbkaUDyKD2FemYq
	 IwsHPk29AfT229gyPnvy6kNFwH4JnlrUTfsyf8BymvScuBdBtvXClCOzC7Z+Q/4Ui3
	 qm9lGdnlcUozw==
Date: Wed, 10 Jun 2026 18:39:02 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
	linux-samsung-soc@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: exynos-rng - Remove exynos-rng driver
Message-ID: <20260610183902.GA1158828@google.com>
References: <20260531175932.32171-1-ebiggers@kernel.org>
 <CADrjBPo3BpSk49oasf_9g06xrBMkw+NiKo10xDKjWr8sJ+Zc-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrjBPo3BpSk49oasf_9g06xrBMkw+NiKo10xDKjWr8sJ+Zc-Q@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25023-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:peter.griffin@linaro.org,m:linux-crypto@vger.kernel.org,m:herbert@gondor.apana.org.au,m:linux-samsung-soc@vger.kernel.org,m:krzk@kernel.org,m:alim.akhtar@samsung.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-crypto];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A39CE66C553

On Wed, Jun 10, 2026 at 03:46:54PM +0100, Peter Griffin wrote:
> Hi Eric,
> 
> On Sun, 31 May 2026 at 19:02, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > This driver has no purpose.  It doesn't feed into the Linux RNG, nor
> > does it implement the hwrng interface.  It is accessible only via the
> > "rng" algorithm type of AF_ALG, which isn't used in practice.  Everyone
> > uses either the Linux RNG, or rarely /dev/hwrng.
> >
> > Moreover, this is a PRNG whose only source of entropy is the 160-bit
> > seed the user passes in.  So this can be used only by a user who already
> > has a source of cryptographically secure random numbers, such as
> > /dev/random.  Which they can, and do, just use in the first place.
> >
> > Just remove this driver.  There's no need to keep useless code around.
> >
> > Note that the other crypto_rng drivers in drivers/crypto/ are similarly
> > unused and are being removed too.  This commit just handles exynos-rng.
> >
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > ---
> 
> If the driver is being removed, should the binding documentation for
> this driver not also be deleted (see
> Documentation/devicetree/bindings/rng/samsung,exynos4-rng.yaml)?
> 
> Peter

In other discussions I've been told that devicetree bindings are
hardware descriptions that should still exist even if there is no
driver.  It doesn't make a lot of sense, but it seems to be what the
devicetree people want.  I expect there would be objections to removing
this binding.

- Eric


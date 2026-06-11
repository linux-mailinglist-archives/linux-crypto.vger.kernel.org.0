Return-Path: <linux-crypto+bounces-25093-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0wuaE9YeK2ri2wMAu9opvQ
	(envelope-from <linux-crypto+bounces-25093-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 22:47:18 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D438E6754B3
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 22:47:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EQCnh2FC;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25093-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25093-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54DFD313F623
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 20:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F36A4CA28D;
	Thu, 11 Jun 2026 20:47:05 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4292639F188;
	Thu, 11 Jun 2026 20:47:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210825; cv=none; b=a3tiqEwX3+hRqHx/CoJ6+S8vDXY4WBCoBLwSHTwze/ywrdJaGmIvJJrLkVOd/wFPXZ98g27A9ND6f/bdY+ill2rLzvfj6m5zSfiGUyuD0jdDxGDg9FnQRaCQC/qEGJtEmY6kTfjldnl+/QXrPNQUfdDm9mU6UqFFRgspbIUBtAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210825; c=relaxed/simple;
	bh=IyYRxRg3MeYz33vBBG8MyxsFl8rxieoHXQRP3G6L9aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGj/K8gIMMFm+yD1zQAi4VGArrN1BO4KFmUFUe8VkP7aXNCE2eU+OoFYjJmOqAV71/Oebww0u8Do1WGrBdOQTM+Gw6yQzM0MSzgr6WGZ1aAhgQxpBSDKxB+LIFcI79J+2tksK6LqNsbOFNyeQghnznG3ItPSUTEV7Kxybvu9AeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQCnh2FC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E216E1F00A3A;
	Thu, 11 Jun 2026 20:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781210824;
	bh=8YUgGB7unUfuXaH5pfE121ZOgCzzrH9HhF5tOcGI554=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EQCnh2FCvEu1io2MpQW3qyrOqoiUSUjMnJfNKoZ8lIPcGe9MTiL0FTk8rFl+/fHqW
	 GdN0/DVHIaFEf+cdJzNxt7riig00q+HHX21wZ6pn2wDTxbhLUs10yH82aYCqHL9sTl
	 QUencz6XOI2GALaBOpNWB3WImqzD3VZ7015Ok5i3mSJxWQPc2hBkWggQhAVAg82eT+
	 qaJAsQPmu52hJUn6kUMdJssCJNfjFl6frJ0+53waVp+Y0Xv/dh3boBwRtUcg+MTObG
	 lp3hETH5mq1QSBNXAPZOM9eiIdTIwQ9J93ZoPB6/qJWBi4MQhMzZ9uyz5FdUMjVa5D
	 hLZifhzblF8aQ==
Date: Thu, 11 Jun 2026 13:47:02 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mounika Botcha <mounika.botcha@amd.com>,
	Harsh Jain <h.jain@amd.com>, Olivia Mackall <olivia@selenic.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] Xilinx TRNG fix and simplification
Message-ID: <20260611204702.GB1747@quark>
References: <20260531191738.55843-1-ebiggers@kernel.org>
 <aip2l1pwMY4UDBdA@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aip2l1pwMY4UDBdA@gondor.apana.org.au>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mounika.botcha@amd.com,m:h.jain@amd.com,m:olivia@selenic.com,m:michal.simek@amd.com,m:linux-arm-kernel@lists.infradead.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-25093-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D438E6754B3

On Thu, Jun 11, 2026 at 04:49:27PM +0800, Herbert Xu wrote:
> On Sun, May 31, 2026 at 12:17:34PM -0700, Eric Biggers wrote:
> > This series fixes and greatly simplifies the Xilinx TRNG driver by:
> > 
> > - Removing the gratuitous crypto_rng interface, leaving just hwrng which
> >   is the one that actually matters.
> > 
> > - Replacing the really complicated AES based entropy extraction
> >   algorithm with a much simpler one.
> > 
> > Note that this mirrors similar changes in other drivers.
> > 
> > Eric Biggers (4):
> >   crypto: xilinx-trng - Remove crypto_rng interface
> >   crypto: xilinx-trng - Fix return value of xtrng_hwrng_trng_read()
> >   crypto: xilinx-trng - Replace crypto_drbg_ctr_df() with HMAC-SHA512
> >   hwrng: xilinx - Move xilinx-rng into drivers/char/hw_random/
> > 
> >  MAINTAINERS                                   |   2 +-
> >  arch/arm64/configs/defconfig                  |   2 +-
> >  crypto/Kconfig                                |   5 -
> >  crypto/Makefile                               |   2 -
> >  crypto/df_sp80090a.c                          | 222 ------------------
> >  drivers/char/hw_random/Kconfig                |  11 +
> >  drivers/char/hw_random/Makefile               |   1 +
> >  .../xilinx => char/hw_random}/xilinx-trng.c   | 134 ++---------
> >  drivers/crypto/Kconfig                        |  13 -
> >  drivers/crypto/xilinx/Makefile                |   1 -
> >  include/crypto/df_sp80090a.h                  |  53 -----
> >  11 files changed, 37 insertions(+), 409 deletions(-)
> >  delete mode 100644 crypto/df_sp80090a.c
> >  rename drivers/{crypto/xilinx => char/hw_random}/xilinx-trng.c (75%)
> >  delete mode 100644 include/crypto/df_sp80090a.h
> > 
> > 
> > base-commit: 5624ea54f3ba5c83d2e5503411a31a8be0278c1e
> > prerequisite-patch-id: 07e982b663ac3f8312ca524f6b91b5b38661df5e
> > prerequisite-patch-id: 72064361a8f36e015ab0b7e1fa4d364b40d90506
> > prerequisite-patch-id: 8978b8e0db7f47935e5f6f0aff14a97f55d3073c
> > prerequisite-patch-id: 6aa0e3e93a008279d71e535a3d0cf48643f55e19
> > -- 
> > 2.54.0
> 
> All applied.  Thanks.

Can you re-add the following to "hwrng: xilinx - Move xilinx-rng into
drivers/char/hw_random/"?  It seems you applied this before the qcom-rng
series, then dropped the drivers/char/hw_random/Makefile change rather
than resolve it.

diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
index 3e655d6e116b..95b5adb49560 100644
--- a/drivers/char/hw_random/Makefile
+++ b/drivers/char/hw_random/Makefile
@@ -51,5 +51,6 @@ obj-$(CONFIG_HW_RANDOM_XIPHERA) += xiphera-trng.o
 obj-$(CONFIG_HW_RANDOM_ARM_SMCCC_TRNG) += arm_smccc_trng.o
 obj-$(CONFIG_HW_RANDOM_CN10K) += cn10k-rng.o
 obj-$(CONFIG_HW_RANDOM_POLARFIRE_SOC) += mpfs-rng.o
 obj-$(CONFIG_HW_RANDOM_ROCKCHIP) += rockchip-rng.o
 obj-$(CONFIG_HW_RANDOM_JH7110) += jh7110-trng.o
+obj-$(CONFIG_HW_RANDOM_XILINX) += xilinx-trng.o



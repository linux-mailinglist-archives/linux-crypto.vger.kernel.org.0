Return-Path: <linux-crypto+bounces-6316-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F61961C6C
	for <lists+linux-crypto@lfdr.de>; Wed, 28 Aug 2024 04:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA921F23EB9
	for <lists+linux-crypto@lfdr.de>; Wed, 28 Aug 2024 02:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA28885956;
	Wed, 28 Aug 2024 02:59:37 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB221DA32;
	Wed, 28 Aug 2024 02:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724813977; cv=none; b=V0zGKvq9+S+eWgogyx8gpoGT7/se8Oe4b+UIPKnBlgj+dX6ax0SvCtX6EL48hz2FSfRQPD6f5JujCtbwFgsDCdk81G4n6K9nYh+PPx/+ispYE3NaDDosLASKDk5TCiiNA8f/q1glLh6+YOhWE5qncxyaHIFnMZ4eyoS3/bLTCYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724813977; c=relaxed/simple;
	bh=ZcjCrmvd1gBVBvDeDP5GKBp7eMjPg2WrhMS0Ls3M3jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9XMEYy7HUTBKrcuWIY7a17E9E4Uvw1e25FD7G3stCGBwRciB+Ti0PMjVHItvFBNJqtjHaQgOQa9QgbXRw4BuuUKTTY2pZ2uuSFO7BMuPdMCCRsKww98It1eoN4Ba5RgGSH4IEZbwHl2q+/1T7sInz35npwY0vTRcw/nCzWcaEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sj8lW-007pM5-37;
	Wed, 28 Aug 2024 10:59:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 28 Aug 2024 10:59:20 +0800
Date: Wed, 28 Aug 2024 10:59:20 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-crypto@vger.kernel.org, ltp@lists.linux.it,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [v3 PATCH 3/3] crypto: simd - Do not call crypto_alloc_tfm
 during registration
Message-ID: <Zs6SiBOdasO9Thd1@gondor.apana.org.au>
References: <ZrbTUk6DyktnO7qk@gondor.apana.org.au>
 <202408161634.598311fd-oliver.sang@intel.com>
 <ZsBJs_C6GdO_qgV7@gondor.apana.org.au>
 <ZsBJ5H4JExArHGVw@gondor.apana.org.au>
 <ZsBKG0la0m69Dyq3@gondor.apana.org.au>
 <20240827184839.GD2049@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827184839.GD2049@sol.localdomain>

On Tue, Aug 27, 2024 at 11:48:39AM -0700, Eric Biggers wrote:
> On Sat, Aug 17, 2024 at 02:58:35PM +0800, Herbert Xu wrote:
> > Algorithm registration is usually carried out during module init,
> > where as little work as possible should be carried out.  The SIMD
> > code violated this rule by allocating a tfm, this then triggers a
> > full test of the algorithm which may dead-lock in certain cases.
> > 
> > SIMD is only allocating the tfm to get at the alg object, which is
> > in fact already available as it is what we are registering.  Use
> > that directly and remove the crypto_alloc_tfm call.
> > 
> > Also remove some obsolete and unused SIMD API.
> > 
> > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> > ---
> >  arch/arm/crypto/aes-ce-glue.c     |  2 +-
> >  arch/arm/crypto/aes-neonbs-glue.c |  2 +-
> >  crypto/simd.c                     | 76 ++++++-------------------------
> >  include/crypto/internal/simd.h    | 12 +----
> >  4 files changed, 19 insertions(+), 73 deletions(-)
> > 
> 
> I'm getting a test failure with this series applied:
> 
> [    0.383128] alg: aead: failed to allocate transform for gcm_base(ctr(aes-generic),ghash-generic): -2
> [    0.383500] alg: self-tests for gcm(aes) using gcm_base(ctr(aes-generic),ghash-generic) failed (rc=-2)
> 
> This is on x86_64 with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y.

Could you please send me your config file?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


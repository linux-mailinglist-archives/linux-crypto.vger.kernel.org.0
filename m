Return-Path: <linux-crypto+bounces-6217-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF1395DE3A
	for <lists+linux-crypto@lfdr.de>; Sat, 24 Aug 2024 15:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68BF21F223FB
	for <lists+linux-crypto@lfdr.de>; Sat, 24 Aug 2024 13:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D8215098F;
	Sat, 24 Aug 2024 13:52:51 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFCB143889
	for <linux-crypto@vger.kernel.org>; Sat, 24 Aug 2024 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724507571; cv=none; b=H/lVJby9Dc9MTkJpOxdNgwU6Fr/AgkXVGxsXDDYrwDrh70hoTo+SVn/lkRZ0JRshcKpBJ2g7aqSi5k+hjktQY4VRUfMR0yy0QK1oSg623uCZ6tkkIonDyZp2qGU3GgKTV0RVrfAkjzKnrkuD5UlbEnP9LNaTvwXGh0U8ZJG3JSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724507571; c=relaxed/simple;
	bh=nYyvYtPmgQYbB5l/HKDSwZ9B0+cZQIsT24w9ydJLzi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aw2IFZgP65pyVEBQJ96iwI2ihiYupJIqlvx5dhP1wLBbi7IsrrAoMSqoHKek5YlAkyZP2ajVscs2XisksG9tEEEaS5/t8ld3drGWenu3jybMRT1F4kvgKjJLisv1Q/g1FGBYvgnOGhA+VT/4hqLtBGtl9Z6jM3aY7JkellWN1is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1shr3h-007276-0E;
	Sat, 24 Aug 2024 21:52:47 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 24 Aug 2024 21:52:46 +0800
Date: Sat, 24 Aug 2024 21:52:46 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Pavitrakumar M <pavitrakumarm@vayavyalabs.com>
Cc: linux-crypto@vger.kernel.org, dan.carpenter@linaro.org,
	Ruud.Derwig@synopsys.com, manjunath.hadli@vayavyalabs.com,
	bhoomikak@vayavyalabs.com
Subject: Re: [PATCH 1/2] Fix counter width checks
Message-ID: <ZsnlrpL27fEmR-3I@gondor.apana.org.au>
References: <20240816072650.698340-1-pavitrakumarm@vayavyalabs.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816072650.698340-1-pavitrakumarm@vayavyalabs.com>

On Fri, Aug 16, 2024 at 12:56:49PM +0530, Pavitrakumar M wrote:
> This patch fixes counter width checks according to the version extension3
> register. The counter widths can be 8, 16, 32 and 64 bits as per the
> extension3 register.
> 
> Signed-off-by: Bhoomika K <bhoomikak@vayavyalabs.com>
> Signed-off-by: Pavitrakumar M <pavitrakumarm@vayavyalabs.com>
> Acked-by: Ruud Derwig <Ruud.Derwig@synopsys.com>
> ---
>  drivers/crypto/dwc-spacc/spacc_skcipher.c | 35 ++++++++++++-----------
>  1 file changed, 19 insertions(+), 16 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


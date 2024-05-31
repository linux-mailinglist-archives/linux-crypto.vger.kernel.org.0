Return-Path: <linux-crypto+bounces-4599-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B918D5F11
	for <lists+linux-crypto@lfdr.de>; Fri, 31 May 2024 11:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8201C21FA0
	for <lists+linux-crypto@lfdr.de>; Fri, 31 May 2024 09:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01553143723;
	Fri, 31 May 2024 09:58:20 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E334D142620;
	Fri, 31 May 2024 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717149499; cv=none; b=iebSzZx72WML2XyWBycAaVsks5jzjtBsJWJXM/9vwVSolAyxMME1959HfMfljZLVB4k5yQASQZobAuCmouLVe19BbCRLnSEq+wMm6ic+CYmuaP2KId660I+MJddoFZhnb2zphogSizQFNg0kbxR13Y3CUEF7mWaJZitlJ27duiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717149499; c=relaxed/simple;
	bh=MoIZpM/uVyGNVn1IHbtjB6NAONwQFeF7I8Yo5S8olE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwxbVS33DyQfiSmhi9IuBVrUzGnNE2j8am8zXNFYxkhtFeNb1TTdNm1infkCzrkCK+XMKoSE9oeHDsRYq02i+Tt0sWm9jCq7njDfKRjLWvuAYpJnP+/beWOqiYHW36oHQI3F5pya8USTu9MdZGnxpre0SKe6Vd5QMBW7CYKtgh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sCz1V-004AHz-1p;
	Fri, 31 May 2024 17:58:10 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 31 May 2024 17:58:11 +0800
Date: Fri, 31 May 2024 17:58:11 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: linux@treblig.org
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
	sparclinux@vger.kernel.org, andreas@gaisler.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: niagara2: Remove unused struct
 'n2_skcipher_request_context'
Message-ID: <ZlmfM1rIMHUVR7Sd@gondor.apana.org.au>
References: <20240511145620.226548-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511145620.226548-1-linux@treblig.org>

On Sat, May 11, 2024 at 03:56:20PM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'n2_skcipher_request_context' was added in
> commit 23a6564a6b51 ("crypto: niagara2 - switch to skcipher API")
> but never used.
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/crypto/n2_core.c | 4 ----
>  1 file changed, 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


Return-Path: <linux-crypto+bounces-1642-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 110DB83D5D8
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jan 2024 10:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96AE3B27E92
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jan 2024 09:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8DC208D0;
	Fri, 26 Jan 2024 08:29:09 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2331BF31
	for <linux-crypto@vger.kernel.org>; Fri, 26 Jan 2024 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706257749; cv=none; b=iYdJjzxd5d3gMGkV7CHlsPCRm1AI+ZxMIVn1xnYWF8pINZtLBcGJIZt/nOq4KP36LSqlJ3oCVY0iuCuC+TTs59QvkreyyD2W8NqRmiv/qA4Sydpm1ZsaziqeBz44Pqip2wa/0vhIcYjb3mf7y212E36RO2tJic8mgrFbC5FjZxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706257749; c=relaxed/simple;
	bh=0pazT6/+PhaI5hwbDlQ0W/arHusjdRVzz573NNFeBIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsq3xxj5MsinFdnbW2JWPafGItbpGUMdycm5yWRV8GrUSBbcdXZNHIzWzcAR7y7lNMAxVICdeQanvZsuZvrNIAEZm19NuCibC7NHPtMYEoQy9ngU5PS6qbVhIZKqq8H2oBG5zQo5RwTj6KrHNO3dzZW68uDLbya5sjjy4juGuzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rTHa7-006E2p-Jc; Fri, 26 Jan 2024 16:29:00 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Jan 2024 16:29:12 +0800
Date: Fri, 26 Jan 2024 16:29:12 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Joachim Vandersmissen <git@jvdsn.com>
Cc: linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: rsa - restrict plaintext/ciphertext values more
 in FIPS mode
Message-ID: <ZbNtWAXCz5LLaIeZ@gondor.apana.org.au>
References: <20240121194901.344206-1-git@jvdsn.com>
 <ZbNKHGDiGOyIB5+S@gondor.apana.org.au>
 <b2dc028f-54e5-4992-8f8b-32cbfd072f73@jvdsn.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2dc028f-54e5-4992-8f8b-32cbfd072f73@jvdsn.com>

On Fri, Jan 26, 2024 at 12:13:00AM -0600, Joachim Vandersmissen wrote:
>
> Yes, mathematically speaking the values 1 and n - 1 aren't suitable for RSA
> (they will always be fixed points). I simply didn't want to introduce a
> breaking change. If you think a breaking change is acceptable, I can update
> the patch to replace the RFC3447 check with the stricter check.

Please do.  We can always change it later if someone complains.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


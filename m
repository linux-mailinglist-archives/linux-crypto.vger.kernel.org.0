Return-Path: <linux-crypto+bounces-5574-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD0293029E
	for <lists+linux-crypto@lfdr.de>; Sat, 13 Jul 2024 02:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB29B1F218D9
	for <lists+linux-crypto@lfdr.de>; Sat, 13 Jul 2024 00:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26687136986;
	Fri, 12 Jul 2024 23:57:43 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from norbury.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B0738DD9;
	Fri, 12 Jul 2024 23:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720828663; cv=none; b=XBurgl2DE8KUMGLucm0gtnIqlPZ3zs/R62HH0g/xYWGQbul4DgQj6Co29AGr6cdarCDFzOQvzbB/9eVE3K+k/dlKwCg3F4Us0JJ8vknlRZelBgIjVgX9y4Ono3gbxuHhX04OjProm3YfvDxosVUsnZ1rcDMzYkJb5WXuvsbilvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720828663; c=relaxed/simple;
	bh=TsY6JEfalLllqjYlHrbYXXydEB0C2MBCge+Kq6rlKf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1A43KUYR4/cB7uUVFgPxzml7bo96UIyieuKJuJ8+uoN+sY4voGvmfq7RA4OXrzXn0Xn1sD+VJ0imxj/MiqsTqfFYG68fMTaHDZ9OHTYVb0PNRnU2G2unnrxEMUS2Oq1Ph1HjeIBftp4UyWODz8We1rdJnIXwUYwfu+Oo3KPCEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
	by norbury.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sSQ8f-001q61-1p;
	Sat, 13 Jul 2024 09:57:22 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 13 Jul 2024 11:57:21 +1200
Date: Sat, 13 Jul 2024 11:57:21 +1200
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] crypto: lib/mpi: delete unnecessary condition
Message-ID: <ZpHC4VxlpycOGdOO@gondor.apana.org.au>
References: <6686bed3.4a0a0220.6aa45.6c34@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6686bed3.4a0a0220.6aa45.6c34@mx.google.com>

On Thu, Jul 04, 2024 at 10:25:05AM -0500, Dan Carpenter wrote:
> We checked that "nlimbs" is non-zero in the outside if statement so delete
> the duplicate check here.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  lib/crypto/mpi/mpi-bit.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


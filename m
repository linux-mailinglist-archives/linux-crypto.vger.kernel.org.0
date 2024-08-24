Return-Path: <linux-crypto+bounces-6214-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B950495DE34
	for <lists+linux-crypto@lfdr.de>; Sat, 24 Aug 2024 15:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76062283283
	for <lists+linux-crypto@lfdr.de>; Sat, 24 Aug 2024 13:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED951714DD;
	Sat, 24 Aug 2024 13:50:43 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3718515098F;
	Sat, 24 Aug 2024 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724507443; cv=none; b=agYMXzEug/JkssFC7hTabg3zNhyN272wqJizEDM3lj5O7DQgf9OT38vauQpHr65DRTUmI7rePh1K0cVbRjdlKj+hrHcMDvFHoJlCR7gMC8/yXMVteNEZuoi3eT3WOs0LmTzhHnUavGVIK1L4AhlofjKdubKdBORRhIPgQ63oaZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724507443; c=relaxed/simple;
	bh=2XeH6dI9Paiv3DyyDlNK8426NqKrGnFSKszijEA1+8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gASyNQLH3S6KyYY7E3xnkyGWNEik8X6U5oKvic9OS3C/gUOeonNj6+gRTe+sfzkzLBhdgAFXxB3QWTT9790bPed8tBhfNmf39E/mjYui/pGShp5HJNuccMBTo36IdJcw9P00TfxbpHnJIqsRJDFEjpxdCeZ+gcgN9zMI4JtYxL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1shr1Z-00721L-2E;
	Sat, 24 Aug 2024 21:50:35 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 24 Aug 2024 21:50:34 +0800
Date: Sat, 24 Aug 2024 21:50:34 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Pavitrakumar M <pavitrakumarm@vayavyalabs.com>,
	Bhoomika K <bhoomikak@vayavyalabs.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ruud Derwig <Ruud.Derwig@synopsys.com>,
	shwetar <shwetar@vayavyalabs.com>
Subject: Re: [PATCH 0/3] crypto: spacc - More Smatch fixes
Message-ID: <ZsnlKjlSs_gcxbgO@gondor.apana.org.au>
References: <df1ed763-0916-41e9-bdcf-a1a51c8ad88a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df1ed763-0916-41e9-bdcf-a1a51c8ad88a@stanley.mountain>

On Thu, Aug 15, 2024 at 02:19:56PM +0300, Dan Carpenter wrote:
> A few more Smatch one liner patches.
> 
> Dan Carpenter (3):
>   crypto: spacc - Fix uninitialized variable in spacc_aead_process()
>   crypto: spacc - Fix NULL vs IS_ERR() check in spacc_aead_fallback()
>   crypto: spacc - Check for allocation failure in
>     spacc_skcipher_fallback()
> 
>  drivers/crypto/dwc-spacc/spacc_aead.c     | 8 +++-----
>  drivers/crypto/dwc-spacc/spacc_skcipher.c | 2 ++
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> -- 
> 2.43.0

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


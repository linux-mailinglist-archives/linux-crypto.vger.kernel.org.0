Return-Path: <linux-crypto+bounces-3910-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 234F28B4FEC
	for <lists+linux-crypto@lfdr.de>; Mon, 29 Apr 2024 05:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8DF1F21D35
	for <lists+linux-crypto@lfdr.de>; Mon, 29 Apr 2024 03:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AB18F6C;
	Mon, 29 Apr 2024 03:39:36 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB188BEE;
	Mon, 29 Apr 2024 03:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714361976; cv=none; b=GK7VC4c6TLmjqH9NgijEnMG3Wjs+7w1LI59UsWm0yE0hvl/Vmh47rRHmSwNawEkhLL6IaK/j1q8V2xnK2sxhzterGjm4iNQ43ffr9uY5p/u5rELFhaV6qb/eH4w6Taqc+OxfAGyEypWprHon9Z7gk6+IUabC3ze/wFYhS/kyCD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714361976; c=relaxed/simple;
	bh=FaREJWqWPzE5jXZHdIFuOj2dzhTwN1KejCtwF4xk/+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=op7KIr6KM8lTRuCFenKOUdsgOdHPPErad4q+pYomklLeVLK27IS3ESk2SZ9xjhcNaYLQovvv7W7mBSNNhmA0JPjgZCAkSkH5lwA6DwEFKtzkJotxf0TQVe+HcewXCX0AGyNtg3lOOxw+OmuMfPw6WXklqkqWtGaZCLe0AmyonCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 839C23000E443;
	Mon, 29 Apr 2024 05:30:37 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 610752165EA; Mon, 29 Apr 2024 05:30:37 +0200 (CEST)
Date: Mon, 29 Apr 2024 05:30:37 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Stefan Berger <stefanb@linux.ibm.com>, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
	davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: ecc - Protect ecc_digits_from_bytes from reading
 too many bytes
Message-ID: <Zi8UXS1MD5V58dnN@wunner.de>
References: <20240426225553.3038070-1-stefanb@linux.ibm.com>
 <D0W3MTR0CY08.Q2UIYE4N274L@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D0W3MTR0CY08.Q2UIYE4N274L@kernel.org>

On Mon, Apr 29, 2024 at 01:12:00AM +0300, Jarkko Sakkinen wrote:
> On Sat Apr 27, 2024 at 1:55 AM EEST, Stefan Berger wrote:
> > Protect ecc_digits_from_bytes from reading too many bytes from the input
> > byte array in case an insufficient number of bytes is provided to fill the
> > output digit array of ndigits. Therefore, initialize the most significant
> > digits with 0 to avoid trying to read too many bytes later on.
> >
> > If too many bytes are provided on the input byte array the extra bytes
> > are ignored since the input variable 'ndigits' limits the number of digits
> > that will be filled.
> >
> > Fixes: d67c96fb97b5 ("crypto: ecdsa - Convert byte arrays with key coordinates to digits")
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> >  include/crypto/internal/ecc.h | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h
> > index 7ca1f463d1ec..56215f14ff96 100644
> > --- a/include/crypto/internal/ecc.h
> > +++ b/include/crypto/internal/ecc.h
> > @@ -67,9 +67,16 @@ static inline void ecc_swap_digits(const void *in, u64 *out, unsigned int ndigit
> >  static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
> >  					 u64 *out, unsigned int ndigits)
> >  {
> > +	int diff = ndigits - DIV_ROUND_UP(nbytes, sizeof(u64));
> >  	unsigned int o = nbytes & 7;
> >  	__be64 msd = 0;
> >  
> > +	/* diff > 0: not enough input bytes: set most significant digits to 0 */
> > +	while (diff > 0) {
> > +		out[--ndigits] = 0;
> > +		diff--;
> > +	}
> 
> Could be just trivial for-loop:
> 
> for (i = 0; i < diff; i++)
> 	out[--ndigits] = 0;
> 
> Or also simpler while-loop could work:
> 
> while (diff-- > 0)
> 	out[--ndigits] = 0;

Or just use memset(), which uses optimized instructions on many arches.


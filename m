Return-Path: <linux-crypto+bounces-2578-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8012875FEB
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Mar 2024 09:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B20284BB4
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Mar 2024 08:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFED535DF;
	Fri,  8 Mar 2024 08:42:07 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E994D5A2;
	Fri,  8 Mar 2024 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887327; cv=none; b=YrqbqRZnMd3/FNkhYYVT+nzdg2BV8N6K1pqvH7fGXhQeyfm7v4X+mYeDhKT3GT3tpzQVGzSyi5pe5u24jMeYshQ0zD9RJ8RB2IxXWn1lyLPZprTp81DeZ+TXHIC3cHaBkVLPu1SM7FPlyCEiGxUVtVt/m3oQrsqSYUuaxFpl55Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887327; c=relaxed/simple;
	bh=/slvoAHN49wbRpn5WRNcBiT9EoixUWwXrRJ1fG5Uhc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHZmxl/iTUoXkU3c66J1u6+r8K0rmm+QbxxSB/+A+fWKguhKReLvnHRWr8oyh/GoUXRB/f0S2mCPhnVAr9TiaTezKzmCvhVf4lcbzMd1FFT4BO/qYqvO1e8xtfxeM4qWtQ2ZndP1kFLGwoN16DbNv4OT6KXPboAfIbA4SL9tp8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 3DADB300034CC;
	Fri,  8 Mar 2024 09:41:55 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 26D6043C6CA; Fri,  8 Mar 2024 09:41:55 +0100 (CET)
Date: Fri, 8 Mar 2024 09:41:55 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
Subject: Re: [PATCH v5 01/12] crypto: ecdsa - Convert byte arrays with key
 coordinates to digits
Message-ID: <ZerPU6pJiosjOvDq@wunner.de>
References: <20240306222257.979304-1-stefanb@linux.ibm.com>
 <20240306222257.979304-2-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306222257.979304-2-stefanb@linux.ibm.com>

On Wed, Mar 06, 2024 at 05:22:46PM -0500, Stefan Berger wrote:
> +static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
> +					 u64 *out, unsigned int ndigits)
> +{
> +	unsigned int o = nbytes & 7;
> +	u64 msd = 0;

My sincere apologies, I made a mistake when I proposed this:
It needs to be __be64 instead of u64...

> +
> +	if (o) {
> +		memcpy((u8 *)&msd + sizeof(msd) - o, in, o);
> +		out[--ndigits] = be64_to_cpu(msd);
> +		in += o;
> +	}

...otherwise sparse complains:

    crypto/ecdsa.c: note: in included file:
    >> include/crypto/internal/ecc.h:74:34: sparse: sparse: cast to restricted __be64
    >> include/crypto/internal/ecc.h:74:34: sparse: sparse: cast to restricted __be64
    [...]
    66	static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
    67						 u64 *out, unsigned int ndigits)
    68	{
    69		unsigned int o = nbytes & 7;
    70		u64 msd = 0;
    71	
    72		if (o) {
    73			memcpy((u8 *)&msd + sizeof(msd) - o, in, o);
  > 74			out[--ndigits] = be64_to_cpu(msd);
    75			in += o;
    76		}
    77		ecc_swap_digits(in, out, ndigits);
    78	}
    79	

0-day alerted me about this, it's monitoring my GitHub repo and
I've got your patches on one of my development branches.

Thanks,

Lukas


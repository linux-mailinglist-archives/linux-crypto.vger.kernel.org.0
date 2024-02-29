Return-Path: <linux-crypto+bounces-2384-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2D486C491
	for <lists+linux-crypto@lfdr.de>; Thu, 29 Feb 2024 10:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131C1288546
	for <lists+linux-crypto@lfdr.de>; Thu, 29 Feb 2024 09:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1979A58113;
	Thu, 29 Feb 2024 09:11:18 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B355810B;
	Thu, 29 Feb 2024 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709197877; cv=none; b=nu2w3FKQC+e+q0rNrwvaMK7GfnVZmc/lumxiQWRF05hzacogfyFvK9JyeN7hB6JnKi9gNYnrZddJET7npikiDjIDOlEgZm9FhRsTrTrMdGfOsASjFYMKEtlCJRUoYMU1uTjSy0yJIGXcTN2VTQuhXGNyJ7Ckx+AaI58VK84vKAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709197877; c=relaxed/simple;
	bh=iIH1ah9G+zFyTlqxkBJJeg8/4Q1M35aDXxtZ20ZjMe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jv+j2p8G/HPM4E4JZRx7BXN2K6RskLTKN4LOUiDgbJvDRYoo/+oXFD2mSFg9V3qKZ+ivVKJB/cKKTdppR83hZgRTLjG3WMwCX3C2aQ1HsNabvufrz2yOqcJzJLLI6vTnmGR3ofiEDmxwvOixcd9zxbOm6Cqqu9YZiWg3rUddLfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id C26B4100E2018;
	Thu, 29 Feb 2024 10:11:05 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 97603527B51; Thu, 29 Feb 2024 10:11:05 +0100 (CET)
Date: Thu, 29 Feb 2024 10:11:05 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
Subject: Re: [PATCH v3 01/10] crypto: ecdsa - Convert byte arrays with key
 coordinates to digits
Message-ID: <20240229091105.GA29363@wunner.de>
References: <20240223204149.4055630-1-stefanb@linux.ibm.com>
 <20240223204149.4055630-2-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223204149.4055630-2-stefanb@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Feb 23, 2024 at 03:41:40PM -0500, Stefan Berger wrote:
> +static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
> +					 u64 *out, unsigned int ndigits)
> +{
> +	unsigned int sz = ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
> +	u8 tmp[ECC_MAX_DIGITS << ECC_DIGITS_TO_BYTES_SHIFT];
> +	unsigned int o = sz - nbytes;
> +
> +	memset(tmp, 0, o);
> +	memcpy(&tmp[o], in, nbytes);
> +	ecc_swap_digits(tmp, out, ndigits);
> +}

Copying the whole key into tmp seems inefficient.  You only need
special handling for the first few bytes of "in" (6 bytes in the
P521 case) and could use ecc_swap_digits() to convert the rest
of "in" directly to "out" without using tmp.

So it would be sufficient to allocate the first digit on the stack,
memset + memcpy, then convert that to native byte order into "in[0]"
and use ecc_swap_digits() for the rest.

And the special handling would be conditional on "!o", so is skipped
for existing curves.

Thanks,

Lukas


Return-Path: <linux-crypto+bounces-25031-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id spGBHB9IKmq4lgMAu9opvQ
	(envelope-from <linux-crypto+bounces-25031-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 07:31:11 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EC766E963
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 07:31:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=iju0Omu+;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25031-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25031-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F3853215193
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 05:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7402E5B02;
	Thu, 11 Jun 2026 05:08:10 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A378340293;
	Thu, 11 Jun 2026 05:08:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781154489; cv=none; b=S09pQWLrelSTXYglOGMtlfJG/zt3U75J6pKl2uIX+v6yePAX1zNNMtMEPsULCrOMtD4v7Nwr37qzEjUmNURRVEdZf7kqM/YmdK5HJM6/McwctmH30peL5uqjEAynjJciY2k4wpzpVsEmBWbxAPgcC7N+FyOSchTWZaBAmmylHmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781154489; c=relaxed/simple;
	bh=QuOQzKqWtSYR32qN5nAanMbXmgiPPtV1NmvqVk3Nb68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSi+AHTkNxmgSvb9/JD/xFxEiU+CIH/Om/IqOEj0FEsKOHB3yvmxk3/cttzmBEsPTkgqyKHZdoBcaUv2yHla3PoJHfNcsH+30f9NM4lZAFVxAakJI7T/Z1s2V28HlbE11L58Vc01UT+o9rvlxhs9lKr87tBdBXHkqfBS069JJBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=iju0Omu+; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=GDfClmc81kfx8tEP4oo29m8sp+Ny4s0yacmzWMf40x8=; 
	b=iju0Omu+wYeKvT+BzaaKXUgoaDf9+tb2kjnzy6ZmkrN5TifIU766lsllVR5RdfjvRunTNEMOyiK
	EQyqlog6Qr1MK2Myno6ZDcS3fmWoXkOjpaUTaKbMTjm48+UUH80Ri+KN0gShlqGN6ZtYHtsq4Lg7f
	95fSknI7BnVctegZLVSgDqcgVNoohDbLBVNReo4ZlDTYXS1bLH3A1adB3SFsF0S5t8af0odml3Ny9
	bsThv36w0eh0JYfRpPnUgTUoQYDJtZNqa0GX0uiHZ5F91O/4m75dh7i+0Qyd7YnclLAATef3j+UlU
	soA+0gX9DVkQbIwJd3/iJHdHCmRA8R15Ki4Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wXXdy-00000004TpW-1MUd;
	Thu, 11 Jun 2026 13:07:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 11 Jun 2026 13:07:54 +0800
Date: Thu, 11 Jun 2026 13:07:54 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Leonid Ravich <lravich@amazon.com>
Cc: Alasdair Kergon <agk@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Horia Geanta <horia.geanta@nxp.com>,
	Gilad Ben-Yossef <gilad@benyossef.com>,
	linux-crypto@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v3 1/4] crypto: skcipher - add per-tfm data_unit_size for
 batched requests
Message-ID: <aipCqiY-s1zYaB1d@gondor.apana.org.au>
References: <20260601085644.13026-1-lravich@amazon.com>
 <20260601085644.13026-2-lravich@amazon.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601085644.13026-2-lravich@amazon.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25031-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lravich@amazon.com,m:agk@redhat.com,m:ardb@kernel.org,m:ebiggers@kernel.org,m:axboe@kernel.dk,m:horia.geanta@nxp.com,m:gilad@benyossef.com,m:linux-crypto@vger.kernel.org,m:dm-devel@lists.linux.dev,m:linux-block@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:url,apana.org.au:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15EC766E963

On Mon, Jun 01, 2026 at 08:56:41AM +0000, Leonid Ravich wrote:
>
> diff --git a/crypto/skcipher.c b/crypto/skcipher.c
> index 2b31d1d5d268..bc37bd554aec 100644
> --- a/crypto/skcipher.c
> +++ b/crypto/skcipher.c
> @@ -432,13 +432,119 @@ int crypto_skcipher_setkey(struct crypto_skcipher *tfm, const u8 *key,
>  }
>  EXPORT_SYMBOL_GPL(crypto_skcipher_setkey);
>  
> +int crypto_skcipher_set_data_unit_size(struct crypto_skcipher *tfm,
> +				       unsigned int data_unit_size)
> +{
> +	unsigned int blocksize;
> +
> +	if (!data_unit_size) {
> +		tfm->data_unit_size = 0;
> +		return 0;
> +	}
> +
> +	if (!crypto_skcipher_supports_multi_data_unit(tfm))
> +		return -EOPNOTSUPP;
> +
> +	blocksize = crypto_skcipher_blocksize(tfm);
> +	if (data_unit_size < blocksize || data_unit_size % blocksize)
> +		return -EINVAL;
> +
> +	tfm->data_unit_size = data_unit_size;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(crypto_skcipher_set_data_unit_size);

The unit size should be a per-request attribute, not per tfm.

> @@ -492,6 +517,66 @@ static inline unsigned int crypto_lskcipher_chunksize(
>  	return crypto_lskcipher_alg(tfm)->co.chunksize;
>  }
>  
> +/**
> + * crypto_skcipher_supports_multi_data_unit() - test multi-data-unit support
> + * @tfm: cipher handle
> + *
> + * Return: true if the algorithm advertises that it can process multiple
> + *	   data units in a single skcipher_request.
> + */
> +static inline bool
> +crypto_skcipher_supports_multi_data_unit(struct crypto_skcipher *tfm)
> +{
> +	return crypto_skcipher_alg_common(tfm)->base.cra_flags &
> +		CRYPTO_ALG_SKCIPHER_MULTI_DATA_UNIT;
> +}

My preference is to always use multi-unit submission if the user
is capable of doing it.  The Crypto API should automatically divide
up the units if the underlying driver does not support it.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


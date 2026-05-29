Return-Path: <linux-crypto+bounces-24692-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PSBGKUgGWqnqggAu9opvQ
	(envelope-from <linux-crypto+bounces-24692-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 29 May 2026 07:14:13 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7805FD45B
	for <lists+linux-crypto@lfdr.de>; Fri, 29 May 2026 07:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9BEB3031C8A
	for <lists+linux-crypto@lfdr.de>; Fri, 29 May 2026 05:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157FD39EF2E;
	Fri, 29 May 2026 05:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="l+SXrurF"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C45330BF6B;
	Fri, 29 May 2026 05:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780031646; cv=none; b=C/Kg87Q5aMYq8dcaqtkZfwZFYwD4IaWTlbJ7hK1NW4xXjRnGG5hYTQ0LH+SmLimMiv4ILjkkayjmX1qrAYQRxKBfwAB4U6wJWyi9ymp97ReJcNkzkUQzFri6E1o2n3yAkDwha4pyb9F680q/wFQDMAS+qyYOEdg3v9iKwQrs32Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780031646; c=relaxed/simple;
	bh=UFMo0NT5u3oV2nbxOjppJE/m5+ueDKvsHcxxhjnJNUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEHt+t+RcUjJ45puVUMhLGkl5OtG/TsdSL0LBKg2APXCTH5+6f32vguVHOh2iC5kGW+gMEYiPcY4q1G99OU8UtvfVRG5zX8px2Zd84I007Ez4/RQl5d14N1NRbCfomxwtfSwU/8LZNu//uFZ3vV0W0guhm0t4ORbubf9A5vuBDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=l+SXrurF; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=ejnJEa04ufm0qiqr5vvfERz7zFDVeMyDyKBO45XGNNs=; 
	b=l+SXrurFZNSFfxzRWOXn1qGbzeUWZljEz2fLjUpNZqj9SjJyra8M/EAIsFpi7661ilaZWXl4gDr
	Kqqes0e+CPv5m+iHr+zxp3ZLOUuLRlwRucUYaNTA70MDr5Ynw7pHY/AL8uvICD5BY4hddqa4mvJRg
	OhryXwlG3UW5XsvBhR+7MpebE3frmZReIPkt1eV4KPuHwKBCLSyVzw5D8o+0nSsf7YohGBmA2J0wq
	nL9THBgZaj9OnEC1zzCoTl7UwmTjcecmNIIF3aVmftb6qmqfJQ3bC0tC0q9nGX76x6Sm1EH0gyRq+
	TpljVntyUv7Lh0ooOfv7WF3ZUfI6HujO4+dg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wSpXi-000cbW-2N;
	Fri, 29 May 2026 13:13:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 29 May 2026 13:13:58 +0800
Date: Fri, 29 May 2026 13:13:58 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Max Clinton <maxtclinton@gmail.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, davem@davemloft.net,
	security@kernel.org, stable@kernel.org
Subject: Re: [PATCH] crypto: algif_skcipher - snapshot IV for async skcipher
 requests
Message-ID: <ahkglg0M4sCt3Et4@gondor.apana.org.au>
References: <agp9Hc71Z3lGF_zu@gondor.apana.org.au>
 <20260518233538.705966-2-maxtclinton@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518233538.705966-2-maxtclinton@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24692-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,apana.org.au:url,apana.org.au:email,gondor.apana.org.au:mid,gondor.apana.org.au:dkim]
X-Rspamd-Queue-Id: BE7805FD45B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 07:35:39PM -0400, Max Clinton wrote:
>
> diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
> index ba0a17fd9..519ff8d17 100644
> --- a/crypto/algif_skcipher.c
> +++ b/crypto/algif_skcipher.c
> @@ -23,6 +23,7 @@
>   * the RX SGL release.
>   */
>  
> +#include <crypto/internal/skcipher.h>

There is no need for the internal header.

> @@ -116,10 +119,14 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
>  
>  	/* Allocate cipher request for current operation. */
>  	areq = af_alg_alloc_areq(sk, sizeof(struct af_alg_async_req) +
> -				     crypto_skcipher_reqsize(tfm));
> +				     crypto_skcipher_reqsize(tfm) + ivsize);
>  	if (IS_ERR(areq))
>  		return PTR_ERR(areq);
>  
> +	iv = (u8 *)skcipher_request_ctx(&areq->cra_u.skcipher_req) +
> +	     crypto_skcipher_reqsize(tfm);

You can rewrite this as

	iv = (u8 *)(areq + 1) + crypto_skcipher_reqsize(tfm);

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


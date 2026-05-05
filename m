Return-Path: <linux-crypto+bounces-23722-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGI1NYSw+Wld/AIAu9opvQ
	(envelope-from <linux-crypto+bounces-23722-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 05 May 2026 10:55:32 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 400714C8F5F
	for <lists+linux-crypto@lfdr.de>; Tue, 05 May 2026 10:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C7E23055C3F
	for <lists+linux-crypto@lfdr.de>; Tue,  5 May 2026 08:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FB33164DF;
	Tue,  5 May 2026 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="jqlivJif"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C0930C632
	for <linux-crypto@vger.kernel.org>; Tue,  5 May 2026 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971062; cv=none; b=NFKzpcS6KWqU5IJ1xkq0mHnLrUq3elfyIklMgFH5Re6JhOV4e8O4ZMTgMrEs7YjbwmxDle8bTg7OgnVrvDS5whDAHfInCuAMY4pOUbHXZY/DuikahNgGYezI4Ammm/Z+poRhgjJA2OHoM0fne/DH1cIFeTC9gDMecF+g6BvBZgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971062; c=relaxed/simple;
	bh=Oo0NjITjhNPiOzo4ibZQVD5LZPnyHviUBe6pR2/Vfec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAD5vMARQ5YCS1969dkOgj72aF9ESV09ClTniDVNT5zFlNP+TnppTEcg0oGtBmciL+ofv8/2rFBvm/IJd7Ngi6LyDjeI9J26q8cF7ycQfmAkWguPNwCF3Y9/bgwHFA88XhLI2c39WMZLRyBCHQS+Pa33t0gClBhBNYHYmi+Or3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=jqlivJif; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=G7AlGtQ6kalc9B+qkfaX0+2gnGZmq/bYpL4SsN8H2S8=; 
	b=jqlivJifwXsSpYRWvfzPZFM2EkAVIYdF41tthY4aXnMulYKeUlrl46c6E8ajLqnOAnkPGhHBGxo
	HR484gUzSbLFHsP/6ipYIGjPhneRCckRasRG1QPOhBpq87RWJH21qu4KFihbs3BUtMnDV3yn1Z8oi
	1ICoZv7k0J1b72eBYV3v3T5FlMNe6GRHC/lWygj6vvw4LPViGZLUIa8+vAkqWj3BNYtz8PK8lahP4
	Mb5TzSRXmCyzA/2vCNuZugoIhBkiIiRqjGxkHrsLP6uLIPx4oEYAVIxGZp4RVphxutmRrD0CkXvKn
	IfaUwsqyfvKj6iimu5UfqBaSIdRgnb2ruubw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wKBUY-00BN9S-06;
	Tue, 05 May 2026 16:50:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 05 May 2026 16:50:58 +0800
Date: Tue, 5 May 2026 16:50:58 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-crypto@vger.kernel.org, ebiggers@kernel.org
Subject: Re: [PATCH] crypto: Drop unused cipher_null crypto_alg
Message-ID: <afmvctO4ZaqtAw3b@gondor.apana.org.au>
References: <20260420094120.5167-1-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420094120.5167-1-ardb@kernel.org>
X-Rspamd-Queue-Id: 400714C8F5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-23722-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,apana.org.au:url,apana.org.au:email]

On Mon, Apr 20, 2026 at 11:41:20AM +0200, Ard Biesheuvel wrote:
> The cipher_null crypto_alg cipher is never used in a meaningful way,
> given that it is always wrapped in ecb(), which has its own dedicated
> implementation. IOW, the cipher_null crypto_alg should never be used to
> implement the ecb(cipher_null) skcipher, and using it for other things
> is bogus.
> 
> However, it is accessible from user space, and due to the nature of the
> AF_ALG interface, it may be wrapped in arbitrary ways, exposing issues
> in template code that wasn't written with block ciphers with a block
> size of '1' in mind.
> 
> So drop this code.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  crypto/crypto_null.c | 35 ++------------------
>  1 file changed, 2 insertions(+), 33 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


Return-Path: <linux-crypto+bounces-23417-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UM5rG7NI72lO/wAAu9opvQ
	(envelope-from <linux-crypto+bounces-23417-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Apr 2026 13:29:55 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD8D471BB0
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Apr 2026 13:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04FA7300C0C9
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Apr 2026 11:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E703BA229;
	Mon, 27 Apr 2026 11:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="ogM+TnHg"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4BC3B95E9;
	Mon, 27 Apr 2026 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289332; cv=none; b=SQLy/s/c2kx08fOa3cJ2M/DZyXrHjyM7RQNt/9nB3GiPTFY9G9WBnZggINaxFRLE74BlN8uUWoDruOsZ37yrwzLP+H3HEtJxu7om96uJtSDijFzk2FATWfPFnl9pVC587tKIfUajxhL+12rdlUPiWYPJoHCaMcV/u/kwDAc8JxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289332; c=relaxed/simple;
	bh=6gWBj4MisYKhDfsbHiaLJojsUblIjuWUd7K92c1FoxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jY2frZwhqlQ6Rec6FxWTlw8yc8kRglj5DJnboH0gozle7wpJyi0/Ni0EbJzrRs1ifB0wc8qn6I/qmAgiYthU5j0F0FHfeyBFADKghblCI0QcKPYUZ3dcZAeajSXSHA1uH5T/5C1A0TbDHD+gZmOAdzYBAxi/ANXNQ0yL3I9rCGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=ogM+TnHg; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=Q2WgKfm0cGry8eeTwOrg1RLcJogo1MlMGaF3VYoKO8s=; 
	b=ogM+TnHgh35jEAIkTveVlZUu6YYUmA4+wu5AVyVLaqltXMbjvl1HSOOegfIAR3fhoykihq9SCYS
	CBKEbzMGep+5Dhnexk+d8ntsXtHSeqwAbWxYQs28RYQV8dR4hgnfvsEEt+zDDmLhCQ36Ccv9upvwT
	UmigHjMEQW3jaUK5lA0oVrpGUxUVow4+YXYkgqdw9SBb8S3GOxRKDzP3DbClsEuxP8B7Vv8ZSd2u+
	NChv/dnEZyv6QkKhnbmgRCsDAYileMmxKP7CKHJS/SYEvf5Lo8M+QWF5oCPiYXYfhHIaRSj5zf9TM
	Xpcqs2ZDZ509C9wr7eFpi07F6GCgOOeLy70Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wHK8O-00991v-12;
	Mon, 27 Apr 2026 19:28:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 27 Apr 2026 19:28:16 +0800
Date: Mon, 27 Apr 2026 19:28:16 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Leonid Ravich <lravich@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Alasdair Kergon <agk@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Horia Geanta <horia.geanta@nxp.com>,
	Gilad Ben-Yossef <gilad@benyossef.com>,
	linux-crypto@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: Re: [RFC] crypto: skcipher multi-data-unit requests for dm-crypt
Message-ID: <ae9IUN0lOMkijDyw@gondor.apana.org.au>
References: <20260427095622.27799-1-lravich@amazon.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095622.27799-1-lravich@amazon.com>
X-Rspamd-Queue-Id: 4DD8D471BB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23417-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,apana.org.au:url,apana.org.au:email]

On Mon, Apr 27, 2026 at 09:56:22AM +0000, Leonid Ravich wrote:
>
> Proposal
> ========
> 
> Add a data_unit_size field to struct skcipher_request:
> 
>   struct skcipher_request {
>       unsigned int cryptlen;
>       u8 *iv;
>       struct scatterlist *src;
>       struct scatterlist *dst;
> +     unsigned int data_unit_size;
>       struct crypto_async_request base;
>       void *__ctx[] CRYPTO_MINALIGN_ATTR;
>   };
> 
> When data_unit_size is 0, behavior is unchanged (cryptlen is one
> data unit). When data_unit_size is nonzero, cryptlen must be a
> multiple of data_unit_size. The IV applies to the first data unit.
> The crypto driver is responsible for incrementing the tweak per
> data unit according to the mode.
> 
> This mirrors the data_unit_size concept already present in struct
> blk_crypto_config for inline encryption. In blk-crypto the size
> is a property of the key configuration. Here it is per-request
> because dm-crypt may use different sector sizes across different
> device-mapper tables sharing the same tfm.

Yes I'm happy with this since it could also work for IPsec.

But before you invest too much energy in it it would be helpful
if you can get some proof-of-concept performance numbers so that
your effort is not wasted down the track.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


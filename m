Return-Path: <linux-crypto+bounces-20620-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CoxJADIhWnAGAQAu9opvQ
	(envelope-from <linux-crypto+bounces-20620-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 06 Feb 2026 11:52:48 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8542FCD73
	for <lists+linux-crypto@lfdr.de>; Fri, 06 Feb 2026 11:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09424303A875
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Feb 2026 10:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC4E36E484;
	Fri,  6 Feb 2026 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="rp+5wXTU"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAFC32ED57;
	Fri,  6 Feb 2026 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770374988; cv=none; b=oLqElMLRoGVX6RReTY5BkzLFPrxRYoZ2P5i332TtxoPDZCtUhv9ckTnLiz1wSiaCoLEtN4BD+jrN3KoaDzz5SQHHCqn4lKr7ZbVL2Ib9fJ+x3ObcI6IOG1Mh8EUGfEEjZnF0JfzHKSHnP4KbVWYqTS3eiTL1L/yOhvROHiZc7I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770374988; c=relaxed/simple;
	bh=l995j+rK09mRzsGE1cyVZJVehiDXew53h1za83Pkdxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8u0/y4OqbjRekhq41YuD7aW7hvHGbhIz8nnbqMmDwtlzgJ4aUx+nGU+wxVWnV+uevosvoPNevZO/kE+NhjM8mZcsW3vV+YDEEN7v3Psgc+VPr7aQ1nK9cxujMZHxJfeqLkXOK7LqyIjCzSaQ3MP1K52DY4UjTjZYvYQYzR+NSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=rp+5wXTU; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=ptcmndYEG1F6l9iVKWQB0jX78266KfWSXC+PhYUkJiY=; 
	b=rp+5wXTUE69Xxrg+403LV08mJKMDJk6CMXofHVSo2AKrRWwNVx5A4LOs/8hpR9ciT6FSHKZNYnF
	A4QqpZeBNqO3etWuChHwkLHFEmtY6NdGfxvZMdOYawZLx0PSEX6yKh2ahySDa3liWzGIpWzJLc4AG
	Sgb/64W9FD5bUuHP/aH0At/zU6ApBpPqZkoEGv3xl7oYFafgPVuXsvdr47lNBFNtOJyuXtBQAzBiT
	PNFJ+g7Z0eD8oRpNaX2EjhhDv1ec1OO9Vo5CLxRF1s3bvcoIkf3ZixzyRxAXQyKuOFc+SR/wqIyTN
	Xqekxb9BTYixAbLAcn6u/Yjl72JSumBdnifg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1voJOt-004zKU-0W;
	Fri, 06 Feb 2026 18:49:24 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 06 Feb 2026 18:49:23 +0800
Date: Fri, 6 Feb 2026 18:49:23 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org,
	yosry.ahmed@linux.dev, nphamcs@gmail.com, chengming.zhou@linux.dev,
	usamaarif642@gmail.com, ryan.roberts@arm.com, 21cnbao@gmail.com,
	ying.huang@linux.alibaba.com, akpm@linux-foundation.org,
	senozhatsky@chromium.org, sj@kernel.org, kasong@tencent.com,
	linux-crypto@vger.kernel.org, davem@davemloft.net,
	clabbe@baylibre.com, ardb@kernel.org, ebiggers@google.com,
	surenb@google.com, kristen.c.accardi@intel.com,
	vinicius.gomes@intel.com, giovanni.cabiddu@intel.com,
	wajdi.k.feghali@intel.com
Subject: Re: [PATCH v14 12/26] crypto: iaa - Rearchitect iaa_crypto to have
 clean interfaces with crypto_acomp.
Message-ID: <aYXHM4mGlj9y2XXM@gondor.apana.org.au>
References: <20260125033537.334628-1-kanchana.p.sridhar@intel.com>
 <20260125033537.334628-13-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125033537.334628-13-kanchana.p.sridhar@intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,gmail.com,arm.com,linux.alibaba.com,linux-foundation.org,chromium.org,kernel.org,tencent.com,davemloft.net,baylibre.com,google.com,intel.com];
	TAGGED_FROM(0.00)[bounces-20620-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gondor.apana.org.au:mid,gondor.apana.org.au:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:url,apana.org.au:email]
X-Rspamd-Queue-Id: D8542FCD73
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 07:35:23PM -0800, Kanchana P Sridhar wrote:
>
> +static int iaa_crypto_acomp_init_fixed(struct crypto_acomp *acomp_tfm)
>  {
>  	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
>  	struct iaa_compression_ctx *ctx = crypto_tfm_ctx(tfm);
>  
> -	ctx->mode = IAA_MODE_FIXED;
> -
> -	compression_ctx_init(ctx);
> +	ctx = iaa_ctx[IAA_MODE_FIXED];

Gcc warns about ctx as this line does nothing.  What is meant to
initialize?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


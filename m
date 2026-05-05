Return-Path: <linux-crypto+bounces-23727-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sD5FF3a4+WmNBAMAu9opvQ
	(envelope-from <linux-crypto+bounces-23727-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 05 May 2026 11:29:26 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FBA4C9ADA
	for <lists+linux-crypto@lfdr.de>; Tue, 05 May 2026 11:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A1C73051ABF
	for <lists+linux-crypto@lfdr.de>; Tue,  5 May 2026 09:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653D031AA87;
	Tue,  5 May 2026 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="ZEd7Q3th"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08F33164C5;
	Tue,  5 May 2026 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973071; cv=none; b=WnHzAQpTaGOTEkIoE47ELdf24Aabbi/tWobPMuUXtaqSTiTL2Jo91GN23neEZDfndvAl1Pk1jsxN6EQliHl2c4X8Y9tdPv4VQ2lYq+Re48pxGRTf6g3pupZJlSD38AHwWF9pvYNW4Myjv4Boq1nYFABU5OnuTTB+X8rN5MdW3tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973071; c=relaxed/simple;
	bh=UH5ccZrjiJrKCBRLejFTIknd1qhu917a+wPTo+ZyK6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLS/wfPZmFzbvhcuuZT09ODDIaxJjkJaYDII18TaiwTZQw0ycamzulqnpBBH3Zjbbb1u0ywgE9sWw8ubwNYESqwEUVGEj+4EetIQV4CyF7+7ZpWcGzfpM2dc2h0y+4Cxe+mhZzYhOU47t4V9rqpH71NsHjOR6mVyzqAqB6asdb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=ZEd7Q3th; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=AQeNCS6wC+YzY1oGOiHUG65CiDfkMKsi4NUVtsUQM9s=; 
	b=ZEd7Q3th2nNYd9oYnLUbOlLJb0QKCue74llDuhg/nGK+sqQU+8Aa6nrHysw4CfVhpovnCCllMYX
	6171488JItu/NZjHPZ8SaY4gIrAnwAR0OG575lJH5J3VFLYGpAUHgWncp/SdCfGuYCp8yn2NQw1YK
	yPYDbu5H/SUexra8AaqesTsS8L0g4ui8zo57tVyAcfhDlTAn2Iq0ePe0vR4wvYp5dWrQv0R7N25XS
	P0zkjBZCBItkyNoMyA3fQbKn0Mwm7/lq7TdaWJhnGTV2nAA+Q3sjGeyCd70p5pVsVLvAn1USlgoGC
	vouNU9SOsaHskQ6pO5j4NE4llgpC/9CnKf3A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wKC0l-00BNpG-1p;
	Tue, 05 May 2026 17:24:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 05 May 2026 17:24:15 +0800
Date: Tue, 5 May 2026 17:24:15 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Corentin Labbe <clabbe@baylibre.com>, linux-crypto@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
	"David S . Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crypto: ixp4xx - fix buffer chain unwind on
 allocation failure
Message-ID: <afm3P2vtZAPdIK0x@gondor.apana.org.au>
References: <20260423111956.185761-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423111956.185761-1-ruoyuw560@gmail.com>
X-Rspamd-Queue-Id: B1FBA4C9ADA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23727-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gondor.apana.org.au:dkim,gondor.apana.org.au:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:url,apana.org.au:email]

On Thu, Apr 23, 2026 at 07:19:56PM +0800, Ruoyu Wang wrote:
> chainup_buffers() builds a linked list of buffer descriptors for a
> scatterlist. If dma_pool_alloc() fails while constructing the list, the
> current code sets buf to NULL and later dereferences it unconditionally
> at the end of the function:
> 
>   buf->next = NULL;
>   buf->phys_next = 0;
> 
> This can lead to a null-pointer dereference on allocation failure.
> 
> If the failure happens after part of the descriptor chain has already
> been allocated and DMA-mapped, the partially constructed chain also
> needs to be released.
> 
> Fix this by terminating the partially constructed chain on allocation
> failure and letting the callers unwind it via their existing cleanup
> paths. Also fix ablk_perform() to preserve the hook pointers before
> checking for failure, so partially built chains can be freed correctly.
> 
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
> v2:
> - Keep the unwind path in the callers, per Herbert Xu's feedback.
> - Terminate the partial chain before returning NULL on allocation failure.
> - Save the hook pointers in ablk_perform() before checking the return value.
> - Thanks to Herbert Xu for the review.
> 
>  drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c | 25 ++++++++++++---------
>  1 file changed, 14 insertions(+), 11 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


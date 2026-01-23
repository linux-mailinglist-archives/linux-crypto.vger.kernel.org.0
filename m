Return-Path: <linux-crypto+bounces-20297-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHJbF+sOc2ntrwAAu9opvQ
	(envelope-from <linux-crypto+bounces-20297-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Jan 2026 07:02:19 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C15270B2C
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Jan 2026 07:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE20E300DDC0
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Jan 2026 06:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCD539DB2D;
	Fri, 23 Jan 2026 06:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="DBkXUXSr"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20B6221F12;
	Fri, 23 Jan 2026 06:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769148131; cv=none; b=CireSla+ShEz0ZgPSQpjXHe3U1WT6LLHzpG4o7HiW3g1n9wvRVt/gEh8+I8QfsEl6szKxt6NTTPfWCdm8dV6MMy7mPljkxzyEF/Tb8pq69b9y6EZpVxMnEAT8AVQEHS1MC2ND5Zs61j62QEVgGtDuN7o2Ivqoz3pLmBF2Deof2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769148131; c=relaxed/simple;
	bh=qvFFkUXMqN91q/9W0PkvJsENtOz/FGHAGrwUFjCGKEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnslazvofWtkzUiIHX7Vg0k+vzBdqhqazzYulXfPIjowLQNTv+epW1kUZ8DRr9wQGaIM/fXZQt3azVYJXXpfW6omCyN6YgLsiy0FpsK8aUDUuinjSL81YxMfrPCawDmeJJLPgACfAQUc0ayG3WBkZmv8aEdzeNuu6akzXmdf1lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=DBkXUXSr; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=SZcBaX9njbZsoyBZCnXkExSdR4O8mj9ArVaoUuVnRpU=; 
	b=DBkXUXSryLiOXFbGQSf9uf3jdFlLJ3yaxyW5X32Jm30QQ9xKdvlFM1jjKcK1KhIN8IJ4nZu8nRZ
	DLo6EiPYMkRft2rEN95PYwr4eM49YAGJ82mAqUCPChKi83Kt570+VFEU+4X4TMRgSIUf1wKw6KJ3+
	fRFH6JJ5N3BhOE7RVo2XEbftsK8+aPwNc8zFiBg/TweWjJSDyyGSe0QHxC8/fRZB9bXUcUzMxscMX
	23ESj5Dj8OHBhPdhKS6JfDx3MxFgmW9Eqd9p1FfmmqBZse21qeOeqynlwAJ74jEZnMXOjWhlBtpW0
	BTZCnXr1IN8RHaXWlxgMStc6FoZqGTYW4F5Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vjAEZ-001VRS-0b;
	Fri, 23 Jan 2026 14:01:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 23 Jan 2026 14:01:27 +0800
Date: Fri, 23 Jan 2026 14:01:27 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Lukas Wunner <lukas@wunner.de>, Ignat Korchagin <ignat@cloudflare.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crypto: ecc - Streamline alloc_point and remove
 {alloc,free}_digits_space
Message-ID: <aXMOt7xDgkm1b_BY@gondor.apana.org.au>
References: <20260105222153.3249-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105222153.3249-2-thorsten.blum@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20297-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:url,apana.org.au:email,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gondor.apana.org.au:mid,gondor.apana.org.au:dkim]
X-Rspamd-Queue-Id: 9C15270B2C
X-Rspamd-Action: no action

On Mon, Jan 05, 2026 at 11:21:53PM +0100, Thorsten Blum wrote:
> Check 'ndigits' before allocating 'struct ecc_point' to return early if
> needed. Inline the code from and remove ecc_alloc_digits_space() and
> ecc_free_digits_space(), respectively.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Use kfree() instead of kfree_sensitive() as suggested by Stefan
> - Link to v1: https://lore.kernel.org/lkml/20251218212713.1616-2-thorsten.blum@linux.dev/
> ---
>  crypto/ecc.c | 27 +++++++++------------------
>  1 file changed, 9 insertions(+), 18 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


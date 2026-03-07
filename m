Return-Path: <linux-crypto+bounces-21689-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBdFFx65q2n7fwEAu9opvQ
	(envelope-from <linux-crypto+bounces-21689-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 07 Mar 2026 06:35:26 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 013F522A4BB
	for <lists+linux-crypto@lfdr.de>; Sat, 07 Mar 2026 06:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FC8C3029E4F
	for <lists+linux-crypto@lfdr.de>; Sat,  7 Mar 2026 05:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8091D280018;
	Sat,  7 Mar 2026 05:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="QRv1oqbP"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9788130BBBC
	for <linux-crypto@vger.kernel.org>; Sat,  7 Mar 2026 05:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772861645; cv=none; b=AhMCAsY1mR7sxL+hpi6H+MFKWmPMvUK6X0avL+yziv87sK80GcfgMfioNofiBQTJv4TdVUyT+tSo5DIRkszH41HXKBiOkSNcg67+/RpQ/4qdfqyOsYqz4fE4lVd2p3FecceJFuEPSIcuBVvI2Dluf1CfJuYxBNmeXHbHYCISOcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772861645; c=relaxed/simple;
	bh=p7CHXNjQwe29/5fzM607YpDSx0YH+wEriQRMMeMingQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blYVyhT6rWDfCtaeX5iIa2NSaSuPahZ5l+nES2cTNeznJaVOsGMSlnqT68omNhV60dmevUiphtm/oFJdAPeUPdY3CmKM7EcH/9zH9dcNgJ11tVKqqpsWwxkzI75X8rqsDrzlR/5rbBeWixuFMHSWlu2sc/7H3psnfYd0Ty9/DGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=QRv1oqbP; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=L+0HVPmNn9Gioabw/8foAudw+QdtYYoKs3gyb91ClKg=; 
	b=QRv1oqbP7YuETwhiJGq+2JxrTi5r+hsaKDG4Di/Sk2Uxhnp+jKfQp0NLHGPqUANRGzrkfVJqZ9b
	u33ILDymhI6RyQG8REKJKbiimM/avY+64YHiP8zzvKojYXeOfOKAGX5iS9CgOSzwj+w6vq3GfvzMB
	1eUPWCPEyjkN7LgvX55kpwi+SkiE+0Kbcj42MHLzLbbDoi92eCSi3dVFL40Zo6F2kzgFLhkGFNp/1
	j/9ojUGc0Fi3T1ZM9p+7fVnjozbmOcu26S65Om6qQUR1gvN42g9KktaGT9uJZWWuz5oBiLAREVMN3
	Bss4cHbB+LJm8bg2RwBLbLRmMhuCryP3mUqw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vykIa-00CJb9-0M;
	Sat, 07 Mar 2026 13:34:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 07 Mar 2026 14:34:00 +0900
Date: Sat, 7 Mar 2026 14:34:00 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] crypto: ecc - correct kernel-doc format
Message-ID: <aau4yKiA8Ue0_waA@gondor.apana.org.au>
References: <20260225014528.45199-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225014528.45199-1-rdunlap@infradead.org>
X-Rspamd-Queue-Id: 013F522A4BB
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
	TAGGED_FROM(0.00)[bounces-21689-lists,linux-crypto=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.962];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,apana.org.au:url,apana.org.au:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,davemloft.net:email,gondor.apana.org.au:dkim,gondor.apana.org.au:mid]
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 05:45:28PM -0800, Randy Dunlap wrote:
> Fix all kernel-doc warnings in ecc.h:
> - use correct kernel-doc format
> - add some Returns: sections
> - fix spelling and parameter names
> 
> Fixes these warnings:
> Warning: include/crypto/internal/ecc.h:82 function parameter 'nbytes' not
>  described in 'ecc_digits_from_bytes'
> Warning: include/crypto/internal/ecc.h:82 function parameter 'out' not
>  described in 'ecc_digits_from_bytes'
> Warning: include/crypto/internal/ecc.h:95 No description found for return
>  value of 'ecc_is_key_valid'
> Warning: include/crypto/internal/ecc.h:110 No description found for return
>  value of 'ecc_gen_privkey'
> Warning: include/crypto/internal/ecc.h:124 No description found for return
>  value of 'ecc_make_pub_key'
> Warning: include/crypto/internal/ecc.h:143 No description found for return
>  value of 'crypto_ecdh_shared_secret'
> Warning: include/crypto/internal/ecc.h:182 No description found for return
>  value of 'vli_is_zero'
> Warning: include/crypto/internal/ecc.h:194 No description found for return
>  value of 'vli_cmp'
> Warning: include/crypto/internal/ecc.h:209 function parameter 'right' not
>  described in 'vli_sub'
> Warning: include/crypto/internal/ecc.h:271 expecting prototype for
>  ecc_aloc_point(). Prototype was for ecc_alloc_point() instead
> Warning: include/crypto/internal/ecc.h:287 function parameter 'point' not
>  described in 'ecc_point_is_zero'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> 
>  include/crypto/internal/ecc.h |   22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


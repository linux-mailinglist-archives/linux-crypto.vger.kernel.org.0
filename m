Return-Path: <linux-crypto+bounces-22757-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIbdL08Tz2nXsgYAu9opvQ
	(envelope-from <linux-crypto+bounces-22757-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 03 Apr 2026 03:09:35 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D690C38FDBB
	for <lists+linux-crypto@lfdr.de>; Fri, 03 Apr 2026 03:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91EE8302C562
	for <lists+linux-crypto@lfdr.de>; Fri,  3 Apr 2026 01:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8D22405EB;
	Fri,  3 Apr 2026 01:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="CWBkCYYg"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A60F1EB19B;
	Fri,  3 Apr 2026 01:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775178551; cv=none; b=pNMOvanvrbnTA0xPXVfd4l232wNGI2CpSyX/E3pzK/UEe4p6OpoURnjg6ahAbPv+Sq7NyglrLFiGw6g8w3XVnmaGkn1Ztri5TE/173ZfV58hUmlmnMUM7j1siXsKZKzCk2w4VCB4W8+F4OPgyVOigcIPO0xFmwklAoTI+rLIOxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775178551; c=relaxed/simple;
	bh=1C4N+4Nq4Xc68q3x6VAM82NxgdjKBMPV02PGjnkzUpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJw//74i0sZN5/ZyTJgZRhK0hSKzTPJfa0u8gnZUQxVlyCv+eHpERnJiUKc9YfUDn4Az6eQqOxb+dkLxi2dhrs9CEquE8fFUD9RfAjq8K6ifjMb7HoB+ZO0ALCMm83yzgKRGSXA01b2IB+LmXwSf5j9gUUTUxD7SS0QAjbCYpqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=CWBkCYYg; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=7+nDM6LAsmkDnFr7mjtWoXvu1ettz+C/TmpGTp7BxGM=; 
	b=CWBkCYYgJKnfSt7hZ/r4E27Su8BLzOeO2LhRAXgMisrkJ5UBqrxzTEpF4cW+3njXERzGPoXydgn
	M+TRIzuyvVnc4+B00ctxEc47fI7lDb6LTr15fPHrGtT6D7pdomBonrBr5uvIi0WqbqXuo8g6zGdtL
	3pMej2XrO/W8VKPNr22FW5ETz6YMFWutD9D7X3m5T5VUtqQuM9QovF6MPkrtoyfzPDnhkrZyNChj0
	IYr78dMopiYB4FO8CrUGmYA4Dvr/sSuNzfBCQiFrzpBsNeCiX3OYOr0kjUizaTghzqjfSV6l+YL2X
	sTZkD/UxY0BcwSAhykyJPHLXx7LxiEJlC90Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w8ScX-003R3t-2u;
	Fri, 03 Apr 2026 09:09:05 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 Apr 2026 09:09:04 +0800
Date: Fri, 3 Apr 2026 09:09:04 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] crypto: img-hash - use list_first_entry_or_null to
 simplify digest
Message-ID: <ac8TMM-Mvy8ZeWBy@gondor.apana.org.au>
References: <20260328102043.85271-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260328102043.85271-4-thorsten.blum@linux.dev>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-22757-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,apana.org.au:email,apana.org.au:url]
X-Rspamd-Queue-Id: D690C38FDBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 28, 2026 at 11:20:44AM +0100, Thorsten Blum wrote:
> Use list_first_entry_or_null() to simplify img_hash_digest() and remove
> the now-unused local 'struct img_hash_dev *' variables. Use 'ctx->hdev'
> when calling img_hash_handle_queue() instead of 'tctx->hdev'.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/crypto/img-hash.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


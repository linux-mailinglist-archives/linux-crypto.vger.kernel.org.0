Return-Path: <linux-crypto+bounces-22756-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A0GAS8Tz2nXsgYAu9opvQ
	(envelope-from <linux-crypto+bounces-22756-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 03 Apr 2026 03:09:03 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E0A38FD91
	for <lists+linux-crypto@lfdr.de>; Fri, 03 Apr 2026 03:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D532301A3AB
	for <lists+linux-crypto@lfdr.de>; Fri,  3 Apr 2026 01:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283CC2405EB;
	Fri,  3 Apr 2026 01:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="KZ2BssO7"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F033C2D;
	Fri,  3 Apr 2026 01:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775178537; cv=none; b=clp0JinVPFCXdzBa6dC+b6+uisRFHPrrzE9AJiQaFWyXN9T35+qIKKXaL30hYsTdgow1Hff2Z8uhi9Jk31dun4RDyH8wCX28taso/kBV+Bz2O0Vj3f44b0+nkp8I8uItm4wFIotq3smEjh1w9OaY5BcNIMq4Qf8bRAvy9mTI7jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775178537; c=relaxed/simple;
	bh=MpmlzE44/KkuNvx8SIXsmNx34WGHLm7AzXtoNxi5jz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ek1rR82pG0USijLYbTaTFDJkQwazMfp4qi/hlEJxK14E7/gkitbeYNsnQNcX7MTwp7XzN/hvOcHd251ugqBycEDOYW3q/od2QE9bAUuwT4FDITHNNI0rbVtVDEzzruBhUZQ6BP+4iRjQamIr/3fNw0DSz/fRYhnlZs+8P6sfkwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=KZ2BssO7; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=cE96ftrNG6aV7TRyCq27TIxjfnhO8CfBx9R1BcXGNpU=; 
	b=KZ2BssO7QZ9OnU5vAYmXDC8XKVdswRTJY3vCPIrSk45/ksEV/yiwDflRSGr6n4eoIjmeQijmtYx
	cgtcuVr3xGdmhIxzm2T2Q4iLt1MJGxvi6j+knBMvobQyfEz5DJYKIvJRYvv6X/IF1DDfNsgfc+c1q
	krUZm5uXfYNDyOmzYZFkGBSB0VuZBJ4SbBmxKuuhPgFPn0bcNjSV5htIhr0uVgkhYNbph9vo3sFp2
	EZgWgOAIEvE1qiJZuh4m+uHjVzWQ6h/5ah+Ozy7ogCmPs/qRTHy392P6qNYpQ6g2fgDbNbVzbXixS
	VgnU2BeDxdz/cDnNixaQ5dtVyalOvvuVIsxA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w8ScM-003R3m-15;
	Fri, 03 Apr 2026 09:08:54 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 Apr 2026 09:08:53 +0800
Date: Fri, 3 Apr 2026 09:08:53 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] crypto: cryptomgr - Select algorithm types only when
 CRYPTO_SELFTESTS
Message-ID: <ac8TJTR-rqoMO2zO@gondor.apana.org.au>
References: <20260327230818.140264-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327230818.140264-1-ebiggers@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-22756-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gondor.apana.org.au:dkim,gondor.apana.org.au:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:email,apana.org.au:url]
X-Rspamd-Queue-Id: C7E0A38FD91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 04:08:18PM -0700, Eric Biggers wrote:
> Enabling any template selects CRYPTO_MANAGER, which causes
> CRYPTO_MANAGER2 to enable itself, which selects every algorithm type
> option.  However, pulling in all algorithm types is needed only when the
> self-tests are enabled.  So condition the selections accordingly.
> 
> To make this possible, also add the missing selections to various
> symbols that were relying on transitive selections via CRYPTO_MANAGER.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
> 
> This patch is targeting cryptodev/master
> 
> v4: addressed yet another transitive selection
> v3: addressed more transitive selections
> v2: add selections to options that were relying on transitive selection
> 
>  crypto/Kconfig                   | 27 +++++++++++++++++++--------
>  drivers/crypto/Kconfig           |  1 +
>  drivers/crypto/allwinner/Kconfig |  2 ++
>  drivers/crypto/intel/qat/Kconfig |  1 +
>  4 files changed, 23 insertions(+), 8 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


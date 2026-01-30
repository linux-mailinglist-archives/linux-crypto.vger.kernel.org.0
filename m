Return-Path: <linux-crypto+bounces-20473-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFgAMAU9fGkXLgIAu9opvQ
	(envelope-from <linux-crypto+bounces-20473-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 30 Jan 2026 06:09:25 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7B2B7335
	for <lists+linux-crypto@lfdr.de>; Fri, 30 Jan 2026 06:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80554300DE2A
	for <lists+linux-crypto@lfdr.de>; Fri, 30 Jan 2026 05:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001D832863A;
	Fri, 30 Jan 2026 05:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="aKabSUZm"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B9431355C
	for <linux-crypto@vger.kernel.org>; Fri, 30 Jan 2026 05:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769749761; cv=none; b=e3DnJXf1zhj32Ey9mGxcrC2Y/XX6un2RlfSJy/0soU3yCAqFm4uCy88Y3olLPVGzFEpAgq9VE968mrbucpFWzULg8qE4jvnYoRoAPKAmkRpTnYF3erS6tueITdA5SuwVRt4ngo+pBtMOVEmKdT5Zl2wifyc46Iy+gFZqO2qRbN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769749761; c=relaxed/simple;
	bh=oT7zk/Ls/sBMFx69bl2yLD1ZaRwDcaQygY+6AR2ieMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+QnEYAvYvL+vq6V40nwexINGVPoJLGSGusJTwpz4RuaEWe/pyn89xVY5mT2kiU9/qOv2dN7cTXHIi9zVqwoTQ3UGojcTWBHBjI35PGfZUVhtnmWYo3kHFrLp3UohcbwSuGSNSLD/DYdjzLMeV9Px3y8b55fRr3AV+FV0+XVPnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=aKabSUZm; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=wpphbVCilQmqkHs0YHpEt2Or5PPfVb+lhFC4nphItZo=; 
	b=aKabSUZmAbizNc2Dd4CuyRNsSQLol6vPPMhfa3kWpiOomv6/Z5G4hvWuJnXdliT4fva8KfE+94m
	argt7GSL0HPdS83pyOLvCfNY0Nl/tGm6dVdBccVZBZDozicazLSESZIiEShYVgM74SvxrfPvcldJJ
	MGeJlH0Hi1uLN2Jr443Gv4evw5HAfpBWk+TSWEPj2MO8pN+dTpcda0lbOeOcrB2Nx4zJT9xNDAJEd
	fEW1RwCiPD56fpKNTESl0EWBQ2kogHYrI8CNzfJ9gORmhtRE90i/sqQrBaV93DYCDblVfaZPL2byi
	aR4K/6ORrVm7VF5ugJttzaCjBJK1c0hQsdNA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vlgkq-003Da1-11;
	Fri, 30 Jan 2026 13:09:13 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 30 Jan 2026 13:09:12 +0800
Date: Fri, 30 Jan 2026 13:09:12 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ryan Wanner <ryan.wanner@microchip.com>
Cc: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: AFALG with TLS on Openssl questions
Message-ID: <aXw8-J2KRklumOa8@gondor.apana.org.au>
References: <25e13e64-f39c-44b4-9877-1e3b6caed458@microchip.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25e13e64-f39c-44b4-9877-1e3b6caed458@microchip.com>
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
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-20473-lists,linux-crypto=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:url,apana.org.au:email,gondor.apana.org.au:mid,gondor.apana.org.au:dkim]
X-Rspamd-Queue-Id: EA7B2B7335
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 09:28:51AM -0700, Ryan Wanner wrote:
> Hello,
> 
> I am working on kernel v6.12 and trying to use
> authenc(hmac(sha256),cbc(aes)) for a TLS connection. The driver I am
> using atmel-aes.c and atmel-sha.c both do support this and I did pass
> the kernel self tests for these drivers.
> 
> It seems that afalg does not call the authenc part of this driver, but
> seems to call aes separately even though authenc is detected registered
> and tested. Can I get confirmation if this is supported in afalg? From
> what I understand afalg does not support hashes but cryptodev does. I
> see cryptodev call both sha and aes while afalg just calls aes.
> 
> I do have CRYPTO_DEV_ATMEL_AUTHENC=y CRYPTO_USER_API_HASH=y
> CRYPTO_USER_API_SKCIPHER=y CRYPTO_USER=y this is a SAMA7G54, ARM CORTEX-A7.
> 
> I also would like to know if authenc(hmac(sha512),gcm(aes)) is
> supported? I would like to add that to the driver as well but due to the
> issues I highlighted above and no selftest suite for authenc gcm I do
> not know a good way to verify the driver integrates with the crypto system.

It certainly should work.  I suggest that you check /proc/crypto
and see if your driver algorithm is registered at the correct
priority for it to be used in preference to the software algorithm.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


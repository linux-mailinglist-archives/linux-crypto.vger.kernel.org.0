Return-Path: <linux-crypto+bounces-23734-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGfBOKy4+WntCgMAu9opvQ
	(envelope-from <linux-crypto+bounces-23734-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 05 May 2026 11:30:20 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1914C9B37
	for <lists+linux-crypto@lfdr.de>; Tue, 05 May 2026 11:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B0F83001C46
	for <lists+linux-crypto@lfdr.de>; Tue,  5 May 2026 09:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC5C31ED7C;
	Tue,  5 May 2026 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="Xl/wuggo"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2A32C08D4;
	Tue,  5 May 2026 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973398; cv=none; b=kawhd+Ef01Q9VvmWDzjUWRYhF22F6hVebjYFuchDiD5Q2VTxoVWJSmj2yVBUspewHAoMJvvB0UXOtWIlzFDWwAu5/F0EaD65hZEYpZA5iwq05JICj9qfEcA2GZyUsNtzqKkhIRZOopU43tOnj0YtiLKj+kN2Io9efDPijgZvuRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973398; c=relaxed/simple;
	bh=re5/hwBAs5/GBJ7TzB7vl/S/EucrBlA3ypH6UW5YHOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4kj/WGLd+7wRoJ6XH/Zby4+7GzmetLq2a/wLn7Wha90tB46NJC6pCtRRekteljbsTzkC3mjeCJyTeohQAAH6CJfFZ0EgHZYv1D8lhE9qMKAhJ2GDe+nhhfE2i3rWqx2C+rwqTdeLalqw4//Cf2uGgfSlKpl8YLtqheLZcYyr8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=Xl/wuggo; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=VT+42vPs6HXLDX21YUZCKBsCFIDbYncns96uQpD8gr0=; 
	b=Xl/wuggonWJuItnSe57YQkkU4PNpyTaSeqN2QWgNX1660Fi5RHD+jV7Mbfa1YrYJgklIJ8aATED
	QeGG/L28Btb57XVFuTC1H7FWIZNdVVALmXvERoka5j3z8V/i3PeY2KqPsH3kADwNd1QaY6yCdNxpQ
	dHl1MDeqpNaf5dFN7BolDzhjs6tIroSrTjV/0xQ5IVNHvuY698HLfysLZ5yFxotMKVL1fYNoMmofB
	01a1NJopULaybSDTCuWPmRwRut052WxStVpcnmanwkoRXs3bzqfAwR1zPkEXhMofAT+0hc5rJZTe1
	E+a+yuBpOa7VP+dvcil/MagPbBkVMJeeWtyg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wKC66-00BNyq-0v;
	Tue, 05 May 2026 17:29:47 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 05 May 2026 17:29:46 +0800
Date: Tue, 5 May 2026 17:29:46 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jia Jie Ho <jiajie.ho@starfivetech.com>,
	William Qiu <william.qiu@starfivetech.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: starfive - use list_first_entry_or_null to
 simplify cryp_find_dev
Message-ID: <afm4ig_BAsfY2HWW@gondor.apana.org.au>
References: <20260427213504.420377-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427213504.420377-3-thorsten.blum@linux.dev>
X-Rspamd-Queue-Id: 3E1914C9B37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23734-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,linux.dev:email,apana.org.au:url,apana.org.au:email]

On Mon, Apr 27, 2026 at 11:35:06PM +0200, Thorsten Blum wrote:
> Use list_first_entry_or_null() to simplify starfive_cryp_find_dev() and
> remove the now-unused local variable 'struct starfive_cryp_dev *tmp'.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/crypto/starfive/jh7110-cryp.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


Return-Path: <linux-crypto+bounces-21287-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMXBCeZnomlA2wQAu9opvQ
	(envelope-from <linux-crypto+bounces-21287-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 28 Feb 2026 04:58:30 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8551C03BA
	for <lists+linux-crypto@lfdr.de>; Sat, 28 Feb 2026 04:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F074230579F7
	for <lists+linux-crypto@lfdr.de>; Sat, 28 Feb 2026 03:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B427433ADAE;
	Sat, 28 Feb 2026 03:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="HkguhNR7"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782D92222A9;
	Sat, 28 Feb 2026 03:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772251093; cv=none; b=dyKUp7vQJP5opNuogQ7hXzuMHwfvAEKrevS1l56KmVyaAeLAFaoBzoyZSrXsD3Jqfkpf+K64mBdq2oYml/fWaIxyRxJ1ISKiJl/jbBVBDG1AFvOFzDvoH1GAhak8a0Oiy+8Hgt2mh61oIv+eqtS9/ZBKUlnf9bwGFUVzVAvT7Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772251093; c=relaxed/simple;
	bh=eDIRflFeZ/aTj6QsaYs5yMdhLUeBd/eUzo1c1YzlIdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuXsEsxgC157F8XGXAKBIt/6nEbVTVHuloh5K6jTWAJIMnT4s6KcnTv8HEwQ9sl9D4V6oFhTMTmil6KqDopyqtCePp0ZwLpXqP254+gFuOWgle6gBvheO9KGPPBgBKW267gkmYW2EKtFjdt7psgLPcROXn70FHtLYxmjme2CmOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=HkguhNR7; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=WUAKgwWFg/dMy9Lurwd3Ntd7xoozqQGcNbLzpMDQiaA=; 
	b=HkguhNR7aJTkkqU7szjr8kioXGP5+PC+GMSOrKCnNY/NqoKPza7hRwtLgW4UWepA+njENz8WRLJ
	J+hBFIgRQVmxU+aPbgA18VbtDsUB89sxYsYVARBpBgPI+1Pogb7//n5h+XGfyC5YEwWGHEj2/dwXA
	2h3a5fD0OFQ/aomy59mmBzy7wwuSkbQBwHUgZCMK79BNZLS6gEITKwLR4/xmpKtX3Utm35Vk75jBz
	F7Qa/jZomg8GEMtGjxhNI9AksDfqgFmIByNgT6hDDOvnhVFnIyktTchdXasD0HVix6tCMJVOMsLsu
	+2BNpCIKMLL0BtHYZD0+amfwFXyKEPztWloQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vwBSS-00ABiu-2h;
	Sat, 28 Feb 2026 11:57:37 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 28 Feb 2026 12:57:36 +0900
Date: Sat, 28 Feb 2026 12:57:36 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: octeontx - Replace scnprintf with strscpy in
 print_ucode_info
Message-ID: <aaJnsOEKPBhkdefW@gondor.apana.org.au>
References: <20260202173323.865842-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202173323.865842-2-thorsten.blum@linux.dev>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21287-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:url,apana.org.au:email,gondor.apana.org.au:mid,gondor.apana.org.au:dkim]
X-Rspamd-Queue-Id: 7F8551C03BA
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 06:33:21PM +0100, Thorsten Blum wrote:
> Replace scnprintf("%s", ...) with the faster and more direct strscpy().
> Remove the parentheses while we're at it.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


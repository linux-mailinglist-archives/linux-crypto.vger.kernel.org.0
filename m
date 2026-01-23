Return-Path: <linux-crypto+bounces-20296-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAWYJuQOc2ntrwAAu9opvQ
	(envelope-from <linux-crypto+bounces-20296-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Jan 2026 07:02:12 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F96670B1D
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Jan 2026 07:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9821301917F
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Jan 2026 06:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4299B35DD1A;
	Fri, 23 Jan 2026 06:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="MN4VmyFo"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB71237AA9E;
	Fri, 23 Jan 2026 06:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769148107; cv=none; b=d3/n7kjhfdpjEFDz/4pFDdaMH8UHZQr9z0X48wvCaQQI9nkBoHIOEErfLhi6y1hMI9cHBrl3zwSTp1YG9RN1GNF7lyhsHgts6leMwuYb+Kv1l6gpL5tABo44WiSTKjcsdeABy7t24mQQtLccxshbJJHTJgeyz7PCNeS/tj7qIjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769148107; c=relaxed/simple;
	bh=xBB+IajcbYODYCssVaSCkuE8n6G+dpzj1y1zpm1BwUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2bwlXbIdIj0u6cxH/+hqXu6tZhLhBsQnZW0/VHEbMnkvosrFbA0IXu+oso7ETSFkHn+5U/5TB+OnTQiFQ1Pty4x1sLfA2xqNVtvBmNNc8bdDy3twyd3D2AIKXWrykwPQkHRGm+B1GNYjnyDckRDdZkfdlvn6WNoVO1r2Kryp74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=MN4VmyFo; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=uxd8qXEJDj94YeJB4zv9coAoOQR2STnKUNJVVZFpwNQ=; 
	b=MN4VmyFoyxWtsSvuQDifkmTnPVb1SI51h5g7cPFgOOLd5XMMYo+uaRhu67Tk0ujHEZil7fYWepU
	PxL/LQ3yR48fd/AjDJzAPu17Y6iTAqe1jAB6LhIdWPzonnxT8InQw6SDq57skiVu//XebhbOQxr8g
	BkJQ2Awn8Qyxhy/HQq+b0bbhv/9oi9O3XZOeVF/8wEon94+bIoz4SYjn91RW50qIullCWgk/51Uuq
	GvTyskiAoEwg+yxmlGVadoTkmBwMAKVyJQQnszJph5Ovhxz4/z2/xWmkSwqncoWT/D6glZNbkiidv
	a+tBBiCI0CBk1wOi37EiFPWqW/sOlCNXfwYA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vjAES-001VRO-0u;
	Fri, 23 Jan 2026 14:01:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 23 Jan 2026 14:01:20 +0800
Date: Fri, 23 Jan 2026 14:01:20 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: benjamin.larsson@genexis.eu, olivia@selenic.com, martin@kaiser.cx,
	ansuelsmth@gmail.com, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwrng: airoha set rng quality to 900
Message-ID: <aXMOsCsUMpCQRy6Y@gondor.apana.org.au>
References: <20260105204204.2430571-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105204204.2430571-1-olek2@wp.pl>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[genexis.eu,selenic.com,kaiser.cx,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20296-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[wp.pl];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.957];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wp.pl:email,apana.org.au:url,apana.org.au:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gondor.apana.org.au:mid,gondor.apana.org.au:dkim,genexis.eu:email,random_airoha.zip:url]
X-Rspamd-Queue-Id: 0F96670B1D
X-Rspamd-Action: no action

On Mon, Jan 05, 2026 at 09:41:49PM +0100, Aleksander Jan Bajkowski wrote:
> Airoha uses RAW mode to collect noise from the TRNG. These appear to
> be unprocessed oscillations from the tero loop. For this reason, they
> do not have a perfect distribution and entropy. Simple noise compression
> reduces its size by 9%, so setting the quality to 900 seems reasonable.
> The same value is used by the downstream driver.
> 
> Compare the size before and after compression:
> $ ls -l random_airoha*
> -rw-r--r-- 1 aleksander aleksander 76546048 Jan  3 23:43 random_airoha
> -rw-rw-r-- 1 aleksander aleksander 69783562 Jan  5 20:23 random_airoha.zip
> 
> FIPS test results:
> $ cat random_airoha | rngtest -c 10000
> rngtest 2.6
> Copyright (c) 2004 by Henrique de Moraes Holschuh
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> rngtest: starting FIPS tests...
> rngtest: bits received from input: 200000032
> rngtest: FIPS 140-2 successes: 0
> rngtest: FIPS 140-2 failures: 10000
> rngtest: FIPS 140-2(2001-10-10) Monobit: 9957
> rngtest: FIPS 140-2(2001-10-10) Poker: 10000
> rngtest: FIPS 140-2(2001-10-10) Runs: 10000
> rngtest: FIPS 140-2(2001-10-10) Long run: 4249
> rngtest: FIPS 140-2(2001-10-10) Continuous run: 0
> rngtest: input channel speed: (min=953.674; avg=27698.935; max=19073.486)Mibits/s
> rngtest: FIPS tests speed: (min=59.791; avg=298.028; max=328.853)Mibits/s
> rngtest: Program run time: 647638 microseconds
> 
> In general, these data look like real noise, but with lower entropy
> than expected.
> 
> Fixes: e53ca8efcc5e ("hwrng: airoha - add support for Airoha EN7581 TRNG")
> Suggested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  drivers/char/hw_random/airoha-trng.c | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


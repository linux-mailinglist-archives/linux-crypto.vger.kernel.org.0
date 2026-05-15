Return-Path: <linux-crypto+bounces-24080-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBBlKGb7Bmp1qQIAu9opvQ
	(envelope-from <linux-crypto+bounces-24080-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 12:54:30 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADBC54DD14
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 12:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B52CB308566D
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 10:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ABF3A9627;
	Fri, 15 May 2026 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="l07vNgJG"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1DD3B1009;
	Fri, 15 May 2026 10:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840351; cv=none; b=ijOVTiDuUHf53WZPntedChYeklOlGyeorM4Afzyiu0+gRYsH+1KxOu7gPzFiYuw3SAXe+Q5586Iam09sSykiIktTYjppFh4BreY9UzIdtqgId5SfelRb0IxmM9nbbNDsC6FXyf06DNVmJq4XygZStniugOM0mMjfbnRA2KxxLR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840351; c=relaxed/simple;
	bh=skUs5OObtvHIW5l9S1tai3j3C738SE8HZv8oD9ZpfN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/myxEHUAFCYrSZbiZ6hhTO+al3wXzMhMOkB0L+RCdhg7p57OiNyvLRmh8VWF+atuqg0DJqJ2e4mUQYLKfD+4+BWD23Zccvvo3Gw9OWB1knrn4IGgwuMMEqByOTNgiXog0GoVTTpPOb7+ivYUTJ7asyRiSNQIB26mE4BWW3hoWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=l07vNgJG; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=BNP5P1RTLSMO2EZNZMRug211Ae1yzrAmUs+eI+V5368=; 
	b=l07vNgJGfze0G5/viKGJ2qFVe8/d3b7K17NbOhFk4oRTcyUn0puBePi7Da2mlaLnCt4/p8BcUI3
	3kckXdp+HMXlMSKvPQmvh/CNUSArblk5hnzqv5fbSx/Q1Dd/sRXL9fjZ1244jY0sOJQI1inx+a/bl
	/z63YIQVvq1ujagf9g1dYD7V7QhvwN0ZIJwCRxtk7GfO+fotWuOX7w01yZQzxNNWqqvN8nXZ9B3Yd
	80OQYij1pFeQ4AV9voPrNhoVFZ3F/v+bvhwvpRxFlE2jK9DrqArroHeeMwC0v//QcPDXEj0gHo3L0
	pMK+9a03LIHc1moHfYjI9rME46rXswxNniAg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wNpdD-00EOPw-32;
	Fri, 15 May 2026 18:19:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 15 May 2026 18:18:59 +0800
Date: Fri, 15 May 2026 18:18:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Olivia Mackall <olivia@selenic.com>,
	Lianjie Wang <karin0.zst@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Jonathan McDowell <noodles@meta.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] hwrng: core - drop unnecessary forward
 declarations
Message-ID: <agbzE0Cgd2wUbtzn@gondor.apana.org.au>
References: <20260505094555.158017-6-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505094555.158017-6-thorsten.blum@linux.dev>
X-Rspamd-Queue-Id: 9ADBC54DD14
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	FREEMAIL_CC(0.00)[selenic.com,gmail.com,meta.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-24080-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue, May 05, 2026 at 11:45:55AM +0200, Thorsten Blum wrote:
> The forward declarations for drop_current_rng() and rng_get_data() are
> not needed - remove them.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> No changes in patch 1/4.
> ---
>  drivers/char/hw_random/core.c | 4 ----
>  1 file changed, 4 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


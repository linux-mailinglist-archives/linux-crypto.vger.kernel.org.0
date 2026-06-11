Return-Path: <linux-crypto+bounces-25029-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DMBCIlVBKmoQlQMAu9opvQ
	(envelope-from <linux-crypto+bounces-25029-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 07:02:13 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2EF66E59F
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 07:02:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=MlX1Dafe;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25029-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25029-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33997303098D
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 05:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DD5367B95;
	Thu, 11 Jun 2026 04:59:16 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C90D35F172;
	Thu, 11 Jun 2026 04:59:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781153955; cv=none; b=noWxNYX+mLnSOyTkOFhsRgXYb+e9HGlWWt37TcNWnFAVkKoq/7uhPHE8Q6vRMzlBGC98ZMcDFr94ZASdA8eruEId6hJLJWZHMjUdool5eEQ/EQmKy+ON5zdo/3Jl59pSMCz91QyJhK3+yxRPcQ3HKFUbESGjmrd4FPijtw+RKZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781153955; c=relaxed/simple;
	bh=rPgXoYUGKhSxEuLmBMhhmev6gI+ing8WhJjfM5N2BwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6otHO43X9rgaqIVGHQAQjXncTRPWyETK93gKdPkXzQE5D2fdFJQPWJebTzHKkRRbvr52Fmn4t4ehgYOSrSiwSxaKzQZyd0x4/1aI9YxEg+bazmdq5DwSccIjZTYqJrmLcOOg3+d8g3MLsWkDlx8KWcTRcOjT2DVbGdvNokn3X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=MlX1Dafe; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=546shhB/KH5+15tWAdPoz4gIivACldY67y4LOMfUQeY=; 
	b=MlX1DafeCyKYYEqc2jJ06gdJe49IOkcz0wjLYKEijY5r/LZOufEDMtOWiJVXVTEsF+nRtnmVTnp
	DPKpT5+IHOX8QGc5zdsppH2dkFBzWaZQi4OkUyoKE8mhTX1uDyRZCtsjPHDrEUK5PMC0J0ktS9xbD
	HVrllEb+R68tI/Akgo9VNCPR6yRuAQfsv2QpND37NlzLNR4GuMaPrP3wWTXn8YBAxrixO5TH35aS4
	Otjnowfks6R8xvfCqaDg53lqtuwoLh43ccpguYI+RM0l+aAu8bKuF1U/1CxMy8b2gNv4ubkkczz00
	D0GN7F+eoL8sdn1cNz4KYORCZTNy6YwoOjDg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wXXV1-00000004TeB-1eqX;
	Thu, 11 Jun 2026 12:58:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 11 Jun 2026 12:58:39 +0800
Date: Thu, 11 Jun 2026 12:58:39 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: thorsten.blum@linux.dev, davem@davemloft.net,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, ardb@kernel.org, krzk+dt@kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 1/1] crypto: atmel-sha204a - fix heap info leak
 on I2C transfer failure
Message-ID: <aipAf_uZnX_gwZnl@gondor.apana.org.au>
References: <20260609094723.47237-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609094723.47237-1-l.rubusch@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25029-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:l.rubusch@gmail.com,m:thorsten.blum@linux.dev,m:davem@davemloft.net,m:nicolas.ferre@microchip.com,m:alexandre.belloni@bootlin.com,m:claudiu.beznea@tuxon.dev,m:ardb@kernel.org,m:krzk+dt@kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:lrubusch@gmail.com,m:krzk@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:url,apana.org.au:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA2EF66E59F

On Tue, Jun 09, 2026 at 09:47:23AM +0000, Lothar Rubusch wrote:
>
> diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
> index 4c9af737b33a..20cd915ea8a3 100644
> --- a/drivers/crypto/atmel-sha204a.c
> +++ b/drivers/crypto/atmel-sha204a.c
> @@ -31,10 +31,15 @@ static void atmel_sha204a_rng_done(struct atmel_i2c_work_data *work_data,
>  	struct atmel_i2c_client_priv *i2c_priv = work_data->ctx;
>  	struct hwrng *rng = areq;
>  
> -	if (status)
> +	if (status) {
>  		dev_warn_ratelimited(&i2c_priv->client->dev,
>  				     "i2c transaction failed (%d)\n",
>  				     status);
> +		kfree(work_data);
> +		rng->priv = 0;

Why is this necessary? It appears that rng_read_nonblocking already
zeroes rng->priv.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


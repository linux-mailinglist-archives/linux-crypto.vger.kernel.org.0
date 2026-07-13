Return-Path: <linux-crypto+bounces-25872-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hGlPNNNIVGrRkAMAu9opvQ
	(envelope-from <linux-crypto+bounces-25872-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 04:09:23 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF25F74689A
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 04:09:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=GYXfRv8Q;
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25872-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25872-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 652243001CF8
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 02:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179952DCC05;
	Mon, 13 Jul 2026 02:09:16 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6D32D77F5;
	Mon, 13 Jul 2026 02:09:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783908555; cv=none; b=U/2h1h1+6gV3AeanRMVK0WvVyLTGefudxwessCkqO4B7OB1RLbtK2NKtcCgmxNupnmV1rXEJho0qDqTILbTj0YQrq7QvFtNU/xVv723z/6v4P1D9g41BX9hz44yTUDN6PRxAbirmkF8PwLxMPB99ngQbM4rLTzUV26dcgXgYOak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783908555; c=relaxed/simple;
	bh=iTY+1Uatitk5rJHb6sb1FsxZ8/tdaF0YJ40QmlGdN9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQnX70S/6eoW9EaOKsuFiMsPUA4pHKtsD32OCb1h3u0ta6/jLt2NXtkoh7/Fsb8u0FnMSzLcBavMAEvrXppOe/DzzGk2kpN1Nc/Nuey9NAESbXTqdU9l7q+5zlTMpnij69BfIdYONrlSOVqDY73diK9H9F0ZW36PkR2nI170LkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=GYXfRv8Q; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=AbiLZWl/3TiK6gijGtX2JiTC/GloFVRdhq3Htt3t6jo=; 
	b=GYXfRv8QfzZGxTxtwvkmABU9bpzgn1qwfCpIbYos5GLxSViHnLxB+lX+Dv6vcWxCNwztwX1KeJZ
	kUCfvObRV7JWYrfPySm4o9+dqB6K5wEQCFjMnx214x4O9SYWhC4+6LoMQimctl8iT28+2+H4M9HdR
	vEw18zho/OfxOhZsRnUIZkL5BQZJd568rK0ipO39rMmiC1oE4NHx7ItNikT3uuYU4NTGIjERq5Tkn
	Qq2V0vS465XgFt9Mz+qHY57O9TvCiZnLuXLsIJjWdY9g68h9Xnk7jI64zdMrrJGc+ea00Bu9Fmwye
	2fGaCbw+gue5YyBFPin2ygJHyckNRJ8n3/7A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wj66V-0000000CxAu-44X0;
	Mon, 13 Jul 2026 10:09:09 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 13 Jul 2026 12:09:07 +1000
Date: Mon, 13 Jul 2026 12:09:07 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-crypto@vger.kernel.org, Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: cesa: add missing free_irq() calls
Message-ID: <alRIw6NnLkD_HU99@gondor.apana.org.au>
References: <20260628232000.1287439-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628232000.1287439-1-rosenp@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25872-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:linux-crypto@vger.kernel.org,m:schalla@marvell.com,m:bbhushan2@marvell.com,m:davem@davemloft.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,apana.org.au:url,apana.org.au:email,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,gondor.apana.org.au:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF25F74689A

On Sun, Jun 28, 2026 at 04:20:00PM -0700, Rosen Penev wrote:
> Add the missing free_irq() calls, along with irq_set_affinity_hint(NULL)
> to clear the affinity hint set during probe.
> 
> Fixes: 5bbf25419f8e ("crypto: marvell/cesa - use request_threaded_irq instead of devm variant")

This commit does not exist.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


Return-Path: <linux-crypto+bounces-24447-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOOlK+xMEGq5VwYAu9opvQ
	(envelope-from <linux-crypto+bounces-24447-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 22 May 2026 14:32:44 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD495B4010
	for <lists+linux-crypto@lfdr.de>; Fri, 22 May 2026 14:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4D21306C5BA
	for <lists+linux-crypto@lfdr.de>; Fri, 22 May 2026 12:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACB0380FE5;
	Fri, 22 May 2026 12:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="D142ZXZF"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5393803DC;
	Fri, 22 May 2026 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452926; cv=none; b=fvVhPS5Im1uJX5ctwrrtBSa0DPuHK4qW6e9fHu3Dw9x6yc0P/+ktVLtQaYdgF17doj2T/J1u7UXNV8WldmiJtSJgS/wdxqEco3e3sKMBJ0u55Nxt+PZAObwS7h/cDyxW6/EbrzZf3C6Nprz5aO4BDrqSMpx9OOXoiH1M8CwRjM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452926; c=relaxed/simple;
	bh=twADWZHwnWKcA/f+s52Do0dKLJJsub8i+cI5sf6Qa7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWBVVjstsfQ/pczwx+38XLf5Vv3EIUzemGu1YghCTcFLzK1LC9et4DiQ9EGlHTRM4FmSaU4yjfOsnWw3zXOHyZ3y47rhyY96pbFpjVjmfIardrx4hkNsltQSiLtixlkRbKiOJO392Xh7inDm4fek6WggSt6YdefpTEgvkPlFmA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=D142ZXZF; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=37IxNgIC/tK7GQFANkJ90OJqPkAePULSWjzc8XxfLNo=; 
	b=D142ZXZFRwKjKdEolsaV7eNlCIJltAQh+FHrmbw7hKm2Ft+HWrB8Dz/PvBpqsoUSfWXqAAII7IG
	nUsKIcihgqzRqiOFzpSkfy4t8VwDm8GoC4K0LIOmbrQDNTr4ADyHyEhGJQsflA2TIpKnhNfyde4R/
	CwrhwbgpXmPQkScjPpA9hYEC7xUJC/fAFXduQP6B9quKHjEZlXhmJOZ/aqP2kO1mWRFh5F79FEASO
	ppaGu1tyTeqlq6whEzceHmj/UzU4dZpcE2Y2nDZEub5+YkheF+Q94iJ8BUOf9h+Nm4BKSSudRlxjU
	LRLV8HFuQ/6voj+XFDYPIZCtoitfmcQS8r5A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wQOzG-00GSKP-2p;
	Fri, 22 May 2026 20:28:23 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 May 2026 20:28:22 +0800
Date: Fri, 22 May 2026 20:28:22 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: atmel - use min3 to simplify atmel_sha_append_sg
Message-ID: <ahBL5nVfR2oCHhuO@gondor.apana.org.au>
References: <20260512145123.303311-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512145123.303311-3-thorsten.blum@linux.dev>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24447-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gondor.apana.org.au:mid,gondor.apana.org.au:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,apana.org.au:url,apana.org.au:email]
X-Rspamd-Queue-Id: 4FD495B4010
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 12, 2026 at 04:51:24PM +0200, Thorsten Blum wrote:
> Replace two consecutive min() calls with min3() to simplify the code.
> 
> And since count is unsigned and cannot be less than zero, adjust the if
> check and update the comment accordingly.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/crypto/atmel-sha.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


Return-Path: <linux-crypto+bounces-22573-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKZONhw7ymnD6gUAu9opvQ
	(envelope-from <linux-crypto+bounces-22573-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Mar 2026 10:58:04 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F381F3579BC
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Mar 2026 10:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6D263017070
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Mar 2026 08:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E583AE6FD;
	Mon, 30 Mar 2026 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="Us4rGFuy"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981C73A8757;
	Mon, 30 Mar 2026 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860692; cv=none; b=FkiUxuETjOsqX+rkk/u6gQIr853H/LIMmjNhZDa84LnzUBoKEcXe08DG0jUvudMToMvYJT0COvg6q9O+N8cZ+kNASd5wiCYO8K1aXq4k6Ugl9vTvTzcxW8PP/zxz7UkO1orh27fRjxAmANfLyLWsDXMZggsrIU9IqEO2i04ljLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860692; c=relaxed/simple;
	bh=G6QNBerDZ98GetajaXxuct5Ddi8jrV/1us3rggiuPmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfKe76N+iUN2sO9u5B60LdAOJNGNwM/R5Zuob0lpgyq3AG4+k0AKo2mrBM2TMvu1evDpm0i3vecatdLq1MARpHOlisMCYa3fNL77cm8yBDdOOBUFcnAkYLNrq0hfG6AaUWieysMR5s6RNRGQBNLeWVJLkkTR+oh7puKRq7HHKbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=Us4rGFuy; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=vllDIm3R4mkZyxMgh7GwL09LhN/fvKaSHp29p/+2HRQ=; 
	b=Us4rGFuyPG/2sBNhep65E+P+CponNoHajLXzctH3sqx3dmnMTSRmedRjNYkguWzbS+TOoraSFJa
	M7wfTuhPU8G3ZgJoVNyoFdgYM1nCYQDmK9yDroJpy6kAALDORpfV2hewYU4G/zJbz3g8NX11HMwCC
	ucpNbGGXi1gBmJPLbUj1hDi2+PbVOWsTIIrtljREhF7As2UXFfq1wVGpYitc3qFley50dPaF4HNKx
	OOlIzjT4ktlGowKqBV2G1hI0EnmSxMZ1Rg+2xZuVYXrz8yC5xlY49XIURkvdDteuvKDYwYH79Nxi8
	WnZ+8qwqq6oAtv9SDKHb2WTvppnYrHRrUSJw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w77vk-002Fjv-0I;
	Mon, 30 Mar 2026 16:51:23 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 30 Mar 2026 17:51:22 +0900
Date: Mon, 30 Mar 2026 17:51:22 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Haixin Xu <jerryxucs@gmail.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	davem@davemloft.net, smueller@chronox.de, yifanwucs@gmail.com,
	tomapufckgml@gmail.com, yuantan098@gmail.com, bird@lzu.edu.cn
Subject: Re: [PATCH 1/1] crypto: jitterentropy - replace long-held spinlock
 with mutex
Message-ID: <aco5ijLVPL8EjS8g@gondor.apana.org.au>
References: <cover.1774854094.git.jerryxucs@gmail.com>
 <9a8ef1cbcc68b752a495acf0a23e7095eb0a7796.1774854094.git.jerryxucs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8ef1cbcc68b752a495acf0a23e7095eb0a7796.1774854094.git.jerryxucs@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,chronox.de,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-22573-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,apana.org.au:email,apana.org.au:url,gondor.apana.org.au:dkim,gondor.apana.org.au:mid]
X-Rspamd-Queue-Id: F381F3579BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 03:23:46PM +0800, Haixin Xu wrote:
>
> @@ -298,7 +298,7 @@ static int jent_kcapi_random(struct crypto_rng *tfm,
>  		ret = -EINVAL;
>  	}
>  
> -	spin_unlock(&rng->jent_lock);
> +	mutex_unlock(&rng->jent_lock);

Are you sure that this function never gets called from softirq
context?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


Return-Path: <linux-crypto+bounces-22483-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIJgGD9NxmmgIAUAu9opvQ
	(envelope-from <linux-crypto+bounces-22483-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Mar 2026 10:26:23 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05935341B0C
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Mar 2026 10:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58E2B30D01FB
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Mar 2026 09:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93E73DBD69;
	Fri, 27 Mar 2026 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="KTjpiJSx"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C833DA7E7;
	Fri, 27 Mar 2026 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603254; cv=none; b=gsGnKNl5OdDQ82EShduaguT2IOymrXVuWkjkqoQaqOOnLQfAUrOND5wS7JQHpdq/6NF0TKm9bxxI6Vbb7ZCowe/ccoqxvKATmWWy+0vb89aizYIr1veYF69nHY/PyerJ6TEGqGgBssqFkg/MtroFBtl7s/6Uc+2T8X02HlsiGe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603254; c=relaxed/simple;
	bh=ivrdAm5VUl+eeUiNY/xm2VT/phomHJCnLUxoSHzSM+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNBeZSUTX+0jOPRhBkMTe9sGP9uKuVHT1cIlEDiTQk71oZaQoWG//ykYAfAus0de0pFsIqpx90K/k4E7sGzXkSJEFYCDa/VKZ7sP+tWmjYcD/0izW7xS6ctmFDBLR4upQF1gknl81P5WNpZMKbg7udqInbT0ai1WPyHpIwLnbjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=KTjpiJSx; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=34bnUCpzGUOxqBhJgEQAzk6HPfVMUpigvBxKtbkSxTQ=; 
	b=KTjpiJSxcTcFwclpUWxlhQY9FhOEM/ryC45FrwZl4Xa0v3FuRWlW5yD1lEeaAqcrE+9URbm1auP
	Kob+GdTvWJUotDFrbHRRz6iRtypzfnPinRBAD00p9HLsPPuGX3cOFmOyuQ68Xw0m1U+Wx3bJU02AS
	GY9TCvCvk9IZN8HK43IeNi9AjcvSgnnd1vK/TYLB3G5Hv8EBm+c2yPOl1uByRAYG0GyodehHtL/1B
	OEvczxuot5zJu10UMvSNSFR07546ma+/qIDzpYCdNTjGbNThVY7dvRNrZo558M79+cXk6QHCfQf+v
	02j6bY5Llkyu3a22XBuL2Fm6lcCrVgxMtwtg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w62xU-001axQ-1h;
	Fri, 27 Mar 2026 17:20:44 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Mar 2026 18:20:43 +0900
Date: Fri, 27 Mar 2026 18:20:43 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
	Ruud.Derwig@synopsys.com, manjunath.hadli@vayavyalabs.com,
	adityak@vayavyalabs.com, navami.telsang@vayavyalabs.com,
	bhoomikak@vayavyalabs.com
Subject: Re: [PATCH v11 2/4] crypto: spacc - Add SPAcc ahash support
Message-ID: <acZL65nbtfMCPHhq@gondor.apana.org.au>
References: <20260318071808.817074-1-pavitrakumarm@vayavyalabs.com>
 <20260318071808.817074-3-pavitrakumarm@vayavyalabs.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318071808.817074-3-pavitrakumarm@vayavyalabs.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22483-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:email,apana.org.au:url]
X-Rspamd-Queue-Id: 05935341B0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 12:48:06PM +0530, Pavitrakumar Managutte wrote:
>
> +		switch (salg->mode->id)	{
> +		case CRYPTO_MODE_HMAC_SHA224:
> +			rc = do_shash(salg->dev, "sha224", tctx->ipad, key,
> +				      keylen);
> +			break;

Since you're doing a giant switch statement anyway, please convert
this to use lib/crypto instead of shash.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


Return-Path: <linux-crypto+bounces-24075-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SF8kOUn3BmpUpwIAu9opvQ
	(envelope-from <linux-crypto+bounces-24075-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 12:36:57 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC8A54D769
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 12:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D23493104512
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 10:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466F33932EE;
	Fri, 15 May 2026 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="I2LpZlNx"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E043FAE0E;
	Fri, 15 May 2026 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840023; cv=none; b=Zs60CcKlUrzDZt+POReSjfShzWGLQuE3mZqDuQ2WMHXLYNVo3XC64D9mw5svNPwj3Dva83/N6NcjKD8dYrXKZiXknt890t6KcTQe6JVobLbD9zNu2jobmS0/Uh8uNfSWmIbXhyWS8reiTeFowMU7yIKcJ1GNu7PWiRquGiiRngE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840023; c=relaxed/simple;
	bh=Xi78PjpXlZvszK+qxNcsqzt38I1e858jzCyuY7TX7cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fffGyVwcPBKKASxHkzTgdIZcRY9N6MEN2rYRGDdZ66AZpUAHpdYjogM617t11QqaD09wtIsZAubfZGk5EyWdtc7fEIBYhcNi8d+SHdITd9e80pbsM7F59KvHbrkIWO83CJDavGAxAtgauOMwykxGrfL91ChuOEnWys0vSlZFqxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=I2LpZlNx; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=D8TnRVi8M9KjgoIGV6oSHFGc7P58CTtQCn54/xwvcVE=; 
	b=I2LpZlNxquU/afgLGDUatzJr8M7h+mf4wnDO8hiMX6VVSFvGy/6VD6WudIAYdoEfAlJuCkDwIGQ
	vLjBT/xVkzX2f8F2LCwqHskO3U4tpVFIFoLYyHKrL0zsdjEFgnj2Wmo2FuxVKqNf7vpGmiqwPuDzV
	3ajeSO2/8cxC/8yj1yYjuaNxp4b1XkVw59GaLr/suFOltFiFmEvsSnlYyy6WsEA/xnDAHAoDRFtYY
	clHz30XWsxO+z2ilpuRchIl94nSVR4guLrvliU9yNtP7L8Fz0YD5duhzzIvLSII/kPc31aNdIvGZA
	HqS3RpvevnG6NT/st4X/5UW5/ygvealz+8yQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wNpXx-00EOHS-0Z;
	Fri, 15 May 2026 18:13:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 15 May 2026 18:13:33 +0800
Date: Fri, 15 May 2026 18:13:33 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: ccp - Define pci_device_ids using named
 initializers
Message-ID: <agbxzTrSgEWu4w5H@gondor.apana.org.au>
References: <20260504152421.2147027-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260504152421.2147027-2-u.kleine-koenig@baylibre.com>
X-Rspamd-Queue-Id: 2DC8A54D769
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	TAGGED_FROM(0.00)[bounces-24075-lists,linux-crypto=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, May 04, 2026 at 05:24:21PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> The .driver_data member of the struct pci_device_id array was
> initialized by list expressions. This isn't easily readable if you're
> not into PCI. Using the PCI_DEVICE macro and named initializers is more
> explicit and thus easier to parse. Also skip explicit assignment of 0
> (which the compiler then takes care of) in the terminating entry.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
> Hello,
> 
> The secret plan is to make struct pci_device_id::driver_data an
> anonymous union (similar to
> https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre.com/)
> and that requires named initializers. But IMHO it's also a nice cleanup
> on its own.
> 
> The anonymous union will allow changes like the following:
> 
> -	{ PCI_VDEVICE(AMD, 0x1537), .driver_data = (kernel_ulong_t)&dev_vdata[0] },
> +	{ PCI_VDEVICE(AMD, 0x1537), .driver_data_ptr = &dev_vdata[0] },
> 
> (together with the respective change in the code when the value is
> used). This gets rid of a bunch of casts and thus slightly improves
> type safety.
> 
> Best regards
> Uwe
> 
>  drivers/crypto/ccp/sp-pci.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


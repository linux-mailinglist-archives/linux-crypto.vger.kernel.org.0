Return-Path: <linux-crypto+bounces-24928-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 75KrOTS5ImoCcwEAu9opvQ
	(envelope-from <linux-crypto+bounces-24928-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 05 Jun 2026 13:55:32 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D068F647E16
	for <lists+linux-crypto@lfdr.de>; Fri, 05 Jun 2026 13:55:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=Zx612sDk;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24928-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24928-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADC433021EBB
	for <lists+linux-crypto@lfdr.de>; Fri,  5 Jun 2026 11:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F8A4D90D8;
	Fri,  5 Jun 2026 11:48:13 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C324D90CD;
	Fri,  5 Jun 2026 11:48:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780660092; cv=none; b=WKvXA6R3nARMlAIf7NDTFaDp7yS2FPpIBKETMtOeTxjGVKjQ2tO0VCt+lWXghScFgN5JbnpSuzV0FX/a5NJy1qgHsbl9mUi8iCPssyto6n8dWqJ8H/xvSb6sLfRiWn4a/aeq2GYSMiycmXVO1vAA0CxWG5ASngJCdbqtpGDz1uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780660092; c=relaxed/simple;
	bh=aSd80DdxXs+WYidBs49MY7Uom36DWSi5hyTXnor6CQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WORk4cwXlf03qNhCOYz6adDG2fZuKab3DT8Floe4I0+1buyn5kwW7N3L7y9UQqVhnS1ynWXYEFP/ni2lbsdzCQ0hFc1zzrnsdJF8u8Yl6N8SorC6G+cn6Mc/A3TB8fFOwOkZL4wdVs7cdmkbhgs0w3zgTWM3Uw92TAfgzcajCAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=Zx612sDk; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=zlyadE4qYISd12lSmjZ2ehMfzSKYMN8+0MHuwIpIAvg=; 
	b=Zx612sDkM1ybmbtgfb2luRUpPZ0BbdmTl166Mm9tLdrHiO5adAHbeOgdFqCz0h1xt+4bKX1xN+H
	/fKomphmLHHyj58EPcf4edX7hb41ijp5xxjiXcFWaYM1zaRozwgALadRs8ZPxQA2aEU/Ruwt8vaN8
	+i9QtB/M418y2N8iUxtIvBeWN4qYY0R92MtOM4hzGlszc8PInlfW2wu4ICbG/bp52TXECH0T6wmK8
	Vq9k6HXWtJUlwRzqdjCvqBX1U1CUk0vlC1Edhk28pPWsp1MCniPRSEn14ZnD6+4PMfQvko/a6I7ZC
	331Yo6CC1TGWqVoPHpnMcQYhzLCFAu7Wg9nQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wVT1x-002ovl-2F;
	Fri, 05 Jun 2026 19:48:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Jun 2026 19:48:05 +0800
Date: Fri, 5 Jun 2026 19:48:05 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: ZongYu Wu <wuzongyu1@huawei.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, fanghao11@huawei.com,
	liulongfang@huawei.com, qianweili@huawei.com,
	wangzhou1@hisilicon.com, huangchenghai2@huawei.com,
	linwenkai6@hisilicon.com
Subject: Re: [PATCH v2 1/5] crypto: hisilicon/zip - add backlog support for
 zip
Message-ID: <aiK3dY25BJv4APu_@gondor.apana.org.au>
References: <20260528115531.174593-1-wuzongyu1@huawei.com>
 <20260528115531.174593-2-wuzongyu1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528115531.174593-2-wuzongyu1@huawei.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24928-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:wuzongyu1@huawei.com,m:davem@davemloft.net,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:fanghao11@huawei.com,m:liulongfang@huawei.com,m:qianweili@huawei.com,m:wangzhou1@hisilicon.com,m:huangchenghai2@huawei.com,m:linwenkai6@hisilicon.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,apana.org.au:url,apana.org.au:email,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D068F647E16

On Thu, May 28, 2026 at 07:55:27PM +0800, ZongYu Wu wrote:
> From: Chenghai Huang <huangchenghai2@huawei.com>
> 
> When the hardware queue is busy, requests are now queued instead of
> being failed immediately. Queued requests are retried when earlier
> requests complete, which prevents transient failures under heavy load.
> 
> The backlog path also provides a fallback mechanism while the hardware
> is temporarily unavailable, such as during device reset.
> 
> Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
> Signed-off-by: Zongyu Wu <wuzongyu1@huawei.com>
> ---
>  drivers/crypto/hisilicon/zip/zip_crypto.c | 286 ++++++++++++++--------
>  1 file changed, 183 insertions(+), 103 deletions(-)

We already have a generic queueing mechanism in the form of
crypto_engine.

Please add support for acomp to it instead of rolling your own
queueing mechanism.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


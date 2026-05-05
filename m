Return-Path: <linux-crypto+bounces-23709-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELr8Bh+p+WnF+gIAu9opvQ
	(envelope-from <linux-crypto+bounces-23709-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 05 May 2026 10:23:59 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B807D4C89D6
	for <lists+linux-crypto@lfdr.de>; Tue, 05 May 2026 10:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEC39302DF54
	for <lists+linux-crypto@lfdr.de>; Tue,  5 May 2026 08:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CB13E0245;
	Tue,  5 May 2026 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="B0+ihSpr"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AD23E4C61;
	Tue,  5 May 2026 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777969399; cv=none; b=PWL5tj2gCjZoW1mO/C5zUMUq6fnTOhq5ZsJ/1P0M3TddFt8FgVjMKThIXM16TKyTOLU5ZnrcHAS49ArEg4yuJisi/r3NG69Tute4vPOMt34wIvfOKBrmFFX813sU5nUH54bDxRje/SO7WV5o3Ah7bwyPpcVs6Kuc7P/tPxhE4Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777969399; c=relaxed/simple;
	bh=s8tRxJbbfwrCnkwj+IvJip8DNnvpQbZWo/ddocX/+VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0sWKjgVdtEzn60H9R8WvJDYYtL62ZWEVyRy+pBER1X9jyeusrQiZpcSVRN+ya+pm9Aayo9/M8UYRHJnql8JhBBsPtPcDfc85movhVOEGI2NXEFsCHjYTcFllZFJNLnW+aYF/oQTJPXSWcWEsRGWnnduePA8/7LczXXczY3kTHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=B0+ihSpr; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=AZzxSu0X3NGt+Y8kBHu5qY0cSTMYriJuRZ0POdO9TTA=; 
	b=B0+ihSpr1z/xxR2YpHkjsjuDUnSZE7p5tmXCTk05LO5WrUTbBBu+qSNDqULGXY61nGNiuszq425
	5EvZgUOzoMBB9sl/T/PNPcus0pDNTQ5I6aVAOo+RgIKDLGMsozM2BIlT9+L166EjlZdJIXm+PAE6T
	GVR2pdcsqhmYkqsl2lfMj2XlPke2AdsL36PA+BmMvEod//kcGCkOa+Hzh5edZzGS3mKixvAstaN/v
	7iUWVj0qy6js6uEXv/d8hMb6YnvQcktUbKgKg0YJye296Xyy0cyedkYL597ERbM1ZcgMoUa+ZB0Ca
	h/FKWhOr7WzDW8dxrB//YcmbNIm619ym8e7Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wKB3a-00BMcq-2K;
	Tue, 05 May 2026 16:23:07 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 05 May 2026 16:23:06 +0800
Date: Tue, 5 May 2026 16:23:06 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv2] talitos: allocate channels with main struct
Message-ID: <afmo6sJlqbjCWd9A@gondor.apana.org.au>
References: <20260505073705.8810-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505073705.8810-1-rosenp@gmail.com>
X-Rspamd-Queue-Id: B807D4C89D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23709-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[]

On Tue, May 05, 2026 at 12:37:05AM -0700, Rosen Penev wrote:
> Use a flexible array member to combine allocations.
> 
> Add __counted_by for extra runtime analysis.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: add check for of_property_read_u32
>  drivers/crypto/talitos.c | 19 +++++++------------
>  drivers/crypto/talitos.h |  5 +++--
>  2 files changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
> index bc61d0fe3514..e1f009684216 100644
> --- a/drivers/crypto/talitos.c
> +++ b/drivers/crypto/talitos.c
> @@ -3409,14 +3409,20 @@ static int talitos_probe(struct platform_device *ofdev)
>  	struct device *dev = &ofdev->dev;
>  	struct device_node *np = ofdev->dev.of_node;
>  	struct talitos_private *priv;
> +	unsigned int num_channels;
>  	int i, err;
>  	int stride;
>  	struct resource *res;
>  
> -	priv = devm_kzalloc(dev, sizeof(struct talitos_private), GFP_KERNEL);
> +	if (of_property_read_u32(np, "fsl,num-channels", &num_channels))
> +		num_channels = 0;

Does this driver still work with zero channels? It should just fail
the probe.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


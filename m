Return-Path: <linux-crypto+bounces-24812-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBgHJfvZHWpsfQkAu9opvQ
	(envelope-from <linux-crypto+bounces-24812-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 01 Jun 2026 21:14:03 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 142806247CF
	for <lists+linux-crypto@lfdr.de>; Mon, 01 Jun 2026 21:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B969302DE1C
	for <lists+linux-crypto@lfdr.de>; Mon,  1 Jun 2026 19:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B451336A34E;
	Mon,  1 Jun 2026 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TCr0M55f"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB19364024
	for <linux-crypto@vger.kernel.org>; Mon,  1 Jun 2026 19:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341238; cv=none; b=bnPfLP/1/MTzDtBjPCsMMLBIrd8jbu1FjpaPbi/3lL1+hC3XtWjLKPs/6UhhNgZUmZV3rNmfht96sxKdY/1AuQzB8ek4gbo4EPxAkZxsZdFZqPlYu+TL+OivbFUPWBjEL/Bdo17yjYQKoGKwhuWGV+MhdQqOuUbxgisgoOHDSkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341238; c=relaxed/simple;
	bh=zjkhgvnoXtd4kePl7vzYRz0aAuE6/hXf+7NEyutnvbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTsXxTdynjcedS6Lp2uJ8FujdglQR2U6r2cKRWvvaRDt9KSo+RHHAwcXINGdjfR0draTIQPRxqO2Csk7fp+zxW5d8kODfI8TiNfXk8+P+PM/HaxlUNiPgyXVSFB4bCYQCXQUkrKB03ZU1mmWa6DGUXIUTgSqy+MvH2NXYiI0PVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TCr0M55f; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 1 Jun 2026 21:13:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780341234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JUQ1Hc+I/Aj1c96UteOUubDPVimXUERGAR0RBwprXqQ=;
	b=TCr0M55f+cj+zWkW4XfeG+iVrtQgcElmfxJcHPG6EuXGJ5WkOgA0QaNKeFlHzvWRPQ5n/I
	q4OeObswfaAesrI3w77ZkRXoDC2fM9Naa8JlDRTPW0VtmfK3qoo9JCvmuT7Tx5UW9sWVkI
	lGvHf6qF/7IUEoYnZ1qaAhtfEzhyZzM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: atmel-tdes - use min3 to simplify sg_copy and
 crypt_start
Message-ID: <ah3Z7bFWz512AgTU@linux.dev>
References: <20260525092927.818586-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525092927.818586-2-thorsten.blum@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-24812-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 142806247CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 11:29:27AM +0200, Thorsten Blum wrote:
> Replace multiple min() and min_t() calls with min3() to simplify the
> code. Using min3() instead of min_t() in atmel_tdes_crypt_start() is
> safe since the values are all unsigned and compatible.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/crypto/atmel-tdes.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
> index 643e507f9c02..834c6d3e1b06 100644
> --- a/drivers/crypto/atmel-tdes.c
> +++ b/drivers/crypto/atmel-tdes.c
> @@ -143,8 +143,7 @@ static int atmel_tdes_sg_copy(struct scatterlist **sg, size_t *offset,
>  	size_t count, off = 0;
>  
>  	while (buflen && total) {
> -		count = min((*sg)->length - *offset, total);
> -		count = min(count, buflen);
> +		count = min3((*sg)->length - *offset, total, buflen);
>  
>  		if (!count)
>  			return off;
> @@ -469,8 +468,8 @@ static int atmel_tdes_crypt_start(struct atmel_tdes_dev *dd)
>  
>  
>  	if (fast)  {
> -		count = min_t(size_t, dd->total, sg_dma_len(dd->in_sg));
> -		count = min_t(size_t, count, sg_dma_len(dd->out_sg));
> +		count = min3(sg_dma_len(dd->in_sg), sg_dma_len(dd->out_sg),
> +			     dd->total);
>  
>  		err = dma_map_sg(dd->dev, dd->in_sg, 1, DMA_TO_DEVICE);
>  		if (!err) {

This should probably be dropped for now because of this fix:
https://lore.kernel.org/lkml/20260531204115.689052-3-thorsten.blum@linux.dev/

Thanks,
Thorsten


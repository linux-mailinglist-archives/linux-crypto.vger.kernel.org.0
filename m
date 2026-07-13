Return-Path: <linux-crypto+bounces-25911-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2MZjBS/TVGp/fQAAu9opvQ
	(envelope-from <linux-crypto+bounces-25911-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 13:59:43 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D3274AA42
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 13:59:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=XapGZfWf;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25911-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25911-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37E69303CC30
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 11:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F1C3F54A0;
	Mon, 13 Jul 2026 11:58:25 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637F613B584;
	Mon, 13 Jul 2026 11:58:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783943905; cv=none; b=s0IH9FR3wceW0LEQ1yb+doseOCj4J3wYiTyscCh8WGVfSmnrPXovbfYX+xvo72IU8DD37H59egqLc+D1syKfCIi1QljRLYCTB+5ZuKsQ5CswkwHmVD5wY24dfQQxBMyeqNBNNq8rIfqFu6fQxuWqyWCR42L1W8w6rhHGxMvoQ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783943905; c=relaxed/simple;
	bh=ohwl+NNZhM3tc2Svo5D4PPwHbHssItFhLlreVZUvKhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JM1bQrv9k2DCKe/FU09QULpgHdfbjKA0fjDkEwtsAuBnbEH8siL4E8z5Ll3+1JE9r6QLIUVYG+J0K4fVy1Bej8hS2BXQTyzwhGPSnshyHPt0NgfQ3kKa8mqGW8wv7q5smSVGNPdkTeK4N9kO+mBPoM4gHgnYVBMjPnMovsClK80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XapGZfWf; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B97A1576;
	Mon, 13 Jul 2026 04:58:18 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 900F03F7B4;
	Mon, 13 Jul 2026 04:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783943902; bh=ohwl+NNZhM3tc2Svo5D4PPwHbHssItFhLlreVZUvKhk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XapGZfWfK9osfIfcG32IEYSYOtQGC+I2rtd4HPYv7Gtyl9/QcllKwTsDOCxmfGyam
	 URrOHMTqmPs5DUgUuriFWgHphPzgHY4BLCsM3Krg7FwPTMWyX34DuatMpcpzJIZyTe
	 +8EWKL996I63gGJqAnlqTbYWuA5nRJ0KBA/YsbO8=
Message-ID: <3d606437-ab63-41e7-88d3-fb6e47014a8a@arm.com>
Date: Mon, 13 Jul 2026 12:58:19 +0100
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: cesa: check for sram_dma NULL
To: Rosen Penev <rosenp@gmail.com>, linux-crypto@vger.kernel.org
Cc: Srujana Challa <schalla@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Boris Brezillon <bbrezillon@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260713050740.3687230-1-rosenp@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260713050740.3687230-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25911-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:linux-crypto@vger.kernel.org,m:schalla@marvell.com,m:bbhushan2@marvell.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:bbrezillon@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[robin.murphy@arm.com,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:from_mime,arm.com:dkim,arm.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57D3274AA42

On 13/07/2026 6:07 am, Rosen Penev wrote:
> dma_map_resource() might fail. In such a case, don't call
> dma_unmap_resource()

Hmm, AFAICS it's more that if *anything* in mv_cesa_get_sram() fails, we 
could end up calling dma_unmap_resource() via the cleanup path for 
subsequent engines which never had their mv_cesa_get_sram() call at all 
(and thus all of engine->pool, engine->sram and engine->sram_dma will be 
unset). While for one where dma_map_resource() itself did fail, 
engine->sram_dma will be non-NULL here (but still invalid to unmap). I 
think this needs a bit more work to differentiate between the 
successfully initialised state which needs cleanup, and the partially or 
fully-uninitialised states which don't.

Thanks,
Robin.

> Fixes: 37d728f76c41 ("crypto: marvell/cesa - Fix DMA API misuse")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/crypto/marvell/cesa/cesa.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/marvell/cesa/cesa.c b/drivers/crypto/marvell/cesa/cesa.c
> index 57c9295be711..bcbb909c48d8 100644
> --- a/drivers/crypto/marvell/cesa/cesa.c
> +++ b/drivers/crypto/marvell/cesa/cesa.c
> @@ -406,7 +406,7 @@ static void mv_cesa_put_sram(struct platform_device *pdev, int idx)
>   	if (engine->pool)
>   		gen_pool_free(engine->pool, (unsigned long)engine->sram_pool,
>   			      cesa->sram_size);
> -	else
> +	else if (engine->sram_dma)
>   		dma_unmap_resource(cesa->dev, engine->sram_dma,
>   				   cesa->sram_size, DMA_BIDIRECTIONAL, 0);
>   }



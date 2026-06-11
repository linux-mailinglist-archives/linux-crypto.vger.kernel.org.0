Return-Path: <linux-crypto+bounces-25073-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qyQEGbN3KmrqpwMAu9opvQ
	(envelope-from <linux-crypto+bounces-25073-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 10:54:11 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C0E6700D3
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 10:54:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=FVQOzdz+;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25073-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25073-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D01E73045AB5
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 08:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A9F38F25F;
	Thu, 11 Jun 2026 08:54:01 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EE738D404;
	Thu, 11 Jun 2026 08:53:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168041; cv=none; b=fBuo/4QJZyaxHMpf4c4Yg7nPBfNdImyqYvaKcVR92VKaMX4178A52JzyYlf9DNDUgGUtEPLkExR/4BZXT346/EAi3KqXE3VgkdM4iWLcN/Onw7YOJNruazLHAhytonsVOJ+hE7x1hz9AUdJA7h3nbeb417/kCg/UeA7JBeHYkgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168041; c=relaxed/simple;
	bh=/wxBMEUhN3ByWnFQe9UC6D4pJA1lgI719i1WRKwf77U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijLBgCalgriADU59TBANopUdr2iPhayW0Yno/pUqkuwbS2SyXcvitdlEpgDjowoetBZ6CLehPIxVTGm/vu7sbpOZdOM5kupDPNXDpgsRqLrMp53vu0G9rGEIW2y4mFwXpeTS2PG6/7RfqDSn5qSUp/9nFFv1842SvttbcdExX3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=FVQOzdz+; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=7RT/e/rEU6HtQrgQutT6dH2HWck7fSGFRVH+ob7Y5Jg=; 
	b=FVQOzdz+wvnLw9SCgjzPpZPLLufKeRL4/TWdQpv2RlD/PhCWDmMJOLlo8gJ/B59Bijw47SG20ZH
	2DiisZJrH5292MvKK/gdvfHBm63WGoLaVDXg9onW8swEllXwURN/7SVZXcyCSfNYIPJxbV+yL6AAK
	0n5GqtMMRfFiRglXlkx1n+k+XodNOta10gjlsPT7YAj68ULcsVXrWWGAFlIEMSasYWCMPyFUYeQvl
	iYjVCkJVwDbCDWIjwXVC/vY0pnD0AQ1rQc18+5gDoGgAza32POb3v7Sl8/FdYWv9gtdPACNRQ2o7y
	9/se2bWHCC5tT6nNmENp3LpbPCnAW2W94Heg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wXbAh-00000004Xbs-2xVM;
	Thu, 11 Jun 2026 16:53:56 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 11 Jun 2026 16:53:55 +0800
Date: Thu, 11 Jun 2026 16:53:55 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Lukasz Bartosik <lbartosik@marvell.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: marvell/octeontx - fix DMA cleanup using wrong
 loop index
Message-ID: <aip3o32MIAMrrHah@gondor.apana.org.au>
References: <20260602-otx-v1-1-e0c9ec50cb04@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-otx-v1-1-e0c9ec50cb04@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-25073-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ustc.gu@gmail.com,m:schalla@marvell.com,m:bbhushan2@marvell.com,m:davem@davemloft.net,m:lbartosik@marvell.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ustcgu@gmail.com,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8C0E6700D3

On Tue, Jun 02, 2026 at 10:38:26PM +0800, Felix Gu wrote:
> The sg_cleanup path used list[i] instead of list[j] when unmapping DMA
> buffers, leaking successfully mapped entries and repeatedly unmapping
> the failed one.
> 
> Fixes: 10b4f09491bf ("crypto: marvell - add the Virtual Function driver for CPT")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>  drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


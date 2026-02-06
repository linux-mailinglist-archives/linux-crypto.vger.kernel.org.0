Return-Path: <linux-crypto+bounces-20627-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKiDFhHKhWlAGgQAu9opvQ
	(envelope-from <linux-crypto+bounces-20627-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 06 Feb 2026 12:01:37 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B58F0FCF3A
	for <lists+linux-crypto@lfdr.de>; Fri, 06 Feb 2026 12:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC58230364ED
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Feb 2026 11:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE243793A0;
	Fri,  6 Feb 2026 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="b429vx0J"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452F9396B88;
	Fri,  6 Feb 2026 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770375615; cv=none; b=BLJC9z/BQvBaH/oKHJNBrkCxLIUnG96jPpBRfRoBS8GyyphwlioK+WbgdAYlkn8hFG3gql57pRlX8GEX2MlNdVS9y5WHkzsZlm/y3u8isJFtl/gkjlIeZ2mM5AnijryTKpLH9wItJrHRk5Kys28Q8tjjVs6qSV2GbbLvhhrIKYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770375615; c=relaxed/simple;
	bh=gb3tFe3rCSupQVrmvnRn4/Q2tBZ/pSu0D/SJHg1RxE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcoFJ7ZGn5Fc0pC+d0SGdyOkTdqNRKSul8eGdsiyLwQelpn1NBuh2D0XQ0yNCuqX45gdTBzItuYRtCgNzQf+UkfEXgYaa4ahnsN0FtlPoXmKdSuOtBk/efm+6iPQMq5+5H1fsAzYW9Wdfs0528a7ZoTVeS13jl4uD5OP5PPKcAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=b429vx0J; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=eY31VWKjjKFCDbP/iKZlszltMN4iCpQJ6Gpd4y7c7DQ=; 
	b=b429vx0Jf3nGkoa7kuhYpnlZaZFgvCEXpqXiNi0ef2s07uQhdQIxmU1w0+ocUHAhGduwL/PbFAQ
	oHi4f6Q2jjQ0hranQ4RZVtflUdU+e+jLarIkl9qfldky2+gi2nUEdoDD9fLXlD+j16R4oy8PhCn5f
	B5Tl8i3/XSbFY1PqUVCWghkzbvJ3kqpCuCKKSYntBkjZWORxeIBRDh7PNgjr7ESweAjfSuNvsNu/Q
	IfXke0Rduoye7Hd6CVZEcVePs/FDOf9TUlBNEuV5VY9Rp+fMciePM9rl97m87XGnZJXTeovclg4v9
	eBdhoSnRdy4Ftvoj9QJmcToDEFE2h05KYCog==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1voJZD-004zWH-01;
	Fri, 06 Feb 2026 19:00:04 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 06 Feb 2026 19:00:03 +0800
Date: Fri, 6 Feb 2026 19:00:02 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: jiajie.ho@starfivetech.com, william.qiu@starfivetech.com,
	davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: starfive - Fix memory leak in
 starfive_aes_aead_do_one_req()
Message-ID: <aYXJsgvEp9FtCnl1@gondor.apana.org.au>
References: <20260129151016.1131652-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129151016.1131652-1-zilin@seu.edu.cn>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20627-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gondor.apana.org.au:mid,gondor.apana.org.au:dkim,seu.edu.cn:email,apana.org.au:url,apana.org.au:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B58F0FCF3A
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 03:10:16PM +0000, Zilin Guan wrote:
> The starfive_aes_aead_do_one_req() function allocates rctx->adata with
> kzalloc() but fails to free it if sg_copy_to_buffer() or
> starfive_aes_hw_init() fails, which lead to memory leaks.
> 
> Since rctx->adata is unconditionally freed after the write_adata
> operations, ensure consistent cleanup by freeing the allocation in these
> earlier error paths as well.
> 
> Compile tested only. Issue found using a prototype static analysis tool
> and code review.
> 
> Fixes: 7467147ef9bf ("crypto: starfive - Use dma for aes requests")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
>  drivers/crypto/starfive/jh7110-aes.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


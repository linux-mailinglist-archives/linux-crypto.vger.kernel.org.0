Return-Path: <linux-crypto+bounces-24084-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePi6H8v7Bmp1qQIAu9opvQ
	(envelope-from <linux-crypto+bounces-24084-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 12:56:11 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 876FE54DD9E
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 12:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A2A5D30C2394
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 10:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00153CF020;
	Fri, 15 May 2026 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="EzncRejt"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458163CC327;
	Fri, 15 May 2026 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840462; cv=none; b=PiV/RVmcrmSPwgZE1Q47CVkAolywZIaYrEf1mEcw1wxrR6m1eJaKkPcbVJgcYw17LE7OqcZIiTCbB/WhRmOKVCdYX3n1DabPmd7S4lD4EZSbLZWbO2kN14afXY8DkzNKkijKCu3OcnFuN1Ny+ZLonQLJlFcZqyUQO8jmXJLa36A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840462; c=relaxed/simple;
	bh=jW9+hyUk89tROv/CUiYPBch07KZS1X7tVp5pERha0xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRTNTOnZeUm46NUVBqoDiK9PfQdPMt1pUn69OHg/H65xVj5mNByMmRH6CeTrVL1XxeYj6AArW+8iAkJNtYLGNmJUax/MZGhQNoK7hXpMBGAhPIPG0FaXhiuFoaJ7qv7ynXwJ7nvGeYZNpG7GYbuRHxj14uZUq0TSl2TtqjIV5So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=EzncRejt; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=0kyPMlQARZP2pYYuzJPhhL9xAltKRy/0OBEHZAXtFTE=; 
	b=EzncRejt6b6DbVEvyoMLG2PRONuSeZvLGjSp1P+TYNjDDO2t+HD1qcjqUzTxSetsp4pXXYJYUdz
	X5+fnCiYtOZITgzcrlpqs/092Xz2mpjCdkLLoZ97nw7zfBPzdJeCH4jwyKGIhNs7SkbKexZ+FGlMX
	hdeeEMefkOM/k+lrkl5i8H58bzNzVCI5RUy9Jjij7IE4WInnt7ES8VsU51WOkPavRLI2Z8srDoBGZ
	AU9QBxsGh9j8FSwF1b/SCJNeCHLobd1HCUNUrW/4WZWkANeBogUqOedXbH4SBsUxavbnSBWDPaMIl
	nyaKrFEM7HysBbbc/PNb5EzEXH+NOzI4KdQQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wNpf5-00EOUK-12;
	Fri, 15 May 2026 18:20:56 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 15 May 2026 18:20:55 +0800
Date: Fri, 15 May 2026 18:20:55 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] talitos: allocate channels with main struct
Message-ID: <agbzhy4GoAwmtxEB@gondor.apana.org.au>
References: <20260506085653.1211263-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506085653.1211263-1-rosenp@gmail.com>
X-Rspamd-Queue-Id: 876FE54DD9E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24084-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 01:56:53AM -0700, Rosen Penev wrote:
> Use a flexible array member to combine allocations.
> 
> Add __counted_by for extra runtime analysis.
> 
> Error in case of no channels as they are required.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: error when no channels
>  drivers/crypto/talitos.c | 19 +++++++------------
>  drivers/crypto/talitos.h |  5 +++--
>  2 files changed, 10 insertions(+), 14 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


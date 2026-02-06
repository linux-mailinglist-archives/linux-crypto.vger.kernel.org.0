Return-Path: <linux-crypto+bounces-20619-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oL6GC2vHhWnAGAQAu9opvQ
	(envelope-from <linux-crypto+bounces-20619-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 06 Feb 2026 11:50:19 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3F2FCD09
	for <lists+linux-crypto@lfdr.de>; Fri, 06 Feb 2026 11:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE4413045C3E
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Feb 2026 10:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502C9389445;
	Fri,  6 Feb 2026 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="HWLXCPne"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1055935FF6E;
	Fri,  6 Feb 2026 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770374907; cv=none; b=IwUUCBRRtrXKfGlNBXwwD5Po6F48M4bnB8iZ5NUiTJKJPQMFmdcGZjXCiK7BOypYNpEO7zIyW2vxv40bFT7gyvdL4L03k1elgi8kUX5f4bmCBN6H/S2/7BOmNLUwOKvNs3AtWtMl378qIhG3qkRJoVK5xtR2OuUEV4pmeQRb2/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770374907; c=relaxed/simple;
	bh=xZahdDcIiXNmiWiQpPqsuGaQ2D81aGB8Ufd1t8I0GWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAF3W5kvl1gPBJ/3PyGtZuckXbjnijKmcIkJ26oWUPeil9H24UIaauJXPF5svC1dIzany/Zxynu4c1qvjHxEYv6cbcpWfLpDzNBAr6mSymTtp4z624+1Yq3lkOxIXGwIujiZo/AVuYVQ9+0nr3vzxucp4x8gNYtBojfKH+7iMH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=HWLXCPne; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=FnLp+WfYpx0MNvkgCWm/fXSiKjmhsszDBOKmLwjwMCM=; 
	b=HWLXCPneoPqOp2feilbLaD8sWXv+kMGDHjz5oVF5J6FrhZMF9zOfUEenLetiTDLcubVGHb3CP6w
	R/kYrwQPJdPGD2DX7HGMmM9dkwpo8J4oRiKfPR6laFL2qe9emMStjQtG08/cDXsgvDa4J15xOYH/1
	/7vGAwLRfRu1FgiWAk0noV7ZCwq/E4pRL39BVpZkdbIU2SX7bXqgPL/AlrNisk+q048ckcorGoso2
	JWw4WTteqABY03wXPgqiJ6UXHd4jaoG7t01QPHor2NuDeCHztvJL6icR93opPsV5pSCIF19Szh+/a
	OY1G7qcUe8Z3Y6eqaLvJhmN4WXoNGMFJEkRg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1voJNV-004zIe-0o;
	Fri, 06 Feb 2026 18:47:58 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 06 Feb 2026 18:47:57 +0800
Date: Fri, 6 Feb 2026 18:47:57 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org,
	yosry.ahmed@linux.dev, nphamcs@gmail.com, chengming.zhou@linux.dev,
	usamaarif642@gmail.com, ryan.roberts@arm.com, 21cnbao@gmail.com,
	ying.huang@linux.alibaba.com, akpm@linux-foundation.org,
	senozhatsky@chromium.org, sj@kernel.org, kasong@tencent.com,
	linux-crypto@vger.kernel.org, davem@davemloft.net,
	clabbe@baylibre.com, ardb@kernel.org, ebiggers@google.com,
	surenb@google.com, kristen.c.accardi@intel.com,
	vinicius.gomes@intel.com, giovanni.cabiddu@intel.com,
	wajdi.k.feghali@intel.com
Subject: Re: [PATCH v14 02/26] crypto: iaa - Replace sprintf with sysfs_emit
 in sysfs show functions
Message-ID: <aYXG3RF4PltO9wtA@gondor.apana.org.au>
References: <20260125033537.334628-1-kanchana.p.sridhar@intel.com>
 <20260125033537.334628-3-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125033537.334628-3-kanchana.p.sridhar@intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,gmail.com,arm.com,linux.alibaba.com,linux-foundation.org,chromium.org,kernel.org,tencent.com,davemloft.net,baylibre.com,google.com,intel.com];
	TAGGED_FROM(0.00)[bounces-20619-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,apana.org.au:url,apana.org.au:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 7F3F2FCD09
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 07:35:13PM -0800, Kanchana P Sridhar wrote:
> Replace sprintf() with sysfs_emit() in verify_compress_show() and
> sync_mode_show(). sysfs_emit() is preferred to format sysfs output as it
> provides better bounds checking.  No functional changes.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> Acked-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> ---
>  drivers/crypto/intel/iaa/iaa_crypto_main.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

This patch has already been applied to cryptodev.  Please rebase
your patches.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


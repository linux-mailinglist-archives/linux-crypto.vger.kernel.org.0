Return-Path: <linux-crypto+bounces-20290-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAMlBgkOc2ntrwAAu9opvQ
	(envelope-from <linux-crypto+bounces-20290-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Jan 2026 06:58:33 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA7670A59
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Jan 2026 06:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B34E13007AC8
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Jan 2026 05:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FBF396D2A;
	Fri, 23 Jan 2026 05:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="NN/vS+KR"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4702037648D;
	Fri, 23 Jan 2026 05:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769147902; cv=none; b=QcIaynldiWguMNAk/FUQceGncP/lUvBgLqZDeVTd+y29k8xjL8rxgZ66eGXe70dU62/PhrLeepTb51sFs72rliOx45RSlS8vZmd5awFKEwtWsLbyTZsccNVgdw26GS4KIsnj6+eBqsrWBoZUlLSO7dHjShYGviK7KMFnCEbXGwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769147902; c=relaxed/simple;
	bh=gCfIEkwtlVOW1vh1W9KXZ/IsPBlSCJD5kc47XzgwUKA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rQzYx5hETNggcDSQTFp1VQX5R13gg3KpMx084cpX1aT/YPQhoXJh+UBQ4sRkiq30Vb3YLuXdgqQoWsc5hRGev8NLEQlaUiNyGpVQzeq8xEshCAye8R/cn00V/hT+qD/MuC+4yqZA+Xo0Y8ZJSRlNUfjshFmdl/UAJeezPZ0vv5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=NN/vS+KR; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=s+Wo3iM2icQGPV6vcWu3/JhRLr/ikfaLTZIuEs7rhvs=; b=NN/vS+KRYZzpKhU9w3Zlkz646s
	1zqL+KNg/pMfLhyRVyL60ydBW4CRb0b8+YIxy7/lA7sGL95iCuDBl5yMKaJbILtVuEACvf89FIM8o
	seLqdUev1xhrya+hjVNyKoMJJCp/paGAjfLQjGchry3BZMF7Ws8pB8L31meXlgC9mghMC5R0zgiL2
	4pT+hlkaApm0j203xYKCkdntAsGLQSC/iiGMkSgxbNskJaa7s/0IHuZ0xH5AonZeP3sHGGwN+PhZn
	977OPw8JvKFyiXP7VZSqVF+bT0mtK+1AbJtKIWz7JcFCmfeWyI6mrHg51XQW/Yp5kbLs9Yl1BKmkq
	XJDqv4yg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vjABJ-001VO1-0W;
	Fri, 23 Jan 2026 13:58:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 23 Jan 2026 13:58:05 +0800
Date: Fri, 23 Jan 2026 13:58:05 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: steffen.klassert@secunet.com, daniel.m.jordan@oracle.com,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@weissschuh.net
Subject: Re: [PATCH] padata: Constify padata_sysfs_entry structs
Message-ID: <aXMN7Rqgn5-GIon9@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251226-sysfs-const-attr-padata-v1-1-8f1cf55bd164@weissschuh.net>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20290-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:url,apana.org.au:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gondor.apana.org.au:mid,gondor.apana.org.au:dkim,weissschuh.net:email]
X-Rspamd-Queue-Id: CFA7670A59
X-Rspamd-Action: no action

Thomas Weiﬂschuh <linux@weissschuh.net> wrote:
> These structs are never modified.
> 
> To prevent malicious or accidental modifications due to bugs,
> mark them as const.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> kernel/padata.c | 22 +++++++++++-----------
> 1 file changed, 11 insertions(+), 11 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


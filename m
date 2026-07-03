Return-Path: <linux-crypto+bounces-25561-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s3+nAY5iR2obXgAAu9opvQ
	(envelope-from <linux-crypto+bounces-25561-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 03 Jul 2026 09:19:42 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D93C26FF7CF
	for <lists+linux-crypto@lfdr.de>; Fri, 03 Jul 2026 09:19:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b="Z9G/Dfyi";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25561-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25561-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 019E33023D82
	for <lists+linux-crypto@lfdr.de>; Fri,  3 Jul 2026 07:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BBF2EEE9E;
	Fri,  3 Jul 2026 07:18:18 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1C22C21D9;
	Fri,  3 Jul 2026 07:18:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063098; cv=none; b=bwj6sBJAEbTyte4AVXgWMmhMJoLdEMUPh7U5kZEQDgEDtKzrCiAyH8gL61cHw5Sl8UtLnwdikiKYr/af2giSSp9YC06IGdG8Oj6nVJwiTzzUXF6dQDq21NXVfTDC4hz0zjVVgka40gCyDAyeCzI94r8xQ6Sb6IHzDFeiuLLHhc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063098; c=relaxed/simple;
	bh=9j1rleesf6eU1gz52aImXaulF7Yq0IZ9pa+dr53kFDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCgusXsRxiCyz9FnS52TtFCMFrsyyq3iybbHDH2Bf+2wRQLJXiJMG/4wy3cTqXmI1FQF9xfj6DL8g9b8IAUcK6ZXLAAFWQRJPnIJKBL7sIDdtmZskmoxwoB/umndisfqoZRH2F+GxNBON2Tq4ZIl682fa4c5Lfuo1c7e7odz/JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=Z9G/Dfyi; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=PRFdd3N33TY7ztrR7vrjtBo7P1zO+yDY2pFBvFjUSL4=; 
	b=Z9G/DfyiyKf7kQrh6hDsOLBOtnwGQKqgYRTXgVjaVc6/XJB4p00GcMEz1DLd4gxrydQLuIDd8D9
	we96TxP3PVYMzmaCYlBhdpZAJ5fChKKLiiHaN3PlsOXNeRbmlylbN7+RI1967ZqpyZ/oXOrn3Vn46
	ZutZx0QQeGCzsgx/qqFdEXgV1blS8EmaYVV/ZuI19BW1W9WmJc8N+RPelj9z7RxrSOXcNmzyaeGSh
	pK0ja+Q+1v1LKD9F66dTF7a2bbVwPBLrIEZZ9SXaXa//KhIn2KlDclX23oyBd9tK9M+hMhY6mZYjS
	JaTDNYhCY5XbmBB4bCbqhExiS7Z/cD6SB5qA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wfYA6-0000000AHne-42Nu;
	Fri, 03 Jul 2026 15:18:12 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 Jul 2026 15:18:10 +0800
Date: Fri, 3 Jul 2026 15:18:10 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Paul Louvel <paul.louvel@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Christophe Leroy <chleroy@kernel.org>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/19] crypto: talitos/hash - Use
 CRYPTO_AHASH_BLOCK_ONLY API
Message-ID: <akdiMro0yKwwicaa@gondor.apana.org.au>
References: <20260611-7-1-rc1_talitos_cleanup-v2-0-aa4a813ce69b@bootlin.com>
 <20260611-7-1-rc1_talitos_cleanup-v2-1-aa4a813ce69b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-7-1-rc1_talitos_cleanup-v2-1-aa4a813ce69b@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25561-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:paul.louvel@bootlin.com,m:davem@davemloft.net,m:thomas.petazzoni@bootlin.com,m:herve.codina@bootlin.com,m:chleroy@kernel.org,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D93C26FF7CF

On Thu, Jun 11, 2026 at 09:35:55AM +0200, Paul Louvel wrote:
>
> @@ -2932,8 +2861,11 @@ static struct talitos_alg_template driver_algs[] = {
>  				.cra_name = "md5",
>  				.cra_driver_name = "md5-talitos",
>  				.cra_blocksize = MD5_HMAC_BLOCK_SIZE,
> +				.cra_reqsize = sizeof(struct talitos_ahash_req_ctx),
>  				.cra_flags = CRYPTO_ALG_ASYNC |
> -					     CRYPTO_ALG_ALLOCATES_MEMORY,
> +					     CRYPTO_ALG_ALLOCATES_MEMORY |
> +					     CRYPTO_AHASH_ALG_BLOCK_ONLY |
> +					     CRYPTO_AHASH_ALG_FINAL_NONZERO,

Sorry, but the FINAL_NONZERO flag doesn't work for algorithms like
md5.

The reason is that all implementations of md5 must accept the exports
from each other.  So as long as the generic md5 doesn't not set
FINAL_NONZERO, your driver will need to be able to take that on
import.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


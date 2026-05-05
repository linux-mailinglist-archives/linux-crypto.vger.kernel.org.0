Return-Path: <linux-crypto+bounces-23726-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH04Lk+3+WmNBAMAu9opvQ
	(envelope-from <linux-crypto+bounces-23726-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 05 May 2026 11:24:31 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB014C9923
	for <lists+linux-crypto@lfdr.de>; Tue, 05 May 2026 11:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D38693017E76
	for <lists+linux-crypto@lfdr.de>; Tue,  5 May 2026 09:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B509031AA87;
	Tue,  5 May 2026 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="Y41gk5U8"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E5431714B;
	Tue,  5 May 2026 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973056; cv=none; b=GZ1GEuSBQBv6XvEnuECp46C7EwOWeOV+KKk745m6Edd01+YMC6byv8P4iFoAW3kcoVF4sT1DNlhbfi1md1JPmPBbMGpR5OuKIY4b0iBBVFudvPevIMyZs31sVuenp7LI6vA5Km9eI4OByBgO7fXZNl5WkylPPnydEeYRINeG/C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973056; c=relaxed/simple;
	bh=XPNYtDiy6DFzgDoTIr6WbLXow7kyb9R9vsR6xnW/AUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwMQShE0U5I4hyrixi+Kim6/cFN4zJ3wHRG3GqUkSLjgcUh84v0/hl1xoH0zMWWRSPcdy6wpn6Axa562vIAH5MLAG6xH024rCSgRC7gRg07EPD4yLKR0oMmVidAJGM7lnfC38GZJWsHpmdcCa7OThml1Dpg1Nuud/k7BsDZfXxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=Y41gk5U8; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=0iFjxSowMvuMBQYdWrDTkbNzEcz8jfIC8K0vfmREwfM=; 
	b=Y41gk5U8Cns3zRxaKmmQVn8+A39mLYqXQrFvAMToSrCH5Wwdvb7LjOuBDRguIIZHielES7s3kKG
	R461lbkcS8Z/Cd37DK2yKFFd3DovVSeiDSUBn0bMxOLNIM18FSDJEXR7zEKRhY5Fxbs2Qs+Uww2v9
	DktsMswR9CNGzrvsYyIizGkWvqs3bBUlu8T4sT4jKGACBiJ5PhbY47lqbniFN8ce9KlWAwJkQotwd
	n3gYQntFEz0nC3NHsXnqbROXpoabdnlTdhMhVTRBg8UccWaOKBZZ2Gu+KNQW/p7MthpiRbZYBQ5i4
	lJpxlubiKGt3WYhppMLSS80SPN0pf3LbbdJQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wKC0X-00BNlw-0J;
	Tue, 05 May 2026 17:24:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 05 May 2026 17:24:01 +0800
Date: Tue, 5 May 2026 17:24:01 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Eric Biggers <ebiggers@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Ovidiu Panait <ovidiu.panait.oss@gmail.com>,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: sun8i-ss - avoid hash and rng references
Message-ID: <afm3MTvlJUKv87AN@gondor.apana.org.au>
References: <20260423065600.2081989-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423065600.2081989-1-arnd@kernel.org>
X-Rspamd-Queue-Id: 5DB014C9923
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,sholland.org,arndb.de,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23726-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]

On Thu, Apr 23, 2026 at 08:55:42AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> While the sun4i-ss and sun8i-ce drivers started selecting CRYPTO_RNG,
> the sun8i-ss variant does not, and causes a link failure:
> 
> aarch64-linux-ld: drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.o: in function `sun8i_ss_unregister_algs':
> sun8i-ss-core.c:(.text.sun8i_ss_unregister_algs+0x94): undefined reference to `crypto_unregister_rng'
> aarch64-linux-ld: drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.o: in function `sun8i_ss_probe':
> sun8i-ss-core.c:(.text.sun8i_ss_probe+0x40c): undefined reference to `crypto_register_rng'
> 
> Looking more closely, I see that all of the allwinner crypto drivers have the
> same logic where the rng and hash parts of the driver are optional, but then the
> generic code is still selected, which is a bit inconsistent, aside from the
> missing CRYPTO_RNG select on sun8i-ss.
> 
> Change the approach so only the bits that are actually used are built, using
> ifdef checks around the optional portions that match the optional references
> to the sub-drivers.
> 
> Ideally the drivers would get reworked in a way that keeps all the bits
> related to the skcipher/ahash/rng codecs in the respective sub-drivers,
> rather than having a common driver that knows about all of these.
> 
> Fixes: cdadc1435937 ("crypto: cryptomgr - Select algorithm types only when CRYPTO_SELFTESTS")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> The simpler approach would be to add even more 'select' statements
> ---
>  drivers/crypto/allwinner/Kconfig                  |  2 --
>  drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c |  8 ++++++++
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 12 ++++++++++++
>  drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c | 12 ++++++++++++
>  4 files changed, 32 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


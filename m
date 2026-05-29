Return-Path: <linux-crypto+bounces-24698-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCmMHSMsGWogrwgAu9opvQ
	(envelope-from <linux-crypto+bounces-24698-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 29 May 2026 08:03:15 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BDD5FDB5F
	for <lists+linux-crypto@lfdr.de>; Fri, 29 May 2026 08:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B07DD306A974
	for <lists+linux-crypto@lfdr.de>; Fri, 29 May 2026 06:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5812E36D512;
	Fri, 29 May 2026 06:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="WBrq4d+o"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D441C5799;
	Fri, 29 May 2026 06:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780034567; cv=none; b=XawpqPdKro5UDU/xWUf63Dh854okPuJ+0/kY6kzuGACmWyiQHJgaixb7TLZiYF7C2DLfcXGMBk0zkbQCfvkMRID0txm0NO4bAXxb98kIPyW+OpJOPHKZVb5m8tLpJMAp2xnqNc2EbmjbvcMc24SlNPwsAUoNOZYOqBsNJngQWOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780034567; c=relaxed/simple;
	bh=YaWDiFRGUA++NkyEGhrt6qbDxdbwfTw1Uj2b47SF9g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNtGhcA9YwxCGsChEekbw/TazhzZl5FCmO0g3pA1BKS1cBGf68iIAE4L/vswJt7OKpjNcg6yQWyWtPRG1mFXoFOw517Na56IBuZAnQU20RC5+xFKv9/ILRLz5ROD8vpj2kWTcJm/JRa40WRFxele4kSuN1M9xeMHuUZYDcV+/SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=WBrq4d+o; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=8bnKmxC52GLCZuQR2/K5yUFJK7C3/40LM1QGIO+W7gs=; 
	b=WBrq4d+ogwqXWwvCgpR4z9CUnERscO04wktu6Guaqr62plL3OSKSKPZNaVOcGWRAE9bgegp1e+C
	aAzwEOr15mzfnZzf++/iblZcNbI9/E+Ha49gt8Xh5laPg/8B0I/JHEkYqpolfaTYalFiula5Aw7CV
	QGWEGVghDnOWV1mhdmwHunqqXlWDIKU8ffwCw/U/2EkpRDr+7MCnRIvWCZbBZylQY5E9GQ3Ft/3y8
	/rw2Wdc/qmstQWt/v9d3CFQfOTYFADgwvPQMj4wX1Y+6Yxgn7/VHIeuQnAVlHQ6rlVIyRGgjOjB3o
	TFyy/t0JEvP8naBYe/Ozpi/VG9F7FY+vWbSg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wSqIj-000dAy-1V;
	Fri, 29 May 2026 14:02:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 29 May 2026 14:02:33 +0800
Date: Fri, 29 May 2026 14:02:33 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Patrick Steuer <patrick.steuer@de.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: crypto: add select CRYPTO_AEAD for aes
Message-ID: <ahkr-efyVqgF9hOr@gondor.apana.org.au>
References: <20260520073911.843561-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520073911.843561-1-arnd@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24698-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,arndb.de:email,apana.org.au:url,apana.org.au:email,gondor.apana.org.au:mid,gondor.apana.org.au:dkim]
X-Rspamd-Queue-Id: E6BDD5FDB5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 09:38:44AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The aes driver registers both skcipher and aead algorithms,
> but when aead is not enabled this causes a link failure:
> 
> s390-linux-ld: arch/s390/crypto/aes_s390.o: in function `aes_s390_fini':
> arch/s390/crypto/aes_s390.c:969:(.text+0x115e): undefined reference to `crypto_unregister_aead'
> s390-linux-ld: arch/s390/crypto/aes_s390.o: in function `aes_s390_init':
> arch/s390/crypto/aes_s390.c:1028:(.init.text+0x294): undefined reference to `crypto_register_aead'
> 
> Add the missing 'select' statement.
> 
> Fixes: bf7fa038707c ("s390/crypto: add s390 platform specific aes gcm support.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/crypto/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


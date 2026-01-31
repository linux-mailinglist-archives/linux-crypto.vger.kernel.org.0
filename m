Return-Path: <linux-crypto+bounces-20505-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOsUHDlvfWmTSAIAu9opvQ
	(envelope-from <linux-crypto+bounces-20505-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 31 Jan 2026 03:55:53 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DECB4C0671
	for <lists+linux-crypto@lfdr.de>; Sat, 31 Jan 2026 03:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AEFF3018BDF
	for <lists+linux-crypto@lfdr.de>; Sat, 31 Jan 2026 02:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB0532936C;
	Sat, 31 Jan 2026 02:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="ssxFzetO"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4C230B517;
	Sat, 31 Jan 2026 02:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769828134; cv=none; b=g2Cw5Qz/M6ogk4z5ppZxisf53k0+S11ZHJG5LIVoObgRTL/hHTTxF9rtdoNEs2v7CQK8VIrDdYX+gFT7Att/AzPN3gEIruFjmxZm6O0Cfc5qcqqtiC0nqZVF3t86Osa/4nHvObK242pfN1iUfZvel3vNAqJpvc2roBLRDWkdijU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769828134; c=relaxed/simple;
	bh=Y8jlpLEPt+ZY90QT7kCNaZHwNmpWIm3GVsuoX6oIHws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPmr3If+APd3g1rjIFlyoj4wg6HphLzUt47vn7kVb/BeRc2adGRnSOFsY4aG4sP/c1TSD93+BATX4yb6Wzs3mZOzgB650Pxz2qU+dz3tXC29YwdSETfC6cZ/PtaekzlDYyYKsf+/WSt/EeAFQYciW/RCKBCtipwL4c3O/Y1n/cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=ssxFzetO; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=PARnfAmO8TS3qYl2afHb4aIaOUKMPPe+CbKLTktcDqM=; 
	b=ssxFzetOSSB93G/sh3CKAllOFkdW+kQt5lLgf812PrjAHbaKyYx/ruV/td2SyK6S3LmVmX76ooq
	YagM7Xw4pe5mg1cSm0tjfR4aBPlL2HJ9776nbzi1Oou3q40WWTkMlFnVMhG2KaKQW4tkKUreXl+E0
	ayt8+bpPWdTMyF2ME/rInx9/EuTRKujxESoL+z0pOzWaaW//7R9ikj3BOljCI9t9NPAE6YNxABc2V
	A+rfC2CMMBgkoO0rcU7k1Ecgg0BI8vvMFOTPtwCS8ghB7+HIakI3H/edxlxuFADYreMlSpJud6nLF
	gv+gse+4s9jNyTtlkhTzbvkjmf3zR37YX6ng==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vm18X-003S0A-1M;
	Sat, 31 Jan 2026 10:55:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 31 Jan 2026 10:55:01 +0800
Date: Sat, 31 Jan 2026 10:55:01 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Maxime =?iso-8859-1?Q?M=E9r=E9?= <maxime.mere@foss.st.com>,
	Eric Biggers <ebiggers@google.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	linux-crypto@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: stm32 - Replace min_t(size_t) with just min()
Message-ID: <aX1vBYvzyxT4zdBK@gondor.apana.org.au>
References: <20260113083130.790316-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113083130.790316-2-thorsten.blum@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,gmail.com,foss.st.com,linux.intel.com,google.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-20505-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gondor.apana.org.au:mid,gondor.apana.org.au:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,apana.org.au:url,apana.org.au:email]
X-Rspamd-Queue-Id: DECB4C0671
X-Rspamd-Action: no action

On Tue, Jan 13, 2026 at 09:31:28AM +0100, Thorsten Blum wrote:
> In most cases, min_t(size_t) and explicit casting are unnecessary
> because the values ->hw_blocksize, ->payload_{in,out}, and ->header_in
> are already of type 'size_t'. Use the simpler min() macro instead.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/crypto/stm32/stm32-cryp.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


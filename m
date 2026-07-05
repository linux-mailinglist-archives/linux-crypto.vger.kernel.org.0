Return-Path: <linux-crypto+bounces-25590-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e6IyIMDsSWpZ8gAAu9opvQ
	(envelope-from <linux-crypto+bounces-25590-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 05 Jul 2026 07:33:52 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3660709091
	for <lists+linux-crypto@lfdr.de>; Sun, 05 Jul 2026 07:33:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=C3VACG++;
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25590-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25590-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82CE4300EA8E
	for <lists+linux-crypto@lfdr.de>; Sun,  5 Jul 2026 05:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202BD2E739D;
	Sun,  5 Jul 2026 05:33:50 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F242D7386
	for <linux-crypto@vger.kernel.org>; Sun,  5 Jul 2026 05:33:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783229629; cv=none; b=LAxdARndYl8G/LeciuQyTv3B+Ec1DShXGkZ44Bye+yzWpFbx+mHPw3Sa8i2qaEEsf7r/FypRE91RHNmFSWq+cwW2uOUml3PYutXek95/BTe9/L5YvGZhZba1w0resouyD6WkgZh147301sEfXXphHFKq9Jdl9oPXzu7ZE4CNDm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783229629; c=relaxed/simple;
	bh=/JHZ5d1JqOQS5U6fooIrqXyMLZ3iIbkbuR0s1OFqiLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWo37+46T0bwdG7pWORVpfK25XSoOwJl5yzZi/9yuXBVz4cZzUl9JwEY5m5RWlKcJEkHjDzfdatPNlk/0R8NHw4ya+g8Z+W64MNTivzoKQeJKvCO1EvL8bQFVcUQcyIEP1KmIiZjciMMYIeKLNN1LVVlzOkvDBZ8sQlkbcFmtes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=C3VACG++; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=vLJZmJLp7yryHBbgocuwka/zedyBQs285vhANmqDRP4=; 
	b=C3VACG++3iBkzcf8qW28mfoX1Ynf411vHd+1LKuk00eINvUS9jO8chOzlcWyIerMzq5kYX/3TGM
	dKvzpIbOUNp8+sd/nT2/Rgu9bGiRbc2PeqypaaWIII6NWSI2m8SCQfk8PFSj5baTTk4u418lth9Xm
	BM9JwnCNnkEvjrKmOK10AUvEvgUwJSs/Dh08akV1N4OsDDhreFCySwPFkUcnqk9XoxSg1cl3dfN6+
	E5jEPlis2Z9/V9tfzkkXy7zYwDYzooZA9T8eq8MGC3CApDuco6A8HTO/f28iqXe1Sz7VGlx+rOUEz
	xeDAAEI9O2wBgD6hAjCtRqD2FxSZvX7Nphng==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wgFU8-0000000AjgI-41u4;
	Sun, 05 Jul 2026 13:33:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 05 Jul 2026 13:33:44 +0800
Date: Sun, 5 Jul 2026 13:33:44 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: linux-crypto@vger.kernel.org, qat-linux@intel.com,
	Ahsan Atta <ahsan.atta@intel.com>
Subject: Re: [PATCH] crypto: qat - clear AES key schedule from stack
Message-ID: <aknsuDYTebbOaYHz@gondor.apana.org.au>
References: <20260608150441.136014-1-giovanni.cabiddu@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608150441.136014-1-giovanni.cabiddu@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25590-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:giovanni.cabiddu@intel.com,m:linux-crypto@vger.kernel.org,m:qat-linux@intel.com,m:ahsan.atta@intel.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,apana.org.au:url,apana.org.au:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3660709091

On Mon, Jun 08, 2026 at 04:04:20PM +0100, Giovanni Cabiddu wrote:
> qat_alg_xts_reverse_key() expands the forward XTS AES key on the stack.
> That schedule contains key material and can remain in the stack frame.
> 
> Clear the temporary crypto_aes_ctx with memzero_explicit() after the copy.
> 
> Fixes: 5106dfeaeabe ("crypto: qat - add AES-XTS support for QAT GEN4 devices")
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
> ---
>  drivers/crypto/intel/qat/qat_common/qat_algs.c | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


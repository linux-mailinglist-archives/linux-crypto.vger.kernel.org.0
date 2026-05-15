Return-Path: <linux-crypto+bounces-24093-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NSQFG79BmoeqgIAu9opvQ
	(envelope-from <linux-crypto+bounces-24093-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 13:03:10 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EA154DFC3
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 13:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DBC23189718
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 10:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680453A2E18;
	Fri, 15 May 2026 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="q8QYw1iX"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ECA3CDBC6;
	Fri, 15 May 2026 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840661; cv=none; b=lOkKW8mumDW8oDTo2p3ylANFA2NE8BednTqH2w0am0nZbupfn2C46iCU1x6Q5KIxjba1CHjLP1Y/ZQA/f8pkmXXg2c2GUJRozkMKYCiQuCpBk0Mu3gQ+uPvg/AVeQG52QflEXSFfHUQIv+8IdtUzpsx8oTviWf280TFrMAs1Gbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840661; c=relaxed/simple;
	bh=2GKb9HTk95mw0Oz/cYG7a7hBCHLrx/o+nefLxLDT198=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJhiWd+RFcmKlHMiwoJM6G7std8vKpq6z6fgtT0qkiCOPS1oTGYrkibQZsxtzur2YxNn8OGHY67pMOluwKLnGgG0nVARAexSzpMCn7og8YP8Klrzs2mxR8jE0tWnWeplKeQbPY9mJCQ9nsO0uZRi5o+STou4EgkCJ7Fhblul4tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=q8QYw1iX; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=ksCQhYMScY3CkwwnWo3JMfB9hNVhNGysgJfEGt2jKgg=; 
	b=q8QYw1iXb8zXib8kcdTPvbAP4oNWHGpSb51PQi5f+rbRz87jrktAZMgdO+lS7HFq+FVTWX9jLNF
	AVw5ezV913Ots2tdxG85Hm11ejKTbWv24Wf7tq8sWhbvuUFMHxaK28/wrbBFhCgdC+aYCxw+e0qPo
	8P2BrUr5S/txkG8uGaYq3Oum+b4WH0W8fzD5LvaNx/RamP9Aq7mXYirI4g1RfA9TMyty/b+0cqEab
	BnZq++4pRcqJgoeWshSvrmPNmg7KEwucrrlP+IgWJ9323NGvohr2u/un6xT1/NtPW7gHTcTNttICT
	KaMaeO3O2DoRM4btoCPrP1eLDahK3ETeIatQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wNpiG-00EOYt-0Y;
	Fri, 15 May 2026 18:24:13 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 15 May 2026 18:24:12 +0800
Date: Fri, 15 May 2026 18:24:12 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: atenart@kernel.org, davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, pvanleeuwen@insidesecure.com
Subject: Re: [PATCH] crypto: safexcel - Fix potential memory leak in
 safexcel_pci_probe()
Message-ID: <agb0TL_S9oCbtcWl@gondor.apana.org.au>
References: <20260508090347.74176-1-nihaal@cse.iitm.ac.in>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508090347.74176-1-nihaal@cse.iitm.ac.in>
X-Rspamd-Queue-Id: 40EA154DFC3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24093-lists,linux-crypto=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,apana.org.au:email,apana.org.au:url,gondor.apana.org.au:mid,gondor.apana.org.au:dkim,iitm.ac.in:email]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 02:33:45PM +0530, Abdun Nihaal wrote:
> The memory allocated for priv in safexcel_pci_probe() is not freed in the
> error paths, as well as in the PCI remove function. Fix this by using
> device managed allocation.
> 
> Fixes: 625f269a5a7a ("crypto: inside-secure - add support for PCI based FPGA development board")
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> ---
> Compile tested only. Issue found using static analysis.
> 
>  drivers/crypto/inside-secure/safexcel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


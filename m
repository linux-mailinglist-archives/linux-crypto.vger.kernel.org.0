Return-Path: <linux-crypto+bounces-23239-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJKsK8zn5Wm2pAEAu9opvQ
	(envelope-from <linux-crypto+bounces-23239-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 10:46:04 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4981D428633
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 10:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ACA7E300B1B8
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 08:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCBC2D8796;
	Mon, 20 Apr 2026 08:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="d63nZV8C"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FA42F999F;
	Mon, 20 Apr 2026 08:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674762; cv=none; b=r73GJQ64I49lsJOvH4W7H1RZ5pEfbWbAEeXVBcYAhmAeBl0iHcuq9Agw+flozfwKZPyrF1HmObN7fs3ly8qhWssKpStimwECDxEVGyzCcg8oXFQIvvfFTUqHvD70RPu+mHmyrqC5IJD81dp8MR3+LEHAzTY3k//ketsExakDnzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674762; c=relaxed/simple;
	bh=ULbdKXfQnKB6bWicRCYS7e2zfNqXP3YcbHtImx4XJFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niyBIhSsn1YQkPRY/nxNmU3lArsD4L2s7+bWAJ34Nj4BcZY0AsgDxLuBLk2i2GChC4QHZPi65jHLu5aLNnNEH4n91dndhAZOLqsML4TgepwwrHqWk4rUMx/Hy377UNAhwJPzT7gvOMZ7CcZD7z2fFmFkqVh+0ZLoUE7srAbM1Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=d63nZV8C; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=rA0RugfwP71Dnuw8bsIljvtpxKBXfcuhfWG6uOrPjIA=; 
	b=d63nZV8CMGGJBw1J9IuDxg4Uvo1yzQ5d+5TPIFN1o3B5t0WXgFg/RA52LTD5psbYsNRwNCaLn8L
	2Z3x/pxn0j/9rqom7zNXsg79fFttYhsa3BO1YtZI6j4Q6ocmMxGsRmx7we1HJKdacegx9mq60C099
	ZpLAoRBTsMnxbwS1fo6cj6RkxWWQih8BD90G+IxdDcupGRIlBNn+7n90/oZcOJ6nNERLsSq18X6O/
	OTEiGnfyOga/tVcZYla+H9eqSujdOVYsyzGPpjqTxEks1cmLt0YEvCTkVnvR7DEYs/MrJnlw2qMTe
	jUcDZkZEfugYKAe0Et7aPhYj+ceW23F3WE4Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wEkGE-007LzY-33;
	Mon, 20 Apr 2026 16:45:44 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 20 Apr 2026 16:45:42 +0800
Date: Mon, 20 Apr 2026 16:45:42 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jeff Barnes <jeffbarnes@linux.microsoft.com>,
	Paul Monson <paul.monson@capgemini.com>
Subject: Re: [PATCH] crypto: tstmgr - guard xxhash tests
Message-ID: <aeXntu0DVQdocakd@gondor.apana.org.au>
References: <20260407192859.270745-1-hamzamahfooz@linux.microsoft.com>
 <adYNClYB6RY820Xl@gondor.apana.org.au>
 <adffSYxKIuaDLZit@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <aeCmk6LbLFT4Keo2@gondor.apana.org.au>
 <aeCnNsNrK5o2JcMu@gondor.apana.org.au>
 <aeJw9I38heQRbbe6@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeJw9I38heQRbbe6@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,gmail.com,foss.st.com,st-md-mailman.stormreply.com,lists.infradead.org,linux.microsoft.com,capgemini.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	TAGGED_FROM(0.00)[bounces-23239-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,apana.org.au:url,apana.org.au:email]
X-Rspamd-Queue-Id: 4981D428633
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 10:42:12AM -0700, Hamza Mahfooz wrote:
> 
> It appears that commit 6318fbe26e67 ("crypto: testmgr - Hide ENOENT
> errors better"), already does exactly that and it appears to resolve the
> issue that I'm seeing. So, is there any reason it can't be backported to
> stable?

Sure I don't see anything wrong with that.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


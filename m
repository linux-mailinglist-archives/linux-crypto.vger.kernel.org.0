Return-Path: <linux-crypto+bounces-25593-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d1cRAbkVSmq4+AAAu9opvQ
	(envelope-from <linux-crypto+bounces-25593-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 05 Jul 2026 10:28:41 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFF8709714
	for <lists+linux-crypto@lfdr.de>; Sun, 05 Jul 2026 10:28:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=NLPrEK+i;
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25593-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25593-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D443F3009F00
	for <lists+linux-crypto@lfdr.de>; Sun,  5 Jul 2026 08:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1EB36AB46;
	Sun,  5 Jul 2026 08:28:18 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E42B36A36C;
	Sun,  5 Jul 2026 08:28:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783240098; cv=none; b=oqMQxD/f1jNTfDprWtO4KY1PGliQmgyEBIsM38FaKE+AhpF2MzrIio7Wa0rkf+44KMm/kzxNB0VjsEpQW5Sxachik+vy5+7EijCbxc3bQaT+lh3SJ0iv0NCFLRnH3huAFWxm8/UG3AsdiN1Ao+O5GtHpzYZ7ihITOXAaqh5ZogE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783240098; c=relaxed/simple;
	bh=wh6B4oCOQxzxFGtsNgRPGGqX7mJWx9ITe49etI2RNdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3cAFfKWfXHSZUnpObsPnK826HkvJSlgRWyjc9GbkUzsM8IiYNM7Q+1dZGiAQzRvOO+ggDOI7zE4U5A+InzP7fOgcxQE4vVq/h6pwe0lUnBxaIpupnaceJ6yZX2NBz1FVX4z7USlDrvTNoJ1Vm5dwAlnmtmIBd8X6w6RpowDtxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=NLPrEK+i; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=Y/fEI1tsYcMeILFjsz0iVsmftEVQAz64IXLrZBObpqM=; 
	b=NLPrEK+iUe9kpSTKN60rKpZgNio6syoLNSXoFItxclsZ1QZznxT0R4tEgX5+XV7zuXEcPF2Zvj7
	0ZmRAGDFWPx9RAgg+R2uY8D1MfwKJSn9xx6UMRNWCLqDZavOqX6qn+09Sxtyrso4481czd0BgabGd
	ULMbgqRhH8rrDylCn/AjStsfvrJHkjZzWTO+ID5YAZOPBmngtyPtMAqmC8EXe+UZwF9d6UGLWAK1k
	l2+0QA3/tv4xWMP3zOccJTzlBz5MWdUGKHCQzRVl0/+5wyaxI+X9zKhfEIComPrhG8bcSFXTXdjcX
	NcqGet1EaonqHoAZPMZlCfhFCSybPX8YcfDA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wgICy-0000000AkvN-2jh6;
	Sun, 05 Jul 2026 16:28:13 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 05 Jul 2026 16:28:12 +0800
Date: Sun, 5 Jul 2026 16:28:12 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Chenghai Huang <huangchenghai2@huawei.com>
Cc: shenyang39@huawei.com, fanghao11@huawei.com, liulongfang@huawei.com,
	qianweili@huawei.com, wangzhou1@hisilicon.com, davem@davemloft.net,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update hisilicon zip driver maintainer
Message-ID: <akoVnF_cFSeDo4Ak@gondor.apana.org.au>
References: <20260610013437.1354503-1-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610013437.1354503-1-huangchenghai2@huawei.com>
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
	TAGGED_FROM(0.00)[bounces-25593-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:huangchenghai2@huawei.com,m:shenyang39@huawei.com,m:fanghao11@huawei.com,m:liulongfang@huawei.com,m:qianweili@huawei.com,m:wangzhou1@hisilicon.com,m:davem@davemloft.net,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,apana.org.au:url,apana.org.au:email,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CFF8709714

On Wed, Jun 10, 2026 at 09:34:37AM +0800, Chenghai Huang wrote:
> Add Chenghai Huang as the maintainer of the hisilicon zip driver,
> replacing Yang Shen.
> 
> Signed-off-by: Chenghai Huang<huangchenghai2@huawei.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


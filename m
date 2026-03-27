Return-Path: <linux-crypto+bounces-22497-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BgROqZZxmlgJAUAu9opvQ
	(envelope-from <linux-crypto+bounces-22497-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Mar 2026 11:19:18 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0537234260F
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Mar 2026 11:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C350D30B82B1
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Mar 2026 10:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89D93A9DAB;
	Fri, 27 Mar 2026 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="HysPy/Yo"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B3C32C942;
	Fri, 27 Mar 2026 10:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774606191; cv=none; b=UOID5v62XY5Q6W2yLRucGt+3GOqkd4LEAcYjUEiRiTtUF1Viy9OK8gVHjGIzO555HFSalp7sxR9EgxRc8+F0IgQ+PD0PAEHy4WjmGfnaJCyKgjiN55IuwjcwXBy4y/i8a3nIp02XXhHSXrsXjK0vi62w+EDRtipu9QYsFFyNScQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774606191; c=relaxed/simple;
	bh=gTvXuReAjPAHASbBqememMh2xAfDOENN+LVHcJgIniQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rp0ZHwxBVg/9g5F+xkrYYgJBSqJyeJfhpMCsEpTBADUCTXXZ8wElmryOLTYpKEHKlClNoQ+vASiTEAdb1FS46Jxm5x7OZNirYEB/Wlw2Z5jLrVBO1gcWl9WQxaacJ5OXPnkLjSXgPFCY9RdmDOyXgK6Es1LiAGTlKBTDqs1ytwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=HysPy/Yo; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=Elqfb1zrZbxu2yixOnTRFdEca09tffbB/3BR31L15h8=; 
	b=HysPy/YotyLf6MJXwTL8jI5zpyBP0cEu1RfUAs/jaNC4Y2rE8MDsIbWnF09AS7IWuooOBXxS2Hf
	//1OMxhjNjct2/CMiHimOAAIut+d1lLj6OZViS+EPXpYb+hRwTQDmquUt7KcrJIzKLxdFmPsWyFcj
	XoDHfSQSi9a37GGLhCkrOwZJUNwlrF7K/L8ieU1Mk3wJLb+/7y10lrO//BuFi/joMxe79T0xDQeff
	xt62B/s9BcuHCvsOUR07Iaa2lPZ/trwS+CDokrkr8GFOldgDpYJeU8vaW3V9IWgrzCtwHn/RWQDny
	R3liqMZn5ORwRz1+DDuwebx6L09LyIhUYW7w==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w63ix-001brH-1B;
	Fri, 27 Mar 2026 18:09:47 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Mar 2026 19:09:46 +0900
Date: Fri, 27 Mar 2026 19:09:46 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Chenghai Huang <huangchenghai2@huawei.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, fanghao11@huawei.com,
	liulongfang@huawei.com, qianweili@huawei.com,
	linwenkai6@hisilicon.com, wangzhou1@hisilicon.com
Subject: Re: [PATCH] crypto: hisilicon/sec2 - prevent req used-after-free for
 sec
Message-ID: <acZXavY-RlQHBw09@gondor.apana.org.au>
References: <20260321070038.2023844-1-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321070038.2023844-1-huangchenghai2@huawei.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22497-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,apana.org.au:url,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,huawei.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hisilicon.com:email]
X-Rspamd-Queue-Id: 0537234260F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 03:00:38PM +0800, Chenghai Huang wrote:
> From: Wenkai Lin <linwenkai6@hisilicon.com>
> 
> During packet transmission, if the system is under heavy load,
> the hardware might complete processing the packet and free the
> request memory (req) before the transmission function finishes.
> If the software subsequently accesses this req, a use-after-free
> error will occur. The qp_ctx memory exists throughout the packet
> sending process, so replace the req with the qp_ctx.
> 
> Fixes: f0ae287c5045 ("crypto: hisilicon/sec2 - implement full backlog mode for sec")
> Signed-off-by: Wenkai Lin <linwenkai6@hisilicon.com>
> Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
> ---
>  drivers/crypto/hisilicon/sec2/sec_crypto.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


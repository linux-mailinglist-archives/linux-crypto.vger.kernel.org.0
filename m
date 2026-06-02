Return-Path: <linux-crypto+bounces-24848-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TegBBrZDH2pzjQAAu9opvQ
	(envelope-from <linux-crypto+bounces-24848-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 02 Jun 2026 22:57:26 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABB4631F09
	for <lists+linux-crypto@lfdr.de>; Tue, 02 Jun 2026 22:57:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=LwHmyJRg;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24848-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24848-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C63DC303DD1A
	for <lists+linux-crypto@lfdr.de>; Tue,  2 Jun 2026 20:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B2B388E43;
	Tue,  2 Jun 2026 20:51:15 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B22D30FC1B
	for <linux-crypto@vger.kernel.org>; Tue,  2 Jun 2026 20:51:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433475; cv=none; b=qt++X5alseuDyU8ms74rDWwoVvUzF2+RgvxHEgFxdPct85QlXoq5huAKVDqXx48cAOswZZSi65md91z8ZUEYE2fB7EKCWMBwcRkAHI7lySccEQnc5L0xCoEwR/jI9Vsc1OhCLNQtH9eM8uQKaMwSoyLX9fqOnf1iZb4iJ2fzuP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433475; c=relaxed/simple;
	bh=791aivTs4EgvrFxer55SyQA3Adu38ewQOtHjDh7Oh0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDrEnnzFoy1hn0i4XBQOgYNAhdcWrr13gCj7LCACJHXvlZ+Jsdsv3duIvjdmgA61YwQWdrossGOuVe69x8eZ3F7zRmOJ5TZBEqMq1XvCtikZ16pfGjdNKRjh6hk46C76QiKXQue/aDVhHbh4LDZ/4SbQhw+IFGlXtBqkxC5+j7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LwHmyJRg; arc=none smtp.client-ip=91.218.175.185
Date: Tue, 2 Jun 2026 22:50:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780433461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SrVoGOGyRLrxoTmnEzU+D1XUI6722cewBkysfTUfUQU=;
	b=LwHmyJRg2D4DbfAXN5HL1LwNueKg+Qy1wB5hHi2fFHPS5p8Z58/mSZS+vqoJduffyV/M4I
	2d8wPvWk6jVikqkKK/eh0c7Rjx4OKaAZgaeEl2ObZNX72wg/7NwqUV1Wcw9XAuRNnqExQO
	G44xe+b5+vBDjmEUnbtI7ZBYDlTqT9Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	John Allen <john.allen@amd.com>, Weili Qian <qianweili@huawei.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	qat-linux@intel.com
Subject: Re: [PATCH] crypto: use two-argument strscpy where destination size
 is known
Message-ID: <ah9CMYSp27OSPxkv@linux.dev>
References: <20260525103038.825690-4-thorsten.blum@linux.dev>
 <e94278a8-52df-4758-98fc-e6d7e5b55491@amd.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e94278a8-52df-4758-98fc-e6d7e5b55491@amd.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:thomas.lendacky@amd.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:john.allen@amd.com,m:qianweili@huawei.com,m:wangzhou1@hisilicon.com,m:giovanni.cabiddu@intel.com,m:schalla@marvell.com,m:bbhushan2@marvell.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:qat-linux@intel.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-24848-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:from_mime,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6ABB4631F09

Hi Tom,

On Tue, Jun 02, 2026 at 03:24:06PM -0500, Tom Lendacky wrote:
> On 5/25/26 05:30, Thorsten Blum wrote:
> > To simplify the code, drop explicit and hard-coded size arguments from
> > strscpy() where the destination buffer has a fixed size and strscpy()
> > can automatically determine it using sizeof().
> > 
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> For the CCP driver changes:
> 
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

Thanks.

> But I noticed that there are a few other places in the driver that I think
> can be changed to use the two argument strscpy - essentially the strscpy's
> that involve "cra_name" and "cra_driver_name" in
> drivers/crypto/ccp/{ccp-crypto-aes-galois.c,ccp-crypto-aes-xts.c,ccp-crypto-aes.c,ccp-crypto-des3.c,ccp-crypto-rsa.c,ccp-crypto-sha.c}.

They already use the 2-arg strscpy(), except for the one in this patch:

$ git grep -n strscpy drivers/crypto/ccp/
drivers/crypto/ccp/ccp-crypto-aes-galois.c:227: strscpy(alg->base.cra_name, def->name);
drivers/crypto/ccp/ccp-crypto-aes-galois.c:228: strscpy(alg->base.cra_driver_name, def->driver_name);
drivers/crypto/ccp/ccp-crypto-aes-xts.c:243:    strscpy(alg->base.cra_name, def->name);
drivers/crypto/ccp/ccp-crypto-aes-xts.c:244:    strscpy(alg->base.cra_driver_name, def->drv_name);
drivers/crypto/ccp/ccp-crypto-aes.c:311:        strscpy(alg->base.cra_name, def->name);
drivers/crypto/ccp/ccp-crypto-aes.c:312:        strscpy(alg->base.cra_driver_name, def->driver_name);
drivers/crypto/ccp/ccp-crypto-des3.c:196:       strscpy(alg->base.cra_name, def->name);
drivers/crypto/ccp/ccp-crypto-des3.c:197:       strscpy(alg->base.cra_driver_name, def->driver_name);
drivers/crypto/ccp/ccp-crypto-rsa.c:261:        strscpy(alg->base.cra_name, def->name);
drivers/crypto/ccp/ccp-crypto-rsa.c:262:        strscpy(alg->base.cra_driver_name, def->driver_name);
drivers/crypto/ccp/ccp-crypto-sha.c:429:        strscpy(ccp_alg->child_alg, def->name, CRYPTO_MAX_ALG_NAME);
drivers/crypto/ccp/ccp-crypto-sha.c:487:        strscpy(base->cra_name, def->name);
drivers/crypto/ccp/ccp-crypto-sha.c:488:        strscpy(base->cra_driver_name, def->drv_name);


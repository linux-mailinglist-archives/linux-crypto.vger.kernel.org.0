Return-Path: <linux-crypto+bounces-25560-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W965AhdfR2rSXAAAu9opvQ
	(envelope-from <linux-crypto+bounces-25560-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 03 Jul 2026 09:04:55 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 907AB6FF603
	for <lists+linux-crypto@lfdr.de>; Fri, 03 Jul 2026 09:04:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=M3qO+uFb;
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25560-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25560-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EA26306A364
	for <lists+linux-crypto@lfdr.de>; Fri,  3 Jul 2026 07:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DD638A736;
	Fri,  3 Jul 2026 07:00:36 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132A23451B0;
	Fri,  3 Jul 2026 07:00:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062035; cv=none; b=O8GgO/VKen4D1OvN82w3lWjGniEK64Zg0031UPUcyFifioWj8M4xSORIVUaUqv2+IWHddbGOrUD0hRQXo44xF5rIuhApkJN4iJtkL5rzaSMYfUGJ5PeinW/gYLuvQWEYxeCQmoF1j2xcLY9eoeGhQACM06dGf9i2+TNiDYkJxb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062035; c=relaxed/simple;
	bh=qN2vKE5Fn8xDUD3eHawEdlqobivVCRK6hrnO6m3Yzm4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qbNJ0ARwrHRvBn0Na/DDeI3eMrv1RSBTn+I4FyH1r/cskV8cl2i1wiicf/Atq4TnVuDdKodBvDob23DwynVEfJwomNALiTLJFgZQHe4KH4NYKwVhNHIaIoeUrU1WzezP7qIhJf1+N1+fn4u2Ev6CiXsoQuOOftUUclyhJZ1pEiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=M3qO+uFb; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=huYPoepGe1WD2g2cbld41nXud9yg4hSdMCBncMeGpxc=; b=M3qO+uFbBR1AzEQRUBjwjiCG0n
	nYMkvdOp8p87nyBxYmQZTwMd/uKBwAmx2xjwEMqz54pTodACE0yJF10t/ts0+mbphpima0pvjA34l
	++BSSzy2jfGiaPQvXeeTO3bKD6krCZryvkFnB6fBnyGvPAcpcAwG7jfjFU2N3YEXw3gLDpbwWbROF
	/Pt4gLcXpkAsiKz8W0Pxv7goEBsltaI16irhzMULGNsElRfGZYRe/3D7OwDvoQ8ITMu5/nMYCV9K/
	DHaTNic5K1YJHxbSIv5FUzZjn804ulkm7m49+tdRcg+X1CLcRAK1HSDzoWopnnBMCIHU3t+okkYq3
	chDAF/+Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wfXsu-0000000AHUA-0iLw;
	Fri, 03 Jul 2026 15:00:25 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 Jul 2026 15:00:24 +0800
Date: Fri, 3 Jul 2026 15:00:24 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: William Theesfeld <william@theesfeld.net>
Cc: dsaxena@plexity.net, olivia@selenic.com, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] hwrng: omap - balance runtime PM and clocks on
 probe-defer paths
Message-ID: <akdeCL5BWlK5homr@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605192842.372935-1-william@theesfeld.net>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25560-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:william@theesfeld.net,m:dsaxena@plexity.net,m:olivia@selenic.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thomas.petazzoni@free-electrons.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,free-electrons.com:email,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,gondor.apana.org.au:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 907AB6FF603

William Theesfeld <william@theesfeld.net> wrote:
> omap_rng_probe() calls pm_runtime_enable() and pm_runtime_resume_and_get()
> to bring the device up.  If either devm_clk_get() call subsequently
> returns -EPROBE_DEFER, the function returns -EPROBE_DEFER directly,
> leaking the runtime PM usage counter taken by resume_and_get() and
> leaving pm_runtime enabled.
> 
> Convert both early returns to set ret and jump to err_register, which
> already performs the matching pm_runtime_put_sync() + pm_runtime_disable()
> unwind.  Because devm_clk_get() returns ERR_PTR on failure (not NULL)
> and err_register calls clk_disable_unprepare() unconditionally, also
> NULL out the failed clk pointers before the goto so that
> clk_disable_unprepare() (which only handles NULL safely, not ERR_PTR)
> does not deref an error pointer.
> 
> While here, NULL out priv->clk and priv->clk_reg in the existing
> "optional clock not present" else branches.  In that pre-existing case
> the pointer was left as ERR_PTR, and the unconditional
> clk_disable_unprepare() in omap_rng_remove() would have dereferenced
> it on driver unbind.  No functional change for systems where both
> clocks are present.
> 
> Found by smatch ("missing unwind goto?").
> 
> Signed-off-by: William Theesfeld <william@theesfeld.net>
> ---
> drivers/char/hw_random/omap-rng.c | 24 ++++++++++++++++++++----
> 1 file changed, 20 insertions(+), 4 deletions(-)

Looks alright to me.

But please add a Fixes header.  I think the bug was added by:

commit 43ec540e6f9b8e795dc9000114636ff72afc5b01
Author: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date:   Tue Mar 7 15:14:49 2017 +0100

    hwrng: omap - move clock related code to omap_rng_probe()

as prior to that the probe function did the right thing.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


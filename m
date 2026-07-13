Return-Path: <linux-crypto+bounces-25885-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HJWmId9aVGoNlAMAu9opvQ
	(envelope-from <linux-crypto+bounces-25885-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 05:26:23 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B239746E88
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 05:26:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b="E9GPj/aN";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25885-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25885-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C72830078EF
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 03:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE5E314B9A;
	Mon, 13 Jul 2026 03:26:18 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EDF3148D9;
	Mon, 13 Jul 2026 03:26:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913178; cv=none; b=MPyk1PJNeAeBnvmqGa67j2Xxh9JNvNtdq3f078H3zcK8eMQ4At8phGaRc7i8JO249tk65z8NAT0K17VyXJaXU40L8uvwlNtKpaLIWk1Yhbotw6acInniWZZ+nYx/dXP3MU/FVnw3pBI4GVnjkUSO3+7Vg0NldssnjEA9fEytsvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913178; c=relaxed/simple;
	bh=XU8PwunInvAHerjBwgKLfc/8URkqNPuUHurJTz9emKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLY32ZlKId0a8sOzAswHS/RERQIWxRHnLf0/hr113YDyB7yYjIJsg771HlPX0qpu9CLkyhQYhbtpEGV6RSzIx9/fHH2VJvqyo1Gfsq4CpldskIoAWVq0lDldW1Cl8/5Vw3GtI0rCRHdMRAA4B2nEWIMisBSLwy1nmLNoyX0ABNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=E9GPj/aN; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=IhCzXW7viQCr5P9GDimMf/pCmw5MR5jf9qVyHnLRLks=; 
	b=E9GPj/aNAG7kzwjLhA5EDr2vi61TWm6o8Q2H6hXZfQCxJsDJVwdVZRfqxNR1qmdggdNZswG1aR3
	FbWGN3D2FM+rxZx2YiPycds7ue2pbzbVJwS+4WuHFeqbHEkb5qXCawIxVP+jGeg1MXqaQ8Z3nZht3
	lJK7qGP508KqY0ZnXzbLWWvD++x+2oy0ygnjE8aWw29wBda0f2C5FtJRsHbjZbAI7E72AghxGF2TW
	IshnflBpOzBGeb4YJdpHf8mR9ASjLbYmVAkdcPFEIbreQeorJaCEMmQlCzunH5x5PFVPbGAz/eXh9
	ZZGFyxh3GKCedpRbPnwmd+B2YRp6SvvTYafg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wj7Iu-0000000Cy46-0wAx;
	Mon, 13 Jul 2026 11:26:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 13 Jul 2026 13:26:00 +1000
Date: Mon, 13 Jul 2026 13:26:00 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Thomas Richard (TI)" <thomas.richard@bootlin.com>
Cc: Olivia Mackall <olivia@selenic.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	gregory.clement@bootlin.com, richard.genoud@bootlin.com,
	u-kumar1@ti.com, a-kumar2@ti.com
Subject: Re: [PATCH v3] hwrng: core - Stop/start hwrng_fillfn() kthread
 before/after suspend-resume
Message-ID: <alRayMNo3D46Tdby@gondor.apana.org.au>
References: <20260703-hw-random-fix-hwrng-fillfn-crash-suspend-resume-v3-1-b7165cb9cf38@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-hw-random-fix-hwrng-fillfn-crash-suspend-resume-v3-1-b7165cb9cf38@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25885-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:thomas.richard@bootlin.com,m:olivia@selenic.com,m:thomas.petazzoni@bootlin.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gregory.clement@bootlin.com,m:richard.genoud@bootlin.com,m:u-kumar1@ti.com,m:a-kumar2@ti.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:url,apana.org.au:email,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,gondor.apana.org.au:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B239746E88

On Fri, Jul 03, 2026 at 11:20:20AM +0200, Thomas Richard (TI) wrote:
>
> @@ -506,6 +501,29 @@ static struct attribute *rng_dev_attrs[] = {
>  
>  ATTRIBUTE_GROUPS(rng_dev);
>  
> +static void hwrng_start_hwrng_fillfn(void)
> +{
> +	BUG_ON(!mutex_is_locked(&rng_mutex));

BUG_ON is not acceptable.  Please use lockdep_assert_held.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


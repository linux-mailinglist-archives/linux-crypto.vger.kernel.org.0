Return-Path: <linux-crypto+bounces-24910-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mwxmLOqMImo8aAEAu9opvQ
	(envelope-from <linux-crypto+bounces-24910-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 05 Jun 2026 10:46:34 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF2464688D
	for <lists+linux-crypto@lfdr.de>; Fri, 05 Jun 2026 10:46:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=Epb3RRoy;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24910-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24910-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD1E13081CE8
	for <lists+linux-crypto@lfdr.de>; Fri,  5 Jun 2026 08:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC513D0BE5;
	Fri,  5 Jun 2026 08:35:02 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D711399CFD;
	Fri,  5 Jun 2026 08:34:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780648502; cv=none; b=qgZvcRy9B1iYCb39u2EWo6480ooUcoZwkgOEuIApwgvhh+NadIipJG8GKhub/xZe88fsYmGbDfxfybfQinyp58EoO6Tfhokp/HymEwnm1Y+wYmH+K/D+1VlxcPxUB0nkQUDyv6FPosJtDL4WU7yHIOZnewIN7gLcvFXOafEZLEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780648502; c=relaxed/simple;
	bh=NTF5J3ZVW4/eT3uDog+42vAtd8DNL8yBOAV84CgXdp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cf8DN3y+WF6AFkzlbOSFXgO4bQ3kC8XQq36L8+oI6LMVPVM2izBM9lzvRzQVB+LDFsRKGlqbsdeE4D4zi0AwkCP4VgdSs+OD+g9oryY5xpE9j4XYwMBagtUC2VsOZAI9KsGBVDl+rlKuy88wx6OUkteaz/BqTpZ/wcu3Tf+dlAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=Epb3RRoy; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=dHkD+yL+8nOlGoyo4Wgyaon1TT9iBy84T10xGloyuao=; 
	b=Epb3RRoy/LsK2TsFdqDSNf2CZoekIyuWkGedR2eKfz3Y6hu6FN8uiDj9d5zQIuMJ+5P3iaEOMXj
	LHEotWiB1G/BmNUxu/Lg+yr6GMWvq3csIfhY02pifsOTG37Ma5rPkye1AG8o4+sAFL94Rbq6JJ9em
	7//OX6O61UT37Jy3MjDWX//41cE4JqQVAIotUu4gwkSR+ZZW7MHs7wnmClh7bZPkXl1ALV+p8M533
	/8wMc3ucCPhwjnNBfOjwHFyy6WWECo+LotxDZWmGLvkq3UQKXTUSMiiZkiBHOivLguv7G/Dyd6fF/
	vXhjHOQPmPqI4IfFHXNTsbSkDLw++sWEprCw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wVQ0n-002lej-14;
	Fri, 05 Jun 2026 16:34:42 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Jun 2026 16:34:41 +0800
Date: Fri, 5 Jun 2026 16:34:41 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Manos Pitsidianakis <manos@pitsidianak.is>
Cc: Olivia Mackall <olivia@selenic.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Harald Freudenberger <freude@linux.vnet.ibm.com>,
	PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: Re: [PATCH] hw_random/core: fix rng list on registration error
Message-ID: <aiKKIdPQzFdH0m9t@gondor.apana.org.au>
References: <20260525-hw_random_registration_rng_list-v1-1-ee1c215d544d@pitsidianak.is>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525-hw_random_registration_rng_list-v1-1-ee1c215d544d@pitsidianak.is>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24910-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[selenic.com,vger.kernel.org,linux.vnet.ibm.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:manos@pitsidianak.is,m:olivia@selenic.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:freude@linux.vnet.ibm.com,m:prasannatsmkumar@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:url,apana.org.au:email,pitsidianak.is:email,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DF2464688D

On Mon, May 25, 2026 at 10:25:39AM +0300, Manos Pitsidianakis wrote:
> hwrng_register(rng) does the following:
> 
> 1. Checks if rng has name and read methods set
> 2. Checks if the name already exists
> 3. Adds rng to global rng_list
> 4. May try to set rng to current_rng
> 
> If step 4 fails, it returns an error. However, it does not remove the
> rng from rng_list, causing a dangling reference which can result in
> use-after-free if the caller frees rng, since registration failed.
> 
> Add a list_del_init() cleanup step.
> 
> Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
> ---
>  drivers/char/hw_random/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Good catch!

Please add a Fixes header for this:

Fixes: 2bbb6983887f ("hwrng: use rng source with best quality")

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


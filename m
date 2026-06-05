Return-Path: <linux-crypto+bounces-24912-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AIBaJwOjImpDbQEAu9opvQ
	(envelope-from <linux-crypto+bounces-24912-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 05 Jun 2026 12:20:51 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE17A64743B
	for <lists+linux-crypto@lfdr.de>; Fri, 05 Jun 2026 12:20:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=Ax6BZji7;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24912-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24912-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8A8030265A6
	for <lists+linux-crypto@lfdr.de>; Fri,  5 Jun 2026 10:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163E03E4C85;
	Fri,  5 Jun 2026 10:04:55 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653922EEE83;
	Fri,  5 Jun 2026 10:04:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653894; cv=none; b=c58OR9pG6aSdgxMK6zKCliaG0Yn6BB8DoLTdXwXtMGY0Os58UKclWWygTCtPj6wV+2xIa2NFjFLLjU0RN1qu0IakbEwp/y8uznRw9sQNt8z/Ll3mnYzVjPS0vYBdbVLTXEDMcvplEqtz0iNxg6Qx+jXzBJQXM4A8KEk4/1udc+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653894; c=relaxed/simple;
	bh=FE22ZdPf+wKhwfzKDsrco4GUVraR4aTWRxc65nLLhPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gulcbQyEIW0bhTS3AmZITcWPSc1wrT3VdCwrjscdo12B7JEIqKQP079xgfS+ft6brZ6EOZNzHnCbayY6HvXISm5/QbfM8MbFyegYVRgwWIPrrrKGjGbHQxbNwL16vm4dc/MB3Cifg9Dzax1rg6tWgRCSOIHboQyMhIfBLQjOADs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=Ax6BZji7; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=5nLOynZ1AgtIdQmmprJhzIyBvj7O8ByMcWq9gSrAVuA=; 
	b=Ax6BZji7M+GAm650GWcCbDGg/FJVo/O53s2XrUkefacgu9M+ZLaJzH09yvlkjiJDpslo19FrAhk
	/1ETA2RF2isMnhk9Djxo8q6U12VrxvE3wDJoPj/92/CGb21CYZpAoLgCeLK9p7GlUpVLfju7Q8xbO
	Xe9a1ypiz026OnghbrGpEO0QPKLV05zodnm0s4suACNDI9x40uPvOuY9axc+4LiegqWlbxqguQbQR
	Ls2jAo9Re6ulKOQcEW3NLDG8yKZH4c6QCP4Rb53FpW7yyZrHgXSRJrmz5iDKy/MbZEskHUMxnyBcq
	xuEB5eu3yGh/Rzw1Cjbf+x8hu4G+WXF3GcEg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wVRPr-002nBr-1g;
	Fri, 05 Jun 2026 18:04:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Jun 2026 18:04:39 +0800
Date: Fri, 5 Jun 2026 18:04:39 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Manos Pitsidianakis <manos@pitsidianak.is>
Cc: Olivia Mackall <olivia@selenic.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Harald Freudenberger <freude@linux.vnet.ibm.com>,
	PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: Re: [PATCH] hw_random/core: fix rng list on registration error
Message-ID: <aiKfN1GHrNDs_nDV@gondor.apana.org.au>
References: <20260525-hw_random_registration_rng_list-v1-1-ee1c215d544d@pitsidianak.is>
 <aiKKIdPQzFdH0m9t@gondor.apana.org.au>
 <tg5j9x.z6yluqyl72so@pitsidianak.is>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tg5j9x.z6yluqyl72so@pitsidianak.is>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24912-lists,linux-crypto=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,apana.org.au:url,apana.org.au:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE17A64743B

On Fri, Jun 05, 2026 at 12:18:29PM +0300, Manos Pitsidianakis wrote:
>
> If yes, you could add it along with your r-b directly, otherwise I can send
> a new revision when it gets a review.

It will go through my tree but please resend.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


Return-Path: <linux-crypto+bounces-20457-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MGbHe3semmE/wEAu9opvQ
	(envelope-from <linux-crypto+bounces-20457-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 29 Jan 2026 06:15:25 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D686ABDF5
	for <lists+linux-crypto@lfdr.de>; Thu, 29 Jan 2026 06:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52171301A29A
	for <lists+linux-crypto@lfdr.de>; Thu, 29 Jan 2026 05:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051952D640D;
	Thu, 29 Jan 2026 05:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="AvY1W3Xe"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FF72AEE4;
	Thu, 29 Jan 2026 05:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769663719; cv=none; b=DqlA61NwZzJZeAruP1bRylESpRO/8LpDbWEdag9fsgxKDaYS0fANKk7U26GmmWHfHa7KpFc48zq5b+UPr8FGNROYmidETDBzjmNFOzPgNI4DbhU8Mr+jQuk9P4HKB09s2UYrBBZFQo4UCOadBw1+Hh6mrmYE4BjVT+2Q44S1qUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769663719; c=relaxed/simple;
	bh=rvNC3CpSJWRgisOa3YYykLBDNSO6xDdIUmJyxFXijsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ID+vWb/OLk9XqpX4jUyf6pQAueObO6wT2fKFz8WIGZz9LetRbqcBBumOB4I60ApPdASY6FpibK2MA+GEzmTShxtJqKxFv1KEYQueK1z4+VyFMW26/ZxeKkfZY8SgVo84gAqWFHORWppFv+GZNFDOmU8IsHBr5fQ1vcprR8gRh/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=AvY1W3Xe; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=L7N1rycqV1nGODktamMWXiffpemQFzIg76phTFXKDks=; 
	b=AvY1W3XelVp5IC2p92X5qm4ZJWR+wu8bM/jUUnYLAU+ydRX+HeQotL1wCDqfoM8wxp+zrYnmTKM
	YXGGXedk3SVWUx6JyUQG8tFt/PA+GUSrr3J/lgG6JBryjC+mKKT5TZSKYORn7SVNkzheGycomXGy5
	dfpzyq3rhGLCQsDMiPYFNgSMju5kyrz3Vy4Xe2Wr3Igwfu4dtoKWYGW9fmNHy3fy2v37wrNMefMS/
	kM8tyQQSzU5Iq8uuKqzN2LuZ9vViEU8linSAXm/LgPxJCtRMFmkgbKWtNeuLJULwe6mQWCjT9+NUh
	yyfjihNqZcM0Kwyx27AYRKCJejobEBWhVQgw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vlKMt-002wXV-0C;
	Thu, 29 Jan 2026 13:15:00 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 29 Jan 2026 13:14:59 +0800
Date: Thu, 29 Jan 2026 13:14:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Lianjie Wang <karin0.zst@gmail.com>
Cc: Olivia Mackall <olivia@selenic.com>,
	David Laight <david.laight.linux@gmail.com>,
	Jonathan McDowell <noodles@meta.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwrng: core - use RCU and work_struct to fix race
 condition
Message-ID: <aXrs03QrQcCeQYYz@gondor.apana.org.au>
References: <20260128221052.2141154-1-karin0.zst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128221052.2141154-1-karin0.zst@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20457-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[selenic.com,gmail.com,meta.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gondor.apana.org.au:mid,gondor.apana.org.au:dkim,apana.org.au:url,apana.org.au:email]
X-Rspamd-Queue-Id: 6D686ABDF5
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 07:10:52AM +0900, Lianjie Wang wrote:
>
> diff --git a/include/linux/hw_random.h b/include/linux/hw_random.h
> index b424555753b1..2ccfd081a94a 100644
> --- a/include/linux/hw_random.h
> +++ b/include/linux/hw_random.h
> @@ -15,6 +15,7 @@
>  #include <linux/completion.h>
>  #include <linux/kref.h>
>  #include <linux/types.h>
> +#include <linux/workqueue.h>

Please use workqueue_types.h instead.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


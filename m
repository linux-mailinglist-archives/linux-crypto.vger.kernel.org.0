Return-Path: <linux-crypto+bounces-23736-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGwcAQe5+WmNBAMAu9opvQ
	(envelope-from <linux-crypto+bounces-23736-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 05 May 2026 11:31:51 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D49C4C9C17
	for <lists+linux-crypto@lfdr.de>; Tue, 05 May 2026 11:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1303A305EA10
	for <lists+linux-crypto@lfdr.de>; Tue,  5 May 2026 09:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361BA328631;
	Tue,  5 May 2026 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="TmXo0mkQ"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EF3322533;
	Tue,  5 May 2026 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973430; cv=none; b=anqyO6uR/HBa/5sUu2AyI8+8Uu66zUNMqqj2UywTSyR9zTZcR4ZJa/ZuYlE62ant1iSmI8t5hv/extprBHSZOd5oMu2rPXaOLPsI9h0TD50uNtpMeep20QTpN+doy+zxOnL0KjukkGmI1d8g7N2tepDHn3h31h20T8fTQO6XPS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973430; c=relaxed/simple;
	bh=AtlTOkkY3ItuTBSxHl3ZRWZJeM22i9kASzn4tJVxmmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2lUWJk33uXZz6kza6SmL6RqfZm6plzbO1Ehp0ZF3FxWJZf8pQsdIGfQtVxEZ0SQDJCaVfMAX++BHAOjI+U0czMMhfhcnUbNKSdJH3OkGxAmF+X4+d3/4qHzxiMRRAAhy3K9/2Xvjeyx98tQRcu03pWKFr5cZqRVa20wY94gt0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=TmXo0mkQ; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=gbP3V8rjmIFqxtq6jUoquK7W5/tZMT01OX1jNRuEuQo=; 
	b=TmXo0mkQabiakl6G/gFSTRnLjWAYhWYREskqAbHRFGiIw8esYZt/4OynOYjRx7cAcaWN3SWcguI
	WOjC+1ZaZLstCMrhitldhQus4p6AsKUucP8pfBzASYjVbD9HN/Z8vWZxw/mDMYneGRpgRuoa5CpHV
	RwyE3wFt82dYdAU5aEp5DlnFTHvrqbRGw9QLvdZfFqVnFxWT98DYIrI2YSntiPeIobjbStW8ySWMn
	70I0Ph1YH3D+zm+FwScxJMQ8hT+V3JmEFDzs1jB4PCeKvvAkdS1NIasw0yGJi/cqdyEhPz4qtghJb
	ROApDm9fSMh8wPloAUUSYqwRa6GodhHWrvzw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wKC6i-00BO1E-34;
	Tue, 05 May 2026 17:30:26 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 05 May 2026 17:30:24 +0800
Date: Tue, 5 May 2026 17:30:24 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] mm/slab: Add kvfree_atomic() helper
Message-ID: <afm4sIE1nxUsBtK9@gondor.apana.org.au>
References: <20260428161419.94695-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428161419.94695-1-urezki@gmail.com>
X-Rspamd-Queue-Id: 7D49C4C9C17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23736-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gondor.apana.org.au:dkim,gondor.apana.org.au:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,apana.org.au:url,apana.org.au:email]

On Tue, Apr 28, 2026 at 06:14:18PM +0200, Uladzislau Rezki (Sony) wrote:
> kvmalloc() now supports non-sleeping GFP flags, including
> the vmalloc fallback path. This means it may return vmalloc
> memory even for GFP_ATOMIC and GFP_NOWAIT allocations.
> 
> Freeing such memory with kvfree() may then end up calling
> vfree(), which is not safe for non-sleeping contexts.
> 
> Introduce kvfree_atomic() helper for such cases. It mirrors
> kvfree(), but uses vfree_atomic() for vmalloced memory.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  include/linux/slab.h |  3 +++
>  mm/slub.c            | 16 ++++++++++++++++
>  2 files changed, 19 insertions(+)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


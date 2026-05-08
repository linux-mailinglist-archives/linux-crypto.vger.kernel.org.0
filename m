Return-Path: <linux-crypto+bounces-23873-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHDjB5JD/mlFogAAu9opvQ
	(envelope-from <linux-crypto+bounces-23873-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 08 May 2026 22:12:02 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF4E4FB5E7
	for <lists+linux-crypto@lfdr.de>; Fri, 08 May 2026 22:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B75E303D089
	for <lists+linux-crypto@lfdr.de>; Fri,  8 May 2026 20:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C2D3E4C61;
	Fri,  8 May 2026 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cJ3QEDVU"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C54364E81
	for <linux-crypto@vger.kernel.org>; Fri,  8 May 2026 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778271107; cv=none; b=P1MH+t4+dHKz1dyC+xgKbNUTYR7QRnKUa6Csu509UKpelzsu6NHLRkZT/9wf9p+c1vOePkzfLd8WLJ7BTXVd0cg0oUr9wedKXmM/LYkcIi59Qf1xI6t8+R/9HkpSkhX9VKTvj1nIrDw5Zsnfy5pxyXLYs/6RO9jCs8K8BvoxCFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778271107; c=relaxed/simple;
	bh=gFM+1DtlfWABxcetTW+y/wcHkrJwYbA8IwlYL1+XUC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uApgNz2u/aDIdAA55dbhExCvS/O7THL24hhF8kzFzdjRJg2VL60xAJ0N9GSGh+1V+jOfXjfBTT+dQTAfP57bD2CVZvkhVBBmF8FkbGd1VcxzaBNQch698jQj6TrNIKutf9WVGmXbPpqAtARBuRN6njvxeqZdT0VyDaDmzMrqaa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cJ3QEDVU; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 8 May 2026 22:11:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778271094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ryCh/KwkvC7J+1KyZjp5sJF3n83AW+FG1o3Sx2IpqQ=;
	b=cJ3QEDVUprgH40Jy/nzJyk1skLtPJXfkuD4T4cWVzOibpTTw4ybt7pQYsNv3cemWpV89of
	UG4G5MCFLfXeywMq23Jq/DbhBfPKqrOgsRcKecuX9aUYJyDqq4uyAfpkiMR9AjzAq5Zdrj
	CVrDjQSarBqAROO7Zeaw+9rOAEXRi3E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: use designated initializers for report structs
Message-ID: <af5DbZKdf5u0H_-1@linux.dev>
References: <20260508105717.472043-3-thorsten.blum@linux.dev>
 <20260508184013.GB4145640@google.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508184013.GB4145640@google.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 7FF4E4FB5E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23873-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 06:40:13PM +0000, Eric Biggers wrote:
> On Fri, May 08, 2026 at 12:57:17PM +0200, Thorsten Blum wrote:
> > Use designated initializers for the report structs instead of clearing
> > the struct with memset() and then copying fixed strings with strscpy()
> > at runtime.
> > 
> > This keeps the structs zero-initialized, lets the compiler diagnose
> > oversized string literals, and makes the code easier to read.
> > 
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> Did you verify that none of these structs contain any implicit padding?

Yes, I checked the structs manually and with pahole, which also reported
no holes. The structs only use char[64] followed by unsigned ints, so
implicit padding shouldn't be an issue.

Thanks,
Thorsten


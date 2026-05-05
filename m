Return-Path: <linux-crypto+bounces-23713-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Nl/L7Os+Wky+wIAu9opvQ
	(envelope-from <linux-crypto+bounces-23713-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 05 May 2026 10:39:15 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AD14C8C37
	for <lists+linux-crypto@lfdr.de>; Tue, 05 May 2026 10:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A15430733EE
	for <lists+linux-crypto@lfdr.de>; Tue,  5 May 2026 08:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6AC30BB9B;
	Tue,  5 May 2026 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="GBunEQgh"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075FB30C371
	for <linux-crypto@vger.kernel.org>; Tue,  5 May 2026 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777970172; cv=none; b=G57anc5wA03uiW+bA7n7kMXVd+ufC9j0RyGXyh7f+YGU94XVbvKhAx5ctSB/ZaSZTTZTIQUY/oDrIZ1ZfAwYyzSi+Q5MKgtrF8oHsvQiCGrg7XL8EQELyO9bwmYkZumQOXM//DctklLfByWlpfBT3TbGewBtCyNDfFCubU3vj8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777970172; c=relaxed/simple;
	bh=PBBG265yKsNJqdNW1SNv/+hHjj5GNgOrVYpC9aSUp+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGEXT/sFpXWBwFACnYDSvn8rmXO0cVpTUlLrZFaDHewwHZvYFRpazbMaxmEdyAHV9/9arss2RdSdh7lG5B86pp3Ox6xxggXVyxgqPoV7WfmkrRqJZrs44BhQx8bmZLIbJsybeQVExJvQ4I3FuA4cm0stdcfVthRrm5JJ48v7RLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=GBunEQgh; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=W62X9jBjQjMGYQKBNtLBN8Km5WqAo7vAJ8Q9K0IyBxg=; 
	b=GBunEQghuYWPm2Rac6+97PgqXlrylArAWgiAwXT8q8V96PlFchJ1tGxwX7BBwVgMnCER+j3OrDT
	mA1MRRrh6PSPYyXNBaakBhyIsaqG0FyVH4r1OafgEySt3OWY9jqAeXbIaRqQfFx193O5XO/DdWivs
	efeQPGHnreP5fh+uF0s2zO98FPMx0i9iY+/71LyKYHon36ktzFff/3Gvyjz5uyWbi8wRtEa8eE6/d
	Y1CCpd8f2dCJ3g4kYwODSQa3OpMj/RHFRWracOpY+/sa7tNUVtxvRzRDRNLrBbQSjNNwdbLd+y5OF
	1PHZipdBP48HcP5LW8jzU0WAXis0xRof+qeg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wKBGB-00BMuL-0P;
	Tue, 05 May 2026 16:36:08 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 05 May 2026 16:36:07 +0800
Date: Tue, 5 May 2026 16:36:07 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Damian Muszynski <damian.muszynski@intel.com>
Cc: linux-crypto@vger.kernel.org, qat-linux@intel.com,
	Ahsan Atta <ahsan.atta@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: Re: [PATCH] crypto: qat - fix heartbeat error injection
Message-ID: <afmr93zfny-jBciH@gondor.apana.org.au>
References: <20260407100443.8094-1-damian.muszynski@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407100443.8094-1-damian.muszynski@intel.com>
X-Rspamd-Queue-Id: 22AD14C8C37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23713-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:url,apana.org.au:email,gondor.apana.org.au:dkim,gondor.apana.org.au:mid]

On Tue, Apr 07, 2026 at 12:04:26PM +0200, Damian Muszynski wrote:
> The current implementation of the heartbeat error injection uses
> adf_disable_arb_thd() to stop a specific accelerator engine thread
> from processing requests. This does not reliably prevent the device
> from generating responses.
> 
> Fix the error injection by disabling the device arbiter through
> exit_arb() instead. This properly simulates a device failure by
> stopping all arbitration, which results in missing responses for
> sent requests.
> 
> Remove the now unused adf_disable_arb_thd() function and its
> declaration.
> 
> Fixes: e2b67859ab6e ("crypto: qat - add heartbeat error simulator")
> Signed-off-by: Damian Muszynski <damian.muszynski@intel.com>
> Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
> Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> ---
>  .../intel/qat/qat_common/adf_common_drv.h     |  1 -
>  .../qat/qat_common/adf_heartbeat_inject.c     |  6 ++---
>  .../intel/qat/qat_common/adf_hw_arbiter.c     | 25 -------------------
>  3 files changed, 2 insertions(+), 30 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


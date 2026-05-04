Return-Path: <linux-crypto+bounces-23664-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGJBLnOv+GkPzAIAu9opvQ
	(envelope-from <linux-crypto+bounces-23664-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 04 May 2026 16:38:43 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D34674BFCF8
	for <lists+linux-crypto@lfdr.de>; Mon, 04 May 2026 16:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C1BC3013AA4
	for <lists+linux-crypto@lfdr.de>; Mon,  4 May 2026 14:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBFE3DEAFF;
	Mon,  4 May 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Iogc645m"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D143DE459
	for <linux-crypto@vger.kernel.org>; Mon,  4 May 2026 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777905448; cv=none; b=LYCPw0kdIseaLfuQUDH9uGHZVpXN8zmD88EReyOuiYTpUnl0h1QJtqt/GY3sulESxT5ML6l8SFMBfwQ9nmLss0CMTxZB5hylq6zIfM4965fcD88cpSQ4xtoZ+Gggccsxvsb3Q4qvRPq9PuAgBq0o7EaczBLVBJ9bpbJ8p6D1XHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777905448; c=relaxed/simple;
	bh=zrzEItvI7wQsj7VV6oxbb2bq9vyhQ+Qb+IZ2obak6Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/Z1R+A8Vhmwb7g189OaxgWF/d9v+eJdBo/jucY9n2rFiGIgjZKn1D4BOo+jHZ4DcuSYmywzFrLunqWH3A4BE1uXxqiw+Lk895u3icxFuRnAfGdKAtwE5FH0y1MTud/i3Jn+YAzEnvNkLdxhfP18njgtXbnGRJ80hKhVReruomY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Iogc645m; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 4 May 2026 16:37:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777905441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TAGJTouWHe3Gioqsz3YMSQxBMTpanXbhgaHt14I0wls=;
	b=Iogc645mOlS0Q/AcdFW+OfjhF2ooCTHU5uuvG8G2rDU9YUsSrYpdswl2EzkIyfdoyFgg7e
	9viVS6LwX48fNQO8oklbh7G1I2AFrC/AcpyS48K7Hl5ojv6jcfzMdE3xwFWpu4wm7MVFOR
	JjrwnAvkc305nacIIkVXvVcY7y1adnw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] hwrng: core - use bool for wait parameter in
 rng_get_data
Message-ID: <afivHbWdCprHpJSB@linux.dev>
References: <20260430110047.248825-5-thorsten.blum@linux.dev>
 <20260430110047.248825-6-thorsten.blum@linux.dev>
 <afilBnLk4lapbAj4@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afilBnLk4lapbAj4@black.igk.intel.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: D34674BFCF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23664-lists,linux-crypto=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, May 04, 2026 at 03:54:14PM +0200, Andy Shevchenko wrote:
> On Thu, Apr 30, 2026 at 01:00:49PM +0200, Thorsten Blum wrote:
> > The 'wait' parameter in rng_get_data() is a boolean flag - use bool
> > instead of int to better reflect its actual type.
> 
> ...
> 
> >  static inline int rng_get_data(struct hwrng *rng, u8 *buffer, size_t size,
> > -			int wait) {
> > +			bool wait) {
> 
> You want to fix the checkpatch warnings while at it and indentation.

I just checked again, but I don't get any checkpatch warnings.

> static inline int rng_get_data(struct hwrng *rng, u8 *buffer, size_t size,
> 			       bool wait)
> {
> 
> ...
> 
> > -		rc = rng_get_data(rng, rng_fillbuf,
> > -				  rng_buffer_size(), 1);
> > +		rc = rng_get_data(rng, rng_fillbuf, rng_buffer_size(), true);
> 
> Is it the only user? Why parameter is needed at all?

The other one in rng_dev_read() already uses a boolean expression, hence
no changes.

Thanks,
Thorsten


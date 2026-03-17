Return-Path: <linux-crypto+bounces-22022-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIk2Mh45uWlYvwEAu9opvQ
	(envelope-from <linux-crypto+bounces-22022-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 12:21:02 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F21A2A8A42
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 12:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2E873041D6F
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 11:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6D43750DD;
	Tue, 17 Mar 2026 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="au04Iwaq"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8AA37648B
	for <linux-crypto@vger.kernel.org>; Tue, 17 Mar 2026 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746452; cv=none; b=DwxQqc7Lw9U4W234alQa98E3ZY3VupJxqD2pGx4VSgCleuU/4nUQSyTHXIQ5LBv4XVa3tLZorTGTUTTSfeMFH58QaDkOxHsk16gO04RgqdBcaiTUSqtLjdcwDsNmC7BHfjRBWQEIB1ETZAv8++vbh57W0p76u60NvWvQc708ujI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746452; c=relaxed/simple;
	bh=pOAJ7gTT2gW3rIbyM1AFAzko/De87b7KJmIKhZOX4RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HW2fQKCCLKdJlxh8dR1WxCbKpOlwMAHE+ySZKJu4qodvpXxHd0RCc/xJBZswn4lxGIVKPz2uWWORceTSSUc05oG1OGZjhyrw1NBt1GIl9u7nnx6LkJGTm8LWaLg3TFpWjBIPCIcDv4dqz5PJZqTyHLNJN6kFGryPeWVo9H2FDW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=au04Iwaq; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 17 Mar 2026 12:20:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773746438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fJ19JX+Fdfvgr+LNxpY/TOqvYP2YRwuZtSMmPJ3oyp4=;
	b=au04IwaquZL/9L402rl9GkDbdHPdZDGzWMebJ8y0SVeq0gIrOG8fHY5jnHIxEQdMGRFUAF
	Y2G10qY+H+5rOpeTEUsauUiBKBmfmyLqtIXq+EZ+34p0RmM33EGevjqIHUE/R6W8RzV+OQ
	XOYEeugQEjPKVe+Vg4leqmT42xtW7qA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Gaurav Jain <gaurav.jain@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Kim Phillips <kim.phillips@freescale.com>,
	Yuan Kang <Yuan.Kang@freescale.com>, stable@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: caam - remove HMAC key hex dumps from
 hash_digest_key
Message-ID: <abk4_r-KUYIhvyNL@linux.dev>
References: <20260306111204.302544-1-thorsten.blum@linux.dev>
 <abTqefme_iApfHZi@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abTqefme_iApfHZi@gondor.apana.org.au>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22022-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 4F21A2A8A42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 01:56:25PM +0900, Herbert Xu wrote:
> On Fri, Mar 06, 2026 at 12:12:03PM +0100, Thorsten Blum wrote:
> > Stop dumping sensitive HMAC key bytes (original and reduced keys) in
> > hash_digest_key() to avoid leaking secrets when debug logging is
> > enabled.
> > 
> > Fixes: 045e36780f11 ("crypto: caam - ahash hmac support")
> > Fixes: 3f16f6c9d632 ("crypto: caam/qi2 - add support for ahash algorithms")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >  drivers/crypto/caam/caamalg_qi2.c | 5 -----
> >  drivers/crypto/caam/caamhash.c    | 6 ------
> >  2 files changed, 11 deletions(-)
> 
> What is the rationale for this? When debugging is enabled, all
> sorts of things could be dumped, e.g., passwords.

This is not specifically about caam, but (debug) logging of potentially
sensitive key material should generally be avoided, imho. Some other
recent examples:

https://lore.kernel.org/lkml/20260227230008.858641-2-thorsten.blum@linux.dev/
https://lore.kernel.org/lkml/20260303132552.65235-2-thorsten.blum@linux.dev/
https://lore.kernel.org/lkml/20260303190350.78705-2-thorsten.blum@linux.dev/

> Is there a scenario where production systems will run with debugging
> enabled in caam?

I don't know - possibly.

Thanks,
Thorsten


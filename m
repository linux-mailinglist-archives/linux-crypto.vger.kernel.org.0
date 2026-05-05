Return-Path: <linux-crypto+bounces-23711-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QO9gBiWs+Wmh+wIAu9opvQ
	(envelope-from <linux-crypto+bounces-23711-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 05 May 2026 10:36:53 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8884C8BE1
	for <lists+linux-crypto@lfdr.de>; Tue, 05 May 2026 10:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F52C3020A47
	for <lists+linux-crypto@lfdr.de>; Tue,  5 May 2026 08:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1922F12B3;
	Tue,  5 May 2026 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="gcCQHTB6"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EA42F90C5;
	Tue,  5 May 2026 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777970146; cv=none; b=QScs9PGO5s74PKRtcvtrvjyej6X3L61w9jeXarBNx6VpovgdY5YXUDYrsG47JidtNMGxhEP9+Dho3+xqrte5veQwD3uJ7WgUOLCraNZbzw2+C9r2NpodnJLJ9V9JnpdjcQIiMe2o/qimcOLUdJABapWgQMYRlfuPAM63/y5Zx1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777970146; c=relaxed/simple;
	bh=OI6Os/hCWOzK4EJegmwG52iQlumbuvQwvDjsybmjJXk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ljmIEprtzdyT5u0WdWdYMUY6oftxQg7exwfhcgkw+Q4ddsQ/S2fxopDwdxTx02in23ELXWhXnsTd27zLsQ/gr1b3o1YIabuJIdmdwH2PsX4IH3z1sO4c3yGhBc969DYu0NLQZCiIKQHFOnt30CQQOo88YgxAxu1rmv8EfiTNkOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=gcCQHTB6; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=zWb0QKY737Yu+yXE3SSX+Q+dhwYDl2cEOXHWGxU+3Fc=; b=gcCQHTB6t4LucPc9NeUiL8+JrE
	iv6yN6YpptbhkM3nD0xlVp1zYvbf3chnPM85MfJutv+2WWI36PW6anCaWjDTYMf9jgboe1fh38cJ8
	eKNYhD6YyPzWBjWHH8c2DiVw2ZvLUe97ezW2psvSoyni37aE3pLkYbFnqc0zv8O9zau4LAefV3uv/
	veQa4HsWsibNocaZxbbFmGMiBvLFxnXiWSBgCd7DHjp9O/VFXg14A7OumedVurawZuy83vVo5N7Dg
	BEv0MagiVVB2cJPXFfX0A0vi8yIxHmVCFlcJtASkmBtb/IzQLCDMiHU2H7IrvHjoizB5CRJ8xoFVT
	bPjbz4MQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wKBFW-00BMsu-2J;
	Tue, 05 May 2026 16:35:27 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 05 May 2026 16:35:26 +0800
Date: Tue, 5 May 2026 16:35:26 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Julian Braha <julianbraha@gmail.com>
Cc: dhowells@redhat.com, rusty@rustcorp.com.au, lukas@wunner.de,
	ignat@linux.win, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	julianbraha@gmail.com
Subject: Re: [PATCH] keys: cleanup dead code in Kconfig for
 FIPS_SIGNATURE_SELFTEST
Message-ID: <afmrzqj5mM-TUUYK@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331122214.103145-1-julianbraha@gmail.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
X-Rspamd-Queue-Id: 6B8884C8BE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,rustcorp.com.au,wunner.de,linux.win,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-23711-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:url,apana.org.au:email,gondor.apana.org.au:dkim,gondor.apana.org.au:mid]

Julian Braha <julianbraha@gmail.com> wrote:
> There is already an 'if ASYMMETRIC_KEY_TYPE' condition wrapping
> FIPS_SIGNATURE_SELFTEST, making the 'depends on' statement a
> duplicate dependency (dead code).
> 
> I propose leaving the outer 'if ASYMMETRIC_KEY_TYPE...endif' and removing
> the individual 'depends on' statement.
> 
> This dead code was found by kconfirm, a static analysis tool for Kconfig.
> 
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
> crypto/asymmetric_keys/Kconfig | 1 -
> 1 file changed, 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

